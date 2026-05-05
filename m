Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801FCFF885A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 00:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0591710E01F;
	Tue,  5 May 2026 00:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fjvPE7hn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IudMoqlM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA95C10E8CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 00:25:08 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644IhVad1150966
 for <amd-gfx@lists.freedesktop.org>; Tue, 5 May 2026 00:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7QLod9dRReugtdmt8pQOfg
 aPMeJva4633ho398t5P0U=; b=fjvPE7hnM88jQx30FVC2ZWXIf7TWjGN3eYN63h
 Ue571PL1sq94DOGQ/hNxaOgRi9+dU3csOkwJyqFcxBF533sMQMW4FAE6r2LAiXsY
 6Ml9hkYOpYnhamv8OgGXa70y8ygkyPhvR5zoSKZ2KVyB+mVNmNZgEgiWz87aL0vD
 u8PSYdhEl6Tp1krK5PFbfmy3M7IA3owYqXO/yfXArBBc2zjcMp4QfOOEdnfbwLTV
 9K6KX+RFqZhLp2N/mN+bRVxGzzz/jgkGZzY8phKOs+6WzF0oVLH7LlPCKqjvpWNR
 7Q4+ekzx0uBChicnA/9htOSTwyoxl1XtuVlJmDR1sK/eOEmg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscyasem-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 00:25:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50fba8d8c40so121968301cf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 May 2026 17:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940707; x=1778545507;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7QLod9dRReugtdmt8pQOfgaPMeJva4633ho398t5P0U=;
 b=IudMoqlMrhFyDDb8pD/MR6yU+cMH7xU4+BS44ECdkryrpBAi3uOmX1j/J2HsiaLd4I
 A3E9Bmz7YDnrWTKS7O2nts+7d+5SJPG4QaQGl7+1N1JNc0X/KGxIFqPywfhrwAAr8k89
 4ND4TZFsyTnX4v1QfTgzriAxtIa9ibQV1gcoIu0g4+Snn5Bv78lGP9CD+WmvGkvYlJ5k
 Wz7thc4cvS3TvLbls2fUZHrjfq7LwTLV4JpVOb7F22Qz377snr3cU0hJk7BFq5skvIBc
 CsvP6VdXPjawg5uZ6eqsqT3ajJHCeaj+wrTK3BwxnAfvCL3iOGaifjq+/rDo75YYv/FY
 QFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940707; x=1778545507;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QLod9dRReugtdmt8pQOfgaPMeJva4633ho398t5P0U=;
 b=Q+7Cmy4DrDqtMzyCppIVUT9xzW//1qeH5fjpYftI+yA2F+OGF8WvjID2vBKSRMD7n7
 8zZl0nhbUYVzaDteHQObGh3AfJ2o458uNZNRi8huqqf8GJwKy+5N1j2l64LUC+ix6rDt
 W8nI2+lLRkB85T7S+mtJyg2N2wsju8FyRMr05wSZRgiHSdOKrS15uQYEf+uZe4G3XNRc
 L1aZGsHowHQlam7f5DDb02UfH2RCBVHm+yCgm40cY+4TVmX7X+cDopCKklhxrT8mtNLl
 6m609OKLrw++6Ovu+pwY0DX/aeHU+d/2wRQKZdtMwa3HS4xqJSiEUnSSGmGOrN/irLqK
 pExg==
X-Gm-Message-State: AOJu0Yw2gc2l1HPcO9DiLGuM+symWz0B5c15dSDy/UI0J4N03gXHQxfG
 GIlwSvZact2PmuvFK3Xm/zn7v+s1PhbjAtupspFqbZ2HX8KM9c+4eIF00uUVG1oCRfa9wcScP2B
 NpaQFut8coEE9KKK8FTLgXmoadUb7KiQ7RLNNWkmBg7ym95rWdzpy8nUzdrLTK93/s8W0
