Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DF9D43368
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 14:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70AEF10E85C;
	Thu,  7 Nov 2024 14:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="C9mMt3q9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B126310E7F7;
 Thu,  7 Nov 2024 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I/wj5FuLo31/fpnWb4VJXuQTUN+dwPCJttGkV3MBVS0=; b=C9mMt3q9FCa9LTALsiyHOPTo3E
 LPgZcDE3GZNshn3tFJDHp53XdtWHITHZFEMEhj6MVWx7cfC1MyGO/WS22qz+6SadyfWiWNbJhjcHO
 KcLwJYK1XvTdmlwqdFv4fcmFQv/GCaQg+hF7ywKallUVDy8DC/9pWrIVWRxuXBCfN8lVoanHIU+7F
 cos89d4wRQD84M5pGeL+TluKodrCS25OSIWV274sDd9d+0DcyA3iY3QfXiRB4tgqK/xBO1y77M6FQ
 mtKfIyoQDO2vMeo4JVsYqF6fYVPXU42+SiTYJGv0SNIaZhJlTVCJuNV+rBT1ksEpvPO8r5bwi54uP
 h1XrBw5g==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1t8zwo-003WcZ-P4; Thu, 07 Nov 2024 11:41:06 +0100
Message-ID: <b31fd5b2-094a-4d3a-bab9-83102726eefa@igalia.com>
Date: Thu, 7 Nov 2024 10:41:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] drm: add drm_memory_stats_is_zero
To: Yunxiang Li <Yunxiang.Li@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Cc: Alexander.Deucher@amd.com
References: <20241025174113.554-1-Yunxiang.Li@amd.com>
 <20241025174113.554-5-Yunxiang.Li@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20241025174113.554-5-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 07 Nov 2024 14:22:21 +0000
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


On 25/10/2024 18:41, Yunxiang Li wrote:
> Add a helper to check if the memory stats is zero, this will be used to
> check for memory accounting errors.
> 
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/drm_file.c | 9 +++++++++
>   include/drm/drm_file.h     | 1 +
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 714e42b051080..75ed701d80f74 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -859,6 +859,15 @@ static void print_size(struct drm_printer *p, const char *stat,
>   	drm_printf(p, "drm-%s-%s:\t%llu%s\n", stat, region, sz, units[u]);
>   }
>   
> +int drm_memory_stats_is_zero(const struct drm_memory_stats *stats) {
> +	return (stats->shared == 0 &&
> +		stats->private == 0 &&
> +		stats->resident == 0 &&
> +		stats->purgeable == 0 &&
> +		stats->active == 0);
> +}

Could use mem_is_zero() for some value of source/binary compactness.

> +EXPORT_SYMBOL(drm_memory_stats_is_zero);
> +

I am not a huge fan of adding this as an interface as the only caller 
appears to be a sanity check in amdgpu_vm_fini():

	if (!amdgpu_vm_stats_is_zero(vm))
		dev_err(adev->dev, "VM memory stats is non-zero when fini\n");

But I guess there is some value in sanity checking since amdgpu does not 
have a notion of debug only code (compiled at production and exercised 
via a test suite).

I do suggest to demote the dev_err to notice log level would suffice and 
be more accurate.

Regards,

Tvrtko

>   /**
>    * drm_print_memory_stats - A helper to print memory stats
>    * @p: The printer to print output to
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index ab230d3af138d..7f91e35d027d9 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -477,6 +477,7 @@ struct drm_memory_stats {
>   
>   enum drm_gem_object_status;
>   
> +int drm_memory_stats_is_zero(const struct drm_memory_stats *stats);
>   void drm_print_memory_stats(struct drm_printer *p,
>   			    const struct drm_memory_stats *stats,
>   			    enum drm_gem_object_status supported_status,
