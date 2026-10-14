Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D43CC6B2A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5263E10FD5D;
	Wed, 14 Oct 2026 12:47:58 +0000 (UTC)
Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E92B10E256
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 03:03:00 +0000 (UTC)
Received: by mail-lr2-f7.google.com with SMTP id
 38308e7fff4ca-3a9a51919baso3364761fa.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 20:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791946979; cv=none;
 d=google.com; s=arc-20260327;
 b=l3kcxQ14VaaddscRE0Q0VwpFgfrBwTFSXVHZdcqM1jjUujr0i5JyAAYjfUMVsOeSQ7
 vrJ3XFKGbVgTh12DA8mFVtgiK3DZ+OE7ARQicUocLke6dpEX7Q3pruLLbC2iopHUVKmy
 /QTuRGIz4LsJFDCHbYmebWMUtG9s2ksMKsKgMMZTHzuIv/1SjGW545qwOsIpnT9u913y
 lTu7oPUz1EXF9uWBKrUmq/lMiEYhIK8RGVPZOjQVVgkIv6zcKk+FdB10xaMUfnOiY4y9
 0U69siexxBZBrpqFl68EOq2pBEz0pxCQVVXiulsNm3CXbg0oHNfJ5inO6vgPbs74fCxo
 x7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oaE/H0ZV/2aESDvS9Gp3EEHeBvb99SQefPoRqEUxC5k=;
 fh=U4MCwTg3+87LaGQkG1IgbQysShmMdoq4lt+4RH1FUHI=;
 b=ZLZE/9ZhqogD/aPbnBQ2lrl8YdEji3qGKn7dlK7ucQdzzRiTtBeFz8P50HfTMCOyHu
 CZvid/FYw+LQ19jpEkkUtsYrg3SUYrdlhkprB7h1Yr/+prdIEiwL83RMPZTx3LPnBAcs
 NtQInLvvxV4gDX+5pZLQWPycmxi6vhBQwnnKUHBRi3sDBtnaemMF/esgRXD+FMS2Ex4Z
 U0KI3+/jT4lGUlJ2Z3BKZHOXGWZ7tA/zkBh3iPiS0pVM6HvmNXcToLBd+rRkV1/oWz9F
 KwJzatool0YiQsU86T5mYEUvA0SOm1rtidb2bnTReZLA8JdwOm8k2JesS7/qJmvCWAuK
 G5yQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791946979; x=1792551779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oaE/H0ZV/2aESDvS9Gp3EEHeBvb99SQefPoRqEUxC5k=;
 b=c28mKWdiWFJE5y1hY4UPH7VZt0SOA7nefFD4nAhus9eWjhR3Epc+4stKfTy5aJdgSc
 +2NLPY0ncMdmNEadu0K7EqbcZZ5LNkRjs0Y+m5fU8yIs2VCfZXycTVSChVqAAn/U95Ao
 Kv2bTDdx4thul9EjxA5IU4YcuXmSTEmFcbnm348OLLeVpRYAfC9BI89qclLQL5XSGknB
 5NMe2eUsRSCBFQ3+MadotRbSLUekjXj7rMsR2Ptrzct1KKwL/avHVjHNZYHauaEdqQ/M
 AYaIqFNDNGS7iP3lmSH+ayt3KJRXLs1BhwWVKWN90p3ySr/dMiWia6/wrmhEw6z8bXlE
 1HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791946979; x=1792551779;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oaE/H0ZV/2aESDvS9Gp3EEHeBvb99SQefPoRqEUxC5k=;
 b=NyGsk8yqAvNwzJfmcgvgchhsBu2J4Y8mla888aqhZNEhT4FuTXbEjHuXMQHUjpX4kQ
 tEYRWC00m5zwGhAwVig8BY1O87i329KUFUgHBVu5ZQPkxuLTFJsjmZ8F42h5mHoC+3kn
 tn0/80cwzPrHQHpF+ul9+04gTzDSPUx0MOxSAXMCl9SaZjAjE0lbEvcKDAdmEXCqi2kH
 MVZuQRLXoJWEUVw5SbyvHRozbgNLSh7R4P6NuVUJmSahCB/7EC4t/KH/WU4+w1dy9c5L
 bKkeg7z9E/AtA3oRqjvxA3yS4TINh1DL2YxmhLe2jYmFMbzmHet49V2rPB7iyKtxmUIk
 X14w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwD8rKuI2X7ZsuNxHIy/A6dOpFxsXjvguz34Ov0lbf27V26mZ1ETuKAJOHXmVnyL1yCYDUeV1tR@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL4UDQcLvG1eEDpyZX/5h98UpwUNUS+WdBrgdf9WFcH9Ee6dNV4
 imoM+qd5o8rz0qO0Tb/QvMuWsodY1Uh1uKmLITwtmtvBuwLf2HtQljfvI3C/v2cmQm4Rqxcbe8V
 RDxlFDx3fv6GB0Ck8HGFKlvkbWA8ywRU=
