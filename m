Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214F2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 13:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A4610E3B6;
	Thu, 21 Apr 2022 13:06:25 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D5510E724
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 11:11:36 +0000 (UTC)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1nhUik-0002yu-82; Thu, 21 Apr 2022 13:11:34 +0200
Message-ID: <550cf7fc-47fa-777d-892d-8ec0b9d15445@leemhuis.info>
Date: Thu, 21 Apr 2022 13:11:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220421031607.1745623-1-alexander.deucher@amd.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220421031607.1745623-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1650539496;
 a7026f63; 
X-HE-SMSGID: 1nhUik-0002yu-82
X-Mailman-Approved-At: Thu, 21 Apr 2022 13:06:23 +0000
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
Cc: Michele Ballabio <ballabio.m@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 21.04.22 05:16, Alex Deucher wrote:
> We normally runtime suspend when there are displays attached if they
> are in the DPMS off state, however, if something wakes the GPU
> we send a hotplug event on resume (in case any displays were connected
> while the GPU was in suspend) which can cause userspace to light
> up the displays again soon after they were turned off.
> 
> Prior to
> commit 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's."),
> the driver took a runtime pm reference when the fbdev emulation was
> enabled because we didn't implement proper shadowing support for
> vram access when the device was off so the device never runtime
> suspended when there was a console bound.  Once that commit landed,
> we now utilize the core fb helper implementation which properly
> handles the emulation, so runtime pm now suspends in cases where it did
> not before.  Ultimately, we need to sort out why runtime suspend in not
> working in this case for some users, but this should restore similar
> behavior to before.
> 
> v2: move check into runtime_suspend
> v3: wake ups -> wakeups in comment, retain pm_runtime behavior in
>     runtime_idle callback
> 
> Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
> Tested-by: Michele Ballabio <ballabio.m@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [...]

Hi Alex, how can I bribe you to start placing "Link:" tags in
submissions that fix regressions (like this one), as explained in the
Linux kernels documentation (see
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'). E.g. in this case like this:

"Link:
https://lore.kernel.org/r/20220403132322.51c90903@darkstar.example.org/"

This concept is not new (Linus and quite a few other developers use them
like this for a long time), I just recently improved those documents to
clarify things, as my regression tracking efforts rely on them -- that's
why it's making my work a lot harder if they are missing most of the
time. :-/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot ^backmonitor:
https://lore.kernel.org/lkml/20220403132322.51c90903@darkstar.example.org/
