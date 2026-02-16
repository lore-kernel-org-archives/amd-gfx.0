Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63816EF99FB
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418C110E473;
	Tue, 17 Feb 2026 08:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LsxCfHX2";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B551610E3BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:35 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8fb8858537so59945266b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260334; x=1771865134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGNe0DbosFuyf1BzABz49JKUy3I3J7cCYNl1QlycPRA=;
 b=LsxCfHX2bRZbJDfz9uiBlCrWv+M/8dNFzw4ZQzMQOMeWyTJy7fTP1XoljdP0dG/Fzj
 eHP+s97xSWWGs1zVK5RNeMpMBVLje5UFjdRnoGjvZ36EvatkmnxfXMaLCzvlqcWSSoil
 H0UaE5/Z2NYdFAIYfNnVwAccsQmcPkk3HhRKab0Nln6KY1D2V9Bu0sLzI+1h7MZY2d4E
 PAtIkIFMTa+BD6FAl6wfGxAEjaZg/u64CRJeQF1S3gUZMJ6qLOBzPKc9EK2es0qNQEJM
 0bgy/6kDzNyfDLln57GJq1C9JfDrt+fXJDF2bfbWorqMGaPdYfcTtaVo5hgXC3xwHG+f
 4NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260334; x=1771865134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AGNe0DbosFuyf1BzABz49JKUy3I3J7cCYNl1QlycPRA=;
 b=AvcTjIANvtTWa8uFPWz7w1f4gYkFriWm/WSPGW8CV02D0sWgrXXmcs6xoxA2U1JbR6
 Rn3j2RA9X5qwm2zimnQwwlIw8Jghwdt7/TnyYNPFrL0wBU5E+3fY01mEsj+x2soYYeYX
 I0HCxJ3CXeHU+W3BOC49Rld/HM3wWCC9RaBnm13jFJzvYFIkgHIaDygcqbXGJ3da2w59
 uUqgfcMlpuLNc5Q5jlQpdDu99Fewg399N3LW1nPZHUFpNjIIWOBhBtAwiG4y2s6t6uCy
 EwpREWJu8kD+aJXST+wiRlhmEANds7g1xVYlqQvg2K2PNQYFIWUcv4K6S1JJ9QmN9od3
 GRiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5XHhHfWeZvyIOK3sSrAfZI2SOx5XKfuotCMRsgUVUjR2DMjk5DjsXre6brvkWy9kbyJN/qztA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmOrrjAXe1EDn98C/zFYkm6H8gW7M1spibJhjKiFCjnGzIo00p
 2xQpSFMcOORz8dVb4eSpbyybkC/GwNjgUXq2bhQNfnN1eXEQtw27L7RO
X-Gm-Gg: AZuq6aJbj4IF3xu6mWMN8pRGwRQgKOpIWfnUjCkyhhHiRnV0s/pBNWgvrcWDytIVw5e
 vFWsS508neVrnyEKF+p2PHWgH8uud/z443Bzuk8HT4fbYgGcs2BC8rjagjnRHeQCIlT8pXNqI6o
 343fiMukVfNlKbgFpJnsb8j3WmZL5B24oA4VFfEBF6wvuxPhBSj7LRhh8xp/WG33xch1FfxnVsr
 9UtXwvxk4Sb+iEQtyHI836xU776xVzW8lu758Qe4T3jWJImudYqpcSS254b06tj0RuMzpySm5jT
 de0heTFCr9IR4VfjzVd5TyhB11OSG9AwDyexL+7iigT4QlAjbn9DD2HRxlLk6y4TRhl4yrMbYq8
 7iaSLaHJutfjJHB1CyfB0+jybl9o+mkTkbVZiYee6uXfgVwsJjJ9USK2ZIPXVysJnPpTj+PVRxM
 uK1FVJFNJ7SFm1kqn/C4WC9/uQ0oXr+MDUg5dR0N8sxrmli9ecPRGMSt6VI9X270i2/TgrTh4lc
 ms+CNabrtIfZ2M=
X-Received: by 2002:a17:907:3e88:b0:b87:2099:9f6b with SMTP id
 a640c23a62f3a-b8face2491bmr364254366b.3.1771260334002; 
 Mon, 16 Feb 2026 08:45:34 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:33 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 11/27] drm/amd/display: Add CH7218 PCON ID
Date: Mon, 16 Feb 2026 17:45:00 +0100
Message-ID: <20260216164516.36803-12-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 drivers/gpu/drm/amd/display/include/ddc_service_types.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index cb8a2855ac10..690558584a0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1396,6 +1396,7 @@ bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link, const struct drm
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
2.53.0

