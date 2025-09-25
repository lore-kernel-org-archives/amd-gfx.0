Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70829CAC5BA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 18:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097EF10E2CF;
	Thu, 25 Sep 2025 18:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kpDc++Ka";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB7210E2CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 18:45:45 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-77716518125so724109b3a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758825945; x=1759430745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQhKzetF5oIRZwx+RXpKazp3H6wc14PpG1+yxlFyfZA=;
 b=kpDc++Kar8Mg2Jxw0eOL8rMYStMlgHwaxs4jzXm4xX3/s28KH3qA3Z4NvLpwk3JlsZ
 h+kQgpffywgnhRFSf/ZcT6F9260d64VMGrA+gDn+0exONttVW/iK4tZyU/eUveWUZeKP
 BWGBic3toBHCiduN2flb6rJAy8erTGul7FAkHe0ktZ2OyQ34C9NxkKyzrOFk3wJ3hkcI
 FaRUolEENDnN46XeG/HYVCEyQBdxXSIuS1YVvdHkoTE3g0Bwbp3+tz1hY1V4zyXz6XBn
 L3pXPoOqux1hml0Axaxw4W0AG0p1UslmrZXvcdI5fB9od2Jpyn2WWroyCRo6QQPgCgc3
 2fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758825945; x=1759430745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQhKzetF5oIRZwx+RXpKazp3H6wc14PpG1+yxlFyfZA=;
 b=Qr3MXiNb5hndwrR+xOlYMZXPT1SEM8Th2U7Kjuu1dFjjC0QvfZuCvSpobDmk7oVt5z
 h232lY6VD50GM/Fku/hraxs5vt+CP3fOd5Au71rvk6KFUluE8veY6wLnRd1+bu9gGcHN
 M0LVqvF7eHMKFiZbC25z8cdMrUm7wRvldCB3JgbMx3auOZoVgXsc90tZPMHbp7gzs1gQ
 Fcm7mXqLbedQGuvQ3zcNi2PYE0wTIJN2+zYd4RcQsEGGiZWL7hZhYDMxdfHg6ULKv0t4
 vHAPWarXw0K05neC+2X8Z2OivCTUQqfT8AwBwza+zYhZiLDyc5LttLGJOLp2Pn6JjyIf
 QzcA==
X-Gm-Message-State: AOJu0Ywohh0J4mmnTXVNaMvgKIf5sETTg7nngmBOAaQ6EvMV8mHJkwnk
 pPINrra0L5HXI+rNwnladpiufn1fN+ZwT3dmFJIAecG3U9xi7Dg0usJQlV3qaw==
X-Gm-Gg: ASbGncu3rkhij7w64TRZOJ1ZFqdLcrOPth6rZ8OrtgdfqNqm0R3Z8NAElgeibGM97qT
 vuM6Ql+MsbmgYtGO0OLH8730WSkuRV10dgmeOeoK5BRYGvHPYaQviy30SphTrvAG8+oa+o1Qe5l
 YcyiVeSjyQsVNm0/wX6ubJKmfHGkkpKyA8GWtaBlu+kJg//F1vKMHXdqxTO2iTmSRPAs3rWPk2u
 tGz+phFWG5R5bVfiTGGgWrp5YN4XhLH9bBcAZWYAgasLCb9IcPtWtMH2qJFBwxubk9zLCoS5p3X
 lKHwpzXd9MVRiO+PqMlGkYwO1tugnrdwvJCwZdCSC5c2TTDrdasWwsIdssvQ1DLxotiYQsCgv5W
 +zsLtsb0moHcJhES8fg77fmR+9smTRgCM9dZd/FEBHy1zGQz3RSX6p+1ayex0UZ5PnbleBxVo4r
 RgNKc+vCZQj1xFuH3A2HUqIwJY1A==
X-Google-Smtp-Source: AGHT+IFpFdhZ6F97skMu7vn568cAAmlb4PO295uo1/auoXGHc7Yq1/JGQ3NDFxOSZ9JliNia1z+AoQ==
X-Received: by 2002:a17:903:320e:b0:267:c8d3:531 with SMTP id
 d9443c01a7336-27ed4a315c1mr51613345ad.25.1758825945033; 
 Thu, 25 Sep 2025 11:45:45 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D06700C9F588200B1ECEA8.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27eeb9a8ebfsm4244125ad.67.2025.09.25.11.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 11:45:44 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/5] drm/amd/display: Add missing DCE6 SCL_HORZ_FILTER_INIT*
 SRIs
Date: Thu, 25 Sep 2025 20:45:22 +0200
Message-ID: <20250925184525.43290-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925184525.43290-1-timur.kristof@gmail.com>
References: <20250925184525.43290-1-timur.kristof@gmail.com>
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

Without these, it's impossible to program these registers.

Fixes: 102b2f587ac8 ("drm/amd/display: dce_transform: DCE6 Scaling Horizontal Filter Init (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
index cbce194ec7b8..ff746fba850b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
@@ -155,6 +155,8 @@
 	SRI(SCL_COEF_RAM_TAP_DATA, SCL, id), \
 	SRI(VIEWPORT_START, SCL, id), \
 	SRI(VIEWPORT_SIZE, SCL, id), \
+	SRI(SCL_HORZ_FILTER_INIT_RGB_LUMA, SCL, id), \
+	SRI(SCL_HORZ_FILTER_INIT_CHROMA, SCL, id), \
 	SRI(SCL_HORZ_FILTER_SCALE_RATIO, SCL, id), \
 	SRI(SCL_VERT_FILTER_SCALE_RATIO, SCL, id), \
 	SRI(SCL_VERT_FILTER_INIT, SCL, id), \
-- 
2.51.0

