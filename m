Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041CFCC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 07:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60CE110FBD1;
	Wed, 14 Oct 2026 07:50:38 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A4510FBC2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 07:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBWWQ0Qnt2P4/MchpHt4zVicXwgzfaGicWUmE6QgIFCoAIH/nmBxHnuMyArTl4ik1hVqA1qvm7gqqm297d42Qvjeon7xTZoblNKHuffnhSwWrzpe2b3+leLiiWF7E0QcynZDcnyZBknCfX3u0fq1D2Y4/arEoCdbtRVadR5ObsZcTRxyb9hSsz1b7V6wRPKE7dr9hSWWuIJgD+20WN5b+bkL+3txjomUqwk7auEIl+wfGY0qFSOpzxskucluJGCiF9BX8XCcypAGvbS0EPHRzUCtL18MCKcZygcRWLqvjIsat5hQkd4oCUdM31osDrOjM3cv8agAWMDiXTD/4NTmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AubsQkTQLFNMrR8cUq7ZQRA+SPn8jrdyYefeg4zFDM=;
 b=KODOIhybwFEIhDL3FK6vggYWGvAyCSWSAskWCwrp6e5DDBNzW3APizMDM5VR5diTb+yzl4cEiOGekip4zpYJs0J+gdM3gWgnMS6L8DnUJ13068czNk/7ArOhf5HH8KFY99FsrGz3QBIvpCn4+wwAUYRfmi/x1NIusqMtFP49iuL3MADjtR+/iPw2Bt7psLlJ8ZzEUlPdBx+zjTe8HXAqjOeskmqq35qCHuZdJNFaL+mXut7beYo2Rztvv/7qYFdivRaG50KSOZRA13kunu0vL8G3kdSvX9dazfV+i4iPjGHj4axJL4wcoySMZu57tdgailVjDtBQ5VenoORKv7pbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AubsQkTQLFNMrR8cUq7ZQRA+SPn8jrdyYefeg4zFDM=;
 b=LhVDYxrDXqvLTFAlDE4BJpeIYGhhw4b24sL7EVvF5cfRPR/nl54tZlqGNftSUmWl0hlerSunfFlyZRSp60nbYFJDyBF/4WBCFqrFkumwHP2AEkkTvJIHjeD+ARLMplDZBqrrr873oaMpW/DgytH5W7dDCuMr8HmXpJBNdd1TKaw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 07:50:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 07:50:26 +0000
Message-ID: <0a7fcff1-95f1-4e48-bf42-974bbb2ee856@amd.com>
Date: Wed, 14 Oct 2026 09:50:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix TLB invalidation fence handling
To: Felix Kuehling <felix.kuehling@amd.com>, David.YatSin@amd.com,
 amd-gfx@lists.freedesktop.org, Sunil.Khatri@amd.com, natalie.vock@gmx.de,
 Bincy.Mani@amd.com
