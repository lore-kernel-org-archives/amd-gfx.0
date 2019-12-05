Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D6C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 15:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3C1224F8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 15:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3C1224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386236E13F;
	Thu,  5 Dec 2019 15:19:26 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952066E140
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 15:19:25 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id q10so4050548wrm.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2019 07:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=pLbA/0RfVG8kZCGP2JK9tSHS3m8TtiQil6crs+FqoL8=;
 b=j/KTs7OrcbYBERKX6YW+PUJp82P6dNKxqCnMNWlvLxIEF/vCUESfACxlY2bOgBJS1C
 8vrQ9NcpMj/P03cR4ItjDPIvDK+dqgwjO2/DGEJfCewurUihdlxQKjbat0rHuKXE4oGH
 sWOa/CktrZ3vjOx6iacDA2X9CsDRz9xLZJ/OiIiZhPI0GkI/NGzfngG6bGs2zF0i3xbV
 PJ6sbhxClUGCpORTrg0JzIsM9nXQTG+3JgVnVTS2ksZrrhVSlAeRTTmbIOw6Q/TXI41q
 70YEOx7uzNmmmkedTnbVTuVaWCkBwq2DRrl1ZbQNq7hEs0Ixx1f/vWL+d0CRD1TNNNHm
 1yRQ==
X-Gm-Message-State: APjAAAWKY7UTJg50O/hYMZ4+HjWeoGQUhsblp+f4ghPUOwMYQWyyWyGT
 g0Om6VjjcMyt33+hb/xZUfMv3j7H
X-Google-Smtp-Source: APXvYqwsj9YgapV22rmZ9vGxhku3jNXMrNs7WlFCzZcMZ7xG1rFB2Rf1isA1XGu39NGXatnpU0FAxg==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr10849183wrr.226.1575559164100; 
 Thu, 05 Dec 2019 07:19:24 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s25sm158445wmh.4.2019.12.05.07.19.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Dec 2019 07:19:23 -0800 (PST)
Subject: Re: [RFC 0/7] UVD support for SI in amdgpu
To: Matthew Taylor <mat@sharrow.me.uk>, amd-gfx@lists.freedesktop.org
References: <CAJ0uJC1kxmAdwjRGMf8ZHospNz5sO1jV1E0E1_tsBZCrDVK=ag@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5f0ba91c-3234-9d27-cda9-af22ac781436@gmail.com>
Date: Thu, 5 Dec 2019 16:19:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJ0uJC1kxmAdwjRGMf8ZHospNz5sO1jV1E0E1_tsBZCrDVK=ag@mail.gmail.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=pLbA/0RfVG8kZCGP2JK9tSHS3m8TtiQil6crs+FqoL8=;
 b=ktrlOdJh9XXILbbLYbuzqf6lfJMPpD8SuiZqdpv2ueKdMUUUbi/Y8IeiEBUM4BhjUZ
 3tUDGdw/BNASLRpYbaW3mFwklXKuIuC0UlZIQzGjOnwcxpCydjYgml1BF7Lp5aulOhyW
 Cmij0G8HClKK5YGtq4U++v5ysl1CsHMDMOBEwr4jktg4Ly+20VWQAozgUyQMSQAt3Hmj
 LeZR/fEX2vpSa/qEVwu+iv1vxUr/Ne6gzG66csUqGfW1NnfXeWnlebPfCRibGVFPDqKj
 AxLbFey2m+R5GQ4CYUZNbhINkZ20gffStN/wNW+lQF3tgoMvsQK/EvAdbbCXk+Ncv1Hp
 3Fuw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Content-Type: multipart/mixed; boundary="===============1957648747=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1957648747==
Content-Type: multipart/alternative;
 boundary="------------66CE73D7C1A4D3010DDAB562"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------66CE73D7C1A4D3010DDAB562
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Matthew,

Am 05.12.19 um 15:16 schrieb Matthew Taylor:
> Hi,
>
> Back in November 2017, Piotr Redlewski, provided some patches for UVD 
> support in the SI cards, the thread had the same subject as this message.
>
> The outcome of a conversation between himself and other developers on 
> the list was to wait for something in updated firmware.  As this was 
> over 2 years ago, I was wondering if the firmware has been updated 
> sufficiently for Piotr's patches to be reconsidered or modified to 
> deliver the UVD support for the SI cards?

we discussed that internally quite lengthy and the firmware will 
probably never be released.

To be honest we actually considering dropping SI support completely from 
amdgpu.

Regards,
Christian.

>
> Thanks for you help
>
> Kind Regards
>
> Matthew Taylor
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------66CE73D7C1A4D3010DDAB562
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Matthew,<br>
      <br>
      Am 05.12.19 um 15:16 schrieb Matthew Taylor:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJ0uJC1kxmAdwjRGMf8ZHospNz5sO1jV1E0E1_tsBZCrDVK=ag@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">Hi,
        <div><br>
        </div>
        <div>Back in November 2017, Piotr Redlewski, provided some
          patches for UVD support in the SI cards, the thread had the
          same subject as this message.  <br>
          <br>
          The outcome of a conversation between himself and other
          developers on the list was to wait for something in updated
          firmware.  As this was over 2 years ago, I was wondering if
          the firmware has been updated sufficiently for Piotr's patches
          to be reconsidered or modified to deliver the UVD support for
          the SI cards?</div>
      </div>
    </blockquote>
    <br>
    we discussed that internally quite lengthy and the firmware will
    probably never be released.<br>
    <br>
    To be honest we actually considering dropping SI support completely
    from amdgpu.<br>
    <br>
    Regards,<br>
    Christian. <br>
    <br>
    <blockquote type="cite"
cite="mid:CAJ0uJC1kxmAdwjRGMf8ZHospNz5sO1jV1E0E1_tsBZCrDVK=ag@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div>Thanks for you help</div>
        <div><br>
        </div>
        <div>Kind Regards</div>
        <div><br>
        </div>
        <div>Matthew Taylor</div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------66CE73D7C1A4D3010DDAB562--

--===============1957648747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1957648747==--
