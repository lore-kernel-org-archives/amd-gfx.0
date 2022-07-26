Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FD3C00144
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 14:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE1A8B115;
	Tue, 26 Jul 2022 14:24:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E7F8B1C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 14:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM/R++gDZmH+DgFabL8jFbsyoNj8FXW+q9+s9ASGz6LYQDXAqyGebyJxE8Ijvy/8WwzCx/XfI2iHD2kiHAxvOAZYNCden/XcEmjYPpPdDiaOMvnSt0DbBeyGwmSn4PLvai6FooAoSNRRmqD4uZAghm9k9PBHqXCOq8vByTXLrHqhmJQMy+vpaA6VblL9bV9AdqkM/yWjfv9EHne0hmSQa5oU0Fotn4AZWkusc7xmyBKi9z5eMrr031/97YLYQ2kWS92Pgagin/R5bGDTwcjjqMGsfvnxiA/wnDZsvR+oanzUAxkPkILKwtCaJ1wJhpbqW3CIMpaq70A0qU66jyYKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9O63n5DaNMnAixRN5tOJtpjmG74gTlvIIsqqpT3Nlk=;
 b=RMrgi/GTeCEVvPuScKvS2vJNPRVTnDq1t+R0j6NoFgvshqnMP6jr7SHygs7ELvbK9f0xlxVf8AE1j1Ikhyx7DT31JbptfZcwWFpSzrpJvD6RMFcjKQoun8KmtLQ6/DF6/6M8Y/8sXVM9JcWoRn6oV/WsdiFPVwxUAQzgqDcc18dtTf4w94D8wxkx+lcwuvVlEmNEzk0ct2sIH876onc7gCdhJo7i8pk+QjO2bqoSKCzHjnTZIaIVu1rtAicygQl07Kuu+fbIYAoCAJ79Ew7rsWWJb/k1mQP7RNizu+PD3qeOufrPKKk/ldLzoJglL74cahD44R1BHw2kEdQ6RwLm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9O63n5DaNMnAixRN5tOJtpjmG74gTlvIIsqqpT3Nlk=;
 b=rhNR/tUJPArcNxE1tQlH7rPnGn13iBKtZxRZBwzBbQLxAA5BWRptp/31dZG+cPoKhtZyod57gEzhim3kuZa+vumpmA4oq/ifTucUuJMaaVKmZ2cz5WDCgZHnsRoPtdWQkTYepuZl952y+LeD1OzeJY/Naalq/V5sHNNhKQk+5Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 14:24:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 14:24:30 +0000
