import { memo, SVGProps } from 'react';

const VectorIcon2 = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 48 49' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <path
      d='M19.5556 0C10.6667 0 0 9.07407 0 23.5926C0 38.1111 10.6667 49 24.8889 49C39.1111 49 48 38.1111 48 29.037C28.4444 41.7407 7.11111 19.963 19.5556 0Z'
      stroke='#914F13'
      strokeWidth={2}
      strokeLinecap='round'
      strokeLinejoin='round'
    />
  </svg>
);

const Memo = memo(VectorIcon2);
export { Memo as VectorIcon2 };
