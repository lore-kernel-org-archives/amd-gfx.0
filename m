Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00278C5AD4E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 04:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5907B10E5FE;
	Mon, 10 Aug 2026 04:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mo4Cyn5z";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C358510E5FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 04:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6CrFH1RgApgJGiWi7pzMvCg/6VApLfpCjIGWOGR84XBoEo5gTj3pRa9EtPW7VV2z6Iqx326SWC/tes5m2J+tgt7rk2nGEDCpkwxX/lD8Zm7FwK5mxx7AL17RE957HTSE0vBjMViTriN/v79YFP98MkU0Yt2J3UCRbv8C/n0HLvvHOm+rPnq+JavcWvICP/S1x8JRj6xeybthEdgEv71TZQ9BxCUrQ7w1J6BS7sInNP3WChYP6tuE7yIVfGWLWGWU2CQ4ieU0AfLsjeQ2naJLQTOuWFssBAq1WtQdE6KXYKmt682g5RgIrmkyD0EupCUbk+A8cmKK1KcD/ayZ4pB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6UcYghrUoeVckJTLdr+1cU6HLQhaMx0Ly0gwhAASa4=;
 b=gJq8IcjdokuCnmpvLVb3q/h4D8j6xFEf0cvDJSTWFCy/y1++hOc0iaF+QVhWM//ii0DchCZfNidkJasSS6Ozyweae4CPjEe9cdwjgV4rfyxRoLfVH0YmQ9mekRx+cHRKwfcfSgfAr4Kb36pTeevwQietFU5oo7DJrtgJpmIHbCq+mnHOJkq74OyOnbHKBGCvT2B6LVROlUU2nLwZ8VXETd9quGLptipgaxzbXEqtXqlnw4tzvb5Wpab5c5D9Avk4szDPLpsNVB/fEmrE2BgS/3nVcV5i7NKXr59spRtSnuNTPZ8GKV2Xn6lmd5BchV159kSRLJpTrHWpuFRN1w5E2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6UcYghrUoeVckJTLdr+1cU6HLQhaMx0Ly0gwhAASa4=;
 b=Mo4Cyn5zaObY04Xl8pD0iuZLm8QB5A2g7iUOtriqN8SpRr9FA8cZXbbMMx4U6n/FPZbIHQwqz/SlW5jVACPnWIgGPykvY4IiOPfMe3c2DrjY/GnebY+lF+VPSfRC1NE643q/4M3IqylEH8f3ejN5Hj9Emo7j8RKSpgBjddmQJKQ=
