Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1490C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 14:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1761210E2B6;
	Tue, 28 May 2024 14:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q0sw9hef";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4AE110E2B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 14:41:53 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2e716e302bdso10668941fa.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716907312; x=1717512112; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jSDuClNj1RXldbrYlyv1+1c0xjzpJRcJfMzw7CHHIE=;
 b=Q0sw9hefcISpjLvFC0ubiD2iDj6K+TN8RE2mTy6zKXHl8bgCUBfKl8x4lRR5c+XEaq
 YThZaV2gynjdQ2jCnTuGIZ9gzh1GqijhnpTxVlvw7c7sJdB3Rh8QZiR9X8FBeoql7VZZ
 rk24+qvnxfocIV46/tg6kT+aQsxA5tG3n/6xk7yUL1Yr5beJXBW0ECZMVrYVERHAI9Cq
 u/wDd+8JWs39yP9XmOARpPsEJJWJ85xR49GmRddcA1RR0r0X+Pldmb84MjUSWwNjMNNU
 o4UCIqG3cqn3aJSroacH9OFCCLgzaN9/3LVJb58+8cw59lTUKrmCbOJ++1bxnyKyXtVI
 v0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907312; x=1717512112;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jSDuClNj1RXldbrYlyv1+1c0xjzpJRcJfMzw7CHHIE=;
 b=vfjuWSdRQXuvInm4vkpAOkosYkrfafIpk5QoigDR+DwvTOiQcWYoiXiP2ox5t3Cys/
 obdK3JXesSSrhzbOonqU8c+vU8r/RvORv/+U9MCXAApyEx9LC9gTIXKrkioMGrYGVoLf
 /eEyhtlLgJ8rzKcTFx1IOmnAKmecs/uodZ/vRRgoXP6yOhfybLAr3+r2nw7COGZpGlxP
 KdkggteJczHeWgZsE6MPtGh1w4GC4IxcjY+hZgQ5VnOgWMITjGJAt/y4Fxt65ZHKL8Bz
 0lYX+cJ528tRTByBVm25LZeC1NKEuT1/0Sv4dctI/QmJDe0qft17EHpxEQNxEYB1HOxl
 2mqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQRRb5BJGas+4OYY3YlU9ugKwI880AukWth+AoWxVbLjklvDtkWzWXTl+LLKkvgfaGL0Y2LXWRRkj94ZHUiKEqYpIdQKTlkB8uXbBysw==
X-Gm-Message-State: AOJu0YxtUg4R6i2svtw08G/Jz/nI3JC7FB29F2B36bt2MHibWWkDUclL
 aW6FTtri6Wg+W6hNE6GIMF9k6gIu8/9ur6o5/HJ4hH6nXodXTrbN
X-Google-Smtp-Source: AGHT+IHjXHwM0DQvrEN9hr7nIKO7zvTEwkaEfRSdP9yPH2+xeWiTT+TN0538VHolDVwGypPIG2udMg==
X-Received: by 2002:a2e:3a15:0:b0:2e9:8ac8:b0c4 with SMTP id
 38308e7fff4ca-2e98ac8b11bmr8908581fa.49.1716907311388; 
 Tue, 28 May 2024 07:41:51 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08ab81sm11904171f8f.39.2024.05.28.07.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 07:41:50 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------rCWctXYjMxSJypZNHLWucRMH"
Message-ID: <ce34d2ad-8f0c-4b3f-b798-0967b7adcce7@gmail.com>
Date: Tue, 28 May 2024 16:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "Dong, Ruijing"
 <Ruijing.Dong@amd.com>, "Wu, David" <David.Wu3@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>
References: <20240523150439.3274992-1-David.Wu3@amd.com>
 <SJ1PR12MB6194DBE65CF492DA12ED5BE795F42@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <47f0ac94-d6cb-4632-9960-0f94832857be@amd.com>
 <SJ1PR12MB61942426002C44CC636AD5C295F42@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <BL1PR12MB51263D2BC502E2FCF5C7123DFDF42@BL1PR12MB5126.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <BL1PR12MB51263D2BC502E2FCF5C7123DFDF42@BL1PR12MB5126.namprd12.prod.outlook.com>
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
--------------rCWctXYjMxSJypZNHLWucRMH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Acked-by: Christian König <christian.koenig@amd.com>

