Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD7CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 07:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9E110F88C;
	Wed, 11 May 2022 07:43:41 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA30610F882
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 07:43:39 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 k126-20020a1ca184000000b003943fd07180so699568wme.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=8w8jtgSGRu9qvfcyjUNJ73Ncdey3ULtqI4nRooStIO8=;
 b=cYNSarAUYdafOoxH+Ru1j+pYCRBVadkvBxMF44PjA7WuBZDXRL3XBG4k9CM9yVmbtP
 +03TAIv6sUGstQjMgIfuGNd1kJo3RGDD/uQ6BOwZaNnF4TIZbFbseT1OqXYEGdcfR7OT
 FSZEDDUWnuCrXKbEzQPkx+RLyWovASohlVxVPF3EMSb20gDel3OsfeJS2uTkb0UbKwPO
 8ROqA2Qy9H9aM5dUqbgC+yf9+hLveUFa+ZOfw3aAMdGc3ilMvD/1CRmCDUcpnMszvV45
 1PSMxMiLDRzISiMBOlCs0fu3sc9WfnlVPwDz5Q+5ow7FLv8HhvxA5mH1+J2PimMlcexY
 avpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=8w8jtgSGRu9qvfcyjUNJ73Ncdey3ULtqI4nRooStIO8=;
 b=6pUnEDQrX899RqXFFcsp7ziZFI82XGCaPCBDeQCkMFq7SBNKLWI4BUmNWMAaa9H5PI
 MbMmSwpCo5REnYx2wH7wcIig5a7klsalsgwJihwhDjZM7Vf46ftA4O7M/AUazNr1jiMS
 GIU2tuEnhvZ2Wq7ccVHkWii9jpqAg4J//3YZ8ALyOh5WOMJzJhs2+Pp1eIa8XepgQUC0
 qJH9VDEzSMLo9TSujYTZKgzSv/txbADtoyvJLgv7qKbyEw9KYlvzBso3F5SaRUQHhqV5
 pJp0NuewDRql50i9zBpsi5sZNVRx/Hgc6bZrL3ckhXO8p7heSKx4zC7+D4DWFkO/9xZH
 78zA==
X-Gm-Message-State: AOAM532wYlA4t95XWtktRAPTrRo+fIQpL9JdkCI92o1ef1OF3V2jaZ/U
 bIZ9KiOxCWo/vKuLGaaT5xk=
X-Google-Smtp-Source: ABdhPJwc/tXPv3qlFLY9Ndk4hzHtK7eMSaaQpPAwvf0i4OoC2ivL2NRiaGuokDgsBsExyfCPslPMOQ==
X-Received: by 2002:a05:600c:6022:b0:394:81cb:8c9 with SMTP id
 az34-20020a05600c602200b0039481cb08c9mr3402650wmb.111.1652255018322; 
 Wed, 11 May 2022 00:43:38 -0700 (PDT)
Received: from [192.168.178.21] (p57b0be56.dip0.t-ipconnect.de.
 [87.176.190.86]) by smtp.gmail.com with ESMTPSA id
 s25-20020a1cf219000000b003942a244f42sm5201488wmc.27.2022.05.11.00.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 May 2022 00:43:37 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------KqCbR3OVEQL0iKLXmA6BJrcu"
Message-ID: <e3de3d01-25fb-8839-c793-bde9188ba77a@gmail.com>
Date: Wed, 11 May 2022 09:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] drm/amdgpu: add AMDGPU_VM_NOALLOC
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <20220506112312.347519-2-christian.koenig@amd.com>
 <CAAxE2A7+-MKrh1BoXhGNBY38_7PkvrmZvn-tg4-4CFNXBvdKqw@mail.gmail.com>
 <8695802e-6835-a717-c0ee-83b76d8a8875@gmail.com>
 <5941d83c-6d2b-6e3b-bd5c-b22779929d5e@amd.com>
 <CAAxE2A7-crNh7oTTzgm7W7J412_ijrmoiN9ip9iiS1MJmmaB4A@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A7-crNh7oTTzgm7W7J412_ijrmoiN9ip9iiS1MJmmaB4A@mail.gmail.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------KqCbR3OVEQL0iKLXmA6BJrcu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It really *is* a NOALLOC feature. In other words there is no latency 
improvement on reads because the cache is always checked, even with the 
noalloc flag set.

The only thing it affects is that misses not enter the cache and so 
don't cause any additional pressure on evicting cache lines.

You might want to double check with the hardware guys, but I'm something 
like 95% sure that it works this way.

Christian.

