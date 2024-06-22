import { memo } from 'react';
import type { FC, ReactNode } from 'react';

import resets from '../../_resets.module.css';
import { Cell_TypeHeader } from '../Cell_TypeHeader/Cell_TypeHeader.js';
import classes from './Row.module.css';

interface Props {
  className?: string;
  classes?: {
    cell?: string;
    cell2?: string;
    cell3?: string;
    cell4?: string;
    root?: string;
  };
  swap?: {
    cell?: ReactNode;
    cell2?: ReactNode;
    cell3?: ReactNode;
    cell4?: ReactNode;
  };
  text?: {
    text?: ReactNode;
    text2?: ReactNode;
    text3?: ReactNode;
    text4?: ReactNode;
  };
}
/* @figmaId 112:500 */
export const Row: FC<Props> = memo(function Row(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${props.classes?.root || ''} ${props.className || ''} ${classes.root}`}>
      {props.swap?.cell || (
        <Cell_TypeHeader
          className={`${props.classes?.cell || ''} ${classes.cell}`}
          text={{
            text: props.text?.text,
          }}
        />
      )}
      {props.swap?.cell2 || (
        <Cell_TypeHeader
          className={`${props.classes?.cell2 || ''} ${classes.cell2}`}
          text={{
            text: props.text?.text2,
          }}
        />
      )}
      {props.swap?.cell3 || (
        <Cell_TypeHeader
          className={`${props.classes?.cell3 || ''} ${classes.cell3}`}
          text={{
            text: props.text?.text3,
          }}
        />
      )}
      {props.swap?.cell4 || (
        <Cell_TypeHeader
          className={`${props.classes?.cell4 || ''} ${classes.cell4}`}
          text={{
            text: props.text?.text4,
          }}
        />
      )}
    </div>
  );
});