X-Gm-Gg: AeBDievShx1UJpCedh+yfQ4+Y/zJs99MdiAquzoCBvnUumyvRwlJaeLnG9adeGlRDh+
 mwHwIHxVwzlvAbI7n6nyvWT85wjEe+0vDrcGKXNBbrAGrhlOm8ByIWdQNgo7O6gjpHxHelyMvZ5
 ++h1bdjV6fcuXdkClNnQ52LvCemkZQ+Xlh0qHhd5/VB6MRx6xvEYaTluF7lMV5BT7VdFcGicW26
 TT/H1BkNnatZRbethng3I/wgzBiLw1ZcKAxxy8BPo15GCwIU/w+vVls4sET0zM2Ms9+mvntSRBx
 GPHfvlSMTinYWX305+0eMkR7LHRtoVhmXyRGeP2xXi8jQKJIGUeOWxRnpxPhZm0FbxaOm17Pant
 MtUfAnQQ0rYxTgBIUXgEbTow58mDf6wP75V1Vz9vRdOMlEZLMQnwRzk4G99mXq3Pf7joZ6S9iqo
 uWr71ezbVj3lg9xvlLRFuc3NpYMrc6pqKDREAF3s+Qq+ZBJw==
X-Received: by 2002:a05:622a:5908:b0:50f:b974:7ef5 with SMTP id
 d75a77b69052e-51306a7acc5mr16374021cf.32.1777940707083; 
 Mon, 04 May 2026 17:25:07 -0700 (PDT)
X-Received: by 2002:a05:622a:5908:b0:50f:b974:7ef5 with SMTP id
 d75a77b69052e-51306a7acc5mr16373321cf.32.1777940706560; 
 Mon, 04 May 2026 17:25:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 0/8] drm: writeback: clean up writeback connector
 initialization
Date: Tue, 05 May 2026 03:24:57 +0300
Message-Id: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANo4+WkC/3XRS27DIBAG4KtYrEsKGDBklXtUWfAYGqTaJOC4i
 aLcvThRq0iuN2h+NPMhDTdUIEcoaNvcUIYplpiGGsRbg9zBDJ+Ao68ZMcIEUYTib4t9TkcMg0s
 eMtadIa4T1gvfoTp1zBDi5SF+7Gs+xDKmfH08MNH5dt2aKCZYMS65JJyFzu9SKZvT2Xy51Pebe
 qCZnNgLQ+WSYZUJWlAPhAce9ArTvjJ6ybSVsVwZaUKnSWtXGP7HUMbUkuGVEcozBVIqTeg/zP2
 5uAync/2B8bk9ZE0BPDfFcdv43OM+Fvf+W+ABLmMdvf8AiACrSMQBAAA=
X-Change-ID: 20250801-wb-drop-encoder-97a0c75bd5d7
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3303;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5yJfYD9nv3EttqjPI1vJyzwvXDJhLx4j8rBATQoCCEs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp+Tjbf13SW5UIUohb/OBxNm4E3L6S3xwe0xiFX
 czRU0ec5PeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafk42wAKCRCLPIo+Aiko
 1Zt2B/4lVv+bnZzJL4SjTwu9r864h29OcYwW9NO1sE5jzL++++8t0xfzq7FVGRpBoPg1namlp5s
 WlNEasWgUsZ4o4vi+k9m56KWbTrT6B8wDgElLrG+DhyTOmGgWTKplqjlmrfCgj1qS1XGXavhbNv
 gynPNIVrFyGnJh+DCdih5/F0aY8BcGsr0DMKHR3QOlQR6uTW3hwPLm+Z+AwbEjeXlNiU/C+zSK5
 eUiCXhl5JGm+QdFKw+9bJauuLz5Bgi02RcYLx6xXMsHOU7t2qgZnnuCc+aoXgVK7VSqOt76PGJ3
 u3wUBo6qBsD+7vJAJYNGmzyEbUXgrBVGLgLnlbYcxw4unxIp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMSBTYWx0ZWRfX9vg951+Ca3HC
 i+rJKAazAGbRhfXAU89XGkRwA19+uWDKF71EoA6QSQAwwy4EJULbsf9R87hFoJ2VOtI+t/+Rxi1
 5G0vrNre23BfVuF1Y8xNTM9BKf2qqvJRDV/jAWPQV2OdvrqDqB84OEfDjo792O8kLHP5mp84uIP
 2gc8W7kIqq2AxoRzxqZajU/XIQRI8dieIqUueBpM29wBFkOV0Jj2IBzwVX4enU5f3+iV0dlFj5j
 JhxBykSDQCaNsHZNFksWANiHY/rTpEygsKZZjpcneaEKLSVCcwCYalAOS+3oG7BH7pCUmHzOpMu
 NpNftpBdH7FoDiNmerbjP2kex9uaqC08mnqNqVF9fg2r3LvxLEHBaXyMJ0IG5uQYqvKBsl6Pyqr
 gjmX2kGNmksGqldAGeNmhMVHIbOikhTXhHAWK3MA+43k7HwbSk6TWjm/5Hf+Qg0e6XdVrpGzyUK
 esK68LVdnoVQwzzri5w==
