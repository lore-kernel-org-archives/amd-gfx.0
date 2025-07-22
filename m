Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7819C83F34
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9EA10E60A;
	Tue, 22 Jul 2025 07:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1saYFPmD";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF3210E60A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5S4q+gQK2Jjop2o3boCgozdL5smct2Og2yYawtBXkbemItmHTK8y1HfMM4Rgo3R1GILNjY89KkvSNHe3qObfUR9PgV+icyDW95AbNJvlsduyjJKWI0KJXisU+ZdSeG9oTGXhbSgdQxtzAbg2cu22H3jjGNi4rrjiCrPuY/vHC4XnPi+13Lf2muHVumbehQXO51NLPOfvhJZ9aLRk+C8B1utxOksWEeJdyD2Uw5gVIw77+GDs07uf+bhSfmlFVMAkjx5RcS26gVZZKI9FvFaUwxP5P7S8rtUtIa/hlSO9qeoYHGjKp++qZf0w9vH4MyR5i6jrpvvqvJkco0384F+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSQ0a4aaCk2NnsvLTWBBiYeJ4AXZFSRj/haAyPo/oxA=;
 b=p5UULZqb1op6zNRQZ0LX+aDckLVK8TOKizJgxr8tC8VozSCasHU9tQNtyxM+xL+NfZYUQOJmPEbybjO90RIpbqmbOhwvdRiAl6CfpruYQZ/87+xeywpg8HXlsDYvY/X9xvARJUnVMc3FiaP70QV82vLJp9fHXvyELMi+O4mYzQmYaGHd/qdKVDQCli5Z9xy5qnMkT53idQfQ3tf5vU+xMqdG0rcKN3BMuk9F1JKZgfCzglwAowUz+LV+7jkApcO7akcLBJS5PErcTaELolbUX49c78NRB4xUHGUQ+Z9o6CZRtVuiXvQGy7KhnRlhR4gYsBnAcGbSERkN22CewIcSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSQ0a4aaCk2NnsvLTWBBiYeJ4AXZFSRj/haAyPo/oxA=;
 b=1saYFPmDmfK6buOw+jxQHedICxVZUDFinj+DTPL/UD2xWawudC01+OZ1ELV5LnYlqUpFaD5iDlcM2qZc1BUqMzWl037n2crxws5rGmVY9BUObXuuTwqhlf9s9bsGEJDeMIobAYZnCCDQ5p0V+usw60plcAIOtfq/K781qSleMDQ=
Received: from BL6PEPF00013DFD.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1d) by SA0PR12MB4381.namprd12.prod.outlook.com
 (2603:10b6:806:70::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 07:46:44 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2a01:111:f403:f900::2) by BL6PEPF00013DFD.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:43 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:41 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v7 04/14] drm/amdgpu/userq: implement support for query status
