Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D83AD40CEB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 23:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D29510E628;
	Tue,  5 Nov 2024 23:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Evvg1XyK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279AC10E056
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 23:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730848747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sa5/5lhLKs3iHDCWSEuUxxBOpoA+LLfA05FJdzRoUzo=;
 b=Evvg1XyKpUL287S2uBA1JJTcXGVww01dZ6viNdo70+XRVING8K4nXKn9U3AP1+CzkjsOAE
 0b+jGpi0jT9B+GDXfIiE1d808EsUHp9W5GPZwLi7FjqvPTlI0eZdhOV4DkSrDrgeVkfF1k
 L5x1X0pFoo6x1IKVmYc4hDvicvYcweY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-iXIyJoWEP9-1nn0H2zl_qw-1; Tue, 05 Nov 2024 18:19:06 -0500
X-MC-Unique: iXIyJoWEP9-1nn0H2zl_qw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5016d21eso2783306f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2024 15:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730848744; x=1731453544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sa5/5lhLKs3iHDCWSEuUxxBOpoA+LLfA05FJdzRoUzo=;
 b=jKMegisT2M2xQjKx5uZnYPeYde0Q/JDarylHCjV+k0l3AG6PgZ0l3NVKZB3nqRgNxm
 Ftbd6GQw8EXTmn1DMYnuNVz/JN/TcZEZAsC/0Ht53jcMP0OGSm5Jpt09FXACYUPE6Jeh
 EJepn9fQNaLI2Us7FRkLrWgonZgHG3H23h9ih7XM23RIQI7oy1uiibluPVFNKi7/OguC
 AGo1xhBNRaBFRMCdAvXtqappIl4BB2RrzWTedSCs3d09vaOVd9FuHtSYINv4O69LT6As
 1AjZD5AmSW91bvGng4nS5wzPJRD+AAkjHw9YvG1rOFMPVnvjNyUhtPl3LreAnjSSxkVE
 0Wxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkdgxz6aQDsLtvaT4F9aIR2YcS+oUxCPNElYSsehpkmWOioblJpzI9zxKENKxHIceCn4EuT5TA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwATdRKiYWLstH8sZMp0rGu5I5+V5GeNikx13gSPoZpwbaxchl
 sYvoHh+ptwhsxfbAbxu8bO6PTnGsJuJJSIDdT8xzgE5KxmWfSyjIjSQPTc5I4ClcJXJ3YIxXzqk
 aUl38jU56WUfQAxzh1ewvvNLwP9IVdeexXUoxw4gHYuETz+OHG7dr6F1R2zgYgf/A9BOjV3w=
X-Received: by 2002:adf:fe85:0:b0:37d:5352:c83f with SMTP id
 ffacd0b85a97d-3806113da4dmr25398090f8f.17.1730848744378; 
 Tue, 05 Nov 2024 15:19:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5CeXbMtj7/scO7nb0dolHCnHseqzllEhjyejI6hmJR+iynIaQAU1ObelYIRHcBCQS8KC0Og==
X-Received: by 2002:adf:fe85:0:b0:37d:5352:c83f with SMTP id
 ffacd0b85a97d-3806113da4dmr25398082f8f.17.1730848743999; 
 Tue, 05 Nov 2024 15:19:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722?
 ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7d15sm17653649f8f.8.2024.11.05.15.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 15:19:03 -0800 (PST)
Message-ID: <fe52bbb2-60c7-4be2-9304-f868f54bb56c@redhat.com>
Date: Wed, 6 Nov 2024 00:19:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/5] Add panic support for all DCE/DCN
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: yaolu@kylinos.cn
References: <20241105140624.2897662-1-alexander.deucher@amd.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241105140624.2897662-1-alexander.deucher@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 05/11/2024 15:06, Alex Deucher wrote:
> This builds on the patches from Lu and Jocelyn to fill in
> panic support for all DCE/DCN variants and code pathes.
> 
> v2: refactor to provide cleaner history and share more
> code to provide a more consistent experience across
> DC and non-DC.
> 
> v3: resend with the missing first patch

Thanks, it works now, and it looks good to me.

Best regards,

-- 

Jocelyn
> 
> Alex Deucher (4):
>    drm/amdgpu: add generic display panic helper code
>    drm/amd/display: add clear_tiling hubp callbacks
>    drm/amd/display: add clear_tiling mi callbacks
>    drm/amd/display: add non-DC drm_panic support
> 
> Jocelyn Falempe (1):
>    drm/amd/display: add DC drm_panic support
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  80 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   5 +
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  27 +++++
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  27 +++++
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  27 +++++
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  26 +++++
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 103 +++++++++++++++++-
>   .../drm/amd/display/dc/dce/dce_mem_input.c    |  34 +++++-
>   .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  15 +++
>   .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |   2 +
>   .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  15 +++
>   .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   2 +
>   .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |   1 +
>   .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |   1 +
>   .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  17 +++
>   .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
>   .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   1 +
>   .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   3 +-
>   .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   1 +
>   .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  15 ++-
>   .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +
>   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
>   .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   2 +
>   23 files changed, 401 insertions(+), 8 deletions(-)
> 

