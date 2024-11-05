Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D01D29FB8
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 08:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB84310E686;
	Wed,  6 Nov 2024 08:24:51 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F1010E187;
 Tue,  5 Nov 2024 14:12:41 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XjVfS4Zn5z1ypGd;
 Tue,  5 Nov 2024 22:12:48 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
 by mail.maildlp.com (Postfix) with ESMTPS id ABACB1A0188;
 Tue,  5 Nov 2024 22:12:38 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 5 Nov
 2024 22:12:37 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <Dillon.Varone@amd.com>, <Alvin.Lee2@amd.com>,
 <nicholas.kazlauskas@amd.com>, <alex.hung@amd.com>,
 <aurabindo.pillai@amd.com>, <relja.vojvodic@amd.com>,
 <chiahsuan.chung@amd.com>, <wenjing.liu@amd.com>, <george.shen@amd.com>,
 <mwen@igalia.com>, <yi-lchen@amd.com>, <martin.leung@amd.com>,
 <srinivasan.shanmugam@amd.com>, <stylon.wang@amd.com>, <jun.lei@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
 <judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH 0/2] drm/amd/display: Fix Null Pointer Dereference Issues
Date: Tue, 5 Nov 2024 14:01:35 +0000
Message-ID: <20241105140137.2465572-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.175.84]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200012.china.huawei.com (7.221.188.145)
X-Mailman-Approved-At: Wed, 06 Nov 2024 08:24:50 +0000
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

Hi all,

I am submitting two patches to fix null pointer dereference issues in
the AMD display driver.

1. Patch 1/2 (Fixes: 8e4ed3cf1642): Add null checks in
dcn20_program_pipe() to prevent potential crashes when accessing
plane_state.

2. Patch 2/2 (Fixes: 0baae6246307): Ensures pipe_ctx->plane_state is
checked in hwss_setup_dpp() to improve function stability.

Thanks for reviewing!

Zicheng Qu (2):
  drm/amd/display: Fix null check for pipe_ctx->plane_state in
    dcn20_program_pipe
  drm/amd/display: Fix null check for pipe_ctx->plane_state in
    hwss_setup_dpp

 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c   | 3 +++
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1

