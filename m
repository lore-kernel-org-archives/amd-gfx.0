Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51A1CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B16110EA39;
	Tue, 16 Jun 2026 11:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="GKPyu4Bk";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238B610EA39
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:18:52 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6913160c9ddso8169590a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781608730; x=1782213530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BQEAzNClKJh9Itfe6Ck/QnkFQ4ypOtuoKQ8oD1J+6Q8=;
 b=GKPyu4BkRh2T31pyTiLfP0Dss7ldjsZkHNG49kDJJ3hIWRWwqnGON+Ttu18tVFJf8E
 fTRyaN1rR76ieEi5pX9FI7PaJzuwcr4xmgPoSQllRgOlTvI8lbVzcnX2gzuwv4+A8Bs+
 JtfnYwL1sK25+FnQCq48I0HYPEhcaqDn4ERQRpDzIC2Aa6UHapRI23RETX8aPdk33/fT
 18nXFv4v4hmtYsSAUzQ3lG877CtlgKXRZ6QKRQBtBH+9Vg96fLVlHEaz2oFkQogMG8ca
 JtYP/qhdcDQcs8K4P56E2zuCYXKGjn8s/inRh8VapwOoODBPL2GfFEkvreLU20dWadMl
 RURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781608730; x=1782213530;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BQEAzNClKJh9Itfe6Ck/QnkFQ4ypOtuoKQ8oD1J+6Q8=;
 b=Y4hPZ8TDG0yXb+qh3I93tBZNwM0FmbacD0m5yd70r99fFRVOw7U3FHwr4weiMZyGkw
 A49cfGOPPUBur1LS/lDmfJ90eJUU6hrZGWn0tBnGWjgjTSjNRpKn3sVZ84xzKXjnNPRh
 n7MVC+dKXpxsEUqHCaqmtkcoaSmoLkG7TrT70W0eeR1A9CMyn9ARn7UEuNIQ0yQJoqgX
 8paq97d6Ju6Qmetdp9ugAZ+6pnO/DYmDQFzr4Fsq4ZlRbEdruqGehE4mf9KyAGsL28gs
 ppgaHhvWuWjKj8TDXqXDTlz/p2WakKJeNlLPo29Tgj3MDJmHFcHaFfgvojqK91P33x2r
 HvaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+w2h2EhpzYKpSoqHpVH6Mzuu/7buPcjxyZrFPgw0kUqwUeufmi3v2NtSGJEqaX/bZ1rTFLe/yG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQS1HKDan9oGx1G1HrJ8li1g/p2rlsXuRIo0KtMWP9nPfdMacf
 arTCPzr82s4KN3Onx06aYD3xLn6d4FPFv6qRLJWRe8M2TXZ2P8HgBPdW9rl3tHNkKC0=
X-Gm-Gg: Acq92OFM7qHXeoT/zbnQKCrsqluk7wh9dnyqDtfS4/Z27cOjPILvcw3NFCQfwBcpYsx
 qL+tp/68cPSeNvYR/n5ciboi6332shb456lwk+AMNDUzCOlbyxhKhO9ix1JaPXDrArP0a0E4jGQ
 SCZTU6g8hU/zimeuPr+9d3KpT/By/9jfJJBtOlyuVly/yT/7kv9MboeBSHwdJWxF1HgVFoHUKcY
 UtulOwXp4uwIPwfQ/r/zYAalHXoxICAyfkeu+aSXBOqmFpnkcBFihmkrh6hDQbb7b6VmCTNaN+j
 4Ce96DD8Ll4Q+xpNeGniuZhqrarre/KTYzaJkMFiVeyXnLb5vQgZEdaUqfCJNJfmsZAmZOQbY8h
 IQ3gObbnzikkTK4ipEax2lWGrJgLi21DoX4KmQnK+QnVa8dLTsejoBm+GO/+auDxgr+E2GwWApJ
 DpGhCXbIAbxMJcGEp9V8Pjs3vHaunfjkz793b0oTPAB+cT
X-Received: by 2002:a05:6402:4496:b0:691:52e1:646 with SMTP id
 4fb4d7f45d1cf-693c6a6af35mr6530318a12.18.1781608730219; 
 Tue, 16 Jun 2026 04:18:50 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6940c7456a8sm3479449a12.16.2026.06.16.04.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 04:18:49 -0700 (PDT)
Message-ID: <48b11e0e-7da4-4b95-9e40-c552aa254dd4@ursulin.net>
Date: Tue, 16 Jun 2026 12:18:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] amdgpu/ih6.1: Fix minor version
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, amir.shetaia@amd.com
References: <20260513170849.27061-1-timur.kristof@gmail.com>
 <20260513170849.27061-2-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260513170849.27061-2-timur.kristof@gmail.com>
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


On 13/05/2026 18:08, Timur Kristóf wrote:
> Report the correct version of IH v6.1 (previously it showed v6.0).
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> index 95b3f4e55ec3..699c274d357e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> @@ -790,7 +790,7 @@ static void ih_v6_1_set_interrupt_funcs(struct amdgpu_device *adev)
>   const struct amdgpu_ip_block_version ih_v6_1_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_IH,
>   	.major = 6,
> -	.minor = 0,
> +	.minor = 1,
>   	.rev = 0,
>   	.funcs = &ih_v6_1_ip_funcs,
>   };

Finally an easy one! :)

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

