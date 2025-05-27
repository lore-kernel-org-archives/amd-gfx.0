Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E465C54ED1
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 10:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E567110E487;
	Tue, 27 May 2025 10:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oALCJE3m";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4535010E48F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 10:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbpS4kgrW/1Zqhne2uz3CZdMzREbBBLM39U9q3OK+RB74KnOl59S3bE3g7wItzGZHU75itAIqQCB3YYz4aAuTmXomLodX8+6amkgc+fzpdOg/Lwf0jGAM1FimykDJd7wg6FSxsMu6vjTfPsPyW/o4XF/5DCUcktL1IBg0xLkpuL/udZsJ5H9Lz/ofE4uDXuHPt4FEXKXA6ffEadIHbbRCmk9ilJQyw7BOgVgQlDEGW4lK2RktG6vxkoJSknBjS8izolHF+y4sDbg9k1r8gUO4euxA4iGNz0AldRCHUAHVPnFY/dL9s+nbSOcupDwq0S85oUPt8oz0pcYhUg0bie0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKGoj0QuYmgT9PmIENBD1CUI+06JSwq9WK9NPxQ+5Wg=;
 b=wG5bCrdOUDwoUE8ui7K0IJq8mZMgvr7mxQhBr5JWDgiWLgVnF0suVhuhmjRqXoyzERkhRErlbfweur+uxauvGzUq13UFfJkhpQl/qa6AY2PjISonyTojnS/3+RiwDF53CEZ612NWFimxAg+cW/duWx+a3wHyyUVuKxpiVnDGxrMYaMWU5VqIepdU1yv29azHXM4PnC9eHbKlCc1oZnKc74iI+f4qmJcGaIcbQ00vyk/lR8d2bewvWHQHGKYY/8aVDhyWNqmEhcXy+gqspiQeaPbMWVa/Ak3JaH0DsJaFbVbh4rRsnMMyBqHLSovP5zaNwRzhctqbkjWHbtL6aJeYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKGoj0QuYmgT9PmIENBD1CUI+06JSwq9WK9NPxQ+5Wg=;
 b=oALCJE3m5LuZjANq3m5nMdijjsyNSubPrhSbtyRsWC2va0lRP8KOJmoXULHtS/IKOUet/BAiyY0tzFTaYKBoMbisiRotCVkZuVIKAr6DA+PfqMRXmXjlXFCYLotkJolTLbTnx5cKbBM3QGdAG9TWqCh0IZcV4tepN9hNf/agXYY=
