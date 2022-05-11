Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF7CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 06:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A90B210E4A2;
	Wed, 11 May 2022 06:06:45 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162A210E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 06:06:44 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 v64-20020a1cac43000000b0038cfd1b3a6dso2509825wme.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 23:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=uU+wxjNh7kMiapejgylsdENbiB4nwJKmXQjawLFrxAU=;
 b=Te8Kc7VWTz3v8P2NaJEE5iNDno1zaeK14DvPa/IfRwg9ChKLT1n27sBjpAzJW+XmUe
 MDXtlq9dzt/jUh648t+jPeX8a1hyqReOHjVXEQMy4J2fCEzWHrAnfseiBr6Hxoya651O
 kSWuZYy9ZIv3GnjoCBfvNp0hLGk5VaXm7W8rxvaj9Nf6r7krZWAugYfvk4HFbB3gBbif
 WJJxGbTRiHAKfTiloLYKWuX6BYv33WGevaWi6l4GZQXI1+Pl6bXfc383rMIzlW5nSg0B
 mwfL+thbJE8Oq1/aBYGDi87TmmuMZCOWBB5a4yZBWy+wDoiPnioV30JAhwzXVk71Ukt5
 T0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=uU+wxjNh7kMiapejgylsdENbiB4nwJKmXQjawLFrxAU=;
 b=NS63TU1MZfBtv5Lm5ia+xpqmAjQ+B8PtNbrxfDELJ50CNyPfBhy7oh66W6HEjrGHkh
 3VXye7JHJIpsdTnFRpEnAMQN+Y4uFP94bDfqdOaIwvRXFX6miURdZKUULd5nc0+x99yT
 R+1PlD6NcvayAG6iyg+87uNsGUw8I4X0usJOLXMgr8MOBneghvNP9b6OO6XZeZvtWv2e
 7QNJlRS9GsfHRQSy3G8F296YFbTdIolk0HaqTW8KmboWDIUzASvq/4RD+t3MNxnxmmlj
 Ow/nHlLdi/5Kpcqt659GD5Exl0NN2yxnDjyZQ9hsz2//QpHPv2KyeSBipmOeJaw72FvO
 uHcA==
X-Gm-Message-State: AOAM530bk9Hndos9YrtWFPrc7xtP3siYGHbaDw+DBR3QlxjWFx2YQccs
 YOdQf0/bHqplyFnEUrq2EXs=
X-Google-Smtp-Source: ABdhPJwBxLeg70pvwDym7YiFwDK96v+TBJHF/yXXQvYbdvhnSnzJPYEa4v5iy84uiOHppttV/eQsAg==
X-Received: by 2002:a05:600c:3b17:b0:394:88f0:a4b with SMTP id
 m23-20020a05600c3b1700b0039488f00a4bmr3067413wms.129.1652249202471; 
 Tue, 10 May 2022 23:06:42 -0700 (PDT)
Received: from [192.168.178.21] (p57b0be56.dip0.t-ipconnect.de.
 [87.176.190.86]) by smtp.gmail.com with ESMTPSA id
 d13-20020a5d4f8d000000b0020c5253d911sm696888wru.93.2022.05.10.23.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 23:06:42 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------HvU0i1DinKmp5ghfEeWOTFWm"
Message-ID: <8695802e-6835-a717-c0ee-83b76d8a8875@gmail.com>
Date: Wed, 11 May 2022 08:06:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] drm/amdgpu: add AMDGPU_VM_NOALLOC
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <20220506112312.347519-2-christian.koenig@amd.com>
 <CAAxE2A7+-MKrh1BoXhGNBY38_7PkvrmZvn-tg4-4CFNXBvdKqw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A7+-MKrh1BoXhGNBY38_7PkvrmZvn-tg4-4CFNXBvdKqw@mail.gmail.com>
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
--------------HvU0i1DinKmp5ghfEeWOTFWm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Mhm, it doesn't really bypass MALL. It just doesn't allocate any MALL 
entries on write.

