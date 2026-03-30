Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA208FF4923
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 01:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200B910E2E5;
	Mon, 30 Mar 2026 01:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WW2Sr35+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A8010E2E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 01:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCKug1fGen95JUktY3NI61vEoLaBzzITGLh8MwEJ/R/KJOroVXfB2LEt7WuoCB3uaHG51674ycg1UlsWrYd4zVQh2enhyooz6s3XW2ktzzL8UQTFX2Oex0VWrDofmL4oo/fREVSwPOy9dbijmIR/2WHEPuoYGfyM0kyH7w6ci8cbb6FCrkUigSNPNyLFfxOnBIy1mbiQFwyWK+UNnBD2cW7RJ14fPvlBFQQpNyjJ07wIwi+QRirrCV1xBsvG+1ySl0QX+t7bYunRGohIh83oWpUPnZUETKJxbdd+wKsIbP71T/pEZXJWL+cnVDhR1b6rXK04TWzinyNkfdPI7X/dvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+olg7gleTng/chVCb1E8JuiToUsmj+H9OOQpBmJRra8=;
 b=aA+jmq8qbTfW0BN/l5EaCCErynmvnO1rY667RnsZghLYtBt1RoSx80E75tV9i85Wq/dSFsHcqOKrNRBe7bdmtwkQiFBpyvs2Q0ZMSHPflYpVbSf7ZC7UasF0apFGJemfYkNyqpRLNdlC0h/14mRIB+F/pW2dFPy5RgjzV+FjIWS+y9miPGUklKeFV4gdAYony7k6MXOz3kDrbaUFTaDjCmIsaT/1zpA6zrwWIiaOrj8lOZAxpc7zawe9esXj1UNMWeFqvnoerJX3MYZWKfuVd6CmlZRv9XJzKc4bKhZVFq5j0B46tsD4MCG31GHHzEqw5V1ClT3EjV16NeZbTflrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+olg7gleTng/chVCb1E8JuiToUsmj+H9OOQpBmJRra8=;
 b=WW2Sr35+gtBhXotlKaUXSFaiDv1jpEdeah2cF2cTcxRDhfP0v37YB/AH0ckNDGL3ANXx5MvGZJEC5abxofRifcHZqyjEQxPIDWacJCdq91eRYNbSfQGvTJ4JhFUlofC/kDHPvmgeck/yLPxe5cjHz2WzrLM1vEqgw0hQzVogquo=
Received: from BN0PR04CA0150.namprd04.prod.outlook.com (2603:10b6:408:ed::35)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 01:34:00 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::12) by BN0PR04CA0150.outlook.office365.com
 (2603:10b6:408:ed::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 01:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 01:34:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 29 Mar
 2026 20:33:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 29 Mar
 2026 20:33:59 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 29 Mar 2026 20:33:47 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Michael Chen <michael.chen@amd.com>,
 Jesse
 Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse
 Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu/mes_v12_0: use mes schedule pipe for legacy
 queues on unified MES
Date: Mon, 30 Mar 2026 09:33:27 +0800
Message-ID: <20260330013346.1054624-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 63662729-f1e2-4fa5-d8ba-08de8dfc6b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Hjkq0vyTg5Vbh3LS2qjJiFJgahzZRFEOpWIsceEgKsFdyLTDDZmLWdDjxcIAusKbzCVLpNGVbsYsYOYL9gQezY10DLUDhz1tYPTqbN6u+gu4s88Tw+FBv/OjK6dSE8ncbn4Z+xiakvDSIfCMn3AIx4XMFmFpZMtjh3X3iTe+IZYxVuYShnyh/QdNRnNedqwL6Swo5D10OtS6Mr+r/90oAZnAhUeWFxyudueJOU8aN4HzYXXuyGog8Taw+gecTJ9mKRUP3s/3MnvnoXtAJbxai9QUlAlHY69MI5tAHDWUms00sBDh36OoRvKs0jvamsXheFM961Znen2EsSFGd7T9TvFq25HoqI+RYOsmn31uwbW3Z5mfe17NUwE16R7TkJGu8Dxb85fiE2D8baHiABr3FRQzFgzCW1nEOCCK34TlF/wpAIRgHUacSIXoq2CDG1aDQWUVHx0h1IY5OSb7SQ5ZDigaWI5m9YtgVfODMY60xHENVpYtzPLRHYUIA0CBkZf67n1aPd4Dk4Q/c4jT5mReUoPUld8HgC85LcmEK0VfaqkiO6kHKBSn08v+w65RhZJHdp2GCew/WKnoXKfCbuh1u7/P5ujhdE7yi4exE3cdkYBXLuDlFUSDn8O7wYVe0TtgxQvBGFt5Pradj28Qa68hC/Dohz611I5x/DylmhHY7V9MxGwAdzZWM0JcJOLV6eRhYTomaIwtAn/oQK0gMExVK9i8krnL/wYGEDvu9TNv0ACKQC4Usqw3Un1a8WhPANS0ahvl+QtQydAMb0J8g/UxHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7PpCMUW20cpvlrCJ7CaqPRTqZkU3WNdJ+bV/aCHmLcxxOv2gaGfTZa+Eqp0SlZpB27DADQkD5P+7859H5uXJSPKpEpCBz51o9jE5eNbT6pfh4LjU2yfOhfy7ceBYUZ5zALoTmyb1+ytRkixf4jkxlxVDJEw27gItX21p2avGzs5bEw7UVnMn9HxbGGDcQhSBWz5NFse7uqMufVhmGszZvHbvpcSv3rLH6dfObTazh6Yx46d9ZgTpmuVJTEa7oVn7Rttfi706XBQvRDx8jGc+VUv98VsaP3bsYXJcppsACNssIoOp/btbqcVWwVE8Sa77suTMCM3HMO+Kfgu+HghN14+VozxUhPd3X+9UrGkGBaG8iabIDy20xP6KeevxpGcHfSz4sIgwPmU602I4dKmmx+f+05quJmeliFJYZv3k2RuQmPv7GofxtW1y0mVxhcmQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 01:34:00.2250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63662729-f1e2-4fa5-d8ba-08de8dfc6b2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
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

when suspend_all_gangs is issued to pipe0 MES during system suspend or runtime PM, pipe0 can only suspend and resume queues it has tracked.
KCQs registered with a non-zero pipe slot may not be correctly handled, leaving them in an inconsistent state after resume.

v3: fix the schedule pipe issue

Suggested-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 023c7345ea54..67fb5161c0e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -528,10 +528,15 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
@@ -567,10 +572,15 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; unmap all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
-- 
2.49.0

