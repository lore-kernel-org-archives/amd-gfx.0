Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4793C55160
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 02:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6787B10E0A4;
	Thu, 30 Jul 2026 02:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nsYGd9Wg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894C010E0A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 02:40:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0827B600B1;
 Thu, 30 Jul 2026 02:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30A51F000E9;
 Thu, 30 Jul 2026 02:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785379253;
 bh=RyTEnv63di/ZnQ4fhrUnlRJJkfnhOs7V4O2VKHjPxrI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nsYGd9WgE51TM77R4ABu6+pF2/ZAW8i7nU6Yf2v+5pDxEBQTB+AVukdHIyxNYaC4G
 scxsvywfgC5vsZE533bHXPT/tElR+BpMVGMgQOlpQu+l4+lO2TQFdkxAHOlg/0B7RH
 RX/uobQqi/i2mYlkD1E/f0h3Gr1sj9GHMBP+gf3OHKTJH1OHCsWfxyJI7xL8DZia14
 dRWpWA6zadcJzpdsdVACBbmb9EXmdzrwRK3BR3tnkbSg7d4CzT5zoSbkTNRgJMk7SX
 oRQ66k8pgh/MPVD/Ku97mLhIQcdwT67l6ed5TBrcMwi95Lj1DichTVu93NLb/mqS/S
 ZdfzVzrjI9oaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com, mario.limonciello@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH 6.12.y/6.18.y/7.1.y] drm/amd/display: Fix DTB DTO updates
 breaking live pixel rate sources
Date: Wed, 29 Jul 2026 22:40:19 -0400
Message-ID: <20260729223316.stable-0026@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729063340.9287-1-matthew.schwartz@linux.dev>
References: <20260729063340.9287-1-matthew.schwartz@linux.dev>
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

> [PATCH 6.12.y/6.18.y/7.1.y] drm/amd/display: Fix DTB DTO updates breaking live pixel rate sources
> [PATCH 6.6.y] drm/amd/display: Fix dcn32 DTB DTO update breaking live pixel rate sources

Queued for 6.6, 6.12, 6.18 and 7.1, thanks.

-- 
Thanks,
Sasha
