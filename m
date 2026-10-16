Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D326ECCA462
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 08:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6812411266E;
	Fri, 16 Oct 2026 08:27:59 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3732112682
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 08:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=9py5ggYWKl0k2/gAfg7ZSv+gD1yNZtxMJcE8HCQqDVc=; b=VIUJOhXsPx076X+Js9QP8tvQ3g
 hKHLR4YqjgvenjDM0P9ciB/WwRJjWSQtux0mSqdxROi2mVS5ccQk+YkCN7HwXp12CqPHt88WWwQAn
 ew21mpV79APM2+8b/WQfib10AolDw/ztV0Bx/e6JSFFaQjUEgiKZbfEOiB8Pcc7lZQ8FlsPSBMzA0
 mRw8AmI/94eyvLANyPfuGCEUp5+rOUP6BavYk844jfqQ4Pdqooi3KV4B4wuSEg6pMpCKFna3bKQ+w
 jSdcZQlijdJOmlMpLFD/VAIAXNLu0lGabtsB5Dry8e+PGNCpKIf4K8pgfHjidKLBvjSKhpNVC96s/
 aUY2isPA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xHdI7-000wxt-QQ; Fri, 16 Oct 2026 10:27:51 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Hung <alex.hung@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH v4 0/2] amdgpu display debugfs handling fix and refactor
Date: Fri, 16 Oct 2026 09:27:44 +0100
Message-ID: <20261016082746.47749-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
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
Cc: Alex Hung <alex.hung@amd.com>

Tvrtko Ursulin (2):
  drm/amd/display: Use memdup_user_nul in debugfs code
  drm/amd/display: Simplify debugfs token parsing

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 595 ++++--------------
 1 file changed, 126 insertions(+), 469 deletions(-)

-- 
2.56.0

