Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD00C44507
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A8910EAB9;
	Mon, 13 Jul 2026 18:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Ch1ypTi";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5115210EA95
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7VkhSoyuGJEo6kBD4HoHh9WCV7isGOlZpWbuzLpRkXSMnBI5VABcW+uhR+HfVBBHmwkP0Vpezfk1H/H9ypWVM6yxoZA1Q6GbLtmWooEYQYVivWG4GDPCzHLPmWlhunKSbE0sKW0Qo9h3AGlDO0ujo/GVodKTw5sbY9m9YR2PV20HJT6RZr1m+AgIVR4SWZwPGk1PZtNXkH/5sk6ZnTxTZl6hDFYefisPsBl+XxLBk+v1fRy7JEvRUj/Y70lTBVwJIrZm+y+GKXxns/Xx/Xv+rhluGfVGhUOTj2m+AIfLNR9biz31LcX/ZlGXGJQUc8e7gfi7JWl4no3CAKNH+sacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Bo9eIQK3CtMLfUMOV6HeEnn2og4KCTQIPG5OwDo43U=;
 b=KW+8qtHaf6DFbV9bG8ArBBFxQjYtVdPCGue8NAm8dpqGCVcudKHKcjNDj2qKN6nlBE0yWFO6scbxSu5k3MkXCoz/alXmKjmCXreU92bPFPKQi8dlDG47muBPhwZMHmBd17lwlF9rqoVtq9QNo8UU6AEfKs0QU8ejO0cKPvtpghEIOWjSSbq8EbB/cnVgPXO+j3j6149b7jOxDaECOm2ydLkbuA5TgeO7u6wiN38ZkBTSHrp/zLfxglA6G7E+oBGjyj/+U3FdK0rEc961lsuwcTa+ZmtREQZ5IzoTxbFlOw2X39/ioZkKn1+rswq1TLrr63gf6y6us5rdS/Nv2aA5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Bo9eIQK3CtMLfUMOV6HeEnn2og4KCTQIPG5OwDo43U=;
 b=3Ch1ypTiQfmY5ZS/AxvatoJs9uqwJ7POs26ooSvurcsLPc7YSiIwrp6/YoOR56ZlAZ13/0hID8X9Nwr7LV+iomm1jTFl9EAgBNYmsloagF8TvB8boUYvhAhIY2bop1Pqe4/f5Bb7hZBcMLJFJ/+aL6jejK96QkmjVn7lHeiU7ww=
Received: from SA9PR13CA0045.namprd13.prod.outlook.com (2603:10b6:806:22::20)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:27:47 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::92) by SA9PR13CA0045.outlook.office365.com
 (2603:10b6:806:22::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 13
 Jul 2026 18:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:46 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/14] drm/amdgpu/sdma7: add tlb invalidation buffer func
 callback
Date: Mon, 13 Jul 2026 14:27:27 -0400
Message-ID: <20260713182732.630947-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e829690-c430-426f-0e9d-08dee10c7011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1f/Hi5r5o5KI3ABoK3F+aLMIOkMo/qJ+lbinu3q59G5DgJ0GMZK4VBVnfMCOE8dKsTzh/wvq7koXyMqS2/BfqeuSxGmRIY28EkqhOv2OmJS6Xa+vlMJIkTLOdzBjT+D74pslmxNvkUcHSZNMtcOJCatFwGdFieGfj0gXWubOJNfYnlDiae2gmZTfbpHgJ2zwVKznFJLjYrsV7MF6gRHfXvX0snQd+J3zp/woB86LyrxmGrMxJRTThNhGbkHXkG8lpL+a+IIpQpz9tsIWxtFgTDK/h/KCfMakZe5r+mLQeF/XKSZPM5Yv8FrC9rRt8ZeZF7gm1ZK4W9eU9AJ6ruTkHizEcDfxDkiU4vw0/g0hG0LIK5cfrjAhSXhh0STwdhu724kfoUsuC+SRS0Ep0NdX3JoLYn0nZhpehxFo54u/+HjCZdLXax2hzlDL8ajGHVtgPAiAYu+bSfJA/cgbvoFxzI6VPiuUt+2VcmxNz0dFXtpNxMZ6suOAAOoZFbMlF4DJmFMZnuLrLtDBN7nqfNCPCQGxyAsN4UySZUig6rGguWMusc0u5MUYvviZCT5gYoIO64BYf3EZ1uRWoZavptqXaZTeacMGjwDxbixqaBFur+dXi9zyft8mixWYbx2Qh5hvOpWGZLX4z9kHHmNOrFAmQRO6MEZRGd0E64zgLa6L3Ew5vr6xTbXeMIs2OsALdPls3zLerIRWOglgiMxcrifbjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j7YILuCYNT900CD0XpynZ+MrZ0JABVahHgwo8il600Jb7b1LMlZ6/GGUbKURlbGORXNnyRfXQDXLxAqXseCVKo3RG98GS5z+uhlb/FZy96XEYE6iEP4SGaqoHsfLxC9IvohoyQQhLQMllVv5QV0MlGUVBATixpr7f1YyzLLnKshVF+0Qb5J1S+j+xTDT9FgokAVFwC4muZI1gpMhnz/r4eMt2fVzZkzoh0QLHeoPQXk7kV9FxVIW4PSBWZEtjhNqaTWUULSYkg5epOGkD2Ir/Yn/IzLVp70AwbkBLsSxHeUo4PZcvyIC1C0eU2LTOtWdFvDbtRwQ7HVelAr0nEh4/VyPPABisdGcEXgfHv8R/i/o9TmRozNLXB58lpOLWokAwm4r1DkpROeaLNjchaeCymNbAMahM3U4ZZLOBa89uVfgR8A94wQ263Wy1bL2lxpb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:46.8565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e829690-c430-426f-0e9d-08dee10c7011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 1f460e1b1e6d6..748514786e8cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1811,6 +1811,52 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v7_0_emit_tlb_inv - Invalidate TLB using the sDMA engine
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
+static void sdma_v7_0_emit_tlb_inv(struct amdgpu_device *adev,
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
 static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
 	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 8,
@@ -1818,6 +1864,8 @@ static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
 	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v7_0_emit_fill_buffer,
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v7_0_emit_tlb_inv,
 };
 
 static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

