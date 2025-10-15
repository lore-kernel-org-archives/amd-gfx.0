Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8042CCCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D3410E6D2;
	Wed, 15 Oct 2025 02:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qj7XucFz";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2651110E6D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY6hJdsyefQSvWDmCqEQ2+hrusYzOG5Gd4MM97N/lzz9OFDLBSocoOsONNjfUKvBRrSgK+y3GKTutuf44CT2ghGmlSRp2RL3Ci2u099I0TP+wNsURKy8AcOGZDVwdnL33rPAJm18TDXX9clhAATiAuw+ta+9YpLMY6LJHD85jE4APaS+8mVJ0F+uM3zXDJ/rnRKaZzy5QlkRCS0CizWn3/IL13oML7hW5xxhC9BMdq2VqrEB5SSvJ15/wQayK4D64RdY9kkYSN7z4TmXG+FxyaOLiA0kh+HtQND8OtMS+54tuix8Gf3uL3iu0v+/Bejh2dMwUjjTZ8zwsje7siNQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUmPa0TOHBLajz4VpbOHz+vTPdVj4t1hAd9xi6FQraQ=;
 b=v4HbAg89mvcIshHUAErTxTxFUnr+81ANYaXHlGYEhkAQv3GWps7JN8knPIQZTbBxVm5gObr7BYHgGxWcO/zYYHGmQuEFiIKi8jaT3JePBp0FBaYGhxrIXjip7bP10yPRUgBUP8oIE9K3p1L+KUP1OILBCk2yGzNNxVpQLYiwdjXS9OiY4DWreJa269gKR5uiR2nlrXJCmVrmurjPQSbbLzMoDRerbJN/3vgmUxdJl/8o93wxg07pE54NMJ45C/KGzTqz9qxMs0V/Ruk+nYTIwlrfw3ODBqqjKlQWv4JndkkUljc118ApNOZ11Iwd02hrQV5a9XL7k9FmcHdztTfW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUmPa0TOHBLajz4VpbOHz+vTPdVj4t1hAd9xi6FQraQ=;
 b=Qj7XucFzdC6yLTwYLvDxPOkZdV7yCuTG3DnMrS1soSA9oj5/vFpVXCGMV1v2SQXsV/lkNutyzZdDTeFR89jvuLqmiaTxIZsBa8imKFdpk+99+Z86G7FJ+BCbHQsuHpseHuAzDgdL5K90+jnFSB0ahtOvCHPujhsH8yh/NOaJDdo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 02:30:08 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 02:30:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add ras module ip block to amdgpu
 discovery
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add ras module ip block to amdgpu
 discovery
