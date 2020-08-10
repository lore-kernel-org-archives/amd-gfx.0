Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F1FC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 11:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8268F206C3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 11:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKlzdkx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8268F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234CE6E40C;
	Mon, 10 Aug 2020 11:46:34 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8669D6E40C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 11:46:33 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id y3so7860505wrl.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=8tBQ/H4B7m8AEgGi6sRikSTS28rrLFDj5DljMgd6eqM=;
 b=rKlzdkx8vLloH/mel4m7qHaq+roVzRGFEX0921CUyb9qSHWRh8Cxmw03CJ8zQi09+q
 BvRVWNF8kGUAifPcKJYF7hUjjfF7SFs6987DpImkSkWRcxVmEUz1rkgt0Lwpz+3pZTJ2
 b/TyfFk8oswqdwXFrrRPYXZQfgVX7Ndb0MbVq7Dnt3Hz1cQpHEyYqRqlkqmDKwB5pqjr
 WeqNga27aG1BpxOnbiLMv8K7yUCJrvkvuFu1pyeXhTI1uOvGISH/ay7U3st9Lv1P8z7I
 SuUeKJg4A/MAejaxAjg7fk9vfUCcKp5aZ1hnJExsbIy70+s1GutquyNQPoBQfowctsyb
 b3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=8tBQ/H4B7m8AEgGi6sRikSTS28rrLFDj5DljMgd6eqM=;
 b=JbTQkKpuf9MpAAcqKGOIV6kq+dY9bz8dgIYq2Th5ZuGe1SqpuiqKCu1Bc9vjrCR8HC
 Pot7epDYo7rpuL6soZ8+kyZFWDMS/QXwYtphrIy3KvMh8KMU3ezmPbRgCNmvl0/5KHQl
 o/y2TBPlnLFCCGJbBSBwfpyLwPo/mI3pGEY6h4M/7E+EwpM2PjIuqgKHTsGPFLKaUJuC
 sJ9Wv84Vwhp3Qh7rO5V72rPi2VNZ/bkOG/dDcx3X3IBYUmnMWa5Xk+EsQdVYUGSYScN+
 ZkiWsRRd3dTBs2fsN5vK0TediHASAqxYn5xnokMoXEsEoDhd/OFbFOCMYK7jn3eA+MIV
 zx0A==
X-Gm-Message-State: AOAM533T2kE+7sXhxp7qB3+Etp88o2U9pU2NNC29RhcR6b2KQE8YTyqQ
 yJoTnFGSszhCFG7TtAgpYwoEXhVU
X-Google-Smtp-Source: ABdhPJwAM4rkq8LDnKJODEUYtu9IdP/1ZwoxxwMWtRck8s2tsFxnDZNZpZLCl60F409c3e3MpoeG7g==
X-Received: by 2002:a5d:550e:: with SMTP id b14mr25924046wrv.392.1597059991957; 
 Mon, 10 Aug 2020 04:46:31 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z207sm22094306wmc.2.2020.08.10.04.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 04:46:31 -0700 (PDT)
Subject: Re: Non-deterministically boot into dark screen with `amdgpu`
To: Alexander Monakov <amonakov@ispras.ru>, Ignat Insarov <kindaro@gmail.com>
References: <CAB-2Q08KQmS0D06k1QEUpccybGqCY+HYaZkF=sY0t1EX8Y_u2Q@mail.gmail.com>
 <alpine.LNX.2.20.13.2008100928010.2454@monopod.intra.ispras.ru>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3f687bb2-d5c0-d538-53f4-af2b444bb1b6@gmail.com>
Date: Mon, 10 Aug 2020 13:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2008100928010.2454@monopod.intra.ispras.ru>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0512288257=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0512288257==
Content-Type: multipart/alternative;
 boundary="------------1BCC1FCDA49B0DBFB1EF4C0B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1BCC1FCDA49B0DBFB1EF4C0B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi guys,

Am 10.08.20 um 08:43 schrieb Alexander Monakov:
> Hi,
>
> you should Сс a specialized mailing list and a relevant maintainer,
> otherwise your email is likely to be ignored as LKML is an incredibly
> high-volume list. Adding amd-gfx and Alex Deucher.

Thanks for forwarding this. AFAIK we haven't heard of this bug before, 
but Alex already might know more about it.

