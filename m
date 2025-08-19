Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F48ECA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 20:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75C410E670;
	Tue, 19 Aug 2025 20:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IiUQr4VV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1850A10E672
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHUgRT032365
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ovJO1XSWvs0KNakJASmsJP5sNHD1z0QwbqY++5/N+xM=; b=IiUQr4VV5TbyzTFC
 CN1iQjZqVwVVM/orFQS3P0PoGA1Pl93VgXACCmF+oOSbcxExjnyZ7dJ3BwVfTH5v
 vrol8L4OUtyeylkdzVy6WUHuRUHtXyDqIfl0NsIUzsrltwZ4xUEONym14TGAFzRS
 2Z5hXD+tfeEoZgOnAzsYYBYskF/9xEjZ+D073I0sE5Jl5QktSeP9/CXkALhB7/Zd
 b1JTJ28dkpcjZbHKQAnz6L2UDY2CtfpuEgn/u7P/15NZHnIVXUkA5sCc0IQe1i6r
 q78OjlfhywLdgYVAydE6CDO6dF4LMC40FcD9NfdjFLtBPF1D1ZJjtNKyRezZ8qpT
 jdN3rg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2uhxke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:33:07 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70a9f562165so205815256d6.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 13:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755635586; x=1756240386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovJO1XSWvs0KNakJASmsJP5sNHD1z0QwbqY++5/N+xM=;
 b=RrI85UbWXcCqhEpDNZ1QUtA9qwZDQI3f4PwZEWD7RXn+HB1dWcV3yQYAjU+Fi9EEdr
 VbIf4b18mUIVOZ7fM8JepK5bQdkKSC8Bfsnkkgay+TAaoC0lXExw0OnBRAgZCQRILwEq
 Cd+UJSHk7dGqoGkRxffWVYJROhMQdpEdg6rgHzIeI9QKU0MqN+3hsfviHj2w9kn2jbJ/
 5VTad3RDb0YWnGz9y7mUJjg7UiZCQbKxpMer4RzcQnjx0+/XzI+4ILBCBARozDSoNLQc
 LCnUaCxRiNtEwLjWlq77LEDRe/vIj2OLQirsS0IlsNXwyW5iEHjL3URwImAQ/OWcBbYU
 qg9A==
X-Gm-Message-State: AOJu0YzhNc7t0tjEuei5X8bGRupOi9amFowcLkOQ0bQXgKt8OQlKRbOW
 pFI3tsUTjAc7i/FJsgS5SzG0SfhnTd/umb7gWWLp+sBIJbvY/ay8n2z1nALYsB/ODVuBQvI6BsA
 dNGqnj/5rSu1XyQEnvNGnlAJS9Hgkmys/adqJImwgP/3g/GzdmaVeCQmMOa6pEkzf23cm
X-Gm-Gg: ASbGnct/PxtYEShLoQgw6BupRuU/wKyrUGOpnkSFR4SGqfsWUMdXDxyE7XPW9rTEwMx
 v5XbXCaQtY5KBoOjMQfzzlpds4os4eBf5kL/K5CrRlyC8e5GXUVfD8maZQRoc3/31h01bxToF31
 CFSTD4uMyBur6hJ5rb5zp1oLS9BW5vfc4iq6rwrltZMTabFd/GpDFSv+Ono8j/uEqCbksn1868R
 S5GWDKiMYZ/mmhKq/04gDBf3lk5QTD55Ds0RUXZ1JJx6eFr17nf4/45kBO2lxk+CZlGam8ryoV4
 H2TWoQrBrOMnxU/7zjOCdAK92NAjg8hPJoIea8wqF5InJEoT8Rv2SW/EYf3MDhQTgacNbUMtI8B
 LFJunD0n23tTS2w+795XJ+6KIMjvgXM6iEh3tPGPfdb+E22V2MZ38
X-Received: by 2002:ad4:4eea:0:b0:704:95c6:f5f1 with SMTP id
 6a1803df08f44-70d7709978fmr4710206d6.34.1755635585916; 
 Tue, 19 Aug 2025 13:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExtlapPhC4VdvxehLvtICbE+wf4VkX5gXmldiks/+ryTub2wDdZG116DcdFZUySCphNajoXQ==
