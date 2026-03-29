Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A16F3D611
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A649510E176;
	Sun, 29 Mar 2026 16:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RGSzHMbI";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C12910E149
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 16:03:19 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-486ff201041so35772995e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774800197; x=1775404997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIxvOJJVSo+GGSj7zxVLsnJ9l5q1d9xm3/29J3i/9U0=;
 b=RGSzHMbIsDzlLbwKGCg+yr9BTjVF2C5qo4kM/bBtXwwaZ/Jn15hwclw4tncanGVw5x
 ApTIpHsg7pW//aRk8bhKb2m5fKTufgZoAJFkbEHuxqCPfBu1PDI3AvoNgQb/JV5kygSW
 69C6oUVe5Av2EiNQtBjzAc+R2MZyAoVboS+n3B4vg3rW8N/JcVXPMF3Bmn9HF3Yiea8S
 ispFipf0+s2r6+gR3foqTMtcouiLObit2GvFCLMyPymT0XUSV2Jw1YO0dr72+RV3tYMk
 9Hg9bUlacM7E2TzWVLnXGYqRQQgdMCxXcBuYXNqvsykltrlVVKcwOIQCrLeYCJNNjmBN
 7evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774800197; x=1775404997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fIxvOJJVSo+GGSj7zxVLsnJ9l5q1d9xm3/29J3i/9U0=;
 b=RpoI3JIFCZDZ/qgAYNblhu1SZjHeqS4Ny8Sbg8xaTuFfn1THJtl8ydQlN3PhstsW2L
 WbYGUZppTjqYeWHZNmQI2Njf4a3tRo0Y87oEqvLobKzZXHkim1lW3phhSRsMMERmllSt
 L+UP0iPvYgyT3MKIwFDcYb43FBDMB8DX1L6OX2co+d+haekv34Hb8isawrr6IB2XTOw+
 oB3foGLBZFkheEZNz9iIFwGBTN+yhlzkdwNugnhNaRL+pFz2FFyripro/cq4U33kF/Jn
 DF9Tf0sLScCARnLrSnqV6U1D+wttnb7AaHjfTwgSE62KUbFb9rBnh7sha2aV5OA1mG/D
 VI9g==
X-Gm-Message-State: AOJu0YzTXfvoO5ZXnUl7JC1RnrOC8znDfpiCAYDePm5TV5+OfAD2msGB
 YTr0g/+La0WLxHKOpkvjALu3fK7aOetjeC7qf9XRGZPYjBzMpyxMaqDhzk+sYw==
X-Gm-Gg: ATEYQzzTeuky3lvZvB8713ru6J/1ka7mzizp8l47zeu2fOX5VPmGrio1rwAIc86Igr5
 15T475pEoJRFkXK1pz9liMfIyesfOSEc3+TXCviMSQYcVLdWtt0+O6gjUtqnYYDr6DKfohSSeu2
 5Cfn5uDjqH9uz2AnzAsBrYas4i4L5vKtRTIDuOsu/D45SqzCUKd4x57l78/3s45RgBoewSlmk1i
 CWKdJ+PbVAZwd0rYYhEb56klehOpJ6GzBtsAA4aAlUOiu/CatNMddM13j97fsLiAUTQP6hqOvqV
 0Io3oFYqtAexWxdNlOPF3YOo/slZAIbo27X3xAl35661jJS/ZBTvCK2FuGK5Y0OEOiUUw+8QHJp
 4NguZkEtHev3tpcVziZBNlhEXHYa997cws+3UhJrhzPFSubfbP2Mp47/Oa9VwbJBI8RNhEIuJvs
 53MekYR+eiNzn6lTDBcMrorcW9cxD8WH6YgnCA+r7hUNwFwDiqLmxRj2lxbH6Un5aUepQ=
X-Received: by 2002:a05:600c:c87:b0:486:fe83:8621 with SMTP id
 5b1f17b1804b1-48727ede17amr164723535e9.23.1774800197317; 
 Sun, 29 Mar 2026 09:03:17 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d38a5fsm217428915e9.12.2026.03.29.09.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 09:03:16 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 9/9] drm/amdgpu/uvd4.2: Don't initialize UVD 4.2 when DPM is
 disabled
Date: Sun, 29 Mar 2026 18:03:06 +0200
Message-ID: <20260329160306.3417458-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329160306.3417458-1-timur.kristof@gmail.com>
References: <20260329160306.3417458-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

UVD 4.2 doesn't work at all when DPM is disabled because
the SMU is responsible for ungating it. So, Linux fails
to boot with CIK GPUs when using the amdgpu.dpm=0 parameter.

Fix this by returning -ENOENT from uvd_v4_2_early_init()
when amdgpu_dpm isn't enabled.

Note: amdgpu.dpm=0 is often suggested as a workaround
for issues and is useful for debugging.

Fixes: a2e73f56fa62 ("drm/amdgpu: Add support for CIK parts")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 73ce3d211ed64..8a9ba2276275c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -93,6 +93,11 @@ static void uvd_v4_2_ring_set_wptr(struct amdgpu_ring *ring)
 static int uvd_v4_2_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+
+	/* UVD doesn't work without DPM, it needs DPM to ungate it. */
+	if (!amdgpu_dpm)
+		return -ENOENT;
+
 	adev->uvd.num_uvd_inst = 1;
 
 	uvd_v4_2_set_ring_funcs(adev);
-- 
2.53.0

