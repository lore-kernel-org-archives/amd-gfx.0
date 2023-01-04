Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19E4C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7538A10E220;
	Wed,  4 Jan 2023 14:51:24 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAFF10E220
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 14:51:22 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id l26so24158591wme.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Jan 2023 06:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M30DJGRfisa7IBOYwdL1FLX0Z+zw/y5/AM4xc20F0bI=;
 b=a8/lFYTlKR2D+5QlysSLclInfZoAfg3I+vJw/eqfNWEs5gUA2e+mQd8M6gwD5Sg1JK
 fq55OSWbXuewOmW+1ijiqiwf3TszlPNthc7ZMsnOuDi+uiLVAfXtach1Zu2sjPCJMoYc
 HGHQO5SqhpVcgj/+qjwN2y5ghDAOk2UolDO7T2rLLIHkFPDmIg835UzT1fnEFWcxtsn/
 etDyucJ2ekWmVaAwxXk30VzCFeer5hWHcyzSrpSK6UrYq6HUhP9s1LyXwnMSEdsRq8IA
 M+BhEWaxPXsKSnp25au18y34w4ETj4Fpe+9xU3lWovEUiKepn6XVnpReFnoq4rgwQDbE
 tdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M30DJGRfisa7IBOYwdL1FLX0Z+zw/y5/AM4xc20F0bI=;
 b=BVeWmhXhB85TW5P3Bi9dLnmxdUuNT3JbR1p7EgkMli3+DZu1u6lNCUZPU9OqolaAEO
 pxfe3v327Ol8j9jrr0lVxtBxtPJuC+SxyHH76SgWUQ7rW8Pqr2H67xBBSpQGiOeVoyAV
 oX3okXh0fEnA13zxdDRD2szmut3OldhBQjkVkFShc3iTA58OvpG6SqH5vVix10OeCyhP
 ETxTlmMlc1UYKGqW8OtT9uPZwDN6McHDFa7VvfiQecD17xQ0k0wlu9EhWEEYkZ88f5c6
 3HhANxvHkgKCw8WlSalL1s5Pz6Vn8BdECAPL4sTHQR4KjudbdjKbTZxl084sgQmQyckR
 vOBg==
X-Gm-Message-State: AFqh2kp2LD8msYuVSXgf5Ac8+cNCfOPbDOQswQnOgJYmZOnbdIBw0BUP
 qkUeX7x0N0thVcsE5LJ7D0s=
X-Google-Smtp-Source: AMrXdXvpFCj0tCh8xQQ4aOfS5BSZDfc6vjS0HqEKtOOrdFuodsC0TcC+rRm10VtsRbtMT6yuz0WDdA==
X-Received: by 2002:a05:600c:1d0e:b0:3cf:8957:a441 with SMTP id
 l14-20020a05600c1d0e00b003cf8957a441mr60167wms.12.1672843880642; 
 Wed, 04 Jan 2023 06:51:20 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:8d9b:539b:3481:f5bc?
 ([2a02:908:1256:79a0:8d9b:539b:3481:f5bc])
 by smtp.gmail.com with ESMTPSA id
 i25-20020a1c5419000000b003c6c182bef9sm59930408wmb.36.2023.01.04.06.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jan 2023 06:51:19 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------YC9e4pPZt3LyJOxuxYLvBJX1"
Message-ID: <d1463910-1eab-2dac-a633-812ada011cc4@gmail.com>
Date: Wed, 4 Jan 2023 15:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPU_INFO_VM_STAT to return GPU VM
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
 <355bab4f-2ca8-3dd2-4cbc-264931fe9d7a@gmail.com>
 <CAAxE2A487Ra9ropymBGZpXSt=Zz81cjf56p_7wq+tK4cDfn1sA@mail.gmail.com>
 <1d0ddc01-b315-a5ff-f4cc-30b8aedfeb57@gmail.com>
 <CAAxE2A69e+rHQJP+wHYOxywB0+B4Vp4XsO429euoGE=H-VRsPw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A69e+rHQJP+wHYOxywB0+B4Vp4XsO429euoGE=H-VRsPw@mail.gmail.com>
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
--------------YC9e4pPZt3LyJOxuxYLvBJX1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 04.01.23 um 00:08 schrieb Marek Olšák:
> I see about the access now, but did you even look at the patch?

I did look at the patch, but I haven't fully understood yet what you are 
trying to do here.

> Because what the patch does isn't even exposed to common drm code, 
> such as the preferred domain and visible VRAM placement, so it can't 
> be in fdinfo right now.
>
> Or do you even know what fdinfo contains? Because it contains nothing 
> useful. It only has VRAM and GTT usage, which we already have in the 
> INFO ioctl, so it has nothing that we need. We mainly need the 
> eviction information and visible VRAM information now. Everything else 
> is a bonus.

Well the main question is what are you trying to get from that 
information? The eviction list for example is completely meaningless to 
userspace, that stuff is only temporary and will be cleared on the next 
CS again.

What we could expose is the VRAM over-commit value, e.g. how much BOs 
which where supposed to be in VRAM are in GTT now. I think that's what 
you are looking for here, right?

> Also, it's undesirable to open and parse a text file if we can just 
> call an ioctl.

Well I see the reasoning for that, but I also see why other drivers do a 
lot of the stuff we have as IOCTL as separate files in sysfs, fdinfo or 
debugfs.

Especially repeating all the static information which were already 
available under sysfs in the INFO IOCTL was a design mistake as far as I 
can see. Just compare what AMDGPU and the KFD code is doing to what for 
example i915 is doing.

Same for things like debug information about a process. The fdinfo stuff 
can be queried from external tools (gdb, gputop, umr etc...) as well 
which makes that interface more preferred.

