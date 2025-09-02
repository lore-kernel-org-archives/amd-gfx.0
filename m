Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97923CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 17:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E1910E804;
	Tue,  2 Sep 2025 17:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uyOV2ZGi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B79C10E804
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 17:41:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D4AE6000A;
 Tue,  2 Sep 2025 17:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4465C4CEF5;
 Tue,  2 Sep 2025 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1756834901;
 bh=J7w3TFR3s2XVr+RI2tuanWa/2oVErxmKQPnWo5hM7q0=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=uyOV2ZGi9exmLYR5tcyxekY4vAL0rmRNRI1TSuvU282B1d2vAmIeOYumX4ri3uwO1
 4JRd78hOCWxLaNa/s2Eatxg2P1Fl8ohXJ8qQ8BUwH12Gq1I7+7Ypnm+24uko3jv6Pz
 qtrEC8Hrh31+Ly7tXX4jg+mvEcN/REhBg72y8qXaHvwnEyT8JNNlQpp4uLkeZWtMHt
 2C8RkfqXR+sDtUCJxDNvGTacf2u0Ques1+WKXziDxS7lNB5Iks+KkAu3HVdZ5QISk7
 aR71NxZXqoRcjEuc3AOX/HSr+vfrCxYZe9xlgwl/9dPFjJpjZXqrylhLVw1ZJfVbkg
 ftEGJDa9+ihdA==
Message-ID: <ae2182ad-2894-4ce8-a319-8410eb990022@kernel.org>
Date: Tue, 2 Sep 2025 12:41:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Increment drm driver minor version for list
 handles ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250829183016.1342823-1-David.Francis@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250829183016.1342823-1-David.Francis@amd.com>
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

On 8/29/2025 1:30 PM, David Francis wrote:
> With the addition of the drm ioctl
> DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES,
> the drm driver version should be incremented (to 65)
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b42a2a32b0b7..e098a553d12b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -128,7 +128,7 @@
>    * - 3.64.0 - Userq IP support query
>    */
>   #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	64
> +#define KMS_DRIVER_MINOR	65
>   #define KMS_DRIVER_PATCHLEVEL	0
>   
>   /*

Can you please update the comment above the define to indicate what 
changed at the bump to 65?
