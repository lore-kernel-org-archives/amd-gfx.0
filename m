Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B399C4727F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5FF2087D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVrDHZ79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5FF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F8EF6E8AD;
	Wed,  7 Oct 2020 16:32:32 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FDC6E964
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:31 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id c5so2407312qtw.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7l/o6JIiGVaxjenDjZymJA7Qx/afMLDTYYQ9buYasqk=;
 b=PVrDHZ790R229TT+hBKYWunnpoAXY5OysjyPTSqIHrpJqSvXAO1oIoV1HXrLA1dfu5
 3tBWfcHGW7qWiWWLnxZZE2TbAP7ofby3TQw4DCvu1qKzH6cPV4xLS49Rt+7AJiQdaNb1
 rv1V+inK49BiZimMhl3uU9ljL2/0RX01rDwMsJoKQ6XwdC9hOGVX0N0ZMGx+QA7ZG3wS
 Q2UBwQsdjxLxKu/0jd08GWFbV+JT7YTQ4fJtOH9PvLCVR8aK6sbVpnPcNI4dM2HrWkB/
 jUJb8FDTLiHsO4qkCWX7N4OGxY1X2LE9I/F6l/At6NbR0qiICuozEouABEhZhFpngGA+
 kFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7l/o6JIiGVaxjenDjZymJA7Qx/afMLDTYYQ9buYasqk=;
 b=ZLNcKI7qj5zYMwoNf9nrpBN2DsArKgrzaqlnEwFcP0dVjyJjqY5WKDpLwimzUIip/3
 0WJAJpQqXtyx6cMMsVyDxN83RLHx0ftoIEPNl+R5cr3pD3AVoGppdm8xWanfJ0sgwcAN
 Vd7f2wQBUL/W7HlYyZdbOuWQUcYOSQ0VNH90Rd104qD5A5qla23BcCAe660aO6g/Ld6h
 8aVloVkqBay69E3LkPjxxDrEMaUBtcdURAwhomCBV4NCUidxWwhdGJMbEZbaXxnEUm9u
 xZgzua78lR2czmpeDv8O2ZyCvNGaAtIhBihP2AftAi2Y2in46vG6+RA/wLRIqJBGDtEU
 AYhQ==
X-Gm-Message-State: AOAM533HHlEw2q9LNeCXyGT5gmhp73MSC5xeWmEaix8auSglIJLl+Luu
 lzixH9Uwi6ONhOLvEoRgbCk9xqZuqKo=
X-Google-Smtp-Source: ABdhPJxqWSOgx8IiGCq4MNUb2jXwmEDSqkOz2RVQmOm3AHaSxx981rewHqG1ZIj17w6Y+D6VTPcJRQ==
X-Received: by 2002:ac8:b8b:: with SMTP id h11mr3964953qti.28.1602088350024;
 Wed, 07 Oct 2020 09:32:30 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:29 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/50] drm/amdkfd: Support dimgrey_cavefish KFD (v2)
Date: Wed,  7 Oct 2020 12:31:14 -0400
Message-Id: <20201007163135.1944186-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add KFD support for dimgrey cavefish.

v2: rebase (Alex)

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 20 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  1 +
 6 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 0eeda7904c14..7a071b4f76a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -681,6 +681,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 	case CHIP_NAVI14:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		pcache_info = navi10_cache_info;
 		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
 		break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 81751da79feb..7a1ff80cfb01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -517,6 +517,25 @@ static const struct kfd_device_info vangogh_device_info = {
 	.num_sdma_queues_per_engine = 2,
 };
 
+static const struct kfd_device_info dimgrey_cavefish_device_info = {
+	.asic_family = CHIP_DIMGREY_CAVEFISH,
+	.asic_name = "dimgrey_cavefish",
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
+	.num_sdma_engines = 2,
+	.num_xgmi_sdma_engines = 0,
+	.num_sdma_queues_per_engine = 8,
+};
+
+
 /* For each entry, [0] is regular and [1] is virtualisation device. */
 static const struct kfd_device_info *kfd_supported_devices[][2] = {
 #ifdef KFD_SUPPORT_IOMMU_V2
@@ -542,6 +561,7 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 	[CHIP_SIENNA_CICHLID] = {&sienna_cichlid_device_info, &sienna_cichlid_device_info},
 	[CHIP_NAVY_FLOUNDER] = {&navy_flounder_device_info, &navy_flounder_device_info},
 	[CHIP_VANGOGH] = {&vangogh_device_info, NULL},
+	[CHIP_DIMGREY_CAVEFISH] = {&dimgrey_cavefish_device_info, &dimgrey_cavefish_device_info},
 };
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 7971bbe696d0..c579615451ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1926,6 +1926,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		device_queue_manager_init_v10_navi10(&dqm->asic_ops);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 379457d1b250..98a5e1d719c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -418,6 +418,7 @@ int kfd_init_apertures(struct kfd_process *process)
 			case CHIP_SIENNA_CICHLID:
 			case CHIP_NAVY_FLOUNDER:
 			case CHIP_VANGOGH:
+			case CHIP_DIMGREY_CAVEFISH:
 				kfd_init_apertures_v9(pdd, id);
 				break;
 			default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 9beb2eabd56e..5d541e0cc8ca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -248,6 +248,7 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		pm->pmf = &kfd_v9_pm_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index da6b493c520f..3f2aa055c32c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1376,6 +1376,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
