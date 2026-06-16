Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12184CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 14:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F92910EBB4;
	Tue, 16 Jun 2026 14:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sukjkZDt";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02A110EBB4
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 14:29:42 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-304d3d3d8f8so563400eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 07:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781620182; cv=none;
 d=google.com; s=arc-20240605;
 b=CTOgiYwEEFXM+a9Xepq+B22tNCNUjZDS4Gzh+eyYj3QfMZZDkyuTXYxpNjedHP1tUa
 YuwG7sL22vio65X3z0sALD23/ixIRxL2SHktCRLNCKCE9tG7nvZ+L2wkhdY69bSLhigJ
 +mxwGuXSpBLCJ9QwO54t1hTLvWr27Wx2QMmOHVUWHK4D+FXN0M6NEKWjYMR4mIy297p1
 hMkk6UZNxeh0tHNg8Zy4kzI4mbZYQjtBcTG7xp6QhgPn/CFp0sAUI4V5snq0x/3nfVCq
 kTTSD7LaGUivLD8/Mn2YAUWwWO3SfT9cH3j0eyj2KZChjGutllCuvAjyNkyrU1ciWK8F
 EwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vfJJneV1qILopKt6f5xWlrSyWb8ZZ42PxwlpIru+T3w=;
 fh=b2zUEOVqwzNRSKvBZVdnjUzPMV9XcOolFj7HTymr1H8=;
 b=a3i9mzOsfrIEyR9FGGyYk2PdfeWL+dLrtkec9iS6qfYNLm5TABD6nVOzuBsfvRKZoT
 YgWSbfNCvswlQY2XMrQiIvhBA/yu0RsAmug9XiceOgA4KlSf4/6Bvuh9ICS543LpZgwK
 jbAwBPush+vLv5zihagxFjhzpxiN4yD6Q1XARRJtDTF8idFPiQbu7EfQ4Jkw35VuDvql
 Hm0uEZEg0juRgKxJivEQgf2xprwumVIoDl8FhtFh135UEvaCuTkjS+nwhmgGSoGBtkZ9
 F1z0J11TxhP5GykC1jHhyEMT2YFzYnKx1DPm/tjg6JhJwbADKrb8BShEi/t8OeZmsDi2
 e59w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781620182; x=1782224982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfJJneV1qILopKt6f5xWlrSyWb8ZZ42PxwlpIru+T3w=;
 b=sukjkZDtpl8drNEzeFlgS2dgoj6kKIRivwK9EeODatqww9TvIE8g6dhcGeMMRq8x5Z
 ukm4QZJt9edjeKBm5lnX1MStQK3mTGHjzVTTXJerCnKQ71OUVctZEnnupmz0cY2KuLiG
 rt5cYmpK2g1N6hAjCC0BdcCNUldEW4xkppkA+m2pcpb9jvRPc0SxPFZiUXSFAshi9v2o
 TXQemj/NQlh4F16qu0b9FYUpY+HuWYCwVohMCF/+wzgXxMWpu3xzDBkYKu/Dxew2mHpX
 2BUc2SmRebC1QF/b7OoiwILAh1EeAzZS9JVf1LIFkNuVrc6uBiyhg4O+MvwabttWx5vj
 SjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620182; x=1782224982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vfJJneV1qILopKt6f5xWlrSyWb8ZZ42PxwlpIru+T3w=;
 b=RrJV/S371VF1Fde+3lB7ECffAc2Y+Nul/f2qKgH/gn4NkvuF6A9RXNH0l9osUTgPV8
 e1X7PTtn98RS4aXeY0YBO4JJz+yQJnI3wi5TrGOZ5PsVzGK7wnhjc5g5ahQRydG9nurA
 xn+HcniLUs3tdeKLoo1rH217dmqIufppGgT6xSaqJbhoOBC6OKwBbIdOovf2FCCpbXKc
 8Ka85oDcndVdVonLWtriWwXhwS3nTlVdZNC66wMcs+SuGaelLxkS4EI9dYfEvJ0Zgjs6
 pT8V7F0wJIEBFEmL40w36Wn7QNy/8MLDXwKOjzxgiknKSjfWAHnqsET8678jaEqTkjrq
 lkHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IkXQtIcu2+Fe9CjHuk9Wt+qGkagpD7nyCwEsWU6xdrx1yMwc5SzBFVNR/T1qRKD00bDD3wYPP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcXZgnMK4qmx/41aZOz8Sys4C14cPoAVjx+REftmqJqAg0HKSW
 F9tU3YiZ6YYB0ZUCNPgV00wRm0NBfmkSxE2Vujs+NTELJ9Uyy/jvcAyE7rZmmYaAXhg2T+na/lr
 1tYK2/iN1KAAZ/7qRSjknCHCxwmw+Ya8=
