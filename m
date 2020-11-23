Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D049C63697
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 20:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3134320657
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 20:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBbKGEUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3134320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 892166E0B7;
	Mon, 23 Nov 2020 20:17:53 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B35E6E0B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 20:17:52 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id z5so5057936ejp.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 12:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=UHfcGtf+0ehrBTbg5roaj1Hu4D+D+ArIgAllkAC6bFA=;
 b=hBbKGEULpJOZxT3e5CcCDg6we09mLmgS9iFnK1Dl3Ahr8GP6VvYBNIoBKE/dUpHOMS
 MibX9D5gAgRM4oGH7ro4rEoNgqEMtdFAhXlgQxOJBqREyOQajG3c9G0f6qdivpuPiIha
 Mbjsof3t2vcWRd7SRjopvyi57pFcr3VNGvXxndhgbx/vz9Qe5c1Ht57MnOqfGzix1zH3
 Bc/s99/u84DIcC7DUfv0Uv0KY93PUrvmgjvz/3sziRmB5BM+O1XV0xpnCWHevgpKxKDS
 qOVJxU18FR/voAWgZYlMyELKxKlpv8v0HeaF0Ut6qZoN3V8P7NcAn6papBQVrGvTcEmJ
 eiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=UHfcGtf+0ehrBTbg5roaj1Hu4D+D+ArIgAllkAC6bFA=;
 b=cV9AgYiQrYrPc+DP6jgHsZw82vW8yBDNcdmhgN4ZFxYIv/Bl+4Wq6QOhb0+E0/+VYZ
 sJ6f/F5bzABaP41XXy2+WULkxNHt6gqZ7uH+FnJfKMY26l87tFRd1dgP7IfKsLre9+cr
 cy8D4J9FGBpaoJQYPCed//A7IR757/96ZXlQAZ0hlqbiSD1qNaIJ5lmMQ8TXAAg74vfn
 M7hhU9SRE8q3GVGy4aJwwbQ8gutoVdzWuU9tC7AFXuKTwlGMyKGl8bY7NyYACjpzCRsX
 E69zh+fFVDMy+YCAe62Xnmf/+Uhxe4B1dGElTumpIKauGqMSmsKxLl7bKa3QzB/9UjLs
 NCMw==
X-Gm-Message-State: AOAM532rN0SCm5/gxRrWmTjZxa0q6HCF+/hVqTwIXNydcJ/sVVwcz4g8
 Sjuq0R8Ba8+Flk0SQGXnI+apSLQfKA8=
X-Google-Smtp-Source: ABdhPJyPxF0VW6pj28qiQYBL5I+c5payg4Vl41FljTQZDNrKkyj5J3ax4NGWxNXikrPH6y1oPhFiOg==
X-Received: by 2002:a17:907:94c6:: with SMTP id
 dn6mr1194720ejc.13.1606162670986; 
 Mon, 23 Nov 2020 12:17:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id gn41sm4664355ejc.32.2020.11.23.12.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2020 12:17:50 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: unpack dma_fence_chain containers during sync
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20201118132039.2336-1-christian.koenig@amd.com>
 <1a20a665-f859-6ed3-be98-48cb5b9fcf37@gmail.com>
 <CAAxE2A5BLn0ygJc6nx5QPW1qWq6hpvQbzFm51pzan+jhe_BWWw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <53b5d31f-e533-0fb3-0907-76d2f3730af3@gmail.com>
Date: Mon, 23 Nov 2020 21:17:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAxE2A5BLn0ygJc6nx5QPW1qWq6hpvQbzFm51pzan+jhe_BWWw@mail.gmail.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Pierre-Eric Pelloux-Prayer <Pierre-eric.Pelloux-prayer@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1565058614=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1565058614==
Content-Type: multipart/alternative;
 boundary="------------7684E73B4306AFD57A5BC964"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7684E73B4306AFD57A5BC964
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

That the CPU round trip is gone now.

Christian.

