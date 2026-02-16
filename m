Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE54E63F3D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 09:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B2E10E1C3;
	Mon, 16 Feb 2026 09:45:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IOq6AwHz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E4110E1FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 09:45:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqYaBQwyXCS1Un+M/m/5fKyzQ6UjxlFoVfXseCVnljtKOkvORNQKj4l2/UDBtOxZ8APgu8rNEuKtmtsoOhu59p+9jA7I+knIffmUoo1G5ex7P1jAqxWKPAEQ4/cDS16HNdTw+uLSU4qxn5ypExykyAXYOQVL4VH2IvLyGKORZ7yVocoO7RIdvBkaXkCkrr8jIS0Uyji9PorbL9WEXNm9mZmX8VNHVp1jP0To1ZIyuQYx+qpvY67jtDdQAo/4RQrpjcBwvzYdzF+PXQPPQg/xrhIVlxK0YXP8tCu2Z3XqWDLR+0OGoReXeVruLNmCe2BqSUhxaOjsVtWsNWw5RGkmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4CQcSg+uI5/B26XYyw9wZQa9894veTIJSKPVgrlRus=;
 b=vYRIt6+lQ219Ltkq3Nke2bOk0dcFY2btpbYOQNbn5kiPX3bP92W3VG95gL8lRVmymad22qZ8VrFfs6svhddUxYaGSXbmYGnjQMxTnuxIyuSrXi30UL1H3/DWi4FdRtlKVas31GQTbZBwTdUHtuHDXJ2UsOCGb51XIPQSEmOdndVkwUCRj+T9d9HdOt43EqngLdBCVEkVXIZpEbKW6el38GhoXzjI247RCX4S9PVG1FF9KfeamMXVUeBRCsDnuxRodBqvYcfW/NQ9/JzV8JF4vZw+OKeF+egt6+1iDcrwsxm9/V5+xtUolWXvwDdSVeixZHkzbELyGWhR3kMR15icNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4CQcSg+uI5/B26XYyw9wZQa9894veTIJSKPVgrlRus=;
 b=IOq6AwHzejgfG7F0+C1HQc/7+p8Xl0mFyvBLZxndDZGAneL03w0GGcGQ1/Mv0rHMp8qYEsVGk3aS/BnBxGOFpO0rk7b2oqJYNw2YguUE4ATrRH5mH9BQj2chT5M9AGsZBYEAcQHUeDpWWcdgMMpbF2j5v8yISVsS/tEJlpnIkRs=
