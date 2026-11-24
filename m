Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D0606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HumFdKnX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F13C10E5CA;
	Tue, 24 Nov 2026 20:33:13 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A938610E3CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 20:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjQekiPBd+5BQkQ4ugVNTgFyJlh+zqtbS6OQD37CBJv+4wA+oYc+vplmYJ5x1o2ljP3Usilmb77AWdvHeuJ+dFrED6P76/k5z0jD5eA0thquh8NU+jUkf/hEmVRD64MXVG0CrDd0VFMspnMiGN4y0cQ3MjuXNzQ5T/F5uySfGl6yRNICXsXQeVTe7lvMXqNGcoYm9tvtUpqE2e+wgIlOOj8BMEab1wFAFV9BdU+FxyBQ8woqBH5d/uKyVXLzoHGh5369QYaVTmP4IfqqPkFlNbMOdZCPDjGPo9QMwihGLml4NCi4Lr4v91F9EvF2hKZ2qiJAN6noRojPyo/hPvsb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iOv/e/2fpigDIj4d1PYmY/g4d4SptxHPTnx6gqJL4I=;
 b=gUfXUiONVRKW03I2ee5HIEEF0GVpOhXQSZvFJ5MRHEEUhUBfepk8DHcfrP7ak2icicRL+sDTz2fhWohIJwtfY4ylA3LW+SKIB0gn8/dGhc6PHf62xBMXfMfKuedmEjl/0BzhpQJGuWNezshGKqdqYYODKx6Zw7cuesaw7is4x5KOvcjf1Y51GzULTOL4tVss46G84x/YevD6MxIZFDstwQL2gJp24kCpTqrYT/By72NyoMupNtW7GXPUW6j4z9B1xYqPuV7k2d7+3Qo8QQNWFs6GeHmuYYaMMeKlHlnQApKj29psaMqFQTjiKxKBfO3LAcOOW/qFNlYfkvgWFs8sbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iOv/e/2fpigDIj4d1PYmY/g4d4SptxHPTnx6gqJL4I=;
 b=HumFdKnX/L7R5IG5dfExbCsIzY4DZUuvQmwi6oUG8vXcWjQzKg43ZKDRzvc17iGeMJ4vljraSHNpU08KX0v0zrbu86U0w19HRjKXGUaFJQmcYaSQeB6hfQQubgmdWm/cCNhMVoNmz2U9/NwarkRPu+Cg06u7u3WaCJiONUC4IVM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 20:33:00 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 20:33:00 +0000
Content-Type: multipart/alternative;
 boundary="------------oF67xRde9NE176pXlaSDwRTC"
Message-ID: <5d065c3d-9b78-4039-9457-f2cff0f536b4@amd.com>
Date: Tue, 24 Nov 2026 15:32:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] drm/amdkfd: Add awareness of THP of device and
 system RAM in kfd svm driver
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261122202653.274580-1-xiaogang.chen@amd.com>
 <20261122202653.274580-2-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261122202653.274580-2-xiaogang.chen@amd.com>
