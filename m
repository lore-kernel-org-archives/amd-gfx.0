Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF1BD30CC1
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 21:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B951D10E165;
	Tue, 13 Jan 2026 21:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jrsDGvNM";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE48310E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 21:23:14 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-122008d4dc0so368250c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:23:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768339394; cv=none;
 d=google.com; s=arc-20240605;
 b=MpfHVTFcm1r0Pu5NRKex7PwIyvOJzRECYtdTGeiw0p5/jeblcs63YWaRhP6CdT/7yV
 1RGcFNe7ncmJWAkrn1Uv8hm/1k7w2tqFnghRfYZbu2l5UZ9iPHrCtJZqKLbzzmMZffo3
 Fcv52LLuPj3UfG5OrT42sVrP/50gO0qLZZ5mhsjiJNX18Lvr1zQBFn1NMsS56RZRt0vJ
 RQC6ld1sD1Y3vEfYOxEuT4T+exuFWx4/DGolwOc1FCdpdgy0ib7b6C9CVINJowoaZQlb
 cOkS8MaEzuWnBFZhhIz5nNAEe/YzTSVrx7hSylBbovhwFEDav0F+Sc9P/UD+OB7n0nsE
 lwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RXsZLSEG5OvY/ugwq92hC44nKU98a/G97p0FOCYnOgQ=;
 fh=gWI5KnsOpz9fwpUwkIgat+YVpFBrLZ2GvT9yL+HM51I=;
 b=HAZkoQM6Cg7PRdboXrjPUKSO0vLKWNsEfIXoqF9qQJMkrqW17d2fxHDl6F4r+WanC1
 /m2wM+tPxZo0Ko3Q6DJRAzRmsXe6Y36NTfh0B4xENjVOVw347nIY74VUVfIKg3bMFm6H
 xqgqa3g5KF7GgG9OB46h8LBw/Yb3NpqL1TJIjzDIrW7b7B2anf8fyqTv3iR7OMRL9Y+l
 4TWcEMNhU2Su//lWq2otEYM4HlCP3/Y6yPQCTCOdm65ZNRjaSc5rMK1Em+yY2ts2e3RG
 fXvOS/bjyCZUbumOpxeefT9JtKbnqIKN45SZcf9kUg64eMdk40FDk3rwm7duxq1fdh6h
 YgDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768339394; x=1768944194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXsZLSEG5OvY/ugwq92hC44nKU98a/G97p0FOCYnOgQ=;
 b=jrsDGvNMfs4Q6iTr969GSS0cyG2MtnNifSfu6bmPuMkqKt021MXIHnqwt6GIMMc3i4
 47gyh3sihATmEkUbOKIy18Xh++Yb4sVHcYfdmf3saaiLGJq2eOb3tW02OpGutHWsfpsl
 lLWI/7b+y097DlNr83iguqW/bs1gry0T/dfkM4ewrUxQBR/pehcjMcN6suD5C86qfakT
 s/kdE6lBZYvzv/S+PAdrhFxMX5dngff8bntWq0GtZfYFXNhKEtltWBijCsIICDCQazyg
 3OgY31eod7rUdXTGhnRTaT/cAVkS7lgVakVrsfm5s2BcDN4VVBRHVMzT/66Pof9pQH9M
 w1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768339394; x=1768944194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RXsZLSEG5OvY/ugwq92hC44nKU98a/G97p0FOCYnOgQ=;
 b=WpEXARVhfycbKj5Ajkh0csdikHVK9vFnn0dlPxG/weNslxo52qsfb4qR4orKQH13S5
 zTd8wA57q/vgm7lFMiJe02nptomIuzfajy2QMRi9JxXxVQLHSYqBvH63psJ8W6d+y9ew
 jwsBGnrrMLVmNw+YES2KMQXbKL2u6a1UVoeQ1HNhxZEo3uetdKdrryLd+SOE9gLpZf9s
 RL2USZjEkYvnDdApSkmiUzX3iHpKvZDwKHvO7ubeoPg4YyEyuuy0hk/YLsgs7nobbS/l
 BbpPQ4OTG/JXh2MDW9MVy2pAlfOszaYEDx0S5McEGXaAZysr8mo8YRmvPK2s4xno66H3
 IMvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW35CQ3kaF4yUQQfiQk4g7uFNHMsOSt65nQ/mZaXPBVHvpH7CaUqpwYeV1spGugquW3KYu/eMsK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCk+n2U/z6xBg8+p+BiPvCj1at293kVeftvxTkTeC/4rGASuU7
 yMTR9Ule3U6EUDOIKVhMiITw+rrubWVhaklw+QHhtXmM1iMEGXH53r1CcfKZ1+ptpgVV0FrTZuw
 GzmCK+k/8vMccRhnv62pb3Ld0sjdUg8M=
