Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E21CD0434
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 03:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD94510E1B3;
	Tue,  6 Jan 2026 03:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqVmyjmv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MEwxjz5W";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7AA10E16C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 03:10:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6060o6Ug2888454
 for <amd-gfx@lists.freedesktop.org>; Tue, 6 Jan 2026 03:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i/ZE9RtLemTsfDhGA7S/TMDUgGHbHWM5z3Ovm2RpDnU=; b=iqVmyjmvarYskCET
 XopyhP7TvNVn+OSDbG75jjQMwgINvVjmVIEzP8R0yFt8oespgYd4BxiLUIjfVRdX
 7N8QWATyHpn8Xct5g2HUw/gN3pLSEvg1PsbohufeiLNb4ZUjWlepY0ZMy6NGZHLp
 d0XXh7r1cYFKd1oK/2o27lnWm4jCfd3vtQTKMCYBEWKvAEjWsE1280BIFqLmlJf2
 0QneHyHIemY8FmNpixW6Ze0gTLOrCpM3UfYlmHpETmxqxGAoTzeQEn0tJi3pMoTX
 K4wp6fWf44KSu7E5HRKeQxWMo1qaRIZRwYyHoP/XFv8GbWG/pe7fqQWsCL39/gbn
 ni4LpQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgpnd8h5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jan 2026 03:10:04 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a2f8e7d8dso15962536d6.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jan 2026 19:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767669004; x=1768273804;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i/ZE9RtLemTsfDhGA7S/TMDUgGHbHWM5z3Ovm2RpDnU=;
 b=MEwxjz5WF2jc6rvl1EuDJBx0uUZpF5GoKK/PpPBWtfDB7XcJTs7gxW1D0CNZR0tkwT
 OsOtM3moBbtgJD8/0Zu4ydcth2j7WgsN2AicpEEmIC8Hwy9sDLlgHX81yEscQkJxRnW5
 7BqFkJ29nWU6twe4qqb2GlsgzDJCxbnsjwYX/PMWCVf/Fk8BYzHsHR+TxcWO0JTWw4NZ
 6A0PVPKeDyzL2MWVjdkDP4pYSESBU9oDxTMdW2j7MmZFVRdtIWyfHTgLshZXl3GWJatW
 GDfqEbOO3dSIEquMhjo/ePSxhfrGpNt8cK6fQye0lEUr5iht63NTH+LVrtCDEJWXNJXV
 tYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767669004; x=1768273804;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i/ZE9RtLemTsfDhGA7S/TMDUgGHbHWM5z3Ovm2RpDnU=;
 b=eOSnB+d4yjhMTNdFLXURoQ6swD+YbTusxP51a8QGaR0hp5i308h9xGDWFptD3qhYiE
 v4W2TYNPPyNf4w4XRM9wCxBM3y+UNLKONnGUo4JQeH827JBOvE2v3Gpd2w5Rs7UcQJYk
 vvufg42wkViCOuom2AIDjHca08e17aEMDlOh7QZq4vN3niD4NOFF6tBxyQ7zbLFAcze+
 QUh0Ys6RX5duO1NctyNViZfyhhgS3GuSqlwBKMeAYciD4hgqf2V1Nt2RrWn0Pvbxe1p/
 gemAeAEl+PT7asTo5EqqGzt/ItUWj4CZmg7yoM+5zeTl2yvTXz5XO7q359XjjoyGfw9e
 eDBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2ldPus9OwkHPS1t2Np8oFmfkfoZLb0aBy6YWWLgAVWngtkhxOghpW/67mfK1c5KvnsfEPuROv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4/sEJRauQ03NpifWbgQpHAYkdEEjgouVGp5fDiMlZig/67EYc
 8TRBpFJWOE3VQJuAu5dIIWbui6oARMhyKvzNHItZYTVsM5YySPCO/GEA3hGB7Z2NKXqhf4fXqRV
 CmSgvxUoDFEMhOk4NYiiup3QEBIfqV389k7/qTjecR4lXjZjavpwTr4qwHpl+AbCJp9Vi
X-Gm-Gg: AY/fxX5ehhuF3VsoinEeB44MSE5I+2LInABYaWD2BhBugcVUIn0AtFzOqvT9w2lfT7z
 69vrvddC7aWAOHZruBKJYH7H88bbIAQ08S9rWM9eAc+l6QC2Olbo/PCgxNSve1BmL4538ICkT0f
 9AhESFc5hWjXqKlfGMCNCzYsYphy8V+yjBZ/JNL2AWVrS5FxcgUcQBUjfDq9S8lZSceKKl2B1el
 BT5uCrZtMMn01ISbu0pwuj0phDGHG8aC5RrgxI4MtVO7kXIhAr3YOyq2H1iuF2I2terWbjv901x
 0uyeu1BrMj3sG9lk3aNEk5cbdqezVRggNw/vS9NgYLD80VRuUR2e6aL1NQzFt5cHV8h2l1vm4gc
 zmfUu7UPc5dihckeUn46Qh7kxQPlx2gcjDc2YhrasaHpTry9yUkQCFuMZxzjanLc3IEIe2AJGSt
 LhJtvlEO84ntfdcFXQ5rdnZGA=
