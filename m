Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AC9D12669
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 19:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642FA10E6A6;
	Tue,  2 Dec 2025 19:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MwAzT9pp";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A69E10E0A9
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 19:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKpL/bf8ZPkwR2NnVd3tiOCP5wTns3H0m5rplvbCKs7JX1uIZjJqKY1d0OlfnhubwAAufmXFzV3BN29y05sSvW/pLPVhC48nAp6HdHx/HNFlVoSM0rscYmz8ATsyl3Ag16L+pfAH54MYDU/4QB4w8sQkVAhcz/SnEUH8QvXqPxKqCrrTnLKYULPA1T3IIL/3C/S8+XI4t3LvjUW93uDmaTbGZYSR8BsdLjuEd1OvPV3mF7HS0/ECvTha2hHYAQEGOQ9abMiAZQ/w35ER3N267IkXrklLrcs3HYoRLQLtXIoTPGCoye4JGsq4sXu7FNbmDVczjS5hkEn3MQy1JjIVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jricoUiAZ5mA06mzS0S85oSHBY85tRbKzTWrddW/ls=;
 b=x6kWu7lYxY1vrlNhDG+PyLQ9vmFK4UpIHw9meYATMSkvboEFVrV7HG7rjyMYGz65QwR62+4AWmdxYYhrKlNtBKLZJeD3BITqx6Zo69JYucrlIDUhijx3/KmP+C5i9o0z69WN8p0SI1zrMCiRnPqVZmGhYk8v0GsWfWr+dRp3a80GsNbjxxZxSeRWpoCm8j1xYL+fvk4BJnTemIUZV9dYGoQ0V0lJwy6WvLfbHOY4GW1KUDjjDZHcFM8PFcjQUzzneJZme/FnUOI6Gjj9sQZgXCInhuqLbgmTLtcXO+Q48F/0QwZUd7sDKa9AUCbOvxwwjerT6we2foFBSpAiCUEMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jricoUiAZ5mA06mzS0S85oSHBY85tRbKzTWrddW/ls=;
 b=MwAzT9ppMZH+IwSAfqTXVvpK01NIxMu82gwGSH0JimFbOy7BlIGjijXPlIH0YCxv2S23Xl4galLh+qngVB/OB5UYEBK0v9mF/wIFWP2cQmk0cb7pQ/JIu6WG6qdH4QmBqwAazsH4BH84Xgf5OKqFg6zByytZzmo7P2ShIhQTaGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 19:22:55 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 19:22:55 +0000
