Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30ECC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 07:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FD610E06E;
	Fri, 18 Aug 2023 07:45:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A46110E06E
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 07:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay80GYBe1IAeYqbdTLXO/ZsTJpuY7/GitNwoXgH5adEjhXw9V2+Mj79hx5d0e/5YZbzQB4xVujGYoeD1hNA++DOhLPYR69DdOCWmJm9wRVd9bNDACOGMKDXnMS1JYzVF0ycg3zETSY7MPNvOAkpsn93IBalm0zBdjVRVJRbEynCWBm3j/At/FqEqBgXy8Y14LNgizubIx8rzvVTb5nh2v2mLnz7FGTPls/xnhPMEPQ+oc3LHuqDIvlnYGL1++eXf1BBkNHcG1AX1pNnrDgtD1yBjhIW1gZpb7BObqpPLm2bUeJrSlSm80YLABJoKJHs10pW54ZY+ehUSQJmFPqsJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2obyFT1tCB240Koo1JupOKfw/+ZFLoRnMaHFIN0dJo=;
 b=l0zB9gnmxCZaFkCrmjgkz/iHyvmzhEIr34kXnkCF/heO3yS7J8OsSrC6JjVhjoR+2/czWdZAaWdg46QXmsS9UFskM04G0XSNVaFiIpbmnPQSoLcpWN2BtauAd5Bde8tge1ZtBVqaNenD/rD5pZL53O37SiGakbvS6SFWI6SLbtlGwUbIK2GAzizCprYh+d5r93bdAcZ7c5oEI+qj/miHBu2DPgrOoNK2Dx8L9fdmv/BJOHRqCZYpi+OO/4HE3m+TWTPs3R1s0kxF/TlVANqLUNYOhYNoY707wDusThxVK0eOO7NXTHgDe7dinSeQbdGWd1OJj3zAvhL403KV36Dzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2obyFT1tCB240Koo1JupOKfw/+ZFLoRnMaHFIN0dJo=;
 b=wL2yZZWR8ziAAf2fLJ4KFXjdAasbui0U9GSxXSufI+CoD1mMtvGunsKniPJXfSbyaAfmBsgupPM2wYnAxS5/yOpdr902stQ+jrWaJnDLecdW+V9xGl+glN4r9IQfvGZSdac3h+LKy+4yeV80Ffjn329xnXyyaTAEVAhimg2xBm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 07:45:44 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%5]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 07:45:43 +0000
Message-ID: <02cc257e-08ea-6706-647f-39e34bdb8b6a@amd.com>
Date: Fri, 18 Aug 2023 13:15:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Fix kcalloc over kzalloc in
 'gmc_v9_0_init_mem_ranges'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
