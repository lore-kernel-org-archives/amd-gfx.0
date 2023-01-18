Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE02C32793
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 14:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A8510E760;
	Wed, 18 Jan 2023 14:47:20 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13AAA10E6F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 14:47:19 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id az20so64706338ejc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 06:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZSd1+vYtGfSUJaEAlvyt0j0HFUyfohqvlKrCz3wK6H4=;
 b=pMK1s60/dFTf7DGkUIUwyBEOQ1y4FprY3desohcz1UB1YLmu4yyDqcNQwLO1M2HnAj
 36RZhNe7/dxOGW8S7GRJ4XYAAfacBnOFfMDlbABC95yW6nBGymmjsSnHzN2OKOr5wJsD
 bEL7UkcCe9Kuuwnk32fe4PxhFeLBeBeFktK+Ln/6xTWPlNpz9eP7xfG+4jNSLfT3lh2I
 D+zARLnThZzFjMbq+bvYtJk/aEFndQcOv0Laf0IxV7tDLfjxD6VSjghdO/Zx7HT/Va9f
 Y5EfNvrvaUWUO7hib+VXU7QJc1cL/AU/ciJJoLg00kbtZiptapb/Jwh0b7xc0gPzP130
 3azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSd1+vYtGfSUJaEAlvyt0j0HFUyfohqvlKrCz3wK6H4=;
 b=siYIxn+ev0DgKr+nWkoUtYewmtvIQUXrqRp1fI0o51tHpHhq4GS2J9lnIunUl+ao2m
 qu4/FrNvWdNufKS4R/alF5ACzqKHR5M3Bag1k71amfc20amMkS3ZiDVXHF97U41eirJt
 Gb5AZPaYDgsRp6TFrfTBJBfNsl5m4kXZ7T5d8b37hHgBVeSSvcm9QLdvErgUYXE8Lvkd
 4QomsmP5W7s2fYQaLkC10B8SdrfOAx+8djiUmfzQvbnFSN5q1PsL/EdjaOVJHFbuELBF
 G9pl0Nu9oZLCKn87iQ3oRuvFxPNk0KbeQ9Rcwvp4e+r2zehN8EVBPG4FZtaiq0jj0OrV
 2DnA==
X-Gm-Message-State: AFqh2kqUY4Rmvj7Wbn3d79CkWPaDwlz1ZjP/kJWuQp5+gZj5Zdr7iHmj
 e211E2u2ksynycwl5uR3PAc=
X-Google-Smtp-Source: AMrXdXsnhvwQOSh4xlWKiBDLyLFkhKBIQs+aZKM9kj5xCfrEfZrUZ4d3S2Ka7ACu49dS2C5cTe8Sbg==
X-Received: by 2002:a17:906:3f94:b0:861:4671:a834 with SMTP id
 b20-20020a1709063f9400b008614671a834mr6405891ejj.71.1674053237670; 
 Wed, 18 Jan 2023 06:47:17 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:11b:aaf8:6e8b:724f?
 ([2a02:908:1256:79a0:11b:aaf8:6e8b:724f])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a056402000200b0049e09105705sm4542006edu.62.2023.01.18.06.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jan 2023 06:47:17 -0800 (PST)
Message-ID: <3e534cde-b52b-79e1-e114-811956c068f5@gmail.com>
Date: Wed, 18 Jan 2023 15:47:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] drm/amd/display: disable S/G display on DCN 3.1.5
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230118142611.1780725-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230118142611.1780725-1-alexander.deucher@amd.com>
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
Cc: yifan1.zhang@amd.com, roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.01.23 um 15:26 schrieb Alex Deucher:
> Causes flickering or white screens in some configurations.
> Disable it for now until we can fix the issue.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
> Cc: roman.li@amd.com
> Cc: yifan1.zhang@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 500d3d9b59d2..7167a7b63f8c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1503,7 +1503,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   		case IP_VERSION(3, 1, 2):
>   		case IP_VERSION(3, 1, 3):
>   		case IP_VERSION(3, 1, 4):
> -		case IP_VERSION(3, 1, 5):
>   		case IP_VERSION(3, 1, 6):
>   			init_data.flags.gpu_vm_support = true;
>   			break;

