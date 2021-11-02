Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE751C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 15:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96EA60F90
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 15:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B96EA60F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C32F6E99D;
	Tue,  2 Nov 2021 15:54:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213BD6E04E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 15:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah118lFnf4NUF+1owvjg2XkvVMDZSwbm9vvw9Kd557MPmAp14fX+9J/ltcVYA+EU7mOQSPNtL9mbFamt95OqvhW9GhxnW84t/3aCXqRCI8USIF7sxSQBe1OYdWxKfYk3yRY8u0Q9OVSejN6NcOLUXVu20/UgkIqWK7poKHPRLdIN90QlprgAqwvmoJl03pIsbF7y1C409zETSIKtRiJTvQkBGkN5L88ElOcP7UrMT/ktkoF5BtatXyKMshg7IKnViXEnZDwHM+F2WvhAKE6gRn5zPBrDi5k8aJeR3rB4+p1kLXKa08erut+NjhhhjAn3oOD2EFGhnTbcx4oPdAt0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+FY+KjMC6NOaFwcF+peDqmlEmrbIjzPQRvseVttzp8=;
 b=laPo6Wy5mms4yT4FMxg928TTMz2p2clnIJUfrJ0HeD9ILB6cKMvOoo9sFhl8Qj83rYOvYeSQ/HMsmmPMUQxefgoGHD7EJ+XhZ1fLoCgyChkPTqZsS+rkl0UNjw7pCOrUiH7fPseFYsPBGjUIlJ3aZhn5rQn4ofbLTmyJx5Rwv9ZCec5PlfGUiQk/XaYrUjSBgw1zkOq1F8rh6VxBsRCSC7C1BLfxsbjmACbJgyd6I19ssj2D+xUCKry+XVAjVgwYtfm5AZnbg3ApkvJYiExRLj/WeFD0WsAHkVJrZCuPHRXP/aSiQu3GWYaTYL1LLg0ZkV4XOomTryYWOtwiXMFyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+FY+KjMC6NOaFwcF+peDqmlEmrbIjzPQRvseVttzp8=;
 b=lqMILunysUMu34Y7EmyJAezYWhK0T7yWaTN25KV3yurnvvZeMgOEyzvLft4eAmTxh1SBndp5x8Vq92imfb+4U74TbaA2Yjqj4k5QbzXwfChtwszb7nhIeTJ63S+NF917yDZTmo6o+or2Dio70bW/3aPIQrkSeMfgK9q4clVtuHk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 2 Nov
 2021 15:54:08 +0000
Received: from MN2PR12MB4423.namprd12.prod.outlook.com
 ([fe80::d105:f008:718e:9b2a]) by MN2PR12MB4423.namprd12.prod.outlook.com
 ([fe80::d105:f008:718e:9b2a%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 15:54:08 +0000
Message-ID: <38f47a35-4212-dc20-20ed-ef60659bcda5@amd.com>
Date: Tue, 2 Nov 2021 10:54:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] drm/amdkfd: avoid recursive lock in migrations back to RAM
Content-Language: en-US
To: philip yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211102024040.11666-1-alex.sierra@amd.com>
 <86db53c1-538a-c479-fffd-88888141c2e6@amd.com>
From: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
In-Reply-To: <86db53c1-538a-c479-fffd-88888141c2e6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::11) To MN2PR12MB4423.namprd12.prod.outlook.com
 (2603:10b6:208:24f::18)
