Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90443C3600B
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 04:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173D710E37B;
	Tue, 25 Mar 2025 04:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3v1g02VO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7E810E376
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 04:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9UycYPfyixBZZKbb3m2/1Ovvrmd2CEeH+rj040Pa7XqqJr5GsFym3dHa/XuENgE2U8NTUCzQvmM3tHO0XGwSEc5Wpp0OtwMd2qghgcdYqZjDPxIriuxsgijRHcyAY9KExepZlXY6G82QGrBHISR5F4Lei3esGNNZp8xf/zesW0yHJqP060n1Xrc/UTcXebHtLwffmngOBiU16JGBpQN+7c6J9or2A/sp3XLYMmZ8RCqEdNs/jKo49p1/XofzSFniSJ9/QcWLLhXGVxZ0Hll8E6Jr90nWi6H+RSNgQwxeTJivgSp46HUCKEuzmyyOWyVFoe87tnz+UCkhMmPuvqaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKZce7GpdAE1hI+9rviEfDQHYjKe2QllBNboLaKwyTE=;
 b=h7lZU1vMTbRSUNu2pHBW+1yamHXhr3HkoeFUcfmlStQ4kmCd4SgXI24rkX3bYkNqL9kXmrklZgbN7jTpsEMOflyopuQAeWlIgmWXAYGgUXJkC0du/8ZRlJI1/5knutukYWcMyn/xaWtnsZM5mmjXNDHCgiY09HHjRnyZqIULLLV1z+uwdAEsnPH0cXUZj3AFC3u8DmfsKrgPlirVuwKbV+Hu8nSuTLzC6G/3VYy3YeVu41D7uoqfn+zE7Brcr5c5wYdq+E+BiLzGIwYdqPBfHQ703BE8Hwn/6RHFGbKwHQgxAqlPpDpKYviT7EyvxpQ1rd9LRO4tf4GNg4oQGaM4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKZce7GpdAE1hI+9rviEfDQHYjKe2QllBNboLaKwyTE=;
 b=3v1g02VOZjUZRF6NyA/Qagendc7D916qWiDyvgVSj2cnVgYYyqCU2Lp/ZNYhatiPP3RsHBcLL05uWuPEa+PKYfL9PXY6JqrL1dT74ak1OOSv/erBQNnGAgKoP4RW0k62iKUi39VQq840LFgYkNCdOHWfzpLj7EeZ+qe1iEe3lkU=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 04:33:18 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 04:33:18 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
CC: "Gao, Likun" <Likun.Gao@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: use common function to map ip for
 aqua_vanjaram
Thread-Topic: [PATCH 2/2] drm/amdgpu: use common function to map ip for
 aqua_vanjaram
Thread-Index: AQHbnTpLulKLLsEvMUeWRm7U1IttwbODPHIg
Date: Tue, 25 Mar 2025 04:33:18 +0000
Message-ID: <DM4PR12MB5181927938115EC197E38095EFA72@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20250325035850.2440725-1-likun.gao@amd.com>
 <20250325035850.2440725-2-likun.gao@amd.com>
