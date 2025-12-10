Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23565D3E77C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 19:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990E810E76D;
	Wed, 10 Dec 2025 19:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dw7RkObN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CxvP7mwc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515DF10E761
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 19:43:07 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BAIRTBv3082423
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 19:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ucvlwZxhUO3+pYRWRBKqgclemaPm9AbJrEzW63oPi/0=; b=Dw7RkObNqH0/JArg
 Z/G0xdd2MGP8Z+gzWqBxf51kS0nY0viSOr+MbPd9eZyKAe/S2rZPHFLJnZYtbC5Y
 96Cj+zHDK6p0EtBtSGPYNTteP81YQSCQG4nQZcuTWEekGMkHBcFIZe8DBUFJzCDf
 0MP7Al5ID5YYexklfnJ2AmcIf7jLD+xUXlRZ9FUlOo7SfXAfvWmGPL6OTUCZ85PJ
 AYgso6wRsfBgSt0w5gF9shnTHrMYbOGhJDXThEb+Sjy4/0g6FkEVoyaMbWrfrpvC
 lUQTV2n000avc4jmvxZbVsjh2kr+d+PQk6jx7Fgmbg1V96ny3cQpdZYsBcjeyhaq
 GSJ4Yg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay2e0jnpx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 19:43:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee0488e746so4267971cf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 11:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765395786; x=1766000586;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ucvlwZxhUO3+pYRWRBKqgclemaPm9AbJrEzW63oPi/0=;
 b=CxvP7mwcVz/762YFI5KCNMYY+D8w/h4TZ7Pon3bgA2bIAKasS34Fv08sguUsLDzzVG
 moP9Y8NxFEM/4PBUjHI7l6JITkFBE4LoBkz+moAVvw1ZZZqswONDzPNBcyx6/ewoAFUp
 ZMJVWs8wgf+1Js2kXMZciSHLY7g7KP+ZqG2Z+UfV5RMpqIC4P12iWazj4Vl8c7oSH9Rx
 nA4hOEC7Hp+H5um/IIjVN+b2NZ9Hw7scJTwD46f16hKW4aMt0Xx8kbshR8SFl4dMpEca
 Mbt6LB1rIjK5EV0tf1PWAzL91cOm0/zy8Yr1FU0ZhMEMJ70DdJAwSUg/ErlIF4PpKjh6
 MItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765395786; x=1766000586;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ucvlwZxhUO3+pYRWRBKqgclemaPm9AbJrEzW63oPi/0=;
 b=CDyy2a+UYacj+Jzy0nZPKqk1TRD21Yii+1wLl8jxcR2/uABX+7XgOc+ZrfHATQoBL9
 jQ7hyDK2/YtjNgZq3Ym9so7w9W4AYzEJJ+5AowG+gzPD3fxCbnI3WEHCuPxwQ0CxbhbN
 iXIZBrBwPVwrxHs8woS9COL8M3MI6BnGgTkSr36rsXAxxk+tzBqacjuEaqveDka3Cd/v
 auZjyQgcQMSyWMgE+NecIOFvREDurecMc8sk6Uen/VIaJeSq9FIMbNZWfk0z89tv8I2B
 nYCsR8ENLAmhxJ9LFwwKeuUj0/t/e+964R2qV2q8acgYhFcjbXM9s1D80aEQKnjByA0X
 TiJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8Q7It3P6jzxoEmoU/XwiJE+O5bjFpF5/Qs9DtLgSptDoFkbhzLhxjamN3BL+Dlosy7xMJc2Tb@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyv+CcY5od+yR0OodfQeZQgIweDSq1b65SbAU01gImoBv/XEC4t
 K1SOw2U0FAu/q8+w8qUHTbq9vyWf6innXMocrKAzIwQoZS17JGae19oCgJfKnzKhSJYwzjpp+kT
 ZDisirgKh4Ri0zZiP/fuchTA7I6Bw8JHSExtunjl0R3V2Q3h9uQsK/N/XCp+d/3QXGxGp
