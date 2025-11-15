Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0618BCD4F48
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Nov 2025 03:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E6E10EB73;
	Sat, 15 Nov 2025 03:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HboKQy1y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="irIlHTQH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD68210EB76
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:43:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AF28Yj91066068
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aamIlscdOZY2NtMNmIDW1DpTwPFXcWriH5eM+ZN8CSY=; b=HboKQy1yA7vhgXyT
 P1ia12JurKgStGgWb6jbJ4jftC9Uz4xPMG0FfCZ+xi8gG1lwxVQg7zReFC8weKGM
 erZsILtU3/ib4bpGndhO/ubNd3uU1Qwb2GqPvT+w16xjxEySW3Irj6+oJxLpP8Hx
 NMQQFIr6LT/xrzIMB9nWfUK40SrZNsT1DAppakH7D7Z1LtZNBLMvoMu/wXqYC7uT
 +2ZjxSOkQGwn2jh/EI5yllCZtC/gwyp91jUqRE6CLwQN8mzC639r/4HKIyMKgVrv
 BPaS0/nHk+NEa1O6o1E3f65EX+wGR/98n/DnSorOoZc3JiFm2nVUig9XxiJXGYfa
 06gEWQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aegfq84gf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:43:01 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8824b00ee8bso41835986d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 19:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763178180; x=1763782980;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aamIlscdOZY2NtMNmIDW1DpTwPFXcWriH5eM+ZN8CSY=;
 b=irIlHTQH9Ue9O8KLcoD4gIQ3+dEOG3TLAcLlg4wA2YaOVac0Danx1/463ZGPhVQNhI
 Y8b5mSLiZG9vC3EeALDQHqaXKXjO4OGw+YssemeXUezc3M/wiR2kYoV+1OCS/JS+qGix
 WVaaZ0Py5OqUrxsowkZWqqRkHzBpvxuHE7dcK5Lku0EzcsR2v6rf+Sz/bp9013MG1FhB
 fzf+8EFJ+FZQUIo5Xve8YKaqBacfzff+NAm2pSQwbh9mOyyE4FcR9X1X/F1Uht/IQXuQ
 688FkLkvsgvOta+wtvLrUJ2sH4s0c+2tNQPuS3ZMecxceB4qA2hy7a7Di8KdAFGP6PgH
 WDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763178180; x=1763782980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aamIlscdOZY2NtMNmIDW1DpTwPFXcWriH5eM+ZN8CSY=;
 b=rhNntIeamTozwoTFN0rpS1P/JgJyOl0XvayDbDZgj+aoASiMFbxC6ShWHDfoVLROV1
 GfCeFsulpwVqNhGrSZK6mk+R8Xve6nF5sorBjeCvGNOQjjFM8qOc92fyqNOgMJXMjh98
 PK8PsxN6Ck5/uN2/edhyK/xwdNqp+q2WKxytULWifEEwzpUxgYqvpBdxy9Hg9DsX0QyP
 l0x7NPOy+nww2iZgaxU9k6g+E2bOMawp1fqiFg/D93v1pe/fJTm5Uha/ZCnMuI7f6t2U
 8m5L6W280+nKyYOgnyVefiCCpXqv20PdT/s93sai0Hag3K2xR13PO+23qz8bOMvUOf9u
 V5pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULdgFMhSwbqcoiVaJ2Rn2podk6UYYQp8u+usiNeiiCpvJ+lc6ihqBw2Bu+1cdq7KVXGWkIrbja@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXMkuchhUGKxwG3l0Q2ws7r4sbRNz/g3oAlz+q4yj5StSlq5R+
 jW2uDCKoNvDVngpItZtIYuHirtKsOKhIOo70IviTGcRmbd2qywXmKMBxWgtnnGxV2mBU3NlAJcV
 9Ja9m1ReYcC/+zRdIIISeAdjGVqkLxxSvDbBDEjOtevhZ93nMKJEbqNcgZhy2uke7VH+D
X-Gm-Gg: ASbGncsAqq+CJhWv0P67t+dCnOnGsA+Zt0RxCf2xupMtiZbPJQ4+jfmMNmz/R2UuuNH
 71SLmHZ0c/TpHTNUqYNnIZiqAUXqKDAC2VOA+0xfwjaQF2qjg7X/CzY5uPnn4/0G+ZweWvk/Lij
 r0VJXKYli4rm8iSj8u5ivm+xBFXrVlGXwCJVY9ve6Ea7n9IwjkJeJ8MqUMK5n4BdEkrgZO+aKby
 LtmkB6hwyRROYo9UE9rnHtFOD7982yEE/paSbD3KNeb7Ufc2uxaQP0che+GgD4UyvDq+NRnYO67
 41FeZSHSG/rkRED9w645CmZvr5QKg9cj1pAKC64o0cV9GxC0JaOrO5INPtYsPt6BYw5+VqmXYJb
 BQ7HsEC+i2S0hVugshayHZmezhFPWLq6/pzKNbJINIJ1coB7XJpiCzCNyHrismomWrq2C0+JN3V
 oTgZ8UyRB2l48Q
