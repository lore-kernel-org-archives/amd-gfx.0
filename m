Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2BDE81A3F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B95910E3A6;
	Mon, 16 Feb 2026 15:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E3wcvPq8";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4140910E3A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMhKs1P+9YgPAoLpSrKQ0t5tbrU5HcM1KNmuPuhcaZsE/xLc53I5P2YQUISvcaxDYZstV0pWVmSP6GxvcnVo1kCTXZzAX9llGifi0D1MjzVUB2gVWEgSiN+B8/3adzDtoAXwKHO4M5Z+ElCmjxLsFt4Gt4hxytn9FP4Js9pto4/CKU8BRvWCtnfr+AiPvFYpeM0QxET3JXJgld5PW8ptxNjDR8NgddibDSfsC/GK8GRHrsoz3sZtXXipUo4fKVnvQLp+pvW033twvG8o3z+7pLTUGmgd7Yif18Z1mt03aLI2W4esUhFogFUUzVic0vGhSO/fQJvUOPleST1yWRHXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4CQcSg+uI5/B26XYyw9wZQa9894veTIJSKPVgrlRus=;
 b=UQKOSqc2xpc08kRCute5ImwEiNY+Vp7qscyuNDHmsF/dt1G1HT+xk/d/AIkS47CexPTE4qy6RY4j283sE2iw5o1pOYvhvSnTpNCr0ooGZIEjBiP/IyC9m7GzzLkqR3wSprzSEMskj5LTc8y4XnhdVd6iBFFneOACnZdBXB8Sv8rLw93S3U1tZLVHcPeq09cybmllLBwK04sS5L58hUU0Yj0/qLjDI9gRZxJuwqruv4E2GBCbAtV9VNV8mQWzphZh9O73F3qFHfYRNxMxku2qFjyF0q//2GSKiT1ipDDcXkdr0NrRvG4wkpmMZ6r+WMnClntk2hwgejMtyhgLj6sylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4CQcSg+uI5/B26XYyw9wZQa9894veTIJSKPVgrlRus=;
 b=E3wcvPq8AMNEtyJR5KkrZmq7wIPnHc1Kpfi/wydIaEioaGMggFK0mgUxiWjWglcKibHdEVadukIiVKecDasp6TRMCu54p5c/HeueF5LrzWckWkvChbdgDvssqXHoDnD1tMmJ42kRjRBcR4dFQJhZ5uv//quVufbNebZWORI70qc=
Received: from SJ0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:33b::14)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:50:13 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::49) by SJ0PR05CA0009.outlook.office365.com
 (2603:10b6:a03:33b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 15:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 15:50:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 09:50:07 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2 4/8] drm/amdgpu/gfx11: Wire MES EOP IRQ to render-node
 eventfd
