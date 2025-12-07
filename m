Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D91D2CE17
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Dec 2025 14:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 718FF10E00E;
	Sun,  7 Dec 2025 14:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="r0coVMnh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD6610E03A
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 14:04:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 24B464400A
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 14:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2434C4CEFB;
 Sun,  7 Dec 2025 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765116249;
 bh=aNk6iTVVagPZB9ljs28lW9z1srVx6wKAIItbkofhZmM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r0coVMnhbHCvQG1Sdw3LfT2rkpL7hi0l/fD6GwrgTh1JgJS7KODktErpp8CO6h70W
 4BH9G34DX35bSQLfDZ14Up1S+ThEAHWWJvcvaTHMlIncQAvnTkssMvvpFlmOoVriTY
 kickZtJbSXj5uyJ5/pHoLWPgKWjOTM6d0dpOR+Yw8hChE4Jt5ea9Vi+ABtl/XsY3vI
 3lF+XioejqyB9NEJXUwIRnnQrJfOy54tuYdqhceDZsYoSOaIYB0fRQ+qS6aTotPdBU
 LtrdjKFCh2AR+MrJJrJ4fs0mWByG1DXfhPFi1YacNFHovM8zWdOY7s3LFIlNPZU9+G
 CgmNIvPYyC59w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 2/2] amdkfd: Add device links between kfd device and amdgpu
 device
Date: Sun,  7 Dec 2025 08:04:02 -0600
Message-ID: <20251207140402.121338-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251207140402.121338-1-superm1@kernel.org>
References: <20251207140402.121338-1-superm1@kernel.org>
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
KFD device goes with what GPU add bidirectional links.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  8 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 36 +++++++++++++++++++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 ++
 5 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a2879d2b7c8ec..5d6cf3adfa7b8 100644
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
+	return kgd2kfd_create_sysfs_links(adev->kfd.dev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 2fa5f1925f5a3..542f5bc2dd189 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -270,6 +270,7 @@ int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
 int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
 	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
 bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
+int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev);
 
 
 /* Read user wptr from a specified user address space with page fault
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a0213a07023d..44c9320d72a56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4947,6 +4947,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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
index 9c3e8f946a3d5..be673e35978eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -79,6 +79,37 @@ struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
 	return device;
 }
 
+int kgd2kfd_create_sysfs_links(struct kfd_dev *kfd)
+{
+	struct kfd_topology_device *top_dev;
+	int ret = -ENODEV;
+
+	if (!kfd)
+		return -EINVAL;
+
+	down_read(&topology_lock);
+
+	list_for_each_entry(top_dev, &topology_device_list, list) {
+		struct kobject *amdgpu_kobj;
+
+		if (!top_dev->gpu || top_dev->gpu->kfd != kfd || !top_dev->kobj_node)
+			continue;
+
+		amdgpu_kobj = &top_dev->gpu->adev->dev->kobj;
+		ret = sysfs_create_link(top_dev->kobj_node, amdgpu_kobj, "device");
+		if (ret)
+			break;
+
+		ret = sysfs_create_link(amdgpu_kobj, top_dev->kobj_node, "kfd");
+		if (ret)
+			sysfs_remove_link(top_dev->kobj_node, "device");
+		break;
+	}
+
+	up_read(&topology_lock);
+	return ret;
+}
+
 struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id)
 {
 	struct kfd_topology_device *top_dev = NULL;
@@ -567,6 +598,11 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
 	struct kfd_mem_properties *mem;
 	struct kfd_perf_properties *perf;
 
+	if (dev->gpu) {
+		sysfs_remove_link(dev->kobj_node, "device");
+		sysfs_remove_link(&dev->gpu->adev->dev->kobj, "kfd");
+	}
+
 	if (dev->kobj_iolink) {
 		list_for_each_entry(iolink, &dev->io_link_props, list)
 			if (iolink->kobj) {
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 9aba8596faa7e..f6db1dc634399 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -335,4 +335,6 @@ struct kfd2kgd_calls {
 					  int engine, int queue);
 };
 
+int kgd2kfd_create_sysfs_links(struct kfd_dev *kfd);
+
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.43.0

