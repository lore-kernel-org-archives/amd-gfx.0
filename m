Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCFCFD8FCE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 16:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE8110E9A3;
	Thu, 26 Feb 2026 16:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bt9cTTes";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27D110E9A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xhx1DGZyXsgz41rg8zYEOGoPHDmPRoCfYoI7lacnglY=; b=bt9cTTesUsprH0kPsAMzUyMB7R
 1dEAUtuKbx/wDL1IC7DyRizDf/OUeMUkfE3nDcNqLAlCaCgiGB4eTGEznC5MlMpTq1dF4Yo7iN4VH
 3O6jpAbWPR1nsQ0psDxa+6Hv33MWPZmEuTPQGGFY4zVJM+b09tonfhKUrwu8nfDVz6yObF5Tntntc
 1vsRuVlCefMan27tYk7yh/3GEXZXbmTOl0yORcEAV9j5DEhQDA/cZ8UwzxoedBX4gmM3TypnezVz1
 ApAXIpiBDGlYjRV42SG5SnTpQ2IIAtyS5LfTAftrkXK2pwcpTKSS04DPMr/s+r0mfN7S0UeydEYi9
 l0GmJZVA==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vvdsA-005kPJ-1S; Thu, 26 Feb 2026 17:05:54 +0100
Message-ID: <e93f64b2-8157-4cc8-b4b9-16572a8cd022@igalia.com>
Date: Thu, 26 Feb 2026 16:05:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update type for num_syncobj_handles in
 drm_amdgpu_userq_signal
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260226155146.3727191-1-sunil.khatri@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260226155146.3727191-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 26/02/2026 15:51, Sunil Khatri wrote:
> update the type for num_syncobj_handles from __u64 to _u16 with
> required padding.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 33e8738ce91f..42b4c0f6746b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -479,7 +479,9 @@ struct drm_amdgpu_userq_signal {
>   	 * @num_syncobj_handles: A count that represents the number of syncobj handles in
>   	 * @syncobj_handles.
>   	 */
> -	__u64	num_syncobj_handles;
> +	__u16	num_syncobj_handles;

Could probably cause build warnings/errors for something which builds 
fine today. Hm on big endian it actually breaks completely.

Regards,

Tvrtko

> +	__u16	pad0;
> +	__u32	pad1;
>   	/**
>   	 * @bo_read_handles: The list of BO handles that the submitted user queue job
>   	 * is using for read only. This will update BO fences in the kernel.

