Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8265ED29C43
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 16:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FAA110E4CD;
	Mon, 19 Jan 2026 16:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KS1kRhM9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E970610E4CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 16:46:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DC60260054;
 Mon, 19 Jan 2026 16:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ECFC116C6;
 Mon, 19 Jan 2026 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768841210;
 bh=eEKI3ZxObO3QdCFTxioSzIqvkSxosaz3PRzA18FtArw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KS1kRhM95kcjx9W2tKdUO585ojluwmML1rh1jAzfwUxD79n8xEO/sTbzU+FFsrWCT
 zvRjXwQu859f/OjmbrW5b4tNlZVx3phi79Zm99sZABzwpi3hZjOV+FcwGYQpqRqyE5
 WJVEKMF8cR1U5nwZVVm7AjU8LqydH5H4UloPkTZJ/GnZkJigWUnASPROGcqUNpH6k7
 KX5SVhUwdY/nX24k4V0nAEKWXP4sjIqVL8BRluRN6oTS7pqNXJOY7r3JZYojCBOl0C
 FDp8cWREZHigCH1ZrBvoz8AgXbKUYd/sVIYbWvR5q73CMNZVbqESag0os04jq3DiL5
 r85CmzJCzkG4Q==
Message-ID: <da7fec1c-f25d-49d5-99e3-99f42ffb802a@kernel.org>
Date: Mon, 19 Jan 2026 10:46:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Only poll analog connectors
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20260118130345.43356-1-timur.kristof@gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260118130345.43356-1-timur.kristof@gmail.com>
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



On 1/18/2026 7:03 AM, Timur Kristóf wrote:
> Analog connectors may be hot-plugged unlike other connector
> types that don't support HPD.
> 
> Stop DRM from polling other connector types that don't
> support HPD, such as eDP, LVDS, etc. These were wrongly
> polled when analog connector support was added,
> causing issues with the seamless boot process.
> 
> Fixes: c4f3f114e73c ("drm/amd/display: Poll analog connectors (v3)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 0a2a3f233a0e..e7b0928bd3db 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -915,13 +915,19 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>   		struct amdgpu_dm_connector *amdgpu_dm_connector;
>   		const struct dc_link *dc_link;
>   
> -		use_polling |= connector->polled != DRM_CONNECTOR_POLL_HPD;
> -
>   		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
>   			continue;
>   
>   		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
>   
> +		/*
> +		 * Analog connectors may be hot-plugged unlike other connector
> +		 * types that don't support HPD. Only poll analog connectors.
> +		 */
> +		use_polling |=
> +			amdgpu_dm_connector->dc_link &&
> +			dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id);
> +
>   		dc_link = amdgpu_dm_connector->dc_link;
>   
>   		/*

