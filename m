Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58B4C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 22:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722BF10F3D0;
	Fri, 21 Aug 2026 22:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P5/l8zXI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E52110F3D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 22:03:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D801F600E2;
 Fri, 21 Aug 2026 22:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24101F000E9;
 Fri, 21 Aug 2026 22:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787349777;
 bh=3Q5J5tTJbrpaiyJRlU0/x3aWp3lwPiZOEBUqdsxWt8Q=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=P5/l8zXIy3dibYTB5ugf7z/kOTNjC9S+S6j0ur20RHSndT3MqHi6+EbSyjQEl5MSQ
 kuMvTPq6ZebfyG0rdo0OMZBuDuoW3aJCedyVJanA2q8XH6wX43bqv2x4Q/+gwtmlir
 cl2PM3BPbSL5KCSbk6889ncxbGKPqqRHcmnmYtcKqNe0lDOFnF94fzHUG2CvRYs9IT
 +dotYKaIhhGShoDJM8R7bU3iSxcCsFwz//rcj+G1iTcTE3W8W5A/dRqGQ1+CzEsKgX
 R0uj9SibncAfuKhflAVBlbzEuk0V48BgGjlJou19MZoIhTg/DY3p5ZUMPswjOd8pml
 mip2TQZVg6x8Q==
Message-ID: <9a929a5f-0008-4daf-9aa4-7828906ed95e@kernel.org>
Date: Fri, 21 Aug 2026 17:02:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: Log details when failing to register
 HPD IRQ
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Melissa Wen <mwen@igalia.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>
References: <20260821215059.312868-1-timur.kristof@gmail.com>
 <20260821215059.312868-2-timur.kristof@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260821215059.312868-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 8/21/26 16:50, Timur Kristóf wrote:
> This should help diagnose HPD IRQ related issues in the future.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

I'll get this committed to amd-staging-drm-next.

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 9be63996b062..d0239a3de2e1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -1735,7 +1735,9 @@ int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev)
>   			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
>   				int_params.irq_source  < DC_IRQ_SOURCE_HPD1 ||
>   				int_params.irq_source  > DC_IRQ_SOURCE_HPD6) {
> -				drm_err(adev_to_drm(adev), "Failed to register hpd irq!\n");
> +				drm_err(adev_to_drm(adev),
> +					"Failed to register hpd irq %u for %s!\n",
> +					int_params.irq_source, connector->name);
>   				return -EINVAL;
>   			}
>   
> @@ -1753,7 +1755,9 @@ int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev)
>   			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
>   				int_params.irq_source  < DC_IRQ_SOURCE_HPD1RX ||
>   				int_params.irq_source  > DC_IRQ_SOURCE_HPD6RX) {
> -				drm_err(adev_to_drm(adev), "Failed to register hpd rx irq!\n");
> +				drm_err(adev_to_drm(adev),
> +					"Failed to register hpd rx irq %u for %s!\n",
> +					int_params.irq_source, connector->name);
>   				return -EINVAL;
>   			}
>   

