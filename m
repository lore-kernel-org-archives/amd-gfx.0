Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4951EC35FF9
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 09:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72ED610E9B4;
	Fri, 14 Mar 2025 09:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JHSMz4k0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E25D10E957
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 06:00:15 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DMcNpx031592
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 06:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xs5rT/RGnzQe0TKC8aJ0U0f62LNypMaSbN5UiwapTF8=; b=JHSMz4k0IbzBbmVG
 nWSnPcYKL29CfbfGBsXALTBXgXRw1Ua64tLDSDvFG02crGxBC0HjT+HEwbVIYgF2
 IHGq8a8eToEX5Ti/oxyB+ksGf0C0bZFpqOLSYFQ/CXu4fiyQchod/VHF63KxeUqd
 z1/O7tPo77c91SWFDQ7g63ByfQOdbWvTchMFiMBG0liosoi8aGwoobgGxLZ/G7Cc
 hEObgahe+AYVIuPLGLA3OZ3ZjyyEPnJNjrt4ND1mzF/4vZ/xFDOc2JKBbCFNHpyV
 Mxt8uPGHadEW5TYKlqP8KMtT0KwZm1gmAG17bNsQW6rlnQr8wEfZLtU1VYWJhuz/
 PyOQdw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bx1jjm2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 06:00:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e8ea277063so45209646d6.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 23:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932014; x=1742536814;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xs5rT/RGnzQe0TKC8aJ0U0f62LNypMaSbN5UiwapTF8=;
 b=JqBIX7N5/Jvws+mdbCp82BMv1tp9HmLqRTsB2DpuSJ32t4QU/MJRxKX8IWR94NatT3
 HzSqK9VQSabToXmkGQAPgWAtONieBucg96K9l7wWRo+EUnpsT9zVy4S51ClY+y6jV3kH
 QSpCWNYlcwO3Xf6qxkRsOPyQaRpqaGsIzJszwBy8j7r0O+xNlfmLmkgXQCmYHdQwR290
 /nSSzUmGUDpHsmhqS7a3KZhAM1Ef9Q7QlW78Z2zYxlJwyDJqTp8LG9o7IQlXrv9oejsE
 bZMrktZ1f6V5QDVb/ut8ZwDHt/r0STfcyRQ3nnGA2A5mmceGHiZTnHv2ESQGYMzy45OJ
 hbLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHjvEXVdPin6wPfMXV98hxeI0zvANTEi0NgV/Xg/7GwnmNuzI0Hh+3h59SjzSG4SIUsgf6OVsf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySK09J9ep1KXwi5uW8RgT1WGp4Vfnkv1Q6tHSvnwPmJVmlnBx0
 pTG2ixzHJe+wYfctoXMhlzy8EoTIU1ZvD/TWFs7L1RPQpv+onPOVOr7UsTgZDh+XFIP56+VzcmS
 jvnkEv8qH67aYZ3NkdVNurV6EXGsuuEzsH/wXvh71cUIwSv3LwKHX8NQF/wm8CtQZ
X-Gm-Gg: ASbGncupTqcirvUjSKgQc/9dAYqY0qBOlqjAaAghUvoPKFM2Wio/7uOWPNO1s76ABW6
 D1iOFPW2g4gITkip2zC7pXVMAMaahTxMhY1DuAQmvl6Y9to2KSXEbusa7CIazz6r1/fKbdBD9ns
 eUvqw0dftOIINsekYRMv2T/RTCuqaGHtbqGhZ6OvPFphq38XVS3h1IQjgoodZiPcHoq4gvk5e9N
 OpzBBkrte3S+vR7wGzHGZ4lX8H1+tdOk+PZe727Fi0bviUCsmYf4r/gT4OQT6MDmlCSJEp0fuD8
 91Nz5kl7lzTcDIY2PKyzo4EmPEe0GTqw4r4hmsuDniPTV2NhAAxc2rjqS/6Li5YM9Zb9z1R6gmi
 GQCjsUL1TDXStfODZsG5d9kkKDIdc
X-Received: by 2002:a05:6214:21a5:b0:6ea:d046:bcc9 with SMTP id
 6a1803df08f44-6eaeab6a013mr14675626d6.40.1741932013632; 
 Thu, 13 Mar 2025 23:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9ggfslk4zuoLATTvIv1igTQO20IZTMXu60Z3sCx9HbRmLLfdN8lOCY9L1MrQPBMco04OZcw==
