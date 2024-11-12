Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA0D42B81
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 13:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373F610E5EF;
	Tue, 12 Nov 2024 13:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQLrAHmM";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1514810E5E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 13:43:04 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so3301874f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 05:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731418982; x=1732023782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y5CPqQ7d1D9x62AyBfRKOK9sBRy0Ca4qWclrTHYNGTQ=;
 b=UQLrAHmM7epuSZMWvoCImOc5fM3vvG6ZIyHpChpjJlMKJLoV7TKakJTLmm8wc3ghkx
 F4lZdrrtJQKvxtcbOU6rFXWNjaJbvGUZ/aQtd5MuqODVrTbFRsDSfocSv+BePBf7giv8
 ioiw0V2Yf+vuUtXZG96whwGWjkCxeiaT31QLr/OhRwHgHEcoY4Y72gDPKfwnv1/UsJKo
 z1dqZ09PZEro2NFD9cQb3xfalddFLzZN5QU3iOZwFEWIETy86wZHLIkvI+KQ3/jF6/ol
 svccwIoQwK8Y95rAHOFRnrS39Er7igrT5Anf/Pztlvt9t3kLT01R88UgkUdMfw0EybiK
 976A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731418982; x=1732023782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5CPqQ7d1D9x62AyBfRKOK9sBRy0Ca4qWclrTHYNGTQ=;
 b=RXQOqMVzWNYu2GFE8KPQXpOW/44KSdinWMvCX9OM4Cbwv6dUh7pD+f+Q3MjxHqQl2f
 zJJvY96oSpDAzlOY1cXIMTLVIyt82I0dtDMgBsPhA0vU7ZNlBBrkTVBQ0oIsU1GEeDDY
 d2rGYoeJbldlsrchPu9pgMRMxoK/D9OqtxE6R42WPdWJPOVuC/hk+RUzyd1BVEEuyodz
 z87MwymcVI4QpLzD2J835c8hf6VmPrnXvZlCyhB0KfdgJA26l074zDr0f9dOMqRKQm9n
 gR2QNaiOjeB4RhMrW/ZjfljYEfzSIPVwDFQpcPmKzJVSl8C12vZI0PqbjcLzCLPNR2dR
 DMOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv2i5kKUcMSD7oRq0RJnqS4hN9kZpDFDjS7yW2YNC+c9jXxmRF6tRTSjS0+So6wSyv1bUqKIJY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9hyiaMcfpEUbRmwE+IWYZnMThxdVjewk7jKgNmlKZvCpAsRyJ
 vrbGrmsXr0yHiRFqO7mOwUjX1iVliwwRSRYbduYV9oGaK9wyHy8FInQUb2EW
X-Google-Smtp-Source: AGHT+IF8PrlAYPF8Vo3PSXsOPnONxNGoIqGlPGZRbGQyg/SlY9gI9zkR5lmHtyEyVKYhSDhNCRBljg==
X-Received: by 2002:a05:6000:4028:b0:37d:46ad:127f with SMTP id
 ffacd0b85a97d-381f0f870fbmr14380260f8f.26.1731418982012; 
 Tue, 12 Nov 2024 05:43:02 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda04b52sm15265494f8f.101.2024.11.12.05.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:43:01 -0800 (PST)
Message-ID: <51c29248-0ceb-4dfb-a895-a870ac08d138@gmail.com>
Date: Tue, 12 Nov 2024 14:42:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: correct the SVM DMA device unmap direction
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20241105023332.172404-1-Prike.Liang@amd.com>
 <04d4ab32-45a1-4b88-86ee-fb0f35a0ca40@amd.com>
 <3e8ece68-d9e7-4037-bc99-d3f9b78128b5@amd.com>
 <02ddce81-b7fc-4b72-8fa6-1aee9346edbc@amd.com>
 <DS7PR12MB6005480DEC6C9C186A59F90DFB5D2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <4bf5c85a-744a-4456-b7f7-98e37f493f34@amd.com>
 <DS7PR12MB60051020328D30250EE07F51FB582@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DS7PR12MB60051020328D30250EE07F51FB582@DS7PR12MB6005.namprd12.prod.outlook.com>
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

