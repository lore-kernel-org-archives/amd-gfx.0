Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F35CCDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1954410E553;
	Mon, 22 Jun 2026 08:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wfbeCCAm";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013011.outbound.protection.outlook.com
 [40.93.196.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FEE610E551
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MY3d/ckkBW1ZMd5Ec0i9M2Am3Em7MlC6g9NNKgi1FtbZPYwqBqv1yXvCJXWVCioVLodCAFNj8AfOeo4YBs0xroHoZnEcLbW2PRGSD44c7X8r0E17UQQKOdNWSqkFUasgQR2nTglh5h6iAxrbd4/z9P9clwebGA+fA7Yj3OTG78y/2YmgJiPX6K8wdt+SIV27F5d3ms/28UsdkxNSmhjFqcZ7pGjUoqpR5khKaKmhbqRmvL+kFvO6PjuuMWqyvI3woDkglAji4oarZDQx0yoym5YowoNUA46RLwsPBUQrEpuujMerOMXrPA5yO5s2YzKLlvp4kadl+ncRzOs8dqOpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BWElpiMy147FRVdUfJVAL7KsjECB+zX4RQClIIS8Nk=;
 b=cPKtrTB44mE4mZ6pM5SCH4cPAm0J7jk0H2mPLLpIjsDMCmbSMX5oRBI+0TeUm4MAHVyF+kTTOEEmisG2ZI1vb93azqYaCtgy5RYCIO2Q0hHqpsOCE6DuNFUklg5NzL+/aV+4cz0vLLUN1ZzTvqfpu+Gth/Kt3RZ/P+fuGSKRo/PwYt+0GKQP/KXJk5W8Ucr8TkR0HZTu9B2BatRmEHIHKmRRXrGK59MYKZk8GjmclOGuGT90AKR8naHlI/1Ei8q8210R8kDcU/t8o20kdkqz3/ZYl4zgbJ6leOHpXOiO+raCviIoJFRpw1nA7/L9jx+peWq1p3kwO6bRC9Z8+4rueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BWElpiMy147FRVdUfJVAL7KsjECB+zX4RQClIIS8Nk=;
 b=wfbeCCAmRz3p87tLfWzBXz/XlR/wzfgHE2TcVFFJGR0fP6VOikdQV5kq8K7zFSabr8sgq7ZA/v+sQb1HmRSlkW6a1Rv+D+XHriF8D4WtdPbAXllDA5YtDRaPs9u1e2q+KuH5Zr/z3zifzUk2RpXoIAAC49qc3dLTcn+sYevMiVg=
Received: from DS7PR06CA0049.namprd06.prod.outlook.com (2603:10b6:8:54::35) by
 PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:45:22 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::a8) by DS7PR06CA0049.outlook.office365.com
 (2603:10b6:8:54::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:21 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:19 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 06/48] drm/amdgpu: retire ACA support for vcn v4.0.3
Date: Mon, 22 Jun 2026 16:44:08 +0800
Message-ID: <a9fa5afee390fc1052ef5f6c56f1a901ca4bcb39.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b64ecc5-6c4e-45a1-e137-08ded03a9865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CKa30HVRh14bZHPR7+hsoNFDFcmu0gD/faFYo6fQ8AyLd2Sx0yyNujex7piqN+duqlS9wid4R2MA0kR6LzGnrSy1OqGh9ri3BzqL1Ud4+2D3g+4F+VYZ4KzMr7CLBvjUtfYkWRnvJL4nvH8q16HLPANwqn6tY9+LgqKx9MHdHrqQkaCj1DlTYXeF0Y6JZDrP2J+D0ocy54zTUuezVFWtU45SJ73Mr4lt2T9Zz3uBKwulQAdpPmeNeO7kCGEvK9hKgcPbDat36kokB6Hppm/zSVHDr8jt+hFEJHoBir4ROdwK2FD0lZgYSs1KhYFpNDzhxkF/EeL6+crdXGxiSXDLTBdNbBW4hvuMe9Cp65OM2LGCTEUwz/IgpmQSnhOAGVm0zXdxlJfmG8k6JzPxPOyy3UO0JVl5FmKFmqSNYWgJN2uD3eUSqfl52M86jb1aN7o4ujI7ew1DR/Ta0wzWllItm7LkZ63XIC5K7JvhMDtszwXBvuT8XjVpDyG9sj1OpmOhxkvIyklUFqNoGpvE68rJxibQJxW+4QbX6iisab2CAk3QsmlkDab+pL4qOKIVywr0KXjd0PT+MDuG9ALGu6c2UNP/NSOlHJl/Z+btqr1MYcMkPagzCXkmM35+pGpf6wDpUMsj8jw96v+4SH7tv1728dsXhVCB7G1vH5tbYwU+ps90+JLU80phvU/pLbdvnR4GQr1qdG+dNZCAJiV0YbHq8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zMBXz7JvdiNZA5Hpy6Qtv4hyLWhuHzb6q8cX7eIp4Wg6PjVSHJHxc09bNw9A93bKZFTfR7ER+MDVWD0ffYiOOUIlWxkBpurtg3yd/NcQ4hxrkj/jBU/Fk3PIRt4eQQ1uY9cnVzVXPbgJLAO+5OB8UQ75wgmZqLRWpaZyjgbM6RYtzO6dtNaRc7cXYeaDN4oXO7DFsK91s2Xw1Dq2OHuAVLPFRijpXTBpi4DQr/ivBjTNt+WsaJ10Q1I5cuWtewpKj45F3eWhRHZl2+dwrWWrliRCpZaBRh9QLVrsTCpX/73+2Y5ZdGxLpJs/DzToE0cDdfs3P64kNy1ilPg/a96siNhkf/Z1E1n3g8ZSfo6MOyT0DaPwXdFepOzBozcaxLiZpa5ymePyFpNJHYgDaGz43afR4NS/BtVGf8O9umx4fNrO4oRV2OtelDANPWuSQjaQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:21.5741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b64ecc5-6c4e-45a1-e137-08ded03a9865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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

Retire ACA support for vcn v4.0.3

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 94 -------------------------
 1 file changed, 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3c3f3d1a040d..728946911f00 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -2163,103 +2163,9 @@ static const struct amdgpu_ras_block_hw_ops vcn_v4_0_3_ras_hw_ops = {
 	.query_poison_status = vcn_v4_0_3_query_poison_status,
 };
 
-static int vcn_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
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
-static int vcn_v4_0_3_err_codes[] = {
-	14, 15, /* VCN */
-};
-
-static bool vcn_v4_0_3_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
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
-				       vcn_v4_0_3_err_codes,
-				       ARRAY_SIZE(vcn_v4_0_3_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops vcn_v4_0_3_aca_bank_ops = {
-	.aca_bank_parser = vcn_v4_0_3_aca_bank_parser,
-	.aca_bank_is_valid = vcn_v4_0_3_aca_bank_is_valid,
-};
-
-static const struct aca_info vcn_v4_0_3_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &vcn_v4_0_3_aca_bank_ops,
-};
-
-static int vcn_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
-		adev->vcn.inst->ras_poison_irq.funcs) {
-		r = amdgpu_irq_get(adev, &adev->vcn.inst->ras_poison_irq, 0);
-		if (r)
-			goto late_fini;
-	}
-
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
-				&vcn_v4_0_3_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
-}
-
 static struct amdgpu_vcn_ras vcn_v4_0_3_ras = {
 	.ras_block = {
 		.hw_ops = &vcn_v4_0_3_ras_hw_ops,
-		.ras_late_init = vcn_v4_0_3_ras_late_init,
 	},
 };
 
-- 
2.34.1