References: <20230818064558.819989-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230818064558.819989-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf690ca-9e9c-48d5-0322-08db9fbf2000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKzVte9Hk3uPnt66alJxpY9+sVAJE83oUz/DkA/LKmB2vxXV6KPu2UEvGzzK8Y6bN8VrDdAF5B5me/F8TwJQuTIvaAT3YgMhe209Oy8vTLxxFf0y/WM6MBl/ZPxh835iyxUbd6D+OGpeECIiM7/Vx5srTPYATuxeyp8MvHQcTx9kwig7+5H3vj/nG8JZqQ/WVS5k5RSI0tLghMM5G2orONgSdYQgCKyNsVMbpU2XbL8n0ObIa6dadbmBG68zeNeA6WVkFZI6/md4rtZuELlQ6TgPC97jZeHZOzwZ0uK7QSLu7g/dIxZ+pjjYGEP/epeUnB2YAbM08Q/612DHUhWDjZ1zLsQmPdtA1136DEpiLZZlYrmvmFIQ0IafjGYz3Wp/stMtOkQZXcAiKHQ7bQJyrcyRX6jylWU61z9Araw85HH8BcxwHOa3voG1Y8FP+gCbrvEY8Db66SNXBGpZy5QvOLuZdr1eF3cpmcQot5UC2bGWLXYmSmgodsQ8lcSDiVosD0HpQ+IAB8rmD/Tv8u6vEIbx64J7zy6h/D85QPs0yxjuMtnkrYTNGh0JsLqz9bpRccDLrw8KKUfCYCziWVRBR3C1sdb/Z8+lehMkQlL184DfzVQys2FoqeUw10PUSzUteB4wyrmrndewWY/VIJdHXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199024)(1800799009)(186009)(31686004)(36756003)(86362001)(31696002)(38100700002)(2616005)(5660300002)(66556008)(66476007)(6666004)(6636002)(53546011)(6486002)(110136005)(316002)(6506007)(66946007)(26005)(6512007)(41300700001)(4326008)(8936002)(8676002)(66574015)(478600001)(83380400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzJjbng5Smt4VUlVQXdlLzhJcU9aYXZnQ21sZHRGa1JMdHpIQmUzdmdnbHBu?=
 =?utf-8?B?OUJVVXorSHFzUGplVXNXSTlCL0d4Szk4L2pXd2dXM3Z1R3lERVM3dEMyeXIx?=
 =?utf-8?B?dFEyVGJNTytwY24rMXdvcllqWWNEMjJocmEwZGZ1Zkw4N05mU1JVb25sMUts?=
 =?utf-8?B?SHdmS3ZsdVFwT0UvcEtFTFFUaG5aTmJoc0l4S2FFQm5wMmJvbGpJQlJkb0Fi?=
 =?utf-8?B?Uzk4UXQ0VTdXSTIxOEduVkVxZmZ3dXpQenFaRWtVL2ZETHFQcjRuSE84Z1Rk?=
 =?utf-8?B?TjdaWWNWNDlFZEt6NUxkbnN5NUZQZGUrQ1UrdFV0bGdmUXdsTkdxcVoyZW5m?=
 =?utf-8?B?VXFjNDlHb0ZTQWRRZHBMN2tTYVA2cSsrTW9uVDEvQ1ZUdmpGaEFtclBCeTJP?=
 =?utf-8?B?enp5N2FrU2NTODVTbE51L093NWRRWlpjYk80bkZGbmQxOXFaMjZzTHhPYmRT?=
 =?utf-8?B?Nko0M29KWGplYnZNd3lvb3VNczIweGF6d1Y5dEhySjgvUnZDaHFPdFZTcXdM?=
 =?utf-8?B?QXMraklLTExBZFVzVUw4dzFPN3dpeUwyUDdIM290aHpIMVppOUNVemUzVVZl?=
 =?utf-8?B?SmxBRXVkeURlN3ZtYlR6VStRRzhLZWxpMXQ0dE5nLzdGUTFqK3F6bEZTdDdR?=
 =?utf-8?B?YXdJTnN1bjBBYUlLK0hoUkdISWRPaFFKSFI0Tm5rU0pnaUhMcTRKbmkwMFhD?=
 =?utf-8?B?S3ZHbkFsVFZ6dU9OeWxhUWNnVmhpY2xSWWRTMWRlaWpyanZaY0twR1hJeUVk?=
 =?utf-8?B?WHpTRkg1cVNBdU1JTVpDOTdCcUNnMDVkOGRBTDhsNmZpWWx2VzNYOXdyT3Bt?=
 =?utf-8?B?NTFGakZPbVZnWEk2RUpKYXlPV2lRQktxMVNDUElzamVtNVdKQkhkWlB5NmdQ?=
 =?utf-8?B?czkyNTUvclFiZkRvQk1UTmtlK2hhMGREZ2tsTTF4ckFkbjEvem96TDY3dXYy?=
 =?utf-8?B?VE5yYUdHYzVDaS9pNDlpVktQQVdWbnBrVjkxaTZhRlp2dWRxejJCMzJYSkJm?=
 =?utf-8?B?NVM2RC9GKzRRM29WQkhhWEJKTjBjL1VXMC9LTExQWDNtM2VWUmEzQ3JCVENB?=
 =?utf-8?B?YklKRzkvc1FBeFRGblpiT1dxeHZFTWRHWjhBS011a1lDbkl1a3dHanNVZlJH?=
 =?utf-8?B?Wjl3YWFmZXA3Rm05VmdCTXVjeEQ5NEVISUZ5WXdhSitwaWk0eVpLUXZoT3VN?=
 =?utf-8?B?dXZOd084dkkzTHJRNXBHeTNGZTNENmwwV3VxdGUyZDhlYlJpbXVGQ3B0bXhj?=
 =?utf-8?B?TGNGSHp5bUUyRnhoVnBPMy9sS21TV1owMTY2NVZCYjlVeXJBbHFLM3Eza3Fm?=
 =?utf-8?B?eCtheHczYkIxOTZpOER0MlNlV1F4RlBPbWM5czJSNlNLaWphVk8wQWFDUWhU?=
 =?utf-8?B?RHNNL1ZmMjM4aUpDQ3RncUxYSDdvd0I0MU1IVkRvVWVyRzVQMVB1SllXYzVU?=
 =?utf-8?B?QktPdThwTnRsSmJUMnZ0MDl1aDBkcHdEN1pRa3JpSDdYcUdpbEpFYzJ4czJh?=
 =?utf-8?B?eHVCY1N4TFZNM3I2T00waytxSWJyV0lSa2hCOW0xR1I2TkIvMTFXdmx1ZjJ3?=
 =?utf-8?B?NVdjQTB2YlRqWWtQY0QvMzBpN3pIaGhmSGV3UGxubGFDdUduNjdRcjdFWG1r?=
 =?utf-8?B?dy9IYUo3blJxR0loZGNyT1ltWGp6N1FaaC82ZDdYbFM3ampwTE45Y21MWk5n?=
 =?utf-8?B?WFpzVDgrYkwvSUR6N2Z4YzJGa3Zqb2ZVWWRSOGI1TUd3Z0RFcUYxVkdFdXZT?=
 =?utf-8?B?VXhqVDNYenVwSm54NmNCVC85WEFDQ0xIYjBTWVc3bjNhdEh4TXZJNlZhN0lj?=
 =?utf-8?B?NGFNUzlSd05LZ09Qdm5kQ2Y2QzdXWkdFZGxvUHNkbE5pOWttUnd1UDZvY1FK?=
 =?utf-8?B?ejZlZFBNM3lNR2lsd0Z4NHN0dnY0YVpuclhEMUUwaHEyMFQ0TjZmQlhCSFdp?=
 =?utf-8?B?WkxvUitQVUVwZVJXUEZMc1I3Z3VhK3AyR0MrcTVIWWdDU3QyYzFZQ1B5YUJV?=
 =?utf-8?B?Vlkrc1RPekppcGtWSVB1Ry9ZQXlUUmtVZndKQm01TU5zbWJ4WDJZSjhJQmJV?=
 =?utf-8?B?SXZHU2hFRU4wWjk3anhhbTdLQ0VXTklCRktIMnZkOUY2ZXU0enB4M09sQ3Zl?=
 =?utf-8?Q?Zga9tGZpK7qA9RjxlJ/FVEwbR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf690ca-9e9c-48d5-0322-08db9fbf2000
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:45:43.2496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qxweBxOI9DQsmmTttSKOdkWNcix8ijAAIOZ4SHVfkt+ERQrKvo5oBMNft/RoLmx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/18/2023 12:15 PM, Srinivasan Shanmugam wrote:
> Replace kzalloc(n * sizeof(...), ...) with kcalloc(n, sizeof(...), ...)
> since kcalloc is the preferred API in case of allocating with multiply.
> 
> Fixes the below:
> 
> WARNING: Prefer kcalloc over kzalloc with multiply
> 
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index f9a5a2c0573e..0673cda547bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1972,10 +1972,9 @@ static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
>   {
>   	bool valid;
>   
> -	adev->gmc.mem_partitions = kzalloc(
> -		MAX_MEM_RANGES * sizeof(struct amdgpu_mem_partition_info),
> -		GFP_KERNEL);
> -
> +	adev->gmc.mem_partitions = kcalloc(MAX_MEM_RANGES,
> +					   sizeof(struct amdgpu_mem_partition_info),
> +					   GFP_KERNEL);
>   	if (!adev->gmc.mem_partitions)
>   		return -ENOMEM;
>   
