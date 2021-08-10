Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9067C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 03:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECEE60F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 03:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5ECEE60F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F7289DE6;
	Tue, 10 Aug 2021 03:52:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973C589DE6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 03:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwSHtB+OxPwo6oNRU51O6ylznwzV1D+zCwMcE/SOthJy/STVucbaTD4mMUo9RQDqki/sCCMuzXdbaquIdm+iXVEA3xh8pB+RaDcGnS+/BCua9wzxsAO8eTHbpbeT+EhY/xvNVEX3KTXy8SHMW+M/x+bEwj8hY20AixF+S4GFntL/zOCIpmfl9pvrfcCN5T3HF2KXUAVGCgTBd+EUp0r2St8dxCON8IYJSbGzzolDOIWuYGuIXTZHr9/+x1cus5lsmQYwXPXyL9+feTXhOUw/KhIoP9Z8EGP//pakYfK8SfMok5Inm8mvKOnNGD95m/B4wjI8OJcdMqImi9cnAHC9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/5qZl9M4qiRzaklpSqAJ1XxcNW/AWYUMpiVkebnoEk=;
 b=RVHf8KcGE4aaCtTtmo9XR2ZNAD8eOI82PkNJ4R5enWXwAsCWBYVknkWNcAy3P7FMpkMuVTxdk5RdBJweXwgv1s4JS7PzEkWawBXIyjBjxEoincDRiUOXwR64+27ZEqgqIjWgoGN42g8ZhgBfVq3Jr7WJrIPcohqKVynVuEI4YEn/2ElyJjOPluMA/3jJXful62RM9FNMwCTCUcWcRvMzRlFBD3x7n3PBObPu+1YP8c1bMg6/iE1TFcW8JINVudMRclhaUl9wrSM9/DaBEfjj9kij7Nqyku9KULOeAnqjqbQ1Dbxl23ZPjRr0X/D2ZOHxX3Vb/NTnbhZU5B7r0KwWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/5qZl9M4qiRzaklpSqAJ1XxcNW/AWYUMpiVkebnoEk=;
 b=1ibKk1jspo5TnGCiWw73cSezCAg4x8q2rX+AI6jKaM9jpRMNhuyHXtQwJadH1KOUMlgaaYs4fSJ7EJYjpru5FYdwmgcYUnrW8LmS6oVTFc2SHfD4rFCCUM0cRyID8wkTsuxKvlLPUSHKJF/zRH7xZ1YC9ZQGKU46k/9nMicklPY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 03:52:48 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 03:52:48 +0000
Subject: Re: [PATCH v2] drm/amdkfd: AIP mGPUs best prefetch location for xnack
 on
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210802162806.12631-1-Philip.Yang@amd.com>
 <20210809222123.19464-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f3fcc2cf-0e44-6642-e603-cc276374c21b@amd.com>
