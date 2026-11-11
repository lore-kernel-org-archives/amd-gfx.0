Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E2606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hvwrJspI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DoExChX9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9495310F880;
	Wed, 11 Nov 2026 00:43:47 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C3F10F863
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:26 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAMKpZg3592331
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IqrKT0cA3nLDIjgKp7KtkPxQyzK/HBBzs1wgJJzWDiQ=; b=hvwrJspIEHTugiEx
 IOFiIc5IM9EZ1hAf88dfpNx/HTDPm9kiBCa1bT8f633Yp1Jxsezg2xlKYxXKdnGN
 nAfHduuNtmPButDXy/GsOpu16W3Al7oT70ccsi9rlCEOr4v4yeNoIJa9E8UwPTDY
 LI6nJo3+MOHnh9xEI6wVhnOH0IaczrVnywc17Lc6Xo+mdsp76tCtx/l8cC+UtXX8
 mYohnWP3SPyj8h2gOfIwg0VRQHF26zTiaRbLlOANV2Dg5xRv2XYWU50bUH2svnKO
 RXEngv6FLfBkmwVseYfso3CiWsdiVS3fNScXx9y8c9hBFt9Pe0yIKYdX2X6sZHzD
 Ao9yPg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5hqg1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 00:43:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844cb60so550848185a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794357805; x=1794962605;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IqrKT0cA3nLDIjgKp7KtkPxQyzK/HBBzs1wgJJzWDiQ=;
 b=DoExChX9gumZ+IOcwI8EXGV0SC0Qi0ZPTZL0e2srWQ2Wnk4UZ0GGk7pyTbgVvY7T2O
 80NoMfsw1GEL5tRZoLofZil1aIoUg7WcVLo/4odbwKaHBTyHCATzpcJU4EkBcirprHp+
 k+9T/8uZ8eHxpQ8+2sAVaGrEPQjleHSwbQYoDzjQ23LJERLPJKT36/fkYffW6gQ/s4Yh
 mk1iA2b61U70gzgaGSnAmudpf5cbm6gnOL15QkMzObeq7z4er4CIeehaQKlzXs/qf9zp
 eD8x/OkzuC2xA7wNAEvc+lY3rrmTIy0vxzwPT/nb9ZCLsvEt5mJQYuzP7Oitzz8twfUQ
 mOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794357805; x=1794962605;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IqrKT0cA3nLDIjgKp7KtkPxQyzK/HBBzs1wgJJzWDiQ=;
 b=KBSRgNtNeYJwhbpTpuPtdY/j8a2Y/TeaoCPSeH9kWVaRfnXVbzJD1LwimhcvUpnk6e
 SHYNRf/T7QVtTGU0LB5UH1af4MAxMGc0zYLm7xX49NO4bizFoquCfob6XO8tFUB66z01
 /2GoR5Pl7Nj6y/WpU5RLOrMcnwA6nULk28CTL+Ut2GC4+nIJIvbbwb2tUhhJoZ/AHxpe
 rlG0Vd8SbgLIsAbHICWXPK6ei6Ll7sH6m2EFsHypH1pZ6srvyrSmQ7xBrUllAfpj1C6o
 1Mmpw2720YvT83NIG4aJih09Oo1ovmoIo+cjElMypmTsLvFYpWmC1C8/eyF5aST+nYNf
 fTrA==
X-Forwarded-Encrypted: i=1;
 AL+hErFnxty2IdD70K0HpEqM4IYAGdDYN7/uooufguIJA2NdS7jdETu+6KZKH/AK0mWlHR56VfyJ4Mjd@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8UGuJqep97VnYWAfnbwT8XZyW7YSSsiX+N0CfxAvl/5w1eIutE
 UxjmUeiTljyeniPG9dXjC2MPBlp0pVQPGgYWaZDo9zxtr5yWK6vhgik2AqYPeEJ8u4a3sL3VkX5
 OV2pudUm2Oy6FamEElcREcOoCI+yQybE91lEaC8oa8FJPGheHnMNQyp7mKkmf1pXg+Pm4
X-Gm-Gg: AYBFou24PI7baM7ZHo8dfQEQA9au2uKPtMs6mzKK9AF6DQRAytVkNYpjJNCOWuBltBa
 gA/ExjbrwCqFis/gWGR4BWR1grCz0mAXBiGHDfXZ884IN3U5gsc7mnPdZvBktGzgsCVgfZ82k2U
 tFK0pbTezFJRvdk4L0XyzPJM3MpKPcDImKb0ca1bTx5OQt2NTjax2QF7nICiaokaISwvmQMCgu+
 mOA76As17wHVz8/piIOYGy+m5pfUJ3RObrkCp6YCsbae/nPoUW9nXBbKbGbMCbSqatGHL6m15zc
 rvNQ4yI/DZTKob6rP/ZS0yVEtpYGAMimTK9vTkOKxhiUBMHhd6M4MvkX+WISKnTZtXmaR4oPga1
 vb8HrzQdvKEhCzS7xCM4UcanQCo/qrmt0U808+DY8jpJbnd7KU/H1KxVgBlxEAZdrY+2GIhW5Wr
 dzE7oUzbZcs9c/02FIXCXYIc7782uDch+HM/h+MIEnxPjdR0WUv0VffgTu25d6Pg==
