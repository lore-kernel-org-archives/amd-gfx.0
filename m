Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B31DCEB2C0
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Nov 2025 03:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD50110E291;
	Sat, 15 Nov 2025 03:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPE3C7Y+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EWJMzuJy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A7410E28F
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:42:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AF2XuiI1258849
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wT7UUFJeF9mn5pIiD4ANC//sSw0eeZrazvonDtQ2l5k=; b=nPE3C7Y+WwNMxcDd
 VcbZKN5pGId/FkrF6+8vtv7H3aALmWVblX5ADLOEleC1tyLU4nTpc3n733hPzqE2
 Hegi9dIm9GzULEqdeznUfSkU9Uru2ZkXkPRRIWDArLoawL8Wnx6pYbCKxEHxAVnu
 Eu0BkP7yF6YaKC+LCVG63cG1SjyHDLT47NWHgpCfs25YwNuSwr2/HftYVR8ZMIoE
 NuHcf9oid7pLwSLCUKBy5qY+s9M1G9qTOZTkRcVA5sN//DnsM1eEUOGbMXGApC6c
 sf9QdYlA4px4T3QXm1/KbQPvNdY/yJyBUwf6DYpB8GR2GO4H9zQSqNCQJr7Cvv8t
 HivNpw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aeguhg3eu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:42:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4edb34dd9c9so71014881cf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 19:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763178174; x=1763782974;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wT7UUFJeF9mn5pIiD4ANC//sSw0eeZrazvonDtQ2l5k=;
 b=EWJMzuJypst5L8naRMv97vCRnblBwlIVyGGPy1qUbsLFHx9Z6OD95UTu+AUzeS08RA
 GfldQAXIpeUZX3hjKa4e3EyJ7JsiUaQkYcLFjIEvpbuwb9zReBYndd7dKT7mqan1RYZv
 p5MLQbbgSLJAcrb/+pi1NcSInX04NfznfqD+rogK1NeGjnRrXCVvElLg9sc2E8vOxjKc
 E99S1ogBdQDkuaO4qkspiJsW1OXpCEPb7Y+Tmu0q/X/jjnDKvPGOOrk8PrwKDAlHDKBl
 YC7jX4RPOpwA1c5Cu9Goud2aQxDaB2+cO0sV8Chwt67fhBe9EidhbNDkE4YK0izSOIXL
 U/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763178174; x=1763782974;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wT7UUFJeF9mn5pIiD4ANC//sSw0eeZrazvonDtQ2l5k=;
 b=r/OpFfi8V9UvUHXX1P1PuuK/7OeT06j+YuGXdViWop5JCbcgM3CvHdqC/HP1RkUpVV
 e4k+DGLR9AqLCSyA9/wjLosHe/3NX94i3HFV5T2pAsva+RmHMgdSDxY5W/edCg9gtykc
 RAyheroYavrIQA8oiFP5X9fF66rgOZ0PrxdDV3f94TAK+n/DtcmjoCOVPVVEo2Y/9kA0
 9QbLbrg92R1xG4YaLR1TRugF4R6XOJnKO++RH+RlhXwMQJahavvTDErLL5akMUJR5EAh
 pb0Ui32LSBiB14a1EioJZM853DG0WRVkSIjfgQE5vd7uQ3nTpuN8/1gMZ9jYVg5KroXF
 UjEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIM333L4dNrtpkoZy4n7Svxos/CGhZU6OAMDGqRiyD0v6cQu/i6skGFztMAiHwMAtdqi6K5hRA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGr0NB9zBc3kyg0A3xyiGKw15u7yWxW6JqhDqck/ReyDgrAHRo
 GwUFso1KQYndhO2Dw1XTw/YGAIQslsx2xxoU10dybCZyzKoRNtlwIy/tw/+XSxcgaae9cZyGuvL
 ho6TuvYdiqzRS/J1X19bLc85/uH8c3dgffN3V5lBLSvweQckiGJAUSnvrcnnBPwtBrqdm
