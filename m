Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19211D73086
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 02:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E41010F369;
	Fri,  3 Apr 2026 02:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kymKmVfR";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA7B10F369
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 02:22:15 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43d17bb1c1dso1338033f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Apr 2026 19:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775182934; x=1775787734; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vzNDCnptLxr9N4/HfL1wKT8fmcbYUXexVBJFABPwBBg=;
 b=kymKmVfRlYTn+xNAZrW77KtbO30jQKyTpqnETpVU9vTU88z6UlKHL/sCNPNshWCF6e
 /mx6Jq/dNGVcsPCqva3U4in47XuTMfFJmz2gjiEnyobdBvuaMXOmDR/jxv6R/FtWMO6I
 5wRjUxdB0IRzNMh90EVCMAkdXE0V3xJPhegGuXYLVorCoMZYqo9eYz9Gjcgxqi3NXxzl
 BsORCNQ4sV+oy2jPNHoh61mddM7PXr59J1iIylHuKnh3QrlBvkoqy07VD+hqZcpJB3oA
 tOInRHFDMs1klgWOrEErrYkkXs2QeqhjaK8FXlyPlpOZDaz+jrlI5RPgnZGhKfBmRiEu
 3JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775182934; x=1775787734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzNDCnptLxr9N4/HfL1wKT8fmcbYUXexVBJFABPwBBg=;
 b=b2UxuIQmijFrsvvU/3urCi4amHprCTNdjNpazdhQgnVexvkeSW0o5cAbVd+zLimGoo
 YfkNogq2zqNTQRigR4R3WnFiC8N9oksYBwov8XYYz3vCU7rdBKoVjIFbuj6DFBFnCMT1
 soxif95G1Bd9lpT7D31BZZTA6Q8G2dixqmqt4pAonXHl1/bNhoUmCTbToKdfTOYrm71u
 RY+JJq1FN3mRDdhnQa18tCYOzGUE7gCWU0cOMQsLCUo+J8SWir+6XYpv0vcl5f+T4puz
 wXreuvFs07SaB3P1Irm75DjzAZFyvm8dHdzaEjtDD/CmoNUY6sEMKQKnaLupOaeI4oiZ
 X82g==
X-Gm-Message-State: AOJu0YzwDl0G/YZpcZN3HhH83z937AAyziwKitsLJYIr/ExVP0k5ME3R
 JVjv1Ze+HiqqIaCKUsYhip13Omm8YbNAofTd+FjW48l3CEZIlBglOF0Mn1KRB/Aq
X-Gm-Gg: AeBDievk82otCJBCzwkSN+0xrF2vQBxjUntJb2PkR3lLYCQm1/sUBfihyiF54DcscIy
 zMVb5Kc11pGBmMG/YC/q6SI85ycvE9jKZ20sUVLwPzEKjzFiktGBq2pKDdsqWDLy68u73BZUADe
 Q+7y90ZlAv/DgQOLoc1Axn6Fb0ghpiqZHH6m2ugg70hLv+vzNZSg2xgXgHcUXSTvnAh1KTPZzvA
 B3H7Tumu3TKYCX1IuL+JX1KinM9WuMam5dkMA/V44rOiGEuT+CRwhBEiX1yagGh4IFI+9JToj7w
 2XJ9OkQb8AA8x7IUwOZpHcOhCllXbZKk1LKvR2oyrbwlsAw5ivoIFO92rl2Aob1CnFVaj+nDTIC
 6+E6fN8f026IBmIv53r4RH0ipC+9YZQIiBKy/hSsY/PDio5DSEZDpj1BtjxdtivBVL3EA7A5qhm
 2Yhk7REmZ5/MrrmBF08pJsQlvsuFZB/Sd1RXSo8JyXqwsum79Sp87/56DOhUl6nOg9nHw=
X-Received: by 2002:a05:6000:400e:b0:43d:1c39:534f with SMTP id
 ffacd0b85a97d-43d29295ef1mr1981977f8f.11.1775182933459; 
 Thu, 02 Apr 2026 19:22:13 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e52a0sm11942406f8f.30.2026.04.02.19.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 19:22:12 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu: Use amdgpu by default for CIK APUs too
Date: Fri,  3 Apr 2026 04:22:08 +0200
Message-ID: <20260403022208.232991-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
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

CIK APUs are: Kaveri, Kabini and Mullins from 2013~2015,
which all have a second generation GCN based integrated GPU.

The amdgpu driver has been working well on CIK APUs for years.
Features which were previously missing have been added recently,
specifically DC support for analog connectors and DP bridge
encoders. Now amdgpu is at feature parity with the old radeon
driver on CIK APUs.

Enabling the amdgpu driver by default for CIK APUs has the
following benefits:

- More stable OpenGL support through RadeonSI
- Vulkan support through RADV
- Improved performance
- Better display features through DC

Users who want to keep using the old driver can do so using:
amdgpu.cik_support=0 radeon.cik_support=1

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 ++-----
 drivers/gpu/drm/radeon/radeon_drv.c     | 3 +--
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8ed637f923226..e47921e2a9af2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -641,9 +641,7 @@ module_param_named(si_support, amdgpu_si_support, int, 0444);
  * CIK (Sea Islands) are second generation GCN GPUs, supported by both
  * drivers: radeon (old) and amdgpu (new). This parameter controls whether
  * amdgpu should support CIK.
- * By default:
- * - CIK dedicated GPUs are supported by amdgpu.
- * - CIK APUs are supported by radeon (except when radeon is not built).
+ * By default, CIK dedicated GPUs and APUs are supported by amdgpu.
  * Only relevant when CONFIG_DRM_AMDGPU_CIK is enabled to build CIK support in amdgpu.
  * See also radeon.cik_support which should be disabled when amdgpu.cik_support is
  * enabled, and vice versa.
@@ -2323,8 +2321,6 @@ static bool amdgpu_support_enabled(struct device *dev,
 
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
-		support_by_default = true;
-		fallthrough;
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
@@ -2332,6 +2328,7 @@ static bool amdgpu_support_enabled(struct device *dev,
 		param = "cik_support";
 		module_param = amdgpu_cik_support;
 		amdgpu_support_built = IS_ENABLED(CONFIG_DRM_AMDGPU_CIK);
+		support_by_default = true;
 		break;
 
 	default:
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 87fd6255c1141..53d06053dec8a 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -278,14 +278,13 @@ static bool radeon_support_enabled(struct device *dev,
 
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
-		support_by_default = false;
-		fallthrough;
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
 		gen = "CIK";
 		module_param = radeon_cik_support;
 		amdgpu_support_built &= IS_ENABLED(CONFIG_DRM_AMDGPU_CIK);
+		support_by_default = false;
 		break;
 
 	default:
-- 
2.53.0

