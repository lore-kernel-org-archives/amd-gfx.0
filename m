Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DABAC5DF6A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A305110F739;
	Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fDwF5znn";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6515910F725
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw0fPRNwcTpzEZaYdAxP+d8SgbxJ7M6qIkEzMBDWPzKWse4t5N8GEtPAQD5MXqHdJmV6p/Pyc9G/1UTrieKf26vcaonpe8sOvGXQ1TxJvJcjD2zNcT9PR+PFGW2Q84m7SEUmf+ove2AxTi3dAXbw0uTjAPu5W2DolPO7Sar/aGdpPy5R6xkZBjrbvD2x3EISsVkxKIiFeo4C+G9GThU9Z59IDulP+PAfuXfD+TvT3NtrhigIHhsRtoHB9k7ZU4VxhlCYsjd4mKqyM2M7P81uHFXgCVwLv5n98deo9wBsZMqwGUI5tuvsek1m5Lq1zRHdrVSusQKdv9+MLxl8bXn3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khLoP6zT7GUT0ll5LlU1tmLkpn79lsy87PWjcK7d8Is=;
 b=fb7y9KhWDoLaVM/cQvxdx8ZoF19Bu4YZgVvx6HgjyqDbA1147ApBcblrFRgIqEAnWY/lZJ3jzRq6gA+gZ3UKV4hZkUk+5xcyVPM3h7njn6kmGXsxBqwdTDYv9fk4BLd58ogn37RtJ/i/LPLCqtaATG861CI7nge7GUtdNNp5YDU2BauXG8dETn0n16qzkt6XSH1l8sEYyJeEu1hDC7Ds99XDCwhPChJ90zZ8C+IPCvm2QiaT4WJUvDz52JILJwI5oABfBwY01gmg3JbolTmzJqflbdRlvlW5rOQkzOTGMtryoXLV37mStpYQwcS7DyebwDDtZ05VrtKGXZ8lOskTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khLoP6zT7GUT0ll5LlU1tmLkpn79lsy87PWjcK7d8Is=;
 b=fDwF5znn7NE11W0DoWcqvB6hsIWrc0hPcmvLczf1+WdS9kj4Ntc+4kUEIDSQRD11W1P3kLAaq3kZjkYjohxH3F0UCs6Hwa3QA6QswAtMS8dSZrq6ImwvoKB+jDXo07+cnCISlvQdBXEbFvVfRkMXbJ57pR2mXqU2Lu3+pWm5cr8=
Received: from DSZP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::9) by
 DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.16; Fri, 14 Aug 2026 21:03:49 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:280:cafe::77) by DSZP220CA0008.outlook.office365.com
 (2603:10b6:5:280::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 077/109] drm/amd/ras: add management interface to support psp
 bad page address translation
