Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD2DEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F73210E49F;
	Wed, 21 Jun 2023 15:00:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8368E10E49E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 15:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmjeVQpXTp6qZ0u3FAiDymfr9ywcoj9XoP9b66382HTafTr4QRr/vMkoqQGa8bxH3We0WYr58Y2MXEYsIEqaCSnsRTqjaS+Rh5mYFmK8MESmcRBL5z7NmFXAhtWj8IkZPYIzEb1bmYjDfKeUD5vSqdBcuYjBn0tp73/OZISXWiK9r90KwfYvwBAvvysLsu6CkQs10D3r2/NSXus3nJxrVqQPLn7iFzmfB8GHPGLZYDIJh+DqN9bqyBkWSsnwEyHlyFJCGXuV/kj+gn9bpv6S6Jp8T7I36Of6QgGum3Qh1k/gLRFEf0rK874wyXkuqkDXH2nlzVwCfT4PgH1ovTPg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V1Kqf7DlmWhzlQymWXwxPCjj6VVGEbYIBa/UvXvHsY=;
 b=LZiaL2xR5p11WkWktJ/qywaijtaKxSrrOqBMDQg3eot2W0SBqION/MfDD5sGsNuCMMrV6fayi5OIJlzUleuuQXaiT+NZHTXbwMbwlxUf+1bR0DWcF3IAgrrEKoc5c0Y/6ozwrBjEaWBOKxwTpr2NOqxqukVHzAs0IRaIHoCRIPC8VkABLxL+SjPyev9q9VRqFTXraykhXiQe09FKh5XgzqIFH3EuSpPlVCK6UKrHssaJcfhm5YgkQwJAeSsFLRGqrPfNgHIYDykBwJDr3VSlsGW11d877xhHuNbDBsP0SblRTObc+XKaEfmPx6F1PBuPsWYv1qIIKRafIBbeaggvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V1Kqf7DlmWhzlQymWXwxPCjj6VVGEbYIBa/UvXvHsY=;
 b=vsSAbTd2gWpxrHWYkFN7/WV5+TeTAlJBkLTrzIanW9zmLFjwrZxiGPemdUrstWytjECyOZGazeZjKCMzo3c742xkCcvQGoULgRNqSZQ6h+I8L8jbpXfhCTjtdvXR9InkukvK0tpxobPSQ40C+FcFpCufR+aEyQ9VsBacwCPXELU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 15:00:32 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 15:00:32 +0000
