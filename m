Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F66AE9271B
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Dec 2025 03:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8C511A675;
	Sun, 28 Dec 2025 03:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nk4YVERI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DOT2AN2Z";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559E910F121
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 03:24:14 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BS3FttD3278445
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 03:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i/ZE9RtLemTsfDhGA7S/TMDUgGHbHWM5z3Ovm2RpDnU=; b=nk4YVERIVG+3upJx
 ei+/HxEVAlFjbJaZKgC+gi4qrF/RgWbK3OkH8B8FSvCGHk4gIokCNcVPNi5qvSvH
 s/W9rysqHTb6/hHqf8J/davH8C+JLaGIU6yzm1unSwDOkD3R+33IIYhrM+HBsBrG
 FcMEoI9i7Gn+qaNODDGfWbGjusapZDMZG0reKOTj4iJuGtZEjOE73dH09obpuInz
 C2WaqJzQJYzs4hc2V4NJjdHxtILSlOX/7+9kT/7MgVxirr+fNoFBqXm6/9H1AQAO
 KECpTS0sybHhT8TMPUt3bAlhIChRo1qZAHNX1jWTzUyT/1KCHBnTb+uFTegeOtle
 0iaXdg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba8mf1hpn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 03:24:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4f1d26abbd8so240339481cf.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Dec 2025 19:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766892253; x=1767497053;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i/ZE9RtLemTsfDhGA7S/TMDUgGHbHWM5z3Ovm2RpDnU=;
 b=DOT2AN2Zs+N3ATzuqrJoA+vcrBIFOo0RH1WBOojkFUOckyTpubRJlptG23CURIL9ZM
 H3rbYH5RkC6NX+XWqkudR5iu22ld/mBh3kYx8rcNyyaJRCveOU8IrJafVaaAMpcSzF6Z
 UmYiMSmv91OV48L+V5xZyCQ5nWjuQo5Yk/8jwlakQDowpXnVPQRpSlN5L/UkJndFlG8l
 lKKFQcahFwcxRiIDy2fqj+m7kGwu01NY96jOLuqYvOozOkNfC5fqg457u/y9DQY/MisD
 3tsA6ma8HYHwEZQ0WfStvNOeegcuDZEgNkNY2jMXOvsdJnbkvt5jy6Gd0TvZcfrkYgul
 YFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766892253; x=1767497053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i/ZE9RtLemTsfDhGA7S/TMDUgGHbHWM5z3Ovm2RpDnU=;
 b=NDHlucy6Hg6u+PtXGINt//jC757A7XmFBg/VWNLx1VEbkNkAeRlMu/p72jtfyM0aAU
 CVPLsamtJoRCLUD9UPdwXbpAiBk2tQSpC66OA9c1OO2sTQ19DyLkJcAKo7HVlyQQQobo
 yr0Rc+PSMqvml9AwIVSNogqXV0+2ARt4vO0Ef+2cEm4lp3Jcq8MOyktSiT5luhGp2a4f
 DGVWEUfXW+RwiyqLlgV0VdfXJ2Oejl1wFfUjtp16dIo6PXZtNNh1xfGDWMLzSR60WQmg
 RdrV8LkMi0N1lCxahfChn58dNY8DYzjX8KWepETpDFXZD+HdxP4e3hyetEJoh0NBfHoQ
 LwYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8NTXq67R4xP2WfFYbR1/UQJU8iaRmieWEaJPj1vxtQZQZNnemTVxzQreKLxge7KiDMSuXhcU3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBCtK3rDLOBxNOEbrNPVHj00rp454cdWPyC3XpxZRZqIORWVO/
 TFv5eIfCrJZwtECatnzDXyjkFUOeihKZLD15uM3N18yeQBjf2FBDAWVgiwpx6fCTV2HaoKpzo3p
 1yGytLvu8vUN+SIDx6Xmy2etoQfiiN0aFLUWflMjWCMfSiuecFtaqEOL1Giw63WbbRDfr
