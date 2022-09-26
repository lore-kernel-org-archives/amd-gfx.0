Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC4DC6FA86
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 22:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7C010E7DD;
	Mon, 26 Sep 2022 22:16:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3901410E7DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 22:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN0p112B4RtDKBb926Nxs/ZphbW8SvdPyzAdKfbkLQJcWIsHy9yfpMAs0fDwGyPzNJobtUAbAn78Cdt1OSuKz7ViOAk1u5KT/iekfXRrOPyNcP6SwpUsMLyBMuU23LvhPz4O2ghxDVBOmKiYFF0CW5pWGKh/e7/uSABTYnTw80am8aUwrA9OkvbEHCf4xMvu3Z3OYusojRvh+q1e/CnqXcb+avFrOf3ztJ8g+XBo31KO8AqXYcELm+q0M1p41XwSTlHQDpdYMpzn9wPG3S5uz2/KDJ6inRpdyUfGlFatGQF/TuyAlY8ZAfbQNrBPi/zJl/3CLlmcTD63a2L0rARaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLJXzTdKrCkoJZvEXGnZsauNtVKeZXfRSOqbNX+L0PQ=;
 b=EjAqwC+ErH8HWOJd3RInsHawMjzDJQdRtDxOI0EzHRX3mUQTiJ53kQexMs+nQwFZHw3peLaL/Qu0lZMTzvoHhKE3jduOug+WQF6BegPH0HzU882STEb28ctCu4oX4dEjC2H1shiTFoGL1M7fRrGMa++SWgTwY+PPysyqBv+cpauppCKZttjPB9ux5STsS8hGg2wfnTsrCE/OMhcQDiF160FeyN7AERm2gTC6QCLGCwhFRyTMU5HK8mRjubKqh3a12/q8ekshJt7EwSoR3tXCcNBFzJjyZdDX9cOx/G1gePRO+J/VFw0kERwdRjcOEiFAHk0Kk4GxScld3elGVxiS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLJXzTdKrCkoJZvEXGnZsauNtVKeZXfRSOqbNX+L0PQ=;
 b=m9ZZKgwREQXVTsfDXQwzRbOkFZRRVZJ0tssZ7q/UI3f6mhQTXkCrjG0hE0Njo1V+9RwzKE46+AI+CUTQxEzdA5WhJ4VIPMkw81d7JQ0wrDWuRrSxMSt4qafkRjT9WsyenxhH5yIELxFeQGutpSH/OIqPPTzyzERjsPNlQsPr9mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 22:16:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 22:16:01 +0000
