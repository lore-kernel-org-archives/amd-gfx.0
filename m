Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D27CEB2C0
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Nov 2025 03:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A35C10E150;
	Sat, 15 Nov 2025 03:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lV0SugJZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IYAszwSS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD79210E150
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:42:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AF0KTgo1137189
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tp2SrjM3ut1J2CotAoX20o
 6lXiPU098YctdSdpLfUHo=; b=lV0SugJZ4X9IqMom3rdI7sgPsrF1Rl8nk0Zujz
 6/rqtD2n1bTHntoSU9aMcNNzvOEK1J9FD1NNqJmIB40udjdEGI38RlIeklPfjCTF
 tFLTcz6E8FiqHtyyI2IC7t5DCIxYPucotHlBjPxYAFYAtraWDAQ1QCzUf+QZ2gGZ
 riONBOMXDPDyutpc1pc12lrnuASLAMXsNSlOL+fDte+WnByRIHhylzJh0C2YqDg7
 hFPK8cRsHSZYsbB5UkZzBqrEk4i73RnwBvIDWQRbpQuX+MkCex7iZRJmMge2zrFC
 6K0+DMSnnKoOYUQYbEsCXckJPpFp0Nh9pFjy+hlj4EJLtz0Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aeevpradf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 03:42:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4edb7c81e0fso76749671cf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 19:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763178173; x=1763782973;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tp2SrjM3ut1J2CotAoX20o6lXiPU098YctdSdpLfUHo=;
 b=IYAszwSSJoQPDDt7+VvIerp2c8iNpTedHDSPUgvobG9J0mZpVA4zmIgr6mWM513rMi
 n4nc7KwEWaygH973/9dNV7CcerenjYhEr3HlazPUhbkSDbOyIsLXej17x2pouEa5x+Q6
 ZCj1EEYdA+KPRdky0dmWK2AyQenOHbK8k/4hz5owHZasHo3j/CV77oCW9dIkWVaDn/0B
 w6kdY1m8cExtjFxeZkRk6shAz5ACuE/ahc+jUnh0IM3nSdV6NuBjAAg9fmSSgfrrev3Q
 5wbYv3eyGfn0h+r+/uVJnad2s2OG5/4ImXFxY03eoiI4QRhd1Hk6g4wUqlQ2JYKo50+l
 gCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763178173; x=1763782973;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tp2SrjM3ut1J2CotAoX20o6lXiPU098YctdSdpLfUHo=;
 b=rofkBjqbWAewX3DVukCZI/MNOb6+oIEPDF6GNMt0FryGihMtxMGm7a/iXMTccU6W+m
 DLI1BlMY8rTP0OvtZnLFqU7Xtcg/1SXYKY2f7nIMM3O0+ti68loncY4NNMCKsnuvNfT4
 4KsfmYEhIYEZHVUzhBelIuWX9daqdO/jwmsEtwSdRAItqB53JEdV7NIYkYUDvJP2gEnE
 8c/5Z/2OwxYojmP/mlCLYcnOZbB9hEXCK29ijQV4DGxxW6oEixOn/5yWM7z4ti3MjEt/
 hq5fZ9WXQ6+CMutpD492cUUh336pY4iZqTtc5uFgtdHAeiGF2RiuX8fEfxIPhO/W6D54
 draw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWgtOLjZu9NUOb4ZlTYJIJtis62zHqf8+Vp5da9oH6ZZqPrAagclgLYkvIdak/4PVkQaatLtE0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAKiKSkpLBzTBkVEMQmtK3Z+sclo1TkRsEWdA+yEs+CVtUZ781
 Rq6iU4/tzbt6AA8iDEX6ttaK+cPoIk3M8+Jma2ZdP2qa7uDjC3t5aHfHltFcsjLn7+yJxbQBFBy
 JWHeHVJVFoClQVS1adMbiHsMCwP8H/lhorkBQU15lJSMTCSrnFn+AByqkUrrnIiVXkmuU
X-Gm-Gg: ASbGncvxUWrRTUZQ4Hq7fSsZHoKhzRoCIVTFzDN+spHldlUqPioU5FByeFtzdjDDi8a
 jsbP/AS8Bd3i2nMTzfVM0gFMzsuN1SQOlMFiMx+zOvhv38r2gmT0o8yjB6FZfrqiqqbzIoR0XLQ
 /xoLoluauu1qHnNlZdOtQZdAdqeD/PPMdpp2id4jNXL/dXNHXu6R+3qca9CEwO1FiecSNKI389s
 ujW7kPSPGFVcDcrA9NuVsdNF9hC5xhG3tbting5tBWvkMUhYrek//b0AAwhR0apec6AR4vklRsH
 gdyBeO/sK2eexFMPhFVz6rLzWP+EnSAiWKQUcwQ2PeFnvWX2cJOE9RbOAv91DAu5ouu37uagB5i
 pZr8BTqQf6s36RZVfcdnecXg/AnMdqsAOh2VfxQK9oqCAGM/0ZDwDBe73GEEPGpJtzdNbwAOHd8
 yeK88b7tLGkdZF
