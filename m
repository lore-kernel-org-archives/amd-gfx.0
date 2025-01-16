Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D362C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 21:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E8810E255;
	Thu, 16 Jan 2025 21:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iNlxMC4k";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7E510E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 21:42:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C34045C556C;
 Thu, 16 Jan 2025 21:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD09CC4CED6;
 Thu, 16 Jan 2025 21:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737063742;
 bh=Tyim3ov3R4W5EyKerAxa0cSIOaoXr+o/874MWv39esw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iNlxMC4k1rc29X4wE/r38VcNNUuyiq0Q7Nd3TxfDwox8KtwmxtsqRwnqP+96YpioO
 PIoRjBROZh8xrdTX2eieKspnuwec+eJsMBNGO8CecFeErqsKSN0CZZKdeS9C3Qipvn
 dYZDDXv7MXhOJtkS0hAh747NtTMAIXDqINrWTiDOws+rjpTy4kdcWVN7rTNlnNLO4U
 Yj2+YuCGL6EQ+uZ+CLGWsW/l2V/vVIf3q5pyXPgep0ltSK99b4Akba4puvDn4dSqRA
 zesulR/sc1qkOg7LhKaOf6yzk4XJoz26+5CGm/dcM609qUEykOjwGLAlGF5RP3dsLe
 2FXECg98gGKSw==
Message-ID: <ee899223-0304-420a-9489-6f6abc1b6791@kernel.org>
Date: Thu, 16 Jan 2025 15:42:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amd: Drop gttsize module parameter
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250116182921.1730696-1-superm1@kernel.org>
 <CADnq5_NDhxidmtNhi5rONuZQv-vQF-gYanrVuFU0XYJA-RDqqw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CADnq5_NDhxidmtNhi5rONuZQv-vQF-gYanrVuFU0XYJA-RDqqw@mail.gmail.com>
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

On 1/16/2025 15:32, Alex Deucher wrote:
> On Thu, Jan 16, 2025 at 1:29 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When not set `gttsize` module parameter by default will get the
>> value to use for the GTT pool from the TTM page limit, which is
>> set by a separate module parameter.
>>
>> This inevitably leads to people not sure which one to set when they
>> want more addressable memory for the GPU, and you'll end up seeing
>> instructions online saying to set both.
>>
>> Drop the amdgpu module parameter and related code for it.  This way
>> if users want to change the amount of addressable memory they can
>> change it solely in TTM.
>>
> 
> I suspect we probably want to keep it for compatibility with users
> that still use this option to change their GTT size.

Could we mark it as deprecated?  Perhaps something like this:

0) Change kdoc
1) Some messaging to show it being deprecated

	if (amdgpu_gttsize != -1)
		drm_warn(dev, "Configuring gttsize via module parameter is deprecated, 
please use ttm.ttm_page_limit");

2) Some messaging to show information if inconsistent values have been 
set against TTM

	if (amdgpu_gttsize != ttm_page_limit()
		drm_warn(dev, "GTT size has been set as %lu but TTM size has been set 
as %lu, this is unusual");

Then after the "next" LTS release is declared we can pull it out entirely.

> 
> Alex
> 
> 
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 -------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 ---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 9 ++-------
>>   4 files changed, 2 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 5e55a44f9eef..e728974114bb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -164,7 +164,6 @@ extern int amdgpu_modeset;
>>   extern unsigned int amdgpu_vram_limit;
>>   extern int amdgpu_vis_vram_limit;
>>   extern int amdgpu_gart_size;
>> -extern int amdgpu_gtt_size;
>>   extern int amdgpu_moverate;
>>   extern int amdgpu_audio;
>>   extern int amdgpu_disp_priority;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 3774d12ebc4a..1b62b843e5fb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2031,13 +2031,6 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>>                  amdgpu_gart_size = -1;
>>          }
>>
>> -       if (amdgpu_gtt_size != -1 && amdgpu_gtt_size < 32) {
>> -               /* gtt size must be greater or equal to 32M */
>> -               dev_warn(adev->dev, "gtt size (%d) too small\n",
>> -                                amdgpu_gtt_size);
>> -               amdgpu_gtt_size = -1;
>> -       }
>> -
>>          /* valid range is between 4 and 9 inclusive */
>>          if (amdgpu_vm_fragment_size != -1 &&
>>              (amdgpu_vm_fragment_size > 9 || amdgpu_vm_fragment_size < 4)) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b911653dd8b6..62b09c518665 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -141,7 +141,6 @@ enum AMDGPU_DEBUG_MASK {
>>   unsigned int amdgpu_vram_limit = UINT_MAX;
>>   int amdgpu_vis_vram_limit;
>>   int amdgpu_gart_size = -1; /* auto */
>> -int amdgpu_gtt_size = -1; /* auto */
>>   int amdgpu_moverate = -1; /* auto */
>>   int amdgpu_audio = -1;
>>   int amdgpu_disp_priority;
>> @@ -279,14 +278,6 @@ module_param_named(vis_vramlimit, amdgpu_vis_vram_limit, int, 0444);
>>   MODULE_PARM_DESC(gartsize, "Size of kernel GART to setup in megabytes (32, 64, etc., -1=auto)");
>>   module_param_named(gartsize, amdgpu_gart_size, uint, 0600);
>>
>> -/**
>> - * DOC: gttsize (int)
>> - * Restrict the size of GTT domain (for userspace use) in MiB for testing.
>> - * The default is -1 (Use 1/2 RAM, minimum value is 3GB).
>> - */
>> -MODULE_PARM_DESC(gttsize, "Size of the GTT userspace domain in megabytes (-1 = auto)");
>> -module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
>> -
>>   /**
>>    * DOC: moverate (int)
>>    * Set maximum buffer migration rate in MB/s. The default is -1 (8 MB/s).
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index e6fc89440210..e3fee81d8646 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1957,13 +1957,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>          DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>>                   (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024)));
>>
>> -       /* Compute GTT size, either based on TTM limit
>> -        * or whatever the user passed on module init.
>> -        */
>> -       if (amdgpu_gtt_size == -1)
>> -               gtt_size = ttm_tt_pages_limit() << PAGE_SHIFT;
>> -       else
>> -               gtt_size = (uint64_t)amdgpu_gtt_size << 20;
>> +       /* Compute GTT size, based on TTM limit */
>> +       gtt_size = ttm_tt_pages_limit() << PAGE_SHIFT;
>>
>>          /* Initialize GTT memory pool */
>>          r = amdgpu_gtt_mgr_init(adev, gtt_size);
>> --
>> 2.48.0
>>

