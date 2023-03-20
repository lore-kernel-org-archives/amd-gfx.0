Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC81C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 16:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A852B10E5E9;
	Mon, 20 Mar 2023 16:16:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931BE10E5EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 16:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL01Zru27lP/3GI3KSzoJNu8NV7PwLp5qYxPizuN31C7bB0B6k64kbb+Nv43aHa7vYj6mnyJR7vl1WBOfVHbFkp+UfazdxD2YKgIUemuZfVxE3NZA0T6iIT9RPQbvtqXwx64UBbGQpENn6KwKEvzQwtd39bAUbF8tdtFXTppApLmJcnwcTspUhsxF7dj/pyYzvLz/ll+5Za5Sk3XkFn5xW4x4mFfS8/962wwEfVNjQyAui6oojgMmC3nYD8Ers5CSlnt5qYnGUEj4lnBrvXLd6ivOP3jTgffMINy+Y2PkcedhuOB8cS6A963Xp5ZylwF2OEa7PxXG8dPFd0EZrywuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80MBbS+VX/y7Fvxkl6E2yZuRf00pXcQXL7fGLloNSRs=;
 b=GehpWpI8BHt0vka6r/KT+VWa0xjhj63sx12f31Y7IlDOjo6utNtuHFu9sPFcuAkN4jx3/W9KoqhG3qL9xyWE3UErFo3bs98Z4BGVI2Z4uOBtvK7snq20asKO9XjuZnTP3IvvHz12ZxtKRuRG+/IvBTU70dlmqaH57f69BfdPIRL9h8yNZIIs+YzmkS05Ohb3pHNNJokHkhK3ClwkdDzbhlTRz0RaRlQ7ZrqZjoTyt8OdSJb4e7kAHDbowwFVOroM4i5RlPYvrzEGzOCd7SsX4Pklmg1mvQaCeV7ZbMWNSb+U3wNcjJQLURU6KCFnvT3MKcTM79+MI4LROXzNbfvjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80MBbS+VX/y7Fvxkl6E2yZuRf00pXcQXL7fGLloNSRs=;
 b=uej7/2tmw37+u09QOx6MqoIxquMUQpEj4S/3gMtDFCUe9KyVH4sT7xWmXVh52vAvqyUAP8rDklw6Njabcar95kHjL4bVqycw7inuFV/qVHOvNs+ZfV+40rG7wwGdPC2rzl63sd4+xERwpeRBYBQFtsUTVbEO6Z7yV0/FvrfDk9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5375.namprd12.prod.outlook.com (2603:10b6:5:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:16:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%5]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:16:01 +0000
