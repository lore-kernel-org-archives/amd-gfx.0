Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432ABC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 13:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AE410E860;
	Fri,  1 Aug 2025 13:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZixZKNRc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473F610E85E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 13:51:22 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718t297022949
 for <amd-gfx@lists.freedesktop.org>; Fri, 1 Aug 2025 13:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V6zL/GI63V6YYKeGM1mEryAObeKPOCarM9uKEFJtsyk=; b=ZixZKNRcrQRvodJd
 apim1u6KzeyYaY//ocAWtkLz/m17cHyGdmVUAPav/oemBLjXWM8v5jOvdHVocNyI
 rvLr5FVYTG15cc0OaOsqlihXATZGE9p9a0nu/gA7i7Y7zySFoyb9RqfM+39/kq0c
 htiK2coTBIDxuR0EvVp/uYXqFjE30OEiAdkmtfDLs07DkBNbumDI9dasN5TB0CSJ
 2d5r6trf5sCoWrC6aDCOov17JxzpbWd3mKWqpVLJ0oHEYu0bMDsIMgIK4yRQxBc/
 KO6Vtw47yO6PTczVwalcNZcB1iTGnDVrhZOnTknXWFNdnJWnjDsD8VfMLNWAUU6C
 +MEndA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrm7pa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 13:51:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ab6d31e2dbso36001171cf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 06:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754056280; x=1754661080;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6zL/GI63V6YYKeGM1mEryAObeKPOCarM9uKEFJtsyk=;
 b=kFRN5JStFYmScCmwmmuwCHtwksqSVzhsDA8kUGTLhXfn4a94q9p8fJgY55hFVuTraw
 TVVdDgAHY/z/DP7KkKDT98plS5ZHNphmybaTi/cw5Ao0xzgZBuPaMgdNHZ4M68o7zsC/
 iuZf1Zs1CHJ28sdMArDUNxePCoYC1J2tPz6xl1DNsPCTmx4Mzhoj+/A6LYZtp5kAbb4w
 ZdfjaNrAgcBmvmQNXsUm62LpeMTApc3WHk1kwv09jTDAL+MxXIJg92/AvmOjEKioMDT5
 bpxUKeyoaFSuTzVpLHATrMVpRCr7zPcSUpwiDqejjBkitv9g/eyJAm8VLSq1fFC442en
 dxzg==
X-Gm-Message-State: AOJu0Yw8jYu9Shvx3g7dzVOlU+2pmRY/AfdLUkJbxEidICe9f2zH7/3E
 /AHDR6PkdnZu9Z7MOUz1eTXi28dak8T3CnhGpE9Tq6EvaaoAYpVTNXR7ecRocdL1Ej7446IXycf
 wwXOYtMhqnHKG8Oy7qzYV6HW9sD4vheUMW46d8ZOPflJH3QXVg3n2yKs3/zuRw/MHUkWy
X-Gm-Gg: ASbGncs5N7lzOt7BHgwWLLe2MSW9NcqEhkcGGEV0K2uI+HXo8fBS2h8794SEmhatNQ+
 1cGBnUaosVi9mrClB4PP8VWjCsXCqrua1eMVepW2L0bN44c0T89DB/6qtttt84NybHxz+paeEtp
 pQSUmu5ibscnbS4bzZCbuO3HFTqONRREI5OwQWYaYSUMvQWSwTU+o+EPY643MVhAlReFlpddTBC
 QdxaBTcyIxmrCJljRflWJvqDEq3yCRr4FdnD5BCcr9RFQkzxkqLxa39aCcGfkU20MQt4S9EFk++
 atGaE0h8/QC33Cn9RMJwaI9aulVOBCOGsFAescNTeUDngzkAWpNNxRmWWH7ImNaXNWIgXAR+P9X
 L/ArnyYEjYlr10HBIdz8dYANZLZsaUzMc7AC2lOW8UOsSxnByhEuT
X-Received: by 2002:ac8:5813:0:b0:4af:219:b8e9 with SMTP id
 d75a77b69052e-4af0219bd62mr28441331cf.6.1754056280016; 
 Fri, 01 Aug 2025 06:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR0G/8/mp3NoMeNSdNh5xGLdgi/uAIOcZPk20PI9XWjmBIPiXjC/zontxCRxjb7k+mVn1ffA==
