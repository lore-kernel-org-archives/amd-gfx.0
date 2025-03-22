Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E87C36001
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F95B10E856;
	Sat, 22 Mar 2025 01:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UiJ6scwc";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F7410E856
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:17 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c54b651310so398690485a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608037; x=1743212837; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PL1xSGy/8VbgRXiY5G9SN9Lab3J8WeumuX411JsDSTU=;
 b=UiJ6scwcuGCT4pY1WoSFH2dD8LK1ZRWebn9eSSGS+rJ+4awFST2BLpK9GZ68S3ImV6
 ApGxoZap5aq4vxh36LaNndnW4xc4t97tnzsVOmXKgSAaTTuLeJuUKLVndwTewloP5pKX
 dyApA3wlv4/I4A0qFss3+s/LV3HAqwO1OK9A6LLgRSmkD3Q9He98qECoBiZX+X29Eloa
 ylULUa2F3VQ/yucHBvquxtLk9d5kt5/boTGLAu0VbdgLJxof8GblIw8dKDASRnejpgNw
 milbfTVZC7wtaf4G9erI4wawswllLjtBIxdlY6KmfbxAftKlLZ7UEkxNV85CkcbZq4CJ
 j2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608037; x=1743212837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PL1xSGy/8VbgRXiY5G9SN9Lab3J8WeumuX411JsDSTU=;
 b=wTN/oSUR3j47K+s82OdjRJlR0Ph4oYAoeJs5U2pyi9hnENUsms1G2Q5kJpDyuNJ2wS
 mpHdkNWhBmLpYVzKWG4WqP7L5brTALCpTJlfXhh7AbtBVHcQCEMjwfZLf9TJF1/PjVkH
 umrAOFGBcVOYTni/hE0g6GBX8E4q31uAgKQhrtK2tAe2Ax6G3w1xT4TP//6KILxMAEBp
 O4B+B/4D16Dxyj8yPIYQ+c0ux7+QDJ/bCZXVMIkR5e+z6zS0yPn+DvMrZTT0nitxw1Pw
 AS9IcA/gwFQvzYXv1c8W2WIMdwPxluLkJJCDCgS+5rIBiLowjcohxAJNW4w2heuv6MpY
 fb9g==
X-Gm-Message-State: AOJu0YzC+lRKgrOfLRx3HkqLG5EKIorXuTOh7h0YeTsj5aNDsZxseTgK
 hNs9O722DQJIg463zdIN5RtZ2sFCrvvlGN8qrTjvq/Mn3E2KcGIsHyHWpg==
X-Gm-Gg: ASbGncvYo2XtYYWkM/8KkAJ6wnsgKEzmWD72eol5krGav9VWlxmkQQYk+c1tIkVS0y5
 JHgabUxm7DW9pgshpeDhvPCtGFEtZO3RF6ae6SXXkjgOCRTzKTRQ9S0GAm/ZKWMQLHVh4NSOvdN
 UN6isYkcnkLiKc0BFnU/5KAgRSg9p+XNN3KuVKKKQmvz/zy+qC4SZhRDgf5XsiHjfUgdrbxPNw7
 msrAxIjYE4AZlojA1HkysE4F6FDr7w12xyCoL73aKBnPF6EfL+2ci+wxHiBun33pGbFl3Jz5OY1
 HyhKXcJb1u41W0xupXlEXe/6xi/SihQP6+BnT9ysV6233WYBavkXLcCyGkpnc14KqSo=
X-Google-Smtp-Source: AGHT+IHawn7i/jBjkKcUXoW+snA11lihAwGD1tHEpMuycKUx9uHtvSsX6B0HDJb/94WFK5LyQzLHSg==
X-Received: by 2002:a05:620a:4141:b0:7c5:5fa0:460c with SMTP id
 af79cd13be357-7c5ba1989cbmr808763485a.31.1742608036953; 
 Fri, 21 Mar 2025 18:47:16 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.16
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:16 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/18] drm/amdgpu: use GRPH_SECONDARY_SURFACE_ADDRESS_MASK
 with GRPH_SECONDARY_SURFACE_ADDRESS in DCE6
Date: Fri, 21 Mar 2025 21:46:48 -0400
Message-ID: <20250322014700.62356-7-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
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

It seems a copy-paste error: since we are working with
mmGRPH_SECONDARY_SURFACE_ADDRESS, 
GRPH_SECONDARY_SURFACE_ADDRESS__GRPH_SECONDARY_SURFACE_ADDRESS_MASK
should be used.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index a9a087a841ea..0ac66493ef40 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2010,7 +2010,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
 	WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset,
 	       (u32)fb_location & GRPH_PRIMARY_SURFACE_ADDRESS__GRPH_PRIMARY_SURFACE_ADDRESS_MASK);
 	WREG32(mmGRPH_SECONDARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset,
-	       (u32) fb_location & GRPH_PRIMARY_SURFACE_ADDRESS__GRPH_PRIMARY_SURFACE_ADDRESS_MASK);
+	       (u32) fb_location & GRPH_SECONDARY_SURFACE_ADDRESS__GRPH_SECONDARY_SURFACE_ADDRESS_MASK);
 	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
 	WREG32(mmGRPH_SWAP_CNTL + amdgpu_crtc->crtc_offset, fb_swap);
 
-- 
2.48.1

