Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F2C61DBD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 12:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AEEC10ECEC;
	Wed, 26 Aug 2026 12:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jgwIb3a4";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A7DA10ECEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 12:54:54 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbe4592c193so78569a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 05:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787748893; cv=none;
 d=google.com; s=arc-20260327;
 b=AHrVkEQXlUpjm94C8Lx6lOI8TkdBjVJhr0zqbg2BS/Z9QIs/MZJ8bAOY2qdRULED3R
 6KWSB320vWzNo0HjoASfdxaQND7weXPnUgo3qEUP2kwePfSnzoU12iwkG2+70HhxnHkf
 YSPou0RTBQBmApgLhpA7Nv8Qo7rnIl5hbP+Pz9AM/fSjdZZNkdLAKPUnZaUsrgjFn+ci
 2L9oU33atiyCvKWcHmHV3toemBQOtzfTTGV+N/vod/Gg3bmlHQVtYpsCJE5b91pVjqNp
 +t051NB7qPs2PEbylp7BsjZ1XI8YbUKaE2g3yii35Ziwp/Jl1t/rFcH2AJ/Gd+/G0pLZ
 MfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FuU3VMcUNg2pdJGDt/rU2skLeu7wfXvjpGm0lmGXWaA=;
 fh=hVQ+NHnfuBMtcTgQbv/qElXk7tYIVPwVduqzuO66XKU=;
 b=HD0UlQsfv2juP1kJCl121adEghAw9CHM76E4EJ4BBl7De9tO7UmpEo/DRB50l0pw1L
 XSOAHKGbf82+tDr3720fKF44UQAcHL+F39q1bzjixh9xHzJl25U5wdRGqG5eECQB16TF
 XBdFdOd4zH3vUyxiH/RaFuPYGrNK+/CpLGbVGkvC1/tWK9rfVVDneqQEM84o/J3KgHgs
 2uF4liSb3noEVfndS0T13zCBi+n7nfUdfmM5P1TSzCA4ajYFY57k21wbPpowns3Nw0Rl
 UUoC5hen001mTJ81m3z3EhDMzU/ArwITEf2o4Rh524o6YvA4e1XXLvoDKHOsayvzzOZC
 1oXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787748893; x=1788353693; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FuU3VMcUNg2pdJGDt/rU2skLeu7wfXvjpGm0lmGXWaA=;
 b=jgwIb3a4F5AI91x8/NHl+HobmStC/HWLfgibGlgQLKCY5sL6LVrGUwGf+q1AGhM05E
 TaF1LULp5u+3NnixOlL79c3tMqfdTEAIqXTI9vgIPcjxIJ/j73DlPFwj5wszpTFQndbB
 MRX4x/PlfD2aSadNX0uyr0SqxPDP8hz7xudcSJHZidSFC59HAaQCJ12udVPdF8gA2R53
 uZR50mvyJlG2p/7ZNfDZ875dae0W0aIIYy1vLJOpNwjN3RP0wZwAPx0a/vJgDajQJas6
 2z/JvfeF+imMzT+V9SgGz+4txsICWu2fgjS7HcLf2HybDcjx+040KT9hJbcjKxyCIY+t
 j7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787748893; x=1788353693;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FuU3VMcUNg2pdJGDt/rU2skLeu7wfXvjpGm0lmGXWaA=;
 b=tRYvIqb7XFR5+QgEugG/W53C/NEQUgBp6ZewN+CmgSVfVG/gF1+5BE0H8OLAcaRNeV
 1pnuI832WycrFkz0EcCs2PQRkhCWvo7+z1iIClRyLE/7SYv7B49Nl68RYSk9y9FQgsYB
 2vwJrbccDlhC5JS1GzWdgV0hQk3vVQfNiNcw/pKbU/52UWYT7/KsWt8Cu1754O65+gzu
 JMfKWPFwCrUM5IAbnCNiwsf647R4czsB/J0u6s42Oxwh6/rxcy55kli/dRUv8HZeoP1c
 2rrnrV/j45tO7QcfB6wu/ATyxH693LoIewilErLyNbK3uSFyU4LB4NQ53jfaQLnGZk6r
 RPrQ==
X-Gm-Message-State: AFuF++nnykgYBHd8nOweL9560YeyZANKRvMJdmgCnL/aLhdDhbBoH4K6
 4hilEuQaxf4mQz9RZXMO15x8gYvUYaiVEGu2OWYdqmjEQSilBAWsMUoY7UFGwBlIJyXHnZg3e3L
 oJh9aHLaHKbJHYx6VV7DGfl6XTlrpsLs=
