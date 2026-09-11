Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C3AC88E58
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3965E10E4CA;
	Fri, 11 Sep 2026 17:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uKYoKjUT";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C6210F599
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqB1+RcLGPsCXoICBQZm3+GAgl6V9Aq9zIZ2ueDLqc0ZknbmSAiMVPAfept3SGXR104IX7t6gJ2L5c/ayWV9Hqea3509fE3vihhKmji0goV6156UtuBvOuo+7WkhMVZhM5RzzTuPY133g263N/Kfx6q4MeHvE2UOQ8PZ/8RdW6glZBhiD855Xuv1gcGZf5frwPAUppP97yQZEgv1/ZDAs3YrFWWUnv3avo9Rp45SCO2Y/0uFgFvTs18N09Zs2wqspERm7HTE0yZzrZ9G0nIpXVveL1TdswmclI1r3CTRvc67Bn582cwquihE6v/MIW+Tj4H2A3ICvACfMPtVZkB+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV0KLw0vfkpOEQL7WBme9t6DHPQRcQAYJ/200bop1WI=;
 b=CCzRlyNDSjO569sp3gRJhb2pjHiTqd6ukHHrzHIoX9YsIFeBCRvwvySPKjiKZWjRw34Y+c/9JdK1R+Teu0gSWav4NLwXECXIa21gMsnHOSh6luxTaBHwUZmyiUWY8nw4DXZaQyte137PV9tQhRkEqcF3czUCwXH+sNJTlrjV+qAekXNG3Wh2VaYJYz7heTgPi4p5tu5fzpHlBKDlc4ijC7TgeR/o70VxgsU5EsjSoTeiY+8oJskyv/6O4mRSdRS2Q0gIFcaYyfxANbHuK46pmZ5P14Vr7JqUYH6UutRIEfK1i1wT2jvIlBTWQDgv+T2zCsJbZu3dDGRuH9sMB8DP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV0KLw0vfkpOEQL7WBme9t6DHPQRcQAYJ/200bop1WI=;
 b=uKYoKjUTomo2PFkaIPtuLr9k5kqj1sz6uEi32MzbdB/4Hu/ajUNdKqSdBNf5kWSejd1gT30hHFjXL79UVgPk9EIJzcSQ8jRgfi/SeqswOOd48rJlZex2Doz0IfxVL6EBCmkFkcl5ZynqHDBTdJdLyEXci6yU+w+NnTVUJwYRoxg=
Received: from BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::27)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:09 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::11) by BLAP220CA0022.outlook.office365.com
 (2603:10b6:208:32c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Fri, 11
 Sep 2026 17:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:55:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:55:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/23] drm/amdgpu/sdma5.2: add tlb invalidation buffer func
 callback
Date: Fri, 11 Sep 2026 13:55:29 -0400
Message-ID: <20260911175544.1314467-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 068f96d1-5af4-4e67-a120-08df102df591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: TSo5/QfsGOd0zTb5P0ll6/cYaliXNAScZe8sEVubOQLkl4Bjr0p1P5vbl05ywWLjvIcp/MJvlrwli9fRzsN3s4xAON2J9qkKEHPb7eHFdTBJJLGstVcJLN6WClcEjjZ72EQL8xMxMAn7aumM+ZeA/5+TyJJ79/Ff1JPKwgF0S545pncDv+eGhVXRnIdEUFjX8mDHFn7fjmd14/cECwMnqvD43/kvcTIITC7FA+Q5lAxRuRUi4qLPlhXrM7F/odw6ti6z/vFrJSlFqMhmdqOylsfGBf8AmpMuXmU6aBPoNNx6j71CVPQrIcb4EAQ1Wc+Mi9b9s71EqY6yIDZXpiftWwmQZwCITxdHKZwNbVPDJ+mHSHcMyP9kvgdFo0DWYYAD1KJIcyJn1rnKPm+KGHUtlt/HRAkOaBbPIo6kSZOl0PWDYDjVk+1qxxOiVYhYd7Q9feI42oi3dz7gz1QjeWwU7+SOKz63gI2txGYsMgoQZTFr0CbqjJdg1k/0TDJ8I6i6bkGU/wFa0blnyDetTnBpTUijPJRP0epth6Nnf+WKw75JUg39sptYEEc3plImd6zosvLGnmSliqy23cYCkL9wd+iufK2Kz8WGiIJnVCqVwb+8oZmYuWB+LXbW4wbD4IRZ5u/VsnQ77JTrr/KMz/3gaPZ/fv2ySA4L9DmZxkOHxPz+G5x75tOM0ogKNP1eeYeEjmuqPm4GrvTsWBRUhD35vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dT8N3HeJJ20kJSTkGt3AkEfpcNKkpPQ2qScD9S7wKbmRz1/akj25UHIZRCrAez3vHlaOQFbst5KfT1Qy+0W/Y7uKfUzo8qvFPh9FJ9ZTc6AsxgdbB5okZPmESzg1/7eKQJbaKiWr8GZJ/PwzbvJvFlorYbV9PWgeAeJ4FY1YQ6DfwqBhgWEZk5Rl3jSIz7G5Zmflt6i5q4fvIeJuFiGG0oUNsei3DCsXLk6KvPSsEvTXGIR5/JyyzG4x8TsvHnVYp1VQQcnMyJUOmAx6+2an1OnRaV91ye2ESPcSIDtzkM49k+ZXlGmG3zhWwImtUch2FqmFP4nAXyeE0nD8ZAJi69GagzN2gTMVwTDw1slePP/Ghq/gixKHfV8MfTxg2FaIU2AksYxcldPGcmzoiDlZJmFuJYQvBAmCfuio/m6sAOhAcTrBso1AKtjmHJnf50Xi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:08.9008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 068f96d1-5af4-4e67-a120-08df102df591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

Will be used for TLB invalidation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 35cdf6c149f86..a10086de35957 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -2038,6 +2038,52 @@ static void sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v5_2_emit_tlb_inv - Invalidate TLB using the sDMA engine
+ *
+ * @adev: amdgpu device structure
+ * @ib: indirect buffer to fill
+ * @vmid: vmid to target
+ * @vmhub: vmhub to target
+ * @eng: invalidation engine to use
+ * @flush_type: type of flush (lightweight, heavyweight)
+ * @xcc_inst: XCC to target
+ *
+ * Invalidate TLB using the DMA engine.
+ */
+static void sdma_v5_2_emit_tlb_inv(struct amdgpu_device *adev,
+				   struct amdgpu_ib *ib,
+				   unsigned int vmid,
+				   u32 vmhub,
+				   u32 eng,
+				   u32 flush_type,
+				   u32 xcc_inst)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	u32 mmhub_eng, gfxhub_eng;
+
+	if (AMDGPU_IS_GFXHUB(vmhub)) {
+		mmhub_eng = 0x1f;
+		gfxhub_eng = eng;
+	} else {
+		mmhub_eng = eng;
+		gfxhub_eng = 0x1f;
+	}
+
+	/* Trigger invalidation. */
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(gfxhub_eng) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(mmhub_eng));
+	ib->ptr[ib->length_dw++] = inv_req;
+	ib->ptr[ib->length_dw++] = 0xFFFFFFFF;
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+		 SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
+}
+
 static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
 	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
@@ -2046,6 +2092,9 @@ static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
 	.fill_max_bytes = 1 << 30, /* HW supports 1 << 30, but PAL uses 1 << 22 */
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_2_emit_fill_buffer,
+
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v5_2_emit_tlb_inv,
 };
 
 static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

