Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9956ED70DED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 18:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0541B10ED42;
	Thu, 28 Nov 2024 18:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="stUZAlWJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FEB10ED38
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 18:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChkaSljVMbKZLcEPXlzQr2HbjX9sKxAPWmDRFnBPFV0a+qSnJ4iK+pIPwHYdCzfb8yFmPYgeM51quDv2BapGFejPA0+562m6LqujgufHC6wFN3iv5EmnOuLuKFo+FTdhEgjQQTnIRruMqw5Tone77WQW4fuQVj441Paqczq6/klUFnSe+CgBHpSs7cmU34KxTxS67m6HQZHt0itRwzkAkYM4RETfe5ccBVEwiDRD2Vr5r8MbJ9SXxbeoJlqLqbBRTCxh2hRqbwGsmLh7xIm2BjYL4QT8pd7oEB7C20l8hnLq2bcyoz3UnY0YgGKtR1e4bm8x1m/7uHNzEgrzkyYlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yqdzn3NaZrIx3NZ3RUH2iJKU8aguse9opyXpOpHlZEA=;
 b=i9b176Y7Pr65Dxu0msm4vhBB9Sit8ewS2ClES31LhJztLtPnNAGKurjyfM7hk8tMDGvO8DQJDIyz0nVVsGyF9C1fiO7gN0nN1tBxE1nLiP0efuTC1zomhP+0OfHNrBqjBoyYjeAXkk3mUo0McCdTA/5Ko84JbbExVVqxj0Zk7L04ltWbfgPG8/WKwBQnBSXJo6VlDUvnZCz76n6MSaCsSbqg7ONej0uxHPIBZ3HtxvPlkMyOLhS87Nv2uNv6DMzbXvgO8JTPDul76vSgum3VNXwH42EDoW0MXYOht0/4O4xxChApJmpvXFRyNlphpbthooZAEnIuOv5sFM2x/dPVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqdzn3NaZrIx3NZ3RUH2iJKU8aguse9opyXpOpHlZEA=;
 b=stUZAlWJbMrHvCt/6W2Nng0yhD7kSJ5/8nRzCyxGCsbkXQ/aGIlBbZhlBN3A3eyWSfXqIzlJSx7BoACbQzOrgqV4Tlnd0Ltem3MqmqSNsQgO8MqlQyIONRr4Vz8urCvGgYkKKD2fmHAABhfZ3YFStkVM5hgBM5GPBb/l/lJ5+wY=
Received: from MN2PR02CA0013.namprd02.prod.outlook.com (2603:10b6:208:fc::26)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 18:54:29 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::61) by MN2PR02CA0013.outlook.office365.com
 (2603:10b6:208:fc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Thu,
 28 Nov 2024 18:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 18:54:28 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 12:54:26 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v9 4/5] drm/amdgpu: remove unused function parameter
