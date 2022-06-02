Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E67BC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 13:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1FA112957;
	Thu,  2 Jun 2022 13:58:34 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68D6112957
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 13:58:33 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-e93bbb54f9so6781470fac.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2L2ObJyA5aSAMYg/ooYObOJj991nQteSKXjuDuNhvCw=;
 b=Bb5NTBROxJdLUTbonbdi14UD9v3tDr1oU1S+IeAYUwTUdbHPQY26Dc/kvLzg2pqCd/
 aCT00EyhkTQ1jkzHf8yho+GP8PJTRZuwgSj5UlVuueawgQHOoZBPTDm3mPxzul+JW7iU
 /cwQvwAzepsY8lWF4DVXDJ2B8ERuGFTuCS3ovLQc15pqWz1Cj2GpxPBm2YKjDoSD7eZ7
 RNzMo5oRBELVXe2Rz02E403frVUxGrE2xjamoela22Ll9uqnQmJvpE/3Ud17uYMBEI87
 W6Rrx5UpQ3s4+hw1lS1VATGpvr8Bjs7POrF36N9A0NtkIHUyNIJY60qvhp6FiiFBmKQl
 YRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2L2ObJyA5aSAMYg/ooYObOJj991nQteSKXjuDuNhvCw=;
 b=0cZYxprsg4bSLkbnaiOSQJoRC2mIf3O66O3WtZ4t69XIRZYuq7+EhUa4inh5v7/O/k
 aVrcMEWLyz95uXqqoF8rLUJR9JtU+BiBoH3cL+cHRarLIJsCVMsh1cYVyguRbko/H6sH
 e30C6t/uHzIFzHNbn3MIgj1b0o/18fvb9eDyfm4eKlNyYMcmMXSokSprDfcoTcbCR290
 gjrcZYu0VuWMy1o8Fe84UxFCL+sI6YbhJlm0CNCIFzpPeX2U7uCmVYlHSlKbM6ZDN4Pk
 sb4NLRptSHGefu7tYJAp6dNnSvPocBiHgmIM0tz5lLKAIx0QAES/3VGFI4UstlajM85e
 zbWg==
X-Gm-Message-State: AOAM533WiiQPTcaWT0op2RKWYoz5LTqUcxTgl2i4xixjn0L9oa0LDSmS
 fQ6pOc4Ck6Hl46BlfIvh1gEwTLTytXv2EtyfzaA=
X-Google-Smtp-Source: ABdhPJwDy6DJ5qiR0rFGMNl9Es1ZF1OGqrTAAVs3U0JDV3pUTwhOg+jdn03Umz0Fe1sVdCzwIFWA7VgzMu7kRZ7N63s=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr2810070oap.253.1654178312926; Thu, 02
 Jun 2022 06:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz>
 <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
In-Reply-To: <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Jun 2022 09:58:22 -0400
Message-ID: <CADnq5_Pr-FKfhuXT9DR2rYD=dMfD=+Dfev+CO-xeaPGnhwSQaA@mail.gmail.com>
Subject: Re: (REGRESSION bisected) Re: amdgpu errors (VM fault / GPU fault
 detected) with 5.19 merge window snapshots
To: Michal Kubecek <mkubecek@suse.cz>, "Yang, Philip" <Philip.Yang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 27, 2022 at 8:58 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Fri, May 27, 2022 at 11:00:39AM +0200, Michal Kubecek wrote:
> > Hello,
> >
> > while testing 5.19 merge window snapshots (commits babf0bb978e3 and
> > 7e284070abe5), I keep getting errors like below. I have not seen them
> > with 5.18 final or older.
> >
> > ------------------------------------------------------------------------
> > [  247.150333] gmc_v8_0_process_interrupt: 46 callbacks suppressed
> > [  247.150336] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
> > [  247.150339] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00107800
> > [  247.150340] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
> > [  247.150341] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1079296, write from 'TC2' (0x54433200) (8)
> [...]
> > [  249.925909] amdgpu 0000:0c:00.0: amdgpu: IH ring buffer overflow (0x000844C0, 0x00004A00, 0x000044D0)
> > [  250.434986] [drm] Fence fallback timer expired on ring sdma0
> > [  466.621568] gmc_v8_0_process_interrupt: 122 callbacks suppressed
> [...]
> > ------------------------------------------------------------------------
> >
> > There does not seem to be any apparent immediate problem with graphics
> > but when running commit babf0bb978e3, there seemed to be a noticeable
> > lag in some operations, e.g. when moving a window or repainting large
> > part of the terminal window in konsole (no idea if it's related).
> >
> > My GPU is Radeon Pro WX 2100 (1002:6995). What other information should
> > I collect to help debugging the issue?
>
> Bisected to commit 5255e146c99a ("drm/amdgpu: rework TLB flushing").
> There seem to be later commits depending on it so I did not test
> a revert on top of current mainline.
>
> I should also mention that most commits tested as "bad" during the
> bisect did behave much worse than current mainline (errors starting as
> early as with sddm, visibly damaged screen content, sometimes even
> crashes). But all of them issued messages similar to those above into
> kernel log.

Can you verify that the kernel you tested has this patch:
https://cgit.freedesktop.org/drm/drm/commit/?id=5be323562c6a699d38430bc068a3fd192be8ed0d

Alex
