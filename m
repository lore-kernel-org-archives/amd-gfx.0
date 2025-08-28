Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11DAC8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8321010EA17;
	Thu, 28 Aug 2025 15:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kBS9q3M1";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6B310EA17
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:21 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so6617455e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393880; x=1756998680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkAy+O06uP+l1LGw0YUe810GdMpRjvBJxSQG0McCjVY=;
 b=kBS9q3M1nTzpBQ331TAugQ/17/3fwHgPpfgCoRbLI/jJc06WxSy0yR0kH4+VMA9m8o
 2GE7m/ht+JL55ouLpZnohS8yQ2hDOMqbrKpDZ+v+CUJ6CfMGCNznRaQ2JW/5eGKnFyGs
 QLY3kpXJzNccZHGlPWQplDxmJssqCFDxi13wNSLL2e+mlhOSMzyjxkGwA6ay1DYtp5oe
 9KuoTmjfXEJNcSWTl8rgTXGFR9457dDJv45ix0k4l01QTWoh3afcUTANk70E9yNBJWRn
 KrS5A7OqJP9NYrxlzJfE5s7oYMt8jnuZc58ObKHxF1bvy6CFTGnOwfBCiQBLU0TKeg9l
 Ri+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393880; x=1756998680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkAy+O06uP+l1LGw0YUe810GdMpRjvBJxSQG0McCjVY=;
 b=sCJMjTMFA0PTl7iR/oROLcXEHIWGny3cTwrkthzIwnrDQzuRP8h1ie5MIAoGe2xq3z
 N2wfZqq7kWbpDFFuhyNpX6CpuvRda8eYj38pZdIEztlWaBWcPhZvOvzIdV5Q1N9ZVBLn
 c9f56Y2yEfmzxnySAocDnw7mSnFcr2bUP6YMXHo0kWAcOt7/tA/6CH+J3ZQ25P1kwZYe
 pwucrzOTc1waQvrUDtop68P6pjl6B1SjcjlQkQZZWnucAlf87YVQbsJCBJCRm8HqcfSp
 M2AqXuEujqHrGolG3cNkTi4QQZFTfpj1sf5u16lb6I6mROtHVxNupS58Z0ZtOiZEgf1N
 pPIw==
X-Gm-Message-State: AOJu0YzmGNhFAoQ/ZaUv/BCSUATlvEKT1+13CcTe00Kig3g17LmMKj1K
 lasuGho1AXtYujs1tgBQrgNDXKdnxFF8XNJVsMKjrvpc9Jk48GnQEPs8Ib1bdw==
X-Gm-Gg: ASbGncu+tK2h9huBTnzw7SfhcGJr1FrP7SLTBDENmi6rgSbUj1AXawsP7l5u28+iyKP
 jihKsYqLb2UHgYoSeqrZMgX4IAja3tUNeOHP+JEeoPZpbEydvNRY7rvOyk8rc5DTJgXuDQoLcvC
 NTJLyAiTGQFNAoA/PnwWFiayZkeMwtsHV6TkRkPnSofX4y3iLCyENwLe/xT0Qn4+fBQpIHuOi0M
 qkoYPaezKaR4napwPEfn0Jl5Z26atQEIXdClsrNe2nH7eIjJVozcfKTnyqWfLf3UfPWNEXKMFD0
 AkB5Pte9PJAdhifcKTz+K7ww4TMA1zrt01DbmJQvsnn5rKfZVoiZw1GjcydPhij3ZT+at5INQz2
 tGwbZCU4mdYQNqXVdDWCJY6pFanF08JP/Z6iiS3pReOHc1Fs1mYm7ZIz1LWLnzbL9+8MQiE9mR6
 eCBasTO7vy7Sq4Sbx13XXJ9K80JA==
X-Google-Smtp-Source: AGHT+IHbf71w2EXVhA/Go4YC0Nmm3AQB6AmNoW1QuopsFtFAZV5WdpEr8bVUr4Qh5QaQarKk/UGVyw==
X-Received: by 2002:a05:600c:1e8b:b0:45b:47e1:ef6f with SMTP id
 5b1f17b1804b1-45b517fabfbmr191265705e9.34.1756393879556; 
 Thu, 28 Aug 2025 08:11:19 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:18 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/10] drm/amd/pm: Adjust si_upload_smc_data register
 programming (v3)
Date: Thu, 28 Aug 2025 17:11:07 +0200
Message-ID: <20250828151112.15965-6-timur.kristof@gmail.com>
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

Based on some comments in dm_pp_display_configuration
above the crtc_index and line_time fields, these values
are programmed to the SMC to work around an SMC hang
when it switches MCLK.

According to Alex, the Windows driver programs them to:
mclk_change_block_cp_min = 200 / line_time
mclk_change_block_cp_max = 100 / line_time
Let's use the same for the sake of consistency.

Previously we used the watermark values, but it seemed buggy
as the code was mixing up low/high and A/B watermarks, and
was not saving a low watermark value on DCE 6, so
mclk_change_block_cp_max would be always zero previously.

Split this change off from the previous si_upload_smc_data
to make it easier to bisect, in case it causes any issues.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 6736c592dfdc..fb008c5980d6 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5833,8 +5833,8 @@ static int si_upload_smc_data(struct amdgpu_device *adev)
 		crtc_index = amdgpu_crtc->crtc_id;
 
 		if (amdgpu_crtc->line_time) {
-			mclk_change_block_cp_min = amdgpu_crtc->wm_high / amdgpu_crtc->line_time;
-			mclk_change_block_cp_max = amdgpu_crtc->wm_low / amdgpu_crtc->line_time;
+			mclk_change_block_cp_min = 200 / amdgpu_crtc->line_time;
+			mclk_change_block_cp_max = 100 / amdgpu_crtc->line_time;
 		}
 	}
 
-- 
2.51.0

