Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34B6C54FCD
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 02:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6519210E069;
	Thu, 30 Jul 2026 02:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CyTd5g5O";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BC810E069
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 02:40:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7277600B0;
 Thu, 30 Jul 2026 02:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98011F00A3E;
 Thu, 30 Jul 2026 02:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785379241;
 bh=kzshhQShEALfUgm8OY0PEu/4IHG++/qw5QpmzIBc4ho=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CyTd5g5Oa+bQXq/o2jQ0KJXZZDrFWK/jtpuqbHIM0K/4+tTX4bvxfuE9vMOoZ2f/H
 i72xGjDCbtcblzNY0PZb3kE+e1S/KNtuP1SanM1KDI0OMFbH0qouWvSsv3FoOFfzlg
 Gz6YpaxtK/oJcsZm85oUKbriuAuPeJNNZwq3oSSxCryVZnHP9yBOhmNCs2jZWT3+Ys
 p1RT9EAA3KjIUoOHUvMKHUlNHuNCPOjKXp/vld0bFHFL6hHvun9Vw1ZY9Z2O6BKgtg
 mahvc2KdQXR2hbNdMnZJSq6xW4Dt53jyoeewQqoqdr7P+O36/fJmwVu7Fo4VKDCbUw
 DDO0l5Sr6Wgvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before
 sending event
Date: Wed, 29 Jul 2026 22:40:06 -0400
Message-ID: <20260729223316.stable-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729173742.950965-2-sunpeng.li@amd.com>
References: <20260729173742.950965-2-sunpeng.li@amd.com>
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

> [PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before sending event

Thanks for the backports, but I'm going to hold both of these for now.

There are two unmerged Fixes: patches against 48ab86360af1 ("drm/amd/display:
check GRPH_FLIP status before sending event") on the list, and I can
reproduce a flip_done/login freeze on DCN 3.1.5 with 7.2-rc4, plus there is
your own Cc: stable follow-up on top.

Could you confirm which set you want stable to carry before I queue any of
it?  Once the follow-ups land in mainline I'm happy to take the whole thing
together for 7.1 and 6.18.

-- 
Thanks,
Sasha
