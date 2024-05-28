Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C991CC25B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CC410F476;
	Tue, 28 May 2024 17:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rFAHsM4P";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1FA10F42B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwqrm2OWIUG4XcJZCFVq3iidHhVtsSpvxWUWTAXHrp31IaqVSzGQgiEj0P1qFJ7U0Oo5DglCpQlt7q7NdaQ29tCFNa5kAwwQFRmYoEgq2ndtdT9uOqt8RgGTEDhx2X8cKixtvkW49H9voEJnMRhy35ke+0ddGURLavJ3FSfMeXoNHK3KGmIgfV4GH/kgWAxBIpwzxqdFQaQ2n7p3cFaPKJin0RGQFy1cgECwoFEuF1sCytf9GYYBhI9AjsoX1vczETO6Ss5lzytb6YDGn2Wm/WAKGxlQjAHci1bz+1mjFhCiq2JCpAOTBwx1Vk2pv3p6Cls6XRpt1XBQ8+bVlE00DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58kclLSPdJI3ihoM76+ZUXwkmRBWv2NflV1Py+2XIYY=;
 b=LXx/TI7IcaATY9MlCvri0YUqjG61djtcIhn9mvVhhTbx788giO8FGrdPKaYFuIfq0cBmg0bxx9jbK+4pS/z9HyXwDZlrcainUlLWhnpTUusXWdj1O5FSWnwJ9cBbtswpsHBXEQwOqyrV/m/HOAmG9LwECrP3U1yXNlt5/UHIVNBmhk+tEAcPHntmgM0TQIStQUPgaJbjoixHFT6xQHTKRgOF2iaPJmsP1nNGKLPWbqozpts94pjDfn91t98zryHL54dHGNxKAUVYKSWeIe1sChuKM7zgO5/klvS4NhldTfkY1Lh9eZgq7vN+KdNMJJald65/TqulyBnzT659TlJIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58kclLSPdJI3ihoM76+ZUXwkmRBWv2NflV1Py+2XIYY=;
 b=rFAHsM4PUD/LIN3yiwTsV8A/PFQqqrqaj6SMQg4ke5bUq+30MLqEYtPRFaW9hfV7dPTBUHIq7/qHuxJvSDr6qHx2u2K0THi/jFPVTtW3hrtDyM9+xnbVB8Qfwr4joUuePUGOnvJ+3c6H4l3Tk2q/Oa7lqRI37WEikzjgcTGSfiE=
