Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDFEC5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 07:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C706010E613;
	Wed,  4 Jun 2025 07:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oEJAYQ88";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064DC10E5F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 07:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJUUfcf6QMaIbqe64Sel3Otbp329LZUysurVkoeQjwNa/Q4Gm8UBgnzF0u3N93hYQmL4CWWd8ocd2XwTfvIqxhigXMi6apNAXYmFQXi2kz0wlnTshY1Rwa2OMgFELSHgnzv3RVY5JnBdJTPHPS/yw4Fipk+aJyJEDfXPYYofO9NabQPPNRcCHAMUag5V5aVnJGj5NfttBrFpgeS+sMfI//lv1FX0CkUx5F5whqgyfAbyQrw6Ca30NSRcN0QCDd4YKHzvOpppcU/LOQODzPdFVxo89y/qtIwjFXH8d7ImjXjkA8uGf5EB8pHTE1yBhTBIhJnM6vdlzZfahRi+w5EKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ3EhnPUHyimE7mHfbalrQyrQwGqOQp5UWLHC4aMMsQ=;
 b=ym+ZofllaNN+IP2zjlxOMnTcJCnVUMBpV4x6yAJpaoX2UDzCNY1n2CFZrrjiSHWOjby8BwC+KHts5AO2v3aJgUVJqWRW5bPYuhE65+LqEbemFoIwSbpLP4qo/Bb63NLfAunvipxr5f6shov2BAnZa05x255n2t/S2Ql5auDdRP3JZHygITmD89DVn5qI4OQuWiWiGUJCwesaRTIjYj4bJ8d9f5F59hCwxoK/k6PNfshHmRFp92zlhzZydU6EnBsWHkjTESetseksegVpCp+VS0+cxhDgHGqA/SV5ZPduHlyyfdyCJxO4VlzA1XQl6DJ/NmdLAF2WcIBV1CnFf3J//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ3EhnPUHyimE7mHfbalrQyrQwGqOQp5UWLHC4aMMsQ=;
 b=oEJAYQ88XhOIk4A8ZHPg08Pe9AL7vrXHi9bQyNV+y0gifMFpSpX022sVspDC/sJdvk1HPPq+e7nkrYNSJwnCR2kuYfVzrRvihxLhytqvD1XbWtHZM2QbcFuHCvkL1pcGdufJChJqpVCn7fmui3aBSljdmtRf8DhrRl1YyZ0GWDc=
