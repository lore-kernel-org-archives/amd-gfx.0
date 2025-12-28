Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC76E9271B
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Dec 2025 03:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644EC10F121;
	Sun, 28 Dec 2025 03:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxwRHhAb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N3Rd0Hs5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A5D10F121
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 03:24:13 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BS0QLYI2953969
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 03:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1uGVNstsP/UQQcLwdrzkGVSuVG5G5/ESRhIQYzvPwck=; b=LxwRHhAbR7kpNG1k
 oms2nloI0pLtwFoQaJmmTFjvFi92tWj8FUVYjz1W+W3NtwXo19okA7TySOiw0ht9
 xnpAnoeDIEzUv5rVFqrjg2jw1DkO61hqCa8hvExHqvnpEntFpCKkdMQaF3nTSGp1
 3BSwtU0w/xiSSCZofFTW3/eQW7hqZeb+QK/eDGZbCmbCav8D63Eu3KiR810jGSHn
 Kznsn3ddn8k4OijP3hvtYvXG/pK3YwSHJcax4mMHHv6vNPRhX+vZFwjByPzBfiWk
 ePcYWAuic3vIkXCJsj1nT6EmPw/ohvDyT8Qt2EAfPEZXOeNC0Ba+GpCz3FF8P5Re
 Wd5AyQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba8mf1hpj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 03:24:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ee09211413so215844091cf.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Dec 2025 19:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766892252; x=1767497052;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1uGVNstsP/UQQcLwdrzkGVSuVG5G5/ESRhIQYzvPwck=;
 b=N3Rd0Hs5hAC0eBH19BLmhz3tmcUYC75UTbMrQtKBQCH7ilw4TTYpRF90qskfy/7kCI
 T1uog652tz1cNppl9gM1Xnu/kVW4vGeGwvtOh+W7NlNF+MagOFHMq7WU5XfoDqcwbkF5
 pA7lT8u8sLUeRimmII3oAxq6p7axZQRLWJtJYEguYFxlYS47qVnSTaWdLpRfvfZHpNCa
 CVJUA3YRaj1wHR84YoEFgQpu2AcQGBniwaeItblhQkaSlUjcjAKRKfREWi6dlDrFy2R4
 acZkII6xd/9L5QT36aNrqsRs59nnLxdxXZmHO5YTd1QnzCpSpf888mymdb4xXVKvCKHh
 2bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766892252; x=1767497052;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1uGVNstsP/UQQcLwdrzkGVSuVG5G5/ESRhIQYzvPwck=;
 b=WhdEHzrEMKDXwtQieOWOZnsxWJNwz7obpaiyaiYrwVz+rSJcwrtWNmQhTxYE0L7q18
 v7Bz5an+EDGaBuZMnL8t6Y9EzVM9G1k2BRft4UDFF+Yn+FcySqSyvqgSBUoPaYakwbMT
 XPTrvfYTUlmNbqDQfbzPM7k8IUbVSgUTntTuIW1pdgdegLSIS+qp9Umy9Ez0h5GRDHGJ
 EfLMJupvGaaeiqZO7451emAcl3YH1VNq5a9WFue4KxbAbKxLyUUD7lqMGfoTZyHIVy4H
 8NxPYQnYPd0jhSf02Nhh1dV8GnIHge1rEBRi65IMpDkXtOP2xA1/KfK2T8UUDip0KEpE
 NTsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZWGcEaQgCsA83mKTSbL4qnr6NibPHzuSTeTZY1Ev5a8wO+QVE5x8BgMI3DSfZ14MsEnJBd9gm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvgOHmIrxwPF9D2fHBMdVNWTHC4J0nCN+1OELZNQ9Cg60eRs9O
 lxjekcLJFD0GKZUe2Je+BOLJGZF9ByVckBLVbpeEelcReVUzi+FxTUzfSVO4PBTvRcnEEa4Hbht
 cGLVK+mhIn/yOtUmF+8ZWju+SsVlN05MWWN+K4lsErO2Jtu45b/tIGGM7j3wk6YzD8eEm
X-Gm-Gg: AY/fxX4peNj8/yNQoNObkvs5rTyw4zeyuoF4r3/xMXMsrCKluo4Athee2Z8uavV3WZI
 56PZBMeWeYCOiWjXikUCUD0oLpYM2TKC0lk0D8wH4HyVrl+IEAA6o7ByPpC6v5B/PkOxigJorgj
 Te9G2+klRaYgtx094T1jCd4CLlx0U4ycxM3EiZXFYT3hE+IWMIRIGFCSCYy2npKAtEqI3354Cv1
 7VUpQjJzvIDAG7w9135DTvUE+td48B/2INNIF6EZU2KkFQ/fLnpBZBvtG/9Rsq6H/9SFSH95Khy
 rYiqnMBZVVXVvGUil5r/2p8m10jocwyRNsHPY2qEXwyfeSoi8JppFnN4CKX8gxZMaK9kewFUVzx
 QfcisMd2bdRgKHlyD2J7FASdZiFNYWNq35WUzBdYGFMQq+5ZXGZGLTdQ5GZkpW+meVNc3UaV+Z4
 wmJQ78i1TXxCOA6B6+acj/K44=
X-Received: by 2002:a05:622a:52:b0:4ee:2154:8032 with SMTP id
 d75a77b69052e-4f4abccfbf9mr411437621cf.6.1766892251880; 
 Sat, 27 Dec 2025 19:24:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHym4jtd6iruY/LtoXO0zkBjy8zwwzIIzsS7J759AFgV3YE7d2JZ9pTxvrevNx5At1xnVelTQ==
