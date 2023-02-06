Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A630C636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 16:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A2310E996;
	Mon,  6 Feb 2023 16:20:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF68410E996
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 16:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDtkpH3LYe5647Ipljc8Th/oubeSV2yarEBK7nDBIQVoXprKXgpegnc9oEZkLOqnBzSevNRmQkGzUvWkT4BDlA/E/xfW/4oQgbGSupcvg4/rgeNaA6+Zt1VmP3e/y4QtMf82e1xzJ5xSu65YcUJ3XyR5dzKIkZNLXymkEPeAWLf++cztJFky4WjC+Ckwd6Xpo4Wjd9nEBPxE19NU9LNZwjz+1TA049a7X/Xe/mIiBtQ+LrxkURn5Bc2QorsnFPJyBKiIO+LZEloQR5hdspFAfjF3cGMOrkTYe2eqWOtm5k7mWdp5dCbMiKYwSNqNqYy9CjRUOXSujLkJqFHkgoSnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EskKnh+miOHD5uffHDn5GwZ35OucgP5CbeIbHQ5bF9k=;
 b=Kk6viKfNCbjr+uOsjDZrq2N91E0wWIVnvw7ECVFhuxTnhORe6Eb4xsI/cCn1iygpBFOtWwD88dSywneLtj10ZlXLhOT+sIWPaq8yMVQoXtngYEmgYu7ZNDzd5zwmFe7s1V38SqzufC1oJkQTvmUQ05Lb0+ra0RjEVMuxWXfjIsuHweSckLONUsBPo3WMCLducIszSuwYGHWmKJF/0hxYu2vbk0xrZXI50Cz9jRiHG+Ej6SIcPqehxnpPj6c8zhsVRhbgb8eqiwnbNTDfRsGmgtCxNcC+5enT5YCx37hrs5KHOHr4uuwiHB9wQbnQy/FI+1TkgerJvYID0sCUIrLbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EskKnh+miOHD5uffHDn5GwZ35OucgP5CbeIbHQ5bF9k=;
 b=jXeZ9wp3h4TbGWPILgjQycNlNzceTa5abDKb53v6Bn71Yem6UZHXfVrcOmVZHTqhbchq9gmVaXMYKpQ4Ap1++Oysvb3deyjq4ypkfMG57L71mVuHM4gTN+i9HcOEUQTUBzst2f9avkCd3jq3cUQ0wjc/OlVc5H+mwzzODB7gGvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 16:20:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 16:20:30 +0000
