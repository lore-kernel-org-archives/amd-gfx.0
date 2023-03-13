Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27669C6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 13:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4BE88E26;
	Mon, 13 Mar 2023 13:29:35 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AA888E26
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 13:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USPIGlvdj8LKHTncY5i+xONwbgMd+thtVl7WWyPjc3MyElWRW7b8eGIEMXls2MdV9KsEtGDJ1oEy0lk/kDZzIhpzKzd71Qws3HX1pzkNc8PT4Xq/BJmCj1oI9wO1Ubo5lI6MBmbEcFd4wthmtTEVueNuCULIwIDgneWhD/4YuBkCudsw3/bu0TIjwi2xvq994YZ6y9LdjXHskzw3Rb4x4AZNf2xul0s+eMDZYUgz+jb0n0fub4CjHlZwNlB5kM8LjVjdf92ciUfJXT6vwaabibYILkNfzfjUomOBe6PzRPon/06SYCurVTEpG4Uvz7DE0hnvTZFhaPahx7vnHYZviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffIJT5+7Nti5f35KwENkFieBWX/43n4LW1nUR2xrgzE=;
 b=d/E2WLCE5u6i2fbBydnFfUyeo6YjP0FlF8AjklHmhYRAPlZQe0JlmHHsrpZy2T3jx+DAF1QpX9WesdIfOMz6r3HyLEH+XWGQ4ycr6ovuhZiCS47VwxdLIUPBGPGW3x3twVuVVCNeF1AAZcb9QgswintqbwKAIaALcJZ4l8N4gvQkOdi5Dwz1UviueG+uXuXheI1ckTCLd7OryzAfffR2BHW+msFOqC1NbT6gpIg6mTub4HIv8Mh5QrweCBQsH1v1Wp644Ps3R7exGS7WaUcriGPYWXNuyEFr/ua3nXJ85/qzT95+sc+nV8nAX1C1+07LpJWUEvKWD7sYlPvOwsL9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffIJT5+7Nti5f35KwENkFieBWX/43n4LW1nUR2xrgzE=;
 b=uK+GU75yMW6Tv6sclGmj0VDnZ5zokLQNeCUx5h9nuLWhHdyQJ+lt8egziFYv7oXXWHMkNT6zSKgd2Ei3pPolrrx2gglHP6xBJmkZ09ZLrMO/Vt0DFc0tp4bHvyT1LDMlRw7PXg1M6oebuFiNaj/cJuY/1U+5kPDi3zlAPddJGHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:29:32 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 13:29:32 +0000
