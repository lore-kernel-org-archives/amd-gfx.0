Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB89C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE35922B42
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ouoh3vaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE35922B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C40D6E4BA;
	Tue,  4 Aug 2020 20:08:49 +0000 (UTC)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2FB89E52;
 Tue,  4 Aug 2020 20:07:09 +0000 (UTC)
Received: by mail-lj1-x243.google.com with SMTP id w14so15192377ljj.4;
 Tue, 04 Aug 2020 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8X1vD9iMjbD58TZPHKwb4ye5PBWIjmiaZvRTOJ3otNU=;
 b=Ouoh3vaNcVVGD7H1kVwnvrVgU+wwepgvDoAEKRlV+AQ4Tf2O+YsRYKYjqgvyFNQB2o
 eROYCzwN/1rJZ+FMCt2vFYPMrt4X0Rmk9LoreTDEZAGNnFKT6V2YRSqWNc14awRYiFn7
 jEUkw6GM3xGAEjf3AXKOIgEMI3vjKawi3ItOG4+6Jl80xw80/Alin70MWgu/wjlM7d94
 c3jshDgkCYxxIq7vcFA18eAH30zhEryIJTkQW4bINYC9f/+SEEdxx8P4ZJ1UiSuqHgJU
 gVywg7cQU1OOxLn4t8RJCuKJx36zrpwywX8nIm3XL/Rs3oOwMK2kM33iP3Lm8D1toPPn
 YBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8X1vD9iMjbD58TZPHKwb4ye5PBWIjmiaZvRTOJ3otNU=;
 b=QHEC44kTRgfJ7HYrdzKJhJ8CQtFfl5QmIdjNqei6hDOkanC575fLyzVz5OHnfWRJPt
 XUvOQzdi0MbFhiAQs0WLsst1LNOtW4MuysGDA2oQ3C+k019RjGEzY7f3NJpgeKRCgtAC
 u2piB+YkQbXHCxw4cl5leHJ6YKx4hdv4XV5v4K4xYAIITKZ1RMa+rEem8aXPP7R9K+0p
 Wx5d7j+SnzCYsxlkpLeAua7OFnJFVCnNbpI137b59E5a/ohTT9yY6mat7omOK0lOiL1B
 jbcYf/a2yjIcl2ryJaE+J5mqZWJ8MJqmsi11GlKZ9DZUNK99bODdqfYc4x7mgmqzxJVl
 ByZw==
X-Gm-Message-State: AOAM532rrX+IygayrZ4nEV8Q9pYzxkx+eWGJKiaeSMRRSNofxF02/uGE
 dJbVbVLL+GFcQY6x69XYysE=
X-Google-Smtp-Source: ABdhPJx1Y3+zg8EQVx5eowP9zlLeEH4mmso+i3MTOfkpYRGj2nf76AZey+5T5A6YD2go2MiFTnmiCg==
X-Received: by 2002:a2e:a179:: with SMTP id u25mr11596380ljl.101.1596571626718; 
 Tue, 04 Aug 2020 13:07:06 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se.
 [82.196.111.59])
 by smtp.gmail.com with ESMTPSA id g21sm3080020ljh.103.2020.08.04.13.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 13:07:06 -0700 (PDT)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 1/3] drm/amd/display: Constify dcn20_res_pool_funcs
Date: Tue,  4 Aug 2020 22:06:53 +0200
Message-Id: <20200804200655.30495-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
References: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 04 Aug 2020 20:08:47 +0000
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
Cc: amd-gfx@lists.freedesktop.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The only usage of dcn20_res_pool_funcs is to assign its address to a
const pointer. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2a5e7175926a..d7ce984a2ce3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3320,7 +3320,7 @@ enum dc_status dcn20_patch_unknown_plane_state(struct dc_plane_state *plane_stat
 	return DC_OK;
 }
 
-static struct resource_funcs dcn20_res_pool_funcs = {
+static const struct resource_funcs dcn20_res_pool_funcs = {
 	.destroy = dcn20_destroy_resource_pool,
 	.link_enc_create = dcn20_link_encoder_create,
 	.panel_cntl_create = dcn20_panel_cntl_create,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
