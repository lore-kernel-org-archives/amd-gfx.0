Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B7606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ArmHmbIL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CZTYMkOI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1241F10F863;
	Wed, 11 Nov 2026 00:43:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBEB310F859
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:23 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB0LXFo407341
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hhveaKbmmmrP1w+Sni0lZMyjK8nAFckdknPCkhp9J44=; b=ArmHmbILUuUtsadw
 nWEPIL8Tw+H7j2TWvIODSCkbPxgChOY6fbgLnLnu7KZLOOlVekdLrRmRShwJZYJP
 oYD9EqTVQWRbEIstWQVeqzaFjyr6EcFV+YqS7NLi8+Q7sSmB0mxL1Uf9tzEzxDIf
 NxO03sD3Cy3DUtQMyY7/xcOtu9AjuSaMECeE5xIHYa0e3oLyO1PZR06kDMcGFoOH
 OGIcwPWjg6gGnWfYslAy1dbuOaYHrTuB1ozETvFwaVCrYCpVleVcTaxvDzv55lpl
 ZozBtmSKCmOo+z50kPNvTNqODU5AiFnF2D1WFVhPPtJcvk7kaUwEHMsfEQx08FYV
 JGB08g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh0277-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91ea0c20af3so50212666d6.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357802; x=1794962602;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hhveaKbmmmrP1w+Sni0lZMyjK8nAFckdknPCkhp9J44=;
 b=CZTYMkOIeKk9WURcsaIJqh30lnX72EGHrfE5QDLFOnKKxDl5hw1i2mPOY31HLTi/7I
 FVBMpWhKN5Gez6jjfcIP9YTyI5dh8U4/ACz64HHucBvMNsXgL6s445S4z2MX5X6XhtT2
 /wAVutu/BtZTRY54HaU+CPUhCzRVZfljiIlz4mya8rztJjopS8OAaGAZ7Kfcw6LJT1/2
 P49NFlVqmYV0ytrLFmcJOFon7V9oYZKq5bWXLlEbeHaR4Y1FZ7IF8UIutVVBRTvks7sf
 Zbiie/f3xCBhFsnPJNMLF9R9SKZH5csT9sZnfxoNhr9kHJAn/zyXuQfJMIeNJ5us9JQS
 1wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357802; x=1794962602;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hhveaKbmmmrP1w+Sni0lZMyjK8nAFckdknPCkhp9J44=;
 b=gTRhFkkHlSgqPMOu+TFknZwQC32WlcwWYhYKfoVI2Fb4hPcYoDIfPLvRRtNAKfXyZ+
 4UkExckdhClWNi1cQNnDxG6o9LnXts6I4jSsgmebqF07V7tIIrIY7+1s+rApiA4h6luP
 MCiv9zpvD3pJTz2i06se2I0Rv/DsfDVYAp6dSAsWXm5Ol3Y1bQ38AR8TYDndrQFoxuLP
 UE44VmzMCg6HNUSRJn61LS0qClVz6CLego7T87Tz1oFTeVKGynum258avI4tNtzHOXV8
 kO07V1vpDpYpFtGIAIa9MlglbtZwmwegEY9n3Wnf8YZn8PAPmA2hD3KlpRK8HdoDMxDo
 LG8w==
X-Forwarded-Encrypted: i=1;
 AL+hErEyV7MOPOqqvTE7lPefjhMi2QyhZR391FRpCEMTUmvpFnogUE1TUp4BAjLt6fgAoINji2bXVQcz@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/un8KTnk81rvaQA4bZc22PsAjAOyWanZiCWlZ13kBuim4sUhvr
 ZENiuNzTRLxKg38M+VXejeCP+nnWsM3tiRNiV+ruXrp9sKKjKC2d2Cy/gZDM/e6lo/G/ztADMFO
 m2FqN03AXcTSJWLCnvc7fWof3y7HWjTzfhmEBDCFdvh1T0NBe9Z4m0/rjb7jW7+vCYaFg
