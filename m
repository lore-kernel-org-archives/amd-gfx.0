Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF0CC7114A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B826310E49D;
	Tue, 17 Jun 2025 03:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BMplcwCp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E1410E49D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:46:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3CB5F4A50E;
 Tue, 17 Jun 2025 03:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C817CC4CEF1;
 Tue, 17 Jun 2025 03:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750131968;
 bh=V5ML7zQsO5t1RomzpLJ/9cV+JVyQUT3I57T7ahRNFbA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BMplcwCpeqUPdBJ7SjBJDDqmeCWYczlEnBg1ZCOSrdTwTAeYMHGgI8YFdsAd9Dwfd
 lJgwaBA6ayF5cWcfdY8FkdfCCFmOWuagtQbXJymkarrcvuNWg0U0Cpo94goFgdbJe+
 D6SvtznBIr4LMQ7hbRswm8fbulf3kmt5VTW1MZeQ9syBDSCdQSCVKosydS24Ds03Ph
 Z3A9aU/Qxr2S/oiGfL8nhpQx1/q8o2CEJjlhv++bMubHkzDy8V9k0gP3va4vnEkjHu
 DBwcWMtx8I+5DYpBotET2s8kiT9fpKHds7UeOZNJwWkU1O2gOoCDhflMXUox2Z7oJe
 Aopd/HKzHsA6Q==
Message-ID: <7ba8c02a-acdc-4fde-b05a-572df148ac1e@kernel.org>
Date: Mon, 16 Jun 2025 22:46:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add a sysfs file to detect whether a GPU is an
 APU
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250616201552.4022366-1-superm1@kernel.org>
 <CADnq5_PAR3sW9bFPwCfzJYGKqBygNDk=rrifBkb3q_E58396UQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CADnq5_PAR3sW9bFPwCfzJYGKqBygNDk=rrifBkb3q_E58396UQ@mail.gmail.com>
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



On 6/16/25 9:53 PM, Alex Deucher wrote:
> On Mon, Jun 16, 2025 at 4:21 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> In order to discover whether a GPU is part of a dGPU or APU userspace has
>> to do some mental gymnastics or heuristics.  Add a sysfs file that clearly
>> indicates to userspace.
> 
> You can already query this via the INFO IOCTL.  What use case did you
> have in mind for this interface?

You're right; the IOCTL is totally fine for this.  Disregard the patch.

Thanks,>
> Alex
> 
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c     | 16 ++++++++++++++++
>>   drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h |  1 +
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index edd9895b46c02..4e4c77488e334 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -945,6 +945,21 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>>          return size;
>>   }
>>
>> +/**
>> + * DOC: apu
>> + *
>> + * Represents whether GPU is on a dGPU (0) or APU (1)
>> + */
>> +static ssize_t amdgpu_get_apu(struct device *dev,
>> +                             struct device_attribute *attr,
>> +                             char *buf)
>> +{
>> +       struct drm_device *ddev = dev_get_drvdata(dev);
>> +       struct amdgpu_device *adev = drm_to_adev(ddev);
>> +
>> +       return sysfs_emit(buf, "%d\n", adev->flags & AMD_IS_APU ? 1 : 0);
>> +}
>> +
>>   /**
>>    * DOC: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
>>    *
>> @@ -2287,6 +2302,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>>                                .attr_update = ss_bias_attr_update),
>>          AMDGPU_DEVICE_ATTR_RO(pm_metrics,                               ATTR_FLAG_BASIC,
>>                                .attr_update = amdgpu_pm_metrics_attr_update),
>> +       AMDGPU_DEVICE_ATTR_RO(apu,                                      ATTR_FLAG_BASIC),
>>   };
>>
>>   static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
>> index c12ced32f7808..ffd008c1e6ec2 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
>> @@ -78,6 +78,7 @@ enum amdgpu_device_attr_id {
>>          device_attr_id__smartshift_dgpu_power,
>>          device_attr_id__smartshift_bias,
>>          device_attr_id__pm_metrics,
>> +       device_attr_id__apu,
>>          device_attr_id__count,
>>   };
>>
>> --
>> 2.43.0
>>

