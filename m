Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D99CEB2C0
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Nov 2025 03:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F0710E293;
	Sat, 15 Nov 2025 03:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z5/ZteZQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DFRuhnyV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449F510E292
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:42:59 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEIQ52u043084
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BhpfJLji6/fhtqDCZ24EK575S0ON8OrjNodLzdYi1t8=; b=Z5/ZteZQFnfcvd9H
 zhmucCCTPYkD59BYzuozHbarBemxmP65bY/oVvwto7naAdmTmiPK8mOC9RWfu2Kl
 OVdSCVXOEQqCyWT2z44jvH1G2DWfTwwyMxwzG4BWjy1TxCGTA3ufSpLbm3JAZEa/
 dtSpIACUTz/yDcXAg6p7yH7fO183Mn0dWtB1fi+akEMJC0Wda/7YochzrqNfckIR
 xkJjg3ePCXJ9g5y0/qxg9t8BSUKXG27yGCKE54BpQNQu5glSWtdilRhMMKtT0/PK
 Oe+d7SDAqzqIxOBf6UWciFuaBK45AEiEzI6xNeQeUOZHNamQRuf5yQ6qEziMFX+P
 gsjiFA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ae3t9ta3a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:42:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b24383b680so221586185a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 19:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763178176; x=1763782976;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BhpfJLji6/fhtqDCZ24EK575S0ON8OrjNodLzdYi1t8=;
 b=DFRuhnyVD/pZ6S5slrTT99UoQKDHCRDGzst03eUBGKDpFW6u8KF0/dm5RxcBntAkF3
 I9i7IbsM5HJN0g168M4DrD7GA0Q+Gr5fbUX/GMeS2rLhrkUSRBs3migSLmTKF8jt6FmM
 Cy4D+8wWyZ4W0HYsttqgrgaWCMVYXfDBGD25Ubbbxk/SugNxb0gqYz3vk/uf9MFkUam6
 FYZOzW5Xvx8ba+rEICTTf5jc2Z+Qz4ruVXuy/ql2oqSIlkZMe0iFEKtCzDv1IPGj0vWV
 s7ipPwfqRwncdF4aw4MDuPXS3oRxpVA64z+exYaeuL/B4t6s/tYjKBAFpae+qI2PCzXV
 Oa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763178176; x=1763782976;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BhpfJLji6/fhtqDCZ24EK575S0ON8OrjNodLzdYi1t8=;
 b=AHsJ9+/Kuzy2DbzBcDrAAq4e4XFgrcX9rjNX3/VGMFgX3o1RmBHUvhNozYZ1HI6pVD
 dffXhf9qbGMmKcvV41a98bnpV98k67YsLdR3bygSxoSbp4HnWi098+Wm0MnrW6V8h9AJ
 WqLTdS3/NlmFBUqQxxViyN6+eL81cxYfZeHsEN080sBEreb3gs/pC5LeBvxnbH3ajfft
 LA2SY9dYAPIN+b4fyBDC7NuOSBuv6EsCvqsJQT2agWTAdY/mVXdzycIeWR2V/jNBajeq
 bFp4QlxfpM1E9LWXNZ/n7ZRCmFqhIiPstWYyXWE0rxXW6xYNGmyIE2VwzafITCJLFLU5
 IGPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOt/aYQ6RKF44VKJg3+wMJfq+qevFGYuI4KkRbLuluoYqaaUKSZkP8JPx6lsj7QF7EDKSoqIqj@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+RxwPzsfdzV0WkyMFPzH40XfQMuozmyfoUikzHDo+REROcfK5
 IQAKczr0PXTEBV83rGUMSy+DB5WvKZ0/AWbsn/8dEAUXWUgRihFObp9L7POTCnEdC/zjC5ibqiX
 pt2DAfyV9iBzcbcelVzOynuFoztpm0QTaGF3PeH15D9zm8goxAMELTASgoAP/YyD5CCGa
