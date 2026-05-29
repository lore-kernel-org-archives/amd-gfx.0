Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7E5CD6E4F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 10:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF8410FCB7;
	Fri, 29 May 2026 10:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="apEfIwnc";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6010B10FCB4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 10:31:08 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso119529185e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 03:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780050667; x=1780655467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvklLwVGbPYyhd1VrtCs+OxzWAHr8XDZ6TifKFs0OyU=;
 b=apEfIwnc7TyLl3XizKhKHg6KZec26mIewmcVZKEcAuEP909zUnkmgcTtXXmqNzIjDW
 4zuHRjFG1fGJfDBbPpK23xYIoevk8Ixogk6aE8cN+oMds5+VuqVj58aro49sLFdeLzg+
 JEd8iYtkZPMKRwn8z2wG7vXstecwPTE6r5LeATProNTE+6eAfPryW1XmOFBZgwRm2j6s
 WIUYMnWH5GqtnyU6YlO7j2xHXYoASeuBNoFDRJVy55HLOafSK7eLDY7f80JFozmSeCzS
 gqlUB22+fg3eCt04sxO1d6LbTPDJBKDQz2KHYnUldEO2N8qydIFz2a6cYioDZhLFTeeZ
 9V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780050667; x=1780655467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WvklLwVGbPYyhd1VrtCs+OxzWAHr8XDZ6TifKFs0OyU=;
 b=cuL1XD0maiILb2kTwDp/Y5LikYpK0vATVjZBv+GINS/HL4dZEhWc2XyZddT8hBN7lE
 pF1lyZfAK/TzFpO6wnxMJiOVBRUVZkYCLQk3JJO8MJ5H1ZGYi60QLGQ3y8iwHMDRKz7E
 obsCV9+ctJK7d9Rum6OUUSeRhT7eUQ+3YJfdyzPclJ0XB7VS8YvFjEowEUq5Y6hl6tv7
 /JAFzlRyQRS+wzqIxruQBHeZGtK1WfYA6pc8z4tkEOOStYJzCdX4Q8cNjmAJR00HRglu
 AViSQ2NxYBg37aUBH0iEayOLFPPNDuuJtWjO0Psu4LVVAsLZEUKt9XD9gs4Sj12faPJV
 bBqw==
X-Gm-Message-State: AOJu0Yw/PfrB30oIKA6lC5BhpdqJ9J7kcB/OT/Yert0ZizJ5cUIz55m9
 YYei0fLKoBFnAC5GjM/Vvm0f9r2rs5D4e+lxb6EVY+d4gaTsacP+IuXKcJuIFf5D06o=
X-Gm-Gg: Acq92OHwMUqEjsW9Wjxpy49ZH1pwUGrMFd0/Qj71rq3oyz3ItI94OVFV2oHRzImDmP0
 GqsbSwzrYnTkjYNnWfJmgIqH/OOIRo2vpW8OjoBfTWvtzYmcCH0basFpD6MvxRXYCI/3DtKPG+K
 dFn9xsp57SSKdM7J3bjOwjOLDM0/ByCCCPSWfTP91Oe8vH7VJZaiCvW0WH5AX2LldL4C0NirLSN
 pmK3ATRFxc7Ic6eE4VzDAZOT73ZayR87Cj0nkNBFge68nZGKU4p3DovER79j9wXAsN+IEWHGLfU
 rbMu9jUeY50+mWth0CKmaYH5jXz6ppABi1xbO6OEFjI8lZqZxXR6g7s8T9jtiV1m+VbpO1KqbYS
 g4rYz9Mn6Zaaa39Mh2Wj6/BF3tEv8z29SqKtln0unofPbQ2yLuk2v6d4/kGty7nZ02Nu501KnJt
 XHnKqTCAnJE22/9EvbX4Zn2niZY099VX/+PW463LYexDunuCleusviVcC/itwAGGUCj6HFAjuRr
 1lwjZbtI1I7apsf
X-Received: by 2002:a05:600c:630f:b0:490:3c94:a3c6 with SMTP id
 5b1f17b1804b1-4909c0b6cc2mr44072035e9.26.1780050666785; 
 Fri, 29 May 2026 03:31:06 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0a89sm40895945e9.7.2026.05.29.03.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:31:06 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/7] drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH ring
 instead of PAGE_SIZE
Date: Fri, 29 May 2026 12:30:56 +0200
Message-ID: <20260529103059.21470-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529103059.21470-1-timur.kristof@gmail.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
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

When there are a lot of retry faults happening, the soft IH ring
can fill up really quickly and possibly overflow. PAGE_SIZE was
too small, use IH_SW_RING_SIZE to match what other GPU generations
are doing.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 4e6d14facf93a..ec0919fa82540 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -587,7 +587,6 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 	bool use_bus_addr;
-	unsigned int sw_ring_size;
 
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
 			      &adev->irq.self_irq);
@@ -619,9 +618,7 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* initialize ih control register offset */
 	ih_v7_0_init_register_offset(adev);
 
-	sw_ring_size = (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) ?
-			IH_SW_RING_SIZE : PAGE_SIZE;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, sw_ring_size, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
-- 
2.53.0

