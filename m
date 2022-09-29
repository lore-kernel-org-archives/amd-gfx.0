Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99312C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 18:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FCF910EBB4;
	Thu, 29 Sep 2022 18:00:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C8A10EBB4
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 18:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca4h62LM5GO9hZRwrhKkVt6h1pxg7T4lEEjnTQNrqkMp3S+Fk6ys0/5pAQtOl/Y904vIhorhoDgxvVhTW1gja1OTWm8c6h5r8gtmx7Rgc7qslj8QdyWeCbiJ6gfa1qS0saLg2Pqt+d3/ZmWJe2veCu347PW49ZCfRPYKSluIHF02UQEGQVQYcuRJhmSyysrvKnGGz3H0gD6Z5LUD3cWIsjyvOSPwIQKCY5VUf3a2WTs08tRMuBYU9pGAgM9ii8CI2lERZ4FWpUmRXT/BuU/JMXPO6Nz01JoNzG2au5IRIlFfqpZB+mLdwLEEVXlXwzZXVFd84CCWHKwQs15EFBCOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h0BCuJ0CXkW8n/CiDucRz1EjhUCXxxsAXkG30rL8/k=;
 b=d7oGZSS65OM7q49PLk9dDttCgq2a53KFA8LKHZNwwgKl98MXxyRmDiJuf+1WTJoGqdyMs6w3wA6BKOdGSto4MuW4rainSB5MzCymazgz8SVs2MwQvLG/m2inlFidj8UL3u1+a6QfnctHGbLztmfmnvyDd+cRB2FFALuf2fnvTxYdJHMpXW0hr2jCkaB6LEdfRBIk7d/8WaZko5z8akaAfAaDEiq+C0Bl/APJsN7PJsIEjtVCgcexGsWmUERf3g79kbW3YO3gr4rCGWOPt9YAbl76GxR3Idw91Hz4/aZUwPEurKYIKiU/dKjqRupQGgVbiaUa2Zlij3LGbph+Cuh38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h0BCuJ0CXkW8n/CiDucRz1EjhUCXxxsAXkG30rL8/k=;
 b=w8rUwc76HiqZeD8nnwQcDX8mshE/Vovwi/6SnTgTPxm9JgiRWvI1k6o3R6IODm7y+QfrIa1prVgcxFCUjiIx7jFVwwOabF31z1uotXFx6RnsMmZhPhNT7oI3eppSHBSbOWGtuCOnGUtKEGxfGM5GYdlYlCO0nZm5dk0IgqgENDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.22; Thu, 29 Sep
 2022 18:00:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 18:00:31 +0000
