Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755C8CDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E731610F18B;
	Thu, 25 Jun 2026 08:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DEqdveRG";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB0D10F185
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4noQM3nr53xnfWa1dTnmulpM3GsiuueA8KelQVL8TGF5+OOW4+uId6WLWlIccVBv0De3Z12a2XdeXgyfkpUcQw4FuY9nL2yEIegZcRp9kvcAQTL2YHzVBx7CLft7Hu+5cvAHawBgornXRjFb4IYKrl6zuPupGXILE/C/yLxGRHg/FA+b9v1jTczShNT8TW/6RoaNa4c7XPRjVUIdgIZjWXXNDF7XnxKc3mUmiHwBGFYHrfGzPiwUZ//i1UaBCSfg0RWs6re3Ug5TtiaZYG1w8jnFoU63zEGYxd0yMhPpOfAtQd7nNeDOnGNTMLlduMhr68cL1Re2MuRJMqQmINajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUY1GWqCQuoH1d+rhI1t8eLqPbag6kfSLc+V07wHftY=;
 b=P/j1xRaTIz/XpVfN6fD4rvArdBMLKe5cQYtRSpY/a/ZxvuCCpgcjm6ZO0lbGSJ6OWO7u6eRANKlQOQgWvUmDoaipOm2nsqP4GvYWiDkbZYpUKxjzfB1EzhvjYn0FS7ssPjMYq6yHxYayNWpxGVqm2L7bNc1yNfhIeX8RiXwfAVexUQaTDdEVa1FIOfujktyGtDNfpaigTydxRD+QzrdINF97XL7i/pwb4MH50riM+skzSdyq4r/K6uoyFUZYqbVRuteRpRAIcsfQmIeCcdnQmCbF0OA5Wq1IUNojBXNGwo1r3hIWcFY8fnV8tsddthL0VjL3Ros0xNVLBzp1R6v3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUY1GWqCQuoH1d+rhI1t8eLqPbag6kfSLc+V07wHftY=;
 b=DEqdveRGXASGqtC//g1QxUtm+OzaO6ZAkoe3D2ba+gE5s4l4HTjLB/YVcsP1sSyFsSyvAOjRc8s1dn6Qnt+4UqaL5fJNZPYRiYtCHmofX3+EYKx8WVeUhHWx6/Ks+MYjrxsCEn8rQjHYJNYZVMg4BsSUZKa71SoLj4tM8Iqsd+I=
Received: from PH8P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::14)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 08:20:41 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::49) by PH8P220CA0031.outlook.office365.com
 (2603:10b6:510:348::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:41 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:39 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 16/44] drm/amd/pm: retire smu_13_0_6 mca dump support
