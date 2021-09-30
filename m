Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFDAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB29A615A2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB29A615A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CABD6EB21;
	Thu, 30 Sep 2021 02:03:53 +0000 (UTC)
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18F36EB15
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 01:28:47 +0000 (UTC)
X-UUID: 993842a9cda04ea6ad2ed57bc14bac0d-20210930
X-CPASD-INFO: ec70aeb55926416ab06c86cee760c4b5@rrNxUI6XkGVhWXSCg3SBm4JhZpNoYoO
 0p3FWYJFkjlWVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3tKVxUJGTkg==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: ec70aeb55926416ab06c86cee760c4b5
X-CPASD-SUMMARY: SIP:-1, APTIP:-2.0, KEY:0.0, FROMBLOCK:1, EXT:0.0, OB:0.0,
 URL:-5, T
 VAL:161.0, ESV:0.0, ECOM:-5.0, ML:0.0, FD:0.0, CUTS:138.0, IP:-2.0, MAL:0.0,
 ATTNUM:0
 .0, PHF:-5.0, PHC:-5.0, SPF:4.0, EDMS:-3, IPLABEL:4480.0, FROMTO:0, AD:0,
 FFOB:0.0, CF
 OB:0.0, SPC:0.0, SIG:-5, AUF:8, DUF:15365, ACD:57, DCD:159, SL:0, AG:0,
 CFC:0.663, CFSR :0.05,UAT:0,RAF:2,VERSION:2.3.4
X-CPASD-ID: 993842a9cda04ea6ad2ed57bc14bac0d-20210930
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: 993842a9cda04ea6ad2ed57bc14bac0d-20210930
X-User: lizhenneng@kylinos.cn
Received: from [172.20.108.41] [(116.128.244.169)] by nksmu.kylinos.cn
 (envelope-from <lizhenneng@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
 with ESMTP id 2001967444; Thu, 30 Sep 2021 09:25:46 +0800
Subject: Re: amdgpu driver halted on suspend of shutdown
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <f5d30be9-7980-e44d-0eca-7cfe7c0c1d05@kylinos.cn>
 <CADnq5_MC4XPWcgT0FE5mmghZD9+YPaaAXPAkzUjFEO-hxr20Eg@mail.gmail.com>
From: =?UTF-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
Message-ID: <dc3c0e5c-a1cf-4d98-030a-967bad2c8d01@kylinos.cn>
Date: Thu, 30 Sep 2021 09:26:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_MC4XPWcgT0FE5mmghZD9+YPaaAXPAkzUjFEO-hxr20Eg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------1C27D9EFA4FED9FFE32ED476"
X-Mailman-Approved-At: Thu, 30 Sep 2021 02:03:49 +0000
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
--------------1C27D9EFA4FED9FFE32ED476
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

So, Can I remove suspend process in amdgpu_pci_shutdown if  I don't  use 
amdgpu driver in vm?

Thank you so much foryour reply!

在 2021/9/30 上午5:12, Alex Deucher 写道:
> On Wed, Sep 29, 2021 at 3:25 AM 李真能 <lizhenneng@kylinos.cn> wrote:
>> Hello:
>>
>>           When I do loop  auto test of reboot, I found  kernel may halt
>> on memcpy_fromio of amdgpu's amdgpu_uvd_suspend, so I remove suspend
>> process in amdgpu_pci_shutdown, and it will fix this bug.
>>
>> I have 3 questions to ask:
>>
>> 1. In amdgpu_pci_shutdown, the comment explains why we must execute
>> suspend,  so I know VM will call amdgpu driver in which situations, as I
>> know, VM's graphics card is a virtual card;
>>
>> 2. I see a path that is commited by Alex Deucher, the commit message is
>> as follows:
>>
>> drm/amdgpu: just suspend the hw on pci shutdown
>>
>> We can't just reuse pci_remove as there may be userspace still
>>       doing things.
>>
>> My question is:In which situations, there may be  userspace till doing
>> things.
>>
>> 3. Why amdgpu driver is halted on memcpy_fromio of amdgpu_uvd_suspend, I
>> haven't launch any video app during reboot test, is it the bug of pci bus?
>>
>> Test environment:
>>
>> CPU: arm64
> I suspect the problem is something ARM specific.  IIRC, we added the
> memcpy_fromio() to work around a limitation in ARM related to CPU
> mappings of PCI BAR memory.  The whole point of the PCI shutdown
> callback is to put the device into a quiescent state (e.g., stop all
> DMAs and asynchronous engines, etc.).  Some of that tear down requires
> access to PCI BARs.
>
> Alex
>
>
>> Graphics card: r7340(amdgpu), rx550
>>
>> OS: ubuntu 2004
>>

--------------1C27D9EFA4FED9FFE32ED476
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>So, Can I remove suspend process in amdgpu_pci_shutdown if  I
      don't  use amdgpu driver in vm?</p>
    <p><span id="tran_0_0" class="">Thank you so much for</span><span>
        your </span><span id="tran_0_1" class="">reply</span><span>!</span></p>
    <div class="moz-cite-prefix">在 2021/9/30 上午5:12, Alex Deucher 写道:<br>
    </div>
    <blockquote type="cite"
cite="mid:CADnq5_MC4XPWcgT0FE5mmghZD9+YPaaAXPAkzUjFEO-hxr20Eg@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Wed, Sep 29, 2021 at 3:25 AM 李真能 <a class="moz-txt-link-rfc2396E" href="mailto:lizhenneng@kylinos.cn">&lt;lizhenneng@kylinos.cn&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Hello:

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
      <pre class="moz-quote-pre" wrap="">
I suspect the problem is something ARM specific.  IIRC, we added the
memcpy_fromio() to work around a limitation in ARM related to CPU
mappings of PCI BAR memory.  The whole point of the PCI shutdown
callback is to put the device into a quiescent state (e.g., stop all
DMAs and asynchronous engines, etc.).  Some of that tear down requires
access to PCI BARs.

Alex


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Graphics card: r7340(amdgpu), rx550

OS: ubuntu 2004

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------1C27D9EFA4FED9FFE32ED476--
