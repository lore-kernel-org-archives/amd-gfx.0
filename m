Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB11D3E77C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 19:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D38910E6DD;
	Wed, 10 Dec 2025 19:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IfGcGQaF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H0w/W8JI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE4C10E6DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 19:43:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BAIRTC23358991
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 19:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ryq28wshLI0oIjJ4PKrZBvj5VmkNPho6G1e6vywuGjk=; b=IfGcGQaFGSoAHFkY
 +Bdz88h6xLBPeCkhZrACck9CpPp3PcNndJfWJ0cPM2kSMViBgxxaj6ym71aAVqKk
 IyNnbjWcf/oY0A0oEQE944GqVbHtUizt34we/1UYiTJmuq0qUx81vCqbWw0NOdfn
 RWyJhZLeBgVUIRnUzXUemroSFfUJObYMTIe+kkIdctpE3nGc7dF7xKOxoLdc1GBT
 p++oxTOdq6ab4+g0jLCaSJz+7UUeWbJzPgFh+zl0SbVKrOJ5uyOHS6a39SG4wrl8
 ICSr7kejZWIxNY2fdlzoi0+BL/S8CT4J4Hv5BSxeh0TLECvZpiVaHJo+1qot9n0w
 ZKU4rA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay7pp1qsv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 19:43:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ee21a0d326so2848431cf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 11:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765395782; x=1766000582;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ryq28wshLI0oIjJ4PKrZBvj5VmkNPho6G1e6vywuGjk=;
 b=H0w/W8JINTd/Vliyz3HTDnI8WwCX2lE+IZ+vicFaKwWYsgfHRG6TJi/NBHgzOTNvjT
 x8+ePZ974SIf21Uxc27Hl48PDh5SFLBvP8utcP+EgoAAAr8nycvbvqyQKj0xaiMpXHAt
 lqNUmmHZ6TRfeVkP5MTmxP5seFHUxWch8AT7IQfzNtvQG87f7QvIkMObq7lUjCmNX241
 XRfZf3JevATW8VqylA0moozwYHLNSKgQLakTF7Z7F1HNfnvB2BMEePqmSh73kIDZ+/Kg
 ZSXdcz9js3L7aS5AFosd/E0GcZGea9rOOZu21wZk8mh93Ij5Ha7sHJgeUaIwJTuGh0Rl
 Zj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765395782; x=1766000582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ryq28wshLI0oIjJ4PKrZBvj5VmkNPho6G1e6vywuGjk=;
 b=XkxNre6KA80HQporXwWSKeYr1fS3w1tp63kMsHI+YGQJiK67T7rMp9iwtMZ0T5RQVA
 yZGbp9B/0QxgxXq3M032fFN4MJpFe2qEpVGPFvPDGXKSp7SeXrcB4oag1kgF60w5+g7Z
 WaQGncpWpG+s/23KfTtI3gCXwYi7H9qINwiCDlJDNj05cKFw/pYzFnLkoNKjnogy7/B7
 N0rgtGsJ9WZv4qRESKE1l0/XG2rP8ObOZUy2FudHh0MBCYcSa5SVL1Ci3SXM8FvraXBf
 dS/v00FNmsQXjExWJe8dHTsmqrusITtq5gVj2G/tLMXLkLgQRCE0k2hiwo3zu5FB2jo+
 S0bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv6sLiH5N1jnH+aI0mVK0aSsGbe+cKTNGRNRkJuHUHnOpcRqawrZinluLCtjMc3bbbigURQrfj@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzjKFmLIkYhbZ5hxlZQyGWgwVt6EJ4ULkeJLHbRoE3k2nLvQGD
 WahvDaChCr/1DVIe8jhVeA+hSOIM1Rn5ueOfiPPUfW6F4twdyRpjjw8Q8NCxvnAvNJ19QS1mWu/
 9HL3JnRCHUg8mQhZ1GgPygj70SSKezQP+JNtGV3IjDqLk7UWKrV7HMVNGgurKroLJbXqH
X-Gm-Gg: ASbGncsx2OzwH+SEWAGwlL7Tohcd2mL4qdkN0+i9wyumPl5ScMuipCPs6O3w6kvpRgK
 +twlJt4fJQS72hhGswQdYZoPZPozoKPwK/P3AU5FyNFgZGHHLNbwFf/PZGAmQ9im7TaFws4oqpM
 iaecfnBK/TgWHKA7mdyNNkyoSNJpThuIdWzz9WKT/5vPJOfCO3D69dQr+PVMEVR4Zp+LgnybC7h
 5vILR9naKr/sMg0XI51RdHUH2Eh2Av6ket42574N09uqQJUOoCumFqkRReLULQbS9FyW03KGHbr
 zAPfYUxEwkK9A6zJASfkTmXqUyK725Vpmo7603z8J/HkHVaO3jJGy9/2OyFrA34NZ6qiQuwJtHi
 ApFZGopYLR07IbAiTlkxN+Tg6awmoETJjeOQB8oGnTIpMWOlDu24gTNi/wvFcb5oQUFr0Hml+9r
 zG4mhnIWyyvTg5JDRL+RHEylo=
