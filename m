Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC38DC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69DC010EB5C;
	Wed, 29 Mar 2023 15:48:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E32110EB5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG5WLDH8iI2W31SiwVtJRF9zEKH7OJty6D4h9L/6xAuBr1CyXaE92goRndiqlesiUhre6knifk64mevG+/gYcjFYlw1GFLAN609iY+C6gvs+mSbR4YENp8fs1597WqLxg58JN/QWg8uCX6Kb1KML0I7tEFYgBR6MHq0CwSXflSVP6amgv1tI83eMqk3DE0jMjfyUiFyV6bC+BL00L0YOJl/PP6L3pcDsBgfKlwVdFRpuCnfoAAV7n8qfR/0Ldw/SWOmoe7UOLGVR0COwTxQ+hRUUNu79t0eqxVk18WXGdkW1ZPvmWOW2nkxZYjK+b/8ZDElcaFQkcGfo6npmdRs73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtDqcy0g81bqHg1GiA3nrddULOxCXmPLEGDaqzmzcBM=;
 b=BstIY0OZv6XJkHBIqLYnT7qMK1P7j1k82upnzKLp4JwJAtlrMhPJsbkq9S1+wQD3bWCBr9Xlruc5ap9ZR8LOFL7XzyF13dqOwFqDU6p2IIhagoRxCjpKp3lhw9Z0BlW+ylthkFMU391Aen9CD+VpdSPzAshuW+mdnTl2rDFD3YdfHqGy5chlCQB22ywZZFsSgJ1xf2AGA8xKPUdM3QQChTL3W/B3VlGPdCVSS3PAyQpj3BsyoVlpJWH2xYSaLZdjMpcBjGdgDhiw6u36FFsV7VkvzFuVlrIesrfYj3LHIe+9B3cSRYzom2TfTp6m6rWGlrMuyOa6SwvR+9zujV1QYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtDqcy0g81bqHg1GiA3nrddULOxCXmPLEGDaqzmzcBM=;
 b=aqcqOweEoVQhpHKADuwT0gxBR1YQYSyNX9B0O0nrYzInT8x270DeAMG+dqTLyk9QkaSrei9pn7/Nz4PZ6aB2h6E7Y0XDFAOONvEGLGw3b0mmEdKBus0DQcXmK4550o/q6N51CtNI0BiqeeJz/Q2qbnOT3vC5FqyzKUaFj3QaEkU=
Received: from DM6PR14CA0050.namprd14.prod.outlook.com (2603:10b6:5:18f::27)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 15:48:42 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::c5) by DM6PR14CA0050.outlook.office365.com
 (2603:10b6:5:18f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 15:48:42 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:40 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amdgpu: user doorbell mgr for MES process doorbells
Date: Wed, 29 Mar 2023 17:47:53 +0200
Message-ID: <20230329154753.1261-17-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef7587c-7d00-485e-6e4f-08db306d1293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k73kTNiCTP5Q7oTXmJyOHAGpCe1f9vgzj1JSYyY4oP4u1CkFMrySoX5kI/So6x47gss5LxxFs0d2CEdbUd4Z760UceRO1JmrustODLlOtI0HD5nR3wfjTPyWC+w8ulVWpMxA7X166EaWcP8x43/WlX2ks2czzkKONBrU1N5ReWmK6hFi4nj/0wJzJ6n31OYO5Fc9wDKtDsrOtapoGazDtDiJG0+3tw2HUtvcUwUodvQeoOApw3neAEIE0CrwlXuqoq2kfJRDD7X/WnUo+MdGWkaHD13kxqGqaMLSht221MJQnSkrc0AWBHGHHJ94xJVA2vcJ0FBw3Dv+/AFHwd0VkyOn0wraF+Wz9JVBlmrQudsO9jPzLW42qANYqg3qWF7CP8Ip98Hl3+34G6NhtyMhMyvoY0vhB3ob+F49udaCCCA/AJIzH0KOxfMQcqSvsSjus6JjV8mSdWlo8NsEV+LOCz8vsyr/p6LBHpU4pHd7imuhyxKEQ5NvXJY+eTQxh86vejKiKCKm+ZVdUkPdDi54GJWMf0VBAOlyzgNfqdOuv6G6beMBSF0uMk2PD1nqyJQi2r7bRij92dxgh2btRZfZP3/6t3WerN6Z7Htb8Vzo1cVxiYbZGWSpLKTdPMLnUpbnpZgueiACpstc93V6luYhaNXEqpdIyuevL60/qIkLzurvmMoXwuUULXNYah2E0o5T9zfpHTOsJdre1yHIsYepcH7rw6bl+LXEEPhi/ZoEk7o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(6916009)(40480700001)(7696005)(4326008)(70586007)(40460700003)(41300700001)(36860700001)(70206006)(8676002)(478600001)(316002)(44832011)(186003)(5660300002)(82310400005)(16526019)(2616005)(54906003)(426003)(47076005)(86362001)(36756003)(82740400003)(336012)(83380400001)(2906002)(6666004)(26005)(1076003)(8936002)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:42.3496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef7587c-7d00-485e-6e4f-08db306d1293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
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
Cc: Mukul
 Joshi <mukul.joshi@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- Adds a amdgpu_doorbell object in MES process.
- Allocs doorbell pages for MES process using doorbell manager.
- uses doorbell manager to get an absolute index of doorbells.
- removes a offset calculation function which is no more required.
- removes prototype of a few functions which are not required.

PS: This patch ensures that we don't break the existing KFD
    functionality, but now KFD userspace library must also
    move to creating doorbell pages as AMDGPU GEM objects
    using libdrm functions in userspace. The reference code
    for the same is available with AMDGPU Usermode queue
    libdrm MR.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 60 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 12 ++---
 2 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 423cd642647c..7c6cf3d2c8ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -36,33 +36,40 @@ int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 		       PAGE_SIZE);
 }
 