Received: from PH1PEPF000132F1.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::34)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 17:24:11 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132F1.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 17:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:10 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:09 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 02/10] drm/amdgpu: fix sriov host flr handler
Date: Tue, 28 May 2024 13:23:32 -0400
Message-ID: <20240528172340.34517-3-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6ff45f-739b-4b5a-5641-08dc7f3afce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DZssnnnRcQaWosL8M/WkZqlnUCTfmAhHj/Zn/0LvS1HAV6QMs7VFkMDjbAXy?=
 =?us-ascii?Q?xRin+SlbodogSEA7+dUeyx5DqsN58lw2ryFZAe1zvYeXD2mQ4ebKj7EIxoBC?=
 =?us-ascii?Q?3bLuFoaM+i9FIJNa70B5rJq15TvFvcbq5SGsTjelEMhy85ArMYXgpLgCLOw6?=
 =?us-ascii?Q?bCUB0yYVAajEbXS8d/P7x9JiJKtnSnEOUrIMjrAZ/1Lpzo4IsZqDnxIzLA/A?=
 =?us-ascii?Q?7r5wJcenbtKHvBm489oASnhkwRISpAkiNVIv/AX8lBu8X6/gyuOLkL2ekQ3u?=
 =?us-ascii?Q?uvT4NKiyVIT74adPkcaJkRjuCup/3W+4pZ2M5XSggnquTu/PpuPxuDkB6d32?=
 =?us-ascii?Q?+QDBqtNuFfvdb00MqG0xVQ9D4OL2E5zCvVrwVbJedf93WMIJUSBxA8XNhFnZ?=
 =?us-ascii?Q?jwwLvyr94jWcpp+CvuPJgFm4hPpWh4++KrFuXBaedrZ/NMANP8TnlF4stZL1?=
 =?us-ascii?Q?XYW2SjUA6HGY9A+96APW3RGaDdtMccd/nOZBug4JA0Cqd4CLDLahkoSYf9t5?=
 =?us-ascii?Q?H9DlwCZk09HB0ax114jXOcxrSzjku+svc8VHGYCZGBESZjfrTMvnQTDETG7K?=
 =?us-ascii?Q?76y0BGYhj1ZVgC5ADuGb2eJN2lDxDJNiiXlnrZtUK9n3wwoQxXkWbjHv6IP4?=
 =?us-ascii?Q?mZ0dKj5TZ74yTpjxK//MaHDYuMGpqVrsJl0z6QONd0klqjZHZ71GWotGgEPD?=
 =?us-ascii?Q?RmUAGSa5foyDOMCdZ2OstTlqyX4UgF1QlhyNVpNj5m18LJePCONNpBZYZnrf?=
 =?us-ascii?Q?bY+US+b1YtpJ92BhdyhAX0DYgqQlY5XxmhKi8LPyop15MuwuoK9HeM2snej6?=
 =?us-ascii?Q?L9gHDahdwGOZmFFg6q0My0Pm4Cvmcwc17QZu6BZLQdkx9qGzY4LuurBRJPfT?=
 =?us-ascii?Q?rQGhWuyFaFhQAddHFvsDKHv1Xwh+kyCMBFixEAJuI9W+Gdx1pxaSTv38jMZ4?=
 =?us-ascii?Q?Gxav6OFk78x9iHGYmtVMFr7WzpYx4TT+1qHVUilkk91dHOCgW1TGD1o/iqm5?=
 =?us-ascii?Q?FSYBrqGbnkw2wvqgI/WfF3QOWXv9g9TLT2kWifYDE/kxjRPGIiooAIm+ss3M?=
 =?us-ascii?Q?LllQxut2aouJgtYYgsUdpnc1bLXRQ64qfN9O/DSx5ZFZ9kdEuoWCtQvL4m1r?=
 =?us-ascii?Q?E8Gg6UZURDxvvl2sytHAL+1/dG3p98iHO0ZNkx9OxKjjiEcaggEPtHzCLLn7?=
 =?us-ascii?Q?pm945CoZXI+aTeJflZz/0YZueg5XHTrKLFrm0J+TJ37E40+XGZBv4HpxBHSV?=
 =?us-ascii?Q?wFzDaACgMmD6qDTJ+5BqwJwFoExR58lrtskSrusF/3l62H4OcXiuAR+hmJqs?=
 =?us-ascii?Q?JSUy4FyKaZFVnVgpRf8aIhkl3EiE8JOUEMeRGdS6d80HHzzTaRI5NWHwIuWU?=
 =?us-ascii?Q?sjdNhNH7AfzFpAkrcAGs5uiaEXTh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:10.6221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6ff45f-739b-4b5a-5641-08dc7f3afce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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

We send back the ready to reset message before we stop anything. This is
wrong. Move it to when we are actually ready for the FLR to happen.

In the current state since we take tens of seconds to stop everything,
it is very likely that host would give up waiting and reset the GPU
before we send ready, so it would be the same as before. But this gets
rid of the hack with reset_domain locking and also let us know how slow
the reset actually is on the host. The pre-reset speed can thus be
improved later.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 14 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 37 ++++++++--------------
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 37 ++++++++--------------
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  6 ----
 6 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bf1a6593dc5e..eb77b4ec3cb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5069,6 +5069,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 
 	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
+		amdgpu_virt_ready_to_reset(adev);
+		amdgpu_virt_wait_reset(adev);
 		clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3cf8416f8cb0..44450507c140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -152,6 +152,20 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
 		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
 }
 
