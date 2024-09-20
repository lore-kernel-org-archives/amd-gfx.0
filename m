Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D769BCF9C6F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 07:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8133F10E365;
	Mon, 23 Sep 2024 07:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DQ1mh+zW";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A9510E7F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 09:10:09 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-71971d20ad9so1277111b3a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726823408; x=1727428208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QsjeiXcVbkhRS0S6mAuTlJso2qznjwKlAjYCJol6uhQ=;
 b=DQ1mh+zWLKM7LtzQ3P5VDq8CxzHyz/1nAo7onmWTT2yflqogWHHdJoH7CfSoRq8Re/
 ZAFvEqyGJK4oQ3oZ6xXaYPqk+spGymtf0J3WniATd2IYbq5ksrlOzpGASddCWOouih9t
 gXciVCgew1AOSCmRbDuq+8SVkwSEQUNbrFKsq2NhDO7E/cIj8eJpsv2pr4mwaTl7zHpl
 zOa/WRg+JglkAdGwuAmNK7u89cFDl5nCts9caiplHCQG8fyOV6X/sY2iVRVklJe7S4G1
 5JtGfVIs1CnObfx7JJml4VmifSqtwB099kY/dUw8lVoaRvtPLxPR5t0aAusNbddvskrw
 I97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726823408; x=1727428208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsjeiXcVbkhRS0S6mAuTlJso2qznjwKlAjYCJol6uhQ=;
 b=Nf6Az5aNL99sKb4mwTh0qwfY0oULk4O6HKAXkdlYlUFfn2iko+uZJxTDyBYPE2ZVBa
 z7QqZ5y3RrAyXXOXvhwqJ1rrLYlWxxYhBtqQNFg8SI3J6XcbI8Adzy4Ogjl6wyIJbos8
 RMoL6CSxS7cLhcoh/uyZZg1wR2oa+26baGP8mFRDI1occRm3AoQyPEpRK0dxU48Zj4d3
 EesY/fOMm9r0ftiQHe7apw0C/ozDnvX4iCYJp6oxXzRDZ4lsK7div2F3RAlCHgt4mc4i
 W4f5u+OjOAGs59S5CND3Bvg8OvTvuuDNPaqOx2zyGct16JuMP5BOdCo7HP1FTW30u72c
 Ao9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdl7h9pqiSOK+Q5okU1iAEbS2k21AtKGS+u91XjLGZ8NRt/lUrC9fxZoSlmEW3iaxKmdHtvvAu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOBPujs7mAajhOQTyo/XRkkf1C/DMyWN2wcK8ogl4HZQdqoDjx
 CvTueTY+ZiVcTyGtWqoUkSj68ztaip7YbhYrnssdmrb7QSVWUoFBy3PwocWa
X-Google-Smtp-Source: AGHT+IH8FAN48dFcmR+m08J6jb/G83Ca1mUzCilqajUAhPNAMop9IubRUvCxd+x0whCenAuCu2S9Mw==
X-Received: by 2002:a05:6a21:2d8c:b0:1d0:56b1:1aec with SMTP id
 adf61e73a8af0-1d30a9b4f69mr4170408637.35.1726823408509; 
 Fri, 20 Sep 2024 02:10:08 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.246])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944b7b181sm9455864b3a.112.2024.09.20.02.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 02:10:08 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch
Cc: Dipendra Khadka <kdipendra88@gmail.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: drivers/gpu/drm/amd/amdgpu: Fix null pointer
 deference in amdkfd_fence_get_timeline_name
Date: Fri, 20 Sep 2024 09:09:57 +0000
Message-ID: <20240920090959.30755-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Sep 2024 07:25:17 +0000
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

'''
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:108:9: error: Null pointer dereference: fence [nullPointer]
 return fence->timeline_name;
        ^
'''

The method to_amdgpu_amdkfd_fence can return NULL incase of empty f
or f->ops != &amdkfd_fence_ops.Hence, check has been added .
If fence is null , then null is returned. 

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..2313babcc944 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -105,6 +105,9 @@ static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
 
+	if (!fence)
+		return NULL;
+
 	return fence->timeline_name;
 }
 
-- 
2.43.0

