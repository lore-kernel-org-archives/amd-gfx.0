Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77D8C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 09:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7EE10E59F;
	Tue, 17 Jun 2025 09:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j0i4hUd9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6924710E59F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttSNDna5cAVehPe+fa4rFWe+7SoRyN2jjkrmtCJIN92hI/aFcaXGScLQrxVuCCjE9Iuu0FfsZBlv0co/JZfatSiOG3pQt5j7CA+o8IDKaqFlPuIq02WLh2XYn1surntZge3ihzq/Qd0TyPt8BpJ1fGjDBNU5ZUtNwnLv1LNnKm2Z6v5Y4gpjMA36iHvoRFJVeAPjfPOQPPf9f00HPnVAuOjB90Sk4AwEIJqv7rPSv5atAW3zdWxtW/IoRNfWGyXE9nYi7eOVDzEg0xEfF0HzZdlhRb2ru655QC+THETC5cM4qI8crCCu5JvE7NiQOnBQNQmutNFe9y/RzpVEwuWRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdsTfCHUNqZvyGaRYC+QBT9ccuJqZaVDZj/SQZksYVY=;
 b=q7ZA6CDDHzcdesqpHCSHFy/7WcFHHbrHIBdN75CYGqNo+ZTJ9UR3YW7A5AkJTjXNXyU1nHOGRlvpjzck9gAE1uTtzWIXgOvd7ZCoYVROmB5vSP92w7DlOvcDFtrR3xNOeruE+qZ7p3kDwXSK//hhSYPRoL0VaKLx5+V9SgK2ZVg597wY1VYYkraE8Ff6MoEM0/5fMBHk+RzXlkL8roVsjGNWhCH+8OYQtqCKgF8eGHw7v9tSMFs135ggQHV/KVdcrg4oSPpRGoSx2WiYhedLL96NfSbiWlL34R74u6lbyy6OSp5IDA/kjY8RuVe8DS/wFS6vjqSaUO93IWay5QV73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdsTfCHUNqZvyGaRYC+QBT9ccuJqZaVDZj/SQZksYVY=;
 b=j0i4hUd9QLYvujuJFfLFMEQVFywVnaJbLAk4Iostxguv/7oWjCBRl8slAdFHfSkylm2wD1JhAs2IwdydQuzfqIzW8WgSqXsiPLdMBbDj6rVbOKIQGyYGjrB8s1xReDwVF50wdgkUvo7f+BpHKdrQDvBJqRvW0QxHqs0iVOPzxFQ=
Received: from SJ0PR13CA0160.namprd13.prod.outlook.com (2603:10b6:a03:2c7::15)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Tue, 17 Jun
 2025 09:23:22 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::b2) by SJ0PR13CA0160.outlook.office365.com
 (2603:10b6:a03:2c7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 09:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 09:23:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:23:20 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 17 Jun 2025 04:23:14 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v3 7/9] drm/amdgpu/userq: add force completion helpers