> More thoughts below.
>
> On Sun, 9 Aug 2020, Ignat Insarov wrote:
>
>> Hello!
>>
>> This is an issue report. I am not familiar with the Linux kernel
>> development procedure, so please direct me to a more appropriate or
>> specialized medium if this is not the right avenue.
>>
>> My laptop (Ryzen 7 Pro CPU/GPU) boots into dark screen more often than
>> not. Screen blackness correlates with a line in the `systemd` journal
>> that says `RAM width Nbits DDR4`, where N is either 128 (resulting in
>> dark screen) or 64 (resulting in a healthy boot). The number seems to
>> be chosen at random with bias towards 128. This has been going on for
>> a while so here is some statistics:
>>
>> * 356 boots proceed far enough to  attempt mode setting.
>> * 82 boots set RAM width to 64 bits and presumably succeed.
>> * 274 boots set RAM width to 128 bits and presumably fail.
>>
>> The issue is prevented with the `nomodeset` kernel option.
>>
>> I reported this previously (about a year ago) on the forum of my Linux
>> distribution.[1] The issue still persists as of  linux 5.8.0.
>>
>> The details of my graphics controller, as well as some journal
>> excerpts, can be seen at [1]. One thing that has changed since then is
>> that on failure, there now appears a null pointer dereference error. I
>> am attaching the log of kernel messages from the most recent failed
>> boot — please request more information if needed.
>>
>> I appreciate any directions and advice as to how I may go about fixing
>> this annoyance.
>>
>> [1]: https://bbs.archlinux.org/viewtopic.php?id=248273
>
> On the forum you show that in the "success" case there's one less "BIOS
> signature incorrect" message. This implies that amdgpu_get_bios() in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> gets the video BIOS from a different source. If that happens every time
> (one "signature incorrect" message for "success", two for "failure")
> that may be relevant to the problem you're experiencing.
>
> If you don't mind patching and rebuilding the kernel I suggest adding
> debug printks to the aforementioned function to see exactly which methods
> fail with wrong signature and which succeeds.
>
> Also might be worthwhile to check if there's a BIOS update for your laptop.

It might also be a good idea to try the latest amd-staging-drm-next 
branch from Alex repository (bear with me I don't have the link at hand, 
but it should be easy to find).

Opening a bug report or searching the existing ones for something 
similar under https://gitlab.freedesktop.org/drm/amd/-/issues might be a 
good idea as well.

And I completely agree that this sounds like an issue getting the BIOS 
image.

Thanks,
Christian.

>
> Alexander
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------1BCC1FCDA49B0DBFB1EF4C0B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi guys,<br>
      <br>
      Am 10.08.20 um 08:43 schrieb Alexander Monakov:<br>
    </div>
    <blockquote type="cite"
      cite="mid:alpine.LNX.2.20.13.2008100928010.2454@monopod.intra.ispras.ru">
      <pre class="moz-quote-pre" wrap="">Hi,

you should Сс a specialized mailing list and a relevant maintainer,
otherwise your email is likely to be ignored as LKML is an incredibly
high-volume list. Adding amd-gfx and Alex Deucher.</pre>
    </blockquote>
    <br>
    Thanks for forwarding this. AFAIK we haven't heard of this bug
    before, but Alex already might know more about it.<br>
    <br>
    <blockquote type="cite"
      cite="mid:alpine.LNX.2.20.13.2008100928010.2454@monopod.intra.ispras.ru">
      <pre class="moz-quote-pre" wrap="">More thoughts below.

On Sun, 9 Aug 2020, Ignat Insarov wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hello!

This is an issue report. I am not familiar with the Linux kernel
development procedure, so please direct me to a more appropriate or
specialized medium if this is not the right avenue.

My laptop (Ryzen 7 Pro CPU/GPU) boots into dark screen more often than
not. Screen blackness correlates with a line in the `systemd` journal
that says `RAM width Nbits DDR4`, where N is either 128 (resulting in
dark screen) or 64 (resulting in a healthy boot). The number seems to
be chosen at random with bias towards 128. This has been going on for
a while so here is some statistics:

* 356 boots proceed far enough to  attempt mode setting.
* 82 boots set RAM width to 64 bits and presumably succeed.
* 274 boots set RAM width to 128 bits and presumably fail.

The issue is prevented with the `nomodeset` kernel option.

I reported this previously (about a year ago) on the forum of my Linux
distribution.[1] The issue still persists as of  linux 5.8.0.

The details of my graphics controller, as well as some journal
excerpts, can be seen at [1]. One thing that has changed since then is
that on failure, there now appears a null pointer dereference error. I
am attaching the log of kernel messages from the most recent failed
boot — please request more information if needed.

I appreciate any directions and advice as to how I may go about fixing
this annoyance.

[1]: <a class="moz-txt-link-freetext" href="https://bbs.archlinux.org/viewtopic.php?id=248273">https://bbs.archlinux.org/viewtopic.php?id=248273</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

On the forum you show that in the "success" case there's one less "BIOS
signature incorrect" message. This implies that amdgpu_get_bios() in
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c</a>
gets the video BIOS from a different source. If that happens every time
(one "signature incorrect" message for "success", two for "failure")
that may be relevant to the problem you're experiencing.

If you don't mind patching and rebuilding the kernel I suggest adding
debug printks to the aforementioned function to see exactly which methods
fail with wrong signature and which succeeds.

Also might be worthwhile to check if there's a BIOS update for your laptop.</pre>
    </blockquote>
    <br>
    It might also be a good idea to try the latest amd-staging-drm-next
    branch from Alex repository (bear with me I don't have the link at
    hand, but it should be easy to find).<br>
    <br>
    Opening a bug report or searching the existing ones for something
    similar under <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues">https://gitlab.freedesktop.org/drm/amd/-/issues</a> might
    be a good idea as well.<br>
    <br>
    And I completely agree that this sounds like an issue getting the
    BIOS image.<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:alpine.LNX.2.20.13.2008100928010.2454@monopod.intra.ispras.ru">
      <pre class="moz-quote-pre" wrap="">

Alexander</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------1BCC1FCDA49B0DBFB1EF4C0B--

--===============0512288257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0512288257==--
