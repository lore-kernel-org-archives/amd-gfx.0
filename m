Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3881CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 08:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5D610E88E;
	Wed, 10 Sep 2025 08:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dUgpkKGm";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEF0C10E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 09:21:05 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2518a38e7e4so31961685ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 02:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757409665; x=1758014465; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aUvugBs/HfbP8FSUc7ieLlf7fcudHbkwsA+MFyocDa4=;
 b=dUgpkKGmvsdD5UPoknshSo9qW2gKs7ioAWZptpgM8N+776V+6jdgvuFOJHZR1JfepK
 mlpq23ZOLP5ex8l4xYTjUeNNLyLr/sdu5EvTYTSifqpRq+0l77g9C+Jt7hrY+IEugl9K
 93zedwe9RHlKNJC/X8T6UvBafceeGx9bofQZgfOWJXOm+2xYYcl34fxr8gxcebR3jgy3
 aIZx6ir7ME4tN+WQndH+7daKNONRgBMVnSftE4yISeNMbm7oDIv3y0iAZH7zlrElpM4C
 4Ps88WfGu4akgSUGMMvlpnJq1Fvyht3Yi80jZkprPGxogzV3ZcAX+1iizOQe6FWP+LZL
 tQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757409665; x=1758014465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aUvugBs/HfbP8FSUc7ieLlf7fcudHbkwsA+MFyocDa4=;
 b=UkysjZjkuyDFUtd0stVLQEOElYADv3E29PtMi8N0xdNeUs+xyW1qzaAqRFIv3d10xG
 oB//esq2WJxeJBRWnB+35TPRQN6h/23YP4DVR1QJKb2t+nCmfjOvVa1Gw6/K6SBCQjB+
 rAo6S5Dxd5YoheFj+E9CBGLJh3L0hFoDdrNxe5bE+jY2bTKMKyVt7kJ8SnlM5OYuKJ1y
 3qA6DXHZAD0YQNyQkSxbrp4CIuwrwHR6Zt8n67mXY2bTOjLa2t0ysNCJWojRK/ymNWgT
 02acasd57Gi3/fg6BqsMY1b5P04Zfmmf++rjMhf0os81hIUHA/eCKl+v+J5UhasIQTX0
 oCfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSE9z9S7yYTwu6oi2SRUcSzZ/QTusbr8NdFW5BpOBM1wTG1VWykPne6528OxTMeklMCa9Dw00N@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAcaBxE95SeJ5amhpzGjV3yacNN/W00ij6mllZ6DId5/rDbXOX
 FyzMh88UX/RfJxyIP0kOhMWcbnAxY3Yyvz9SzchV/0l/xCqk3TFpIDi9mCY8Mw==
X-Gm-Gg: ASbGncuspyKz3vbAZA05BW2d6+RGYh0ZuRcVSm2ioSB2/qaAu9M0u61X1ry2uKbS4T4
 4yD02fcoZJoJk8oVN7zsQYa4ZfkCQM6+/m2WZZvG5qk17ya9QWJDD8HEPXsm/F02nopyyTonrm1
 +3WOkanu/xJ9bng7oLZYx9ejqgVfygrbulHdqH3Ckb2RH0Inkp5V2HeETUwyHGRajMj0YhH62+W
 JSbybsuK9cQ1ERWNevHLh2kksYI8lmnLTolC1G+/8+gTqaKhOsKuHLVnpBy2TJV0Xk//UxR6O5V
 yNZ06klGhmj0XUSf7caoJeIPH7h9r6RpnaqVMsisNsOsmRUfDV/+vIKKDndxc/N6WulV/vaIrhU
 oRDOXs34pdrX79JVUqArtE1B+fcHX8WsPn0+ughIIioW0YT9c3IRl0IUKhLu6dFU=
X-Google-Smtp-Source: AGHT+IFUMNr3rKpEQQ4QGJsgn1vIVkRQMGZf6cJe/JnOFgXmQnPwtOeK007JtOsHgeUS+Rg3hE+J+w==
X-Received: by 2002:a17:903:986:b0:240:417d:8166 with SMTP id
 d9443c01a7336-251788fd271mr132869335ad.19.1757409665016; 
 Tue, 09 Sep 2025 02:21:05 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25125d76218sm88522165ad.119.2025.09.09.02.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 02:21:04 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com
Cc: chiahsuan.chung@amd.com, nicholas.kazlauskas@amd.com, wenjing.liu@amd.com,
 jserv@ccns.ncku.edu.tw, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/2] drm/amd/display: optimize reserved time candidates
 handling
Date: Tue,  9 Sep 2025 17:20:55 +0800
Message-Id: <20250909092057.473907-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Sep 2025 08:01:12 +0000
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

Optimize the handling of reserved time candidates by replacing the
custom bubble sort with the kernel's standard sort() and rewriting
duplicate removal with a linear-time fast/slow pointer method. The
changes improve sorting from O(N^2) to O(N log N) and duplicate removal
from O(N^2) to O(N), reducing computational overhead and eliminating
hand-rolled implementations, while correctness has been verified with
simple unit tests.
---
Changes from v1:
- Add early return when *list_a_size = 0 to fix a corner case.

v1: https://lore.kernel.org/lkml/20250824182359.142050-1-visitorckw@gmail.com

Kuan-Wei Chiu (2):
  drm/amd/display: Optimize reserved time candidates sorting using
    standard sort()
  drm/amd/display: Optimize remove_duplicates() from O(N^2) to O(N)

 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   | 44 ++++++++++---------
 1 file changed, 24 insertions(+), 20 deletions(-)

-- 
2.34.1

