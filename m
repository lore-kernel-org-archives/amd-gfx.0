Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BD9CF9C6F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 14:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8D310E200;
	Tue, 24 Sep 2024 14:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nAUletLi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA8F10E200
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 14:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UasvAHU/+SS8eFzO0MUZgiv5ggIM9WCMM0wK8Pls6wSspxfC2Pb+1nvEXBxoadXwU/XALOVnWjijqJ38S46ikWxHw/BH9KMhS9Z1sgFqzivnnK6+cNHhW6hp528mS79g2tHerqAsd4r7k48aL8lWnv4spUNLU8D/G6gzODV3H831GreV9oPjH25JjyGwxFUHznDqKHYlxGo15gap9roC/vPjJSt6fXJqWmnOjdIs70L1jUyS748bFuNnijNH2jyJP3oVN/AK97kMx7z6Fjssm2XWlHtxlH3r9h1PItTQWkyU91FobCvDbSGU7V1cE0hXnHWMfu5HhsXZnrm39GEk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp/tIvQFLrSAsjkYhwCwk25BN2Jq5FKw2RfIydThvSQ=;
 b=FX2EYp8uIjsDQrx0NKc5qgECXw/RXXOfw3OnJkKJvFVQH2BpntaVmCpiW9nGBMo2qPpmg8IFOn5I46fclmGIi1GZ+5AaqbECucLa8xOJW26ZS5ItucabB98dA8nFX4WhitNXIFfTSn57rLPx9DDkoTYVf0/bbGEun9+HkDt/EGDJEGC8llF0Mnmb9C5qb0cR/e+qJfLTH5CROjV3L+XFf/EQzsORsGl3C1DVwnb7vXulgtS7rIfWyblr0KeVb/0LltZ7gZAtdCJRECVCsEPi4HwoEMSwZeNNFTYW6tZT5UST3QyKdFj7+RCzxePzqhqvyeiFvZWZs29Dyk3JBRCwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp/tIvQFLrSAsjkYhwCwk25BN2Jq5FKw2RfIydThvSQ=;
 b=nAUletLi6hEOb6olhLjW3cu3iUGuzUjL7xRqoWzq/PQMJi2K8boF5TtDaJ5oFT2MnK1uKDTnf31AWrXHTDjc14BuRT+XXt1Hjo3ILP7E3QGCThtVdmzmQSbmcNwaMYTQJeUI2pyRrtMEx6oT7QTfxfIajiHn+8xsHHwlS/CNnMY=
Received: from SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) by MN2PR12MB4127.namprd12.prod.outlook.com
 (2603:10b6:208:1d1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 14:16:06 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::77) by SN6PR2101CA0020.outlook.office365.com
 (2603:10b6:805:106::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.3 via Frontend
 Transport; Tue, 24 Sep 2024 14:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 14:16:06 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 09:16:03 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 1/4] drm/amd: Add helper to get partition config modes
