Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698CFC2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 14:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09982074B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 14:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImNXkg+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09982074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8439B6E069;
	Wed,  4 Nov 2020 14:42:00 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 661C76E069
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 14:41:59 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id cw8so16546807ejb.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2020 06:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=by7kD3GnxrNialM9sO5mButuPsX+XdX3Nzxu47MGo2Q=;
 b=ImNXkg+Ah+tzHE6OgmBE10WQSzV9IWtexCm+Glk8OLAMdD1BHWaOiE0cq0F7oCu5pX
 wKakSOeaYOuvKsJ743GUTgH3YGwVF+UzVQMPYaVFKnoiZChL5L5wercZa/BxJnxMlQyy
 LWDpHwE6HsPAJywpm89XJlPDrzFOkSniJ5XZ5c2kb/oMAcSR7PSzNUtodc696KNaqxEd
 8xv8/0a5i/EF+cG6ZPLPpIBvT/63dp+OTLWOThaUcFtNdg+bn/JLLkESt1Q9z3o0kFJq
 yB1+/XUFy/qB8270QHPPozFX8MPh3tTtzbwPwBWv8C4OnRihCBgcS7f0Xnf3wuQgmzXn
 RbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=by7kD3GnxrNialM9sO5mButuPsX+XdX3Nzxu47MGo2Q=;
 b=i4AAEgGuBlnAe9OB30AzxHahHfHSh6qrfCXm2vndtH1QeAVmIl/HcjXR42YDqmZRgY
 TB5GZK90qp6zy+rnC2n4BeWwtMn3akvOmmGrMW3IP/v57tVLwQMxFEyUFPt82x8jF5C4
 TLE3tNYx0h6T0PCqLdyxQrLGkgQL5kwX8hCdmABXX6qK06ku9WKTJogY3b+2JLnjKUFq
 rztwmBa3bB5RmmJFrD6XT+VTdFKNbAOw3qhHJ6fmmGsly9N/D42Zi/6t7PSTv7OdbwTI
 uqrzRMKNFyQGspYdU1UXTONYk3suyk+uwBBuo2vPruQufvvm6fNzyJYFOeGKH0cWxsx1
 pn+A==
X-Gm-Message-State: AOAM532Os9dG77URck/qDU8nI9iYyNhaDYtNw4hYYsLGIDeNf1ynmsQH
 3iqn7FU3rJfyJG1kTDeLtdE=
X-Google-Smtp-Source: ABdhPJx4Ht8OWuNyRkAGv2O9c4+pXkS6mvljKCVrzdZawXEV49rTDTNBNdavYlqI1kTOZiQMUpRGcQ==
X-Received: by 2002:a17:906:13d6:: with SMTP id
 g22mr17197635ejc.240.1604500917999; 
 Wed, 04 Nov 2020 06:41:57 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o1sm1108282ejc.81.2020.11.04.06.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 06:41:57 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201103171340.2978395-1-shashank.sharma@amd.com>
 <7f9cc1a0-ad6b-ee9b-ac7b-4a49d08de1f9@amd.com>
 <MN2PR12MB3133BFD54B552B19A512B27CF2EF0@MN2PR12MB3133.namprd12.prod.outlook.com>
 <211bb89a-4433-3fb8-7849-6323cafe20fb@amd.com>
 <MN2PR12MB448848FEEB5717DDCF66F601F7EF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <b6e345a7-5547-2026-313c-739833c5013f@amd.com>
 <MN2PR12MB4488278FB8B457603F1B955CF7EF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <b326cc56-5374-8e35-9492-7ed82225030b@amd.com>
 <MN2PR12MB44885BB869E184372785BB5AF7EF0@MN2PR12MB4488.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3c18d0c2-ceab-d5ac-e44e-29d62f789259@gmail.com>
Date: Wed, 4 Nov 2020 15:41:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB44885BB869E184372785BB5AF7EF0@MN2PR12MB4488.namprd12.prod.outlook.com>
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
Cc: "Qin, Eddy" <Eddy.Qin@amd.com>
Content-Type: multipart/mixed; boundary="===============0331977621=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0331977621==
Content-Type: multipart/alternative;
 boundary="------------461998D46E6F4292AE18B514"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------461998D46E6F4292AE18B514
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Then feel free to stick an Acked-by: Christian König 
<christian.koenig@amd.com> to the code and get it committed.

Ideally somebody should have it on the TODO list to get rid of that code.

Christian.

