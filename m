Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32709C5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 11:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8649710F482;
	Fri,  7 Aug 2026 11:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XpBSLbu7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCA010F493
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 11:45:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4C9D600D8;
 Fri,  7 Aug 2026 11:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4351F000E9;
 Fri,  7 Aug 2026 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786103109;
 bh=4fIsUldULIaC0MWQKqk57oNvo2kpovLrTcAHwv/xdzM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XpBSLbu75zt6T6N/reDErAnhMzLBTNJ/4lCeuuL3wrLLB7w4pgAcsuSGNI+QM/Wsc
 KvScPUP/eiSJqr93YmXQcKkpWR/rFr9JtVx524QecZulejUg4/I0t4s5qoV2HrXfw8
 llZepkSXN5s23h7gtJyXj57NXejhC6YaJAj23dFaluz0xJ/Wx4AW3XVh6eRETcF9jM
 ZUKvgq47brVypteSY9zIsOZjoknwhfQbqhT/Psq/CZbA0xWtJpv3qRCpeO6efoMThb
 heP0pvd5krz9gb2LwGvd3OUMB226PB0c2Y+s1YNTn3WD4Mk8wb0RRo1qELDeal6Ltp
 gEVsSyrDOX3jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, David Weber <weber.aulendorf@gmail.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.1.y] drm/amd/display: Exit idle optimizations before
 programming
Date: Fri,  7 Aug 2026 07:45:05 -0400
Message-ID: <20260806234000.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805163314.214623-1-sunpeng.li@amd.com>
References: <2026080547-scoff-that-5ce1@gregkh>
 <20260805163314.214623-1-sunpeng.li@amd.com>
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

On Wed, Aug 05, 2026 at 12:33:14PM -0400, sunpeng.li@amd.com wrote:
> Prior to the tagged "Fixes:" change, drm_vblank_get() was called before
> the workqueue flush. This ordering ensures that PSR exit occurred before
> programming. After the "Fixes:" change, drm_vblank_get() is called after
> the workqueue flush, leading to programming while idle optimizations are
> still active.

Queued for 7.1 and 6.18, with the "check GRPH_FLIP status before sending
event" prerequisite applied ahead of it on both trees, thanks.

-- 
Thanks,
Sasha
