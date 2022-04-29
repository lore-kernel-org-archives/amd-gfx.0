Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74597C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 360D410F553;
	Fri, 29 Apr 2022 17:47:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EB910F24D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAikhOxVGNTW326j1oNTCbaKCjKvHmFm4Vo91mTMiblc/mvlLtmDm9YIkIFsjs91hx5szQkBC3t0ezWvb0i4J7kEIiR33YpYxsPLxWhMUJcxBuN9cobIe6Qw9rdoPOvBqiCxlq3yuL6OsG6jxrf/Rcn8QpUuLTr14qzyIYGfGT72PcWA9PHaVBtDoNZF5jetGWFt3fUiYbL49oY5FDSNVURQbV1MCfpZngqRnxD3JUZQ5Cl7/RLK561xOX+2JaDwq8cH5qM8zzCChZpnQH2jzm1Eugy/0WiYsLF+vnGgEgfmfaHwKbhz4ldHMbLucm4ZII6ShS2rrZQMsVkeBKSvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLD1N39lrQJKKSUUhy/8p0rPfu3XJ2g7nqfl3vML2wM=;
 b=LZuOPC92taSzEPe3FgXSXHpfUi26N3VgMJTBm6YfA42+pMyS8T5sFP5PWJOLtoEskBZf+tig6VMM6Af6SA555SZ7S5gR2KsR2GMuAZPUYE9YJ+kUMe98SZ1zX/3NAe7nUkySebdAmwqdxPiWWMMuqiaIn3lz/zPvXlIGKUDzfgmR1PttSjIN9bwcqUr01fTb3ERIFMnIbg0VooHhISoey3wkLwbEm0NBR1lIguROTcIEBARxwUPxmqWPct4eIdDtMnHroXjtj/UrdKMdRtlhNPp/uD+FSgPrcjjfVNeujqt0zaOlvtduGBqf1FWLs7RN+Vbcg8eLJoyoXr3D89nN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLD1N39lrQJKKSUUhy/8p0rPfu3XJ2g7nqfl3vML2wM=;
 b=OJp9ZnTyFs2uGtviL9y4AVh+JecMt+00YijX40nLoT3CyeQ2DuJv5AcNHrjcRIu1shtRoU0PnETbrtmTOgGFjd0hU3XOPKY2nq7gn78Wc/BVazRkUszUa9vMqyqZ+wvigIM8MB67TFSbAEC5y3O4cbPIsUelIIMTQ8fgaiXDqFc=
Received: from DM6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:5:1f4::30)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:47:07 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::92) by DM6PR02CA0089.outlook.office365.com
 (2603:10b6:5:1f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 47/73] drm/amdgpu/mes: implement destroying mes process
Date: Fri, 29 Apr 2022 13:45:58 -0400
Message-ID: <20220429174624.459475-48-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7b7e9b67-935f-4cbd-e984-08da2a08476b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4174F552A2B512CE81A125D9F7FC9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVX+kwrx9D5Ic0RFsCdG8NFTMmNn6rEEKOC1mNOyc+Q2l3M79D8QSC0mMg2P3deXKZiI27/fJgom/c9l3Tc5NkzwJf8LcNvpCt+PRwDOeObq2f9Bkb77DSLjWx5Ie/lPQyvoXiRbImA0pcnklxWc7d6Y2rg74f/1uPnrslKVfZlZr8LjVKpA+aVX/etSE47y8uVDPU+YSX/3s6nfGTJmNHWZtagax5khjN1yCmFn709Ob6o6sPil4W4mcafIgGm74qrR7QzbuGQYtJk+CExnefdr/5+FqAm908v/pNa6l3vNrlvukjpZZW9nhiBy/4jRvKXTgKUffo0rQjaBJVCxuW4WHgzZ3JLsXxzrr9spPs6cCjFc1bwSGr6+rNndYTtFf3SNmbkDtjK6o8SWlMNgqGFZRsGpAykl1WdfSvy1yxjv87tJG586P9MdCzmOBmGd7LgLtMPtXEEa8FP/3Y9ixYxIHXEBBS6wR5ORoanoEltka4z+vNEZoqf/rxCak0+JkGn79Xa8pZTh79wFuJXs741s7PCzolE6jikU3YeY7sweSUZl+WHKA6U7jw6btA34o1ovofuYKfNRW8Pz3Cgq6+sWO/1IC9aFpwRilHrb4D6oSd6tyxakstZq1kNa4Rlw8Djcf6w3xhFldgNEkH9hFYx5vxry+0QbizC6uJDseOA1RtLlTD6LYJ2w9fQWpVh4oa/wZC9JbEjLBFH8NM0x/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(16526019)(186003)(336012)(66574015)(426003)(6666004)(7696005)(2616005)(1076003)(26005)(356005)(54906003)(81166007)(86362001)(40460700003)(2906002)(36860700001)(83380400001)(82310400005)(508600001)(70586007)(4326008)(8676002)(70206006)(5660300002)(8936002)(36756003)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:07.1612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7e9b67-935f-4cbd-e984-08da2a08476b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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

Destroy the mes process, which free resources of the process.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 58 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
 2 files changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 55005a594be1..05e27636ce20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -291,3 +291,61 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 	mutex_unlock(&adev->mes.mutex);
 	return r;
 }
+
+void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
+{
+	struct amdgpu_mes_process *process;
+	struct amdgpu_mes_gang *gang, *tmp1;
+	struct amdgpu_mes_queue *queue, *tmp2;
+	struct mes_remove_queue_input queue_input;
+	unsigned long flags;
+	int r;
+
+	mutex_lock(&adev->mes.mutex);
+
+	process = idr_find(&adev->mes.pasid_idr, pasid);
+	if (!process) {
+		DRM_WARN("pasid %d doesn't exist\n", pasid);
+		mutex_unlock(&adev->mes.mutex);
+		return;
+	}
+
+	/* free all gangs in the process */
+	list_for_each_entry_safe(gang, tmp1, &process->gang_list, list) {
+		/* free all queues in the gang */
+		list_for_each_entry_safe(queue, tmp2, &gang->queue_list, list) {
+			spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
+			idr_remove(&adev->mes.queue_id_idr, queue->queue_id);
+			spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
+
+			queue_input.doorbell_offset = queue->doorbell_off;
+			queue_input.gang_context_addr = gang->gang_ctx_gpu_addr;
+
+			r = adev->mes.funcs->remove_hw_queue(&adev->mes,
+							     &queue_input);
+			if (r)
+				DRM_WARN("failed to remove hardware queue\n");
+
+			list_del(&queue->list);
+			kfree(queue);
+		}
+
+		idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
+		amdgpu_bo_free_kernel(&gang->gang_ctx_bo,
+				      &gang->gang_ctx_gpu_addr,
+				      &gang->gang_ctx_cpu_ptr);
+		list_del(&gang->list);
+		kfree(gang);
+	}
+
+	amdgpu_mes_free_process_doorbells(adev, process);
+
+	idr_remove(&adev->mes.pasid_idr, pasid);
+	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
+			      &process->proc_ctx_gpu_addr,
+			      &process->proc_ctx_cpu_ptr);
+	kfree(process->doorbell_bitmap);
+	kfree(process);
+
+	mutex_unlock(&adev->mes.mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 010a9727cbec..fa2f47e4cd5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -215,5 +215,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev);
 
 int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 			      struct amdgpu_vm *vm);
+void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid);
 
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