References: <20261008124232.23825-1-christian.koenig@amd.com>
 <c4a5cbd4-41b1-4c1f-ba9c-77e41e117383@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <c4a5cbd4-41b1-4c1f-ba9c-77e41e117383@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: d741a428-5fa6-41fe-aef5-08df29c7cf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|18002099003|10067099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: P7ejB1mdSrnDy2XJNpdRDS4powdotIRhVnHuGHbR/SuYEDwb2M5aVP1ZRtFWxBvfQzNDWxtO1ObCMAx/xgMrA+YDRZAm9IMrW0ArFp1ymnA633SpKlFOQjXtRaPZP2bb9+fMLSHrK4q0pIt6dq3zcwLb7udmEf08o/XVS+StyxDCiXwFMscgrKeAINiqfxWNECh40HU0o03uETiUHe8m+/v9DlERbuowTYbiH6pJirMITLNPgdxmvrf6vO+1qqyF2fpTKxYz0uG2AatdnN0A65UkN08x6flb9AJb1/rToCx8VDNVajvsylLAsyaLBRm9a+4tNzyq1536VxoRQqoH4Vu0WyphMS1EK0xN1U7xGfOLFWkkBBlmHAQrceHU9EJJEv8Gt8tEnVKJzypBhAeEY9H3RzRfWa/HhKB/YrcGQb+/XHyuPGI7jsMKis+gpeklchilTcixDjfllpEsoDcYKOET2gKml2c4XttfOXtg/YbzLQCGegHeY6vgj5dFI8Rj5nazMqEhf8/QnTyZhBltSsqINZ9dYmEW8loUQwIGRPSketKw6lVtM/8/NtRGsATtfi7XL+2z2bjgB6gO81Aq1Q5DN9Rh+IPgQREIUluMRjCqUOB7FezhFRD0LFPjpYptn54S9yEGEKb7GNekjNRglBPbD6pr8TUgy2EJHUYt/5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWpNVVc2RTRKVFoyODdpSldYSXJteGd3MWZJMjBRVFlVY2ZvRUp6bzFSRldu?=
 =?utf-8?B?VFJ3cjIwWGt2SU93YWVUQkVmeGh4MkFrOEdSbTR2MVV3Q2pLR1NpcWVoQkMz?=
 =?utf-8?B?b1NqYytuRDc2NzBJTFFMNnIyWXVnU3o5VjcvblFQQzJKd0ZySWw2SFJGOUtl?=
 =?utf-8?B?NXZUVWU0ODJrd3E4SFYvbUM0Ym9qelNhcVh2dkwxMTloWGRyQXByMUVWdUdU?=
 =?utf-8?B?TGxSLzd6RFJMSWJCZC85d2FvSlFDdGRVODd6WVVuNnR5YjBncVp3M1RwU1Y1?=
 =?utf-8?B?WWVJOWo4Q2tzUHFnTVoweHZhbnB4VjhQRVBHYnkvclVKVVFXKy9hV29tWlla?=
 =?utf-8?B?ajdEbi8vOGxjelBiV0NZV25aOE50d2g4Z0lPTjhaMkEvaUlyRmQrMkZZQ0pG?=
 =?utf-8?B?RlFPRjJQTm4yZkY1d05tNnhldGhFUTYydGhkR0VLOEVFa0RwcGVIb1VLb3Vy?=
 =?utf-8?B?WHg0OEZ1VmFQNWZZNDR4ZFBqNmVOTDlYOU9KdzdJSzV0a0kwbzRFT0pIU2oz?=
 =?utf-8?B?MXVUbGk1UTFLMUdVTnptZm5DMzcyTGg4TjVRNnFyMEVacldXY3gvbmZyYVZ6?=
 =?utf-8?B?RkNCZlpqTGlIWTdYR3BscS9UYjRDSkxhOFB6VzdJelhxSUkxazkwVW9IY1o0?=
 =?utf-8?B?a1UvNXhpYTk0NTZOTE5pQTh3WmpKOFFYSml3TzdkVnVEZU81MkZzNmtXSWdX?=
 =?utf-8?B?bm5yNlFCUHp2Q3A3aHZ1M0ViQ2N4ckh3R3dsREl5R3V4T2t4RWF2TFlQVGdW?=
 =?utf-8?B?ZWhQbTZSSHBMUzg1d3ZuUFdCd240RDlJMk50c2FiOUh0clN6U05RcndZYnZy?=
 =?utf-8?B?U2puRXVGQWVuRVc1WDRySmZsOEJoZ29jNlBSaS84SDFHY3hVazV4ZWYxWHpa?=
 =?utf-8?B?Ti9MTnlIZjYvaXJzTS9DYmRiS2tsS0xvWWdFM25SUWlFcFl5Uk83RDd2OHJC?=
 =?utf-8?B?MzNpY2tPaDZuOXF1RmJWV2paby9sQVBaSmM2MmxUbVRKOTBSTm1MTDl2ZTR2?=
 =?utf-8?B?TjdwYS9uWHRQVGlOZGtGVHVLZ1gxTWxpamdqN0QzRUpwajd4akhRallVcmNm?=
 =?utf-8?B?RmNvQ0tWN3JnSktoWDI1TzgyOEE1bDc5K1kwUXIwWU4yY2xlbFJXcSs2bm1Y?=
 =?utf-8?B?U3V3TnM0cFRVS3M0OG10aGpyT1J6R2NGS0tKaTVLWWVlc2ZTUkoza1NMdzl4?=
 =?utf-8?B?RitaUjhPLzZ6M3FTM3RVa0FZUUk1eWZMUCtTbk5WajdaUEFCbjdXYUMyQ1ND?=
 =?utf-8?B?SVpIMG9jVFk4VE5WbkljbWVNNEk5WWZsOUFvRENQd3dLOHpsL1JZM01jVWwy?=
 =?utf-8?B?RkkwRUxZeHJkZzNiQU1SamRBU3poTFdod2tZUWJEd0pHT21tM3hFem5SeGxj?=
 =?utf-8?B?UG0yUnhOREtsbEFGSVp0V0R0eVRaYmdLbnJtVTlsMFNXb2dFUkdUL3FuUFhL?=
 =?utf-8?B?U1N5R0FNVURwTzl2VXZwbWdpTFo1MnhkemFjYXh4UnRucThodlpjdTlSQnhl?=
 =?utf-8?B?cXBITEI3UlZCWmRBc3ZFdy95VEg5dWpxdkFsS1VWYURtMUVnY01zV2xEQ3B3?=
 =?utf-8?B?eDdFY01OVGs1Y29nRkdWY3RtekdvdFJPM2IvaGJNSVVJRisyUjYvMEpQUUJC?=
 =?utf-8?B?aGlNZGJZQTJ3U3FmSWRiMmcvMDg5aWdhY2ZqKzFNelVVNi9kekhjYnYzTWt4?=
 =?utf-8?B?dm1mcjY3b2lBbE94MkpaSmNXZFlCTVJUWTdhMDRLSlQzUnNQNVA1NHhJMXpH?=
 =?utf-8?B?WXVqK3NyakFMS01WcnFXV1VkUHcyV1BQemY2VGl1MmhTWjlDM3pXaWUyb25x?=
 =?utf-8?B?ZzVPblJHVDBpeFQzb05zTWhKZWxkRTU4N1dOQUhUQnR4TTV6c1dtUEFFWTFD?=
 =?utf-8?B?SEVNVFBjMDRsT1JpL2FvSll1bFIvQ2ZHNEVrekpWV3RPNjUvRktnNGpsRDRN?=
 =?utf-8?B?UUsvcTEvYlV5VkR4dGNrVkpDNnRFeGNqZlVzWWNpaS96RURQME1sQTFYeFYw?=
 =?utf-8?B?NjBHejAzMXZ4MFY5V1ZZNlZEbDRTWUhkbDA1c2pocERtWjAzVHdma3R4V2lt?=
 =?utf-8?B?Nm8vWTNReGVrRHVZb3dSL3NOQjBkeDN1WlBrcVF6RytNVitiMlljbUlQYWZn?=
 =?utf-8?B?ZVJJVEpFc1ZpSTgrNVR0SDA0ZWZFWEhKU3NLL1prQWx2cXYreUZXV2hXSTZu?=
 =?utf-8?B?a1FCMUhRY3U0MkRjSy9DOExOV20rdklWKzQzUHhJMEdzNWdYU1JhblZyNGx4?=
 =?utf-8?B?NXZoREx6d1E1ZnkzNDZGN1NoRXhXbUZ6NkNWYW5FVTNtS2FRWUhpVUxoQ0kx?=
 =?utf-8?Q?O77jqXkzpnNYelulsj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d741a428-5fa6-41fe-aef5-08df29c7cf14
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:50:26.4250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7/3UiF9jCPude+c4Dav1TGSlnDueIWRHvHIrmt6ouBXafmoU6SP/Srb4I1SSf3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467
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

