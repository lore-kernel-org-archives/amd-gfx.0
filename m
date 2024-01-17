Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA97C47422
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 06:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D20410E039;
	Wed, 17 Jan 2024 06:59:43 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C010110E039
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 06:59:42 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-40e8ca164f0so159665e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 22:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705474721; x=1706079521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n+vESr5oks4iAf3ykQE/gfdlS3G+JXAN0IhMoqbaqng=;
 b=Nft7MELlAph7yPZGjKAGKx8CF57oSlCcyS4siWEXgOP++fPiClWCTuxqxyZEaBdEJt
 YISJ1jALARdQJ3gTztfb2JcW3FpSRpJ43O8lhr2CkfAinyU7522zAxAbTPaY3RymbY4X
 C6k6sXZI5hz9Y3AMm/OHRsQFUSoWcgdrshHI5GQfx49Sk9PaRnGWZpFNWvkIUlQq22/x
 PbJqeu9Og8LYCfhDtSVBPnaecLVeKfV7B8BRPS3oppT4n8QyzMCvg3+FsbWC56FVuTx6
 xkxzfNhmhXEzq1f8wETlm7d1SEuJXVRmpVAGL2f6gTLcfs35ppcLfwWgrz8gS5K6K1cE
 8VDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705474721; x=1706079521;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n+vESr5oks4iAf3ykQE/gfdlS3G+JXAN0IhMoqbaqng=;
 b=MvED+ZWojjOq69179kPdwWkfCk1mGpObmimpzxN7P9Br17IKRuhVKXzjURhzijA4lp
 Jj25zsq9GyT8RbQ9HpEnPCnhzWeDSy3ZcHBl3BR9Omf4llrIn8JQmWJQveoiOUFatycT
 Mb1H1FQ8cbgCDJDVxWjW1aVAcG5FG0QiEGvD6WiWpE20JXcz5Q7BWzXy2vq+Tm9zIHsb
 TYZVuQuepVsRAP9Et1rI0o4zp9+ofkA+ICJpIGGj4+4qhwhslfo36jsqOrUrGcEQWsKi
 EpYO+oqz9nYr+YTFnghc1hp/G6+PdZ7IO02ZjJOshsnXxaLKqM8I77bvDr/Zn74If6CZ
 MrzQ==
X-Gm-Message-State: AOJu0YwWPZfEw3KoT480j5JJwl4h2/IGoZZ/OFXzlinrFhtf38vio8KF
 8cNwe0wKZR1Vl5usVf362gQ/Mmn4xEZCMw==
X-Google-Smtp-Source: AGHT+IHV8tku3mcC43yORV+wTPQpHyoiGZD9bpB7nyzW8K5DeYoeqSjK74Uvn40AWPzksoLt18k/fg==
X-Received: by 2002:a7b:cd87:0:b0:40e:75e5:4e70 with SMTP id
 y7-20020a7bcd87000000b0040e75e54e70mr2767702wmj.166.1705474721045; 
 Tue, 16 Jan 2024 22:58:41 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c358a00b0040e559e0ba7sm25053453wmq.26.2024.01.16.22.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 22:58:40 -0800 (PST)
Message-ID: <c67fa6a6-5608-42cd-8568-e8a8d080726b@gmail.com>
Date: Wed, 17 Jan 2024 07:58:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: only remove existing FBs for devices with
 displays
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240116143914.2991405-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240116143914.2991405-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 16.01.24 um 15:39 schrieb Alex Deucher:
> Seems calling drm_aperture_remove_conflicting_pci_framebuffers()
> will take away the apertures for unrelated devices on some kernel
> versions.  E.g., calling this on a PCIe accelerator with no display
> IP may take the apertures away from the actual PCIe display adapter
> on the system, breaking efifb, depending on the kernel version.
>
> Just do this if there is display IP present.

I would have checked the PCI device type instead, because a system BIOS 
most likely has no idea that a VGA device doesn't has a connector.

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62772b58ef3d..353c38f008e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4056,10 +4056,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   	amdgpu_device_set_mcbp(adev);
>   
> -	/* Get rid of things like offb */
> -	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
> -	if (r)
> -		return r;
> +	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {

This certainly worth a comment why we do this.

Apart from that I'm not sure we should upstream this, the customer 
kernel is most likely just missing this fix here:

commit 5ae3716cfdcd286268133867f67d0803847acefc
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu Apr 6 15:21:07 2023 +0200

     video/aperture: Only remove sysfb on the default vga pci device

     Instead of calling aperture_remove_conflicting_devices() to remove the
     conflicting devices, just call to aperture_detach_devices() to detach
     the device that matches the same PCI BAR / aperture range. Since the
     former is just a wrapper of the latter plus a sysfb_disable() call,
     and now that's done in this function but only for the primary devices.

     This fixes a regression introduced by commit ee7a69aa38d8 ("fbdev:
     Disable sysfb device registration when removing conflicting FBs"),
     where we remove the sysfb when loading a driver for an unrelated pci
     device, resulting in the user losing their efifb console or similar.

     Note that in practice this only is a problem with the nvidia blob,
     because that's the only gpu driver people might install which does not
     come with an fbdev driver of it's own. For everyone else the real gpu
     driver will restore a working console.

     Also note that in the referenced bug there's confusion that this same
     bug also happens on amdgpu. But that was just another amdgpu specific
     regression, which just happened to happen at roughly the same time and
     with the same user-observable symptoms. That bug is fixed now, see
     https://bugzilla.kernel.org/show_bug.cgi?id=216331#c15

Regards,
Christian.

> +		/* Get rid of things like offb */
> +		r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
> +		if (r)
> +			return r;
> +	}
>   
>   	/* Enable TMZ based on IP_VERSION */
>   	amdgpu_gmc_tmz_set(adev);

