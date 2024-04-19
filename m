Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2706CC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 19:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93BC9112063;
	Fri, 19 Apr 2024 19:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oO9LtcLE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD31112063
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 19:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2UueQvw1WhG4JP5B+vlD9+8W1s/c5pv0HEfUOCAqIJ3nC3SpZlLMov7BiWRuh6yAuiMTB+lunA3JolwXpIE6pDaTaPfp4Re5wrc54rWAcHka7J+n+yLI1VkA1cRMIKK2qhvp4K7AORi18SRqDp20/N9RzTLxQNK3Fi8/dVO+io8bK+oFuvVhZIQwwy+6NlUrqk4g+tpKLimF3l1QLVM+ieoBRjnk0xBLfBO+1AuryQmrVWHsf3dA4+pXbUrXYcXrOd545GcuQgrVlfVix2UMl+2Jb+h3CDK5BQEA0q4Pjwj8rNdTOiuI/upibGhB1Rbexatvtdiat7ELE0vn/zqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViZoXTVKtfeq/tOHncSYRpnq1r3S9n8dDeDNd9Egb4k=;
 b=R/CgIjMbUq4DOjJgMh8Xn5RGBJaig/0axHDFjv/apcId0eciygwr+MPO7osE+TMy25kaLCANOwxXukg29dXTTBO3D8mIcqMfk+VpaT9oMEsOzKdeVm9Zm/cqv6mJ6X/3c9ONZbYjxvbmAH5e8z5nQOR1JhYaAEVWsiMRVKvbqP7w2DUwVoSabM+yVxv0x8MbJSW4pg55sgQuzlcTG/LXyUcso5bE3+nfots0+hbr/mgeYGIpuLwW/l2w9aCIdFSp3AIWf37juOq6VnqHw3rIwXQRzYhydOSThd1CxBXFTT+QOC5IUCGl/L3pgyb7SY7Yyl4sLOX6XWX6NAK6vyguUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViZoXTVKtfeq/tOHncSYRpnq1r3S9n8dDeDNd9Egb4k=;
 b=oO9LtcLEyC20rj6P6JlIcprJb3h8FG8JnxB1h5tL8VkbTB6pn/hOSA5pVBx0P6Schq4vr/IL7QBBUov/6/yA0iJd9duEowuELjQ65ADEysr4N8syGcLRAwUwmNB3PJEmIkNNumlAKWEmY+HNA5EOyt9uCf/z6OYOEsOuF+M0bcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 19:45:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 19:45:36 +0000
