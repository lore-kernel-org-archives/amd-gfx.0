Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20822C87FC8
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 08:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F026210E4A1;
	Mon, 21 Jul 2025 08:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="wAtEKjoM";
	dkim=pass (2048-bit key; unprotected) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="b0mwZIoJ";
	dkim-atps=neutral
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E001C10E081
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 00:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=c05wUT+bq779G
 ufqk2BH+fCf4L+5v3C8nXUtbpwoSmM=;
 h=in-reply-to:references:subject:cc:
 to:from:date; d=hacktheplanet.fi; b=wAtEKjoMcdl/AbzEI9KmWNQM/XOhQ60/bu
 D3ARrgrvqatKDeUTOvxqWoNBrj8XrtC5JNryWPW2PjxLmmGaxkNH2K9nP6cyJWQHnTjnj2
 7zfA+OUNlpw9U5io6XNzLYpK91o+3rNB5luBiRz6hybxTf8ihHJIcVb4zpo1TuoCaNuQlK
 xP+HFP4ap65wISL/Y5EDfftcyvwhBPO7ahMEAff+d3jB+8PGcNKhMdLQaH6csM7GrfL91J
 I6QK69+LKu5HtJYm346SZE27ce5qYobcBs/Zf0lI6/Us7ku/ShPWn+SK0qMky2GbzeKNPV
 ou0ROsRVxmqrfYFwTliD9RjTFsBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
 s=key1; t=1753059126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DXCbmS5P0loEZr2tsKNQxNnCx9HD+tGrfjP0p51QIJE=;
 b=b0mwZIoJ8CeZrbgkvsh0MsoZV58Dw8mMlTow1s6HBIiPYP02+4nCFPtUZZIiUDIGtjtRxP
 eSE9SVIN0QuH2YJnOxWnX//wfTA9JCTqpR4JXIlivdfhNzXpcZ7tLuLMtnsohHk3zSI4WM
 vaL69Ojkh95sewFyGTYiaEHCo8K8KxpUWjj3semidPEvsGktwemuCYSXUITsr2i/997iqB
 cw+DpCIM4SG6EIDSxLrnBstooEVAGLM2kTw/Ho4Y98SAQGeLmMs9cSvMkFup0KT2mjUxwi
 x+bkLIlw6XNhKxvjZ9v4FPFvVKRJX73ZYf2xlWQw6vmflpOxvVBL6juXdVq25A==
Date: Mon, 21 Jul 2025 09:51:58 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mario Limonciello <superm1@kernel.org>, stable@vger.kernel.org,
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 Wayne Lin <wayne.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [REGRESSION] [PATCH] drm/amd/display: fix initial backlight
 brightness calculation
Message-ID: <aH2PLrFLS0ksT0u1@hacktheplanet.fi>
References: <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
 <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
 <aHr--GxhKNj023fg@hacktheplanet.fi>
 <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
 <cc7a41dc-066a-41c8-a271-7e4c92088d65@kernel.org>
 <aHy4Ols-BZ3_UgQQ@hacktheplanet.fi>
 <aHy4tohvbwd1HpxI@hacktheplanet.fi>
 <2025072012-deluge-arbitrate-9129@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025072012-deluge-arbitrate-9129@gregkh>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Mon, 21 Jul 2025 08:45:59 +0000
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

On Sun, Jul 20 2025 12:26:48 +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 20, 2025 at 06:36:54PM +0900, Lauri Tirkkonen wrote:
> > DIV_ROUND_CLOSEST(x, 100) returns either 0 or 1 if 0<x<=100, so the
> > division needs to be performed after the multiplication and not the
> > other way around, to properly scale the value.
> > 
> > Fixes: 6c56c8ec6f97 ("drm/amd/display: Fix default DC and AC levels")
> 
> This should be a commit id in Linus's tree, NOT in just one stable
> branch.
> 
> Also, you forgot to add a cc: stable@vger.kernel.org so that it will be
> picked up by a stable release.

Thank Greg, let me try again. First time sending a patch, so... :)

-- 
Lauri Tirkkonen | lotheac @ IRCnet
