Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454A1C87FD2
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Aug 2025 02:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DFC210E1A1;
	Sun,  3 Aug 2025 02:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QW1qMXbu";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B2E10E05F
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Aug 2025 02:27:56 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-7074bad055eso14485496d6.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Aug 2025 19:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754188075; x=1754792875; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B5KmXqrjkyuxBEgOpuVWWM/d2rFbcL5c72cCU9ANjTw=;
 b=QW1qMXburx6UyZsbpWrG+9l2lZju2bRuojwiOP/LCD7z5+nuqY1mKRYE64lYljfFqH
 Quu07cmXRMN1FH4d/G73e3VbT0083RFCd131U9LqpyXyelnO6tVOhp4/0rqPfhusa2oy
 RsGJpVXgVKgRSGWUvox49QX8C9VjxMTdnAnxoXjuHh/zbyLLecaGDI8YipGhbbpyFjcl
 49LHDsNo6g0j6i01uCiYudH/4vPvaa8UfG0963KpkYVRBlxIKeobaqL5/o9y5ipZuBLY
 ml8eoujbVh5KZ0CPMwqP8s3ZFr3D9llq3OIkzTgW20nYANLQUlIHsLTPSUXk3yk8XIw1
 162g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754188075; x=1754792875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B5KmXqrjkyuxBEgOpuVWWM/d2rFbcL5c72cCU9ANjTw=;
 b=iojX0qf8ib8WtRmRF4DcmF1Lr0r2p+ikf+TFSuSQeWmFvLqrT/MzKjIu7shXdSbN4x
 2G9sAsQJbOABWKOAgAy43j5+MafzmGGLO39tEtS8FavxF1R5CH84zanFKbDKM76fF0Po
 4tSNP6wWQanylN838wkSpbL2+mAwo1rwWHXC0IzmjNt2vrl3KZYAIs2xzreC1iV+Fhar
 qmvy9Q2l6Akt2fOUxdxpWtETgpZVPjhnpV5xTIJjsKGArFNQl4RfQCg0JP6wCnYZK5jp
 NrM7zvNR3L1/rglj/zulczs6oSjyXwPAOJqpyJ4VOk7KDSLJsJf+KdvMn2AhkXDUtuYo
 uaeg==
X-Gm-Message-State: AOJu0YxFEx2Z69ZRj1LPWMOrcoMBOKyhZnnywYOkvU0L6FbB5XPnBbIu
 la12DmtT8Y2Wk3UJV013jUtDw4gntsbd2Ubo+ayhM5ahmWCgxpp7t7BXWNuGvLpH
X-Gm-Gg: ASbGnctuc8Nn4lAPzcageASmGUd4yJ4TJnG73/MogjXAfkIjAmXo2U+F29iZL2w16if
 +eXPuDBGFalNEE/FdN/l2pFfGiIEN629peyvJNANDzUeP+31d5zatUvtmZ19oc3N35hd8CjilXc
 PBoIGyQBpgjsDO01nbiFP41GAJuZUKwbwm0FSrPUewgSgvFoDzbkHzBl5KKbBVWXmt/s9oAy6wj
 3Jpu+xy+Fs2BFj+LEYj/61rd9AYrTWg81VwdkF6Jj2kl0ThLSr0rP0GKguU4NYuuH/8fQZK6YEV
 Kh1n2yYDyL8kICDJubcIzF+Q67CXYovk+V0mTzfoDy/fTAOhSdV/BBzjcmROTQMYcLJQ3iMY8pp
 sGdapHvy/HyN0AGG67L2o+OceB+Q=
X-Google-Smtp-Source: AGHT+IEbOSGAwnBriJKP7HzEOa2Vf15Itp9xKglNS6QFBtXT4YwaGVLoj4adw6/0HAdYi0OWmIy/RA==
X-Received: by 2002:ad4:5749:0:b0:709:205a:d90c with SMTP id
 6a1803df08f44-70935f0e681mr76535556d6.3.1754188075080; 
 Sat, 02 Aug 2025 19:27:55 -0700 (PDT)
Received: from Xander ([104.251.39.208]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077c9dc383sm40959946d6.16.2025.08.02.19.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 19:27:54 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH] amdgpu doc: Remove VCE support as OLAND's features
Date: Sat,  2 Aug 2025 22:27:31 -0400
Message-ID: <20250803022731.2033153-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.50.1
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

OLAND doesn't support VCE at all, but it does support UVD (3 or 4,
depending of the sources).

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
index d2f10ee69dfc..f4dde71b5654 100644
--- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
@@ -1,7 +1,7 @@
 Product Name, Code Reference, DCN/DCE version, GC version, VCN version, SDMA version
 AMD Radeon (TM) HD 8500M/ 8600M /M200 /M320 /M330 /M335 Series, HAINAN, --,  6, --, --
 AMD Radeon HD 7800 /7900 /FireGL Series, TAHITI, DCE 6, 6, VCE 1 / UVD 3, --
-AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND, DCE 6, 6, VCE 1 / UVD 3, --
+AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND, DCE 6, 6, -- / UVD 3, --
 AMD Radeon (TM) (HD|R7) 7800 /7970 /8800 /8970 /370/ Series, PITCAIRN, DCE 6, 6, VCE 1 / UVD 3, --
 AMD Radeon (TM|R7|R9|HD) E8860 /M360 /7700 /7800 /8800 /9000(M) /W4100 Series, VERDE, DCE 6, 6, VCE 1 / UVD 3, --
 AMD Radeon HD M280X /M380 /7700 /8950 /W5100, BONAIRE, DCE 8, 7, VCE 2 / UVD 4.2, 1
-- 
2.50.1

