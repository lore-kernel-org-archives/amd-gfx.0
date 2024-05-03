Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC560C10F16
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 13:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D432112051;
	Fri,  3 May 2024 13:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jAoNCUWy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC631129C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mEr5j+c2TAEn4GYoHu9Q1dUlYs4h9AAFVpkf8vU3MyE=; b=jAoNCUWyvUoOR4uaMCEYq9PI9T
 wh9s1ZOyTvGSHK2rBnQzSYDGj+KJSlrdZPfQOdHlvldGmseoSDosNP6RAI1It71vN2SEmt1ny0HsD
 Db0YLdQiB9XraJFvXIwDTb/kYQyY5NhoIlO+Oia+wDkMsW8bvV22NCLTlyi73xxNT9xBIpg62pSUe
 URCDxRWciWd33Zb8sDirJVBhai6ysrjMsOTZkjkPui1dZyCBg8jMqeDDr2PP6rgk59Fx1JRlY4Qwr
 m37B57xQA0AUH4ECpZ1Zy8E1FEieqBDaMQtT/oHlwAUcOCMM8Cgs0C4YDn4/81obwQHy7X3xMgACS
 zC6oUcJA==;
Received: from [84.65.0.132] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1s2sDG-0007WH-SO; Fri, 03 May 2024 14:40:31 +0200
Message-ID: <736ba0a2-035b-4727-bbcc-437029420377@igalia.com>
Date: Fri, 3 May 2024 13:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/gpu: Document the situation with
 unqualified drm-memory-
Content-Language: en-GB
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Rob Clark <robdclark@chromium.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240503123657.9441-1-tursulin@igalia.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20240503123657.9441-1-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 May 2024 13:10:22 +0000
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


[Correcting Christian's email]

On 03/05/2024 13:36, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Currently it is not well defined what is drm-memory- compared to other
> categories.
> 
> In practice the only driver which emits these keys is amdgpu and in them
> exposes the total memory use (including shared).
> 
> Document that drm-memory- and drm-total-memory- are aliases to prevent any
> confusion in the future.
> 
> While at it also clarify that the reserved sub-string 'memory' refers to
> the memory region component.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.keonig@amd.com>

Mea culpa, I copied the mistake from 
77d17c4cd0bf52eacfad88e63e8932eb45d643c5. :)

Regards,

Tvrtko

> Cc: Rob Clark <robdclark@chromium.org>
> ---
>   Documentation/gpu/drm-usage-stats.rst | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index 6dc299343b48..ef5c0a0aa477 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -128,7 +128,9 @@ Memory
>   
>   Each possible memory type which can be used to store buffer objects by the
>   GPU in question shall be given a stable and unique name to be returned as the
> -string here.  The name "memory" is reserved to refer to normal system memory.
> +string here.
> +
> +The region name "memory" is reserved to refer to normal system memory.
>   
>   Value shall reflect the amount of storage currently consumed by the buffer
>   objects belong to this client, in the respective memory region.
> @@ -136,6 +138,9 @@ objects belong to this client, in the respective memory region.
>   Default unit shall be bytes with optional unit specifiers of 'KiB' or 'MiB'
>   indicating kibi- or mebi-bytes.
>   
> +This is an alias for drm-total-<region> and only one of the two should be
> +present.
> +
>   - drm-shared-<region>: <uint> [KiB|MiB]
>   
>   The total size of buffers that are shared with another file (e.g., have more
> @@ -145,6 +150,9 @@ than a single handle).
>   
>   The total size of buffers that including shared and private memory.
>   
> +This is an alias for drm-memory-<region> and only one of the two should be
> +present.
> +
>   - drm-resident-<region>: <uint> [KiB|MiB]
>   
>   The total size of buffers that are resident in the specified region.