On 10/9/26 23:23, Felix Kuehling wrote:
> On 2026-10-08 08:42, Christian König wrote:
>> After each unmap it might be necessary to invalidate the TLB to flush out
>> VM changes to the HW and make it visible to executing work.
>>
>> We tracked that as part of the vm->last_update fence, but as pointed out
>> by David it can be that this is overwritten by PDE updates when we have a
>> combined unmap/map operation.
>>
>> In that case userspace doesn't correctly wait for the TLB invalidation to
>> finish leading to all kind of problems (sq_int, page faults etc...).
> 
> If I understand it correctly, you fixed this by tracking two different fences in amdgpu_vm: one that updates the sequence number, and one that signals when the TLB flush completes.
> 
> 
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> 
> Why was cursoragent@cursor.com copied on this email?

It was CCed on Davids original mail as well.

Regards,
Christian.

> Anyway, the patch looks good to me.
> 
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> 
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 20 ++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 39 +++++++++----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 13 ++++---
>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 21 +++++++---
>>   4 files changed, 55 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 374f1322c3ee4..606725d0eb155 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -843,18 +843,24 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>           /*
>>            * For MAP/REPLACE of non per-VM BOs we need to sync to both the
>>            * bo_va->last_pt_update and vm->last_update or otherwise we
>> -         * potentially miss the PDE updates.
>> +         * potentially miss the PDE updates or TLB invalidation.
>>            */
>>           fence = dma_fence_unwrap_merge(vm->last_update,
>> +                           vm->last_tlb_inv,
>>                              bo_va->last_pt_update);
>> -        if (!fence) {
>> -            /* As fallback in OOM situations */
>> -            dma_fence_wait(vm->last_update, false);
>> +        if (!fence)
>>               dma_fence_wait(bo_va->last_pt_update, false);
>> -            fence = dma_fence_get_stub();
>> -        }
>> +
>>       } else {
>> -        fence = dma_fence_get(vm->last_update);
>> +        fence = dma_fence_unwrap_merge(vm->last_update,
>> +                           vm->last_tlb_inv);
>> +    }
>> +
>> +    if (!fence) {
>> +        /* As fallback in OOM situations */
>> +        dma_fence_wait(vm->last_update, false);
>> +        dma_fence_wait(vm->last_tlb_inv, false);
>> +        fence = dma_fence_get_stub();
>>       }
>>         return fence;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 7d3659ef11e53..f124320345ec4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1071,21 +1071,16 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>>    */
>>   static void
>>   amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>> -            struct dma_fence **fence,
>> +            struct dma_fence *fence,
>>               struct amdgpu_vm_tlb_seq_struct *tlb_cb)
>>   {
>>       struct amdgpu_vm *vm = params->vm;
>>         tlb_cb->vm = vm;
>> -    if (!fence || !*fence) {
>> -        amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>> -        return;
>> -    }
>> -
>> -    if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
>> -                    amdgpu_vm_tlb_seq_cb)) {
>> -        dma_fence_put(vm->last_tlb_flush);
>> -        vm->last_tlb_flush = dma_fence_get(*fence);
>> +    if (!fence || !dma_fence_add_callback(fence, &tlb_cb->cb,
>> +                          amdgpu_vm_tlb_seq_cb)) {
>> +        dma_fence_put(vm->last_seq_flush);
>> +        vm->last_seq_flush = dma_fence_get(fence);
>>       } else {
>>           amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>>       }
>> @@ -1095,11 +1090,12 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>        * sort out the issues with KIQ/MES TLB invalidation timeouts.
>>        */
>>       if (!params->unlocked && vm->need_tlb_fence) {
>> -        amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>> +        amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
>> +                       &vm->last_tlb_inv);
>>             /* Makes sure no PD/PT is freed before the flush */
>> -        dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>> -                   DMA_RESV_USAGE_BOOKKEEP);
>> +        dma_resv_add_fence(vm->root.bo->tbo.base.resv,
>> +                   vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
>>       }
>>   }
>>   @@ -1248,7 +1244,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>           goto error_free;
>>         if (params.needs_flush) {
>> -        amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
>> +        amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
>>           tlb_cb = NULL;
>>       }
>>   @@ -2647,7 +2643,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>         vm->last_update = dma_fence_get_stub();
>>       vm->last_unlocked = dma_fence_get_stub();
>> -    vm->last_tlb_flush = dma_fence_get_stub();
>> +    vm->last_seq_flush = dma_fence_get_stub();
>> +    vm->last_tlb_inv = dma_fence_get_stub();
>>       vm->generation = amdgpu_vm_generation(adev, NULL);
>>         mutex_init(&vm->eviction_lock);
>> @@ -2691,7 +2688,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>     error_free_delayed:
>>       dma_fence_put(vm->last_update);
>> -    dma_fence_put(vm->last_tlb_flush);
>> +    dma_fence_put(vm->last_seq_flush);
>> +    dma_fence_put(vm->last_tlb_inv);
>>       dma_fence_put(vm->last_unlocked);
>>       ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
>>       amdgpu_vm_fini_entities(vm);
>> @@ -2834,11 +2832,12 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>       amdgpu_bo_reserve(root, true);
>>       dma_fence_wait(vm->last_unlocked, false);
>>       dma_fence_put(vm->last_unlocked);
>> -    dma_fence_wait(vm->last_tlb_flush, false);
>> +    dma_fence_wait(vm->last_seq_flush, false);
>>       /* Make sure that all fence callbacks have completed */
>> -    dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
>> -    dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);
>> -    dma_fence_put(vm->last_tlb_flush);
>> +    dma_fence_lock_irqsave(vm->last_seq_flush, flags);
>> +    dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
>> +    dma_fence_put(vm->last_seq_flush);
>> +    dma_fence_put(vm->last_tlb_inv);
>>         list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>>           if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 8e478d3bda1ac..713a597027bbe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -328,11 +328,12 @@ struct amdgpu_vm {
>>       struct drm_sched_entity    immediate;
>>       struct drm_sched_entity    delayed;
>>   -    /* Last finished delayed update */
>> +    /* Last TLB seq/fence */
>>       atomic64_t        tlb_seq;
>> -    struct dma_fence    *last_tlb_flush;
>> +    struct dma_fence    *last_seq_flush;
>>       atomic64_t        kfd_last_flushed_seq;
>>       uint64_t        tlb_fence_context;
>> +    struct dma_fence    *last_tlb_inv;
>>         /* How many times we had to re-generate the page tables */
>>       uint64_t        generation;
>> @@ -561,7 +562,7 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>>        * sure that the dma_fence structure isn't freed up.
>>        */
>>       rcu_read_lock();
>> -    lock = dma_fence_spinlock(vm->last_tlb_flush);
>> +    lock = dma_fence_spinlock(vm->last_seq_flush);
>>       rcu_read_unlock();
>>         spin_lock_irqsave(lock, flags);
>> @@ -576,9 +577,9 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>>                     uint32_t status,
>>                     unsigned int vmhub);
>>   void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>> -                 struct amdgpu_vm *vm,
>> -                 struct dma_fence **fence);
>> -
>> +                struct amdgpu_vm *vm,
>> +                struct dma_fence *dep,
>> +                struct dma_fence **fence);
>>   void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
>>                      struct amdgpu_task_info *task_info);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> index b0002c8983861..c91417e4df4ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> @@ -75,7 +75,19 @@ static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>>       .get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>>   };
>>   -void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +/**
>> + * amdgpu_vm_tlb_fence_create - create a TLB invalidation fence
>> + * @adev: the amdgpu device
>> + * @vm: the vm to use
>> + * @dep: the dependency to wait for
>> + * @fence: the resulting fence
>> + *
>> + * Creates a TLB invalidation fence which signals when all the VMIDs assigned to
>> + * the PASID of the VM are invalidated.
>> + */
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>> +                struct amdgpu_vm *vm,
>> +                struct dma_fence *dep,
>>                   struct dma_fence **fence)
>>   {
>>       struct amdgpu_tlb_fence *f;
>> @@ -86,16 +98,15 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>>            * We can't fail since the PDEs and PTEs are already updated, so
>>            * just block for the dependency and execute the TLB flush
>>            */
>> -        if (*fence)
>> -            dma_fence_wait(*fence, false);
>> +        if (dep)
>> +            dma_fence_wait(dep, false);
>>             amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>> -        *fence = dma_fence_get_stub();
>>           return;
>>       }
>>         f->adev = adev;
>> -    f->dependency = *fence;
>> +    f->dependency = dma_fence_get(dep);
>>       f->pasid = vm->pasid;
>>       INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>>       spin_lock_init(&f->lock);

