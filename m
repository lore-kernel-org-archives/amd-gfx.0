Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9C2D3517E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8F910EE03;
	Wed,  1 Apr 2026 13:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gmfrQmlb";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC4610EDEF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:24:38 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2bd801b4078so413711eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 06:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775049878; cv=none;
 d=google.com; s=arc-20240605;
 b=F7zV6PC7mGc9NJaN9EQZc2c5OlKBtx8wj84g4eE4wK+PdbUErcxLPnTnDfsUO2v05a
 rBNJa+DrQm433yGsOyq37oF30brf3ysAmSsZ94oHv8QikIneH7fp0flxcKJ5Fc4R0xb/
 YpAPXAAINMe5v/umFPWp/BvFa6KB5LJhVV4q4Ih3Jf/a3ZhcyQRB1BigeL0pp2wP4tGM
 +36+/YUXm5TbZC/2tLUy2zB4AElpBAS++JTYv9VQh2waw22BppvIc2mrgskUEnRiXws6
 rC5cvHO90+ZQciljB5CfD4hCLdZWqcId+hzzmjqESI/N5c+u6R6X/eXvle2F1is2A38p
 1NEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IDufKBR+XlMKiQydxoWaasabDEo99JV6htcx9j+jpD0=;
 fh=ydNJQwnYAjhV1IPFI4BKR10SrbLuYlSE5hcqKNPwFbU=;
 b=gPcpU/6C4/67h8jo2txekyqhksFZ3SfmZqi0obbK0dv2ucwf67gc39p4vXw2KNHeah
 BlXN2tHXwQawgR/N0YhzQVp025dEWjBZtWzQe5KrWgp7jaKan8fzrCWKXDpoTZXsGZQb
 q3DDKVbzWc82X+mdOHGg4+K/gBiEzcClRBeOaw1gApkS52U8cFN1lbURdzoVK5pRP2YI
 WJRVSShMHC+SABCDnL/IIThmA69kGQnffq5BmCh9YFnGpkeuwk0IKS3cr3u8XMlcz2ZK
 caa75kKXnfmULCebGW/3Ulu+WUVSrmoUy2b35MmBspLUxw0NQU5cwQHqJR6Lar5CDTm7
 ZErA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775049878; x=1775654678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDufKBR+XlMKiQydxoWaasabDEo99JV6htcx9j+jpD0=;
 b=gmfrQmlbyZzmhkcpL+GdqGkaTBYZLziies2af9/CWfCR9Tf7CXjspgsAkX9AG3tRZc
 0wl4v4MQ3ipo138bq5grC95K+tyohHxOjpahLaTj57jkorE8s//7hnUPVqZaBJEDNtiw
 xyElzhbUv44e/3BPF+1cl+wy+utyflC+T/MTt0gUZSTyVO7xWeISyjipO86f7YsstPy0
 WcP1zWYbY6gMCcjOFDwIOhZhqJNvpGu/5aCMbtqpfJFtyi/jGWhquKo2rHiZuYoq4X65
 2Ohau5+1n15ZjPZF7uufbHvWxVHsUMeTl/ZpI0k2KmjlvfTnj6Rfv1ciyz/YzOMfc3j2
 Uoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775049878; x=1775654678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IDufKBR+XlMKiQydxoWaasabDEo99JV6htcx9j+jpD0=;
 b=tFPTId+aVHSoontLTFojKBHc9ZNzh7mrlBRXZ6UqPP6SYVALLSpRzduSOnL+9m21m5
 JDqhZ/qurA0W89Ayl+JAz2G9IjuwOkvSQTww33mS8kuZ9BszltEMdtshHDQ2vBh0zIDf
 HCLQww2NR0rAMNP5qFrzozS9OtgKvxGeL3AtL5RffBelHk8mKiOBvePknbKJo+/TsqWe
 YNp9+13E3yjA90v/IEPoVhKYO5BVryieM9P6Os+U57HyCFkFNfQTLA7+CQCyAnVSC8ZA
 nHrFJ+RMyAlIT8uxv3JkioXNI3BSKPG5fghuQ4nt6Mptyw/FxK2Hj/X/Chp9RTcjvxIn
 nwew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh+CcTL+t4LZaKKoObkZ/7Tq5oXF2THAGHB5+j+bSnUJ5SDuymScDFZHCR+1HF2QZPDcEIBBlc@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3e278k4CS6DdS7wuUzfGxnAKnVQrUqFEVoK33c3kqIAC+MrDE
 FUKUxB6Q9dxSzcLR1nCExNoKe2Y2feBFjuGepZArEdJ2x7rC5IB6C5jtl10HvMSbHLwtpgRMyb6
 rj7avEmQgnrbhiqpHv928D9+QMVoklgo=
