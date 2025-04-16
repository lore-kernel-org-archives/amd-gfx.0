Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035C9C369C5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 18:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614F910E99A;
	Wed, 16 Apr 2025 18:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uyGNYi1m";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D128F10E997
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 18:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yslXdBZJ7KQVcRXBu+E2hz+mkC4joMDAqSmHaahlRhWNnbZJcckXkwaKOqpNUGnIRuTu/NEXB9BdRHaV0gerTnE5aKcHz2DLlJ+33719cPFPeEmNJ7CybWKNvRtPsg3Bf+agWS+tT8hXgVv3Je/7oPni7lyqaXzYMj5LsaZitbqOSKSoti69Kp+A9QVKC0oRRS1khEsYDQPPZccjjiH6soNGnXcw7mSmO9ypVPRPEr92V64UVVfcN53GJPVWHoNr2DJbBFkZQMvxmmSgYZjzJYRs8C57+3BzWw/o91yn6/yh9D69Risj7OvS9vAIibEAJjzke7lNz5xxFK12CEfNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6Kw20mzrd4xTlm+LqLCVIOS1Y7pjNOqQRRqeyIVOWQ=;
 b=j3V080K/R+tGF8VzuXsUZscdH2T3FJ/8Xvx9Y0iJ57GgIdHgfyrWX/xpioHM7OJrrmIiE63iXJA2N36sBRmbHR0lys2D/+sIoWZqknsp+yT0VcCT5JdER+lU186jznh8TeXT02/9FkGkScBZLR2smyvh5opLWlXDlVsStMgrsXn8ekoGlHYMu2m3gkEzCk+yWIgHFmkF8LQxmle2Wc2pfQF08+QubyOn5HmmXmOIHz6MgIpgzgG89QRdGkwHs6Go/A6H3o9DU3QKqz8cHaChWwmN91t3NzX7k5BrWDnLw97ibFpePngDtuVDw6wjlC2wzEr1VaZulhotz8oiMQbtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6Kw20mzrd4xTlm+LqLCVIOS1Y7pjNOqQRRqeyIVOWQ=;
 b=uyGNYi1m20rlh5fs5xWB7on4/2ynCSlfUzkJhm5MW1F5XSRTtimqwyg5B+AF+PTZVdWFpOhurGbBABZq/Gj/ckSLq28hVYOhbNmsKlE45ON6psJTJbwCLNwx8ym5aDphQMCJVI5quJWm8AR/FCG7ki/qobENRDseMJu7CRE0org=
