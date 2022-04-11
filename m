Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48312C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 13:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4C910E0FB;
	Mon, 11 Apr 2022 13:08:03 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104F310F329
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 08:31:02 +0000 (UTC)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149]
 helo=[192.168.66.200]); authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1ndpRr-0004tX-8k; Mon, 11 Apr 2022 10:30:59 +0200
Message-ID: <5d7ac2a0-00b7-1307-6aeb-1461c79bd6f8@leemhuis.info>
Date: Mon, 11 Apr 2022 10:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Evan Quan <evan.quan@amd.com>
References: <20220411074732.36486-1-evan.quan@amd.com>
 <78cdd8a2-4482-7b1b-2df4-a2983c1b2887@molgen.mpg.de>
From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] drm/amd/pm: fix the deadlock issue observed on SI
In-Reply-To: <78cdd8a2-4482-7b1b-2df4-a2983c1b2887@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1649665862;df6de1ba;
X-HE-SMSGID: 1ndpRr-0004tX-8k
X-Mailman-Approved-At: Mon, 11 Apr 2022 13:08:02 +0000
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
Cc: Alexander.Deucher@amd.com, arthur.marsh@internode.on.net,
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11.04.22 09:59, Paul Menzel wrote:
> Am 11.04.22 um 09:47 schrieb Evan Quan:
>
> As it’s a regression, please follow the documentation, and add the
> related tags.

Yes please, otherwise you break tools that reply on this, like my
regression tracking efforts.

> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in
> amdgpu_dpm.c")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
> Link:
> https://lore.kernel.org/r/9e689fea-6c69-f4b0-8dee-32c4cf7d8f9c@molgen.mpg.de
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1957
> 
> Also add the link from Arthur.

What is BugLink? That is not in the kernel's documentation afaics (BTW,
as other people use it as wll: where does that actually come from?
GitLab?) . It should just be "Link:". Or am I missing something?

Ciao, Thorsten

