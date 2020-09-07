Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA74FC43461
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 08:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB3C21556
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 08:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3DClvfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB3C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45C56E3C1;
	Mon,  7 Sep 2020 08:26:02 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1D56E3C1
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 08:26:01 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id q21so11938489edv.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2020 01:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=ZUSDzrfQJ+V/xzADLiijX6iwJW7WmzBRMFPpsbjvIvI=;
 b=G3DClvfKVYG9vUxY7Mxh9P+Vem+r9wERgiLEL+1B2dMu/PAh4nqCz5e3M2nUo5dCSE
 ONRSn8FtdTPx77iPUlQ6gJniNyhBWXdZfstY0kx6mGbyaZndvXatTUBNV+03wjZn2PqZ
 DNEJ/aTjaB/VduyK1cQndotscjwT4VyYrDkyK8qWJ7aV4NwkzGDZnk+JGS+U2HdGysqK
 AuwvfQecJ0ES/IMOvBSIyzsrFxTBggxqqB9ehZP46PKzSvlI027ozMoXD1ybdkggpDFK
 OvmyZ8qQl08MYZ7/QnOLyKRv1xPs2h+9gc+7hSrkCsNO/m/vk0d+vL3knA7fdLy4TH2D
 vp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=ZUSDzrfQJ+V/xzADLiijX6iwJW7WmzBRMFPpsbjvIvI=;
 b=JNHU4H7It/CxV/JSWnctjVGxTvbciIfA3rQYO1iDhsKiElnWXRmb9FvsvE9Mx2zVNJ
 /ZYkars29j1WaPN6TyG1eXzEmSSbbLAmyW/w9yESjemuzutt6Qqahp+lhVrTJ9cGbBrA
 c3shHzzBfneLygcq6xJH7dSbzfm/TfWL4OxaV1kZl2zgFtEeOYk2LdHmaQX/D0uCYBsa
 9GNJzWCNLNd5PCZuLmah7lrlMjarH9I2Pdl9sYbqt84tXIQXBgMJJZTB6HOobbZNl/Np
 Y/KD2J3ruOLjAPh2KmMLshtGnm4xBZta1oF1mJGFzVckUGc+Mzm3RvEx640OEEumxkFW
 pRkA==
X-Gm-Message-State: AOAM533KnhuzU25Eb7pOkHMD5BpGTr25h29sNXDneEJhuh5QvEMC+Cv1
 Jl/0hDDY4I3y5ATLccJIDv98ge0H5yE=
X-Google-Smtp-Source: ABdhPJy1ad0MrhcFx5IYF5WZqWHSxYrNiDvIAfEiaRyukZXlZIAAue/VbNhLgSsk4DCikDz4CK9q4g==
X-Received: by 2002:a05:6402:8d3:: with SMTP id
 d19mr20359660edz.68.1599467160174; 
 Mon, 07 Sep 2020 01:26:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t14sm14269327edc.7.2020.09.07.01.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 01:25:59 -0700 (PDT)
Subject: Re: [PATCH] radeon: Use only a single work queue thread for crt
To: Jan Vesely <jan.vesely@rutgers.edu>,
 "Koenig, Christian" <christian.koenig@amd.com>
References: <20190803000908.5310-1-andi@firstfloor.org>
 <47558836-612d-75e3-c4a8-7b8baf53036d@gmail.com>
 <CABE_ZV3Uk69RXv9RYj5d7cNXi5pX16Ve8qkkGPB5=OAX5b_6Rg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4d01188b-bc90-2ae8-2ca3-c12159413bc9@gmail.com>
Date: Mon, 7 Sep 2020 10:25:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABE_ZV3Uk69RXv9RYj5d7cNXi5pX16Ve8qkkGPB5=OAX5b_6Rg@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Andi Kleen <ak@linux.intel.com>,
 Andi Kleen <andi@firstfloor.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0075331282=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0075331282==
Content-Type: multipart/alternative;
 boundary="------------1DEF7B2D6C25FBB1578337CC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1DEF7B2D6C25FBB1578337CC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.09.20 um 18:02 schrieb Jan Vesely:
>
>
> On Sun, Sep 6, 2020 at 4:54 AM Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     Am 03.08.19 um 02:09 schrieb Andi Kleen:
>     > From: Andi Kleen <ak@linux.intel.com <mailto:ak@linux.intel.com>>
>     >
>     > I got tired of seeing a lot of radeon-crt kernel threads in ps on my
>     > workstation, one for each CPU and one for each display, which
>     never use any CPU time.
>     > Surely a single kernel thread is enough to handle the display.
>
>     NAK, radeon blocks inside the kernel thread and those need to run in
>     parallel or otherwise the hardware can hang.
>
>
> Shouldn't WQ_UNBOUND create a new worker thread whenever all current 
> workers go to sleep/block (and the total number of worker threads is 
> below 'max_active') ?

If that is guaranteed then this is indeed sufficient, but the sentence 
"Surely a single kernel thread is enough to handle the display." sounded 
like it creates only a single one.

Christian.

