Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE3C2D0D0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61711206CB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61711206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B00E6E34E;
	Tue, 24 Dec 2019 18:09:11 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C3CA6E055;
 Tue, 24 Dec 2019 03:20:33 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 494DA5F125A5BD238AFF;
 Tue, 24 Dec 2019 11:20:31 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 11:20:22 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 0/8] drm/amd/display: use true,false for bool variable
Date: Tue, 24 Dec 2019 11:27:35 +0800
Message-ID: <1577158063-76188-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 24 Dec 2019 18:09:10 +0000
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
Cc: zhengbin13@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

zhengbin (8):
  drm/amd/display: use true,false for bool variable in dc_link_ddc.c
  drm/amd/display: use true,false for bool variable in
    dcn10_hw_sequencer.c
  drm/amd/display: use true,false for bool variable in dcn20_hwseq.c
  drm/amd/display: use true,false for bool variable in
    display_mode_vba_21.c
  drm/amd/display: use true,false for bool variable in dce_calcs.c
  drm/amd/display: use true,false for bool variable in
    display_rq_dlg_calc_20.c
  drm/amd/display: use true,false for bool variable in
    display_rq_dlg_calc_20v2.c
  drm/amd/display: use true,false for bool variable in
    display_rq_dlg_calc_21.c

 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   | 24 +++++++++++-----------
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  4 ++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  4 ++--
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  | 24 +++++++++++-----------
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        | 24 +++++++++++-----------
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |  6 +++---
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  | 24 +++++++++++-----------
 8 files changed, 56 insertions(+), 56 deletions(-)

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
