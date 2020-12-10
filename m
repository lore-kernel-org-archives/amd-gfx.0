Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5B7C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 10:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C986222DA9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 10:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C986222DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A5D89D99;
	Thu, 10 Dec 2020 10:04:52 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED8289D99
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 10:04:50 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id ga15so6491148ejb.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 02:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aokATj+RVS/JVJll7haF26+6Bec4r5BXG0sPiBm5HWY=;
 b=dCUhbUM0I7Na+Ruxlm9Ab8J+Lt8MDfm3ZYjY8HIphQZCMijPGGQn5djkYmU9CnBx+U
 04EhxRm6UenDcJ3rGNpQUv6heF+mqt+Vg2lnuyp9kh6Axx5i+SuAqeVNXqxWfU0hBfjj
 cIYsKGFO9kshJKqI16Rw7zFhBtXjisvQ3+1jZqYfNVydofRfpJu2jX0yzC70Q0e1EYuG
 IISVhKP0I+YcM5qnoYdm74idckebLRAbCsHYHWxlbQPeZV8chGHmyBXPrxWgwLJri8+/
 qrnYfNBW3WxxipKUr8NX3rrDFYMgr6t4ME8RsYXY7MKHkbHQysQQJtQXTteCs9PLwikn
 Jxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=aokATj+RVS/JVJll7haF26+6Bec4r5BXG0sPiBm5HWY=;
 b=pi/8rmibbO4i646+nJf3mAolJ/RbV5tcY+rqts+tUSMknhgibExzaGcb5u1FAOLz6a
 Sb4QrdGbtlSAaIkNV5Nrfsnx4A0QFz0onKpYUQC4v+efARj7NARevk+fYP8YHAtlkVxu
 Uvunz6LTDu338ATPh+RMF/7nqjFxMw7/GxwuoauOy37G4rSsv2JV0phJg3K1GGeQA7RA
 478U834UTlB/AclFjQtDbhZOFTFogzGbU1GzUNGbOa7l6c9JVChSjDd6XYrh1bMbBZ01
 fO+NVixdUvpFZIvCJg5mkFo88AFCSoD8ECKJiJwyGb19lBxSnHfdpxbPYMdYtX4YFGLl
 NaTQ==
X-Gm-Message-State: AOAM533IvStVTdS2GxAu1dUqov9/2mkJBr/8bamJFMnYwvE9AxxDS4E1
 shi7bR1Q0KcXOj7/FYIIAhoDYFxLVGk=
X-Google-Smtp-Source: ABdhPJwLV/W0QgYO165+6dLps9Ql+c2K6gSCojvpcYCuNYHlI77WejHASxEt30BvrDbBOEuFxFK8AQ==
X-Received: by 2002:a17:906:b2d1:: with SMTP id
 cf17mr5857500ejb.281.1607594689090; 
 Thu, 10 Dec 2020 02:04:49 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v24sm4759086edw.23.2020.12.10.02.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Dec 2020 02:04:48 -0800 (PST)
Subject: Re: [PATCH] amdgpu: don't treat BAR resize failure due to unsupported
 requested size as an error
To: Darren Salt <devspam@moreofthesa.me.uk>, amd-gfx@lists.freedesktop.org
References: <20201209185540.2032-1-devspam@moreofthesa.me.uk>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3199abbb-e5d0-dff2-d444-c10f10d957d8@gmail.com>
Date: Thu, 10 Dec 2020 11:04:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209185540.2032-1-devspam@moreofthesa.me.uk>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.12.20 um 19:55 schrieb Darren Salt:
> On the resize attempt failing with -EINVAL, instead report an informational
> message indicating that the requested BAR size is not listed as supported by
> the VBIOS.
>
> Without this, as I have an RX 5600 XT which lists only 256MB, 512MB and
> 1024MB as supported, I see
>      [drm:amdgpu_device_resize_fb_bar] *ERROR* Problem resizing BAR0 (-22).

Well NAK, we just recently discussed that internally and the key point 
is that we should not have tried to resize things in the first place 
since that means a lot of churn for the PCIe subsystem.

So this is really an error and we should try to avoid it.

But the fact that you run into this in the first place is really 
interesting, I thought we haven't sold hardware with that configuration yet.

Regards,
Christian.

>
> Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 355fa0057c26..d80ba03913a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1136,6 +1136,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	r = pci_resize_resource(adev->pdev, 0, rbar_size);
>   	if (r == -ENOSPC)
>   		DRM_INFO("Not enough PCI address space for a large BAR.");
> +	else if (r == -EINVAL)
> +		DRM_INFO("VBIOS does not support exposing all VRAM via a large BAR.");
>   	else if (r && r != -ENOTSUPP)
>   		DRM_ERROR("Problem resizing BAR0 (%d).", r);
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
