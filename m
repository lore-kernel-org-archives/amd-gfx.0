Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAB0C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE5410E3DB;
	Thu,  9 Dec 2021 16:52:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE1910ED93
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev/5bNLcKaxLTrOIBMdpK5PZnXJyt22EbzBY2l0UyqeJgy7IdWLM7x8cfpMoy7lgeSzUoKag751THvKGAPJmuJXOGl8avTgVyHWXj/tVY6KuZvQXLH2j34CV5ROrjF+XLdlI2JAUK+DqD8Mn7oYnYbBqMWfko6dt5xKNF8pjijjEIjlGDt6RzEuCcZC55Ejv/vYcSlUoh+NHvyuDvRuObaEt1MjKUYy/lY966Pk18QSZcWGj9NP2LXcBKjSJdFScoaQlpbSDJnL1vOeTYxyO9o9Ylzgp+x7+iABc9TaYtmwnO8lHnSK2q7LV0ILmrSo9ubjneEAw7CULjgXmTd77Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBlKcCASO8gC/BFcsm5s8XXtZiWR6EzfMU/bulfR5Zc=;
 b=GhjtUf6+Z0OIP5vdPpU9s9Ck5U1unAqgzCrMjBjmlD1GMi77m0dkVlK3LA0cYqzdI0eapPOQYvuvw6T3kCswtb3k+D04TK21GDm9fnKHX27zQ2PUB2NWt94AhKa9VPcsxccOl/Tm7Sh0mCqbtnSuEYuGOYym75GXyu/gH5UY/HTgSdnt/QYVNUtItcvquEMVCUYIOL+Q/BBZFHxR5SSgJ+61Z5M3F8WZdhLpmX0toUejPnT/5GhMIfac2IDFhHPTOGHoDBbuThBMULxvSDehMr9D3UHIO+qOBhkUK3kQpQzW+QERsSew0p0JJhZdTaoXMxlhVaB6Mb/f9giXSyjvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBlKcCASO8gC/BFcsm5s8XXtZiWR6EzfMU/bulfR5Zc=;
 b=Cg9gGmLFDX64x1umGU90UgrZ4x8kZOp3XlFk1iMYDJAJpuKaEoF00ONFcOw/yQ4v2teJMJjEaJVWLISi+NmBeSBIgXd1NaAz/5cehxSeA/WnGWPuSXN9i0OIJIahvlE0Dp+NVVS1TPR76Y8UYrDqyuYi+stQKD2VOvGEZbsYUHw=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Thu, 9 Dec
 2021 05:18:04 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::74a1:b6e:8b95:d7e6]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::74a1:b6e:8b95:d7e6%8]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 05:18:03 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that
 accepts buffer base and write offset
Thread-Topic: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that
 accepts buffer base and write offset
Thread-Index: AQHX6/4D9lD6iLZw5kmZ1VPQscdx+6wpZbuAgAA5454=
Date: Thu, 9 Dec 2021 05:18:03 +0000
Message-ID: <CH0PR12MB5387719AD57026EE6470F05AF0709@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20211208063609.5593-1-darren.powell@amd.com>
 <20211208063609.5593-2-darren.powell@amd.com>
 <DM6PR12MB26198BCA8EBB91200235DC52E4709@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26198BCA8EBB91200235DC52E4709@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-09T05:18:03.090Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 856c205f-5e52-dac9-a158-1c66e97b81e1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25135f00-b42a-4f0b-37c3-08d9bad346cf
