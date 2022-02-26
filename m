Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B17DC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 21:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0434A10E20F;
	Sat, 26 Feb 2022 21:32:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6114510E20F
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 21:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5iy4x538ssZACl5PK+ZYUFsFCTRtZWlLrnrBEAbWKX1K4CeeKdnybpSDee0G+/CBPnxmdkeSiABCCVpqASuByN5NpI1Zfkq7d8FvHRlMwUaLnqZmxmrG12tii01eqdMzT9UfCfqZAGhXeuxGW87SiPkbo2ppd8X/VUa/9jBIyLEssaK89t9c1agpE6EzJ6i2oyUpKJOVp2YZb+N4FsLJTvrp0rm/TDmEZFwf1BuOGIu4e6mGYs6KDYyvMLInQgNyBHe+4G2X8JeQZ135JZbRNNGEZ02+W6d+HERzgqmQqnSGSoyWkNFhfsXYYUdadGs70lvJubr4zcmH4dOK3hewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eBp6PnKZHDvsqKaVz+3ID0WU9uuUu8GCRbaYNca3Bk=;
 b=SBY0g7CfhL/C7+L6wX9BfvTygyjGXidP5fHCoTDbQB86nFOFnqzwDMaJyQys2ig0wFMYx5PMHUhKazE9KRXXk3C6LJBPmFtgpJ9aexGrWkteGH5I2ftE9IQOkfccMx5wPqpD8QZWD5upubHlN2xaz5zbG9eVzldVjL6IKEVPNaMWv4gvixxCFgJ8pWOJI9QluF5PDGzW+bt02nRyt+GIpzYkbR64m5DVIEdAuzZ86Es2betD/AjJcyfrYN/sUHLukGHWkp5BokhsDAt2ofV2ovLk3gjzvJ/+tsAU19W9MvTKybj+DqesK493aphcXE+M07e4LvM7PfJqg81qSXcBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eBp6PnKZHDvsqKaVz+3ID0WU9uuUu8GCRbaYNca3Bk=;
 b=SxuTVwpQp4nvMnDpQEjdOfOtPc1SJdf7dLPb5R9PF+jfeF1FH7fE/h8GjdTGzDncxpq+uNxRVltLLYZm6I0zTmErpaCSNYNVMsXnIj+GprwOFfiSHydJyw0ijWN1XKUXRbfWi4tqfWUfaKFfXS6hbkLuQJQ/cfuswUnD/maL0JE=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by MWHPR12MB1390.namprd12.prod.outlook.com (2603:10b6:300:12::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sat, 26 Feb
 2022 21:32:13 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::7468:c081:9b06:c7fa]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::7468:c081:9b06:c7fa%4]) with mapi id 15.20.5017.026; Sat, 26 Feb 2022
 21:32:13 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v3 0/3] amdgpu/pm: Implement parallel sysfs_emit solution
 for navi10
Thread-Topic: [PATCH v3 0/3] amdgpu/pm: Implement parallel sysfs_emit solution
 for navi10
Thread-Index: AQHYEnDiE8RekQ98B0G8Ry0zxWlN9KyiRE2AgARHEWo=
Date: Sat, 26 Feb 2022 21:32:13 +0000
Message-ID: <CH0PR12MB53874421D6810B1E213BCA67F03F9@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20220126045441.3891-1-darren.powell@amd.com>
 <CADnq5_M-4qAc94zdNnJacCWdobeXfub7tga9+Zi4MkL2H2=+KA@mail.gmail.com>
