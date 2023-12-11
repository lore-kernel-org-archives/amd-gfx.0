Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF325C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 18:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE7210E4E3;
	Mon, 11 Dec 2023 18:55:01 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3FA10E041
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 18:54:58 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c2c65e6aaso48652375e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 10:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702320897; x=1702925697; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R5WRRdbrX7jsDydPDTMQ1NfEfgKo0NpiSZKnMVTNgAA=;
 b=IDTfkurT9Nf3HHQR+3d87BvNSfSm8sFfrmgtdRhzE9k7QW7JEPZVLdO8XbxDXDwuwt
 tXicaF6A0tDtVSxhgZw1/tgRNLIWsfnH+S1YiK/xNfd+HGVuC0D80y1TzKFC8fIqGdIz
 t39CYahRuMzAwHWa0slHSR4vVYhF1h/U3isaV3FEb/T5D+QQmn3Y5rId0zJKsyyQT+8s
 +mPBzKzk9LCm4FQGOHswJsWzON9SolTR+kHjxrrrV3rbndT8G6Z7IsfPEtsaChj3giaT
 GX3TatfNMurJ4gN/GMQRDtj/AcJ0DF5c1SvkgJ9m7DW1xeuYyd2YH927YaA+zhEpEb1h
 Kd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320897; x=1702925697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R5WRRdbrX7jsDydPDTMQ1NfEfgKo0NpiSZKnMVTNgAA=;
 b=VLMa6y6jFV64xADoxhWnEiDNbinMHFGuerN/EW0wW5fFvV5rC7Plsu/3JcSUPRhxIa
 FqOXawbfbBfzb28yojkT1ZrVJIShIg4uOSF7ifYBM04X6GX2LdQzwFOBEt8gRNODk8rM
 UTqBty1feIQ6uhsq901ATQSYBthly5TviVT5tPZtHdhlOduiktU3oXN34sHcESYM28n4
 awg5xF5TzAF2ULiyIf6GormmWa7M2IoNPG/h3s/QHwfhDlLXtwDzu53zwt5OmNMMnM1S
 x5EMcROxoNzyC+VOgr1M2nRcfceIokn64sN5sseyYz9gkQbgvl2QIbu34QG+D2mqaMAq
 yPzQ==
X-Gm-Message-State: AOJu0Yxb186Ozbo4wl/xrj1u00YcnzTHkuxDyrczpH15DS/6/utzmYfT
 6lYmda+Wfk+Dmj0i7f6mAXTj4Uo4Qvg=
X-Google-Smtp-Source: AGHT+IHXmCPrFzakVnF4WGq3hSML3wU0pprlw1sxKA8c1ekbqZ07LdgML8wmYXG6YMEXHaM+gcrp5g==
X-Received: by 2002:a05:600c:4384:b0:40b:2b42:a1c9 with SMTP id
 e4-20020a05600c438400b0040b2b42a1c9mr2337544wmn.23.1702320896571; 
 Mon, 11 Dec 2023 10:54:56 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 jg8-20020a05600ca00800b0040b54335d57sm15975428wmb.17.2023.12.11.10.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 10:54:56 -0800 (PST)
Message-ID: <b02be977-9e24-4368-9dcc-7ce6fef5ab93@gmail.com>
Date: Mon, 11 Dec 2023 19:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu/sdma5.2: add begin/end_use ring callbacks
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231208225328.25651-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231208225328.25651-1-alexander.deucher@amd.com>
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.12.23 um 23:53 schrieb Alex Deucher:
> Add begin/end_use ring callbacks to disallow GFXOFF when
> SDMA work is submitted and allow it again afterward.
>
> This should avoid corner cases where GFXOFF is erroneously
> entered when SDMA is still active.  For now just allow/disallow
> GFXOFF in the begin and end helpers until we root cause the
> issue.  This should not impact power as SDMA usage is pretty
> minimal and GFXOSS should not be active when SDMA is active
> anyway, this just makes it explicit.
>
> v2: move everything into sdma5.2 code.  No reason for this
> to be generic at this point.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2220
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com> (v1)
> Tested-by: Mario Limonciello <mario.limonciello@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Maybe add a one line code comment explaining why we do this, with that 
done Reviewed-by: Christian König <christian.koenig@amd.com>

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 2e35f3571774..89f7955739f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1643,6 +1643,20 @@ static void sdma_v5_2_get_clockgating_state(void *handle, u64 *flags)
>   		*flags |= AMD_CG_SUPPORT_SDMA_LS;
>   }
>   
> +static void sdma_v5_2_ring_begin_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
> +}
> +
> +static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
>   const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
>   	.name = "sdma_v5_2",
>   	.early_init = sdma_v5_2_early_init,
> @@ -1690,6 +1704,8 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
>   	.test_ib = sdma_v5_2_ring_test_ib,
>   	.insert_nop = sdma_v5_2_ring_insert_nop,
>   	.pad_ib = sdma_v5_2_ring_pad_ib,
> +	.begin_use = sdma_v5_2_ring_begin_use,
> +	.end_use = sdma_v5_2_ring_end_use,
>   	.emit_wreg = sdma_v5_2_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v5_2_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,

