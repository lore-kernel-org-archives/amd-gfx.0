Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99CBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 15:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8BE10E187;
	Wed, 16 Mar 2022 15:56:12 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB2610E187
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 15:56:11 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 x8-20020a9d6288000000b005b22c373759so1689335otk.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XXH/+AEdX01vjwLqulKnJuqOMOnl2+sbuRXE97u32t0=;
 b=K0+6alab+8bCwxHjelKfLdOY8vfVVnXjaTP5DmXLmt2goFq6wbzF4tdnaYKKLQcxQL
 iEQqn4s14h+vtPbSVxzVlmnrAeFuEydY112gTd+SGFk4ptgsZll3UmNcoind3tTyblyK
 TuvkrY5Ve0CuG964tpqHWXFBHorMvU1CEUx2BoBljk6HKbEcq6MAJHRmYZ7oPXovZ2lP
 Hc5+4zSy6ZfTU0ADVg2yMIivdZzaxWFUNsql7qv27pCQIAvsU0OvmBDpwWPluqM7vw8H
 RxG2XpftnKLUnQ9jEHFdCU8M9Voxc71xpGDioHRLdUc39OvTYLfe5fxZCygXWrKICbu1
 cbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XXH/+AEdX01vjwLqulKnJuqOMOnl2+sbuRXE97u32t0=;
 b=Hs51/RzXTfjKLtuFJFR3fjIU+5/LzeRpIeSrTsPjGFyV8FIplfKR5g+hihwnkD0p0C
 u4aMi2vP9KUrA8adN21p8qd5YBU7+KmKxXC+2a590bFPAMjV0rZAAaS8C1ShHyFTJu8b
 HLNu04kkb49E3jEBR9HwW6a/3wSZAEz4GRQd4T/etua+ubhy9Up0a5TrtNpnOmhCIH0s
 ZjZS9BFURENDtJEYpRhJ+rzI+yPXF+Cq7un9+72h3NyVNexk8riIk86a1a8ZScUIYAh8
 SP2lk5B74BCUbPyExan1gki9L9LAZVPc860Th6cPwOihipi3oDRGUNKFXDCMrrbywG9x
 Dt1A==
X-Gm-Message-State: AOAM533KNHhx4K35b065zB6cVkhApbgwXp8sYIIvrurn5wjkJxHFQJg9
 ElS13GvCO42A5jGBRiB7MDde0ef26uNZyXup+4I=
X-Google-Smtp-Source: ABdhPJyD7YldfQF9TcHLIs9bI7IOr+gG9UJ7tKAfN0wPu4AioYqR84COI+xSkQ9j1GCJocR62PE4QP8MEKG/GY7NMc4=
X-Received: by 2002:a05:6830:2709:b0:5b0:196:dcf with SMTP id
 j9-20020a056830270900b005b001960dcfmr222840otu.357.1647446170224; Wed, 16 Mar
 2022 08:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220310180615.2245997-1-alexander.deucher@amd.com>
 <ed66fa3d-51c8-1cd1-8709-30f66eb82fd3@mailbox.org>
 <541dc1eb-cf50-17d2-0ae3-5c3cb3dc3ac0@gmail.com>
 <238d136e-d060-d1b3-57f9-ee23b00d5ed9@mailbox.org>
 <0fc2af87-4c9d-f2b8-c14b-703299fc6367@mailbox.org>
In-Reply-To: <0fc2af87-4c9d-f2b8-c14b-703299fc6367@mailbox.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Mar 2022 11:55:59 -0400
Message-ID: <CADnq5_MBK2VP9A6r1MtiMFvBrmO7Tc5Y=RtENWoEhopp8BY3aw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 16, 2022 at 11:52 AM Michel D=C3=A4nzer
<michel.daenzer@mailbox.org> wrote:
>
> On 2022-03-11 18:43, Michel D=C3=A4nzer wrote:
> > On 2022-03-11 11:32, Christian K=C3=B6nig wrote:
> >> Am 11.03.22 um 11:24 schrieb Michel D=C3=A4nzer:
> >>> On 2022-03-10 19:06, Alex Deucher wrote:
> >>>> If the GPU is passed through to a guest VM, use the PCI
> >>>> BAR for CPU FB access rather than the physical address of
> >>>> carve out.  The physical address is not valid in a guest.
> >>> I think amdgpu_device_flush_hdp & amdgpu_device_invalidate_hdp need t=
o be modified accordingly.
> >
> > I'm surprised you gave your R-b despite this. Surely the HDP cache need=
s to be handled when going through the BAR?
>
> I'm a bit confused why there's still been no response on this point from =
either of you. Are you guys checking internally whether or not this is need=
ed?

Yes, it is needed.  I added it in v2 of the patch.

Alex

>
>
> --
> Earthling Michel D=C3=A4nzer            |                  https://redhat=
.com
> Libre software enthusiast          |         Mesa and Xwayland developer