Date: Tue, 24 Sep 2024 22:15:46 +0800
Message-ID: <20240924141549.244754-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 98284c20-5e80-447d-2f06-08dcdca36e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BOFF6MLAx/BG8K5BD7+MrRqZUErish55Ax08Q6Xvtswpfd2UiFfF0SxyHTqE?=
 =?us-ascii?Q?xtqpRVn/sGu+4YJyeV6OmRO9IxNyb8IaiaNf2LneqxMkd0s4OAPm/qy5SA7V?=
 =?us-ascii?Q?yq/k4urTXnOEI9CGUip/sdAQ1yPm9RhR4WQs7zyYpFW4PSqj5St7h0ZbR8DR?=
 =?us-ascii?Q?+UABBM5jnCa/9CL+7bTy808r5dlCfp/dn7yU7cz49/+CnKgkbZrbM1ItRRCH?=
 =?us-ascii?Q?6IqCT7zRWygst/yXW4nFTXSkV0geDe0kIMFRWCTOn4ttAecsHA05c58lLrKP?=
 =?us-ascii?Q?XHoomS+7BCI0PgT4D0jBJNj/3FyqYyWTo0nzk3vE7vMd4BY3ZCgZAGjk9MCa?=
 =?us-ascii?Q?OPKCBxqBEEQOdYHNET9TLbWL+Av54irgVgbpXPrzmXicwqQxfIxxK2r55omM?=
 =?us-ascii?Q?/pe0sb6jXhCk/tSLWxKRCCpg6LDbJ6nQcdJAdOft8ZoZeyCsUM5YPGYJP0hR?=
 =?us-ascii?Q?4Wht3ARpFIHJ+8Sd61UcxIhlUAhMZ2SNLc13xOrmTUdQFv1h2HmaPCQ7sOrq?=
 =?us-ascii?Q?c6UYLLYUdRgu6SMHfHBucj+eTw28oCMIm4vZD8auMJBTI0txsKlG9oQKtPht?=
 =?us-ascii?Q?y4iANfadVGGI5LJB8vNvhE4TS5574aiw95+3XTjFeA+zZKqaDMfMZVIFScoy?=
 =?us-ascii?Q?vg481PIrmoRUYz+ij9tm0p/s82gJipV8TyeNdqGEUZDwyNUcK0bcM32VNtSy?=
 =?us-ascii?Q?KFQvFUnBA33+u5FmB1SEmpG3SxNpMnG61rgRZIIyjQgVbJ0xo1VaTG7zSdpg?=
 =?us-ascii?Q?G5sltgpv7iGY7CbQHVk0y1tqazQ2sBLL/YkysIjAJDG3v6irNnny9+7anNU0?=
 =?us-ascii?Q?7VESIk218ePH7D6bHGdWcAUP041JwTa1bU7paA97Dn91Er5KFbbgyzFlUh8P?=
 =?us-ascii?Q?TEfgsROo8Ywl436dxGoTBG9ZTV6x9z4qe7Exjs1vsUdZ14vgSxCQ8PmJZTrs?=
 =?us-ascii?Q?AeQYY3HYlCJz99KNzKc9ic6TpthiB96x09ZjUOxaretxdwjJ1Iua9oteg1a5?=
 =?us-ascii?Q?hhTrbiQpxWvpZzHUBA/9RDF1Pkigdix8+ao7QVkaWLu6NTHHthLJZxvbgt0K?=
 =?us-ascii?Q?lxssCVFKxCxYc41VqsMllJWIwbscqkDDQtKcg5I1RsE2DvxEJ6UVMxd3tpQu?=
 =?us-ascii?Q?bUk7NePiGzRWCUkqpd2MqKxcgq1dHvZtKtPGbCL2gzN6QdF+Mzwu7GO2XX/L?=
 =?us-ascii?Q?1TDipvOui5fcU917YKX42pIRwNzeEcB1EWUpXCPa63TY4cDEWnLKd17yazQs?=
 =?us-ascii?Q?9CBovTqqBHeLOTLVr2AZTamMF5hWQlXol4q4ICKm7nHBS8dgtchSq8lFT5Fs?=
 =?us-ascii?Q?OVQWzqlDxaqt0lThVOlYjQb1Epu3XjM5Ar6dLmNqeYhMwzkDVPwn5n7Swiqi?=
 =?us-ascii?Q?klIG8IHC2O1iQWAHh/ftgVcepT5RNv+t2ZR1hZwOxF8dZGZ0e8VZc9MoxxLC?=
 =?us-ascii?Q?12CQ6JjqsuHa6cZJnU5KQfBI/msKIoWt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:16:06.2993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98284c20-5e80-447d-2f06-08dcdca36e0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add helper to get supported/available partition config modes

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 40 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 54 ++++++++++++++++++++++
 3 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 83e54697f0ee..2d3fdb6c3161 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1363,35 +1363,35 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 	return count;
 }
 
