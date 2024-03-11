Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4CAC5475B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 15:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEB8112B19;
	Mon, 11 Mar 2024 15:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o0ONRoOA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185E0112B1A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 15:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e09BU/RkNnqK1tyF9txN0lsM+W7UxGGHMqXP3YEWqL5RcWb8fPMZ4g186710XXxV55a0MLYO/oiA9eNVtatDMuIPH5SKdyWAwyek0tw7TSyH5PK8CzOqev9acXjxFnwICxbsnycuY9AVOTHF2k3jeLjn8xXQRCLuqzBoJmXDUdjGqRNJHugkfco5+VQj62Ln6j0gJX9edPmHl+hEUi9OPsPdgcwFt00USSJ/toi3twZc8wwT6Uk+a5s9DhCkqkzeEOIpvziOftmml1PIIIODN2TEE32z3kXcrdR659uZ/Wp8F8PaigVur3wygec5lIJdX01pc2PDcIQyjpibDq3OJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTDqMWsCHGvBeAgwDy47V+warDmpVOnkZaz42Qbl+0s=;
 b=dXGwVfswLRMNNnTWRTkxf2xkgw87DRIVaVfd3yDYpj5uXrPa21q8fknD6eAEvfxGSskr0+rMhUd0zhqEbXWUoqU7ShxqHpN/Mxn924I48XTOf6GxDK31te9n8Yb3jlNmxCSWUrLM/8o0/l3DZABb/E40GN+Y/cl9e3d/ka7fKXoHp1tdgjFh2a0Tyuna2Iaq0Hg+uBuVw0wPgMJRXMrsTQWWbvCdj3TI7bCbi3pKAekjzoEIKxtu/tbEBIF6UvDL2vMJ/SIvhRdJhLFv4zJ8wbDTZSOVc4Ex9aXkfyvpHRDdI3cDF7mQpH8ULi8NzzGXNCi/t0cguGTuJx4tiFjLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTDqMWsCHGvBeAgwDy47V+warDmpVOnkZaz42Qbl+0s=;
 b=o0ONRoOACdBJ6+zn7bKo07UkiaNF5UfcIChcuCM/lxXfbnAyXxJVHI0exAN7zYOdCYDy70oBT09O5+1/PQVYjZjScuzT3vkfmlZy+3QKb51BO1+V3YjlCPpB4wnTkPQ2y16VIcWmhDj663ZCxbvvwj14j3UUclVL2Y+vfat8kyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 15:33:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:33:16 +0000