X-ClientProxiedBy: YQBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::14) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 1525599a-e1a8-4531-5911-08df4a6a2196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|8096899003|261026140227099003|4143699003|11063799006|10067099003|56012099006|261026121527099003|261021121427099003|261022105027099003|261102123227099003|261022113327099003|261102130727099003|261021123027099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: IKftzzAxj20KfYP3pIOZuORL7SU0SWtopkuBWorFd41Tji5FeHUzHlArm3obEYSQ37AFfTxQkcbJVKAzryxBPpDCCPlGXi3q2VhOaOOWlKCzt2OYp74g3fpyxegqs+RoHwWCP2mfUIN/MCcVQXBhV/Vvf1VjBWV8RnoC7vKfZsfYudaASb07JyEy5Va+v+F5MuEsAcBVC2zsSXMUDbFBdSLyYmGJe33mUNpIJ7tbh4cGB5gqkekhnFyVl8qa0cf8RR3ABwKljqMzL3Ah1TxNB870nBi9263nEM8A8sI6VhzpDHrgYO5WsntQJyDIxk/OAd/wcaDMy9vHneJh2ibUjJ/YgHvZKPUOInlZOjOSVUmy4lnrvypStDwLF58jeRP9qZNjlX5hL4Q/S5NQwt9xXGw7dnQ10Hr+AZ1/9nMDjavd9VFH2S0IE9Jtkpz1COZkGrACWWRg/o9oNKld6WQpXLZmCDP+iXioukTmA/tiYQ1X4o+P9ClXCxiQirMlWHNPULB2St//EMrpmdls4XeMu5KA/xTyZfo6ciNHxmETf3hZ/y7qdaRkyppnG+JKJlzikvV/DbDBkeXL95oAawJ7JB+mSWynvtzHp+1oRP9boHYEpes9wgAzNEIejr0fDAZyoZAYt1UKgWtcyXT6h7XQMlXIe5OB22UTjXKOkse2XqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(8096899003)(261026140227099003)(4143699003)(11063799006)(10067099003)(56012099006)(261026121527099003)(261021121427099003)(261022105027099003)(261102123227099003)(261022113327099003)(261102130727099003)(261021123027099003)(261022075727099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2Zzb1dRN1dZRGF5YmFaNzFTUWdsY1dSeFFDTitvQ2NnVDZNNW1pbDB5K0s0?=
 =?utf-8?B?YWwvK0dHRzBVOTRPczkrL1kvWlBMSXdERjlDRGlOZkFWaTEzbEplTzJpNFJJ?=
 =?utf-8?B?MmRBRzVLSGxsM3psempjUmVMSHhqVVRzaE9yaVY5V3FDWU5qVktsVTRzT3VK?=
 =?utf-8?B?REk5M21vVmY1cFh0eEZHb2pLVjF0UmVLT1FwVTNkU1BtRUpFQUpjZnhpU2Fq?=
 =?utf-8?B?ZzRwYVBPM0l5N3B2RmFSdXVsVklISVdPdTFQWk43QXpHKy90MkcvT0JQY0JI?=
 =?utf-8?B?L0pqSGw1ZmF6YmJBRVk0NytVMTlJM1ZnMkJDTWs2dGxtWkdVTVZIRmJFZC9i?=
 =?utf-8?B?dlI5N1JCNDVMeEZOejdIZE8welNYYkVTcEhWUVoyVnVEMWRPeEJWQmxIMUM3?=
 =?utf-8?B?RnVoMzcvK2p2NG96bmJNQUJaSXJrMTR5anNEMWxNWng1QlJDTjlRUW9nMXk3?=
 =?utf-8?B?eW8zMEtuNUpGc2FMYTlPckNBbjh5WHl1RmNLR0FtU2VPVmlwWXprelRJc3JB?=
 =?utf-8?B?T1cyWXc5bmJwWmU3ZnRPc2c1QzY3U0VHT2pRMWJ5dzZKNEpGSGJJcVU0WFMw?=
 =?utf-8?B?RWJQWVpGa2d0MERGM0wxUnE4SWlzV1orSmFHQUlBb3U1SER1aTMwMElHQnhW?=
 =?utf-8?B?VlRCNkJnKzZnOVRNSUFxQWJOUVBEaE5HRXN6aWxyTjVycTNqZjZ5dE4xU2hk?=
 =?utf-8?B?MTM0VDMxS2dGUSs4U3VaL1lRWVVUMWlOV0ZwWElLZlN2a0hUZ3UreE83ZW5V?=
 =?utf-8?B?aTdTQ1p4YkhJcWh1RDg3bjBRcDdBK0JMUXNmRDRaY2FyKzJGeGxkZG91UUtB?=
 =?utf-8?B?STljRy9HTWZ5aVhhTklHVUlsYnpYc25FWThYcHFGZ1A2OFUxQ1dsUFhUaWFN?=
 =?utf-8?B?YTlsRmQ3aC82aldtOVdrRXlCMU03NGVBK2Z0Ui8rOHZ4UVJFT0FvUTQ0MUpC?=
 =?utf-8?B?VjVsemsxOW95N2hKMzNXNU40SDVXZmk5V2RLUVhSQUlIZWpDWWV6NXZCdFRV?=
 =?utf-8?B?MzJoRE11OE9oWERnb3Q5RXFkTzJDeDQ1aGJEMHhmaTVqMUFuWDJRK1F4bTVL?=
 =?utf-8?B?YnZxQm1jSHhHckc1azRQbklxbWliQzh6Tm5MYmdXTW5YS0h6NGxhQmRxdnlR?=
 =?utf-8?B?c0hMNmJRelMxT0JHY2gzanJGTUtzYU52UHBBVUloTldUWjI4c1lCSnArK0Jw?=
 =?utf-8?B?S1B2WWFHNHZCWE1JNGU0M3g5cFNxTndrQ0xwWWwvUkV6REIyUDZkem9ZYUNP?=
 =?utf-8?B?eWNlV0VieVkyRFh5c0lYYzhBdllZVkQ2TjZzT25xbDluVlpVd2JvL3JMOWQr?=
 =?utf-8?B?S00vMmlRRHNOT2JSR08wbVpCdTRJYndCdjRqYzFSYzFMak5MZGdNZGFoMWdX?=
 =?utf-8?B?OWdXSTR6NVlWWE95WncyZVNENjlwcUgzaWNzTTRDbnlJdHJyR2xDS2xYZDR1?=
 =?utf-8?B?TUx5aTZqZU12a1RhNkU5TUhJaXlqOHFRZ1pmS2NVVk42SDlsaE9LSnpHVnJs?=
 =?utf-8?B?NFNaZTJxMzRHNzhOY05zeDcxTS9XbHNuYW4xb0duTnFtaUhWSUNTcVVSWUlH?=
 =?utf-8?B?UzBTOXhoTXRJWXZHNmx5NDdXMG5oTGNGNGJkY2dTdTM4QU43Y202T0RzSmQz?=
 =?utf-8?B?SHZxZkFvZWdXNDJiS3ZCRk5GeVdVM1NyUGlKTVVuK1lOR0tRTU93RjNhNVlU?=
 =?utf-8?B?aDJLT3VMSFl5MnhTVjZmdnhOYXlzQXdVQ1Q2YnJpVXNQY0hFY1ltRjRPSE54?=
 =?utf-8?B?M2tPNkFDc0hXeU5hSVhOWnlhazlLL3RmVzZIeWJ3d0hxeUlYd2lzeEprd25a?=
 =?utf-8?B?UUIrbUl3NjBuK2E0QnMrN0ExUEs4ZVVaQ254ZUhGTTVibVE5L3JwdGNUOXp6?=
 =?utf-8?B?NEhsQ3R0M3Q2NzFCTHlDaGNSZHRlYXM0dTcyRTNSbEFaN3hQNnZmVjJVY05j?=
 =?utf-8?B?eDBLTlVOQjN3a2JBVVJyZUdwSVVaZ2l2a3JQNzZNc2VQaU80ZVVhelJXZEE0?=
 =?utf-8?B?Z0tVdDc4NzVkV1E3cTZHbnNoL3VvVkNTRzFSKzZxMEFBN3dHN3JxbUlaTDFs?=
 =?utf-8?B?WVpCV2RNOWpXZGN2Y1R1V0tDSXk5U28vZTJQV3V5Wis2bEdDd0RHYlFzRjhq?=
 =?utf-8?B?SFRYei9sNWZ0b3kvYXkvVTVwWThJeCt6bUhqK1ArL05ndDJYRWhFVmcrbWk2?=
 =?utf-8?B?dW53N0dra0MveDlreS83UGtlZ3d6QUxJWFR1d3ZmVFFtc0lXQ0ZSeXkwQkNp?=
 =?utf-8?B?WkJ3NklEUVVBb3BGOVIveTJWVi9YeVJhVlJZYlZZNnVVNTVwTGsvK3hicmhn?=
 =?utf-8?Q?ujwDctk2xXqx468rd+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1525599a-e1a8-4531-5911-08df4a6a2196
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:33:00.3060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WC8L8jmoO0N4kB5xvae5I96fwN5ClLTXNenAgxEJwfiqR5yIdcvLRrgn58yHYAD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------oF67xRde9NE176pXlaSDwRTC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-22 15:26, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> Extend kfd/svm functions to allocate HPAGE_PMD_SIZE based device memory by
> buddy allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned; and to
> allocate THP system ram by vma_alloc_folio.
>
> Introduce SVM_RANGE_DMA_THP flag that indicates dma map of THP. THP dma
> addresss will use this flag.
>
> Add dev_pagemap_ops->folio_split callback that is called by folio_split when
> core MM splits device memory folio.
>
> Reset compound folio of device memory after it got released from core HMM.
> So, TTM can reuse this VRAM as 4K pages on next range.
>
> These are preparations for following support for (THP) migration of zone
> device-private memory, no function change.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 112 ++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  39 ++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  18 ++++
>   3 files changed, 152 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 1eb92ac6eb05..5ead98a604b1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -218,17 +218,45 @@ svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
>   	return (addr + adev->kfd.pgmap.range.start) >> PAGE_SHIFT;
>   }
>   
> +/*
> + * TTM can reuse a 2MB VRAM block that was previously a device THP.
> + * Reset unused pages so the next 4K init does not see leftover head/tail.
> + */
> +static void svm_migrate_clear_compound_pages(struct page *page, unsigned int nr,
> +					      struct dev_pagemap *pgmap)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nr; i++, page++) {
> +		struct folio *new_folio = (struct folio *)page;
> +
> +		if (page_count(page))
> +			continue;
> +
> +		page->flags.f &= ~0xffUL;
> +#ifdef NR_PAGES_IN_LARGE_FOLIO
> +		((struct folio *)(page - 1))->_nr_pages = 0;
> +#endif
> +		new_folio->mapping = NULL;
> +		new_folio->pgmap = pgmap;
> +		new_folio->share = 0;
> +		page->zone_device_data = NULL;
> +	}
> +}
> +
>   static void
> -svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
> +svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
> +			   int order)
>   {
> -	struct page *page;
> +	struct page *page = pfn_to_page(pfn);
>   
> -	page = pfn_to_page(pfn);
> -	svm_range_bo_ref(prange->svm_bo);
> +	/* Init this pfn, not page_folio() — that follows a leftover tail to the old head. */
> +	zone_device_folio_init((struct folio *)page, page_pgmap(page), order);
>   	page->zone_device_data = prange->svm_bo;
> -	zone_device_page_init(page, page_pgmap(page), 0);
> +	svm_range_bo_ref(prange->svm_bo);
>   }
>   
> +
>   static void
>   svm_migrate_put_vram_page(struct amdgpu_device *adev, unsigned long addr)
>   {
> @@ -249,11 +277,45 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
>   }
>   
>   static struct page *
> -svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
> +svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr,
> +			  unsigned long order)
>   {
>   	struct page *page;
>   
> -	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
> +	if (order) {
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +		struct folio *folio;
> +		gfp_t gfp;
> +
> +		/*
> +		 * Honour MADV_NOHUGEPAGE and prctl(PR_SET_THP_DISABLE). The
> +		 * sysfs THP policy (thp_vma_allowable_orders()) and
> +		 * vma_thp_gfp_mask() are not exported to modules.
> +		 */
> +		if (vma_thp_disabled(vma, vma->vm_flags, false))
> +			return NULL;
> +
> +		/*
> +		 * Used by every VRAM to RAM migration (CPU/GPU fault,
> +		 * prefetch, TTM eviction), and the caller falls back to 4K
> +		 * pages on failure. Fail fast like the default "madvise"
> +		 * defrag policy: no direct reclaim or compaction unless the
> +		 * VMA asked for huge pages. Eviction in particular runs under
> +		 * memory pressure, where compaction stalls are most costly.
> +		 */
> +		gfp = GFP_TRANSHUGE_LIGHT;
> +		if (vma->vm_flags & VM_HUGEPAGE)
> +			gfp |= __GFP_DIRECT_RECLAIM;
> +
> +		folio = vma_alloc_folio(gfp, order, vma, addr);
> +		page = folio ? folio_page(folio, 0) : NULL;
> +#else
> +		return NULL;
> +#endif
> +	} else {
> +		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
> +	}
> +
>   	if (page)
>   		lock_page(page);
>   
> @@ -267,8 +329,13 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>   
>   	for (i = 0; i < migrate->npages; i++) {
>   		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
> -		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
> -			mpages++;
> +			migrate->src[i] & MIGRATE_PFN_MIGRATE) {
> +
> +			if (migrate->dst[i] & MIGRATE_PFN_COMPOUND)
> +				mpages += SVM_HPAGE_PMD_NR;
> +			else
> +				mpages++;
> +		}
>   	}
>   	return mpages;
>   }
> @@ -312,7 +379,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   				migrate->dst[i] = 0;
>   				spage = NULL;
>   			} else {
> -				svm_migrate_get_vram_page(prange, migrate->dst[i]);
> +				svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
>   				migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>   				mpages++;
>   			}
> @@ -626,10 +693,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	return r < 0 ? r : 0;
>   }
>   
> +/* folio can be compound folio or single page */
>   static void svm_migrate_folio_free(struct folio *folio)
>   {
>   	struct page *page = &folio->page;
>   	struct svm_range_bo *svm_bo = page->zone_device_data;
> +	struct dev_pagemap *pgmap = folio->pgmap;
> +	unsigned int order = folio_order(folio);
> +
> +	/* So TTM can reuse this VRAM as 4K pages on the next range. */
> +	if (order)
> +		svm_migrate_clear_compound_pages(page, 1U << order, pgmap);
>   
>   	if (svm_bo) {
>   		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
> @@ -688,7 +762,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			j = 0;
>   		}
>   
> -		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
> +		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
>   		if (!dpage) {
>   			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>   				 prange->svms, prange->start, prange->last);
> @@ -1091,9 +1165,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   	return r ? VM_FAULT_SIGBUS : 0;
>   }
>   
> +static void svm_migrate_folio_split(struct folio *head, struct folio *tail)
> +{
> +	struct svm_range_bo *svm_bo;
> +
> +	if (tail == NULL)
> +		return;
> +
> +	tail->pgmap = head->pgmap;
> +	tail->mapping = head->mapping;
> +
> +	svm_bo = folio_zone_device_data(head);
> +	folio_set_zone_device_data(tail, svm_bo);
> +	svm_range_bo_ref(svm_bo);
> +}
> +
>   static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
>   	.folio_free		= svm_migrate_folio_free,
>   	.migrate_to_ram		= svm_migrate_to_ram,
> +	.folio_split		= svm_migrate_folio_split,
>   };
>   
>   /* Each VRAM page uses sizeof(struct page) on system memory */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 421d3f65fcf1..35cebdad5651 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -246,7 +246,16 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>   			continue;
>   		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
> -		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
> +
> +		/* dma unmap of THP */
> +		if (dma_addr[i] & SVM_RANGE_DMA_THP) {
> +			dma_addr[i] &= ~SVM_RANGE_DMA_THP;
> +			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*SVM_HPAGE_PMD_NR,
> +				       DMA_BIDIRECTIONAL);
> +		} else {
> +			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
> +		}
> +
>   		dma_addr[i] = 0;
>   	}
>   }
> @@ -579,10 +588,20 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   	}
>   
>   	memset(&bp, 0, sizeof(bp));
> +	/*
> +	 * Keep bp.size equal to the prange size so it matches the
> +	 * amdgpu_amdkfd_reserve_mem_limit() reservation made by the caller.
> +	 * A 2MB byte_align makes the VRAM manager allocate 2MB-aligned 2MB
> +	 * buddy blocks and trim only the last one to the requested size, so
> +	 * every full 2MB chunk can still back a device THP.
> +	 */
>   	bp.size = prange->npages * PAGE_SIZE;
> +	if (SVM_THP_ENABLED && prange->npages >= SVM_HPAGE_PMD_NR)
> +		bp.byte_align = SVM_HPAGE_PMD_SIZE;
> +	else
> +		bp.byte_align = PAGE_SIZE;
>   	bp.bo_ptr_size = sizeof(struct svm_range_bo);
>   	bp.destroy = svm_range_bo_destroy;
> -	bp.byte_align = PAGE_SIZE;
>   	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>   	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>   	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
> @@ -594,9 +613,16 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   
>   	r = amdgpu_bo_create(node->adev, &bp, &bo);
>   	if (r) {
> -		pr_debug("failed %d to create bo\n", r);
> -		mmput(mm);
> -		goto create_bo_failed;
> +		if (bp.byte_align == SVM_HPAGE_PMD_SIZE) {
> +			/* fall back PAGE_SIZE granularity */
> +			bp.byte_align = PAGE_SIZE;
> +			r = amdgpu_bo_create(node->adev, &bp, &bo);
> +		}
> +		if (r) {
> +			pr_debug("failed %d to create bo\n", r);
> +			mmput(mm);
> +			goto create_bo_failed;
> +		}
>   	}
>   
>   	svm_bo = to_svm_range_bo(bo);
> @@ -957,6 +983,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
>   	*vram_pages = 0;
>   	for (i = 0; i < num_elements; i++) {
>   		dma_addr_t *temp;
> +
>   		temp = (dma_addr_t *)dst + i;
>   		*temp = *((dma_addr_t *)src + i);
>   		if (*temp&SVM_RANGE_VRAM_DOMAIN)
> @@ -1675,7 +1702,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
>   	uint32_t gpuidx;
>   	int r;
>   
> -	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
> +	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
>   	drm_exec_until_all_locked(&ctx->exec) {
>   		for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
>   			pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 38744e716f74..8767a784e679 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -35,6 +35,24 @@
>   #include "kfd_priv.h"
>   
>   #define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
> +#define SVM_RANGE_DMA_THP (1UL << 1)
> +
> +/*
> + * Size of a PMD-mapped device or system THP. HPAGE_PMD_* expand to
> + * BUILD_BUG() without CONFIG_TRANSPARENT_HUGEPAGE, so the SVM code uses
> + * these instead. Without THP, SVM_THP_ENABLED is false, no compound
> + * migration is requested, and HMM never reports MIGRATE_PFN_COMPOUND, so
> + * the THP paths still compile but are never taken.
> + */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define SVM_HPAGE_PMD_ORDER	HPAGE_PMD_ORDER
> +#else
> +#define SVM_HPAGE_PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> +#endif
> +#define SVM_HPAGE_PMD_NR	(1UL << SVM_HPAGE_PMD_ORDER)
> +#define SVM_HPAGE_PMD_SIZE	(PAGE_SIZE << SVM_HPAGE_PMD_ORDER)
> +#define SVM_THP_ENABLED		IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> +
Look at drm_pagemap: commit 04b177544a04 ("drm/pagemap: Guard 
HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION") took a 
similar approach, and it was then reverted by 1ff399c4cd13.

I suggest dropping SVM_HPAGE_PMD_* and SVM_THP_ENABLED and using 
HPAGE_PMD_* directly.

Put thp_migration_supported() first in every condition that leads to 
HPAGE_PMD_*, so the compiler drops the whole branch when THP migration 
is not supported. For example:
if (thp_migration_supported() && (migrate->src[i] & MIGRATE_PFN_COMPOUND)) {
         ... HPAGE_PMD_NR ...
}

Regards,
Philip
>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>   			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
>   

--------------oF67xRde9NE176pXlaSDwRTC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-22 15:26, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

Extend kfd/svm functions to allocate HPAGE_PMD_SIZE based device memory by
buddy allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned; and to
allocate THP system ram by vma_alloc_folio.

Introduce SVM_RANGE_DMA_THP flag that indicates dma map of THP. THP dma
addresss will use this flag.

Add dev_pagemap_ops-&gt;folio_split callback that is called by folio_split when
core MM splits device memory folio.

Reset compound folio of device memory after it got released from core HMM.
So, TTM can reuse this VRAM as 4K pages on next range.

These are preparations for following support for (THP) migration of zone
device-private memory, no function change.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 112 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  39 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  18 ++++
 3 files changed, 152 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 1eb92ac6eb05..5ead98a604b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -218,17 +218,45 @@ svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
 	return (addr + adev-&gt;kfd.pgmap.range.start) &gt;&gt; PAGE_SHIFT;
 }
 
+/*
+ * TTM can reuse a 2MB VRAM block that was previously a device THP.
+ * Reset unused pages so the next 4K init does not see leftover head/tail.
+ */
+static void svm_migrate_clear_compound_pages(struct page *page, unsigned int nr,
+					      struct dev_pagemap *pgmap)
+{
+	unsigned int i;
+
+	for (i = 0; i &lt; nr; i++, page++) {
+		struct folio *new_folio = (struct folio *)page;
+
+		if (page_count(page))
+			continue;
+
+		page-&gt;flags.f &amp;= ~0xffUL;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+		((struct folio *)(page - 1))-&gt;_nr_pages = 0;
+#endif
+		new_folio-&gt;mapping = NULL;
+		new_folio-&gt;pgmap = pgmap;
+		new_folio-&gt;share = 0;
+		page-&gt;zone_device_data = NULL;
+	}
+}
+
 static void
-svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
+svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
+			   int order)
 {
-	struct page *page;
+	struct page *page = pfn_to_page(pfn);
 
-	page = pfn_to_page(pfn);
-	svm_range_bo_ref(prange-&gt;svm_bo);
+	/* Init this pfn, not page_folio() — that follows a leftover tail to the old head. */
+	zone_device_folio_init((struct folio *)page, page_pgmap(page), order);
 	page-&gt;zone_device_data = prange-&gt;svm_bo;
-	zone_device_page_init(page, page_pgmap(page), 0);
+	svm_range_bo_ref(prange-&gt;svm_bo);
 }
 
+
 static void
 svm_migrate_put_vram_page(struct amdgpu_device *adev, unsigned long addr)
 {
@@ -249,11 +277,45 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
 }
 
 static struct page *
-svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
+svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr,
+			  unsigned long order)
 {
 	struct page *page;
 
-	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+	if (order) {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		struct folio *folio;
+		gfp_t gfp;
+
+		/*
+		 * Honour MADV_NOHUGEPAGE and prctl(PR_SET_THP_DISABLE). The
+		 * sysfs THP policy (thp_vma_allowable_orders()) and
+		 * vma_thp_gfp_mask() are not exported to modules.
+		 */
+		if (vma_thp_disabled(vma, vma-&gt;vm_flags, false))
+			return NULL;
+
+		/*
+		 * Used by every VRAM to RAM migration (CPU/GPU fault,
+		 * prefetch, TTM eviction), and the caller falls back to 4K
+		 * pages on failure. Fail fast like the default &quot;madvise&quot;
+		 * defrag policy: no direct reclaim or compaction unless the
+		 * VMA asked for huge pages. Eviction in particular runs under
+		 * memory pressure, where compaction stalls are most costly.
+		 */
+		gfp = GFP_TRANSHUGE_LIGHT;
+		if (vma-&gt;vm_flags &amp; VM_HUGEPAGE)
+			gfp |= __GFP_DIRECT_RECLAIM;
+
+		folio = vma_alloc_folio(gfp, order, vma, addr);
+		page = folio ? folio_page(folio, 0) : NULL;
+#else
+		return NULL;
+#endif
+	} else {
+		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+	}
+
 	if (page)
 		lock_page(page);
 
@@ -267,8 +329,13 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 
 	for (i = 0; i &lt; migrate-&gt;npages; i++) {
 		if (migrate-&gt;dst[i] &amp; MIGRATE_PFN_VALID &amp;&amp;
-		    migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE)
-			mpages++;
+			migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
+
+			if (migrate-&gt;dst[i] &amp; MIGRATE_PFN_COMPOUND)
+				mpages += SVM_HPAGE_PMD_NR;
+			else
+				mpages++;
+		}
 	}
 	return mpages;
 }
