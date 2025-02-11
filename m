Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7F6C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 01:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5467110E62A;
	Tue, 11 Feb 2025 01:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vOmE1G4f";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3712210E634
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 01:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaL51hakzcOuEJxT/6ApbJzxsJg2Jclg96VY62kzk3zdzIspZu0AQO1Cy6rI73azw2n0Zro8Zuq+Sau8liLXpgH6YSgMk/CFDTh63ws2IatmRULYYKDwKQKmj8o8TWF/7xTHD7A5txC6V2R+blGAH2hBUjJr8jLjsWdMz5ZS+8KEf1gdvsX4VUw8pG1p4rYH67znY15U5ZB72JkNsYR36+mvgIKzJmZiLi4DGuhov1sqSj6KustdZjAHizqAnTh10mvSGrK90PpshmbGm4ujimQuE6bYI8xSL51a1Yo4/0ReThsC2GaX5UAGppDTp8j5CO3Ae0Lfvoxrm4VdIerSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32w8m/bbJWOcvjpBnnDv39Pn7TjM1+5x9iAlmDqqpsM=;
 b=HEI1KDLHLWHIsoa7tHi0niuP14JMkYdJ8IRYVvSvZw7FEQt0B9OqLcFu3YLaIXKMgoIribLYzekdLSV00QKEtvm9EzpHWCLNcbgM4su+TqKhRVPAXeGSwUgwqZqNWrK3oscuvzAAqqzENhn/XdXa1brOD2pHc8WL/t/Xw1hJ9ui2OKpdI9D8z/cNCYTFbryfnwEDxqyJoNn6QvBkB3UBSfqRygb4SbGeYDDXDg5F25pkOHTJjMtNkO9TTtIzQw25kiH0g4aEtrzjzq48BxG1wN3pbiDMd/VPGKZTzqF7QU5Qzin+8KqCFMNsFVOQ5AnZy8NAMBlVsvYDFQYRiv9Ykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32w8m/bbJWOcvjpBnnDv39Pn7TjM1+5x9iAlmDqqpsM=;
 b=vOmE1G4fbnIxd+ElrsEt+hjSjxKHHqJGVcQMB1rAHLFAxAGnoRo+DHVSweH0sUDon2GHFoC8Y1tDdmFmL+VytMh9nzDCBfy6Rg9OMPoy3SbCvyu9jCuAJzxxXo4rJgA9tgVqed6gMyq0Y80JmbJS8qMTvWqXLLdUvPjb/cUONcA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 01:54:42 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 01:54:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>
