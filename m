Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B7AC624D7
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9E810EF00;
	Tue,  1 Sep 2026 20:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TnIL3uga";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221AC10EEF6
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUQcvmtERuguCcwEWfVe4AMIB2Cb1k0p50Nsyk8A35S2wy9jayfDk0DJ0LAL22zRSQ6FSq6LknJ7h4pM+bTH36Y6ouWKEbjseJl9OxKGV35SV5xtkDt/6pEjY1BitJr8LZTeMw32fDWPYJkYYabqO8BWPHG3nWdjkcEyDPBB4yw2BXRQwS8VWunBA4fip615n0bPEP7pOPj/gNCU5iFOzWt709vUE3Zle44t68lZkSdWl5lnqxZOO7PHTAgd9sZFkPYr0bZxSY86n3rfhowjn965b7/wsFO5y3TTb3e4znNICAxvITYauzUaU/Br6AzyQv4dlNtaeZgxoPYnmY+dWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsL0bcAlSiDYwRmrQlvSc4TfY0pkE9q9fQ5iF+OVt3E=;
 b=l/gLMsXiK+C14n3mcpwRrnFWWKEEV+1/FjiG3J0mJsG62Vq0Tu8pX0jmVwWoRuKuNQRt5EQkeolwSfqV6gHrAvdVKu86E7HULnSL0bqiND/nKsvtCaPZsMVQhAioR6DRJKUyqI0xMJ82yG/+SEleWVIns7JmZYBKLW0GtlB3KoLXKGPtDmtsOx/LX034WIt1lFjBLJfFhu4+GHKwTobHdY1r4d6yPavo8+V6NHTxpsk1b09Yp7ZhmLJfENZjHNiLuKFaVsCmRcri9cjkm606LNDDtN2vWniOdnKnB+1ry1EhFZ6vFs0MuPWtT9wscRJPi13j3caWwIyGTcOulfzZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsL0bcAlSiDYwRmrQlvSc4TfY0pkE9q9fQ5iF+OVt3E=;
 b=TnIL3ugazfPZY74rhToOKSkVDHesZd+p79bx1p0sOxQb0x0tdAXQZVDCALJ3RQab46Bim1pyHyrIFEsCB72/5kZtqENo0AxFJVX1m9m5HiKuRCT+7dmGs4WGy1f7ECqnri0pIXomLnS5TzPA8YepVbEPLLLLqWsKdo83W/Q+Hxc=
Received: from PH7PR02CA0006.namprd02.prod.outlook.com (2603:10b6:510:33d::17)
 by DS2PR12MB285917.namprd12.prod.outlook.com (2603:10b6:8:401::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:56 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::1c) by PH7PR02CA0006.outlook.office365.com
 (2603:10b6:510:33d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/31] drm/amdgpu/sdma6: add tlb invalidation buffer func
 callback
Date: Tue, 1 Sep 2026 16:10:17 -0400
Message-ID: <20260901201034.2960437-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DS2PR12MB285917:EE_
X-MS-Office365-Filtering-Correlation-Id: f79943c5-8046-4f81-e62e-08df0865219f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QYHDu11ECbX7EYP98U3Wp5R4g78ovOiSIxlF5gbYu/UEtuGjLhw8mi2d1pUR4371TrVaAE8DETcT/BnqruiOYfIkkaxOmGigWv9AIFss381now78sMoPMFedu9SZN3gRpZqN0ApxUKBUc9TCADhNiDduPgTstTxC7OBxMboT9Fy5vxmaOi4lqxDwYxdq9/2qeG/NNHw620TCziy9p3WdJpUCWWDxjavSX5et6fUNIktEw5CLkrY284qyEfTLZg/MWqnkVt8b8pyS3kR617buQi/v9xkfzVUEdHafzvX7ZDoTufFdakUWDjYt5SraXFdB6mmj7tECZZnR68uH7zSKGD4Y1B3NxSCMnger+vHmw3h+W5M3xNLE+pyTuAJgayd/hBASlKOhsmNwf21XmNKO4BM4xVDp8qvidnhbG4mWSAdYUkXq6PkSR0+DVmZvOVpvA7PMr6sZacOMDCKhyq3e4JYLPda1Tmt2HB3rO5Iq2duCWg5aDTY2JfWhwOmDzP49uwWu1b0qkUjIcimo8Ro4XYftoNh0obDUhYlnuPdrGDU7jDrJAUu5V3TNxF6wDVpS58LsGrMOXxPCYPuFRyOh/zoqsfnzTPJDz1sU+Z3zgKjbiH4YVhoebaP8oam8Dp86ooMbrGdogE0SjEs+TjrKHBuvmRAgS+5QjBSGMav4P1kvQhiGydIe10BHiBAMZlLk6Q32ZrYf3XVIRa3JvMjIHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N8tM7kpBm3CQ5wKU6jC0eZDWCP2BOzSCfk5ufr1kd0KTifP50mD2ZRpPvVWeSR64kuy1WEt8Gsy0ptkREBxv3Ig/CT3yWqykgqWDMmOa3vtJZwI0SOgauh38KJ+PYMU6GJzbfAcrDuvo40Diqu5WjFQSEG/Th9NR62yiScitRh3Xr/n2UpVF1zTzhRsriS5wxPs3Yfk/orStfUy8oLj4MznLMoxzZF7eXTmuRt1csiRVud1qIaqH8YFfcWGKJQREdy3NjacZIJp5UhPF58d9CJ1qy+0qSh2GCMQY8eZI6whk5Wj8pzwetzEnc+UxF8HmYbsaREsH6lJ/+Pbc73glcWJEwohTa9lRr4fX6lz98FJl/v1c6PZHpfLO9VRrbhaj/ral4IZvQVh+K4KTXo8zKHuYz2u/xacNxhriAefQ8RbVte2nPhFRuJQjozWUwNed
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:55.7894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79943c5-8046-4f81-e62e-08df0865219f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB285917
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
index 303fd7d1b7c88..7b84c996e2359 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1846,6 +1846,52 @@ static void sdma_v6_0_emit_fill_buffer(struct amdgpu_ib *ib,
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
@@ -1854,6 +1900,9 @@ static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
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

