import { memo, SVGProps } from 'react';

const ButtonAccuRewIcon = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 492 147' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <path
      d='M0 10C0 4.47715 4.47715 0 10 0H482C487.523 0 492 4.47715 492 10V137C492 142.523 487.523 147 482 147H9.99999C4.47714 147 0 142.523 0 137V10Z'
      fill='#613A17'
    />
  </svg>
);

const Memo = memo(ButtonAccuRewIcon);
export { Memo as ButtonAccuRewIcon };