Subject: RE: [PATCH v2 1/4] drm/amdgpu: Move xgmi definitions to xgmi header
Thread-Topic: [PATCH v2 1/4] drm/amdgpu: Move xgmi definitions to xgmi header
Thread-Index: AQHbe4mIZBYrYbQUf0G3dPp0PpXYlLNBWKxw
Date: Tue, 11 Feb 2025 01:54:42 +0000
Message-ID: <BN9PR12MB52577E165A1BA07DA498CA58FCFD2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250210070034.1998011-1-lijo.lazar@amd.com>
In-Reply-To: <20250210070034.1998011-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=32b8cc8c-f4d6-42a7-884e-ae219bd17cf5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T01:54:23Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB8757:EE_
x-ms-office365-filtering-correlation-id: 541b0e77-5f07-44ef-f617-08dd4a3f0d88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?y9jqTwJHG9BAGlc7BazqFeFPr4j730Qid2V3BX9ILvlsdzeeM9zcnUL35jyZ?=
 =?us-ascii?Q?ip9IN+/6NhOljZ+DD3w6WnaWthAML/gdAWb79QSVlJl05uWNJwPy6MBLL0P7?=
 =?us-ascii?Q?+2jFz20eFojL2B6CxjCOXbjkaVr8XIjm/PQ1DxP0u+NC+/YeGCgdkdMOjsbX?=
 =?us-ascii?Q?69Kl82PoSCsPHlCwkm2mhpIGnHQXHmOtTSGTOn8z7Xsi7fc5o+tUG/V7FMJx?=
 =?us-ascii?Q?xcaMVOTGQxGuUTUrsi3kFRGds8f1am8w1fPNEQrmrffY7Nq4F0gz0QS7M5oD?=
 =?us-ascii?Q?MMPadN87RMbJ3/oIoqg1eZKvPXBVCh6lTY0CisCwyeWYnSam9sevZiL8JhIi?=
 =?us-ascii?Q?7TGXps/QKwcqDhJIiP8JpaU7W4tx0ASchA9ybtOGzQ05HZGenVKLBvVM4gbC?=
 =?us-ascii?Q?BjMDmiujswXQYmsT2DV2h1tdeGE6PdhbIXkKw400Ifxpl7ARKK+TJIxQfZr9?=
 =?us-ascii?Q?8N1zDfbY6KrwQnAAo0/7ypvA8KLOX94DxGFYDxPELLXpMG5nLWgSq3mO3D2K?=
 =?us-ascii?Q?f82PhqU5zm+Dz0dcHFbD3eywL4x2K1jWoyqtDXBZRaWTvN8fBeGZl0zJv91A?=
 =?us-ascii?Q?lFozQ5QwwIqQDah9CtSQAhzf5k11zfCB3WEWoznGRWOoHPw3cXfnTECG7ryy?=
 =?us-ascii?Q?Rj/AE/pm7Fn9XQ2MCYHdiYMjl3QRIWqObIgx9WZEdrD8X7RekEJDuO+A9qZv?=
 =?us-ascii?Q?aAxUMg1tjVX94ZEyfHSuZdyilccg67QR60sjgfvg8K9CB1InAMqvab7dtV+1?=
 =?us-ascii?Q?WHJgkxSTEY5X46LKk+zDwwwptXcRSx3BdOw2Lr3Gfs0gc9R1UwSN8yUO/nkg?=
 =?us-ascii?Q?MjAhjFkbhBdbpr4x4vj92kSp6tcmYM9wng3ZCnsDSqpNGzZvjfxGzKBe38Gl?=
 =?us-ascii?Q?Arbmq31PpmIIvaSiKamrcbk5ImzQRaB7HrTD6l4AHDKKcQgcC8+pF714tU+l?=
 =?us-ascii?Q?jTOCEDj64A3mSb8BN9usHYvEg7knPZFc4D3KGnnK/eHhOCWcxU2waRj0h19E?=
 =?us-ascii?Q?/oscvSxsQsvLg98N4GJDF3RsGaM60Q1gKbX5DPFh91UM6hheYsBSiw10ajBK?=
 =?us-ascii?Q?bLB3NfFH7vj9/8aBXYKvQKa1baR2L9JXi6C7mrDIOgdI/ngJbQKINb6q2WcV?=
 =?us-ascii?Q?S2+41jCh7VoCmeHb3ExcZwArvDyFp5vss85vfGdgL1/xKGx/9Ie2OEGbNyhZ?=
 =?us-ascii?Q?K2k3R1DBkd0UsYejPntstulJL6sZXjnJ2LQZ90SgZ8ZXyEbPmZnl18NTYc4H?=
 =?us-ascii?Q?XCOXxuuAHPS0keJxBxCR2KPIPh4hRfJk+aNoXSG+T20GL5LdfPq8M+V5p7o5?=
 =?us-ascii?Q?meC8kgw+iJuuqh8lCFc3aDkz9mSfHFPRNCiKEh9z/RvwmBbXJ1b93+47t/+D?=
 =?us-ascii?Q?TDbTR7rZ9pZU1r+i3p6YZgAbu5tp9/f2POgUBioGJVzTtNDtfx80GlK14apP?=
 =?us-ascii?Q?pusRfz6J5aE+Q+KUQ/u5j+pOX55G8dMU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1a+h4lnDW3SKRFILOje4EZS6wEyTILU3o0VQjIUB3/ofgEvCyj5us/fhjiRn?=
 =?us-ascii?Q?wR99WX/hwbipgXa2Z9Up3EX/9dz/uy+xbZJJIxawM1CoocW/lfxCgAchFL4C?=
 =?us-ascii?Q?ryOwVz1b8lPNYJQltWtHqZe3TUZxU4H7s39DDD+4Tj0s+UGQIDN5P6Fk+rk3?=
 =?us-ascii?Q?SE6Wa+yPq/DAh6skSVT2Nxxf3TUJ6wrILD5649zxQT9PSj4jULaULfN/s64Z?=
 =?us-ascii?Q?fR7AuwfAYoHL20ZKC1wppfcbHmo3GJsfpO69A6jpvnRJJg7knev6xKlwYuS9?=
 =?us-ascii?Q?mJRYJivnO4mHPgp063o1kT8yL8IM89EfEiCorklU4XiHRqHksBVkpoBDJnYl?=
 =?us-ascii?Q?KEicrCWspSZG2rOEd1WpuJU/8svOKg9/qtz2e9gcaTP5rzZSiePnOypn/C4q?=
 =?us-ascii?Q?k0eL/wDuUGSA2l8yuFgj6AhzCGb6g0vo34vdP7B9VU6NrSP57vnQqR0Jmjfm?=
 =?us-ascii?Q?509GVwsVzycukeSeTo535UWI6dfDUWVGliXCpYLeaYNXnn8ctc7s3qzQtipn?=
 =?us-ascii?Q?7HEt8yox1iwG3KZX7pf4K7Mfc9P5FgK3eUijm3p9spwU4YmNGYy0WbD/Kkdq?=
 =?us-ascii?Q?IZdvJTpfxxp/XRUJZh3fdP3X+23wPTIHQjDACxI8HGA/aE/9wD94DPMB5S2X?=
 =?us-ascii?Q?VRvHE9YvqqSCqYYVTjelQQOjdaGydcYwHPvsEjcmpCFeXyHN7tGC/to9WbFa?=
 =?us-ascii?Q?l/ls9GxZMlrlrMm7t3g+BuCEmrYn0tNTxiGv+eL2Rjhi18WXp3lPFr1cs3fa?=
 =?us-ascii?Q?TcScrYxigRF4vb3yz34TWQyarW5FWqH9mTCojlivWJZEbC9gemZSo4GeAmS9?=
 =?us-ascii?Q?GGduYKs/2jH55PZ7xHTNXAS/T6oi6xtCk62bF5pZtI5/P3oJ43joIPN0SkwK?=
 =?us-ascii?Q?OfxAN6Swx3rT5D8i63vVu2dexvY5E4UPVHSx/IBNkC35qs7pBknjFYlhuy6V?=
 =?us-ascii?Q?KuFOrkaiezPVYV9G06SCXImPH93uWclBNxPWOCBtouBHVoyRBgQ34uW1YyHG?=
 =?us-ascii?Q?u87VZgG4VXBv75DRU/Zxb//XslJBeXJoJBJSnacxqT7Rtsq1q6X6FOeY92Rr?=
 =?us-ascii?Q?QUl/cKBpO2okQ48lIun4X5mY7u5Z/bbrRZy0L1mU8WpzpWD9G2Atl4WkK5if?=
 =?us-ascii?Q?eFsYk6Z7xnxn5mfuXKbxAN2MYpehlnBdq8bcAg0DbLc3Mwa4IPK08UamApmT?=
 =?us-ascii?Q?JjXDT+d+MVIfinC80hTlzfWUInTRxG/LvTxmYFS/o5KRTyo/ZCiSeJ2ebHYY?=
 =?us-ascii?Q?pU5Bhf9ENamyGZ0P3OS+MmfTCx9EyKxTOkFW0SZWXOJA8Wa3GYLchPeWRW4g?=
 =?us-ascii?Q?jiEXeKbwjl98S5C00FtQf3U7MDLd1Fd0zVlOZ+Vm/a1w1tpkA8DRoywGfjp7?=
 =?us-ascii?Q?igFC5XcGlwdBfA0CjoFES1oTdgW292IyLHYWn/aXaoWiFqKtV6+EX96btihr?=
 =?us-ascii?Q?lPsQlojXQb3qQ0631wDJiND1VrRkN6sp8uNC3yPPiRDR6ClhE9VyjG9a2djz?=
 =?us-ascii?Q?yIBBS+fcAv7OTBElMISXH78jL5NhkaG8cAJOFHx8mKn3UTo7kBeTeyO/fGUq?=
 =?us-ascii?Q?t6ajqibxcX5aP8Wv2CE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541b0e77-5f07-44ef-f617-08dd4a3f0d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 01:54:42.6449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXmaMMUcvuIx8FxHraP1E5mwRYNqwEi4hMy/Q6SmfcpvpkFeYphKjpETICzApyVjcSIGkpNHwEbrpnJBqEYJLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, February 10, 2025 15:01
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Move xgmi definitions to xgmi header

