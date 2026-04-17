Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A17F4368E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 10:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B09C10E9ED;
	Fri, 17 Apr 2026 10:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GAr4xixD";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB67E10E9ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 10:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1isAjp9DuZ7hS3EG/RFn9TtEQZ7rXAOi1tJdv/FI1nXI6ZXj0A5MHRVt53wnqBCv0uVLEagXv8GM2JQIvSNJ4QIbf5PYI8SETEYRA3b/3zDUu4OJm02Rqb9Yi8ptI9hDSZHehr5PyNtwcr1l4ToRfqWvOIEoUioEoqFeS2LLiqB92O32ZGoTsIiWmUy80JoDzRllyGP4YjGzFKIPXj0UJUK+9iTTDNXPVKZbCxpXL/LX1NAaMhIPn3gkbO6C7RW8xiyL0RxI6z5I7B3fDgjfys1cR5xDxj5DA7kfWlMjJKA2Rj8UnAaV0j1IcI3JqTOHM+aE6hHkMPbRSw+GZdKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mm6dfCbh3SOYYTmktrBznnroC+oEdUot9MxDV8H7Egs=;
 b=FOniq+sjNXoTqC7JLHWWLEktAPiRPNp2Y0SMzueKHH2zHZr4XGTLrEttVExEkNCx9tBBx+TUiumKwJqOC5ELyfKtNWh0D/s2hT3dGYO3Eq365qhzGSrmcotAjsMX1uAKBsMiqkBAclC1HspalJ7kj9S89wDSMb2sEdO+ycBQFYHvwPXg7M1sciRC41sWqkbgvEGV8LdPU9hcZRW2dU9Px8IoM6e5FTi7bxZkborI4l0C3MYonoc7yjgm964LLzmHQGpY6aIO7iw6N+hOdeldyvZ/wbCR08V9j+tv7j8i6iVCQP70wlTH7wykTtS4b+fWXbVaXAb8xxY7GGj3u8TeLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm6dfCbh3SOYYTmktrBznnroC+oEdUot9MxDV8H7Egs=;
 b=GAr4xixDV+ZC2sUC3KD9f4AtAvTXR6KYSlgjWF9v03NfgrRA1AViNqfykfg2YMNJY3XK1d+30p/IsWIQNExm8ob1d7/GL4EP9VrVokR9bsqv+OidIoEPxoOGk2WrWr/qFKWnktzY3E8Nn9EA1yyLibG9d/sxlz1Y7pXy6ClAq+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 10:58:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 10:58:52 +0000
