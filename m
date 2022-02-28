Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C18C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 11:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D48510E40D;
	Mon, 28 Feb 2022 11:50:28 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538C610E40D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 11:50:27 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id h15so17187814edv.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 03:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to;
 bh=qkpt3x+tezeHYmewSpA9RRzlSUfyOk7nPA/CJrxhgdM=;
 b=QSycR0bHLANwdU1jO4WvCAxhpTgeibiqPboEoipdoB/DeoLGCqLCPnqFmLEmoAE5u0
 x3b855V+jsDG4Jgi0yJkNAG+Kzxhlm9dRJpRJjEm+wu0ez8S0mrh6JaZfDJCx+U76LOW
 Wk2shelCFey6ZdItKS++cFkU7B/ZDN39RivkzLXd+6vSOAOCZCeSPbRnelLSRphl6lsx
 j57nng5UNlKyKX05EzIFvJbcwZJGVzS1uA+BkkKPoHfbgEIHaWXxvgr9lnteAXKHN5w4
 fuGOAVP6h/8b2F4q5ba2OeD7m7EthP3/K9TO8cklV+KQTBIwnNlrPbYXGMaGra5eGbcR
 YikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to;
 bh=qkpt3x+tezeHYmewSpA9RRzlSUfyOk7nPA/CJrxhgdM=;
 b=5pwkksp8IIXV66o+y+MPraFyzNR2GHhldJ8iRFTet2yCzxUVXHckkhOUz7JM86RRCF
 4iD7wpCwSD31hEvFEowz37ujMTbWKMIpgV5PK4xuXFUK40y1ETvfNVqETF8+EfJlQgMo
 KuOfCSY6EBS9pnbQV698K91YaGZacVRumjt+5Mv7jc8GdjT/YlsIeDl6kLrk5GYwoiX0
 UMmQRwqOHitRQ7M9NfYfNwdE/k0drGVek08OTOy5SR7D/r39eF5or6k9wX+fHVb9VHyu
 7FemD1x85BotufHJdUb7pMVRAV4kcFiKtLCyzYpQdMutWh52AGfhnoCKQm4nvBUEFqtY
 SoJA==
X-Gm-Message-State: AOAM532mK24yqVE2Ik4oiBUaDmr6GCcMuzsnW28KRrBRx20u3yrPj9m+
 xj3eg7Z/TCq59vvC/o3News=
X-Google-Smtp-Source: ABdhPJwYzAr69eyZAJqUSysdSDCLUhnN0tlyzLAK5gofDkkbNbmjlsUqR6CnwOQkoAXNfnJLmWPOqg==
X-Received: by 2002:a05:6402:1941:b0:413:2822:9c8 with SMTP id
 f1-20020a056402194100b00413282209c8mr19172783edz.13.1646049025718; 
 Mon, 28 Feb 2022 03:50:25 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:6cde:13e6:6361:ba15?
 ([2a02:908:1252:fb60:6cde:13e6:6361:ba15])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a1709063f8e00b006ae0a666c02sm4291037ejj.96.2022.02.28.03.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Feb 2022 03:50:25 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------JSd60lK8ymlQdrukY1YQS1AT"
Message-ID: <599ef7a1-389a-6fda-71e3-11776645e6dc@gmail.com>
Date: Mon, 28 Feb 2022 12:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: kernel amdgpu problems
Content-Language: en-US
To: Alex fxmbsw7 Ratchev <fxmbsw7@gmail.com>,
 Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org
References: <CAALKErFVZt9+5pPuDYj=zcaB9xr0=iWN4whQR2WRVK6vGe=bdQ@mail.gmail.com>
 <CAHbf0-G8Rm-Q665mrEOOds109ojvng7qA4DseJsAYq01UfaJtQ@mail.gmail.com>
 <CAALKErHVGydCZ3V2ZSNz9BCZTXCxOxgjJdmjX5BY6MyAA5xXbQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAALKErHVGydCZ3V2ZSNz9BCZTXCxOxgjJdmjX5BY6MyAA5xXbQ@mail.gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------JSd60lK8ymlQdrukY1YQS1AT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 28.02.22 um 07:43 schrieb Alex fxmbsw7 Ratchev:
