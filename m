Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350E3C88E7D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 21:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C27C10E7B9;
	Tue, 15 Sep 2026 21:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W2t5bnOX";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB1C10E583
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 16:37:50 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633ecdeso459888f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789490269; x=1790095069; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uyYww1vw22YFRnFO2kz8YhlMFLNE8VmPnf3mijbwEdw=;
 b=W2t5bnOX8n8Xsi6Y3RNKEZj5Dh3C2NLtL+iza8LQzAIxdyeQDX6/Wyox36RydKzY8k
 oyKHTCCef9FgXFYqA6tavR0WhGo5OIC6VXsIAlAXLffS2cS8H7TujGO1JyoIrDtwF2Rk
 W4gKNKA5ZZYaqUV0twfOdtSIVnRcfJvX0DJwWgk9pB0upCASwa9aw/9/Mh99L9tlW0H8
 pfWby6TgGPAbvN8cfslIb+FKOwtk9nm82eH1wqZaxjQ1cclULmKawFQrvVMzna8izu8x
 6X53iRU9Nn0k1r0VBzkoCs5ehgzF8NccW+K31V6dU9q1/p6CfXTWJobpJ3VF/wCy3JJK
 5YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789490269; x=1790095069;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uyYww1vw22YFRnFO2kz8YhlMFLNE8VmPnf3mijbwEdw=;
 b=Tw/3uKLlBbkrntL6drlDQuN3b/SoSdQU1vN6HT65HrN1Djng/8a7uHkizMk3PcDBKE
 24IUOZ8ZG36dXUIBIxRzk1yOfr3Bfjszj13pbJNDOJilxAx0DWYv0opv6/qTfXU0qrUk
 OJK5FUMTwYQBlLQwVyEgW8xIN+mE7WXP9UBlVN6C5PHXo0q3Ex1Jtbz7SgkRe98DoqB+
 7490k99OXwyESxrZWruXXCD/uBADF9jqkZ7+FPbMYnp7F7VS0YqzgrnEiTGxba+AVlvU
 UaI1R3d1Sw0/ic/0P5YRGJx/gktJiARYB1AosP79wqbZHgmMXH2lNF9fwC4U/KS4fJtB
 LbGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIjNFq3K+eMxgmJsKACL5CDDcEejS2509HwqewM6GU59isVH1MLvGXCFzv9dykq4EBolVcPzmk@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLUrPLeNooPwQOgDOhSHUlktZw9cBXgzeOjk/Hpl9xntLKnPBr
 iUlz6RWGcqWfFL3WOSBdGIrykwqUZr4C9N3RSR6JySYBGt3Y3+eV8I0o
X-Gm-Gg: AYBFou3z2i5p7FVpNgKDO1I+TuXkY8Q7HQ/hQ0pqdNAoke+nc9IBY3eU438BoN4PF+8
 OPSdCqJnwAlQw/bmB8BoVBYFm7u+9ClT6RlgjFr2q5F0dwM8C1fcov5l1TOMXo9pL03MBpZ8oSl
 vy5AHfLVX9pTsElsT4Rd4ZbHQX0n2/dRA688vkr980xHBXlf8XcUwwysuuU7t7xbnG3d5gn05yR
 K78uW/igpfpIRzEfbUdxBL7ipmsKlfnYDT9f7vZMKjgqYi8DoVW6IRVOMeFRMWQslA7NS+2XpHE
 DN/K4g5jcvouZYRLJJEBiNFPRyPogQ+382G/BGyMUEDoJpZNlPuZlJq8eUWGheUYLZW5sE4ho0/
 6AvSHrx2elc3ktTtEF82lv0OIJiK4WxDPVdReItlJnk3mVzF5HvOVrPFlsl7kXRPG9B3uFdBFIM
 uOwPG/nDTwyVR1N8721GwPytuMuPzbx2jJwIG9AYUDyhxR2JYRqNkAl0DmimApqeSQq+IwvEgI+
 h3m3w==
X-Received: by 2002:a05:6000:310f:b0:486:e9b7:cb9 with SMTP id
 ffacd0b85a97d-4870a9dd928mr2076898f8f.45.1789490268678; 
 Tue, 15 Sep 2026 09:37:48 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fa70sm256434f8f.9.2026.09.15.09.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:37:47 -0700 (PDT)
Date: Tue, 15 Sep 2026 19:37:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: Yang Wang <kevinyang.wang@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Kevin Wang <kevin.wang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/pm: delete a stray tab
Message-ID: <aql0WF8CnlzgS4nz@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Tue, 15 Sep 2026 21:01:04 +0000
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

This tab was accidentally added in commit 6c9e0328d1de ("drm/amd/pm:
refactor PPT limits by controller and power source").  Delete it.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a29e76b03476..6beafabf1306 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3077,7 +3077,7 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
 				return ret;
 			}
 		}
-			return smu_v13_0_set_ppt_limit(smu, limit_type, limit);
+		return smu_v13_0_set_ppt_limit(smu, limit_type, limit);
 	} else if (smu->od_enabled) {
 		ret = smu_v13_0_set_ppt_limit(smu, limit_type, msg_limit);
 		if (ret)
-- 
2.53.0

