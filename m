Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2052BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 15:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D411139B1;
	Fri,  3 Jun 2022 15:49:44 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B6D11398E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 15:49:43 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 w19-20020a9d6393000000b0060aeb359ca8so5806973otk.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jun 2022 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/9WBFLi2GZ/Ui4GpH9tULtj9LEgcGT39WehBSO1WgzQ=;
 b=HEUAXsna5ZmSt0hJfuqV4f5D85h+f7wPyDldmxerUEzbCUP/OG/paIqlzAoySvKeaX
 SIwilD6gZCvRVOBgAiv6GINcQ62p8PX5DuVPoOn35OEQFCmsntOS/RP6/DSiP6HzKvnz
 KQDYVwTmYWC0hcQmTYfskxUHLjDVhbLbi7rq7Z5JERaKRgMVEsWkU5tQYsCZFktp0Hq4
 Pv2dl+wx1j4nKLHpq/SBK+Q442HyVo3wK/Jx3mzQtCQj7MVzAGN7mM5NyvQCgjeLK8rv
 fhTbFgNwg9K1WmzDDQFjZhZLtR8NU+r+NSaFPMBUoGP/zMX6DKKXnj/oCXnhFXHdD4BJ
 0J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/9WBFLi2GZ/Ui4GpH9tULtj9LEgcGT39WehBSO1WgzQ=;
 b=H6g+lmiN9cTMcp+B3FrZO+ohzoS+Xv3sRDDLoyf7G4rOStoPFP71rOelarzWRChtYP
 WxeMysiUm9+Ynqh6M1s3eMPwHLTtGSv8UX1QTY6b6UPbfA4HIRWFQYO4JAenLwF9QuSj
 aOMgPhoz+H2rlQBPpXMvk2aqWtSZSQxOdbiwRerKSGRm2bIOfeTDFs3GeXD/s8UPKEed
 rmmWv4Evro51qWMAXUOuJKjk+2qeHs2S0Nz2PdRKE8aG/AbWkjtC5xqGOt5sJbODuZxA
 Wt8kgTQuMfmLrqnV0rVsfR46P2eO1ERreRvoFqnqoLugjwPMaoVVGX8JhVosZdMG4vMT
 LOFQ==
X-Gm-Message-State: AOAM532drLz3EbSYhLszVpqzhu1QlEIuFKbwffi52khNXehKjrJbJmLd
 XuJP9yB/mvkK6iZjOeS7ElV7OJtZ2j/EQBoGab0=
X-Google-Smtp-Source: ABdhPJxTFtSaEphADyaZrC3fHSPoD2jCLj9MJgYqmbfqzpp1ApK9lENRCw5aqbmmwF8PM1IEsWByk+YB87sXDhurQl4=
X-Received: by 2002:a9d:6b98:0:b0:60b:c54:e22b with SMTP id
 b24-20020a9d6b98000000b0060b0c54e22bmr4445740otq.357.1654271382892; Fri, 03
 Jun 2022 08:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz>
 <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
 <CADnq5_Pr-FKfhuXT9DR2rYD=dMfD=+Dfev+CO-xeaPGnhwSQaA@mail.gmail.com>
 <20220602142254.2ck7dw7u3xlzdnt2@lion.mk-sys.cz>
In-Reply-To: <20220602142254.2ck7dw7u3xlzdnt2@lion.mk-sys.cz>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Jun 2022 11:49:31 -0400
Message-ID: <CADnq5_MiQKX4JA-3xbxGYXKHpJqD0Px1NYSiL6yPeTwseoNVGg@mail.gmail.com>
Subject: Re: (REGRESSION bisected) Re: amdgpu errors (VM fault / GPU fault
 detected) with 5.19 merge window snapshots
To: Michal Kubecek <mkubecek@suse.cz>
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 2, 2022 at 10:22 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Thu, Jun 02, 2022 at 09:58:22AM -0400, Alex Deucher wrote:
> > On Fri, May 27, 2022 at 8:58 AM Michal Kubecek <mkubecek@suse.cz> wrote:
> > > On Fri, May 27, 2022 at 11:00:39AM +0200, Michal Kubecek wrote:
> > > > Hello,
> > > >
> > > > while testing 5.19 merge window snapshots (commits babf0bb978e3 and
> > > > 7e284070abe5), I keep getting errors like below. I have not seen them
> > > > with 5.18 final or older.
> > > >
> > > > ------------------------------------------------------------------------
> > > > [  247.150333] gmc_v8_0_process_interrupt: 46 callbacks suppressed
> > > > [  247.150336] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
> > > > [  247.150339] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00107800
> > > > [  247.150340] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
> > > > [  247.150341] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1079296, write from 'TC2' (0x54433200) (8)
> > > [...]
> > > > [  249.925909] amdgpu 0000:0c:00.0: amdgpu: IH ring buffer overflow (0x000844C0, 0x00004A00, 0x000044D0)
> > > > [  250.434986] [drm] Fence fallback timer expired on ring sdma0
> > > > [  466.621568] gmc_v8_0_process_interrupt: 122 callbacks suppressed
> > > [...]
> > > > ------------------------------------------------------------------------
> > > >
> > > > There does not seem to be any apparent immediate problem with graphics
> > > > but when running commit babf0bb978e3, there seemed to be a noticeable
> > > > lag in some operations, e.g. when moving a window or repainting large
> > > > part of the terminal window in konsole (no idea if it's related).
> > > >
> > > > My GPU is Radeon Pro WX 2100 (1002:6995). What other information should
> > > > I collect to help debugging the issue?
> > >
> > > Bisected to commit 5255e146c99a ("drm/amdgpu: rework TLB flushing").
> > > There seem to be later commits depending on it so I did not test
> > > a revert on top of current mainline.
> > >
> > > I should also mention that most commits tested as "bad" during the
> > > bisect did behave much worse than current mainline (errors starting as
> > > early as with sddm, visibly damaged screen content, sometimes even
> > > crashes). But all of them issued messages similar to those above into
> > > kernel log.
> >
> > Can you verify that the kernel you tested has this patch:
> > https://cgit.freedesktop.org/drm/drm/commit/?id=5be323562c6a699d38430bc068a3fd192be8ed0d
>
> Yes, both of them:
>
> mike@lion:~/work/git/kernel-upstream> git merge-base --is-ancestor 5be323562c6a babf0bb978e3 && echo yes
> yes
>
> (7e284070abe5 is a later mainline snapshot so it also contains
> 5be323562c6a)
>
> But it's likely that commit 5be323562c6a fixed most of the problem and
> only some corner case was left as most bisect steps had many more error
> messages and some even crashed before I was able to even log into KDE.
> Compared to that, the mainline snapshots show much fewer errors, no
> distorted picture and no crash; on the other hand, applications like
> firefox or stellarium seem to trigger the errors quite consistently.

This patch should help:
https://patchwork.freedesktop.org/patch/488258/

Alex

>
> Michal
