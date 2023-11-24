Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F68C61DF4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Nov 2023 13:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97DCC10E205;
	Fri, 24 Nov 2023 13:40:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFD410E205
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Nov 2023 13:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZBd8fyQI6bQBUGTYDzdR5aTmPZZ8TVQnQGXHHmeYWG0Vfc7lQEi9OnS5hSUvje3YtrqZcPfG2RozjfU9Em5mnPKA2/urKBMTy75Pd39C29k4moUnLXMOg3wNKeEcF9RUPW4rnJt8aj8hx3A+R9lYkPc9bTl4OqbnHY+roFEenb8XxX2eeUL/NI5yfZwOixF/Rh0sjLzBdjB39Cmjm3P+Uzc8b61vIv/RfX+i6+4orVjJuch2izt7G9AdnypRmXhgle9H2M9CG674oCW4+74Nyg5YsaKeHCner7V8ukrehO+doJn9SNo36lcWJf/iWKwHimiv9nffq5gYO+17rvHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4U8Crjbb585koIoDAauWtbmO/SqUYXmKcHsh0S1eq8=;
 b=Y71sMfwqvx6Y/MeQT48D+CKIDTT/Hp2wwDi1Z2nPu/JOlxXgYso4Yzg663E0BZ7bIWbTh6Xp1RRO655VbhP4pnLRlnIs2XHcKtt2LayvjN/EfMcF/SmoC26tK6IstuYRfOGoOB4YYy21P3RyegF14cPitCYZ9rkPoFAhpTkZwtGMUyUgiyeqSb2KzqaRXSERid2ymxwZvM8cebpb4HPGU+fwTQBX1PvnjZmXktbRifob9NcHr5wqIqunia9zNBZaWRCKj0SZEsMK1nruy5PPSqLOre7XSSTKKwPr8EYTsE9fna1tQAFxO1QySsrPcR2pcMbelFe2/AktJQlFiDoq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4U8Crjbb585koIoDAauWtbmO/SqUYXmKcHsh0S1eq8=;
 b=rq7YNYr1zM10zjBLWVpfJqQSv76+SdrGY27KOTUOIOfCQ43nkj11mmNegpVFzF0M5h9jBS7y1FG05n7GO8wDdNtcg4OmxGdG0Zi4nGRgU8H+1PkwOHY/vpptfWR6Yy6155A0pE2DB8x7CHQZLmcioHsjww8xGeciIeJK+HcERjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Fri, 24 Nov
 2023 13:40:20 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 13:40:20 +0000
