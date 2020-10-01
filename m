Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_ADSP_DISCARD,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB77C4727E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 20:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039AE20739
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 20:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="AKREcO2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039AE20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6626E06D;
	Thu,  1 Oct 2020 20:36:18 +0000 (UTC)
Received: from services.gouders.net (services.gouders.net [141.101.32.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ACB56E10F
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 20:35:20 +0000 (UTC)
Received: from localhost (ltea-047-066-024-155.pools.arcor-ip.net
 [47.66.24.155]) (authenticated bits=0)
 by services.gouders.net (8.14.8/8.14.8) with ESMTP id 091KUwWs015548
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Oct 2020 22:30:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
 t=1601584259; bh=tcXFYCXwIwCI0zr467EPsI+J2hd/fK6huawfTzULyJw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=AKREcO2asXJreCy9VrTtaXZChMh6tzgROkz4be+8YT1CVAw5Es7Cqk8FFlrgOU3Xm
 Zd40zGKx7rkZQZaZiscSLEur5ojqxqHE7gWeplJtTnlK/FuNINwlbZWSOD/Qdr1dDe
 DXmProSAompmQKNdLEOCBIOh5a5YSbC9hvjypFpA=
From: Dirk Gouders <dirk@gouders.net>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: fix NULL pointer dereference for Renoir
In-Reply-To: <20201001195525.3477-2-dirk@gouders.net> (Dirk Gouders's message
 of "Thu, 1 Oct 2020 21:55:25 +0200")
References: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
 <20201001195525.3477-2-dirk@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date: Thu, 01 Oct 2020 22:30:51 +0200
Message-ID: <ghh7rdy9hg.fsf@gouders.net>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 01 Oct 2020 20:36:17 +0000
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Christian =?utf-8?Q?K=C3=B6?= =?utf-8?Q?nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dirk Gouders <dirk@gouders.net> writes:

> Commit c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
> introduced a NULL pointer dereference when booting with
> amdgpu.discovery=0, because it removed the call of vega10_reg_base_init()
> for that case.
>
> Fix this by calling that funcion if amdgpu_discovery == 0 in addition to
> the case that amdgpu_discovery_reg_base_init() failed.
>
> Fixes: c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 84d811b6e48b..f8cb62b326d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -694,12 +694,12 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
>  		 * it doesn't support SRIOV. */
>  		if (amdgpu_discovery) {
>  			r = amdgpu_discovery_reg_base_init(adev);
> -			if (r) {
> -				DRM_WARN("failed to init reg base from ip discovery table, "
> -					 "fallback to legacy init method\n");
> -				vega10_reg_base_init(adev);
> -			}
> +			if (r == 0)
> +			  break;

Grrr, wrong indentation here.
But I will wait for your review before v1.

Dirk


> +			DRM_WARN("failed to init reg base from ip discovery table, "
> +				 "fallback to legacy init method\n");
>  		}
> +		vega10_reg_base_init(adev);
>  		break;
>  	case CHIP_VEGA20:
>  		vega20_reg_base_init(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
