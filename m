Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C6BC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 14:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6481A64F42
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 14:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6481A64F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DC76ED99;
	Thu,  4 Feb 2021 14:43:48 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F23A6ED93;
 Thu,  4 Feb 2021 14:43:46 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id i8so5684111ejc.7;
 Thu, 04 Feb 2021 06:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wedMKLv5Ufk/tyydKR+pTpkzFwgHy/gV4E2x3/ps7VM=;
 b=eccZnehSVsG5Gc85Co868CRoSHs2yjSsTEMdR8g51N6+ZKgjGGZjTb7lYbTaBcyxWi
 JWD8ji2wn1pRAX0ig2qvTMfI1lYsjhayrLJC8WM8Yc3dcRqEzA3Eeq04zZcHzcIIwC/3
 KKaMRIB/2uRbYMRzx3SMMp68vzJ+BlsgJqqTAX7rp8dONrkpcjfsLsq7JqaUHYxw3GJt
 ykV9mG+HnZMrQdVI1auF4uYPlZWnXwWydidkiBzb+J042KmTFoU9wn5gLPx63vG4Zdwf
 jui5QNItnwdR8o9MwsIczE8onXNlsKoGJ5izSPXNwLBFStws4xjYan51nGpKFkS2jbmy
 HVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wedMKLv5Ufk/tyydKR+pTpkzFwgHy/gV4E2x3/ps7VM=;
 b=L5BbRpWrSmuP23WPvi9JzIQHKnOVOhWx4mLJf+5VP8fFS6wH+00k2iaLOjrulnBAgW
 zYDyNO1HH8Iy10ifcVhfDMoUZi2dTDY67HP9Z1F4AfmJ/MCZ//GdZi3ls3WpAU9KdgaZ
 7YOJ1cOBvfNPX3zWEhi0IkwzqzjoR//AzPpgkh0be/vcqgKbW3nD3+wcugIjDJzzJp+c
 yK2F2iN2jb2LxUHhPdwUSewn+bptkhrOR4YmYJf7dKztHqk57N+3wz+9N8T3hUIY+U6Y
 VmZLk1+vUfOnIwkWTabnaxVPHKQE2hTQmQ4vWniPU4EcZmqyTzW+59SILLDCQUJqniMF
 ZMbA==
X-Gm-Message-State: AOAM533yBbh5NKv4Q6jIoLW5TwsxqfFnu87bTIsdPYMEOwnYIjAbBnIM
 /XCmnVwyrZNlFyG5EXa11bKHX5jzV00=
X-Google-Smtp-Source: ABdhPJxi1BZiobcRDGw/jHByFvcLpXoGaiIfXGbh6qbCqVpgbGQIvPG8fglsOx6Abe/N7Ky1tjvLLA==
X-Received: by 2002:a17:906:154d:: with SMTP id
 c13mr8394976ejd.471.1612449824860; 
 Thu, 04 Feb 2021 06:43:44 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:db9a:1ee8:e47:9603])
 by smtp.gmail.com with ESMTPSA id u5sm2734472edc.29.2021.02.04.06.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 06:43:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 01/14] drm/amdkfd: Get unique_id dynamically v2
Date: Thu,  4 Feb 2021 15:43:30 +0100
Message-Id: <20210204144343.2679-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Leo.Liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kent Russell <kent.russell@amd.com>

Instead of caching the value during amdgpu_device_init, just call the
function directly. This avoids issues where the unique_id hasn't been
saved by the time that KFD's topology snapshot is done (e.g. Arcturus).

KFD's topology information from the amdgpu_device was initially cached
at KFD initialization due to amdkfd and amdgpu being separate modules.
Now that they are combined together, we can directly call the functions
that we need and avoid this unnecessary duplication and complexity.

As a side-effect of this change, we also remove unique_id=0 for CPUs,
which is obviously not unique.

v2: Drop previous patch printing unique_id in hex

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a3fc23873819..0be72789ccbc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -497,8 +497,6 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.num_sdma_queues_per_engine);
 	sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
 			      dev->node_props.num_cp_queues);
-	sysfs_show_64bit_prop(buffer, offs, "unique_id",
-			      dev->node_props.unique_id);
 
 	if (dev->gpu) {
 		log_max_watch_addr =
@@ -529,6 +527,9 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 				      dev->node_props.capability);
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
 				      dev->gpu->sdma_fw_version);
+		sysfs_show_64bit_prop(buffer, offs, "unique_id",
+				      amdgpu_amdkfd_get_unique_id(dev->gpu->kgd));
+
 	}
 
 	return sysfs_show_32bit_prop(buffer, offs, "max_engine_clk_ccompute",
@@ -1340,7 +1341,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
 		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
 	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
-	dev->node_props.unique_id = amdgpu_amdkfd_get_unique_id(dev->gpu->kgd);
 
 	kfd_fill_mem_clk_max_info(dev);
 	kfd_fill_iolink_non_crat_info(dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 326d9b26b7aa..416fd910e12e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -57,7 +57,6 @@
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-	uint64_t unique_id;
 	uint32_t cpu_cores_count;
 	uint32_t simd_count;
 	uint32_t mem_banks_count;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
