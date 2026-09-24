Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F694C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 11:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762A110E0EC;
	Thu, 24 Sep 2026 11:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="s0+0tFPs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EF710E0EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=Dj6tfQ25VjGqniB5K4KDR+GXd/KaPDlHKwBfJBGLqWk=; b=s0+0tFPs+Y2W0S9OzugIAVAJrc
 mF1NbnamJW50GWV/jgIZ8gsXDBVln+ynt2yJYFUMB9uokc/Fe0i02jQs7LIJluz6foaNM+k8MjHQU
 V9JggBJ6fupYHlPloLM/o9MMu5PftkgRK2hsPBjBPM/GbJUZJ2aaVW4JdkLQGXo2DPFZk53calP6X
 R86uaQZ8Q1oycTHa1AaLb08dszvMWEOYVjn+/U9L8KWFX3+SikH54HBUKHMNbdRZADHKpVR40dzdM
 vHgA6mZ3D+QzHSElKT1UBHU9c61hRKAxlZTvC+csuPdKlZJ6v+xDUrbw2+CVCe++DLqWIjuz+DU4I
 zKtrsnUg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9hoq-006ctg-BE; Thu, 24 Sep 2026 13:40:52 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/2] amdgpu display debugfs handling fix and refactor
Date: Thu, 24 Sep 2026 12:40:47 +0100
Message-ID: <20260924114049.55201-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I had some patches in this area ages ago so I re-visited them, tweaked and
decided to re-post.

First is a clear fix while second is a serious refactor which needs a lot of
scrutiny. Mostly closing in on the desired semantics and thinking whether
changing any of the existing (incosistent) semantics is likely to break any
(hypothetical) scripts used for debugfs configuration. In it probably desirable
in principle since it removes a lot of redundant and somewhat questionable code.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>

Tvrtko Ursulin (2):
  drm/amd/display: Use memdup_user_nul in debugfs code
  drm/amd/display: Simplify debugfs token parsing

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 600 ++++--------------
 1 file changed, 130 insertions(+), 470 deletions(-)

-- 
2.55.0

