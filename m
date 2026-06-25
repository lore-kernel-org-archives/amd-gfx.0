Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7748ACDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118AE10E981;
	Thu, 25 Jun 2026 08:20:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dvJyVT9x";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A366610E1F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fABfzo63y1+TCAJiH5OiMsGrB7REyswjoc5Muw3qHq4ZWmptiPfTHgwGgf4DXJzYty5ybga8UgUg3OSrhHyfxqN+87ICcE4SyDTpJJ7zVUP7H1BHCqorcH7L1OSdIyWKJ1EshjpguMFldKfixgVk2LUI9Zgcf6mFWnmWDR3EorLLNjo0wM69OOoQbG11D4nXQO/F7R1tLJPKa9RCHZQoB61q20X+ORXKTHCXk4KymknOICzZlDOn/7d0geFLl7g1RQxe0mdavsiGh+iEnj3+WN9dWMnVEFzx4B34DITxXY6wGSAl4RBQxVu4sbVilHxETmQK3sjeWUrtcNABiYwqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7ROur1WihqrCmrPKELI4LvxMaK8K3pShZ/PRp8abaE=;
 b=TapHtYT3BF8B6zo9TEcry7EO8sNmtux6Jp6fzsSrTCj4tnv2VC0RECCfvvE1/qw1Yg/Dri1yNORUz/3QALy/EKJNc1foz1zydn8w+/MQmyOMRRYGnJs581tUw+UKJDk1NCGRyaL+U5YSPGMC0fxVPAEZ49CRghLiyP2eKfxI7NG3owvfg/ZMHAA9BxSi2XB72yqZXyS2s7hv7LbbWrRWoYwjxjAZS6H7IbZlNEHWt+aTiypwCn7mINC7U2zVOZ8/Nui5WTWUbQg4MK9V1cFLg1XzMzzLjKRMvS1dPtAD21Ed4HL8iP1SwjudrE3NEC7tL5P1r5cT43H4Iae8xyHN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7ROur1WihqrCmrPKELI4LvxMaK8K3pShZ/PRp8abaE=;
 b=dvJyVT9xfRaBjlwwswd7+yCgK33cOQAuVgzeO6se6CCHQyodJ+AvTm6IG9Xz7jKXQ+npb2uKMZksj6mxjzuqwu/SCn0WL9tJM49hj3L6Is6qCJV64LInJTOTE09RT45pU3OjEofZwRcqk7ArC0OUZLp4d1HYK+KCgpuEgmDbwdA=
Received: from PH7PR17CA0042.namprd17.prod.outlook.com (2603:10b6:510:323::21)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 08:20:15 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::11) by PH7PR17CA0042.outlook.office365.com
 (2603:10b6:510:323::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:14 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:12 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 03/44] drm/amdgpu: retire ACA support for jpeg v4.0.3
