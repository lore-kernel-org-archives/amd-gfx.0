Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94458C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 07:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAB710E892;
	Wed, 21 Aug 2024 07:16:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9288810E587;
 Wed, 21 Aug 2024 06:33:28 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wpc322wRPzyR9t;
 Wed, 21 Aug 2024 14:33:02 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
 by mail.maildlp.com (Postfix) with ESMTPS id D0D4E1401E0;
 Wed, 21 Aug 2024 14:33:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 14:33:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chaitanya.dhere@amd.com>, <jun.lei@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <alex.hung@amd.com>, <aurabindo.pillai@amd.com>, <colin.i.king@gmail.com>,
 <dillon.varone@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/5] drm/amd/display: Make some symobols static
Date: Wed, 21 Aug 2024 14:40:35 +0800
Message-ID: <20240821064040.2292969-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Make some symobols static.

Jinjie Ruan (5):
  drm/amd/display: Make core_dcn4_g6_temp_read_blackout_table static
  drm/amd/display: Make core_dcn4_ip_caps_base static
  drm/amd/display: Make dcn35_hubp_funcs static
  drm/amd/display: Make dcn401_dsc_funcs static
  drm/amd/display: Make dcn35_fpga_funcs static

 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 2 +-
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c   | 2 +-
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c         | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.34.1

