Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACCAD10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2935110E5F8;
	Wed, 26 Nov 2025 13:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bDymV+J2";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A62E10E5AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+bIu/omug6j2vRTQRHpUNxfFEdQu+Xb30NrbypwwaweuULvrBvE8xSPMXiT5V3AbJ/pq0Zc5jxCCKdGJO87j0rn3GrwkSJPe5V8xXnb12ut5E/OH4ndi224adp1dJUtsawpCtwwo2NX03sAX9qY2LnJ4q3ycfd1BlXu9IK7ZKmsgbKt02VL8fkt3InRkfflIbqFGTLBCDGL9v3yiBLp1nTZMrmLyrNn6fLMJ3b+dNVd/HntK0EhT3EXiMzX6LkC6QtfjTy3ZDd1iEx6cPwdHOiJO5mjB0bhpdxRok9NBb4fMF3YXojPCCLPkjj5FwZZ1QdX+GxjdvyWgvJXHYOdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6sd5P0w4e0ce8vmabXqQHqnP9y+Q6oawLT7i+PfCMY=;
 b=ZV9y1Ng71zEnwWRlM1iIRt9MLqPNxA0CjQriIJdRRJKlvLhJ2WjChJYW6EwZnhqqnj0zj8QQwz/xxORG5u42qRXQyHejoP9iEl29E7mwycODAn2Ad4fFQkxtb77btOaONs5RQGHH2kcEf1jJuphdtQBF2HgAyEGbSmbfDs5SoE9pPehpJO2K2UNAA/WtHgCWXdgmRL27HgfIlVQFYY4MdUTsD9xm6Jvoq7JNi4zysmvlFoTQte8w5/su9NYX9/A2w6Vmw50FZbWNDQUxintzapFnIm2seh6Tn9H66AK1+oLXYSi0N5WdLnPKWNhzB8ew+uPH2nyT01k70iZfLGC6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6sd5P0w4e0ce8vmabXqQHqnP9y+Q6oawLT7i+PfCMY=;
 b=bDymV+J2hYYswZpiv2yT/H4m5rBhuluRNFBmhnjWH/5pkbblMwgXaqr4EccxFBoAZvPBNtb9QqakiaLDpWzBb2XsBKhvawspnuv8Az6en5lTs5E5xP6b8nUSIxo81dheZ5AQcvmh7Sf0caPn/TkDdkum2gHm9FqtnnNoXeNBX7Q=
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Wed, 26 Nov
 2025 13:28:48 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::bb) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 13:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:46 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 04/20] drm/amd/pm: Use emit_clk_levels in vangogh
