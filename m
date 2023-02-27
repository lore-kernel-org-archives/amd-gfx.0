Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DD0C64ED8
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 16:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9834010E10D;
	Mon, 27 Feb 2023 16:31:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3538F10E10D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 16:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbwz77Vxmnj6++8W3O9HclCNTJkpziJNCsbCe1SGr39j/Dr8ZaXILIX07XBRlccmHFXsbWozxIVlKRMJGz2nD34hhve6wHn5QUx9kZ6QIHgqVt7MxrJHQRtx+Oj1qJLkiuRGZkD6qBgTk1ZM+FFclOzTbkusLnRZAKL7dNw/5Cc5JTimMB2J7XCLbBNMe53Bnk7RpL6FqcjDA/xxB7Aku4uaT/zfvu8oKuOMuIp0avZDatLoZgfqcW8AtBv7RsxRD7vJKnpfYHpbon2F7Vm5sLGEnM6/Xovg/9r5meN+cM0qNIb+f7T/ixA6fLvPHzeT9OSvDjJcBTZYOGGi/NACkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxK68Jo5t80+ESDLwXcU4WCMvJRwolI10Amqow/Cw4c=;
 b=LLyhDWrhCgDO74tTaYQ2BJ3XbHHVJnNuUXoHq7pU4gdevfucXLTLmXBeyQkVZzdGOoVoqN+4Vj5dO9+Aq2DfQFVBfP1+A96YAMDyo/E0n8rjUx5hUKPIPfnDy4rBB2QDy4saP+vf/z3UFjT5Qvh8xWGSJR6jZMPbGNf0X9wcR0Q1I9IDkXEzdehtzH+if82bFFy/UEGketFLIjyRlBpALVu4Xa+nvITitB0lypoAUpBCMdOjnZCbCYBSl2dSPwYU8T9A92O5+8dGvjT5LVCQnEtqGZ8LtYh0w6u6RJZ+5cAqwNgHNDT040TntnSiQvyjNnlL4kTjVsBK06aK28U7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxK68Jo5t80+ESDLwXcU4WCMvJRwolI10Amqow/Cw4c=;
 b=k8C9UlOVFfl1nvJaOKsCYA97nSK8yV7zkRf0nr+DzOvh4ktX0DsiJGFkOktrMfN9p62NKwGJez1SAPLrIe43ed/WedNO+5txguol4OGTYLESVJ2rOD9QxHWqIKoWmDF41Vr74cfMLfcpgOEpwy4b2xmYrrDw3mWOAJLGIZmfP+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4953.namprd12.prod.outlook.com (2603:10b6:610:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 16:31:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%4]) with mapi id 15.20.6134.028; Mon, 27 Feb 2023
 16:31:05 +0000
