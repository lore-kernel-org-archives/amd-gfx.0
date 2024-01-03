Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B4EC47077
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7238B10E260;
	Wed,  3 Jan 2024 08:04:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F91310E25B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro6uedISIHUsXUZcGh8fVe6s+YRv2w5n6YB4ovnDPloJPvMUR6QxS1xTKmumI7K0zTX/jNj8YrXQRWO/E5vT+GtyWhuNfQy7HRuo6I668SWLrPQc7avGo7C1ak/lwFBU3x2rXpZt+HwlRT4cQxm8I2mqhuw4x1J9TXDmIJKNLtFKEqUMGiL1Ig8kg1KjrlFpOoeJ5cvISgNY6jJKH10ddoEEgtoo/NRRV+0goWECVFWpwXHw9y0ib7mTeQaILga5SoJyNrmO1hrQhAsiXRrBakR67ERHhNVfesF8Y9D2hftRckSiYuFTfwdzPTxfZeAkLrTdeXGiP0whGfrIG6RECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTca/ilKobO9dSQLGtt2qMx9qzwEcImbjqHGaN2cFYQ=;
 b=KA5me+nAZMJZjCdjg6o76a8bkl5e8bqe5w6+zBifas8T4FtaOv7rjBaQ5+WZ4i3mgzU/zZBYxrBAB7oYvQno1dM1SOCCmNihnhDDu24al8zDq9p3Cl3OrSY/N+nF3DXBEhBPzh4JrXdqcOSuSzxf+w+62IyLI+em6y1d4G3nkNdgzQReDlrlC9KuIhlvw4B/CGPrpV4BnmLsUOvGdzBZToNCBlmey2dD0a66bZVOqUwTLUWyl8+cdN8IQuN+mQHlH3S3ffhfWvJRRO4yrGh538ZvabmmjKxX/VPe8OhaHhQtwLKmLJ3sq+kDl/NaemV6uVwxyqHJHQXaq44f/ypVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTca/ilKobO9dSQLGtt2qMx9qzwEcImbjqHGaN2cFYQ=;
 b=eUs9rgiFEGlyKLcsIkJIAkzSvSYsh/LPwECeu+zwGJFuGuU0bAZESBZ+0FOaL1c+pvpTPPRRMgIoHotnqx7it2ENQoRRRfOIkuX9DJOxyr0SFFG9LXfajV0guZ3TIwigUJrUNUj7LVBm5Uo0GOPKuH3NR6sn8R5zSHip9UdUCPs=
