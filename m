Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A747C3DA66
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 08:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9388110E626;
	Fri, 25 Aug 2023 08:08:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D624610E626
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 08:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqZG0hrGS+DgDhU4pNAtIwedP/kBtuhKyLwXI9t4b809j9cIa1+yLuBGzTbzfAgkgEsO7RicV+FlbbrXOvXpIprwJMcDuhf+5jPI6H4vNgPMua38FbGU1JJVfK4clTqAPSEMJaTQUYu8lufE+w+oAYdOgYJEFbBgLa7jnI6uLwUmUDIW3a0bXfPp6nUQa2LAjMOXEaWZKEk39i2jfn4PLNFcqfhj7pMOdRcIlHZmRA1upRcI+VW72se+9tKJlJPrd9xSb1tCmppUop58/fPu2thfJinWkWjp/LArSx6H8IVYLFe50LEkpMm4Lnozkd6jli4FSzD7pszxFInJX1l3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLZPybRcgGBpH++yr2OUoJYAxWV4tdaWDd7kGGJ7jLs=;
 b=b4oOV1gYjh2ggDQlgkdM5uUn8Ae2ZhYrB9CHWdCE2DrkwGkC6jxbS8wQgcOfqgCWGgPyRsOvQ2pjcY5w6wcdAfu44EirgAbqY87pCGgzevxjjxgz7Mk86PIiE9z/LROiR353B2UY6NJHvNJH2N/74FItHqppeDwgHltI199Xyme8d7/2PHwhz6zTOKTMaGlieT7cpNxvd40ey86PH7BJhD2X29Fw+V5v4wcX6/6OTqaCB9b/bOdvEIH+iOlES7lv/OS1yzFrLA8KiBueR+Qu52bbFii81FXGAcObOAK30Yc1c63bRkM2z3qDsVumeJe7KHBOnH+by9VRUGtg2H8jbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLZPybRcgGBpH++yr2OUoJYAxWV4tdaWDd7kGGJ7jLs=;
 b=UnoERqgX4OeRVnqO8HkwcxSpRwLWoTsuj3JYEJECJwRGqDWRHBvZ6gw2JXo+TQTvCYZyp2lnwkC/uA9EDu/PGVNTihG73JpOvsoYrX6nu05r9xCNiQmuFvjVFY3GIL4X5Ijfpn5ow+v/NszPj2SmCiPTpwqLf2yYfTSsrFHr0es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.29; Fri, 25 Aug 2023 08:08:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 08:08:47 +0000
