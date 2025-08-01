Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598A6CA0EC0
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 13:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0963610E876;
	Fri,  1 Aug 2025 13:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ot71yDba";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7B510E873
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 13:51:30 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718h3I1018769
 for <amd-gfx@lists.freedesktop.org>; Fri, 1 Aug 2025 13:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 278QZ0lFfDm835VGauRYZsYszXs7O8BAZXSyOh2pTg4=; b=ot71yDba/AH2AD6I
 Mj2dOXKQojk6IRbIcHcc2poCjsJKGX4bm8HdAdEldXhvifVAQe7sLwhUihEUpDxi
 Pl1EpZu8O1We7/iLGosinar8YzZVZdqFxpd4LK2SyUoHWVYQJ4ci6M0px+NDMHhX
 TWDrEjYRBeN3bW4rjWFBYqF04YLNWilWVI6WjXUBHVAGo6EpOUOyOG0lPHvjUaS7
 FWyYNsJtUvWoilTT6LAhGtrPZp+uzfxD+fG908le2MPVxQLPA52G8WkI+6uoF7zS
 t8Zf4KA8nqADiu5GRVoxg5//Jm3JaqPRCbGsBD7mSZj5Lxk/IQv1Bv9DHg9xF+nj
 4FoyrQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwggj7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 13:51:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70743a15d33so25861566d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 06:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754056284; x=1754661084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=278QZ0lFfDm835VGauRYZsYszXs7O8BAZXSyOh2pTg4=;
 b=K8zz1iBrP8phjiSafGusZ+Vfb6Jq0Xyfrnxv/shaSCNccFJQHAezX9JZWLluEtTGiZ
 HZCsjmPKZmONa1MjNVOMfsiIgvt5m/t54QzBA9S9w/zGrD42toQ8FRHtJOaX7qSLEYxu
 f5oIbFxGafxOOPRblWvgXJ1OM3GO8vAYhLTZz4THabUWrX4dG010gOR+f6LMFyoJvA7z
 q33Xp2p1igkvXoKVoC5YG9IO5f3+l8Uo/1sHtvXM3aBm3uBI3lEnLsTY8Y9f2Oq+0qSG
 6DeW9Vxd0hqVFa0d+er/YEXu3a1MB4EvlOeMNuQWkJHhJMP4ZqnUJXxcRFt3p2TLOjRV
 90pg==
X-Gm-Message-State: AOJu0Ywt2UrvxJgDjsMG2gWs+ujtfIXa2lu3kDd0RBjgEV1hGaHPEOFs
 cMel37IIYuIhleujC3weYjWojGjbg5Nu8A1IdqcwpANmFB58qzpxO8BeusRPp/a25aQDWWzRSOq
 +qiYDu9o1EuRunSW+P3MV3xl3JRApmyww+T7SBM8a+phZQqKjBlfZ1MsOpsmUJG1AetLu
X-Gm-Gg: ASbGncueXJ73d0/Awd+ukNYzklQ/qtm/bwxpEKCP3Owt1Iy1DS7rldy91xiAJAmoAtO
 P5+4ebrdmRkUvkY/Zq9LHvfNvEwhizCbLBxB/FtDNXpV05E5CRN7KfRA8CxAr0qwGMiMDAYzXCb
 8ZSljrCc0fC3nIpU/kQb0/5MSzeNTSRNl1vetGVo3iYrHsDSO2VNkf/zkcONUQv0bn0COOEeqgJ
 D7vDdPzj+allBXzatVn0NI4tTzKTJlP/diXQPXdPMla4yITtAyJGlDGIwJqDWr8gOqzstQDXg1k
 7Z/lajb0KaIADARD35KCKzTr2S5r352ub4fBRlgN9GDfnjnCHhbTVRxxHc8rnBGxd4ObX/QKEYk
 1/Umfv4Y+Q/NwvqiFCinZrhsSxorp+oJZxWbz+yPAdEF75SOJtGCR
X-Received: by 2002:a05:6214:226f:b0:707:4fec:c0ca with SMTP id
 6a1803df08f44-70926508ddcmr38892536d6.4.1754056283824; 
 Fri, 01 Aug 2025 06:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJom3kFAnf8JFuU2DiA4RfLsiaMRDn6FA+aJ51nDsVnUTvIGfyBP8DkrKWMMjE38R3E76PPQ==
