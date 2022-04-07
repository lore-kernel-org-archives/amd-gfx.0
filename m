Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AA0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 17:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020A710EBC5;
	Thu,  7 Apr 2022 17:05:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1813B10EBC5
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 17:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8rQJHXf+TnAP2E6Eh+FOpOtDLlTZQRfVqG/BGHyAZszhA/7ujvqQOIOZ5Q8mv7SgJJ4yUOlPohtGe0T+gJomnUvdeVo5RcAWUyzfhjxve9wJwSA0Z0icuKFqzb/1KUUmN1MIbfWOBsDsiIPlSphyz12Cx2mLmli8cExTwkjx5UnI30vcMr8uuWhRYg+gKVRg1oAIVQRzQ2VbmCkKMvU4xrshUz/SLK79O2zd7xTrKX2Fv0b9tzIhpw0WVruaBFM+pxGb+1s7ioWBJEQ01G7Zv6QI7P++rHm8uDrTVlWg2RosYWXd0fixKQgtypMKDTsmot8vkf+6yWWYQ2zKqryQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nb+NaCNFU2zjWrAA2H8OTQXMM+bfyQWRRQxWdOc4SU=;
 b=k28PJHRuOIhHrAHZwUrw+Bw7Nw86618uCDX5itrR+248SXWNGuacJKDLDtzD3lXiaWy5Y2uU4DVypqhq7+UCIv7r1VGGPsf1KHcCqh4FzWFRpfFvrvWxQpcyUINdt29fqCHc+nCyW/tDWubzuKscwxjgzqq2Vxod2piycOUjD6qOm1CZZ+albs7yzGi5bnCQ6ZTXcfXb/PI5IgxKSCAO3YdSYz/Rr+Oa6zlRWN5jlkfLrXxB4Ll1XhxGjA6BclffKJ2bXhJas/ySnZ32496n5xkcD0q8SbdUJbqGKegwk5LkjycmVsknbEDdqYadKZIEirdV9xjwy+6SiqLDl/m2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nb+NaCNFU2zjWrAA2H8OTQXMM+bfyQWRRQxWdOc4SU=;
 b=KbnM9K+8kgFbZxCQn0y0Lg3aD5iPOgjBAHXUOJ887P499BP6fy5bO8fD2pEGCFD5HRi+Lr9OTVn48VbWpNvYjqAbe7v2UzYnmQt1N8LzCjuaKnYZh4U3LB9sup4uVGMvh7fSjrW4fHjyca9Lwx/LN9AFofwztaJkeN8+fd0asMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 17:05:50 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 17:05:50 +0000