Thread-Index: AQHcPNk5V3B7Dl13JEOE+7dzPRmvLrTCfXDA
Date: Wed, 15 Oct 2025 02:30:07 +0000
Message-ID: <BN9PR12MB5257BB31382D9C4A1081C94AFCE8A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251014070617.698199-1-YiPeng.Chai@amd.com>
In-Reply-To: <20251014070617.698199-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-15T02:29:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB7896:EE_
x-ms-office365-filtering-correlation-id: e94002fd-fc7f-4456-fbe1-08de0b92c1e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bpJS6ZTsBZbZhuPETrDZsUvMQXYt6yaXrVxCvubzH7Vs3SyDaDw++rxsomLl?=
 =?us-ascii?Q?Q6DFQJ3/Rrqsx9UqT4cKSn0zKijw0/UfaeGmgW+CIOkw3wHO8FbHoOwaPONp?=
 =?us-ascii?Q?Yimrp4np63ZlkBvlApYIFGHwotvFkUE+3jJ3mDGHExTl7E6JxIZbgZwnOAf6?=
 =?us-ascii?Q?0TZUFL/8Ek4BCUTesyveVofO1UsMMwO4+mWYol5XXQnrv0pG9vP14iS1oW3C?=
 =?us-ascii?Q?hLZVJSfimmP+/lsuQBX+3RyZYGES5Pg+C+pK5K0GMhkhj5Xpss7H9y41cTqn?=
 =?us-ascii?Q?FODsJEzgsX7Kc5/ny+luQXKUW+yQ/lIO4VKLBJOD3U72paTHnwBrBQa6UXl7?=
 =?us-ascii?Q?BZ8lgdQEwT+UliEnA68DPXyWw5eICJNXbevvri4sYIbFhQFga2enKlkGBSNL?=
 =?us-ascii?Q?pEL7V+/K3i7AGmnz5ceOGm/b/P1QuUYq7bBHlSoj3IHbUiCt70B6QYmz1vo7?=
 =?us-ascii?Q?HnomVbSsVMdWEYrU2S+m9Hud4wcGTh8jL3+d0/c0FfWHxXJPrMq64ot8boQO?=
 =?us-ascii?Q?SaOKsVMQMYtmI3TX6x1XR6dlFiQi1XNg2vIHxZHuyuHN6AyTRfrC8dn2PljQ?=
 =?us-ascii?Q?ZWs3Oaw6SYTfBxfT4z9zu3Sl2oLu2ehJfG7BDoKm0uG2RlrtAGmpshEY+RbK?=
 =?us-ascii?Q?A/GcNTrzGTIAvhf+T9XwZugBTKfgr6hf4fF9DsyHZ4/pgs7j9nt1RhjQVk29?=
 =?us-ascii?Q?25Ghs6YntAFDQlT1/x3TzMnPIveOtqIS0CRilVRkAluVmcclGzxpMy+vnwMQ?=
 =?us-ascii?Q?BDfR0FLGozIdcCabZ+n3ARFTbUMi14O5n1hYTnejUyaBSEa79bPSgYRH8MEh?=
 =?us-ascii?Q?E8SzT/LJv5YM+D4V01eibcVahAaMiPvpmBQlj7w3FTbu/BZjnbUuU+7Y8Jke?=
 =?us-ascii?Q?0hVYUB4J3R1n5hhzPAeJiRf2niZEzzo7SIN4av0w+GlQ0lUlH+bFfxEu7nHf?=
 =?us-ascii?Q?AO/5fH0oiABpsTmbPoNehht6iMWqAivatauUmc/uMrpa6Ml0/tSsXR7U4OuR?=
 =?us-ascii?Q?oZ3aHzZY/03W16gZAUAN23mjO75KKUoYuf6Qzhj8UXtP17QwFI7ZGEcJCgfL?=
 =?us-ascii?Q?ZJs0BaQHP0aRfSbuKZh6f/n1kmP65ymw9n018s4JyOBnSly/qHs9CUS1Elky?=
 =?us-ascii?Q?QPqaxg/1x7ffNxXPos7aPeFbra0ckcySLLUrmZoyXQdGjVFjlSkv3ZRZ9a+j?=
 =?us-ascii?Q?/GfWXOwmovywq4GKLlCuNaAlJ+yJWEBMf2NgdXADIZMNfKabf16VTIsD1uBQ?=
 =?us-ascii?Q?9Qz0sUb0Hii8ytE2aevQ5KFREtLYtT6jC7CetJOqkqYkBNoZUCDBXj9GSBoB?=
 =?us-ascii?Q?LHOIoDpy5VAxsDVl2ogIm+0MD5KKsEI+Cb09RMsy6NgyG7YvaXre+FjJFkcw?=
 =?us-ascii?Q?Pv8d/CvhVuu3JRqchaTht1GWHlJOvDCP9ocQGPiuN+3F+3TirJhU6fqv9B0q?=
 =?us-ascii?Q?qdWRsbIFNr7JRwK5GT4PA4sbxbEDGi2P9ceXnFFDrdYSopiqKtsG3LrxWvVo?=
 =?us-ascii?Q?LYy0pnLvPadzqKAZDQgs4f/wSb8X9fJi4WiQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2K2l35OHnzEZt6KR6f2e0tClgTrsNAUt4+qxPKG502jad7qIZfv/l1tBudXI?=
 =?us-ascii?Q?c+s+9L7cAZV22hHJs2YD/dXEnH/DHB7fiIIElhcQskx4NXn446CfbJmjkVLn?=
 =?us-ascii?Q?GO0TfxOLWeziK6M4C9WRO4XxW3/OxUfcfJl9Ok+Gd6ckE7pU8LjVxyYGSWpy?=
 =?us-ascii?Q?ytTVjQfCGkUyAkmb5r5lJGmKlhz6iASP3uaOGzgXDp5utTaUqBfF6oOimRNI?=
 =?us-ascii?Q?RFgmz5SOR1NflMAnxL9LhJq4vTXoYOivg+BJlNFCwEFkX2gStIUbc+zmeD4U?=
 =?us-ascii?Q?fLpn6uY0m29WCteJQ8AqnU7LzobnQpjfrYcdyewyUYU6OqLBEy88j6k77CJX?=
 =?us-ascii?Q?iYlyZQRwtkIdzGMSyUfCjmixSGYs0SV0kftiEgDgIaZWLO0t4iUtOpRXCCBX?=
 =?us-ascii?Q?K+uQtZeJP/4gyyQ/sbb/+1glTuGS1FeeDstMZRnTVApkTA+GT7t9xr/ez+v6?=
 =?us-ascii?Q?1h0JbifZliJdgUgacZFOwZukJSrmhZoYxHvxB5iHB9p7eEb2t/3R1xoR8Sbd?=
 =?us-ascii?Q?0pmdDFUljAgUvFn3xrRAgZy6CQfVjz9J7go7A9lKI7qF8ISNIvWDKW2MDl+r?=
 =?us-ascii?Q?8MWFDdRi/4/s/eGnail8c5AvSWs+jqSOEjC8ZWD0j8fzTTrAp1lmKTuNuTFZ?=
 =?us-ascii?Q?aeAI0Folyd7JS/5MPiwEdPNrSqcn6bMnftPm10yCA3TqfbZChjlU2HeowVZi?=
 =?us-ascii?Q?rGQe3KnYTo4YRjESTyromVq8soah3olJRU/MpniJ9oIWWBGh3hHKGljlJclw?=
 =?us-ascii?Q?qTA9DaaVFgG8XSFGuf09B2E5woLpOFhoMQykLICih+SK0aFpsGMDhuXjFPbK?=
 =?us-ascii?Q?cxehZSGqbF/Q6hEicDqPrCANhwdmC+NP6fJ0QM0VRYl8jx+9h5dheUUb0g/U?=
 =?us-ascii?Q?PZ69K2htdo9LoRTWxh4qZu/OhjdCRO/AzkxzbAgdpllCeGgo2uowMJElDjZK?=
 =?us-ascii?Q?9Wsem5b595M3Hpnm0o4SkPyHEDOkKIdTB69P8t9mrh6OezQT7BqeFeuSe9ok?=
 =?us-ascii?Q?q2DOTu9/PUmfOueoCMvuql/CCh7sEsteX0WxYIq4W7T+TDIiEXaQxIuUlXVk?=
 =?us-ascii?Q?VLHF9plSgdOcUUbC9rQsCEDeECZ0OC84jNORc32M6ccpRAMRDb2+qJVAliks?=
 =?us-ascii?Q?LVqfs0LhWkBQZrk48zOuDuC6C/se8BEdPLqNmMMoQc1cD1ocMzxdPNgP6hmf?=
 =?us-ascii?Q?tQiUBJE4NqYv0TO02Z8aHD9WLdMzD7EbteKiRi+0NB9Lr6qRzhmG/ilGg96Y?=
 =?us-ascii?Q?fJIubV4uBVBcrEqJG8cfvQ9orgbvH1KIinULSCetLTI3B4tgKwAvDhSKNMpd?=
 =?us-ascii?Q?3B9L967KqH4bfOw7SE3CgIDYkB6ubOoY1Cmnw/mYtfsP4vCXBDmczjx6l/Ol?=
 =?us-ascii?Q?ZZsgFqVdKCgByqWX7XXtsldIBcV4ihYzNHQtG9sIQuYn43GeoYhwEWCOSw2T?=
 =?us-ascii?Q?Cd0gvP56hb+vEmzIs3VDDZLnnAIyiEOyBfvgShTh5cvqcEdRaQlZgwS+q0AE?=
 =?us-ascii?Q?fltmPzlTZpMiovCI8R8Zck7BL4vhP/9bAErppN/kt0zFLimAQcHUOPGWbFs7?=
 =?us-ascii?Q?2UxdH8TJJCTJisMjf1g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94002fd-fc7f-4456-fbe1-08de0b92c1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 02:30:07.8911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzqbsLjBhdJ6aXCyp1xQlIywoBPZ5fV/Mgce1PdTl59gUrTYz8qKOW2ilZbkczU95oPtYeH2c/vv4+qo2r98Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, October 14, 2025 15:06
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add ras module ip block to amdgpu discover=
y

