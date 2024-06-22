import { memo, SVGProps } from 'react';

const BxlTwitterIcon = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 40 40' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <path
      d='M32.7217 13.3282C32.7434 13.6199 32.7434 13.9099 32.7434 14.1999C32.7434 23.0749 25.9884 33.3016 13.6434 33.3016C9.84004 33.3016 6.30671 32.1999 3.33337 30.2866C3.87337 30.3482 4.39337 30.3699 4.95504 30.3699C7.97669 30.3772 10.9128 29.3668 13.29 27.5016C11.8891 27.4762 10.531 27.014 9.40544 26.1795C8.27987 25.3449 7.44301 24.1797 7.01171 22.8466C7.42671 22.9082 7.84337 22.9499 8.28004 22.9499C8.88171 22.9499 9.48671 22.8666 10.0484 22.7216C8.52797 22.4146 7.16083 21.5905 6.17941 20.3894C5.19798 19.1883 4.66286 17.6843 4.66504 16.1332V16.0499C5.56004 16.5482 6.59837 16.8599 7.69837 16.9016C6.77686 16.2892 6.02124 15.4583 5.49894 14.4829C4.97664 13.5075 4.7039 12.418 4.70504 11.3116C4.70504 10.0649 5.03671 8.92158 5.61837 7.92491C7.30527 9.99994 9.40921 11.6975 11.7939 12.9077C14.1787 14.1178 16.791 14.8136 19.4617 14.9499C19.3584 14.4499 19.295 13.9316 19.295 13.4116C19.2946 12.5298 19.4679 11.6567 19.8052 10.842C20.1424 10.0273 20.6369 9.28703 21.2604 8.66356C21.8838 8.04008 22.6241 7.54559 23.4388 7.20837C24.2535 6.87115 25.1266 6.6978 26.0084 6.69824C27.9417 6.69824 29.6867 7.50824 30.9134 8.81824C32.4163 8.5276 33.8576 7.97895 35.1734 7.19658C34.6724 8.74794 33.623 10.0634 32.2217 10.8966C33.5547 10.7445 34.8574 10.394 36.0867 9.85658C35.1686 11.1951 34.0309 12.3688 32.7217 13.3282V13.3282Z'
      fill='url(#paint0_linear_180_119)'
    />
    <defs>
      <linearGradient
        id='paint0_linear_180_119'
        x1={3.33337}
        y1={19.9999}
        x2={36.0867}
        y2={19.9999}
        gradientUnits='userSpaceOnUse'
      >
        <stop stopColor='#F2A55F' />
        <stop offset={1} stopColor='#914F13' />
      </linearGradient>
    </defs>
  </svg>
);

const Memo = memo(BxlTwitterIcon);
export { Memo as BxlTwitterIcon };
