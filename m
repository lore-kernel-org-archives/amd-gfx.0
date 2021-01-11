Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC5C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 14:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3B3223E8
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 14:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3B3223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66D689D6C;
	Mon, 11 Jan 2021 14:03:50 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9237489E50;
 Mon, 11 Jan 2021 08:46:49 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id q22so23606955eja.2;
 Mon, 11 Jan 2021 00:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=YlWsX4vIpjnJ+C3Yar4M2WF0HiBoobe/CVqoUsW6rVo=;
 b=COw2rqB77zW6ZIOfu7OjUku4N7nfgax8oJ9zq1ttqjWKsRXGjatsHvgc6ObraJj3v6
 Z+JDkxvucKWw1riQrOqDrq1qyGO8Jj/73spV6l1EgiO1BB54dNqyeFIAC6EY6GRg1/3X
 77C+7c1DTWy2+5FwfzUB+PCZIv2JhiYxVLrfuTdHhwJ6+c2FNgy0hlzw1fj/Gnf5fiBG
 QJsNi5alVtS8/6D06g0QFg8P/IvtuxBUhy2FqFS8DSAoyctBr44V8MDp6WFcHVabHeo/
 RY1AvfGCBzjfJ9ZYX1f7tnOIWUfN0tpnjepI7koTzaoA7D4zIGVObe6zEydk13m8blH4
 IyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YlWsX4vIpjnJ+C3Yar4M2WF0HiBoobe/CVqoUsW6rVo=;
 b=Di82n/YVZenSmyYoTZV5Mi9xENdPwb+FEf5hx/cPViURVtejD8AcRbQwYwaF+kkjoz
 Oqa/qPpvh98UrTr3RvyAsOSlEnfDmQquKfo71g4NGEo7En7UwDIHv1/Gb/bq7+e8WMzb
 IAO/2ZsFbh8gWLBC63EIpSPsiZ5NpVcNGLQiNQiUlPonG91X9JZtqfqB0z3zeYW6TqAU
 tHRyVGS6dWeN8tvHFHKry6Uw+ph/nvLNnf/3tLvisf3+yJKJJNFicEgfgLQ9OQgRzIli
 XEEvB8bkIx/PGJjaysxQ5/BkpjZtLwtWdTWL+Rx0VEncFZSHbFt6dMrZgtcLmr/aZXMa
 Bb4A==
X-Gm-Message-State: AOAM533PQsO1+GqeOaoMPsE7Hq8ab57hp16/BM7CKeH8iApbmZEqvtm3
 Yx6JaYawcTViwLAM+Oqxpyc=
X-Google-Smtp-Source: ABdhPJwACYUF7sGeZamayddBFCwllD7sJkbrh/rFulbE6JzAxqy1K0DMg/EsOWVzFKaoobUwwyrblg==
X-Received: by 2002:a17:907:6e9:: with SMTP id
 yh9mr9959389ejb.131.1610354808059; 
 Mon, 11 Jan 2021 00:46:48 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d2f:cf00:597a:a5a4:31de:992e])
 by smtp.gmail.com with ESMTPSA id j7sm6775313ejj.27.2021.01.11.00.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 00:46:47 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nick Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH -next] drm/amd/display: tweak the kerneldoc for
 active_vblank_irq_count
Date: Mon, 11 Jan 2021 09:46:40 +0100
Message-Id: <20210111084640.28500-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 11 Jan 2021 14:03:49 +0000
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
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit 71338cb4a7c2 ("drm/amd/display: enable idle optimizations for linux
(MALL stutter)") adds active_vblank_irq_count to amdgpu_display_manager
in ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h.

The kerneldoc is incorrectly formatted, and make htmldocs warns:

  ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:
    340: warning: Incorrect use of kernel-doc format:          * @active_vblank_irq_count
    379: warning: Function parameter or member 'active_vblank_irq_count' not described in 'amdgpu_display_manager'

Tweak the kerneldoc for active_vblank_irq_count.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies on amdgpu's -next and next-20210111

Bhawanpreet, Nick, please review and ack.

Alex, Christian, please pick on top of the commit above.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f084e2fc9569..5ee1b766884e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -337,7 +337,7 @@ struct amdgpu_display_manager {
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 
 	/**
-	 * @active_vblank_irq_count
+	 * @active_vblank_irq_count:
 	 *
 	 * number of currently active vblank irqs
 	 */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
