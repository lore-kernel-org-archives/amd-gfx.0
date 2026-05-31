Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE245CD6E52
	for <amd-gfx@archiver.kernel.org>; Sun, 31 May 2026 10:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C52710E614;
	Sun, 31 May 2026 10:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ut+qkkoh";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 003A510E613
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 10:57:53 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so19412215e9.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780225072; x=1780829872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+TRaw6ItBpD+BUFHZNImOCK0LtUdz7xluoPSNGcrf0=;
 b=Ut+qkkohbElhlJwFmDQkUvi4Qi67MoMidSXG6ES1nxfqnfwu9DSbpwtk7CObPjpXMH
 1nAtQbY3z8+S9E75Ki6rbNGs6N/zn0sU4fpGKb3dkfnc6nO/ptgTYr1hmTdAemt5d8aY
 glv0at8UvqQAbg8xvWxNTBVt1pSOROd6+w28UA5VHHSiPge6xdDWYDBApAPO6ExDQL+i
 lJEmcxKgdN6QRgWwwyjXaFFunr8xTzhRhONWxgWTfCs/qKhV5wviCWGW1z657IRHXvET
 AUyody0VZCbztvRDgPfCdfl17A5A9abhuNfH0ummmbydcfQW8eou55dU9q4p16TxWvyg
 sjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780225072; x=1780829872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j+TRaw6ItBpD+BUFHZNImOCK0LtUdz7xluoPSNGcrf0=;
 b=Bfo5PFhYwIvWfsTZ2gA+WM0X0bu0umQl6TLhZhfsmHXpz3/oKs/n/dhjEtNRRryJev
 NAYlQdCAIt61XHuZE1UzSQxzLJsflekKIU23l5HDmwCwQlWmmApYEpCqX3hAqrxAgSTU
 jd/UU9xtTP3fSBPPlDr08jP2Ytp6ZkgqTq1U/y5iNjK5rNlWAJplfuL96PtBCPS612z7
 LKf99AF4ic8sZeosn/1fL/F38alINs5SRh3A7q0YrNHaLAfxTzAjz1t2SqrJ4UaPhS2v
 rsM9OMYDjBUmMpeGHi4A72x83512my7rhet+u4KWOUrk4nOxIa/h/InG3iWaUj1T8Xwd
 Huww==
X-Gm-Message-State: AOJu0Yzc+N2vtGqm/voS0EeXEn2dzFjOTg3q62yIgVCeXomFMWMPXMas
 XjeD6O7dyDb+q6U6DfMtBtxJQykpTxwT7C9dfDltuhqFBODBR+SrVv9y+j7r4bDK
X-Gm-Gg: Acq92OGcUnwa87LW2V0Nkw7KsnXjpI63pAmvdljisciLvL1tku8jbwVgy7Q/7d0Kl6n
 UO0qVYpWOfxlXuAVN/Pov6WPkmSFi7IC2bDtgPTI0KTNC0qog62a1gxSMmKlHNymK51HIuLao3s
 OCZzjg9UkkKMKaYJJJ6ipdThqOUSNnqeJGAJzeIvr1LEo13f73hOly3hTMu1p3UHUFqQb6WSK1r
 bChxBBg0nlUaycjfX+ykP2BUICPvVZJ1ZqGxa9sVgEMCTwgFGnGQ5Lw0GF8Rh9LbdfSWbJJGEJ1
 rmBwu2SEy5C8GERujc9FQL8Fgre1RGUMLwV8CwOydybb8o7ffYBv/e8UqVvvDotg3HoXByzRsY5
 l/DnqJGeSi2azSm5pifRsT+QBC5K3my4ug5wF+gyhJY+C/lgx4kX7c6sbFhWQwfoUjQEMl4Vo+y
 O1UiMtLuPrMErrSUigohgKxPLRVLFfWHDo9eVQ60OoOr39ui//OdLF4AoDqGLuo5QA2wR8Bg6Ui
 q62N5cjSnsCUDMY
X-Received: by 2002:a05:600c:a214:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-490a2948f0cmr77083645e9.25.1780225072435; 
 Sun, 31 May 2026 03:57:52 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68980csm192904065e9.1.2026.05.31.03.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 03:57:52 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/5] drm/amd/display: Retry link detection on resume and boot
Date: Sun, 31 May 2026 12:57:44 +0200
Message-ID: <20260531105744.28717-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531105744.28717-1-timur.kristof@gmail.com>
References: <20260531105744.28717-1-timur.kristof@gmail.com>
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

Link detection may fail after suspend/resume when the display
is "slow to wake up", and it may happen on boot as well.

Let's retry link detection in those cases too.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8bda79c26288..1ddf77b08626 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3954,6 +3954,10 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 			if (ret) {
 				/* w/a delay for certain panels */
 				apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
+			} else {
+				dm_queue_delayed_hpd_work(aconnector,
+							  DETECT_REASON_RESUMEFROMS3S4,
+							  AMDGPU_DM_HPD_RETRY_DELAY_MSEC);
 			}
 		}
 
@@ -5979,6 +5983,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 						 link->dpcd_caps.psr_info.psr_dpcd_caps.raw,
 						 link->dpcd_caps.psr_info.psr2_su_y_granularity_cap);
 				}
+			} else {
+				dm_queue_delayed_hpd_work(aconnector,
+							  DETECT_REASON_BOOT,
+							  AMDGPU_DM_HPD_RETRY_DELAY_MSEC);
 			}
 		}
 		amdgpu_set_panel_orientation(&aconnector->base);
-- 
2.54.0

