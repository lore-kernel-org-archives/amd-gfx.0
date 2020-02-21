Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66863C35657
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BBE208E4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BBE208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38F46F488;
	Fri, 21 Feb 2020 15:33:56 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 965A26E2B2;
 Fri, 21 Feb 2020 13:24:49 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id EBBF3C503326C0296B72;
 Fri, 21 Feb 2020 21:24:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Feb 2020
 21:24:38 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <tony.cheng@amd.com>, <Rodrigo.Siqueira@amd.com>, <Eric.Yang2@amd.com>,
 <yongqiang.sun@amd.com>, <joseph.gravenor@amd.com>, <jaehyun.chung@amd.com>,
 <yuehaibing@huawei.com>, <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH -next] drm/amd/display: remove set but not used variable
 'mc_vm_apt_default'
Date: Fri, 21 Feb 2020 21:24:33 +0800
Message-ID: <20200221132433.16532-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 21 Feb 2020 15:33:55 +0000
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c:
 In function hubp21_set_vm_system_aperture_settings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c:343:23:
 warning: variable mc_vm_apt_default set but not used [-Wunused-but-set-variable]

It is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index aa7b0e7..d285ba6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -340,13 +340,9 @@ void hubp21_set_vm_system_aperture_settings(struct hubp *hubp,
 {
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
 
-	PHYSICAL_ADDRESS_LOC mc_vm_apt_default;
 	PHYSICAL_ADDRESS_LOC mc_vm_apt_low;
 	PHYSICAL_ADDRESS_LOC mc_vm_apt_high;
 
-	// The format of default addr is 48:12 of the 48 bit addr
-	mc_vm_apt_default.quad_part = apt->sys_default.quad_part >> 12;
-
 	// The format of high/low are 48:18 of the 48 bit addr
 	mc_vm_apt_low.quad_part = apt->sys_low.quad_part >> 18;
 	mc_vm_apt_high.quad_part = apt->sys_high.quad_part >> 18;
-- 
2.7.4


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