Received: from SJ0PR13CA0112.namprd13.prod.outlook.com (2603:10b6:a03:2c5::27)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 08:04:05 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::ce) by SJ0PR13CA0112.outlook.office365.com
 (2603:10b6:a03:2c5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.11 via Frontend
 Transport; Wed, 3 Jan 2024 08:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:04:05 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:04:02 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/pm: remove unused mca_smu_funcs
Date: Wed, 3 Jan 2024 16:02:19 +0800
Message-ID: <20240103080220.2815115-14-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103080220.2815115-1-kevinyang.wang@amd.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: 940c70db-abda-4e80-24dc-08dc0c328e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QRBofuGeGR6ktRgackomXXPWfBk+ClMeq6oFQu/D9Q31bMmp+FSgNxRB5diYx6udzfIgz1dBihafzOYQIf50+oZhpafExAwqtz1I2GUjtgz6MUengmcMMG5ueSfy9vVUswyiE+vGlazV2MXeSYCcyHMxCym2M1rv2W7j7uK9jdQkFz/Ogb0GA0/KQ1Xb2KtRx5w6a45s7xfrsP1W66EKGsCW5Gbm+UesoPE7zyjU+FfigLqzGL0qV1t6Ilsye1RET2jRUpFPY1JOy8shzo7TdtD+x6w89b1v8XEEqphhoTcolQQH8efJzF+awRQK+XS726If70DaRe5jA4SJ2ld35RxNBtPpaf3A5S4p4DvW1q5zDTPxhB2hkBQ5c3twPYtjDJjJldwduvqePx/yhQdT7f7b+X8noEcJ3hUHZlWvoQYbZLQjNzX2z0Rm3P7PUHPmQDhteDUaLnNObRQI3VVqYr8GM2bTx+2qzIxpLQR4zkAOzBWAXqZHyg3W7QxnnapDERPnibeUCBUII6jGvmRQb57koDXqrawM5NyAcGf31I98AqOVxEOh31zMwBusnqgPcdhaPQn0TMsmvT1Z0lrOl4xNkZo82tR/Qkhdz9nyct8J2lL5xB/y+6ocF7vF+SGqmVzKqjCFhjr9Rv9L8zF3vAdhwYiJ7uhsh47infjh5JEM+Qd+jdNxmujR0lpKZFEZLYL3e8lymt6U3WADz46420SnlAr/V51VcvmWD8JUSc10gg1zNA7E+uLD4fXcgICXHZtsjmQBhVuiQ0g/YE13g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(36860700001)(478600001)(40460700003)(41300700001)(82740400003)(336012)(6916009)(356005)(4326008)(36756003)(81166007)(316002)(54906003)(70586007)(70206006)(86362001)(6666004)(47076005)(7696005)(1076003)(26005)(83380400001)(426003)(40480700001)(8936002)(16526019)(2616005)(8676002)(2906002)(5660300002)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:04:05.3276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940c70db-abda-4e80-24dc-08dc0c328e4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

remove unused mca smu backed interface.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 505 ------------------
 1 file changed, 505 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index bed75af45369..f31c9eb84a41 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -43,13 +43,10 @@
 #include "thm/thm_11_0_2_sh_mask.h"
 #include "amdgpu_xgmi.h"
 #include <linux/pci.h>
-#include "amdgpu_ras.h"
-#include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
 #include "smu_cmn.h"
 #include "mp/mp_13_0_6_offset.h"
 #include "mp/mp_13_0_6_sh_mask.h"
-#include "umc_v12_0.h"
 
 #undef MP1_Public
 #undef smnMP1_FIRMWARE_FLAGS
@@ -98,26 +95,6 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_6.bin");
 
 #define SMU_13_0_6_DSCLK_THRESHOLD 140
 
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
-
 #define P2S_TABLE_ID_A 0x50325341
 #define P2S_TABLE_ID_X 0x50325358
 
@@ -2375,487 +2352,6 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	return ret;
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
-
-	status0 = entry->regs[MCA_REG_IDX_STATUS];
-
-	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
-		*count = 0;
-		return 0;
-	}
-
-	if (type == AMDGPU_MCA_ERROR_TYPE_UE && umc_v12_0_is_uncorrectable_error(adev, status0))
-		*count = 1;
-	else if (type == AMDGPU_MCA_ERROR_TYPE_CE && umc_v12_0_is_correctable_error(adev, status0))
-		*count = 1;
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
-	if (type == AMDGPU_MCA_ERROR_TYPE_UE && ext_error_code == 0)
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
-	if (!(adev->flags & AMD_IS_APU) && smu->smc_fw_version >= 0x00555600) {
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
-static int __mca_smu_get_ras_mca_set(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras,
-				     enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
-{
-	struct mca_bank_entry entry;
-	uint32_t mca_cnt;
-	int i, ret;
-
-	ret = mca_get_valid_mca_count(adev, type, &mca_cnt);
-	if (ret)
-		return ret;
-
-	/* if valid mca bank count is 0, the driver can return 0 directly */
-	if (!mca_cnt)
-		return 0;
-
-	for (i = 0; i < mca_cnt; i++) {
-		memset(&entry, 0, sizeof(entry));
-		ret = mca_get_mca_entry(adev, type, i, &entry);
-		if (ret)
-			return ret;
-
-		if (mca_ras && !mca_bank_is_valid(adev, mca_ras, type, &entry))
-			continue;
-
-		ret = amdgpu_mca_bank_set_add_entry(mca_set, &entry);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int mca_smu_get_ras_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-				   enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
-{
-	const struct mca_ras_info *mca_ras = NULL;
-
-	if (!mca_set)
-		return -EINVAL;
-
-	if (blk != AMDGPU_RAS_BLOCK_COUNT) {
-		mca_ras = mca_get_mca_ras_info(adev, blk);
-		if (!mca_ras)
-			return -EOPNOTSUPP;
-	}
-
-	return __mca_smu_get_ras_mca_set(adev, mca_ras, type, mca_set);
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
-	.mca_get_ras_mca_set = mca_smu_get_ras_mca_set,
-	.mca_parse_mca_error_count = mca_smu_parse_mca_error_count,
-	.mca_get_mca_entry = mca_smu_get_mca_entry,
-	.mca_get_valid_mca_count = mca_smu_get_valid_mca_count,
-};
-
 static int aca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -3104,6 +2600,5 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v13_0_6_table_map;
 	smu->smc_driver_if_version = SMU13_0_6_DRIVER_IF_VERSION;
 	smu_v13_0_set_smu_mailbox_registers(smu);
-	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
 	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
 }
-- 
2.34.1