X-Gm-Gg: Acq92OGPAB0GpssEcC5g50ZPwvjDws5NJnBPG4DJo63+yUFhO604MqXsbdZu8ggAG2I
 vDZIQ5RuxaNJbpoY2vx3P0/+BpQDGmnpuYHc9eZCnRajDDMaq/nLuFZIa7Tpt0r5Fe1Fl9o/GR1
 2B/XZRg4U33zNQXC9vEndKj/+0Q1wD132NzqXT9elehZEpAthQ+FnHtYToGQ40ogMoJhy3U2GH2
 Jon36V07jf8wftjaGkSI66ahATyS+UDHqfpEALFr5v48FZaCuSb9eqER4sxVb9o/gZgXA4Us85i
 M3dQfJI70keAo2I9UJLfful2Qk9gsdjCB+NaP0+rnK0318GDc7Ttqs7jcV1eVV4xycgFng==
X-Received: by 2002:a05:7300:641a:b0:304:1d92:42ab with SMTP id
 5a478bee46e88-3081ff5f11fmr4963849eec.2.1781620182010; Tue, 16 Jun 2026
 07:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260513170849.27061-1-timur.kristof@gmail.com>
 <20260513170849.27061-4-timur.kristof@gmail.com>
 <ae08836c-95b6-42a1-8173-108c5b4b5925@ursulin.net>
In-Reply-To: <ae08836c-95b6-42a1-8173-108c5b4b5925@ursulin.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 10:29:30 -0400
X-Gm-Features: AVVi8CfGTbw16bkPB21PY2ShKerlWB9of_zSgHLa-Rl-yER9a55QDZjvt5ovvcE
Message-ID: <CADnq5_OZbTwce-xioZmsy6isWPp2ZKh+vCvUuD0JiABteesRyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Use system unbound workqueue for soft IH
 ring
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 amir.shetaia@amd.com
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

Applied.  Thanks!

On Tue, Jun 16, 2026 at 8:19=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.ne=
t> wrote:
>
>
> On 13/05/2026 18:08, Timur Krist=C3=B3f wrote:
> > Allow the kernel to dispatch the soft IH work on other CPUs.
> >
> > Otherwise it can happen that the soft IH ring fills up
> > before it actually starts processing anything, which
> > can easily happen with retry page faults, in which case
> > the CP repeatedly spams the CPU with a lot of interrupts.
> >
> > This significantly improves retry page fault handling on
> > GPUs that don't have the filter CAM and must rely on
> > software based filtering.
> >
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_irq.c
> > index 82bc6d657e5a..515fc32051c8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -549,7 +549,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev=
,
> >                        unsigned int num_dw)
> >   {
> >       amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, n=
um_dw);
> > -     schedule_work(&adev->irq.ih_soft_work);
> > +     queue_work(system_unbound_wq, &adev->irq.ih_soft_work);
> >   }
> >
> >   /**
>
> Look good to me.
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Maybe later we can consider a high priority driver specific worker or
> something but for now moving away from default system percpu sounds like
> it addresses the problem statement.
>
> Regards,
>
> Tvrtko
>