Received: from BN9PR03CA0667.namprd03.prod.outlook.com (2603:10b6:408:10e::12)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 04:42:37 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::1f) by BN9PR03CA0667.outlook.office365.com
 (2603:10b6:408:10e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 04:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 04:42:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 23:42:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Lijo Lazar
 <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Remove unused functions in smu_v15_0
Date: Mon, 10 Aug 2026 10:12:20 +0530
Message-ID: <20260810044220.3821511-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c812791-d395-48c2-7c74-08def699cd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: q29yNC+GAhW+/ltkYjryYaD6+jhJudm8aotx99vHt9CFEl1Cl5+xzAluzNp2onm1QME15Bxduwnuh4JJVH5vwiiDxdR1N2JIa3ZHYnfAWb0mm1itXvYf2CYAGz+IZNcnSFqf14N0Yg2GVstgzJp40S3EpN4uGD5QpcBq4th0BhpV6PS4IvReJyDf2FbWUmkans2EFvK4egFQuiuv6Z8IPzi+LUv5Hz5DubvhsnppmebEY76+VDu9p21gbzHGaTVS3byVScXGzZbGepvSiOR9pLkQhQ8yUcmPfW8wLZf2Xqftii/jcoaUB2LYtM07xeEw05IhnIjAv/eEM471nkymrfv5OeRYB6lsDqfDukC3/PTVJwdcsLfPFkmRxM3Iof7DqaRLpuAmtkZEf+ufqC7szpxNBQMqrpUl1iB8D0XjwMpmIi7S/Bz1EXbz4MfV8xNre7J9K+dg/av2F0i55H26iTbEXjoDCrf86ulSPa2+dsMjXV+jfTDZs9rv5C3yNXHWZRtTsNQiBOz06BrsYDuzQoqIdcomIum8c1Fy2CcFwkMcD9/43fzDdUtwEQtJrpLjljS7dIe6u5pyRoYYxkBt3ChEFrbfZ8zp/oeIe6w2QpPwyxy6ynsEtODBMoGoyDkmKKTVcqvmHtUoQAsWHk07gJ/2f7tEbOhuh7IgEeH2X7H9zCa6onzkU9ufEyJpI5Qaz7Qi7DfHPtduq/FiADDzZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n2RTV0fb2ifugpVpiWAJ0AV3aZ+UxFTLTRPfftcYZc4i5iJadXPrZ5/Q3QkwxQH5Ze1WOOAB/whnvWoFlK3tD2fIgXQzu/yHW4wyu3RfmazoVGxhiyrpmqG5Gox5JvtyH8K60/RWPi6lILgQ125mmdQ77L13i50SPP4wmrw8ncgxafByGmt3bJZRFhbcrDnpQ8BuXtlGfWQRikmrAe0atoFSMScW04lBy25pq2V46wzRNyW0MS4x0m944Y9KQIz1DHx03JVhyjSz9Q+DlEUxjl6CtccOh8RCQaTRZTl7/iUdiE9j7to4E4nxvISBQpIVczrBX3QoIdm6SV1ldiakS9tKSSfFHS+/DQkOcDwtLvNQpS+oEV/ljOfzy/LeRbvIGc1AFvw2PFsSdg4cJLIbX+PcBgbKFZyhZGx0WghbXX16omwG5X3gKRTEk+7K7BkV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 04:42:36.3991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c812791-d395-48c2-7c74-08def699cd16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
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

smu_v15_0_load_microcode() and smu_v15_0_set_single_dpm_table() are not
called anywhere; the latter is a carry-over from a previous version. The
static helpers smu_v15_0_get_dpm_freq_by_index(),
smu_v15_0_get_dpm_level_count() and smu_v15_0_get_fine_grained_status()
were only called from smu_v15_0_set_single_dpm_table(), so remove those
as well. Remove all functions along with their declarations from the
header.

Fixes: c7fc0f372374 ("drm/amd: Enable SMU 15_0_0 support")
Fixes: f7bee962d92a ("drm/amd/pm: Update dpm table structs for smu_v15_0")
Reported-by: Dan Carpenter <error27@gmail.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |   6 -
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 166 ------------------
 2 files changed, 172 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index ec96dc775485..0c97bee2c4bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -113,8 +113,6 @@ int smu_v15_0_init_microcode(struct smu_context *smu);
 
 void smu_v15_0_fini_microcode(struct smu_context *smu);
 
-int smu_v15_0_load_microcode(struct smu_context *smu);
-
 int smu_v15_0_init_smc_tables(struct smu_context *smu);
 
 int smu_v15_0_fini_smc_tables(struct smu_context *smu);
@@ -183,10 +181,6 @@ int smu_v15_0_set_performance_level(struct smu_context *smu,
 int smu_v15_0_set_power_source(struct smu_context *smu,
 			       enum smu_power_src_type power_src);
 
-int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
-				   enum smu_clk_type clk_type,
-				   struct smu_dpm_table *single_dpm_table);
-
 int smu_v15_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 29f444aea73a..2269703869f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -106,44 +106,6 @@ void smu_v15_0_fini_microcode(struct smu_context *smu)
 	adev->pm.fw_version = 0;
 }
 
