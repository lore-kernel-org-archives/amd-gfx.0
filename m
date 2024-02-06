Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EA7C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 21:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7602310EDD4;
	Tue,  6 Feb 2024 21:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pR/p2JQi";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16090112E6D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 21:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4CbrW/7r2AFv11bU50YA17NEpHSru42jJh6i0y4rnY5+YdkK+9bKhxyBwz+bo36ozM6pKy/TPTc9DeM1SYGZXmFkK3tpC5nO2ZiEN5LryQw9l0jzQsgqdCDfku2MqmrTPjk0HIUSDcaud1XKboVzrnS4lCM+VpBBeTSjN5akhab4k8ElF2o3BIfK0pJPidcDR1ZHDKPMcRFHbli9XKAAbgybLsQEb990WUeDS4nOltyll64sMQt1nmWMK56rsvsVxw6PdnELOQ3OUiYa9aOb6ko0F4NPd9iPqrTEIVSCdWYWuv9Ri8MmlI5XHQkeGALMcwZSlFtha7cqZgTF8IOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+6mlUkgtU/kkX2FeCSpmXWpp2Rw/TamWnWFXOjTL/8=;
 b=dqaJbOsGl39mF76rx4aF7fbupqlvHO9CxFOpwx/1uF6jwXRltHRCGI/3A5otVfTH0Wt0t75jdJ13jtX+hE/LK0XRz8eEQo1BLdEtt5ArSN1uHRbyn9k3UwpcmXYlTKxVAUq2hccv6Hbei9F1wmlVjBat4lm3ZgzrTqZ3BySCoZyjTaeHst1HoTZbNfKTI7c8NDPphnqR2j5QaIFTnDCbRGO3XNU6LVEovaKtKg0mN6IJI8lA2gtKfFbJQhkmWbpaMvPelMySHEfIoT66FnlCYBXtsAnTpnnPBnyC3MMEETEUQvmfyJ80GiCch8DxfsrXtpNX1XLWxwBUZnZrsLw6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+6mlUkgtU/kkX2FeCSpmXWpp2Rw/TamWnWFXOjTL/8=;
 b=pR/p2JQi7i7rIt4I1r0Uomkoq9VaWqF8QHwXAY/jknpC8RxjxPSC7xtCViF58FSy47Ku18VtaOLda1/mpP+WKqQsr78lCdiZhLEnG8ChMc9qWPYCY1RDef6jVkXGkohcU8NZK4D67/1xq2/kOyv1wHy+7yDPihdYK9CVUwlUMSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 6 Feb
 2024 21:28:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 21:28:51 +0000
