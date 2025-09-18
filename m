Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378C9CA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 20:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C95C010E8FF;
	Thu, 18 Sep 2025 20:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DvsXjSgO";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B56010E051
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 14:59:36 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-32e715cbad3so1061761a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758207576; x=1758812376; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=beNHBIORwWdI6jz0Xklt4Z8Y7brA2iCv2EEwx022pAc=;
 b=DvsXjSgOOIWxENpXoOP/Ghd0xaAwZmzGVR2Gse8naJls+XHIllPCVu8/EFD8giE71v
 /531G207dDQErsXZvacqrkMe+TpbPgpXqeYmyOtWStGZOmVpMDyqnJusKf1Y8/IeUCZe
 rPA67gfp04C9UfR2/TNBkfp2KKjpDxwuhODvzU/54DdrQHvQdnIt+BQaJwjKTpASNRtE
 +SwzCjdOF/qJMTi3xwl6z/bkSWYVCpGz+1HsPCYMM+lUdUOoW7IcGJotu6hBv2pDzciE
 4TGVStmZgLkDTsVslukCLGP0ZOTLvHLTrveq2LR8J5pw16Doia6rCQI2ef1pCgUPm/wc
 q7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758207576; x=1758812376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=beNHBIORwWdI6jz0Xklt4Z8Y7brA2iCv2EEwx022pAc=;
 b=AWeJgAazMqzbpW3knADC4HlHiYX3OcDikykeXffHxPSZDbV+5KZ0W39w9lag5rzTV1
 ZWs4gun/CmVupFcJ1WxgeL1yeJYGJvRRgJPW0dfZqcb6oowtU8YHdxDzokiDt2j80Ig1
 dDv4uCYReYKEKXmlgeBTyg693GOXwaXgG1+N6VtR4piXrDEx03jqzwliak+l2N2jblFh
 VrOl+J6Qb4CapnFP4c4lJK/RwiU9efhebjZTFwY+ZvTYR92+3h+R/lxCCP8EPULodadE
 WbkOvvijf6InyLLkcvBu/7+TKmCwEvgHvAm/0U5yaL9vafYDtP257Y6qqEwII/INo+/D
 J+kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM7kkmsPLlxru9/rggKft1auZDXBnVo/y2YVj7G7LqWOILniK9N6WamnGcVq4rLOGnv9N05m/b@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPaUl122JJ3Edm4Oe7kwzdFoZvH2NlYxW4UPEhu8cqrG/lQWOQ
 e/rUop8CV8u7f92wvJQ3LDN0Dm+MDPSxzgvPJ3t8iJNhRftHtss0al7lARLeWoExWL0=
X-Gm-Gg: ASbGncs89b/QDHJlWi3x3iOaYWPrtUpCsNfdHWkwDvk+PAP4V00ePCjaehQ/shjgWHE
 vsF443wVgfLTCKXn3O+LlWu4hSkaTdkm0qy0PSa+87vcfB+e5JKS9FKSIrPYGsMexZICkEiguut
 wXPmKVw/AFwVqduhkOie1qfV8WZ9z9ENietc3hWYiD58Sxd2kuvD7GflBKgfJmRsVwKpT7vDvL8
 kp1/PJ78FgzOWvA5daF1LYuxCN9wJRHNoMWBu8YvLvmPfCBLCfr9ATBPUZKVUH3cemiezgISu8O
 kZ/cjeyBEjenBU0oMyb+P6WDkZ7CcHOefMosQevOCAMbIirl86z/bFiVlYJkt8BzxvdV5hdpfag
 dgVI5iFHWv/sGN7QREjYn1YLBAqfXg1b405gpRXF65A==
X-Google-Smtp-Source: AGHT+IGIvBO3xzseHmX1P7b9dSF7ElctZYn/Sd/EuikFaigeHUhCCsSkueAeH62n8Nrlv3YnRL44AQ==
X-Received: by 2002:a17:903:187:b0:24e:593b:d107 with SMTP id
 d9443c01a7336-268137f2459mr75365495ad.32.1758200706397; 
 Thu, 18 Sep 2025 06:05:06 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:c81b:8d5e:98f2:8322])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b55138043b6sm424564a12.26.2025.09.18.06.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 06:05:05 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu/atom: Check kcalloc() for WS buffer in
 amdgpu_atom_execute_table_locked()
Date: Thu, 18 Sep 2025 21:04:33 +0800
Message-ID: <20250918130434.3547068-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Sep 2025 20:58:24 +0000
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

kcalloc() may fail. When WS is non-zero and allocation fails, ectx.ws
remains NULL while ectx.ws_size is set, leading to a potential NULL
pointer dereference in atom_get_src_int() when accessing WS entries.

Return -ENOMEM on allocation failure to avoid the NULL dereference.

Fixes: 6396bb221514 ("treewide: kzalloc() -> kcalloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 81d195d366ce..bed3083f317b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1246,6 +1246,10 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	ectx.last_jump_jiffies = 0;
 	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
+		if (!ectx.ws) {
+			ret = -ENOMEM;
+			goto free;
+		}
 		ectx.ws_size = ws;
 	} else {
 		ectx.ws = NULL;
-- 
2.43.0

