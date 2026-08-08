Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B60C5AE49
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A59B10E6B1;
	Mon, 10 Aug 2026 06:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iR7ZfJh6";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F53B10E091
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 21:10:37 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so496169a12.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786223437; x=1786828237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yArLt2s8wdC4FzctPE80cYnqePeUAwYoOgd9G0fcya8=;
 b=iR7ZfJh6bnmcYDf9tunnqsZEM53AlipaVQWVVU9S4gUemi+kQm1fbYPRTdQr+Vbhml
 c0dJ2mm7WL/qmeFKCICua/C78EuvT6dsjzrUZXaazum3bIi9pkV3yCUM5O5ag1lmPKn8
 6sK38xyNaYv0NLwX2CowpIl0nNPzyttQ1dw+a1JpDmxAbR+qJcvnXlUP/StH7B3M1fRa
 Glq6Nfm+ZFOgWcVA8iJv5IaKzF26sNlm4pyeviTkHAQ9Qgwa65N5rq8kg43OBHTY207A
 PEZSwDKPCHbdbgHthw6YOmUbG5z8//rVmnNLEiHsHCLix5FpsDWTEbgbXgLV1mJYPb51
 chiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786223437; x=1786828237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yArLt2s8wdC4FzctPE80cYnqePeUAwYoOgd9G0fcya8=;
 b=sOyMhBXN6tgq6ODj74dLIF3eRDjeuW+ZrvFeTzvcZSGaPQeksfAyBoxE+LlI8y+lYn
 uz+Vl5wR+OypGYBfXLiWXxuzO1asy6qsyH6KKd0M8oQjtcQtpuKeqlX82Kmfq7HpuYsb
 jQGp4PVdtyNSI1Te608syleKqRE6sESp0QYabKGFWMsh3LM5vnrMwBACToGqpZ6tAx0p
 r4YqwoZIOXNUub/9CJgCukbsB5O26TcgR0JZPAwlQyGvnUtAvhvtIZMELdG7TSBIDHov
 yHUjd2B6yF8eIMHUJepAwznX1lVo1Dw1TiZsygK7huBjPuLpB8fiY7f2JiTTJdMZ9MFy
 /zbw==
X-Gm-Message-State: AOJu0Yxy/nhBbu7PL9zv3ULB/UosZ7Oq44X8ycgT8MgPeDWMQr5mIeqQ
 yuDh1MNVy77YcJJhWM6jeIC3yRv6ZvE64e8A3zs/tFazopsX3EpMS2mtafAwGPgM
X-Gm-Gg: AR+sD10vdl/fay2fknBcJRM8HnfnJHOOCfoYuMSJ34jR+YkXQiSz0w7H9Ue/FfJHcvJ
 2g1OfaBmOb223QdskPrcODxU6V3RMWF5/AysPuD37oZ2DkmXeCtjy4xziifU4YPap+ug4KOMhmu
 iVfqNzqjisHosY2m/c93FrNreLXk//X/B0zyVPKmMrUnlOid5ciBQSj9V/JxnnRQG3j9BwqHt6a
 MfaS3HzeQp1bEO3T664CLdm+fHFptINmekaX/1aakTTHE6fiSyJtwnvCA5gM8xHO0WyoHz0Qa4j
 bYMNGoo4mXLDWilbdEBnOw23eELGNnN16K/hrHurBK9VKUcl7iKVftqVe2DRsYgaSnopXd2stb2
 O/KAH8PQ7ID52AeCxPmc/QouUvI1Yoh49k2lqAOzrmKadHqmQCxJL8+/ZCnRlHAtbIC7U4rNwid
 pbcoeBu5GRvdG0wWD4ikG/wpBw8esrif7CBemQEc3pzl2MqKakLzpDcFI1MIR91yjs/4NXEe+LH
 4+gFZfk8Tg=
X-Received: by 2002:a05:6a20:918c:b0:398:7ed3:a001 with SMTP id
 adf61e73a8af0-3cbce6ca776mr10224996637.2.1786223436830; 
 Sat, 08 Aug 2026 14:10:36 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec5aac2sm25713133eec.30.2026.08.08.14.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:10:36 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH 3/5] drm/amdgpu/aca: Fix inverted validation logic in
 amdgpu_aca_get_error_data
Date: Sat,  8 Aug 2026 21:08:50 +0000
Message-ID: <20260808210852.2938-4-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
References: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c76664af9902..1cddacb7c554 100644
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
-- 
2.54.0