Received: from CH0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:610:b1::15)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Wed, 4 Jun
 2025 07:48:23 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::84) by CH0PR13CA0010.outlook.office365.com
 (2603:10b6:610:b1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.13 via Frontend Transport; Wed,
 4 Jun 2025 07:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 07:48:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 02:48:20 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Jun 2025 02:48:19 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amdkfd: Move the process suspend and resume out of
 full access
Date: Wed, 4 Jun 2025 15:48:17 +0800
Message-ID: <20250604074817.1444723-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: efa99a05-29b3-4319-ec5d-08dda33c2d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kIYgeXRxEYIYNsoGhELbYU62NcU4wF2N0am/y+a45mFyiLmR+fbAOMRwHP00?=
 =?us-ascii?Q?PAr9sDx8+6PXYmnXuAFu9OOK7o9y54yjT52udlXXigmPhJYYv4OqHCw7IMcY?=
 =?us-ascii?Q?LGBW3O6huMeuWr5EwKn+ipWJpBDNerOHkEY2T9KbhtM/6xDOHjAELI97zTsy?=
 =?us-ascii?Q?fsGy1xr0c3ZvBL7KYUIRpM0v/mGZYIdrw+40+m4FPDV99wXhZs2gxv1mnERb?=
 =?us-ascii?Q?OApg+tTUHr+jkc936sh8rvGDnNMrQPC0+wiRjpA8RRW3PayGg2Y5eTCRCAJ0?=
 =?us-ascii?Q?9MBWrYgIXkfw3zln0M8qgBVNbKf+dKtF7DzKOpI7bbla5Pxti1jKUgFYZ/pi?=
 =?us-ascii?Q?RFgGzv3h8eEunvAGoYdMMpSqvu1Hd22vvwGIGCU6uVMYH6rIErvq8QGsDf+D?=
 =?us-ascii?Q?5jOxTOK2GkjbFqDT03mX4+gm0qAXH/jtNUlKtVtnXoq877seVJLjCKfxWHwU?=
 =?us-ascii?Q?XlF34MIPmZJW51l8fZCcI3c2hBsHET+6Fc3iR+lOCfDYH209mBVYFq20uG7T?=
 =?us-ascii?Q?168li1s4uI+ax2x/G6T0LCrgwBiKklOxq1GMX+k2FsHU5bVOYS0JuMcoOemB?=
 =?us-ascii?Q?OLbuLryVt0nD0DZdGanwdvJqYG+l+W8OUieGG29eQhre3Mdrg5KS72oP73rO?=
 =?us-ascii?Q?gpv1j59UC+1zXyHHI9GTI8vOV2K5cV77T+JYTIBLGAxo2S32Fm3iO/pt/llT?=
 =?us-ascii?Q?aVXu9S0xp3PV374x8mZwES+ywcrXF0fOArBFPtghK+rSjQrb4CjMQA/NCzJx?=
 =?us-ascii?Q?8tPF+uYD5LIQPo/saTBIaExoJEMgoqvdAED4MQPi0xVnjvpzoOFiokqKujmX?=
 =?us-ascii?Q?WRAr0F7EtNqhJ4hxXJvqngLwjFV9HZk4cdgGvgL1Rl6rELkaXSpQMLoD0O/C?=
 =?us-ascii?Q?0SfmvKt512gKYEONe9g7cVTOxyy0eXqKjQI6bqbIRiKGQWq0fJ2cy3KQeUzj?=
 =?us-ascii?Q?gvJkdZPLAhp60XHrYMQIvk3QL87WwaByAEXzrd71zOnUYkq7RTLbOqEet3RY?=
 =?us-ascii?Q?IQBybwcZpkbgmRi0lVl6S/g6H76shBAA7PlWQVyJEDoSafWx9UVm+MuQyjMS?=
 =?us-ascii?Q?jeIaluvb5fprg+MAXC08/SqWJh9OQimLsfaegGG4MUAMyQFIALV6wv2l6Jt2?=
 =?us-ascii?Q?2HyW/XUwjSpOB7GRCBefXcmoJro0uvEz8eKWQH/2AtYQp7F5UjiffryMJ7fc?=
 =?us-ascii?Q?Lm7POlRdK0r58LHfyFKNJfgFeGRUM4KkCQM7uH1b4zHVo6Uka5ponXMnaZhe?=
 =?us-ascii?Q?H66ML/nLhw0EN+9Ni5k31XgBkyn8ULs0zK1TLGSXWUZYB2/tfe7HpEBHAo3w?=
 =?us-ascii?Q?9y9MJ37Jrz3yfPsCIF0508CC00s/RM2MJecYFERLPljYc3FX66xsKb35wFjz?=
 =?us-ascii?Q?1Vqax1OSqKJIh9aAQJ9PjmteWjKowLvy7ubTAax+/WmObAZ3loWYCrOhjubb?=
 =?us-ascii?Q?rx+/98PxJv6zxNLaUQ76DfzQsvDWR4sLRkZZ0DUPF5C0OxMlgykWXG/IPC+/?=
 =?us-ascii?Q?YjmMqezdmaMQ0pEoZ6AAbCa82vsf3YN3nTGS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 07:48:21.4265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa99a05-29b3-4319-ec5d-08dda33c2d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
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

For the suspend and resume process, exclusive access is not required.
Therefore, it can be moved out of the full access section to reduce the
duration of exclusive access.

v3:
Move suspend processes before hardware fini.
Remove twice call for bare metal.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
 4 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index d8ac4b1051a8..0a8e7835d0fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -264,6 +264,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 	return r;
 }
 