x-ms-traffictypediagnostic: CH0PR12MB5369:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5369C0E7B3CD02B31F9791D5F0709@CH0PR12MB5369.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFrargIPElwbaov4Ol/wl76aKj4AXK1QL1XXkJIJbVq+XXq/tkOKMQLHUZZl+L/MxwJJQgoYiAkmSgwAQGWqm2+Y7oiYqH5An92aDLO+QXgn3n0gMFe9FEo9BtkjAq+w9qF83kJvw7yFUfOOaVBUXhcMkS3he7gQHHv4UTdBFzuzI2dudkxN0vxUGmewYDzGWtCU6aJoPIkzuzU1qETTL1YUbXGqO9lI3I5z7TcgZtb85bxg7wtopdxeRTXm0Mkg7bpV5S9vpB3l2qVGMCTtVeLlTwbIM7vtTHDfOvWKJFL21xxFR2F3X5Je+P/89LrOmKi/5Qyb21UlDXQkjHHlFSreeU11IL+OEu9fWLL3z1Xwt9TzqFGsckuke+/w1GJp3x5kxfCk+7rPxu5a8pHBOWD85EXb6BmSwQ6eQLLylitcuRJ25GoXjK9QRHnB0HA4MJ24yjtqH8XLxjHqfzJe/9Jur2G9t9hh1h3rDvwMqQgGREWTSUlXhVlip/rvFgOrVGrYsWCPCX5GlxqRPwEN/mgOkYuIB2TTRePTkPC1NOBBuvR+160O9ylXR6dysM1h26csAJUlpldRpJt4o7fexTQHFFaOpvOEldUwo6euAzvmQJNH0XhG24V77TRpHTIY5pb88bv3uRYCS7w9Eg2bYCPctU53xuRdEFCOj6FkoPTqkH+HgH7zy6CKsKftbZVpAwnnFTNoTRd1fxPTeYfW3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(30864003)(53546011)(6506007)(110136005)(8676002)(55016003)(86362001)(66446008)(64756008)(66556008)(9686003)(26005)(966005)(186003)(166002)(508600001)(71200400001)(66946007)(83380400001)(2906002)(7696005)(316002)(91956017)(76116006)(19627405001)(38070700005)(122000001)(52536014)(33656002)(21615005)(8936002)(38100700002)(66476007)(5660300002)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+i1K0vyfjiKdcGOqiqL+3ipdQMTcBasKei7Hg/YfFwYIevykDIIfeFV22M?=
 =?iso-8859-1?Q?ebBqCOEwpRar9trwuOv3d98gN8g7EGJAW7wCLoCHMG8K5V+MFGFB5Y3D3Z?=
 =?iso-8859-1?Q?rrTiJJnagPwd5KTA2/eWDgxECvOFzlcbN0g9Dm5o7FSL9lWr3zFUmKkkQ+?=
 =?iso-8859-1?Q?DtU6OZXLf2BDQov8FxlpADQF4EbPt9a/h9WU2NSznaTdGgrdIqSLxVa2xB?=
 =?iso-8859-1?Q?IAXeArP1NJO2GTX6wwT0GvgKHGVqjexHg8k9IkTNXthGnrS0j3yPPnuGWJ?=
 =?iso-8859-1?Q?Z793RbJTLxV73tgghAlOE1MkV2DKLxt51VZfulJSqwa3OBduLwhEcD+cGi?=
 =?iso-8859-1?Q?2yPF+Qvso480BepChzryA3C3ObfbkxmYJqp9Xo4R2Hf1LQXMuFqHi4aplb?=
 =?iso-8859-1?Q?jH/envM6Unp4P9NeVCNTyS32SQYXERYWVyHBVDkETJSwjmPSNVkfG0Zj9i?=
 =?iso-8859-1?Q?xTH+L6b38R7rjG6oZO58oj/Kkg1PYq66fDQPtzxuGRtBLoIYLaQ/JWdKrh?=
 =?iso-8859-1?Q?+4XrgXhnnAUzjc8ep5VRBfS10qKJ8vZsuFzFkcj1VKnjwjkSBF/vL8XqgG?=
 =?iso-8859-1?Q?WaC7u625/YxB8GZDiFNs6AiLdIByQN/FOE0IPQrfKhQ2jb43UiZH6YPFna?=
 =?iso-8859-1?Q?nqbGKI0THgpc3w7xwk6wsB1Isy3FMkcRgjWIA/np5A0DEgwhfq3FBrDqHI?=
 =?iso-8859-1?Q?TQRk96qYWlJfWYYW0HAhCpBohzOFJVb1oCEv0PhbpgqBn3otcPtohOJx+0?=
 =?iso-8859-1?Q?KsDynt0BWUdLJVWUVQnj3ebMpP8y02wxhkJjzSmP9pVK+i72x490hiy0YE?=
 =?iso-8859-1?Q?xeIkfkm+9K8fLsh9/LYBhY4YLo2I5QB1PcDu3J2kmABk4IA4OLxo74JwbD?=
 =?iso-8859-1?Q?IRtfY2n0e95cne5ANQwe4pTRYUp7kSA739Qq4q3CsMWfO9qduL3hoskKHD?=
 =?iso-8859-1?Q?dCjeE9TqY7vRulZDrRJP1/4DnaZCk+syTF9czqiBrmkQdJ4U7Nu8SXKo5+?=
 =?iso-8859-1?Q?fJoZb14On4TCEf/FRnYLg+8wKeS60Lzdt2IJpHIcK3u68q0bODJRLHIaoU?=
 =?iso-8859-1?Q?n9ML+451F70S6GZ6b/oygpu3GP99ib1X1m3Qg4+vSewL3XeIM7Kv0aUNt7?=
 =?iso-8859-1?Q?pW+QLFB+J1guEes5icv9dvbD72LaAq1NWf9lJ0XOAvFjtdnPAYd+34fCPw?=
 =?iso-8859-1?Q?PTm02we/UiZGR502Yy2ZZgeAhE1WJWwYbknh5qsVBeKd/p0IZGJqnljxCL?=
 =?iso-8859-1?Q?a7m+22uhM/h48eO+WFI7n/4bQmkpwVz4MbUYkJ4spu5hAUGmg1NhicX901?=
 =?iso-8859-1?Q?YMz6FPTrPARbYvKqLzJNTrs3FLncjRRinoEZcUtBl434GtsWYf2TcYl6bn?=
 =?iso-8859-1?Q?SgS01nI0eINM7RzpLMk1KOnEwtLF+Z6hbQqg/RAbn7ffF3bArgsrCulmNQ?=
 =?iso-8859-1?Q?ohHB9MS1BU0uhwUxzA8IYIEuy6P6w0MuJ1ywGSDGRG7AD9spJKj4lZl7rb?=
 =?iso-8859-1?Q?vA4Oh2UtWWel6nbhjHycHiuJr7YEKvk6wJ91Qrw/CEQWE1J4PkDQQpicna?=
 =?iso-8859-1?Q?MqX24bdwPoAHGirLPsBp0jQRXDVPM1PTxyiVfwo2z0XhkGvCLRp3ufVq+6?=
 =?iso-8859-1?Q?xg90JStFIe8Wwpvq+QQBQrDw2oyUh2G6V6CJowqr0PLE8wPFopPerhnXEf?=
 =?iso-8859-1?Q?jgzlwW4TirgD0pBSD1c=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5387719AD57026EE6470F05AF0709CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25135f00-b42a-4f0b-37c3-08d9bad346cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 05:18:03.6924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2hgKQCxlCeGp/cNs6opmsRgLWmsrg/QEFjld0My3u59ggKaPNBGATus3pMO/W0hF0TW04JKmy5UNpevH5UtCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5387719AD57026EE6470F05AF0709CH0PR12MB5387namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

> The whole idea seems fine to me. However, we are trying to do some cleanu=
ps to avoid spiking into power internals(as above via adev->powerplay.pp_fu=
ncs->emit_clock_levels).
> Check the patch series below:
> https://lists.freedesktop.org/archives/amd-gfx/2021-December/072096.html
> So, it would be better if you can rebase the patches here based on that. =
Or you can wait a while to let me land them first.

> BR
> Evan

I can wait for it to land and rebase then, will send v2 of series once this=
 happens
Darren

