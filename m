Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F32C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 21:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F12D61130
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 21:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F12D61130
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662216EEA8;
	Wed,  6 Oct 2021 21:36:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1796EEA7
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 21:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqwMkR2WTjy0IIPuYn4rrcVsOeN7KxdXU++t6AY/4QqHsRlUPckE4503xypiE8jPS/rh3TzNOYrVN6NV7hxwAMs764xzoQ+1AAQG6XoZ3Dds1JnNcfjE860vJCMJXx2fCSeb7FLiKWVGkVMSi/CSCtX/oXG+mDTjS9yDXhDsd7PMkxJxHm4v/4N9lUis1dYwWrwVNlP8ApNNa9WhoWSQ/LOy9RKy6KMRZi0wyrqikDKzUdRYhYHhy07hf6wTqTcxs8J8kOUmF9ZR0t9wMvYxxTjFywFai9amCY+AJE9+f4sge1xKKzc2LWmd1yWv1ATcKIuYp3NTypaArhuhcxoVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX/bJ/M+WI59G/0LmsHhqbHg0etfuCzz/nAmtZHXwyk=;
 b=Qrsb6XrsJ0KnsqYG8THzYVAdt0BlKGWXbNcDLDEIiPkdbQqOcvgEM3vHTTdLT0AtfJ597NkY+ohJ3+9U5hG/zOMUWS4BWfMXz/A7MqUB5eJCO8vxXyDaR3/gvvjox51S7zcpeue6toKaBN+U05UFzKvmgGlYttNC0wJSfMaLTKF48YCMuOfrzoCCVVeeIKfcZ89UcP9xmBKnn6iRuvwSTPIzb+x6oo6aqV0bNqv5LVPlwLLVK0D5C8iaFlUxy2/Bw0fplFni7EGDybVe+34eWDsJnmzbqagaokOJC2jf1i2ngUV60i7bkz0bTvvlOso+FtNsY3pyHjZ31TY+MbcXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX/bJ/M+WI59G/0LmsHhqbHg0etfuCzz/nAmtZHXwyk=;
 b=CQb/GOwlaXgOkPtMHvTmqCl7/HrMywXjKeFSyce720NfihP9oETOvH2Q/91K+YHyuBdCDzvCvHUf1uIGVDPhBXYbcPb2GwPH7tkfaC+Ab4ymDRa5PPNmBf2D7/d58vdJ1s8BPPgrwHNDy5DtDfv5Ltdv7i41i5ziboFTcsnz77I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 21:36:54 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2%2]) with mapi id 15.20.4566.023; Wed, 6 Oct 2021
 21:36:54 +0000
Subject: Re: [PATCH 2/4] drm/amdkfd: handle partial migration cpages 0
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211006143210.4954-1-Philip.Yang@amd.com>
 <20211006143210.4954-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b080e4ac-7b95-bb16-6989-85085b05335e@amd.com>
