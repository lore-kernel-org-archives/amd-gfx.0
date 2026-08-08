Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FBCC5AD4E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF0CE10E6B4;
	Mon, 10 Aug 2026 06:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bnqVXVGg";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5215510E043
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 22:30:11 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso663671a91.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786228211; x=1786833011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S+lUmXf0M1/AoHp7ybgP/EVeQH1GTrMXgFQpOQU1h9c=;
 b=bnqVXVGg+FusaZvKgn35571fxVSuhPC4Fg8yCX5zJmTjikCjWDnl8lis+ecrMb080A
 CTpdzkiI1F3yD3+O64jY9ykmojT/jfDwqQFFlGERS72e/91NLZHDUhG03ypkiub4ld56
 ft5SriaWWTTrnkzQykiUtA/Ilei2C9ML61n31aAyp46kHuGArbjJJgvvQ5ZvJeepaVOs
 IrJluGAfz1quYJ5TeHlO6ttGuTLnRlodfiY0gMM0lt9JnpleIXm49ejXKPJoxinboHzD
 7y+qenLgqv2LAq5MzCTU9rkLe6gaMpVfVRig+eO+oON5aKONQ8EBf86lkaE0MwCUGu/B
 CWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786228211; x=1786833011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S+lUmXf0M1/AoHp7ybgP/EVeQH1GTrMXgFQpOQU1h9c=;
 b=fjXLDXYBabSHoJR8xWV7GOgs8ixBVg8rITiT2ehSwYtN01iBlyWgje7GKNDGPk/nru
 YU+iUrEUQqvaY6M1N+AErxcBYjeE08ReOjWGKwp9n3C/BxAW6eMmFXRboGrOGk6NY34L
 +TUSGwxTdJ8Sy8a+4IJPgO0X7NbKG/1J7XRwsjErbiUfhnEUj+iJgTRTazFOWPijFDJr
 QZZDmVyRivxl3n/BVRMwqlNYsvQ2bVz7OYrEfzgJlCw/gTrzAivssIDD3jVZe6EY/omw
 QvJDs3cq8kz1opqQdx6iGVm+uUSciESuJ/wiqfrvSt0sBbFzUCqTThXgDfAaSY9OLt3Q
 HnoA==
X-Gm-Message-State: AOJu0Yy9YQtjAfTDih/MtyinLDVhgZFIwgTnzjlef3eHJ1l7FcGnA791
 0+p3fIkZrG3qh4zsJ0UjBjaPZZOCzO5yVvodmhPDNGyUH5T4yX3DzQQP
X-Gm-Gg: AR+sD13hNnPowHdrsT4aa1c10jiIalowfiAV0MtQhUzSnZyFCwc64ohbF9QXjRUSsFe
 ZTqCtbY0VBzkjNdpPkkWl6sDcAHYP7/j09pUcEWgoze3lXzkFayRivkjofHHwLSGio6TKU/hbSn
 M+9V6zYtuPJcZLZjDkAct2SQ1EKKUUgTYmqT7bWq6QclgCq4wrmucQKmHDVJHYU2QR90VnJTQvf
 76dfRJQ2FOPhIXGMFZjHC0aoJnEIUE447bOKjp2HAUg9qUxpdL9fLrGwFxhnxxiM7c56SU82MGT
 +mCKRVcy+fcotP/WECpMMcppWuwjxyzJIns2KEBXGANLeZbr0ePx7MnB97dGALfysfnkEfl5h8E
 Pc+ppj4Vm2qGtZTVkmsnH0qdK885/2XHIsLqpFYcqqTFgi73qIev68CNMx0Tx23tvrYSSPiCWa6
 IbISUC0LPo/9NU2t+Wz3hUxNXraOuFrHQUB5SBaNqVhrHw2ZthzGghPw+yVfCk+LVAiVBcgk6fj
 T1aHwGnGJs=
X-Received: by 2002:a05:6a20:4309:b0:3c4:48da:8102 with SMTP id
 adf61e73a8af0-3cbce930129mr10090468637.29.1786228210822; 
 Sat, 08 Aug 2026 15:30:10 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb877b4sm27463910eec.19.2026.08.08.15.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 15:30:10 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2 3/5] drm/amdgpu/aca: Fix inverted validation logic and
 handle cleanup
Date: Sat,  8 Aug 2026 22:27:40 +0000
Message-ID: <20260808222742.2859-4-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
References: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

aca_handle_is_valid() returned false if !list_empty(&handle->node)
evaluated to true. Because active registered handles have non-empty
nodes in the handle list, valid handles evaluated as invalid.
Consequently, amdgpu_aca_get_error_data() returned -EOPNOTSUPP
whenever aca_handle_is_valid() evaluated to true.

Fix the logic in aca_handle_is_valid() to verify that the handle is
non-NULL, contains a valid mask, and is currently registered in the
list. Negate the check in amdgpu_aca_get_error_data() so valid
handles are processed properly.

Additionally, update remove_aca_handle() to use list_del_init()
instead of list_del(). Standard list_del() leaves node pointers
poisoned, which causes !list_empty() in aca_handle_is_valid() to
evaluate to true for removed handles, leading to a potential
use-after-free during device teardown.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c76664af9902..b4c1438a56d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -586,10 +586,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 
 static bool aca_handle_is_valid(struct aca_handle *handle)
 {
-	if (!handle->mask || !list_empty(&handle->node))
-		return false;
-
-	return true;
+	return handle && handle->mask && !list_empty(&handle->node);
 }
 
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
@@ -599,7 +596,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 	if (!handle || !err_data)
 		return -EINVAL;
 
-	if (aca_handle_is_valid(handle))
+	if (!aca_handle_is_valid(handle))
 		return -EOPNOTSUPP;
 
 	if ((type < 0) || (!(BIT(type) & handle->mask)))
@@ -717,7 +714,7 @@ static void remove_aca_handle(struct aca_handle *handle)
 	struct aca_handle_manager *mgr = handle->mgr;
 
 	aca_fini_error_cache(handle);
-	list_del(&handle->node);
+	list_del_init(&handle->node);
 	mgr->nr_handles--;
 }
 
-- 
2.54.0

