Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE292C88E70
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3377410EE1F;
	Mon, 14 Sep 2026 13:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fKGalWrd";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E30210EE06
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APzMQe3wvYcAfDRHYrMHpIqjOs+0JufKOlYoJPWPYA/o0OsctYv2otzlYOjarOZ1sgeWqHpWLhjC2/U4+rsCkwmM2jKaru5V8K6kln8ojUF+MdsLMCZyhioY0WZ72xjq/eOS8dOoE7/OIDFoC8ie61U0bpzpGU42QN5AsEQlJKcIK2oVLqT0FSPHL9xF2AKgnQ0MU7O0fibjCfrtPsKD1gse1Dx/mIyvCdfqL5NvDvKN2Gw9bgBYmdSs+RiEKeEH756cMc6OcjM81z1XuZsoCZP6RmKA8P/wuaUWrVrA68KjH+9slI72dveaETQjiZHcYUaJdnA1hDR0G6cdIkm/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vesjpXLH6oRPpbyshfIn2dBRGbVLLw6tnGuCZwCUyZ8=;
 b=W0m2mNVSzySdrIgmTSG8EP19kkYb1Ba4c8kW4d7mzTYiJC2gRSscubm+k9p/JIoSM5c8QfFBgYnvvXFyVpvb9vFmFi8h9asRUJpfd4emYFFzdcNPTGl6peX3u91Sngs4c5UvrMObnI/mcXpvaKX/r6qnGaXxv2MLTJLT2gz1OUS5Ne3imDd0y/UNE4WsnZzikx7WXemWepluJ5NqYZ9krkZnLvB/+xbCph8bglERJcweqV5j3JUBlsgRhr3BeO/3VqXfgghXz1FuOgG4WymU5GM8/vw/Kv36x9GupJnEMCquL4bQlIQ4DWrjKk97DfHUQbeIXY4IiVOxtQIFGz9fLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vesjpXLH6oRPpbyshfIn2dBRGbVLLw6tnGuCZwCUyZ8=;
 b=fKGalWrdueUERLU0pmITs3DPb9GMqa8RiFirjaBFAjrlF0ABIIrPvgpypdAQZlPccXuOuzqwS6vAwwVYJmwspU08LnRjW1sXVqPpX+emAmI7iQPOju50YmVXQzqzhGOxPUpsbBP67s/p+aF4eCTiFIo9Ycc2zu8dfTO32KF/ChQ=
Received: from BL1PR13CA0063.namprd13.prod.outlook.com (2603:10b6:208:2b8::8)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:07:18 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::5e) by BL1PR13CA0063.outlook.office365.com
 (2603:10b6:208:2b8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 14
 Sep 2026 13:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:18 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:16 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 09/10] drm/amdgpu: free userq by kref_put when fails to
 create
