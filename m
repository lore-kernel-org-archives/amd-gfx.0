Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4869ACD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 08:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4AF310E5D0;
	Fri,  8 May 2026 08:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VqhJfZ8L";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF86010E5D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 08:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6u43bU3A7MET8iebFSvq/xdMW6rlPa+SQDPScxAawLQ3+P+DiMK1nP7I0lLnczl8ARmr4q7mH5797xw0+pFUsmJRfAd5MQV4RDJf5B51q1W4lJ68cLsdtooNoxlThqqCkkkR6dIMuWtuYmQ1NqURoRybzc2V6O+txQxGe2JB3DSBtLsaYXf36sHlK2JEAbb+gs0foHD2CyiDweJrfyEIF6d4PehQEH3hzEKutE15cgzKSqVM5PXijsgInNNj1AFxRngOHgfokMaa2g/pm52zXIWHZVu4u8NfO9OkuGgodiWyBnuUdpe6qevvav4oBUg+QP3GDOAv8goWTIKHSFAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvPc+RvkiGe2Qcnj1Sa77ffFEjdY2efmfiqUFmnTt6k=;
 b=Av31Hp56fciLY27Lsy7jj4d9YgYLAkhpkONZnVokZSQIGwLBqFerwoayHnrrXz1Y62m/Imyqy0sAsZxBvlXh8alkSQh2XtnlhJ/Vd2VuDHMfa5RgDDAbZZ+hRq28nWo16HkvBizLg0sGBuDpESFb5VYoMsPo864fmOz8uJzn13m26P5PGI8fBuSkf264nqex6z0alhIGauX9tMGjhEnQZl2x0O7kZHjip/o2RkPtAKr1fw31imcmhpjfjPc7ltAR9K3vigjauwq1YtXM6h7MWt/+RwdWBta3Fbl5QTkBBMCCzWqOIIlsTmD/Ca9ewneCTplalAxAwiqNjeL2BQLb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvPc+RvkiGe2Qcnj1Sa77ffFEjdY2efmfiqUFmnTt6k=;
 b=VqhJfZ8Lx6ZzUVCdk6xQmsWg0WOYQ/LMM3yQDRo4oqqK6ROizQQVkC13KFChON8qkajddLpzkC3eLH3+2ZJksi2Fap4HmEQ7YRwp/bZNCI4+Yv5yNEAZSRl1rsW9tpLrHkWgrDvCI8o+dQyouBf8ynaeA4AqGOV8pZbu4csNB20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 08:11:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Fri, 8 May 2026
 08:11:40 +0000
Message-ID: <6c7785d5-4619-4348-9772-9de8c30bce21@amd.com>
Date: Fri, 8 May 2026 10:11:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 "Honglei1.Huang@amd.com" <honghuan@amd.com>, Alexander.Deucher@amd.com,
 Perry.Yuan@amd.com, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>
References: <20260507140934.1001909-1-yifan1.zhang@amd.com>
 <d1e60cfa-2e93-48ff-9af6-72366aba7e06@amd.com>
 <CADnq5_P=UYFyxiFaxj2YQdfyaJCSYhHHT9shk4LxfPa+XMV-7Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_P=UYFyxiFaxj2YQdfyaJCSYhHHT9shk4LxfPa+XMV-7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0388.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fbe5ec-8ca2-4b6e-9dae-08deacd96e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|8126099003|3023799003;
