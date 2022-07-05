Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E42C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 17:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D3610E1D1;
	Tue,  5 Jul 2022 17:44:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A007790C4A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 17:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYUXoHO4t6dngB5RSFhAOyyojwMWVT1AtcFH35fDq0IrRbqV8qmLy0CUIqpuT7RU9u8qeyO0EkOaFH1BL953uCEy58I2Cj6C9bra6tR/5vm2TYa4M6IAQVUmblyy3LRQzMz0Hwj4vlrtELVjHDiC9GvkHAvj00/qXtGqLrcwFAIsGtgbwvASJvyX/WVgspzEyWy9ZpHohGetHrgFt+s0/JXZZA3p5Sn78/90vKQOuso0JDV07rifoqtsotaL3/cgji0QBa9uaZpi9pswr/TMRIpDLtMCQZWwghXKSfytInMg2wPqI05GBGgWTs8FoFyCGxSNMIkBahe0ni3J/CG3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06+RJ9R6zZggAVQewILh0QxOEQBVnOFJdS/aTp9SXCg=;
 b=Ds/kEqxjmTCvDzBW8ZFoar1WB6Nfd/sN3jeWYkiCsFPL13VYF2IypV1SS3BpRvWY4KgvJ2Be+sPmcMe00Lky9yg0YBU/X0VS+1oQSIbPXFFRuJRKFil/bkH73H1oSG5a5dLRYUpN8T31py0qHo5ivIz1zD45+n7Ev7MG44OTGRffnGbFkivwsMUa9t6xC33uKah5lNd+4Xj0ZhrJhBololT83W7JO91r0REwkjDU4HGiFOfwsxVUldepeL5CmEG246OHf4PGcVOVESm1Bc1id7bqs4B62dZcdoIC2TWdHu0vTjk9DOuTIvT7YmzpuVc4fEvfgGgGgY7dY/os09hATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06+RJ9R6zZggAVQewILh0QxOEQBVnOFJdS/aTp9SXCg=;
 b=M3gj52nUhpO3EzIqb8w4H2JxMYX6iUemPhzRu5WGJgozlrJY4LN9leIJneMmn07jK7hs0pA9F23Ri2eIbJe+4FnQXG96lakK3W22c1Vrxr/4tWByqpSvb4XAGP8ki9tQ0RVez82idTDT+/mJTtghyc5aXjdmqkZE626T/RCLORc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 17:44:40 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::2d9d:f26a:77a4:c19]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::2d9d:f26a:77a4:c19%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 17:44:39 +0000
Message-ID: <e5eb8962-df0e-093a-9b30-6ba7b6da245d@amd.com>
Date: Tue, 5 Jul 2022 13:44:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: philip yang <yangp@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220628002347.3982-1-alex.sierra@amd.com>
 <20220628002347.3982-2-alex.sierra@amd.com>
 <cdcf6a70-c553-49fd-320e-7b3b178337f5@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <cdcf6a70-c553-49fd-320e-7b3b178337f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:610:11a::20) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e94d221-b95b-4158-3910-08da5eae0909