-int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
-				      unsigned int *doorbell_index)
+static int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
+					       struct amdgpu_mes_process *process)
 {
-	int r = ida_simple_get(&adev->mes.doorbell_ida, 2,
-			       adev->mes.max_doorbell_slices,
-			       GFP_KERNEL);
-	if (r > 0)
-		*doorbell_index = r;
+	int r;
+	struct amdgpu_doorbell_obj *proc_doorbells = &process->proc_doorbells;
+
+	/* Bitmap for dynamic allocation of doorbell */
+	proc_doorbells->doorbell_bitmap = bitmap_zalloc(
+					  AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
+					  GFP_KERNEL);
+	if (!proc_doorbells->doorbell_bitmap) {
+		DRM_ERROR("failed to allocate MES process doorbell bitmap\n");
+		return -ENOMEM;
+	}
+
+	/* Reserve actual doorbells from the BAR */
+	proc_doorbells->size = amdgpu_mes_doorbell_process_slice(adev);
+	r = amdgpu_doorbell_alloc_page(adev, proc_doorbells);
+	if (r) {
+		bitmap_free(proc_doorbells->doorbell_bitmap);
+		DRM_ERROR("failed to allocate MES process doorbells\n");
+		return r;
+	}
 
 	return r;
 }
 
 void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
-				      unsigned int doorbell_index)
+				       struct amdgpu_mes_process *process)
 {
-	if (doorbell_index)
-		ida_simple_remove(&adev->mes.doorbell_ida, doorbell_index);
-}
+	struct amdgpu_doorbell_obj *proc_doorbells = &process->proc_doorbells;
 
-unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
-					struct amdgpu_device *adev,
-					uint32_t doorbell_index,
-					unsigned int doorbell_id)
-{
-	return ((doorbell_index *
-		amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32) +
-		doorbell_id * 2);
+	bitmap_free(proc_doorbells->doorbell_bitmap);
+	amdgpu_doorbell_free_page(adev, proc_doorbells);
 }
 
 static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
@@ -275,15 +282,6 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 		return -ENOMEM;
 	}
 
-	process->doorbell_bitmap =
-		kzalloc(DIV_ROUND_UP(AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
-				     BITS_PER_BYTE), GFP_KERNEL);
-	if (!process->doorbell_bitmap) {
-		DRM_ERROR("failed to allocate doorbell bitmap\n");
-		kfree(process);
-		return -ENOMEM;
-	}
-
 	/* allocate the process context bo and map it */
 	r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_PROC_CTX_SIZE, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_GTT,
@@ -311,7 +309,7 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 	}
 
 	/* allocate the starting doorbell index of the process */
-	r = amdgpu_mes_alloc_process_doorbells(adev, &process->doorbell_index);
+	r = amdgpu_mes_alloc_process_doorbells(adev, process);
 	if (r < 0) {
 		DRM_ERROR("failed to allocate doorbell for process\n");
 		goto clean_up_pasid;
@@ -336,7 +334,6 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 			      &process->proc_ctx_gpu_addr,
 			      &process->proc_ctx_cpu_ptr);
 clean_up_memory:
-	kfree(process->doorbell_bitmap);
 	kfree(process);
 	return r;
 }
@@ -382,7 +379,7 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
 		idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
 	}
 
-	amdgpu_mes_free_process_doorbells(adev, process->doorbell_index);
+	amdgpu_mes_free_process_doorbells(adev, process);
 	idr_remove(&adev->mes.pasid_idr, pasid);
 	amdgpu_mes_unlock(&adev->mes);
 
@@ -404,7 +401,6 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
 	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
 			      &process->proc_ctx_gpu_addr,
 			      &process->proc_ctx_cpu_ptr);
-	kfree(process->doorbell_bitmap);
 	kfree(process);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e7e9dfe44c99..0c659ade527c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -145,8 +145,10 @@ struct amdgpu_mes_process {
 	uint64_t 		process_quantum;
 	struct 			list_head gang_list;
 	uint32_t 		doorbell_index;
-	unsigned long 		*doorbell_bitmap;
 	struct mutex		doorbell_lock;
+
+	/* process doorbells */
+	struct amdgpu_doorbell_obj proc_doorbells;
 };
 
 struct amdgpu_mes_gang {
@@ -364,14 +366,6 @@ int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
 
 int amdgpu_mes_self_test(struct amdgpu_device *adev);
 
-int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
-					unsigned int *doorbell_index);
-void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
-					unsigned int doorbell_index);
-unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
-					struct amdgpu_device *adev,
-					uint32_t doorbell_index,
-					unsigned int doorbell_id);
 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev);
 
 /*
-- 
2.40.0

