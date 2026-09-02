Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B21C624DB
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1EB10F431;
	Thu,  3 Sep 2026 07:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LgvppNsq";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725BF10E008
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 11:50:04 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49b9320423cso9347645e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2026 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788349803; x=1788954603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KQYhF3JRqYQ4KMxSdHkJy21dirNqkSr4/Y/EOxbYYiE=;
 b=LgvppNsqcVjyxAgUoMnOho7DQGm7VIaTzC2utdB2uyFpVv56WW54hu1ygfJZToNYDv
 8I+0UQVJghRBsfF8OV1qkux1mRAsnvG20XrKjCxiOiLvyQXPE5exWQQ+B4I84Fgp20b5
 2CsjV/SXk8l1z2AUrfwlVIHEQvIPvtC18o3csh/5CXJN4utEB1YzaI8LNQ1NqXyoJGwR
 GdIg8DDJ5C0+getthNQ28OnSwwL3VrXcNaMLeMY1WOSf/5pV+URVc5UJvFwyLM+mrwWa
 78OCJMpprt2TNc/vfvKfsMhqu/Yxro/jV2apTDPEdi+dBsBD6VK3tVOfivZDnSAgxLxY
 sh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788349803; x=1788954603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KQYhF3JRqYQ4KMxSdHkJy21dirNqkSr4/Y/EOxbYYiE=;
 b=VCjOLmh+A4y+EapzS+oUxZM3xuQxt3Zz88xskF1uj5SBLcqaGDB3BVyowFSY306Mx0
 rYJu4LH5FnH23pIWVsv6heOCVKJhypqozbuSW8wSds6IcvYRHFcpnk/dd/vVARjyeTc1
 deLw4e8mVcpEgNVvmi4L5syHHy+THl3F5Wd7ql1p2BbrJKWmZuZKWxjPA+9T1UZvCids
 H8gV7BisBnKTBsX2I6Uz41I36y8BsFm/muzB410/y1dQiTwTnHaWLA1daYKxNX7ozire
 jo3vA65iE2m7cLHLBosk9htNvb0FHoUXCVbjVU2PdkG2DBFdFZxqvUNPaRQhYJsNkYLR
 korA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9oBozVQJ4dagZJ2bJBhKEaWM4XAOZHxkbVi3Aj02a3k/eSAxiz69zeyRk3ft5P6eDGYWtHy3g@lists.freedesktop.org
X-Gm-Message-State: AFuF++m/nm/+Il87UP4CMC0Z6zq+TwOaFogrwD+9HnC6uzAX9RVw3oy4
 3DE3Zs+6GXvsoH38xreUU8k1t+xdICd3VCj1aogh7sWpcQv+Kaz/+v++
X-Gm-Gg: AR+sD12fy1AflLMt7bOkBOrW2ZKEjlVwe8tFACrvP4WOcqMcpREh7W3JaL0g5T4orFT
 TncaDn6IcRnOpGLMAm0yBP8lxkQqyL56Xl/N9pxiEHuvOHE2yCJWq7ToWhJ5vWG9pqVFqwFv7uY
 gRtfoQA3aOfLrZ4NQVqHRFQRMKHyvJ6r4DkVBEBpW7Csb65zxmtgF2Vz6lIRPkW8L40YndGHuqQ
 VfSCmsndITVULxxDaYi4IMqE1kadq2ILKMo01R607ZVTuA0U2UQNw6jaC+p1bkeZYoEnKLLVWqu
 wcQnfTnC4YvEoWQeSNgzpBpy/6SiVW1PIDgeV3iCNLm+0kbz6sAPomIqlWH8qfVVZJZddzFN8u+
 kBiYPnOlU8JCxCgxQOBzBsN/MoCkrtV7rsU5BFj7AVl0YBumxT8HBPVZhJcNQbQnSI7yTg9EgbO
 Wf8Xd9INts3LxB92NYaNEQYpBnN2GQaVBn51+AV/req7tuJ9LkiVWS3cuwmSZ1KrLFbjqHxWWZV
 Kd4N2hhJ/JUGoWm66/I3cf0TdhjI3H8reEj74gRYWIbWjbgMfdBo6mhqCVxqg==
X-Received: by 2002:a05:600c:8b05:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49ce5817bfemr91781575e9.6.1788349802440; 
 Wed, 02 Sep 2026 04:50:02 -0700 (PDT)
Received: from drago.hgw.local ([2a00:1d34:e871:1c00:d71:a9eb:b721:e4dc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce551bf7asm33475835e9.2.2026.09.02.04.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 04:50:01 -0700 (PDT)
From: Deniz Aydogan <denizaydogan1902@gmail.com>
To: lizhi.hou@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Deniz Aydogan <denizaydogan1902@gmail.com>
Subject: [PATCH v2] accel/amdxdna: add NULL check for job->cmd_bo
Date: Wed,  2 Sep 2026 14:49:59 +0300
Message-ID: <20260902114959.9553-1-denizaydogan1902@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829080016.10002-1-denizaydogan1902@gmail.com>
References: <20260829080016.10002-1-denizaydogan1902@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:34:48 +0000
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

amdxdna_cmd_submit() leaves job->cmd_bo as NULL for internal driver
commands that use AMDXDNA_INVALID_BO_HANDLE. The cleanup paths in
amdxdna_cmd_submit() error handling and amdxdna_sched_job_cleanup()
call amdxdna_gem_put_obj(job->cmd_bo) unconditionally.

Although drm_gem_object_put() handles NULL, adding an explicit check
makes the code more robust and easier to reason about.

Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 31a414c3f..21f0560e6 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -575,7 +575,8 @@ void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job)
 	trace_amdxdna_debug_point(job->hwctx->name, job->seq, "job release");
 	amdxdna_pm_suspend_put(job->hwctx->client->xdna);
 	amdxdna_arg_bos_put(job);
-	amdxdna_gem_put_obj(job->cmd_bo);
+	if (job->cmd_bo)
+		amdxdna_gem_put_obj(job->cmd_bo);
 	dma_fence_put(job->fence);
 	mmdrop(job->mm);
 }
@@ -676,7 +677,8 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 put_bos:
 	amdxdna_arg_bos_put(job);
 cmd_put:
-	amdxdna_gem_put_obj(job->cmd_bo);
+	if (job->cmd_bo)
+		amdxdna_gem_put_obj(job->cmd_bo);
 free_job:
 	if (job->mm)
 		mmdrop(job->mm);
-- 
2.55.0

