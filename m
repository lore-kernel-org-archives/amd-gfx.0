Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C1606A329
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=i2vG3OmD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBC610ECAC;
	Fri, 13 Nov 2026 23:31:25 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8291710E159
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 23:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5JEghpY4Ny5qcO5ZeiiQFnB8W8n4fAtE4E4DAN6NXXHUKqbycHA6FWgWbMwMJKzBX+wcc8lykw9kHN7bBhtplA9efwVjgWLriI6XhjFckDLf0ejqckBQWsWUr1UL4G6QxF3i3S4/evSb5RESj8GbrVuHjE7+b0hvuAwtZdzyhm20JfrdX7FXXIQZI/I474Xkmio7yAcSF3eVof+EpmtJttsU49O/X3xAvGjB5lBfS4EQXDSxd1xAKt3j7+qR1j9yU4DjkOxnBj3iX4vkkkL4hwA/m4Q07dFws7nEuCK1VMaNeMwwBcgQFcriF4FpNXbBYYZb9zPVV69KVhQFuxXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZEI9u9W1FdXVmwZr8tJYdeO4sdoz1sgTYQMEIVSLtQ=;
 b=g9pdESkLSWGDed5EdfnjmiEGDsNAWIbk0idMC8JGD6nyEuemiMPIKrKfjZOBU2tN9AljRD0B86ve9wLi1CowZfkbPEC67EEpKmPtTr7GHwZTXQKce1Dw3r9p98xEQLh2CjR7+FRauQK/IVpNHdw++GFykAkx35XvOYs1aVAw/Cn73Zi9D8k7cze5VIXhCoj7ZNOtbhFhdcQcLLvBqVRRRkWHIRlfkrOPRV6ArgNByYWAvNKEDifx6WSW5mkreKz8rXBj4CSF5JmKRPugiPipFRLudPEGI/Oln0E1v+L4Cpgprd5cp8HWWNrqupotyWXSME4IZ2QB3alTXv5mWWbeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZEI9u9W1FdXVmwZr8tJYdeO4sdoz1sgTYQMEIVSLtQ=;
 b=i2vG3OmDf8TrOhSuT8bPZbQW1TWjrcr4Vzlp0le6EewIDRfRCtensuUbbjXgsM67nVtk1H54jdGN7S6gUOOQLI1mZ+QME7F6VIvu4NLdeTZehOjpV5T0YTfd3a+tVEK3nnt64yTKiQHYUejS3rVuVLQHglaUIxiMbCPrBltjXF0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by DS3PR12MB999217.namprd12.prod.outlook.com (2603:10b6:8:390::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 23:28:55 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 23:28:54 +0000
Content-Type: multipart/alternative;
 boundary="------------c3FxEl9bHQjmVY4QSI5NEQuN"
Message-ID: <2740efce-be38-4a82-98cf-4ddb6cc1212f@amd.com>
Date: Fri, 13 Nov 2026 18:28:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdkfd: Add awareness of THP of device and
 system RAM in kfd svm driver
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261019133845.166916-1-xiaogang.chen@amd.com>
 <20261019133845.166916-2-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261019133845.166916-2-xiaogang.chen@amd.com>
X-ClientProxiedBy: YT4PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::12) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|DS3PR12MB999217:EE_
X-MS-Office365-Filtering-Correlation-Id: d07bb383-44d5-42c9-9173-08df41dde17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022113327099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|8096899003;
X-Microsoft-Antispam-Message-Info: ximtPzLaIdPKLcnKsO1AiY9S5JmdtIC0jGBcW1lpb6PBpEvecRoelnzp6utU/lNG7aXeoWcBRQ9TAhq6RsWoJ5HEMNZokFpyl/e1fZMM8PdKqc9WdVT6Ut7CxLfT2+YEwladVmHXXMOQFWNgnGAI5W9ZWU+OnNzbQKYMIxEJSb6w6+7/Iv1JI2hHc34U1oQLf9hlviQMeOgpgQgCPqXNFK/O10Gr6WYytfFGk6gqrVfGp1SeaYQJRdzKX8JYuTN/kzkpn+SBozfjf6vkFlZ6QFQONaTnFR3M/mYN6sDB8t4ThxaTvl1xhRm0IBJGECkBbcaBQWEiLyJZrTPSFAmmXiI9UwdCHYGy9V1l3LVaYYXvPSvX0pm5XWzQTLrJ47DBpD/M0aJVzWzGwJxYWDwVQq3SI1BSvh3Mve09k5unD3R3KS3C4hpMLi1PSBeCqxNILPCsm8nk1bigdbNWz1vbf2HBo2z1XYT6Wcn3rpan03wkQ/t8ELg0FZ4a0qlrL74aBzNrmhfLfAx7s/Fodoi45zEBKkMs9tElFsWx/uQZSOKBCL5ymm3TcQ2Itg0R+6jkMp+ozI/d1RucOhfM+C3zCP9+EHwiReDEHt8O2RuBNd4Tm2/kDIRsbjrla4FJqG/W8FZ2w6goSJ8FEG69mdQ7MqCQjFMtFstmsMlOWDO/BEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022113327099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm9pQnNTTCs1ZzJHcm5kOFdnWG9Lc1pBYzB6RFYvODUwMjM0bHlRMVNoM09y?=
 =?utf-8?B?SFJiZXRvNnZsZnNNeExTaWlzSnZ5ejEyc3JGTHRiM3dyVUFlem9RWmUwUzcy?=
 =?utf-8?B?bmVsMVBBTDBMWlAzQWtpL2pJa1dQek5pd3ZGVUxGWU0wTUNoUGNGV0d6Vzdm?=
 =?utf-8?B?Q3BYTzdkeHJpTjEveUhWNUpWVjY1S081Vk5rSGk2SGxMVHA5VHhJZ1hDdU13?=
 =?utf-8?B?R0FaSGl1a2trKzFhKy8wUWF5S0h3aExCNGhudjZsdGZSdmZ4cHBUcGJCSDFm?=
 =?utf-8?B?SmhzYk9zQ3ZyOWZZVXBDY2RqbktxV0VuYVU3ck50Qld3ais3ZWZ0R0V1Y0Q0?=
 =?utf-8?B?ejBodFVWWk85bnN2b09SZ29oY1ZmdThESzk1RFRYS1l6ZmlWTCtQSTFnNHky?=
 =?utf-8?B?a21lNWVTY1NDRXh4MkI4UDNoQUJqaURHQ2VTeXJLWmZpMzlIdDBUWnZlNjRQ?=
 =?utf-8?B?SjR4bDBIVWs5VDRiWStYdjlHZGJpRkJFSVRndG5Dd01uNUZNK2g3YzdIYng5?=
 =?utf-8?B?SUxJMHBZZ0dBMGJ0aUxldkpYcmRHbGlCYnNjQjRnc3lTNnZNV0x6cE42bTVu?=
 =?utf-8?B?K0EwVW5TVEdKK3RRR0k1Qmd5ZldYSk94U2xtbm9rVTZISUJlOEIrRE5zczZ2?=
 =?utf-8?B?emxOL0lUUUhrM3VNRG5MUjFDYStBNUpPZitBeEkrYUhiZ1g2bFpUV2RzMnM5?=
 =?utf-8?B?amdzSDF6UUFqZlAxSE9qeTBkUWJFYjEzVkwwUVlVbncwaDlkMHR5NHFSc0lX?=
 =?utf-8?B?NGNtc3RJTm9IZWs2dTYwdmNxMTZlaUxWb2UzcTR5UzFRR0kyazhoMWNFRnAv?=
 =?utf-8?B?QW9YWkdnZkkydytlYlFtLzRDTTlYamhWUmd3VUNEdlhMaTAwK2gyM0ZwR2p0?=
 =?utf-8?B?RkphM0F5dE5EMkpkYlBTUnEwOHJQWkdmRWtsd2JBWDZlSU9xQkhLUHEzZW5M?=
 =?utf-8?B?UG1IbGN3NHFhNUJRWjFac29rWlN2bGlLSWlrSjA0OFhiVjZMUjhlNzhMSWgv?=
 =?utf-8?B?aGVlWjBuaWpxQ1Y1RGNPK3M3UFJqZjJPK3FtRzlISWx3OEorS0MxTER6VW44?=
 =?utf-8?B?R3BOdU5SVHYyYjdrZERoZ0hzZ3ErOUtmWVpMcUFGTWUvUm1YMkJMaVVHbmxZ?=
 =?utf-8?B?NTNDL3FFQ2xQY1lkSGJoY1pIQ2lRTE15cm96UHBxVVNiZUhDSUVILzAzK0NQ?=
 =?utf-8?B?WFpUZjJZdnRsZkpYODFMeEUxOVZ3K2ZjdFVIdjlSOWh2L29WQzVqUnZZTUxk?=
 =?utf-8?B?MUFweFhqc0pwd2JyRkZNVkRCU3Z6WkIxK29OVnZqNENlb3A0RGdZODFoMFJi?=
 =?utf-8?B?THE4dkMrc3lOSTdUU2srd2lrRkFHb09oQlJSZ21QcWx6MmpuSXZYODBSZi8w?=
 =?utf-8?B?WDlOY1Bqb0xRTGcyd2ZjRzFQMjB0MzU1UUtnRXYrenplWWRqUUEyZEN6a21R?=
 =?utf-8?B?NTdPQlREODR4dldkUndXSm9WNmpUdVJvbWlNVDNtVk5UUUc1K2trekc4TVdI?=
 =?utf-8?B?Z1NudWxSMm52MGMxWEpqVjVkaGJDWnVSZXptUnBBQTc3N2o2SElBVW1ZMndK?=
 =?utf-8?B?YnhCR3gzMFJxOFdZWjdlVldaOS9wbEM1UGVRc29scVk2QVVhS2ExU0EwSThu?=
 =?utf-8?B?WE9aNXR1alpiMTRYZVNlR1BJREFUL0NyTTlaRHJVT3grV3VxazNiTjVQNk9w?=
 =?utf-8?B?enR4UUFoM1YreldqeTRSeEY0cGYwaENEeHdLOEM5Z1U5LzdtY0Y5RTBTWGg4?=
 =?utf-8?B?RjlCUWs5UmxtRitwVUxteGFOaER4UWV0a3lPM1YrOTZhL1RnMkVGSTd3OXlO?=
 =?utf-8?B?V21PL1B3cUxudldUM3ZWb2t3NTdwaFltOWNCRGR2UmFEbXNEblBkOHNsUjdk?=
 =?utf-8?B?SlhER1V3SDVoYzVMdkR5elJxTDZaOUFBdWp3dXhzeTg4bXhRbUdKcEdLbEdO?=
 =?utf-8?B?VGl1UXZORk9naWY0TmhyUlFlb1J6MEhYMlA5NGY2eUlZcHFHMVdUWXZoaHlH?=
 =?utf-8?B?SWRQODVLUmh4WTQ3dUpqdmUzUGVlUW1weUdKR3FpelFLT01wS3FESWRPTGNa?=
 =?utf-8?B?UHJiVTlQNmNOL0hIU3hNWFJTOW1qWVk3dGFzWDBDRUdLVlhPWUxrKzVkRWRN?=
 =?utf-8?B?T1lDN0pIekRLRU9xT0dHM0VWWmxMWWRzdGd6VGJMRW9ScmVtKzRZeTgxVzNx?=
 =?utf-8?B?UlRyQUlQRllGcnBRZ3E1RER6UE12cHYya1o2QURlT25icW9xR1luYVlmTGli?=
 =?utf-8?B?SEhnNy9QcXRGSHQ2OFM2cHR0VHlIM3J3TzF0ejQzWWhtVjJBVXNuc0daNlRl?=
 =?utf-8?Q?pq1P+sDaC4wF5stG0G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d07bb383-44d5-42c9-9173-08df41dde17e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 23:28:53.8727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paFQeuyQYDIQSzMwi/nlRGg/5gd2ySYL8wW7rL2UAC4lO/rb6mejdnEACClWC15+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999217