X-Received: by 2002:ad4:4eea:0:b0:704:95c6:f5f1 with SMTP id
 6a1803df08f44-70d7709978fmr4709826d6.34.1755635585259; 
 Tue, 19 Aug 2025 13:33:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55cef351806sm2212969e87.13.2025.08.19.13.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 13:33:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 23:32:55 +0300
Subject: [PATCH v3 1/8] drm/amd/display: use
 drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-wb-drop-encoder-v3-1-b48a6af7903b@oss.qualcomm.com>
References: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
In-Reply-To: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pfarMdKTP3PKuK/rYN2PwD9JvqS3ROd0ZonPoWJ3yhg=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ8aS+zVx+7sDXTal/otbFF9xSvEB653da1pVu5wcjWZwb
 P9p8uJUJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmUqvC/t+J/b2vPYfQ9w8Z
 7fcdbLozXYrsLgarn7RWWJkyI+udhmF3TqT3PPkPXdKqr98e2FnOcfmUBZvjJ+OHMwzU1X+XzH4
 8c7+pkaBR0rXaRzuc8vSXn3diK2C38P76+qyPl7q9wOZFYfahPLmCqbfOMi/xPHvDW2eKlkVy8Y
 +g9f5/Wd5z/c26m3dp6yIb0RI+2eclWryLDPW7Mwu3sSZsFb+3U9X47reNOv5+gmX68zVeCnmUG
 Z3dzGW37vy7Mu6zvYK/753+cDXLcG25q4HNr4XPLrptYufLDu1/981izUrO9Q3xVyIvLYif9lZf
 LCz2it/0pWd+3vugZlfn92Vhc7tUC5Noamr9xabCb2XnAQ==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a4df83 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=M-qvw7r3wQx8XY5Jx90A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: YEXpnvp0HjwT61S-q3FVcmU83PWVGq09
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX+xgWPWjwQOK/
 qyRmdhjJOCFhC19ln8TLn8NlCGO3hRA2FVE5dG2ZJ+Dtd+xY8iSYbdTa/t0dObFsn1wKdwp+tzk
 tWIp3y+5gV7rjORfuTYRA797C2NPD1rZCqMtsMsMlg3vAYeoC3ma3rNoBkiZ1anIHOmDMTwSEoF
 hchx0kHf4kX0jZ9qMS9V1T1M1fusTrJ8ytEMyM9gtq5LuaelLU/Fzv9Oil1OROzz1VyuzxiG9aw
 7+2XBxWnAiMBtM6tSQ/PLG6CexSNsxA8St8mD7B89m4kUkvRT//kGIMr6PeD6dqULKnruCb+r/M
 FSzIZa5oxma5+Q6BKnaUXAapeBM2KMwQcFzs3mawTk2gSl+gCIZR39dpMj22SawbIRxppDqMwbg
 6qpRqXJr
X-Proofpoint-GUID: YEXpnvp0HjwT61S-q3FVcmU83PWVGq09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031
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

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cd0e2976e268da41f576624c50ef0c76ede67414..0c9d347b1efc804a28fb3095df94e543a19e4159 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10006,7 +10006,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 		return;
 	}
 
-	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
+	acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		kfree(wb_info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index d9527c05fc878ef6916782ff9fde847813938461..80c37487ca77c0494eaf769c5b9a3c53486aa52d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -171,7 +171,6 @@ static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs =
 
 static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = amdgpu_dm_connector_funcs_reset,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -190,17 +189,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 	struct dc *dc = dm->dc;
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
 	int res = 0;
+	struct drm_encoder *encoder;
+
+	encoder = drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &amdgpu_dm_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
 
 	wbcon->link = link;
 
 	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
 
-	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
+	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
 					    &amdgpu_dm_wb_connector_funcs,
-					    &amdgpu_dm_wb_encoder_helper_funcs,
+					    encoder,
 					    amdgpu_dm_wb_formats,
-					    ARRAY_SIZE(amdgpu_dm_wb_formats),
-					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
+					    ARRAY_SIZE(amdgpu_dm_wb_formats));
 
 	if (res)
 		return res;

-- 
2.47.2

