Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F96CCF2DA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4FAB10E877;
	Mon, 19 Oct 2026 08:34:30 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010012.outbound.protection.outlook.com
 [52.101.193.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D60E10E877
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAKJSI1WA0bViqY9bKFbdv9533gd3TzxvFYdDjeiF6fKwduXA8W4gwlNhl4h6fJub/bai3qj/OokpKnlvCE0P+oIqFT7SXy6gsIM085rKjkM0R5baViIEJxA0wnQV7W/i4eWx522ZyMhv69LhHrO1sx98H3XH0KL1ezjQ74fYQWouQRLIPHRNRakmjz3Ia2cEWhPWbJg2Ss2KMFPBxr1ykBy8qTXu4e068j1hvfVqodOVyg3eWK2xu/azq6SVtI+xlLzNYy4PyevwRJH39WKIsNaut5CuO60VpziiT7ZF9Bm+DsQb9L3xYmYLzaRLDl17DEtC6YdSGlTB1+RsnslRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anUywITAkT2ML/rab9W/8ilGC7+ubwVe9FGd3DMPUXE=;
 b=aUFJaQaLQWxFbgDBLYSFJjhdGNvxJdJXlfk5GpwJY4AUsHOnA+gS+eAiKo+lURqNgGPpBRM4IPdG4NjGmxb6CTEE5NlaDyXn9ouNYnoxA01kn3sULU+yX5Lz68rKBA+5b3bwJQhZxdzpivglzPN+8cpxh5pFj5AOYLovW31WoBhRbtLdRMm6fKMTkx3jIReEcAEIVIJS3i6MEqCFBZDqps6l56gScvCLq5K738zGNQiHcBaIZWiU9m4GDR5LyjUW6+dP/LvkZQmHR31mz+V5k5nsGCfjSjFpzhB+nrqCXMNrAXeubNkWVnwSl0H0/SE4fJyokbLWXiahigFC8pOgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anUywITAkT2ML/rab9W/8ilGC7+ubwVe9FGd3DMPUXE=;
 b=yd4g9u8UF3zRYeYpJnXfER3kNHWkN6ruOBr3y+1nPuO0RKUyM1ArB5fkmx2oOG9TAW7PF8Sc1b7Fu+zGZ56fdpQijO2XcV90VHTx8U4mf+OVt5blVdYB0Of+nIhXizfjvmEPt5qeI1osWMfr98fexEOWW1Y7TnBL6LUU3uyBLTc=
Received: from PH8PR20CA0015.namprd20.prod.outlook.com (2603:10b6:510:23c::8)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:20 +0000
Received: from PH1PEPF00062F26.namprd02.prod.outlook.com
 (2603:10b6:510:23c:cafe::79) by PH8PR20CA0015.outlook.office365.com
 (2603:10b6:510:23c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 08:34:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F26.mail.protection.outlook.com (10.167.243.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:11 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:34:09 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 09/13] drm/amdgpu/userq: reset the gfx engine when a gfx user
 queue reset fails
Date: Mon, 19 Oct 2026 16:33:09 +0800
Message-ID: <20261019083402.2033724-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F26:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b92c73e-fa5b-4be3-7b44-08df2dbbc533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WJuyF6I2/5qWt3pO0/SoP+SGtOcbFEwAuqa6+h0uTO1qlkQqcmbVDumoMdUwdz+yAEXHlub/UKBNvPNfF4+6MP4p0PeWJ9j2veBTRDfa+qKmsw483mxC8RU/iusS+JwlB0Og4quH1CWwujF6cdO/VhFVPNRGgaUlDd4LmDN2V1qkCgvAWYrX2lxRbXuAtoPQvFwJ8NcZV0ow6Sk98o8Mm3OKeQBnQIf3w/WFr3qZHChYTLMdjlJXKa+8ypqVW/2wi5Q/n8pYDdhRenEzqMQ4hc1OzXyWbFGc/OJfvsdSnbYahF71J5VEWV4ZaspruuwtweOMS2qMmyhQn/C8oPnyNfSH/I9xnhO5GymiMN/pBTqCw8V1cFZfn4vmGMgAfd+pzUQIboPM3ptfaskoa1ke8zYRjToEW6JxxEmP8L/9xyXluVFywD22dBFVQ9N+LyDL7VsBs/qXFrYIglbOGynAiJcJ+BmrbmqMUNPpHUTpL2DJXJOXA1w8AKFlWDzT48s9GKhDt6kUiaIrkS3ero9p9amG4k13xQQ8AllNmkT7XYgzWOQA3JdcRN3/uXrqzKTKtB0MnErKYwdVP0XTZ7eJqo0TgHibJh/oi4eANVkGiFU4374iOgyDQqeTrBip68SQJZ/4/DoYpn89IchbEsqVFTGvJZ4vzw13dthbfsLY6SS2K5scB4weSXeY7vGANMZlqNSt8Kj6nEnVkD1j2SHlkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EeZxEhM3w8ISEsnCfeHUnSYpbsB/29IvNayV4MLxuegyfr7pQicoIqInZgalrtI8W+o0t2sZrKUBy1WwjHKrb0Z0La7tTdIhNHrTIty8xasBKXuuunSSPiMFW+g8xiZs33qPHVxbqiSOVnUPt0rpkmZFgR3syLRvLVX9/qweVbMgjiWJvAifByA/1f9D7J669fuP/b0PD5LIZzxzrR80PmgD5BLVBFfg1RUT5p87Nfljg7u9rCDZRgSZS0owCQAcu6hiEtAUs+DP/IxtMF8lIGbrJleeUP604FNGikAWHX5BaC+Feiu4oWOP+lCOwnAhvLRQyzdoI4OKF056z6RUHjg8pmfrrtfci+1udLrF+P6NDvthmnfztPeI7UGOqD8JZxTi8oJmxEZGAUGFpMn67qYa6gCeTfruDv8RxqA/4ig3vbLX756eyCBAslUgNlAX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:19.9391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b92c73e-fa5b-4be3-7b44-08df2dbbc533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F26.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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

When neither the queue nor the pipe reset recovered a gfx user queue,
fall back to a gfx engine reset before a full reset, as for the kernel
gfx queues.

The hung queue can't be unmapped before the reset, so mark it hung
first. That keeps amdgpu_userq_pre_engine_reset() from recording it to
map it again, and the queue from being mapped again otherwise. Mark it
for amdgpu_userq_post_engine_reset() to remove it from MES once the
reset cleared its HQD.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 31 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index adc9bdaaa981..1117743b09dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -237,11 +237,28 @@ int mes_userq_reset_hw(struct amdgpu_usermode_queue *queue,
 	return 0;
 }
 
+/*
+ * Neither the queue nor the pipe reset recovered a gfx user queue: reset the
+ * gfx engine. The hung queue can't be unmapped before, so drop it, and remove
+ * it from MES once the reset cleared its HQD.
+ */
+static int mes_userq_reset_gfx_engine(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+
+	trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+	queue->state = AMDGPU_USERQ_STATE_HUNG;
+	queue->engine_reset.unmap = true;
+
+	return amdgpu_gfx_reset_gfx_engine(adev, NULL, NULL);
+}
+
 int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_reset_queue_input queue_input;
+	int r;
 
 	/* already reset by an earlier job's hang-detect; just signal and bail */
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
@@ -250,8 +267,12 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	/* A GFX pipe reset also affects the kernel rings on that pipe. */
 	if (queue->queue_type == AMDGPU_HW_IP_GFX &&
 	    adev->gfx.funcs->detect_hung_queue &&
-	    amdgpu_gfx_me_pipe_reset_supported(adev))
-		return amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+	    amdgpu_gfx_me_pipe_reset_supported(adev)) {
+		r = amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+		if (r && adev->gfx.funcs->reset_engine)
+			r = mes_userq_reset_gfx_engine(queue);
+		return r;
+	}
 
 	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
@@ -279,7 +300,11 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 		}
 	}
 
-	return mes_userq_reset_hw(queue, &queue_input);
+	r = mes_userq_reset_hw(queue, &queue_input);
+	if (r && queue->queue_type == AMDGPU_HW_IP_GFX &&
+	    adev->gfx.funcs->reset_engine)
+		r = mes_userq_reset_gfx_engine(queue);
+	return r;
 }
 
 int mes_userq_reset_queue(struct amdgpu_device *adev,
-- 
2.50.1

