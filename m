Return-Path: <SRS0=ZIXC=7U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B3FC433E0
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jun 2020 04:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E25F206A5
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jun 2020 04:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD39SVG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E25F206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCFB46E25F;
	Sun,  7 Jun 2020 04:06:20 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE176E260;
 Sun,  7 Jun 2020 04:06:19 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id q19so14485081eja.7;
 Sat, 06 Jun 2020 21:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YnfNaRqVPV6XqQG2QgxhQE+LJO62l70Xq3ODGCdKbrM=;
 b=eD39SVG7TsxYBPUexkrFKxT01/K/7WNVvcZVjjdXxDZsDBHnZR8F2bDGsKs5f0rCcx
 SR++CBlzHVetPlhWMGVgnnNs0Gv2eyvHAS3sCkCmbaKtny0s1WU3bOPWSROlBIFqcjR7
 nvhWhoaa8kkFj/amy6sLglXozu2G7tyEVoIyq7psRuweyrQitRuufIC7++SJa+j/ctPi
 HlF+91KWFg9+WGyJyEXP7Rrh4vCzwboT+Lwmg/A58q+QQUx/RLT1XF6T6gQX6j6MRejM
 caC1MoEATdDn1hqmhIlCWUVtEtAn+VXxru5fyawLWE8YSvlYux4wr76sUSdy0Tpau1ej
 zUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YnfNaRqVPV6XqQG2QgxhQE+LJO62l70Xq3ODGCdKbrM=;
 b=kPPP+Irj8r2NJlB4JU9is2ibG64gUz7VGxDyCrp3IAo2lxjS9J/u1U6tQ65ujt/L+v
 s/cd5JzjrK2F6QkTAqoqQBPm0hg+wPbOAXiI7/XcKSRe8lTJyM0bMTqf1AGewuIG21Jg
 eSPpVxDgF5ULPyVI9sxW24cz50BVjVU69S940C75UkGpowFCBklzgZaf+SF9RFO3sxXC
 zbOxyM5zUNMGXG6xS9T9cuQaXtJZRmCBgaVa4d22jwJtw2ZAubWB7vtm0gSIpIQ7qjNk
 1X4o1+oCnES7Y+v1uF1Rv5r8EjTJBdx3Zxgk761CpXZGYIc8mQsxSOYoQK26PFIvHuqv
 G+ig==
X-Gm-Message-State: AOAM533wLacGEWFL6vsy72v2N5XQ7TUwxBS90ELdLMQIxY+R6phCr+5K
 1qy0caAfCKqrqJCiJ7Q5ZgKOHNu2
X-Google-Smtp-Source: ABdhPJxhxitFum4zLZeNoJUz6WK4R5MBNcjk9wnR74y7u9CfPAXCoyIGjDW2KWz1tRVTPmFs7vRZKg==
X-Received: by 2002:a17:906:b88c:: with SMTP id
 hb12mr15086605ejb.483.1591502778428; 
 Sat, 06 Jun 2020 21:06:18 -0700 (PDT)
Received: from twisty.localdomain
 (dynamic-2a01-0c23-8430-e100-f914-43b7-6b66-02cf.c23.pool.telefonica.de.
 [2a01:c23:8430:e100:f914:43b7:6b66:2cf])
 by smtp.gmail.com with ESMTPSA id w13sm7797243eju.124.2020.06.06.21.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2020 21:06:17 -0700 (PDT)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/display: Enable fp16 also on DCE-8.
Date: Sun,  7 Jun 2020 06:05:58 +0200
Message-Id: <20200607040558.15996-3-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200607040558.15996-1-mario.kleiner.de@gmail.com>
References: <20200607040558.15996-1-mario.kleiner.de@gmail.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, mario.kleiner.de@gmail.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Assuming the hw supports fp16, this would be also
useful for standard dynamic range displays, not
only for HDR use cases, because it would allow
to get more precise color reproduction with about
~11 bpc linear precision in the unorm range
0.0 -1.0.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index a19be9de2df7..0dcea3106886 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -402,7 +402,7 @@ static const struct dc_plane_cap plane_cap = {
 	.pixel_format_support = {
 			.argb8888 = true,
 			.nv12 = false,
-			.fp16 = false
+			.fp16 = true
 	},
 
 	.max_upscale_factor = {
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
