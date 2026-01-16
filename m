Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79242C982CD
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 15:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142DD10E8C0;
	Fri, 16 Jan 2026 15:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="laltpRYy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDA510E8C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 15:07:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E519B6016F;
 Fri, 16 Jan 2026 15:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFACC116C6;
 Fri, 16 Jan 2026 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768576025;
 bh=Pz8ztduKDZpRKO0ccE0abw9KU6bswUfzPk/s9t7qgpE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=laltpRYy7BlQk3jGZ/iYoz22mHPNlRBw61pbZUfKjuHMB7gDB8atR52UMQ9WfWAcc
 ntlkG9TQlUSNKAIycl6HdJYYvWHLCIdkAh03LU6Lohsii+boxjcDd33eeWsO/e4be8
 eS+vak3OUevh+Scd2GyMA0F/GThBGL4Ydj7bh6wZO598SY+ndW0EPxQ62sxWFNIWm2
 cxdmekKiNUGcPSzfYr59uH6ulfj565M2+0JldHzOyT+O7ivxpE/BOz3rJH2Z5x1BAi
 Soz5PQye8sHIVri6WFWdNpNxG/xvtzsi6Vq7az1DYbIAL7nOWX3YLpJNduOPs/Rhpw
 BW/MY89p/i0Pg==
Message-ID: <6fe1eca2-2b4c-4852-b4ee-a87abc92a6de@kernel.org>
Date: Fri, 16 Jan 2026 09:07:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Clear HDMI HPD pending work only if it
 is enabled
To: IVAN.LIPSKI@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20260116150411.1110886-1-IVAN.LIPSKI@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260116150411.1110886-1-IVAN.LIPSKI@amd.com>
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



On 1/16/2026 9:03 AM, IVAN.LIPSKI@amd.com wrote:
> From: Ivan Lipski <ivan.lipski@amd.com>
> 
> [Why&How]
> On amdgpu_dm_connector_destroy(), the driver attempts to cancel pending
> HDMI HPD work without checking if the HDMI HPD is enabled.
> 
> Added a check that it is enabled before clearing it.
> 
> Fixes: d98e9c0497ae ("drm/amd/display: Add an hdmi_hpd_debounce_delay_ms module")
> 
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 655c9fcb078a..cba7546d3f95 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7743,10 +7743,12 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>   		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
>   
>   	/* Cancel and flush any pending HDMI HPD debounce work */
> -	cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
> -	if (aconnector->hdmi_prev_sink) {
> -		dc_sink_release(aconnector->hdmi_prev_sink);
> -		aconnector->hdmi_prev_sink = NULL;
> +	if (aconnector->hdmi_hpd_debounce_delay_ms) {
> +		cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
> +		if (aconnector->hdmi_prev_sink) {
> +			dc_sink_release(aconnector->hdmi_prev_sink);
> +			aconnector->hdmi_prev_sink = NULL;
> +		}
>   	}
>   
>   	if (aconnector->bl_idx != -1) {

