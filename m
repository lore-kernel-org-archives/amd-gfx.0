Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C398FC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 20:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5852023D9A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 20:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5852023D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B352D6EB4A;
	Thu, 10 Dec 2020 20:41:55 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0029F6EB4A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 20:41:54 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id bo9so9225447ejb.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 12:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=nLUzW5XciMGBJKnlmXEPb39Jmo729IBjJBx/8uxWFms=;
 b=OdVB0MTKgupGDVinaueRnHxjipxKOVOcTx8SjcZPIGackBAfm/sTiqLg/6s+Qiu8hu
 ipAHdwIJXlWuopz6D26ubI+kdIKEkD2UVGUV+IQCnQk84iXeA5hctuYKc9bTGkgKYqVs
 WpVqAkZofWZPCD3HhiGIRpdhyNgL0KFrbSMf75vzX27A2qdRRNcr32eavz0xEY7XqCb5
 ttyaVyjrXoJ5a1K7FeaM7s531Tj3p2EVfSMoKpf2bjqYXCARaMrT11F813VUD4iKwno2
 s0IOz8i7SBGPazKd/UUiJsqURZ9RNLcOFg8twdzRvSEIdek+0fyfIwAAIB5p+yewFo1j
 33Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=nLUzW5XciMGBJKnlmXEPb39Jmo729IBjJBx/8uxWFms=;
 b=ULirBCHz7sD4JCLXSzOv+Jcs3H6SIw9YRWtYG0CUkzrJdAjZsuFsAv7V6fx8qFl7eT
 pf4lISGmShhyO1lNkc3mT9mZXpXO2So1pILBNl85XBtzdb1+JrOD8RgCXtW6PG/jA7DD
 3rt6XTJp8v8e9Wxd3Mc6ny/k+1aaaZBdkJ+SWYHSnYWFbSbCP9Q978aKqoqesUVpoVuR
 pp3IvWP37cl8XXqrDE/UhCPcLW8kY3/8mS1MPaAjelfwL7bWrpQjqDZw/0RwFfcoMR9X
 IYcxnxRRftx4Oe6nD0ZksYiOEQYD7tPy5Eq1lNeIBPEhsjK27IfbR7mypk5UMkVMbrfd
 aPlw==
X-Gm-Message-State: AOAM530C06lQ1xa42Th5sj8ENCEWu1kfhFK+x2l+see6mzp7tQ2sg9v2
 zMyL0L2zr02ab5xiZfbKe4Y=
X-Google-Smtp-Source: ABdhPJzCcjJiWzDWEV27TLLe34B0LykZxw+0hDwsOPW+cfDg5UCZUfIdSyhvSowoK60CpjfhbJDMNg==
X-Received: by 2002:a17:906:7a18:: with SMTP id
 d24mr8125038ejo.324.1607632913541; 
 Thu, 10 Dec 2020 12:41:53 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e3sm5130496ejq.96.2020.12.10.12.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Dec 2020 12:41:52 -0800 (PST)
Subject: Re: [PATCH] amdgpu: resize BAR0 to the maximum available size, even
 if it doesn't cover VRAM
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 Darren Salt <devspam@moreofthesa.me.uk>
References: <20201210005744.5877-1-devspam@moreofthesa.me.uk>
 <621ae252-ab39-383e-61a9-746fb47c6e01@gmail.com>
 <58E21FF244%devspam@moreofthesa.me.uk>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9d3cee7f-366e-4e7e-9f63-b0a51af7436c@gmail.com>
Date: Thu, 10 Dec 2020 21:41:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <58E21FF244%devspam@moreofthesa.me.uk>
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
Content-Type: multipart/mixed; boundary="===============1321937519=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1321937519==
Content-Type: multipart/alternative;
 boundary="------------9ECA8344B9CECD376A11F46D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9ECA8344B9CECD376A11F46D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.12.20 um 14:59 schrieb Darren Salt:
> I demand that Christian König may or may not have written...
>
>> Am 10.12.20 um 01:57 schrieb Darren Salt:
>>> This allows BAR0 resizing to be done for cards which don't advertise
>>> support for a size large enough to cover the VRAM but which do advertise
>>> at least one size larger than the default. For example, my RX 5600 XT,
>>> which advertises 256MB, 512MB and 1GB.
>> I've never seen such a configuration except for engineering samples. Can
>> you send me a dump of the relevant PCI configuration space?
> “lspci -nn -v -xxxx” output is attached. (Sapphire RX 5600 XT Pulse; not an
> early one.)

Thanks. Going to double check tomorrow.

>
> My current kernel has another patch, applied on top of this patch, which
> allows ignoring the size list. As such, that BAR is currently 8GB instead of
> the 1GB which it should be. I've not noticed any significant problems as yet.