+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool run_pm)
+{
+	if (adev->kfd.dev)
+		kgd2kfd_suspend_process(adev->kfd.dev, run_pm);
+}
+
+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool run_pm)
+{
+	int r = 0;
+
+	if (adev->kfd.dev)
+		r = kgd2kfd_resume_process(adev->kfd.dev, run_pm);
+
+	return r;
+}
+
 int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
 			    struct amdgpu_reset_context *reset_context)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b6ca41859b53..841ae8b75ab1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -156,6 +156,8 @@ void amdgpu_amdkfd_fini(void);
 
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool run_pm);
+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool run_pm);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
@@ -413,6 +415,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm);
+int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd,
 		      struct amdgpu_reset_context *reset_context);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
@@ -463,6 +467,15 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return 0;
 }
 
+static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm)
+{
+}
+
+static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm)
+{
+	return 0;
+}
+
 static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
 				    struct amdgpu_reset_context *reset_context)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5289400879ec..08ff9917c62f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5061,6 +5061,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	adev->in_suspend = true;
 
 	if (amdgpu_sriov_vf(adev)) {
+		if (!adev->in_s0ix)
+			amdgpu_amdkfd_suspend_process(adev, adev->in_runpm);
 		amdgpu_virt_fini_data_exchange(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
 		if (r)
@@ -5080,7 +5082,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	amdgpu_device_ip_suspend_phase1(adev);
 
 	if (!adev->in_s0ix) {
-		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
+		amdgpu_amdkfd_suspend(adev, amdgpu_sriov_vf(adev) || adev->in_runpm);
 		amdgpu_userq_suspend(adev);
 	}
 
@@ -5178,7 +5180,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	}
 
 	if (!adev->in_s0ix) {
-		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
+		r = amdgpu_amdkfd_resume(adev, amdgpu_sriov_vf(adev) || adev->in_runpm);
 		if (r)
 			goto exit;
 
@@ -5197,6 +5199,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_init_data_exchange(adev);
 		amdgpu_virt_release_full_gpu(adev, true);
+
+		if (!adev->in_s0ix && !r)
+			r = amdgpu_amdkfd_resume_process(adev, adev->in_runpm);
 	}
 
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bf0854bd5555..22c6ef7c42b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1027,15 +1027,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 	if (!kfd->init_complete)
 		return;
 
-	/* for runtime suspend, skip locking kfd */
-	if (!run_pm) {
-		mutex_lock(&kfd_processes_mutex);
-		/* For first KFD device suspend all the KFD processes */
-		if (++kfd_locked == 1)
-			kfd_suspend_all_processes();
-		mutex_unlock(&kfd_processes_mutex);
-	}
-
+	kgd2kfd_suspend_process(kfd, run_pm);
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
 		node->dqm->ops.stop(node->dqm);
@@ -1055,6 +1047,36 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 			return ret;
 	}
 
+	ret = kgd2kfd_resume_process(kfd, run_pm);
+
+	return ret;
+}
+
+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm)
+{
+	struct kfd_node *node;
+	int i;
+
+	if (!kfd->init_complete)
+		return;
+
+	/* for runtime suspend, skip locking kfd */
+	if (!run_pm) {
+		mutex_lock(&kfd_processes_mutex);
+		/* For first KFD device suspend all the KFD processes */
+		if (++kfd_locked == 1)
+			kfd_suspend_all_processes();
+		mutex_unlock(&kfd_processes_mutex);
+	}
+}
+
+int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm)
+{
+	int ret, i;
+
+	if (!kfd->init_complete)
+		return 0;
+
 	/* for runtime resume, skip unlocking kfd */
 	if (!run_pm) {
 		mutex_lock(&kfd_processes_mutex);
-- 
2.34.1

