Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AB8C6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 18:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 190D010E140;
	Mon, 12 Sep 2022 18:53:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA3810E140
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 18:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvo6hE2iCDORvtVU+pDHHqPrUOP8/P4BQiAJ54hWi2CUHbFVTECsU88o8i5cyZUmhDo0ZXSEXQSpoWDFX19ZuCJ0tkc3Zy2B0GRnIEfYWnK2VRrpS5RgRwqPXy21DH/P+rdkpCcS7TWbym8HSbMnJ7yjwAnEI0/Gj2PU91BNB0FCk7HSJF7GYulRhDxogGaM8civVEIFxlY5zA1PggipVKrGYP+3bjg0Y1fhH0nMyznrGqaDAaCquIAx2psRBilBBWXKDQZd585qwsN1mijbZzovRfUZtl4Q7hXYkX05YGEc7yqOAqVAWucBV93190zW7aJyKZqVS3i//U3xP38HWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhAVSkrPn7ylEsBq98HI1TqpwDJWxLGuGAt2wsmHmJM=;
 b=PUUoNlIfBF7Bx/XrDEPnqBIZubLQrWR+wrvx3Q0EMy1pgvJoXX1/bgiWfBbUoMhTdxx1JFVTTYjSqhk5YSmAGvPTdl/8yy2hY9jCwkU3niFCrgPx38/8NMGm84nu07zDLf+NYpQYlC5j5qY0U6CnJqhTpDLwQbicj+Sm6KvYk1D8joKV+oYG6Sw7FPmgGxcvYvHQxwbKG/Z78WVzD1ppDXZotXt52vRj1Njn45aezwz5HQ90izHvgBBlp8nQU0dp3D+OZ4hEglblG2t2Ee5b6kpSlG7QMAJt64e/y2zInoaI8zLVQ+lh4WLn3R5wgWj+0XLCG+ov4pD4i1A61xMjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhAVSkrPn7ylEsBq98HI1TqpwDJWxLGuGAt2wsmHmJM=;
 b=WRZERbqaI5dwCxY7GBlI4jZJdgwVFsSCsjt0CXK/dokMvSNtnAfxckCuoILM1EhyLpgJpIWP7qD9BVpO3KNPD6tAhnOKfTIN5Y91Vnf+tUsFlYtmcUSB8lLpuGAOcVD1pNu42Cmc1IwICjbJIG5e2yY8c7nnFAlCzmEYqh6TxFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 18:53:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 18:53:41 +0000
