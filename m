Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2EDCD0432
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 03:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD6510E159;
	Tue,  6 Jan 2026 03:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ONFjEibD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+94uW9c";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD4C10E159
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 03:10:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60617lrL2784498
 for <amd-gfx@lists.freedesktop.org>; Tue, 6 Jan 2026 03:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1uGVNstsP/UQQcLwdrzkGVSuVG5G5/ESRhIQYzvPwck=; b=ONFjEibD5yK5fUZy
 O5ag6J+2m/+8CBwmtvt4LSZU9L5KntQcAK5CVDHinePnOYXiYO2YS3lrETDyHRnA
 E1olvjB6uj87vvQDLg9RylNdvo2dcVM+Mqvr4PiH324NOVtV7oUU8EHa9UHq/0Kh
 cKGupaPsGx0P+AjPLbvFZpuLffSuSXr/yPCLQUWfRc14/pSZBMFu5xCkgH41F1vU
 ts2nh+n7RlzxlxJ9Lgnb3RS5Ve++IFvyY07EAcEoO8o5W+tW2clCGHzwwtqni9hk
 3h9ct+ernGUnS++aewPRtYZjEL0VrZVthuoxqZL5jpVYI7iUfznjgcICgICzU154
 2uRy+A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgrf7g94s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jan 2026 03:10:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ee04f4c632so9442381cf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jan 2026 19:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767669000; x=1768273800;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1uGVNstsP/UQQcLwdrzkGVSuVG5G5/ESRhIQYzvPwck=;
 b=N+94uW9c9WZhkRibvGEhJx1wctimZP7h9R/UkHIQy4BbWVpd7bvXXT5hrSpHuXxXvi
 NMu618PucHw95HgH4CN/arrFd15GTdsF5viWVUmS+yOFFkYtXxm20f2K1umonKCTViNN
 pZv2wjOyvu0/O4xokMViyeQY3MJpWwNZOH6G0kRh3bjFtzM/Px6Ijc+px4IJOmBYnDf+
 Iuh9E0QfRxqkyoGEWGMB/CebrsOxWJhO2e8MhJ2aXYfKm8Utmr5rn/NDtE4LdsyVI2vi
 tXw59MgPrrSvNoN9qpz5NCqGCsg5W1WUqB4fYIXWj/FXXzmZpmMrZbyj/ojJrv4rCjWD
 9Bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767669000; x=1768273800;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1uGVNstsP/UQQcLwdrzkGVSuVG5G5/ESRhIQYzvPwck=;
 b=xN5AmVadwSniB5RdSbB3w3UdlUVemVLXlnUfcV/o/PqRDgRBHbBl1LFnHp091OKFxM
 uAPS875tsjQBnvDapLCwvv1gFHpd6yBlpUM3K4Mk0Pbvk2EQOl+Bqj+kfU11r715ox2q
 v1PVkUaopQLXAfpfsFJI4yq++goSeCccgA4TIOUrqw2BUn06UmqSbC7LUg1P1WEk8bZo
 oBYEdrWNo+2CECvzInUzk0PieNMRIfEXq8xN79b5GrU1V+ItwHCv/wLSV0XFeEAWExkr
 C9QfX//iwYf/uWnlAW3avDPK7OiKXVI4NfewqdU6ycGpWP9z+XRucPjvGaDGpsM5p1lT
 yzSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXbLxVNhGwq4wEDqbJT+lK71gEHGUn0T1FUPnkGxqbQGBxNs4BySAApmPEMuZK2Hgg6S9zw969@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFpmLoQpj8Mb2PESW+CEFpcPYcC0fsbX3PrOL00HEM3Dl1CaMP
 5FFkmL/mjiepGuMA5xU54fSKPwUy2a/84Drw23sb/iY2AVUmYyJSN7TfzO48vFjNMT299x2hutv
 yO6DUDmOl4RWypYCYaYkEYXhyQrviMh+GuIIHf9G2J94gIJ1f0jlEqk6hdNhf/yadIHAe
