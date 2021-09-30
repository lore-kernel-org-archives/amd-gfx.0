Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C00C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 06:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BF161390
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 06:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7BF161390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189566E301;
	Thu, 30 Sep 2021 06:30:14 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E1106E301
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 06:30:12 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id x20so8131378wrg.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 23:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=EA24UXiMFlIl5fG/vXIjHZNw7v9KXw3YfgbowKfBJ7Y=;
 b=I/yTEOR5r4A1LqBAl+wlGyWwbw6Da93OFHgiU0QoqYaxM94vOBLUZIXxqJGTy4TvkO
 Pavrw3k8l9sEYDmgUgxKFuQ7e8qbNHXxA1AXpveQ9HbMY+gtXOK/Se1dXQlAUbCIxskV
 OcroeeL5Gnl6L/m2Zt+T6GHO9hBn/iJu+g0srDxfcLTiFAEIBfPGVoA5NwXcmdLxqgxT
 NvpeABKbAhZn+6uJayHroeGpajBWMB1BRLazB6zr1nmnLApTZZ6PmxCyyHPJ74cADCLT
 ppy4b+PTHB1PUTiSXE2b/8BmvT0/EU0uCc4OhTzLuyWs/elGjlbqeSruqYZoMH/HBmi1
 39Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=EA24UXiMFlIl5fG/vXIjHZNw7v9KXw3YfgbowKfBJ7Y=;
 b=Xssz3XY/3rEqQ0jcMCTNH9WqFF1+HhX6xHNjdcg7VGOMWkX2PNJSOoJz1t1jrb+qF2
 sCAwoWpH+pA4cYNNIykzPUidXNwqQp7gBGcXkVJyzgbTkNCY6aBGKK4RHRaKEKrUZhja
 POWD+rcAdc+kC6wEh/KujQL4hEtFgEjkWl4c0VdBbLGJ0/5+ojZ3exR/4zG53+ggHDnR
 KpiU3PiOHZQJMVnBBqjg92NQC7kN4wj3LmwcfouhoaWWPLWEQOqV0n2AQiEI0hmUGoqq
 dCMJd1YyPq+A9U4zqq4dN3dDwGQ+NyiRUQiDKsTSNEHblssnVfSHalFyInRakYT5knyJ
 QmqQ==
X-Gm-Message-State: AOAM530R4X1OzH0y+nAELaKl3pICjXmXveBcJHj6LGa/mWnuUdrCTWvd
 lukZYDLGeI3mmqzv1990qzw1Z6w5uA0=
X-Google-Smtp-Source: ABdhPJwUe+eUryNdBb6ORDvdhVbvRDC/6rxsWiO5HF9AXsVx/Tbh7rlcIBopGNyvYBKyS/nKu/hgGQ==
X-Received: by 2002:a05:6000:160c:: with SMTP id
 u12mr4148810wrb.128.1632983411196; 
 Wed, 29 Sep 2021 23:30:11 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id i2sm1906191wrq.78.2021.09.29.23.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 23:30:10 -0700 (PDT)
Subject: Re: amdgpu driver halted on suspend of shutdown
To: =?UTF-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <f5d30be9-7980-e44d-0eca-7cfe7c0c1d05@kylinos.cn>
 <CADnq5_MC4XPWcgT0FE5mmghZD9+YPaaAXPAkzUjFEO-hxr20Eg@mail.gmail.com>
 <dc3c0e5c-a1cf-4d98-030a-967bad2c8d01@kylinos.cn>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ed106229-56ed-99f8-e2ea-67755750265e@gmail.com>
Date: Thu, 30 Sep 2021 08:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dc3c0e5c-a1cf-4d98-030a-967bad2c8d01@kylinos.cn>
Content-Type: multipart/alternative;
 boundary="------------8A310AF8AA9BC6A196A36A36"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------8A310AF8AA9BC6A196A36A36
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Well you could remove it locally if it solves your problem at hand.

But keep in mind that a lot of ARM boards are simply not compliant to 
the PCIe specification and the hardware won't work correctly on those in 
general.

I'm pretty sure you have one of those cases here.

Christian.

