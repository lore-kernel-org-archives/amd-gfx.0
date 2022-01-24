Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B049C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 03:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AAD710E362;
	Mon, 24 Jan 2022 03:01:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B5210E362
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 03:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfbKBUfl2EhPV/fbhmY2mZVu9nb5BrAG7XZ9g6Bv8gQm7tILB6ZC0Xb1s+kBMsaK8/brmLRxPBkz6e8NLv3IMtGnBanIif/xkXtmfcJSSrTt+MlG23x9fOjPEqKcWANU+tA38bUBQmiGXXNIH6w4XoiUQbV7roabp5oR6p6+wj+tP+yxYKzmOHJ1R7bIvaNDlhbNTRUj3tCkAQXPJOufRAQL7IP7/tAlxrpWK2xqPhCJtB22UR7AR+MPdT3t2AVlqmNNKlKQu7IceRPIHXXKLAsv/tKnWHQsA5muSxxy+kN7fIicrvcFSR14D0qFTcgxfsdgDZDFhYQcf4iLbTTftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsG/ONcj8yOVvzQv3VlQ+zMG+cFd4H4cAUNgm06rLhQ=;
 b=E4ni1CaWyUMnDnT0dqwR/lXcpv8kpKqUtIAB9BY8hdW0hXlyPWFq8g7knnFvBDczMxt7XwpLDT7smKxHyfQigi4vdacU8mojEB33G3q8kXBKt+5kEGUyq0BIpuSPVkax1ceH7krxriFJuH+S2Qx/FzXXhrfGti0QSLPhl7aDUq6YQp2feimkHDowkveWwQ7Dy/0yRE6xEXSaEH/hyEeDPYkNZVpA41lH+vPV9U9XO2cjR7NeVBrvJ6npHiU6bgHytqZvypTE7IMCrWBvmGYVe5V9WI0sOuuY+dZahd2Ug57mLwEGqFcW3zpIIgX5w7oHGN16l8i9rzAcO638PPgNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsG/ONcj8yOVvzQv3VlQ+zMG+cFd4H4cAUNgm06rLhQ=;
 b=0lVJRyj+IcTPTCqmVyPX7wRonZmExKY0ycSL+VIL+HYS2IUIqXvLyMehyHexV0krj/bZ/n00gleus44+laeW1Y06T+V7nvuecPRwx1Orq8VvA8V6afrVURxLTG+ZJEghr3JKQRtP4LYO6FO7Bfoz65EpKQIwdgzsz1kCgLnv1NA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Mon, 24 Jan 2022 03:01:52 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 03:01:52 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 0/3] Implement parallel sysfs_emit solution for navi10
