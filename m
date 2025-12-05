Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC47DD32D8A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 14:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6887010EB49;
	Fri,  5 Dec 2025 14:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OpZw7yFl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A684A10EB49
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 14:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/8O8y8OFGChvLHPl2IEtGRFHN+bEuHIZc5HhPicAhtQ=; b=OpZw7yFluLNXYJ3Rp3OwUiK3D4
 XaxLOm2nNqd7/ndtWzqWr6IfBGgYzUsKGuTQeFpfJoVbMdaSyB1svnpIRlnxGaF4NpnKUE6QVb6Zj
 mi15jRF6CAIYSCbI0LTYTQWFKrfS0NrrXzR/ZlYOLv/LZX+bBQ5nhGRzqOwtWM4xRXjSlZ5RLejCJ
 kp/9uMTsS2oqafEHbpHQrrfcnht3s+E3ytjigCeH0lZtxvEfJ8wOffp7SYp5vJcou8qbIxG929SjX
 XWeCeG6SacrZa2qrZck9kyoXHWG9TCsWRs/oq6y0CsxjLUo6j5E17XClRzK3q+w7aHCp7VdsV79gT
 9LDnI4VQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vRXGz-0097LY-Ri; Fri, 05 Dec 2025 15:59:05 +0100
Message-ID: <25e5c8bd-7c8e-4170-8912-45f616163013@igalia.com>
Date: Fri, 5 Dec 2025 14:59:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu/userq: Fix reference leak in
 amdgpu_userq_wait_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
 <20251205134035.91551-2-tvrtko.ursulin@igalia.com>
 <562c2fcd-d99f-4072-b005-31a26f85448e@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <562c2fcd-d99f-4072-b005-31a26f85448e@amd.com>
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


On 05/12/2025 14:46, Christian König wrote:
> On 12/5/25 14:40, Tvrtko Ursulin wrote:
>> Drop reference to syncobj and timeline fence when aborting the ioctl due
>> output array being too small.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: <stable@vger.kernel.org> # v6.16+
> 
> I need to double check the code when I have time, but of hand looks legitimate to me.
> 
> Where are patches #3-#12 from this series?

On amd-gfx only, since 3-12 only contains cleanups I thought not pollute 
the inboxes too much.

Regards,

Tvrtko

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index eba9fb359047..13c5d4462be6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -865,6 +865,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   				dma_fence_unwrap_for_each(f, &iter, fence) {
>>   					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>>   						r = -EINVAL;
>> +						dma_fence_put(fence);
>>   						goto free_fences;
>>   					}
>>   
>> @@ -889,6 +890,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   
>>   			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>>   				r = -EINVAL;
>> +				dma_fence_put(fence);
>>   				goto free_fences;
>>   			}
>>   
> 