@@ -312,7 +379,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 				migrate-&gt;dst[i] = 0;
 				spage = NULL;
 			} else {
-				svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
+				svm_migrate_get_vram_page(prange, migrate-&gt;dst[i], 0);
 				migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
 				mpages++;
 			}
@@ -626,10 +693,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	return r &lt; 0 ? r : 0;
 }
 
+/* folio can be compound folio or single page */
 static void svm_migrate_folio_free(struct folio *folio)
 {
 	struct page *page = &amp;folio-&gt;page;
 	struct svm_range_bo *svm_bo = page-&gt;zone_device_data;
+	struct dev_pagemap *pgmap = folio-&gt;pgmap;
+	unsigned int order = folio_order(folio);
+
+	/* So TTM can reuse this VRAM as 4K pages on the next range. */
+	if (order)
+		svm_migrate_clear_compound_pages(page, 1U &lt;&lt; order, pgmap);
 
 	if (svm_bo) {
 		pr_debug_ratelimited(&quot;ref: %d\n&quot;, kref_read(&amp;svm_bo-&gt;kref));
@@ -688,7 +762,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr);
+		dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr, 0);
 		if (!dpage) {
 			pr_debug(&quot;failed get page svms 0x%p [0x%lx 0x%lx]\n&quot;,
 				 prange-&gt;svms, prange-&gt;start, prange-&gt;last);
@@ -1091,9 +1165,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	return r ? VM_FAULT_SIGBUS : 0;
 }
 
