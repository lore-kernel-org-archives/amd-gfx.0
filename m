Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78201CA0EE6
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 15:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A29D10E384;
	Sat, 16 Aug 2025 15:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oCAgJmfF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5D410E384
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GFFssF001347
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5lryexlqd0cwKQzcmybpaI
 +3EMl9PhbQcl2IWaTvkAM=; b=oCAgJmfFi/I2hzZFvUUpZcIkfXUtBg3UORsCZf
 JW43oqB6fB7mnzKdW1JpGIZ9TtzLtE+W3jZ36ZMH0RXXf53Mhu96U37P8XUnxarY
 oimPLzWmgJZFXbICcXB0HBA1w1gu09hc1CXhdn16cHauAmztii6bPGsJnEFJoSC3
 aYiCb5CpR3aeAnly/872UnqG7qWifllQ4xar86OOnxToYp63YUVDlMLJ7cDGODHY
 oH6TvRWa1VymRh1hvQ7/2Lbt+4Mcrs7mZQrgFZ+OPFp7MRkfVs3ANWt4JXNERfd9
 6AHTINJsBENxDPhLNKJRYyljl1ij1Dn+lNT1choVU6dt8tAQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjrfrs44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:19:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e86499748cso959410485a.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 08:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755357580; x=1755962380;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5lryexlqd0cwKQzcmybpaI+3EMl9PhbQcl2IWaTvkAM=;
 b=Q4Qds1NDF0qno17GMEZU0q0VXl0b+4jdtGXCT1bpm56zPvT5va2uFn10TjX+XlEvtH
 iE04pD5iLkORbgkjxCcCP8+OytrfilHD3NT9Cblo4v5ZpNpgupT1om8oIEHL/3LGkoSh
 DGjYsBAteafm4ytxRRKYc6Ub3sfILf3q9bcqPTjVUach4Sns1cGUG1vW1ZrW5DAqyGQm
 NrmbLd5KFuvx1Rq4Z//4oQV2qB52pDNnPwmathb0WlmFr4sFhZShR5iZepD9wnGHX+bi
 2la4qWjPsdbw2+OjC/XxwbVyDraEE/GKihg69LE8SvsaltmZ4j4u7qnWzLaEXRTzwWfG
 wGcw==
X-Gm-Message-State: AOJu0YwXDFf08HD2iwjQ7NOcOdUiT6bOVFNndNDut/JyHx7mw2aLPQnM
 x4cdqw35+sJpybZCZDOhtVgp6e8cyA1zITb66iICstlH6QwOjAo74ePfbAjXN1EBT+d2w5IV6xI
 HSwYtLSsiBe1tzZuS6489k2gCi2yRSSAl8OfYKs4LeFXNKVObLpoV8DtohrKtu0zRwl6A
X-Gm-Gg: ASbGncs1bM5s7cwN+HTQr+keJ7zwL8BlsSNvENFU1qp4GlO2z8uDPUThu4jXvc2rTPh
 sQtW43GMKH5LyZOovUYji+/99e5KRPlXxqpppWn1C970UAbedcvIjtT+PyQhNPd+zLLRbT19Bv9
 o11sApkCY/54WhCKm4G43v6AhBOZgUcLTJEhM05nQCfaDNDVlsi/eF8a+m568bvJoCs2ragmEIf
 m7m/p8arroRf0wLlS8F4QYI09OEp2gSHRO5Sr5yYpq/UTkn7lX6wtC0g7YBzCKo52nfIEDaDSyA
 pfvpBx0eTFiWN7f6P4ERqm/o7gwhtvyktNyha9u+CLoIfgnpZKIYWAxNpk2SdbI/aiDJVtCenUl
 UWLW0FtDcjadbGgpPgBSgoSpXuvGCYKe3Ql7879aNEtlpcA6HxVKT
X-Received: by 2002:ad4:5587:0:b0:70b:ae3b:4fcf with SMTP id
 6a1803df08f44-70bae3b53demr47856646d6.23.1755357579692; 
 Sat, 16 Aug 2025 08:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfelfomvA5wci6xz+3wi0J8SULNHFeOUuYXDPXJ1C+6Dag8vtfdR/Y+CaRJy4U66cTGuwdXA==
X-Received: by 2002:ad4:5587:0:b0:70b:ae3b:4fcf with SMTP id
 6a1803df08f44-70bae3b53demr47856216d6.23.1755357579187; 
 Sat, 16 Aug 2025 08:19:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55cef35965fsm907579e87.37.2025.08.16.08.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Aug 2025 08:19:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/8] drm: writeback: clean up writeback connector
 initialization
