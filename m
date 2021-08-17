Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49371C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 16:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2F960FD9
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 16:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D2F960FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E76A6E1F1;
	Tue, 17 Aug 2021 16:54:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92A86E1F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 16:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmsLzV73Pqqx5PJ0yHMUjhwfdPg9BgPfneUBcFk0ZneR1lwC8uuUKYkxBakyQSMfAr5DIY6ke7OlxG5AtzdPD5iMUdO4kLI7LCqUSKPCmgVyMaWiJj9dH0MF1MF7BYviwMbdVcrjTEYIvOa6jkUIb22ZvXdiEgR96RS2gq18k8ZKej5r1/9FZoRbHDhkJzTQWc2O7NcS9L6DlntWUpSkc/5lksH+X41CKMvgM98lk1RVethEFBi/6rxH/jPtLx0yHz55ZTjPayOEHR4/n6fkL/x/qXtpki6+h53/hKHpIjlc1ntXkWKUkosGs7UxXTLuXXzyd/LNqiW8KDef3oBrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiBfsSGXMqsfPv+jOnClwv7p+vBp03bXJLfi5BnkoS8=;
 b=nOoC8SLup3Lua2aLxt7MhoxAQMxrxe5jzUKoFSXNGQ/uOAag4fpnovjBEK8FrGo58pIy0c5qirzjWkQBNhVHBttheILpx9VhCFUNlo0HSrKoD8pqylIsiIFYVoc8UoN7zA8TVELdUf9whDeZgqE7yvrpt6nuASOfHFUfHUTJCvEfT1PrDTP8YObkiBy3d0UhEirYDzXKtlZIG36kSWpQ5vg7C+Mg5iuF1E+gxbiCjJZEOMtyVqC1ByoCNlc4pie8D72eOthUlEn5ihgs5IrgFH7MpqfKZMeo1AbpHGmDKYvYVF09Si25k1Lvdb5EqmUrNFjXf3vnnfvpwb4UfIxpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiBfsSGXMqsfPv+jOnClwv7p+vBp03bXJLfi5BnkoS8=;
 b=A1Jal1PAqS378DTstDUs4U+wmCpbMYTwwMrVzbDmf8LixmlVGRtQab1w6HrWxXzjUC4Du/QL2FdTu8L6pZ6B2/ubMA5zryTG9lxBG0ll8Aq8Fgs1CvpwGhXEsom4wt87rRNdmVNouIfQZpunQGfvGBKoB8/WHFIsRcW/A2w5AcI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 16:54:09 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400%5]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 16:54:09 +0000
Subject: Re: [PATCH] drm/amd/amdgpu:flush ttm delayed work before cancel_sync
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Evan Quan <Evan.Quan@amd.com>, horace.chen@amd.com,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Jack Xiao
 <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>
