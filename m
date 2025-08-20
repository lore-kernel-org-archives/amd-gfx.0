Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF383CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 06:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E54F10E69E;
	Wed, 20 Aug 2025 06:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="klXQMntD";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A2B10E69E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 06:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEqjx8fpjTSNEUZt1m4dJRTEqIaJNghGIz53v/d3Gw8Zg+SvJseTSMYrpbBJ0IIwdGQ5u3l7EjfUgT3vN+F/pLhc5TxD7Pl0oTlt6i8vxijzA6ZOQk9V1BLa+6dFs+VqFpc0HA2ddapbMIAwtFI7OaWT2It35S1of3G4WHGfgcMuXYUJtdCJNGv4OjaFwVybuG+fUbznAseNAIP23cy/IouhjJRn2ruHaTMP0YueRZ4sOU1H9HR8kL5/pd5+LP2j4I+gJufp01/51T+YGTstUp6CIhWG5PzOtY7dZfKMq2sF/vRELgMEDUM3Dhv5zTmJJV6XZHVuc+Jb4TX39ie2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0izkU64/z3RmE6sZX0Hb98RGJdZB5pgZYNml12syks=;
 b=FvLr4GPlVuUJ8BOb7ntMFR3208Q0+d67ZPn0nUDvvXuwZQm1o06xy0heh7A0+YUeDGlNKqxDvgxLFvKkFwbiZ9mWj3OqxNkzaxmKA4Wyz6ZcoYx3ereGKg/w/iGNu4gwSzTu8xy39xWhv6BeWeUkdoLowz3lHMu2SgjKOk4k0ygGLeXcaA1Fvyn7NkVJCGUhr632kicJSHTAV31y032LiVYu4zU3rwS4jADCZxDWd5fyjKn/mbTTt6K/02sRs6DRCYZ0+nRbLjz0Dv6xZIgzlatRWK51rmZsb18opNbwVMhQ+z31LEwhibD/MRk7AdTURwkghCUQIY1k/LoXoOC2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0izkU64/z3RmE6sZX0Hb98RGJdZB5pgZYNml12syks=;
 b=klXQMntDsXcQRsXZuOd7FB6ArPIIP3iWkGYwMRmB8jfyXJZrpo9VyHsnpeEdPqbe3SYhUXmFHhSqN0mMr1SpF/iyP+N1/IWTWcw5KeV2ts17A21vW2Lu+crDrg+AwYuTd3nRn29pGvdYUxRzlxFZX64x6E1cloI/xgPn4eLy3Gs=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 06:03:56 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 06:03:56 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Thread-Topic: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Thread-Index: AQHcEX8lTtkjEkLpdk6soTx9Raiu0LRrDTvQ
Date: Wed, 20 Aug 2025 06:03:55 +0000
Message-ID: <PH7PR12MB599700D26DB690DE9A49D51F8233A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250820030400.514460-1-Jesse.Zhang@amd.com>
 <20250820030400.514460-4-Jesse.Zhang@amd.com>
