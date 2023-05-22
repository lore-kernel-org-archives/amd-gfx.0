Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F70C7EE29
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 20:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B907A10E270;
	Mon, 22 May 2023 20:24:17 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C8D10E379
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 20:16:09 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d57cd373fso1482178b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1684786568; x=1687378568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HzlAGM8RQ6FHyn5tETnI+sMMAIwviCvOlXcFSHD1eAE=;
 b=a4/oSrRQtWRLaqbqVFZWY7qrHna387jLw1QMQLYbleIE1kd7KUiXqNFbF1hj/qyxeL
 u1g/ZpYLS57Lq8SdoOE1vTW6fiOdToSwphBQ415xl1AvhSYo0HTQyvVR5Fe4UifeqLOh
 hGHUHAnxcE/O6kVjnzpWzBPmEl0VRTz/fDV2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684786568; x=1687378568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzlAGM8RQ6FHyn5tETnI+sMMAIwviCvOlXcFSHD1eAE=;
 b=HNU7oacqziSJmxrYJsG1iARRhy8MK+hvO76d3McsVQr5nDjappN5VQ6wXTFIXXQr4k
 6eacPm2njLThfEzCaBSs0O4vZyc1J5PmA02AfzsC2KoU5GHOfEUdU5DqRwC1kCR+/tP5
 wnqePYPePNaJqele5CzJpCCNFc3GxCKHyCUnh0u8XVE3NTSDKo4ZKJsXyUZ4BAqQPVUH
 rRLBc/dGGxRtJ57jP1Awd4uEtwv0Rr/n9TqpAvdRQgMaS4H7CmkrfgqKnP05Sm8x+Aos
 o6nj7xYbOrjSLZVO4mpra0p9ykpamMdFusUUgfD08dh2AFhoFm2ADnv0PXKPRBTlqSMP
 +LiQ==
X-Gm-Message-State: AC+VfDxShoJlREEZspu35lnRUPGvYzQYvxgfukQMGYhJSlBUUKD/NRVy
 j5c7ApujTDXDHxaud8OePfo+GA==
X-Google-Smtp-Source: ACHHUZ7kSdg7lvscJChRXHco/lZQNRpJ7GeHs3ZD/B6Dkut0O0hFkEBB9llB/7LICw3wA0pe6/GJnA==
X-Received: by 2002:a05:6a20:428f:b0:10b:c843:9522 with SMTP id
 o15-20020a056a20428f00b0010bc8439522mr3203020pzj.20.1684786568532; 
 Mon, 22 May 2023 13:16:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm4508531pfn.68.2023.05.22.13.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 13:16:07 -0700 (PDT)
Date: Mon, 22 May 2023 13:16:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Azeem Shaikh <azeemshaikh38@gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Replace all non-returning strlcpy with strscpy
Message-ID: <202305221316.038CDF6B@keescook>
References: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
X-Mailman-Approved-At: Mon, 22 May 2023 20:24:16 +0000
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
Cc: dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-hardening@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 22, 2023 at 03:52:45PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
