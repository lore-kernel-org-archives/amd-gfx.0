Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF4FC5B56A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA48A10E6B8;
	Mon, 10 Aug 2026 06:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qsVZzUHx";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE5F10E043
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 22:29:51 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38e3efab7e0so517192a91.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786228191; x=1786832991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A3BeIAtfJ2/omVu82I5VMk45uIa8CTiHrIT/44X40ds=;
 b=qsVZzUHxzQVLLM78YHWlVGv+hhnS7uO6Z3VC5PVYgDzJb9CeHk/ZlXeOXZFPJZWrpG
 TwlLB9AIBG+i39lzdPV6BRlhV60trbyJCnD2x6pOJUPacGzxHL+z8CIrRzhQG05UdYL7
 pl8EzPgTP/Aed9rwd0dhcPhQfpsxkMik59Y3lcXv8UtoYDCqO9awNmE1fKNRIvJ/OIV7
 lH+Bs4lxMLuoJW06s/kWPeo2iLqnfoQctR2o4zI3+uLr2afOpsBhspDjfKdQ67TyjQKj
 IIRvzss5Iq7x3wdtHedyhDrJLoklr6Y8NyvHP5S3fbPAHeK0CPZG+YuPIhjewN/6TY+K
 BMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786228191; x=1786832991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A3BeIAtfJ2/omVu82I5VMk45uIa8CTiHrIT/44X40ds=;
 b=MB0kO8tze/21NFyf6807AgUqkxzw8dK1A5bOpE82kWwOE4tk2KTXhB0AwSK6/I4rtF
 ZP420Ot4cqK/BXyQNsf8kg90dfFTZiD9Ro7E0QIIMlK+ucjYUDNpsEmz7g7I9SHfL7vp
 SpQFr1sx1XYZ6BesRMFkjCoupIyw/KifwwtSmwmr2m1RBsgsna6RLP8SmY0PgF3gzK99
 XrfgWUFnakegUktRsf3biS5Q0aKpUwq5zkQcYAmaoIl05KYpsHOburc7+DYxY12+NRRw
 uRLDh/M/LgD4ItALf+eTHOySMkmIuhYTeAHhiKsAf+EBqmKKm1sLOaMFontpkd764Stb
 93ag==
X-Gm-Message-State: AOJu0YwZY03l5aZ/GD0MC0+zUu1lB89JQP4o9od3w2utlEw3nB4CN2jI
 dXwypwOCXVSmwVB5duIKyexz83az7ztDjacKBKuZwgr2jh1qmb4+B4h8GipWVR07
X-Gm-Gg: AR+sD13/o7wiZoDiGbeBAKI3y1SFek7vBWjSDmp/BwZGIFRhyr6ROfv9wtSH0xdlzOO
 fnT/o6lQY3mLZKswc+xKDGNdgdPsZ9haAbUpZsoWF6R5v1+lhy4VlCfcxYY3vVVgoFMIyGKrVAq
 GDCfYtXe/Z4HJqKG9dkzyF7EMBmLy60PTX6kAtytud9DDS5rSOlg2Vua+T1e+Iw4FNRNY8DaoF5
 bYFJ+PksIz/o10JCUOdN7JJVOMAHGnUGt72TOd7B0vyGQkHKXBXDFwPfxQzXZoBo6U/VeD+BB9e
 2v0dMfPwVCGEEucv8OCkE72jVtc5kus4fMQNz/uqa5rP9hhB7FDBS8b4NMmEsp/Xn75/FTVphcz
 5YwTM7fO6khoAwn1pOSYnBwbUgSZzKD8fXbr3KbYhnqs54A/CR4QFpJkkWhHUtx8VyZKuRNlmc6
 /t+jnulf788digtn0dbvG4GPSN3aAXGn2r39I2KNGJo+vkO+xcgbKjVDjYwkKL+QoZUzPHEHXCo
 21bmtL0yZs=
X-Received: by 2002:a17:90a:dfcf:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-392847505bfmr4213335a91.15.1786228190844; 
 Sat, 08 Aug 2026 15:29:50 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb877b4sm27463910eec.19.2026.08.08.15.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 15:29:50 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2 1/5] drm/amdgpu/aca: Fix race condition and UAF in error
 cache logging
Date: Sat,  8 Aug 2026 22:27:38 +0000
Message-ID: <20260808222742.2859-2-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
References: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
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

