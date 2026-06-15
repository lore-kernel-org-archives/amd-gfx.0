Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CA8CD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 19:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BEEE10E5F0;
	Mon, 15 Jun 2026 19:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BIFepazd";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6CC10E5F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 19:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jppliG/grACkt+hhNM8TwXad6aRPPuERBf4RLdubBJU/Xo5w12H/LXcflFFiwOJ6I496TpMEKkjMqEhg24xq+sqfoSZ7A+hCZoAZFwRzF9d5w7Vnx8LgnNKhkP1FCC6enmy9+wmPQWmDoRXy4uTsxOv9/gpL+lsrv73G92f5FTiW+DvjYGW3Sv4Oaq8n3X4vGfyrGzkHt7DeLMmOqL9Tmha1KE1UT+aEmluiJJ5zZnTEDXAMSCrD2AzP+cLtLBn3aXt8OpoUNGkDq4O9CqPhCxS39bW6XyGFL3UbATJn7GxOHApptdO4Ra/Qc1aOTIae4x5lH572BLZ86dQeWntfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCQ886BPikjEQg2vtuJ1mD9HAmLAMu71UOTahqvhbfE=;
 b=uROrYQprI5URVfAdxNav/shH5Tz98Q/bVzYqsajSlFbsmoJpvEefJqBfcbH2DIz4mwuuplrIXKa3c0AwE1jsWa+Or0EZPbNsSHN9Q4mkdIPPdfvb88r0SIICxaWgILrBmNk/O+sIPTKzgQyC0WSOsKC1GXmTXc8CZHu5o14btkogWjX2lirV/MevoQ0eFqw4CMIy8SY4EMhrPSi+3mpFSA2iF/0WaTTjGhcZzh2Cn3tolpGPxqt4u1FogJCMsWOaHXEZvYX+Slwxvm29DjcNzvp3ETDOORtqZiHaWwXTl0kE9/vCJy0NNF3j4pnuECwnHXw/css9nZ63C6lfmrf9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCQ886BPikjEQg2vtuJ1mD9HAmLAMu71UOTahqvhbfE=;
 b=BIFepazdwLyRygOJrE4KB88VvtzFRI2jwm6B++RcLjCd+Liz+1XTIkg/bC5Nk/yeGLIVXJMsiX6USj396s5SBdCKF9I76BiCX3HV+1+zYQAZb6sh00p0YueYXfZMu5M9jlAI79GL8jYqeB07C8G3WyTQD74zyL8M9nWM+poS0yU=