In-Reply-To: <20250820030400.514460-4-Jesse.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-20T06:03:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|LV5PR12MB9753:EE_
x-ms-office365-filtering-correlation-id: 5162fd85-b588-43ac-1d76-08dddfaf58d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?L6E3kFb+ZLzRK5WUl+poetb/oC8octG/1XHjkRCEh6+H2JLIPXD/uXx5zM0d?=
 =?us-ascii?Q?VN1fgjztMwRp3amWDjRPEg6kz8A/zK7q1AehRz6wwRUx8gFivUh8YDgBzP1y?=
 =?us-ascii?Q?XWNMDL9OF2h0/b20u3TaTvDwc5BxVaq/zlBna4ssA+G46O4sStUo3HdA7Djv?=
 =?us-ascii?Q?Pi2Sdf8OjSAIVupKFkz4D1YNmR5hd5yJuBlNVFFvDaFN18RfDnxC+lty3llP?=
 =?us-ascii?Q?8SIG0L5vUnxUA37iP8vekUPZXpZ4AcAkgQveRznzjmzYyNgaZis0yGGRrUA2?=
 =?us-ascii?Q?JhgrkrXDMzJvNndNqmUQpe50nr7M8ps/JWkYjt5WYHYos2B97c19WxK2fTdF?=
 =?us-ascii?Q?jczVLJRiRRGujbJDKgCOvHOMsFVNqIZWjRy+ZK8mv/Kw1l0SRJN2lzYK88eD?=
 =?us-ascii?Q?V3g9IDylsTLXgIrrfQuFPNl8nJOCKZ8MNpgRFH0qpYyyyjj+dIhr9kYusgP7?=
 =?us-ascii?Q?eWQwmYRsWsBjaXF91CD4Hr9dAhlnNplYgnQD7rMzbgehzR4AveKSwneAbOzh?=
 =?us-ascii?Q?QUG8RsdS96iDC4St3zsAjkjC95pIhRJ1c15V6Y4B+3bw9tp8SoL/UHv0yZRr?=
 =?us-ascii?Q?wY54w8Quxa9MhNSj5kfFUu++1soZWpmF7/zlgYbwqNPjwwNhfEpZiGSUQDSL?=
 =?us-ascii?Q?k1Nv4Qm91+Puj6j7f7XiUmADlnXn2AH/uD8Op/CTnh3VDQ0tHYBEmG+2OMQy?=
 =?us-ascii?Q?N+RHIAzpOf08PIJ+ncDoqOd/HxjtvqH+aQbKJJkaAv3fv5F7GYOMnKvwDcRZ?=
 =?us-ascii?Q?q0QJUpVN0FY79sy8Krwm0pTcWeesyW6o1rITAWgULzAccjfTl1uZr+YMqYnn?=
 =?us-ascii?Q?ai7Dx7tfpXHy08Xr7I9T2HoZm0nFUe0PgmuyK51Q0cfWEY1hcFFQ+XS155Yj?=
 =?us-ascii?Q?VA3L2eH9ly7fhNtioj4ZKrP7y2zN3WHxBMhJkAGBHNMr5Vku6N00sWYqFs7q?=
 =?us-ascii?Q?iRVINxPUGcHKrM+4LOgaiKlx2rC3ZrEpDW+bFacUy5znxjKW20G1sDx0jmGb?=
 =?us-ascii?Q?36Be5aiOLkoCdFHwhbIEF9NzW7tjq3nCYEzNU2UIGB9lPTNJRTiJE+wbaEoq?=
 =?us-ascii?Q?5BmxScx5zuozRnf6ZC3mi9seCON6y0hnpEVkfQX40zdRnSAESb74WnVbfDS/?=
 =?us-ascii?Q?PXm+Vy6JuQdvhzlGiGOI1ISHRWzhl098gXek3DV4ovXYgvSaygnbtqB1spes?=
 =?us-ascii?Q?n3GDF8OwQzDm9qfU8XgLoirhyYzP2uaw8MCLvUjSMZ2DCIlxpuT9NOhP+uri?=
 =?us-ascii?Q?9XlEENLVjH23nSFXVZ6QTezii0AQ3aDy+80oskRhgSE4MGwGizaHANKDfME1?=
 =?us-ascii?Q?FNJe0FFqZ5alXY6GNFTXClJA1UNkDfKwWSiqRBdjs9T8AeFCBdPEKMxTQNo3?=
 =?us-ascii?Q?KppsfGyJS7p/QGBig6vGHHMwoDtYZk9LJwYwNIAB7wsE5fsHvMbkDE+G/K8/?=
 =?us-ascii?Q?3BW9LEzIP2+zTM6Pap9zFsnezru69EhNZWFRRBV3SpAeOg8P9caoZw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lHQDOOf1DDQEesjKCHJKRz50FnmmtDAKm6xMuXquoTA57TjApa8WbYXRCTqM?=
 =?us-ascii?Q?JlC2nJiLhDirFSjjKz3VHBJnOsDOODhZEbuOkMTs9P+Acyhf71dvdD/Mr6R4?=
 =?us-ascii?Q?dCyOVJAXO9Xbuduo85WJr/rK8Gfa+BYJtc9oQ1ScFnKYMGGP741S5Z+gZw6X?=
 =?us-ascii?Q?R5c5gI8jdC9hv+/9FfcOwrBXdOjs9mULarC0mIi3Y6LgRKEAMrX/qlstg2BI?=
 =?us-ascii?Q?lGVjMCVRSbFfUtUZvskC2NRcpvpJND+6JAOotjTys+YaCf10y3rhG9jWFKb5?=
 =?us-ascii?Q?iWgsZUP/3afgp8qlkxCrZYx5HYB91qvAiryBP/FWHM9fZHbn1Bpjvdo7Mt93?=
 =?us-ascii?Q?oZlFv2L40Uqov70bqtgOzrR5vOOjBLgjxj0pAuCuS4J+gwcrrVIyDE3svDo0?=
 =?us-ascii?Q?JJOeEo1MIVjb8h8R+gfOORxB2nLPkBKg/ivWbe4IlOgW/OZJz5DV5QgdPM/r?=
 =?us-ascii?Q?dMtoLoATj/EixMMjBWL2wtluo1rgVyi6Wj8d2VYKCnEk4AzGxlBEAn6yMNcq?=
 =?us-ascii?Q?sCzYqMckA3oKfPGUF+XBPv7qR35TuVbd5QAR9YCAye1OBYGn5/+HLR6/ulPQ?=
 =?us-ascii?Q?M0TlDw6U4UcfuMKG0vtc6Kbhj8Mufe24PmYUorOQlGbNvv8YyNJYrC6vEzDg?=
 =?us-ascii?Q?Ev7SXlfvg8/a6bzmiPLzx/kSsLMZSZLDqcTmY1ragF0/URYIIlE1cFvAVYVD?=
 =?us-ascii?Q?7kwaMVll9OHtN2vYqcboIKsFctxaiIn0j8FoLq1syNXYhQHH74aBSmLdVFqH?=
 =?us-ascii?Q?5A+yIYEurB7wC+i2jtp/sBleS0hqfZWdharDlFredgyJJ9GO6awVRaE4eQfN?=
 =?us-ascii?Q?Q/n4w68WrQJi8vUDYS4gWntfk/aqvUyXukjIVb1owtP20M5KfF4R51L3MjaM?=
 =?us-ascii?Q?flnCfqqFyW2WI0JeN7RAhitMx+ZKq1RMROmJdQCGp4sz0ydgPXtMSeSJ2h2o?=
 =?us-ascii?Q?i0m7C96jZiu5E6XQEOEsIuivPNs8/a+SGn3XgKBaxRaM10wMSQRK5iQVPMjH?=
 =?us-ascii?Q?3ibUhHuVCqrdDA79QPHeeIRuzT2gBbsq9sKRJR8Zy1D8Fy+lFGt2cLhSvAxh?=
 =?us-ascii?Q?6jOrQXN1BOqlAfEhCm698gxkwnz3+6rN9rI0EN4hTM5a3fvEUG8Jzh/3d1ie?=
 =?us-ascii?Q?akO4gVx0rqUZq4y3qwJ4uwKMwPxcnqF+lsajvObZcZgZENUd/zxVJfHwsi8Z?=
 =?us-ascii?Q?kLksf5++TSB0Jb0K4ysif5kNu3S1nTY38OEUZCqvI3FoyHIyxFad80RrJt31?=
 =?us-ascii?Q?eaGO6KsfBBPxbR7yqHP6m2zjof2ZI4fI7JTqI+gHaLHQHztvlfr5u3ZC7ibb?=
 =?us-ascii?Q?zBD08NEzuqWVjtE4GdPyQUzJOm/QQoZdkZ0HIcBl4MN4x34xgjZ12NrWsGr7?=
 =?us-ascii?Q?EZD07GAQ5OVWlLoLeVRJH9kYA67kuyz3hJGbdcuRgq8Y7z84wRkWwkDmp2n9?=
 =?us-ascii?Q?S/PqpzgU9gjRXC/W6PsINsEGbPmLLGbSidTmXGSi+u6JiYQLEg2Fl/mCFm7u?=
 =?us-ascii?Q?O9wsZDanXTbBy9HakNCgGYa4Pz11G071VgHiTKt+98RyFEdMzXxtdssKmawh?=
 =?us-ascii?Q?THmTp1MhVrtbgp8Hh/o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5162fd85-b588-43ac-1d76-08dddfaf58d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 06:03:55.9321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EaVFyX2A84/Lsf5T1EcI2c82sTE++6vqg6ZG2fwsxLy3O0fGgTdsUQ4NLqhe4RjL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753
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

[AMD Official Use Only - AMD Internal Distribution Only]

For patch #4,#5 is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse.Zh=
ang
Sent: Wednesday, August 20, 2025 11:03
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Liu, Leo <Leo.Liu@=
amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhan=
g@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [v3 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization

Update the conditions for setting the SMU vcn reset caps in the SMU v13.0.6=
 PPT initialization function. Specifically:

- Add support for VCN reset capability for firmware versions 0x00558200 and
  above when the program version is 0.
- Add support for VCN reset capability for firmware versions 0x05551800 and
  above when the program version is 5.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 627a8188d868..9306bfe808e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -437,7 +437,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *s=
mu)
            ((pgm =3D=3D 4) && (fw_ver >=3D 0x4557000)))
                smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));

-       if ((pgm =3D=3D 4) && (fw_ver >=3D 0x04557100))
+       if (((pgm =3D=3D 0) && (fw_ver >=3D 0x00558200)) ||
+           ((pgm =3D=3D 4) && (fw_ver >=3D 0x04557100)) ||
+           ((pgm =3D=3D 5) && (fw_ver >=3D 0x05551800)))
                smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));  }

--
2.49.0

