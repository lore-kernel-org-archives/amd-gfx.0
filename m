Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13CFC79FA1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 08:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166C810F56D;
	Fri, 11 Sep 2026 08:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GM3XVd+T";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957AE10F56D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 08:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/7QeqjbI/fT8rrwu9IzF0EKWO+fHf/sWFsTSbbJ+Y6hfiWtINvKyvaLo4ZF64YuGNTEXs4w6iKBi1GLS6eFeWBmLMsxgvuxgZzVHgU4I/tzQvRbM3Vg3EqMCxIg2QYK9USeufCea2baQ8fmtJTfz86knE4f5pMv2fzPYpDF9uV8HW8A8zBvdCcQL+WkY4ZqXnrOzlCaLoi4csZ5CvMquZyd4o66L0qKMJ3HBFyzfv6LVrD4Z2uNbUKVG0YOCMjvZy6OLPhc+BnX8JWy75YV4J2kuczz15r6CuYRmBUZeRuYDnKGceZ+/H+Wac9Sw2HNmzf3aU1lBKyumDKP1DyhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24xvyT2/3losxCu+ZYviQRSJ/C6E8mC2V84Nt7HnXO4=;
 b=h78TGJTVx8LcG4L2Z1QxYAP3FyRlvJuLwsSzj9IQ4Z+2j98y4Cnye8VaD5+pYlJYOgzD0wYFBWOS2EQUE56PwO1tZjmMIfGFDLzgqZ5fDcMQxpUBq4xjdjmLiK6o1r3eBbvlF/5tdtqmH5oPp/cvFrUOSvRlUPqma0DMqEddi1U499jrWjBrdWAkkDG4s20+vhr8uF6f+yjEeBMraH8snqUWYOz42bPloFo0rbL0iZ1NyX6OYw5QKtcH77NnMn0Wx3w/0YhtdlUt39eVcQ5y72k/RkDA9fJz5QMaOkxEnZ8YKPTWOLehFMJojId6VbVlq5KKoGNhhecDSinJWtwzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24xvyT2/3losxCu+ZYviQRSJ/C6E8mC2V84Nt7HnXO4=;
 b=GM3XVd+TrtXry0xPupHi8Qshlkgpd5V7krlapMwYkAyLD2YBb8XomkMt+u5Bdu3/HEWvXWtFqvhX9FJmbqK1zYgAoFAWag2vTjlrt9F63gqCLjDfIGGAp08Z6zMoXmfkYP3otTdc6BYAQNiAH43rxVsW4CsD5pI2KOy2ntLExmY=
Received: from SJ0PR03CA0289.namprd03.prod.outlook.com (2603:10b6:a03:39e::24)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:22:47 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::6d) by SJ0PR03CA0289.outlook.office365.com
 (2603:10b6:a03:39e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:22:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 03:22:44 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/userq: implement support for query status
Date: Fri, 11 Sep 2026 16:22:30 +0800
Message-ID: <20260911082233.694414-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911082233.694414-1-Prike.Liang@amd.com>
References: <20260911082233.694414-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f00767f-23f4-4a53-b7cb-08df0fdddc48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i/vJQy8/NQ+Dph4Cg3f6O29rWnjz6tIeK56rg8O42IRK56G9c+eWsPZBPKlfN/R9cvyjLEi392qn+N8kbz7EnKZBUTiRAgrD03jKjYvV+Lt/VLNq++tinAtIZMJSBGnuSjRVpDBo+1VajBWWIEmOgKG7Qz+Ilf0DMz3yzcbxRyjxCjp+W2S9E+KyCz2aJJqZAbwAKpQbfEzLkzRF7YHkG/8vEZ6JTgAU/JJD4+ma59Pdxr2wAtJTfvYhVl7qc3mTZIA5RYEt7DakGwbl5FIqDU3uE3S400yntVb/qIteRNcjFTU/dox7jRmbSRSq1p/BCKZtmDjB49OGQYTuFOmPCRjBFunyLLVBRlXiD3AAXJgbrrNZRqoIm/nZU9APxvuhdw2ChPyUl1GDEfbJl/lPqRqlDft8tGMFi0NKRZkzbjJpIGI3EO40yVoIDd+4X9FchMgGkw3vnJY2BDHJbJBqzEfufo1IVk8IqQo2T4lI5ryIhO+6QQ77ZRzqIQM3evf3gydvLmMbMhr007FOg3dmdFFF0wsBufwbh7Out1VYYmBgzzDqNClBWR6BV5hucHaJRXI4WDGZ1xNYEAexMsVJBC5VhH95oPPpsVz6bvS89fXEYnwBnVcjaLnW5ezdn92bb4EkFVPdK8HBmlvbhexOo2omvbPblNErbLarUtV5AlQ23y8E2RQYit1ukOOb7IM+KsZqmKr+dnRlu14KAI8dYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nBew8w9Z3o8zpGu4C+KW/jf44q8UfWQV2ecBJZDFYrwiT1Hvg9YOuAfIgew2ay97cXiSUu/rV/PkMaUlHGsc7iV6GqiZACTndefMbDfhvN5W5nbA7flEYSoB+vzqrlRb2L8r+VeuVldR66XZTXYmQ37gJz4I+Ru6OIjnmF/4Sj1TGlel9Ze2nQk7gRP4V5O3WFD+92jUyteka3D/KzEYwo4g9pCFU5F1HvcNfkGrERtGd5teYs7jCbz+Ckmb8++Z7ZhBMaj4+NBuHhhN5gjBwyP3WnwSQZSOYnP+0FDlaAoJaHWrvyHeveWvBxzHF7EzJ05yyKntpX0iWQglAoG9ErcAS3FNk4FYGErLH6qReP/QzC3nYx5q3BSTm/S27GdQAUT4fc2E0qR0LelrCVwp0F2XMs56lB/nPzBdcP9Iql71jihQGal+ZJuxZ+VyOexj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:22:46.6825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f00767f-23f4-4a53-b7cb-08df0fdddc48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3938f7b8ec4b..1be5e70dd4e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -692,6 +692,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv->xcp_id : 0;
 	queue->userq_mgr = uq_mgr;
@@ -812,6 +813,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+	queue = amdgpu_userq_get(uq_mgr, queue_id);
+	if (!queue) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	amdgpu_userq_put(queue);
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -933,6 +962,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		break;
 	}
 
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			drm_dbg_driver(dev, "Failed to query usermode queue status\n");
+		break;
+
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..40228c60a1ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -79,6 +79,7 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	uint64_t		generation;
 	struct dentry		*debugfs_queue;
 
 	/**
-- 
2.34.1