X-Received: by 2002:a05:6214:248e:b0:882:3453:8248 with SMTP id
 6a1803df08f44-882925f67a9mr77232006d6.28.1763178180253; 
 Fri, 14 Nov 2025 19:43:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhVxtE2vzDpCPxpniykwzQn02uMaRseK9nYWsrY16MxhuNwjNND/ElPUxOxZWzG5XyLWKoMQ==
X-Received: by 2002:a05:6214:248e:b0:882:3453:8248 with SMTP id
 6a1803df08f44-882925f67a9mr77231846d6.28.1763178179750; 
 Fri, 14 Nov 2025 19:42:59 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5958040578fsm1475880e87.78.2025.11.14.19.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 19:42:55 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 15 Nov 2025 05:42:51 +0200
Subject: [PATCH 3/3] drm/atomic: verify that gamma/degamma LUTs are not too big
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251115-drm-fix-lut-checks-v1-3-3586f5855bc7@oss.qualcomm.com>
References: <20251115-drm-fix-lut-checks-v1-0-3586f5855bc7@oss.qualcomm.com>
In-Reply-To: <20251115-drm-fix-lut-checks-v1-0-3586f5855bc7@oss.qualcomm.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4P1wMVl+cr5YuoK0uLDDF4U6r3t4wXggB06NKtuqjxQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpF/a7T5WnPS0+6Tv496xy0Hm3V4HUcepWVOh7+
 VCvXzZ0ycWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaRf2uwAKCRCLPIo+Aiko
 1YkmB/wPsLc6KEvkV424vpLAEbHyA6xjgnMKZ8tD9uJ/+MD6hxhPqfREqsSyl+MQ5pLR3IceAoS
 /kRCvgLGHirkV2I4x1xAwX+1Huqe2X8PL9InneIHyOgtV+G6Tm+sOxSeroduVzfJ/878dKw2rdh
 +6MQwO5CGzxmegoJ1uwt+cmQFi5ZQIRso9+YbQNSZUqw9m/54fgaZsDYyZ1CRTTNtRUkOBGBSTy
 jtzW9mSXfn4oeivRipQEgsOXmacKBxIU2LgE3wcFCEdbZoEd5dgrBG/MzM8Ll+XI/WbUm0+0pfd
 oUmsdaraNAe8qLgCznpVkSLyzHlVcKwODR9r6MfIPXGnNohi
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAyOCBTYWx0ZWRfX4foTqxB9Yr9y
 plestuSuEGv6zn3Pp/kLUOA7yUTQ99FWOBm5yb4Qm6peDhS3/G9uUeeH59q1EDyOqAGuFNpdESI
 cO1Pvywn+gM1ezuFv6uv69TzYdg1rCTaC88q0yfOO75d9zAlXikNC08e4/vOv16GsX7+75xSErZ
 XZJ2e3elDaZX9tUaPN7/T9NHv68q6O3CxcfvWyU4KKq4lZHgZXdKudRL/TOkc9C303QolBBVmJ2
 pyeiJMsP8dwF/qQnlPVcRExx8lzYiTAb1N0NPunF/TNFnXPq5YZbeYuD9VOdpOVzv+mWGm2JdRx
 pfeJSriFbi4BtxmmiKKT29FXxSKWE0rqNdszwoEH+lc2icNGCshQnjNM8BlHuNVSS+2R9S6Op9O
 /AFojtnZE2BH2+7u6ddvOIsBtWQa6Q==
X-Proofpoint-ORIG-GUID: cJ0JD1JvmNrx1s35tO36iWVEFzg7UH8T
X-Authority-Analysis: v=2.4 cv=NezrFmD4 c=1 sm=1 tr=0 ts=6917f6c5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_v5trmpiMvKuf-VRmTkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: cJ0JD1JvmNrx1s35tO36iWVEFzg7UH8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511150028
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

The kernel specifies LUT table sizes in a separate property, however it
doesn't enforce it as a maximum. Some drivers implement max suze check
on their own in the atomic_check path. Other drivers simply ignore the
issue. Perform LUT size validation in the generic place.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 7d2076f1006e976de73c898a838ceb4b5c4370e4..178d983b2378e1910a8afff4da24e090f02f3bd4 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -384,11 +384,19 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 	} else if (property == config->prop_vrr_enabled) {
 		state->vrr_enabled = val;
 	} else if (property == config->degamma_lut_property) {
+		u64 lut_size;
+
+		ret = drm_object_immutable_property_get_value(&crtc->base,
+							      config->degamma_lut_size_property,
+							      &lut_size);
+		if (ret)
+			return ret;
+
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->degamma_lut,
 					val,
 					-1, sizeof(struct drm_color_lut),
-					0,
+					sizeof(struct drm_color_lut) * lut_size,
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;
@@ -401,11 +409,19 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		state->color_mgmt_changed |= replaced;
 		return ret;
 	} else if (property == config->gamma_lut_property) {
+		u64 lut_size;
+
+		ret = drm_object_immutable_property_get_value(&crtc->base,
+							      config->gamma_lut_size_property,
+							      &lut_size);
+		if (ret)
+			return ret;
+
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->gamma_lut,
 					val,
 					-1, sizeof(struct drm_color_lut),
-					0,
+					sizeof(struct drm_color_lut) * lut_size,
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;

-- 
2.47.3

