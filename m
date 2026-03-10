Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7ACFD0653
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 08:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE28210E862;
	Wed, 11 Mar 2026 08:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=wbinvd.org header.i=@wbinvd.org header.b="DGPz8iSx";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E220A10E2C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 15:46:13 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2be1b5fe11cso10448755eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wbinvd.org; s=wbinvd; t=1773157573; x=1773762373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eWrM4zr6HsvGxIBz42uj8X29XvQLF5lH3Zcfuwu6Bmo=;
 b=DGPz8iSxIuVNhJV6ddAnbe5YrIexWDgPfw/fijrMnRqTdwhXkknfjD1tkw2dR8V56P
 57sqe6cxirg+OuZ0evCf0W62nRUfCC/07n3DghLyti9iWme9ZE+euo1+XC7CGl+G1H7i
 AS1ZO2DfLe8XEVAcfzHXYD5b5LfKHkl9Im5YqshJ1sAOeRfQCWsjt2jo+r376vtzO263
 AKsxGCUMbLJESkGYvBDaaAKadQcvlh0jI0r06dbqqtUwIqyXIYIwowz6YvhSZIsrC7Wh
 9JzI2FURLvQQT1lI/+zUAHmZpqqLAH7RFMMFyRbl+AsHf7NvIt+rq7ntRz4KJ8bTHqz2
 tgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773157573; x=1773762373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWrM4zr6HsvGxIBz42uj8X29XvQLF5lH3Zcfuwu6Bmo=;
 b=BFKxGQfuWaYbDyutX9b9OH8UGrNtAy2ZqrL29uYDkSpDxevY76N0JYRkDZLVNYKBsD
 MRvoz4T16jIlVyG4/0wm4xC8Nf4N92ZkwYbLW4BdjaXZbUQFfTI3LRSG75VrhjvCw/3K
 E+U/opp1H1+jGX8dOexd2GYvMiM57KSNmjtRRqArZY6Ny30n4eajFnuxHLAtjM+unaA0
 1IA086/diTDApWU5aG79pf0Bex8mBWQhn1hiwIXHm0OnF6dZ+Uj0wGcdpam8AffqIGoK
 Ub/1XexCqkzOZw0BeLy+Lm/SQBBx3D1pnI2UuL6fkb4btsksrj3OxBZJ+KrrbRKp6OVo
 4B1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2VMO7tjJFmeSbJmNTR5jMKJJWtU1M/VDSm93plJJaGczklfSe0+iYOlhTmJYQfECYov0JAcI7@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/dk3sYUzlsQsaPO9+444m+z/KqFVd7DZkA1AnzFIQnj8V168T
 7RHQlmwV8G3Dk+MGa6bryTGAyVFYYywMZ5w/bI6JCa/3u9Lrb4EZAJamg2lXmgOHUSQ=
X-Gm-Gg: ATEYQzygSb826xOziXJq2gC5/2xeJRzoQf368GG0GQY9/Jqw9g8bi5WhQhE5TYuUrXm
 fKMiCVVtDujuYxpH1efYe8NBH5tB+THS7KMhMic7o11KwmauPJqnpI5LWRZWcut8Mj8/kQMT75W
 i+9Xooxsk/gUAlnDl28gv5Ov1tMWtKW9gibWbs2LVnCDpWJAlMAslBHjWkiAMUIfW9x5W6fukDP
 4+7qiblBOqEgKtMbVOw7ewRZSzUfR/Adw6RP4q09IaTh1+aepH/farFl97FMLSeOO/b8/gApXuj
 VyLzt4Lm6s8RfDPr+QWlWzYMcthYsFgq23vp9lQbBFJ5NU0WdarZplcRJV1hAuKiidDq8QAIoTx
 zMNKpFcQBweVPOaj8LviyuYAENK91DCjoFWxCCbTGOx7587kZZLg+ApB4zWuC9yMCwfVdYUQPis
 mcS3ol3by19QvXpMuVCSssI1qtDzbzO/GSzGw=
X-Received: by 2002:a05:7300:a887:b0:2be:198e:438 with SMTP id
 5a478bee46e88-2be4e01914fmr6497991eec.16.1773157572941; 
 Tue, 10 Mar 2026 08:46:12 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:38dd:9485:6087:683])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be645c89bfsm9743296eec.13.2026.03.10.08.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:46:12 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/amd/display: Fix a benign uninitialized variable warning
Date: Tue, 10 Mar 2026 08:46:06 -0700
Message-ID: <6aaf2cf4bd19363a85f35e649685d7bdae400253.1773157137.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Mar 2026 08:09:27 +0000
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

This warning shows up with GCC at W=2:

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3229:32: warning: ‘r’ may be used uninitialized [-Wmaybe-uninitialized]
     3229 |                         return r;
          |                                ^
    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3133:13: note: ‘r’ was declared here
     3133 |         int r;
          |             ^

The compiler can't know drm_atomic_helper_suspend() doesn't return NULL,
so GCC is technically correct, that case would return `r` uninitialized.

Fix the warning by using PTR_ERR_OR_ZERO() on the return value from
drm_atomic_helper_suspend() like i915 does.

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
This is pretty nitpicky and obviously benign IMO, I just happened to
spot it while debugging [1]. No argument from me if you don't want it :)

[1] https://lore.kernel.org/lkml/ef7266eb7802ce6d68ebd9356477e9671f0c94e0.1773116305.git.calvin@wbinvd.org/#t

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8ab6..9c5dce8d38b6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3133,12 +3133,11 @@ static int dm_cache_state(struct amdgpu_device *adev)
 	int r;
 
 	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
-	if (IS_ERR(adev->dm.cached_state)) {
-		r = PTR_ERR(adev->dm.cached_state);
+	r = PTR_ERR_OR_ZERO(adev->dm.cached_state);
+	if (r)
 		adev->dm.cached_state = NULL;
-	}
 
-	return adev->dm.cached_state ? 0 : r;
+	return r;
 }
 
 static void dm_destroy_cached_state(struct amdgpu_device *adev)
-- 
2.47.3