X-Gm-Gg: ASbGncv2J6Ell53i1K3X9bE0DDF3yrF2cp+IPk1p6l/F4gHIrW5oZ/W+epkmsnH6M6L
 5p1UzN9WQbaQxjFXtq8z1zjlRm0sx4ZwTs/BuDn1vW14x/UtjcnK2PeJx0LKz4/fhPABDs9JwSg
 7pjilQlNxxB4QQGI9E9UMJvVedrzFQ8PxIUyJB4RogHWFmqoHK9SiJSfPsrkKHzxtF7j27CeooK
 D+qKyDhR0GCAGZLz4o8yrE3elmgxhDfxpERCrLEluBl41Z8KVYuDrQoAr5EBSA22TUy3IaxQ1sW
 UqmwbmCGSWZY13EuC2E9c+JYd+HsDa5EccVa+5N9W/JzqtJTGUHrD+tVIrBdQqIfECEG3JebtlK
 tHqNmwFOmC5Rko+LOaCB4XU6tHLCLTEVK46vdDM8tQhJmyEyHrT7pjpCdEQ3+x+i7UPCXdvpXQ4
 7nkOerZ6500HfP
X-Received: by 2002:a05:622a:3d2:b0:4ed:b4d2:bb1f with SMTP id
 d75a77b69052e-4edf215d86amr74148461cf.61.1763178174356; 
 Fri, 14 Nov 2025 19:42:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRpgJMMIbQfXn2B+yE5Q7cHj+2bp0JKnB91uXEQcxd0UHF9SIgkPuJeRO0IpkL2Q1fqtnrUg==
X-Received: by 2002:a05:622a:3d2:b0:4ed:b4d2:bb1f with SMTP id
 d75a77b69052e-4edf215d86amr74148291cf.61.1763178173856; 
 Fri, 14 Nov 2025 19:42:53 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5958040578fsm1475880e87.78.2025.11.14.19.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 19:42:53 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 15 Nov 2025 05:42:49 +0200
Subject: [PATCH 1/3] drm/mode_object: add
 drm_object_immutable_property_get_value()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251115-drm-fix-lut-checks-v1-1-3586f5855bc7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=sd03B0iyMcZ4bRpYzJ8B3NHXcAQ+vhzF9Y936LF4/JE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpF/a7Q390bzLrXrqU/SiCZtrKXA/1yNIqEBHBm
 UicFYwms5+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaRf2uwAKCRCLPIo+Aiko
 1a+aB/9LsO4ku/AA5NaGv9eaRTylr7bCF2cfqDSP28cQvEKbRuHYL/zAI1nU7Phf3vrpt04ZOzI
 HlM9PzrgvLuFvAyJewHxiIiDhdY1pVZqN70kwtvCnddMJ6Zf2H/qAfkENJepxI2+R1RhUzlJ+Lr
 WdX/8Vzjv6AWTLp/ixLnQHuqHV3YwbVEYHe1xGJk24qmO4Ulnnk3U+kE1VYMhNf9VCxM5X4ugbs
 DEMnNX2sbV/PC+Z/ATLY2MM11yDGMUIjnPlDplDSu8WDDINgQALCWoB30iLuriU1SoykBaZttCY
 iRK5t1YD9/lKGYFwyddW1sHFPpTim1NxZ0gbvfDU4puEa0On
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: HZfPnLeN2vDBqJLkAIelZdwkqk8J0cFE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAyOCBTYWx0ZWRfX84JaYW6iGwho
 XDTkaV19xQY11jBjsb2obMNxGT6qq5Ukbl7CY+r6vC+T13+lP/JemKHy/SaxrXYbG+mtOguTCUC
 Qhqf6a+ly9PslKfnscuJjhj6xCLaC4W1GfiLqQMPC8kXBHV8s1VKbRrEoBLEwL4pXGvOWM+8gUL
 on9W8sko3ifYMjYX3SNRWjC8onn3R/HhICttBiogsL73eqxkM/WzMOiGXHR/Chew2Dh+EcwLx8l
 +ilswpvG/beHEtnYT2DP0BJvpPOOmZoJ2S/YNGlZpmHdtodrB3jup6VFCMA4+WSlakUothRPEEz
 wVx8WF2ooPRBBCmZAWgKPufqtlEJ3jilYxquBsXHPdprOx43VbmFcbNmC4c3w7w/wZNnmAt4m/3
 zZVqQQ8agASu+a3pFP6fRN6YC17liQ==
X-Proofpoint-ORIG-GUID: HZfPnLeN2vDBqJLkAIelZdwkqk8J0cFE
X-Authority-Analysis: v=2.4 cv=boJBxUai c=1 sm=1 tr=0 ts=6917f6bf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=uUhA93nX2LN1thLMeo8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
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
index e943205a2394cd9c0d64b940a5e15ccff7f35246..ead8eeafd0126ee2028efc3ba747d37307e8d72b 100644
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
index c68edbd126d04d51221f50aa2b4166475543b59f..44a0d6f8d01fbcd9db3dc2d6d374f185459ae879 100644
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

