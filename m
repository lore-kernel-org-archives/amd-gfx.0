Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06A1C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 13:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0F420733
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 13:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0F420733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A256E5DA;
	Fri, 15 Nov 2019 13:00:13 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A56466E5DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 13:00:12 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id n1so10859910wra.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 05:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=OJY+0WLcqlkLAI0oWPhCKoL4RqF32c1bxiYn3+VQKUE=;
 b=kkYHljyaB2emFyTx7U2j/Zg5EbgAvMmEyelsc4uua4l1QORrpgJiphuIwMyOA7Ro5s
 eQ4goGKbKHwIpX8tkrqyJZkgRjYyGUmIlpz/MhZlZlx65/qavjTszcl0sTm8kso70uzb
 jO7qB4LtgfRLays+UKi7iLoomcyDAe8XerZNmFXhtNcsFoabfBfYJQ2/yYsB634vGdoD
 7cau9A6BI4qEySjDkRU6QCgXc0o4soEaaZ8RTC+RB3AUI/k17SSAzVtnZ86TQuzBT9nA
 CWR0wPioG2faq3BebG6vh6oJfioxmwbIXCnF58LwnK/dumm1kbQdpB7NRRQojLqdnPi8
 KJ8g==
X-Gm-Message-State: APjAAAUSLuB/2zyoUmRHjl2MOk/6r32cxBSlOUqnbodpKMX49mfIEoz6
 Q6JPjMkqdJfIBViZ1SqKsjZkM3k4
X-Google-Smtp-Source: APXvYqy16GBni4ZAYQxb/VjvuaR433JlsqQ68GR2zyE+d8/fecFyhkShQB1oPL0GeTa4FbsSP+aIcw==
X-Received: by 2002:adf:f005:: with SMTP id j5mr14710909wro.295.1573822811387; 
 Fri, 15 Nov 2019 05:00:11 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e16sm321763wrj.80.2019.11.15.05.00.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Nov 2019 05:00:10 -0800 (PST)
Subject: Re: [PATCH 00/12] Initial TMZ support for libdrm and amdgpu_test
To: "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <MN2PR12MB3838F61E68479F97A65B7E6EF0700@MN2PR12MB3838.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8557eeab-5939-8c9a-1d28-f6b65b1b4b4c@gmail.com>
Date: Fri, 15 Nov 2019 14:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB3838F61E68479F97A65B7E6EF0700@MN2PR12MB3838.namprd12.prod.outlook.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=OJY+0WLcqlkLAI0oWPhCKoL4RqF32c1bxiYn3+VQKUE=;
 b=BjojkNMHVHuFsk2pOvw0X8hZf6Jc3IcXmXrk4D5Jl5h7ZQdaHPDrjN/IJwazHj2Lhb
 9BVMDWJUurmGFxDQ0LehVmBvG8klKfqPV47bQ3+Oycjz72WlNhYHbZakAn3EhLs3ucJs
 hHXGZuEydCGXOcbJoAB0+EzQwPHzsl0Gkb2Ce9MrwLwGSl6rla1qQ+ifso/8IrCNAn3L
 JrCBE6u31hWDrQ6NgpnOaUFrMM2wWLRbj3Mbv9QnMSUGQqhbRuoZp2dovusUr9S3TsPu
 2ahqv/a/6MCM+NyzOaQZ9OUrGUbtjtBfYdPoV8+E8CKyUJ8q59xUmN+g9Tzxbu0EurDJ
 H2IA==
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
Cc: "Olsak, Marek" <Marek.Olsak@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0004083816=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115130009.1XY3vbxjKXbwAbNGDgLwHmCkoI7M42r1rNW1CGSlmFw@z>

This is a multi-part message in MIME format.
--===============0004083816==
Content-Type: multipart/alternative;
 boundary="------------EE36D2F0B8E34FA4C4652FAD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EE36D2F0B8E34FA4C4652FAD
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Patches #2-#5, #8, #10-#12  are Acked-by: Christian König 
<christian.koenig@amd.com>

Patch #7 is most likely a NAK. The interface updated here is deprecated 
as far as I know.

Patch #9: How does that actually work?

Thanks,
Christian.

