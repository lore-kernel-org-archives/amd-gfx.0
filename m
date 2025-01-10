Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAECE7719D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 18:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E994B10E516;
	Fri, 10 Jan 2025 18:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BJD7ib01";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6373310E516
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 18:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiT2GsQDX2ZaeUyz7qp/ZkuInzt8Rd+/H6JLsvJx8R8rw8cu+pZAVw+f3yj1lERjXZ/Ojx47xaZ4BRIWo5BzeCqmn4rTC34p98t4J0PkjALjTW54LdxW4lPQH8cY2ipyDkpXi3+Y4IrPJ8qD4W06dlR2FAFFFOVvMxtxPm44Z/FIKOM4PFZeP60W6nMEKStYcVqzlIGbnV4Ldb3qvsieHu/UQt+C6ZCUUnBLlXedhprFeXgCSZfhXEAtifpKs+7IKcdBNNMEVqOWgY0gXxA/QOnhiNQ1Sk8LKAMC6jLtygFiBsae14xocV2oCKu/eViy77Hh5A35MQiBq6xogB/soA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3takXH/F5T983BisTGGJ36xWUbEQpUPLE4hCHHi1Qvo=;
 b=HoDYdvwlJAgAe9qnJIbCHEkcO5PT+0zMlSp8F1HM9RaqEIkMN+qjf4KVaphJT3fV6QPKupXsYTBtmNVnJwLq/nz0eGeTNLp0e/5w/ePD8l5HQHAOA2ko02YWbetBAoj9JQt24ybmlTQ5pLLYzgPOb5fgI6z9Tptq6m+p9UdWyENp/oCgEClQhdtjhKr8p9FVeOyvxAKw9/+ykvsiIF24kjS9+Z0eQzdlQAFvKgXKYMcVIoI/GC2YhSER/7pHjFmzivO1iT7YtQ1tUi7+ddAVNyUjsXrWi5gCOp3WLXWPFBV/0GWvafvpdc+WdCNiTIil5diQ02Ao1Za415sxVeEfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3takXH/F5T983BisTGGJ36xWUbEQpUPLE4hCHHi1Qvo=;
 b=BJD7ib01sZWI8ZsUScCi3Q5vctSGDpXftQ3DAwtkNFHl+Qnwhd0Ir4k5ib0UtZRRcanK5g1vHZQopeBUAr9zPL9lGw2+CO0HkpFPYoiSy4B3LhorVefvVdvVJRQPXraq+sbwZOq/VruVwlqxhYs+C7d+TW5LQvN7yRbzLsMQrRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 18:42:02 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 18:42:02 +0000
