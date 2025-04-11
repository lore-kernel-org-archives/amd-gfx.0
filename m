Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80620C369B1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA6D10E114;
	Fri, 11 Apr 2025 18:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GP0f1fCq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7B310E114
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLELt/AbZbUmOSxqbsk3FLz1LEqseKgcZ/h61exxq4Yc/qUwko+UdONC8t4V/iq0IRspEWtcRb8hirYYpsIyuBN4gVyOjwgoImFIzOgFBLlqjrwmUOdx+7HIPUsQCOSHvxhCC5SsG2lJL9SV+0WPCjQ+sVxQWHaslXdtLsvQ17YIxJJytsQRdtorrKKLr3nIxiUUNK2y6kNIPSOijuyFX5qtbfRTICfQfYHSIHVCLl1DMwErsVqGU2tsTox+0TYz3prDKXHiBzBbeJAeEQEmDZOgaAS1gIMnFk/lN8WQ8zWPnd2mWnZNFrT33aGAtITnz58PceuQlMVrS+G7qdtzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg/OyfK4Tcfy6h1mH7pkBQtFqueHs/y03wXCBOYKAio=;
 b=AsyGf2OAmpz/V0EPKMpJTnkB8pDj3YLENwnf4kefKWImLQ7nAn4O2u/PWOdvq65sObhAXoASfK4BwpOoGQMZvyYOEYKHgumI111sO0uZIdBAwQ3+PvXpX8A1WYfix5wZbPCmrczGPeEhpyrBorr2PR2b5m4z/zQfXJcmXIIeNJkkK44kCqsY5dgyp6yKg7ZjVX//wQ221GtDKTcCL61Yfdm2bbwGdqIJpx9ej0VLQ+XUObYHD/Bybh/q/2ZFap5aEBMTbt9cJXOSTSexTYFP5A0V2BuzhjDJtQhVWvXe025ohL+eOV0ZX/7DBgaAl8bKEeq+RGtfWig8SIwY8DZsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg/OyfK4Tcfy6h1mH7pkBQtFqueHs/y03wXCBOYKAio=;
 b=GP0f1fCqmTBRC3oMdKOIGJQp4Tri2RIgzhHSpRPntMogkAZirIIncBxDygJndAU9VOJPvNKhXZxgMMS3a+4h0rBwH4gnb0Bu0oX4G1H7+eYtKdGx6Shd/UqqmXYPsxqwJFZjio4QNEbpdqoQxAUT9Dlk7XVy9ZT5igG2uq5q91Q=
Received: from BL1PR13CA0299.namprd13.prod.outlook.com (2603:10b6:208:2bc::34)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Fri, 11 Apr
 2025 18:48:39 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::a4) by BL1PR13CA0299.outlook.office365.com
 (2603:10b6:208:2bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 18:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 18:48:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:48:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 02/10] drm/amdgpu/userq: rework front end call sequence
