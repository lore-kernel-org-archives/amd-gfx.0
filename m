Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECA1C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 11:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DC161152
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 11:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DC161152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4FD6E06B;
	Tue, 13 Jul 2021 11:02:42 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E026E06B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 11:02:41 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 k16-20020a05600c1c90b02901f4ed0fcfe7so2033589wms.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=PfPx91+wUaMsUTmtmwzvMDou3AGLZg5VO2f2BEDfxUE=;
 b=HT3z4whG2VF96BGUGTjY82jblbnOztYpYuPHDd70ir81OE4v4EA0gJbJpfrgT+akT0
 Dh6v5muBOB1BfalramYoSyDpdFAs8mWLIerqGHvYaNgS73he0xlLmhodA8GYyy7wBphO
 qdYBY1FCGsga2D5slk0Rcy9ZOs1e4kJwtimE7TJFwTOsVzWExF13v4hjczuiFd/+lf8p
 qH954/x48y/4Xv+nhJVCJ02B1Dj+lm5zxedf4AxaZJUVa5FAJAnRBzu0Islw2DeCeLHm
 X2ezOuMiZiH0DiqmPcqyhDRhjTqwwxF+CS0XSHlx+2txl+j0ix/tNjofdlT99jRRu9r2
 Pm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=PfPx91+wUaMsUTmtmwzvMDou3AGLZg5VO2f2BEDfxUE=;
 b=Ebw3wPPdsM72Fwl+0/QW+Lk5OAy3YPH7CEsqrl54/NAu1/yn8k3hLp+wSBwt/2WVsh
 jIfn64oDDPFC52RDzzBuQUHix25nZ5lfSNebYrlsnr/2iBsj6tojV1ORnRmR5sK6qoRn
 GyXtCZrWfNG2M0k19NpzzZVFurzjYDPC5H+nCMohj0sP9iCzf+jeTf9gwh1/x9yywgxo
 cWseq5v8mCQr6BpftAD7exHvIrhFQgrH2bKOgf2d/CCBE/eHA9a1WvGNnrrE5Vtp8q1Y
 rTRxxklPBWKkRTbu73Lk08Rz/1d7pD63g77p1axWjvZh0pmeihs8RmukmsDkUck2AcoZ
 BgSA==
X-Gm-Message-State: AOAM533R7crqoo2A3UP+gnR5RBNCDrjmYUCzizXaQgZ05v4pPEsKhT47
 aS/zf5yFFrmBb4fEQT2YdM5y+WmkmBs=
X-Google-Smtp-Source: ABdhPJylFI4r/9E/rAK/CKLfj/6QPoVyT49lDty9Sx40YM6s3Ig66QakgyCJuDurtZZErs5O8ybk/Q==
X-Received: by 2002:a05:600c:4896:: with SMTP id
 j22mr4295173wmp.43.1626174160511; 
 Tue, 13 Jul 2021 04:02:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7f5a:cff:4644:b698?
 ([2a02:908:1252:fb60:7f5a:cff:4644:b698])
 by smtp.gmail.com with ESMTPSA id z17sm1505586wrs.54.2021.07.13.04.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jul 2021 04:02:39 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <BN9PR12MB5226592BA32F2E749A39B9D5FB149@BN9PR12MB5226.namprd12.prod.outlook.com>
 <BN9PR12MB5257A6F5F01459E9DB43B0DDFC149@BN9PR12MB5257.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8f4b76dd-c75b-e4db-4dc7-cc164210d175@gmail.com>
Date: Tue, 13 Jul 2021 13:02:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BN9PR12MB5257A6F5F01459E9DB43B0DDFC149@BN9PR12MB5257.namprd12.prod.outlook.com>
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
Content-Type: multipart/mixed; boundary="===============1591351023=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1591351023==
Content-Type: multipart/alternative;
 boundary="------------2E3A898C8D10911F2244AF39"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2E3A898C8D10911F2244AF39
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

And let me guess you "git send-email" with an AMD address doesn't work 
for you either?

I think we need to ping our IT once more.

Regards,
Christian.

Am 13.07.21 um 11:39 schrieb Zhang, Hawking:
>
> [AMD Official Use Only]
>
> Let’s submit the quick fix first and then work out better naming 
> styles to fix confusing
>
> The patch is
>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Regards,
> Hawking
>
> *From:* Clements, John <John.Clements@amd.com>
> *Sent:* Tuesday, July 13, 2021 17:37
> *To:* amd-gfx@lists.freedesktop.org
> *Cc:* Zhang, Hawking <Hawking.Zhang@amd.com>
> *Subject:* [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset
>
> [AMD Official Use Only]
>
> Submitting patch to resolve bug in UMC 6.7 error offset calculation
>
> Thank you,
>
> John Clements
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------2E3A898C8D10911F2244AF39
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    And let me guess you "git send-email" with an AMD address doesn't
    work for you either?<br>
    <br>
    I think we need to ping our IT once more.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 13.07.21 um 11:39 schrieb Zhang,
      Hawking:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN9PR12MB5257A6F5F01459E9DB43B0DDFC149@BN9PR12MB5257.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheadera4477989" style="margin:0in"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
            Official Use Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Let’s submit the quick fix first and then
          work out better naming styles to fix confusing<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">The patch is<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Reviewed-by: Hawking Zhang
          <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Regards,<br>
          Hawking<o:p></o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Clements, John
              <a class="moz-txt-link-rfc2396E" href="mailto:John.Clements@amd.com">&lt;John.Clements@amd.com&gt;</a> <br>
              <b>Sent:</b> Tuesday, July 13, 2021 17:37<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <b>Cc:</b> Zhang, Hawking <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
              <b>Subject:</b> [PATCH] drm/amdgpu: Resolve bug in UMC 6.7
              UMC error offset<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="msipheadera4477989" style="margin:0in"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
            Official Use Only]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Submitting patch to resolve bug in UMC 6.7
          error offset calculation<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Thank you,<o:p></o:p></p>
        <p class="MsoNormal">John Clements<o:p></o:p></p>
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

--------------2E3A898C8D10911F2244AF39--

--===============1591351023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1591351023==--
