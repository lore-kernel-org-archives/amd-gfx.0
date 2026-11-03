Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE0606A333
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=01kc+u13
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D3E10F532;
	Tue,  3 Nov 2026 11:40:57 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6993210F532
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 11:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXtzISzwWYoYkI7Mi/umRcMUyi0aTG4wa/Uz660TJoR7B2QWTKe1ekFDdkpjPv9d+pySO1ceVQrrYiv5peKRDSpPKr99Y4myB5SI3WLE5QmeFYR97o385e5dfI/9wZIgW7zcK2ERnVGhwViE18unn/USIVtwPg4WxhhyfF3+d6Ky8jO85iRjgPOek7AVw6Yfe3i5sG3uCuJaBSDk/+w8n0dnhScbM4ndXtAplF3Yxgga8FKZYYn75rIQjaN8X0Ecl4CZELEG/EGH3W8WPQ5/bGwccCJMloGpi5Sd1/xg04qS1yPUQF3rBfqEcACxrs8XlbZti+5BarFYSZ7oR6R4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrCx35v+W7gAVYC4PHipM7tqsZX7xh7zsif7UekS4x4=;
 b=enYqwXvqj167L1k2yrh0lcUjIARqAy9AOu59GLVZoasZ0vQcW0zHZ0miRibGbjyfXjYZ0PZyH2aOFeb7Y+iaPZTr++EBh7xtKp+vp+DU5aWvQzAgZb5kKLF7lo2RoSMhpfMJdlaNGG/BRf76GVv9RiMhyZM3SUy4diF8XkUCAAjxU5155U7YGV3fZPjQG7MGIxDW7yPl8QxU14s91aw/qz7PC0rORBQ79vyriLXpi/CyVD36+SQlJD9B9KD8pNfTNxt9gDsT5o5pwPnHRHNQwN79eX9tXYBr4Atr30LuzVIstMVSz/nbk6hdDWvxPbxseG2NKks1W4fJt4OGjB8Lzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrCx35v+W7gAVYC4PHipM7tqsZX7xh7zsif7UekS4x4=;
 b=01kc+u13fzYw/l+U/MoMWseaO9eI7s+wIf7Hn5Bk5PTRj4BgJoZNCTVvy74kw+KT6GhsFFyv2INT2cuxQG4wGzj2/TorbecV/mC5ZR58nvukDBbzihWcKoOjzaYPKCKRctbrD7BOyssXRX0nRDbOyXW63gQ8XAtVirNNt3vvjOQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV1PR12MB365848.namprd12.prod.outlook.com (2603:10b6:408:50d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 11:40:48 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 11:40:47 +0000
Message-ID: <4bf11762-a54d-4850-b7d0-4d77ac1916ee@amd.com>
Date: Tue, 3 Nov 2026 17:10:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: time SMU metrics caches with ktime
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, Kevin.Wang@amd.com
References: <20261102122128.961804-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261102122128.961804-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0218.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV1PR12MB365848:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e32c029-7525-4929-64c3-08df399f4d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|261102130727099003|56012099006|261022105027099003|261021123027099003|261026140227099003|11063799006|261026121527099003|261028144727099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: nKZYUi34Z2NUU6NQF+fB4Gk5GOQGquZ/Bspfz3ez65nuetIuTzWAnCjdWwriFmTt4vziqxwIuyF9fIlbS1X9XRfTKuOy+9QZC1qXZpX0ycBCDf22oA4wvtAs5Pd8r3PBYSXi2twLbS+0k6UYQslGyOo5/rhxbw1zC9wScjbrLc1fPQQ4hV49LzZd1RRMHltP9+xYCUcTyo6AjwPe99ZVrVEm+79t7/h9892WwAF8/71hOZ8hU9vb4f7jZubuPbcTP+QVnSy6L3X9x3mPmx/Ssn6h+IrmBa6Zb/tVxoHhz3J7kvVeMsKCCLxKJ/4c/+HnJmXML/Z20P7hhL9Up+Ga7UdAZuOCTkZzScnragy+IRX1ZDtj919WMjXzaj6ep5xBn1OIpXZzGO4OuU//dzFj7UJiChrhfn41aRRoAAh3zNd4+lRKumK1Qd8NvHsyIuEliBEDOOIna+kSKoKFs6iiXg27ErN9ehYUIFiL1e2/eEB41RGFaxHIIAZzlieeyWZ5EgCqMAzHmA3U0yuTLTkdbY8s2qdtvwGPW1KGuAuFQoZ+v9fpmF/Zac9G/qKjUnG5utf3conq8XmM5SVNNzDc+Aja4ZAuKQc7G4d6MmnYWoCzMN8Lojeqdryj2JmguBN/GPbLqgovX9tLPJxdZKQOOf2gHYhMBK4kKjVT92LsOd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(261102130727099003)(56012099006)(261022105027099003)(261021123027099003)(261026140227099003)(11063799006)(261026121527099003)(261028144727099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjdHVG1lVzNMR3lvalNlMVBpYUR2NHNRbk9saXZEVzZsUDZRZGFBbU9qdzA5?=
 =?utf-8?B?WVRleGV1ejhPME5jS1A0elVidXF5UXgreGVLZnJaRlpnK29RMXkydTFwazRM?=
 =?utf-8?B?bHJtNXdIWFlGZkhXdGJua21nTmZyNXRSdmFoNWFOVk50MjVhU1Ava0wvRnp1?=
 =?utf-8?B?ZXJ0ck5ZSmNGSERpNHZtMFRpb3FNdFdOUWJVSGx5RkRrcmNuMmFiLzRFM2hu?=
 =?utf-8?B?b09EdWdaRWU0WE1yL2tWbEhGRk1TUlovODNSbWg2QjBNcGRrYWFxcld0bjkw?=
 =?utf-8?B?SzMzQkdnVm5sMXdrVVg2dkI5VlV2WURBRXg3eEp6NnR2RDQveGZNWWVvcTFT?=
 =?utf-8?B?ZmpBbnE3cCtFUldza3pDUGN2SUtXL3hjajB2RDEwSU9vSmw4QU9qQ0JIZG1z?=
 =?utf-8?B?SU9DcE5QYzI2WmNtZldwKzFhZ1pwek5oM3V2ZURSRE1oTjk4R2tqSTI4amJZ?=
 =?utf-8?B?cTNiZXJvNW93d0kxY0J0U21kT0QzenFBOGNPOTZvelJWVEI1TVVtVjI0T3ZC?=
 =?utf-8?B?TGU0VlhKWmozMkJucG1SbEVaYUdjcnhhVEhobkk2ekIyZjlWZk9JNHdZNWp3?=
 =?utf-8?B?bktSa0NWa0JkRlJPQ0J2Sy9TckdGbnBwUWVOWU02QlMrNm1raEQ2dzl1cjBN?=
 =?utf-8?B?MGxRSmRvdmhJYkFvYVlKNFRuakdVQW1ySzdZbUFVRStGLzJRdUQ1b3J1WDVO?=
 =?utf-8?B?bFE4aVZNQlBZaHdHbDNtRlI3RDlMUG1tYUNkUWRHMVI2dVpPcGhsZXU1UDds?=
 =?utf-8?B?Tk9LMnphZDFYYjhNUU5WTnhUbnVPYUwya0RjK3lXcFp0WldGNjU3bVNRZGZu?=
 =?utf-8?B?QkJtQTBIamdJSkViTi80THB2a0VCRUp4RVFxTmR6SDEyME50M1kyRmtxVHFQ?=
 =?utf-8?B?bm9ZbS9UNHlsMndwc0FLcXFjMlVLMW5EcitTN1B2UUYrR1kwZzE2YXQ4SFRT?=
 =?utf-8?B?a0hPWmxLME50Y1o0WEE2RkV4Q1cwMHFxbTJDSFVVcXRINmF5RUhvT0tEMUJY?=
 =?utf-8?B?SzFpMit4OC80YlRuT1NHbFRrUDdnUnFhTTJUdU1qalJEdyszZy9HbU5wMkMw?=
 =?utf-8?B?dTFjZm1TTzc2MVVublZ3UUo4bkpMcGFhVGh5Z1Q1Sk5HeTFRcjlTVkhKSXln?=
 =?utf-8?B?Vk1FMXVSSUpvUUl5RW5tNVNUZlZ4WW0ybDd5d20zYUh0d0RRcTZNQ0V2bEpr?=
 =?utf-8?B?VWxNZ2EwUmFSQzRsdUtEWEk5YjFZd2RldlprT0VDVFlnVTZYb0ZlejZnZzVX?=
 =?utf-8?B?Q1dYYlNIVlJPWWM2bWREa1o5SE1VWTVZak5SaTlFaVFiMHI0amFTVTlKTGo5?=
 =?utf-8?B?cWp5WlM1Mko5NXNjUDhxRjNKL2daTEI0ajZVc3lucHY4S1VObnFLSC9FMzh2?=
 =?utf-8?B?aEU0ajVkYTlJcWM3cFpUNkgrYkRBb1pKMm13MmhPbG4rU0JrZmcyL21ZVGp0?=
 =?utf-8?B?TS9MK0s5cmU4Y1NEUUVNelorbDRQN3YzRkdQdGxXc2dvRzYvSW1uZU1WalRH?=
 =?utf-8?B?dFV3aTJWbXgxcTFXRzh4YTNONkU3YXRqMWF3c2xZUk1oQ290Z0VzWXA5dGN4?=
 =?utf-8?B?UW9PQ1JFZEtHZDArTnhkZkYwQ1pvZXdlUFVyb1NFcXRHM2l4YmppUzVXNXZO?=
 =?utf-8?B?RGh2N1JaQUY5UlZqaW84Z0JHelBhYnR3WnVLVy93aDlkZEZleEtTQ0lBdldw?=
 =?utf-8?B?cjlDRXhkMlFMZU9OK25kN3lXb1AzTVBRU2toM0ZkRVRuTmJCVDhJbUdNL3Bs?=
 =?utf-8?B?REJxU1dCdnI2ektoQ0lFRm1Jb1dzUDIwT25sWVZJSWNzUy9KOUhNbVJEZWk5?=
 =?utf-8?B?NHd6Y1NkUnNmUUM5bVZSMEgzNEdoeG1IUjB4NWdwaFFnQUJQRVpsMVVpd0di?=
 =?utf-8?B?ZlJKdXhLNDlkUkJJSTBEQWNHSWVNRk1TUkQzeFkwUHZDV055QlFJcVd4MFli?=
 =?utf-8?B?R1NkM3dIWGl2K1ZjUDViVHpNaWlVZU9VdHNrYUhEa1FoOU4yOHNJUlFGa1E5?=
 =?utf-8?B?TDI2UGxDbXQrSE8yelBQYVdLanlvZTVDZXNoRkFsQUJRb3crNllYb3JXZ2w5?=
 =?utf-8?B?akQ4Tk9xUEZHeTdNTFh6bDMvdjF0Y0xqUHBOeE1ZWUs1MjhwaWozK1pyQzVl?=
 =?utf-8?B?MUZrOHY3VXBLNXN3OWpGT2MyV3luYjBaUitkcS91YitvczI4Q05qT2pwTW5m?=
 =?utf-8?B?ZUlwY0E1dDlTSDQzK1h0RXVvSUNsMkxNdThMY0xyU1BqREtyaHdDVDBSRld3?=
 =?utf-8?B?NHZjYmVNampqVGlCcGdacHhwU05Ya1BacjZNdyswYkpoMy9HVExiWG84WnpJ?=
 =?utf-8?Q?J1CI8sYKj70FC6yWeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e32c029-7525-4929-64c3-08df399f4d50
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 11:40:47.3967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxfhGR/x4Tom/4trycPZ4H0DdzdmOpGUq2NrOPVtw5n3AStZnbJCPjMe53k7i9tf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB365848
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 02-Nov-26 5:51 PM, Asad Kamal wrote:
> The metrics caches store their interval in milliseconds but test it
> with jiffies. On a HZ=250 kernel msecs_to_jiffies(5) is 2 ticks, and
> time_after() keeps the cache valid through the end of that tick, so a
> 5 ms GPU metrics cache holds for about 8 ms to 12 ms. The same rounding
> turns the 1 ms raw metrics-table cache into up to about 8 ms.
> 
> Stamp and compare these caches with ktime_get_boottime() so the
> configured interval is the real interval.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 38 ++++++++++---------
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  2 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 +--
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  |  5 +--
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  |  7 ++--
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  5 +--
>   6 files changed, 30 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 9d47d2ab1b49..5ad50a304168 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -31,6 +31,7 @@
>   #include "dm_pp_smu.h"
>   #include "smu_types.h"
>   #include "linux/firmware.h"
> +#include <linux/ktime.h>
>   
>   #define SMU_THERMAL_MINIMUM_ALERT_TEMP		0
>   #define SMU_THERMAL_MAXIMUM_ALERT_TEMP		255
> @@ -275,7 +276,7 @@ struct smu_table_cache {
>   	size_t size;
>   	/* interval in ms*/
>   	uint32_t interval;
> -	unsigned long last_cache_time;
> +	ktime_t last_cache_time;
>   };
>   
>   struct smu_table {
> @@ -403,7 +404,7 @@ struct smu_table_context {
>   	void				*power_play_table;
>   	uint32_t			power_play_table_size;
>   	void				*hardcode_pptable;
> -	unsigned long			metrics_time;
> +	ktime_t				metrics_time;
>   	void				*metrics_table;
>   	void				*clocks_table;
>   	void				*watermarks_table;
> @@ -1815,22 +1816,26 @@ smu_metrics_get_temp_table_id(enum smu_temp_metric_type type)
>   	return SMU_DRIVER_TABLE_COUNT;
>   }
>   
> -static inline void smu_table_cache_update_time(struct smu_table *table,
> -					       unsigned long time)
> +static inline bool smu_ms_cache_expired(ktime_t last, uint32_t interval_ms)
>   {
> -	table->cache.last_cache_time = time;
> +	if (!last || !interval_ms)
> +		return true;
> +
> +	return ktime_after(ktime_get_boottime(), ktime_add_ms(last, interval_ms));
> +}
> +
> +static inline void smu_table_cache_update_time(struct smu_table *table)
> +{
> +	table->cache.last_cache_time = ktime_get_boottime();
>   }
>   
>   static inline bool smu_table_cache_is_valid(struct smu_table *table)
>   {
> -	if (!table->cache.buffer || !table->cache.last_cache_time ||
> -	    !table->cache.interval || !table->cache.size ||
> -	    time_after(jiffies,
> -		       table->cache.last_cache_time +
> -			       msecs_to_jiffies(table->cache.interval)))
> +	if (!table->cache.buffer || !table->cache.size)
>   		return false;
>   
> -	return true;
> +	return !smu_ms_cache_expired(table->cache.last_cache_time,
> +				     table->cache.interval);
>   }
>   
>   static inline int smu_table_cache_init(struct smu_context *smu,
> @@ -1906,14 +1911,11 @@ static inline void smu_driver_table_fini(struct smu_context *smu,
>   
>   static inline bool smu_driver_table_is_valid(struct smu_driver_table *table)
>   {
> -	if (!table->cache.buffer || !table->cache.last_cache_time ||
> -	    !table->cache.interval || !table->cache.size ||
> -	    time_after(jiffies,
> -		       table->cache.last_cache_time +
> -			       msecs_to_jiffies(table->cache.interval)))
> +	if (!table->cache.buffer || !table->cache.size)
>   		return false;
>   
> -	return true;
> +	return !smu_ms_cache_expired(table->cache.last_cache_time,
> +				     table->cache.interval);
>   }
>   
>   static inline void *smu_driver_table_ptr(struct smu_context *smu,
> @@ -1938,7 +1940,7 @@ smu_driver_table_update_cache_time(struct smu_context *smu,
>   	if (table_id >= SMU_DRIVER_TABLE_COUNT)
>   		return;
>   
> -	driver_tables[table_id].cache.last_cache_time = jiffies;
> +	driver_tables[table_id].cache.last_cache_time = ktime_get_boottime();
>   }
>   
>   #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 1691a0be4f7d..7d1594a24431 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -485,7 +485,7 @@ static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu)
>   	if (ret)
>   		return ret;
>   
> -	smu_table_cache_update_time(sys_table, jiffies);
> +	smu_table_cache_update_time(sys_table);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 95e288327e45..01110afe8502 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -750,9 +750,7 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
>   	struct smu_table *table = &smu_table->driver_table;
>   	int ret;
>   
> -	if (bypass_cache || !smu_table->metrics_time ||
> -	    time_after(jiffies,
> -		       smu_table->metrics_time + msecs_to_jiffies(1))) {
> +	if (bypass_cache || smu_ms_cache_expired(smu_table->metrics_time, 1)) {
>   		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsTable, NULL);
>   		if (ret) {
>   			dev_info(smu->adev->dev,
> @@ -770,7 +768,7 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
>   				min(16, table_size)))
>   			return -EHWPOISON;
>   
> -		smu_table->metrics_time = jiffies;
> +		smu_table->metrics_time = ktime_get_boottime();

<nit> This update may also be put inside a wrapper in case we need to 
adjust the timestamp type.

That aside,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   	}
>   
>   	if (metrics_table)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index 1004c5d59728..5e6fdbeb2f41 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -361,8 +361,7 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
>   	size_t table_size = metrics_info->table_size;
>   	int ret;
>   
> -	if (smu_table->metrics_time &&
> -	    !time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1)))
> +	if (!smu_ms_cache_expired(smu_table->metrics_time, 1))
>   		return 1;
>   
>   	if (!cpu_addr)
> @@ -386,7 +385,7 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
>   			      cpu_addr, sizeof(MetricsTable_t));
>   
>   	metrics_info->active_idx = !metrics_info->active_idx;
> -	smu_table->metrics_time = jiffies;
> +	smu_table->metrics_time = ktime_get_boottime();
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index c778091a4272..c2a956a78b5f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -358,8 +358,7 @@ static int smu_v15_0_8_get_metrics_table_internal(struct smu_context *smu, uint3
>   
>   	mutex_lock(&smu_table->metrics_lock);
>   
> -	if (!tmo || !smu_table->metrics_time ||
> -	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(tmo))) {
> +	if (smu_ms_cache_expired(smu_table->metrics_time, tmo)) {
>   		int ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsTable, NULL);
>   		if (ret) {
>   			dev_info(adev->dev,
> @@ -376,7 +375,7 @@ static int smu_v15_0_8_get_metrics_table_internal(struct smu_context *smu, uint3
>   			return ret;
>   		}
>   
> -		smu_table->metrics_time = jiffies;
> +		smu_table->metrics_time = ktime_get_boottime();
>   	}
>   
>   	if (data)
> @@ -586,7 +585,7 @@ static int smu_v15_0_8_get_system_metrics_table(struct smu_context *smu)
>   	if (ret)
>   		return ret;
>   
> -	smu_table_cache_update_time(sys_table, jiffies);
> +	smu_table_cache_update_time(sys_table);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b0abc2f504c3..417e988c361d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1230,8 +1230,7 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
>   	int ret = 0;
>   
>   	if (bypass_cache ||
> -	    !smu_table->metrics_time ||
> -	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
> +	    smu_ms_cache_expired(smu_table->metrics_time, 1)) {
>   		ret = smu_cmn_update_table(smu,
>   				       SMU_TABLE_SMU_METRICS,
>   				       0,
> @@ -1241,7 +1240,7 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
>   			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
>   			return ret;
>   		}
> -		smu_table->metrics_time = jiffies;
> +		smu_table->metrics_time = ktime_get_boottime();
>   	}
>   
>   	if (metrics_table)