Message-ID: <08c51a55-a1e9-43e6-82e9-537424c0bfb5@amd.com>
Date: Mon, 11 Mar 2024 11:33:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240308162253.264154-1-mukul.joshi@amd.com>
 <4098f759-dc58-422d-b000-af8126775966@gmail.com>
 <BL3PR12MB6425EFDC27818399BA85C1E2EE242@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <BL3PR12MB6425EFDC27818399BA85C1E2EE242@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb6f96f-19cb-4bc3-ed71-08dc41e0927a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHIgnlm32wtjObUAH7nFUxVXC676I/kP/+RKEIhoZuFJccaH+sJ5+P7wc4rN+hZMayqDbtf/kGCIDz+0DGrJU3UTNZeGAYmCDfonQQw444FWHD82HWzwk1LNj8bS5sIU+LmyYuKz3fRCy6bMXuNlgZUIIH3KMXWHIw8PnG7D9uIbfF478914jpdMhNN7EfWeGvvq2YYwcQpX93bY5+L6qzqbx+J2pbF6W02a2pbRuP9LbKxIRuim2lbbbdJpQAAOO8S9s4PkihZqZS0K3O+pHjEmm6+93tn7iOxTeUtdX9v+i077Y1dUiuh5fkRuqI71Vopr6onjbsMX2lqdrG4BDWsnbNv91xcrvooGKDqadKGcwKw5arYKgYjhFkdj8pEcygpqg7FP7fl1QVIlzRy5hI5nxYLPh8uZrWqwuppnisSFnce0q05WJ+i4rgh5FQVWY/q13I8CJbNJke8dqgdnQ6juf1DXyVf7U8I426k+JSve2QWqSTbrZrDaa6/EBMgDGHinFpoeNbsUjT8pfSZgGmjfmJ0tChDJDdlw2S8RhleqHBZhy1G3aqd8lllWbSPenvv4NK7bauq9w2PYHyqC1Wg4Pi+V+Db7zQjqJ+0GIXUPUgAb771OPkG3Uwu1yHTBs/7LzgKZS+wkFXF5pAU8JJ28SMcx9UIO3QlK6KGaw3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NnNHBOaHlWc3oxWFdGT3NEbjZGMEEvNUNIaUNNeGdvbjY2b0kwa2laSXF1?=
 =?utf-8?B?R253ZjdqU0dZUDV5dHdYUVNsMi9CcG9oR0VOODFoMTNJWTFsakhXd21uL1Zp?=
 =?utf-8?B?MktpT3NKVWhUVHBLWEU0dStka2dmN21VRVY2N2Y3TjhmbmpEN2dFNk5SdDFC?=
 =?utf-8?B?L0F1azhPMlFzWmdTbXJwRnRXWDhsUTdDd1NPaHMwdktEUUxoMko2cEJaZHBC?=
 =?utf-8?B?b2xwb21NVHB5UmFNb3p2a3lZWmYra2paQ3VxTFdVdGhBOStUTCs4UmpyQ1M4?=
 =?utf-8?B?MUNPS1FNeVBESU1UNjl2dUtvVnVueE5jcXBPMEtRZlNBS0hOSG9HWi9rdFpv?=
 =?utf-8?B?WmxxVlRFR0FtSXNqVFRvWU9Yd2tKczV3eEhmQndtR00xNXJxdVcyaDM3UUcw?=
 =?utf-8?B?TUpMcjBkNDJ1cTNjSmx3cUU1MGtSQ29rdWU5VkRnYVRyWWErZFBKOW9RT1Ay?=
 =?utf-8?B?ZEV0d2xwckE1VUQvOUtDbFBNT2FVVnIzRkpYSlJoMzh4c0xJOWx3QjhyWktR?=
 =?utf-8?B?bFNJa2Rnd0NHTFYrV0x5cjZOTERmYnc3MDBCM2RpY1NXVS9wUndmcWlheUwz?=
 =?utf-8?B?Y1I4TTJ0VTZDV2x2VFhLUFk1bytmRHFKYkhFU3o4SlMzZjRBeXhkWUFqZjFt?=
 =?utf-8?B?enBVMXVhS3VUaHMzb0VBK0diVXlrR3F6TUZ2UzBNZGRMQm5NT2ViWHJMMExQ?=
 =?utf-8?B?d3lGbnZmMGh5MTROU29PK0VvVXZqZmhJOUE5dDlJbVVVaG9mMVR0NFZ5ZlJZ?=
 =?utf-8?B?Y2hwMmJiMm5Md0FmRXplODFISzhRdWdnYmMyVXFTc1FnZDU0NjQxbGVSbWRp?=
 =?utf-8?B?SkZMRnJHZFZFRGhyL1FzUzNQL3FkOGtqV1phbTB2SE1valRtMk55RDg5VU56?=
 =?utf-8?B?Z01KSW45T3B5bXAzQjlFOUpTVkhmMy9FMERwQm9rZE1FOVN2OFVudHpGMGFJ?=
 =?utf-8?B?T0N4UDlEbEd4NS9yTnJia1VQV3BNeS93NVhQOUJQNnRIYUk0MkNZM1RjWFBk?=
 =?utf-8?B?MWdHMHdWNUl0U0xpZ1Jta0RDNFNWRFJhYkJNVnE5Y0FRYU1xcXBVUUhZZlIy?=
 =?utf-8?B?WFFaRzlydUxzSjE4QlJoclJpWlRYSG8xUHBqZWkraXhZNUpZb3ZENHdhWVpD?=
 =?utf-8?B?QVI3N3Z0TTRKc2U1akRFUWpBRWZHTFgrOFJ0OUhaY0NDb2tHbFFoaHpkbkxW?=
 =?utf-8?B?Mk53L3V0VFVGRHYzM2FSZG5ETHhGay8vdG1DQm9rMlptQi9CY1IyOHliQUhm?=
 =?utf-8?B?YnhsM0RyRnA2QzQrcDkyblJsVUl5UDhrNUNIVkVJZXRqc1FnUHNCeG0wMEp1?=
 =?utf-8?B?bXEwM21PMC94YnFGVkRxQm9ScjJRWlEvdzRLVWllc1Zvbi9LS29qU3JhTUl5?=
 =?utf-8?B?Y0tRYlhxWDhzOGxIQWRaM3VkemR6ZGZKRTdQWGZnOVZudDh2V1Z3Y2t1ak1v?=
 =?utf-8?B?UzZhRTNpdlFrSGVQeXNmdXY2cFFLMUw1Rlh4UFIvQld0dnJBdGRsOWV3aHls?=
 =?utf-8?B?MjdoOUxQU1dCRWdpaFlmMzFCQnVwRHhkdmliSXh5UW5BQWRmZ3NpMkVjOTZt?=
 =?utf-8?B?YXk3SitTdmhBd3ovUGd5UTVHWStYYUd4cUk3bXF5QzhEZ0ZQZ2lOVDlyRVJU?=
 =?utf-8?B?U0FlWjFBTE9KQjNxMzZna3JNWE4zK0lneTJNb1ZWS1JBcW15cDVzWjREbmMx?=
 =?utf-8?B?UlZnc0R2Z2pCd2ZyU0FEUTN5cFdvdTNjRVAwTE81eWRFY0F4SVdWOS9jcUtX?=
 =?utf-8?B?Sk4rdWRGS0FzRHR1WDEzcTFCSXQwaUt0NXFIUkVIQUlFc1lnQnRIc0NCSXdh?=
 =?utf-8?B?RU9XMy9SZjVTTmdoOUtLZlA2dmdRZVRUa0RpVDVydXRmVVpPa3hzaGpZSWZx?=
 =?utf-8?B?RWVsbVZoZ0pQUmdBTzF1Mk80Wndmbit5ZzNZdzRaaHBnWCtsais0dHJWOFRK?=
 =?utf-8?B?MUZDQkhFZ3hsNTYwejM4Wms4SjRYVHp0M1d4S1krMFI3bVNERXVodzU0d1M4?=
 =?utf-8?B?TUpkNEcwWUY1MWtGM3RJN21MUFpPTnFZYng4SEQyT2lsdVVoZ2grOGM1ZFpx?=
 =?utf-8?B?aXFvNjJQTHJteElEcExmSG92MjFRTEJFNGRMa3JvR0NhbE5ZeHY3bURtMGJ2?=
 =?utf-8?Q?A8Flxv3yVan4lTON+yP6+f0NS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb6f96f-19cb-4bc3-ed71-08dc41e0927a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 15:33:16.7086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09aIMio+0nRjogV/HtybqZBNiRCoyGD8CDxQdPp3Hz/XQKZhpdAak69XGlrUWuPU07wRKttvFEwOTZhcbF5wGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
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

