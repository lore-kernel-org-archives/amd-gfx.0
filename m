Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D5DC624CF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 08:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9251C10E5C0;
	Tue,  1 Sep 2026 08:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qM+Q3K/2";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 700C810E3D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 08:41:34 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so7008045e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788252093; x=1788856893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cIPe2iDx1q04AOuThkTiqVbSHD6gJz+15yfxxKXnVIw=;
 b=qM+Q3K/2ppXo3qma+cBT8rYV+E24cNEOacuElfq9w2hYOQM9AwzVN4xpMyCrzzdYfs
 6c0yfk3GPupQuCHb1v4rYWEYrXKfj0Qbrp6Yl1Mqj6hSUMeAK+yVxVL60YHtID95Mbfi
 pOgJwv0Y8hTd64mU4EAc17hdpF+eKFv0UNTT96/QYCQkEwElDz+NcsUFrI0dduZvtXwR
 M7EzYOymJGvsd4HTSZIuHN1yuMPmq0K7lUWr9eXK5lQVTrqkXeuTv6Fzn57MdlFVa1la
 rnJa6bljEgqtUdUT+8T1Tp7wM0q0pade/Cs4m/NBaQCMmdDWfB/T76TtlZtPRHMx9LCo
 3LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788252093; x=1788856893;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cIPe2iDx1q04AOuThkTiqVbSHD6gJz+15yfxxKXnVIw=;
 b=iTvCxzbf6a6lzQlxl+zl1VG2XmkDefQii7K7OTyTYqghxCyB2NMRXkUJOjSLFwK9NM
 Am5Pj8CUDJuhxsrJx9aylaFquIEtqknCIrx3fwUamtSMbQ8Csrg69zMYVvJZEoxQXzXz
 wjRU8VSgbb6yjtxHEbf1zqyjOXLIx7fFEJXXqMj1SfZ31jKMnQts/aClznOCHNeKw4L9
 rTci1uFUx8FqYXNjtK+XeZh5p7W/UGeeso9P7gmnVyqtmm8GCvsPUtY2PCXxhasx/hkw
 uxB/+3P+ghy2CFiojjaCKpW8Bif9TcuC2OVwJKyklWvFFxteMAbVxY1m78cg7oXiFSdW
 jgiQ==
X-Gm-Message-State: AFuF++l82VXcckxkGNK9f5HLkE6N9xMTMHQmZt6mQ4qLxNB/OfpYIXyB
 xSv+t/mfMT5iKSVWdhPe03SSUFQqWQxhqkgLvzdJjLDaEyOOgy58j1VeblIuMjXA8NI=
X-Gm-Gg: AR+sD11fiCmtLWHwcvKk9NZE82HFfxuph465KCV8N53fz5Z/UjmDhIE6TVGOpKWwqw8
 fPPeYh1O4Y49nNtENZyWS52q9QY8+Tdyl+lIK6cjrN8KhuQYC9yLaOet2oot64IrodyGQY/5Klp
 EE6mcOgqA4eJvuJw3omjYx/SV/9+4F1z4ZqX7LvQx/B2xgkLa8eOBlrVh0j+439GE4WhH9Mv6vM
 J6R+vBfLJSf/XKJnRFSTmTMeVweJnWA+sC7nE61A6kTGxSAVqL0ae4rHr/6EqEYMx+MHCxnYzNl
 cbvEopcuxEU4ImYQF8vo2weipIWzIm9j4NB++3fyaNOMYfNxV+zizmiFVnFSwob8UGR/esdB1S6
 8o+J5PsZyfe/lZjHJHqHZfXPglvw/IZFg7gvZgZ7g30apwsb6mu2Rq7xKciyXeYPP3kDIEAqU7N
 vBFZPammTTzQQAuecwAIoUFAYFLKPa7voDIjVwXB4nvqK9Lz5pqUah0f7XnKQlclXtcBlvCUG5V
 JHtFoLF1XiBlVhpk4/IdlT5uO4yzbsJwxw=
X-Received: by 2002:a05:600c:6096:b0:49c:cfad:90c1 with SMTP id
 5b1f17b1804b1-49ccfad9180mr361631495e9.14.1788252092659; 
 Tue, 01 Sep 2026 01:41:32 -0700 (PDT)
Received: from Timur-Max (athedsl-4457084.home.otenet.gr. [79.129.242.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce08b8esm47139235e9.3.2026.09.01.01.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:41:32 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/8] drm/amdgpu/sdma: Clear SDMA rings after reset before
 starting them
Date: Tue,  1 Sep 2026 10:41:12 +0200
Message-ID: <20260901084115.262457-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901084115.262457-1-timur.kristof@gmail.com>
References: <20260901084115.262457-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The ring contains commands that were emitted before the reset.
These need to be cleared to make sure the HW doesn't execute
them, because they are garbage at this point.

Note that the ring reset helpers will re-emit the commands
that are necessary after the reset.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fbac732f3e01..66f278f77f71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -593,6 +593,18 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		goto exit;
 	}
 
+	amdgpu_ring_clear_ring(gfx_ring);
+	gfx_ring->wptr = 0;
+	atomic64_set((atomic64_t *)gfx_ring->wptr_cpu_addr, 0);
+	atomic64_set((atomic64_t *)gfx_ring->rptr_cpu_addr, 0);
+
+	if (adev->sdma.has_page_queue) {
+		amdgpu_ring_clear_ring(page_ring);
+		page_ring->wptr = 0;
+		atomic64_set((atomic64_t *)page_ring->wptr_cpu_addr, 0);
+		atomic64_set((atomic64_t *)page_ring->rptr_cpu_addr, 0);
+	}
+
 	if (sdma_instance->funcs->start_kernel_queue) {
 		sdma_instance->funcs->start_kernel_queue(gfx_ring);
 		if (adev->sdma.has_page_queue)
-- 
2.55.0

