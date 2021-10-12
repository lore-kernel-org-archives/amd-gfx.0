Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E72C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3ACB61050
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 13:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3ACB61050
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B2489D66;
	Tue, 12 Oct 2021 13:12:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E7089D66
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 13:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IX6rHn2lBy2ywt1C6nmqC2dXTOlPqSNNAPwTiUhi3yrL2wwTMtvU1fjixC00lP4Tsm3CC6PBMkQi31gRGYRb7B8EITv/6Vv2Q4UBIwejIP+kWWC2ZMK6tKJUbYkyObbB25cnvLUpcMwQkmYrzve6tKzloJOA4qZKDP/MeQqFLb0sDIA5gt+O/88DQF1tWo9GAqEPmdBvTUf9CJhJLcSErWo0YwCOby6X1NQ99LGifDOahlGfsq6rN4Gkp0SmfLdd9hfzaJTDDBZSq4adPKD39aCqEe2TPuwsgPSnDf1vaCO7ZCT5x/ck7FhUPoHT39DibjULbf5E7klglpMb0CWJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h93A0WJeQPEbh6noMgFUPyQ6vo2UExQ2AaQNWoCClvo=;
 b=VamiS1S8lXVrlgntCGciPg8GXNXjPJIDKpA33sIDiiQx70/xYlC9NF3PiNNe0qyzUo/B+29e6ZgEJ/BW8Zi+S/Lkx0l3jjFYDEMC/co8egqSAZwmCeNiFxBwnGyZfcnW99mzxQPPSgkMpb4iaeSOFl2Yt6kyZCcl7I1QJ1Fty3y7SbB1Yuzmdv9nAZ/QpAY+t+GQQWISczPo4hSVuNVss2PqE7n0lwtnr3Oymjcc6dGwYJXVB12aTxJRzf11REHtXBDlP6m0HWc81rwPWM6/P2CXbtlr5JTKU3qjvsITccXG7Vvxcln5OHPKk2UjZ0wVqXt+BgBu6GTEkf0VkMe1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h93A0WJeQPEbh6noMgFUPyQ6vo2UExQ2AaQNWoCClvo=;
 b=IKPIHiDni0aW3X3eYNbJY046zNan6qg5QqlyDSnvcLwwtpOS8oN25F2Gope4xjJjPmd+9GL/Kkbvr09T49W0UFDItKQ0J7nPgcKn6vZ6dZfDUQP//FLFKnNZRK2R8EEKVpFC49OCoMkaFthVuVZ1Z03UXPnnk375ND5HnTlgCOg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Tue, 12 Oct
 2021 13:12:34 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 13:12:34 +0000
