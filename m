Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FD9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 12:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1A064E41
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 12:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1A064E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38E96E4F9;
	Mon, 22 Feb 2021 12:59:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733766E4DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 12:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPIltZCo1UwHMYP7rmiCc3qaw30NeZbOwgUCGRA09FjuU7luO+m66vLv8l0DMRvsO2abcL5SsNUfXD4p32ZDRMIFcVR5eFWj2/ILrYsQ31jGFh6tXSQyST0dwmbNwVqlkFVxd7/zeflCV630XnKL9iBpNfeo2LpZxFH8E+bywYYAfd7tKMPhLmb4BVpXPDhkkvvOPYBVxtnvSR9T1+euhGaPKVkt23zNBlHEDQezqB5p4w88TmcNRFLVrqvCJOp8sTa3RehxbENNRl8IRiHKS/UluudP37XaVdorlNQYF60nBvEv10t3Nrs/HL2e5pgf7kZstWgAgqYLMo6L025m4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsoAcJVLJRX4WoVGizKQH0bsQKOMo7tuKoZNz82A8Yg=;
 b=G1dAOSmNyvVH8kyX485ELZqEt+gpr/tnC6Z5eNQOp3qB4qTTN66qYJZdF49bRtIh5lULShM+hGY9lQH9vVlJcWGACZYd0/A8OryqzwijHlU/nPIJbgjkkgWa1KWJ5wnR+MjT85qBXiPXj93QJYhxjZwJfRzWmM843kM3xtMV3hf4ikr1lce3tnlHSR/VnEeDxW8du1gNee0BpmgYganD3tZbCKDkTctHt/YgUJWQak4J9LUxLr/melyob4XwmIOlA529FkbPQFKbeBBMC3yYr00JwEcJWOf3pBbGnwwVvp8wP40J46Fdq97ITCFNGgoTl0eXCOR3Z7nFQp1DT7e3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsoAcJVLJRX4WoVGizKQH0bsQKOMo7tuKoZNz82A8Yg=;
 b=ZBbi5nBzqwAmr282Hil3h1yuvNVt/BSjo07r2lij3ElGac2kE0JQNnyFMycMjJ8ftn22gtKZ1d/tw2p7twnMynz6BG+00v80Hmhiks/+tMDvG5kopxwnMIJfvRcbv2taU6JdAKbVrUcOXUnRO4N0Qb+4/vqOLZGOsRUM/5eMv4A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 12:59:41 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.031; Mon, 22 Feb 2021
 12:59:40 +0000
Subject: Re: [PATCH] drm/amdgpu: reserve backup pages for bad page retirment
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Guchun.Chen@amd.com, Hawking.Zhang@amd.com
References: <20210222123816.30957-1-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <60e15e64-439a-d788-9110-2128780c7791@amd.com>
Date: Mon, 22 Feb 2021 13:59:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210222123816.30957-1-Dennis.Li@amd.com>
Content-Language: en-US
X-Originating-IP: [46.189.55.12]
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.201.250.142] (46.189.55.12) by
 ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 12:59:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f630600-689c-42cc-cc32-08d8d731b762
