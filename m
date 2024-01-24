Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F96C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 10:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6138310E9BE;
	Wed, 24 Jan 2024 10:29:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8F010E9BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 10:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahWkDrU7avUmi2P9vml7s+u/yK8gIxAt6MYT3cOBtP4l0PCZfrwVfu5p11vqnDBDjo2Wi3vFpO7XzMVv/lgJ1E0HricHNip0sepg2OejoXimZtb/0w5poJDZzipjbqHw7Y5zOBfH3XZTaZdktjDIhBIOoXEpxPTaSfr2YURUogcMHpeTZJvQNrevGiHS/W4aD0VVmmQa9mGy6lU04Q22sngFfe4qOLeIvxSPXPaW/Jt2HfD2ENG3pb8tld7hKISWcAzpo9XRbZYOZtkG5t4BIQEWA6za2UKLCqlVxQ8yCEGcgxusIrGD9by+F2AON2qbDroTSpebcoetFTxDVF1Uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KxfveHzpDNbfdRB96pu8PdQnwkS9OOt0wfDI0VnzEk=;
 b=cGjEv5RZR+guar6PMOmJaMDw0YGWQZgLjBvF6dE+94JfqNSfUywEAkS4C5Oars+5y3D2HNV7YpJZYgsRCJ/xDZkpehYtCHQY/VUadgN1fk7nkOFgOwN4DRZM5gmEzxdePVsQMBJqLPk9UQiQxKnpAqT2xlMXfuHwdkF0iDcpDLK6MRjKecc3KkiK36U1qojZ4FKdbVLgtV24te+1KJFNKF7sTWnc9KSGuaentWXIMK8SNKPS4PvrxX/Gg6c3mFZKfmAFL96lrXhCJBVUr7biDEBuyGKN7wkMwRpzqabKeDznTueI+mfhkiDFuBVfLhcZRIWmwcPTwIDsliRWtfTreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KxfveHzpDNbfdRB96pu8PdQnwkS9OOt0wfDI0VnzEk=;
 b=GlvCZxAOM6pVzIJ3Ib04DbvqIau3YyR3OHbiD0rd9rCHQ9HNJyDPe/gpVbu3zjXvwA8PzcGjfP6KNPTWiT2fgag9QmBit+bmSHO1ZA1RMD6OIoq606E4GsR/IQsw5LkXeNsQEmmbqtlRseOaHNvig58oB1fBYpVFxfMEWeCVfVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 10:29:27 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Wed, 24 Jan 2024
 10:29:27 +0000