Subject: Re: [PATCH Review 1/1] drm/ttm: fix debugfs node create failed
To: amd-gfx@lists.freedesktop.org
References: <20211012115834.19577-1-Stanley.Yang@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <7cab58fe-c6ba-c5cb-921d-67a86ccda725@amd.com>
Date: Tue, 12 Oct 2021 15:12:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211012115834.19577-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.110.202) by
 FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:48::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.4 via Frontend Transport; Tue, 12 Oct 2021 13:12:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b67125ea-c7e9-40e2-4289-08d98d81f44b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5167C77E0886C0E5942523328BB69@DM4PR12MB5167.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obItFg+yPHhwoVV89JSwM2x80v/nbK7JWdOuiYTRQfLXKKFzW/ZplnGuAmMWDYBTEfgQeWDyCVIHaPmlk/AgrlJ2SkCLYI/iOlFwmKc90H+wNJPjc6HTrfXVuQm+77ATRxFoLB9EoJOX3RwPHKPwU2BHgf5QcqiY78Eotg+17qto3mzEkGEI5Xtitq9l5ONuGXgNtfRVS/Ksih+HmuKs8TkgV8mm39fiCt9neWK1AzxWvYXQroF72PCmoHmrGAWSJrJoXpceULwTX+7jCh59ztR5zFNZcCo1/4+ZQF0h1JWUF8U+3bBjAr5GknTLEJqRUJ5a3M41RkI5Blm3DpjruWLYA44eVx58vzCvvw61pWUfvmvhzOmotsh8abP60qXUcXqaSwHkVZRcIVTsPnEaoyyT5DGx1msb8HnjxTXj64KcZNtGiLPQwjedoU8DLmHcL7iI5HXcD0BhZBB+IGjc+WdgwFas/XinYEOxs0WhhefdmnuuRNzQ4io3X3hfnbVqPa2GA/9OR6pKEymcAU1dz6GobkiE3p2EwLm539VkSE91oBLI1cwIG19iieUhGf0fBlpoTYLwXiMZULpp6zHrPWR36wet01p2yBj6Zsf1NUPuYOnwmuJjr2/5NPVqxyywBkLMQzNCTME7qrSxNcgiWuolhXbuJ3twP1KaH7ZI9UQlgdG3bEhXbKXYe8Go3dk8WQT2GLDU5qNO4XPJK8HCvdGazc2uKo3YajxTOjj2l7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(36756003)(31686004)(2906002)(26005)(508600001)(5660300002)(6916009)(53546011)(6486002)(66476007)(6666004)(186003)(16576012)(8676002)(8936002)(2616005)(83380400001)(956004)(66556008)(31696002)(86362001)(66946007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHFDU2Y2RUVLVXA4LzhZYXZSeHc1UlBOb3dnYmdpWTFNMzVrU3NpaHVtcGQ0?=
 =?utf-8?B?T2dDWnhyTWRxOWYxamF0YlpEL3c2NDFLSnBxTWdzSGx6QXVRR0lYUkdIZGtx?=
 =?utf-8?B?enpuRCtyK2RmOW52T005dHR4eWVKL0g1WVFiSUFzZ1FHMlc5QURxL25QdVRs?=
 =?utf-8?B?RHVsbWxVb0ZnWS9wSzYyTGVRN09lNjVtL29DaS9Td2lyZklZWDRndEVyNHhV?=
 =?utf-8?B?RGdIaUtWZnAycmFxQzJlNGV3cUhsTm5aTkpuc2szdUp3NS9ZOTQvekc2RGs5?=
 =?utf-8?B?cWNGeGVNbnFKTlhGKzdiNDUyTlNLZkRvVnYra0NmSWZRT0lpNlg0SjhMMW1B?=
 =?utf-8?B?T25JSVRTbzdnaWY3d0xVK1l1WFJzT00xdUxJVkNBcFZodFRJN1JjZWJjWUhB?=
 =?utf-8?B?alBZemFocy9FT0NvR1h2T2x5YnBTL0RHV0pqY1BqaVh5THU0OWR2STFvaGg2?=
 =?utf-8?B?aXNtQjdTdTBibEJPMEtudGZTZjdrSVpSUE55K2xldlltK2NTdmNUaFd2YUhr?=
 =?utf-8?B?bUhTRnpzR1M5VEhUcmRyM3NVbGpIS3JUVkJnYkJtT205QjJiWlN5djdlZmJu?=
 =?utf-8?B?Y1lzU0pVbjJhT0tzVzJMTUNtQ0l3Slg3WmlDWnZhRVNzOXdLU1BoY0NJOEZY?=
 =?utf-8?B?aDFWWUpGbVZ6b05tcDQxZHlWbEZjaTR0dmtaWlNNcUk2czNOUFY0SGZCdVJD?=
 =?utf-8?B?T0tZUGYyUFJrdGhaSDc4RnF2T2xGV0xwVThQMHpIZTNUb2JFM1ptMW1iU1Jp?=
 =?utf-8?B?NlRCUlY1UTB0ZFRkSFNadDVYWXlHc1VGTUV6YnV2TGt1UHFiWDFJY3JXZUFU?=
 =?utf-8?B?SUU2eEMrRlJKRHI5VlJaWFJyT0VaaUh2U050S1BINUZwazh1TkdyMHVrMmMz?=
 =?utf-8?B?YU5nMkV3MnFSeDJMb2Z6UG5uSUZxcmZqdWhsWkROODZLOGtOOEtiS09RTkw3?=
 =?utf-8?B?cFlXS244M01IbWNhcDVjRXdXWjFESkM2QnZPdUxoajZuVy9ZZkdkVko4MFJj?=
 =?utf-8?B?UTNoeVhjeExaVXZuWlBvb2lSd3kzU1pnVHN0azNpY0l1SDB1VHFOdUhEOVNS?=
 =?utf-8?B?UFVISElSMWk3N1E4dHZPd1g3NkFkNkNVSnBsM1ZpYzRQWVd3R1VhNDFIeFpS?=
 =?utf-8?B?WWJzckNpOVJucElXODFKSThFZHBLa2dwSzUvNWp1Si9ZYnlYcEhtKzhPS3Rk?=
 =?utf-8?B?Y0dkbG9UUWxIcUtZOElHRTRKaUo0bHBma29DQlcvNm5HanJidE5LVUVJbXQ0?=
 =?utf-8?B?WUZwdUNFcVZFRVl0TXM5STREd0xvWW1VMTlIT2taM2dVWVVacm9GM2pMSFdT?=
 =?utf-8?B?c044ZGlCNnkyekJrNU4vcVJLQVVwSFQwNmV4TTlRYW5wVkRSc0ZzdjczU2Zo?=
 =?utf-8?B?UVJXL2pSVitlVWRWS29McnhIMm84aU1nU25rOEcvM2UzRm5OZTVaNWtZVFZH?=
 =?utf-8?B?NEZwODQwZVk5a0JCTEExbldLV0FGMHh2M2tRRUxWNjhvRkRyRWxXbHpYZWg0?=
 =?utf-8?B?Y0RiS2VGQ3N2Znc5OVIwSURpRTNmc0hlRUlEbUFyeUl1ei9tN0hReVNhdzJq?=
 =?utf-8?B?WkQwcE1mNkh1NldxVDZwL0tUZU1kbVF4RHJiOVJNTXp2SDlsR0Jlb25RajVB?=
 =?utf-8?B?OUpXRm9JOEJiUXZMVXJXUXhmSGk5MGZxZ2RWSVJQTkQ5RWE3cXhZbkVxSVpM?=
 =?utf-8?B?cWI0WGJtUC84YlY3dUE2YnQyZTZhTTNtMDBia3J4amptNGp5SDRDTTRwRk5n?=
 =?utf-8?Q?4mWL47UrLPNq6eI6crocVgebF1ieg/fZwgBsQgr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67125ea-c7e9-40e2-4289-08d98d81f44b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 13:12:34.1055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61txeur4d3uhxpwIy/FYgO/ReZi9ZU3ciiAGJt9k9KRDyQO5G6F7pEtCWKhp6RfjPww7LKpen1V0m74pGgwc7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
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


On 10/12/2021 1:58 PM, Stanley.Yang wrote:
> Test scenario:
>      modprobe amdgpu -> rmmod amdgpu -> modprobe amdgpu
> Error log:
>      [   54.396807] debugfs: File 'page_pool' in directory 'amdttm' already present!
>      [   54.396833] debugfs: File 'page_pool_shrink' in directory 'amdttm' already present!
>      [   54.396848] debugfs: File 'buffer_objects' in directory 'amdttm' already present!


We should instead add a check if those debugfs files already 
exist/created in ttm debugfs dir using debugfs_lookup() before creating.


Regards,

Nirmoy



> Reason:
>      page_pool, page_pool_shrink and buffer_objects can be removed when
>      rmmod amdttm, in the above test scenario only rmmod amdgpu, so those
>      debugfs node will not be removed, this caused file create failed.
> Soultion:
>      create ttm_page directory under ttm_root directory when insmod amdgpu,
>      page_pool, page_pool_shrink and buffer_objects are stored in ttm_page directiry,
>      remove ttm_page directory when do rmmod amdgpu, this can fix above issue.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_device.c | 12 +++++++++++-
>   drivers/gpu/drm/ttm/ttm_module.c |  1 +
>   drivers/gpu/drm/ttm/ttm_module.h |  1 +
>   drivers/gpu/drm/ttm/ttm_pool.c   |  4 ++--
>   4 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
> index 1de23edbc182..ad170328f0c8 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -55,6 +55,10 @@ static void ttm_global_release(void)
>   
>   	ttm_pool_mgr_fini();
>   
> +#ifdef CONFIG_DEBUG_FS
> +	debugfs_remove(ttm_debugfs_page);
> +#endif
> +
>   	__free_page(glob->dummy_read_page);
>   	memset(glob, 0, sizeof(*glob));
>   out:
> @@ -85,6 +89,10 @@ static int ttm_global_init(void)
>   		>> PAGE_SHIFT;
>   	num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
>   
> +#ifdef CONFIG_DEBUG_FS
> +	ttm_debugfs_page = debugfs_create_dir("ttm_page", ttm_debugfs_root);
> +#endif
> +
>   	ttm_pool_mgr_init(num_pages);
>   	ttm_tt_mgr_init(num_pages, num_dma32);
>   
> @@ -98,8 +106,10 @@ static int ttm_global_init(void)
>   	INIT_LIST_HEAD(&glob->device_list);
>   	atomic_set(&glob->bo_count, 0);
>   
> -	debugfs_create_atomic_t("buffer_objects", 0444, ttm_debugfs_root,
> +#ifdef CONFIG_DEBUG_FS
> +	debugfs_create_atomic_t("buffer_objects", 0444, ttm_debugfs_page,
>   				&glob->bo_count);
> +#endif
>   out:
>   	mutex_unlock(&ttm_global_mutex);
>   	return ret;
> diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
> index 88970a6b8e32..66595e6e7087 100644
> --- a/drivers/gpu/drm/ttm/ttm_module.c
> +++ b/drivers/gpu/drm/ttm/ttm_module.c
> @@ -38,6 +38,7 @@
>   #include "ttm_module.h"
>   
>   struct dentry *ttm_debugfs_root;
> +struct dentry *ttm_debugfs_page;
>   
>   static int __init ttm_init(void)
>   {
> diff --git a/drivers/gpu/drm/ttm/ttm_module.h b/drivers/gpu/drm/ttm/ttm_module.h
> index d7cac5d4b835..6007dc66f44e 100644
> --- a/drivers/gpu/drm/ttm/ttm_module.h
> +++ b/drivers/gpu/drm/ttm/ttm_module.h
> @@ -36,5 +36,6 @@
>   struct dentry;
>   
>   extern struct dentry *ttm_debugfs_root;
> +extern struct dentry *ttm_debugfs_page;
>   
>   #endif /* _TTM_MODULE_H_ */
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 8be7fd7161fd..ecb33daad7b5 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -709,9 +709,9 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>   	}
>   
>   #ifdef CONFIG_DEBUG_FS
> -	debugfs_create_file("page_pool", 0444, ttm_debugfs_root, NULL,
> +	debugfs_create_file("page_pool", 0444, ttm_debugfs_page, NULL,
>   			    &ttm_pool_debugfs_globals_fops);
> -	debugfs_create_file("page_pool_shrink", 0400, ttm_debugfs_root, NULL,
> +	debugfs_create_file("page_pool_shrink", 0400, ttm_debugfs_page, NULL,
>   			    &ttm_pool_debugfs_shrink_fops);
>   #endif
>   
