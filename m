Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BC6CDB476
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9EC10E55F;
	Mon, 22 Jun 2026 08:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FyjNfwfC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150F910E55E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggu+9zTbGaxsnpd/Rgwuh49hVKiMD47ZZEcaLbj8Qo4hVGB5yLPumdbp9yAMSNGOEcBWuel0IQ2iK6GLcU6y+BhaNN3BmKu1ZIFAJ2N2S6pj0O6LTPeAnfRliMkYDcWDpOUA00/sDdJWCa6nK/mkwyz7/9ryLxfhb8LReHR/cAGwSm8cpI1oOFpqIwp7IE9M3Cd8cuiMgeSPl4TxcHeO+fwHmQmWSNuU73GGitqYjW5WqCCI23s+TQDToDdNhNQ6kINKdCaIV1fog2X99kPayjoyV3GIDg76AAEYeuGEfFQRSIX0tWYL5E89hH51xHKGFjxMC8IAd83drO+/DtJoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTkP3HqIywIrUKdcS+xQx3Qnj8eFekQUQ2UX8B52GTU=;
 b=iG1hG5NNxchgeiJRCewbIBlK8cVzoADEByYsSBc0t2rBSl7mr4mjVv8Owyp7MGQ7JNecf+q+ps1CcdhTaHOrrzJQrR+aCzEn2nwM6UeEc+jZ9SAHPhF2O2oP6mqaOM8dl1AlifHqwcIP0z5mSPB7qOesaL1qnfb1GGJ/cpRXPqEnzLSXEB7MB5moWEJjkhGlw86R+M5DoeKhHvGCVV48ohV/hqZpq3vd97D336voHI0FHTsUDzB9DQeAdDZdLJll0ubsysuN/vhWvpyBNa1JLSGw1dZ1xKT7soP0oGhFLwrjEjwOadHmF82en/TqkfNxsZiL67BYkZKZmeqEv0hLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTkP3HqIywIrUKdcS+xQx3Qnj8eFekQUQ2UX8B52GTU=;
 b=FyjNfwfClVOXgmgYVpzcQQihvzwhIgwU0FzPbMp8rN8NvSRKYqcg4n69Pn78jfbQUUyyXzPPXxpmD9XHKT4qlHByPhS6Xnpibtq29j+Dg6UYVabm8lwCuaA87Ce3kYicUDO1ZH8W9vK9bCRgSqEnb+kf65ozKoWEphoc1zrQR14=
Received: from DS7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:8:54::30) by
 LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:45:33 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::9) by DS7PR06CA0052.outlook.office365.com
 (2603:10b6:8:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:33 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:31 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 12/48] drm/amd/pm: retire aca smu backend support for smu
Date: Mon, 22 Jun 2026 16:44:14 +0800
Message-ID: <aae7ee61331bcf403d21fa8d6fac7215e8b7a7c5.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e61057-710d-4a1d-e1ac-08ded03a9f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sn94NSCbDLRjrqY4YFEcigKZ+AWM3RJ/RvjI1AKM468JWTrFuZoRhF8rsqPJV3dCYdZi/RgTxLSEDDOTKSIIoA/hwYtievIdJEFcGhxjEbR0XzkAMYKPH80eUWNKYQ73BvfQSzpVzQzFPzFEdP6eff+3yLFANl7HPlzhvZN7kD4yYD++QAtFF4778m5sNbGcWlvvHLHZRwKAHyyFAdEmMCQg61YdFqQG+EYJT5dhXzHWTpbN7OXs78FtT0B4DVPu9QRDwPGxRgqe4X1Nox3UIAjIW5RgGVlBfWaBwgxSAijKitFZBjlUmVnee2KRGRtHXkhU8vIOWWKMQVYGukO7TWDX+peUS7WDp7EXJCMBWwGTBU36D7g8wnooURcyTIdRPcNRN2ciepP7cwxOxXeFD/FNNAHhUCxSLJg8Tifyui0y9eDgAJiUfXpzQ41XJY3g7hiH4wYW1+QlOBYHkc4gpMZF3/xiEWiITAvnFG11eywd3T5gH8ELvKmzF61aQiZ9b3eIR6GGl5lZJPYp7BVxF1ErCWCLp3aYmke9Vgl0qEs0CVRxxqavmNlnsloToNHkGXbsxmgLbn2zXlcYcksNSaptDKA42dnZ+f+XKIK3Ri/doEKqgBhSurcBA8O33tF7M1BQ1CYCOZeJnU+qTYFp68qzMa0lg/Yte06l0GDtt8qz4//Cuv9GYwJFSNB5MrytV0bEBUKQeDti2/0AIcSc/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SKKJWIbcA3/rnrU8beZ6Ng00gMNv7WoTyt4Yg8RoF4l8R8cxahE/li2zRShcofWuE3dZAGYvcXpCEVfs9FUfNqnVSsCP4bRICZuzNxKs8Wup4DRBqp3fX5R6+ktpQhG8uSbMyWi+vtK1q5tMwoCTe6BtF7wqbNCZCHXcASIuZ++W9StC5Q4bAYRN83hVL8c4lWGJy0XYG0eIVPGokDxhWGTT5o15PJv8LIcmJlReN4IDeCkAQE/VtFdzaBd/MtcWs4DUxDYn6hpnQ+KV9H1xzgZ+qZcYraQYVJBWNh9ELlpkovyQLo8bveb5u4Ph5qbDbmUp5Mk5ytpadYfNA3K1zMFnIs0Lf0crzufadmn5C/Jxaw+JO1vTZc4Jwn+wnendYhdn/ASyJHfT14wLZjdG2cLLjs3ZV+PR2LUUNnwoLfdc1C8Cx9XnX8Y3pWU3N3xt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:33.0118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e61057-710d-4a1d-e1ac-08ded03a9f2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
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

