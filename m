Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9505C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E05D10E4E0;
	Tue, 30 Jul 2024 07:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="TxL8CSQm";
	dkim-atps=neutral
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9ED10E21C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 08:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
 Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 In-Reply-To:References; bh=BzIiocqu7ai5BzKHxI8W6PqIYtEJSWNtQSgp6jZijik=;
 t=1722241901; x=1722673901; b=TxL8CSQm5eF0PjkF+n1J29jdDgXdyVjMZWfNCUEO7iFInbA
 ZzHlIFFVtsEwaDrIp82KM5E5M5RJPbjfrxALYUK+io5qJTexBaXj4Cqfsj0onH4Iltmhsk7RR1br5
 2HPy4l8hTrOFt6sxAs6lQDHj34hH4vNlQfaMz5aKMyUxGUEMGD039LXdu/XMd2s5S3JCJCCqG4EFm
 5Ns1m5v1tbWCgvhEYw++tv1bRH44+zGGgeXkYHDlksWFVx5WaVgOpMZEDi2lUjc95aaz+QkqJ8Gnc
 I5jLd9v3o/LjvXXhbJkPDU1FR2l/tqPuy0RsBZuQm3bpIxCwR0kgfkdA7pyGRSAg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1sYLn8-0004K5-QN; Mon, 29 Jul 2024 10:31:38 +0200
Message-ID: <a3af3f0b-df81-4407-a38d-2fa35b33b08c@leemhuis.info>
Date: Mon, 29 Jul 2024 10:31:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix corruption with high refresh rates
 on DCN 3.0
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mikhail.v.gavrilov@gmail.com, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240716173322.4061791-1-alexander.deucher@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240716173322.4061791-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1722241901;
 88b8ab58; 
X-HE-SMSGID: 1sYLn8-0004K5-QN
X-Mailman-Approved-At: Tue, 30 Jul 2024 07:54:54 +0000
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 16.07.24 19:33, Alex Deucher wrote:
> This reverts commit bc87d666c05a13e6d4ae1ddce41fc43d2567b9a2 and the
> register changes from commit 6d4279cb99ac4f51d10409501d29969f687ac8dc.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3478
> Cc: mikhail.v.gavrilov@gmail.com
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [...]

Hi Greg, quick note, as I don't see the quoted patch in your 6.10-queue
yet: you might want to pick up e3615bd198289f ("drm/amd/display: fix
corruption with high refresh rates on DCN 3.0") [v6.11-rc1, contains
table tag] rather sooner than later for 6.10.y, as the problem
apparently hit a few people and even made the news:
https://lore.kernel.org/all/20240723042420.GA1455@sol.localdomain/
https://www.reddit.com/r/archlinux/comments/1eaxjzo/linux_610_causes_screen_flicker_on_amd_gpus/

Ciao, Thorsten