Received: from CH0P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::29)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 19:35:39 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::26) by CH0P223CA0012.outlook.office365.com
 (2603:10b6:610:116::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 19:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 19:35:38 +0000
Received: from ruijing-dev0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 14:35:37 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Pratik.Vishwakarma@amd.com>
CC: <leo.liu@amd.com>, <boyuan.zhang@amd.com>, <ruijing.dong@amd.com>, "Boyuan
 Zhang" <Boyuan.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add UMSCH HW IP
Date: Mon, 15 Jun 2026 15:35:18 -0400
Message-ID: <20260615193518.3989770-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.49.0.593.gd86a19f485
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 6801253b-0861-45a9-7c13-08decb154788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|6133799003|18002099003|11063799006|5023799004|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: W7VtlSMOt8Pd5KwT3nxM0i28RSVIe1dpChMgB0KNoxUVm0rSvsw+FqImfn8GLlDz45CNGFh8eJX0ncuQNCymr208X3dufXhcFbdCnvWkqwErzOlfXwhRIz1cRnp4hZKqGX5ZB0SJn18t/yIQfi16hYKOc7AnEZXYNGrzgGzMjLVF9kVmQqVWyN14WoIA9zaVmI0PE/DeaP2bq2vjr4hAJw/YJcVHqIVv3X3fAREjka29PcsB4EzXOLEZta8Ia5Q33VPT2iK9TTmm4sXuiBLgjFeXMaOgddayrN+WJx9KNZAl8Racbob5iklamAlPq/268jHA4ZPUspXjayHXSD01RYg0+LSddh5vvq6Ugct3COCeW8hDsuK7h7EsAn+hD08c9poUycqAO2OKx+UNORdLxkfGRsDGmmw+BaFVCatCDtWV9uv+j8edfYuNLd50W1tL7mwmQrlm6aTSioyGJ07dYTKVgDsbj2cY948kEAiYF3xFaadexMSN4HKkDkKKJI7H2KtAFBP/pv8NJENupKz5RgH77sgSWF2X7UMEv+NJgg/cmlCywXMHokAgs9ilLO9Sl2+TQs7LBNuh9JOCfmHfjfXga5pbCwvtqj17cMh/TJnFMEqibQbN4y6CDs7j8wXkJUEqwmvzI76DNNs3jGAFkb7T0JCqvrN4pecFvBlWksFlAbeCfNkJutaW2x6X+tdeLEa8bQIOn8kJaPBhiTmSVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(6133799003)(18002099003)(11063799006)(5023799004)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LfnMFLrT4gUpWaJrkB1sAifNiS2zZV1bX/y1hPiLMcpx8lShayGDuYfQsPNQ1n5+IqFnj7AQ25xGNl4dU6bK+6J0kV5J1nF6VhFolWNDvWJ8bG7vZ6nk+EV43agQej3rbRrGkUq5LQNaYxqh2mnM2tM40kz0U03gfLdkoxuZug7QI4Y6yEC4YnzaJUqeEMtwci8XDMxFRDbMTWtz8SQTyL4311aqcmULmoLATGeUaFv3Ur8PAQw5pHKQWcXFTWXGHAtI9uEgvQFdCbFzYcYQGK2KoiWkVHMrpoqaN3cQQrt28lM4xBz4U3ErVz+BWk9z9O1JMvze+iDIiAarSWhhtnrKqmVauvR1gOhDC05i+H3rfq87OH5Iyiz3anv0jBdEg4YGal+k8MTufiy5G7vN3CvUhcOdTfMwX0cMy4WQLkxgPsDQeMoFQdulfNuxqwqD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:35:38.7742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6801253b-0861-45a9-7c13-08decb154788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

This part enumerates a UMSCH block under hardware id (22) at version
2.2.0 rather than under VCN. Add the UMSCH hardware id, an IP enum
slot, and the discovery name/map entries so it is recognized.

The multimedia IP setup assumed VCN/VCE/UVD was always present; handle
the case where it is absent so init does not fail with -EINVAL.

Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>
Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
Assisted-by: Claude:claude-opus-4-8 checkpatch
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c    | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h           | 1 +
 drivers/gpu/drm/amd/include/soc15_hw_ip.h        | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 322c55aaf15f..ba2f15d12751 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -63,6 +63,7 @@ const char *hw_ip_names[MAX_HWIP] = {
 	[VCN1_HWIP]		= "VCN1",
 	[VCE_HWIP]		= "VCE",
 	[VPE_HWIP]		= "VPE",
+	[UMSCH_HWIP]		= "UMSCH",
 	[DF_HWIP]		= "DF",
 	[DCE_HWIP]		= "DCE",
 	[OSSSYS_HWIP]		= "OSSSYS",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2cfcfa29204a..430f68181005 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -226,6 +226,7 @@ static const char *hw_id_names[HW_ID_MAX] = {
 	[XGBE_HWID]		= "XGBE",
 	[MP0_HWID]		= "MP0",
 	[VPE_HWID]		= "VPE",
+	[UMSCH_HWID]		= "UMSCH",
 	[ATU_HWID]		= "ATU",
 	[AIGC_HWID]		= "AIGC",
 };
@@ -258,6 +259,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[DCI_HWIP]	= DCI_HWID,
 	[PCIE_HWIP]	= PCIE_HWID,
 	[VPE_HWIP]	= VPE_HWID,
+	[UMSCH_HWIP]	= UMSCH_HWID,
 	[ISP_HWIP]	= ISP_HWID,
 	[ATU_HWIP]	= ATU_HWID,
 };
@@ -2631,7 +2633,12 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			return -EINVAL;
 		}
 	} else {
-		switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
+		int vcn_version = amdgpu_ip_version(adev, UVD_HWIP, 0);
+
+		/* no VCN/JPEG discovered; nothing to add */
+		if (!vcn_version)
+			return 0;
+		switch (vcn_version) {
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
 			amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 1d0df6d93957..590ad82f115e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -68,6 +68,7 @@ enum amd_hw_ip_block_type {
 	ISP_HWIP,
 	ATU_HWIP,
 	AIGC_HWIP,
+	UMSCH_HWIP,
 	MAX_HWIP
 };
 
diff --git a/drivers/gpu/drm/amd/include/soc15_hw_ip.h b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
index a20e59584dde..60f588dd0130 100644
--- a/drivers/gpu/drm/amd/include/soc15_hw_ip.h
+++ b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
@@ -44,6 +44,7 @@
 #define SDPMUX_HWID                                       19
 #define NTB_HWID                                          20
 #define VPE_HWID                                          21
+#define UMSCH_HWID                                        22
 #define IOHC_HWID                                         24
 #define L2IMU_HWID                                        28
 #define VCE_HWID                                          32
-- 
2.49.0.593.gd86a19f485