X-Gm-Gg: AYBFou2DAeC40Mi9uFTd/5Mk9JlTu8RdIKZ5vXvz2hmxYZ0pMDLwyf+bi56uEiffwiG
 4wcrHcF1P76w6ADM2iEtfkRO7Lp9Qw44tJz6o+cMt0HgTCsYr5gxloqsXC2ITPSA2tuokrhoaLi
 8GtMxC5e8VS1D6JKYD16Faz6DyB+M9mALawZJw8YPUg1dAaD8XZ5Qucb9wU99GHHFGpX9ofcYzt
 6OnSnA54dHSzFoUXxwqxALUPBe6M1QXp05T3+7VLBBzhvCr33AJfmeQLQYOkE0ptfyPUoSD3J0R
 8SbsgWGboshYlQOFS+GBNmncf+HB8m/d9OBQfXqFk3F7YKF06mgU5UxV4E8VQjRXIn2K1jby81V
 e7YLUzsmo105pZ+bVe+4tHmzRXue9/lFeOnvIyEc/ID+sy0r8VEcDdbPAYfH9YU8Erd/VtYfz4U
 ysfA0d5KprBlcbfkZctOKJ6b8aPnu9kDcHBiPhZgqX4SpVq15zATEDDh9JViPntw==
X-Received: by 2002:a05:6214:d86:b0:91e:a629:ff92 with SMTP id
 6a1803df08f44-91f04196dd4mr18149046d6.42.1794357801746; 
 Tue, 10 Nov 2026 16:43:21 -0800 (PST)
X-Received: by 2002:a05:6214:d86:b0:91e:a629:ff92 with SMTP id
 6a1803df08f44-91f04196dd4mr18148396d6.42.1794357801033; 
 Tue, 10 Nov 2026 16:43:21 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:16 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:35 +0200
Subject: [PATCH v8 06/10] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-6-62948ed87d13@oss.qualcomm.com>
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
In-Reply-To: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Harrison <John.Harrison@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8350;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=wvKxj/weq4r4ZxPKaEMkccXc+Kqhd05QUrApI4aY/UE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oO56imQXCPnVcLCoJc7EVpFUdmAkmiwiJjs
 DKzNFrZ25OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6DgAKCRCLPIo+Aiko
 1XvNCACpqHYibAHqx9CrcrvKX7v7KToL77nGbW0BpE/3brMkQw5Au+kpj7nq7PT/fw73Q0PRsAV
 oKhCfkmuvYa9IsYzA2dJ6CTKy6yNNJ+YgU1U86C3BOi1dyWIiSuY2nXqIGxVjBTV7sBPh7FRAyl
 Re0sqtsmSv7k35XyQNMgd82L+rUC7BRfUAuJnt5K5FcMuV0jDcS1Tvqhjw3Lpd53sH6nDG8+obn
 RV/SOXsFd0beBgLVxDEbw0IYIJcbTj44dIHpm6k6z8tLQcDuEKPFrBQpqrmWoKFkJvnPFfYSb+6
 PnzfQHJLHFOk0VYLr17RNNmZAt1Z1MIjebJ7J5s5dqRYA+kV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX+ABN/0V9PMBe
 tGMEhhs8dO9BdT8JUXfbA/u7SqaE34L8uL3pQzGY8pTFJLQSwBevUJoMG+Ft8SdG5Qw9bqClc/P
 HyaNpjDmXfuw9CadFB6ALrw3q1qYsjo=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af3ba2a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=s8YR1HE3AAAA:8
 a=EUspDBNiAAAA:8 a=KeTiLIfg1DN4_MrrFvcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: pZvkCkLFxrEgVvbPVP6J6XQXvFaVOE2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX65jkK84vXXTY
 I+WriMpZgSE2xwFylXPTFAbpn59U/phw14+8hA6p0WmxjjwileMFYHNDJZmdW1QkKatJp839Tqp
 QYJvCgjhwW+DDNWpkEgFu5powWUMtxNmcKmH5Pjgd9HermjGFiElcd+6T3HVzM1rJUey0Giywfk
 Qjdy4VOkJVkYtoV0DWPAq6+91GvQH4wbCuxg8ZAl5eyOgnyMpI4x0oN1U7OfLz/pCLhhrH9LAqV
 iUgD7A+/oy/sz50lP1Oa96vdDfSOIsVHrBwIqafja/LPa7BYJcryisjgpG4ZtswKbGFQYZw3NB0
 qtxZ8OKzFpTX/LO15NEzQS3sp4EhozTUQVN3ZLQVj5HQdbF6BZh4fshfpY5gdpak5I1mMIUeD00
 /rdwqSfEjC+i+GmLOLm6U2vJc+2tQ8P+wY19760NTWC9nxeaTVv/cEpieOraplK2SIrQihbXqJs
 wRxxIdpDTmN+9Q8bUEQ==
