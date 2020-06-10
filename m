Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF1CC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 10:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5350E20656
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 10:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="QIwAgYRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5350E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F116E523;
	Wed, 10 Jun 2020 10:26:00 +0000 (UTC)
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DCB6E0BC;
 Wed, 10 Jun 2020 10:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id E15653F9F5;
 Wed, 10 Jun 2020 12:25:56 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="QIwAgYRB";
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
 by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e4UsNpfjkLuV; Wed, 10 Jun 2020 12:25:56 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se
 [155.4.205.35]) (Authenticated sender: mb878879)
 by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 2428A3F4CA;
 Wed, 10 Jun 2020 12:25:53 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se
 [155.4.205.35])
 by mail1.shipmail.org (Postfix) with ESMTPSA id 25F71360060;
 Wed, 10 Jun 2020 12:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1591784753; bh=wU8RKATsV6OHlRI0fpBbOdnJVaB9z2zis0YvRywgYtQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=QIwAgYRBj9TuooCL9Dj4Kj+d3aveIvKWfmhMP8O6s+m0rhfvvfUNezMpy4to4a5CF
 zxtqXe67Rs/YgxndNbGHb+Nqn91edpxLOBRymBo+kpI/UziRu8Xt3ynQ+oBq6UwdC8
 wCt00s4FY0zk8o5BSAsHbdVbAj5jKenDPtD8edls=
Subject: Re: [PATCH 5/6] drm/ttm: Add destroy flag in TTM BO eviction interface
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <1589050310-19666-1-git-send-email-andrey.grodzovsky@amd.com>
 <1589050310-19666-6-git-send-email-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
Message-ID: <dd61e068-cbf1-c612-2c7f-f1e7786b16f7@shipmail.org>
Date: Wed, 10 Jun 2020 12:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589050310-19666-6-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
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
Cc: daniel.vetter@ffwll.ch, michel@daenzer.net,
 ckoenig.leichtzumerken@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/9/20 8:51 PM, Andrey Grodzovsky wrote:
> This will allow to invalidate, destroy backing storage and notify users
> of BOs when device is unpluged.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Please add a motivation in the commit message and use imperative wording 
("Allow to invalidate..." instead of "This will allow to")

s /unpluged/unplugged/


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  2 +-
>   drivers/gpu/drm/nouveau/nouveau_drm.c       |  2 +-
>   drivers/gpu/drm/qxl/qxl_object.c            |  4 +--
>   drivers/gpu/drm/radeon/radeon_object.c      |  2 +-
>   drivers/gpu/drm/ttm/ttm_bo.c                | 41 ++++++++++++++++++-----------
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c         |  6 ++---
>   include/drm/ttm/ttm_bo_api.h                |  2 +-
>   8 files changed, 35 insertions(+), 26 deletions(-)
>
> diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
> index b9bc1b0..9d57b8c 100644
> --- a/include/drm/ttm/ttm_bo_api.h
> +++ b/include/drm/ttm/ttm_bo_api.h
> @@ -597,7 +597,7 @@ int ttm_bo_clean_mm(struct ttm_bo_device *bdev, unsigned mem_type);
>    * -ERESTARTSYS: The call was interrupted by a signal while waiting to
>    * evict a buffer.
>    */

Please also update the function documentation.

> -int ttm_bo_evict_mm(struct ttm_bo_device *bdev, unsigned mem_type);
> +int ttm_bo_evict_mm(struct ttm_bo_device *bdev, unsigned mem_type, bool destroy);
>   
>   /**
>    * ttm_kmap_obj_virtual


Thanks,

Thomas


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
