Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BF1C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Dec 2022 19:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D241210E232;
	Fri, 23 Dec 2022 19:37:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E689910E230
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Dec 2022 19:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuIXQqDxEbUektD3P063MZCu+Eq3HetvfU/BuVfNbURc9ivlaEEmfolUUkMnI+vCRK4NeHy/QcMCzco02GR5Q8zs7izealTAXKITasnIwZ0MfcSJGz10gG3gXdgAioNZ2yJdY+9acuyRWNB81oG70otxiFBYf5uVD66uUcLen4Uo72noRU3tAc8G2SDstyby7uEIx94jeCPPwSjN8048UMXoteV0MG50sW96FPCJ9q9J3uFBstKxclu2XV40PlHAG6IFeQP3V1DyssDH/6VxoZA+Jca0hKirIZ3RAwd7BEN0gF+oqPkEYT6Gaibn2pyGs0Cyu6XmSCKpxtoDiIXrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezobu/zIdRxqK/pVmuMAJOyIBCBzP6JIM299D8siMkA=;
 b=BovZd6uVst/isIJQqx9SaLNEqUQzZdII1sXBSacM22e1v5YjYy+Fakx8DKwIho4bTzs5COyxxh2fSaNTDjCFPLXWrGKLLh9495/bPsII6cnAMnGtw2eHa41K7L4NZfIg/tFWox/LkUn4uwwsxWfB/GcGxRBfRM0ljWCturAuzA7Z/VveNB19RuAAb8sekn04u0cK6iQMWAE3duWJBuXQWIsb4MIiSdGEn2oVxSWkamH2x9lZaGP7SYsaU65dLxvZXO8kkQYCbADDF2uDVV8uSfXBmtoZMsfRZPxNkNeGh3xt8wjjqqqfsTG8u9rlqLpwBqS6n+ecUxEBMiJgGoCM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezobu/zIdRxqK/pVmuMAJOyIBCBzP6JIM299D8siMkA=;
 b=EUqpiAJrdm95jcUktYOXbWebdRwhaQI0O1i+qS3ttYicarDaR1BBQ+U+y2+v0TUh7PJgC6kyNflDs4RpgoOx5l7nLYrAuUxXb/GJh1Tfyp4WR67kon+da/+ymelxjJWtAj9c7ETPJyjS0ADJ6H0ioUDsVuzH0vyAvjAnvdk1UNQ=
Received: from MW4PR04CA0198.namprd04.prod.outlook.com (2603:10b6:303:86::23)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 23 Dec
 2022 19:37:35 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::2a) by MW4PR04CA0198.outlook.office365.com
 (2603:10b6:303:86::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 19:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Fri, 23 Dec 2022 19:37:34 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 13:37:31 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 6/7] drm/amdgpu: Map userqueue into HW
Date: Fri, 23 Dec 2022 20:36:54 +0100
Message-ID: <20221223193655.1972-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20221223193655.1972-1-shashank.sharma@amd.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c04e1b-18b9-479d-7c90-08dae51d23f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGT1iqEJRzeiV5JCNmRUOG3uYXWdMaKcx17V8/vEMRONfpX4rA28Lm1MwZzmhgWc6UfBjTv9w49oVVFqJRXrSaxrgo6GydNI6CNMXgmyeNpKHc1Ze5iXDsQvg7s5c72gN64e0XIhUdBGozIvBfI16UFEUL4eigcjUke9wNkKYDNAYtHO+r5ON8gmkr7XJRBOUl2wOaJqude4wJdPwmP5fPeb4GDuMIuOeTOB0jJ5j1DIAg0uvad4r/saeECWzQHXsrTEjB1MeAM7KJGSgj8QNkGq5Y2D1skjgZoSNI9xNfvJgxq8E93Mvgs51YSdBaDqnkM0N52Nl9ZPGnvMK0Q6UCr+t8z8PuycuL3JTLGT+36MZGQIHkTpi52OGyJAePk22CeZkkfG2lYwu224lJOcRu7PtR7iImElXnMhyadLmBLCeUKrXvVtDe1wX81s1ZqC1DSfJBVbHjDZwpwG6J4Gf+OAiNgwC1i23KZIBCmewAYelVF+RtUqfmBpDqvpg4m6X0rIRRLZow2of80cP30N5KUNm+EZ+IpjBUBGxD1h0iaCLX5JwXMff0OItWBXzb5REiouJwOd2wREWaNpwF/tK+B6sOGDKV2BqU3HOpziTPTlHk3BT9UdmjCsvMWSEmbReaV6fg6AStMqSG1cYAbAbGcf1lIqJ4xdAsEWvMuBbYI1spoQO2Kq1rzKAcwaeWFdv4CpLH18a55Sbar4HeaM6sW4Fjv9BQeVTDeJlEHIxig=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(8936002)(426003)(5660300002)(47076005)(44832011)(6666004)(70206006)(70586007)(8676002)(4326008)(82740400003)(36860700001)(81166007)(1076003)(2616005)(83380400001)(356005)(41300700001)(316002)(40460700003)(6916009)(54906003)(86362001)(16526019)(186003)(2906002)(336012)(7696005)(40480700001)(26005)(36756003)(478600001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 19:37:34.5149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c04e1b-18b9-479d-7c90-08dae51d23f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch add the function to map/unmap the usermode queue into the HW,
using the prepared MQD and other objects. After this mapping, the queue
will be ready to accept the workload.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>

Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 2a854a5e2f70..b164e24247ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -50,6 +50,67 @@ amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct amdgpu_usermode
     ida_simple_remove(&uqg->ida, queue->queue_id);
 }
 
