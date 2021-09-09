Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7D1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5B460FE3
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B5B460FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F9A6E489;
	Thu,  9 Sep 2021 08:15:13 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5ED66E489
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 08:15:12 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id g16so1262672wrb.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Sep 2021 01:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=ZSpvEUEjFoCpkcz/+UlNz0b5fld3ymdDrK4IPdFaaHs=;
 b=UybEjfC9VKhvjjFHuI7Fz+oldDVsErCbNX/hHDv9V+mHVWq7RREAc6WTbrreqR55/d
 olvrUFjpTg3A6eWDv75HTUivQcl7B4pmtQ8OX0oUdFeJLn22jJHz6FIStR5sh1CWdd3p
 f5LwL4kujxZWjm64pou64csVhpx6NtqT21MRC/dnA+fDEEOX7IjKlTsqcj8CRbCx2q9u
 0nGHOwXv7u/FPSyY0CvC/ioUGdE9scO3aWFpztnB+zgNISTZJaW0nSHsh/0yJmYxzw55
 kS5Tg7sqA9QEB6D4F0SsC3JqQ9XB53+rxK6B1ft0z4cidloyjcXa6Lwh1ugkblsgQ/lx
 6EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=ZSpvEUEjFoCpkcz/+UlNz0b5fld3ymdDrK4IPdFaaHs=;
 b=8AgBkeubKs/dpnlrEuA5UDbM/0XcE2axHFXQSaaieY2oWw6gQtOQMUP1TOCxmQT8AO
 yg+Chj77UP9qfWLt/gEqZDxzQYKf28k+qZ532cNnTnSm4iumRajJq+FD0GXwO6ndnlF3
 ofYyCg4pggplGPlSyt6ybKyDgXl36Zb4r3osRXsXNHhZ1SjLQw/bMWCDmcgyKtDMDRYM
 w6JP2kmE4PV4bbAcdUw+5LtM2GmG7EXqq9VwZFBCX1x1PDKi1DmN2M7mdoGlOrFlb438
 Nij74Zjm6F4e78gAQRRXji3jYwdidzOdAryduJlmMQG8dqdxIM9mDKOoe9xIZwPndxqf
 33Rg==
X-Gm-Message-State: AOAM530s7rmxjE1fCdSCfLYksveVfXzqql7IPdbOmAHlClGs9ehuVY9z
 ws/G0dG1ylhXQWRNgK5i+dS6SL7WkNQ=
X-Google-Smtp-Source: ABdhPJxO2IiTGEQ5ReFxuXhD5dN2DsZR74uIvsDbR+4fM+HhwRrLzl2xpD01WAYEuRyRf16KZmaQww==
X-Received: by 2002:adf:914a:: with SMTP id j68mr2022660wrj.73.1631175311223; 
 Thu, 09 Sep 2021 01:15:11 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7140:364b:3af8:f004?
 ([2a02:908:1252:fb60:7140:364b:3af8:f004])
 by smtp.gmail.com with ESMTPSA id j18sm1059350wrd.56.2021.09.09.01.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Sep 2021 01:15:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: Increase direct IB pool size
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <DM4PR12MB5165BCC3E4E26C7EE4E85F3B87D59@DM4PR12MB5165.namprd12.prod.outlook.com>
 <8c56cc27-a99b-3ea5-1bf7-59cad134fe21@amd.com>
 <DM4PR12MB51653E83408F2CA3F3D5029687D59@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <811a527a-e02a-744e-e507-c1230d74de4a@gmail.com>
Date: Thu, 9 Sep 2021 10:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <DM4PR12MB51653E83408F2CA3F3D5029687D59@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="------------B96C432349F11C7180867999"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------B96C432349F11C7180867999
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Ok, good to know. That's probably the reason why we didn't push that 
stuff into the IB in the first place.

And yes, using fixed 256kiB sounds like a plan to me then, but please 
also double check the AMDGPU_IB_POOL_SIZE define.

I also won't mind if you just open code the two initialization since 
there probably will never be any more than that.

Thanks,
Christian.