X-OriginatorOrg: amd.com
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

--------------c3FxEl9bHQjmVY4QSI5NEQuN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-10-19 09:38, Xiaogang.Chen wrote:
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
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 84 ++++++++++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 37 +++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
>   3 files changed, 104 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 8b96e1fe741a..7a129c9954fc 100644
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
This is called after the device page is freed. When migrating, 
svm_migrate_get_vram_page() uses the VRAM page and 
zone_device_folio_init() does the same initialization, so this looks 
duplicated. Is it?
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
> @@ -249,11 +277,17 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
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
> +	if (order)
> +		page = folio_page(vma_alloc_folio(GFP_HIGHUSER,
> +						  order, vma, addr), 0);
vma_alloc_folio could fail, then folio_page has NULL access, should 
check vma_alloc_folio return value. if vma_alloc_folio() fails for order 
9, this fails the entire migration with -ENOMEM and the CPU fault 
becomes SIGBUS. migrate_vma_pages() already handles a compound source 
with a non-compound destination by splitting the source, so falling back 
to a 4K page here would be enough. Where is that handled?
> +	else
> +		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
> +
>   	if (page)
>   		lock_page(page);
>   
> @@ -267,8 +301,13 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>   
>   	for (i = 0; i < migrate->npages; i++) {
>   		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
> -		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
> -			mpages++;
> +			migrate->src[i] & MIGRATE_PFN_MIGRATE) {
> +
> +			if (migrate->dst[i] & MIGRATE_PFN_COMPOUND)
> +				mpages += HPAGE_PMD_NR;
> +			else
> +				mpages++;
> +		}
>   	}
>   	return mpages;
>   }
> @@ -302,7 +341,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>   			dst[i] = cursor.start + (j << PAGE_SHIFT);
>   			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> -			svm_migrate_get_vram_page(prange, migrate->dst[i]);
> +			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
>   			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>   			mpages++;
>   		}
> @@ -616,15 +655,22 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
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
>   
>   	if (svm_bo) {
>   		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
>   		svm_range_bo_unref_async(svm_bo);
>   	}
> +
> +	/* So TTM can reuse this VRAM as 4K pages on the next range. */
> +	if (order)
> +		svm_migrate_clear_compound_pages(page, 1U << order, pgmap);
>   }
>   
>   static int
> @@ -678,7 +724,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			j = 0;
>   		}
>   
> -		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
> +		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
>   		if (!dpage) {
>   			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>   				 prange->svms, prange->start, prange->last);
> @@ -1081,9 +1127,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
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
> index a99dbedf3cd4..8e1fb5df8abd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -245,7 +245,16 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>   			continue;
>   		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
> -		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
> +
> +		/* dma unmap of THP */
> +		if (dma_addr[i] & SVM_RANGE_DMA_THP) {
> +			dma_addr[i] &= ~SVM_RANGE_DMA_THP;
> +			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*HPAGE_PMD_NR,
> +				       DMA_BIDIRECTIONAL);
> +		} else {
> +			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
> +		}
> +
>   		dma_addr[i] = 0;
>   	}
>   }
> @@ -578,10 +587,15 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   	}
>   
>   	memset(&bp, 0, sizeof(bp));
> -	bp.size = prange->npages * PAGE_SIZE;
> +	if (prange->npages >= HPAGE_PMD_NR) {
> +		bp.size = ALIGN(prange->npages * PAGE_SIZE, HPAGE_PMD_SIZE);
> +		bp.byte_align = HPAGE_PMD_SIZE;
> +	} else {
> +		bp.size = prange->npages * PAGE_SIZE;
> +		bp.byte_align = PAGE_SIZE;
> +	}
seems don't need align size to 2MB, this will alloc vram that never 
used. For example size 3MB, byte_align to 2MB, gpu buddy allocator will 
return first block with 2MB, the second block 1MB. Regards, Philip
>   	bp.bo_ptr_size = sizeof(struct svm_range_bo);
>   	bp.destroy = svm_range_bo_destroy;
> -	bp.byte_align = PAGE_SIZE;
>   	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>   	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>   	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
> @@ -593,9 +607,17 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   
>   	r = amdgpu_bo_create(node->adev, &bp, &bo);
>   	if (r) {
> -		pr_debug("failed %d to create bo\n", r);
> -		mmput(mm);
> -		goto create_bo_failed;
> +		if (prange->npages >= HPAGE_PMD_NR) {
> +			/* fall back PAGE_SIZE granularity */
> +			bp.size = prange->npages * PAGE_SIZE;
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
> @@ -956,6 +978,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
>   	*vram_pages = 0;
>   	for (i = 0; i < num_elements; i++) {
>   		dma_addr_t *temp;
> +
>   		temp = (dma_addr_t *)dst + i;
>   		*temp = *((dma_addr_t *)src + i);
>   		if (*temp&SVM_RANGE_VRAM_DOMAIN)
> @@ -1628,7 +1651,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
>   	uint32_t gpuidx;
>   	int r;
>   
> -	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
> +	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
>   	drm_exec_until_all_locked(&ctx->exec) {
>   		for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
>   			pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index c7d7adae4476..f2b3a05cd8cf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -35,6 +35,7 @@
>   #include "kfd_priv.h"
>   
>   #define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
> +#define SVM_RANGE_DMA_THP (1UL << 1)
>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>   			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
>   

--------------c3FxEl9bHQjmVY4QSI5NEQuN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-19 09:38, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261019133845.166916-2-xiaogang.chen@amd.com">
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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 84 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 37 +++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
 3 files changed, 104 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8b96e1fe741a..7a129c9954fc 100644
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
+</pre>
    </blockquote>
    This is called after the device page is freed. When migrating,
    svm_migrate_get_vram_page() uses the VRAM page and
    zone_device_folio_init() does the same initialization, so this looks
    duplicated. Is it?
    <blockquote type="cite" cite="mid:20261019133845.166916-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
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
@@ -249,11 +277,17 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
 }
 
 static struct page *
-svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
+svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr,
+			  unsigned long order)
 {
 	struct page *page;
 
-	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+	if (order)
+		page = folio_page(vma_alloc_folio(GFP_HIGHUSER,
+						  order, vma, addr), 0);</pre>
    </blockquote>
    <span style="white-space: pre-wrap">vma_alloc_folio could fail, then folio_page has NULL access, should check vma_alloc_folio return value.

if vma_alloc_folio() fails for order 9, this fails the entire migration with -ENOMEM and the CPU fault becomes SIGBUS. migrate_vma_pages() already handles a compound source with a non-compound destination by splitting the source, so falling back to a 4K page here would be enough. Where is that handled?

</span>
    <blockquote type="cite" cite="mid:20261019133845.166916-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	else
+		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20261019133845.166916-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	if (page)
 		lock_page(page);
 
@@ -267,8 +301,13 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 
 	for (i = 0; i &lt; migrate-&gt;npages; i++) {
 		if (migrate-&gt;dst[i] &amp; MIGRATE_PFN_VALID &amp;&amp;
-		    migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE)
-			mpages++;
+			migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
+
+			if (migrate-&gt;dst[i] &amp; MIGRATE_PFN_COMPOUND)
+				mpages += HPAGE_PMD_NR;
+			else
+				mpages++;
+		}
 	}
 	return mpages;
 }
@@ -302,7 +341,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
 			dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
 			migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
+			svm_migrate_get_vram_page(prange, migrate-&gt;dst[i], 0);
 			migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
 			mpages++;
 		}