Date: Sat, 16 Aug 2025 18:19:34 +0300
Message-Id: <20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIahoGgC/3WOwQ6DIBBEf8Vw7lokKtZT/6PxgLBWkioKaG2M/
 17U9NjLZmeyM29X4tBqdKSMVmJx1k6bPgh2iYhsRf9E0CpowijLaEETeNegrBkAe2kUWrhxQSX
 PapUpTkJqsNjo5Wh8VEG32nljPwdgTnb3f9ecAIWCpXma05Q1XN2Nc/E4iZc0XReHQartZFgcp
 /CsP0GkFg5hP9K+jJTtoNNOXn8L9Lj4EN2+MNFAzu8AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2260;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=A/d943iupZVCsxCU+H3jAnKd2fBEwptYqE3Wnl3fWfg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooKGIGMd13UWHpYiChLD84LKwc5yW7HTOFZ5Nc
 BeTRdJYMi+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKChiAAKCRCLPIo+Aiko
 1VU2B/4olLxWynZ6yiMZ4UeXGeUOQWFTHVS0OmcvLMCYAz5OQG0aZQ8ccKIlHwyxoHSBsBg78Mr
 5QdHuJQEQDktITLER+XgXzSQGcAgijiinR/nhTa+NfpLIGR/EZrDmm2Pzno0MlDiSYg29IhxB4T
 kEyqTv5mjfkGwilg9DYt3nua1zSszeQdW1SnwwmS2bJ5BNDrwFKw9Be1apeVE0V5bbt3gjV9cJ1
 CTyH4/m6IJr1ZW1Z9GAeYcsmchIGnAeuuUGT6OENI6yZkiEVDemT5O54HW7bSXSXNU41/Le5fiv
 QQeKwVTkV8cEZ7a13v/GM/cWDBTcehtOQTW4bxGUsGsKFDS6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: nMspcmHhai3ikThrvA_DdCEf62XiGApt
X-Authority-Analysis: v=2.4 cv=YrsPR5YX c=1 sm=1 tr=0 ts=68a0a18d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cFjmsF-WLDi_aLc5EnEA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzOSBTYWx0ZWRfXx4JGe33zcp19
 VzDap46iNeWygQuxqbPZJBFLRZRysfk3vLCshK624a+m3Sp3pJnY4SEsLOqQc7E6EZ1xJqMAspI
 A0Dp3b4OWkHNM+3iq+SXCHJMNDnjSGYaStVjVgAF+TEeoyuuuXJIT47WzKlq3a4LvZ/zG2HXhOh
 CLuhJsWbQ3eE5pDPHJLBYHBg+RCWXpOC3td6i2O2gGbYlxRWMr9mDIPl4vC4TsvWLBk6xHmLKP1
 2e08HANuA5oxEOFII4f7ZgyWN45BqjmgzfO7zlw1+1xnC698jJTblRR0OCZVlF3umYwo9JWDf1d
 6dfgc1sKmmIXKHTo1H9ahVZsgED1d8nMaDtUdqup8uVmvu+hDe3IH3J7phxghrsPqsSFOHYmfw6
 5u4H++mv
X-Proofpoint-ORIG-GUID: nMspcmHhai3ikThrvA_DdCEf62XiGApt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160039
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Switched to drm_crtc_mask() where applicable (Louis Chauvet)
- Link to v1: https://lore.kernel.org/r/20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com

---
Dmitry Baryshkov (8):
      drm/amd/display: use drmm_writeback_connector_init()
      drm/komeda: use drmm_writeback_connector_init()
      drm/mali: use drmm_writeback_connector_init()
      drm/msm/dpu: use drmm_writeback_connector_init()
      drm/msm/dpu: use drmm_writeback_connector_init()
      drm/vc4: use drmm_writeback_connector_init()
      drm: writeback: drop excess connector initialization functions
      drm: writeback: rename drm_writeback_connector_init_with_encoder()

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 18 ++++--
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++----
 drivers/gpu/drm/arm/malidp_mw.c                    | 25 ++++----
 drivers/gpu/drm/drm_writeback.c                    | 69 +++-------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      | 10 +---
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++---
 drivers/gpu/drm/vc4/vc4_txp.c                      |  9 ++-
 include/drm/drm_writeback.h                        | 22 +------
 9 files changed, 77 insertions(+), 131 deletions(-)
---
base-commit: cb640b2ca54617f4a9d4d6efd5ff2afd6be11f19
change-id: 20250801-wb-drop-encoder-97a0c75bd5d7

Best regards,
-- 
With best wishes
Dmitry