Date: Mon, 9 Aug 2021 23:52:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210809222123.19464-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 03:52:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f73fc385-7b09-4850-4476-08d95bb251d5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5067:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5067373E41DF8C89A905A3EE92F79@BN9PR12MB5067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4Mmpt9DvJRJ+Im3Lsp30aMOfN5pxCwQVu1t6q2eyFrfytkAbiTF7kVuAEeIndkPbrAefBrRxAkuhAsWGQ64F8+ug9yoZPkDqCA6hC+slGOA7Y7VW4fM8SfD+qUUZSLVkD2JvSj4dW8G9Ql1dnK6vxRC7+5+A7Zp533EjCTDNkaTHeruRsQpYyxPBiZubHgt22XCUIBnCnEahOypzGnoIlQ0KGskjF9rQTHR93waPdJS9OL+OYiH5sTBLF1wGIOhKjCZBi19oFIYQAfK923Nn2Q2zt0Vk+2Tal16QqwFANVDpagXoqBlYv4kLiqXX9a2JtS56IKKpFGnoGHGuUfQkbndShiXYdFBJqExp0cIUYZXwpJwqrMnI7t8Qu7ryvqxvx5z6kxX7Wxq5rzVFC0ZQ8R+IPBa8kqhy8WdXY/wcFCTnU3oGpLVNtx18wByUg4U8CrohiP1VZaJHjMnU7jqaHV+MPwK/3MIhxWYBdHhm21d+ayOyUbAPQyaVcpPb25WmiVD8pv5nSLIOiHlRopf505cMGYw3jvE2iq2HK3RQ77QNZjjLzfNhuVfbQwlZcjFpvEeHvQ6T3aacK8uW3cNDu5zoZAMOnW2vJ1XZ/JnBS22xGE9SkZNngnxfNKvott84clW+ALdUJA/n/N+QSnwlrTD19kFsL+F/NslkJM9G5b7R5gCxkB63ISQcsXmU/j1mQG51THXp0ieqUIFEBz2mUYodqXMycmqHam/xDyeuMx8kq9ZR5BNPwdJ8FaCj99b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(86362001)(2616005)(5660300002)(508600001)(6486002)(956004)(26005)(44832011)(186003)(38100700002)(83380400001)(8936002)(2906002)(8676002)(66946007)(31686004)(66476007)(66556008)(36756003)(316002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRHd2p6Q2ZMSWx3OHRFbDFmaFA1OFlPMmZONmRFNGRkN2psSEZkR2Ivb1l1?=
 =?utf-8?B?c0Zrdk1yTUlkeFFjNUQwVWtvc2RQVVNKTS9DSVdTYmY0U0lQY0lRZHZLME4z?=
 =?utf-8?B?SnUwY21tcDUzWWFtaENBaW5IWitpR29qQjh4VWorVi9oTUd4Y0FLUjIyOTg3?=
 =?utf-8?B?R1NiKzJ6Z2orWkdmL0pQajNtVUozbUFMcE82b09uY1Z1L2x0M1NWOXpDNGhO?=
 =?utf-8?B?T2VvOGIrZW0vNk5uUVZaWEh4cnIzeTYyU01YY3VRZWQ5dlFjSHZPZDNHSkN6?=
 =?utf-8?B?V0RyQVhRMTJPVWxsUGFlcE5heVlHb1lYc0xscDlpdXJEanRmZk1yZ256TTdO?=
 =?utf-8?B?TWR4R3poRTB5T1ByRUFBR2tHdDhobFFIMW9oZ1Q2MDVxOUVFQzJYc3JiVDYw?=
 =?utf-8?B?SWlyQmtrN3RmeGlpbG1WY2w0ZWNjcmV5eXpNZGtHNElqRGdnaGF6c3dBbUM0?=
 =?utf-8?B?YVV5MWwrTm93WmREdlRoOEU3YnBMem1qakVubnlxM0JMVThsaW9nYVNYcVMx?=
 =?utf-8?B?bXVtaElzcjhkaGlKa0NDdXk4cTJuWVZUamtkeUlhNllBVDdmek5aaDBvM2tJ?=
 =?utf-8?B?ZVc5L3kzRWQvMEkxcFRPQjZOUW9sTlRBT0FUdVZZS05vQ3pld0E1SVBrVG5i?=
 =?utf-8?B?YTBrTmQzNTd1SFY3cUhnR2kyWkt3azhpZFphYmJyK0FSRTlPRXlWRC82Rkw3?=
 =?utf-8?B?citzRVBQenlPSUxWTGM3TU5oNHRXT1pFdmVJTDNuVTI1OWd3UTdJRmZvVGFS?=
 =?utf-8?B?U3AvbVJadHMzc0hoT0tHQjdoa0hxK3ZkODRTWWlxOVd3YkF6UUpKYWtVTG5B?=
 =?utf-8?B?bW5seE1xbHJDVlB4QmJLYTVMSjFBRXNWanpQYk9paFhzMk9ZSmhnZG5KeWRu?=
 =?utf-8?B?MDdzalFrSHQwaktmcUJJRmFrTThqWWhpK1lQaU1rRWFsM0NEV2c0NmtlajFR?=
 =?utf-8?B?RXFySDY3c2RqQmJRby9DQWR2ZDRxSGNsRU5BaWY1dHdsMllzdms2cVhqcERJ?=
 =?utf-8?B?NkxxTzVWVTl5WjdKbW9xUjMyN1R6QnpDV3p3dTBlL0tuZUZ1cEYyc09Ua0xN?=
 =?utf-8?B?UjRrckYvMi9xVHAzb2JxTkpxL1FyWTkwenNXd0lHNkliNWdTVDdUOUJJNU5L?=
 =?utf-8?B?dFdGSWZaU21HWlBpWkp4VHljdE1pVTZMd1JiTWk4bmF1bWZ3WU1JdDBrL1JX?=
 =?utf-8?B?Y0RJeDI2RFZzNWQ1aThiUndvUVBNS0RTNHRzZC9PZlRWQmZqbFkyekRLZEor?=
 =?utf-8?B?OWxodFBFWm0vMkNwcC9EdEpNd0VDaGY1aXlBMWM5cjdSNHRmMXVMM1VDTFJv?=
 =?utf-8?B?VHRBczg4cXI4RmpaejUwQW8veEk2NXVXa3NieklPaFZ6RTRHSi9YOEFrL1dZ?=
 =?utf-8?B?YkJxV1c0YkM3anFGUkNSRVpHcWMzQlJrUjFpcFZpT2NtSFk1VkxEOW41ajJD?=
 =?utf-8?B?bXlJSmQ2TTJKb3JVeCtua1VUc1FJTTU1RzJRK1hQL0R4MXZ6d1RVUmh4Mlhm?=
 =?utf-8?B?c1ZxRE4rUEVmc3lud05FREIvemR4TzlBUnNnVWJGZzFXVi8wWG0wZmNPcVVn?=
 =?utf-8?B?K0phZDZJWmlOcjJJalpJTXZrUVlFZWhRZGV0UU5nQjg2TmljUy8yK0lIbzY2?=
 =?utf-8?B?R2xQQjVZQTBDU2dvdjFKcWRvTDQ0ODNwdmRpK1FtcjZFVnBKeTFwTVREMmxH?=
 =?utf-8?B?alBERFNHSHhJcWlrSWZBODQ1cVlHWXlNZTUyWGRzWnQ1emdtb3hvaVFKWGFu?=
 =?utf-8?Q?lXRlIjoJNn01zuhIX7H4O1c2dmt7ypd/8bp7o7o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73fc385-7b09-4850-4476-08d95bb251d5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 03:52:48.6575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XwYcS3TWoCDrZP/k9YshOLM+bc+QJbSZ26mOQtFzDcCmweLlxvPx8gXajnbSTw8Px2G2glXzTH9k0nVArT8Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
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

Am 2021-08-09 um 6:21 p.m. schrieb Philip Yang:
> For xnack on, if range ACCESS or ACCESS_IN_PLACE (AIP) by single GPU, or
> range is ACCESS_IN_PLACE by mGPUs and all mGPUs connection on xgmi same
> hive, the best prefetch location is prefetch_loc GPU. Otherwise, the best
> prefetch location is always CPU because GPU can not map vram of other
> GPUs through small bar PCIe.

I don't think small-bar is really a factor here. Even with large-BAR,
our P2P mappings are not coherent like XGMI mappings are. So we wouldn't
be able to use P2P even on large-BAR systems. So I would modify this
sentence:

> Otherwise, the best
> prefetch location is always CPU because GPU can not coherently map vram
> of other GPUs through PCIe.


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 +++++++++++++++-------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f811a3a24cd2..5bd51a15fb00 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2719,22 +2719,26 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>  	return 0;
>  }
>  
> -/* svm_range_best_prefetch_location - decide the best prefetch location
> +/**
> + * svm_range_best_prefetch_location - decide the best prefetch location
>   * @prange: svm range structure
>   *
>   * For xnack off:
> - * If range map to single GPU, the best acutal location is prefetch loc, which
> + * If range map to single GPU, the best prefetch location is prefetch_loc, which
>   * can be CPU or GPU.
>   *
> - * If range map to multiple GPUs, only if mGPU connection on xgmi same hive,
> - * the best actual location could be prefetch_loc GPU. If mGPU connection on
> - * PCIe, the best actual location is always CPU, because GPU cannot access vram
> - * of other GPUs, assuming PCIe small bar (large bar support is not upstream).
> + * If range is ACCESS or ACCESS_IN_PLACE by mGPUs, only if mGPU connection on
> + * XGMI same hive, the best prefetch location is prefetch_loc GPU, othervise
> + * the best prefetch location is always CPU, because GPU can not map vram of
> + * other GPUs, assuming PCIe small bar (large bar support is not upstream).

Same as above. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   *
>   * For xnack on:
> - * The best actual location is prefetch location. If mGPU connection on xgmi
> - * same hive, range map to multiple GPUs. Otherwise, the range only map to
> - * actual location GPU. Other GPU access vm fault will trigger migration.
> + * If range is not ACCESS_IN_PLACE by mGPUs, the best prefetch location is
> + * prefetch_loc, other GPU access will generate vm fault and trigger migration.
> + *
> + * If range is ACCESS_IN_PLACE by mGPUs, only if mGPU connection on XGMI same
> + * hive, the best prefetch location is prefetch_loc GPU, otherwise the best
> + * prefetch location is always CPU, because GPU cannot map vram of other GPUs.
>   *
>   * Context: Process context
>   *
> @@ -2754,11 +2758,6 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>  
>  	p = container_of(prange->svms, struct kfd_process, svms);
>  
> -	/* xnack on */
> -	if (p->xnack_enabled)
> -		goto out;
> -
> -	/* xnack off */
>  	if (!best_loc || best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
>  		goto out;
>  
> @@ -2768,8 +2767,12 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>  		best_loc = 0;
>  		goto out;
>  	}
> -	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
> -		  MAX_GPU_INSTANCE);
> +
> +	if (p->xnack_enabled)
> +		bitmap_copy(bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
> +	else
> +		bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
> +			  MAX_GPU_INSTANCE);
>  
>  	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
>  		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
