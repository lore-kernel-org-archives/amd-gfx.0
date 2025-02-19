Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F60C021B2
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 18:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AABEA10E874;
	Wed, 19 Feb 2025 18:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UL0RVFUn";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE95310E4AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 18:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6r+svG78jzF9diT/8IAIF2P/yXmCgWfDm7zl/U5Du6M=; b=UL0RVFUnmLnPZOlRVdEqGxSfgu
 neyCfCC5o83udL4W/hHni5zcy8Pxl4CqWlXw5u3kokWoWRjx5N7H5McL+hG4Crt5WPys448z+VJTl
 44nryhDIcb3YrFVcJu6TioFoh0IqsXjjMpqBAtDOidpSzjI9lYT9dujME+G1lcmsDjRk2LdTkgZzX
 fFKSN+yvyuaH4Mo9l3awCCLc1kRasqaLcHDLxHGPVz43ojbNIBDHwCGuiy6nCquK8yOW00XodVpOT
 l7nEn9sp+5vwkPD2PGOrQv8TtV9omUZUHjONSg5eW919PVRy4Z5AG0tgTAB93oFNEQveNgO1nG93K
 GllISfvA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tkp6P-00EwF0-W5; Wed, 19 Feb 2025 19:47:28 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 2/2] mailmap: Add entry for Rodrigo Siqueira
Date: Wed, 19 Feb 2025 11:46:20 -0700
Message-ID: <20250219184702.242924-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219184702.242924-1-siqueira@igalia.com>
References: <20250219184702.242924-1-siqueira@igalia.com>
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

Map all of my previously used email addresses to my @igalia.com address.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 5e829da09e7f..64413bbc286c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -583,6 +583,8 @@ Richard Leitner <richard.leitner@linux.dev> <me@g0hl1n.net>
 Richard Leitner <richard.leitner@linux.dev> <richard.leitner@skidata.com>
 Robert Foss <rfoss@kernel.org> <robert.foss@linaro.org>
 Rocky Liao <quic_rjliao@quicinc.com> <rjliao@codeaurora.org>
+Rodrigo Siqueira <siqueira@igalia.com> <rodrigosiqueiramelo@gmail.com>
+Rodrigo Siqueira <siqueira@igalia.com> <Rodrigo.Siqueira@amd.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
 Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>
-- 
2.48.1