Add ras module ip block to amdgpu discovery.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h      |  1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  8 ++++++++  .../gpu/drm/a=
md/ras/ras_mgr/amdgpu_ras_mgr.h  |  2 ++
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index d9bd1d71552e..04c1f004931b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -378,7 +378,7 @@ int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_=
block);

 int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);

-#define AMDGPU_MAX_IP_NUM 16
+#define AMDGPU_MAX_IP_NUM AMD_IP_BLOCK_TYPE_NUM

 struct amdgpu_ip_block_status {
        bool valid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 4e75334f3b3a..b4d52da687a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -112,6 +112,7 @@
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
+#include "amdgpu_ras_mgr.h"

 MODULE_FIRMWARE("amdgpu/ip_discovery.bin");
 MODULE_FIRMWARE("amdgpu/vega10_ip_discovery.bin");
@@ -2393,6 +2394,21 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struc=
t amdgpu_device *adev)
                        amdgpu_ip_version(adev, SDMA0_HWIP, 0));
                return -EINVAL;
        }
+
+       return 0;
+}
+
+static int amdgpu_discovery_set_ras_ip_blocks(struct amdgpu_device
+*adev) {
+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+       case IP_VERSION(13, 0, 6):
+       case IP_VERSION(13, 0, 12):
+       case IP_VERSION(13, 0, 14):
+               amdgpu_device_ip_block_add(adev, &ras_v1_0_ip_block);
+               break;
+       default:
+               break;
+       }
        return 0;
 }