Message-ID: <13425a17-813e-05f4-edb6-c289079a9dc5@amd.com>
Date: Mon, 6 Feb 2023 17:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 09/14] drm/amdgpu: move doorbell aperture handling into
 ttm_init
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-11-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203190836.1987-11-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: c6abffc3-f886-4a82-59f2-08db085e10a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ZQ39vkGPZRDye7xPyX2m2O6tyyI08jnNb28kNNMHXH2NL7YuvSDfJOKm33ar7oTyclDHDlqcGjHbrJNMhtf2uMsNBwUvdwbI9eOFy6jxD8ns9iMyKoXWzFONw8f56wwcOzfQTIBfIdLUN1vhGNBE+7/0OwUYsyzHJlEquFFn+aCRFr2iHuluw6NICZfMD+UgTbAh3YX5p6VPWMlXbKtR0PvOv9L6fUFZsGxyF1x4+y9z3Q7pTa3c3sDxpBenGpYkpXHkZ/Op6ECmB7M0fcYnRWwzHLM41FVAJuNiOmuTLaDssBhVy72m1EVXPaaT/AEChUNbCVBXF3dw+LnmMaFs3lpURXgzUMTLjk+PebLzrzdeM5fbKTGVJcZ62km/HZS0k0R9cl+sLkNdal7l32aclg0VcFK3ln2I/fAnqVyaw2Y1r5Rh/ZFlxOfv31zEGQ7bTc+TQ/AM0hV/mQFtlb/x59eNBZUvkbrnEETxDsupoBV/EoMmOIUoTX4M+vpwXuqfLxGLzczP1nenoO3bMgCkDDYxqywHM5HiCxfuLJtl6Xo4AdTBBs3h6MPElCGo2ukO8dDZMJwFu5k4GfBSoty361Hqu0SxEAzS38BdK2esVpx3IUHOUsAfbRtv7Szk2DnKKT5tKHchoyp7CLgm8cLNKvo8/cCgGahioJ0H7fm1gv6zVS/Lnl0jjUgOlY6W5Ia+m5w30FvdtVtiGoULylDlnodJ9ZPiRQ35gT+AA0SKt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(31686004)(66946007)(316002)(4326008)(8676002)(66556008)(66476007)(41300700001)(8936002)(5660300002)(38100700002)(31696002)(86362001)(36756003)(6506007)(186003)(6666004)(6512007)(66574015)(2906002)(6486002)(478600001)(83380400001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk9PM2tUd1p5QUdsZUdnd21hVEFQTlR1cENUR0EydjcrR05sOXM1QVp0V3JR?=
 =?utf-8?B?YW9oaHBaRGMwa1FuMjdXdWh1d2w2VjBRa3haNmROa2RpQ2dDWGVFQUVSS3U2?=
 =?utf-8?B?aXZ1NXRXVEo1ak5vQnRKQUFzc0g1YzFzM29mOThub2k5MnhXckJYdHY3QVlQ?=
 =?utf-8?B?Ti9CQ25VWVgyaGpYdnQ4QjJGcjdBbFNGMFd5YjFHVU9kSDg0bk1CVVNZNDdw?=
 =?utf-8?B?MjhhM28yWDl3bHpiRjl3L1I4ZFUya2ZjMmJNM3RkUCtiRTJWbjFRU2g5TkY1?=
 =?utf-8?B?dktXQ0FOTnlXcGJmZWFIMmFxQnozWDZQd3IrSWQxY1pkbTFMUTBGM3dicmdN?=
 =?utf-8?B?S3FSN20wRlM5UzNzRzgxa0ZZdGhPbnFJMyswck8zenBZZHRONW4yWE9PNmMw?=
 =?utf-8?B?R25tWVBjRVZCNENtWjlmUFQyRXB4emxpL1dsZzFFOWQ5eHZYUndIM0JWY0JN?=
 =?utf-8?B?aUEva0Qrajg4OWN2Z1NnRkMram1zN1ZHMXVnaXlXUko0UjNEU2hFbS9ERFFh?=
 =?utf-8?B?ZXc2b0xsNDU0V3BTbUhTNUk3eG5RZk0yajNGV1VMU2RnUm9ZZTFiY25GOStM?=
 =?utf-8?B?NTlCVDMwbWhZL05QelJCa05OaTdwNHFTYUJYT09EcTAzSXpoQ3h5d3JPU1dz?=
 =?utf-8?B?bThJRzlickROV080NHBUTGVnMWs1Ui9ZY2VFUmdGem9SOGJwUGlOK1NOa0ly?=
 =?utf-8?B?VVoxeFprS09Fbk80SGtyTC9UOGlCMDBpbkJjdFlHV1JRRWtJU09OOVhsMnpx?=
 =?utf-8?B?ZVplQ0IrSStua05keHhXK1lpcXNFTEVhU1JlSXp4MjdtZXBST0FUMGNFOXo0?=
 =?utf-8?B?RHMza1JTUWNGbHJWc2lEUDNTZzQ2RXl4czJ6YmpJeEhLS3I5ZnR2emZUTDJt?=
 =?utf-8?B?TVZkb1hHK1JlTmpBeUNOdzFwU3NOTStQaTYrUWw4YVI2UitlSHNGWElvakts?=
 =?utf-8?B?Y0RJZ2Urc2xmMFVwdVNXTWhsczkzVmxzbGd5VTc2ZCs3K0RmT2ZaMWp6SUZS?=
 =?utf-8?B?d0ZPLzdlY3gzYndoTGI2S1c5Y1ppb0JESzBzcnFnbGJZdG5SRTh1cGRoOVNG?=
 =?utf-8?B?SE9BWk4xRXpZTENIaXI3UTBqZWJ6Tm9vZ3hJbVFzZGpUb2ZYVld3UVd6SEd4?=
 =?utf-8?B?UklWcjY3M1kwTFZ0T1hiVmdaRUh6eHZOY283WitHd3dNZ0RsNEc1cUpDNmhZ?=
 =?utf-8?B?clJzVVZzekVpZ1NJbUFSU3lyc1NmUUcwaXczK2IwTFFaMEpWckhHVEJibHJZ?=
 =?utf-8?B?ZVBodkpQQSsrM3BSTkFid3gzVE5mTlRRcUlaUVBjZ1FlNUVqWHA0Vm81VHp0?=
 =?utf-8?B?d0VOd3JxM2tDaE9Mcm9Ob0ZmN2V3RHFjQkppMXNZSXBIc01xTGdRcFRCRTBU?=
 =?utf-8?B?SVMrWjMvVkZwK2lNK2xnMlRlRkw4NUV4UGVlSVJORUdLZ05LVWZOdlJnWjQ1?=
 =?utf-8?B?bnB5Z1haOXdhOXg2NUdRS1hSc1ZIcXhFL25rNkl4RUxERlVML05hR2F0MVhu?=
 =?utf-8?B?SkZadlJHQ0UwckNtaHRVcGZpQzYrbFdlUXhYU29GMjdmWFpTT083S0NYbUpm?=
 =?utf-8?B?UGppSVV2dkxzbHd5MXhiZmVFQVZJOGRyNVJSeHRJeWYyUHQrQzhOM1M0ZWR0?=
 =?utf-8?B?cmlGYTMvSTJaUkNMMUJncStReStHTDFEaUZSS1BsdjRjYjcwaURRc1dwQW5K?=
 =?utf-8?B?K0VOZzd5ekRvcjlTV1JxRmNrNTRhYWtyanpwNjJnanFqSEU1d0FZb3pSTTNX?=
 =?utf-8?B?OHF6NHFodFNKSDE3dUhmSDZIV0JnZDFiNTJSeWM2MWRlVGl2alQvM3V3bjBP?=
 =?utf-8?B?SlVjTzkwYXZaYS84VHBuV2JxeVFZV2tJeVB1QUtlRWgwS1BURUFFNEd0ZDlP?=
 =?utf-8?B?ZUNIcFRvZEd0NGNJUFBRYTFKeTUvN3ZnQWJZdmp1WmNZYi8rVWg1WkhKeW5W?=
 =?utf-8?B?bmZBZEpkYWtxTDZoWkdtOUJTRFpwQlJkVWRPM3NyT3RpQUh1MlFGYUtuc1hI?=
 =?utf-8?B?bnVCY3lnRitydGdkLzMwNWRSa3p2dlh1N2tRVHluaU9BRTE5R3ZERTl6VVNm?=
 =?utf-8?B?azNHaUtQbHcxUXdscWg2TzNjb2RCZ0taK2t1bDNNaU9Sbkh5KzhoSlFDQ2ZG?=
 =?utf-8?B?ZGFUaVR0SXN2eEp0UWUzUTlzMC9RdWhIRVppVXdPSGE3ZHlpelV1L2ZoT3Q3?=
 =?utf-8?Q?nzk44u6JGXTvnvv0V+0W6Cei2j+FYcxPdkyKQ9YWOGPC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6abffc3-f886-4a82-59f2-08db085e10a0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 16:20:30.3824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWgNRCQUxSnotRDSlzPwZFVec45lwa2IsQjsDj4K28+cqjlC+8dZvqi28xnA01HM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> To consolidate it with vram handling.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <shashank.sharma@amd.com>

I can't check all the implementation details, but from a mile high view 
that looks correct.

Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 96 ++--------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 64 +++++++++++++++
>   2 files changed, 71 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b07b7679bf9f..7c21ffe63ebc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1016,82 +1016,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *adev)
>   	return pci_reset_function(adev->pdev);
>   }
>   
> -/*
> - * GPU doorbell aperture helpers function.
> - */
> -/**
> - * amdgpu_device_doorbell_init - Init doorbell driver information.
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Init doorbell driver information (CIK)
> - * Returns 0 on success, error on failure.
> - */
> -static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
> -{
> -
> -	/* No doorbell on SI hardware generation */
> -	if (adev->asic_type < CHIP_BONAIRE) {
> -		adev->gmc.doorbell_aper_base = 0;
> -		adev->gmc.doorbell_aper_size = 0;
> -		adev->doorbell.num_doorbells = 0;
> -		adev->mman.doorbell_aper_base_kaddr = NULL;
> -		return 0;
> -	}
> -
> -	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> -		return -EINVAL;
> -
> -	amdgpu_asic_init_doorbell_index(adev);
> -
> -	/* doorbell bar mapping */
> -	adev->gmc.doorbell_aper_base = pci_resource_start(adev->pdev, 2);
> -	adev->gmc.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
> -
> -	if (adev->enable_mes) {
> -		adev->doorbell.num_doorbells =
> -			adev->gmc.doorbell_aper_size / sizeof(u32);
> -	} else {
> -		adev->doorbell.num_doorbells =
> -			min_t(u32, adev->gmc.doorbell_aper_size / sizeof(u32),
> -			      adev->doorbell_index.max_assignment+1);
> -		if (adev->doorbell.num_doorbells == 0)
> -			return -EINVAL;
> -
> -		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
> -		 * paging queue doorbell use the second page. The
> -		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
> -		 * doorbells are in the first page. So with paging queue enabled,
> -		 * the max num_doorbells should + 1 page (0x400 in dword)
> -		 */
> -		if (adev->asic_type >= CHIP_VEGA10)
> -			adev->doorbell.num_doorbells += 0x400;
> -	}
> -
> -	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->gmc.doorbell_aper_base,
> -						      adev->doorbell.num_doorbells *
> -						      sizeof(u32));
> -	if (adev->mman.doorbell_aper_base_kaddr == NULL)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
> -/**
> - * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Tear down doorbell driver information (CIK)
> - */
> -static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
> -{
> -	iounmap(adev->mman.doorbell_aper_base_kaddr);
> -	adev->mman.doorbell_aper_base_kaddr = NULL;
> -}
> -
> -
> -
>   /*
>    * amdgpu_device_wb_*()
>    * Writeback is the method by which the GPU updates special pages in memory
> @@ -1239,7 +1163,6 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   			      cmd & ~PCI_COMMAND_MEMORY);
>   
>   	/* Free the VRAM and doorbell BAR, we most likely need to move both. */
> -	amdgpu_device_doorbell_fini(adev);
>   	if (adev->asic_type >= CHIP_BONAIRE)
>   		pci_release_resource(adev->pdev, 2);
>   
> @@ -1253,11 +1176,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   
>   	pci_assign_unassigned_bus_resources(adev->pdev->bus);
>   
> -	/* When the doorbell or fb BAR isn't available we have no chance of
> -	 * using the device.
> -	 */
> -	r = amdgpu_device_doorbell_init(adev);
> -	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
> +	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> +		return -ENODEV;
> +
> +	if (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET)
>   		return -ENODEV;
>   
>   	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> @@ -3711,9 +3633,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if (!adev->have_atomics_support)
>   		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
>   
> -	/* doorbell bar mapping and doorbell index init*/
> -	amdgpu_device_doorbell_init(adev);
> -
>   	if (amdgpu_emu_mode == 1) {
>   		/* post the asic on emulation mode */
>   		emu_soc_asic_init(adev);
> @@ -3941,14 +3860,14 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>   	/* Clear all CPU mappings pointing to this device */
>   	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>   
> -	/* Unmap all mapped bars - Doorbell, registers and VRAM */
> -	amdgpu_device_doorbell_fini(adev);
> -
>   	iounmap(adev->rmmio);
>   	adev->rmmio = NULL;
>   	if (adev->mman.vram_aper_base_kaddr)
>   		iounmap(adev->mman.vram_aper_base_kaddr);
>   	adev->mman.vram_aper_base_kaddr = NULL;
> +	if (adev->mman.doorbell_aper_base_kaddr)
> +		iounmap(adev->mman.doorbell_aper_base_kaddr);
> +	adev->mman.doorbell_aper_base_kaddr = NULL;
>   
>   	/* Memory manager related */
>   	if (!adev->gmc.xgmi.connected_to_cpu) {
> @@ -4051,7 +3970,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   
>   		iounmap(adev->rmmio);
>   		adev->rmmio = NULL;
> -		amdgpu_device_doorbell_fini(adev);
>   		drm_dev_exit(idx);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index bb2230d14ea6..983826ae7509 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1705,6 +1705,63 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +/*
> + * GPU doorbell aperture helpers function.
> + */
> +/**
> + * amdgpu_ttm_doorbell_init - Init doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Init doorbell driver information (CIK)
> + * Returns 0 on success, error on failure.
> + */
> +static int amdgpu_ttm_doorbell_init(struct amdgpu_device *adev)
> +{
> +
> +	/* No doorbell on SI hardware generation */
> +	if (adev->asic_type < CHIP_BONAIRE) {
> +		adev->gmc.doorbell_aper_base = 0;
> +		adev->gmc.doorbell_aper_size = 0;
> +		adev->doorbell.num_doorbells = 0;
> +		adev->mman.doorbell_aper_base_kaddr = NULL;
> +		return 0;
> +	}
> +
> +	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> +		return -EINVAL;
> +
> +	amdgpu_asic_init_doorbell_index(adev);
> +
> +	/* doorbell bar mapping */
> +	adev->gmc.doorbell_aper_base = pci_resource_start(adev->pdev, 2);
> +	adev->gmc.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
> +	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->gmc.doorbell_aper_base,
> +                                                    adev->gmc.doorbell_aper_size);
> +
> +	if (adev->enable_mes) {
> +		adev->doorbell.num_doorbells =
> +			adev->gmc.doorbell_aper_size / sizeof(u32);
> +	} else {
> +		adev->doorbell.num_doorbells =
> +			min_t(u32, adev->gmc.doorbell_aper_size / sizeof(u32),
> +			      adev->doorbell_index.max_assignment+1);
> +		if (adev->doorbell.num_doorbells == 0)
> +			return -EINVAL;
> +
> +		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
> +		 * paging queue doorbell use the second page. The
> +		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
> +		 * doorbells are in the first page. So with paging queue enabled,
> +		 * the max num_doorbells should + 1 page (0x400 in dword)
> +		 */
> +		if (adev->asic_type >= CHIP_VEGA10)
> +			adev->doorbell.num_doorbells += 0x400;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>    * gtt/vram related fields.
> @@ -1761,6 +1818,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   				adev->gmc.visible_vram_size);
>   #endif
>   
> +	r = amdgpu_ttm_doorbell_init(adev);
> +	if (r)
> +		return r;
> +
>   	/*
>   	 *The reserved vram for firmware must be pinned to the specified
>   	 *place on the VRAM, so reserve it early.
> @@ -1907,6 +1968,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   		if (adev->mman.vram_aper_base_kaddr)
>   			iounmap(adev->mman.vram_aper_base_kaddr);
>   		adev->mman.vram_aper_base_kaddr = NULL;
> +		if (adev->mman.doorbell_aper_base_kaddr)
> +			iounmap(adev->mman.doorbell_aper_base_kaddr);
> +		adev->mman.doorbell_aper_base_kaddr = NULL;
>   
>   		drm_dev_exit(idx);
>   	}