Received: from MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::6) by
 CH3PR12MB9732.namprd12.prod.outlook.com (2603:10b6:610:253::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 18:47:29 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::7) by MW4P223CA0001.outlook.office365.com
 (2603:10b6:303:80::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Wed,
 16 Apr 2025 18:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 18:47:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 13:47:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/userq: move waiting for last fence before umap
Date: Wed, 16 Apr 2025 14:47:13 -0400
Message-ID: <20250416184713.28964-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416184713.28964-1-alexander.deucher@amd.com>
References: <20250416184713.28964-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|CH3PR12MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebf121a-f55c-469d-6017-08dd7d17237e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C59PcUoK9ncHv5W2euUF4+hIxul7WJW15VZIF6yVUVyXgWXca+FpCM6U3m4T?=
 =?us-ascii?Q?fKJIZKkWa3TujUR834dxnV6I8F7TvjBksfYO08+ldMjegO7GH6XoC3PQMbQ4?=
 =?us-ascii?Q?pVBqcj9sA9b1BSjNf3FQhJhox3p3fiki70vrGNXTS9Cu0UwZwHOuHcsLfHh8?=
 =?us-ascii?Q?6fXOMP4puvchWINCGa/lGlISfu19kMDAr/chWnpievTkWiixzJAYiDHNSRw3?=
 =?us-ascii?Q?5PTfbBdY2YwL4SAPTcdfBpdEEoi43GcKDjRINVRs6xuerH4slQ9xFQW2Hw6d?=
 =?us-ascii?Q?zF/OeGl/MmnNEmGGNSivKtgpNHrUqCcxbenxEwR6Nnx3xNrTX/8LczJPnEDv?=
 =?us-ascii?Q?fuGlZxlSfIu6qHEPXnx10XmnJ+5ZTKPWfHW4ZAbtwf9K1QN82cl8aZMrwqNT?=
 =?us-ascii?Q?x1JvdU2vKIwEuCmJ7U1lZ/1wgFzYOasx4iVNvJRUQWxMiGqxFLFQQ+XLTaLg?=
 =?us-ascii?Q?0iMjQZEeL+oJdbCLu4ytY/fzTczvZeqWlPxzdIUwv8iNai4oqAq+suC5JXFY?=
 =?us-ascii?Q?k4VAJhiElkC5xjEb+KirQSzZjqYeah+3uIHTw4/58JdyIjnjgMpTuyOQ828a?=
 =?us-ascii?Q?RWXrElG8jfy2AKWBHdJQqXVYa3eIiEXnrKt6tGQFvmS/gEKe7qF2tjB+pFuv?=
 =?us-ascii?Q?TDxjQQ5IVIl1j1ojdGSwDVF6eSIUJZTxjQETs2Na98QLCvATyY5nH5gqETOY?=
 =?us-ascii?Q?6awi8l5ca8mEFKjuqSYjp1bofmt7AkineS1BgZ2kH1HR0gfqu2x+Rzpp414+?=
 =?us-ascii?Q?iBDCOkdUgeiaSqePGY6C1b1XaQK9X5xGi/uP+ir/+TgCLVskMVzZIp8er0iR?=
 =?us-ascii?Q?ANVdJN6hlr2lSR0u6L+Mrp7xHeEr2EIKxufVxcWcA96DwHskbctqm/N/KY3m?=
 =?us-ascii?Q?/LMdC+aDg5JCstx/NGMoNr1nuJJJVRdGTKgFK9DdX+tdwZ+xxQvYQj3WEG2n?=
 =?us-ascii?Q?5RuFBARuV8+4yegGxNp1+TE1Ofa+WZnPiojRwGPXWjOYycH3+/RS+M1DmQo+?=
 =?us-ascii?Q?q0WyI4bdKNdVW9asjm9pZQLayV4mzp7ASmOqBVnE2UN3aaZXFAYsKJgF0rrK?=
 =?us-ascii?Q?U3AWLdSyx8g4l6TiUVBUBLC2JogDMtsW+lIyLZxvfrnRIr1tDskULuHai8zy?=
 =?us-ascii?Q?tgk//bPd4ZeRSn/QUlztJTiN+RWBCi27Ltf4AxPaT+dnjWwscgr5IF5LFgq2?=
 =?us-ascii?Q?zHeLbRLYEwHuwWaqPAm3F2bB7t8nRZtmgx3G7zOUQRjcJIsaUNJ67BiaCa0W?=
 =?us-ascii?Q?jHDaTEuChIHlJeR0JtSBD4MoMoY4RqFieHvD/gJXjzlGp7wi2MUKltjnR1lU?=
 =?us-ascii?Q?+XeHWQ7j0/LiWttrl5aUzbnJf1DAxxEAZpoonzYIhMEAvDSlV78sKZuVNrAb?=
 =?us-ascii?Q?nCWFJgRdZkmwR566J9Hxa5oQigjmqbuOz+R1YBpKmS4rcyQzrDeYW24TQR1z?=
 =?us-ascii?Q?msqLQkiBrDDtk2y5s069hg/xbUpUhnZAAlqi69levVyblagsCG2Ybh9KMIWz?=
 =?us-ascii?Q?PrzpNlfoQc5PmBFBay0ZIbmspbwBSk3qnaUh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 18:47:28.8433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebf121a-f55c-469d-6017-08dd7d17237e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9732
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

Need to wait for the last fence before unmapping.  This
also fixes a memory leak in amdgpu_userqueue_cleanup()
when the fence isn't signalled.

Fixes: 5b1163621548 ("drm/amdgpu/userq: rework front end call sequence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index b449c685302e1..06e41023a04ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -109,22 +109,27 @@ amdgpu_userqueue_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static void
-amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
-			 struct amdgpu_usermode_queue *queue,
-			 int queue_id)
+amdgpu_userqueue_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
+				     struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 	struct dma_fence *f = queue->last_fence;
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0) {
-			DRM_ERROR("Timed out waiting for fence f=%p\n", f);
-			return;
-		}
+		if (ret <= 0)
+			dev_err(adev->dev, "Timed out waiting for fence f=%p\n", f);
 	}
+}
+
+static void
+amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
+			 struct amdgpu_usermode_queue *queue,
+			 int queue_id)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	queue->fence_drv->fence_drv_xa_ptr = NULL;
@@ -330,6 +335,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
+	amdgpu_userqueue_wait_for_last_fence(uq_mgr, queue);
 	r = amdgpu_userqueue_unmap_helper(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
@@ -818,6 +824,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 	mutex_lock(&userq_mgr->userq_mutex);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
+		amdgpu_userqueue_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userqueue_unmap_helper(userq_mgr, queue);
 		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
 	}
-- 
2.49.0