Message-ID: <022a8a66-4dfe-4001-96cc-2cd752a81586@amd.com>
Date: Mon, 12 Sep 2022 14:53:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Track unified memory when changing xnack
 mode
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220912180447.19622-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220912180447.19622-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: b681c336-d212-4a7f-b9d3-08da94f01bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqVTS0M4IMvGzvTTzgn6qlYMxNZqG4fU2hnTpFu86NERutqdXYpcA6NRCU1JOW6pjeNnltHoisltNkiO09Jz/YozAcWshTyAhXOvmYk+wF4hKxKDpt2VU7KAA9AnZtrpWNzXWo3YTwaJj2QrpHvHJyYXseElPxDDR3xhCAN7ZUSob1x6gE+B/aarbtd4CIC9U6oH8n7vn21pyeG/sUKroocmbEgeaQnmq84mMXH0cuJtRCRjnyjCh67OY/3B9QcJnnpX4N7YbWqROl6nBWYfKMeTbiHQZd0ZWEspraY3VlUXyBEh7CSzBXuf+5c3j+yGDOIyW8U6EE6uzMPUgf/7wrwTtPz3x/G/RKTTa6cP/fPEaWXRoTLlkNvmXlp45oa32RKg89xlji/QFRUX1Mm7K/a4+EeeKRI4N8JC5djN321fN8HmjoHDenZKis/aYrbK463q7Mr+1je7oQtOgqOdOpHe3Bs6doDfV/uQ0EUJ/xK3M7GpO2mLpdOKgsyxMQq/OElHKJbKdsMYoz0wu1jEe2gwGL2yuvgZ64NOmwy9YpWz/oxQhvCqALy93Plyx++8tDZQBakLFFAR0QTjOWn0noGLsMqC3OelA5uXMHIQYYgXIcbSY95rsV5ExWDNPlyX1HK2c4OycE/zEGEeVjUyTEuIMR+42XlSRAtgS9H6BJ4Exa/vLWkEOgYoFwyTJbU3aXvhe1IbAFxS/BiXltP8BrC7pfmuN40mMPzdbPj1OX9kUm7rLuKh5RoRFjnEX76HB4ZoT1TYyo7Po2DFjU45TfcEnssDPuRN4axRMrSo9FY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(2906002)(6506007)(86362001)(38100700002)(44832011)(26005)(83380400001)(186003)(6512007)(478600001)(66476007)(8936002)(66946007)(31686004)(2616005)(36756003)(8676002)(66556008)(41300700001)(6486002)(5660300002)(31696002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXZER0syd3BZQ0ZROWduWERKYURiWUVzYVU1WmNROVNVMkNIS3ViSUlFRkxk?=
 =?utf-8?B?LzdNOFIyMDd3ZWdWRHVZT3lUbFJ4YkgyZmRMbGFLaFhLQVBVdmwvbk10ZVVD?=
 =?utf-8?B?T3BHaS9ycS9uck96VHh6YnNEa1ZWOFA5T05tNHJPRHVyejFXY3JUL3VSbFhX?=
 =?utf-8?B?OEdrbDU4UUtwcVY0dE84aE95NTRpL1c1d05iNCtsLys1cmFUQ1RzL29BK09R?=
 =?utf-8?B?elRzMHZBWUYxendHcHU1TE5NMngwak5LYUgzNER2V0JYc1FvU0xBS1Y0Y0Zi?=
 =?utf-8?B?WERyVHF0YW5KYmlTOXFROFBXUE1ySXNFS1lXU1BOTHhiSmNxVS9kRjRpWEdE?=
 =?utf-8?B?cUJkWGRZVDVOaC9XSFQ3azY4WmpFMmNYWXFrS045UTI3ampTekZzY0dob2V6?=
 =?utf-8?B?VEx1M3A1aHlOYjZXQ2RPcDhXcjRKNEFxdTBNS20vZit3NjRiVTRhUTNDc2Zx?=
 =?utf-8?B?eW0xTkNzNnZrWU1LWE5hUHd4TTB4SnFreHRUdCtpbk5BQWJPZDR4N1NXRGE0?=
 =?utf-8?B?WENRVEthcWVPT2JPVkRSRUZuT0tlNEN5blQ1OWRaaUp4TFFCcVJDc3hZM24r?=
 =?utf-8?B?QXo5NU9HS3JJQk5yeWFxV3ZaNHJVM1BOc3FXOG9pVkVDVVBNSSs0OHlZWldk?=
 =?utf-8?B?WjdscE1uaFVxTU9oQXM0eFdqUFRqS09vaFBMS0VRcmlwTDhrUDd3WWs0ZXhu?=
 =?utf-8?B?aEFXdEUvZElLcW50akxyR01tNnhtTVpCNWlUNkZFc0Qwc29iMmMxYzVsRVc2?=
 =?utf-8?B?bVhNZlJiZEFVVHdzdUVVRGZXSWdDQ2VEOHBhK2U4cGU2RVYwL2FzdFVKa1pJ?=
 =?utf-8?B?ZDZLcTh5Mys0dVJLY3lUT0dwNU9MVkpyOGI4QlljZDZSZGFSdTJDVzU3L0Vj?=
 =?utf-8?B?LzVodkM4T2VDN1ZvUnp0MktyZXpJOFVaekdLQmlyNHEzYUl1STVaUzAvRE9E?=
 =?utf-8?B?eUsyL3c5ODQvNitnN0xLZFh2aFNISXpmN0V3cjFGSzRDdWZTVUpGM0JTK0Rz?=
 =?utf-8?B?MjB4NTQySmRIRFN2SUtPWmtJdW1ZSlVQbm5jODZRWGRJOEc0bkN6ZXdPWUp3?=
 =?utf-8?B?SjJZOG00Y1RSOEsvd2pZNjZSQ3FZWTN6c0ZCdDkxRVJJN3RMNjRhN2RFeXFu?=
 =?utf-8?B?Zkx0RUdLSE5WdmQ5UDg2K0o2SlZzVTZlNXhDbk9CcHJRREU3UjVsVUh5aXB0?=
 =?utf-8?B?bzFrdFZaVFpkaDlyeUJtWHZyRXBHUEd1dTJ3a3pkU3hPMzZMZVM2UURtYUtD?=
 =?utf-8?B?VjRvRURKQi9IcDg2SHhtRzV2YmVBVHRMa3JkZWtJbmFtSW9PYnRVTE5tMkpr?=
 =?utf-8?B?Vm9qd0Njdi9EVFQ3UXBYRGNJZDhpUnBFOVRjaW5RTkQ0WUdNeFhVSTE3Y2Ra?=
 =?utf-8?B?WW00cVBpcEFtMlEvTFordHVLaWFHbXIrSno0WWwvYkI5eHFBYXRTT0lzcnpD?=
 =?utf-8?B?YVhzMis0dFVmcEFEMFhHSkpCeldVWmtpc1F3M21BQWQyYWM3VENOblFRc3la?=
 =?utf-8?B?WWJpL21SekJ5Z2xBRG1hTW9oTHpIVnE3MUFGS1d1dFpJZk5nbFpMTnpSYW1B?=
 =?utf-8?B?c3laemZIZUVZWWRkc0V4dEpXYVZ6aTkxVnV6NGtqZTJ0eTBJUitmaE9kL0dX?=
 =?utf-8?B?VHM0cEtybUxrNlJucjNUaVpqckxtRVBrTWUwUm5DNEJ3am10OUo3YjFpbjFK?=
 =?utf-8?B?cWd2U0srY09rQTRGazF4b2VxQmxTaHpDREhwTGdwVng3dE84Zjk1NXpnSWEr?=
 =?utf-8?B?bmN5NGFBWlNIUGFqeUxjSE1MVjFXTVFJQ0xzdk8vdVRBQkRDZnkxb25YeG1C?=
 =?utf-8?B?cTd6SENlVXVlbE9Fd1RqWkJyMlRML2pPZkZwZndSenhLbnE1by8zQzlLOHZW?=
 =?utf-8?B?RUxqVmQ2SkpVVm5lZ0o2OENJMzcwSjVQbGdUcitWWktwZ2FyVGFlUmQrVlRa?=
 =?utf-8?B?Y0RveXBOdFNtclFZVk1SeGUwcG9yby94ZVVkQWIxczgwaXlnODRCZW1BVlQr?=
 =?utf-8?B?b3o5bjVWSWRhZERqRVFNTWphMmdUUTBNRGVqZHd1dFAvNDJRS1l4UU1zVk9u?=
 =?utf-8?B?YWNYSFdrWktqTFVlenM2VUZxRUd0MysvTGhCbWZnR2tqT3dLVGh6eXEvSWF6?=
 =?utf-8?Q?T5WIdGgtp4dsWW3kL/8VAzCEX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b681c336-d212-4a7f-b9d3-08da94f01bf2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 18:53:40.9863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcdaPSX3lyotf/rxQA6XWpxMgziaxMNvFr9EvwM4XRPVs2n/JI551bMQGQKel91lwsTrwZaXhnWnkKpitkfMWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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


Am 2022-09-12 um 14:04 schrieb Philip Yang:
> Unified memory usage with xnack off is tracked to avoid oversubscribe
> system memory. When changing xnack mode from off to on, subsequent
> free ranges allocated with xnack off will not unreserve memory because
> xnack is changed to on, cause memory accounting unbalanced.
To you need something equivalent to reserve already allocated memory 
when switching XNACK off?

One more comment inline.


>
> Unreserve memory of the ranges allocated with xnack off when switching
> to xnack on.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 16 ++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 14 ++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +++
>   3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 56f7307c21d2..1855efeeaaa0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1594,16 +1594,28 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
>   	if (args->xnack_enabled >= 0) {
>   		if (!list_empty(&p->pqm.queues)) {
>   			pr_debug("Process has user queues running\n");
> -			mutex_unlock(&p->mutex);
> -			return -EBUSY;
> +			r = -EBUSY;
> +			goto out_unlock;
>   		}
> +
> +		if (p->xnack_enabled == args->xnack_enabled)
> +			goto out_unlock;
> +
>   		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
>   			r = -EPERM;

You should goto out_unlock here. It may not be strictly necessary, but 
it's confusing to think of the cases where you may fall through here 
unexpectedly.

Regards,
   Felix


>   		else
>   			p->xnack_enabled = args->xnack_enabled;
> +
> +		/* Switching to XNACK on, unreserve memory of all ranges
> +		 * allocated with XNACK off.
> +		 */
> +		if (p->xnack_enabled)
> +			svm_range_list_unreserve_mem(p);
>   	} else {
>   		args->xnack_enabled = p->xnack_enabled;
>   	}
> +
> +out_unlock:
>   	mutex_unlock(&p->mutex);
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cf5b4005534c..5c333bacf546 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2956,6 +2956,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	return r;
>   }
>   
> +void svm_range_list_unreserve_mem(struct kfd_process *p)
> +{
> +	struct svm_range *prange;
> +	uint64_t size;
> +
> +	mutex_lock(&p->svms.lock);
> +	list_for_each_entry(prange, &p->svms.list, list) {
> +		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
> +		pr_debug("svms 0x%p size 0x%llx\n", &p->svms, size);
> +		amdgpu_amdkfd_unreserve_mem_limit(NULL, size, KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +	}
> +	mutex_unlock(&p->svms.lock);
> +}
> +
>   void svm_range_list_fini(struct kfd_process *p)
>   {
>   	struct svm_range *prange;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 012c53729516..339f706673c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -203,11 +203,14 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>   
>   void svm_range_set_max_pages(struct amdgpu_device *adev);
> +void svm_range_list_unreserve_mem(struct kfd_process *p);
>   
>   #else
>   
>   struct kfd_process;
>   
> +void svm_range_list_unreserve_mem(struct kfd_process *p) { }
> +
>   static inline int svm_range_list_init(struct kfd_process *p)
>   {
>   	return 0;