Message-ID: <d54d2ea4-e259-ac16-52a7-1e5c09acb544@amd.com>
Date: Mon, 13 Mar 2023 14:29:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/2] drm/amdkfd: Move TLB flushing logic into amdgpu
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230310221613.1647188-1-Felix.Kuehling@amd.com>
 <e4173da3-5868-3b21-f2c5-20d1645106f5@amd.com>
 <24f2b8ea-4e5a-7695-cdbf-cfe7e8109dcc@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <24f2b8ea-4e5a-7695-cdbf-cfe7e8109dcc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f0736e-4a7b-436a-3a33-08db23c6fa7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2V34D66rbBxwcOgpPV2UX9zqf5TKm9sJaAu9/nRQcNqTfIY7fAQOJzDPwg1VNo7EwNlYyizx1ZJBkpvFe4/Je26/WPByv51TS4qBKqFuzISI5llJu036aoYBuMUm+DJWgNmM6CyUmfZ9PEa1ZsJjQipQ5jExk0Nx7ahFPzUPy9UstF4umm45HuIc38QsbafpiAuFTnQl54bMEzYFTwV/6ELOfB+UZqaZZhrIjtlUc8g9x2WZ1RLEhrwh+UF7I1NZG7tErxceTh/IaFpLTvTmIo5fDb74AmhHd5svLGKv7mRsUPVofNdAmucCDNm9vhfgbXEkxiKblKzWJWa/zkC5pOMWyWOhz10954TOzwpBZScYqQTiE76PtVHESfEPY8kSMzw3yQumM+gv0U9QwEFg6GCjnInOWdfVsZixWLa30HbR21ogR622EXWopf4MAdzgaxuFx8kuC3U/X4W53xZ5qUMvMoX5c1z2uNHeE+h7YDx3j82tBcuRzXosSg39P2spewWVSfFEsyvctHn0hGA6zyyLSE5wPTiSXrdRqfV3YvfTdIourEglQkdRnzCaLVIBNw8oXctxhCvpoZ0M45cpmVjPZUWrkeUWDcfk9FJEZ8Ffx12+uJVUm7BKew/bq0qO8CJjv+d8I1QT0rWr8zgTiaLQ7aoaqiNvdRTgK2YNOpVEJ3lZgQsTDBf9MZN/O4EA10AG8W1hJc27N6hFmyNV0sVJ2b6byjAkQ5ViorxqcIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(6666004)(66574015)(83380400001)(316002)(110136005)(38100700002)(478600001)(8936002)(186003)(26005)(6512007)(6506007)(36756003)(31696002)(66556008)(66476007)(66946007)(86362001)(2616005)(41300700001)(8676002)(2906002)(31686004)(5660300002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkV1QXBRMjVLa2pDYXlGa1RnYXI3dmhSd2w3dlRFSVpxNmVLek92UGtBaXA1?=
 =?utf-8?B?R1BPdEFYVGtHcmNjV003SmNBekgvcDEwUUVocjRHVGtEL1RDZDB4RFBUTUR4?=
 =?utf-8?B?U1ZoemFxVG13clBidTJwL245VGVEdWFZLzU5c3VUZXBHNUxNV3oxU0UxRVFp?=
 =?utf-8?B?NWlnWlVEczd2MnJ4UWo3aWZGZkljSjM5NDFwTGI1NHZFQmJiQURGNk9VWE9W?=
 =?utf-8?B?NE1TMXlybEt5M01zbmFMbmFzanVmdXh4dkVNbGNZQkpjVjA2OWQ0emRVamx3?=
 =?utf-8?B?TDhXU1pUSjRKUEk3MTNwSVJsTUVlN0wwNVNwaFVNaXZ5cm81ZlBjS2h6RzIr?=
 =?utf-8?B?MHFrdEVESC9ZLzduVGY0YlI2eFNJUEoxMEt0c1dJUy96bzJubkpxY2hnNWhM?=
 =?utf-8?B?RjZZRmVTQkVrZkpMNEYrclREdWdHeVIyVVU5SFBpY0hhekliaGx6aE1sbzAz?=
 =?utf-8?B?ekRUeDcxTWpLS0RDVWl4RkVsMVJUTCtPMnp5Vm1GWm1vUVV1MjNqeTBRWEVq?=
 =?utf-8?B?cXl4TFNjZ3lGOGNaRXBiUWdmTUNxZXFGRm1tdzZWVmdjL3VNL2xtU1ZrWkNm?=
 =?utf-8?B?RkxiRFViYzNiQTU1S1p5V2VyVUcxQ3REc25jL1VPLzdHL28rcFFJeWMyMVRC?=
 =?utf-8?B?VmFpWFpzU1VSVk8xK1BzczBtNVVHSVYxbkZiL1E5di85dWpUU3VnV2UrQVRn?=
 =?utf-8?B?MXh5RFlVSmpMWDlSVWxHZGVxc09YK3NrckFFVUliRkQySm9UcFNmNEhiMFZ5?=
 =?utf-8?B?YXlEQk1VSEFYS2xaV1BxZklVU0JkZzJ5RDZ6d3VPYlU4MG0ycWRwZWlNRmVU?=
 =?utf-8?B?YkxQSEkvZFRmNDJkTEFvaEV1N3NBNTU2V3lEaVJPSkllZjFYSlU1VHF5eEdW?=
 =?utf-8?B?VElUSWU0RjRMRmZwS1kwY3BCNGV2Sm51czlGdDBqclVNV04rYytKU3hERkNh?=
 =?utf-8?B?dUNMN0FmYTcrY2lFQVQ4M1BtQUVXZGp4dFpWa09RWGRIVmkrZHFQaUdiWDBU?=
 =?utf-8?B?V3pUOG9zbmJsTXBmWmZ0VDZsbTRaNjQ3aWU4NE5XaS93bVNPdHErd0lwakZM?=
 =?utf-8?B?bUp3VVRqMC9TbjNiMWk4UHUxUTU3a0Q0YVFlM1BxcnZsdDFCVWZ1Qk9EeFQ2?=
 =?utf-8?B?aDRHa2U1Mnl0OGNSUkZyNCt5WnZSMUZ5dlZ0ZXAvaWV4cjZ6bVJPVWx1c3Nq?=
 =?utf-8?B?eVgzd2Y4NmZUSFMzWWszM0w4YnVnK0w0bWxVWlc0QWt6Qk9xSXBRcUxsejBZ?=
 =?utf-8?B?MDhEUmhGTTgyRnNLc3Q1RncyaXo1b1lMRUhTaGNOM0pzS3JtTER0eFBKRm9I?=
 =?utf-8?B?dHRYSGdmcldmOXRYL3lGbkRXMUd5Nnp3OWY2RWF3bU9YM2hRamlUNVBkdG1N?=
 =?utf-8?B?dU9LNkEvUnYxTlc5RzV5bDN0R2ZCcWRJKzRBbFYyWmtIRHQvY0E1Um1pQjMv?=
 =?utf-8?B?eS95Qk1MRUFwZHpWR1pKRXhIQVFlN1ZHNmxrOFYxMmxzOWtSVEczMnRTbXpj?=
 =?utf-8?B?WWl0REl0UDF1YWFhK1lLWTZYR01uSWpCQmJjclgrdWxmSEtqaXc4bW5hbzRS?=
 =?utf-8?B?bFlOZG1Cc2VIK3lROXBHMHUvUU5QUk9DcUp3ZnFBNDlFZ3hweHNKeXlsQnY2?=
 =?utf-8?B?WnVZc05aWWJYamxaRXRFUGN2QW1henpLS3hGZ1kvcm5vRzN2bjNENUdVTVpK?=
 =?utf-8?B?enEvQmNmRVpZOHpOUFZhMEZISlFwVUpXS2gxcWlHWUdURUZMeDNCVHJ2MmJ3?=
 =?utf-8?B?YzlNNEdIT1ZFU3VMWkc3ZUtHZkhPK0F1dVNicXczVW1xbW1JdUwyV0RIQWRJ?=
 =?utf-8?B?dHZvWXMrMmlKU3lmbjRlZ0wxcVQwazF0TEhpOWdPaFNWRnpZdnVXYThzSExU?=
 =?utf-8?B?YjRuT3JzMkV1S2pnVmxMWGVrUXBmRE5NVlpVT0ZScHlDZnJhZTY5a1BOUnFJ?=
 =?utf-8?B?YnU4ZCtuVktvVTFKRncxRFJxL1lWN0RxMzNNdGhDRTRIM1Y0bEt1eTdPRkxH?=
 =?utf-8?B?bEp1YUlRbjlFU0FOQXhwbmM4Vi9OckRURmxvSEl5K1NENjFHU1VuOERSLzBr?=
 =?utf-8?B?L0Ezd3g3WHFyeENVNHJTUk0zRUllbGdOVjI0Z2F5QU5vNm9ieS9LakFOeS9y?=
 =?utf-8?Q?2s31F9eQI+cJ55Kn3Z7V5c0VY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f0736e-4a7b-436a-3a33-08db23c6fa7b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:29:31.9371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5XAWBAi0S5gwKThzKV4hWgLbPkW7SOiFxw687HdlBjoNujP9BVtdbZBe49aM7uB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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



Am 13.03.23 um 14:21 schrieb Felix Kuehling:
>
> Am 2023-03-13 um 03:36 schrieb Christian König:
>> Am 10.03.23 um 23:16 schrieb Felix Kuehling:
>>> This will make it possible for amdgpu GEM ioctls to flush TLBs on 
>>> compute
>>> VMs.
>>>
>>> This removes VMID-based TLB flushing and always uses PASID-based
>>> flushing. This still works because it scans the VMID-PASID mapping
>>> registers to find the right VMID. It's only slightly less efficient. 
>>> This
>>> is not a production use case.
>>
>> On the one hand it looks nice that we can now flush based on the 
>> pasid without having the NO_HWS dependency (I hope that this was 
>> intentional).
>
> The intention was to be able to trigger PASID TLB flushes from AMDGPU. 
> I need it for flushing compute VMs when their mappings are modified by 
> the GEM VA ioctl. Removing the NO_HWS dependency was a useful 
> simplification to get there.
>
>
>>
>> On the other hand I really don't like to have any variables in the 
>> amdgpu_vm structure which are not worked with by the VM code itself.
>
> So what's the solution? Move that code into amdgpu_vm.c? Or find a 
> different data structure to store the sequence number? I guess I could 
> put it in struct amdgpu_fpriv, which amdgpu_vm is part of.

Yeah, moving more of that into the VM code would be one possibility.

What we should especially do is implementing this TLB flush fence idea, 
I've already pinged Shashank for the MES side and will probably assign 
Amar to implement this for older kernels.

>
>>
>> That already backfired with the pd_phys_addr before.
>
> Can you clarify this concern? I'm not aware of any issues with 
> pd_phys_addr.

Shashank confused this with the addr he should use for the MES and it 
took us a moment to realize that this value isn't updated in the VM code.

Regards,
Christian.

>
> Thanks,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 30 
>>> +++++++++-------------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  6 ++---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  9 +++++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 28 --------------------
>>>   5 files changed, 22 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 8816853e50c0..dcbd28e99b5c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -726,31 +726,25 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct 
>>> amdgpu_device *adev, u32 vmid)
>>>       return false;
>>>   }
>>>   -int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
>>> -                     uint16_t vmid)
>>> -{
>>> -    if (adev->family == AMDGPU_FAMILY_AI) {
>>> -        int i;
>>> -
>>> -        for (i = 0; i < adev->num_vmhubs; i++)
>>> -            amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
>>> -    } else {
>>> -        amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
>>> -    }
>>> -
>>> -    return 0;
>>> -}
>>> -
>>> -int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>> -                      uint16_t pasid, enum TLB_FLUSH_TYPE flush_type)
>>> +int amdgpu_amdkfd_flush_tlb(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm,
>>> +                enum TLB_FLUSH_TYPE type)
>>>   {
>>> +    uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
>>>       bool all_hub = false;
>>>   +    /*
>>> +     * It can be that we race and lose here, but that is extremely 
>>> unlikely
>>> +     * and the worst thing which could happen is that we flush the 
>>> changes
>>> +     * into the TLB once more which is harmless.
>>> +     */
>>> +    if (atomic64_xchg(&vm->kfd_last_flushed_seq, tlb_seq) == tlb_seq)
>>> +        return 0;
>>> +
>>>       if (adev->family == AMDGPU_FAMILY_AI ||
>>>           adev->family == AMDGPU_FAMILY_RV)
>>>           all_hub = true;
>>>   -    return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, 
>>> flush_type, all_hub);
>>> +    return amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, type, 
>>> all_hub);
>>>   }
>>>     bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 01ba3589b60a..dcaf69fd833c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -157,10 +157,8 @@ int amdgpu_amdkfd_submit_ib(struct 
>>> amdgpu_device *adev,
>>>                   uint32_t *ib_cmd, uint32_t ib_len);
>>>   void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, 
>>> bool idle);
>>>   bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>>> -int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
>>> -                uint16_t vmid);
>>> -int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>> -                uint16_t pasid, enum TLB_FLUSH_TYPE flush_type);
>>> +int amdgpu_amdkfd_flush_tlb(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm,
>>> +                enum TLB_FLUSH_TYPE type);
>>>     bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 
>>> vmid);
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 03a3314e5b43..171de7da2959 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -290,6 +290,7 @@ struct amdgpu_vm {
>>>       /* Last finished delayed update */
>>>       atomic64_t        tlb_seq;
>>>       struct dma_fence    *last_tlb_flush;
>>> +    atomic64_t        kfd_last_flushed_seq;
>>>         /* Last unlocked submission to the scheduler entities */
>>>       struct dma_fence    *last_unlocked;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index bfa30d12406b..e029129308e7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -715,7 +715,6 @@ struct kfd_process_device {
>>>       /* VM context for GPUVM allocations */
>>>       struct file *drm_file;
>>>       void *drm_priv;
>>> -    atomic64_t tlb_seq;
>>>         /* GPUVM allocations storage */
>>>       struct idr alloc_idr;
>>> @@ -1344,7 +1343,13 @@ void kfd_signal_reset_event(struct kfd_dev 
>>> *dev);
>>>     void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 
>>> pasid);
>>>   -void kfd_flush_tlb(struct kfd_process_device *pdd, enum 
>>> TLB_FLUSH_TYPE type);
>>> +static inline void kfd_flush_tlb(struct kfd_process_device 
>>> *pdd,                             enum TLB_FLUSH_TYPE type)
>>> +{
>>> +    struct amdgpu_device *adev = pdd->dev->adev;
>>> +    struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
>>> +
>>> +    amdgpu_amdkfd_flush_tlb(adev, vm, type);
>>> +}
>>>     static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>>>   {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index ebabe92f7edb..48d7d30eeb24 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1591,7 +1591,6 @@ int kfd_process_device_init_vm(struct 
>>> kfd_process_device *pdd,
>>>           return ret;
>>>       }
>>>       pdd->drm_priv = drm_file->private_data;
>>> -    atomic64_set(&pdd->tlb_seq, 0);
>>>         ret = kfd_process_device_reserve_ib_mem(pdd);
>>>       if (ret)
>>> @@ -1994,33 +1993,6 @@ int kfd_reserved_mem_mmap(struct kfd_dev 
>>> *dev, struct kfd_process *process,
>>>                      KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
>>>   }
>>>   -void kfd_flush_tlb(struct kfd_process_device *pdd, enum 
>>> TLB_FLUSH_TYPE type)
>>> -{
>>> -    struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
>>> -    uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
>>> -    struct kfd_dev *dev = pdd->dev;
>>> -
>>> -    /*
>>> -     * It can be that we race and lose here, but that is extremely 
>>> unlikely
>>> -     * and the worst thing which could happen is that we flush the 
>>> changes
>>> -     * into the TLB once more which is harmless.
>>> -     */
>>> -    if (atomic64_xchg(&pdd->tlb_seq, tlb_seq) == tlb_seq)
>>> -        return;
>>> -
>>> -    if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>>> -        /* Nothing to flush until a VMID is assigned, which
>>> -         * only happens when the first queue is created.
>>> -         */
>>> -        if (pdd->qpd.vmid)
>>> -            amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->adev,
>>> -                            pdd->qpd.vmid);
>>> -    } else {
>>> -        amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->adev,
>>> -                    pdd->process->pasid, type);
>>> -    }
>>> -}
>>> -
>>>   struct kfd_process_device *kfd_process_device_data_by_id(struct 
>>> kfd_process *p, uint32_t gpu_id)
>>>   {
>>>       int i;
>>

