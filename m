Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A5FFF8869
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 15:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8317610E7DC;
	Mon, 27 Apr 2026 15:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t08ObGEE";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2432610E7D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrsPfc9AVZ/gImiv8j3NolEOkp8VgxuZcsW9rcWxBH92nFEDMA5oF1i0Y8EpN9D+ccOi1hcpjHtaMPIo8Qn1N9/f+d0UF19PXvoTPEdEAP014bxJV2z6oMHS99FuUrZPs91UnNQP/JzFCOuKYPNnHwzhlRwTqUbTWj/C4rF6PFIEtVGOXjfttvbciu9jOGmsHVjCe8jVQAsGukBq/blWqVJSpPRHfI4XT7tiLyEbSx7yJ46TxKAogvWcHfysxinIgOIbFWCOwNkBiflZ2CK33mMTFDxGHVvzHpCurHhmvfyBaeNxs9weLRWF+0se9ewLlal4BwkLsflm+iYA4lvfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uZxnwCyMmI8O00Rfr85NrY+0l2qbIPwGY7D5GBjEw8=;
 b=YL9Nopv+SCwxArLXOVBNEIO24H42xYea9logyMRcYO/jnKoq9NN5fQU3owcyXNy+IrxctvKTbhknleVHP35Ihic1gwCufIEvIUU952V9kZGVK5GqUN3LPUR+ONlWcLouWz5QavsG7y9kRqbFFHWhbky7VKgKnipaYi5YLzPsRd3RMEruLTzpZ2w+c+Meg7Y8duFeMMzZwWdFsrI9BJHnEDKy4XdbBaQ4SFjLTfgmBvtwUscq3TsKB87F6mOkJoshz8/YqMIRFrW/m12lTL2sB1xAIgt7SZlVFOzqX1GQB5BAoDUOYt1/o0E4luj1g2addDcS6KXXjMcxEDgv5YL7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uZxnwCyMmI8O00Rfr85NrY+0l2qbIPwGY7D5GBjEw8=;
 b=t08ObGEE8+OijxaSstSQPWc9NRggo6ObFA+2Ba039Jel8c/Oe07Wdx70bZdFbe9bTKL4g3SZmthCuszjjl7F3WERct5MQpY6IyDSeSCMoAdTXr0UsuMncLGj80kt7a4nqLt32atWmxQISrFy/OnlrFqosXG0C2lxa2QLe8SqClo=
Received: from BL0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:91::29)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 15:59:43 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::f3) by BL0PR05CA0019.outlook.office365.com
 (2603:10b6:208:91::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:42 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:42 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 03/19] drm/amdgpu/vcn: set no_user_fence for VCN v3.0
 enc/dec rings
Date: Mon, 27 Apr 2026 11:58:41 -0400
Message-ID: <20260427155857.1370151-3-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc52efd-48d6-4964-e513-08dea475fee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vU/1O9FKmBcaKrhIiGNe2vQufD0X31LQZmHrBKK5FwCaATlvNzkBVwUQpq0jYDpv01sUVhZ/gpfsEC7iM962pqvuOkFuFcq8hK5xDt/gR//rXqJ9RnG0Cz9FtGQgLZfPOtz/FZ0IYj0n/ZPIG+sihzEi2KRFzieYEBLIRX83S6PuvNEOBflIcdDNW80Korceks7BBrxadMursdihAJnu+/SOx9ciAlAgjEaDHipqJh126+FGVMVBBJzKGAPuIdKg0pSa9eME2zh1pexr3plqE46dXFzmqX5AiLKMNLHgz0dXaf42bt5cKGQfgn7Psg3j1PKAsS5ptCHNgg1eMHCNWUt7WJiGCJ9G8YCUygVy77+JyGrMOr085Dg4FpDuNr/wvkbuGbtWmv93PH74a1EWAJlGsPh4N+3mSItccNOa96iccl4kFj3bR7adeHYMI9HsqG3sFcKfyTOPCnuAUBFR2jWAUMCzUSrjmvH2qaZ8NudCKq36Jp/9Nx1+y8DUBpICUP28Kt6rbS4D6o+PkGgJQ8Z9WHued5cCo35wnJUTkEL4QWM4RYadDu3o5iF16+uLnslFVcI++05tMpCrf8YhlDrmXAlEPRnX2oylJLjhEYzRrIFWykLBg0EqXpItnbeBucgHSK59EiXHjOzmelbWS+sOVcNg+ZaotQ5yfAmWsjxJ+LsLbnROP/AL5/VV+od3R7HOvijBHGeX1LLPPfE8LUCyEWRzMmCUIQbFoUjQ3U7lWL4LLdqZhzTOrLv27tTmLJQWQaDZS1zFno+M4BSfxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wEwVIMHOQtb23fjNWJCWcMSl8cNC4ynImd0wfXrN1oOFO6eLiatQedsU/Jns7xl1BAHAR+bb9Q2wByfa8tqhGh1Jsgp35gYop6Do4QM/USvS73O5XANwZPOa5ooJpOTiGzYcUAMlHA8G9cjTi287vdpegqhyHdJEmtpomXpLr9gXHNU/DziOLcu1TU9ZQl3WQRRspi7kVDKjn7kbliKFHJYTAUpYBHQmJ1i5UBIXXCOpy3YQvaCSfY+WITk98W2u4aRdVtObvK4mhhu/Qq596p38kdUHLUzrTtMWKCSEQSx3jRc2EbZloKfQOE6IBEirBXvmr8KuoavKqn8cWBoesS1l7PedtlCG8l7rRvoOf68QDUcVgvYFPi9NRBjd6KSTD7TU4Gu4kvYmNuFlWz7vPGqfP0h7ggqd7fOnWiGrx1apTSJjYKcYSsKG5NRm+QEK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:42.7574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc52efd-48d6-4964-e513-08dea475fee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: cf14826cdfb5 ("drm/amdgpu: add VCN3.0 support for Sienna_Cichlid")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6fb4fcdbba4f..4924da5af5e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1856,6 +1856,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0x3f,
 	.nop = VCN_DEC_SW_CMD_NO_OP,
+	.no_user_fence = true,
 	.secure_submission_supported = true,
 	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
@@ -2036,6 +2037,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.secure_submission_supported = true,
 	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
@@ -2138,6 +2140,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v3_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v3_0_enc_ring_get_wptr,
 	.set_wptr = vcn_v3_0_enc_ring_set_wptr,
-- 
2.43.0