Date: Tue, 17 Jun 2025 17:20:19 +0800
Message-ID: <20250617092243.2769580-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 35af6891-6ae4-4648-beea-08ddad809a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?14mYAzPdZQW/oh/9t0S1CbxSTcLpQfrtOBGPch08BRkAr8WmDxoS7WkGVtuP?=
 =?us-ascii?Q?h8kKAjmUrIIvuTkhk+vGRQwOA6tkOK1O65xfSk3Tg9j58u/tK7mjXAiaIhZB?=
 =?us-ascii?Q?mzxdU3bFhfriQUp0wi/7D0u+FOKf+wAupEy2dSaseAGzSpHVDX2G/rob3zsb?=
 =?us-ascii?Q?HgSWIYY7FrAn16eX/aTwvjPrkmcFWHiyj1IeUxpPuLn5iLxS/P1yQErqjgSi?=
 =?us-ascii?Q?pIIj8URiFS9ZvuFXuSSbF9x29wzE6ERJ+cJGVIN7KBHFyjDTCZlHufzPxZQh?=
 =?us-ascii?Q?N20JdG8Xkcsbh+SQiInCOtRI6lZxF2qSJ7igqfKmp4mpYZ7zdK9hOQ/dOK87?=
 =?us-ascii?Q?TSqdSGmzcdoJ3Y+4GzsLMgzF6uxt4w8fRDKh5NgNhqrGsknrDnhkPGTC3Uuy?=
 =?us-ascii?Q?b2SMbSRxhwGz1wRE9Vd5X58XrmhNSW9IvI5ASgGBeb6ASo0fI7324Ak3kNCK?=
 =?us-ascii?Q?ctsVxmF8K8tT1wdopw4LAdvX+f+L5L/ei9RpNGRLoudaTl8S8/vf86rk0TMC?=
 =?us-ascii?Q?cF+9NtPnsktd5lDBF4U3SKK+5GKj1Ru/YhonF9nKXwe5KLIzhAJAznxRboCy?=
 =?us-ascii?Q?79o5a4JHwtd3KN7yoY+7IDkjQhc79tsja6XxS7nDt8al/I4rPZfOHMIm0sU/?=
 =?us-ascii?Q?L11wzz4str4xRGxxia3c/K9UGHn/7c2ut57GpjL4H9X+oC5caYlWErx2YZL5?=
 =?us-ascii?Q?TZt/8xlnMzPRJP7HEfv/p18szEHVmQL9ky/4QtYOZvVYLypjfsSUufU49ox3?=
 =?us-ascii?Q?2JwIL90qaZqvixTLlnJcF5ONVLZTM2yQggb+ogL0qXbsCseIocyT5tehWN01?=
 =?us-ascii?Q?s+JetZpQFhFa3TNnpjoTrkd3tTQniwgnON67uHbuM/z3WmeTXG7N0Ggyscw1?=
 =?us-ascii?Q?0cpY74lF9WUAePZ4/ME3aVmErkbzUMJi/55wwDPbSWgKWq4VvQLEJBAr7m12?=
 =?us-ascii?Q?ct85R+I0/cClfKWpqLh2OrB2g+S0m1Vs5chrYBtpdsBXvcubnXNnpugc+yYm?=
 =?us-ascii?Q?MCC8Ald/ijy5k3uAKg87i/8+Vd5AALv2b04iMhfmhj6eUWta/O4hTE2OBMAi?=
 =?us-ascii?Q?X4lo/l7AwkBfJtb+HtdPr2QN7nJ1DuBH7//gcpOlP3S6Y4MH8LYJPuTjrvl4?=
 =?us-ascii?Q?unXGrILkKyKdTuEGcr8/vhlNwlle+k41oT50uIY/vxsqVTh8UpDQ1Uo8mVzO?=
 =?us-ascii?Q?72A+Jwk3iRPTADz3iFsd4VCabfeJRb3cwBC42x/iQg1R7z71iBHb8zMo53od?=
 =?us-ascii?Q?VVeDWnLKcsSmoWvMpK1mSYdPJ3PQuLKZjkcpnYMjzwZo4nEBS8Mpx7XifZLr?=
 =?us-ascii?Q?QEANE5PoeCgSj39I42qWt660uUqQQTBSBZeBUEZW4JQKGEoamp9Nfhi1tfG+?=
 =?us-ascii?Q?uZQ/bjulhajQDhbV4c0U3u7MAlq49jOCPfjjUTZId16Hc9wzMLCxdUoxgDK4?=
 =?us-ascii?Q?L32S6L9iWMAo8kQO4zkaf9dvNRiJ+RQNniRWgAcsbNcKz2RZH0na2vwu0wK4?=
 =?us-ascii?Q?bjcX4DVriw2K6CBb5Wr5AM1X8dOQkBDXalUP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:23:21.0104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35af6891-6ae4-4648-beea-08ddad809a3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
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

From: Alex Deucher <alexander.deucher@amd.com>

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deef..01688bbf3f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
 	return le64_to_cpu(*fence_drv->cpu_addr);
 }
 
+static void
+amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
+			 u64 seq)
+{
+	if (fence_drv->cpu_addr)
+		*fence_drv->cpu_addr = cpu_to_le64(seq);
+}
+
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
@@ -409,6 +417,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static void
+amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
+				    int error)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	unsigned long flags;
+	struct dma_fence *f;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+
+	f = rcu_dereference_protected(&fence->base,
+				      lockdep_is_held(&fence_drv->fence_list_lock));
+	if (f && !dma_fence_is_signaled_locked(f))
+		dma_fence_set_error(f, error);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+}
+
+void
+amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
+{
+	struct dma_fence *f = userq->last_fence;
+
+	if (f) {
+		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+		u64 wptr = fence->base.seqno;
+
+		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
+		amdgpu_userq_fence_write(fence_drv, wptr);
+		amdgpu_userq_fence_driver_process(fence_drv);
+
+	}
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 97a125ab8a78..d76add2afc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.49.0