Date: Thu, 28 Nov 2024 13:54:03 -0500
Message-ID: <20241128185404.2672-5-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128185404.2672-1-Yunxiang.Li@amd.com>
References: <20241128185404.2672-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d17430-3014-492e-de37-08dd0fde15fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M09FcS9mZTZlOVFUSkx0YjBtQ2E3YkUzbUE0M01zSW12ZHZkZTBnOGdmdU1n?=
 =?utf-8?B?bVg4bkNtakp4VmN1YWxCL3NSVzZxNkpkZVc0WDVyVTc0d1ZkNWV1V3lxakR3?=
 =?utf-8?B?cWUrOFZ3R1RXMFlXKzdDSmRRT24xdDlSRHYzY3lHeVlaNVZwSnJ6L0tKUWpa?=
 =?utf-8?B?dWZTcHVWVC82Q1lpWm8yWW5USm4vYXJSNVRaWnJwWW5oRU5OYjNaU2xROSta?=
 =?utf-8?B?RlpSYW42cTFHdHhWVSttOERRWmxTTlRZUVFyUy9uekIrcjkvU0dEbVFBNDNF?=
 =?utf-8?B?OEJjNFNpRDU0NTNFbkhQa3ZTRFB2UTc3cDA0dG5VQnJMRitVdlI2aEdxT3Yy?=
 =?utf-8?B?eWR1N05wVHU0YW5UR0FzMUl3YjRjR3RXdWlielBmcGNOVFBFdHN4ZWNoVWdC?=
 =?utf-8?B?TlQwT3ZoK3htalROdVpWbVBCMWZ4cnRSd08xNGJlYmdWWXpUamhjWlNuT1I0?=
 =?utf-8?B?cm5IQ1pOK3JwNTVjM25GRVl0WDZtZTRxemhMQUE5azh2QkpsR1QxTklvZkxs?=
 =?utf-8?B?eFdXZ0dVZmx3eXBiWGE5Z3FvM2JOWnZQTXJwLzhKOG4rK2JUd0h1UHdubjZo?=
 =?utf-8?B?b21BOTZST094Si9FYWxtU3UyVzVOa1FQY2c1cGN1ZG93NmZYWFcyMDltN2pN?=
 =?utf-8?B?eUpTbjFTTFBZN0hCSFUwZXBtc2pNcG01UWl3U1V2VEp0LzNDVWNJbkxJWmZO?=
 =?utf-8?B?RlI4TWs2TnpSM2s5b2hKa2ZmQmwzOVdsaTRiNmNtUWRMQ0FPMEZaQ2NoeVVv?=
 =?utf-8?B?WkNVcVpxYThJT053RWlBWjFaaE1RZnIweWI1KzF0YUNnaEtOUnJ6bnZvQ2Zp?=
 =?utf-8?B?N0c5aWdyaUZBVkwrN2xZQktNV1ZpTnR6dzRBWnpsSWtSRVpYOGxGb1Z2NFhL?=
 =?utf-8?B?ekNpUTdzQTlTZ0JpcjVidURPdi9Qc0VmbnBXdUN5MDBjSUxFOGpZbU9ZZlFU?=
 =?utf-8?B?QnBnNzlTZEx0L09Ic2hhc3hQdFRqZjZIOWc1WlNQMUFnTTU5ZWpyd0dyK2xV?=
 =?utf-8?B?ZnVadTBrcFdHNFdkTkczWFo2Q3pPSERuaitSRmlIQ2Exc2UxT1B5TlVGT1Bn?=
 =?utf-8?B?TjNmbW9UT3lyR2xTRTR3Q0p1UDd6TUlnQ2UvKzZXR09Xb2hnQWZQeTRQRTJ3?=
 =?utf-8?B?cGxNWjJoRnlyZyt5alVHUUFtM3F1bWhYMDhXUTY0aE9wK0pPSEY1T2ZiUEFz?=
 =?utf-8?B?V2NFUmVKLzFWNDQwTS9IMDFqbG9teTFUZjhBRk04bjdHK2JqWHZnNmRvZi80?=
 =?utf-8?B?RzFRSFA4VDJMckk3VHZjbmhZcDZWeHhEMEVYZE50cWN4YVBPQlZ6NzRKNE9W?=
 =?utf-8?B?VFE2Vm9OT016SkhMOHdBQXhZVWlYTHNpcUs0TGlGczBWaVN2Zm9kZ1luMmJu?=
 =?utf-8?B?RUl6ck1DWGNDaUpvY3QzVzJUUWNEZjNYakFwRzRPUjlhRzAxTElVc1ZaTEZj?=
 =?utf-8?B?RlRMZFB2NUhNbGcxR2tuMEh4NzVPWUZuZVVRelJacW1CWDJ4bEh6Q1UxTmhs?=
 =?utf-8?B?a3lYcktjNGFIYWJWTm5yRHp1N2pUY1ZUUk1FRDVsejdMYnF0bDhJVnQwY0xl?=
 =?utf-8?B?ZUZyTGN0UmQ5UWpZV1R3VWRCa09DVUdNaXRieEEwSWt6L1lXdUE4RGxZMklL?=
 =?utf-8?B?YVpnb1JoZmlmWGd5TnRRR0JNQkxUdUZkdEtFYlA4dEQ4Uit5UzhTVnFIMUhx?=
 =?utf-8?B?VWhkakd0RGR2d0d4c0J6cTQxOGhXajltYTVOVTVvcWpRQzgxMTJYMTlsMW4r?=
 =?utf-8?B?S0RYSm44dk51T20xcXl1UFlyVDFCNjQzLy9IOWQyZmxrYkNkdE9QMjJEZVo4?=
 =?utf-8?B?WWFROHdiTW9zdjQ2eGlzMWhXMlIzbW1UdXkveUtBdVRvZGNDdmoxRU5TTFdF?=
 =?utf-8?B?MDRQazE1M2RNZy9ZYVMyM1B1T2FrOFcxZnhiZlB4NzgzMGhoZzc1UkZUWFAv?=
 =?utf-8?Q?nskD+yie6B0XcnCkao8eSEmpHJ0fM2qz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 18:54:28.1812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d17430-3014-492e-de37-08dd0fde15fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071
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

