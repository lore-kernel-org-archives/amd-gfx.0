Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3027C433E4
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 09:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A248B2070B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 09:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNIsz0mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A248B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A68F89CD3;
	Mon, 27 Jul 2020 09:41:00 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF87789CD3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 09:40:59 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id g11so4599269ejr.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=Z2uA9cBHQk9VMl7r+hCZr92yFxzVSM/mUawovLGZqsY=;
 b=gNIsz0mWqgbgVLUaC+AhiUIbRuqSQe10XUtoBKI64dsmmDLucg6SyCQ8MNZ/KbePle
 u3OaEE3v+sd0abbZ0YMeN2cxOb0ux9OC7ExCtjrcBhnzC3bYZ3KyPPiurvxqgoCahS+H
 bKBajI3vkyRZi/Rz69PmjpSTDkcuuYu6yKOTDZ4vTnyQJZPSUnDz2O73wQBQ76+j2tSz
 Tb3GwuHzhi3KmNt2SUOUX+Z/w/KhpTdbUpZjz/lL2i6++CeR6AMSFLIRUCI0UwuvQ8Wq
 1cwJMx/KluY4j678ZOdKJh1zM/eBxlkfChWxulNSsqYDd5lrLh3yI0vzrTE+sYfBMjK1
 PuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=Z2uA9cBHQk9VMl7r+hCZr92yFxzVSM/mUawovLGZqsY=;
 b=dEyy88KTVKSfXzpcXNr4ish42WKJYmsMmZYPoPcakyGpQW6bKz3un1G9Bw6rUNmHj3
 pKzvPLtwwgW7SDf/DJiJN840l5tyXiDg0Os8T48XT5047hiuq3EEC3OdYzeopdIrrd9y
 gYvwQlvDonZc1d6Xv3j/go4g40cwfV2ed7WHt3kbH+2t00AuZkfFH8iJrOmrg8WbEUWp
 Zt1zbvRjG72jvx7PEjxQCRqYG7JSrG1B6eggHGMsk75Xilik1EurFb5k1U1G4UOztb3H
 KyA34Ytz8z+DB1O2uvVyw51A3RDPpmk50Y2Q/1zV7ADNts1foY9CFLUusKDTwNyODymP
 Ydzg==
X-Gm-Message-State: AOAM531MC0mQ3Tea4mj4oyxI6CISVnDMX+q8qGHyVZJ0OBgAgz+3zfGZ
 LWDTPghPNP13+UIoN9uDN64=
X-Google-Smtp-Source: ABdhPJy3aJ7aQslX8BH3B2Ia/Z/4Y5Tf1iV6IT6OQWcmYv9gFpmzhvHeU02BXQ22kEycRVwBeEWAIQ==
X-Received: by 2002:a17:906:dbcf:: with SMTP id
 yc15mr19415347ejb.222.1595842858330; 
 Mon, 27 Jul 2020 02:40:58 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a23sm6833642eju.68.2020.07.27.02.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 02:40:57 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10
To: "Clements, John" <John.Clements@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <DM6PR12MB40262ED0408E4FD14160D1A1FB720@DM6PR12MB4026.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <71324dfd-a192-cab1-6432-1b44917ac12d@gmail.com>
Date: Mon, 27 Jul 2020 11:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB40262ED0408E4FD14160D1A1FB720@DM6PR12MB4026.namprd12.prod.outlook.com>
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
Content-Type: multipart/mixed; boundary="===============0545735566=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0545735566==
Content-Type: multipart/alternative;
 boundary="------------B22C257BC12428054C136BB1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B22C257BC12428054C136BB1
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Please use the "git send-email" command to send patches to the mailing list.

Christian.


Am 27.07.20 um 10:32 schrieb Clements, John:
>
> [AMD Public Use]
>
>
> Submitting patch to enable UMC 8.7 GECC functions in GMC v10
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------B22C257BC12428054C136BB1
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    <div class="moz-cite-prefix">Please use the "git send-email" command
      to send patches to the mailing list.<br>
      <br>
      Christian.<br>
      <br>
      <br>
      Am 27.07.20 um 10:32 schrieb Clements, John:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM6PR12MB40262ED0408E4FD14160D1A1FB720@DM6PR12MB4026.namprd12.prod.outlook.com">
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
      <p class="msipheader251902e5" style="margin:0" align="Left"><span
          style="font-size:10.0pt;font-family:Arial;color:#317100">[AMD
          Public Use]</span></p>
      <br>
      <div class="WordSection1">
        <p class="MsoNormal">Submitting patch to enable UMC 8.7 GECC
          functions in GMC v10<o:p></o:p></p>
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

--------------B22C257BC12428054C136BB1--

--===============0545735566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0545735566==--