Message-ID: <e34f3127-f34b-2763-8ac2-503d0458cbf6@amd.com>
Date: Mon, 27 Feb 2023 11:31:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] drm/amdgpu: Synchronize after mapping into a compute
 VM
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230224233647.847647-1-Felix.Kuehling@amd.com>
 <20230224233647.847647-2-Felix.Kuehling@amd.com>
 <7c921833-884a-0034-7ede-6bd44fd40750@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <7c921833-884a-0034-7ede-6bd44fd40750@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::39) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: c552f005-f7d7-4397-c16b-08db18e005a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhZ0Lks51wQwXoRHVPvDYbmxCVjV51F8Oba+7u2zuhBStEDpDiYXK3xYL2xWpzMQrA9EHxmhKzlSspz3Op1zIEEwVQF+IYEbo1HW4sVBEyUyDh86S1GgKhPE4zJ4nDvo+F4hDSShNj9LH2gosQJCvgPR1R6dlFLfMEcdLqJWtsc0NsVS4s4rca5txQyb7DTdJ8bgpPrnsPdnF+t1+pSkZueFZgpmHBXQIQCSwnmZNmarIWOPX2Viqej4o9y7vg226ExinW4KARt0k+HB28By55D7qce35GIYBCcu1vI5gmUFMV9GYlOToifGo/n0NWs+wNfa61uf3WVkgkNy4VzxpiDk3ARJ575oyMFG80CFbKD8XxUP/9pcup7+o69b8lGIs/S7M3q7kkYm5grEbkt1486kUZhhQj0NG11/M/3ZspE99TOP+AJIfun7hcd9g1s0liZGKij6QyJemEMbjfgI/biWVeVrnjVLchH2+giLMj7mm1Uyv2JCChMPdjCMbp6x1SqY1KtMJlvc/cAciNUMXtLa3Zw2tIQ/yaiZ4eWG01+9Ip5j6/gAgBJtzZBeIPLj7A23ZYw8Ncoes2+BX2CAC+nIHtwW0QHVNbKkZQC7YX2nnA2Zb/SOlDn+2xuWrtoXKPyqRfvA1FNGpY/v7ompiIvtusN9NizfE/OpfwI8+8GnRob/WYcv5Vu1VaKk2dqeeB3C7hAHaMBBpjxFxL+ystBn5TeBG8+9/LUN/yKUlGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199018)(2906002)(31686004)(44832011)(5660300002)(8936002)(36756003)(36916002)(66946007)(41300700001)(66476007)(31696002)(86362001)(6486002)(4326008)(8676002)(66556008)(478600001)(6512007)(316002)(38100700002)(6506007)(53546011)(26005)(186003)(2616005)(6666004)(66574015)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVBjdUFYTXM1T3UvT1ZWTVo1aHE4QVhXb201OVo3NjhMRmJvOEkzQndOS0VW?=
 =?utf-8?B?WGtMeW85TTFjUVc5L3pJY0psSUVEcDlBdVFRRHoxWExXZHFTdEljc1grZTlN?=
 =?utf-8?B?VEkydmtzeFRVeGV0WDFjbEtyMW1LLzVjNWVYSjk3OVhCLzJnZEJlaDJ4VXY5?=
 =?utf-8?B?bjVmQnhDS1VRK08rdytEVVZKallIQkhJTTJQUUJUaDROVUVIQTE1bWFKWjRl?=
 =?utf-8?B?Ry8zNmIwaThkcnZBU2xwWG1aUE5idGM3U1IyZGwwSDE0NWViRU9SekVyWjJD?=
 =?utf-8?B?SGpGSE4xRlpScWEwSUtVcXZoN2tjM0FUTFQ3Rm5mRk1LenlRengzbzV2VmpL?=
 =?utf-8?B?OVpMNXFzS293cnJ5eGxzaERKU2FZbnNpRVJaV1JMOVNvYVFESkUwOFhEZFJz?=
 =?utf-8?B?UGRQY24zM1A0SXlTQmVMT0pMZHQ1NTRKY3YweFVaY3BxUStNenUwMFFCYW9z?=
 =?utf-8?B?Nm5xRmdleUhyTTNCeEpWbFpXSGVjcngxMWVLcUNCTVY1WWp2MUVaMU5naS9m?=
 =?utf-8?B?RXVCU0dQbzdwY2FaTlVQcWpqMjlxUHZTbU5LejRQdmVDMk1tMU9rdDNTTkFM?=
 =?utf-8?B?Z0J5Z3ZYb25keHVFSnNESXVRVDlEaXcyUjhkeHNwNEdESzl0MnlSd1l0dkxM?=
 =?utf-8?B?dG9YMllrWGN1eEhQbXVwWWFtWHRjWjF1TTc1OWo4Z3I3RVNGQkZ6L0kyT0to?=
 =?utf-8?B?dWc4dnl3bzN5akwxdmxMdXNWL0pMbEJCcGZGSWViTnhhbHovQjM2TFBRYkRz?=
 =?utf-8?B?UjFrcEZQRThQZnQ5bWdMQ0ZndnhPV1A3THdaVlk0cUtWb1ZCT3drQ1JhdHNE?=
 =?utf-8?B?ZkpaVU55TmlCdVJoYk5WV2h0ckNFbTBYUUZqY3JyMFJsOWxwdHlDdHJPSCtR?=
 =?utf-8?B?UkdKSjJIcTdta3Uwc3MyRFo3U0pjMjlDa3pJYStsbDlrZWtLcldEeVZYN05j?=
 =?utf-8?B?S01rSVJOWGtUK0NCVUs2dmNjUldmRU1JV1hxZHg0OXhmY3hoVTNXbVFvbkdY?=
 =?utf-8?B?bGFBNTdocFpCYjNCd3pIb3hvQWNrd2tWenpwUWR4UXNrTWZQQnhXM0x4NXdm?=
 =?utf-8?B?WnMzOEN1V2ZEa2tKbFVCcmo4aUIzMHZBU3ZnenAwbVYrTHJDbS9YYnNkbGdq?=
 =?utf-8?B?WnlENzZsYjY0K1gvbDd6U0JwY0ZzWHJEUUZxRWVIYTdKV2FWVzdGUFQyNjg1?=
 =?utf-8?B?bEkrVkFyL3BHSlRKSzg2Y1RkaFlmMFdER1U2VGE3VE1nRkswVWtnZVZUMTVJ?=
 =?utf-8?B?UUZDYkpDOUNVUkZyWkVXLzQzYlhCbUZCaHBNUHdzWm5LOUNjL0o4YVhHbmJE?=
 =?utf-8?B?akVybUZCSXNwL3JRVEk3RVhIYzJVS2FrT3ZxS01qeFZRNmtUc0ZGVVRweFJH?=
 =?utf-8?B?L2lxWDV4cTNJS0pld1hna3dWQTdnZEo3UkV6NEdRckYwV2YxMnNjRWwzMHBs?=
 =?utf-8?B?Sk83a1ZFK3l1Uk4vdWVqOEs5dnhwZ1RKeHloZXUxcHFGUEhrY0dQb25qb1ZG?=
 =?utf-8?B?N1hhckZYUzJjdUQySE9pc2JUQ0F5eEhiWjRBRWp1NEJwdWZ0ZmRFc2c1dFBp?=
 =?utf-8?B?dmdrUG9MdmJzREZXcm1tVWpTSVlHVi9sdHVHb1llZWh2ZHh4aTd6cml6YzI5?=
 =?utf-8?B?Ni9PaEVYVnZaK1NyNjE2NkYyTjZhSzd5WThMc0RQR3B6eDFFb2VTakNyNE4z?=
 =?utf-8?B?Vm1senE1dHlvQ29nbkRrWkJDTFZPTEJCY3Rod0JQSTh3b1llMEFxRGRoeGRP?=
 =?utf-8?B?TlZEN3kyQUVtd2NaSUNKbFpjT1Btb3Y4cDhTMFhaQ1ZHTWpnUnpuNUFDY3d4?=
 =?utf-8?B?WlgvcUtGZjkvVUl6UVR0UlVWanEzelROMnNyMVJFSzNJMndLT2krR2xxaVhm?=
 =?utf-8?B?VlRGaE5zTmFmQ3NKbk5XeUtrTUVuSzlzdklmcTRyRE1ZN1dDSVZlaG9yRkZN?=
 =?utf-8?B?RjZIc1c5Rml1blZrZDIvblF4aDZFUVlqUlBSUjB6M0ZPMmZYRUg0UXRkL1VL?=
 =?utf-8?B?RDVjb2pQS0J6ZUdzbDZleUNodStXYlJlR3RxQTBicFVDSDN0V0pSOStxQlVN?=
 =?utf-8?B?a2JwNHZBd3dWYTV2WDY0b0kwaWhNVDNKaFI2M1loOWpDOHI5aTNYdzRaQytv?=
 =?utf-8?Q?/AVGy0Q9q71DmIFxvEfuo0USc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c552f005-f7d7-4397-c16b-08db18e005a0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 16:31:05.0482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxASaJIRSz4E6Ric1nzE/FVXLE4mE/uo8Ou+3CNx2rJKHV/xh03RPZC7uhlzAmufLMmYoXSLMYJDgzX6zxL+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4953
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
Cc: ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-02-27 04:42, Christian König wrote:
> Am 25.02.23 um 00:36 schrieb Felix Kuehling:
>> Compute VMs use user mode queues for command submission. They cannot use
>> a CS ioctl to synchronize with pending PTE updates and flush TLBs. Do
>> this synchronization in amdgpu_gem_va_ioctl for compute VMs.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 6936cd63df42..7de5057c40ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -601,7 +601,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device 
>> *dev, void *data,
>>   static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>                       struct amdgpu_vm *vm,
>>                       struct amdgpu_bo_va *bo_va,
>> -                    uint32_t operation)
>> +                    uint32_t operation, uint32_t flags)
>>   {
>>       int r;
>>   @@ -620,6 +620,18 @@ static void amdgpu_gem_va_update_vm(struct 
>> amdgpu_device *adev,
>>       }
>>         r = amdgpu_vm_update_pdes(adev, vm, false);
>> +    if (r)
>> +        goto error;
>> +
>> +    if (vm->is_compute_context) {
>> +        if (bo_va->last_pt_update)
>> +            r = dma_fence_wait(bo_va->last_pt_update, true);
>> +        if (!r && vm->last_update)
>> +            r = dma_fence_wait(vm->last_update, true);
>> +        if (!r)
>> +            r = amdgpu_amdkfd_flush_tlb(adev, vm,
>> +                TLB_FLUSH_LEGACY);
>> +    }
>
> Mhm, that's not really something we can do here. The GEM VA IOCTL is 
> supposed to be async and never block.
>
> Can we do that on the KFD side in some IOCTL instead?

Not really. There is no existing KFD ioctl I would call after GEM_VA. 
The whole point was to use GEM ioctls to manages virtual address 
mappings for KFD and avoid adding more KFD ioctls that duplicate similar 
functionality.

If you wanted to tie it into the existing amdgpu memory manager, I guess 
we'd need a dummy command submission that does the synchronization and 
TLB flush and the wait for the fence from that.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>     error:
>>       if (r && r != -ERESTARTSYS)
>> @@ -789,7 +801,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, 
>> void *data,
>>       }
>>       if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && 
>> !amdgpu_vm_debug)
>>           amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>> -                    args->operation);
>> +                    args->operation, args->flags);
>>     error_backoff:
>>       ttm_eu_backoff_reservation(&ticket, &list);
>
