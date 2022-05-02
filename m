Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701D3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 16:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F32EC10F086;
	Mon,  2 May 2022 16:57:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E4310F086
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651510635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0Gq4g+r6nSFFN2UMiOU7agj8frQhJOC3wt5ScKN4WI=;
 b=VVwzwO59SzS0+Lzj+SrIY/Auhq1cFya02SAB75l5ytIZFavMtdZ09zH3GfXkCMZ+5fA8yp
 lFxlfbUH2uqedBLECNtfrR8u/AliTr/B7CVQdQj3aCh2w1576vxZliTQkWc4tQ4Ix5KKH6
 WbbKGAAfgm2ezWaVJ5dpSLKMFT/A4a4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-2pLqjvsQOneXrGffAIY4KQ-1; Mon, 02 May 2022 12:57:07 -0400
X-MC-Unique: 2pLqjvsQOneXrGffAIY4KQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 n186-20020a1c27c3000000b00392ae974ca1so122724wmn.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 May 2022 09:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=K0Gq4g+r6nSFFN2UMiOU7agj8frQhJOC3wt5ScKN4WI=;
 b=uFzMclCF9qknsYTiVnUhZNn8agU2H6xw8Gu6N/fCV/p6MyMiU1YchRuDucHmc2+Mwo
 GZrbfAHxBUi3s+myo/2QgnEYQ82xjjoBjECRxW750+uSWBwYkS9CZ/zk8ggyHtwxRf0F
 xSocHlEkIEuPNrQepvmwEfaZA6BhK8tpW8nI5a45+TCE/IDlZenUscGNGmdugnEE+g/R
 cNCrB6+2Xky5sdrJX8aGCH10RTl7xbGp1ojPK0pok5fBaxdV8LyXSg5xQyfBwXOEx/vO
 PlYLi9BbPvvAOhD6E09TeW8o/KaGqErNONNC5M7XJFdOGfmdLFyqZj61RSP2PHwoQU3M
 zCkg==
X-Gm-Message-State: AOAM533qiZC2AkEkwBxwDL88Fn70uSsmwL6N6HeCJIb7LyksJQmJcHbc
 m4JxHg+EvU8wGH1lwO9RYFnNgGGZhonI7DlKhLosSNbWx4yZVyhmo++KpLOLHsM75qCBklo2B79
 dpV5g6rUf7gBFfXBq9/jsOQpUbQ==
X-Received: by 2002:a05:600c:4f08:b0:391:fe3c:40e6 with SMTP id
 l8-20020a05600c4f0800b00391fe3c40e6mr78539wmq.34.1651510626175; 
 Mon, 02 May 2022 09:57:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBR5y6TmCRfu+8hzM0SQTGA4cZrpN3ZhuFriWyFUH2mb/ZbNn3olE2yOJI8bAuj+96a04yXQ==
X-Received: by 2002:a05:600c:4f08:b0:391:fe3c:40e6 with SMTP id
 l8-20020a05600c4f0800b00391fe3c40e6mr78523wmq.34.1651510625948; 
 Mon, 02 May 2022 09:57:05 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
 by smtp.gmail.com with ESMTPSA id
 r20-20020adfa154000000b0020c5253d8c7sm7273243wrr.19.2022.05.02.09.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 May 2022 09:57:05 -0700 (PDT)
Message-ID: <ac202e93-cde2-99fa-5aca-abdc1cf6a3bf@redhat.com>
Date: Mon, 2 May 2022 18:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/3] drm/fb-helper: Rename preferred_bpp
 drm_fbdev_generic_setup() parameter
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-3-javierm@redhat.com>
 <YnABz/4haOHe66Do@pendragon.ideasonboard.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnABz/4haOHe66Do@pendragon.ideasonboard.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: linux-aspeed@lists.ozlabs.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-mediatek@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, spice-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/2/22 18:07, Laurent Pinchart wrote:
> Hi Javier,
> 
> Thank you for the patch.
> 
> On Mon, May 02, 2022 at 05:38:59PM +0200, Javier Martinez Canillas wrote:
>> By default the bits per pixel for the emulated framebuffer device is set
>> to dev->mode_config.preferred_depth, but some devices need another value.
>>
>> Since this second parameter is only used by a few drivers, and to allow
>> drivers to use it for passing other configurations when registering the
>> fbdev, rename @preferred_bpp to @options and make it a multi-field param.
>>
>> The DRM_FB_OPTION() and DRM_FB_GET_OPTION() macros are provided to drivers
>> for computing options bitfield values and getting the values respectively
>>
>> For now, only the DRM_FB_BPP option exists but other options can be added.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> ---
>>
>> Changes in v2:
>> - Rename DRM_FB_SET_OPTION() to DRM_FB_SET() and make more clear in the
> 
> I assume you meant DRM_FB_OPTION() here, not DRM_FB_SET().
> 
>>   kernel-doc what this macro does (Laurent Pinchart).
>>

Right, that's a typo. The patch description and content are correct though.

I'll fix the patch history log in v3.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

