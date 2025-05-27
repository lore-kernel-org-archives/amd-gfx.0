Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665C9C54F30
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 03:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0813A10E031;
	Tue, 27 May 2025 03:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DCGOvrDZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011F810E031
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 03:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiNwuexcD1QYI6RJYAeNC2hy4pZYKLUcjW41PtNBQv5Y44/KQy2InyF2dNgknyIZxq4AqcFeXOj2WRfSIOlOfgPP/hkGm5L5XFrGYRQylQuX7J3zvyYAnKS9ekQ5QWzvrO2nbyAk0klNwkjMgn6fGA5JDf2OdMS/WzN2kXUDFGH+fqQ/VzG6SObu6dDv+mCqYF6/Zg/9DtyjYweN3mhja4HWzaVUMRQsmwQQ35WsV6hiGun6U3OeYaRsjFm1Siixs3BCZD7PYn2OVotwz9dYMo2flHS7BGqzVX2907OP8SGjfN0cAUFPqqZYEdSGt96TpjcgZ6Av2SH0yaOyh01eIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gObfWmWMTthoPoRSELc5SLQOpSw0onjqQ/hGGXJ4EM8=;
 b=m3MTZ/zStU4HSju75F+OQ45NwCVVhyClG1Q/5AE+rrvl7ZKmth4WwKp6GdlDmXYI5+wWZuqoZyK3aLt2jiCbksz+VvAdMmFU7timKmfYWxGMp58nDiQSelQE5RbPfKtHGLhSWkjvvydLxzX+ZowM3atDIBAMXGgK3Rus6+DbkzA9GDwCdUm0VbFPEDBvKHOq81QThbV9/MIdsL9eaomyIeM1fmpupMZfCJlOcYYe6TtSqAhjRSfWKIf0Jkx7mpgZISPBR1SPreDk4dSpO9dSBres70orj3GkggO3DJ+kju08slNyj3VPJDu54bEflB7l3XwhqJ/+3ehRcJq9mIeKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gObfWmWMTthoPoRSELc5SLQOpSw0onjqQ/hGGXJ4EM8=;
 b=DCGOvrDZKpWoqVWoBsEDODswoaz8kMyFO259+ou+c9d/06pPSyRJUs8vskD5Eosk1gkrBycMtXSqkl9fkV4VB3XqKTpQJmptJIw3Y2hqOvGFOxBoKSRXxWzxJe3uDeFmWY/OmaBnkOcoIOAEjlK3jYMblnhGVXUiMYBA8s5u0y8=