+/**
+ * amdgpu_virt_ready_to_reset() - send ready to reset to host
+ * @adev:	amdgpu device.
+ * Send ready to reset message to GPU hypervisor to signal we have stopped GPU
+ * activity and is ready for host FLR
+ */
+void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+
+	if (virt->ops && virt->ops->reset_gpu)
+		virt->ops->ready_to_reset(adev);
+}
+
 /**
  * amdgpu_virt_wait_reset() - wait for reset gpu completed
  * @adev:	amdgpu device.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 642f1fd287d8..66de5380d9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -88,6 +88,7 @@ struct amdgpu_virt_ops {
 	int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
 	int (*req_init_data)(struct amdgpu_device *adev);
 	int (*reset_gpu)(struct amdgpu_device *adev);
+	void (*ready_to_reset)(struct amdgpu_device *adev);
 	int (*wait_reset)(struct amdgpu_device *adev);
 	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
 			  u32 data1, u32 data2, u32 data3);
@@ -345,6 +346,7 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
 void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
+void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev);
 int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
 int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f4c47492e0cd..3fdd1fc84723 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -249,38 +249,28 @@ static int xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
+static void xgpu_ai_ready_to_reset(struct amdgpu_device *adev)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
-	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
-	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
-
-	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
-	 * otherwise the mailbox msg will be ruined/reseted by
-	 * the VF FLR.
-	 */
-	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
-		return;
-
-	down_write(&adev->reset_domain->sem);
-
-	amdgpu_virt_fini_data_exchange(adev);
-
 	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
+}
 
+static int xgpu_ai_wait_reset(struct amdgpu_device *adev)
+{
+	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
 	do {
 		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
-			goto flr_done;
-
+			return 0;
 		msleep(10);
 		timeout -= 10;
 	} while (timeout > 1);
-
 	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+	return -ETIME;
+}
 
-flr_done:
-	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
-	up_write(&adev->reset_domain->sem);
+static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
@@ -417,7 +407,8 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
 	.reset_gpu = xgpu_ai_request_reset,
-	.wait_reset = NULL,
+	.ready_to_reset = xgpu_ai_ready_to_reset,
+	.wait_reset = xgpu_ai_wait_reset,
 	.trans_msg = xgpu_ai_mailbox_trans_msg,
 	.req_init_data  = xgpu_ai_request_init_data,
 	.ras_poison_handler = xgpu_ai_ras_poison_handler,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 37b49a5ed2a1..cd6ec1afff2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -282,38 +282,28 @@ static int xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
+static void xgpu_nv_ready_to_reset(struct amdgpu_device *adev)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
-	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
-	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
-
-	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
-	 * otherwise the mailbox msg will be ruined/reseted by
-	 * the VF FLR.
-	 */
-	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
-		return;
-
-	down_write(&adev->reset_domain->sem);
-
-	amdgpu_virt_fini_data_exchange(adev);
-
 	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
+}
 
+static int xgpu_nv_wait_reset(struct amdgpu_device *adev)
+{
+	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
 	do {
 		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
-			goto flr_done;
-
+			return 0;
 		msleep(10);
 		timeout -= 10;
 	} while (timeout > 1);
-
 	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+	return -ETIME;
+}
 
-flr_done:
-	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
-	up_write(&adev->reset_domain->sem);
+static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
@@ -455,7 +445,8 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
 	.req_init_data  = xgpu_nv_request_init_data,
 	.reset_gpu = xgpu_nv_request_reset,
-	.wait_reset = NULL,
+	.ready_to_reset = xgpu_nv_ready_to_reset,
+	.wait_reset = xgpu_nv_wait_reset,
 	.trans_msg = xgpu_nv_mailbox_trans_msg,
 	.ras_poison_handler = xgpu_nv_ras_poison_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 78cd07744ebe..e1d63bed84bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -515,12 +515,6 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
-	/* wait until RCV_MSG become 3 */
-	if (xgpu_vi_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL)) {
-		pr_err("failed to receive FLR_CMPL\n");
-		return;
-	}
-
 	/* Trigger recovery due to world switch failure */
 	if (amdgpu_device_should_recover_gpu(adev)) {
 		struct amdgpu_reset_context reset_context;
-- 
2.34.1

