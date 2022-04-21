Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FDEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 14:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684AE10E418;
	Thu, 21 Apr 2022 14:55:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A4B10E418
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 14:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAX3ys8UP/oVocD+mToeXqyjdfrrQzsAnTM9BhdP85DjLFesY7nGYS6kV0VC6rRZ+FoPgLci+8Ow1ihUrmT/hGpZDOPooR16MKGY/re1b5NxqdvqdQOyQ+KNXPjDHFXN7Pq/pyUWGXcdd5uEd0BVGqE74adR1ULG8T+RUScKAQvbZbDfeJApa/ZyMi7cE9ZSs3vwSJf0BpGh35kjn82sraIPQxCuI3PJURHNbwD4uzWeiZ56leksURGLrbyl5HT/FfUEsJQeAUOUUdkzs5nQ7mzzRi0Ne4E9OY9Lx4IZNDEWHKBg8U2GnpPNw0OSYBYSkA59isi5X2rbXl+Y0SDZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqcydRbl+7QxfdDY5OnDgBN+jH6EHIFU52cDqvFxYUM=;
 b=IxCs12d/AQLzHmBzTWtZVOUd/P28yB4yFUckMFOqyVwIGPMYwtTj16qqG25UsytKNIt4Fvu+M3J/eHa+sK4L87zt5zsehuPUJDmplF5h/6ugXNKdB4k8VsESPZjMi1XLE+58bpl4O3x++kDdmXuePve6zLT1aXo0x4Yv3I1q4o+1AfZVds9rfH7a3ha3+y4XipSUuuNWKwCPpYCjIecD5audS3icutN43Hb+TV6kNO+/GnhnhXMrL9PIIZrnchbhX41C9MlxESpABq4jj786cxgYxHHGgENEyVhJOEz9zijic8BcB05wOttPoYoqSb/rbuvrvIdVjZEWuGIyM5rvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqcydRbl+7QxfdDY5OnDgBN+jH6EHIFU52cDqvFxYUM=;
 b=Gm+8cNDgwJK3CTpzVZ5jN6Nbq7cTkhK2ZE8W4FwcanPWc6anHBTPRVDKu8DJ1MasbIQkQ83J7c1uKodoPk/q2PBmZebVKc2wTuoDlV5DT1Aqr5zWzSNLCTAR/FYt84f3IhJTAmlnq4XT12AxJqCthMhxyaBhjJPipXFHul1fhPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:55:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 14:55:06 +0000
Message-ID: <cd602c09-64fc-cb13-60b9-a3a4be7a7f37@amd.com>
Date: Thu, 21 Apr 2022 10:55:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: use kvcalloc() instead of kvmalloc() in
 kfd_migrate