Date: Wed, 6 Oct 2021 17:36:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211006143210.4954-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::30) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.17 via Frontend Transport; Wed, 6 Oct 2021 21:36:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e826fca3-bd1c-458d-e149-08d989116a4d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB249117A20E1CA993F14EB59692B09@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G52tsL3dh7iliJj4WK6yMMjzvgIzFtJtIs+Cn3S+3ZLnom9EjsFbfrAe6hT+rEZp1bLzBMHO4gHeT+TInjI5ey1lgyUtLvoZFDv+CV0yiKDLKM1kadlpqXyRFTtw7o53o1dg2wQZ8GFD18WDL0d2deMbQzf4ntRF3aCeVLSdEDx9bClDo/4w4a7m5M4OlljICN38Y00BcAeaqwvFN5AgsnRXgp73pwgS5i33f9my1QHASqKjvohv8KF6njlyzuhWaTATAoo8IoK4G2zWmiQNhsapjYTQe8rfauQ5VL1RcNzUGc6V4IFBPZnfz7nv+i1bR3BDwkOJhKy0Yh/JStGyW9hGil8CdLRoRibeBr66hul7TlJHmRB7cvMQ5AUgYBoDYF2hf8E8JtDUKZLTjPks9p1MA4akecPLImM9hCvpsgGZDa56L4mveFvTRFd9AYalHc2wjcpC2jtku/6sA7+7QfgjOOyzNVZxpuzvmepJhQtMAsmuHuWHfTrw695Z7fHRT51T1q92H71uZHVfz/SZwbv3IqD1ZYtEee1z4VlhjLzj7FXc/JhiV7WD43CbDoYFeai3K/1nCZMJXYP7db32VbWcQ3WGhe/ta6INJ+acEP/M4lCEW7CcORgOJ1p4/gnyD1NWoGW6+kI9JsbxOA//olUR+i4KRi/Mganv38U1BsPct0suUQvNkGcJqkf/oXtEUHzNXgtvNpRe7+LU+6rAb10M4+oJwbOc4NFqTLKHjEQ+7S3orBL9h50HzzKDyK+x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(5660300002)(8676002)(508600001)(2906002)(2616005)(956004)(316002)(16576012)(8936002)(66556008)(66946007)(186003)(83380400001)(38100700002)(36756003)(31696002)(6486002)(86362001)(31686004)(26005)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1FyM0ZKc0NobndhK0ZUZWtHTmNtWC9SSWtGbDVBelhNWEFUcVd4OERnTENZ?=
 =?utf-8?B?Rzd3V0VUazVyaVJnU3ROTHB4d2VQMGEyT1ArcGJVdFRvVEZjdTArVC8zQmth?=
 =?utf-8?B?L0pBVFNUMVZnOWc4NG9TOTdIRkRpWWpycUExSDdYUDBuZW4ycWQ2NHVoOEdU?=
 =?utf-8?B?OW9SbWFMSG11TDg4MmsxVldBc2xIclRiVlYrcXRsMmw4b0kwd21kMks5R3Ax?=
 =?utf-8?B?YzE4ZHp4MGRPamZOTzVNZ21EcmUrZ3NzMWNrUjR4TUJwSUlpdzV6ZXZDcjZS?=
 =?utf-8?B?VTNuUWgvYThKOXVvcFlSQkVQaE5VWWZhbEhVUWducXBvL1ZvZkVweTdRVDhC?=
 =?utf-8?B?eDZSSEZNUUtEd3hPV1RZcmhBL1R4RllUcUJqNDFUK2hzSmtLU2tFb1ExODVw?=
 =?utf-8?B?VG4rc3ZGV2NPaE90eExwbE1GM1o2VUk4ZmQ4TlNJUEFKUStpSVFhL29uUDdK?=
 =?utf-8?B?eG5aTDNhQXV5ZnArbkY4UzZ4MjFVMms0Vmp5V3pYNUxkR0pnalhUSWFmOHdH?=
 =?utf-8?B?OW9SNm1oN0NaUHZRbzdpTzFqVDYvSGdRMXRpZ0hMOXZYN1hIZm5wdlRKUytR?=
 =?utf-8?B?UFA2NXp5Y3QydGRBNzlkenlyQnFaL2JFOTdpaVlvSmowMkNSMzRzb0FuazYv?=
 =?utf-8?B?amNDWExWaVQwY1U4RXo0OFBqV3pZRFJJT21KSnlrQS9sMDFnaDZmSU5SZHlk?=
 =?utf-8?B?cVp2aTA3NWc1ZkMyUGxOaXBDYk1RVGtCbUtUR3gvTjRmdEF4bmZuRVQwOGlY?=
 =?utf-8?B?UlYwNTIvd0E3R1BicDFMcW0vM1FwSlJkT0VyWm1GKzg3dnNXMm4xTllCRUFS?=
 =?utf-8?B?U1ZHb2JSeVI1VGJVckRJckE0NndtNWd0MzZUVXFLWVY2RThNTUZFU1RXMjJv?=
 =?utf-8?B?K3RRQldwa2xLR01zOHZNZ3lpMDR4YlgvK1NmWlllMDJXN0MreUpJQnd1Mmo4?=
 =?utf-8?B?R2c1V3diQTE2Z3BrZGk1cUYxV3o1cEN4ZFp6dnl2UUM4emhyOTJuQzZyRkhJ?=
 =?utf-8?B?OTQ0THRodDN0eFgrbmV0ZThSU095TEpLYUJIbzJIdlFvaGhvNjh1WUhhYjI4?=
 =?utf-8?B?QVVDaE1TR2RtOTRBWVAzdTdnaE44NlFIdnJTOWdTK01CUFNWa3pmWnVjL0NK?=
 =?utf-8?B?TloxU0tXbU8yZEdwMlhmMnNNNFF2ZHk4d05KQnNqTmJBeVBVOUpuZDJucS9x?=
 =?utf-8?B?QWF3SkU4aHNPNGVUMEowYUhiZ2xxNVFZT29EL1QraE55b1ZBYm4zbTU1a1d1?=
 =?utf-8?B?OFFzbGNkZ0tPQUxJL0dJM1FnUnQxVDB6NjdMYWUrM1haQnBIWndRTDdJOEVG?=
 =?utf-8?B?eUJmaFNFSW5CU1dLWlA5YVdwNWRsLzFweHhMYlZMT0ZyR3ZlcVNnUjE5Q2t2?=
 =?utf-8?B?cEVDTW11bDQxRTF6ZHZoQThrMytiN3M0ZTF0YnRmdCtpNVZ5K0IxOEhvN25N?=
 =?utf-8?B?RGlGekRzWCtPUzk3eUU5QTZUZjVBY3VCUHhBem5qVlpldmR0N01CSXJFYzFj?=
 =?utf-8?B?eEVQRTNpWkQ3VW1UcW9Da0wvWTBDeldKM3l2NjBFdTF3TjJ3bmVBcjRuaE1j?=
 =?utf-8?B?bi9hNFJFM1hOS24zUS9lQTA0YVo1dVFnamYvUUphbnZmY2pZMkl2UHZTWnc2?=
 =?utf-8?B?YStxMHNzL0F4YmxraHJ0YUlRVTRoRm5iclF3RkVIb2hmSEd5Y2JpRzFRdHVD?=
 =?utf-8?B?WGJ0NmgwTWlja2lENmVGcko5Y0g5TkozZityL2doNGluNkJJQVJXVExYZExv?=
 =?utf-8?B?MU9NMnpsNUFrUVpmOXlmT1ZKVmdmL1JYSjJ4U2I3dlVGaTFoUzR6c0NMYXBK?=
 =?utf-8?B?ZnRsK29vR2s4Mmx4allIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e826fca3-bd1c-458d-e149-08d989116a4d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 21:36:54.2423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3IhpIMHm+8nd16QXgm5xi17kYkPWupFaf6V5fjlb5y9xae4h4ekk63zMpYAufMdZVEIteOnBg6hVjR5s9x3FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
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