Move definitions related to xgmi to amdgpu_xgmi header

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  | 23 +---------------  drivers/gp=
u/drm/amd/amdgpu/amdgpu_xgmi.c |  8 ++++++  drivers/gpu/drm/amd/amdgpu/amdg=
pu_xgmi.h | 35 +++++++++++++++++-------
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h
index 459a30fe239f..bd7fc123b8f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -29,6 +29,7 @@
 #include <linux/types.h>

 #include "amdgpu_irq.h"
+#include "amdgpu_xgmi.h"
 #include "amdgpu_ras.h"

 /* VA hole for 48bit addresses on Vega10 */ @@ -174,28 +175,6 @@ struct am=
dgpu_gmc_funcs {
        bool (*need_reset_on_init)(struct amdgpu_device *adev);  };

-struct amdgpu_xgmi_ras {
-       struct amdgpu_ras_block_object ras_block;
-};
-
-struct amdgpu_xgmi {
-       /* from psp */
-       u64 node_id;
-       u64 hive_id;
-       /* fixed per family */
-       u64 node_segment_size;
-       /* physical node (0-3) */
-       unsigned physical_node_id;
-       /* number of nodes (0-4) */
-       unsigned num_physical_nodes;
-       /* gpu list in the same hive */
-       struct list_head head;
-       bool supported;
-       struct ras_common_if *ras_if;
-       bool connected_to_cpu;
-       struct amdgpu_xgmi_ras *ras;
-};
-
 struct amdgpu_mem_partition_info {
        union {
                struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 74b4349e345a..03d909c7b14b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1671,3 +1671,11 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_dev=
ice *adev,

        return r;
 }
+
+bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
+                          struct amdgpu_device *bo_adev)
+{
+       return (amdgpu_use_xgmi_p2p && adev !=3D bo_adev &&
+               adev->gmc.xgmi.hive_id &&
+               adev->gmc.xgmi.hive_id =3D=3D bo_adev->gmc.xgmi.hive_id); }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h
index d1282b4c6348..044c4f6be44a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -23,7 +23,6 @@
 #define __AMDGPU_XGMI_H__

 #include <drm/task_barrier.h>
