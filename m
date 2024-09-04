Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0F1CD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 09:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46EF10E713;
	Wed,  4 Sep 2024 09:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GAqV9yHS";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2509E10E719
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 09:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYNyUtnTS6goPX5EM6bB/xzomQssYdAOuNAAlvSp6epGaqZWdk7wsdiBXHGFQDjyv8TaZsluPhQDRDna/JJwzqB7TOfPqypF7eMA94ljrdh14M/hvB0LzsB2QT6C6utOK/oDwCT2gqaBzXIGnYUIE92/H+hQDiJc997UEVuydfQnO57ORHDyjhDLGSIGgLYeSDeYxuOuWSaOfh5uzyObF3sxwAjqJJ9Yooq6Ia8UreTp2rPuZpJrMWy4Q7KtegW5fbbxF9OZyvm8fZgt+COAHzluGeImjk7v/d3AsktnM35UxZNxO7ZfivV6uituWzFNkMhyqCMVOUMaIBQHxZ0/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knVTU6NS7qRzCN8Tq7A0W1jjK70DjzYb4MrX/98mLyg=;
 b=I2uOJW/hbX4MZ+7T9TJYI5DKYHgZZPfgNqpMlWg5KLC+KuPsYxeOoF5pKAfHMT3fhb0k/hBhlWZsfznULPmQzjfrzSRypEKvfYeA+/8J9IpFlxKIiR55VTdlKud4g+Bc7v9dSYj5c/EtI7wp4Wn2mj6mZQcJmwnrJF6t6/0K7atTFTvbbtB3bNNOhL0I6/TlKMoo4JZaRS/MuUtmIkM7rQFj/YhgtkX2ly0/ZOUSG8Xq6rwWQ2JuP2B/m1QL4+kZL82H6BtXdFHCXYr1/a8KDTyQV5zC1YZGRKDDoVKG+xJzVZgezaVfMJFAv3P7RsdWIVg9uSTi9fneF1ON6vk/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knVTU6NS7qRzCN8Tq7A0W1jjK70DjzYb4MrX/98mLyg=;
 b=GAqV9yHSqA3IZtCQBpRkkDdblQi133oqQiq4eXw/9I+28/rDeO3n1x9nGkxm2E3QS/wWt0VoZR9C7X5HqAKBDB41Fq4Mz36li8JCAliSXLwLjXj3xSro23uvaW6RAQvXoFqBniTejMGyROJXUWjX2xtAuBV/n09+9DXRNiGhK2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:36:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:36:12 +0000
