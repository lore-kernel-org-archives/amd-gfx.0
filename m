Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68463C5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 06:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0DE10E3DE;
	Fri,  7 Aug 2026 06:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dS8ODn58";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA1110E33A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 06:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5Imx8tVgRYgMn0l0QZ9i3wkpAfEJW6B2kVzLUPc5MpqpSroSb+3WIL8W0akPUAoed6pScWnA1EBzHHpcD2Mam5cxXxE5phGS/FZZ6C4KW0fqunmjv1ZBBWQm4l2GqduYHeWDm97ZS8dOMOZ4x+QCvdAaSkzf+YCia/mmlCnWN4H+CXmmbPZj20HsSsdhV0p/PVBeWCoINev27XHBRTfsf3C6Y6fzWvtVPk4ZZH19YTpdhtpMBfJlky3KeLDAXMvDKDldpJF9xMdVkxUNdrpCOcVmLDrL8aFyNLNyDd29gAE1ZVZ6fpZ6yWZ6cZ25GiqSlC7g823UNXODBRzxfRU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMbGG+VnvUi2I3p+TwwV7znbmBB+fMHWlEXwe6h6NdM=;
 b=GhdrObCzMtBA9ge5LVMvFTicaaAGFp1qTL4CPBXJ+kt6hzf/ismRfOxWcTqcFQUFFRX8Euej8PkBDCr2FdQCCiFjxx+oe+NWSIXo3yX1aBQ28s2BY6DsuWutjcn7qiq8jk750FQcvtGawgMo2uguDzjSnDTwiwxB4EKEbhsEfdkL3umz71Vai4GduiCQn24r56g/XwJy2qrQEc8wH/mDhoMNlOVpmK+S34+4eF74NtU7rThrORmQXuLzEB6vGkyjtJrondipiDTWJmCmg2ae7mEgdUofj+Adtlotshk8w25vLzAi0WzAYyNB5uX32jpGeskKkHnRrop0HFjr5J7CFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMbGG+VnvUi2I3p+TwwV7znbmBB+fMHWlEXwe6h6NdM=;
 b=dS8ODn58MH5UMM7WkTE8GLhAGzAFg1/eGPYVWGpCL04UmOQ+lu0WBM+cgSNIECXcIPLJOtUUMs3t94KodSviX7htu2NpHE3bm5T6uBPgNeXwkL1tiN4h7nfU7EQ8knClqXkakg19RobvBm3BNkVI9CATpZ7MdfY8cr+wgMQRWQQ=
