Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E437C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 15:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDC32072B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 15:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDC32072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C346EC55;
	Fri, 20 Dec 2019 15:10:42 +0000 (UTC)
X-Greylist: delayed 906 seconds by postgrey-1.36 at gabe;
 Fri, 20 Dec 2019 02:10:44 UTC
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25ED16EBB9;
 Fri, 20 Dec 2019 02:10:43 +0000 (UTC)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0C1F689C28CBC3381A9E;
 Fri, 20 Dec 2019 09:55:35 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Dec 2019
 09:55:25 +0800
From: chenmaodong <chenmaodong@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH ] drm/radeon: Fix potential buffer overflow in
 ci_set_mc_special_registers()
Date: Fri, 20 Dec 2019 09:55:05 +0800
Message-ID: <1576806905-4590-1-git-send-email-chenmaodong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 20 Dec 2019 15:10:36 +0000
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
Cc: chenmaodong@huawei.com, hushiyuan@huawei.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 zhangpan26@huawei.com, wuxu.wu@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

The length of table->mc_reg_address is SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE.

In ci_set_mc_special_registers(), the boundary checking

here("if (j > SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)") allows 'j' equal to

SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE which can easily cause the 

table->mc_reg_address to read out of bounds. 

To solve this problem, we change ">" to ">=" and check this boundary 

of table->mc_reg_address after "pi->mem_gddr5" is false.

Signed-off-by: chenmaodong <chenmaodong@huawei.com>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index a97294a..42ef745a 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -4364,10 +4364,10 @@ static int ci_set_mc_special_registers(struct radeon_device *rdev,
 					table->mc_reg_table_entry[k].mc_data[j] |= 0x100;
 			}
 			j++;
-			if (j > SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
-				return -EINVAL;
 
 			if (!pi->mem_gddr5) {
+				if (j >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
+					return -EINVAL;
 				table->mc_reg_address[j].s1 = MC_PMG_AUTO_CMD >> 2;
 				table->mc_reg_address[j].s0 = MC_PMG_AUTO_CMD >> 2;
 				for (k = 0; k < table->num_entries; k++) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