Message-ID: <1c44f172-99b4-3981-a646-48d2b18ba149@amd.com>
Date: Fri, 25 Aug 2023 10:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amd: Simplify the size check funciton
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20230825052204.1315534-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230825052204.1315534-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: f40f5b7f-c781-4091-f59c-08dba54281d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSBwBBRBWFAIHb8C9htAo/aKBFOS9FsYahC5yzgApc+fd9HdD+JFPsnLlb9GEr6GCoRd/ojJv5Ah/ueXGumhMQZjqxS1M7vk+O0CZx5HK5u+VnGNg5yxKKSGVsR1AlLsRYZveGETTgXTc4Ku9XDzdfMM6mkxI3KgXia1BToo3QvBG1NYZsta0ZZkwtIFrR/IYxEoKnOxhvRppeoffDUFjn9qXJNwn31s8lw9Ey/EzuMi6tU1L4uaHAHfW2pULFBBkryJoXRZ6M+jMbeHolkt3bnpRYNbpZ3XK2PvGo2/s5ZBJaSI0DUn6THEoXl4MZtFrgPMF72Tm+/2MIqFN/llNOVPivImjN8qd0XFNryaSQCWBNLf2SDKBy14CLF7JxCEYE0LiyLqBW0b9WF7tgJvvhNPQZlaKtvt9Qavn7jqKEuzakPj49cotJjYBwj5B0g9FlEz2KuDCIf3X8GhYXdfFsYUc3qhqdclGK7tsy0Sny8lyet9szPBOKSrTHM8UPNQiu+X0jXlRJgbI9V22cf14hvK7PEIPKxQnReCelJMIbDXbLIXaqfIAm5+vpWJKJb000ShhrRFByswYrwG9V3HgoiJYQp8SyBMQ5waLwacSdGwVY9viJ8Ir0dzr1zqi12j9/T8mmod0CXmy7/URyh2LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(83380400001)(6512007)(26005)(478600001)(2616005)(5660300002)(31686004)(2906002)(8936002)(4326008)(8676002)(38100700002)(6636002)(66476007)(66556008)(66946007)(86362001)(41300700001)(31696002)(6506007)(6486002)(36756003)(316002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhjQk1NeDB4ZGpwdzNhMkFndE5OV0lCSWRoMTRFcDJNSW5LS1JRM3FCSnAw?=
 =?utf-8?B?T3ZvSXRRc3R3Zmh0U1lBMmgvb3pLZWdmSDJKOC9rOVZjV2ExZVN1YmpHclZr?=
 =?utf-8?B?WEFjQUFDWjFuaDVNYWUzTTQ1ZWQ2V01XMTkvSTh4UXkxekQ0SWIwNktIMlJD?=
 =?utf-8?B?K29rdDl3Y3M4Ukt0bTgyR0V3cm5JWFdDbDZsTk5qaGdnY2t2Y0lIWk1GTnR4?=
 =?utf-8?B?anUzdk1WY2JjWFV4c3dHdC95V3gxMUV2MTNmRzVLQm92dThFQkx5VUQxOTJi?=
 =?utf-8?B?cFA5YkZpSXl3RkNRYXVEblpMT2s3RDh2NXdDR3pzVi9jZURTREtnemVxV0Vi?=
 =?utf-8?B?VzFsbVdjaUJxM3loZWE1STlybC8xclBNNkpqbEF2dEdpTDFvK1FOb0NQOGUx?=
 =?utf-8?B?OWd5R0ZadGRycmYzQW5HNDZwSk5VMTYyYmNHQm5sd2g0QTk2QSthSEJsMDVS?=
 =?utf-8?B?Vjl3eTNoUjE5REZIWkFSb0xtWGRCWjd3VFlkSmduWDg0c1MzeWhlSW5MVmx5?=
 =?utf-8?B?MmM0aCt6ejBDNFkwSU1qTkovRmI5YWFxQkp5MmJwbU8zcUY1d1JXcU9oM093?=
 =?utf-8?B?YVZWVVl5ZWltcWUwQ2p2ZkVwamxMTXRmcWNtWTZMWi9aT1hCKytzL09tRG80?=
 =?utf-8?B?VUlWR09BOWJkbEV1dDFDVzVXb0ljdEM1aTg2M05FU2phalRITC9FdFkzUjJC?=
 =?utf-8?B?cm9FMHlDMHhkMmtwcFlYc2Y0RlovUFE1TmlGSUN0R3NWM0p3Y3MvN1A1Y3Fh?=
 =?utf-8?B?TGQyZkFneERnZlB1MGhUZFFoYWwrVyswL1hzdTk3YXRPTFJCSmV3VGc3KzJv?=
 =?utf-8?B?b2o3NW5UaUdYWEdwZUh5ZnMyVWNpSTNuNHZrQlpUSHJTSE1PQzVkcUtaclMx?=
 =?utf-8?B?RW9hUVdrREJIVE05UVIreExFU3J1REkrTmhWeGI0Qm9TN3RENTR5RjlBRHU3?=
 =?utf-8?B?aFEvUjgzLzR5ZDVuM0tuOW5LV1R3Ykt0NU03b0Ntc1pjdnIyN005b1krS01T?=
 =?utf-8?B?Tm53SkxSWTFjbEVZZ3B4dWpvMXJwY28rZWFhSUVOekpiaXA2Q2s0Q2NydGRw?=
 =?utf-8?B?Nzd0SlpodlB4YTN3VVd1VmJaUWc2eTVibFRCVm1pTWd4MVlOTkFPYUtaVUlz?=
 =?utf-8?B?ek5VOWdKOCtXSitnU045WnFJdjErUHpxOXQ4dDFLQk1DVy9Wc2svdWRQVy9B?=
 =?utf-8?B?bzJSdENrQTQxc08rVFFIVmxtUmplakF1SXdrTjhmanBtYmlLYWFVU1o5NjVQ?=
 =?utf-8?B?Yzd5anhxNEh6cVk3czRJRXIxZno2YTNrNEFhZjlZNWo1Qm1QdEFkeDczS2JZ?=
 =?utf-8?B?enRyUzZCWnkxYWV6UDBEZmRlNWpsbS83QnZHMXE0QzZUOW5CbXRiazE0OEtY?=
 =?utf-8?B?UTRQTEVsRnAyVkFDbFBCNHprVFA1cmZjQ2NqM0dqQmtXV3ZXWEVXR0xIcTVk?=
 =?utf-8?B?Z1RhMVNuNytpRTN6T20wNS9LMGJ2QUw4ZGxTMUNoQ0pSbysvNVZzUzl0Q1M2?=
 =?utf-8?B?TVByU1JFL0VPdzV1SFZ4YmgxRTdITmZEdVNQS1dsN21PQ3VVNUJJWjhWY1dK?=
 =?utf-8?B?eEZrZTdYK0gwUnRFd2c5d0xnWE5JSTlxRXBrNUQwRGo2YWhLT0M5cHpBUEZC?=
 =?utf-8?B?WHFHNnRQREpoTU84cDRkdU4raEdTMmZvaGJZbVdnZjlFNXdadmIzVlREdHlm?=
 =?utf-8?B?a3dOdy92bUlEL0FZSjZaWUVjakhtYnhuVyt0YnIxSlk1Qk9zWkRQck5WSjl2?=
 =?utf-8?B?SUN2ekllb1Z1N1pNMFFnWjNwZ1J2Sy9pbVRnTm4xRE03aXFnN0JtYklIQVFL?=
 =?utf-8?B?QjFSWEtPbzJGTXhacUJRYWJId0Jka1R6d1BSTmZRSVRNZWV0Yjd5cWY0enIw?=
 =?utf-8?B?alVkamtTWktyV0NDTDVWSmtsOVU3bWxJZEV4UmdMWkxMV3lDa2dkMWxueU8r?=
 =?utf-8?B?NDhBNDROcUM2ZGRWRENVeWRtazBRRXo3MFY2Y3hGR3U4UWxsdWMrOXJBcjRC?=
 =?utf-8?B?K0dESUwrQVExTTdIUTdiKzRRNDZQMWNCb1lpRmp6TFg2Y3pDVkVMRGNlby9h?=
 =?utf-8?B?ajNCamFBeEhRYmdNZXB3Ny8rQ21SWmFkZWVZd1J4ZnpoZjlxM1JmR0lJMnpa?=
 =?utf-8?Q?8iroAMK1tOTEqTGoSSIUZx33B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40f5b7f-c781-4091-f59c-08dba54281d9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 08:08:47.0596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQGjDiPKM/QIjjj/jT/+U7inIz1SoXmbCZxvRmaBp83fuz/e0r8QsNN13UndqBsK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
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



Am 25.08.23 um 07:22 schrieb Ma Jun:
> Simplify the code logic of size check function amdgpu_bo_validate_size
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 +++++++++-------------
>   1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 807ea74ece25..4c95db954a76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -480,7 +480,7 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   		*cpu_addr = NULL;
>   }
>   
> -/* Validate bo size is bit bigger then the request domain */
> +/* Validate bo size is bit bigger than the request domain */
>   static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   					  unsigned long size, u32 domain)
>   {
> @@ -490,29 +490,23 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   	 * If GTT is part of requested domains the check must succeed to
>   	 * allow fall back to GTT.
>   	 */
> -	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
> +	if (domain & AMDGPU_GEM_DOMAIN_GTT)
>   		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> -
> -		if (man && size < man->size)
> -			return true;
> -		else if (!man)
> -			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
> -		goto fail;
> -	} else if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
> +	else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
>   		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> +	else
> +		return true;
>   
> -		if (man && size < man->size)
> -			return true;
> -		goto fail;
> +	if (!man) {
> +		WARN_ON_ONCE("Mem mananger of mem domain %d is uninitialized", domain);
> +		return false;
>   	}

That change here is not correct. It's perfectly valid for userspace to 
request VRAM even if VRAM isn't initialized.

Only the GTT manager is mandatory. That's why the code previously looked 
like it does.

regards,
Christian.

>   
>   	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
> -	return true;
> +	if (size < man->size)
> +		return true;
>   
> -fail:
> -	if (man)
> -		DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
> -			  man->size);
> +	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man->size);
>   	return false;
>   }
>   

