Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC60D2D107
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 13:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1BE8999E;
	Tue, 13 Jan 2026 13:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IRLQSVWq";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B68A8999E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:59:51 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2b175c4bb64so478672eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 05:59:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768312790; cv=none;
 d=google.com; s=arc-20240605;
 b=PlCYQU8iXO3XpRt4QKFZu6ioFCKQXMCbFcfd4R1Tse9Okv/45N/r6rM63FzDWjg2NO
 f4xqHPDZBWET5gGtfGM4QVi6T2iZkamG8ThvyatZkFTw8WrOfkEUaIU41cBNJ1TgBwEm
 fhyXroElslpBhUdohu/1j1OtAZxdxwzBUjVtk9Ihqmtlxh0E2lf1qmot40R/pK8PrWTj
 lSHxPjtlfA16qdjfXtsvmTbAxKsgrycOGwgRl5CZzHO6PBZlktgdSU3H6Pz7tuDpNvrg
 p7VbmH1a5T3mtAlqAgXlZLUbiMw/7FAYMzD2rzUcQVVQ7TpJEIvMKkMCgyZIVHFeyyIk
 NPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ne65Ye1ulOHkF/N2kB6ZTyuU7dqXpVqch2aFnGX1PUM=;
 fh=tHaW2Dnoj02vwIx2N49MV9LA78qZTpeHLM8fBIf8vts=;
 b=Gsm/2aLMdZDL6elOYIilR/sho2jxgboiUIizdj0/WWhU6iNic7cJhJ2tq450mObDGb
 6gawlz/3DIA4UOD0Ha7f9VODIEojTrsvHahPn8d+Z2IvRgVZlDfB94AGqN7b02wgdkBl
 OPdRwxn0Lu2+ZPPsXhInF0ipEiUqMD/3AQq5FyjkloBQNvmx1I3GEAAJGErTHFzKTxmu
 XV/c2FWKi8hyWLzRpVXBOfxeUzVGYAJ6C8q/NMjWkS0ceEBdVtthV1HqdY2F0tQHqiAZ
 BoBp0qvALqi3XHcVJXkHP8Rr/fXPiTCn9+dsg0fvNgyPsls7RQThKa2Ga6Tt5NGCw6Cz
 ieag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768312790; x=1768917590; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ne65Ye1ulOHkF/N2kB6ZTyuU7dqXpVqch2aFnGX1PUM=;
 b=IRLQSVWqXxhJXOVU7bIHN9IekspZeQhCjpU3WmmRacpmGr1lRV+XzDY40ugfVPeKBI
 T2MABEajpAfrbEz+xheNcK+T/z7gjikFuTltrT9AAJjEzoyn21JsFiQ+wkcOqmuodRrX
 SMjibWrvP7Z6nMSORB7sVhk8rkZqiFwz2y0o+nqr0yCAcMGow+5msoU1wf732gAK38T/
 2KgObaPgBhqylBI91yaTsPK0m0tzLz7q6R1XiUoV1V3gZmMw37WIjEgWhHhnXoVYHzeF
 4NgIJMq4OWdhSUgQBzjW0sGwt/91j55xspa7QZcrqoqg3Px3DxwJI6APpL6QKeLF2rpK
 hBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312790; x=1768917590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ne65Ye1ulOHkF/N2kB6ZTyuU7dqXpVqch2aFnGX1PUM=;
 b=CfNu7xgh5TbrUZENWkFMMism5YxwuP95TGFPKzNN+YtwlcLO79lCmn0ZG6Pxuv46NT
 aXvb3xgem6zWqDUZ7Qu971btX17y2OMmwS2GFYckPhm5tgpruyCY93bvOFBvsWhRe8Zm
 ELgu8LwQ+3eTjd0LWqgmQuwvj+eF4ucvw3SeVIUja9IMUlMRfamcVGdrHSFuhPthEatS
 tAyQo7aXF8j2cKMVBrYhS1Cs20D0Yzz/RcYX38UWjH849YBMLkfMM6iihdseISf/GUiq
 FJ2sPKFcDIoTSLfYFFEOkjkGwl96Aeq2LA3Ibhk1eXiunPoG1D5yYhrCYT8NTYM7MRRa
 1pog==
