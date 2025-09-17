Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38841CAC599
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9ABB10E858;
	Wed, 17 Sep 2025 14:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g6jRBJUX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161EC10E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nB4Cl0uujT4EadNcgfdSxwD2nUgV+nZYS7GX5TuhNMk=; b=g6jRBJUXUcHRDNp1ebEHhHo25H
 xELqMEmiIodRbWldQz3eOkZna4BBy5fH8gn7nGrTKcD95P68l+cMZAq7pc8e+sJjcQXeZvptRx2hS
 rAbUzobbk79Y/yyGZeXYP2Vn3dQNmsPC2jOO9FdS1xeQjt1ccwgbCairva9UrjfOqSutwhLuL42VJ
 9pGdVx0Uc0X78Qn73/EsAWX3OhcQdrtfaxUrI0ReuBgzuCD0MVMv8nzMz0kBhjb2nSvzy7yfWlWOv
 vzEpJeJ1U4QGxJ8Xclbg3c7Bq/GLTb5MD/l8tZFOqx75nwWuxZiiCHLrl/oLX5XojR/pxPn42P8QX
 AUy6i/JQ==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uytYe-00Ckdu-C7; Wed, 17 Sep 2025 16:54:56 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 0/6] Some debugfs/sysfs handling cleanups and consolidations
Date: Wed, 17 Sep 2025 15:54:43 +0100
Message-ID: <20250917145450.3000-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
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

Recently I ended up experimenting with some sysfs PM controls and while trying
to figure out how to use them stumbled upon some code duplication in sysfs and
debugfs handling.

There seems to be a number of places which parse input strings into arrays of
longs and those places look a lot like copy&paste. There is also some redundancy
in how strsep is used, ie. code that could be simplified and made more clear.

So I went to eliminate and consolidate, plus some other minor cleanups.

Sending as RFC because I am not the best equipped to verify I introduced no
regressions and also because the common parsing helper I put in amdgpu.h. Which
is quite bad, but I did not figure out (yet) what is the "official" way of
sharing common helpers between PM, display and amdgpu.ko itself.

Therefore if someone has a suggestion on where to place it, or general feedback
telling me if this whole cleanup is something AMD wants to entertain or not.

There could be some further cleanups as well, for example a lot of the places
are quite over the top with stack usage, and with not very obvious reasons why
they happen to be safe against overflows.

Tvrtko Ursulin (6):
  drm/amd/pm: Remove unnecessary local variable initialization
  drm/amd/display: Use memdup_user
  drm/amd/display: Align data types in debugfs code
  drm/amd/display: Simplify debugfs token parsing
  drm/amd: Move display debugfs array of longs parsing into common
  drm/amd/pm: Use common helper for parsing sysfs writes

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  36 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 421 +++++++-----------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 296 +++++-------
 3 files changed, 306 insertions(+), 447 deletions(-)

-- 
2.48.0

