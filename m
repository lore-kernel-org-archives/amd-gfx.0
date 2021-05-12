Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEFBC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 06:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEE561177
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 06:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEE561177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CADB6EB4B;
	Wed, 12 May 2021 06:55:21 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474FD6EB4B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 06:55:20 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id b25so33309029eju.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=Wu1LrxK8RTVLOA4oysYG+Mf4FWuy+l8JooqfXCYR+zo=;
 b=JzCij9DXx/n/zFh9JSb7PSeQsGeCDWU2bT07LSRQ4KF6ckH2t5JcoRCQxkmwRk5S8n
 cURbVW1zuq1BWu5ynd+JX6JyV2GLwClhQWPuUGoA7R7JARVmi7xSpaBNeCfEM5S8m7QM
 Lw8wjf+qG2vPirkT5lSR3AHWlTr1xLPIEOWUkzDr8eu4AhE5y4xTdCRp+E4/hi0/bTGB
 EBOF41rS9hTf9QO9Uc021hSgEpQ/GF/bDT6jhO/1AYhbJYXSlHKLLjI2mpdJXQ23Qimm
 m78bGMc4sjSArBLx3AhovC+c3G1xEDgApz0cq+K/ZdVqCEuEgbTOCN80juVd/E3BZw8T
 Q1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=Wu1LrxK8RTVLOA4oysYG+Mf4FWuy+l8JooqfXCYR+zo=;
 b=qxDcVSz8MD8iP/1DwZMaUhpD56q7PDysxQHRSXa/nSGAPd81PFBpdtRcATVfvi4obf
 DbbqxSexUbcj+gUblBQGjA/y7b73uMiVzf5nbjtjDWbjgCLrU2XHMlyn8SFTl5YUeuxg
 ScZdg58HDkl/+nQ45mvwmExSPjjhj34H400BG6sBciVJGblsZYfP8eOThZwyuXoBFkzK
 kY7Wz2z3JM/w0iwiAoSTuTX4X4wZoSGOP+WR/8v8nF4xGK1gceimV83WUtAEyPoABnAy
 PvXsyLYnYrf3tEHulfcAix2g03qBMRwIZOm51hy9dYIx6GznumoVFOGzmfKd+j7iIBlo
 jWcQ==
X-Gm-Message-State: AOAM532HI5yMplGp8mSlRnPZ5kTcXxMjPw14QXp3jZKMmt0nn2P4B91l
 icDA1ZhWQueEdYTSFAiyRmJAs18RzKA=
X-Google-Smtp-Source: ABdhPJwXAcZ4Ha4cVKSCNlf0oY2p9GVO9oCxs+bvXdljd6448xRMDUsygWuhIl6BVsYRw+MSv+8MOQ==
X-Received: by 2002:a17:906:858:: with SMTP id
 f24mr36508296ejd.347.1620802519040; 
 Tue, 11 May 2021 23:55:19 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:bc39:4e06:ac5e:2e31?
 ([2a02:908:1252:fb60:bc39:4e06:ac5e:2e31])
 by smtp.gmail.com with ESMTPSA id t20sm13372934ejc.61.2021.05.11.23.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 23:55:18 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation
To: "Nieto, David M" <David.Nieto@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <c1b6f68f-4b96-8752-c406-564e2b98ce41@gmail.com>
 <20210510202915.30502-1-david.nieto@amd.com>
 <20210510202915.30502-2-david.nieto@amd.com>
 <7579fa92-ad25-323a-0c41-ac07ac47fa42@gmail.com>
 <BYAPR12MB284099C33725C0BB0FDD8D48F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9b373f49-51ad-089c-2494-032b13a9a39c@gmail.com>
Date: Wed, 12 May 2021 08:55:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB284099C33725C0BB0FDD8D48F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
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
Content-Type: multipart/mixed; boundary="===============1135282661=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1135282661==
Content-Type: multipart/alternative;
 boundary="------------3A1D30770827C865F2B76F03"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3A1D30770827C865F2B76F03
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

In this case amdgpu_ctx_fence_time should probably be changed to 
initialize the variable itself.

That is really bad coding style otherwise.

Christian.