Am 04.11.20 um 15:33 schrieb Deucher, Alexander:
> yeah, ideally.  Just need to get support for analog encoders.
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Wednesday, November 4, 2020 9:31 AM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Shashank 
> <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Qin, Eddy <Eddy.Qin@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
> In the long term we probably want to nuke this code anyway and switch 
> to the DC code, don't we?
>
> Christian.
>
> Am 04.11.20 um 15:23 schrieb Deucher, Alexander:
>> You might want to talk to the DAL team, they may have some advice.  
>> In general, I would say test it as well as you can.  It's probably 
>> safe as radeon is still the default driver for SI parts and generally 
>> seems to be working well there.
>>
>> Alex
>>
>> ------------------------------------------------------------------------
>> *From:* Sharma, Shashank <Shashank.Sharma@amd.com> 
>> <mailto:Shashank.Sharma@amd.com>
>> *Sent:* Wednesday, November 4, 2020 9:11 AM
>> *To:* Deucher, Alexander <Alexander.Deucher@amd.com> 
>> <mailto:Alexander.Deucher@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com>; 
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> 
>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>> *Cc:* Qin, Eddy <Eddy.Qin@amd.com> <mailto:Eddy.Qin@amd.com>
>> *Subject:* Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
>>
>> Thanks Alex, Same question here,
>>
>> Should we go through some extensive test routine due to change in PLL 
>> values, or is it OK to go ahead based on our experience from Radeon 
>> values ?
>>
>>
>> Regards
>>
>> Shashank
>>
>>
>> On 04/11/20 7:36 pm, Deucher, Alexander wrote:
>>> Acked-by: Alex Deucher <alexander.deucher@amd.com> 
>>> <mailto:alexander.deucher@amd.com>
>>> ------------------------------------------------------------------------
>>> *From:* Koenig, Christian <Christian.Koenig@amd.com> 
>>> <mailto:Christian.Koenig@amd.com>
>>> *Sent:* Wednesday, November 4, 2020 6:54 AM
>>> *To:* Sharma, Shashank <Shashank.Sharma@amd.com> 
>>> <mailto:Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.org 
>>> <mailto:amd-gfx@lists.freedesktop.org> 
>>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com> 
>>> <mailto:Alexander.Deucher@amd.com>; Qin, Eddy <Eddy.Qin@amd.com> 
>>> <mailto:Eddy.Qin@amd.com>
>>> *Subject:* Re: [PATCH] drm/amdgpu: clip the ref divider max value at 
>>> 100
>>> Am 04.11.20 um 11:40 schrieb Sharma, Shashank:
>>> > [AMD Public Use]
>>> >
>>> > Hello Christian,
>>> > Yes, that 100 is hardcoded in Radeon, and git blame says it was 
>>> one of your patches which made it 100 from 128 😊.
>>> > Would you mind having a look at commit id: 
>>> 4b21ce1b4b5d262e7d4656b8ececc891fc3cb806 ?
>>>
>>> Ah, yes that one :)
>>>
>>> Yeah the background is that this was just an educated guess because I
>>> couldn't find anybody which could tell me what the real limits of the
>>> PLL is.
>>>
>>> Looks like we just forgot to apply that patch to amdgpu.
>>>
>>> Regards,
>>> Christian.
>>>
>>> >
>>> > Regards
>>> > Shashank
>>> > -----Original Message-----
>>> > From: Koenig, Christian <Christian.Koenig@amd.com> 
>>> <mailto:Christian.Koenig@amd.com>
>>> > Sent: Wednesday, November 4, 2020 3:35 PM
>>> > To: Sharma, Shashank <Shashank.Sharma@amd.com> 
>>> <mailto:Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.org 
>>> <mailto:amd-gfx@lists.freedesktop.org>
>>> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com> 
>>> <mailto:Alexander.Deucher@amd.com>; Qin, Eddy <Eddy.Qin@amd.com> 
>>> <mailto:Eddy.Qin@amd.com>
>>> > Subject: Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
>>> >
>>> > Am 03.11.20 um 18:13 schrieb Shashank Sharma:
>>> >> This patch limits the ref_div_max value to 100, during the 
>>> calculation
>>> >> of PLL feedback reference divider. With current value (128), the
>>> >> produced fb_ref_div value generates unstable output at particular
>>> >> frequencies. Radeon driver limits this value at 100.
>>> > Mhm, is that 100 hard coded in radeon? I have no idea where that 
>>> is coming from.
>>> >
>>> > Best would probably to grab a hardware engineer and try to figure 
>>> out what the real maximums for the PLL is to still produce a stable 
>>> signal.
>>> >
>>> > Christian.
>>> >
>>> >> On Oland, when we try to setup mode 2048x1280@60 (a bit weird, I
>>> >> know), it demands a clock of 221270 Khz. It's been observed that the
>>> >> PLL calculations using values 128 and 100 are vastly different, and
>>> >> look like this:
>>> >>
>>> >> +------------------------------------------+
>>> >> |Parameter    |AMDGPU |Radeon       |
>>> >> |             | |             |
>>> >> +-------------+----------------------------+
>>> >> |Clock feedback |             |
>>> >> |divider max  |  128         | 100       |
>>> >> |cap value    | |             |
>>> >> |             | |             |
>>> >> |             | |             |
>>> >> +------------------------------------------+
>>> >> |ref_div_max  | |             |
>>> >> |             |  42          | 20         |
>>> >> |             | |             |
>>> >> |             | |             |
>>> >> +------------------------------------------+
>>> >> |ref_div      |  42          | 20         |
>>> >> |             | |             |
>>> >> +------------------------------------------+
>>> >> |fb_div       |  10326       | 8195       |
>>> >> +------------------------------------------+
>>> >> |fb_div       |  1024        | 163        |
>>> >> +------------------------------------------+
>>> >> |fb_dev_p     |  4           | 9          |
>>> >> |frac fb_de^_p| |             |
>>> >> +----------------------------+-------------+
>>> >>
>>> >> With ref_div_max value clipped at 100, AMDGPU driver can also drive
>>> >> videmode 2048x1280@60 (221Mhz) and produce proper output without any
>>> >> blanking and distortion on the screen.
>>> >>
>>> >> PS: This value was changed from 128 to 100 in Radeon driver also, 
>>> here:
>>> >> 
>>> https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8
>>> >> ececc891fc3cb806
>>> >>
>>> >> Cc: Alex Deucher <Alexander.Deucher@amd.com> 
>>> <mailto:Alexander.Deucher@amd.com>
>>> >> Cc: Christian König <christian.koenig@amd.com> 
>>> <mailto:christian.koenig@amd.com>
>>> >> Cc: Eddy Qin <Eddy.Qin@amd.com> <mailto:Eddy.Qin@amd.com>
>>> >>
>>> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com> 
>>> <mailto:shashank.sharma@amd.com>
>>> >> ---
>>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c | 2 +-
>>> >>    1 file changed, 1 insertion(+), 1 deletion(-)
>>> >>
>>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>>> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>>> >> index 1f2305b7bd13..23a2e1ebf78a 100644
>>> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>>> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>>> >> @@ -85,7 +85,7 @@ static void amdgpu_pll_get_fb_ref_div(unsigned 
>>> nom, unsigned den, unsigned post_
>>> >> unsigned *fb_div, unsigned *ref_div)
>>> >>    {
>>> >>       /* limit reference * post divider to a maximum */
>>> >> -    ref_div_max = min(128 / post_div, ref_div_max);
>>> >> +    ref_div_max = min(100 / post_div, ref_div_max);
>>> >>
>>> >>       /* get matching reference and feedback divider */
>>> >>       *ref_div = min(max(DIV_ROUND_CLOSEST(den, post_div), 1u),
>>> >> ref_div_max);
>>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------461998D46E6F4292AE18B514
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Then feel free to stick an Acked-by:
      Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a> to the code and
      get it committed.<br>
      <br>
      Ideally somebody should have it on the TODO list to get rid of
      that code.<br>
      <br>
      Christian.<br>
      <br>
      Am 04.11.20 um 15:33 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB44885BB869E184372785BB5AF7EF0@MN2PR12MB4488.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        yeah, ideally.  Just need to get support for analog encoders.<br>
      </div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Alex</div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
          <b>Sent:</b> Wednesday, November 4, 2020 9:31 AM<br>
          <b>To:</b> Deucher, Alexander
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Sharma, Shashank
          <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Cc:</b> Qin, Eddy <a class="moz-txt-link-rfc2396E" href="mailto:Eddy.Qin@amd.com">&lt;Eddy.Qin@amd.com&gt;</a><br>
          <b>Subject:</b> Re: [PATCH] drm/amdgpu: clip the ref divider
          max value at 100</font>
        <div> </div>
      </div>
      <div>
        <div class="x_moz-cite-prefix">In the long term we probably want
          to nuke this code anyway and switch to the DC code, don't we?<br>
          <br>
          Christian.<br>
          <br>
          Am 04.11.20 um 15:23 schrieb Deucher, Alexander:<br>
        </div>
        <blockquote type="cite">
          <style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
          <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
            You might want to talk to the DAL team, they may have some
            advice.  In general, I would say test it as well as you
            can.  It's probably safe as radeon is still the default
            driver for SI parts and generally seems to be working well
            there.</div>
          <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
            <br>
          </div>
          <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
            Alex</div>
          <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
            <br>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="x_divRplyFwdMsg" dir="ltr"><font
              style="font-size:11pt" face="Calibri, sans-serif"
              color="#000000"><b>From:</b> Sharma, Shashank
              <a class="x_moz-txt-link-rfc2396E"
                href="mailto:Shashank.Sharma@amd.com"
                moz-do-not-send="true">&lt;Shashank.Sharma@amd.com&gt;</a><br>
              <b>Sent:</b> Wednesday, November 4, 2020 9:11 AM<br>
              <b>To:</b> Deucher, Alexander <a
                class="x_moz-txt-link-rfc2396E"
                href="mailto:Alexander.Deucher@amd.com"
                moz-do-not-send="true">
                &lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
              <a class="x_moz-txt-link-rfc2396E"
                href="mailto:Christian.Koenig@amd.com"
                moz-do-not-send="true">
                &lt;Christian.Koenig@amd.com&gt;</a>; <a
                class="x_moz-txt-link-abbreviated"
                href="mailto:amd-gfx@lists.freedesktop.org"
                moz-do-not-send="true">
                amd-gfx@lists.freedesktop.org</a> <a
                class="x_moz-txt-link-rfc2396E"
                href="mailto:amd-gfx@lists.freedesktop.org"
                moz-do-not-send="true">
                &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Cc:</b> Qin, Eddy <a class="x_moz-txt-link-rfc2396E"
                href="mailto:Eddy.Qin@amd.com" moz-do-not-send="true">
                &lt;Eddy.Qin@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: clip the ref
              divider max value at 100</font>
            <div> </div>
          </div>
          <div>
            <p>Thanks Alex, Same question here, <br>
            </p>
            <p>Should we go through some extensive test routine due to
              change in PLL values, or is it OK to go ahead based on our
              experience from Radeon values ?
              <br>
            </p>
            <p><br>
            </p>
            <p>Regards<br>
            </p>
            <p>Shashank<br>
            </p>
            <p><br>
            </p>
            <div class="x_x_moz-cite-prefix">On 04/11/20 7:36 pm,
              Deucher, Alexander wrote:<br>
            </div>
            <blockquote type="cite">
              <style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
              <div
                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                Acked-by: Alex Deucher <a
                  class="x_x_moz-txt-link-rfc2396E"
                  href="mailto:alexander.deucher@amd.com"
                  moz-do-not-send="true">
                  &lt;alexander.deucher@amd.com&gt;</a><br>
              </div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="x_x_divRplyFwdMsg" dir="ltr"><font
                  style="font-size:11pt" face="Calibri, sans-serif"
                  color="#000000"><b>From:</b> Koenig, Christian
                  <a class="x_x_moz-txt-link-rfc2396E"
                    href="mailto:Christian.Koenig@amd.com"
                    moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><br>
                  <b>Sent:</b> Wednesday, November 4, 2020 6:54 AM<br>
                  <b>To:</b> Sharma, Shashank <a
                    class="x_x_moz-txt-link-rfc2396E"
                    href="mailto:Shashank.Sharma@amd.com"
                    moz-do-not-send="true">
                    &lt;Shashank.Sharma@amd.com&gt;</a>; <a
                    class="x_x_moz-txt-link-abbreviated"
                    href="mailto:amd-gfx@lists.freedesktop.org"
                    moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a> <a
                    class="x_x_moz-txt-link-rfc2396E"
                    href="mailto:amd-gfx@lists.freedesktop.org"
                    moz-do-not-send="true">
                    &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                  <b>Cc:</b> Deucher, Alexander <a
                    class="x_x_moz-txt-link-rfc2396E"
                    href="mailto:Alexander.Deucher@amd.com"
                    moz-do-not-send="true">
                    &lt;Alexander.Deucher@amd.com&gt;</a>; Qin, Eddy <a
                    class="x_x_moz-txt-link-rfc2396E"
                    href="mailto:Eddy.Qin@amd.com"
                    moz-do-not-send="true">
                    &lt;Eddy.Qin@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu: clip the ref
                  divider max value at 100</font>
                <div> </div>
              </div>
              <div class="x_x_BodyFragment"><font size="2"><span
                    style="font-size:11pt">
                    <div class="x_x_PlainText">Am 04.11.20 um 11:40
                      schrieb Sharma, Shashank:<br>
                      &gt; [AMD Public Use]<br>
                      &gt;<br>
                      &gt; Hello Christian,<br>
                      &gt; Yes, that 100 is hardcoded in Radeon, and git
                      blame says it was one of your patches which made
                      it 100 from 128 😊.<br>
                      &gt; Would you mind having a look at commit id:
                      4b21ce1b4b5d262e7d4656b8ececc891fc3cb806 ?<br>
                      <br>
                      Ah, yes that one :)<br>
                      <br>
                      Yeah the background is that this was just an
                      educated guess because I <br>
                      couldn't find anybody which could tell me what the
                      real limits of the <br>
                      PLL is.<br>
                      <br>
                      Looks like we just forgot to apply that patch to
                      amdgpu.<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      &gt;<br>
                      &gt; Regards<br>
                      &gt; Shashank<br>
                      &gt; -----Original Message-----<br>
                      &gt; From: Koenig, Christian <a
                        class="x_x_moz-txt-link-rfc2396E"
                        href="mailto:Christian.Koenig@amd.com"
                        moz-do-not-send="true">
                        &lt;Christian.Koenig@amd.com&gt;</a><br>
                      &gt; Sent: Wednesday, November 4, 2020 3:35 PM<br>
                      &gt; To: Sharma, Shashank <a
                        class="x_x_moz-txt-link-rfc2396E"
                        href="mailto:Shashank.Sharma@amd.com"
                        moz-do-not-send="true">
                        &lt;Shashank.Sharma@amd.com&gt;</a>; <a
                        class="x_x_moz-txt-link-abbreviated"
                        href="mailto:amd-gfx@lists.freedesktop.org"
                        moz-do-not-send="true">
                        amd-gfx@lists.freedesktop.org</a><br>
                      &gt; Cc: Deucher, Alexander <a
                        class="x_x_moz-txt-link-rfc2396E"
                        href="mailto:Alexander.Deucher@amd.com"
                        moz-do-not-send="true">
                        &lt;Alexander.Deucher@amd.com&gt;</a>; Qin, Eddy
                      <a class="x_x_moz-txt-link-rfc2396E"
                        href="mailto:Eddy.Qin@amd.com"
                        moz-do-not-send="true">
                        &lt;Eddy.Qin@amd.com&gt;</a><br>
                      &gt; Subject: Re: [PATCH] drm/amdgpu: clip the ref
                      divider max value at 100<br>
                      &gt;<br>
                      &gt; Am 03.11.20 um 18:13 schrieb Shashank Sharma:<br>
                      &gt;&gt; This patch limits the ref_div_max value
                      to 100, during the calculation<br>
                      &gt;&gt; of PLL feedback reference divider. With
                      current value (128), the<br>
                      &gt;&gt; produced fb_ref_div value generates
                      unstable output at particular<br>
                      &gt;&gt; frequencies. Radeon driver limits this
                      value at 100.<br>
                      &gt; Mhm, is that 100 hard coded in radeon? I have
                      no idea where that is coming from.<br>
                      &gt;<br>
                      &gt; Best would probably to grab a hardware
                      engineer and try to figure out what the real
                      maximums for the PLL is to still produce a stable
                      signal.<br>
                      &gt;<br>
                      &gt; Christian.<br>
                      &gt;<br>
                      &gt;&gt; On Oland, when we try to setup mode
                      2048x1280@60 (a bit weird, I<br>
                      &gt;&gt; know), it demands a clock of 221270 Khz.
                      It's been observed that the<br>
                      &gt;&gt; PLL calculations using values 128 and 100
                      are vastly different, and<br>
                      &gt;&gt; look like this:<br>
                      &gt;&gt;<br>
                      &gt;&gt;
                      +------------------------------------------+<br>
                      &gt;&gt; |Parameter    |AMDGPU       
                      |Radeon       |<br>
                      &gt;&gt; |             |             
                      |             |<br>
                      &gt;&gt;
                      +-------------+----------------------------+<br>
                      &gt;&gt; |Clock feedback             
                      |             |<br>
                      &gt;&gt; |divider max  |  128         |  
                      100       |<br>
                      &gt;&gt; |cap value    |             
                      |             |<br>
                      &gt;&gt; |             |             
                      |             |<br>
                      &gt;&gt; |             |             
                      |             |<br>
                      &gt;&gt;
                      +------------------------------------------+<br>
                      &gt;&gt; |ref_div_max  |             
                      |             |<br>
                      &gt;&gt; |             |  42          | 
                      20         |<br>
                      &gt;&gt; |             |             
                      |             |<br>
                      &gt;&gt; |             |             
                      |             |<br>
                      &gt;&gt;
                      +------------------------------------------+<br>
                      &gt;&gt; |ref_div      |  42          | 
                      20         |<br>
                      &gt;&gt; |             |             
                      |             |<br>
                      &gt;&gt;
                      +------------------------------------------+<br>
                      &gt;&gt; |fb_div       |  10326       | 
                      8195       |<br>
                      &gt;&gt;
                      +------------------------------------------+<br>
                      &gt;&gt; |fb_div       |  1024        | 
                      163        |<br>
                      &gt;&gt;
                      +------------------------------------------+<br>
                      &gt;&gt; |fb_dev_p     |  4           | 
                      9          |<br>
                      &gt;&gt; |frac fb_de^_p|             
                      |             |<br>
                      &gt;&gt;
                      +----------------------------+-------------+<br>
                      &gt;&gt;<br>
                      &gt;&gt; With ref_div_max value clipped at 100,
                      AMDGPU driver can also drive<br>
                      &gt;&gt; videmode 2048x1280@60 (221Mhz) and
                      produce proper output without any<br>
                      &gt;&gt; blanking and distortion on the screen.<br>
                      &gt;&gt;<br>
                      &gt;&gt; PS: This value was changed from 128 to
                      100 in Radeon driver also, here:<br>
                      &gt;&gt; <a