Am 15.11.19 um 04:34 schrieb Liu, Aaron:
>
> These series of patches are to initial TMZ support for libdrm and 
> amdgpu_test. They are based on amd-staging-hybrid-master20190125 
> branch. So far, gfx/sdma TMZ tests are passed on Raven.
>
> Please review them.
>
> Thanks,
>
> Aaron
>
> Aaron Liu (6):
>
>   amdgpu: using IB flags for TMZ or non-TMZ
>
>   tests/amdgpu: expand secure param for exec_cs_helper
>
>   tests/amdgpu: add atomic_mem cp_packet to verify the secure buffer
>
>   tests/amdgpu: add test to submit a gfx command with secure context
>
>   tests/amdgpu: add atomic dma command to verify the secure buffer
>
>   tests/amdgpu: add test to submit a sdma command with secure context
>
> Huang Rui (6):
>
>   amdgpu: add UAPI for creating encrypted buffers
>
>   tests/amdgpu: add security test suite (v2)
>
>   tests/amdgpu: add secure buffer allocation test for system memory
>
>   tests/amdgpu: add secure buffer allocation test for invisible VRAM
>
>   tests/amdgpu: expand write linear helper for security (v3)
>
>   tests/amdgpu: add device handle as input param for exec_cs_helper and
>
>     write_linear_helper (v4)
>
> amdgpu/amdgpu.h               |   4 +-
>
> amdgpu/amdgpu_cs.c            |   4 ++
>
> include/drm/amdgpu_drm.h      |   5 ++
>
> tests/amdgpu/amdgpu_test.c    |   7 ++
>
> tests/amdgpu/amdgpu_test.h    |  27 +++++++
>
> tests/amdgpu/basic_tests.c    | 161 
> ++++++++++++++++++++++++++++++++++++------
>
> tests/amdgpu/meson.build      |   2 +-
>
> tests/amdgpu/security_tests.c | 134 +++++++++++++++++++++++++++++++++++
>
> 8 files changed, 322 insertions(+), 22 deletions(-)
>
> create mode 100644 tests/amdgpu/security_tests.c
>
> BR,
>
> Aaron Liu
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------EE36D2F0B8E34FA4C4652FAD
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Patches #2-#5, #8, #10-#12  are
      Acked-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
      <br>
      Patch #7 is most likely a NAK. The interface updated here is
      deprecated as far as I know.<br>
      <br>
      Patch #9: How does that actually work?<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 15.11.19 um 04:34 schrieb Liu, Aaron:<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB3838F61E68479F97A65B7E6EF0700@MN2PR12MB3838.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoPlainText">These series of patches are to initial
          TMZ support for libdrm and amdgpu_test. They are based on
          amd-staging-hybrid-master20190125 branch. So far, gfx/sdma TMZ
          tests are passed on Raven.<o:p></o:p></p>
        <p class="MsoPlainText">Please review them.<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">Thanks,<o:p></o:p></p>
        <p class="MsoPlainText">Aaron<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Aaron Liu (6):<o:p></o:p></p>
        <p class="MsoNormal">  amdgpu: using IB flags for TMZ or non-TMZ<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: expand secure param for
          exec_cs_helper<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add atomic_mem cp_packet to
          verify the secure buffer<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add test to submit a gfx
          command with secure context<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add atomic dma command to
          verify the secure buffer<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add test to submit a sdma
          command with secure context<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Huang Rui (6):<o:p></o:p></p>
        <p class="MsoNormal">  amdgpu: add UAPI for creating encrypted
          buffers<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add security test suite
          (v2)<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add secure buffer
          allocation test for system memory<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add secure buffer
          allocation test for invisible VRAM<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: expand write linear helper
          for security (v3)<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add device handle as input
          param for exec_cs_helper and<o:p></o:p></p>
        <p class="MsoNormal">    write_linear_helper (v4)<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">amdgpu/amdgpu.h               |   4 +-<o:p></o:p></p>
        <p class="MsoNormal">amdgpu/amdgpu_cs.c            |   4 ++<o:p></o:p></p>
        <p class="MsoNormal">include/drm/amdgpu_drm.h      |   5 ++<o:p></o:p></p>
        <p class="MsoNormal">tests/amdgpu/amdgpu_test.c    |   7 ++<o:p></o:p></p>
        <p class="MsoNormal">tests/amdgpu/amdgpu_test.h    |  27 +++++++<o:p></o:p></p>
        <p class="MsoNormal">tests/amdgpu/basic_tests.c    | 161
          ++++++++++++++++++++++++++++++++++++------<o:p></o:p></p>
        <p class="MsoNormal">tests/amdgpu/meson.build      |   2 +-<o:p></o:p></p>
        <p class="MsoNormal">tests/amdgpu/security_tests.c | 134
          +++++++++++++++++++++++++++++++++++<o:p></o:p></p>
        <p class="MsoNormal">8 files changed, 322 insertions(+), 22
          deletions(-)<o:p></o:p></p>
        <p class="MsoNormal">create mode 100644
          tests/amdgpu/security_tests.c<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">BR,<o:p></o:p></p>
        <p class="MsoNormal">Aaron Liu<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
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

--------------EE36D2F0B8E34FA4C4652FAD--

--===============0004083816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0004083816==--
