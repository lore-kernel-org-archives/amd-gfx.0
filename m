Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C94C982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4794710E503;
	Mon, 21 Sep 2026 07:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CmgJn7WD";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BF310E503
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5bsUwRrCSAgLtyXABTvDs6O8LwtgBczfun9bpeK6E1Sw3UkKUx7cJ17GsxUDSX+9a5MAbNafAJwyRi3A48tLtovjRfXBzpPuaLysbuZD+qAWhgQmZDm0X6uLjtI+vQZLE2bqN9CvufYZFevK96071wF2Y2qcYZzj1+xXLj8F23cT+SeNrRijnt+jh+HXi0UAihi10Q+gxBeOdXa25XNEGkg/h3GzykuA6GsZOtbXbMsFHQ3XpSmUlkOXJjUtr/FKOzBgW3OqMSWUZFN9NBY3kBV6NqkTgDfRXBfnEV08dCVoGQkpodtX07ktLpS2zXgSpxOHd8qfoXr278SDMFtmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUUGoGAOFNrcXnr4tvZLHA4u3MBMBpd22t0s2T1KsEY=;
 b=u4eobou2BxTwGcnkd4rp+qKtXwQEztD5q/qD2CG/fu4AvYoumOjS5mgGY9pfzfkh8+dVLdr7wTSo6Txj4W2ya8+hh3LXLCSQg9YV+jkqflHo3Pj6+1BGu80G9jOVoheB4fnUOugQzvDcfOWB2FPBdN5SEAHGyF/XEsyfLUqweU1KfLtuE733ZJIeKUxyTVtUAPoZmqE4sww9eeSgFF8ZQXEeea7eejG8UTDV93xpr/bbng2ZSRZLAWvEbIZeTw5nxpV1yaSm5tP6MLo/xFZWkhs7S4onzt2sg/w6IteUH2Y0KEPhNNratMRGXpGoSGvWJvEEqm2e9s1+vW05za/cBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUUGoGAOFNrcXnr4tvZLHA4u3MBMBpd22t0s2T1KsEY=;
 b=CmgJn7WDzN4vFdlyqmx8g9auqEXTT3i8fT51iO5MP7WK8PcYxnbfR0qw0aKqzHoEx0SmjdXGngHZWYlcCjoFplHYQ07CDyGy90Bjik6/a9CxhnDNhwyIFF95MKoyRHLt/Y0Z+4NzZ9VPUMtpea83pZm5NueS0zozTiQLDPHatA8=
Received: from MW4PR04CA0284.namprd04.prod.outlook.com (2603:10b6:303:89::19)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:53:58 +0000
Received: from BY1PEPF00026958.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::56) by MW4PR04CA0284.outlook.office365.com
 (2603:10b6:303:89::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026958.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:56 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 13/21] drm/amdgpu: factor out the MES user queue reset body