Am 30.09.21 um 03:26 schrieb 李真能:
>
> So, Can I remove suspend process in amdgpu_pci_shutdown if  I don't  
> use amdgpu driver in vm?
>
> Thank you so much foryour reply!
>
> 在 2021/9/30 上午5:12, Alex Deucher 写道:
>> On Wed, Sep 29, 2021 at 3:25 AM 李真能<lizhenneng@kylinos.cn>  wrote:
>>> Hello:
>>>
>>>           When I do loop  auto test of reboot, I found  kernel may halt
>>> on memcpy_fromio of amdgpu's amdgpu_uvd_suspend, so I remove suspend
>>> process in amdgpu_pci_shutdown, and it will fix this bug.
>>>
>>> I have 3 questions to ask:
>>>
>>> 1. In amdgpu_pci_shutdown, the comment explains why we must execute
>>> suspend,  so I know VM will call amdgpu driver in which situations, as I
>>> know, VM's graphics card is a virtual card;
>>>
>>> 2. I see a path that is commited by Alex Deucher, the commit message is
>>> as follows:
>>>
>>> drm/amdgpu: just suspend the hw on pci shutdown
>>>
>>> We can't just reuse pci_remove as there may be userspace still
>>>       doing things.
>>>
>>> My question is:In which situations, there may be  userspace till doing
>>> things.
>>>
>>> 3. Why amdgpu driver is halted on memcpy_fromio of amdgpu_uvd_suspend, I
>>> haven't launch any video app during reboot test, is it the bug of pci bus?
>>>
>>> Test environment:
>>>
>>> CPU: arm64
>> I suspect the problem is something ARM specific.  IIRC, we added the
>> memcpy_fromio() to work around a limitation in ARM related to CPU
>> mappings of PCI BAR memory.  The whole point of the PCI shutdown
>> callback is to put the device into a quiescent state (e.g., stop all
>> DMAs and asynchronous engines, etc.).  Some of that tear down requires
>> access to PCI BARs.
>>
>> Alex
>>
>>
>>> Graphics card: r7340(amdgpu), rx550
>>>
>>> OS: ubuntu 2004
>>>


--------------8A310AF8AA9BC6A196A36A36
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Well you could remove it locally if it solves your problem at hand.<br>
    <br>
    But keep in mind that a lot of ARM boards are simply not compliant
    to the PCIe specification and the hardware won't work correctly on
    those in general.<br>
    <br>
    I'm pretty sure you have one of those cases here.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 30.09.21 um 03:26 schrieb 李真能:<br>
    </div>
    <blockquote type="cite"
      cite="mid:dc3c0e5c-a1cf-4d98-030a-967bad2c8d01@kylinos.cn">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>So, Can I remove suspend process in amdgpu_pci_shutdown if  I
        don't  use amdgpu driver in vm?</p>
      <p><span id="tran_0_0" class="">Thank you so much for</span><span>
          your </span><span id="tran_0_1" class="">reply</span><span>!</span></p>
      <div class="moz-cite-prefix">在 2021/9/30 上午5:12, Alex Deucher 写道:<br>
      </div>
      <blockquote type="cite"
cite="mid:CADnq5_MC4XPWcgT0FE5mmghZD9+YPaaAXPAkzUjFEO-hxr20Eg@mail.gmail.com">
        <pre class="moz-quote-pre" wrap="">On Wed, Sep 29, 2021 at 3:25 AM 李真能 <a class="moz-txt-link-rfc2396E" href="mailto:lizhenneng@kylinos.cn" moz-do-not-send="true">&lt;lizhenneng@kylinos.cn&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Hello:

         When I do loop  auto test of reboot, I found  kernel may halt
on memcpy_fromio of amdgpu's amdgpu_uvd_suspend, so I remove suspend
process in amdgpu_pci_shutdown, and it will fix this bug.

I have 3 questions to ask:

1. In amdgpu_pci_shutdown, the comment explains why we must execute
suspend,  so I know VM will call amdgpu driver in which situations, as I
know, VM's graphics card is a virtual card;

2. I see a path that is commited by Alex Deucher, the commit message is
as follows:

drm/amdgpu: just suspend the hw on pci shutdown

We can't just reuse pci_remove as there may be userspace still
     doing things.

My question is:In which situations, there may be  userspace till doing
things.

3. Why amdgpu driver is halted on memcpy_fromio of amdgpu_uvd_suspend, I
haven't launch any video app during reboot test, is it the bug of pci bus?

Test environment:

CPU: arm64
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I suspect the problem is something ARM specific.  IIRC, we added the
memcpy_fromio() to work around a limitation in ARM related to CPU
mappings of PCI BAR memory.  The whole point of the PCI shutdown
callback is to put the device into a quiescent state (e.g., stop all
DMAs and asynchronous engines, etc.).  Some of that tear down requires
access to PCI BARs.

Alex


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Graphics card: r7340(amdgpu), rx550

OS: ubuntu 2004

</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------8A310AF8AA9BC6A196A36A36--
