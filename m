Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C8CC6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 08:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D916710E58C;
	Mon, 19 Sep 2022 08:06:54 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A856210E429;
 Mon, 19 Sep 2022 01:37:56 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MW6dp2gbCzlVxB;
 Mon, 19 Sep 2022 09:33:50 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 19 Sep
 2022 09:37:53 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <Pavle.Kotarac@amd.com>, <HaoPing.Liu@amd.com>,
 <Krunoslav.Kovac@amd.com>, <Yao.Wang1@amd.com>
Subject: [PATCH] gpu: color: eliminate implicit conversion about enum type
Date: Mon, 19 Sep 2022 09:44:57 +0800
Message-ID: <20220919014457.3297857-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 19 Sep 2022 08:06:05 +0000
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
Cc: zengheng4@huawei.com, weiyongjun1@huawei.com, liwei391@huawei.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below compile warning when open enum-conversion
option check:

drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:
In function ‘apply_degamma_for_user_regamma’:
drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:1695:29:
error: implicit conversion from ‘enum <anonymous>’ to ‘enum dc_transfer_func_predefined’ [-Werror=enum-conversion]
 1695 |  build_coefficients(&coeff, true);
      |                             ^~~~

As 'build_coefficients' definition, it needs enum
'dc_transfer_func_predefined' type acts as the
second argument, instead of bool-type one.

The numerical values of TRANSFER_FUNCTION_BT709 & true
happen to be the same, so there is no change in
behavior.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 04f7656906ca..2f807d787c77 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1692,7 +1692,7 @@ static void apply_degamma_for_user_regamma(struct pwl_float_data_ex *rgb_regamma
 	struct pwl_float_data_ex *rgb = rgb_regamma;
 	const struct hw_x_point *coord_x = coordinates_x;
 
-	build_coefficients(&coeff, true);
+	build_coefficients(&coeff, TRANSFER_FUNCTION_BT709);
 
 	i = 0;
 	while (i != hw_points_num + 1) {
-- 
2.25.1

