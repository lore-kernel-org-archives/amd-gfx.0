Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219C1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C8D10F52A;
	Fri, 29 Apr 2022 17:47:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA48C10F3BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKSzoONgTXqduVTPdgR9Rogi8Ct2EUqLQN33X/xV0kIOxR31SYlQblys0jBudPmpqFxyAfKNucgj3Kq5tUP/OJZKBQ7MJUg1Nv9e3pvnrHjZU6l4TW+uwpaRyedZjNQwU2G+zNk6pzjIYGyOUnzw09L8EVmSJINjGW2H3JZZyV6fD6rxuKMjosMbCamkLdNgdWmGXzhLlNd8WgP3VD7mYNVSVDYesySZWNY3lAew+klynPoHKv4NKDkl9F43LXV0c29DgY7V9Exlfc4ejtJqSgQVI6wY1DDISn87RDsrYcnkkaOqNE3h8HZDs/EOhmbXhlZOwnnxk690pk9dYDi6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulGBbCX6dzwQFWs6OeN7pnbFuMLrphcnCOYEzLyMvlo=;
 b=TJkKNE8YRtt9DOnmnTiCRutEyI9DCt7bpnsT7rtiKQy7cpdn6xRsa/rpvSVSkhNKZAuYcSrh7WC1mAI/iQ43v286Bfu3paQv0I4sMTA0IOUhmVdJKvuysagn8ZbZV1r2w6QSkKBz3kHafe+Q3wfQj5R32gk+NEnmY0L2h5niMEiIy3/iVxAnHFVB2MahIR/gzC2kRnIkheI3chhStvgDm1u4RoEsT1WcEuBo185ZseMs7DJA4+tlapQwtvm/CNJhFVBPmRZVqCC8O8vOL9GAx1zNPLXiY+ExyGkxoskFSf3S0H+7W/WgfJteFolQenJA1BbCmUySKIDKuZQHp7IbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulGBbCX6dzwQFWs6OeN7pnbFuMLrphcnCOYEzLyMvlo=;
 b=19dp8WjdA3NxbvlJ4i28oUT4tbzDoXtszm/BS/6sr1bUMvGUxs42o9C13m5CGik49+ARzWyGzMST+BB9CINrzbfhg+xBvBwHtWDj3PE4HkN9RfL4/ciOs+Dk4iPH58gykqMqXURlPeYtGpQXq8HEo27WlkR/K8amcWqSVyi4CNE=
Received: from DM5PR21CA0007.namprd21.prod.outlook.com (2603:10b6:3:ac::17) by
 BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 17:47:12 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::e1) by DM5PR21CA0007.outlook.office365.com
 (2603:10b6:3:ac::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.1 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 53/73] drm/amdgpu/mes: implement adding mes queue
Date: Fri, 29 Apr 2022 13:46:04 -0400
Message-ID: <20220429174624.459475-54-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4326face-d757-4af4-a4d3-08da2a084a55
X-MS-TrafficTypeDiagnostic: BY5PR12MB4290:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42901FFCFC7ECE3666FB2B36F7FC9@BY5PR12MB4290.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kq1tuCtKM8LRz1SVG5XTKn93fnrewNuIAdn2QPqY+8HskmVVoef14qGLFofLdgBnuMO14zYNpU/n8+7qASljGMSfcI5vNh5EOeReWpM2l3G9wc/pR0D2Q7W1+Rn8iTQk0aG25jiz0WBY/IS9OFU6RxHnVFIolOa12v5zUAnHweD2P3WsUOeQdrMwnxQHA7ueyGdment9Ifhfg2AIXeksT/q/SoMyJoQAvf4qfS8c4Bq1aGlB7SstAUCpmPEgV9m+X4xEGIrmdi+PgL6Nvkd/yy+jyI1H3w1K0brQNp5hsyQU9d7Hvocy8QYHFdY6qf7Qz7pYCwopA0Hq/w0gcFQp1TIZBf6NMARebWu2+mGdPCnrj4gaK+YTK/VcqZ/e89yRPt0ntcGY6q99CdI6QO+xtXSdUyb2LLVs9TDDAYqUE/yAj7rWMccFaxxUPm6x8ODSmY3M263MR3sLTjgAfTiCAN4TDIh1VW/5AGJGNrWhrxYQe60G4FdfCid9j9BrIq5bbz/zRiSFvkZ+DxBNmkaMtbZaMeWGvVt/zBFKiNy20V33x2459SNfIBQMoaFZs/De8gTZn1ohszAmvCRkVX0sjkuhtPirACUj4JwDxSVkzpiQ4OOaCKiySflcNozWCLoq5JCQD6Qy1HFqGPFP7vxOGXXw3+5zXsivbXMUhfZezk77xIR4P4nt4cB90sbdwvMlykmfozHzhBc18uU7+rbjnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(26005)(356005)(2616005)(2906002)(81166007)(7696005)(70586007)(1076003)(8676002)(4326008)(54906003)(6916009)(70206006)(36756003)(86362001)(508600001)(16526019)(6666004)(83380400001)(5660300002)(47076005)(40460700003)(336012)(36860700001)(186003)(316002)(66574015)(426003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:12.0640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4326face-d757-4af4-a4d3-08da2a084a55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Allocate related resources for the queue and add it to mes
for scheduling.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 105 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  19 +++++
 2 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 2cd2fa76b5c8..9f059c32c6c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -550,3 +550,108 @@ static void amdgpu_mes_queue_free_mqd(struct amdgpu_mes_queue *q)
 			      &q->mqd_gpu_addr,
 			      &q->mqd_cpu_ptr);
 }
