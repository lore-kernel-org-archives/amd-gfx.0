Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A18C10F1E
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6295810E362;
	Tue, 20 Dec 2022 09:40:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D203E10E362
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671529233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
 b=DhiHk/HyImR4HtOMcFN2LQsGDLUfzWRwh3sFdcTSOXC1iJq7ca4jlIQNnXv1idjBWtUnKP
 IOOySZuIBlswiIhQ7Zj5LMjCwJEspwvGbdp4Q6uBkUk9hverLhJ51jx3ipewVNL1569JWy
 BztCJxnbz4qb3FNgdCDwlF4NWX9JRBM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-0hBUb8yOMyG1iDBXbKHf8g-1; Tue, 20 Dec 2022 04:40:32 -0500
X-MC-Unique: 0hBUb8yOMyG1iDBXbKHf8g-1
Received: by mail-wm1-f72.google.com with SMTP id
 n8-20020a05600c294800b003d1cc68889dso2402236wmd.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
 b=uv1T8gjKJR3/jnvxwmcWb0ao6GZKcPN378guSzc0vfqgJHs9wC6hHQQCr9o5nrTabU
 C6Vi14GqQrtA8Mnb/QX1Po06r63LfnqDHl97K5MTfN6R6fJgqqTpf2jQvQlsjtLDE/ZE
 EoSKI0e9pw9HdlfijZMyhpkD5XtNhajEQv4cqXKay7e53TlqzY1LK3/+1d4EYBsq3J1l
 C4SyFlZqS6/FR/+VY8NYAybSq0O/HzM7DHlIsWp4ckRDbXOA2CbO+YAsaw6wkyuV7g8Z
 /rcAnvmNurv356FPxLy0eWrGjyr9aOFCGFvkAB+wECvsIsVMgX0qcfCbh5J1SN57PO1r
 Fmbw==
X-Gm-Message-State: ANoB5pkbIJ+mEN1aJXiZWmrtHG7ZMVwJTGR+aize6sfmlMCR9AlYAVG6
 SeoW7Vx73ENuvClXDQbzaSI4Dkgh/Cb120zH3WsCjKuyq2DcRGPW8II8rR0oYhQHU35rPWNMihI
 sLDjuz/UgFmIr+8WZs/GvKIMLAg==
X-Received: by 2002:a05:600c:1c14:b0:3d0:965f:63ed with SMTP id
 j20-20020a05600c1c1400b003d0965f63edmr33960392wms.23.1671529231163; 
 Tue, 20 Dec 2022 01:40:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf71wOlxFtTuSNW/9jMXBnVwUZwb2b/kuKlWfvoG3RUuoMrRINee90ZtVa/GrwK8ITxjbcPFuQ==
X-Received: by 2002:a05:600c:1c14:b0:3d0:965f:63ed with SMTP id
 j20-20020a05600c1c1400b003d0965f63edmr33960383wms.23.1671529230999; 
 Tue, 20 Dec 2022 01:40:30 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 p2-20020a05600c358200b003d1f2c3e571sm24392373wmq.33.2022.12.20.01.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:40:30 -0800 (PST)
Message-ID: <1dd11b16-bf9d-4b86-14c7-095804a2f66d@redhat.com>
Date: Tue, 20 Dec 2022 10:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 14/18] fbdev/simplefb: Do not use struct fb_info.apertures
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-15-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-15-tzimmermann@suse.de>
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
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Acquire ownership of the firmware scanout buffer by calling Linux'
> aperture helpers. Remove the use of struct fb_info.apertures and do
> not set FBINFO_MISC_FIRMWARE; both of which previously configured
> buffer ownership.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

