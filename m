Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCA3CD0433
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 03:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A803410E329;
	Tue,  6 Jan 2026 03:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lwUUksny";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R0m9/TsN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAE810E2EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 03:10:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6060nGgm3114826
 for <amd-gfx@lists.freedesktop.org>; Tue, 6 Jan 2026 03:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kxx8tCQDWmw4x8+Q9ke5IQIT8BfxOOcptitDY8TgftM=; b=lwUUksnycBGhL7QM
 V7gx5qNFpCeiw+Cna0vJBDJK68qs4bZ8FgpYN2vvSxqr48Jwi+fn9yBdAVrBFEoE
 O4aFpKBK3flnHCxiJ0GH1BqkaubH7c9a53awgHWdIsahx+IbK6TiDNGpLW1c7w+8
 Vy5/6B2aI2NqKSXUgvuEjgHTgRPfq36QkxCf7iJAZ4ERtP45bL9OFhLOqe7hrRnC
 JYzb+tUQU3J0HFSseBUBFsjKwk3NA0jJ5gHeR0AmHiVqpcTHnjWnEeyv7w/P25be
 XNXQbV3jNWWB/vJ6/gKGB7LnJofobF3QDBJpIqUYDyLqvtQG8Kc9dinFdY4k2GUc
 mOsoFA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgmnh8u7x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jan 2026 03:10:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4f35f31000cso8537991cf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jan 2026 19:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767669008; x=1768273808;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kxx8tCQDWmw4x8+Q9ke5IQIT8BfxOOcptitDY8TgftM=;
 b=R0m9/TsNq9yC9zImxqzTkVni/3yDwB9+llqTLPW5vzdYcriqyp+IcrbFgtVGqI+oGj
 6QEsuj8L7Dbax9n1a1vnOe6ekL7a9J+HzhMSFRkIrB8sn2OIoRpaijF+zWO+UvOG4Dhl
 iuIbgmmiKXaG07LA+hrXk+lNOZ8M0b9GcOEhm9sqFUSJsjMLZ0SwFvJEsdX8o1WAZ3I+
 OOdTC57iKFnI8vaYjt6OqGXHJL6i7qw+d4t/w5a3ymUmwXSLdiZbTD8JcaCs8pFS6ysg
 wLzdDPqEIAleIpDYU71PxLrEkNTX5eaZvRr47ONdoxGI5HGv1uUiZeCh5DYzX9igtD3r
 vyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767669008; x=1768273808;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kxx8tCQDWmw4x8+Q9ke5IQIT8BfxOOcptitDY8TgftM=;
 b=wGCYGjg4tv0hc0MdCgmVkvVLED1tkFY+eDDntikPo6OOKTOhb7kGjNuG6xq7twghLI
 lqwQ5zHZZkMu0ujwBOs3KQkHNXV7cVDynBxy5pfZJy+EoAWken8qcrO135MhR/tKJ5QM
 B1P2k64iUiQtsA2z/Vo4Wjq33tYLQzicdkP341GXcL8OmBHg5LD6bQiKQNAGfvtmsDRS
 WtXvPpmvUodtpX7MjXoh4ve6Mly5zLy922wMU6DtpduI36s60NGh/wHhPCJILFJCRIhq
 Dd13mu1a1rdmfKwJ96VuWqKWECIUnYeEySRkDF0TH/R81lK0GcPC77GYNZ3TdxIHfme1
 rT9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrxHgZLjlqGp7Iz26bg5pUedtsqmtqQRGIRP53ylgDH98oTO1szg7zDpwZAy1tOAMckiz5ei7t@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1GjoVpqlTokKBvGNOWlVNtvf6tiJxn9Mdbo9U5oStTKxs0inA
 4Qzgp/VzWYY8iJGK6xMKffEzWb857nT02fXNlpGesAy2ZtfWnQyHpyqV18urSnSf6NwA68b86XZ
 KhQQFd8jAREBt6XjVwArrBidfnXPMoKU6SSD4pYQxBZ5Xheip+bJ39RNmEUX7fDDWL6v2
X-Gm-Gg: AY/fxX423JqmzND384FSR2OWgxtMCKFdfti547n5QEUwcW2A9pbU/emJWwkIL827hEh
 TX2KjX8hsbgSGt9lJRNyShagDqSVWcibG5BDygSfV4fTXyfZgOWmquteZ6ZCT0YQnEz1KzkF9VX
 rtHJ8GNt5/gBAB0f4PSzo57RFnKLvwdUlBHj6Aa8o3Td5FKvSo5ygD1DwtRvq+b1rCa3WgASn2W
 gNYMXO4UGWhTK2miQ+Gn+VZQ/gKgDmH+cczeDJc0XW2F5nqTaSWA6PTCZpzzjVDpnejs0E8GUSl
 VaTU5EjeLBETlF6y4EI4cA35q6EoegeUcZ7CBmKbSyCVXOi44VzF+aLUc6nCQHnhYnzjaP4V/lk
 LJeR+Bt/k23y/N6UNixPhMMyxLBjI0qCrSm3JJJ7bkVBZYedLLgTe3/UulbDJaF2NQFc=
