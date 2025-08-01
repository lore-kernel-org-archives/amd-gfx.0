Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FFDC87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 13:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9563A10E86D;
	Fri,  1 Aug 2025 13:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VjJ+wtta";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC37010E86D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 13:51:27 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571CLRTN001657
 for <amd-gfx@lists.freedesktop.org>; Fri, 1 Aug 2025 13:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W2UCi+malvB0ar8bb6DW9kSFC86prf8rvHe8q8tIWaw=; b=VjJ+wttaMaAyvo/w
 Jp5kH6NjJ4kszVYIFnbCxOw0/E9yoW10FgZrcO5RLvi/Kbfr/mAtYEMhvVQumaXH
 nQTyvuYeFYE+0nKGN5x35T1Nb4xPytiW8wf3Lu2PeYUrv4HItVqM69zKgjh33L9F
 EhpSEqU6KVVLjpnCG1hPIWwE+uLMC/ZsecUYpYeCqOz+c1bwDjU/xJbFsFllXdIG
 0ejkdZE7GPXkgWopZyMVGb9SKvOBA/zITP2odOuNECJ2nzvXfnCQBP9Cw4yUMUDx
 C0VDjmMMHajjU7xu4hcazhSMOkazuUh/7L5TVGL52BG3mKjFngQ1sLrW2ff2r1GL
 cTNtEg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 488wgrr7du-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 13:51:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4aeb8b6acd1so17008281cf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 06:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754056286; x=1754661086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2UCi+malvB0ar8bb6DW9kSFC86prf8rvHe8q8tIWaw=;
 b=D6GffhEQ1B9bbgjcrLsME3VH434FVyPhXPn4RlzijuOHOxzWUpVFUHbTxuXShq1iRU
 u7+nPAckcj9/cATTe1ZGJWwXonM4SZq2oN2DggP5bjMikKTaaPZnup+rEKUHG4bEIvic
 55r8xG+7YX6KgbAY5amjHINXSFo+pCC8YsAHubonE33KXwrSSTn7DWHPNgSOivWMGtKx
 1E73J9odHIfGiMMRq2cSznPEhSvhUwsw1lpQLqxUMFOT0WNtjLIfAlS002DzqJ+sHqEL
 vbAzBU9wZKzKdjwuOJK55WbqlgPDBfuQKM6VlDQOHhW+5ZCoFOnauFu/mR0FBWrxvNCl
 thYg==
X-Gm-Message-State: AOJu0YwFzSyr+2n8Kt7gFutWJKu96m32Ds7/fXhRMrgqQnKzFal3Nqoa
 ySGbF+Y5qkw9qxdl7jgW5AMs0VcXCmQaT/BBOkpOvTLRfNmK9hyJcWuqU6RgjsW7O+gbm5Z6ShU
 VogE5Il9OkWK733Kk51OBEw3SWTCTBD0yr+ks49/pCG9LSuOE4QPXUq9slTYbt6dCoYDp
X-Gm-Gg: ASbGnct1zFNCz7ciXlpriQCMAT4WgYrAkL7awVRRv3pLCJ4toA5qfQZcHwHLzGUdV7a
 5Mu2n722osLgF/xl6oKgXqdzDKREQxlXHF+T+tEbJIw0/DLwgy4rBSVromqg2S0fLIRZffqiOJ8
 GojrGSiaOstry9fbB+eJFL6VgQgpQ/hSy0450qSY/4017ErgZ5Ac2HWcu3G6YR/eZ+0HncMpKWb
 Ua7k7/OvSyWpaCvHwbova04GpEourQU+5i1MM6pDEG/92YtKN7aYNkN4dV9kBiAE21hanllfV3X
 l6Eulw/TzkxrSI5OGzQ9J6tn6iMERIRwIUAOvuLSQSM0pp7eFJ/+b2bbLqNllK4Zpn3LLZjY3lt
 0KTZA1Pcpa86J8Fep+4zLZt3c0ndpLa5TQ1ADX6liH68BFTO7yCLw
X-Received: by 2002:a05:622a:4fcd:b0:4ae:f1c4:98fe with SMTP id
 d75a77b69052e-4aef1c49b02mr76647821cf.34.1754056285907; 
 Fri, 01 Aug 2025 06:51:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAwqWqcrYsHbU0F2gj2xmMxu0CXmwPTRpB2ryFYEdGwGRHG1UFGg9MBUQvZBikakoqd/cRgw==
X-Received: by 2002:a05:622a:4fcd:b0:4ae:f1c4:98fe with SMTP id
 d75a77b69052e-4aef1c49b02mr76647531cf.34.1754056285484; 
 Fri, 01 Aug 2025 06:51:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-33238273006sm5917801fa.9.2025.08.01.06.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:51:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:51:13 +0300
