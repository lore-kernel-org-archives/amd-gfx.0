Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D78F99C99
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2026 21:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73D310E0AB;
	Sat, 18 Apr 2026 21:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QFUdBtx7";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CEC610E0AB
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 21:49:39 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48374014a77so22412145e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776548978; x=1777153778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ieh3XomRKUR+y0Q/Kq5qf3/V6qfQpBVq1fb9U9HFowQ=;
 b=QFUdBtx7G3ZxRD0jeSLULkRTJ4jgHHqjZZnyC62vVf1S6dlP42Ms9JY/KTyq38E8v/
 8RsrGHlN6tzGu8xO+NwRIbBjH1/h+HQCCxCXmDqNChQ44fbBzJTsVpitl5jd6B7BenpO
 vIEXMDqiVldYd+cVBmOUci2jmuKKPkRtYb3mdENOgz7T3ibI6lI2DHgn0GYFossHC3rb
 RZ4uyGQLrlrVMxFfvlfoWD8j/+UDV10J0og7NSf3E3JtfPeosynHFDcqVuGcQRi9skYU
 jv9OdfgGvx54Dm/h4z7/Ck4PyhyGAGj2IQ4C/dvZutveGW9677t7Orip2DwHfr3JeEs7
 lbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776548978; x=1777153778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ieh3XomRKUR+y0Q/Kq5qf3/V6qfQpBVq1fb9U9HFowQ=;
 b=iwmFxHDAasoT85/kYQkAQiFkKDg1MFoSTVxngHaCm69nWycsmkSMUSW5na69jZyWU9
 qfrAQqQaIqfeZnLIIds2yuhHLrEEHGNPjev85qgS8d43K3Afu/HCqFho2CtnAAnXASgq
 c4IKnzni2Sxih1epmim26WBCrganC6dZ/l0XXnvdEDC/IrQ6XBu/O31oJkaBoGHup+xN
 s9vh6hgFOmkKz8quYHerWfYfOmOVh8Lz2q4osXhIYdGgybUkMxO3dVlovHJhpf1VNISI
 QCyHgjvvgC9KCrmQHnHoaQOq7r+loi1a7nIzv3Bu6j8zOtfAlofNkVG6zvrctO/Z+/8N
 laPA==
X-Gm-Message-State: AOJu0YxzE76F1/arh3mxPhDpJMPIGWOaCV36dCnr+FTnICxXQK4ugRZh
 1twC57tY5Qg0WE7RJ2KovyY+sr3Qtv9cPlOYuyvjRYcVFb77FeQN5Ps7XEDA9Q==
X-Gm-Gg: AeBDieuO3RB3oO/G4jXlJTrUdqcoaXH/soJTrY8CLcCn4pt7XWKvnXhDj7d3E2HhQlM
 wZ8rrRG6YQ+1V2jYbM5ZU9WyfGlpgm7SQzeA7+aotI0Og5LSRM4EskWsvmTXIuf91NSkUhWHTSs
 QZM6g9s0oIeBVqevn64oxsYUEV/2iuSMwLsAGO1BD/pVaVKAousD1a5MCgAcbnBxr9oysxxUGGV
 8GuMDd01TT2PuC733qHWqPW2/XxVd3zFU8Xt1KILPVkDhGBNq2rr/tIRdyFQ7l5Sxh+YqWyLBBm
 xYD7rUNqGVxcgHlSZ1f0n8/+HhFgjAC2RoBjjfLlNsBhSUzFcRUZyDOXZUBDSROW7SPlWMUvUHG
 LAPeFfaueQkdhecf/FDlM9/e+HvHX4hPtMn2yE/ZKpZnVv4FmMPXzdcMdBV6Uat7Fxy9WuYL1HE
 kroqUfnq/KJhZSD1fEgBbp/RZTM89qoObv4u8Mo/LrehCj45ayDXvhJRnfWDY3iLda/nc60vMC8
 CfyJA==
X-Received: by 2002:a05:600c:a108:b0:488:a82f:bbb4 with SMTP id
 5b1f17b1804b1-488fb78a0famr92162755e9.26.1776548978014; 
 Sat, 18 Apr 2026 14:49:38 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm171531905e9.2.2026.04.18.14.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 14:49:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/4] drm/amdgpu/gmc: Fix AMDGPU_GART_PLACEMENT_LOW to not
 overlap with VRAM
Date: Sat, 18 Apr 2026 23:49:30 +0200
Message-ID: <20260418214933.230912-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418214933.230912-1-timur.kristof@gmail.com>
References: <20260418214933.230912-1-timur.kristof@gmail.com>
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

When the GART placement is set to AMDGPU_GART_PLACEMENT_LOW:
Make sure that GART does not overlap with VRAM when
VRAM is configured to be in the low address space.

Solve this according to the following logic:
- When GART fits before VRAM, use zero address for GART
- Otherwise, put GART after the end of VRAM, aligned to 4 GiB

Previously, I had assumed this was not possible
so it was OK to not handle it, but now we got a report
from a user who has a board that is configured this way.

Fixes: 917f91d8d8e8 ("drm/amdgpu/gmc: add a way to force a particular placement for GART")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 290b9f9043036..f69a931e04fe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -314,7 +314,10 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 		mc->gart_start = max_mc_address - mc->gart_size + 1;
 		break;
 	case AMDGPU_GART_PLACEMENT_LOW:
-		mc->gart_start = 0;
+		if (size_bf >= mc->gart_size)
+			mc->gart_start = 0;
+		else
+			mc->gart_start = ALIGN(mc->fb_end, four_gb);
 		break;
 	case AMDGPU_GART_PLACEMENT_BEST_FIT:
 	default:
-- 
2.53.0