>
>
> On Mon, Feb 28, 2022 at 12:22 AM Mike Lothian <mike@fireburn.co.uk> wrote:
>
>     On Sat, 26 Feb 2022 at 10:01, Alex fxmbsw7 Ratchev
>     <fxmbsw7@gmail.com> wrote:
>     >
>     > i have observed at least two major problems of using amdgpu
>     >
>     > 1. cant be built-in instead of module, display stays blank
>
>     Are you remembering to add in the firmware to the kernel image too?
>
>
> i copied all from official linux-firmware.gif to /lib/firmware

That's not sufficient, you need to tell the kernel explicitly which 
firmware will be needed.

In other words try mentioning everything in /lib/firmware/amdgpu as 
CONFIG_EXTRA_FIRMWARE.

Regards,
Christian.

>
>     There's a good guide at
>     https://wiki.gentoo.org/wiki/AMDGPU#Known_firmware_blobs
>
>     I've successfully used AMDGPU builtin on Tonga, Raven, Renoir and Navy
>     Flounder systems
>
>     I've never used kexec so have no suggestions for that
>
>
> it may be back then when i compiled it inline not as module i didnt 
> include firmware in the initrd so that may been that
>
> about kexec, i dunno, X dri doesnt work after first kexec, after 
> second screen at all is blank
>
> driver init problems ..
>
> cheers..

--------------JSd60lK8ymlQdrukY1YQS1AT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 28.02.22 um 07:43 schrieb Alex fxmbsw7 Ratchev:<br>
    <blockquote type="cite"
cite="mid:CAALKErHVGydCZ3V2ZSNz9BCZTXCxOxgjJdmjX5BY6MyAA5xXbQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Mon, Feb 28, 2022 at
            12:22 AM Mike Lothian &lt;<a
              href="mailto:mike@fireburn.co.uk" moz-do-not-send="true"
              class="moz-txt-link-freetext">mike@fireburn.co.uk</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">On Sat, 26 Feb 2022 at
            10:01, Alex fxmbsw7 Ratchev &lt;<a
              href="mailto:fxmbsw7@gmail.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">fxmbsw7@gmail.com</a>&gt;
            wrote:<br>
            &gt;<br>
            &gt; i have observed at least two major problems of using
            amdgpu<br>
            &gt;<br>
            &gt; 1. cant be built-in instead of module, display stays
            blank<br>
            <br>
            Are you remembering to add in the firmware to the kernel
            image too?<br>
          </blockquote>
          <div><br>
          </div>
          <div>i copied all from official linux-firmware.gif to
            /lib/firmware <br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    That's not sufficient, you need to tell the kernel explicitly which
    firmware will be needed.<br>
    <br>
    In other words try mentioning everything in /lib/firmware/amdgpu as
    CONFIG_EXTRA_FIRMWARE.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAALKErHVGydCZ3V2ZSNz9BCZTXCxOxgjJdmjX5BY6MyAA5xXbQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            There's a good guide at <a
              href="https://wiki.gentoo.org/wiki/AMDGPU#Known_firmware_blobs"
              rel="noreferrer" target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://wiki.gentoo.org/wiki/AMDGPU#Known_firmware_blobs</a><br>
            <br>
            I've successfully used AMDGPU builtin on Tonga, Raven,
            Renoir and Navy<br>
            Flounder systems<br>
            <br>
            I've never used kexec so have no suggestions for that<br>
          </blockquote>
          <div><br>
          </div>
          <div>it may be back then when i compiled it inline not as
            module i didnt include firmware in the initrd so that may
            been that</div>
          <div><br>
          </div>
          <div>about kexec, i dunno, X dri doesnt work after first
            kexec, after second screen at all is blank</div>
          <div><br>
          </div>
          <div>driver init problems ..</div>
          <div><br>
          </div>
          <div>cheers.. </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------JSd60lK8ymlQdrukY1YQS1AT--
