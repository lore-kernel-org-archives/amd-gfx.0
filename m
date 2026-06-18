Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29AACD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 06:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7776B10ECB3;
	Thu, 18 Jun 2026 06:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MnXpvPmd";
	dkim-atps=neutral
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E1A10ECC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 06:45:11 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7e6e9408e30so545129a34.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 23:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781765111; cv=none;
 d=google.com; s=arc-20240605;
 b=cdoa6FZqlMme5iGqYCkLR9ks8F45PqT7h78LKBBpQ/o9I2Rd/7anaHV+xrCYJRyo85
 geZY+nRXQJtOLlDXQEHaepcIpnfX5RvbonooMgCwqQ6FAuK1hVddKi61dsdfbDtf4aqs
 N8my09sa82IbeniHtCdNXXfY0p9+0dh7Yvafe6gHFdRA/Y89BbAQRu6gbXqC5cidwLBe
 h2tiNtMSBAwbswd3quIeaf8Il5/dXUh20D4OWjurzeVSGvfqQ/ZC2Wx6QaaVbAqdN3pz
 +CZV6/Q8YlybS65Q5r3qF9MwLtgnJZedouHIqexJv/2DZwPnOE7hbmRgIpP38k815l0L
 LjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Aw7+Ysr8IWme6YKCtFAf4Wtx49VGl1R8xVbGoroEzf4=;
 fh=A0O92VuhfCQXQeb4hEgqOCeTqkZAv9qZR5gTzfPEHwQ=;
 b=X9wR9bCEVA6ERS6rRY3Dbsl2wqsceYda17jPFRZkRSv7LFRJKQMmOu9g7/bHY83uC8
 eVUjRtGZOYj+BXssMy1Vt4lkF7bw3iZuydzk3q53ps81xJcK5llodH9NFHJaCS7JlGcD
 enXUbQzjxSFmLOfC4lP/zjQ4oxKkYRNiPrTJd0ya4Jiero7z8dA/Vk2UTL0zePuP+MZE
 5M7g9EHlgLidQxKiPta16PX8q6CIcwy+5OwvC0H0017sl57RfJpCVia22XhzEzfOd1jd
 wKN5Tx1+F2vf0dHpbJMEmTuAYHXoRSoJYaeLeaCP1WeOXqIr2JHLno99rGgdfczUSFot
 7RFQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781765111; x=1782369911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aw7+Ysr8IWme6YKCtFAf4Wtx49VGl1R8xVbGoroEzf4=;
 b=MnXpvPmdmQSmpg6ChUC6walwZfV0M2fv0eTAQdXZm/c2Ukj6zSLFAyKTOiDmFD5oXc
 2Fm/VV1ag31HjrpGlj3sAAwAnUm7BIDi3rroiMnFrXelDJhCy1RZvZsy+QYAUYtUuvhJ
 X19KPJ2gusxBSl4hDZLhPGERnPF9Y24AY65vCRCIXj0/utvbL/eYBqSjRR7wcbrup3Al
 GEpUv1j0yvXMJmzQBMnFdwS2VwV6XaYyAcmTIjWATEryiGWRznMUludGwBI2jOEwFAVk
 byl3GnrAHA5dNwF1zlpFhzNdb4JhiXkxxy3mmAHGHHczYnNqNZBBPztD3ez/fvIQdmbu
 OUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781765111; x=1782369911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aw7+Ysr8IWme6YKCtFAf4Wtx49VGl1R8xVbGoroEzf4=;
 b=lIZiIixXt8zv6AmLSPRDelkiUQVVkOzMLxM3bWAaJL4VNv25vIqBn4+8tVxW16G57d
 jdeMCqTBY/KDhh5eH6QHCwC4fXqBj8nGzzhDdd5sfODjb0POZDMw3BFXV0gP1iY22nps
 Q2pAsoU44fjnCEOqyuX5/ll79iyvGH5rj4ORE4C6LX8Ysh9Oirr/FN7l5F8q+zgg9KlD
 eGuzJhJrh6qVPY7PevGnydtRF1U5KMY1EYqTlSIsoA+jC3cOYwbK0A7/qVeafD9JYD3g
 60bY2wREMKI5LhvJYipnibYLSpo2EoZYKHp8Kr8Sj5K3dDwz+Klc5meOoE8ti64cHHSm
 +Luw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+F59Fm3NldFzHsln9R+33haPD9YiezhlMp0sYu9AhfWzo7GMLerFI9u0geEUwH4I0K9Clr49y4@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx23cAUgd5CGNdbh7yEtHtjvyCYvVpcDMRkHCCzEf9PXK96ju1H
 lp1+RKxsPSApn79uZ6mEhv34BMWx0PlidU324f9NgwVrW+ySebmayActrvLzFdj+PkdfWVYjEXm
 g+uIOIXJsVM7wipcdzvRAXpH8Yimo6mI=
X-Gm-Gg: Acq92OE53Gpq7UUyHVCsZh1egDFA2oyP4jqEp3AHUspwPMfnQOny3dp5+1I656uBZAa
 /OrFRA28qF16+NYohCekSi/r2oOcMZWWIPcWIqgliTluwzcd5sUYtLRLZfs/W5VvIeo8Bf4JGkk
 LscZ1mMH1f9NjAcCo5MyLbTviYvbbSKVxhgZusRebhwXgiIQ/O0Jt8LifhAGf8LF0Pd4xIfXI/i
 Ar3TTHUDUj0QQAqzf8p2JU8kNO2rBWud2jtLEwmL46q1Q3LfbxCDmeTygQL5pRMAtK3VRdRsHs=