Am 11.05.21 um 20:14 schrieb Nieto, David M:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> The local variables need to be initialized to zero, since 
> amdgpu_ctx_fence_time accumulates and does not initialize
>
> David
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Tuesday, May 11, 2021 12:53 AM
> *To:* Nieto, David M <David.Nieto@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH 2/2] drm/amdgpu: fix fence calculation
> Am 10.05.21 um 22:29 schrieb David M Nieto:
> > The proper metric for fence utilization over several
> > contexts is an harmonic mean, but such calculation is
> > prohibitive in kernel space, so the code approximates it.
> >
> > Because the approximation diverges when one context has a
> > very small ratio compared with the other context, this change
> > filter out ratios smaller that 0.01%
> >
> > Signed-off-by: David M Nieto <david.nieto@amd.com>
> > Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 13 ++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
> >   2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > index 9036c93b4a0c..89ee464b9424 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -698,16 +698,27 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct 
> amdgpu_ctx_mgr *mgr, uint32_t hwip,
> >        struct amdgpu_ctx_entity *centity;
> >        ktime_t total = 0, max = 0;
> >
> > +
>
> Unrelated white space change.
>
> >        if (idx >= AMDGPU_MAX_ENTITY_NUM)
> >                return 0;
> >        idp = &mgr->ctx_handles;
> >        mutex_lock(&mgr->lock);
> >        idr_for_each_entry(idp, ctx, id) {
> > +             ktime_t ttotal = tmax = ktime_set(0, 0);
>
> There should be a blank line between decleration and code and please
> don't initialize local variables if it isn't necessary.
>
> Christian.
>
> >                if (!ctx->entities[hwip][idx])
> >                        continue;
> >
> >                centity = ctx->entities[hwip][idx];
> > -             amdgpu_ctx_fence_time(ctx, centity, &total, &max);
> > +             amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
> > +
> > +             /* Harmonic mean approximation diverges for very small
> > +              * values. If ratio < 0.01% ignore
> > +              */
> > +             if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
> > +                     continue;
> > +
> > +             total = ktime_add(total, ttotal);
> > +             max = ktime_after(tmax, max) ? tmax : max;
> >        }
> >
> >        mutex_unlock(&mgr->lock);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > index 10dcf59a5c6b..3541dfb059ec 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > @@ -30,6 +30,7 @@ struct drm_file;
> >   struct amdgpu_fpriv;
> >
> >   #define AMDGPU_MAX_ENTITY_NUM 4
> > +#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) (max > 
> 16384ULL*total)
> >
> >   struct amdgpu_ctx_entity {
> >        uint64_t                sequence;
>


--------------3A1D30770827C865F2B76F03
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    In this case <span style="color: rgb(0, 0, 0); font-family:
      &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;,
      &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,
      &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px;
      background-color: rgb(255, 255, 255); display: inline !important;">amdgpu_ctx_fence_time
      should probably be changed to initialize the variable itself.<br>
      <br>
      That is really bad coding style otherwise.<br>
      <br>
      Christian.<br>
    </span><br>
    <div class="moz-cite-prefix">Am 11.05.21 um 20:14 schrieb Nieto,
      David M:<br>
    </div>
    <blockquote type="cite"
cite="mid:BYAPR12MB284099C33725C0BB0FDD8D48F4539@BYAPR12MB2840.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
        style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;"
        align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0); background-color:
          rgb(255, 255, 255);">
          The local variables need to be initialized to zero, since <span
            style="color: rgb(0, 0, 0); font-family: &quot;Segoe
            UI&quot;, &quot;Segoe UI Web (West European)&quot;,
            &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont,
            Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size:
            14.6667px; background-color: rgb(255, 255, 255); display:
            inline !important;">amdgpu_ctx_fence_time accumulates and
            does not initialize</span></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0); background-color:
          rgb(255, 255, 255);">
          <span style="color: rgb(0, 0, 0); font-family: &quot;Segoe
            UI&quot;, &quot;Segoe UI Web (West European)&quot;,
            &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont,
            Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size:
            14.6667px; background-color: rgb(255, 255, 255); display:
            inline !important;"><br>
          </span></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0); background-color:
          rgb(255, 255, 255);">
          <span style="color: rgb(0, 0, 0); font-family: &quot;Segoe
            UI&quot;, &quot;Segoe UI Web (West European)&quot;,
            &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont,
            Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size:
            14.6667px; background-color: rgb(255, 255, 255); display:
            inline !important;">David</span></div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Tuesday, May 11, 2021 12:53 AM<br>
            <b>To:</b> Nieto, David M <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: fix fence
            calculation</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt;">
              <div class="PlainText">Am 10.05.21 um 22:29 schrieb David
                M Nieto:<br>
                &gt; The proper metric for fence utilization over
                several<br>
                &gt; contexts is an harmonic mean, but such calculation
                is<br>
                &gt; prohibitive in kernel space, so the code
                approximates it.<br>
                &gt;<br>
                &gt; Because the approximation diverges when one context
                has a<br>
                &gt; very small ratio compared with the other context,
                this change<br>
                &gt; filter out ratios smaller that 0.01%<br>
                &gt;<br>
                &gt; Signed-off-by: David M Nieto
                <a class="moz-txt-link-rfc2396E" href="mailto:david.nieto@amd.com">&lt;david.nieto@amd.com&gt;</a><br>
                &gt; Change-Id:
                I5b6e0ce5f489a5f55855d35354a6a3653e9d613b<br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 13
                ++++++++++++-<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +<br>
                &gt;   2 files changed, 13 insertions(+), 1 deletion(-)<br>
                &gt;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
                &gt; index 9036c93b4a0c..89ee464b9424 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
                &gt; @@ -698,16 +698,27 @@ ktime_t
                amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr,
                uint32_t hwip,<br>
                &gt;        struct amdgpu_ctx_entity *centity;<br>
                &gt;        ktime_t total = 0, max = 0;<br>
                &gt;   <br>
                &gt; +<br>
                <br>
                Unrelated white space change.<br>
                <br>
                &gt;        if (idx &gt;= AMDGPU_MAX_ENTITY_NUM)<br>
                &gt;                return 0;<br>
                &gt;        idp = &amp;mgr-&gt;ctx_handles;<br>
                &gt;        mutex_lock(&amp;mgr-&gt;lock);<br>
                &gt;        idr_for_each_entry(idp, ctx, id) {<br>
                &gt; +             ktime_t ttotal = tmax = ktime_set(0,
                0);<br>
                <br>
                There should be a blank line between decleration and
                code and please <br>
                don't initialize local variables if it isn't necessary.<br>
                <br>
                Christian.<br>
                <br>
                &gt;                if (!ctx-&gt;entities[hwip][idx])<br>
                &gt;                        continue;<br>
                &gt;   <br>
                &gt;                centity =
                ctx-&gt;entities[hwip][idx];<br>
                &gt; -             amdgpu_ctx_fence_time(ctx, centity,
                &amp;total, &amp;max);<br>
                &gt; +             amdgpu_ctx_fence_time(ctx, centity,
                &amp;ttotal, &amp;tmax);<br>
                &gt; +<br>
                &gt; +             /* Harmonic mean approximation
                diverges for very small<br>
                &gt; +              * values. If ratio &lt; 0.01% ignore<br>
                &gt; +              */<br>
                &gt; +             if
                (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))<br>
                &gt; +                     continue;<br>
                &gt; +<br>
                &gt; +             total = ktime_add(total, ttotal);<br>
                &gt; +             max = ktime_after(tmax, max) ? tmax :
                max;<br>
                &gt;        }<br>
                &gt;   <br>
                &gt;        mutex_unlock(&amp;mgr-&gt;lock);<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h<br>
                &gt; index 10dcf59a5c6b..3541dfb059ec 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h<br>
                &gt; @@ -30,6 +30,7 @@ struct drm_file;<br>
                &gt;   struct amdgpu_fpriv;<br>
                &gt;   <br>
                &gt;   #define AMDGPU_MAX_ENTITY_NUM 4<br>
                &gt; +#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max,
                total) (max &gt; 16384ULL*total)<br>
                &gt;   <br>
                &gt;   struct amdgpu_ctx_entity {<br>
                &gt;        uint64_t                sequence;<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------3A1D30770827C865F2B76F03--

--===============1135282661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1135282661==--
