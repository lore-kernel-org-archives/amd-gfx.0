Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A97C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 21:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8098A6E3C6;
	Mon, 29 Nov 2021 21:47:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0C76E3C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 21:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3uiGR62LBHqzabUi+JHYwGRN8tf0OJIrwaBF4zT8vdoYu/Y++HIlAWkcyp3RWGHUO2CY7xsDqu57Ufj/40hihXg5Ojjb6sEl1WA7SbCpH/yOZ2aL3Pvr5x+xyzqRhSJFXmIuV/Kbhe+ZXjzE6ar7z8FAw/be1s/y2euupYZh3Iyo5wEg1VboBnLqENil6iRIuCjI9iLgCS5bQae4CL8mE0wWW98GqZJ5SUCDA4HsRhNSuOhkRU4spzMUEzXNbzwSmnZMeMpErYyOvmLL0KVI1FE7GqXvDo2OE9y2EaXhCgEKBhHj78cfIUuNK/HMtNjNrPckQqxpI4jyWxjYvSHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1jy4RdBwJJsr8OBEzUmVRySe8JuIt5wiIQCXbV9eWo=;
 b=oZNRWdl3vC/FuH2UPdkVaGvpp5nvSoLOwxQ/JaUS2iFXH9E7K7G/16w/xwdWVAysaDz6RHxOrz/B172wuGE2pI0GMb9lu4m3EgZdY+stujdlfIDLdD/X82GK5ZXhwQYEGYZ3mirrPQLoJddUrHh4eJEoiainp+FoP9hxKmwOYq+h5LFxs0O6gQNiBsSQUzIkiTvuJll9xmpOfR2AoKJPKQjbPI7FJc8+UUzHHW/xliLwAeoGfewXuzvQWi6QV2R5CeiY9anabxxTQ5CC8FkBUTWMAKV+lid7Z1PN7thELyB8tUFUO8tHbBMFkTuFRFbuenFasZIJ1DfXaB9x9SQY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1jy4RdBwJJsr8OBEzUmVRySe8JuIt5wiIQCXbV9eWo=;
 b=VI6nf2hNOviuAmBSuSLor0OQGjltSxtYf3Mif1x4Sh7LZ+qn1QgjWCMu/HDvorUyjMRdyc4oupEngHH75SU0H7iTCeKO4sBEjhayzjRwRglLGDSQoyQvSTPikl3i8gWrziXni1+S4ayKlL1P54+ohM1Esjl3eCxaEk6mhCsNUsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 21:47:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 21:47:46 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: err_pin_bo path leaks kfd_bo_list
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211129212328.19049-1-Philip.Yang@amd.com>
 <20211129212328.19049-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1730002d-8fda-c7f9-1eb9-d647bc375516@amd.com>