Message-ID: <86ef31b9-3638-6b84-fcc8-c52b2346239f@amd.com>
Date: Fri, 24 Nov 2023 19:10:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] drm/amdkfd: Run restore_workers on freezable WQs
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231123225506.986511-1-Felix.Kuehling@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231123225506.986511-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0219.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 177fe271-a798-4aed-856b-08dbecf2e6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4JjCUvU6kdTPaiHBUQJ+aR5ukRyfEyHsidqfIoWYhcIlbkgx9EINCWQ5q4/RDnsb/4h5pfDXAaQP5amTfKqByxuquz7Sl95UUE6PpOKyskdf4hDL7cvi6ZGx1LJrkIIwO7ANVMuMZuuRMWoRnJGn3mTvLY+TM6uSQJGIBB3jdQgjrSy3gSXiL9V+UZtVOSVe9KPU7CjMpY1uG6aV/nzEBLDxpLHx58NJOBEXNsNjSob5BhbeQJnZpKjIJRnwrEE33jzXBRfVI/aHCGKM8El7v3wiA/ABbFgf+IAf5B6SF2At9DWWY/pGvNUqXizASsUqqhzYLTbxyNNptrxSEWBFgt+INhHYzUNZkVvQbi/NlopeB7lEv/8oPm+yuoKHKaKwR3fXEvUcT0wikKSgaKPV1+/4yhzN07+jGSC65UxgX2RoWhfmtSipqywqjX4cUEmYnASzk9mQSJYzbR0cAwf3LOcWD2pVf21QgRpo8CFzmj9IuobWyYGLvqzQuH85jfk8W5XCj2/pRYgYAmvE2tunpMlF9snRVCz5popmKORmVKTaiKtTc5JXs0Np3+06TBZ4bmzJVSvBOZ7ctWegb7Uw3b+tqqj2cRw6xeBPdFSWRaJYCzgSzRxRTxIlDwwCnQr6lq75Z3u4iYBqb0BDLUiLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(41300700001)(36756003)(2906002)(5660300002)(86362001)(31696002)(30864003)(2616005)(66574015)(6512007)(53546011)(6506007)(38100700002)(45080400002)(83380400001)(6486002)(478600001)(6666004)(31686004)(8936002)(8676002)(316002)(66476007)(66556008)(66946007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlVCNzQ0WXZyTW9yMkxiSTZ1OUNaRUpnY0wzM0cwSlBTMXkzSFB5TnFvSzZm?=
 =?utf-8?B?TjVUcVNKTVRLcU55WUJWelNKZ0ZkazFDM1d3UkRrTUNWcXhQQ3NNV21QUFNF?=
 =?utf-8?B?QWJnQkRjTHhJMkdoWWZndFRXQURnQ1R1SUNDMWp0NFFYU1VDNE0waXBlU1RO?=
 =?utf-8?B?NEdJQjFPSVJVdXdlenQrMjErcEhqS21veExEa1krWENyTERHRjJXblFxTHAr?=
 =?utf-8?B?a0tiS0k1cDU2N3NVdEU1RTg5K2Zsakx5VVZueDdTcm91Q0xTYjhEQURJTjVt?=
 =?utf-8?B?VVdId1JNYk8vazExM01rNmFESTlxdk81cFJHTWdBRjkxMlhMSGMwL3VtK203?=
 =?utf-8?B?M1dlRjdKdzRFa0UrNEhCTVBUdzZTNWU2cTlXRG5Tak5TdHNCU0RVTEZSYzVO?=
 =?utf-8?B?TnZJUCtSVnpzOW5lVWVRbmVSWUFWWW1JTE5KaXBKbUJOOUJOTmlkV3dNVUkr?=
 =?utf-8?B?Wm1GalpERFM3NVZrN2o1eG9FZjNpUHhGY1ozb1BJUUsxMWEweW42MHA1NjN6?=
 =?utf-8?B?bFU3cEh6Q1VjQXB2cW9uU2FsSmk5bzVwS3BlVW5iYXRDYjVKNUNCWGxSdmxG?=
 =?utf-8?B?SjJZZTZtRGxHTGFreFRmc0ZXU284UTIyYUFoNlk4ZkFobVZsMTU0c1ZDRFFT?=
 =?utf-8?B?ZDR6ZnBZZ1VHdzI4aTIxRFAyK3B1OEdXRENmcisyWEdPOUJaUFdKcU1MeERq?=
 =?utf-8?B?NklyQzBUTmRLZTBVRmk3MUdZeUh0QS9WSWQyODIweDlzN3J2TjloWkN5T1pB?=
 =?utf-8?B?MUZVcGlFaVlFK3V1OG1Cb0xVKzloem5ZMHoyS21US2kwM2E4L01TcmlmN2xn?=
 =?utf-8?B?OEk1Z3Q5M3pRc3BtZFFmSUFJSlJnZjAyMm0rc0dNOW52cFNjSEszbVdTZisr?=
 =?utf-8?B?b0NFU2p2YzlOeEhvamtPdU5nZldic0lncEE4Y0ozeStBT01Ud1VjSGVDVE1k?=
 =?utf-8?B?WEZwakVTWjI0RkJHTDRwQTRJV3RIYXdmU0JkM2FjY1JpRHNmMCs5c2FWM3Vl?=
 =?utf-8?B?MU5DNFVpNTFMaXhDMEU3SzVwY3YwaEZjNmtKK3FnL29uc2hXdjhsOEc1UVJL?=
 =?utf-8?B?bVZqZEh6cm9ybUdzWDkrU3RyUjA0OUJ4SVNSY2hnT0lWZHcraHdEaUJVWm4x?=
 =?utf-8?B?RzY1ZWdkd2thVkpKblRRMTZRdlo2ZVUxczRYT2VjbkRvQU0yckVIZHI5VnQ0?=
 =?utf-8?B?TDFQVFFZNFNta3M1WmV4ck9uQ1JMWVliQ0RyL1QxcjhDV0RwYU5LOXl3cDN4?=
 =?utf-8?B?cW10NzRXci96S3hMNG9ibURlYUw4cGcvandkYXJ3aU8zQjVkeG12VkhSaVJ6?=
 =?utf-8?B?K2RHa0ltWXdKMG9BNXh1K3FOL092cE42d2Q3VzdZT0JrU2JUZCs1SGFDY1pW?=
 =?utf-8?B?VmdoTmpJSk9iT1Y1SFZlMFA3eXpKV2ZLUUpYY1FEMFVCelkvUERMQVRoL1Bw?=
 =?utf-8?B?WU5mMHJYSkYyTHBsZ2RIL1dBYnF4R0F3NnRXakxleUF1djgwWnh3WVRyalEz?=
 =?utf-8?B?V2dhSjF1Tk1jbk1pZzlQUE5OQStMUGcwWU5sbkxnK0U4UG40d1pSNVBQbkd6?=
 =?utf-8?B?M0UxMDBUb2tpalU5bC9wV3Jia3VueGNCcndEeVI1LytiMUtHUnNOa3NUQ0ZE?=
 =?utf-8?B?U2YxVUNpT210SFpFV2tQTDU0M1RheWFCQVBXREhiNytRcTd4cHA0eU0xVlA0?=
 =?utf-8?B?YWQ5SFhZSzg5djZnTkZJVmcvZklSSTlkZWQwclkrUGx2cGdzYmxXeVR0NXd1?=
 =?utf-8?B?VGdYZityeTM3R0ZIR1BPQjhpb1VBUWN1T2IyYm5ram5STGNNOTVUY3BNVDUz?=
 =?utf-8?B?Y0RLdmI0citEMG1TY2JZWkozMG9LNmpDMXgvMFBrbXBZc3k0anBsYmFleERB?=
 =?utf-8?B?L0FWcm1FVFIrVFFMRTlONHVKSU04TUkrR28weHJUMkdqaVc5eEZpNWpPcS9X?=
 =?utf-8?B?YktMR0NVL0N4N3RGcE1FaDJQMVZGTzJkSnlEc3FFbUZxSG1GRVJRMmlVcU1V?=
 =?utf-8?B?dElLRkkxMStCVlR5QVVjL2JjWThKcS92WEFqamIzL1FXaG1vRjFQb3VRNDE0?=
 =?utf-8?B?bGMxNDJGMUdCTWZoamNPaVpPSTU2ODZudllJWlpLaXRpVFpaWWFCYjVtd1Nt?=
 =?utf-8?Q?Evp7j0Us8B1V1gdHiHDZ3QVXP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177fe271-a798-4aed-856b-08dbecf2e6dd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 13:40:20.4893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtlpWijhznmdwi9e0tqArCleND+n8HTozy15h/EY3j2umxAZRn2oOkxtFIjB2q/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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
Cc: emily.deng@amd.com, xinhui.pan@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/24/2023 4:25 AM, Felix Kuehling wrote:
> Make restore workers freezable so we don't have to explicitly flush them
> in suspend and GPU reset code paths, and we don't accidentally try to
> restore BOs while the GPU is suspended. Not having to flush restore_work
> also helps avoid lock/fence dependencies in the GPU reset case where we're
> not allowed to wait for fences.
> 
> A side effect of this is, that we can now have multiple concurrent threads
> trying to signal the same eviction fence. Rework eviction fence signaling
> and replacement to account for that.
> 
> The GPU reset path can no longer rely on restore_process_worker to resume
> queues because evict/restore workers can run independently of it. Instead
> call a new restore_process_helper directly.

Not familiar with this code. For clarity, does this mean 
eviction/restore may happen while a reset is in progress?

Thanks,
Lijo

> 
> This is an RFC and request for testing.
> 
> v2:
> - Reworked eviction fence signaling
> - Introduced restore_process_helper
> 
> v3:
> - Handle unsignaled eviction fences in restore_process_bos
> 
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 68 +++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 87 +++++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
>   3 files changed, 104 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2e302956a279..bdec88713a09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1431,7 +1431,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   				  amdgpu_amdkfd_restore_userptr_worker);
>   
>   		*process_info = info;
> -		*ef = dma_fence_get(&info->eviction_fence->base);
>   	}
>   
>   	vm->process_info = *process_info;
> @@ -1462,6 +1461,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   	list_add_tail(&vm->vm_list_node,
>   			&(vm->process_info->vm_list_head));
>   	vm->process_info->n_vms++;
> +
> +	*ef = dma_fence_get(&vm->process_info->eviction_fence->base);
>   	mutex_unlock(&vm->process_info->lock);
>   
>   	return 0;
> @@ -1473,10 +1474,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   reserve_pd_fail:
>   	vm->process_info = NULL;
>   	if (info) {
> -		/* Two fence references: one in info and one in *ef */
>   		dma_fence_put(&info->eviction_fence->base);
> -		dma_fence_put(*ef);
> -		*ef = NULL;
>   		*process_info = NULL;
>   		put_pid(info->pid);
>   create_evict_fence_fail:
> @@ -1670,7 +1668,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
>   		goto out_unlock;
>   	}
>   	WRITE_ONCE(pinfo->block_mmu_notifications, false);
> -	schedule_delayed_work(&pinfo->restore_userptr_work, 0);
> +	queue_delayed_work(system_freezable_wq,
> +			   &pinfo->restore_userptr_work, 0);
>   
>   out_unlock:
>   	mutex_unlock(&pinfo->lock);
> @@ -2475,7 +2474,8 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>   				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>   		if (r)
>   			pr_err("Failed to quiesce KFD\n");
> -		schedule_delayed_work(&process_info->restore_userptr_work,
> +		queue_delayed_work(system_freezable_wq,
> +			&process_info->restore_userptr_work,
>   			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>   	}
>   	mutex_unlock(&process_info->notifier_lock);
> @@ -2810,7 +2810,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>   
>   	/* If validation failed, reschedule another attempt */
>   	if (evicted_bos) {
> -		schedule_delayed_work(&process_info->restore_userptr_work,
> +		queue_delayed_work(system_freezable_wq,
> +			&process_info->restore_userptr_work,
>   			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>   
>   		kfd_smi_event_queue_restore_rescheduled(mm);
> @@ -2819,6 +2820,23 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>   	put_task_struct(usertask);
>   }
>   
> +static void replace_eviction_fence(struct dma_fence **ef,
> +				   struct dma_fence *new_ef)
> +{
> +	struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
> +		/* protected by process_info->lock */);
> +
> +	/* If we're replacing an unsignaled eviction fence, that fence will
> +	 * never be signaled, and if anyone is still waiting on that fence,
> +	 * they will hang forever. This should never happen. We should only
> +	 * replace the fence in restore_work that only gets scheduled after
> +	 * eviction work signaled the fence.
> +	 */
> +	WARN_ONCE(!dma_fence_is_signaled(old_ef),
> +		  "Replacing unsignaled eviction fence");
> +	dma_fence_put(old_ef);
> +}
> +
>   /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for the given
>    *   KFD process identified by process_info
>    *
> @@ -2844,7 +2862,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   	struct amdgpu_vm *peer_vm;
>   	struct kgd_mem *mem;
>   	struct bo_vm_reservation_context ctx;
> -	struct amdgpu_amdkfd_fence *new_fence;
>   	int ret = 0, i;
>   	struct list_head duplicate_save;
>   	struct amdgpu_sync sync_obj;
> @@ -2974,22 +2991,35 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   	/* Wait for validate and PT updates to finish */
>   	amdgpu_sync_wait(&sync_obj, false);
>   
> -	/* Release old eviction fence and create new one, because fence only
> -	 * goes from unsignaled to signaled, fence cannot be reused.
> -	 * Use context and mm from the old fence.
> +	/* The old eviction fence may be unsignaled if restore happens
> +	 * after a GPU reset or suspend/resume. Keep the old fence in that
> +	 * case. Otherwise release the old eviction fence and create new
> +	 * one, because fence only goes from unsignaled to signaled once
> +	 * and cannot be reused. Use context and mm from the old fence.
> +	 *
> +	 * If an old eviction fence signals after this check, that's OK.
> +	 * Anyone signaling an eviction fence must stop the queues first
> +	 * and schedule another restore worker.
>   	 */
> -	new_fence = amdgpu_amdkfd_fence_create(
> +	if (dma_fence_is_signaled(&process_info->eviction_fence->base)) {
> +		struct amdgpu_amdkfd_fence *new_fence =
> +			amdgpu_amdkfd_fence_create(
>   				process_info->eviction_fence->base.context,
>   				process_info->eviction_fence->mm,
>   				NULL);
> -	if (!new_fence) {
> -		pr_err("Failed to create eviction fence\n");
> -		ret = -ENOMEM;
> -		goto validate_map_fail;
> +
> +		if (!new_fence) {
> +			pr_err("Failed to create eviction fence\n");
> +			ret = -ENOMEM;
> +			goto validate_map_fail;
> +		}
> +		dma_fence_put(&process_info->eviction_fence->base);
> +		process_info->eviction_fence = new_fence;
> +		replace_eviction_fence(ef, dma_fence_get(&new_fence->base));
> +	} else {
> +		WARN_ONCE(*ef != &process_info->eviction_fence->base,
> +			  "KFD eviction fence doesn't match KGD process_info");
>   	}
> -	dma_fence_put(&process_info->eviction_fence->base);
> -	process_info->eviction_fence = new_fence;
> -	*ef = dma_fence_get(&new_fence->base);
>   
>   	/* Attach new eviction fence to all BOs except pinned ones */
>   	list_for_each_entry(mem, &process_info->kfd_bo_list,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index c10d050e1a61..71df51fcc1b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -664,7 +664,8 @@ int kfd_process_create_wq(void)
>   	if (!kfd_process_wq)
>   		kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
>   	if (!kfd_restore_wq)
> -		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq", 0);
> +		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
> +							 WQ_FREEZABLE);
>   
>   	if (!kfd_process_wq || !kfd_restore_wq) {
>   		kfd_process_destroy_wq();
> @@ -1642,6 +1643,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	struct amdgpu_fpriv *drv_priv;
>   	struct amdgpu_vm *avm;
>   	struct kfd_process *p;
> +	struct dma_fence *ef;
>   	struct kfd_node *dev;
>   	int ret;
>   
> @@ -1661,11 +1663,12 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   
>   	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
>   						     &p->kgd_process_info,
> -						     &p->ef);
> +						     &ef);
>   	if (ret) {
>   		pr_err("Failed to create process VM object\n");
>   		return ret;
>   	}
> +	RCU_INIT_POINTER(p->ef, ef);
>   	pdd->drm_priv = drm_file->private_data;
>   
>   	ret = kfd_process_device_reserve_ib_mem(pdd);
> @@ -1908,6 +1911,21 @@ kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
>   	return -EINVAL;
>   }
>   
> +static int signal_eviction_fence(struct kfd_process *p)
> +{
> +	struct dma_fence *ef;
> +	int ret;
> +
> +	rcu_read_lock();
> +	ef = dma_fence_get_rcu_safe(&p->ef);
> +	rcu_read_unlock();
> +
> +	ret = dma_fence_signal(ef);
> +	dma_fence_put(ef);
> +
> +	return ret;
> +}
> +
>   static void evict_process_worker(struct work_struct *work)
>   {
>   	int ret;
> @@ -1920,31 +1938,46 @@ static void evict_process_worker(struct work_struct *work)
>   	 * lifetime of this thread, kfd_process p will be valid
>   	 */
>   	p = container_of(dwork, struct kfd_process, eviction_work);
> -	WARN_ONCE(p->last_eviction_seqno != p->ef->seqno,
> -		  "Eviction fence mismatch\n");
> -
> -	/* Narrow window of overlap between restore and evict work
> -	 * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
> -	 * unreserves KFD BOs, it is possible to evicted again. But
> -	 * restore has few more steps of finish. So lets wait for any
> -	 * previous restore work to complete
> -	 */
> -	flush_delayed_work(&p->restore_work);
>   
>   	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
>   	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
>   	if (!ret) {
> -		dma_fence_signal(p->ef);
> -		dma_fence_put(p->ef);
> -		p->ef = NULL;
> -		queue_delayed_work(kfd_restore_wq, &p->restore_work,
> +		/* If another thread already signaled the eviction fence,
> +		 * they are responsible stopping the queues and scheduling
> +		 * the restore work.
> +		 */
> +		if (!signal_eviction_fence(p))
> +			queue_delayed_work(kfd_restore_wq, &p->restore_work,
>   				msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
> +		else
> +			kfd_process_restore_queues(p);
>   
>   		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
>   	} else
>   		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
>   }
>   
> +static int restore_process_helper(struct kfd_process *p)
> +{
> +	int ret = 0;
> +
> +	/* VMs may not have been acquired yet during debugging. */
> +	if (p->kgd_process_info) {
> +		ret = amdgpu_amdkfd_gpuvm_restore_process_bos(
> +			p->kgd_process_info, &p->ef);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = kfd_process_restore_queues(p);
> +	if (!ret)
> +		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
> +	else
> +		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
> +
> +	return ret;
> +}
> +
>   static void restore_process_worker(struct work_struct *work)
>   {
>   	struct delayed_work *dwork;
> @@ -1970,24 +2003,15 @@ static void restore_process_worker(struct work_struct *work)
>   	 */
>   
>   	p->last_restore_timestamp = get_jiffies_64();
> -	/* VMs may not have been acquired yet during debugging. */
> -	if (p->kgd_process_info)
> -		ret = amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
> -							     &p->ef);
> +
> +	ret = restore_process_helper(p);
>   	if (ret) {
>   		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
>   			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
>   		ret = queue_delayed_work(kfd_restore_wq, &p->restore_work,
>   				msecs_to_jiffies(PROCESS_BACK_OFF_TIME_MS));
>   		WARN(!ret, "reschedule restore work failed\n");
> -		return;
>   	}
> -
> -	ret = kfd_process_restore_queues(p);
> -	if (!ret)
> -		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
> -	else
> -		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
>   }
>   
>   void kfd_suspend_all_processes(void)
> @@ -1998,14 +2022,9 @@ void kfd_suspend_all_processes(void)
>   
>   	WARN(debug_evictions, "Evicting all processes");
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> -		cancel_delayed_work_sync(&p->eviction_work);
> -		flush_delayed_work(&p->restore_work);
> -
>   		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
>   			pr_err("Failed to suspend process 0x%x\n", p->pasid);
> -		dma_fence_signal(p->ef);
> -		dma_fence_put(p->ef);
> -		p->ef = NULL;
> +		signal_eviction_fence(p);
>   	}
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>   }
> @@ -2017,7 +2036,7 @@ int kfd_resume_all_processes(void)
>   	int ret = 0, idx = srcu_read_lock(&kfd_processes_srcu);
>   
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> -		if (!queue_delayed_work(kfd_restore_wq, &p->restore_work, 0)) {
> +		if (restore_process_helper(p)) {
>   			pr_err("Restore process %d failed during resume\n",
>   			       p->pasid);
>   			ret = -EFAULT;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b23ba92a794c..42b5279c7010 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1871,7 +1871,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   	/* If validation failed, reschedule another attempt */
>   	if (evicted_ranges) {
>   		pr_debug("reschedule to restore svm range\n");
> -		schedule_delayed_work(&svms->restore_work,
> +		queue_delayed_work(system_freezable_wq, &svms->restore_work,
>   			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>   
>   		kfd_smi_event_queue_restore_rescheduled(mm);
> @@ -1947,7 +1947,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   			pr_debug("failed to quiesce KFD\n");
>   
>   		pr_debug("schedule to restore svm %p ranges\n", svms);
> -		schedule_delayed_work(&svms->restore_work,
> +		queue_delayed_work(system_freezable_wq, &svms->restore_work,
>   			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>   	} else {
>   		unsigned long s, l;
