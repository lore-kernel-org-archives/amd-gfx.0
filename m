Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F212ED2F338
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 15:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F2710E505;
	Tue, 13 Jan 2026 15:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LuSYtyKn";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A42D10E505
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 15:39:29 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12335a3e1edso9233c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 07:39:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768318769; cv=none;
 d=google.com; s=arc-20240605;
 b=Zs/+g75OPNi9fPSYQBQEo6w4RbN0YQRARR6CfdHycNm7Z22RqIuwbeOeJLk/ucnUr3
 rb2CtI1s/cofZe80u6dzot5kYYL2KH+9t3jBF4z0cjH2iFjER2Wj6tGdRm/jGAOR47h1
 asqy2riFByY6bWa+aXJwtvcG3NR4m7kcuo1rk3FbT9vQjtusOk6i9EVr2FhiRilrcGKq
 ITKlkHuTGf+wdzJAuYszFcft28gdDjOitwxKaOZZL82MYjzO3g1AkV+KAlFO2nVREW9b
 83xlk7t1lHdx7KP1wf+fEjFLlAnbHsAJrqraVsUdlDAoajC6urKqNkVzupwHG/BDu1fF
 nnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TUU696zwAsSx9SpETAOzeDQkCweJUcFh/1i1VKCpzEM=;
 fh=mSfvjgL01kZt031qaSLTZcF46r5tuRG6vdNJvzh93CE=;
 b=WfqrCCV1klSC7VaOtjEwDNhK9hRvKgHLIlAjGGPtquvPxxQ9xfS7q8ojfqPqm0Dfrv
 2EX638WgW2ew0daQvJMV4mNXtqlgx2cq9llASWj8nxC1v8gHGrbCmiTTg8MaeIE6kQF1
 dp1qY493bKAr+S+fsrjeqFh3w1VU6NT8dU8S5mukdT5jKc4qD+LWgUeNoqM7VpS6OiL+
 HoffJXWxRv7vymNeyncHpNgtqi9EHAp479prw0yJo7RjrdXBB0v/8iyTnis/T0lbzwVs
 l+IW4Cnds6IzDyu8UBxn4iHzhoYyG7bLIUmvQVlJFuULl4nwlMpn4NmQWs5yglsSCmal
 /EtQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768318769; x=1768923569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUU696zwAsSx9SpETAOzeDQkCweJUcFh/1i1VKCpzEM=;
 b=LuSYtyKn11aV/XEro5WxxxihJm3ITL3zWfNkfsXt8RyAK8TZriHcUetAmN6uB0fpYl
 xIIHbgyJuZ+oHOPlrw2wSeFsOTH+W9sDNmnfxu5yGbUkkhhc/6hvt2ReXmuLiZmvimDo
 vtkFjKR2obGp5/OQ+YU2GaYUxkE+mSOy6pc0e7fxqgcZvL+3iCkJJ15+ry9xtYeH38o0
 CCA7ujr8UbB2iMzQ1YXn9FVbKEdXp0tPkAcxFK8vQGromaCflQmlrtHGxJ/umcfS6FJ5
 llYo5c+T3+3r5qbZxERpXL/9qX+j9w5pQEZhn6dDiKNxEw2nZAXJQiWrn1fiQYoUoqI1
 oggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768318769; x=1768923569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TUU696zwAsSx9SpETAOzeDQkCweJUcFh/1i1VKCpzEM=;
 b=ujp/GiATqEy3ULUL0X0cZxtVdXmyKEONyzSTkHMs6WSNehfn7WtmXUoMsLvqIE5zBF
 9exrlH0v9nKMVlkIflxYfkvD84Jrk5hCmm6VPpY42vh6aGzw3WWQmNuiFQgYLUyrvwNN
 vPK5MAvcWzQO8A2tpQTsRt2OdEerFAw+vn2aLwCiRRMq7OZdu3hrSLPguHvugMZGff+1
 9WBtOEK5kAobarI34Ffljg0MLJSoTCp2G+c3ro4q0vCvPAYYJRBZvUGdMfkoQN254aID
 ER8eCEHx1bCWfAgxyIcHvVCZIyFvTtQX+FKg7WA7/AHDD79yaA9WJAzdoRnHVShZpTPd
 yEXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3Q56X34Pt9GpJmFBoC4tvNwIbFLEG3kEr53cBNBXb6plzAuY9jUWjTdG1uGEMt+HXmet5ZpE6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztkpGdpQx/yYsKzb5Vy1/rd3fRpHys2DxZJj9RWr4uqdbioOlJ
 smbt8aEBS9bvAvuBjklTitPN9rPgeEVoE7t1El1ia341JssicE6MvJyPTPzpgJH+zmLZ315o95I
 6fu9P1lWnkvg2TaR/W1CV5lJYJC7mjG9olw==