Message-ID: <009b47ac-a818-a699-bc73-d2f9fd3cdf29@amd.com>
Date: Wed, 21 Jun 2023 17:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: add VISIBLE info in amdgpu_bo_print_info
Content-Language: en-US
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230621143502.22293-1-pierre-eric.pelloux-prayer@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230621143502.22293-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a7781b-0855-4e20-2e67-08db72684263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3s2aok1zipJi9AL37TUvrbL5x58IlLfWg2Rf/slERb5Ts1zOi0ljLVF3lkKQXqY2h8Z4+uFq/tESrFtDwPPZyl7USDsrMTKxWMPIBqNyz74JugQuBQYJTDeP6kBUS4tqvIROpud/WHPjABTxo+o4ZWX7gggTgBKsae0+NAfP7AH8RRjf1O54y/V8IlQPArj7omt7qeczYFmXzmehw1NBMDCr/w/7k7OPK/nEIpEl7n+cZe9pJDRYu/5RTsmcoGgkQZZQPR8kLxZSpmvGTyNhj1AGNcBRBgzp3L8sgSzM9Cl7s+g5KQweaN0KaA7mq6lTL61eH6yNntOha7d74GohSD/8Yn9CxhLqXpMgHyHNSmfYA/4NtrR1CXEXh+xajLF0MtYY09liYX5QjZr9H5iqdUTC8jZHDjy68Pl/y6J1RUlMdaZY4emtluoF0AwlVXLAMksLPGs/8tyuM3uIFrCV3/S+Ob2jLk9mp3X1JjvvKMs0I7zR/zG3Xtn17r8aHxXHjMhzoji7k7QYs+maDbfATaZuKa/Hob2MsA0eHDv3PAtbKwmN1vxpGJvquQw54Bq+ZS8q/7Xu7tqI7DeMA716/RGtesgW5pMvQN35rk4mF3UK9hyjJfkeLcK2PF+EWRG7ISty5FGIcD6ebe0b6b6MaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(31696002)(36756003)(86362001)(31686004)(38100700002)(8676002)(83380400001)(66476007)(6512007)(186003)(41300700001)(6506007)(316002)(2616005)(6666004)(478600001)(66946007)(8936002)(6486002)(66556008)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnpnNGdwOThyNmNSUEVta1FtZUxTb0Z2bHd3aThyL2xQb3lPVkJtcW42OEl4?=
 =?utf-8?B?SzkwUDhEQnFuVGNkTzFuVkxmY1VqZjBRaXgwVVgyZnA4VHByckRJdzl4aHJL?=
 =?utf-8?B?b2Yvcm04NUV4TUR6UWljZ2VkRnczb0FzRnJ5M0EwbHVVNTFNUzE3eU5EV2E3?=
 =?utf-8?B?cjA1STVscmZKMk10aG5Yb0RRT3U0QVMyNmpmU204cmJwVzNqK0VPQ0NTRzhK?=
 =?utf-8?B?Q3lqQ0xRTzlsQVA5NlZURTdIa3lRbHV0Y0ZEeHhpVG5rczhGMWFtdUhML2th?=
 =?utf-8?B?MXJEWlN5SnlYcVZWc0lOS3RTMWlPT2UrclpKMnNDUk44b0x5aThaMnBaWVJE?=
 =?utf-8?B?N1J4TnliL1B3OXpzdVpoWVI4R3c5bjFUc0FNam9ua1hYYm9mZnkzN0VYbkNQ?=
 =?utf-8?B?R0kyZ1Q1MWR2WVVHVEJoZ2x0VXhRT1VWZzFIOG1WYjZkSk4vbjFnSmxndWtP?=
 =?utf-8?B?OTNaKytzVHVvTDlxajREREVoSTJlTC9nUWZFWm93OGNqL3hQeWJMWklldVlD?=
 =?utf-8?B?c2tIYUpPaWJxbjRtVzgxOEZKSk9KNFQzbnNnOCtLM2NCNmljM2tkSWVGUGNQ?=
 =?utf-8?B?bnVNRVBjZzdWbnRpQlR2SG9UWUg2QUFLZXM3RzcyaWhtS1JzYUx4dTZzbHpN?=
 =?utf-8?B?aE9ka3ptaHNHZHlTR1VtRjRLZkNCZ0tKNno5RzY5MEs2a2xTV1Z2K0NiOFN2?=
 =?utf-8?B?SWNZbmF5UDJFM0RhWjc3WEQwRnFxNlEyR0lYRlcxQW5KNHVlYlhBN0pWMUhD?=
 =?utf-8?B?ajdWTXp0cW1HblhKaEVQZkJ0VStBRndkL0M4WHhxNXFqR2pPQjJpNG1pRjl6?=
 =?utf-8?B?TXJ1WWZTR3o5VFJ3SzBZZDhaVFRkUG84VzdKS2NyMGk3RCs2UEVHeTRJWWdr?=
 =?utf-8?B?ZmZENi9YeXF1NVYvanFGNDVhYWh0V0hKeERBVk9wTityS0ptYkFuemFBVys2?=
 =?utf-8?B?RFFQMGFXdDF0Ti9saWZTa25GUDZPcnVGU00xLzdrYkZqeGFiZGFFQmFFN2lr?=
 =?utf-8?B?N3M4YVNUWW1kbWovWUdIZjBPdFRhbWRSaFdOc1Y4UlRBR1NpTjcxcU1hRElB?=
 =?utf-8?B?WmE4VDhlZmR0d24xdXNaRG40R282Qzd0VkF1RVlKQSt2bE9HNUlnZzlvdGkx?=
 =?utf-8?B?dCsyTFgxb3h3TGlnSjlONHMyWktMWTAzNmQ0cWlIS2VPL2dNelFSQW45WGpi?=
 =?utf-8?B?QlBHWStnNDIxVDZKNjFLVm9LelJxRUUzTW9tMzJ2R1hibUg0ZWFTL0pud0d1?=
 =?utf-8?B?REZ3ZDNNNTlUamNaY3VTdVR2Y2FlVXhHUFBoMFVrenNlOEZtanNPakJHcnBL?=
 =?utf-8?B?Q3N5UWkwZStRdzdnWVFXa1RXbERGU29IY2J6eGZDaWtwWHkwcHNmdlgyYUFz?=
 =?utf-8?B?MmVyaFNIRk5JeGxnZHIxalk2dEVtSGxqSjdMUnNrdGFBZXNjR3I2aGd3ZzRO?=
 =?utf-8?B?SlpEREFnbG9wRmZoVFBuOXBHM05hTGZTa2x2NktxNitTNzRLUlpCQWFzMjZS?=
 =?utf-8?B?TG9zSWdmNHFmRzY5bmkvc1dIbHRXVXFSTElKTTNwamlvQ1l3NmNVeGZuaGZ1?=
 =?utf-8?B?K1M2cTFsS2xCbDRrc2Q4aStlTzBQZnNoZ2hRWnYrSHlvbmRER3RmQjJNUWVs?=
 =?utf-8?B?L0IyZDdHTkNFVkZXU0g4Z1RMWU1xTWZwQ20ybnIxWGd1cnNuSjRjSDhhTXZH?=
 =?utf-8?B?cWd2Y1ZmNTdJS1Jod2FkQlAyZ0RUUk9nUDhWbjMyQlZ5SU5DUlEzVytFNUpG?=
 =?utf-8?B?UlBpK2o4WDVyYkl2c05RVkZMQVRhdWNHZ3djdmdsUUxmUnRHN1JXQzI5V3ZU?=
 =?utf-8?B?VElSUHU0T3FyUGR6ZVFQd3JkUEZIUHBqdklJdlA1aTlwV0o4dkdtaDJlUnc1?=
 =?utf-8?B?V0FDQldINmZxUjM5Z2djaEFHVlBHUGQ4K2ZnSU1PS0pLK2o2cEJEWm9ta1N2?=
 =?utf-8?B?Tk5aYnlxcVpaMXA1cloyVDVNUjU5dDF1RVhma2oycGNOeWdFOEs5YlZYMFly?=
 =?utf-8?B?UW9DZ0pJVHNVbnVxbDdSWG5QNFlUMmcvRDhqSThPclYzVnIrZjlzSDRmL28x?=
 =?utf-8?B?SUdnQ1JHT001eGRwQWVSa1VwbXVXcHVaNVZudEs4RGNJcXRxQ0dJNlpIVEJB?=
 =?utf-8?B?aUxGb0pqU1ZSTDlOSGlQeTZOU2NTNGpsa1RidmppYXFic01oSzB1NG5FN0t3?=
 =?utf-8?Q?YbWYZt+CF3wh2NmvIUawylfcu5053ecIDU89+zdraLmh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a7781b-0855-4e20-2e67-08db72684263
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:00:32.1254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJdPCzgi1h1va78wb0aTK2+yQYjT6wdWQJbfUQ4lfPLRx/UIGUpudCAVSSFnoTJG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
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