X-MS-TrafficTypeDiagnostic: MN2PR12MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3792F0C141E733CF87D2255A83819@MN2PR12MB3792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hggd1i+Ye2nYQatW0UQmpkdK+AEjxWbeiYipAGdPs0K5RlijJ/KQN/vjpwXgG+rRjmrz2s6jWm4bU+fUDkMj63WGgTUfuwUs1FmDmNg5TinNHsMOd5UeVtDYAUNZbgKBfzvDICQnPHlpBmIc9jjUPDeQ0XfKhlwXA2lwG5nkZ7s6voRDerhu3ZHBtrab2/wUgBKkkXb/I2+RkJKYL++Jt7K4tS65ULlgeVUMLK3/IGQ0NdnB9T5mHsjW67fDOvRWauok3YbOGvIJl2cHShExrMJJdOdCxI56kwspC9x5b+VcWc+6Z/hA6L6ZEn3Cbo8pafQF1CfK5T0ZFVtpngPayfVj+7SCQqVxK5kcSOV/yRbuTKoW8eoHEO99To0AHwp7Gi+BSdPyDCA0yUxenVYZOyGMAezT7LUyY53GnjaqVUqwSmAtwk20bStLKZ8s0D/yQvXp68EWF8NHaYYyFnbaroB6Vnx1Wv2D2ohETkizrqC3a9UJF6LAXRM/MgEyamVo7I75g+4i4TxHaDpSYyJ5A4uUZBPfrB4J5JYGdVfOVlz7qiifbqd007tU0QJJ3tgFw8qRFPmED0tkHsI+Y+S/QysD4ZjJGrIOd7C8SwbG7/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(2906002)(5660300002)(6636002)(31696002)(31686004)(36756003)(16576012)(16526019)(83380400001)(52116002)(6666004)(66556008)(66946007)(66476007)(26005)(86362001)(186003)(8936002)(6486002)(478600001)(956004)(8676002)(2616005)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QW5qcUk4TksxTC9ZVnZBR1gzdDFPeTlJbzB4MzVQanovd05YYjlORjlNa0ZJ?=
 =?utf-8?B?ZkZDdEhpbWwvb1NURVIwUG4vU3czenBNbDRzcnlPNzQ3QU1sbStzUVJjL2Jt?=
 =?utf-8?B?cDgwY3JTSWVwWkFDdjh3bTgvMDA0NmtTdmtqeFQwNHhFWjFVWnQ0YThzeGY5?=
 =?utf-8?B?dWx6bmlUU1hhaW9ZazNLYmk1YjZYOVZ0UXhiSTBWdk9QaUQzc0JJUFFZQ09R?=
 =?utf-8?B?anZWZEE1Ykg0blZiYjdWQW14WFFadjMyZ3Iwc2ZLcnJ1VDhXVU9jM0NPMDNG?=
 =?utf-8?B?dWZDd3V5V2o2UWNPZzN0dXpUYjBYRjJ2dkdXYXBVM3JaOCtEMFNqdnVhckhG?=
 =?utf-8?B?K0NPVHBOWFJwQXhHVC9QQk5TcWZObmczdk16dTlPZ3QrK2FYVVZValZCbDhV?=
 =?utf-8?B?dktqbVJ0alhEc1JDMHJuWlNXbVcvalg1aDcwRjVURk50Y3NWcVhjblljSW1W?=
 =?utf-8?B?QWQ3a2NHN1RDWW5XZ0x2QVhhclAxSFdGOVBlYzdlbXBOaWFydTBNZEtyRTA0?=
 =?utf-8?B?dGdycERreGkrcm82WG5MQ1c5d2lWRlU3cWpEUldkbWUyVFEzaHlJNW5vd0NY?=
 =?utf-8?B?NUZQbkg2UGRYbmhtSXlRenFJTzFVeUJkRG5DMkFKRDVJZHczamxtOVNHNnJG?=
 =?utf-8?B?OFdTTHpUUnY3ZXJ4eGVsR1kxanVqUmYrM2I3cEowOVhHQmxKbFlpblp1Ti8w?=
 =?utf-8?B?cHFqd0dmaXpaYkl3OEkwSk4zV3d0bWFKSERPUlVvZXNuOGVScm9YNTd4WGd1?=
 =?utf-8?B?dXQzUnRsVitVa0RXU3JPMy9CL3R2ZDFvaG4zMFBtQ1piejlxOWUxZExmdWcz?=
 =?utf-8?B?em1mQjVWaWpmdzNOeERQSTRIV0RRM3N0SHJpdHlCbjhwVzR5MlpHM0NCV3Mx?=
 =?utf-8?B?ZGJCbmcwaGthSGxsMzF5WEZhSS9DdFdoNXVyUUVLM0lYK2JaclVjSlV1VGJl?=
 =?utf-8?B?WldiclJ6dXdxYkJ2QTMvTzR1UjR5dkpRckw1MTFNMmxTckI2NkJpVVlsVmNC?=
 =?utf-8?B?T0pKZVBkdndnM2ZLaTBOUVlEQjQrRGc3VDhlN0ZOMGo1ZzNjcGMySlBpKytk?=
 =?utf-8?B?Z3RhcEhGejRKalR2Vmg1SXdPWkhhbmlFT1d0c2lmVHBIbUpIbjBycUczVTk1?=
 =?utf-8?B?Vk5mdmVNbkxlV09tTy9mRUFkbW1yNkNLRmxwQXdEYU9oNE5PRGlBZkdRdGRH?=
 =?utf-8?B?b2NINHRuWllKZXVxWStEeEtEUnNkdzl3RmwvMGpqbnQ2RkZ6NGhWNW8vWmNu?=
 =?utf-8?B?ZjBEM1ZaNWh4aXJ6QWlZWThSdVlXcUlKUTVzb25tWXBVdk5BYUVQVFdYMnFw?=
 =?utf-8?B?V1lVOE1keWVMdHdDTXBIV0FkNXk3V0l5cmRPbjg0VEl4cHJDWmtRdW9NS3g2?=
 =?utf-8?B?V0NOOUpyZ2FTdExUYU1qNzN6b3JpYjdzRTlOdlAvTkZLUDJDbjFhalRDS3pB?=
 =?utf-8?B?dFZBdXpEUzBtYjR2TnhiNVFTdmViZ3V1alA2NlNBWlNIb3V2VEJFeU1wdHdL?=
 =?utf-8?B?ZDNLUkx2QVFvS3ZidVRDbTBaTjJOdlZkUzJkRHlGUVZFVTBSbXRUdTMvUjJM?=
 =?utf-8?B?WnBLa0drOHFGYTV4WFFoVkF4MUZLY0o0Z3ZoTmoyOU9lMGVHQ3BHRTd5WjdD?=
 =?utf-8?B?ZzBTekh1VFlFKzFqZE9mdk1zOENxVkhvcE1aWEFvUFFPMHYxUHBnakVxUWht?=
 =?utf-8?B?dlM1S3FHVllnMkN2RCtUelBNTk9NV00rd1Zwd3lpdVkyWGUzSEhzS1gwcmpL?=
 =?utf-8?Q?jq4RpFDHqPbr8WByuSeYgNuNflzg+FN5gFuqQy7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f630600-689c-42cc-cc32-08d8d731b762
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 12:59:40.7077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TH8vZHeMoqnKq62o1v5jagNT3wsfwFXJRCnhsABszUHOkvfA4nbLrCAK8AMzv461
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.02.21 um 13:38 schrieb Dennis Li:
> it's not user friendly that users' visiable unused memories are
> decreased when bad pages are retired. Therefore reserve limit backup
> pages when init, and return ones when bad pages retired, to keep no
> change of unused memory size.

