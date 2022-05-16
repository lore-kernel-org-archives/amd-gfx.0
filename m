Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B550C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 12:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D878A10F9C6;
	Mon, 16 May 2022 12:57:22 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF5D10F9C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 12:57:21 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id i8so404750plr.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SndaP2bZy3gNbsLDst3JgnCN7aeWDTvu9kqEUIpaQvc=;
 b=ZfjcjOPQ0hD7dJ0cIckLGFZA5s/QxwT6B4nH1EMtrlz0wzSIVaDNykyNqtTML3Nb01
 bzarsnUhPCbu9H+ke54xQWeIcqAIHSLXEkm85LAXpJOQXOJIxo3YQwhcKEEQlzvYZi9o
 NqH6Zx+NS0UCrU/I/LiBLWR2PwGk3getoFrjupnivFLbBKyLjcoXmufGUT5JTgNRKgSa
 NF3GrwEHbGUDdwtSkWMc9NGuTjuZVJewIpPcJsrxOGfOXSRoG4IFchZnypZM6ocCpGxD
 cJuB42V4n5RblMoqhQnJkJpSadfi7uVNOjaE/snnJrXaAoVOoIA+XsfC9wCbA6kIZ6Js
 FUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SndaP2bZy3gNbsLDst3JgnCN7aeWDTvu9kqEUIpaQvc=;
 b=vfCeUL8ia4SqOyFaL8txqZhvpYJKLCNCZ6rDal+33KTU7xBwO73HxaZLqv6ecxn4BO
 q9FlTwIZ9w40gB3OhpO6FJ5b+LII+gByKk8elR3GAgurEgF7nh+MSvw/uAluUDTZxhnL
 L7g8MyKAR3HlQYSmtfA9RutBIbfwNS1I/DH9eqXAjeZb/t3MOAI5NprngnqF6UmXLQAh
 DkejZWEf+U84JXlIFakmDcTbArKmiG18Ec7uK9p7J2Lj0Sf7Y5h9BpuFon4zs0eQ/DUb
 rsnG5Kjh4JcVIGnZK+t3gep1o4Ic7dJlA7B0F7g09G6CpvIzRq1VLTLoHkVbgUSTCJYm
 H3wQ==
X-Gm-Message-State: AOAM532uRIi/UO1DotgK9jqe8PvgMjzqU4nN1VZyV8NnnRyCuHcpyYDF
 OleHYfHm4ZOYGoVUYtkSuMxq9emPSoUjyLa9G88=
X-Google-Smtp-Source: ABdhPJzfC9vccqX7XAJMqVTBxAaBzNpGtd8BtjFL8CsqAT6Q1jWVbw4AqXKGc4H6RzaTpiTqXpEMmZh5JqnPPFQovCU=
X-Received: by 2002:a17:90b:1b42:b0:1dc:c56b:58a8 with SMTP id
 nv2-20020a17090b1b4200b001dcc56b58a8mr19355657pjb.73.1652705840773; Mon, 16
 May 2022 05:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <20220506112312.347519-2-christian.koenig@amd.com>
 <CAAxE2A7+-MKrh1BoXhGNBY38_7PkvrmZvn-tg4-4CFNXBvdKqw@mail.gmail.com>
 <8695802e-6835-a717-c0ee-83b76d8a8875@gmail.com>
 <5941d83c-6d2b-6e3b-bd5c-b22779929d5e@amd.com>
 <CAAxE2A7-crNh7oTTzgm7W7J412_ijrmoiN9ip9iiS1MJmmaB4A@mail.gmail.com>
 <e3de3d01-25fb-8839-c793-bde9188ba77a@gmail.com>
 <CAAxE2A4P1avEwz0cniZupD9ZkXfnxKJY+1OzAOPRQqnOUcE5OQ@mail.gmail.com>
 <CAAxE2A5yVDo-6HW9Jt_pO-VwnBFQXQJP9-r0kNThP5XO1KWkFw@mail.gmail.com>
 <CAAxE2A7TPhshFx7EJir9iS580XO7-1N1hJCpeoKXRvMH7au1gQ@mail.gmail.com>
 <e33d0e1a-8992-142d-5084-a8667110c172@gmail.com>
In-Reply-To: <e33d0e1a-8992-142d-5084-a8667110c172@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 16 May 2022 08:56:44 -0400
Message-ID: <CAAxE2A6-1znDCdZ-3WUbqjQw_B=Sr4qpXz3Hw4o8VA8EAPuVDg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: add AMDGPU_VM_NOALLOC
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000008ebdd505df2090c4"
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
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000008ebdd505df2090c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reproduction steps:
- use mesa/main on gfx10.3 (not sure what other GPUs do)
- run: radeonsi_mall_noalloc=3Dtrue glxgears

