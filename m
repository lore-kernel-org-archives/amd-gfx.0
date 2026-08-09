Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F85C5B567
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEDC10E6D6;
	Mon, 10 Aug 2026 06:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PqKi0mzT";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E0910E10B
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 08:49:08 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cc73e322dbso8550805ad.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Aug 2026 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265347; x=1786870147; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A3BeIAtfJ2/omVu82I5VMk45uIa8CTiHrIT/44X40ds=;
 b=PqKi0mzT9RpvT/V9AP9sOZFv+LpVKzN8uZOIebDxh/KHGIGOTlYLRheWVA3Q5AyZv7
 VXLjK2NAbHY4f5Q+dahSg8/zUh26z48Cp+XDQomTQh9LXN1kjshRDwFGKHrfXfsXAMJ9
 yj/c/u2N6mrgHW5yzOi3tCEA4GT/jfHhQgjbcKsOcmDPTHuO3ldHZGN+edYYGbE+xSKA
 9TG0ZU4w42+kQhzBjXRx0Ot1CIWYt1rD912SRAVDr3bBGm8XL16jwb6qIEocbOmUJ9nm
 SO2SMQ1c/MXB60sJ7mIDaG1UrJgcT7IeOjMRu2FkDB3ClnFrlwIaDBZl4jpvfdI8Pbej
 4W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265347; x=1786870147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A3BeIAtfJ2/omVu82I5VMk45uIa8CTiHrIT/44X40ds=;
 b=aFRvASG5N3YSOk6IV5ZfiPFKmtWkYJ3N88CkKDK4YWSc10BZfb+MAQOaK0k0DbAdbD
 D9rTumvvQVsjixv8MycBu+vk/VaKJL0w5VX7JcB8db9SeuXGKZ+7KQmGxz6erN59eUlq
 xfsInQcYQ1XJy/sfi/L7IFUtdoRNyaJYwwQ8HOIn8Coj5Ll/K4CmCj5oApitr0UwmoGk
 fbkPg0WLux5rGBMBd3ncC30GKCumssgi7BJ9na/6icrMo0BM7maW4s/hghMQGzfbVkE0
 4zd4bzxBwOe3ay8nF/+Ey+dUuL5GRV1nsM91upwsJUF62ZjZyO4lO/nivnS38t9uCpFR
 sD+A==
X-Gm-Message-State: AOJu0YzDH05S19IWEFdZT5M/UHVbOZ1WMQO/DWts0AVTaYKDuYMjjXoM
 SGqiRiyxKUph0+NYuC9zk0XiJ8b9RgvWnMTonO7I+g23ZNFA85QMFVAY
X-Gm-Gg: AR+sD13W50uX1hWE4OYfy27Vte5bB89mB+DDn58WbkL9bYtmNAURKhYIiD+btwwpx0+
 RnEMm5gmTJ/BjXApAPXogHUzNN4LPF5y06Ky9K1kVqfIx4ELfuPaJiqLYxx3rSfAGdcmd3kW4kS
 8aK9/rcF+gm9t+HMPdpAddRTK9jaQPszNxiszsMVxOWBb/4X6RAsH1Ag/OuHuwhcEPart7H5zip
 Z9pClS/RMj6p7dy/wEhmHSFsBDct4ozUwI/Wzg4xZoabw41glItQmKSLUICrdEjlpOvXCJWzgga
 FvokOpC39FVd36gC/ky38TXGvXf/kdsr+3P3NM9K16sm07skH/2h9UaCVrtjyvXv2fQGq9PV5hQ
 cLdwSfaJ+19BIHNRZLrgQr84wJae5B4eIkJY1XOwdkDyCOldPQJHqtj9p3WHGW7XBkKwbzKWkm+
 1p7nJIP5AbJxlw4r7gqRsUHZVIYbpK3bPve0seF9I1QPTdzDl3lq+A43AkcM4AO3IBovnMRAevy
 XGxpcryELI=
X-Received: by 2002:a05:6a20:9e0e:b0:3c3:66c5:68cc with SMTP id
 adf61e73a8af0-3cb85efa4f9mr44179451637.21.1786265347177; 
 Sun, 09 Aug 2026 01:49:07 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:49:06 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 1/6] drm/amdgpu/aca: Fix race condition and UAF in error
 cache logging
Date: Sun,  9 Aug 2026 08:47:30 +0000
Message-ID: <20260809084735.9743-2-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
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

In aca_error_cache_log_bank_error(), find_bank_error() released
aerr->lock prior to returning bank_error. This created a time-of-check
to time-of-use (TOCTOU) race window where a concurrent caller of
aca_log_aca_error() could acquire aerr->lock and free the bank_error
node via aca_bank_error_remove().

When execution returned to aca_error_cache_log_bank_error(),
incrementing bank_error->count resulted in a Use-After-Free and
potential kernel memory corruption. Additionally, bank_error->count
was updated outside mutex lock protection.

Fix this by acquiring aerr->lock at the start of
aca_error_cache_log_bank_error() and holding it continuously across
lookup, creation, and counter updates, while removing redundant
internal lock acquisitions in helper functions.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index db7858fe0c3d..d0d473082431 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -237,10 +237,8 @@ static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_
 	INIT_LIST_HEAD(&bank_error->node);
 	memcpy(&bank_error->info, info, sizeof(*info));
 
-	mutex_lock(&aerr->lock);
 	list_add_tail(&bank_error->node, &aerr->list);
 	aerr->nr_errors++;
-	mutex_unlock(&aerr->lock);
 
 	return bank_error;
 }
@@ -249,22 +247,16 @@ static struct aca_bank_error *find_bank_error(struct aca_error *aerr, struct aca
 {
 	struct aca_bank_error *bank_error = NULL;
 	struct aca_bank_info *tmp_info;
-	bool found = false;
 
-	mutex_lock(&aerr->lock);
 	list_for_each_entry(bank_error, &aerr->list, node) {
 		tmp_info = &bank_error->info;
 		if (tmp_info->socket_id == info->socket_id &&
 		    tmp_info->die_id == info->die_id) {
-			found = true;
-			goto out_unlock;
+			return bank_error;
 		}
 	}
 
-out_unlock:
-	mutex_unlock(&aerr->lock);
-
-	return found ? bank_error : NULL;
+	return NULL;
 }
 
 static void aca_bank_error_remove(struct aca_error *aerr, struct aca_bank_error *bank_error)
@@ -306,11 +298,15 @@ int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_in
 		return 0;
 
 	aerr = &error_cache->errors[type];
+	mutex_lock(&aerr->lock);
 	bank_error = get_bank_error(aerr, info);
-	if (!bank_error)
+	if (!bank_error) {
+		mutex_unlock(&aerr->lock);
 		return -ENOMEM;
+	}
 
 	bank_error->count += count;
+	mutex_unlock(&aerr->lock);
 
 	return 0;
 }
-- 
2.54.0