Date: Mon, 14 Sep 2026 21:07:23 +0800
Message-ID: <20260914130724.130794-10-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914130724.130794-1-lingshan.zhu@amd.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eda2fbf-c4b0-490b-fab8-08df12611b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QB2Z+YlCiVw1uiz12HrpK0nzI2drSdj0gRB3UiL74e+pTIv9CN82Y0aesTWHIuKulHSSKQBKsBdAsU675nUe1d8+QbQO+a1y3V+WrhjpbhRT5wTespS0IQvD0rQdc8KnqE//fC+B0/2Rs7yLeZzQCCowCKTz13N8vjFWSS3ZkJlVhesf1jSR+96g+t27QLIk5DBFm+TPesTWYhQPtz8sNhiUZroa68AX4mLGHw4fRpcoRkwLHNpAUZyNPunCxRNdrYqf+pKTFYgj1Jl8T1Kc8XbnzdWr4BuUSxj+JmBcFh2ezG/GuxuFyIUXxyvasYSauwodMrQKKttPsLOog3+pIs3IeSM+9AQI+V8wvAw3/2LtqEnPFT8KnxYG+0pffT1l6w5nL6VmWDuCUUDAQ9Nuy21FGlaNMF2I+lH6pOE4F3ddScxYWrXeQPwGnNhkEEUddxFIDoBFvbKuXb+alu8+vJTKGZC2snTtnoSbUy7lOO0BW1BPO9AiUwzSWhrxiTv8fbtVvtGnJruwvv0Ii/YMHTE726+yvmVy1CC4yt8NGTlfhYEu2PsHBI5g5m74Zt7osrg2SrkZ5vz9R5j+GknXUVzIs2sjKTqxR1HCVJfLFWaAQIMGzuJbBzIL+VjNlyXLSx/w5m2V871JoT5Rc6izZ3H5A0h5T80kzyfgYN7jv1/dynlwYpRnra4Xx+RnPSWDAOLiU+QkGz0LZOC2U8CtyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SFUhc93ztKFz2czaBuf2IpoFAOddNp7tQScSpvQ0NoGb9O3bi/QZ6uV83G8goOzW9RwpfBxmWsZb01POJVVVajqcFIoenNh/YCH+y29aJqdw2Cpt4a4ry6i+WbwMZSvrpO5ZfAQ7hLOs7Y6ry+/1ubTYY8n/HQA/rTOGdxHQtPwkPWkQN+DZITd2byXRr9gONnvHa6hyiq9nD5CRw8L+z/6YdVFukpH4fwTQZOrNmTBMoDYffxXuVvsRNjMAuxjS+entuM1bPJNx4zIFTjAG13/a0hQZ85AOWCJuahpaZGK6tyFdXczmPApIAhLM5g5eUHOxV4xWTVOfajrzAmmbO2dCtvn+KQ6utGBlPNgwFfg/L2AIoSH08KYFVqAnlEAY/L7dS7Fj4Y+q8/7gzn2yuU4NAVjrhLV24hHgGZx4CN19eAIyEtYV83OOOLKGubdH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:18.5183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eda2fbf-c4b0-490b-fab8-08df12611b19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
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

In amdgpu_userq_create(), once the user queue is
published to userq_doorbell_xa, other threads could
access the queue from the XArray. But the queue
may fails to map the queue and kfree(queue),
this causes the accessor use-after-free issue.

This commit fixes this issue by properly
get and put the kref of a queue to maintain
the lifecycle of a user queue.

There are some minor improvements in this commit:

1) Early detach the doorbell of a queue when fails to map
a queue, because the map helper set the queue state to HUNG,
and the asynchronous post reset helper amdgpu_userq_post_reset
can find the queue from the XArray and remaps the queue again,
which causes a queue leaking because the user space
already receive an error code for the queue
from amdgpu_userq_create()

2) Use xa_cmpxchg_irq in amdgpu_userq_detach_doorbell().
Once fails to map a queue, the queue destruction process
is asynchronous (a delayed worker), and a new created queue
could re-use the doorbell, xa_cmpxchg_irq compares the doorbell
which to be deleted with the doorbell which @index points to,
so it does not detach the doorbell of the new created queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0dab395ef0f4..21a9a2138fc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -424,7 +424,9 @@ static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
 	struct amdgpu_device *adev = queue->userq_mgr->adev;
 
 	down_read(&adev->reset_domain->sem);
-	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
+	/* It doesn't alloc any memory here, so pass 0 to gfp */
+	xa_cmpxchg_irq(&adev->userq_doorbell_xa, queue->doorbell_index,
+		       queue, NULL, 0);
 	up_read(&adev->reset_domain->sem);
 }
 
@@ -836,6 +838,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r)
 		goto clean_mqd;
 
+	/*
+	 * Once the queue has been published to doorbell_xa,
+	 * it could be accessed by other threads, so it has to be
+	 * destroyed through kref put. The destroy work decreases
+	 * userq_count, so we have to increase it here.
+	 */
+	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
+
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	/* don't map the queue if scheduling is halted */
@@ -851,12 +861,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			trace_amdgpu_userq_create_end(queue, r);
+			amdgpu_userq_detach_doorbell(queue);
 			mutex_unlock(&uq_mgr->userq_mutex);
-			goto erase_doorbell;
+			amdgpu_userq_put(queue);
+
+			return r;
 		}
 	}
 
-	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
@@ -877,8 +889,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	args->out.queue_id = qid;
 	return 0;
 
-erase_doorbell:
-	xa_erase_irq(&adev->userq_doorbell_xa, index);
 clean_mqd:
 	uq_funcs->mqd_destroy(queue);
 clean_doorbell_bo:
-- 
2.53.0

