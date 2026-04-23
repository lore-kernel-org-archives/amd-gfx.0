Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117E1FDEE47
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A22EE10F29E;
	Thu, 23 Apr 2026 19:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VIXzu+vk";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C215D10F26E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:38 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so3606940f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971737; x=1777576537; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGxBXZ22nFZhkm5QYoA2t8LuC40XkoBbRIa+rSjCTDg=;
 b=VIXzu+vk1jckC4Nhsdgyp3+XME0byynrEy9Eym7tIiGyuPNlEeP55Xs921qodsQSS9
 zwDJk3YGsWfNuiBZ/aVl8fULGplQXKpOqwJXpRyPUPdneQ/kFzaoQCk8TWY7tel5D7AA
 Q0DEtavbWSWQD250BB5BFYbcYksiA1YaMnZ4I7xNAxyqGF9GklTGb08cUv+P1QHl0VxE
 V+Jy7/Yobuo7vGdMp75dwaOn/Zvg4+D57hE+mENlbhQS7Y1A/T/jSLbNa6hYnM1KFraJ
 hCm6I5QKN6o+RjhYb/nWcDnR5UK9tVSEUhDmrVs95EMWOOfEbqOEC0bs9OSe2JH1xk/x
 CORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971737; x=1777576537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGxBXZ22nFZhkm5QYoA2t8LuC40XkoBbRIa+rSjCTDg=;
 b=Udf/+Wj8S+DJAikybNzehccj7GVKwpIET8GRj8ALu9LV6j4bJS5v2mRt5YHE+Sgjw9
 hg4CBJlKCLMYgK3UjtAUBDM2VOyszt5TDTWMI+G8ZxuKnj25QCX1riOZ+aKGYngptD4C
 +pp+ae+LAhmCCnUzcO7TR3sDShtwt65GfqvY5GhYgG2O6D++2pAsE55+s1fl+akrRPB7
 YpgJcYgtLlJq68GdLoLUKCWxwKNn1Xo5V2bTpH4PYU3p5KcQG28kff7tz1DPtooCMK6h
 zfB3mCOBUX9me7rAk02qHSqPdXirJTOG+irqU+bIxotRmu7SxemDdvGWz8C+a0h7wtZ+
 Gzkw==
X-Gm-Message-State: AOJu0YxOVXkHic4Pg7NyUSs/rgdjVVuFEGqFKPR+wLHBma1oFP4zZNJ9
 pL/EVhJTlUXLDWkBV5idX1VSEUypdL6ina69/HiROJ3nWzBJ7p7IUzHJ0lDuu58I
X-Gm-Gg: AeBDies2wPQpmtmLrMRbLLFLQCDRadvq5yPMijkXJe4x7OCk4mw9g7sGEzIKhjTN8iq
 zWttCM9FbHoNRJR6L9k88QcLMqc84/88IdXBCmxpA4BfVauV4L+UbpSOXbp6jq5nM0Y2sJ/GH8D
 Pk0Q70eJS8xCNICBpXZjPyHEYGEorbK+szmc3JHV4TDxZTGxSPiAkEzaiIZIj+uPt4ZNLPf+UXw
 fnTSX+oLrQJjCJ/pvO/2sF5xT+8pC/x3BppLLpApqr8EdmDo/VaSKRSpl6MDIXlFgX7CvMOsJwT
 35EhbdltccVkS5Lbff+1sZ+J/xdv4wTDXJf/fRxJHEhLeBu0hNc5hX8Z1zJwDSwA81k68VAEo0i
 WZIhRBXAuDFBDHuFq6RepnotDfsRmozgGPpxurbp1g0pbDnAOPnqeQi6p0otlaNRI2WIVZHWlEp
 HRNzaLrzUs3XSPou+tYUID8+uaFFF4AZ0CuUUtZOXBxR492/QDhf7ZJmlPxuOOax/ZoGQiBKJ0k
 KGJZQ==
X-Received: by 2002:a05:6000:186c:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-43fe3e0af4amr45072474f8f.38.1776971737188; 
 Thu, 23 Apr 2026 12:15:37 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 14/14] drm/amd/pm: Delete PP_DAL_POWERLEVEL
Date: Thu, 23 Apr 2026 21:15:19 +0200
Message-ID: <20260423191519.73127-15-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423191519.73127-1-timur.kristof@gmail.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
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

Not used and not needed anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/include/dm_pp_interface.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/dm_pp_interface.h b/drivers/gpu/drm/amd/include/dm_pp_interface.h
index 10747a1ceda9a..e3d40fb371039 100644
--- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
@@ -115,23 +115,6 @@ struct amd_pp_simple_clock_info {
 	uint32_t	memory_max_clock;
 };
 
-enum PP_DAL_POWERLEVEL {
-	PP_DAL_POWERLEVEL_INVALID = 0,
-	PP_DAL_POWERLEVEL_ULTRALOW,
-	PP_DAL_POWERLEVEL_LOW,
-	PP_DAL_POWERLEVEL_NOMINAL,
-	PP_DAL_POWERLEVEL_PERFORMANCE,
-
-	PP_DAL_POWERLEVEL_0 = PP_DAL_POWERLEVEL_ULTRALOW,
-	PP_DAL_POWERLEVEL_1 = PP_DAL_POWERLEVEL_LOW,
-	PP_DAL_POWERLEVEL_2 = PP_DAL_POWERLEVEL_NOMINAL,
-	PP_DAL_POWERLEVEL_3 = PP_DAL_POWERLEVEL_PERFORMANCE,
-	PP_DAL_POWERLEVEL_4 = PP_DAL_POWERLEVEL_3+1,
-	PP_DAL_POWERLEVEL_5 = PP_DAL_POWERLEVEL_4+1,
-	PP_DAL_POWERLEVEL_6 = PP_DAL_POWERLEVEL_5+1,
-	PP_DAL_POWERLEVEL_7 = PP_DAL_POWERLEVEL_6+1,
-};
-
 struct amd_pp_clock_info {
 	uint32_t min_engine_clock;
 	uint32_t max_engine_clock;
@@ -141,7 +124,6 @@ struct amd_pp_clock_info {
 	uint32_t max_bus_bandwidth;
 	uint32_t max_engine_clock_in_sr;
 	uint32_t min_engine_clock_in_sr;
-	enum PP_DAL_POWERLEVEL max_clocks_state;
 };
 
 enum amd_pp_clock_type {
-- 
2.53.0

