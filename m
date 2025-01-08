Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1607E7719A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 07:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C6510E276;
	Wed,  8 Jan 2025 07:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DzwCqE6F";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F79A10E276
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 07:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JP/2+alVIMmZs0cObSxFPZcS9YdcWxQtE1GJaajpiTpSdgfzp55ypdz1kallJ1VtLjuU80UnDuy9OdHpVFkzGV6tEcwf0NrnmJ2A3X1A4M/rs7MAe3AJ1JKcUeUiRjfKEJyhmizY/LrrF20T3bY0B2lF/httVulOlz+9pjtjdMd0SuNs7kxJPSfjAf7SD+qXq1xZgcu2nW9BxCFRhDodx0jLtcdd3AnezMXJP1VeBLQDRxqOdc0TEFSquOmjGwrQv5WOm3kOlb+60NFdpVrOPCL8QSTstA79w7Zm4y2pec7FaKAM2VsLRK8aAvyD29fSnOJnx+8/OMMXam3UjxaeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGD5Fs/95SpxlC3tSE/5s/abGCIsO7Zv1rU7bAPkGd8=;
 b=pypLeS9O4rDiAT1ACOZ4eMzn5H82u4dH+17z2fAH0Z3iU02anbvGtix42/ON8fCyhX0NDYoV91qfU1FPiLTtqAuG4pP+8uHZxkJ+mRAnIiliHOctFGWNbOl6eEvjsGeChzPEjwL0AYRv6UrzqMsxmDIugLVZr3/K8bg/l2nwU0Su4nuYDwOqAWwXwofDGiYxyWnCFCr2SIU7KknKLC9vRqNuTJ3y4wRDDXLEp3OeldlW70QIguCLywWPJ7WQHcmedFNJMQ4E9NE2zKdS7yXZPvai7UIUePhqwT47sS1+uV9SN5S5gPWzqw9EGfV5yQMEist0eR8WhUPmW9WoUGKVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGD5Fs/95SpxlC3tSE/5s/abGCIsO7Zv1rU7bAPkGd8=;
 b=DzwCqE6Fsv25E/qMroOCx6F5jjtUzZP9YcUNJgmswlUbJSMyXQTNBBbNDpKnzLEYha7+aEU3zxMEetq3FIeOeNIRyQ2KcbzthtMmAANnu90P9gkyrUdriUVk9jYF7A0ZTOW1H0inK6mmv8Ugy/tl0ufrRkVf//uT8psjZg8Pozw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.15; Wed, 8 Jan 2025 07:20:32 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 07:20:32 +0000
