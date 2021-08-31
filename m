Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920C3C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 06:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A6660FD8
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 06:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61A6660FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7834889B98;
	Tue, 31 Aug 2021 06:19:06 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B537F89B69
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 06:19:04 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id u9so25660790wrg.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 23:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Ecm1RWI6ljc2drfBz44LtUpb1AwRDuIqWia7EGbP42w=;
 b=LTLoOCXd16fyS50dRC1INMu0WkSfvQ7yT8IIjCI6a+0RQ/3rNOWrRgCJQ+zosO4lpU
 W/RD/x3/oSpA46mDx62NPAGE0b+Y13PZ1lvc/S0uLCix5voNYmBHEs8FYGLEZJUVAKBi
 AVhk5sDe1TEMl4PvJrMOOvurPbYZnHNu/F5RyDGo+FzzrGzLU4SJS1G/5p1Q1tO2vZUR
 K1KJ5ai61Vgnb29A8w4p/zgxV4YRoujDdqUvsGDMHoMCNRgqas6A2uud9g8vAW20Wt4R
 j/aRF/jP9JktYjJ1aTp569gQb2k0CaGLvlNufSq1MgG6UAAUAr90k8riFx0OM1HvnBed
 QWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Ecm1RWI6ljc2drfBz44LtUpb1AwRDuIqWia7EGbP42w=;
 b=tCrrlla8WTIboG7rwst3e3k6AujfTxbZI8DZ/iraXe+25kJHXK+wp7BGDGi2JKu2Tt
 lgqZ8HbD7v8qSfIWg2ZHgSQDIM60a4pAZ5HwWadmI359IDLGQEW7HmHo31FHqSmYdpHw
 RkVp80wU19FJdd7ae4cbxxzTSrsA2k9pFEjJlBwdU0X777k9HfABlJWoJSXJ3yf/nNF4
 NvioIDLrjtP9RlwCd0ipLSlmkTbHQzaqTS7/H9jGwbVsTGb0wHcxbuAhd56xJbTs85te
 wQxLyB0H5RzbnkmKqVw/ZFSxmRuPFL0m2rxdQmEkK/1+C2zk8fXN2sbaqa88J15Uztp5
 KV7w==
X-Gm-Message-State: AOAM531Sso7y7HPE2JvGV7OCfLG8p69G4lEtm9vgsjnuSiJutpeizVqa
 kU0MlQtCrm9KVvzbVbCYUwk=
X-Google-Smtp-Source: ABdhPJwHuyC+YYosQa4ax1hdOlGk98dMjMmYIi5vNsm+nMt/mh/Osdj1yJvm20FnXEe9+RzVbB/Kvw==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr29166473wrn.365.1630390743375; 
 Mon, 30 Aug 2021 23:19:03 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id v28sm17238559wrv.93.2021.08.30.23.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Aug 2021 23:19:02 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <DM4PR12MB5165AFECE854E6A4E82A05DF87CC9@DM4PR12MB5165.namprd12.prod.outlook.com>
 <0a52e64c-c5c7-ab65-4370-94374e2d0458@amd.com>
 <C4E7B450-18FA-4DA3-9AED-FCA03A24B279@amd.com>
 <9AE27401-DFDB-44C1-86BE-064F3378D5D5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <72e03423-461c-c6c9-e1f4-84d185cf3ab4@gmail.com>
Date: Tue, 31 Aug 2021 08:19:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9AE27401-DFDB-44C1-86BE-064F3378D5D5@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Am 31.08.21 um 07:47 schrieb Pan, Xinhui:
>
> ﻿在 2021/8/31 13:38，“Pan, Xinhui”<Xinhui.Pan@amd.com> 写入:
>
>      
>      
>      在 2021/8/31 12:03，“Grodzovsky, Andrey”<Andrey.Grodzovsky@amd.com> 写入:
>      
>          
>          On 2021-08-30 11:24 p.m., Pan, Xinhui wrote:
>          > [AMD Official Use Only]
>          >
>          > [AMD Official Use Only]
>          >
>          > Unreserve root BO before return otherwise next allocation got deadlock.
>          >
>          > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>          > ---
>          >   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++++------
>          >   1 file changed, 5 insertions(+), 6 deletions(-)
>          >
>          > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>          > index 85b292ed5c43..c9db7d2c5816 100644
>          > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>          > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>          > @@ -355,19 +355,18 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>          >                          DRM_DEBUG("Failed to allocate GEM object (%llu, %d, %llu, %d)\n",
>          >                                    size, initial_domain, args->in.alignment, r);
>          >                  }
>          > +
>          > +               if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
>          > +                       amdgpu_bo_unreserve(vm->root.bo);
>          >                  return r;
>          >          }
>          >
>          >          if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>          > -               if (!r) {
>          > -                       struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
>          > +               struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
>          >
>          > -                       abo->parent = amdgpu_bo_ref(vm->root.bo);
>          > -               }
>          > +               abo->parent = amdgpu_bo_ref(vm->root.bo);
>          >                  amdgpu_bo_unreserve(vm->root.bo);
>          >          }
>          > -       if (r)
>          > -               return r;
>          
>          
>          The above early return seems to be needed for -ERESTARTSYS case.
>          
>          Andrey
>      
>      There are two returns. ERESTARTSYS and other error after retry are already handled by the first return in if {}. So the second return is not needed.
>      
>      Thanks
>      Xinhui
>
> Also we can do something like below which is simpler.

Yeah, I think that would be better. We could also change the "if (r) { 
if (r != -ERESTARTSYS) {" into just "if (r != -ERESTARTSYS)" then.

But good catch anyway.

Regards,
Christian.

> @@ -355,7 +355,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>                          DRM_DEBUG("Failed to allocate GEM object (%llu, %d, %llu, %d)\n",
>                                    size, initial_domain, args->in.alignment, r);
>                  }
> -               return r;
>          }
>   
>          if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>   
>          
>          >
>          >          r = drm_gem_handle_create(filp, gobj, &handle);
>          >          /* drop reference from allocate - handle holds it now */
>          > --
>          > 2.25.1
>          
>      
>      
>