@@ -3173,6 +3189,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
        if (r)
                return r;

+       r =3D amdgpu_discovery_set_ras_ip_blocks(adev);
+       if (r)
+               return r;
+
        if ((adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT &&
             !amdgpu_sriov_vf(adev)) ||
            (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_RLC_BACKDOOR_AU=
TO && amdgpu_dpm =3D=3D 1)) { diff --git a/drivers/gpu/drm/amd/include/amd_=
shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 75efda2969cf..17945094a138 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -109,6 +109,7 @@ enum amd_ip_block_type {
        AMD_IP_BLOCK_TYPE_VPE,
        AMD_IP_BLOCK_TYPE_UMSCH_MM,
        AMD_IP_BLOCK_TYPE_ISP,
+       AMD_IP_BLOCK_TYPE_RAS,
        AMD_IP_BLOCK_TYPE_NUM,
 };

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a8d02bd42f90..3ae843d078d8 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -381,6 +381,14 @@ static const struct amd_ip_funcs __maybe_unused ras_v1=
_0_ip_funcs =3D {
        .hw_fini =3D amdgpu_ras_mgr_hw_fini,
 };

+const struct amdgpu_ip_block_version ras_v1_0_ip_block =3D {
+       .type =3D AMD_IP_BLOCK_TYPE_RAS,
+       .major =3D 1,
+       .minor =3D 0,
+       .rev =3D 0,
+       .funcs =3D &ras_v1_0_ip_funcs,
+};
+
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable)  {
        struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
; diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/g=
pu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 8d6a1873b666..814b65ef1c62 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -54,6 +54,8 @@ struct amdgpu_ras_mgr {
        bool ras_is_ready;
 };

+extern const struct amdgpu_ip_block_version ras_v1_0_ip_block;
+
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
                        struct amdgpu_device *adev);
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable);
--
2.34.1

