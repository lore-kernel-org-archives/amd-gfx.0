Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E174C56208
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 11:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6E410F18D;
	Thu,  6 Aug 2026 11:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XNP+Pf3v";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8DF10F19E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 11:36:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0049460A64;
 Thu,  6 Aug 2026 11:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED35D1F000E9;
 Thu,  6 Aug 2026 11:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786016201;
 bh=KVadu0BtIMWtIre5calukpCIzOpYbejNQsFw9QOLEnM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XNP+Pf3vFyZsY4gFYVC2aSLlSjkOZcpbOuQiGb6dwpFIqO7wfyUgwSHjFE9WI+Yhp
 K91FH2ppgx9exhguhv1u/kACm1OSoqsSFm42swxK0S9IsLGQgcCFH7zlWDvJVC+1Sq
 rzunWoJbuVpA6W2fBmHH9IYbTD2a7lgRRx3QVKiLvk/+hzt4UtNXAbhGR60/m3po7q
 /kU/97G8z5Jf2k2qESiNq9//VBZfdDml8tWFYq9gZJySdHmREdxUe6qSTmI8r0jmIu
 LinapvEtLNhyZcHmyi7zh+gqimRUXRpouerCyCswd13g5GYJksHXBxdg48OSUk1dNR
 gYXnqOPwDblgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, David Weber <weber.aulendorf@gmail.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.1.y] drm/amd/display: Exit idle optimizations before
 programming
Date: Thu,  6 Aug 2026 07:36:12 -0400
Message-ID: <20260806021809.0021-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805163314.214623-1-sunpeng.li@amd.com>
References: <20260805163314.214623-1-sunpeng.li@amd.com>
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

This doesn't apply cleanly to 7.1?

-- 
Thanks,
Sasha
