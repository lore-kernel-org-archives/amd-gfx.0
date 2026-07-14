Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7E0C44507
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 18:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA7410E572;
	Tue, 14 Jul 2026 18:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="mFHRmTxV";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC86310E572
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 18:58:32 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so4055650f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784055511; x=1784660311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h6h94CabvOEU1OZ4R1K7bZVQOxAeDTgeQwde5T4bN5c=;
 b=mFHRmTxVB7C8bxWwi6x++BEf79JLWfyfsBNIV6mg2PIgG2FINrkwVj3Czk1EngBRUk
 RFyIrPljKgjZTQPvUTELdpIEDA/J7+UMRXNfjdJmmB7oYv1aL1CE+Dx7m9TG/W1gNMkT
 bNqAo8TebL1S53U29VMX41ukPwYUGGTmGVXuXejTvJQObeys8XGf0s8aDOma37wkFA8s
 Kj2Vt0YITjafl9TUqzu/v7W+jCSpFVJ0QlZus7m4hZyZOBEV2/fgMO/B/SLgBozkzHF+
 uj6PZZRBcEJzDl+MSIODaTxpKYbkfQ/6Tioiyp7mwrDs0jjxa7G7Npi737CmLDm3UzAl
 qvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784055511; x=1784660311;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h6h94CabvOEU1OZ4R1K7bZVQOxAeDTgeQwde5T4bN5c=;
 b=InwlOCo0T0iDMtEZLiXsxwPAloPQ9Vcnqx/V7ni1EO6ChEWJN3d7XMceLI5KmBzr5W
 OnXUjRvq6LRooG0TmzSXlRT3qIhn40btR3ew7XlQJe3EQQ3ksr8wL/Bp2uZ8c5Jvs7At
 4N+2vKXgrbNM/ol1tuzxCPOMJsfwoHAerGMVCx/jMtKmZ8z9EixXCJqO2ajMZvE83H9i
 sWebrzbkme8rQeN32F6CDGrFM+ELntPNI5aXXUj54nANQIXPVjxuVV3mIiv5Bvwp/NqY
 gydj0RuZmh6lqx0EaaVIjwb2CPhknS0mI5J0H3BYpHqiVvH7WruKGTzUmYlZ84wruRxu
 cnqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0W58fK4Pjlljim3eNZlGN3ISm5drf5TklaUa7qb0SB5mJSvkQ0qM1142rUnnrkD/yV+oh76Rp@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywu9p9y1GhJJFNi3S4glV/GcoesSsl734sQWRx4E/2HgBstzt8X
 bEy17yWbW+w6X2f+uMRRNILLSKD8ocBmT2Y773Hk8SQYcThRWyHoAoMYWk8uIcnxV/Q=
X-Gm-Gg: AfdE7cno9qIf1pj8hX1oSVKbTcp08Qba1AWKiYo9f2HZNvi7rL4zomI4i/FPddzsaSQ
 vYiTpoG0lFHNm8YplqA2LnpS/+EhSdPAErWIYOezaLFkaM3gZ5HilzQ9AqTcZou/XMc0bjINZv3
 JYLgY1bO70sgZBOG/Gmz4EQ2jqSos/8QFeiZVR3CByYilBDZhQeqZ6y3Xb0k/Q/rIctQ28+jJQX
 I/Tx4He4OMIRQGHMVPNAuXyW93gB+5LaAkPNlvUtny/74LFBd6uxosJZnbBIjUBO7kNKRGSTYfd
 Y6UJ8yGXDUJB83wShQYYGoUNlVia0bI2CX5RUPf21ZF2D6dhj6b8BnwUMct3oScYQVLUmpj93dv
 NWULEyIEtTIXiSDuX681m3Yp7OA8SWRLNLn6j3bxbW3jwtCNMty+ua6E9SiWOllAHe45kaVP4Oz
 3JMbBpPgLXXSKFhsYig0x8Je/CfMSyimpFXw==
X-Received: by 2002:a05:6000:3c5:b0:46d:d90b:bbe4 with SMTP id
 ffacd0b85a97d-47f2dcf30c2mr17904267f8f.40.1784055511193; 
 Tue, 14 Jul 2026 11:58:31 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a974csm12147777f8f.18.2026.07.14.11.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 11:58:30 -0700 (PDT)
Message-ID: <334c040a-7e9f-4e6f-b3e2-f7d2403ec2d7@ursulin.net>
Date: Tue, 14 Jul 2026 19:58:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] drm/amdgpu/gfx7: Return error code when failing to
 start GFX ring
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-5-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260713125838.30607-5-timur.kristof@gmail.com>
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


On 13/07/2026 13:58, Timur Kristóf wrote:
> Return an error code instead of silently failing.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index a1a9f3fc4567..0ceadb107d26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2576,7 +2576,10 @@ static int gfx_v7_0_cp_gfx_resume(struct amdgpu_device *adev)
>   	WREG32(mmCP_RB0_BASE_HI, upper_32_bits(rb_addr));
>   
>   	/* start the ring */
> -	gfx_v7_0_cp_gfx_start(adev);
> +	r = gfx_v7_0_cp_gfx_start(adev);
> +	if (r)
> +		return r;
> +
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)
>   		return r;

Hm this one looks less "controversial" than the previous one since it 
already can error out. And surely test ring helper would error out if 
cp_gfx_start failed..

I think it also means the previous one is likely fine.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