Date: Thu, 25 Jun 2026 16:18:56 +0800
Message-ID: <b8f2e62cd25e3232ccc9795629af193bf258705d.1782373701.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: e59b05e2-bbf3-4241-a5f5-08ded2929558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZmNvBo69Tw9xgLX8UlkfDJKs/D9sVq/rwnLsIsyeFYRcBnjB6l9TeBZlw3lYyO+kmfYbyK17W+g6Sbih4MWp3KoKEVwABRlS3vFxGElYdjNOXcJ0i+LD+j/H57i59sLn5TE9EuehDL9J9jJ61lWhFv2g1BxcNwuru8GkurbCNmdwNyLWki/fTC8/w/8W+Ucd+9d2bGMlm5SNWQb2ke61djBogjnmbnfre/ibt6iE5IpS3F8H+kDbEnW6dhBxpB6I8KQrMZhBZhIUQ+wUBz4JAAqMQMt549TM7Jou5daTfOkIfEm9qat2QR+62oTgvYq3FOlr56Dd7ZT+EYErSifUgCDe9OHPhCYq/xAhOfkJSxRZoCmJj5jjYVAa/QuLVZQ35vgvNY2W5kaJiGK3HJTwTTKG4h0hsxsveDhvpOaLsL1C54V7IcuDXzsRxDuZ8lNmWnIereVtO2LRnNhhCoZNkStzDoWJdjqsGEz9Pue7BanHJzy0S7KXjZ6hNBamSaNBij1Y7F7j/YPDVismp6uZjD9mn3lkxNdaOiJXunsLSGeuOwN3YyqNbbsjMJCPimKKl35Hu4IsKRXGJM1653i3pJCw13tDtrpCEMgZG1G3NAhueloiaaC7ug3ihGpKueIXxYRSnSVHywl/8rYBqQDPlFMUPmPtZZrF8Jfz7mWwpOkT+3lXF8AftLkJXidAdmopRJehwvdIghx9zb5m/ijNyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6XyWWIpxlLEZPVfN5s0pinfwQqK0NTeBH3y1lbBROi9SzDml8dIw/ieKn3N6MWsSXxlBEVHUsf2R/KCcITbze2OlZiG5gNY2yGlX85rN2imKqLif+mBJg7ezFqL1l+75xJQVJBFuzMJ1q4TJB8VS/j0fCyOOa+8zgZ8Vt9e2zfnjj7RAQU0NOewZdBiwV1Sjk3CoQzg8W1JvpzAakmKURULMKWbNZD3+ltMdySmzWLTzXr+3Nxga0OshN3hrxh1aqUPES65gqV0sradP6O5WJtJ1QCF3Xf0DxNlPTlGxMNyxDhWvG+4ZtNBPxExKFxeDvm6vXiEEI/PodOVYN50gFe+4mKZjxEZ4cfluuDAFZhMYl7CmNs3dGxJUmQ9oGkxPJpzX9eI9FlMkjhq8f25+HXCAfucup9pH9o9AmVynqKOklQKcmC/m6TCY7Y6p2B56
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:14.5449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59b05e2-bbf3-4241-a5f5-08ded2929558
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
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

Retire ACA support for jpeg v4.0.3

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 71 ------------------------
 1 file changed, 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index b0bdb449538e..4c57871b810a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1442,72 +1442,6 @@ static const struct amdgpu_ras_block_hw_ops jpeg_v4_0_3_ras_hw_ops = {
 	.query_poison_status = jpeg_v4_0_3_query_ras_poison_status,
 };
 
-static int jpeg_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				      enum aca_smu_type type, void *data)
-{
-	struct aca_bank_info info;
-	u64 misc0;
-	int ret;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	misc0 = bank->regs[ACA_REG_IDX_MISC0];
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
-						     1ULL);
-		break;
-	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
-						     ACA_REG__MISC0__ERRCNT(misc0));
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-/* reference to smu driver if header file */
-static int jpeg_v4_0_3_err_codes[] = {
-	16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-7][S|D] */
-	24, 25, 26, 27, 28, 29, 30, 31
-};
-
-static bool jpeg_v4_0_3_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					 enum aca_smu_type type, void *data)
-{
-	u32 instlo;
-
-	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
-	instlo &= GENMASK(31, 1);
-
-	if (instlo != mmSMNAID_AID0_MCA_SMU)
-		return false;
-
-	if (aca_bank_check_error_codes(handle->adev, bank,
-				       jpeg_v4_0_3_err_codes,
-				       ARRAY_SIZE(jpeg_v4_0_3_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops jpeg_v4_0_3_aca_bank_ops = {
-	.aca_bank_parser = jpeg_v4_0_3_aca_bank_parser,
-	.aca_bank_is_valid = jpeg_v4_0_3_aca_bank_is_valid,
-};
-
-static const struct aca_info jpeg_v4_0_3_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &jpeg_v4_0_3_aca_bank_ops,
-};
-
 static int jpeg_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
@@ -1523,11 +1457,6 @@ static int jpeg_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 			goto late_fini;
 	}
 
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
-				&jpeg_v4_0_3_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
 	return 0;
 
 late_fini:
-- 
2.34.1