Am 2021-10-06 um 10:32 a.m. schrieb Philip Yang:
> migrate_vma_setup may return cpages 0, means 0 page can be migrated,
> treat this as error case to skip the rest of migration steps, and don't
> change prange actual loc, to avoid warning message "VRAM BO missing
> during validation".
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 48 ++++++++++++++----------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 069422337cf7..9b68e3e8f2a1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -409,20 +409,25 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  			r, prange->svms, prange->start, prange->last);
>  		goto out_free;
>  	}
> -	if (migrate.cpages != npages) {
> -		pr_debug("Partial migration. 0x%lx/0x%llx pages can be migrated\n",
> -			 migrate.cpages,
> -			 npages);
> -	}
>  
> -	if (migrate.cpages) {
> -		r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
> -					     scratch);
> -		migrate_vma_pages(&migrate);
> -		svm_migrate_copy_done(adev, mfence);
> -		migrate_vma_finalize(&migrate);
> +	if (migrate.cpages != npages)
> +		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
> +			 migrate.cpages, npages);
> +	else
> +		pr_debug("0x%lx pages migrated\n", migrate.cpages);
> +
> +	if (!migrate.cpages) {
> +		pr_debug("failed collect migrate sys pages [0x%lx 0x%lx]\n",
> +			 prange->start, prange->last);
> +		r = -ENOMEM;

I think just returning an error here is incorrect. This error gets
handled in svm_migrate_ram_to_vram and prevents the following VMAs from
migrating as well (if the range spans multiple VMAs).

Maybe return the number of pages migrated, if successful. Then the
caller can add up all the successful migrations and update
prange->actual_loc only if the total is > 0.

Regards,
  Felix


> +		goto out_free;
>  	}
>  
> +	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
> +	migrate_vma_pages(&migrate);
> +	svm_migrate_copy_done(adev, mfence);
> +	migrate_vma_finalize(&migrate);
> +
>  	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
>  	svm_range_free_dma_mappings(prange);
>  
> @@ -636,19 +641,24 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  		goto out_free;
>  	}
>  
> -	pr_debug("cpages %ld\n", migrate.cpages);
> +	if (migrate.cpages != npages)
> +		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
> +			 migrate.cpages, npages);
> +	else
> +		pr_debug("0x%lx pages migrated\n", migrate.cpages);
>  
> -	if (migrate.cpages) {
> -		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> -					    scratch, npages);
> -		migrate_vma_pages(&migrate);
> -		svm_migrate_copy_done(adev, mfence);
> -		migrate_vma_finalize(&migrate);
> -	} else {
> +	if (!migrate.cpages) {
>  		pr_debug("failed collect migrate device pages [0x%lx 0x%lx]\n",
>  			 prange->start, prange->last);
> +		r = -ENOMEM;
> +		goto out_free;
>  	}
>  
> +	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> +				    scratch, npages);
> +	migrate_vma_pages(&migrate);
> +	svm_migrate_copy_done(adev, mfence);
> +	migrate_vma_finalize(&migrate);
>  	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
>  
>  out_free:
