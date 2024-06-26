Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60C8C3064D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF26B10E998;
	Wed, 26 Jun 2024 18:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N1Og3YuX";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E9B10E009
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:32:02 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-79c05313eb5so199378385a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426721; x=1720031521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xri2sL29lwBBvIyJLBKIhEr0xbgJ4eVfji6GL2cmsB8=;
 b=N1Og3YuXE0sWB3ReaK1iyvoKEEWh9rmvPrzcZ/9ORs2rh+uNWYT/H9pgcuoisEYy2t
 bwVoYYEcKO+fzUtIF1n5Zer9XRUtV4oUaS6RZtpP/CK5dDE1EmYpuLcUTJlRdCOiPcMJ
 dz2+HWe38JkmuypbfkzGc3qjCn/D3ql7UdqIlNyRi8S8UPWpLP3OJo0EL17QpK+D7t3B
 SNVFsGnSLQHyaQ4kwsL+zbExoeJKOYso0AEHmiDv3XXqlHOmZSBFoWfcKgq220w5AoSh
 ylDxOY7/Z+1/530Ql28gfKYEnBM0Fv8k3ifrOKBWi7gL7J74R5EFh2RfJA9jRN9h68UL
 ropA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426721; x=1720031521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xri2sL29lwBBvIyJLBKIhEr0xbgJ4eVfji6GL2cmsB8=;
 b=CRhr35H58LvnB6ReK/09LgFnJbfXuEj1mf5m0Xq1Moci2JUXl3w2f5bU6yJdqOi7/Q
 gkQJCDub50yqHxSbDT95VxMSGDqwc7BhdVdOjqbBZ2RjhGxVzkxbDqnEdZ+IUXkKrqV8
 R2dJkrZWOOCV1Sl78/otgcIwqfgJJzifdztb/gih2lfU4lWTu93Zzz+gXoPCQWzbg48s
 RJDoer1W6NPNtF8+WjdLvC216t1qwGW76QwG5WNmFb3UWA1frgxrIiByCh7q076aFgFn
 X+ewpwvAcwoxEIMPnt6+9wo1aBqxN7tdlX6u8Lig6hZLb40wl60P5AVGlNbLtrxaiSiW
 7Fmg==
X-Gm-Message-State: AOJu0YxqosoQARudckx8EFv2I6p1YWsAxGGSDSRV6zgNI4zADlBR5vJ/
 Fi8lfGqpaR81r5P4lOpP2i8quC8pymnuSPQOYy+IJr1xGimAVVRlCAs1yg==
X-Google-Smtp-Source: AGHT+IFyGrr38h0Gb0ErnPQRiK8yEHsxIeR+50OU1aod68t3tUFPrzqUQfiMWGeIGL9ON6Mc01tzSw==
X-Received: by 2002:a05:6214:2cc2:b0:6b2:d69d:a2d7 with SMTP id
 6a1803df08f44-6b5409c718amr109707616d6.19.1719426720903; 
 Wed, 26 Jun 2024 11:32:00 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:32:00 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH 05/13] drm/amdgpu: remove
 AMD_FMT_MOD_GFX12_DCC_MAX_COMPRESSED_BLOCK_* definitions
Date: Wed, 26 Jun 2024 14:31:27 -0400
Message-Id: <20240626183135.8606-5-marek.olsak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626183135.8606-1-marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
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

They were added accidentally.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
---
 include/uapi/drm/drm_fourcc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index d0063ac6e09f..4168445fbb8b 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1540,9 +1540,6 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_DCC_MAX_COMPRESSED_BLOCK_SHIFT 18
 #define AMD_FMT_MOD_DCC_MAX_COMPRESSED_BLOCK_MASK 0x3
 
-#define AMD_FMT_MOD_GFX12_DCC_MAX_COMPRESSED_BLOCK_SHIFT     3
-#define AMD_FMT_MOD_GFX12_DCC_MAX_COMPRESSED_BLOCK_MASK      0x3 /* 0:64B, 1:128B, 2:256B */
-
 /*
  * DCC supports embedding some clear colors directly in the DCC surface.
  * However, on older GPUs the rendering HW ignores the embedded clear color
-- 
2.34.1