X-Gm-Gg: ATEYQzyR2MuaYjV2vT0jjFy8BDkXtv0WJhiCtuUuheaIcYwJfTC5CbMR4oJHdlHgysv
 cLMyYVO+kF1KZNnZS13IQN7njDDKavJfuHvVsPOwDJixhKYHNl736WGfkS0AxTqP5nIgrPkPO1N
 rBrwG2kr3h+x5PAhxe+WHBX+hc1YmG6G1EZGrKI6cezlAsxQ6x7dX0tfYlKdRouY7jvZWynXUgu
 VFOeCw5Fiod0j8DcyHBDch1mW0MqA8wId2tg/vCoQr4DfLM57pplU6+x1DzZinvwB+q5Ptv7Oyz
 Tb3qS91zDABsgUUhFUuirqw6V2wx88G2totiT5wdE+mKF/j8sY/l23GNuUBo+zfJrv41AA==
X-Received: by 2002:a05:7022:698e:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-12be62e92f4mr1007497c88.0.1775049877886; Wed, 01 Apr 2026
 06:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
 <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
 <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
 <CABXGCsNcRQnQmsZJAhfJPsR71HXU5+CG4URJiX03xkPJD+f7SA@mail.gmail.com>
 <d37e1e34-8a9b-49dc-ace5-76f23c0375e3@amd.com>
In-Reply-To: <d37e1e34-8a9b-49dc-ace5-76f23c0375e3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Apr 2026 09:24:26 -0400
X-Gm-Features: AQROBzDtwC2uHCPbn47xrdsYtCW1ppTW7fCCiZAyw4rC-_YtNNFBrKFHsMlI2hU
Message-ID: <CADnq5_MiwKNWOMfWZ1BGRYQyeAeih9SiHd44Y0QGL=tDKmp64A@mail.gmail.com>
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Apr 1, 2026 at 3:24=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 3/31/26 19:12, Mikhail Gavrilov wrote:
> > On Tue, Mar 31, 2026 at 7:38=E2=80=AFPM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> >>
> >> Applied.  Thanks!
> >>
> >
> > Hi Christian, Alex,
> >
> > While testing v7, I noticed that xa_erase() and xa_alloc_cyclic()
> > use plain xa_lock()/xa_unlock() regardless of XA_FLAGS_LOCK_IRQ =E2=80=
=94
> > the flag only affects lockdep annotations, not runtime locking.
> >
> > The XArray API provides separate _irq variants for this:
> > xa_alloc_cyclic_irq() and xa_erase_irq(), both defined as inlines
> > in include/linux/xarray.h using xa_lock_irq/xa_unlock_irq.
>
> Ah, crap I wanted to double check exactly that but then had no time for i=
t.
>
> >
> > I confirmed this by hitting the same lockdep WARNING with v6
> > (which has the same locking), and by reading lib/xarray.c:
> >
> >   void *xa_erase(struct xarray *xa, unsigned long index)
> >   {
> >       xa_lock(xa);              // plain spin_lock, not _irq
> >       entry =3D __xa_erase(xa, index);
> >       xa_unlock(xa);
> >       return entry;
> >   }
> >
> > Should I send a v8 using xa_alloc_cyclic_irq() and xa_erase_irq()?
>
> Alex already applied the v7 so it would probably be best if you provide a=
 delta patch on top of that.
>
> It's then up to Alex if he can squash the patches together before upstrea=
ming.

I dropped v7 so I can either apply v8 or squash v7 with the fixup patch.

Alex

>
> Regards,
> Christian.
>
> >
> > Thanks,
> > Mikhail
>
