Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EBBC282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 20:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984EC10EA1F;
	Thu,  6 Mar 2025 20:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zar2vM51";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F3210EA1F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 20:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeF4lFJ6cDSCvK3p6tQw+7EQb+8LZa2CcKPYFflWNxUa8tVyjc6hlgZrkg5cr+08ULsOlMp3ungZYNcmUdbzV38do9wYdsFMhdIzUKwDrGu7aYKysJXOJwQq72bX25EJBHdg6C4PRo2qr6h5U7KK8iM6pDhlBJhKF7e+0P2xrDi+fbdWIF3vNBM09dPpmh+2Rj1GPUBNnlJOZZ+EiwH2ecZAt3jE7j4lodXNjgz9+Jzp74cSGvm0D3+9yF1Zo0/UH6T8nHR3BvVgcS61k5vSHbYNxJXpLlgySYmYx7Yr9cGKVZao+Ofk+I5zLEA8Wz7HNeELFv5BZXGSq0AwK2r8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD2Aq70IQYqxkR3ZyzkYwZZ/da3ac3HKFBpJ0hVc/H4=;
 b=n7yxqj9xwjkTrsIsJXrSVQkmMB7KoFVpbCqht/xEOMFMIXBOxYQ7Lx+R7h5YiLLrq92nTTJpr6BbInE4NvFiw1EXEwsRaJmLvK+YLQOgjC6rbdtKiXui7stRglYR2suRMClV07+1L9ai4WzijsWUHJxT57XNr2xF5Ofbm03WybknHD71ZCPpVL21C6ptu+7QDLMnttes1eADPIjeOYrMGK6mpV23FN6Wgxw8Aw1FGLuhkgKoCqrgXMftDz5C5BWXzicnfPPlQ8N2891vDGs5KtEvi3r349GcFQ4a5+k1ZDt+moV/AmURFDptOizzfRxP2qYkMMhpQfz9i0XOPah2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD2Aq70IQYqxkR3ZyzkYwZZ/da3ac3HKFBpJ0hVc/H4=;
 b=zar2vM51q1ZxdH5L88f5m7fIR4eI3Tgz4/f8cFWpsI8L8L87rbRC5IVT5xeJ/XWFoPi0tK9ZBGh0o1nOEd91jo2iLg9aJHsu9w19yr9E5FenbbMGVIgDm4rNpewhzWtNXbmiSznSneEZ3rwnpNAZGqWpDE/WnVlTawHMbBRhFsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 20:44:44 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:44:44 +0000
