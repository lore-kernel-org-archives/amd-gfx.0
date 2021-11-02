Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 07:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC9560F02
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 07:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABC9560F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6434688D39;
	Tue,  2 Nov 2021 07:36:01 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77ED088D39
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 07:36:00 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id y196so5619688wmc.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Nov 2021 00:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kNrWrHSUOA282X+VoevDQuYTlATLBNn8oQC/2+dY/zc=;
 b=mWFC/HBVsoH8OfIH1Abb+CBonhUHR/P+lmbPtBkosvmnGXMKyTuD1KWTWc00IpfZl7
 sFtpgE2oKjtDL4ayrl8fdN8hT1B8All4Mzob5D7Xs7SXet0lbRnNmDh4rrAq87OGjAB/
 HFtP9bEDKodXJh1zPovNbvXai/Abju7k604D5CFXvV86TVR1swMcA5l+XQO1svEKFu97
 kTUKQMLTIl7iOcsLrnfsHCzIQXwXgQDZpmfzhk1KAfluTnlP5WRdAsrXIYOSrGPrybfS
 +jFLzKtWWnZZKdpMTwh5vDTP1qrbH6YT/VnSaG15e/DgbqSPWn9hHXiVnAZ1/b8j+8k4
 zlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kNrWrHSUOA282X+VoevDQuYTlATLBNn8oQC/2+dY/zc=;
 b=dd3ksWp+gkqb5vyeqiSIGqxPZDW9C2RA8TW86gci3mqhJ1us/G2c43z0a8jXTS7T1O
 T+NuK8U6YY0dtI4tnCOEbazS5W3Rgw+YDzbrG/qUTUEsNkitrIkU+Vh6EbyXR35Y6q96
 oIW8vhVICcjw3Rk+XaAzt2cZDFb9qKZQM6/7kXZDWSM4RNmc+NHcGvlrFPP+/Lf6GZwe
 PSXD5DS3srGIWtwTTxu3emV0vF+aMIg1EG0JMqjSkO9CchtXAeB7WShR4wQK38glxMpv
 4K3EoFnckeTzBdOguzM3oDtE2uP9CxKx0wCf92HwMBevEeGLdziV9LM0pRg26lquPNzA
 ZyKQ==
X-Gm-Message-State: AOAM53014Wq2AR4GBrMbW+WvfW/Jrkbkt8y+qE3r28WZQ0aZbIk1+mjB
 fUoFkJ0iN4MAEez7rc0NBcioxucYAMk=
X-Google-Smtp-Source: ABdhPJyCxSLUc36SlsdLehZ/VQKQOAvasOmFdgJCKVZwGApbFUtpf5DDMsLNzCr6ConNaw1td671Lg==
X-Received: by 2002:a05:600c:21c3:: with SMTP id
 x3mr4984633wmj.13.1635838558799; 
 Tue, 02 Nov 2021 00:35:58 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:2746:f022:81db:a2f4?
 ([2a02:908:1252:fb60:2746:f022:81db:a2f4])
 by smtp.gmail.com with ESMTPSA id i15sm1564303wmb.20.2021.11.02.00.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 00:35:58 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: return early on error while setting bar0
 memtype
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211029150917.4462-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d617fcad-c6b1-0e04-6065-4961f80f34a3@gmail.com>
Date: Tue, 2 Nov 2021 08:35:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211029150917.4462-1-nirmoy.das@amd.com>
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 29.10.21 um 17:09 schrieb Nirmoy Das:
> We set WC memtype for aper_base but don't check return value
> of arch_io_reserve_memtype_wc(). Be more defensive and return
> early on error.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 073ba2af0b9c..6b25982a9077 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1032,9 +1032,14 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>   	/* On A+A platform, VRAM can be mapped as WB */
>   	if (!adev->gmc.xgmi.connected_to_cpu) {
>   		/* reserve PAT memory space to WC for VRAM */
> -		arch_io_reserve_memtype_wc(adev->gmc.aper_base,
> +		int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>   				adev->gmc.aper_size);
>   
> +		if (r) {
> +			DRM_ERROR("Unable to set WC memtype for the aperture base\n");

Drop the word "base" and rather write "VRAM aperture".

With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> +			return r;
> +		}
> +
>   		/* Add an MTRR for the VRAM */
>   		adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
>   				adev->gmc.aper_size);

