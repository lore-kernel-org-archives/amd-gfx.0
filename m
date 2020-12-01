Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787A2C64E7A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 09:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B67206C0
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 09:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxYtELr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B67206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF716E4CA;
	Tue,  1 Dec 2020 09:50:47 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 793C66E4CA
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 09:50:47 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id d17so2813571ejy.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 01:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=J6fJCdBKxrlzZMMN68vSXLHqxULdxNtNaACs6RCGgRE=;
 b=WxYtELr+xceitlky3N5hEzo/Bl9C8t6Tto8mpsE2/Z7bXetajMS4XrINnfRQIgTzKj
 bQc5KiL1UKLGwpMhJLGnNh16hCHUwtN/mrfzurazahzHDxHXr97ILILk8yCC21B9mp/o
 D+U1e3F9rmHr+xYv7RJov1UXCi5SvaHTJzH0ewhxUNC1szsT97ESO64XfwZM9lBoFJ4m
 Rnivgl5YzA2UETNJvzWL62uorewQ/GySFh82oIaAB7ZflAkAzYzHViUdsKSrj5KDE/As
 gJeRP+TT2OLalAA4tnnR0KphfJRu/s+PSo/ujJVsMS4dByKH6wjhDJkcZqD1CEE7vMbc
 sdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=J6fJCdBKxrlzZMMN68vSXLHqxULdxNtNaACs6RCGgRE=;
 b=W/ON1xVnK1XVWRVMPQUc+zfH1rroJCNJW844aOBzqqvmQIeTGjzQTMAOW6/4+x+hLn
 aRR6VDgXUN/NQVpq7HzqkvspuCQEnb7dyjxZ13kbqX7z4ft2qDEKVyOhxAhQkxo8COhB
 EsVaXVzynFLZHoMXZzbiScy40YlYR0e2RWYtp3kh07Qlk3uh0g+8mcnwbft9ITLZEgtz
 ADGS4psA8YC3ZhkGaFXzAMXXFVjQAkwPPxrSNbSQ7lUJROCPVqkHJAZ9LBgssAsKwXY/
 Uv++LxRoKgH08YVlNq3txDqj6ZziO1WHJLwEcNB/UUUtLCuEvvzafI2ZdCjpifkHIDAX
 MeIA==
X-Gm-Message-State: AOAM531/zDG74hpjWs9DGk94/8QJjXELtXLUoNzQDViVHoxfIYOqPXMY
 0zmI53vpSuvpsRJplTrBIMv+k9amjME=
X-Google-Smtp-Source: ABdhPJzBM156SSLxOE40+dPuCyi8ZxuzUUI6+wwL9b7VvC7ps+pyaUbF4HlDY45yG53khW4n5VT53A==
X-Received: by 2002:a17:907:6ea:: with SMTP id
 yh10mr1223650ejb.29.1606816245936; 
 Tue, 01 Dec 2020 01:50:45 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id d14sm548369edu.63.2020.12.01.01.50.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Dec 2020 01:50:45 -0800 (PST)
Subject: Re: [amdgpu] Is it possible to disable page tables and use the
 physical address directly in amdgpu
To: Smith John <ls.cat.kth@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CAGztBWUy6a8oB9PuF3YmqKN0DdqXixTmxThyK0+BwTMFWYtTww@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ee60c997-1c5c-cda1-74da-ed40c3ce6dcf@gmail.com>
Date: Tue, 1 Dec 2020 10:50:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGztBWUy6a8oB9PuF3YmqKN0DdqXixTmxThyK0+BwTMFWYtTww@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2057171500=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============2057171500==
Content-Type: multipart/alternative;
 boundary="------------735C0D66BDB9ABD41EC4671D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------735C0D66BDB9ABD41EC4671D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 01.12.20 um 07:58 schrieb Smith John:
> Hello!
> I was trying to figure out the impact of gpu page tables on 
> applications' performance. I noticed that there are 16 vmids supported 
> by the hardware /Vega 10/. Is it possible to use physical address 
> directly in some vmids, or use physical address globally?

No. VMID0 is used by the kernel for jobs like copying things from A to B 
and even there we use the VM remapping functionality.

Regards,
Christian.

>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------735C0D66BDB9ABD41EC4671D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 01.12.20 um 07:58 schrieb Smith
      John:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGztBWUy6a8oB9PuF3YmqKN0DdqXixTmxThyK0+BwTMFWYtTww@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">Hello!
        <div>I was trying to figure out the impact of gpu page tables on
          applications' performance. I noticed that there are 16 vmids
          supported by the hardware <i>Vega 10</i>. Is it possible to
          use physical address directly in some vmids, or use physical
          address globally?</div>
      </div>
    </blockquote>
    <br>
    No. VMID0 is used by the kernel for jobs like copying things from A
    to B and even there we use the VM remapping functionality.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAGztBWUy6a8oB9PuF3YmqKN0DdqXixTmxThyK0+BwTMFWYtTww@mail.gmail.com">
      <div dir="ltr">
        <div><br>
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

--------------735C0D66BDB9ABD41EC4671D--

--===============2057171500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2057171500==--
