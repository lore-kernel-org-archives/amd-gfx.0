Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F2EC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647DE10EE2E;
	Tue,  7 Jul 2026 15:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N7IYpN6w";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36F810EE35
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF2cXwEXBQUS9JTPmrkfJkZn5yNEK8Pmz37NvK9dCSLpmpZaqWExowb42ojMhKhn0fgozHNZNl5ThBf8xNIpOMxFv2K+gX4Vh9Jv91gyYeQHZ0If7ncKNN18gLHeTqwIUWHglzgUA80ptYBQEkzx0y2HLxmHuM96WdiNUGb2xp7KHUxfw5uQRVxfd0yrWMOBjccYv96wG43ly0jMV/ypYd06RakDZwORc+Utb7EM7JexFrpHFoQAXEN1lgWWyJ8Ck9+0mcx5MzpNa5nCXD9/6KZ0fTrMD2KocoYLLDel+vL3rqreDhh05GiTaSfEdW+ZE3nQLP/84AhFSovaiq332Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oFirwthFXjfVZxLKOoQRoNRZhANw4xjlW42kzfhlkE=;
 b=pEWAsoLdCzM9eXPM6N8iggKECmMw2lDOmY0oEQkvTpKN7ricliYt5Rn71sIjRS3eKZ3ILg8nChqNL2DUPmvhjOI7e9FL/0+2P8I4pjWTUwPHSXt0kpGlziR0HHFnlQfXrXw4/+ehLVvVBcxaC2iFvWB/TVWLiDbK2PGAeWNFQi4YMXFgjBNe7XD7XL3M+swZorovtbRnL9RIHYeNY4Q/iCHb7fCu+H2tEJlDQBInNEPqPSPcJo41K6VQ/0oriA9SFXGIJXHlBnqURqSL/JTopPMyi5ltfp5RHVNuuuSFsdeOnrRkOLZrmId1IV//aO1AVfxjBc1AnMzX2SMTzq/Cqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oFirwthFXjfVZxLKOoQRoNRZhANw4xjlW42kzfhlkE=;
 b=N7IYpN6wCcWQAzpykrelzVJrCmPMe7d9hOuYPhEBVKnC1VI72kbCfvl8e+VzUBV6wP3f2Q9xwIiR2q+cjQJ/nBXiPyVgvFxef+9a7zZMPpWxneAj7O8UXGdzjWIQVZTiqnWgwMlUV6AJZPvb1fR/559Sp5tw/ITTCjusS+M6JYw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:43:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 15:42:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: move uniras IP version check to
 amdgpu_ras_init
Thread-Topic: [PATCH 1/2] drm/amdgpu: move uniras IP version check to
 amdgpu_ras_init
