Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB95C7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 13:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91CE10E077;
	Wed, 10 May 2023 13:20:33 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8119610E077
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 13:20:31 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202305101520289476; Wed, 10 May 2023 15:20:28 +0200
Message-ID: <714c875f-21f1-7e29-fb39-4a1f97eb712f@daenzer.net>
Date: Wed, 10 May 2023 15:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-CA
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Chalmers, Wesley" <Wesley.Chalmers@amd.com>
References: <20230414155330.5215-11-Qingqing.Zhuo@amd.com>
 <9deeb132-a317-7419-e9da-cbc0a379c0eb@daenzer.net>
 <CH0PR12MB5284513F3548D749845BD7B48B769@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CH0PR12MB5284BDF5F23009597E1503E38B769@CH0PR12MB5284.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
In-Reply-To: <CH0PR12MB5284BDF5F23009597E1503E38B769@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CTCH: RefID="str=0001.0A782F1C.645B9A1C.0017,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/9/23 23:07, Pillai, Aurabindo wrote:
>=20
> Sorry - the firmware in the previous message is for DCN32. For Navi2x, =
please use the firmware attached here.

Same problem (contents of /sys/kernel/debug/dri/0/amdgpu_firmware_info be=
low).

Even if it did work with newer FW, the kernel must keep working with olde=
r FW, so in that case the new behaviour would need to be guarded by the F=
W version.


VCE feature version: 0, firmware version: 0x00000000
UVD feature version: 0, firmware version: 0x00000000
MC feature version: 0, firmware version: 0x00000000
ME feature version: 44, firmware version: 0x00000040
PFP feature version: 44, firmware version: 0x00000061
CE feature version: 44, firmware version: 0x00000025
RLC feature version: 1, firmware version: 0x00000060
RLC SRLC feature version: 0, firmware version: 0x00000000
RLC SRLG feature version: 0, firmware version: 0x00000000
RLC SRLS feature version: 0, firmware version: 0x00000000
RLCP feature version: 0, firmware version: 0x00000000
RLCV feature version: 0, firmware version: 0x00000000
MEC feature version: 44, firmware version: 0x00000071
MEC2 feature version: 44, firmware version: 0x00000071
IMU feature version: 0, firmware version: 0x00000000
SOS feature version: 0, firmware version: 0x00210c64
ASD feature version: 553648297, firmware version: 0x210000a9
TA XGMI feature version: 0x00000000, firmware version: 0x2000000f
TA RAS feature version: 0x00000000, firmware version: 0x1b00013e
TA HDCP feature version: 0x00000000, firmware version: 0x17000038
TA DTM feature version: 0x00000000, firmware version: 0x12000015
TA RAP feature version: 0x00000000, firmware version: 0x07000213
TA SECUREDISPLAY feature version: 0x00000000, firmware version: 0x0000000=
0
SMC feature version: 0, program: 0, firmware version: 0x003a5800 (58.88.0=
)
SDMA0 feature version: 52, firmware version: 0x00000053
SDMA1 feature version: 52, firmware version: 0x00000053
SDMA2 feature version: 52, firmware version: 0x00000053
SDMA3 feature version: 52, firmware version: 0x00000053
VCN feature version: 0, firmware version: 0x0211b000
DMCU feature version: 0, firmware version: 0x00000000
DMCUB feature version: 0, firmware version: 0x0202001c
TOC feature version: 0, firmware version: 0x00000000
MES_KIQ feature version: 0, firmware version: 0x00000000
MES feature version: 0, firmware version: 0x00000000
VBIOS version: 113-D4300100-051


-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-----------------------------------------
> *From:* Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
> *Sent:* Tuesday, May 9, 2023 4:44 PM
> *To:* Michel D=C3=A4nzer <michel@daenzer.net>; Zhuo, Qingqing (Lillian)=
 <Qingqing.Zhuo@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.fr=
eedesktop.org>; Chalmers, Wesley <Wesley.Chalmers@amd.com>
> *Cc:* Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo)=
 <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira=
, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu,=
 Solomon <Solomon.Chiu@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, B=
hawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutie=
rrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
> *Subject:* Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe co=
mmit
> =C2=A0
> Hi Michel,
>=20
> Could you please try with the attached firmware package if you see the =
hang without any reverts?=C2=A0 If you do see hangs, please send dmesg wi=
th "drm.debug=3D0x156 log_buf_len=3D30M" in the kernel cmdline.
>=20
> The attached fw is not released to the public yet, but we will be updat=
ing them in linux-firmware tree next week. Please do backup your existing=
 firmware, and put the attached files into /usr/lib/firmware/updates/amgp=
u and regenerate your ramdisk. On ubuntu the following should do:
>=20
> sudo update-initramfs -u -k `uname -r`
>=20
> --
>=20
> Regards,
> Jay
> -----------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------
> *From:* Michel D=C3=A4nzer <michel@daenzer.net>
> *Sent:* Tuesday, May 9, 2023 6:59 AM
> *To:* Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; amd-gfx@lists.f=
reedesktop.org <amd-gfx@lists.freedesktop.org>; Chalmers, Wesley <Wesley.=
Chalmers@amd.com>
> *Cc:* Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo)=
 <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira=
, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu,=
 Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.=