Date: Mon, 16 Feb 2026 21:19:39 +0530
Message-ID: <20260216154943.1582412-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fb4004-7608-49af-c175-08de6d731255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3FqTE9qZXpxaVVRMVFtM25VSVplSEVjei9OdzBHZURRR09yQlRMQ0w2cUpn?=
 =?utf-8?B?VFMvM1FVb0JsM1JHQ3NRV1k5NDhkclE4SDZCY2F2bXNGTytWM3UzNDltM2Rn?=
 =?utf-8?B?U280MWJxNUMxODZya3FWY2Nwc0pLeVM1Ulp4NHo5UTlZVUtPaTBJTW5sQjJT?=
 =?utf-8?B?a2l4cDNGYSt6TFJjUmthRlhHaVBOOHQ1N3h6dWlCVkpDdE1hR3dqSkcwRVRk?=
 =?utf-8?B?MmxPQUpHTlBWYlBhMnBOS2l4Z3NnR1BOOGJKOFhtbVFSY3JuV2tuU3ZqdTMr?=
 =?utf-8?B?djF4bmJIRFNZaEtzVTNmYWFJV3F3ZzVGUXIyb3M2a3BhM1lyR05UaEx5eUFq?=
 =?utf-8?B?ZW1welJqL0JuZFloUDJNOTM5aGR0cmVkcmZBWVhBeVRDalZhZXN3TWl0Um05?=
 =?utf-8?B?MUZSWnUwOWJ0UnRJMHF1SDFST0tjYS9qZ3V3Ly9iMmFPK0s4T0JuV2R4em8x?=
 =?utf-8?B?N0F0eE03SDluL29xcXFacGt0aUY2dk9oVWpCckR0WFU1Y2VlVXJEbHVJTVFt?=
 =?utf-8?B?Vk9oOURqUkVmQ0prVzRtdFdhLzN5SmVwOWprNlZoUlk2ZHZoZ0tJQnN6R2Zs?=
 =?utf-8?B?RmI1SnpQbE8rRWovUDhsYm9aTkRYdTVmRDVqa0dzeStCN0R2WXJlSkZpc0ln?=
 =?utf-8?B?dTBNVStCTkVUUnJFcm1ZdUd1dDMrMVkxUGpGa2RnS0pqY2RCbWs2ZGlKSWpX?=
 =?utf-8?B?ZldHVSs1UmNjM3BXZWVxc0diUDNGT0RSMFU3S2Q5Y2pCcWlYWXhrYlFyM3ls?=
 =?utf-8?B?NlE4cXY3OFl6anFlNEZJNTFTc1ptTDB5V1cvSVdTTytreUhHZDlnRTVXMkRP?=
 =?utf-8?B?b010US9ML0llTnQxM09meWtQNVRuMnlOTUlSWDhqWDJLdE0rWnlHQityMlNH?=
 =?utf-8?B?VDM2SjVOQXJFazBKUlZoM0hOOEl0R05ka0xWd2owanBUcy9WaUY1VVhEb05B?=
 =?utf-8?B?R1RScURBYURKcXRuWVFJalZGYUljMEMyOC8vSi9FMWs3Y1pOa2lnajRXSE9x?=
 =?utf-8?B?OXZNNGFacUdkMkZHT1JtYmxFanBXMEZQRjdyb0tkUGFZNUs4S3lDdTVpSjlU?=
 =?utf-8?B?ZFZJd1hrVklIbUljYVByRFlSb3pJTUhTdUFhOHJ1Z2dkcXFqOFdyOFZ1THBi?=
 =?utf-8?B?RmRsMXhiQVRYemhRem02Q1VBeTZkSnNsZUYyazk5akY1bzFBUS84cml2UzM2?=
 =?utf-8?B?K3QzSGxvNzRQbFJINHQwSmhWZlpxeHhhZldVT0tUOURjamdIZEp3MVNUZWlV?=
 =?utf-8?B?dGMvN2RkS3JkVjdWRkNQdVVPV3ZkS25KeVpObXRvUzVaRGpXTVNPS05mU0h3?=
 =?utf-8?B?YXk2Y1JtTE5OaHg2WWNBN1VOSyt1SExxZWtWNHA0d0NIR1h2QjR5bUVRTER2?=
 =?utf-8?B?VDExUUlxU3ZLVnVOZjlaU0IyZnJ5OXFvMU5HQkFCcEJjR1M2NGdFVDVGUzVD?=
 =?utf-8?B?dXVGQ0drUUJlT3N5QmZmbzBrNVpBeTIxN0xDaXVtRldPeHgrWVN3WWVhWHVI?=
 =?utf-8?B?a1BIRlBWT3NVQVdZR2I5YkdWYXkyNTJmNC9UdWRmSVFHdzg3emhzQVNDZFZo?=
 =?utf-8?B?WEgzQ2ZzWmNhNVptcDIvZ0pDbnJBSlBFeGdSR0tNRURRY0hOZHJJOWhzbzEv?=
 =?utf-8?B?cTVhZWx6SENOSlpWNFZTQWo4YUtPM0RLN1dZMUk1MUZ4S0xxVFUwdXNEM28x?=
 =?utf-8?B?L085eUpKSlJQcXMvaWdrSzN1SjFsRm5oUDZuMU1jd0dGRHF1a2w0TzlzVmN4?=
 =?utf-8?B?ZXdtclFaTVM3ZkZrdmJjOXRsc0laNk95bldRaUJVTis1K3AvNk16aThsZm1Z?=
 =?utf-8?B?dCtwSStySVN1aUNmczhXQ1p4Q1Uvd3VEZEhXSFJEdmhONC9COWFBZktYV3Yy?=
 =?utf-8?B?bytMYTk0S0RvRWViL2JDSnJFaXd5dDRWd0lObmVLc1UxdUxJS1Z3R0pJWDhh?=
 =?utf-8?B?SDNuSFB0YTRIUGxBdHYxRXo4NitUd3VEcDF6T1A5bHoyYW9zZll2ZTc0bGIy?=
 =?utf-8?B?M2lJRm5JbkFUSlpGQmNOQ0w0elZQcE1Nd0prN0YrVEM0cUsvTzB2ZzYvSDZz?=
 =?utf-8?B?aFhaYUZXdllzNVB2TjNvMlUweXVIWk9vOUhLRnlqWjlZMVRXWXhpaFRUZUZs?=
 =?utf-8?B?azB5dWtURHMxOGxuN1YyS1I1Y0xuRXpONXh0SXZjd29IYUhOc1JwYjBiL2JN?=
 =?utf-8?B?RHpPb1c2eW1ENWU3clQzVSsyOTRYajRnbkl4d2FZa1N1SEhYc1RnbU9XR203?=
 =?utf-8?B?Zi9xY0VNYzBvc2JaNTZqMHJaYSt3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ogf2mVCmSUlwlVQn3J4ln3/Ytk+tXHciioxTKrZM1nwXE/B8vHQfy0RXhUqoBaoNm8v+eYBxtdanH51LkFgeAJkGlLnU9kxY4CRMsspd/C2ouHxF46lWGQWpNX1afj9S1SiYw4Eags4vXH454N6llyWizauNDtbNtM9af5LFmjuNaK8O1PPdUsnkPUQawsYZiq/qeIze4jBES8obJ9WyZ8q4+arBJv7BwXY/2oLzgz5j0buS+89vzDWx2DWoq7GBvIEz4Svodbu9bDRH/P2wIb2RHJgQ7r+BU7JPapWK4zGvqFH/aMw73kQO6d8IByuQNg4igckqBXsf42jSpC+yMDIrNgV3InWQoy/+mkS/BEJH8OwDVxGtphka+XfUlp1Gvyefq/BrSoI62CCTb9g6KkYNI2XuXd/zrzHvB/ijWAsnTe20U3u3BWja5XjszPcy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:50:12.8645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fb4004-7608-49af-c175-08de6d731255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939
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

