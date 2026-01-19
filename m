Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E59CCA6008
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E25910E3B4;
	Mon, 19 Jan 2026 08:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QkZ8lDQC";
	dkim-atps=neutral
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFFF10E305
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:12:00 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id
 4fb4d7f45d1cf-64ce9d80429so430632a12.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785119; x=1769389919; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZXVwXnPctt9VEWjXx91N6i+1aICn1iOJ7TSOyayxAY=;
 b=QkZ8lDQCsX+8WRPu8nZ8XNcDKrzvDaX1r1oeugh1JuNfomx1+xbh4iqF8Wyx5wUcTQ
 dyEc3QOU6fFA6I5tgPSZQbeYKVE9kXtxp7Rf7fzXMaRatUF1cCf+WuYmq3+/DtYGbaHo
 3Ez+mjyaKAB2bLACAup70zndGn1f3aBBSYHNt7c2raPLMVoMie3PC+g+0V55lbbmvpPk
 Hb2lR34Doz5coe65eA3yET9GB8EUFSQU4d0Azbqzja8wlfuhNJTmmNW1ZnRVWa8tQad2
 F02V/F3vql0x1koaS5yu54Wak2WEpajZN2GoyXr9wKsXpuYFuEqT1k3/b5JtpfUxSnjZ
 wKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785119; x=1769389919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LZXVwXnPctt9VEWjXx91N6i+1aICn1iOJ7TSOyayxAY=;
 b=QIuEMJfaEzRVDmr9ZUcu5zOAiiqdDgGdfaFKN48dHXqyjSa0nzLphabMFg6T79D366
 gVpBVkMnhNJh6uLsVUbNn+B9hSuJZorU9eL5EypYuiM0jhQ8iEBHRT9vGhLlfktWH8rQ
 WZX9cQkMUxC0C6l4BmKKj5znidUnLW4O7maYtUtNlhrGPBVQdpRdblPrkCvuXLm4t9Bl
 1tYje3Fhh24b0QM7Jnk3dkiXLs/kUdXcyMJzwemIrxytSclyP3cIQYskxZPNy4olDwI0
 h2qi+U66XQkjtCSV3SMx5+PbREzJ9HpebdW13Vg0C4Aj8nT4B6JEvupura2WWKcgzhPF
 IuMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr2srOgRqK+smf+9UPPFx/lQZqfzhyg+cncbowsRPkc33MDTu99ttmnjPDUjdiCdABflElEgRb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRzYW3OoIArVshdpZjmjUeujEB0XMmK7Nn8TwB44jdipgDRj0J
 iSZT2m9mB1A8+L2wnVy1+RQXHLnN4i6nn99juCLG07KZmQNBIzlWIuKj
X-Gm-Gg: AY/fxX7fBWZTN3rlTrWlGVcz3eBiaeudlmKpAe1ZL1s9HXzWnJMq2ZkF3QkA0//LDa4
 5ecHWjuGKr6HilaxZySGBjMzfijeTDl3r6w/+jlhGPEftNUf9qUuc8TRQm9SPO0OuyI0LQpXQin
 aXCPUKVc9ZEx5jLi2ncL5RpQjUVzdqZeQeJfCNmfcBh8VxP0MWTJLhfqRi1qsc04vmJOpT7rKg9
 OaabFipI8VKsEvnebOGl1IwCPN7gUzKLNmERpr4OqVJOixttQSDYHOjkeFENMGYqh6eKZIK9/SN
 IOXh7vjVFP8qwnJ+T95z3T2X9vu+pMUP/MfoybMY4anvrBsi88Dthg9CfWbaeN9JZik97cIS0CJ
 xw9Lk7rTQWb/9i/oyhliVf5rq1Nc5Q/Ga3y2y8ru2TDp/7sySdy4L2alcrxBLBjrecawMbimI6K
 nRv0QimSDNx1cADU1bdY0Mup859npCjR9hMpC8j6gVzReqZzGMNj1uwCgG3Iz+wDpSHDifuNLZH
 hk=
X-Received: by 2002:a05:6402:42d2:b0:64d:23ac:6cae with SMTP id
 4fb4d7f45d1cf-65452bce08amr4211650a12.6.1768785119145; 
 Sun, 18 Jan 2026 17:11:59 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:11:58 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 07/17] drm/amd/display: Add CH7218 PCON ID
Date: Mon, 19 Jan 2026 02:11:36 +0100
Message-ID: <20260119011146.62302-8-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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

[Why]
Chrontel CH7218 found in Ugreen DP -> HDMI 2.1 adapter (model 85564)
works perfectly with VRR after testing. VRR and FreeSync compatibility
is explicitly advertised as a feature so it's addition is a formality.

Support FreeSync info packet passthrough and "generic" HDMI VRR.

[How]
Add CH7218's ID to dm_helpers_is_vrr_pcon_allowed()

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4773

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 drivers/gpu/drm/amd/display/include/ddc_service_types.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 2ef515a4e1c4..37747f87b55a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1390,6 +1390,7 @@ bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link, const struct drm
 	case DP_BRANCH_DEVICE_ID_0060AD:
 	case DP_BRANCH_DEVICE_ID_00E04C:
 	case DP_BRANCH_DEVICE_ID_90CC24:
+	case DP_BRANCH_DEVICE_ID_2B02F0:
 		return true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 1c603b12957f..e838f7c1269c 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -36,6 +36,7 @@
 #define DP_BRANCH_DEVICE_ID_006037 0x006037
 #define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
 #define DP_BRANCH_DEVICE_ID_0060AD 0x0060AD
+#define DP_BRANCH_DEVICE_ID_2B02F0 0x2B02F0 /* Chrontel CH7218 */
 #define DP_BRANCH_HW_REV_10 0x10
 #define DP_BRANCH_HW_REV_20 0x20
 
-- 
2.52.0

