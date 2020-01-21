Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5830FC2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381B4217F4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381B4217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2176ED92;
	Tue, 21 Jan 2020 16:08:26 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45166ED09;
 Tue, 21 Jan 2020 14:00:59 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E2C832175FCBBEF9725C;
 Tue, 21 Jan 2020 22:00:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 21 Jan 2020 22:00:36 +0800
From: Chen Zhou <chenzhou10@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH -next 00/14] drm/amdgpu: remove unnecessary conversion to bool
Date: Tue, 21 Jan 2020 21:55:26 +0800
Message-ID: <20200121135540.165798-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 21 Jan 2020 16:08:17 +0000
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
Cc: chenzhou10@huawei.com, Felix.Kuehling@amd.com, tao.zhou1@amd.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series remove unnecessary conversion to bool in dir 
drivers/gpu/drm/amd/amdgpu/, which is detected by coccicheck.

Chen Zhou (14):
  drm/amdgpu: remove unnecessary conversion to bool in mmhub_v1_0.c
  drm/amdgpu: remove unnecessary conversion to bool in vega10_ih.c
  drm/amdgpu: remove unnecessary conversion to bool in navi10_ih.c
  drm/amdgpu: remove unnecessary conversion to bool in gfx_v10_0.c
  drm/amdgpu: remove unnecessary conversion to bool in sdma_v5_0.c
  drm/amdgpu: remove unnecessary conversion to bool in athub_v1_0.c
  drm/amdgpu: remove unnecessary conversion to bool in amdgpu_acp.c
  drm/amdgpu: remove unnecessary conversion to bool in soc15.c
  drm/amdgpu: remove unnecessary conversion to bool in nv.c
  drm/amdgpu: remove unnecessary conversion to bool in mmhub_v9_4.c
  drm/amdgpu: remove unnecessary conversion to bool in amdgpu_device.c
  drm/amdgpu: remove unnecessary conversion to bool in athub_v2_0.c
  drm/amdgpu: remove unnecessary conversion to bool in sdma_v4_0.c
  drm/amdgpu: remove unnecessary conversion to bool in gfx_v9_0.c

 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++-----
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  6 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 28 ++++++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  2 +-
 15 files changed, 43 insertions(+), 45 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