Date: Mon, 21 Sep 2026 15:51:20 +0800
Message-ID: <20260921075326.2409021-13-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026958:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: c32f90ae-d5e7-460d-ffcf-08df17b57dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zkP/4wMOLfgqaapoXtzVpNNXk9pRQpjWd12dpa6XuilF3RVaB1E8QwUzilsxbdI2ClLGam3omkGC72AGRaUFiTC8qirCdw8LtPVfovO0y1Ba+sL54f+LjbkAHYCwijQpbe8TnNkej4xG9BOCv52iw6TUVrT2GhYIBXt0KCy/98hIAJN6/6MrBFD5dih2Cwr5epmB0vy6nRlrsbLoHoo0AppPibtd5lUHUAiPgEusnUWxqFllyv8UU11rmWZgfHqqnIs9gST0UazdvZKT+e/LIHbW8gScAK+rkX26Va5hwfEwtZBYNAAgnHDTjrpNMSdWaa9qCbfyNJKVFP6wFFyj/ZF1eoJE++Vnl2T6K9WHDoXhnZRLbcbQRL7HB+7vsRqFEwew69pJbVUNE3S9scnN75C3zfpDYkSrN6HJeXzxi2MhWzCyNaggBR5OV6EjtOv8udpNUFIQjCj9UPXEFQ1l1uP0tCQn+4OmdNLe860o6qdVAXAPsVAKi7vwPnryDR8ijkcm/b12gGu5oXbE9q1MhMsXUrl75xt/M0QbDQM6dKArrfUVkdKjQnuiw3++N31Fjo23Q2dohZeI5myeEq1BkFt/FjWXcSURlvS4QXPz2RW7a+clniBbSUQOIei9F0UbKo+6uzfNpJNi84lbPyo3gAqUaRnE8uEtKpppURTxohULm3bxR1vDtovVD4h5nOT16Hu/t8VQx7aoSFKZIuw26g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mSH7ftkWiESz/t3SQXyv7Q5F4xQsR+lwpSie3/OBy3ME0CHfxvxL5Ci3xS8B+P13BepCydZVI717INEGj5yXLh19dMONhDFJ6CMSZY8M9bnAMpKn0y7UfATPaNCQoKLGw7ScdksiBUuwI4aL83PNmGkkUZk7mlSiMmhVnJgOQokXVspAz9VwetETjCll8YbRwuwyTcLAxZPHrhqCJVd1B2xXS5hgF/dGDM3z178HWSX49Fo/XuIWlSt57LHQSimFU4oLzwDAL/2h+GMs1T+qQKSrZ3EH7nazgvECxTLaLDgRNC8LH5uAJBprIkSAQIW+TvFni/dM6lVtd9jdFM9/qCKB1zx4+Bs8ls4/sjOXvJ+RFDBa1LsJPeHHpyru/ZhyPJxWeFZfv7uVBIK5D0jx+HvnmlipJHoHPcYlOW2fYPK4qbv3+bcrKBAi+4PiTM9B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:57.5219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32f90ae-d5e7-460d-ffcf-08df17b57dc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026958.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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

Extract mes_userq_reset_hw() for reuse by GFX recovery. Keep reset and
MES queue removal together, marking the queue HUNG only after both
operations succeed. The existing reset entry point uses the same helper.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 44 ++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.h |  4 ++
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index fe49aa4dc5ff..948813042e98 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -207,12 +207,34 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	return 0;
 }
 
+int mes_userq_reset_hw(struct amdgpu_usermode_queue *queue,
+		       struct mes_reset_queue_input *input)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	int r;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		return r;
+
+	r = mes_userq_unmap(queue);
+	if (r)
+		return r;
+
+	/* Prevent the restore worker from resubmitting the guilty job. */
+	trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+	queue->state = AMDGPU_USERQ_STATE_HUNG;
+	return 0;
+}
+
 int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_reset_queue_input queue_input;
-	int r;
 
 	/* already reset by an earlier job's hang-detect; just signal and bail */
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
@@ -244,25 +266,7 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 		}
 	}
 
-	amdgpu_mes_lock(&adev->mes);
-	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
-	amdgpu_mes_unlock(&adev->mes);
-	if (r)
-		return r;
-
-	/* drop the queue from MES */
-	r = mes_userq_unmap(queue);
-	if (r)
-		return r;
-
-	/*
-	 * HUNG, not UNMAPPED: the guilty job is still in the ring, so the
-	 * restore worker must not re-map and re-run it.
-	 */
-	trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
-	queue->state = AMDGPU_USERQ_STATE_HUNG;
-
-	return 0;
+	return mes_userq_reset_hw(queue, &queue_input);
 }
 
 int mes_userq_reset_queue(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
index a473360d6a8b..5e6d444447c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
@@ -26,8 +26,12 @@
 #define MES_USERQ_H
 #include "amdgpu_userq.h"
 
+struct mes_reset_queue_input;
+
 extern const struct amdgpu_userq_funcs userq_mes_funcs;
 
+int mes_userq_reset_hw(struct amdgpu_usermode_queue *queue,
+		       struct mes_reset_queue_input *input);
 int mes_userq_reset(struct amdgpu_usermode_queue *queue);
 int mes_userq_reset_queue(struct amdgpu_device *adev,
 			  struct amdgpu_usermode_queue *guilty_uq,
-- 
2.49.0