Message-ID: <fcce5810-6599-486f-ae5c-7916b0bda5d9@amd.com>
Date: Fri, 19 Apr 2024 15:45:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Add VRAM accounting for SVM migration
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240419162350.1284651-1-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240419162350.1284651-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: a2173901-9a8c-4a19-37ad-08dc60a94844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+LAH9qPgtjs9F5dyNQAgv5qxo0G6H9qBSGGRZHXsv4+e5y4GXuO4H9g9G0cPdhfLeW/weF1P6IzV2k/FvEON/s1iGMNdmMHsFYDK9Tk/TyBkkNoxfacZEO1hi/lrs7Jb0Czh4Z9+pjo2OG9dvTAABy5HHuHTSilQ5cKQE1NVW+LUj7Oa1g6SkQn1KNUJCS7TEM7e07gaoUm1z09AkTkqmeGQOgc64t2Z4+lLmfXZFtBmzsGijbXKKbMv9PT7S7tROgZoLSSJuyGBvkwJDtMB8Of/h9KEX/C0OtE5ICqbfgrR2VmO6R4F0/f+zznNEMxj2ZY3rJoZZ530WOaUpFdNUNWVaAbtdoQah70xF6KtH8ZtXuotyvltbivrQUhVNtwJSPpC9fdnGjFhW7bcuXlPsi/0SwH81tjBopzPIwivUxYHgWuwimMXCMAB1/CHBnvt203T21WS6FyCB9G4267mApIbTXjlkmXxcIzUTH/aQuwPSW6vzNBWdUzr/56gugMyDGIvFl//8/Nv2ZE95k7YogSV7YYOuMBtvXlmCP4H2u5gf4CeX6UNzCAZGKv+/oX2BpUNLJCet/goWyq/DoRqFWom92toh7s6e0vIUD7nJlF5k/zycV9/5drkp2+vJeh+XhuIjyZ9PuUj3QtDeZXENov9c8FYbSgZ/v/C4Y7SKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akdrY1ZXSDFlbTNvQ2tYQUFlKzRDc0ZYUXpvbFhsNG9wbi8vQlFZTTY1ZThz?=
 =?utf-8?B?M3loU0xXN3VzSUovdXdYL29LQXZuTjdsT013UmJvVUpjdWI3aFc0Nm9lQXZq?=
 =?utf-8?B?NXJYR1F4akNySTg1cGhyVXloclp1dU9NelZsVzJnSDdGakhZOFFNZVFucFRN?=
 =?utf-8?B?Y243NHk3VmN5NmQrOG9BWk9mQ2dhSk5UNUtmYjAzajFNSHF3bGFYdzRyM2RD?=
 =?utf-8?B?dVRXem5TZ0NqOE9XMzVmMXd5U0hGdUFpdUg0VXdzcE9tUDlzYVREN3NtQzVY?=
 =?utf-8?B?eUlxaDZoaURMZGJaSkN4bGUzVWtXT2I0RmRSU3RETXRrRi9ZTWNtMnZVcjdu?=
 =?utf-8?B?Y2ZQcFA1WURTYVd0RCtrVDdwUzJCc3JPaVgwVGpIRFVCK25sbHdEN2ZTRE1H?=
 =?utf-8?B?K3VSd2pBeEtZV1UwbDEvRXcxbU5PMlhNZjR2UVdyQkV4Y2k5REd5NmI2a2NX?=
 =?utf-8?B?amtMaE45SmJ3c2N4Y3dHMmxLcmQzUHdjTjkxR3J3ajRXbFJTcHVRV010UWtt?=
 =?utf-8?B?M0MyNlMrUDJaQ0YxYXJOVVBQaG9ZWVZjQWpXeU5yallLdTR2TVFZQ2llczJU?=
 =?utf-8?B?S2M3a1dnNHFoN0FMRExTMmxsYVVZSTU4QWlmTnh4aGN2T3R0eStneWxzYlpK?=
 =?utf-8?B?RHhFTzZpZlh3NzIwTHpVLzNuTVJ0aHR1U3l4a2g3RlkycG9oSU5lQnBRSmx0?=
 =?utf-8?B?UldSTEh1VjNHZW5vLzRQWjhpZGF6WCtFK042ZFd0RkMyTmlaQ2owbGRQd3hF?=
 =?utf-8?B?cmZtTndGVUlGL3VRY1NCM1pVczU4MFdWUTYyb2lTa0FBZzhrNVBGRWg4M2ZY?=
 =?utf-8?B?MEVSWjB4Z0dZUnJxNzdXNmhodGdXZW9PU2pnUzBSUkRKcG1PcEVuVWoyVk9O?=
 =?utf-8?B?b25QSldMWng0bHV3a0JYZGtuMnNpUzRSeGFEa2k4elhiYXZYdUVUQzJPNXRL?=
 =?utf-8?B?MjE3cW53ZDJSdjJiT3lWMTgvaEZLN0lkMlRtVlRZdHZ3TkVMRFVOZkZCcTFu?=
 =?utf-8?B?UmRKYy9wSEpCQVdZeHVjejM4cStIdzBZYWxybGN6R0FxeUJ4OXpaaTk3QWNL?=
 =?utf-8?B?N045ampQRUZJVmY2MnVmY3VGdFFFVFAra1lrdWVJSHZTU2hSRkxtOU00MS90?=
 =?utf-8?B?alo2YUdPRjM5T0lqd0txVndxQi9VcWhKZTJ0R3Z5OHFYdUhkNmNlU0l5aXBF?=
 =?utf-8?B?Q05MOG1SazZzVVUyK08xeDZnd2lYM3U1VEVLSEVTdDhlZVp4V054eVF3cDRk?=
 =?utf-8?B?UkxsbmpVejUyem84ek85dVIrWC9rVVhkQjVIT3lKVjl2b1JwOVlYR0UzTDg1?=
 =?utf-8?B?K2cwRk5tNUF5MlVZUDRWcG5icmxSMllvdzFtZlJqaW1kb0pVSVVXZ2hiL0M4?=
 =?utf-8?B?TmZhWWtnMm5aaGFBMEZReWJwQWpQKytFREJZRXRGKzRkeGdrbXo5bDY3WTNh?=
 =?utf-8?B?TjFwcjdvYldDeDRCdnVkZllnM1VnUklHdHVJMkJNNUdORnIvUEpWTUdFZ2Ex?=
 =?utf-8?B?a3lDbGxqTnVTSGdWZ1lrUEo5QjRxZnNjUGloditFNkFyc3laV1V3Q1Q5aEdC?=
 =?utf-8?B?a0FnUmNoakFnVFU4NkVhOVEzV0p2QnBCSjhyMjFQRzQzMnd6WGVGQm9vMjZk?=
 =?utf-8?B?aW5leitYUjZXNlhyd3ZyQWkrdlFaSGlaVTVKR2pZbzNvTWtydVpncHB1R0FV?=
 =?utf-8?B?N0ZCcnJJaGFFZzBPSnMvdUFpcHdzQXh1ZkVMS2U4MTRzd2NwUzduRTF5UHhC?=
 =?utf-8?B?MFJrSWdLVS9xWmdkWjNUeGFqeEdjbWtsQU53MmQ5dU9TK2dnUU5iMVMyOFFp?=
 =?utf-8?B?OGx1QUpKbXJBQzJQSktZWG1yZmNzcGlWSHNRRGUrN1pRQTRqSnd2SlVBWHg2?=
 =?utf-8?B?Q0Z3UjdXRUhYYy9JS205SkoxYlVrcml5aXRjT0xXcXNLcEdwdnpQVzZVK0lH?=
 =?utf-8?B?S2FPN0hiTE0vSWVtbmdMNkFqbnYrSFh4aFQ5NW0zMFJHcm1Lei8yZitpb09S?=
 =?utf-8?B?YmllMGNVWjlPZ1Y0MFZ6ejdKczEyVk9pc1ZQV3c0WDRFMU1BTjdyWnNoRlUx?=
 =?utf-8?B?ZWhPcFVJZVVocncvaFVvbXp5N25QQUdEZ3pNZW1oOTM0Nm1HNFR6UzQ0QVlJ?=
 =?utf-8?Q?pAMGhaH+z7eW9hf333n9HuR5c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2173901-9a8c-4a19-37ad-08dc60a94844
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 19:45:36.6311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7/gv9pIrvwIM/TfcXhEc4IHw29koBji06TxIr9LNgbZQPhpuzfVqBYMJEyXxykmwLy/YuKmPWeFgZXgoWifQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
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

