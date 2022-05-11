Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70E4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 07:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFC510EC44;
	Wed, 11 May 2022 07:22:38 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E8810EC44
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 07:22:36 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 gj17-20020a17090b109100b001d8b390f77bso4127882pjb.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 00:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y1uWYEteeWYV6MxL6Y1dmnWhReY3GBdVyCDTLxX8AkE=;
 b=m2AVy5ue+cwzjJLwkoIu3tefb/Rm/zuNuYKnz3kRdtMeXUSym8HSe20JS3ujo9+RdX
 Y7TSnt7SB8GjiBQ0wSUQTJpdLxVtTm5/vV068URyJqQYHzLwgcQA5wq3urSPOaIqWdOJ
 6ZfYnHQtf7SPf5f6Uiahqp8s02w8lz3eDqX5UPKcJKvmjIgdXn5cGszoaW84IZE6Aqzf
 rDh5IuFAxSgxveBG2buPX073pDHursD7z+A8ZoiOeuoy1jAZ36NfA7sPayr5Cupwkf5L
 yabv3BpurDltwpxIoCWHgH2PV14tmI/tnbrnvyh0E4fE7cQjJUayBOl1b2pcVDWYhF9r
 99Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y1uWYEteeWYV6MxL6Y1dmnWhReY3GBdVyCDTLxX8AkE=;
 b=ejoCYGamqX9NCNObVQXFIHJkYcliTof/CKvRwVh3dlS5Y/JnTblneaivqWrJgBoT4C
 D2gICl0AILXpoR/a1wxX28RbBtDj0E2uJznVsa8IV44u91xkv+N3PT7bGGUWXB2I1aVh
 Cq2ICSQ0PflZzO+Meh3K3Xo2KFAmkQoIsFS7qX6qFgMrCvHQuseBg7STztzHoBNpGEBX
 WQGbX9IfXGTlxBYqGl+E022pd4sfukx5nLV5HcuMCOkHoyHjXyjzbKelP4h1svQQC+2e
 B1IDhe5RNcQQzFLfn1nc5hH754e1cMiyOT/R+KJqa6Ibq92TI5RKqXYfuOizMgXlPpNy
 /WrA==
X-Gm-Message-State: AOAM530Jm8CXvB65PYaEQ5zjUUF+UV/GfW8wWodgSZvpXRDS7SJ5d0eA
 KdhCFltiSeDiusKFUd/aL7KzogetXh+S+Fa7BME7vBkh6Qg=
X-Google-Smtp-Source: ABdhPJzQ2KEtD91snHpxcDGPXq+fptUSwMbkVX46KVSyLiDgfK465Z0uWa7RnEU5glaTabwLX4oIO1NDSp9mGKG0DF8=
X-Received: by 2002:a17:902:d3d3:b0:15d:1eb8:c820 with SMTP id
 w19-20020a170902d3d300b0015d1eb8c820mr24631254plb.96.1652253756451; Wed, 11
 May 2022 00:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <20220506112312.347519-2-christian.koenig@amd.com>
 <CAAxE2A7+-MKrh1BoXhGNBY38_7PkvrmZvn-tg4-4CFNXBvdKqw@mail.gmail.com>
 <8695802e-6835-a717-c0ee-83b76d8a8875@gmail.com>
 <5941d83c-6d2b-6e3b-bd5c-b22779929d5e@amd.com>
In-Reply-To: <5941d83c-6d2b-6e3b-bd5c-b22779929d5e@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 11 May 2022 03:22:00 -0400
Message-ID: <CAAxE2A7-crNh7oTTzgm7W7J412_ijrmoiN9ip9iiS1MJmmaB4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: add AMDGPU_VM_NOALLOC
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: multipart/alternative; boundary="0000000000003b70ac05deb74ee8"
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000003b70ac05deb74ee8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bypass means that the contents of the cache are ignored, which decreases
latency at the cost of no coherency between bypassed and normal memory
requests. NOA (noalloc) means that the cache is checked and can give you
cache hits, but misses are not cached and the overall latency is higher. I
don't know what the hw does, but I hope it was misnamed and it really means
bypass because there is no point in doing cache lookups on every memory
request if the driver wants to disable caching to *decrease* latency in the
situations when the cache isn't helping.

Marek

On Wed, May 11, 2022 at 2:15 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:

