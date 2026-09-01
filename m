Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFC2C624D4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD91210F42C;
	Thu,  3 Sep 2026 07:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n0OhP2ju";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E908010E650
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 14:02:21 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso6266935ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788271341; x=1788876141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJiqhKlCrTwwf/cJleA2B3ljUR61iwycQECqOoNxMUo=;
 b=n0OhP2juX8oBzc8xrDsXhemIeUr1quc92J1iGox54uRQ8edIOwHTbh8jNOaGWsCpUh
 DVEzhDruDwa3Vn8df0HdHH6vzMNDKpP3KxN9oeKbhxwFkryUY95N4Nvdge/Byg8yIVf6
 F+cnvcV1VMXhCqXrrBNZfknK1GlmzBFHSQrP3Qsi+aiQdLYFe7RJmfywvFG2+eonyu7I
 s49mMyQ2qbuh2AXUc53VdWriBfmy3KIwcY4GD5hqjjdrmt1Ct+VwEweipzOo7U3S7EcS
 cs6iYUgOaRCAiYBfM/9IgixPMvqQgwPWIooc+i4Mmpgex4RUAEe6xv8g0TXgwUoCM2Ki
 G6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788271341; x=1788876141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJiqhKlCrTwwf/cJleA2B3ljUR61iwycQECqOoNxMUo=;
 b=oUo+JkwhHDacMz7g0G6kThdvpvCMIye7iuIXvZvMCYvwbopqylGJ4Az5o2uZtlGnzx
 TQlPleEq3zWYK0j5JmcP3cxkXaR8RIyjudb4fc1yqF1X/yfNQHf4x70phXGf1jwiFnlK
 IncZg4Ydy5PBirD4D4KNTE/rTQd2NhmX7q+B2U0Z9XZf3mivjUEXx5LNblfzO9BlFuEA
 9p3uPKhxEFEy0EuilF1O1jkhBSpyVP9mBrqDyiPRv/pqkezERHW89ziLgNki1A388NRt
 BMnLDqz0BNDmtembEhut4UO4o3PuQMCM3KaUtpUU3SCp/YsS9w5PvboZR5Qh765RR82v
 6A1A==
X-Gm-Message-State: AFuF++m6rwlmY05EqlJlkgSCGzvnynws5tXR/2VhmqJfCFskMTAYucKP
 e5MGTMYrdPILjeodVulsPXCeX1G3qYqT3iBsmDuL8R1AeZr2YnLLvh3zQguTvxlh
X-Gm-Gg: AYBFou0PXIrunFdDfhGzuiN/202nNGhXwUkx9IriNfByNRjaxFdQUDhMJqL3BcCPooy
 QdIlJgc819k6woJfRVuFomQ3sWSyb/X3vy4cqvr1ajd2A4N5ZieOjMmQAY6jO1ir/Ld01bDvF4w
 zNy2JOI76PGZ8YYPx1+9RggFc1bp8i2uNymMjVx0CGWMSyIHRRdvHTkJCpWuaLzRB07qfyamSrO
 RSOQ0Pn8U69H1gxXW7/mefHm8WL+XDo6PYvUc08/Zmxw8rkW4vvr+MIszUP79f5I3rBO7tyVIW1
 CLgLmTOwi14Yfl8aMQPdJCJ6Wb5Z4dywf0JGgL8HLqL560/nIeAIsaYaaF9QeOb6SoiN68Ghr6g
 LQL9e0/v7u3UCU5tzXUCND7oeaut/LEESHf7paTZqnI0v+BQZvRslKoMo6wYrYXLVAENXWHnX3a
 1SGr95LCPr4wSO5dEurxn11ukszlGLFMlSg3sOmZZlrGwADZWEp9wnxnhm/w==
X-Received: by 2002:a17:903:2b07:b0:2d8:d4de:fa80 with SMTP id
 d9443c01a7336-2d8d4defec6mr398333105ad.4.1788271341199; 
 Tue, 01 Sep 2026 07:02:21 -0700 (PDT)
Received: from loontop ([163.61.5.136]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7594fc0b3sm53833895ad.16.2026.09.01.07.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:02:15 -0700 (PDT)
From: Aarav Kumar <aarav.240604@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, ray.wu@amd.com,
 Aarav Kumar <aarav.240604@gmail.com>
Subject: [PATCH] drm/amd/display: use linear backlight curve on Linux
Date: Tue,  1 Sep 2026 19:31:55 +0530
Message-ID: <20260901140155.19129-1-aarav.240604@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:34:48 +0000
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

The power module currently uses a non-linear backlight curve for the
Linux backlight path. This results in incorrect brightness levels on
affected systems.

Use the linear backlight curve instead to preserve the existing
brightness-to-PWM mapping.

Tested on an AMD laptop with an eDP panel. The regression was
reproduced with commit 3c108046e1d6 ("drm/amd/display: Add power
module on Linux"), and the brightness behavior was restored with this
change.

Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5723
Signed-off-by: Aarav Kumar <aarav.240604@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8d690468d..cd10a5d45 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1913,7 +1913,7 @@ static int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
 			!(amdgpu_dc_feature_mask & DC_DISABLE_FRACTIONAL_PWM_MASK);
 		init_data[i].use_custom_backlight_caps = false;
 		init_data[i].custom_backlight_caps_config_no = 0;
-		init_data[i].use_linear_backlight_curve = false;
+		init_data[i].use_linear_backlight_curve = true;
 		init_data[i].def_varibright_enable = 0;
 		init_data[i].varibright_level = 0;
 		/*
-- 
2.55.0