Message-ID: <63edb1b7-06bf-4051-ab4a-d9cf205f19c0@amd.com>
Date: Tue, 6 Feb 2024 16:28:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't divide L2 cache by partition mode
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: mukul.joshi@amd.com
References: <20240206212418.629528-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240206212418.629528-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af97a60-31cf-4ba0-ec89-08dc275a9ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /A+u7mvGz7q6+G5R9Pp4SxFU4Rv3sSRgWjE6PDwaH7uZpSIBjWOGi5gsXv6tIWeE7j6ap9ld4Gjg7bvI81uJQZmwbBVZtKf3Mt7i6eHBSPZJRmM0VSrrnEt0e8eZFR0kfviiyL5afjTyfwKwb8UD6e3sqUhXP/NA/JXy0RV7ktTW6Au7waUAAXZkY7aQjzOsMjp2qf4UDrhwGLl7J4NvSq7sI8cE88lZZx1gmSjfyX7ae744S5m2wkl7RTDzIEAJAiOPnQs79mTgIjn+64pVIi0T4RUwJ5lcQVcxAHRVp5lLfNNRhqWpNz05GhoG4Nl+mfRUuZdemQeSXNfupoIOFqH6vho8kMQfxlrgKWWHmyaRdT/BzzqLdxWiGN3zL94vhjbgPghyi9QQVkUuQJWKLoMi9ZoW4/JD6Pu1biOzin114Fe9JDNU9flDBZ5e8gw1QyvXQzf4wNmoCtQw4fcc/JSFsaHOHpJAa2d33B3/iiuzpdGrEMSgmCGKLNuSoUsNO9ikhed1Po+GIiGhSWJ80nw+RR2rsnh1xblPsxPqj76/uxHipRQpujpRAGWRIf4mBbQq29NKKk9CJotDVXXqqldVQfQ3guqlZ/IFef8Tpnl6FkxO1Cq1SUNynjFd7tDMEqSo5i70M2O5VIb3tI0+OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(53546011)(6512007)(86362001)(66476007)(38100700002)(26005)(66556008)(316002)(2616005)(478600001)(44832011)(2906002)(5660300002)(83380400001)(66946007)(36916002)(8676002)(4326008)(8936002)(6506007)(36756003)(6486002)(31696002)(41300700001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEp1aWlEL1Y2ZU5icDRMYVJEcHFmZ1YyelU1c3U3czJ2K20zT2tzVHFKL2Rv?=
 =?utf-8?B?Q1BweWIvOE5OT0NPNDZYWGVWOHIvQjZPVVRCaDd3RUltNmJ2MXYvVFZwMDBF?=
 =?utf-8?B?ZmVWSXFqMUFUQmJHUi9TZEtpbHRjNVF2eFo2SXN1U0JVVm9yUGpHWkpXTUdx?=
 =?utf-8?B?OTVYUnd5MDJiSFJhd1d4dGdsaHJCbTBuU0ZKTWIwZXRPd0p6OEFSbFozT08y?=
 =?utf-8?B?YXNiREhXclVWV0pxN3I4OGFaQnZ2VWN0YTNWc01lTjFnOXhPS1doSldBVndW?=
 =?utf-8?B?K1NPcXVMK0lNTXRzcXYxZEYwRERHWURBSzVoTmkrSmxIaSsvczBkRFQyVFVl?=
 =?utf-8?B?M2hzbXhYREVTOWZXb0psMVBPMVpyVDg1dWQrNldZSXdqY05qYVhtaDBiZWZh?=
 =?utf-8?B?ZHJPbzczKzZJOTZSNUhjZk9PVUN4VXJJeWtza01QcFNRU0pDWWRiNnF1eUFh?=
 =?utf-8?B?N0J6UFpRaytmbWg5cU5lcTl4VTVKZzFTZm83eVJxbldQZUgxcjZRa0JiYnhx?=
 =?utf-8?B?YWdRaURiOXRQaWxrL2Z4QVB4MitxRkNOSzVTRzJvT0c5ZjFpbzNEekh2SDZJ?=
 =?utf-8?B?bDdrbm1QVlUzMUZzamY0ZDhMNDZ2V2ZMWEFmakIyeXdLQlMwSVl4SFA5Z3dJ?=
 =?utf-8?B?OGJwcXUzOGJVc3hOYmMxQVBsQmN1UXhoOElBU2FtcTF6alMvVUFOdk10eTEr?=
 =?utf-8?B?R2todTVDSUY1aDRsdGxNQmVyTkFNWjB0Rzdyd2NnZzdNbTViTDVLakUvS2M3?=
 =?utf-8?B?bU1BMitFY2sxU3cxRjI2dzV3V3N5d1NONGpxZW9PeGIwUCtvRHY2TStMWFFX?=
 =?utf-8?B?dWVyTnlLcUxBSG10T0o5RkJHZ2hNNDN0bnFRQXEzZ000MXlDZGR5RUQzVzBC?=
 =?utf-8?B?eW96ZFVOL0txMFFyOUl3YkM5dTRaYUc3WC9aRSsrRnB0N0swV3NzNnpxbS8y?=
 =?utf-8?B?alBNM0xjQzR3SjFMTDVKT3l3a2RlUi9LL1VVZEhDR29hcUJMUU51Sjdhb1B1?=
 =?utf-8?B?U0M4WHNDbDE1dTdDYzJqRjliYnUwTDUwdUtrRXl6N1NCeDFMZ05oY3JtY2px?=
 =?utf-8?B?UnV0K2JDOEV6WnY3eFhyT1Y1ZU80Q3lrMTNDRTlGUHY1eHBGeVJML1Q5cngw?=
 =?utf-8?B?V0tFRXlvZ1JGMkpHZHhLUHVDZ3ZhaS9Rb0J2QWc3MStOSEpyQ2tCR2UyeVkz?=
 =?utf-8?B?bS9NUzdyRDV2OE5UdFJ2QW4zWEt3c25JOUNobDJkVWFDWnZPTjVEYXNCazlY?=
 =?utf-8?B?bnl3aVAvZE5WUmRkZnZsb25BSHV1NnU4bXRWdTk4Y0FnWE91YWNXRHJ2ZDJ0?=
 =?utf-8?B?UTdJYVdzbTVFMW1rVVRwZVVPZVpJL0hRMHlhWlpXV2xyVGpwc1ZqQUt6UzE2?=
 =?utf-8?B?bERTeS9KeVd5NXZtaGN5UjI5SVJaSGRkTHFkcytWN0FCSGRRRVZqQ3ZjN2h1?=
 =?utf-8?B?WmxIOWI4TnhiT25PYjRXN0dTc0FXcHhWeWJTMk9WNTFGUXJOc3ZPTzZhQVp2?=
 =?utf-8?B?R0dvYTlwd3prN0RwczBvS0ZzYkFBR3VnRkQ3RDRpczVQaUt6QWtnODVtU2Rr?=
 =?utf-8?B?WjlQTnY2clh6UVlrblFCMmZGdkwyTFJXVlpRc3NtYzNkMXZTcmNFUk9JUkNH?=
 =?utf-8?B?Um5XcVhEcy9aRU0yRW4xNGM4NkQ4VFdBcTdkSGNpeFVVQUxGMjhVUlp3SURs?=
 =?utf-8?B?Rm5pMmZMN0p3dnJaNThTUXRsOVVaenVRb0hPcFlBd3RFMWRpTDhMemxYWFM2?=
 =?utf-8?B?Mi9DRjVVOHlOeXh4d1hKRzBNQTJWWUVGL2xHaDAzbzNJWER5aldDc1hPaUw0?=
 =?utf-8?B?V1IrNWJZRVhOVndab0xsWklBNEFRUXhMaVphRWd6OFV0eDd5cDZKMEZIYmxY?=
 =?utf-8?B?b09sbTc4VlNpRWdIZi85enZha0ViMERDc0NPR1JnZ1lLcFlCejFNM1NBZkRO?=
 =?utf-8?B?VWM5Q0lqWnNGdlNaWnlOQUhsbVdkM3Y4YmR3TllpMGVvYWRXUlkvZzJPVEhj?=
 =?utf-8?B?Zk1iaFl0WWdxd0ZjV2R3NXd2SWtRZjZEWHFsc09HQURsenAwWWpxR1lLaUlJ?=
 =?utf-8?B?QitZNm1waTBMRkptbUoxOHRLUnhJMm1kbDlzYkVQeSsrMS9jN2JMc2V2UVVV?=
 =?utf-8?Q?NO9TNJL5rN3dqm5dvR+0tGWZh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af97a60-31cf-4ba0-ec89-08dc275a9ca8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 21:28:50.9766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubv5KTn85+oUD96ujAGEEamY2wD9saN1acMd1HyjX4UFrQ5p6VOjlaTrZ6/oFXmIvWMmjF+IQIQkMaWcveSycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186
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


On 2024-02-06 16:24, Kent Russell wrote:
> Partition mode only affects L3 cache size. After removing the L2 check in
> the previous patch, make sure we aren't dividing all cache sizes by
> partition mode, just L3.
>
> Fixes: a75bfb3c4045 ("drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3")
The fixes tag looks wrong. I can't find the commit a75bfb3c4045 
anywhere. Did your previous patch actually make it into the branch yet? 
Maybe you can still abandon it in Gerrit.

Regards,
   Felix



> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 64bf2a56f010..533b8292b136 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1640,10 +1640,10 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>   		else
>   			mode = UNKNOWN_MEMORY_PARTITION_MODE;
>   
> -		if (mode)
> -			pcache->cache_size = pcache_info[cache_type].cache_size / mode;
> -		else
> -			pcache->cache_size = pcache_info[cache_type].cache_size;
> +		pcache->cache_size = pcache_info[cache_type].cache_size;
> +		/* Partition mode only affects L3 cache size */
> +		if (mode && pcache->cache_level == 3)
> +			pcache->cache_size /= mode;
>   
>   		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
>   			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
