Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBCDC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 00:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC2A206E3
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 00:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="wJWQyTrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC2A206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AEE16E8AA;
	Fri, 24 Jul 2020 00:11:07 +0000 (UTC)
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch
 [185.70.40.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EB889B0B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 22:58:34 +0000 (UTC)
Date: Thu, 23 Jul 2020 22:58:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1595545112;
 bh=lg9xOnMsFhhdqALv0aeP/Vx2Gofelvm+74wmCknZsFo=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=wJWQyTrNxzYCugTunHerczbSVBPFAyOkFnBt7X5S1XVzsUu/CqTghfT5XKiJqfCMb
 G1g3xRBuQI4aoyJodntEqzHGTw4zt+dQyEA0OkIP7e/Z9Q+YFww7/QLZdrEgJ35/qn
 M4P8GF7YJgW5MjILTKRXcogl6z7WEMPnUhlcPT04=
To: Kees Cook <keescook@chromium.org>
From: Mazin Rezk <mnrzk@protonmail.com>
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
Message-ID: <4KGdosy_NHW6FYCc2rCq4e71vYI7e4InqrLJ4S1GJsLcfjHv_INF-CzIYusOFqznOxyvflBTlFCXvyy7J37fn-QKfNOQK78MM38VdjdUXks=@protonmail.com>
In-Reply-To: <202007231524.A24720C@keescook>
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
 <202007231524.A24720C@keescook>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 24 Jul 2020 00:11:04 +0000
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
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Cc: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
 "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
 "1i5t5.duncan@cox.net" <1i5t5.duncan@cox.net>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>, Mazin Rezk <mnrzk@protonmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
 "regressions@leemhuis.info" <regressions@leemhuis.info>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thursday, July 23, 2020 6:32 PM, Kees Cook <keescook@chromium.org> wrote:

> On Thu, Jul 23, 2020 at 09:10:15PM +0000, Mazin Rezk wrote:
>
> > When amdgpu_dm_atomic_commit_tail is running in the workqueue,
> > drm_atomic_state_put will get called while amdgpu_dm_atomic_commit_tail is
> > running, causing a race condition where state (and then dm_state) is
> > sometimes freed while amdgpu_dm_atomic_commit_tail is running. This bug has
> > occurred since 5.7-rc1 and is well documented among polaris11 users [1].
> > Prior to 5.7, this was not a noticeable issue since the freelist pointer
> > was stored at the beginning of dm_state (base), which was unused. After
> > changing the freelist pointer to be stored in the middle of the struct, the
> > freelist pointer overwrote the context, causing dc_state to become garbage
> > data and made the call to dm_enable_per_frame_crtc_master_sync dereference
> > a freelist pointer.
> > This patch fixes the aforementioned issue by calling drm_atomic_state_get
> > in amdgpu_dm_atomic_commit before drm_atomic_helper_commit is called and
> > drm_atomic_state_put after amdgpu_dm_atomic_commit_tail is complete.
> > According to my testing on 5.8.0-rc6, this should fix bug 207383 on
> > Bugzilla [1].
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=207383
>
> Nice work tracking this down!
>
> > Fixes: 3202fa62f ("slub: relocate freelist pointer to middle of object")
>
> I do, however, object to this Fixes tag. :) The flaw appears to have
> been with amdgpu_dm's reference tracking of "state" in the nonblocking
> case. (How this reference counting is supposed to work correctly, though,
> I'm not sure.) If I look at where the drm helper was split from being
> the default callback, it looks like this was what introduced the bug:
>
> da5c47f682ab ("drm/amd/display: Remove acrtc->stream")
>
> ? 3202fa62f certainly exposed it much more quickly, but there was a race
> even without 3202fa62f where something could have realloced the memory
> and written over it.
>
> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
>
> Kees Cook


Thanks, I'll be sure to avoid using 3202fa62f as the cause next time.
I just thought to do that because it was what made the use-after-free cause
a noticeable bug.

Also, by the way, I just realised the patch didn't completely solve the bug.
Sorry about that, making an LKML thread on this was hasty on my part. Should
I get further confirmation from the Bugzilla thread before submitting a patch
for this bug in the future?

Thanks,
Mazin Rezk
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
