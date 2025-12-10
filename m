Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA571D3E77B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 19:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8460510E275;
	Wed, 10 Dec 2025 19:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZXSfmlIf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eeteY3ke";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FBDF10E6BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 19:43:01 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BAJ94Pg4013011
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 19:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tp2SrjM3ut1J2CotAoX20o
 6lXiPU098YctdSdpLfUHo=; b=ZXSfmlIf7Z/Qod+Psn1Rpyp6yc3icEcCq5einS
 SaZuIvU5RB3ivEb0T4gBm3LV5DI2IgH5UN9/70ai3a4n2f8nraOPN/4zO4YlcRDg
 EugCIyEJB87JIBBnMpwb7vsG4w0F8L21uRjspFsb0MkuDGRlJCtH3BxzxZoVNvfE
 iKcv+JWJgs2jBfcv8CIa9Z5nuXalFZeSAwkhMv+MKZQ8rJdQgAsq98pO/lbynJtN
 7DTee3dRy67VW54JqC7AtvHFWiig2DlxgI9Xp9rey7mi7WRPxpgG4pNNQUk6rpHw
 MzQVUCL7wCwHSq7Kl/oOK6UJkSBGtzt4Q4HW2oNT6ScwRAAw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayes1g3cb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 19:43:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b6963d163eso48326385a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 11:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765395780; x=1766000580;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tp2SrjM3ut1J2CotAoX20o6lXiPU098YctdSdpLfUHo=;
 b=eeteY3ker9vJ1tvqEcR9NOLpk0C/cTV9bIVlRNCeHdbYpfhIxiLle+Pq4RfN0EvwQL
 FVSokVsg8sSIrkmGiBDwqMJgeylQO2ltn2dIe74GpoXVxX1JSoFTzl0azczORxUZweiC
 JW0ZwFB06mG2PxxrJY0kSq4lGe3g5jJI2Q5JVjJOVCfF4KpJML0xD2uPrR+9Etoq9YPB
 YYZ9eLlrLS313pIDhpcQCC93uwRs9vEwKH/NFVvaqujMs7wwnUmNJCPSi7au9w0DrwoR
 CSRjP6zP6rR4DNNbeeAToHLN29pkYpLySHRgsRSGvGmGbhrnvbRISr/kJu51Hv08foOK
 kPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765395780; x=1766000580;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tp2SrjM3ut1J2CotAoX20o6lXiPU098YctdSdpLfUHo=;
 b=OrkJrAs1l7TeUGUYZY0PypOAMoiWEyhmngF7QlOGto5GBfnjl092IdsnG300B8rCjM
 t8rkGomnBVe95/ovfSkVfyIG41p8Eu5ThNBPFdQoPXmyflasw8hzdbOQFs3tDKC0NpU2
 3LhPdR5Ze6b8fNPOkqVGow9FOFyZRND1aFj5O91LuICQ91SVT9GBKAT8hddD17Pe5WwR
 AKaUUrxp+CurZwXkdrxzS26nBxQ7CCGIaMkIgFapq9IGcYrsXif/HISoluvC2HL5+BNO
 zI0nyLIvIpaahDpayE31E0TLjjYGV0D782bXevbAYYA6yp9aoh/QsVuwLjlLoA6h+Bd4
 0akg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL6AfcNawzo0dRnW86yYPeGtSwNAWeWxUHJs9KogLvrmV/0MqvR+k/p8sq1uMTSFOCWG+N0ryB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxP+Xl9BIVtb0M8SkL+CkcVBlAx/w78uXimIDD3Hx1qcWJX17gH
 b5wvNwectU3xzTH3pEFfdesYq4GYg2YGBUBsNmzCeqctP3hfhv0o3X86Xa2KZWNRX1+FrFnmlr/
 66tohnx6DhSaNOKnv+giF181gRiSgkIXo5JajcTa47hZ72cz2JaawoHjNW+uWLxu01PCy
