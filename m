Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9436EC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 13:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D61110E547;
	Mon,  4 Aug 2025 13:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BBvbgIcM";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FBD10E54A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 13:41:58 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-459ddb41539so3280435e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754314917; x=1754919717; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=arWkCZdCW+9/tY+leQhr8q8j2YaoMyw3pc0fSlzh5V8=;
 b=BBvbgIcMEp8CJYdzqsQPevjkiM9hywhxLmaH4N/bKwzcTdQSG3CEMsvikllM6+B1ug
 LVKQhkkOCh82HNhdGsV5amuqvObKteWPjrv0hf9DRQ3tUtu25vfsgOkk6QKmlPBD8dV+
 CDq6zS4Wxr6Nfhs5Gqp81TMNHiY5nkuy6P301Y1DJOofxF4ZBTZuFL42MxPGOE2MH8lx
 FOXh38P9vK/Em53Moo/6NAg8Num7U1YAC9iKEG4kmSFoPMreg8z4sixH6S+fc9vTVWli
 2O8pijz5egO2CnZpRWa6a+2D7reR66WlFWBY7HZ++cVHUuSqzv5L36YenVNI5/zJlZlq
 UCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314917; x=1754919717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=arWkCZdCW+9/tY+leQhr8q8j2YaoMyw3pc0fSlzh5V8=;
 b=cvH4i5MonyVp3u3yql6g5Yiu3aEj4hgpNn3iYLu7GC6uC0nrZmJdHpJj0K7lQX8Fp9
 GEUD2SQ95fTedg09v8Tm3oKuUjhhRE8PXVoyB8NwJjFof2WFAVPSaNyAnNOVDg2bZLcH
 Rr5KP8x/jF0pxV8MpVPLDo0bXEYO0CCQuT8x3A6GtC4J6Z4UW1ckyDtd7YtLmBtbkTwQ
 mqK7zJM0a2tdwm8TzsATr+OIXc9dt17kLfU3gQuV6rCL9stYzAl3pwmiu0nNwtek2++P
 9Ft126aGNrne7fcEic611eO4Z5dVGPSIfvh8/EPmjtVT4EZOhQscS2RJETR0x1TRUjet
 Glxw==
X-Gm-Message-State: AOJu0YymsCLrI1cxk7IuZPe/tkAvl/IQLlajoqgfHiIIM0KRA4ipR9qP
 Q/bCXvH4+EM910jIqunJLsTurJvaCA2zmKG2Z1Yv27quevcsONn5flnvg6gCyg==
X-Gm-Gg: ASbGncsbJ1ChOQTaZMAPpOr6G+87r8Acijy/OagzfI/45OSWH95q1Xf3KoyLioFYPQ5
 dVSevtazEJd52eBaxxzzBYFp4U7UwXkNM5FDZmlYcp4V1f1r3MOJI8H+pQ47lbjqXZD641wuT/8
 gjhJgRJOG6UyPtXT1LwGTISFm8UX16UrjTz5krXLvRlqhs0ifMEk4ryNleKzh+AiZTjiqdAmp60
 dClHPTbVnnjLAVbA/sVwwnaXsQgOLlcbKyLt6GaDNe+MLKvS1565DwXKfZDkHz03BerVeoMtSp3
 M1mCBKG6zQINl3ljhUxs1dYmDpX5fPn/AziLDIvxfY6e/sYXD5zUhRFNQKjYw9x8ardH34vTF0i
 nS5PbiCMdQK6Z0YU6w1bK47Q643a2eNp7fu/diqYrjtfCa1KFEPdYOVP3/YzNKLDIhdlPHrKQPE
 GVYP+S+1dILms4sOXZUQ2P1rLncA==
X-Google-Smtp-Source: AGHT+IG+Tqif+ntE/zyEOzgOM0Et2KYAZihw1RHmI10Pa66S410iPemSfPxcsu/MeiNIcBtNNdlRpg==
X-Received: by 2002:a05:600c:4f10:b0:458:be44:357b with SMTP id
 5b1f17b1804b1-458be443856mr72117625e9.15.1754314916721; 
 Mon, 04 Aug 2025 06:41:56 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee621adsm172056395e9.30.2025.08.04.06.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:41:56 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/6] SI power management fixes
Date: Mon,  4 Aug 2025 15:41:48 +0200
Message-ID: <20250804134154.95875-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
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

This series fixes some power management issues on SI.
Where applicable, a radeon backport is also included.
I recommend backporting these commits to the stable kernel.

1. Ensure that DPM powers on the UVD for FW validation.
This is necessary because SI needs to use a specific power
state for UVD to work correctly, which we forgot to use
for FW validation.

2. Disable ULV mode even if unsupported (+ radeon backport).
Send the PPSMC_MSG_DisableULV message to the SMC even when ULV
mode is not supported, to ensure that ULV mode is actually
turned off. This fixes some instability on Tahiti.

3. Fix si_upload_smc_data (+ radeon backport).
The si_write_smc_soft_register return value is actually zero on
success, fix checking it. This fixes an SMC hang on Tahiti.

4. Fix issues with high pixel clock displays
As we don't have something like dce_calcs for old GPUs, sadly
we have to apply ad-hoc fixes. This fixes different flickering
issues that I observed on Oland, Tahiti and Pitcairn.

Timur Kristóf (6):
  drm/amdgpu: Power up UVD 3 for FW validation
  drm/amd/pm: Disable ULV even if unsupported
  drm/radeon: Disable ULV even if unsupported
  drm/amd/pm: Fix si_upload_smc_data
  drm/radeon: Fix si_upload_smc_data
  drm/amd/pm: Fix SI DPM issues with high pixel clock

 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c      |  9 ++-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 75 ++++++++++++++++++----
 drivers/gpu/drm/radeon/si_dpm.c            | 38 +++++++----
 3 files changed, 91 insertions(+), 31 deletions(-)

-- 
2.50.1