Received: from BN9PR03CA0862.namprd03.prod.outlook.com (2603:10b6:408:13d::27)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.22; Tue, 27 May 2025 10:49:47 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::2) by BN9PR03CA0862.outlook.office365.com
 (2603:10b6:408:13d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 27 May 2025 10:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 10:49:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 05:49:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 05:49:46 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 05:49:45 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdkfd: Move the process suspend and resume out of
 full access
Date: Tue, 27 May 2025 18:49:43 +0800
Message-ID: <20250527104943.3020168-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ce6db5-e688-4a07-67a5-08dd9d0c32a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y4eepcMIJxLqSztSCmovfyyc20gT4CH9bsI9C442vItms2SDdCBwyraQIr4L?=
 =?us-ascii?Q?ks7dglhHekDI//KNGgen+TSNATWc9rtjqswYhTE+neW9eSvoABTfGxk0XknU?=
 =?us-ascii?Q?y87Q4ifYd745XeZiLo1Eho4GjlBsOdYclNsI/JZKt/KvDNT5xx0K7UPkVaub?=
 =?us-ascii?Q?B2ZRfOvA0mwuiUpU0V0ua1fI24mtJLllDILLoLUxZUnnr9aLIs6hyKAlDAxH?=
 =?us-ascii?Q?63CTuv93E53XjWOgcYjW04u4gQjQL78Z0sasz11oOCPhtEbtHNlGlzjy1exS?=
 =?us-ascii?Q?kVnOctA72nrdeivnssFi1hEmtHTSD1/TzGIj/HQyVSPOWmhJqZIANis1zwdg?=
 =?us-ascii?Q?nCn0Li6EO0MkWYSfjYTwIoAiEOArDaO3/w8g1Zpeq79IyZLeTvF+tCIG11kV?=
 =?us-ascii?Q?ZSkqtzP1mUzVUtag6NPQAaSyJWnOwHek1VXVGyB/pF6XCQjFulzN7P5LkIIf?=
 =?us-ascii?Q?0HV/x8ltzJewjGhNMlCOCcOKeUsx/v7w+dfXWnaTBAwmfMGgxaq6F8S3PszR?=
 =?us-ascii?Q?Vc1KIBAVbdJP5SsV32ywixuK70fv/PAbpUJxbp49ky56Wx5rEj5KHtmdbPXp?=
 =?us-ascii?Q?g5p+X91BRM3jWyWUlFzGkP2/WgZO411ybuWAHGhq963bog9kaG7b/kDAnc6e?=
 =?us-ascii?Q?3PeGk9+ixQUD3BsjZly1CtoAL30q6IRna9LHZvftLNGeTxaUZhB35eDdE33+?=
 =?us-ascii?Q?sfG7ziSHZCEpy8aaArH3+zGhcr02fYe8fk42BiTJRWLvGhR8TI38XiUd7OqW?=
 =?us-ascii?Q?RJzuDqi3Zmf/Jmabu8hNB8K7E7+HRk94RgkdeQaR2ker50no7E8XAe5AngLC?=
 =?us-ascii?Q?+kuMazJ/JNoCZdOcUYNWU1pGu9OtwAOyTN9HmuHde6J3OL1mHzrcbSb+WaAf?=
 =?us-ascii?Q?D21oHqepy+pGX9ttsm62NVmEUSQ9E/rddqCkR9tYSmWHdMBsnOV1ZaxqkJ4G?=
 =?us-ascii?Q?aMgP2+EtFcqcenD5wrrzeS8voax8JguCGtNRwIzjvXatfl3l3riRguiMb8JC?=
 =?us-ascii?Q?ld0kjlH0VCRe0FEMkboDrL1jWSjxmisUqH4FF0VC1ZiEQ+vw69iB/j7cr8eN?=
 =?us-ascii?Q?lK7IY6bnFaaWHIz/70qrC865ATocfig2f2rJK+43BxjV5LSKjI75SygoZHU3?=
 =?us-ascii?Q?3IHVB2ndIpCerXAhVbm1lcfLz2ndMrA4xXCwhsRyQYyxxwBUnattz+jWv5zY?=
 =?us-ascii?Q?OfHyJL3k3Xv/8em+/s0B9IuIxVNrwM7boKrP4Jb9FEaqtps5sf4Tnkq8lIk6?=
 =?us-ascii?Q?vm+H9QWc4cG6wnKjKYG4PbbI2v8XjC4pPF6lvSZBzaojTcD2tBKKzsqrY1G2?=
 =?us-ascii?Q?Hc9Re4RJf7bI+a+2AJTmDxaUdad2XG+0HEutUf/+6BCpVLpfsRpcZvyCTVH0?=
 =?us-ascii?Q?RvRXAD9/Qr7yRtPoaUlM2cSy2KmTwC6Tttf3eC55W/tOov4zP6Jf0CH2kCzQ?=
 =?us-ascii?Q?M2fKgQ6wRdmh0IDUh6wVrYx2RlOr6oqW/8I/BUkutNJjCTchac//wdqzMBKe?=
 =?us-ascii?Q?4qvE6rr/1eHWHsTBmiMmIJAcNJoO+nxWDdM2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 10:49:47.0705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ce6db5-e688-4a07-67a5-08dd9d0c32a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544
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

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
 4 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4cec3a873995..ba07e9c6619d 100644
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
index 625c416c7d45..6e29f8bd54bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5080,7 +5080,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	amdgpu_device_ip_suspend_phase1(adev);
 
 	if (!adev->in_s0ix) {
-		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
+		amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_runtime(adev) || adev->in_runpm);
 		amdgpu_userq_suspend(adev);
 	}
 
@@ -5097,6 +5097,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
+	if (!adev->in_s0ix)
+		amdgpu_amdkfd_suspend_process(adev, adev->in_runpm);
+
 	r = amdgpu_dpm_notify_rlc_state(adev, false);
 	if (r)
 		return r;
@@ -5178,7 +5181,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	}
 
 	if (!adev->in_s0ix) {
-		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
+		r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_runtime(adev) || adev->in_runpm);
 		if (r)
 			goto exit;
 
@@ -5199,6 +5202,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		amdgpu_virt_release_full_gpu(adev, true);
 	}
 
+	if (!adev->in_s0ix) {
+		r = amdgpu_amdkfd_resume_process(adev, adev->in_runpm);
+		if (r)
+			goto exit;
+	}
 	if (r)
 		return r;
 
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

