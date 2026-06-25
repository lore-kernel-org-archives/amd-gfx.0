Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26273CDE006
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F26E10E6DE;
	Thu, 25 Jun 2026 08:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYeCW3ua";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A7710E1F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoKUE0N63cXzPq8QgyDKJczlA4GoXbx644UnBwpCpURnrs+pBCutVHtX21k/joJCaf947zujnt0yxNz4dSFUnSIzqdz9Oi6P0m4r9jqCRsAHurutXf+0TqvFextxlUONECkJn7znBYj2RTwxNIJ58SVaDnyuMnhssbeShv+MrHSnQsnsExY4TwWeCYb4BDngpMMC0EMx6ZtDD8oRFVSsU5xh5o6q+IbYAUTSDj9DdipArEu2PHZVrGpyif8lr1xfh6fDD8NDMeZPY82I4wvbrCzFB90x0ShSX9wWwVeuJ7gtk9YOQSlY9SBMZTcMO0vztEs/Ief/Si2A7DCbBuA1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwVknxU6915i1uVqzEbZKEdFfTbXRjBc88iyB2w3+SQ=;
 b=eVImOexdIDVDKw8nKNgrJqFlmYrD6ckKH/qc6mGPx1EI8Ev6FKlzY0g4SMHunb0hRKAdwVU52FS/lSzGNRiCQ6hOShrrxFCx/J4Gh7BCpFMYOtxX6ChIMdBNJFhPIeSNDuSGqK3WWQgWckfnbMtNl/VdriHu791ISN8slR16EAwU4ktdFlhiksMzXG83wN4r5zfYbYAIJMG1a+4w1qpx5Bfq1FqCUMhNo1P7XE+55k4QJGmri1J2eEKj2Bd+7/TDTldfJozUz/wThwhS2eARky7wNKbuMEBnAMok0XpK+tS1yjsVYymq26ibE61LVV6pVirjH98JpTbpxpnRUaTYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwVknxU6915i1uVqzEbZKEdFfTbXRjBc88iyB2w3+SQ=;
 b=RYeCW3uaOe+lLA5NPNO39LPec9jcDRveOjk2TMkVxuNkTQkoGlyqpOTGEQpvGEYa19t/LkjhAvJ5ToAI8Z5Zt0hjR2/5OfwMtED/ku3J+rVzmW/pf4s67bblFjBtePVxxFZ+5b+SVZKZX+I3Fs9tZ06g5b2YMgvo9+PJP4KZcV0=
Received: from PH7PR17CA0034.namprd17.prod.outlook.com (2603:10b6:510:323::12)
 by BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 08:20:17 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::70) by PH7PR17CA0034.outlook.office365.com
 (2603:10b6:510:323::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:16 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:14 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 04/44] drm/amdgpu: retire ACA support for vcn v5.0.1
Date: Thu, 25 Jun 2026 16:18:57 +0800
Message-ID: <f1c1ba9dba03e81b2a5be3b0a80db61b1233ff57.1782373701.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|BN5PR12MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 108e91a9-9819-408a-35c1-08ded2929687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EI1BoDHbGPqBVFWxwhEstOIzWHcGaX2Vk46s65QrW+iRQ+0HS2JcGsTySYQQWOM+U25A88p2PfzIrNg6WBDf+YIfCiOsj/Mk1deWiGcO1dHbejraneNsnxPKKpC3QX3TajRqIr/SPEA4dg2pYe/JEa7lETuXYoFUckPyYdWWgYUGbf+I4xayxKacpUZBC2pXZEsQE+GHLZM5dlvSiaXpxifyuG8f/WkwatOq0CGbuXByodorzRf1IhfT2oZ9v3Aag3egy/0Xw2zdYgFaCU0eWtJG8x4MBR2CzSRy9sdRihdn9LWNIURWTeiGpOlpVvGj1E3/Z8MmYtOzb5FJzYHFUY6+/hbbjLKTtV1BnkdPiBkxImUltRsP5lC8Ex68y4nwnhQZc1fXh7cHX8lXuUeoEb7HYXiB8qKS2VIO1WGN6Qj6lFEDEu1B/RC8g0R2GKE/bPd0ZIuv3+QbrCBvTlaNw295Ri/Vri4rbw5UVCDOf8JzHZL9PVF0RYBTp2RzEGnJBrhYGdKSbEsjQMD7flqaoZqjpSWXCqLsFoL4hZf3Mr8iemVM4Zwd4WTAtSgk8tIhpG5FHVWk4B9FSgjKLHp/OOUgrpPGXjbknQtf8lxm5UKLkt/kB++kHAcQdz5SwzUW8VdFptD0IX8Fj1nFftJjTBwwsOvpBV18wj99V403KNb0aHVXeCoRSI+QU840dboYX7aYPVuv661i5xgc2aHgqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Mx8ed3fgaUqClNQCmRe3r0YiQrPSUIgqkNam8gk2tP3M1gJEtdforjT34d6Ycq7Ug09fmCJSbI6pWCNqNrtT2c0kSo9dqKf7gaHomU32fzDIGFb+weD3TZ3WrcYH69Ak4Y8ELaTXqaiKxAnvJ8bCn5znM62lnb66ViHC30FxezFhBp8reuxfryF60G8Y4H/LoTt8hee9rjmXqJ3qPffZ7taaXqyNv/2KynyRk+6AyGQlo5gNnOve/6j+9u0oiVDHDhmJDGzEBwZ5P1Nkxh9LqO4/6x0knPQnWPqeZ177rx2A6WGkT9RA+eJS+QXE+A4a5Z8Do+xu/USvDMsxXYK6/wWRammyEL62+9ioihLaGT0QUCwnBhh9AY/lM7vBeqDHCv/0o8gKwwtuTNmAa0ylm+OdmJ0vYsAuyTspSbU5I9xtEb1b056WZu2IDSdsnkN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:16.4820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108e91a9-9819-408a-35c1-08ded2929687
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463
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

Retire ACA support for vcn v5.0.1

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 70 -------------------------
 1 file changed, 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 9c23055cf5ce..1a07c3bf4425 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1727,71 +1727,6 @@ static const struct amdgpu_ras_block_hw_ops vcn_v5_0_1_ras_hw_ops = {
 	.query_poison_status = vcn_v5_0_1_query_poison_status,
 };
 
-static int vcn_v5_0_1_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
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
-static int vcn_v5_0_1_err_codes[] = {
-	14, 15, 47, /* VCN [D|V|S] */
-};
-
-static bool vcn_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
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
-				       vcn_v5_0_1_err_codes,
-				       ARRAY_SIZE(vcn_v5_0_1_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops vcn_v5_0_1_aca_bank_ops = {
-	.aca_bank_parser = vcn_v5_0_1_aca_bank_parser,
-	.aca_bank_is_valid = vcn_v5_0_1_aca_bank_is_valid,
-};
-
-static const struct aca_info vcn_v5_0_1_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &vcn_v5_0_1_aca_bank_ops,
-};
-
 static int vcn_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
@@ -1800,11 +1735,6 @@ static int vcn_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 	if (r)
 		return r;
 
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
-				&vcn_v5_0_1_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
 	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
 		adev->vcn.inst->ras_poison_irq.funcs) {
 		r = amdgpu_irq_get(adev, &adev->vcn.inst->ras_poison_irq, 0);
-- 
2.34.1

