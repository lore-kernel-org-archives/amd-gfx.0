Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED458C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 16:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6492110E5E4;
	Mon, 20 Mar 2023 16:04:07 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1246410E5E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 16:04:06 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-17ab3a48158so13536011fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679328245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRLJ12AEP9ezGeP/7UqwqzmKO9HJ7JjJXYmxs9z3/2A=;
 b=Ihpyhxa9QB862lVibbSgq3wBCqUBqOeA8WI0eUAKXu7waDL1e+eyQGhOPPyYKfGaiR
 E2uIv7x66hi2QiWDcQa3yTEl8ZI+205gvDn07VB6Gu7vjXHpAPHP7dD3b2SA4Z/k1Cio
 xWle5T3z0lVVxnk5gkG4XCodaQtVQqEaWgO0REaoIW1liygSN5edsrT6y1vGwVToiAGT
 5rijAQjFYVJYxTay/PKujmi1Tl8L7JxcjbdZEjJnxT+J54v6bmGGd0h9qdxJLFQMcaX7
 lJ+QvwMDdocEWTffpvRUyxJ/vZywSv+F+SmR+iuMwldtHL1aj1XMp7Qx9n7t1XOgv0Fh
 9o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679328245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRLJ12AEP9ezGeP/7UqwqzmKO9HJ7JjJXYmxs9z3/2A=;
 b=DRMQalkzBBlGRIVprwVis5182H/wbfEyoIcxosmYyxNzaZBvdxvkCXZBq9+Bb9OvOW
 Tb73a5tVPSZsIlqbOKv5Ldz+QeJvlsVcjH+0NJQwI0BLU9a/FbO0mr/xVV9gCVwJbT3r
 z0bLBJawxx8QkibyXjXpkwl7R0miKmhh5ob22hA1049cTEYgvwgPYvCfMjngnGmIeac4
 91ie37ApdXDzUbWot+I4k458ZENlaxtMFrcOLBBYi4zJvBfWXL7JUIyfPu2VNTXFLagg
 txDU5mylqE3QLRrUqaZLpgt/UHhTPO6SokMH8SbfgAeOMGbr3gy663r1r7ukKeK0n4A7
 Udiw==
X-Gm-Message-State: AO0yUKVTvSFiHsk4AI/PeYwUdz1hmab7PoC+prdAmlB4aOD7QEI+lXfl
 hERcBOVUK0QH/ox/gFQeqWryUMYNqWvmy8VhLKw=
X-Google-Smtp-Source: AK7set8d0vaZ5MBdIs1LHllgDhD7FbM3zdjG82dJZ67+mBS6tgJ60LvCaQ+G58niPSSptuQ/fH0BtvrVE7tpS4adGsg=
X-Received: by 2002:a05:6870:8f0c:b0:177:a289:46b1 with SMTP id
 vb12-20020a0568708f0c00b00177a28946b1mr1855522oab.3.1679328245325; Mon, 20
 Mar 2023 09:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230317171748.682691-1-alexander.deucher@amd.com>
 <20230317171748.682691-8-alexander.deucher@amd.com>
 <fd529eb8-2070-320f-27bf-371ac294c574@gmail.com>
In-Reply-To: <fd529eb8-2070-320f-27bf-371ac294c574@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Mar 2023 12:03:53 -0400
Message-ID: <CADnq5_PMGhzZ6eo5kVRbdZPYxdGk9tWg=dQYQ6sX9CgAdKy6Wg@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/amdgpu: add gfx shadow callback
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

On Mon, Mar 20, 2023 at 11:58=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 17.03.23 um 18:17 schrieb Alex Deucher:
> > To provide IP specific shadow sizes.  UMDs will use
> > this to query the kernel driver for the size of the
> > shadow buffers.
> >
> > v2: make callback return an int (Alex)
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.h
> > index 4ad9e225d6e6..8826f1efc75f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -219,6 +219,15 @@ struct amdgpu_gfx_ras {
> >                                               struct amdgpu_iv_entry *e=
ntry);
> >   };
> >
> > +struct amdgpu_gfx_shadow_info {
> > +     u32 shadow_size;
> > +     u32 shadow_alignment;
> > +     u32 csa_size;
> > +     u32 csa_alignment;
> > +     u32 gds_size;
> > +     u32 gds_alignment;
>
> I don't think we need an alignment for those. Otherwise we would run
> into problems with the VA mappings as well.

This is for the GDS save area so it's just memory.  The size is just
the amount of GDS on the ASIC and the alignment is standard 256B like
most other CP things.

Alex

>
> Regards,
> Christian.
>
> > +};
> > +
> >   struct amdgpu_gfx_funcs {
> >       /* get the gpu clock counter */
> >       uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
> > @@ -236,6 +245,8 @@ struct amdgpu_gfx_funcs {
> >                                u32 queue, u32 vmid);
> >       void (*init_spm_golden)(struct amdgpu_device *adev);
> >       void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enab=
le);
> > +     int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
> > +                                struct amdgpu_gfx_shadow_info *shadow_=
info);
> >   };
> >
> >   struct sq_work {
> > @@ -372,6 +383,7 @@ struct amdgpu_gfx {
> >   #define amdgpu_gfx_select_se_sh(adev, se, sh, instance) (adev)->gfx.f=
uncs->select_se_sh((adev), (se), (sh), (instance))
> >   #define amdgpu_gfx_select_me_pipe_q(adev, me, pipe, q, vmid) (adev)->=
gfx.funcs->select_me_pipe_q((adev), (me), (pipe), (q), (vmid))
> >   #define amdgpu_gfx_init_spm_golden(adev) (adev)->gfx.funcs->init_spm_=
golden((adev))
> > +#define amdgpu_gfx_get_gfx_shadow_info(adev, si) (adev)->gfx.funcs->ge=
t_gfx_shadow_info((adev), (si))
> >
> >   /**
> >    * amdgpu_gfx_create_bitmask - create a bitmask
>
