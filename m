Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73347E83060
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 08:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE0110E582;
	Tue,  3 Feb 2026 08:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="JV8hE9tM";
	dkim-atps=neutral
X-Greylist: delayed 451 seconds by postgrey-1.36 at gabe;
 Tue, 03 Feb 2026 02:13:34 UTC
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9163210E2F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 02:13:34 +0000 (UTC)
Message-ID: <8196dd34-048a-452f-b01b-978f7d78df84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1770084361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5xnCXyQ1Cpz7oO8OOwdeVQSo8NWh1peNlpPtSsvBzI=;
 b=JV8hE9tM03spgawEO68e+Hr1YElDCMwtQ5Hj0UObe/qRUk/hYjCWfQYQX3t2anaOqrUzoY
 MMcm229Bi+L4puKvt6kUy6iDk6DiDPbaNMxUMZ42ERpdcU/DnrFLHvnwpXn8TqWJ4dzc9h
 JKQS8IjrkjXP/rCa+FDVLKKXgrKLdqY=
Date: Mon, 2 Feb 2026 18:05:49 -0800
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: expose plane blend LUT in HW with MCM
To: Melissa Wen <mwen@igalia.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Alex Hung <alex.hung@amd.com>
References: <20251209151032.91738-1-mwen@igalia.com>
 <003737a0-7777-45f3-af55-4cee7a73ab9d@igalia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <003737a0-7777-45f3-af55-4cee7a73ab9d@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 03 Feb 2026 08:16:06 +0000
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

On 2/2/26 6:03 PM, Melissa Wen wrote:
> 
> On 09/12/2025 12:09, Melissa Wen wrote:
>> Since commit 39923050615cd ("drm/amd/display: Clear DPP 3DLUT Cap")
>> there is a flag in the mpc_color_caps that indicates the pre-blend usage
>> of MPC color caps. Do the same as commit a0c3e8bfbab6 ("drm/amd/display:
>> Use mpc.preblend flag to indicate preblend") and use the mpc.preblend
>> flag to expose plane blend LUT/TF properties on AMD display driver.
> 
> A gentle ping here.
> 
> Melissa
> 
>>
>> CC: Matthew Schwartz <matthew.schwartz@linux.dev>

I can confirm this adds back color management capabilities in gamescope on DCN35 and DCN351.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>

>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> index 56cb866ac6f8..b15f0cf86008 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> @@ -1649,7 +1649,7 @@ dm_atomic_plane_attach_color_mgmt_properties(struct amdgpu_display_manager *dm,
>>                          MAX_COLOR_3DLUT_SIZE);
>>       }
>>   -    if (dpp_color_caps.ogam_ram) {
>> +    if (dpp_color_caps.ogam_ram || dm->dc->caps.color.mpc.preblend) {
>>           drm_object_attach_property(&plane->base,
>>                          mode_info.plane_blend_lut_property, 0);
>>           drm_object_attach_property(&plane->base,
> 

