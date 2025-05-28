Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49CCC5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 13:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6BB10E2C7;
	Wed, 28 May 2025 13:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ERnycNVW";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0F610E2C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 13:41:32 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-31141a8e6c9so604115a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748439691; x=1749044491; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sx5nlVuV0fzHZVTbjBHtQUDx9njAP6tFWGVXAKYcVjw=;
 b=ERnycNVW7Yk52OmJFWFN6HuJR+RWCKAUhIuSswhBADTU2Fk/BenQiXbN8F+WGj5g0p
 Akam5j3crUfqEFJtP8easLSMu8i1QvafySvr6XY5bCwhPCdW4ZQAsKwKv95+aFb/1ipC
 L7oU/iMicDfqdWFBklWezlTjC9GuSqtJcVPKf5ljCWvnFg215IttyIhZShbI+5/G0/fY
 TP2Yejh8+vC8aP0vkeUbbYTvtsHyfp4min0O20h0EzGk30444Kp9dWWQ82EZcbnv9g6W
 JCYQ8lCL5dXjs290shaubjhca42jIWx789KbEaZ6sCbCXv0WFlQ7kVwMG3/UPEsD2v5Z
 oh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748439691; x=1749044491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sx5nlVuV0fzHZVTbjBHtQUDx9njAP6tFWGVXAKYcVjw=;
 b=lclEi9h1wL/PkJhYMtM8YkdpK8cpRO9515pUActi7elRiMWUED/DQs6vU5xaiJ9TsU
 2p2vMYkXO8IfJt3w36gT6c2bI4l4rhYOy7nNAo/Q7R+v/e2k7EgMMjgr90y+mvP/kvz4
 HZembYKxM/ZOUv/aJgb7P7ROVCjgDgMvDRy6KszahHWoSFCZeyEbSbk/cgWC4Ivnpnum
 UvdaxmFP6qT8FMxob6TaBeHwB7mwHXh0IqbZRN6MygK/cJMuLvKZgEZ4HaL3/tpytjLk
 tpd1XLoVWstWL+Q0ek3vzKwK9xbv8HJKSyJyhBKnDAn8t5Fe+aQfz7kNM4ugtKBb+HW/
 bA2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiocXHXoxc9RutXD5E5s2Z4Kn/2njmPiLJ86pxPxEQ0ofNA2bVr40aGAfPafpGwn0V36BLc6lo@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8p1vAGY6LeU/hX/JJu1ssPI5rZqTxFY3zwUcoOyQsaDGVmFYH
 4vU6af4AksddU8ks88+2eDa9Ksje2pAuDYtVSMX9cRYhbUpAhwlCNQbaKMgDOWhb1js970JWqUF
 K33AWLwoqHiXHw7O8myRXU0iu1k6znck=
X-Gm-Gg: ASbGncvGjdBXiQQJbWOUFnX04ij/pFzdUSSD3xvwyihW6QcucXAdBr8gG7To3lwYZow
 S91pUWtIV2ZSJ/KrSKVkBB1wB5R9/+t+UfXv7J09jTVHuc5d2W/+p/CedWPZpSZQPkbPZYi78ix
 Ku725niuto7w8QnDwsLpr8KAqievBZjsL/SA==
X-Google-Smtp-Source: AGHT+IF508vbAETVItJVIdCf21lRIsE4a1QDqjK2vm7egmUasPLo9sZdbec4dNv0vnVd9e4UeWGNEsU7s5v1F3AOEH0=
X-Received: by 2002:a17:90b:388a:b0:312:639:a06d with SMTP id
 98e67ed59e1d1-3120639af74mr340627a91.5.1748439691510; Wed, 28 May 2025
 06:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-11-alexander.deucher@amd.com>
 <7299c780-8d32-4840-91f8-0056d7acdf52@amd.com>
In-Reply-To: <7299c780-8d32-4840-91f8-0056d7acdf52@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 May 2025 09:41:20 -0400
X-Gm-Features: AX0GCFs9lqa0cSxVDYETA07G-VO3v2ztAdbZNANHP79y__4HdHL7x0ox_LfNELs
Message-ID: <CADnq5_PaFMC+VxnDmeqXZLqj7_0ifwgLpVB5aVw8x3VghK2VaQ@mail.gmail.com>
Subject: Re: [PATCH 10/19] drm/amdgpu: pad ring in amdgpu_ib_schedule
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, May 28, 2025 at 7:45=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/28/25 06:19, Alex Deucher wrote:
> > We'll want to include the padding in the wptr count
> > for resets.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index 802743efa3b39..3e05e8bfaca4a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -304,6 +304,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >           ring->hw_prio =3D=3D AMDGPU_GFX_PIPE_PRIO_HIGH)
> >               ring->funcs->emit_wave_limit(ring, false);
> >
> > +     amdgpu_ring_pad_to_fetch_size(ring);
> > +
>
> Hui? Why that here? amdgpu_ring_commit will do that anyway.

So that I can know the full size of the submission frame for this job
when I grab the follow-on ring contents to re-emit.  See the next
patch.

Alex

>
>
> >       amdgpu_ring_ib_end(ring);
> >       amdgpu_ring_commit(ring);
> >       return 0;
>