+static void svm_migrate_folio_split(struct folio *head, struct folio *tail)
+{
+	struct svm_range_bo *svm_bo;
+
+	if (tail == NULL)
+		return;
+
+	tail-&gt;pgmap = head-&gt;pgmap;
+	tail-&gt;mapping = head-&gt;mapping;
+
+	svm_bo = folio_zone_device_data(head);
+	folio_set_zone_device_data(tail, svm_bo);
+	svm_range_bo_ref(svm_bo);
+}
+
 static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
 	.folio_free		= svm_migrate_folio_free,
 	.migrate_to_ram		= svm_migrate_to_ram,
+	.folio_split		= svm_migrate_folio_split,
 };
 
 /* Each VRAM page uses sizeof(struct page) on system memory */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 421d3f65fcf1..35cebdad5651 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -246,7 +246,16 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
 		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
 		pr_debug_ratelimited(&quot;unmap 0x%llx\n&quot;, dma_addr[i] &gt;&gt; PAGE_SHIFT);
-		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
+
+		/* dma unmap of THP */
+		if (dma_addr[i] &amp; SVM_RANGE_DMA_THP) {
+			dma_addr[i] &amp;= ~SVM_RANGE_DMA_THP;
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*SVM_HPAGE_PMD_NR,
+				       DMA_BIDIRECTIONAL);
+		} else {
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
+		}
+
 		dma_addr[i] = 0;
 	}
 }
