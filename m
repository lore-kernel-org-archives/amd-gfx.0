Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E519CA0FF7
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA9910EA1F;
	Thu, 28 Aug 2025 15:11:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dolC7QO/";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33D010EA17
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:22 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45b5d49ae47so6068745e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393881; x=1756998681; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDSMijh/NAFBh0hDVazhF7DL4bKbJcgYA2X+s2rm1oM=;
 b=dolC7QO/OeUMs1OP/ayNyNSG1EUKdL3NImjD6CifSoAXjGo9bYAxDCZp6LRCFH//RK
 pSa38zrLO76H25Ej3Npku3sCJvzw+UBZfGlvh5F4Kwhp2eHdawIlJnKT5/om+F37wxqw
 jFZ/uQVeUfcU05JpH2seYzvRcxcpUTPpdYF9lqDt6LQVCOG2pVjzFbOwL/NQaXroLUk2
 L9wGB8tZU3DRnVda6MstwaMADAClfLRCyVmnUmGGTX3IpHlyuGB/QzH/uoXH0kaqytWf
 sbHV86AL4r2gtRMDincrWRpkWMdpNwprBEZet1MA2u0ZtRVct7hzZE+B3uYn5Fqjb0e+
 9r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393881; x=1756998681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDSMijh/NAFBh0hDVazhF7DL4bKbJcgYA2X+s2rm1oM=;
 b=TrLIFPeHHjpKN93ytvPkb7Pj1teLe9iH7mRtHmYCpqtvfNhWr6OT8Flw1cmQspHg28
 4LOwmjsHlKDwRqTbmTBjUDBdMUsCf9T7mEG/oVY/rwo6qlzPS0x3aWABG9qzj7iIoX9r
 gUtH6+NFsR6GQ2I/4GhB+jG2pzcXgOUPibR1k9bQyQRbT0fIGqD68j5YSmmbmZ6lE/GF
 yRMiYsQDn9uDdRJTmNNPGMkyPuFNhUdwwiwBqinE8SDm/DnDMSoDFjtt2cohoSsJyBbx
 gXWL+rSVE87GFP2CK3HGtvUZV2CqNAPgk+KeG0lf3GquVR5kGZchaLTRfUYXUaiKCv+x
 cWOw==
X-Gm-Message-State: AOJu0YwUDwdXsRSGVa/kykCjPZltOrrEqFpTLsr2Bs0LXHi5ncSr3aqf
 QgjcLv4MwavsO4dTKK29xwBNT6jR7XcRyNDTkaxkV9h69O3fsJxL4Dp8CshuoA==
X-Gm-Gg: ASbGncvorJgFbF1bhx2ybty3bmhtmSHbze9In9CSkJq+OG9GIMu1NwJV3TfXJY44Y6K
 Alm4Tu6bumZGMGqLIHag89B1W1bZG0TqVpllBKmXYkVrigXLJSDjBwA5XjHFU7WFw4xnXVzg86R
 zmroAFRR2c94i+f5mCGRT/mEJ2bXUm16cLWMu2R3v8PD5gPnSQ135AnP95Jjos0YlR+2wJDpz2A
 q/ACMC7pehV9POqdRb5hX/hsxge6w2TZtwQZ3VXqImWG73kJfLdbAJwg9jhPw9BqV2XGyM2LsB6
 lAuy+y7Z+hTUbYPUDC02XecrF0yeI3pBDyqjA7pr5VublMtcgJGV4cRApSnZ15giLPVYeniBdhx
 WWFEJFmi4vPtymtpvaZYEN2x9wBnBz6Ygw1xHRVxPe9iBSmZ//Om8gdUk4QJm4cNPux4BvSC6pX
 QEuVH5t7dmnTkushnTQq7+Q9RgMr5b6feir/sBb17BAtUfQlc=
X-Google-Smtp-Source: AGHT+IEgbXJ0ajtMvOiOh7ZgheuM6GaxupfVsUjvVDCSIum/O7JzXB9kpm67oEd+sa7ESFemDhkHXQ==
X-Received: by 2002:a05:600c:3b1e:b0:45b:7a21:9e96 with SMTP id
 5b1f17b1804b1-45b7a21a19fmr28886945e9.37.1756393881313; 
 Thu, 28 Aug 2025 08:11:21 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:20 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/10] drm/amd/pm: Disable MCLK switching with non-DC at 120
 Hz+ (v2)
Date: Thu, 28 Aug 2025 17:11:09 +0200
Message-ID: <20250828151112.15965-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828151112.15965-1-timur.kristof@gmail.com>
References: <20250828151112.15965-1-timur.kristof@gmail.com>
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

According to pp_pm_compute_clocks the non-DC display code
has "issues with mclk switching with refresh rates over 120 hz".
The workaround is to disable MCLK switching in this case.

Do the same for legacy DPM.

Fixes: 6ddbd37f1074 ("drm/amd/pm: optimize the amdgpu_pm_compute_clocks() implementations")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
index 42efe838fa85..2d2d2d5e6763 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
@@ -66,6 +66,13 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
 					(amdgpu_crtc->v_border * 2));
 
 				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
+
+				/* we have issues with mclk switching with
+				 * refresh rates over 120 hz on the non-DC code.
+				 */
+				if (drm_mode_vrefresh(&amdgpu_crtc->hw_mode) > 120)
+					vblank_time_us = 0;
+
 				break;
 			}
 		}
-- 
2.51.0

