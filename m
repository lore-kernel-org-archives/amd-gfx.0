Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C70C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Dec 2022 19:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFBA10E086;
	Tue, 27 Dec 2022 19:23:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B2B10E07E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 19:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672169016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7dbgHTngiyfazSG5sXwLfx+o+WyMctqSvzgKNLu/LU=;
 b=VGJ5D2oJ1eMRR5uUmYCTNAPQPvJgM16r3VfRnTxFpZmbrYmD1+fNEEnWqECkG8ffCMNPUo
 7f1YfbdKj/+UwbReUwiODDPsKXOBBqXVKxXDCq7nJnR0Ws/fjRexsG/BkgIV4lPMwFVT2S
 8xvK+t6XwsFKFjn7oswVkgc2G+hX9Sg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-1-A7NDPRPWyxe69BsSZzIQ-1; Tue, 27 Dec 2022 14:23:35 -0500
X-MC-Unique: 1-A7NDPRPWyxe69BsSZzIQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 l31-20020a05600c1d1f00b003d9720d2a0eso6179668wms.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 11:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y7dbgHTngiyfazSG5sXwLfx+o+WyMctqSvzgKNLu/LU=;
 b=nfTt5EUipn//IdwctXh9Vij8Nq+xgqvB9qv6MhWZkq2N1Nc+R+arLknRXgRw5r8U9P
 jxtGuhGMlBd4IZzhTQ+kn5C4sTvFqKKrg5Mhl8Gk8Ax2ngFWxusgJu07KVa0TQmZCr7r
 tGQYMLz5YJ0uIu5qUgqLOZ+FHE44wM1GHNVeZaVNClC6oL8AO+KyrVRW6UMC2y9HszR0
 X7dGY/0qJLp7q0JM9ZsqFuAyYrLbf/lNdyUZ6aJn+2TzjzrQmHTRK3rXRvF5rt+earhS
 hfwNZ4VmMblNGv/XAhBuvH2x+HmgikKB5b1Qe9mqvRjv9UW961ZUZXgw7C/WQB3tFoPR
 Bdsg==
X-Gm-Message-State: AFqh2kpD4xtOf7YJNGgKDqyiZb443MNDuc1AYeNwyd88OAmn691kaNJE
 iQUjdJgSVcJvzHoFlYn45Do0//Hhfqfvq5prywGw9TrO2UcEqj4zRrtnyZhKc73ocwMeQ89O5hq
 4OHeKe7y49c3FLNIiGbSB99sg6w==
X-Received: by 2002:a05:600c:3b90:b0:3d1:f0f1:ceb4 with SMTP id
 n16-20020a05600c3b9000b003d1f0f1ceb4mr16025412wms.19.1672169014395; 
 Tue, 27 Dec 2022 11:23:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXva0B2UHKhAop8zDawG+uzkPkYfVViqdOdvS3DOeaUVR1+zQGk160j5uLhQYZ6Be0X+v85V8g==
X-Received: by 2002:a05:600c:3b90:b0:3d1:f0f1:ceb4 with SMTP id
 n16-20020a05600c3b9000b003d1f0f1ceb4mr16025401wms.19.1672169014169; 
 Tue, 27 Dec 2022 11:23:34 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 q20-20020a1ce914000000b003b4935f04a4sm21286147wmc.5.2022.12.27.11.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Dec 2022 11:23:33 -0800 (PST)
Message-ID: <9911d249-ccc0-7724-b0bc-17bcf2a524e8@redhat.com>
Date: Tue, 27 Dec 2022 20:23:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] Recover from failure to probe GPU
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20221222183012.1046-1-mario.limonciello@amd.com>
 <2761b1e1-508d-2c2c-f2d8-6f1be536723e@suse.de>
 <f9b40837-ee2b-76fb-0ec1-d7dfda4ffb7e@amd.com>
 <CADnq5_M42GQhVquw5BM+P-6NKmdZ6yj8czq=s5iXVAmVOexAkw@mail.gmail.com>
 <CADnq5_OLf3VhFZm7=riDm9ezVT9j9nQ5Fwei3budnqPt5C4t9Q@mail.gmail.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CADnq5_OLf3VhFZm7=riDm9ezVT9j9nQ5Fwei3budnqPt5C4t9Q@mail.gmail.com>
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
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Carlos Soriano Sanchez <csoriano@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Alex,

On 12/27/22 18:04, Alex Deucher wrote:

[...]

> 
> I think something like this would do the trick:
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2017b3466612..45aee27ab6b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2141,6 +2141,11 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>                 break;
>         }
> 
> +       /* Get rid of things like offb */
> +       r = drm_aperture_remove_conflicting_pci_framebuffers(pdev,
> &amdgpu_kms_driver);
> +       if (r)
> +               return r;
> +
>         if (amdgpu_has_atpx() &&
>             (amdgpu_is_atpx_hybrid() ||
>              amdgpu_has_atpx_dgpu_power_cntl()) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b8cfa48fb296..4e74d7abc3c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2123,11 +2123,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>         }
>  #endif
> 
> -       /* Get rid of things like offb */
> -       ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev,
> &amdgpu_kms_driver);
> -       if (ret)
> -               return ret;
> -

I'm not familiar with the amdgpu driver but yes, something like that
is what I had in mind.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

