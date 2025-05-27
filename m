Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE11DC54F30
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 16:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4673310E01F;
	Tue, 27 May 2025 16:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PpCOX5os";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FE410E15F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Ym8zjHHdncmlqF2oYhCtOjMC3M6BHIsa9W83aTKBDU=; b=PpCOX5os7xAJYG011u9hTxgCoP
 qgoW8HT8ZUKMV8UNgijrBpnubkXza+SS0weVtckYt+lukp/gB+ddCt8/zx3JQ4ZmCwIuBI+dnLpFz
 8ze2e0qRpZPe2xpjHcGISa3rE/FwUceVc0h42tmNiKrcQtC9mMe1WtsT14tSbzo+fQWEtdq1GXeNr
 V6WU/Pf8jb3z82Mp0AGnswFhB0GWYNPK9d9L7AWFfaAccFI+379RN94dgx5/1AI7/6MbIWYbx9Kk4
 WPXBRkiM7n5gIf3W7Mx6f0vFZfxIINrTUvmddhwUukmYZigwUsRHoyJI+viGlO+HDsY+mRx+lbSg8
 LUJ0MxSQ==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uJxQd-00Dr49-3V; Tue, 27 May 2025 18:45:27 +0200
Date: Tue, 27 May 2025 10:45:23 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Subject: Re: [PATCH 01/10] Revert "drm/amd/amdgpu: add pipe1 hardware support"
Message-ID: <ifaonlhubwsgbz3xxbkyqhyttuebk4ro2u2kpzrbrvcuhqdgch@zkyr7xci64rv>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <20250522215559.14677-2-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250522215559.14677-2-alexander.deucher@amd.com>
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

On 05/22, Alex Deucher wrote:
> This reverts commit b7a1a0ef12b81957584fef7b61e2d5ec049c7209.
> 
> A user reported stuttering under heavy gfx load with this commit.
> I suspect it's due to the fact that the gfx contexts are shared
> between the pipes so if there is alot of load on one pipe, we could
> end up stalling waiting for a context.

Is there any mechanism to check the load per pipe? Debugfs? UMR?

> 
> On top of that, disabling the second pipe may fix the reliability
> of vmid resets.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3519

btw, since this patch addresses an issue with Gitlab, should it be sent
outside of this series?

Thanks

> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 75ea071744eb5..14cbd1f08eb5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4781,7 +4781,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	case IP_VERSION(10, 3, 3):
>  	case IP_VERSION(10, 3, 7):
>  		adev->gfx.me.num_me = 1;
> -		adev->gfx.me.num_pipe_per_me = 2;
> +		adev->gfx.me.num_pipe_per_me = 1;
>  		adev->gfx.me.num_queue_per_pipe = 2;
>  		adev->gfx.mec.num_mec = 2;
>  		adev->gfx.mec.num_pipe_per_mec = 4;
> -- 
> 2.49.0
> 

-- 
Rodrigo Siqueira
