Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA38AC44501
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jul 2026 11:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A6510E281;
	Sat, 11 Jul 2026 11:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GwvIUPeW";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9769110E0EB
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 11:21:14 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso1104406f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783768873; x=1784373673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wb+G84SjUTaBnQMDlPXrlGPWCus/NYdgvtVtNya4474=;
 b=GwvIUPeW5ljPIhGnIWc11LRzS+MAPDAOrAyKWqRsW8gMb3VBoGxhIbtdCNs0N9aGjv
 AL0nbm7Wzl1jd9UQHuF7PUd4hg7Pgq2IfEnKdE+DaTvqGcjiffdn5rd8w6CqdsYv8q37
 4WfauLvpZUOq1tp4tlcv00tVtL88PlRqzhuKB7+wmlx8YaAaw7UO05RMIRd6XoMW1RZ6
 GqjqKbDsqgsjIhHp3nc/jocMUgTx+U4pcOUn/oZuqyMZJ2DkGLOfSmSA2FH29TurdIlg
 VHZC9DpOLKHgN27NFrECoGmZO33v+frWnFqeGz44/LrBpzMsKvqoi3Fho77bgtswQ2qM
 g68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783768873; x=1784373673;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wb+G84SjUTaBnQMDlPXrlGPWCus/NYdgvtVtNya4474=;
 b=Nf2OpP1ramHxTIwJRPZKPSvglirZL+2WBv3K5dpMV41ya3JOcKcryxrmiUepskukaN
 HSZLL2HdUO66K4Xz1FMiZCP0ZKi0lDtC6WRkMaiOWRMBuS0DxR02gCogP955nlg/xPgf
 dpilrhnD4D5OS99srIYzFTmjll0tBqj+RKYJJx1+vGa8t8dx0TI1nCtaHWAaZesnFFh7
 MBfPX3SX0JeI24yMzB654zpaOtxEBS1V8k1lBei/4b8G0j/k7RaE51BRmwBAX9hqPC8B
 AIXnL2INfG9xeC9+nxJsENrUAncBs7gxk1tru3MfkUTZQsw7XbLQq9LT360RxeAv7Qjl
 EVBw==
X-Gm-Message-State: AOJu0YwP7NQhA+4kClgwyGzz5CJcVC9rfqYGhaEB1xGon0JoaZbyh+G6
 qLSw1eoHo0kz7e2B15s45uGUJtaV92v/qnvkv66kzS84uykFdagW19qoTNjfuA==
X-Gm-Gg: AfdE7cnjF627OuPPC5c2BWvphjTuP5q+j4iv9auCfGcZmuYOTk9U0spMbJoW14DeOPB
 W/+Nrik8+ElL0u66u0mGyY4ByQteOFZ7ForzXv6UGfW+XT421Q2uOlp1SzgjoaagzmmHF8iEt2B
 CighhTX5znMAHJKA/Cs93GIhX2uF9V6Q9ckz9QdwE2P2WdkQqBuUGl7HtkHkJP0RuGv3L8fF3KG
 DPKmpk2kbigl6b85t8Wzn+PVvVpXfmJHiE0luyKZOmMcQbPNpsIRSFZ8vZqKp4/QYnzaouNiscK
 NPx0UF23dVqxamm4m70ywFGUYYzN4JrTko+nH+x9cWY4Kfx+WkWtULMq3KLRv/J+svaRBXfl/8m
 bJpTWZAljqrxdtAY2OV75Oc1fPAWNj1Q/Jx+7yoiqkXOrm/SLyiSma+DmoLtFCDeByy3ZjzATAz
 NF/AjlfuM6X8q6wmlnl+FHkjvJYwuhjtS081Gz9iTbDUpjuEByLVmQJw==
X-Received: by 2002:a05:6000:4381:b0:473:3241:26a4 with SMTP id
 ffacd0b85a97d-47f2dcb3e4cmr2401625f8f.12.1783768872915; 
 Sat, 11 Jul 2026 04:21:12 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f2465ae8bsm13228764f8f.36.2026.07.11.04.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 04:21:12 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/2] drm/amdgpu: Reserve space for IB contents in devcoredumps
Date: Sat, 11 Jul 2026 13:21:08 +0200
Message-ID: <20260711112108.8980-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711112108.8980-1-timur.kristof@gmail.com>
References: <20260711112108.8980-1-timur.kristof@gmail.com>
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

Currently the contents of IBs are abruptly cut off and don't
show the full contents. This patch makes sure to reserve
space for those contents too so they may be printed.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index aaf091b7f9d0..39b2a4c0e011 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -235,6 +235,9 @@ amdgpu_devcoredump_print_ibs(struct drm_printer *p,
 			drm_printf(p, "\nIB #%d 0x%llx %d dw\n", i,
 				   coredump->ibs[i].gpu_addr,
 				   coredump->ibs[i].ib_size_dw);
+
+			for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
+				drm_printf(p, "0xffffffff\n");
 		}
 		return;
 	}
-- 
2.55.0