X-MS-TrafficTypeDiagnostic: DS7PR12MB5959:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgHfZKMpwnXVmQ4k0BTPk4LAYjtGfwaeZtr5KBNbagT0jP+CxDD1joPc+zeXE9wFTV5OSvWAj1et4BCp0uRxdc1J/7uOApFq1K/jUCmF+oKt07j4QaFynr4WkWUaZ1T0bhvFyi03clwwy+fWPiE1HIqCcmhcv0KJIamM3Ayp8p3Q/aV8/DmIzwoZaVN0S1ev6vWBeWbPfE3HsYU1IJp3jaMdkFjta/AZ/UgB4X1V3Lx5lW6ThUht1JakOwuB6Yd82cPUCScFwNm6lATM6hZhPpaGL8uUPDdYVk9/ceCOjCml/MzctoBMTDCS/UPnLzQvTuxqNFaHbXpvnpNjeDgyZC2TjKso7I9Tr9VXS5HPEMEG8qMXhnfQPPOpuaCnXqiU7FxYOseyV5ZRpmZEla87TCXdmKdE6ALg3NPjK+cPUPYXzSImLsPqDNDODyqCN1t7eBMiDUo9Aep9e8yf2s66hg503tFFv4c/6WPYy+iJeCLvHD7UItMd4q7SF2/MZly+H/rlboB1NAAA1qUshmP4+gHLlo5Lh9NsFkBVPw03F0sqSL9K/8lqr1px5A6z3nYvG3to95LGS5uOh1JaLgKjHLbmI5vHCmLeBW9Gt74q3NfCcbaSZl4H0z7IrwQVcPiEPLjzSJr1Xih+zqQ/jWicIjjE1G52I5tR8q916mYNJciRnAu6UWNxa3cBSIdS6ptKR7QYgdT4UhVAvoaRo604a9AtMYKuKr45/I3i8BR+0P1c1gR9oKHggOLfR0VcSgDcQsUKz4lnZlrV1RrPA6Y4JcLvdseI69XUVoUNWzDd6v3cuOnAa/RVpkkp8YVXgyLVzypHzHV68pCtwvoGUuNVE7i8U3sRPOqHP8LQjZq4WBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(38100700002)(66556008)(8676002)(66476007)(66946007)(316002)(86362001)(31696002)(110136005)(2616005)(31686004)(6486002)(41300700001)(2906002)(478600001)(36916002)(8936002)(6506007)(44832011)(30864003)(186003)(53546011)(26005)(83380400001)(5660300002)(6512007)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRiWDRhUUtSalA2WWM2czNTNTJhbXdEQUkzdXFRcmc3Z0ZZb1A1aC8rR0M5?=
 =?utf-8?B?NFBRa3JlVUR5VUxwRzVSNVh4M21jazdIelZ5VTNHWndzVHdMZzlpSHN1dVZF?=
 =?utf-8?B?R3dxb0tUU0ExYUdGMERaRkJMeEd5OUVJRlM1MnBndGRBT09KbWxwY0NVMjNN?=
 =?utf-8?B?TkMrQlFqUHRuMTl6QnpNWlJGYXVHZ1QzWWZzTHRUQlRMQ0JvU2NCR3M4WkVF?=
 =?utf-8?B?SWNURnlPZm1hWUhhY3ZNMGZWZWJqa1B1TWVBQ3JqcWF2a2xpSGh2WlJ1MHk1?=
 =?utf-8?B?VGxnd0JlUFY1blFETW42aGxQNERySS9scU84ckR1dk96aHdGT1hKMFVUSmJq?=
 =?utf-8?B?dzNpY0RkSjlJTnhoZCtLN1dnS3NnVnBJRnFXYURMNUtvR2swL003Yi94bFlm?=
 =?utf-8?B?Q1lyaDBja252Rkowa2lLK0xRaVZCeGJSWXZqRzlkbElxdGl0RmJKK01OTXN5?=
 =?utf-8?B?T29hcXVhKzBTVmZmeE5CM0RFbktxaEUrUHpXOWdDRU5OaStzWU01dkxQV2Zy?=
 =?utf-8?B?OEJrM21MUDVER2Fodm9rRGZqeVJoMWk4UjhLYkloYjI5TEtIZ1NzUENhSnBU?=
 =?utf-8?B?VWFsaXhSYTZFTUJRTjdPRmxRS3pWWGlUazJpMUpmaUMvYlU3QjVDTkEreDc0?=
 =?utf-8?B?eW1aWVZXMGI2SWpMcE8zRUp1WXNTZ1FCQkFXSVFwOU5BRGtjVUM2MEdab3VV?=
 =?utf-8?B?VytOSUN4UzBJcDNXa1FMVXFaa3JDSG03THhrTkFTN2VvVk9rTkZNZEFhWkVF?=
 =?utf-8?B?NG5UZ01kejhhYVNxb0lKa3NjVm14UFFoLzdCZUxrY2JNUjJsTkRLSlhHaENw?=
 =?utf-8?B?OWUyZG9yczB2TnpUTXBFQ3g1UkNndmJsVEk1TzFOU0pNUWtWVS92SFk3bUVj?=
 =?utf-8?B?RE1udklIN1BRZk8xSEpPTlVtUlBwRkNKVWJqQmpkdXFmOEpWUitYL21ISERi?=
 =?utf-8?B?V1ZtblJickRiajI4QktWN3FtcThkcHdFaGJaZGpyb093anU0OHd0VThJOUhR?=
 =?utf-8?B?c2hFbkJtVk9hSnhFZ0dIZW9XanFFekdlaVMwWEpPazE4N1M5aE5mNW94eFRq?=
 =?utf-8?B?dWw4bllmZEVNbmV0bmEwNDc4MkNsVnBqNmhIT1lSWk9YRkR5QlIrVFkwcU5W?=
 =?utf-8?B?NEIralM1SkYzQ2RQNTFHQzBoMTdBT0hocWloTDhQellVYXRuOFFBYU1KdlZI?=
 =?utf-8?B?cytaZGFjZTBFRWU3T2s4b1dIcFRYTkpQTGw0RWEwU21iRGpZcWczbW90dUxw?=
 =?utf-8?B?em8vR2svbC80YWxCeitXeWNDL0d4eXhwZlBWcHpUWU90cGVqbjduZDlHRHhx?=
 =?utf-8?B?ZWg3ZStGOEZPaWpENmI2Y2FKUUdva0lTRG1rZXRjMk9TS0hjOU4wbEdWU3JS?=
 =?utf-8?B?K3JTQStOWFZZZFFUUUVJY2dHTFRuK2svL1JPbGlnZUNNU1B1TjJBR1FHN1Qy?=
 =?utf-8?B?bE5WV0J5QnJvZGJSU09sZHZrTVZERXRkZ0Q2NExPeGdKZnhxeDlLMWtwaWl0?=
 =?utf-8?B?Uml1U1FqMFBZaWtGK1o2L09LNUxGT2c5dndkT1FhbGhMYW9qSEVteG5SM1dU?=
 =?utf-8?B?SmNnU2RGamxIdXNXNHp5NjdzT1hmMElDeVJ6L2NJeWU4SHRQZ1FVcUt5UDRo?=
 =?utf-8?B?eXpKWHVoWlJ6cVAreXFlb3RRQkVEYTdaeHRaRmRQQ3dsSzNVSk9PZzl3V29i?=
 =?utf-8?B?bFRmWTBldkxKRnRLcCsvK2ZUQ0ZlYW5UVGhWbmtNR0tyQTN5SmF5aEZVeDE4?=
 =?utf-8?B?UDZxNjZpNnkrd1h2UGh3Z3VPMlZCNE03ei9IaXdCWEJmZUo0b1l2aVZsaXNU?=
 =?utf-8?B?VDZpa21VdGxwUnUvaDUrTXRYQndNWm9Kc0RoUFd6YlZJaWFxZ1ZIZmNSZGor?=
 =?utf-8?B?THhRMnV3dVQvMWdqb0xMZWRzQ2psT1hzcG9EMzVIWk05cXR3Z3RuMWZDYmtJ?=
 =?utf-8?B?QnFSMmVDaGRUYUVKNzJQdi8yUW8ybnRHMGdrYzNaNlFkKzQrNnN2MTZWR3RV?=
 =?utf-8?B?dW5PbTVXY05SV0ZJUFZoa0lpVG01dGpVQzByMGRQRlhXR0VpdjJVanA0Nzd5?=
 =?utf-8?B?dVplTWQ0dVpnaHlXanpjR3ZDVXF1OHE2TEU0TjQ5QUhDc3g0eFZoV1NUK0to?=
 =?utf-8?Q?CK6UxSEZ9zKlcifYIaA9CTAIm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e94d221-b95b-4158-3910-08da5eae0909
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 17:44:39.7372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEb3OV5Hz2bHcO3TrpBDsM61T8E1rxcSBgmCNP8Am0eKUadAw2KuA5ApCaIMjrr3i291rxBt2+/GEl7grQqS9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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


