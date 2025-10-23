Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626B5CCD1BF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 22:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E191110E97A;
	Thu, 23 Oct 2025 22:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ePTgxZUx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C49810E97A
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 22:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xt3XTqZiLRiEZ+mIwyWdKHeKc3G5C2bO17WjB/HEpRQ=; b=ePTgxZUxV2UJCJ5jyYccYCygJV
 hFDxTwEXv6WBl8kjdQNPoK+GxLtJBE7GXSme6KevnZjiB2ml+QTm3wClcFgMfbiEdwqBZnVrXsz6T
 wiRqunVC2ELrqgmck521sY3QDCvmIF6YeDxtIXgR67M5Yus4qXRB5WTppO/L/bCebwVBEN9Yy00Pf
 ie7tg5vWRtIEOrwTNKI7c/lytywFNc3X1egl45npmSc0bvNJK9khGXdTZpaa6zl7TmKaHeSzyHm3C
 xW5OPuiYMu650oNkaEieYfEjAUw4h/+Xw7sRNFiPgSCmviTVi3KudOaDrdvmXEPahR8oTWQl4xXHo
 pMTR9NbA==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vC485-00DpgR-Or; Fri, 24 Oct 2025 00:49:58 +0200
Date: Thu, 23 Oct 2025 16:49:54 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Robert Beckett <bob.beckett@collabora.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
Message-ID: <pr56g6xi5ji7mrcfjr5uh6uwwf4wmbrfi2gnbdwhokowovwsk6@qvump5zll6vl>
References: <20251020161606.67812-1-siqueira@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020161606.67812-1-siqueira@igalia.com>
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

On 10/20, Rodrigo Siqueira wrote:
> When trying to unload amdgpu in the SteamDeck (TTY mode), the following
> set of errors happens and the system gets unstable:
> 
> [..]
>  [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
>  amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on gfx_0.0.0 (-110).
>  amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
> [..]
>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
>  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> [..]
> 
> When the driver initializes the GPU, the PSP validates all the firmware
> loaded, and after that, it is not possible to load any other firmware
> unless the device is reset. What is happening in the load/unload
> situation is that PSP halts the GC engine because it suspects that
> something is amiss. To address this issue, this commit ensures that the
> GPU is reset (mode 2 reset) in the unload sequence.
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0d5585bc3b04..0a7bcb2d5a50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3649,6 +3649,13 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>  				"failed to release exclusive mode on fini\n");
>  	}
>  
> +	/* Reset the device before entirely removing it to avoid load issues
> +	 * caused by firmware validation.
> +	 */
> +	r = amdgpu_asic_reset(adev);
> +	if (r)
> +		dev_err(adev->dev, "asic reset on %s failed\n", __func__);
> +
>  	return 0;
>  }
>  
> -- 
> 2.51.0
>

Hi Alex,
If this change is okay with you, may I send a revert for the change below?

 72a98763b473890e6605604bfcaf71fc212b4720 - drm/amd: fix gfx hang on renoir in IGT reload test

The above change adds GPU reset during load time.

Thanks

-- 
Rodrigo Siqueira
