Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD1FC5AD49
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 10:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36EF010E4E7;
	Mon,  2 Jun 2025 10:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RpmKjDJi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D9C410E4E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 10:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6VUpLqHfdcN7tx947ShM2cVIaNn56nD/WPPn6YnWXr0p0LXEZq2k5c3iSTrPnlV5WV6cYyrBjbRYAs6iqkcAiOoR/beeGRreibYrVPL+Rx5PczvdKgiCcVzkZZoP3WL05H+/wp24kV0TFBsDHsJGUpn8qrle7s7Rz+TNPf0mXAIDG9/n+zwuF6H+2PWEQ0NfIZFFgkbATOCerZ7fIshu4rc/V32034x4oxXpmtLOJD1kLdTKuVQQexikNT+qe+eCKcAHbavvg2CbbSVVvNyScECMeD3v3y1qMJugeb8QYILaNnkLOUGiN1H1+77fNu8b8o7IG18RghBLA/65kWLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtfGUZ//uOXzMoAzkzyLnfeL/pQQ8YBgLke5ywPuBjg=;
 b=BhT5WhICCpKIH9F5ezDETI2fx1xk6BrIiSKgI9wu0UjRWl+dV8o+dZ7yo0G7hjFWY+sG4XEYpTmwu+1nqMuaLVZ73LocQWlsZBANZdtAiBeUDY2bXpy7KU0Wq/AitTNrC7UlNWOfx3KYaf3piUcadT9CRe1RX3R0KNnb8gSkDIC2Ff3eiLt2O3RioSmrkRQvd4tx65EEIlAN5JK5wizBqr9UzaFaBwYDdKx5KH2G/KNwkp2YNsqfBFyDclrJ3iQ5YePHnV8MVMAcJdJHrMDJ7sEznX0xY5dDLcGHE/ygwKVvOAI9MoF2k0ImStCgEvqQFWw2f8Od2EaVhxmZpc4RvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtfGUZ//uOXzMoAzkzyLnfeL/pQQ8YBgLke5ywPuBjg=;
 b=RpmKjDJi83WztdCcH/hUq7+7psXqllERCaLuAH6wGq1+ux4zyFV0RjawsfEfDoMnLvfVOvCeUGqE0MXQn/KWi2JLbfknyTG4LOQZuzcLzLmFZVtQvxiuGg8QEf4TZtjqJ9WdDJ3vr0T0xhgm/C5/VBmWpGOMcoQFBGSSdnoobUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Mon, 2 Jun
 2025 10:05:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 10:05:51 +0000
