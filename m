Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90199CD4F57
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F9E10EC08;
	Tue, 19 May 2026 10:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pz+lAxKk";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9417F10EBFD
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:37 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso24375645e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186096; x=1779790896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jq9DQU9+7CWNdt7Tl1OTcUjQ1o4DT7lI+wb4tdVU/6E=;
 b=Pz+lAxKktfWEqAiuPypCD8c9Gl7HdmvC3iYiTE9Ed+Yhg+d9LdMqIgT+cqgtNe53JI
 MEIn7BE/nxDuJg+qkbghvN10F5woJcrGsLCjXK7CY6ZK7SyB8730WZTXatMW0t7JWKTa
 qL4FGu3XmGEiz0/NV49Chy5PmG/fMoPDMiQS5ws5IfFJlLZe/b1NoPIE5uzWYlVTWV/y
 CJ7qYC8vJ2EBplQNzm54F+INgSeFUPu1cJsAGg5dw342KDvCQ8BSDYmmPYzUZ/rrJUTJ
 XHoSa1j4Eq9nuxTDpPVX0dQ9cdN5b5FeNBClGa9jHXhDfFe0yv9v10GDLsHDlNUxULoP
 GJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186096; x=1779790896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jq9DQU9+7CWNdt7Tl1OTcUjQ1o4DT7lI+wb4tdVU/6E=;
 b=UG8DJ17JmCF5s2MLYNp1YEZe+pV8rhLce7BDIcZFEwUg/6EuyUZv9KbhR4yMJURfER
 yPZS7O+U7lNcfnfyp8lkQEN+2EYdsRFVn4DLSUofPgxz0QZzhqxYlb7uqqHbOZLvL1jD
 jgo9XPY2PfTULk646siGzJ4D70AaWETmjYlPhx896myAyVvvhvV1vV/+ZfF0WAoBjwIR
 zcuJZ+KpRO50P15JiaXYMo2EIH71+/lpk4YkQ6DYLygwb28l183qcpbBsVMedn74WHli
 5ZPkW9qiCwvEhoU+Qshu20H4kpTK//KutmUvlJNhdmTUCY0MlgTLTkxfi8+uF2OCX7tO
 IKwQ==
X-Gm-Message-State: AOJu0YwHJoBBdVO//dhM3W1VR2mrQ56SP2gKrHHxrox6yO7hSjgqa5wE
 66/4VwMuwYm8Boo3NIGmqqFbH81frK+kVRn2jWyen6/DdxvZ46y4+G5DyKu77MRY
X-Gm-Gg: Acq92OFhd9+16cUdgZApWPcdjpmHB/1tFgXO3gdQ1BLvWDShTA1WuQt05t9lm/fR8ra
 nauS/PgRbMwX9WNGnDcAqcczdCiXWCLphoL8Q7Je/5KpXEnVVOp82W0tjvhph0vdsB0L7O2/QTs
 lUTMwakPZYNuFlZLvbf9KttLBtfTA7zGGw4LZY4v0q3rBiyR8k7N6L8uf6So4u3BviayMAFyzgd
 qtwskfRNILfOoAoeRX8urIDExaMsHKZgTrPvrL0cVqQffsTs2sSvUm6wSNkmgw7TX31I6U8l5hH
 pswBxpbuk0MBYBlYX6aUahjMogQ6wlhgd4jaKMB3APeYaZRFFO6moSaxkZjyR8jhLtGxaKM8C9P
 LiJxIv0i4GpQ2nuORg2UaWigESKZpbqPkUbHlhetT7B1MxE5VMzdgNywLpt9rtyV/9d09djagWQ
 KpX+N1Y7Gdoodk3BoBrLJkxwkWUVaeTin+V3cePIkmbzc9aczGrmlRP9xsSH0XPnJb
X-Received: by 2002:a05:600c:470e:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48fe60ea590mr274201575e9.12.1779186096081; 
 Tue, 19 May 2026 03:21:36 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 14/14] drm/amd/pm: Delete PP_DAL_POWERLEVEL
Date: Tue, 19 May 2026 12:21:18 +0200
Message-ID: <20260519102118.246466-15-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519102118.246466-1-timur.kristof@gmail.com>
References: <20260519102118.246466-1-timur.kristof@gmail.com>
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
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/include/dm_pp_interface.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/dm_pp_interface.h b/drivers/gpu/drm/amd/include/dm_pp_interface.h
index 10747a1ceda9..e3d40fb37103 100644
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
2.54.0

