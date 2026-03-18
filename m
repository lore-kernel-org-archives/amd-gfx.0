Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47D9FCD0AE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 05:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 713B110E09F;
	Wed, 18 Mar 2026 05:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KBmnNWFb";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9295510E09F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 05:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNgmtqZVRjtpt3tpusKRBV9Fc4MX/tmWTGIcvu0TcIGNcFan/QxPYD+U0mrbebbSechxm7PSRsiXhdX3iIsZQyGGLfnPC2BKGH0woYdAsC7OuEN1k5cdujRZHhRo5oriaUS/PTAWwW9wa9jWdbBrLQOjDEaWGyTVxBzn8fOkYG4/6f0KLv/28IbLMXtoumKytuoqWvP3l3gY7+7t6WFaZQQ3UNkGbE28WAoQuSdruKRFRduR3+aps0aajZerhN6BhHPKzbzD2zz0LqG3YcIm12EhoY3uLCD2mp/uINWiBwkjLC8D8eenzmqfAWhm7Kdo16uRp0coXD8/HEQaeyCfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5Wox5OfbIQkPiAFCPzeAOCMUYa1hMGxu7HCZG4X61Q=;
 b=Q9vRRvj3BzOvhNzc7n+C6UT6g7bG5l3fDsrxXowDD1uKG7LKr/FERjMstf9opcdXDFL7K6u76NYJkGCOzYUFUvhs7V0TWoyywzE5d8JcbxeREO3z45LL2oZrDNLcpZOzQVnG+71PthP1W8k+X3/xRjZd8/ayLNJe2ZD5QF8qDAFN4gFnVa+lejyiTdjZseMl9PjlPggsVkcFPSahNLrvSZI5IEQah8ZRyFomr/e+dINUpZf+C1w+gq9oPws5CmWU9Buev0InV6npbyUb6Navb92GMH09sPdwVBkTinbTQiE3uPbuS3ECmxzu+4ILGoYcAgtcnLcgPVzmOv1/BHvV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5Wox5OfbIQkPiAFCPzeAOCMUYa1hMGxu7HCZG4X61Q=;
 b=KBmnNWFbh0AOkgbyW2MeJa7C8D8EngJsKWQ2FQ5zKAWmMeYkMSsELQgZqSvcAUReiZgmt9mNrMqwCXgB1dDNCpdPaDCMArajKn25PiKcHj+cDzObLYfimxR+ddkxLqjs9NTxq5dhTEp7vfg0pLuNxVtqxA6JePuPqXKLykEb2uY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 05:22:15 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 05:22:14 +0000
