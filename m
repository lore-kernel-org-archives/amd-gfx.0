Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2471C77B7C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 16:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B3410E19F;
	Fri, 12 May 2023 16:27:44 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D48310E19F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 16:27:41 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-54fa79be6e8so1836304eaf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683908860; x=1686500860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZlH1DT9WPNSXZP6wf/NL+PY/J20IWNbAtLsUOHSRFo=;
 b=qFkk9PELllw2xYg7VxMAiCVSJsPn1jAalQmr/OmF3olPjK03UE7xh9xQh+iUTEg/s7
 hwDbMtDpJ+/lUYkC+Oc1m6x/D3ntTf45WiPbaMdKhnhanZIzD4UqKk2nUVozc5T5IVtj
 X1OSaS0wRmbYqxYpU05Zg3sCIIIe1bQM0ay8z6UqDe/ycn+/FLS0x62kH6dmyehaxZ8B
 zotDEsidxeqpVz3awUhwSSEccfIs8yleneCxlcpvDo5qa42gseTQxlh1pKpzxxYC9XM0
 Igkac4slJnuUKYgEmtyQMrZkbdpxIygSUwLABkwsyW8YoDeqhVfeNcROnDE743VckecS
 InhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683908860; x=1686500860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TZlH1DT9WPNSXZP6wf/NL+PY/J20IWNbAtLsUOHSRFo=;
 b=c0bL+wWKNrZHqx51ZfrHjh1HhVmx2ivgxxEEICg5+t90jMyYZf1qgbpq98C9NkTvwU
 mykswUcmtK3dtBhJMT80NK6yPy8fI8wxjd3xM5z5oDW6PWXUovlQCPM3mrMmsRg/4Ue9
 G4DfqdTI/B2dWSUFNvTm0qKlg4Iq0z0C+l2LnJLYNzSYQDhWjj8gSEVrDoJpcHohhV7M
 bmhnhnAhkkNSg2wDmv7qEdELyPXwZ9cTZH4IDZNaBGxK5YUNh2BNqr7EnK5qq8AMtzbx
 gI21lU8WRfKK2uEeBpfyN2cJWoXid/bTZnK4Fzl6uhb8/NZVOkEiUYky2IUJjQfj7iaK
 eqRg==
X-Gm-Message-State: AC+VfDxoBdCc9t8takKOuEAHyJMsJrFGHJVsjcp1RCn9vYqFgfBM+jSG
 S9aU+MCmg2h0W5Q1B2X+IZM0Yi9LcOHc7E/mskAvygDS
X-Google-Smtp-Source: ACHHUZ70aquhGAZcv08TyGn8ryHmkaehXC/6FX2GX1dRGNzUBv95q5MOi4bk8HqKVnHezQx4X8jbgyFf9IT1pwKhU6k=
X-Received: by 2002:a4a:91cf:0:b0:54f:7324:d277 with SMTP id
 e15-20020a4a91cf000000b0054f7324d277mr6077282ooh.4.1683908860114; Fri, 12 May
 2023 09:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230426161519.7840-1-alex.sierra@amd.com>
 <d7b97fd3-59fd-d162-5c8c-3e02c0772fe5@amd.com>
In-Reply-To: <d7b97fd3-59fd-d162-5c8c-3e02c0772fe5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 May 2023 12:27:29 -0400
Message-ID: <CADnq5_PK4Zk95-mD4x4Rn9LT7q1MjFmNjO9njpcg6pnTWssj-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: improve wait logic at fence polling
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 1, 2023 at 11:13=E2=80=AFAM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
> Am 2023-04-26 um 12:15 schrieb Alex Sierra:
> > Accomplish this by reading the seq number right away instead of sleep
> > for 5us. There are certain cases where the fence is ready almost
> > immediately. Sleep number granularity was also reduced as the majority
> > of the kiq tlb flush takes between 2us to 6us.
> >
> > Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>
> I'm not sure I have authority to give an R-b for this. But the change
> and the explanation sound reasonable to me. Doing the first check before
> waiting is a no-brainer. Reducing the delay can increase CPU usage or
> bus traffic and may be more controversial.
>

The fences should be in system memory, so it shouldn't affect bus
traffic, but there could be more CPU usage.  The change seems fine to
me.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> FWIW, this patch is
>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 11 ++++-------
> >   1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index a7627cc0118d..9192896239e9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -377,14 +377,11 @@ signed long amdgpu_fence_wait_polling(struct amdg=
pu_ring *ring,
> >                                     uint32_t wait_seq,
> >                                     signed long timeout)
> >   {
> > -     uint32_t seq;
> > -
> > -     do {
> > -             seq =3D amdgpu_fence_read(ring);
> > -             udelay(5);
> > -             timeout -=3D 5;
> > -     } while ((int32_t)(wait_seq - seq) > 0 && timeout > 0);
> >
> > +     while ((int32_t)(wait_seq - amdgpu_fence_read(ring)) > 0 && timeo=
ut > 0) {
> > +             udelay(2);
> > +             timeout -=3D 2;
> > +     }
> >       return timeout > 0 ? timeout : 0;
> >   }
> >   /**
