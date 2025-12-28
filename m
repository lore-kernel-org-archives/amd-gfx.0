Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEB1E92728
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Dec 2025 03:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E8A11A6BC;
	Sun, 28 Dec 2025 03:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k4UPUn6v";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FruSLLQi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCDED11A6AE
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 03:24:17 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BS2NVnG1397169
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 03:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3dHmK4Z0mEQYvLqijWN5ssYQ9ShWJJdkoUufTuuHqek=; b=k4UPUn6vP9bcXK1f
 rcaBMSgGNPCbld4EE5oJ23m4QoB8mb8LRWVjzK4q1vCegA/YAre4Zl5fY1RJUrJB
 /QAHePqkVrXSfLHt1CTCzZaHhfzVLuXMnQJmnVU5T466J54c/ULibA/mXau7uxUn
 V72OIEMHiwpTucSCdfdJUEy0JRmmzw6QEP/UBjYcwMQnyX8xcJFj/cHCh3nhw0e7
 FnmNWFZIedaoHs9lWcAJjTYKlS+vHH1W7IytwF0dgWyoQm6PXF6btMafZNbyAe8W
 rH4QXyeAZ/3OIbZYk2terhg9y04u/ajFblp16GAuOyhY+lGVKAW9PDWzKGGiwdUi
 fMSUag==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba55e1sj0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 03:24:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4f1d60f037bso185824811cf.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Dec 2025 19:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766892256; x=1767497056;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3dHmK4Z0mEQYvLqijWN5ssYQ9ShWJJdkoUufTuuHqek=;
 b=FruSLLQioXtBbDS2DqgvtP7DA719Yf99lb3dYbQ/OpkM9fvwOymFwyLvEKxYEPiKm1
 ZsKgQoFtV9OQbw16f2j6FOeZb7hyFrK99pC2NnKm5M+Vw9WUFcwDQqmBz5wokbDe9yKF
 rzjYh8b7r8eQxTPIoPqThnZrKDD9NV9b3nNIZgc6lBElJdlkTEytl8gfVY3X6vUy9LFK
 8R9XaG2ZBwRgMGTwVyL4EpWA+5fHoe0UEgBlrdtt5FS9UdEr2O7yof90FO59jCNAUL5z
 Q3OQDX8gfcfStdna8ZYz81c4xSNTTggJmJw95HAg/6HEVK6JeHpDEPvHZAY29W5w7qs0
 GSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766892256; x=1767497056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3dHmK4Z0mEQYvLqijWN5ssYQ9ShWJJdkoUufTuuHqek=;
 b=e2m34YRC73KEkMZRDJCnsue1XNwF+hGTyiGMj0aYSA+hlL8bzDRs0RMxwep3Hhtz5V
 9Nz95V5BLRhYnOrsN70W8+6fNsu1maXBPKxVjvln8X1GeHujk+Iktc9U36/G8LYDP4rP
 hvQGXiEljgEKRlVmDFRy+4Ahabda7i0XTPbFtG+/nu3N13IQbKQhfJYSWGZZtAFBWDDC
 17PUIvd5jsPC4EurustQ3IN2pME4d5bsWL7DEvsa5FH14+f4kk3pvju6PKXrWoapQkuA
 5nyhpSNdtLBT6RZW11o6oaLIF/1VERQmP/ReoGLq7BDZZ2awu4nCs1yvsU6/+erR6hVM
 DKvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVgvnX2366lAKySX1UY7knfSaEf+iqyXTSk0lXv+r8iUhb46Sdgbym/gYRfg06jeBrTkGFn8/C@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrTXQHZSrLQgWKDVm4mBtsHZLdaJ08gi6TL0erbhy4lrIFqkb3
 BPtl2xGfDsO9izvwhVDt/7pzQEKitt4LVaiyWTUxBrUD1d4SY2DXw9i9jznun/awu8dk6FVBm2G
 n2iwZ3zwhAXlvtdrr/oAddJVKGc8jsxlHuQqTIWVsKeL4O6qPoRRoX2UvJ7H6oA1aHGjK
X-Gm-Gg: AY/fxX6ODnzML2dSzk+Uer8C+IVmvV96HArlr1C7Jbc9dIRCjY5oMdanlcjZrLOEJvc
 6OBlfOdFeqIMwqXV8hZ0zJjaVwLWYujxFjSgci1phC6aYc1WoKbSfgZ6JYuF1LipqFCfB6QzpWn
 y6gvYYtZ48sJeFEhtcXWVeJMSqoWxEB88jvEhCtKoXgyD9XbkQUFmXOgSaPT1ykebH/sVZRK+BY
 VJjvnM+LNoihEyTo6EcLqPbolJWuICncOcrIH3daThYK8aLvnfYO4wMzPD+tYuwLcPcPbhqlUlK
 vGGiKyu+hAOFw+XWX4YvCEv9LI8Y0cK97tpuWcNMYE7KXgcHzXS89z/41D1Psp/gB8fe36VzElk
 xKBxMIMUC4rls3TzI2XlCD1AuhQ/qPdYCY6COzA0vPlNCPEH10k99VtJFyzcyn61shs1FbvF4qf
 QKh3imyYRZplq09KxcYr60E4Y=
