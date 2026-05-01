Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDC6FF885A
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 12:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A53710E6A4;
	Mon,  4 May 2026 12:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SKor3FrM";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1161710F5FB
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 20:48:57 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c7971d0d97dso1309674a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2026 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777668536; x=1778273336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TDTG+3/DnSLNqGWEZBCoD/zuD/bmDCvWNrNY2zLrKIk=;
 b=SKor3FrMmrKkQ3hMO6dR0R6dxxfFx19eivvQsKQ5/3EERogtHty+l68OdlQ9alFUbh
 nWuuB5FPUi6PS2kiLO3LJ/sARzsEJKVM61cE+o8n+c611x8vaLjIAtF8uYTts+o7u9R2
 NwUBOvbNHldLaC9/tKQa/jbOv0dvFdKYJye8m8sybTj0FcJvui4n5PBRgMWeDG4EY9Q1
 dmawA+z0Dq5u8wXZANPn7QasV7bZPprCqpUKpEINPmiO8KhnwvLriDc8RnwAibp/MIfm
 zGyS2RjoXrSDMGBuDnLNIPbYUm2+1T2qlr/bLY89Bj41DoMHYu8FtnSOG/lAxf/1O3Wa
 Bbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777668536; x=1778273336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDTG+3/DnSLNqGWEZBCoD/zuD/bmDCvWNrNY2zLrKIk=;
 b=d2+mceihqWLJyGOOcM+DJ/R1awkk3QD9pitLRCVv5D5ClvHXh7SoeX1aRQY2lxGBiE
 FAaZA50E0G6Jlmj4VUK2SCoV7djf/WPu1DnS8YINmRdLZ5W3IbeSF0o4nWOA4GclEJcr
 ys4irGzZPJ9FgJIZtNWwOfHNyjbRoB1NFM5ayDD5sryMMK7GMLsjp8GO+XMlO6Fnc3W+
 0m3bzUvkcRpbrXFwC2yq7R/On3tDZHfaEl9OoBbFsEU5z9XcpxlJKU/1HeVTeDhajqIf
 Qbdsk4RQ9SUJlnNRWpYHYNvJJ5jkrTwjHJrL63+xmulOQjrVfT3C//L4Gepido08v9Vx
 mVAw==
X-Gm-Message-State: AOJu0Yyl3cKitj1tZio34RRhzYdFteeLMAl76r+TSTzcV8TYq2suscyh
 AE3El5rpF6xNDcbu3Z5ECl7xSZvorJs8MDEckQ8uXeqgXO8DJ0pNYyfcnT1Xrk3ezX4TLQ==
X-Gm-Gg: AeBDievnKHnDKh3Ph7lCB6nK1sm2JH7moO0p18VGKXfrdsr7jE2Z1mtZuc5bbjAti+Q
 fzfMh/U8poC2OgcHsvinFUUgViflwboY1UAKuGdwj3etO6d7+SwZleftQMMDB6sQt5TyFOJDceO
 wbFkD3hTT21/mhqEPEYmHI7ZkkM9lZpYHJ9hIxHN79Fr9P2riwuUcNbMUuN9hz4oFJ1kw7asQIT
 sgu7DWNgjUbilDLLqcrClj5GMzGOQAfCXD301eyBRMrW/M6d3rpDy1H8J8XDGNJuzVB2dfB2WLW
 I0OTKWG+dN5M20D0siDQYR524HN7zueiwxQdPBlSfMdkKy5Ys4D1gkzUHuN8RuddDt9/Cd7FoPe
 TksUPW7c0tmGsVhetkp3SNxDhV2+r9kcW/RDTG9eijp6yNn6Uv/VOTa4eMUtDs6DcTyeCgRiJAA
 ZpMWyHFnV7J2HW04KgftTHtyxJlg6kG5GZ
X-Received: by 2002:a05:6a21:6da2:b0:394:5513:ce5 with SMTP id
 adf61e73a8af0-3a7f1fd1314mr559712637.51.1777668536068; 
 Fri, 01 May 2026 13:48:56 -0700 (PDT)
Received: from archbox ([2401:4900:1c0a:5b5d:d61f:366a:2e4:3109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbc6f511sm2878652a12.16.2026.05.01.13.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 13:48:55 -0700 (PDT)
From: Daksh Sahni <swizzguy76@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, Daksh Sahni <swizzguy76@gmail.com>
Subject: [PATCH] drm/amd: Fix spelling mistakes in comments
Date: Fri,  1 May 2026 16:48:32 -0400
Message-ID: <20260501204832.66251-1-swizzguy76@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 May 2026 12:42:21 +0000
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

Fix several instances of "occurred" and "separate" in comments.

Signed-off-by: Daksh Sahni <swizzguy76@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h           | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c | 2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 7af86a32c0c5..e5884bb4d63a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -564,7 +564,7 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 	out->state.flags = 0x0;
 	out->state.hangs = 0x0;
 
-	/* determine if a GPU reset has occured since the last call */
+	/* determine if a GPU reset has occurred since the last call */
 	reset_counter = atomic_read(&adev->gpu_reset_counter);
 	/* TODO: this should ideally return NO, GUILTY, or INNOCENT. */
 	if (ctx->reset_counter_query == reset_counter)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 124fb38eb465..095ab609623f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -161,12 +161,12 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
  */
 
 /**
- * amdgpu_vmid_had_gpu_reset - check if reset occured since last use
+ * amdgpu_vmid_had_gpu_reset - check if reset occurred since last use
  *
  * @adev: amdgpu_device pointer
  * @id: VMID structure
  *
- * Check if GPU reset occured since last use of the VMID.
+ * Check if GPU reset occurred since last use of the VMID.
  */
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 56a88e14a044..bc011b4639f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -31,7 +31,7 @@
 #define AMDGPU_PREAMBLE_IB_PRESENT          (1 << 0)
 /* bit set means preamble IB is first presented in belonging context */
 #define AMDGPU_PREAMBLE_IB_PRESENT_FIRST    (1 << 1)
-/* bit set means context switch occured */
+/* bit set means context switch occurred */
 #define AMDGPU_HAVE_CTX_SWITCH              (1 << 2)
 /* bit set means IB is preempted */
 #define AMDGPU_IB_PREEMPTED                 (1 << 3)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
index 5bc3bc60a2ac..ebbe7900205e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
@@ -46,7 +46,7 @@ static void dcn20_wait_for_vmid_ready(struct dcn20_vmid *vmid)
 	/* According the hardware spec, we need to poll for the lowest
 	 * bit of PAGE_TABLE_BASE_ADDR_LO32 = 1 any time a GPUVM
 	 * context is updated. We can't use REG_WAIT here since we
-	 * don't have a seperate field to wait on.
+	 * don't have a separate field to wait on.
 	 *
 	 * TODO: Confirm timeout / poll interval with hardware team
 	 */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index c18ff8f00bb8..43b05e56679c 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -355,7 +355,7 @@ struct dmub_srv_hw_params {
 
 /**
  * struct dmub_srv_debug - Debug info for dmub_srv
- * @timeout_occured: Indicates a timeout occured on any message from driver to dmub
+ * @timeout_occured: Indicates a timeout occurred on any message from driver to dmub
  * @timeout_cmd: first cmd sent from driver that timed out - subsequent timeouts are not stored
  */
 struct dmub_timeout_info {
-- 
2.54.0