Received: from BL1PR13CA0328.namprd13.prod.outlook.com (2603:10b6:208:2c1::33)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 09:45:38 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::31) by BL1PR13CA0328.outlook.office365.com
 (2603:10b6:208:2c1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 09:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 09:45:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 03:45:36 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/gfx11: Wire MES EOP IRQ to render-node eventfd
Date: Mon, 16 Feb 2026 15:14:47 +0530
Message-ID: <20260216094447.1581407-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216094447.1581407-1-srinivasan.shanmugam@amd.com>
References: <20260216094447.1581407-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: a37a4229-c0f5-4dc6-1227-08de6d40240a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUVLc1NraHpDQjFsZVRQZU43VmcvMWhHK2g5N2Y3Y0lXOFU4TTl1OFJ6K1hK?=
 =?utf-8?B?b2ZldjNmUVZWRWdFemd1TjNaSEZHbVRiWHdvMWwybXU5MHY5QUszZ2xGZHps?=
 =?utf-8?B?aWM1RWVvMWxFcmxYSHNwbld5WEVqblVJZkk4YU1mdUVXYitYUVRNTlBzM3hH?=
 =?utf-8?B?VjBGL0VLS0g3UWZQdGxOL3hjbUt3a1lnazYzQTJqa2ZMWEtkemlFZ0QvQWdH?=
 =?utf-8?B?eSs5WndXSk1COHFRNU9QSTlaaGRhb2dSdUNOaEVTelNMWjZybThvQ0VoNFpa?=
 =?utf-8?B?WmQyZkpCdHlFNnNHbGh2TE52MUFOeXREUU1NU3JMUFU4czZXVkgrNmtteVkz?=
 =?utf-8?B?RmEzeTFpczRnR1FCMGFaY1g3V3laeEk5UG5NRlR4aHVWOUpscmlYcE5BOFAw?=
 =?utf-8?B?bFJ6UkRlZzM4cU1CazczTHpyVVRkbHVMMVR4bmFpRUl1dUVqdHZzanV5dzBB?=
 =?utf-8?B?UytjaDNhd2R6MjdTU0JLclhja05yTFFOZ1dSdVZWNjVXSllZRVkxcTg3U0pQ?=
 =?utf-8?B?OXorYTFIQUlRMUhmUnlrZ3g4Y09qS0ZqOWlWQVNFdG96cVExNGpaQUhMQ1Jj?=
 =?utf-8?B?ck00SnNSVVBQNDdQRjRFZzl2dmhPMEg4ZGVIOS9SbDg3bHJ1RVFxT0Z3dEVp?=
 =?utf-8?B?R2IwM0JMd2QycGhoTnNsZEUxcGRPYWFoY0NjZ2xONis0ZU1ZNWdYNUVZMDly?=
 =?utf-8?B?ckNLZDlBVnRBU3dOUFdVOXMzRUt2RUpmZkEwMHQrWkJZc1BiUVZCbWJxWU9Q?=
 =?utf-8?B?WFVRYm9tZy9SelZuVXVxdXFqT1VEMmtUYWprVXVnRzhKZ0NjeXF3ZFV4R1BW?=
 =?utf-8?B?ZEJ4WExaOE56MjhTeXhDTjZ3OFpkYjcyVWVIdzUranpLVm83bnlOV2R4M1dB?=
 =?utf-8?B?akVKUW96ZnRkalZQR1JwNVRoOTNzamVranNKNzFjVzFYTWRmTU1vaUlIRUYw?=
 =?utf-8?B?b3BZbHZUaTV3cVY5cTRsbTNCT1p3dmM0SzEyTC9QeUdUUmJReGViOE9nTDZW?=
 =?utf-8?B?a2lTK3RScGJyM2FKU1lvdklzTm9VTnNZcmdFcGZQZ3NkWEtndGlTd0hxS1lo?=
 =?utf-8?B?RTFlUG1TRkYxQjR3aGthdUp4TjNNQ0ZHVEE0MWxZMXE5MStBS1hKc3dUOXhG?=
 =?utf-8?B?VUJpTGRicGlXRVNjbkZJaEhOYzNtQlI5Yyt2cjY4Vk8rNVBTRmFKTk9qSjVN?=
 =?utf-8?B?ZWs2cTJxQXdpYkRnWTN4d1BacEZ2RlFxQlZEelJKUDdBejFQUTZ6bks4Mm0w?=
 =?utf-8?B?YU45WHd0RzM1cmxpUjdWVUVLTEduQ3NoMFdYdGZuaXhZWTNucmE2NlhGWEtR?=
 =?utf-8?B?aFE2UkN5OWhyNUlyRUZwVHdHTFpZVVEwNDBOdXdUSjJQZk5DOHZJN284SmxG?=
 =?utf-8?B?dnhUejcrZlMyZ3JEcThCbFZSUXpyblBpUDRNL00yYy95OGxoWjdNQ2xrVzA2?=
 =?utf-8?B?RVkvMGRCNS9oNG5oYUplNHYwcU5YOXVDYlBYOXY0QnZiYlZhNWl5bS82SWdq?=
 =?utf-8?B?L29nTFQwVmJXVGU3Yno2dHZ0NWdrcUdsMmRvK0ZwMm1OWWpRUjlXS3NuU21S?=
 =?utf-8?B?eTFSRnowQkRlZDZ4UFZtejI4bHBhY1dDN1Fwalp5VzJtQUw2NlZyeU9kZzk5?=
 =?utf-8?B?aWlKU0VUZ1E5bEQwN3Q3Q2g0MkhjZWJFRUpIeFh2WktvWUUyU1hyN3Avb0hk?=
 =?utf-8?B?d0NSN1o2L3VIU2ZoRXJKQVFBVy9VOEV2aHMwVVZONjFBRmw2TUxEMmYwRnVz?=
 =?utf-8?B?MUFFQXI1cnBsMVFoeGdsUzVPdkt4aDB5cldEREgwSDFQRStRMnVVajFORnhL?=
 =?utf-8?B?ako5Qkg4amFhZ2I5N3NnT2dFYTQ2aHVvZ2tWMDhRVW9KN3dySkNUWExCa09o?=
 =?utf-8?B?eHNTVlpKY1JTaFlZYjN6bkFvcFpMaFlCU2NsRmtiM3RjekNvVjYrV01tdWVx?=
 =?utf-8?B?MFMzK1BsaDdrdW9LVjRRM1UyaGFLMWRsZGhVVXVMU1hsMElNRE8rRiszamRr?=
 =?utf-8?B?TTJZMDJ1SzJGVXJacENVR21UclFhK1NyY0tEcGxKYTBtZmRRbHJaY2RwQVRD?=
 =?utf-8?B?TEJ3ZGlScUduN2Y5dmhoVVM4K2ZRUk5DckpEVDRBbythVi8yR3JOSjNNR3RE?=
 =?utf-8?B?ZEYzLzgwZVJoTWxGV2ZsTmo2M0t4N29lU2J3dE93SW9YTThENXZ0dDRTVVA1?=
 =?utf-8?B?TnA2Y3JrYzAyeGNuTFIyK1RZcFZDOTRRRUVxeEcyYzM3Y0s2cWgxbUxmZXVa?=
 =?utf-8?B?UUl4bjBzRm9TeEhSU3ZNR2R3a3d3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EbSz6XEjhdCkjchQMM5IJmjNLxAws+Ld+sZpkTskNck2izSQKGi2qtJrAfy6HZZNEvOvkX6sKjNWu5cBONe51zOCb0xGcaIlkuuc8txQCGJIRraMRJGxCs5U9hytLevkz846HRg5WX3HtK4AZ4zkj5ABVX+UO2G7jMIfiIGp3d5ru+mV8SCOJrTC/0ajFBCwkGzkLPzjdgfZE4zDqRoynOLX864gbkAZDsShHV1NPZ4hGB8UG6DSDA8PoqR9mTbuyfGJdtG/0Vxm3ot1nDl6yV05Zzh51LzJ7zRpdaziIvEm9TmLZVX19AdUIJ7QQkRg6Rp1emZMz+m8hEFYwfbj4FWnsljz8b9stjujqabVz9t2Y6oq2zqkGfwVrKrHhUuZ4syBCtlTz3r9NiLzdfIhlKSuUVUT/TkwGx0Me3kE+5iY7ye/EUuBqRzufoVUngGD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:45:38.2816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a37a4229-c0f5-4dc6-1227-08de6d40240a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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

