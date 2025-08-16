Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0313ACA0EE4
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 15:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2484310E397;
	Sat, 16 Aug 2025 15:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rq2p6ZCR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E1C10E398
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:49 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GEhrQe019711
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mEvIV2bV6AlxqzM7m9xsvqcJBh2delxnqohnrAUROZo=; b=Rq2p6ZCRr0spzxZ0
 77c/jJP+Aq5MegOt6dmVaWnsD1K1fiMgfkNxzfMZCTefVuTHV/4/fIak+3av+jUQ
 CZUQ1TyIeYAAiwf86MZ90zppw4ikLmmdYy7UzEyD5U22cD/5qGbrXv6nFTPhJsxj
 KZc5Bv3I//PggYVGIZGVv2+YNg5v1xBzv4lr8oyMxPE3j5e1jrSjZLQjX7eMnK7m
 E+/fWwk4FzT0XWqbU+lbOVqR3XwXUTutn2mNVAAs5C/27u6xCSzKcOwasrm8HGVA
 bflEF9yCI/ttaC2nIovn/RF+XYvx8CkO29dE3lQIOVK1f+ghxzc3dkaML72LyHTg
 cCAHtQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jfbn92b6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70a9289baafso57669526d6.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 08:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755357588; x=1755962388;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEvIV2bV6AlxqzM7m9xsvqcJBh2delxnqohnrAUROZo=;
 b=vIZMZ/okRU78W4yxZAjiDD4ui9Wcu2UA+la1rYut6EwlVb7V66wvjomns/FcgRIUIm
 o+Za8eTzYkGIQlh5J0FokqyyBnwEoq0VEYlQVEozEoQh9DCZ2ylh4BY3paZKvkY/Us8+
 7gYPkUk2tHTfpEgOfwOVkSFCq0ft14HWIUbjOPAJGiN83tZTyZzzQxGml/L+aI74+N7Y
 WX9la8U7h5LfC8031Hg99YYqOjj57KFdW708gywM6tB8xzvuDPdkjXnkE1Wt5sz2Wy3D
 GXhPQmsh/VDLzc9rX6cwib2GatJBLPKb5j4nvk9YE9cwa0RvDlKqTVuxZn+EwiiKa+lH
 L5zA==
X-Gm-Message-State: AOJu0Yzkae5ECy8p46Dp3yVRRRYpjY1z6rnxnJH6e9KFTX7tXH/iQxJx
 nCAN35DiYbHcg0FGG3qwK1XOOQpHcHZTfuV5gfgQaX6wDHuPrlS1EruRaKkTjoyeyeIPtU+jDxa
 Dz1/wMXOOndeSlM+WV5SUg24UMjdlQgUB4Aufqdlsy/ZlGsjJCGGBieFpV2UqE4trW9ZZ
X-Gm-Gg: ASbGnct58EhZMsLfSLvTbLcWaE9iMbXkJ/xFgSMnAtUXcIakD8L2W2Quq5cL5wnpDdV
 j9EcS/8dIFHi+ikh1OtD5enZ4QyYkJwKVaY0aYwWQk609R/2T69zG5n8FaMLaBqSY2+Cg09LhQq
 VPnQPaCaPx1Eq0guNZnFSlv9qL5pZDIX/5VH7xtgOVvqDowdcZGCN7E+qKuaELf6TMVFsb29tvk
 cRRycHWkbLgDdz5vsqhEAWBB0R6XMlERoivIb4sFdWIU45v9eyl+1+oFsKiP5MKuZATf0MoOMNK
 FxTs65iSS1DTbZb98njR+qJSkhtD1ppSp+ZcNIP096WNDH3AM80jvLI1UCN1OFOqiPHeQELtk5k
 ol0uvKFXMew+zCy3fi+UVlXQ5e15m2Uh/c45dsv4lFmTNys6Ibbcl
X-Received: by 2002:a05:6214:76c:b0:6fa:a5c9:2ee7 with SMTP id
 6a1803df08f44-70b97d50e1cmr134782356d6.8.1755357587580; 
 Sat, 16 Aug 2025 08:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGElAmZI2U8Jde4TU+ICdrflTejDEsiodGV0TbuZxZ/JkbA4U1g8hagzZyjmkD4GE9Spc44Eg==
X-Received: by 2002:a05:6214:76c:b0:6fa:a5c9:2ee7 with SMTP id
 6a1803df08f44-70b97d50e1cmr134782076d6.8.1755357587134; 
 Sat, 16 Aug 2025 08:19:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55cef35965fsm907579e87.37.2025.08.16.08.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Aug 2025 08:19:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 18:19:38 +0300
Subject: [PATCH v2 4/8] drm/msm/dpu: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-wb-drop-encoder-v2-4-f951de04f4f9@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=SsfbY2BgCwVOdMoS0AB7dKBbl1htE78XemRzUg21Jp4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooKGJdDsbpspC67fG8mISRpjdFMuBL5GkSkS6i
 1YB1BXzE2iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKChiQAKCRCLPIo+Aiko
 1R+zB/9gVJgtlwuaXv286oPUL9YSSVxu5wvJRyS4WQ5lemWaU/gD7xFDGPshn+e2TlAUr79nPTK
 96TU41SHn4rJvfF1yjT5zrSVt39knNzks20P0e1N2/kooOaxT1XXy2MtbLZ4ttPfwnQYVHz49ZI
 vrXB8KznoEhnSXUNJSGt91MSRuu8BsA3Ju2EPpnZ9OcPApZHYZgeSbTJLLX722M6HN82yun00Mi
 h5EbNOZ7z599t939ktW4ogS9gFbXrfpH1OSTFHXNmrGEFgNJtlzv7sSSC27KYq1rMFBU3DSLW/z
 RtCbCCGPzLhyP8pkwOvuLLihiQ+pB9/+eq8ylzIiVxNO/dOE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfX4IoLTBbDMcME
 3JvYXvBZbKm3RirgDdQAXYaWZtqQCrlJjbSq+clDsk8RUhITxcsrnuFV7m/u2MCY0eIT5fPEnay
 17tZwEKyVz3K8hhw2ABrPwG3nv1u3B7YG4DS5iTiVyQb3+lz9rp5AjCVdQjtxjO5cDrgjqmWLeT
 A9S7dKl6gkad+70pv25lTNYKrZEyQu0xO027UxjbeBFklKcG4svdptLX/CLmo7oGiL+IbH9ZkKD
 ArVm0cuOBEUeL8E9TVQMt46iU0kVEYVM95y2w84rsWB7GXQVrCs/SIL069zDmSDpZI5CSAccSmW
 Hid64BfjW022R14ONDbok9w2nWjhinybwWZSUDIV4YrStO1piV7Z4AhwOVWt1KUCk/Xqwn1snbu
 opRzOb+w
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=68a0a194 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=UqIHtJT1QCIVCAY24KsA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: K_uCHAmyNloNv2B4qcDdEK6mQAzGa_f6
X-Proofpoint-ORIG-GUID: K_uCHAmyNloNv2B4qcDdEK6mQAzGa_f6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160001
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
2.47.2

