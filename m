Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02068CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 15:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EEBF10E8FF;
	Thu,  6 Nov 2025 15:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kMNbeWNE";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A6E10E8FF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 15:19:08 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-33257e0fb88so211874a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 07:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762442348; x=1763047148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SX1RsfZ06gmC2m0vv0M8ynPPzto1fT8TMS7v02HJeT0=;
 b=kMNbeWNEXhXEedW3bJq5N/jt7hQxi9GQppXPOuABSxdbKpTOy2sRJj53FlIxbe9s9j
 1PxbuYdWDHC1x42luRDLJJjGkZWsEA2Ql20+Oqws3MqX9+nLsKoefwBICq366yg7qzyC
 sE4BUIHlvUHMVv29gbYzAOJEQoA2m31niNxckq1KCbu3C75ga5FpYOOQAxYwK31JEA0T
 +y3MhbcCuHeJkUFWlqrv3991fyJ1uLy55Fj/plQ2k3QFu1wBa4VyCQE8x2lkIRn3NpHp
 RBJLVs+Sy1RWnPB9LSoFkOO0aQOFLf+YIpkxo1kgvgISPNjJfr2EbR7WKxekKJc/aBR8
 Vg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762442348; x=1763047148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SX1RsfZ06gmC2m0vv0M8ynPPzto1fT8TMS7v02HJeT0=;
 b=vzYk2d572HQo2MmIP90o52q8TEJGKqjmO958GDksApaId0kAPM8ENo2DkyxgUxFehE
 7ZtotfUtLeGIJvLYzOZLbaWeS39GALV/pDc7NmVJEsGsFpVNJJNNGD7OkepnyfH1l5n2
 VGLq9kG9l2K91cwmU45wGsu46WMPqncTHcwc3GXizaBxAHE7DXkslpocIAWw1EQybkSr
 ia87kDLr0IrCp9gvp+mzEmolTHFzEsB6p3LjtjQPR+NSupNYB3GRg/NIyYetDdVnGGL3
 Yrwfbm1gwSccHm5AJE9KXc+dzc/wy8T6B5mgzkOZjWp54PMCdhmRu67Nu8fZ7UdLIBDO
 xicw==
X-Gm-Message-State: AOJu0YylXIG2Y85vu1uZXVRjNzvyOZp4J//dhpiLlSt2aSyjVUkznlbx
 dtq+vn6IAcvuQvH23rbJbRGmaA7T/Anb7Yfx9bayogLXizqo4+V84QInHSzNLAgnpqrvEoBBuDn
 +Nl8Z1U+Bni3q6JDeSaTSECTBPPsf830c8ZKF
X-Gm-Gg: ASbGncu6QsEYAfY92UjkJqETrXXDPFmfT9558+srn2fd7/ZtlZO0TOwDynrUszx1uX7
 S9doQiNVXJ3OBzXqmduKRzmsa3ii5S0Rb1f609GzCWntxJFM/jSlZtGtKsR/4oakRMeLGtMZAm/
 LPAqU5m5Az8l0Y3UpuOXAPHxJ572eZSw1IUAMhFlyQHW6GS5kR0smpdwY6Lte1DvyNdegvtthYJ
 DqIZ3JH09qQKjYyhByVnSD3ixHSjjOQbzl3pFXjZyTG9INu9tS3MxdqGF8C6qe8Do3yw7k=
X-Google-Smtp-Source: AGHT+IFdv1OfD0zigltebs1yl/GsycM2yBZu+OctMxU3gfjsc38AFhZQgRt2Be2MjL+dZcF9GI80EHhDHvWd81p2KKA=
X-Received: by 2002:a17:90b:17c1:b0:341:b5a2:3e78 with SMTP id
 98e67ed59e1d1-341cf41436fmr2369518a91.3.1762442347800; Thu, 06 Nov 2025
 07:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20251106130637.2187-1-christian.koenig@amd.com>
 <20251106130637.2187-2-christian.koenig@amd.com>
In-Reply-To: <20251106130637.2187-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Nov 2025 10:18:56 -0500
X-Gm-Features: AWmQ_bk5TBAdgp49GbaR8ygwlpGALfXru5tz3yHrNTZIs0sl8F60CrOyi_NIYo8
Message-ID: <CADnq5_OpEN57hh0WvprRBK2NKSTh7Yk5kYMUB6YHRfBWH8cAvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: use GFP_ATOMIC instead of NOWAIT in the
 critical path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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

On Thu, Nov 6, 2025 at 8:06=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Otherwise job submissions can fail with ENOMEM.
>
> We probably need to re-design the per VMID tracking at some point.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/4258#note_3179934

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4258

With that fixed, series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.c
> index 5f94a66511af..ecf2b1f13ca7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -286,7 +286,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm=
 *vm,
>         * user of the VMID.
>         */
>         r =3D amdgpu_sync_fence(&(*id)->active, &job->base.s_fence->finis=
hed,
> -                             GFP_NOWAIT);
> +                             GFP_ATOMIC);
>         if (r)
>                 return r;
>
> @@ -346,7 +346,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm=
,
>                  */
>                 r =3D amdgpu_sync_fence(&(*id)->active,
>                                       &job->base.s_fence->finished,
> -                                     GFP_NOWAIT);
> +                                     GFP_ATOMIC);
>                 if (r)
>                         return r;
>
> @@ -399,7 +399,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amd=
gpu_ring *ring,
>                         /* Remember this submission as user of the VMID *=
/
>                         r =3D amdgpu_sync_fence(&id->active,
>                                               &job->base.s_fence->finishe=
d,
> -                                             GFP_NOWAIT);
> +                                             GFP_ATOMIC);
>                         if (r)
>                                 goto error;
>
> --
> 2.43.0
>
