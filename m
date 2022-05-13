Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2629C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 11:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF0910E2A5;
	Fri, 13 May 2022 11:24:33 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5981E10E29F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 11:24:31 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id z19so9580991edx.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=RtFlB8M+6XS2nBj7bk7hiutHv26sa7FTtb1PSd488Ps=;
 b=gvK1hXj8n+N0NSWwkPSpFUgAPBZDk8kCDQiOOp5w5MsMP3xFPN3xMjD7V5LjHu2vFp
 WI2iZ0+2m7PamWsuHS6nNdF2d+XFBG1hmxFTmjSLxsOyldgWlaGK9ra5HmIOgzQ4z3RX
 1qJpQsUjUzxgn6K04FWV3L03nj6vrMtXlwr6aA8NOwC+uaR8ZHXZxCbTtmm3MtzbeqUn
 WbUsE4PDWyhThto9usj4IBNtPKmCCZ6ft/AGWaPOEgztLl0SAYj5qj6OT8d7p8LZFoId
 afTFkkWvU5CxtujjDmCFxzL2J16I+noRfQpV9PlWufeQT10h5BK3Fkq8Pa8XOnQnV+lh
 pwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=RtFlB8M+6XS2nBj7bk7hiutHv26sa7FTtb1PSd488Ps=;
 b=nd/dl9lbAQuL09ipNRvF0YRwORUvTneLs+MVSsYxnaSKlbJbnxpr571RyXTvlCGzUl
 n1MGPQibm15pzJWyDDhaJYdRSQKUbJ4lmYbmjqgQmmoh8Sl+ZS9xjsMIbagkti+0d4Nb
 D0AISOHAdBLi8TFzXDjLtP5DkPLAAbyEWm6zoGchJzdPL2l5FE/h6epU9YCqZnh2xcDX
 Id7+PcJa/L8myhz9SHOTjjb3dfGLJBK57QyZaTJFtgjITH3dhIVBiHSreJNwRZDnnIB/
 TFVZLv17DJ4vxyfK5b834WkbPKkaFELcqAfYYneyKSa45yhvCJiRm0FfZsC8mu3WlIPy
 cxRA==
X-Gm-Message-State: AOAM533fSlOF6PIxyNR8AR1QcOTdAQwe8tRVAl8bOJkLKiTbVUPGh0aV
 YYG2CscIFx3Oxk3Ywe4/aBgCmAceVE0=
X-Google-Smtp-Source: ABdhPJyE6wyuIGZtWXIMO2l9tbV1rOT+P2IhzN6qyIN9ICApi8AoMLapcfTf/LB5m0wfRqtECc1C/w==
X-Received: by 2002:a05:6402:51d3:b0:428:ce4a:69b with SMTP id
 r19-20020a05640251d300b00428ce4a069bmr15618615edd.72.1652441069773; 
 Fri, 13 May 2022 04:24:29 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:4107:8049:874f:2444?
 ([2a02:908:1256:79a0:4107:8049:874f:2444])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a1709063bd200b006f3ef214e57sm641783ejf.189.2022.05.13.04.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 May 2022 04:24:29 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------iR0vBbYBnuWj0mmQQJdZthWk"
Message-ID: <63d547b5-c0a3-812c-e019-ed2a2010fe4b@gmail.com>
Date: Fri, 13 May 2022 13:24:27 +0200
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
 <11d9492c-f727-f149-d473-9cda4bab2760@gmail.com>
 <CAAxE2A5jc0FhpnM2tBskS2puKY-jidC_xdMTZhQ5p9U31O_0KA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A5jc0FhpnM2tBskS2puKY-jidC_xdMTZhQ5p9U31O_0KA@mail.gmail.com>
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
--------------iR0vBbYBnuWj0mmQQJdZthWk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Well the best placement is guaranteed as long as the application doesn't 
do any nonsense (e.g. trying to allocate a buffer larger than available 
VRAM).

The VM_ALWAYS_VALID flag doesn't affect any of that handling.

Regards,
Christian.

