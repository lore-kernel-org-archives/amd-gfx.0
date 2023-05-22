Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AFBC77B75
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 20:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B24C210E294;
	Mon, 22 May 2023 20:24:18 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A78710E26F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 20:15:10 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-53474b0c494so4517223a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1684786510; x=1687378510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L9fN0dQoly88G20mqeG6e3wEqqETJg+h79VSFG9UPZE=;
 b=Vt5mLw1zDYiyC23QcOz7VOSTUfaxfWt+kaBNXr4ct2pwiJ99N4MhY1NbeTx3uv1mm6
 qRnDKSWxiCoUPyGP6Z666O7SSigjCy/AdTJKWo5Ri/TUJ1xBsQ0HVb2fau6I/qb+yU8m
 1r5UJtw9NgpIXzOePa+QVYe0Qj0thwDN6wDuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684786510; x=1687378510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9fN0dQoly88G20mqeG6e3wEqqETJg+h79VSFG9UPZE=;
 b=Dtz84taL9lZuJ9wN+n9S/UukvDrR4Y7XVP9naJHGvVbd7AkCEU8tOcKQ7w1Scyv8oY
 jc/7Jt+CEWcKnPP6/9DgebHjWo0TviCROogOyJscb4CYDEYnXdH3FZ5nde5Z+iHwRnN7
 nptQY5xcJY3/SKXnDzYOmegTX06b7Px1o48c8rIfJRTKeuodO6NC1920Q3hCHlDramcM
 rAp1WPxSUcUyF46l7rOanqd6UOn6jm3lNjwycRtw6bJhqWoOTUlCkeIZiuimbfLuPFIZ
 0OwCepcR5G+VNufGySyLSCekhEVY2Dqx3nMpQBl0JvBLBNkHPP7FV1RHxYctfXxN1HgH
 k2+w==
X-Gm-Message-State: AC+VfDwf8GYMK1uHVUAi3svtBPDL5YN7STUxlaUT5Bx6hG3Rd508XeKh
 fX6/bJMaFVSP/5PkpNplzokpOg==
X-Google-Smtp-Source: ACHHUZ7puI3viaM9u3eCn1pWl+lXzpSStw8vQUJTeuU3YLnaPBQ6edr8Hq6qSp4lKa3v8WUp7Z99Kg==
X-Received: by 2002:a17:902:e74c:b0:1af:a349:3f0d with SMTP id
 p12-20020a170902e74c00b001afa3493f0dmr8517770plf.23.1684786510093; 
 Mon, 22 May 2023 13:15:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 jd15-20020a170903260f00b001a634e79af0sm5209204plb.283.2023.05.22.13.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 13:15:09 -0700 (PDT)
Date: Mon, 22 May 2023 13:15:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Azeem Shaikh <azeemshaikh38@gmail.com>
Subject: Re: [PATCH] drm/radeon: Replace all non-returning strlcpy with strscpy
Message-ID: <202305221315.4392080E4@keescook>
References: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
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
Cc: dri-devel@lists.freedesktop.org, Pan Xinhui <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-hardening@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 22, 2023 at 03:50:32PM +0000, Azeem Shaikh wrote:
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