Date: Tue, 22 Jul 2025 15:46:13 +0800
Message-ID: <20250722074623.1464666-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722074623.1464666-1-Prike.Liang@amd.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 777d7bb7-cf1c-4879-1e08-08ddc8f3e731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AV0CSmGpP3OTaDVHxNbuRMZfkzmEjSlXVzGlmGeS5WFC2WlJVhNYJLRrHdfx?=
 =?us-ascii?Q?Pxpsy50Tp8afOgB4hYTfDSywJRna9MfiYTPHmO6mIGiXGE0ho5UQk4faLseC?=
 =?us-ascii?Q?yOAAwKjkXSa6jWAHfoWZ416SY6VZQfpXT78hg4q461IlTbR14ufDo1cnOHGr?=
 =?us-ascii?Q?qFJyZ2/8HCIHu3O3hDHLleZwB9w9nW44k6D4iFiiJjldYvtWYPvWtBjzu6mn?=
 =?us-ascii?Q?R4iIwA5WHSsja5YgrJrWhntq0IF8c7vZq80KXZQ1l4XTItWYfOAHvL47Yd0x?=
 =?us-ascii?Q?fcA7YbBkf8ZBo66dHkWARXr9VraK4Tja7zBiCdQX97NCfjMitrLbn6Lo5jbE?=
 =?us-ascii?Q?livm42JHROKe5uJQXVTuGYtgHh1gwkzD3WC3iNrekmxfxdbjTLKTd+S6kMD6?=
 =?us-ascii?Q?X4EhPRDZgji5HOIKxfKzGF+c0UX4j6samD5Dp1z+G/9/KGrD6rBnu2Cu37xw?=
 =?us-ascii?Q?qqo4IuKMs7nXJ9meobSiETvn5rDa2pI4kFzdlAb8bFqJn62FMiz2mVFsO/Qd?=
 =?us-ascii?Q?EP207ab3Pex+Z6HtzlGra3sIKbC5IitwohPBKtiO8Tw1NOydUjiDMKYTjV1q?=
 =?us-ascii?Q?TImQSBSYm2+FoqGHhQar3alM6vc/GRuXZcYuwNnr1LYXGU4ISxTOo/nmL1Bv?=
 =?us-ascii?Q?/8TzAvUqjmtj9Kffo+47eLh9MKttnIR5EGpFjmn++aT17XIJWAiMoKg/iwWE?=
 =?us-ascii?Q?u6ns/x0uHli29/ZYgFlxDe2JldONU0Hdw48/d6xyCWEJSzu7A9NEpeWx8Ube?=
 =?us-ascii?Q?Cv/8IVrv5NKSergBqJ6fGmIm2I6QiZbMBYtks3HQFfF3nNLNE4GntcKpuNPS?=
 =?us-ascii?Q?zQDeif1mDKp4+BEMbtXH4ekBAO0w7a5BwDGUBCBWyqDWACy/ClfAKq0NoRC+?=
 =?us-ascii?Q?t+5Lmq+ppbldyGsdWKOMow4/D0Pt1xcwdm7gl0wo1DSxW/zfhgPqjUBexqK5?=
 =?us-ascii?Q?jsZFtccbxKtmO3yRR+oiv/2O3XCekJPWcTN7izWwOhF1AvjjTgkHlyzja6MS?=
 =?us-ascii?Q?yRzgSMvBp4prd8w+IMPnqAtOUNMkxhM5OpTT9b10CkPQds48Pqa7mvuXnDRg?=
 =?us-ascii?Q?DOb8mXmSOxv+WkdwH/6JracL8v9zqFS2YhedFmhy1xKjicrHgHFe7l+9AZT5?=
 =?us-ascii?Q?FxHOwHVbY0ZWGI5M7hhhJ77JfynYzSJ61GwSaLhuMcPhz0LHj5dqJ8clqNom?=
 =?us-ascii?Q?kFRZUnULJP5zZiTZ9y86dutYDW3zdadoQFwB2pNuKyj4PpxF12tTMI5fgE1p?=
 =?us-ascii?Q?IDich6MgWFG8KZqpxnlEPav/gqx2F/Hdk+W9rci+bpyVjuk6fGRER7hf1YSg?=
 =?us-ascii?Q?GrYNqZDJqhjKoSvWnL/jFtuco4epwjg5Sr8+uFOD3C1YA4/W5jkGePiNdQR2?=
 =?us-ascii?Q?wf5QG+QPhsyujCcLew5mzT1DWhQNb86qkpZm8+UNT76ciBHyqXGdgujqzosj?=
 =?us-ascii?Q?/11WPagG2GdaMb70RnyFMK+sMwV7j9h8issnwd/KNuPx1EbbIrTNOAQdxWiO?=
 =?us-ascii?Q?6AKHLyIAKhyqMTBVceyHx3u3KR7rVFu/UAPq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:43.7422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 777d7bb7-cf1c-4879-1e08-08ddc8f3e731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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

From: Alex Deucher <alexander.deucher@amd.com>

Query the status of the user queue, currently whether
the queue is hung and whether or not VRAM is lost.

v2: Misc cleanups

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2b35198608a7..75b7e39ee576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -403,6 +403,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -473,6 +474,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
+static int
+amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_usermode_queue *queue;
+	int queue_id = args->in.queue_id;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	queue = amdgpu_userq_find(uq_mgr, queue_id);
+	if (!queue) {
+		dev_dbg(adev->dev, "Invalid queue id to query\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -554,7 +583,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			drm_file_err(filp, "Failed to destroy usermode queue\n");
 		break;
-
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to query usermode queue status\n");
+		break;
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..48722936ff70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -65,6 +65,7 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	uint64_t		generation;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.34.1

