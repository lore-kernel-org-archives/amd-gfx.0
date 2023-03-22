Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1640C6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 13:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2742610E0FD;
	Wed, 22 Mar 2023 13:27:12 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0127010E0FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 13:27:09 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 cw13-20020a05683068cd00b0069f8c4eecb5so2518850otb.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679491629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9hqA1QkZiNOk4weRVpV5MtxAgWjWCDOmBBndEB3oMQ=;
 b=M8wkHpRlQj5YAJAWGPL7p7EkrlBfaYTAO0GdZvKvvVjwhhytaTHjvfnpP1kZlA2TJq
 3Ox+01ti3Sp9ynhdT9/x4i91pCm7Rq+WpKtEgoVVq1efzkkh4rwbKO+KVv4xLCVpvICt
 +OJN3qHBRvjoot+EYpN8O5E5CivKG71tzGxD3QWH4W58HNGsTkT/BJ8tcpXRR/CpqEbW
 lqjLi7Fg4MKALv90bfCN44ls+VTrar/DXvwK/3KDeuSEqO+SN+H3OxXwE+Se5qXXpuYv
 yhbhGPvf7647ACA84NcLCFbOx+zbnbgAOYsAWAsFBt+jA0hwoN+wXNAWgqhJQj4c2YUp
 6WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679491629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9hqA1QkZiNOk4weRVpV5MtxAgWjWCDOmBBndEB3oMQ=;
 b=IYHSD07koevwymTZrDcagTMC7dK6LI6B4+H9vMKI7Tvb0h7+JgbwLz4m3qwd3xktv6
 elZ6DZXQY/J/qirU3HQVK/SmXQ3Y2T9/3IDNEi2yYmhETwZ1pgKrtSt8qD8L5KOyUQST
 OsXq9RP9AB2iErLDNoteEvOnQYfxodKQN5Vt856rX0JJ2Z4i46FMcaIowb+kZ0WoY12n
 H6ia+BJnbcfrmaQmMtYhO16Tazg9r5agsuAFbflq8f111vfImFJsbXpnnYDSZLILSUd3
 ZQrDo7hMIa1QJ6x404Uongr7xjfKaNocFY/anBjZYYgU9tY9zQpoi30OdO+ldJ1K2qkV
 /FoQ==
X-Gm-Message-State: AO0yUKWMQzswfTPlaYbxS7hx3oexvo7DY3QMx0RPTMqbaN//RLTRAfTh
 hmQN6izFT46QhGh5HdMDM1RfSFbTX4s+1K6XXAA=
X-Google-Smtp-Source: AK7set+XmP8qvoJR0mfQoChEn0RQeXhZ0WExvGKdKFCto/o4KDdARVDm1QKUPPSEy/WQU0EAHcluuy2vd2JMmZwIe2Y=
X-Received: by 2002:a05:6830:1044:b0:69e:24a7:e042 with SMTP id
 b4-20020a056830104400b0069e24a7e042mr1092532otp.3.1679491629218; Wed, 22 Mar
 2023 06:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230321193922.2029808-1-alexander.deucher@amd.com>
 <07b35e4b-c574-0ad8-9c71-591dc5457979@gmail.com>
In-Reply-To: <07b35e4b-c574-0ad8-9c71-591dc5457979@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Mar 2023 09:26:57 -0400
Message-ID: <CADnq5_OAZZ-SYLprOFzzJgsQBxs15FdxTWc28MpUQ-abM4ZLHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: track MQD size for gfx and compute
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 22, 2023 at 4:48=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 21.03.23 um 20:39 schrieb Alex Deucher:
> > It varies by generation and we need to know the size
> > to expose this via debugfs.
>
> I suspect we can't just use the BO size for this?

We could, but it may be larger than the actual MQD.  Maybe that's not
a big deal?

Alex


>
> If yes the series is Reviewed-by: Christian K=C3=B6nig <christian.koenig@=
amd.com>
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 ++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
> >   2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index c50d59855011..5435f41a3b7f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -404,6 +404,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ad=
ev,
> >                                       return r;
> >                               }
> >
> > +                             ring->mqd_size =3D mqd_size;
> >                               /* prepare MQD backup */
> >                               adev->gfx.me.mqd_backup[i] =3D kmalloc(mq=
d_size, GFP_KERNEL);
> >                               if (!adev->gfx.me.mqd_backup[i])
> > @@ -424,6 +425,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ad=
ev,
> >                               return r;
> >                       }
> >
> > +                     ring->mqd_size =3D mqd_size;
> >                       /* prepare MQD backup */
> >                       adev->gfx.mec.mqd_backup[i] =3D kmalloc(mqd_size,=
 GFP_KERNEL);
> >                       if (!adev->gfx.mec.mqd_backup[i])
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 7942cb62e52c..deb9f7bead02 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -257,6 +257,7 @@ struct amdgpu_ring {
> >       struct amdgpu_bo        *mqd_obj;
> >       uint64_t                mqd_gpu_addr;
> >       void                    *mqd_ptr;
> > +     unsigned                mqd_size;
> >       uint64_t                eop_gpu_addr;
> >       u32                     doorbell_index;
> >       bool                    use_doorbell;
>
