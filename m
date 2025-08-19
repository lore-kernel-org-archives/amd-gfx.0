Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A65CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 12:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D92810E72D;
	Wed, 20 Aug 2025 12:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HWCvMIYB";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B22F10E218
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 21:23:19 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b47174c3817so4239215a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755638598; x=1756243398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PSmrBC1d6V94gjkuBfdG1y/aJoYUJfpUXKEMb53Azh4=;
 b=HWCvMIYBL+nHKYdRvuAx9Bdui8y6JgCZjEAnyY1FUR06J9B2f8g5AmI20npX9y149v
 jVS0LjFGd7JAHVQJ3sGmYd/4dHr02wu760xdPClj/DeJuQ3Ph8Isv6uppWUj+ASNWuXG
 tCHf0VC7zX7R5v/gFABNQNjJlKZIe/4+GM3ajNYJ+J7U0FqL2wD7+95gnzAP+o328j1W
 Rsx9lN5D0VwAlkeIOi9ZoQm8/ANgGpOqQJ/m0gEPHcQV989azmUF/sKfWgkgRmpgvknH
 K/9jzvJDpLL+alqEZIeGvTpAdodDyirhqAPoh0Ue/5JrAA+9pf6cgMPdMuywP2s68YUZ
 Olpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755638598; x=1756243398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PSmrBC1d6V94gjkuBfdG1y/aJoYUJfpUXKEMb53Azh4=;
 b=GZXccVQN0EkDNXqjbDOivZVLwDBJUVybXED1GX/4lhsSS4JjYNPgV491CyhPOKMKCS
 wC89SFUOI0FbeFQYFFZgD2eaLgEkJY/5INfCC3CEyNAWGUUyor4v0ZuIOaQo3KhfJjJ9
 H0Zuu9WVX2QRlTVx0srXWIObxZITVzJZ3RmBnWu8bAicF9am8SwLpiWi/B79IxRG7dyP
 bJVhg1YeaVXzQLhCWbxAP/pah7PuCay+MSSWSEJ0RTyAwWvTCR9wsAmy6MagF4vRwNy6
 UZoO4nVqy7ub9zUsW1BQwm//HjHoKeh/uznma2ZLwYNTo8J4NED2gDjm8y1WXAvY+I1B
 mDug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn6ZCcfIkxX+5WwdnU1TBVOcBviAnhkZ4jtA6ZMAlAUrf9vRvvlk/HzhbuzxIU8c3DNOzrWxkW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbzqnMH9jJW+uc8S38s4Xa/6Suy02+Hulnc9Dy+IUdW90UCXUA
 5ALv5iGpfDMqsrhRT6KX0edX4BgEL10Tc3mdfUP+3ELCiP05/erAG/X6
X-Gm-Gg: ASbGncsJktv36RyFV2gS8Nsfn0I1w7xVRsIDammXqkH/Vhl/U2W1h6F0dZxUzCWZnuJ
 +jd3dblihqLc73EP2Khaj3B8bQQYoe3oeI5sAfCiNtPiJfXbfCclmD+9cNLnANfzwjjYTsvckR8
 YiIBM1wphm9EIPodT/JV029rrt+nXYROavQgP1Lh+alYDyxMnY3F/4ncVsGdSzcnQAoqq2j1kbP
 R/qt6CenoK3Fy+VrNwNK7gWZTzEBWv1SXMqDtEC+NlKwcqHmtDgeZsmVc5SBjHfr4N8FrQlX07N
 RVcxSVD8Uaq9E9+dc4JuopXibXzS0vTUP0zwkdaKZV3dnjBfPGnJMvQHxh/t1+K6qi707geGxim
 ymXlMTF/zgRFpep21S0TNqQpVLmORX0U9RkJkfcg9zKZjR1CpRQ==
X-Google-Smtp-Source: AGHT+IEh4Uka68y7Zj7GJebi6yM8KMmJWwpaYwlw+QFwbiPeXXdYTZC6/PqbjtfhSYD0c3fy30pHXw==
X-Received: by 2002:a17:903:2ac4:b0:240:9cf:99a8 with SMTP id
 d9443c01a7336-245ef0eedc7mr5753865ad.11.1755638598444; 
 Tue, 19 Aug 2025 14:23:18 -0700 (PDT)
Received: from localhost.localdomain ([202.164.136.133])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed4e9bc2sm6364175ad.113.2025.08.19.14.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 14:23:17 -0700 (PDT)
Received: (nullmailer pid 17994 invoked by uid 1000);
 Tue, 19 Aug 2025 21:21:51 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: skhan@linuxfoundation.org, corbet@lwn.net
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Kathara Sasikumar <katharasasikumar007@gmail.com>
Subject: [PATCH] Documentation/gpu/amdgpu: Fix duplicate word in
 driver-core.rst
Date: Tue, 19 Aug 2025 21:19:58 +0000
Message-ID: <20250819211957.17871-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Aug 2025 12:32:38 +0000
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

Remove duplicate word 'and' in driver-core.rst.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
Hi,

This patch is part of my work for the LFX Linux Kernel Mentorship
Program (LKMP). 
I would appreciate any feedback.

Thanks,
Kathara

 Documentation/gpu/amdgpu/driver-core.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
index 81256318e93c..bd4be32f2725 100644
--- a/Documentation/gpu/amdgpu/driver-core.rst
+++ b/Documentation/gpu/amdgpu/driver-core.rst
@@ -65,7 +65,7 @@ SDMA (System DMA)
 
 GC (Graphics and Compute)
     This is the graphics and compute engine, i.e., the block that
-    encompasses the 3D pipeline and and shader blocks.  This is by far the
+    encompasses the 3D pipeline and shader blocks.  This is by far the
     largest block on the GPU.  The 3D pipeline has tons of sub-blocks.  In
     addition to that, it also contains the CP microcontrollers (ME, PFP, CE,
     MEC) and the RLC microcontroller.  It's exposed to userspace for user mode
-- 
2.47.2