X-Gm-Gg: AR+sD13/Mnf+O2iZtXrOm60/NySbjlPRpzW/bifjTZ5fhxaWkixD1p4t8ZykMx76Db9
 FkvtDMHpy6+PUdNfs7LkF/FOCGciAmYtN4T2du5ndHjFRTIE5J7qQRJs5v22QrOmOxGJiLe6obl
 +4do16tuhWPg3c5PoSQuP02JKZ800uRcXhGe+xsE657L4MogfsLar0h+MDnlLGuS7SsWCZ2iVod
 UdikkEV6UjnfafmfQ3So4YOefSCgBH6mhbzEy1IP2R5GSyywKADKkvI5oehBFGJkR58/5OiQSAL
 K5B5f3VWqv9OwOacs+zXC88rKons/H3Z4z13ilibYeBnaB85tts85CD6gKO0bYiB/OHixXsZDMO
 niLE04YP2QXthSntNBy5805ruGjcnU50=
X-Received: by 2002:a17:90b:1f8b:b0:395:4df3:8800 with SMTP id
 98e67ed59e1d1-3966d007e47mr7038530a91.0.1787748893471; Wed, 26 Aug 2026
 05:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260820105537.3138777-1-YuanShang.Mao@amd.com>
In-Reply-To: <20260820105537.3138777-1-YuanShang.Mao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2026 08:54:40 -0400
X-Gm-Features: AcwNN1Vl3kRBW-N1LWgZYg_JVW0tlGYh2X5EM9z27O7wLl6AhGuRaixYziELxWI
Message-ID: <CADnq5_P8Vyzysy0SBncfK0AkxJ9t5A3p_0ccBfBMeF7SVv_Jtw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset
To: YuanShang Mao <YuanShang.Mao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, yuansmao@amd.com
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

On Thu, Aug 20, 2026 at 8:40=E2=80=AFAM YuanShang Mao <YuanShang.Mao@amd.co=
m> wrote:
>
> From: Yuansheng Mao <yuansmao@amd.com>
>
> A full GPU reset reloads the MES firmware and wipes its queue
> table, but KFD keeps the queue objects with is_reset left false.
> Pre-reset cleanup cannot fix this: it runs with the reset domain
> write lock held, so remove_queue_mes() fails with -EIO and the
> cleanup loops bail out early.
>
> When the process later exits, process_termination_cpsch() sends
> REMOVE_QUEUE for doorbells MES no longer knows about. MES rejects
> them, remove_queue_mes_on_reset_option() mistakes the rejection
> for a hung queue and ends up in kfd_hws_hang(), requesting another
> GPU reset. On SR-IOV that resets the whole card, so one injected
> hang costs two resets and disturbs the other VFs.
>
> Observed on Navi32 SR-IOV with a compute workload running:
>
>   ring sdma1 timeout, signaled seq=3D239, emitted seq=3D240
>   GPU reset begin!. Source:  1
>   Failed to evict queue 2
>   GPU reset(1) succeeded!
>   [ ~34s later, when the killed process is reaped ]
>   failed to remove queue from MES, doorbell=3D0x1002
>   MES might be in unrecoverable state, issue a GPU reset
>   GPU reset begin!. Source:  3
>
> remove_queue_mes_on_reset_option() already skips queues with
> is_reset set, but only the per-queue reset paths ever set it. Set
> it in kgd2kfd_post_reset() as well. Suspend/resume is unaffected:
> it goes through kgd2kfd_resume(), where queues are re-added to MES.
>
> Signed-off-by: Yuansheng Mao <yuansmao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 586e640f13dc..d326e41a8656 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1033,6 +1033,27 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>         if (!kfd->init_complete)
>                 return 0;
>
> +       /*
> +        * The reset wiped the MES queue table. Mark the queues as reset =
so
> +        * that teardown does not try to remove them from MES again.
> +        */
> +       if (kfd->shared_resources.enable_mes) {

Why is this MES specific?  Shouldn't this be true for KIQ as well?

Alex

> +               for (i =3D 0; i < kfd->num_nodes; i++) {
> +                       struct device_queue_manager *dqm =3D kfd->nodes[i=
]->dqm;
> +                       struct device_process_node *cur;
> +                       struct qcm_process_device *qpd;
> +                       struct queue *q;
> +
> +                       dqm_lock(dqm);
> +                       list_for_each_entry(cur, &dqm->queues, list) {
> +                               qpd =3D cur->qpd;
> +                               list_for_each_entry(q, &qpd->queues_list,=
 list)
> +                                       q->properties.is_reset =3D true;
> +                       }
> +                       dqm_unlock(dqm);
> +               }
> +       }
> +
>         for (i =3D 0; i < kfd->num_nodes; i++) {
>                 ret =3D kfd_resume(kfd->nodes[i]);
>                 if (ret)
> --
> 2.25.1
>
