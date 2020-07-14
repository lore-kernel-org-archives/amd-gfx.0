Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A384C4345A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C9C223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ZMIipQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C9C223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1886E853;
	Tue, 14 Jul 2020 18:24:45 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E8266E853
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:44 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id 6so13610684qtt.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gOr9gyrQc3si/quYiSW3ryqaV62zP0Pj4OIJqu95CwQ=;
 b=e+ZMIipQM4fndGv/1p7TVZh2FQ72A7BEb7yvAcrQNbwDhPTT79D8Ke1CJY3sl4qlbi
 fKmy/jvgyyYNLpaiBRrA7SVP5bj0ERTnK31sdyQe/gokNab+TxML8p1LBm1HLusOTAlA
 knoNc5drHPDf2NC5H1TkoEGXdY8hh3axxW+M66Hwn9w29/9goFmFvjh7I4KFkhNakjHv
 emh/fQ6wh3Uf9UqsmEJsCqZhTtUcFu6BLS70VkshJU1w4RVaY8QgPRPUt5Y16XT73Q4D
 v3NFpGYDJj40h87RQcqMsKgn9WmiLVh4TVtTlCeKHHfMRbdoPFGQoWz2e707RlZIdjaX
 ZyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gOr9gyrQc3si/quYiSW3ryqaV62zP0Pj4OIJqu95CwQ=;
 b=FsBLzRj/gQsLx9b5ruRWnMOELoxKntryh6l4/LrmsT3PndGhc1DqInofvs3NKBN7Zx
 mUWn8fTXmGfvjahF0djLc00TJn6HKRIgxbOFuADB75wLkJ67QBdrZUrPRnHgKZ3f5vil
 V4WwHdEUT9k/svVaMumOXhja0oNCqVrSnONC2DbtgZ8aqEzTt20nKwdFNpkzWz/39AjT
 73dKZt1MxFUkNo0xeOjFjtpZlyQ2Q9Mljy8BAxsnIVw/aNt068GIWdUtP1X2sbzLnH+Z
 OZmZgd3Z9HGHXBC4hMpm8qsLdioyYhU9zYKaOoL6HozQD7PoiNU5wG4CepK4YjHU4gjh
 wnGg==
X-Gm-Message-State: AOAM533oIm3yzCQo6uyYUd5+07R/MpDm8SwudnbhWYzCYzQp9Zvd+CHp
 LsAKe1sE8DgJz5EZP82yyeSOa6Xo
X-Google-Smtp-Source: ABdhPJyDS24HHqXbUC+0aeo1ProyQCiqDo9qX9Stc2bcNSCNHEXAbDXPG+k9jsDZSQavuI+WRbOk2Q==
X-Received: by 2002:ac8:17fd:: with SMTP id r58mr6069099qtk.151.1594751083058; 
 Tue, 14 Jul 2020 11:24:43 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:42 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/42] drm/amdkfd: Support navy_flounder KFD
Date: Tue, 14 Jul 2020 14:23:37 -0400
Message-Id: <20200714182353.2164930-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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

Add KFD support for Navy Flounder.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 19 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  1 +
 6 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 9deadfd8f929..6a250f8fcfb8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -679,6 +679,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 	case CHIP_NAVI12:
 	case CHIP_NAVI14:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		pcache_info = navi10_cache_info;
 		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
 		break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 50886de3ba0a..82ac1b4886c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -478,6 +478,24 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
 	.num_sdma_queues_per_engine = 8,
 };
 
+static const struct kfd_device_info navy_flounder_device_info = {
+	.asic_family = CHIP_NAVY_FLOUNDER,
+	.asic_name = "navy_flounder",
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
 /* For each entry, [0] is regular and [1] is virtualisation device. */
 static const struct kfd_device_info *kfd_supported_devices[][2] = {
 #ifdef KFD_SUPPORT_IOMMU_V2
@@ -501,6 +519,7 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 	[CHIP_NAVI12] = {&navi12_device_info, &navi12_device_info},
 	[CHIP_NAVI14] = {&navi14_device_info, NULL},
 	[CHIP_SIENNA_CICHLID] = {&sienna_cichlid_device_info, &sienna_cichlid_device_info},
+	[CHIP_NAVY_FLOUNDER] = {&navy_flounder_device_info, &navy_flounder_device_info},
 };
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index dd550025d1c1..e0e60b0d0669 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1939,6 +1939,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	case CHIP_NAVI12:
 	case CHIP_NAVI14:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		device_queue_manager_init_v10_navi10(&dqm->asic_ops);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index b4674cf73132..c1166c40ac15 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -416,6 +416,7 @@ int kfd_init_apertures(struct kfd_process *process)
 			case CHIP_NAVI12:
 			case CHIP_NAVI14:
 			case CHIP_SIENNA_CICHLID:
+			case CHIP_NAVY_FLOUNDER:
 				kfd_init_apertures_v9(pdd, id);
 				break;
 			default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 89d7f08d749f..47ee40fbbd86 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -246,6 +246,7 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	case CHIP_NAVI12:
 	case CHIP_NAVI14:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		pm->pmf = &kfd_v9_pm_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index cd18baf62727..f185f6cbc05c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1374,6 +1374,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	case CHIP_NAVI12:
 	case CHIP_NAVI14:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