Message-ID: <42ef8811-ace5-4d5f-b29b-43f060ca7d60@amd.com>
Date: Wed, 8 Jan 2025 12:50:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/pm: add the interface to set and save the
 bootup workload type
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: aurabindo.pillai@amd.com, alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20250108064752.131717-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250108064752.131717-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3fe20d-1c53-4e5a-2569-08dd2fb4efff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTgwb0ROTjFyQVY4WFJzRW0xR1JGREIwK0hTT0w4K2piVkRocDl1cUZxRnNw?=
 =?utf-8?B?cEoxblF5YVBWMmtRQ1VKZlJaTVREYlE2TWo3aVJuR3ZTUmdvWDluUjFmV0lv?=
 =?utf-8?B?bml4T0pPV2dmYUF2ZjNDOWExdTVtclNEbUlrdDdHK084bktyTFJtYmhJalhH?=
 =?utf-8?B?UlN3THlRZ1ZGVVJadFdvR3dzY0xrb2g0UnRXejUvRndzNkExTmd4Wm42THZS?=
 =?utf-8?B?TmFKR0VPME52bHpxNXZYdUtSTjVINTNqdldXeW83QjErWndOU1VJbkVmVTVS?=
 =?utf-8?B?OGEzTDNpVmwzZXNmZ2RrOFdmY1RjdDdFRWVLWURJOWo5Rng4VnNNdVQ3dVpL?=
 =?utf-8?B?ZUVkbng1ZmJTOWdJV29CUG91YTNaQ2tqQXEzd3hrbHlLeUV5cDRHQTlhaXMr?=
 =?utf-8?B?bUZ4RnQzUjA2eWRIUFc0MTBSN0NZSU42eVdjU2pqL01WWmRvazBaUXhRRjlk?=
 =?utf-8?B?VzRNeFJUa0dWVmY1Y1c0eFFBZGllNWx5ZG91Z1ZWZHhGUzNIbitKQ1hDUmJ2?=
 =?utf-8?B?c2hMS0JnSDZTKzV5R2hta3oyVis2TC9STTVpUjU5ejhYMFBtbFJacHlWRGcy?=
 =?utf-8?B?eTgrRkFsTWNGUzNqUmtHUzl4SGZkRlFOZmxyUjhCZlkrUlM0QVM0ekpYRDUx?=
 =?utf-8?B?dDE0Q1Y3UW9WZG1BVzUxMlNraHlWM0N5VmlWQXlYZWxFRmVVWDBYc2cvaHF6?=
 =?utf-8?B?MkxxRG9yOEFCcjBrM0tFUml1enZuRmNZR2N5djRpc2lsbXJiVm13U01LNXRB?=
 =?utf-8?B?NlBhbEZuRjdTUlpwV0txcXBsUUI5cTlwbjlwZC9XVWJYeW5qMjdIL1oxbjF2?=
 =?utf-8?B?d0hISkJLT2wrN2hLTlRrZmJZOUJmTUF3MDBUYVZrakROYUluYnlyZVAvVEtt?=
 =?utf-8?B?OFg5dXBJNlBmWThFK2RkQmFaM1F0STNyc1RPMnRndkRLNksvdkRKQzdnbU5N?=
 =?utf-8?B?Uzl5R0tLaDFPSDVYdkFEQVZMQXZRejd3TkIvREtkSUpRZGt2ajFQaFl0ckta?=
 =?utf-8?B?QXllcUJ5bFNLYkFLT2lRVTRPN29McFJhMGcxN1phNHp5V2ZqVVNCakNHaDNy?=
 =?utf-8?B?b0VNaVA2dnFWQk5ZTTIvOVF3cW03V3RLTFRxblptMUIwbzEwZU94enZTeVZN?=
 =?utf-8?B?MEpUbzZXYm9PQzlyM1RQU1JqNUNYV0tFRGVzdi9JQ3p6YUFWbWFwa3U1Vjh1?=
 =?utf-8?B?UmNHUUpicW1qRGM5dmtiMXBIZEw4a05QUGJSOXVuazdlT3FsSnhrdlVjUTlO?=
 =?utf-8?B?SVFWQ3Z5NG44RURaOThWWXgrbXk2UndmdVQ2dUJBMVBQUi9IdTQvcFNBUmcw?=
 =?utf-8?B?QUFVVUxVckxZUytWbWp2UkVHTnJacExBRTR1ZzNyMmI0ckd2R1ErazY3MFFl?=
 =?utf-8?B?cFVPd3EwSXpablFWVlVWN0NPdXF4MXVhUW1wZ2VsaW5mT1YycVRVUUVGVWxx?=
 =?utf-8?B?T0ovSVEraVJaWWRyRGt0QjFoUE1TTC9NOGpKdWUyeThEQWV5Uk50SDNqcTly?=
 =?utf-8?B?a3h5ZmFDM1piVk5lQWY3cVEwTmhxUWh4Syt2eXhKYWxJZXIzREZSelhMV1lr?=
 =?utf-8?B?NXRybnZhcG95SVpGNTBMMjNxSmFQVVcwM09MZVhUZTMra242N0NFWlAvOE1W?=
 =?utf-8?B?YnNWNUtwTVVIdzdoaWtHYm1mMUEraHgxS0E2bkY1eWtjcW9JcUNGTXFkOG9u?=
 =?utf-8?B?SkRHc0JzQ3F2bWtwOGdZT2h1cERZRlpldTRuTVJ4dHMwVkR2TU15NGNmbW1q?=
 =?utf-8?B?d2NUL1VOKzlnRkpRRXp1TElCRUJBU04xMEZaYnFKWGtjYzd0K2JiWk1TN2pt?=
 =?utf-8?B?OTAyWFQ5UkRNdms2VFhPeTZmUXVOaXJhTDVJOGpDUlNSWXRsVFRJbHNZcWI5?=
 =?utf-8?Q?vCo3YJUO+pYU9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGNzeG1sdW4zSFlEUkU0QU9Qa3h6ZGFuQXZ1WnpNZWtJWFRTRm9DS1NxVHlB?=
 =?utf-8?B?ZzlwSUhtTVEyTG9PNW5FSmxpczdGaVd2T3F1QnJjV1NzOGhQQi9HSmREeUx4?=
 =?utf-8?B?UmxxZHl1SlJPU3BjMy9nNGpta094NXZMYVZaNUo1ckFNQ1lVdlNNSmdGTEdy?=
 =?utf-8?B?VkxuMUZORWhnUTVnZFo2RGJneWp1a3c3eHpVQmNJYWkwdGFmdThSR1l6bEZi?=
 =?utf-8?B?N2pqTkJuV21ER2ZxYVlXWFpueUk0YW1PREhHZ0dwVlM0Q3FobFk1V1lYOVlu?=
 =?utf-8?B?R3JnanhlUWp4MnBNMFJyeEY1Smh0cEV1ZTNkK2tlMkM0cVc1ZjFodW96RGdN?=
 =?utf-8?B?RkpWOXFTLzJqMGUyYUw2em9SblpmdlpnOThKMzNsN21BR3Q4d0U4YUxnMHpo?=
 =?utf-8?B?RHpJa3BDVEpUR0U3ZjE5VFo4L0tYbUc0a2loUEk0cWRKZkt4dE9VREsvb1RP?=
 =?utf-8?B?WGg4Wmdxa2NhUmxCbVNzV1hzRC9EUGppeGUzM0RLdUNIN3loOVRUUEQ4WG9J?=
 =?utf-8?B?Y1JybnA2cDZJOUNYbmlpVTIyd3E0L1FyZVlMVlFzZmZvNmhOaEc5VWJ6Y0tT?=
 =?utf-8?B?UXBZeTVmUmNNZzJGbGg1UUJrWHF4NkNEc2ZKWDRlMTdmcEQ4Z2U4UG0wSUtC?=
 =?utf-8?B?QVNEblZuVU1EWG9NQldlTHBLOFltT1hET0o5bUpMV1R0Yk1RclRZUWxhREVm?=
 =?utf-8?B?Tlg2RzR2QSt4ZGtKck14YTBoRVVCOVlxQlpSdWJkQ2dRbWh6QWpyODZ5d09s?=
 =?utf-8?B?aThuZ3E1Yk04bHV0aGlOL1h4cjBoWVM3REZ2MUc2MGh6MlRsZE5vRXZ5bkZu?=
 =?utf-8?B?Y2xPWlk1cmt3T25tYTcwQkZadXpTcm4zaWd1Tlk4WkZGVFMzZmNXdXBETnV0?=
 =?utf-8?B?UXFDTHUrUnN1UXB6VVFPM2ZvR1YvMXUrMzE4eE43ZklXY3p6bnE4Z29BTXpJ?=
 =?utf-8?B?VTdPanBycjM2ZUx6a2dJK0Y2TDFEVUM0eXNxOEQzQnhaWGVrdlliRUx6L1Rq?=
 =?utf-8?B?K0htSnpEZ21WalVCNHR2cEgveUMrWHNQMUNVbDJqOVpSRW1SQUx0WXYvODBQ?=
 =?utf-8?B?amVHOWE0ZlVYRlBIeTlkUEpqajJsQUdMSUZPcTdBQlMyVEF4YlZ6MkFNc1M4?=
 =?utf-8?B?dU9VRGRodDFJYWNSUHhsTnNqQzBRSW9oeUZnd0Z5b1pwemZMNU1sMXkwSHAx?=
 =?utf-8?B?Y3dMRlp4T1Z3NWRWRVhQc2NpeTl0dzd4bDhwQkFKbHZDenY3aytvdFdxRFhE?=
 =?utf-8?B?djVlTXp1SE5mNzhIcDU2Z2RGcXJnMDE2MklZbFhUajZFbC9wS1lwWElGbmNW?=
 =?utf-8?B?N3ZwOGFudVF1akNIRVVZWit1Mldkcitmc2hrMktZUnZCb3ZOU01GY0xMV1V6?=
 =?utf-8?B?QjZxREpLTzFIZHhuWjRwN1BleWUxQ3dCWGZFeXR5Qjd1a1FidWN6L1pZMjhG?=
 =?utf-8?B?RnMwTEo2SW5VRExiWFplNTN5TmRzMktZS0UrNE5JYklvRGpZTGowN21sVW1P?=
 =?utf-8?B?UGQ5KzZZRmU0UFJBOEFZNHk0cHhrd0tOeTE4UkJRd212MTV4cWd4d28vdGNo?=
 =?utf-8?B?UDhlMlBLems5a2N0MFRyK0cyNUJiMmd6bjVNUGJ5bHAvSjdQN01vanNWcWZC?=
 =?utf-8?B?ditwQSs3ZDdXMWtlemEwY3NCLy9oT1VEZmlDcUtEV1pIdWYzOHBQRklZR3VC?=
 =?utf-8?B?N2RpRFNkZjYxNDVTMkY1MlQ4Vm4ybHY1VmxZQ28zcHEzWnZLOWlBRmN6OEJF?=
 =?utf-8?B?dDdsdUhBZ1FsRnVKZTh1MXMrWnhZaUxkVG5XaURNNXNtOVZMN25QTElRa2N3?=
 =?utf-8?B?Y3Q4L0VXZUNGTnBUYWcwZEpNUkJYRkprejJRMkdZVWtsZ2x0eWhpNXFVZGgw?=
 =?utf-8?B?UjFEK3ovRG1BS2I4a1ZBa0tSUW1ZaE9VQVZUR0VHbkl1dElMY1E2cG1EalRW?=
 =?utf-8?B?R1hmMEVyaGJyVmVLVnRoTDN4bXFUTzhVeXJ0djZxWFdia1U1UU9GY3ljUW81?=
 =?utf-8?B?WU45OEZvZnJsWFlGNEE3eXJWaFhWaFpzRWJ3K2NjVnFPQTErZmc2YXRNQVNQ?=
 =?utf-8?B?OW5SMnB5T1QvcDRZRWVyeHVGMTU2WjYxNFdRTVRvRkZsc29oN1o2TEk3SmVB?=
 =?utf-8?Q?3r7LI2H1ThZhO1tCZ34LN7eZu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3fe20d-1c53-4e5a-2569-08dd2fb4efff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 07:20:32.7209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMugbeetcaRC6AUqxOVu/0HthtlJA5QbE2k0i/uhqVh1lI2hpbfwZSF1OB5TJKEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
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



