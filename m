Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30318C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 11:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D5D310E424;
	Tue, 29 Apr 2025 11:24:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fx8sqebI";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0325610E42C
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 11:24:31 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7c08f9d0ef3so365592385a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745925871; x=1746530671; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOvUgF8xgXWkEaPx8ZlpSzy1rwPlnQ3aoHrP0tQLpbM=;
 b=Fx8sqebInOBAqqNCtIHmz+ThHn1x17Oj/+z4gAIjoEtrdLY6ta26i9qSDpG5Nbh+xo
 HYL0P3lpTG3HDg3RcGLwgJlt5QskNN+LBVozk39Q6HXsYxtpXszL+X+WFLPdgA3Wib+1
 ChT4rFcws/yB4hAmTHU9aTTMGmen2/LfzceVq1ZLUrk5F8NM0JMIN4X36Ydrrvir2TV5
 IB389Vi1b29Sg8NJgHsQ10UZEt8HBPe1yZ11ALhIJ/IIN9JoiSAtrTTMcCKzn5kaBCjy
 30Vizx9pvNDylM6r8ShPfZdiyhjEYtaK1zeje8cwigUwhQL0lWm4n4w9g2HKZNuVOYx0
 J0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745925871; x=1746530671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sOvUgF8xgXWkEaPx8ZlpSzy1rwPlnQ3aoHrP0tQLpbM=;
 b=SmlTTpLmZtZiGnQxEaLzDj9/q7s4z4YdTRyqiGnJ5FJ2yjTBHD5lDIGTiqgh9wJjqi
 XMJOTWWJi5JHtup1Q66rSk0g6JqDijG/P7TMK/LvMKS2SCejIFNUqxL7N1wRbNmJus0p
 i7AbLtqtVs2WN/lw7VRGs1tJLTF/EzymkwMh0vDzYe1rY2XLNx9usd8/1k0pvxH2VZcX
 Fi1ZIgUOmLd3C6k7dTGZNhQr2o9nb+Cu/bJ1EbpJn1Kxvss01IKxbLPGgy16mpAycHbD
 vN1CebtvFUy0NBfubuDom6EFbDGdqswkhS9tyXlUdpes6u7WjTP72U0NS/jHdRfBSzrN
 KO4Q==
X-Gm-Message-State: AOJu0YyIQa7zzjzZnO4gLAcAc02BePvHdc7vK41jvbLYfFuSXNfzX/4a
 tYbIf1K4gp3qGbKEC3jr5uIFzSZxva2865uiANO1CiluTztRf5v0qBPiLQyg
X-Gm-Gg: ASbGncthWe6PCabTMIgc7SZW/f2S7PEJ9X386QEC+/ZgPp8a4bOsdFz1D/xqw2Gbddg
 VfhfKPhFaSGN8K5pzw1g+4DOCOzjRFyvfewBosCEKfJmypb9tYmq8LXyxVJEmtEOXKZQA06s1dl
 4FfXKR3YTnMnlgaidgsnQsIeNAQs0ThL//N6hwApHT6I7530thUWkBkFs/MQIg8k4kQ4chb5MfQ
 AIfUoqUR4pvSDXY7DqMqCTnECH417a87IWqqCBUt/7ucDYvzstwazCTw1HECAUQ/N73sOyZsCRi
 VmtymsDNIGW4Xtofb2Jj3FQCGn6Yi0hDoZJT5cfJuRQ9BPZwNuVxd+fs/ridKg==
X-Google-Smtp-Source: AGHT+IEY+ppJQIVdv5RdRpYkQbmQNj+9iWNaUX3YlY3TbQaG06sWp20VJzLeKKHeR59N4q8JPBgRrg==
X-Received: by 2002:a05:620a:171e:b0:7c5:42c8:ac89 with SMTP id
 af79cd13be357-7cabdd8dd7dmr433532285a.33.1745925870837; 
 Tue, 29 Apr 2025 04:24:30 -0700 (PDT)
Received: from johnnyzero.szero ([32.220.111.111])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958d86f1asm725583285a.69.2025.04.29.04.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 04:24:30 -0700 (PDT)
From: John Olender <john.olender@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: arunpravin.paneerselvam@amd.com
Subject: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
Date: Tue, 29 Apr 2025 07:24:28 -0400
Message-ID: <20250429112429.5646-2-john.olender@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429112429.5646-1-john.olender@gmail.com>
References: <20250429112429.5646-1-john.olender@gmail.com>
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

The drm_mm allocator tolerated being passed end > mm->size, but the
drm_buddy allocator does not.

Restore the pre-buddy-allocator behavior of allowing such placements.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
Signed-off-by: John Olender <john.olender@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 2d7f82e98df9..abdc52b0895a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	int r;
 
 	lpfn = (u64)place->lpfn << PAGE_SHIFT;
-	if (!lpfn)
+	if (!lpfn || lpfn > man->size)
 		lpfn = man->size;
 
 	fpfn = (u64)place->fpfn << PAGE_SHIFT;
-- 
2.47.2