On 2024-04-19 12:23, Mukul Joshi wrote:
> Do VRAM accounting when doing migrations to vram to make sure
> there is enough available VRAM and migrating to VRAM doesn't evict
> other possible non-unified memory BOs. If migrating to VRAM fails,
> driver can fall back to using system memory seamlessly.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 16 +++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  2 +-
>   2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index bdc01ca9609a..a6bfc00c0310 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -509,10 +509,19 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	start = start_mgr << PAGE_SHIFT;
>   	end = (last_mgr + 1) << PAGE_SHIFT;
>   
> +	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
> +					prange->npages * PAGE_SIZE,
> +					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +					node->xcp ? node->xcp->id : 0);
> +	if (r) {
> +		dev_dbg(node->adev->dev, "failed to allocate VRAM, size exceeds VRAM limit\n", r);
> +		return -ENOSPC;
> +	}
> +
>   	r = svm_range_vram_node_new(node, prange, true);
>   	if (r) {
>   		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
> -		return r;
> +		goto out;
>   	}
>   	ttm_res_offset = (start_mgr - prange->start + prange->offset) << PAGE_SHIFT;
>   
> @@ -545,6 +554,11 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   		svm_range_vram_node_free(prange);
>   	}
>   
> +out:
> +	amdgpu_amdkfd_unreserve_mem_limit(node->adev,
> +					prange->npages * PAGE_SIZE,
> +					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +					node->xcp ? node->xcp->id : 0);
>   	return r < 0 ? r : 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f7d75b432cc6..bfab16b43fec 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3426,7 +3426,7 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
>   				mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>   	*migrated = !r;
>   
> -	return r;
> +	return 0;
>   }
>   
>   int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