amdgpu_vm_bo_invalidate doesn't use the adev parameter and not all
callers have a reference to adev handy, so remove it for cleanliness.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 3 +--
 6 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d891ab779ca7f..471f3dc81e8db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1105,7 +1105,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	 * We can't use gang submit on with reserved VMIDs when the VM changes
 	 * can't be invalidated by more than one engine at the same time.
 	 */
-	if (p->gang_size > 1 && !p->adev->vm_manager.concurrent_flush) {
+	if (p->gang_size > 1 && !adev->vm_manager.concurrent_flush) {
 		for (i = 0; i < p->gang_size; ++i) {
 			struct drm_sched_entity *entity = p->entities[i];
 			struct drm_gpu_scheduler *sched = entity->rq->sched;
@@ -1189,7 +1189,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			if (!bo)
 				continue;
 
-			amdgpu_vm_bo_invalidate(adev, bo, false);
+			amdgpu_vm_bo_invalidate(bo, false);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 8e81a83d37d84..b144404902255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -345,7 +345,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	/* FIXME: This should be after the "if", but needs a fix to make sure
 	 * DMABuf imports are initialized in the right VM list.
 	 */
-	amdgpu_vm_bo_invalidate(adev, bo, false);
+	amdgpu_vm_bo_invalidate(bo, false);
 	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 63e2cb1ab56ea..fe7ae45500639 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -977,7 +977,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
@@ -1037,7 +1036,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			robj->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
 
 		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
-			amdgpu_vm_bo_invalidate(adev, robj, true);
+			amdgpu_vm_bo_invalidate(robj, true);
 
 		amdgpu_bo_unreserve(robj);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4f057996ef35b..951b20e40fd35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1251,7 +1251,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			   bool evict,
 			   struct ttm_resource *new_mem)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct ttm_resource *old_mem = bo->resource;
 	struct amdgpu_bo *abo;
 
@@ -1259,7 +1258,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(adev, abo, evict);
+	amdgpu_vm_bo_invalidate(abo, evict);
 
 	amdgpu_bo_kunmap(abo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 68dd4130b5ad9..d0db155a9ab7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2143,14 +2143,12 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 /**
  * amdgpu_vm_bo_invalidate - mark the bo as invalid
  *
- * @adev: amdgpu_device pointer
  * @bo: amdgpu buffer object
  * @evicted: is the BO evicted
  *
  * Mark @bo as invalid.
  */
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted)
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 {
 	struct amdgpu_vm_bo_base *bo_base;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 5d119ac26c4fe..6a1b344e15e1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -524,8 +524,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
-void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
-			     struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
-- 
2.34.1

