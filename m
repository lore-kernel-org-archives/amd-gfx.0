Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC21E7718F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 10:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A8D10E85F;
	Fri,  3 Jan 2025 10:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OeVzmkQc";
	dkim-atps=neutral
X-Greylist: delayed 301 seconds by postgrey-1.36 at gabe;
 Fri, 03 Jan 2025 07:48:55 UTC
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE6810E243
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 07:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1735890534; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 bh=jwy5XjpC+wxCHchu7ay1MGzecfGKYmTTDPGJVqqX1lo=;
 b=OeVzmkQc+VH/jcT/30/1hmV1PBUwZD0c9W33FRrElpjq+KmwIJYgOtqi5kko0ZL/G9gEHX0tZhefYUycMACRfX8p4fnQrUnPOfoMIk8m0f0HBhZs+I6v7Dom8REG1Zelfyw0yLQCgfM0RRHt8NtIvHRyCZivzysR0aFSUVLpFhc=
Received: from localhost(mailfrom:shuox.liu@linux.alibaba.com
 fp:SMTPD_---0WMsPXs8_1735890230 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 03 Jan 2025 15:43:50 +0800
Date: Fri, 3 Jan 2025 15:43:49 +0800
From: Shuo Liu <shuox.liu@linux.alibaba.com>
To: Gerry Liu <gerry@linux.alibaba.com>
Cc: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 kent.russell@amd.com
Subject: Re: [PATCH 4/6] amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
Message-ID: <Z3eVNVoTJhyAiV83@shuo-ali-mbp.local>
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <176921ed3539fb55e4a222212b638caf84ebf4aa.1735795671.git.gerry@linux.alibaba.com>
 <291f4971-132c-4587-ad36-158a8ab64883@amd.com>
 <4A1FAF80-B3D5-4440-A73E-6D8AE2486F7A@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A1FAF80-B3D5-4440-A73E-6D8AE2486F7A@linux.alibaba.com>
X-Mailman-Approved-At: Fri, 03 Jan 2025 10:12:56 +0000
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

On Fri  3.Jan'25 at 15:02:38 +0800, Gerry Liu wrote:
>
>
>> 2025年1月3日 13:58，Chen, Xiaogang <xiaogang.chen@amd.com> 写道：
>>
>>
>>
>> On 1/1/2025 11:36 PM, Jiang Liu wrote:
>>> If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
>>> after free bug related to amdgpu_driver_release_kms() as:
>>> 2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>> 2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in kernel mode
>>> 2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - not-present page
>>> 2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
>>> 2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>>> 2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
>>> 2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
>>> 2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
>>> 2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
>>> 43 28 4d 63 ec <4a> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
>>> 2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
>>> 2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
>>> 2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
>>> 2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
>>> 2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>> 2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
>>> 2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
>>> 2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> 2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
>>> 2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> 2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>>> e024se+0x3c/0x90 [amdxcp]
>>> 2024-12-26 16:17:46 [16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
>>> 2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
>>> 2024-12-26 16:17:46 [16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> 2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26
>>>
>>> Fix it by unplugging xcp drm devices when failed to probe GPU devices.
>>>
>>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com> <mailto:gerry@linux.alibaba.com>
>>> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com> <mailto:shuox.liu@linux.alibaba.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 1 +
>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 5ffe1dad9622..e7f35e3a6d2d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -164,8 +164,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>>  		DRM_WARN("smart shift update failed\n");
>>>
>>>  out:
>>> -	if (r)
>>> +	if (r) {
>>> +		amdgpu_xcp_dev_unplug(adev);
>>>  		amdgpu_driver_unload_kms(dev);
>>> +	}
>>>
>> I wonder if you can call amdgpu_xcp_dev_unplug here. It will call drm_dev_unplug that unplugs a hotpluggable DRM device. In you case amdgpu_driver_load_kms failed during probe time. We need unwind amdgpu_driver_load_kms. Why need do unplug a DRM device?
>>
>> The backtrace show:
>>
>> 2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
>> has:
>>
>> 2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> How this change is related to the invalid access above? Can you explain more?
>>
>Per my understanding, `amdgpu_xcp_dev_unplug(adev)` is a workaround for design flaw of the amdgpu_xcp driver.
>Currently the amdgpu_xcp driver assumes everything will go as expected and there’s no failure or GPU hot-lug operations.
>So it only provides an interface `amdgpu_xcp_drm_dev_alloc()` to create xcp devices for a GPU instance, and another interface
>`amdgpu_xcp_drv_release()` to destroy xcp devices for GPU instances. There’s no interface to undo what done by `amdgpu_xcp_drm_dev_alloc()`.
>And I found `amdgpu_xcp_dev_unplug(adev)` can undo work done by `amdgpu_xcp_drm_dev_alloc()`.
>
>So it’s a workaround, the fundamental solution should be to enhance amdgpu_xcp driver to provide interface to unroll work
>done by `amdgpu_xcp_drm_dev_alloc()`.
Agree. Actually, some ops of amdgpu_partition_driver cannot be reused
directly by amd_xcp drm device. DRM doesn't use its minor->dev as 
param of such callbacks, just like .release(). When
amdgpu_driver_release_kms() use a amd_xcp drm dev to find the `struct
amdgpu_device *adev`, unexcepted memory accesses.

shuo
>
>The code paths to trigger the use after free are:
>1) in function amdgpu_xcp_dev_alloc(), we allocate a drm_device by calling amdgpu_xcp_drm_dev_alloc(), and then change the device’s driver to amdgpu_partition_driver.
>2) in function amdgpu_xcp_dev_unplug(), it restores drm_device’s driver to the original device driver.
>
>In function amdgpu_driver_load_kms(), if we don’t call amdgpu_xcp_dev_unplug() on error recover path, the `xcp_dev[idx].driver` will still points to amdgpu_partition_driver.
>Later when amdgpu_xcp_drv_release() gets called, it will call platform_device_unregister() -> amdgpu_partition_driver.release -> amdgpu_driver_release_kms().
>Here when amdgpu_driver_release_kms() gets called, the corresponding amdgpu_device object has already been released on error recovery path in function amdgpu_pci_probe().
>
>So just like amdgpu_pci_remove(), we call amdgpu_xcp_gpu_dev_unplug() before calling amdkcl_drm_dev_release().
>> Regards
>>
>> Xiaogang
>>
>>
>>
>>
>>
>>>  	return r;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> index a6d456ec6aeb..ef4eaacf67f6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> @@ -382,6 +382,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>>>  		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
>>>  		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
>>>  		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
>>> +		adev->xcp_mgr->xcp[i].ddev = NULL;
>>>  	}
>>>  }
>>>
>
