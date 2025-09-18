Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549B0CAC5A7
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 12:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D807110E894;
	Thu, 18 Sep 2025 12:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="acapf04V";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE36E10E706
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 10:57:30 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-77b2e3169dcso1114748b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758193050; x=1758797850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o8fD1CQqjJUvOAUt7m+V26PDaC5fPrsIK+KI3nVmRl8=;
 b=acapf04Vj6rqQ62QDjbd1WXRkxbFCexbd9lLHD+ZU/XlXv0z2PzwdwGvgGealyZPR3
 En8THiZfb4oL9EYZTZcVC+62Tn2k8D7Q2ns5F26f34sbswL25yMe1YPiKe0WOw2f6aZh
 p0KR0dMc+/iGSZFL48vZtmJK/ajAjKy3TeHYJIuohKy4NR8MKcJzcNxO5swUkLeeEJck
 vNtfKe08zaKVKkNgOC/koCDT/AItgu1DZBOS76Jw9OtukD4JGldJyCOy+88ORXYlsq+Q
 V6EtXUg5k3t2e84j5rumVGtWqPHy3tHffCAolasqNYV3UUqEBDRp7xW/FRsF/Ww1AqmA
 4jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758193050; x=1758797850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o8fD1CQqjJUvOAUt7m+V26PDaC5fPrsIK+KI3nVmRl8=;
 b=Xkq4s+BlBwnk6x5za1RpL8y7KHnuGU/Pb362A4MD0zClbJ3/mH5kTUh804hW06Yp62
 e9ntPjFoK6Srd/5h2KBRMdQggdjD1F4E+sqQvuFo/YID/h2AnnHobYCL07QRb8rx07ri
 xyMNWIDXymKAkO5olqIq/bn/uYkKAL7nAQQh6ZaCktLRPR0Hazjcff2wtQ7lpQJMItlZ
 1cqj/pPAb24aLr51YqbhIfFoxJQloQ6yt88vza+b1CJE4gq/babP9ycNwTKOjgHB1b9z
 SqUu56XGFwWkmj36eicVclkftYPIVqGB6HsXbr+aSmC4uyj2LiptTYoVum6MuwUfeKZA
 hVzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkcfh/fVr6P5tANuXzxG6gKK7anZ3vd3AU1ah6MDGBEzxdv5cV3Z/tKCB9XdM16hyTMJrqyEYf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQzYbgxHQCv7gdPfBNoZv/2aiPAvGbMZdUxkng6OFPAH14Ffae
 IUwNbZsbUjO2FO0KZFwRbH5UptKGT5F1pkur/3f7vncVJaKd2inuh1IL
X-Gm-Gg: ASbGnctGzZ2E3qwc02YnFgHJA14u6A0k+nNzImv9wwZw1vgUnejPnteMUp0/CZ2Qlb5
 tJ3Q5u++gtrQvfRKm5jDfRjjrs+CO8LvgJ6ouKWHdfZKscVUX/zEzH7zj6QW5lXICxJ75WaKkwD
 AWU/eD0MaD9h/S13c/LVZ7rsZ1+xz0efsVnRv7cGj++ZNmIbZLaxUvW9KTffznp1uoPzMeYfuHL
 1drq9601vD+viWVF8oQeKlXIyM0fdNIVGxoFgXjVEGIijrvHNqYoENs69Hv5c5BMpRdtq0Sf6Q+
 CyFjzybkYLMd5JZEOIMuMEGA2GKPGzpm5Il5VmPvC+hTo0kfC8R/MZBiwNViYPfrwfA9VtUbiY7
 lnfy3bT0WaoDqygBxycUQFIpYLmBuXQLlGBRri+rGXdadlROreQ==
X-Google-Smtp-Source: AGHT+IHJVja8HNkuglOhZxfUAvb71rTHrEahoyXZo6qnEi+bdQYnLOPRyp4BgI/iBJSnqYyXbwrbzw==
X-Received: by 2002:a05:6a00:92a8:b0:776:4eba:de33 with SMTP id
 d2e1a72fcca58-77bf7cbf514mr7097558b3a.14.1758193050346; 
 Thu, 18 Sep 2025 03:57:30 -0700 (PDT)
Received: from lgs.. ([223.80.110.60]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc34078asm2071491b3a.35.2025.09.18.03.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 03:57:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu/atom: Check kcalloc() for WS buffer in
 amdgpu_atom_execute_table_locked()
Date: Thu, 18 Sep 2025 18:57:05 +0800
Message-ID: <20250918105705.3480495-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Sep 2025 12:44:21 +0000
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

kcalloc() may fail. When WS is non-zero and allocation fails, ectx.ws
remains NULL while ectx.ws_size is set, leading to a potential NULL
pointer dereference in atom_get_src_int() when accessing WS entries.

Return -ENOMEM on allocation failure to avoid the NULL dereference.

Fixes: 6396bb221514 ("treewide: kzalloc() -> kcalloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 82a02f831951..bed3083f317b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1247,9 +1247,9 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
 		if (!ectx.ws) {
-        	ret = -ENOMEM;
-        	goto free;
-        }
+			ret = -ENOMEM;
+			goto free;
+		}
 		ectx.ws_size = ws;
 	} else {
 		ectx.ws = NULL;
-- 
2.43.0

