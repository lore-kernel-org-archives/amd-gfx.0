Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434F6C36002
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 18:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE92C10E16B;
	Sat, 22 Mar 2025 18:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dzD+wT34";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02BF910E16B
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 18:39:03 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7c560c55bc1so334433785a.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668742; x=1743273542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=D/AWyIJsFXsu9b7mKexS+DPGxyMGxrfwDL7sSuRTTDw=;
 b=dzD+wT34MCG7SrvCCksbQFcsP2pojNLvhXGWa1wLeFl3dTLndncN/xXaU4NZ23+zVr
 rupoxpS3AYA9uLctM06HFwwp4MZmiGInXzHtfGIFHTcxK/m6lXuCAf1XsrksGjT08I2v
 XJrnR4VY8YePTBOf3X4sphtAEBFbtJ6HM9rEuNHpaPdObY1yxdpTUqmQVO/1MhN+SJIv
 wNMGxe+J7lsZ42Hp5WvL7a7ocCKG9vZsPdeTbodoCJpoxf7F3+Q/KtKHvJMgykntFBIn
 eKzhk98qmq4dJNK5kfsnW+QGcWl2zP6hxkQpZN8IszyKE/ea3jldSAvS5aoWI9m+E1AK
 QVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668742; x=1743273542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D/AWyIJsFXsu9b7mKexS+DPGxyMGxrfwDL7sSuRTTDw=;
 b=f0s4Z6yfZUz25inY8xSlrG3lejqZXr+nmVfg6RGhuXaeUO04pxOMdHBgXOmdzKVNmG
 tVlPJ1UAvByaUSbjGQ6bvvAyHmJyHjJB4zPwm3R2gs6swVQ55z90ql0mknWtobajRspm
 kGaxuW8re1jw2neiHf6PHhKcNVFUwfJ6648RW5vUlWyMG7V+bFx7WUkl3X6cShgY3q8U
 2sTTFq5LhWTjREnh7+yPgJh6DfRQ5IJbYj1zQ42GeexZOIM1xfYCx8HvTtENt5l5Peve
 rUG8AL6qQwBn7gMcKbZyyFq3QfFjPgkm5XpjMryrka1ztUQk83XG/v8Ec3qHIQVKNLKf
 jegA==
X-Gm-Message-State: AOJu0YwOjeOWqBcJGj9NegSiyF/KNVC5IkTzC9/7VmBkKtY3hj8nVywT
 UAP/Tdhq8PYSGq6tEhl9v8DXpzq07Z/VKOqoDbBAgeFVZ97jo/pSGPJk8w==
X-Gm-Gg: ASbGncvBN+ttcukoBE5DXL6f9qAQlHbaUx3YWInBfV83jRvPO5wQADgDNSaWRHeCaDG
 H76qwdV+x5EgSOsTw8a0Uk5X83lH3GbY0TLyIcDP8OD6yQBPx+VwrnmeyF4a/gYW1alMV7t1Uur
 ysqL1a3Xv/4twCou3O2/MA+NgD0yQO1dNcqsUuBRdT7UAHVjg0K4eO45I7/Hfn3WWWgdCsfK0sZ
 9I6xN/XvIsT1ygdlaE3Hn6jPIUPOtzUqyNKOB4mhc6NcyFBstCoYFqcEZwnaRmQ8jd9oQqoEa+p
 LYapWt5ySNxf5eAry8Iw4c3FLUXLpcSzULOZPHp4XU28pW/z3RbXQhaYdphDiuOWeZ8=
X-Google-Smtp-Source: AGHT+IE+ZyC85UgRxYKt9mOqfu9MNdollD5FswL7enIhvUJLQVXotezkGK1ME0ZtQ4WE9g71lBer9Q==
X-Received: by 2002:a05:620a:1a9e:b0:7c5:48b8:b4ac with SMTP id
 af79cd13be357-7c5ba190c07mr927271185a.34.1742668741905; 
 Sat, 22 Mar 2025 11:39:01 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d18d541sm25762911cf.36.2025.03.22.11.39.01
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:39:01 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/radeon: fix MAX_POWER_SHIFT value
Date: Sat, 22 Mar 2025 14:39:00 -0400
Message-ID: <20250322183900.86061-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

While I don't think it is being used anywhere, if it were used, it would
be wrong. We can base this assumption on MAX_POWER_MASK, where the shift is
by 16 bits.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/radeon/sid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/sid.h b/drivers/gpu/drm/radeon/sid.h
index 65a911ddd509..f9267b026f8d 100644
--- a/drivers/gpu/drm/radeon/sid.h
+++ b/drivers/gpu/drm/radeon/sid.h
@@ -1109,7 +1109,7 @@
 #define		MIN_POWER_SHIFT				0
 #define		MAX_POWER(x)				((x) << 16)
 #define		MAX_POWER_MASK				(0x3fff << 16)
-#define		MAX_POWER_SHIFT				0
+#define		MAX_POWER_SHIFT				16
 #define SQ_POWER_THROTTLE2                              0x8e5c
 #define		MAX_POWER_DELTA(x)			((x) << 0)
 #define		MAX_POWER_DELTA_MASK			(0x3fff << 0)
-- 
2.49.0

