Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CD6C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 22:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0F522D75
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 22:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0F522D75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=froggi.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 487156E088;
	Tue,  5 Jan 2021 22:05:24 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E8EB6E088
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 22:05:23 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id q18so683556wrn.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Jan 2021 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jVBB+l1NlFfYbkih4uO/qeOdck/mdvjkYnzvhBDVq74=;
 b=KggkL+QEbVZVnfkd6V4XnZKt1UPG2XjW6r3eZryREia4AsWgbXMz/ECQtfmJDPR+Xj
 BnMr/c0DZKRmDcX/hqGCsqSNIJojasGLCb5Sb9yMtRyde5/tqxqrNYVnBM3Mim7Nedk5
 d15mdmDeX7MbAhNpm5ioy4wVek/CY8uYICDw6sleXZbx8IBEeHpoqYO3N24t7uZFJwFW
 JxnVCRC9T7RhZeZRwa9x1f/uKncGSBmL2XpXFc93UNQwIr4+BGG0DJd2y4JaEZb41+w0
 N74xR2g8lXHnlXUMiDchuCmbQ5U+46+YJwHGOFk0G39GGDIfk4D//yOxUdmgCb02bQdr
 8Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jVBB+l1NlFfYbkih4uO/qeOdck/mdvjkYnzvhBDVq74=;
 b=g1pI+AooZ11O+m0B6IbIN31PoZQRvJZZrXJeBgZOWQ7cPfDXm4fGSfOckSdjzDDBb9
 G880O8q5+up9Pt4GSisvwuYf/HPawPnEKF4iP/WaHcSuWlHnKpIQDwj/nWY7AuBxUInE
 qvEVyfzfuu60ZkJAPSsJBuMfsHClztZ5945kUFPwxw5wnSPv6OadnXHSuewSZPFcVezj
 GpwRMDemdJu1OL6KShdsdDspADxq8ute2n4a4df5F/7KkMpT5O0ln/igxlNaMm0Jh71w
 J0v+vFG+FKq3FdZZHv/MWcmko00PzI18uv6GciQwPAkhUM89eYM01r03n0nyalxa1XZA
 ydlw==
X-Gm-Message-State: AOAM533d/t3oe1VcBmbRd1vXP+buTTbXKo7HIb83vdzMwluXYwc0DxNL
 EtDz93oEG98gRfXmU0Ne2w2u+Eqk7lrN0Q==
X-Google-Smtp-Source: ABdhPJwrM5ZK0ZBAA7zBR8H7WMZhwXctUk83t/AvuIlVskDkqRwJlaJvKDE0YA0sKJtuaEL7XYkWrw==
X-Received: by 2002:adf:f681:: with SMTP id v1mr1431899wrp.133.1609884321555; 
 Tue, 05 Jan 2021 14:05:21 -0800 (PST)
Received: from localhost.localdomain
 (cpc89720-darl9-2-0-cust754.11-2.cable.virginm.net. [86.2.110.243])
 by smtp.gmail.com with ESMTPSA id r1sm527918wrl.95.2021.01.05.14.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 14:05:21 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com
Subject: [PATCH] drm/amdgpu: don't limit gtt size on apus
Date: Tue,  5 Jan 2021 22:03:59 +0000
Message-Id: <20210105220359.1392555-1-joshua@froggi.es>
X-Mailer: git-send-email 2.30.0
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
Cc: Joshua Ashton <joshua@froggi.es>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since commit 24562523688b ("Revert "drm/amd/amdgpu: set gtt size
according to system memory size only""), the GTT size was limited by
3GiB or VRAM size.

This is problematic on APUs, especially with a small carveout
which can be as low as a fixed 128MiB, as there would be very a limited
3GiB available for video memory.
This obviously does not meet the demands of modern applications.

This patch makes it so the GTT size heuristic always uses 3/4ths of
the system memory size on APUs (limiting the size by 3GiB/VRAM size
only on devices with dedicated video memory).

Fixes: 24562523688b ("Revert drm/amd/amdgpu: set gtt size according to
system memory size only")

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 72efd579ec5e..a5a41e9272d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -192,8 +192,9 @@ module_param_named(gartsize, amdgpu_gart_size, uint, 0600);
 
 /**
  * DOC: gttsize (int)
- * Restrict the size of GTT domain in MiB for testing. The default is -1 (It's VRAM size if 3GB < VRAM < 3/4 RAM,
- * otherwise 3/4 RAM size).
+ * Restrict the size of GTT domain in MiB for testing. The default is -1 (On APUs this is 3/4th
+ * of the system memory; on dGPUs this is 3GiB or VRAM sized, whichever is bigger,
+ * with an upper bound of 3/4th of system memory.
  */
 MODULE_PARM_DESC(gttsize, "Size of the GTT domain in megabytes (-1 = auto)");
 module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4d8f19ab1014..294f26f4f310 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1865,9 +1865,15 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		struct sysinfo si;
 
 		si_meminfo(&si);
-		gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
-			       adev->gmc.mc_vram_size),
-			       ((uint64_t)si.totalram * si.mem_unit * 3/4));
+		gtt_size = (uint64_t)si.totalram * si.mem_unit * 3/4;
+		/* If we have dedicated memory, limit our GTT size to
+		 * 3GiB or VRAM size, whichever is bigger
+		 */
+		if (!(adev->flags & AMD_IS_APU)) {
+			gtt_size = min(max(AMDGPU_DEFAULT_GTT_SIZE_MB << 20,
+				adev->gmc.mc_vram_size),
+				gtt_size);
+		}
 	}
 	else
 		gtt_size = (uint64_t)amdgpu_gtt_size << 20;
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
