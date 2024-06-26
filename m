Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BFDC30658
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D48E10E98F;
	Wed, 26 Jun 2024 18:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G4sz6fH6";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC5D10E009
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:31:59 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7955c585af0so377692785a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426718; x=1720031518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VwoA47WiGFSmwlMqUz9GDfFDqzLec0Enuocw70PZLF4=;
 b=G4sz6fH61u7k+ryNY21xwCytZH6WdwsxW0n1RVUCXLZeTSYBp8EY+KS+2HQiGeMn57
 EnUTs8IFFc2X+2Eovw9O3PyPyAELZrTjgZ4ANg8k72BwMpCo4Jjlh3xQrt/mKo0dwQ94
 7foK92oXIyAIivnVmv52oVKNO+IjnRLjpYu8lYCAac5hWfRoS8PRLv+EyksCcJ6ylJ1/
 D4F1o8JnePEaNr02wDcjv55bzhzQVGb/7FJtbuWvcX5w+eEiBkeHD5QpDiBrkG35jtE5
 KKgyRYVGyPSCVZ2Jz977ihtsIr5Wpx4iR8RhXTSBciIS5RY7aupEFJ7d1y4Q8lVTeYA4
 GUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426718; x=1720031518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwoA47WiGFSmwlMqUz9GDfFDqzLec0Enuocw70PZLF4=;
 b=YeGjqLYCXPFMnCSJPk1Nc+7KcVMxY4bwVIxMzOXCyz6twVfSBvYeDoaYNzVs+yrbts
 Nszxf8TRF9PByQAfvMbgS+otbL0FyPRv8sAgH4oUF79WJAHLPxP/1fNdfWPMxDWJzTh6
 yD88ZxsQ4kL/WLrvOpHw8DKuJpSrxCMhHZjynJEVJw2c291OvumTiz/ycyjOKUxfN8n5
 OAQHYCB4r3V86YZUm2MWtEsimAYxrFhyVXjq+QXCztPirIClEv6fN1QwjEjwCuq2RCHF
 YsfezP8Nj1dV3FlgyLXw6p9caWNrslppGUwKtYFLkNe8KsvxKSLrt95CBxcUDgOUhwjv
 9f2g==
X-Gm-Message-State: AOJu0YzgWbHp+VaZNBsC/C4ZfwDpKoIF7zQDFOupfBaQ5a/eBlT/4fdK
 KfjsFKQ5ODnmhx7QKxP6hg27W01/OTyIpgvOsE2qyymhI8obJoDJZOvdNQ==
X-Google-Smtp-Source: AGHT+IFotcERQ4qVszREWqdUXm6Smssv3DfK5V7j98ofHiUh+zzgpHvEnWsSJ54Rb614d1MWfxXsMQ==
X-Received: by 2002:a0c:ed27:0:b0:6b5:3bff:da3d with SMTP id
 6a1803df08f44-6b5409e0ca0mr101536936d6.35.1719426718155; 
 Wed, 26 Jun 2024 11:31:58 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:31:57 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 03/13] drm/amdgpu/gfx12: remove superfluous cache flags
Date: Wed, 26 Jun 2024 14:31:25 -0400
Message-Id: <20240626183135.8606-3-marek.olsak@amd.com>
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

GLM flags are also removed because the hw ignores them.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index e9559bdd8264..a638696b2142 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4144,12 +4144,6 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ |
 				 PACKET3_RELEASE_MEM_GCR_GL2_WB |
-				 PACKET3_RELEASE_MEM_GCR_GL2_INV |
-				 PACKET3_RELEASE_MEM_GCR_GL2_US |
-				 PACKET3_RELEASE_MEM_GCR_GL1_INV |
-				 PACKET3_RELEASE_MEM_GCR_GLV_INV |
-				 PACKET3_RELEASE_MEM_GCR_GLM_INV |
-				 PACKET3_RELEASE_MEM_GCR_GLM_WB |
 				 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
 				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
 				 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
-- 
2.34.1

