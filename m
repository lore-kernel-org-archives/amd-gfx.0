Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCAFC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 07:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD7D207ED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 07:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTXx/P9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD7D207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E784B89F01;
	Wed, 10 Jun 2020 07:41:52 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DDAE89F01
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 07:41:51 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id p5so1049778wrw.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=nsa5MFk3KLG7XhhgPmi3zOip7pCozd4o4Sfn09UF7AY=;
 b=fTXx/P9RzzBrfLLR5RRYjQfqcdPPBWOPa4zyjkOATyNCHQTewUrhWQ+P0AHKGezuJw
 8KQz48IljdBexvx7P+CrKBPzDQLNxWJR2wpt8L+pkMwDZR2wMIxLfZSqff7QkOzf7vt/
 409OPqc65Y2OyqzrcQtHyXijQnnp+a6kJsUOUOniOEmIXlRcH7U0g9ZH22/NFPMaFlic
 Qg1vvOcuekp3a77V93HeU0Bs98PyBbPWyS2DRTeyPLiHjgKxbrd5x5MB4LlXTPmCcAuh
 vkmGwfkqn+bIcBlTKDXduZfWyoqhfjX5ppOsrQlqu8xbm759UqHO1xLd7JwMNT1fxQ8u
 VJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=nsa5MFk3KLG7XhhgPmi3zOip7pCozd4o4Sfn09UF7AY=;
 b=CicA7dG7EVOII/C4ttkqbI9rB8JELgM54QoEiknx3ULTY1mNyk2NC3WNEvMs4/zzaO
 eFIbcDhpn/2yPTrKuExPvNQqIpqjAaT/S5i7ChlBQZLXFpFvmqqgmrd0FUqEP9JrbpFY
 mnNPHDveR/lUMxydnF7RCV2bK1y0hpdzRRyYF1nzBdU3g/DIp4mb9wCqHz6ppRGqi6W/
 sFQ2M8VA+RWjugS7/fSt//KnLXJ3ZfehuuY6huG//OFyI7y/18F53AFdmJpdXyLMW3sF
 JblTlvA55WvwDd3jrW+eERv8+/0dtusQYinQvsH5Ks58bTdJjs7C6oqCK0pLTSqx19eZ
 Ojhw==
X-Gm-Message-State: AOAM532Ww/DiYdOLowDIPpkoO23AVhKV2T5+1Le7W9w1eYBPeeAtOWvi
 7Ec2pLJRQtE/2z2hJz2LIakLgeEI
X-Google-Smtp-Source: ABdhPJyhri/9Bf37K+vskP+rkGFwzXkaQ6IP7zbEqDDZJscsAR104YGHXvqLSeVlB/L4iAm4R0LDtw==
X-Received: by 2002:adf:a51a:: with SMTP id i26mr2055080wrb.406.1591774909817; 
 Wed, 10 Jun 2020 00:41:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 128sm5923864wme.39.2020.06.10.00.41.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2020 00:41:48 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: remove distinction between explicit and
 implicit sync (v2)
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <CAAxE2A6T-hGWE7r_aFVmPyO__wh5kptbJiJ7rYd7dFg2TH2BKw@mail.gmail.com>
 <DM5PR12MB24405F71791676A64CB02D9EB4830@DM5PR12MB2440.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b47f193a-9103-ca7b-85e6-c8a52a977da8@gmail.com>
Date: Wed, 10 Jun 2020 09:41:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB24405F71791676A64CB02D9EB4830@DM5PR12MB2440.namprd12.prod.outlook.com>
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
Content-Type: multipart/mixed; boundary="===============1131340890=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1131340890==
Content-Type: multipart/alternative;
 boundary="------------59A9539BFA576F5B8EF055AE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------59A9539BFA576F5B8EF055AE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

That's true, but for now we are stuck with the implicit sync for quite a 
number of use cases.

My problem is rather that we already tried this and it backfired 
immediately.

I do remember that it was your patch who introduced the pipeline sync 
flag handling and I warned that this could be problematic. You then came 
back with a QA result saying that this is indeed causing a huge 
performance drop in one test case and we need to do something else. 
Together we then came up with the different handling between implicit 
and explicit sync.

But I can't find that stupid mail thread any more. I knew that it was a 
couple of years ago when we started with the explicit sync for Vulkan.

Christian.

Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Not sue if this is right direction, I think usermode wants all 
> synchronizations to be explicit. Implicit sync often confuses people 
> who don’t know its history. I remember Jason from Intel  is driving 
> explicit synchronization through the Linux ecosystem, which even 
> removes implicit sync of shared buffer.
>
> -David
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
> *Marek Olšák
> *Sent:* Tuesday, June 9, 2020 6:58 PM
> *To:* amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
> *Subject:* [PATCH] drm/amdgpu: remove distinction between explicit and 
> implicit sync (v2)
>
> Hi,
>
> This enables a full pipeline sync for implicit sync. It's Christian's 
> patch with the driver version bumped. With this, user mode drivers 
> don't have to wait for idle at the end of gfx IBs.
>
> Any concerns?
>
> Thanks,
>
> Marek
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------59A9539BFA576F5B8EF055AE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">That's true, but for now we are stuck
      with the implicit sync for quite a number of use cases.<br>
      <br>
      My problem is rather that we already tried this and it backfired
      immediately.<br>
      <br>
      I do remember that it was your patch who introduced the pipeline
      sync flag handling and I warned that this could be problematic.
      You then came back with a QA result saying that this is indeed
      causing a huge performance drop in one test case and we need to do
      something else. Together we then came up with the different
      handling between implicit and explicit sync.<br>
      <br>
      But I can't find that stupid mail thread any more. I knew that it
      was a couple of years ago when we started with the explicit sync
      for Vulkan.<br>
      <br>
      Christian.<br>
      <br>
      Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB24405F71791676A64CB02D9EB4830@DM5PR12MB2440.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
        <p class="msipheader4d0fcdd7"
          style="margin:0in;margin-bottom:.0001pt"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Not sue if this is right direction, I think
          usermode wants all synchronizations to be explicit. Implicit
          sync often confuses people who don’t know its history. I
          remember Jason from Intel  is driving explicit synchronization
          through the Linux ecosystem, which even removes implicit sync
          of shared buffer.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">-David<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div style="border:none;border-top:solid #E1E1E1
          1.0pt;padding:3.0pt 0in 0in 0in">
          <p class="MsoNormal"><b>From:</b> amd-gfx
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
            <b>On Behalf Of </b>Marek Olšák<br>
            <b>Sent:</b> Tuesday, June 9, 2020 6:58 PM<br>
            <b>To:</b> amd-gfx mailing list
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amdgpu: remove distinction
            between explicit and implicit sync (v2)<o:p></o:p></p>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <div>
            <p class="MsoNormal">Hi,<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal"><o:p> </o:p></p>
          </div>
          <div>
            <p class="MsoNormal">This enables a full pipeline sync for
              implicit sync. It's Christian's patch with the driver
              version bumped. With this, user mode drivers don't have to
              wait for idle at the end of gfx IBs.<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal"><o:p> </o:p></p>
          </div>
          <div>
            <p class="MsoNormal">Any concerns?<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal"><o:p> </o:p></p>
          </div>
          <div>
            <p class="MsoNormal">Thanks,<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal">Marek<o:p></o:p></p>
          </div>
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

--------------59A9539BFA576F5B8EF055AE--

--===============1131340890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1131340890==--
