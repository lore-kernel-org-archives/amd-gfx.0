Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1F4D10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 14:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B359910E62C;
	Wed, 26 Nov 2025 14:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CMsi0yP/";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BD310E62C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 14:11:54 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-bd2decde440so567902a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 06:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764166314; x=1764771114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4KX8kkoKGabs7/UIPDv5W3WxdgStnYcf8g2pgJwzjs=;
 b=CMsi0yP/l6pV4UGiG16gZaYuZ1i8mWraPPZjBJDNSxKYC73F8Vjb4H3JscQC5M8iPl
 heLbSvezp/weU5mrOp+zLvZeRlslMhNoVg4oXn/h27GwGPgMCbl5qpoUG1YJle6wBxer
 7bgMsIru6f5tH7IrIOC2ea0hPdXj6iGnundFupMhMQ+HOgETLf7CDe7cTqm4cuJ8bmPc
 FG949PeRfsqHAg/lYSsjyYNkFyBXtXXSD8FFnzInQ/RFib+y5T6cwdZlfI1hF8jeL3Ki
 aP3nFCqRfpFtOT4CK9/D4YYiwA6PYf9HRTobtO6TPrFH/dl3fejpwzFPFVRm9n/9utkg
 1Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764166314; x=1764771114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g4KX8kkoKGabs7/UIPDv5W3WxdgStnYcf8g2pgJwzjs=;
 b=OetB43vDL3G2hgC08S0b7fOzkgCx+5CFCY4w84ujMZqUrcvd7rCrrti7SU3JA3/WU3
 pmFaigLi/WfRiIqBmGuql03xoN2YlLZVHZ/bjxa9Xuh3gFTHCKv0D7ojEsCST1VJqBsG
 8ZuRl9yYNOdoML0IjgZxRFW68ZCWFP/qu+CmiImb4lCiCQDIZ2U050cYdfyQetiN778O
 aTQo7zQfVxxzY+6LmXB+By+5SQ/DIRyQ0Rbmd0/UsiGDmkzI3cKdzIr8yrQs2u/dLIr5
 PSoayfkpLnEW3zki38HUTyrJEf6wfiJ46cOoJTTYAkN44vSNywIqX+izx4fUmL1FGAAM
 qfmw==
X-Gm-Message-State: AOJu0YwwzftHrahWyc0J8cIotPpP30tJBWKBFGTo0AjSHk2ikG/OYS7d
 ULPR6SLSq30H7xazqN4BkGn5Q85/zGX/Qe5PLnVzy2wsm1RpADzocvtfkEtvE/Ug5M9YPqP0KmX
 Ii0m9CGWv7YjzUW9jbeggWwWr7rgInGk=
X-Gm-Gg: ASbGncuOC/VF1ECDpLjOeNBPwg0MNe+FIA3uVHyuepxkUFB+iL8W0N7LVz9yMQzQUAF
 gAS0wmWp+CXQ9lz8WiyrP0PIRE+9D7vOM1Ndpbnlepy4sAYYJ357XkSI/VPM9B9L1rVpbJUnign
 WfmKR2geh3kgz1MajVAiJOC+NSArFXl7QpUnCxftujd1MVjuGi/BBPvSkRACrl/6eCNCdgWKxFC
 fUyzaEuFDLatUToXB+pAkAjd+XZJlViAoAtE0gIcUF2fwjLzSfoeQlhutlLg1YIfksQWzs=
X-Google-Smtp-Source: AGHT+IH+e3fGPMQ5wQR3Ea1n7bEHPFhLDg0++sOAQRow6KXaMqAhUMmsl+6U5wzqIn/U4pJFj5XIRj7YKO2TYgK6RtY=
X-Received: by 2002:a05:7022:3d03:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-11c9f35e60fmr11892913c88.3.1764166314153; Wed, 26 Nov 2025
 06:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20251119203004.22742-1-alexander.deucher@amd.com>
In-Reply-To: <20251119203004.22742-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Nov 2025 09:11:42 -0500
X-Gm-Features: AWmQ_bljBkNcp_B1_YgN8mMHVfh7MPWAd74JPCacsosA72T0ygFSS7mq4UzRmwI
Message-ID: <CADnq5_MHBxCAjJ_zYCVptR5PcsVwy=ij9f06DuaB-FNYY9sC+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: don't reemit ring contents more than once
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping on this series?

On Wed, Nov 19, 2025 at 4:09=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> If we cancel a bad job and reemit the ring contents, and
> we get another timeout, cancel everything rather than reemitting.
> The wptr markers are only relevant for the original emit.  If
> we reemit, the wptr markers are no longer correct.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 1fe31d2f27060..334ddd6e48c06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -710,6 +710,7 @@ void amdgpu_fence_driver_guilty_force_completion(stru=
ct amdgpu_fence *af)
>         struct amdgpu_ring *ring =3D af->ring;
>         unsigned long flags;
>         u32 seq, last_seq;
> +       bool reemitted =3D false;
>
>         last_seq =3D amdgpu_fence_read(ring) & ring->fence_drv.num_fences=
_mask;
>         seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mas=
k;
> @@ -727,7 +728,9 @@ void amdgpu_fence_driver_guilty_force_completion(stru=
ct amdgpu_fence *af)
>                 if (unprocessed && !dma_fence_is_signaled_locked(unproces=
sed)) {
>                         fence =3D container_of(unprocessed, struct amdgpu=
_fence, base);
>
> -                       if (fence =3D=3D af)
> +                       if (fence->reemitted > 1)
> +                               reemitted =3D true;
> +                       else if (fence =3D=3D af)
>                                 dma_fence_set_error(&fence->base, -ETIME)=
;
>                         else if (fence->context =3D=3D af->context)
>                                 dma_fence_set_error(&fence->base, -ECANCE=
LED);
> @@ -735,9 +738,16 @@ void amdgpu_fence_driver_guilty_force_completion(str=
uct amdgpu_fence *af)
>                 rcu_read_unlock();
>         } while (last_seq !=3D seq);
>         spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> -       /* signal the guilty fence */
> -       amdgpu_fence_write(ring, (u32)af->base.seqno);
> -       amdgpu_fence_process(ring);
> +
> +       if (reemitted) {
> +               /* if we've already reemitted once then just cancel every=
thing */
> +               amdgpu_fence_driver_force_completion(af->ring);
> +               af->ring->ring_backup_entries_to_copy =3D 0;
> +       } else {
> +               /* signal the guilty fence */
> +               amdgpu_fence_write(ring, (u32)af->base.seqno);
> +               amdgpu_fence_process(ring);
> +       }
>  }
>
>  void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
> @@ -785,10 +795,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct=
 amdgpu_ring *ring,
>                         /* save everything if the ring is not guilty, oth=
erwise
>                          * just save the content from other contexts.
>                          */
> -                       if (!guilty_fence || (fence->context !=3D guilty_=
fence->context))
> +                       if (!fence->reemitted &&
> +                           (!guilty_fence || (fence->context !=3D guilty=
_fence->context)))
>                                 amdgpu_ring_backup_unprocessed_command(ri=
ng, wptr,
>                                                                        fe=
nce->wptr);
>                         wptr =3D fence->wptr;
> +                       fence->reemitted++;
>                 }
>                 rcu_read_unlock();
>         } while (last_seq !=3D seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 52c7597870eb9..f93bf83f7f5e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -155,6 +155,8 @@ struct amdgpu_fence {
>         u64                             wptr;
>         /* fence context for resets */
>         u64                             context;
> +       /* has this fence been reemitted */
> +       unsigned int                    reemitted;
>  };
>
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> --
> 2.51.1
>