X-Received: by 2002:a05:622a:4d8d:b0:4ed:df82:ca30 with SMTP id
 d75a77b69052e-4f1b1a4441fmr44111011cf.13.1765395782110; 
 Wed, 10 Dec 2025 11:43:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8Leq08Gnm+xIOjQRDoPg4jQIGdReNJ5+WQmPnyY2bqpauNc4t6EMMxDDUIMcGNH0IxdK3MA==
X-Received: by 2002:a05:622a:4d8d:b0:4ed:df82:ca30 with SMTP id
 d75a77b69052e-4f1b1a4441fmr44110611cf.13.1765395781625; 
 Wed, 10 Dec 2025 11:43:01 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-598f3199e93sm104845e87.96.2025.12.10.11.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 11:42:59 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 10 Dec 2025 21:42:57 +0200
Subject: [PATCH RESEND 1/3] drm/mode_object: add
 drm_object_immutable_property_get_value()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-drm-fix-lut-checks-v1-1-10ae38519f43@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=84spwcC+GgCGcy6iJaQp0NhNe6cV9oQI7NsJIN80HDg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpOc1B8K6ZcH9AGxBj1wYCLCUEBFjES9yOWFJCd
 h15qndfCVCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaTnNQQAKCRCLPIo+Aiko
 1eNBB/9mmJa+SoiCqubL6XwCu35MQeMCvsZSyezoTRIFzMWU+RXiMp65olwThsJX30j7QAoE62W
 6HeSC5PLSjTYmHU9xDc1knqb8PJsL+9S/kmPBZP8otKlBgPME8uv6PVG9etXNrAz+XEHCyAun+c
 Sv0N9yK28gVvH+ocJQPTSClSG03fiL1f1NfxljZNKK32G/71jhJiZ+/t9/vMWHbUFvgB0rW8WSd
 btYC1JzDRwyz6QznNlxhihVta3VR5KZQX1/VPW5MTPCmDOsGZJs01isKALrvIfRXc+UIbsbBIrW
 gwmKkcyKzx+3BhRkAlORsJmB2xTjzzOM7fuwJIYXxzECRJH3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: iCkEHC4Dvp29QVwi_e9Nn6rhufIew34w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2MSBTYWx0ZWRfXwbcW6WtSJmGx
 4jQGogSP/+amgdRS8Haka+N4ZWL3wIjAkPIskkQ1ZayOZDWP5CQQYdBN5/nSfC1oo6+UB++DFtb
 /W8UrHzgJJsdRzz6WPP9A+itN+av7D8v9lmIQ9Lw67FAOICgd4sUAQdpn5SE/7X6tSYOHkDkjoO
 ozsbCPb5LZnhsas4y20/tjfMb7ueyqqjwNXLvPmuBajuD3lzJ8kd45f2XxHzjd/6KsaXqdz4y0C
 H0rJjcPLaaJ18NS5Rmuv9Bj+N7zW5uwseFBLbAvNTR+GTJMvBDSwNFvc9HI4CV2UVOcQ9q3yQOs
 Yt380qyRhinlpe3FoKm+ofYnc8THJXvr0SjgHcIVZ8AmBLf6pnKhaK5J1spCxQuBgQg7CIEf1/Q
 qzRy+i3sjLqDJ+xDqepsJDaCpotuEg==
X-Proofpoint-ORIG-GUID: iCkEHC4Dvp29QVwi_e9Nn6rhufIew34w
X-Authority-Analysis: v=2.4 cv=WaMBqkhX c=1 sm=1 tr=0 ts=6939cd47 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=uUhA93nX2LN1thLMeo8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_02,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512100161
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
index e943205a2394..ead8eeafd012 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -384,6 +384,31 @@ int drm_object_property_get_default_value(struct drm_mode_object *obj,
 }
 EXPORT_SYMBOL(drm_object_property_get_default_value);
 
+/**
+ * drm_object_immutable_property_get_value - retrieve the value of a property
+ * @obj: drm mode object to get property value from
+ * @property: property to retrieve
+ * @val: storage for the property value
+ *
+ * This function retrieves the softare state of the given immutable property for the given
+ * property.
+ *
+ * This function can be called directtly by both atomic and non-atomic drivers.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drm_object_immutable_property_get_value(struct drm_mode_object *obj,
+					    struct drm_property *property,
+					    uint64_t *val)
+{
+	if (WARN_ON(!(property->flags & DRM_MODE_PROP_IMMUTABLE)))
+		return -EINVAL;
+
+	return __drm_object_property_get_prop_value(obj, property, val);
+}
+EXPORT_SYMBOL(drm_object_immutable_property_get_value);
+
 /* helper for getconnector and getproperties ioctls */
 int drm_mode_object_get_properties(struct drm_mode_object *obj, bool atomic,
 				   uint32_t __user *prop_ptr,
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

