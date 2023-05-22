Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE9FC77B73
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 21:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB03D10E393;
	Mon, 22 May 2023 21:02:08 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB68D10E38E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 20:54:51 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2555076e505so1804016a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1684788891; x=1687380891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuElaN/qDTwisrD4X6pHQNWgjgAbUbIATBdO1zpDRq4=;
 b=MhuIchJoSP3VNW834mCsQH8QhVAtF7Te4uKXeNA+vCPR8uLVLXQlSOUUqmD3FnOyFq
 wSE2ePdtuZfdxWOxnqhyyk5C3i51P5jAWLvfCTqGtZm/Hv6oG/eG7QO1GYOPLQn9IsUF
 ukspP2HSGuGjgrmweUS3CD9/nlMyJ2RKTL4hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684788891; x=1687380891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuElaN/qDTwisrD4X6pHQNWgjgAbUbIATBdO1zpDRq4=;
 b=Q3cMbACgaT6oe2GtzTQWVJvm9g/2RvtL7FJV8ZEm0fbU0nzQfOjn+5pRPujQCaT+ZA
 F4k2531z0btuaCnNMM73GbKZ32hsedvN3q4N70TQyjTt3jyildAuv7rlRlKqk3dapLMM
 WSL92XIrlhQy4sBmQ9dG4wRr7dIOYAJe2VbwS/10BeYa2yQbasC3oYxk6UjblRxflEyj
 R1ZAdQGHAFkM1kVHFSUQ3FVRboDSi77E8YtywiBKL1t1dX35Phh4EY4AlgA2TYpVCGC2
 TMA0vJefGa9Dht/HsQFAgLeVMffLqx6Mk0ZZiDUemcPMUhmusOlJ5znKQEnNdac3I6TR
 WknQ==
X-Gm-Message-State: AC+VfDzv/y9jyEKa1VEVmv1cwoXgudD+3mT/XL217uwQxxZZdnvxjPLt
 F2cugp93Dl4iW7FnOQLYwfZctA==
X-Google-Smtp-Source: ACHHUZ5RojlqCQM3TmsJ+Nx4QRDer9RPXkiS+1C8Bn4fPCBBrUhOW1RX7WMCawCYR7+Mqz7BmU1sxQ==
X-Received: by 2002:a17:90b:3555:b0:253:3b2b:2a3 with SMTP id
 lt21-20020a17090b355500b002533b2b02a3mr10962552pjb.43.1684788891123; 
 Mon, 22 May 2023 13:54:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 j3-20020a17090a31c300b0024de39e8746sm6807748pjf.11.2023.05.22.13.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 13:54:50 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Xinhui.Pan@amd.com, azeemshaikh38@gmail.com, christian.koenig@amd.com,
 alexander.deucher@amd.com
Subject: Re: [PATCH] drm/radeon: Replace all non-returning strlcpy with strscpy
Date: Mon, 22 May 2023 13:54:49 -0700
Message-Id: <168478888725.1444594.8281276970110924816.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
References: <20230522155032.2336283-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 May 2023 21:02:06 +0000
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
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com, linux-hardening@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 22 May 2023 15:50:32 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] drm/radeon: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/76ea3f6ef93f

-- 
Kees Cook

