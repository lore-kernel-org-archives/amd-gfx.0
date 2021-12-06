Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4555C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC6573E29;
	Mon,  6 Dec 2021 10:20:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D5E73893
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 01:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVusq5jpEz1/lPxT4tsTxLv4MMHm8FbMaJnlsWt1j9cqRSTwkfYiB/7iYGE8DTi6Vv5xOa3MTvGbZZLvxV+9Butnom1cnUDboGA9BpIADYSnD50TeAqUErPm1rrwt+3OVTxgkuUoEZlvU5Z0dDXjhzqgdCYnYCkTPAYDUEzt//Egzk6ORImg9z21/vHn2ql1DxPtc4u71LuWD+lRPVabDBk+OtM3VLFpda/15zcqzdJikyFrHv0hV3Pz0MnZ0RAvGBb+XaY4Y3wXJi/V0ArLS8GZo4VPLBQPHFyju/Opp33fPdwAE4iVe2DLDdBN5mtcgFD81JzZbf9EsE5oplrB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B+wzPiloDJfmlB6LcBSR67lw+DtHN//wvxmzyDD/Kk=;
 b=nTtYHodRXB5E8j49D45+0BpmvqZNIpshHo7XTOBVQLtT3lxt0jFKlGFs7VhBTRfoPn72Tu+KZz29wqHe8NuqO2wk3TmoVPfFLm68BPeWNEKemlbPUu5MZaURhe2f3IESVkaiMfOxxhuOipIHJqnNMCURGudIXZOGA8U+vq+ylYDG2B9BIBSidBlHyPyAduP2sAE5Slcn5Qs37fg4Fz2+9bOnom9NFUrSfnTc2ppd3gipOomcTuhHPRIbcOKp4wc9g9aZxt/Js4iqfzAzR5uzEvpDnnrixiAxJLD0P99iSgSKpJ+d4cz5U7NJ/d48lFo0YwW6JUDe1iocuW1THdiIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B+wzPiloDJfmlB6LcBSR67lw+DtHN//wvxmzyDD/Kk=;
 b=u1Gybm017HlZeGSyTrCsuhC8FQYjrqcCAxi8vE60Hz2DhIt36GhSmQSHibAxoS4yTvemhckW8z52m7de9Y0/rBJiP9mD2W/tpEZ4CHujkEF3DCK7Wqplsn65tLgRFW8qHsGWa6RyDqhWTK4KCGcCCvv3EmenVqPn7jzaXzymoXk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Mon, 6 Dec 2021 01:36:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 01:36:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