X-Gm-Gg: AYBFou0Wdd9VLPh/9QrA3Ek20kLU8llAbkWADeiu4TIj3cSy4uXDXic94FXrZMQSyK/
 nsRURykMb0M+R0icznEvMKVZyycVjJ5cJ3HnBsrZoEcRL1WA0sdix8mBTWDpNgFfN7Zq+D7Kl6Z
 dOplVAMigqsFrXupvpjfNPkz8a45gQYyLj4taGPLlG9qzHHh8rZfYowm+WlVN3KOntY8GXBt85/
 pTgtxtAMdAcs0S3bDGVMkbqf5cxheg7AWldn4qMdDlw3i3g8B9vpzMbgPvJFv04DPl/CTmrYYf4
 mjolMV9QbrBqzpbo8noT1j09CjNChPP88t0y6VkktzckYHtekEv6899guqB9FR+PD/E=
X-Received: by 2002:a05:651c:1542:b0:3a6:692d:b7ed with SMTP id
 38308e7fff4ca-3a9c539343dmr38351911fa.20.1791946978412; Tue, 13 Oct 2026
 20:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
 <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
 <4df51e6e-b017-4057-96dc-32d4003f8705@amd.com>
In-Reply-To: <4df51e6e-b017-4057-96dc-32d4003f8705@amd.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 14 Oct 2026 11:02:46 +0800
X-Gm-Features: AclHuK9wmlZSIF4pzMKiC6asGVwJ7ETTkkdCmGmvxP7lUevo_EYe8yPIyar_-KM
Message-ID: <CAEnQdOpWJ-73FyQzgov2g9___KWptdK5PZcOkwi1FS4b6mhOFg@mail.gmail.com>
Subject: Re: [PATCH v2] amdkfd: fix doorbell allocation race creating
 duplicate allocations
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

Hi Felix,

