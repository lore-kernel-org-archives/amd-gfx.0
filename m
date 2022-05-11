Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC37DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 06:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AFE710E2AC;
	Wed, 11 May 2022 06:04:46 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57EE210E2AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 06:04:45 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 m2-20020a1ca302000000b003943bc63f98so578100wme.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 23:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=QO9k23A1U1t2qaoROQDKdRQCwCTwpUcpI0dcdYsTwYM=;
 b=WoolrPUCGSCGN/GdCTe0HFJ7UhsBCdw64CR7ArIIyIfNyqrkMNAyCYWpKDX1FGePDn
 PZb+nel9HW2usH3FWUIMQrpOx7re+fiPJbBatiypryxaWyqff+v6uaCadzuM+N0024Md
 SaB0NA6EkYqENUxoBIKc3OuLJ8OSqD+i41Q7sFNn39lN2eODnQ0Tm6nxDORT5fUh6hm0
 YMYbKdOAKYm9uwwqdThaNf8Cde+lU3XOG/cDuzu5DIg3MEtPn0POzCl1kktFeMhOvAA7
 i4SOOW+oVYmUPYGGZksL1HrYmHG8m8WOvEdrIT4Mu4+PBwxziYMRFiwYuU0fsHp9n/Ot
 sWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=QO9k23A1U1t2qaoROQDKdRQCwCTwpUcpI0dcdYsTwYM=;
 b=2rKaSpVIh8HWsn+rpM9YICbWlX7LLJFnodxrq1bCbBi6gf7+i0ySqo+fdSrx1LFPEX
 3BR58DMkyobAHRZXyC4iQv1CpygDI//VtPmeX1I3Y+4q0f11bfcNKfPCGwOAfysj/W8d
 KSvx9LUw9FwlaT2w8tL9bEyZJNaSfZNghWjuUpbV/OMcA05P9D+oVpJO8rhb9LuvGqeg
 xgQgakyYBCBzc3IL20eWc+h7Fqh6ivAKxTv00yI5IyugmpRKjS859JUuhPMMnQ9Zi9os
 MA0MDOhsiEdOrvIeFlz7EE+cxOs0tkTT/dHD14nCKTEcvwXCKkI5doRBuAzNrzxj5hvl
 LK1w==
X-Gm-Message-State: AOAM530K13FUzRB2lLEwY0LKkpWwaV0NpeX9fX/bUSWcwENkDN/KONCH
 JT9hChTFdiEswlswAqBkdvU=
X-Google-Smtp-Source: ABdhPJzbhO+zonBwTOAhJpxUyWoUOMV9qUOqGotrBQGv2J89jIDVpBnU1cz+gRb5e3S1adNZ6fUc/A==
X-Received: by 2002:a1c:5410:0:b0:394:1976:76e4 with SMTP id
 i16-20020a1c5410000000b00394197676e4mr2999200wmb.11.1652249083733; 
 Tue, 10 May 2022 23:04:43 -0700 (PDT)
Received: from [192.168.178.21] (p57b0be56.dip0.t-ipconnect.de.
 [87.176.190.86]) by smtp.gmail.com with ESMTPSA id
 l3-20020a1c2503000000b003942a244ecfsm936889wml.20.2022.05.10.23.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 23:04:43 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------H04tKLNKU8wUeZ8ur3YibHm0"
Message-ID: <d4f8f7fc-e3dc-fcf8-0543-62039c7460d3@gmail.com>
Date: Wed, 11 May 2022 08:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <CAAxE2A4Bny50ywdTXi0MBV_Pb-onx0yVhPOsb2Lk9XtbJ1R4rQ@mail.gmail.com>
 <CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com>
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
--------------H04tKLNKU8wUeZ8ur3YibHm0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marek,

Am 10.05.22 um 22:43 schrieb Marek Olšák:
> A better flag name would be:
> AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD

A bit long for my taste and I think the best placement is just a side 
effect.

>
> Marek
>
> On Tue, May 10, 2022 at 4:13 PM Marek Olšák <maraeo@gmail.com> wrote:
>
>     Does this really guarantee VRAM placement? The code doesn't say
>     anything about that.
>

Yes, see the code here:

>
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>         index 8b7ee1142d9a..1944ef37a61e 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>         @@ -567,6 +567,7 @@ int amdgpu_bo_create(struct amdgpu_device
>         *adev,
>                         bp->domain;
>                 bo->allowed_domains = bo->preferred_domains;
>                 if (bp->type != ttm_bo_type_kernel &&
>         +           !(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE) &&
>                     bo->allowed_domains == AMDGPU_GEM_DOMAIN_VRAM)
>                         bo->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
>

The only case where this could be circumvented is when you try to 
allocate more than physically available on an APU.

E.g. you only have something like 32 MiB VRAM and request 64 MiB, then 
the GEM code will catch the error and fallback to GTT (IIRC).

Regards,
Christian.
--------------H04tKLNKU8wUeZ8ur3YibHm0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi Marek,<br>
    <br>
    <div class="moz-cite-prefix">Am 10.05.22 um 22:43 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>A better flag name would be:</div>
        <div>AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD</div>
      </div>
    </blockquote>
    <br>
    A bit long for my taste and I think the best placement is just a
    side effect.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, May 10, 2022 at 4:13
          PM Marek Olšák &lt;<a href="mailto:maraeo@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir="ltr">
            <div>Does this really guarantee VRAM placement? The code
              doesn't say anything about that.</div>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
    Yes, see the code here:<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com">
      <div class="gmail_quote">
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              index 8b7ee1142d9a..1944ef37a61e 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              @@ -567,6 +567,7 @@ int amdgpu_bo_create(struct
              amdgpu_device *adev,<br>
                              bp-&gt;domain;<br>
                      bo-&gt;allowed_domains = bo-&gt;preferred_domains;<br>
                      if (bp-&gt;type != ttm_bo_type_kernel &amp;&amp;<br>
              +           !(bp-&gt;flags &amp;
              AMDGPU_GEM_CREATE_DISCARDABLE) &amp;&amp;<br>
                          bo-&gt;allowed_domains ==
              AMDGPU_GEM_DOMAIN_VRAM)<br>
                              bo-&gt;allowed_domains |=
              AMDGPU_GEM_DOMAIN_GTT;<br>
            </blockquote>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
    The only case where this could be circumvented is when you try to
    allocate more than physically available on an APU.<br>
    <br>
    E.g. you only have something like 32 MiB VRAM and request 64 MiB,
    then the GEM code will catch the error and fallback to GTT (IIRC).<br>
    <br>
    Regards,<br>
    Christian.<br>
  </body>
</html>

--------------H04tKLNKU8wUeZ8ur3YibHm0--