Message-ID: <cb1faf3c-f06c-45d1-bf33-da0aabc38228@amd.com>
Date: Tue, 2 Dec 2025 14:22:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: FORWARD NULL
To: Andrew Martin <andrew.martin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251118203419.2528796-1-andrew.martin@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251118203419.2528796-1-andrew.martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dddc7db-792e-4d94-17e1-08de31d831c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVJqOVhpOXNBZ0NlU1VuOU5yeWxoUGIvcFpQNStVL3phSnY1WS8vK2UrK1Bh?=
 =?utf-8?B?TjlQcStUR3ljb3Z0QUl5SmkrVTV1dFNLTXdvUHdlNmR4NmRUOHpBTGpaQXF2?=
 =?utf-8?B?NFpzTEFCM3BRQTF1WGxjd1FKOUY4MGs5azJ6ZkJjUkZBNURqVkNjSXpRL0tH?=
 =?utf-8?B?YW9lbVA3TE5aeHFSSkJHK1hZM3pOd2x1Y3NKZXlkMk45RGw5cUdObmZ5Rk80?=
 =?utf-8?B?QWd0R2YxelZUMW1BK2NoYnkvUXR5ZDNFR1NjcHYrcUZ0Tjg2WVo0WkpoTnBk?=
 =?utf-8?B?QU15T0hvL1ErREZqOUR1ZHo0Q3pQeUIxTUc5VlJqbVVjbSsxWWR4NEJBL1pQ?=
 =?utf-8?B?cE9MM2JscC9rNTRDRHROcmVYZXdjUmxrclEvVWh3MXlpbUF4TGtQQ3hGSGJn?=
 =?utf-8?B?RGZPMzFLdnNtUjFYVW5KbnFsRjRybEdUeEVVT0J3dEVVYlkwenZSUnRvTkxO?=
 =?utf-8?B?Y2ZNMDdmVXdTQ1lIY0RlYml1UW5qYXBVSm0vWE1IaGtocVVuOG9JWlpBaWdo?=
 =?utf-8?B?R2hLQXNjZ28xdVBtME5SdW5yK01PaldYR2NNdTJxcER0VVZWVENGaXpHbVNj?=
 =?utf-8?B?WTZyUXlSOWZCcW1tYm43ZXlWV25xWC95RDJXOE5Gelphd2tkb0pXUEpEUG4x?=
 =?utf-8?B?dmkxSHhJZHRLbC9VdkJtOERBWU9sMytZaXk5cW05amFsU3Z1djVHNUw2a0J0?=
 =?utf-8?B?b25DS2hEWFpGSDQvVVo4SmpaNU9ISURER3BVQkZoOUxZM2pQczJEYWRpWkw3?=
 =?utf-8?B?aEFWaW1qbW9zNmQ1Smd4Qmd2NDVSZTVHbk1QZnVSOFVWVHZHVXlmMkF4WUlx?=
 =?utf-8?B?OW50TWRRMGdyZm8vVktmTHBaV2RZckc1bTlnbE50b0xYNEhMc1d0WEpZZ3dt?=
 =?utf-8?B?SC9RemsxRmw0QWxRUFQxSjhaMTFUMEl5c05VSHZzT0g4K3NzaUNtK1ZMM2JH?=
 =?utf-8?B?Rkc3ZnpFQTZTcVRHZ3M3SWNCRGgwdnBlK0tMVFJhblZDaVIrTlk2MHNWRGFk?=
 =?utf-8?B?aXFhVFZFVEx6U2hPaFFqWXJiMC93aXlLb00yYXZzdGlHM0JaOEc3UFNEZkhv?=
 =?utf-8?B?OEExWVo2Tmo4UEdJU2dBaHFXQVFSSVdHTjJNU2RPaGlyVjA2WXl6R2VLOGhn?=
 =?utf-8?B?eVdDTnp1MVdoSWNsVGs4Q3piVURZSVVsSW0wM1c5MUduaEFpU2NFR0FGMkdz?=
 =?utf-8?B?OVN2L0hJOEFmSzBvclFwdU12TUt0YmxyamdIL1RiQ0lrMUtpQ0llUThKZVJm?=
 =?utf-8?B?N1JzY0R0bHNHQXZrakkxczRhUXBtRGVDSUJhK0lkcUVueFNGaGRrR2dqQWE5?=
 =?utf-8?B?b09IMldvRDQ2K3gwenhGdHZlUDVPQ3AyZHAyTnJyTUI0dlo2YitkVVJqY1dT?=
 =?utf-8?B?ampyQUdDQVRGVUdGeTBYOWtuSW5pYkdNMzJFYkQyS3Y2eUswbm9IN25kc3Bx?=
 =?utf-8?B?aGtNaWgwSWd0ZVlNZjlSR0VaTWMvd0MvdGV0cS8xbUZEamNyS1VSaVFwbEpP?=
 =?utf-8?B?YjVOSk9tbFY0a0ltQk1tK3BFekhzM014VThUS2dvVld3aEZpSWVENWttY1Zv?=
 =?utf-8?B?TnBiZlJRb3FndTBSQjgyTURKM0Z5Mk03U3QyNlNnVkxRaUZjdUc1K3pjMjZy?=
 =?utf-8?B?UXFZNjNYd0p0aEZLTEJweml3dTZjQmczNlYwR2tuRDVHenl3V2pUczMzeHRY?=
 =?utf-8?B?cUExTmw4MVlIYTk0eEE4YktGQ2tCVmNjK3JqVVZ3TllHcFhzVVp0MWh2a0FS?=
 =?utf-8?B?Nk85ME8xK3VaQ2ZhcnhYU05FV2U1V0FuSGJHb2M4RkFwRlB6V0ROZVNIdFJK?=
 =?utf-8?B?QWV1WTBoUk9XeFVmUGN2UVpEeHh5QTlISmRzakh0UEtwcTdJRnpFT3BRRnpk?=
 =?utf-8?B?VEJKZFJhM3pmbUxNU1laekZoWHFpRUJXSnVpU01NN0h5aFRNcFVlNXZFOUg1?=
 =?utf-8?Q?yKADwIhSCciwokqEBXmFYus5tw7A5TYr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9kN2lqeG1FdSsvNFBZK0R6WUxqREtrZURSdWhyOTNmZnRaUDJzYzM1Mngx?=
 =?utf-8?B?eWZzZXRudmdMNmIxbjBBMFNGajY0Y21QQ3R0cjVWam9WVWVBQXY4U2x2S1R3?=
 =?utf-8?B?RktQenhycEszTlFkM3UrUEhjbW9rVDBsSUlkQU0zRC9Bd1JUMGJIUUZrZ1Br?=
 =?utf-8?B?bjFNeE9uV3h1WjZ0cmhSeFdrYmJrL3pmdkZYUXJWOHNHTTBFVysxN0FKVFFJ?=
 =?utf-8?B?U0hEMFJkRVhITGUwQlFIRWxab3g4Z2ovQWQzNTY2QzVRM1lhVElOU1lsdHZI?=
 =?utf-8?B?VGhsL2piSXcrZnZ0NTZYV1M0MWNEczd2R0RmQUZPZDdCckdNMlNRdUo4bE5L?=
 =?utf-8?B?ZTlsTlpRZi9GUzVRNVB1cjl0THZHS0tDVFRZcTdhUFJnemVBd3o1aU9iekpp?=
 =?utf-8?B?U0RTYmJXMnM3VnZxOGJKQTZrcDA3aEpaendxcHVRcEpqQVpGV1cvaGJRcXl5?=
 =?utf-8?B?Zno5NVdob3VIOHk4VUlmUTRQVXBQNWx1N253TitFU20xWU1NVUUyVWR4SEFI?=
 =?utf-8?B?aVRuQ25OQStwaDl3azlYVktNUEVVOHNjS3M3YTlHYnQzcVkwVjh6bDVGalJO?=
 =?utf-8?B?WGF5VUNXb0FpWW02SmNGZXc4a1lTSjZKcE1jVlBVM09IK2UvMHBvZGRCNzRi?=
 =?utf-8?B?MVdON21vTEwwZTNsNUhIbjY1eTB4WUtEaUc2QVIwYnlDL2czM05UV1BVQ2I2?=
 =?utf-8?B?SWNHN1NOQWF2SlJ5eU5qR0Y1ZjNSYWV0OVJHdUR3YUVISU9yV1pKM2ZNd3Jn?=
 =?utf-8?B?L2loZ1JiaTE3bjB1K3B0bW0wNXZoUlR2ejVuSFFJL3V5TkZMcFYvUU41WGU3?=
 =?utf-8?B?NEZjZnZ4bWp0emlDSWhjYjgrNTIvbWI5dnBTSFQwRDBwNkloakI1NEt2WmxX?=
 =?utf-8?B?V0kyRSs3c2VjNzdyZ3lSQ1FMbnlMV3l0cGxndldoaStVL0lyZjRkbnFhUzNo?=
 =?utf-8?B?VkpHRW1aUGxVaGJLTFRHSyszVUhwWUgzOVF2Vks5Ulh6NEVZSWd4MEdwdWps?=
 =?utf-8?B?UWl3Nkh2TWh6bk4rdVFuRzdldHo2VmZpTERBaVJKOUxHSWU1TE5SSHBNYVRB?=
 =?utf-8?B?N3BxY2M1THpPcUFZdHBoVlZDL1Q1NXA2SGVQamUyTWcrNUcxMzJXRFROV0t6?=
 =?utf-8?B?U3RlV3Vwb21hSnM4SmhzdnJIKzF0a0NYTHdKTkpTQlJHaUJPTUVUTU1OTnlP?=
 =?utf-8?B?aDZmampMakY4a2tHejVqTWxJYkZmbTFnb0JELzZHNUppKzBwWFBWbzROZk43?=
 =?utf-8?B?T2tyY0wvZ09WVGU3WHEwWE9adnFtT3FKMWRzbFFaVWlsRzE0NG5aQnBGK0NU?=
 =?utf-8?B?TkRpQUhPTDc2UktMc0YvVFV6c0tReEw0YTM1b0xtTHZPOVlSMkpSM0FNb0JI?=
 =?utf-8?B?MU9jU0ZCOFhRNlpBWXBxZjQ3ZXRtM1h4S3FKMm03SHJiM04rWWZsVjU5RFgr?=
 =?utf-8?B?eDQ3TktJdlpiaThaRG9xUnpLSThKTXVxdC8zd1FYUm00M1VLTVlUcWNRYmZU?=
 =?utf-8?B?TjFqKzlOcmRRVytpT2hFVUp5clJ4NGlPdWlxRldIWVlRTHhwbXRzZDQvcHgw?=
 =?utf-8?B?Wm4zMmJTbGxlTHIzdkV4MUZyWUZaRXBTeEVZWVY1Q2xOcm9UMUVHQzJLWm5F?=
 =?utf-8?B?Nk5MLzhhcklmck1wK3d6dzVNdFVLeXpWRWFITjA5ZHR5OGNGRkFSaDEwbUJR?=
 =?utf-8?B?OXA5Tm9KN25RQjFzM2NNNVRGRVFOTmo3SjM5ZFdSaW00NUR6UXV2S2NPczJL?=
 =?utf-8?B?WWtYRU1SZkxEQUs1cHBOakdHT2p1SGtVQ0YzQUZ2ZmRDWWQ0cnJ2V1NsZkpT?=
 =?utf-8?B?YzMvUnBCUTZlRVF2S1Z2Vkh5R3RVTXA1QXJkekx1LzFTZVFibHdaZncyVjky?=
 =?utf-8?B?eTJReXQvbStoSnE0Q1RWbGRGUlRkOGtwUmwyQTA0MjE4MHdkbVU5U2FMUkpK?=
 =?utf-8?B?Y0U2VzRrT3RyL2dKQWZmeERVZzVROXdIYUcwRzBzSXczbVFPa3VxeE5SRjhi?=
 =?utf-8?B?Z0R2by9nY1lKdU1lL3lza21UU3RLbVBhd2JsOEp0eWpvalJBYlpjbDNLWUM3?=
 =?utf-8?B?eXV6MmJMWXVwZVNlVDhoN1E2MVNKbmRLU1ZieC8rNWo0eVpGRkIwZWcweTEx?=
 =?utf-8?Q?KgGU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dddc7db-792e-4d94-17e1-08de31d831c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 19:22:55.2340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+5D5YOA82EuUDvoAHHPFz4b0FuMM8//SWPItYOgKfCvJ4RS5vgeZr/30+yphefW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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