Date: Fri, 14 Aug 2026 17:02:14 -0400
Message-ID: <20260814210246.3067612-78-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: c32cc2d4-7314-453f-732c-08defa47897b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VzLkTx6U74xPIlnrvjft3EEOzFvL4s/WhdJl7i79ZLpaVPvp4/x2fhQCiwUQPi48uQg5CWqD20KSkZ/nwDQqdkD8oVHUGMa2sFh1anKoKOJv264xUJCejmQuQBe5+5KdDVYIBFmAYdWjYp1L3ghw1sxcPWz5xzFdFmX4B7Ev4MuCaPgDl2RIIE8snrv4tAb2IoXtpTe0FsN38P5gZgVPC9S/k3duuNVBnna7CXlrK9zS9/37+hJYrFXb7Lrwy86KBrbXIyWbl3dIP0f4qvZErrK72R4kDNQN+7bj1OzI/rDoH6JBo+PS+UorbMUwXtKc4ZM8QHFcHnpuialzw1hxwyQmb23G/B1XGAbLr02kAzgM0+2ec5OV7Aa01F657kB7p4ueLbruha/R+afJC9aPmeJcuv393dZdGGSfXoqcYaFcGnI6LGyCRRbdWnCWjaKv+QYrhySNWB/3samNKH/gdv0doseZtrWGMHAPH0sMtR2kp7E31vEcMe5CAYQ4PlYlAqsUIdOTcrX8NNlNk+ykREyXxjxnSQ94j1haTZEs7EtJslRp2Uy5Cc69k+w/jG/6UJVlhkqV+Va6g+ajoRA7bT+8A+dpkc990Jv2P++XzTSifSd1bZqclS59o7vgxkoG3e7ZCQ8z4dK8L1Osp/OvVSFEEO2KocFo/cqDNlKBTro=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lZx7ARDkeadWWCODEFWq2F9ip6oLCEDnwZOEzRgYvmYgjSNlDT1qKWiVyRZYJZkqs6YKTBtc8nMipeMhPMgW7G/9ItZwCLsO6c0k0uphPvUmm01aRgaXzn6OPEJIQoPcTDmZ5MUlS3Y0GXY0T5lwkZkd448IKANbr1EycRbBLC+nhrlJuPVOKyicejRUdM7/bvhSp1uz8KHzefkkudZ8VmuBk75T6Q4wGm6MwxoGsHeofSAI2CuvIEc9trDHfrqGYIrtNgJfkx2tkekfGlN27JySiUY+tIe7MDb7UeMx5OX54eZEqBDBmcqmZa0Qg7TWiCcwWsIUaVaw9grsprfIjehO7N6TuECwyqNoaRHJau/RQ/smkLern0d7RbToLK+Si1uVg8s4FhUopX5csJfEKNtdQkWkz3aBD94ZHbzSC3OuIxZDQE7ZtXr9USVq6DiN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:48.8838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32cc2d4-7314-453f-732c-08defa47897b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add management interface to support psp bad page address translation.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom.h        |  4 +++
 drivers/gpu/drm/amd/ras/core/ras.h           |  2 ++
 drivers/gpu/drm/amd/ras/core/ras_psp.c       | 14 ++++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp.h       | 19 ++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_umc.c       | 27 ++++++++++++++++++--
 drivers/gpu/drm/amd/ras/core/ras_umc.h       |  8 +++++-
 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c | 21 +++++++++++----
 7 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.h b/drivers/gpu/drm/amd/ras/core/eeprom.h
index f4dac13d70056..ae22bb3f83187 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.h
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.h
@@ -163,6 +163,10 @@ struct eeprom_umc_record {
 	/* The following variables will not be saved to eeprom.
 	 */
 	uint64_t cur_nps_retired_row_pfn;
+	/* Combined PA flip bit mask across all bad pages in a row;
+	 * used with cur_nps_retired_row_pfn to derive all bad page addresses
+	 */
+	uint64_t cur_nps_pa_flip_mask;
 	uint32_t cur_nps_bank;
 	uint32_t cur_nps;
 	uint64_t ipid;
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 168766d449ce7..a2f0491e4062b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -273,6 +273,8 @@ struct ras_psp_sys_func {
 		struct ras_psp_sys_status *status);
 	int (*get_ras_param)(struct ras_core_context *ras_core,
 		struct ras_param *param);
+	int (*psp_translate_addr)(struct ras_core_context *ras_core,
+		struct ras_psp_addr_trans_in *in, struct ras_psp_addr_trans_out *out);
 };
 
 struct ras_sys_func {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index 06668332256c2..102dffe9d4989 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -985,3 +985,17 @@ uint64_t ras_psp_get_hw_ras_caps(struct ras_core_context *ras_core)
 
 	return psp->ras_hw_caps.features.block_mask;
 }
+
+int ras_psp_translate_addr(struct ras_core_context *ras_core,
+	struct ras_psp_addr_trans_in *in, struct ras_psp_addr_trans_out *out)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+
+	if (!in || !out)
+		return -EINVAL;
+
+	if (!psp->sys_func || !psp->sys_func->psp_translate_addr)
+		return -EOPNOTSUPP;
+
+	return psp->sys_func->psp_translate_addr(ras_core, in, out);
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
index 5e668730cf176..041d46eee3f43 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.h
@@ -34,6 +34,23 @@ struct ras_ta_query_address_input;
 struct ras_ta_query_address_output;
 enum ras_ta_cmd_id;
 