>
>
> On 5/11/2022 11:36 AM, Christian K=C3=B6nig wrote:
> > Mhm, it doesn't really bypass MALL. It just doesn't allocate any MALL
> > entries on write.
> >
> > How about AMDGPU_VM_PAGE_NO_MALL ?
>
> One more - AMDGPU_VM_PAGE_LLC_* [ LLC =3D last level cache, * =3D some so=
rt
> of attribute which decides LLC behaviour]
>
> Thanks,
> Lijo
>
> >
> > Christian.
> >
> > Am 10.05.22 um 23:21 schrieb Marek Ol=C5=A1=C3=A1k:
> >> A better name would be:
> >> AMDGPU_VM_PAGE_BYPASS_MALL
> >>
> >> Marek
> >>
> >> On Fri, May 6, 2022 at 7:23 AM Christian K=C3=B6nig
> >> <ckoenig.leichtzumerken@gmail.com> wrote:
> >>
> >>     Add the AMDGPU_VM_NOALLOC flag to let userspace control MALL
> >>     allocation.
> >>
> >>     Only compile tested!
> >>
> >>     Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>     ---
> >>      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
> >>      drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3 +++
> >>      drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 3 +++
> >>      include/uapi/drm/amdgpu_drm.h           | 2 ++
> >>      4 files changed, 10 insertions(+)
> >>
> >>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>     index bf97d8f07f57..d8129626581f 100644
> >>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>     @@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_flags(struct
> >>     amdgpu_device *adev, uint32_t flags)
> >>                     pte_flag |=3D AMDGPU_PTE_WRITEABLE;
> >>             if (flags & AMDGPU_VM_PAGE_PRT)
> >>                     pte_flag |=3D AMDGPU_PTE_PRT;
> >>     +       if (flags & AMDGPU_VM_PAGE_NOALLOC)
> >>     +               pte_flag |=3D AMDGPU_PTE_NOALLOC;
> >>
> >>             if (adev->gmc.gmc_funcs->map_mtype)
> >>                     pte_flag |=3D amdgpu_gmc_map_mtype(adev,
> >>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >>     b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >>     index b8c79789e1e4..9077dfccaf3c 100644
> >>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >>     @@ -613,6 +613,9 @@ static void gmc_v10_0_get_vm_pte(struct
> >>     amdgpu_device *adev,
> >>             *flags &=3D ~AMDGPU_PTE_MTYPE_NV10_MASK;
> >>             *flags |=3D (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
> >>
> >>     +       *flags &=3D ~AMDGPU_PTE_NOALLOC;
> >>     +       *flags |=3D (mapping->flags & AMDGPU_PTE_NOALLOC);
> >>     +
> >>             if (mapping->flags & AMDGPU_PTE_PRT) {
> >>                     *flags |=3D AMDGPU_PTE_PRT;
> >>                     *flags |=3D AMDGPU_PTE_SNOOPED;
> >>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>     b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>     index 8d733eeac556..32ee56adb602 100644
> >>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >>     @@ -508,6 +508,9 @@ static void gmc_v11_0_get_vm_pte(struct
> >>     amdgpu_device *adev,
> >>             *flags &=3D ~AMDGPU_PTE_MTYPE_NV10_MASK;
> >>             *flags |=3D (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
> >>
> >>     +       *flags &=3D ~AMDGPU_PTE_NOALLOC;
> >>     +       *flags |=3D (mapping->flags & AMDGPU_PTE_NOALLOC);
> >>     +
> >>             if (mapping->flags & AMDGPU_PTE_PRT) {
> >>                     *flags |=3D AMDGPU_PTE_PRT;
> >>                     *flags |=3D AMDGPU_PTE_SNOOPED;
> >>     diff --git a/include/uapi/drm/amdgpu_drm.h
> >>     b/include/uapi/drm/amdgpu_drm.h
> >>     index 57b9d8f0133a..9d71d6330687 100644
> >>     --- a/include/uapi/drm/amdgpu_drm.h
> >>     +++ b/include/uapi/drm/amdgpu_drm.h
> >>     @@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {
> >>      #define AMDGPU_VM_MTYPE_UC             (4 << 5)
> >>      /* Use Read Write MTYPE instead of default MTYPE */
> >>      #define AMDGPU_VM_MTYPE_RW             (5 << 5)
> >>     +/* don't allocate MALL */
> >>     +#define AMDGPU_VM_PAGE_NOALLOC         (1 << 9)
> >>
> >>      struct drm_amdgpu_gem_va {
> >>             /** GEM object handle */
> >>     --
> >>     2.25.1
> >>
> >
>

--0000000000003b70ac05deb74ee8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Bypass means that the contents of the cac=
he are ignored, which decreases latency at the cost of no coherency between=
 bypassed and normal memory requests. NOA (noalloc) means that the cache is=
 checked and can give you cache hits, but misses are not cached and the ove=
rall latency is higher. I don&#39;t know what the hw does, but I hope it wa=
s misnamed and it really means bypass because there is no point in doing ca=
che lookups on every memory request if the driver wants to disable caching =
to *decrease* latency in the situations when the cache isn&#39;t helping.<b=
r></div><div dir=3D"ltr"><br></div><div>Marek<br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 11, 2022 at 2:=
15 AM Lazar, Lijo &lt;<a href=3D"mailto:lijo.lazar@amd.com">lijo.lazar@amd.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><br>
<br>
On 5/11/2022 11:36 AM, Christian K=C3=B6nig wrote:<br>
&gt; Mhm, it doesn&#39;t really bypass MALL. It just doesn&#39;t allocate a=
ny MALL <br>
&gt; entries on write.<br>
&gt; <br>
&gt; How about AMDGPU_VM_PAGE_NO_MALL ?<br>
<br>
One more - AMDGPU_VM_PAGE_LLC_* [ LLC =3D last level cache, * =3D some sort=
 <br>
of attribute which decides LLC behaviour]<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; <br>
&gt; Christian.<br>
&gt; <br>
&gt; Am 10.05.22 um 23:21 schrieb Marek Ol=C5=A1=C3=A1k:<br>
&gt;&gt; A better name would be:<br>
&gt;&gt; AMDGPU_VM_PAGE_BYPASS_MALL<br>
&gt;&gt;<br>
&gt;&gt; Marek<br>
&gt;&gt;<br>
&gt;&gt; On Fri, May 6, 2022 at 7:23 AM Christian K=C3=B6nig <br>
&gt;&gt; &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"=
_blank">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Add the AMDGPU_VM_NOALLOC flag to let userspace=
 control MALL<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0allocation.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Only compile tested!<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Christian K=C3=B6nig &lt;<a href=
=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd=
.com</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |=
 2 ++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c=C2=
=A0 | 3 +++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c=C2=
=A0 | 3 +++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A04 files changed, 10 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_=
gem.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0index bf97d8f07f57..d8129626581f 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_=
flags(struct<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_device *adev, uint32_t flags)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pte_flag |=3D AMDGPU_PTE_WRITEABLE;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; AMD=
GPU_VM_PAGE_PRT)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pte_flag |=3D AMDGPU_PTE_PRT;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; AMD=
GPU_VM_PAGE_NOALLOC)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pte_flag |=3D AMDGPU_PTE_NOALLOC;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;gmc.gm=
c_funcs-&gt;map_mtype)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pte_flag |=3D amdgpu_gmc_map_mtype(adev,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10=
_0.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0index b8c79789e1e4..9077dfccaf3c 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -613,6 +613,9 @@ static void gmc_v10_0_get_v=
m_pte(struct<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_device *adev,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags &amp;=3D ~AM=
DGPU_PTE_MTYPE_NV10_MASK;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D (mappin=
g-&gt;flags &amp; AMDGPU_PTE_MTYPE_NV10_MASK);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0*flags &amp;=3D ~AM=
DGPU_PTE_NOALLOC;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0*flags |=3D (mappin=
g-&gt;flags &amp; AMDGPU_PTE_NOALLOC);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mapping-&gt;fla=
gs &amp; AMDGPU_PTE_PRT) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *flags |=3D AMDGPU_PTE_PRT;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *flags |=3D AMDGPU_PTE_SNOOPED;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11=
_0.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0index 8d733eeac556..32ee56adb602 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -508,6 +508,9 @@ static void gmc_v11_0_get_v=
m_pte(struct<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_device *adev,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags &amp;=3D ~AM=
DGPU_PTE_MTYPE_NV10_MASK;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D (mappin=
g-&gt;flags &amp; AMDGPU_PTE_MTYPE_NV10_MASK);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0*flags &amp;=3D ~AM=
DGPU_PTE_NOALLOC;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0*flags |=3D (mappin=
g-&gt;flags &amp; AMDGPU_PTE_NOALLOC);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mapping-&gt;fla=
gs &amp; AMDGPU_PTE_PRT) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *flags |=3D AMDGPU_PTE_PRT;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *flags |=3D AMDGPU_PTE_SNOOPED;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0b/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0index 57b9d8f0133a..9d71d6330687 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0--- a/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#define AMDGPU_VM_MTYPE_UC=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(4 &lt;&lt; 5)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0/* Use Read Write MTYPE instead of defaul=
t MTYPE */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#define AMDGPU_VM_MTYPE_RW=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(5 &lt;&lt; 5)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+/* don&#39;t allocate MALL */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0+#define AMDGPU_VM_PAGE_NOALLOC=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 9)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0struct drm_amdgpu_gem_va {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** GEM object hand=
le */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A02.25.1<br>
&gt;&gt;<br>
&gt; <br>
</blockquote></div></div>

--0000000000003b70ac05deb74ee8--