X-Proofpoint-ORIG-GUID: q9D3F7vzORocj0JI2yJjiQ0aQxT9iLck
X-Proofpoint-GUID: q9D3F7vzORocj0JI2yJjiQ0aQxT9iLck
X-Authority-Analysis: v=2.4 cv=C47ZDwP+ c=1 sm=1 tr=0 ts=69f938e4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_H8M4-vQE-x6SST4HBsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050001
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

Drivers using drm_writeback_connector_init() / _with_encoder() don't
perform cleanup in a manner similar to drmm_writeback_connector_init()
(see drm_writeback_connector_cleanup()). Migrate all existing drivers
to use drmm_writeback_connector_init(), drop
drm_writeback_connector_init() and drm_writeback_connector::encoder
(it's unused afterwards).

This series leaves former drm_writeback_connector_init_with_encoder()
(renamed to drm_writeback_connector_init as a non-managed counterpart
for drmm_writeback_connector_init()). It is supposed to be used by
drivers which can not use drmm functions (like Intel). However I think
it would be better to drop it completely.

Note: Christophe pointed out that AMDGPU driver leaks connector memory.
As it's not related to this series (and as I don't have enough
proficiency in the driver) I'm not going to fix those in this series.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v5:
- Rebased on top of drm-misc-next
- Expanded commit message for msm patch, describing devm vs drmm issues (Laurent)
- Expanded commit messages, describing why the drivers are converted to
  drmm_writeback_connector_init() (Laurent)
- Link to v4: https://lore.kernel.org/r/20251228-wb-drop-encoder-v4-0-58d28e668901@oss.qualcomm.com

Changes in v4:
- Rebase on top of drm-misc-next, dropping applied patch.
- Added a note regarding memory leak in the AMDGPU driver.
- Fixed a devm vs drmm issue in the msm/dpu driver.
- Link to v3: https://lore.kernel.org/r/20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com

Changes in v3:
- Fixed subject prefix for the rcar-du patch (Jessica Zhang)
- Link to v2: https://lore.kernel.org/r/20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com

Changes in v2:
- Switched to drm_crtc_mask() where applicable (Louis Chauvet)
- Link to v1: https://lore.kernel.org/r/20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com

---
Dmitry Baryshkov (8):
      drm/msm/dpu: don't mix devm and drmm functions
      drm/amd/display: use drmm_writeback_connector_init()
      drm/komeda: use drmm_writeback_connector_init()
      drm/mali: use drmm_writeback_connector_init()
      drm: renesas: rcar-du: use drmm_writeback_connector_init()
      drm/vc4: use drmm_writeback_connector_init()
      drm: writeback: drop excess connector initialization functions
      drm: writeback: rename drm_writeback_connector_init_with_encoder()

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 18 ++++--
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++----
 drivers/gpu/drm/arm/malidp_mw.c                    | 25 ++++----
 drivers/gpu/drm/drm_writeback.c                    | 69 +++-------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |  3 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 22 ++++---
 drivers/gpu/drm/vc4/vc4_txp.c                      |  9 ++-
 include/drm/drm_writeback.h                        | 22 +------
 9 files changed, 75 insertions(+), 125 deletions(-)
---
base-commit: d4c14903bf5e28e740516c4fbb7db01e0dedf3af
change-id: 20250801-wb-drop-encoder-97a0c75bd5d7

Best regards,
--  
With best wishes
Dmitry

