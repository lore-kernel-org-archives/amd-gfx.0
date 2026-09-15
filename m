Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C603FC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 13:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8DA10E757;
	Tue, 15 Sep 2026 13:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hDQxxHON";
	dkim-atps=neutral
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C7A10FC18
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 12:14:26 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id
 2adb3069b0e04-5b8997bc6e6so676050e87.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789474464; x=1790079264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hT109/DKD8D3ImrzvgTZ3A2CRXv9GUhxcQttm3TUwyQ=;
 b=hDQxxHONauGGsgYgKg+NR58zgeQNy2X82s/K4l9I7AdUABc+gEHDyiez5IuATTEo+E
 DTTk3ObigaJQinQePrM28oUEttvPuyZm8GJPrZyb7ueV8FaootknCrHoxR+hjmWnCUUe
 M//iPTklXoWeEjTlYLSRFd6/rFjb+0ANrkeHBlrts5zP7iW5T7ufbSnwK83jK1zImyJW
 nIqQUHgeplUlxScpgSveG2mymOO0EWfYR3JLuzkjnpnFFUrqpmpk2SYZGYX6HNLZmIAo
 aLnpSGNpENNjykr1SvD7ttci0ZmL9i0CnCuQWJ0NOAQgM9WS3T3IyYxzaOldKG5h1t3v
 v41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789474464; x=1790079264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hT109/DKD8D3ImrzvgTZ3A2CRXv9GUhxcQttm3TUwyQ=;
 b=IfGgMSp0ike6S1e8WvyLapKdbs5AG7lzeRmd7GC+xTtdyZinZ8naDhvbQJd7KcI+ps
 uBb1gBLIHf3OJy7DTkY0IhIzHJJNzWxwjPk576Q7Z+IJxwLQae2KH3j1qaQ0O1pYsdbY
 WvAmjRC0gSDMPDEcDVkMmSwrp71Bvn/H0Uoa9wOzRwDBKpR3vcAN0GhSYzA9muVOcpDD
 /SAU/2MCQm1Az8hCLHaEH2ZWUbDEwpAS8JD/aaU3AWISTljEvtvEOh2x07zrk1fA/KXh
 PbQwGY+EVhKKNXb7AjhwUxeQXFE1Q0wCaYmEHe5k+FOJcuzWYGlapLbTdVKg7iL7+76r
 EF6g==
X-Forwarded-Encrypted: i=1;
 AKwUvByJnb19NA4j8+CoO4zfU38GsIIVgnH+PIp1rCZXHY3i8m1xnF4hMuPcjH7gXK2gMQOQB4IpssAd@lists.freedesktop.org
X-Gm-Message-State: AFuF++nFEXU4GZXyF7C051hikD0dPr3xZ92Ro+RhgL0pJdI3KBzXwPDh
 +WGILELmBZdk3hXN2lIHxG6KjyqA/JLZuH0xxoockw2Gjug3EDca4vzZ
X-Gm-Gg: AYBFou3KLtjqO7UxH8t9aq8jDMmzA2+U0lt2RIxhxW8wX/hdpVzHCmZEyYh8//kBGqv
 /HUyh+CSUjwgS+/SW5cWhMCL5dBpZ2hvycF0vjdH6SgECG3rlLzVXxVykXg9q7wj0dd1iS0PdNm
 eHvJUPFEYMAos9u0OSibI10OzgwqQEDzN1ASsM10N+EkTCzyI4Dl1rrx/EF1r3T0LlvGeP7iWL3
 x9CRbbafbacs2SzDWS37651Pr8kGnZhdB/2onJiRMk39kfXnKo5Mjhk5FWAD7LVNNXNTdjcUYMs
 nztqphc/juUm1Or0KggB84E9rN7Lfv/zR8d3pFNPPcnpLrZFM54XE2VqkOiJfzBPXKEUGFpZPZJ
 3xAM5N5unmPedNAewB9/im1OQ5wY1eoZ1rwc8uARkAOnMxcvsZqXI4BEzsYNHIze3vKsHojfM4B
 2GIHaCTDG93ObH030zN/2EPK6u3nEaZ/QOY6wvypD2tUFYgguKE2iwvBX7zNr+0PxtA4jfA4dmr
 Sgyj1A5/IG0QLmA
X-Received: by 2002:a05:6512:6ce:b0:5ae:b5d7:4b99 with SMTP id
 2adb3069b0e04-5b8b29d4641mr846404e87.0.1789474464385; 
 Tue, 15 Sep 2026 05:14:24 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8b3a58fdasm446114e87.12.2026.09.15.05.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:14:24 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Oded Gabbay <oded.gabbay@gmail.com>,
 Kent Russell <kent.russell@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH 5.10] drm/amdkfd: Check for null pointer after calling kmemdup
Date: Tue, 15 Sep 2026 15:14:03 +0300
Message-ID: <20260915121405.107068-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Sep 2026 13:14:42 +0000
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

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

commit abfaf0eee97925905e742aa3b0b72e04a918fa9e upstream.

As the possible failure of the allocation, kmemdup() may return NULL
pointer.
Therefore, it should be better to check the 'props2' in order to prevent
the dereference of NULL pointer.

Fixes: 3a87177eb141 ("drm/amdkfd: Add topology support for dGPUs")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2022-3108

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 86b4dadf772e..02e3c650ed1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -408,6 +408,9 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 			return -ENODEV;
 		/* same everything but the other direction */
 		props2 = kmemdup(props, sizeof(*props2), GFP_KERNEL);
+		if (!props2)
+			return -ENOMEM;
+
 		props2->node_from = id_to;
 		props2->node_to = id_from;
 		props2->kobj = NULL;
-- 
2.53.0

