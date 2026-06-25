Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1A7CDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DF110F16F;
	Thu, 25 Jun 2026 08:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4iW0Fhqo";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C5610F16F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPxCOlW98l9XqZog8XUa/TDaCcqBOxDnL4miG3Lti4Lql6mVYiwgSxQaNJLnb2andod4dmEKLb8oqmyRy3Fs2EAOaJUzArLnY1cFqTKAD0uK6pYs6XtCJxkPq71Swi+zVb26P7G2eX2YZhmIsV56OU+Cv19L03Lizk64OeNxnFSA2kcIeE96bUkIUXMioialSQuTDcPTgB3mtyONfNhUpZVbK+0oq7TzfyQl7sZob6Y+xeEer0qo1rVbZxl7GMwPBE7beTwDKTVglDjhYKtYe2mRMNVSp5E/Lo5Tp+3sux/KRR88D5y8r4pp+GzirzvFn2BgLbKA3YpvnFV7KXNSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTkP3HqIywIrUKdcS+xQx3Qnj8eFekQUQ2UX8B52GTU=;
 b=CskjDRkschUhqcIgi1QK/hGFyuKxEBz8u64i3R/jeoKMiqj0h5VzymZCp0wXoEkwDDMDeu3nzPLBXHw/5s7gzICeCO0Zhg68bve3WcWhhmi8bP06HhRad1nc8aRVXD0w3pbJrwrmT5Cd8Ff6nylkUHHqzQhttlcLOgG/bQShJjtuVNbL2QtmiElWpwMr8lHAN76tCFzgNcCDPdWDQJIJpRSnZnVgT/g2d7Qqwo25WwcnR2q3/aJrYbmohOI9V/KCv4nGbqqBg3W+/UaZTMHn5LZMrJpIyF/WGruBUBqpL2oGflnanUGywenH3TmctU38i38jH8V13czXt01o+O59og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTkP3HqIywIrUKdcS+xQx3Qnj8eFekQUQ2UX8B52GTU=;
 b=4iW0FhqoykZHYRjmViqogD6i8tqM3GPOfDZCwnn1r/Io0vPrQAmxNEFVyzbCrvQNq1+x0ILef0zXWIYVtbfYyWFXj11Y/0tacPMBv55fkCS0Du/cRTdPK51WNIV0PIaMRSqlieQZQNWb5Af00SHQNjZZPUvG0nqxksk9qOnyqDg=
Received: from PH8P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::16)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:20:33 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::8c) by PH8P220CA0036.outlook.office365.com
 (2603:10b6:510:348::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:33 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:30 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 12/44] drm/amd/pm: retire aca smu backend support for smu
Date: Thu, 25 Jun 2026 16:19:05 +0800
Message-ID: <c7988a53e618158beb8d93f156a718d61b8ebf44.1782373701.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eedc314-3c52-4078-5edc-08ded292a07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jck7STUkAXeesjFTx0j6h+FyCupkdeYHLdikd0ju+a4IqADbUd+GsmdedrG4hxtNiqPMpG/Kfa4e3/ISWRaXJ/0ZQW8jNJSUNO821eveLndFMYnLFlk3X3IGOYvmx6M0XwuPiSmwkpr2tz+1ndCUuWoyYicObfYI6JfRXTKI4CC6dd0xvrwUa/eUcz9tZ/B0qxe5eHHd5aPH33YxLwlP9pdxYDlwL1cmMICJ+ZVhQpOil3KNsFIMpuO3sFoB3/CqEf8lzoggoGSoh0Iqv5gXcQK+sHh6WCAkKCsJ3gNHxmJ5Qwq3i80xTbO4NzH4bXLUHolWLSkmhV86e2cIku18KOcvTsN2PxbbCOxSL/7WVfHgdf1kWpWRBnzuducKpkaXBrg3yJ5TSCUelokSY3b/Uob2KbJfA7jawWSpr+jsKNPrepKUEp77TXidvCewKGkc4OzoH+i9KWJigxKku9GcrB3knUk+wH1wGmZqj474bV47Umh51k/hCCkcZGgnCWBIQI66aX21VRVA1kZWyrgN1Y6HYwWfKBe0NGYE2szdAMWH+5VtDjpN5Uy+nHY5t+bIl+CDv0/MbRHMmj1mP3chYSWNKBVBfKDfERtmd9KHQHy9VppUsZhg6qXkwVehsyMdQJO7DangCc7RukHaKTQ5gfrCtBnUqKGxLvBBvqomW/+ZEo2IGZp+fZBQysfwOXesyQy4Q7d5rzg1lZb/Soqk1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A+AQCpj0baLf8g3s5ggIMAJcbeANe7e9wW4yFyILus/d2hQg4+PG+9xlzwNv9kcGVjecFu3zGnyF5jmVMpaeVHnxHdiL0G4p1L+IzhMDIE16hj+yI5jYs2UolqqgH6qZtl4zr7nU2Lwk9JHiFwI7F0qwRxTeF7s9myW9TyHQ69QjsuCPCNVlO7EcCJ2/DqoZ9tqUYwRQaDeQA7AEGEVJdS8QyxYmFn3aDDChPw5NpEXDMpD7vtch/hG8l18H65tniRnn4VCK8BKTTmBAuZCxTfn3rx6fiYL4ZWnPmAEnjTSEYRKtgbCMxqsHOa1xoRwB77UIqUeaMkbXVvdUfBTgeUJioJvfUsTTUYP3dqgpuWieUtHzns8teY+MtIFfJdMMYJJ6I6sVrtnYNzE+jgV0KDJpb5u8sxrhhFqDowHw3nNKebWVe0SX191aG8ex4Ghb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:33.1809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eedc314-3c52-4078-5edc-08ded292a07c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
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

