Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9F0C2D0CE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 07:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9245610EABE;
	Fri, 21 Jun 2024 07:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NzemIdTj";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD4710E86C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 08:49:49 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-57d07f07a27so573839a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 01:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718873388; x=1719478188; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FCmULs7Ip+T4HEzPRhfMxVMy8WCUz+1jGV/C4njJqXM=;
 b=NzemIdTjIjLaNUZ0BR2Og7t7k5isij+kzg2hrSkIYQ5GKbhPGsTaB4eX0hen1lOQ9g
 3NxANAOCVmRCV3p61mYw/mTKMDGaN72cbOA0CBauHeSZRDGMlC/zvSmN1uNiBPyVXOoS
 wG6R5em3EctNxojpuwj9AY8jgbIsUrxhjA++TF8+OhuI0gA3kIng01Ay4cyXyjrOEMCT
 64dEe4l/QXq2jmpitCxD7xZKCBr5wiXTqVUWwl/vYoA+0YWjjXvKoKEkqRro5RPQvc8q
 qub9EstmHBt4MQb52kP4QcA5MZxasyCboR03xNpseTyxqGM8YjYx+vlWBCmhra6pm7RT
 tSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718873388; x=1719478188;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FCmULs7Ip+T4HEzPRhfMxVMy8WCUz+1jGV/C4njJqXM=;
 b=QEry9MMXgjukZxmwnhT3bH81j+kQx8CI2LGuvJwAKvubXP2SUCvHG4oHGnAQiPLleP
 gQefDFdf7g0E/hFrNUfSoe6ZYq0tcWPaMjs9q0G2sCSfrqI6DeW8gwGAKzLXNM/O2MFw
 WCwLQ0GY4zs7WuNgbR0kUg1RQ/iV9Td260qKfIoLJsqCXoZ238NjoHK6UnJ22KVAj8Xp
 PX6tsXddpptgZBCewVhExoYQ1A20lo5GoAmbHtgJCFvCEjyxg+jBMn44PoBLA+06Tc0U
 hDBCtX2vf1VASB9yRs5j96Tw65IWlqbaJyqmZwNGiuqoIRYwZrWOmqVMrCGf7+UZx1Hj
 H94g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUFZHbqKCygd98ydGHDX3ADIRsNYS05GTzdY8YsQeX5sQz4pNiM18lEjfAyjHIUYMOp8s7zCqHX70CqcDYUNIZfPaIxr8WmvDutY0w+Q==
X-Gm-Message-State: AOJu0YwE0ZQ/WzoxO3pi+vYvcJ1lBlIz+unWs6hyJEf5/KIl/CF6KNFJ
 CyxQmjpzrqc3WxG5je3YBrViSSyQBFS4ej3Wuwy0JhwR82KU0O/PIfJCAIsCaO8=
X-Google-Smtp-Source: AGHT+IFjPo1mca3mlAO70SZGhud7FBjXkR91J2Bn4a2E6P7EwodOEE/C2Tdp9I1x/bZPTaMnkVihqQ==
X-Received: by 2002:a50:9fe1:0:b0:578:67db:7529 with SMTP id
 4fb4d7f45d1cf-57d07e190c7mr2545052a12.4.1718873387774; 
 Thu, 20 Jun 2024 01:49:47 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da371sm9318328a12.24.2024.06.20.01.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 01:49:47 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:49:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>,
 Agustin Gutierrez <agustin.gutierrez@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: Clean up indenting in
 dm_dp_mst_is_port_support_mode()
Message-ID: <a57a9d8f-40bb-4cfa-9dad-4f93a1f33303@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 21 Jun 2024 07:13:20 +0000
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

This code works, but it's not aligned correctly.  Add a couple missing
tabs.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 48118447c8d9..5d4f831b1e55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1691,7 +1691,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 		if (aconnector->mst_output_port->passthrough_aux) {
 			if (bw_range.min_kbps > end_to_end_bw_in_kbps) {
 				DRM_DEBUG_DRIVER("DSC passthrough. Max dsc compression can't fit into end-to-end bw\n");
-			return DC_FAIL_BANDWIDTH_VALIDATE;
+				return DC_FAIL_BANDWIDTH_VALIDATE;
 			}
 		} else {
 			/*dsc bitstream decoded at the dp last link*/
@@ -1756,7 +1756,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 		if (branch_max_throughput_mps != 0 &&
 			((stream->timing.pix_clk_100hz / 10) >  branch_max_throughput_mps * 1000)) {
 			DRM_DEBUG_DRIVER("DSC is required but max throughput mps fails");
-		return DC_FAIL_BANDWIDTH_VALIDATE;
+			return DC_FAIL_BANDWIDTH_VALIDATE;
 		}
 	} else {
 		DRM_DEBUG_DRIVER("DSC is required but can't find common dsc config.");
-- 
2.43.0

