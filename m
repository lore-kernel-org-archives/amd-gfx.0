Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CA2C88E58
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F45E10EED9;
	Fri, 11 Sep 2026 17:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ugmDK8Sm";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B656D10F64E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xl198BbrbxBPG56XFJV/vFEP9avdOOJTouQ3qQ4ajk3ekV4bWR8fKfLmoMcYWo7TNMDhJnh4Yira+y+C1Q8xTAtZdKtdcRvNlPZZUPD8tc7XM5adQL4OeACbxwxHIzhn7oZ+0tzKDv0tvQLMvuHHqNdftZ5cxYQQ9IiPMLTwhvAqocWI/3mmuGCFWEXDMRaen7vv9ZZ5WIUa2sk5DOnjhoeiF8yJYZ9ywqj+x42VWEAVp6UnV1mQfqHlus1o+YLdmwHlWfqdxvslnxqUQ8HZu2cxqwCAeSXalfkQphky94v3PCs99IWrRjNgDh/3KqGl0h4YzwRi2T8ANLq0EAlusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaAtMksVfFoj+yau8fCCBaLUkGCQRm5qKmVga4Bl/k0=;
 b=ukT8vDwaRK0K+O/jiszqUnf1l2w7jTzbm1D2CveULSDT+CQO605fpk25GjTzPwjKwuF4pyIRgQvu9BaqLcWE8LNjgysCllV+Gb0nHeV1TfN70Cws01YwJJaEFnZdOMWdlgXHGXj0Pk0MKJ6JfVs/Srmd89tVMQdGrqdhKZQ93n7v4BFb2r0tkQS6wLYWiJlL3ROeJXKUAgGOPTzAxoycsY8tEpzWqlsE5QcfuehfLZ4XMnsvJpIIxK2b3X3sl1dZrzGC/AIosPJCgayEd8eoVRwx1wqQuXnPZ7AFyaR1pgCzgyuIEM1y1QOYCQiM2sDYFUZ7TfeO5cynZHdUjKEGKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaAtMksVfFoj+yau8fCCBaLUkGCQRm5qKmVga4Bl/k0=;
 b=ugmDK8SmvRLt0FywLrJLAI1zz6Nr30jL7KvxmbjDAc9RxljU6fIg5Y1rZeXB/W9p7Pq07M6IPR77Hkalj6CwttM41BaYhEurslnWilwUiIjLNj7B1glvh/YIxrDavAyEABuMsMO+MWMgdOS5iK5zv/TnC7xKpFPU4nKQAYcYl5E=
Received: from BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::17)
 by DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:09 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::4c) by BLAP220CA0012.outlook.office365.com
 (2603:10b6:208:32c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Fri,
 11 Sep 2026 17:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/23] drm/amdgpu/sdma6: add tlb invalidation buffer func
 callback
Date: Fri, 11 Sep 2026 13:55:30 -0400
Message-ID: <20260911175544.1314467-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|DS4PR12MB999075:EE_
X-MS-Office365-Filtering-Correlation-Id: 997aedac-204c-4c2f-053b-08df102df5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: l2D2ZIK2bv80hcaiDHFBFEauMpp8SZioq+wF57uaz+xBcP/tVP/f1u7qGIYR6Hlw7ukTY2ubSXRA/Icz8b7TSYlnAy/2p/FS+Edj8wCCBapvJdqn12s5dw26u0bE9ClsYLeRAQbnFomcr1eJdTl5JO90SrsWSjmLeSJLSZYlpIZ2ZZEDqRbURvKWxclzma2a1YM83HoqU2yIMaxn+5A/iPSosCl8JIuMUebrrqD/rSfQhGrBIZR4KiiiRkH3oX4sT0ENj/gqOb8f44kZQgCNly8rxCqPY7Cfrgschmd0vc276vu29sH8xklPUjv3pvH/TjO5vqSrn0K7R8i2NA5thiMiMZaVB9153G3yNqeQ3IhseDzUdwJys55sTFrNKfxq2dIUw+Wclh1St9vczh2G9fjA9stXNkoCGl1dddmXCw1CcFF7kMZkYZlpnnhgfACYCLRyGKRyyGvwVfwpusC1onxKPeWaFelvrqPiWuZrdXDTNcEHz775wFAAavWIkD/NU21hiNHHkXSFz2cn3xlUztVPoJkWWe/Nrgt2orfAq+Dtosb3p39va1hKThqxHLc4cnhJHSQ3/jaeokrMq7QIdNe+oJAt38PB+xGkc3Fpbmk9bKhNzFGXQnI66moVXT92pzJTUQhOh/Zadt+LpV5VChClGz6s2axTYg/oJlxhBxySHzCqTxJYQ1G6KUBZQCcRlwI0trY7n0brRhRrMV9z3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6YErXyogPbpMHrNYnJlC9WkjNCWyXHLgi7UmzXWZYM+XY9c10z/ATWGlyoouUme1TEGqc7LAWmvR5DiNilZA3H4ASQU8Tfaw3ITqyjl0ZRWY4+qZ8jOVupCowI+I+CPw4XTRpi3cP+UI5Kep4a1Szzei8v0rUplB2tLRyqxj3UEq6t/EuM7gBSoCiRucUDQ+bbIlhzPCSB0VKUzxAXBdycUaRQfKcWNj06yiAfdXCGOEAUyl07PJkjbgRT5zJYtCjgnbPfE8xcIrG6c6f9DJoBFTJHdRI5DNVTGsSjGxT05gIWgflBvdWRFo4KIjo00W72e27SSswxVePf9sbblgkXlhQbKI+/lamhSdl/p31wOCxazp6iitP27ogzWgf9jdmIe1cGSFO2JtdgYG4Ic/APiPF8DkMqx6cj/ZHzudix2JKe8oQ8ClZF6bllU+spdY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:09.4247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 997aedac-204c-4c2f-053b-08df102df5e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999075
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 0b64eb5b32e9f..10af8300ba1cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1879,6 +1879,52 @@ static void sdma_v6_0_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v6_0_emit_tlb_inv - Invalidate TLB using the sDMA engine
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
+static void sdma_v6_0_emit_tlb_inv(struct amdgpu_device *adev,
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
 static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
 	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
@@ -1887,6 +1933,9 @@ static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
 	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v6_0_emit_fill_buffer,
+
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v6_0_emit_tlb_inv,
 };
 
 static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

