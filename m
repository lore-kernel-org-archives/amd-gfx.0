Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671E4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 21:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC9A10E167;
	Thu, 20 Jan 2022 21:52:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FB110E3B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 21:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGTKeSDvIpBv81QFBR5P1w3bXt9jGYJ7pa9A8I2Lm9xjPukt5HzRJRiU1S03cbHRBAnmpRtDB0SwbpfZMxl4atZXfVrJRLgVkMpHQ6XajGf0l0GMcsiBsHxyjOq4ZfHrYLOAhXNeRcA886BboyY+1PvtkcoZOmdeVs/bJagBaICgk1OYNj+6iR5uU+H0urHj9zMH4wfPMnWHN6icy/YQAAI1JbpPviAxdpmNuU625PGGwpUIDU7njEQdaCzKTrLaBJutoPzqnRMOuEgCQSr96Dd/xdZquITTNRab8yCn0mOeofFcGWnAlpJRgKNsccC5GTRTwfR+pI0gkqC0aoQIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSyCC06eObgr6njA4h1osTZ/+bTk0OD2vRAVAd/I+3c=;
 b=ALvZHnz+EVTPQmfIm1y78fRCJsAduHgD6O3GWTmqlZ3yRbzdRpz4TIJYz6X4zMH0ea3/1NA5jOoK6oko+Qf7fdUsXci7Qh0XN38s2mOSWzod2C5IAQ2g8pIjZ1wEHyVpnathp82XH6xAYPAwtfT7uTjM7LHpOpjBl6n83z0cEdTjgTV+xejblK510liiCr5V4nSl4sGcAetwNmWsu5oWc4VmVM2wTtti5rDPTIroBx0ir52vRhlkdmc7lmArAPhZhzMtEJ0TsZu1OvrPnCTA0goaBSWZFoVeJiOegh2hs/GCVSopzfj29Ozaf1gFrLAEsGIczn0eZsO6pOVPl72cFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSyCC06eObgr6njA4h1osTZ/+bTk0OD2vRAVAd/I+3c=;
 b=dersF2epANAnCoRkQj1r+7DPFFhqXQv4vKhRLQ16LtXbGUYxm9Anaqhdgt+zGADDg+7zu8BlT/EikHU8LsArXWlRmksVzIVyg8QO9hcg6qL8SxovBBqJYbaHmI4mE0GyJop/O1sLpXyAk5rOk+9W9iS4ibVnS219YaP+P6hbdxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 21:52:24 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 21:52:23 +0000
