Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136E3EC875A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 20:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A4F10E08F;
	Thu,  7 Sep 2023 20:03:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7938710E08F
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 20:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMoPSZUURdfJ38PvG/iz+l6eotKZHmOW8Vv9n7kzWi23cIAsvULRypuodbn7SJz3P49NMulQns2YyuUiK2iy/K0ZK6xZJAuLVJLDJiAun4heWimSrZyjEqLlQQmpfZHB7CfkL2Tjt4KYoXQAKrQNqK/O6/OPdxHhZj9sAn2rkgvQL6VmIm6VzNfoTMtS5CtBlPxKxS/XaEUG+zu+W+ufEUODJxlA25+h8Z/UIyN1pTQ5PqCLeAXWjMhBzytjDg9zsJOvO6OCmzSe33JhxIFGTlVxZ70J6pFXslC/8OCBWpFOJlDnxmeD6ozTbPUuKJ8gRZfvjOCVxq1AjFwKidfzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqRCf2vvmZ81t+K8JX+HP0kknl0UdnukAk9yFZQZERQ=;
 b=bYNNHpEVfUtr3yG40GajgBAqGFFKIStlU4iodaPWgeQgYmxuFA7SwrUcAaCkIrCv2dKG3A/xJIXDmeD/CcxNZugf6nfG1rx/1Hw0XH4giBpH9TQ14pTTWvlhb9AqsLRp9P1FejI54TiB4Oz12Z/G6vNmGpm463sy9CW8NQSju9yOdLUeQMrrw26aL0dk9ZPeqvkMM6mR7raGnlAiGGnBRD7w/aeB3c/erI7YG0EBAkkRQgvA1f3bu6tlYwpgdIj93zcwfzBXNRZBrE+iySNooiFFoCLYDE+DEtKfJ9QeJgN3FhzOBeEJy+0pH/SPrPbXWFqUOZWt207JiQSdqzPo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqRCf2vvmZ81t+K8JX+HP0kknl0UdnukAk9yFZQZERQ=;
 b=WOsQT7U2hwo2e/mPel5C8HWwOH49TqrdxSrPMAT3dsRCUYr+tSTWN/9zGPRrSW8VJb9Rp0yBFa3yQY+poQiHLme7/CDVtzMbUWK7BkSqYXivGeKcVTKG9JhfdsdADXgRtl1W+oRNIVdX3D0goQHRnMzNzsfY4FjQGJFnP2da5nE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 20:03:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 20:03:22 +0000