Date: Fri, 11 Apr 2025 14:48:17 -0400
Message-ID: <20250411184825.2890189-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411184825.2890189-1-alexander.deucher@amd.com>
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d607289-253e-4543-bd48-08dd7929791d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cIzV/e39pK7K4lOJp4QzcA6ZPAJNfItvTe2eEAwlfg+8610jovuKvSGZl0Rd?=
 =?us-ascii?Q?8SCosFuG+lxSmjW6UZe6UkXhkSW0A+A/iuhmKRgiqqilYlPn+vLDts5WPMGP?=
 =?us-ascii?Q?x1hTAumkSQAUaFDSdOckqPnsqKZeEeHnPHzcLc3zugYo/At1ub2WBKJlwpdS?=
 =?us-ascii?Q?Nhl/LtYyjQFErLEzOTd82MC2TmIXjbvg02kokVxiQg2ZVRSCnt5BHrxrWbZj?=
 =?us-ascii?Q?sWkgh5QPVD4YwmLNlcU0FoDB7zl/EiEvDBgMWAyVIiHjCjETAF6aT2du6UED?=
 =?us-ascii?Q?m5lvffa4TVRFILPU5LfFoUA2DVSjNVKnq6xcIvgU3afEwKK/u7D7M7WBEoS4?=
 =?us-ascii?Q?Ym0B8H1bAdFqWvFk0WuykKUdOhvaz4PvIS0Y6XKoPFS6UtgmAQsYWjDxfITl?=
 =?us-ascii?Q?igBuA/hfq/DrP2f4kNYc0ypEe/k4j8ykneZAifLGGrCNe13rU0pw7h7dlf/C?=
 =?us-ascii?Q?wVRbvuHeXDoIShjCMh92JbRFfqIUFw/MLWCpnla74hU7Zxd9Pyc0vKfkv80m?=
 =?us-ascii?Q?iB9/raPLNvqa6nJDc/atJEGUeQOU5OBtjWBq080soiwZcDnP9YEJYmHIunjj?=
 =?us-ascii?Q?CYkp7Dk7mIh9BkP2kqA7V8W9XFgo04LAwvgPnucmvZkaYODFZp6snZ85rxqh?=
 =?us-ascii?Q?iDhbIkYVgOrhRE+mwVA3NHpWq5uMtE2SXsG3vGiapFN3dynMPRm4QN8neNPf?=
 =?us-ascii?Q?8SwJBCwhuLIsw1LFIDVlwrCAs23HNegJAhZRqTIJEpU6wfuZ3opJOPFVXC3v?=
 =?us-ascii?Q?9rOlpwgfugZnEfxew6HF/gKlJhWJXIX3k0ns+w3bKG9CJpzIKTnQnY5caQxr?=
 =?us-ascii?Q?FNN5wW1wQtCPodF7kBx/yeJXfyCsGUEVChfwR2ooAn4hzpHjvqJig+AcDoL4?=
 =?us-ascii?Q?imInxrmt0ULhT8XktlmLIIPZioOQVj18uDNKfVApTg8NyPvpxGdoNXzoS0wc?=
 =?us-ascii?Q?fQ7zqFXDrLlOaXZ6xh34KFFs9SOgruxwlL+9xLugeXtVHW/4Vaepl7ewFtqu?=
 =?us-ascii?Q?fTzmb1iehiEH0YWerl+l88G3mU5UBzk5GGiWjHvrov7KWD+/5nQQEY4pI91A?=
 =?us-ascii?Q?EkPqTl6hoWbky5TJbhKDuV39tKzeQUpaoLsuFYqpCP39hHtOjstZ73hQXz8j?=
 =?us-ascii?Q?CDoH2MG9nUvsOj2zZf0qC22p2Xn7yjoN0jHOwS5+UvyIrmIk2kOJxwkzwPRN?=
 =?us-ascii?Q?lYBZumURqWfxDZFU+zNUza1UW4j0n5AD0gxcFFyNa9P3z2IicCxuGAU1VePV?=
 =?us-ascii?Q?ftcAODLXSXndEQgecdWvVORz9GtwIbXGgP3CXGNXYEIvTsLMzuMF9i1Xxvua?=
 =?us-ascii?Q?vczb1/+VdB5/xPfrS8xokjw7CLVkbLUQb8vVrtqSfBBFNBBaYMTEXVkjjgdC?=
 =?us-ascii?Q?nSWLfRSEwDK26WcKLwgCBy3+lnszco+h041ap61PXTZHISCo8ZJSqJgeXPUP?=
 =?us-ascii?Q?eS7piFGZ8ZM2KY9BLnP6gMKdotxvk2G7FeOBbBpE6txrRBfHhZaPF6zqD+CY?=
 =?us-ascii?Q?9zS3XXkl+n250XrciKZFh2y1ciXqZIJIJk1X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:48:38.8652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d607289-253e-4543-bd48-08dd7929791d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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

Split out the queue map from the mqd create call and split
out the queue unmap from the mqd destroy call.  This splits
the queue setup and teardown with the actual enablement
in the firmware.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 17 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 10 ----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 2be1e54b78997..c3873041ec942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -263,7 +263,10 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
+	int r;
 
 	cancel_delayed_work(&uq_mgr->resume_work);
 	mutex_lock(&uq_mgr->userq_mutex);
@@ -274,12 +277,13 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-
+	uq_funcs = adev->userq_funcs[queue->queue_type];
+	r = uq_funcs->unmap(uq_mgr, queue);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
-	return 0;
+	return r;
 }
 
 static int
@@ -364,6 +368,15 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -ENOMEM;
 		goto unlock;
 	}
+
+	r = uq_funcs->map(uq_mgr, queue);
+	if (r) {
+		DRM_ERROR("Failed to map Queue\n");
+		uq_funcs->mqd_destroy(uq_mgr, queue);
+		kfree(queue);
+		goto unlock;
+	}
+
 	args->out.queue_id = qid;
 
 unlock:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index fe6fc3e0a3204..e3c3fc160b799 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -320,13 +320,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_ctx;
 	}
 
-	/* Map userqueue into FW using MES */
-	r = mes_userq_map(uq_mgr, queue);
-	if (r) {
-		DRM_ERROR("Failed to init MQD\n");
-		goto free_ctx;
-	}
-
 	return 0;
 
 free_ctx:
@@ -350,9 +343,6 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 
-	if (queue->queue_active)
-		mes_userq_unmap(uq_mgr, queue);
-
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
-- 
2.49.0

