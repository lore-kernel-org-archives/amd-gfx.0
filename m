Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3847CC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 22:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BF42053B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 22:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1QR3m2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BF42053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D206E9B5;
	Tue, 10 Dec 2019 22:18:47 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F7C6E9B5;
 Tue, 10 Dec 2019 22:18:46 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p9so4940504wmc.2;
 Tue, 10 Dec 2019 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/xeSJ1vVQGbd+lIc7YdzwAZ3r9lP4F35wcBj4c6Z8vM=;
 b=B1QR3m2HFzPOE0yEbMaZ1Sv5w1g+5+FM6cKF0BpNVupNgtuHvgoHSP7I3Ziag9IEx1
 nSVN5CjtjtmnmRmVAxT0qR1PQBTISWoP5nlGxR/74CBAwLEX4RLUCUSjKS0HZ6qS4ybG
 vew9E7FQWm5s6CIZnCYXKkrVaYcaYteviw9EajeSB26BxomxoMM0kJSvZugp8yj15Lu5
 fyuej3mOWV8JZDG8Evb4K2KwBo/i78gQ3qjzTw7OedgXfxux3nv7MBeG00X5+hIrC3uB
 SjgBDVMv5v15UTvH+HkbnSNLb1Dk+kJcuJdLPYH+SlRYf87GGIlcViMdZ3gRriu3pw9Q
 PxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/xeSJ1vVQGbd+lIc7YdzwAZ3r9lP4F35wcBj4c6Z8vM=;
 b=C8ngjo2eIlkfo6Qlyma/liXH3/PWe2UNPGNSRLd9rPqxPNR5OL/+AHnpCS6n/vu6wx
 NjtA68w42HqLvgdbB1kRYkP92rBicBBdpj4R3GciFugYPwZUPv3fo+Z5i1Ad2cX4ghq6
 FxWD1Z2Y98G6LIWB4yPA4gGNrLwFZ4jJVABAeoyAfY64akXPAf88j+WIw+IcDKrY9V0N
 7assg8ou43xEPvd1YFaM0sSYWuQLsCuuoKdR1+pJQxcjGd2ZdEQl34euaQLTMVtKr+gI
 uvQZB97AKg4SEsKdh4AY6mbPq1fLKsTa+12dXRH8XkqSa7vaP7481w04Mgn2osjmrPcv
 4bwA==
X-Gm-Message-State: APjAAAVwErpOQac9eyFGQ+RiRUHMj0AuHSfGZNbGlEM5VnFvdxLRhmSv
 EoAwZUbt49F2mBaiMB9Ax+fincsgsZ1B9B3VzSo=
X-Google-Smtp-Source: APXvYqzLcz+L/kcYgFcxP6XewiOkpSfkoPwGQbtDouaQraSVktzlPiRm+eotTeS8npUt7k71bLFPIMThugyJTYeKi8M=
X-Received: by 2002:a1c:4454:: with SMTP id r81mr7591380wma.143.1576016324848; 
 Tue, 10 Dec 2019 14:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20191210195941.931745-1-arnd@arndb.de>
In-Reply-To: <20191210195941.931745-1-arnd@arndb.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Dec 2019 17:18:31 -0500
Message-ID: <CADnq5_Ou91nmzTc6mAugpbML4XqrYfSg0jcx7U9yb=X3LSmZiA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: include linux/slab.h where needed
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Michael Strauss <michael.strauss@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Dec 10, 2019 at 2:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Calling kzalloc() and related functions requires the
> linux/slab.h header to be included:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In function 'dcn21_ipp_create':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:679:3: error: implicit declaration of function 'kzalloc'; did you mean 'd_alloc'? [-Werror=implicit-function-declaration]
>    kzalloc(sizeof(struct dcn10_ipp), GFP_KERNEL);
>
> A lot of other headers also miss a direct include in this file,
> but this is the only one that causes a problem for now.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index 906c84e6b49b..af57885bbff2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -23,6 +23,8 @@
>   *
>   */
>
> +#include <linux/slab.h>
> +
>  #include "dm_services.h"
>  #include "dc.h"
>
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
