Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE09C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 14:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1ECE10ED1F;
	Fri, 30 Sep 2022 14:19:00 +0000 (UTC)
X-Greylist: delayed 1023 seconds by postgrey-1.36 at gabe;
 Fri, 30 Sep 2022 06:55:37 UTC
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19DD910EB9A;
 Fri, 30 Sep 2022 06:55:37 +0000 (UTC)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mf0nJ4BDyz1P6yT;
 Fri, 30 Sep 2022 14:34:12 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 14:38:29 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <airlied@gmail.com>, <daniel@ffwll.ch>
Subject: [PATCH -next] drm/amd/display: Removed unused variable
 'sdp_stream_enable'
Date: Fri, 30 Sep 2022 14:38:27 +0800
Message-ID: <20220930063827.1835856-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 30 Sep 2022 14:18:56 +0000
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
Cc: kernel test robot <lkp@intel.com>, sunpeng.li@amd.com,
 yuehaibing@huawei.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jerry.Zuo@amd.com,
 dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 Dong Chenchen <dongchenchen2@huawei.com>, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Kernel test robot throws below warning ->

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c:
In function 'dcn31_hpo_dp_stream_enc_update_dp_info_packets':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c:439:14:
warning: variable 'sdp_stream_enable' set but not used
[-Wunused-but-set-variable]
   439 |         bool sdp_stream_enable = false;

Removed unused variable 'sdp_stream_enable'.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c       | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 23621ff08c90..7daafbab98da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -436,32 +436,28 @@ static void dcn31_hpo_dp_stream_enc_update_dp_info_packets(
 {
 	struct dcn31_hpo_dp_stream_encoder *enc3 = DCN3_1_HPO_DP_STREAM_ENC_FROM_HPO_STREAM_ENC(enc);
 	uint32_t dmdata_packet_enabled = 0;
-	bool sdp_stream_enable = false;
 
-	if (info_frame->vsc.valid) {
+	if (info_frame->vsc.valid)
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				0,  /* packetIndex */
 				&info_frame->vsc,
 				true);
-		sdp_stream_enable = true;
-	}
-	if (info_frame->spd.valid) {
+
+	if (info_frame->spd.valid)
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				2,  /* packetIndex */
 				&info_frame->spd,
 				true);
-		sdp_stream_enable = true;
-	}
-	if (info_frame->hdrsmd.valid) {
+
+	if (info_frame->hdrsmd.valid)
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				3,  /* packetIndex */
 				&info_frame->hdrsmd,
 				true);
-		sdp_stream_enable = true;
-	}
+
 	/* enable/disable transmission of packet(s).
 	 * If enabled, packet transmission begins on the next frame
 	 */
-- 
2.25.1