On 2024-03-11 11:25, Joshi, Mukul wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Monday, March 11, 2024 2:50 AM
>> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Handle duplicate BOs during process
>> restore
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> Am 08.03.24 um 17:22 schrieb Mukul Joshi:
>>> In certain situations, some apps can import a BO multiple times
>>> (through IPC for example). To restore such processes successfully, we
>>> need to tell drm to ignore duplicate BOs.
>>> While at it, also add additional logging to prevent silent failures
>>> when process restore fails.
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14
>> ++++++++++----
>>>    1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index bf8e6653341f..65d808d8b5da 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -2869,14 +2869,16 @@ int
>>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>>> __rcu *
>>>
>>>        mutex_lock(&process_info->lock);
>>>
>>> -     drm_exec_init(&exec, 0);
>>> +     drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES);
>>>        drm_exec_until_all_locked(&exec) {
>>>                list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>>                                    vm_list_node) {
>>>                        ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
>>>                        drm_exec_retry_on_contention(&exec);
>>> -                     if (unlikely(ret))
>>> +                     if (unlikely(ret)) {
>>> +                             pr_err("Locking VM PD failed, ret:
>>> + %d\n", ret);
>>>                                goto ttm_reserve_fail;
>>> +                     }
>> That's a bad idea. Locking can always be interrupted and that would print an
>> error here.
>>
> Thanks Christian. Will send out a patch to change it to pr_debug.

We cannot get interrupted here because we're in a worker thread. We 
should be running in non-interruptible mode.

Regards,
   Felix


>
> Regards,
> Mukul
>
>> Regards,
>> Christian.
>>
>>>                }
>>>
>>>                /* Reserve all BOs and page tables/directory. Add all
>>> BOs from @@ -2889,8 +2891,10 @@ int
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>> __rcu *
>>>                        gobj = &mem->bo->tbo.base;
>>>                        ret = drm_exec_prepare_obj(&exec, gobj, 1);
>>>                        drm_exec_retry_on_contention(&exec);
>>> -                     if (unlikely(ret))
>>> +                     if (unlikely(ret)) {
>>> +                             pr_err("drm_exec_prepare_obj failed,
>>> + ret: %d\n", ret);
>>>                                goto ttm_reserve_fail;
>>> +                     }
>>>                }
>>>        }
>>>
>>> @@ -2950,8 +2954,10 @@ int
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>> __rcu *
>>>         * validations above would invalidate DMABuf imports again.
>>>         */
>>>        ret = process_validate_vms(process_info, &exec.ticket);
>>> -     if (ret)
>>> +     if (ret) {
>>> +             pr_err("Validating VMs failed, ret: %d\n", ret);
>>>                goto validate_map_fail;
>>> +     }
>>>
>>>        /* Update mappings not managed by KFD */
>>>        list_for_each_entry(peer_vm, &process_info->vm_list_head,