X-Received: by 2002:ac8:5813:0:b0:4af:219:b8e9 with SMTP id
 d75a77b69052e-4af0219bd62mr28440731cf.6.1754056279485; 
 Fri, 01 Aug 2025 06:51:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-33238273006sm5917801fa.9.2025.08.01.06.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:51:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:51:09 +0300
Subject: [PATCH 1/8] drm/amd/display: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wb-drop-encoder-v1-1-824646042f7d@oss.qualcomm.com>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
In-Reply-To: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
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
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2980;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Npu11OGBlNLZEIA4iffNoHuzYf6/Fg1CUI3VmwQheFU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBojMZSZXL0kc9QaXkC+l3w6n53625xXoOoWi1Rf
 w1dSHbBA4+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIzGUgAKCRCLPIo+Aiko
 1bpSB/94A2+Addr9RNnuGBvk1NYZ/RWjJSnSxboR9iOfirpPVgua99XOaoDsSnhD3nuxJDmBBgF
 98NqAbJF6AFI97xmYBM/6ZHsdItWame0lELe7Aw/j7btMsZu4+ROQl6Y0xZAX084XeDcL/jBaJP
 xamILenkg4IgIBeN9bJeA5pyCqsvRXSezPiBgNrZsYGeaqPvNmK9Mn0W0Y8TFvSvDNOvYTcOYSP
 iArGGeNBhFZpGcWJn4cJDKYMfOSQLAW9ZQg0/3fe0/pp9MfDoYSyOjWvZsX73WeP5lIM0vOShqs
 9ONfy5Np+vHNO0rlKWiXD7XgdKfRRU203q22p1TS+tHpzFKa
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwMyBTYWx0ZWRfX4o2ZsDe/Ei+U
 8WVh2gJLWKczVcpFaSKh7vj6vpuhH0ffZOAT9sXHx+wZYDcIWbp8YzvtpXCRLEL5IlpiiZxBHUQ
 gIBr4ntAo0xhYpfZzLqraWwZaXhe+ZxThBWeXwHf0Gn4pkAFYjj4LzYdoAmcEAGXNkeOr8pEbTd
 Mn//gnliLeYSMPt0yA/bDkPrYobQtayIs4reFSthKv5lbkh/uUQHTMqnGx76NE8RUgfqcGASSpy
 jE/8ir8h4STg2Oj8LT0qVBBVgvC4/hTESc58bWUrv0+v0vIG083kDM/VTwYIjceG7cG7qqkOkNL
 ky2RbPkKwFBABKd5s3hp8XE+zxC0N1jQZOlTefbRHo4yQVn7HkbUOy9IeP+WpZIjciWqj3Gee+p
 Fo7oDmolxU2Quh23HCBhPpaO+L0TahgQ64+Et1jpHE2Iv3GQpKcuWY314YiWpZma7nxfWGws
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688cc658 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=8cP71iSYcfV9S7Y4u-4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: JDxx5EfVb_PW7pO8BuZEqWYPbyQHekOG
X-Proofpoint-ORIG-GUID: JDxx5EfVb_PW7pO8BuZEqWYPbyQHekOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=982 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010103
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

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 096b23ad4845d365dad707deed4e3e84b1f9945d..a9948e8d67a6e9556d21090b5cdd101258d62480 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10003,7 +10003,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 		return;
 	}
 
-	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
+	acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		kfree(wb_info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index d9527c05fc878ef6916782ff9fde847813938461..80c37487ca77c0494eaf769c5b9a3c53486aa52d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -171,7 +171,6 @@ static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs =
 
 static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = amdgpu_dm_connector_funcs_reset,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -190,17 +189,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 	struct dc *dc = dm->dc;
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
 	int res = 0;
+	struct drm_encoder *encoder;
+
+	encoder = drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &amdgpu_dm_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
 
 	wbcon->link = link;
 
 	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
 
-	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
+	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
 					    &amdgpu_dm_wb_connector_funcs,
-					    &amdgpu_dm_wb_encoder_helper_funcs,
+					    encoder,
 					    amdgpu_dm_wb_formats,
-					    ARRAY_SIZE(amdgpu_dm_wb_formats),
-					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
+					    ARRAY_SIZE(amdgpu_dm_wb_formats));
 
 	if (res)
 		return res;

-- 
2.39.5