Message-ID: <f14b070f-4ab8-7403-9c48-f9951708ecce@amd.com>
Date: Thu, 29 Sep 2022 14:00:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 1/1] drm/amdkfd: Track unified memory when switching
 xnack mode
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220929164712.26962-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220929164712.26962-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: 526bc6c7-421b-4b07-0d49-08daa2448010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7gOET1mkk1bbTE1SxQwByvtW/io5DWMKVNg5qbLOP/w+cZZC17XEitRZWF1t+u0JOUzPi/ylhFydkviqUSta388MB8cMclLXh8cicNmS9wCwyECtaBpVFxGl0/iCJb9PWpRgZm3BHw4fNSHQFZsnXgf/NWLfxo/KDAdsYJ3yB7O/tZTxKBYc50hS4H0KJfh1rPDYZ6BtK5ab5Z1v+0cHFu/FSKr3JTxp60Dvjv2t8GWG8Ok/7YFFzOtGeFQz58RrHQMyvWccMnhtm6EyytA3c09wc8RKHQCZPbZX8XxF/yK4oSrUP/6uaQrFtIyKkb4ZwYT6JXSMBqwcwzQ9Vm4qK88X8V94Td8kY7HVsLLjZ4Gs0diA4KAu5l+/jaVQz1EeH5B8zIZcYYTKNq2EilkJgLbJPTS3jUOmc5fPyulap8xQkGdYkxnGI8zrNg+ntymDFR1NG19VqtfArAaRbiicHcPyWiEld+1iRuKmYXEeOTkzJKFhD9/ejV6oTAbDFZeivo0LgOsfwESRHfIZA+k04gnJ81uePOjNl21E53JR6v7bPM87AaI4JTiGAEqhrUFfhRgAgSwcIZAOoUR7SPHqN6eiHyLXB9fPMb4JAsWRFnOdhgkxJBHR6JwZjKtTCPAwiYEi8swQcB5RgibqdI4Nrxydx2JBQGmZZnL17ryzDwz5d3FJ5w3qv62aYV0HNQYrTCeZPjHJEpNwlKs3V0o4gWJu6sQyaZlkzn0DLTyoLP2rN354/y33Mg8o9EQ016HKwkjLGHg+JjppBG/jAB8bmfTjqM3lb05YO6eUeRKoyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(6506007)(53546011)(26005)(186003)(2616005)(6512007)(66476007)(66556008)(66946007)(44832011)(8676002)(6486002)(36756003)(36916002)(5660300002)(478600001)(38100700002)(31696002)(41300700001)(86362001)(8936002)(2906002)(83380400001)(31686004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW5wT3d1ejQ3K3p6RmVWQU1NVy9Pbm5iNzEwZWc1d25ONVFrS1U1eTJrV3g1?=
 =?utf-8?B?a0xKRHZtallFZHdndkNGT2xtaTVUMUZBelZ0OXJ5Z0Z5Vk55ZjU5ek8xMzRK?=
 =?utf-8?B?dnVCWWIwVERXell6QWQwRTl4UjRMbDZoN1JSc2xLcmN5SU5xQTZZb0Q0NXdj?=
 =?utf-8?B?bzAvb2dGWlE2SXI0bVl4dWtLaDlLTWx1SGhyaTZVZTUwY3pwcVdWa0YxbTFU?=
 =?utf-8?B?S1EvU3lvaDhaNFRxTDBQTys4Tm16ZC85WmwwYUROOVJCYTRFQVpQZkllN3Mv?=
 =?utf-8?B?eEtQK05DbzBkSmp3ak1Vb00ySkdPRExkOUxpOHVNVlFtTHkyVlY0Q2twaGtw?=
 =?utf-8?B?cExQeGRUSGtrRklERGh5aTlJeDE1alZHMWFKUmlmWVA0ZlBBYXExS2VLY0VR?=
 =?utf-8?B?ZDg3eGxMdXRXSGcySDdpYUtRZENENk5Bd1B4Q1VZS0JrWVQ2akUwRlFhUmg0?=
 =?utf-8?B?Smo2c3BraDFtNXJpSFhlZXA1VWNObmE5NFBNUHM3eFNyTWxJMS9FU0p2cyt6?=
 =?utf-8?B?YlFwM2h1R2RhWHRnTFkrbW4raVZsVUFHNkl6RjZBQk1uVVdLT1pvMEdmOUJ1?=
 =?utf-8?B?WXBwZkZSTk00OUw0elBtcG9RdldlQ3VvbmdILzJybGNkbEJxbThyQ1dhbThV?=
 =?utf-8?B?bTFHREFFZTNjTXJVWmhUdzVvSEprUUpLUyttamE2OVRFaGgvemQreXB4S1JF?=
 =?utf-8?B?cithZzREd2ZLSHlMVUNlVDF1TlFid0I0a1hkakkzQ3FwaFROenBoOGhxa1g1?=
 =?utf-8?B?Zk5ORW0rclNjYjk0WjdFTWJRQ2tFVGxjZTdUbVRwM0ppdGhPRzB3UG1USFUw?=
 =?utf-8?B?VEZVNGEvSVg2OFQ3VmRmcGh0TVRJOXBpU0xlL3ZqTFNRVFVHQnllUEpQS1FP?=
 =?utf-8?B?TDZDUmZEY1F2RS9xZ04waXVPeHB4ZUFsZC9wRG9nZG85Vm9BcWxIajhOVnNs?=
 =?utf-8?B?bE81dDFrRzdIQzlpRE9IdXV6UkNValY5cEZsZTZRNTVkOURlQ0N6Q3RxRU9l?=
 =?utf-8?B?L0dqY1JaWFlUdTlCam1zNXpXODRaWUhmQVl2M0RVQ3kvT1AwMzN2aFhnWDl1?=
 =?utf-8?B?NWU2bUgxOVZaNERtOE45Z3YrcXMxV3J2b2ZRb0NISDZFcGEzMERWZlRjQUp5?=
 =?utf-8?B?ZHNBcVFac2Mvd0lEaFRuT3pmQkJMVU04aWErLzFHTlVQRm1PNCsvNkU2cG5v?=
 =?utf-8?B?c05hZG12SGdmTUVUQ3lJTXNzYkdHdldYc3BIc3ViaEdMYm5JNmxqSUlYWHZ3?=
 =?utf-8?B?eUR6UEVEdjMzbldabWs3a0EwSXg3V2RpdjFNcmlGL3FUdmtyM3pzdzBoQWNB?=
 =?utf-8?B?Mm1mbHh6NGE5RkdBWldWRlIwRVh4RmFhdFQ1c0txSE9BQTRHUVp3ckF0amtO?=
 =?utf-8?B?a2RZSDZZTk9seE0zcGRFeUhxK0VSM0NvVXFMZXhvY0tqZkJhOXlwbGVZRlE5?=
 =?utf-8?B?Rzh3ZjhlM2RJd0MybTg1Y3BHei8zWFhxenpZdzY3ZEZOS1QyRVlsbE1mbGR3?=
 =?utf-8?B?bFZlZ3E3UWc3Z1RDRUFSbjlVZFpvYmNSdEN3VlFUWnFLbEpZTjlkSzBFRktW?=
 =?utf-8?B?azVtV0t4cXFDRzZSdlM5azZpd1ZWbHA1cnZPc0twTy9Dc08yUlF5SXBFMHJF?=
 =?utf-8?B?ZjZLSDRwU0xuZWhpSExjRW1oZHRGZFNQbTcxZVFDSCt0TG5EbWlVWTBpZUZm?=
 =?utf-8?B?cWxvU0M3NU1BRU5aL0Y4SnkzQ1F4Qnh0MmZLeUkwMjFITjVpY1FsUy9LcDc4?=
 =?utf-8?B?N2NITi9GMlZxM1UyUHBVeFFLeHROV2F3dGxDV20yZFF2Y3NDS25ScUZiMmFw?=
 =?utf-8?B?WWFNeEsrcXJpTjFuS1FOYkdwVUhrRzAwZEF4Q29RWlFLT1dvL0FrVStGb29V?=
 =?utf-8?B?cGUvLzJMM3N0VlE5NjB2UkozWnJGYWpGMStsd2pzRWIrZEQxbFlvdGtpRmhq?=
 =?utf-8?B?WnVoRm9BY1Byd2wxd2swcmZZTmFHcDNzVkFjYkZuSXNwZDhZY04wZDhocjUw?=
 =?utf-8?B?ZFFRdDIrWXNaWW1wcVZOUmRNdkthZzFWTjYzUGdXaStsdUFXeHpZUGZqY3Jl?=
 =?utf-8?B?OXdOenZ4Z25iMmVaMzlFVWVnUlBNcE1EbUpENy9qSnJDbjc0aTdSVWJRRElH?=
 =?utf-8?Q?Isie284UJQm3nU6s2KB5JT9qs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526bc6c7-421b-4b07-0d49-08daa2448010
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 18:00:31.8232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATe6k7neenwk9vxaeL+EEMuKMtotfcvs+JO0nUZ4CHXCiEqch8aXsBWW7DBoFds1ET49Sjc05168zpkWgL0YFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
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

On 2022-09-29 12:47, Philip Yang wrote:
> Unified memory usage with xnack off is tracked to avoid oversubscribe
> system memory, with xnack on, we don't track unified memory usage to
> allow memory oversubscribe. When switching xnack mode from off to on,
> subsequent free ranges allocated with xnack off will not unreserve
> memory. When switching xnack mode from on to off, subsequent free ranges
> allocated with xnack on will unreserve memory. Both cases cause memory
> accounting unbalanced.
>
> When switching xnack mode from on to off, need reserve already allocated
> svm range memory. When switching xnack mode from off to on, need
> unreserve already allocated svm range memory.
>
> v6: Take prange lock to access range child list
> v5: Handle prange child ranges
> v4: Handle reservation memory failure
> v3: Handle switching xnack mode race with svm_range_deferred_list_work
> v2: Handle both switching xnack from on to off and from off to on cases
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Really Reviewed-by me this time. Feel free to submit to 
amd-staging-drm-next.

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 +++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 60 +++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
>   3 files changed, 80 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 56f7307c21d2..5feaba6a77de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1584,6 +1584,8 @@ static int kfd_ioctl_smi_events(struct file *filep,
>   	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>   }
>   
> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> +
>   static int kfd_ioctl_set_xnack_mode(struct file *filep,
>   				    struct kfd_process *p, void *data)
>   {
> @@ -1594,22 +1596,29 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
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
> +		r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
>   	} else {
>   		args->xnack_enabled = p->xnack_enabled;
>   	}
> +
> +out_unlock:
>   	mutex_unlock(&p->mutex);
>   
>   	return r;
>   }
>   
> -#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   {
>   	struct kfd_ioctl_svm_args *args = data;
> @@ -1629,6 +1638,11 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   	return r;
>   }
>   #else
> +static int kfd_ioctl_set_xnack_mode(struct file *filep,
> +				    struct kfd_process *p, void *data)
> +{
> +	return -EPERM;
> +}
>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   {
>   	return -EPERM;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cf5b4005534c..f5913ba22174 100644
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
> @@ -2956,6 +2956,64 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	return r;
>   }
>   
> +int
> +svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
> +{
> +	struct svm_range *prange, *pchild;
> +	uint64_t reserved_size = 0;
> +	uint64_t size;
> +	int r = 0;
> +
> +	pr_debug("switching xnack from %d to %d\n", p->xnack_enabled, xnack_enabled);
> +
> +	mutex_lock(&p->svms.lock);
> +
> +	list_for_each_entry(prange, &p->svms.list, list) {
> +		svm_range_lock(prange);
> +		list_for_each_entry(pchild, &prange->child_list, child_list) {
> +			size = (pchild->last - pchild->start + 1) << PAGE_SHIFT;
> +			if (xnack_enabled) {
> +				amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +			} else {
> +				r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +				if (r)
> +					goto out_unlock;
> +				reserved_size += size;
> +			}
> +		}
> +
> +		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
> +		if (xnack_enabled) {
> +			amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +		} else {
> +			r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +			if (r)
> +				goto out_unlock;
> +			reserved_size += size;
> +		}
> +out_unlock:
> +		svm_range_unlock(prange);
> +		if (r)
> +			break;
> +	}
> +
> +	if (r)
> +		amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +	else
> +		/* Change xnack mode must be inside svms lock, to avoid race with
> +		 * svm_range_deferred_list_work unreserve memory in parallel.
> +		 */
> +		p->xnack_enabled = xnack_enabled;
> +
> +	mutex_unlock(&p->svms.lock);
> +	return r;
> +}
> +
>   void svm_range_list_fini(struct kfd_process *p)
>   {
>   	struct svm_range *prange;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 012c53729516..7a33b93f9df6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -203,6 +203,7 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>   
>   void svm_range_set_max_pages(struct amdgpu_device *adev);
> +int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled);
>   
>   #else
>   
