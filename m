Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB37CD37AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA8D10E73E;
	Mon, 11 May 2026 13:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PSadWoQO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D304110E77A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f62GbPaQlW7oCIVhacQqFdpYsjHBoQQBwJjbG0rnHZFJGyn94+V1CmW3PmY+qMLg8RBeboZjd6ut0F/T4sqQqhKoxbDUd1a87V2bxhPQhcZU6RIrUakp3l/bhq96hcUKuLV0rjKk7uulGSCBu1CTtmP+I8sCzayJb5+J2B4QmP6qOUR7LYrkKgofPmVLcTI5inz46UeaR/tCB3sBaQ+b543BTgJ90vDIFSYzG0BiS7DAtQCza08Gxh6Nie4E4uSBNqJBnA1rjft/kMN3DF3oynjqyB3LNJvCD2nr4gL7bSHF5xTn3QxJnsbFABEl3cTf07lglQMF6ZXLFOjmVc6mhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Hq6T4MFVl1jOdE4TXdpsx70TxgUU4RcOPNUtmr6SZY=;
 b=bgTcPOJ+evl9wMm7/WnYsD7GTVPQGXggc607pHvG/Y1UmpHQnO42ZT5+BRJZU5rYgkkoER39lIa+ftOHYGKIgTFsiiAUOnGKhreCRQh0pd3F8ntkDi7h0jqLeW//XWyfGax3ELUtEpFL+TaoUpQDZWjRjnQry5pqLHTfFaUhSduc9bzlWbymCiby+r4uTw3egutEVS2SnCYUHN2r8fpb/xiZ+xCWp9KHO+uUdzSHX2SjdLSH1QNnGoUPZfcjZVkGF6JZdTGj6odPZVAIbjEAnJhZ50RF2NMQM05l1JLw12vgq1o4wp7ouWSp/LNrmNTmPM2e4HD6RH/yBpL8wBH1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Hq6T4MFVl1jOdE4TXdpsx70TxgUU4RcOPNUtmr6SZY=;
 b=PSadWoQO4pamAiHBQKeLzv6b3X2gFNLvKJ/++NHf8z7FX++j7jaY78230sy/uvjtsEEgGe51KlYjf+2tzHDkJCtCrj7/1lIRJ+W9SmvsF2dFRhvzFA+7dlrVdtWNG+fZhrjIjbh5vP7lkonQo6xIFpEzZyrmHCXsaAFZLXT+VZg=