Am 13.05.22 um 00:17 schrieb Marek Olšák:
> Would it be better to set the VM_ALWAYS_VALID flag to have a greater 
> guarantee that the best placement will be chosen?
>
> See, the main feature is getting the best placement, not being 
> discardable. The best placement is a hw design requirement due to 
> using memory for uses that are expected to have performance similar to 
> onchip SRAMs. We need to make sure the best placement is guaranteed if 
> it's VRAM.
>
> Marek
>
> On Thu., May 12, 2022, 03:26 Christian König, 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     Am 12.05.22 um 00:06 schrieb Marek Olšák:
>>     3rd question: Is it worth using this on APUs?
>
>     It makes memory management somewhat easier when we are really OOM.
>
>     E.g. it should also work for GTT allocations and when the core
>     kernel says "Hey please free something up or I will start the
>     OOM-killer" it's something we can easily throw away.
>
>     Not sure how many of those buffers we have, but marking everything
>     which is temporary with that flag is probably a good idea.
>
>>
>>     Thanks,
>>     Marek
>>
>>     On Wed, May 11, 2022 at 5:58 PM Marek Olšák <maraeo@gmail.com> wrote:
>>
>>         Will the kernel keep all discardable buffers in VRAM if VRAM
>>         is not overcommitted by discardable buffers, or will other
>>         buffers also affect the placement of discardable buffers?
>>
>
>     Regarding the eviction pressure the buffers will be handled like
>     any other buffer, but instead of preserving the content it is just
>     discarded on eviction.
>
>>
>>         Do evictions deallocate the buffer, or do they keep an
>>         allocation in GTT and only the copy is skipped?
>>
>
>     It really deallocates the backing store of the buffer, just keeps
>     a dummy page array around where all entries are NULL.
>
>     There is a patch set on the mailing list to make this a little bit
>     more efficient, but even using the dummy page array should only
>     have a few bytes overhead.
>
>     Regards,
>     Christian.
>
>>
>>         Thanks,
>>         Marek
>>
>>         On Wed, May 11, 2022 at 3:08 AM Marek Olšák
>>         <maraeo@gmail.com> wrote:
>>
>>             OK that sounds good.
>>
>>             Marek
>>
>>             On Wed, May 11, 2022 at 2:04 AM Christian König
>>             <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>                 Hi Marek,
>>
>>                 Am 10.05.22 um 22:43 schrieb Marek Olšák:
>>>                 A better flag name would be:
>>>                 AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD
>>
>>                 A bit long for my taste and I think the best
>>                 placement is just a side effect.
>>
>>>
>>>                 Marek
>>>
>>>                 On Tue, May 10, 2022 at 4:13 PM Marek Olšák
>>>                 <maraeo@gmail.com> wrote:
>>>
>>>                     Does this really guarantee VRAM placement? The
>>>                     code doesn't say anything about that.
>>>
>>
>>                 Yes, see the code here:
>>
>>>
>>>                         diff --git
>>>                         a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>                         b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>                         index 8b7ee1142d9a..1944ef37a61e 100644
>>>                         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>                         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>                         @@ -567,6 +567,7 @@ int
>>>                         amdgpu_bo_create(struct amdgpu_device *adev,
>>>                                         bp->domain;
>>>                                 bo->allowed_domains =
>>>                         bo->preferred_domains;
>>>                                 if (bp->type != ttm_bo_type_kernel &&
>>>                         +           !(bp->flags &
>>>                         AMDGPU_GEM_CREATE_DISCARDABLE) &&
>>>                                     bo->allowed_domains ==
>>>                         AMDGPU_GEM_DOMAIN_VRAM)
>>>                         bo->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
>>>
>>
>>                 The only case where this could be circumvented is
>>                 when you try to allocate more than physically
>>                 available on an APU.
>>
>>                 E.g. you only have something like 32 MiB VRAM and
>>                 request 64 MiB, then the GEM code will catch the
>>                 error and fallback to GTT (IIRC).
>>
>>                 Regards,
>>                 Christian.
>>
>

--------------iR0vBbYBnuWj0mmQQJdZthWk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Well the best placement is guaranteed as long as the application
    doesn't do any nonsense (e.g. trying to allocate a buffer larger
    than available VRAM).<br>
    <br>
    The VM_ALWAYS_VALID flag doesn't affect any of that handling.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 13.05.22 um 00:17 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A5jc0FhpnM2tBskS2puKY-jidC_xdMTZhQ5p9U31O_0KA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">Would it be better to set the VM_ALWAYS_VALID flag
        to have a greater guarantee that the best placement will be
        chosen?
        <div dir="auto"><br>
        </div>
        <div dir="auto">See, the main feature is getting the best
          placement, not being discardable. The best placement is a hw
          design requirement due to using memory for uses that are
          expected to have performance similar to onchip SRAMs. We need
          to make sure the best placement is guaranteed if it's VRAM.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Thu., May 12, 2022, 03:26
          Christian König, &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">
          <div> Am 12.05.22 um 00:06 schrieb Marek Olšák:<br>
            <blockquote type="cite">
              <div dir="ltr">
                <div>3rd question: Is it worth using this on APUs?</div>
              </div>
            </blockquote>
            <br>
            It makes memory management somewhat easier when we are
            really OOM.<br>
            <br>
            E.g. it should also work for GTT allocations and when the
            core kernel says "Hey please free something up or I will
            start the OOM-killer" it's something we can easily throw
            away.<br>
            <br>
            Not sure how many of those buffers we have, but marking
            everything which is temporary with that flag is probably a
            good idea.<br>
            <br>
            <blockquote type="cite">
              <div dir="ltr">
                <div><br>
                </div>
                <div>Thanks,</div>
                <div>Marek<br>
                </div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Wed, May 11, 2022
                  at 5:58 PM Marek Olšák &lt;<a
                    href="mailto:maraeo@gmail.com" target="_blank"
                    rel="noreferrer" moz-do-not-send="true"
                    class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div dir="ltr">
                    <div>Will the kernel keep all discardable buffers in
                      VRAM if VRAM is not overcommitted by discardable
                      buffers, or will other buffers also affect the
                      placement of discardable buffers?</div>
                  </div>
                </blockquote>
              </div>
            </blockquote>
            <br>
            Regarding the eviction pressure the buffers will be handled
            like any other buffer, but instead of preserving the content
            it is just discarded on eviction.<br>
            <br>
            <blockquote type="cite">
              <div class="gmail_quote">
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div dir="ltr">
                    <div><br>
                    </div>
                    <div>Do evictions deallocate the buffer, or do they
                      keep an allocation in GTT and only the copy is
                      skipped?</div>
                  </div>
                </blockquote>
              </div>
            </blockquote>
            <br>
            It really deallocates the backing store of the buffer, just
            keeps a dummy page array around where all entries are NULL.<br>
            <br>
            There is a patch set on the mailing list to make this a
            little bit more efficient, but even using the dummy page
            array should only have a few bytes overhead.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <blockquote type="cite">
              <div class="gmail_quote">
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div dir="ltr">
                    <div><br>
                    </div>
                    <div>Thanks,</div>
                    <div>Marek<br>
                    </div>
                  </div>
                  <br>
                  <div class="gmail_quote">
                    <div dir="ltr" class="gmail_attr">On Wed, May 11,
                      2022 at 3:08 AM Marek Olšák &lt;<a
                        href="mailto:maraeo@gmail.com" target="_blank"
                        rel="noreferrer" moz-do-not-send="true"
                        class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote class="gmail_quote" style="margin:0px
                      0px 0px 0.8ex;border-left:1px solid
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
                        <div dir="ltr" class="gmail_attr">On Wed, May
                          11, 2022 at 2:04 AM Christian König &lt;<a
                            href="mailto:ckoenig.leichtzumerken@gmail.com"
                            target="_blank" rel="noreferrer"
                            moz-do-not-send="true"
                            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote"
                          style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">
                          <div> Hi Marek,<br>
                            <br>
                            <div>Am 10.05.22 um 22:43 schrieb Marek
                              Olšák:<br>
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
                                <div dir="ltr" class="gmail_attr">On
                                  Tue, May 10, 2022 at 4:13 PM Marek
                                  Olšák &lt;<a
                                    href="mailto:maraeo@gmail.com"
                                    target="_blank" rel="noreferrer"
                                    moz-do-not-send="true"
                                    class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
                                  wrote:<br>
                                </div>
                                <blockquote class="gmail_quote"
                                  style="margin:0px 0px 0px
                                  0.8ex;border-left:1px solid
                                  rgb(204,204,204);padding-left:1ex">
                                  <div dir="ltr">
                                    <div>Does this really guarantee VRAM
                                      placement? The code doesn't say
                                      anything about that.</div>
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
                                      rgb(204,204,204);padding-left:1ex">
                                      diff --git
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                                      index 8b7ee1142d9a..1944ef37a61e
                                      100644<br>
                                      ---
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                                      +++
                                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                                      @@ -567,6 +567,7 @@ int
                                      amdgpu_bo_create(struct
                                      amdgpu_device *adev,<br>
                                                      bp-&gt;domain;<br>
                                              bo-&gt;allowed_domains =
                                      bo-&gt;preferred_domains;<br>
                                              if (bp-&gt;type !=
                                      ttm_bo_type_kernel &amp;&amp;<br>
                                      +           !(bp-&gt;flags &amp;
                                      AMDGPU_GEM_CREATE_DISCARDABLE)
                                      &amp;&amp;<br>
                                                  bo-&gt;allowed_domains
                                      == AMDGPU_GEM_DOMAIN_VRAM)<br>
                                                     
                                      bo-&gt;allowed_domains |=
                                      AMDGPU_GEM_DOMAIN_GTT;<br>
                                    </blockquote>
                                  </div>
                                </blockquote>
                              </div>
                            </blockquote>
                            <br>
                            The only case where this could be
                            circumvented is when you try to allocate
                            more than physically available on an APU.<br>
                            <br>
                            E.g. you only have something like 32 MiB
                            VRAM and request 64 MiB, then the GEM code
                            will catch the error and fallback to GTT
                            (IIRC).<br>
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
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------iR0vBbYBnuWj0mmQQJdZthWk--
