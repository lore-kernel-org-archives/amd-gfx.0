Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60642C0219B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 06:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C776710EA28;
	Fri,  7 Feb 2025 06:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fSyQ6qkT";
	dkim-atps=neutral
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 965F010EA27
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 06:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1738909736; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=bRwE2xb2Ev7VUPiYcag21bpsgQbhUmxWVgiXzXq8JM0=;
 b=fSyQ6qkTpHLiGyGuhfJMbuW/OJJG/5K+ckwYOJnXuAs/ior2GUEhwfozkwv+INYwT7j/fDGvr3oD1pUnMUYIKTzJXzNO6GVWpqRTtbtsCsfpSCGbNOv6LTel1cMqJ8B8lPw0zQnkUtrZiB56sB8jcW4AUX0OyvBp+pfUOgJtIXs=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WOyT2o._1738909734 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 07 Feb 2025 14:28:55 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v1 0/4] Bugfixes and minor improvements to drm/amdgpu/psp
Date: Fri,  7 Feb 2025 14:28:48 +0800
Message-ID: <cover.1738909308.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fix some bugs in error handling path in psp subsystem:
1) fix possible bugs in error handling path in psp_sw_init()
2) fix a bug in error handling path in psp_init_cap_microcode()
3) reduce duplicated code related to psp_ta_init_shared_buf()

Jiang Liu (4):
  drm/amdgpu: reset psp->cmd to NULL after releasing the buffer
  drm/amdgpu: enhance error handling of psp_sw_init()
  drm/amdgpu: bail out when failed to load fw in
    psp_init_cap_microcode()
  drm/amdgpu: simplify invoke of psp_ta_init_shared_buf()

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 147 +++++++++++++-----------
 1 file changed, 81 insertions(+), 66 deletions(-)

-- 
2.43.5