href="https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8"
                        moz-do-not-send="true">
https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8</a><br>
                      &gt;&gt; ececc891fc3cb806<br>
                      &gt;&gt;<br>
                      &gt;&gt; Cc: Alex Deucher <a
                        class="x_x_moz-txt-link-rfc2396E"
                        href="mailto:Alexander.Deucher@amd.com"
                        moz-do-not-send="true">
                        &lt;Alexander.Deucher@amd.com&gt;</a><br>
                      &gt;&gt; Cc: Christian König <a
                        class="x_x_moz-txt-link-rfc2396E"
                        href="mailto:christian.koenig@amd.com"
                        moz-do-not-send="true">
                        &lt;christian.koenig@amd.com&gt;</a><br>
                      &gt;&gt; Cc: Eddy Qin <a
                        class="x_x_moz-txt-link-rfc2396E"
                        href="mailto:Eddy.Qin@amd.com"
                        moz-do-not-send="true">
                        &lt;Eddy.Qin@amd.com&gt;</a><br>
                      &gt;&gt;<br>
                      &gt;&gt; Signed-off-by: Shashank Sharma <a
                        class="x_x_moz-txt-link-rfc2396E"
                        href="mailto:shashank.sharma@amd.com"
                        moz-do-not-send="true">
                        &lt;shashank.sharma@amd.com&gt;</a><br>
                      &gt;&gt; ---<br>
                      &gt;&gt;   
                      drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c | 2 +-<br>
                      &gt;&gt;    1 file changed, 1 insertion(+), 1
                      deletion(-)<br>
                      &gt;&gt;<br>
                      &gt;&gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
                      &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
                      &gt;&gt; index 1f2305b7bd13..23a2e1ebf78a 100644<br>
                      &gt;&gt; ---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
                      &gt;&gt; +++
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
                      &gt;&gt; @@ -85,7 +85,7 @@ static void
                      amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned
                      den, unsigned post_<br>
                      &gt;&gt;                                    
                      unsigned *fb_div, unsigned *ref_div)<br>
                      &gt;&gt;    {<br>
                      &gt;&gt;       /* limit reference * post divider
                      to a maximum */<br>
                      &gt;&gt; -    ref_div_max = min(128 / post_div,
                      ref_div_max);<br>
                      &gt;&gt; +    ref_div_max = min(100 / post_div,
                      ref_div_max);<br>
                      &gt;&gt;    <br>
                      &gt;&gt;       /* get matching reference and
                      feedback divider */<br>
                      &gt;&gt;       *ref_div =
                      min(max(DIV_ROUND_CLOSEST(den, post_div), 1u),<br>
                      &gt;&gt; ref_div_max);<br>
                      <br>
                    </div>
                  </span></font></div>
            </blockquote>
          </div>
        </blockquote>
        <br>
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

--------------461998D46E6F4292AE18B514--

--===============0331977621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0331977621==--
