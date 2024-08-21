Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D83C54730
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 07:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811A610E89D;
	Wed, 21 Aug 2024 07:16:24 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD1610E58F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 06:50:07 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wpc3S1MNTz1S8Dh;
 Wed, 21 Aug 2024 14:33:24 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
 by mail.maildlp.com (Postfix) with ESMTPS id D0ECB1A016C;
 Wed, 21 Aug 2024 14:33:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 14:33:26 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chaitanya.dhere@amd.com>, <jun.lei@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <alex.hung@amd.com>, <aurabindo.pillai@amd.com>, <colin.i.king@gmail.com>,
 <dillon.varone@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 3/5] drm/amd/display: Make dcn35_hubp_funcs static
Date: Wed, 21 Aug 2024 14:40:38 +0800
Message-ID: <20240821064040.2292969-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821064040.2292969-1-ruanjinjie@huawei.com>
References: <20240821064040.2292969-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)
X-Mailman-Approved-At: Wed, 21 Aug 2024 07:16:18 +0000
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

The sparse tool complains as follows:

drivers/gpu/drm/amd/amdgpu/../display/dc/hubp/dcn35/dcn35_hubp.c:191:19: warning:
	symbol 'dcn35_hubp_funcs' was not declared. Should it be static?

This symbol is not used outside of dcn35_hubp.c, so marks it static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index 771fcd0d3b99..d1f05b82b3dd 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -188,7 +188,7 @@ void hubp35_program_surface_config(
 	hubp35_program_pixel_format(hubp, format);
 }
 
-struct hubp_funcs dcn35_hubp_funcs = {
+static struct hubp_funcs dcn35_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
 	.hubp_program_surface_flip_and_addr = hubp3_program_surface_flip_and_addr,
-- 
2.34.1