Thread-Topic: [PATCH v2 0/3] Implement parallel sysfs_emit solution for navi10
Thread-Index: AQHYD0K/7V84ROxCoEOnoc8a1KkSBqxxfr8g
Date: Mon, 24 Jan 2022 03:01:52 +0000
Message-ID: <DM6PR12MB2619A05A37572E5675E69578E45E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220122034647.67925-1-darren.powell@amd.com>
In-Reply-To: <20220122034647.67925-1-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-24T03:01:49Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ec7bf38d-0a46-4ff8-b3da-4d8d1d9f8cde;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f7d4dce-d1a6-48a8-dd6e-08d9dee5df13
x-ms-traffictypediagnostic: DM6PR12MB3914:EE_
x-microsoft-antispam-prvs: <DM6PR12MB39143BFFB63B1C81D80647D1E45E9@DM6PR12MB3914.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:343;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qc5X/wRfmSdPBKv7Ti/kbAPr/X06IJa5NwoycPwBYa3FOie+vZaBDaYYblnR2h+C0DgYpV2oMTwgNDHdO5EpJHVal72wUDoDIZ5ZOxwNh5yWUJ3Aq1dtfxXKvYUYCCILQnJ2S6h3fwaeY3djX0G/I0qhtwM4hKX5oLzd3kXQqB/UXE8qVXjhL8IwrzU0UsXeYD3uQbYkgD97v1p6eZFlkHZUeEzWRNPj6rKT3ETpIAhMWzcxC2GlpO//ljdtbhs/BQMkYqW74g1ZG6LzWumwNbHG4+lwWruUYYthLbtRnuPG/HpRVlf3VZ12SSf7fsGKKJHUy+cmarEX+HMgI9W9Z/hh23Sydf28muK1+fTXU9GkcuITXV2rwpTvsL0XvoQ0CJZZgbPLAGsFT5XzsHU0jQtbjg7LBHRVf77QnPw/+zVRH/au7ofWRFjBV3mdLn4HHS//iXPYMpwz4Cs+o2o5mIxWoERnb3VEzqm0f1K4PY1oB5KlYyDdL+BP95t0b5nAXhvl7KoprqAk0TmNXttN/+FZV7J5xWWg01gwkv4tqSwCZ94x2ucC+PQLL+JjcMr7HKbaX/jAHEeOiUZWpPF/zRpXO8hcOOwFcJKO4F8o7RV1oPAbNyK/tcPtSwo/HJgcILEF/RvfAoIJ/I65D13Cu+UMyMjpHdgCryUG9kaKnQLUbLEPVE4xcZkgL84p3JuI+IeMq6DgpJYOKvJIe45shw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(76116006)(38070700005)(9686003)(53546011)(7696005)(33656002)(66946007)(66556008)(186003)(66446008)(5660300002)(66476007)(38100700002)(64756008)(110136005)(55016003)(8936002)(316002)(508600001)(122000001)(8676002)(2906002)(83380400001)(6506007)(71200400001)(52536014)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zIajx7hisZJKZWgFASCLLYjYca/z2eWvQ6ckNnHaRayJZ5dutZexAYlRbNSu?=
 =?us-ascii?Q?2+92wAHCfSv/OTsObUbfn9CErDdbJL66FR8DnZ+ZuK/R2l58g+7NofOCFqbW?=
 =?us-ascii?Q?o+lWOUTpf4aHJClWoRhdhTkZpuHXV+liEuQJpIt/ZsMbznZtGs3w+soSwS3E?=
 =?us-ascii?Q?bK3fP2jIXeGZasT2CKa53tZ0IRmWYD4Z93TmNekG/JXbCnaKNap7KDcCpncl?=
 =?us-ascii?Q?ILbUr0h+Rmuc4uRUarClnCNUJJgI9/0BvlJz8XELcF5ynSwscWrHRLxnQic5?=
 =?us-ascii?Q?Qub+cq3vhMbjma1cVttc5aMKYhOUI0QcmamWzQFqjhlYYAJmjZNNaJTjuxFX?=
 =?us-ascii?Q?LCKAXdpQsCqqEZyf2pMJlMBwCPKbOqJXSjrRp2OBsw/E7brtsQwkRacOaTb9?=
 =?us-ascii?Q?o4WjrKebePGCyaeDptM3Wxo/CaYVovL6R/fRGU74XcD2Z0E9anl9ryZOn6gs?=
 =?us-ascii?Q?rmxhBEUpQdFe72YZ+sPGDlpSArx2w89XM8x6hYFGHPNEecGHrbak1q/WLe5N?=
 =?us-ascii?Q?ez4Z/UPIHzGrAUu5MSYa33VCIHx/67iOeDn37/sOSTow7vqpGX2vVRLq9WXF?=
 =?us-ascii?Q?QfBw1p+bvdnhxGkgaAwwNe4Tb4sTizG4G4ys4aYgHKH7ZXy2tL5pcw+GvGxH?=
 =?us-ascii?Q?J1CAPgcl/BfAA6YXBOu26YzfdONG1aGbax9aB4e+fR5Og4Y7xciLvrb6ahs4?=
 =?us-ascii?Q?UgxR/6xDGWYj+nZENuK1OpqX7sw3lAbB/C5SuI7JlGn8CYd5ZDmXkUZxX0tz?=
 =?us-ascii?Q?ARIvYWHY9cwRRe0+YXtju4wdHIsmyEpMcK3Tijrnfe/Rvi+525u+Wmbo27mu?=
 =?us-ascii?Q?cEGPmSauVKptT9R+lEoUxc1KZpMkoKPFrrleIrPNE1YChVahHbXQ0SfgfNvM?=
 =?us-ascii?Q?vpcVS/X0GQ9Vjwbdhf2aBDIwR7F1tOdkfRKQjNbDC7Vs5Fz1/qmB/gGTiYK8?=
 =?us-ascii?Q?4adILR3GST2Xrw599RSLduAmCKIhe7wYBdeY3A5b2/z+AZYljpAYln57zHjZ?=
 =?us-ascii?Q?DHe4EJRl4pIcdbDQ4vkAB3AksKYgRfylAr+hWYdv78H17RIkHibJKoJH+XB8?=
 =?us-ascii?Q?I5if3Lk10+uCOu3BUtQTszvBVghpEd0cbJoVE/QtHhbzmVpjiorjCkOqzrs3?=
 =?us-ascii?Q?48aqhHxsO8BLt4wSKy6k5MrJWLAz1OSi8nmvOQO3PSBDHishf8w1Oej40NVk?=
 =?us-ascii?Q?4L+ZTRBbMUSTqEBNPbdBWT5/gZt5FjImJGg4SOm0Xj6zMfDmM/4Ho+x8zxd9?=
 =?us-ascii?Q?j/BUH243/mn4Dk/JTi5TAJk/cy0a5CCkpz0abfIEBXILxiBM47w9drcgBD5X?=
 =?us-ascii?Q?abLRiryOYVr7FGXJjR1BlwMJP/ZsjOJwMQqwWaNqj0fVe3XsBXkO/gcs1e0j?=
 =?us-ascii?Q?uS7oH13F8rHfJ6urqvXR3cSq4NjiWBHsvlwrvSpPr6P5VkzkXdRdT2nA2qyd?=
 =?us-ascii?Q?K1VKUn4kw9eQmzcOU8RiZ6sFdbrGZuK1wRX3Kg0HI7OuI/uDZMANyJ8PSzEQ?=
 =?us-ascii?Q?QkcQqW1XGjUK8Sl1LNKT7enYWCSkWI0lsYClrBiA9VQKJAfLTmtjwSZgzoXI?=
 =?us-ascii?Q?pak+cslqDFOJ5dPUuW8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7d4dce-d1a6-48a8-dd6e-08d9dee5df13
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 03:01:52.0821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gisphK/FxLWMg7CmP521yompPnt52RZ+kRkgHuTKkuccEQYhFhmlE/1uzhyuFJ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3914
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

