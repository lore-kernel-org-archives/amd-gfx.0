Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7D9C64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 16:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36CE10E1A6;
	Thu,  9 Mar 2023 16:13:39 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF9710E8B5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 16:13:37 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id da10so9179488edb.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Mar 2023 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678378416;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxU1G0LlxZFQlUsZBoUMg2Cgf+8iIFVWNFSxxW+Eueg=;
 b=CTEImDplc3htbkCDhs+p+ft3r1ji+4Z5x6rqnF0TO3x9TK0Ym9Mpzwh5vTX/ey3lNX
 rpCLpvmLZ/7g2XW3/31FclPxmo2L/q0vno7zGYUhexU3GrXTV/Sl0IoIzo+sVV9RzMdO
 QH0AC4drqjCYIZnDqaOSD5Q+FJaU1797AP0iDPactlt7IYpCAhcnmsMG1/7yfU5XMNa/
 EN1ibSqwSuvp0qq3bjeYr11viMCpzB6RBUFzrA4mSBIWqKfWkIPgrIZbwq2rFDVjDvO6
 UiLWVa0ndsLqn4FCNEkojQ4MSXWtKX7loGJ8sLFE4qdS24HuDbyDSfOmtlpgu0Er8akR
 txWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678378416;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lxU1G0LlxZFQlUsZBoUMg2Cgf+8iIFVWNFSxxW+Eueg=;
 b=p0mWV+X4theFU3QiYcWIwiuSNiAzQ+QMKaap85x9BZFwhmYyOlB7X9P4s/xzUZgKQe
 sytF7fjAordWbSkqjgXhMer7J8Gxzccgyu//DaaV/9pESL1jC2PttZiZjY/d0Bp+RCUS
 XGOGW3U//+l5XIT/A1uEtaHq5oQpYe4A7Hw3XEh5L3LdIb+ZgU1eBbAKWK4pffCmzjvy
 yaNkRHtA1drk9+x1QU57vIYOZ+K+ENqj0xxJ1ZcywsaR3n1lMgmRsRfJ5knKNKRtZAyv
 35atuTdr42cgpf0n9eNoe09ULDoCi/igZH5aFjFr2ZM+eZLX8SdNDioazkkYDHkrnhMD
 WpjA==
X-Gm-Message-State: AO0yUKU6XrvUsbISa40IWRRPUHlWMjP5ucPJLsQWgyIOzlPlurpijh54
 x9Imm1iMtzHG3qNAN7fEo6U=
X-Google-Smtp-Source: AK7set+5AoEfEs9xmhZZOGDpuvuo3jEkhOP8NsuK1DfOvxkwUgxLLuwjduDXIKdyqVwyPsnpiS8rqA==
X-Received: by 2002:aa7:dcd7:0:b0:4ac:b2c8:aeac with SMTP id
 w23-20020aa7dcd7000000b004acb2c8aeacmr18496544edu.40.1678378416183; 
 Thu, 09 Mar 2023 08:13:36 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:ab5b:407e:ab53:db4f?
 ([2a02:908:1256:79a0:ab5b:407e:ab53:db4f])
 by smtp.gmail.com with ESMTPSA id
 b31-20020a509f22000000b004eb16b75b93sm4959366edf.49.2023.03.09.08.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Mar 2023 08:13:35 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------SXzYxBzZkMy1fLsHKmtlMgHH"
Message-ID: <f5076ead-4c8d-8122-26ff-e1b0ede55584@gmail.com>
Date: Thu, 9 Mar 2023 17:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: expose more memory stats in fdinfo
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <CAAxE2A6Y=++EP8vqzqjGQ3kfh2=JC7PKGoyJvfw9pFVL2UcNJg@mail.gmail.com>
 <3c2f16a9-64f2-9124-afc4-43af37fb82fa@gmail.com>
 <CAAxE2A54Z_ghZFFBb+s-0kx4z-st=XyLXb1fVHkfw2z=ROTC-A@mail.gmail.com>
 <CAAxE2A6uh5z0i=g1yFXid509Mo0OkJJ-2N_23wqfn2XTRJAr5g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A6uh5z0i=g1yFXid509Mo0OkJJ-2N_23wqfn2XTRJAr5g@mail.gmail.com>
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
--------------SXzYxBzZkMy1fLsHKmtlMgHH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Feel free to add my rb on this and push it to amd-staging-drm-next.