Date: Mon, 29 Nov 2021 16:47:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211129212328.19049-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 21:47:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a16f340-b982-4f94-f03e-08d9b381e151
X-MS-TrafficTypeDiagnostic: BN9PR12MB5339:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5339C5C45CFBE32D76B3111792669@BN9PR12MB5339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeTwd7w3Ipdy84+sVHH51AFjBSuu4anQbVe39ymn3vK4aDM8C+sJBq8nN0fePrfKlWUNd3Ek9es4Ar71sW5xOiTriq4a8+4H/WZPQmYXqc9Zs7gOOJNpH3s+jmIyyVpcGln5Br1HfuTXQbg7hfhGZdIz7pFS1FiSR2uE/nLlGTQrmuwf3vIQmWNcS748FImFF6z2o9sNPxNdvJCfiLKcuFaDCjjGUXBkL1ahDP9QyplywBvd+pnI/ZsDGHx29XPzR1I9whYKWPBNZ0ZpHZLz16h/WHaLx4my7GEFvlbTtMCbp/XXjxPlOXJdKLbhSFK4GeLVv2ebo4/R8pPi6AK1GjfSvXahGhmZ+KXXvyspHqDRYNalFxxtDbSrUXFJ2TlwUL7hp+55yDKeQ3m3TalbgAJkm7Q3wvSC0a7ytS2QCgci2Lfynx0DedmUgD4XNWmNvbRQ/XzPpayPXkADlMeSD+E+p3S3GEGa//1YqWlHEPHVQI/5SIPL6E0OI20WmhJm8FNm9Hhz2gKVsKO+sAf8O+PvcaU+XcRvP1sjiCK+5ZvEsMtvkr2r9UHrF3x+xPr53ja2xm/kOmwqucM+RDlkErzzZIZLiSDG2YVDJJ4j49m9rfC6maZ4psV4XyUJgeSIo8onuoZwTjhKlIiH67ZxP2tVAG145UZRCMzkY4nsE8p2E6cQ/Ri1E0oRhvZZlsdwjU3eJIDXiUfuM0XyJNvQSISPbu9MZz37oX2uNQbleDs6AVTNx+j5Qmajk6H6hbve
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(66556008)(66946007)(66476007)(16576012)(8676002)(956004)(186003)(8936002)(86362001)(31686004)(31696002)(44832011)(26005)(6486002)(5660300002)(2616005)(36756003)(4001150100001)(38100700002)(316002)(2906002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2FWNTltK3BXOVdUdllxbXpuMXR1S3lBb3Y4Mjd0MXNzb1dIeWxnVWVITUN6?=
 =?utf-8?B?V1FyR3RyS0NIUHpodWNFRkNiMHdXei9uQ01hY0RzTDNkd1JUUUltUk1qVDQ3?=
 =?utf-8?B?cmV4eEdKTWF2U3piaGI4dnA2ckdZenEvZGtUR29qeHlqRi9DeHFUYnFXajJ1?=
 =?utf-8?B?UUNWU0JadjM1UGdwRThFdGhCRlA1a0xtMWVyOWxDQ01EdUQ5MG4xSUhQYmdv?=
 =?utf-8?B?K1I2K1VwbTVuNHNrSURYQVFCcWxYZmFOUUJtVVc5cGhwd1BpenRNSlJjb3Nr?=
 =?utf-8?B?cS90QmczT01iVzh1NkdnSGlyeXI5bEhQWklPL1VITFlqajFKektabkYyc2dk?=
 =?utf-8?B?d0pwM1YvSFJyd3drTXJpRzR5UVJ6d3V2VEdnSnp4VmhOSXRGZisya1dCYkNL?=
 =?utf-8?B?aWx2c0dMVk5qN0N4Q1EzbVIycUUyVEZPWDZGT0NjK0xlcit2QUl4SUVLTUpS?=
 =?utf-8?B?b2pNNzlsU2oxTElQR09wc1NGc1hVRVNBc2hIb1F3TnVpc05PODBlWDhLQjBm?=
 =?utf-8?B?ait3Y1puUjdCakZIandiam95Y0RCdFg3NGhYSXpvYlhlV1pPVEswNjU2aTVD?=
 =?utf-8?B?VjNHNXlaQUh6d0dBdWF0Y3M2UTRvZmN0enA5MXhsaFlTZDdJV3g0STcrSDZ5?=
 =?utf-8?B?VW1XSFp3ZW8ycUNFVy9DSnZSSlg2cTN5TlcwWjJ6aG5jdXlWTkhGdExWVk5M?=
 =?utf-8?B?ZWpHYjdwakQvSGdIS1BRRUd4ODgvSkRmaDh0Ym8wS2Y3Z0lGRHJpTHI4SDJh?=
 =?utf-8?B?R0piYnc4TDNZZjhiMmlLZFNKQUE2cmkrQmxrMHNPOUlTbFlTSGR4RjljNndU?=
 =?utf-8?B?WXRBT1ZEV29oYmxtc2RhR1VVbjc2cHJvOTB4MWpwV1pPaFdSeTlaV0o4MEVP?=
 =?utf-8?B?eXk3M2kySWdXOGF5TndZNGpkZ2JqM2NTWjU2OFBuSjZIaTNCcHdRUi90Smh6?=
 =?utf-8?B?WGlsajh3Z2dRd09vRGRnK211SEkzMlFBY0FLRkhKbFBISTBreFhQSjFwVHNP?=
 =?utf-8?B?djRvWW9LRXk2RUJrTVJyMXNCRjF1UDkwVVJLZVA3WXhqMTVKaktuNWdWVlk5?=
 =?utf-8?B?Q0crMFExVU93SVk0bW9zcmVMOUVPRlN1YzBSbVcvQWl3aTNwZ1BXd0NDTC9L?=
 =?utf-8?B?blBzV2FveVI1ellXRnQzMCtwdmd1SUZ5WFliUHFiczczUWlHV00zVGxYYmd4?=
 =?utf-8?B?b0JucisvMWs0NkFxampDcjdZZlQwUU1uWWJVOUVQbFluVGUyVlZMejk5WXVk?=
 =?utf-8?B?UC8rbzg5MlBWMEI4c1pWaUE4Q2RiMmFnWTZWc2paRUM0WXVlVGN4cGpkQ0Fh?=
 =?utf-8?B?RXFWQzMxNWFhYmNhd01COUQ0R2V0VEwrT3U2cmFWa3d5ZkliMnBTNnMwVGI3?=
 =?utf-8?B?OHRWWEhVV0NTYXRhWkpyeHM4eXNWbDhGWlI4ZkM1elhhSitMSkxJMjgzU3R5?=
 =?utf-8?B?Tld3TGVBaHVoWkZEb0RvZTVHQ2k1Y0NwYUV6dXZZNW5xaHJtWXdUQWFLeXo2?=
 =?utf-8?B?SjRxcitRUW1DRVRhVU5RTXpOb1daT3dSbXFYckZ6alZ2VEQ1N05kVzlGWEov?=
 =?utf-8?B?MytmK2d2QkRvb1FZWFlCMmlubThZVFczMVBXU2xocHdjaU83dkpKdnRsVDRG?=
 =?utf-8?B?UjJ5ZUgvQmJ3Zlp3M0RnSm1CZTY5M1oxVUFUc0xMYmJBS2NKTUMwNTU3eEQw?=
 =?utf-8?B?SGZsWU5yeUxFdUVudUhVem1nbGxsTVBxRU1HT0t0b0l5M2VRL3pVLzQ4dmVz?=
 =?utf-8?B?MEd3TmpwelNmWFBBZVRtNVJDcEV1NDR6ZDFjb1o2TzZ3ejRnNkNtemw5UE9T?=
 =?utf-8?B?Rnp5UTJYU09ndkZza2FDOHBhK09DZWF1a1ExOGI3OW41T1ZLUUhVR3YyemlN?=
 =?utf-8?B?ditQbnBhZUQxVSt4WnFKRGJtbVhWTWdaaEQ2MXh1QVkxektrTVZJNnJ3ZVYv?=
 =?utf-8?B?WHFaeVczZkxQZkZMTGtyRDNuaEZCUHBYcE1nT2hKRVAxeVllbktURnJ1eE1n?=
 =?utf-8?B?ejc0TkJZLzlld1hrQ3N0a2tXc2QrRUFhS2hTVWJET1JkSTdYZFVpZzlmYWJR?=
 =?utf-8?B?TmVjRmZtN2xqUTloUW83R3lQUnVXRWp0K3ZEN3lIWlY1ZFFJSExndzlGKzNI?=
 =?utf-8?B?VWtydGpJeWJzMzVGYkpxQno0RTZCa0lDRmJhU1ZYNFAxR01iQTZ6OG92Q3NO?=
 =?utf-8?Q?m3c1msBKJZRlz8fIoXEnDUY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a16f340-b982-4f94-f03e-08d9b381e151
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 21:47:46.2968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqnpUQ60LWud7NfuUj0i4Xvaaoei+1uP7Nb3tnqPxW0c+BilQngDt57gtegwHKMdl1m/00My2ty5nDhvqM4sXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
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

Am 2021-11-29 um 4:23 p.m. schrieb Philip Yang:
> Refactor userptr and pin_bo path to make it less confusing, move
> err_pin_bo label up to remove mem from process_info kfd_bo_list.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5df89a295177..b8490789eef4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1559,13 +1559,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  		ret = init_user_pages(*mem, user_addr);
>  		if (ret)
>  			goto allocate_init_user_pages_failed;
> -	}
> -
> -	if (offset)
> -		*offset = amdgpu_bo_mmap_offset(bo);
> -
> -	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> -			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +	} else  if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>  		ret = amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
>  		if (ret) {
>  			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
> @@ -1575,11 +1570,14 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
>  	}
>  
> +	if (offset)
> +		*offset = amdgpu_bo_mmap_offset(bo);
> +
>  	return 0;
>  
>  allocate_init_user_pages_failed:
> -	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
>  err_pin_bo:
> +	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
>  	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>  err_node_allow:
>  	/* Don't unreserve system mem limit twice */
