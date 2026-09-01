Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B96C624D1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 07:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8046410EBC7;
	Tue,  1 Sep 2026 07:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CskD5+OK";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6570C10E3A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 07:26:26 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso630007a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 00:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788247586; x=1788852386; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N0EL/pf1f3ThtoFU4Hf1cFodrWTG5punvyNZKF7Nskc=;
 b=CskD5+OKxKakCz29ip09+XiA3ginEgsALUvtu+KW1OAeMots+bnz6gDUEBkH70lqLX
 7ug9G1e+CCkzn+7ikmJIiK7teEiJl/rh8cu00XxMmumoAqkF7gpwKB/VxZplfGFT8FZH
 e6c1I4ma6iQpxlTYDHz9mrJ9NlE3kApCmv9SXkp1Ae3OObWKVtEIPra7sN8XYE1usJWH
 upKUoEFdxNmEaQEY6KsWqH09jwRQV+RjM5tOk2ra+dMf/6jvyniZnbThsYDqPbk1YcEK
 v+BMgpx4V2V5Ty2d2wogai7IdKM6e5JmkWVijfqq+d95fvHKfkGlm4IvPU5aAxIOMWRm
 6VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788247586; x=1788852386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N0EL/pf1f3ThtoFU4Hf1cFodrWTG5punvyNZKF7Nskc=;
 b=euYeoMLcX3o602eXvyNKA02ZTwQXayfSxzs2mASv53wiEuYLObta0Y7soRiBoeeqU6
 RVKifZpcJ/WQ1ASMMi1kPGbujsSgI9OUrnV7ed61h0stjzzX/B6mXLniJ41N/otaZaRV
 TDtYCzx4OQ2fiRd49QzutN273sy66EpjKzjTsG7umJxA7QZKd1yjGz3EryXfbXidNmG+
 tSc59lSFvH4d2ehjgFQ2NRvPO29J6AwSA96btEhIqWwgUtGq9meQFkMeEjK1feel1s7N
 kTWVPiHa6pNlrLHF3HDmTPVRjUUUdQNWB8Spq+Y+eD0pSRIm4m8E0hWFlE4MgKkbR2Nu
 rMaw==
X-Gm-Message-State: AFuF++nM/DB2OApGK4NcfmUGvqF+7PDyZ7KBW4KXVnDv9uaCJge7yyc2
 tLZg58zkSQsFpEA3u6P8ZVXJ57WlNLdZYb7rQqSjVXbju0jDYIQp1xDZ
X-Gm-Gg: AYBFou16EzWs4milENQZ7qsBTJNBFUmKPzgRNIZGrzq3B0tUhQY9RgfGVYygXSVWgJH
 lFInnN0AmWlRWDLUIwc17zbA1Y2ANDxs4svgQfuyHjJ7GdCoXW7I4J4LpbpeJncqYt/ooqThwD+
 L1ssYBg1FKicCGkaMHvpq4YAc0uskiuQxrUMoJH5wCd54wZr0ZDVc+d0Z+VzHHe9nDU7aviVX5F
 Kys9pubYPk2bYzZp+Y2QUMB/v3d23ZuEXiOmEwUzZ+jdMSmYE1D+IXEL3N1BbakeSRPz9O4cRg8
 H6mUTle7PeuewKHC+X2pUZfo3FM1QsTNITn9epU78fDQgkbJAtAqBNZEryR4yGlQhwqkN3vrFNG
 5t8PSLnNxPkmtU65d9O/2nMnN3kUwNE8kcGeNKkLxf3ZwRGldyD0lVLP10UrvtCrDZu62FWYYnu
 9Bb+1D37PYzepXLQ5qIMP9LY+8Z2lFPPupP2hZKvVRFhHfvpdHfNk656g3oYV6ePkSskxo
X-Received: by 2002:a17:90b:2c88:b0:396:b98b:a3c2 with SMTP id
 98e67ed59e1d1-396d0f52a0amr51476456a91.8.1788247583735; 
 Tue, 01 Sep 2026 00:26:23 -0700 (PDT)
Received: from i386.168.1.127 ([2402:a00:163:2ce9:6882:91b7:8e79:7958])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0dc898dsm32895480c88.9.2026.09.01.00.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 00:26:23 -0700 (PDT)
From: Hrushiraj Gandhi <hrushirajg23@gmail.com>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Hrushiraj Gandhi <hrushirajg23@gmail.com>
Subject: [PATCH] drm/amdkfd: use kzalloc_objs() instead of kzalloc() with
 multiply
Date: Tue,  1 Sep 2026 12:56:14 +0530
Message-ID: <20260901072615.522925-1-hrushirajg23@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:59:19 +0000
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

dqm->detect_hang_info, dqm->hung_db_array and dqm->hqd_info are all
allocated with a hand-computed count * sizeof(TYPE) size. If count
were ever attacker- or firmware-influenced and large enough, the
multiply could wrap size_t and produce a too-small allocation that
the code then writes count-many elements into.

kzalloc_objs() computes the same size via size_mul(), which saturates
to SIZE_MAX on overflow instead of wrapping, so the allocation itself
fails cleanly (already handled here via the existing NULL checks)
rather than silently succeeding undersized.

dqm->detect_hang_info_size is left as-is since it is also used later
for a memset() call; only the allocation itself is converted.

No functional change in the non-overflowing case.

Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 67137679a901..5aa42fd5bb49 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2013,17 +2013,15 @@ static int start_cpsch(struct device_queue_manager *dqm)
 			      NUM_XCC(dqm->dev->xcc_mask);
 
 	dqm->detect_hang_info_size = num_hw_queue_slots * sizeof(struct dqm_detect_hang_info);
-	dqm->detect_hang_info = kzalloc(dqm->detect_hang_info_size, GFP_KERNEL);
+	dqm->detect_hang_info = kzalloc_objs(*dqm->detect_hang_info, num_hw_queue_slots);
 
 	if (!dqm->detect_hang_info) {
 		retval = -ENOMEM;
 		goto fail_detect_hang_buffer;
 	}
 
-	dqm->hung_db_array = kzalloc(hung_array_size * sizeof(u32), GFP_KERNEL);
-	dqm->hqd_info = kzalloc(
-		hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info),
-		GFP_KERNEL);
+	dqm->hung_db_array = kzalloc_objs(*dqm->hung_db_array, hung_array_size);
+	dqm->hqd_info = kzalloc_objs(*dqm->hqd_info, hqd_info_size);
 
 	dqm_unlock(dqm);
 