[AMD Official Use Only]

The whole idea seems fine to me. Just some nitpicks for patch1 and patch3.

BR
Evan
> -----Original Message-----
> From: Powell, Darren <Darren.Powell@amd.com>
> Sent: Saturday, January 22, 2022 11:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Powell, Darren <Darren.Powell@amd.com>
> Subject: [PATCH v2 0/3] Implement parallel sysfs_emit solution for navi10
>=20
> =3D=3D Description =3D=3D
> Scnprintf use within the kernel is not recommended, but simple sysfs_emit
> replacement has not been successful due to the page alignment
> requirement of the function. This patch set implements a new api
> "emit_clock_levels" to facilitate passing both the base and offset to the
> device rather than just the write pointer.
> This patch is only implemented for navi10 for some clocks to seek comment
> on the implementation before extending the implementation to other clock
> values and devices.
>=20
> Needs to be verified on a platform that supports the overclocking
>=20
>    (v2)
>       Update to apply on commit 801771de03
>       adjust printing of empty carriage return only if size =3D=3D 0
>       change return from amdgpu_dpm_emit_clock_levels if emit_clock_level=
s
> not found
>=20
> =3D=3D Patch Summary =3D=3D
>    linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next =
@
> 28907fd9e048
>     + f83a3144ede4 amdgpu/pm: Implement new API function "emit" that
> accepts buffer base and write offset
>     + 82de36426a1f amdgpu/pm: insert attempt to call emit_clock_levels in=
to
> amdgpu_get_pp_od_clk_voltage
>     + 32f0fcf45dd8 amdgpu/pm: Add Error Handling to emit_clocks stack
>=20
> =3D=3D System Summary =3D=3D
>  * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
>   + ISO(Ubuntu 20.04.3 LTS)
>   + Kernel(5.13.0-fdoagd5f-20220112-g28907fd9e0)
>=20
> =3D=3D Test =3D=3D
> LOGFILE=3Dpp_clk.test.log
> AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
> AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR |
> awk '{print $9}'` HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}
>=20
> lspci -nn | grep "VGA\|Display"  > $LOGFILE FILES=3D"pp_od_clk_voltage
> pp_dpm_sclk pp_dpm_mclk pp_dpm_pcie pp_dpm_socclk pp_dpm_fclk
> pp_dpm_dcefclk pp_dpm_vclk pp_dpm_dclk "
>=20
> for f in $FILES
> do
>   echo =3D=3D=3D $f =3D=3D=3D >> $LOGFILE
>   cat $HWMON_DIR/device/$f >> $LOGFILE
> done
> cat $LOGFILE
>=20
> Darren Powell (3):
>   amdgpu/pm: Implement new API function "emit" that accepts buffer base
>     and write offset
>   amdgpu/pm: insert attempt to call emit_clock_levels into
>     amdgpu_get_pp_od_clk_voltage
>   amdgpu/pm: Add Error Handling to emit_clocks stack
>=20
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  21 ++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  49 +++--
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  44 +++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  14 ++
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 188
> ++++++++++++++++++
>  7 files changed, 302 insertions(+), 19 deletions(-)
>=20
>=20
> base-commit: 28907fd9e04859fab86a143271d29ff0ff043154
> --
> 2.34.1