Date: Thu, 25 Jun 2026 16:19:09 +0800
Message-ID: <b36acfe44b7639361c9914b16a55d874888c9ad6.1782373701.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 289f9fea-5008-4314-2207-08ded292a581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: Vfop9cyiBv4TwFOps/bEebfOLh0+B9urM7mynBHDy2MI3KLv4DnsDZ6hADr6w6yV2oMsHkcaGwK9pfUMt8p9Soh2LKn7o9UPliJSE5ZX7KRu2EPy7dNaq5Dg9GDZNS+NqsoOTE2/axGmXspGRJxYcjCh/OK67E782Y0rFZnoXZT6RD6u5GtgFSSlivRnrijln1RBpDlPL0LwKUxbxBQAyRYef5EouzSCPmvphU9mgtxaHgmTA5mzZlHsxYVvlmish8joblq9BBbKjxDhXcn/zvGaj8tPm6rhQhUurH9pEhAxh7Q4sV/PyVxOSQRNlpCnQW5ClrPdm2y3eSXN+H8zp5ICo2mgMKL1G80UwCIGSuyoKJn/yHQlDIngKYHYd86bH7wrixvUGZ0fZbQWiyzb056DQyup/CBPDdYWX6L+1B6Oss5aC1krdkf3Xfb/HKJccTvvC0sipDv0jaonEuCv45g6seqAW4eBwnOnaOLl45dOsa/skJn5fQpTj+OPOInkuTlauZNtcc1BDfpDD86odhOhV86c1IHzuqmk7KWcDFuVfRug+EhtAi7fIYdl5ZHSzXqHBOgGf700YJ87vLAe+eLYkFtDJkaHF+mNxz+I4u2da6c7iEEnyKD8AX2UBjMY2NtlvanF2LvftIrHVB7x79uBY7aLQ97j47RSI8RQP37WBH4H7wtLjOsu/Mr8sAxx+5n4Z2m/SA0EF4752+mBvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PXVIbgww8FtOpRjDGn5DfEtoBlZ/uEIijHxRdROJHl2Y3xTwejnAx/W4hOntgVhECIvOL+vj94VNgqaXGVfwF8VcgIYeh8JdGpx0rwVGV0EiFeOMBNfWRRkKHO1ROsbavTdg66AHWFo9GC7ZPVexY0GS2RhTE3vsbI3LWVCGbDXSubWXWrOtCDau5z3hPI2SfYD9UK18St4WhQlOzxL7LBVgeXfrVSWIdRK5SL0vWGnP2Fz+6dAki+ggZgY4b0mVO96JeJH4YSS5aMcx5JVllM1TzrA/NuA7pp+FcW+DzUjg8ZO9s1IQVkH7nW3qezsbSLz6rm9VKOM14oc1Fu/NpkGl2rCE3bSnjnSZvMUPsUdPH7gDHDsI+vX1WE/voUirT52I5PmUnDEWXS6Ds8QhrML4kf9MfDMyVx1sqL82IAi5so9cQldaJSiLUzD8CT0h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:41.6077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289f9fea-5008-4314-2207-08ded292a581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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

retire smu_13_0_6 mca dump support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 497 ------------------
 1 file changed, 497 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index e149993f55b2..395b735dfa8e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -44,7 +44,6 @@
 #include "amdgpu_xgmi.h"
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
-#include "amdgpu_mca.h"
 #include "smu_cmn.h"
 #include "mp/mp_13_0_6_offset.h"
 #include "mp/mp_13_0_6_sh_mask.h"
@@ -98,25 +97,6 @@ static const struct smu_feature_bits smu_v13_0_6_dpm_features = {
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
 #define LINK_SPEED_MAX 4
-#define MCA_BANK_IPID(_ip, _hwid, _type) \
-	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
-
-struct mca_bank_ipid {
-	enum amdgpu_mca_ip ip;
-	uint16_t hwid;
-	uint16_t mcatype;
-};
-
-struct mca_ras_info {
-	enum amdgpu_ras_block blkid;
-	enum amdgpu_mca_ip ip;
-	int *err_code_array;
-	int err_code_count;
-	int (*get_err_count)(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-			     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count);
-	bool (*bank_is_valid)(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-			      enum amdgpu_mca_error_type type, struct mca_bank_entry *entry);
-};
 
 #define P2S_TABLE_ID_A 0x50325341
 #define P2S_TABLE_ID_X 0x50325358
@@ -1942,17 +1922,6 @@ static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 	return 0;
 }
 
-static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
-{
-	/* NOTE: this ClearMcaOnRead message is only supported for smu version 85.72.0 or higher */
-	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(MCA_DEBUG_MODE)))
-		return 0;
-
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
-					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
-					       NULL);
-}
-
 static int smu_v13_0_6_system_features_control(struct smu_context *smu,
 					       bool enable)
 {
@@ -3298,471 +3267,6 @@ static int smu_v13_0_6_post_init(struct smu_context *smu)
 	return 0;
 }
 