Christian.

Am 09.03.23 um 17:02 schrieb Marek Olšák:
> Ping
>
> On Thu, Feb 23, 2023 at 1:46 PM Marek Olšák <maraeo@gmail.com> wrote:
>
>     Updated patch attached.
>
>     Marek
>
>     On Mon, Feb 6, 2023 at 4:05 AM Christian König
>     <ckoenig.leichtzumerken@gmail.com> wrote:
>
>         Just two nit picks:
>
>         +    seq_printf(m, "drm-evicted-visible-vram:\t%llu KiB\n",
>         +           stats.evicted_visible_vram/1024UL);
>
>         For the values not standardized for all DRM drivers we might
>         want to use
>         amd as prefix here instead of drm.
>
>         +    uint64_t requested_gtt;        /* how much userspace
>         asked for */
>
>         We used to have automated checkers complaining about comments
>         after members.
>
>         Kerneldoc complicent comments look like this:
>
>                          /* @timestamp replaced by @rcu on
>         dma_fence_release() */
>                          struct rcu_head rcu;
>
>         Apart from that looks good to me.
>
>         Regards,
>         Christian.
>
>         Am 30.01.23 um 07:56 schrieb Marek Olšák:
>         > Hi,
>         >
>         > This will be used for performance investigations. The patch
>         is attached.
>         >
>         > Thanks,
>         > Marek
>

--------------SXzYxBzZkMy1fLsHKmtlMgHH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Feel free to add my rb on this and push it to amd-staging-drm-next.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 09.03.23 um 17:02 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A6uh5z0i=g1yFXid509Mo0OkJJ-2N_23wqfn2XTRJAr5g@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">Ping<br>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Thu, Feb 23, 2023 at
          1:46 PM Marek Olšák &lt;<a href="mailto:maraeo@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir="ltr">
            <div>Updated patch attached.</div>
            <div><br>
            </div>
            <div>Marek<br>
            </div>
          </div>
          <br>
          <div class="gmail_quote">
            <div dir="ltr" class="gmail_attr">On Mon, Feb 6, 2023 at
              4:05 AM Christian König &lt;<a
                href="mailto:ckoenig.leichtzumerken@gmail.com"
                target="_blank" moz-do-not-send="true"
                class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">Just two nit picks:<br>
              <br>
              +    seq_printf(m, "drm-evicted-visible-vram:\t%llu
              KiB\n",<br>
              +           stats.evicted_visible_vram/1024UL);<br>
              <br>
              For the values not standardized for all DRM drivers we
              might want to use <br>
              amd as prefix here instead of drm.<br>
              <br>
              +    uint64_t requested_gtt;        /* how much userspace
              asked for */<br>
              <br>
              We used to have automated checkers complaining about
              comments after members.<br>
              <br>
              Kerneldoc complicent comments look like this:<br>
              <br>
                               /* @timestamp replaced by @rcu on
              dma_fence_release() */<br>
                               struct rcu_head rcu;<br>
              <br>
              Apart from that looks good to me.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 30.01.23 um 07:56 schrieb Marek Olšák:<br>
              &gt; Hi,<br>
              &gt;<br>
              &gt; This will be used for performance investigations. The
              patch is attached.<br>
              &gt;<br>
              &gt; Thanks,<br>
              &gt; Marek<br>
              <br>
            </blockquote>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------SXzYxBzZkMy1fLsHKmtlMgHH--