X-Gm-Gg: AY/fxX4J4qY+bcQQsntUJYTBO0oDT7f29ibVd1pz8GscwL2RtldtQSOTsYm74A269AF
 za477WQn4mkkJd3z5AFPdY32xJmFY3JlEdQQlpObRgegduTQzb/oY8HgqsAlscqUAgsspllzqku
 E2XK2e5mwHnI5O/PsX2u/Hq/09jaHj3NHz5yc3yJ++vLH9/8FGqCtGHUegOQi4Gw2twNIC7s6N2
 uQEffDVE59vCEzI28eeAwUJzRlSFvF3bkn3IW9mXihpSLOh8/OcxmWPhd6Y6AGzZ9Y8nEEY0P9g
 2BMPqjuVCEkkJr1FBAxitHG8CIHJiIj5yK1CFACenwTFMFRT6/GWXJ6yCEsJdydh/bjvWPp9N9T
 GGfh/8skDXfLVus9KQKCqGNNh+FPk3b5D1xy9bKY70bGQFhSAoBjozjHEjO+BfnmkBLc8aR0zay
 +Pwg2RCHh0u7dZlhQKMqcEFTA=
X-Received: by 2002:a05:622a:5c91:b0:4ed:dcf0:6c42 with SMTP id
 d75a77b69052e-4f4abd8cb47mr445720491cf.40.1766892252919; 
 Sat, 27 Dec 2025 19:24:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7sI66qV0k9krxjZk/aTcw5Gnyitndlxx7LAdj3JhMqT0YeUPsGI0pydm0oPEQLn/B8b/b5w==
X-Received: by 2002:a05:622a:5c91:b0:4ed:dcf0:6c42 with SMTP id
 d75a77b69052e-4f4abd8cb47mr445720401cf.40.1766892252510; 
 Sat, 27 Dec 2025 19:24:12 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3812262b36dsm72149561fa.30.2025.12.27.19.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 19:24:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 05:24:06 +0200
Subject: [PATCH v2 2/3] drm/atomic: add max_size check to
 drm_property_replace_blob_from_id()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-drm-fix-lut-checks-v2-2-50f5d1a260a7@oss.qualcomm.com>
References: <20251228-drm-fix-lut-checks-v2-0-50f5d1a260a7@oss.qualcomm.com>
In-Reply-To: <20251228-drm-fix-lut-checks-v2-0-50f5d1a260a7@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpUKLWPCn5iT0mGoXdl7QJ6E+apnQ7rMLHMGJk4
 G9sECIFLGyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVCi1gAKCRCLPIo+Aiko
 1SctB/9QMqX9xOhN+slQMAqjpgPgfBziS0hh5u1jxZXi7HNFhxc3+/JyQ9eOUwrsExpScvJVr68
 x9UzhN+X7/NQcX13Rta3rU4XT2+CFZQSPyf4nTkWfBfwBoLIQrZSRJKMIADXXxvxNCfrgO0DWIB
 ekeglW3oAcSJkcoAXQgcSy5utQak3jZmais2WMk5ZgsAP7JAbYGMzBoiGJTFoR/Dja1GKM6F0Sz
 7Kl07Yxm7TQW+8+GjJXUFZyABXeX+HsXcPusv+eRG/zm6fGYbve5qE+84vzYNO/pUHvEciIjzry
 q6uIVF/AlSUouUR3hldSUi2smRuPKyCfyiWsvxgqJCh6kjxF
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: S4vb4847e50yuXd-wQ5TurXwitY-djbn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDAyOCBTYWx0ZWRfX67YEPxkZU4eA
 /vJRToqmdUYkyj2uDs6SVBu50pnnSn7gfxFu1NtDLaMVYrnuhvIa+V0L/hXKcHP83+dtRWBesnX
 c4L7HSzqUxUI4PsBQTHPjYQ2eskAnnxU3h1lgppDVNWF/EWU7xZmQtiGRxNi6DJ4+ZN4Y5nifM+
 EGPJ2djJZbXTLC2Vfgm4O+b8Dpn0L0WY65TIWlnbdw420XKsTh3+oDU6LFIxfC17Zz1J3eynQGi
 SPWcc6BsSsHO4t47uUPEZScYS1vSHPTuxq6Q/YTvaeqhBKuUSdRmE+b+3MgSZf3LEFj+FOOe9tt
 lWIhvmwfKyE8OJeJRwdr2N03jSl00sREVLph7hwi+/YVdDLt+lBkk7zw07KbAlca2lhN/oeBmO2
 qmhDi4eLvtxDsih1B5ebuBvyNAi04RCKGLOdR4jk4Q9dkXXFIVFVCyFIeswxxQDRU/h4qsp4ST5
 Pc1pVpnDXGGAFgwjl3w==
X-Authority-Analysis: v=2.4 cv=XuX3+FF9 c=1 sm=1 tr=0 ts=6950a2dd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ySEUILROmfWDjamXepEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: S4vb4847e50yuXd-wQ5TurXwitY-djbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_01,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280028
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