X-Proofpoint-ORIG-GUID: pZvkCkLFxrEgVvbPVP6J6XQXvFaVOE2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110001
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rename drm_writeback_connector_init_with_encoder() to
drm_writeback_connector_init() and adapt its interface to follow
drmm_writeback_connector_init(). Drop references to the "custom encoder"
from the documentation since it's now the only way to specify the
encoder to the writeback connector.

Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c    | 10 +++++-----
 .../drm/arm/display/komeda/komeda_wb_connector.c    |  8 ++++----
 drivers/gpu/drm/arm/malidp_mw.c                     |  8 ++++----
 drivers/gpu/drm/drm_writeback.c                     | 21 +++++++++------------
 drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 10 +++++-----
 drivers/gpu/drm/vc4/vc4_txp.c                       |  8 ++++----
 include/drm/drm_writeback.h                         | 10 +++++-----
 7 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index e0ef23f692d4..dde02b2b018b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -262,11 +262,11 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 
 	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
 
-	res = drm_writeback_connector_init_with_encoder(&dm->adev->ddev, &wbcon->base,
-							&wbcon->encoder,
-							&amdgpu_dm_wb_connector_funcs,
-							amdgpu_dm_wb_formats,
-							ARRAY_SIZE(amdgpu_dm_wb_formats));
+	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
+					   &amdgpu_dm_wb_connector_funcs,
+					   &wbcon->encoder,
+					   amdgpu_dm_wb_formats,
+					   ARRAY_SIZE(amdgpu_dm_wb_formats));
 	if (res) {
 		drm_encoder_cleanup(&wbcon->encoder);
 		return res;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 7b795e1c5705..ea4589b00ee0 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -186,10 +186,10 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return err;
 	}
 
-	err = drm_writeback_connector_init_with_encoder(&kms->base, wb_conn,
-							wb_encoder,
-							&komeda_wb_connector_funcs,
-							formats, n_formats);
+	err = drm_writeback_connector_init(&kms->base, wb_conn,
+					   &komeda_wb_connector_funcs,
+					   wb_encoder,
+					   formats, n_formats);
 	komeda_put_fourcc_list(formats);
 	if (err) {
 		drm_encoder_cleanup(wb_encoder);
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 889d0d1db85d..3669d10540bf 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -239,10 +239,10 @@ int malidp_mw_connector_init(struct drm_device *drm)
 		return ret;
 	}
 