In-Reply-To: <CADnq5_M-4qAc94zdNnJacCWdobeXfub7tga9+Zi4MkL2H2=+KA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-26T21:32:13.146Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 9f190999-cbfa-aa45-e04c-64afc0b4f626
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c62c9417-d294-4dfb-dbbe-08d9f96f7442
x-ms-traffictypediagnostic: MWHPR12MB1390:EE_
x-microsoft-antispam-prvs: <MWHPR12MB139076FBE937E31CCC2F68A6F03F9@MWHPR12MB1390.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0aM9tQhE9KcqR+oYgfMflNZY4zxpYd8AKLB105QC9S2AeKMZm/ceCrVlxkusuQFtbTMOFcxXBKzrS0Jlu5aZBDS3NrnYwHZJlTLblSmPT2aQVlBED++aEMarYZp0ctGw1KA1rs7GHxBz5vcuiz8hQcKdEKgAWMXrNKnQv7cP0YFmgEH6XSQtn5M2d97xiY3sEebL2ogNdo1xcwxG+spQg0nf7ADNkKF6/lxBWvORyN/F9wMRJzDLgrkLo3QkQ/cfD3DcrqFPM2Neuf4cmDT+F1s2YTsFJ6WJ713KX5kCl1mFy/xRatKFo7o+V1nZf4YEcMnMsjMaGKrTRKgmYeA4VBrTlR6dPrTHSBdlZ0zbKnEJM6/UwHJ9o3917pDwZcsMRRvaAFF3qovfXbQD5gH0oOOMOd5B1kU7vY9jqD4taT4CWke43OW79UoLbalrXT7JbbOufCT0KGT0C+a/obMDU5bKY+mIood51DJiRqQh6zDSqVAE2pK/YPUDW54OYBRAgscWXutRhIG4VhnBktPEkT5kLvbZtNNGuuL+8w0mDjHU4mffUCXF5L1axLpYM0EvVKveU9HBqcG5VuIrkcdVAR0qcOTGESWd2u/iumQqk+BtG+vN3WFxC3Df2+Ox1s1J7wICKi8+Z9rAha1xKc9KzUP8FVjZP8MBGSzAgMoUyCOX0D+L3a6qZiOzuDk3je0LTRO3hrNGNn0kPayvLCGtlw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(55016003)(33656002)(508600001)(9686003)(86362001)(2906002)(53546011)(6506007)(7696005)(186003)(26005)(38100700002)(66556008)(83380400001)(66446008)(66946007)(122000001)(66476007)(8676002)(91956017)(6916009)(64756008)(76116006)(5660300002)(8936002)(316002)(52536014)(38070700005)(4326008)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tDl8AClEzdfd+rFQh7J3J3Z/f0+glNz7BP/W/kSOByd9VuI+XplgUErnoxwO?=
 =?us-ascii?Q?wVyRnFtSIqbHanLbVbcW0BIbGoGpfhhP3fpVGRbvLXcYkGHCBsNSQzRtyxGY?=
 =?us-ascii?Q?n3xX0Av2UwkFXqartf/YhEIz5NoDX267epWX98ycRo4eJspIzuOsI40JD5v7?=
 =?us-ascii?Q?b0Ot7YaCkwrnvxqZoN3dRSaXPTbqYQgAflrfvFxxSaSY80UC3T4mALlyvXAj?=
 =?us-ascii?Q?5jbFeAdI3urCUh8/hftOqAcx3MFw38cw7snTdAnTw4B+lw7HoANfiYBwYaNm?=
 =?us-ascii?Q?aZ3+qhILK64WAiajUHO/6d6CV8HwrmBsYzUujyjMvNcL29zWKBEiblw3sK2e?=
 =?us-ascii?Q?xqceVKlI5W4wH4p7YKg+fpbTrhyB954rHgiuwUApclU15IWQCxPb/H4mC9qu?=
 =?us-ascii?Q?o7qmyYwZliIfvkEqfjfdclYii4NPyNFrlQlL6kkdGVPvtJxmS1a4fTADCR2z?=
 =?us-ascii?Q?wzFPFxudzeW27XRHFSeSUB8JpQkBRR/KtM3MVuQrbVmZEoEBWMRrzfC3Zoqx?=
 =?us-ascii?Q?1+ZpMLIxzB8CVdumXW0l4NgjUE1FoQ0PqCqD1fjP0fK3IA7RXX2WWgeKfncX?=
 =?us-ascii?Q?1vrb2rIdOK9jWdEXiD9RAy0WBqbSEKVtZmd3GddGMxTFFuyb56+34RwGZf46?=
 =?us-ascii?Q?5pxySWMKh5laN/b/6zL4qaOt83WaeuJ7voGuFI7FJLP0pdypXb2GUG/kYUgd?=
 =?us-ascii?Q?5Et2bvwwE37LOPvuMxmsntqrHju8BN9O5BX3btBO4SorJ6UvqLwbyMAIiqpv?=
 =?us-ascii?Q?gUGNAtb36koCQbXlOfuX9ph/qzGykud7kAhBB+HLf3PvxkUe380LW9ZxmZr4?=
 =?us-ascii?Q?0775xrN8vYC0AFp0ZVuzTP7HjEDIGK9SqiERxuQFRuiktyqq0vRo6gqNvETZ?=
 =?us-ascii?Q?4o8LzagFBbquw1Ka138ijvxyswH5QcTpe8gjhqJqteAcw+ZVd1h3hn7KFy2F?=
 =?us-ascii?Q?6GV5JCBT+wPcrkOA1g62WkubRFepUqUyhKz5h9tFK0cAjz5RWR/MQ/fyAZ5D?=
 =?us-ascii?Q?eAidt6LDPZWXGg/gCfRSgd5SfldWZgElpPpDAt8VwRfwVLhyiUw3qUHtSLdt?=
 =?us-ascii?Q?qDPeW+13/Oh4BAGZPvweSdk0JhRCrE+4ZUTuQetIznmKie5yJ3ZY3M3nKa3N?=
 =?us-ascii?Q?HKAHH1pDFUJ402VRSc0dSafhoyArOUN2IrkQFdW+vviB8WhdmhKfUQny/Cqo?=
 =?us-ascii?Q?lZ7R48W7cBCpkAIOfiJUH0Q0qBezchSVnG+IUCAKgXi6bpbdsQxVNDu+1CK8?=
 =?us-ascii?Q?hyILP0zee26GsVfbak1Fa3fzMb0wxadzGtgLMEAdg0OkJUHXwUwDl07qy3Fl?=
 =?us-ascii?Q?ILYC/Xj7bKCqsbEQoVN93MIkPPhOkBmaEnbLGUO2pg9PuZJ6+B1HG6J8ABGN?=
 =?us-ascii?Q?HpYx5/YuFTYCC212DrM1zV6H7jZ9QCMPOSw963pOD3EX4qPno0dTc7GFrUl+?=
 =?us-ascii?Q?gKfGS0iY/B9aou4sageYDNScOT0muA8eLGn0HGPquxS7jYUyLNpgNSpt/MMI?=
 =?us-ascii?Q?SAuZoF5mIT05O1u0Uu2C/RxMpi6Zn1vT1mQmlFG2ZjmUQDmfhSX7+Mcmzs3j?=
 =?us-ascii?Q?QSB2AGl88qo0NriZpm3A4ypd+tZPkRVzfwa4sMELmagQc6v6vmZt6Y8Adgl+?=
 =?us-ascii?Q?IHPewB90MpR0Ao+znHfueSg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB53874421D6810B1E213BCA67F03F9CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62c9417-d294-4dfb-dbbe-08d9f96f7442
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2022 21:32:13.5142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBF76+l1hr2hPFooH97ed9Eh3/p9dXsLPWzoo+SRG5HICo7QlCGOOHiTYgsTA3qdcFdAHozJo+IMA1rs0/nr7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1390
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB53874421D6810B1E213BCA67F03F9CH0PR12MB5387namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Plan is to now commence with VEGA20 implementation and then continue to tra=
nsfer other platforms after that patch is RB'd
Thanks
Darren
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Wednesday, February 23, 2022 11:11 PM
To: Powell, Darren <Darren.Powell@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 0/3] amdgpu/pm: Implement parallel sysfs_emit soluti=
on for navi10

