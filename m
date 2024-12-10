Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB514E77182
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 18:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6512B10E94F;
	Tue, 10 Dec 2024 18:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EW/dq+fv";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3AE10E94C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 18:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4wARA1+a1V7LqFFGmmrjRKWpsDm3cOTkotEGM0vlNL7CXfBwWLQlEFpBGjUNlrl73fUlaurpiYi/74NowPi2/jCQ0fbqhwJ59ZSRHm/orCLD12SiFziKB8H1sMxPLXFnxCWgWTpRSsGPHmSQKfMFLjo3mq5UwNiMLaiROFbwsdnFgfDohiKg/YHPmKEEvJicofO8VK8Kz779lamD5mheVNI82JuVvFa8x+9T+2D1KQVNeOilAAK9QOZBgW1Fw9735Gvn/1aNU9CEhLWy8qhT8B+0GQCC86V0H4BsA9UPY7q+SadAIG8qqhMi0FrP8E0m0mIEble8ONnwjzuqwIgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3QQ4R7Ctr5/7ZKzdorMpieHsMWBqtOSJXB6h9zoqH8=;
 b=sZrtS0E3FLfCkarCxyy8ak0lNorpbjDZ/ykWSYDGhTUbsQr6n9i3Njs5dhFfKeJjf0awa/0DkyOOX7ci0+32X0O1XKifb4pDnc2Y/qingMhHaHyBHpVOLH+FK2kj0Hv4lHd7GpnIhxck4Kegx93TdyGRRQ3n0BWeKOhM2zFBJ5+tnevCqGbvpEp3F8gl3aXel7EJn4yDnf+dYB0LK6qkmugst8RXF8FN1HAxg+Z5HeyskNCXhBIDcNMtc7lpOXdqlFdjNwrMY3TOMUYOa+I0jnWx+HLUxIXuNQfi0TswAFHWQXQODk3c0oFLlyHViH/DYoWuLAqdrR1JhJp4XTQNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3QQ4R7Ctr5/7ZKzdorMpieHsMWBqtOSJXB6h9zoqH8=;
 b=EW/dq+fvMP+Q3QqEJGQGVkXIzeJx8oL7Bphi6ASAyYnuUI3pM4GfWu6xPVKuqhm+/BBisL2QoI9LF4GzKoZEcx7cEPYb1E4KIwAXsA2lJUstk6tPGMt0n3EYbJdo4rXeUbPoH7GmCd8j83oY9ZQyHKVN6OsxZ4ATye2zkT5jaYU=
Received: from BYAPR11CA0065.namprd11.prod.outlook.com (2603:10b6:a03:80::42)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 18:00:12 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::8e) by BYAPR11CA0065.outlook.office365.com
 (2603:10b6:a03:80::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.20 via Frontend Transport; Tue,
 10 Dec 2024 18:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 18:00:10 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:00:05 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v10 5/6] drm/amdgpu: remove unused function parameter