Content-Language: en-US
To: Yang Wang <KevinYang.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220421123322.1833664-1-KevinYang.Wang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220421123322.1833664-1-KevinYang.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf72a9df-3cf7-4b92-506f-08da23a6ec7b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1833EBA02769C40CC67E8D3292F49@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4TjoOfBgs+AYOzmbW2qlpx2BhREXydPUPnT9ZtsHJUKM5wNSpVrM1E7mKVAgMJ2piQ91lWzSqhE7hYuXl28TwSoKv0YrGNvGBNAqs5cV5GvP3uFOwrnj3oUu0tp9F/kfFOTyMLCCXp6bg2VWhniMw8mcViUJOUVu61T2yXiVpYcZ9QwT+loDvBfgtVJB3xRuhluiIzHkhktwkrBwVHcpsrXHT3cfUs9E+Rk+rQ94t5bgqAYuzW3xzDYdmBpFAItub8mvFQGZJdXBx1PH4/DA8FIxaW1tOTIrti/Uq7OruCHCeZbPLMJdJL0ofgWTaX1tx4RVwMzyhQpDI2uMdUpgQj7CENJSp6qr/BApA0t9PclmJukD5upazsd3YDhT3JEW1tD5+KdYzdkTZFVnVfm1sBsFIC0m9PcGob2EAaWIu5TM1vN7GptiP3aiSBWbQfD16Gdwnt0aEpwvrp1YvvL0qwrp0+tl7O+qflmk1E2Hz2la93KLIQ4SjpKHZISRiHfHwNuv+pF3zQC7CtDrJh7BfOwiVVkmELBgS5VZyBXdADBgKyd5Xn/VpTE26gQVdhbQ1WJdSlPp6ZeFeXvR8dDiainJer3LsPjWNw4T6cIVKSfbtcpEL8c333RPDR2ZMQHjXQYNeMK+7j0IWVWRbp6RzAX8MUV+3YBidpG9XYsQMk2iwk1bPjo9/CDzl9C6tubbNaoTff4hHkcT+1HN6Ad9VqUbTB70Ac4KZWZtwCSxezviSMzGG1j99Hpjpngpd1J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(31696002)(6506007)(38100700002)(26005)(44832011)(2906002)(6512007)(186003)(316002)(2616005)(66946007)(66556008)(66476007)(8676002)(6486002)(86362001)(83380400001)(36756003)(508600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlBiSkxmbTlJSzhTeFY3TEd4ZmJod2ZYZHdBWGpUSHkxbUtjcFNzUE50d3VC?=
 =?utf-8?B?RE5FbUlLekhMUXIxOTlsQXpJZjFCOFNxeldqcExCcVY2SEN2cDhnS1BXTkQr?=
 =?utf-8?B?MjJjdmdDcXNlQVJyRE1wbmxnS1V3ZWNQRS9kSVdlRjJtUVdtM25neXkxWllI?=
 =?utf-8?B?ZXlvZ2Vna1VpS2VjNjJ4VjB2ZlFHa3RnaWtFNG9iaHpDWjBEOHdGL0FqYjd6?=
 =?utf-8?B?YmRGZHFtR3d1MklETHVUUXcwWDlCL29pQ1A4cHQrTjgzeXF4Vlp1UmVkMFVG?=
 =?utf-8?B?U0JmNUVzdlBPa0tEaDk5clljMkJrQ2RCZjM0dHZCNVA5OFZ5NzdPMGJoMGRy?=
 =?utf-8?B?M3JhYm4rMXRkUVFXbTJxVDhQQzJFVnpYZ2hBSkNTeGtjVDZ0Q3hQQUJCMEMy?=
 =?utf-8?B?dGNGUTk2ZDRZMno1SG9yd1dNSm5kaGhuK3lOOERldEtQbXVjVXRFVUlPUXNu?=
 =?utf-8?B?a2VTeGlQbDB4S2hvZEYzOHNKYysyVXduOEN3ZlNkMzRjQTc3R1R3b2JjYi9B?=
 =?utf-8?B?MDFYenpYa3BIZlpFVlEzZ29scjhidXJIdXpISDdaNWZtaFFKdlZ2WnZ4MXNF?=
 =?utf-8?B?SU5oaG9TVDNDbUtabElQZFQ4Sk5MakN4a0dIdUFwZEJmYVB5VmhuTVlWMDJM?=
 =?utf-8?B?bHdPY1dHS0xRZlRrWFJRckxZekZsMXVOS2tNUGtDOTRJbHMxaThxODhwbktD?=
 =?utf-8?B?ZDNzajV0Y1JpeC9XbjJKVHllYVlsQk50VDJsL2NHTnM0djNxdlZzQ2tMbjRD?=
 =?utf-8?B?MWlPR2g5ZTVQRTd2cXZNNWRIdldKWnJhNkZaKzc0NGJFUktQcTdQeWFYdnZa?=
 =?utf-8?B?RjVvbXE0WmYwcnQ3bTZpZlg1dXozUkttdk55WFJCSjRSbmthQWlvZFgwRmFW?=
 =?utf-8?B?WEJnem0zeHY5dUw1NW9aWit5b3pQZGhzQXpQTkhLUmFTTmxNeDBNa2FvQXAx?=
 =?utf-8?B?SWk1NS9udUtlWGljOEZSMUoza0JxSnZQY3F5VDhrVzEyYmVpaEJxRlpIQlhX?=
 =?utf-8?B?aitZQ0I1c1c4TE53K3hINFl0cE9sSzQrMnZkbllQcTJBZzg1SVEvVkNWWitH?=
 =?utf-8?B?VzZTMFNldkhuSlFhSnZHUkZMbjg4UlRaaElvbStNK1haSGIvOHNCWk02UHdq?=
 =?utf-8?B?RzUrZ1hQRUV5aEdwaGJQWktHUFFWOWR5VG9hc1Z6SmZBTkpKcm5QTHhTNHhz?=
 =?utf-8?B?ODZnQmNWL1RHdlJDRWlLOERTU2RjVTZkZEtENFliTlNhY0JvYWhQelVBRENM?=
 =?utf-8?B?VmxaUEJOQTN3VEdJa0JrUDY3b1RjZWVPQmQ0WWxvZklJTUdtTUtRY3hUdTJo?=
 =?utf-8?B?OWFraWduU3RIN3NYZ3hyN3IzcE4rWC9HTzBNelFVcVlxa0F6YWc5STFXYzc1?=
 =?utf-8?B?RW81Q1ZSTFJja1JqcXVpbGJHTGJKdElkV281TFR6RVlQUWZCTDkrWXN6MG1o?=
 =?utf-8?B?azVNT0E3TXlaQStjY0I0WC8zcFZxYlBBNjRCUm81Sk5jamx1eU1rQnlwRlNn?=
 =?utf-8?B?K1MwVTRsQWFaVlhsRzlzN2RkcEJhcVpwU2NDTzMwMEUrRjVSbUJEZko5UDFY?=
 =?utf-8?B?dlE5UndhMnNoUDN2ZTFBNCtTMld2bmVqdTk4em9rK1VvWGFGK2hOY0hYN2FW?=
 =?utf-8?B?dFN3dm04SVg3YWRNRjVKcHZaazlHeG5kUk9ZcWJwWlBQdFlVeGlQQU5mZUIx?=
 =?utf-8?B?NnRXYTBSVU9WNEEwY09VcEl4cEhPTVA5M1FXaHBNZjlJSCs1Z295S1ptL3Z2?=
 =?utf-8?B?QkdBN1FBb3c4QWJIYlpJemFFOTMyMnZqekY1U0dZSnZ6cUlNMFg5T2RrNDlo?=
 =?utf-8?B?a1lnSTErMmpRSzZuZEo0Rk9qMFl6ZUN0dGdMUjVNc0hHY2tDS3NnUE9JYTIx?=
 =?utf-8?B?TTl1WHc3YzUyenY0NjZvSTJneVBUMDl5YUpjQjQ4RzFNUXJBNWc1dWJMVDc1?=
 =?utf-8?B?YU5IZi9LSlI0TU1LbnZURjRzNzZIUDR1TUJiaGxZVnM5cmN4ZXQzejc0N2hF?=
 =?utf-8?B?SElZeDJ5WDRhNHpMM1VRdFZZZHpydEUzSnZZQ2ZqSXlsZTQxdTZoWFVKZ09y?=
 =?utf-8?B?dXp2R08rRW5ZVGJYWEhVaTdIbXJIRTlDc2I1YURoZUFSVDZEbzJmRTZJTnNw?=
 =?utf-8?B?bmh0cGY0U2RhRmFJT2FlZVhaOWwyUWE2dEM1anRmUVlvWm9GR1ZIYnVlQUNU?=
 =?utf-8?B?VlM3ZUN1ckxTRnpDN2VHOGdSbmNYd0RTb2UwRlNtVncyeFcwRHdVNVpOd3h1?=
 =?utf-8?B?eFNpa2JRMHBrS3ZvUUhHS0hXOUlUZ0xzTjUvcWRHajY5dWlQYytYNGwyaHlz?=
 =?utf-8?B?azFKNE5FQm1mamdFNzhzdnhmODVhWG9LRXgvbEhmUHBMMmtmZGxidz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf72a9df-3cf7-4b92-506f-08da23a6ec7b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:55:06.7893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ymln4MGFtugpJ/Dj/aO8hnVfmRdHwY/VnS2YWEOZlmis07HwOV0KPJ8cG4Fo/5r/cVp7DPml95Lvbp0NHrqmZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
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

Am 2022-04-21 um 08:33 schrieb Yang Wang:
> simplify programming with existing functions.
>
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

There is one more kvmalloc_array call with GFP_ZERO that could be 
replaced with kvcalloc in svm_range_dma_map_dev in kfd_svm.c. Maybe fix 
that one as well while you're at it.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 3a29d857640b..43cd47723946 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -410,7 +410,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	struct migrate_vma migrate;
>   	unsigned long cpages = 0;
>   	dma_addr_t *scratch;
> -	size_t size;
>   	void *buf;
>   	int r = -ENOMEM;
>   
> @@ -421,9 +420,9 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
>   	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>   
> -	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
> -	size *= npages;
> -	buf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +	buf = kvcalloc(npages,
> +		       2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t),
> +		       GFP_KERNEL);
>   	if (!buf)
>   		goto out;
>   
> @@ -665,7 +664,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate;
>   	dma_addr_t *scratch;
> -	size_t size;
>   	void *buf;
>   	int r = -ENOMEM;
>   
> @@ -676,9 +674,10 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>   	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>   
> -	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
> -	size *= npages;
> -	buf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +	buf = kvcalloc(npages,
> +		       2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t),
> +		       GFP_KERNEL);
> +
>   	if (!buf)
>   		goto out;
>   