X-Received: by 2002:a05:6214:cc1:b0:88a:2444:36e9 with SMTP id
 6a1803df08f44-89075edfd93mr23664646d6.67.1767669003706; 
 Mon, 05 Jan 2026 19:10:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUbEw4dDpAlA+E/+QDVLYJVJTnPodAKfEcOQtXRN1eWx9cl9lcmjGvedKs7jPeUnxVSlp1Pw==
X-Received: by 2002:a05:6214:cc1:b0:88a:2444:36e9 with SMTP id
 6a1803df08f44-89075edfd93mr23664366d6.67.1767669003155; 
 Mon, 05 Jan 2026 19:10:03 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59b65d0d22csm242869e87.37.2026.01.05.19.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 19:10:01 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 05:09:56 +0200
Subject: [PATCH v3 2/3] drm/atomic: add max_size check to
 drm_property_replace_blob_from_id()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-drm-fix-lut-checks-v3-2-f7f979eb73c8@oss.qualcomm.com>
References: <20260106-drm-fix-lut-checks-v3-0-f7f979eb73c8@oss.qualcomm.com>
In-Reply-To: <20260106-drm-fix-lut-checks-v3-0-f7f979eb73c8@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7371;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UkO7gGzz204YJlbpHl9qFMBJirNFYawZoOhKgADqEnM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXH0DDblUwoI2UVGbb37850iZL6ICDxF3WSFiv
 X6LDbNRXU6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVx9AwAKCRCLPIo+Aiko
 1dUSCACM5JnNkCjR7xv/Iuq1XrLGYxgx6TKOoOFudll5tDxgBqKKQbb4mlfGqVgBeUlvty1GBEJ
 KlkklAdBYvQwbJYewszXD4vGy66zGeW+Q+wLwyEcVd1LCJ/TGyS2JFikJpN05fyvGx6W276Lrzy
 iTzFiz5t5JsZ+Rj3N8J88N4qLN2MAle90PBMUYHKh++9hm64hfasrUn6u73XwnIjMyjkFg9dWIV
 6YpwNU7C7ypvOkgpjEDQN8CcZU5IqbVAcPwPj24N+Z8/0+5QbxdVM9r608Oreb6VgpwOfVy/uUG
 4NjwGCpUQGKAw6Q/w54N4SK2nT5JPprx60ZIVRbJ1cHSZoye
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: xJLZL2fe9a-Os6ci4uHaMneGb8TGgFRK
X-Proofpoint-GUID: xJLZL2fe9a-Os6ci4uHaMneGb8TGgFRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAyNSBTYWx0ZWRfX8243Gya2SPTp
 VKLWTwuf0QcCDuGpwLWuETt8CjYQk6zgbwnXUJbDVZ0k22CuS3qTmal5Gou/nF3Bw2zGYYkrbPc
 Mj1fkIYM0rN/TXleZHcvbfdY6FxToeFoCEk/owGJ8uaBAet5+4GdAMmXrrBogUpUlOl6SaqbJU3
 n6z1wiOcdzoNooSFnZ8lI9dk3lKPU/245YS6CgkGb977CvO0DQVbwC3X2PwuNowYA0wG3KEbCvb
 lCKETAEZtdBPnOaBNg45DZfYcqQ8+7ns+Imqjsiyv+MBsjXmup++ykeW8AKqW5tVxTGXVxhueqx
 mgusO5oo8rP17j+nVLCB60yx+20/RkYvbqhJ67XkOFuvG+QDVwtuOEEMZMGxvy/P2N63DKdaS8G
 OD/1ugY62sB1B5EbbXQSO7gpEfipWWMS++a14/MNvQmnRFcsQPqWQW6seQbWZGeGDK7Yh7+nIWG
 i32SMMFABTqm9msilgg==
X-Authority-Analysis: v=2.4 cv=Jpz8bc4C c=1 sm=1 tr=0 ts=695c7d0c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ySEUILROmfWDjamXepEA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060025
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

