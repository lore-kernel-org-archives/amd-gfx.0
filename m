Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E77CC98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 21:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804CB10E1F9;
	Thu, 24 Sep 2026 21:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oMeteJlj";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE5610E1F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 21:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=NtjY+4aX5C4glNstCxfiKZ3GHTCRx0sxpgWksTA34So=; b=
 oMeteJljK7faq8cq2k2mxxnXSjmTeKgdzO7IXvlVkSn0ERavLvEeDdfMNCBt8HPMwRXOoqy3FdKpp
 Bh4dO3mkU0XX217v5zq3Muv40bug6XUhsz2/9IVNgdY00AraN8FDV1rQ3Q1vbL5wkBHdUuD/eiy2C
 UU/8z8BHT5UKHGj0Bq4fI6cYHJD9bywcjhZCUuavBd9fj77fLEcCDB5QbBzZ86Ry22Bpk3MzWSmbT
 AOVhOnQ/b1w+dKKcAPh1jZZbqP3FM2qid5RlTvzrXbcGJf4s/AgFVfytL0+5eVdHQF6mUX/zWs43w
 6IWZQBkkas3PkIHajKR/9wPajJBBUCh4qg==;
Received: from 113.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.113]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9qlf-006qf4-Tu; Thu, 24 Sep 2026 23:14:11 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 Aurabindo.Pillai@amd.com, christian.koenig@amd.com, David.Francis@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] drm/amd/display: DM trace event cleanups
Date: Thu, 24 Sep 2026 23:10:03 +0200
Message-ID: <20260924211410.867686-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
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

Hey,

I was tracing some amdgpu_dm events and noticed small issues and found
areas for minor improvements. So this series is just a collection of
those small cleanups.

Melissa

Melissa Wen (8):
  drm/amd/display: assign missing trace entry in amdgpu_dm_dc_clocks_state
  drm/amd/display: remove duplicated prev_p_state_change_support assignment
  drm/amd/display: fix vready offset assignment in dcn_optc_lock_unlock_state
  drm/amd/display: declare amdgpu_dm_atomic_state_template as an event class
  drm/amd/display: use right type for amdgpu_dc_performance event entries
  drm/amd/display: remove redundant cast on amdgpu_dc_reg_template printk
  drm/amd/display: copy function name into dcn_fpu trace event
  drm/amd/display: copy function name into dcn_optc_lock_unlock_state trace event

 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 99 +++++++++----------
 1 file changed, 45 insertions(+), 54 deletions(-)

-- 
2.53.0