Message-ID: <a5f61ce5-f56a-a66c-9c97-16445d2c4911@amd.com>
Date: Thu, 20 Jan 2022 16:52:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu/display: use msleep rather than udelay for
 long delays
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120180429.616236-1-alexander.deucher@amd.com>
 <20220120180429.616236-2-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220120180429.616236-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0344.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 821a5fe2-74d0-4592-224a-08d9dc5f23b7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3479:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34799FE42D4BC4A2150AA5088C5A9@BYAPR12MB3479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGUh2SstuoncR6if9iLslhPciYQgIWmy2BNeoyNcR5vtT3cQ0pwt3s+OJJbFwmKMnyivYLtIvpILWecGg9fiQsEgcnuQmIzrvbh7JiBi7tiXPJYolBC/RrYpbEO11HppcA8Et7yAHtT8mcwsg9RgjGlKvuSOYnibcB8e1gC3VRqQiY8CwGpGozQ0iLOaTcqEBWBObHVpfDYJNln5BHH0HY4hqdRa0bp7PIJ40lx8fcfFn8CkFCFLYrUEGpg/iE5fKINhgozG1bme0xguDqzBJR4tI6nQdTgWdBZRGoRFG07Gfo1K58mhsHju3zPbzcr3avIj1kbGxfRHk2Htx2sBKYfbp+kgzIoQLMCgpau+/to6NKQ7wmNCKNE8bBe27gJOsHV3/kmHR6uNUgrd2QFO2t6KC4tmmiHlG0+Wv5V+cHTM0JtLtwtJ8pmUnO3GHN0WeBHpt3Iubs+VRYlxqGc99iR6SxWhQ48/TijAL59JKjg+ZgnM3zypNm47KMjgPYli84GeqZmcOBqh/kdmFKIXS1vVHl2pJHbvD4WcSRCGNUuoLdn5UuJUUJ+gqFqUOoGsopPtrL1GekU+4FHrE85t4u57NvTrCl2XH/rWR0r3MQOVm5R0eMwkFfMPeLZWa5jBynBdzyzbe/90ZKcXwbITErtqpS0MU9FqS0DV1pNZ/esqb0Tg93e0wO0GxPJEcuEcaL5W8PsJVQW489NPK6AVe0xLIwDCQ5X8lt0RAdNXPEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(6512007)(66476007)(2616005)(66556008)(31696002)(8676002)(8936002)(86362001)(508600001)(66946007)(44832011)(316002)(2906002)(6506007)(31686004)(53546011)(83380400001)(186003)(5660300002)(26005)(36756003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckQvVnI3L1FKakltbm9sTkdWQTN4R251UmNzQ1g3S3RsS0orNW1TanJjSTNN?=
 =?utf-8?B?c1k3bVA4NTErNFdsQnI1ZW1PczljR0RmRlFlUk9mRExGUlZMZUxUMVdmWlpD?=
 =?utf-8?B?bTBmcWJmSjNrTiswTjFmd2lPcG1kSS82bExaN0JXQUVNalRZTHBIdmdwYXZC?=
 =?utf-8?B?M3Q4RmVJV1BCK21VZTZlZmNnT3FTQm9EYmhlbUpuS3N1TmpvNnovT3BPaXNm?=
 =?utf-8?B?ZWJjZjRvSW1tMFZhTFNvbXEwZzBLQTVqcHJkSVZDdGhmWDZ1SnZuUHdZbXd0?=
 =?utf-8?B?U0U5UUp1YjEwaHF5V01PU2xiR1Z4QW5xV2lGOWkrbDRxaUljeXdhanlsM0pF?=
 =?utf-8?B?R0laTTJMOEtNdmZ3L2JxQU9FY2RkRDJvb1FlSkc3OG4xbzZvRFppTE02Sk5I?=
 =?utf-8?B?Tm9pamV1NlhpaXJ2VVBjMHlhR0YrRWpYN0F3Vy9ocTltUWk4QmJ5T1l4RG9i?=
 =?utf-8?B?bFVOUU1Oc2ZnN1ZXL01IRGJtbkZSSEp6dWd1dGJRakVZdGsvR3NtNjN6RlpK?=
 =?utf-8?B?QzAvc01qR05QdStUWEF0SklwbFIrdTQ3RWt6TEtObE9jcnFMTmoycHl6THdR?=
 =?utf-8?B?eWNwNUY0R2JYZ09yVlBrUDdYbDJmdVo1UXNHTHFHcW1tbFlrNXN1OFV0SytO?=
 =?utf-8?B?UHlmRkV5S0M4OE8vY2ttUVBHd254aXJZT1hNL05leEhqbW9rWms4dlV4MHll?=
 =?utf-8?B?TEYvR21aOUdHdmJQbTA2YUNodG05UmpvMjFlc2x1WVYySGJLWW9hbUQrc0Nm?=
 =?utf-8?B?Mlk4VzcrVXRPOUJSNFJINEtuZ01HdjJIaTVERHVoYVUxb0dvUmZEdkYzMWJO?=
 =?utf-8?B?WklDOFltUXk3a0tmV3FVUHdpZUJPYktOWjNITmJXNG0vUFlaS3RpQjdGaEh1?=
 =?utf-8?B?eFRTRHI2MGZKRnp5M3ErSW83OTFqZSsxQWJldlBSYWpPT2pONDlpK2p3dTVG?=
 =?utf-8?B?bTZPbENJbjBBNGU4YjJpUzFEeVVveEljMWN0eEwxaG9mWHBGb0EvMXpDemp1?=
 =?utf-8?B?MklYbldNM2xRdE5XTS9CZVoyT1VPZStoaCtuWXR2RmQvbmcxTUp5U1pXNldG?=
 =?utf-8?B?Z2VYOUlqSm1pTW1UdHEyUlppMWpnNGlldXNQZkErQWJHQTFkK1ZTNTIvQ2VP?=
 =?utf-8?B?KzRMT3A1MGdhQUVYa0VZanRRTktPZThKZW9VdmpQcTdiNnQ2ck9ueGpvTU5S?=
 =?utf-8?B?YlN3S3RFNlRKbkM5MFpMaDlTa3ZwTmU5VnRiWTIzaUU3UFhCbGc2ZDljMkxl?=
 =?utf-8?B?eDk0MGxoVS9ybGVZaVJscldMekhzQTdHcTZSV1FWSm9KVk9STTdHdkdPRE1S?=
 =?utf-8?B?dUNGSm55a1RsYjZTTEF6K3RpcDZFVmc0VE5tVnBYNW02Q2dZSEw1MXdReSsz?=
 =?utf-8?B?ODRQMjcyZkVhcU9LdFdvS0ljeXB2RGlQa09lMHRRbWFHQWZvQUhvVGJvVUQ4?=
 =?utf-8?B?a3p6THUxNDU2YTVvazFpeE1wdFJvZUMrWVcyRkt2eTNEYTVtdE9veCtwVm5y?=
 =?utf-8?B?S0ZYV0p2VlhYNFhIWFIrOThud3diQ1UvVHp2b1czZXp6aTVsS04wSGkxeHd0?=
 =?utf-8?B?WkJxOFgzZ1Y2eWVEcmRDQWQ0OThQYUM2QTl4Q1gyaGhFU00rYTVqeXpqeHUy?=
 =?utf-8?B?M1J2ZEJJNWE0b0JJcm4rNUdRamhub1JZSlV6YVpuQ1lTZjlmcm0yL2Radi9t?=
 =?utf-8?B?dEREUnRnMGVtaG1MaTJoYUNPak02bE5tSFIwR1V5MThnMVNzMVNDdjREaEw1?=
 =?utf-8?B?WHlWa0ZHa0IzZ2EwS0loRzN2NzlYWkJsZVBqalhETXEzcDNhV201cXErRWxr?=
 =?utf-8?B?UlYzVi9BdFYyajBhSWZiTm5VbmJXbjdHZUEwT0hLaUM2NGtaMDAxQmlhVEVV?=
 =?utf-8?B?NmdtMHNVV1M1b1RlUkt2YUxtc3RKamxQckZoVFp3RHlOd0c1Y3RoL2hpS1lt?=
 =?utf-8?B?WlA1dFFOdHNkSGJWTTBsWmVrd0NHbDQ0S3lHUSt6UzlHZklaZkdENGVFaUNr?=
 =?utf-8?B?dWdFd2YvelIyNXAvb3VLNTJQSnBZUUhVRjFNVTNHZUVvbzZxSkJwSGxRR3FD?=
 =?utf-8?B?M1NrNGVTYm1YWDltblUvUDRNSk5jc01sNWVNcThOQnQ1NEQzK0ZIYTd4bHZk?=
 =?utf-8?B?bGluK1dxbUNnZFVHdWd5blVlU1RKZjhpcHRxdW9DR053Z1RuZHhZbGcxZDVH?=
 =?utf-8?Q?5/THeuREpAtACqJhimRvlmU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821a5fe2-74d0-4592-224a-08d9dc5f23b7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 21:52:23.5405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BCFT7iZ5/MfbP3JKdsmQpso6tJNMZIklpA0eFrBuU2pKu2Scy6rVA49fLr7joxRqsaV8lVCrpMu/DOpU7HVgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3479
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

On 2022-01-20 13:04, Alex Deucher wrote:
> Some architectures (e.g., ARM) throw an compilation error if the
> udelay is too long.  In general udelays of longer than 2000us are
> not recommended on any architecture.  Switch to msleep in these
> cases.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index aa1c67c3c386..eb4432dca761 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -6941,7 +6941,7 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
>  			}
>  		}
>  		retries++;
> -		udelay(5000);
> +		msleep(5);
>  	}
>  
>  	if (!result && retries == max_retries) {
> @@ -6993,7 +6993,7 @@ bool dpcd_poll_for_allocation_change_trigger(struct dc_link *link)
>  			break;
>  		}
>  
> -		udelay(5000);
> +		msleep(5);
>  	}
>  
>  	if (result == ACT_FAILED) {