X-Received: by 2002:a05:6214:21a5:b0:6ea:d046:bcc9 with SMTP id
 6a1803df08f44-6eaeab6a013mr14675226d6.40.1741932013248; 
 Thu, 13 Mar 2025 23:00:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-549ba88332dsm416136e87.181.2025.03.13.23.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 23:00:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 07:59:46 +0200
Subject: [PATCH RFC v4 5/6] drm/display: dp-mst-topology: use new DCPD
 access helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-drm-rework-dpcd-access-v4-5-e86ef6fc6d76@oss.qualcomm.com>
References: <20250314-drm-rework-dpcd-access-v4-0-e86ef6fc6d76@oss.qualcomm.com>
In-Reply-To: <20250314-drm-rework-dpcd-access-v4-0-e86ef6fc6d76@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8924;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lOAwM26QhsV15lYFaBEeUiZtWiwv6AIfNojc3p1iTEQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn08XZq48cvIyYBf/kBkcM6PZ2QjbmI2P9MTtrN
 EoXaoKdsA+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9PF2QAKCRCLPIo+Aiko
 1fWFCACECdIgEwfsDhf3wmAf6H5YXKRkrLkmnSjIiAWprKvWFDsmv/JnUN5rPrwiqVxajQKJ1Ne
 QULtPar2xu3aotOaPpZGQqlpr2DuSJ8vJhzKdYP/zPeigvER0lpF/YKx97L5KEEYOOMtIAa4Ye/
 9iFIofIb8EMrImkxMgE17XgkIL5o9YozJuhoArjL8hHPH2lduf8uRwe4b0Rzai65LZErXnMIYYa
 3gUIVFS0UVQs233oQQxqr6Bb3dqeSiFNZjA3fDI9pAgPivD5eE9r7vsNgTRMDLVkpCcFbJxDqrN
 HjQJvTmzWVYnG6lxh4LD1QGn7vQToMz8Q6Uzzp6ChCbfeQ/Q
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=CNQqXQrD c=1 sm=1 tr=0 ts=67d3c5ef cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=CIugonsnW1z_eXyUCzcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DQ7LMod-O-WVTh4FWrCXTwXXdKqYgR33
X-Proofpoint-GUID: DQ7LMod-O-WVTh4FWrCXTwXXdKqYgR33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140045
X-Mailman-Approved-At: Fri, 14 Mar 2025 09:11:23 +0000
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Switch drm_dp_mst_topology.c to use new set of DPCD read / write helpers.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 105 +++++++++++++-------------
 1 file changed, 51 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 3a1f1ffc7b5528b940485e7d96b1913bd85b0153..de3fc6090c906efce3dbaa8462d736ebf9094b34 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2201,15 +2201,12 @@ static int drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, guid_t *guid)
 						     mstb->port_parent,
 						     DP_GUID, sizeof(buf), buf);
 		} else {
-			ret = drm_dp_dpcd_write(mstb->mgr->aux,
-						DP_GUID, buf, sizeof(buf));
+			ret = drm_dp_dpcd_write_data(mstb->mgr->aux,
+						     DP_GUID, buf, sizeof(buf));
 		}
 	}
 
