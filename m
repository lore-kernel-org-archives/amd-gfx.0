Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7150C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 10:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C2210E1E8;
	Thu, 30 Mar 2023 10:48:58 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D99210E1ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 10:48:55 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id x3so74620408edb.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680173334;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUxtj+vBnxyRbXWC+tCPIIjdvFH9MiSBKxi8tUWA5Iw=;
 b=H6htspieNSshdMR9tbXUmlp8ikcpWYxsW2wR22LXU3Hy42Bcz0ONBJ8FtpEPBkoQsR
 CGRdgIz2zwETHGuYibFoOJBMsWuDOV9BHd34GlaRHfItLaJoVmSbEfv1vR0DNoQ4vs34
 TDk9WDwP/izm0me8Opcu1KRyLnaR2Sg8oGpa5HMi0GYnNcd/SnoMQTMDvVpNIKsB5p1Z
 5vXarDUSidJCyPUPKFu8JMerX/jTznFCd4fYDtF6lrNtRPtHTXVv+I8Cm4WLg009LkOY
 7w4ffYqxiY9YI2sFfH8jX45mclqKcCqt6HPMKZW7LNwPq9bQGZhJfG+41U1/vKA+kdsb
 +iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680173334;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BUxtj+vBnxyRbXWC+tCPIIjdvFH9MiSBKxi8tUWA5Iw=;
 b=zLbhjRAL0VygilAd1ZkSFPELbs/Nvyqv44qf9maL44MWEex1qfXvjio7dx7/upaN1A
 2amZGU6e2FVFxQtIMsKF18ohu1sBJgAm4kRLjoXrbt21K2CFEXA9XaMeGX9JVzgAsKk9
 xyLOt7ZThivBdyuUk6wsozLpPThO4xKec12cWechtVe5NBu6GrTlTNNf8NrgUAUO27Sz
 jjaFl02loIRvriAUtORH/5tS0urpJJHYmA8dS03ziTp3aYjyuZxu+bchFQX3JYx2Wo/O
 Y/bTsS0uCW4x3wVVSnfkfT8LxyZb2yrFxXvhESKJ7YORvRClCAyPK9IpBDp5ycM75RAO
 O9Gg==
X-Gm-Message-State: AAQBX9f8gJ/0NTZMy8J833RVnPCEucAu/xI+oeyj3q/UaO7P2/yAoXA6
 7CeGOeiiBewRplK1xXuFXGrx6Y0z5ApTiw==
X-Google-Smtp-Source: AKy350YQRaAQ7MLezSpdP14auWBEULY7uqBqLfZkNoraaxskiFxULKCpKjlq53OGCb9VeFiTSY/buA==
X-Received: by 2002:a17:906:4c59:b0:947:6d49:d221 with SMTP id
 d25-20020a1709064c5900b009476d49d221mr1059806ejw.6.1680173333886; 
 Thu, 30 Mar 2023 03:48:53 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 lx12-20020a170906af0c00b008e57b5e0ce9sm17374719ejb.108.2023.03.30.03.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Mar 2023 03:48:53 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------fSYCmysqYab03ZHgq83O3wwW"
Message-ID: <842f5527-6992-f579-8749-c49d4f9f6e28@gmail.com>
Date: Thu, 30 Mar 2023 12:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Content-Language: en-US
To: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
 <76206089-39dd-c009-f0a3-415f3c02406a@gmail.com>
 <SN1PR12MB24455388D199AD581AC2FA5CF58E9@SN1PR12MB2445.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <SN1PR12MB24455388D199AD581AC2FA5CF58E9@SN1PR12MB2445.namprd12.prod.outlook.com>
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------fSYCmysqYab03ZHgq83O3wwW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.03.23 um 11:15 schrieb Liu, HaoPing (Alan):
>
> [AMD Official Use Only - General]
>
> Hi Christian,
>
> Thanks for the review. Please see inline.
>
> Best Regards,
>
> Alan
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Tuesday, March 28, 2023 7:16 PM
> To: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; 
> amd-gfx@lists.freedesktop.org
> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
>
> Am 27.03.23 um 17:20 schrieb Alan Liu:
>
> > [Why]
>
> > After gpu-reset, sometimes the driver would fail to enable vblank irq,
>
> > causing flip_done timed out and the desktop freezed.
>
> >
>
> > During gpu-reset, we will disable and enable vblank irq in
>
> > dm_suspend() and dm_resume(). Later on in
>
> > amdgpu_irq_gpu_reset_resume_helper(), we will check irqs' refcount 
> and decide to enable or disable the irqs again.
>
> >
>
> > However, we have 2 sets of API for controling vblank irq, one is
>
> > dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
>
> > its own refcount and flag to store the state of vblank irq, and they
>
> > are not synchronized.
>
> This is the source of the problem and you should address this instead.
>
> The change you suggested below would break in some use cases.
>
> In struct drm_vblank_crtc we have a vblank irq refcount controlled by 
> drm layer, and in struct amdgpu_irq_src we have enabled_types as 
> refcount for each irq controlled by the dm.
>
> I think the best solution will be to get rid of the refcount in drm 
> and only maintain the dm one, and add a crtc function for the drm 
> layer to get the refcount/state of vblank.
>
> But this may be dangerous since it’s a change in drm layer. Do you 
> have any comments?
>