Message-ID: <b7bb5865-1818-4d76-9b04-0871da124963@amd.com>
Date: Thu, 6 Mar 2025 15:44:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/amdkfd: Set per-process flags only once cik/vi
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250306195227.32765-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20250306195227.32765-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0385.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::24) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ced30b6-29a4-4d33-da7e-08dd5cefb9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blgvazBrR2R2V2JEUTE0SGJCaDFqOXpKUkptYWJKNmNvb3puZWp5S09ueGJ4?=
 =?utf-8?B?b2hyMXJNTG5ibHRSN24zTWxQUlZsVDQ3dThPNys5Ukp6VEhxNk9pUEF2Y2lz?=
 =?utf-8?B?Wk93RkJvWkFLenVNTTBlZXFTR3ROSVJ1NDZudk1BV2VlUE1sSmJQZ0UrNS9t?=
 =?utf-8?B?TitGUEh0SGJ4REVOaC85cHorcnpjUUtOZU05a3J2SzAyWWRoYWk0LzZoeXdt?=
 =?utf-8?B?MUdXYSsxSWtBN3FDeWYzaUlHa2hwem1xOXFZWFJHVFdkWDkrSmZQUTB2SlVo?=
 =?utf-8?B?Nmw1cTZuL205UGZnM0hIMk1VVjMxUHl6T3EwcVNPWk5YWllQL05DRkJQQ01G?=
 =?utf-8?B?aW9EcU9jeFZuanFQQzRMT2tNVGR5bXhUNFMzeE56dEFZT0NCQWJDbUhRRTZO?=
 =?utf-8?B?QWdsaEFxY1daQUlYZnRyT1ZiRytqbGdRQ2w5aHFzRTU1cm9EeXcyeFhtZWxx?=
 =?utf-8?B?RHZrcThCS3E1TU5ncTZLcVFaRHpXU25sb3VrYVhpSE1tQTJZdk9YMFJTbW9M?=
 =?utf-8?B?YklSWTU3UHNrcEd6OTBCYzVUdGw5VVdZL3lERjdES2R3eXNHdGFLbkhjU0lF?=
 =?utf-8?B?LzFCaXQ0Vmk2dkV3R05WVjhWbGdLZ0RCZlpaOHd1amUyUStad0pGK3pEQXVk?=
 =?utf-8?B?UmxwcVhNY3M3Y3AwMTdkOStpUGdZOGRoY0paMFNUS1JmVmU5Qk5PSjBUazZZ?=
 =?utf-8?B?dm1iT3NTNVJubUNYQ1RDNm5NWHc5Y0Jvd1drQ2psT2NyWUowUE45ZlVDNmpl?=
 =?utf-8?B?UDVZMEpJNStHZVBrMDhvek5XU25XNGowMUoxMktDZFN6dkoyUzlGSnVkVGwr?=
 =?utf-8?B?ODR6K1FuY3lOM0R0ZFp5WDg1SWFiSjdpWHJZMlZpWmN5SXdPWWNPQkhLbmRi?=
 =?utf-8?B?R1FhWHJPOUFxRjcwaEJLTjh0Q0dFL0xkbG94WXVIU2lHVUhFRzNNbE9RVGQ1?=
 =?utf-8?B?SWMyanE0TEFmdGdmY1pvU0JJWm5hajNrRGUxZnUzdmFrbEhzZHlCZG0wSmwv?=
 =?utf-8?B?bUg4MnlPcDUrdGNpazQ5MVphdGtRdFVtUlUzdEw4UlVhNnJlbVNlTXFYQVdX?=
 =?utf-8?B?OWdzWm1xN20xVUIrbDYvakJBZlhFTWZHSWFxWFhsMEVsNUZid3ZDYy9GcnNF?=
 =?utf-8?B?bTBJSnNBTnUydTUxNm5QWEFSaCtoWGgxcU56QmxNQU9nN1hsR2NlM3dJQSs3?=
 =?utf-8?B?ZklLZHJnZDhMazREaGZCL0lGV3FibkwwUXR4Q1l5NDVjc0x1OHRJdU55cWYy?=
 =?utf-8?B?elYra3ZxWUxleHI5bi8zYXdtZmtpQUFpQzBVSERsM3lJeTZkV2hFdW9CTUkw?=
 =?utf-8?B?czdPRmsxVzF3Y3B2alpkV2hySWQ0N0xHOFI0bE9vLzM1MW56MTdkVXhaY0l1?=
 =?utf-8?B?OC9reTRPcDlBSEJkdGE2YW1oanloa2Z3c0Q4QnRSeE10TFg3SXNYQktlcVla?=
 =?utf-8?B?K2VHK3p4UW5WZUl3RUx6S1hhdGZPZ0U5K1VEbmRtMjU4RXA3QUEwK2hadGg5?=
 =?utf-8?B?UkFrbG1DbnA4MUFPSUZ2QmE1cVdiempiVkNpNXpQOUhUb3kxTlNBZE1TZzRE?=
 =?utf-8?B?c0RaZDhCVktORkZhb0pleWlPNk5DUnlYeklyYlRKME05NjZXeE53S2RGaGNF?=
 =?utf-8?B?bThSdDlDT1F4cWhucDRkOWtaTThjeVpzaytRUnJTbHN5SjNjcjI0SjhRdXMr?=
 =?utf-8?B?Ly9UNXpyM3pLbXRaMDJOckVBL3JuWmN2czV2OS9ZeFhzaVFzNDlUYUxzMjhw?=
 =?utf-8?B?WkkxbW83aVpSbzRyeGFhQ1RrRHRzck45eS85QTNjUnNBWnQ3Njl3dmdHVm1i?=
 =?utf-8?B?d2FZSjBxWVpJOUNUWWJVczhCSHVIWEMrV2U5S3JrNDRDT1lhWEVraWF3YlFa?=
 =?utf-8?Q?WKwc79lAi8M0i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVZ0UWxOWWhFRG40ZWl5ZzdEZnFGT00vUVVQOTlncHFBSzVlK1lId09Vakxm?=
 =?utf-8?B?SGtjWTIwYktERXRHMXptdFlqNnExeTVKeXN4RUEvUDU1VmpmUWRRNnFkaWRt?=
 =?utf-8?B?SWl5aUhvbHFwWjRlVDBpbTZvWFcvS0ZrWjIyNUdIYnl3N2tqdGxiWHVPbEhy?=
 =?utf-8?B?cFkxVVVHT0xSaUQ4V2tUc3FOZnBjVkpRM0wzVjVodllUQzk3M0pWNW9yRFk1?=
 =?utf-8?B?dGhvM0JKK0FDc2kwblYrVGJNMnRTaDF3TmFKUXVGYVY5QUhsbnN4S2tFUkZC?=
 =?utf-8?B?RGtEaGxSb2NzeiswcFdKSmRmWE5BaWgyZGhEVzIvSVJUVG9NQXM5cHQ4NVJz?=
 =?utf-8?B?TnV6MzRhVW5TQVN6OEcwVEJxdnBjbmFjK2hieHhuZnRpY2RzNUgwdGhFUVQx?=
 =?utf-8?B?NTB0dStPa1puOVJGWURQV0JDaW1yVjgxNllrcFI2eHZMZmFXYmdaa3ZhODZX?=
 =?utf-8?B?QnpMNmE4Uk1sWnBXM1I4YVhhT1VQVktSOFM5S28wOHYyenZMTHBSZzV5YXRl?=
 =?utf-8?B?cGJFOUprRjRjck9qQWR6OHlycVdqZ1NBZ2V6dm9lb1J4Vld1bUNMc2tadXhU?=
 =?utf-8?B?RUhXR0hRQi95V3hRRW0yMHFxWm5nVDU1NnBEN3NaNTJEMGhXMVhMMSs2enkw?=
 =?utf-8?B?SXphQmJYY0J2dDdhaE1wVkRHRHJydDZQMUE5N2dUZXlnQUlVaWtZelZocEZE?=
 =?utf-8?B?SDRQMnlsRzY0RGw1cE5ldmk2YThqK1dHR2M0dUtpMW90ZlpUWEsrV1kzN0RC?=
 =?utf-8?B?bU4rL0hMR2ZzZWtaMEJmUmhpcWJKUGdjazV5UDFBOGYzZWF5aHRGbmdzdXBL?=
 =?utf-8?B?dkViVS9kYzRyNlJzY01KSDQ0dTFLN2ZTakFVdlQ2eGwwQitFYzdjNXgrL3ZI?=
 =?utf-8?B?Wk1kMjFEZU91L0NLY1Z2eTEvZlBOMDYyZnBQWXpYUkZseEk3UXhvN2MyRjV1?=
 =?utf-8?B?TmZTUndENk1ERWdOc2ZoMWpzNUhVRjhjZTl5TmNNcExVVzZiYWZzdEZUeVJB?=
 =?utf-8?B?WmtVM1lDTnh4cUJMTmxlMVlWMkJsYzJabGxCbVBIcG9GZ2ZCQ3hXUDhYQUNC?=
 =?utf-8?B?U1lJUUFVaVRNRUFyTXV6ZXVmUjJkcnpGanI3V3VjNDJPbFdIL0hTc01BU0hV?=
 =?utf-8?B?b0dWQ25aakNCbjVJcndnSFN0YnZFbHUwS2Ric3R1VVJoMEsrSFNybHVoRUMw?=
 =?utf-8?B?ZXc3S2FJM0xXdjNheG5oMjNVMUZiSk1uYmE3OGdHTUxYSlJTaFBHQWllQVJK?=
 =?utf-8?B?d2VSNGhkZnVRNXFRbzZtMVhpNzFnblJKZm1uYzVPZGk5YXU2cllEa2FqdTU5?=
 =?utf-8?B?eVhmclMyQ2tYakRSWGJjbUo1YlFhNU40TG1xcGx5Wk9XVmtjUkE4NWlJNVNs?=
 =?utf-8?B?bjVGRVIwaDN2dVgwRi9hVVhiRHB0bnF1UDEzbU80SWUxbFVzMGZGaGtYZ0tr?=
 =?utf-8?B?ejhtM0R3dnJFWHpHeVc2ZlNLZ3dPYjUvOG44RzVmSnFSZ2VLU1pyN0ZveDd2?=
 =?utf-8?B?MlZsaDlZYW4zTHRrdlhoTVZ0T3o0YzRVSkRnSDd5UDM3OE4rOEdjR1crMEVV?=
 =?utf-8?B?dmF5aElBaGRQbllrUXV3dHBCQkpvV2RwckI4VEZrOTE3ZVkrQS9ZUFY5bDk3?=
 =?utf-8?B?aFdvTGlZbi9TMXVqVTE0Ny8wRXVUVkI2alA4UTdoYjNWNUFRMi9uRGJ2NE5h?=
 =?utf-8?B?L1grUEd5M0IxN3JITU9nM01NMmxXQ3FNNGIzOHlhZFNpUUxmQVJCRGR6aUZx?=
 =?utf-8?B?elgwcGFLNGpGcGFtV3BXSWpWYUZyUU1Scy9xaWdnRDZWNjNtb0FIWC8ydXdq?=
 =?utf-8?B?UFYwVG5Ua1BFTmZvcmdXbGtRZEhGTTVjT1BxcjR2alo3aUVSZkV5UEpkb1hI?=
 =?utf-8?B?ZStra2tvS3p0L2VFdHQ2QkVLMFUzYVdPeHJmQi9YS2h5Z1dTSy9PYTk1WlZS?=
 =?utf-8?B?cndqdWIyNklacUpTNm9OWmNhQkJESWlyOGk4ZVBwUGh5eWsrYU16bXY4cTZi?=
 =?utf-8?B?OUphKzRHdi9uODZ3OE1Wb1ZQallKc1NNRjY5SHZhZDZoemx0QzJKbDJQY2o5?=
 =?utf-8?B?T211RWcwK3MrZi84TUMvcmJMVC9YRFBYTDhNUGtEVWd0dGZmbWRCaGZCK2c0?=
 =?utf-8?Q?BDTO1UAXnZuQUqVtjjFUmF3Hq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ced30b6-29a4-4d33-da7e-08dd5cefb9d9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:44:44.3162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRFTcvt10SABwLE9TPFrxTfcnpOZXnycemY/teoH9M+W44lf+h9dbOsRueaSF3bK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