Date: Tue, 10 Dec 2024 12:59:38 -0500
Message-ID: <20241210175939.2498-6-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210175939.2498-1-Yunxiang.Li@amd.com>
References: <20241210175939.2498-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 058aff4e-7541-4eda-23b7-08dd19447d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVdBSkNnUVQyUmd2aDcvZG9lRXNiNnlrSmZZVzNzb2RFckEzTS9jV053aFR3?=
 =?utf-8?B?ZVFWYWtOcmxNSWdYWFlMQy9mZnB3NEE4MnNQYWN4eUgxcW9OWUYvRmh4VWJ2?=
 =?utf-8?B?Qkt2SlZHZ1N1cW5TWW5TQWE5cmJGNmNNYzMwVy95UVRJSlNrQkdaeG1HVHZY?=
 =?utf-8?B?bHZ3cEprUnVJU0RmTEV0bSswb0xHNU41Z0xxK3pxRjVVNWRlaW9rVit6RjJK?=
 =?utf-8?B?K2RnbUs4QlhqVUhqcDZxQllJemdIOVJOak80azhvMmJRbjVOVUhuMkNyVzV3?=
 =?utf-8?B?ZUNKVTgrd3dXOVNpb0lJaTc3MnhCcFZFdmlnSGpkdUZPUDdNYW9hc0JWN3lD?=
 =?utf-8?B?S3J0Z1NRcTZsVHhiMDVnTFdTWFZoV3pCbWNUVGloL01vUDhXMEdodWhFSDF2?=
 =?utf-8?B?QUxmTFVkaWhSMEdha2JLSzc4KzRyc3VKald2WHdETVI4eXZYeXdhWlRhRnI2?=
 =?utf-8?B?UC9Ic1h2SXgrNTUrbWtncFdxRHh1R3djUlBTQUJONi9SeUNGeUpqbytYL3lw?=
 =?utf-8?B?OFR1dlRkQUZqRkdkYlpTSk1lNXZyRGM3ek5rK0wvQ3ZpVjhoRWMwcDZwVGQ3?=
 =?utf-8?B?b2xHTTdOQi91Rk9oTFZ2cnJxa1BMNEdja0tWajR2TXBjcFZoanJvYmZqOURS?=
 =?utf-8?B?TDFuZFdNWm9kenduTmMwVUp3bnBuOUFnR3lsUGZheGlBTDVkMEE0dDFxcFRO?=
 =?utf-8?B?RnZnUU13dEFJRVZLTlFHVmRFd2Q1bTFkMnIzcnBnN2dlNVUyK3dBNzBrd25r?=
 =?utf-8?B?ZXVnTnBTNjNxazNyNHdaVWxQYk5yS2JMaGxMb0NKeko2SmRyWW1CSmxRWk53?=
 =?utf-8?B?U200OW1ETzFtc05aNncrTk1SS2FvUFlRWS9HejJMbTRDakdEdTZJcTBpL0xk?=
 =?utf-8?B?VE9yNVJSSDFvYlE4SWRISktBRU5XbTlzMjVhSXd0Nmt5UjBWSkVFdnRCRGxL?=
 =?utf-8?B?VCtQSUFYMEEyTUxIV0pMT0w0RmVaTnZZZFVRZ3pSYmQ0aWFYQ1R5RGFpbG9w?=
 =?utf-8?B?UEZ6aTdud3JaR0NRSXcwcGlQS2JZQU9LYklVempheTQ2K1RFSGdQUGpLY01h?=
 =?utf-8?B?T3dCVnZyZ01tNjUrZTZkaDNEVmpxOUJXdEZXNzJUOG01UUxGUTZJVHg4aGNV?=
 =?utf-8?B?Um41T3lSdWh0MW0yRkNUb2VPV3RoYTNHV0RmbE9USTNUWlowTzlHWjdaMG9a?=
 =?utf-8?B?Rkw5OWxETUpHdTVWY2lmTzNUOGg1WTR3cElNWW9saVpNZVJPOTFIeUtzTEJF?=
 =?utf-8?B?dWZjUExlS0lOVDlmVS95blFBNC9TeERyRVcwanVONVMwRk5WZVFhQjdCYW1F?=
 =?utf-8?B?VUNnODdwZHczdysvcTJaelhUYlNOTmdNQ0xJQVE0M0tTOC9CMW1KYXVmV083?=
 =?utf-8?B?d2tMTjdGUGM1WHR0a00xQVpQV0puQ1ZJQ0ZFY3h2VjRHT1N6NnBmT1QwOUNz?=
 =?utf-8?B?SGtaajRWRDZBN2VDQkZnMFh6MWcvOFNYOXdRZEExbFVKZUQ4VUc4c1VsOFZX?=
 =?utf-8?B?TUMyRkc2dXZWc1ZuTDFFVnBkcXZxQ1RnTVU2Zy9HNkpHU0oxa3dpRlFSNzhX?=
 =?utf-8?B?ZHJxakFXckF2bWtXSnJrbEYydFBhaVRLM0htK004cUl4dUpjR0FmTFRhNENj?=
 =?utf-8?B?RVFENjI0QlJ3a2k1czA0dVlJMUtXWW1VYWx5T2xYbENzOU1CRXhacG14LytM?=
 =?utf-8?B?cysydG5aYmg3Y0FOUzF0Q0d6WjBTVGxQejZJZ0pKUUdJNFhsbmRpMUVDbEFm?=
 =?utf-8?B?cFpWejl1RW9ZRWpMQ2hnaElWL3hJY051WGk4SjEzVUltSjlIMlFJNGtvQXRw?=
 =?utf-8?B?SzRJT1BSTTJ2VGpmVFhoTFZ1UXUvNTR2WGRQT2g2NEhENWhxRHplZ2d0WTU5?=
 =?utf-8?B?Vm45K0lkWVRUdzJ0TVAvWlJVd3NnclZPMk9XaUthaVorbGxyak9CdnNlZlps?=
 =?utf-8?Q?Tism85eAPjeaKHJDXDdw8Qy1iuzAjpq1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:00:10.9263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058aff4e-7541-4eda-23b7-08dd19447d85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
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
index 5df21529b3b13..5cc5f59e30184 100644
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
index 57636dfd77a8a..88173bd1f9a2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2144,14 +2144,12 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
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