On 2025-11-18 15:34, Andrew Martin wrote:
> This patch fixes issues when the code moves forward with a potential
> NULL pointer, without checking.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c            | 2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 7 ++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 3 ---
>   4 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 1ef758ac5076..73c5749d4243 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -105,7 +105,7 @@ static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
>   {
>   	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
>   
> -	return fence->timeline_name;
> +	return fence ? fence->timeline_name : NULL;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 4a7180b46b71..c086a9ed8c89 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2357,6 +2357,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	if (kdev->kfd->hive_id) {
>   		for (nid = 0; nid < proximity_domain; ++nid) {
>   			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
> +			if (!peer_dev)
> +				continue;
>   			if (!peer_dev->gpu)
>   				continue;
if (!peer_dev || !peer_dev->gpu)
     continue;
>   			if (peer_dev->gpu->kfd->hive_id != kdev->kfd->hive_id)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index ba99e0f258ae..11af0c1cddcd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -517,7 +517,10 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
>   
>   	for (i = 0; i < target->n_pdds; i++) {
>   		struct kfd_topology_device *topo_dev =
> -				kfd_topology_device_by_id(target->pdds[i]->dev->id);
> +			kfd_topology_device_by_id(target->pdds[i]->dev->id);
> +		if (!topo_dev)
> +			return -EINVAL;
> +
move this after variable caps definition
>   		uint32_t caps = topo_dev->node_props.capability;
>   
uin32_t caps;

if (!topo_dev)
     return -EINVAL;

caps = topo_dev->node_props.capability;
>   		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
> @@ -1071,6 +1074,8 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
>   	for (i = 0; i < tmp_num_devices; i++) {
>   		struct kfd_process_device *pdd = target->pdds[i];
>   		struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
add empty line after variable.
> +		if (!topo_dev)
> +			return -EINVAL;
>   
break out of the loop to mutex_unlock then return

if (!topo_dev) {
     r = -EINVAL;
     break;
}

Regards,
Philip
>   		device_info.gpu_id = pdd->dev->id;
>   		device_info.exception_status = pdd->exception_status;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index f5d173f1ca3b..888b1c24c2a6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1685,9 +1685,6 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	struct kfd_node *dev;
>   	int ret;
>   
> -	if (!drm_file)
> -		return -EINVAL;
> -
>   	if (pdd->drm_priv)
>   		return -EBUSY;
>   