Message-ID: <d6863e8a-f94c-4ba0-8120-b8b6a7f2137d@amd.com>
Date: Wed, 18 Mar 2026 10:52:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: drop SMU driver if version not matched
 messages
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Yang Wang <kevinyang.wang@amd.com>
References: <20260317204110.3833021-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260317204110.3833021-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0040.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::11) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7cca5c-5e03-4199-9e6d-08de84ae5070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: jNVwhQ3YV8I20php0Gjr6bfUvFAY/aFvWRoxsyMINHF4djnzocze9Ttzexsv1KLTWWEXjwCgg/GjOiQAZ9cFFaJ7DKAZyDjrqC7Ko5yCOG6gyZHKrf9yIqmtn38pqZMxFSbnMxkZLNUdK44sG6rXyiCCnZiXsiJJ7Zjlk9w84P/5K0Db8JLnwe1dxwetHtmuG0NO5iFRrveHvJKmL0V0sGXgUBuN+hcVkO11m7aSrB04OD2obcs1D1ssQsEgQQeCv/Chf94faZhOCtftcKyyzndAkciQmBnCg5vfRk5rsNM3hO0A3urrTsHrmguS0wzoLmDKALY6SgSANrgv9UJakWE93PQ2/a5nqiVVp2nv4NJKQix84HVWa1QpkDC5AEBw41lMoWHV35dGrd7qTSjxYANcpKqic+1aEXGedkyKml++qFKqYD7/WzL5xQke4nj+RTVuwvcz8P3NfD0rPiKw60jeMIE7+Pt4XYfD0LBeVXBXUtGic6Lm7JeQAgJGEE8T78L8+VNz9tOyHtj4vrPXIZR24pW4ASgg/7W0RkgS/2SsMwO1Nvlb/A6aKg0UbULnDm8xzqnWkz47gf0tDXDnqLf+CTmUhtyXLO5Jsqn2GPeAfMLhPgXQk/l6D+D+G1CyhEwB6yi80Bu7GarrhgUev1dxghyNJhuNExmFaxnhob2M8uxXDN8cKi7jn//iBbV+lfupR4hXEXhNOUL/c6WcRMHokQ1irkiLobS675MWjco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1ppdHdxTEFFc0FBUzZnNDYxdEJ2eTJZS0lqeldJL1ZuMmFjVkhXZUJZb2lH?=
 =?utf-8?B?RHFXVHpTTVlDL2ZMaTNSTHdGQjBTbTVmNjROb0UzOTBjN1VncmRMSjJpY3Ru?=
 =?utf-8?B?aENsVTNQMUtpSW4zbitkcFFGbDB4Z1pvTnpFSE1zd01MdDdqcHZEd3ZDL2pH?=
 =?utf-8?B?cGszVlBza1dJWmpvTkdNMWx4cmYwZVpEN2NTRXA2M2pLdisvdzMxSUdrSllD?=
 =?utf-8?B?ejk3U04zMCt3cTBmVkNvU2VXaVRZUlQxdXNOdTUyWEhPZGNoczBlR3AydHV5?=
 =?utf-8?B?d05JdGhsSlBaaEI5ODhaM0FEdHlVc1RzUXo0a3NrRHhvdHg3UWIrbHF0bkxQ?=
 =?utf-8?B?enIyd1p1dUY5ZUpGT3BWOXdWVFJVNEVxTTVpRlcvTmJjbEVIWnhxZWd1dzEz?=
 =?utf-8?B?VXo5d0lYeE94RklrRVpWdy9GSWc2M0ZMN05UWEx5T1F0MHg5Nk9uSEM1THFS?=
 =?utf-8?B?NnRPN3c2WkVMVDlvRnZMSW82S29BejVQdXJWWHZyV2M2TFhQZ2UrTEVHOFhq?=
 =?utf-8?B?OSsrYUd0VUtHaHRvWlpES2V1ZGZmL3lYUjVEczhJck85bGdtTytjaER5ZVdS?=
 =?utf-8?B?L0M4NG4xdVcxOERzREd5czZFOTQxZElteTlHaW1NSUloRStuTGJ0VFU3ZDZY?=
 =?utf-8?B?R2x4UU54cWd0RFM0YXZjRGJqMVJYVW9oN3MwMkprUktkOGVmWWdVMHRabW1y?=
 =?utf-8?B?Ry94VlJablBkSTVLY2hzVDFMYjZqSk5sWm5WRTBRZFJLMG1ZNUZQMFJyeFFW?=
 =?utf-8?B?akNXMjdDeEE1a3YrZ2hKSFRWL09FU1NZYzZ2VERwdjZQTWYzNGRhK0YrOWFR?=
 =?utf-8?B?cDZFTE9nS1lDRzZ5QmNHZnVMaGRYSFZuMW9mcjFZSDRBUmJCSmI0cEhyR3Y5?=
 =?utf-8?B?MjBuR1piQzFQUkx2SklSZ1ZVdmNhRmhBNTZwRkFXTDVLc3dReHpsYkxjZ1lr?=
 =?utf-8?B?L2prSWVTSEoxSm9PZWhpVEJsbHN5Ty95S1BVOTJ0S3FhOEM1K1V2UWE1b1Vp?=
 =?utf-8?B?cFpuUDNMSWN2WXFGWENlbllDQzVVSzR4d09PNWRKMFdUdUVSRW9JckNwV3ox?=
 =?utf-8?B?cmxYblBCU2pEOXExd0F2SVUvMEwrSDF2cDl0STJwcUozY0k1MU1ubVBZSGJF?=
 =?utf-8?B?cDJCQ3N2eXlOTS9Xanc4Y1o1cEYreTZ1REtwUzBTQnR0VW8wMnpnTTNjNWVz?=
 =?utf-8?B?aUd6ZTI3WGxjVlp4cWZIL0FjK2FRVVVuWVFzVGVJbHUvN0M2NGdVc0lXUGRk?=
 =?utf-8?B?SXJoU3V2VjdvbzB1emRtWENVa1EyUXptdE9YcmhFcGZJblJONFU0L3ptdWJz?=
 =?utf-8?B?RjJGcy9KZHJEM0ZsdjNhU2xoQ1F5dElkOVl3bjh3Vmt4bTkxbG40dkcvWlVj?=
 =?utf-8?B?Yzd1WENlRzhPY2FvZnh0M2Vod0FoMnV3cERsdUlxOThrUG85Q3FOc1lkOUQx?=
 =?utf-8?B?akt1U1pzUFVrN1BkeG1KVXI0YXZQRTBubTdRU1pnVVQ1MTF6bDIxYm9FcTJr?=
 =?utf-8?B?L0xOMGJ4Qk1FeUdxVk90eWdiMVF1NmwxN25JYnF3Wm5TY3BVM2JRZTB5VFE1?=
 =?utf-8?B?TzJCTVMweWtwMUk2WkdrZENyTWFWWjJabXhCbjdhMVJ6ZzVuSlhwMS9yVC81?=
 =?utf-8?B?M3pJd1hEM3g2WjQrQUpHQjhBakNxYmZLYWFZM2FvMDVPTjlDbE1NQktYQ1Uy?=
 =?utf-8?B?THZNaHNJU2E5RnpoMDZoUjlrcXRkM01GL3NqNVN1QlNBNXJtWXdCWlhmYVVs?=
 =?utf-8?B?cXNQKzc4Q3BhS0tVazRMbE9TY1lYZFpQWTBNV2tEdWVOZkN5R003ems2aTVh?=
 =?utf-8?B?NDBaK0FCTzV3TFpubWMvMWtDQXdZWjBnMlVHbHpac2U1RC9MV2dRbkVQUmdy?=
 =?utf-8?B?UVhxRzBvQmRzaEJ5djdrNnFrNzNRVk1mRTBhNEVMREJBMUtMUDdyWjQ1d0FY?=
 =?utf-8?B?YVo2Q21MaFhhSDJqOXAzVTVrVkkxK2JwSDNXT0o5MmxIZXBscmxVOG1FTVFk?=
 =?utf-8?B?WmFTbFNlc3ovK2hBdHArclR3V0JNcGRkS3dieWdOdHFzVWQ4UjBnNENnalR1?=
 =?utf-8?B?YVlER01HRS9iNVkxK0h5bjNQUmVhaGN2dU5hWFI0RXRZNkdKc3BzaTVLemFh?=
 =?utf-8?B?ZTZVQ3ZuNkhKMjY1QTRiVzJtcmt6VDBOVDJQeUNMc0ZNQmtiakdCcHF5Szhj?=
 =?utf-8?B?L29JMjUrWHI3S3pTNXIzbktOMjluMDZpZVBZT3lmbnAyQ21DTDN5OXhPZVZ1?=
 =?utf-8?B?UmZrbkhSenlDYkhLb2VDRE9wMTlBc1FLS1dxNjI5UlMrcVVRbjFhdWl4blYx?=
 =?utf-8?B?dGdwNU5jUWVJSTYyVFIxalJEekhJcUNkaTd4bWVwMHMzVFVoL1ZSUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7cca5c-5e03-4199-9e6d-08de84ae5070
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 05:22:14.8658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTBVqqfTOamKzMbbOs7pZQ/m3TJWlcRuTYN5XIS3+cvNQYd5HuLJx0bCaBCWYMaI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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