X-Received: by 2002:a05:622a:909:b0:4ee:1875:42fa with SMTP id
 d75a77b69052e-4f4abcd09f4mr411834011cf.1.1766892256455; 
 Sat, 27 Dec 2025 19:24:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7rnFmsC4exAxvQSHpB1xuuZUBoYW9vqYfhHAhmTqGWdfrHTe27lOp4ru7Isb9AMlvq7RjTg==
X-Received: by 2002:a05:622a:909:b0:4ee:1875:42fa with SMTP id
 d75a77b69052e-4f4abcd09f4mr411833851cf.1.1766892256029; 
 Sat, 27 Dec 2025 19:24:16 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3812262b36dsm72149561fa.30.2025.12.27.19.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 19:24:14 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 05:24:07 +0200
Subject: [PATCH v2 3/3] drm/atomic: verify that gamma/degamma LUTs are not
 too big
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-drm-fix-lut-checks-v2-3-50f5d1a260a7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MShYdDKdFUHcrHqdYR2kRbGAF0dVfrFIaZJcWDlIW7g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpUKLWgTT7o1EDCbJr87OcCnHW+Vd1tXrMXtG8i
 AXrXELA0PWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVCi1gAKCRCLPIo+Aiko
 1fCHB/49Xr2ORljZCm1hynreogxCv1NqbFHUtI1Iw14YGFMA1Z9EXjf1SXSZlHQ8Sag/qifTS+X
 avKm3KjwjQGIhqZ+8UGs4RiS3x2hg6lrDzqqOnX9RfH1i0YYvw7WKMyopKqw9b/y7EKQjg9JI2w
 ToNRi9PgLT6R0RbpDg/0jeSBtcKTD0L9f2/c3qs7yEwWyAOubY4ue9HR5drfOkvSaWUygIEvl15
 0Pt0MTj1iJHefu8vS41zFO1I741K456L5hxZhLzcn/fSDbB79eye6ji/QI4a2OwyZeugDnYjSxG
 4xbbM431/e2jm0juvpdiipkpq/AlbY85tqyumRP32Egepcyy
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDAyOSBTYWx0ZWRfX8Y0KFb10PmhQ
 srRWlfUTpQgWvnCbQ0tBC0tY+XQLzpIb7cHwPrHNYBUH77vXFP5eAigPRMgOXSRA6kTrdnA81Qi
 Z9HTnDv0vK3idq18Ae/yAY/1KpdAxH6a2Qg1QxfSKIlRnrm/gt0ouJK7XEtuwuVnv2xfP56NbIj
 kNABbLFylVC+ccdymJ6FchZxnZdiTIJGK1VDZ41IM9yyuhGG3J9XyiFJgieD2QiIlLUI6rfDbDi
 B8fxEwOvmWVs/J+vzdjq167fGe49T4yDEKxaf0tGxXz9JRrY4onmcmE7U0qxz9qAOIN+ZrQsHa+
 0iGNMA3UH/Wg4UDeziqlEPgrnbTFnS+RvCQ9K6XRCciPdByM0Gnw84vls27G5WEPNaR+6tzYxLh
 78f4n17VQp123zvZviNfH24NZ+iBMRGfUwnAerjMngUZX43F+XdQGiG3iY3wYTLqhLPuh26nWpz
 Yup/RsCEotc2PC4eL7A==
X-Authority-Analysis: v=2.4 cv=UMDQ3Sfy c=1 sm=1 tr=0 ts=6950a2e1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 3FxuF9TDsAjMkvTsaHOmw1tIGuKqXwAQ
X-Proofpoint-GUID: 3FxuF9TDsAjMkvTsaHOmw1tIGuKqXwAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_01,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512280029
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
 drivers/gpu/drm/drm_atomic_uapi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index dff1fdefcbeb..8489823a9773 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -413,10 +413,19 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 	} else if (property == config->prop_vrr_enabled) {
 		state->vrr_enabled = val;
 	} else if (property == config->degamma_lut_property) {
+		const elem_size = sizeof(struct drm_color_lut);
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
-					-1, -1, sizeof(struct drm_color_lut),
+					elem_size * lut_size, -1, elem_size,
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;
@@ -429,10 +438,19 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		state->color_mgmt_changed |= replaced;
 		return ret;
 	} else if (property == config->gamma_lut_property) {
+		const elem_size = sizeof(struct drm_color_lut);
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
-					-1, -1, sizeof(struct drm_color_lut),
+					elem_size * lut_size, -1, elem_size,
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;

-- 
2.47.3

