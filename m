Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96C2CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 19:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DFC10E21B;
	Wed, 29 Oct 2025 19:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NxV2ldMf";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3B210E21B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 19:02:56 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b6d08015f42so5573a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761764576; x=1762369376; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=532ANQlaO/BlLqZf/zLH5tZYgK2Od6Sh1YZomqty9qY=;
 b=NxV2ldMfHpSE/fEik3s2cjp7gC+vUo7fEFi+Cfq523mw6yDFi+tPiDD2NCia71oxIa
 /topuBS1JbYQbwmOHBh+q1xDth9Jn8nZisDuP3p4YqjXvTASsEe8Z/g8wx+9W9qiq48V
 z1C2dAm01auEXlYd+KzcKDp3XwZpd168TDYj02V2ZVcVHLFFcQxTJ0N439apZBlEfBqn
 H3QK9db1qoH1ZnfRWznuvkEZe+SNadrIcqiwuMTVTu0fxWnp5qwXjk3XMVtEI/a0T/I7
 2WudFwe0upeIliXzy6DwrrI01nlgPpvdpy0XjdSXTEKHqcBzJde7X02eXkBvI3AvZYpO
 CF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761764576; x=1762369376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=532ANQlaO/BlLqZf/zLH5tZYgK2Od6Sh1YZomqty9qY=;
 b=gVom+1Nppx5OvUEwZvRViELGsk/36MJlUnQH/U0nPhbyN3U8dxher7foegAvQLcgCl
 mNnuqejUPYX1FG26O4+Z97GBboa5OVDpT/vxMtkxSfB9ZSrc6+qedH9ZLrypFerYFomH
 O80pd+Q7oPG5QZegLfVs2GrPED0/c117UJ7ZOggSae/u4MX7Mk2phZosUKrBY6Xrgyap
 KcKAwj7AALXOmGomG3DXN+TTaLdZBlzeeh0ethrK9iVYncpOylzffCclP7E9gJwS8QYq
 iBMl9t/b3fDaUfo0ndzPPi2peROuSfN+S+x2RtWUCCVBs1vjc1Ye6+7g4dBUWdNUJzJq
 w1wQ==
X-Gm-Message-State: AOJu0YyTlx+pSoEAy0bNBXy76AEL+YHb1tcy+NWcZjSfCLy5sSnH1AXL
 xPLycJl5eFH+upRd46l86m5Rtaeb4iOODNAY1cu+AGnVTmiUJC6gum/rrQFJ8zWXGocorAKq50V
 t/3fFLCQruX8Ag6vG1skhYFTMWLW7KF56hQ==
X-Gm-Gg: ASbGncu3HTuc5AdpUkyUJvsSClXkFWYY3WIP/wxedEnC01N8HgHMw/ZBkZpQSj7XVmT
 +B1L+EQzbTnhHMtvoN8OwWVuAUfXDBMWidDEGvhIE1PRlGxm0tI+WMYDzSg8oVL2PM0b7R+gqRy
 WG0KIhUIj1e09NpBjhMtbOTEnm2u2uXhgNIT6MxF7KQp0LWNIJas0Ha05bYerXSXi2IxXcMQ7au
 yHFpTD5xG9r9NTUWJe0sCpAIYNdjGyCodhloK9SluJ1zC03AZEZ39ROeAZZOiuGIG/bgqw=
X-Google-Smtp-Source: AGHT+IFMMbX0K3fCxZhPmmioKsvgMEhPutscNOuI9SHayvUBn6G1UhJ5gijzSL1gG6M4tr1CA1H6rMd/3i8w1fmdBm4=
X-Received: by 2002:a17:902:e845:b0:25c:9a33:95fb with SMTP id
 d9443c01a7336-294deedd0fdmr22745735ad.8.1761764575802; Wed, 29 Oct 2025
 12:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251029140820.10930-1-Philip.Yang@amd.com>
In-Reply-To: <20251029140820.10930-1-Philip.Yang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Oct 2025 15:02:43 -0400
X-Gm-Features: AWmQ_bkjo9W6FPv4DLa1rAAzRHQJkk8cj-DhZGeoJbxVqqv2wHic3PCH1JGGRn0
Message-ID: <CADnq5_M5rLzBEaDt8ucQYfz_p43NBgdubZKs_DZPjtbn+-Xotg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdkfd: Improve signal event slow path"
To: Philip Yang <Philip.Yang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 Alexander.Deucher@amd.com
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

On Wed, Oct 29, 2025 at 10:26=E2=80=AFAM Philip Yang <Philip.Yang@amd.com> =
wrote:
>
> To fix regression report on gfx8, which requires the exhaustive search
> path for signaled event.
>
> The high CPU usage of KFD interrupt wq issus is gone after HIP/ROCr add
> option to reduce HW event interrupts, safe to revert this optimization
> patch now.
>
> This reverts commit de844846f72b152119faaef1b363448dc8ea368f.

Missing your Signed-off-by.  WIth that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_events.c
> index 82905f3e54dd..5a190dd6be4e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -748,16 +748,6 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t =
partial_id,
>                 uint64_t *slots =3D page_slots(p->signal_page);
>                 uint32_t id;
>
> -               /*
> -                * If id is valid but slot is not signaled, GPU may signa=
l the same event twice
> -                * before driver have chance to process the first interru=
pt, then signal slot is
> -                * auto-reset after set_event wakeup the user space, just=
 drop the second event as
> -                * the application only need wakeup once.
> -                */
> -               if ((valid_id_bits > 31 || (1U << valid_id_bits) >=3D KFD=
_SIGNAL_EVENT_LIMIT) &&
> -                   partial_id < KFD_SIGNAL_EVENT_LIMIT && slots[partial_=
id] =3D=3D UNSIGNALED_EVENT_SLOT)
> -                       goto out_unlock;
> -
>                 if (valid_id_bits)
>                         pr_debug_ratelimited("Partial ID invalid: %u (%u =
valid bits)\n",
>                                              partial_id, valid_id_bits);
> @@ -786,7 +776,6 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t p=
artial_id,
>                 }
>         }
>
> -out_unlock:
>         rcu_read_unlock();
>         kfd_unref_process(p);
>  }
> --
> 2.49.0
>
