From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [Regression] "drm/amdgpu: enable gfxoff again on raven series
 (v2)"
Date: Thu, 8 Aug 2019 01:44:32 +0800
Message-ID: <624BFB8F-B586-492E-BEA6-4B138DAEC831@canonical.com>
References: <3EB0E920-31D7-4C91-A360-DBFB4417AC2F@canonical.com>
 <MN2PR12MB330979BAFF5BCC758258D54CECD40@MN2PR12MB3309.namprd12.prod.outlook.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MN2PR12MB330979BAFF5BCC758258D54CECD40@MN2PR12MB3309.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Huang, Ray" <Ray.Huang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Anthony Wong <anthony.wong@canonical.com>
List-Id: amd-gfx.lists.freedesktop.org

Hi Ray,

at 00:03, Huang, Ray <Ray.Huang@amd.com> wrote:

> May I know the all firmware version in your system?

# cat amdgpu_firmware_info
VCE feature version: 0, firmware version: 0x00000000
UVD feature version: 0, firmware version: 0x00000000
MC feature version: 0, firmware version: 0x00000000
ME feature version: 40, firmware version: 0x00000099
PFP feature version: 40, firmware version: 0x000000ae
CE feature version: 40, firmware version: 0x0000004d
RLC feature version: 1, firmware version: 0x00000213
RLC SRLC feature version: 1, firmware version: 0x00000001
RLC SRLG feature version: 1, firmware version: 0x00000001
RLC SRLS feature version: 1, firmware version: 0x00000001
MEC feature version: 40, firmware version: 0x0000018b
MEC2 feature version: 40, firmware version: 0x0000018b
SOS feature version: 0, firmware version: 0x00000000
ASD feature version: 0, firmware version: 0x001ad4d4
TA XGMI feature version: 0, firmware version: 0x00000000
TA RAS feature version: 0, firmware version: 0x00000000
SMC feature version: 0, firmware version: 0x00001e44
SDMA0 feature version: 41, firmware version: 0x000000a9
VCN feature version: 0, firmware version: 0x0110901c
DMCU feature version: 0, firmware version: 0x00000000
VBIOS version: 113-RAVEN-103

Kai-Heng

>
> Thanks,
> Ray
>
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Wednesday, August 7, 2019 8:50 PM
> To: Huang, Ray
> Cc: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); amd-gfx  
> list; dri-devel@lists.freedesktop.org; LKML; Anthony Wong
> Subject: [Regression] "drm/amdgpu: enable gfxoff again on raven series  
> (v2)"
>
> Hi,
>
> After commit 005440066f92 ("drm/amdgpu: enable gfxoff again on raven series
> (v2)”), browsers on Raven Ridge systems cause serious corruption like this:
> https://launchpadlibrarian.net/436319772/Screenshot%20from%202019-08-07%2004-20-34.png
>
> Firmwares for Raven Ridge is up-to-date.
>
> Kai-Heng