com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lak=
ha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pav=
le <Pavle.Kotarac@amd.com>
> *Subject:* Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe co=
mmit
> =C2=A0
> On 4/14/23 17:52, Qingqing Zhuo wrote:
>> From: Wesley Chalmers <Wesley.Chalmers@amd.com>
>>=20
>> [WHY]
>> Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as =
a
>> pipe commit can cause underflow.
>>=20
>> [HOW]
>> Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
>> optimized_required.
>>=20
>> This change expects that Freesync requests are blocked when
>> optimized_required is true.
>>=20
>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
> I bisected a regression to this change, see below for the symptoms. Rev=
erting this patch (and the following patch "drm/amd/display: Block optimi=
ze on consecutive FAMS enables", which depends on it) on top of the DRM c=
hanges merged for 6.4-rc1 avoids the regression.
>=20
> Maybe "Freesync requests are blocked when optimized_required is true" i=
sn't ensured as needed?
>=20
>=20
> The symptoms are that the monitor (Samsung Odyssey Neo G9, 5120x1440@24=
0/VRR, connected to Navi 21 via DisplayPort) blanks and the GPU hangs whi=
le starting the Steam game Assetto Corsa Competizione (via Proton 7.0).
>=20
> Example dmesg excerpt:
>=20
> =C2=A0amdgpu 0000:0c:00.0: [drm] *ERROR* [CRTC:82:crtc-0] flip_done tim=
ed out
> =C2=A0NMI watchdog: Watchdog detected hard LOCKUP on cpu 6
> =C2=A0[...]
> =C2=A0RIP: 0010:amdgpu_device_rreg.part.0+0x2f/0xf0 [amdgpu]
> =C2=A0Code: 41 54 44 8d 24 b5 00 00 00 00 55 89 f5 53 48 89 fb 4c 3b a7=
 60 0b 00 00 73 6a 83 e2 02 74 29 4c 03 a3 68 0b 00 00 45 8b 24 24 <48> 8=
b 43 08 0f b7 70 3e 66 90 44 89 e0 5b 5d 41 5c 31 d2 31 c9 31
> =C2=A0RSP: 0000:ffffb39a119dfb88 EFLAGS: 00000086
> =C2=A0RAX: ffffffffc0eb96a0 RBX: ffff9e7963dc0000 RCX: 0000000000007fff=

> =C2=A0RDX: 0000000000000000 RSI: 0000000000004ff6 RDI: ffff9e7963dc0000=

> =C2=A0RBP: 0000000000004ff6 R08: ffffb39a119dfc40 R09: 0000000000000010=

> =C2=A0R10: ffffb39a119dfc40 R11: ffffb39a119dfc44 R12: 00000000000e05ae=

> =C2=A0R13: 0000000000000000 R14: ffff9e7963dc0010 R15: 0000000000000000=

> =C2=A0FS:=C2=A0 000000001012f6c0(0000) GS:ffff9e805eb80000(0000) knlGS:=
000000007fd40000
> =C2=A0CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> =C2=A0CR2: 00000000461ca000 CR3: 00000002a8a20000 CR4: 0000000000350ee0=

> =C2=A0Call Trace:
> =C2=A0 <TASK>
> =C2=A0 dm_read_reg_func+0x37/0xc0 [amdgpu]
> =C2=A0 generic_reg_get2+0x22/0x60 [amdgpu]
> =C2=A0 optc1_get_crtc_scanoutpos+0x6a/0xc0 [amdgpu]
> =C2=A0 dc_stream_get_scanoutpos+0x74/0x90 [amdgpu]
> =C2=A0 dm_crtc_get_scanoutpos+0x82/0xf0 [amdgpu]
> =C2=A0 amdgpu_display_get_crtc_scanoutpos+0x91/0x190 [amdgpu]
> =C2=A0 ? dm_read_reg_func+0x37/0xc0 [amdgpu]
> =C2=A0 amdgpu_get_vblank_counter_kms+0xb4/0x1a0 [amdgpu]
> =C2=A0 dm_pflip_high_irq+0x213/0x2f0 [amdgpu]
> =C2=A0 amdgpu_dm_irq_handler+0x8a/0x200 [amdgpu]
> =C2=A0 amdgpu_irq_dispatch+0xd4/0x220 [amdgpu]
> =C2=A0 amdgpu_ih_process+0x7f/0x110 [amdgpu]
> =C2=A0 amdgpu_irq_handler+0x1f/0x70 [amdgpu]
> =C2=A0 __handle_irq_event_percpu+0x46/0x1b0
> =C2=A0 handle_irq_event+0x34/0x80
> =C2=A0 handle_edge_irq+0x9f/0x240
> =C2=A0 __common_interrupt+0x66/0x110
> =C2=A0 common_interrupt+0x5c/0xd0
> =C2=A0 asm_common_interrupt+0x22/0x40
>=20
>=20
> --=20
> Earthling Michel D=C3=A4nzer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://redhat.com <h=
ttps://redhat.com>
> Libre software enthusiast=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mesa and Xwaylan=
d developer
>=20

--=20
Earthling Michel D=C3=A4nzer            |                  https://redhat=
=2Ecom
Libre software enthusiast          |         Mesa and Xwayland developer