X-Gm-Gg: AY/fxX4x4oEYnAgVlbJGSna1XOChbl+2DY44EFtgcjciYN724whc6JaSiWxEPRV/8Om
 /N+5aYTLIazqL3cEz+8dedxci9k6NHe2HWk1CVnufQuEA1QIUzdL1ysmQxz/AWpf9CluNgBIuNS
 cSlt8IQcdGkxUdK3RJozC6acH90IodCDSoKpCIbEKCkn8/awbqQsRyp71ZvOqwn+LcLv8Js9Zec
 Pf4rST4JOpEPZ9Qad3PXoRym0fY0f6U416PVM/KuWOmehj9Q0Kld/kkIvN75fMbUGy66OqR
X-Received: by 2002:a05:7022:b902:b0:123:308f:667b with SMTP id
 a92af1059eb24-12336a2e6bemr180412c88.2.1768339393894; Tue, 13 Jan 2026
 13:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <20260108144843.493816-28-alexander.deucher@amd.com>
 <73176491-e648-4a8b-bcaf-d40394dad0c7@gmail.com>
 <CADnq5_O+9wLA9_n8jamLA0EpVw4y4WY8FfH9=5pr8SxJkLXRmg@mail.gmail.com>
In-Reply-To: <CADnq5_O+9wLA9_n8jamLA0EpVw4y4WY8FfH9=5pr8SxJkLXRmg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jan 2026 16:23:02 -0500
X-Gm-Features: AZwV_QjxiugsPsMJInqe7sneWGIlUDnyz_R_VLezCMVMzi7PC1uk5nOOr84fOHc
Message-ID: <CADnq5_NECdibuaSwKHjg0MrPPSGEN2zcLydiYedpfraWnMz3Yg@mail.gmail.com>
Subject: Re: [PATCH 27/42] drm/amdgpu: mark fences with errors before ring
 reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Jan 13, 2026 at 10:39=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Tue, Jan 13, 2026 at 8:13=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > On 1/8/26 15:48, Alex Deucher wrote:
> > > Mark fences with errors before we reset the rings as
> > > we may end up signalling fences as part of the reset
> > > sequence.  The error needs to be set before the fence
> > > is signalled.
> >
> > Setting the error is a good idea, but signaling the fence before the re=
set is clearly a NAK.
> >
> > Fence signaling can only happen after we are sure that the DMA operatio=
n has been canceled.
>
> This function doesn't actually signal any fences any more.  I just
> sets errors on the fences.  That's why I renamed it in the next patch.

I've reordered these to make that clearer.

Alex

>
> Alex
>
> >
> > Regards,
> > Christian.
> >
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.c
> > > index 600e6bb98af7a..5defdebd7091e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > > @@ -872,6 +872,10 @@ void amdgpu_ring_reset_helper_begin(struct amdgp=
u_ring *ring,
> > >       drm_sched_wqueue_stop(&ring->sched);
> > >       /* back up the non-guilty commands */
> > >       amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
> > > +     /* signal the guilty fence and set an error on all fences from =
the context */
> > > +     if (guilty_fence)
> > > +             amdgpu_fence_driver_guilty_force_completion(guilty_fenc=
e);
> > > +
> > >  }
> > >
> > >  int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> > > @@ -885,9 +889,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ri=
ng *ring,
> > >       if (r)
> > >               return r;
> > >
> > > -     /* signal the guilty fence and set an error on all fences from =
the context */
> > > -     if (guilty_fence)
> > > -             amdgpu_fence_driver_guilty_force_completion(guilty_fenc=
e);
> > >       /* Re-emit the non-guilty commands */
> > >       if (ring->ring_backup_entries_to_copy) {
> > >               amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entrie=
s_to_copy);
> >