Thanks,
Christian.

Am 23.05.24 um 19:11 schrieb Jiang, Sonny:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> The patch is Reviewed-by: Sonny Jiang <sonjiang@amd.com>
>
> Thanks,
> Sonny
>
> ------------------------------------------------------------------------
> *From:* Dong, Ruijing <Ruijing.Dong@amd.com>
> *Sent:* Thursday, May 23, 2024 12:58 PM
> *To:* Wu, David <David.Wu3@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>; Koenig, Christian 
> <Christian.Koenig@amd.com>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo 
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>
> *Subject:* RE: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Thanks for the response, and it looks good to me.
>
> Ruijing
>
> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Thursday, May 23, 2024 12:55 PM
> To: Dong, Ruijing <Ruijing.Dong@amd.com>; Wu, David 
> <David.Wu3@amd.com>; amd-gfx@lists.freedesktop.org; Koenig, Christian 
> <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo 
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
>
> please see in line.
>
> On 2024-05-23 12:02, Dong, Ruijing wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Please see my question inline below.
> >
> > Thanks,
> > Ruijing
> >
> > -----Original Message-----
> > From: Wu, David <David.Wu3@amd.com>
> > Sent: Thursday, May 23, 2024 11:05 AM
> > To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> > <Christian.Koenig@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo
> > <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing
> > <Ruijing.Dong@amd.com>
> > Subject: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
> >
> > We have messages when the VCN fails to initialize and there is no 
> need to report on success.
> > Also PSP loading FWs is the default for production.
> >
> > Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  |  1 -  
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  3 ---  
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +---------
> >   3 files changed, 1 insertion(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > index b89605b400c0..5e2b7c340724 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > @@ -1078,7 +1078,6 @@ void amdgpu_vcn_setup_ucode(struct 
> amdgpu_device *adev)
> >                              IP_VERSION(4, 0, 3))
> >                                  break;
> >                  }
> > -               dev_info(adev->dev, "Will use PSP to load VCN 
> firmware\n");
> >          }
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > index 64c856bfe0cb..68ef29bc70e2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> > @@ -145,8 +145,6 @@ static int jpeg_v5_0_0_hw_init(void *handle)
> >          if (r)
> >                  return r;
> >
> > -       DRM_DEV_INFO(adev->dev, "JPEG decode initialized 
> successfully.\n");
> > -
> >          return 0;
> >   }
> >
> > @@ -549,7 +547,6 @@ static const struct amdgpu_ring_funcs 
> jpeg_v5_0_0_dec_ring_vm_funcs = { static void 
> jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)  {
> > adev->jpeg.inst->ring_dec->funcs = &jpeg_v5_0_0_dec_ring_vm_funcs;
> > -       DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
> >   }
> >
> >   static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs = {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > index 36d4ca645c56..070b56610c7d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > @@ -200,16 +200,10 @@ static int vcn_v5_0_0_hw_init(void *handle)
> >
> >                  r = amdgpu_ring_test_helper(ring);
> >                  if (r)
> > -                       goto done;
> > +                       return r;
> >          }
> >   [Ruijing] Are we assuming the hw init process always be successful?
>
> No - it could fail with errors and in this case the top level will 
> report error. Otherwise it will succeed(and no need to report 
> successful message).
>
> David
>
> >          return 0;
> > -done:
> > -       if (!r)
> > -               DRM_INFO("VCN decode and encode initialized 
> successfully(under %s).\n",
> > -                       (adev->pg_flags & 
> AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
> > -
> > -       return r;
> >   }
> >
> >   /**
> > @@ -1122,8 +1116,6 @@ static void
> > vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
> >
> > adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
> > adev->vcn.inst[i].ring_enc[0].me = i;
> > -
> > -               DRM_INFO("VCN(%d) encode/decode are enabled in VM 
> mode\n", i);
> >          }
> >   }
> >
> > --
> > 2.34.1
> >

--------------rCWctXYjMxSJypZNHLWucRMH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Acked-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 23.05.24 um 19:11 schrieb Jiang,
      Sonny:<br>
    </div>
    <blockquote type="cite"
cite="mid:BL1PR12MB51263D2BC502E2FCF5C7123DFDF42@BL1PR12MB5126.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;"
        align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          The patch is Reviewed-by: Sonny Jiang <a class="moz-txt-link-rfc2396E" href="mailto:sonjiang@amd.com">&lt;sonjiang@amd.com&gt;</a></div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Thanks,</div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Sonny</div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Dong, Ruijing <a class="moz-txt-link-rfc2396E" href="mailto:Ruijing.Dong@amd.com">&lt;Ruijing.Dong@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, May 23, 2024 12:58 PM<br>
            <b>To:</b> Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Liu, Leo
            <a class="moz-txt-link-rfc2396E" href="mailto:Leo.Liu@amd.com">&lt;Leo.Liu@amd.com&gt;</a>; Jiang, Sonny
            <a class="moz-txt-link-rfc2396E" href="mailto:Sonny.Jiang@amd.com">&lt;Sonny.Jiang@amd.com&gt;</a><br>
            <b>Subject:</b> RE: [PATCH] drm/amdgpu: drop some kernel
            messages in VCN code</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="3" face="Times New Roman"><span
              style="font-size:12pt;"><a name="BM_BEGIN"
                moz-do-not-send="true"></a>
              <div><font size="2"><span style="font-size:11pt;">[AMD
                    Official Use Only - AMD Internal Distribution Only]<br>
                    <br>
                    Thanks for the response, and it looks good to me.<br>
                    <br>
                    Ruijing<br>
                    <br>
                    -----Original Message-----<br>
                    From: Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a><br>
                    Sent: Thursday, May 23, 2024 12:55 PM<br>
                    To: Dong, Ruijing <a class="moz-txt-link-rfc2396E" href="mailto:Ruijing.Dong@amd.com">&lt;Ruijing.Dong@amd.com&gt;</a>; Wu,
                    David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Koenig, Christian
                    <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
                    Cc: Deucher, Alexander
                    <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Liu, Leo
                    <a class="moz-txt-link-rfc2396E" href="mailto:Leo.Liu@amd.com">&lt;Leo.Liu@amd.com&gt;</a>; Jiang, Sonny
                    <a class="moz-txt-link-rfc2396E" href="mailto:Sonny.Jiang@amd.com">&lt;Sonny.Jiang@amd.com&gt;</a><br>
                    Subject: Re: [PATCH] drm/amdgpu: drop some kernel
                    messages in VCN code<br>
                    <br>
                    please see in line.<br>
                    <br>
                    On 2024-05-23 12:02, Dong, Ruijing wrote:<br>
                    &gt; [AMD Official Use Only - AMD Internal
                    Distribution Only]<br>
                    &gt;<br>
                    &gt; Please see my question inline below.<br>
                    &gt;<br>
                    &gt; Thanks,<br>
                    &gt; Ruijing<br>
                    &gt;<br>
                    &gt; -----Original Message-----<br>
                    &gt; From: Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a><br>
                    &gt; Sent: Thursday, May 23, 2024 11:05 AM<br>
                    &gt; To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Koenig,
                    Christian<br>
                    &gt; <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
                    &gt; Cc: Deucher, Alexander
                    <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Liu, Leo<br>
                    &gt; <a class="moz-txt-link-rfc2396E" href="mailto:Leo.Liu@amd.com">&lt;Leo.Liu@amd.com&gt;</a>; Jiang, Sonny
                    <a class="moz-txt-link-rfc2396E" href="mailto:Sonny.Jiang@amd.com">&lt;Sonny.Jiang@amd.com&gt;</a>; Dong, Ruijing<br>
                    &gt; <a class="moz-txt-link-rfc2396E" href="mailto:Ruijing.Dong@amd.com">&lt;Ruijing.Dong@amd.com&gt;</a><br>
                    &gt; Subject: [PATCH] drm/amdgpu: drop some kernel
                    messages in VCN code<br>
                    &gt;<br>
                    &gt; We have messages when the VCN fails to
                    initialize and there is no need to report on
                    success.<br>
                    &gt; Also PSP loading FWs is the default for
                    production.<br>
                    &gt;<br>
                    &gt; Signed-off-by: David (Ming Qiang) Wu
                    <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a><br>
                    &gt; ---<br>
                    &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  |  1
                    -  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  3
                    ---  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10
                    +---------<br>
                    &gt;   3 files changed, 1 insertion(+), 13
                    deletions(-)<br>
                    &gt;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
                    &gt; index b89605b400c0..5e2b7c340724 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
                    &gt; @@ -1078,7 +1078,6 @@ void
                    amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)<br>
                    &gt;                              IP_VERSION(4, 0,
                    3))<br>
                    &gt;                                  break;<br>
                    &gt;                  }<br>
                    &gt; -               dev_info(adev-&gt;dev, "Will
                    use PSP to load VCN firmware\n");<br>
                    &gt;          }<br>
                    &gt;   }<br>
                    &gt;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c<br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c<br>
                    &gt; index 64c856bfe0cb..68ef29bc70e2 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c<br>
                    &gt; @@ -145,8 +145,6 @@ static int
                    jpeg_v5_0_0_hw_init(void *handle)<br>
                    &gt;          if (r)<br>
                    &gt;                  return r;<br>
                    &gt;<br>
                    &gt; -       DRM_DEV_INFO(adev-&gt;dev, "JPEG decode
                    initialized successfully.\n");<br>
                    &gt; -<br>
                    &gt;          return 0;<br>
                    &gt;   }<br>
                    &gt;<br>
                    &gt; @@ -549,7 +547,6 @@ static const struct
                    amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = { 
                    static void jpeg_v5_0_0_set_dec_ring_funcs(struct
                    amdgpu_device *adev)  {<br>
                    &gt;         
                    adev-&gt;jpeg.inst-&gt;ring_dec-&gt;funcs =
                    &amp;jpeg_v5_0_0_dec_ring_vm_funcs;<br>
                    &gt; -       DRM_DEV_INFO(adev-&gt;dev, "JPEG decode
                    is enabled in VM mode\n");<br>
                    &gt;   }<br>
                    &gt;<br>
                    &gt;   static const struct amdgpu_irq_src_funcs
                    jpeg_v5_0_0_irq_funcs = {<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<br>
                    &gt; index 36d4ca645c56..070b56610c7d 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c<br>
                    &gt; @@ -200,16 +200,10 @@ static int
                    vcn_v5_0_0_hw_init(void *handle)<br>
                    &gt;<br>
                    &gt;                  r =
                    amdgpu_ring_test_helper(ring);<br>
                    &gt;                  if (r)<br>
                    &gt; -                       goto done;<br>
                    &gt; +                       return r;<br>
                    &gt;          }<br>
                    &gt;   [Ruijing] Are we assuming the hw init process
                    always be successful?<br>
                    <br>
                    No - it could fail with errors and in this case the
                    top level will report error. Otherwise it will
                    succeed(and no need to report successful message).<br>
                    <br>
                    David<br>
                    <br>
                    &gt;          return 0;<br>
                    &gt; -done:<br>
                    &gt; -       if (!r)<br>
                    &gt; -               DRM_INFO("VCN decode and encode
                    initialized successfully(under %s).\n",<br>
                    &gt; -                       (adev-&gt;pg_flags
                    &amp; AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG
                    Mode");<br>
                    &gt; -<br>
                    &gt; -       return r;<br>
                    &gt;   }<br>
                    &gt;<br>
                    &gt;   /**<br>
                    &gt; @@ -1122,8 +1116,6 @@ static void<br>
                    &gt; vcn_v5_0_0_set_unified_ring_funcs(struct
                    amdgpu_device *adev)<br>
                    &gt;<br>
                    &gt;                 
                    adev-&gt;vcn.inst[i].ring_enc[0].funcs =
                    &amp;vcn_v5_0_0_unified_ring_vm_funcs;<br>
                    &gt;                 
                    adev-&gt;vcn.inst[i].ring_enc[0].me = i;<br>
                    &gt; -<br>
                    &gt; -               DRM_INFO("VCN(%d) encode/decode
                    are enabled in VM mode\n", i);<br>
                    &gt;          }<br>
                    &gt;   }<br>
                    &gt;<br>
                    &gt; --<br>
                    &gt; 2.34.1<br>
                    &gt;<br>
                  </span></font></div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------rCWctXYjMxSJypZNHLWucRMH--
