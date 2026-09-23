Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA8CC98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 12:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5760810F511;
	Thu, 24 Sep 2026 12:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bIvcWWZW";
	dkim-atps=neutral
Received: from mail-lr2-f5.google.com (mail-lr2-f5.google.com [74.125.230.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04BD10F0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 14:55:09 +0000 (UTC)
Received: by mail-lr2-f5.google.com with SMTP id
 38308e7fff4ca-3a20b70da4cso6239961fa.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175308; x=1790780108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KLyY5MHaKq4xCUtb5Tr0mqR1G0KiRq9dtEBuRM3TfU0=;
 b=bIvcWWZWDpwJpV/5hjyIZIN9rK+4FyXrGVI1Qn7I0/vxv14KcjEWbG3HEJqG5CwQcI
 daT6BOKs93LiGCACn8XFajj6pYrjqWRANgdMlU1+Yw5T3lUFX+ooawfEPJ4DhUmocFC6
 eAPjfpAKR3ZNGHIBz4771YGp1lhWD99Glpy1J4wk+Lbr4imTEQ5ni09pc8XKPb0GfTby
 HuLhxI1G2yPuZriQooZOR18vTVepVjogrnmwg8T4Tkpu6m23LcX5POFqiYszY/3Wu3kh
 RQSz5bp1j5IerHW+VNEaGDIKW9/EXIu+ISVWtfCXrHB0Vp/6PaSoiI73svx0+s+X9nAu
 HhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175308; x=1790780108;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KLyY5MHaKq4xCUtb5Tr0mqR1G0KiRq9dtEBuRM3TfU0=;
 b=MGqIxdYF2Vuvf4Rc6na01jiJ2Epc8ECU144/EcUwMgYr4QF3NBuHBDXyf0EF+a2lYa
 7B/5aMtyICI/Kewl4YyRgOKstVX9q4lazi77B9UggXayVWpIPGHqD7/q+n4glLPx3U0U
 /buV9/Cz1Yvu3VwTZUhD/PwNXocohbOxPBpli2DRF3ToU8JIymcQ60vafyJLGYq6aOw5
 m3pDrYFukUjiDWevjILvFOJbBY4v0RAbG+b1eRQQEs0dt6uY6nbUlY4P6v5cPrX4xvT1
 ifXqfHkNC5J4KkTR+XFTMKiAryUf0g57k6JMV6suGDfcY0YMG/+LU+lc0Lk15NszHUrx
 pXLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvamy4Q9i8hYnRYPBak9BmkSiaDuZDSq1Nqizj5ztXkhogqbzIVyJsKcvZI0YcNySRS0DBgawn@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8NdTGhOZyRVKthxN9DTY2c4WmhGmcUc1y9EtN4IvjaCqPMmaV
 Fiy5Y1JozTf15wTSWuY5ioFlNoPH+2GM+wI/qhVHF1YvK0quqBzluzzd
X-Gm-Gg: AYBFou0d5JW0y1cywVczBlavNBbIruJMyc8lMstiz64buRtyS4mYgEU18ofEDS3pIrX
 73IqU4H9AbmKfNPay+y7PHzF2ezkl1YUUYPjk4ITjkShN2sRjSyT1jmLofdbTe8hVmIxsF3SEmP
 wctVoxt2KOtsHLTgmVJXsMzfU1Oovdv/4BNIKKkO3FizMNiHOLP9ACDlmVr5QaVmTutLb4EqUuz
 xNs3jNBGQwMq9Youprg/7SqPVCEjF/tGhV3ZE+es//NoGeHnc2o6+KYO2UC+iyb0vSfWMOIOfvm
 OsJSqgh0uSLxQMF/h6SaHnfB75kYcXLVtpp52Kf+/iDsnc8jpG0UebEVjVzmwrx/m0mjr9iNDAp
 M3NSKcze5Jmw8JEJCp0DDG37i+qzzowi1M6ND4g/xH+J03euMNr3oLqTBkPImgw6OhdlKqV80OQ
 fEr9G17ht4wK3oF+bkSpY3bUBpBplWabcgWGwEDAfW2jAnfGfq4izE8tTka+czsIJP6qXEFaYoS
 wCRBag5NoxMr52W3w==
X-Received: by 2002:a2e:bc16:0:b0:3a4:8510:f45b with SMTP id
 38308e7fff4ca-3a630587d23mr6394071fa.8.1790175307836; 
 Wed, 23 Sep 2026 07:55:07 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a62f527d51sm7824951fa.33.2026.09.23.07.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:55:07 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sasha Levin <sashal@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Jesse Zhang <jesse.zhang@amd.com>, Fang Wang <32840572@qq.com>
Subject: [PATCH 5.15 2/2] drm/amdgpu: Limit BO list entry count to prevent
 resource exhaustion
Date: Wed, 23 Sep 2026 17:54:49 +0300
Message-ID: <20260923145453.76114-2-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923145453.76114-1-roman.demidov.nn@gmail.com>
References: <20260923145453.76114-1-roman.demidov.nn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 12:46:10 +0000
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

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

commit 6270b1a5dab94665d7adce3dc78bc9066ed28bdd upstream.

Userspace can pass an arbitrary number of BO list entries via the
bo_number field. Although the previous multiplication overflow check
prevents out-of-bounds allocation, a large number of entries could still
cause excessive memory allocation (up to potentially gigabytes) and
unnecessarily long list processing times.

Introduce a hard limit of 128k entries per BO list, which is more than
sufficient for any realistic use case (e.g., a single list containing all
buffers in a large scene). This prevents memory exhaustion attacks and
ensures predictable performance.

Return -EINVAL if the requested entry count exceeds the limit

Reviewed-by: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 688b87d39e0aa8135105b40dc167d74b5ada5332)
Cc: stable@vger.kernel.org
Signed-off-by: Fang Wang <32840572@qq.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-23468

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 22d7b7c504db..ca0d82be5c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -35,6 +35,7 @@
 
 #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
 #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
+#define AMDGPU_BO_LIST_MAX_ENTRIES	(128 * 1024)
 
 static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
@@ -230,6 +231,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
 
+	if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
+		return -EINVAL;
+
 	/* copy the handle array from userspace to a kernel buffer */
 	if (likely(info_size == bo_info_size)) {
 		info = vmemdup_array_user(uptr, bo_number, info_size);
-- 
2.53.0

