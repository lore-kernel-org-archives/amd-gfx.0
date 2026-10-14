Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95652CC6B2C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B3D10FD8E;
	Wed, 14 Oct 2026 12:47:55 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C5910FB9F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 07:32:35 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48deeadb3fdso86381f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791963153; x=1792567953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dQ9Vi8ze8lwdPqHYidKfxChexwTLWFdZyXa9tkQZSpQ=;
 b=QdSXNglrja129vuU8HZVy5mA9LNme+TTI5+3PLWQI/VF4jLOtFPnqF21xPvoHaf4pO
 jqqPAJYiHnVO9lsXQLgZKzsWei4Au5aUKOa+9Qz9bZlzeuADNw6dw7f/OhQZhgOb61Rn
 YwYCx0utO1io9WUbbcOWWRtvFTdaiOnn4IOMIw8nuj4JnJweY/+LeWeKs/iqMFvpZkuH
 27miVmLVWp1yPvxA2u/Pf1BYYd5b7Mfnjq8H9dgtzI+ydzUsqh0hIT7mMqSmKjUNDkXq
 v3QL5KV8+1bzhHI/ti2TuTanb54zZHNG1vj0v2xbk0IchFmykcHbHkDmQxvhSN8OnM8H
 CSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791963153; x=1792567953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dQ9Vi8ze8lwdPqHYidKfxChexwTLWFdZyXa9tkQZSpQ=;
 b=tNQ0aImyiXjoSOFQP8bDzETexsCZojNKOeLK6wppT8kvhhOGIk8Pqx0IM18gDBNAyU
 5X+9oNa3RnZ6ynr44i1F/ZHT91rZ3xm8PNfVSV0vm2m6Sf2CH2vK+mfR7/bLoFb1CG4r
 fVlFHOVDY6e/50FTwVIf5+8D8FSxE7UbEOt/dXMAkRlZXjcyl+B4AMPikmVhFYz0IuOC
 Jr72VJ3idbHy/WGriIcbbW4glYRvSiEVUJzrrIu6mBeV4HrXX+QXSBYn8xAF006uT5cE
 L/CsvRC7ijwoYVqjY3tyDTBeWpm7wk2LIIB4pkw+uVRBzCpqZvTxFVHJLcBhMoK1qPPw
 FLfg==
X-Forwarded-Encrypted: i=1;
 AKwUvByjaurxcdKcQKVLfGiQQo5+S5RUSQav5/SpenbJ4fxmVStvIYJyCXOhmD99Yfzi+r1W3xc9IEbb@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL13fO4J5IJUdTKsVNikeQGiETgXTPAQsOnq//sOTqtmo9ee7cq
 bx7WcWu/P4QjCYhem13DGVTaGcQ1Js0lLfqcI5rrDxMTFVEg9XBy/fJk
X-Gm-Gg: AYBFou0L/g120GmLKyGKfvJQUoo2MXHMlelF+eJINYXxEfnjdtbuH3btIlGq19qEzld
 W+oLiYlZIaW4+nUlEK5MEvLFb138h5UWrD6ma6JS7QONLr0KQUx03/twu9CT7jYkGm1U5Rmg5Ra
 uTpBMYAUwtU4J0GnXv+8yedA69H+CDyp5Kvs5osNaqVKrbdtWs9OuGIf/AftxVC3BuXkUB0QgoA
 IwaM/8GisifziKletlSuiA/sGvXKARCOI0C5WGTU5ZwcafdmUK91P72pyrGYB1fIYGlbiu5zAWY
 NRgBkfYna52iY84+Rd/4y3mi0pwSaUJRMWeCbzRFGjmcLf5L8xxdG2ha51l7YcuMoWsb7WrtVLs
 qy5rvwtjChreByzPV1o6UzCTRusAfNNLSxgg7N1dkXWq9SstseJbv8LdrKBFt57JV+dVhjhO+a6
 aKr/O2OVdB9rAFI85b8weLEJxQpSFB7isqlumQkiRYjzeIXCRFHIuSdFOGuDEAhHGHsv6J4jxzT
 m7Xd2r/EHQDIA==
X-Received: by 2002:a05:6000:2906:b0:48b:226:839 with SMTP id
 ffacd0b85a97d-48dbaaed220mr27241742f8f.14.1791963153131; 
 Wed, 14 Oct 2026 00:32:33 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4778:c500:9cb0:7d9f:2fd:3903])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967bf5sm9622415f8f.5.2026.10.14.00.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:32:32 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] drm/amd/pm: propagate errors when forcing SMU11 clock levels
Date: Wed, 14 Oct 2026 10:32:28 +0300
Message-ID: <20261014073228.2095339-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

navi10_force_clk_levels() and sienna_cichlid_force_clk_levels()
return success when a DPM frequency lookup or soft frequency range
update fails. smu_force_smuclk_levels() then records the requested
clock mask even though the operation failed.

Return the helper error from both callbacks instead to improve
observability. No obvious reason to clobber the return values here.

Fixes: db439ca21b81f ("drm/amd/powerplay: add function force_clk_levels for navi10")
Fixes: b455159c05313 ("drm/amdgpu/powerplay: add initial swSMU support for sienna_cichlid (v2)")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f8ca5eb9adc6..2d05088619f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1439,15 +1439,15 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 
 		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
 		if (ret)
-			return 0;
+			return ret;
 
 		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
-			return 0;
+			return ret;
 
 		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
 		if (ret)
-			return 0;
+			return ret;
 		break;
 	case SMU_DCEFCLK:
 		dev_info(smu->adev->dev, "Setting DCEFCLK min/max dpm level is not supported!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b42897e7c066..4ef3863fae1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1460,7 +1460,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	}
 
 forec_level_out:
-	return 0;
+	return ret;
 }
 
 static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)

base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
-- 
2.43.0

