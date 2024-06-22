import { memo } from 'react';
import type { FC, ReactNode } from 'react';

import resets from '../../_resets.module.css';
import classes from './Cell_TypeHeader.module.css';

interface Props {
  className?: string;
  classes?: {
    root?: string;
  };
  text?: {
    text?: ReactNode;
  };
}
/* @figmaId 112:345 */
export const Cell_TypeHeader: FC<Props> = memo(function Cell_TypeHeader(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${props.classes?.root || ''} ${props.className || ''} ${classes.root}`}>
      <div className={classes.content}></div>
    </div>
  );
});
