Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1506D41D6B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 08:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4625410E587;
	Tue, 12 Nov 2024 08:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; secure) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="MnMD4gZC";
	dkim-atps=neutral
X-Greylist: delayed 313 seconds by postgrey-1.36 at gabe;
 Mon, 11 Nov 2024 20:31:10 UTC
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
 by gabe.freedesktop.org (Postfix) with ESMTP id C461810E53F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
 t=1731356756; bh=f12Z0l5+q1Mb25CB1gBmGkxSbC3V/vG7Jp8uQvrBwHw=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=MnMD4gZCgKkvucdJ6BWoe54cTw891eoy2yRPE+kYAmW55LmGBqFTzJk/sopy+ErET
 XurkYRuTUALfZOyC3p9rl/UXdHk0rRpYhQg3HxJDyDEromAQd47HTcVxfEQ+q8bx+2
 uRbFqPII/dVIHzz0PP97BX9qFrBBVcRwTdUJlGAM7MufFv+bWKVTaEXrqcLrgd+XME
 ZP9jjCS4A3nfxKd8gUcleE4vjIj3OqMaJkaJXiOs+LABYd1fmNgfeTlxcto7llD0TI
 CBdfiIHo3BdSzLhfw/6HL9NOqKBHvnB80U8N9R3xlJD5oVtbmo3/nEZx4dmGawx5z0
 8dSk5rbM19KIlblT23OFIubdunZuJJuT08oXHnv8NINAL4pLMaUagH82EwZUDju5ca
 0uF97yadPj4GiLcr9QcB+QJ9Wd7UCSzv0cpD6vgV4N5XsacZEUp+r7z3DoTmbLOvck
 bGyHIrQXz/AgbSb9s0iWK0PKzVw1oUFD4okGflM8oHJXlbfbXR9D1Bm/vywYkhHHGw
 F1DGTLkzMBchljR16Tb9OWWKWjenBliO7IRXCvS3DjBu7ZY1Z2Flzfzy1ARp8hhuGz
 Fb6OCkNsMKIAfabmsKBAJemd+TR9yhkg6KCG/lPHiwzBi22XQJsEKtxQ515BILxWp0
 kiCPnXWaN4R9MXN9G/FZdQEc=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl
 [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
 by bout3.ijzerbout.nl (Postfix) with ESMTPSA id B85F118DC0F;
 Mon, 11 Nov 2024 21:25:56 +0100 (CET)
Message-ID: <48f068e8-b542-4449-bb75-4e8409306347@ijzerbout.nl>
Date: Mon, 11 Nov 2024 21:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
 amdgpu_compute_sched_mask debugfs
To: Jesse Zhang <Jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241018023054.1601248-1-jesse.zhang@amd.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241018023054.1601248-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 08:40:19 +0000
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

Op 18-10-2024 om 04:30 schreef jesse.zhang at amd.com (Jesse.zhang@amd.com):
> compute/gfx may have multiple rings on some hardware.
> In some cases, userspace wants to run jobs on a specific ring for validation purposes.
> This debugfs entry helps to disable or enable submitting jobs to a specific ring.
> This entry is populated only if there are at least two or more cores in the gfx/compute ip.
>
> Signed-off-by: Jesse Zhang <jesse.zhang at amd.com>
> Suggested-by:Alex Deucher <alexander.deucher at amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     | 142 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h     |   2 +
>   3 files changed, 146 insertions(+)
>
> [...]
> +
> +void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
> +	struct dentry *root = minor->debugfs_root;
> +	char name[32];
> +
> +	if (!(adev->gfx.num_compute_rings > 1))
> +		return;
> +	sprintf(name, "amdgpu_compute_sched_mask");
> +	debugfs_create_file(name, 0600, root, adev,
> +			    &amdgpu_debugfs_compute_sched_mask_fops);
> +#endif
> +}
>
Hi Jesse,

Can you please eliminate name[32]? There is absolutely no need
to copy the filename in a buffer. Also, using sprintf this way is
weird too.

Just do
     debugfs_create_file("amdgpu_compute_sched_mask", 0600, root, adev, ...

The same for amdgpu_debugfs_gfx_sched_mask_init() of course.
-- 
Kees