-static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-
-	return smu_v13_0_6_mca_set_debug_mode(smu, enable);
-}
-
-static int smu_v13_0_6_get_valid_mca_count(struct smu_context *smu, enum amdgpu_mca_error_type type, uint32_t *count)
-{
-	uint32_t msg;
-	int ret;
-
-	if (!count)
-		return -EINVAL;
-
-	switch (type) {
-	case AMDGPU_MCA_ERROR_TYPE_UE:
-		msg = SMU_MSG_QueryValidMcaCount;
-		break;
-	case AMDGPU_MCA_ERROR_TYPE_CE:
-		msg = SMU_MSG_QueryValidMcaCeCount;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = smu_cmn_send_smc_msg(smu, msg, count);
-	if (ret) {
-		*count = 0;
-		return ret;
-	}
-
-	return 0;
-}
-
-static int __smu_v13_0_6_mca_dump_bank(struct smu_context *smu, enum amdgpu_mca_error_type type,
-				       int idx, int offset, uint32_t *val)
-{
-	uint32_t msg, param;
-
-	switch (type) {
-	case AMDGPU_MCA_ERROR_TYPE_UE:
-		msg = SMU_MSG_McaBankDumpDW;
-		break;
-	case AMDGPU_MCA_ERROR_TYPE_CE:
-		msg = SMU_MSG_McaBankCeDumpDW;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	param = ((idx & 0xffff) << 16) | (offset & 0xfffc);
-
-	return smu_cmn_send_smc_msg_with_param(smu, msg, param, val);
-}
-
-static int smu_v13_0_6_mca_dump_bank(struct smu_context *smu, enum amdgpu_mca_error_type type,
-				     int idx, int offset, uint32_t *val, int count)
-{
-	int ret, i;
-
-	if (!val)
-		return -EINVAL;
-
-	for (i = 0; i < count; i++) {
-		ret = __smu_v13_0_6_mca_dump_bank(smu, type, idx, offset + (i << 2), &val[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static const struct mca_bank_ipid smu_v13_0_6_mca_ipid_table[AMDGPU_MCA_IP_COUNT] = {
-	MCA_BANK_IPID(UMC, 0x96, 0x0),
-	MCA_BANK_IPID(SMU, 0x01, 0x1),
-	MCA_BANK_IPID(MP5, 0x01, 0x2),
-	MCA_BANK_IPID(PCS_XGMI, 0x50, 0x0),
-};
-
-static void mca_bank_entry_info_decode(struct mca_bank_entry *entry, struct mca_bank_info *info)
-{
-	u64 ipid = entry->regs[MCA_REG_IDX_IPID];
-	u32 instidhi, instid;
-
-	/* NOTE: All MCA IPID register share the same format,
-	 * so the driver can share the MCMP1 register header file.
-	 * */
-
-	info->hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
-	info->mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
-
-	/*
-	 * Unfied DieID Format: SAASS. A:AID, S:Socket.
-	 * Unfied DieID[4] = InstanceId[0]
-	 * Unfied DieID[0:3] = InstanceIdHi[0:3]
-	 */
-	instidhi = REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi);
-	instid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo);
-	info->aid = ((instidhi >> 2) & 0x03);
-	info->socket_id = ((instid & 0x1) << 2) | (instidhi & 0x03);
-}
-
-static int mca_bank_read_reg(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-			     int idx, int reg_idx, uint64_t *val)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	uint32_t data[2] = {0, 0};
-	int ret;
-
-	if (!val || reg_idx >= MCA_REG_IDX_COUNT)
-		return -EINVAL;
-
-	ret = smu_v13_0_6_mca_dump_bank(smu, type, idx, reg_idx * 8, data, ARRAY_SIZE(data));
-	if (ret)
-		return ret;
-
-	*val = (uint64_t)data[1] << 32 | data[0];
-
-	dev_dbg(adev->dev, "mca read bank reg: type:%s, index: %d, reg_idx: %d, val: 0x%016llx\n",
-		type == AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE", idx, reg_idx, *val);
-
-	return 0;
-}
-
-static int mca_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-			     int idx, struct mca_bank_entry *entry)
-{
-	int i, ret;
-
-	/* NOTE: populated all mca register by default */
-	for (i = 0; i < ARRAY_SIZE(entry->regs); i++) {
-		ret = mca_bank_read_reg(adev, type, idx, i, &entry->regs[i]);
-		if (ret)
-			return ret;
-	}
-
-	entry->idx = idx;
-	entry->type = type;
-
-	mca_bank_entry_info_decode(entry, &entry->info);
-
-	return 0;
-}
-
-static int mca_decode_ipid_to_hwip(uint64_t val)
-{
-	const struct mca_bank_ipid *ipid;
-	uint16_t hwid, mcatype;
-	int i;
-
-	hwid = REG_GET_FIELD(val, MCMP1_IPIDT0, HardwareID);
-	mcatype = REG_GET_FIELD(val, MCMP1_IPIDT0, McaType);
-
-	for (i = 0; i < ARRAY_SIZE(smu_v13_0_6_mca_ipid_table); i++) {
-		ipid = &smu_v13_0_6_mca_ipid_table[i];
-
-		if (!ipid->hwid)
-			continue;
-
-		if (ipid->hwid == hwid && ipid->mcatype == mcatype)
-			return i;
-	}
-
-	return AMDGPU_MCA_IP_UNKNOW;
-}
-
-static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-				     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
-{
-	uint64_t status0;
-	uint32_t ext_error_code;
-	uint32_t odecc_err_cnt;
-
-	status0 = entry->regs[MCA_REG_IDX_STATUS];
-	ext_error_code = MCA_REG__STATUS__ERRORCODEEXT(status0);
-	odecc_err_cnt = MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);
-
-	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
-		*count = 0;
-		return 0;
-	}
-
-	if (umc_v12_0_is_deferred_error(adev, status0) ||
-	    umc_v12_0_is_uncorrectable_error(adev, status0) ||
-	    umc_v12_0_is_correctable_error(adev, status0))
-		*count = (ext_error_code == 0) ? odecc_err_cnt : 1;
-
-	amdgpu_umc_update_ecc_status(adev,
-			entry->regs[MCA_REG_IDX_STATUS],
-			entry->regs[MCA_REG_IDX_IPID],
-			entry->regs[MCA_REG_IDX_ADDR]);
-
-	return 0;
-}
-
-static int mca_pcs_xgmi_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-					  enum amdgpu_mca_error_type type, struct mca_bank_entry *entry,
-					  uint32_t *count)
-{
-	u32 ext_error_code;
-	u32 err_cnt;
-
-	ext_error_code = MCA_REG__STATUS__ERRORCODEEXT(entry->regs[MCA_REG_IDX_STATUS]);
-	err_cnt = MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);
-
-	if (type == AMDGPU_MCA_ERROR_TYPE_UE &&
-	    (ext_error_code == 0 || ext_error_code == 9))
-		*count = err_cnt;
-	else if (type == AMDGPU_MCA_ERROR_TYPE_CE && ext_error_code == 6)
-		*count = err_cnt;
-
-	return 0;
-}
-
-static bool mca_smu_check_error_code(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras,
-				     uint32_t errcode)
-{
-	int i;
-
-	if (!mca_ras->err_code_count || !mca_ras->err_code_array)
-		return true;
-
-	for (i = 0; i < mca_ras->err_code_count; i++) {
-		if (errcode == mca_ras->err_code_array[i])
-			return true;
-	}
-
-	return false;
-}
-
-static int mca_gfx_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-				     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
-{
-	uint64_t status0, misc0;
-
-	status0 = entry->regs[MCA_REG_IDX_STATUS];
-	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
-		*count = 0;
-		return 0;
-	}
-
-	if (type == AMDGPU_MCA_ERROR_TYPE_UE &&
-	    REG_GET_FIELD(status0, MCMP1_STATUST0, UC) == 1 &&
-	    REG_GET_FIELD(status0, MCMP1_STATUST0, PCC) == 1) {
-		*count = 1;
-		return 0;
-	} else {
-		misc0 = entry->regs[MCA_REG_IDX_MISC0];
-		*count = REG_GET_FIELD(misc0, MCMP1_MISC0T0, ErrCnt);
-	}
-
-	return 0;
-}
-
-static int mca_smu_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-				     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
-{
-	uint64_t status0, misc0;
-
-	status0 = entry->regs[MCA_REG_IDX_STATUS];
-	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
-		*count = 0;
-		return 0;
-	}
-
-	if (type == AMDGPU_MCA_ERROR_TYPE_UE &&
-	    REG_GET_FIELD(status0, MCMP1_STATUST0, UC) == 1 &&
-	    REG_GET_FIELD(status0, MCMP1_STATUST0, PCC) == 1) {
-		if (count)
-			*count = 1;
-		return 0;
-	}
-
-	misc0 = entry->regs[MCA_REG_IDX_MISC0];
-	*count = REG_GET_FIELD(misc0, MCMP1_MISC0T0, ErrCnt);
-
-	return 0;
-}
-
-static bool mca_gfx_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-				      enum amdgpu_mca_error_type type, struct mca_bank_entry *entry)
-{
-	uint32_t instlo;
-
-	instlo = REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT0, InstanceIdLo);
-	instlo &= GENMASK(31, 1);
-	switch (instlo) {
-	case 0x36430400: /* SMNAID XCD 0 */
-	case 0x38430400: /* SMNAID XCD 1 */
-	case 0x40430400: /* SMNXCD XCD 0, NOTE: FIXME: fix this error later */
-		return true;
-	default:
-		return false;
-	}
-
-	return false;
-};
-
-static bool mca_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-				  enum amdgpu_mca_error_type type, struct mca_bank_entry *entry)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	uint32_t errcode, instlo;
-
-	instlo = REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT0, InstanceIdLo);
-	instlo &= GENMASK(31, 1);
-	if (instlo != 0x03b30400)
-		return false;
-
-	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND))) {
-		errcode = MCA_REG__SYND__ERRORINFORMATION(entry->regs[MCA_REG_IDX_SYND]);
-		errcode &= 0xff;
-	} else {
-		errcode = REG_GET_FIELD(entry->regs[MCA_REG_IDX_STATUS], MCMP1_STATUST0, ErrorCode);
-	}
-
-	return mca_smu_check_error_code(adev, mca_ras, errcode);
-}
-
-static int sdma_err_codes[] = { CODE_SDMA0, CODE_SDMA1, CODE_SDMA2, CODE_SDMA3 };
-static int mmhub_err_codes[] = {
-	CODE_DAGB0, CODE_DAGB0 + 1, CODE_DAGB0 + 2, CODE_DAGB0 + 3, CODE_DAGB0 + 4, /* DAGB0-4 */
-	CODE_EA0, CODE_EA0 + 1, CODE_EA0 + 2, CODE_EA0 + 3, CODE_EA0 + 4,	/* MMEA0-4*/
-	CODE_VML2, CODE_VML2_WALKER, CODE_MMCANE,
-};
-
-static int vcn_err_codes[] = {
-	CODE_VIDD, CODE_VIDV,
-};
-static int jpeg_err_codes[] = {
-	CODE_JPEG0S, CODE_JPEG0D, CODE_JPEG1S, CODE_JPEG1D,
-	CODE_JPEG2S, CODE_JPEG2D, CODE_JPEG3S, CODE_JPEG3D,
-	CODE_JPEG4S, CODE_JPEG4D, CODE_JPEG5S, CODE_JPEG5D,
-	CODE_JPEG6S, CODE_JPEG6D, CODE_JPEG7S, CODE_JPEG7D,
-};
-
-static const struct mca_ras_info mca_ras_table[] = {
-	{
-		.blkid = AMDGPU_RAS_BLOCK__UMC,
-		.ip = AMDGPU_MCA_IP_UMC,
-		.get_err_count = mca_umc_mca_get_err_count,
-	}, {
-		.blkid = AMDGPU_RAS_BLOCK__GFX,
-		.ip = AMDGPU_MCA_IP_SMU,
-		.get_err_count = mca_gfx_mca_get_err_count,
-		.bank_is_valid = mca_gfx_smu_bank_is_valid,
-	}, {
-		.blkid = AMDGPU_RAS_BLOCK__SDMA,
-		.ip = AMDGPU_MCA_IP_SMU,
-		.err_code_array = sdma_err_codes,
-		.err_code_count = ARRAY_SIZE(sdma_err_codes),
-		.get_err_count = mca_smu_mca_get_err_count,
-		.bank_is_valid = mca_smu_bank_is_valid,
-	}, {
-		.blkid = AMDGPU_RAS_BLOCK__MMHUB,
-		.ip = AMDGPU_MCA_IP_SMU,
-		.err_code_array = mmhub_err_codes,
-		.err_code_count = ARRAY_SIZE(mmhub_err_codes),
-		.get_err_count = mca_smu_mca_get_err_count,
-		.bank_is_valid = mca_smu_bank_is_valid,
-	}, {
-		.blkid = AMDGPU_RAS_BLOCK__XGMI_WAFL,
-		.ip = AMDGPU_MCA_IP_PCS_XGMI,
-		.get_err_count = mca_pcs_xgmi_mca_get_err_count,
-	}, {
-		.blkid = AMDGPU_RAS_BLOCK__VCN,
-		.ip = AMDGPU_MCA_IP_SMU,
-		.err_code_array = vcn_err_codes,
-		.err_code_count = ARRAY_SIZE(vcn_err_codes),
-		.get_err_count = mca_smu_mca_get_err_count,
-		.bank_is_valid = mca_smu_bank_is_valid,
-	}, {
-		.blkid = AMDGPU_RAS_BLOCK__JPEG,
-		.ip = AMDGPU_MCA_IP_SMU,
-		.err_code_array = jpeg_err_codes,
-		.err_code_count = ARRAY_SIZE(jpeg_err_codes),
-		.get_err_count = mca_smu_mca_get_err_count,
-		.bank_is_valid = mca_smu_bank_is_valid,
-	},
-};
-
-static const struct mca_ras_info *mca_get_mca_ras_info(struct amdgpu_device *adev, enum amdgpu_ras_block blkid)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mca_ras_table); i++) {
-		if (mca_ras_table[i].blkid == blkid)
-			return &mca_ras_table[i];
-	}
-
-	return NULL;
-}
-
-static int mca_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret;
-
-	switch (type) {
-	case AMDGPU_MCA_ERROR_TYPE_UE:
-	case AMDGPU_MCA_ERROR_TYPE_CE:
-		ret = smu_v13_0_6_get_valid_mca_count(smu, type, count);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static bool mca_bank_is_valid(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras,
-			      enum amdgpu_mca_error_type type, struct mca_bank_entry *entry)
-{
-	if (mca_decode_ipid_to_hwip(entry->regs[MCA_REG_IDX_IPID]) != mca_ras->ip)
-		return false;
-
-	if (mca_ras->bank_is_valid)
-		return mca_ras->bank_is_valid(mca_ras, adev, type, entry);
-
-	return true;
-}
-
-static int mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
-					 struct mca_bank_entry *entry, uint32_t *count)
-{
-	const struct mca_ras_info *mca_ras;
-
-	if (!entry || !count)
-		return -EINVAL;
-
-	mca_ras = mca_get_mca_ras_info(adev, blk);
-	if (!mca_ras)
-		return -EOPNOTSUPP;
-
-	if (!mca_bank_is_valid(adev, mca_ras, type, entry)) {
-		*count = 0;
-		return 0;
-	}
-
-	return mca_ras->get_err_count(mca_ras, adev, type, entry, count);
-}
-
-static int mca_smu_get_mca_entry(struct amdgpu_device *adev,
-				 enum amdgpu_mca_error_type type, int idx, struct mca_bank_entry *entry)
-{
-	return mca_get_mca_entry(adev, type, idx, entry);
-}
-
-static int mca_smu_get_valid_mca_count(struct amdgpu_device *adev,
-				       enum amdgpu_mca_error_type type, uint32_t *count)
-{
-	return mca_get_valid_mca_count(adev, type, count);
-}
-
-static const struct amdgpu_mca_smu_funcs smu_v13_0_6_mca_smu_funcs = {
-	.max_ue_count = 12,
-	.max_ce_count = 12,
-	.mca_set_debug_mode = mca_smu_set_debug_mode,
-	.mca_parse_mca_error_count = mca_smu_parse_mca_error_count,
-	.mca_get_mca_entry = mca_smu_get_mca_entry,
-	.mca_get_valid_mca_count = mca_smu_get_valid_mca_count,
-};
-
 static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
 {
 	smu->smu_temp.temp_funcs = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
@@ -3868,6 +3372,5 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->smc_fw_caps |= SMU_FW_CAP_RAS_PRI;
 	smu_v13_0_init_msg_ctl(smu, message_map);
 	smu_v13_0_6_set_temp_funcs(smu);
-	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
 }
 
-- 
2.34.1

