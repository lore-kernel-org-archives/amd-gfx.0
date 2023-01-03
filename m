Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B71C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 08:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27DA10E3AE;
	Tue,  3 Jan 2023 08:33:12 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C3D10E3AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 08:33:10 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id j17so23325489wrr.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 00:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7kiahq3dJHrk7yNoIrzAdgmHp8t5bL1gN+YCkOpaoY=;
 b=n8NStT+wJPfqanwNCaEZyAwxR8Lbt/f9E3NW64ixBjq43bh6nOut6ZkhtfmcBthX3S
 7lUlDUKNsPwjIv1C5aBQCm9hNyjyfD6Us/X/KrGAPRPpebffPaFTQ6hRzrT9Bite3aY7
 jO3eAz5bJcs0yb0U8D2PuUF7EkghuA7+cAwlQDrglk4hH2I31GycDOPlFV53ockehM3G
 2nAaBChGMvsEIUiyo6qinWJAPYIhxZHxmIQZZNTrx9OC4eWkAyPJtDSgUUzo3m36w33A
 6jXSyyvPPLEuW89AB5OF6CT50AlBM5pUeKRxcZ1xgCUmL9jvUHc32tpvguTPSubfbOOV
 wp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d7kiahq3dJHrk7yNoIrzAdgmHp8t5bL1gN+YCkOpaoY=;
 b=HAAeeGwEgaCSSOYm+QeWeo72cJPy82L3hk/ueqnVqzJ2OZcIT8GJFegLHYBTMpOvDw
 WCeIH8vHvCtyUKtCDKU+tLyplyGN/8h4KbgKqyB5zQCyx/hIDzgUJy3imx9R9h1O+k1W
 8iEl8Apx5C6J8qwIJRJLkPmhbyya4trBWfgaxabGTAR9l5qDNXaEQl+T3dRIEbizyOu7
 pvyK040/YPMV6D2I9L1vCQmevSUxIWBiq2Shl6ooNr0eOF++2Xe0mzhKa4/mDyzcBEo+
 B1sbPHeUjOI56yxkW224EXbTJEM074SuS1/HAkaHIXeqtcRG08jx7y7XqYQxvJ6pHvmd
 vzLQ==
X-Gm-Message-State: AFqh2kp5dU6wEHQB/3cNVsawc/ntGPCuqpZ1HcYQgBMg16TrF87tSHb8
 NDuHzyTHjW8xvIUBE2GXaDI=
X-Google-Smtp-Source: AMrXdXtIQ306W2bul2gK9s7i48FSJjmFHmjQZBsRFgV90ED+YtR2DDCHTU/53UwQUcHknWrq3E2EnA==
X-Received: by 2002:adf:d851:0:b0:242:1522:24a0 with SMTP id
 k17-20020adfd851000000b00242152224a0mr25567964wrl.47.1672734788654; 
 Tue, 03 Jan 2023 00:33:08 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:91f2:4ffb:eef9:7882?
 ([2a02:908:1256:79a0:91f2:4ffb:eef9:7882])
 by smtp.gmail.com with ESMTPSA id
 h6-20020adffa86000000b0024246991121sm31445135wrr.116.2023.01.03.00.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jan 2023 00:33:08 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------lRcVO7J3CJgraqGpvFaEHatO"
Message-ID: <1d0ddc01-b315-a5ff-f4cc-30b8aedfeb57@gmail.com>
Date: Tue, 3 Jan 2023 09:33:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPU_INFO_VM_STAT to return GPU VM
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
 <355bab4f-2ca8-3dd2-4cbc-264931fe9d7a@gmail.com>
 <CAAxE2A487Ra9ropymBGZpXSt=Zz81cjf56p_7wq+tK4cDfn1sA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A487Ra9ropymBGZpXSt=Zz81cjf56p_7wq+tK4cDfn1sA@mail.gmail.com>
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
--------------lRcVO7J3CJgraqGpvFaEHatO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Take a look at /proc/self/fdinfo/$fd.

The Intel guys made that vendor agnostic and are using it within their 
IGT gpu top tool.

Christian.

Am 02.01.23 um 18:57 schrieb Marek Olšák:
> What are you talking about? Is fdinfo in sysfs? Userspace drivers 
> can't access sysfs.
>
> Marek
>
> On Mon, Jan 2, 2023, 10:56 Christian König 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     Well first of all don't mess with the VM internals outside of the
>     VM code.
>
>     Then why would we want to expose this through the IOCTL interface?
>     We already have this in the fdinfo.
>
>     Christian.
>
>     Am 30.12.22 um 23:07 schrieb Marek Olšák:
>>     To give userspace a detailed view about its GPU memory usage and
>>     evictions.
>>     This will help performance investigations.
>>
>>     Signed-off-by: Marek Olšák <marek.olsak@amd.com>
>>
>>     The patch is attached.
>>
>>     Marek
>

--------------lRcVO7J3CJgraqGpvFaEHatO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Take a look at /proc/self/fdinfo/$fd.<br>
    <br>
    The Intel guys made that vendor agnostic and are using it within
    their IGT gpu top tool.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 02.01.23 um 18:57 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A487Ra9ropymBGZpXSt=Zz81cjf56p_7wq+tK4cDfn1sA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">What are you talking about? Is fdinfo in sysfs?
        Userspace drivers can't access sysfs.
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Mon, Jan 2, 2023, 10:56
          Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">
          <div> Well first of all don't mess with the VM internals
            outside of the VM code.<br>
            <br>
            Then why would we want to expose this through the IOCTL
            interface? We already have this in the fdinfo.<br>
            <br>
            Christian.<br>
            <br>
            <div>Am 30.12.22 um 23:07 schrieb Marek Olšák:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">To give userspace a detailed view about its
                GPU memory usage and evictions.<br>
                This will help performance investigations.<br>
                <br>
                <div>Signed-off-by: Marek Olšák &lt;<a
                    href="mailto:marek.olsak@amd.com" target="_blank"
                    rel="noreferrer" moz-do-not-send="true"
                    class="moz-txt-link-freetext">marek.olsak@amd.com</a>&gt;</div>
                <div><br>
                </div>
                <div>The patch is attached.</div>
                <div><br>
                </div>
                <div>Marek<br>
                </div>
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

--------------lRcVO7J3CJgraqGpvFaEHatO--