X-Received: by 2002:a05:620a:6c19:b0:943:7e61:fd9f with SMTP id
 af79cd13be357-947ae71ebf9mr202912485a.1.1794357804747; 
 Tue, 10 Nov 2026 16:43:24 -0800 (PST)
X-Received: by 2002:a05:620a:6c19:b0:943:7e61:fd9f with SMTP id
 af79cd13be357-947ae71ebf9mr202908485a.1.1794357804205; 
 Tue, 10 Nov 2026 16:43:24 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092896d8sm7499011fa.32.2026.11.10.16.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:43:23 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:42:37 +0200
Subject: [PATCH v8 08/10] drm: writeback: clean up writeback jobs outside
 the job_lock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-wb-drop-encoder-v8-8-62948ed87d13@oss.qualcomm.com>
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
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6lI15A13l9Pj2MhuBcjzRiQ6NpV3/1ulOmfHPu2OyVQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq87oSIbjxQ/q7RrVd2MdTNVg0HuzllSpgWim2B
 aZWVwGStq2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavO6EgAKCRCLPIo+Aiko
 1ddnB/44pQGZq4MXj/3mf9607WzgcNauTKE2H07IKpYHZawQRixcf9lDGxnbcHjUxmBBs+TX42E
 rqXYXuzrynwYs6NMvOOxo3eZmYe4Fb7cFDyIjb7YoT6h9Rhb3T2s3pL7O+HzEBUPLSAjfvQ38Vv
 9MoJ6vDGDkIWI09pjGY30Vu0HguWoVduaJ7Q//RneKQBF1BpmsU0enxhZIMoB1GyOQXy4wDmebO
 7BQJdPJc5AIiPECtyetj8sok9eXrnw/z1C4LuZJZI1QIJYr8YvOYb/6lXSNolXuV1N1w5I3KOkI
 Phr3Y1GDLdliZ7ZUNKjYEkGvOqvEzEX1BNIz4lOcXNL2Ktxy
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX3AIFWemnVT90
 8HPAy8VFQEae2MUHkHr7TtviR/4FEJmffa0/CpVzgk93K46If2lI2xdkSQRpetMfXKTjDh+oy5R
 tUlPaM7UpR0nkVKGpVuqYG4EeXF0o+VUvb5bLV56kN1TLyne4Ar/7ja0wp5chnCFe9ZHk9096vH
 6qpLxfSUqX/rPvYgejRpNWNjnv5xhUWp/OyiYF2Gcg4IJCOLbqRtmoefBWvv/dVbKJR4q03bDyN
 7YxUY0iF/T9B7cjxRTd2a+uszrEJXgjImo3f/1vJiP5dch+vBYtoBO8J2jZmlCiM5dMHKW+UMX4
 XloIudS9FeViH+Jzrop6E4RJH7/I62P14dIH9diU9D1yGkk+aMXEGzu5oJ4sMfdyDABO8gAiS3e
 2K1DgP4gv/amTiRMUW4t5kZefmxMn48TLSb8bhaidm4Uk72DKMctCnk8TrwyzcKCRxb2jZ8IEkX
 QJquRp6g/qrH5ZLacLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAwMSBTYWx0ZWRfX5CKII9sDDFDY
 BPMfHo7GgkNbqVQxpcXP5UaCDCpn5bVhzntpqZQr7q+533FEDLND+OcX1Jt/D7znn1zidMaBAy5
 PJ3ltuBHW4oXB03HkJzk8M2QvaQp5d0=
X-Proofpoint-ORIG-GUID: O692AuWJqDjTwLplRKl2AJAh99P7W-jy
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af3ba2d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ByKfqPmZO4XEhVLTLvsA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: O692AuWJqDjTwLplRKl2AJAh99P7W-jy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110001
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

drm_writeback_connector_cleanup() frees the jobs left on the queue while
holding job_lock with interrupts disabled. drm_writeback_cleanup_job()
may sleep, though: dropping the last framebuffer reference takes
mode_config.idr_mutex and other mutexes, and a driver's
cleanup_writeback_job() hook (e.g. amdgpu) grabs a dma_resv ww_mutex.

Splice the queue onto a local list under the lock and free the jobs after
dropping it, so the sleeping work runs in process context.

Fixes: 1914ba2b91ea ("drm: writeback: Create drmm variants for drm_writeback_connector initialization")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 2f6a7b50336c..6487f4a104f2 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -281,18 +281,21 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
 static void drm_writeback_connector_cleanup(struct drm_device *dev,
 					    void *data)
 {
-	unsigned long flags;
-	struct drm_writeback_job *pos, *n;
 	struct drm_writeback_connector *wb_connector = data;
+	struct drm_writeback_job *pos, *n;
+	unsigned long flags;
+	LIST_HEAD(jobs);
 
 	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
 
 	spin_lock_irqsave(&wb_connector->job_lock, flags);
-	list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry) {
+	list_splice_init(&wb_connector->job_queue, &jobs);
+	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
+
+	list_for_each_entry_safe(pos, n, &jobs, list_entry) {
 		list_del(&pos->list_entry);
 		drm_writeback_cleanup_job(pos);
 	}
-	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
 }
 
 /**

-- 
2.47.3