Am 11.11.24 um 04:06 schrieb Liang, Prike:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, November 8, 2024 5:40 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish
>> <Harish.Kasiviswanathan@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: correct the SVM DMA device unmap direction
>>
>> Am 08.11.24 um 10:15 schrieb Liang, Prike:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Wednesday, November 6, 2024 8:24 PM
>>>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Liang, Prike
>>>> <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan,
>>>> Harish <Harish.Kasiviswanathan@amd.com>
>>>> Subject: Re: [PATCH] drm/amdkfd: correct the SVM DMA device unmap
>>>> direction
>>>>
>>>> Am 05.11.24 um 17:34 schrieb Felix Kuehling:
>>>>> On 2024-11-05 06:04, Christian König wrote:
>>>>>> Am 05.11.24 um 03:33 schrieb Prike Liang:
>>>>>>> The SVM DMA device unmap direction should be same as the DMA map
>>>>>>> process.
>>>>>> At least of hand that looks like it's only papering over a major
>>>>>> problem.
>>>>>>
>>>>>> Why are DMA ranges for SVM mapped with a direction in the first
>>>>>> place? That is usually not something we should do.
>>>>> These are DMA mappings of system memory pages. I guess we're
>>>>> creating DMA mappings only for the access required for the
>>>>> migration, which is not bidirectional. I see we do something similar
>>>>> for userptr mappings depending on whether the GPU mapping is
>>>>> read-only or read-write. Is that wrong for userptrs as well?
>>>> I think so, yes. The DMA directions are there to make explicit CPU
>>>> cache management and bounce buffers possible.
>>>>
>>>> Since we shouldn't need or even want either for a cache coherent PCIe
>>>> device we should probably always use BIDIRECTIONAL.
>>>>
>>> The DMA core will check the direction when the driver performs DMA unmap, and
>> if the DMA unmap direction does not match the map direction setting, it will report a
>> warning like the following.
>>
>> Yeah, that is perfectly expected. Doing the unmap with a different setting than the
>> map is clearly a bug.
>>
>> The question is rather should the map or the unmap operation be changed?
>>
>> In your patch you propose to change the unmap operation, but I think that is wrong
>> and the map operation should use BIDIRECTIONAL in the first place.
> Thanks for the suggestion but based on the DMA direction design and streaming DMA sync policy, the BIDIRECTIONAL setting is unlikely to be used unless the direction is unclear or it's an exact DMA read/write case. In a scenario like the SVM migration unmap problem, such as in the function svm_migrate_copy_to_vram() where buffers migrate from system memory to VRAM, should the KFD explicitly set the DMA map direction to DMA_TO_DEVICE instead of BIDIRECTIONAL?

No, the DMA_TO_DEVICE direction should be used only if you can guarantee 
that you don't have any other mappings with BIDIRECTIONAL.

And exactly that's what we most likely don't have.

Regards,
Christian.