Message-ID: <0a8ecece-c6b6-4e28-b7ef-e6b92d31cdb9@amd.com>
Date: Mon, 2 Jun 2025 12:05:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: Should to return the evict error
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250521035654.17581-1-Emily.Deng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250521035654.17581-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a2a1fa-679b-4fd9-095d-08dda1bd0df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVNsWUJaOWFjOHIwSFhqRWo1QkU0cCtWMHg0WS9CS0hmZm1OZFRpdXgzV1Yv?=
 =?utf-8?B?cnhuV3hxdHpkWkdmd1ptUTYrakpseER1UUkzZXl1ekc4VGxNa1g1QVRmd0F0?=
 =?utf-8?B?N3ZNRmloUmFHQW1JRENqMzM3RXhZWWdwREF5U1hhQmF1eW9GczltSlVBeTZu?=
 =?utf-8?B?VFRLN1F4YVZiYWlrRlNOUGJkK1E3R1g3M0JMemw2T1lRRXJVTVZacDhnL0NW?=
 =?utf-8?B?WWNnTXhoY1MwYmJudFQvWTFRK2t6RjgzSVBMeGhJVTBVYkdqMkFFeDFUYzh5?=
 =?utf-8?B?QkZ5aEd2Wlp3RUNoRWkyZS95a0dwL1pMSytFZWVLV0Y0ZUlHVlJRdWZZSVBo?=
 =?utf-8?B?MkFjUGxEUDloOE9vS05NdHlkNDNxK2gwdDNxOWZDeWRMaWJiS3FkeURneXZ5?=
 =?utf-8?B?Q2d1RmUwTXlvdW14Y2RhclJsQzBOS2VJaE1jaEhFOUlrTi9GcUlZMTJkdDNF?=
 =?utf-8?B?M3dGMHFSaWFVMEc5bGtoMDVhMDhCSCtrQ2N4blVDTklDaUMwQnhiamE0Z3g3?=
 =?utf-8?B?RTV5MlJ1RGhTUzUycTVkSFQ4RzhrQnFwMjMyRUtJeHVGWjJ2RTVITC9LTmNw?=
 =?utf-8?B?VGxNRElSNWxNditzL2FNRW5VVjdqNDd6SXNwQnlkTFQ1d0I5N0RGSEpEdmRi?=
 =?utf-8?B?cFRGcjkwY0pzYXl6bFJPYVhPbC9yRkVDV29IREdsRHVTRlF1UWM4QnQ1ODA4?=
 =?utf-8?B?L2ZCQzdQNHF1NFZiazgrYkpuRUFuZ3FOc21nN0ZLYVMvMmpKSlJwaWl3Y2xY?=
 =?utf-8?B?aEZBek5INzVxRGFYbmJIR2FiT0xPd1VXUXFWK29pWXdNdnNwYkR3YVFLYmw3?=
 =?utf-8?B?MUFidCtqRmRrVjBhaHV1dEZvdy9ROGlwRzBRcjBMczh3azRQVnhhVEVvZWZN?=
 =?utf-8?B?T3NKNlMwcXZMNEpSRWYxdTNxR1hQUGlVVGZtMERrcE0xc3hDWU01Z2QyOW9a?=
 =?utf-8?B?dlRFRTdyY1RwbXJDblh3K3l3U2h2TjVzSmlRT09QMldVSzIrZ20vcWgzdkR0?=
 =?utf-8?B?TVZFRDFxOVRTTkJaeTAwMkR4dU9JUys5bDBUY04yenhPUFFsTTNSUEl2WG5o?=
 =?utf-8?B?b3F5NGEyQlBjRzM5VjN5MTErWURub1JMd0JIMklTTitwOXpob1Y5UEp1enR5?=
 =?utf-8?B?MUpQaUFZQm43c2xieEExL1BJRHBMOVRadHdQZnZ4YmY2blZBTnZ2eEFLOHZL?=
 =?utf-8?B?dTZTc2ZoYUJDSmczbHZNa3hoT0tUbEZOOFhieXdua2lnN2ZnaHVKRjZSVExx?=
 =?utf-8?B?QS8vS2pUckIveVNKOEJQYXVqRVBWcmxWbE5DZEtyaFFRUCsvTGpnbEw5UGlI?=
 =?utf-8?B?OCtjZUM4cGpxZlI0Q0FwQTc0ZksyTWwvR1JYb2t1RlBic3dLcXQzMy9FVlBm?=
 =?utf-8?B?cGovc3FXV3l5WUJFZkxxaDdvUUdEUWpyR3UzZWpWQnZuUUsvWXdnVnhaRHE3?=
 =?utf-8?B?dlQrQWIzWFdIUXhNTW80bWljSnlWQlcrNFdyTDhtelFldzBmMkZXVk1pbnNt?=
 =?utf-8?B?Tzlid1lpNGlWMEpxVDU3aUpBSENGSlRQc0ZGUzJGM1piT2FJdHJaN05NS3E3?=
 =?utf-8?B?UlloS3ppa1d5L0QzOUJKRHRPU1UrS2E2cjdhVUU5VE52eG5veFdhcDdjb2pr?=
 =?utf-8?B?YzRWV054eGFtOTV5eU1NSU1qbkVLL0dDbDBIbjRkdUVvNm4xSWRwUXdTR0Jq?=
 =?utf-8?B?dG4vdkU5YktwZTM1eVZlWHlwUm5LdStudHVxS3dMYkVaSW1GMng2Sm1wTU11?=
 =?utf-8?B?cElOc3hnTmZZN1d2NE5yTjZuK3h2ak9Lb3prb1VWLzFid0twUk1CMHZ3Ylp1?=
 =?utf-8?B?SXY1QlI0d3VCYkN6ZW9QKytDMk9odEk5NzhGbm5Jb1pjalFMTW5VdDA4eEoz?=
 =?utf-8?B?T2U5L0lsb1ViMjd0S2o1WnozRzVOelhYOW8xRjM1cmNveGQ5ZDc3MWQ4ejFN?=
 =?utf-8?Q?NfE3hROreGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNIUzRDSXNVOFEyMjNmQUhUNnpKYlFmK1FVVFBnbTZxZ05IUzhSVytoajhL?=
 =?utf-8?B?YlBKcUVpZlJBUVlyQ3p0RkJINW9QbjNjaW8zNkNXL3ZZYm5ZbHdRbXpidUhD?=
 =?utf-8?B?UGZ3ZUZlVHcvK2NaSjMrWFlvaVl4RU0yaGZ3M1VYOHhMbHVlUlU5bHJldjdD?=
 =?utf-8?B?ZjMvWkZxbmZwT2lUSmNWTU5CVmp6WkFQRTFvUVZ5UDFtY3dWM0JSVCtpajFj?=
 =?utf-8?B?Q2JKNlVZOHlIYzJuZmRTTm1IUHBvRU90Z2E4MEtXc3I1M2JNeFhqM3h1Qkpm?=
 =?utf-8?B?STZrcXQ5c215Z2NNaFhXcDNtbS9WM0tzOEkvYlM0WC9IOVNRQzBwNjBqUFBZ?=
 =?utf-8?B?UHhxaEwzZUFzTU5CYjBBaU5TWXdiVjdpOFJ4VGNZeTVJRTlNZjhVWDJyTER5?=
 =?utf-8?B?Rk5za005ZEF4dU1KS1B5SUEvUDNZaU1sWkpFUllsdFNJemptZDFtamloaWRQ?=
 =?utf-8?B?cDRJd2g4NHhvYzdzemdoUTc0K0hWLzlLNUtQTkcrcFdzMjFVNWNFREM0VWdE?=
 =?utf-8?B?bkZwcGRrcEsvWGNDa09FeGNVdys2a0hRUEFZRWozNDNYWW91SHZhNU9nRno5?=
 =?utf-8?B?eHZTRmR5Sm5MZTJEbUxUN0JxTmc1ZkplOVZYVXdodVVnVW1qdkg0WldvZmwr?=
 =?utf-8?B?YSswd1ZaYXNDVVlLcGVqK2N0ZHpGNVlKOTVmMW9jQkY1VG9Ja3NiSXkzOG5l?=
 =?utf-8?B?ZVdDTnltaG5Mek1jamhtcUlxNzlHUEtXZThUdzJ5cUlvRE15Z0hJSVo2ZFBJ?=
 =?utf-8?B?UkFUUkNMU0VJaTRrVEZpZXlHbG1UWnVJT3VubUR5RHNkb0ZvTDA4NG9XN0E3?=
 =?utf-8?B?bWJNSmMvZDArL3FaaC95L256L3A1SWZIbDBlajJwN3g0aXBobzJCNjB6L0pI?=
 =?utf-8?B?N3JYMjFtdFR2aUVKTk5sdDZLZVdsWUtkSGJUTlpBT1RUSlMrWUp0SG1mZ3g4?=
 =?utf-8?B?a3VoWU9taDQ1Z0FDMTAwM1k2ZVUvVTZ3QWZRNm9HMjBJQzJPU1RGaGZCZDVn?=
 =?utf-8?B?VmpTWVRyWkNWSlJqT0lYQ0c2WndibXBGVXB4MWdJaG00M1AxL2ZxWDVyUmxK?=
 =?utf-8?B?dEJjeEoxSFFkT0cvdUk2R3RQWWdMQXluUG1zUTE1eVhzSGtPMUhXRDZFQTNU?=
 =?utf-8?B?SHVoK0h4MlZlTmpxNjJ6ZW9OU21qUFRFSzBoU09Ec3M4Z21LOFNjYnh1TzRr?=
 =?utf-8?B?enhqVWdGOVZjSFU4MFkrYmhXVVlsMkIyM0tjTjhpZjIxTlpqZ2xYVFU3RU5G?=
 =?utf-8?B?WXZESTFRMmJoaHMzb0p2TDliSGhINTlmUXE4aGhacE00MGJIenZZSEcrZWVw?=
 =?utf-8?B?d25kbmZEV1ErbUxTc2JmZ2tuaWdBcnVFSG9yblhRN3R3djI5TmVMcnJkeEpB?=
 =?utf-8?B?b3dubkEyblQ3T2M2bTJ6eGJ0YUVOOGVPY2JJZ1FnTll1MHZCOHBneHAzQml2?=
 =?utf-8?B?cHVWK055dm9wOTM4bjkrSzNRRENxeUdPUGZvWDlTN1NibGZIYWRLVE9UNVY3?=
 =?utf-8?B?SEw3MXB3M0toSUtoblFIOWJ4bDViQ0R6YmN2TjVRK1RFMXVCcmM2ejVGdHha?=
 =?utf-8?B?Sjg4Qk53WXlxa28xR01nUTRJTytWeEhEL1RpSW5HekhONVFOUUlBRkZoWE1M?=
 =?utf-8?B?TTFQU1kzbFMxTDdUY0VzK0h2dzlLSW41bWU3WUhpNnVORmtKTCt0SGFKSW1l?=
 =?utf-8?B?M2hHNjc3WDlseWowOHdLLzZtU1Z4cFl1VHAzRU5BMkxhc29qOW5RSVlLSlBT?=
 =?utf-8?B?SENITUFRbEROTlZwSWg2OHUxTUZMbEdLMkdxTHlmblhvVmUwZHRDelNmVU1s?=
 =?utf-8?B?RktabkM0MVVOOUpZSVZYN3V5Q3ZyQXFHQ1R6NnR0RkFFWlFOQUFnSW0rNVAx?=
 =?utf-8?B?aE1lbUtDV0FQZEh3emV6Z1JMNlpCbVR6c3lSRHNUcmsxRDNpTVNIM2ZJYTQ0?=
 =?utf-8?B?TzJXclY5dG5aSG44WGhWT0pqcDZDNEkvVC9JU3RLdXNFMWxQTnBoems0QmFX?=
 =?utf-8?B?UmVrWC90c01oczRZT1d1NmYyNnAvaFh0dDF0R00yUlFQdHh0S2VWN1NvdktR?=
 =?utf-8?B?dVhkdGpGNGlVbXdYZzRKZ2NSaklhcXpkVGowRVUyZEl6MkhpcEZEVmgwMUdM?=
 =?utf-8?Q?PyTRYZ3h1vB1E79mClXxlMuhy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a2a1fa-679b-4fd9-095d-08dda1bd0df0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:05:51.4103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Nqnp0kL841bSwg+KTCRZ0MvCWOmTMX++etZnfDsda3Fc2bLCr6ROH3FMdqfVw4H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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

On 5/21/25 05:56, Emily Deng wrote:
> For the evict fail case, the evict error should be returned.
> 
> v2: Consider ENOENT case.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/ttm/ttm_resource.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 097716bd248a..abf104ae9d35 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -511,12 +511,12 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>  		.force_alloc = true
>  	};
>  	struct dma_fence *fence;
> -	int ret;
> +	int ret, evict_ret = 0;
>  
>  	do {
> -		ret = ttm_bo_evict_first(bdev, man, &ctx);
> +		evict_ret = ttm_bo_evict_first(bdev, man, &ctx);
>  		cond_resched();
> -	} while (!ret);
> +	} while (!evict_ret);


We should probably abort here directly when the eviction failed for some reason (except for -ENOENT) and not wait for the move to finish.

Regards,
Christian.

>  
>  	spin_lock(&man->move_lock);
>  	fence = dma_fence_get(man->move);
> @@ -529,7 +529,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>  			return ret;
>  	}
>  
> -	return 0;
> +	return (evict_ret == -ENOENT) ? 0 : evict_ret;
>  }
>  EXPORT_SYMBOL(ttm_resource_manager_evict_all);
>  