Message-ID: <a25a9826-9778-73f8-dcb7-1c15e64782a3@amd.com>
Date: Mon, 20 Mar 2023 12:16:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] drm/amdgpu: add print for iommu translation mode
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230320140858.1420216-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230320140858.1420216-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5375:EE_
X-MS-Office365-Filtering-Correlation-Id: 2036c17a-7189-4f3f-be6c-08db295e65af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBLduDKhBeLpxNgD4T1dVm7+5b8dYathClUvnriYuG7fPkhWy7f0Chhf1poruYt9RiHGFBo3ZoiFfvmgXhjxznYuPNbtK6hpS0Fv3pMkzj1gmrTRAzOdAjytvDMxIrTxTiqYl461Fitnq/M08xJ5AAsL3CZxToMIklMpBh6P81j+TYXllVg+3BKVFRKalHWZjP8X+ZNpOM6HPAjKr4us0AQ1JuF5Q0D53Qti0ZH06ki62e/+A+lsNwrxg4Ih00Xah0oQb2AFotPCx1ByXDZM9On9b65GZ0evjHm2kiWn6YFXs4u9VjN3+Cvg4cgBsGYoDLW2SP19okKx3Y1PCRMASw+CMpvcVw0NE922YHLxeibt/wZ7gR0yr8Nnc0FU/a/6muYfuc5QKgOt7DkRa05A2r9+KR+B649q28tG/vybgkHjm9XldmAof3wVYihyuLxk+pe9Dc68fYEK11KDPAU2/cVMfVfEE23ZtL4K8M5XpWo0grc5y4iukXv+uA6BJNfW+I+tic3pPJxpkxstcvIADt4aFsnHDsHh4IbDZiEvHFkYaSn555b5nP7SElmgLMjVG+z/SubOd9pOun6qq9zDjeA7jb6uwoQr993rZ/aCzkW6VtYOKFAFChBPGp3bgUf08xK8jsKoG7erJPsUj+c4VfyjFW20u2F4UAP2kwldztq6709Jde/YVBB0qJQdoUiPN592fvmhWcLmcGf1nCxfPGt/en6guPN8vsACkCgGllM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199018)(31686004)(2616005)(83380400001)(6512007)(478600001)(6486002)(6506007)(316002)(5660300002)(186003)(53546011)(26005)(36916002)(31696002)(38100700002)(86362001)(8936002)(2906002)(66946007)(41300700001)(44832011)(8676002)(66476007)(36756003)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVdZaWxjU1NaN09BbXlrU3VrT2tkWTltTDJCYnZmdVVXK0UySzYrYzBYSW14?=
 =?utf-8?B?S1BsT29xa0QzbllvRks5MFQ0clBKdlVlNWQvWW9UcHNiQmZxZWlHVTA5ZkZo?=
 =?utf-8?B?TjhEQ3hPMkg2Ti82U3QzOE0xdFMyWktQUFhKbzhnUm14MFRjQlFyVmRPVXNv?=
 =?utf-8?B?VWc1bHFrT3M3TWZyTG5ZZHlHWlJPT0JhWjZ3TFNLRmN0U2NTUUpYYm5INEpn?=
 =?utf-8?B?WDY0LzhHRkptL0o0TXBmNXBoUXdvRHpadXAzaE5QRzRrR1FKaXlaWWxQMzZj?=
 =?utf-8?B?dFpDV25IanZnWERwcTd5c0pnaVY5MXp5WmlvTjUrcmV4MTNpbmlwK3pZQ0xY?=
 =?utf-8?B?aTJGQzYyazB3cElKQWc4SFdPaHBTb005UERDVzdaSUVKamFDeU9rZkkzeWFK?=
 =?utf-8?B?Sk1qYUxmQ3Fac3daU2k2a1VjMmthaGUvampJVlB6L0dxWkdDcGhDUjBJUFVm?=
 =?utf-8?B?dFBuMFVjbldKY0ZWampFZ2kyZlc5bWhFVU96b0RwakM3N1Y0UmRaQXlJNFMv?=
 =?utf-8?B?czVoelI2L1lWR0VZVHBmeEEya3FTc0lpbUpIOTZtQmNOODc0SWFLMEN2Szhj?=
 =?utf-8?B?ODdzczVnZklFRloyUnZKUENNazVEK1lFa1krMjQyNjFOZ3BuN2RwOVlLclZM?=
 =?utf-8?B?cVBtWmVGODRzbWNucWtnWS9lTU1uYTlyYWw1cGpXQ050MEIrUEVTemU0Vzlq?=
 =?utf-8?B?NlROODZNUFNDZ29HbjhCYWxIOHlFdE5IclN1TktIa1A0bXZGclVuWEl3RnRM?=
 =?utf-8?B?R0NNM2hEa05pTnNuNUVIdnhuMUdPeHVvMmdkc2k3K3RBNGhzYUZYT2k0MmZG?=
 =?utf-8?B?aTkwRGxZTGd2ZXpwYVh0UHB2OG1RS2RNbHVYMnlja0t6ZlJKM3FueWQyOENh?=
 =?utf-8?B?TDVyK0xrNjJXY21GWW5wSjBhZUlTQkxTQ3J5YzkxU2p1MHJGVDlaQjVJQXdt?=
 =?utf-8?B?WEFRd0YxMzhQZ21CNW5DN3IwVzB4bUZHNkNocUZOQkZjb0NUd21kU2d4K1k3?=
 =?utf-8?B?WFRub3ZxdHJVMXNnRU9UN2IyQWpyOTAzN0lCU3FXQ2ZFZ3p2Qk9YK0xMY1Fs?=
 =?utf-8?B?VkJuVUtJc005ekMyTjFMYTl6RWFEMjZ1dXBlWUkxV284M0JRV2hFN2NwTXZS?=
 =?utf-8?B?VWpLMlljOW5zcmFWNXowc0RPdTQyb0VaRVVBb1hvQWF6V1ovVVRUeGRZR0Ji?=
 =?utf-8?B?RExhQThQcVZoZnVHbWR6NXFTT3NmRkZhbzFFaFg2dVVjM1NMeWNNMHQxTlRV?=
 =?utf-8?B?dE9nVGFkcWZSTHdHQytLeVkrY1FEbWUxdDQzUVJQNTJaejAwYUtwVCsyc0FM?=
 =?utf-8?B?NlpQSy9HY05MWFo4NStqNUt1amFVaWswSGtUSndGckZESzE0Z1hVYjZBRjBP?=
 =?utf-8?B?ZG5YdmRDOElTcXVEL3M3ZGk4SllEdEZ0bjIwaEE1V2RhVjNMU1h6TGsvdEpw?=
 =?utf-8?B?VFFtZlJQZnErNVF0NW5CWDVVak9UVHpZSmllK2VnSkdYYWNNRGNGN25tSWUz?=
 =?utf-8?B?elZzWXlMcEdpeS9sY3VsZHBSUFIyNVJWc3dsSHJ5NDZXdkJ3NGRZd1poTTBz?=
 =?utf-8?B?R2wzWGNraFhiSUFndEFWSzM4UHYyTi82MEJkRHVrSFFjYk4xR044M1RNZU56?=
 =?utf-8?B?dmtnYTgvQzl5WlNjQS93SjdWSW82dFpLT0pXTzFjbTI3dytvYm5nKzhQcmFQ?=
 =?utf-8?B?aG9ROUdhN1l4M0wrTitWTFlwZitNMFRRa0tWNTN3bEJXeUxsWmJLMG1xUGFP?=
 =?utf-8?B?V0l3b1dyMHpwb3hPQ01lUUVPaW11dzNWR0FNcUN3RFFpK3RwV3prTCs5a0xF?=
 =?utf-8?B?R1NnaDBGczZ5VEpxZk1LTGtIZXhXaWRuQ2xiRlUwVnkxbGlBMjAydXJXeFhN?=
 =?utf-8?B?T1lWcm15eU4vNnB4ODV2N3pxeFlpUFNPQUJjTWRoUFdoUVJnZHY3UlZMS0c3?=
 =?utf-8?B?MmVuSGp0eUc3MmZOZHV4cm8rR3JUODFaR3p0ZmRsa2trMDF6WHd0eC9vR1hR?=
 =?utf-8?B?VG1OVkxocFVEWGx1WTAzZ0VSeEVYTXhNMU5LYUJKTjNHTVdiR0xNbU42YTNW?=
 =?utf-8?B?MzJ2aE1nS2RXOGZDMW85N29kY3JORERzTWpwTG5FbU5uUDdsU29tbFVFYnhh?=
 =?utf-8?Q?ivmFBrNaXrXfTGXQiawoLOqol?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2036c17a-7189-4f3f-be6c-08db295e65af
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:16:01.3831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ICWTRqjQOGosD9CVxF3KQyZPz91uHguh0tE0yLxwqWE9HfEzu6EtcAFURbh3BJeYGZPpDUFWERA0aALpqDAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5375
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

On 2023-03-20 10:08, Graham Sider wrote:
> Add log to display whether RAM is direct vs DMA mapped.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3bd6c5aef796..83774824694b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3528,8 +3528,12 @@ static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
>   	struct iommu_domain *domain;
>   
>   	domain = iommu_get_domain_for_dev(adev->dev);
> -	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
> +	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		dev_info(adev->dev, "RAM is direct mapped to GPU (not translated by IOMMU)\n");
>   		adev->ram_is_direct_mapped = true;
> +	} else {
> +		dev_info(adev->dev, "RAM is DMA mapped to GPU (translated by IOMMU)\n");
> +	}
>   }
>   
>   static const struct attribute *amdgpu_dev_attributes[] = {