+static const char *xcp_desc[] = {
+	[AMDGPU_SPX_PARTITION_MODE] = "SPX",
+	[AMDGPU_DPX_PARTITION_MODE] = "DPX",
+	[AMDGPU_TPX_PARTITION_MODE] = "TPX",
+	[AMDGPU_QPX_PARTITION_MODE] = "QPX",
+	[AMDGPU_CPX_PARTITION_MODE] = "CPX",
+};
+
 static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
 						struct device_attribute *addr,
 						char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	char *supported_partition;
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	int size = 0, mode;
+	char *sep = "";
 
-	/* TBD */
-	switch (NUM_XCC(adev->gfx.xcc_mask)) {
-	case 8:
-		supported_partition = "SPX, DPX, QPX, CPX";
-		break;
-	case 6:
-		supported_partition = "SPX, TPX, CPX";
-		break;
-	case 4:
-		supported_partition = "SPX, DPX, CPX";
-		break;
-	/* this seems only existing in emulation phase */
-	case 2:
-		supported_partition = "SPX, CPX";
-		break;
-	default:
-		supported_partition = "Not supported";
-		break;
+	if (!xcp_mgr || !xcp_mgr->avail_xcp_modes)
+		return sysfs_emit(buf, "Not supported\n");
+
+	for_each_inst(mode, xcp_mgr->avail_xcp_modes) {
+		size += sysfs_emit_at(buf, size, "%s%s", sep, xcp_desc[mode]);
+		sep = ", ";
 	}
 
-	return sysfs_emit(buf, "%s\n", supported_partition);
+	size += sysfs_emit_at(buf, size, "\n");
+
+	return size;
 }
 
 static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 32775260556f..2c54c05f2c16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -97,6 +97,8 @@ struct amdgpu_xcp_mgr {
 
 	 /* Used to determine KFD memory size limits per XCP */
 	unsigned int num_xcp_per_mem_partition;
+	uint32_t supp_xcp_modes;
+	uint32_t avail_xcp_modes;
 };
 
 struct amdgpu_xcp_mgr_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 5e8833e4fed2..2255ddbb51ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -530,6 +530,57 @@ static int __aqua_vanjaram_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr,
 	return ret;
 }
 
+static void
+__aqua_vanjaram_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+
+	xcp_mgr->supp_xcp_modes = 0;
+
+	switch (NUM_XCC(adev->gfx.xcc_mask)) {
+	case 8:
+		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_DPX_PARTITION_MODE) |
+					  BIT(AMDGPU_QPX_PARTITION_MODE) |
+					  BIT(AMDGPU_CPX_PARTITION_MODE);
+		break;
+	case 6:
+		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_TPX_PARTITION_MODE) |
+					  BIT(AMDGPU_CPX_PARTITION_MODE);
+		break;
+	case 4:
+		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_DPX_PARTITION_MODE) |
+					  BIT(AMDGPU_CPX_PARTITION_MODE);
+		break;
+	/* this seems only existing in emulation phase */
+	case 2:
+		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_CPX_PARTITION_MODE);
+		break;
+	case 1:
+		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_CPX_PARTITION_MODE);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void __aqua_vanjaram_update_available_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	int mode;
+
+	xcp_mgr->avail_xcp_modes = 0;
+
+	for_each_inst(mode, xcp_mgr->supp_xcp_modes) {
+		if (__aqua_vanjaram_is_valid_mode(xcp_mgr, mode))
+			xcp_mgr->avail_xcp_modes |= BIT(mode);
+	}
+}
+
 static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 					       int mode, int *num_xcps)
 {
@@ -578,6 +629,8 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	amdgpu_xcp_init(xcp_mgr, *num_xcps, mode);
 
 	ret = __aqua_vanjaram_post_partition_switch(xcp_mgr, flags);
+	if (!ret)
+		__aqua_vanjaram_update_available_partition_mode(xcp_mgr);
 unlock:
 	if (flags & AMDGPU_XCP_OPS_KFD)
 		amdgpu_amdkfd_unlock_kfd(adev);
@@ -673,6 +726,7 @@ static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
+	__aqua_vanjaram_update_supported_modes(adev->xcp_mgr);
 	/* TODO: Default memory node affinity init */
 
 	return ret;
-- 
2.46.0

