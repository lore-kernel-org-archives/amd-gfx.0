Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F124C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 13:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E132110E612;
	Thu, 29 Sep 2022 13:06:17 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5880610E548;
 Thu, 29 Sep 2022 08:45:58 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MdRfn4t9qz1P6t3;
 Thu, 29 Sep 2022 16:41:37 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 16:45:54 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 16:45:54 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH -next] drm/amd/display: change to
 enc314_stream_encoder_dp_blank static
Date: Thu, 29 Sep 2022 17:02:00 +0800
Message-ID: <20220929090200.2189669-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 29 Sep 2022 13:06:12 +0000
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
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enc314_stream_encoder_dp_blank is only used in dcn314_dio_stream_encoder.c now,
change it to static.

Fixes: c9c2ff53cc20 ("drm/amd/display: Add explicit FIFO disable for DP blank")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 .../gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index 0d2ffb692957..7e773bf7b895 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -262,7 +262,7 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
-void enc314_stream_encoder_dp_blank(
+static void enc314_stream_encoder_dp_blank(
 	struct dc_link *link,
 	struct stream_encoder *enc)
 {
-- 
2.25.1