Thread-Topic: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
Thread-Index: AQHX57YVpe0h3uZndEy7AC4QAkuQQ6wkrmUQ
Date: Mon, 6 Dec 2021 01:36:14 +0000
Message-ID: <DM6PR12MB26193B71B3FD2AFF84C3D45AE46D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211202191912.6148-1-alexander.deucher@amd.com>
In-Reply-To: <20211202191912.6148-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T01:36:10Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=def25975-1cb1-4bf7-bb66-81224c096d25;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b932464-7789-4995-6641-08d9b858ca87
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-microsoft-antispam-prvs: <DM6PR12MB2891A9F8BD21A5BE80ED9F73E46D9@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ib1w4KqfNFAPo73ak7mAGrE9UeQP+b8wliD8vwHJC1XrqsAASfNFwtWw3oE8HBzxtWnI/3KrYr24mnk2ZUX4lFTAbj0bhUWdzYM2rFgaILGdzb7uhK2/nTSb/3KJS2gQwOASPIoeppzP+GXWslVi4BDuTii8xAFpq4/efgTL9O7mNQOW+pzQw++89eLfsfL7DkgumPpnAR7UPlp1rEXl4ORlx36P7UtBed9z6PAf4STYWTDxKpq4ZmcTBbqjhAyXyDbX4gBKxWXNpN+oMxA2QBXVc5ICuuqBKN2b+z0AjVXnosrbBqFLWd4yMRBD+ZBytDz95dOB7jWvMQt2LGJFOft6gH1/6jFfbqMLrxdOWotk0Oydj28HaGxhssQPxTYzmFQ3d6NK+De7fCZ7mtvpR8RE3lKxayKQXcCfgmlmLHsispR7rlLrlmwVXURCze1zljKeyeaVVr7/pP4h1hULwHIw8I2dxOEOhj5MfSZBvBTu2jXGNgiB813bEnfRs0YmWH7SKXuqRLhIfRwJ5dL1XDmCvm6kbmML6VzFPHJKsJ54l2w+ZwpjUZve1fSRnu8bGcLL7VKtBPF2tZDkdL5Umtsq58B2+YlZ+gmW8Jgpj6UoxBZa+BkQHi4drBQXErZJJsplH02ajbvadgbDeyvJxmNilRLK8OFRceRLccLol8yht58S864PfB8QFhm6cJ8adrWgmn8gyaCjvObP8AtEIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(30864003)(66446008)(86362001)(64756008)(38100700002)(122000001)(6506007)(26005)(8676002)(66556008)(53546011)(186003)(66946007)(76116006)(66476007)(33656002)(508600001)(5660300002)(316002)(71200400001)(2906002)(4326008)(8936002)(52536014)(9686003)(7696005)(55016003)(83380400001)(38070700005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vdUH4Q6gGDDOKpbEzkY81GjhsF3EAE4qUJ69K18xQfSES6e3o+yKtTrr+u++?=
 =?us-ascii?Q?LToPBE3TTNB1BaFnhGGTxsu4b6EIYi6PiRlvgZizABp4YMlVUxXjhsGNqKkW?=
 =?us-ascii?Q?cAiyL6F07vm/Ety8ARsaNiBhxk3gCPFnXsVWDeLLUpYz7zRcJQ8b9FqjLaw7?=
 =?us-ascii?Q?spo9YhskFPWfihO/KNF1R2EVq2yY/AZgP1UE+zNE2V9DA0bJrdp6GpajKLVu?=
 =?us-ascii?Q?JaUTNRTnbzZOix/1kMdrjVk8j5jlt3yMU1sds4nhjskZHfmNlDpMb6XIgig8?=
 =?us-ascii?Q?MuYiP0DEee3dFKeh3p58nk/0EcF7fp06vbWFGWgcpR0LaDM/SHn+C8vMA7r/?=
 =?us-ascii?Q?no0kSz0Zf/i1xZxvD/WJ4/goBGHzwRQy8CZwzXnQEJY2yCCwTh3b3hNKSZ/S?=
 =?us-ascii?Q?15psiiRo9Kv00grgNboOGc7K2emR5aW1BVsNVAA1gqusaIN1EdUhTvTL9ipr?=
 =?us-ascii?Q?c3DqRD783ToS1qkGxTGPjvHWsEgfj/e5Qpd0TLf7LbihmGoXZL8hA+ppQt/a?=
 =?us-ascii?Q?wHA20Pamr3pPcYfrlSeXexX4MmNLFfhq+2ai7fV3U/L0lkgjNfRb3ImBdTFa?=
 =?us-ascii?Q?g0Wu+/iJ+czrHqRAKtfZyOVvMJLOK7o8gY3iKkxRQafdbll2rzb+5xGS6NGt?=
 =?us-ascii?Q?1WYFehSawbLkE0bsCrVDpOMdK/JOWydk5t3PTrpKoiKWypzZnN+eqiF8kml4?=
 =?us-ascii?Q?yqERcLP/p+X0ZLZKU6iNprFNyaD+s9F3Ew1tPm51Ufux9Y6P1saqTSEKUmVC?=
 =?us-ascii?Q?JFm8mbLsF3k9pmuq3BU5CnzF4boCYjKgNXMScVF5vPYuMSgn3AubdqCz4CUU?=
 =?us-ascii?Q?vgXsvD+mt+KIyHSx9BdvfIu3bmqs4/Ff9Ov/49Gh8laU1LvZJILfMNi05SBn?=
 =?us-ascii?Q?g6OiiAT6Kyka2Tp0pfvzY0GBLZ4biUQn10qnOTMo776Y8S31EWF2qIOkrAto?=
 =?us-ascii?Q?6xvaL38EXguFJfa2PcwB2kSbaN7+f3k7y7505MlM/PQblcJqZ4u2GLuyNOFm?=
 =?us-ascii?Q?jkgZzPeArzsbwlOAJgi8RlIfNJ2I9bbBG7IBtfwR6jqQt+Cw0EHXl7F5JkEX?=
 =?us-ascii?Q?M+PFDbkXciaE+KRNOuK36p4o76xZmlq0uhPwixE8U6tYNh4U1j+Biphu/E7k?=
 =?us-ascii?Q?VsAu6K+Ai8cItH1IjcE5jmafm/nkVLs01OkgEFywD+x7DsXvJMoG8goWGicN?=
 =?us-ascii?Q?EAbmagagVlPzfi4w/qLDbKPePTphyqpFWf6alnyQ//fxRhQ+2lrTZj77QNb2?=
 =?us-ascii?Q?HMUaMf+CgkfdG8LRUCr6l5kHZ3g6pbGNp7J542NbbS/Ms5OHSSOO41UUUU5h?=
 =?us-ascii?Q?Z7erkAsgwOi16wldxrzx6gPUTWiBXlcCjeoAgKptaPb4nOtRcPLFH3wR4M98?=
 =?us-ascii?Q?1NIK0NRGFCxNuS155RiTmXp7s9mn5ttE5UReASqxatKhD+PnLT07k2ffJqQw?=
 =?us-ascii?Q?GaW3HEKWaJ9CurtmG77KYvVc5tr+v8VrhBDDuw27HybkvEjHCLyqcNCOdmtT?=
 =?us-ascii?Q?gh3PmeQfM6+dRifcRzXrHqyatDy404KVOqJQtGsgVx/WkIPeWvjFdnL4387L?=
 =?us-ascii?Q?nWNC9kVugVTWmbuyQRg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b932464-7789-4995-6641-08d9b858ca87
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 01:36:14.2800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d00qXdL3XugVbA0FN6k0oi2jt8zFXK/ratWVIFiKZ4ahFZYxDqrQZ4axfX86vQCK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, December 3, 2021 3:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
>=20
> This adds a new IOCTL currently used to implement querying
> and setting the stable power state for GPU profiling.  The
> stable pstates use fixed clocks and disable certain power
> features in order to get accurate pipeline profiling.
>=20
> Currently this is handled via sysfs, and that is still
> available, but this makes it easier for applications
> to utilize.  Note that the power state is global so
> setting it will affect all applications.  There are currently
> no checks in place to prevent multiple applications from
> using this interface, but it doesn't make sense to do
> profiling while you have multiple applications running in the
> first place, so it's up to the user to ensure this in order
> to get good results.
>=20
> This patch add an interface to query what profiling mode is
> currently active and to set enable a profiling mode.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112
> ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
>  include/uapi/drm/amdgpu_drm.h               |  28 +++++
>  5 files changed, 173 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 7fedbb725e17..4cf5bf637a9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o
> amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o
> amdgpu_rap.o \
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o
> \
> -	amdgpu_eeprom.o amdgpu_mca.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
>=20
>  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index bc1355c6248d..0e27f9673f8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -46,6 +46,7 @@
>  #include "amdgpu_sched.h"
>  #include "amdgpu_fdinfo.h"
>  #include "amdgpu_amdkfd.h"
> +#include "amdgpu_profile.h"
>=20
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xgmi.h"
> @@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D
> {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl,
> DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl,
> DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR,
> amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl,
> DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>=20
>  static const struct drm_driver amdgpu_kms_driver =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> new file mode 100644
> index 000000000000..94fe408e810f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> @@ -0,0 +1,112 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <drm/amdgpu_drm.h>
> +#include "amdgpu.h"
> +
> +/**
> + * amdgpu_profile_ioctl - Manages settings for profiling.
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_vm
> + * @filp: drm file pointer
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp)
> +{
> +	union drm_amdgpu_profile *args =3D data;
> +	struct amdgpu_device *adev =3D drm_to_adev(dev);
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +	enum amd_dpm_forced_level current_level, requested_level;
> +	int r;
> +
> +	if (pp_funcs->get_performance_level)
> +		current_level =3D
> amdgpu_dpm_get_performance_level(adev);
> +	else
> +		current_level =3D adev->pm.dpm.forced_level;
> +
> +	switch (args->in.op) {
> +	case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
> +		if (args->in.flags)
> +			return -EINVAL;
> +		switch (current_level) {
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +			args->out.flags =3D
> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD;
> +			break;
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> +			args->out.flags =3D
> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK;
> +			break;
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> +			args->out.flags =3D
> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK;
> +			break;
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> +			args->out.flags =3D
> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK;
> +			break;
> +		default:
> +			args->out.flags =3D
> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE;
> +			break;
> +		}
> +		break;
> +	case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
> +		if (args->in.flags &
> ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK)
> +			return -EINVAL;
> +		switch (args->in.flags &
> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK) {
> +		case
> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
> +			requested_level =3D
> AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
> +			requested_level =3D
> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
> +			break;
> +		case
> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
> +			requested_level =3D
> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
> +			requested_level =3D
> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
> +			requested_level =3D
> AMD_DPM_FORCED_LEVEL_AUTO;
[Quan, Evan] I think the idea(to expose those important power interfaces vi=
a ioctl) is good. Since current pm sysfs way seems less official(more like =
debug purpose).=20
And most users do not even know there is(or how to use) such APIs. Another =
interface I can think of is the power profile mode setting related. As alth=
ough there is more
profile modes(like fullscreen3d, powersaving, vr). Only the "compute" and "=
video" modes get actually used in our driver.

For this specific patch, can you expand it to support like custom profiling=
 mode(manual sclk/mclk setting)?
I know we may need to update other power internal interfaces to get that(cu=
stom profling mode) supported.
But can you update the data structure below to fully prepared for that?=20
Or do you think better to do this when the custom profling mode support is =
really available?

struct drm_amdgpu_profile_in {
	/** AMDGPU_PROFILE_OP_* */
	__u32	op;
	__u32	flags.
              __u32 sclk;    --> e..g when flag & AMDGPU_PROFILE_FLAGS_CUST=
OM_PROFILE, these two members will be valid
             __u32 mclk;    -->
};

BR
Evan
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		if ((current_level !=3D requested_level) && pp_funcs-
> >force_performance_level) {
> +			mutex_lock(&adev->pm.mutex);
> +			r =3D amdgpu_dpm_force_performance_level(adev,
> requested_level);
> +			if (!r)
> +				adev->pm.dpm.forced_level =3D
> requested_level;
> +			mutex_unlock(&adev->pm.mutex);
> +			if (r)
> +				return r;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> new file mode 100644
> index 000000000000..cd1c597bae11
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_PROFILE_H__
> +#define __AMDGPU_PROFILE_H__
> +
> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp);
> +
> +#endif
> diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> index 26e45fc5eb1a..b6edf4a826f9 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -54,6 +54,7 @@ extern "C" {
>  #define DRM_AMDGPU_VM			0x13
>  #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
>  #define DRM_AMDGPU_SCHED		0x15
> +#define DRM_AMDGPU_PROFILE		0x16
>=20
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE
> 	DRM_IOWR(DRM_COMMAND_BASE +
> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP
> 	DRM_IOWR(DRM_COMMAND_BASE +
> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -71,6 +72,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_VM
> 	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union
> drm_amdgpu_vm)
>  #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE
> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE,
> union drm_amdgpu_fence_to_handle)
>  #define DRM_IOCTL_AMDGPU_SCHED
> 	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union
> drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_PROFILE
> 	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILE,
> union drm_amdgpu_profile)
>=20
>  /**
>   * DOC: memory domains
> @@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
>  	struct drm_amdgpu_info_video_codec_info
> codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
>  };
>=20
> +/* profile ioctl */
> +#define AMDGPU_PROFILE_OP_GET_STABLE_PSTATE	1
> +#define AMDGPU_PROFILE_OP_SET_STABLE_PSTATE	2
> +
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK	0xf
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE	0
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD	1
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK	2
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK	3
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK	4
> +
> +struct drm_amdgpu_profile_in {
> +	/** AMDGPU_PROFILE_OP_* */
> +	__u32	op;
> +	__u32	flags;
> +};
> +
> +struct drm_amdgpu_profile_out {
> +	__u64	flags;
> +};
> +
> +union drm_amdgpu_profile {
> +	struct drm_amdgpu_profile_in in;
> +	struct drm_amdgpu_profile_out out;
> +};
> +
>  /*
>   * Supported GPU families
>   */
> --
> 2.31.1
