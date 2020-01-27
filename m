Return-Path: <SRS0=W31V=3Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319CDC2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 19:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B6824679
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 19:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGlYHgDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B6824679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0AF6E02B;
	Mon, 27 Jan 2020 19:38:06 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356E26E02B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2020 19:38:06 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id v195so10814992qkb.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2020 11:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/D67QKhC/bj2m8senIx9XzlJFJMYFErGp+szQGqXglk=;
 b=XGlYHgDd4hw6PN4riiENB16d2SGUf/kzEvd/35vbG9M51uIbmYPYGAHfskQwOVYyW6
 MLahGXMW0FSNeNZUWbzeqyXONaMum5+M7dFf/UkaRfC5aeseHCuZIymDRs9JUIFMnqnR
 lnsvagPQskgh4hMO1sb3VKGTsYZjdgpmNzSvalo2oq2EFAjC5eLS+jZnz/Hl+xaj1N0v
 Vud10lEnkhWvLfFc4WRx3/Pane7pTHGlSLHRavIPaUdTPW7UI4AIyAtjdp1Bccb+sFyL
 IkhbgqTRyKl5z8RP0PMuDMBrJfFdE51zOwF/B8nVymsyDFVN2mwGYD1M1YQHteAaKgNZ
 rk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/D67QKhC/bj2m8senIx9XzlJFJMYFErGp+szQGqXglk=;
 b=fh9SdwUw0fvMvggGtmzjFZ9p25+1YWuxPB6VQyk7K1YL5KRfzINqGv7IpFuW3460f7
 KgFdGFJ3AO9I2uXHykYVc9UmhptPcH5IUKwAjMz8JYLL6cc2Qa0j0XgfyjooX+RM2EeO
 Q2FjT23/FLTKjUB2q+zpfYnBpi2jbDzWqYCJCmlQ+vouTGU7ZIQdbp1cMTdGzG1r86eN
 EgkmFTj3NRXB6yPhFd3QP+YaVY0NxTV9VinstO3NU1UOFNYQkXlDf3z8XKgdzNZCCliL
 NaCRnKTEywoKPiROS6jP4fTHDA5fp4ogZO6t0Ul5f6IAoa2ZBj66bPc4uxrn63D+4jWV
 IMKw==
X-Gm-Message-State: APjAAAVIdlPgz5qMBjKOPuySI7FXWc7Ku1XAfbwbVVZ0V39aQXyxt6zG
 +cmhJy7lOoeEMQDVAE8iUtCjVxPB
X-Google-Smtp-Source: APXvYqynfFEk02TwzWlF/lG9CdoowKLbBZtHm/29ix6VC7zMTifnHT0KgtUe8DhPlF/aMJmh/Rmu7Q==
X-Received: by 2002:a37:5d1:: with SMTP id 200mr18141230qkf.492.1580153885112; 
 Mon, 27 Jan 2020 11:38:05 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id k17sm10178749qkj.71.2020.01.27.11.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 11:38:04 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: enable GPU reset by default on Navi
Date: Mon, 27 Jan 2020 14:37:56 -0500
Message-Id: <20200127193757.28379-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Has been working fine for a while.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1da03658891c..69248d1b2417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3762,6 +3762,9 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_VEGA12:
 		case CHIP_RAVEN:
 		case CHIP_ARCTURUS:
+		case CHIP_NAVI10:
+		case CHIP_NAVI14:
+		case CHIP_NAVI12:
 			break;
 		default:
 			goto disabled;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