On 1/8/2025 12:17 PM, Kenneth Feng wrote:
> add the interface to set and save the bootup workload type
> v2: add is_support_sw_smu check and pm mutex lock.
> v3: return before the scoreboard is set.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 44 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
>  4 files changed, 49 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 6a9e26905edf..e262c972d0f7 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -349,6 +349,50 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
>  	return ret;
>  }
>  
> +int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *adev,
> +						bool en)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	struct smu_context *smu = (struct smu_context*)(adev->powerplay.pp_handle);
> +	int ret = 0;
> +	int current_profile_mode;
> +	int saved_profile_mode;
> +
> +	mutex_lock(&adev->pm.mutex);
> +	current_profile_mode = smu->power_profile_mode;
> +	saved_profile_mode = smu->saved_power_profile_mode;
> +	mutex_unlock(&adev->pm.mutex);
> +
> +	if (en && current_profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
> +		return 0;
> +
> +	if (!en && current_profile_mode != PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
> +		return 0;

Does this mean that user may be allowed to set a different profile after
function is called with en?

> +
> +	if (en) {
> +		ret = amdgpu_dpm_switch_power_profile(adev, current_profile_mode, !en);
> +		if (ret)
> +			goto out;
> +		mutex_lock(&adev->pm.mutex);
> +		smu->saved_power_profile_mode = current_profile_mode;
> +		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;


With the second patch combined, the whole logic is applied in generic
layer and may not work for all SOCs.

The default power profile mode of most SOCs is now set to
PP_SMC_POWER_PROFILE_FULLSCREEN3D if supported.

If driver internally has set compute/video profile, then disabling them
reverts only to default init mode which could be 3D mode. So the
assumption that power profile mode is back to bootup default is wrong in
such cases.

If no profile is set and when passed with !en, it will disable the
default init profile mode and workload mask will be 0. If user has set
another profile, it's the same behavior where workload mask is cleared.
Not sure if that's the desired behavior for SOCs where 3D mode is set as
default profile on init.

> +		mutex_unlock(&adev->pm.mutex);
> +	} else {
> +		ret = amdgpu_dpm_switch_power_profile(adev, saved_profile_mode, !en);

I guess the intention here is to enable the saved profile back and !en
doesn't do that.

> +		if (ret)
> +			goto out;
> +		mutex_lock(&adev->pm.mutex);
> +		smu->power_profile_mode = saved_profile_mode;
> +		smu->saved_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;

If it's always assumed to be bootup default, what is the purpose of
saving this? Again, why is the assumption that boot_up default is the
saved one?

Thanks,
Lijo

> +		mutex_unlock(&adev->pm.mutex);
> +	}
> +
> +out:
> +	return ret;
> +}
> +
>  int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
>  			       uint32_t pstate)
>  {
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 1f5ac7e0230d..5fe404bbb033 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -410,6 +410,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
>  				    enum PP_SMC_POWER_PROFILE type,
>  				    bool en);
>  
> +int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *adev,
> +				    bool en);
> +
>  int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
>  
>  int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8ca793c222ff..a6f748361198 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1272,6 +1272,7 @@ static void smu_init_power_profile(struct smu_context *smu)
>  				PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>  	}
>  	smu_power_profile_mode_get(smu, smu->power_profile_mode);
> +	smu->saved_power_profile_mode = smu->power_profile_mode;
>  }
>  
>  static int smu_sw_init(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 3630593bce61..c58fc31fb1d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -560,6 +560,7 @@ struct smu_context {
>  	uint32_t workload_mask;
>  	/* default/user workload preference */
>  	uint32_t power_profile_mode;
> +	uint32_t saved_power_profile_mode;
>  	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
>  	/* backend specific custom workload settings */
>  	long *custom_profile_params;