Message-ID: <da809310-b313-a0f1-69bc-59288be85ad6@amd.com>
Date: Mon, 26 Sep 2022 18:15:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] drm/amdkfd: Track unified memory when switching
 xnack mode
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926194024.31643-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220926194024.31643-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:610:20::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c77edf-e817-4738-3ebc-08daa00cb231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJh/ulQ34Muzsr3Gyjf71QXGIXlFRsEAVup8GexKorgr5hI/EqIFr4fWEr58AtYflLx55rFVic0qOZmOpBIRIPElqGx3wXUQdUk6Yw7iC4n1FkB3RLA7uvsunWHYbq6RwNKlUPr+MRIYZKZD94HHiADaAP0JhSLyCeU/RrK7olOQAozHS0+gXfasEjzIpS8AII/mi8U/6Cjc+iYRRscYYms6WWm0kKey4v9CqxYVHwgQn28uRuPr1Iv87OZ7QG0h4YbCXk9oeD2DsByI3FB/xnidI4vp7f8pSPKyen7pwv4RFrQ5h+Seq0JTnerMmspP/i2asNBuHDUKdC1y/lNigBEzb29KYGJK1Nv4v6FBUJrc4IMVYKzNdtRpBrz5PuXMSTSQgZ+79+ishKnFCOz7x0YWvAQuZa35pGlwqsVBdCdt5ar0TDRFIIXRDR4vwh9jMUa9fh9OiCfWowlI1LRUSLG112GLJiHzeYONM3pCYtkGPpSpDy7g2gU/iro8pOe1fH2cMbgKloArIAuh5NQW4rRDD/DTd6drtZ5vfodl4TL6duG3Z048gVK+KmzzPM9UDdNOoe1tVUNZXXVobvxosP+nZO8NlWD1cYtWaWVtVuhmqletZ7tKJKY2lGRqUfgaZwrN6XL/26KcJKAhTVQIzPi1Ahh7hjxEdlsfrO4naLY3VO8larALDCnfomP5iVTHZ/nhMB5fuArVLykjCHz4IMcZaYe4oY0pcnYHqWKQgDHHZ+p8WHY8WZ6HbPmyiKqHIuzVgBJiRU4m/5A2zromi7al+BrE4GwkjUAGBFUMJ3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(26005)(316002)(53546011)(6512007)(6506007)(6486002)(86362001)(36916002)(31696002)(83380400001)(44832011)(66476007)(66556008)(8676002)(186003)(5660300002)(66946007)(38100700002)(2906002)(2616005)(478600001)(8936002)(41300700001)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXR2T1FWWkF5cEM1c0h3dWxReEtPTUdoRDIwVm5VWDdHSlBMVGFXbFBxWDBR?=
 =?utf-8?B?STMyQlFJZnoySEU2T0tuNFh5Q2d2N284cnBUYkRDQ3pQTkZaTDdacmVMOFNV?=
 =?utf-8?B?MFBkWHN1cG5KMTU2dXhUUDJ3NnBnNjRVbWtsdDVPWTlGZW9LOW9DODhlTDQw?=
 =?utf-8?B?dWlWTERUQm1pVWNuaVpUSmc5TTJnWXhXVGxqbXdscGpuenlZa25iaFoyanNY?=
 =?utf-8?B?Q2d4bjdCaDh1TjNlZWgvKzU4QTJSbFZ0NEJpaXJTcTM1bHU2U2pZNW1KSXpu?=
 =?utf-8?B?eWdtZTR5T3dlUHVKR0JvTG91VnJ1UjF1aENzNzU5Ni8vMy9YVXpDR2o1NXRj?=
 =?utf-8?B?MFEybytwZUNOQ2hZY0cvQThlQXQ5YnViWmx1Y2FUdEJZUEZjY0d3VEs1bXVW?=
 =?utf-8?B?Vkh0cTRZUHlOZXlGWHJPZWxaZXNGcmNZaHZaNkRFdTVNQ3ptdWJRcmc2dits?=
 =?utf-8?B?cnZFSWE4bHRCRWNaM0Y5SU1lY1FsVm5sVnFYYmY3K3RyZUYxWHY5dmwxQ1Rz?=
 =?utf-8?B?S0ZENGh1L0pnb1lrbHVMekhFQ0ZMOGVMU0lmR3FsQmlxTVd6WDU3KytxRG9u?=
 =?utf-8?B?VnlVT0p1Q0RhWGk5K1FoOFBCSHE3ZVg1YkhSWVp1WGN5SDJ2c3psTkVQb1Jo?=
 =?utf-8?B?Q0RMNmNhaWRMSmxrNUJ3SHF1WVdrR05XUGhMVXJyUCtXVW5hVFJaZzFiLytD?=
 =?utf-8?B?NDhKalJ0RDkrSzJ1OUtRK0NCdm1qY3ZyS0RZUklQNmJuMHo4K2o0MVA0bTdI?=
 =?utf-8?B?K1VKeGxRVUR1eFp4VDZydDlJUloxRll4TmhmN0RoTXhtbUJsYTVraHVQQisz?=
 =?utf-8?B?SzdvVEtMQ2p6MGlRMGFYWW0vTERSSnNDazFhZStoMUl3a1JtcTNvWC9zZ00v?=
 =?utf-8?B?MCtHV1VhaklPUldsOVJvVkhLU1V2MWdjWjkvR1F6NUVNNGxQazBFelZlaU55?=
 =?utf-8?B?aG9zYzdralNka1FFN1pjY25hL3l3KzFwWTcwbjdMNXdvaXB4cFE2QVdkOGNq?=
 =?utf-8?B?QjNsUUFDRFpwNzQ5RUZ5bWNjZllEQzhNRDZIbnFBMEpGVWtURldDNUtXanYw?=
 =?utf-8?B?OWlCWllFWVNCTnl4Rjl0VkZ1SDEvdUljbGdZUUdZb05JMFBSS2ZyZVB1Sm9y?=
 =?utf-8?B?UzcvSi85bFI0L2E1WHlQbEZVZVJuTWdoRGRlM1BpMTFpY09KTjZLZXFNbVBo?=
 =?utf-8?B?L0hpUTU4K1lVS0ZGQU5vQUY5L05vd1dybk05VTBmTG00NXF2ekhLRWhyUkZ4?=
 =?utf-8?B?VmJCZERESU1IMnRvT0pDV3N2bnRSa0ZqMyt6ZTRtMTlOR1A2RE9iUkorR3lv?=
 =?utf-8?B?cHNnUnlIUVRUblUyZGxMNkZFU1pBYUk2b0h0S3VoRG1nSlNxczBBNmFNQVZQ?=
 =?utf-8?B?Vk9pQWdvdzUreTlHREU1VS82aWN6Qzg4M0VKV2Y2VGpRNXFRaWw0bEJ2UFUy?=
 =?utf-8?B?eVRlVEM5Z1FPRmk2UWdVbFNQV0FmT0NkS3NsNTJJdjRaeHFWS2Jsb2ZKVERs?=
 =?utf-8?B?c1ZjR0NQQlVsOTl2dDNtTXFCZ3J3OEVFdTRzSGM2bkVMMFVCRG5oTFZzTWdZ?=
 =?utf-8?B?cFh3UWVlU21Bb1lOQ1ZEYjVOTmhFZExRL1R2bTlDNU40N2Nka3UwbDJPMGZp?=
 =?utf-8?B?ajM2RjFVMFhmY2pLNGNkbDhrVmJWY2NMVWhEVjlCeG95eVljZW01dTF4Q09G?=
 =?utf-8?B?SmoraVhzZ0lmRnlUbEdoaVlVVWdoclB3eW8vU29xczVBcjF6Y1Bad05WV3BS?=
 =?utf-8?B?ZVlYZ0pnOEcrdTZyNEpFNVB0NjVIUzJWU0VjZUw2Zzl5TzloL0Vid2V1OFZk?=
 =?utf-8?B?NzZKaDJvQms2QnduSmtiQWZlTyt5eWRuQTNHcmF4Q0E4RmNKQklhNjRWVzJO?=
 =?utf-8?B?TjVTVmphVnRiUTNaMDJRY1dURXl2VzRxTzZmb3FvaVBVbEpLZWFST21jWTBo?=
 =?utf-8?B?QjNyWWh6blNLa2o0VE9UNHl0bFQ0dkJ0NXBSOFFXMTMzZUpybHlCYnpobXda?=
 =?utf-8?B?MTdidWhNckRIVGZ5dlk4N2hnMmRoQktXR2FLYUdsa25adS9ZQWtyMWRhMUxU?=
 =?utf-8?B?cTRqOTM4SExDcmYvd3JManYyUXVabk8za21EaHhJL0FGRmFXZCtVT1FLTXdu?=
 =?utf-8?Q?NQCv+PT09tIkTCPU4H/D2mrYk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c77edf-e817-4738-3ebc-08daa00cb231
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 22:16:01.7063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gjxs/77a9zBhIuY6mWPPi9nCA7xgD6ra9qjKRpRKn6p7mmCrepj3l377nNWJMELi1M73mlEmXLPMT4Ld2e0dsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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


