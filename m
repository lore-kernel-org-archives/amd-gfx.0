Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65608C36013
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 04:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF2D10E0C1;
	Mon, 31 Mar 2025 04:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zd6DEqCG";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A79E10E0C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 04:20:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C31E0A42F39;
 Mon, 31 Mar 2025 04:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E83C4CEE3;
 Mon, 31 Mar 2025 04:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743394826;
 bh=bgCYFWEEdzVE4DqP8z0+B9gRtu+sJX1czwr+T7wL+lc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Zd6DEqCGRTnJUhDM0Ug1e1bxEai9qR2l44PHcxDTQrBLdF00kV//ITgrfQNem190O
 t0KZXhzrNzhKfR78/3/LL02jNp2flxGl2joWRqMBEDKcS7uwZpp9Rc4D78MMHs2ews
 13qMJECFUvRNY9IavUg3RUcnoD17ruliw+sXYUFROgwZZ5wv7peAYVjFWLgEPuNZn5
 SPPcAShNbtrDRy7NbSpJk5lkVGA8UIXe8Ds4ymxMM1+HQAq31K64GqCCOgPqLG2gpB
 ZYr+V3CatOG7kfFtqiE4MhfIlEl33ckncU95c+LbIKL2VdyHWpsZYegWtoFM3cj5M/
 Dww/C1FSqBuzg==
Message-ID: <12e95520-f31e-42ae-8e06-df6b298e9a1a@kernel.org>
Date: Sun, 30 Mar 2025 23:20:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] drm/amd: Convert dev_err_once() messages to
 drm_err_once()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250327203858.3796086-1-superm1@kernel.org>
 <20250327203858.3796086-4-superm1@kernel.org>
 <CADnq5_PHok-aAjsYr0P-xbWowBU-0yRxgFGrkyxmcd_ZE2k1OA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CADnq5_PHok-aAjsYr0P-xbWowBU-0yRxgFGrkyxmcd_ZE2k1OA@mail.gmail.com>
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



On 3/28/25 14:04, Alex Deucher wrote:
> On Thu, Mar 27, 2025 at 4:48 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The errors for power consumption in amdgpu_acpi_is_s0ix_active() are
>> under device scope. As they're drm errors, adjust to drm scope.
> 
> Is there an advantage to drm vs dev scope?  I guess just consistency
> with core drm messages?  I presume the drm variants also print device
> information so we can differentiate between multiple GPUs in a system?
>   That was why we transitioned from the DRM to the dev variants in the
> first place.
> 
> Alex
> 

Yeah it's just consistency that you end up with a [drm] at the end of 
the  dev_*() prefix for all messages.  So you can easily find all drm 
core and amdgpu messages by grep'ing '[drm]'.


>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> index 840901d65fed7..4372738bf2c9d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1518,14 +1518,14 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>>           * in that case.
>>           */
>>          if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
>> -               dev_err_once(adev->dev,
>> +               drm_err_once(adev_to_drm(adev),
>>                                "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"
>>                                "To use suspend-to-idle change the sleep mode in BIOS setup.\n");
>>                  return false;
>>          }
>>
>>   #if !IS_ENABLED(CONFIG_AMD_PMC)
>> -       dev_err_once(adev->dev,
>> +       drm_err_once(adev_to_drm(adev),
>>                        "Power consumption will be higher as the kernel has not been compiled with CONFIG_AMD_PMC.\n");
>>          return false;
>>   #else
>> --
>> 2.43.0
>>

