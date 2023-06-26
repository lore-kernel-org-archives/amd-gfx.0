Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE25BEB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 15:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE5489083;
	Mon, 26 Jun 2023 15:18:37 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC6410E228
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 15:18:35 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313e1c27476so1823078f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687792714; x=1690384714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WC+aef2hn+RC4MvRvC3qkj6qDY6Pc5THd+nDGicp90o=;
 b=e1Vo9sOW49IJ3FBvvIku0R0tzYJXaSDKEMBJSc0mhnHtb0CXvkQYiAIPe+oNdJnxiM
 m9KP/XTyUOTjiiBTAloDTQ04Wsde/vnp7YwiU/HCdoINHMfOn0a94PuI843lwbnVZ35U
 FP2nsIc6UG/xaMCOHd6wMLkZSyRf7wn7bBMYw7+V7kP295Gb8Xkh7Lau6iryaVEgDsvo
 r/JONBCueMbyzanafHcLhjc42s20qNpI1McwiUcLbiUAKdLyGWzGJrLMVygugO7zLWpS
 UgyDPKTnwCvATXsncFFQuHMmRwP0t0GN/LkFazmoZkmnW3vPOHVwJPUJObEukGtKq+pn
 nIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687792714; x=1690384714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WC+aef2hn+RC4MvRvC3qkj6qDY6Pc5THd+nDGicp90o=;
 b=TPebcBuiClx8gA+n+4BmiW/WR3CQZ7gcr2/P83Cvr8Gl2a2RMfUH/IeMLe9Sa3tWka
 9dNt7GLd30ahf5z5vHRXzhoHqTjarCa7NVCmFlt7iD1+rnrOsJY/umkKlzUFFC72KQLz
 F7UfNBXDyFboCld6Z7eeFPy9iNQ65lIqztoBmJpeXQN99TtQu5U4jJr4gIs/gHaSOve4
 XX2gQ3M65UunRAvJVgZ1Pw3J+O9zYzMi9vTy4S2ymWmDiRshAxov7T/ppmvXGQWhi6yj
 fiot4VNrcLo+1OYitKpv7IM342T6SGRceAKYufgEmoWJoA0Dwb62YekBo6hsJCXKXmxC
 Xafw==
X-Gm-Message-State: AC+VfDzNqN4wArrTHKQdToFOlWajZJinFeNkiVwSDtxgELJXkxlt2KtI
 V15ya0raUusIeCdmjL93A88=
X-Google-Smtp-Source: ACHHUZ6aNr29ECe+YQifGqrkZmLpYrrxu+fm3pMdPrg01LIEUG1J8KJKJNmNkVKEODg8Fhz4D/IJ4Q==
X-Received: by 2002:adf:e947:0:b0:313:f2bf:4c3c with SMTP id
 m7-20020adfe947000000b00313f2bf4c3cmr2239800wrn.24.1687792713503; 
 Mon, 26 Jun 2023 08:18:33 -0700 (PDT)
Received: from ?IPV6:2a00:e180:158d:7600:862:d9d5:c1f7:84a1?
 ([2a00:e180:158d:7600:862:d9d5:c1f7:84a1])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a0560001a4f00b00313f676832bsm1490289wry.93.2023.06.26.08.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 08:18:33 -0700 (PDT)
Message-ID: <0ef87cf9-c1ac-b8e5-52a8-3012c44720d1@gmail.com>
Date: Mon, 26 Jun 2023 17:18:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amd/display: Remove unnecessary casts in
 amdgpu_dm_helpers.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20230626124317.1384122-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230626124317.1384122-1-srinivasan.shanmugam@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.06.23 um 14:43 schrieb Srinivasan Shanmugam:
> Fixes the following category of checkpatch complaints:
>
> WARNING: unnecessary cast may hide bugs, see http://c-faq.com/malloc/mallocnocast.html
> +               char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);
>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> v3:
>   - Keeping same as v1 - so that variable "buf" remains to local to the block,
>     whereever it is declared, by having just removed the casting.
>
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index cd20cfc04996..4590deca25f8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -400,7 +400,7 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
>   	total = log_ctx->pos + n + 1;
>   
>   	if (total > log_ctx->size) {
> -		char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);
> +		char *buf = kvcalloc(total, sizeof(char), GFP_KERNEL);
>   
>   		if (buf) {
>   			memcpy(buf, log_ctx->buf, log_ctx->pos);

