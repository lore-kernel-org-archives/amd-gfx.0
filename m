Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71420D6B09D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 16:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADE310E8A9;
	Thu, 29 Jan 2026 16:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CpHfrCxX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FCFB10E8A8;
 Thu, 29 Jan 2026 16:44:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C5B2943ABC;
 Thu, 29 Jan 2026 16:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D0DC116D0;
 Thu, 29 Jan 2026 16:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769705053;
 bh=oovUrynWF0eeT067MEG3dyiLLHMFPUNLKov/+fjlwOY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CpHfrCxXTT34FZVHHHc4au1jLlUwgGxcj0oaFPpyVEaps7UlK1RLCKfZ6cmre+Wp6
 UEBdv6WlYF84dr9WqGLb48zA3dONwgPTNcTRZ/dQzM7Qj/22llfDXCOFT0skg5ulGF
 upk5Fnjn9kzNVH5sR6BycjkBIWY7Rkqe7ETZYbDXIgjpykO/mxpEiMyhVgIv/2rKi2
 QXIKl42U4o/MXXWlOeDkKONuKkTESc4CjiN4uzmKuGHwNS+4u43xqNxbxc1BHLy9k+
 9PwXDeF17s76282FHwkE+ARBZ5cNMCZDmP7mOjurDK/ALwzaq5wAjZvptEyhHIxjTS
 dV1AV0Hfz7RgA==
Message-ID: <f56cb9dc-d47b-49bd-a199-bff9e7bb29b0@kernel.org>
Date: Thu, 29 Jan 2026 10:44:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm: Introduce drm_crtc_vblank_prepare()
To: Leo Li <sunpeng.li@amd.com>, Derek John Clark <derekjohn.clark@gmail.com>
Cc: Harry.Wentland@amd.com, airlied@gmail.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 simona@ffwll.ch, ville.syrjala@linux.intel.com
References: <CAFqHKTnSUndwTs-cc8SZxST48UBj6_oKf0Bzt_mMSsj6=g-xww@mail.gmail.com>
 <923ab7ae-0963-472e-995e-760c30978274@amd.com>
 <31babc28-0e69-46e5-94cd-8856e9ad6550@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <31babc28-0e69-46e5-94cd-8856e9ad6550@amd.com>
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

On 1/29/26 10:40 AM, Leo Li wrote:
> 
> 
> On 2026-01-29 10:15, Leo Li wrote:
>>
>>
>> On 2026-01-28 23:43, Derek John Clark wrote:
>>>> From: Leo Li <sunpeng.li@amd.com>
>>>>
>>>> Some drivers need to perform sleepable operations prior to enabling
>>>> vblank interrupts. A display hardware spin-up from a low-power state
>>>> that requires synchronization with the rest of the driver, for example.
>>>>
>>>> To support this, introduce a DRM-internal drm_crtc_vblank_prepare()
>>>> helper that calls back into the driver -- if implemented -- for DRM to
>>>> do such preparation work before enabling vblank.
>>>>
>>>> v3:
>>>> * Unexport drm_crtc_vblank_prepare() and make it DRM internal
>>>> * Drop warnings in drm core for vblank_prepare(), drivers can do so in
>>>>   their implementations
>>>> * Drop unnecessary crtc null checks
>>>> * Check for drm_dev_has_vblank()
>>>> * Rebase on latest drm-misc-next
>>>>
>>>> v4:
>>>> * EXPORT function to fix build error on DRM_KMS_HELPER=m
>>>>
>>>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
>>>
>>> Hi Leo.
>>>
>>> I wanted to know what branch this series applies to. I'm trying to
>>> troubleshoot a possible vblank issue on the Legion Go 2 and was
>>> pointed towards this patch series. Unfortunately I can't get it to
>>> apply cleanly to drm/drm-fixes, drm/drm-next or stable/linux-6.18.y
>>
>> Hi Derek,
>>
>> This applies to drm-misc-next, here:
>> https://gitlab.freedesktop.org/drm/misc/kernel/-/tree/drm-misc-next
>>
>> Thanks,
>> Leo
> 
> FYI, in case you run into the same issue, I had to blacklist my wifi driver:
> modprobe.blacklist=mt7925e in my kernel cmdline for drm-misc-next to boot.
> 

And if you need wifi while testing there's some fixes for this in 6.19 
that could potentially be cherry picked.

> -Leo
> 
>>
>>>
>>>
>>>  From commit 15392f76405ecb953216b437bed76ffa49cefb7b (HEAD,
>>> drm/drm-next, drm/HEAD):
>>> $ b4 shazam https://lore.kernel.org/dri-devel/20260127194143.176248-1-sunpeng.li@amd.com/
>>> Grabbing thread from
>>> lore.kernel.org/all/20260127194143.176248-1-sunpeng.li@amd.com/t.mbox.gz
>>> Checking for newer revisions
>>> Grabbing search results from lore.kernel.org
>>> Analyzing 2 messages in the thread
>>> Analyzing 0 code-review messages
>>> Checking attestation on all messages, may take a moment...
>>> ---
>>>    [PATCH v4 1/2] drm: Introduce drm_crtc_vblank_prepare()
>>>    [PATCH v4 2/2] drm/amd/display: Implement prepare_vblank_enable callback
>>>    ---
>>>    NOTE: install dkimpy for DKIM signature verification
>>> ---
>>> Total patches: 2
>>> ---
>>> Applying: drm: Introduce drm_crtc_vblank_prepare()
>>> Applying: drm/amd/display: Implement prepare_vblank_enable callback
>>> Patch failed at 0002 drm/amd/display: Implement prepare_vblank_enable callback
>>> error: patch failed: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c:277
>>> error: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c: patch
>>> does not apply
>>>
>>>
>>> Thanks,
>>> Derek
>>
> 