Message-ID: <263ddab4-5007-6c1c-34d2-c65b72842523@amd.com>
Date: Tue, 26 Jul 2022 10:24:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/3] drm/amdkfd: Set svm range max pages
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725211743.5937-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220725211743.5937-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cafe3dd8-0611-491b-7360-08da6f128dd8
X-MS-TrafficTypeDiagnostic: SN7PR12MB6689:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nwnfTUqaf8ZH/Nwc5pwqE+WukoKfSO2B1ypPj0LFbxYU75opC7YNOyX14FNzAdQHuQPRFCtn6DVatZAQsrKD9Drfb+Z0TJf/HjbsV6+713I4Sdzx4THMOiT/HI+TR8w/WC/cMKk5ko7l4k57tcRJyEzmTWTtD8otB1rZA4WnDYm2zY+UZnJymgBgS61rZET8HkTdW52672V3kdzlE2jsDVzayBu01gtcShiSfKpAaXkhWZtUUJ42QgngZ46/B21p3sbmtTHUwZ4D5nAT8+iEI4HpdjNcnfwQCIin1QirZdUxnVVuNA7Xu2DgrihKkdemL6leNI5z1b9elFifcQRsTGpzMwlegsd2PNvw3yniuxAKkFE9cDu1y2gDq2pUCJFfhlqL2q3y4B8bV6qx9Ci0MBnW7UU2rNQbd2kV+4PGfC7PAwUv+QVno0Y5h7LafCLSCVyTp32EJ0ORmjFVVLlXat6jcVVCWkyPIxDkyRa64lxDA0+2U5LAjcxNAy4etVt0RYX3q4gBZqOMfZy4nD9YVAGWnHKjrAzy8KNtWzKMjZScmojgPWWjSbRcZ0qIH1UAzAGaGj7bu9lZtoq9m2RwquDpMVcwTTL5HVfQFTpWbIRmkBl3P/IEjYqmvNXDkvREaH9GTRg958ACEJj3AHPRJ7qOmG5PWSRLv5Sabzj5qhOLxtl9ee9S7eOkF3n+j0/ZOFpKlxTyVT5UPWMmhJGStLjanJXmjVWqF8AqPPPzVEBvVJi9L+DH4cBosTdO/qrvb8ry2qe3I+sxvDZ6jCWlw0OoQKxnbWDWpwaSIg8I706iJtPv5U7WQqsB/7ach7kGzmmAithPHHbsQk8SqQ8LuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(6506007)(2616005)(316002)(31686004)(26005)(38100700002)(36756003)(83380400001)(2906002)(478600001)(8936002)(5660300002)(66476007)(66556008)(8676002)(41300700001)(66946007)(31696002)(6512007)(6486002)(44832011)(86362001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlphZFdQeSs4VC9QUUN6YzlQTmI4LzdtelFydnUzek5jSUVpUnFJYmJ1cWNF?=
 =?utf-8?B?bXRrejhwbTlHcm95QS9TeEJzSWxYOVhEV2ZnTjgzVUQrVmNodU9wK2RXMFJJ?=
 =?utf-8?B?cU90d0hlRlpNZnpQTDM5MDBKWG85S3krVVFLa3AxRHduYUJyS2x1N1RxUDFJ?=
 =?utf-8?B?M2NJNUpnQTZsZkgyUTJxczNhMTJwOFZVRWpyMUYxeGpxYlpPYU5nbkV4Y21E?=
 =?utf-8?B?MHlOMDhXek1uczc5aGUvbSt5N2pZYVozSzZGWmpxeXhIeUQwSk9ZQjFhOVR0?=
 =?utf-8?B?RFByVHJkNTlvayt6bEhEcTROVFVaU1ZXalllU3JlOU5yUXROeERTanJyQWdM?=
 =?utf-8?B?a1l4T0IwZjlPL2VyR1ZWa1ZmaHl2ODN5OXlpSXU2anRMV291Z1Z0YzAwRGEy?=
 =?utf-8?B?OEl4K043TFh3ZUwyTWs4dXk2bzZra2ZiTTBMQ0paSHl4SU5LcUxGOFpCSnBl?=
 =?utf-8?B?VlBWZmU0cllIOTZOeDVjYk9wa1BjN25BbkZtK3BFd1c3R0NOdFNlcGpqY3FZ?=
 =?utf-8?B?c0I5TFZUTzVsSC81UGpOMWtBcWk4eEVPYUdXa203RlJhRFlLU1JYWEQyY1lR?=
 =?utf-8?B?dVFEN3RxK1k0MWtvK1U1QVljblAyNWRjVFViczFBTVU0N0wwZEh1M0tQbVBX?=
 =?utf-8?B?S1Azc2dudmszU3c2SE8wSFFydkIrS0VFTjc2MHprc3NFQTRrU25uUjhwd3pD?=
 =?utf-8?B?TUtVdnNjdXdOelpYNEN5cUtTRGxJanRZZ2F5SDlWQlNNOGJ2ak1la21NREdC?=
 =?utf-8?B?YWNaeTFLVnBxTlExUTRhZWFNUW1HRVRTSTVHTzFUalpZd1B5M1Z4aG5meXlj?=
 =?utf-8?B?ZHo2Y25PbW9WNjY4dEJ3TFhQOXlvVkV4NEJqUHM3RTA0aTVWOXZXVEdxclRs?=
 =?utf-8?B?K1p2M2hNbld6ZTkvZlV0TXRJOU45eloxL1hGeDFIYzA1dVFDNnpva1Jzakdz?=
 =?utf-8?B?aUFmd2ZPeUpnODJYREgydWQxcEpkNGtOUmoxWVlscm9jNE4yLzZSRFNhSU5F?=
 =?utf-8?B?NGZXcnF2QVhpdjhKYVZaTG8yNjVqVThiM21POUNVMkVNMklERmZkMFRwS2pU?=
 =?utf-8?B?elpVV3IyRlBJWFhMa29OOTVzNTNtbm5hVGRUbi9obGI5WVBON2VINkpGNE50?=
 =?utf-8?B?WVpRaVJ0cHUydVpGcVFBNjNiZmpxWXpRWDQ1UEFvZkgrdGdjKzQ4TWZOekJa?=
 =?utf-8?B?aUdBa3piRnoyUTFsWnlrd2ZIQlFxQlg0bWs5dzYrcUFzcHZSWENmT1M0QTNI?=
 =?utf-8?B?c3g4RjBvV0xrTGpQYXo2cGlrUVEwU2RFK0VtUXIvei8rUTZwL1U0OUg3cElQ?=
 =?utf-8?B?OXcveVJmYW1DMTlKRGEyaVI2ODc2RXVYMlJvT0JGWkxWNFJ5U3lBVkEwUyt6?=
 =?utf-8?B?R0dPb0dhNVNKRDB3V1Z6VlMvSFp0VWUvNXkxR1pjTjFwaTlSZVJEaG92Znlk?=
 =?utf-8?B?Z1p2ODdhZGFxaFp6c0pVcmZoN1hHV0NtL0FGU0RzZEU4ckhqbThWZ3NBc3dO?=
 =?utf-8?B?TUNocDEvZStXQkhObDlWYk4wR1FDQXlnN2F0QTFHT0dLWVVIS0FoZ0s2eGFN?=
 =?utf-8?B?WXFRR0RBY1U1bko2djRaWkRza2toT1BVNFJETmFZSmUwcDdzNEVGWGFjRTZM?=
 =?utf-8?B?clA2Q2cxUHhBOUwvSjBVeldSWHovNFhSYjYrbmxkMjRYVG50V2hvbWJrN0ZX?=
 =?utf-8?B?d2tWZWxUS3dhMExIRXA4U3BUZ1RqVWQvS2Z4T2tFbUhRc0MwWEw3ZkZwY1E0?=
 =?utf-8?B?WllLYU1RSzNvTXNWbFdtU3NxUloyODcvRERKdWtNSkJmQ1Q4akMwQXRBWHhU?=
 =?utf-8?B?K1NwVzVicWhIek50Zld5U1dLeEFKRFZyejF4ZWRFNEgxeitqamtsTEROTDZK?=
 =?utf-8?B?S2YzdG4rak5wNjNiNU50QU5zVi9abzNJa2J6S081WkJLTCswZDBNOUxPRk1W?=
 =?utf-8?B?RDNkcU5GU09ueUZhbHZNOFk4ajFORzBXUTVtSm5ndDBLM053M0xSTHgveUR4?=
 =?utf-8?B?cXNHRzZJVVFEMHNUTEJqTkdIdXpGdFVudWRnMjUvdmpDbm1kR1lSVlMvY1ZR?=
 =?utf-8?B?b2dlbGkyOVBGdVV5MzFKRlFtNjNVVmI3NmxzaDY1azY5UmRNbzEwOHNxVGYy?=
 =?utf-8?Q?Z/lUWVjo/+cAluwxLwLpsk+Yz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafe3dd8-0611-491b-7360-08da6f128dd8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 14:24:30.7946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQHGKFb+TYJ+jFLivetOs+wqGQMLzlU00mlRuXN72wsSidRMx5lElYV7fqnU4EZzZEE3vxOGzJzxbDt88suEvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
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

Am 2022-07-25 um 17:17 schrieb Philip Yang:
> This will be used to split giant svm range into smaller ranges, to
> support VRAM overcommitment by giant range and improve GPU retry fault
> recover on giant range.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 21 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +++
>   3 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 9667015a6cbc..b1f87aa6138b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1019,6 +1019,8 @@ int svm_migrate_init(struct amdgpu_device *adev)
>   
>   	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
>   
> +	svm_range_set_max_pages(adev);
> +
>   	pr_info("HMM registered %ldMB device memory\n", size >> 20);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b592aee6d9d6..9d855890658e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -46,6 +46,12 @@
>    */
>   #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
>   
> +/* Giant svm range split into smaller ranges based on this, it is decided using
> + * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB and alignment to
> + * power of 2MB.
> + */
> +uint64_t max_svm_range_pages;
> +
>   struct criu_svm_metadata {
>   	struct list_head list;
>   	struct kfd_criu_svm_range_priv_data data;
> @@ -1870,6 +1876,21 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	return new;
>   }
>   
> +void svm_range_set_max_pages(struct amdgpu_device *adev)
> +{
> +	uint64_t max_pages;
> +	uint64_t pages, _pages;
> +
> +	/* 1/32 VRAM size in pages */
> +	pages = adev->gmc.real_vram_size >> 17;
> +	pages = clamp(pages, 1ULL << 9, 1ULL << 18);
> +	pages = rounddown_pow_of_two(pages);
> +	do {
> +		max_pages = READ_ONCE(max_svm_range_pages);
> +		_pages = min_not_zero(max_pages, pages);
> +	} while (cmpxchg(&max_svm_range_pages, max_pages, _pages) != max_pages);
> +}
> +
>   /**
>    * svm_range_add - add svm range and handle overlap
>    * @p: the range add to this process svms
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index eab7f6d3b13c..9156b041ef17 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -204,6 +204,9 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>   #define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0)
>   
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
> +
> +void svm_range_set_max_pages(struct amdgpu_device *adev);
> +
>   #else
>   
>   struct kfd_process;
