Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4706EFD8FC0
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 15:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CECF410E972;
	Thu, 26 Feb 2026 15:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g+IQ1G76";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B51D10E972
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 15:00:25 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12736a0147cso70603c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 07:00:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772118025; cv=none;
 d=google.com; s=arc-20240605;
 b=cUWMtRLSsNZOFzHrMQnVAwChbZbzqYXD1gZb+BB6gJzCqIQStWvvBR0dkhpokSjlRS
 4xmuPbNsjmY4Fmn/VrDBOJk5lrX5RGcTNDe1cTR4besgbX/VQOD9r2qzETxBVNssLGTu
 Fg5eHRcG9oEPtQ4PTxcpT2J0Rm746BnMFcN47TwFXHKTvQMHek33ERxEuFGivqiKSaVX
 MQfPcfBtsCxtjXLE7JLMuwB/sSR7Atcb0Arodx7LyNgFwIWKzrnkYGQTukQpNeclqpc9
 roPz0UdzTgbcaXSD4vxT8Fv3QF+UivylERaIG4UN2HIp49aU65A8eBLHNb2u34POEZNe
 81zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jA1R3F+bKIiz87FEgUAqxdFJWtjhZPHxtl6GiMjpAQU=;
 fh=Mn+BRED8K460s5Zy/dOw62NhQDT70jz5aMHRQ3SLYw0=;
 b=gcNhaquvtcMAW3ykvXlDEdASRicfSQo3yUL4/yoA2wS1iQG3PDhHiejiLOi8OcGA8l
 8QzGsh74Y+ny1P6eIFLFK4Z0AzoZ+sSrmD4GvJ7cUwk4pGvMTbLGsa82EK+4frcQy93C
 mvkVaQnAGe+5cIMxbVxo6kfbA2Sj6ItAscS1XuFgmE3JPP2qPCOdg8bSXe84uVNCGe86
 SO7TLsP6c+t4tY+cqnJ6Gzb4hzzvq/I+HLto59j9Tty6NZQazTx22B9gGF2UjN+pYvps
 9hZKpUNj+yGSnl+8qwd0vtUfvpaDYvb6XDvgm7gKR/D7r5zVThHGTjsgGbja4Fo4gnnC
 N1IQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772118025; x=1772722825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jA1R3F+bKIiz87FEgUAqxdFJWtjhZPHxtl6GiMjpAQU=;
 b=g+IQ1G76L9Y5+08zNppnlKYMiUFcISycQfUSNSTiCancy5aiZTGus35TDyEmO5tYKa
 HtOQIrGOMNHYhPWMPj8CflJiOJc4J+4A+hvB2L87pxXW/J9qNLowQXrYqEPouy+pyv6t
 iXQH5wZyVtPgwa8wqeUYCOAi2MQxZWfKi2xoJo0I1MdgWgLeWac+FEQaw2szbheeDOk/
 /S63zZzXBCF8wdR3zS31P5CgPZojO80bJT7DSRytEgbpEVAsaNHIQBfOVwcjLF8xbXAD
 sRSLkkjKSH6Qk11rW69ZeHPK/+OES0l8BYV3Z++0rjFZL7ZEpXkdL8gnGn2x/GUOLt1Z
 MrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772118025; x=1772722825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jA1R3F+bKIiz87FEgUAqxdFJWtjhZPHxtl6GiMjpAQU=;
 b=HQ9FaI8aQO7ZI1d0wxT4aOSDcrJydgEFWTVBasanRDriQy91GMjT1P1f5cF0rKRyBj
 lztBlxgADrIsLY3W8rkxAsaf0pQ1pJdNfVEr+NkrkIMURMgHFKZvPpOEACHRjQib9Nkc
 OtHzBiXkH5LkWDqG4j/oGjuVnwf3clHyX2oq753oMXcozRQbQaR+uvPv+RGOOkqejWo9
 bF6UZ+D0sO/4YPP7/aa7T8wLkH4zk3kFVPuufCOpipZ7nQ254z7SUdoY11wd0rRRNhfn
 rSQeGHayHVO9AD8+kbQFD3sXo3laMNL5GOmKt3uDbPeftnvQFue8dcDBDwibjra/riS/
 DchA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0zgY7daJZW86dafXpPH3ZfDc2K5zFbMVgm7Uy28vxiP2aoTusSuQr5CeM2J9FA09y8GBO5Rt3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKI4v2WqVv45szjHR5kS+gb7PefDyP6N+3WYrSzJFU3XRuT4se
 IaA7uLE6nm25qSW3kdLAQuSeOUQ/KI2kmPGGCBSX1wvNedTRN3gc7e394iev99FDMuS2+CVHgJI
 d6D6JgiB3IBOapNQeEWFmr5zgZ7/pkkE1aA==