X-Gm-Message-State: AOJu0Yx/cvj7gbmBX1xQSvhb6AqCvNPsKzlEHOsu4qmhQDDIMez4YqNF
 Io9WHWl2FX4gE3a36Q/t2L6gFs3YuGFvIPlT+nTtFEAojhhzMbS/KSimNkW75VoZqc2Z3StYlzZ
 Gk013j67zjz6DOIpF97XUG2EqtgeHZyk=
X-Gm-Gg: AY/fxX40F8os51ZtwI2yiUQX5SQJC1zbj0WpK8CEuGFHLqh01E9TBnhaps+3BgHr8aR
 b0YvQMbAgGas+nKp1oeapK+jqRDgJjwh8amAjch3CPVul2JSoPJlamX6jEPVV+/PEDxV4EDbBDC
 Krb5tl3+pzJq/MB4q5gJJlcUACJ/dPJc0KNgOHizyvCMAX8bG8l6ph3cO/cVXM2p7DRhOpJfAhC
 z3Dg2yQ+IHQ5+6caFGz5XFWje8CRhaq1zBYsXs9/XKnQn1+2zonP4D5qmz7sFSwbcD4bYJz
X-Google-Smtp-Source: AGHT+IHtQewfRZWGxzxkaREUwZLeozWZqHHCbUVBmOA2Jvte55eXpibPvxY4j0NRwy9Xa7a8nomXlqcvkFf0/2USpkE=
X-Received: by 2002:a05:7022:238b:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-121f8b923f9mr11363752c88.6.1768312790194; Tue, 13 Jan 2026
 05:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20260113015315.517164-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20260113015315.517164-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jan 2026 08:59:38 -0500
X-Gm-Features: AZwV_Qi6iP85Vo8gTIlqCNDBfMfqSzYOvb_VpMt2z7-jVIW1q4TjO5dwiI5iS6U
Message-ID: <CADnq5_NkDKqMLgkAaEBuwUd0jqWG45Z_BXmEbW1NFJA6SWGmZA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: No need to suspend whole MES to evict process
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
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

On Mon, Jan 12, 2026 at 9:12=E2=80=AFPM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> Each queue of the process is individually removed and there is not need
> to suspend whole mes. Suspending mes stops kernel mode queues also
> causing unnecessary timeouts when running mixed work loads
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Fixes: 079ae5118e1f ("drm/amdkfd: fix suspend/resume all calls in mes
based eviction path")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4765

> ---
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index dc4b6d19dc10..28e8c4f46f69 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1211,14 +1211,8 @@ static int evict_process_queues_cpsch(struct devic=
e_queue_manager *dqm,
>         pr_debug_ratelimited("Evicting process pid %d queues\n",
>                             pdd->process->lead_thread->pid);
>
> -       if (dqm->dev->kfd->shared_resources.enable_mes) {
> +       if (dqm->dev->kfd->shared_resources.enable_mes)
>                 pdd->last_evict_timestamp =3D get_jiffies_64();
> -               retval =3D suspend_all_queues_mes(dqm);
> -               if (retval) {
> -                       dev_err(dev, "Suspending all queues failed");
> -                       goto out;
> -               }
> -       }
>
>         /* Mark all queues as evicted. Deactivate all active queues on
>          * the qpd.
> @@ -1248,10 +1242,6 @@ static int evict_process_queues_cpsch(struct devic=
e_queue_manager *dqm,
>                                               KFD_UNMAP_QUEUES_FILTER_ALL=
_QUEUES :
>                                               KFD_UNMAP_QUEUES_FILTER_DYN=
AMIC_QUEUES, 0,
>                                               USE_DEFAULT_GRACE_PERIOD);
> -       } else {
> -               retval =3D resume_all_queues_mes(dqm);
> -               if (retval)
> -                       dev_err(dev, "Resuming all queues failed");
>         }
>
>  out:
> --
> 2.43.0
>
