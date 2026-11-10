Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A28606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ix34q0C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694E610F9DA;
	Wed, 11 Nov 2026 09:13:14 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5E910E398
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 21:53:37 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so1358961f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794347616; x=1794952416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AqrPq6DInPU+YVwPB2qO7zdIo9ZkitMttG/r01QX26E=;
 b=0ix34q0CxQA7lBlgq9uQnwX2qRfsu5j675qF+zpg82FtBBdn/+sQes/Rhqcv7Y4/3X
 Job8waKI4/IXr0TW9tcSwoaSrbX8qz2IEteWGydEmFeRsflC5cTL88AHbGDDw0YggLJr
 hgTc+uR+UcgQo7L44J8p3cgHnVzOm8/3I0HoQdm9dXayMCTDMhCZ8ZT4nc8maDicwJd1
 /pYushijvzlSw662V6LgmlovbzVoY5TGOwS110EV3jyCu346s5KQqbQ20SFjFpqxgAd0
 pRKAmGii0qfW9Mx7MOE+CaKmBK4ueomwSwjbVZFZtnGC9peAEIRKCGIwznv6hCasFBNc
 S06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794347616; x=1794952416;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AqrPq6DInPU+YVwPB2qO7zdIo9ZkitMttG/r01QX26E=;
 b=NXS6FtE379Sd84qJWCko6Nh5KlO2B+QcNTT/au0bfWY0vcFdy+t1G6AFSRr8I9BvMw
 aLo265YY3olgkmxSlEtcV5v+lQuM2H3N08CJgwkFqfeNJ4miX5DnDPDbEiHnhbvh3jv7
 pNYL6j2jLvhSFG9UFRPqdAHH4GzmcoRgvMxmnflJuwsOqmRih5Wi3cB/Q/KRm+zTFxIR
 U1nqlCBbF/+fXcFbtaaYGrzFyGh61mTNIAHNE4ON3Y9m8rUCl/BatMNi2fEeVvXnVSqv
 edbKev9TlL9Wdvs6PU+sMzhqL0C92bIltIgHaNNqEFs7ijk+h2TXs/khwfjQ7s4f2ymL
 UK3A==
X-Forwarded-Encrypted: i=1;
 AL+hErESEXRHEFlerx5Q7l5VuqcBvSibv26FVhMDNEay/2BmxKj4Q3RexIfBNvvWNXVSoQwn4/TlJ48a@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/XiQtyZbUB435hVb9cX6UA/w1B3bW8zquxdru0EJD8lKBQra1r
 gJZnnvyuHTq9O8zw6iGylgnHc+dwOXpIJcxzbggzhkjdOgBRyUs9QCYO
X-Gm-Gg: AYBFou1235W2Ve+L8ZuDFQ2o3+drm7MdTczLFQ4HnbtZ3fE9Q9FZdw2VbFo9RWHYKe9
 XSyCx4KKih56GzP137MJ715fXoO1JLKMSZ8/s1u91eHSf1pkSQbcAVSaLHW/CfpkcHhwmhqx2TD
 PKN8/arxeOghrex0xKBcz8ObSTNbDYcVjkgoZJ8DZGeSgyw/4O3Z3nJFG9xu4PDxxpGJqOxC27l
 +jwZ8YaPIhIALt7+I4uYKGUdtsx3E2wJZMTkhY55HgL3w5hg1rt9PXtPRTY7x4dsnj2KedeDJQk
 tvJtt7JYz1cVlHykqwv95T6gIi9vzJJtKn6dY3/rassBSW34be3DnbB67n7+du/npi4ZFxyO64h
 AwBwsx/MgYJZ0cA4LiJvDDX1ZD1RruU7nnSY27bVKp2SPFwlTan0Lx1T64a8VbyYxS9pMv9ukdq
 TQFseFAfCE0/5OxXpilaaOg9D1wZ8Zj5pkvIxxzgoXI+fquQLErl0tomCZTimjDkZpM/Asd9a47
 L3M/L15YoIfXeLIovV996Kp1sQOaDx2aoXcKQTL/9c13g8pEZ47tkTlW6VzMMsjU9iQT/+/2dTu
 1RMXQGF2SjQBFjJuPD3O8xgOYLE=
X-Received: by 2002:a05:6000:2411:b0:48e:3647:c35d with SMTP id
 ffacd0b85a97d-499c7a24acfmr395628f8f.21.1794347615587; 
 Tue, 10 Nov 2026 13:53:35 -0800 (PST)
Received: from localhost ([5.83.201.131]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4984e26f8e3sm6377221f8f.1.2026.11.10.13.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 13:53:35 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dillon Varone <Dillon.Varone@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: remove extra trailing semicolon from a
 couple of statements
Date: Tue, 10 Nov 2026 21:53:34 +0000
Message-ID: <20261110215334.947250-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 09:13:13 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There are a couple of statements that are terminated with ;; - fix this
by removing the extra redundant semicolon.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index 71d14fb8c830..5dd22003f165 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -328,7 +328,7 @@ void dcn6_ms_calculate_writeback_bandwidth(
 		}
 	}
 
-	DML_LOG_DEBUG_2D_ARRAY_DOUBLE(outputs->WriteBandwidth, display_cfg->num_planes, DML2_MAX_WRITEBACK);;
+	DML_LOG_DEBUG_2D_ARRAY_DOUBLE(outputs->WriteBandwidth, display_cfg->num_planes, DML2_MAX_WRITEBACK);
 	DML_LOG_FUNC_EXIT();
 }
 
@@ -4255,7 +4255,7 @@ enum dml2_status dml2_core_dcn6_funcs_validate_solution(struct dml2_core_instanc
 	enum dml2_status status = DML2_STATUS_OK;
 	struct dml2_core_calculate_ms_context *calc_ms_ctx = &core->scratch.mode_support_locals.calc_ms_ctx;
 	struct dml2_calculate_mcache_allocation_in_out *calc_mcache_allocation_params =
-			&core->scratch.mode_support_locals.calc_mcache_allocation_params;;
+			&core->scratch.mode_support_locals.calc_mcache_allocation_params;
 	struct dml2_core_internal_display_mode_lib *mode_lib = &core->clean_me_up.mode_lib;
 	unsigned int i;
 
-- 
2.55.0

