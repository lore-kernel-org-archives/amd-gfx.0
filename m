Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735ACC5DF70
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 07:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6303210E67D;
	Mon, 17 Aug 2026 07:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="djE887sn";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3E210E590
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 17:15:31 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-495437bb891so9624125e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786727730; x=1787332530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NlJYVJ/8GdD4qg+Ajeu5HEDnsi7CdGS+uFMUtLjS2lM=;
 b=djE887sn2VlrjEj3qJ/EhodRLUs+gBY/Jb61yEHdkS0rzQvoQrLs1d0lCFJcgTcbQw
 d+tOuF4yvMgnchYnBbOXM2VsNyN1fHo6rJ/DFrE+kC7omKRtkNLJkhBsntWlYjdZiG4b
 WqywLTfMUa5/cttERyHJosVjOFBqRx3r/eudF4dU4DIweTKty4T1TNeFBs0G21W4vS2/
 qGIeVwplaf9Ycr5Q5Ik57IDXHwNBtUlrAA57O7S+oGF/7zlpGs8h/9l5WyziqrjI+d+s
 ucdHDZyEPWqDf1wNsx7Xs6GcCINacM6JXcf+rwR/d3J6lMFDz00SoFJ7qt8DQnchfhQj
 j8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786727730; x=1787332530;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NlJYVJ/8GdD4qg+Ajeu5HEDnsi7CdGS+uFMUtLjS2lM=;
 b=jFul9one4XgRv4Qc01Ha3QcUcQXTI+/7B0ZHGt0G13pz9NrjXrSFmg4zMXRrP++IDH
 wwsCnLFDTbvBJfh0jYMzcykgswJEF9QfiXHzK5+yFeyFReqPa4C6p7NPMhyYfC7nmW7V
 TvG3TkFkBli8y2pVWxsDAOkQslRF/GFoqPSknplBDFMjGqbTqJN9fS3ENfCSmaou2E3Y
 OaQvvL0tIF/POt/HuMraD7JyeT+9gjeFJkJxaPlY3836vGxFYnnQkmHEVAFZdT31jdGw
 U05RhglCGvxwLFniIP0u8UnaKwBKAKTQC/rUVqgaoQF17XZQevPjGKKdQtYTNwdaSoyH
 ByBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZTyIHxYvI/FfHZN3guZ6eapox5SSWLyCeuCqWleFll0J9wj73tmageD1E4u4SW+8eeFCtcZvo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzO56I5Iuq0OS1bGfysUtH84Y/rC1lBH5NdVVgQ8KLs/JXU9lRp
 k3WdxqWmHfvTKdh+OUX8VloMqhvmcaaQhsKmdIqDeHh9mgOwNEoRmK9k
X-Gm-Gg: AR+sD11poKxjTDsmiOClhsJJMSL9/X+aFMYj8MzdBhVdizwZfFeqx3gcX5PpCSKYMTi
 O+3j0ufzwcLq7fSkBr4kp1jm+B2YXS2r2TPPjmOAEQDb/eJtaPjpdkxH70bNfCMiqklQ0yhPgwr
 LCOB7u7TMScRZseoWM3QnjKZGccZLTzsJFt+AoP2XK1qFQCYtTA5kYel9wu3rJoW50ikCSglJMO
 RVKwyc3YfhiqBGRK1y6tgBDco6Avhl2ITAb2jqpeI1jLOFhifYg19EXm0+WdAqhNe4imNXjju/5
 N9hrrdod/aeKeD4O+2ljGtEMNU8R4vlXXgUIVIwsCs8LHcl7fBA1djmVSl+qsDLcQaM9pBp1BL9
 kGsDkOHWRSXkCLzhXpSov2GZb9Vmsomdr7E1JVJ5+Ne/WMqzD7pm6ILzkcGFvShHWywwxrdsNG8
 GHLh1yvVnV8CgvU+0Rr+JZXZPVBCCFWKCLERyKlb0imPFIzdCQGkrOE0UYYMw=
X-Received: by 2002:a05:600c:5643:b0:499:77ba:4b6 with SMTP id
 5b1f17b1804b1-49987ad988emr70687995e9.9.1786727730016; 
 Fri, 14 Aug 2026 10:15:30 -0700 (PDT)
Received: from localhost ([5.83.201.220]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899b5ad0sm44859855e9.4.2026.08.14.10.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:15:29 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix spelling mistake "optmization" ->
 "optimization"
Date: Fri, 14 Aug 2026 18:13:35 +0100
Message-ID: <20260814171335.1099999-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 07:01:16 +0000
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

There is a spelling mistake in a DML_ASSERT_MSG message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
index ab9cadaf5a60..79ec5838c26f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c
@@ -123,7 +123,7 @@ static enum dml2_status dml2_top_perform_stage_optimization(struct dml2_instance
 	DML_ASSERT_MSG(worksheet->validation_result.is_mode_support_valid
 			&& worksheet->validation_result.is_mcache_allocation_valid
 			&& worksheet->validation_result.is_prefetch_valid,
-			"worksheet must be valid on exit independent from optmization resul!\n");
+			"worksheet must be valid on exit independent from optimization resul!\n");
 //	DML_ASSERT_MSG(iteration <= MAX_OPTIMIZATION_ITERATIONS,
 //			"exceeds max optimization iterations!\n"
 //			"\t is_permissible_found = %s\n"
-- 
2.55.0

