Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A58C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 11:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03BDD10E152;
	Mon, 24 Mar 2025 11:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V4rCg6EY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7BC10E152
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 11:51:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PMUX030616
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 11:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HHHT+h2di88Hnsl4xAfhOo
 ua3p6DucIksRCHqcJkWEM=; b=V4rCg6EYFROlD5m3BJXIoTh++HFyBLwwUYQvJM
 ejGltDmwp7wU+WUjgeog6cw2CIEQxWiBpzzvMsKc5r/xo3GtPQ5StrQA58O1syWX
 B23ux4YsrajS5JUWN3t1DfezECNYiQhMeZoa+LKVDmg2BLvK5Y2Ihew+x3FEQ5yu
 aHrTNXVXvtZdSkUW9W7A04UpDmN+FhGaH5n2sUqtw0ekW1MiqgrfwNEogYPQJRyn
 LDttiBjeaiarlMYxwn8fTxx/nzs3r9pgUofhjzNpykXUfPHTHtjW/rrfgdJmRM5N
 UxoNP7On5YycpNBATG1gJNOUcsi0JMt+T5fF5Qnd5FEJFdQQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hpgbc5ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 11:51:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e917965e3eso58857046d6.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 04:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742817084; x=1743421884;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HHHT+h2di88Hnsl4xAfhOoua3p6DucIksRCHqcJkWEM=;
 b=oD7oEdv/1/OuNf7EHkYkvy1svtk4XWKFvfsrEG97kuovgRQi1e/lyQhpG2bOI6lnQW
 yQIpX/9PkiWpMJ0T959tSGcPyEeaGngwr7Sh/Clsoj+PjaGb3I8dc4b1XjxJKe6WWFiX
 m5gmivf2G0nCIqKlvOgq3uiPlxxLtzxOvyj3WkZ1uJmrn0peZKB3soAZm7Bfe3eZZ0SZ
 FYG5KMmtQzIfE0opw/IgZbs8rbwTWXZD61wyaZYcN23+we+tZpNsBHMiAbeNznkXiJ9c
 lMMRU0bl/pw5gSHhaLyk5eUmRvl/vYey16MCQ4cw6SCXlZTpyA2Qwi/naCJxvp5qGbdu
 hKew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD+E+1V7+CL7E0CPnyRGvrPeopdD0O6joy2pmic6tz3LD1W0wQ7C2kdB/DUVMYkIgVWf7phV/X@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqyRb2aQbDp0slgYuEw5D2rekQl1qZkIrjm90OSZGeUTcAjD01
 UfDStDAxXcdaOzF72hWGMbUtqbTTWm6QLBQU8gw1AOKgMkgKWneMGT7MLntlmmoM7nAhwKxL+VY
 vJoHRb5rWs/PPNLryK4vBv4vleGmN+w0nKJ8a1gUBEEPfRQLuShzQurSknWn+hz0V
X-Gm-Gg: ASbGncvHMD+WLTMM5BemEvVwrOTLSmfi80YhN58z0XpEXyJVfmjR13hp4fCzbV/C+eI
 7HM1YTTn8qwSThTf+KCQDuoTdMWnNr21CTrkqAQmYF7I2m2YDxx2n/jimxIQfcw9i/AkV43c5dH
 PZx+wNsiYnbjDdyCAQy5LNFMtccGFOPnQs8l1/NLmzG5JgmDWaukwG+K+/V4FokhyCbPSQvM6jc
 10LXvtQsnQOLOsDCmPtPeZg3i/neRmEyYmJpNRXS5w29YRZGUZJhocOmNpP0Mq6UxTvKNPcW/Cq
 8HzK2mKVnVuN+2yAw/J6J21a9cGO+RC5TRk/6I0YybaxpuqdhX5pmL1EWBqcCpkN5pWQm4AFCMg
 jCWZqv+TSWg96Aj4gFMMr7yhNQJ7t
X-Received: by 2002:a05:6214:da4:b0:6d3:fa03:23f1 with SMTP id
 6a1803df08f44-6eb3f2939ddmr188499436d6.13.1742817083597; 
 Mon, 24 Mar 2025 04:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj36F0l6G1JaL0ogDw4h1JCUGq+59PIS80e7WBjTosUk6vT7x5Yv8yf3mUz+pC+Do4mi+8+Q==
X-Received: by 2002:a05:6214:da4:b0:6d3:fa03:23f1 with SMTP id
 6a1803df08f44-6eb3f2939ddmr188498636d6.13.1742817083013; 
 Mon, 24 Mar 2025 04:51:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ad64fbb51sm1142907e87.135.2025.03.24.04.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 04:51:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [RFC PATCH RESEND v4 0/6] drm/display: dp: add new DPCD access
 functions
