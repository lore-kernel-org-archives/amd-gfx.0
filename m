Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F293CC71153
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 19:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5318110E351;
	Mon, 11 Sep 2023 19:05:00 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C318310E34B;
 Mon, 11 Sep 2023 19:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aQLFCp+zWbl3dMMhaycGSX+PcHVumhgjR5Ns6tNTHFE=; b=loAH2sUR7fcXPy2NtNxxbUUN8K
 T4PcfyJplvwEdFBKln8K1Dm4NYp5AXq0RgPX+/rG9BjHrN/nMkLFNx7x/rjcijOnGY7+3ljz8sRFa
 h2uxarZsDUK3aiY38DHIeY6Ibx8uVWXGEjHIGi3HOK8RHYEIRjcD07YDVW/uZc/3ea9dfJbXkKvDM
 cmFdCJfETYvhJ/gfG6rIFNFggWEVciTB+vHjjbh/uHQt6oEIF+FiOQ+YXs5pwBhFD9MfhMsy93EpT
 7z3hmIBnSObgT90aUx8UZqc+u0mcz9cFRinEaZy/57qR+zLblWQTvirr7+gyzT4C79GCmJQyC5Xj5
 /3jc6org==;
Received: from [187.10.203.89] (helo=[192.168.1.111])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1qfmDO-002QkP-A6; Mon, 11 Sep 2023 21:04:54 +0200
Message-ID: <04424869-6c0d-42e0-aa3c-147d15ca69bc@igalia.com>
Date: Mon, 11 Sep 2023 16:04:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Merge all debug module parameters
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20230911171255.143992-1-andrealmeid@igalia.com>
 <41963d55-3fa8-4415-911c-99e35acb829e@amd.com>
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <41963d55-3fa8-4415-911c-99e35acb829e@amd.com>
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Em 11/09/2023 14:21, Hamza Mahfooz escreveu:
> On 9/11/23 13:12, André Almeida wrote:
>> As suggested by Christian at [0], this patchset merges all debug modules
>> parameters and creates a new one for disabling soft recovery:
>>
>>> Maybe we can overload the amdgpu_gpu_recovery module option with this.
>>> Or even better merge all the developer module parameter into a
>>> amdgpu_debug option. This way it should be pretty obvious that this
>>> isn't meant to be used by someone who doesn't know how to use it.
>>
>> [0] 
>> https://lore.kernel.org/dri-devel/55f69184-1aa2-55d6-4a10-1560d75c7324@amd.com/
> 
> I have applied the series, thanks!
> 

Thank you!

>>
>> Changelog:
>> - rebased on top of current amd-staging-drm-next
>> v3: 
>> https://lore.kernel.org/lkml/20230831152903.521404-1-andrealmeid@igalia.com
>>
>> - move enum from include/amd_shared.h to amdgpu/amdgpu_drv.c
>> v2: 
>> https://lore.kernel.org/lkml/20230830220808.421935-1-andrealmeid@igalia.com/
>>
>> - drop old module params
>> - use BIT() macros
>> - replace global var with adev-> vars
>> v1: 
>> https://lore.kernel.org/lkml/20230824162505.173399-1-andrealmeid@igalia.com/
>>
>> André Almeida (2):
>>    drm/amdgpu: Merge debug module parameters
>>    drm/amdgpu: Create an option to disable soft recovery
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  5 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 63 ++++++++++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c  |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  7 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c    |  2 +-
>>   8 files changed, 59 insertions(+), 26 deletions(-)
>>
