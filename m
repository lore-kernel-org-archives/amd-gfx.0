Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CDEC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5CC10E4F0;
	Wed,  2 Nov 2022 16:05:02 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF9210E4D0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 15:42:55 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id k7so7227452pll.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Nov 2022 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gbHhHvdRSfNW3M6lKiiBiHsy/aZHIegD8in6WLhhzSY=;
 b=grx0sX1vyt4doXabEeN05DzVGZaktvYdcCfg6WGKYn2Um48Zgp2UMnzv9yxRjGlvDs
 s02OzcMqRXmY81P844mFxCquKl032+JyuX8aVk9fGB0kVUT/d3ioGHRtH7AHRaujNbdw
 65vnLvXCz2xWmb3ZUvb4RYrBdcrT6g2PSeo3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbHhHvdRSfNW3M6lKiiBiHsy/aZHIegD8in6WLhhzSY=;
 b=h8a8GE17Wqo0po9t34Z5FDWN4uL7yXXnTOFS+X3QgIxqSI+FM5OTjy4LpGUpXyjKlV
 GwevnXwH85l7kxPg5H8z8kjuloGXVFPwRqQ6XC/Tsii9l7NwwbDfIgulM0YdVlT8MSLr
 vXRYV+aWFLQ1Jingv14CNZ59p76GyAe5ibN/px4UaWbWLz+Rw9Txk2UCKKqndoH8UQvs
 DMXN72y2T2B5Bz8vuraY4xns2vZve8idlp1/KTgmH2aSdbyS2vKeBrHWRMWWBgktE2gI
 UcjrCS2XvtXQ1kjeskbeMygVPtkt0bi8TtH4wSsOl2W+Q5dDjl0tKGITUEswpjVn3To3
 nJsA==
X-Gm-Message-State: ACrzQf0z2N2xvSdZ3yF+DcM+vJJvS6LgUCcrFGJWgmOoQIzzN4sz0sjt
 91KbXjl9Kk5H98uwo+1V4URDKQ==
X-Google-Smtp-Source: AMsMyM5riCGdRLVGt8cheeiKjHf8n8+rR3sMc60dvYFpdMSefduVp5ovnjO/E9dJecAFytPwR3myDw==
X-Received: by 2002:a17:902:720c:b0:186:fb90:573e with SMTP id
 ba12-20020a170902720c00b00186fb90573emr25604727plb.160.1667403775155; 
 Wed, 02 Nov 2022 08:42:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902710f00b001885041d7b8sm47015pll.293.2022.11.02.08.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 08:42:54 -0700 (PDT)
Date: Wed, 2 Nov 2022 08:42:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix type of second parameter in
 trans_msg() callback
Message-ID: <202211020842.8F3ECD397@keescook>
References: <20221102152540.2389891-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102152540.2389891-1-nathan@kernel.org>
X-Mailman-Approved-At: Wed, 02 Nov 2022 16:05:00 +0000
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
Cc: llvm@lists.linux.dev, Tom Rix <trix@redhat.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 patches@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 Sami Tolvanen <samitolvanen@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 02, 2022 at 08:25:39AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c:412:15: error: incompatible function pointer types initializing 'void (*)(struct amdgpu_device *, u32, u32, u32, u32)' (aka 'void (*)(struct amdgpu_device *, unsigned int, unsigned int, unsigned int, unsigned int)') with an expression of type 'void (struct amdgpu_device *, enum idh_request, u32, u32, u32)' (aka 'void (struct amdgpu_device *, enum idh_request, unsigned int, unsigned int, unsigned int)') [-Werror,-Wincompatible-function-pointer-types-strict]
>           .trans_msg = xgpu_ai_mailbox_trans_msg,
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c:435:15: error: incompatible function pointer types initializing 'void (*)(struct amdgpu_device *, u32, u32, u32, u32)' (aka 'void (*)(struct amdgpu_device *, unsigned int, unsigned int, unsigned int, unsigned int)') with an expression of type 'void (struct amdgpu_device *, enum idh_request, u32, u32, u32)' (aka 'void (struct amdgpu_device *, enum idh_request, unsigned int, unsigned int, unsigned int)') [-Werror,-Wincompatible-function-pointer-types-strict]
>           .trans_msg = xgpu_nv_mailbox_trans_msg,
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> The type of the second parameter in the prototype should be 'enum
> idh_request' instead of 'u32'. Update it to clear up the warnings.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