+
+int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
+			    struct amdgpu_mes_queue_properties *qprops,
+			    int *queue_id)
+{
+	struct amdgpu_mes_queue *queue;
+	struct amdgpu_mes_gang *gang;
+	struct mes_add_queue_input queue_input;
+	unsigned long flags;
+	int r;
+
+	mutex_lock(&adev->mes.mutex);
+
+	gang = idr_find(&adev->mes.gang_id_idr, gang_id);
+	if (!gang) {
+		DRM_ERROR("gang id %d doesn't exist\n", gang_id);
+		mutex_unlock(&adev->mes.mutex);
+		return -EINVAL;
+	}
+
+	/* allocate the mes queue buffer */
+	queue = kzalloc(sizeof(struct amdgpu_mes_queue), GFP_KERNEL);
+	if (!queue) {
+		mutex_unlock(&adev->mes.mutex);
+		return -ENOMEM;
+	}
+
+	/* add the mes gang to idr list */
+	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
+	r = idr_alloc(&adev->mes.queue_id_idr, queue, 1, 0,
+		      GFP_ATOMIC);
+	if (r < 0) {
+		spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
+		goto clean_up_memory;
+	}
+	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
+	*queue_id = queue->queue_id = r;
+
+	/* allocate a doorbell index for the queue */
+	r = amdgpu_mes_queue_doorbell_get(adev, gang->process,
+					  qprops->queue_type,
+					  &qprops->doorbell_off);
+	if (r)
+		goto clean_up_queue_id;
+
+	/* initialize the queue mqd */
+	r = amdgpu_mes_queue_init_mqd(adev, queue, qprops);
+	if (r)
+		goto clean_up_doorbell;
+
+	/* add hw queue to mes */
+	queue_input.process_id = gang->process->pasid;
+	queue_input.page_table_base_addr = gang->process->pd_gpu_addr;
+	queue_input.process_va_start = 0;
+	queue_input.process_va_end =
+		(adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
+	queue_input.process_quantum = gang->process->process_quantum;
+	queue_input.process_context_addr = gang->process->proc_ctx_gpu_addr;
+	queue_input.gang_quantum = gang->gang_quantum;
+	queue_input.gang_context_addr = gang->gang_ctx_gpu_addr;
+	queue_input.inprocess_gang_priority = gang->inprocess_gang_priority;
+	queue_input.gang_global_priority_level = gang->global_priority_level;
+	queue_input.doorbell_offset = qprops->doorbell_off;
+	queue_input.mqd_addr = queue->mqd_gpu_addr;
+	queue_input.wptr_addr = qprops->wptr_gpu_addr;
+	queue_input.queue_type = qprops->queue_type;
+	queue_input.paging = qprops->paging;
+
+	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
+	if (r) {
+		DRM_ERROR("failed to add hardware queue to MES, doorbell=0x%llx\n",
+			  qprops->doorbell_off);
+		goto clean_up_mqd;
+	}
+
+	DRM_DEBUG("MES hw queue was added, pasid=%d, gang id=%d, "
+		  "queue type=%d, doorbell=0x%llx\n",
+		  gang->process->pasid, gang_id, qprops->queue_type,
+		  qprops->doorbell_off);
+
+	queue->ring = qprops->ring;
+	queue->doorbell_off = qprops->doorbell_off;
+	queue->wptr_gpu_addr = qprops->wptr_gpu_addr;
+	queue->queue_type = qprops->queue_type;
+	queue->paging = qprops->paging;
+	queue->gang = gang;
+	list_add_tail(&queue->list, &gang->queue_list);
+
+	mutex_unlock(&adev->mes.mutex);
+	return 0;
+
+clean_up_mqd:
+	amdgpu_mes_queue_free_mqd(queue);
+clean_up_doorbell:
+	amdgpu_mes_queue_doorbell_free(adev, gang->process,
+				       qprops->doorbell_off);
+clean_up_queue_id:
+	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
+	idr_remove(&adev->mes.queue_id_idr, queue->queue_id);
+	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
+clean_up_memory:
+	kfree(queue);
+	mutex_unlock(&adev->mes.mutex);
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 43d3a689732a..ec727c2109bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -158,6 +158,21 @@ struct amdgpu_mes_queue {
 	struct amdgpu_ring 		*ring;
 };
 
+struct amdgpu_mes_queue_properties {
+	int 			queue_type;
+	uint64_t                hqd_base_gpu_addr;
+	uint64_t                rptr_gpu_addr;
+	uint64_t                wptr_gpu_addr;
+	uint32_t                queue_size;
+	uint64_t                eop_gpu_addr;
+	uint32_t                hqd_pipe_priority;
+	uint32_t                hqd_queue_priority;
+	bool 			paging;
+	struct amdgpu_ring 	*ring;
+	/* out */
+	uint64_t       		doorbell_off;
+};
+
 struct amdgpu_mes_gang_properties {
 	uint32_t 	priority;
 	uint32_t 	gang_quantum;
@@ -233,4 +248,8 @@ int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id);
 int amdgpu_mes_suspend(struct amdgpu_device *adev);
 int amdgpu_mes_resume(struct amdgpu_device *adev);
 
+int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
+			    struct amdgpu_mes_queue_properties *qprops,
+			    int *queue_id);
+
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

