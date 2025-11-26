Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9629D10F50
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4909F10E5AB;
	Wed, 26 Nov 2025 13:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Bdj7zx+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013054.outbound.protection.outlook.com
 [40.93.196.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC54510E2B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:28:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbMZLmTcXy3H/4isXmjqj8hHiLKxNfurK8h3/rHwsWZxwg+0yaWSjFyzk2IbxPyl7GWhC/PtwTC8HVpMobmRydMYwhpjSsKNrN+RoAG8W6SYjIYP3HlNN0I6QU/xWotObRxSN+2BBGVCovq/X+F7oihBfyiE1aIYCZyJsuR80OuGDZULCq5XxBO8kEMpnr0yhDKtYUbadBNmljm+HvfTj74xAltUQ84LbNfy1RVzjKxS+50P2NilFV65BS2gBYn+TG3qr3rpSLjOhaHXhCFdAwSAlUiPO0kHvvRAjQaDbnGRKSICVXvtTn0yulGc+won89Sno3dcR6/I57YoKYoYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTzPruBTb+CC/tPmI+ZsCDhvP2flXW1ho5tcIFslVIQ=;
 b=RXRo4tDHtFY6J3EI9lQBm1rEuayBDUiUEV/HNyCaRFqzDRovH2LU2IIcvgcHIbo3jM1bnit67z1EBYT2o+V2WVkQ9b2ZtyP1IaHA46z3YVFhLx6L2RV2535ObciYLpiaEn1UjlV7BSqcOKr0w6qIcQqwd7ZHLycDUCbSI4PRUBFrV5jGA/ePDR8KkhWNYzTh46pNprzmmKMZ6MAYjBhyRnzXZ3K9G7QKLoQmTe+OJkQ9mp5RM9vzC7ZNAxlIXMwVhGQ562JDTYkIcma4Wa+Ny02QFsYAVDXSCviQz+YeB1IdU5U/t+v3Fzta4cttKStm130vIrDuRq01FxnwZ9ULiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTzPruBTb+CC/tPmI+ZsCDhvP2flXW1ho5tcIFslVIQ=;
 b=3Bdj7zx+UjKL20+wHm2+84WF2KejgJUaxo74vBHF+NwFgW3KCMlMb/KXTzoNaQHJtdk9Hka83FDKngJb7WptKU32GOSGEMl1jYNZX2YGedUx7B6FhvKs2QZ9luEstr0aVM4IeWOw9qwcx3GPcIE5BoGOsgdFOZKdIKjvBupCeyQ=
Received: from SJ0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:a03:39e::12)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:28:53 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::2) by SJ0PR03CA0277.outlook.office365.com
 (2603:10b6:a03:39e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Wed,
 26 Nov 2025 13:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:50 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 06/20] drm/amd/pm: Use emit_clk_levels in SMUv13.0.0