Reviewed-by: Amber Lin <Amber.Lin@amd.com>

Regards,
Amber

On 3/6/25 14:52, Harish Kasiviswanathan wrote:
> Set per-process static sh_mem config only once during process
> initialization. Move all static changes from update_qpd() which is
> called each time a queue is created to set_cache_memory_policy() which
> is called once during process initialization.
>
> set_cache_memory_policy() is currently defined only for cik and vi
> family. So this commit only focuses on these two. A separate commit will
> address other asics.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 39 +---------
>   .../amd/amdkfd/kfd_device_queue_manager_cik.c | 69 ++++++++++++------
>   .../amd/amdkfd/kfd_device_queue_manager_vi.c  | 71 ++++++++++++-------
>   3 files changed, 94 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f3f2fd6ee65c..d23c6a358d34 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2591,14 +2591,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   	return retval;
>   }
>   
> -/*
> - * Low bits must be 0000/FFFF as required by HW, high bits must be 0 to
> - * stay in user mode.
> - */
> -#define APE1_FIXED_BITS_MASK 0xFFFF80000000FFFFULL
> -/* APE1 limit is inclusive and 64K aligned. */
> -#define APE1_LIMIT_ALIGNMENT 0xFFFF
> -
>   static bool set_cache_memory_policy(struct device_queue_manager *dqm,
>   				   struct qcm_process_device *qpd,
>   				   enum cache_policy default_policy,
> @@ -2613,34 +2605,6 @@ static bool set_cache_memory_policy(struct device_queue_manager *dqm,
>   
>   	dqm_lock(dqm);
>   
> -	if (alternate_aperture_size == 0) {
> -		/* base > limit disables APE1 */
> -		qpd->sh_mem_ape1_base = 1;
> -		qpd->sh_mem_ape1_limit = 0;
> -	} else {
> -		/*
> -		 * In FSA64, APE1_Base[63:0] = { 16{SH_MEM_APE1_BASE[31]},
> -		 *			SH_MEM_APE1_BASE[31:0], 0x0000 }
> -		 * APE1_Limit[63:0] = { 16{SH_MEM_APE1_LIMIT[31]},
> -		 *			SH_MEM_APE1_LIMIT[31:0], 0xFFFF }
> -		 * Verify that the base and size parameters can be
> -		 * represented in this format and convert them.
> -		 * Additionally restrict APE1 to user-mode addresses.
> -		 */
> -
> -		uint64_t base = (uintptr_t)alternate_aperture_base;
> -		uint64_t limit = base + alternate_aperture_size - 1;
> -
> -		if (limit <= base || (base & APE1_FIXED_BITS_MASK) != 0 ||
> -		   (limit & APE1_FIXED_BITS_MASK) != APE1_LIMIT_ALIGNMENT) {
> -			retval = false;
> -			goto out;
> -		}
> -
> -		qpd->sh_mem_ape1_base = base >> 16;
> -		qpd->sh_mem_ape1_limit = limit >> 16;
> -	}
> -
>   	retval = dqm->asic_ops.set_cache_memory_policy(
>   			dqm,
>   			qpd,
> @@ -2649,6 +2613,9 @@ static bool set_cache_memory_policy(struct device_queue_manager *dqm,
>   			alternate_aperture_base,
>   			alternate_aperture_size);
>   
> +	if (retval)
> +		goto out;
> +
>   	if ((dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) && (qpd->vmid != 0))
>   		program_sh_mem_settings(dqm, qpd);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
> index d4d95c7f2e5d..32bedef912b3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
> @@ -27,6 +27,14 @@
>   #include "oss/oss_2_4_sh_mask.h"
>   #include "gca/gfx_7_2_sh_mask.h"
>   
> +/*
> + * Low bits must be 0000/FFFF as required by HW, high bits must be 0 to
> + * stay in user mode.
> + */
> +#define APE1_FIXED_BITS_MASK 0xFFFF80000000FFFFULL
> +/* APE1 limit is inclusive and 64K aligned. */
> +#define APE1_LIMIT_ALIGNMENT 0xFFFF
> +
>   static bool set_cache_memory_policy_cik(struct device_queue_manager *dqm,
>   				   struct qcm_process_device *qpd,
>   				   enum cache_policy default_policy,
> @@ -84,6 +92,36 @@ static bool set_cache_memory_policy_cik(struct device_queue_manager *dqm,
>   {
>   	uint32_t default_mtype;
>   	uint32_t ape1_mtype;
> +	unsigned int temp;
> +	bool retval = true;
> +
> +	if (alternate_aperture_size == 0) {
> +		/* base > limit disables APE1 */
> +		qpd->sh_mem_ape1_base = 1;
> +		qpd->sh_mem_ape1_limit = 0;
> +	} else {
> +		/*
> +		 * In FSA64, APE1_Base[63:0] = { 16{SH_MEM_APE1_BASE[31]},
> +		 *			SH_MEM_APE1_BASE[31:0], 0x0000 }
> +		 * APE1_Limit[63:0] = { 16{SH_MEM_APE1_LIMIT[31]},
> +		 *			SH_MEM_APE1_LIMIT[31:0], 0xFFFF }
> +		 * Verify that the base and size parameters can be
> +		 * represented in this format and convert them.
> +		 * Additionally restrict APE1 to user-mode addresses.
> +		 */
> +
> +		uint64_t base = (uintptr_t)alternate_aperture_base;
> +		uint64_t limit = base + alternate_aperture_size - 1;
> +
> +		if (limit <= base || (base & APE1_FIXED_BITS_MASK) != 0 ||
> +		   (limit & APE1_FIXED_BITS_MASK) != APE1_LIMIT_ALIGNMENT) {
> +			retval = false;
> +			goto out;
> +		}
> +
> +		qpd->sh_mem_ape1_base = base >> 16;
> +		qpd->sh_mem_ape1_limit = limit >> 16;
> +	}
>   
>   	default_mtype = (default_policy == cache_policy_coherent) ?
>   			MTYPE_NONCACHED :
> @@ -97,37 +135,22 @@ static bool set_cache_memory_policy_cik(struct device_queue_manager *dqm,
>   			| ALIGNMENT_MODE(SH_MEM_ALIGNMENT_MODE_UNALIGNED)
>   			| DEFAULT_MTYPE(default_mtype)
>   			| APE1_MTYPE(ape1_mtype);
> -
> -	return true;
> -}
> -
> -static int update_qpd_cik(struct device_queue_manager *dqm,
> -			  struct qcm_process_device *qpd)
> -{
> -	struct kfd_process_device *pdd;
> -	unsigned int temp;
> -
> -	pdd = qpd_to_pdd(qpd);
> -
> -	/* check if sh_mem_config register already configured */
> -	if (qpd->sh_mem_config == 0) {
> -		qpd->sh_mem_config =
> -			ALIGNMENT_MODE(SH_MEM_ALIGNMENT_MODE_UNALIGNED) |
> -			DEFAULT_MTYPE(MTYPE_NONCACHED) |
> -			APE1_MTYPE(MTYPE_NONCACHED);
> -		qpd->sh_mem_ape1_limit = 0;
> -		qpd->sh_mem_ape1_base = 0;
> -	}
> -
>   	/* On dGPU we're always in GPUVM64 addressing mode with 64-bit
>   	 * aperture addresses.
>   	 */
> -	temp = get_sh_mem_bases_nybble_64(pdd);
> +	temp = get_sh_mem_bases_nybble_64(qpd_to_pdd(qpd));
>   	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(temp);
>   
>   	pr_debug("is32bit process: %d sh_mem_bases nybble: 0x%X and register 0x%X\n",
>   		qpd->pqm->process->is_32bit_user_mode, temp, qpd->sh_mem_bases);
>   
> +out:
> +	return retval;
> +}
> +
> +static int update_qpd_cik(struct device_queue_manager *dqm,
> +			  struct qcm_process_device *qpd)
> +{
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
> index b291ee0fab94..320518f41890 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
> @@ -27,6 +27,14 @@
>   #include "gca/gfx_8_0_sh_mask.h"
>   #include "oss/oss_3_0_sh_mask.h"
>   
> +/*
> + * Low bits must be 0000/FFFF as required by HW, high bits must be 0 to
> + * stay in user mode.
> + */
> +#define APE1_FIXED_BITS_MASK 0xFFFF80000000FFFFULL
> +/* APE1 limit is inclusive and 64K aligned. */
> +#define APE1_LIMIT_ALIGNMENT 0xFFFF
> +
>   static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
>   				       struct qcm_process_device *qpd,
>   				       enum cache_policy default_policy,
> @@ -85,6 +93,36 @@ static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
>   {
>   	uint32_t default_mtype;
>   	uint32_t ape1_mtype;
> +	unsigned int temp;
> +	bool retval = true;
> +
> +	if (alternate_aperture_size == 0) {
> +		/* base > limit disables APE1 */
> +		qpd->sh_mem_ape1_base = 1;
> +		qpd->sh_mem_ape1_limit = 0;
> +	} else {
> +		/*
> +		 * In FSA64, APE1_Base[63:0] = { 16{SH_MEM_APE1_BASE[31]},
> +		 *			SH_MEM_APE1_BASE[31:0], 0x0000 }
> +		 * APE1_Limit[63:0] = { 16{SH_MEM_APE1_LIMIT[31]},
> +		 *			SH_MEM_APE1_LIMIT[31:0], 0xFFFF }
> +		 * Verify that the base and size parameters can be
> +		 * represented in this format and convert them.
> +		 * Additionally restrict APE1 to user-mode addresses.
> +		 */
> +
> +		uint64_t base = (uintptr_t)alternate_aperture_base;
> +		uint64_t limit = base + alternate_aperture_size - 1;
> +
> +		if (limit <= base || (base & APE1_FIXED_BITS_MASK) != 0 ||
> +		   (limit & APE1_FIXED_BITS_MASK) != APE1_LIMIT_ALIGNMENT) {
> +			retval = false;
> +			goto out;
> +		}
> +
> +		qpd->sh_mem_ape1_base = base >> 16;
> +		qpd->sh_mem_ape1_limit = limit >> 16;
> +	}
>   
>   	default_mtype = (default_policy == cache_policy_coherent) ?
>   			MTYPE_UC :
> @@ -100,40 +138,21 @@ static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
>   			default_mtype << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT |
>   			ape1_mtype << SH_MEM_CONFIG__APE1_MTYPE__SHIFT;
>   
> -	return true;
> -}
> -
> -static int update_qpd_vi(struct device_queue_manager *dqm,
> -			 struct qcm_process_device *qpd)
> -{
> -	struct kfd_process_device *pdd;
> -	unsigned int temp;
> -
> -	pdd = qpd_to_pdd(qpd);
> -
> -	/* check if sh_mem_config register already configured */
> -	if (qpd->sh_mem_config == 0) {
> -		qpd->sh_mem_config =
> -				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> -					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT |
> -				MTYPE_UC <<
> -					SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT |
> -				MTYPE_UC <<
> -					SH_MEM_CONFIG__APE1_MTYPE__SHIFT;
> -
> -		qpd->sh_mem_ape1_limit = 0;
> -		qpd->sh_mem_ape1_base = 0;
> -	}
> -
>   	/* On dGPU we're always in GPUVM64 addressing mode with 64-bit
>   	 * aperture addresses.
>   	 */
> -	temp = get_sh_mem_bases_nybble_64(pdd);
> +	temp = get_sh_mem_bases_nybble_64(qpd_to_pdd(qpd));
>   	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(temp);
>   
>   	pr_debug("sh_mem_bases nybble: 0x%X and register 0x%X\n",
>   		temp, qpd->sh_mem_bases);
> +out:
> +	return retval;
> +}
>   
> +static int update_qpd_vi(struct device_queue_manager *dqm,
> +			 struct qcm_process_device *qpd)
> +{
>   	return 0;
>   }
>   

