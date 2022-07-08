Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EC1C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 21:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CCAE10E1C6;
	Fri,  8 Jul 2022 21:18:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE8D10E9D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 21:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z22uk6v/6UxxGGwE9j0ZW8mPGp46uhn2edvsjgapyajfsoNKe4Ec/n7Z6HFtTZQPiVw5cc/GzBJPpl5acJSmWYGv782MlLgXpm8Ra9WpkAfnXoGZiij1gL33o1KGL3eWXVHJMyWdzcCvTpewN2lCMZnLT1nqPO0p+rAYGGoremdl0dwuaYcd0FHTM8zxjd/5RTfByvFw29kfvg/MrinwKb5bv4aBbRZycM05dtrYamLsSJyUsO+niJkYKUznY7L2/1y7NyImhGKW6CmJespOfrvk37zned7X6kivXxUx8ssS8BoCrWft+zFa3IDvNTCmNMcnjPuh1X1zFW8C04qGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMv4pTjXMidkMaf/FaoWSGztZVahWUQQGtO7wkdW1xQ=;
 b=EomfE5QxDI8f4RxsoqlVO743VzUoJip9XnVZie4NmwpPjZEqVCPf1qe3PlLbomIGCtO67JG7T/357GTAO8U47GF6pRRGpn2eLNqVROzgABClR7l5jt6Q84UST/pNg16fHFqeGCsnvVfRPV9C6lYG8X9q/WT083mhMq56h+uuM1oCmHW8Q/B26PNplhEif8FsEHIrTI1OWzmjKV0QZjKzezQCwg+ojjQAk4rrrggQREUQc74W2I9CizXW0DW0q6j5vOljTuN5RRM2JajdYyjR0WOYpOrNAiSvV6hcOmjknN7yaFscbUHsqVeCedzy9fxrIZRxmmzL2QJ6swwygDJZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMv4pTjXMidkMaf/FaoWSGztZVahWUQQGtO7wkdW1xQ=;
 b=4lZZM/ETcO1KUDBWgT3EeOYturOr0hhA+++SgrOvjQya93fHvFJ3gPpkpbmuZ4lHKxMRkW/ZyYqEf9lSMCQtbotNBX8FjX/34FqEZeIoQDpnG/ISro8DabsjdUrD1QzmB7iG+U4oYu+OHxxO0E0QSFLYbDDWCzhQV0gP9x5/Mfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1913.namprd12.prod.outlook.com (2603:10b6:3:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 8 Jul
 2022 21:18:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%3]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 21:18:21 +0000