Marek

On Mon, May 16, 2022 at 7:53 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Crap, do you have a link to the failure?
>
> Am 16.05.22 um 13:10 schrieb Marek Ol=C5=A1=C3=A1k:
>
> I forgot to say: The NOALLOC flag causes an allocation failure, so there
> is a kernel bug somewhere.
>
> Marek
>
> On Mon, May 16, 2022 at 7:06 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> =
wrote:
>
>> FYI, I think it's time to merge this because the Mesa commits are going
>> to be merged in ~30 minutes if Gitlab CI is green, and that includes
>> updated amdgpu_drm.h.
>>
>> Marek
>>
>> On Wed, May 11, 2022 at 2:55 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>=
 wrote:
>>
>>> Ok sounds good.
>>>
>>> Marek
>>>
>>> On Wed., May 11, 2022, 03:43 Christian K=C3=B6nig, <
>>> ckoenig.leichtzumerken@gmail.com> wrote:
>>>
>>>> It really *is* a NOALLOC feature. In other words there is no latency
>>>> improvement on reads because the cache is always checked, even with th=
e
>>>> noalloc flag set.
>>>>
>>>> The only thing it affects is that misses not enter the cache and so
>>>> don't cause any additional pressure on evicting cache lines.
>>>>
>>>> You might want to double check with the hardware guys, but I'm
>>>> something like 95% sure that it works this way.
>>>>
>>>> Christian.
>>>>
>>>> Am 11.05.22 um 09:22 schrieb Marek Ol=C5=A1=C3=A1k:
>>>>
>>>> Bypass means that the contents of the cache are ignored, which
>>>> decreases latency at the cost of no coherency between bypassed and nor=
mal
>>>> memory requests. NOA (noalloc) means that the cache is checked and can=
 give