Message-ID: <6e25fa71-0421-4695-a1e3-57ce30410ca1@amd.com>
Date: Fri, 10 Jan 2025 13:41:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Add additional i2c buses
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::43) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e543e93-260e-4079-2f29-08dd31a678e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVI3WGltTDAwcnc4bmNVRy9NaWRuNWdaRko0aVhYY0dCNDZoVHdDdkJlVGRR?=
 =?utf-8?B?Z01PRHh4eXV6akpZQjJQQ0wvQXlTMGJZSmNJYVBSb3VhTWNuR0dvY2dtdytN?=
 =?utf-8?B?TUxDQWIrMDVnRGw0Y21hMGt4QkJ0UWhHS1RmUWpNemZzYi85blhyeUg1aXoz?=
 =?utf-8?B?VWVJV3hjQ3BZYzF5ZWV1YUZnVlcwZFVkemNmOEkvM3BxN3RTYTB1aGtzTHFv?=
 =?utf-8?B?WE1vczBPU2RkRzViek1oSW15SllVbk13MGIrNjhSL2gxWURMM2VTQkZKVXNq?=
 =?utf-8?B?QlNGU3hRQ2JwamVURXlOcVVnMWNpYkRUN0I0YUN2YmtmNTY2d1dKNnNlV2lM?=
 =?utf-8?B?MGpyL3RyYTJ0OUdTd0NpeVhxbFhBanhGSHdlUWhmMVlhekNNQ3NKcWw0dEtY?=
 =?utf-8?B?Tml5RWJMVCtvc0V0VkVpSDJMMXROc3ZmOHFjUThpa0lycDV6bnowbzFyTHZY?=
 =?utf-8?B?V3Y3elZwWjlEMThGL2tPQ3JWRVg5V1hKeGJaNFhLZXhjZGxVS3JubWZ2b0ND?=
 =?utf-8?B?YVErdXlHSFY0M2FJL2tqV2tydEdCZ2NCcXljUmlVRmoyRUZmeDkwSkp6NEpt?=
 =?utf-8?B?MnRIWlVUOERIekRjZ2xsZy9nNWNjb2dGUHdoWS9qcGJFalBNQitRZVNLNmRl?=
 =?utf-8?B?aFVLOUxrUkx2RmR5Wk8xNnFibUhDMU9VVmhEdVBoR09JVWMwd0gvN3RGd0tk?=
 =?utf-8?B?SlluTzFFR08xVUFXZnRjdzF1eU5KbFlDcmwvcTFqclJEaGJFdUNFWFRrSFZK?=
 =?utf-8?B?ZkhFTDdqeWJQdG5wYy9vMzIrQytUWCtnSy9oOXIxRGo4cnk1Z2VqMlRoNmJZ?=
 =?utf-8?B?bDZzc1Q3OTF1ajhiUVBHdEdYaS9mcjZ0Rlp4bTkzT2EzQU5xK3ZuUC9mekZj?=
 =?utf-8?B?a3poRklUR0taUjhWbVZmcGlrcU15dEpWL2Q2R0JPVWloSVZsendNcFBmR3Bm?=
 =?utf-8?B?YXl5T1NLNkNzTEdMa0tPMEdyVElJWGxLNDJUdFNYWDY4cWgzcmVuVThiMnlo?=
 =?utf-8?B?WndxQklwN1dlK2V2d2VkK0YxNy9zcWFDU3NHV1V5RW16YitGWmVSN1RCeG1F?=
 =?utf-8?B?LzBhNENMRlNkVjlubC9iNVFnd2FidTMvK3hUeW4xR29OQ3JLbnp4M3FNNGRw?=
 =?utf-8?B?QTd0M29BQnExUk1XVklDQ0lqaVB5NkNtV0hvbVA5ZnVjV1E3ZGNzcm5qd1Zk?=
 =?utf-8?B?Y0JUc1hkZTh3Vi9WdGhJaUxqNTg0VFB1UnN2Mm44ZXVGYm5EMkRqS1JLeGxv?=
 =?utf-8?B?cXRYU2FWakJrV01sdjNjQnJ4Vmg1TlVNTjU3Tnd2ZW1rQnptaW9pNzQycHpo?=
 =?utf-8?B?cWZGNldtNU1nN05md2x5SU1XaklURXExZVJ2bVA1MXJOMk5ROHFyWnRGMlNU?=
 =?utf-8?B?TUduTDJzdlphQzg3RURKeEZMZ0JESzRNOU9PNU5uTUNwTzczUkp0dHZ1ZTlS?=
 =?utf-8?B?cWdJZjhZN0tDWUtmc0M4Wmh1blNvOEpWa0FNcitKTkRZMlVTV3dNakhiVHU5?=
 =?utf-8?B?RkdaZ3ZZZnZlUDBvREFBWHV4aElKUzdzbkV6UFJVclVZTXczM2pTT2NFdjla?=
 =?utf-8?B?Y21lYVptWWtBYU91cWNFbTBRQ2YwbWhlZ0xMUVBobWYwbzFJRlFyK2QyVDJ1?=
 =?utf-8?B?QUZYSnBPSXRGUzBodElyK3NaWGo5WEhCREI2aGYxZkZBd1BYL2RleE9ScVVq?=
 =?utf-8?B?OUNoMVVvR1lTbVRER3V5UnhIOGphdy9rM0NIOTkzYUprQkpLbVJmYWtQV3dw?=
 =?utf-8?B?QW5TYk4vd1hJbSs4V3g5aVphVlFhQ2ZUUzlrTHloaVdlT3lNb25kVWZ5VEMr?=
 =?utf-8?B?SSt2MlFJMEhIUWhQZ2hSWU9WMitqUE5yRitNclcyS2daMXNUWm1kaVFkT0gr?=
 =?utf-8?Q?wtp2/q3S69Iig?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBhbnJ1aXNobkhHTE9uRnFhdTlXS002amM0NVN4SEhIalcveXZzb0x1VzVQ?=
 =?utf-8?B?V1lJMWxGQ0RKTENPcGtaZlJOYUw5N0MwTURlOUZUWlVhaklOd1Zha1Q5anhn?=
 =?utf-8?B?SEtpaTdRNXh1Qk9sV3pwQWxybXV3ZDVOdVlUMTg3R01MTW5ud1ZkSTBrb2hR?=
 =?utf-8?B?ek5uSDRQdzNnb3piOXBQVFdBRkhiL1NNNDlKdCt4QlZBZ0hkQi93MWlieGI2?=
 =?utf-8?B?RDl1ZmcwcmYvc2dIUmFDTmxoTWJMSFF0M21UcElKV0tNd2drNEJMVC9IWmJh?=
 =?utf-8?B?alVGODFFRHVlR3FsT3FSdUhCb0psOXpFZEt0S0w4dVJxdXFPSWlxdmx5N0hq?=
 =?utf-8?B?QVpORWRGbkM2S2ZuNFJ6VzV6bTd0cnRGbWsrYUEvWVFsL2kzYXQrbkZLanJk?=
 =?utf-8?B?SVl3bGs4TnY0L1B5d1Fja1MrcHdMWnVEbW1PTEpPWHhHaDZOaGhkNDRPbzZO?=
 =?utf-8?B?KytZV25ZRC84T3NOUlV0aW0rOGpXQnl6MzhPMS9xYnd0L2cvSVdHemRyVitC?=
 =?utf-8?B?SVRTc3g1SkNwRlgxL2JjaElFZFRkU2d4L3lHUzVreHd4UVRSeFNvMEdiRzZ0?=
 =?utf-8?B?V1lwUzV4aFFMMHJqVWdOQVdaRGtnN21CZCt1M3llS0R2eE92dnlyT0ZaVE5n?=
 =?utf-8?B?d1dGZ0g4TTUvOG9WK3ZUczZ6amhYdlVzQXBtN0tISXpYa0dxTGJaWlBqVDJa?=
 =?utf-8?B?UHZ6MFE1aGdrTVhHUFRnNUJFejJEemw3UHBkNkNSOWtyREMwR3dnUU1IMDZw?=
 =?utf-8?B?NFJpcEM4Yzk2aWRYN3VIbmVXWGpVYXRiU1poYkZrUFdOckQvYzg3ZXF3NEF4?=
 =?utf-8?B?d2QxQWtpT2NsV09qamFLZVhJbVM3RHMvaVhyazNxYVA3SXZ4aU11QnU5VUNk?=
 =?utf-8?B?S2lBTDFWWThkSVJUaldIQ2ZMR1lGYlY0UCtvN2xJMkRoUmlvSmpHTmRERW0x?=
 =?utf-8?B?a0ZESkl4b0EzekQ1Uyt0ZU9WdFRnOEVuR1dGWW11d2RIL09iZVduNjRnaHVp?=
 =?utf-8?B?WllSUGdRWEtEd2o0bVdUTXhRYk1kbW9UOS93U2YyMEg0VytzU3N6MUdrVkQr?=
 =?utf-8?B?MDhEU3pGTkVwY2dGZ2FNbW4xRjdHK2psTFNSMWpvT3N0R0kxTThBdkZUUWlh?=
 =?utf-8?B?RDZhSVdmT0syTjhvL1BlM3AwcGx2WmdaQVRnc2d5bytnZ2VoZExpSDdmNDQ1?=
 =?utf-8?B?WEJIeis2Zk9XTlVJU0Z5VE4xWEkvZ2dEV0R4N1V4VFFyOGswaWZvenI3bGdu?=
 =?utf-8?B?YjFOSGtMdUpwcTF1bnJMSWlHK2Y5M0J1RzZzN1d3ODFmWW9xVVFmMWtaUVY0?=
 =?utf-8?B?TS85V2t4RjNTVlM3NFlQSmY3SXVacEFSRlUwd0xGTzlSMWZESGRwNUxrMFJ0?=
 =?utf-8?B?SnBRTVFuVkxKUkZFbmlub0U3OEJvV3BBR1ZBOVkvb1RhNXkrcU9YeVkxMnZR?=
 =?utf-8?B?a0l6TjM4NE1zRHY5SWo4cmpnUUpPSUtQV3NCcTQ1UXVRck50SnFiUGc3NkNo?=
 =?utf-8?B?VGdjYkhTWE5Ja3ZtZGFzVGRnamRpWE44RHJkMHFpSmE2Q2JOTHhwUlYrdzlW?=
 =?utf-8?B?alBDQmc3eW1pRk94ZlJubnkyeUtoa0R3ZmlXdnpOaFVRZDMxSXlsVU9OOEhv?=
 =?utf-8?B?TmJrSWJHWGFsOGdxOS92bmtoSTFjSzB0L0NnbE9zRDc4SVB6SVA3d1lBRkti?=
 =?utf-8?B?VkRlYlpZMGtLRUdpM3oxYzV3d0hwV1paZUFtdnkvUnFiVmFPSXhYaW1oUHZv?=
 =?utf-8?B?ZTRjci9PM0t5MnczWGROQmhTdUdpa0pmZno4Y3F5QWJ1UWgwMURxZ2lZZHdS?=
 =?utf-8?B?SEF1cXVHZ2I3ODhxbWFraGpvSjBIcjBFZENseTJJVWF3eE9oR05Jc2E2M3Yv?=
 =?utf-8?B?bUViQUFMUTJVUjM2b2tXYjNmcTNMOVk1eXlZcGUzZ1RYOFVzTHZSK013Y0lh?=
 =?utf-8?B?cE5Fbk15eENFUXBtUE5pUlM2M0QxTTUvMW84THYvYytza1k2Q0VEVzZVR3VV?=
 =?utf-8?B?Ynp2ZVg4SFdGS1lpOGRtSlVaNFdJd3JPVlVWUWo1bEM0SHZLQU9yT1lHY3Fi?=
 =?utf-8?B?ak9UTnRhakJFMStsd3hyM1VPdGh1UW8zUDEzblV6TG5IaG9jcHJQNzRjYXNw?=
 =?utf-8?Q?pLaQJ93sVigbSmcvB2uQ1bMi3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e543e93-260e-4079-2f29-08dd31a678e8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 18:42:02.1776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlNOd/5xy/ZNgLplOVdjpqmt3MGipzk3Q9kRLDj8up3ElRV7t6Y/P/uxI7/glY/SS8EaNEANG/96vN/ODsauOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2025-01-06 15:33, Alex Deucher wrote:
> At the momemt we only expose the i2c buses used by the driver
> for displays or EEPROMs.  However, some OEMs/AIBs use extra i2c
> buses for things like RGB controls. Expose the extra i2c buses in
> case the OEM uses one of them.
> 
> Alex Deucher (10):
>   drm/amd/display/dm: drop extra parameters to create_i2c()
>   drm/amd/display/dm: drop hw_support check in amdgpu_dm_i2c_xfer()
>   drm/amd/display/dc: add a new helper to fetch the OEM ddc_service
>   drm/amd/display/dm: handle OEM i2c buses in i2c functions
>   drm/amd/display/dm: add support for OEM i2c bus
>   drm/amd/display/dc: add support for oem i2c in atom_firmware_info_v3_1
>   drm/amd/display/dc: enable oem i2c support for DCE 12.x
>   drm/amdgpu/atombios: drop empty function
>   drm/amdgpu: rework i2c init and fini
>   drm/amdgpu: add OEM i2c bus for polaris chips
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  | 44 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       | 19 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 67 ++++++++++++++++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 ++
>  .../drm/amd/display/dc/bios/bios_parser2.c    | 13 +++-
>  .../drm/amd/display/dc/core/dc_link_exports.c |  6 ++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  3 +
>  .../dc/resource/dce120/dce120_resource.c      | 17 +++++
>  12 files changed, 157 insertions(+), 28 deletions(-)
> 

