Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9F1C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 20:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A4210E5B2;
	Tue, 16 Jan 2024 20:35:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B9F10E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 20:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcGw1X2Y8BuGdllZX4eQ/nYnKLKHJrRiLE9MjMLJtrl2hahwf17Tvz89QUnPRpAPhrdm6jDiqLf48V6yySai1XeFhwOXqeUhLhf4iQXsta1MBxyHg+D3LJrYW2J4jL3uiAO36iFv2YBoof9/6H4dJphz8tlE6C+r1wlpA7A/MmB1i2S41ugwQpuwrL6p/C/u/9wXJBtkl4j9UhlIPHWlfThsQcX2AVsM33pj0xXUqcODgDXO9Vd26otDare36W/i2cPWJEC6HylSfCNcR0f+X9Rn17NRp/naVvFOTDHEZ2l0WefS3OTS9x6xYJV3OKMOgEsRaVXczy4VwK3tOWOAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQyIKZ4KDrtpuDeXfUPbXOkYdmjy1xiIlLc/t0x3NlU=;
 b=Slm0kMw22lVONOC3SWMJHawF1fzmw2CXHDUu6cWnbjWprsZQyElpinsiRm6WQmeeqWXWbHLyX1cebDNUOvTOpqyIEmWKxtupjEdG5welTdFDt7S6wTxfPg+2m3tqyX5k1u4U9Kwsb9kSneEG1F6U6D9AqZV0S6X+JxVqxkLMtXlme4a+/YHiN/MY4Hq60v0aE10Qk3b5d4TpL04eIXY+5o3/nXGLFg0EMzGIbENF58CaOzC1+fmtdbH66KT0chW68Nrwft6IkjqwtFMqL6eIu0GeuZxfHMGUtNli9nwulPFjes2jsBHTvSjHaazd8mx7zDHBEwhxqBbo81ts2HrCag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQyIKZ4KDrtpuDeXfUPbXOkYdmjy1xiIlLc/t0x3NlU=;
 b=HxFU1zr+9htA5cES0EK2osu/PUIO8VvTEwiXGz3xZdSyTS4PBpBnIw8/HWOv8lR+wk+GYOuJaNRAMzSJaMJrFlVMwnme84IFJSls1yPdWG4jOYkT7Kj/vf5uo6BaZhEiT1g56JDtFEf38SrrbHlDeHood3EkdEWqmVdPdPpKWx0=
Received: from CY8PR10CA0009.namprd10.prod.outlook.com (2603:10b6:930:4f::20)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Tue, 16 Jan
 2024 20:35:20 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::7e) by CY8PR10CA0009.outlook.office365.com
 (2603:10b6:930:4f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30 via Frontend
 Transport; Tue, 16 Jan 2024 20:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 20:35:19 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 16 Jan 2024 14:35:16 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v8 5/9] drm/amdgpu: Enable userq fence interrupt support