X-Received: by 2002:a05:622a:1343:b0:4ed:43fe:f537 with SMTP id
 d75a77b69052e-4edf215b06amr82603401cf.76.1763178173173; 
 Fri, 14 Nov 2025 19:42:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXyrH6DMsBG0plYgS9XMaYlKbJKjEyuvQp2iQjMHxRCVfSG63Qze/dppmv24ucgzgaTnMWug==
X-Received: by 2002:a05:622a:1343:b0:4ed:43fe:f537 with SMTP id
 d75a77b69052e-4edf215b06amr82603201cf.76.1763178172715; 
 Fri, 14 Nov 2025 19:42:52 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5958040578fsm1475880e87.78.2025.11.14.19.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 19:42:52 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/3] drm/atomic: restrict the size of of gamma / degamma LUTs
Date: Sat, 15 Nov 2025 05:42:48 +0200
Message-Id: <20251115-drm-fix-lut-checks-v1-0-3586f5855bc7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALj2F2kC/x2MQQ5AMBAAvyJ7tkm36uIr4kAt3aCkRSSNv2scJ
 5mZBJGDcISmSBD4lii7z0BlAdb1fmaUMTNopWsiMjiGDSd5cL1OtI7tEtEMQ6Vr1oZIQQ6PwNn
 4p233vh/1emBeZAAAAA==
X-Change-ID: 20251114-drm-fix-lut-checks-4bb325e24110
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=212f04+vA1L9p4RIj1VyYlO61ApIYXhcl1xh/Mmyias=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpF/a7CVPaOu6IdvBY2A1EDME8rINrM/I8HPhlv
 BhGJkPLFrCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaRf2uwAKCRCLPIo+Aiko
 1STEB/992pzirGjCzs5QhcfsrJ4JhMOAy0zI8Mmx2xAruD+ZsuG8rxhnxJdoWFkPNsVKPixHB5l
 I+vbaMa4o38dH+S7ezTj6CnagM1Y2s05SUkUm01KvCNGuiTEuUCm152B1FEZ+8jOFxEShqIqoAa
 gXXUj4CsB610T2zW82Nm01aIndapup+SUPcduWUtN1zD4VI0Y36dl6EUx+Lp10nWUdQMo2K5Bli
 8qE2J78F9XoHkIC4Lj5ulUL15Wao5YZsPHH5rrUHxVz0x/fBx2XQPS0SmBEdvVg8zXQEH1Zpuzu
 aDnUpjC7PaM5F7akJyXy7KFjv3vo4etW1VZZrYWzqSwOyJln
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 2ZZlnM3iDaB3zalYhZU3u4zmo3xflMSb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAyOCBTYWx0ZWRfXyypdUR2H1DuA
 1bbJ3b+aToJ0KMc7iwrkcDHaHdYOsE57sPGrMWp9jZryG9wiK6vdfFr8CYzBsWsVI26TUjLrPJP
 7OOig0HD9iYD61iDDUj3PpJqBqcayYc4fYK4/khsw1dv7ede2Ci9Z1lPIjT71uJNm4j5kHraBWN
 YTiYxFs6swyfTs4YpQVBgaAwDn6OtPirntpnHk5p+v1p5SmyMdtM1/uyJlxquwOZB8dhYcJWEyO
 P3wUGZnysA1sRmw29w8zEqjxagCoENcKSF3CKebRnhPeW8xu0fviS1J/O136BLh8aF/FHfrjhFD
 f/OeenaJQWDgOiWF60xV76Ra7GTW16gI0f+Igh06qx7Zqi96Kj+ys+IAuWa701/yeEg8Nard9+E
 zx5BpWcjixNzh5qM2q7j3FHYtQlTjA==
X-Authority-Analysis: v=2.4 cv=NLfYOk6g c=1 sm=1 tr=0 ts=6917f6bd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KipMzqLmMTXpIc6q-14A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 2ZZlnM3iDaB3zalYhZU3u4zmo3xflMSb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

While picking up the Gamma correction patch for the msm driver I noticed
that kms_color@invalid-gamma-lut-sizes and
kms_color@invalid-degamma-lut-sizes tests fail. These tests attempt
submitting LUT tables greater than the size specified by the
corresponding property. The issue doesn't seem to be specific to msm
driver only. Add generic check that LUT size is not greater than the
size passed to drm_crtc_enable_color_mgmt().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (3):
      drm/mode_object: add drm_object_immutable_property_get_value()
      drm/atomic: add max_size check to drm_property_replace_blob_from_id()
      drm/atomic: verify that gamma/degamma LUTs are not too big

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  5 +++++
 drivers/gpu/drm/drm_atomic_uapi.c                  | 23 ++++++++++++++++++--
 drivers/gpu/drm/drm_mode_object.c                  | 25 ++++++++++++++++++++++
 drivers/gpu/drm/drm_property.c                     | 11 ++++++++++
 include/drm/drm_mode_object.h                      |  3 +++
 include/drm/drm_property.h                         |  1 +
 6 files changed, 66 insertions(+), 2 deletions(-)
---
base-commit: ea07a751fbf3743490a463ce6cc5828e6dc3c660
change-id: 20251114-drm-fix-lut-checks-4bb325e24110

Best regards,
-- 
With best wishes
Dmitry

