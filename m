Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A6C5B571
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DC910E6A8;
	Mon, 10 Aug 2026 06:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gfUFbvHC";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E81E10E05B
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:08 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cbe3fed2f58so571833a12.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252388; x=1786857188; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A3BeIAtfJ2/omVu82I5VMk45uIa8CTiHrIT/44X40ds=;
 b=gfUFbvHC0EbTKg/0XBN7vKBVaAaSY5ZlZDxWBD+XoUVt4+cqkBGk0MCrLvUMWFZOlL
 f3r6w562ceDnvY+Iv2jH68X6Dldt3HppwqcpUoKTKj21Ib1Y/DLFOFkgd9Ccgnms9yM9
 6eIaVx442zPtkJtZdZ37LYouJXIJnA16Tlh7F42oVI6IEHGz6chT12SmTUZTXFWnF9FC
 1pDvJsqgm+x5rMdcJIW/NeRguAw2QqJDtCaHOoY9aVQjNSJD5tvupLk87YYr/y42ZdxM
 WcSG7rQjftM5MNVIOHPefAaVAR5CHiVet+2g+hnfZUmYYvwn+cI5K3SwBFDU3YDZGtDu
 C1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252388; x=1786857188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A3BeIAtfJ2/omVu82I5VMk45uIa8CTiHrIT/44X40ds=;
 b=bCJozuNMvDA4V3EKgHRTsWY9l3OTY2gqXaaDnRxNYsNcMu/Gjd8gtQFXM+pI47GIUN
 HK9V9uTbvyn61nIF1EkXFjpuca5kYxQ6j2wp5HXQN/IPcB1UwMVSX+LjlkwTIfPlk0Q+
 smQypUaG4fEzKqUQR8u1Qc+yeCQAk3Az8dXK/6w+6YGRLL9rwsXt8RBoIpHbxhPLDrsd
 7YDR2zNSheF01frP7XLho+hqdiLyrpyn07stNhKqAM9cXDYOCSkuDajPHE6ja4CPLKH7
 YD2wP2QbXp0E5hnkG2SIk8HU043FCY42zZPmRei+RLhHS2up2veJwYpb3aJ06bXUY8H3
 Z+KA==
X-Gm-Message-State: AOJu0YwBPtUDIbWTLcJPsf8qteCisJKFLgxcSUlWCdpwrsThw3AyFiBu
 GYi2LKX3MzzSEKfLpVFbEsahoGTkmkcsuQpvorEaNQ7NsfOy11ZoxVC9
X-Gm-Gg: AR+sD10Qqq8oUbTuP8E8w6kQM6Q9AHe5B27vYqaqjxOfGNWfmWDknRxLb5cpThyuLNd
 jH6gdViBP7UrYpj6y7DdhEEuRXau+9g7oC0hZeAVSwbM6zDZ36FUT/pfvIOs7atTqFZPdjwz/fm
 zPDYjZBvzndkCtXBJv7pnqueM/NJPDxUUPx9fpGtNDHBilPjqFu5IJQNTUSRWz4Mp94jkdmOUMO
 hse9i1jMR30wIiGjgPmce+0RGtclIB1QvBo4zjST3G15XN4QLAD2t/v+JngwaXPPpJ1/o7Cj8oN
 zVAZ2c52EggPlhtwNxGpfJkzuhnXfi1rQ2nrfygbnO++29Z2FB+BGmgLLOE5EAYvEnI35Jyrjl8
 SzTOAlpYb/Qo9FluTsaZwHR2AXY2W3qS6uIehkgw6bUnKfsD4kZpt+glQag1I6Poe+qELFZRQhV
 6n2KNYQMTR3NuTYtjq/melKhwDe51Gl9DJKd5L6fGQfYmbkPSXVEtsn8WToD6Rx4A2hyNa9O2zV
 F8F3j1ACfrS
X-Received: by 2002:a05:6a21:a38d:b0:3bf:6fb1:ce0d with SMTP id
 adf61e73a8af0-3cb85ea3663mr41867421637.21.1786252387800; 
 Sat, 08 Aug 2026 22:13:07 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:07 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 1/6] drm/amdgpu/aca: Fix race condition and UAF in error
 cache logging
Date: Sun,  9 Aug 2026 05:11:55 +0000
Message-ID: <20260809051200.3276-2-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
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

