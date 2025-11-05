Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60F0CCFA13
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 02:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B10B10E69D;
	Wed,  5 Nov 2025 02:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3iHSrg+x";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B50810E69D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 02:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXH15a4BMbcKuIHopjjR2yQZnwYyxET/VxSEIBmexY2svm2pgXyZl/bxw+C2UBbOtXS9Pv7WZlWoy99Uk1YqDCXSXws3An8/6xo+IWNMNGD4x7z1H17EBLH+wWoX5SKvL+0+NHjr5fS4ajLudOX2wetNQY2mPjI+Nv+SDW+E5/mgH8kDAwWk/yO3GGuECvd2qWGVZSunW+3dA/+Vage1psp6iT0Hgw6ZRrS6fFJJhOiSaEm7zn0XlFZkw2gpg1pR32T3uO2DBO5FlU701KVGGy5Pz8ullbhMjSZAZoxmg1PNwa+Sk+pbHzSGb57YVcHKeNo+/E1APtO4VjtGKLYmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Psa7BuQ38+cmRjpNaFuO6VrPgGDg8TV6gJtpMQQXYpQ=;
 b=MzPvljwRf0Bzoj3NZfY4h/AemY+Es7qdUv9cZ0WsU6mLjw5FNPme4Z8ir4rRI7m7fw9LDk8VLQ4iIWKjwDvxu8OFCCQ5F3HBG0DqyXFMcHYu6/3agj6UakpGy0PraGpWbn4iTWPy/uknt7pVoCbxRq3OlGOPxQuJNHQ0Tz9pIyl6XLqtv/MxGONhLNdeE+4E27449LvrMvt/sc+H3SaucIt1KSUraAi28oy+wvC93vhZffPYTJ6yRBe7OfYaa9Of5JUXDO4PuY1wIF9tmfRQ6G4Mcuh51u7BiKfGnpAmAGtdAL6/OT1tX2/Ak6zVd71QerANY82hyndNsJtPJcgl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Psa7BuQ38+cmRjpNaFuO6VrPgGDg8TV6gJtpMQQXYpQ=;
 b=3iHSrg+xqkIDAHR5rLEdNOZxmbkpmAkluE4qTZodRAu3kr4Soq/z55SV8h6nlab+zTH9HFuzDuh5sFd2ej6kj01Z0tQUdVqrPl+2MGCbUsER/OQt5jhHKwQeq5+2kKGQK5xqaNnn2d3JPPi1l5im3lvsDaJ2lFihXtvR42NT1qU=
