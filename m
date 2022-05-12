Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EFBC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 07:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A29B10E68C;
	Thu, 12 May 2022 07:26:04 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D6E10E4CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 07:26:02 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id k27so5170639edk.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 00:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=hA0cmj4uTN/7UTFrQGPSFfh4rk2Cp4ZpGimgQR+dCzo=;
 b=WtBhagZFagoYN4l0nJ8HGVRKP8HqAmMbzNyWRAtvJhEJElrtW7qyvVBSPlE0QLBscc
 K+3P4QmqpBfDFtYLlFwHUHBTxK+j5y7QJ3B2rEQ+juvz6PGWthyidkOCYeON3sEmv8vi
 iVwOTQ8nCB4zj6qbiL5yDjskvAZ9MQaGy1wo6WRLeayOfSNN4h0cQatHHqVE254t8Pa3
 hxalskHCtqE4CPcO0nqPxtffzU6jh/1L+22ax31UxULnHBQS1dJ2pruEbTrD8ZoXJNS2
 aw7037B3RNRRCotmsbXKgAwWf6fNXMUbBzjXmdKyZtzFgWQljkTZ4oWj8n/43Wj7lAdr
 g7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=hA0cmj4uTN/7UTFrQGPSFfh4rk2Cp4ZpGimgQR+dCzo=;
 b=tvWUiX4tvteuPV0q/+p5mK0LvEYUMafbrRwgyUG8yzwPVuGfJjsth+H0v+//F09Cu9
 WjiRNUL2ShMvmyg6+BWqQSidWxkQQ7/iiN1hEbgpGNl/kdFJpiC+IuSZIKoxy07mKZEA
 KK5aP2Em3Jrd1KvRN/M4dUXN6jLXr2QVrusf/mEbll+E92zgBGjg8uKdJkb3ea1VZXD+
 J3RtHYR3tDXg8CFuDyf6iLi5aTbmIF0IDAaXskwBzWY6DMZPuy715OzGAtgO0tKDYRtC
 L+RDeTBJNVFGfWAq8c+15uKeBk7doU5/AJpD4+9KpKC2SuFTOZPvPNccPishqypE+DDi
 SL7w==
X-Gm-Message-State: AOAM5304MWothuz6MYKPg4HIkMVexnL0ORNi6FgsUpdNn9lczKzudLTf
 BwXQnZz+gDEM/kAvdXpUmwI=
X-Google-Smtp-Source: ABdhPJxB2efrm9xOJm6wnVI9kGo9cf3Mx0Ih6n+hoVMkXcgmh++hSW0JfC+bBOCYHPtNbciBYUN1cw==
X-Received: by 2002:aa7:d8d2:0:b0:425:e22b:35c0 with SMTP id
 k18-20020aa7d8d2000000b00425e22b35c0mr33908807eds.181.1652340361127; 
 Thu, 12 May 2022 00:26:01 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea033.dip0.t-ipconnect.de. [91.14.160.51])
 by smtp.gmail.com with ESMTPSA id
 c25-20020a170906925900b006f3ef214db3sm1860500ejx.25.2022.05.12.00.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 00:26:00 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------jSGMClt5y8ab3XND8YvEurRu"
Message-ID: <11d9492c-f727-f149-d473-9cda4bab2760@gmail.com>
Date: Thu, 12 May 2022 09:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <CAAxE2A4Bny50ywdTXi0MBV_Pb-onx0yVhPOsb2Lk9XtbJ1R4rQ@mail.gmail.com>
 <CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com>
 <d4f8f7fc-e3dc-fcf8-0543-62039c7460d3@gmail.com>
 <CAAxE2A60-rNUGB3PNL7kq6pJBWf7V-6cAE0Hx6zH31ad7z_1gA@mail.gmail.com>
 <CAAxE2A6BaiGfXXGnmCH9Zk36oWuOwk_84QBYbZ97QhyZQfwBKQ@mail.gmail.com>
 <CAAxE2A6wiL5fnegVo+tMsHBNb+HC3Nw=cmR4MdNVqLpEQYH1ug@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A6wiL5fnegVo+tMsHBNb+HC3Nw=cmR4MdNVqLpEQYH1ug@mail.gmail.com>
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
--------------jSGMClt5y8ab3XND8YvEurRu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.05.22 um 00:06 schrieb Marek Olšák:
> 3rd question: Is it worth using this on APUs?

