Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C795C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 16:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6082D20CC7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 16:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+2SCA1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6082D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217836E0CF;
	Tue, 28 Jan 2020 16:22:45 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378226E0CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 16:22:44 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id k11so2042090wrd.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 08:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=P3epVrj2BsnGrQ1aqY3WAwZz6tHvjIp1+Sl7R5rXVG4=;
 b=H+2SCA1ZSx5Li7jyMSqeYYBXU4fis3FxjWnLexJzDrbE2723t4/Cga1ILiwjkivzmg
 RZWw2kxfxoEFc883bfj1NeKU8rKPH3od+Mzig4PEbKLtztPLQBgo4g/IZLNZ95GFGJ7N
 l41TK/sazFZxQDZZDOI7kSk0qOWV1ZdFEFk51oUWDPU4k589IB3sccegIxgcLHbp4Oyx
 dyX4AkCVBCPXUv7GjR2mJcQcdyiWJmnxZrLUlt9NTy5yuxI0U7WLu0kgjeoUYUjzEqYl
 FsJ8HFgFgouKvEKN7hj7Uv9l7z5do8CCzN4H08wabbYN+s/b2EqlCiQjKLIAgHl2CXL6
 gCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=P3epVrj2BsnGrQ1aqY3WAwZz6tHvjIp1+Sl7R5rXVG4=;
 b=IRz3A9phQN7NYZ5R9vgf9UgDALesm/ooPfO3CD+O8K4+7v39pJf33YpmSEMCOzvnKe
 H9H+9xuT5KYRNx/hbKZsRTset8NW6dN9pxgk6ERatgXs3fhYFgXEmKM4SLJkxR6fWgK2
 IAcl1NuIf9axY9Sv4at9iuCwEssWOpPOukUT2GsIeliWhsNNHLG8lE1aJRAcj4puuouv
 uq/u6V8Uytg8/v0SPEY9Y2zuwL4CtzcQEJul/l64oHWMJbF/QPB8F9okHSCj6Bm4p4gk
 ZgY68nLayyYJeVUxbpEbf3M71Y7jHL2RpiuIzHQZzqaNeF/Fd1pYEeCOpEabvpeMJilH
 A2nQ==
X-Gm-Message-State: APjAAAWGZ5+KxuuoWHrxTweRSfj+LN/jpmapa+vydYr+rbMIz1INRSUn
 oxKLRHFbkfrZcbXey0ouJpprOWoz
X-Google-Smtp-Source: APXvYqy72z9NbXXlnB2GmCVROSreIdZvlE2FVKKGvSdLSPGsAdsiam7n+vM7HrFF15JlOWB41Elhtg==
X-Received: by 2002:a5d:4749:: with SMTP id o9mr28926239wrs.242.1580228559237; 
 Tue, 28 Jan 2020 08:22:39 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u1sm3545196wmc.5.2020.01.28.08.22.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Jan 2020 08:22:34 -0800 (PST)
Subject: Re: [PATCH] drm/radeon: avoid page fault during gpu reset
To: Andreas Messer <andi@bastelmap.de>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <e034c038-f7a5-4bb0-8ec8-2f1a4d089436@email.android.com>
 <20200128131518.GB12260@zeus.ad.home.arpa>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d566cd7a-d1dc-98c0-88a7-8ca5021e00d3@gmail.com>
Date: Tue, 28 Jan 2020 17:22:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128131518.GB12260@zeus.ad.home.arpa>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1444296627=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1444296627==
Content-Type: multipart/alternative;
 boundary="------------11E1BB4FFA902F0F5A55DF38"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------11E1BB4FFA902F0F5A55DF38
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.01.20 um 14:15 schrieb Andreas Messer:
> On Sat, Jan 25, 2020 at 07:01:36PM +0000, Koenig, Christian wrote:
>>
>> Am 25.01.2020 19:47 schrieb Andreas Messer <andi@bastelmap.de>:
>> When backing up a ring, validate pointer to avoid page fault.
>> [ cut description / kernel messages ]
>>
>> NAK, that was suggested multiple times now and is essentially the wrong
>> approach.
>>
>> The problem is that the value is invalid because the hardware is not
>> functional any more. Returning here without backing up the ring just
>> papers over the real problem.
>>
>> This is just the first occurance of this and you would need to fix a
>> couple of hundred register accesses (both inside and outside of the
>> driver) to make that really work reliable.
> Sure, it wont fix the hardware. But since the page fault is most prominent
> part in kernel log, people will continue suggesting it. With that change,
> the kernel messages are full of ring and atom bios timeouts and might make
> users more likely to consider a hardware issue in the first place.

That is correct, but the problem is that we currently have 2209 places 
where we read a register and usually expect that the values to be in a 
valid range.

If you really want to avoid all crashes you would need to audit and fix 
all occurrences where for example the register value is used as index in 
an array or similar.

And the radeon code is only the beginning, the whole PCIe subsystem 
would need an audit in a similar way. That is a huge lot of work we are 
not willing to do.

