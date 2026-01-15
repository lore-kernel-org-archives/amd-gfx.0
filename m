Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEC3D44C46
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 13:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBCB710E759;
	Thu, 15 Jan 2026 13:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FcYhL/lg";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECE410E75E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 13:37:58 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2b05daf2e4eso58932eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 05:37:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768484278; cv=none;
 d=google.com; s=arc-20240605;
 b=ITcqZQKI/sofoBMOxCaVw3W7cCwVuPYOHyqlI3C9KRHtGuDO92qWjhJlXJYR9SD7+2
 q/pzP/Cjy08bjzwcJ+B1lynloJ7xjNva8085Xbw1qS5HHuqsdVVsckjl/bnkzWe+bDNv
 4dQKJrhaU3sKHdy24evpzyZPEmEgdAy8JVKEzBuAa4B6kGzPSggJ22D+nedMv6c19QgU
 j+kQ5MSspKWBpfbsjOGAnGqBVXOjRc/jhbP5pU34ovmeNRx7u18WQLpajvcPtqYc14EJ
 b3zocFGvqobEp/OlXZoJkuPVhJGTkhJrJEwCE00fSALiQXnAAo5zdmDxBKO9Qs98J9uW
 goyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=so17W5QiVvWvfxuhvjAQ8NGcsrU+n6yf2wWyIYZuGXA=;
 fh=Gfnkfkaur23H+jQ7BiBgD3YCxM7NPG5VMklHXUALp0U=;
 b=lBh3At+K5ibS9QKS9ks0XtgG391z9V4kpfAki/MK6SL1T90dTZtNaGMNubLd2hbh2k
 Z1uCFemKIAatvQwFX9tB2kg9Rl3xUztaIsfO/Nf0byclUdL4il6cCuFLF1vCZwF5a77f
 uNoFKpBHU8n3q+2xQciCAM4nPZbcPe/i1tgmS9eswFFGgtyxc0QiRiZtV/w54sTxf/QP
 nqF/PLEGf0WL3+LhsBa9pXAV4MoJ9U9+VDHpxf6I6AS2XK0slZsGTcKrdDW6lz714SDn
 rhcpyyLHg4JPXrhg/IkaFIanpAP3b4CZGBN8kx19b5N0ENEKOu+u9JyuExhnBujxsEIn
 wBjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768484278; x=1769089078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=so17W5QiVvWvfxuhvjAQ8NGcsrU+n6yf2wWyIYZuGXA=;
 b=FcYhL/lg7WuxzUQLY+DQvudOUNdvMo9uCAQEWZdc8hZ4isoCMmw6+Hmb0lPG1Zu1Ju
 wyDwrAki3oXP9l31E8z3VQ8IGTwbJH895W9s1UjvFSOD1tBc0xHnDqbZ64I3ZNFOHmBo
 tWo3OJOJnBJREZKrwwWo/sYkK7aRy1ggbHajU5x9iw+T9DSroLJY3Dg79LGOwdx8IEi1
 Ttd03x3QYuuJgqzh4D59KP3PoMgUHegUpVuzP0rCCBc0d1EWGi22edYFykltUEBFms4t
 D8Hh26//LG6iO4nqZB9Ejh5ZCvkxlo9B5Yze3sBCf45TrEeZVoFCHJFV+CDoS+eKO8WF
 M6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768484278; x=1769089078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=so17W5QiVvWvfxuhvjAQ8NGcsrU+n6yf2wWyIYZuGXA=;
 b=bFAFqDvdSeoMa5mp+/8H5lFlzH6AMXZoOy6y+Vje/+V5s5Ih9oYf80ZLkfvg83v12S
 6FoRt1aFwRYXU1gSSchcsUstikerWllkTcfh+l5qUdwP5KQqoUNojfINRznmlVz4YB8h
 9DzfAP4SoxgSUBdpxRnHQ9JJRFMvh0AbjBKZI0rysYkpQXjseKnis5SWtb0lko1NM14G
 POlj9m2mbB+luRSxd/LkWlEo1f2SYNQd/h1NjZ8FUtDdwEjxFeBvH1gt2yQBA2g00Q0N
 5F2nlXIpdoKBslYLRRkeRTiodFGvCYyRXS8XeTOD4yb8VW1yDrxgOhgvj0FEETRjkjBk
 Y70Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAP5XHr14MeOEBnXeBvXAWpbYf49IN2PqgAMEbPo61e5KX9a8fJg6BJy6OoNcUjhTFsDX6S1Ft@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLbhZLjfUMQC/NHdVPiFrtaexs7ECwjOLP9bxVNqpUYeXtuNj5
 ka9JfteVjziGnpWPB8GsWqGGgdCE3l/APPQRQGo0TF+1aYL1uSl11l7kPbdczlsyT0l4pV8XPvV
 Ip51eF8d8PIJA/zM+20SMLqrALxzJCOo=
X-Gm-Gg: AY/fxX5F2cYeynAysUtVmWhYIIvivRItvgsry0Srw9Zy0s5qxvynj0qDNpzTrmH+2iU
 vx0f3+BBrE8e7Ca3uBuSEccG7h+4LtwL+nQ1QFbnYzqq1DpdwkJFDbUNo2mLR0T3xgwVzZCrTwA
 0Epm70E7kqMc0v+q+1m9QAmFt9qlOge3J0gvlyWbo/02LWauaauzfp7M7b9AdKjapkNI+TnY+Wa
 j0wrmm5ThBXbgC8IjDEgzKa/Bz5sNhajcPAYsNhTRPa3L8ySB12kwk2B7qmXwfa4X8fcYQX
X-Received: by 2002:a05:701b:2218:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-12336a9678cmr3928625c88.4.1768484277734; Thu, 15 Jan 2026
 05:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20260115025313.620844-1-Jiqian.Chen@amd.com>
In-Reply-To: <20260115025313.620844-1-Jiqian.Chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Jan 2026 08:37:46 -0500
X-Gm-Features: AZwV_QgQmuZAqv5NZz7B8sxFICmffmb1xahH3xbBUoLxgvxv3ENT4A0PLLmqVkw
Message-ID: <CADnq5_N0DhsevzefU8_gFKF=jb_W3eEeE2Sc0fxUaQRZOFPgiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>
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

On Wed, Jan 14, 2026 at 9:53=E2=80=AFPM Jiqian Chen <Jiqian.Chen@amd.com> w=
rote:
>
> If drm_sched_job_init fails, hw_vm_fence is not freed currently,
> then cause memory leak.
>

Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
> v1->v2 changes:
> * assign the return code of drm_sched_job_init and check that instead.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 7f5d01164897..72e1bfd3fe4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -219,8 +219,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>         if (!entity)
>                 return 0;
>
> -       return drm_sched_job_init(&(*job)->base, entity, 1, owner,
> -                                 drm_client_id);
> +       r =3D drm_sched_job_init(&(*job)->base, entity, 1, owner, drm_cli=
ent_id);
> +       if (!r) {
> +               return 0;
> +       }
> +
> +       kfree((*job)->hw_vm_fence);
>
>  err_fence:
>         kfree((*job)->hw_fence);
> --
> 2.34.1
>
