Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C82D5C0C0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 06:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671A010E6C2;
	Tue, 16 Dec 2025 06:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R+huUJN6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CAC110E6D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 06:00:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7638A43605;
 Tue, 16 Dec 2025 06:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDF9C19422;
 Tue, 16 Dec 2025 06:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765864856;
 bh=KZiiUyoTeYjamhghQznLG8JBH5kbZYoRmlU9ApVKDFM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R+huUJN6taJ2u8dVpxzFu/woK+jSIiqdlJ9bJCnPtwcgZ1ZT1nqodd3Zgd4KKIYqE
 udOYY3EnsDQ/D0C4sKv243zc2W3uUF36RNRQ7SFOTfwspgkCfp3CQ+bT0QsaETlsmH
 yS/uMmndhSybD/1SzjX2T3zyotA08LRfN/2TRb7CMJyEvV69fm0MlQKU0fD2rPEU2K
 Blq8i9fFI2Zqo5DJCygpYCfNMWj6kxDvXTaYD3JXSpoQqUJCtR1XySAEawxe4c5MRc
 utigQWj3eMQdU/IdMqupFrwSi49kXVSnJupof2RM/Ylejh7VoLMsSyWGE9Lb9eFMiP
 yJPEicFT2dFXg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Harish.Kasiviswanathan@amd.com
Subject: [PATCH v3 2/2] amdkfd: Add device links between kfd device and amdgpu
 device
Date: Tue, 16 Dec 2025 00:00:46 -0600
Message-ID: <20251216060046.3131-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216060046.3131-1-superm1@kernel.org>
References: <20251216060046.3131-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Mapping out a KFD device to a GPU can be done manually by looking at the
domain and location properties.  To make it easier to discover which
KFD device goes with what GPU add a link to the GPU node.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
Cc: Harish.Kasiviswanathan@amd.com>
v3:
 * Create link when topology created
 * Only call update topology when amdgpu is called
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c       | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h |  2 ++
 5 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 67a01c4f38855..870a727d6e938 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -910,3 +910,11 @@ int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
 
 	return r;
 }
+
+int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev)
+{
+	if (!adev->kfd.init_complete || !adev->kfd.dev)
+		return 0;
+
+	return kfd_topology_update_sysfs();
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 8bdfcde2029b5..07aa519b28d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -268,6 +268,7 @@ int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
 int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
 	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
 bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
+int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev);
 
 
 /* Read user wptr from a specified user address space with page fault
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 467326871a81e..d4c8b03b6bf57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5123,6 +5123,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 */
 	r = amdgpu_device_sys_interface_init(adev);
 
+	r = amdgpu_amdkfd_create_sysfs_links(adev);
+	if (r)
+		dev_err(adev->dev, "Failed to create KFD sysfs link: %d\n", r);
+
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		r = amdgpu_pmu_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a95be23fd0397..5f14c66902f9d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -571,6 +571,9 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
 	struct kfd_mem_properties *mem;
 	struct kfd_perf_properties *perf;
 
+	if (dev->gpu)
+		sysfs_remove_link(dev->kobj_node, "device");
+
 	if (dev->kobj_iolink) {
 		list_for_each_entry(iolink, &dev->io_link_props, list)
 			if (iolink->kobj) {
@@ -819,6 +822,18 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 			return ret;
 	}
 
+	/*
+	 * create a link to the GPU node, but don't do a reverse one since it might
+	 * not match after spatial partitioning
+	 */
+	if (dev->gpu) {
+		struct kobject *amdgpu_kobj = &dev->gpu->adev->dev->kobj;
+
+		ret = sysfs_create_link(dev->kobj_node, amdgpu_kobj, "device");
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -848,7 +863,7 @@ static void kfd_remove_sysfs_node_tree(void)
 		kfd_remove_sysfs_node_entry(dev);
 }
 
-static int kfd_topology_update_sysfs(void)
+int kfd_topology_update_sysfs(void)
 {
 	int ret;
 
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 9aba8596faa7e..0ee1a7d3a73f5 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -335,4 +335,6 @@ struct kfd2kgd_calls {
 					  int engine, int queue);
 };
 
+int kfd_topology_update_sysfs(void);
+
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.43.0