X-Received: by 2002:a05:6830:6d4f:b0:7dc:df37:844b with SMTP id
 46e09a7af769-7e91c0fbf54mr2313833a34.4.1781765110831; Wed, 17 Jun 2026
 23:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260618055216.56191-1-mikhail.v.gavrilov@gmail.com>
 <20260618061728.75BDF1F000E9@smtp.kernel.org>
In-Reply-To: <20260618061728.75BDF1F000E9@smtp.kernel.org>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 18 Jun 2026 11:44:58 +0500
X-Gm-Features: AVVi8CcdRAiVNAPkl0B3_vJtXygoy8kBQDI2uhJDlcKLkPHtrH-T6C0HJWVrOP8
Message-ID: <CABXGCsNgUaSkfLw1Nn7-BzD2LBUqscQJtce0Wk6F9pK0+Y6Zyw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: do not enter fs_reclaim under notifier_lock
 in lockdep training
To: sashiko-reviews@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 18, 2026 at 11:17=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Removing the `fs_reclaim` lockdep annotation silences a true-pos=
itive warning about a real ABBA deadlock between memory reclaim and GPU res=
et, rather than fixing the underlying bug.
> --
>
> commit 4896f663f62249014930226b2bc964c2419486d0
> Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>
> drm/amdgpu: do not enter fs_reclaim under notifier_lock in lockdep traini=
ng
>
> The commit removes the fs_reclaim_acquire() and fs_reclaim_release() call=
s
> from amdgpu_lockdep_init() to silence a circular locking dependency warni=
ng,
> claiming it is a false positive.
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_lockdep.c
> > index d5d71fd7c70d0..eeb3b5007f80f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> > @@ -150,12 +150,6 @@ int amdgpu_lockdep_init(void)
> >       /* Level 6: Reset control lock */
> >       mutex_lock(&reset_ctl.reset_lock);
> >
> > -     /*
> > -      * Mark potential memory reclaim boundary.
> > -      * GPU operations might trigger memory allocation/reclaim.
> > -      */
> > -     fs_reclaim_acquire(GFP_KERNEL);
> > -
>
> [Severity: High]
> This is a pre-existing issue, but does removing this lockdep annotation
> silence a true-positive warning about a real ABBA deadlock?
>
> While the circular dependency might not happen in the same thread, couldn=
't a
> cross-thread deadlock occur between memory reclaim and GPU reset?
>
> For example, if Thread A executes the MMU notifier amdgpu_hmm_invalidate_=
gfx()
> (e.g., during direct reclaim), it acquires adev->notifier_lock and blocks=
 in
> dma_resv_wait_timeout() waiting for a hardware fence:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c:amdgpu_hmm_invalidate_gfx() {
>         ...
>         mutex_lock(&adev->notifier_lock);
>         ...
>         r =3D dma_resv_wait_timeout(vm_root->tbo.base.resv,
>                                   DMA_RESV_USAGE_BOOKKEEP, false,
>                                   MAX_SCHEDULE_TIMEOUT);
> }
>
> If Thread B (the GPU reset thread) takes down_write(&adev->reset_domain->=
sem)
> to reset the GPU and signal the fences, and performs GFP_KERNEL allocatio=
ns,
> it could be forced into direct memory reclaim (fs_reclaim). This would in=
voke
> the MMU notifier, attempting to acquire adev->notifier_lock, forming a cy=
cle.
>
> Would it be better to fix the underlying deadlock by wrapping the GPU res=
et
> path with memalloc_noreclaim_save() or memalloc_noio_save() to prevent it
> from entering memory reclaim, instead of removing the lockdep annotation?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618055216.56=
191-1-mikhail.v.gavrilov@gmail.com?part=3D1

The reported splat is not the reset/reclaim deadlock described here.

It is single-threaded: kswapd holds fs_reclaim and the mmu_notifier range,
then takes notifier_lock in amdgpu_hmm_invalidate_gfx(). That is the normal=
,
mandatory direction fs_reclaim -> mmu_notifier -> notifier_lock. The MMU
notifier callback runs from inside reclaim, so notifier_lock is acquired
below fs_reclaim and is never held across a reclaiming allocation.

amdgpu_lockdep_init() asserts the opposite edge, notifier_lock -> fs_reclai=
m,
by calling fs_reclaim_acquire() while notifier_lock is held. That edge does
not occur at runtime, so the reported cycle is a false positive. Dropping t=
he
annotation removes the impossible edge and touches no real lock.

On the cross-thread reset case: if the reset path really holds
reset_domain->sem across a GFP_KERNEL allocation, lockdep learns
reset_sem -> fs_reclaim from that real allocation, not from this annotation=
.
The fs_reclaim_acquire() here adds nothing for that real edge; it only inje=
cts
the impossible notifier_lock -> fs_reclaim one. And because it fires on the
innocent kswapd path, it calls debug_locks_off() and disables lockdep for t=
he
rest of the boot, which would prevent detecting exactly that reset deadlock=
.

Note memalloc_noreclaim_save() on the reset path would not silence this spl=
at:
the false edge lives in amdgpu_lockdep_init(), independent of the reset pat=
h.
The splat reproduces with a userptr BO + MADV_PAGEOUT and is gone after thi=
s
change; I verified both.

If reset is confirmed to allocate under reset_domain->sem with reclaim, tha=
t
is a real and separate issue and memalloc_noreclaim_save() there would be
reasonable, but it is a different patch and does not change this one.

--=20
Best Regards,
Mike Gavrilov.
