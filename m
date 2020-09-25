Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C718AC4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5115A2399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1RavBL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5115A2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FD26ED6A;
	Fri, 25 Sep 2020 20:11:24 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2BA76ED6A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:23 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id z2so3048973qtv.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VH4t2bp9MqqhnYoaSYstmVYvrHrDlBG+RMH8JIl+rvY=;
 b=I1RavBL634WQW04KZaOBSBgcCmUlWHD+ES/Uj0D8z+SbgIV8AIipNgL9MTts94AQLH
 9PZa4aTl6/lGSOZIz41ozfwwt0W61vMQHlB3i52gOik60nczXqthxNWJRMWXIrTm+qI3
 BnJG4llXRBLCxfvMhUYpFo7w8qbQYsgWh5o+IrDiIyNlGqpBfPA7xSgp283rMhy7eOvO
 2aGgDqqhpmk3KAofnYanzzH6hQc8mEBk5xV7M6vP2nN9mmiZF2HzKEQJ749dT9WxvjdM
 Cqz+RzjcJ+plZmYuEvWWZZCiA5ldNn3WRLGyGv0C9D7A16JS/7M+GmeOnABXFqshfbh/
 d9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VH4t2bp9MqqhnYoaSYstmVYvrHrDlBG+RMH8JIl+rvY=;
 b=XkmVbhlYjq3GJTzJJ3NIKKdbDifQpQwxJ8MRbrcN+pPoe5v1Fwsw0/Ys8aNIKFlfPg
 3kyddotousY1k6W+px/MwD4czziCMbO1BKh6iy/vBiwOHg/sAkTlZixWC1HsQRvco9ce
 s52M5RH32GSX7bmolFf6cJMqKzJyiEVsYAV8QwLZDlCIFVeqRXkRzlOTimjQ9pLbCSjr
 bVj3Lfg7tpHu9HbsfIYTrThDFGhS7q27AhiwFV7SkKAUogj/JLVCsj7dEL30p+he2aH2
 bmIVIaHcVImJH7GcFKuDcXaJulkBE6LZ8NF+yG1CQkQvvjXBlyjsitfpvogISehtZ2Rl
 uRdw==
X-Gm-Message-State: AOAM533OXd9tG01Xv3Xresp4yiX6MMQvUC0dISNxurB+QBIey7fT44XM
 yYOSZq8xPlzKqIxnnP0b8yAEFnBFi80=
X-Google-Smtp-Source: ABdhPJzw4XkRJ+9Tid5XVMWh9q0zVNkYQzSGDk94mgvrmJWP5yVBs4IW23cMITeEVRPXZvQXKi3k6g==
X-Received: by 2002:ac8:568f:: with SMTP id h15mr1502690qta.232.1601064682896; 
 Fri, 25 Sep 2020 13:11:22 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:22 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/45] drm/amdkfd: add Van Gogh KFD support
Date: Fri, 25 Sep 2020 16:10:05 -0400
Message-Id: <20200925201029.1738724-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yong Zhao <Yong.Zhao@amd.com>,
 Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch is to add GFX10 based APU Van Gogh KFD support. We will treat Van
Gogh as "dgpu" (bypass IOMMU v2).

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yong Zhao <Yong.Zhao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 20 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  1 +
 6 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index d2981524dba0..0eeda7904c14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -141,6 +141,7 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
 #define renoir_cache_info carrizo_cache_info
 /* TODO - check & update Navi10 cache details */
 #define navi10_cache_info carrizo_cache_info
+#define vangogh_cache_info carrizo_cache_info
 
 static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,
 		struct crat_subtype_computeunit *cu)
@@ -683,6 +684,10 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		pcache_info = navi10_cache_info;
 		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
 		break;
+	case CHIP_VANGOGH:
+		pcache_info = vangogh_cache_info;
+		num_of_cache_types = ARRAY_SIZE(vangogh_cache_info);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 903170e59342..81751da79feb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -76,6 +76,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 	[CHIP_NAVI14] = &gfx_v10_kfd2kgd,
 	[CHIP_SIENNA_CICHLID] = &gfx_v10_3_kfd2kgd,
 	[CHIP_NAVY_FLOUNDER] = &gfx_v10_3_kfd2kgd,
+	[CHIP_VANGOGH] = &gfx_v10_3_kfd2kgd,
 };
 
 #ifdef KFD_SUPPORT_IOMMU_V2
@@ -498,6 +499,24 @@ static const struct kfd_device_info navy_flounder_device_info = {
 	.num_sdma_queues_per_engine = 8,
 };
 
+static const struct kfd_device_info vangogh_device_info = {
+	.asic_family = CHIP_VANGOGH,
+	.asic_name = "vangogh",
+	.max_pasid_bits = 16,
+	.max_no_of_hqd  = 24,
+	.doorbell_size  = 8,
+	.ih_ring_entry_size = 8 * sizeof(uint32_t),
+	.event_interrupt_class = &event_interrupt_class_v9,
+	.num_of_watch_points = 4,
+	.mqd_size_aligned = MQD_SIZE_ALIGNED,
+	.needs_iommu_device = false,
+	.supports_cwsr = true,
+	.needs_pci_atomics = false,
+	.num_sdma_engines = 1,
+	.num_xgmi_sdma_engines = 0,
+	.num_sdma_queues_per_engine = 2,
+};
+
 /* For each entry, [0] is regular and [1] is virtualisation device. */
 static const struct kfd_device_info *kfd_supported_devices[][2] = {
 #ifdef KFD_SUPPORT_IOMMU_V2
@@ -522,6 +541,7 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 	[CHIP_NAVI14] = {&navi14_device_info, NULL},
 	[CHIP_SIENNA_CICHLID] = {&sienna_cichlid_device_info, &sienna_cichlid_device_info},
 	[CHIP_NAVY_FLOUNDER] = {&navy_flounder_device_info, &navy_flounder_device_info},
+	[CHIP_VANGOGH] = {&vangogh_device_info, NULL},
 };
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 62504d5fa42b..7971bbe696d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1925,6 +1925,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	case CHIP_NAVI14:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_VANGOGH:
 		device_queue_manager_init_v10_navi10(&dqm->asic_ops);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 3c22909470f2..379457d1b250 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -417,6 +417,7 @@ int kfd_init_apertures(struct kfd_process *process)
 			case CHIP_NAVI14:
 			case CHIP_SIENNA_CICHLID:
 			case CHIP_NAVY_FLOUNDER:
+			case CHIP_VANGOGH:
 				kfd_init_apertures_v9(pdd, id);
 				break;
 			default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 47ee40fbbd86..9beb2eabd56e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -247,6 +247,7 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	case CHIP_NAVI14:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_VANGOGH:
 		pm->pmf = &kfd_v9_pm_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 2b31c3066aaa..da6b493c520f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1375,6 +1375,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	case CHIP_NAVI14:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_VANGOGH:
 		dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