-	ret = drm_writeback_connector_init_with_encoder(drm, &malidp->mw_connector,
-							&malidp->mw_encoder,
-							&malidp_mw_connector_funcs,
-							formats, n_formats);
+	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
+					   &malidp_mw_connector_funcs,
+					   &malidp->mw_encoder,
+					   formats, n_formats);
 	kfree(formats);
 	if (ret) {
 		drm_encoder_cleanup(&malidp->mw_encoder);
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 683da368e339..89c36f1414ce 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -165,8 +165,7 @@ static void delete_writeback_properties(struct drm_device *dev)
 }
 
 /**
- * __drm_writeback_connector_init - Initialize a writeback connector with
- * a custom encoder
+ * __drm_writeback_connector_init - Initialize a writeback connector
  *
  * @dev: DRM device
  * @wb_connector: Writeback connector to initialize
@@ -241,8 +240,7 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 }
 
 /**
- * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
- * a custom encoder
+ * drm_writeback_connector_init - Initialize a writeback connector
  *
  * @dev: DRM device
  * @wb_connector: Writeback connector to initialize
@@ -269,11 +267,11 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
  *
  * Returns: 0 on success, or a negative error code
  */
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-					      struct drm_writeback_connector *wb_connector,
-					      struct drm_encoder *enc,
-					      const struct drm_connector_funcs *con_funcs,
-					      const u32 *formats, int n_formats)
+int drm_writeback_connector_init(struct drm_device *dev,
+				 struct drm_writeback_connector *wb_connector,
+				 const struct drm_connector_funcs *con_funcs,
+				 struct drm_encoder *enc,
+				 const u32 *formats, int n_formats)
 {
 	struct drm_connector *connector = &wb_connector->base;
 	int ret;
@@ -290,7 +288,7 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
+EXPORT_SYMBOL(drm_writeback_connector_init);
 
 /**
  * drm_writeback_connector_cleanup - Cleanup the writeback connector
@@ -320,8 +318,7 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
 }
 
 /**
- * drmm_writeback_connector_init - Initialize a writeback connector with
- * a custom encoder
+ * drmm_writeback_connector_init - Initialize a writeback connector
  *
  * @dev: DRM device
  * @wb_connector: Writeback connector to initialize
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index a1271fec9874..a88408124758 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -217,11 +217,11 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 	drm_connector_helper_add(&wb_conn->base,
 				 &rcar_du_wb_conn_helper_funcs);
 
-	ret = drm_writeback_connector_init_with_encoder(&rcdu->ddev, wb_conn,
-							encoder,
-							&rcar_du_wb_conn_funcs,
-							writeback_formats,
-							ARRAY_SIZE(writeback_formats));
+	ret = drm_writeback_connector_init(&rcdu->ddev, wb_conn,
+					   &rcar_du_wb_conn_funcs,
+					   encoder,
+					   writeback_formats,
+					   ARRAY_SIZE(writeback_formats));
 	if (ret)
 		drm_encoder_cleanup(encoder);
 
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 642953cba25f..6ffc54d23d48 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -601,10 +601,10 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_connector_helper_add(&txp->connector.base,
 				 &vc4_txp_connector_helper_funcs);
-	ret = drm_writeback_connector_init_with_encoder(drm, &txp->connector,
-							encoder,
-							&vc4_txp_connector_funcs,
-							drm_fmts, ARRAY_SIZE(drm_fmts));
+	ret = drm_writeback_connector_init(drm, &txp->connector,
+					   &vc4_txp_connector_funcs,
+					   encoder,
+					   drm_fmts, ARRAY_SIZE(drm_fmts));
 	if (ret)
 		return ret;
 
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 879ca103320c..958466a05e60 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -137,11 +137,11 @@ drm_connector_to_writeback(struct drm_connector *connector)
 	return container_of(connector, struct drm_writeback_connector, base);
 }
 
-int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
-				struct drm_writeback_connector *wb_connector,
-				struct drm_encoder *enc,
-				const struct drm_connector_funcs *con_funcs, const u32 *formats,
-				int n_formats);
+int drm_writeback_connector_init(struct drm_device *dev,
+				 struct drm_writeback_connector *wb_connector,
+				 const struct drm_connector_funcs *con_funcs,
+				 struct drm_encoder *enc,
+				 const u32 *formats, int n_formats);
 
 int drmm_writeback_connector_init(struct drm_device *dev,
 				  struct drm_writeback_connector *wb_connector,

-- 
2.47.3

