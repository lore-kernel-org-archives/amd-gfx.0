Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19809C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 16:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D522660C4B
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 16:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D522660C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35704898BF;
	Mon, 25 Oct 2021 16:02:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 51EAD89F89
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 16:02:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A30891FB;
 Mon, 25 Oct 2021 09:01:58 -0700 (PDT)
Received: from [10.57.27.231] (unknown [10.57.27.231])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F7E53F5A1;
 Mon, 25 Oct 2021 09:01:56 -0700 (PDT)
Subject: Re: I got an IOMMU IO page fault. What to do now?
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: x86@kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alex Deucher <alexander.deucher@amd.com>,
 it+linux-iommu@molgen.mpg.de, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
Date: Mon, 25 Oct 2021 17:01:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 Oct 2021 16:02:22 +0000
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

On 2021-10-25 12:23, Christian König wrote:
> Hi Paul,
> 
> not sure how the IOMMU gives out addresses, but the printed ones look 
> suspicious to me. Something like we are using an invalid address like -1 
> or similar.

FWIW those look like believable DMA addresses to me, assuming that the 
DMA mapping APIs are being backed iommu_dma_ops and the device has a 
40-bit DMA mask, since the IOVA allocator works top-down.

Likely causes are either a race where the dma_unmap_*() call happens 
before the hardware has really stopped accessing the relevant addresses, 
or the device's DMA mask has been set larger than it should be, and thus 
the upper bits have been truncated in the round-trip through the hardware.

Given the addresses involved, my suspicions would initially lean towards 
the latter case - the faults are in the very topmost pages which imply 
they're the first things mapped in that range. The other contributing 
factor being the trick that the IOVA allocator plays for PCI devices, 
where it tries to prefer 32-bit addresses. Thus you're only likely to 
see this happen once you already have ~3.5-4GB of live DMA-mapped memory 
to exhaust the 32-bit IOVA space (minus some reserved areas) and start 
allocating from the full DMA mask. You should be able to check that with 
a 5.13 or newer kernel by booting with "iommu.forcedac=1" and seeing if 
it breaks immediately (unfortunately with an older kernel you'd have to 
manually hack iommu_dma_alloc_iova() to the same effect).

Robin.

> Can you try that on an up to date kernel as well? E.g. ideally bleeding 
> edge amd-staging-drm-next from Alex repository.
> 
> Regards,
> Christian.
> 
> Am 25.10.21 um 12:25 schrieb Paul Menzel:
>> Dear Linux folks,
>>
>>
>> On a Dell OptiPlex 5055, Linux 5.10.24 logged the IOMMU messages 
>> below. (GPU hang in amdgpu issue #1762 [1] might be related.)
>>
>>     $ lspci -nn -s 05:00.0
>>     05:00.0 VGA compatible controller [0300]: Advanced Micro Devices, 
>> Inc. [AMD/ATI] Oland [Radeon HD 8570 / R7 240/340 OEM] [1002:6611] 
>> (rev 87)
>>     $ dmesg
>>     […]
>>     [6318399.745242] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT domain=0x000c address=0xfffffff0c0 flags=0x0020]
>>     [6318399.757283] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT domain=0x000c address=0xfffffff7c0 flags=0x0020]
>>     [6318399.769154] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT domain=0x000c address=0xffffffe0c0 flags=0x0020]
>>     [6318399.780913] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT domain=0x000c address=0xfffffffec0 flags=0x0020]
>>     [6318399.792734] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT domain=0x000c address=0xffffffe5c0 flags=0x0020]
>>     [6318399.804309] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT domain=0x000c address=0xffffffd0c0 flags=0x0020]
>>     [6318399.816091] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT domain=0x000c address=0xffffffecc0 flags=0x0020]
>>     [6318399.827407] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT domain=0x000c address=0xffffffd3c0 flags=0x0020]
>>     [6318399.838708] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT domain=0x000c address=0xffffffc0c0 flags=0x0020]
>>     [6318399.850029] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT domain=0x000c address=0xffffffdac0 flags=0x0020]
>>     [6318399.861311] AMD-Vi: Event logged [IO_PAGE_FAULT 
>> device=05:00.0 domain=0x000c address=0xffffffc1c0 flags=0x0020]
>>     [6318399.872044] AMD-Vi: Event logged [IO_PAGE_FAULT 
>> device=05:00.0 domain=0x000c address=0xffffffc8c0 flags=0x0020]
>>     [6318399.882797] AMD-Vi: Event logged [IO_PAGE_FAULT 
>> device=05:00.0 domain=0x000c address=0xffffffb0c0 flags=0x0020]
>>     [6318399.893655] AMD-Vi: Event logged [IO_PAGE_FAULT 
>> device=05:00.0 domain=0x000c address=0xffffffcfc0 flags=0x0020]
>>     [6318399.904445] AMD-Vi: Event logged [IO_PAGE_FAULT 
>> device=05:00.0 domain=0x000c address=0xffffffb6c0 flags=0x0020]
>>     [6318399.915222] AMD-Vi: Event logged [IO_PAGE_FAULT 
>> device=05:00.0 domain=0x000c address=0xffffffa0c0 flags=0x0020]
>>     [6318399.925931] AMD-Vi: Event logged [IO_PAGE_FAULT 
>> device=05:00.0 domain=0x000c address=0xffffffbdc0 flags=0x0020]
>>     [6318399.936691] AMD-Vi: Event logged [IO_PAGE_FAULT 
>> device=05:00.0 domain=0x000c address=0xffffffa4c0 flags=0x0020]
>>     [6318399.947479] AMD-Vi: Event logged [IO_PAGE_FAULT 
>> device=05:00.0 domain=0x000c address=0xffffff90c0 flags=0x0020]
>>     [6318399.958270] AMD-Vi: Event logged [IO_PAGE_FAULT 
>> device=05:00.0 domain=0x000c address=0xffffffabc0 flags=0x0020]
>>
>> As this is not reproducible, how would debugging go? (The system was 
>> rebooted in the meantime.) What options should be enabled, that next 
>> time the required information is logged, or what commands should I 
>> execute when the system is still in that state, so the bug (driver, 
>> userspace, …) can be pinpointed and fixed?
>>
>>
>> Kind regards,
>>
>> Paul
>>
>>
>> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues/1762
>>      "Oland [Radeon HD 8570 / R7 240/340 OEM]: GPU hang"
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
