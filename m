Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94748C3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 01:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C1D10E627;
	Thu,  8 Aug 2024 01:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="Sin8MVHJ";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2782B10E627
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 01:09:13 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-368633ca4ffso52052f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 18:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1723079351; x=1723684151;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fwj6QAtkedk6u9naVpNdDcF8o8bbnRYJwm49lFZEyMY=;
 b=Sin8MVHJdG4mpb9gPXexKN9lTGAO/N2YjOTv/ntSGzqDlkocqaPAyAr2KUD1InCugl
 qSzEvRE5tL3/RJWkGqB/GI1lFiO2fIC8RoMnh3A+wErEzE87vWQ088wI7KQlvXfhWTxY
 ABCK5nIEKuHAzgDgjlWmV1k8D5mKhS1mZ2ITRLwL7fH0ZX8bN6KSMR4vQXxhp1hQ1aZR
 5Rg7zdFUSmxKjpHkTjMS+StzcKgvq1TGUrg8NkQ2kC7XdvZ4wMm20DelOjgTsIyUthT+
 cdzRHru3i2QhmWf41b2TzSDME2sGbDGErpsf1OEcEMvbk6NfSlTyGklq7hnkng5jSOId
 KFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723079351; x=1723684151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fwj6QAtkedk6u9naVpNdDcF8o8bbnRYJwm49lFZEyMY=;
 b=c9X+K5SfEbKmn5m1DfFpYdtRWbs7gyv56NdNGtQcvotzzYGQWD4PQFfg84ycQPEiyC
 XDpHKDyHUZJ8rZk/mdUO6Q+Moo6wznE2b47t3OXwgmpQqZpgXcqOVE66S1vVbgswSUuL
 VJDOQM3e5FLi5DnK+maVw0/9ZcEE0rkQQD+qOGC8pPrZn3k+8sq04T2M6RkCCJiuIO0J
 hT+RkfgT2DsxRC5PwWdT6QSxDLC0SBishg+9RxxihAj4tWmImlN0+DyB5Ey/QqYqY/wp
 1Nrh5Tl9uK9kO0estnej/8G2VPaam+lGi3V9zW+78pg23fjIfUBYt7cmTR99iS5a12lr
 balg==
X-Gm-Message-State: AOJu0Yw4IaFEQ0XNERN5e2i3mtrlin85MGxTjDA3HdLu8STQnWXMJavt
 UQ1J7z+Y4PkQMnX/PtB2xc3QKYSMFJqFFZDYd/xVJG2vpe6AKDPo92idQzWxsRvGX73a3FHXz8K
 qgpg=
X-Google-Smtp-Source: AGHT+IGleB1Ggc1F3XS/giTB5QGxSGDFHC+MKKVZSSgSDbN69L/GoaVYo+IxOzw9I/5UFi6qheKwWQ==
X-Received: by 2002:a05:6000:1845:b0:35f:2929:8460 with SMTP id
 ffacd0b85a97d-36d274e0c8bmr99791f8f.3.1723079351103; 
 Wed, 07 Aug 2024 18:09:11 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:a500:aaa1:59ff:feea:fd4f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d272095b9sm240753f8f.68.2024.08.07.18.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 18:09:10 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, airlied@gmail.com, faith@gfxstrand.net,
 friedrich.vock@gmx.de, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 4/6] drm/amdgpu: Add UAPI for disabling implicit sync per
 submission.
Date: Thu,  8 Aug 2024 03:09:03 +0200
Message-ID: <20240808010905.439060-5-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
References: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
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

Per submission flag because:

1) Slightly simpler & more flexible than per context flag.
2) We'd need to extend the per-BO struct if we want to put
   it there.
3) Doing it per BO is annoying implementation wise as we
   disassociate it from the BO list before doing the fences.
4) I don't really anticipate an usecase for doing it per BO.
   (e.g. I don't think we need to selectively do implicit in
    radv and I don't see radeonsi tracking READ vs. WRITE at
    this point.)

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 include/uapi/drm/amdgpu_drm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 96e32dafd4f0..d91fa707575c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -610,6 +610,12 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
 #define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
 
+
+#define AMDGPU_CS_FLAGS_MASK       0x1
+/* Disable implicit sync on BOs wrt other
+ * submissions. */
+#define AMDGPU_CS_NO_IMPLICIT_SYNC 1
+
 struct drm_amdgpu_cs_chunk {
 	__u32		chunk_id;
 	__u32		length_dw;
-- 
2.45.2

