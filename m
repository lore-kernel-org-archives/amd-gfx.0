Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62015CD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 17:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F8610F2DD;
	Thu, 28 May 2026 17:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y3fbLeZ9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D200410F2DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 17:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPJ51QTXcwcc8XNYSgFYSZZb9ihd7+qspF/+8EPd4X3THDKEZpmhUdBoicNuQmP54+tALWYSIsDOUfeyyk3ZpxF/jkn13tJlR/xwzJq14ju8YHO/VLB2rFMCT3uS55oZ9GEmib+8RL4y23eFOvRgpVmB2TYeaWl0kibUYX75QF/ljAwsWqZGgQ+mdi+OGpquK1gDSOZFWaEfY0amBU6p7Nn4wi2RqQpKwvjSeuQsg3yKyNq6H56TyXx5K32hx9jGZkFzLMhL+5o3kEGKCN90PDARj2SG9r/n8TsdH6G1G2Ro4ObLJaY7n4dEZq/+9DG3Ey7yugE5HA0ToDuTuCJJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V1N59fX3rYjLLEGaTXz0D2K+uwjplaIhOnHEbCmg/8=;
 b=zSsfyzZZ8S0Oqoanoic+i44eY4qDUUjoE9r4lnruII9A80twiyw1E4eEoyZtydKWP8vvluijTaK63qtX8gLdymSDx+VnraYbwBb0Ps/H00hVAFpBFF004Y1ZTl/sm2T/n+iaZZqhi/pyAOkU18Jq4Z+KMoXIwZ8Aq46FdymRZx7rvMLkTAf2EvFd+w4FSYKWmQ3UFP4PPAH6yoyWsLBMEPd8nDSnU9cqs3kZObJ8l8wq6zI+e336jVuvffKQIF9lWCJ9MJZdNY8hZOQf1WYlajVsj2wqGnZHolwltHDYrnxpd0Eulhz5CXyW5ZiBeL4n6qTkOLhd4obi3rFZWVOFNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V1N59fX3rYjLLEGaTXz0D2K+uwjplaIhOnHEbCmg/8=;
 b=Y3fbLeZ9HpZo1EaaYgZCUMIHN8yyplVB0h8VVOFKxZDHvKVP5RispgqkkcBpN8JVW9rSsocluqdeC4lQ2Rqh31aeXQCkkoXjKaCwSg5Do1KdTyXixkg3l0VylJzfJA7ezWK8jOKD/mqI0OuvAjmKJT0FypxDsd3AF8ytBk2DzRU=
Received: from BY5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:1d0::14)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 17:19:42 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::44) by BY5PR04CA0004.outlook.office365.com
 (2603:10b6:a03:1d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 17:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 17:19:41 +0000
Received: from nv3x-01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 12:19:40 -0500
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH v1] drm/amdkfd: Fix buffer overflow in SDMA queue
 checkpoint/restore on GFX11