You don't necessarily need to remove it completely, what you can do as 
well is properly chaining of them.

E.g. when the DRM counter goes from 0->1 or 1->0 it calls some function 
to enable/disable the hw irq. In this situation you call 
amdgpu_irq_get()/amdgpu_irq_put() as appropriate.

The the code in this patch already looks like it goes into the right 
direction regarding that. It just seems to be that you have some race 
issues when you need to add checks that the IRQ counter doesn't goes 
below 0.

> >
>
> > In drm we use the first API to control vblank irq but in
>
> > amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
>
> >
>
> > The failure happens when vblank irq was enabled by dm_vblank_get()
>
> > before gpu-reset, we have vblank->enabled true. However, during
>
> > gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
>
> > checked from
>
> > amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq
>
> > again. After gpu-reset, if there is a cursor plane commit, the driver
>
> > will try to enable vblank irq by calling drm_vblank_enable(), but the
>
> > vblank->enabled is still true, so it fails to turn on vblank irq and
>
> > causes flip_done can't be completed in vblank irq handler and desktop
>
> > become freezed.
>
> >
>
> > [How]
>
> > Combining the 2 vblank control APIs by letting drm's API finally calls
>
> > amdgpu_irq's API, so the irq's refcount and state of both APIs can be
>
> > synchronized. Also add a check to prevent refcount from being less
>
> > then
>
> > 0 in amdgpu_irq_put().
>
> >
>
> > Signed-off-by: Alan Liu <HaoPing.Liu@amd.com 
> <mailto:HaoPing.Liu@amd.com>>
>
> > ---
>
> > drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++
>
> > .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14 ++++++++++----
>
> >   2 files changed, 13 insertions(+), 4 deletions(-)
>
> >
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>
> > index a6aef488a822..1b66003657e2 100644
>
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>
> > @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, 
> struct amdgpu_irq_src *src,
>
> >            if (!src->enabled_types || !src->funcs->set)
>
> >                           return -EINVAL;
>
> >
>
> > +         if (!amdgpu_irq_enabled(adev, src, type))
>
> > +                       return 0;
>
> > +
>
> That is racy and won't work. The intention of amdgpu_irq_update() is 
> to always update the irq state, no matter what the status is.
>
> This is a change to amdgpu_irq_put() to prevent the refcount from 
> being cut to less than 0. Does it break the intention of 
> amdgpu_irq_update()?
>

Yes, exactly that. The reference count can *never* be below 0 or you 
have a bug in the caller.

What you could do is to add a WARN_ON(!amdgpu_irq_enabled(adev, src, 
type)), but just ignoring the call is an absolute no-go.

Regards,
Christian.

PS: Please don't use HTML formating when discussing on public mailing lists.

