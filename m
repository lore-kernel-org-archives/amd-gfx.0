Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1E0C83F27
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Jul 2025 17:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8EB10E230;
	Sat, 19 Jul 2025 17:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tdvb+jAb";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF48A10E230
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Jul 2025 17:39:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 27F4DA414B2;
 Sat, 19 Jul 2025 17:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EA6C4CEE3;
 Sat, 19 Jul 2025 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752946787;
 bh=7/NdWaVru2bXgWxe3grex5sXv09jXLsi35lKwOHFWh0=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=tdvb+jAbXtaH2Ug6CLe4ggGjF5CN42xkvX+zRWi3CMxsuwuy+q8zbaRqvAWsSxUpy
 rucGUWrniij4QDyNKZ+U3dzBI5WBWr+GuywfXOlyky7OUZ73vJoHsYhtlEovMlzv7i
 fLYU4/5W1Lb2q9N/p/BtdgyLC57/5Np8VTDdIA+7GQv+ekzpi9/m71vrAIyPuZed21
 lqDbCi0SU/sdP8zsEzD7wAt2fZYGP1d1XKkBSrcLqbAG93KvoWVrFruMNZ3lHAUtld
 kRmCOY+k2dB4xfMl33iF7o4/FKSrp/E4yCx6p0/Ryi6P3c2NsVrDzwPr7JX7VAvZgU
 JxXELil88LiSw==
Message-ID: <cc7a41dc-066a-41c8-a271-7e4c92088d65@kernel.org>
Date: Sat, 19 Jul 2025 12:39:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: backlight brightness set to 0 at
 amdgpu initialization
From: Mario Limonciello <superm1@kernel.org>
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
 <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
 <aHr--GxhKNj023fg@hacktheplanet.fi>
 <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
Content-Language: en-US
In-Reply-To: <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
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



On 7/19/25 10:25 AM, Mario Limonciello wrote:
> 
> 
> On 7/18/25 9:12 PM, Lauri Tirkkonen wrote:
>> On Fri, Jul 18 2025 20:14:08 -0500, Mario Limonciello wrote:
>>> OK, I think we need to do two things to figure out what's going on.
>>>
>>> 1) Let's shift over to 6.16-rc6.  Once we've got a handle on the 
>>> situation
>>> there we can iron out if there are other patches missing or this is also
>>> broken for you in 6.16.  If it's not working as expected there either we
>>> need it fixed there first anyway.
>>
>> Same behavior on 6.16-rc6: brightness is set to 0 (max 399000),
>> minimally visible.
>>
>>> 2) The starting brightness I don't expect to be "0".  We need to see 
>>> what
>>> values were read out from the firmware. There is a debugging message 
>>> we can
>>> catch if you boot with drm.debug=0x106.  Keep in mind you probably 
>>> need to
>>> increase log_buf_len if your ring buffer is set too small too.
>>>
>>> https://github.com/torvalds/linux/ 
>>> commit/4b61b8a390511a1864f26cc42bab72881e93468d
>>>
>>> PS: I would rather you add logs into a gist, pastebin or a bug 
>>> somewhere if
>>> you can.
>>
>> [    3.210757] amdgpu 0000:03:00.0: 
>> [drm:amdgpu_dm_connector_late_register [amdgpu]] Backlight caps: min: 
>> 1000, max: 400000, ac 100, dc 32
>>
>> full dmesg: https://termbin.com/o2q3
>>
> 
> Thanks for sharing.  Can you get me an updated output with 
> drm.debug=0x106 set and with this applied?  I want to see what values 
> were set.
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/ 
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5df7f8c34231..cdc43cfb39dd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10489,8 +10489,12 @@ static void amdgpu_dm_atomic_commit_tail(struct 
> drm_atomic_state *state)
>          /* restore the backlight level */
>          for (i = 0; i < dm->num_of_edps; i++) {
>                  if (dm->backlight_dev[i] &&
> -                   (dm->actual_brightness[i] != dm->brightness[i]))
> +                   (dm->actual_brightness[i] != dm->brightness[i])) {
> +                       drm_WARN(adev_to_drm(adev), true,
> +                                       "Backlight level %d does not 
> match actual brightness %d for edp %d\n",
> +                                       dm->brightness[i], dm- 
>  >actual_brightness[i], i);
>                          amdgpu_dm_backlight_set_level(dm, i, dm- 
>  >brightness[i]);
> +                   }
>          }
> 
>          /*
> 
> Also, does turning off custom brightness curves 
> (amdgpu.dcdebugmask=0x40000) help?
> 

In advance of getting that updated log; I have a theory what's going on. 
  I think the first value programmed to brightness happens as part of 
that very first modeset.

If that's what's going on, then I think doing an explicit programming 
cycle at the backlight registration will help.  Here's a potential patch.

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b19e7964060d..4b99efbaf481 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4996,6 +4996,8 @@ amdgpu_dm_register_backlight_device(struct 
amdgpu_dm_connector *aconnector)
                 dm->backlight_dev[aconnector->bl_idx] = NULL;
         } else
                 drm_dbg_driver(drm, "DM: Registered Backlight device: 
%s\n", bl_name);
+
+ 
amdgpu_dm_backlight_update_status(dm->backlight_dev[aconnector->bl_idx]);
  }

  static int initialize_plane(struct amdgpu_display_manager *dm,