Received: from SA0PR11CA0191.namprd11.prod.outlook.com (2603:10b6:806:1bc::16)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 06:43:41 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::6) by SA0PR11CA0191.outlook.office365.com
 (2603:10b6:806:1bc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Fri, 7
 Aug 2026 06:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:43:41 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:43:39 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: set pa base and lfb size for uniras
Date: Fri, 7 Aug 2026 14:43:30 +0800
Message-ID: <20260807064330.3070081-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807064330.3070081-1-tao.zhou1@amd.com>
References: <20260807064330.3070081-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fce2a5-2b82-45ad-dd3f-08def44f37ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 28rCDwybOV4WIdfK3O+0/Q3ndfXkd0e6EGdTLWjDi8FeKaWiCdCkHjokEfgUdkUkMmXMDUsJmbzfvrlU6NTTitDoJWpJLIzoWl/BxBUYcXrb+fmb1/Y/nBpacORUD1jxeTDX4EWEONo03dlaKhBlnrsrDU0X60JD4rSyPh6mlq+hVRjkzFSLE343n2eOiTKj+AcmudkKBju+zRnoCmkfDvKgf+0yK+nFcnbY04B32NNJo2SniSSxLw6hxJ6dceAPV0l1bxw38wtzKp8t+a6HxPzvSg48iX2LGmLTQ0hGdS3Q4qP8st2C8ZbT6uruzhBz3Nrhu/jXvLcUuqCj/3V2wKZr9DYBR5MvdbZT7zdpcPDd8CVdI7iQ6V/m+JVoh25z6yGFVGsjnIDTy3Z7xQ9d/0QE6pmxsO2eHKi5edX7jczuSYAyb4ZltzwA9hb+NlxNL2Yi5AQ9CWbbIV4+x0M/Fpt5doS19RcOy7+w7FD27hI8bfTBBrAJuWZcc/h9DiauULsgJmGVBgQ8VON2jpSLSf9qKG6sQWZIBdeEp/3YrwEuqd2jsyC9wbNIm3jsyE3PqCj+3cjiVc5v+RIfC4NPXU6l9EPaEq+KDyRmtqoRvQqTie3dyKNcQ0tGJ9nF20NqzAALIXiYDiRxNFUuA05C/69UWjPfELegE0IV6SJCopsxmSaUZXhIhX0FVZN/pj0yyTmcM/bJttXaQoO6beOLQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CyZL7guIMdCAMbd/yMf97dStvk+kQbCNFal/u0qudTLBTch8cw64YZ17oxe8Y+OCyXmtpuzII/7WITjix/bRNMGKRyS/dHzp3bY6Sf/nzYffj940Mwle8i7Zq7i2BbXtiKvNWYOy369o2h9FYAJfMpiQCXQmJFkRIf+4HsvKfDGsayptNkSvl3pMFCLpPcF9PMiSvB9L48xz9B0+DmPzQcIbtOspymsDzZgmovCga+h8+6e9+p+f4AqRtqJTX+sANwayEPV9jWtwHtW78SeNRZn0s6rpPqCZjlrp7F8733dThxLRZPFJig2r1rTGZUDxPbLk1cWlGdDE4P+RUqOu7c4snm35A7TWeorMqxwZQCswotOGoYfkvtFAy9XmfZqmA9XrSKNY/srDedPUAAB+rHTgLSnScuBWa6lPzquQ4qaAgnoiPJ/A5EWcTJIaVDUG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:43:41.0581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fce2a5-2b82-45ad-dd3f-08def44f37ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736
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

Avoid hardcode, get the parameters from amdgpu.
For the algorithms of ras address conversion and die id calculation,
not only pa, (pa + pa_base) is also needed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |  4 ++++
 drivers/gpu/drm/amd/ras/core/ras_umc.c        |  7 +++++--
 drivers/gpu/drm/amd/ras/core/ras_umc.h        |  7 ++++++-
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c  | 20 ++++++++++++-------
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h  |  3 ---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  2 ++
 6 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index d61c977b07cf..e0ed6a3ce168 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -278,6 +278,10 @@ struct ras_psp_config {
 struct ras_umc_config {
 	uint32_t umc_vram_type;
 	uint32_t num_umc;
+	/* socket xgmi offset, base address of umc physical address */
+	uint64_t pa_base;
+	/* local frame buffer size */
+	uint64_t lfb_size;
 };
 
 struct ras_eeprom_config {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 95a98b411fc7..2dc1c0b6ac49 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -411,8 +411,9 @@ static int ras_umc_eeprom_rec2nps_addr_legacy(struct ras_core_context *ras_core,
 	 * only ever existed on NPS1 systems)
 	 */
 	if (ras_core->ras_umc.ip_func && ras_core->ras_umc.ip_func->get_die_id) {
-		die_id = ras_core->ras_umc.ip_func->get_die_id(record->address,
-			RAS_PFN_TO_ADDR(EEPROM_RECORD_UMC_ADDR_PFN(record)));
+		die_id = ras_core->ras_umc.ip_func->get_die_id(ras_core,
+				record->address,
+				RAS_PFN_TO_ADDR(EEPROM_RECORD_UMC_ADDR_PFN(record)));
 	} else {
 		RAS_DEV_ERR(ras_core->dev, "get_die_id is not supported!\n");
 		return -EOPNOTSUPP;
@@ -855,6 +856,8 @@ int ras_umc_hw_init(struct ras_core_context *ras_core)
 			ras_umc->umc_vram_type);
 		return -ENODATA;
 	}
+	ras_umc->pa_base = ras_core->config->umc_cfg.pa_base;
+	ras_umc->lfb_size = ras_core->config->umc_cfg.lfb_size;
 
 	ras_umc->umc_ip_version = ras_core->config->umc_ip_version;
 	ras_umc->ip_func = ras_umc_get_ip_func(ras_core, ras_umc->umc_ip_version);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index af76de70ddd1..13d715c8553f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -139,7 +139,8 @@ struct ras_umc_ip_func {
 		uint32_t nps);
 	uint64_t (*nps_pa_to_row_pa)(struct ras_core_context *ras_core,
 		uint64_t pa, enum umc_memory_partition_mode nps, bool zero_pfn_ok);
-	uint32_t (*get_die_id)(uint64_t mca_addr, uint64_t pa);
+	uint32_t (*get_die_id)(struct ras_core_context *ras_core,
+		uint64_t mca_addr, uint64_t pa);
 };
 
 struct eeprom_store_record {
@@ -168,6 +169,10 @@ struct ras_umc {
 	u32 umc_ip_version;
 	u32 umc_vram_type;
 	u32 num_umc;
+	/* socket xgmi offset, base address of umc physical address */
+	u64 pa_base;
+	/* local frame buffer size */
+	u64 lfb_size;
 	const struct ras_umc_ip_func *ip_func;
 	struct radix_tree_root root;
 	struct mutex  tree_lock;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
index ccdbc5c4bab1..4bf993325a3f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
@@ -243,6 +243,8 @@ static int umc_v12_0_ma2pa(struct ras_core_context *ras_core,
 	uint32_t socket_id = addr_in->socket_id;
 	uint32_t channel_index;
 	uint64_t err_addr = addr_in->err_addr;
+	uint64_t pa_base = ras_core->ras_umc.pa_base;
+	uint64_t lfb_size = ras_core->ras_umc.lfb_size;
 
 	if (node_inst != UMC_INV_AID_NODE) {
 		if (ch_inst >= UMC_V12_0_CHANNEL_INSTANCE_NUM ||
@@ -318,11 +320,11 @@ static int umc_v12_0_ma2pa(struct ras_core_context *ras_core,
 		OFFSET_IN_256B_BLOCK(na);
 
 	/* calc channel hash based on absolute address */
-	soc_pa += socket_id * SOCKET_LFB_SIZE;
+	soc_pa += pa_base;
 	/* the umc channel bits are not original values, they are hashed */
 	UMC_V12_0_SET_CHANNEL_HASH(channel_index, soc_pa);
 	/* restore pa */
-	soc_pa -= socket_id * SOCKET_LFB_SIZE;
+	soc_pa -= pa_base;
 
 	/* get some channel bits from na_nps directly and
 	 * add nps section offset
@@ -330,16 +332,16 @@ static int umc_v12_0_ma2pa(struct ras_core_context *ras_core,
 	if (nps == UMC_MEMORY_PARTITION_MODE_NPS2) {
 		soc_pa &= ~(0x1ULL << UMC_V12_0_PA_CH5_BIT);
 		soc_pa |= ((na_nps & 0x100) << 5);
-		soc_pa += (node_inst >> 1) * (SOCKET_LFB_SIZE >> 1);
+		soc_pa += (node_inst >> 1) * (lfb_size >> 1);
 	} else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4) {
 		soc_pa &= ~(0x3ULL << UMC_V12_0_PA_CH4_BIT);
 		soc_pa |= ((na_nps & 0x300) << 4);
-		soc_pa += node_inst * (SOCKET_LFB_SIZE >> 2);
+		soc_pa += node_inst * (lfb_size >> 2);
 	} else if (nps == UMC_MEMORY_PARTITION_MODE_NPS8) {
 		soc_pa &= ~(0x7ULL << UMC_V12_0_PA_CH4_BIT);
 		soc_pa |= ((na_nps & 0x700) << 4);
-		soc_pa += node_inst * (SOCKET_LFB_SIZE >> 2) +
-			(channel_index >> 4) * (SOCKET_LFB_SIZE >> 3);
+		soc_pa += node_inst * (lfb_size >> 2) +
+			(channel_index >> 4) * (lfb_size >> 3);
 	}
 
 	addr_out->pa = soc_pa;
@@ -496,10 +498,14 @@ static void umc_v12_0_mca_ipid_parse(struct ras_core_context *ras_core, uint64_t
  * umc number: 16
  * hbm type: UMC_VRAM_TYPE_HBM
  */
-static uint32_t umc_v12_0_get_die_id(uint64_t mca_addr, uint64_t pa)
+static uint32_t umc_v12_0_get_die_id(struct ras_core_context *ras_core,
+		uint64_t mca_addr, uint64_t pa)
 {
 	uint32_t die = 0;
 
+	/* use absolute PA */
+	pa += ras_core->ras_umc.pa_base;
+
 	/* we only calculate die id for nps1 mode(save_nps == ch_idx_v2 == 0) */
 	die += (((pa >> 12) & 0x1ULL) ^
 			((pa >> 20) & 0x1ULL) ^
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
index 268db10dc6b0..f6f7f827e06f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h
@@ -300,9 +300,6 @@
 #define UMC_V12_0_TOTAL_CHANNEL_NUM \
 	(UMC_V12_0_AID_NUM_MAX * UMC_V12_0_UMC_INSTANCE_NUM * UMC_V12_0_CHANNEL_INSTANCE_NUM)
 
-/* one device has 192GB HBM */
-#define SOCKET_LFB_SIZE   0x3000000000ULL
-
 extern const struct ras_umc_ip_func ras_umc_func_v12_0;
 
 int ras_umc_get_badpage_count(struct ras_core_context *ras_core);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index c55288c2df9a..c58fa0ef8a80 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -285,6 +285,8 @@ static int amdgpu_ras_mgr_init_umc_config(struct amdgpu_device *adev,
 
 	umc_cfg->umc_vram_type = adev->gmc.vram_type;
 	umc_cfg->num_umc = adev->gmc.num_umc;
+	umc_cfg->lfb_size = adev->gmc.xgmi.node_segment_size;
+	umc_cfg->pa_base = amdgpu_xgmi_get_relative_phy_addr(adev, 0x0ULL);
 
 	return 0;
 }
-- 
2.34.1