X-Gm-Gg: AY/fxX7jXVDBg2H2cVX6F9oLp5q2IiTwUpPud7c5HUBCIUYKgW6KBuMJrP6PtZY4liL
 s/wMQAo+FaGH8IANZFVgbWenJt1WPdcR8gRv372AaxJZuxtjSedQUF48Gsgl5vithznoWN9eG1a
 SAgL17+ywE3oP19Q+pjQyqjmkCxAd0MyQwsVh91cqXLCu1bC9dOuCKKLcy+mEc5ptZ4ody53Wl/
 KD2ah7ZbTcl6uABDUM+kakXI/5LD0+w8jdIy8Wwp40xV1FNiWWLbbCJg5gxV1aZwoSPTaaiHRXW
 qk37Cp+vgmFpr3D6nRXTUlzWwT+G+9kcslDQZakrofO8lLouL6DgSClrid10+HBE8uATXomu08L
 FN+g9uVLaFQoR1pA98IcmWDb+dOhAZbaTIMAlYNktl+8MQAM9qQow3KYa4UIdMpWHzCLrPDTNgm
 2E4c5DgWaHOW+0UeK358VsiIo=
X-Received: by 2002:a05:622a:5c98:b0:4ee:15af:b938 with SMTP id
 d75a77b69052e-4ffa7819d0cmr23555501cf.70.1767668999916; 
 Mon, 05 Jan 2026 19:09:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6gVe9gCbUT6aZzLT7RdSvNX2QeKy9mu54pHXwxlm6rpJqOM6kkyLcNKbwzAr7F+zpdY6IDQ==
X-Received: by 2002:a05:622a:5c98:b0:4ee:15af:b938 with SMTP id
 d75a77b69052e-4ffa7819d0cmr23555291cf.70.1767668999498; 
 Mon, 05 Jan 2026 19:09:59 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59b65d0d22csm242869e87.37.2026.01.05.19.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 19:09:58 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 05:09:55 +0200
Subject: [PATCH v3 1/3] drm/mode_object: add
 drm_object_immutable_property_get_value()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-drm-fix-lut-checks-v3-1-f7f979eb73c8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=OHanLuFuc76947yU3WzGXKL8IflDYvhJa4SYngSj/Nw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXH0DlMWQWECsl/rW26AE+Le0PH4Z89ea3vpjg
 tWGIWCs/zGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVx9AwAKCRCLPIo+Aiko
 1SAyCACnEjzdAMzpyfkO6PvtCf+G3DKX8uG1K088anOusXdpHWWFhRk3GtMnCS5LCYqNRKYUYwJ
 Ytbagn9GTFUuoGQLESfr2Tf0CnjUDMKiTEXwNiGZysydZrW9zBqnJUMnRn8pOvinh4vXvVFKhrf
 6c+WcZ0aSoNz54T/S0liD47Zhs5bMoJKvlMVLXP0qYjiceK3dPFRaSc2sl857rTvfCxxPa0WG6R
 OzStJU50ourr5HiMlCX49zusfzqsjkfF0jgbMblI1D6b3Db2/VRobXLtfeQOstro5PjC+ijLS0K
 GuxXxLdYyF0BZq5TUBES6CyaTl9+jrINf+WW2rxJAkB3imVF
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: zkSyDVllzVGemt57WH1Iymxfqfr2g_qp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAyNSBTYWx0ZWRfXxvAR4VPkwN9+
 fp7Zs4NvRKgyJSnX02+KTjPvRzLdllu/PaJom0Ou6oGFC484I1jcVI7inwVzCKl0OCI31Mqzy5m
 /hlR+iiO6PlHSzBJMxUV6mP2E7Zy8ZpjGbkhmZmF9QOkkxiUtV0S1hOwAz/ZMBG8Y5a4vPpeueg
 TW+Tr5rUioGxDfXgrWSoaaYyOa0fjWRXlKPl5dDogL/S7uCSbo9RlregPokvl9rd3PAllkFRKdx
 3nmQG6BgTp8wk3+131iu0HwU4AfKeGYuL0V9jFO5+DrcDW5sr28UYjlG7Pg5y/MjhAIFyGZ5Qis
 PcwQfW2maLrDjlOUN8ktzlv+Y6meP9J4vhar1jC3H+lrBVIkIYhchWQj9zVUjunQWKMSPDZU1Pd
 bE0vZJNDRrDCaDAVB9ebTbamY5acXiTBhnsVmEy7+GAxCJmtE8awR8EJSAkSKsP1JlaUetXQKFp
 zXWY52ZdPNNzCsbluMg==
X-Proofpoint-GUID: zkSyDVllzVGemt57WH1Iymxfqfr2g_qp
X-Authority-Analysis: v=2.4 cv=FK0WBuos c=1 sm=1 tr=0 ts=695c7d08 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=uUhA93nX2LN1thLMeo8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
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