X-Received: by 2002:ac8:5a49:0:b0:4ee:1903:367b with SMTP id
 d75a77b69052e-4ffa76a1174mr27539081cf.5.1767669006023; 
 Mon, 05 Jan 2026 19:10:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUYnowTv6MsozrIb8LDtbiyw94oAdi29kas9IpHmTtL4k6cthbrQfc1CLNz0JLTyR/dDvm0A==
X-Received: by 2002:ac8:5a49:0:b0:4ee:1903:367b with SMTP id
 d75a77b69052e-4ffa76a1174mr27538641cf.5.1767669005516; 
 Mon, 05 Jan 2026 19:10:05 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59b65d0d22csm242869e87.37.2026.01.05.19.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 19:10:04 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 05:09:57 +0200
Subject: [PATCH v3 3/3] drm/atomic: verify that gamma/degamma LUTs are not
 too big
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-drm-fix-lut-checks-v3-3-f7f979eb73c8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CQUkj+reftSe9Iid1OhLuxp7qZp+MAIvsJPwVl+a6RY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXH0EwOmRyu9Cnxu6D/YykRTPVffVqbMsthR9k
 9TD4SOlAxWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVx9BAAKCRCLPIo+Aiko
 1V/0B/9FfTKkq3SbmSHXtswAti0IbUrsa8ReI/ywGQd5c497iNP8yFMbfaCFlF1iHUVlyYY2o6+
 uA33c0tVXM/epG/henHRiaSdzoHTVkmhbIQ1if8GnDD4Wbo/t9P6Vn67MPf/e7POjuXlpMw4IkV
 6yO3M2fYtLv8dL9fQLg1Mj3LUyqYqaUPgoYVAu6TfcOapTs+Gl+eySbYzVYqX8ab5/NOtHn9YLF
 /DLHinUl/NmfbfDQ2voVT/EvGt7mrelzzYvYAYHNJbR8o8x9namlclukOvEg5oTqElL+h7xUN4j
 WA9Gh7hoQ2qV8iEkYsCUzBKczr0ifWgWpniuQ5iAxYG7Q/XZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: nlPms_s6TB7M39CNByy_e5yKrcl5PTVe
X-Proofpoint-ORIG-GUID: nlPms_s6TB7M39CNByy_e5yKrcl5PTVe
X-Authority-Analysis: v=2.4 cv=Vscuwu2n c=1 sm=1 tr=0 ts=695c7d10 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAyNSBTYWx0ZWRfX1CIj+rnjvEpm
 L7TpA9b3MqzE/nk7U4sKAC4gTMIs5V6yAZ2XNE3jffN3vo2GRcOuT9xW7OBoRUa+MhO9/T1S0KO
 5i7PF2trsBzB1qwteDtrYKfFMSb0VLi+H5QjPAdj0iNkBZrQefnZH+k0KWji5axSKkyKBUwQXBf
 BgH78rGq6n52GqwDKZ41rqrXuUJwlKHHNX9d4wUJCwnPTQ/GcaAvN3bd/tj1AQdImtUIYMPvs6f
 1YKyx59YN3s2ZDirwgVJUrMktdDNfL1h4v4CYGxncsH6cFVVoaxb+7RzdPTOLUC8ecshjwmKx1w
 acCyYhFX71+aG3w1waD4/X7ejZ5njbdJlI2pN356UQGEf8WzMFO0cApec+679r1LBPHoRyGVQK9
 DUdj21Btxj0YLw4OuNpgXgW3RiTli4TwIlZ0SuxAm1q+ETk3smdPIk9UCt3JyB+qaz1+0arIpMg
 EbGIQRS0mtP0oGzRTsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060025
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
index dff1fdefcbeb..dc013a22bf26 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -413,10 +413,19 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 	} else if (property == config->prop_vrr_enabled) {
 		state->vrr_enabled = val;
 	} else if (property == config->degamma_lut_property) {
+		const size_t elem_size = sizeof(struct drm_color_lut);
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
+		const size_t elem_size = sizeof(struct drm_color_lut);
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

