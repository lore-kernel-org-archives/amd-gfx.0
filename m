From: Mathieu Malaterre <malat@debian.org>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_Tracking=3A_radeon_0000=3A00=3A10=2E0=3A_ring_0_st?=
        =?UTF-8?Q?alled_for_more_than_10240msec?=
Date: Wed, 2 May 2018 08:00:33 +0200
Message-ID: <CA+7wUswikSEhxoovvsVR7P4m5ju6Jy1G2ZNCV1CsT=acXhDUGw@mail.gmail.com>
References: <CA+7wUszgY3uFVfMe4T-_5x9KuzWNSgKHXcRKgfcmpE+Keo73Vg@mail.gmail.com>
 <fefee930-1eca-4819-4e02-7ba4a7487dee@amd.com> <DM3PR12MB0873246BA4A3462050AC10E299800@DM3PR12MB0873.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DM3PR12MB0873246BA4A3462050AC10E299800@DM3PR12MB0873.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Qu, Jim" <Jim.Qu@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, David Airlie <airlied@linux.ie>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Hi all,

On Wed, May 2, 2018 at 4:39 AM, Qu, Jim <Jim.Qu@amd.com> wrote:
> Hi ,
>
> If you are sure that the HW worked fine before. I think you should:
>
> 1. Be sure that HW works fine now.
> 2. recall the driver to the point at where it works well, and then replac=
e them one by one to confirm component which causes the issue.
> 3. try to update the last VBIOS to adapt new driver.
>
> Thanks
> JimQu
>
> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: amd-gfx <amd-gfx-bounces@lists.freedesktop.o=
rg> =E4=BB=A3=E8=A1=A8 Christian K=C3=B6nig <christian.koenig@amd.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018=E5=B9=B44=E6=9C=8830=E6=97=A5 =
1:16:14
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Mathieu Malaterre; Deucher, Alexander
> =E6=8A=84=E9=80=81: David Airlie; Zhou, David(ChunMing); dri-devel; amd-g=
fx@lists.freedesktop.org; LKML
> =E4=B8=BB=E9=A2=98: Re: Tracking: radeon 0000:00:10.0: ring 0 stalled for=
 more than 10240msec
>
> Am 23.04.2018 um 20:50 schrieb Mathieu Malaterre:
>> Hi there,
>>
>> I am pretty sure I was able to run kodi on an old Mac Mini G4 (big
>> endian) with AMD RV280. Today it is failing to start with:
>
> Well, that is rather old hardware. I suggest to make sure first that the
> hw isn't broken in some way.
>
>> How should I go and debug this (other than plain git-bisect) ?
>
> You first need to figure out what's the failing component. Either Mesa,
> DDX or the Kernel are possible candidates.
>
> Another possibility is that you updated kodi and kodi is now doing
> something the hw doesn't like.

That was my mistake, I forgot about AGP vs PCI on radeon. Should be
fixed in next release:

https://patchwork.kernel.org/patch/10360887/

> Regards,
> Christian.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