On 2022-09-26 15:40, Philip Yang wrote:
> Unified memory usage with xnack off is tracked to avoid oversubscribe
> system memory. When switching xnack mode from off to on, subsequent
> free ranges allocated with xnack off will not unreserve memory when
> xnack is on, cause memory accounting unbalanced.

Here you describe half the problem.


>
> When switching xnack mode from on to off, need reserve already allocated
> svm range memory because subsequent free ranges will unreserve memory
> with xnack off.

But here you describe the _other_ half of the solution. That's a bit 
confusing. Maybe state the other half of the problem first and then 
explain the solution that fixes both halves of the problem.


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 30 ++++++++++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 20 +++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 ++
>   3 files changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 56f7307c21d2..938095478707 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1594,16 +1594,36 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
>   	if (args->xnack_enabled >= 0) {
>   		if (!list_empty(&p->pqm.queues)) {
>   			pr_debug("Process has user queues running\n");
> -			mutex_unlock(&p->mutex);
> -			return -EBUSY;
> +			r = -EBUSY;
> +			goto out_unlock;
>   		}
> -		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
> +
> +		if (p->xnack_enabled == args->xnack_enabled)
> +			goto out_unlock;
> +
> +		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
>   			r = -EPERM;
> -		else
> -			p->xnack_enabled = args->xnack_enabled;
> +			goto out_unlock;
> +		}
> +
> +		pr_debug("switching xnack from %d to %d\n", p->xnack_enabled,
> +			 args->xnack_enabled);
> +
> +		mutex_lock(&p->svms.lock);

