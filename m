Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C33CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 15:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B7D10E343;
	Thu,  6 Nov 2025 15:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YJuniJ52";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3CB10E343
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 15:22:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E82116133D;
 Thu,  6 Nov 2025 15:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDADC116D0;
 Thu,  6 Nov 2025 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762442559;
 bh=jH8/OicpRdZVK5i9bhKBlm5igYSma30z58VJhEcAtLU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YJuniJ52j+6AaxurDtJf0cut1Uq9YtHFeZtpIadORBIrRSmOZhL1QgX/PNOKMFzC0
 UrTuG6NunJob8w663emd1a5PpAAoGm9dSdsyQWL1gTU291c6euortjyv/P/NR+bLfs
 ted6yygqDt7FvDeI1cLA+aainLoEdcqbO9VlEQz0EiMV8AaF5gjm5AsS3ppiV7EmUR
 Wxk+FbJ8t1tWQpbT+KlQOgP6I6XDyOSjG4r+HvaLDIcLiSvysOKWybp2KZL7tGS3VI
 7/XmY4CRlJn9qeFVDOlK7abHpZ5FkEfYpSgy9vWYeDXp4N91Rgv2RDa4dUf0XMugZ1
 zMMCoxFvzQSqg==
Message-ID: <ac528b8d-bb68-4b66-83f4-1fcaa1475d9c@kernel.org>
Date: Thu, 6 Nov 2025 09:22:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Robert Beckett <bob.beckett@collabora.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20251020161606.67812-1-siqueira@igalia.com>
 <kfkpxu5xve4stdr7nkvqfwpj3a763237udvo5ki6qgq6gimdmo@e6c77y2u2rff>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <kfkpxu5xve4stdr7nkvqfwpj3a763237udvo5ki6qgq6gimdmo@e6c77y2u2rff>
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

On 11/4/25 6:32 PM, Rodrigo Siqueira wrote:
> On 10/20, Rodrigo Siqueira wrote:
>> When trying to unload amdgpu in the SteamDeck (TTY mode), the following
>> set of errors happens and the system gets unstable:
>>
>> [..]
>>   [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
>>   amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on gfx_0.0.0 (-110).
>>   amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
>> [..]
>>   amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>>   amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
>>   amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
>>   amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
>> [..]
>>
>> When the driver initializes the GPU, the PSP validates all the firmware
>> loaded, and after that, it is not possible to load any other firmware
>> unless the device is reset. What is happening in the load/unload
>> situation is that PSP halts the GC engine because it suspects that
>> something is amiss. To address this issue, this commit ensures that the
>> GPU is reset (mode 2 reset) in the unload sequence.
>>
>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 0d5585bc3b04..0a7bcb2d5a50 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3649,6 +3649,13 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>>   				"failed to release exclusive mode on fini\n");
>>   	}
>>   
>> +	/* Reset the device before entirely removing it to avoid load issues
>> +	 * caused by firmware validation.
>> +	 */
>> +	r = amdgpu_asic_reset(adev);
>> +	if (r)
>> +		dev_err(adev->dev, "asic reset on %s failed\n", __func__);
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.51.0
>>
> 
> Hi,
> 
> I just want to follow-up about this patch. Do I need to make any other
> modification?
> 
> Thanks
> 

I was a little bit worried about implications for the 6.19 changes 
around shutdown, but I talked to siqueira about some testing for it and 
he did a wide array of testing across different GPUs with load/unload 
and shutdown.  To me this looks fine, but I think Alex should give his 
thoughts too.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