Received: from BY3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:254::26)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 02:05:06 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::ff) by BY3PR05CA0021.outlook.office365.com
 (2603:10b6:a03:254::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 02:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 02:05:06 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 18:05:00 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: get RAS bad page address from MCA address
Date: Wed, 5 Nov 2025 10:04:43 +0800
Message-ID: <20251105020445.1423034-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105020445.1423034-1-tao.zhou1@amd.com>
References: <20251105020445.1423034-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: f92280b2-5f47-4bd2-fdd3-08de1c0fbdc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?khzMZ5uzNq1RsFyK0zFuY6gvVRmIpemGwstzJmFZ+Am4rqOnndoV82wFTaM7?=
 =?us-ascii?Q?pvDOSVCDc0+Xwx4ZMKSkKAgQjDsFgO9UGudM0J2nHCdyz9nrhudcDc8CENsq?=
 =?us-ascii?Q?3lXa2k56P0CMRs3m310bP+qhPsvLN7Sgl2pZYOcOZ8H2aiApd7eNjdj/0cY0?=
 =?us-ascii?Q?hgYzz4PqdvvmVV8XzMcP+Lqo0ph+iSHmnP/XLZKHguANyn/LEmsTW7rJ9UQA?=
 =?us-ascii?Q?90Oi9BQyxf6w13xej3WOqCM6SlhAJn/TEBaFKYTxK0pR3OQy4HOYGUNbJeG0?=
 =?us-ascii?Q?Vpvat+FF2wzd9/jwgrYSTPXgOeqdIxRpKv9XNyoGMzc3Ze/Y2OVxFaVWbclB?=
 =?us-ascii?Q?98QE3Vg/Ybz/+RzlAsC7iCQJsXEfYoKnsGRhfC2ks2bAUV6WL1WFDtnhX+v1?=
 =?us-ascii?Q?5klW8ptVqRCO5RITos5vG8sU4gidiecggtKobv0MBpuwVqAlGbyi8yfK2Ybm?=
 =?us-ascii?Q?Yy9cxXRcT9DWNK0W9l2mZt0Avg53cD177CLcrYfMDFImYTXNM1kPywLZhFfv?=
 =?us-ascii?Q?200M1WZ2nWGIATNSSGGIBsFj4b+RSxWHBlMxkwyzEht8jT7yK3/cW51O71GN?=
 =?us-ascii?Q?JLXxrSBVGF4ytP1dOxIJ/UR0iNlaFGxyl4PzRcmBIUllX0o2dPeR9VmOn5de?=
 =?us-ascii?Q?T79sbMThDMBlw2hcVgFQiFjMZXPFq1eoZH+W+V5aRhXeBnBCQzcgIARbK17E?=
 =?us-ascii?Q?FE7Ms2HeEoXTuV1xqjOy8ZMVNVa5uuT1bZxvWC3zWlI4Hw4lTZFej8V3FSk7?=
 =?us-ascii?Q?1MZr+r8jkShiJMAQc4Ij3jsI/T6cWAUjDEziTo+CNfZ3NUnpcT0xqZDPRNT4?=
 =?us-ascii?Q?oYc6i6jfnTC7TuoIYxpYqTpfHMMinJ/0eFWTiCG9OnpXN1mIxeTALIZxqqAs?=
 =?us-ascii?Q?k6eAkmsShXUOb0v96cQG3iVuK8A6XzInbXJVWpyvRpwaZrT245D1J/8tI6AL?=
 =?us-ascii?Q?ho1AqY00Ll/tiBIIdfOonKm0//edka7RUM696EmkHNgOAvjF74Th1shGG5iR?=
 =?us-ascii?Q?zHlgdherQWkChTxIlzozabJWgeQczID4ddc7jtCPvvht9I8BRCRSEbOzMnJK?=
 =?us-ascii?Q?FeuaBeSnHutqidPTWCsiXPneeDXAyj/CKDRt3fs6d8924aHTsGviNPBA6BDV?=
 =?us-ascii?Q?3vn45ToklXrRzmNALtkq++QmJdTbyi7OtcsQigvzVdiD5mdo1RVH4fG6si+5?=
 =?us-ascii?Q?mzPjAly/RwijEd2VDBKsrVaeSkUb+NA200O3/BQUpGOf94milI5+251nu4P6?=
 =?us-ascii?Q?QGhpYWZYx1Aq8xdyGqTURoHuefy6Nssp9olQ3uFkD2EMu5eM4E3zLw1aCuek?=
 =?us-ascii?Q?MueHuvbl4MPwY+fdcHk4UsR+WYO4hTDNJYkotteoosCXpmqx4AJtwJiieup5?=
 =?us-ascii?Q?YTWLNS9tX+X4zAIIa7vn7khWrN9cPVhImMwukxpLfe35+yHd2kja5ps2NqIJ?=
 =?us-ascii?Q?HN92xuqSZteuNVmDh0nbJWa/2dCFSkIyNDgtljpuDXm/EnPWkYCLvxQxPZmj?=
 =?us-ascii?Q?MrgtbU8Z0/5li+mS0mBTEyGmnmNZRWrBdNRfFlNPCLhLAxOACvd0K+8wOAhO?=
 =?us-ascii?Q?yzvusUWchQf2v20d25Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:05:06.5861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92280b2-5f47-4bd2-fdd3-08de1c0fbdc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

Instead of from physical address.

v2: add comment to make the code more readable

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 81135cd45d0e..ac00bc93f34c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3010,8 +3010,13 @@ static int amdgpu_ras_mca2pa_by_idx(struct amdgpu_device *adev,
 	addr_in.ma.err_addr = bps->address;
 	addr_in.ma.socket_id = socket;
 	addr_in.ma.ch_inst = bps->mem_channel;
-	/* tell RAS TA the node instance is not used */
-	addr_in.ma.node_inst = TA_RAS_INV_NODE;
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		/* tell RAS TA the node instance is not used */
+		addr_in.ma.node_inst = TA_RAS_INV_NODE;
+	} else {
+		addr_in.ma.umc_inst = bps->mcumc_id;
+		addr_in.ma.node_inst = bps->cu;
+	}
 
 	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
 		ret = adev->umc.ras->convert_ras_err_addr(adev, err_data,
@@ -3158,7 +3163,11 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 		save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
 		bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
 	} else {
-		save_nps = nps;
+		/* if pmfw manages eeprom, save_nps is not stored on eeprom,
+		 * we should always convert mca address into physical address,
+		 * make save_nps different from nps
+		 */
+		save_nps = nps + 1;
 	}
 
 	if (save_nps == nps) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 64c004a2b767..425aa44446cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1019,10 +1019,10 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 		record[i - rec_idx].retired_page = 0x1ULL;
 		record[i - rec_idx].ts = ts;
 		record[i - rec_idx].err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-		record[i - rec_idx].cu = 0;
 
 		if (adev->umc.ras->mca_ipid_parse)
-			adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
+			adev->umc.ras->mca_ipid_parse(adev, ipid,
+				(uint32_t *)&(record[i - rec_idx].cu),
 				(uint32_t *)&(record[i - rec_idx].mem_channel),
 				(uint32_t *)&(record[i - rec_idx].mcumc_id), NULL);
 		else
-- 
2.34.1