Message-ID: <670c67e3-1ce4-e57d-3ff5-5b314cc61ab0@amd.com>
Date: Thu, 7 Sep 2023 16:03:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: disable SVM for GC 10.1.3/4
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230907120848.3169535-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230907120848.3169535-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a01696-e67d-4efa-8277-08dbafdd7cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5nZdqsKKBbOHAV1SICrr1ehGUnnyzjb9LRgL9Yj3WN0fOnheTsTsA8yWhiJks+81yvdlTlFtLXXrt4RqFcSRZ24ryE1LvW8n0OnZo7nM9y/j0t8cUL31EHbQGihszOvi8pgs2e8x3J3emXE4nGB+u0Kue+pBZjTrz4ePL59udCkcQdjerIoCBTE3TIn2CoAHwtvoadlBGfBiXcZRsi4raPv60QAVxbk3ugQ9Tfv00OnQc8olR71msaVfTPaozggYh1I4D5FtITng1tPYtuM+4ILRCednAquUXWki8+JclJN5u3MJ8vuU6MNe17f8Po3OPZvWlml09g2ThCWJmU/cSVMiTI+0CklcWaDyyrxMGqL3+xLuLl0Qk8MN2cHBZeulS0w8w0Yk+MAceWcZPyW+fREJ01jsxCzVFRSkWga6Aaurtk1HKXGqUguPrlNBaGVANWmiOo4NJO/yvgmA+GA/AFTaoDDiUpRqaDZIe580JuQ3ViOXKeSfYar4ipY5raL5YqFuoL+vZgeM4y3aT9EZ7ZdPbQXWZcfEdtHkF0mCo24eyzOxYJMnuuJWbbne69lb+cvOKv2Mrn+384rpCzGPvpi7Bf06qYjroNc/FBzo81Ci6+07iEs4kcLNFsXHghRafugMgLKSaCNeGek1zDOpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199024)(1800799009)(186009)(53546011)(6486002)(36916002)(6506007)(6666004)(31696002)(6512007)(478600001)(83380400001)(2616005)(26005)(2906002)(316002)(66556008)(66946007)(44832011)(8676002)(66476007)(41300700001)(5660300002)(8936002)(4326008)(38100700002)(36756003)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ZnbHlaNGE4UVpMMzRZVUI3R04wMlNYREVCRWY1d1hJOTBQOCsxYzRFNEZs?=
 =?utf-8?B?Snp0VTBlS2NYL09xZnkwQXEyQ3lSdU1ObzlPSGFYQlczN2NJVHlsWlY1a3R0?=
 =?utf-8?B?ZkNkNkQ0YlhUeGt1Mk01VzFsUDg3WlhZTExpamduaEpkSDF6MWxGa3g4bHhJ?=
 =?utf-8?B?ZjZjWlVHUUczSWVqUDQ5VW1nZ2Y4bTByZmxiTGUyb0RmTDE1RE05NlBCS0N2?=
 =?utf-8?B?eThadDJBQXFHTlFHMHYwa25udHVVUUgzVnhGRk5Rem1vLzNtaWxjNHFaNmdJ?=
 =?utf-8?B?SWduQVA1T2pEcFQ1eFhEQjJyS3dtVHRvcVd0YnI4TDJqdUNBYkRnSE9DNjN6?=
 =?utf-8?B?TVA3aGtNYTh1N3g2UnU5aHpRZDBPOHpHaWxnTWhQV09jQlh3ZGkwU0NpMENT?=
 =?utf-8?B?OFA3K0xWZzhNeENZd2tVaU1YQkFUb1pyaUlIaTl4MVFsNGxVcDRlMVJoWDZn?=
 =?utf-8?B?T1dzWENNcmcveW5CMHpYUUswa05xTXBFS01nVEMyYnpRdWNuS1BxNjZXMGFx?=
 =?utf-8?B?UVBrUW1CcWZCYXFnRjVhT2dWSGhVZmNXa0lnZnkvYXhiKzZTVExaenpSQ2ll?=
 =?utf-8?B?aFFZZHZrMm5nMU55Q1FsMTR3d1FDeGpZQnVrNFdicnZsYndaZndWUGxhRlJN?=
 =?utf-8?B?aDR2eG4rb1RrNGJzM2tPYk1EclRqKytxUzYwc0RUNFJtbVNhdXI3cEplclJ3?=
 =?utf-8?B?Uk5CSTMwNmdIZ0ZlSnBOMk54eGNRSjQyMlRPbzk5V3Vrd2NoQ01uZmxOZTlU?=
 =?utf-8?B?bUphNi9hT3dBSzNCOXpZMmlGd2JGOHpRUzllcHpMY1RSZyszUWhMZVdkNHYy?=
 =?utf-8?B?YTMvcmRKa1Jic1BYZ255WEJGNDUzK2swK2hjUnhFVCtkN2pnalRNV0M0L0hx?=
 =?utf-8?B?Wm1MYTNRRVZmMS8vSHhJcHQrdy9oN05abXF1MHNVU2EySnJsWUtBMVRNUzJz?=
 =?utf-8?B?UWtRL25oUnVaUGdWVnRoSS9YUHhtWGZERGFCOXRPa2JYVk1rZE0yelRNNzNK?=
 =?utf-8?B?NUdYM3lwSVJqbFFkSkVlcHd2NHhKK3hRb05wc0xMY1FpQUxkaU5Zd2wzTk56?=
 =?utf-8?B?andMazJxUHBqUk8yOTVqWTZMOVhickJQcXlVYUs4cEFjRE5qZ3RlZmRSeGJn?=
 =?utf-8?B?M3FYWDhtNVBnS2tBWmtRWnVBd3czRTlWT0dIbmlFUG9nUnJzVEIvc0ZIT1p2?=
 =?utf-8?B?ZFNCV0NGZGJJNEZMbHUyU0xCcGd6N0F0bURsUnpBYU9hY2Y4bGw3L3FNUDNs?=
 =?utf-8?B?ZVhOeUdXc0p3SjgyekZiQmpKME9EMENjc0FuWGZiYTY4YjVjRDdFTkJJeGRX?=
 =?utf-8?B?UDJ3d1FTaTRiWXFDWTZSTTd3a0czd3E1RUR6TmpvR2Q1enlMaDhoV244Zkow?=
 =?utf-8?B?VmsvOCtnMmtjbmV3MmxJcDA2M3lRcTFXL2NrWmZlYTc4RUxJOG03NVk3OTY3?=
 =?utf-8?B?YTdvZE00R3dVVWVjRUNXM3ZxZnJYc04xUzF4N2ZOVnNqOEZlWlVZY2NtQjlx?=
 =?utf-8?B?NlErMXhTYnoxYjdMQTdpQzJHYjJuNmVMYWlEcjNHNXdoc09QSlBrUHIwU2RS?=
 =?utf-8?B?NnhtMnV1SmhMcEdwRWVkaFpsd1NPUExLOW1HUElEOEJoSW45UXpTSUhPMHJG?=
 =?utf-8?B?eFFXWHlBWUszZjVnYVF4L2NsTXJkWFo4QWlOa2p3L0EvenBuaFpaZTZSc2VE?=
 =?utf-8?B?aWZCR0VVL3dFSDI4aGNJTDVUaGUxc1BwbzJtaCsxNGVJd0Rhb3p2cEpFU05p?=
 =?utf-8?B?TkJzMklnTi80MTB0TVNLNVo4NUN5RVRiUTJ2SkQxT2ZPeDBTT1lSZnBMQzlV?=
 =?utf-8?B?cjZpSHdORHpvWWJ5bDhNdUs1aXEzZWltR2VJWGhxSldzRXZwVU11R0dtbjlB?=
 =?utf-8?B?Vk56VndyZWtLanhWVDluRGxLZVpUcXNYem5ac09USHVBRmN4bXJsZE5RUGZq?=
 =?utf-8?B?ZGFmV2F1YVg5Wnh2N0pTYmxscldKTXBncHZJazZFbDZIbU5Pd2daN0FYQnhk?=
 =?utf-8?B?aU44MEVJaS9UTkh6L2tLRmNBZ3E2dHZ5SUNGekNmNDIxSFNNcGFEa00xNVlN?=
 =?utf-8?B?MEp2VHVFLzFhVGFIOXdwVlA5T3hGZnc1RWNFYXRvOHV0aHY3dmhwZjVETVRO?=
 =?utf-8?Q?a2ibG9Eyy8+2UFXFxFG7p87DL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a01696-e67d-4efa-8277-08dbafdd7cd3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:03:22.1432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK/diH8mas2bkpACiwtGmsE506l7CK/L4eGDuNpfVmI+EQcSdahFFbQdF6/n/lJOFAWzsgf/frWuRVVveYaphA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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