Date: Tue, 16 Jan 2024 12:34:39 -0800
Message-ID: <20240116203439.802772-5-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116203439.802772-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240116203439.802772-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bb4e96-d66a-4643-280c-08dc16d2a823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQ2lVT3ynhz299W6M99uXKQv6N1HhyTT3smVn7p2KZoEJfkum3RgAyjdvoExEwuQe8gvIDnUcj0b6JszfN50n5MtIdFsEMqMiixJ2qXaCDoJwFWlpOJU+I3CxGxz5sNUK3QeukculGg3LZpgnjvh0w/Oj/GE2Hl9EUb9xpCkFJrrc39+dARBH/0deAnzwd47BAVpVZY7fezKdaIUCFLFOJcldiengHmJUXVhYe/cuoYOlV7QYg6Ae/kViUMzxvfa5OxGRSVgiFaQM6uSonMeoIChC3If7QwsTWvsu24L4N2CBigrbSI2gzpuOJvHLVb8w5Qxt9iq6raT8F9A2SHXXy65PeFe8ljq52ipymXxflSVSB+oGgf5XT3jTFvJSlW1t2jAfkYcG51zNdn3Wt5h2douwx1wRiq00O+6aqoHCuOWMJ2uT/R5hYe7VmvC6+Yeub+aGliTmhlW1BZ1tdgfU0emw77BaYPZoYsIdJA9cKPkLLYS2LPO8k747iKZ+F7A+/GWdWPjQUyu8TLPECtPQjnhkN0KtUDXtYXyW+62tg9hqWd/PbbC0Hxet0liIHEMEEElTMVboEmL1QntB5kp/Pp2UdsdC1gbnHGDup8U/0JVg4rOJAbGR+2QQiTWp190KFCcrf1LI/Qbr5SW8UC5s0pkikXeIgyt0F+T3yly59hncT3msxxzF99mYzXOcOqWvCezTxa4Sn4iBE6rQYq9e+8qGCUiDiX4FcVbdpXTT/vFim/tiZAiMQKejXRntp77Y15vXOtrDvYZRcAmtx0THQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(82740400003)(36860700001)(356005)(70586007)(70206006)(81166007)(6916009)(316002)(54906003)(478600001)(2906002)(8676002)(4326008)(8936002)(5660300002)(83380400001)(47076005)(7696005)(41300700001)(6666004)(1076003)(26005)(426003)(16526019)(336012)(2616005)(36756003)(40480700001)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:35:19.8180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bb4e96-d66a-4643-280c-08dc16d2a823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support to handle the userqueue protected fence signal hardware
interrupt.

Create a xarray which maps the doorbell index to the fence driver address.
This would help to retrieve the fence driver information when an userq fence
interrupt is triggered. Firmware sends the doorbell offset value and
this info is compared with the queue's mqd doorbell offset value.
If they are same, we process the userq fence interrupt.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-----
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 26 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |  5 ----
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  7 -----
 6 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ed4e2f28afa7..72a2d8cb6caf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1006,6 +1006,8 @@ struct amdgpu_device {
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 
+	struct xarray			userq_xa;
+
 	/* df */
 	struct amdgpu_df                df;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d5f78179b2b6..4e8d1fad9f1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3808,6 +3808,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
 
+	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
+
 	INIT_LIST_HEAD(&adev->shadow_list);
 	mutex_init(&adev->shadow_list_lock);
 
@@ -4527,9 +4529,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	}
 	adev->in_suspend = false;
 
-	if (adev->enable_mes)
-		amdgpu_mes_self_test(adev);
-
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
 		DRM_WARN("smart shift update failed\n");
 
@@ -5566,10 +5565,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			drm_sched_start(&ring->sched, true);
 		}
 
-		if (adev->enable_mes &&
-		    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(11, 0, 3))
-			amdgpu_mes_self_test(tmp_adev);
-
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
 			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index cb216247d43f..66d613e38bad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -70,6 +70,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
+	unsigned long flags;
 	int r;
 
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
@@ -94,6 +95,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
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
index 4bdcf46a21a7..a14abd534cf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5823,25 +5823,27 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
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
+		unsigned long index, flags;
 
-		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
+		xa_lock_irqsave(xa, flags);
+		xa_for_each(xa, index, fence_drv)
+			if (doorbell_offset == index) {
+				__xa_erase(xa, index);
+				break;
+			}
+		xa_unlock_irqrestore(xa, flags);
 
-		spin_lock(&adev->mes.queue_id_lock);
-		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
-		if (queue) {
-			DRM_DEBUG("process mes queue id = %d\n", mes_queue_id);
-			amdgpu_fence_process(queue->ring);
-		}
-		spin_unlock(&adev->mes.queue_id_lock);
+		amdgpu_userq_fence_driver_process(fence_drv);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 1e5ad1e08d2a..b4b96949d41f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -1158,11 +1158,6 @@ static int mes_v10_0_early_init(void *handle)
 
 static int mes_v10_0_late_init(void *handle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	if (!amdgpu_in_reset(adev))
-		amdgpu_mes_self_test(adev);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 4dfec56e1b7f..91f326b2b9f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1257,13 +1257,6 @@ static int mes_v11_0_early_init(void *handle)
 
 static int mes_v11_0_late_init(void *handle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
-	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(11, 0, 3)))
-		amdgpu_mes_self_test(adev);
-
 	return 0;
 }
 
-- 
2.25.1

