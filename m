Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445F6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 00:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C147F10E365;
	Tue, 17 May 2022 00:12:30 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC3B10E365
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 00:12:29 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-2ff155c239bso26134077b3.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 17:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tffnRruQBUKhyc7fK5acUSHFHJRr20h/clASbwajb8k=;
 b=mWhbH28/VNXYXtJ1z51ATdPjeF5jlDElqunaM1zJw56GkW/QfvMciilx/nAaKoBc6D
 OGGpw6OWq7zbLR38yvGLG/nkFe0SLuOeoWU+xbZQD8k4qIFd08QZqe9TMC9Y7wgFDzxB
 rV78lCVw/XcVDIbBP4aiYufUemI84TADSY/BxnoBJSSSvzQKWsG6OXtOoHjUzf85XzgP
 5vLC2fqAa5T6CyVA6IERlp+Z21yVzgt1axsQdX0Gz2gHs2PGBn+ZxgsElmthZ3qiDLuV
 3W2mGQRW/iust8Xu980y3ac8Uk9wdaW0jPRNWY4uWFGM5AaN9p1kRc13H8YprL+pyT3J
 DZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tffnRruQBUKhyc7fK5acUSHFHJRr20h/clASbwajb8k=;
 b=DSqkJniGuRWW/U0/aEO+9V2XGJsPvj+oiNA7nEEzmTukla9AQ7AmSThhyPGs1V/6vs
 qd1eN7I/ccjne2Bf5V0Ok5Il9SBiSmnZ+Bhj3hWyQW7C6eJcUrlR8F+1pW6kiZEI/EER
 yzPMw6khk8prnZLiUoc1f3XTyyq6zEJ85gT3ysHY66aHdguwFIAx9/OW5x52sTmBo3Tr
 bV6ybstLMtuD9bDurhF2RqKBWwmEf11imdV9USEPtHUhVQXiFwOTH4nb/k7U2n+LdMX5
 8WCEjCUHNibBnEK2LdF56X7ImUlmMpZkxYmE1EYfYJ0RrQQH5k6Q2H7HPgbynDrgQozW
 2//A==
X-Gm-Message-State: AOAM532+OKParKjVmFLT+FW0SwWf3QeFCIQbbmTY6UTl35BEecxyy6hh
 B90dd2nEGWc4cVbtg8gbWIIrLFYyJsxZl6lAFbI=
X-Google-Smtp-Source: ABdhPJwAMXHJ3g8rXFhv0yKnF46gkADt4ypAD6NUdJIby4YwdomeOuA620mVxB8uUO4hT2t8CyaiHH530D20acLUbVU=
X-Received: by 2002:a0d:f305:0:b0:2ef:21e3:54dd with SMTP id
 c5-20020a0df305000000b002ef21e354ddmr14367955ywf.438.1652746348265; Mon, 16
 May 2022 17:12:28 -0700 (PDT)
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
 <CAAxE2A6-1znDCdZ-3WUbqjQw_B=Sr4qpXz3Hw4o8VA8EAPuVDg@mail.gmail.com>
 <c0eb4a43-95b3-9db9-b095-685e900819cb@gmail.com>
In-Reply-To: <c0eb4a43-95b3-9db9-b095-685e900819cb@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 16 May 2022 20:12:11 -0400
Message-ID: <CAAxE2A4YLny1a5p-WHd_=gTTXWZYa3x50DSeE2zW+zV3iBtWYw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: add AMDGPU_VM_NOALLOC
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000fe075d05df29fe28"
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

--000000000000fe075d05df29fe28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmesg doesn't contain anything. There is no backtrace because it's not a
crash. The VA map ioctl just fails with the new flag. It looks like the
flag is considered invalid.

Marek

On Mon., May 16, 2022, 12:13 Christian K=C3=B6nig, <
ckoenig.leichtzumerken@gmail.com> wrote:

> I don't have access to any gfx10 hardware.
>
> Can you give me a dmesg and/or backtrace, etc..?
>
> I can't push this unless it's working properly.
>
> Christian.
>
> Am 16.05.22 um 14:56 schrieb Marek Ol=C5=A1=C3=A1k:
>
> Reproduction steps:
> - use mesa/main on gfx10.3 (not sure what other GPUs do)
> - run: radeonsi_mall_noalloc=3Dtrue glxgears
>
> Marek
>
> On Mon, May 16, 2022 at 7:53 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Crap, do you have a link to the failure?
>>
>> Am 16.05.22 um 13:10 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> I forgot to say: The NOALLOC flag causes an allocation failure, so there
>> is a kernel bug somewhere.
>>
>> Marek
>>
>> On Mon, May 16, 2022 at 7:06 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>=
 wrote:
>>
>>> FYI, I think it's time to merge this because the Mesa commits are going
>>> to be merged in ~30 minutes if Gitlab CI is green, and that includes
>>> updated amdgpu_drm.h.
>>>
>>> Marek
>>>
>>> On Wed, May 11, 2022 at 2:55 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com=
> wrote:
>>>
>>>> Ok sounds good.
>>>>
>>>> Marek
>>>>
>>>> On Wed., May 11, 2022, 03:43 Christian K=C3=B6nig, <
>>>> ckoenig.leichtzumerken@gmail.com> wrote:
>>>>
>>>>> It really *is* a NOALLOC feature. In other words there is no latency
>>>>> improvement on reads because the cache is always checked, even with t=
he
>>>>> noalloc flag set.
>>>>>
>>>>> The only thing it affects is that misses not enter the cache and so
>>>>> don't cause any additional pressure on evicting cache lines.
>>>>>
>>>>> You might want to double check with the hardware guys, but I'm
>>>>> something like 95% sure that it works this way.
>>>>>
>>>>> Christian.
>>>>>
>>>>> Am 11.05.22 um 09:22 schrieb Marek Ol=C5=A1=C3=A1k:
>>>>>
>>>>> Bypass means that the contents of the cache are ignored, which
>>>>> decreases latency at the cost of no coherency between bypassed and no=
rmal
>>>>> memory requests. NOA (noalloc) means that the cache is checked and ca=
n give
>>>>> you cache hits, but misses are not cached and the overall latency is
>>>>> higher. I don't know what the hw does, but I hope it was misnamed and=
 it
