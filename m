Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D8EC3601E
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Apr 2025 20:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99DD910E1C1;
	Sun, 13 Apr 2025 20:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mE35+08f";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A495F10E1C1
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 20:51:38 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4768f90bf36so33792931cf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744577496; x=1745182296; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kqXGdFidIS16vCS7h61a+9w5I/tDrbo2rKVa92XkibM=;
 b=mE35+08fAMyLAee1Hha6M5OdcrU04KKmBTNAUUyZGSUPRNlrZdkCe2TZ/HjHzOR4mX
 +tgKZVmixPOFaJQzoQ0qrYw3UXvXR7QwZfRh+n3kSJTJVSMijAH4XofMp6s5bYHEQG1T
 79T4QsbAZDYUcSQfklLGaCJ+n4FUzyZ7CFXAy5b3rDq8XLrZrXvvn5YrTEy414B98qKm
 d293aqkkIvdov2/F7izkkITRV9sa9ccdocOMx8abWjHHwENlG7w7BzpT3giWbMUp0WMw
 ypXUbLSoz+58nWBe6KX7G4lr9e9neqMKTFBOxpZz4QqviS8Q5JRXKcCJor0lz0p9iPs7
 OIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744577496; x=1745182296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kqXGdFidIS16vCS7h61a+9w5I/tDrbo2rKVa92XkibM=;
 b=CVxB3/wjBsXR1xrK7yMIQpvl0OLYh622vSk9jIVtxIcCcwwk10BWaKF4Yk4+0Dv36b
 +MZmaJ7oNK5cr9skgYqkobJ6H7pzYifkgaITXCLTkXLD/K/8dpY2UqPmc8dUuqJGBjUW
 o9txzJ/oDhuPKLQDsK4mpkoQAX5E5tafXPgSh0dAhbmDci4Or5NwhSnNN7wT62bZl1g0
 m8QPHoNFVXZeHwZDfwtiq/ZHaPR/sxSNH45S5mSck4u8nBbcFJVP0iDh7y13kLG8tWHZ
 +yRhoNqStnzDkAGiOxL5JOtG6T5cZLY/yLHoS1H6j1NxvUWhfbLSREudiFFHFmLtNWfM
 68wQ==
X-Gm-Message-State: AOJu0YxclUNDzL6XsRHBYaz5xxlot14pKTIdeMcrHUN5Z2EjmbzPB8ls
 x7WFvqANVTb/VvB6goWZSdEYASNRwfsU7EDnbFU6pxsk8YIQD3H7SoK51A==
X-Gm-Gg: ASbGncuTpbahp8MCIMTI37pZf8aNq9oultDghSP0L+K+OoGpdkmmY70B0pEKAiRaUtY
 m8e3n7NYF/Bf/dTSaO864nTvat3OsbW7tdsgcdkOisTOkTcmeWecPajAVQId6/q/nhQU+8nGLEd
 JVo0D84yAYb0hkqxvuiZrzsednza+QMom+8Gl1tOUJTo7fw19cYa+SyKrcDwXoQxGVvWqTfipFh
 /al18+dvV+VnYAak0ViOVeaEuFiZj3ZVjOOWWcCNGiZj5yKUSVWj08tkmgFSBlHx3agr1aj18ON
 MVoJfkjOesLfRvLAtZN6/G3YmGi/25I1LOF190wjvCqohOIe18wlh7zDCaH4XEV9
X-Google-Smtp-Source: AGHT+IHTaILJbAvcwQL7x9VvwDezyUu10MScJ7h6Drpoi42Nzft2M82gJ/E79LbDtF8wrn2kKKufUQ==
X-Received: by 2002:a05:622a:409:b0:476:b33f:6694 with SMTP id
 d75a77b69052e-47977554909mr154906321cf.28.1744577496413; 
 Sun, 13 Apr 2025 13:51:36 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.42])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4796edc1d9csm60300261cf.72.2025.04.13.13.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 13:51:35 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com
Subject: [PATCH] drm/amdgpu: add missing DCE6 to dce_version_to_string()
Date: Sun, 13 Apr 2025 16:51:21 -0400
Message-ID: <20250413205121.5702-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
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

Missing DCE 6.0 6.1 and 6.4 are identified as UNKNOWN. Fix this.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index b402be59b2c8..3d483b5193e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -689,6 +689,12 @@ void reg_sequence_wait_done(const struct dc_context *ctx)
 char *dce_version_to_string(const int version)
 {
 	switch (version) {
+	case DCE_VERSION_6_0:
+		return "DCE 6.0";
+	case DCE_VERSION_6_1:
+		return "DCE 6.1";
+	case DCE_VERSION_6_4:
+		return "DCE 6.4";
 	case DCE_VERSION_8_0:
 		return "DCE 8.0";
 	case DCE_VERSION_8_1:
-- 
2.49.0