-	if (ret < 16 && ret > 0)
-		return -EPROTO;
-
-	return ret == 16 ? 0 : ret;
+	return ret;
 }
 
 static void build_mst_prop_path(const struct drm_dp_mst_branch *mstb,
@@ -2744,14 +2741,13 @@ static int drm_dp_send_sideband_msg(struct drm_dp_mst_topology_mgr *mgr,
 	do {
 		tosend = min3(mgr->max_dpcd_transaction_bytes, 16, total);
 
-		ret = drm_dp_dpcd_write(mgr->aux, regbase + offset,
-					&msg[offset],
-					tosend);
-		if (ret != tosend) {
-			if (ret == -EIO && retries < 5) {
-				retries++;
-				goto retry;
-			}
+		ret = drm_dp_dpcd_write_data(mgr->aux, regbase + offset,
+					     &msg[offset],
+					     tosend);
+		if (ret == -EIO && retries < 5) {
+			retries++;
+			goto retry;
+		} else if (ret < 0) {
 			drm_dbg_kms(mgr->dev, "failed to dpcd write %d %d\n", tosend, ret);
 
 			return -EIO;
@@ -3624,7 +3620,7 @@ enum drm_dp_mst_mode drm_dp_read_mst_cap(struct drm_dp_aux *aux,
 	if (dpcd[DP_DPCD_REV] < DP_DPCD_REV_12)
 		return DRM_DP_SST;
 
-	if (drm_dp_dpcd_readb(aux, DP_MSTM_CAP, &mstm_cap) != 1)
+	if (drm_dp_dpcd_read_byte(aux, DP_MSTM_CAP, &mstm_cap) < 0)
 		return DRM_DP_SST;
 
 	if (mstm_cap & DP_MST_CAP)
@@ -3679,10 +3675,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		mgr->mst_primary = mstb;
 		drm_dp_mst_topology_get_mstb(mgr->mst_primary);
 
-		ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
-					 DP_MST_EN |
-					 DP_UP_REQ_EN |
-					 DP_UPSTREAM_IS_SRC);
+		ret = drm_dp_dpcd_write_byte(mgr->aux, DP_MSTM_CTRL,
+					     DP_MST_EN |
+					     DP_UP_REQ_EN |
+					     DP_UPSTREAM_IS_SRC);
 		if (ret < 0)
 			goto out_unlock;
 
@@ -3697,7 +3693,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		mstb = mgr->mst_primary;
 		mgr->mst_primary = NULL;
 		/* this can fail if the device is gone */
-		drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL, 0);
+		drm_dp_dpcd_write_byte(mgr->aux, DP_MSTM_CTRL, 0);
 		ret = 0;
 		mgr->payload_id_table_cleared = false;
 
@@ -3763,8 +3759,8 @@ EXPORT_SYMBOL(drm_dp_mst_topology_queue_probe);
 void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr)
 {
 	mutex_lock(&mgr->lock);
-	drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
-			   DP_MST_EN | DP_UPSTREAM_IS_SRC);
+	drm_dp_dpcd_write_byte(mgr->aux, DP_MSTM_CTRL,
+			       DP_MST_EN | DP_UPSTREAM_IS_SRC);
 	mutex_unlock(&mgr->lock);
 	flush_work(&mgr->up_req_work);
 	flush_work(&mgr->work);
@@ -3813,18 +3809,18 @@ int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
 		goto out_fail;
 	}
 
-	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
-				 DP_MST_EN |
-				 DP_UP_REQ_EN |
-				 DP_UPSTREAM_IS_SRC);
+	ret = drm_dp_dpcd_write_byte(mgr->aux, DP_MSTM_CTRL,
+				     DP_MST_EN |
+				     DP_UP_REQ_EN |
+				     DP_UPSTREAM_IS_SRC);
 	if (ret < 0) {
 		drm_dbg_kms(mgr->dev, "mst write failed - undocked during suspend?\n");
 		goto out_fail;
 	}
 
 	/* Some hubs forget their guids after they resume */
-	ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, buf, sizeof(buf));
-	if (ret != sizeof(buf)) {
+	ret = drm_dp_dpcd_read_data(mgr->aux, DP_GUID, buf, sizeof(buf));
+	if (ret < 0) {
 		drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during suspend?\n");
 		goto out_fail;
 	}
@@ -3883,8 +3879,8 @@ drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up,
 		*mstb = NULL;
 
 	len = min(mgr->max_dpcd_transaction_bytes, 16);
-	ret = drm_dp_dpcd_read(mgr->aux, basereg, replyblock, len);
-	if (ret != len) {
+	ret = drm_dp_dpcd_read_data(mgr->aux, basereg, replyblock, len);
+	if (ret < 0) {
 		drm_dbg_kms(mgr->dev, "failed to read DPCD down rep %d %d\n", len, ret);
 		return false;
 	}
@@ -3922,9 +3918,9 @@ drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up,
 	curreply = len;
 	while (replylen > 0) {
 		len = min3(replylen, mgr->max_dpcd_transaction_bytes, 16);
-		ret = drm_dp_dpcd_read(mgr->aux, basereg + curreply,
-				    replyblock, len);
-		if (ret != len) {
+		ret = drm_dp_dpcd_read_data(mgr->aux, basereg + curreply,
+					    replyblock, len);
+		if (ret < 0) {
 			drm_dbg_kms(mgr->dev, "failed to read a chunk (len %d, ret %d)\n",
 				    len, ret);
 			return false;
@@ -4881,9 +4877,9 @@ static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
 	int i;
 
 	for (i = 0; i < DP_PAYLOAD_TABLE_SIZE; i += 16) {
-		if (drm_dp_dpcd_read(mgr->aux,
-				     DP_PAYLOAD_TABLE_UPDATE_STATUS + i,
-				     &buf[i], 16) != 16)
+		if (drm_dp_dpcd_read_data(mgr->aux,
+					  DP_PAYLOAD_TABLE_UPDATE_STATUS + i,
+					  &buf[i], 16) < 0)
 			return false;
 	}
 	return true;
@@ -4972,23 +4968,24 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 		}
 		seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
 
-		ret = drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
-		if (ret != 2) {
+		ret = drm_dp_dpcd_read_data(mgr->aux, DP_FAUX_CAP, buf, 2);
+		if (ret < 0) {
 			seq_printf(m, "faux/mst read failed\n");
 			goto out;
 		}
 		seq_printf(m, "faux/mst: %*ph\n", 2, buf);
 
-		ret = drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
-		if (ret != 1) {
+		ret = drm_dp_dpcd_read_data(mgr->aux, DP_MSTM_CTRL, buf, 1);
+		if (ret < 0) {
 			seq_printf(m, "mst ctrl read failed\n");
 			goto out;
 		}
 		seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
 
 		/* dump the standard OUI branch header */
-		ret = drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_OUI_HEADER_SIZE);
-		if (ret != DP_BRANCH_OUI_HEADER_SIZE) {
+		ret = drm_dp_dpcd_read_data(mgr->aux, DP_BRANCH_OUI, buf,
+					    DP_BRANCH_OUI_HEADER_SIZE);
+		if (ret < 0) {
 			seq_printf(m, "branch oui read failed\n");
 			goto out;
 		}
@@ -6112,14 +6109,14 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
 
 	/* DP-to-DP peer device */
 	if (drm_dp_mst_is_virtual_dpcd(immediate_upstream_port)) {
-		if (drm_dp_dpcd_read(&port->aux,
-				     DP_DSC_SUPPORT, &endpoint_dsc, 1) != 1)
+		if (drm_dp_dpcd_read_data(&port->aux,
+					  DP_DSC_SUPPORT, &endpoint_dsc, 1) < 0)
 			return NULL;
-		if (drm_dp_dpcd_read(&port->aux,
-				     DP_FEC_CAPABILITY, &endpoint_fec, 1) != 1)
+		if (drm_dp_dpcd_read_data(&port->aux,
+					  DP_FEC_CAPABILITY, &endpoint_fec, 1) < 0)
 			return NULL;
-		if (drm_dp_dpcd_read(&immediate_upstream_port->aux,
-				     DP_DSC_SUPPORT, &upstream_dsc, 1) != 1)
+		if (drm_dp_dpcd_read_data(&immediate_upstream_port->aux,
+					  DP_DSC_SUPPORT, &upstream_dsc, 1) < 0)
 			return NULL;
 
 		/* Enpoint decompression with DP-to-DP peer device */
@@ -6157,8 +6154,8 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
 	if (drm_dp_has_quirk(&desc, DP_DPCD_QUIRK_DSC_WITHOUT_VIRTUAL_DPCD)) {
 		u8 dpcd_ext[DP_RECEIVER_CAP_SIZE];
 
-		if (drm_dp_dpcd_read(immediate_upstream_aux,
-				     DP_DSC_SUPPORT, &upstream_dsc, 1) != 1)
+		if (drm_dp_dpcd_read_data(immediate_upstream_aux,
+					  DP_DSC_SUPPORT, &upstream_dsc, 1) < 0)
 			return NULL;
 
 		if (!(upstream_dsc & DP_DSC_DECOMPRESSION_IS_SUPPORTED))
@@ -6180,11 +6177,11 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
 	 * therefore the endpoint needs to be
 	 * both DSC and FEC capable.
 	 */
-	if (drm_dp_dpcd_read(&port->aux,
-	   DP_DSC_SUPPORT, &endpoint_dsc, 1) != 1)
+	if (drm_dp_dpcd_read_data(&port->aux,
+				  DP_DSC_SUPPORT, &endpoint_dsc, 1) < 0)
 		return NULL;
-	if (drm_dp_dpcd_read(&port->aux,
-	   DP_FEC_CAPABILITY, &endpoint_fec, 1) != 1)
+	if (drm_dp_dpcd_read_data(&port->aux,
+				  DP_FEC_CAPABILITY, &endpoint_fec, 1) < 0)
 		return NULL;
 	if ((endpoint_dsc & DP_DSC_DECOMPRESSION_IS_SUPPORTED) &&
 	   (endpoint_fec & DP_FEC_CAPABLE))

-- 
2.39.5

