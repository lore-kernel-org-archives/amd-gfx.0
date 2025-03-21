Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96AFC36000
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 12:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6325410E79F;
	Fri, 21 Mar 2025 12:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Td8A6HUU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC8610E7BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BL7ImZaRsEZeRngyuUCj9EfcXVJmAQ/w+mFwVpHoDJM=; b=Td8A6HUUs4wd/tJzpekEWjuXKU
 +wIHp6sYI46NM05nWhnG0GiZh7gfjBFw18fyi5Ll5749ibAsNFvYHF6Lgn6beFzql39RytHkf+TEY
 pK4fUpa8+OsLkMMeCGZ9KTusSeiWaufxLxBc1HsWv+f1NVVlTnXdGzESGmT34lGIdVYHSsfkoPpvh
 tjS28v4Plt5eMZ6tXlh46EW6P4GC+UyxWLPFDAQ2TPLK2mgFIXGD5DNc7rDrkUjqbljCS4FdPsIvo
 MNJ0yGGQHKsQ28mQZlOy3LG/aUcv76R2Vandm3+yVKXaXFfaTVYFYb5Tk48S8zpXwOQLcrNh57mc5
 9KspgiMA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tvbri-004CkH-Fw; Fri, 21 Mar 2025 13:52:46 +0100
Date: Fri, 21 Mar 2025 06:52:41 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com,
 mario.limonciello@amd.com, alex.hung@amd.com
Subject: Re: [PATCH] drm/amd/display: add proper error message for vblank init
Message-ID: <kmohyruis2z2bkzh7jrhmzi5mu4xj4jj7w6eg5vtprr4zrd66l@zcaedvfkt2vs>
References: <20250321113704.390163-1-saleemkhan.jamadar@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321113704.390163-1-saleemkhan.jamadar@amd.com>
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

On 03/21, Saleemkhan Jamadar wrote:
> Update message to identifiy the vblank initialization fail case
> 
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8dd9bf58eac5..3decf1973c7d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2218,7 +2218,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  
>  	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
>  		DRM_ERROR(
> -		"amdgpu: failed to initialize sw for display support.\n");
> +		"amdgpu: failed to initialize vblank sw for display support.\n");
>  		goto error;
>  	}
>  
> -- 
> 2.34.1
>

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com> 

-- 
Rodrigo Siqueira