+struct ras_psp_addr_trans_in {
+	uint64_t mca_addr;
+	uint64_t ipid;
+	uint32_t nps;
+};
+
+struct ras_psp_addr_trans_out {
+	uint32_t channel_id;
+	uint8_t  socket_id;
+	uint8_t  mem_die_id;
+	uint8_t  dram_entity_id;
+	uint8_t  umc_inst_id;
+	uint64_t row_pa;
+	/* Bitmask of flipping bits across all bad page PAs in a row */
+	uint64_t pa_flip_mask;
+};
+
 struct ras_ta_image_header {
 	uint32_t reserved1[24];
 	uint32_t image_version; /* [0x60] Off Chip Firmware Version */
@@ -191,4 +208,6 @@ int ras_psp_get_block_ta_id(struct ras_core_context *ras_core,
 bool ras_psp_poison_supported(struct ras_core_context *ras_core);
 bool ras_psp_flex_mca_enabled(struct ras_core_context *ras_core);
 uint64_t ras_psp_get_hw_ras_caps(struct ras_core_context *ras_core);
+int ras_psp_translate_addr(struct ras_core_context *ras_core,
+	struct ras_psp_addr_trans_in *in, struct ras_psp_addr_trans_out *out);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index d78b111b87852..cef5770a75a60 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -85,7 +85,7 @@ static const struct ras_umc_ip_func *ras_umc_get_ip_func(
 	return NULL;
 }
 
-int ras_umc_psp_ma2pa(struct ras_core_context *ras_core,
+int ras_umc_ras_ta_translate_addr(struct ras_core_context *ras_core,
 		struct umc_mca_addr *in, struct umc_phy_addr *out,
 		uint32_t nps)
 {
@@ -124,6 +124,28 @@ int ras_umc_psp_ma2pa(struct ras_core_context *ras_core,
 	return 0;
 }
 
+int ras_umc_psp_translate_addr(struct ras_core_context *ras_core,
+		struct umc_mca_addr *in, struct umc_phy_addr *out,
+		uint32_t nps)
+{
+	struct ras_psp_addr_trans_in psp_in = {0};
+	struct ras_psp_addr_trans_out psp_out = {0};
+	int ret;
+
+	psp_in.mca_addr = in->mca_addr;
+	psp_in.ipid = in->ipid;
+	psp_in.nps = nps;
+
+	ret = ras_psp_translate_addr(ras_core, &psp_in, &psp_out);
+	if (ret)
+		return ret;
+
+	out->pa = psp_out.row_pa;
+	out->pa_flip_mask = psp_out.pa_flip_mask;
+
+	return 0;
+}
+
 static int ras_umc_log_ecc(struct ras_core_context *ras_core,
 		unsigned long idx, void *data)
 {
@@ -302,7 +324,7 @@ int ras_umc_ma2pa(struct ras_core_context *ras_core,
 	int ret;
 
 	if (ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS)) {
-		ret = ras_umc_psp_ma2pa(ras_core, addr_in, addr_out, nps);
+		ret = ras_umc_ras_ta_translate_addr(ras_core, addr_in, addr_out, nps);
 	} else {
 		if (ras_umc->ip_func && ras_umc->ip_func->ma2pa) {
 			ret = ras_umc->ip_func->ma2pa(ras_core, addr_in, addr_out, nps);
@@ -874,6 +896,7 @@ int ras_umc_fill_eeprom_record(struct ras_core_context *ras_core,
 	err_rec->mem_channel = cur_nps_addr->channel_idx;
 	err_rec->mcumc_id = umc_inst;
 	err_rec->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(cur_nps_addr->pa);
+	err_rec->cur_nps_pa_flip_mask = cur_nps_addr->pa_flip_mask;
 	err_rec->cur_nps_bank = cur_nps_addr->bank;
 	err_rec->cur_nps = cur_nps;
 	return 0;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index 725f74740ead9..a64b5106d0051 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -104,10 +104,13 @@ struct umc_mca_addr {
 	uint32_t umc_inst;
 	uint32_t node_inst;
 	uint32_t socket_id;
+	uint64_t mca_addr;
+	uint64_t ipid;
 };
 
 struct umc_phy_addr {
 	uint64_t pa;
+	uint64_t pa_flip_mask;
 	uint32_t bank;
 	uint32_t channel_idx;
 };
@@ -197,7 +200,10 @@ int ras_umc_sw_init(struct ras_core_context *ras);
 int ras_umc_sw_fini(struct ras_core_context *ras);
 int ras_umc_hw_init(struct ras_core_context *ras);
 int ras_umc_hw_fini(struct ras_core_context *ras);
-int ras_umc_psp_ma2pa(struct ras_core_context *ras_core,
+int ras_umc_ras_ta_translate_addr(struct ras_core_context *ras_core,
+		struct umc_mca_addr *in, struct umc_phy_addr *out,
+		uint32_t nps);
+int ras_umc_psp_translate_addr(struct ras_core_context *ras_core,
 		struct umc_mca_addr *in, struct umc_phy_addr *out,
 		uint32_t nps);
 int ras_umc_handle_bad_pages(struct ras_core_context *ras_core, void *data);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
index 0f3182b14dae9..39e95a5515f83 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
@@ -34,15 +34,18 @@ static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
 }
 
 static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_core,
-		uint64_t pa, enum umc_memory_partition_mode nps, bool zero_pfn_ok)
+	struct umc_phy_addr *pa, enum umc_memory_partition_mode nps, bool zero_pfn_ok)
 {
 	struct umc_flip_bits flip_bits = {0};
 	uint64_t row_pa;
 	int i;
 
+	if (pa->pa_flip_mask)
+		return zero_pfn_ok ? (pa->pa & ~pa->pa_flip_mask) : pa->pa;
+
 	__get_nps_pa_flip_bits(ras_core, nps, &flip_bits);
 
-	row_pa = pa;
+	row_pa = pa->pa;
 	/* clear loop bits in soc physical address */
 	for (i = 0; i < flip_bits.bit_num; i++)
 		row_pa &= ~BIT_ULL(flip_bits.flip_bits_in_pa[i]);
@@ -75,8 +78,13 @@ static int convert_ma_to_pa(struct ras_core_context *ras_core,
 {
 	int ret;
 
+	ret = ras_umc_psp_translate_addr(ras_core,
+				addr_in, addr_out, nps);
+	if (ret != -EOPNOTSUPP)
+		return ret;
+
 	if (ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS))
-		ret = ras_umc_psp_ma2pa(ras_core,
+		ret = ras_umc_ras_ta_translate_addr(ras_core,
 				addr_in, addr_out, nps);
 	else
 		ret = umc_v15_convert_ma_to_pa(ras_core,
@@ -100,11 +108,14 @@ static int convert_bank_to_nps_addr(struct ras_core_context *ras_core,
 	addr_in.umc_inst = ACA_IPID_2_UMC_INST(bank->ipid);
 	addr_in.node_inst = ACA_IPID_2_DIE_ID(bank->ipid);
 	addr_in.socket_id = ACA_IPID_2_SOCKET_ID(bank->ipid);
+	addr_in.mca_addr = bank->addr;
+	addr_in.ipid = bank->ipid;
 
 	ret = convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
 	if (!ret) {
 		pa_addr->pa =
-			convert_nps_pa_to_row_pa(ras_core, addr_out.pa, nps, false);
+			convert_nps_pa_to_row_pa(ras_core, &addr_out, nps, false);
+		pa_addr->pa_flip_mask = addr_out.pa_flip_mask;
 		pa_addr->channel_idx = addr_out.channel_idx;
 		pa_addr->bank = addr_out.bank;
 	}
@@ -164,7 +175,7 @@ static int convert_eeprom_record_to_nps_addr(struct ras_core_context *ras_core,
 	if (ret)
 		return ret;
 
-	*pa = convert_nps_pa_to_row_pa(ras_core, addr_out.pa, nps, false);
+	*pa = convert_nps_pa_to_row_pa(ras_core, &addr_out, nps, false);
 
 	return 0;
 }
-- 
2.55.0