X-Gm-Gg: ASbGnctC4sU3O4diOrZl9+5rA4nTK3/MVI4qAP15ngZu4h0fH2IXqudloBP0BP0vPJx
 InyBnxeg06zg57yhAxKp4QMgLBqg50hK2v1J22fMNZGyhSFJwz+3aZtIMHKp/j+5pjT00K8cfSq
 nSreLvohrEmSvMJ7WSY72PAI/Im7TC3Ba4+kug0whwXkCRr9CvctjIRQa/UBKYKuTlr5l+UkqMW
 8tWbZp5SwpwvoKppz5KZbdP5EmNxspSNjXmM3cIcIiwMo52GHArHmFDMFGebyuxblKn2YDTDPjy
 TbZ1ivs8812QuovsmajnsbKGg4yWyUnnsAw61fh/vR6ncQBkYhgfoJtT5gQXeWdWm5jj6dp+sBA
 nziq7YQ/7daO7IwqeBk2o2X2kNiPDp7G3jdbyAGFwgQll51H3LE00P8IUaHpqeCY1AQQFawDXjx
 A1j0qYm70Op4Ml
X-Received: by 2002:a05:620a:390e:b0:8b2:77aa:73d3 with SMTP id
 af79cd13be357-8b2c31409bamr724154685a.2.1763178175601; 
 Fri, 14 Nov 2025 19:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv7gCdw6HKgZhMlZOXjPB0By0UhngBMETBduc0VjgNYn8qw6cDgmC2imheV8we/zNyBowEOQ==
X-Received: by 2002:a05:620a:390e:b0:8b2:77aa:73d3 with SMTP id
 af79cd13be357-8b2c31409bamr724152685a.2.1763178175004; 
 Fri, 14 Nov 2025 19:42:55 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5958040578fsm1475880e87.78.2025.11.14.19.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 19:42:54 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 15 Nov 2025 05:42:50 +0200
Subject: [PATCH 2/3] drm/atomic: add max_size check to
 drm_property_replace_blob_from_id()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251115-drm-fix-lut-checks-v1-2-3586f5855bc7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6345;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Zrx3F7zYvNugK1FdTfV6C4jbMJzk2pb6chyouaUp1/k=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ6b4t931fGVRZn/3KBwu59oo42C+gumWghjbqshfKxv/v
 E5w+Da9k9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATqchn/6fsMXPfam13vxMS
 koJqp88Gds9Qf9x8YWls8jHXysM3lnnHKSbt6jyfe+X6wVs3nK5t/Kuz+4ct3/Mduw6c2GxvWs7
 fF/LjQVussV4le+OepIdaZ1r9jYNE7Ctn1cq6OxvuDvRVz6zp7pScfYh76e3DJ7uZY3rXplboby
 v2ZmqL0HtanNX7//KCs4mcMlG1ylGclsIBsr6dqzJTmVUOBxgGPfwu8Hvi1n/2LQJROpnLdvUdC
 HGbdNhV8Wcaz70+zsnbxKs/mBXL3nvcsi47/Ha8hFfNYaPnbnFL167fekjkoMB+W831a31/uhdt
 ELRLb5hnZFp07TQrg82hE0sdlN9uVJjdWPiqRaeRaUc9AA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=IOAPywvG c=1 sm=1 tr=0 ts=6917f6c2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GF-90_O6f30kfN1CyEYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAyOCBTYWx0ZWRfXzrtiXvoX6QZ3
 2PXzScboq//5KdL4clKdtib1X3uFHJiLb3mLbmqc0gJ3RHzajzwx6NL7jyGtrOa/HOLl88khMhI
 2WhUgaj7pt/JEKxLBwOxrPbu92JdExgP30jHaOKmvTEm+juQhGrR7701A66uKlCZyhqvvMUif9t
 +mwhDkxk1yDLakIvpuop8IfyZNR99Cmz/Uq0TjfdozMVKFXUjsE6tVz553X6dnC8snaSnJkmsxI
 zq2srDIuyCjeK0n9Q28aax9q85VnW1ijq/aHy94XRhjqU23nvAc5VlWYf+F3xN2axDCBGIGbu85
 mhJwdWfpvPmdjqxcCNNKkAo3N6RburkvNJNgiv3KsqdFFhh1aCGVfh7902kK2uCogJ/Z58MZMgx
 vMSxlrxkeb/xculvGqwFSZzxrYsAxw==
