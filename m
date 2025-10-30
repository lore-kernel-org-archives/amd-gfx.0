Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC5CCCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 20:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C4A10EA33;
	Thu, 30 Oct 2025 20:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QsMAPBhk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8969410EA33
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 20:50:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A4E76049C;
 Thu, 30 Oct 2025 20:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F2DC4CEF1;
 Thu, 30 Oct 2025 20:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761857458;
 bh=571C+YUjoaUzjnsfZWv4bghj5UwWL1E8MqdNKBHow2M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QsMAPBhk5uAxUuOJb1HLJmFJ7ISbSWFS69M+X8QFZWZmg7WWed70G5i928ilGEwrn
 KfqQ5qaFNF9RKK2PFGkkXcZ5FZQkqKHfN12UraVin+R3QarljTAJIEpGfo+3YKABML
 LtwEqce5oQKG69Q+zKQnSfdb11LI7jFTwqynVsh4TpuFEB4diS8aWu0hcrQYeGsg9k
 kFfpDpgGwcLgb2YYucMEX4sSwSMkXK4QEbOTUpR8yGeyEEidfurneSwKNyzTNWq0bL
 l81bmuLgxJirqFkRJAZUTcTelC9xAVO50nXEXuX3v1RC7NV1g4GM5I3Og55g0Qsr+e
 TLX9vUcu4HKWQ==
Message-ID: <ea5478eb-33ba-4354-9ddd-d91b3e896456@kernel.org>
Date: Thu, 30 Oct 2025 15:50:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't stretch non-native images by
 default in eDP
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251030193943.4064454-1-superm1@kernel.org>
 <CADnq5_N==TV+c99gq+PaxRpi9OVZpcCMZF6ro==JKp0n1zrWhw@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CADnq5_N==TV+c99gq+PaxRpi9OVZpcCMZF6ro==JKp0n1zrWhw@mail.gmail.com>
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



On 10/30/2025 3:49 PM, Alex Deucher wrote:
> On Thu, Oct 30, 2025 at 4:16 PM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
>> commit 978fa2f6d0b12 ("drm/amd/display: Use scaling for non-native
>> resolutions on eDP") started using the GPU scaler hardware to scale
>> when a non-native resolution was picked on eDP. This scaling was done
>> to fill the screen instead of maintain aspect ratio.
>>
>> The idea was supposed to be that if a different scaling behavior is
>> preferred then the compositor would request it.  The not following
>> aspect ratio behavior however isn't desirable, so adjust it to follow
>> aspect ratio and still try to fill screen.
>>
>> Note: This will lead to black bars in some cases for non-native
>> resolutions. Compositors can request the previous behavior if desired.
>>
> 
> We may end up getting bug reports about the black bars.  We had a
> similar debate about what the right default was for radeon 15 years
> ago.  That said, at least with this the pixels will be square with
> this patch.
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thanks.  Yeah that was my thought too.

> 
>> Fixes: 978fa2f6d0b12 ("drm/amd/display: Use scaling for non-native resolutions on eDP")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4538
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 29b9197bbbc32..5b279182e66a8 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -8078,7 +8078,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
>>                                         "mode %dx%d@%dHz is not native, enabling scaling\n",
>>                                         adjusted_mode->hdisplay, adjusted_mode->vdisplay,
>>                                         drm_mode_vrefresh(adjusted_mode));
>> -                       dm_new_connector_state->scaling = RMX_FULL;
>> +                       dm_new_connector_state->scaling = RMX_ASPECT;
>>                  }
>>                  return 0;
>>          }
>> --
>> 2.43.0
>>

