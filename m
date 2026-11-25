Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F031606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=m05SfU1L;
	dkim=pass (2048-bit key) header.d=simple-co.de header.i=@simple-co.de header.a=rsa-sha256 header.s=201801 header.b=P1iPX9hD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7EE2112115;
	Thu, 26 Nov 2026 08:09:53 +0000 (UTC)
Received: from mail.bin-co.de (mail.bin-co.de [37.120.183.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9180F10FCBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616379;
 bh=lTjh2SPWuHQe2JTA1qQrMmdfkHbwqqZkQdZ1yDLn0bQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m05SfU1LXqT0KrzGMLKwTUPRQlajbdLP3blThXVbRNSJHQ4drJMXevf7Y5BvPVnWo
 v9u/IBwIsR7lWJ0Vzwvhe5ngPB9IEVGSueLFDo2860aZQ5u9Q89jRTJ1KsI9kHZ5L/
 RkVCuxuPy3PGL1lYau/CcuqH5XdMjMfTv2ed36ow6U8D2FfpEnSkdtZqotnkO6gT5L
 +aaAE5ofSOdiXNVutK+kKVEvRtA+jgXHYQCFoVEsVU/HFpHW+cX6JvGfZdY4Qfm/ry
 78W+RLUkLE444o5b56cxEK3C3bidvllo3LF5bujaFVABMemNhswfLwv6YBdCBusrby
 qirZPHaiOi+fg==
Received: from localhost (localhost [127.0.0.1])
 by mail.bin-co.de (Postfix) with ESMTP id AC3D217F364;
 Wed, 25 Nov 2026 15:19:39 +0100 (CET)
X-Virus-Scanned: Debian amavis at v2202603343726440230.luckysrv.de
Received: from mail.bin-co.de ([127.0.0.1])
 by localhost (mail.bin-co.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_nFszcKL0kx; Wed, 25 Nov 2026 15:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simple-co.de;
 s=201801; t=1795616378;
 bh=lTjh2SPWuHQe2JTA1qQrMmdfkHbwqqZkQdZ1yDLn0bQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P1iPX9hDdte+3o/HLaGrVMa/1ZcXxSIyNrMaNSybGbdeHN+79qISh7LfgXiXL+L3r
 us81ypIU+MhhEcQMt8wyw3xWoM63yJ9jXGSISkiW/s9IJLwUSjX0nx4Eu0sAmASVr+
 53i2iOjjku8mxOyNSPva5+Q08zd1xKF7uOq1LlKMjX52bNDK8mfIPaMdSYt5k2Keyj
 wcgJybQBCwU2ZDY/22kx2jI0gd/Iu2kHCcjXm5qZNhBthRdhVsIYaaQObGls1ii+wj
 frzF83McBcQB4KKuNlt5Ju6JyelLpbkAG143zGcM5VwITfJvpW5D19vm5kHdQ6lMnZ
 M3I6Tcw+p17Mg==
Received: from deepblue.zlan.intra (wan.zappel.net [IPv6:2a02:8106:4:c300::1])
 (Authenticated sender: zappel@simple-co.de)
 by mail.bin-co.de (Postfix) with ESMTPSA id CADDF17F368;
 Wed, 25 Nov 2026 15:19:38 +0100 (CET)
From: Armas Spann <zappel@simple-co.de>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, Armas Spann <zappel@simple-co.de>
Subject: [PATCH v2 9/9] drm/amdkfd: force CWSR on with more than one MES GPU
Date: Wed, 25 Nov 2026 15:19:32 +0100
Message-ID: <20261125141933.154222-10-zappel@simple-co.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125141933.154222-1-zappel@simple-co.de>
References: <20261125141933.154222-1-zappel@simple-co.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With amdgpu.cwsr_enable=0 the MQD of a compute queue carries no
QSWITCH_MODE and no save area. Such a queue cannot be preempted. It
leaves the hardware only when its running waves have finished. MES
waits 2 s for that and then fails the command that asked for the unmap.

On a system with two R9700 (gfx 12.0.1, MES 0x97) that run RCCL
collectives between them this ends the job. Between 90 and 118 s into a
run MES answered the REMOVE_QUEUE of a queue eviction with
0x8100030100000000 and the SUSPEND that followed with
0x8100060200000000, each 2 s after the command, first on one GPU and 4 s
later on the other, and one queue per GPU had to be reset. The timing
fits a kernel on one GPU that waits for its peer on the other GPU while
the queue of that peer is evicted: such a kernel cannot drain. With CWSR
enabled the same machine ran an RCCL all_reduce load for 150 s and for
600 s, 343647 iterations in the longer run, without one MES error.

Nothing tells a user who sets cwsr_enable=0 that it takes preemption
away. Ignore the setting on a discrete GPU that is scheduled by MES when
there is a second one in the system, and say so in the log.

The timeout is that of MES, so this is limited to hardware that uses
it, GC 11 and later. Older hardware does not have this path and keeps
what the parameter says. So does an integrated GPU. The fan boost for
multi-GPU systems draws the same line and counts discrete GPUs only.

The check is made per device in kfd_cwsr_init(), the one place that
reads the parameter. The parameter itself is not changed. It also
applies to the devices that are left alone, and one that is probed later
must not get CWSR because of a device that was probed before it. The
warning is printed for each device that is affected.

The GPUs are probed one after the other. A device is added to mgpu_info
at the end of its initialization, after KFD has been set up, so when
kfd_cwsr_init() runs for the first GPU nothing there shows the second
one. kfd->num_nodes counts the partitions of one device. Add
amdgpu_pci_has_mes_peer(), which walks the PCI bus instead. A device is
a peer if it matches one of the class entries of the id table, which is
how every GPU with MES is matched, if it is not left to radeon, and if no
other driver has it or was assigned it with driver_override. That leaves
out a GPU that is passed through with vfio-pci. For a device that is in
mgpu_info already, its GC version and its APU flag decide.

A device that has not been probed yet is known by its PCI ID only. An
integrated GPU, or a GPU older than GC 11 without an entry of its own in
the id table, that is probed after the discrete GPU is taken for a peer.
CWSR, the default, is then enforced where it was not needed. A GPU that
is hot-added after another one has been set up without CWSR gets CWSR
itself, but does not change the device that is already running.

Signed-off-by: Armas Spann <zappel@simple-co.de>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 99 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 26 ++++++-
 3 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7e1b9a70f..c3ab385c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1306,6 +1306,7 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock);
 
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
+bool amdgpu_pci_has_mes_peer(struct amdgpu_device *adev);
 
 pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
 					   pci_channel_state_t state);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d2db20c17..e80bcc711 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -760,11 +760,14 @@ MODULE_PARM_DESC(hws_max_conc_proc,
  * DOC: cwsr_enable (int)
  * CWSR(compute wave store and resume) allows the GPU to preempt shader execution in
  * the middle of a compute wave. Default is 1 to enable this feature. Setting 0
- * disables it as only in non-HWS mode.
+ * disables it as only in non-HWS mode. A discrete GPU that is scheduled by MES
+ * (GC 11 and later) keeps CWSR on when there is a second one in the system,
+ * because a queue that cannot be preempted can block the eviction of a queue on
+ * the other GPU.
  */
 int cwsr_enable = 1;
 module_param(cwsr_enable, int, 0444);
-MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off (debugging only), 1 = On (Default))");
+MODULE_PARM_DESC(cwsr_enable, "CWSR enable (0 = Off (ignored on multi-GPU with MES), 1 = On (Default))");
 
 /**
  * DOC: max_num_of_queues_per_device (int)
@@ -3171,6 +3174,98 @@ static struct pci_driver amdgpu_kms_pci_driver = {
 	.dev_groups = amdgpu_sysfs_groups,
 };
 
+/*
+ * Returns 1 if @pdev is a registered discrete GPU that uses MES, 0 if it is
+ * registered and is not one, -ENODEV if it is not registered.
+ */
+static int amdgpu_pci_registered_mes_dgpu(struct pci_dev *pdev)
+{
+	struct amdgpu_device *adev;
+	int r = -ENODEV;
+	int i;
+
+	mutex_lock(&mgpu_info.mutex);
+
+	for (i = 0; i < mgpu_info.num_gpu; i++) {
+		adev = mgpu_info.gpu_ins[i].adev;
+		if (adev->pdev != pdev)
+			continue;
+
+		r = !(adev->flags & AMD_IS_APU) &&
+		    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0);
+		break;
+	}
+
+	mutex_unlock(&mgpu_info.mutex);
+
+	return r;
+}
+
+static bool amdgpu_pci_may_be_mes_dgpu(struct pci_dev *pdev)
+{
+	const struct pci_device_id *id;
+	struct pci_driver *drv;
+	int i, r;
+
+	/*
+	 * MES is used from GC 11 on. Those devices have no entry of their own
+	 * in the id table. They match one of the class entries at its end.
+	 */
+	id = pci_match_id(pciidlist, pdev);
+	if (!id || (id->driver_data & AMD_ASIC_MASK) != CHIP_IP_DISCOVERY)
+		return false;
+
+	/* The class entries also match what is left to radeon. */
+	for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++)
+		if (amdgpu_unsupported_pciidlist[i] == pdev->device)
+			return false;
+
+	r = amdgpu_pci_registered_mes_dgpu(pdev);
+	if (r >= 0)
+		return r;
+
+	/* Not probed yet, unless another driver has it or was assigned it */
+	drv = READ_ONCE(pdev->driver);
+	if (drv && drv != &amdgpu_kms_pci_driver)
+		return false;
+
+	return device_match_driver_override(&pdev->dev,
+					    &amdgpu_kms_pci_driver.driver) != 0;
+}
+
+/**
+ * amdgpu_pci_has_mes_peer - look for another discrete GPU that uses MES
+ * @adev: the device that asks. It is left out.
+ *
+ * Devices are probed one after the other. While the first one is being
+ * initialized the driver has not seen the others yet, so the list of
+ * registered GPUs does not tell it whether it is alone. The PCI core has
+ * enumerated all of them by then, so walk the bus.
+ *
+ * For a device that is registered the GC version and the APU flag are known
+ * and decide. A device that has not been probed yet is taken for a peer if it
+ * is set up by IP discovery and no other driver has it or was assigned it.
+ * Whether it is integrated or older than GC 11 cannot be told from the PCI
+ * device.
+ *
+ * Returns:
+ * True if there is such a device.
+ */
+bool amdgpu_pci_has_mes_peer(struct amdgpu_device *adev)
+{
+	struct pci_dev *pdev = NULL;
+
+	for_each_pci_dev(pdev) {
+		if (pdev == adev->pdev || !amdgpu_pci_may_be_mes_dgpu(pdev))
+			continue;
+
+		pci_dev_put(pdev);
+		return true;
+	}
+
+	return false;
+}
+
 static int __init amdgpu_init(void)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index f631047e8..d2bbc78ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -512,7 +512,31 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 
 static void kfd_cwsr_init(struct kfd_dev *kfd)
 {
-	if (cwsr_enable && kfd->device_info.supports_cwsr) {
+	struct amdgpu_device *adev = kfd->adev;
+	bool enable = cwsr_enable;
+
+	/*
+	 * Without CWSR a compute queue cannot be preempted. It is unmapped
+	 * only once its running waves have finished. MES waits 2 s for that
+	 * and then fails the command. With two GPUs a kernel on one of them
+	 * can wait for a kernel on the other one. If the queue of that one is
+	 * evicted, the wait does not end and the unmap times out. Do not let
+	 * cwsr_enable=0 through in that case.
+	 *
+	 * Only a discrete GPU that is scheduled by MES is concerned, which is
+	 * GC 11 and later. Older hardware and integrated GPUs keep what the
+	 * parameter says. The parameter itself is not changed, it also
+	 * applies to the devices that are left alone here.
+	 */
+	if (!enable && kfd->device_info.supports_cwsr &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
+	    !(adev->flags & AMD_IS_APU) && amdgpu_pci_has_mes_peer(adev)) {
+		dev_warn(adev->dev,
+			 "CWSR forced on: multi-GPU with MES requires preemption support\n");
+		enable = true;
+	}
+
+	if (enable && kfd->device_info.supports_cwsr) {
 		if (KFD_GC_VERSION(kfd) < IP_VERSION(9, 0, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex)
 					     > KFD_CWSR_TMA_OFFSET);
-- 
2.47.3