Date: Thu, 28 May 2026 13:19:17 -0400
Message-ID: <20260528171917.45575-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 040bea84-4a88-42ec-7fe4-08debcdd4e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: q9pI9ir9jSG8X4nd8DeqetwOAkNefb6o/sPS2jsAUJfgNr/AEBoWJBrwWV+mu/0dVS0M5O3HratmvG63M1wTVM97S6lEn4p0eH7VG+y4g3OmvORuMgTZ5/YxHlpch3Ltgkp6Af/l7vVUGsLl+yfJJCkGID/+1mN2CegoEHax4thfGqX6hfMidjTR5r2d5P5Thkbzgl1Rc58Ek89njpl5tYLLf8EOPHwaj+ZpchriReS9eBN4gwD8+XwYSzkuXAdy8wJzjNvbeeo7NdN89WNKBdJf2yFDRBmv1E5uxKPXEnjD7uzF3dHshURiXn1NumQfvExjdVsEALnAeQ32MUDxtWaX7QDj5p36bi5kZO/ZMf7Mbfi433nLrfG+V5w7J1blr/co5ugZQ6bCqSadZ5Elr6Z3S2N+o2Ar63iUFpczigtWmGuu7xHmw24D/4wnfz3GB9XAIBIxqd/wZ5mXjjfKR6VuJUx7gcU5qwkP4936yS/Zc9mCM6YTpWhH+s4rM/qAiPaFWT59lXqu012wXv3NxIwrVYY5wFXRktUjdFniKHVAkDQ3nFuVpZYnKp8rFuNcYsItZp0zHf5vm83rzje9yVFZFpgIsXHYOHY0ScTQTQ3w7J3ZYahr+kMCpSkeSSku3Pbdl8dDrId3TQyvJTeyLnKafTrTsVESzCEFxXV6FTuGTgt3xh64yZ0JLazh9KPhBB94xjQsgJR/YnBNBP76CGiZZ4VVVAWPWF51ZDQy6BI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nr+bn5SJSsMIsXasPFsgsby6QlM5P0iytbsJ8L6vJA3G7hXLbYduvw2gK9FvKWWSaxvtGZ8Q2vJsW53L3SC54lLNlG2KxmrSR9wefCRsR+ZOxcj9yjFzo3Y6yh9w9Ls8Xi4JbKy/ULfZzyqcPQQ/Q+7vOkEcggGhipNVBKusMcgVQsIAq1lTCwnPMWvDWQ9nnqrBWTu/gkhtS/0Pxrsg9XK92IyBE2qwZ7xyF6Ft3Gkt4GGatrMgjQlRCR/uCEOKQ+bvKV2NgFynLGFcEqQEf2lxcOTpDj9rtE8enwMj9WxG14uQNGlCcGEFeFi/+SnFCh/70v7p0iJKWGLt9fTZ0EWa8VajRfBp37FaUuoBXZT6F3iQ3VJ97vS1aSZPQyN26MMfqOa54287PiSjK19/mcF+QPTXk3h+yUq25EyZakmOHGhfHxiZTzGP5/NeTOU7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 17:19:41.4882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040bea84-4a88-42ec-7fe4-08debcdd4e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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

The v11 MQD manager incorrectly assigned the CP-compute variants of
checkpoint_mqd/restore_mqd for KFD_MQD_TYPE_SDMA queues. These functions
use sizeof(struct v11_compute_mqd) (2048 bytes) instead of sizeof(struct
v11_sdma_mqd) (512 bytes), causing a 1536-byte overflow.

During CRIU checkpoint of an SDMA queue on Navi3x:
- checkpoint_mqd() reads 2048 bytes from a 512-byte SDMA MQD buffer,
  leaking 1536 bytes of adjacent GTT memory to userspace

During CRIU restore:
- restore_mqd() writes 2048 bytes into a 512-byte SDMA MQD buffer,
  corrupting 1536 bytes of adjacent GTT memory (often the ring buffer
  or neighboring MQDs)

This is a copy-paste regression unique to v11. All other ASIC backends
(cik, vi, v9, v10, v12) correctly use the SDMA-specific variants.

Add checkpoint_mqd_sdma() and restore_mqd_sdma() functions that properly
handle the smaller v11_sdma_mqd structure, matching the pattern used in
other MQD managers.

Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
Assisted-by: Claude:Sonnet 4-5
Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 4d8cf6008a77..ce0f5e8e5c29 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -355,6 +355,42 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	qp->is_active = 0;
 }
 
+static void checkpoint_mqd_sdma(struct mqd_manager *mm,
+				void *mqd,
+				void *mqd_dst,
+				void *ctl_stack_dst)
+{
+	struct v11_sdma_mqd *m;
+
+	m = get_sdma_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v11_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			     struct queue_properties *qp,
+			     const void *mqd_src,
+			     const void *ctl_stack_src,
+			     const u32 ctl_stack_size)
+{
+	uint64_t addr;
+	struct v11_sdma_mqd *m;
+
+	m = (struct v11_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	m->sdmax_rlcx_doorbell_offset =
+		qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	qp->is_active = 0;
+}
 
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
@@ -539,8 +575,8 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
 		mqd->is_occupied = kfd_is_occupied_sdma;
-		mqd->checkpoint_mqd = checkpoint_mqd;
-		mqd->restore_mqd = restore_mqd;
+		mqd->checkpoint_mqd = checkpoint_mqd_sdma;
+		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct v11_sdma_mqd);
 		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
-- 
2.43.0