References: <20210817095005.8536-1-YuBiao.Wang@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <23f99700-3ab4-0111-228a-e844e99d62b1@amd.com>
Date: Tue, 17 Aug 2021 12:54:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210817095005.8536-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::14) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:230a:1a4d:daaa:2e8]
 (2607:fea8:3edf:49b0:230a:1a4d:daaa:2e8) by
 YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 16:54:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 966a36e9-e344-4de7-e6b7-08d9619fa1d0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4542DBC9355CE6C890CF370EEAFE9@SA0PR12MB4542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BPyxJcRPe9CeqpQ2MN3E296IkVHwbf/M0mIGEkjblRzh52BIdEu4z+FD3YSNnFUgmsqQNvVq6Yxai0td9pYpQmyKoQdNV3Si1tFEMU1RSE/0pJ/So9hKl/4Z2vsEcdn/zwMPSqkNz9V1QnWysMVZDmINn+LnUv40asAOqykkXkVOrz1OBMYPPMBCUR9sBc5aZmLIhpYgFOPRY3h8kRXxqjS9pDkcOCdKgF62q8tXC0RhDJAbB8ANB6R2326yua7pvQTgumXBqXDY2L2rUdyI2KAogGk9kt5dq742P9I641vsFJ39vwffSe+4K26fcP0h+HoYU/kslUjFfVIoBtf2KtaUFAyccxpnKXqHsIyoOhW2oJ1w1s+VluMDY7GLR80ChlIg57kblIKuRiQ3fsq7Ccizl58Z79xeHmbDHEPN4huyVWI0TrAWt7axSqyB6O/vcDWWMikqG/VJ4w/hn28nYmAXbGOGOzxSdfHBdMIOHyMU5jxRUj+hvQBOpx3aTFqTCHXyvYnaLbVhY62vnNP5Cmu8R6NagAeWEGv0JUwwgj07MO6jRH0A94PZ/RFCm+l1fXcHnsOr2GT4+R9SkPHxizd8aU/c8kqAZxSF9r7pvIdIWW5M6iaaUXfmwWUqnx7kgCDWA19gZq6SnUD/2CF1wcSI+k4HPJAzcPevtK/6eWXroqPKeo5EoAdfw8OFaaBiuE4fWnHjPPqYYw2rxEtoS34iuOC72oZmIU3Y/wB/sE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(54906003)(5660300002)(478600001)(186003)(8936002)(83380400001)(38100700002)(53546011)(31696002)(86362001)(36756003)(2616005)(6486002)(31686004)(2906002)(316002)(4326008)(44832011)(66476007)(66556008)(8676002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVBZbmsvNjViSG1xMGt6SzNwSVF0WGkydGFNUW02TEVVd25rc1dMVTBLWWtt?=
 =?utf-8?B?azkyNWI0bWVZYndXNE0vNnlPWXZPcTVEQnhjSSttbjBaQ1k4WVphM3ZzSi9M?=
 =?utf-8?B?NEFzMnp3ajN5bnVGa2NmNTNndjgybDZPRFkrNTczWmR2c1lsODNNNEdUTlpD?=
 =?utf-8?B?MGFadHcyNWlJeU0ycFlYd1gvd2cyTnV0d0FhbVdkMldFMGNjakR5bCtTR1lL?=
 =?utf-8?B?dTFzWXBqd1U5bkoranNaOFZGMk11cDRnYXZPSmZvZmxjblRKNVc1UEhFTmNZ?=
 =?utf-8?B?c1I5eElNVmhQL2JwVFNkVlM2MUhRd1ZyZFJ2ZFBLb1pCY2lUUDRTeXJYSnBy?=
 =?utf-8?B?aFA0SUYxMUl2TzB5WExvN0d3dFlIa3BpS2JBeDE4anVZc0s0MlF2Sld3NWho?=
 =?utf-8?B?NVpXSnBMVmFaSG1Uci9IWVVLNTVHU1dJQ2xjOTV1SjlYVUsyYjBaU095TXhm?=
 =?utf-8?B?R1hUcS8zUzFrdVBoZWdOYVI4cjBZTWVWUjM1T2Nwc3pxeE1qemRod1lMUk1W?=
 =?utf-8?B?L3ZQc3ExTnNmYkN5UlhOblhkQXdjUHc1eWpJOS9RUUJXTHVmelBqY2l3OVFR?=
 =?utf-8?B?UnNNNEF3bS81SzM4T3l3MzJKZVNCQmhRbjAvUlFPMXFaenFneGdLNkQzMkRK?=
 =?utf-8?B?dHBka1hMeGFUZHNXZWhQdFl0REp4VHcveUtMaElTd3ZsY1VLVzNCNVNEVWZZ?=
 =?utf-8?B?aEc1VUc1bjJqWWZuT0t2VHBreEkrYkp5dnprTFRMVTl4cndncmdYdFQ2Rmkw?=
 =?utf-8?B?WHlxdnF2YXF1SmQ4eGRvTXU5U1ZIYWpsYlZYelJEbFdRWXFVYTZJaWN4QkdW?=
 =?utf-8?B?K1RhNmFPVTFiaDdIdlgxVDhEbzRzd3FSWTBwdjJTRnRneGh5TzhDNXNRM1di?=
 =?utf-8?B?R2x0SmFpRkhuWERVa08rdlZXcGZ6WmNnaktaREFiaDN1S0Q2NDZrRjlMUHQ0?=
 =?utf-8?B?Q2lzRkFUak5EdkczcG1qZ2l4UThDcHRNUEhXWFBXZExEVGdyY1NNMjU3Zm5W?=
 =?utf-8?B?L2VJbEFpRDgyM1AwQkhYRDN0bWFrT1pqNXdYeXZTSmpCeXhWZFZsWmJmUDV1?=
 =?utf-8?B?ZkZLTksydEszeGtoeTRwTXFvQlB5WXhaQytSYWUvT3M2V3hpa21COTBpQUtx?=
 =?utf-8?B?NkJxUm9NQjE2c3NLRGRFVmdDTmI3WnNYMkNyZEhkbUJxeUxlbnl5cGtVaGxi?=
 =?utf-8?B?YUFVck1CS1ZVNUJZcWQwdmJPVWV5Y0x4bDFucy9UMWVXZmN3cEtLOVdzb1Vi?=
 =?utf-8?B?dm9NNXlxQmR5TTFIR1R5S2xnQ2RyZ3U4K3FnZ0tHZGtJdEtmMWVuSktqTkcz?=
 =?utf-8?B?OUpOcExKMXBDSmNYVG5wZHBRSlhQOFZMS3pNS2ZXZmlSR2piZS9QcnI0bEZ6?=
 =?utf-8?B?TFN2a045cGkzYmp2cDh0NUllQTducWZWNHZFcWt0UVRTdldEODdRZHpITWJY?=
 =?utf-8?B?MWxMc0h1bEx0S2pGTzdrZytoY3o5REJHYUpGWXZBNkdsQnBNc1JyczB1bzgz?=
 =?utf-8?B?OElVVkYvTTEzRmRUK2hZR1RZd3gxM2NIZjFVMTdRY3ExNzVzOE5DYy9iSGZx?=
 =?utf-8?B?K1NMZTlGNGZET1pRMHlFd2U5VS9QVzJwUkNFdCtHU2pjVkhHSFZEcmVJWnFj?=
 =?utf-8?B?Tmgvdmh5cFZLRDFva3JrN1hVa2tmOERpOEF3TDdnamZSc1BVbHVHZ2RRd2RZ?=
 =?utf-8?B?YnExNnh1dXBtMnk0Mk11ZlV3RVRXQkptUWlxSHNlRk5LT2dvN3BMSllxdy9L?=
 =?utf-8?B?T0I0ZUF4TlpvamowU2toMmdrTHhKZG4zY0kwaFk4ZVR6U3phNVNJQUlJaXYr?=
 =?utf-8?B?ZkliY1huQUxEZy96YlFjWm5SVUtaQWwyR0RSNjE1bEdsZXJ5V2wxd2xoTkgz?=
 =?utf-8?Q?CkzO+DdMSZowZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966a36e9-e344-4de7-e6b7-08d9619fa1d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 16:54:09.3701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1iHMinHll4CeFMa/4pzDUB8NQwpTY1UATysphZ7YEJROfHhusAvC4B5HAL2EqEHYacLgFT7pd7R/gkRFaSpkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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

Looks reasonable to me.

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2021-08-17 5:50 a.m., YuBiao Wang wrote:
> [Why]
> In some cases when we unload driver, warning call trace
> will show up in vram_mgr_fini which claims that LRU is not empty, caused
> by the ttm bo inside delay deleted queue.
>
> [How]
> We should flush delayed work to make sure the delay deleting is done.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4d266c40382c..0b5764aa98a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3824,8 +3824,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   {
>   	dev_info(adev->dev, "amdgpu: finishing device.\n");
>   	flush_delayed_work(&adev->delayed_init_work);
> -	if (adev->mman.initialized)
> +	if (adev->mman.initialized) {
> +		flush_delayed_work(&adev->mman.bdev.wq);
>   		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> +	}
>   	adev->shutdown = true;
>   
>   	/* make sure IB test finished before entering exclusive mode
