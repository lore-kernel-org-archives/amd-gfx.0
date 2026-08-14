Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4595BC5DF77
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 07:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C56110E67C;
	Mon, 17 Aug 2026 07:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fwaLXJLM";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F14B10E589
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 17:34:16 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so817567f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786728854; x=1787333654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gtJy9LLDFt0NmzJILJgVKeBO+MrtI49rw/kXkyURaBQ=;
 b=fwaLXJLMUNnaAufhCg0VV/HPRZbV76BwBrQzdAoubwPEzSFb+dyK5RO/yh8/jbc8Qz
 5GtdxMniyKvGDPjWnuH1uyiWBHgQAfvwxq7VHqvUo0Zt72HaNUJXUcrgaFHAIxUmmljX
 e0dNKkPA1oWbY2xEhSaVeqB75ZMSEr+NB26melHw2UEFTmckgNh0XVbHwqnQbNOqkQ/q
 1e5m7XkQfx3OUhKmn4GGz807HGMjId1P/HbRU6yMvYlCmkb21gOGcgfABqZgTaooNVNd
 /PAey3yKT08dZBncF2mWmaxPFJPzvU0MbmSpzDIPPgrYkW08RanOdkBOCNH1fF0CsZq2
 DsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786728854; x=1787333654;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gtJy9LLDFt0NmzJILJgVKeBO+MrtI49rw/kXkyURaBQ=;
 b=J8DIJY9KTsHMnzl5fRErEhw858qf+ww2OUNBe1tLSuPHwa7pPtF8VtSHnihIGsEoyJ
 v1bKyHxOn+TEtqtm3ycKcQRqgMkMRIXwklB+sspaAEZ8J+Sj4LGoBfjbjvA0P8B3v+y8
 Okt6XLcgSmrKOtIhAG8RIO3U7hmDKEagCpBPLM9DSxKufamyUwvs6hnUka3RSMmZtQ69
 A0fwwwZmBgbNPYn4Bg+Bi8cUeTQSLKGn26ZvqtB1pCUfbhqinaAdvniF12zT1jmipXDs
 WCEHt0zFp1zp6zzZBNXW9/H4vWAjeFnSE1HRJxypETeKS6ehsNLWvmG/73+XTipqJYPh
 Ojiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZB++lQStkgwccUtpawHioOP2ZGkKpNvlQn6QmPIPN4E7Aa5YK9Ga31gGhus5+NAYWctSjmBmQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWE70ePn2dl2xxA6EkSGWFbDzQuea2i+n5i/t0hhI93OAEiCNW
 Up7Nr2Qkaz/NnKK3eSZkToZSaQhEXOIwKfiMqLXyVVVUa9IHTqDzBe/o
X-Gm-Gg: AR+sD12uoLznmDf56SC82aS6DRjD/INu6QmsmJ4gbnsQpnlXelTggHVNEfSaONKUTDT
 h0zrr2M2Bezdf4znIogJ9aE2a3QG/katdaYN9oLWaKebs1B82FVeFF29NUBZPzvY5wrutrWDgkh
 Ysx5UTzT4QPnLrzZtbTleeEsnvtlYq9p06fIhrWPTwnh/O8mdFMcPWUjpv8C6dpcxHQP0r8lyyv
 71fsAaIxPtLdrcgLZ1xf/S1AOz8xwol4F0xOATBLtKhtjyvYc/YcBRN9IULWo53T+U4dUkA4HVV
 zNQh1fvuk0WSdg3Q/LzRjL8Acj5jFikHvRRkC20LelIe28iaDzONmTIGdiBDe+tLFZQRDAdD3RP
 KmwLHSppO4yd+AeEXQaALCIrcQ15sT9f+j49xssPZ5Xl5eGNxQqNxMWz/WhPi6OUh290NdKmKFl
 Jjp3Wy3sMXi3feERTVKIL/uvMrOk+IGn9coLDzvy2eYH50oA0BWYhrvTIjtPLQ
X-Received: by 2002:a05:6000:1212:b0:47d:fc23:abe8 with SMTP id
 ffacd0b85a97d-4816079b5camr8667132f8f.28.1786728854523; 
 Fri, 14 Aug 2026 10:34:14 -0700 (PDT)
Received: from localhost ([5.83.201.220]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f219d3dsm10046899f8f.14.2026.08.14.10.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:34:14 -0700 (PDT)
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
Subject: [PATCH][next][V2] drm/amd/display: Fix spelling mistakes "optmization
 and "resul"
Date: Fri, 14 Aug 2026 18:32:19 +0100
Message-ID: <20260814173219.1102435-1-colin.i.king@gmail.com>
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

There are spelling mistakes in a DML_ASSERT_MSG message. Fix them

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

---
V2: Fix resul too, Kudos to Rolf Reintjes for spotting that
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
+			"worksheet must be valid on exit independent from optimization result!\n");
 //	DML_ASSERT_MSG(iteration <= MAX_OPTIMIZATION_ITERATIONS,
 //			"exceeds max optimization iterations!\n"
 //			"\t is_permissible_found = %s\n"
-- 
2.55.0

