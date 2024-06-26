Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FD7C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 574CD10E074;
	Wed, 26 Jun 2024 18:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h3VSHG80";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20D510E009
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:31:58 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-6b2c6291038so7158216d6.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426717; x=1720031517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrcjKttHRqKa+fBbFDj+rc/mFjLrheNWAa/ndUd0Aig=;
 b=h3VSHG80qAezWtv70gnuh7hRveKbRMkTOdAKwomYKmsyREyl9olkQ5Jd9h+y8/d8oV
 NK6FlPZW/yNdQE6DZPuZVdqrjPEDAPUcl5VfDNwYJjY6/xq2z3wNJ4amNhicm2HUf+k1
 azwYUetsiJMyTU3uj1kU119IrNTp24BkTknR+B6I5toUv39wDe14+JkZRCRoioQIXDfk
 gnqq9pecJ8xGd+ymRq22poowXgnkKWTxCx7wVDsa3wY22wNrLKE2+mgJJNnKwx7JhRKE
 Z//+fRuWDGfJhWiYcb26GCkbsAptlgCV45dSVtCMQC+vqbE0E7IV3W+Ng9Ue3Qdts9+s
 7+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426717; x=1720031517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrcjKttHRqKa+fBbFDj+rc/mFjLrheNWAa/ndUd0Aig=;
 b=QDSNK3tzlrgZmrq1ncQuD4nNRu6L9EcY8l5CKOQEpe6/mWseH09Z+s0lALhiKfiK5r
 zRAOLdpwV9LYGIrDTnk3/69MPyszP2Ll3lGOPucNTGnhXyZpp3TQwgQHUjnN5bu0x/y8
 mZ1waG3riZX/7Kn7mVpRU17iBGzjhn9JMMLo3epzPXoXh6mGxUs/WzIGHVKGfHp/U95h
 SeHyu0P95I5NWcrQvCDH5y70XpnXRbO5RMT+JYVnsElRidlTXXCJ9RarGtaPBD2wmMKC
 gqKQtcPknAfOuHPBnAWUBtyEL1Fz6RFAD3cLJzwvrGfUVUwVLKfDdd3l2jdVrZB+/0Wa
 qm/g==
X-Gm-Message-State: AOJu0Ywzvd4T+Q+CDaFbEA0S902hIs2aCc0irnN7Jj8FLiFK9Sz+i5/l
 sXJr5FlYLqtZLj6U21z+Uj8Wqa4qFGOn5vZR89XOz3U+t2KIX0wwTs04Ew==
X-Google-Smtp-Source: AGHT+IGTNWTnP98AkXfLL/yIBZI9zDhA09y/5DpxYOPLM3NzXj4u10WV0MGFrx9kCUPVtsozr1lZXA==
X-Received: by 2002:a05:6214:15c1:b0:6b5:7f0a:d83b with SMTP id
 6a1803df08f44-6b57f0adbacmr23976826d6.57.1719426717141; 
 Wed, 26 Jun 2024 11:31:57 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:31:56 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 02/13] drm/amdgpu/gfx11: remove superfluous cache flags
Date: Wed, 26 Jun 2024 14:31:24 -0400
Message-Id: <20240626183135.8606-2-marek.olsak@amd.com>
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

If any INV flags are needed, they should be executed via ACQUIRE_MEM
before INDIRECT_BUFFER.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5c17409439f8..0d078d0db162 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5604,11 +5604,7 @@ static void gfx_v11_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ |
 				 PACKET3_RELEASE_MEM_GCR_GL2_WB |
-				 PACKET3_RELEASE_MEM_GCR_GL2_INV |
-				 PACKET3_RELEASE_MEM_GCR_GL2_US |
-				 PACKET3_RELEASE_MEM_GCR_GL1_INV |
-				 PACKET3_RELEASE_MEM_GCR_GLV_INV |
-				 PACKET3_RELEASE_MEM_GCR_GLM_INV |
+				 PACKET3_RELEASE_MEM_GCR_GLM_INV | /* must be set with GLM_WB */
 				 PACKET3_RELEASE_MEM_GCR_GLM_WB |
 				 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
 				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-- 
2.34.1