MIME-Version: 1.0
Received: from [172.31.131.13] (165.204.78.25) by
 BL1PR13CA0156.namprd13.prod.outlook.com (2603:10b6:208:2bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend
 Transport; Tue, 2 Nov 2021 15:54:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d024ef92-21d3-48bf-d62f-08d99e190100
X-MS-TrafficTypeDiagnostic: BL0PR12MB4866:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4866CFEC75D61FED7C31AC8FFD8B9@BL0PR12MB4866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RH6AQv3ViP2oV7tUstNMbmguANEWG3GY/j8HiD/uAfjGAoziYE5ZsNhmnwhLJPdtoanVRBVhTNe0WEVqyzWiU4byVIr6k5pstWp/K3cCLjfIQ8RKzO3yAaFg5B47+l1Bm1udX3bGXh+OhZ2CJRbwcxi48xu3F0xW1WbsDIDegTclw5PcBk65AHWZDmzdC/mKxTFMSo0BrXBg4b1gqHOtg528c7RcyBs4nVXD/IyjEbkvx5TFNkY0MlIfpZbOkCauI8o44ajOeiX2GAmTkPLtusgPS8FfCoBmkn32k/3IOI9ex9QhGas0/vvs0SvRs8M12nk0GVgJk10aCU2Vl2kr+GsXjtzGYMArxOmbUoGTtxAGwVyeVlMjbBpLkAOsh6CShO/dIx/TDq97WfeKrJY9me3MEz1vpX8OvppzKy7UUXRg9lvt5PKJ3RGwawHOBfCrsq8qlZUsJQyHQD//wqxrufqEDPIVLMvDL/9iNuarYpy97It7fjxbqAmxBDDdMiIFJNp790Gj0CwOmSGdy4DEcY9CvupmAZP3t6EGv/D1ucCq6XOyvDpun8ipbpQDmeEg8VYaV74A+3Kn/bYU6uDf+JpHgqyV6KnPmTFOfXZQwAY6fXHhhQpY1s/4ZAMMVbeRvxVhy5KynBLNWRJAhC0o1+Q9pGfQN9r3PeFeSf/9EW1ycxSdM0bpebpiqVVyJIEqP/H1Bex7SeD8n/SHBfvN1EWSeZBFwh58Zy1C9mRoWEcp8LcI0DKOQIchcpd3I4ZY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4423.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(36756003)(8936002)(8676002)(53546011)(508600001)(38100700002)(6486002)(31696002)(86362001)(186003)(2906002)(316002)(66476007)(16576012)(956004)(66556008)(2616005)(5660300002)(31686004)(83380400001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW05enNJYWR2WTdEZEVzU0hwb3YxeWxFRy9CZTJUbWRjdHpUL3IyODBvYk9G?=
 =?utf-8?B?c2dLWWxIWi9VRVlNUTBjUGVMeElVMXl0T2dmYnFWVjN2VGFKR3VvdXdLSzI3?=
 =?utf-8?B?RmQrTFBFa1hmMjFIRm9wNHFDNFVRMHhKN0NTNUpkM1VsTjNmTkVNVVJMTW1k?=
 =?utf-8?B?WndZbU0xRy96SUFGMWtUVUwvZTZoVzBxU2V5dHovUTRwWUJaaHpqS2wzQllv?=
 =?utf-8?B?T0Zzb0pUT1E1UnRhcE16T21EVVVKbENjRDdnYXpRcEtvUmU4VGdwR3pLWWZJ?=
 =?utf-8?B?RGN2UTN6N3ltb0hoMVRHTzdQZkFZRGtWbU52cnpuRjVKdUpycjVPNlVkRXFZ?=
 =?utf-8?B?UjNGcjVtR0ZuUHNoYndGSWNIalJ4RTNabGlDV1pGSFRkekpvMHBVUk4wZlAz?=
 =?utf-8?B?aDRnRmtyWHdIME9kT2IxUGdxMWo5YzVHMmI5cnFyQjM5ZHM0V29Fa3lJN1VZ?=
 =?utf-8?B?cHFDbTdvKy9GS29mVkhycmZRZXluNTMweFU5SzBLMTdWUkJUOGpINWlheUQx?=
 =?utf-8?B?bWNoWUxmdTJ0Y2VVVkZUVnYya1J3c2tYTDhoUnF0TE9acVNveStxRllKUUpV?=
 =?utf-8?B?WllEWXVDcTBickwyL0k0dU1RY05BN3gxMUF0eTRqdlpRNlkyU2MxOUZpdUlq?=
 =?utf-8?B?SmFEaHNiNEhIU1BZVFJQYlArNUxvVWdQVjAxQjF5ME1yTEttNzFLSzVXYjlW?=
 =?utf-8?B?Q0pOOGh3WXBsZUZPREVCa1VrMzNBTWNjaXArbGVISkdiNnhkQ21teVk3Yk1M?=
 =?utf-8?B?YlVtRktGa3M3c09ZUWQrQXpSbjhScENUMysrbkNyYWowTmIva0d6Zi96MjUr?=
 =?utf-8?B?Zjd6YkJCV2c2VW5LS3NyUGY1azZHL1p5Vi9UN3Noa0Q3aW5xZHU2clpxZXl2?=
 =?utf-8?B?dlJEVURKclFzbzhudmJTRXVndmVDdGorZWMvNTY4M3l3NWlhN00ySjFXdFA0?=
 =?utf-8?B?eTFHajV4c1N6L3FpOHVka1lsdk1wWUNkTzRTUThQM0FMcDg3RGFGKzRsWEtL?=
 =?utf-8?B?MmJVOU9IdkJKcnl2SFhmbEE0aWhIWTFYcUl1OFBueWtSSnJVbXA5a0tYUFhW?=
 =?utf-8?B?b1RSK0FaUlQyUWtBSWUybHNrYzR1RjlDMGV6VHU5ZVNmaVVyYmxNYjI1MWl1?=
 =?utf-8?B?Y1B5MFBQR20rNWQ3ZGFDV3J3aUhjVDdwQllqbE9XNkxzK2pheWM5S3ZiOXBj?=
 =?utf-8?B?UFpOOUNnVUpwdXB3M2U2bytWMVZXN2VpcUo2cXVQNkxyaWN4YTE0WjF4dmhy?=
 =?utf-8?B?cVYrMnJBMTkzNTNTdEdmelFjeXQ0bWVUMElkR1IyOC8xbnlMclBXU0piMlIr?=
 =?utf-8?B?MjB5b0NINzkxbCtta1BtazZTaUZrYkd4WFAyaTVqVXdGM1RxVng3ZE5tT0I4?=
 =?utf-8?B?VWlyQ09abGFUTlBBa1ZBWUFLU1ZCc21TQVZLSzl4S0RBcEVQcFlYRngrSGQx?=
 =?utf-8?B?Qk54QTRsUXE5c040OGdDem1nRmFPVTltZzZZaEdBVlM4VGpld1ZFZVBZbHdu?=
 =?utf-8?B?bnZyQmdLRWRIS01MUVFrRzFCT3R2ZFc0REdPWDR1YzhYODM5M0RFOENQTWJV?=
 =?utf-8?B?ZWFnL0JYOHI5dUtRRVNTakpqd3BrYkFjaEx1Y2c5VEMrQU1ZOG5sVzhyd09t?=
 =?utf-8?B?Vm9NckE0U0hiVFRMYmZ4aHNlTzFGY21XOEFxeGtDc0xjQSs3Y3dkOTdydEg5?=
 =?utf-8?B?Uk9yY1NxeWFaM3ZVSFI3eG1RYVZLdUh2TjEyVk9laENGY3NZaVlxeGtEbFNl?=
 =?utf-8?B?eWducTlCTFdYOUdvSWpOc0gyenYrMS9VcU1nV1hCQmV4eWVBMGgvSTY2ajJD?=
 =?utf-8?B?WUUxQmFSaUMzRGJzckMrRlpmNDVSYitSTnhqTFErWEk4QUpIc0pqK3Z1bDNM?=
 =?utf-8?B?d3ZZZlZyU3dJcDRBU3NoTkR4UnVLbE9pcks5K0xacllOTTZVZlhiaXRLcHB2?=
 =?utf-8?B?U2dLZGFQa0doUlQvbWZhdGJTdkhjUFhDZmg5anVKNG92WE1HS3pXeHZGbmxo?=
 =?utf-8?B?bzczNG5ZVlhnNWcvNDB1QzlPMFE1ZFVpRUF1YkR6Wk0vQnRJQTZGNEVCYTNr?=
 =?utf-8?B?V1c4cTJBck5RNWprc2hRUHNLdS9XNWd3NGNzdXNJYUNYSm50L2RwOGx4cjJp?=
 =?utf-8?B?d01kT0NVYlllOFNtaHFEU1BBNkdGOWZPcWJ4MXA0enduY1RNOE8wRkVhMXVO?=
 =?utf-8?Q?YlQILWc1F/Ki+6JB7oVNGjk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d024ef92-21d3-48bf-d62f-08d99e190100
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4423.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 15:54:07.9421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQr5OIMQQDmfdB0REltLpdwKTu3WyKuDQYX/DMocurezxlUfGJ+wSPwytBjwqezhSx2M7zNpEDHR+VxB/+KZqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
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


On 11/2/2021 10:04 AM, philip yang wrote:
>
>
> On 2021-11-01 10:40 p.m., Alex Sierra wrote:
>> [Why]:
>> When we call hmm_range_fault to map memory after a migration, we don't
>> expect memory to be migrated again as a result of hmm_range_fault. The
>> driver ensures that all memory is in GPU-accessible locations so that
>> no migration should be needed. However, there is one corner case where
>> hmm_range_fault can unexpectedly cause a migration from DEVICE_PRIVATE
>> back to system memory due to a write-fault when a system memory page in
>> the same range was mapped read-only (e.g. COW). Ranges with individual
>> pages in different locations are usually the result of failed page
>> migrations (e.g. page lock contention). The unexpected migration back
>> to system memory causes a deadlock from recursive locking in our
>> driver.
>>
>> [How]:
>> Creating a task reference new member under svm_range_list_init struct.
>> Setting this with "current" reference, right before the hmm_range_fault
>> is called. This member is checked against "current" reference at
>> svm_migrate_to_ram callback function. If equal, the migration will be
>> ignored.
>>
>> Signed-off-by: Alex Sierra<alex.sierra@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 2 ++
>>   3 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index bff40e8bca67..eb19f44ec86d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -936,6 +936,10 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>>   		pr_debug("failed find process at fault address 0x%lx\n", addr);
>>   		return VM_FAULT_SIGBUS;
>>   	}
>> +	if (READ_ONCE(p->svms.faulting_task) == current) {
>> +		pr_debug("skipping ram migration\n");
>
> need release refcount to avoid process leaking
>
> kfd_unref_process(p);
>
Good catch. Thanks Phillip.

Alex Sierra

> Regards,
>
> Philip
>
>> +		return 0;
>> +	}
>>   	addr >>= PAGE_SHIFT;
>>   	pr_debug("CPU page fault svms 0x%p address 0x%lx\n", &p->svms, addr);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index f88666bdf57c..7b41a58b1ade 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -858,6 +858,7 @@ struct svm_range_list {
>>   	atomic_t			evicted_ranges;
>>   	struct delayed_work		restore_work;
>>   	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>> +	struct task_struct 		*faulting_task;
>>   };
>>   
>>   /* Process data */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 939c863315ba..4031c2a67af4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1492,9 +1492,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   
>>   		next = min(vma->vm_end, end);
>>   		npages = (next - addr) >> PAGE_SHIFT;
>> +		WRITE_ONCE(p->svms.faulting_task, current);
>>   		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
>>   					       addr, npages, &hmm_range,
>>   					       readonly, true, owner);
>> +		WRITE_ONCE(p->svms.faulting_task, NULL);
>>   		if (r) {
>>   			pr_debug("failed %d to get svm range pages\n", r);
>>   			goto unreserve_out;