>
> Regards,
>   Prike
>
>> Regards,
>> Christian.
>>
>>>    Meanwhile, for stream DMA unmappings without the
>> DMA_ATTR_SKIP_CPU_SYNC attribute setting, there will be a different cache
>> policy for each DMA direction. So, will this affect the unmap performance when all
>> using the BIDIRECTIONAL setting?
>>> For userptr unmappings, it appears that they are doing the correct thing by using
>> the same direction as the mapping setting.
>>> ...... < SNIP>
>>> DMA-API: amdgpu 0000:03:00.0: device driver frees DMA memory with
>>> different direction [device address=0x00000001f8263000] [size=4096
>>> bytes] [mapped with DMA_TO_DEVICE] [unmapped with DMA_BIDIRECTIONAL]
>>> Nov  4 15:45:32 prike-queue-reset kernel: [352033.360158] WARNING: CPU: 9
>> PID: 11671 at kernel/dma/debug.c:1028 check_unmap+0x1cc/0x930 Nov  4
>> 15:45:32 prike-queue-reset kernel: [352033.360165] Modules linked in: veth
>> amdgpu(OE) amdxcp drm_exec gpu_sched drm_buddy drm_ttm_helper ttm(OE)
>> drm_suballoc_helper drm_display_helper drm_kms_helper drm i2c_algo_bit video tls
>> rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace netfs xt_conntrack
>> xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo iptable_nat
>> xt_addrtype iptable_filter br_netfilter nvme_fabrics overlay bridge nfnetlink_cttimeout
>> stp llc nfnetlink openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6
>> nf_defrag_ipv4 libcrc32c sch_fq_codel intel_rapl_msr amd_atl intel_rapl_common
>> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component
>> snd_hda_codec_hdmi sunrpc edac_mce_amd snd_hda_intel snd_intel_dspcfg
>> snd_hda_codec kvm_amd snd_pci_acp6x snd_hda_core snd_acp_config
>> snd_soc_acpi snd_hwdep binfmt_misc kvm snd_pcm nls_iso8859_1
>> crct10dif_pclmul snd_seq_midi snd_seq_midi_event ghash_clmulni_intel
>> sha512_ssse3 sha256_ssse3 snd_rawmidi sha1_ssse3 aesni_intel crypto_simd
>> cryptd snd_seq input_leds rapl serio_raw wmi_bmof Nov  4 15:45:32 prike-queue-
>> reset kernel: [352033.360255]  snd_seq_device k10temp snd_timer sp5100_tco snd
>> ccp soundcore ipmi_devintf cm32181 ipmi_msghandler industrialio mac_hid msr
>> parport_pc ppdev lp parport efi_pstore ip_tables x_tables pci_stub crc32_pclmul
>> nvme ahci libahci i2c_piix4 r8169 nvme_core i2c_designware_pci realtek
>> i2c_ccgx_ucsi wmi cdc_ether hid_generic usbnet usbhid r8152 hid mii [last
>> unloaded: drm]
>>> Nov  4 15:45:32 prike-queue-reset kernel: [352033.360297] CPU: 9 PID: 11671
>> Comm: pt_main_thread Tainted: G           OE      6.10.0-custom #492
>>> Nov  4 15:45:32 prike-queue-reset kernel: [352033.360301] Hardware
>>> name: AMD Majolica-RN/Majolica-RN, BIOS RMJ1009A 06/13/2021 Nov  4
>>> 15:45:32 prike-queue-reset kernel: [352033.360303] RIP:
>>> 0010:check_unmap+0x1cc/0x930 Nov  4 15:45:32 prike-queue-reset kernel:
>>> [352033.360306] Code: c0 4c 89 4d c8 e8 34 bf 86 00 4c 8b 4d c8 4c 8b
>>> 45 c0 48 8b 4d b8 48 89 c6 41 57 4c 89 ea 48 c7 c7 80 49 b4 90 e8 b4
>>> 81 f3 ff <0f> 0b 48 c7 c7 04 83 ac 90 e8 76 ba fc ff 41 8b 76 4c 49 8d
>>> 7e 50 Nov  4 15:45:32 prike-queue-reset kernel: [352033.360308] RSP:
>>> 0018:ffff9c0f855179e0 EFLAGS: 00010086 Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.360311] RAX: 0000000000000000 RBX:
>>> ffffffff9165c138 RCX: 0000000000000027 Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.360313] RDX: ffff8a6fcf6a1688 RSI:
>>> 0000000000000001 RDI: ffff8a6fcf6a1680 Nov  4 15:45:32 prike-queue-reset
>> kernel: [352033.360315] RBP: ffff9c0f85517a30 R08: 00000000000000c9 R09:
>> ffff9c0f85517850 Nov  4 15:45:32 prike-queue-reset kernel: [352033.360316] R10:
>> ffff9c0f85517848 R11: ffffffff90f46328 R12: ffff9c0f85517a40 Nov  4 15:45:32 prike-
>> queue-reset kernel: [352033.360318] R13: ffff8a6c831ec7e0 R14: ffff8a6c819ced80
>> R15: ffffffff90ac831b Nov  4 15:45:32 prike-queue-reset kernel: [352033.360320] FS:
>> 00007ff81db1b740(0000) GS:ffff8a6fcf680000(0000) knlGS:0000000000000000 Nov
>> 4 15:45:32 prike-queue-reset kernel: [352033.360322] CS:  0010 DS: 0000 ES: 0000
>> CR0: 0000000080050033 Nov  4 15:45:32 prike-queue-reset kernel:
>> [352033.360324] CR2: 00007ff310200020 CR3: 0000000158f7a000 CR4:
>> 0000000000350ef0 Nov  4 15:45:32 prike-queue-reset kernel: [352033.360326] Call
>> Trace:
>>> Nov  4 15:45:32 prike-queue-reset kernel: [352033.360327]  <TASK> Nov
>>> 4 15:45:32 prike-queue-reset kernel: [352033.360330]  ?
>>> show_regs+0x6d/0x80 Nov  4 15:45:32 prike-queue-reset kernel:
>>> [352033.360334]  ? __warn+0x8c/0x140 Nov  4 15:45:32 prike-queue-reset
>>> kernel: [352033.360339]  ? check_unmap+0x1cc/0x930 Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.360343]  ? report_bug+0x193/0x1a0
>>> Nov  4 15:45:32 prike-queue-reset kernel: [352033.360347]  ?
>>> handle_bug+0x46/0x80 Nov  4 15:45:32 prike-queue-reset kernel:
>>> [352033.360352]  ? exc_invalid_op+0x1d/0x80 Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.360355]  ?
>>> asm_exc_invalid_op+0x1f/0x30 Nov  4 15:45:32 prike-queue-reset kernel:
>>> [352033.360362]  ? check_unmap+0x1cc/0x930 Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.360367]
>>> debug_dma_unmap_page+0x86/0x90 Nov  4 15:45:32 prike-queue-reset
>>> kernel: [352033.360373]  ? srso_return_thunk+0x5/0x5f Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.360377]  ? rmap_walk+0x28/0x50 Nov
>>> 4 15:45:32 prike-queue-reset kernel: [352033.360380]  ?
>>> srso_return_thunk+0x5/0x5f Nov  4 15:45:32 prike-queue-reset kernel:
>>> [352033.360383]  ? remove_migration_ptes+0x79/0x80 Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.360388]  ?
>>> srso_return_thunk+0x5/0x5f Nov  4 15:45:32 prike-queue-reset kernel:
>>> [352033.360391]  dma_unmap_page_attrs+0xfa/0x1d0 Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.360396]
>>> svm_range_dma_unmap_dev+0x8a/0xf0 [amdgpu] Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.360638]
>>> svm_migrate_ram_to_vram+0x361/0x740 [amdgpu] Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.360840]
>>> svm_migrate_to_vram+0xa8/0xe0 [amdgpu] Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.361034]
>>> svm_range_set_attr+0xff2/0x1450 [amdgpu] Nov  4 15:45:32
>>> prike-queue-reset kernel: [352033.361232]  svm_ioctl+0x4a/0x50
>>> [amdgpu] Nov  4 15:45:32 prike-queue-reset kernel: [352033.361424]
>>> kfd_ioctl_svm+0x54/0x90 [amdgpu] Nov  4 15:45:32 prike-queue-reset
>>> kernel: [352033.361613]  kfd_ioctl+0x3c2/0x530 [amdgpu] Nov  4
>>> 15:45:32 prike-queue-reset kernel: [352033.361798]  ?
>>> __pfx_kfd_ioctl_svm+0x10/0x10 [amdgpu
>>>
>>> Regards,
>>>       Prike
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>>     Felix
>>>>>
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++--
>>>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 6 +++---
>>>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 ++-
>>>>>>>     3 files changed, 7 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>>> index eacfeb32f35d..9d83bb9dd004 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>>>> @@ -445,7 +445,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node,
>>>>>>> struct svm_range *prange,
>>>>>>>         pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>>>>>>>                  mpages, cpages, migrate.npages);
>>>>>>>     -    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>>>>>>> +    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages,
>>>>>>> DMA_TO_DEVICE);
>>>>>>>       out_free:
>>>>>>>         kvfree(buf);
>>>>>>> @@ -750,7 +750,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node,
>>>>>>> struct svm_range *prange,
>>>>>>>         svm_migrate_copy_done(adev, mfence);
>>>>>>>         migrate_vma_finalize(&migrate);
>>>>>>>     -    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>>>>>>> +    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages,
>>>>>>> DMA_FROM_DEVICE);
>>>>>>>       out_free:
>>>>>>>         kvfree(buf);
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>>> index 3e2911895c74..c21485fe6cbb 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>>> @@ -233,9 +233,9 @@ svm_range_dma_map(struct svm_range *prange,
>>>>>>> unsigned long *bitmap,
>>>>>>>     }
>>>>>>>       void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t
>>>>>>> *dma_addr,
>>>>>>> -             unsigned long offset, unsigned long npages)
>>>>>>> +             unsigned long offset, unsigned long npages,
>>>>>>> +                enum dma_data_direction dir)
>>>>>>>     {
>>>>>>> -    enum dma_data_direction dir = DMA_BIDIRECTIONAL;
>>>>>>>         int i;
>>>>>>>           if (!dma_addr)
>>>>>>> @@ -272,7 +272,7 @@ void svm_range_dma_unmap(struct svm_range
>>>>>>> *prange)
>>>>>>>             }
>>>>>>>             dev = &pdd->dev->adev->pdev->dev;
>>>>>>>     -        svm_range_dma_unmap_dev(dev, dma_addr, 0,
>>>>>>> prange->npages);
>>>>>>> +        svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages,
>>>>>>> DMA_BIDIRECTIONAL);
>>>>>>>         }
>>>>>>>     }
>>>>>>>     diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>>>> index bddd24f04669..5370d68bc5b2 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>>>>>> @@ -182,7 +182,8 @@ void svm_range_add_list_work(struct
>>>>>>> svm_range_list *svms,
>>>>>>>                      enum svm_work_list_ops op);
>>>>>>>     void schedule_deferred_list_work(struct svm_range_list *svms);
>>>>>>>     void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t
>>>>>>> *dma_addr,
>>>>>>> -             unsigned long offset, unsigned long npages);
>>>>>>> +             unsigned long offset, unsigned long npages,
>>>>>>> +             enum dma_data_direction dir);
>>>>>>>     void svm_range_dma_unmap(struct svm_range *prange);
>>>>>>>     int svm_range_get_info(struct kfd_process *p, uint32_t
>>>>>>> *num_svm_ranges,
>>>>>>>                    uint64_t *svm_priv_data_size);