Am 21.06.23 um 16:35 schrieb Pierre-Eric Pelloux-Prayer:
> This allows tools to distinguish between VRAM and visible VRAM.
>
> Use the opportunity to fix locking before accessing bo.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 33 ++++++++++++++--------
>   1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ff73cc11d47e..f12f019d7f99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1583,18 +1583,27 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   	unsigned int pin_count;
>   	u64 size;
>   
> -	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -	switch (domain) {
> -	case AMDGPU_GEM_DOMAIN_VRAM:
> -		placement = "VRAM";
> -		break;
> -	case AMDGPU_GEM_DOMAIN_GTT:
> -		placement = " GTT";
> -		break;
> -	case AMDGPU_GEM_DOMAIN_CPU:
> -	default:
> -		placement = " CPU";
> -		break;
> +	if (dma_resv_trylock(bo->tbo.base.resv)) {
> +		unsigned int domain;
> +		domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> +		switch (domain) {
> +		case AMDGPU_GEM_DOMAIN_VRAM:
> +			if (amdgpu_bo_in_cpu_visible_vram(bo))
> +				placement = "VRAM VISIBLE";
> +			else
> +				placement = "VRAM";
> +			break;
> +		case AMDGPU_GEM_DOMAIN_GTT:
> +			placement = " GTT";

We can probably drop the leading blank here and

> +			break;
> +		case AMDGPU_GEM_DOMAIN_CPU:
> +		default:
> +			placement = " CPU";

here when we don't keep the strings at the same length anyway.

With that fixed the change is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> +			break;
> +		}
> +		dma_resv_unlock(bo->tbo.base.resv);
> +	} else {
> +		placement = "UNKNOWN";
>   	}
>   
>   	size = amdgpu_bo_size(bo);