retire aca smu backend support for smu v13.0.6

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 153 ------------------
 1 file changed, 153 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ce520f43ab94..e149993f55b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -45,7 +45,6 @@
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
 #include "amdgpu_mca.h"
-#include "amdgpu_aca.h"
 #include "smu_cmn.h"
 #include "mp/mp_13_0_6_offset.h"
 #include "mp/mp_13_0_6_sh_mask.h"
@@ -3764,157 +3763,6 @@ static const struct amdgpu_mca_smu_funcs smu_v13_0_6_mca_smu_funcs = {
 	.mca_get_valid_mca_count = mca_smu_get_valid_mca_count,
 };
 
-static int aca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-
-	return smu_v13_0_6_mca_set_debug_mode(smu, enable);
-}
-
-static int smu_v13_0_6_get_valid_aca_count(struct smu_context *smu, enum aca_smu_type type, u32 *count)
-{
-	uint32_t msg;
-	int ret;
-
-	if (!count)
-		return -EINVAL;
-
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		msg = SMU_MSG_QueryValidMcaCount;
-		break;
-	case ACA_SMU_TYPE_CE:
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
-static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev,
-				       enum aca_smu_type type, u32 *count)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret;
-
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-	case ACA_SMU_TYPE_CE:
-		ret = smu_v13_0_6_get_valid_aca_count(smu, type, count);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static int __smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_smu_type type,
-				       int idx, int offset, u32 *val)
-{
-	uint32_t msg, param;
-
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		msg = SMU_MSG_McaBankDumpDW;
-		break;
-	case ACA_SMU_TYPE_CE:
-		msg = SMU_MSG_McaBankCeDumpDW;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	param = ((idx & 0xffff) << 16) | (offset & 0xfffc);
-
-	return smu_cmn_send_smc_msg_with_param(smu, msg, param, (uint32_t *)val);
-}
-
-static int smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_smu_type type,
-				     int idx, int offset, u32 *val, int count)
-{
-	int ret, i;
-
-	if (!val)
-		return -EINVAL;
-
-	for (i = 0; i < count; i++) {
-		ret = __smu_v13_0_6_aca_bank_dump(smu, type, idx, offset + (i << 2), &val[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int aca_bank_read_reg(struct amdgpu_device *adev, enum aca_smu_type type,
-			     int idx, int reg_idx, u64 *val)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	u32 data[2] = {0, 0};
-	int ret;
-
-	if (!val || reg_idx >= ACA_REG_IDX_COUNT)
-		return -EINVAL;
-
-	ret = smu_v13_0_6_aca_bank_dump(smu, type, idx, reg_idx * 8, data, ARRAY_SIZE(data));
-	if (ret)
-		return ret;
-
-	*val = (u64)data[1] << 32 | data[0];
-
-	dev_dbg(adev->dev, "mca read bank reg: type:%s, index: %d, reg_idx: %d, val: 0x%016llx\n",
-		type == ACA_SMU_TYPE_UE ? "UE" : "CE", idx, reg_idx, *val);
-
-	return 0;
-}
-
-static int aca_smu_get_valid_aca_bank(struct amdgpu_device *adev,
-				      enum aca_smu_type type, int idx, struct aca_bank *bank)
-{
-	int i, ret, count;
-
-	count = min_t(int, 16, ARRAY_SIZE(bank->regs));
-	for (i = 0; i < count; i++) {
-		ret = aca_bank_read_reg(adev, type, idx, i, &bank->regs[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int aca_smu_parse_error_code(struct amdgpu_device *adev, struct aca_bank *bank)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	int error_code;
-
-	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND)))
-		error_code = ACA_REG__SYND__ERRORINFORMATION(bank->regs[ACA_REG_IDX_SYND]);
-	else
-		error_code = ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
-
-	return error_code & 0xff;
-}
-
-static const struct aca_smu_funcs smu_v13_0_6_aca_smu_funcs = {
-	.max_ue_bank_count = 12,
-	.max_ce_bank_count = 12,
-	.set_debug_mode = aca_smu_set_debug_mode,
-	.get_valid_aca_count = aca_smu_get_valid_aca_count,
-	.get_valid_aca_bank = aca_smu_get_valid_aca_bank,
-	.parse_error_code = aca_smu_parse_error_code,
-};
-
 static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
 {
 	smu->smu_temp.temp_funcs = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
@@ -4021,6 +3869,5 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu_v13_0_init_msg_ctl(smu, message_map);
 	smu_v13_0_6_set_temp_funcs(smu);
 	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
-	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
 }
 
-- 
2.34.1

