Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F89E92725
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Dec 2025 17:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAEE11AF4B;
	Sun, 28 Dec 2025 17:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BEwij8f4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PxG+ml9g";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EFF11AF3B
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:44 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BSCNUfF2857841
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QwKCOLaLwEVYb/ydqismQTZCLmcdjRauyMNTqQmx16w=; b=BEwij8f468punwq6
 urKJB9CgqrOEhjKjBPwBBQXG2Ilhu1me2Y8M2L+iFIkvhgwNJybHYhrBCyDkvzOp
 jVx5gZ00XNtkC7J/J7VguH7FjCj78ZFy2j+LVOhNLFfRYXYTgJ62udHdIwgIo3sr
 3221YP2zI1V5Au/JthDmcXGCuik8AcGoq9kLIAP5RwhdRtLDvAsp2zc/T8vqth+1
 eZtJvqyr0V+idOdxnbYqL2mGH3JXZ4lAuNnt09lwMr06yJ0lIQB3RdC93fqswMGB
 xXPfIvwWnEvqC4V8o1z544t+W/lrFu15e9AQzQWVPOQhTxXnDdZ4JsqLkdRg3Z+3
 lEga1A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7hsafvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 17:21:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a43d4cd2bso108682816d6.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 09:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766942503; x=1767547303;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QwKCOLaLwEVYb/ydqismQTZCLmcdjRauyMNTqQmx16w=;
 b=PxG+ml9gYY9X6Fzqh4dhEzICqDHHx3vCw29BaAvykondt52GH87lIrFYYahINhhHCX
 eT2LeWAxjz1I3t0yfE3DHt4EsfmWY25JwXfXeR9c8j9V2PFpsM2B1Mkb9++kRE8VGp9h
 U/OZ5AIkCcHEv5XsuxmEHgB7PyjElk+6xyB5L/PHBhinl75vdj5C/tn01rNJNTr4tGF8
 bMRqLJpMr4lu75bj9ZY0ISdJcM0A3vxDrKPxBvsHaJqVoGKTIb5p1UjmipjGIwCcKd3z
 Y2UO+/EjBgHLRNlBuJucH+ExgjoRRhpXENjAl8fTuu3T6s5IjM3z2zTfCH3TtQOO5C6/
 CsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766942503; x=1767547303;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QwKCOLaLwEVYb/ydqismQTZCLmcdjRauyMNTqQmx16w=;
 b=gAhz+fzotSrt5REIfILsr97HQI0zxQF4v73xsWwvisHsQmE/F10cdYvYLwQs2EL01g
 6JyTZSOuHyaoFqFU5C/xNSFd3tHhfB3j0D0quz/qKRotEyY1pjrjSJTlMX7wseLcU9UW
 YhKy5uPnzTnw5QvxSrf46npBIg+SZbe8qIa97e4fU2T0pLxgYIR1RVDzHM5v+3rGI0Q+
 LNbtP6flV/12C7+IxYyGuKMZ+KkXXlo4/mLEGTE2JKUvKoLTFyBdOrAHZycQMacQRqj3
 dfVVUGDvpVE41PVcOuFxlfne/PTOz4pmNfRszIt+ovapsMsTFRspy0XfAUnGxUbjdy4Z
 AJjQ==
X-Gm-Message-State: AOJu0YwkBI47iFr/YJX7QX26kRF6mis2wYJ5nLMNVVaJheEDcJPj5K9W
 dbLHqx45YIYz9Nmpw4HE9TfEzKGBWpFsY2ygrrKEIu0cw6d4WnQw0YEHxNQcMQ9rYYHP+vcx+62
 YqW0VHba2576oEr+Ukt6DhnNhmI3WL4qe2VBYZGxGawIHUpz9dgTxsh0iq7zXJCrSLjtA
X-Gm-Gg: AY/fxX5FimW2qC//vv0X10pvJpDEvOc7B2jha9YwqBCLlUGVnpFGynpWBUfc2IigkyA
 5nuAHLjrSIYCtOXepnAlZJuHvNWrErz2eqTch2C/jp6T2uQz7tTKT7k4naJBgRiRd1XoZrUnc0k
 56thLaOlndVYBzmtCoFiFMg/DyPh0LIdRpfIivFFr/vGH/XEg+xn/ZRRgpT/WWxCGD+nG0DgFTR
 f0zOoaJ/uDMmW2bxetoAl8k2LmHXZMyDzERr5K1oqVtz3tNIJfp/MOTsn1EfJXFoPWR/5sx8RJJ
 /GoANyWSZvEtGB4obwDZvoAGvwkvsbvOtOefBqzoPMtg2KjvEkmboyw6k7T+asWgwdduVYw3xNH
 4bnYKVMynUPoen27vedO7F3wdSAhWBnnw4Fhe9bwEAMquS64HBBI2WiffApAu+wCsV6IfhowiKf
 CBWmwBHyzpuBHsR5az6ynFiwQ=