X-Received: by 2002:a05:622a:52:b0:4ee:2154:8032 with SMTP id
 d75a77b69052e-4f4abccfbf9mr411437541cf.6.1766892251396; 
 Sat, 27 Dec 2025 19:24:11 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3812262b36dsm72149561fa.30.2025.12.27.19.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 19:24:09 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 05:24:05 +0200
Subject: [PATCH v2 1/3] drm/mode_object: add
 drm_object_immutable_property_get_value()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-drm-fix-lut-checks-v2-1-50f5d1a260a7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=OHanLuFuc76947yU3WzGXKL8IflDYvhJa4SYngSj/Nw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpUKLWCqbtmVXnOVqIZM81gDqoe2k/c0O8gLZ0n
 bForL4+rpKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVCi1gAKCRCLPIo+Aiko
 1WTWB/981hNSUmln3Zng5VlQNM/WADygi9G5h+qTQET3GiZ+0xse3xCVH5B6wPb3tfWauiTsB1V
 1SY4OuuxrNu0qppPny8lc0OTl5FmYweB8YbelQeVDQvgZInG4KZiyZcPVJ/lS3jS3rOzOfNwdq8
 P/nKrWj56IWQ0hPTuBLCD+DRs33SgtkYHVz0cMgJ607UzUskSmYpnCcIEibsUMFM8LAsv3lWcRc
 sRoMMjTeLtDhGQj85wzbvKGy9MUlty1R/B0wqUu3om5EW0HUp3fGdjCmqNHlOn41ATNSumjuAMj
 1VJEsf9NVOmftK2w6E3K323j39kVG3EWuoESf3hEp6CSOJP6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: GPaFIEVWJTtBKBSi6i-F_EYiV9G7WTwZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDAyOCBTYWx0ZWRfX3VsmtUJp4uIM
 U/AIdPgSx6ZXLKoimV7VnKXsAm5ehSF1Fe9x5Go7f6PL5+BvXQEeNuAbA+CWmZp+k3AgCquB1c6
 ZDCu07Pbf+NKHUpnh6P680m+3iGYe/vU9pdz1fHa5Y7jKooHuHhi66Rr7oDCYyqd8vt/1tmyBjq
 ZConoqHggY/7+UrBzuISPrZBDyglD8IhtsoRuJ2d9Pl+6pPZxkAaR+35V7XUbjWQjoKNFc8kjRe
 HDXqpnUQF0AujvA9E7/Vt/tciXI4d7UeUIAU0HV4kJZ3dAfYf+FAJNZRxnoDa5wasY9iyh0f1XJ
 FfT19tPbaRKcfIFoFAOkNgwjuSW7KU+vBCyzal1Od736bZPdH/pnAimE8xJH9uUmor6pdWvHmVC
 AmQPvyyAXRXJCUF/GzCH4HHcUbr9MJMRMmOP22nnANzTjdwAiEs2eH4IB+9XWcn2s5YY27Ifc5c
 H/71P98FgyGS2A3vXOw==
X-Authority-Analysis: v=2.4 cv=XuX3+FF9 c=1 sm=1 tr=0 ts=6950a2dc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=uUhA93nX2LN1thLMeo8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: GPaFIEVWJTtBKBSi6i-F_EYiV9G7WTwZ
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

We have a helper to get property values for non-atomic drivers and
another one default property values for atomic drivers. In some cases we
need the ability to get value of immutable property, no matter what kind
of driver it is. Implement new property-related helper,
drm_object_immutable_property_get_value(), which lets the caller to get
the value of the immutable property.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_mode_object.c | 25 +++++++++++++++++++++++++
 include/drm/drm_mode_object.h     |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index b45d501b10c8..2d943a610b88 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -385,6 +385,31 @@ int drm_object_property_get_default_value(struct drm_mode_object *obj,
 }
 EXPORT_SYMBOL(drm_object_property_get_default_value);
 
+/**
+ * drm_object_immutable_property_get_value - retrieve the value of a property
+ * @obj: drm mode object to get property value from
+ * @property: property to retrieve
+ * @val: storage for the property value
+ *
+ * This function retrieves the software state of the given immutable property
+ * for the given mode object.
+ *
+ * This function can be called by both atomic and non-atomic drivers.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drm_object_immutable_property_get_value(struct drm_mode_object *obj,
+					    struct drm_property *property,
+					    uint64_t *val)
+{
+	if (drm_WARN_ON(property->dev, !(property->flags & DRM_MODE_PROP_IMMUTABLE)))
+		return -EINVAL;
+
+	return __drm_object_property_get_prop_value(obj, property, val);
+}
+EXPORT_SYMBOL(drm_object_immutable_property_get_value);
+
 /* helper for getconnector and getproperties ioctls */
 int drm_mode_object_get_properties(struct drm_mode_object *obj, bool atomic,
 				   bool plane_color_pipeline,
diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index c68edbd126d0..44a0d6f8d01f 100644
--- a/include/drm/drm_mode_object.h
+++ b/include/drm/drm_mode_object.h
@@ -133,6 +133,9 @@ int drm_object_property_get_value(struct drm_mode_object *obj,
 int drm_object_property_get_default_value(struct drm_mode_object *obj,
 					  struct drm_property *property,
 					  uint64_t *val);
+int drm_object_immutable_property_get_value(struct drm_mode_object *obj,
+					    struct drm_property *property,
+					    uint64_t *val);
 
 void drm_object_attach_property(struct drm_mode_object *obj,
 				struct drm_property *property,

-- 
2.47.3