Thread-Index: AQHdDhizvv3yyp9xWk6/tGe1Rizv/rZiMfbQ
Date: Tue, 7 Jul 2026 15:42:58 +0000
Message-ID: <BN9PR12MB5257BA8324D9E00D49E6E8F3FCF02@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260707135815.1028182-1-cesun102@amd.com>
In-Reply-To: <20260707135815.1028182-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-07T15:41:29.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CYYPR12MB8963:EE_
x-ms-office365-filtering-correlation-id: b681ee20-acb2-4144-67fe-08dedc3e6be9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|22082099003|18002099003|3023799007|56012099006|11063799006;
x-microsoft-antispam-message-info: WpVzpxy43vrBW17RMm7bxyusBCuwTCzZxTmXYWRCZDo9a6ltrjyi7UkA+qprezfw7Su5zum61SKYE79lS8+MSU6wHoOzfTPtzhm8sk0jl6B4y13hs7DyW7EOu+u2GifUnbEmwiCnYoxcxPshDp5nCM4c1OR/QZ5ViHoN/NuxhHLHYzpwY/bATjrpgz2wz5znUC71Z7WQQpBhq6+CPymkEpcRlxvBKQiL7xaNDYkLJ+wiiab3iMs8Ci38L/ZuhuYn28sA78Gro8eJ1Rx5dJ5lIHz+2+2G6CQfMbzlg90mzo/+HNBdqz7no/KN2YdlPrNw9DEHaIhU6RogxU402QKdmxP6TOLoxR6v/gkkI7F2fNkcfkeDm6jHkGDMRXkHY8qYG0+kNq7PhQ+9U9tN7Ga2nXeOYag68QfYlOtK2FjhyeeHHLhM+hFRYyEy3ZITzhzEzdt69HqJ982phMUsI51JA3KWD0Gk8vJMBf5fTlVR892at9jPd/UaY3JptHmElrsrDcN/xzkdxeu2HyXUN1jqjYgu86rh2xM/sLsvYm06eOS1osLO/OnKJkxaSF4BKHSuWi+wcB7L6PNQX+QGBo8keuRKk/h5WqRUReXRSO3+/k8ht2VgfhLhhF9EqGhndtb4+VoJ3atMbKgb5+Bf9R5cNOtPgk8lU4HfzIhkNHnZTCY5GsoDklRHcX6Fog24w7vrdPz7BXPCZwLtOdkJs6ANINGrLwK+0TFWb5SDnBUP5eI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8xwa7oLqAHeLbP0o9QM8FGki1QFnTwD1tMVVIOMTPse1EcmBgMDAXMm2ItfJ?=
 =?us-ascii?Q?mcqXvNXv6eAzqBluB48zUnmV9gvCXQBR1zCYh/GnAqO1+dtcRkhd+kbuJyS/?=
 =?us-ascii?Q?sPEgaHS19VXFRVIMslBj9DuqOwk56hbwZA21bTC7OxQnQ/c0Y0sP0BRvxsgk?=
 =?us-ascii?Q?DrKUHbrOJQdFzezbvYzWCk+7kh3Khf1XXzaRapjAqpxiCy4EkNhz8GEcsiXc?=
 =?us-ascii?Q?7WmEYJh2xtiaAx2EwyoG81NOaTfx7tiy7eicRZDZwBzIzIJ3N+l2Dm82/0Ys?=
 =?us-ascii?Q?xNPSo3npHUKe3iuHhpSDxWTZy7rOEzaEjuKsdQmFk4ScsF8lL6JHK9z1hmRj?=
 =?us-ascii?Q?0jnQKS/fyGa/wUVsp57ljOhXbOj2jePLtC0lpkI2Pa57IEplmzfOPe33QpUI?=
 =?us-ascii?Q?ec9Y4T1PcnxJj7/62tUJoiOTtQA3f83/X8HCjzdfjvqO4eBe378G3EH85pus?=
 =?us-ascii?Q?Pz1TAYkZRXKcI85CITuTK68dWMZoJevdjgEuse1B86s2TIyTF3G63edV/+Dh?=
 =?us-ascii?Q?fK4wMP7GbvMlfZ5nVS2RF53YUVPsTR8jVxbNPW/mOgsKfG/FOVLlWFO4GZaj?=
 =?us-ascii?Q?c34saK33Vnke4O33Jxr/IN0BoEdeluxMHlReTVDISBzm8/L1tLJz2pKrAKFC?=
 =?us-ascii?Q?LuRmiehFSU3uHqE4KP7YDZufTLyai22nNkQepYNuBnBtXMZGqzmLFis63iGp?=
 =?us-ascii?Q?zHQg9EG8H49SyxJJTvd2ElsXSpV7E3gyhfI9+lgGKPloJCtkY40htTPF2Sxw?=
 =?us-ascii?Q?RyXZRNtfDLooep6Yb5exCjJEuqPjEyipJ8vA13BNpGrhFn6p5OV6atdcBKU6?=
 =?us-ascii?Q?jRkRPZj3Kc8q64d0TKj5jHK+AzfvhXykG/Y2HHUcYq//v0dIprz8zaxU3X3U?=
 =?us-ascii?Q?PQO97HZYvM/HaUM40pP1bVfYlNpzOyzGrdKSWTKWFvzHssf1Q89+1r1wla/r?=
 =?us-ascii?Q?pvkgczHTaa6NdN0v67mHORTibmAb8tEqO2qlEXVxcT3YG+8LUQzgzix1tfN7?=
 =?us-ascii?Q?9qa16KJa7DLTvw38NXNuvyfy0d4o/8fzidJha0aNok8HTUOO2+ukaorKh5fV?=
 =?us-ascii?Q?QgxDFWZ/60LAuYnZRXGjMfG6hpn8cjMridlmb98QHR5z/o9C+VWUgSCrfxTt?=
 =?us-ascii?Q?lz0IPnQ4oTmS1imOZPeuS0rodBNHv/rYjqTBwntcLVSX0iakGFvZfJB//bHd?=
 =?us-ascii?Q?JKXLz+jKe/SFIzzV09R+EO46pVVLZBNg7mX3ob9TYJiHUWiE2yJjmtrzC7K8?=
 =?us-ascii?Q?ENpZKyjSJ3OH6qFDv5vrZ26cVYDAhX+Gibqi8xzPljiS2Sqvqj+dpZ+GGgW7?=
 =?us-ascii?Q?n/ycGj+w7MIrsO8NBdg64qbVdrAUPnOWwYkEB1n4Dz17+kSlXbh7PuMERE45?=
 =?us-ascii?Q?DBflnZiPAzdgI02yUJG9UvvtqyskKLd8JHhskoEg6L0ozl8kUYEYqEn1syDt?=
 =?us-ascii?Q?tTacS69Iofi7/pOQ+lLQBpuIoNlyhftEHuAUFV5ZMC1vTXYMv1PxuPdI9aRT?=
 =?us-ascii?Q?wNKIUuFXsgQaQp7A1g5ScHeta0n3Gh2RQvl9v3T8060XuPkU8b1GQ13Jf84W?=
 =?us-ascii?Q?v3yHSkGg9Me3bRxEoM3/B9gjg5TgnhnIpROxqnrd8uJcOiUVp8gFiBw9GOzU?=
 =?us-ascii?Q?cG1aBlyCdA7gXEHeXwzaANd1YPnpB4Pf4ARRoeQ5WqR9wwRSjmKkIGMS0tvE?=
 =?us-ascii?Q?jEP7QodVHDt3sDPSsOw+J3NLJbzIdvEDCu+smeok8B/FmnLa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b681ee20-acb2-4144-67fe-08dedc3e6be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 15:42:58.9381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWLd1+t2LAu/93cxpZpKeX0T3faX68lzDnJ4LPERhIKxVsMOV3kvmsZvOO8PuFfXymJgJApeGbOvdXl2ObPlDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
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

