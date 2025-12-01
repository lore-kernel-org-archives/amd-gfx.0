Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA5ED116E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 04:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C0F10E0C7;
	Mon,  1 Dec 2025 04:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KDVdlW7w";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4EC10E0C7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 04:48:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 53F6F443B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 04:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4D5C4CEF1;
 Mon,  1 Dec 2025 04:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764564501;
 bh=tXTkGk9AVU2cF70swymPSF0QPDBYWv64Ped9YpbakGA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KDVdlW7whBKPTOH6gUVtPN9U2Tc5zu57X25+D/Y4PmwnS4gctIs3Xc8mpoRqeqfEy
 It0iB9wDGFPlRc4tfDR21jyqBOYri/Sw3uWoIHeHUpTfJKa6bzTAX2kZfoiF5zwWEc
 wfyDoWxA+BNj5XkliIObCEag44vNtu0o1A0GinMMVlhRp9AjntH69UAVWbu3T6ENKj
 RkXhu7RSbrfy/DpGwKYPf7+xhiKSt0Bxz4RVGKxWZjDMbgidA5X0OFDHxsl3pQjAC2
 6Ej9vkhCSCNd3JUCeoT9vla/pHrTij7VJpifQ58hVSZoaggI5guk4u3OH5FItd7YC6
 aHmYpcchLQZVg==
Message-ID: <ad10d9ef-c769-49ba-ad12-3d2b5ab7f1e1@kernel.org>
Date: Sun, 30 Nov 2025 22:48:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd: Skip power ungate during suspend for VPE"
To: amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20251130014631.29755-1-superm1@kernel.org>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251130014631.29755-1-superm1@kernel.org>
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



On 11/29/2025 7:46 PM, Mario Limonciello (AMD) wrote:
> Skipping power ungate exposed some scenarios that will fail
> like below:
> 
> ```
> amdgpu: Register(0) [regVPEC_QUEUE_RESET_REQ] failed to reach value 0x00000000 != 0x00000001n
> amdgpu 0000:c1:00.0: amdgpu: VPE queue reset failed
> ...
> amdgpu: [drm] *ERROR* wait_for_completion_timeout timeout!
> ```
> 
> The underlying s2idle issue that prompted this commit is going to
> be fixed in BIOS.
> This reverts commit 31ab31433c9bd2f255c48dc6cb9a99845c58b1e4.
> 
> Fixes: 31ab31433c9bd ("drm/amd: Skip power ungate during suspend for VPE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

This was reported by a few people tangentially to me reproducing it 
myself and coming up with the revert.

Here's some more tags to include with the revert.

Reported-by: Konstantin <answer2019@yandex.ru>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220812
Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 076bbc09f30ce..2819aceaab749 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3414,11 +3414,10 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>   		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
>   		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
>   			continue;
> -		/* skip CG for VCE/UVD/VPE, it's handled specially */
> +		/* skip CG for VCE/UVD, it's handled specially */
>   		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_UVD &&
>   		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VCE &&
>   		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VCN &&
> -		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VPE &&
>   		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_JPEG &&
>   		    adev->ip_blocks[i].version->funcs->set_powergating_state) {
>   			/* enable powergating to save power */