> Regards,
>
> Christian.
>
> >            if (atomic_dec_and_test(&src->enabled_types[type]))
>
> >                           return amdgpu_irq_update(adev, src, type);
>
> >
>
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>
> > index dc4f37240beb..e04f846b0b19 100644
>
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>
> > @@ -146,7 +146,7 @@ static void vblank_control_worker(struct
>
> > work_struct *work)
>
> >
>
> >   static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>
> >   {
>
> > -          enum dc_irq_source irq_source;
>
> > +         int irq_type;
>
> >            struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>
> >            struct amdgpu_device *adev = drm_to_adev(crtc->dev);
>
> >            struct dm_crtc_state *acrtc_state = 
> to_dm_crtc_state(crtc->state);
>
> > @@ -169,10 +169,16 @@ static inline int dm_set_vblank(struct 
> drm_crtc *crtc, bool enable)
>
> >            if (rc)
>
> >                           return rc;
>
> >
>
> > -          irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
>
> > +         irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
>
> > +acrtc->crtc_id);
>
> > +
>
> > +         if (enable)
>
> > +                       rc = amdgpu_irq_get(adev, &adev->crtc_irq, 
> irq_type);
>
> > +
>
> > +         else
>
> > +                       rc = amdgpu_irq_put(adev, &adev->crtc_irq, 
> irq_type);
>
> >
>
> > -          if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>
> > -                        return -EBUSY;
>
> > +         if (rc)
>
> > +                       return rc;
>
> >
>
> >   skip:
>
> >            if (amdgpu_in_reset(adev))
>

--------------fSYCmysqYab03ZHgq83O3wwW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 30.03.23 um 11:15 schrieb Liu, HaoPing (Alan):<br>
    <blockquote type="cite"
cite="mid:SN1PR12MB24455388D199AD581AC2FA5CF58E9@SN1PR12MB2445.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 1 6 1 0 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:blue;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheaderdf3d92d6" style="margin:0cm"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
            Official Use Only - General]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoPlainText">Hi Christian,<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">Thanks for the review. Please see <span
            style="color:#00B050">
            inline</span>.<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">Best Regards,<o:p></o:p></p>
        <p class="MsoPlainText">Alan<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">-----Original Message-----<br>
          From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>
          <br>
          Sent: Tuesday, March 28, 2023 7:16 PM<br>
          To: Liu, HaoPing (Alan) <a class="moz-txt-link-rfc2396E" href="mailto:HaoPing.Liu@amd.com">&lt;HaoPing.Liu@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
          Cc: Lakha, Bhawanpreet <a class="moz-txt-link-rfc2396E" href="mailto:Bhawanpreet.Lakha@amd.com">&lt;Bhawanpreet.Lakha@amd.com&gt;</a><br>
          Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after
          gpu-reset<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">Am 27.03.23 um 17:20 schrieb Alan Liu:<o:p></o:p></p>
        <p class="MsoPlainText">&gt; [Why]<o:p></o:p></p>
        <p class="MsoPlainText">&gt; After gpu-reset, sometimes the
          driver would fail to enable vblank irq,
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; causing flip_done timed out and the
          desktop freezed.<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p> </o:p></p>
        <p class="MsoPlainText">&gt; During gpu-reset, we will disable
          and enable vblank irq in
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; dm_suspend() and dm_resume(). Later
          on in <o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          amdgpu_irq_gpu_reset_resume_helper(), we will check irqs'
          refcount and decide to enable or disable the irqs again.<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p> </o:p></p>
        <p class="MsoPlainText">&gt; However, we have 2 sets of API for
          controling vblank irq, one is<o:p></o:p></p>
        <p class="MsoPlainText">&gt; dm_vblank_get/put() and another is
          amdgpu_irq_get/put(). Each API has
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; its own refcount and flag to store
          the state of vblank irq, and they
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; are not synchronized.<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">This is the source of the problem and
          you should address this instead.
          <o:p></o:p></p>
        <p class="MsoPlainText">The change you suggested below would
          break in some use cases.<o:p></o:p></p>
        <p class="MsoPlainText"><span style="color:black"><o:p> </o:p></span></p>
        <p class="MsoPlainText"><span style="color:#00B050">In struct
            drm_vblank_crtc we have a vblank irq refcount controlled by
            drm layer, and in struct amdgpu_irq_src we have
            enabled_types as refcount for each irq controlled by the dm.<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#00B050">I think the
            best solution will be to get rid of the refcount in drm and
            only maintain the dm one, and add a crtc function for the
            drm layer to get the refcount/state of vblank.<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#00B050">But this may
            be dangerous since it’s a change in drm layer. Do you have
            any comments?
          </span></p>
      </div>
    </blockquote>
    <br>
    You don't necessarily need to remove it completely, what you can do
    as well is properly chaining of them.<br>
    <br>
    E.g. when the DRM counter goes from 0-&gt;1 or 1-&gt;0 it calls some
    function to enable/disable the hw irq. In this situation you call
    amdgpu_irq_get()/amdgpu_irq_put() as appropriate.<br>
    <br>
    The the code in this patch already looks like it goes into the right
    direction regarding that. It just seems to be that you have some
    race issues when you need to add checks that the IRQ counter doesn't
    goes below 0.<br>
    <br>
    <blockquote type="cite"