Date: Wed, 26 Nov 2025 18:53:53 +0530
Message-ID: <20251126132822.3266730-7-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 135946a9-6304-41b8-ae34-08de2cefbdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/GxZhJ/3rRlc46JjzfkBRTLGDG/GO0CN934uEx689uuvq4nc+Q7VsQk/X343?=
 =?us-ascii?Q?msSX+hX55T5eqPynSzrsMIVPAyQp5dJEIab+TX0DtFyHY2PAsy3r14QSYwQr?=
 =?us-ascii?Q?aYhgAAeR3O9LK/bFlJAihTbOvlWdrhCd5IpY85cLhLfS4twbn4UiRMdUk4Vl?=
 =?us-ascii?Q?NYkMeYoJRJDRfzHf3jIM91Dj7kdcDep0CdLXFT+rt/aNvwEBbqdMfWONVpVK?=
 =?us-ascii?Q?gtH/LBKqzoks8qDYRsQVJj3vqUlykV3bcN3NntRJX6+pBT9j7OqwGmMlPJnc?=
 =?us-ascii?Q?/oW7tbCniHccNICfNsFejerDXSwuFtussLezYb5EDwfUkkFpxIuvXdrtHA+c?=
 =?us-ascii?Q?NeXMnGeibFvIy53+yG/7zeNBAuaTg9iMBQne5hl2ce+kfGuSYuvqb7joB54r?=
 =?us-ascii?Q?A8xmsUPmu6dFmEuJOYlXZWDpsKiHM8YTK9IxCbF6MPdLOFw3SRsJc1XjmnGW?=
 =?us-ascii?Q?6YCLjJGs6uGgE78NdlhxcsCi/UFUlshW+aAQnXZpHsn6WYmi/Tq/4z3s+7Co?=
 =?us-ascii?Q?mc7WNM4WSKaTN0Ru7RngGrA2Sfhrw9acrdR2RTTGfjqAHGd30n4FJog6qJZ3?=
 =?us-ascii?Q?DYgscC1LB9MvHjm29Oq3VvvbauI7lFPaD1bdIqmXZCSwqEKkjLA9kE3NZGbX?=
 =?us-ascii?Q?7WOXBMngQ5D+Sa53OWYm9Y9Zf/sz+bbWXPnTGH8UiqZcWtD/hhxoaiw1jXLH?=
 =?us-ascii?Q?KEsIMnjvDhyIVVFFneVgwazONo5IA3gaVBkUTDuRDP8IP80BrI3r2qflutd4?=
 =?us-ascii?Q?1+jluT+KFJ41wmUoNACjehIcqXhxrlGwPnx4xEXxrwjylUdlDR9/TbeZ8fi9?=
 =?us-ascii?Q?olp+8/VyFvN2Q4l88YPoVQ05j323Ly0J9215W+JO6Vs28p+HWWxTzgWkDO0G?=
 =?us-ascii?Q?DdaQVojEApWDgzXkR4O+UwOpI8E9IMZ46FMkVDDBkQf4w8Zet8doE9HPoSmc?=
 =?us-ascii?Q?UUImdnmBoHi5nLBmZFGpdTdgSoL2550XzKHSH0uISuI333+7ve5anxk/IJn4?=
 =?us-ascii?Q?Ze1LeTtRXn9DeZwdqDOcjNQE0j9UGIhNfhnnVmjzMr7nsJwFRSa6vivk2lHt?=
 =?us-ascii?Q?u7lg48ZDVXAEenGFMK6Od7HugSVb9Q54r9tnG7UPLnBQoLLJmqwuGN/kGh4J?=
 =?us-ascii?Q?LXTxMCxYJoPXLu+9qIj+gwmk7Vz7gGOjGTka2dZrXIQ8+shmx1+RsZTt5qEo?=
 =?us-ascii?Q?8tja/Kpv/j7prrNDp00vHyXjBwX67lezJd1sMO262yDsTDzu3fVpAtXUaGSy?=
 =?us-ascii?Q?Fp2gRr5I6UXMMPAnC7fSE51QMcrHm9mAGm2qPcTRxJ16B8rG5leYjKpMhQN9?=
 =?us-ascii?Q?gJmSFuF9BioFOB9gTZSqj/MeyY9Rx9PJffuFbo1iGXYcjyTwX/QwqtRDp03m?=
 =?us-ascii?Q?QMRvajYmIcVZPHcdXxa+tAKBmXb0qpKXxl902TIu8SHdBoem6CHuTyFdpr8K?=
 =?us-ascii?Q?PZbNYnc0+KY1c2fACiLVAz/u9itI+YKVm4hn9L4gsBfSfMgd+C2+Aan5Yqfb?=
 =?us-ascii?Q?//M+8G06cDaTxrDRIJE9mUHpqnx0/Aj2w2IDUGHIa/Cd8/rgg4xm1qcHdXQQ?=
 =?us-ascii?Q?+NHXnuRqFPfe3+UXZHY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:52.7683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135946a9-6304-41b8-ae34-08de2cefbdf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
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
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 677781060246..e6ae77223b7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1184,27 +1184,24 @@ static int smu_v13_0_0_upload_overdrive_table(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
-					enum smu_clk_type clk_type,
-					char *buf)
+static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
+				       enum smu_clk_type clk_type, char *buf,
+				       int *offset)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
+	int i, curr_freq, size = *offset, start_offset = *offset;
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_13_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
-	int i, curr_freq, size = 0, start_offset = 0;
 	int32_t min_value, max_value;
 	int ret = 0;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	if (amdgpu_ras_intr_triggered()) {
-		size += sysfs_emit_at(buf, size, "unavailable\n");
-		return size - start_offset;
+		sysfs_emit_at(buf, size, "unavailable\n");
+		return -EBUSY;
 	}
 
 	switch (clk_type) {
@@ -1535,7 +1532,9 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 
@@ -3227,7 +3226,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.read_sensor = smu_v13_0_0_read_sensor,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
-	.print_clk_levels = smu_v13_0_0_print_clk_levels,
+	.emit_clk_levels = smu_v13_0_0_emit_clk_levels,
 	.force_clk_levels = smu_v13_0_0_force_clk_levels,
 	.update_pcie_parameters = smu_v13_0_0_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v13_0_0_get_thermal_temperature_range,
-- 
2.49.0