The function drm_property_replace_blob_from_id() allows checking whether
the blob size is equal to a predefined value. In case of variable-size
properties (like the gamma / degamma LUTs) we might want to check for
the blob size against the maximum, allowing properties of the size
lesser than the max supported by the hardware. Extend the function in
order to support such checks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 +++++++++---------
 drivers/gpu/drm/drm_atomic_uapi.c                      | 14 ++++++--------
 drivers/gpu/drm/drm_property.c                         | 11 +++++++++++
 include/drm/drm_property.h                             |  1 +
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 2e3ee78999d9..8c5912b59e19 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1676,8 +1676,8 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
 	if (property == adev->mode_info.plane_degamma_lut_property) {
 		ret = drm_property_replace_blob_from_id(plane->dev,
 							&dm_plane_state->degamma_lut,
-							val, -1,
-							sizeof(struct drm_color_lut),
+							val,
+							-1, -1, sizeof(struct drm_color_lut),
 							&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
@@ -1695,15 +1695,15 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
 		ret = drm_property_replace_blob_from_id(plane->dev,
 							&dm_plane_state->ctm,
 							val,
-							sizeof(struct drm_color_ctm_3x4), -1,
+							-1, sizeof(struct drm_color_ctm_3x4), -1,
 							&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
 	} else if (property == adev->mode_info.plane_shaper_lut_property) {
 		ret = drm_property_replace_blob_from_id(plane->dev,
 							&dm_plane_state->shaper_lut,
-							val, -1,
-							sizeof(struct drm_color_lut),
+							val,
+							-1, -1, sizeof(struct drm_color_lut),
 							&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
@@ -1715,16 +1715,16 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
 	} else if (property == adev->mode_info.plane_lut3d_property) {
 		ret = drm_property_replace_blob_from_id(plane->dev,
 							&dm_plane_state->lut3d,
-							val, -1,
-							sizeof(struct drm_color_lut),
+							val,
+							-1, -1, sizeof(struct drm_color_lut),
 							&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
 	} else if (property == adev->mode_info.plane_blend_lut_property) {
 		ret = drm_property_replace_blob_from_id(plane->dev,
 							&dm_plane_state->blend_lut,
-							val, -1,
-							sizeof(struct drm_color_lut),
+							val,
+							-1, -1, sizeof(struct drm_color_lut),
 							&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 7320db4b8489..dff1fdefcbeb 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -416,7 +416,7 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->degamma_lut,
 					val,
-					-1, sizeof(struct drm_color_lut),
+					-1, -1, sizeof(struct drm_color_lut),
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;
@@ -424,7 +424,7 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->ctm,
 					val,
-					sizeof(struct drm_color_ctm), -1,
+					-1, sizeof(struct drm_color_ctm), -1,
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;
@@ -432,7 +432,7 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->gamma_lut,
 					val,
-					-1, sizeof(struct drm_color_lut),
+					-1, -1, sizeof(struct drm_color_lut),
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;
@@ -587,8 +587,7 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->fb_damage_clips,
 					val,
-					-1,
-					sizeof(struct drm_mode_rect),
+					-1, -1, sizeof(struct drm_mode_rect),
 					&replaced);
 		return ret;
 	} else if (property == plane->scaling_filter_property) {
@@ -717,8 +716,7 @@ static int drm_atomic_color_set_data_property(struct drm_colorop *colorop,
 	return drm_property_replace_blob_from_id(colorop->dev,
 						 &state->data,
 						 val,
-						 size,
-						 elem_size,
+						 -1, size, elem_size,
 						 &replaced);
 }
 
@@ -876,7 +874,7 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		ret = drm_property_replace_blob_from_id(dev,
 				&state->hdr_output_metadata,
 				val,
-				sizeof(struct hdr_output_metadata), -1,
+				-1, sizeof(struct hdr_output_metadata), -1,
 				&replaced);
 		return ret;
 	} else if (property == config->aspect_ratio_property) {
diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index 596272149a35..955fa960843b 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -757,6 +757,7 @@ EXPORT_SYMBOL(drm_property_replace_blob);
  * @dev: DRM device
  * @blob: a pointer to the member blob to be replaced
  * @blob_id: the id of the new blob to replace with
+ * @max_size: the maximum size of the blob property for variable-size blobs
  * @expected_size: expected size of the blob property
  * @expected_elem_size: expected size of an element in the blob property
  * @replaced: if the blob was in fact replaced
@@ -771,6 +772,7 @@ EXPORT_SYMBOL(drm_property_replace_blob);
 int drm_property_replace_blob_from_id(struct drm_device *dev,
 					 struct drm_property_blob **blob,
 					 uint64_t blob_id,
+					 ssize_t max_size,
 					 ssize_t expected_size,
 					 ssize_t expected_elem_size,
 					 bool *replaced)
@@ -785,6 +787,15 @@ int drm_property_replace_blob_from_id(struct drm_device *dev,
 			return -EINVAL;
 		}
 
+		if (max_size > 0 &&
+		    new_blob->length > max_size) {
+			drm_dbg_atomic(dev,
+				       "[BLOB:%d] length %zu greater than max %zu\n",
+				       new_blob->base.id, new_blob->length, max_size);
+			drm_property_blob_put(new_blob);
+			return -EINVAL;
+		}
+
 		if (expected_size > 0 &&
 		    new_blob->length != expected_size) {
 			drm_dbg_atomic(dev,
diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
index 082f29156b3e..aa49b5a42bb5 100644
--- a/include/drm/drm_property.h
+++ b/include/drm/drm_property.h
@@ -284,6 +284,7 @@ int drm_property_replace_blob_from_id(struct drm_device *dev,
 				      uint64_t blob_id,
 				      ssize_t expected_size,
 				      ssize_t expected_elem_size,
+				      ssize_t max_size,
 				      bool *replaced);
 int drm_property_replace_global_blob(struct drm_device *dev,
 				     struct drm_property_blob **replace,

-- 
2.47.3