AMD General

Should we move amdgpu_ras_mgr_sw_init into amdgpu_ras_init, and ensure it r=
uns before amdgpu_ras_fs_init?

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Tuesday, July 7, 2026 9:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: move uniras IP version check to amdgpu_ras=
_init

Late uniras enable in amdgpu_ras_mgr_sw_init leads to xxx_err_count sysfs n=
ode creation failure during NPS mode switching. Move the uniras IP version =
check into amdgpu_ras_init to set uniras_enabled ahead of sysfs node creati=
on

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 11 +++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 10 +---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index e300d951898d..8ade3da6f132 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3595,6 +3595,17 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
                goto release_con;
        }

+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+       case IP_VERSION(13, 0, 14):
+       case IP_VERSION(13, 0, 12):
+       case IP_VERSION(13, 0, 6):
+               con->uniras_enabled =3D true;
+               break;
+       default:
+               con->uniras_enabled =3D false;
+               break;
+       }
+
        con->update_channel_flag =3D false;
        con->features =3D 0;
        con->schema =3D 0;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index b8b831a91bc7..6224c4921a42 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -327,15 +327,7 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
        struct amdgpu_ras_mgr *ras_mgr;
        int ret =3D 0;

-       /* Disabled by default */
-       con->uniras_enabled =3D false;
-
-       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
4) ||
-           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
2) ||
-           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
) ||
-           adev->debug_enable_ras_aca)
-               con->uniras_enabled =3D true;
-       else
+       if (!con->uniras_enabled)
                return 0;

        ras_mgr =3D kzalloc(sizeof(*ras_mgr), GFP_KERNEL);
--
2.34.1