Am 23.11.20 um 20:49 schrieb Marek Olšák:
> What is the behavior we should expect?
>
> Marek
>
> On Mon, Nov 23, 2020 at 7:31 AM Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     Ping, Pierre/Marek does this change works as expected?
>
>     Regards,
>     Christian.
>
>     Am 18.11.20 um 14:20 schrieb Christian König:
>     > This allows for optimizing the CPU round trip away.
>     >
>     > Signed-off-by: Christian König <christian.koenig@amd.com
>     <mailto:christian.koenig@amd.com>>
>     > ---
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 +-
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 27
>     ++++++++++++++++++++++++
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  1 +
>     >   3 files changed, 29 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     > index 79342976fa76..68f9a4adf5d2 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     > @@ -1014,7 +1014,7 @@ static int
>     amdgpu_syncobj_lookup_and_add_to_sync(struct amdgpu_cs_parser *p,
>     >               return r;
>     >       }
>     >
>     > -     r = amdgpu_sync_fence(&p->job->sync, fence);
>     > +     r = amdgpu_sync_fence_chain(&p->job->sync, fence);
>     >       dma_fence_put(fence);
>     >
>     >       return r;
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>     > index 8ea6c49529e7..d0d64af06f54 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>     > @@ -28,6 +28,8 @@
>     >    *    Christian König <christian.koenig@amd.com
>     <mailto:christian.koenig@amd.com>>
>     >    */
>     >
>     > +#include <linux/dma-fence-chain.h>
>     > +
>     >   #include "amdgpu.h"
>     >   #include "amdgpu_trace.h"
>     >   #include "amdgpu_amdkfd.h"
>     > @@ -169,6 +171,31 @@ int amdgpu_sync_fence(struct amdgpu_sync
>     *sync, struct dma_fence *f)
>     >       return 0;
>     >   }
>     >
>     > +/**
>     > + * amdgpu_sync_fence_chain - unpack dma_fence_chain and sync
>     > + *
>     > + * @sync: sync object to add fence to
>     > + * @f: potential dma_fence_chain to sync to.
>     > + *
>     > + * Add the fences inside the chain to the sync object.
>     > + */
>     > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync, struct
>     dma_fence *f)
>     > +{
>     > +     int r;
>     > +
>     > +     dma_fence_chain_for_each(f, f) {
>     > +             if (dma_fence_is_signaled(f))
>     > +                     continue;
>     > +
>     > +             r = amdgpu_sync_fence(sync, f);
>     > +             if (r) {
>     > +                     dma_fence_put(f);
>     > +                     return r;
>     > +             }
>     > +     }
>     > +     return 0;
>     > +}
>     > +
>     >   /**
>     >    * amdgpu_sync_vm_fence - remember to sync to this VM fence
>     >    *
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>     > index 7c0fe20c470d..b142175b65b6 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>     > @@ -48,6 +48,7 @@ struct amdgpu_sync {
>     >
>     >   void amdgpu_sync_create(struct amdgpu_sync *sync);
>     >   int amdgpu_sync_fence(struct amdgpu_sync *sync, struct
>     dma_fence *f);
>     > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync, struct
>     dma_fence *f);
>     >   int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct
>     dma_fence *fence);
>     >   int amdgpu_sync_resv(struct amdgpu_device *adev, struct
>     amdgpu_sync *sync,
>     >                    struct dma_resv *resv, enum amdgpu_sync_mode
>     mode,
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------7684E73B4306AFD57A5BC964
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">That the CPU round trip is gone now.<br>
      <br>
      Christian.<br>
      <br>
      Am 23.11.20 um 20:49 schrieb Marek Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A5BLn0ygJc6nx5QPW1qWq6hpvQbzFm51pzan+jhe_BWWw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>What is the behavior we should expect?</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Mon, Nov 23, 2020 at 7:31
          AM Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ping,
          Pierre/Marek does this change works as expected?<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          Am 18.11.20 um 14:20 schrieb Christian König:<br>
          &gt; This allows for optimizing the CPU round trip away.<br>
          &gt;<br>
          &gt; Signed-off-by: Christian König &lt;<a
            href="mailto:christian.koenig@amd.com" target="_blank"
            moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
          &gt; ---<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 +-<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 27
          ++++++++++++++++++++++++<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  1 +<br>
          &gt;   3 files changed, 29 insertions(+), 1 deletion(-)<br>
          &gt;<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          &gt; index 79342976fa76..68f9a4adf5d2 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          &gt; @@ -1014,7 +1014,7 @@ static int
          amdgpu_syncobj_lookup_and_add_to_sync(struct amdgpu_cs_parser
          *p,<br>
          &gt;               return r;<br>
          &gt;       }<br>
          &gt;   <br>
          &gt; -     r = amdgpu_sync_fence(&amp;p-&gt;job-&gt;sync,
          fence);<br>
          &gt; +     r =
          amdgpu_sync_fence_chain(&amp;p-&gt;job-&gt;sync, fence);<br>
          &gt;       dma_fence_put(fence);<br>
          &gt;   <br>
          &gt;       return r;<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
          &gt; index 8ea6c49529e7..d0d64af06f54 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
          &gt; @@ -28,6 +28,8 @@<br>
          &gt;    *    Christian König &lt;<a
            href="mailto:christian.koenig@amd.com" target="_blank"
            moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<br>
          &gt;    */<br>
          &gt;   <br>
          &gt; +#include &lt;linux/dma-fence-chain.h&gt;<br>
          &gt; +<br>
          &gt;   #include "amdgpu.h"<br>
          &gt;   #include "amdgpu_trace.h"<br>
          &gt;   #include "amdgpu_amdkfd.h"<br>
          &gt; @@ -169,6 +171,31 @@ int amdgpu_sync_fence(struct
          amdgpu_sync *sync, struct dma_fence *f)<br>
          &gt;       return 0;<br>
          &gt;   }<br>
          &gt;   <br>
          &gt; +/**<br>
          &gt; + * amdgpu_sync_fence_chain - unpack dma_fence_chain and
          sync<br>
          &gt; + *<br>
          &gt; + * @sync: sync object to add fence to<br>
          &gt; + * @f: potential dma_fence_chain to sync to.<br>
          &gt; + *<br>
          &gt; + * Add the fences inside the chain to the sync object.<br>
          &gt; + */<br>
          &gt; +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync,
          struct dma_fence *f)<br>
          &gt; +{<br>
          &gt; +     int r;<br>
          &gt; +<br>
          &gt; +     dma_fence_chain_for_each(f, f) {<br>
          &gt; +             if (dma_fence_is_signaled(f))<br>
          &gt; +                     continue;<br>
          &gt; +<br>
          &gt; +             r = amdgpu_sync_fence(sync, f);<br>
          &gt; +             if (r) {<br>
          &gt; +                     dma_fence_put(f);<br>
          &gt; +                     return r;<br>
          &gt; +             }<br>
          &gt; +     }<br>
          &gt; +     return 0;<br>
          &gt; +}<br>
          &gt; +<br>
          &gt;   /**<br>
          &gt;    * amdgpu_sync_vm_fence - remember to sync to this VM
          fence<br>
          &gt;    *<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
          &gt; index 7c0fe20c470d..b142175b65b6 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
          &gt; @@ -48,6 +48,7 @@ struct amdgpu_sync {<br>
          &gt;   <br>
          &gt;   void amdgpu_sync_create(struct amdgpu_sync *sync);<br>
          &gt;   int amdgpu_sync_fence(struct amdgpu_sync *sync, struct
          dma_fence *f);<br>
          &gt; +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync,
          struct dma_fence *f);<br>
          &gt;   int amdgpu_sync_vm_fence(struct amdgpu_sync *sync,
          struct dma_fence *fence);<br>
          &gt;   int amdgpu_sync_resv(struct amdgpu_device *adev, struct
          amdgpu_sync *sync,<br>
          &gt;                    struct dma_resv *resv, enum
          amdgpu_sync_mode mode,<br>
          <br>
          _______________________________________________<br>
          amd-gfx mailing list<br>
          <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank"
            moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
          <a
            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
            rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------7684E73B4306AFD57A5BC964--

--===============1565058614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1565058614==--