Received: from MN2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:208:1a0::26)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Mon, 11 May
 2026 13:54:49 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::24) by MN2PR07CA0016.outlook.office365.com
 (2603:10b6:208:1a0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 13:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 13:54:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 08:54:46 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add userq queue state transition tracepoints
Date: Mon, 11 May 2026 21:54:33 +0800
Message-ID: <20260511135435.3818345-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511135435.3818345-1-Prike.Liang@amd.com>
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b6fee4-7d90-4d3f-d66a-08deaf64ddb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: U33cb/9tGSKyllVwjSVZq87UT7+AEjXVNuiTMrMALiPcC3chbAV7AGyyetOvOMsWBSbZQt4+OsBFNfuzhShunYSyJbfHtl96ketL60+az131ZaIDjBhI0DxFLhwnM6+n+Obc0ezdhwrvFHPFyPyVPmrV+xa4p3puPuq8Muk21dwY1VBqrlC2IFGakOPCcd8yM4KxApLvyiLiQmeL4rYffJlHZ2SMYEhDE9qOoBRz55nPvg4TNAGLy1L3kRMA0DXfh40DGFi+fEsm9oWolLu8CpEdRpFadB/nbH+cWUPU0fodynm0ndUFnaxMuun3oflHvFB58JuVQNZDKzSLmt/0i9T0KFcjMJSSkglxLxwEeTP20tUPDb9jangZu76DNOwED2GMjV6xrhiwCKCs1swpia/iEnW0cRpbsixkbUIjVLfOCr5i81iDsS/SYuzZ8sQNOXuW7Y0wZ40RmCHSOqP/Bfxgyj1QudmZCchuTk27rybpNaisHzVDAhI/52TfXanRYWvItp3HPj874HG0SZG4XiS41n7I+qQa7HgVEsODPhVi311biKNmw1stOjR1VcW16NEd5i5J0fD2uyRskGpz0anbuj3qd68f6PI8nzS67Q8Q3Ei+YatYRJnlmASQaT/N5B7A1kbjDm6TDJPALprIhH/O0OnBulMRpG7HF/y28vyqj5GJW72EmB/89wWBTaENoqRcAX5LZjEw4NLolPIkudd5A4FiO8p5MIKc+JVX0CI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VEbYAGrQwmXSNTfuYk4mC460/GV5I/ChvOoJU4lxDkfG4cUECUQ2S6bxHVm4qAkKumQrWAvFJdTwpQSxvCXOeohoxGhWFMIJ4LmmbnCp2kk9d69DYAlRKozWkF33UzVxQTPE6Ehy6IGUBI9SOSgdYHYbtmYANeYrX1MWY97MrZ+cjN3OuTOLw1SkRLnkm35gBIk0pawM0MaxmsZjwQ+4CUqU4hYznbhW7lQwSB2QcxjgrqkB48Tmuvxr/QWvBxj61S53hYRIhngiZK0CuQQZEWfq7xxpUIZANU4XcyVzW9M2Cx7dMv5Bjxu+17DvA71BQ0n05kOekmOlECxX7QaI9u9re5CQJjU8eMuCXneNU/TigJ68XHGSE/1lTNy6pr5SaimqEfOwugP5yapdZkys0nYte1jhnAm++jR0hn41F9AFJgqOSvBp7qKAtw/csz1y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:54:48.4165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b6fee4-7d90-4d3f-d66a-08deaf64ddb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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

Add ftrace events around user queue preempt, restore, map and unmap
operations to profile runtime queue state transitions.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 25 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 12 ++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5a01f63d1f32..484fbb00068b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -636,6 +636,31 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
 	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
 	     TP_ARGS(queue, result));
 
+
+DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_preempt_start,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue),
+	     TP_ARGS(queue));
+DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_restore_start,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue),
+	     TP_ARGS(queue));
+DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_map_start,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue),
+	     TP_ARGS(queue));
+DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_unmap_start,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue),
+	     TP_ARGS(queue));
+DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_preempt_end,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
+	     TP_ARGS(queue, result));
+DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_restore_end,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
+	     TP_ARGS(queue, result));
+DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_map_end,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
+	     TP_ARGS(queue, result));
+DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_unmap_end,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
+	     TP_ARGS(queue, result));
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 50c46d31fbae..83aee0810513 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -340,13 +340,16 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 	int r;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		trace_amdgpu_userq_preempt_start(queue);
 		r = userq_funcs->preempt(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			trace_amdgpu_userq_preempt_end(queue, r);
 			return r;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
 		}
+		trace_amdgpu_userq_preempt_end(queue, r);
 	}
 	return 0;
 }
@@ -360,12 +363,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		trace_amdgpu_userq_restore_start(queue);
 		r = userq_funcs->restore(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
+		trace_amdgpu_userq_restore_end(queue, r);
 	}
 
 	return r;
@@ -381,14 +386,16 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
-
+		trace_amdgpu_userq_unmap_start(queue);
 		r = userq_funcs->unmap(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			trace_amdgpu_userq_unmap_end(queue, r);
 			return r;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
 		}
+		trace_amdgpu_userq_unmap_end(queue, 0);
 	}
 
 	return 0;
@@ -403,13 +410,16 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 	int r;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
+		trace_amdgpu_userq_map_start(queue);
 		r = userq_funcs->map(queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			trace_amdgpu_userq_map_end(queue, r);
 			return r;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
+		trace_amdgpu_userq_map_end(queue, 0);
 	}
 
 	return 0;
-- 
2.34.1