cite="mid:SN1PR12MB24455388D199AD581AC2FA5CF58E9@SN1PR12MB2445.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoPlainText"><span style="color:#00B050"><o:p></o:p></span></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">&gt;<o:p> </o:p></p>
        <p class="MsoPlainText">&gt; In drm we use the first API to
          control vblank irq but in<o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          amdgpu_irq_gpu_reset_resume_helper() we use the second set of
          API.<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p> </o:p></p>
        <p class="MsoPlainText">&gt; The failure happens when vblank irq
          was enabled by dm_vblank_get()
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; before gpu-reset, we have
          vblank-&gt;enabled true. However, during
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; gpu-reset, in
          amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; checked from<o:p></o:p></p>
        <p class="MsoPlainText">&gt; amdgpu_irq_update() is DISABLED. So
          finally it will disable vblank irq
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; again. After gpu-reset, if there is
          a cursor plane commit, the driver
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; will try to enable vblank irq by
          calling drm_vblank_enable(), but the<o:p></o:p></p>
        <p class="MsoPlainText">&gt; vblank-&gt;enabled is still true,
          so it fails to turn on vblank irq and<o:p></o:p></p>
        <p class="MsoPlainText">&gt; causes flip_done can't be completed
          in vblank irq handler and desktop
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; become freezed.<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p> </o:p></p>
        <p class="MsoPlainText">&gt; [How]<o:p></o:p></p>
        <p class="MsoPlainText">&gt; Combining the 2 vblank control APIs
          by letting drm's API finally calls
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; amdgpu_irq's API, so the irq's
          refcount and state of both APIs can be
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; synchronized. Also add a check to
          prevent refcount from being less
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; then<o:p></o:p></p>
        <p class="MsoPlainText">&gt; 0 in amdgpu_irq_put().<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p> </o:p></p>
        <p class="MsoPlainText">&gt; Signed-off-by: Alan Liu &lt;<a
            href="mailto:HaoPing.Liu@amd.com" moz-do-not-send="true"><span
              style="color:windowtext;text-decoration:none">HaoPing.Liu@amd.com</span></a>&gt;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; ---<o:p></o:p></p>
        <p class="MsoPlainText">&gt;  
          drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++<o:p></o:p></p>
        <p class="MsoPlainText">&gt;  
          .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14
          ++++++++++----<o:p></o:p></p>
        <p class="MsoPlainText">&gt;   2 files changed, 13
          insertions(+), 4 deletions(-)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;<o:p> </o:p></p>
        <p class="MsoPlainText">&gt; diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c <o:p>
          </o:p></p>
        <p class="MsoPlainText">&gt;
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<o:p></o:p></p>
        <p class="MsoPlainText">&gt; index a6aef488a822..1b66003657e2
          100644<o:p></o:p></p>
        <p class="MsoPlainText">&gt; ---
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +++
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<o:p></o:p></p>
        <p class="MsoPlainText">&gt; @@ -597,6 +597,9 @@ int
          amdgpu_irq_put(struct amdgpu_device *adev, struct
          amdgpu_irq_src *src,<o:p></o:p></p>
        <p class="MsoPlainText">&gt;            if
          (!src-&gt;enabled_types || !src-&gt;funcs-&gt;set)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;                           return
          -EINVAL;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;   <o:p></o:p></p>
        <p class="MsoPlainText">&gt; +         if
          (!amdgpu_irq_enabled(adev, src, type))<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +                       return 0;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">That is racy and won't work. The
          intention of amdgpu_irq_update() is to always update the irq
          state, no matter what the status is.<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText"><span style="color:#00B050">This is a
            change to amdgpu_irq_put() to prevent the refcount from
            being cut to less than 0. Does it break the intention of
            amdgpu_irq_update()?</span></p>
      </div>
    </blockquote>
    <br>
    Yes, exactly that. The reference count can *never* be below 0 or you
    have a bug in the caller.<br>
    <br>
    What you could do is to add a WARN_ON(!amdgpu_irq_enabled(adev, src,
    type)), but just ignoring the call is an absolute no-go.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    PS: Please don't use HTML formating when discussing on public
    mailing lists.<br>
    <br>
    <blockquote type="cite"
cite="mid:SN1PR12MB24455388D199AD581AC2FA5CF58E9@SN1PR12MB2445.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoPlainText"><span style="color:#00B050"><o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:black"><o:p> </o:p></span></p>
        <p class="MsoPlainText">Regards,<o:p></o:p></p>
        <p class="MsoPlainText">Christian.<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">&gt;            if
          (atomic_dec_and_test(&amp;src-&gt;enabled_types[type]))<o:p></o:p></p>
        <p class="MsoPlainText">&gt;                           return
          amdgpu_irq_update(adev, src, type);<o:p></o:p></p>
        <p class="MsoPlainText">&gt;   <o:p></o:p></p>
        <p class="MsoPlainText">&gt; diff --git
          a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt;
          b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<o:p></o:p></p>
        <p class="MsoPlainText">&gt; index dc4f37240beb..e04f846b0b19
          100644<o:p></o:p></p>
        <p class="MsoPlainText">&gt; ---
          a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +++
          b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<o:p></o:p></p>
        <p class="MsoPlainText">&gt; @@ -146,7 +146,7 @@ static void
          vblank_control_worker(struct
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; work_struct *work)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;   <o:p></o:p></p>
        <p class="MsoPlainText">&gt;   static inline int
          dm_set_vblank(struct drm_crtc *crtc, bool enable)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;   {<o:p></o:p></p>
        <p class="MsoPlainText">&gt; -          enum dc_irq_source
          irq_source;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +         int irq_type;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;            struct amdgpu_crtc
          *acrtc = to_amdgpu_crtc(crtc);<o:p></o:p></p>
        <p class="MsoPlainText">&gt;            struct amdgpu_device
          *adev = drm_to_adev(crtc-&gt;dev);<o:p></o:p></p>
        <p class="MsoPlainText">&gt;            struct dm_crtc_state
          *acrtc_state = to_dm_crtc_state(crtc-&gt;state);
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; @@ -169,10 +169,16 @@ static inline
          int dm_set_vblank(struct drm_crtc *crtc, bool enable)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;            if (rc)<o:p></o:p></p>
        <p class="MsoPlainText">&gt;                           return
          rc;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;   <o:p></o:p></p>
        <p class="MsoPlainText">&gt; -          irq_source =
          IRQ_TYPE_VBLANK + acrtc-&gt;otg_inst;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +         irq_type =
          amdgpu_display_crtc_idx_to_irq_type(adev,
          <o:p></o:p></p>
        <p class="MsoPlainText">&gt; +acrtc-&gt;crtc_id);<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +         if (enable)<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +                       rc =
          amdgpu_irq_get(adev, &amp;adev-&gt;crtc_irq, irq_type);<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +         else<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +                       rc =
          amdgpu_irq_put(adev, &amp;adev-&gt;crtc_irq, irq_type);<o:p></o:p></p>
        <p class="MsoPlainText">&gt;   <o:p></o:p></p>
        <p class="MsoPlainText">&gt; -          if
          (!dc_interrupt_set(adev-&gt;dm.dc, irq_source, enable))<o:p></o:p></p>
        <p class="MsoPlainText">&gt; -                        return
          -EBUSY;<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +         if (rc)<o:p></o:p></p>
        <p class="MsoPlainText">&gt; +                       return rc;<o:p></o:p></p>
        <p class="MsoPlainText">&gt;   <o:p></o:p></p>
        <p class="MsoPlainText">&gt;   skip:<o:p></o:p></p>
        <p class="MsoPlainText">&gt;            if
          (amdgpu_in_reset(adev))<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------fSYCmysqYab03ZHgq83O3wwW--
