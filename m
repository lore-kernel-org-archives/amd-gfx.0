Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8683DCAC5B2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 08:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB3910E5A1;
	Tue, 23 Sep 2025 08:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GaBPtu0S";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BAF10E4DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 18:56:50 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4694ac46ae0so32164215e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758567409; x=1759172209; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eyJq43O++KjLnjYoBP21Xp+znz9y7wC4OFS1xU5rHgk=;
 b=GaBPtu0SyYInqmLNWXilFhM26EIrNv/4IlFajwFcflk+1P6ABZzBg51vfCQFGpdlfi
 sMN4/CFf2kgap0hNUxWFQJUBwil7R3Zd9slDqV+Fvu+vo/39TLdjvWre885t3U83d3Ob
 iIIkVsC605tkh9GsBOb4WaljT//OYcC+uzOMPNVmDgwM9Z6xjIbB4wq/3H4JhR4B4w5c
 fdEfegoLrh2o9ozVwiHQ4EAFDkqQjP84+RTXzPyvqfOFRmbvz5TafwcewZ4IG+qqm6nN
 Drx36Bxunp25tNLd4jOXKMWQ5aUKIXWYJklX/YDd5it+N9ajMoeRYdFtwg0juOSQmwYL
 KkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567409; x=1759172209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eyJq43O++KjLnjYoBP21Xp+znz9y7wC4OFS1xU5rHgk=;
 b=TyyqjOuQFAEWAeUkQvmWNP4dgTLOeVM/acF+92ghONdh0nWr0JnRX6XEx6bj+F5mS4
 mooKGXsc8GGkF5TmvxoJXiTDjTPR6cW4OPYrMWcoqwACVXEMC+m62Ke2g2gJKuGELurZ
 +wq0v8+SGWSgGuCCUAjqAJuUNTDhZvOC6xCpd32pEBDdt5cfNoKvpAbdHWOw61gl4wiM
 zKILWa+0XzqYrFyDPouR8rVWB+so5GR/dejqNna+YP1JQb70f+x9GM+RXRw0HpQs6+34
 JBd8GpqbmGFGHziDpiN4ETIKNRtSTcUwspmVkymCHefSzkKF2dBxuzm8vHwkqejtFjgb
 PyCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuh0t3YmUBuq8DvL7QlX6qnXOPwGwZvljocClcY+qG9j/ReIRC8kG+d032uKH7oU6qEo5A0Pno@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHxqFg1g0NJ1OQkVVnRikV5epdDd1fuEjgM6IjIGBk+YZUHVr4
 3DNSc6zo+nk8uaP2h4rBSBIa/OVC318xkn+EbkYjCXuZjZhhyW2OWedh
X-Gm-Gg: ASbGnctz/zt79CMMpn3rD7l+T33xkDmJfpkcNYsaujhGU2i7ZuDTFiJWwr2842qxMk5
 pdalUxrfLaje4r7QTRtky2TkOqVP/jfA76ppM5jUsZdBLlyG0M6IQ0zUXZPW/Zj02S3+0lngcl2
 rC7youssHXcwnaV+uxRD9HgAyYOCQBL99KUBvGQGQ7iWUlVM0gblMaF0HObuStSLyZ4r0MZPYe6
 M1wBZRpkV1DTKHL1HR7Oru8r4NgMC5Gu0omjbPXY/1OUFFf4gW8qRTzJfGjJ2oaS/ZxBR0OuoFN
 TjsccMhDH4XpzXArrM05Uxn25a6/Wf0qN/ZChFlNQ4tYpumHxAprip8uTcrbwTuDScqx884ke9w
 qGvLjnq/Z79SmnD0AaWwWUFT4u039zeE=
X-Google-Smtp-Source: AGHT+IE2hNAByN1u+WlmeKvdGqq3iQsBllgNjf2IKG0z3jtosjk7L/KvCjfFpn/X7tEHILQPO5GNNQ==
X-Received: by 2002:a05:600c:45c9:b0:45d:d1a3:ba6a with SMTP id
 5b1f17b1804b1-467f15d405emr134177295e9.33.1758567408745; 
 Mon, 22 Sep 2025 11:56:48 -0700 (PDT)
Received: from moktar-desktop.. ([102.31.181.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f0aac439sm241209755e9.5.2025.09.22.11.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:56:48 -0700 (PDT)
From: Moktar SELLAMI <smokthar925@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, Hawking.Zhang@amd.com, tao.zhou1@amd.com,
 lijo.lazar@amd.com, ganglxie@amd.com, victor.skvortsov@amd.com,
 candice.li@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
Cc: Moktar SELLAMI <smokthar925@gmail.com>
Subject: [PATCH] drm/amd/amdgpu: use kmalloc_array instead of kmalloc
Date: Mon, 22 Sep 2025 19:56:35 +0100
Message-Id: <20250922185635.50828-1-smokthar925@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Sep 2025 08:54:52 +0000
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

Replace kmalloc -> kmalloc_array in drm/amd/amdgpu/amdgpu_ras.c .

As per said in the Documentation/process/deprecated.rst, dynamic size
calculation should not be performed in memory allocator function
arguments due to the risk of overflow.

Signed-off-by: Moktar SELLAMI <smokthar925@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 540817e296da..8dbb9e349a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2566,7 +2566,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 		goto out;
 	}
 
-	*bps = kmalloc(sizeof(struct ras_badpage) * data->count, GFP_KERNEL);
+	*bps = kmalloc_array(data->count, sizeof(struct ras_badpage), GFP_KERNEL);
 	if (!*bps) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.34.1

