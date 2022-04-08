Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB55C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 13:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0328810F225;
	Fri,  8 Apr 2022 13:50:32 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE80010F0FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 08:46:17 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id gt4so8014209pjb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Apr 2022 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gDyQGG05oDhpXrRcwaGE6a1VBsuGFKHQ1kambJSFz3I=;
 b=Pjxu8QXJwwMR9rfqqTSPpo7doU7P7YBdJt3uck5MP5ibh8CLNGbb8kVoBwGc85JP7d
 qdKFjsD1nLMph2KatDPaJF104BB/y1PSmDRY04wVYa5vUY6M1PfXi0VvtmYuu3n7Cwpl
 U/4TE/rGcXbVvXcsKNf+/mrlckYnFMcxcAZnzCKUK5+Y1LBEn6Sek0EYjgxYO/eG/ck/
 Yy/Qpwg7lNHzwWpbKsSDpadFsXcOF3ERFQKp958LbfmiKgkCrHDdLG6KST9kYYfzNCTB
 CscOdfIgLB8DaHmG7gW7v9JXqbwV9/zonFiicStW00AEOjEFnxdMpcgBQ2XGILeZSKtf
 vSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gDyQGG05oDhpXrRcwaGE6a1VBsuGFKHQ1kambJSFz3I=;
 b=6qh3GWW4IJFcFywW3C7Uf98sm25FNZXe0kvLV+5HSGIaTg4BkVT12qexyAFC5DI/TT
 2DgydgP30dxut/Kr0vuaOvkimjSal+UwQAoz4tfmEiwhJCwOGr0F4BKHRW543mebAP82
 DK+1gp9lvyy5EK8oKTP8kcqVeUM+jLFKmLyPenE78S0v6bD1tMBH2tx6076d/SSqs08d
 Tl3V8Ps07M/3D4RzvbyGL3CN7+f5WSTiMel8qIrCMAZYyabDSutlAKPNCpbgGu8lCCMh
 rxBBJCpiZnOfiTfJtq2PLQQJdJgd9HTVqQWVF/9ZZeSS3N7m2kW413F4qvfGI2PGpHi3
 rWSQ==
X-Gm-Message-State: AOAM5324BhhLqhQHXqwZL5UGdDzkXLy2YYU4+6UDTLnfBCbRXqmipdXa
 6VC4lZGDkExJA9uQoMXlDRX9gw2X2TVUHfnATaY=
X-Google-Smtp-Source: ABdhPJxEuET5uNJakFFSMOkEXCuChvvxtJF9gEX0QxFDiU3vRkvCuj5/jS3j+Al9HH5ToWiapCle2Q==
X-Received: by 2002:a17:90b:17c5:b0:1c6:3639:7daf with SMTP id
 me5-20020a17090b17c500b001c636397dafmr20623845pjb.105.1649407577234; 
 Fri, 08 Apr 2022 01:46:17 -0700 (PDT)
Received: from netturing-04.corp.microsoft.com ([167.220.233.104])
 by smtp.gmail.com with ESMTPSA id
 t38-20020a634626000000b0039cc30b7c93sm4274053pga.82.2022.04.08.01.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Apr 2022 01:46:16 -0700 (PDT)
From: Shuotao Xu <xushuotao@gmail.com>
X-Google-Original-From: Shuotao Xu <shuotaoxu@microsoft.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: Cleanup IO links during KFD device removal
Date: Fri,  8 Apr 2022 08:45:43 +0000
Message-Id: <20220408084544.9313-1-shuotaoxu@microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Apr 2022 13:50:30 +0000
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Andrey.Grodzovsky@amd.com,
 Felix.Kuehling@amd.com, pengc@microsoft.com, Lei.Qu@microsoft.com,
 Shuotao Xu <shuotaoxu@microsoft.com>, Ran.Shu@microsoft.com,
 Ziyue.Yang@microsoft.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, the IO-links to the device being removed from topology,
are not cleared. As a result, there would be dangling links left in
the KFD topology. This patch aims to fix the following:
1. Cleanup all IO links to the device being removed.
2. Ensure that node numbering in sysfs and nodes proximity domain
   values are consistent after the device is removed:
   a. Adding a device and removing a GPU device are made mutually
      exclusive.
   b. The global proximity domain counter is no longer required to be
      an atomic counter. A normal 32-bit counter can be used instead.
3. Update generation_count to let user-mode know that topology has
   changed due to device removal.

