Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD13CA0EEC
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 15:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C1A10E393;
	Sat, 16 Aug 2025 15:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SWH33GE8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B75C110E391
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:47 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GDQKXg028017
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TRcyMGCl+30uALX35qrVjgv24YuvpY2moJlPtRkxYu0=; b=SWH33GE86FDLtZn0
 dlY2V3vW68TyhRFxU3mWsuoXo5/BnJWF5A8g7rb31wtBSSgn8cg6KL5ZogKpnyGv
 DoJoL2hzrBQh6fo0p1Q5hgYRdirAyUYrplnXJAuK/M9H5XIPDUQYxtwkxnTsBXzT
 cFB0IekECrC/H88ibrAS3CdJ0LMrRmUzj4JZtvfv3TpSac8n0sZuVDbd6OIpiIWB
 QmR08bWLoxlk+HnulcTh069TEcAe/OEfEhE/R8cVTdy5Khth0UKjizF4FomlhhTE
 0dcTTKMonlm4gmzh1voCqRRnQ2I9d7w75l8kM3jV61DmsysULKlLYGmIi7fiSZie
 uVL/tg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2u8u04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:46 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70a9289baafso57669206d6.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 08:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755357586; x=1755962386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRcyMGCl+30uALX35qrVjgv24YuvpY2moJlPtRkxYu0=;
 b=l2EH1vWLOPNGwOBOZRGGmceHPOhkq2jWh5Ijf6dUpE6YeKunZCwZZxboGvdeH1U0R9
 6pILd2GYDj+fZNmULYVZdnnRjFHMZOzIDn0Iab2YgQ/gGUdC0ZviZZpJaP/e+IJ8Xqg8
 cdKXnP6esd74IMelJwJ+bx6fIVU94E7itCRJKLiK3dw7F3qTo05KkCAWOBSuQC/lOuky
 iiZXzOyCNVVPf5QvNRIOMUqy5G3aMyNUWnBxDNXEZBepcPuVmtO0X5CNynIE+mMHT3c3
 J8CsLJbLFqwdQ3AaebfW0vN35WDjpWb5BRhRmludzh5tdHxkQmFd46ewC/+I2UmYYITf
 0BBQ==
X-Gm-Message-State: AOJu0Yx5bnhGa8cwo9lurFckuL+tpPt7xBJMsuHPPonev+X7TWmI2yPW
 sKaUgo/6k9SoCnnazY3kZafi2MgeNmVwzVeKCG+fG7/6MhrKYzMkpQzrEm3XwiEK7A+ppd2PbGU
 dycOxHa8x5KHzpiTbmwo46mdZBxufYMfsuywQcQZEYekBdZGEg0Yy7oAdk199/gaDF2Hd
X-Gm-Gg: ASbGncugeJ9RBj24Vec7HPYhUUSvgiMN8KVi/5YWrnJ/2/GiXuLHv5LsGQiy0N2yc59
 X7Bn4B5Dm8ZS3TmpIGWSmkRKdqg/WZbHRIKjyQQglE7jkgEuSxlszcqAGN0YEL2GJwrsaGUWowx
 aTitT+gBQkRT/E5VRSNRfcfHi7LHrIbwzMGTd/MCMuDGlKh+Mcn/Ys5sArU4KV2Irl8Q4p8tlAU
 hrZmpHAwVCp0Y+VA0F/i/ayeysfR3wjN4BaAtNHzyob2vCih/IANMo2Nx8iESs5PKUEhmau6R5u
 yjJsQYtgh26LEYxOcMbxL1yQ3DwEGPDFllEnhMU0kXFwejgQPL6so9sFONYMTaRxDucFN1Ras6l
 1OVNiMIvF6grtwY/z34lPmy7ecvssREmemfmfp/V0NOA8/w/Gh6lG
X-Received: by 2002:ad4:5c4d:0:b0:707:89e:20a0 with SMTP id
 6a1803df08f44-70b97e5f8b6mr121342736d6.22.1755357585908; 
 Sat, 16 Aug 2025 08:19:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYKtw8girfWWYEqO/Ggcji51+kihQkK91jR/jljS3mVOG35hIp3DD0cbbL9nG5EcyplDI8JA==
X-Received: by 2002:ad4:5c4d:0:b0:707:89e:20a0 with SMTP id
 6a1803df08f44-70b97e5f8b6mr121342146d6.22.1755357585415; 
 Sat, 16 Aug 2025 08:19:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55cef35965fsm907579e87.37.2025.08.16.08.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Aug 2025 08:19:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 18:19:37 +0300