Message-ID: <0356f122-57de-1bbb-a3cf-4b416fcb5786@amd.com>
Date: Thu, 7 Apr 2022 13:05:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: Cleanup IO links during KFD device removal
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220407161555.545725-1-mukul.joshi@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220407161555.545725-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::12) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5a49567-f38e-4ad3-9996-08da18b8dddd
X-MS-TrafficTypeDiagnostic: BN8PR12MB3361:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB33610EA89882A0478C7B8E20EAE69@BN8PR12MB3361.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzj6csP287xN6Vi4uc3U8oj/6+vF2MK8Iaf7qFOQSOBbWFu0oW1WLYLxQP+6RVSP4CzpsjyY2N6s6jQqUh3Tk4Rs1cJR3HuQhxuTud1tnBvrDpTs3yafZpVt3jyM29V86HwSNZRpIRfXkc9pUhwb+/EDjawOsfwCuyeX1nEVoBJiAbciwB8gGic0edTe0tm4b521eQ+npGXYPJrBG7NMjZlcaeFiP0CqT2SeowLwK/gP+V3xg5aeXiVeztLwNISFwdOu8hLsk8NN1rZa7scc0rsCt7SI9u9T7qpPlijoXSdRlLjCtNz5lfSjJaqq4YMUyiHEbLDcps7gNejyisgxSzRwwdK7VOitLWzvEP2WpQa9jts/nMpdy6QfvPyi4atHHIO0ZleyQl+VN01im7pwcBLsRbQ2bdNaYNpdhT78e7kGHNKMFfzqfPE5v1ymiIgrIfXskTjXOAxkpdVXchDa14yEptLtn12J/F3J8LDonCdrY+7fnogHv5/QjecqyzUUBaBxY78mBmAH8dv/x5NddVM8mJAz7LNC+hsXG6FuJHrA29wsd1E0dPdyz4ERgmWmTmpALDeTFrwk80d/w5SNRS2Sq/9VpkcXyI6Sg0H6+dKsk7JqW5PVIzrPsy1qv5YMt2BWETDtLCKoqPaicYL5b31o5zqjedA+FF6meP+sanq5VFragzKTSXfNn4V5dMyQGk6uR//1HGX41LdHHg/UAFACjjhzhwz5KipOa9PQ1Xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(2906002)(38100700002)(44832011)(31686004)(4326008)(83380400001)(66476007)(66946007)(8676002)(316002)(66556008)(36756003)(5660300002)(86362001)(45080400002)(6486002)(31696002)(186003)(6512007)(2616005)(53546011)(508600001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXhrVTh1TkR0Wmh5ZlJFd1gyVzYrb0szVGFsM3VKS3BrY3dURHRHNnEzOVpN?=
 =?utf-8?B?OUVXa2ZpZXI0YzdRekw4REpiczlsdlYrUHYyaUVjazV1TU5LR2dHR2tJT1c1?=
 =?utf-8?B?YUhTNWZYbVFGbm5NMG5FSWp5alNQNXMvZTIwQUlBUjhTdERCMXV6eE0xVU1o?=
 =?utf-8?B?QmhFZkdmZVg1QUFLQ0lwYVNqY25GaWExRWMwdm02ck1FaHJ3a1ZTaXhnMXA5?=
 =?utf-8?B?TzN1amJjZTRZN1dDamRtSnU5aWFTVU5WNGdidjB1Ykszd295ZUxYTnUxaC9y?=
 =?utf-8?B?YVB6OW9EdEloTVhSYVZyaVlYU21kZWt1c0xxUnkyN2lYUnlQT25aQmxocjR3?=
 =?utf-8?B?RUY0MmFjeGZNOEFoS3lBeWI0ekZxdnRQQVMvaWIxZnk0UDVXK2NwT2JmcDFG?=
 =?utf-8?B?azRNcjZyWGpCbk1hWjUydkRLU2pWSGsrSmNPanFVK2NjN2daMVJ1R1FKWUNr?=
 =?utf-8?B?bG05V05SVjJJWnQ2dXRONzVtQVkybk83ajFrZlpnczltaHIwUnpZVzEreEFM?=
 =?utf-8?B?YjVjeFJWc0lnUm1wdjVSTXMyNC9IWlRJd0R5OVhIb09vdC9NUXg3MS9JbDY4?=
 =?utf-8?B?bCtsTmQxbnpIdEtNVEJncm1LS3dxOXZXOUs0SzF0dEpmTGRMeGhCYlZIZExI?=
 =?utf-8?B?cmtLSThkc2FoTnZVNmZNU1JDMkNtTTU1WDRpMmo3bDJkL0dPb21BQlVyNFo4?=
 =?utf-8?B?WlJsUDhyK0tHOWxDYURGWjJkOWo1aHdSeU5SZ0xaQzBobkZpbk9pbHJ2bnFI?=
 =?utf-8?B?ZS9JbjBUblFiQ2VLMndCK0Vndm5MSlRQL2htbkdVNm0vSWRySVNsQmxlSDla?=
 =?utf-8?B?QS9iNnh4bjJsc2FnbEtjc21qKzE4cnlMOG5YdENFWUN6Qy9wMDI1OWRzb0lq?=
 =?utf-8?B?QmVHUkR1NnJ2NnRnT2ZVSi9Rb3MzcnFHVkNIVHdjWlRWRFlKaXpEZ1pFZkZV?=
 =?utf-8?B?ZG00bWN1YUtaR3VjOXFPam8rSGc3K25JSUNpdFI0QnhxVEJkR1dsNU1vdXZi?=
 =?utf-8?B?aW14NFhqRlFYQW11SXhwMGNCOWh1aUJBakpnakJYa1JqTVlNckd3c0NndUNs?=
 =?utf-8?B?RjdWL2RjQVRGdm1ZZXdWT1Z2cWtrcFFkZEpmV0dQZmpYa2RIeEFOYVpsdHRS?=
 =?utf-8?B?S3hvYm1ueVVxaXh2NnN1K3pSdWNac20wVTVLV2lLelVzdk91cHZmcjNPVjdk?=
 =?utf-8?B?WUZ1dVV6NWF1UW1jcFNsUG00cGw5VTg2Y3NLVmdpckovSXRGcnN3RzI2S1dv?=
 =?utf-8?B?ZEJCWWRJZHlMWTFHK3ZtMGczeStUajMrLzRYelExZXAvaVBPOWR6d2hvWVN6?=
 =?utf-8?B?ZXFHeEwrRElOVC9kZHVMZlNvcFdESHpFbGlBTWtRY3k5RDJmZ1JpM0FsWkZw?=
 =?utf-8?B?VzM2VmRqTjFBNzZmbG1ZNEhWWlp2aVBSSUlNellnek82MUNPa3IzZFJhS29k?=
 =?utf-8?B?YVhNQTFVcXNJZGtDeDl1VjZmVldpKzBOY0RNWXR2bk5ENFVUOTg3OHJSMFA3?=
 =?utf-8?B?dWgzVVZnMm1GYUt0VVBOcWJ2SUVUUlNEUHZHZU5SRXZ4UjZVNENnN3BLM1lh?=
 =?utf-8?B?b0Y3SmZTdTZTVEpsNURlMVlEWTNobVlIaWJ1N2xiZjdOUVh3K0ZGMkFLbWNT?=
 =?utf-8?B?ZS9MdW1sNTFCWDk2Uks1VFR0UjlpRTNjVWo5YUR5bEtBUVhGZzFNNy9jWXdx?=
 =?utf-8?B?MHFzeDByRmZCQ2FWTS9oQjZJaHlaL2Q3SGlORklaOVpXblNGSVV2d21BUjVi?=
 =?utf-8?B?V1MrSHZWWWdvVFptSU80NW1xUmRpWlB0M0lWcHMvbjFGNHFhcEpkdWt3RWE2?=
 =?utf-8?B?MW1FK3o1blY3L25sVXNZNDFZWkFxODVJQjVwTEZxQmVydkZBRjdlSndIemRD?=
 =?utf-8?B?V09mQnNxMHRVaXZZTWFXNm9USVlObEJxWkdhZWZWTzlrVEdmVVo1WElBOThS?=
 =?utf-8?B?b2xSRHpiV3JxRTltMUVXTmNUZktQeURiNHRuQ0NZOGJYd0JhdTNoT20vWkJF?=
 =?utf-8?B?WTNIbEpoYVVlTWtWTTNXY0YzU2VLeEhOVFI3OGZYY3dndVZPZGRnQ2tZd09N?=
 =?utf-8?B?QW0ycnB4d0pZOTFDa0ZjOWw0VmJQWlVnVDFVR3ptLzF3SDN0bzYxSUdycFBk?=
 =?utf-8?B?aDBmeFUzcnpXOUNYOStKYkgxL1VDVEtpNW5lVUQ1NEF1Rzl6QTNaTXZBZmRm?=
 =?utf-8?B?ekM4Nm9GaEdQZ3llS2oxaWoyMlVLTjN0NVdnVm0yNWdQVmo5bHFBOE1PeHdX?=
 =?utf-8?B?RUF1akhsWDdDWWRYeVdVY3ZPelhIUjhZdWRNTGI3dTE4YWMrb2FBWUNoWmQ0?=
 =?utf-8?B?SHBUaC8xMkZ6K1JxT0RlSEFZVVM0bGd3L2ZIZm9NNmVYQndQbzdIWUJRcjlo?=
 =?utf-8?Q?M5wbNZ4JjDY/rdVZW2AP54jYwjxsjnvBKE/Q5FzbSv4UN?=
