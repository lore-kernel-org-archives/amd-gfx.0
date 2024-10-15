Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3F3CFC274
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 07:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3512D10E520;
	Tue, 15 Oct 2024 07:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kj4v0n9f";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B246D10E520
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwcenOZmVhqCJ6U02bIj/I6mS24Y4j6DUnDISlBzgNUn912WM0NiKJ0YVGkEDT98il0M/U3ZLTs9mj6P8WJt6GOCBMUNhZVT7HgZmrF/gdIX3LgMAqAxmt5lMTCUIW6GlBQtUDLIwBUewjofR/D6XMsSHREs76pMBzThGm8+mUX9h+Za7iV4pgZ55aaK5Xk4sxmlWVbv+hvZGeodsNr2XdvbcSTl4vPiN8LMCMY9l4rJQLDc7nqA2sUsnfHESBXD9cjDMJlsrRRvaD59UIB8gT6GJ9u5Fst+ch63mOm2spwgwmQhoH2eLKQiLYNxeHOmGQs0xT6qpsGtY5EZYHA6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUKTc9jUTfk1XCoDHinL9LccSKaugI3BUbrtssRIeGE=;
 b=DIDTyOr420XTGSSHiuF+8SYfWZf3UIyKBTtLEutTkjo/rBK3DZ30/OTlEy1YCO2bw0Eu6Z0cYlVGUTofK6zB4cAcxr7WNGeID+mgAgRtCWDMU+9GTPUpd6EqX/b6qRN1sPJdObOBoRW+3OaOMICNI05wY05yZ1umpuJoJ/afBOVarsFxsv5YFULaeXurus/yQsJeeHCCZPOmXEWXEynDrZzhPx+7jJLpLnVtG63OQtlbwIIrrErDR+2DxXX70yg5bXfJ6jk9HeBEX0waaud/Y9denZ3m9TRt9hoS27ZltDjlLPabsj4P7gn805/ZPjJaZ3v1WaXkJFyGUW929bQiWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUKTc9jUTfk1XCoDHinL9LccSKaugI3BUbrtssRIeGE=;
 b=kj4v0n9fKPLMKDll/7L489NJ/RdjEKzjPA/VPZ6nwlOGosGdbH+BBvFZKWkjNTqqrrUUksojyU9U/eSI6eRbrhUPf5AYQWawaj5SxFFfVduI9uxOYzGmuIt2RfYvEeSXEZhUZNvbe8edx1Y6BSw/Wi/K8GIXNHz4sOXfwJrWNxg=
Received: from BN9PR03CA0128.namprd03.prod.outlook.com (2603:10b6:408:fe::13)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 07:43:39 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::99) by BN9PR03CA0128.outlook.office365.com
 (2603:10b6:408:fe::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Tue, 15 Oct 2024 07:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 07:43:38 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:43:36 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 04/09] drm/amdgpu: Enable userq fence interrupt support