Message-ID: <2e452e40-0fa8-4734-aba2-5da053caf5e6@amd.com>
Date: Wed, 4 Sep 2024 15:06:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix a call trace when unload amdgpu driver
To: Asher Song <Asher.Song@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, alexander.deucher@amd.com, felix.kuehling@amd.com
References: <20240904080420.559277-1-Asher.Song@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240904080420.559277-1-Asher.Song@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::29) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7f927b-c53f-4693-335f-08dcccc5038e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEVMejhRMlMyWXhYbFV1YXZ1THlVanY5UTNNT0FFZm5aZkozVExjdFp5cktZ?=
 =?utf-8?B?RTBETUlwRGNnTlc3WGE0YVBncmQ5eWdSc3lRNzhkaWlQeGdIai9UanQ2TjZS?=
 =?utf-8?B?cG4zTFNsMm9KV0VCNjVGTnFlU0o1ODdKSXBySWpybnVmUTA4clVkM05vVldP?=
 =?utf-8?B?TFp3Nk5od0tEMUhPYndvOXlKT2VjVHJCNXI5MzkvSmhYaFBQakJJejBRZ3Q0?=
 =?utf-8?B?b1RtbkpPd29SeEhCTFZvZytqMlYyVXliSzRJOVQ1MjlhL2RlaS9NV0diQWUz?=
 =?utf-8?B?NHA2K2NNM1lxUlhMZm92SERscXV3YjVvSWVDcklMd2luc1RjZEY3c28vd1Y1?=
 =?utf-8?B?d0ErbWludXRRSGQveWJrcEJzN3p0d0VaS1BtSGlCSmV2Nk9kODd6YjBCbFVM?=
 =?utf-8?B?eFp0WmtseU1GTWZsdkw1QUF4WFBsTmF6NWxzYkc4TjJ4amVldDRxa2twK29J?=
 =?utf-8?B?bUNLZkpaVHl3MWxkSVBsZHQwTUZpblAzQ1JZdExwOHB1VEk4em80bGk1ZEpD?=
 =?utf-8?B?QXlEQ3hzR09CUE5GK25ETVNtS2k1TllCWk56dHc1NW82WGI2a01FL0lZUlQw?=
 =?utf-8?B?WE9RdG9DTmhhRDVXWEcxZ0RjYnZKVTdxb2EvaEROd3owb3BhcXhXVStwbEhp?=
 =?utf-8?B?NGJWZTdHOXg4RGU3YlBZTm5OWjdXWlJNektpVzNOR1paU3lTWVBNajMxSkVk?=
 =?utf-8?B?QnEzOXZjZ1ZDbE1RemJBSUQzcTB1em1taUhOMDlzQjZvQTFETDc4ZnVkNVpN?=
 =?utf-8?B?bGZtU09rWWhGUXpucHVLN0xsTG5rOUNTRmQremF3RVk1dFllWVlEZitMdllX?=
 =?utf-8?B?KzBZZHVLeGh5cCthQnJYTTJxaGw1R3o1MytLY0FNZHE3VjUrUUpLQnI5a2tD?=
 =?utf-8?B?ZkRHVDB2VjBnazdSTnVEZTlLNnBqZFVmRFpMNUVxM09GSEF5dFhleUtvQlJk?=
 =?utf-8?B?SUpZMlk5SVhnVjNKTUVkcDl6R284VEVQZmRtNWxDYzJuOUVDeGR4SWwreGhO?=
 =?utf-8?B?dzVxOUt2OHYzcmYrTkY1d29xclhkV01QMys5c2NjNGQzanF0SitZQ3VnS1Uw?=
 =?utf-8?B?WHBlbmRyZVBLU25xSlFlaUpRVEVsSzNiSEFJenU4eWVQWTFNSzRNWHRBVjFn?=
 =?utf-8?B?cWEyVHdqMFFYVWl4RGZTVVE0czhtY3VFZld4NDZPZXBqSHFROFhtRldSRmRQ?=
 =?utf-8?B?dk9UdllnZjQ2RjF5d09RMFNkUlgvL2oyV3kzbDBzUUwydUdBMnJmT29rc09n?=
 =?utf-8?B?QU9pUUVJZjVWTFV4L1RqZTB5ZDR4ajFlMzZtVVBjSEVrQUdMbmhJempCL3Qv?=
 =?utf-8?B?TXE5aHVTOUdSa1FaRFYwdTNmTEt6UVNDbk44cm5QSjhrcEhOb29HOEZsSnBG?=
 =?utf-8?B?Zmg3R2FhRnJCTWtCY0RMV1UrelR0UHRNM3Z0cHVibVRyQUFpcG4xWjdMbjNv?=
 =?utf-8?B?cDVVbk5IOXZDendxTFBIbTJHejI1T21hVzBmWG10Y0NBdUdmUzNibkxVWTRS?=
 =?utf-8?B?Zy9PelJJNlROaGZvS05hZFh6M3JwOUwzdXNzZi9lQzU4OUh1akk1d3NJK0lV?=
 =?utf-8?B?NWVsdDAvdnRoZXNOS3kzZEVqSWxxU2M0YnRyQzdGeVhHanhibEZDaDdsN25E?=
 =?utf-8?B?TXlXcTVIcDIwYTNURldCNFE5eXNhbjJXbVFRbGtLcEVSUGZ1VVZ1YWpiWWYr?=
 =?utf-8?B?eHh4TG1tWjNYT2FpcEVvNHdsUVcxbjFkUGM3ejN2Q3NRTU5Sak9ETkJUYjFP?=
 =?utf-8?B?bURkT1djNk1aNG9JL0lSRWRTbnVmSFYrSmJVcGgrR3FFZ2VyOElGMDFUN0Zs?=
 =?utf-8?B?ZWlhd21yaHMzdnhsbHlBdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXh2QnVXQ0x5NkNlY29xSm9EdmExL2d0RzRtMzFRZUlzaENQNkZibmtIcmhh?=
 =?utf-8?B?NVZHREZpd2FHSmZyZUprZzVvMDYzeVQ0K3lCcXNBbWJGUTRjNGZYTGRNZzBm?=
 =?utf-8?B?a0pjQlMxOFVQNXJsNHBDS2NmZTd3NXA5SVl5YW5ycTNDUWNhK0Ntck5NV2VR?=
 =?utf-8?B?S3JrYkxTL1lQUFdPR0pGR1k5UFg3Z2d4TjJNMFpaYkkycy93RlZjY0dHVzNS?=
 =?utf-8?B?YkhlRnlkY2FEdU5wLzRYMEhYZFcxV1ArNE8wVEYrMVJuanVHejNpZ2MrQy9O?=
 =?utf-8?B?aDBvdzNSQnRBSTI5ZWhnQndaU05hOFNlWWZEWVlrLzNCNm5XOXJKS0gzSnU2?=
 =?utf-8?B?cER0ZDJsM3NJM1lwY1Z5YVpRdldDQXoxMkF4dGRqWDQ4aE1zaFA5OFhSdW9n?=
 =?utf-8?B?YWJJV0pqVFlxbkxwZG0zaFR2UXlxNm0yUGJEbEdkRko1T3FWbEM0WjFQU0xF?=
 =?utf-8?B?NkN3Vld1cTB0WGNsV0hzKzMwdWtPR3BiUlBNWExFWlZWUERaSXhUYmM0L3ZT?=
 =?utf-8?B?Q1NvQWcrSHVrY1I0Mk1qSDhTNUErYVI2RGV3L1d5b1lmaUMxRmVTLzJsN3Qx?=
 =?utf-8?B?dFVEcUdrVVh5TkgzYnhaMTY2WTZXSEd5aUFmS1l5Y0J1dTR5WWRwNnEvTUVQ?=
 =?utf-8?B?N3JrWmJUMTVXRkNVdkU2V0hQdFExcVhXWkNIVlBUaHhWamJFOVp0QXk1Q253?=
 =?utf-8?B?R3FkY2ZuUjRYdFFuaUpxVUx6MXZqN2hucTRyZ3IxQzB2cWZIcW9HR2o2NEcx?=
 =?utf-8?B?bG14UGhCeklOVGhGTVdPZ2hyTktlZUJma1BKdGIxSWQya0l2aHR4TXkzUXVO?=
 =?utf-8?B?djFDT0RNa1BnU1hwVTdmNGJxclcxOXprOVAxckNiRE9uQ0l2YUJaNG1Zd3lK?=
 =?utf-8?B?YUdJL0Q1aEJhU2xkWHYvSGxtUE9RQUdrVHlOWXo3VEhBL0kzWXY0R1BENWJQ?=
 =?utf-8?B?U1dGczFRMnZWb3NRaTdvZTFqQ3FLeFZzbVhTNFcvZEN4T0hacG9UbG1rTmcx?=
 =?utf-8?B?TE56MTlqVnV4Tkpqd2d5Y3BFVnlRLzhDNk5ZVlZ5TzlsaCtEK0hhdmZUTUhI?=
 =?utf-8?B?ZnI3em9nV3VzeEgvUHNMdklQK2ZIaks3QmtVbGl6K2JHK01RZkJPM0JQY21Y?=
 =?utf-8?B?bGJDZ2pNRnpOWEtiUGlTTEM1QlV0OGZMWjJiREV0WHIzR25PQkVsSjU2ZDhK?=
 =?utf-8?B?NDJ0K1dxcVJpeVExYVFORytGdmcvb2VnM0xEeVdJTHVPMnliYkdMMFp0Y2xH?=
 =?utf-8?B?b0tGOVFsa3IyN2JzNnorTlZrckh5TzdVSGhoSk1rVDlBSVJKdWt5cHZPN0JI?=
 =?utf-8?B?ZG8xVDh0UEtKai80ZXlXL1ZEZlJ0dU5uaUNwOWtmZEgzN3VvbkRLdGtFZDUz?=
 =?utf-8?B?Qjk5bzNKNE9lWXd0MC9RUWJMTEdmNitRZW9xUkxTZ0xGRkZ2ZTJQT0lPbXpJ?=
 =?utf-8?B?MmpNVTRpTms1STJoUnNuUlVTMEFiZSttM0h0TCszWGk4SnV5cXJPVEtaZVor?=
 =?utf-8?B?UE9JQ0FWY2hmbVJoMnI0NU13bVM0T1Y1emJuUTBGU283TkV5NjV6NnZObjBo?=
 =?utf-8?B?V3VVd1dFKy9RakYyRHNTRGhYZHZ1cHVWSFBPRjV0ZExFTmxVL1JwaHlCV1lu?=
 =?utf-8?B?dG9xK0h5VVJ4MFdad2NnMUw2d3VjTlZVdnArZXJwNU5Pa0NFeExyVXFFTUw3?=
 =?utf-8?B?clAxenMyL2kyTFRYU3ZOa3NqN2lGS1JYQ3pydXp4SzNXS1hqdjNGdC9vZy9T?=
 =?utf-8?B?bGcvMGRHTlFvbWNXbkRsOGpYMjF1THpKcnphZDJ0Nm9lUHpSTjFxeVEvdDJh?=
 =?utf-8?B?NGxrNkxVbVBkSmllU0RqSVc4MjEwR0lscjh4Uk5PVmFKZi9CbXJKVGJUMlFo?=
 =?utf-8?B?elF0MFpOTzRsL04xWWxvMW9CWVMwMmhmL2dwaFI2RHN4WGRDWFBERE80S3g2?=
 =?utf-8?B?TlRzZ2IxV1NEWlZLMkZLeVhHNFRxZEJtbUVuSk9oOGxXM1dmZEpRVmdqdXVj?=
 =?utf-8?B?dlJEdjY1eDcwblVqZHBtU05hZVhqaFE1OXgzMVp4ZURGODF4SUE0VjI0U0ha?=
 =?utf-8?B?enVhY0pPT1I4N0cvNXdyNUJhZTAvWjJab0tTK1R4WDRnMm9hZTdEcWhKWk1z?=
 =?utf-8?Q?CNFeTyTZj4hcu4ukGoxWttF/A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7f927b-c53f-4693-335f-08dcccc5038e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 09:36:12.3576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oop7PZ/8zej6gPJYbnJ1n1HYu3PuzbSW5QloG0686Y+N0mOd1PB/a/TccsMJY2QY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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



On 9/4/2024 1:34 PM, Asher Song wrote:
> In some APUs, the bo type of GART page table is ttm_bo_type_sg.
> Those type BOs is released by bo->delayed_delete which is added in ttm_device->wq, not released immediately.
> 
> To make sure all the ttm_resource is released before ttm_resource_manager is finilized, drain the workqueue in ttm_device.
> 
> v2: move drain_workqueue to amdgpu_ttm.c
> 
> Fixes:d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Asher Song <Asher.Song@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 5c938ff0bf48..cbac21df5c47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2461,6 +2461,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  		drm_dev_exit(idx);
>  	}
>  
> +	drain_workqueue(adev->mman.bdev.wq);
>  	amdgpu_direct_gma_fini(adev);
>  	amdgpu_vram_mgr_fini(adev);
>  	amdgpu_gtt_mgr_fini(adev);