X-Received: by 2002:a05:6214:226f:b0:707:4fec:c0ca with SMTP id
 6a1803df08f44-70926508ddcmr38891606d6.4.1754056283051; 
 Fri, 01 Aug 2025 06:51:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-33238273006sm5917801fa.9.2025.08.01.06.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:51:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:51:12 +0300
Subject: [PATCH 4/8] drm/msm/dpu: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wb-drop-encoder-v1-4-824646042f7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4v/UkWVUd2usRk11ttudKMK/GFE7oPMYIMlz0jnkFl4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBojMZTDNkPGITvncNEDx/CNCeglk1Jp+f/ChpC0
 AXAHrPUnAeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIzGUwAKCRCLPIo+Aiko
 1f8aCACjBXtlBxXcmFySHdDryhXuuyHrGFTLWoQAJYFbFPslFIRoxZSJT6mHErULJ228fcTw8Ww
 risQU9WSdjD7jV8ENl54qLAQNALPedsvbKGwten2/zVwwHND1/tHm62gE/zJVsv0AAxskybYyqX
 XgnflK5pL7cHdNq8kEqSnM8NrkQfgWCwS+NE00GVjlUOwvIM+Db4IxyZpw8ysGkKcOooYn0XV1j
 4zVzcS/pLcAgTkHK6SEWIusjCrJuUX2qaE0MHEDMfL/vyb+buazqF8TLWkgP4XM94aJOKBQFcAC
 qr7avC1KLtKnUu4777zLxpSwk41rREYYp97VOlRBxnyQ5KCS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688cc65d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=UqIHtJT1QCIVCAY24KsA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: -vQeZfdko2SmkKbKnBCLF0NfAHsBL_Q3
X-Proofpoint-GUID: -vQeZfdko2SmkKbKnBCLF0NfAHsBL_Q3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwMyBTYWx0ZWRfXxZQBdpi3IM69
 wjTlCXBDxkYHwkr8s/VT4qY8+sQG3jwAgl/lvJlvcen3qjVCtDsmD5VsBdQUfNK4AMDF1eDVTvN
 2M4BKADJWtWMLyoUwq4cWyLytR8q4SVktN28/v7uYdUmdu63ayyyTPWNGODNns44Q6F+9//h8AN
 ip5DUF7KxIewrrAOaFkZtayAlWQRM+OfQNv/EFEZse4goz07/QbomIKSImQrXPynQn/EtV3gYre
 /18/jEbWexJOC0lwosO2th1+zVIx5DQQrQCHT2GVVxtReGcRfgOghGP5KGn6CwjClis3t8sQRjk
 ShWo3AwdxLw9eMIDrxC5mHViWM+gIVvDP/NarT0GiiGvEqXy25FxlXD4Vgd4tllmbl2+gCVmyDT
 Zu13vVwHLIxfAPUNuzoKGyzW7mHsQSbf08mU64m4Rm2jdnKP3k0D4GlQZ3bbdNOWHlboWhXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=980 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010103
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 8ff496082902b1ee713e806140f39b4730ed256a..cd73468e369a93c50303db2a7d4499bcb17be5d1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -80,7 +80,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
 static const struct drm_connector_funcs dpu_wb_conn_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
@@ -131,12 +130,9 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
 
 	drm_connector_helper_add(&dpu_wb_conn->base.base, &dpu_wb_conn_helper_funcs);
 
-	/* DPU initializes the encoder and sets it up completely for writeback
-	 * cases and hence should use the new API drm_writeback_connector_init_with_encoder
-	 * to initialize the writeback connector
-	 */
-	rc = drm_writeback_connector_init_with_encoder(dev, &dpu_wb_conn->base, enc,
-			&dpu_wb_conn_funcs, format_list, num_formats);
+	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base,
+					   &dpu_wb_conn_funcs, enc,
+					   format_list, num_formats);
 
 	if (!rc)
 		dpu_wb_conn->wb_enc = enc;

-- 
2.39.5