>
> Jan
>
>
>     Christian.
>
>     >
>     > Signed-off-by: Andi Kleen <ak@linux.intel.com
>     <mailto:ak@linux.intel.com>>
>     > ---
>     >   drivers/gpu/drm/radeon/radeon_display.c | 2 +-
>     >   1 file changed, 1 insertion(+), 1 deletion(-)
>     >
>     > diff --git a/drivers/gpu/drm/radeon/radeon_display.c
>     b/drivers/gpu/drm/radeon/radeon_display.c
>     > index bd52f15e6330..fb0ca688f6fe 100644
>     > --- a/drivers/gpu/drm/radeon/radeon_display.c
>     > +++ b/drivers/gpu/drm/radeon/radeon_display.c
>     > @@ -682,7 +682,7 @@ static void radeon_crtc_init(struct
>     drm_device *dev, int index)
>     >
>     >  drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
>     >       radeon_crtc->crtc_id = index;
>     > -     radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc",
>     WQ_HIGHPRI, 0);
>     > +     radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc",
>     WQ_HIGHPRI|WQ_UNBOUND, 0);
>     >       rdev->mode_info.crtcs[index] = radeon_crtc;
>     >
>     >       if (rdev->family >= CHIP_BONAIRE) {
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------1DEF7B2D6C25FBB1578337CC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 06.09.20 um 18:02 schrieb Jan
      Vesely:<br>
    </div>
    <blockquote type="cite"
cite="mid:CABE_ZV3Uk69RXv9RYj5d7cNXi5pX16Ve8qkkGPB5=OAX5b_6Rg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Sun, Sep 6, 2020 at 4:54
            AM Christian König &lt;<a
              href="mailto:ckoenig.leichtzumerken@gmail.com"
              moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Am 03.08.19 um 02:09
            schrieb Andi Kleen:<br>
            &gt; From: Andi Kleen &lt;<a
              href="mailto:ak@linux.intel.com" target="_blank"
              moz-do-not-send="true">ak@linux.intel.com</a>&gt;<br>
            &gt;<br>
            &gt; I got tired of seeing a lot of radeon-crt kernel
            threads in ps on my<br>
            &gt; workstation, one for each CPU and one for each display,
            which never use any CPU time.<br>
            &gt; Surely a single kernel thread is enough to handle the
            display.<br>
            <br>
            NAK, radeon blocks inside the kernel thread and those need
            to run in <br>
            parallel or otherwise the hardware can hang.<br>
          </blockquote>
          <div><br>
            Shouldn't WQ_UNBOUND create a new worker thread whenever all
            current workers go to sleep/block (and the total number of
            worker threads is below 'max_active') ?<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    If that is guaranteed then this is indeed sufficient, but the
    sentence "Surely a single kernel thread is enough to handle the
    display." sounded like it creates only a single one.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CABE_ZV3Uk69RXv9RYj5d7cNXi5pX16Ve8qkkGPB5=OAX5b_6Rg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>Jan</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            Christian.<br>
            <br>
            &gt;<br>
            &gt; Signed-off-by: Andi Kleen &lt;<a
              href="mailto:ak@linux.intel.com" target="_blank"
              moz-do-not-send="true">ak@linux.intel.com</a>&gt;<br>
            &gt; ---<br>
            &gt;   drivers/gpu/drm/radeon/radeon_display.c | 2 +-<br>
            &gt;   1 file changed, 1 insertion(+), 1 deletion(-)<br>
            &gt;<br>
            &gt; diff --git a/drivers/gpu/drm/radeon/radeon_display.c
            b/drivers/gpu/drm/radeon/radeon_display.c<br>
            &gt; index bd52f15e6330..fb0ca688f6fe 100644<br>
            &gt; --- a/drivers/gpu/drm/radeon/radeon_display.c<br>
            &gt; +++ b/drivers/gpu/drm/radeon/radeon_display.c<br>
            &gt; @@ -682,7 +682,7 @@ static void radeon_crtc_init(struct
            drm_device *dev, int index)<br>
            &gt;   <br>
            &gt;     
             drm_mode_crtc_set_gamma_size(&amp;radeon_crtc-&gt;base,
            256);<br>
            &gt;       radeon_crtc-&gt;crtc_id = index;<br>
            &gt; -     radeon_crtc-&gt;flip_queue =
            alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);<br>
            &gt; +     radeon_crtc-&gt;flip_queue =
            alloc_workqueue("radeon-crtc", WQ_HIGHPRI|WQ_UNBOUND, 0);<br>
            &gt;       rdev-&gt;mode_info.crtcs[index] = radeon_crtc;<br>
            &gt;   <br>
            &gt;       if (rdev-&gt;family &gt;= CHIP_BONAIRE) {<br>
            <br>
            _______________________________________________<br>
            amd-gfx mailing list<br>
            <a href="mailto:amd-gfx@lists.freedesktop.org"
              target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
            <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </blockquote>
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

--------------1DEF7B2D6C25FBB1578337CC--

--===============0075331282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0075331282==--