Reviewed-by: Shuotao Xu <shuotaoxu@microsoft.com>
CC: Shuotao Xu <shuotaoxu@microsoft.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 79 ++++++++++++++++++++---
 3 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 1eaabd2cb41b..afc8a7fcdad8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1056,7 +1056,7 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 	 * table, add corresponded reversed direction link now.
 	 */
 	if (props && (iolink->flags & CRAT_IOLINK_FLAGS_BI_DIRECTIONAL)) {
-		to_dev = kfd_topology_device_by_proximity_domain(id_to);
+		to_dev = kfd_topology_device_by_proximity_domain_no_lock(id_to);
 		if (!to_dev)
 			return -ENODEV;
 		/* same everything but the other direction */
@@ -2225,7 +2225,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	 */
 	if (kdev->hive_id) {
 		for (nid = 0; nid < proximity_domain; ++nid) {
-			peer_dev = kfd_topology_device_by_proximity_domain(nid);
+			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
 			if (!peer_dev->gpu)
 				continue;
 			if (peer_dev->gpu->hive_id != kdev->hive_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e1b7e6afa920..8a43def1f638 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1016,6 +1016,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu);
 int kfd_topology_remove_device(struct kfd_dev *gpu);
 struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
 						uint32_t proximity_domain);
+struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
+						uint32_t proximity_domain);
 struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
 struct kfd_dev *kfd_device_by_id(uint32_t gpu_id);
 struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3bdcae239bc0..874a273b81f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -46,27 +46,38 @@ static struct list_head topology_device_list;
 static struct kfd_system_properties sys_props;
 
 static DECLARE_RWSEM(topology_lock);
-static atomic_t topology_crat_proximity_domain;
+static uint32_t topology_crat_proximity_domain;
 
-struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
+struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
 						uint32_t proximity_domain)
 {
 	struct kfd_topology_device *top_dev;
 	struct kfd_topology_device *device = NULL;
 
-	down_read(&topology_lock);
-
 	list_for_each_entry(top_dev, &topology_device_list, list)
 		if (top_dev->proximity_domain == proximity_domain) {
 			device = top_dev;
 			break;
 		}
 
+	return device;
+}
+
+struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
+						uint32_t proximity_domain)
+{
+	struct kfd_topology_device *device = NULL;
+
+	down_read(&topology_lock);
+
+	device = kfd_topology_device_by_proximity_domain_no_lock(
+							proximity_domain);
 	up_read(&topology_lock);
 
 	return device;
 }
 
+
 struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id)
 {
 	struct kfd_topology_device *top_dev = NULL;
@@ -1060,7 +1071,7 @@ int kfd_topology_init(void)
 	down_write(&topology_lock);
 	kfd_topology_update_device_list(&temp_topology_device_list,
 					&topology_device_list);
-	atomic_set(&topology_crat_proximity_domain, sys_props.num_devices-1);
+	topology_crat_proximity_domain = sys_props.num_devices-1;
 	ret = kfd_topology_update_sysfs();
 	up_write(&topology_lock);
 
@@ -1295,8 +1306,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
 
-	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
-
 	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
 	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
 		struct kfd_topology_device *top_dev;
@@ -1321,12 +1330,16 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	 */
 	dev = kfd_assign_gpu(gpu);
 	if (!dev) {
+		down_write(&topology_lock);
+		proximity_domain = ++topology_crat_proximity_domain;
+
 		res = kfd_create_crat_image_virtual(&crat_image, &image_size,
 						    COMPUTE_UNIT_GPU, gpu,
 						    proximity_domain);
 		if (res) {
 			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
 			       gpu_id);
+			topology_crat_proximity_domain--;
 			return res;
 		}
 		res = kfd_parse_crat_table(crat_image,
@@ -1335,10 +1348,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		if (res) {
 			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
 			       gpu_id);
+			topology_crat_proximity_domain--;
 			goto err;
 		}
 
-		down_write(&topology_lock);
 		kfd_topology_update_device_list(&temp_topology_device_list,
 			&topology_device_list);
 
@@ -1485,25 +1498,73 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	return res;
 }
 
+static void kfd_topology_update_io_links(int proximity_domain)
+{
+	struct kfd_topology_device *dev;
+	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
+	/*
+	 * The topology list currently is arranged in increasing
+	 * order of proximity domain.
+	 *
+	 * Two things need to be done when a device is removed:
+	 * 1. All the IO links to this device need to be
+	 *    removed.
+	 * 2. All nodes after the current device node need to move
+	 *    up once this device node is removed from the topology
+	 *    list. As a result, the proximity domain values for
+	 *    all nodes after the node being deleted reduce by 1.
+	 *    This would also cause the proximity domain values for
+	 *    io links to be updated based on new proximity
+	 *    domain values.
+	 */
+	list_for_each_entry(dev, &topology_device_list, list) {
+		if (dev->proximity_domain > proximity_domain)
+			dev->proximity_domain--;
+
+		list_for_each_entry_safe(iolink, tmp, &dev->io_link_props, list) {
+			/*
+			 * If there is an io link to the dev being deleted
+			 * then remove that IO link also.
+			 */
+			if (iolink->node_to == proximity_domain) {
+				list_del(&iolink->list);
+				dev->io_link_count--;
+				dev->node_props.io_links_count--;
+			} else if (iolink->node_from > proximity_domain) {
+				iolink->node_from--;
+			} else if (iolink->node_to > proximity_domain) {
+				iolink->node_to--;
+			}
+		}
+
+	}
+}
+
 int kfd_topology_remove_device(struct kfd_dev *gpu)
 {
 	struct kfd_topology_device *dev, *tmp;
 	uint32_t gpu_id;
 	int res = -ENODEV;
+	int i = 0;
 
 	down_write(&topology_lock);
 
-	list_for_each_entry_safe(dev, tmp, &topology_device_list, list)
+	list_for_each_entry_safe(dev, tmp, &topology_device_list, list) {
 		if (dev->gpu == gpu) {
 			gpu_id = dev->gpu_id;
 			kfd_remove_sysfs_node_entry(dev);
 			kfd_release_topology_device(dev);
 			sys_props.num_devices--;
+			kfd_topology_update_io_links(i);
+			topology_crat_proximity_domain = sys_props.num_devices-1;
+			sys_props.generation_count++;
 			res = 0;
 			if (kfd_topology_update_sysfs() < 0)
 				kfd_topology_release_sysfs();
 			break;
 		}
+		i++;
+	}
 
 	up_write(&topology_lock);
 
-- 
2.25.1