On Tue, Jan 25, 2022 at 11:55 PM Darren Powell <darren.powell@amd.com> wrot=
e:
>
> =3D=3D Description =3D=3D
> Scnprintf use within the kernel is not recommended, but simple sysfs_emit=
 replacement has
> not been successful due to the page alignment requirement of the function=
. This patch
> set implements a new api "emit_clock_levels" to facilitate passing both t=
he base and
> offset to the device rather than just the write pointer.
> This patch is only implemented for navi10 for some clocks to seek comment=
 on the
> implementation before extending the implementation to other clock values =
and devices.

Were you planning to extend this to other asics?

Alex

>
> Needs to be verified on a platform that supports the overclocking
>
>    (v3)
>      Rewrote patchset to order patches as (API, hw impl, usecase)
>    (v2)
>       Update to apply on commit 801771de03
>       adjust printing of empty carriage return only if size =3D=3D 0
>       change return from amdgpu_dpm_emit_clock_levels if emit_clock_level=
s not found
>
> =3D=3D Patch Summary =3D=3D
>    linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next =
@ 28907fd9e048
>     + f3c1d971ea17 amdgpu/pm: Implement new API function "emit" that acce=
pts buffer base and write offset
>     + c67ac3384682 amdgpu/pm: Implemention of emit_clk_levels for navi10 =
that accepts buffer base and write offset
>     + 734cca28fed3 amdgpu/pm: Linked emit_clock_levels to use cases amdgp=
u_get_pp_{dpm_clock,od_clk_voltage}
>
> =3D=3D System Summary =3D=3D
>  * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
>   + ISO(Ubuntu 20.04.3 LTS)
>   + Kernel(5.13.0-fdoagd5f-20220112-g28907fd9e0)
>
> =3D=3D Test =3D=3D
> LOGFILE=3Dpp_clk.test.log
> AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
> AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{p=
rint $9}'`
> HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}
>
> lspci -nn | grep "VGA\|Display"  > $LOGFILE
> FILES=3D"pp_od_clk_voltage
> pp_dpm_sclk
> pp_dpm_mclk
> pp_dpm_pcie
> pp_dpm_socclk
> pp_dpm_fclk
> pp_dpm_dcefclk
> pp_dpm_vclk
> pp_dpm_dclk "
>
> for f in $FILES
> do
>   echo =3D=3D=3D $f =3D=3D=3D >> $LOGFILE
>   cat $HWMON_DIR/device/$f >> $LOGFILE
> done
> cat $LOGFILE
>
> Darren Powell (3):
>   amdgpu/pm: Implement new API function "emit" that accepts buffer base
>     and write offset
>   amdgpu/pm: Implemention of emit_clk_levels for navi10 that accepts
>     buffer base and write offset
>   amdgpu/pm: Linked emit_clock_levels to use cases
>     amdgpu_get_pp_{dpm_clock,od_clk_voltage}
>
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  21 ++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  49 +++--
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  42 +++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  14 ++
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 188 ++++++++++++++++++
>  7 files changed, 300 insertions(+), 19 deletions(-)
>
>
> base-commit: 28907fd9e04859fab86a143271d29ff0ff043154
> --
> 2.34.1
>