X-Proofpoint-GUID: SxvlODAV1WgmZke93dEjzoKHB_QV-pp5
X-Proofpoint-ORIG-GUID: SxvlODAV1WgmZke93dEjzoKHB_QV-pp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511150028
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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c |  5 +++++
 drivers/gpu/drm/drm_atomic_uapi.c                       |  7 +++++--
 drivers/gpu/drm/drm_property.c                          | 11 +++++++++++
 include/drm/drm_property.h                              |  1 +
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index e027798ece03226338a4ff6ca9e06eb77436bac4..d19631b5d9e1237849e081b156d23b933848faef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1677,6 +1677,7 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
 							&dm_plane_state->degamma_lut,
 							val, -1,
 							sizeof(struct drm_color_lut),
+							0,
 							&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
@@ -1695,6 +1696,7 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
 							&dm_plane_state->ctm,
 							val,
 							sizeof(struct drm_color_ctm_3x4), -1,
+							0,
 							&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
@@ -1703,6 +1705,7 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
 							&dm_plane_state->shaper_lut,
 							val, -1,
 							sizeof(struct drm_color_lut),
+							0,
 							&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
@@ -1716,6 +1719,7 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
 							&dm_plane_state->lut3d,
 							val, -1,
 							sizeof(struct drm_color_lut),
+							0,
 							&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
@@ -1724,6 +1728,7 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
 							&dm_plane_state->blend_lut,
 							val, -1,
 							sizeof(struct drm_color_lut),
+							0,
 							&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 85dbdaa4a2e25878c953b9b41539c8566d55c6d9..7d2076f1006e976de73c898a838ceb4b5c4370e4 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -388,6 +388,7 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 					&state->degamma_lut,
 					val,
 					-1, sizeof(struct drm_color_lut),
+					0,
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;
@@ -395,7 +396,7 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->ctm,
 					val,
-					sizeof(struct drm_color_ctm), -1,
+					sizeof(struct drm_color_ctm), -1, 0,
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;
@@ -404,6 +405,7 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 					&state->gamma_lut,
 					val,
 					-1, sizeof(struct drm_color_lut),
+					0,
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;
@@ -546,6 +548,7 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 					val,
 					-1,
 					sizeof(struct drm_mode_rect),
+					0,
 					&replaced);
 		return ret;
 	} else if (property == plane->scaling_filter_property) {
@@ -741,7 +744,7 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		ret = drm_property_replace_blob_from_id(dev,
 				&state->hdr_output_metadata,
 				val,
-				sizeof(struct hdr_output_metadata), -1,
+				sizeof(struct hdr_output_metadata), -1, 0,
 				&replaced);
 		return ret;
 	} else if (property == config->aspect_ratio_property) {
diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index 596272149a3599130186a470e5a5a3c1150b377d..5befe443135d3861289183d1b6fa1ac0e5e46515 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -759,6 +759,7 @@ EXPORT_SYMBOL(drm_property_replace_blob);
  * @blob_id: the id of the new blob to replace with
  * @expected_size: expected size of the blob property
  * @expected_elem_size: expected size of an element in the blob property
+ * @max_size: the maximum size of the blob property for variable-size blobs
  * @replaced: if the blob was in fact replaced
  *
  * Look up the new blob from id, take its reference, check expected sizes of
@@ -773,6 +774,7 @@ int drm_property_replace_blob_from_id(struct drm_device *dev,
 					 uint64_t blob_id,
 					 ssize_t expected_size,
 					 ssize_t expected_elem_size,
+					 ssize_t max_size,
 					 bool *replaced)
 {
 	struct drm_property_blob *new_blob = NULL;
@@ -801,6 +803,15 @@ int drm_property_replace_blob_from_id(struct drm_device *dev,
 			drm_property_blob_put(new_blob);
 			return -EINVAL;
 		}
+
+		if (max_size > 0 &&
+		    new_blob->length > max_size) {
+			drm_dbg_atomic(dev,
+				       "[BLOB:%d] length %zu greater than max %zu\n",
+				       new_blob->base.id, new_blob->length, max_size);
+			drm_property_blob_put(new_blob);
+			return -EINVAL;
+		}
 	}
 
 	*replaced |= drm_property_replace_blob(blob, new_blob);
diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
index 082f29156b3e3fd2de0d6a3864022388cd61e17d..aa49b5a42bb56d9331d8d3397b150e33aae67451 100644
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