>>>>> really means bypass because there is no point in doing cache lookups =
on
>>>>> every memory request if the driver wants to disable caching to *decre=
ase*
>>>>> latency in the situations when the cache isn't helping.
>>>>>
>>>>> Marek
>>>>>
>>>>> On Wed, May 11, 2022 at 2:15 AM Lazar, Lijo <lijo.lazar@amd.com>
>>>>> wrote:
>>>>>
>>>>>>
>>>>>>
>>>>>> On 5/11/2022 11:36 AM, Christian K=C3=B6nig wrote:
>>>>>> > Mhm, it doesn't really bypass MALL. It just doesn't allocate any
>>>>>> MALL
>>>>>> > entries on write.
>>>>>> >
>>>>>> > How about AMDGPU_VM_PAGE_NO_MALL ?
>>>>>>
>>>>>> One more - AMDGPU_VM_PAGE_LLC_* [ LLC =3D last level cache, * =3D so=
me
>>>>>> sort
>>>>>> of attribute which decides LLC behaviour]
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>> >
>>>>>> > Christian.
>>>>>> >
>>>>>> > Am 10.05.22 um 23:21 schrieb Marek Ol=C5=A1=C3=A1k:
>>>>>> >> A better name would be:
>>>>>> >> AMDGPU_VM_PAGE_BYPASS_MALL
>>>>>> >>
>>>>>> >> Marek
>>>>>> >>
>>>>>> >> On Fri, May 6, 2022 at 7:23 AM Christian K=C3=B6nig
>>>>>> >> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>>> >>
>>>>>> >>     Add the AMDGPU_VM_NOALLOC flag to let userspace control MALL
>>>>>> >>     allocation.
>>>>>> >>
>>>>>> >>     Only compile tested!
>>>>>> >>
>>>>>> >>     Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com=
>
>>>>>> >>     ---
>>>>>> >>      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>>>>>> >>      drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3 +++
>>>>>> >>      drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 3 +++
>>>>>> >>      include/uapi/drm/amdgpu_drm.h           | 2 ++
>>>>>> >>      4 files changed, 10 insertions(+)
>>>>>> >>
>>>>>> >>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>>> >>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>>> >>     index bf97d8f07f57..d8129626581f 100644
>>>>>> >>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>>> >>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>>> >>     @@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_flags(struct
>>>>>> >>     amdgpu_device *adev, uint32_t flags)
>>>>>> >>                     pte_flag |=3D AMDGPU_PTE_WRITEABLE;
>>>>>> >>             if (flags & AMDGPU_VM_PAGE_PRT)
>>>>>> >>                     pte_flag |=3D AMDGPU_PTE_PRT;
>>>>>> >>     +       if (flags & AMDGPU_VM_PAGE_NOALLOC)
>>>>>> >>     +               pte_flag |=3D AMDGPU_PTE_NOALLOC;
>>>>>> >>
>>>>>> >>             if (adev->gmc.gmc_funcs->map_mtype)
>>>>>> >>                     pte_flag |=3D amdgpu_gmc_map_mtype(adev,
>>>>>> >>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> >>     b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> >>     index b8c79789e1e4..9077dfccaf3c 100644
>>>>>> >>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> >>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> >>     @@ -613,6 +613,9 @@ static void gmc_v10_0_get_vm_pte(struct
>>>>>> >>     amdgpu_device *adev,
>>>>>> >>             *flags &=3D ~AMDGPU_PTE_MTYPE_NV10_MASK;
>>>>>> >>             *flags |=3D (mapping->flags &
>>>>>> AMDGPU_PTE_MTYPE_NV10_MASK);
>>>>>> >>
>>>>>> >>     +       *flags &=3D ~AMDGPU_PTE_NOALLOC;
>>>>>> >>     +       *flags |=3D (mapping->flags & AMDGPU_PTE_NOALLOC);
>>>>>> >>     +
>>>>>> >>             if (mapping->flags & AMDGPU_PTE_PRT) {
>>>>>> >>                     *flags |=3D AMDGPU_PTE_PRT;
>>>>>> >>                     *flags |=3D AMDGPU_PTE_SNOOPED;
>>>>>> >>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> >>     b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> >>     index 8d733eeac556..32ee56adb602 100644
>>>>>> >>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> >>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>> >>     @@ -508,6 +508,9 @@ static void gmc_v11_0_get_vm_pte(struct
>>>>>> >>     amdgpu_device *adev,
>>>>>> >>             *flags &=3D ~AMDGPU_PTE_MTYPE_NV10_MASK;
>>>>>> >>             *flags |=3D (mapping->flags &
>>>>>> AMDGPU_PTE_MTYPE_NV10_MASK);
>>>>>> >>
>>>>>> >>     +       *flags &=3D ~AMDGPU_PTE_NOALLOC;
>>>>>> >>     +       *flags |=3D (mapping->flags & AMDGPU_PTE_NOALLOC);
>>>>>> >>     +
>>>>>> >>             if (mapping->flags & AMDGPU_PTE_PRT) {
>>>>>> >>                     *flags |=3D AMDGPU_PTE_PRT;
>>>>>> >>                     *flags |=3D AMDGPU_PTE_SNOOPED;
>>>>>> >>     diff --git a/include/uapi/drm/amdgpu_drm.h
>>>>>> >>     b/include/uapi/drm/amdgpu_drm.h
>>>>>> >>     index 57b9d8f0133a..9d71d6330687 100644
>>>>>> >>     --- a/include/uapi/drm/amdgpu_drm.h
>>>>>> >>     +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>> >>     @@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {
>>>>>> >>      #define AMDGPU_VM_MTYPE_UC             (4 << 5)
>>>>>> >>      /* Use Read Write MTYPE instead of default MTYPE */
>>>>>> >>      #define AMDGPU_VM_MTYPE_RW             (5 << 5)
>>>>>> >>     +/* don't allocate MALL */
>>>>>> >>     +#define AMDGPU_VM_PAGE_NOALLOC         (1 << 9)
>>>>>> >>
>>>>>> >>      struct drm_amdgpu_gem_va {
>>>>>> >>             /** GEM object handle */
>>>>>> >>     --
>>>>>> >>     2.25.1
>>>>>> >>
>>>>>> >
>>>>>>
>>>>>
>>>>>
>>
>

--000000000000fe075d05df29fe28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Dmesg doesn&#39;t contain anything. There is no backtrace=
 because it&#39;s not a crash. The VA map ioctl just fails with the new fla=
g. It looks like the flag is considered invalid.<div dir=3D"auto"><br></div=
><div dir=3D"auto">Marek</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon., May 16, 2022, 12:13 Christian K=C3=
=B6nig, &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.lei=
chtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
 =20
   =20
 =20
  <div>
    I don&#39;t have access to any gfx10 hardware.<br>
    <br>
    Can you give me a dmesg and/or backtrace, etc..?<br>
    <br>
    I can&#39;t push this unless it&#39;s working properly.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 16.05.22 um 14:56 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr">Reproduction steps:</div>
        <div>- use mesa/main on gfx10.3 (not sure what other GPUs do)<br>
        </div>
        <div>- run: radeonsi_mall_noalloc=3Dtrue glxgears</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 16, 2022 at 7:5=
3
            AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzum=
erken@gmail.com" target=3D"_blank" rel=3D"noreferrer">ckoenig.leichtzumerke=
n@gmail.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div> Crap, do you have a link to the failure?<br>
              <br>
              <div>Am 16.05.22 um 13:10 schrieb Marek Ol=C5=A1=C3=A1k:<br>
              </div>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">
                  <div>I forgot to say: The NOALLOC flag causes an
                    allocation failure, so there is a kernel bug
                    somewhere.</div>
                  <div><br>
                  </div>
                  <div>Marek<br>
                  </div>
                </div>
                <br>
                <div class=3D"gmail_quote">
                  <div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 16, 202=
2
                    at 7:06 AM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:=
maraeo@gmail.com" target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.com</a>=
&gt;
                    wrote:<br>
                  </div>
                  <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                    <div dir=3D"ltr">
                      <div>FYI, I think it&#39;s time to merge this because
                        the Mesa commits are going to be merged in ~30
                        minutes if Gitlab CI is green, and that includes
                        updated amdgpu_drm.h.</div>
                      <div><br>
                      </div>
                      <div>Marek<br>
                      </div>
                    </div>
                    <br>
                    <div class=3D"gmail_quote">
                      <div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 11,
                        2022 at 2:55 PM Marek Ol=C5=A1=C3=A1k &lt;<a href=
=3D"mailto:maraeo@gmail.com" target=3D"_blank" rel=3D"noreferrer">maraeo@gm=
ail.com</a>&gt;
                        wrote:<br>
                      </div>
                      <blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                        <div dir=3D"auto">Ok sounds good.
                          <div dir=3D"auto"><br>
                          </div>
                          <div dir=3D"auto">Marek</div>
                        </div>
                        <br>
                        <div class=3D"gmail_quote">
                          <div dir=3D"ltr" class=3D"gmail_attr">On Wed., Ma=
y
                            11, 2022, 03:43 Christian K=C3=B6nig, &lt;<a hr=
ef=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank" rel=3D"nor=
eferrer">ckoenig.leichtzumerken@gmail.com</a>&gt;
                            wrote:<br>
                          </div>
                          <blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
                            <div> It really *is* a NOALLOC feature. In
                              other words there is no latency
                              improvement on reads because the cache is
                              always checked, even with the noalloc flag
                              set.<br>
                              <br>
                              The only thing it affects is that misses
                              not enter the cache and so don&#39;t cause an=
y
                              additional pressure on evicting cache
                              lines.<br>
                              <br>
                              You might want to double check with the
                              hardware guys, but I&#39;m something like 95%
                              sure that it works this way.<br>
                              <br>
                              Christian.<br>
                              <br>
                              <div>Am 11.05.22 um 09:22 schrieb Marek
                                Ol=C5=A1=C3=A1k:<br>
                              </div>
                              <blockquote type=3D"cite">
                                <div dir=3D"ltr">
                                  <div dir=3D"ltr">Bypass means that the
                                    contents of the cache are ignored,
                                    which decreases latency at the cost
                                    of no coherency between bypassed and
                                    normal memory requests. NOA
                                    (noalloc) means that the cache is
                                    checked and can give you cache hits,
                                    but misses are not cached and the
                                    overall latency is higher. I don&#39;t
                                    know what the hw does, but I hope it
                                    was misnamed and it really means
                                    bypass because there is no point in
                                    doing cache lookups on every memory
                                    request if the driver wants to
                                    disable caching to *decrease*
                                    latency in the situations when the
                                    cache isn&#39;t helping.<br>
                                  </div>
                                  <div dir=3D"ltr"><br>
                                  </div>
                                  <div>Marek<br>
                                  </div>
                                  <br>
                                  <div class=3D"gmail_quote">
                                    <div dir=3D"ltr" class=3D"gmail_attr">O=
n
                                      Wed, May 11, 2022 at 2:15 AM
                                      Lazar, Lijo &lt;<a href=3D"mailto:lij=
o.lazar@amd.com" rel=3D"noreferrer noreferrer" target=3D"_blank">lijo.lazar=
@amd.com</a>&gt;
                                      wrote:<br>
                                    </div>
                                    <blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
                                      <br>
                                      On 5/11/2022 11:36 AM, Christian
                                      K=C3=B6nig wrote:<br>
                                      &gt; Mhm, it doesn&#39;t really bypas=
s
                                      MALL. It just doesn&#39;t allocate an=
y
                                      MALL <br>
                                      &gt; entries on write.<br>
                                      &gt; <br>
                                      &gt; How about
                                      AMDGPU_VM_PAGE_NO_MALL ?<br>
                                      <br>
                                      One more - AMDGPU_VM_PAGE_LLC_* [
                                      LLC =3D last level cache, * =3D some
                                      sort <br>
                                      of attribute which decides LLC
                                      behaviour]<br>
                                      <br>
                                      Thanks,<br>
                                      Lijo<br>
                                      <br>
                                      &gt; <br>
                                      &gt; Christian.<br>
                                      &gt; <br>
                                      &gt; Am 10.05.22 um 23:21 schrieb
                                      Marek Ol=C5=A1=C3=A1k:<br>
                                      &gt;&gt; A better name would be:<br>
                                      &gt;&gt;
                                      AMDGPU_VM_PAGE_BYPASS_MALL<br>
                                      &gt;&gt;<br>
                                      &gt;&gt; Marek<br>
                                      &gt;&gt;<br>
                                      &gt;&gt; On Fri, May 6, 2022 at
                                      7:23 AM Christian K=C3=B6nig <br>
                                      &gt;&gt; &lt;<a href=3D"mailto:ckoeni=
g.leichtzumerken@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank"=
>ckoenig.leichtzumerken@gmail.com</a>&gt;
                                      wrote:<br>
                                      &gt;&gt;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0Add the
                                      AMDGPU_VM_NOALLOC flag to let
                                      userspace control MALL<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0allocatio=
n.<br>
                                      &gt;&gt;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0Only comp=
ile tested!<br>
                                      &gt;&gt;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0Signed-of=
f-by:
                                      Christian K=C3=B6nig &lt;<a href=3D"m=
ailto:christian.koenig@amd.com" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">christian.koenig@amd.com</a>&gt;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0---<br>
                                      &gt;&gt;=C2=A0 =C2=A0
                                      =C2=A0=C2=A0drivers/gpu/drm/amd/amdgp=
u/amdgpu_gem.c
                                      | 2 ++<br>
                                      &gt;&gt;=C2=A0 =C2=A0
                                      =C2=A0=C2=A0drivers/gpu/drm/amd/amdgp=
u/gmc_v10_0.c=C2=A0
                                      | 3 +++<br>
                                      &gt;&gt;=C2=A0 =C2=A0
                                      =C2=A0=C2=A0drivers/gpu/drm/amd/amdgp=
u/gmc_v11_0.c=C2=A0
                                      | 3 +++<br>
                                      &gt;&gt;=C2=A0 =C2=A0
                                      =C2=A0=C2=A0include/uapi/drm/amdgpu_d=
rm.h=C2=A0 =C2=A0
                                      =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A04 f=
iles changed, 10
                                      insertions(+)<br>
                                      &gt;&gt;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --gi=
t
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_g=
em.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0
                                      =C2=A0b/drivers/gpu/drm/amd/amdgpu/am=
dgpu_gem.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0index
                                      bf97d8f07f57..d8129626581f 100644<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0---
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_g=
em.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+++
                                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_g=
em.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -650,6=
 +650,8 @@
                                      uint64_t
                                      amdgpu_gem_va_map_flags(struct<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_de=
vice *adev,
                                      uint32_t flags)<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                      pte_flag |=3D AMDGPU_PTE_WRITEABLE;<b=
r>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (flags
                                      &amp; AMDGPU_VM_PAGE_PRT)<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                      pte_flag |=3D AMDGPU_PTE_PRT;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (flags
                                      &amp; AMDGPU_VM_PAGE_NOALLOC)<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                      =C2=A0pte_flag |=3D AMDGPU_PTE_NOALLO=
C;<br>
                                      &gt;&gt;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if
                                      (adev-&gt;gmc.gmc_funcs-&gt;map_mtype=
)<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                      pte_flag |=3D
                                      amdgpu_gmc_map_mtype(adev,<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --gi=
t
                                      a/drivers/gpu/drm/amd/amdgpu/gmc_v10_=
0.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0
                                      =C2=A0b/drivers/gpu/drm/amd/amdgpu/gm=
c_v10_0.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0index
                                      b8c79789e1e4..9077dfccaf3c 100644<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0---
                                      a/drivers/gpu/drm/amd/amdgpu/gmc_v10_=
0.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+++
                                      b/drivers/gpu/drm/amd/amdgpu/gmc_v10_=
0.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -613,6=
 +613,9 @@
                                      static void
                                      gmc_v10_0_get_vm_pte(struct<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_de=
vice *adev,<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *flags &amp;=3D
                                      ~AMDGPU_PTE_MTYPE_NV10_MASK;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *flags |=3D
                                      (mapping-&gt;flags &amp;
                                      AMDGPU_PTE_MTYPE_NV10_MASK);<br>
                                      &gt;&gt;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0*flags &amp;=3D
                                      ~AMDGPU_PTE_NOALLOC;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0*flags |=3D
                                      (mapping-&gt;flags &amp;
                                      AMDGPU_PTE_NOALLOC);<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if
                                      (mapping-&gt;flags &amp;
                                      AMDGPU_PTE_PRT) {<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                      *flags |=3D AMDGPU_PTE_PRT;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                      *flags |=3D AMDGPU_PTE_SNOOPED;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --gi=
t
                                      a/drivers/gpu/drm/amd/amdgpu/gmc_v11_=
0.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0
                                      =C2=A0b/drivers/gpu/drm/amd/amdgpu/gm=
c_v11_0.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0index
                                      8d733eeac556..32ee56adb602 100644<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0---
                                      a/drivers/gpu/drm/amd/amdgpu/gmc_v11_=
0.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+++
                                      b/drivers/gpu/drm/amd/amdgpu/gmc_v11_=
0.c<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -508,6=
 +508,9 @@
                                      static void
                                      gmc_v11_0_get_vm_pte(struct<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_de=
vice *adev,<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *flags &amp;=3D
                                      ~AMDGPU_PTE_MTYPE_NV10_MASK;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *flags |=3D
                                      (mapping-&gt;flags &amp;
                                      AMDGPU_PTE_MTYPE_NV10_MASK);<br>
                                      &gt;&gt;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0*flags &amp;=3D
                                      ~AMDGPU_PTE_NOALLOC;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0*flags |=3D
                                      (mapping-&gt;flags &amp;
                                      AMDGPU_PTE_NOALLOC);<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if
                                      (mapping-&gt;flags &amp;
                                      AMDGPU_PTE_PRT) {<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                      *flags |=3D AMDGPU_PTE_PRT;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                      *flags |=3D AMDGPU_PTE_SNOOPED;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0diff --gi=
t
                                      a/include/uapi/drm/amdgpu_drm.h<br>
                                      &gt;&gt;=C2=A0 =C2=A0
                                      =C2=A0b/include/uapi/drm/amdgpu_drm.h=
<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0index
                                      57b9d8f0133a..9d71d6330687 100644<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0---
                                      a/include/uapi/drm/amdgpu_drm.h<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+++
                                      b/include/uapi/drm/amdgpu_drm.h<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0@@ -533,6=
 +533,8 @@
                                      struct drm_amdgpu_gem_op {<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#de=
fine
                                      AMDGPU_VM_MTYPE_UC=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(4
                                      &lt;&lt; 5)<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0/* =
Use Read Write
                                      MTYPE instead of default MTYPE */<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#de=
fine
                                      AMDGPU_VM_MTYPE_RW=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(5
                                      &lt;&lt; 5)<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+/* don&#=
39;t allocate
                                      MALL */<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0+#define
                                      AMDGPU_VM_PAGE_NOALLOC=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(1
                                      &lt;&lt; 9)<br>
                                      &gt;&gt;<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0str=
uct
                                      drm_amdgpu_gem_va {<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /** GEM
                                      object handle */<br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
                                      &gt;&gt;=C2=A0 =C2=A0 =C2=A02.25.1<br=
>
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
          </blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--000000000000fe075d05df29fe28--