Am 09.09.21 um 09:57 schrieb Pan, Xinhui:
>
> [AMD Official Use Only]
>
>
> yep, vcn need 128kb extra memory.  I will make the pool size constant 
> as 256kb.
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Thursday, September 9, 2021 3:14:15 PM
> *To:* Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: Increase direct IB pool size
> Am 09.09.21 um 07:54 schrieb Pan, Xinhui:
> > [AMD Official Use Only]
> >
> > Direct IB pool is used for vce/uvd/vcn IB extra msg too. Increase its
> > size to 64 pages.
>
> Do you really run into issues with that? 64 pages are 256kiB on x86 and
> the extra msg are maybe 2kiB.
>
> Additional to that we should probably make this a constant independent
> of the CPU page size.
>
> Christian.
>
> >
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > index c076a6b9a5a2..cd2c7073fdd9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -308,7 +308,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
> >
> >          for (i = 0; i < AMDGPU_IB_POOL_MAX; i++) {
> >                  if (i == AMDGPU_IB_POOL_DIRECT)
> > -                       size = PAGE_SIZE * 6;
> > +                       size = PAGE_SIZE * 64;
> >                  else
> >                          size = AMDGPU_IB_POOL_SIZE;
> >
> > --
> > 2.25.1
> >
>


--------------B96C432349F11C7180867999
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    Ok, good to know. That's probably the reason why we didn't push that
    stuff into the IB in the first place.<br>
    <br>
    And yes, using fixed 256kiB sounds like a plan to me then, but
    please also double check the AMDGPU_IB_POOL_SIZE define.<br>
    <br>
    I also won't mind if you just open code the two initialization since
    there probably will never be any more than that. <br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 09.09.21 um 09:57 schrieb Pan,
      Xinhui:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM4PR12MB51653E83408F2CA3F3D5029687D59@DM4PR12MB5165.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <p
        style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;"
        align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          yep, vcn need 128kb extra memory.  I will make the pool size
          constant as 256kb. </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, September 9, 2021 3:14:15 PM<br>
            <b>To:</b> Pan, Xinhui <a class="moz-txt-link-rfc2396E" href="mailto:Xinhui.Pan@amd.com">&lt;Xinhui.Pan@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Increase direct
            IB pool size</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt;">
              <div class="PlainText">Am 09.09.21 um 07:54 schrieb Pan,
                Xinhui:<br>
                &gt; [AMD Official Use Only]<br>
                &gt;<br>
                &gt; Direct IB pool is used for vce/uvd/vcn IB extra msg
                too. Increase its<br>
                &gt; size to 64 pages.<br>
                <br>
                Do you really run into issues with that? 64 pages are
                256kiB on x86 and <br>
                the extra msg are maybe 2kiB.<br>
                <br>
                Additional to that we should probably make this a
                constant independent <br>
                of the CPU page size.<br>
                <br>
                Christian.<br>
                <br>
                &gt;<br>
                &gt; Signed-off-by: xinhui pan
                <a class="moz-txt-link-rfc2396E" href="mailto:xinhui.pan@amd.com">&lt;xinhui.pan@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-<br>
                &gt;   1 file changed, 1 insertion(+), 1 deletion(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                &gt; index c076a6b9a5a2..cd2c7073fdd9 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                &gt; @@ -308,7 +308,7 @@ int amdgpu_ib_pool_init(struct
                amdgpu_device *adev)<br>
                &gt;<br>
                &gt;          for (i = 0; i &lt; AMDGPU_IB_POOL_MAX;
                i++) {<br>
                &gt;                  if (i == AMDGPU_IB_POOL_DIRECT)<br>
                &gt; -                       size = PAGE_SIZE * 6;<br>
                &gt; +                       size = PAGE_SIZE * 64;<br>
                &gt;                  else<br>
                &gt;                          size =
                AMDGPU_IB_POOL_SIZE;<br>
                &gt;<br>
                &gt; --<br>
                &gt; 2.25.1<br>
                &gt;<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------B96C432349F11C7180867999--