@@ -579,10 +588,20 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	}
 
 	memset(&amp;bp, 0, sizeof(bp));
+	/*
+	 * Keep bp.size equal to the prange size so it matches the
+	 * amdgpu_amdkfd_reserve_mem_limit() reservation made by the caller.
+	 * A 2MB byte_align makes the VRAM manager allocate 2MB-aligned 2MB
+	 * buddy blocks and trim only the last one to the requested size, so
+	 * every full 2MB chunk can still back a device THP.
+	 */
 	bp.size = prange-&gt;npages * PAGE_SIZE;
+	if (SVM_THP_ENABLED &amp;&amp; prange-&gt;npages &gt;= SVM_HPAGE_PMD_NR)
+		bp.byte_align = SVM_HPAGE_PMD_SIZE;
+	else
+		bp.byte_align = PAGE_SIZE;
 	bp.bo_ptr_size = sizeof(struct svm_range_bo);
 	bp.destroy = svm_range_bo_destroy;
-	bp.byte_align = PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
@@ -594,9 +613,16 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 
 	r = amdgpu_bo_create(node-&gt;adev, &amp;bp, &amp;bo);
 	if (r) {
-		pr_debug(&quot;failed %d to create bo\n&quot;, r);
-		mmput(mm);
-		goto create_bo_failed;
+		if (bp.byte_align == SVM_HPAGE_PMD_SIZE) {
+			/* fall back PAGE_SIZE granularity */
+			bp.byte_align = PAGE_SIZE;
+			r = amdgpu_bo_create(node-&gt;adev, &amp;bp, &amp;bo);
+		}
+		if (r) {
+			pr_debug(&quot;failed %d to create bo\n&quot;, r);
+			mmput(mm);
+			goto create_bo_failed;
+		}
 	}
 
 	svm_bo = to_svm_range_bo(bo);
