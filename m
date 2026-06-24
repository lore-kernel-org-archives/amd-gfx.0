Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC922CDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 07:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6886210E064;
	Wed, 24 Jun 2026 07:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWSeVGoD";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2AB10E060
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 07:38:35 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-460166910e6so414096f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 00:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782286714; x=1782891514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVORJntvacmLmrZGRHw9952P7CRI2lqPs4Y2tNLZLBU=;
 b=QWSeVGoDpD1N2q8C7WphSGiwDyACf8/hT13EgEkJkQm6ecuSVDMdX9i3vasPce9VFy
 +eK1Vi1z7qpGIXpYk5l3iOu/+F5zxqFCSjz4SQvw2SCvdT0D8h9vB3Q+7h6+cSJYpz7H
 wPBMUVxvSfKYOs5yFykNyItEL01c4m0DcA4pk0J/e+CJ1E5Z64lLi6rOyDsCfeuNJdaz
 EA8VHkxhgnz3pvFeDuQGKHOrfktMG8RFpWTO0QFdWkGYlUuSxW1RoeqbzGd/2gvLem8z
 d3/gQQRMDpq8yer0QnaI7LlPc7sQJGaPNastZAgUReOsIu9ahpdumrGtxydDNNVmjZu9
 oPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782286714; x=1782891514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bVORJntvacmLmrZGRHw9952P7CRI2lqPs4Y2tNLZLBU=;
 b=YSQ4KQVN7vphXCDE+888HouZTodxrIPcKnML0wGosw+AB2YlnSdHBmfQysw+sedZKh
 gBmZR+HS2RgUxyTK8vgiRtkWtOa4i/aXkrBtWGUsT5ez00OeDUgnKkBqZ9+soLIUJL4c
 TmaFX3rRzcRFZx74FiQyzlJIkivjN+yHIjNFxdgvSxjF2aaiCqBPcjdrmWN8oAHtzNsn
 uj5cL3Da3eHz0tRKFLTipzaxltCJ7+orR2mXHO7xYrkfT34Xqa8ZQQRs514szce4nJII
 B+Akasv8/msiORZijZH1LIn+lh/DPnqB25INoFeHfeNo0eNZIuy6VgbaWLo9veIzcLly
 BmWw==
X-Gm-Message-State: AOJu0YxSbbpR5AfvqjwOdA3xlnX+jZORJezmZc51sHGykWQx815N9yUj
 tYrSnSPwEn9RFPnyCdXf35om8Z1KIuqySDD2+SgAGFkl0DdWPTz8MLIt+YcHpg==
X-Gm-Gg: AfdE7cmoPXXv1FSlqMt2rYGLdcBp2TtKkEaESGtIxLZx29Yqg9yia91T+/eFqmoaCXT
 NqYL1v6RRMr27CKU3yi7ogRAVRYmmcq2ed5PPn2EbJdJ6OWqzw0ZhAEiiXjSiAcpXpof1W4VOZt
 iW9rHi5+8W3n88yZJuitNvLTDRI8gHA7m7XQ6963xQfoqS8NXFkwOfrv6Amj9WYVc3r+CmAKGJf
 vL1DSuVeHxN+P6oIOaosTRbk7WB+FP9jx3hbL28lJ2QLG1c2AjX0eTFY55hAWM6BnQ4d4ek3cIr
 LIz61i4qLjkGwKqOBhzrBgMHw8YEllZgv0sOxL3vkNxwncMhz9yhlbbIghVkdJqYyBIEdnxGMw6
 JJnEVKWEke2ENA9RW5Zi5WQyIUf+LidQ9nUjgiqJ0+iEhN8PEAw7a2zGPT+9x07nkbSdiWynrlw
 RqWZUWWySm76vHT+crh3Bwujfu4gPQkAq64qqgqddFERrPVIDyYcJ1Qg==
X-Received: by 2002:a05:600c:a42:b0:492:4188:5819 with SMTP id
 5b1f17b1804b1-4926084971bmr27756995e9.1.1782286714115; 
 Wed, 24 Jun 2026 00:38:34 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9787dddbsm1683667f8f.3.2026.06.24.00.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 00:38:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix typos in comments for IP block soft reset
Date: Wed, 24 Jun 2026 09:38:29 +0200
Message-ID: <20260624073829.40835-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624073829.40835-1-timur.kristof@gmail.com>
References: <20260624073829.40835-1-timur.kristof@gmail.com>
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

These typos were accidentally overlooked. Let's fix them now.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index ab5df854c1d20..dad04a88179cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -942,7 +942,7 @@ void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
 	 * Give some time for non-guilty rings to finish their
 	 * current submission, to try to minimize collateral damage.
 	 *
-	 * Note that this just a best effort, but really there
+	 * Note that this is just a best effort, but really there
 	 * is no way to really know which ring is actually responsible
 	 * because different rings may share resources, eg. a compute
 	 * ring may hog shader engines, causing a graphics ring to hang.
@@ -1003,12 +1003,12 @@ void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
  * @guilty_ring: The ring which is guilty of causing a reset.
  * @ret: Return code from the reset function.
  *
- * After calling amdgpu_multi_ring_reset_helper_end()
+ * After calling amdgpu_multi_ring_reset_helper_begin()
  * and executing the actual reset method, call this
  * function to restore normal operation.
  *
  * In case the reset failed, this function should still
- * be called to restore some state, but it won't attempt to
+ * be called to restore preemption state, but it won't attempt to
  * fully restore the ring contents.
  */
 int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
@@ -1032,7 +1032,7 @@ int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
 	/* Flush HDP cache so the GPU can see the updated COND_EXEC values */
 	amdgpu_device_flush_hdp(adev, NULL);
 
-	/* If the reset was unsuccessful, return without restoring anything. */
+	/* If the reset was unsuccessful, return without restoring anything else. */
 	if (ret)
 		return ret;
 
-- 
2.54.0

