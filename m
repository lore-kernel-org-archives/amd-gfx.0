Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99141C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689AB20708
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6WnLk1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689AB20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F236F3D8;
	Tue, 28 Jan 2020 20:11:45 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4704D6F3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 20:11:44 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id s144so2546378wme.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 12:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fPpB1pZYkmn/hjMHd3BquZiU1iu5N9KtoesX0Ki6K7g=;
 b=L6WnLk1+zWHKaFjEcLsJt+ggcE3xFHb8d3pJZRKjTNroXNSWl7f8QKd3oeWaZlaQ9S
 OT+JxO/yDW0QqKkdEloStF+ZVQ+ElPqTAApHzvXpjw0jZAJeAv3UcDWr0OGpnWzqc02a
 1ijSZHoOOVxb0R+Ajv43jPAIdxv/7DISlkWxB8wpo3svCvYyAMCbwXeDHUpAe05+aB8j
 2B6jeGuKFHlY8PVxaTQ1imQlRk/iltZy0VxBu+P+CEmIhiVMVhAsbDL8FLB7YVfD3IG0
 moDtwsHS5079INILa2OYcMj87tMYxDby3PoaEgTDW7T5UHK+l3400zF2SVJtQHWQJ6xX
 oEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fPpB1pZYkmn/hjMHd3BquZiU1iu5N9KtoesX0Ki6K7g=;
 b=NZXMKgYeEBAmiPxCP5Ij/ywDkC+H/C6gXneiTrXCvbwhKfsnSDG6YNYw53Qc8HfMlc
 4K1/yoRZjVeYen0MvbqzKpDhSot/rMsSugPTSyQ8B+rgjv4KoMa7idAuVahoBct7nBuF
 dG04YRKo1+mnYdjdQcmBgu/8GVIj9T920OjI+E4JWD1ZTfQ/mNjQQlqreZPt3ZuosC4u
 JGSslvHWDM+d0ySotZTjEH7nBOvKCnORWtrpFGqD+krwa5/bKCGGISuwJMmdEJgag7jO
 P/AL7ovYVb+e9rjs1u2TeBFCTTTJIa2iGVc2d8+7YGizlWl/ggjo3lNSEn0+IOpQUFRz
 ieeA==
X-Gm-Message-State: APjAAAV40Gu+RYO9aC0/2009VN0zTy4lTNEA5JPgmcWZqqZ3zA8S9REy
 eXY14N/vsAEUsBmt5swr9lZBsGK6GgTCZH6XKyo=
X-Google-Smtp-Source: APXvYqwH3Ga/g0mYF0nDm3jWep/oQ+HSNvzwfkjuQCmI14mLN0W1QPvBtgopNf8A1n57iozUTH4t0AXoW+D5NtWXy4g=
X-Received: by 2002:a7b:c152:: with SMTP id z18mr6706784wmi.70.1580242302884; 
 Tue, 28 Jan 2020 12:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <CAHbf0-G_mG-awokOA5yeLwp4CKzQ1WB_a6rBLj-xKY5cnS+YUw@mail.gmail.com>
In-Reply-To: <CAHbf0-G_mG-awokOA5yeLwp4CKzQ1WB_a6rBLj-xKY5cnS+YUw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2020 15:11:31 -0500
Message-ID: <CADnq5_OANiWKd=cA1BzdQ_QOGNoLwEZ0EFF0c2UmRmw9rVf19g@mail.gmail.com>
Subject: Re: [Patch v1 0/5] Enable BACO with KFD
To: Mike Lothian <mike@fireburn.co.uk>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 28, 2020 at 12:39 PM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Is this designed to work with PRIME laptops too?
>

Yes.  The title should really be runtime pm rather than BACO
specifically.  The underlying power savings mechanism (BOCO, BACO,
etc.) varies from platform to platform.

Alex

> On Tue, 28 Jan 2020 at 01:29, Rajneesh Bhardwaj
> <rajneesh.bhardwaj@amd.com> wrote:
> >
> > This series aims to enable BACO by default on supported AMD platforms
> > and ensures that the AMD Kernel Fusion Driver can co-exist with this
> > feature when the GPU devices are runtime suspended and firmware pushes
> > the envelop to save more power with BACO entry sequence. Current
> > approach makes sure that if KFD is using GPU services for compute, it
> > won't let AMDGPU driver suspend and if the AMDGPU driver is already
> > runtime suspended with GPUs in deep power saving mode with BACO, the KFD
> > driver wakes up the AMDGPU and then starts the compute workload
> > execution.
> >
> > This series has been tested with a single GPU (fiji), Dual GPUs (fiji
> > and fiji/tonga) and seems to work fine. I have not seen but expect some
> > corner cases where for some reason a KFD client binds a process but is
> > unable to complete the task within 60 seconds. Ideally we should put the
> > runtime_put and auto_suspend code in some function which is logical
> > opposite of bind_process_to_device but during my experiments, it ended
> > up with random gpu hang, machine reboot etc so any comments for
> > improvement are welcome.
> >
> > Todo:
> >
> > rebase on top of https://patchwork.freedesktop.org/patch/338037/
> >
> > Rajneesh Bhardwaj (5):
> >   drm/amdgpu: always enable runtime power management
> >   drm/amdgpu: Fix missing error check in suspend
> >   drm/amdkfd: Introduce debugfs option to disable baco
> >   drm/amdkfd: show warning when kfd is locked
> >   drm/amdkfd: refactor runtime pm for baco
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 ++++-----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  9 ++++---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 +++----
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  2 ++
> >  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c   | 27 +++++++++++++++++++
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 31 +++++++++++++---------
> >  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c     |  5 +++-
> >  drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 19 ++++++++++---
> >  10 files changed, 91 insertions(+), 33 deletions(-)
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
