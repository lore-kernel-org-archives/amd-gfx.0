Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4CECA5FCB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 14:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D6F10ECF8;
	Thu,  1 Oct 2026 14:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WBv9k4GO";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1871E10ECF8
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 14:46:23 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso41896775e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2026 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790865981; x=1791470781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hAY8Y7lS5pZSCwwNk0LjwR1o1ybilXeJLRl336PhQCY=;
 b=WBv9k4GOk2X9jZw1ixwqnn8lsXHII7yhdMaZgB3h35mUR0Uq9U/e0W38xT22GWh8mD
 1YTNm/ntHgyLQ9213wQbXasKjVq2f0QgGAFdt7nSy6/tXDOfLDd0za7KOOCasHjneBV9
 WxfVRGPNclzFy6OWxCdIZfv2dDttKT1FAwORyQbpLf3+npZ7fxbckqHNg4aAukMy5QXm
 4FsiDfCM/1uNnV6PWcXctMDeEhnmRetca85mCSjkRDWq5bdiaE/eIdyzVxJLu2Vswubn
 K+Egd3LGyrKCLiEyna7ZQPFp4ZEq2X/8WYmyFfybe25CQPifmNTYpKf2ClIqKc/7lI02
 cSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790865981; x=1791470781;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hAY8Y7lS5pZSCwwNk0LjwR1o1ybilXeJLRl336PhQCY=;
 b=M/P9TkVc11RapbsI6LJUt569gftker+GBHMTSum8ehJtBHjHp9XDQ3wiUWCBfnA8BB
 lm09OQlIFgActphd23Or2Bbv6mnnqcXnOtLyEOmnKf5+cycmVpLxSu/wFHsykb/GV9+K
 XcY74Y1zRlhOmSkrSpCcaqZwcFkDtiaJJc0YQuenSVy431mUnQaW4eIRGLQKS9Exhg73
 mdv0BnhNZFsfJXvg2Qgzm/D/0ANVH9V7eByhV/dlNmPATROGA5ql6eh3PqmLIcRAIBY5
 13r3m13DmOp1jTiAkgGYlMTS2jxejpYwKrV21rsvkfhEiNwTHxY2SUc78K1JTk6t4uKL
 g1Lw==
X-Gm-Message-State: AFuF++mnaLzB3hnUXQkEe1Io0dYWHefYp933oyY4nA5tXbOL4NzHyEGr
 OijoMXncFs95A6jUF4M+zxvJS6cszq76NsldsQTruLHKochr/w+1HKQm
X-Gm-Gg: AYBFou08oH4b6PQH+k05+mxbWbKYUUbx8suLpq204sKagi0xgMo+hZda7EnkpW0FuTM
 +T7jB4aWc6UiNTDiKTigjqCwdx8ZXJbTuolCRfCBqY9laTNMh3uVKCiVf4Vn0j3XJxBTOQHMESU
 WxtH/SeQhRn2r0+EtaBeLAJgoh1P4m5dBGa46fnY0v37GdlybEDJ+yh7sHE5q8Uo3rjqHHSP2X7
 dm23txeKuUi8nixOExe5WJzoGx9GBqkr06rKiDvN1D6qzEZoNnWrcAmVzuRI+1WVR48uuXpQsNk
 xKk546uwRLyjd/42KlSFsYZ2HXnKerJclYaozzWuSFA9Q/H1KtbSM21EvQvXNuGyQLm3LHlBywo
 E4HhECv5nBglw8G+IcqSyUSRz4TZJxpJ6qrY5KOkoNLKO5SUv69q843XtK1o6i+P0ludBbaEVK1
 Liuj2uv7POTsVcrIJsqgw+WTYgExcUF7BXer0/y65yl2mbs99hrAcAysarl7xpKX6/Oo4r0IVMf
 o19ZZdbzu0W7rfcVxf2IS6SNuH+szsWf/q8tiYK6lTpXQQdzdXNOzOzltTPumhCvzFZ5ZU=
X-Received: by 2002:a05:600c:4f8b:b0:49e:7a10:1b71 with SMTP id
 5b1f17b1804b1-4a01afe1e7dmr82947495e9.11.1790865981016; 
 Thu, 01 Oct 2026 07:46:21 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0272a2071sm762575e9.14.2026.10.01.07.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:46:20 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tom.stdenis@amd.com
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 vitaly.prosyak@amd.com, alexander.deucher@amd.com,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
Date: Thu,  1 Oct 2026 19:46:14 +0500
Message-ID: <20261001144614.249703-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS0PR12MB79937883FC1952B821439A27F78A2@DS0PR12MB7993.namprd12.prod.outlook.com>
References: <DS0PR12MB79937883FC1952B821439A27F78A2@DS0PR12MB7993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On 10/1/26 14:25 UTC, StDenis, Tom wrote:
> I wonder if a similar fix is needed for gprwave reads as well?

I don't think so. amdgpu_debugfs_gprwave_read() reads into a kcalloc()ed
buffer under grbm_idx_mutex and calls put_user() only after
mutex_unlock(); amdgpu_debugfs_wave_read() and amdgpu_debugfs_gpr_read()
do the same. A grep-level scan of drivers/gpu/drm/amd for
get_user()/put_user()/copy_{to,from}_user() between taking and dropping
grbm_idx_mutex or srbm_mutex finds only the four sites this patch
changes. The scan does not follow function calls made under the locks.

v2 with Vitaly's PAGE_SIZE check is being tested; I'll send it once that
run is done.

Thanks,
Mikhail