X-Gm-Gg: ASbGncvhDob8vLyI7W3u2jn6aFLjim79U2NwvWExLspMmWhHBLP/H4DNA45FOyXnlgx
 3BRMJQ9cb3GJ5oDlM3tEyoxoQLeQgwnZWSTk89rhA/2GyC6YsQQqV6ylxTvmTdUFjfEJfx1z+SZ
 fDi9q3etMmp0dgu4lZfrNbyaZxRwA3ldj/pHNYWmSpvG/nC4rUa8C7b5AHgYNnP+XRzb9Uy/9T9
 FHQ+/Zh9dhMGKzAajeE11DmM9itX5jzP2j9+Fa39Um+4Stm95oD0On4qIwuS6hobgq9wdDxwndZ
 elvJNx0L2THxamsE83SZQc6CS+8mluOIjfMhwbqQEt1SJz0kNw07AhOowXB/j6SmWS+R2oyy6nA
 cyu1I+QZZeIhpzOpp8k+UlSRyDM/EtTNP3RXfPIDQL04Gip+kSyAiXmif2Hlw8ghbEuVdkesZ1o
 zl2mYkCWgSvmKSg4RCndXc7vM=
X-Received: by 2002:a05:622a:10f:b0:4e8:916f:9716 with SMTP id
 d75a77b69052e-4f1bbdb9ca6mr10010161cf.36.1765395785803; 
 Wed, 10 Dec 2025 11:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTGVZDJO7OhmU9jVRqnXNBJECkkrpq7sqjcnTZrOyIk7WxcjjzjnM4z7PCglHDaysmLPP26A==
X-Received: by 2002:a05:622a:10f:b0:4e8:916f:9716 with SMTP id
 d75a77b69052e-4f1bbdb9ca6mr10009541cf.36.1765395785026; 
 Wed, 10 Dec 2025 11:43:05 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-598f3199e93sm104845e87.96.2025.12.10.11.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 11:43:04 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 10 Dec 2025 21:42:59 +0200
Subject: [PATCH RESEND 3/3] drm/atomic: verify that gamma/degamma LUTs are
 not too big
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-drm-fix-lut-checks-v1-3-10ae38519f43@oss.qualcomm.com>
References: <20251210-drm-fix-lut-checks-v1-0-10ae38519f43@oss.qualcomm.com>
In-Reply-To: <20251210-drm-fix-lut-checks-v1-0-10ae38519f43@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DcbmKAWOVk4DBQnJAwa8CKdQ1Yq3s2UIfNjf/wSOuus=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpOc1CNBQVt5lVuntwMtvsG9k/gNh7wXlfIuESB
 sIMSN+2yj2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaTnNQgAKCRCLPIo+Aiko
 1di+CAChX+sjkc6W9zAEjAlx5O3DSDT0vvEM/vEgYbtgD/Dms0BzFm6SWNX1DU6BMRju6vqsYHa
 JQP56xB4W9XhjdjrpX3SrCN0O4ECzuB1+1NVoUaCdjUIk9ZNwrIAGQBcePAyFyq0Rve3BNFAnWd
 WdnwCXcC2W1AWBVt8jtUqXSCxizsf6gcnVtwqs6a11rDP5pZGHB/cKzTmnL3gOGZK6TDxbjNipT
 IGYHa5UtHcnuaTUM2nI4bhE32SiQ9iJUvh6nkYpCQfyT4+FNm235+CqQjLUGqTJAn137h4+h0uc
 NPGL42BqOOgUh471X0NcvJC8tkC51mjyZXVPF9bkD7Ng747p
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2MSBTYWx0ZWRfX5FARNM73SjAT
 QAx8fLuiUjhXQOANjjaAhUj1Om6mLMIQPYU1D7YRFGMIih/6gmJFatd1JFLwxqWcB77vAU4F0J3
 j4v26UxX5076m3osf3x7cSGGYgg29z3LtYdz3tbEBTGsRB1mflcUcVVipSUrsNQxQN2yhVBKJ3g
 YVZDjXtc72rFNqGEivkrDolir4wcAhUyzie5/1QoTMBg9l2Sfk9oXShgrm9vw9RmJdALccyf75L
 3GcHGyYCKZDVK1rM89xGPMH8GwgfIFq/J/7i8cIfZaSsplqfmXfpo0VN1eEnQANzS7uEpHR7+fl
 TRxCqILJfgf8gJo0HH3BEOUOwbScWv+xEvIoI9KLjM5Y8DnxFQak9V4e92PyI0SE8+hsiWqa0MA
 4fZsm0DOqCp9/hqOYGkrIQ1cLSeWCw==
X-Proofpoint-ORIG-GUID: D2CsMWVPgOLZSnqPe5T-ab0FAzowhKn0
X-Authority-Analysis: v=2.4 cv=G5oR0tk5 c=1 sm=1 tr=0 ts=6939cd4a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bAolQom50hykzV7YMrMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: D2CsMWVPgOLZSnqPe5T-ab0FAzowhKn0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_02,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100161
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
index 7d2076f1006e..178d983b2378 100644
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