@@ -957,6 +983,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
 	*vram_pages = 0;
 	for (i = 0; i &lt; num_elements; i++) {
 		dma_addr_t *temp;
+
 		temp = (dma_addr_t *)dst + i;
 		*temp = *((dma_addr_t *)src + i);
 		if (*temp&amp;SVM_RANGE_VRAM_DOMAIN)
@@ -1675,7 +1702,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
 	uint32_t gpuidx;
 	int r;
 
-	drm_exec_init(&amp;ctx-&gt;exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
+	drm_exec_init(&amp;ctx-&gt;exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
 	drm_exec_until_all_locked(&amp;ctx-&gt;exec) {
 		for_each_set_bit(gpuidx, ctx-&gt;bitmap, MAX_GPU_INSTANCE) {
 			pdd = kfd_process_device_from_gpuidx(ctx-&gt;process, gpuidx);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 38744e716f74..8767a784e679 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,6 +35,24 @@
 #include &quot;kfd_priv.h&quot;
 
 #define SVM_RANGE_VRAM_DOMAIN (1UL &lt;&lt; 0)
+#define SVM_RANGE_DMA_THP (1UL &lt;&lt; 1)
+
+/*
+ * Size of a PMD-mapped device or system THP. HPAGE_PMD_* expand to
+ * BUILD_BUG() without CONFIG_TRANSPARENT_HUGEPAGE, so the SVM code uses
+ * these instead. Without THP, SVM_THP_ENABLED is false, no compound
+ * migration is requested, and HMM never reports MIGRATE_PFN_COMPOUND, so
+ * the THP paths still compile but are never taken.
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define SVM_HPAGE_PMD_ORDER	HPAGE_PMD_ORDER
+#else
+#define SVM_HPAGE_PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
+#endif
+#define SVM_HPAGE_PMD_NR	(1UL &lt;&lt; SVM_HPAGE_PMD_ORDER)
+#define SVM_HPAGE_PMD_SIZE	(PAGE_SIZE &lt;&lt; SVM_HPAGE_PMD_ORDER)
+#define SVM_THP_ENABLED		IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
+</pre>
    </blockquote>
    Look at drm_pagemap: commit 04b177544a04 (&quot;drm/pagemap: Guard
    HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION&quot;) took a
    similar approach, and it was then reverted by 1ff399c4cd13.<br>
    <br>
    I suggest dropping SVM_HPAGE_PMD_* and SVM_THP_ENABLED and using
    HPAGE_PMD_* directly.<br>
    <br>
    Put thp_migration_supported() first in every condition that leads to
    HPAGE_PMD_*, so the compiler drops the whole branch when THP
    migration is not supported. For example:<br>
    if (thp_migration_supported() &amp;&amp; (migrate-&gt;src[i] &amp;
    MIGRATE_PFN_COMPOUND)) {<br>
    &nbsp; &nbsp; &nbsp; &nbsp; ... HPAGE_PMD_NR ...<br>
    }<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20261122202653.274580-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 #define SVM_ADEV_PGMAP_OWNER(adev)\
 			((adev)-&gt;hive ? (void *)(adev)-&gt;hive : (void *)(adev))
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------oF67xRde9NE176pXlaSDwRTC--