X-Microsoft-Antispam-Message-Info: 4teOAt2ckM9B5j2kEBm+iDCAPT5C00kRnxwR5rsvCJHxzTL9pcWa7CqUk9QEnaR9Vghe0FyZt6ueC60AjaMQm+T5ecxSRxKQfugMrU38LaZjUOcbw82/engacWga+Qa8f7wbrNzBAQiBKsNPwNQ+StEEtnDGhwJzhFzV9S9wBoZf0k+K/M2dgm4jzw6DrBgECeeRcIMbBJaI60q9FwFzwOF9AAI/NhCpDKirg3okiE5uvy0Svlv8dNt6vKfzIaa3K9FZnMH81L5eWoBI9AQKvD5HUVvR6GjZS/KBhvPHye4a/9mvLYIoYlB9N71/k82K6aEXu9ANGCHgw9xY6A4PE92tVUDl2werY3s2cwd4D1l/qoUoxLJ4GdCTfCbYKVLp2XAhKQR7VjMg7pv7QysY4FukODXP5lRFojMqpic3ocdVBd7dDVhS7HZlPC1BVUPJIqgQqNnZT/NiKPH+RcPgpMvkPAjN49gY5jpQyqtws/BNNAQqfZdpOo1HmWzkuSPxTA22RwqjuA92qTbYL+6H1qD3S8mUjaXJUuCMe2JdfZLTartTVbXq7Nph/nqJKFD8o/jCkMidYcSbnr77JX3x4hgtDK5mX74JBzz1k9S8zMI26RPBYi6c8TJZgsR29lMeiDCSg5UhpSdUpEDcBRr18Hhm6NxU2/m2eYYJsQNOFCIdmJZEGiFT0OkOWpV5dVX8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(8126099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmgybjc0c2U1V002em5CUkxXeGNKR2NVRGhMTnlEa0prUUpVMWNCMG9mUHJx?=
 =?utf-8?B?cS9qY1EvQ1hNblNlSUJpOWJrZHdGb05YNVdyUGhlZkkwSm8vTmJCNlNLeEx6?=
 =?utf-8?B?WHpycGlDTkRVL1IwM3VjQ0JPZC8vNS96OHBWR2ZNRFh2REtzUCtONFZUUDVs?=
 =?utf-8?B?TjlJdzRnOENVdHdnT1Rsb1dlOXVaTm5FelpTOERScmovMmMzTkNEYXJ1TnR4?=
 =?utf-8?B?bWN0UHVSUk9FYmQ0K0lEbzduNjcxZVRsQkFlZGh1TnAvaWdNaS9ZTlNDOEI3?=
 =?utf-8?B?T2ltZXR6M3ArUThTcXlyL251KzFLSmNUOUZpMmpOeHp6VG5TUitDT1RBYzI0?=
 =?utf-8?B?aEEyM2tPakJ1d1Z0NkVzREd3YUFLYVlXb1dtTjVJL2k5M1dHNEJJa21uODc3?=
 =?utf-8?B?cm9VbHNrU2xma1hHU0JzTTZ6VkJZaHpwRUpoZStrbmhJRGF5UlBKYm9ZelEr?=
 =?utf-8?B?aTRhWCtpMFNJSGZJWDlSWlBaQVdyUGhndWdOSGNPWFc2NGtwa2hJUW91cmZN?=
 =?utf-8?B?dmRTQnl5N0J6c0ZSZFhnY2NuMVhOdzU2Ly9uSjN5TERRSFR3RzNlSms3emhW?=
 =?utf-8?B?UGlhV2swY29nL2dFeVNyS3BVSnRPU2FrK05LejJvZGxrK3liZlIzR3JGZWk0?=
 =?utf-8?B?WVZTVEN6YTE3WjY5aUZyQTc1TlhpREg2d3lod3piLzlIZCtIamlJeEhQcmVF?=
 =?utf-8?B?REVKVC8rT1E5V243NjdHeHhGYlRLNDZXOWR3aTg0UTFjQWw2MlJCTXQ3QlR2?=
 =?utf-8?B?dG02Ri9pWVM4eHJieXRtQXlrNko1ckdYRTJtTlB5RndxL3V0bmRxUElRNDNp?=
 =?utf-8?B?Y0o2R0U5Rmd6MEJiamhlV2hNSzFTd2ltVEh2TXpKWGo2QnoxS0FaeE9LZ0lr?=
 =?utf-8?B?eXJYU2lCa3BDT3k3djJEYzU2VURHZUNvZW1JYStYS2pKb1J2UGp6VTJzaWYx?=
 =?utf-8?B?WVlrTkh3dHRZSVZ5cDRYWUJ4MmVWSkZTZ29CS3RhWEZjYVpQSUVKK3F0Q0M3?=
 =?utf-8?B?Nkw5SUk4dC9EWkNHSEhxVG53THNNd1htUVJqckdUTDE2WktSS1JSRUlvaWha?=
 =?utf-8?B?N3J5NGdFeEc3MkEwQW1tcVphTkVmbUNNdlRHZUpkQmJQL3FwU1RSRUM5MzdP?=
 =?utf-8?B?UTNGbHRhSUdzYzNlWEZqWWdDODl1elhVb1A3cTI5Q2hiTTFMRHo0aXFrNDF4?=
 =?utf-8?B?U2NzYVZhNVNlT2FHUFlXcnFEbThnMFVuaTNZaUN5L2V2L2EwbW0yYm5PRU5n?=
 =?utf-8?B?YUhCWUxCMEhqeXVPc2ZnaEp5SXRSS0lnY0RFQ244bVVKM3JHOUpqc0pWUTBD?=
 =?utf-8?B?UnhqR1NBdVk5WFpZQnUzWEo1QUlJdWxHN0dzbEJsWmdwaVhuRGk5ekM3UXow?=
 =?utf-8?B?cjA5U3M2YUtuWXV1Yk9KL084R3pSWmoxTmpzaytlQ0lQSCt0MGhkZjFtSnpy?=
 =?utf-8?B?elZFcC9tSWtoaUQwNGptanVOQnFBRjhrVndMUmgzR2RubkFtckl4VXVFVzlJ?=
 =?utf-8?B?RkFxUGdld24xTm5nSlhnTkhMbjlsdGxYeFo5RTJvQTdqUjY4a3BTQWdZK0VR?=
 =?utf-8?B?K3Z5RDUxazJZUDNXY0tSMFRwZ05TZ3h5dk1yKzRZKzZrTHRoaDQwWkU5Y3BF?=
 =?utf-8?B?aXhWOHN2SW5rdjZNMXNLenFsZ2VoUHdjNndkcGE2Z3o1MVBURjdzZVozaE5l?=
 =?utf-8?B?SUVCTUJ1NmNWRitTa3BJL1IxcXVXRllLclV2OVVjRlR2eTZhSjJuVU4yZnNR?=
 =?utf-8?B?OUlyRVVrZWJNT3hTSFBGdzRlY3p0am9ZazRkRHhtUXFZWmhJU1FtMmREU1VC?=
 =?utf-8?B?VW1yMVhLdWR1QmFLVTZiWWlESFR3cUVJYjIvMG92Q3d2OUxjNEJNMnpJaG92?=
 =?utf-8?B?ZFB5aUd5T0pyYkwvcEZuc0NLUzY5OFFkbWpVeFNxT3F3TXlCbmZXa0tLemxz?=
 =?utf-8?B?eklVc2VlOG8zSThWb1RWODhaVWxRbCtyUmZPQi9nM1pxRHFzQW9MbE44QkQr?=
 =?utf-8?B?cmZuckxRcUZ2dnJrNjFtdUJ0ODdHSEhnbW52Vld1NXBoRTRyaW5xNlVRcGI5?=
 =?utf-8?B?S2hJQmlzS3lzTGFBeDhEVVNFcE4wdWU1cUtPMW1NM1JJNjdDeld5enVBOFJi?=
 =?utf-8?B?TWZ0dnRJaGtaZ285NXZaUVZlVmVZYVEvNFpDNTNEVnIrSjI2S0FEMXFERWsy?=
 =?utf-8?B?dlNxVklHaDRxdGNoaWc2blo1NVp5dVh2bitnejZFbmJIM3ppa2xuaTU1amRC?=
 =?utf-8?B?MXV5ZW5ObFB0Ykd5bkFVOUlzOCtUZmsyMU85LzhwVWlGVjdNUDNiaVFtMTBY?=
 =?utf-8?Q?OKB2qb4HWhug4rfJHW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fbe5ec-8ca2-4b6e-9dae-08deacd96e9f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 08:11:39.9446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujuijbtScj2FQv//LrTxZ/zPuX9/MpgCGIDq7YlOzXcAOsOUEEHJEombD/iATRcb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
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

On 5/7/26 17:05, Alex Deucher wrote:
> On Thu, May 7, 2026 at 10:54 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 5/7/26 16:09, Yifan Zhang wrote:
>>> During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
>>> inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
>>> this window can result in uncompleted PCIe transactions, leading to NMI panics or
>>> system hangs.
>>>
>>> To prevent this, Unmap all of the applications mappings of the framebuffer
>>> and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
>>> during the reset process.
>>
>> I think putting the inode into the kfd_dev would break userspace, so that is a no-go and needs a different solution.
>>
>> But apart from that the patch looks like what I suggested before.
>>
>> Question is since when does that issue exists? Previously we didn't had to take care of that.
> 
> It's always existed, I guess generally there are not often CPU
> accesses to VRAM during a reset.  It depends on the platform and what
> level of PCIe error handling it enables.

Yeah I feared that. Yesterday I've gone through that step by step and came to the conclusion that our approach here won't work at all.

The problem is that vmf_insert_pfn_prot() can cycle back and wait for the GPU reset to complete.

So when we are now holding adev->reset_domain->sem to prevent new mapping while calling vmf_insert_pfn_prot() we can run into a deadlock.

I don't see how we can solve this except for switching TTMs fault handling over to apply_to_page_range() and then holding the lock while calling set_pte().

I tried to do that a while back because it would also improve TTMs mapping performance quite a bit, but that was rejected from upstream because of restrictions around apply_to_page_range().

Anyway this can only be done with a *huge* change to TTM and KFD. I fear we will need multiple month for that.

Regards,
Christian.

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
>>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 12 ++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  7 ++++++-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c         | 17 +++++++++++++++--
>>>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        | 10 ++++++++++
>>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h           |  3 +++
>>>  6 files changed, 47 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 2bf6a31c194d..5333e052d56d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>               uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>>  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>>               uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
>>>
>>>  u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 7c01492e69dd..3ac2bd86c08b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -139,6 +139,18 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>>>       kfd_mem_limit.system_mem_used += size;
>>>  }
>>>
>>> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
>>> +{
>>> +     if (adev->kfd.dev && adev->kfd.dev->inode &&
>>> +             adev->kfd.dev->inode->i_mapping) {
>>> +             unmap_mapping_range(adev->kfd.dev->inode->i_mapping,
>>> +                     KFD_MMAP_TYPE_DOORBELL, kfd_doorbell_process_slice(adev->kfd.dev), 1);
>>> +             unmap_mapping_range(adev->kfd.dev->inode->i_mapping,
>>> +                     KFD_MMAP_TYPE_MMIO, PAGE_SIZE, 1);
>>> +     }
>>> +}
>>> +
>>> +
>>>  /* Estimate page table size needed to represent a given memory size
>>>   *
>>>   * With 4KB pages, we need one 8 byte PTE for each 4KB of memory
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 073f632f295a..c67936d1fb0d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5019,7 +5019,6 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>>>
>>>       /* disable BM */
>>>       pci_clear_master(adev->pdev);
>>> -
>>>       if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
>>>               dev_info(adev->dev, "GPU smu mode1 reset\n");
>>>               ret = amdgpu_dpm_mode1_reset(adev);
>>> @@ -5840,6 +5839,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>       /* We need to lock reset domain only once both for XGMI and single device */
>>>       amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>>>
>>> +     /* unmap all the mappings of doorbell and framebuffer to prevent user space from
>>> +      * accessing them
>>> +      */
>>> +     unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>>> +     amdgpu_amdkfd_clear_kfd_mapping(adev);
>>> +
>>>       amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>>>                                     hive, need_emergency_restart);
>>>       if (need_emergency_restart)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 0071d6957828..1dd343f0219f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -46,6 +46,7 @@
>>>  #include "amdgpu_hmm.h"
>>>  #include "amdgpu_xgmi.h"
>>>  #include "amdgpu_vm.h"
>>> +#include "amdgpu_reset.h"
>>>
>>>  static int
>>>  amdgpu_gem_add_input_fence(struct drm_file *filp,
>>> @@ -118,13 +119,21 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
>>>  static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>>>  {
>>>       struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
>>> +     struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>>>       struct drm_device *ddev = bo->base.dev;
>>>       vm_fault_t ret;
>>>       int idx;
>>>
>>> +     /* Prevent new mappings from coming in during reset */
>>> +
>>> +     if (!down_read_trylock(&adev->reset_domain->sem))
>>> +             return VM_FAULT_SIGSEGV;
>>> +
>>>       ret = ttm_bo_vm_reserve(bo, vmf);
>>> -     if (ret)
>>> +     if (ret) {
>>> +             up_read(&adev->reset_domain->sem);
>>>               return ret;
>>> +     }
>>>
>>>       if (drm_dev_enter(ddev, &idx)) {
>>>               ret = amdgpu_bo_fault_reserve_notify(bo);
>>> @@ -140,11 +149,15 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>>>       } else {
>>>               ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
>>>       }
>>> -     if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
>>> +     if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
>>> +             up_read(&adev->reset_domain->sem);
>>>               return ret;
>>> +     }
>>>
>>>  unlock:
>>>       dma_resv_unlock(bo->base.resv);
>>> +     up_read(&adev->reset_domain->sem);
>>> +
>>>       return ret;
>>>  }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 84b9bde7f371..d5bf5ba73ca0 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -130,11 +130,21 @@ void kfd_chardev_exit(void)
>>>  static int kfd_open(struct inode *inode, struct file *filep)
>>>  {
>>>       struct kfd_process *process;
>>> +     struct kfd_node *node;
>>>       bool is_32bit_user_mode;
>>> +     int i;
>>>
>>>       if (iminor(inode) != 0)
>>>               return -ENODEV;
>>>
>>> +     /* Save inode in kfd_dev for unmap_mapping_range */
>>> +     for (i = 0; kfd_topology_enum_kfd_devices(i, &node) == 0; i++) {
>>> +             if (node && node->kfd && !node->kfd->inode) {
>>> +                     node->kfd->inode = inode;
>>> +                     break;
>>> +             }
>>> +     }
>>> +
>>>       is_32bit_user_mode = in_compat_syscall();
>>>
>>>       if (is_32bit_user_mode) {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index a6ff1db477f9..bfdd7d3bc7cb 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -373,6 +373,9 @@ struct kfd_dev {
>>>
>>>       struct workqueue_struct *ih_wq;
>>>
>>> +     /* kfd inode */
>>> +     struct inode *inode;
>>> +
>>>       /* Kernel doorbells for KFD device */
>>>       struct amdgpu_bo *doorbells;
>>>
>>