Message-ID: <7fa313f3-3589-f75e-1206-c6cf2971b61d@amd.com>
Date: Fri, 8 Jul 2022 17:18:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdkfd: Process notifier release callback don't
 take mutex
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220707212340.23118-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220707212340.23118-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a4fd42a-1094-49e9-691c-08da612762dc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1913:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SlhLHr1W5tvrMFKFOMnFx31AGOyiPUUz4MnGk7xczwv2lIvJWGX2cbksOQsn6+KrfJ95TLkAU33Zlqo7LCdXLcdZiU6jbJxB3bV2cvkglo9qpWsBnhznY6CLKmNNolStnMl0nr9SWLWCNb0BSaZEcl3Pc1i3Vptqt2Ew8oxP/wDFWk3YSLaoUx2shUqYoFEEjaEuUcYn4JWo0UIz0oS1DO75Au1YFejI0qEzDv5Z9wZcxHmLJ6mHecPew3L4YxtcJKxpxmthD0028nKMU8S+X7QsXKXlJMoruqZZBclqtPQp4jCOv5jVLSvwkJdGlC52LLwt9wxokfZy37eCDfnRRqNd5jAXXxscbO4MnqLao0pu91JJvsKv4JhGut9YV+eApl+DmU5HTTyHQECjiYXtO5n2b67oSqzovlRdtZYTfQWjLOJtQcRB3tPr4Xp+4JJWy8KTYXr2wqSJxls2dw22d5McT9rtM27U5Fttms7cS6cIIltTia4YuT/mKWeJPAYRtdPoPqBP1Np1/qFTH90di8dt557Ssn9bQA8XB3/fOqjTOSwqJa92wkROR1FZ6+eb/7bTYgaUzlc0apf0UoxRDJZ8/jr1yhJajCUuHs0f9y1KXp8ILuDZUc0ADbbJzMCKL9kWXL2TBXEoSRiHBqmeon9EryiTXvPebc9+yVr5fmBJ64uAwqFmcOUQmy00JcoV0T+w+lxl5B0RkA2dM6h/35MY5XPdCAx0aStjHU1pT/becXozbnumFln4XE09L59ovFQ2cqLlwzOq2/iMgPPpcO0qHI5FzbSpWR8rO413+9MMh5GLjKsUaVjzMJzEAOhDmOhhUB1iykNBLMiFZyakOhu2YaztzaKDlzaxgBlkNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(36756003)(86362001)(186003)(31696002)(26005)(2616005)(83380400001)(8936002)(31686004)(53546011)(36916002)(6512007)(41300700001)(38100700002)(66946007)(316002)(5660300002)(478600001)(66476007)(8676002)(6486002)(2906002)(44832011)(6506007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDVlejVvMU1lSFlSK2oxZVkvalE3STdrUXcva3B2OC9nMTREemg0RzM2S2J0?=
 =?utf-8?B?azQ5Y09PSjhvUjhaeUVRUnhNK0Mvdy91KzhmRDhVTVlJeXVsekFkalh3alg4?=
 =?utf-8?B?eVpJU2JQOEZFVHpqRU5zdlRaQ29HWGhGZjdXNEcxNHlqQ2dPN0RnRWhwQTlj?=
 =?utf-8?B?SzN5U0xva1dlMjVLYW1MczJ2VVl2Y0FzUHBjSHJvSU1vOFI2UlBWZWpDWmFH?=
 =?utf-8?B?WUJodTZLWjJoNTZwaDlPMnVPL0N5N0dRUU52ek9YRzlkSmxESWp3UFFLMlBM?=
 =?utf-8?B?cGtrd1lVL2VUanpVeWh5dU5ZUWJibzN2djZQMDNDMkxWcFpSZUNHdXpWNEVK?=
 =?utf-8?B?UlczR2FkNGI5QU5xazRHMlRVUnk4SFJrVldjMDM2MnF1ZUpqTytNL2xsZElD?=
 =?utf-8?B?dytDV1BydXk0TC80dnRtR3hmMFcwcHR4UU5rS1NGMXBLaGlxWmJZeENjZEp5?=
 =?utf-8?B?VFlKWGZtcnRjMEM2bHBCWVNKeUtrUWEwU1ZxQjJ6NHZFNExhWDdKV25RTkRp?=
 =?utf-8?B?dHRsSHB3aFBzeFRSY0UzcC8vdXZxZ0h5ZmlaZjJIa0JEaVR2MXBpWkJYVEMw?=
 =?utf-8?B?WjlxbWowZU5jcTA3LzQ3MHNxVWdsaGsyVGFHRlZrNFRzRFM3TnREZlFIQ25J?=
 =?utf-8?B?dHVLbG1ybnlCR205THJWbFkvcWRMWDltQXBsK2Z1YXhsb2phRjI5bWRyMWRD?=
 =?utf-8?B?V3JTTFJQNVBwU1hHcGZ0eHVzMGdUR3dvQlovdDhHUFRwdzYwNFJnL0QyNGhM?=
 =?utf-8?B?NVVucGdOaTd4b2hLeGF2Ry95TEJjQ3UzbDJNbHU2VVQwRGwxWXJJRThvaFBp?=
 =?utf-8?B?S3A3Z3ZjaGtsTllBMFBnY3hMTy80ZWFPY2JUbE5yditpbHBYL2ZPd3JJK0gv?=
 =?utf-8?B?RE11SGRTS3ppQUpsYkRiRnF3dG80UFdBTElXQURDbnpZWHQyTXBWY3FoSEZD?=
 =?utf-8?B?UkxkVkc0WlVtaHhHd1AzdzNmcnNJWXBtVS9kSlRMQnFDeXhPTmVRVzdWMHB5?=
 =?utf-8?B?emhEMHE0ME8yWDd3OHBReTNEdnRhVEpZdkZZWWdaMVh6c0x0azhNSVl3eGhC?=
 =?utf-8?B?ZUNtclZIUHdBVGJ6aVNYQW1HSmVlR2s1NDlpeUNxcnFGV3NacWdoeG8vTGFq?=
 =?utf-8?B?OUl4dUlwSC8weVlWWnZHbUh5OFB3bEowMEJqc2VEbTdWd05Pd3hBQWZpdTU3?=
 =?utf-8?B?UzQvamp3cysrbjA4M3I3SWVIY3VHc1ZIeDJvS3N3ZTdzZDBBRmtFUUxjU3Fv?=
 =?utf-8?B?T0E5ZCtaMXdYZCs1Q0l4aGJYeVUwaW9DY3B3Mk1sTFo3SGFMYjMyZjhnRTdy?=
 =?utf-8?B?a0pOYS9ML25xNVBNL3RwdGlxcGJNSjhVbmxLYUdJUFNTVnZEL2VZSVVGZVE2?=
 =?utf-8?B?L2ZvdGpHRWo4ekY5R2sxTnBpaWR5eWp5azV6a0VVU1VwbnhqSWZ1Wm1Dclh2?=
 =?utf-8?B?ZWlOTlRpc3QxY0toNzlMSzFONnNuMzhyaVVPc3JEUnZTejBOUDFaOVNlblBN?=
 =?utf-8?B?V2QvVlA4MGdFZHd4UHM3UXUvVVYvZ0oxbXdoV1JvQ2NPUzFoOFRxT3hZWVVk?=
 =?utf-8?B?aWxCT0hRcXNBV2g1SVlsMzNlU21oUitRbHVqWndHMDA5dTRvbExGYTg4TlZk?=
 =?utf-8?B?Tkc3KzlUbjJLREdpVTVvMWk1STJMQlVLblZVZ2xHUXFTVitSeG13akhld3Iv?=
 =?utf-8?B?ektlNTE5MURWV3lRc1lHODYrZFd2d0xrY3ZobndqYWxvK1lIbGNna25vcmtl?=
 =?utf-8?B?QVBMem0wZS9iNlcyTU9zSWJCQXVlYzNPMk1TZHIrMDdKM0hEdzZ2L0gyZThz?=
 =?utf-8?B?OUZJQzNWZStvSVFBQ1hOV3V3dEdFK2pOcWxQUEFlcTF5V3FNM1FOZmNKdWls?=
 =?utf-8?B?bTdpbjZ5NWNISmsvQ2x1bXZDY1RYeHdwald5VlFYbDRpNFJPeDJ3Q2FoeEFa?=
 =?utf-8?B?WDlaMmMrcWx2QmNTZzZ0NCtWbE1LZTRrODN3eFY5TEVobjUvVzNGb1JveTlk?=
 =?utf-8?B?anVQN0tyWU0xVUZSdUo2Um14OUlqZWZDNkQ5Tkl5Vys3MkdYcEI2QU5idUUy?=
 =?utf-8?B?VXFxL04yVTZiTXR2bnpFS2NJOFpYb3E4L3NHMTBnZkc2YXU0UW02RXVlUklp?=
 =?utf-8?Q?4KNPThXE8FVfws/+jzjA+mYIb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4fd42a-1094-49e9-691c-08da612762dc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 21:18:21.7670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHEdVtm46vmOhqLzoZLn0mlIoy0WoV85dKLRqVlpF67K/3kZmGmY3zDNIxqQ5ou9L96wWlQupLIa5E0TNBIdVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1913
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

I think this could also be fixed by not taking the process_info lock in 
svm_range_restore_work and svm_range_set_attr. I'm not even sure why 
we're taking this lock in the SVM code. I think that was copied from the 
restore workers in amdgpu_amdkfd_gpuvm.c because there it's used to 
protect the BO lists. But I think in the case of SVM, the equivalent 
lists are protected by the svms->lock.

Regards,
   Felix


On 2022-07-07 17:23, Philip Yang wrote:
> Move process queues cleanup to deferred work kfd_process_wq_release, to
> avoid potential deadlock circular locking warning:
>
>   WARNING: possible circular locking dependency detected
>                 the existing dependency chain (in reverse order) is:
>        -> #2
>          ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}:
>          __flush_work+0x343/0x4a0
>          svm_range_list_lock_and_flush_work+0x39/0xc0
>          svm_range_set_attr+0xe8/0x1080 [amdgpu]
>          kfd_ioctl+0x19b/0x600 [amdgpu]
>          __x64_sys_ioctl+0x81/0xb0
>          do_syscall_64+0x34/0x80
>          entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>        -> #1 (&info->lock#2){+.+.}-{3:3}:
>          __mutex_lock+0xa4/0x940
>          amdgpu_amdkfd_gpuvm_acquire_process_vm+0x2e3/0x590
>          kfd_process_device_init_vm+0x61/0x200 [amdgpu]
>          kfd_ioctl_acquire_vm+0x83/0xb0 [amdgpu]
>          kfd_ioctl+0x19b/0x600 [amdgpu]
>          __x64_sys_ioctl+0x81/0xb0
>          do_syscall_64+0x34/0x80
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>        -> #0 (&process->mutex){+.+.}-{3:3}:
>          __lock_acquire+0x1365/0x23d0
>          lock_acquire+0xc9/0x2e0
>          __mutex_lock+0xa4/0x940
>          kfd_process_notifier_release+0x96/0xe0 [amdgpu]
>          __mmu_notifier_release+0x94/0x210
>          exit_mmap+0x35/0x1f0
>          mmput+0x63/0x120
>          svm_range_deferred_list_work+0x177/0x2c0 [amdgpu]
>          process_one_work+0x2a4/0x600
>          worker_thread+0x39/0x3e0
>          kthread+0x16d/0x1a0
>
>    Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>          ----                    ----
>     lock((work_completion)(&svms->deferred_list_work));
>                                  lock(&info->lock#2);
>               lock((work_completion)(&svms->deferred_list_work));
>     lock(&process->mutex);
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index fc38a4d81420..3c9cf9bdb63f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1115,6 +1115,15 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	struct kfd_process *p = container_of(work, struct kfd_process,
>   					     release_work);
>   
> +	kfd_process_dequeue_from_all_devices(p);
> +	pqm_uninit(&p->pqm);
> +
> +	/* Signal the eviction fence after user mode queues are
> +	 * destroyed. This allows any BOs to be freed without
> +	 * triggering pointless evictions or waiting for fences.
> +	 */
> +	dma_fence_signal(p->ef);
> +
>   	kfd_process_remove_sysfs(p);
>   	kfd_iommu_unbind_process(p);
>   
> @@ -1179,20 +1188,8 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
>   	cancel_delayed_work_sync(&p->eviction_work);
>   	cancel_delayed_work_sync(&p->restore_work);
>   
> -	mutex_lock(&p->mutex);
> -
> -	kfd_process_dequeue_from_all_devices(p);
> -	pqm_uninit(&p->pqm);
> -
>   	/* Indicate to other users that MM is no longer valid */
>   	p->mm = NULL;
> -	/* Signal the eviction fence after user mode queues are
> -	 * destroyed. This allows any BOs to be freed without
> -	 * triggering pointless evictions or waiting for fences.
> -	 */
> -	dma_fence_signal(p->ef);
> -
> -	mutex_unlock(&p->mutex);
>   
>   	mmu_notifier_put(&p->mmu_notifier);
>   }