In-Reply-To: <20250325035850.2440725-2-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4a844473-e540-48f4-b168-79b8181f6f9d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-25T04:07:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY1PR12MB9673:EE_
x-ms-office365-filtering-correlation-id: ba4f3aa1-6e32-464a-ebfe-08dd6b562aa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0JiombPmyon5RCGmrLeoMm8M6G7Q6K9Z1ifA/PcBBG2Umerl9y84JoWye5vE?=
 =?us-ascii?Q?PwH9KD2bQ/qsrvJubVOXPnsHH1IGNDv8oHnSoVNEO1JwwUz3et2GaBepwIT2?=
 =?us-ascii?Q?e0KyPobRiLoCP8dOOghiQoJjIVsB0HIDq2JsqfwMjxlDED/SqSXDeZfDDim4?=
 =?us-ascii?Q?Lko/3X0OzvcQUxvV86j3XS6jwPBrfevtT+qrmATVLr2EqaV1f6yx7a2W35l/?=
 =?us-ascii?Q?3QaSgsX+ZR4PyzTKhxVZeC+8fyYA3/QKtOCXqbxUwvbsfTk893zV5WuKSj/e?=
 =?us-ascii?Q?1OKX4zElenU7QK+/8JXuKabHlv9PZ5K0V/nNz7/HJQEs5J7WTeUDC6mJv2Kp?=
 =?us-ascii?Q?8LFrnMAYloe2xq96Dxhb8azSvvtleS7zMBLLIXYPOrOn4tReEwMjmyRqg0gZ?=
 =?us-ascii?Q?gwb9ilM6tHhfFJ+P81q/6z5zzEd+PLASMmCrMb+E6pALdLtWkDxZ6glLyu1/?=
 =?us-ascii?Q?AMBYIEOcI4O/bHPVaU9sNHTinUSJCfficz7C3Cyjl1ignsHnHa67XzcW6eDD?=
 =?us-ascii?Q?/XPUjX5QTCFmIyJxjRN2Mj4R9W/8rPNbDdKF2ervtCIeJP2O0tHuNVUxlu9s?=
 =?us-ascii?Q?DVr/uxQ0TjMLMA8zod9v4E+3WgnZAMosu+DIbCE63dl9D3kWD9qQ2JonBsFG?=
 =?us-ascii?Q?C23S42YlMg8T5XN026WTbW5kuB2P39l3OiLlrejtUYcwLKcktna0tk5yXs0B?=
 =?us-ascii?Q?pA26VhHJ1RX+Rtqm+q53rfTZVAjsCq74hdL1/zr7XSqr1QJCjLChOntxCntX?=
 =?us-ascii?Q?kZISI+/UM3WOEh/UqDJKwdJkxiwROEeuE3T5nb36cdPnpOHpbxcZaw56lQ6F?=
 =?us-ascii?Q?j6FbMyEh08SNN9hclW+QtpdJkTtWsWxY2mYjx5TkAxb3i29X5h0XHCcCafl6?=
 =?us-ascii?Q?w+9ikj5jN4IFgg5+rNY3DR/MxpgDVIdEkj2rtY1U/ePPD5Z7NX92PKwYkqCF?=
 =?us-ascii?Q?DWPPvEX2CSRMN2dNBUGQzAsQl4ixBdtgVokTS2AGFvTKnP2ay+8xTyqzFlhF?=
 =?us-ascii?Q?jm+8D1bCV6xLusqC1pITFT5p4w8MksrP6LrsW8RFJLzkju6ZKvieIquKyb3b?=
 =?us-ascii?Q?2dbXx3Om9Lu/2qbsufKWHK2DYac874TcNmBcwhj/RGgMzl6TtYptQuUzywvW?=
 =?us-ascii?Q?WDzcPEbAEOJSM+sHxKh7pTUtWmG2AZZrZJkOVmmDqnWOBYTQRR6eFUz3iPQJ?=
 =?us-ascii?Q?6c3thL0/wRD9vOr7m/YQnz1AHm5sjDGxFbgpNYP7Sqw9/9GVabS+yl+5G/4u?=
 =?us-ascii?Q?3tFI2yPgCKtKveUNGteTsrosKANtWy9PBDHaEcXH3ctgtGx/CVX3ts7OyKtF?=
 =?us-ascii?Q?EHDGes7JjoLzL2D3v7tvx9MFiWV8jU7nNiBsCkVSiJSkAWOYr6iZpo3tSF6I?=
 =?us-ascii?Q?C6GfGWykktQsvp7N57bcYaH2fAu2awXHI6kafyYs2O+5ZEV6hN5a3mDAN0Ha?=
 =?us-ascii?Q?uoxRv7Fk/jEDZIZIz60W08rpPggpJXms?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ona5Ze8nzaHnGfjDt0gS5uF0JIFuBI//rZaxfPVvxiX134BVAWnsbYj/rBA0?=
 =?us-ascii?Q?w68yk7P36AR45w3t+1/W/sDoi0vlJH4NO7pzSlh75lXUTyhvtC6yc6U8yW9P?=
 =?us-ascii?Q?BOef/oiXDwNGV6okdxMb8YxnscQaviS84K5jIyYfPoe4WFvJDfPgpZ4orG/a?=
 =?us-ascii?Q?y182Ac5fzBnMV2fZZgvfjlRG9fuuU/X1MWIjCRG/ucjb8T7PfqXbwKYEdfP9?=
 =?us-ascii?Q?hISyh+tCdm35bfxqBTTOUdOBvUsduBYlAedsv4L5NNZkpSpi5///Dcy72B6k?=
 =?us-ascii?Q?I6UDGqDX7N2Bo3pjjtDcWOjtabjDCaUAGph6bJatnikkBMnIemVICVN7QIFJ?=
 =?us-ascii?Q?1Rj/0KxwHl01zeiLEyq3ZXHx7pjYrD8MO1H1WGpdTwbhHJPUl3WPMUXnpHdl?=
 =?us-ascii?Q?kPbSIbnZxYbtM/LMDy+KsRAlmgJpPBXz3nalaZn4DAHUhWx5FrGnCbEcpqeN?=
 =?us-ascii?Q?olIk2c9WkainVM9ZOlCBiGDczfrSdc+508cRT9p1sozKft40Ba9w1n8DSwjX?=
 =?us-ascii?Q?KErLfoq7xPxXKr6OUSCK7mLVQSWvxeEne8oYjEwEKXe4Au0f7XCJZe5gWad1?=
 =?us-ascii?Q?kKzEz28UP058oe7t+jW816SIIF1EdO2LokEo29irFAeuGSPwwQcDgzStmuMf?=
 =?us-ascii?Q?XuRgpj3wE1xZAD3k/i4SD2gRtfUO+RYYj6mNiMaoUuz4c9xBhAeNFSeOgFEl?=
 =?us-ascii?Q?BKwRKmErPcJaDTcyFcXZCHpatU0snqIrCIss/iPC7utYU68nUcAadsp06Z3L?=
 =?us-ascii?Q?BBh5QgFulfIVXDOerkNS1UYpaG1+0Zi8TjUfypKvAQ9RALhxhz4uSFLcCo6K?=
 =?us-ascii?Q?cIZd6pp5qS6Yp8IIxseGr2j9dqHGOj3sXROQTPjwqaxwg2aPNDPk84mOWVNP?=
 =?us-ascii?Q?tBwmgb6/+zq6ajzRWAjdLUxZ8x22wchTJUihmP115Rs1oG++rzaZmZlZi8Hr?=
 =?us-ascii?Q?j/c7ZE0C8cbuf7WN2Qwr6RnBNwHOSAr6q4iIXGyPByPXPv/PlsCIJdN/R55K?=
 =?us-ascii?Q?HsNuy22ExsH41bQ4e7pCH1E/E66kTt6+XlpUBdICYIOGSd4vt7+LGcp7BE2k?=
 =?us-ascii?Q?Q96lgUtax5uCbs0fGO2PbbJ7oZTy0SpioeLdpjSE51zggyKK/PeKZg3oWsF4?=
 =?us-ascii?Q?HAy183Bxntl0kQbYrcMrYUWqv5N2N7yOeNojt/pkxcbjzvqhQF9R7nLTQDUY?=
 =?us-ascii?Q?/s9pdUc7dt1S0L2cKGBCJj4xoYxrxuYRVs5L21TThFBihrh09HeoF6fPH3F2?=
 =?us-ascii?Q?ZvsNI41P8CQ22ORFgpMLhix/svejlaj57YfWJX+bPkLLUJ81Qg47eNBwWgnB?=
 =?us-ascii?Q?qh65hwbVmyUaVDc5wSoVd8HGzsX4fAiNJQVz/8Vai4bmn05e1N7Q9QR69h7Z?=
 =?us-ascii?Q?L8ZkIxtLYPW1iXEgOIrKPsTBQAr2MxS/+F7P2FdzbwGqMN8y86YHpPd7madT?=
 =?us-ascii?Q?ienZ7sS9nTTcGNbrgtE0y9ts/OL4BzbDpEbhK5eWxD17nRei/YzfkEALPTVT?=
 =?us-ascii?Q?bkMVT9pXVJs+QmkKUzEGNFK+lYmDarKQGp0lVL2clkzztwe3OaD6Gaa9ltDq?=
 =?us-ascii?Q?lWf+/SEGJG3Nq8z7nKQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4f3aa1-6e32-464a-ebfe-08dd6b562aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 04:33:18.3057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kETOltkoKBbaHTXOvaGyi6BuDSIbwXmg90bpNwIlo5XisEioiAu1dEAb79OKcDeu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673
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