--_000_CH0PR12MB53874421D6810B1E213BCA67F03F9CH0PR12MB5387namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
Plan is to now commence with VEGA20 implementation and then continue to tra=
nsfer other platforms after that patch is RB'd</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Darren</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, February 23, 2022 11:11 PM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH v3 0/3] amdgpu/pm: Implement parallel sysfs_emit=
 solution for navi10</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Jan 25, 2022 at 11:55 PM Darren Powell &lt=
;darren.powell@amd.com&gt; wrote:<br>
&gt;<br>
&gt; =3D=3D Description =3D=3D<br>
&gt; Scnprintf use within the kernel is not recommended, but simple sysfs_e=
mit replacement has<br>
&gt; not been successful due to the page alignment requirement of the funct=
ion. This patch<br>
&gt; set implements a new api &quot;emit_clock_levels&quot; to facilitate p=
assing both the base and<br>
&gt; offset to the device rather than just the write pointer.<br>
&gt; This patch is only implemented for navi10 for some clocks to seek comm=
ent on the<br>
&gt; implementation before extending the implementation to other clock valu=
es and devices.<br>
<br>
Were you planning to extend this to other asics?<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Needs to be verified on a platform that supports the overclocking<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp; (v3)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rewrote patchset to order patches as (AP=
I, hw impl, usecase)<br>
&gt;&nbsp;&nbsp;&nbsp; (v2)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Update to apply on commit 801771de=
03<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adjust printing of empty carriage =
return only if size =3D=3D 0<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; change return from amdgpu_dpm_emit=
_clock_levels if emit_clock_levels not found<br>
&gt;<br>
&gt; =3D=3D Patch Summary =3D=3D<br>
&gt;&nbsp;&nbsp;&nbsp; linux: (git@gitlab.freedesktop.org:agd5f) origin/amd=
-staging-drm-next @ 28907fd9e048<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + f3c1d971ea17 amdgpu/pm: Implement new API fu=
nction &quot;emit&quot; that accepts buffer base and write offset<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + c67ac3384682 amdgpu/pm: Implemention of emit=
_clk_levels for navi10 that accepts buffer base and write offset<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; + 734cca28fed3 amdgpu/pm: Linked emit_clock_le=
vels to use cases amdgpu_get_pp_{dpm_clock,od_clk_voltage}<br>
&gt;<br>
&gt; =3D=3D System Summary =3D=3D<br>
&gt;&nbsp; * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)<br>
&gt;&nbsp;&nbsp; + ISO(Ubuntu 20.04.3 LTS)<br>
&gt;&nbsp;&nbsp; + Kernel(5.13.0-fdoagd5f-20220112-g28907fd9e0)<br>
&gt;<br>
&gt; =3D=3D Test =3D=3D<br>
&gt; LOGFILE=3Dpp_clk.test.log<br>
&gt; AMDGPU_PCI_ADDR=3D`lspci -nn | grep &quot;VGA\|Display&quot; | cut -d =
&quot; &quot; -f 1`<br>
&gt; AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk =
'{print $9}'`<br>
&gt; HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}<br>
&gt;<br>
&gt; lspci -nn | grep &quot;VGA\|Display&quot;&nbsp; &gt; $LOGFILE<br>
&gt; FILES=3D&quot;pp_od_clk_voltage<br>
&gt; pp_dpm_sclk<br>
&gt; pp_dpm_mclk<br>
&gt; pp_dpm_pcie<br>
&gt; pp_dpm_socclk<br>
&gt; pp_dpm_fclk<br>
&gt; pp_dpm_dcefclk<br>
&gt; pp_dpm_vclk<br>
&gt; pp_dpm_dclk &quot;<br>
&gt;<br>
&gt; for f in $FILES<br>
&gt; do<br>
&gt;&nbsp;&nbsp; echo =3D=3D=3D $f =3D=3D=3D &gt;&gt; $LOGFILE<br>
&gt;&nbsp;&nbsp; cat $HWMON_DIR/device/$f &gt;&gt; $LOGFILE<br>
&gt; done<br>
&gt; cat $LOGFILE<br>
&gt;<br>
&gt; Darren Powell (3):<br>
&gt;&nbsp;&nbsp; amdgpu/pm: Implement new API function &quot;emit&quot; tha=
t accepts buffer base<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; and write offset<br>
&gt;&nbsp;&nbsp; amdgpu/pm: Implemention of emit_clk_levels for navi10 that=
 accepts<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; buffer base and write offset<br>
&gt;&nbsp;&nbsp; amdgpu/pm: Linked emit_clock_levels to use cases<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_{dpm_clock,od_clk_voltage}<br>
&gt;<br>
&gt;&nbsp; .../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_dpm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 21 ++<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 49 +++--<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 4 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 42 +++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nbsp; 14 ++<br>
&gt;&nbsp; .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp; | 188 ++=
++++++++++++++++<br>
&gt;&nbsp; 7 files changed, 300 insertions(+), 19 deletions(-)<br>
&gt;<br>
&gt;<br>
&gt; base-commit: 28907fd9e04859fab86a143271d29ff0ff043154<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB53874421D6810B1E213BCA67F03F9CH0PR12MB5387namp_--