-int smu_v15_0_load_microcode(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	const uint32_t *src;
-	const struct smc_firmware_header_v1_0 *hdr;
-	uint32_t addr_start = MP1_SRAM;
-	uint32_t i;
-	uint32_t smc_fw_size;
-	uint32_t mp1_fw_flags = 0;
-
-	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-	src = (const uint32_t *)(adev->pm.fw->data +
-				 le32_to_cpu(hdr->header.ucode_array_offset_bytes));
-	smc_fw_size = hdr->header.ucode_size_bytes;
-
-	for (i = 1; i < smc_fw_size/4 - 1; i++) {
-		WREG32_PCIE(addr_start, src[i]);
-		addr_start += 4;
-	}
-
-
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (smu->is_apu)
-			mp1_fw_flags = RREG32_PCIE(MP1_Public |
-						   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
-
-		if ((mp1_fw_flags & MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
-		    MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
-			break;
-		udelay(1);
-	}
-
-	if (i == adev->usec_timeout)
-		return -ETIME;
-
-	return 0;
-}
-
 int smu_v15_0_init_pptable_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1161,134 +1123,6 @@ int smu_v15_0_set_power_source(struct smu_context *smu,
 					       NULL);
 }
 
-static int smu_v15_0_get_dpm_freq_by_index(struct smu_context *smu,
-					   enum smu_clk_type clk_type,
-					   uint16_t level,
-					   uint32_t *value)
-{
-	int ret = 0, clk_id = 0;
-	uint32_t param;
-
-	if (!value)
-		return -EINVAL;
-
-	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
-		return 0;
-
-	clk_id = smu_cmn_to_asic_specific_index(smu,
-						CMN2ASIC_MAPPING_CLK,
-						clk_type);
-	if (clk_id < 0)
-		return clk_id;
-
-	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
-
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetDpmFreqByIndex,
-					      param,
-					      value);
-	if (ret)
-		return ret;
-
-	*value = *value & 0x7fffffff;
-
-	return ret;
-}
-
-static int smu_v15_0_get_dpm_level_count(struct smu_context *smu,
-					 enum smu_clk_type clk_type,
-					 uint32_t *value)
-{
-	int ret;
-
-	ret = smu_v15_0_get_dpm_freq_by_index(smu, clk_type, 0xff, value);
-
-	return ret;
-}
-
-static int smu_v15_0_get_fine_grained_status(struct smu_context *smu,
-					     enum smu_clk_type clk_type,
-					     bool *is_fine_grained_dpm)
-{
-	int ret = 0, clk_id = 0;
-	uint32_t param;
-	uint32_t value;
-
-	if (!is_fine_grained_dpm)
-		return -EINVAL;
-
-	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type))
-		return 0;
-
-	clk_id = smu_cmn_to_asic_specific_index(smu,
-						CMN2ASIC_MAPPING_CLK,
-						clk_type);
-	if (clk_id < 0)
-		return clk_id;
-
-	param = (uint32_t)(((clk_id & 0xffff) << 16) | 0xff);
-
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetDpmFreqByIndex,
-					      param,
-					      &value);
-	if (ret)
-		return ret;
-
-	/*
-	 * BIT31:  1 - Fine grained DPM, 0 - Dicrete DPM
-	 * now, we un-support it
-	 */
-	*is_fine_grained_dpm = value & 0x80000000;
-
-	return 0;
-}
-
-int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
-				   enum smu_clk_type clk_type,
-				   struct smu_dpm_table *single_dpm_table)
-{
-	int ret = 0;
-	uint32_t clk = 0;
-	bool is_fine_grained = false;
-	int i;
-
-	ret = smu_v15_0_get_dpm_level_count(smu,
-					    clk_type,
-					    &single_dpm_table->count);
-	if (ret) {
-		dev_err(smu->adev->dev, "[%s] failed to get dpm levels!\n", __func__);
-		return ret;
-	}
-
-	ret = smu_v15_0_get_fine_grained_status(smu,
-						clk_type,
-						&is_fine_grained);
-	if (ret) {
-		dev_err(smu->adev->dev, "[%s] failed to get fine grained status!\n", __func__);
-		return ret;
-	}
-
-	if (is_fine_grained)
-		single_dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
-
-	for (i = 0; i < single_dpm_table->count; i++) {
-		ret = smu_v15_0_get_dpm_freq_by_index(smu,
-						      clk_type,
-						      i,
-						      &clk);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] failed to get dpm freq by index!\n", __func__);
-			return ret;
-		}
-
-		single_dpm_table->dpm_levels[i].value = clk;
-		single_dpm_table->dpm_levels[i].enabled = true;
-	}
-
-	return 0;
-}
-
 int smu_v15_0_set_vcn_enable(struct smu_context *smu,
 			      bool enable,
 			      int inst)
-- 
2.34.1

