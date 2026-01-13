Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4B2D30CC0
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 20:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F7C10E53E;
	Tue, 13 Jan 2026 20:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EDjkcVDc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4918C10E53E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 20:01:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CCCEF43EB5;
 Tue, 13 Jan 2026 20:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7647DC116C6;
 Tue, 13 Jan 2026 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768334514;
 bh=M4uUyEp62gWWD4OOHFLprekCcfTdrbBnebmztF3mh64=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EDjkcVDc8fy2JPLPcxCXi+cKEji/LSh7u5E4loJIV8SBUN9ksk9z8X4YQLRBQEYvk
 cH0NpPRL+2VmpppDijtqgINcFyY+bBSOLbbD6l9Cvfimky5Gz170JWS+J8n31NBoyp
 WMVpGOL/tiBpGy6uTLEFfJic4cIUYMlRP77Vpv+Z2A2IOdOA7OhPLgtNbam30fTbhZ
 TIWv3Bb0h74UQlZlJMcitgfHi9qtiURXDQnWiJumppZaKYlY0MjiyeBoh2lHu7IodA
 CSnI01WN3g5I/C3vHP+QbWZxBEYb2xCvZUlPvNqbZGjaD0K6nevM4fSq7XmwtlyjsH
 0ToWKe84JxRnQ==
Date: Tue, 13 Jan 2026 15:01:53 -0500
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Apply 70740454377f1ba3ff32f5df4acd965db99d055b to linux-6.12.y
Message-ID: <aWaksWlyB-5k58G8@laps>
References: <20260113005327.GA2283840@ax162>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260113005327.GA2283840@ax162>
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

On Mon, Jan 12, 2026 at 05:53:27PM -0700, Nathan Chancellor wrote:
>Hi Greg and Sasha,
>
>Commit 70740454377f ("drm/amd/display: Apply e4479aecf658 to dml") was
>recently queued up for 6.18. This same change will be needed in 6.12 but
>it will need commit 820ccf8cb2b1 ("drm/amd/display: Respect user's
>CONFIG_FRAME_WARN more for dml files") applied first for it to apply
>cleanly. Please let me know if there are any problems with this.

Queued up, thanks!

-- 
Thanks,
Sasha