Subject: [PATCH 5/8] drm/msm/dpu: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wb-drop-encoder-v1-5-824646042f7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=p1vIn/pLBbJ5zOAwN/G9XdaGKb83FPkfI1f2HSftzDk=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ0bPsWCx0yvsNgYcls5I+plW1j3Fjjm+X0px0rzqd0vs0
 k3EioQ7GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCRty0cDE2u3dqvkrq7bmfF
 GxbJfBK+ZLJFuKaj26z4TYAFw/fJBZ2aYT3Gdf9/PWAxvbefn01Pz+WJmX4Nh7rCawmJhRy1706
 af0ncqHWyLqckPz6+/8blWQf0tQ+x+89a5TX7S45x/TNzlh3qyeFRl37Ezzy08rXZJ8bL6ooyoV
 EfHX5Ebo1krQ1gmbFK0crxnYXlZhXrdSGia/STswu9wpY82y07y9lQNGfJ8xOBFYyxVkrZOx+qb
 Vw16+qNB63ze6WmWzmfX/E88/ZurZg1MdG+O4LnBeR9/WLr+eX0wq2SAr+u6EnEO5o6eYV8PfnA
 vv3RupYU979rBV5UGpx5cvFAoH1d+/sSiX/KJit4UycDAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=fs7cZE4f c=1 sm=1 tr=0 ts=688cc65f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=mhD89yN676IZukTL2GQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: a2rbmBirRyHzfQ4VqJmUY7ZUCh4tJn17
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwMyBTYWx0ZWRfX3yQXgNGfWVsF
 iG1oOJR5NaAvjja7PI5nP3Xk8M7OO72Hh8vRpSUiNiCbjJ43s1rpGgcAJu5SX1QxnVy7JthoWj8
 Rb84jGIM4IHBbQJ7pSmv+rFhNOyveq8WBqhUasTa0jda23y4db+MDuiskzGkjQl9nV3wSqiFjC+
 yZbYt+HD+S6sJIn6h0xlArG2hdTBZb7MglRB10WcZ8165wmMGGbvKluBB3tXmkmjADVwrHHDiKh
 LZTFdUvVLec9j28IlJZcXk4AjpOxt9Xsgc9mSv+0qPUgWIrxwjlIHSLKS4sgw2I3wZ1NGHKI1xl
 AXmgDC6Vhicv/09brl8d3Oj7RzgW9P7Tc+ZfOlRhbcGIr8khURB78C3v8rvoh8U/aXpXWVTgicv
 TwnIg55ClvE9OivUGt1SQym0L9So6C8tObOekbwv3kNuBJFGakSV2Ls+PA6OvC12iskxXKri
X-Proofpoint-ORIG-GUID: a2rbmBirRyHzfQ4VqJmUY7ZUCh4tJn17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=955 impostorscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
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
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index 8cd37d7b8ae281cbc1fd8cbb243c621174517e23..9986a10e8114680e9da48986f4ca3ce6ec66b8cb 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -134,7 +134,6 @@ static void rcar_du_wb_conn_reset(struct drm_connector *connector)
 static const struct drm_connector_funcs rcar_du_wb_conn_funcs = {
 	.reset = rcar_du_wb_conn_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = rcar_du_wb_conn_duplicate_state,
 	.atomic_destroy_state = rcar_du_wb_conn_destroy_state,
 };
@@ -202,15 +201,25 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 {
 	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
 
+	struct drm_encoder *encoder;
+
+	encoder = drmm_plain_encoder_alloc(&rcdu->ddev, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &rcar_du_wb_enc_helper_funcs);
+
+	encoder->possible_crtcs = 1 << drm_crtc_index(&rcrtc->crtc);
+
 	drm_connector_helper_add(&wb_conn->base,
 				 &rcar_du_wb_conn_helper_funcs);
 
-	return drm_writeback_connector_init(&rcdu->ddev, wb_conn,
-					    &rcar_du_wb_conn_funcs,
-					    &rcar_du_wb_enc_helper_funcs,
-					    writeback_formats,
-					    ARRAY_SIZE(writeback_formats),
-					    1 << drm_crtc_index(&rcrtc->crtc));
+	return drmm_writeback_connector_init(&rcdu->ddev, wb_conn,
+					     &rcar_du_wb_conn_funcs,
+					     encoder,
+					     writeback_formats,
+					     ARRAY_SIZE(writeback_formats));
 }
 
 void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,

-- 
2.39.5