Subject: [PATCH v2 3/8] drm/mali: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-wb-drop-encoder-v2-3-f951de04f4f9@oss.qualcomm.com>
References: <20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com>
In-Reply-To: <20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2621;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bSu7BtDX/FJ/CYhdTG49eD8oSIyWKKcC6qKfEjkvl9M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooKGIYX6MbbfX0q4CqCoZNIiZx1UDb6oAqdBYr
 e0GtlGtu66JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKChiAAKCRCLPIo+Aiko
 1XFKB/0X/ib5lIagcGHFFApfOPY+gYbqF8flWf58m5QwtwRW5JbZgubNJhn8ewnog9DlDUs1iQ2
 8AZd4JZE8uJ39gfaok+MTfL+tqc65sbijJoCKgvz9+dlMkRxi1rkg6W8XBAj/Ql5xi4QJdIrHuc
 6v09zB7eIG7Lmmyxvy7H+l2SX3npPoNX/1kWEBUcDdZMEz+kNRYaS2C67tip/1O53yvNISFiR9v
 DZc/rM1UzRP81nWh7ilpYyfA7hjUAMeNnYJR+EKl0Ma4t7O6c/ABqTgZmtecludu7wNZwZhCZBX
 S77fnkUHzj74L0sc6kM/VDZNgmgTj+Q8ATzzUHygv8oFDR+G
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a0a192 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=mhD89yN676IZukTL2GQA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: PleU46Q2evf8ypcief2MiGW9MQSYYux1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfXzo/nqK80/mxe
 yTV4ZDkkNNknOvy0vExJIhevmGH8IL2lHT4Pbo+kUsqn1JlyUFk8NFr9lBgVVFLsUjPtQ3t8ujN
 6m0VqRrPV7ou7hFVldcpONfW2YoLRxaqs90f6Xon/8iKAqEVME7P3r7LT2nHOUi05tUJSABx7SM
 cZpcIkVJmz3dUWrkTzpB3ZHutq1fVzXEusU754e5IF13VF6XKN3GoZIAFVGgxrGN8dTYoe6+L4j
 Tt1QY1KH7hoUzYYpBYk5PSSlQF5qXsCh7OOC2g2LBZcMHX/wkYiRh494h57+CyuGXZFTrzeygMu
 vqlDIFCDvjLlz94/y3Dd0y3ldGyh9bMwVLDw8lPoZt0jc3/TuXrgvlJlDNP3u6UR6NdBo3ni5tG
 ZXyKsQaT
X-Proofpoint-GUID: PleU46Q2evf8ypcief2MiGW9MQSYYux1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031
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

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/malidp_mw.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 600af5ad81b15d0c30f9f79588f40cca07437ed8..80f7f3474c4494554c6b6fb392e7f396b3b49c83 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -84,11 +84,6 @@ malidp_mw_connector_detect(struct drm_connector *connector, bool force)
 	return connector_status_connected;
 }
 
-static void malidp_mw_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-}
-
 static struct drm_connector_state *
 malidp_mw_connector_duplicate_state(struct drm_connector *connector)
 {
@@ -114,7 +109,6 @@ static const struct drm_connector_funcs malidp_mw_connector_funcs = {
 	.reset = malidp_mw_connector_reset,
 	.detect = malidp_mw_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = malidp_mw_connector_destroy,
 	.atomic_duplicate_state = malidp_mw_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
@@ -211,6 +205,7 @@ static u32 *get_writeback_formats(struct malidp_drm *malidp, int *n_formats)
 int malidp_mw_connector_init(struct drm_device *drm)
 {
 	struct malidp_drm *malidp = drm_to_malidp(drm);
+	struct drm_encoder *encoder;
 	u32 *formats;
 	int ret, n_formats;
 
@@ -224,11 +219,19 @@ int malidp_mw_connector_init(struct drm_device *drm)
 	if (!formats)
 		return -ENOMEM;
 
-	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
-					   &malidp_mw_connector_funcs,
-					   &malidp_mw_encoder_helper_funcs,
-					   formats, n_formats,
-					   1 << drm_crtc_index(&malidp->crtc));
+	encoder = drmm_plain_encoder_alloc(drm, NULL, DRM_MODE_ENCODER_VIRTUAL,
+					   NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &malidp_mw_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&malidp->crtc);
+
+	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector,
+					    &malidp_mw_connector_funcs,
+					    encoder,
+					    formats, n_formats);
 	kfree(formats);
 	if (ret)
 		return ret;

-- 
2.47.2