@@ -616,15 +655,22 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	return r &lt; 0 ? r : 0;
 }
 
+/* folio can be compound folio or single page */
 static void svm_migrate_folio_free(struct folio *folio)
 {
 	struct page *page = &amp;folio-&gt;page;
 	struct svm_range_bo *svm_bo = page-&gt;zone_device_data;
+	struct dev_pagemap *pgmap = folio-&gt;pgmap;
+	unsigned int order = folio_order(folio);
 
 	if (svm_bo) {
 		pr_debug_ratelimited(&quot;ref: %d\n&quot;, kref_read(&amp;svm_bo-&gt;kref));
 		svm_range_bo_unref_async(svm_bo);
 	}
+
+	/* So TTM can reuse this VRAM as 4K pages on the next range. */
+	if (order)
+		svm_migrate_clear_compound_pages(page, 1U &lt;&lt; order, pgmap);
 }
 
 static int
@@ -678,7 +724,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr);
+		dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr, 0);
 		if (!dpage) {
 			pr_debug(&quot;failed get page svms 0x%p [0x%lx 0x%lx]\n&quot;,
 				 prange-&gt;svms, prange-&gt;start, prange-&gt;last);
@@ -1081,9 +1127,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
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
index a99dbedf3cd4..8e1fb5df8abd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -245,7 +245,16 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
 		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
 		pr_debug_ratelimited(&quot;unmap 0x%llx\n&quot;, dma_addr[i] &gt;&gt; PAGE_SHIFT);
-		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
+
+		/* dma unmap of THP */
+		if (dma_addr[i] &amp; SVM_RANGE_DMA_THP) {
+			dma_addr[i] &amp;= ~SVM_RANGE_DMA_THP;
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*HPAGE_PMD_NR,
+				       DMA_BIDIRECTIONAL);
+		} else {
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
+		}
+
 		dma_addr[i] = 0;
 	}
 }