Add a minimal producer for the render-node
eventfd subscription mechanism by signaling a fixed event_id on GFX11
MES/userq EOP interrupts.

To reach the correct per-file registry from the IRQ path, plumb the
originating drm_file's fpriv into the userq fence driver, and in the
EOP IRQ handler walk:

doorbell_offset -> fence_drv -> fence_drv->fpriv -> eventfd_xa[event_id]

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c          | 14 ++++++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b700c2b91465..a3a38efdc3aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -820,7 +820,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	queue->doorbell_index = index;
 	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
-	r = amdgpu_userq_fence_driver_alloc(adev, queue);
+	r = amdgpu_userq_fence_driver_alloc(adev, fpriv, queue);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
 		goto unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 212056d4ddf0..507defcfabd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -76,6 +76,7 @@ amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
 }
 
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
+					struct amdgpu_fpriv *fpriv,
 				    struct amdgpu_usermode_queue *userq)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
@@ -102,6 +103,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
+	fence_drv->fpriv = fpriv;
+
 	xa_lock_irqsave(&adev->userq_xa, flags);
 	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
 			      fence_drv, GFP_KERNEL));
@@ -192,6 +195,8 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	unsigned long index, flags;
 	struct dma_fence *f;
 
+	WRITE_ONCE(fence_drv->fpriv, NULL);
+
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
 		f = &fence->base;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index d76add2afc77..8fa444a07f77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -42,6 +42,8 @@ struct amdgpu_userq_fence {
 	struct amdgpu_userq_fence_driver **fence_drv_array;
 };
 
+struct amdgpu_fpriv;
+
 struct amdgpu_userq_fence_driver {
 	struct kref refcount;
 	u64 va;
@@ -56,6 +58,7 @@ struct amdgpu_userq_fence_driver {
 	struct list_head fences;
 	struct amdgpu_device *adev;
 	char timeline_name[TASK_COMM_LEN];
+	struct amdgpu_fpriv *fpriv;
 };
 
 int amdgpu_userq_fence_slab_init(void);
@@ -64,6 +67,7 @@ void amdgpu_userq_fence_slab_fini(void);
 void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
+					struct amdgpu_fpriv *fpriv,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b1a1b8a10a08..b06adeeeed2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -54,6 +54,8 @@
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
 
+#define AMDGPU_EVENT_ID_USERQ_EOP  1
+
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 #define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1	0x1388
 
@@ -6489,6 +6491,7 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 
 	if (adev->enable_mes && doorbell_offset) {
 		struct amdgpu_userq_fence_driver *fence_drv = NULL;
+		struct amdgpu_fpriv *fpriv = NULL;
 		struct xarray *xa = &adev->userq_xa;
 		unsigned long flags;
 
@@ -6496,7 +6499,18 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 		fence_drv = xa_load(xa, doorbell_offset);
 		if (fence_drv)
 			amdgpu_userq_fence_driver_process(fence_drv);
+		/*
+		 * Read fpriv while fence_drv is still guaranteed alive under xa_lock.
+		 * fence_drv->fpriv is cleared during teardown.
+		 */
+		fpriv = fence_drv ? READ_ONCE(fence_drv->fpriv) : NULL;
 		xa_unlock_irqrestore(xa, flags);
+		/*
+		 * RFC: notify render-node eventfd subscribers for this drm_file.
+		 * Mapping: doorbell_offset -> fence_drv -> fpriv -> eventfd_xa[event_id]
+		 */
+		if (fpriv)
+			amdgpu_eventfd_signal(fpriv, AMDGPU_EVENT_ID_USERQ_EOP, 1);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
-- 
2.34.1