X-Received: by 2002:a05:6214:14ac:b0:880:48bc:e08f with SMTP id
 6a1803df08f44-88d83793405mr311516496d6.40.1766942503353; 
 Sun, 28 Dec 2025 09:21:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5EUG88eN7xWHCQu1kB/Om4DasLN+n2uCUeGVvVxm3AjAOh3j8JLRR73QWpq6YGG91jGc5zw==
X-Received: by 2002:a05:6214:14ac:b0:880:48bc:e08f with SMTP id
 6a1803df08f44-88d83793405mr311516016d6.40.1766942502851; 
 Sun, 28 Dec 2025 09:21:42 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3812251cfffsm76871031fa.19.2025.12.28.09.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 09:21:42 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 19:21:34 +0200
Subject: [PATCH v4 2/8] drm/amd/display: use
 drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-wb-drop-encoder-v4-2-58d28e668901@oss.qualcomm.com>
References: <20251228-wb-drop-encoder-v4-0-58d28e668901@oss.qualcomm.com>
In-Reply-To: <20251228-wb-drop-encoder-v4-0-58d28e668901@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
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
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AhjL5n0KqMn00LisHx2T5B6vTrBvTjUUJYkgUx2rS80=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpUWciqEro/DFsCfKaexLHG7KTjaJzdmaEO/86Q
 /tztctUKI2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVFnIgAKCRCLPIo+Aiko
 1ajxCACH793b0lsnrCbvP33cFhq6yL0q59eHuPMhmnMl4PbAf74U2q6vkmuhCLbqWCyjjympkm2
 F/QcVzF6/2fMsBgWaxsNYMVRtMEayNK7VupJM/1PgLNA0wAVIhFcD1nGQ9aAoIUL3hD0ssjtLSE
 9+AjggpuA2/LVew7AVfi28UvHarYVEjG/cdGTOH+shJS4pH7Uc7xY64PV2WAV7gcxdIF6LMqZF8
 zVkVffrU80TTqtUmnaNTLFzL5KTn2ydJbita7NEyIvP5RCWD2I94OLeJHb90rtbkm2B4OL7NFwl
 y1FdVeZNaoJYHJgm5XqKdUx1uN271EkIn8vhU3oofzZ79v+n
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: pNJoYE6fsQCc7imiNF2pipiCOuVMG5sd
X-Authority-Analysis: v=2.4 cv=O4o0fR9W c=1 sm=1 tr=0 ts=69516728 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=8cP71iSYcfV9S7Y4u-4A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: pNJoYE6fsQCc7imiNF2pipiCOuVMG5sd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfX1kn1n7PjKYEA
 tjKDONMxNDlQWz4roszNr4CwL06eVv8cTjdhWocQ6XOV/KOFDYfE7SJSFbe0AvtcjsspKaVp3h4
 dWFpZCtaP1EDyVXjYFdFQyIIMzqCYLh48RpcsH7XtE2+upgCDppSYa1YUBmTLfdOosjI3ENYBe6
 oEnZrQJR67OcQujfMH+hwQQIyd3M0F12vz7zyCmLuYF6U+IMDPGD2T9cYDAUFNMZYj2s496wHId
 1cE15U6gnopq8kdOdWfaZcE2y6IolD4PfIEVnFfA9QIP6sY/DPDE6e1oCS9ISCpK/LF+q7FtgU+
 PF5Ea8Tr/YYJIcO8znzhP5IXLu1394/RgPWkIGV9b1uIB2jzJBqa2xICsc9UPSXWyKYYu/gY8rs
 zJXVu+H5f5zpZRdn03JDLtdsVpRqhreKW5stv3/U6kRSvht9bgYLHsdG/fLuYVDM170rnotzaEC
 BaMcPpf7Iz1mHtOZF3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512280159
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
index 740711ac1037..45b3c8f16b23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10570,7 +10570,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 		return;
 	}
 
-	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
+	acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		kfree(wb_info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index d9527c05fc87..80c37487ca77 100644
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
2.47.3

