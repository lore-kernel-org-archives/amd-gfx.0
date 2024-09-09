Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9E9ECE579
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 08:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB1210E337;
	Mon,  9 Sep 2024 08:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WpUK5T12";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D3810E336;
 Mon,  9 Sep 2024 08:49:07 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4X2L9C6HmQz9sW5;
 Mon,  9 Sep 2024 10:49:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725871743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AngHvSwbCW0+7rfPLzjnSExJBBtNLPD5KPT/tszkCtQ=;
 b=WpUK5T12v7bPD/nIczcpQZBACpbwWOUIQxMnRY8JODRbywjax0pUvcp2QB02GT9eJ/Cxfz
 WU2isLHojzke+6ZK3S/uH20vDxkzSuopvzOVoEg74XEQ24vuj0gcLNEKoevfr3odQY+wVu
 1lXIVaThtfBaf6ufzPzyezUSqIS9VcAauZnVHm5YZ6FzNSaJySXI9Be71LbMte9/kH1GuY
 25nLXxSZS/8p8FjiH0ySEUu0kIaETSohRV7GKaz/lMpzz4r2eOyJ49g7984oWoa12iJ0yC
 SXBHztSHFN+ZIuq9YrsuCZRMGDa6p3vmG89G9ucRWJpJDD1XlRJWTz+7rZpM1g==
Message-ID: <d880c32d-2bc4-4b53-a919-efa8df79109e@mailbox.org>
Date: Mon, 9 Sep 2024 10:49:01 +0200
MIME-Version: 1.0
Subject: Re: 6.11/regression/bisected - after commit 1b04dcca4fb1, launching
 some RenPy games causes computer hang
To: Leo Li <sunpeng.li@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, zaeem.mohamed@amd.com,
 pekka.paalanen@collabora.com, "Wheeler, Daniel" <daniel.wheeler@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com>
 <CABXGCsNztS8MLteq5=fcddwuQ1TCzeOM8TdVtpJ3crK=sV5PTQ@mail.gmail.com>
 <CABXGCsMdxHJ-MLkS0pm51Sk8g0PTghsuZxmowvj5t44bVN4ndA@mail.gmail.com>
 <ffd2c40c-1c2e-4465-b26f-88d5e08a80d9@amd.com>
 <CABXGCsOoL5vD0+FRALFQFr3ZBpb2z5mpGKzAD5RHoW9_sb5yaQ@mail.gmail.com>
 <f68020a3-c413-482d-beb2-5432d98a1d3e@amd.com>
 <CABXGCsMSTsBFW=OirDszPFVOiNgyOBSh3qyzAw-Coi-McnicAQ@mail.gmail.com>
 <04d3755d-f295-46d7-b35d-008b888b39ae@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <04d3755d-f295-46d7-b35d-008b888b39ae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kcrirfedk8katjemr557ymd44g7p1e1e
X-MBO-RS-ID: 989341b4da68afa42db
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

On 2024-09-06 21:46, Leo Li wrote:
> 
> Second, can you try adding "amdgpu.dcdebugmask=0x40" to your kernel cmdline at
> boot, and see if you can still repro the hang?
> 
> This setting disables hw planes. If it resolves the hang, then it's quite
> interesting, because it suggests that gnome may be using direct-scanout via hw
> planes. We may need to align our gnome configuration in that case, since I don't
> see any additional hw planes being used on my setup.

GNOME's mutter doesn't make use of overlay planes yet.

(There's a WIP MR though: https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/2660)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
