Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C337CAC592
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 07:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AA210EA1D;
	Thu, 11 Sep 2025 07:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="diTC0lNO";
	dkim-atps=neutral
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [95.215.58.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 887A710E19E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 22:23:11 +0000 (UTC)
Message-ID: <236b2370-4aef-48bc-9f8b-0e37a72f65ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1757542989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aWQDILI3uBc7hyjxz9WTSmjBYV9NZwtCUxZRwM7aSvw=;
 b=diTC0lNOV4WhltK0jGUCzN8O8l8TtVsaMShDXIR/j+MbNjKgZFFg+pxQe7irLySrKwrzmo
 7HQmy1lfetYjYMpzvvMkaHtb6tlhyzbJGRmq/P0uxEmcOTpoEcfeLCD+ql7xTfT6OkI91k
 rrCNXzWMnXzIWGiIYFYP/uEKhIqz7NU=
Date: Wed, 10 Sep 2025 15:23:03 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume
To: Mario Limonciello <mario.limonciello@amd.com>, chiahsuan.chung@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, simona@ffwll.ch,
 airlied@gmail.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, zaeem.mohamed@amd.com, misyl@froggi.es,
 linux-kernel@vger.kernel.org
References: <20250910212753.3167295-1-matthew.schwartz@linux.dev>
 <53e5cc5d-f220-4e4c-8ee4-159a7d8f329a@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <53e5cc5d-f220-4e4c-8ee4-159a7d8f329a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Thu, 11 Sep 2025 07:28:47 +0000
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

On 9/10/25 2:32 PM, Mario Limonciello wrote:
> On 9/10/25 4:27 PM, Matthew Schwartz wrote:
>> On clients that utilize AMD_PRIVATE_COLOR properties for HDR support,
>> brightness sliders can include a hardware controlled portion and a
>> gamma-based portion. This is the case on the Steam Deck OLED when using
>> gamescope with Steam as a client.
>>
>> When a user sets a brightness level while HDR is active, the gamma-based
>> portion and/or hardware portion are adjusted to achieve the desired
>> brightness. However, when a modeset takes place while the gamma-based
>> portion is in-use, restoring the hardware brightness level overrides the
>> user's overall brightness level and results in a mismatch between what
>> the slider reports and the display's current brightness.
>>
>> To avoid overriding gamma-based brightness, only restore HW backlight
>> level after boot or resume. This ensures that the backlight level is
>> set correctly after the DC layer resets it while avoiding interference
>> with subsequent modesets.
>>
>> Fixes: 7875afafba84 ("drm/amd/display: Fix brightness level not retained over reboot")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4551
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++--
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 7808a647a306c..3651315760759 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -2037,6 +2037,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>         dc_hardware_init(adev->dm.dc);
>>   +    adev->dm.restore_backlight = true;
>> +
>>       adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
>>       if (!adev->dm.hpd_rx_offload_wq) {
>>           drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
>> @@ -3407,6 +3409,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>>           dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>>             dc_resume(dm->dc);
>> +        adev->dm.restore_backlight = true;
>>             amdgpu_dm_irq_resume_early(adev);
>>   @@ -9922,7 +9925,8 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>>               acrtc->hw_mode = new_crtc_state->mode;
>>               crtc->hwmode = new_crtc_state->mode;
>>               mode_set_reset_required = true;
>> -            set_backlight_level = true;
>> +            if (dm->restore_backlight)
>> +                set_backlight_level = true;
>>           } else if (modereset_required(new_crtc_state)) {
>>               drm_dbg_atomic(dev,
>>                          "Atomic commit: RESET. crtc id %d:[%p]\n",
>> @@ -9979,13 +9983,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>>        * to fix a flicker issue.
>>        * It will cause the dm->actual_brightness is not the current panel brightness
>>        * level. (the dm->brightness is the correct panel level)
>> -     * So we set the backlight level with dm->brightness value after set mode
>> +     * So we set the backlight level with dm->brightness value after initial
>> +     * set mode. Use restore_backlight flag to avoid setting backlight level
>> +     * for every subsequent mode set.
>>        */
>>       if (set_backlight_level) {
> 
> Is there really still a need for the local variable in this function 'set_backlight_level'?
> 

No, you're correct and it's a bit cleaner that way. I'll fix this in v2.

> It seems to me with this change you can just use dm->restore_backlight for state tracking at all times.
>>           for (i = 0; i < dm->num_of_edps; i++) {
>>               if (dm->backlight_dev[i])
>>                   amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>>           }
>> +        dm->restore_backlight = false;
>>       }
>>   }
>>   diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index b937da0a4e4a0..6aae51c1beb36 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -610,6 +610,13 @@ struct amdgpu_display_manager {
>>        */
>>       u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>>   +    /**
>> +     * @restore_backlight:
>> +     *
>> +     * Flag to indicate whether to restore backlight after modeset.
>> +     */
>> +    bool restore_backlight;
>> +
>>       /**
>>        * @aux_hpd_discon_quirk:
>>        *
> 