>   Anyway:
>
>> The only advice I can give you is to replace the hardware. From
>> experience those symptoms mean that your GPU will die rather soon.
> I think my hardware is fine. I have monitored gpu temp and fan pwm now for
> a while and found the pwm to be driven at ~60% only although the gpu
> already got quite high temperature during gameplay. When forcing the pwm
> to ~80% no crash occurs anymore. I suppose it is not the GPU crashing but
> instead the VRMs, not getting enough airflow.
>
> I have compared the Bios fan tables of my card with them of other cards
> bios (downloaded from web) of same GPU type and similar design.
> Although they differ in cooler construction and used fan, all of them
> despite one model have exactly the same fan regulation points with PWMHigh
> at 80% for 90°C. This single model with other settings has 100% for this
> temp and generally much more sane looking regulation curve.
>
> I suppose most of the vendors just copied some reference design,
> maybe the vendor's windows driver adjust the curve to a better one,
> I don't know.
>
> I think I'll add some sysfs attributes or module parameter to adjust
> the curve to my needs.

The issue is that this is most likely not a temperature problem at all. 
If you have a temperature problem the ASIC usually just hangs in a 
shader or so, but the BIF is still fully functional (e.g. you can probe 
PCI-IDs etc...).

That looks more like the ESD protection is kicking in for some reason. 
In other words what you got here is a cold/broken solder point on the 
SMD components which happens to loose contact because the material 
expands when it warms up.

That is a serious hardware fault and a really good indicator that you 
should replace the faulty component ASAP.

Regards,
Christian.

>
>> [ Patch cut out ]
> cheers,
> Andreas
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------11E1BB4FFA902F0F5A55DF38
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 28.01.20 um 14:15 schrieb Andreas
      Messer:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20200128131518.GB12260@zeus.ad.home.arpa">
      <pre class="moz-quote-pre" wrap="">On Sat, Jan 25, 2020 at 07:01:36PM +0000, Koenig, Christian wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

Am 25.01.2020 19:47 schrieb Andreas Messer <a class="moz-txt-link-rfc2396E" href="mailto:andi@bastelmap.de">&lt;andi@bastelmap.de&gt;</a>:
When backing up a ring, validate pointer to avoid page fault.
[ cut description / kernel messages ] 

NAK, that was suggested multiple times now and is essentially the wrong
approach.

The problem is that the value is invalid because the hardware is not
functional any more. Returning here without backing up the ring just
papers over the real problem.

This is just the first occurance of this and you would need to fix a
couple of hundred register accesses (both inside and outside of the
driver) to make that really work reliable.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Sure, it wont fix the hardware. But since the page fault is most prominent
part in kernel log, people will continue suggesting it. With that change,
the kernel messages are full of ring and atom bios timeouts and might make
users more likely to consider a hardware issue in the first place.</pre>
    </blockquote>
    <br>
    That is correct, but the problem is that we currently have 2209
    places where we read a register and usually expect that the values
    to be in a valid range.<br>
    <br>
    If you really want to avoid all crashes you would need to audit and
    fix all occurrences where for example the register value is used as
    index in an array or similar.<br>
    <br>
    And the radeon code is only the beginning, the whole PCIe subsystem
    would need an audit in a similar way. That is a huge lot of work we
    are not willing to do.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20200128131518.GB12260@zeus.ad.home.arpa">
      <pre class="moz-quote-pre" wrap=""> Anyway:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The only advice I can give you is to replace the hardware. From
experience those symptoms mean that your GPU will die rather soon.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think my hardware is fine. I have monitored gpu temp and fan pwm now for
a while and found the pwm to be driven at ~60% only although the gpu
already got quite high temperature during gameplay. When forcing the pwm
to ~80% no crash occurs anymore. I suppose it is not the GPU crashing but
instead the VRMs, not getting enough airflow.

I have compared the Bios fan tables of my card with them of other cards
bios (downloaded from web) of same GPU type and similar design.
Although they differ in cooler construction and used fan, all of them
despite one model have exactly the same fan regulation points with PWMHigh
at 80% for 90°C. This single model with other settings has 100% for this
temp and generally much more sane looking regulation curve.

I suppose most of the vendors just copied some reference design,
maybe the vendor's windows driver adjust the curve to a better one,
I don't know.

I think I'll add some sysfs attributes or module parameter to adjust 
the curve to my needs.</pre>
    </blockquote>
    <br>
    The issue is that this is most likely not a temperature problem at
    all. If you have a temperature problem the ASIC usually just hangs
    in a shader or so, but the BIF is still fully functional (e.g. you
    can probe PCI-IDs etc...).<br>
    <br>
    That looks more like the ESD protection is kicking in for some
    reason. In other words what you got here is a cold/broken solder
    point on the SMD components which happens to loose contact because
    the material expands when it warms up.<br>
    <br>
    That is a serious hardware fault and a really good indicator that
    you should replace the faulty component ASAP.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20200128131518.GB12260@zeus.ad.home.arpa">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">[ Patch cut out ]
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
cheers,
Andreas


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

--------------11E1BB4FFA902F0F5A55DF38--

--===============1444296627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1444296627==--