On 18-Mar-26 2:11 AM, Alex Deucher wrote:
> It just leads to user confusion.
> 
> Cc: Yang Wang <kevinyang.wang@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 -
>   drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 1 -
>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 1 -
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         | 4 ----
>   4 files changed, 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 56efcfa327dfd..1eec1a88e05f8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -262,7 +262,6 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
>   			"smu fw program = %d, version = 0x%08x (%d.%d.%d)\n",
>   			smu->smc_driver_if_version, if_version,
>   			smu_program, smu_version, smu_major, smu_minor, smu_debug);
> -		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
>   	}
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> index 2c20624caca45..ac5e44dff6c97 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> @@ -101,7 +101,6 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
>   			"smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
>   			smu->smc_driver_if_version, if_version,
>   			smu_program, smu_version, smu_major, smu_minor, smu_debug);
> -		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
>   	}
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 7dc6687c3693b..9f01bed3970ee 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -284,7 +284,6 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
>   			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
>   			 smu->smc_driver_if_version, if_version,
>   			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
> -		dev_info(adev->dev, "SMU driver if version not matched\n");
>   	}
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a644579903f40..5ec2b4e6f3f35 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1057,10 +1057,6 @@ int smu_cmn_check_fw_version(struct smu_context *smu)
>   		      smu->smc_driver_if_version, if_version,
>   		      smu_program, smu_version, smu_major, smu_minor, smu_debug);
>   
> -	if (smu->smc_driver_if_version != SMU_IGNORE_IF_VERSION &&
> -	    if_version != smu->smc_driver_if_version)
> -		dev_info(adev->dev, "SMU driver if version not matched\n");
> -
>   	return 0;
>   }
>   