Date: Tue, 15 Oct 2024 13:13:04 +0530
Message-ID: <20241015074309.2484264-4-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: c609f9a8-9c04-4a8f-210f-08dceced155d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|30052699003|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVZJV1VKNDNqWTUwVUZPWi9MdVY4WU0xaUFpZEdZT01IdU1sdHRram9HUW5r?=
 =?utf-8?B?enJpbm1FanpTSHM2NnQ3L2pQMVB2cDUrekZBcTkybVFSZ1ozRzJCN3VQSUM1?=
 =?utf-8?B?R3VQZTJnQkdhWWRnalFVZXdRc0hxWUFoOGIrRGMzaTMxb2RlbzBGaEEvTVpX?=
 =?utf-8?B?RDlxd2dMWWl6OWIzVGVZSVNMeHF1VWNVVjU4eStuZzZlMDFSZkVSV05vNnpT?=
 =?utf-8?B?NG14VmlwY3BaUU1rZFUyUkZ3dklYY0VLcVI5bVRsQU05d2NVREtiVzh2WFMw?=
 =?utf-8?B?d05uT09sNjNTdnNCMlhTUkR5K0NTV2xWUFBwOFU1QTF2V0U1cThoQ0t3aE1W?=
 =?utf-8?B?TXNkbGV1UjNPUUx1UnpZYTYzeDVWaU4rUGx1eXhVTnhmZHN1Q1ZGRmtENnh1?=
 =?utf-8?B?bjNabDE4R0lwaXJybitpaU1WMnZIbC9Hd1dJN1Y0Y3F1NlZHcmtMMGtTa2pH?=
 =?utf-8?B?T0QxTHE5clJSUDMvbUpBQXF4Z1JySjRERG45ZlBlVFgvWjhVQlJ6WFJCN3pV?=
 =?utf-8?B?a0VMeitqQWp1VXVndlhvWDRwdHplVzJtUWl2a0xFbTc4anV3QmViT1BmbHBI?=
 =?utf-8?B?L3R0RSs3U3dPaHpUUnhZVnRmWmplT3RXUlRLNXBrc2J2WndCbS9WN0pvallD?=
 =?utf-8?B?VGt5Y05VTmt3eW9IcDkwTm9jUCtvYUZON2RhZzFnOTBTNUpaVjVFOTVWQ09z?=
 =?utf-8?B?ZE1MS3pQTnBoei8yV01XeEFLcDVEdFd1YTVoU2NuWEpGdlpxOGF3c3IzekND?=
 =?utf-8?B?SHcxVlZ6TEoyZ2k3QkNab0lyZjhSZXowVzEvcmdJSVJaY0dSMUlFYVNlbUJu?=
 =?utf-8?B?M3RmSG9SSTI3NkwrNmJJdnlWWkhxMTEreUZYK0lZV25QL3ZldW1Mc004TXJC?=
 =?utf-8?B?RkVEWWFSd0ZuNmFnVDN3Zy8vMG5pM2F3SWlKTThyMjgyb3FsMEEyVkpWZWVu?=
 =?utf-8?B?SmJGQXZDYXd4ektkZlR5YzR3QUhpTEN5eWFMVGpqcnV5QVZRMUF1aFlXTXZE?=
 =?utf-8?B?ZHUyZTF1TTZLUkp3OXZ2Y3ZDKzhMRjdQdDA3UU03SFBaL0YvNytKVmpaeVFD?=
 =?utf-8?B?R29Za3Q0ckd0NjB3R1JmbWVneDVhVlBGOUg3NmVsQkRVWGRYOERFSGxlZ3Vx?=
 =?utf-8?B?dGg0OFp6dHJPcUcwMThvY0l0Rnowa3dPWUhvWnB5OWJLb3JHdDM1QTdVdndH?=
 =?utf-8?B?bmdVVUhNL1pkV3dlMzV2MEFWQnZYTDFxQVhreXJHeFRTbXNLQ2FPOUI5ek5r?=
 =?utf-8?B?Z1Z4Qm5GR3lmR1l6YWZSZXdxajV4UVhFU3BRdVBrVmVZblNDWHhseEs0MXdU?=
 =?utf-8?B?TXJXd1R6ditFSERtbkMxTW1UUkxNNllqakl5b3huL1ZzNlpaWFUvWERsdkp5?=
 =?utf-8?B?M01OTk8rcEJDY3VpR0V3eUlzbGNXOGptdmZna2hqbVkzU3RxY24yVm5QRkMr?=
 =?utf-8?B?ajkxWVhTS1p5WEVIYlloU2JzV3ArYnBWUU44TWhKTmVhVzNxL1VId1JabjE4?=
 =?utf-8?B?YWtNaEJSdmRiY256S1YyaFloUS9VK2VCR1FyQ2NUaFhrS1ZhSzZGVExhQzVP?=
 =?utf-8?B?QWlFYmhLVTN5QXB1Q1hxTU9tY0pTRkJLZGZRbm5xTEMzemsvRlhjSmVRdUZR?=
 =?utf-8?B?S05seEpwUXpUVG5PeHNlekZBbkNGZDhKZnZqcmpZcXMxOGZPakxNQU94UUxT?=
 =?utf-8?B?RXFxOXRsV3ByWDF1LytJdFJkK2Y1VU5sdmFuSU80NXRGUnRDbHgrMkwzeUVn?=
 =?utf-8?B?OG9jQTEzSUxZS2NFb3E1OXdFaE5KemMyMldQZ2J4VFZaZTdsTWNWKzd0VElz?=
 =?utf-8?Q?AGVhtlFuY1ofbgY0CI4iAU0GNgZH+thLSH2Ac=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(30052699003)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:43:38.8971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c609f9a8-9c04-4a8f-210f-08dceced155d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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

Add support to handle the userqueue protected fence signal hardware
interrupt.

Create a xarray which maps the doorbell index to the fence driver address.
This would help to retrieve the fence driver information when an userq fence
interrupt is triggered. Firmware sends the doorbell offset value and
this info is compared with the queue's mqd doorbell offset value.
If they are same, we process the userq fence interrupt.

v1:(Christian):
  - use xa_load to extract the fence driver.
  - move the amdgpu_userq_fence_driver_process call within the xa_lock
    as there is a chance that fence_drv might be freed.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 ++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 25 +++++++++----------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 94bdb5fa6ebc..2da895f91e4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3967,6 +3967,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
 
+	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
+
 	INIT_LIST_HEAD(&adev->shadow_list);
 	mutex_init(&adev->shadow_list_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 1a9565b61266..cd473c985e36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -71,6 +71,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
+	unsigned long flags;
 	int r;
 
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
@@ -98,6 +99,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
+	xa_lock_irqsave(&adev->userq_xa, flags);
+	__xa_store(&adev->userq_xa, userq->doorbell_index,
+		   fence_drv, GFP_KERNEL);
+	xa_unlock_irqrestore(&adev->userq_xa, flags);
+
 	userq->fence_drv = fence_drv;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 508e0acebb0d..68f908cafb6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -50,6 +50,7 @@
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
 #include "mes_v11_0_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
@@ -5865,25 +5866,23 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_irq_src *source,
 			     struct amdgpu_iv_entry *entry)
 {
-	int i;
+	u32 doorbell_offset = entry->src_data[0];
 	u8 me_id, pipe_id, queue_id;
 	struct amdgpu_ring *ring;
-	uint32_t mes_queue_id = entry->src_data[0];
+	int i;
 
 	DRM_DEBUG("IH: CP EOP\n");
 
-	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
-		struct amdgpu_mes_queue *queue;
+	if (adev->enable_mes && doorbell_offset) {
+		struct amdgpu_userq_fence_driver *fence_drv = NULL;
+		struct xarray *xa = &adev->userq_xa;
+		unsigned long flags;
 
-		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
-
-		spin_lock(&adev->mes.queue_id_lock);
-		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
-		if (queue) {
-			DRM_DEBUG("process mes queue id = %d\n", mes_queue_id);
-			amdgpu_fence_process(queue->ring);
-		}
-		spin_unlock(&adev->mes.queue_id_lock);
+		xa_lock_irqsave(xa, flags);
+		fence_drv = xa_load(xa, doorbell_offset);
+		if (fence_drv)
+			amdgpu_userq_fence_driver_process(fence_drv);
+		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
-- 
2.34.1

