Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E57F588C2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AB810E5F2;
	Mon, 20 Apr 2026 13:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o7FzuWs/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13FF210E5F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 13:21:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 414D06012B;
 Mon, 20 Apr 2026 13:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD47C2BCB4;
 Mon, 20 Apr 2026 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776691292;
 bh=oVwuzYzukeQDmwGlU0rmhQA/bH1QRrZVQNaXWeEeZYs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o7FzuWs/TBsI6ZrOSDzQUW8wupTIcWjXaK5agJS0yfBYICaXvMU11peoWA3GAmktX
 kO8L+T3/pH58m5DquD0IQf72id3H2Uf1VytoCqHBs93TLL36KGR6RVYjBexYkEivPq
 qJ5GX6wVwYR5ILshNBrEw0OryxgIayg+l5rDBBKcsD8nwPQjYfJbrE/LcWZAhWSDxK
 BScpLoqXD4hf8K8IoD94LauehfmDZ6QYDc4oKq1mDHPvtfQ5DM7+zvSO7DcXuYMPvr
 voS51NB+84ar+ahVgpNQydYSj1pYNb3262//QLLfmbMMXRU9m5oqKJe2R2vJ1cgoQu
 1G/GKtjvoxLaA==
From: Sasha Levin <sashal@kernel.org>
To: Robert Garcia <rob_garcia@163.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
Date: Mon, 20 Apr 2026 09:21:13 -0400
Message-ID: <20260420-stable-reply-amdgpu-bug-on-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417074010.1607496-1-rob_garcia@163.com>
References: <20260417074010.1607496-1-rob_garcia@163.com>
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

On Fri, Apr 17, 2026, Robert Garcia wrote:
> Backport of 5d55ed19d419 ("drm/amdgpu: remove two invalid BUG_ON()s")
> to 6.1.y.

Queued for 6.1, thanks.

--
Thanks,
Sasha