>>>> you cache hits, but misses are not cached and the overall latency is
>>>> higher. I don't know what the hw does, but I hope it was misnamed and =
it
>>>> really means bypass because there is no point in doing cache lookups o=
n
>>>> every memory request if the driver wants to disable caching to *decrea=
se*
>>>> latency in the situations when the cache isn't helping.
>>>>
>>>> Marek
>>>>
>>>> On Wed, May 11, 2022 at 2:15 AM Lazar, Lijo <lijo.lazar@amd.com> wrote=
:
>>>>
>>>>>
>>>>>
>>>>> On 5/11/2022 11:36 AM, Christian K=C3=B6nig wrote:
>>>>> > Mhm, it doesn't really bypass MALL. It just doesn't allocate any
>>>>> MALL
>>>>> > entries on write.
>>>>> >
>>>>> > How about AMDGPU_VM_PAGE_NO_MALL ?
>>>>>
>>>>> One more - AMDGPU_VM_PAGE_LLC_* [ LLC =3D last level cache, * =3D som=
e
>>>>> sort
>>>>> of attribute which decides LLC behaviour]
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>> >
>>>>> > Christian.
>>>>> >
>>>>> > Am 10.05.22 um 23:21 schrieb Marek Ol=C5=A1=C3=A1k:
>>>>> >> A better name would be:
>>>>> >> AMDGPU_VM_PAGE_BYPASS_MALL
>>>>> >>
>>>>> >> Marek
>>>>> >>
>>>>> >> On Fri, May 6, 2022 at 7:23 AM Christian K=C3=B6nig
>>>>> >> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>> >>
>>>>> >>     Add the AMDGPU_VM_NOALLOC flag to let userspace control MALL
>>>>> >>     allocation.
>>>>> >>
>>>>> >>     Only compile tested!
>>>>> >>
>>>>> >>     Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>>>>> >>     ---
>>>>> >>      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>>>>> >>      drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3 +++
>>>>> >>      drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 3 +++
>>>>> >>      include/uapi/drm/amdgpu_drm.h           | 2 ++
>>>>> >>      4 files changed, 10 insertions(+)
>>>>> >>
>>>>> >>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> >>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> >>     index bf97d8f07f57..d8129626581f 100644
>>>>> >>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> >>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> >>     @@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_flags(struct
>>>>> >>     amdgpu_device *adev, uint32_t flags)
>>>>> >>                     pte_flag |=3D AMDGPU_PTE_WRITEABLE;
>>>>> >>             if (flags & AMDGPU_VM_PAGE_PRT)
>>>>> >>                     pte_flag |=3D AMDGPU_PTE_PRT;
>>>>> >>     +       if (flags & AMDGPU_VM_PAGE_NOALLOC)
>>>>> >>     +               pte_flag |=3D AMDGPU_PTE_NOALLOC;
>>>>> >>
>>>>> >>             if (adev->gmc.gmc_funcs->map_mtype)
>>>>> >>                     pte_flag |=3D amdgpu_gmc_map_mtype(adev,
>>>>> >>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> >>     b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> >>     index b8c79789e1e4..9077dfccaf3c 100644
>>>>> >>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> >>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> >>     @@ -613,6 +613,9 @@ static void gmc_v10_0_get_vm_pte(struct
>>>>> >>     amdgpu_device *adev,
>>>>> >>             *flags &=3D ~AMDGPU_PTE_MTYPE_NV10_MASK;
>>>>> >>             *flags |=3D (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MA=
SK);
>>>>> >>
>>>>> >>     +       *flags &=3D ~AMDGPU_PTE_NOALLOC;
>>>>> >>     +       *flags |=3D (mapping->flags & AMDGPU_PTE_NOALLOC);
>>>>> >>     +
>>>>> >>             if (mapping->flags & AMDGPU_PTE_PRT) {
>>>>> >>                     *flags |=3D AMDGPU_PTE_PRT;
>>>>> >>                     *flags |=3D AMDGPU_PTE_SNOOPED;
>>>>> >>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> >>     b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> >>     index 8d733eeac556..32ee56adb602 100644
>>>>> >>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> >>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> >>     @@ -508,6 +508,9 @@ static void gmc_v11_0_get_vm_pte(struct
>>>>> >>     amdgpu_device *adev,
>>>>> >>             *flags &=3D ~AMDGPU_PTE_MTYPE_NV10_MASK;
>>>>> >>             *flags |=3D (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MA=
SK);
>>>>> >>
>>>>> >>     +       *flags &=3D ~AMDGPU_PTE_NOALLOC;
>>>>> >>     +       *flags |=3D (mapping->flags & AMDGPU_PTE_NOALLOC);
>>>>> >>     +
>>>>> >>             if (mapping->flags & AMDGPU_PTE_PRT) {
>>>>> >>                     *flags |=3D AMDGPU_PTE_PRT;
>>>>> >>                     *flags |=3D AMDGPU_PTE_SNOOPED;
>>>>> >>     diff --git a/include/uapi/drm/amdgpu_drm.h
>>>>> >>     b/include/uapi/drm/amdgpu_drm.h
>>>>> >>     index 57b9d8f0133a..9d71d6330687 100644
>>>>> >>     --- a/include/uapi/drm/amdgpu_drm.h
>>>>> >>     +++ b/include/uapi/drm/amdgpu_drm.h
>>>>> >>     @@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {
>>>>> >>      #define AMDGPU_VM_MTYPE_UC             (4 << 5)
>>>>> >>      /* Use Read Write MTYPE instead of default MTYPE */
>>>>> >>      #define AMDGPU_VM_MTYPE_RW             (5 << 5)
>>>>> >>     +/* don't allocate MALL */
>>>>> >>     +#define AMDGPU_VM_PAGE_NOALLOC         (1 << 9)
>>>>> >>
>>>>> >>      struct drm_amdgpu_gem_va {
>>>>> >>             /** GEM object handle */
>>>>> >>     --
>>>>> >>     2.25.1
>>>>> >>
>>>>> >
>>>>>
>>>>
>>>>
>

--0000000000008ebdd505df2090c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Reproduction steps:</div><div>- use mesa/=
main on gfx10.3 (not sure what other GPUs do)<br></div><div>- run: radeonsi=
_mall_noalloc=3Dtrue glxgears</div><div><br></div><div>Marek<br></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May=
 16, 2022 at 7:53 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.lei=
chtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Crap, do you have a link to the failure?<br>
    <br>
    <div>Am 16.05.22 um 13:10 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>I forgot to say: The NOALLOC flag causes an allocation
          failure, so there is a kernel bug somewhere.</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 16, 2022 at 7:06
          AM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" =
target=3D"_blank">maraeo@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir=3D"ltr">
            <div>FYI, I think it&#39;s time to merge this because the Mesa
              commits are going to be merged in ~30 minutes if Gitlab CI
              is green, and that includes updated amdgpu_drm.h.</div>
            <div><br>
            </div>
            <div>Marek<br>
            </div>
          </div>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 11, 2022 at
              2:55 PM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gm=
ail.com" target=3D"_blank">maraeo@gmail.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div dir=3D"auto">Ok sounds good.
                <div dir=3D"auto"><br>
                </div>
                <div dir=3D"auto">Marek</div>
              </div>
              <br>
              <div class=3D"gmail_quote">
                <div dir=3D"ltr" class=3D"gmail_attr">On Wed., May 11, 2022=
,
                  03:43 Christian K=C3=B6nig, &lt;<a href=3D"mailto:ckoenig=
.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.c=
om</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  <div> It really *is* a NOALLOC feature. In other words
                    there is no latency improvement on reads because the
                    cache is always checked, even with the noalloc flag
                    set.<br>
                    <br>
                    The only thing it affects is that misses not enter
                    the cache and so don&#39;t cause any additional pressur=
e
                    on evicting cache lines.<br>
                    <br>
                    You might want to double check with the hardware
                    guys, but I&#39;m something like 95% sure that it works
                    this way.<br>
                    <br>
                    Christian.<br>
                    <br>
                    <div>Am 11.05.22 um 09:22 schrieb Marek Ol=C5=A1=C3=A1k=
:<br>
                    </div>
                    <blockquote type=3D"cite">
                      <div dir=3D"ltr">
                        <div dir=3D"ltr">Bypass means that the contents of
                          the cache are ignored, which decreases latency
                          at the cost of no coherency between bypassed
                          and normal memory requests. NOA (noalloc)
                          means that the cache is checked and can give
                          you cache hits, but misses are not cached and
                          the overall latency is higher. I don&#39;t know
                          what the hw does, but I hope it was misnamed
                          and it really means bypass because there is no
                          point in doing cache lookups on every memory
                          request if the driver wants to disable caching
                          to *decrease* latency in the situations when
                          the cache isn&#39;t helping.<br>
                        </div>
                        <div dir=3D"ltr"><br>
                        </div>
                        <div>Marek<br>
                        </div>
                        <br>
                        <div class=3D"gmail_quote">
                          <div dir=3D"ltr" class=3D"gmail_attr">On Wed, May
                            11, 2022 at 2:15 AM Lazar, Lijo &lt;<a href=3D"=
mailto:lijo.lazar@amd.com" rel=3D"noreferrer" target=3D"_blank">lijo.lazar@=
amd.com</a>&gt;
                            wrote:<br>
                          </div>
                          <blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><br>
                            <br>
                            On 5/11/2022 11:36 AM, Christian K=C3=B6nig
                            wrote:<br>
                            &gt; Mhm, it doesn&#39;t really bypass MALL. It
                            just doesn&#39;t allocate any MALL <br>
                            &gt; entries on write.<br>
                            &gt; <br>
                            &gt; How about AMDGPU_VM_PAGE_NO_MALL ?<br>
                            <br>
                            One more - AMDGPU_VM_PAGE_LLC_* [ LLC =3D last
                            level cache, * =3D some sort <br>
                            of attribute which decides LLC behaviour]<br>
                            <br>
                            Thanks,<br>
                            Lijo<br>
                            <br>
                            &gt; <br>
                            &gt; Christian.<br>
                            &gt; <br>
                            &gt; Am 10.05.22 um 23:21 schrieb Marek
                            Ol=C5=A1=C3=A1k:<br>
                            &gt;&gt; A better name would be:<br>
                            &gt;&gt; AMDGPU_VM_PAGE_BYPASS_MALL<br>
                            &gt;&gt;<br>
                            &gt;&gt; Marek<br>
                            &gt;&gt;<br>
                            &gt;&gt; On Fri, May 6, 2022 at 7:23 AM
                            Christian K=C3=B6nig <br>
                            &gt;&gt; &lt;<a href=3D"mailto:ckoenig.leichtzu=
merken@gmail.com" rel=3D"noreferrer" target=3D"_blank">ckoenig.leichtzumerk=
en@gmail.com</a>&gt;
                            wrote:<br>
                            &gt;&gt;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0Add the AMDGPU_VM_N=
OALLOC flag
                            to let userspace control MALL<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0allocation.<br>
                            &gt;&gt;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0Only compile tested=
!<br>
                            &gt;&gt;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Chri=
stian K=C3=B6nig
                            &lt;<a href=3D"mailto:christian.koenig@amd.com"=
 rel=3D"noreferrer" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0---<br>
                            &gt;&gt;=C2=A0 =C2=A0
                            =C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_g=
em.c |
                            2 ++<br>
                            &gt;&gt;=C2=A0 =C2=A0
                            =C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_v10_=
0.c=C2=A0 |
                            3 +++<br>
                            &gt;&gt;=C2=A0 =C2=A0
                            =C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_v11_=
0.c=C2=A0 |
                            3 +++<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0include/uapi/=
drm/amdgpu_drm.h=C2=A0
                            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A04 files chang=
ed, 10
                            insertions(+)<br>
                            &gt;&gt;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --git
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
                            &gt;&gt;=C2=A0 =C2=A0
                            =C2=A0b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c=
<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0index
                            bf97d8f07f57..d8129626581f 100644<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0---
                            a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+++
                            b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -650,6 +650,8 @@=
 uint64_t
                            amdgpu_gem_va_map_flags(struct<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_device *adev=
, uint32_t
                            flags)<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pte_flag |=3D
                            AMDGPU_PTE_WRITEABLE;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (flags &amp;
                            AMDGPU_VM_PAGE_PRT)<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pte_flag |=3D
                            AMDGPU_PTE_PRT;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (flags &amp;
                            AMDGPU_VM_PAGE_NOALLOC)<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pte_flag |=3D
                            AMDGPU_PTE_NOALLOC;<br>
                            &gt;&gt;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if
                            (adev-&gt;gmc.gmc_funcs-&gt;map_mtype)<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pte_flag |=3D
                            amdgpu_gmc_map_mtype(adev,<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --git
                            a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                            &gt;&gt;=C2=A0 =C2=A0
                            =C2=A0b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<=
br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0index
                            b8c79789e1e4..9077dfccaf3c 100644<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0---
                            a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+++
                            b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -613,6 +613,9 @@=
 static void
                            gmc_v10_0_get_vm_pte(struct<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_device *adev=
,<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *flags &amp;=3D
                            ~AMDGPU_PTE_MTYPE_NV10_MASK;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *flags |=3D
                            (mapping-&gt;flags &amp;
                            AMDGPU_PTE_MTYPE_NV10_MASK);<br>
                            &gt;&gt;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0*flags &amp;=3D
                            ~AMDGPU_PTE_NOALLOC;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0*flags |=3D
                            (mapping-&gt;flags &amp;
                            AMDGPU_PTE_NOALLOC);<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (mapping-&gt;flags
                            &amp; AMDGPU_PTE_PRT) {<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D
                            AMDGPU_PTE_PRT;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D
                            AMDGPU_PTE_SNOOPED;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --git
                            a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
                            &gt;&gt;=C2=A0 =C2=A0
                            =C2=A0b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<=
br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0index
                            8d733eeac556..32ee56adb602 100644<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0---
                            a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+++
                            b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -508,6 +508,9 @@=
 static void
                            gmc_v11_0_get_vm_pte(struct<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_device *adev=
,<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *flags &amp;=3D
                            ~AMDGPU_PTE_MTYPE_NV10_MASK;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *flags |=3D
                            (mapping-&gt;flags &amp;
                            AMDGPU_PTE_MTYPE_NV10_MASK);<br>
                            &gt;&gt;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0*flags &amp;=3D
                            ~AMDGPU_PTE_NOALLOC;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0*flags |=3D
                            (mapping-&gt;flags &amp;
                            AMDGPU_PTE_NOALLOC);<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (mapping-&gt;flags
                            &amp; AMDGPU_PTE_PRT) {<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D
                            AMDGPU_PTE_PRT;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D
                            AMDGPU_PTE_SNOOPED;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --git
                            a/include/uapi/drm/amdgpu_drm.h<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0b/include/uapi/drm/=
amdgpu_drm.h<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0index
                            57b9d8f0133a..9d71d6330687 100644<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0---
                            a/include/uapi/drm/amdgpu_drm.h<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+++
                            b/include/uapi/drm/amdgpu_drm.h<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -533,6 +533,8 @@=
 struct
                            drm_amdgpu_gem_op {<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#define AMDGP=
U_VM_MTYPE_UC=C2=A0 =C2=A0
                            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(4 &lt;&lt; 5=
)<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0/* Use Read W=
rite MTYPE
                            instead of default MTYPE */<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#define AMDGP=
U_VM_MTYPE_RW=C2=A0 =C2=A0
                            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(5 &lt;&lt; 5=
)<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+/* don&#39;t alloc=
ate MALL */<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0+#define
                            AMDGPU_VM_PAGE_NOALLOC=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt;
                            9)<br>
                            &gt;&gt;<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0struct drm_am=
dgpu_gem_va {<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /** GEM object handle
                            */<br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
                            &gt;&gt;=C2=A0 =C2=A0 =C2=A02.25.1<br>
                            &gt;&gt;<br>
                            &gt; <br>
                          </blockquote>
                        </div>
                      </div>
                    </blockquote>
                    <br>
                  </div>
                </blockquote>
              </div>
            </blockquote>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div></div>

--0000000000008ebdd505df2090c4--