X-Gm-Gg: AY/fxX6hULUZqcuY6mT4QVCqaT+BNM6hyGXmAaXBQfjQvAYSpkpHsBMJI2Vphv2Cg7i
 c8jivBArz7hQqW6OSoU064u2H4MR+6FD3KWoNjyRvUY1rj2cF1Ij8R58zmv01vTZHm/JzWnrrlg
 4fLDY91xIImfPB9rXlVWN13aO3p3J+mIqwiR9jBp2NIMNnwyH41rjyroXYa1DWs57K1a6oCgpgR
 OyCDgs4P1zX/eJebd16PLKT2bQiuzxq0sBccypCUT0HwxqnArqwJXZ0QnPjuiEAd/sfj6Ut
X-Google-Smtp-Source: AGHT+IECtj/RS20pEd7pff+v6Yg1lp6/g6pJ3edB9xja3N4cgsETN8kQyZFy64aCAdoqgziLa4k29AiJMXvIh/nxE5c=
X-Received: by 2002:a05:7022:3d12:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-121f8b77078mr10333339c88.4.1768318768504; Tue, 13 Jan 2026
 07:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <20260108144843.493816-28-alexander.deucher@amd.com>
 <73176491-e648-4a8b-bcaf-d40394dad0c7@gmail.com>
In-Reply-To: <73176491-e648-4a8b-bcaf-d40394dad0c7@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jan 2026 10:39:16 -0500
X-Gm-Features: AZwV_Qhsg0mJabbyAbWO-trReNxuO2GbYASRO1lJXddTFC5IDvT8sUTePKFT708
Message-ID: <CADnq5_O+9wLA9_n8jamLA0EpVw4y4WY8FfH9=5pr8SxJkLXRmg@mail.gmail.com>
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

On Tue, Jan 13, 2026 at 8:13=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> On 1/8/26 15:48, Alex Deucher wrote:
> > Mark fences with errors before we reset the rings as
> > we may end up signalling fences as part of the reset
> > sequence.  The error needs to be set before the fence
> > is signalled.
>
> Setting the error is a good idea, but signaling the fence before the rese=
t is clearly a NAK.
>
> Fence signaling can only happen after we are sure that the DMA operation =
has been canceled.

This function doesn't actually signal any fences any more.  I just
sets errors on the fences.  That's why I renamed it in the next patch.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
> > index 600e6bb98af7a..5defdebd7091e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -872,6 +872,10 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_=
ring *ring,
> >       drm_sched_wqueue_stop(&ring->sched);
> >       /* back up the non-guilty commands */
> >       amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
> > +     /* signal the guilty fence and set an error on all fences from th=
e context */
> > +     if (guilty_fence)
> > +             amdgpu_fence_driver_guilty_force_completion(guilty_fence)=
;
> > +
> >  }
> >
> >  int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> > @@ -885,9 +889,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >
> > -     /* signal the guilty fence and set an error on all fences from th=
e context */
> > -     if (guilty_fence)
> > -             amdgpu_fence_driver_guilty_force_completion(guilty_fence)=
;
> >       /* Re-emit the non-guilty commands */
> >       if (ring->ring_backup_entries_to_copy) {
> >               amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_=
to_copy);
>
