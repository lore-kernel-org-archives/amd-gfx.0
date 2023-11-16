Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F29FC197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 10:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3233910E5C5;
	Thu, 16 Nov 2023 10:52:53 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1CF10E5C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 10:52:50 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32ded3eb835so538040f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 02:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700131969; x=1700736769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PAzDknxrYCT2SwvRBMtH3gQps5h0QTsZaUkSvjjp0wk=;
 b=LoEqCr7XERln23SR+MtH/mXV5oapL4w5shXHu62Lgl/8OEWdw+ccgCu+evrvBAs4oX
 SJIkbs9JbIwe6uVgrn+NjsXGUGjp3yISYzjHrwOV7xQaI095XgcFRpZ/sRbpp6v2FNop
 hCnzda4746ram/P6FMJJ8laha+LqaLBnxkA/TLFI+FOIYFgcNhtwEmCXSKuZRvr9+xRX
 b/Z0lRann4/XKx/TLnAnRJMvKHcmPw7wg2y9zooXuIffu6OLCm2gxa3PSMoyDW9KN7xM
 gHXczc0TYtZgGHvMYhEIuQicJuF+aTne6jAS/L2HsybDZfjL7uHLxUnTdXxjuKQziK/I
 uZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700131969; x=1700736769;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PAzDknxrYCT2SwvRBMtH3gQps5h0QTsZaUkSvjjp0wk=;
 b=riTX5FysDRx4taQ5sPwnaATwTocLIWXsRWtZNh9DIdxcKD+1N4s1cZTIIxLJrj3FXG
 84lMsJQr4M6QfRXsqzPt3AqXrN4HPjpXace/iv9X8jVEQP+BQLiO6kC9CoJfXUCP4E+u
 enK0mImhvifcbioX87m7XJ95h+1B0PMN57RoxZx/OKYvtvUEl7W67x0mCDWnQFxnj3NY
 oza8ZiXfygPRQbrycSKWY7qNDnz7nh2Kc+nmh4mCIekVJyRpvP+lcV+pf/HwQY8/ueoe
 O2JQO+9ZLhaRGlE4gM3WZV9Q9LT2Z6OkH1faTHH+mcgTeiyjFX+r/Hub+UnB5cT8USZZ
 w3Nw==
X-Gm-Message-State: AOJu0YzgYnFBAVuTBWKgt+xAt46ZyS6tecxdRmaXtlPxfGNt3mBbXdww
 zgtDMJnrZU4rY2AWX0O7ilYVMAnFYzE=
X-Google-Smtp-Source: AGHT+IFKmb/rqbo10txx9ErQsUlUwe9T76gJVXHUf8Q7+TiV5/OLalCL30YHWcSylvNOri0x2Havvg==
X-Received: by 2002:a05:6000:1acd:b0:32f:79de:8b7f with SMTP id
 i13-20020a0560001acd00b0032f79de8b7fmr13165028wry.49.1700131969005; 
 Thu, 16 Nov 2023 02:52:49 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 x9-20020adfffc9000000b0032da87e32e2sm13366717wrs.4.2023.11.16.02.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 02:52:48 -0800 (PST)
Message-ID: <1ba780f7-cb1c-460d-9a19-78e293a9fb7f@gmail.com>
Date: Thu, 16 Nov 2023 11:52:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add function parameter 'xcc_mask' not described in
 'amdgpu_vm_flush_compute_tlb'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20231112044534.1637245-1-srinivasan.shanmugam@amd.com>
 <20231115161540.72584-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231115161540.72584-1-srinivasan.shanmugam@amd.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.11.23 um 17:15 schrieb Srinivasan Shanmugam:
> Fixes the below:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1373: warning: Function parameter or member 'xcc_mask' not described in 'amdgpu_vm_flush_compute_tlb'
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> v2:
>   - Updated xcc_mask description "mask of
> XCCs that belong to the compute partition in need of a TLB flush"
> (Felix)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index be084cbe7501..9cd2595f6c22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1360,6 +1360,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>    * @adev: amdgpu_device pointer
>    * @vm: requested vm
>    * @flush_type: flush type
> + * @xcc_mask: mask of XCCs that belong to the compute partition in need of a TLB flush.
>    *
>    * Flush TLB if needed for a compute VM.
>    *

