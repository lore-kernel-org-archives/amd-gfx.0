Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DE2C7EE2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 16:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DA810E39D;
	Tue,  9 May 2023 16:52:30 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F01810E39C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 16:52:28 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-94a342f4c8eso147437266b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 May 2023 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1683651146; x=1686243146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l/zUwg17n6MbxLvNCKWDWOw/93Sm5viSmoaLZsakTHs=;
 b=RMAcYjnYOvfULPo74tvtG4tvqGL/bM/xxQuqHqRGbOy0Jn8GUjRrSIARYXQ9mBvzHq
 7+og5NMtjIVGRY+Z6NO+v5fa6B8iLMUspI8dL69D69ebA1+HxoNkVAfYYxUKkyeMaQty
 +7gFQBL1n56amwNghi0WxuA6asGffywaLPH1fZZf2RYrs6L6yaV+jsXjVrxnZVUDJ2J5
 9+Gihdd3e9gk6+d3BXqI2YmZIz9AHGNdllfmqbbdgqZ9htCy7z58IF4lsizBQbLelEtz
 DmCBGtxFjJYvIzLWyAMHbbkv0PplSx3YQlLIcOhZ9mNU/zVtunDs7dwNocqMeeJSt5pE
 vUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683651146; x=1686243146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l/zUwg17n6MbxLvNCKWDWOw/93Sm5viSmoaLZsakTHs=;
 b=CbIjyLYKy4MUyHI2XtKFcelLtUkb8+BVjdVHLNoLFx6PGW+nP4bR6EK7DzFz3PZjFr
 F3GcnlLe5ro0WfN852Sm4Fhu673UuXYgfhzgHGmtJRAdW9vJV/BgT2dGtz4/J9/rp/Tr
 XsfFrGErmKSOeVF1Cgoil2jq7c6OrxgKFP9r7s7/elkSDFuL5j2dR0+nxn4os97KpaMi
 95EPzQ8l2SHgvpL6Svf3U6Tu5XispAoBZDLrfuPi1W3ZTDLuqpmXVnNTO5ulqJwMWl32
 yDUezzpS6gYfGDXg8G+X8BFm1NGUcCqrO8wYNXBaD6ZSi56t8V+0j6ik3Xtl0aU07QZm
 161w==
X-Gm-Message-State: AC+VfDyyonYM+Ygt8mq8fCPDBdBPqde7luLwYPHKSynQDYp+su01J3gu
 p01s4JWcOBQfoEOjXX7Vz3BJdkMCL5yFORyRSLo=
X-Google-Smtp-Source: ACHHUZ5XlzCK/w/vp8GnSFk7HVy3Wt2+aUDz/RLAJfq6mvoU+BZbk23D9ec4G3DpAsM4uooox/Kzvw==
X-Received: by 2002:a17:906:1d4:b0:953:2918:71e7 with SMTP id
 20-20020a17090601d400b00953291871e7mr10892017ejj.5.1683651145815; 
 Tue, 09 May 2023 09:52:25 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:180::a8])
 by smtp.gmail.com with ESMTPSA id
 tk13-20020a170907c28d00b0094f185d82dcsm1521337ejc.21.2023.05.09.09.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 09:52:25 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/gfx10: Disable gfxoff before disabling
 powergating.
Date: Tue,  9 May 2023 18:49:46 +0200
Message-Id: <20230509164947.455753-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise we get a full system lock (looks like a FW mess).

Copied the order from the GFX9 powergating code.

Fixes: 366468ff6c34 ("drm/amdgpu: Allow GfxOff on Vangogh as default")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2545
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2e0234b43f43..1d164ed2a714 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8036,8 +8036,14 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 7):
+                if (!enable)
+			amdgpu_gfx_off_ctrl(adev, false);
+
 		gfx_v10_cntl_pg(adev, enable);
-		amdgpu_gfx_off_ctrl(adev, enable);
+
+		if (enable)
+			amdgpu_gfx_off_ctrl(adev, true);
+
 		break;
 	default:
 		break;
-- 
2.40.1

