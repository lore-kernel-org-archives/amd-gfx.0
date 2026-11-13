Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7B606A327
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vdZ7yGEH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA74310EC4E;
	Fri, 13 Nov 2026 15:50:24 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E937610EC59
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkeS77IuZe9PlPPQN207qnv5skrOXr+0cOenYUuqXPZFo+5lTYh1ngvrwChEdTu7eo/HGDdKbGIsoCBvvdfeJCJTfRQYtZl9hXHN8YT83W5O+AVCPAI8m9gFbbT1mEh+5Iy/KP5mx83MUqyvMMpD8m8Y0n1/8Gx1sifSieWcogDGKZEYMGEYf7dpE94UGPBtgwVFqCim2eWagnx5pFrOp8GcHqJljFQYg+1D96Pfb4PQa9xJB+LK6fsCkyzvaVNti3aYrQhxEAZ4VDLM1ZVeffg8STF0jdfc5Y7u8Ez1qM8DWsv/l7MSyqgWUUPrC/Q5t3ve2Jsf5MeFL8ZoV7+Drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5RTmYP0u2iz9As8PEl6i7A9r+Hcrk2igmg+t/3R3gc=;
 b=uP4EmYaycSpVvObx7X8UaHj1UHc+GfGYKQ6pGVMqhIkk6BID5u9+FRcIbEkZNT7FQLQm0IHrSXyi9NbZtNNYls3GrnotR5CRwhsz5WMG40xMKYnt2gfuSYcK5BYSVspkFX/L/ZL9gT/r0YB1GHzYOfh+88WrTf5O92qBof8TqfXuv/loIIhQmVeIVm3hNf+vkHBGmBJUl7XwIiRqvo23TgU3UrJaHq/xjrVdvMhGwZOtgtfaa8p0AmVwbOw1ghJgqHSBYQVJUnI8erGDFF2PJGSYCsCdL0eyAu5v8eSuvFb9/vg92rM7qhWYQZmmMPqbWPMS8Dq2E/tMXQqtKqgwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5RTmYP0u2iz9As8PEl6i7A9r+Hcrk2igmg+t/3R3gc=;
 b=vdZ7yGEHQmuN4VxXBP4cmoPoACHvbGOGtW9eG1bhBDo+tu8j4P/knWTDorIy8zGkbWJcbeTmkAfm49NyoP+/wd6K7CbMNMM2HuPyAViL1PEvwPT4hj+Q93w7Gfx6D9kZtxRt2HVV8/SpmH8CUvIktjjC+uj1paLfiq4mC1poPbk=
Received: from CY5PR19CA0018.namprd19.prod.outlook.com (2603:10b6:930:15::31)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 15:50:12 +0000
Received: from CY5PEPF00000E77.namprd02.prod.outlook.com
 (2603:10b6:930:15:cafe::b) by CY5PR19CA0018.outlook.office365.com
 (2603:10b6:930:15::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 15:50:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY5PEPF00000E77.mail.protection.outlook.com (10.167.247.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 15:50:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 09:50:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 09:50:07 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 13 Nov 2026 09:50:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] Revert "drm/amdgpu: re-enable SPM updates in the the IB
 path"
Date: Fri, 13 Nov 2026 10:49:52 -0500
Message-ID: <20261113154954.1865439-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E77:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b7719a-f4c7-44e1-2e7e-08df419dcd81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|261021123027099003|11063799006|261009223027099003|261021121427099003|261102123227099003|261022075727099003|56012099006|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: GzQ16uirdhW5niNaLy44BSmBfKUSKqQcjgNQxPcIvWfeMFwVMrqQSdiFAIIFhrB4afDtjwGIPUAIysdHL+v5BPe9gpvebXLizd1pEwvtzrUCQ8o6dp3Foby0MxFeELJ5lXL3Hr0qTI7cDrG2Pk+IUsyRMjRzAbrB6Z+lebMcW9xLZ8KC4EDPgsHchduIq981kOwLY7DY4KBCy6hUEt/lpsQq7Muty2S6anq8D8BSS1nda6fETzl8mpabXw4XzxmxV0dLopC8UUwBz6hU6H2Q28FpYyT2iUOL8uGLHlTmybJyWDiTkso/qjG2/7FalSPbIwczWJ0TPN1dgLvEoQjuB9p0LGB/ovK5n2qwSWaoXOC9KUtAFt45o6LSdclP388RsfOtGYjgMcT1u8hl3+9OGoABjYWENij1AeUBcgFAJdSkFXzvU/Xnl0EzrdAQozc126KkzQknxq5hlC4I4jxBF66XYsoLj+bZWYyitz46DWEcM4qu1eQ9ZE3336kYqhnvlm3V2pps72ss6yWT5WWgvJzWxi4i/pAv7FLPPJLRx0gvlyJyuudvS9YQR59DxwrKI74I0l+Da5nhtYXC2KhLf78w4QpmdKdk5D3y2J9k6lhqV18PNVkg/vYH/+Vqv40Fcxgj9BfO49JOTy3l0RnUCQ2pOyPplP60e933OFEAF2Yoa+LxAZbkjjz5k7t26WiyghYaRqRtNiPdhXcv3ieTxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(261021123027099003)(11063799006)(261009223027099003)(261021121427099003)(261102123227099003)(261022075727099003)(56012099006)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gkIXnaDrWEPZ0/tvJUas/tLImjU8L+LQ6yO58xem1ZH2DSVnOUHaf463ubtljDmSqGx06rngYgXb2Gm9GaWUWd5buULHUqWWtaE+WZsAOA5sNItAjA4gLZ0uEvYo+2apNGrcNZPBstIItFIg17MMLGdkY8oVZIbYJa3UErMfs2lhp2MNpe3DQh8WEUKj1Yyz6Cwb4ftos/FXvSohS9zdI3f1pyb1djbLLYaR5IsgXdFIDWZlMFQ2OP6IB6/2P3Hoj0XNadmbxLo1FOwgFk5o2OryMYKbPT6vt2hpo0sBEeBfkwBGrReFk7KG85xICSsexds+aPnBYejA0/nz4tbplBDgFKY99sFD3dA2gEtV/6My8jz31RezCOrxHzS+OSNKw+EeXC04aqJHGT5R+qmH/mIxpRlMpkouS5UjDJvXMD6RSsbDPNvPb+OeXI6gs+4V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:50:12.2482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b7719a-f4c7-44e1-2e7e-08df419dcd81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit d44428868e5b9f97c6216eee1b4f82aec7a6e8d2.

This causes flakiness in gfx11 CI tests.  Revert.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 6210edf1937aa..f98a7c6797b3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -121,9 +121,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool emit_spm_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
-		(ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
-		 ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
@@ -212,10 +209,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
-	if (emit_spm_needed)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
-						     adev->vm_manager.spm_vmid);
-
 	if (emit_gds_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 					    job->gds_size, job->gws_base,
-- 
2.56.0