X-Gm-Gg: ATEYQzznr3YKfjX122vM6dZNk8EuHoov4fdCFFe7Y4cXEG/Gh8CXF0LfOLqNpXTF+eD
 zbHaeS8pG5llv/k932s0SBD4ZY+czECINrSh1ZG4ziTrRS6nhd4ouOSMQlbzeL4VGX3Sh+I0/Lo
 3I/05axS+HA9zvS6yYmVrp24zJqgW9rCbVUZbbeqZZSw3N55XP8yC1eLgTtaEZTqdYNjEnEiyOM
 HWhQepC8fSTeKnP2fUFGUtSynU4Aed77etgFC0aSwvL4JKG6KMbuZd3+uHcPbSyC7gzziT/IDYc
 z/QSC/6nP10RdjAbIPhxyW2NEvtTkkxj7IhiEvmGqgWsYnp9l5Myx9QDLrUwXFPghq0Hig==
X-Received: by 2002:a05:7022:ecc:b0:127:332d:63e with SMTP id
 a92af1059eb24-1276ad1a7d8mr4083635c88.5.1772118024406; Thu, 26 Feb 2026
 07:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20260226074241.3150441-1-sunil.khatri@amd.com>
In-Reply-To: <20260226074241.3150441-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Feb 2026 10:00:13 -0500
X-Gm-Features: AaiRm51c0ZLkund71jmXikj7VgTQT7ROYJgVZqpkGeyfcbYtd7IkKfbl7zHNs2s
Message-ID: <CADnq5_M7B++68+Kgo7Eb+y-mco=P9Ov4JT=2HkrubFNYxRVBVw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu/userq: change queue id type to u32 from int
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Thu, Feb 26, 2026 at 2:42=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> queue id always remain a positive value and should
> be of type unsigned.

Does it need to be a u32 or can you just use an unsigned int?

Alex

>
> With this we also dont need to typecast the id to other
> types specially in xarray functions.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index b700c2b91465..e07b2082cf25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -447,7 +447,7 @@ static int amdgpu_userq_wait_for_last_fence(struct am=
dgpu_usermode_queue *queue)
>  }
>
>  static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
> -                                int queue_id)
> +                                u32 queue_id)
>  {
>         struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
>         struct amdgpu_device *adev =3D uq_mgr->adev;
> @@ -461,7 +461,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermo=
de_queue *queue,
>         uq_funcs->mqd_destroy(queue);
>         amdgpu_userq_fence_driver_free(queue);
>         /* Use interrupt-safe locking since IRQ handlers may access these=
 XArrays */
> -       xa_erase_irq(&uq_mgr->userq_xa, (unsigned long)queue_id);
> +       xa_erase_irq(&uq_mgr->userq_xa, queue_id);
>         xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>         queue->userq_mgr =3D NULL;
>         list_del(&queue->userq_va_list);
> @@ -471,7 +471,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermo=
de_queue *queue,
>  }
>
>  static struct amdgpu_usermode_queue *
> -amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> +amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>  {
>         return xa_load(&uq_mgr->userq_xa, qid);
>  }
> @@ -625,7 +625,7 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_m=
gr *uq_mgr,
>  }
>
>  static int
> -amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
> +amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
>  {
>         struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
>         struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> --
> 2.34.1
>