It would be cleaner to do the locking inside svm_range_list_unreserve_mem.


> +
> +		/* Switching to XNACK on/off, unreserve/reserve memory of all
> +		 * svm ranges. Change xnack must be inside svms lock, to avoid
> +		 * race with svm_range_deferred_list_work unreserve memory.
> +		 */
> +		p->xnack_enabled = args->xnack_enabled;
> +		svm_range_list_unreserve_mem(p, p->xnack_enabled);
> +
> +		mutex_unlock(&p->svms.lock);
>   	} else {
>   		args->xnack_enabled = p->xnack_enabled;
>   	}
> +
> +out_unlock:
>   	mutex_unlock(&p->mutex);
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cf5b4005534c..5a82d5660470 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -278,7 +278,7 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
>   	svm_range_free_dma_mappings(prange);
>   
>   	if (update_mem_usage && !p->xnack_enabled) {
> -		pr_debug("unreserve mem limit: %lld\n", size);
> +		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
>   		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>   					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>   	}
> @@ -2956,6 +2956,24 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	return r;
>   }
>   
> +void svm_range_list_unreserve_mem(struct kfd_process *p, bool unreserve)
> +{
> +	struct svm_range *prange;
> +	uint64_t size;
> +
> +	list_for_each_entry(prange, &p->svms.list, list) {
> +		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
> +		pr_debug("svms 0x%p %s prange 0x%p size 0x%llx\n", &p->svms,
> +			 unreserve ? "unreserve" : "reserve", prange, size);
> +		if (unreserve)
> +			amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +		else
> +			amdgpu_amdkfd_reserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);

You are assuming that this will succeed. If it fails, you will end up 
with unbalanced accounting. You'll need to detect failures and roll back 
any reservations when a failure happens. Then fail the entire XNACK mode 
change.


> +	}
> +}
> +
>   void svm_range_list_fini(struct kfd_process *p)
>   {
>   	struct svm_range *prange;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 012c53729516..05a2135cd56e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -203,10 +203,12 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>   
>   void svm_range_set_max_pages(struct amdgpu_device *adev);
> +void svm_range_list_unreserve_mem(struct kfd_process *p, bool unreserve);
>   
>   #else
>   
>   struct kfd_process;
> +void svm_range_list_unreserve_mem(struct kfd_process *p, bool unreserve) { }

I think it would be cleaner to put the entire kfd_ioctl_set_xnack_mode 
under an #ifdef, similar to kfd_ioctl_svm.

Regards,
   Felix


>   
>   static inline int svm_range_list_init(struct kfd_process *p)
>   {