>
> So do you want me to move it into amdgpu_vm.c? Because you could have 
> just said: Let's move it into amdgpu_vm.c. :)
>
> Thanks,
> Marek
>
> On Tue, Jan 3, 2023 at 3:33 AM Christian König 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     Take a look at /proc/self/fdinfo/$fd.
>
>     The Intel guys made that vendor agnostic and are using it within
>     their IGT gpu top tool.
>
>     Christian.
>
>     Am 02.01.23 um 18:57 schrieb Marek Olšák:
>>     What are you talking about? Is fdinfo in sysfs? Userspace drivers
>>     can't access sysfs.
>>
>>     Marek
>>
>>     On Mon, Jan 2, 2023, 10:56 Christian König
>>     <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>         Well first of all don't mess with the VM internals outside of
>>         the VM code.
>>
>>         Then why would we want to expose this through the IOCTL
>>         interface? We already have this in the fdinfo.
>>
>>         Christian.
>>
>>         Am 30.12.22 um 23:07 schrieb Marek Olšák:
>>>         To give userspace a detailed view about its GPU memory usage
>>>         and evictions.
>>>         This will help performance investigations.
>>>
>>>         Signed-off-by: Marek Olšák <marek.olsak@amd.com>
>>>
>>>         The patch is attached.
>>>
>>>         Marek
>>
>

--------------YC9e4pPZt3LyJOxuxYLvBJX1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 04.01.23 um 00:08 schrieb Marek Olšák:<br>
    <blockquote type="cite"
cite="mid:CAAxE2A69e+rHQJP+wHYOxywB0+B4Vp4XsO429euoGE=H-VRsPw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>I see about the access now, but did you even look at the
          patch?</div>
      </div>
    </blockquote>
    <br>
    I did look at the patch, but I haven't fully understood yet what you
    are trying to do here.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A69e+rHQJP+wHYOxywB0+B4Vp4XsO429euoGE=H-VRsPw@mail.gmail.com">
      <div dir="ltr">
        <div> Because what the patch does isn't even exposed to common
          drm code, such as the preferred domain and visible VRAM
          placement, so it can't be in fdinfo right now.<br>
        </div>
        <div><br>
        </div>
        <div>Or do you even know what fdinfo contains? Because it
          contains nothing useful. It only has VRAM and GTT usage, which
          we already have in the INFO ioctl, so it has nothing that we
          need. We mainly need the eviction information and visible VRAM
          information now. Everything else is a bonus.<br>
        </div>
      </div>
    </blockquote>
    <br>
    Well the main question is what are you trying to get from that
    information? The eviction list for example is completely meaningless
    to userspace, that stuff is only temporary and will be cleared on
    the next CS again.<br>
    <br>
    What we could expose is the VRAM over-commit value, e.g. how much
    BOs which where supposed to be in VRAM are in GTT now. I think
    that's what you are looking for here, right?<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A69e+rHQJP+wHYOxywB0+B4Vp4XsO429euoGE=H-VRsPw@mail.gmail.com">
      <div dir="ltr">
        <div>
          <div>Also, it's undesirable to open and parse a text file if
            we can just call an ioctl.</div>
        </div>
      </div>
    </blockquote>
    <br>
    Well I see the reasoning for that, but I also see why other drivers
    do a lot of the stuff we have as IOCTL as separate files in sysfs,
    fdinfo or debugfs.<br>
    <br>
    Especially repeating all the static information which were already
    available under sysfs in the INFO IOCTL was a design mistake as far
    as I can see. Just compare what AMDGPU and the KFD code is doing to
    what for example i915 is doing.<br>
    <br>
    Same for things like debug information about a process. The fdinfo
    stuff can be queried from external tools (gdb, gputop, umr etc...)
    as well which makes that interface more preferred.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A69e+rHQJP+wHYOxywB0+B4Vp4XsO429euoGE=H-VRsPw@mail.gmail.com">
      <div dir="ltr">
        <div>
          <div><br>
          </div>
          <div>So do you want me to move it into amdgpu_vm.c? Because
            you could have just said: Let's move it into amdgpu_vm.c. :)<br>
          </div>
          <div><br>
          </div>
          <div>Thanks,<br>
          </div>
          <div>Marek<br>
          </div>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, Jan 3, 2023 at 3:33 AM
          Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Take a look at /proc/self/fdinfo/$fd.<br>
            <br>
            The Intel guys made that vendor agnostic and are using it
            within their IGT gpu top tool.<br>
            <br>
            Christian.<br>
            <br>
            <div>Am 02.01.23 um 18:57 schrieb Marek Olšák:<br>
            </div>
            <blockquote type="cite">
              <div dir="auto">What are you talking about? Is fdinfo in
                sysfs? Userspace drivers can't access sysfs.
                <div dir="auto"><br>
                </div>
                <div dir="auto">Marek</div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Mon, Jan 2, 2023,
                  10:56 Christian König &lt;<a
                    href="mailto:ckoenig.leichtzumerken@gmail.com"
                    target="_blank" moz-do-not-send="true"
                    class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div> Well first of all don't mess with the VM
                    internals outside of the VM code.<br>
                    <br>
                    Then why would we want to expose this through the
                    IOCTL interface? We already have this in the fdinfo.<br>
                    <br>
                    Christian.<br>
                    <br>
                    <div>Am 30.12.22 um 23:07 schrieb Marek Olšák:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">To give userspace a detailed view
                        about its GPU memory usage and evictions.<br>
                        This will help performance investigations.<br>
                        <br>
                        <div>Signed-off-by: Marek Olšák &lt;<a
                            href="mailto:marek.olsak@amd.com"
                            rel="noreferrer" target="_blank"
                            moz-do-not-send="true"
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
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------YC9e4pPZt3LyJOxuxYLvBJX1--