+static int amdgpu_userqueue_map(struct amdgpu_device *adev,
+                    struct amdgpu_usermode_queue *queue)
+{
+    int r;
+    struct mes_add_queue_input queue_input;
+
+    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
+
+    queue_input.process_va_start = 0;
+    queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
+    queue_input.process_quantum = 100000; /* 10ms */
+    queue_input.gang_quantum = 10000; /* 1ms */
+    queue_input.paging = false;
+
+    queue_input.gang_context_addr = queue->gang_ctx.gpu_addr;
+    queue_input.process_context_addr = queue->proc_ctx.gpu_addr;
+    queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+    queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+
+    queue_input.process_id = queue->pasid;
+    queue_input.queue_type = queue->queue_type;
+    queue_input.mqd_addr = queue->mqd_gpu_addr;
+    queue_input.wptr_addr = queue->wptr_gpu_addr;
+    queue_input.queue_size = queue->queue_size >> 2;
+    queue_input.doorbell_offset = queue->doorbell_index;
+    queue_input.page_table_base_addr =  queue->vm->pd_phys_addr;
+
+    amdgpu_mes_lock(&adev->mes);
+    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
+    amdgpu_mes_unlock(&adev->mes);
+    if (r) {
+        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
+        return r;
+    }
+
+    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
+    return 0;
+}
+
+static void amdgpu_userqueue_unmap(struct amdgpu_device *adev,
+                    struct amdgpu_usermode_queue *queue)
+{
+    int r;
+    struct mes_remove_queue_input queue_input;
+
+    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
+    queue_input.doorbell_offset = queue->doorbell_index;
+    queue_input.gang_context_addr = queue->gang_ctx.gpu_addr;
+
+    amdgpu_mes_lock(&adev->mes);
+    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
+    amdgpu_mes_unlock(&adev->mes);
+
+    if (r) {
+        DRM_ERROR("Failed to unmap usermode queue %d\n", queue->queue_id);
+        return;
+    }
+
+    DRM_DEBUG_DRIVER("Usermode queue %d unmapped\n", queue->queue_id);
+}
+
 static int
 amdgpu_userqueue_get_doorbell(struct amdgpu_device *adev,
                     struct amdgpu_usermode_queue *queue)
@@ -338,12 +399,21 @@ int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
         goto free_mqd;
     }
 
+    r = amdgpu_userqueue_map(adev, queue);
+    if (r < 0) {
+        DRM_ERROR("Failed to map queue\n");
+        goto free_ctx;
+    }
+
     ctx->userq = queue;
     args->out.q_id = queue->queue_id;
     args->out.flags = 0;
     mutex_unlock(&adev->userq.userq_mutex);
     return 0;
 
+free_ctx:
+    amdgpu_userqueue_free_context(adev, queue);
+
 free_mqd:
     amdgpu_userqueue_destroy_mqd(queue);
 
@@ -362,6 +432,7 @@ void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
     struct amdgpu_usermode_queue *queue = ctx->userq;
 
     mutex_lock(&adev->userq.userq_mutex);
+    amdgpu_userqueue_unmap(adev, queue);
     amdgpu_userqueue_free_context(adev, queue);
     amdgpu_userqueue_destroy_mqd(queue);
     amdgpu_userqueue_remove_index(adev, queue);
-- 
2.34.1