-#include "amdgpu_psp.h"
 #include "amdgpu_ras.h"

 struct amdgpu_hive_info {
@@ -55,7 +54,29 @@ struct amdgpu_pcs_ras_field {
        uint32_t pcs_err_shift;
 };

-extern struct amdgpu_xgmi_ras  xgmi_ras;
+struct amdgpu_xgmi_ras {
+       struct amdgpu_ras_block_object ras_block; }; extern struct
+amdgpu_xgmi_ras xgmi_ras;
+
+struct amdgpu_xgmi {
+       /* from psp */
+       u64 node_id;
+       u64 hive_id;
+       /* fixed per family */
+       u64 node_segment_size;
+       /* physical node (0-3) */
+       unsigned physical_node_id;
+       /* number of nodes (0-4) */
+       unsigned num_physical_nodes;
+       /* gpu list in the same hive */
+       struct list_head head;
+       bool supported;
+       struct ras_common_if *ras_if;
+       bool connected_to_cpu;
+       struct amdgpu_xgmi_ras *ras;
+};
+
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);=
  void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);  int amdgpu_xgm=
i_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev=
); @@ -70,14 +91,8 @@ bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu=
_device *adev,
                                        struct amdgpu_device *peer_adev);
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
                                           uint64_t addr);
-static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
-               struct amdgpu_device *bo_adev)
-{
-       return (amdgpu_use_xgmi_p2p &&
-               adev !=3D bo_adev &&
-               adev->gmc.xgmi.hive_id &&
-               adev->gmc.xgmi.hive_id =3D=3D bo_adev->gmc.xgmi.hive_id);
-}
+bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
+                          struct amdgpu_device *bo_adev);
 int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);  int amdgpu_xgmi_=
reset_on_init(struct amdgpu_device *adev);

--
2.25.1