X-MS-Exchange-AntiSpam-MessageData-1: zfUYS3b49YFRSw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a49567-f38e-4ad3-9996-08da18b8dddd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 17:05:50.4182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obdKEYtycBC/arILMXCGlfI+1NBPjes7npgffMiOT6RKB1PUbjuZvjxvd27hFwOegOUjsbR1Kj2lHUS0x9JhDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3361
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
Cc: Felix.Kuehling@amd.com, Shuotao Xu <shuotaoxu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I suggest adding another patch to handle unbalanced decrement of
kfd_lock in kgd2kfd_suspend. This patch alone is not enough to fix
all removal issues.

Andrey

On 2022-04-07 12:15, Mukul Joshi wrote:
> Currently, the IO-links to the device being removed from topology,
> are not cleared. As a result, there would be dangling links left in
> the KFD topology. This patch aims to fix the following:
> 1. Cleanup all IO links to the device being removed.
> 2. Ensure that node numbering in sysfs and nodes proximity domain
>     values are consistent after the device is removed:
>     a. Adding a device and removing a GPU device are made mutually
>        exclusive.
>     b. The global proximity domain counter is no longer required to be
>        an atomic counter. A normal 32-bit counter can be used instead.
> 3. Update generation_count to let user-mode know that topology has
>     changed due to device removal.
> 
> CC: Shuotao Xu <shuotaoxu@microsoft.com>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 79 ++++++++++++++++++++---
>   3 files changed, 74 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 1eaabd2cb41b..afc8a7fcdad8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1056,7 +1056,7 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
>   	 * table, add corresponded reversed direction link now.
>   	 */
>   	if (props && (iolink->flags & CRAT_IOLINK_FLAGS_BI_DIRECTIONAL)) {
> -		to_dev = kfd_topology_device_by_proximity_domain(id_to);
> +		to_dev = kfd_topology_device_by_proximity_domain_no_lock(id_to);
>   		if (!to_dev)
>   			return -ENODEV;
>   		/* same everything but the other direction */
> @@ -2225,7 +2225,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	 */
>   	if (kdev->hive_id) {
>   		for (nid = 0; nid < proximity_domain; ++nid) {
> -			peer_dev = kfd_topology_device_by_proximity_domain(nid);
> +			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
>   			if (!peer_dev->gpu)
>   				continue;
>   			if (peer_dev->gpu->hive_id != kdev->hive_id)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index e1b7e6afa920..8a43def1f638 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1016,6 +1016,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu);
>   int kfd_topology_remove_device(struct kfd_dev *gpu);
>   struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
>   						uint32_t proximity_domain);
> +struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
> +						uint32_t proximity_domain);
>   struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
>   struct kfd_dev *kfd_device_by_id(uint32_t gpu_id);
>   struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3bdcae239bc0..874a273b81f7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -46,27 +46,38 @@ static struct list_head topology_device_list;
>   static struct kfd_system_properties sys_props;
>   
>   static DECLARE_RWSEM(topology_lock);
> -static atomic_t topology_crat_proximity_domain;
> +static uint32_t topology_crat_proximity_domain;
>   
> -struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
> +struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
>   						uint32_t proximity_domain)
>   {
>   	struct kfd_topology_device *top_dev;
>   	struct kfd_topology_device *device = NULL;
>   
> -	down_read(&topology_lock);
> -
>   	list_for_each_entry(top_dev, &topology_device_list, list)
>   		if (top_dev->proximity_domain == proximity_domain) {
>   			device = top_dev;
>   			break;
>   		}
>   
> +	return device;
> +}
> +
> +struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
> +						uint32_t proximity_domain)
> +{
> +	struct kfd_topology_device *device = NULL;
> +
> +	down_read(&topology_lock);
> +
> +	device = kfd_topology_device_by_proximity_domain_no_lock(
> +							proximity_domain);
>   	up_read(&topology_lock);
>   
>   	return device;
>   }
>   
> +
>   struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id)
>   {
>   	struct kfd_topology_device *top_dev = NULL;
> @@ -1060,7 +1071,7 @@ int kfd_topology_init(void)
>   	down_write(&topology_lock);
>   	kfd_topology_update_device_list(&temp_topology_device_list,
>   					&topology_device_list);
> -	atomic_set(&topology_crat_proximity_domain, sys_props.num_devices-1);
> +	topology_crat_proximity_domain = sys_props.num_devices-1;
>   	ret = kfd_topology_update_sysfs();
>   	up_write(&topology_lock);
>   
> @@ -1295,8 +1306,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   
>   	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>   
> -	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
> -
>   	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
>   	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
>   		struct kfd_topology_device *top_dev;
> @@ -1321,12 +1330,16 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	 */
>   	dev = kfd_assign_gpu(gpu);
>   	if (!dev) {
> +		down_write(&topology_lock);
> +		proximity_domain = ++topology_crat_proximity_domain;
> +
>   		res = kfd_create_crat_image_virtual(&crat_image, &image_size,
>   						    COMPUTE_UNIT_GPU, gpu,
>   						    proximity_domain);
>   		if (res) {
>   			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
>   			       gpu_id);
> +			topology_crat_proximity_domain--;
>   			return res;
>   		}
>   		res = kfd_parse_crat_table(crat_image,
> @@ -1335,10 +1348,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   		if (res) {
>   			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
>   			       gpu_id);
> +			topology_crat_proximity_domain--;
>   			goto err;
>   		}
>   
> -		down_write(&topology_lock);
>   		kfd_topology_update_device_list(&temp_topology_device_list,
>   			&topology_device_list);
>   
> @@ -1485,25 +1498,73 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	return res;
>   }
>   
> +static void kfd_topology_update_io_links(int proximity_domain)
> +{
> +	struct kfd_topology_device *dev;
> +	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
> +	/*
> +	 * The topology list currently is arranged in increasing
> +	 * order of proximity domain.
> +	 *
> +	 * Two things need to be done when a device is removed:
> +	 * 1. All the IO links to this device need to be
> +	 *    removed.
> +	 * 2. All nodes after the current device node need to move
> +	 *    up once this device node is removed from the topology
> +	 *    list. As a result, the proximity domain values for
> +	 *    all nodes after the node being deleted reduce by 1.
> +	 *    This would also cause the proximity domain values for
> +	 *    io links to be updated based on new proximity
> +	 *    domain values.
> +	 */
> +	list_for_each_entry(dev, &topology_device_list, list) {
> +		if (dev->proximity_domain > proximity_domain)
> +			dev->proximity_domain--;
> +
> +		list_for_each_entry_safe(iolink, tmp, &dev->io_link_props, list) {
> +			/*
> +			 * If there is an io link to the dev being deleted
> +			 * then remove that IO link also.
> +			 */
> +			if (iolink->node_to == proximity_domain) {
> +				list_del(&iolink->list);
> +				dev->io_link_count--;
> +				dev->node_props.io_links_count--;
> +			} else if (iolink->node_from > proximity_domain) {
> +				iolink->node_from--;
> +			} else if (iolink->node_to > proximity_domain) {
> +				iolink->node_to--;
> +			}
> +		}
> +
> +	}
> +}
> +
>   int kfd_topology_remove_device(struct kfd_dev *gpu)
>   {
>   	struct kfd_topology_device *dev, *tmp;
>   	uint32_t gpu_id;
>   	int res = -ENODEV;
> +	int i = 0;
>   
>   	down_write(&topology_lock);
>   
> -	list_for_each_entry_safe(dev, tmp, &topology_device_list, list)
> +	list_for_each_entry_safe(dev, tmp, &topology_device_list, list) {
>   		if (dev->gpu == gpu) {
>   			gpu_id = dev->gpu_id;
>   			kfd_remove_sysfs_node_entry(dev);
>   			kfd_release_topology_device(dev);
>   			sys_props.num_devices--;
> +			kfd_topology_update_io_links(i);
> +			topology_crat_proximity_domain = sys_props.num_devices-1;
> +			sys_props.generation_count++;
>   			res = 0;
>   			if (kfd_topology_update_sysfs() < 0)
>   				kfd_topology_release_sysfs();
>   			break;
>   		}
> +		i++;
> +	}
>   
>   	up_write(&topology_lock);
>   
