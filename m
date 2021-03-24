Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C87C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 13:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E9861992
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 13:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E9861992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE286E9F9;
	Wed, 24 Mar 2021 13:05:14 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035436E993;
 Wed, 24 Mar 2021 09:17:14 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F52cb6gM8zPlk3;
 Wed, 24 Mar 2021 17:14:39 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 17:17:07 +0800
From: Tian Tao <tiantao6@hisilicon.com>
To: <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH drm/amdgpu 0/2] Convert sysfs sprintf/snprintf family to
 sysfs_emit 
Date: Wed, 24 Mar 2021 17:17:39 +0800
Message-ID: <1616577461-18556-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 24 Mar 2021 13:05:10 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the generic sysfs_emit() function to take place of
snprintf/scnprintf, to avoid buffer overrun.

Tian Tao (2):
  drm/amdgpu: Convert sysfs sprintf/snprintf family to sysfs_emit
  drm/amd/pm: Convert sysfs sprintf/snprintf family to sysfs_emit

 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 32 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c         |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c           | 88 ++++++++++++++--------------
 9 files changed, 73 insertions(+), 79 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