Cc: Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need heavy-weight flushes not just for SVM. If this is broken it will 
affect ROCm either way.

Regards,
   Felix


On 2023-09-07 08:08, Lang Yu wrote:
> GC 10.1.3/4 have problems with TLB_FLUSH_HEAVYWEIGHT
> which is used by SVM in svm_range_unmap_from_gpus().
> This causes problems on GC 10.1.3/4.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 7d82c7da223a..dd3db3d88d59 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -992,6 +992,22 @@ static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
>   /* Each VRAM page uses sizeof(struct page) on system memory */
>   #define SVM_HMM_PAGE_STRUCT_SIZE(size) ((size)/PAGE_SIZE * sizeof(struct page))
>   
> +static inline bool is_zone_device_needed(struct amdgpu_device *adev)
> +{
> +	/* Page migration works on gfx9 or newer */
> +	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
> +		return false;
> +
> +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3) ||
> +	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 4))
> +		return false;
> +
> +	if (adev->gmc.is_app_apu)
> +		return false;
> +
> +	return true;
> +}
> +
>   int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_kfd_dev *kfddev = &adev->kfd;
> @@ -1000,11 +1016,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>   	unsigned long size;
>   	void *r;
>   
> -	/* Page migration works on gfx9 or newer */
> -	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
> -		return -EINVAL;
> -
> -	if (adev->gmc.is_app_apu)
> +	if (!is_zone_device_needed(adev))
>   		return 0;
>   
>   	pgmap = &kfddev->pgmap;