Message-ID: <079aa468-f330-431c-9f84-4c3993ebe83d@amd.com>
Date: Wed, 24 Jan 2024 15:59:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: enable interrupt prior to kfd device_init
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240124085850.29188-1-le.ma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240124085850.29188-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::6) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: affbfcc5-210f-4dce-4002-08dc1cc7575a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afDYMHGQQ4Z96Ry3uTqoX0atT1wAWmPaZQMNcwoMzjQ3/xJ+2XFohyDtw/N3Md+UlzZ0jcVNEqo5TRWHepvBfG7iOHBDyQyid4A8ss+SPUlxwBICQRZItLw2C8y5knVFLT7onwtQFJE15geW7M6YJUSBzR/aH04mUQ0qKcS69VKNQFBcS/LGQMP8our2XJxRVKsQYjWt4czPF73tnI2Z8oXz2VZ7ICGywIQztQrtnAMYEbgsK1c+m5XAIm/duH5Cy+38hrnla+31n/+SxyJzZ2qVUyPXq0yZV2NWH+g9h6M/5NgGnEvexDbI99hbcHdxtAwEwheTeIzwWN9aGdtKQKurEhvx8zWlf3+YD0wMxcjRvDOmUk2UvHbJfMvXbe2phrKw+kJCg1sC+RCyjTvkgp5KzJBOjECkJIeassvo0EU9OnI8F3m2D8BbViwzgEoMSMmSiZmnjp/LTjBH/V4O3fGP4iM1PUF1dlpscpLJNOIMmSae7LVKdj9NwWyaBlPe7x3+wk0ijHzq2hWcZRV3QSxwdYU+jVi2bkYeuvksmPsPnu6acwzUtTykY52FGEu2Pj023RPegRWRbIQZ8KnO+orLiwF6RPrR1RaJg5ISY6ml6aJ6ia5GWkB9Vme1CIc0QOr+ZbDsYUl/JQtgDjizLWVwEWkZ3EgOaO1Ssve0kO+PaH819Iu9n41mLIE2fXp+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(8936002)(6486002)(26005)(8676002)(4326008)(66946007)(86362001)(66476007)(316002)(6506007)(66556008)(31686004)(38100700002)(6666004)(6512007)(36756003)(53546011)(2616005)(478600001)(5660300002)(31696002)(2906002)(41300700001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0RhMExPZklobWJhV3dtOHZLWng4Y2dBeG9mMDc1MHRPamMvZWFURkIyeEdx?=
 =?utf-8?B?TC9PTW9rdXF4V0xObUpmV25Dcmk0a0hwSlFabUU5MndETGRQUENDb3BtVWtW?=
 =?utf-8?B?S0U4ZEc1c294ZHFSSlhwUGUxdGlwRzlvNnBZOFlwUXdkeXRjeUd4Y25ObDRG?=
 =?utf-8?B?MGVqVk9BdDRBVVBILytEUEM2YWhUVXVJYlVRK2pPRUdYenJ4K1VlU3pDeFBE?=
 =?utf-8?B?dlZtRzBQYkVmQ1RKRWdqL3hiRnpwRmhSZTNBTGJXcENFL2dHR0lWNFUxaUxq?=
 =?utf-8?B?a25qNk1NczZvaVZlUmQvYnJNcGFib0tPdjA3c1I1MXNCb0VHbHRyanpRQWRL?=
 =?utf-8?B?bDNSM1VhbTJKYmxydHJla3dMS3NqSUVQVUw3bHcrLytEempRV0tRQ0o5T1p6?=
 =?utf-8?B?aFJaM3VwdWkvWU5GWHlWQU1seUtIa3cxQitJTTI0Wlg3bExGSXJZOVhSRnZo?=
 =?utf-8?B?QkZjZEVqRFppZkFSOHllTmxYV0pnWWtHTUppcUx0ODlEOFhMYU5tVFl0K3o5?=
 =?utf-8?B?U2JWckJzdFB1U1FkSG5mTjUxTGtEMmhOVEdRNTg2NnUxQkZnYWEyeWRZQ3py?=
 =?utf-8?B?d1hSZy9pQzlRdUpQUDg1N2w2WmFtVU5kUlRVM1cwZS8zWlgzdTZ2cStDYkYz?=
 =?utf-8?B?ZWFNZzZuZ3Z2SEFTTzFxMjgrc2lqZlZRWUc4WFdUTzE4RkZIQ3c2UHVEWUdB?=
 =?utf-8?B?ckkrbkFsYUY4UEdaRlk2RENOdVZnbXdDeGg0eTZwMWxPV1AweVR1YXNtQlh2?=
 =?utf-8?B?cFdQZGR5RWxOc3orR3BITktKb0dvUnEwQ0NCdElyVFpTQkFYTGlEYTRwWmYx?=
 =?utf-8?B?ZUI3QlFvZWxNVUlnR1R3bXVpTVp1N09YS3NvSWN6SzVLUXAvRHdkb3h5dW02?=
 =?utf-8?B?NERIN01iajNVZk8yUm5jZkhoWXRRdUN0T2tkYkxVYlNpV1ZrQ1BDWWVJVmtW?=
 =?utf-8?B?blNjMEltR1IvMWZwbmxtak9vSHM0MEIzVUhlWE9ObWlQUXowQlVqWkhod3pv?=
 =?utf-8?B?cHlBN2Zuem12MHlieDB5UVNIU0dpYllrNk93VENWUjRGRG9yeHBaQ2JzNk9F?=
 =?utf-8?B?c2FMdzUxNU95ZndDOFBuczZ6N1hVWGJjZnIzakpsaFNxQ015ZlNCTWY2ZHRx?=
 =?utf-8?B?amY4YUt0aDl3aUFtd2NzVS9RNldBNktLY1M4YTBuM2hTNWVOYXh2OTJkL0hr?=
 =?utf-8?B?NWV5SVhSa3FobG9Mc1JGcEtmUkhWRXVVN1M0eEdYU05jOEJYYk15eEREL0kv?=
 =?utf-8?B?ZnN4M0NGREtFUWxYL2Y5bFZnRk1IcW5RWi9aNFVHYkhGNlozZ1c4eVlTanNQ?=
 =?utf-8?B?TERGQ00wdWdzemV0eFJjTXJDRG40NktLZFk0d2xBMC9KWDFRcWNwRDkvd0tD?=
 =?utf-8?B?a2d3VVg2SEJ6TjR3ckZyRmM0R2h1NnNYSnc1TW5vcWMzY2diTml2OXJsQVdP?=
 =?utf-8?B?Ung5Ykd5RjN2ejFIUE9RYmp1YStCU3JYRytXWFVtMVFyb3FBRGN1NVdsTHNB?=
 =?utf-8?B?YlVzRGpWbGt5bEw4VUR0Tkw4eGZiWUlmVmw5dDhBVVN3Mm9QVWx5U0Y0Wkhp?=
 =?utf-8?B?NVpjRGVvZEhlZkdneWlRdFFIb1dYVTlPZnY1VjFRVDFDR0gyczN1SjY4eDNT?=
 =?utf-8?B?U0hqbVFLTDlQck5tU1V2UlczTDZHNkpaNTE1K2dudzNabVJQMExGZG5POFJ1?=
 =?utf-8?B?R0IrbEhabmY1bURYMFpnenpCTlQ0WmVRcW9KS1Y2cnRzN1gxMjVJR3k5NGhX?=
 =?utf-8?B?TlNNdXRKUnpUYVRCcEhybWdzZWFrS0k2cVlyc0IvNytuTWZZZ2RRSnAwL2k5?=
 =?utf-8?B?OHZldGU4TEU0RDVyVkhUc0kwL1pORWpZUzJLeUpGWlE0V2pWc05laTI0RGlZ?=
 =?utf-8?B?RUEwVlpYS21VN0pzMjZrc2ZvWXBNcXpOQU1WOGVrcEx1dnVuZDMrT0E4eG5O?=
 =?utf-8?B?TWE0U3owZVllekM2eXNGRHNFOGNhbzNYOXUzcXZmMzZOcnJHMW9Da0hKcHdO?=
 =?utf-8?B?MzlMWGpOdHd5WGJlQ0MyMHUvcW5HN09WbmtBR2Y3YnlkUU1GTTJWNFdmRTdI?=
 =?utf-8?B?eE1ndmU0bFpuM2dHMk1oWk9VSjZLUUJ4clMzNmRpTm5FV3FyNGVEY0trUkl3?=
 =?utf-8?Q?VB9itVue8LqdrYQUQWA8lyLgD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affbfcc5-210f-4dce-4002-08dc1cc7575a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:29:27.3326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLYSQU2JSACGz5dOChwcr+Ihaw6wtQH4h9ueRKWid0azFU0kqiUyRfF9LRw7wq8b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2024 2:28 PM, Le Ma wrote:
> This patch is to eliminate interrupt warning below:
> 
>   "[drm] Fence fallback timer expired on ring sdma0.0".
> 
> An early vm pt clearing job is sent to SDMA ahead of interrupt enabled,
> introduced by patch below:
> 
>   - drm/amdkfd: Export DMABufs from KFD using GEM handles

I think the fix needs to be in the above patch. In this flow, the client
is initialized even before the drm device is registered.

Thanks,
Lijo

> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 56d9dfa61290..c8aa07282366 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2833,12 +2833,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	if (r)
>  		goto init_failed;
>  
> -	/* Don't init kfd if whole hive need to be reset during init */
> -	if (!adev->gmc.xgmi.pending_reset) {
> -		kgd2kfd_init_zone_device(adev);
> -		amdgpu_amdkfd_device_init(adev);
> -	}
> -
>  	amdgpu_fru_get_product_info(adev);
>  
>  init_failed:
> @@ -4204,6 +4198,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  
>  	amdgpu_fence_driver_hw_init(adev);
>  
> +	/* Don't init kfd if whole hive need to be reset during init */
> +	if (!adev->gmc.xgmi.pending_reset) {
> +		kgd2kfd_init_zone_device(adev);
> +		amdgpu_amdkfd_device_init(adev);
> +	}
> +
>  	dev_info(adev->dev,
>  		"SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
>  			adev->gfx.config.max_shader_engines,
