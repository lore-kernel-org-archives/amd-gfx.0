Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAB9C25B07
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 17:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B6A510F951;
	Wed, 10 Aug 2022 17:14:59 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA57814A83F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 17:14:51 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-10ea9ef5838so18551174fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=R8Ujpq5h0BHpP71beqFK+dDxuWudKuGKO8TAICwYa2M=;
 b=DmBJVq0hxNhavxph3lov7OQArd+uwX38ECJwCY2ikbYkXwfvYvilMN8S1T4bbLn4MS
 7psV0sQKHAYaTLywueANbYE0FaFd8CwQz2OVXYKk32Mmd36wZaWv/GZrp3kkNF/9VYwE
 6uCHfQjVqcWEZL1B63yv9o4FF08SRUwND8D5SW/4r6Ql3EjuLbJN7loyNogWJC/NSiMr
 8iXPpJ8+qohhO58AMCy2QgNR57VH42jpvxSvfqb7LbCFv1Mm9vHrn8Fy43+xc4LeNzHS
 pZwdj4t2TVT6tahlbfpGsOldk6jeZ9EJR2yXQHSBiaV8s+KykQKVAcC5IiWeyx1o6lz+
 eRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=R8Ujpq5h0BHpP71beqFK+dDxuWudKuGKO8TAICwYa2M=;
 b=MGqc7kXI6ctHf3Cn/6iFM1Ev01PjmTG9nlFwhKvMSXOd5J494YMys25gNI4vljv8/K
 2JSqbSNHfP85xSlKb5ibkKb4GlbuL67Oazs7XzU0pej1jiof4cDbljL33D5TsZuZYTEJ
 6dbF7AkWGSJG0n8S27e6amSMmFNQ1/y+FkV1XKuMRIUpq3zxTZMvBkYSEuoSWSGJ4CfJ
 eNcJW4/CXzme//MbXdJC6vdG7EyhR1FpmiBTVAF9wXhGleseCBhnDiuIdnUFeySRav0b
 6d7sLIkd5pshs4hqj/Ny9G6YI+sSuDqDJa77/7+h3nx7ZXazK3hrCO+PTykESL1+SHxt
 /P9w==
X-Gm-Message-State: ACgBeo3mhrQaG0ArV5Q/02GzLx5R3+eUzGQTP6zimTmZQSPspBXtRrzH
 4mgd7OUjb/ZPeadqyC0FEie21fMpBmXhb/RqNtCvoakG
X-Google-Smtp-Source: AA6agR4dcpQ3dXrNgKkeNqtjK+d8MtuOxHyx3sYN8ZOjbaz8FKwutxd6yhX2WDJ6x4BOYC/0xNR78helxAOPMsaCtj0=
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id
 w24-20020a056870339800b001137f43d0e9mr1835110oae.33.1660151691061; Wed, 10
 Aug 2022 10:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220810085004.107210-1-Dusica.Milinkovic@amd.com>
 <572bd280-09ef-4026-c812-b91b9fe4b7e0@gmail.com>
In-Reply-To: <572bd280-09ef-4026-c812-b91b9fe4b7e0@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Aug 2022 13:14:39 -0400
Message-ID: <CADnq5_OzPuC6bh_spr0vnT8xKZGcNg3LJMUoH5sku3jVyd4gFQ@mail.gmail.com>
Subject: Re: [Patch V2] drm/amdgpu: Increase tlb flush timeout for sriov
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org,
 Dusica Milinkovic <Dusica.Milinkovic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 10, 2022 at 12:52 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
>
>
> Am 10.08.22 um 10:50 schrieb Dusica Milinkovic:
> > [Why]
> > During multi-vf executing benchmark (Luxmark) observed kiq error timeou=
t.
> > It happenes because all of VFs do the tlb invalidation at the same time=
.
> > Although each VF has the invalidate register set, from hardware side
> > the invalidate requests are queue to execute.
> >
> > [How]
> > In case of 12 VF increase timeout on 12*100ms
> >
> > Signed-off-by: Dusica Milinkovic <Dusica.Milinkovic@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
> >   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
> >   2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v10_0.c
> > index 9ae8cdaa033e..5743975efea5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > @@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amd=
gpu_device *adev,
> >       uint32_t seq;
> >       uint16_t queried_pasid;
> >       bool ret;
> > +     uint32_t sriov_usec_timeout =3D 1200000;  /* wait for 12 * 100ms =
for SRIOV */
>
> Please put that as a define into some header and never ever write
> comments at the same line after a define.
>
>
>
> >       struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
> >
> > @@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct am=
dgpu_device *adev,
> >
> >               amdgpu_ring_commit(ring);
> >               spin_unlock(&adev->gfx.kiq.ring_lock);
> > -             r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_tim=
eout);
> > +             if (amdgpu_sriov_vf(adev))
> > +                     r =3D amdgpu_fence_wait_polling(ring, seq, sriov_=
usec_timeout);
> > +             else
> > +                     r =3D amdgpu_fence_wait_polling(ring, seq, adev->=
usec_timeout);
>
> Don't duplicate the whole call, just change the parameter.

Per this, see my comment in the previous version of this patch.

Alex

>
> Regards,
> Christian.
>
> >               if (r < 1) {
> >                       dev_err(adev->dev, "wait for kiq fence error: %ld=
.\n", r);
> >                       return -ETIME;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v9_0.c
> > index ab89d91975ab..bab26982b3f9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdg=
pu_device *adev,
> >       uint32_t seq;
> >       uint16_t queried_pasid;
> >       bool ret;
> > +     uint32_t sriov_usec_timeout =3D 1200000;  /* wait for 12 * 100ms =
for SRIOV */
> >       struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
> >
> > @@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amd=
gpu_device *adev,
> >
> >               amdgpu_ring_commit(ring);
> >               spin_unlock(&adev->gfx.kiq.ring_lock);
> > -             r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_tim=
eout);
> > +             if (amdgpu_sriov_vf(adev))
> > +                     r =3D amdgpu_fence_wait_polling(ring, seq, sriov_=
usec_timeout);
> > +             else
> > +                     r =3D amdgpu_fence_wait_polling(ring, seq, adev->=
usec_timeout);
> >               if (r < 1) {
> >                       dev_err(adev->dev, "wait for kiq fence error: %ld=
.\n", r);
> >                       up_read(&adev->reset_domain->sem);
>
