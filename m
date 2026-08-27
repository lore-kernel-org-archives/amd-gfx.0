Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E2C61DCD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 08:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4F310F2BC;
	Fri, 28 Aug 2026 07:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="OiipsV10";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF3510F0D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 16:01:37 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-853c947bfefso1090916b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1787846496; x=1788451296; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7sryVqJwijt526l6++VdXSITZiFhPfcV5wF4kc67w4s=;
 b=OiipsV10svfhMiovOn3v1SR0g35ovedJcRfO7N+pqqb5y1C7wbuMcM/GlqIyvel56Z
 bD3vuscDp/ReQCx+L6SMxlJldRqjU6RMr76GlyA8SFPJfeFTJEOckJEjaF7MdDN0hXt5
 qiOCNjqVa6Ul4MNuVJAIxMK8OU0NcaebjfPDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787846496; x=1788451296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7sryVqJwijt526l6++VdXSITZiFhPfcV5wF4kc67w4s=;
 b=eq7mWmh9T/k7/UTOwu3ENeDFbjiEUHgcwz6JNl2PKz/z+DY7QErXuyCL8hHIxrF3nl
 DvoD15KRyohowBWQlUVAUHH43j/eYncnI/FQk/hN3nj/6+pgf3fdRaFF9ircCJrjCcm6
 zgqbN3m7yqcsCMsVaxGnnhu3lR8KxYp/khuV8zu3ubLngIWRhAcq0/9EXQOPietgiCa1
 gD312j73FlWq9xNzJ4v/6RT7UtTNVlNn36SZJ63eZ+xfnsoaW4CmWlHknyH1BDD5Wqn8
 ljbvuS24Cpxp3iH0esKPHPtZQ7NrKN1kUJj/nTRhfAGtThmFrz9SpcoyOIaEpuRZxNvb
 dj/w==
X-Gm-Message-State: AFuF++mV2Jy0AJJVa7W+6+lIVgGbuuRQF4pgM44ZaFROgzGh73cj5nVW
 fQGAUw3df03rERfxq/UzJ8v+FldVqCEuKx8PUvMEpO+hB2DMXYjTPq9bUeXOa94Pq5Y=
X-Gm-Gg: AR+sD11sYc400YdE9ZiYQMogxSex0A2xd/opXYz6tGU15AmQpt6PuNwXefMy+8Ve89Y
 XDj552nYCcXwsGBZhkOEt33Lc4Xprd0TWnKBWuBmprEs6qmaARHkwRPd1vYUnYeEIBWHHs3u5C7
 hBjyHgtVgTxibVXxj3ONkAzZFBhgH2LJdj2TrJaXOo3P7Z3BbiWG3NfgAgzKktwbdbomZ2MgEqx
 isVIvN7DGQdzlWcpyry9wgauBw0QekSVMsIR9EYGt0s/8oglU3a9Rdbq0945Le5y8dqX+w3eSOD
 ivgfm2AsJ4oZDGxTLWguaPomykOmYRekBjYmb2iNdupGRShNiJ4Iz7QE+KgfJKY8w2AwhOCQ027
 mYML82HNYy5qOUmHMUtMHfyjBJ/uTK5yXa9zizqQkPRyPqztegSXgkNOBMiMtk7Zo1xNpt8P3k5
 9B0/u2h+7VAnciisNPACvIC2GwfQv8g5b9C/+njf9/FVR2UsLCx4/ZD8Rqrw==
X-Received: by 2002:a05:6a00:4fd0:b0:84b:9a69:156d with SMTP id
 d2e1a72fcca58-8562543f74cmr429998b3a.0.1787846494915; 
 Thu, 27 Aug 2026 09:01:34 -0700 (PDT)
Received: from 1c1aead48890.. ([49.142.45.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535a8bd941sm2178632b3a.18.2026.08.27.09.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:01:34 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>,
 Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH] drm/radeon: fix double-free/UAF of ttm->sg on userptr pin
 failure
Date: Thu, 27 Aug 2026 16:01:22 +0000
Message-ID: <20260827160124.679309-1-hsj0512@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827091532.340141F000E9@smtp.kernel.org>
References: <20260827091532.340141F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:59:57 +0000
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

If sg_alloc_table_from_pages() or dma_map_sgtable() fails inside
radeon_ttm_tt_pin_userptr(), the error path frees ttm->sg with
kfree(). But ttm->sg is not owned by this function - it is allocated
once in radeon_ttm_tt_populate() and is only supposed to be freed by
radeon_ttm_tt_unpopulate(), which persists across multiple bind/unbind
cycles of the same ttm_tt.

kfree()'ing it here without resetting ttm->sg to NULL leaves a
dangling pointer:

 - radeon_ttm_tt_unpopulate() will kfree() the same pointer again
   later, a double-free.

 - Anything that dereferences ttm->sg in the meantime (e.g. the
   "!ttm->sg || !ttm->sg->sgl" check in
   radeon_ttm_tt_unpin_userptr(), or a retried bind calling
   sg_alloc_table_from_pages(ttm->sg, ...) again) is a
   use-after-free.

Additionally, if sg_alloc_table_from_pages() succeeded but
dma_map_sgtable() failed, kfree() only frees the struct sg_table
header, not the sgl entries array it allocated internally, leaking
that allocation.

Use sg_free_table() instead, which releases only the sgl entries
this function allocated and leaves the ttm->sg header intact for
radeon_ttm_tt_unpopulate() to free later, matching the ownership the
normal (non-error) unpin path already assumes.

Fixes: f72a113a71ab ("drm/radeon: add userptr support v8")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 22fc35a0e8d8..cbc0339cf127 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -374,7 +374,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_device *bdev, struct ttm_tt *ttm
 	return 0;
 
 release_sg:
-	kfree(ttm->sg);
+	sg_free_table(ttm->sg);
 
 release_pages:
 	unpin_user_pages(ttm->pages, pinned);
-- 
2.43.0

