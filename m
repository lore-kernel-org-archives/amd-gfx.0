Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516D2C2D0C3
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313A5218AC
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313A5218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D31F6E260;
	Wed, 18 Dec 2019 08:19:44 +0000 (UTC)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44DC6E21F;
 Wed, 18 Dec 2019 04:06:53 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B4B02BBA8E82425B4BFD;
 Wed, 18 Dec 2019 11:50:56 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Dec 2019
 11:50:26 +0800
From: Pan Zhang <zhangpan26@huawei.com>
To: <zhangpan26@huawei.com>, <hushiyuan@huawei.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH 3/3] gpu: drm: dead code elimination
Date: Wed, 18 Dec 2019 11:50:08 +0800
Message-ID: <1576641008-14880-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 18 Dec 2019 08:19:43 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this set adds support for removal of gpu drm dead code.

patch3 is similar with patch 1:
`num` is a data of u8 type and ATOM_MAX_HW_I2C_READ == 255,

so there is a impossible condition '(num > 255) => (0-255 > 255)'.

Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
---
 drivers/gpu/drm/radeon/atombios_i2c.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_i2c.c b/drivers/gpu/drm/radeon/atombios_i2c.c
index a570ce4..ab4d210 100644
--- a/drivers/gpu/drm/radeon/atombios_i2c.c
+++ b/drivers/gpu/drm/radeon/atombios_i2c.c
@@ -68,11 +68,6 @@ static int radeon_process_i2c_ch(struct radeon_i2c_chan *chan,
 			memcpy(&out, &buf[1], num);
 		args.lpI2CDataOut = cpu_to_le16(out);
 	} else {
-		if (num > ATOM_MAX_HW_I2C_READ) {
-			DRM_ERROR("hw i2c: tried to read too many bytes (%d vs 255)\n", num);
-			r = -EINVAL;
-			goto done;
-		}
 		args.ucRegIndex = 0;
 		args.lpI2CDataOut = 0;
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