Date: Mon, 24 Mar 2025 13:51:18 +0200
Message-Id: <20250324-drm-rework-dpcd-access-v4-0-e80ff89593df@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=66iKtCroS+wUxpRA2gMU25wN8Ri0QuCTAm5ya+VinMY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn4Uc3j8hi7hRD+ymVE4ZaY94BaAKhBUU1YaVP5
 QlAqLvMy6qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ+FHNwAKCRCLPIo+Aiko
 1U5YB/9Er45q0Cnmx/cxb3wpGStaZkp9jILfFprTtlgc8IQjnhjovAuz7jPIFzspv+9BxGb6eAy
 2OTUyjJYJjwATk57dZEQGENUMO/pDgokQOAOMSYQWWxs04ePJT7go3UnR5U86af59Gwkv/Gt+ls
 0svFOWah1z9cXpJU3rvAeaXJyDTnSuGd3ayHHGofSOl7NBh2ZxZl1ZQKSC7QvCNx4urQJGoF19U
 OqQRqsC80zHDKJaSoLr/hsgjm81s9ydm6e9Flq65OSSlMpOvl0rkwrD+1oMo2jA83or8sDX2uMz
 TVfNVZ4bRb9Dzu/NTuJq9gOHchEx1jJ3G0iu0IjlkA/NAAQB
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=BoydwZX5 c=1 sm=1 tr=0 ts=67e1473d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=BDmTPyut6bhdKis1t5QA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HSiBukFi9A7xCwPN5XqOTBUS5EKvks8X
X-Proofpoint-ORIG-GUID: HSiBukFi9A7xCwPN5XqOTBUS5EKvks8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240086
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

Existing DPCD access functions return an error code or the number of
bytes being read / write in case of partial access. However a lot of
drivers either (incorrectly) ignore partial access or mishandle error
codes. In other cases this results in a boilerplate code which compares
returned value with the size.

As suggested by Jani implement new set of DPCD access helpers, which
ignore partial access, always return 0 or an error code. Implement
new helpers using existing functions to ensure backwards compatibility
and to assess necessity to handle incomplete reads on a global scale.
Currently only one possible place has been identified, dp-aux-dev, which
needs to handle possible holes in DPCD.

This series targets only the DRM helpers code. If the approach is found
to be acceptable, each of the drivers should be converted on its own.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v4:
- Actually dropped the dp-aux-dev patch (Lyude).
- Added two missing full stops in linuxdoc (Lyude).
- Link to v3: https://lore.kernel.org/r/20250307-drm-rework-dpcd-access-v3-0-9044a3a868ee@linaro.org

Changes in v3:
- Fixed cover letter (Jani)
- Added intel-gfx and intel-xe to get the series CI-tested (Jani)
- Link to v2: https://lore.kernel.org/r/20250301-drm-rework-dpcd-access-v2-0-4d92602fc7cd@linaro.org

Changes in v2:
- Reimplemented new helpers using old ones (Lyude)
- Reworked the drm_dp_dpcd_read_link_status() patch (Lyude)
- Dropped the dp-aux-dev patch (Jani)
- Link to v1: https://lore.kernel.org/r/20250117-drm-rework-dpcd-access-v1-0-7fc020e04dbc@linaro.org

---
Dmitry Baryshkov (6):
      drm/display: dp: implement new access helpers
      drm/display: dp: change drm_dp_dpcd_read_link_status() return value
      drm/display: dp: use new DCPD access helpers
      drm/display: dp-cec: use new DCPD access helpers
      drm/display: dp-mst-topology: use new DCPD access helpers
      drm/display: dp-tunnel: use new DCPD access helpers

 drivers/gpu/drm/amd/amdgpu/atombios_dp.c           |   8 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |   2 +-
 drivers/gpu/drm/display/drm_dp_cec.c               |  37 ++-
 drivers/gpu/drm/display/drm_dp_helper.c            | 307 +++++++++------------
 drivers/gpu/drm/display/drm_dp_mst_topology.c      | 105 ++++---
 drivers/gpu/drm/display/drm_dp_tunnel.c            |  20 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c       |   4 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  24 +-
 drivers/gpu/drm/msm/dp/dp_link.c                   |  18 +-
 drivers/gpu/drm/radeon/atombios_dp.c               |   8 +-
 include/drm/display/drm_dp_helper.h                |  92 +++++-
 11 files changed, 317 insertions(+), 308 deletions(-)
---
base-commit: b0894e40afe2bd05d1fda68cc364665ac2b00e09
change-id: 20241231-drm-rework-dpcd-access-b0fc2e47d613

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