From: Likun Gao <Likun.Gao@amd.com>

Transfer to use function amdgpu_ip_map_init to map ip instance for aqua_van=
jaram instead of operation on different ASIC.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 74 +---------------------
 drivers/gpu/drm/amd/amdgpu/soc15.h         |  1 -
 2 files changed, 2 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index ae071985f26e..edf479319f82 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -29,6 +29,7 @@
 #include "gfx_v9_4_3.h"
 #include "gfxhub_v1_2.h"
 #include "sdma_v4_4_2.h"
+#include "amdgpu_ip.h"

 #define XCP_INST_MASK(num_inst, xcp_id)                                   =
     \
        (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0) @@=
 -219,77 +220,6 @@ static int aqua_vanjaram_select_scheds(
        return 0;
 }

-static int8_t aqua_vanjaram_logical_to_dev_inst(struct amdgpu_device *adev=
,
-                                        enum amd_hw_ip_block_type block,
-                                        int8_t inst)
-{
-       int8_t dev_inst;
-
-       switch (block) {
-       case GC_HWIP:
-       case SDMA0_HWIP:
-       /* Both JPEG and VCN as JPEG is only alias of VCN */
-       case VCN_HWIP:
-               dev_inst =3D adev->ip_map.dev_inst[block][inst];
-               break;
-       default:
-               /* For rest of the IPs, no look up required.
-                * Assume 'logical instance =3D=3D physical instance' for a=
ll configs. */
-               dev_inst =3D inst;
-               break;
-       }
-
-       return dev_inst;
-}
-
-static uint32_t aqua_vanjaram_logical_to_dev_mask(struct amdgpu_device *ad=
ev,
-                                        enum amd_hw_ip_block_type block,
-                                        uint32_t mask)
-{
-       uint32_t dev_mask =3D 0;
-       int8_t log_inst, dev_inst;
-
-       while (mask) {
-               log_inst =3D ffs(mask) - 1;
-               dev_inst =3D aqua_vanjaram_logical_to_dev_inst(adev, block,=
 log_inst);
-               dev_mask |=3D (1 << dev_inst);
-               mask &=3D ~(1 << log_inst);
-       }
-
-       return dev_mask;
-}
-
-static void aqua_vanjaram_populate_ip_map(struct amdgpu_device *adev,
-                                         enum amd_hw_ip_block_type ip_bloc=
k,
-                                         uint32_t inst_mask)
-{
-       int l =3D 0, i;
-
-       while (inst_mask) {
-               i =3D ffs(inst_mask) - 1;
-               adev->ip_map.dev_inst[ip_block][l++] =3D i;
-               inst_mask &=3D ~(1 << i);
-       }
-       for (; l < HWIP_MAX_INSTANCE; l++)
-               adev->ip_map.dev_inst[ip_block][l] =3D -1;
-}
-
-void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev) -{
-       u32 ip_map[][2] =3D {
-               { GC_HWIP, adev->gfx.xcc_mask },
-               { SDMA0_HWIP, adev->sdma.sdma_mask },
-               { VCN_HWIP, adev->vcn.inst_mask },
-       };
-       int i;
-
-       for (i =3D 0; i < ARRAY_SIZE(ip_map); ++i)
-               aqua_vanjaram_populate_ip_map(adev, ip_map[i][0], ip_map[i]=
[1]);
-
-       adev->ip_map.logical_to_dev_inst =3D aqua_vanjaram_logical_to_dev_i=
nst;
-       adev->ip_map.logical_to_dev_mask =3D aqua_vanjaram_logical_to_dev_m=
ask;
-}
-
 /* Fixed pattern for smn addressing on different AIDs:
  *   bit[34]: indicate cross AID access
  *   bit[33:32]: indicate target AID id
@@ -839,7 +769,7 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device =
*adev)
        if (ret)
                return ret;

-       aqua_vanjaram_ip_map_init(adev);
+       amdgpu_ip_map_init(adev);

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgp=
u/soc15.h
index ef7c603b50ae..c8ac11a9cdef 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -118,7 +118,6 @@ int vega10_reg_base_init(struct amdgpu_device *adev);  =
int vega20_reg_base_init(struct amdgpu_device *adev);  int arct_reg_base_in=
it(struct amdgpu_device *adev);  int aldebaran_reg_base_init(struct amdgpu_=
device *adev); -void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev);
 u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_id);  int aqua_vanjara=
m_init_soc_config(struct amdgpu_device *adev);  ssize_t aqua_vanjaram_get_r=
eg_state(struct amdgpu_device *adev,
--
2.34.1

