Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4802C02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 06:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F2610EA2E;
	Fri,  7 Feb 2025 06:49:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Axuczs29";
	dkim-atps=neutral
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E63910EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 06:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1738910660; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=dqs0IiLbo81Z41jcnB37Q8hZo6bO1Fp2XUWzCUpP3ys=;
 b=Axuczs29DoB/+gC5K9uo6u9H9nbWY8YM+JKm5sfiUhHxSMJEv1A5OMPXAp6ur9ETbaCTVW2tuX2pLn675gDTSh1dGOZAry/FRdUWrTnS7jZUZ0GreykeLTAmN1lHjHR62qM+/7SFWysQk1WsX1yEqryRxMm+miFe9fEIK9sg6LM=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WOyQdyL_1738910658 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 07 Feb 2025 14:44:19 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v1 0/4] Fix a buffer overflow in drm/amdgpu/smu
Date: Fri,  7 Feb 2025 14:44:13 +0800
Message-ID: <cover.1738910203.git.gerry@linux.alibaba.com>
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

Fix several bugs in smu subsystem:
1) a buffer overflow bug in function smu_sys_set_pp_table()
2) tune logic of is_vcn_enabled()
3) enhance handling of gfx_off_entrycount in function smu_suspend()

Jiang Liu (4):
  drm/amdgpu: avoid buffer overflow attach in smu_sys_set_pp_table()
  drm/amdgpu: accumulate gfx_off_entrycount in smu_suspend()
  drm/amdgpu: treat VCN as enabled if either VCN or JPEC is enabled
  drm/amdgpu: minor code style enhancement for smu

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 17 +++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.43.5