@@ -578,10 +587,15 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	}
 
 	memset(&amp;bp, 0, sizeof(bp));
-	bp.size = prange-&gt;npages * PAGE_SIZE;
+	if (prange-&gt;npages &gt;= HPAGE_PMD_NR) {
+		bp.size = ALIGN(prange-&gt;npages * PAGE_SIZE, HPAGE_PMD_SIZE);
+		bp.byte_align = HPAGE_PMD_SIZE;
+	} else {
+		bp.size = prange-&gt;npages * PAGE_SIZE;
+		bp.byte_align = PAGE_SIZE;
+	}</pre>
    </blockquote>
    <span style="white-space: pre-wrap">seems don't need align size to 2MB, this will alloc vram that never used. For example size 3MB, byte_align to 2MB, gpu buddy allocator will return first block with 2MB, the second block 1MB.

Regards,
Philip

</span>
    <blockquote type="cite" cite="mid:20261019133845.166916-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	bp.bo_ptr_size = sizeof(struct svm_range_bo);
 	bp.destroy = svm_range_bo_destroy;
-	bp.byte_align = PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
@@ -593,9 +607,17 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 
 	r = amdgpu_bo_create(node-&gt;adev, &amp;bp, &amp;bo);
 	if (r) {
-		pr_debug(&quot;failed %d to create bo\n&quot;, r);
-		mmput(mm);
-		goto create_bo_failed;
+		if (prange-&gt;npages &gt;= HPAGE_PMD_NR) {
+			/* fall back PAGE_SIZE granularity */
+			bp.size = prange-&gt;npages * PAGE_SIZE;
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
@@ -956,6 +978,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
 	*vram_pages = 0;
 	for (i = 0; i &lt; num_elements; i++) {
 		dma_addr_t *temp;
+
 		temp = (dma_addr_t *)dst + i;
 		*temp = *((dma_addr_t *)src + i);
 		if (*temp&amp;SVM_RANGE_VRAM_DOMAIN)
@@ -1628,7 +1651,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
 	uint32_t gpuidx;
 	int r;
 
-	drm_exec_init(&amp;ctx-&gt;exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
+	drm_exec_init(&amp;ctx-&gt;exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
 	drm_exec_until_all_locked(&amp;ctx-&gt;exec) {
 		for_each_set_bit(gpuidx, ctx-&gt;bitmap, MAX_GPU_INSTANCE) {
 			pdd = kfd_process_device_from_gpuidx(ctx-&gt;process, gpuidx);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c7d7adae4476..f2b3a05cd8cf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,6 +35,7 @@
 #include &quot;kfd_priv.h&quot;
 
 #define SVM_RANGE_VRAM_DOMAIN (1UL &lt;&lt; 0)
+#define SVM_RANGE_DMA_THP (1UL &lt;&lt; 1)
 #define SVM_ADEV_PGMAP_OWNER(adev)\
 			((adev)-&gt;hive ? (void *)(adev)-&gt;hive : (void *)(adev))
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------c3FxEl9bHQjmVY4QSI5NEQuN--