How about AMDGPU_VM_PAGE_NO_MALL ?

Christian.

Am 10.05.22 um 23:21 schrieb Marek Olšák:
> A better name would be:
> AMDGPU_VM_PAGE_BYPASS_MALL
>
> Marek
>
> On Fri, May 6, 2022 at 7:23 AM Christian König 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     Add the AMDGPU_VM_NOALLOC flag to let userspace control MALL
>     allocation.
>
>     Only compile tested!
>
>     Signed-off-by: Christian König <christian.koenig@amd.com>
>     ---
>      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>      drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3 +++
>      drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 3 +++
>      include/uapi/drm/amdgpu_drm.h           | 2 ++
>      4 files changed, 10 insertions(+)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     index bf97d8f07f57..d8129626581f 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     @@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_flags(struct
>     amdgpu_device *adev, uint32_t flags)
>                     pte_flag |= AMDGPU_PTE_WRITEABLE;
>             if (flags & AMDGPU_VM_PAGE_PRT)
>                     pte_flag |= AMDGPU_PTE_PRT;
>     +       if (flags & AMDGPU_VM_PAGE_NOALLOC)
>     +               pte_flag |= AMDGPU_PTE_NOALLOC;
>
>             if (adev->gmc.gmc_funcs->map_mtype)
>                     pte_flag |= amdgpu_gmc_map_mtype(adev,
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     index b8c79789e1e4..9077dfccaf3c 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>     @@ -613,6 +613,9 @@ static void gmc_v10_0_get_vm_pte(struct
>     amdgpu_device *adev,
>             *flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
>             *flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
>
>     +       *flags &= ~AMDGPU_PTE_NOALLOC;
>     +       *flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
>     +
>             if (mapping->flags & AMDGPU_PTE_PRT) {
>                     *flags |= AMDGPU_PTE_PRT;
>                     *flags |= AMDGPU_PTE_SNOOPED;
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>     index 8d733eeac556..32ee56adb602 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>     @@ -508,6 +508,9 @@ static void gmc_v11_0_get_vm_pte(struct
>     amdgpu_device *adev,
>             *flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
>             *flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
>
>     +       *flags &= ~AMDGPU_PTE_NOALLOC;
>     +       *flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
>     +
>             if (mapping->flags & AMDGPU_PTE_PRT) {
>                     *flags |= AMDGPU_PTE_PRT;
>                     *flags |= AMDGPU_PTE_SNOOPED;
>     diff --git a/include/uapi/drm/amdgpu_drm.h
>     b/include/uapi/drm/amdgpu_drm.h
>     index 57b9d8f0133a..9d71d6330687 100644
>     --- a/include/uapi/drm/amdgpu_drm.h
>     +++ b/include/uapi/drm/amdgpu_drm.h
>     @@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {
>      #define AMDGPU_VM_MTYPE_UC             (4 << 5)
>      /* Use Read Write MTYPE instead of default MTYPE */
>      #define AMDGPU_VM_MTYPE_RW             (5 << 5)
>     +/* don't allocate MALL */
>     +#define AMDGPU_VM_PAGE_NOALLOC         (1 << 9)
>
>      struct drm_amdgpu_gem_va {
>             /** GEM object handle */
>     -- 
>     2.25.1
>

--------------HvU0i1DinKmp5ghfEeWOTFWm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Mhm, it doesn't really bypass MALL. It just doesn't allocate any
    MALL entries on write.<br>
    <br>
    How about AMDGPU_VM_PAGE_NO_MALL ?<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 10.05.22 um 23:21 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A7+-MKrh1BoXhGNBY38_7PkvrmZvn-tg4-4CFNXBvdKqw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>A better name would be:</div>
        <div>AMDGPU_VM_PAGE_BYPASS_MALL</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri, May 6, 2022 at 7:23 AM
          Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add
          the AMDGPU_VM_NOALLOC flag to let userspace control MALL
          allocation.<br>
          <br>
          Only compile tested!<br>
          <br>
          Signed-off-by: Christian König &lt;<a
            href="mailto:christian.koenig@amd.com" target="_blank"
            moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;<br>
          ---<br>
           drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++<br>
           drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3 +++<br>
           drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 3 +++<br>
           include/uapi/drm/amdgpu_drm.h           | 2 ++<br>
           4 files changed, 10 insertions(+)<br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
          index bf97d8f07f57..d8129626581f 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
          @@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_flags(struct
          amdgpu_device *adev, uint32_t flags)<br>
                          pte_flag |= AMDGPU_PTE_WRITEABLE;<br>
                  if (flags &amp; AMDGPU_VM_PAGE_PRT)<br>
                          pte_flag |= AMDGPU_PTE_PRT;<br>
          +       if (flags &amp; AMDGPU_VM_PAGE_NOALLOC)<br>
          +               pte_flag |= AMDGPU_PTE_NOALLOC;<br>
          <br>
                  if (adev-&gt;gmc.gmc_funcs-&gt;map_mtype)<br>
                          pte_flag |= amdgpu_gmc_map_mtype(adev,<br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
          b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
          index b8c79789e1e4..9077dfccaf3c 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
          @@ -613,6 +613,9 @@ static void gmc_v10_0_get_vm_pte(struct
          amdgpu_device *adev,<br>
                  *flags &amp;= ~AMDGPU_PTE_MTYPE_NV10_MASK;<br>
                  *flags |= (mapping-&gt;flags &amp;
          AMDGPU_PTE_MTYPE_NV10_MASK);<br>
          <br>
          +       *flags &amp;= ~AMDGPU_PTE_NOALLOC;<br>
          +       *flags |= (mapping-&gt;flags &amp;
          AMDGPU_PTE_NOALLOC);<br>
          +<br>
                  if (mapping-&gt;flags &amp; AMDGPU_PTE_PRT) {<br>
                          *flags |= AMDGPU_PTE_PRT;<br>
                          *flags |= AMDGPU_PTE_SNOOPED;<br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
          b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
          index 8d733eeac556..32ee56adb602 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
          @@ -508,6 +508,9 @@ static void gmc_v11_0_get_vm_pte(struct
          amdgpu_device *adev,<br>
                  *flags &amp;= ~AMDGPU_PTE_MTYPE_NV10_MASK;<br>
                  *flags |= (mapping-&gt;flags &amp;
          AMDGPU_PTE_MTYPE_NV10_MASK);<br>
          <br>
          +       *flags &amp;= ~AMDGPU_PTE_NOALLOC;<br>
          +       *flags |= (mapping-&gt;flags &amp;
          AMDGPU_PTE_NOALLOC);<br>
          +<br>
                  if (mapping-&gt;flags &amp; AMDGPU_PTE_PRT) {<br>
                          *flags |= AMDGPU_PTE_PRT;<br>
                          *flags |= AMDGPU_PTE_SNOOPED;<br>
          diff --git a/include/uapi/drm/amdgpu_drm.h
          b/include/uapi/drm/amdgpu_drm.h<br>
          index 57b9d8f0133a..9d71d6330687 100644<br>
          --- a/include/uapi/drm/amdgpu_drm.h<br>
          +++ b/include/uapi/drm/amdgpu_drm.h<br>
          @@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {<br>
           #define AMDGPU_VM_MTYPE_UC             (4 &lt;&lt; 5)<br>
           /* Use Read Write MTYPE instead of default MTYPE */<br>
           #define AMDGPU_VM_MTYPE_RW             (5 &lt;&lt; 5)<br>
          +/* don't allocate MALL */<br>
          +#define AMDGPU_VM_PAGE_NOALLOC         (1 &lt;&lt; 9)<br>
          <br>
           struct drm_amdgpu_gem_va {<br>
                  /** GEM object handle */<br>
          -- <br>
          2.25.1<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------HvU0i1DinKmp5ghfEeWOTFWm--