X-Gm-Gg: ASbGncuoEPPb2p6vw1VAzhqZIqvPTaaSPRkkAK9BQQb5w3SxqeSQYZsdVBeACt9DVLO
 NzcHP7lcdzYaovoloAKxd/HMAddliFTMWxZmGWJT9cDXBIrwUFnRHGB91VyJEkPpI1yfZvVc54d
 zLhdugh3J4MAXJUiUdo6HEaUk6C8jrlAhy4HG68cR9cuNs5hCtgNEXN9WFALY4kJi5QtBJmw7od
 7R3hrwWzNMI6srlnj5lK45dNrrhPUthpeDxV+exe7IzepojrJ/bCv4eoUG3idKKL9/Vtz7DYHSZ
 84to/x/gp605OfK/5KnuFqjNcsg6Bavm0zANrsJTw8aHQwtlSE6tvxhelFW2e8svxfEH2d4RrWr
 2A6H55m9NaG/0fWQqOplXVu3vy1U4cX+1jV4k1BVpYKE/7vAOIcLr5VYbhs3R8l2tpxW1WcTEsr
 BJlfWajvCNWTR1mKd4G1Bszto=
X-Received: by 2002:a05:620a:2552:b0:891:9bb6:6b9c with SMTP id
 af79cd13be357-8ba39a5557bmr549904185a.44.1765395779906; 
 Wed, 10 Dec 2025 11:42:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwQ87M90APNT1G5dyO1V7BnT3I3yUMiuGnuKVGYNBx/MQE5gzeph5rWyWHbP5udM7ppIZJxA==
X-Received: by 2002:a05:620a:2552:b0:891:9bb6:6b9c with SMTP id
 af79cd13be357-8ba39a5557bmr549900085a.44.1765395779412; 
 Wed, 10 Dec 2025 11:42:59 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-598f3199e93sm104845e87.96.2025.12.10.11.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 11:42:58 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RESEND 0/3] drm/atomic: restrict the size of of gamma /
 degamma LUTs
Date: Wed, 10 Dec 2025 21:42:56 +0200
Message-Id: <20251210-drm-fix-lut-checks-v1-0-10ae38519f43@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=212f04+vA1L9p4RIj1VyYlO61ApIYXhcl1xh/Mmyias=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpOc1BO76Xx07350KCr+Ny4wnojRH4aJAOMdrBY
 9qAk91995uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaTnNQQAKCRCLPIo+Aiko
 1XbFCACWORm4MaA8RjD9mxjPpflh6/Xl5GbbOvO8tKoCXv7LFPbWzOoE1FI9HB5baofRv3ltu3J
 NqHVoAImAHcpH/TDRJjgohk2mCveXvH0ggJayj9xmCCt9fAFYiYKUhDacgKAbinDX4Jt/CjFKM8
 9P/hHGloQb6nXheMJ9/LGnwsHnwTlwWb1uwI0/9lKeXqntLXLrn/E3BpYrIxZLa2IURp87zTjew
 +XhWg5ZDJ1MzLexsatvl9W9QaODXBLplK/3VGYs/V8ZGX/eJzFUFAFMKy6uUK7QDvOELe3hQpDx
 zFj18eGWz1lLxtq4kNXuV9NBtep0in6Gyw2H3ZWdvH4fyH6H
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 40la0B7W23E-pV5954PJbMLKytR2rnXo
X-Authority-Analysis: v=2.4 cv=KqBAGGWN c=1 sm=1 tr=0 ts=6939cd44 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KipMzqLmMTXpIc6q-14A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 40la0B7W23E-pV5954PJbMLKytR2rnXo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2MSBTYWx0ZWRfX/FZDNoKmYElb
 lVRk61A3aksl/V1yLoHyQWzbCWusKKnAXkOQ1XDc67uuHLXtO/qj7Lmr20YWvrAybPdUCMPagf3
 ZF4kpNrvIWHNjsvvoH0BNRU3DxCVLq2c0ZwWVGfjWU06ziNub99efWmi5cgl43Pqc8mcEA/KCvQ
 o8Q/B/hKhLgePQU4A/w9KiJ+4856+mNd6t8GVP+uPIrPmGFgjdJiW2C4GAk+6xC8usg0cIWrMsb
 fZqvPh0yzRojFGf4xell+E9pyoHESnnGKcKyhvgk1G9sFrgbRqXBuzC8TnvaETD9gFUHj7Hmgi4
 pthMSig7BmCS+xBbfboPs8loH7gi1sAFl7qRKbehhTYxummTXEFL0EhYILhtykIUgmaeBqNZ7pg
 2T9Aijrlfp3KViKswpGhp6Sor9AXqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_02,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
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