No objection at all - 16f0013157bf ("drm/amdkfd: Allocate doorbells
only when needed") looks right to me.  Thanks for the archaeology
and for taking care of the tag before submission.

Regards,
Henry

Felix Kuehling <felix.kuehling@amd.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=B8=89 01:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2026-10-09 23:02, Henry Martin wrote:
> > The check-and-allocate sequence on pdd->qpd.proc_doorbells is
> > lockless at every call site of kfd_alloc_process_doorbells():
> > kfd_get_process_doorbells() (mmap of /dev/kfd),
> > kfd_ioctl_create_queue() and the CRIU restore path each test the
> > pointer under different locking (or none), so two racing threads can
> > both observe NULL and each allocate a doorbell BO and bitmap,
> > orphaning one allocation and handing the two mappings different
> > backing pages.
> >
> > Move the serialization into kfd_alloc_process_doorbells() itself,
> > using a new per-process-device mutex so all three call sites are
> > covered regardless of their own locking.  The device-global
> > kfd->doorbell_mutex is not suitable here: it is acquired under
> > dqm->lock on the kernel-doorbell path (start_cpsch() -> pm_init() ->
> > kq_initialize() -> kfd_get_kernel_doorbell()), so holding it across
> > the sleeping allocations above would create a lock-ordering
> > inversion with dqm->lock via TTM eviction, and it would also
> > serialize doorbell setup of unrelated processes behind a
> > device-wide lock for per-process state.
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 2105a15a2046 ("drm/amdgpu: use doorbell mgr for kfd process door=
bells")
>
> I don't think the Fixes tag is correct, even though that's what Claude
> suggested. As far as I can see, the code had the same possible race
> condition before that change. I believe the problem goes back all the
> way to 16f0013157bf ("drm/amdkfd: Allocate doorbells only when needed").
> If you don't mind, I'll update that in the commit description before I
> submit your patch. With that, the patch is
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
> Thanks,
>    Felix
>
>
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >
> > v2: Use a per-process-device mutex instead of kfd->doorbell_mutex
> >      (avoids the dqm->lock ordering inversion and the device-wide
> >      serialization) and correct the Fixes tag.  Pointed out by Felix
> >      Kuehling.
> >
> >   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  3 +++
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  1 +
> >   3 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_doorbell.c
> > index fdcf7f2d1b5b4..55acadc986bee 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> > @@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *k=
fd, struct kfd_process_device *
> >       int r;
> >       struct qcm_process_device *qpd =3D &pdd->qpd;
> >
> > +     mutex_lock(&pdd->doorbell_mutex);
> > +
> > +     /* Another thread may have won the check-and-allocate race */
> > +     if (qpd->proc_doorbells) {
> > +             mutex_unlock(&pdd->doorbell_mutex);
> > +             return 0;
> > +     }
> > +
> >       /* Allocate bitmap for dynamic doorbell allocation */
> >       qpd->doorbell_bitmap =3D bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_=
PROCESS,
> >                                            GFP_KERNEL);
> >       if (!qpd->doorbell_bitmap) {
> >               DRM_ERROR("Failed to allocate process doorbell bitmap\n")=
;
> > -             return -ENOMEM;
> > +             r =3D -ENOMEM;
> > +             goto unlock;
> >       }
> >
> >       r =3D init_doorbell_bitmap(&pdd->qpd, kfd);
> > @@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *k=
fd, struct kfd_process_device *
> >               DRM_ERROR("Failed to allocate process doorbells\n");
> >               goto err;
> >       }
> > +
> > +     mutex_unlock(&pdd->doorbell_mutex);
> >       return 0;
> >
> >   err:
> >       bitmap_free(qpd->doorbell_bitmap);
> >       qpd->doorbell_bitmap =3D NULL;
> > +unlock:
> > +     mutex_unlock(&pdd->doorbell_mutex);
> >       return r;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index d8631847f0eb9..96e59133fee02 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -779,6 +779,9 @@ struct kfd_process_device {
> >       /* per-process-per device QCM data structure */
> >       struct qcm_process_device qpd;
> >
> > +     /* Serializes process doorbell allocation for this device */
> > +     struct mutex doorbell_mutex;
> > +
> >       /*Apertures*/
> >       uint64_t lds_base;
> >       uint64_t lds_limit;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_process.c
> > index 0a7c1900da959..4efe4dae79c13 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -1788,6 +1788,7 @@ struct kfd_process_device *kfd_create_process_dev=
ice_data(struct kfd_node *dev,
> >       pdd->dev =3D dev;
> >       INIT_LIST_HEAD(&pdd->qpd.queues_list);
> >       INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
> > +     mutex_init(&pdd->doorbell_mutex);
> >       pdd->qpd.dqm =3D dev->dqm;
> >       pdd->qpd.pqm =3D &p->pqm;
> >       pdd->qpd.evicted =3D 0;
