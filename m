Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74C5C5CFCF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 15:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5C310E4F1;
	Thu, 13 Aug 2026 15:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iWui3I44";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDBE10E4F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 15:43:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFEA460A7C;
 Thu, 13 Aug 2026 15:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D571F000E9;
 Thu, 13 Aug 2026 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786635789;
 bh=m4a+9FvALtfcTV85vaNHvrYePV5IDKI/YvGktvwk0rc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=iWui3I44N29rrVHMsmRRrtmnkUlj1iJLI9mKaiClRs6GA9uMkzOKOIvXTlIfQ1LaT
 LD6Y1wh26yuGdidkjUy/bKMWm56ib+0+pQjzA4MKk/NX1/a+OROLiSCRdGNuZFs7Tu
 etBgUlA6SD3rkF5QuZjbsImPgpqWXjWme0oZvvbEVDdUJFzkU+iKy3Oihap/6G0QfT
 m6GI2T03xrUswCZ0gPYybRSOGIwjo6L5w1ySjn8eoWQD2J+uz+gP0pTQGDRS38vR6E
 zJFY1F4YkEbQSeK+eR2TytQ/X/drL4H+InjkMRifdFCYnO7obSyExlaRI3eG3rndiy
 gZ8cg6eoSSSsw==
Message-ID: <6ae915cf-34b1-442f-bada-c49155f64831@kernel.org>
Date: Thu, 13 Aug 2026 10:43:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix sysfs ip base addr for 64bit in
 standalone mode
To: Alex Deucher <alexdeucher@gmail.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260813151043.1206885-1-mukul.joshi@amd.com>
 <CADnq5_PAAhPq=g5PDEqPKcVfVbRmxngzodu3m3JBZSMm0TTdgg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CADnq5_PAAhPq=g5PDEqPKcVfVbRmxngzodu3m3JBZSMm0TTdgg@mail.gmail.com>
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



On 8/13/26 10:28, Alex Deucher wrote:
> On Thu, Aug 13, 2026 at 11:20 AM Mukul Joshi <mukul.joshi@amd.com> wrote:
>>
>> In standalone mode the ip_discovery sysfs tree is built from a verbatim
>> copy of the discovery binary taken before reg_base_init() collapses the
>> 64bit base addresses in place. Decoding as 32bit there yields interleaved
>> zeros. Decode base_address_64[] in that case; keep reading the already
>> collapsed adev->discovery.bin as-is otherwise.
>>
>> Fixes: 3ee1065e9830 ("drm/amdgpu: Export ip_discovery sysfs on probe failure")
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index b5bc0d71653d..8745b0a66f1d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -1308,8 +1308,19 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>>                                          ip_hw_instance->num_instance);
>>                          ip_hw_instance->num_base_addresses = ip->num_base_address;
>>
>> -                       for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
>> -                               ip_hw_instance->base_addr[kk] = ip->base_address[kk];
>> +                       for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++) {
>> +                               /*
>> +                                * Standalone mode uses a raw copy of the discovery
>> +                                * binary; decode 64-bit addresses here. The shared
>> +                                * bin is already collapsed to 32-bit in place.
>> +                                */
>> +                               if (reg_base_64 && ip_top->standalone_mode)
>> +                                       ip_hw_instance->base_addr[kk] =
>> +                                               lower_32_bits(le64_to_cpu(ip->base_address_64[kk])) & 0x3FFFFFFF;
>> +                               else
>> +                                       ip_hw_instance->base_addr[kk] =
>> +                                               le32_to_cpu(ip->base_address[kk]);
>> +                       }
>>
>>                          kobject_init(&ip_hw_instance->kobj, &ip_hw_instance_ktype);
>>                          ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
>> --
>> 2.54.0
>>

