Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4FFEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 14:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A1B10E694;
	Fri, 21 Jul 2023 14:57:16 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281DF10E690
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 14:56:27 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b701dee4bfso30908271fa.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689951385; x=1690556185;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U4uPw584/Tdlq/aOQhdIYZ2NWWZUO8Cw8PlRqHsN9Fo=;
 b=JyXtdWR89AuYMt8ebkpbk25d7ot90wKR+CGZh/1m+KMCbvze89anIZrvUjPBHvPZeb
 4xr1L4z3DmX4K2a+5vd2Dmt2AHNVquvN6ej9C99KCBRussfyUuuqNAmuEKPyBx9jAl67
 9LmQvARZTDhRVVq9/xskXgkDm1AanY4JEeWveP6iicOEwbZTfh79hM+I+ZdDu6N9hWm0
 AadUtN8DhlZqXjGpCiI5F/gZAzMqHUx9G4PZrA6SInZOHc+lF82sH7jb6f6WBoplx5a3
 6kWrFO6DioTqSOOwPeykZSXEkU/1vkq3Bravdqwbz4Y1ydxHfbu25tTP5SROv2QLSlmo
 rqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689951385; x=1690556185;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U4uPw584/Tdlq/aOQhdIYZ2NWWZUO8Cw8PlRqHsN9Fo=;
 b=CDWW1cSKwJ8dcTpKY/s/WNpH/3esbgT1FHeo9lPqLMf8G0bbfGiHCz+8Ili/flg9Mg
 /K8p2Tkri6zABeoHBqBuBs5aof0t/wGZzu6R3jPm8lp8WbK/gzxiE8IcvMTAAVFqt0MJ
 lYSb8bc4Paxt1ph21pSMUlwJhZ/XAW9P98i/2zU0iRm84fTfQll5k5EXsyWQZfPxxLas
 L83/WhXKkHtkhYko0igJHyqj4L9VRP/CPMreE/XWDOFba2knlIR+Co3M/VZ2byF6fGq7
 Bm1mq7Wa1OtN/JCqdOoAMPNfPeaD9mt6JsyMec8hnletu3wI4gguVXB1FiyDSJb1w/sV
 rW0A==
X-Gm-Message-State: ABy/qLbFWbraCl6ttwIK1MDgOCEZmMk+0lmZgO51AulacFWWevjEt+fT
 x5Axx/C5DgttMlTNfyl9gO2U0Q==
X-Google-Smtp-Source: APBJJlFwVWEJ9HCYiiD4k+l7zWH5gfbXV1xm2Y6zHh5t+enoUzr93GJvhTbRarCClp80b1UNBFU3kA==
X-Received: by 2002:a2e:a1cb:0:b0:2b7:842:a64c with SMTP id
 c11-20020a2ea1cb000000b002b70842a64cmr1673222ljm.5.1689951385241; 
 Fri, 21 Jul 2023 07:56:25 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 q17-20020a7bce91000000b003f91e32b1ebsm6300279wmj.17.2023.07.21.07.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 07:56:20 -0700 (PDT)
Date: Fri, 21 Jul 2023 17:55:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wayne Lin <wayne.lin@amd.com>
Subject: [PATCH] drm/amd/display: Unlock on error path in
 dm_handle_mst_sideband_msg_ready_event()
Message-ID: <0a4b4a77-75e0-4a1f-a944-6ea5c75a2bb9@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 21 Jul 2023 14:57:14 +0000
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
Cc: Alan Liu <haoping.liu@amd.com>, kernel-janitors@vger.kernel.org,
 Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This error path needs to unlock the "aconnector->handle_mst_msg_ready"
mutex before returning.

Fixes: bb4fa525f327 ("drm/amd/display: Add polling method to handle MST reply packet")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1abdec14344e..943959012d04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -707,7 +707,7 @@ void dm_handle_mst_sideband_msg_ready_event(
 
 			if (retry == 3) {
 				DRM_ERROR("Failed to ack MST event.\n");
-				return;
+				break;
 			}
 
 			drm_dp_mst_hpd_irq_send_new_request(&aconnector->mst_mgr);
-- 
2.39.2