Am 11.05.22 um 09:22 schrieb Marek Olšák:
> Bypass means that the contents of the cache are ignored, which 
> decreases latency at the cost of no coherency between bypassed and 
> normal memory requests. NOA (noalloc) means that the cache is checked 
> and can give you cache hits, but misses are not cached and the overall 
> latency is higher. I don't know what the hw does, but I hope it was 
> misnamed and it really means bypass because there is no point in doing 
> cache lookups on every memory request if the driver wants to disable 
> caching to *decrease* latency in the situations when the cache isn't 
> helping.
>
> Marek
>
> On Wed, May 11, 2022 at 2:15 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
>     On 5/11/2022 11:36 AM, Christian König wrote:
>     > Mhm, it doesn't really bypass MALL. It just doesn't allocate any
>     MALL
>     > entries on write.
>     >
>     > How about AMDGPU_VM_PAGE_NO_MALL ?
>
>     One more - AMDGPU_VM_PAGE_LLC_* [ LLC = last level cache, * = some
>     sort
>     of attribute which decides LLC behaviour]
>
>     Thanks,
>     Lijo
>
>     >
>     > Christian.
>     >
>     > Am 10.05.22 um 23:21 schrieb Marek Olšák:
>     >> A better name would be:
>     >> AMDGPU_VM_PAGE_BYPASS_MALL
>     >>
>     >> Marek
>     >>
>     >> On Fri, May 6, 2022 at 7:23 AM Christian König
>     >> <ckoenig.leichtzumerken@gmail.com> wrote:
>     >>
>     >>     Add the AMDGPU_VM_NOALLOC flag to let userspace control MALL
>     >>     allocation.
>     >>
>     >>     Only compile tested!
>     >>
>     >>     Signed-off-by: Christian König <christian.koenig@amd.com>
>     >>     ---
>     >>      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>     >>      drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3 +++
>     >>      drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 3 +++
>     >>      include/uapi/drm/amdgpu_drm.h           | 2 ++
>     >>      4 files changed, 10 insertions(+)
>     >>
>     >>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     >>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     >>     index bf97d8f07f57..d8129626581f 100644
>     >>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     >>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     >>     @@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_flags(struct
>     >>     amdgpu_device *adev, uint32_t flags)
>     >>                     pte_flag |= AMDGPU_PTE_WRITEABLE;
>     >>             if (flags & AMDGPU_VM_PAGE_PRT)
>     >>                     pte_flag |= AMDGPU_PTE_PRT;
>     >>     +       if (flags & AMDGPU_VM_PAGE_NOALLOC)
>     >>     +               pte_flag |= AMDGPU_PTE_NOALLOC;
>     >>
>     >>             if (adev->gmc.gmc_funcs->map_mtype)
>     >>                     pte_flag |= amdgpu_gmc_map_mtype(adev,
>     >>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     >>     b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     >>     index b8c79789e1e4..9077dfccaf3c 100644
>     >>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     >>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     >>     @@ -613,6 +613,9 @@ static void gmc_v10_0_get_vm_pte(struct
>     >>     amdgpu_device *adev,
>     >>             *flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
>     >>             *flags |= (mapping->flags &
>     AMDGPU_PTE_MTYPE_NV10_MASK);
>     >>
>     >>     +       *flags &= ~AMDGPU_PTE_NOALLOC;
>     >>     +       *flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
>     >>     +
>     >>             if (mapping->flags & AMDGPU_PTE_PRT) {
>     >>                     *flags |= AMDGPU_PTE_PRT;
>     >>                     *flags |= AMDGPU_PTE_SNOOPED;
>     >>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>     >>     b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>     >>     index 8d733eeac556..32ee56adb602 100644
>     >>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>     >>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>     >>     @@ -508,6 +508,9 @@ static void gmc_v11_0_get_vm_pte(struct
>     >>     amdgpu_device *adev,
>     >>             *flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
>     >>             *flags |= (mapping->flags &
>     AMDGPU_PTE_MTYPE_NV10_MASK);
>     >>
>     >>     +       *flags &= ~AMDGPU_PTE_NOALLOC;
>     >>     +       *flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
>     >>     +
>     >>             if (mapping->flags & AMDGPU_PTE_PRT) {
>     >>                     *flags |= AMDGPU_PTE_PRT;
>     >>                     *flags |= AMDGPU_PTE_SNOOPED;
>     >>     diff --git a/include/uapi/drm/amdgpu_drm.h
>     >>     b/include/uapi/drm/amdgpu_drm.h
>     >>     index 57b9d8f0133a..9d71d6330687 100644
>     >>     --- a/include/uapi/drm/amdgpu_drm.h
>     >>     +++ b/include/uapi/drm/amdgpu_drm.h
>     >>     @@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {
>     >>      #define AMDGPU_VM_MTYPE_UC             (4 << 5)
>     >>      /* Use Read Write MTYPE instead of default MTYPE */
>     >>      #define AMDGPU_VM_MTYPE_RW             (5 << 5)
>     >>     +/* don't allocate MALL */
>     >>     +#define AMDGPU_VM_PAGE_NOALLOC         (1 << 9)
>     >>
>     >>      struct drm_amdgpu_gem_va {
>     >>             /** GEM object handle */
>     >>     --
>     >>     2.25.1
>     >>
>     >
>

--------------KqCbR3OVEQL0iKLXmA6BJrcu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    It really *is* a NOALLOC feature. In other words there is no latency
    improvement on reads because the cache is always checked, even with
    the noalloc flag set.<br>
    <br>
    The only thing it affects is that misses not enter the cache and so
    don't cause any additional pressure on evicting cache lines.<br>
    <br>
    You might want to double check with the hardware guys, but I'm
    something like 95% sure that it works this way.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 11.05.22 um 09:22 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A7-crNh7oTTzgm7W7J412_ijrmoiN9ip9iiS1MJmmaB4A@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">Bypass means that the contents of the cache are
          ignored, which decreases latency at the cost of no coherency
          between bypassed and normal memory requests. NOA (noalloc)
          means that the cache is checked and can give you cache hits,
          but misses are not cached and the overall latency is higher. I
          don't know what the hw does, but I hope it was misnamed and it
          really means bypass because there is no point in doing cache
          lookups on every memory request if the driver wants to disable
          caching to *decrease* latency in the situations when the cache
          isn't helping.<br>
        </div>
        <div dir="ltr"><br>
        </div>
        <div>Marek<br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Wed, May 11, 2022 at 2:15
            AM Lazar, Lijo &lt;<a href="mailto:lijo.lazar@amd.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">lijo.lazar@amd.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex"><br>
            <br>
            On 5/11/2022 11:36 AM, Christian König wrote:<br>
            &gt; Mhm, it doesn't really bypass MALL. It just doesn't
            allocate any MALL <br>
            &gt; entries on write.<br>
            &gt; <br>
            &gt; How about AMDGPU_VM_PAGE_NO_MALL ?<br>
            <br>
            One more - AMDGPU_VM_PAGE_LLC_* [ LLC = last level cache, *
            = some sort <br>
            of attribute which decides LLC behaviour]<br>
            <br>
            Thanks,<br>
            Lijo<br>
            <br>
            &gt; <br>
            &gt; Christian.<br>
            &gt; <br>
            &gt; Am 10.05.22 um 23:21 schrieb Marek Olšák:<br>
            &gt;&gt; A better name would be:<br>
            &gt;&gt; AMDGPU_VM_PAGE_BYPASS_MALL<br>
            &gt;&gt;<br>
            &gt;&gt; Marek<br>
            &gt;&gt;<br>
            &gt;&gt; On Fri, May 6, 2022 at 7:23 AM Christian König <br>
            &gt;&gt; &lt;<a
              href="mailto:ckoenig.leichtzumerken@gmail.com"
              target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
            wrote:<br>
            &gt;&gt;<br>
            &gt;&gt;     Add the AMDGPU_VM_NOALLOC flag to let userspace
            control MALL<br>
            &gt;&gt;     allocation.<br>
            &gt;&gt;<br>
            &gt;&gt;     Only compile tested!<br>
            &gt;&gt;<br>
            &gt;&gt;     Signed-off-by: Christian König &lt;<a
              href="mailto:christian.koenig@amd.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;<br>
            &gt;&gt;     ---<br>
            &gt;&gt;      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++<br>
            &gt;&gt;      drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3
            +++<br>
            &gt;&gt;      drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 3
            +++<br>
            &gt;&gt;      include/uapi/drm/amdgpu_drm.h           | 2 ++<br>
            &gt;&gt;      4 files changed, 10 insertions(+)<br>
            &gt;&gt;<br>
            &gt;&gt;     diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
            &gt;&gt;     b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
            &gt;&gt;     index bf97d8f07f57..d8129626581f 100644<br>
            &gt;&gt;     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
            &gt;&gt;     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
            &gt;&gt;     @@ -650,6 +650,8 @@ uint64_t
            amdgpu_gem_va_map_flags(struct<br>
            &gt;&gt;     amdgpu_device *adev, uint32_t flags)<br>
            &gt;&gt;                     pte_flag |=
            AMDGPU_PTE_WRITEABLE;<br>
            &gt;&gt;             if (flags &amp; AMDGPU_VM_PAGE_PRT)<br>
            &gt;&gt;                     pte_flag |= AMDGPU_PTE_PRT;<br>
            &gt;&gt;     +       if (flags &amp; AMDGPU_VM_PAGE_NOALLOC)<br>
            &gt;&gt;     +               pte_flag |= AMDGPU_PTE_NOALLOC;<br>
            &gt;&gt;<br>
            &gt;&gt;             if
            (adev-&gt;gmc.gmc_funcs-&gt;map_mtype)<br>
            &gt;&gt;                     pte_flag |=
            amdgpu_gmc_map_mtype(adev,<br>
            &gt;&gt;     diff --git
            a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
            &gt;&gt;     b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
            &gt;&gt;     index b8c79789e1e4..9077dfccaf3c 100644<br>
            &gt;&gt;     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
            &gt;&gt;     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
            &gt;&gt;     @@ -613,6 +613,9 @@ static void
            gmc_v10_0_get_vm_pte(struct<br>
            &gt;&gt;     amdgpu_device *adev,<br>
            &gt;&gt;             *flags &amp;=
            ~AMDGPU_PTE_MTYPE_NV10_MASK;<br>
            &gt;&gt;             *flags |= (mapping-&gt;flags &amp;
            AMDGPU_PTE_MTYPE_NV10_MASK);<br>
            &gt;&gt;<br>
            &gt;&gt;     +       *flags &amp;= ~AMDGPU_PTE_NOALLOC;<br>
            &gt;&gt;     +       *flags |= (mapping-&gt;flags &amp;
            AMDGPU_PTE_NOALLOC);<br>
            &gt;&gt;     +<br>
            &gt;&gt;             if (mapping-&gt;flags &amp;
            AMDGPU_PTE_PRT) {<br>
            &gt;&gt;                     *flags |= AMDGPU_PTE_PRT;<br>
            &gt;&gt;                     *flags |= AMDGPU_PTE_SNOOPED;<br>
            &gt;&gt;     diff --git
            a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
            &gt;&gt;     b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
            &gt;&gt;     index 8d733eeac556..32ee56adb602 100644<br>
            &gt;&gt;     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
            &gt;&gt;     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
            &gt;&gt;     @@ -508,6 +508,9 @@ static void
            gmc_v11_0_get_vm_pte(struct<br>
            &gt;&gt;     amdgpu_device *adev,<br>
            &gt;&gt;             *flags &amp;=
            ~AMDGPU_PTE_MTYPE_NV10_MASK;<br>
            &gt;&gt;             *flags |= (mapping-&gt;flags &amp;
            AMDGPU_PTE_MTYPE_NV10_MASK);<br>
            &gt;&gt;<br>
            &gt;&gt;     +       *flags &amp;= ~AMDGPU_PTE_NOALLOC;<br>
            &gt;&gt;     +       *flags |= (mapping-&gt;flags &amp;
            AMDGPU_PTE_NOALLOC);<br>
            &gt;&gt;     +<br>
            &gt;&gt;             if (mapping-&gt;flags &amp;
            AMDGPU_PTE_PRT) {<br>
            &gt;&gt;                     *flags |= AMDGPU_PTE_PRT;<br>
            &gt;&gt;                     *flags |= AMDGPU_PTE_SNOOPED;<br>
            &gt;&gt;     diff --git a/include/uapi/drm/amdgpu_drm.h<br>
            &gt;&gt;     b/include/uapi/drm/amdgpu_drm.h<br>
            &gt;&gt;     index 57b9d8f0133a..9d71d6330687 100644<br>
            &gt;&gt;     --- a/include/uapi/drm/amdgpu_drm.h<br>
            &gt;&gt;     +++ b/include/uapi/drm/amdgpu_drm.h<br>
            &gt;&gt;     @@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {<br>
            &gt;&gt;      #define AMDGPU_VM_MTYPE_UC             (4
            &lt;&lt; 5)<br>
            &gt;&gt;      /* Use Read Write MTYPE instead of default
            MTYPE */<br>
            &gt;&gt;      #define AMDGPU_VM_MTYPE_RW             (5
            &lt;&lt; 5)<br>
            &gt;&gt;     +/* don't allocate MALL */<br>
            &gt;&gt;     +#define AMDGPU_VM_PAGE_NOALLOC         (1
            &lt;&lt; 9)<br>
            &gt;&gt;<br>
            &gt;&gt;      struct drm_amdgpu_gem_va {<br>
            &gt;&gt;             /** GEM object handle */<br>
            &gt;&gt;     -- <br>
            &gt;&gt;     2.25.1<br>
            &gt;&gt;<br>
            &gt; <br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------KqCbR3OVEQL0iKLXmA6BJrcu--