It makes memory management somewhat easier when we are really OOM.

E.g. it should also work for GTT allocations and when the core kernel 
says "Hey please free something up or I will start the OOM-killer" it's 
something we can easily throw away.

Not sure how many of those buffers we have, but marking everything which 
is temporary with that flag is probably a good idea.

>
> Thanks,
> Marek
>
> On Wed, May 11, 2022 at 5:58 PM Marek Olšák <maraeo@gmail.com> wrote:
>
>     Will the kernel keep all discardable buffers in VRAM if VRAM is
>     not overcommitted by discardable buffers, or will other buffers
>     also affect the placement of discardable buffers?
>

Regarding the eviction pressure the buffers will be handled like any 
other buffer, but instead of preserving the content it is just discarded 
on eviction.

>
>     Do evictions deallocate the buffer, or do they keep an allocation
>     in GTT and only the copy is skipped?
>

It really deallocates the backing store of the buffer, just keeps a 
dummy page array around where all entries are NULL.

There is a patch set on the mailing list to make this a little bit more 
efficient, but even using the dummy page array should only have a few 
bytes overhead.

Regards,
Christian.

>
>     Thanks,
>     Marek
>
>     On Wed, May 11, 2022 at 3:08 AM Marek Olšák <maraeo@gmail.com> wrote:
>
>         OK that sounds good.
>
>         Marek
>
>         On Wed, May 11, 2022 at 2:04 AM Christian König
>         <ckoenig.leichtzumerken@gmail.com> wrote:
>
>             Hi Marek,
>
>             Am 10.05.22 um 22:43 schrieb Marek Olšák:
>>             A better flag name would be:
>>             AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD
>
>             A bit long for my taste and I think the best placement is
>             just a side effect.
>
>>
>>             Marek
>>
>>             On Tue, May 10, 2022 at 4:13 PM Marek Olšák
>>             <maraeo@gmail.com> wrote:
>>
>>                 Does this really guarantee VRAM placement? The code
>>                 doesn't say anything about that.
>>
>
>             Yes, see the code here:
>
>>
>>                     diff --git
>>                     a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>                     b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>                     index 8b7ee1142d9a..1944ef37a61e 100644
>>                     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>                     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>                     @@ -567,6 +567,7 @@ int amdgpu_bo_create(struct
>>                     amdgpu_device *adev,
>>                                     bp->domain;
>>                             bo->allowed_domains = bo->preferred_domains;
>>                             if (bp->type != ttm_bo_type_kernel &&
>>                     +           !(bp->flags &
>>                     AMDGPU_GEM_CREATE_DISCARDABLE) &&
>>                                 bo->allowed_domains ==
>>                     AMDGPU_GEM_DOMAIN_VRAM)
>>                                     bo->allowed_domains |=
>>                     AMDGPU_GEM_DOMAIN_GTT;
>>
>
>             The only case where this could be circumvented is when you
>             try to allocate more than physically available on an APU.
>
>             E.g. you only have something like 32 MiB VRAM and request
>             64 MiB, then the GEM code will catch the error and
>             fallback to GTT (IIRC).
>
>             Regards,
>             Christian.
>

--------------jSGMClt5y8ab3XND8YvEurRu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 12.05.22 um 00:06 schrieb Marek Olšák:<br>
    <blockquote type="cite"
cite="mid:CAAxE2A6wiL5fnegVo+tMsHBNb+HC3Nw=cmR4MdNVqLpEQYH1ug@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>3rd question: Is it worth using this on APUs?</div>
      </div>
    </blockquote>
    <br>
    It makes memory management somewhat easier when we are really OOM.<br>
    <br>
    E.g. it should also work for GTT allocations and when the core
    kernel says "Hey please free something up or I will start the
    OOM-killer" it's something we can easily throw away.<br>
    <br>
    Not sure how many of those buffers we have, but marking everything
    which is temporary with that flag is probably a good idea.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A6wiL5fnegVo+tMsHBNb+HC3Nw=cmR4MdNVqLpEQYH1ug@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div>Thanks,</div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Wed, May 11, 2022 at 5:58
          PM Marek Olšák &lt;<a href="mailto:maraeo@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir="ltr">
            <div>Will the kernel keep all discardable buffers in VRAM if
              VRAM is not overcommitted by discardable buffers, or will
              other buffers also affect the placement of discardable
              buffers?</div>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
    Regarding the eviction pressure the buffers will be handled like any
    other buffer, but instead of preserving the content it is just
    discarded on eviction.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A6wiL5fnegVo+tMsHBNb+HC3Nw=cmR4MdNVqLpEQYH1ug@mail.gmail.com">
      <div class="gmail_quote">
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir="ltr">
            <div><br>
            </div>
            <div>Do evictions deallocate the buffer, or do they keep an
              allocation in GTT and only the copy is skipped?</div>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
    It really deallocates the backing store of the buffer, just keeps a
    dummy page array around where all entries are NULL.<br>
    <br>
    There is a patch set on the mailing list to make this a little bit
    more efficient, but even using the dummy page array should only have
    a few bytes overhead.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A6wiL5fnegVo+tMsHBNb+HC3Nw=cmR4MdNVqLpEQYH1ug@mail.gmail.com">
      <div class="gmail_quote">
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir="ltr">
            <div><br>
            </div>
            <div>Thanks,</div>
            <div>Marek<br>
            </div>
          </div>
          <br>
          <div class="gmail_quote">
            <div dir="ltr" class="gmail_attr">On Wed, May 11, 2022 at
              3:08 AM Marek Olšák &lt;<a href="mailto:maraeo@gmail.com"
                target="_blank" moz-do-not-send="true"
                class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div dir="ltr">
                <div>OK that sounds good.</div>
                <div><br>
                </div>
                <div>Marek<br>
                </div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Wed, May 11, 2022
                  at 2:04 AM Christian König &lt;<a
                    href="mailto:ckoenig.leichtzumerken@gmail.com"
                    target="_blank" moz-do-not-send="true"
                    class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div> Hi Marek,<br>
                    <br>
                    <div>Am 10.05.22 um 22:43 schrieb Marek Olšák:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div>A better flag name would be:</div>
                        <div>AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD</div>
                      </div>
                    </blockquote>
                    <br>
                    A bit long for my taste and I think the best
                    placement is just a side effect.<br>
                    <br>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div><br>
                        </div>
                        <div>Marek<br>
                        </div>
                      </div>
                      <br>
                      <div class="gmail_quote">
                        <div dir="ltr" class="gmail_attr">On Tue, May
                          10, 2022 at 4:13 PM Marek Olšák &lt;<a
                            href="mailto:maraeo@gmail.com"
                            target="_blank" moz-do-not-send="true"
                            class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote"
                          style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">
                          <div dir="ltr">
                            <div>Does this really guarantee VRAM
                              placement? The code doesn't say anything
                              about that.</div>
                          </div>
                        </blockquote>
                      </div>
                    </blockquote>
                    <br>
                    Yes, see the code here:<br>
                    <br>
                    <blockquote type="cite">
                      <div class="gmail_quote">
                        <blockquote class="gmail_quote"
                          style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex"><br>
                          <div class="gmail_quote">
                            <blockquote class="gmail_quote"
                              style="margin:0px 0px 0px
                              0.8ex;border-left:1px solid
                              rgb(204,204,204);padding-left:1ex"> diff
                              --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                              index 8b7ee1142d9a..1944ef37a61e 100644<br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                              @@ -567,6 +567,7 @@ int
                              amdgpu_bo_create(struct amdgpu_device
                              *adev,<br>
                                              bp-&gt;domain;<br>
                                      bo-&gt;allowed_domains =
                              bo-&gt;preferred_domains;<br>
                                      if (bp-&gt;type !=
                              ttm_bo_type_kernel &amp;&amp;<br>
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
                    The only case where this could be circumvented is
                    when you try to allocate more than physically
                    available on an APU.<br>
                    <br>
                    E.g. you only have something like 32 MiB VRAM and
                    request 64 MiB, then the GEM code will catch the
                    error and fallback to GTT (IIRC).<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                  </div>
                </blockquote>
              </div>
            </blockquote>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------jSGMClt5y8ab3XND8YvEurRu--
