Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAD1C98317
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 12:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA90C10F500;
	Thu, 24 Sep 2026 12:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUSJ2efq";
	dkim-atps=neutral
Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com
 [74.125.230.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F2310E8D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 14:56:39 +0000 (UTC)
Received: by mail-lr2-f10.google.com with SMTP id
 38308e7fff4ca-3a46d5c5bd7so6031791fa.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175398; x=1790780198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KLyY5MHaKq4xCUtb5Tr0mqR1G0KiRq9dtEBuRM3TfU0=;
 b=lUSJ2efqQ6/ceBWzoFqXs6T5Faaj17w2DNwF9tZ5sNPJ8QuXeUH+kfwARbcHupO0gB
 HO3ye83vJX2ZVR4Pe7A+XXHGQercQXnG6F4yZ85X0eA1BtwPGSMYl4huwocZuepno0Hk
 tYx6c3S89a6N6dGjQbYcjeNT3Y3b+ebrZf4lfnzQDzv+0us4R0IBtyAV96f5o32DUaah
 EGRbPjuOKLVFrnDaYCFgRo3q44B6BZPYDhs+JWBblAsb3nqj57P8S/vsz7uOEC2mAs4N
 dYPkvKpoAAB5liYA//yix7uey9qkZ5UAao9ucnz6VyHyUUkvbAIwL/MUG1R7yYSMLqol
 KONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175398; x=1790780198;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KLyY5MHaKq4xCUtb5Tr0mqR1G0KiRq9dtEBuRM3TfU0=;
 b=pDn3zLGTDOe/WXgGTE9HnBo282deXbcX4HDKs0FpOw31okOkT32AOGTAJrvReGl4T6
 sjw06vW1MrWKMw9UqlbKbaxQ/gzMGus+W4lr8FoSQLQ7wKDj/PV21ZOZEj+MkstP3wwz
 M1/a9xllyTUvEQUah6ybjnhZnI/qAXQUW22rykNM5fe443wn6cU+0HMnkCZrhyljCogi
 /pEstmDFPJlUjM5mVG1tyMTyqgreJc1ijF/TSd8kFodJacoMQhFYXPWH63k1kCbPjDpw
 Lras8z8li5r9riu7Joe2ZqiRnp62RBfLdhUs4qMKHSQEG2C5bzFP0BZGJW5/R0+QPfAd
 pcTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqTRIQ4shd3P9yuQ+c96z1eUFSBHd9ob/4TTes5DvcgVDU+S5uSbNJPvAteoXz82yfZjqLpaxi@lists.freedesktop.org
X-Gm-Message-State: AFuF++n07ZHwi72k5EZVBPnaUFLRnj/tulwcHV/7G4NhOpKy7SaA4jAe
 klwO+TAxkuMSOSAA6pRhyWxs+BqS+PO/Cz2wdBpqdDZMqfL7KzaiGIfF
X-Gm-Gg: AYBFou3ra43+C0gQ3MdCh8S525i7OHJWdNyUQTLIL/XatzW3BIpu3zAn73TnZ8zUS10
 72pARdEKIOhovq9t/rJkcRBNjC/Kdvz8xSeBQUP6xhgRtPL1M3b+T86URRV0qPFSqX9A7591a0F
 P9QtOATeiVapRV3yhDzmrfSAw0zWir57YnQQ1LQ7wJKx5XazaFBPzjBEPTgBN/fB6UVm/o99Fl6
 vK2BKa6TiE3IOiaugBGUNgvqdZ251uv8bMz40TFA4P4DsEVWh6eBk9ss5glltojN/xiSlu5CM44
 2bTbuToJmEj5zV7Cuna1/e/A7Mf7V84bcoBJPLHAsqSOYY4bktJ3HDlk4fOkSNw8lBpzCoqfkhG
 eAlprdKeOTw2uwZx2XB1am5rhXywPhw1XbOb++KocE9uiWAS3JTOFo7vJYR+m99nErwI61lslIp
 1eeXGenqrtCVI+HglcLwSLP9BxdRJQoxzX5iWXZFAZRUY7e7F1fsMMYsLXcOxtggnbgqEXOtGjE
 E5ZgZaqujtSOwE8
X-Received: by 2002:a05:651c:551:b0:3a5:3b80:8f58 with SMTP id
 38308e7fff4ca-3a63056a748mr6382501fa.6.1790175397496; 
 Wed, 23 Sep 2026 07:56:37 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a62f53b4efsm7512171fa.39.2026.09.23.07.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:56:36 -0700 (PDT)
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
Subject: [PATCH 5.10 3/3] drm/amdgpu: Limit BO list entry count to prevent
 resource exhaustion
Date: Wed, 23 Sep 2026 17:56:20 +0300
Message-ID: <20260923145622.76242-3-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923145622.76242-1-roman.demidov.nn@gmail.com>
References: <20260923145622.76242-1-roman.demidov.nn@gmail.com>
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

