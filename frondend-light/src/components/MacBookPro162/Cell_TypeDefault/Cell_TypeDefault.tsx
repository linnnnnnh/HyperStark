import { memo } from 'react';
import type { FC, ReactNode } from 'react';

import resets from '../../_resets.module.css';
import classes from './Cell_TypeDefault.module.css';

interface Props {
  className?: string;
  classes?: {
    content?: string;
    root?: string;
  };
  text?: {
    text?: ReactNode;
  };
}
/* @figmaId 112:342 */
export const Cell_TypeDefault: FC<Props> = memo(function Cell_TypeDefault(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${props.classes?.root || ''} ${props.className || ''} ${classes.root}`}>
      <div className={`${props.classes?.content || ''} ${classes.content}`}></div>
    </div>
  );
});
