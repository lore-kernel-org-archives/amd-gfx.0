Return-Path: <SRS0=G9GP=6J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065BCC54FCB
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Apr 2020 15:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC04020748
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Apr 2020 15:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJfG7Gmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC04020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A7C6E29E;
	Sat, 25 Apr 2020 15:04:24 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50AD6E29E
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2020 15:04:23 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id i10so15047909wrv.10
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Apr 2020 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=vaTNktVVlFcl/Th+vHWmug28dgFqyOgRJF3p2rqBaaQ=;
 b=tJfG7GmrCpdOZekL/adfY0fxkfWvWHzZ+2caHwUFls04ANgBbR7vTh4eduSZnYqb//
 mB4P6kuwRpJsnIKHKEyHOLBqjSiUYk5Kt/ntOdn+EolIwjOMM3l1GgbG7+H+tVueQabD
 511lMk/uvaoe1HKAnLlDJYdaTUpZT9Umauk2VtUWPehTYIZ6ArllOwNtaqVS+YB+W/AP
 OJEl0gDjU6r0JqzL+NPVtbix/v+Wv0bemoKta3xzAFweFyD9S+LldZTyDnFuv+NxfQch
 fK61UgaouH+laWwZ+aNhqcVBIKZ2f7jcGPzUKP6jDaRCHk4SN4iuhiE4jRmGgBBRE/xy
 Bm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=vaTNktVVlFcl/Th+vHWmug28dgFqyOgRJF3p2rqBaaQ=;
 b=CfB2DusYT7KENYnAJiNttwB0QLpBbN+O5C4S0FwQnLKDu+bxXgMBVGPBxU6MPidkxC
 bPgsb/oDga0U+UrNiFzDBarlll80Xd4BnYipF2VVnTPIzlZg321WmOxVcYGiy4WiOKDe
 8A1BxTK16RxWgRX7nMTgUUY9jjm2L5CwvdcDYeBM5Q7bxLmx0LmqFZ6n3RCupDD19PIF
 7KGmqz9ALc3j9fJw0iitv2BQpgKiggP0XQdpk4BXCuLLDeUZt/kLtcYXwNdWE302PPgo
 wgoVizMORk54ltML9Wil9kNEndxF7Vqwi8HNggmxKLmd2TThG40haLkxt31JI5TDjm/X
 w+nQ==
X-Gm-Message-State: AGi0PuZ92/Rg4GRK0+1NJhc9IXoMqDtYSkK4WWtXVxNVyZw+AVYpO5do
 szWiWvXuTdhxANTqsdaORb95AEBh
X-Google-Smtp-Source: APiQypI9SeT8aba8pdRHhK40KGU3/FU46rjVQzxqgwUARRs8OWKPK+gS/mkvTHlMN5ZkW47VxAdoKA==
X-Received: by 2002:adf:9d83:: with SMTP id p3mr17945109wre.142.1587827062460; 
 Sat, 25 Apr 2020 08:04:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j17sm14235891wrb.46.2020.04.25.08.04.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 25 Apr 2020 08:04:21 -0700 (PDT)
Subject: Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <71c2f3e9-a734-5887-b5ce-7fa8b011d372@gmail.com>
Date: Sat, 25 Apr 2020 17:04:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1512808671=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1512808671==
Content-Type: multipart/alternative;
 boundary="------------B95B89DB079BE518F3F499C0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B95B89DB079BE518F3F499C0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Could we do this in userspace as well?

Am 25.04.20 um 10:52 schrieb Marek Olšák:
> This should fix SDMA hangs on gfx10.
>
> Marek
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------B95B89DB079BE518F3F499C0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Could we do this in userspace as well?<br>
      <br>
      Am 25.04.20 um 10:52 schrieb Marek Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>This should fix SDMA hangs on gfx10.<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
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

--------------B95B89DB079BE518F3F499C0--

--===============1512808671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1512808671==--
