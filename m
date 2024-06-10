Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D43C27C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 09:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F4E10E3BD;
	Mon, 10 Jun 2024 09:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xh+dSsmx";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE0810E3BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 09:26:16 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4210aa00c94so35701115e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718011575; x=1718616375; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ImFyoIBq2lQPxU/tPErVKieYaN4cMs9e4PFZdmH5VY=;
 b=Xh+dSsmxkzfcugrr4NntI3RfsoRlLlm0z1xAiw+vIwi9ONxe/CRJ/a2OwdDQpMEmuj
 m+98eXNl74STirCZGOjM4601K51iG0s3qoY/jXWYj76CU/IPlmdWPfSFAnwmS9K2U2ZB
 mLlC7QIUxwxTPq7BAsnwURXUgvuXalNrMNVCC+rJNVbVBCOhjmZ5E0fDF9maY8n5GWP1
 kTcU0pgd1UHsTlesj0MPnArfXEzDgGOprtgRpKFUbjACNysyAKKUv4WXAELZqUvApbjF
 TVgIAFH/XGzWmaW1PYSYZAsP2VXwphh10bGGGG8RfXF/f6SiDRZiqDqwa4/OGaWqlxDX
 ZQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011575; x=1718616375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ImFyoIBq2lQPxU/tPErVKieYaN4cMs9e4PFZdmH5VY=;
 b=PTY09VxBUKlnfvqIYq4c7rhxaAennhHXotyHPKf2kFgHWqF4wZd11fniKOuwJRUO8K
 gJk/Me0O3TX3c/ZGOgsu+jmI5HAU0VTSd7w9HloM8O1sRQ3V53syHIDNMSUnedpUArLD
 3TEHnxmee4WUo5RHRtaR5r8iBDspBR3ajNi2ivSvfgzf7Y1OzLzoKz8nJGUeGqGK5kV2
 Dd2BbjAkYsKKHq4Pl9/ll+2bNcF9d1JKJj8htL11rrZJojAe+6yNYUe8yYpjdFW7czfa
 jvStdOgNizTRLyyv6eRnnZtNia57HeoidaJiG/5SP4aF81WUIeKiOegGL/ULlG8gqqaN
 cNDA==
X-Gm-Message-State: AOJu0Yx5Uryia7/blPh7Q/ZMYfqTvrn9tl3Fwiq8ksmH1S086u3B3rbv
 SiyKBd4I73/Iuh/419xVrK/iKxgGTlP72En4kFka9plBz2j2sw70j/yNEpUWWgA=
X-Google-Smtp-Source: AGHT+IHiKhyc7qo27/bzzyB12nBLwpHz81YEUUE8pv+qz8oVd78SGSgh7caLbP2ix8ejZY2XWjHeuw==
X-Received: by 2002:a05:6000:1846:b0:354:f6bf:b272 with SMTP id
 ffacd0b85a97d-35efedf285amr7290177f8f.48.1718011574901; 
 Mon, 10 Jun 2024 02:26:14 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f9:7000:4916:a8ec:dd12:5894])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2169fc45sm3075827f8f.10.2024.06.10.02.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:26:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/9] drm/amdgpu: remove the CPU placement fallback
Date: Mon, 10 Jun 2024 11:26:06 +0200
Message-Id: <20240610092611.2894-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610092611.2894-1-christian.koenig@amd.com>
References: <20240610092611.2894-1-christian.koenig@amd.com>
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

This limitation originated in the days where TTM couldn't handle BOs without
any placement.

Today a BO without backing store is perfectly valid.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2ee783217017..2aefc183b291 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -191,14 +191,6 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
-	if (!c) {
-		places[c].fpfn = 0;
-		places[c].lpfn = 0;
-		places[c].mem_type = TTM_PL_SYSTEM;
-		places[c].flags = 0;
-		c++;
-	}
-
 	BUG_ON(c > AMDGPU_BO_MAX_PLACEMENTS);
 
 	placement->num_placement = c;
-- 
2.34.1