Please grab umr, take a look at the amdgpu_vram_mm debugfs file and see 
if you can get some bytes from a buffer at the end of VRAM.

If that doesn't return 0x0 or 0xffffffff then it is probably working 
quite fine.

> If the card should be advertising larger sizes too then its VBIOS needs
> fixing; but as a lot of these already out there won't get that fix, some sort
> of override (quirk, I expect, with a module option for cards not covered)
> would, I think, be warranted.

I'm really wondering what the heck is going on here. I've heard from 
boards which don't have resizeable BARs, but that there should be an 
artificial 1GB limit sounds strongly like a VBIOS bug to me.

Anyway I agree that a PCI subsystem quirk might be appropriated.

>> In general we could do this, but instead of just blindly trying
>> different values we should just pick a supported one in the first place.
> By using pci_rebar_get_possible_sizes() etc.? That looks reasonable to me.

Yes, exactly.

> It'll also require some patching in the PCI subsystem to expose relevant
> functions.

Just send that to me as a complete and clean patchset.

I'm the one who added the code in the first place and I have no problem 
arguing with Bjorn why we need that in a driver now.

Thanks,
Christian.

>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------9ECA8344B9CECD376A11F46D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 10.12.20 um 14:59 schrieb Darren
      Salt:<br>
    </div>
    <blockquote type="cite"
      cite="mid:58E21FF244%25devspam@moreofthesa.me.uk">
      <pre class="moz-quote-pre" wrap="">I demand that Christian König may or may not have written...

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Am 10.12.20 um 01:57 schrieb Darren Salt:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">This allows BAR0 resizing to be done for cards which don't advertise
support for a size large enough to cover the VRAM but which do advertise
at least one size larger than the default. For example, my RX 5600 XT,
which advertises 256MB, 512MB and 1GB.
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">I've never seen such a configuration except for engineering samples. Can
you send me a dump of the relevant PCI configuration space?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
“lspci -nn -v -xxxx” output is attached. (Sapphire RX 5600 XT Pulse; not an
early one.)</pre>
    </blockquote>
    <br>
    Thanks. Going to double check tomorrow.<br>
    <br>
    <blockquote type="cite"
      cite="mid:58E21FF244%25devspam@moreofthesa.me.uk">
      <pre class="moz-quote-pre" wrap="">

My current kernel has another patch, applied on top of this patch, which
allows ignoring the size list. As such, that BAR is currently 8GB instead of
the 1GB which it should be. I've not noticed any significant problems as yet.</pre>
    </blockquote>
    <br>
    Please grab umr, take a look at the amdgpu_vram_mm debugfs file and
    see if you can get some bytes from a buffer at the end of VRAM.<br>
    <br>
    If that doesn't return 0x0 or 0xffffffff then it is probably working
    quite fine.<br>
    <br>
    <blockquote type="cite"
      cite="mid:58E21FF244%25devspam@moreofthesa.me.uk">
      <pre class="moz-quote-pre" wrap="">If the card should be advertising larger sizes too then its VBIOS needs
fixing; but as a lot of these already out there won't get that fix, some sort
of override (quirk, I expect, with a module option for cards not covered)
would, I think, be warranted.</pre>
    </blockquote>
    <br>
    I'm really wondering what the heck is going on here. I've heard from
    boards which don't have resizeable BARs, but that there should be an
    artificial 1GB limit sounds strongly like a VBIOS bug to me.<br>
    <br>
    Anyway I agree that a PCI subsystem quirk might be appropriated.<br>
    <br>
    <blockquote type="cite"
      cite="mid:58E21FF244%25devspam@moreofthesa.me.uk">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">In general we could do this, but instead of just blindly trying 
different values we should just pick a supported one in the first place.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
By using pci_rebar_get_possible_sizes() etc.? That looks reasonable to me.</pre>
    </blockquote>
    <br>
    Yes, exactly.<br>
    <br>
    <blockquote type="cite"
      cite="mid:58E21FF244%25devspam@moreofthesa.me.uk">
      <pre class="moz-quote-pre" wrap="">It'll also require some patching in the PCI subsystem to expose relevant
functions.</pre>
    </blockquote>
    <br>
    Just send that to me as a complete and clean patchset.<br>
    <br>
    I'm the one who added the code in the first place and I have no
    problem arguing with Bjorn why we need that in a driver now.<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:58E21FF244%25devspam@moreofthesa.me.uk">
      <pre class="moz-quote-pre" wrap="">

</pre>
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

--------------9ECA8344B9CECD376A11F46D--

--===============1321937519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1321937519==--