________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, December 8, 2021 8:48 PM
To: Powell, Darren <Darren.Powell@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: RE: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that =
accepts buffer base and write offset

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Darren Powell
> Sent: Wednesday, December 8, 2021 2:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Powell, Darren <Darren.Powell@amd.com>
> Subject: [PATCH 1/3] amdgpu/pm: Implement new API function "emit" that
> accepts buffer base and write offset
>
>  - new power management function emit_clk_levels implemented by
> navi10_emit_clk_levels()
>        This function currently duplicates the functionality of
> navi10_print_clk_levels, where
>        snprintf is used write to the sysfs buffer. The first implementati=
on to use
> sysfs_emit
>        was unsuccessful due to requirement that buf must be aligned to a
> specific memory
>        boundary. This solution passes the buffer base and write offset do=
wn the
> stack.
>  - new power management function emit_clock_levels implemented by
> smu_emit_ppclk_levels()
>        This function combines implementation of smu_print_ppclk_levels an=
d
>        smu_print_smuclk_levels and calls emit_clk_levels
>  - new helper function smu_convert_to_smuclk called by
> smu_print_ppclk_levels and
>        smu_emit_ppclk_levels
>  - emit_clock_levels currently returns the length of the string written t=
o the
> buffer,
>        maintaining the behaviour of print_clock_levels, but will be upgra=
ded to
> return
>        error values in a subsequent patch
>  - failure of the emit_clock_levels at the top level
> (amdgpu_get_pp_dpm_clock) triggers a
>        fallback to the print_clock_levels, which can be removed after
> emit_clock_levels is
>        implemented across all platforms.
>
>  =3D=3D Test =3D=3D
>  LOGFILE=3Dpp_clk.test.log
>  AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
>  AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR |
> awk '{print $9}'`
>  HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}
>
>  lspci -nn | grep "VGA\|Display"  > $LOGFILE
>  FILES=3D"pp_od_clk_voltage
>  pp_dpm_sclk
>  pp_dpm_mclk
>  pp_dpm_pcie
>  pp_dpm_socclk
>  pp_dpm_fclk
>  pp_dpm_dcefclk
>  pp_dpm_vclk
>  pp_dpm_dclk "
>
>  for f in $FILES
>  do
>    echo =3D=3D=3D $f =3D=3D=3D >> $LOGFILE
>    cat $HWMON_DIR/device/$f >> $LOGFILE
>  done
>  cat $LOGFILE
>
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  20 +-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   3 +
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  10 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  50 ++++-
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 189
> ++++++++++++++++++
>  6 files changed, 262 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index bac15c466733..43f43a4f321b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -310,6 +310,7 @@ struct amd_pm_funcs {
>        int (*get_fan_speed_pwm)(void *handle, u32 *speed);
>        int (*force_clock_level)(void *handle, enum pp_clock_type type,
> uint32_t mask);
>        int (*print_clock_levels)(void *handle, enum pp_clock_type type,
> char *buf);
> +     int (*emit_clock_levels)(void *handle, enum pp_clock_type type,
> char *buf, int *offset);
>        int (*force_performance_level)(void *handle, enum
> amd_dpm_forced_level level);
>        int (*get_sclk_od)(void *handle);
>        int (*set_sclk_od)(void *handle, uint32_t value);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 49df4c20f09e..a1169a2397ca 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1056,8 +1056,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
> device *dev,
>  {
>        struct drm_device *ddev =3D dev_get_drvdata(dev);
>        struct amdgpu_device *adev =3D drm_to_adev(ddev);
> -     ssize_t size;
> -     int ret;
> +     int size =3D 0;
> +     int ret =3D 0;
>
>        if (amdgpu_in_reset(adev))
>                return -EPERM;
> @@ -1070,10 +1070,18 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
> device *dev,
>                return ret;
>        }
>
> -     if (adev->powerplay.pp_funcs->print_clock_levels)
> -             size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);
> -     else
> -             size =3D sysfs_emit(buf, "\n");
> +     ret =3D -EOPNOTSUPP;
> +     if (adev->powerplay.pp_funcs->emit_clock_levels) {
> +             ret =3D amdgpu_dpm_emit_clock_levels(adev, type, buf,
> &size);
> +     }
The whole idea seems fine to me. However, we are trying to do some cleanups=
 to avoid spiking into power internals(as above via adev->powerplay.pp_func=
s->emit_clock_levels).
Check the patch series below:
https://lists.freedesktop.org/archives/amd-gfx/2021-December/072096.html
So, it would be better if you can rebase the patches here based on that. Or=
 you can wait a while to let me land them first.

BR
Evan
> +
> +     if (ret < 0) {
> +             if (adev->powerplay.pp_funcs->print_clock_levels) {
> +                     size =3D amdgpu_dpm_print_clock_levels(adev, type,
> buf);
> +             }
> +             else
> +                     size =3D sysfs_emit(buf, "\n");
> +     }
>
>        pm_runtime_mark_last_busy(ddev->dev);
>        pm_runtime_put_autosuspend(ddev->dev);
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 16e3f72d31b9..95add7afcc86 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -310,6 +310,9 @@ enum amdgpu_pcie_gen {
>  #define amdgpu_dpm_print_clock_levels(adev, type, buf) \
>                ((adev)->powerplay.pp_funcs->print_clock_levels((adev)-
> >powerplay.pp_handle, type, buf))
>
> +#define amdgpu_dpm_emit_clock_levels(adev, type, buf, offset) \
> +             ((adev)->powerplay.pp_funcs->emit_clock_levels((adev)-
> >powerplay.pp_handle, type, buf, offset))
> +
>  #define amdgpu_dpm_force_clock_level(adev, type, level) \
>                ((adev)->powerplay.pp_funcs->force_clock_level((adev)-
> >powerplay.pp_handle, type, level))
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index f738f7dc20c9..dc1325783c10 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -620,6 +620,16 @@ struct pptable_funcs {
>         */
>        int (*print_clk_levels)(struct smu_context *smu, enum
> smu_clk_type clk_type, char *buf);
>
> +     /**
> +      * @emit_clk_levels: Print DPM clock levels for a clock domain
> +      *                    to buffer using sysfs_emit_at. Star current l=
evel.
> +      *
> +      * Used for sysfs interfaces.
> +      * &buf: sysfs buffer
> +      * &offset: offset within buffer to start printing
> +      */
> +     int (*emit_clk_levels)(struct smu_context *smu, enum
> smu_clk_type clk_type, char *buf, int *offset);
> +
>        /**
>         * @force_clk_levels: Set a range of allowed DPM levels for a cloc=
k
>         *                    domain.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index e156add7b560..b0638d8308d2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2397,11 +2397,8 @@ static int smu_print_smuclk_levels(struct
> smu_context *smu, enum smu_clk_type cl
>        return ret;
>  }
>
> -static int smu_print_ppclk_levels(void *handle,
> -                               enum pp_clock_type type,
> -                               char *buf)
> +static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type
> type)
>  {
> -     struct smu_context *smu =3D handle;
>        enum smu_clk_type clk_type;
>
>        switch (type) {
> @@ -2434,12 +2431,54 @@ static int smu_print_ppclk_levels(void *handle,
>        case OD_CCLK:
>                clk_type =3D SMU_OD_CCLK; break;
>        default:
> -             return -EINVAL;
> +             clk_type =3D SMU_CLK_COUNT; break;
>        }
>
> +     return clk_type;
> +}
> +
> +static int smu_print_ppclk_levels(void *handle,
> +                               enum pp_clock_type type,
> +                               char *buf)
> +{
> +     struct smu_context *smu =3D handle;
> +     enum smu_clk_type clk_type;
> +
> +     clk_type =3D smu_convert_to_smuclk(type);
> +     if (clk_type =3D=3D SMU_CLK_COUNT)
> +             return -EINVAL;
> +
>        return smu_print_smuclk_levels(smu, clk_type, buf);
>  }
>
> +static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type,
> char *buf, int *offset)
> +{
> +     struct smu_context *smu =3D handle;
> +     enum smu_clk_type clk_type;
> +     int ret =3D 0;
> +
> +     clk_type =3D smu_convert_to_smuclk(type);
> +     if (clk_type =3D=3D SMU_CLK_COUNT)
> +             return -EINVAL;
> +
> +     if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> +             return -EOPNOTSUPP;
> +
> +     mutex_lock(&smu->mutex);
> +
> +     if (smu->ppt_funcs->emit_clk_levels) {
> +             ret =3D smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf,
> offset);
> +     }
> +     else {
> +             ret =3D -EOPNOTSUPP;
> +     }
> +
> +     mutex_unlock(&smu->mutex);
> +
> +     return ret;
> +
> +}
> +
>  static int smu_od_edit_dpm_table(void *handle,
>                                 enum PP_OD_DPM_TABLE_COMMAND
> type,
>                                 long *input, uint32_t size)
> @@ -3117,6 +3156,7 @@ static const struct amd_pm_funcs
> swsmu_pm_funcs =3D {
>        .get_fan_speed_pwm   =3D smu_get_fan_speed_pwm,
>        .force_clock_level       =3D smu_force_ppclk_levels,
>        .print_clock_levels      =3D smu_print_ppclk_levels,
> +     .emit_clock_levels       =3D smu_emit_ppclk_levels,
>        .force_performance_level =3D smu_force_performance_level,
>        .read_sensor             =3D smu_read_sensor,
>        .get_performance_level   =3D smu_get_performance_level,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 60a557068ea4..e43c7e950a55 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1261,6 +1261,194 @@ static void navi10_od_setting_get_range(struct
> smu_11_0_overdrive_table *od_tabl
>                *max =3D od_table->max[setting];
>  }
>
> +static int navi10_emit_clk_levels(struct smu_context *smu,
> +                     enum smu_clk_type clk_type, char *buf, int *offset)
> +{
> +     uint16_t *curve_settings;
> +     int ret =3D 0;
> +     uint32_t cur_value =3D 0, value =3D 0;
> +     uint32_t freq_values[3] =3D {0};
> +     uint32_t i, levels, mark_index =3D 0, count =3D 0;
> +     struct smu_table_context *table_context =3D &smu->smu_table;
> +     uint32_t gen_speed, lane_width;
> +     struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
> +     struct smu_11_0_dpm_context *dpm_context =3D smu_dpm-
> >dpm_context;
> +     PPTable_t *pptable =3D (PPTable_t *)table_context->driver_pptable;
> +     OverDriveTable_t *od_table =3D
> +             (OverDriveTable_t *)table_context->overdrive_table;
> +     struct smu_11_0_overdrive_table *od_settings =3D smu->od_settings;
> +     uint32_t min_value, max_value;
> +     int save_offset =3D *offset;
> +
> +     switch (clk_type) {
> +     case SMU_GFXCLK:
> +     case SMU_SCLK:
> +     case SMU_SOCCLK:
> +     case SMU_MCLK:
> +     case SMU_UCLK:
> +     case SMU_FCLK:
> +     case SMU_VCLK:
> +     case SMU_DCLK:
> +     case SMU_DCEFCLK:
> +             ret =3D navi10_get_current_clk_freq_by_table(smu, clk_type,
> &cur_value);
> +             if (ret)
> +                     return 0;
> +
> +             ret =3D smu_v11_0_get_dpm_level_count(smu, clk_type,
> &count);
> +             if (ret)
> +                     return 0;
> +
> +             if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
> +                     for (i =3D 0; i < count; i++) {
> +                             ret =3D
> smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
> +                             if (ret)
> +                                     return (*offset - save_offset);
> +
> +                             *offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i, value,
> +                                             cur_value =3D=3D value ? "*=
" : "");
> +
> +                     }
> +             } else {
> +                     ret =3D smu_v11_0_get_dpm_freq_by_index(smu,
> clk_type, 0, &freq_values[0]);
> +                     if (ret)
> +                             return 0;
> +                     ret =3D smu_v11_0_get_dpm_freq_by_index(smu,
> clk_type, count - 1, &freq_values[2]);
> +                     if (ret)
> +                             return 0;
> +
> +                     freq_values[1] =3D cur_value;
> +                     mark_index =3D cur_value =3D=3D freq_values[0] ? 0 =
:
> +                                  cur_value =3D=3D freq_values[2] ? 2 : =
1;
> +
> +                     levels =3D 3;
> +                     if (mark_index !=3D 1) {
> +                             levels =3D 2;
> +                             freq_values[1] =3D freq_values[2];
> +                     }
> +
> +                     for (i =3D 0; i < levels; i++) {
> +                             *offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i, freq_values[i],
> +                                             i =3D=3D mark_index ? "*" :=
 "");
> +                     }
> +             }
> +             break;
> +     case SMU_PCIE:
> +             gen_speed =3D
> smu_v11_0_get_current_pcie_link_speed_level(smu);
> +             lane_width =3D
> smu_v11_0_get_current_pcie_link_width_level(smu);
> +             for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
> +                     *offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %s %s %dMhz %s\n", i,
> +                                     (dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 0) ? "2.5GT/s," :
> +                                     (dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 1) ? "5.0GT/s," :
> +                                     (dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 2) ? "8.0GT/s," :
> +                                     (dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i] =3D=3D 3) ? "16.0GT/s," : "",
> +                                     (dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 1) ? "x1" :
> +                                     (dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 2) ? "x2" :
> +                                     (dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 3) ? "x4" :
> +                                     (dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 4) ? "x8" :
> +                                     (dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 5) ? "x12" :
> +                                     (dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i] =3D=3D 6) ? "x16" : "",
> +                                     pptable->LclkFreq[i],
> +                                     (gen_speed =3D=3D dpm_context-
> >dpm_tables.pcie_table.pcie_gen[i]) &&
> +                                     (lane_width =3D=3D dpm_context-
> >dpm_tables.pcie_table.pcie_lane[i]) ?
> +                                     "*" : "");
> +             }
> +             break;
> +     case SMU_OD_SCLK:
> +             if (!smu->od_enabled || !od_table || !od_settings)
> +                     break;
> +             if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_LIMITS))
> +                     break;
> +             *offset +=3D sysfs_emit_at(buf, *offset,
> "OD_SCLK:\n0: %uMhz\n1: %uMhz\n",
> +                                       od_table->GfxclkFmin, od_table-
> >GfxclkFmax);
> +             break;
> +     case SMU_OD_MCLK:
> +             if (!smu->od_enabled || !od_table || !od_settings)
> +                     break;
> +             if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_UCLK_MAX))
> +                     break;
> +             *offset +=3D sysfs_emit_at(buf, *offset,
> "OD_MCLK:\n1: %uMHz\n", od_table->UclkFmax);
> +             break;
> +     case SMU_OD_VDDC_CURVE:
> +             if (!smu->od_enabled || !od_table || !od_settings)
> +                     break;
> +             if (!navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_CURVE))
> +                     break;
> +             *offset +=3D sysfs_emit_at(buf, *offset,
> "OD_VDDC_CURVE:\n");
> +             for (i =3D 0; i < 3; i++) {
> +                     switch (i) {
> +                     case 0:
> +                             curve_settings =3D &od_table->GfxclkFreq1;
> +                             break;
> +                     case 1:
> +                             curve_settings =3D &od_table->GfxclkFreq2;
> +                             break;
> +                     case 2:
> +                             curve_settings =3D &od_table->GfxclkFreq3;
> +                             break;
> +                     default:
> +                             break;
> +                     }
> +                     *offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMHz %umV\n",
> +                                               i, curve_settings[0],
> +                                     curve_settings[1] /
> NAVI10_VOLTAGE_SCALE);
> +             }
> +             break;
> +     case SMU_OD_RANGE:
> +             if (!smu->od_enabled || !od_table || !od_settings)
> +                     break;
> +             *offset +=3D sysfs_emit_at(buf, *offset, "%s:\n",
> "OD_RANGE");
> +
> +             if (navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
> +                     navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_GFXCLKFMIN,
> +                                                 &min_value, NULL);
> +                     navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_GFXCLKFMAX,
> +                                                 NULL, &max_value);
> +                     *offset+=3D sysfs_emit_at(buf, *offset,
> "SCLK: %7uMhz %10uMhz\n",
> +                                     min_value, max_value);
> +             }
> +
> +             if (navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_UCLK_MAX)) {
> +                     navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_UCLKFMAX,
> +                                                 &min_value, &max_value)=
;
> +                     *offset+=3D sysfs_emit_at(buf, *offset,
> "MCLK: %7uMhz %10uMhz\n",
> +                                     min_value, max_value);
> +             }
> +
> +             if (navi10_od_feature_is_supported(od_settings,
> SMU_11_0_ODCAP_GFXCLK_CURVE)) {
> +                     navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,
> +                                                 &min_value, &max_value)=
;
> +                     *offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
> +                                           min_value, max_value);
> +                     navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P1,
> +                                                 &min_value, &max_value)=
;
> +                     *offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
> +                                           min_value, max_value);
> +                     navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P2,
> +                                                 &min_value, &max_value)=
;
> +                     *offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
> +                                           min_value, max_value);
> +                     navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P2,
> +                                                 &min_value, &max_value)=
;
> +                     *offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
> +                                           min_value, max_value);
> +                     navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P3,
> +                                                 &min_value, &max_value)=
;
> +                     *offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
> +                                           min_value, max_value);
> +                     navi10_od_setting_get_range(od_settings,
> SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P3,
> +                                                 &min_value, &max_value)=
;
> +                     *offset +=3D sysfs_emit_at(buf, *offset,
> "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
> +                                           min_value, max_value);
> +             }
> +
> +             break;
> +     default:
> +             break;
> +     }
> +
> +     return (*offset - save_offset);
> +}
> +
>  static int navi10_print_clk_levels(struct smu_context *smu,
>                        enum smu_clk_type clk_type, char *buf)
>  {
> @@ -3245,6 +3433,7 @@ static const struct pptable_funcs navi10_ppt_funcs
> =3D {
>        .i2c_init =3D navi10_i2c_control_init,
>        .i2c_fini =3D navi10_i2c_control_fini,
>        .print_clk_levels =3D navi10_print_clk_levels,
> +     .emit_clk_levels =3D navi10_emit_clk_levels,
>        .force_clk_levels =3D navi10_force_clk_levels,
>        .populate_umd_state_clk =3D navi10_populate_umd_state_clk,
>        .get_clock_by_type_with_latency =3D
> navi10_get_clock_by_type_with_latency,
> --
> 2.34.1

--_000_CH0PR12MB5387719AD57026EE6470F05AF0709CH0PR12MB5387namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">&gt; The whole idea se=
ems
 fine to me. However, we are trying to do some cleanups to avoid spiking in=
to power internals(as above via adev-&gt;powerplay.pp_funcs-&gt;emit_clock_=
levels).</span><br>
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">&gt; Check the patch s=
eries
 below:</span><br style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI=
 Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSy=
stemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667p=
x;background-color:rgb(255, 255, 255)">
&gt;&nbsp;<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2021-De=
cember/072096.html" style=3D"margin:0px;font-size:14.6667px;font-family:&qu=
ot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI=
&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quo=
t;, sans-serif;background-color:rgb(255, 255, 255)">https://lists.freedeskt=
op.org/archives/amd-gfx/2021-December/072096.html</a><br style=3D"font-fami=
ly:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Se=
goe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Ne=
ue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255, 255, 255=
)">
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">&gt; So, it would be b=
etter
 if you can rebase the patches here based on that. Or you can wait a while =
to let me land them first.</span><br style=3D"font-family:&quot;Segoe UI&qu=
ot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple=
-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
;font-size:14.6667px;background-color:rgb(255, 255, 255)">
<br style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West Eur=
opean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robo=
to, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background-c=
olor:rgb(255, 255, 255)">
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">&gt; BR</span><br styl=
e=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&q=
uot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quo=
t;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb=
(255, 255, 255)">
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">&gt; Evan</span><br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I can wait for it to land and rebase then, will send v2 of series once this=
 happens</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Darren</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 8, 2021 8:48 PM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 1/3] amdgpu/pm: Implement new API function &quot=
;emit&quot; that accepts buffer base and write offset</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[AMD Official Use Only]<br>
<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of<br>
&gt; Darren Powell<br>
&gt; Sent: Wednesday, December 8, 2021 2:36 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
&gt; Subject: [PATCH 1/3] amdgpu/pm: Implement new API function &quot;emit&=
quot; that<br>
&gt; accepts buffer base and write offset<br>
&gt; <br>
&gt;&nbsp; - new power management function emit_clk_levels implemented by<b=
r>
&gt; navi10_emit_clk_levels()<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This function currently dupl=
icates the functionality of<br>
&gt; navi10_print_clk_levels, where<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf is used write to th=
e sysfs buffer. The first implementation to use<br>
&gt; sysfs_emit<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; was unsuccessful due to requ=
irement that buf must be aligned to a<br>
&gt; specific memory<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boundary. This solution pass=
es the buffer base and write offset down the<br>
&gt; stack.<br>
&gt;&nbsp; - new power management function emit_clock_levels implemented by=
<br>
&gt; smu_emit_ppclk_levels()<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This function combines imple=
mentation of smu_print_ppclk_levels and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_print_smuclk_levels and =
calls emit_clk_levels<br>
&gt;&nbsp; - new helper function smu_convert_to_smuclk called by<br>
&gt; smu_print_ppclk_levels and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_emit_ppclk_levels<br>
&gt;&nbsp; - emit_clock_levels currently returns the length of the string w=
ritten to the<br>
&gt; buffer,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; maintaining the behaviour of=
 print_clock_levels, but will be upgraded to<br>
&gt; return<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error values in a subsequent=
 patch<br>
&gt;&nbsp; - failure of the emit_clock_levels at the top level<br>
&gt; (amdgpu_get_pp_dpm_clock) triggers a<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fallback to the print_clock_=
levels, which can be removed after<br>
&gt; emit_clock_levels is<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; implemented across all platf=
orms.<br>
&gt; <br>
&gt;&nbsp; =3D=3D Test =3D=3D<br>
&gt;&nbsp; LOGFILE=3Dpp_clk.test.log<br>
&gt;&nbsp; AMDGPU_PCI_ADDR=3D`lspci -nn | grep &quot;VGA\|Display&quot; | c=
ut -d &quot; &quot; -f 1`<br>
&gt;&nbsp; AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR =
|<br>
&gt; awk '{print $9}'`<br>
&gt;&nbsp; HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}<br>
&gt; <br>
&gt;&nbsp; lspci -nn | grep &quot;VGA\|Display&quot;&nbsp; &gt; $LOGFILE<br=
>
&gt;&nbsp; FILES=3D&quot;pp_od_clk_voltage<br>
&gt;&nbsp; pp_dpm_sclk<br>
&gt;&nbsp; pp_dpm_mclk<br>
&gt;&nbsp; pp_dpm_pcie<br>
&gt;&nbsp; pp_dpm_socclk<br>
&gt;&nbsp; pp_dpm_fclk<br>
&gt;&nbsp; pp_dpm_dcefclk<br>
&gt;&nbsp; pp_dpm_vclk<br>
&gt;&nbsp; pp_dpm_dclk &quot;<br>
&gt; <br>
&gt;&nbsp; for f in $FILES<br>
&gt;&nbsp; do<br>
&gt;&nbsp;&nbsp;&nbsp; echo =3D=3D=3D $f =3D=3D=3D &gt;&gt; $LOGFILE<br>
&gt;&nbsp;&nbsp;&nbsp; cat $HWMON_DIR/device/$f &gt;&gt; $LOGFILE<br>
&gt;&nbsp; done<br>
&gt;&nbsp; cat $LOGFILE<br>
&gt; <br>
&gt; Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 10 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 50 ++++-<br>
&gt;&nbsp; .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp; | 189<br=
>
&gt; ++++++++++++++++++<br>
&gt;&nbsp; 6 files changed, 262 insertions(+), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; index bac15c466733..43f43a4f321b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; @@ -310,6 +310,7 @@ struct amd_pm_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_fan_speed_pwm)(voi=
d *handle, u32 *speed);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*force_clock_level)(voi=
d *handle, enum pp_clock_type type,<br>
&gt; uint32_t mask);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*print_clock_levels)(vo=
id *handle, enum pp_clock_type type,<br>
&gt; char *buf);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int (*emit_clock_levels)(void *handle, enum =
pp_clock_type type,<br>
&gt; char *buf, int *offset);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*force_performance_leve=
l)(void *handle, enum<br>
&gt; amd_dpm_forced_level level);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_sclk_od)(void *han=
dle);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_sclk_od)(void *han=
dle, uint32_t value);<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; index 49df4c20f09e..a1169a2397ca 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; @@ -1056,8 +1056,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct<br=
>
&gt; device *dev,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D =
dev_get_drvdata(dev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D drm_to_adev(ddev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int size =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EPERM;<br>
&gt; @@ -1070,10 +1070,18 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct<=
br>
&gt; device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;print_cl=
ock_levels)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size =3D amdgpu_dpm_print_clock_levels(adev, type, buf);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size =3D sysfs_emit(buf, &quot;\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -EOPNOTSUPP;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;emit_clo=
ck_levels) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D amdgpu_dpm_emit_clock_levels(adev, type, buf,<br>
&gt; &amp;size);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
The whole idea seems fine to me. However, we are trying to do some cleanups=
 to avoid spiking into power internals(as above via adev-&gt;powerplay.pp_f=
uncs-&gt;emit_clock_levels).<br>
Check the patch series below:<br>
<a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2021-December/072=
096.html">https://lists.freedesktop.org/archives/amd-gfx/2021-December/0720=
96.html</a><br>
So, it would be better if you can rebase the patches here based on that. Or=
 you can wait a while to let me land them first.<br>
<br>
BR<br>
Evan<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;powerplay.pp_funcs-&gt;print_clock_levels) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D amdgpu_dpm_pri=
nt_clock_levels(adev, type,<br>
&gt; buf);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D sysfs_emit(buf=
, &quot;\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(dd=
ev-&gt;dev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(d=
dev-&gt;dev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h<br>
&gt; b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h<br>
&gt; index 16e3f72d31b9..95add7afcc86 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h<br>
&gt; @@ -310,6 +310,9 @@ enum amdgpu_pcie_gen {<br>
&gt;&nbsp; #define amdgpu_dpm_print_clock_levels(adev, type, buf) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;print_clock_levels((=
adev)-<br>
&gt; &gt;powerplay.pp_handle, type, buf))<br>
&gt; <br>
&gt; +#define amdgpu_dpm_emit_clock_levels(adev, type, buf, offset) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ((adev)-&gt;powerplay.pp_funcs-&gt;emit_clock_levels((adev)-<br>
&gt; &gt;powerplay.pp_handle, type, buf, offset))<br>
&gt; +<br>
&gt;&nbsp; #define amdgpu_dpm_force_clock_level(adev, type, level) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;force_clock_level((a=
dev)-<br>
&gt; &gt;powerplay.pp_handle, type, level))<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; index f738f7dc20c9..dc1325783c10 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; @@ -620,6 +620,16 @@ struct pptable_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*print_clk_levels)(stru=
ct smu_context *smu, enum<br>
&gt; smu_clk_type clk_type, char *buf);<br>
&gt; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @emit_clk_levels: Print DPM clock le=
vels for a clock domain<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; to buffer using sysfs_emit_at. Star current level.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Used for sysfs interfaces.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &amp;buf: sysfs buffer<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &amp;offset: offset within buffer to=
 start printing<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int (*emit_clk_levels)(struct smu_context *s=
mu, enum<br>
&gt; smu_clk_type clk_type, char *buf, int *offset);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @force_clk_levels: S=
et a range of allowed DPM levels for a clock<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; domain.<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index e156add7b560..b0638d8308d2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -2397,11 +2397,8 @@ static int smu_print_smuclk_levels(struct<br>
&gt; smu_context *smu, enum smu_clk_type cl<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -static int smu_print_ppclk_levels(void *handle,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; +static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type<br>
&gt; type)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_type;<=
br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt; @@ -2434,12 +2431,54 @@ static int smu_print_ppclk_levels(void *handle=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case OD_CCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clk_type =3D SMU_OD_CCLK; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; clk_type =3D SMU_CLK_COUNT; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return clk_type;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int smu_print_ppclk_levels(void *handle,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_type;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; clk_type =3D smu_convert_to_smuclk(type);<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (clk_type =3D=3D SMU_CLK_COUNT)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_print_smuclk_leve=
ls(smu, clk_type, buf);<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; +static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type typ=
e,<br>
&gt; char *buf, int *offset)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D handle;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_type;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; clk_type =3D smu_convert_to_smuclk(type);<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (clk_type =3D=3D SMU_CLK_COUNT)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&gt;adev-&gt=
;pm.dpm_enabled)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EOPNOTSUPP;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;emit_clk_levels) {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu-&gt;ppt_funcs-&gt;emit_clk_levels(smu, clk_type, buf,<br>
&gt; offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D -EOPNOTSUPP;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;mutex);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static int smu_od_edit_dpm_table(void *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_OD_DPM_TABLE_COMMAND=
<br>
&gt; type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long *input, uint32_t size)<=
br>
&gt; @@ -3117,6 +3156,7 @@ static const struct amd_pm_funcs<br>
&gt; swsmu_pm_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_pwm&nbsp;&nbs=
p; =3D smu_get_fan_speed_pwm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clock_level&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_force_ppclk_levels,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clock_levels&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D smu_print_ppclk_levels,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .emit_clock_levels&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D smu_emit_ppclk_levels,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_performance_level =3D=
 smu_force_performance_level,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D smu_read_senso=
r,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_performance_level&nbsp;=
&nbsp; =3D smu_get_performance_level,<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; index 60a557068ea4..e43c7e950a55 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; @@ -1261,6 +1261,194 @@ static void navi10_od_setting_get_range(struct=
<br>
&gt; smu_11_0_overdrive_table *od_tabl<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *max =3D od_table-&gt;max[setting];<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; +static int navi10_emit_clk_levels(struct smu_context *smu,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_t=
ype, char *buf, int *offset)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t *curve_settings;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value =3D 0, value =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t freq_values[3] =3D {0};<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, levels, mark_index =3D 0, count =
=3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =3D =
&amp;smu-&gt;smu_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gen_speed, lane_width;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_dpm =3D &amp;smu=
-&gt;smu_dpm;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_dpm_context *dpm_context =3D=
 smu_dpm-<br>
&gt; &gt;dpm_context;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D (PPTable_t *)table_co=
ntext-&gt;driver_pptable;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *od_table =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (OverDriveTable_t *)table_context-&gt;overdrive_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_overdrive_table *od_settings=
 =3D smu-&gt;od_settings;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_value, max_value;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int save_offset =3D *offset;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (clk_type) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_GFXCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SOCCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_MCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_UCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_VCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_DCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_DCEFCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D navi10_get_current_clk_freq_by_table(smu, clk_type,<br>
&gt; &amp;cur_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_v11_0_get_dpm_level_count(smu, clk_type,<br>
&gt; &amp;count);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; co=
unt; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ret =3D<br>
&gt; smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &amp;value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn (*offset - save_offset);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; *offset +=3D sysfs_emit_at(buf, *offset,<br>
&gt; &quot;%d: %uMhz %s\n&quot;, i, value,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_value =3D=3D value ? &quo=
t;*&quot; : &quot;&quot;);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_d=
pm_freq_by_index(smu,<br>
&gt; clk_type, 0, &amp;freq_values[0]);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_get_d=
pm_freq_by_index(smu,<br>
&gt; clk_type, count - 1, &amp;freq_values[2]);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D cur_=
value;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mark_index =3D cur_valu=
e =3D=3D freq_values[0] ? 0 :<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_value =3D=3D fre=
q_values[2] ? 2 : 1;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels =3D 3;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mark_index !=3D 1) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; levels =3D 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D freq_values[2];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; le=
vels; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; *offset +=3D sysfs_emit_at(buf, *offset,<br>
&gt; &quot;%d: %uMhz %s\n&quot;, i, freq_values[i],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D=3D mark_index ? &quot;*=
&quot; : &quot;&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_PCIE:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; gen_speed =3D<br>
&gt; smu_v11_0_get_current_pcie_link_speed_level(smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; lane_width =3D<br>
&gt; smu_v11_0_get_current_pcie_link_width_level(smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D 0; i &lt; NUM_LINK_LEVELS; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset +=3D sysfs_emit=
_at(buf, *offset,<br>
&gt; &quot;%d: %s %s %dMhz %s\n&quot;, i,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (d=
pm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_gen[i] =3D=3D 0) ? &quot;2.5GT/s,&quot;=
 :<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (d=
pm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_gen[i] =3D=3D 1) ? &quot;5.0GT/s,&quot;=
 :<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (d=
pm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_gen[i] =3D=3D 2) ? &quot;8.0GT/s,&quot;=
 :<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (d=
pm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_gen[i] =3D=3D 3) ? &quot;16.0GT/s,&quot=
; : &quot;&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (d=
pm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_lane[i] =3D=3D 1) ? &quot;x1&quot; :<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (d=
pm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_lane[i] =3D=3D 2) ? &quot;x2&quot; :<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (d=
pm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_lane[i] =3D=3D 3) ? &quot;x4&quot; :<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (d=
pm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_lane[i] =3D=3D 4) ? &quot;x8&quot; :<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (d=
pm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_lane[i] =3D=3D 5) ? &quot;x12&quot; :<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (d=
pm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_lane[i] =3D=3D 6) ? &quot;x16&quot; : &=
quot;&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp=
table-&gt;LclkFreq[i],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (g=
en_speed =3D=3D dpm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_gen[i]) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (l=
ane_width =3D=3D dpm_context-<br>
&gt; &gt;dpm_tables.pcie_table.pcie_lane[i]) ?<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &q=
uot;*&quot; : &quot;&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_OD_SCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!smu-&gt;od_enabled || !od_table || !od_settings)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!navi10_od_feature_is_supported(od_settings,<br>
&gt; SMU_11_0_ODCAP_GFXCLK_LIMITS))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *offset +=3D sysfs_emit_at(buf, *offset,<br>
&gt; &quot;OD_SCLK:\n0: %uMhz\n1: %uMhz\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; od_table-&gt;GfxclkFmin, od_table-<br>
&gt; &gt;GfxclkFmax);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_OD_MCLK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!smu-&gt;od_enabled || !od_table || !od_settings)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!navi10_od_feature_is_supported(od_settings,<br>
&gt; SMU_11_0_ODCAP_UCLK_MAX))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *offset +=3D sysfs_emit_at(buf, *offset,<br>
&gt; &quot;OD_MCLK:\n1: %uMHz\n&quot;, od_table-&gt;UclkFmax);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_OD_VDDC_CURVE:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!smu-&gt;od_enabled || !od_table || !od_settings)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!navi10_od_feature_is_supported(od_settings,<br>
&gt; SMU_11_0_ODCAP_GFXCLK_CURVE))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *offset +=3D sysfs_emit_at(buf, *offset,<br>
&gt; &quot;OD_VDDC_CURVE:\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D 0; i &lt; 3; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (i) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; curve_settings =3D &amp;od_table-&gt;GfxclkFreq1;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; curve_settings =3D &amp;od_table-&gt;GfxclkFreq2;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; curve_settings =3D &amp;od_table-&gt;GfxclkFreq3;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset +=3D sysfs_emit=
_at(buf, *offset,<br>
&gt; &quot;%d: %uMHz %umV\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, curve_settings=
[0],<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu=
rve_settings[1] /<br>
&gt; NAVI10_VOLTAGE_SCALE);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case SMU_OD_RANGE:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!smu-&gt;od_enabled || !od_table || !od_settings)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *offset +=3D sysfs_emit_at(buf, *offset, &quot;%s:\n&quot;,<br>
&gt; &quot;OD_RANGE&quot;);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (navi10_od_feature_is_supported(od_settings,<br>
&gt; SMU_11_0_ODCAP_GFXCLK_LIMITS)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_od_setting_get_r=
ange(od_settings,<br>
&gt; SMU_11_0_ODSETTING_GFXCLKFMIN,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
min_value, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_od_setting_get_r=
ange(od_settings,<br>
&gt; SMU_11_0_ODSETTING_GFXCLKFMAX,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,=
 &amp;max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset+=3D sysfs_emit_=
at(buf, *offset,<br>
&gt; &quot;SCLK: %7uMhz %10uMhz\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mi=
n_value, max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (navi10_od_feature_is_supported(od_settings,<br>
&gt; SMU_11_0_ODCAP_UCLK_MAX)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_od_setting_get_r=
ange(od_settings,<br>
&gt; SMU_11_0_ODSETTING_UCLKFMAX,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
min_value, &amp;max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset+=3D sysfs_emit_=
at(buf, *offset,<br>
&gt; &quot;MCLK: %7uMhz %10uMhz\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mi=
n_value, max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (navi10_od_feature_is_supported(od_settings,<br>
&gt; SMU_11_0_ODCAP_GFXCLK_CURVE)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_od_setting_get_r=
ange(od_settings,<br>
&gt; SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
min_value, &amp;max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset +=3D sysfs_emit=
_at(buf, *offset,<br>
&gt; &quot;VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_value, max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_od_setting_get_r=
ange(od_settings,<br>
&gt; SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
min_value, &amp;max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset +=3D sysfs_emit=
_at(buf, *offset,<br>
&gt; &quot;VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_value, max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_od_setting_get_r=
ange(od_settings,<br>
&gt; SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
min_value, &amp;max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset +=3D sysfs_emit=
_at(buf, *offset,<br>
&gt; &quot;VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_value, max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_od_setting_get_r=
ange(od_settings,<br>
&gt; SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
min_value, &amp;max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset +=3D sysfs_emit=
_at(buf, *offset,<br>
&gt; &quot;VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_value, max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_od_setting_get_r=
ange(od_settings,<br>
&gt; SMU_11_0_ODSETTING_VDDGFXCURVEFREQ_P3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
min_value, &amp;max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset +=3D sysfs_emit=
_at(buf, *offset,<br>
&gt; &quot;VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_value, max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_od_setting_get_r=
ange(od_settings,<br>
&gt; SMU_11_0_ODSETTING_VDDGFXCURVEVOLTAGE_P3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
min_value, &amp;max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *offset +=3D sysfs_emit=
_at(buf, *offset,<br>
&gt; &quot;VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_value, max_value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (*offset - save_offset);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static int navi10_print_clk_levels(struct smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum sm=
u_clk_type clk_type, char *buf)<br>
&gt;&nbsp; {<br>
&gt; @@ -3245,6 +3433,7 @@ static const struct pptable_funcs navi10_ppt_fun=
cs<br>
&gt; =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .i2c_init =3D navi10_i2c_con=
trol_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .i2c_fini =3D navi10_i2c_con=
trol_fini,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clk_levels =3D navi10=
_print_clk_levels,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .emit_clk_levels =3D navi10_emit_clk_levels,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clk_levels =3D navi10=
_force_clk_levels,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .populate_umd_state_clk =3D =
navi10_populate_umd_state_clk,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock_by_type_with_late=
ncy =3D<br>
&gt; navi10_get_clock_by_type_with_latency,<br>
&gt; --<br>
&gt; 2.34.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5387719AD57026EE6470F05AF0709CH0PR12MB5387namp_--