Received: from SJ0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:a03:3a0::11)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 27 May
 2025 03:46:26 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::c) by SJ0PR03CA0246.outlook.office365.com
 (2603:10b6:a03:3a0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.23 via Frontend Transport; Tue,
 27 May 2025 03:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 03:46:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 22:46:23 -0500
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 26 May 2025 22:46:22 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdkfd: Move the process suspend and resume out of full
 access
Date: Tue, 27 May 2025 11:46:20 +0800
Message-ID: <20250527034620.37231-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbac74e-d4a6-4947-4541-08dd9cd10d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kv1107MJuN5ZN8Vxb+fSaLCnzAlicXY8iZj4A7KCvk2oQaefse55w5exskLk?=
 =?us-ascii?Q?53Os2864NPnC0tlr6ko/FIrwpep2DitfB8scj0SGrsmOz0xZQ5d3yrBcqSZ1?=
 =?us-ascii?Q?3dgPehA1TJZBr6+222ssw4tm+urS50fvkk9fxYtfYqIAH5E1BPg2HL0b6Y0V?=
 =?us-ascii?Q?+BGw81h/aG+IUj+VYLL6PyIOGai+ZYScjtgTl2D8+W6NKEJaxfxPRkYyIyIc?=
 =?us-ascii?Q?GaBfor1YuIwRuEiKdLkBh1ereb8j9fbZop+phtbgo5Ppcf6fkUG7s5v1LNP9?=
 =?us-ascii?Q?m/dw640x42slxFoIPTwnNWlA9XS1TsFuFerxLFPidbAfmEy2xkR1wtOlcobi?=
 =?us-ascii?Q?ZDdg4c0hcad8DXOOV47adXsstu1ZRfndT1HZ9KZTPRqPOutksgV0glqW4PXt?=
 =?us-ascii?Q?RaGdzR52G5+4iNwLHFFtrZScWd0YcG8Qo7dy8mTpG4rbXIXsN79PBEmsa4Oj?=
 =?us-ascii?Q?uDyPNrf8rlgTghWxCoUuL1HTegJkEsYXk5fEZ+9gS/lmkCnHc9KzXhOTA53e?=
 =?us-ascii?Q?mi7VtEcMmwOCfCgEGjZD8i2NWXnPfqwyJ7zd+N9WIhA8i8rLKJMSi1E7B/En?=
 =?us-ascii?Q?FW80cW/c15ZFzWh8hxV6S8complP3O1B7vlhuw2OjtgJP7PZrioBhIBs0Jfm?=
 =?us-ascii?Q?y4ydvpTeoftOyb26oClURRBZA38PLeyNc49gra7tjB2FSKy11fRQYCKiyV9Q?=
 =?us-ascii?Q?n+aT0ogB+c42bJBsrtjB5hS2tF6qdaeRoQXhtZgQbHK35kjp/XZcLJHY1Ky3?=
 =?us-ascii?Q?X1kNspZUwTe6bJS5cA6pvndXJHjDsWGRokTovmvAgceL1RG/zaAhtVCeaElZ?=
 =?us-ascii?Q?7FmXqtUkrtyNz1H0/LDtNctju3SaQuwWz7bzU0RdYI7wM9m+SzwFqQQ1c4VM?=
 =?us-ascii?Q?ceGSv31VeNpMT/hAJENyllgnZYd9lg+qv0heErF1uSWboAM0kqDtPURJnVCD?=
 =?us-ascii?Q?BaWsNVObUzcKFpxgCr3qIyeDtU0InrpbAmakeo3tGP2EhjC8ktpvOktrY2Oo?=
 =?us-ascii?Q?2LFgaUjUPjSXpLq/DOQcQm/wCGOVYwNyvXvr2OQqddxfuSwfFgZq4E8bSb7j?=
 =?us-ascii?Q?7dce043vyqHVKm5G79GlE2FFnqYzfD42/7gnbPqudyQZsgr2UMojJupRfD+V?=
 =?us-ascii?Q?AJzEzSQTgoGftS+BQJcCBAw7hhhOXRThpkKbDs2UYfEL4DFGN4rOmWuASZk0?=
 =?us-ascii?Q?QIsLIEuwEhRveCfwVNORNd3v+u5lEqccxh0WZkG2iKRj9/ra2gjYyIW753Rg?=
 =?us-ascii?Q?KVL0QFZ3WVLribFnqUmv6fwrMcfH8m1wpPmm3m83x0Hk/3y690BXIE818Px9?=
 =?us-ascii?Q?yojh2020IH7Ah2HuP3zAjUGemmfIlnEn8P/rznvcBMJBceQnq2FEMpL/h/6O?=
 =?us-ascii?Q?q6zYFi59sM1iZBZ6ScanDU7CjqiIYvYXYw+d7ePqNUpVOFl5O7Xlw7D2pVC8?=
 =?us-ascii?Q?c/1p8lN13DhBJlrMmE3mPsZpyfF9X65eIZ8DFagBR2+gkA/9L0u6AeO2Edlj?=
 =?us-ascii?Q?Nfj6oNDz2Cy8Fhha02zZIQig1mnyvEDLB55x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 03:46:24.5070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbac74e-d4a6-4947-4541-08dd9cd10d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779
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
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 ++++++++++++++++++----
 4 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c166e059ead3..ccf898a73897 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -265,6 +265,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 	return r;
 }
 
+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool run_pm)
+{
+	if (adev->kfd.dev)
+		kgd2kfd_suspend_process(adev->kfd.dev, run_pm, true);
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
index 3a54f90ffcf8..78eaac829a58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -162,6 +162,8 @@ void amdgpu_amdkfd_fini(void);
 
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool run_pm);
+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool run_pm);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
@@ -491,6 +493,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm, bool force);
+int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd,
 		      struct amdgpu_reset_context *reset_context);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
@@ -541,6 +545,15 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return 0;
 }
 
+static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm, bool force)
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
index 4e343561a17d..34f040820546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5032,7 +5032,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	amdgpu_device_ip_suspend_phase1(adev);
 
 	if (!adev->in_s0ix)
-		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
+		amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_runtime(adev) || adev->in_runpm);
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
@@ -5049,6 +5049,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
+	if (!adev->in_s0ix)
+		amdgpu_amdkfd_suspend_process(adev, adev->in_runpm);
+
 	r = amdgpu_dpm_notify_rlc_state(adev, false);
 	if (r)
 		return r;
@@ -5119,7 +5122,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	}
 
 	if (!adev->in_s0ix) {
-		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
+		r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_runtime(adev) || adev->in_runpm);
 		if (r)
 			goto exit;
 	}
@@ -5136,6 +5139,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
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
index bc8f4e8f9905..23c30320ca3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1061,13 +1061,8 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
 		return;
 
 	/* for runtime suspend, skip locking kfd */
-	if (!run_pm) {
-		mutex_lock(&kfd_processes_mutex);
-		/* For first KFD device suspend all the KFD processes */
-		if (++kfd_locked == 1)
-			kfd_suspend_all_processes(force);
-		mutex_unlock(&kfd_processes_mutex);
-	}
+	kgd2kfd_suspend_process(kfd, run_pm, force);
+
 
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
@@ -1088,6 +1083,37 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 			return ret;
 	}
 
+	ret = kgd2kfd_resume_process(kfd, run_pm);
+
+
+	return ret;
+}
+
+void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm, bool force)
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
+			kfd_suspend_all_processes(force);
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