NAK, it is even less friendly to not allow applications to use all of 
the available memory.

That the available memory is reduced as bad hardware pages increase is 
expected.

Regards,
Christian.

>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b7ee587484b2..ff4387bbfb1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -170,7 +170,7 @@ struct amdgpu_mgpu_info mgpu_info = {
>   };
>   int amdgpu_ras_enable = -1;
>   uint amdgpu_ras_mask = 0xffffffff;
> -int amdgpu_bad_page_threshold = -1;
> +int amdgpu_bad_page_threshold = 100;
>   
>   /**
>    * DOC: vramlimit (int)
> @@ -804,7 +804,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>    * faulty pages by ECC exceed threshold value and leave it for user's further
>    * check.
>    */
> -MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
> +MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto, 0 = disable bad page retirement, 100 = default value");
>   module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
>   
>   MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 93699ea4860c..fb1c3f6cef29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1779,7 +1779,7 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
>   		tmp_threshold = max_length;
>   
>   	if (tmp_threshold == -1) {
> -		val = adev->gmc.mc_vram_size;
> +		val = adev->gmc.real_vram_size;
>   		do_div(val, RAS_BAD_PAGE_RATE);
>   		con->bad_page_cnt_threshold = min(lower_32_bits(val),
>   						max_length);
> @@ -1812,8 +1812,16 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>   	atomic_set(&con->in_recovery, 0);
>   	con->adev = adev;
>   
> -	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
> -	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
> +	if (!con->bad_page_cnt_threshold) {
> +		max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
> +		amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
> +
> +		ret = amdgpu_vram_mgr_reserve_backup_pages(
> +			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
> +			con->bad_page_cnt_threshold);
> +		if (ret)
> +			goto out;
> +	}
>   
>   	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit);
>   	/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 69ba8dd4f3ee..927d33d75c22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -52,6 +52,8 @@ struct amdgpu_vram_mgr {
>   	spinlock_t lock;
>   	struct list_head reservations_pending;
>   	struct list_head reserved_pages;
> +	struct list_head backup_pages;
> +	uint32_t num_backup_pages;
>   	atomic64_t usage;
>   	atomic64_t vis_usage;
>   };
> @@ -127,6 +129,8 @@ uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);
>   uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man);
>   int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
>   				  uint64_t start, uint64_t size);
> +int amdgpu_vram_mgr_reserve_backup_pages(struct ttm_resource_manager *man,
> +					 uint32_t num_pages);
>   int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
>   				      uint64_t start);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 21d18efca277..b325b067926b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -28,6 +28,9 @@
>   #include "amdgpu_atomfirmware.h"
>   #include "atom.h"
>   
> +static int amdgpu_vram_mgr_free_backup_pages(struct amdgpu_vram_mgr *mgr,
> +					     uint32_t num_pages);
> +
>   static inline struct amdgpu_vram_mgr *to_vram_mgr(struct ttm_resource_manager *man)
>   {
>   	return container_of(man, struct amdgpu_vram_mgr, manager);
> @@ -189,6 +192,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>   	spin_lock_init(&mgr->lock);
>   	INIT_LIST_HEAD(&mgr->reservations_pending);
>   	INIT_LIST_HEAD(&mgr->reserved_pages);
> +	INIT_LIST_HEAD(&mgr->backup_pages);
>   
>   	/* Add the two VRAM-related sysfs files */
>   	ret = sysfs_create_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
> @@ -229,6 +233,11 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>   		drm_mm_remove_node(&rsv->mm_node);
>   		kfree(rsv);
>   	}
> +
> +	list_for_each_entry_safe(rsv, temp, &mgr->backup_pages, node) {
> +		drm_mm_remove_node(&rsv->mm_node);
> +		kfree(rsv);
> +	}
>   	drm_mm_takedown(&mgr->mm);
>   	spin_unlock(&mgr->lock);
>   
> @@ -300,12 +309,14 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
>   			continue;
>   
>   		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
> -			rsv->mm_node.start, rsv->mm_node.size);
> +			rsv->mm_node.start << PAGE_SHIFT, rsv->mm_node.size);
>   
>   		vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
>   		atomic64_add(vis_usage, &mgr->vis_usage);
>   		atomic64_add(rsv->mm_node.size << PAGE_SHIFT, &mgr->usage);
>   		list_move(&rsv->node, &mgr->reserved_pages);
> +
> +		amdgpu_vram_mgr_free_backup_pages(mgr, rsv->mm_node.size);
>   	}
>   }
>   
> @@ -322,6 +333,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
>   				  uint64_t start, uint64_t size)
>   {
>   	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
> +	struct amdgpu_device *adev = to_amdgpu_device(mgr);
>   	struct amdgpu_vram_reservation *rsv;
>   
>   	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
> @@ -332,14 +344,94 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
>   	rsv->mm_node.start = start >> PAGE_SHIFT;
>   	rsv->mm_node.size = size >> PAGE_SHIFT;
>   
> +	dev_dbg(adev->dev, "Pending Reservation: 0x%llx\n", start);
> +
>   	spin_lock(&mgr->lock);
> -	list_add_tail(&mgr->reservations_pending, &rsv->node);
> +	list_add_tail(&rsv->node, &mgr->reservations_pending);
>   	amdgpu_vram_mgr_do_reserve(man);
>   	spin_unlock(&mgr->lock);
>   
>   	return 0;
>   }
>   
> +static int amdgpu_vram_mgr_free_backup_pages(struct amdgpu_vram_mgr *mgr,
> +					     uint32_t num_pages)
> +{
> +	struct amdgpu_device *adev = to_amdgpu_device(mgr);
> +	struct amdgpu_vram_reservation *rsv;
> +	uint32_t i;
> +	uint64_t vis_usage = 0, total_usage = 0;
> +
> +	if (num_pages > mgr->num_backup_pages) {
> +		dev_warn(adev->dev, "No enough backup pages\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < num_pages; i++) {
> +		rsv = list_first_entry(&mgr->backup_pages,
> +				       struct amdgpu_vram_reservation, node);
> +		vis_usage += amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
> +		total_usage += (rsv->mm_node.size << PAGE_SHIFT);
> +		drm_mm_remove_node(&rsv->mm_node);
> +		list_del(&rsv->node);
> +		kfree(rsv);
> +		mgr->num_backup_pages--;
> +	}
> +
> +	atomic64_sub(total_usage, &mgr->usage);
> +	atomic64_sub(vis_usage, &mgr->vis_usage);
> +
> +	return 0;
> +}
> +
> +int amdgpu_vram_mgr_reserve_backup_pages(struct ttm_resource_manager *man,
> +					 uint32_t num_pages)
> +{
> +	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
> +	struct amdgpu_device *adev = to_amdgpu_device(mgr);
> +	struct amdgpu_vram_reservation *rsv;
> +	struct drm_mm *mm = &mgr->mm;
> +	uint32_t i;
> +	int ret = 0;
> +	uint64_t vis_usage, total_usage;
> +
> +	for (i = 0; i < num_pages; i++) {
> +		rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
> +		if (!rsv) {
> +			ret = -ENOMEM;
> +			goto pro_end;
> +		}
> +
> +		INIT_LIST_HEAD(&rsv->node);
> +
> +		ret = drm_mm_insert_node(mm, &rsv->mm_node, 1);
> +		if (ret) {
> +			dev_err(adev->dev, "failed to reserve backup page %d, ret 0x%x\n", i, ret);
> +			kfree(rsv);
> +			goto pro_end;
> +		}
> +
> +		vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
> +		total_usage = (rsv->mm_node.size << PAGE_SHIFT);
> +
> +		spin_lock(&mgr->lock);
> +		atomic64_add(vis_usage, &mgr->vis_usage);
> +		atomic64_add(total_usage, &mgr->usage);
> +		list_add_tail(&rsv->node, &mgr->backup_pages);
> +		mgr->num_backup_pages++;
> +		spin_unlock(&mgr->lock);
> +	}
> +
> +pro_end:
> +	if (ret) {
> +		spin_lock(&mgr->lock);
> +		amdgpu_vram_mgr_free_backup_pages(mgr, mgr->num_backup_pages);
> +		spin_unlock(&mgr->lock);
> +	}
> +
> +	return ret;
> +}
> +
>   /**
>    * amdgpu_vram_mgr_query_page_status - query the reservation status
>    *

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