On 2022-07-05 12:09, philip yang wrote:
>
>
> On 2022-06-27 20:23, Alex Sierra wrote:
>> [WHY]
>> Unified memory with xnack off should be tracked, as userptr mappings
>> and legacy allocations do. To avoid oversuscribe system memory when
>> xnack off.
> I think this also apply to XNACK ON (remove p->xnack_enabled check), 
> to avoid oversubscribe system memory OOM killer, if we don't account 
> swap space as it will degrade performance.

That's not the GPU driver's job. If applications allocate too much 
memory, that's the application's fault. With XNACK ON, the driver 
doesn't need to make memory resident before the GPU starts executing, 
and the GPU can continue executing when unused memory is swapped out. 
Allowing memory overcommitment is one of the desirable features enabled 
by XNACK ON. Therefore we don't need to artificially limit the amount of 
memory that can be GPU mapped in this mode.

Regards,
   Felix


>> [How]
>> Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
>> API and call them on every prange creation and free.
>>
>> Signed-off-by: Alex Sierra<alex.sierra@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 ++
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 25 ++++----
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 58 +++++++++++++------
>>   3 files changed, 58 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index b25b41f50213..e6244182a3a4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -305,6 +305,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
>>   void amdgpu_amdkfd_block_mmu_notifications(void *p);
>>   int amdgpu_amdkfd_criu_resume(void *p);
>>   bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
>> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>> +		uint64_t size, u32 alloc_flag);
>> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>> +		uint64_t size, u32 alloc_flag);
>>   
>>   #if IS_ENABLED(CONFIG_HSA_AMD)
>>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 9142f6cc3f4d..9719577ecc6d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -128,7 +128,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>>    *
>>    * Return: returns -ENOMEM in case of error, ZERO otherwise
>>    */
>> -static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>> +int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   		uint64_t size, u32 alloc_flag)
>>   {
>>   	uint64_t reserved_for_pt =
>> @@ -168,7 +168,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
>>   	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>>   	     kfd_mem_limit.max_ttm_mem_limit) ||
>> -	    (adev->kfd.vram_used + vram_needed >
>> +	    (adev && adev->kfd.vram_used + vram_needed >
>>   	     adev->gmc.real_vram_size -
>>   	     atomic64_read(&adev->vram_pin_size) -
>>   	     reserved_for_pt)) {
>> @@ -179,7 +179,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   	/* Update memory accounting by decreasing available system
>>   	 * memory, TTM memory and GPU memory as computed above
>>   	 */
>> -	adev->kfd.vram_used += vram_needed;
>> +	WARN_ONCE(vram_needed && !adev,
>> +		  "adev reference can't be null when vram is used");
>> +	if (adev)
>> +		adev->kfd.vram_used += vram_needed;
>>   	kfd_mem_limit.system_mem_used += system_mem_needed;
>>   	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>>   
>> @@ -188,7 +191,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>   	return ret;
>>   }
>>   
>> -static void unreserve_mem_limit(struct amdgpu_device *adev,
>> +void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>   		uint64_t size, u32 alloc_flag)
>>   {
>>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
>> @@ -197,7 +200,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>>   		kfd_mem_limit.system_mem_used -= size;
>>   		kfd_mem_limit.ttm_mem_used -= size;
>>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>> -		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
>> +		WARN_ONCE(!adev,
>> +			  "adev reference can't be null when alloc mem flags vram is set");
>> +		if (adev)
>> +			adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
>>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>   		kfd_mem_limit.system_mem_used -= size;
>>   	} else if (!(alloc_flag &
>> @@ -206,11 +212,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>>   		goto release;
>>   	}
>> -
>> -	WARN_ONCE(adev->kfd.vram_used < 0,
>> +	WARN_ONCE(adev && adev->kfd.vram_used < 0,
>>   		  "KFD VRAM memory accounting unbalanced");
>> -	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
>> -		  "KFD TTM memory accounting unbalanced");
>>   	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
>>   		  "KFD system memory accounting unbalanced");
>>   
>> @@ -224,7 +227,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>>   	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>>   	u64 size = amdgpu_bo_size(bo);
>>   
>> -	unreserve_mem_limit(adev, size, alloc_flags);
>> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
>>   
>>   	kfree(bo->kfd_bo);
>>   }
>> @@ -1806,7 +1809,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>   	/* Don't unreserve system mem limit twice */
>>   	goto err_reserve_limit;
>>   err_bo_create:
>> -	unreserve_mem_limit(adev, size, flags);
>> +	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
>>   err_reserve_limit:
>>   	mutex_destroy(&(*mem)->lock);
>>   	if (gobj)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index d6fc00d51c8c..e706cbfa924f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -259,13 +259,22 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
>>   	}
>>   }
>>   
>> -static void svm_range_free(struct svm_range *prange)
>> +static void svm_range_free(struct svm_range *prange, bool skip_unreserve)
>>   {
>> +	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>> +
>>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
>>   		 prange->start, prange->last);
>>   
>>   	svm_range_vram_node_free(prange);
>>   	svm_range_free_dma_mappings(prange);
>> +
>> +	if (!skip_unreserve && !p->xnack_enabled) {
>> +		pr_debug("unreserve mem limit: %lld\n", size);
>> +		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>> +					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +	}
>>   	mutex_destroy(&prange->lock);
>>   	mutex_destroy(&prange->migrate_mutex);
>>   	kfree(prange);
>> @@ -284,7 +293,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
>>   
>>   static struct
>>   svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>> -			 uint64_t last)
>> +			 uint64_t last, bool is_new_alloc)
>>   {
>>   	uint64_t size = last - start + 1;
>>   	struct svm_range *prange;
>> @@ -293,6 +302,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>>   	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
>>   	if (!prange)
>>   		return NULL;
>> +
>> +	p = container_of(svms, struct kfd_process, svms);
>> +	if (!p->xnack_enabled && is_new_alloc &&
>> +	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
>> +					    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
>> +		pr_info("SVM mapping failed, exceeds resident system memory limit\n");
>> +		kfree(prange);
>> +		return NULL;
>> +	}
>>   	prange->npages = size;
>>   	prange->svms = svms;
>>   	prange->start = start;
>> @@ -307,7 +325,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>>   	mutex_init(&prange->migrate_mutex);
>>   	mutex_init(&prange->lock);
>>   
>> -	p = container_of(svms, struct kfd_process, svms);
>>   	if (p->xnack_enabled)
>>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>>   			    MAX_GPU_INSTANCE);
>> @@ -1000,9 +1017,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>>   
>>   	svms = prange->svms;
>>   	if (old_start == start)
>> -		*new = svm_range_new(svms, last + 1, old_last);
>> +		*new = svm_range_new(svms, last + 1, old_last, false);
>>   	else
>> -		*new = svm_range_new(svms, old_start, start - 1);
>> +		*new = svm_range_new(svms, old_start, start - 1, false);
>>   	if (!*new)
>>   		return -ENOMEM;
>>   
>> @@ -1010,7 +1027,7 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>>   	if (r) {
>>   		pr_debug("failed %d split [0x%llx 0x%llx] to [0x%llx 0x%llx]\n",
>>   			 r, old_start, old_last, start, last);
>> -		svm_range_free(*new);
>> +		svm_range_free(*new, true);
>>   		*new = NULL;
>>   	}
>>   
>> @@ -1825,7 +1842,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>>   {
>>   	struct svm_range *new;
>>   
>> -	new = svm_range_new(old->svms, old->start, old->last);
>> +	new = svm_range_new(old->svms, old->start, old->last, false);
>>   	if (!new)
>>   		return NULL;
>>   
>> @@ -1889,6 +1906,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   	struct interval_tree_node *node;
>>   	struct svm_range *prange;
>>   	struct svm_range *tmp;
>> +	struct list_head new_list;
>>   	int r = 0;
>>   
>>   	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
>> @@ -1896,6 +1914,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   	INIT_LIST_HEAD(update_list);
>>   	INIT_LIST_HEAD(insert_list);
>>   	INIT_LIST_HEAD(remove_list);
>> +	INIT_LIST_HEAD(&new_list);
>>   
>>   	node = interval_tree_iter_first(&svms->objects, start, last);
>>   	while (node) {
>> @@ -1951,13 +1970,13 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   
>>   		/* insert a new node if needed */
>>   		if (node->start > start) {
>> -			prange = svm_range_new(svms, start, node->start - 1);
>> +			prange = svm_range_new(svms, start, node->start - 1, true);
>>   			if (!prange) {
>>   				r = -ENOMEM;
>>   				goto out;
>>   			}
>>   
>> -			list_add(&prange->list, insert_list);
>> +			list_add(&prange->list, &new_list);
>>   			list_add(&prange->update_list, update_list);
>>   		}
>>   
>> @@ -1967,19 +1986,22 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   
>>   	/* add a final range at the end if needed */
>>   	if (start <= last) {
>> -		prange = svm_range_new(svms, start, last);
>> +		prange = svm_range_new(svms, start, last, true);
>>   		if (!prange) {
>>   			r = -ENOMEM;
>>   			goto out;
>>   		}
>> -		list_add(&prange->list, insert_list);
>> +		list_add(&prange->list, &new_list);
>>   		list_add(&prange->update_list, update_list);
>>   	}
>>   
>>   out:
>>   	if (r)
>> -		list_for_each_entry_safe(prange, tmp, insert_list, list)
>> -			svm_range_free(prange);
>> +		list_for_each_entry_safe(prange, tmp, &new_list, list)
>> +			svm_range_free(prange, false);
>> +	else
>> +		list_for_each_entry_safe(prange, tmp, &new_list, list)
>> +			list_add(&prange->list, insert_list);
>
> We should remove range from both new_list and insert_list to rollback 
> pranges.
>
>   	if (r) {
> 		list_for_each_entry_safe(prange, tmp, insert_list, list)
> 			svm_range_free(prange, true);
> 		list_for_each_entry_safe(prange, tmp, &new_list, list)
> 			svm_range_free(prange, false);
> 	} else if (!list_empty(&new_list) {
> 		list_splice(&new_list, insert_list);
>          }
> Regards,
> Philip
>>   
>>   	return r;
>>   }
>> @@ -2026,7 +2048,7 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
>>   			 svms, prange, prange->start, prange->last);
>>   		svm_range_unlink(prange);
>>   		svm_range_remove_notifier(prange);
>> -		svm_range_free(prange);
>> +		svm_range_free(prange, false);
>>   		break;
>>   	case SVM_OP_UPDATE_RANGE_NOTIFIER:
>>   		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>> @@ -2588,14 +2610,14 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>>   		last = addr;
>>   	}
>>   
>> -	prange = svm_range_new(&p->svms, start, last);
>> +	prange = svm_range_new(&p->svms, start, last, true);
>>   	if (!prange) {
>>   		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
>>   		return NULL;
>>   	}
>>   	if (kfd_process_gpuid_from_adev(p, adev, &gpuid, &gpuidx)) {
>>   		pr_debug("failed to get gpuid from kgd\n");
>> -		svm_range_free(prange);
>> +		svm_range_free(prange, false);
>>   		return NULL;
>>   	}
>>   
>> @@ -2884,7 +2906,7 @@ void svm_range_list_fini(struct kfd_process *p)
>>   	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
>>   		svm_range_unlink(prange);
>>   		svm_range_remove_notifier(prange);
>> -		svm_range_free(prange);
>> +		svm_range_free(prange, false);
>>   	}
>>   
>>   	mutex_destroy(&p->svms.lock);
>> @@ -3299,7 +3321,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   			 prange->last);
>>   		svm_range_unlink(prange);
>>   		svm_range_remove_notifier(prange);
>> -		svm_range_free(prange);
>> +		svm_range_free(prange, true);
>>   	}
>>   
>>   	mmap_write_downgrade(mm);