Date: Wed, 26 Nov 2025 18:53:51 +0530
Message-ID: <20251126132822.3266730-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c69cce-3d05-4089-805e-08de2cefbb68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TlDXX21qYEtCKjhqwwTZgzk8fSONWkKNnq7BzroZo7au1gnFqikO6Wt7CZAH?=
 =?us-ascii?Q?xZrA+egMPbeTP0WsHHHQMtvOKcbXi+ehg+MWOk7CPoFRw03pb+RnvJPKyOyh?=
 =?us-ascii?Q?kbHAP+wn7KfVMlhbCWaZN6SaTdJ2EGKNLkAHZWNlKQM89x/ewwX/mYUxF1cO?=
 =?us-ascii?Q?PIOwBszNUXRcMuXDRz4lQ+XPVC8BSqdACv8skUHMlcE28Jht5EAz0y1sXoXH?=
 =?us-ascii?Q?L1KQIF95ZHyufCFwLT17IHagSzHRR7O7EFj2k37mAcfKh3xRh6AGFdpbctzo?=
 =?us-ascii?Q?HR+GpS5n223G6Q47Wx5qKIIU7XSxsf6I12tuQPcAPgAEjF/raN3SBVKHSQmd?=
 =?us-ascii?Q?SH33OVY1R9o/rhRjxM2O0boQ5IOqRDFenNRZOmQzJyTYvhyrD3cDpA5eqTsL?=
 =?us-ascii?Q?OiqMcebMPWTeaU3isevs7+ZLob7/Ae04Pwstz7ho+Sv1oR3w2uuP+T4LAMBZ?=
 =?us-ascii?Q?0qJp1WTfpf+2GWx0DsU7ZDkXTj0Mm9L09C87MYYa5T7x2iIwJrXoQPz52Syb?=
 =?us-ascii?Q?D3qkPRoOdbqacqAPNdpM9yWCLefDeC3CZ0Z7rs3L0Td9u12ZYAdYFdJ3Bi/0?=
 =?us-ascii?Q?XLuaDGNeQwQMJ+OYtB5Q8d7D7AHmrfcutKIqjEe7t/YAbHmTYopqyL+VW7aE?=
 =?us-ascii?Q?yOpoEthN167g5PTQpD+po57fXrHCQRxrM7sDB7G1+CpWW44zkkaw0KyvmqMh?=
 =?us-ascii?Q?HQi12zhZmpqueGQlVW5ISF9eTy9Ow4HEAnUZV+PI+L23vx/T9YP/3kA7o5qG?=
 =?us-ascii?Q?d3lKYIQb0M+n2YYZJmD6biuXmuo8ak3nPo9wGfivtK4JdR7xieMJ8KCWEE/5?=
 =?us-ascii?Q?cSis99F0NDKbjtT8kxm2qaoZtF8vRS6xZolQmdtBgnq9aLrwEAk8mJMfMA0b?=
 =?us-ascii?Q?Vaf6WAyZSlFMXhmAvrKNMRzYRbO58XpLFe1Zmrm+4qH4PPW7tcZAxY/TKXXW?=
 =?us-ascii?Q?GPBZGkccau/Oelytf8Rxtq55sFe0MFMYoSCD6su0s4E1JiPqpLNja4M0vil9?=
 =?us-ascii?Q?gInPYyabOoFSsZqWbMCQhQJ/YoGEnLF4517XgI4ETOGzLLjpGcn9j8MSUWPw?=
 =?us-ascii?Q?51AzWCAvkBn2a5fyPH0eiRFvAzuinevTKg7dQa27DgMvnUVLxbUeaBoDf61S?=
 =?us-ascii?Q?RiIlhd06jMd1qp8bG4BCsgFGps2RKN1l6WLy3Eb2cxanWqxurPqxOU+V8SFk?=
 =?us-ascii?Q?YllLcLJRYzDLm2x4W3ggIu6Pey94JdwuBEoTmHJ4UkYsJQEHY42RIM0Bnb9Y?=
 =?us-ascii?Q?uKDt6EpWdmVsDFHwAXFVO/VofdBcBZhkJIz9mlNfnFMtFmQLfmNCxhXE8hYp?=
 =?us-ascii?Q?WtPwYxFlc7irt+BLKG74+jMsf9N0X2vxnkp7mrgg0u9KxZZQSg2BaNnadItU?=
 =?us-ascii?Q?XiIrI6nfFPVbXIKAXt4ea48s21MoXgxWOX8+F+GjeiXK/6EIvnBRLIlWqTRt?=
 =?us-ascii?Q?GclqCKvpdm5yn+e9uKO4abBQd3/MwyHIiyemqXvSdg7yTIlVgjk3X+vla8g+?=
 =?us-ascii?Q?KDNKlnlS3s4a4YrDxLqfTNSceEq0EJ+HwuMPQB7npOHLSAzbuu5KMUD90Tb4?=
 =?us-ascii?Q?OryO8mfN7tF0eFNbf0k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:48.4811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c69cce-3d05-4089-805e-08de2cefbb68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

Move to emit_clk_levels from print_clk_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 9626da2dba58..34b3f8680a2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -559,13 +559,14 @@ static int vangogh_get_dpm_clk_limited(struct smu_context *smu, enum smu_clk_typ
 	return 0;
 }
 
-static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
-			enum smu_clk_type clk_type, char *buf)
+static int vangogh_emit_legacy_clk_levels(struct smu_context *smu,
+					   enum smu_clk_type clk_type, char *buf,
+					   int *offset)
 {
+	int i, idx, size = *offset, ret = 0, start_offset = *offset;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_legacy_t metrics;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	int i, idx, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 
@@ -575,9 +576,6 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
@@ -659,15 +657,18 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
-static int vangogh_print_clk_levels(struct smu_context *smu,
-			enum smu_clk_type clk_type, char *buf)
+static int vangogh_emit_clk_levels(struct smu_context *smu,
+				    enum smu_clk_type clk_type, char *buf,
+				    int *offset)
 {
+	int i, idx, size = *offset, ret = 0, start_offset = *offset;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
-	int i, idx, size = 0, ret = 0, start_offset = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 	uint32_t min, max;
@@ -678,9 +679,6 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
@@ -781,18 +779,21 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
-static int vangogh_common_print_clk_levels(struct smu_context *smu,
-			enum smu_clk_type clk_type, char *buf)
+static int vangogh_common_emit_clk_levels(struct smu_context *smu,
+					   enum smu_clk_type clk_type, char *buf,
+					   int *offset)
 {
 	int ret = 0;
 
 	if (smu->smc_fw_if_version < 0x3)
-		ret = vangogh_print_legacy_clk_levels(smu, clk_type, buf);
+		ret = vangogh_emit_legacy_clk_levels(smu, clk_type, buf, offset);
 	else
-		ret = vangogh_print_clk_levels(smu, clk_type, buf);
+		ret = vangogh_emit_clk_levels(smu, clk_type, buf, offset);
 
 	return ret;
 }
@@ -2524,7 +2525,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.get_gpu_metrics = vangogh_common_get_gpu_metrics,
 	.od_edit_dpm_table = vangogh_od_edit_dpm_table,
-	.print_clk_levels = vangogh_common_print_clk_levels,
+	.emit_clk_levels = vangogh_common_emit_clk_levels,
 	.set_default_dpm_table = vangogh_set_default_dpm_tables,
 	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
 	.notify_rlc_state = vangogh_notify_rlc_state,
-- 
2.49.0