Message-ID: <3fbffa96-9b09-4a14-918c-609130f34c64@amd.com>
Date: Fri, 17 Apr 2026 12:58:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amdgpu/gmc: Fix AMDGPU_GART_PLACEMENT_LOW to not
 overlap with VRAM
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260416202643.25350-1-timur.kristof@gmail.com>
 <20260416202643.25350-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260416202643.25350-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f014d9-0efa-42ff-af33-08de9c704fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: OMQNZ5tzMKssUxvLJap2gza5gaXok04IzAl+HNoVMf5TgNRSu9KlYPmnCLzDlYYIs49RW8URQ8VFd+T1EIYKh3Ez9sSyhZ6eXgJOntjWYB4QFFAfMzMV39j5tNZ2dVJ7dvl+Ywoy4f8Ds9Q+Ki4/plItDOpA++yBA84LAvBCkMKsCK5mlnX3il916X4OSWqApAH3DSEDHE1B4pQOMKVieHTlN7dwrldRX+LGWiiyGmtPmdk3rletER/CqvSrxcH/2DIDLonczdPf9u/u2Vjb5DETa/5GxffBl1pze3jEt3aZaXSeqCk+BFInRE6pXnOfr0PFOJdT5G4PErW28ylC+z592BoZLCJ66ef22HIC6kTRXUplXGC0Hhs7uubJnKayKpx0nuqXpfoO37DquAt2x9kj3h0eQz8P2kLjHRM7n91X+JBWcS7IxJmy3vVfMGJw7SopGuYRdX++xxP4ek1V8M83RSwTlHUlGbgpzF0dgLK6EpR+sbztqBjc7pdI91es8vQwqu5CUpJgQ0p8lwRv4rlso2C4dd/Qtvvnxu9bvw6CwEglbKsd+EvSM3Ms6Qj2MaC+KU7PromPzrWdt+kH1aUBvcKhLx7Mo61bbCqosmeDJUNrW4yvPfGnZolvdH5rs0gx+sxu0hQzmbwSmxJMakM79xGgKWRIh0jMwSCJN1KVLETGwHZ7u9k+izfZdMO7Ttyoib8gQqPXQYVP1kxRFQwtyt6p1+dIdUbUiC4wShc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9kWE9xVG1JcTllTlUzY0dtVk80MjZNYzEwcTBlWmxBNEMydTl3SjNDREJo?=
 =?utf-8?B?cVEwTVN4M3A0MHlhSFRLM0IyOW5PMHBKNmFvU2VObjVzdnBEUXdPWHd6Q2ZI?=
 =?utf-8?B?TFR3bzJhU2ZlZW5VU2o4ZCtmNkpxdUFrL0UzNHBIT1B5Rm13WC9teUYxRm9a?=
 =?utf-8?B?enBPQTFKd3gyc1o4UkF0ck1ZWlhhR2FhdHlockoyTHBSZFRWZzVoRzBCdFhF?=
 =?utf-8?B?OWpHampmcEJ0Yno4WVlLNTh1VEZpRjdNNWdlRWpPZ2hmNzBPN296c0FNWG1i?=
 =?utf-8?B?dlhUQ0dzMFpkY3RHSDBNcnVEdXIyZThQZXFBK1czektZY21Bb2RBMFJJTE9S?=
 =?utf-8?B?SHpUaUk1QUMzb3E5SGxQL2tJaWNkbUE5cFlEMytKWHJuZFJVajJiMFp4a1ZV?=
 =?utf-8?B?aHBRT3ZzdjlVMlhFVU1BMHV1Nmp6STR6andySHlVc2JxaWpIS1c3MWtKNkcx?=
 =?utf-8?B?VDhlZ0hVelFtNVBCNWtJZ0M3SDlVSTU2ZC9MWkVpbW4wdmNaZktFTjBZUmpp?=
 =?utf-8?B?dHdvUkdCTjVOdHB6OWNQVjJ0bFVWRzJOZkVzek9Oam1PZTZCWGpmcUJMTEZO?=
 =?utf-8?B?SHFUS0FzWW53SHlseUVjclltVGlXc0tyNlF3aDJrWVAwRytaMzVpTnB6ZlJU?=
 =?utf-8?B?WEpKSjNxbzJRSitveURPWkVBeWVneCtxR3BtOG9VZVBybC9oTFFLTzVyQlJo?=
 =?utf-8?B?Q3ZxUEphazNzbkJ1ajdVeVJnMWExNTdQekwvaFFQeFpZZkdUNWVza0RDR1lj?=
 =?utf-8?B?VlkveXkvd0RzWHlRdWZ6WXJuY01ySEFYQ0tmTkVDS042NnExSitxcUFqZXo3?=
 =?utf-8?B?VzFLOTZwYkluY0FEUlNlM3pqOFdmaStGSVVVWDN6MU50bCtiaXpoTk8rdWRh?=
 =?utf-8?B?SUZBQkJVMW14MWxaRjlQOTNKdXdPeXdWaUJWeldoZUtHd1BhR09pVFF2SHVu?=
 =?utf-8?B?Wkh3K1Y2T3N1L2YwNGU5V0RPaDFYRW55dnYwRmltWkFtQlM4U3BOUWkrMVNo?=
 =?utf-8?B?TmNURnM0a0FpYmZyVzcrZ2NQUnNQQ0JOV3NGRkxjN2h2ckVTelpndTZIdzJ5?=
 =?utf-8?B?QjNidEw0U1Z4YjdSN2ZQaVlZeE9oR2pRZElrZWg3TDlrTERocy9JYUpYd3JB?=
 =?utf-8?B?VFlKM2NIT1NDT1djaVBxdDhBazhrMm03U1poNHZyaWxFRkh2V2xYZmlWaG1u?=
 =?utf-8?B?cllJbmgvbzJIU2U5VFF2Mkk5cjErenlxYyt0NHJ3engyQ1NMWkpDK2pjQWph?=
 =?utf-8?B?cWptUUVaWkg0VnU3MnVwWTdwRE95UlVOdnJYYlVxZndjbUpINFIxNHlOM0Uy?=
 =?utf-8?B?SGJZZExObFVBREhMUkhDOGtCaGR4SWUrQzBnbW5ZbXpCbVhGUE83eFIzYUVs?=
 =?utf-8?B?d2pQc2NYTXVlMUVBWlZxZzV5UHVzZkJ2ZCtubUZpWDlPNC9hVUxPd2R6ZDVG?=
 =?utf-8?B?VktlZ0hKVS9kRU01V1p0eG51RVo3OXBmT2djMER3MkZtN0liY1RIQWY1WjhE?=
 =?utf-8?B?RVBZV2w5NEZPTzNOWVFiRXpUVHhodEh3WjJ2Q3NwUkxxaVloZ1Q1dFRuaDFB?=
 =?utf-8?B?QmhpaEl2N2tKSkdHS2lodmsvYnBkNDdTQ2tEbHlpb1RiZVpYdkZaZm5kVEpW?=
 =?utf-8?B?MXYvZStVZVpWNkdSNzY5QzFXTE5WR3A1bWx5b3NUaFUxMUc5TEFSOHRrekpw?=
 =?utf-8?B?M1hSemxKRWN1bjB0d2lsbVJhbi9BeUROMkh3TWxlWXIvRnJnNXpWdWlsMjR1?=
 =?utf-8?B?S3ducjA4RGdYNE1YQlIveHMva1gxODlaLytYbEZOcllwQm9FZHpwdE1XcTNv?=
 =?utf-8?B?R2kyLzI0R21zNEJDSEF2TVQybVAxaWc0Vy9MaWdPUHhOeU4vRHdzUko0cnNU?=
 =?utf-8?B?bEo1YkEvRmE4Y1BsYk9HWXFab0pVM3JwMHhwR21PdzJQdzcwYmdid1RQcDJX?=
 =?utf-8?B?cmJQZ244bU1yY3RTWnI5RzRvdkd1ZFdjTklnZ3hJSTFDNnorN2NVOXBrTHJG?=
 =?utf-8?B?clVvRWFFUjExL3JJSHpCZUVUODBRdy9IUjFUeElCQWNTcUYxR2NScjV5RnVK?=
 =?utf-8?B?QUQ4OHVXVVpCdEhQVDUzUlZTWmFWeXlrdTc4MWI3bVVqRFB0OG82SFIrUVVq?=
 =?utf-8?B?dFY1MnE1dm9LNlcyT0JIWFUxVmF6MENjblV0UGN4ZzR2WnYrT3hHbVVRZVZp?=
 =?utf-8?B?TWVLQUx0WWNYYjRDRGRVS1cvY0Jta1FxUWlhNUc5TzVRYTFZc1Q5OFBrSFFn?=
 =?utf-8?B?dTlPSTJyckRwZEhIMjRSYlRwanJzOHQvVDE5SjRmMElqTHFUKzExQVUwOVAv?=
 =?utf-8?Q?u+69Mpkokl51bJO2NY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f014d9-0efa-42ff-af33-08de9c704fe7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 10:58:52.5542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Eopp8KaGQI9/W2FbWh47zeQakaNkIRfeYdsANlcuH7/ckoWDJgPVknfz3hQT8OU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
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

On 4/16/26 22:26, Timur Kristóf wrote:
> When the GART placement is set to AMDGPU_GART_PLACEMENT_LOW:
> Make sure that GART does not overlap with VRAM when
> VRAM is configured to be in the low address space.
> 
> Solve this according to the following logic:
> - When GART fits before VRAM, use zero address for GART
> - Otherwise, put GART after the end of VRAM, aligned to 4 GiB
> 
> Previously, I had assumed this was not possible
> so it was OK to not handle it, but now we got a report
> from a user who has a board that is configured this way.
> 
> Fixes: 917f91d8d8e8 ("drm/amdgpu/gmc: add a way to force a particular placement for GART")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 1daf2546d3b26..b454b463bcb2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -314,7 +314,10 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  		mc->gart_start = max_mc_address - mc->gart_size + 1;
>  		break;
>  	case AMDGPU_GART_PLACEMENT_LOW:
> -		mc->gart_start = 0;
> +		if (size_bf >= mc->gart_size)
> +			mc->gart_start = 0;
> +		else
> +			mc->gart_start = ALIGN(mc->fb_end, four_gb);
>  		break;
>  	case AMDGPU_GART_PLACEMENT_BEST_FIT:
>  	default:

