Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3984BEE49A5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 13:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B2610EA12;
	Wed, 11 Sep 2024 13:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OKPya9CE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261F610EA12
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 13:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EG3ASLWnpEob1CA2ZpVB+2dMXJvtU4EPOneJIvY+x3phgmJWTYJQhsxuwuFe9VKDrJiJvxCx1Xpqw+UEaMjRlZPUJ72bCZhqfIh7eXZpWUKtAM8mnyGb/RotiKE6g0X+Hg7no1ojvJqfL//KYC9Jb9K6O/aqy1HZAB3O1hz9dgX0G0KYbN+TCwKt7qhCTI/l12ArP+qtP3+wt+oZuRWI3IJhKSl+kVLhA2Ic/mUmhvaQEas2+uzgqx6GVrXTUdhEql/Y+yAP8iQwoWfvF+2zuPumDEykJ6RQTnb5YKBMlqnPxrSdTvw4RVDLs6emyxx2K8HdzrAdyB8/2CoGjln9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFvPk4KwHffKWKZGOaRRG8Ol5vVrKpvSwEnjPK/Z65w=;
 b=Rxykz4YsyIreYxnjTN2RTZMg0Wm/XEuBgQg+P1fyXYgE0lEaOz7q0b+vFg5Y/3Tza4+dGBaix12GOzO42/WT4HkXRiR2gIn59lY76EIzCcBfEUNqLeSy3jaQBEwvb6GW66kIZ0LEHpWz1YqQDGrdjWiJI06KPMByacXJKY0/O+bqHgGqSInTkubk8bCIPergDBcBTi0tuuhaBmCfXzExyQpA2c4t9FeqgwnWP/mOrCvs4d4VQS5jrK0VBRYbJA6vlWRb3rLxIdG0QhhAzrNvShaTCGXBd1q91kF+MDftoj3UnX7pgSQOMFuKbTRwcJ/vLgBkdXTFbdmTKfYXGvmpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFvPk4KwHffKWKZGOaRRG8Ol5vVrKpvSwEnjPK/Z65w=;
 b=OKPya9CEw+Irwu3Po/KTS70qCjb29s5tbyu9sv+smbtGgPW4XXDWbnluVMpbH+Y9zlU0rTV64iyGsqlLvR+L8+WSUiLhlDretrRWsuBKQiltcA28ChvOuOgv6KoEB7mCWI75f9vw0MT29hpbbGMvbsmHSphsItdEwUghwMWb0qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 11 Sep
 2024 13:41:02 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 13:41:02 +0000
Message-ID: <48494b4b-59eb-484c-b616-f017f41e2812@amd.com>
Date: Wed, 11 Sep 2024 09:40:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add all planes on CRTC to state for
 overlay cursor
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: hamza.mahfooz@amd.com, rodrigo.siqueira@amd.com,
 alexander.deucher@amd.com, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20240911130650.6535-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240911130650.6535-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBP288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e43eb1-a941-4b78-04f8-08dcd267602b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUpPclhCYVZXUkNkeVZkK0xnaDZmQVA2Uk5tcnk3TkJTRmJSS0VGZ2lNem9v?=
 =?utf-8?B?Q0p6L2lyY3VWb0VuQmdTT245bWF0azk2ZFd4ZzlDUzRGZkNXT2g1ZGNLV09G?=
 =?utf-8?B?bUN4ZS95OVEyblRXeDk5TkJyN1R0VmVSam0rRzg4NktsaHZaeUxleG5tVjdj?=
 =?utf-8?B?UHp1NFNSakhOOWxlWmJQQUwyeVZlWGVnWExIMVREUE5sZ1RRc0dDQnV3ZFpI?=
 =?utf-8?B?d2xIWWVOVkJmOTd4UVFoVzM4eXRlT25JdnlndHJ6cS8xOGpzZGsvNm5UMGJF?=
 =?utf-8?B?TDFaNmxGb1lkU0dJeFFoZ3Q5S2hWYlBWMTgyeXVVL0FVZDVmb1E0b0F6Z0Vx?=
 =?utf-8?B?NkxDVnlDckM5QTE1S0o0a050Wm05NEs4eEIrNWduSmlwYnFtWDY5WDF1bi9t?=
 =?utf-8?B?bVJ5REZrWHdacnJGeHlBTHQvekNGTi9pRHg1Yis2UHdkeWMydTJ5dVViZTZn?=
 =?utf-8?B?eDBpcW5QOU9TTDdRWVFDQzBKWDNiV25CcVFCVWhyZ2E5YTd4Y1dJN1BZTWJW?=
 =?utf-8?B?emtraWJpT1dSWitiM0Q0Nm1kZTA4LytYWjZpVnhXdG55MzdWZGw1bTBGdWM4?=
 =?utf-8?B?N0ZHNUhaUjJmUFFMYlFDNjRpSzM4RE1GeG96d25tVWYzM2ozNXdOMFhUQUVI?=
 =?utf-8?B?MGN2QmdiWTVNRkltK0I3MVlMVlpqOU5ua1d2TERsdVVha3JnZnkzcUNycTZx?=
 =?utf-8?B?OEtmdW1zT2FaUHMwZSsvcmhOeGpGcHBqdjkzQzlaNXNlRXR3SnhmdkZwQVoz?=
 =?utf-8?B?c1dHUHYxenh6Q01IamZJcUVXTVM2ZnZEeXlFdzhyMm5OOTVjUjFPTkZPZk43?=
 =?utf-8?B?STN5QVJHOU9reWN1M2p0VWtYdlE2UDUzY1pobzJvNS9iR01QTThTQVpqWGRo?=
 =?utf-8?B?NjNmVGZocVEyZzBCcFhybC9JdzBXTHIwK0pTckV4K1RWdVN3M0pmdnVyc3pu?=
 =?utf-8?B?U1V3bFo1ZTAwTmJha25xQzZueVQrTjc5N2VZNmRrcndDYnFBKytKN2o2VWcx?=
 =?utf-8?B?R2dwYmVDRzJqbXNpU3pDZUtOSDlWcFBTazZObTIwTmtGTGxER0JqUUFsTDgy?=
 =?utf-8?B?VzhMZDhTN0RNWUZFekI2eDRHSlRLTXhSS3RKZS93dWJkOGZ4SWwxS3lUbHo0?=
 =?utf-8?B?T1FlWGRUa0lHc1NLRlRnelhPVGJ1bjRkVVczUmNYeW8yZytRU2ZqYXIwS2di?=
 =?utf-8?B?RTZLQWVKMldlWVlpN1FCTlIrT1RDZWthdmdYQXQzMkt5eldsQUVuaW5pSzRL?=
 =?utf-8?B?YjUwTHdWWG5YeE5RdzNWYXBzSyt2WWp6NEprMWhnZ3hGcmF6cEVxRytKSFlY?=
 =?utf-8?B?Q1dxWXZkb2gybmJlN1pvaE8xdEtGN09DS2h1NGRuU2VkaittNyt5bFB6dE5o?=
 =?utf-8?B?TnduTnZmZ1RjTVJKWjU2cFo5RllMQ0diTVErMkNRY0orUmxNMlcwTFBDYVNo?=
 =?utf-8?B?Zk1rL2RwOVptakl5Q0d1cDBkN3RKK0lvVmdNYTlhQ2o2YURqVGF0K1lycG5N?=
 =?utf-8?B?WnlJSE9yM1hJT3RmeHJSb3dHbkgzZTA4T29DRGZOdzI0S0ZKc2k3bzNmeG1B?=
 =?utf-8?B?VllueE1RVU9ONER4WXRMNzFBd0QwRlJOS2ZDaW9FTEp5RGkzVE1Ga2hsU1pG?=
 =?utf-8?B?UGhDN0w1SnF5c0dvbVRYMzY5T3E2ajZON1MxVFdhMzcwdENrZ1RSTjJJZnZo?=
 =?utf-8?B?U3VoeHNoZFhEZU14ZzlQWnV3dUpxZks4d0hjOXYyNFBRamhsNHdKeTlWQlRk?=
 =?utf-8?B?Z1hiQ0p2a3cyMkloeEFMNDMwZ3psOVVRa0h4cmtjQjJQN1FvcUxTVSt6SVZ2?=
 =?utf-8?Q?4GYjG5u+L7FHHLo2oQCn5KdUKFkE2BqHKmMbU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTFHWEdmYkJNRlg1TUZuZ24vR0JwWDZ6bEZUb2JuTXVXNG1VTU1tS21lcUhM?=
 =?utf-8?B?ck5jNHh2NEdTV1NHVitoTExseVZYVWllVHhNRytKbnNueWhHa01BTEQxZHBF?=
 =?utf-8?B?REhWT2ZqdHFnWWpvUGs4TCt3RDh2d3ZScGgzRVlhWE9nancwdU5ieFJUZ2sx?=
 =?utf-8?B?NThTb3orN3hpQ3pxaVFOa3Z2ODdJU1RBcnFocDE0Rklkc2dZc0g3MWF5dlRG?=
 =?utf-8?B?RVFnOGpPMmdJcDRFaStzQnhRN01XSmZGMVVIdEx6VE5IcU9XTWJWbXQ3a05p?=
 =?utf-8?B?TmU1WWJobTY0Q25UWWs3N1R0SHBLaTQ4RUk3cnVhYjhIeEdJRVRnWDAvZ0FW?=
 =?utf-8?B?YlFZcDYyeU1qYjZhczZkeWVIblEzUG1LTWRqZ1ZJQTRjNU9qWTBoRjJWc3p2?=
 =?utf-8?B?RVNQeDRPMXAxVjRlazF2SXJtVEg5MlNIZ2gvZ1hiS0xGNWNvc1FNZVFERFg3?=
 =?utf-8?B?eU9HZU92cG9La0lNUjdyQXFNWThRYzhUenU4UWdHOVhuQzZsYU1CWGFub1Nt?=
 =?utf-8?B?WFArc0N6a2pTNU50dTU5Sm0vaGZxWERXNHZOb0luT0RqdUJqM1AwOFpobTh1?=
 =?utf-8?B?bSszLy9vRENqbHVaRXpQb1prZXhERXF3MEtkWHBnYmRTeVc2TlI2UHJDcHBl?=
 =?utf-8?B?ejlhNm9pSDM3T3F2bXl2WDFUbkNCMGwzcngrNTdXaVN0bEJuZVM3Q2dFN0Jv?=
 =?utf-8?B?Z2tKMFFhTTY3YWk5NFpPRlJnekJRRFVFelI5U01IUFYzODhKZ2RBTFF5bUs3?=
 =?utf-8?B?VW1TeTVpOWVCYVVNYnRaSVdxZFF1bkpkUWhsR2xkTmVmL1NvbHBJQ3NyWXha?=
 =?utf-8?B?eDBxbENaSnBtdmFVZXpWUVlQeVUwUmpsSFhCZnBUdXNtWm9WRnNFYVNGK3gv?=
 =?utf-8?B?emZKRnNuazBUNXVxZFdzT0kwbXZzNjJlV2ppTjhDWDJ1QWZ3ek1xRmdYZFlV?=
 =?utf-8?B?ZGZsMWt3U1U2b3JhbHAyQnlwQzMzYkNGcGwyOTd5dWFEcFQvRFFrc0VMWnZY?=
 =?utf-8?B?NUhoTDNYZmtvcXdZRUNTY0NkV0VDV2EwYVJkYXlBL0tFUEtXNkxQb0lYQXhD?=
 =?utf-8?B?V29zSjY5Z00xb04yY1FJdHpuYUZnblpUMnB5QVNIN2VLWE5zWDZEY2R5NEEz?=
 =?utf-8?B?SU1OSXhDNEpJZGFpeDAzS2Z3U052ODB1bU5rQlA2bkdwQnVVdTg2K0FOZXF5?=
 =?utf-8?B?YkR3Y01QSTlkQW9sdVBBdklqL1l3QTBXLzFITDhGbXl0VTlLdFJlTkl4Y2cv?=
 =?utf-8?B?b1VYYXZuRGJuQlY2ODh3NnY1dW1yTE1DWUVmUDF1TEUzQ210SW5MQ01GT3NR?=
 =?utf-8?B?Q3NodWZaREFJbENhTmx0VnB5b20rSldsMUk5QTFWN1pHNzFoNE5vazE4bWZO?=
 =?utf-8?B?VWNJOHFSN3d3MVZlaDA2TFVocXpTbTJrcUJQMHVmeks1eDA5N3lwOTR3cGoz?=
 =?utf-8?B?T2NZMzNuZnZiak9VcWc0WGJyNjF0UnNYSU9NeWZWMGNXRkJjQ0pqRitnZmRj?=
 =?utf-8?B?aW5vSDdyNStXTURsdnlLa2QzdFlFeHNUNlMwR3lPN0U1Y1RORi9xMCtmYWE4?=
 =?utf-8?B?NW1VRFlYdGcydEZ6enNEckRxZkd1Q0pzOEpzM3U2dXlyLzFSUFlrZk56dmdm?=
 =?utf-8?B?WHVxelFwaGpPZldtalB5TG44aGRCREIwdzJ3WjB6dUdBWEsyeXFGUFNZRU0y?=
 =?utf-8?B?M05CRGVBSE9ldUZub1ZBSlI0cVgxOHRiNWFUaldqZWxLa29OWlVBbmoyempW?=
 =?utf-8?B?R3lDQmtieGF1SHhYNUlnRTdVeGtqZ054TFNyMmZ3S0sydTEzNG11YkVZOWxs?=
 =?utf-8?B?ZjljOG9rSDEzcGoyZ090NUhzWUFHUk5YZlp4ZzV2YW1XYURYS2FZeHoraHFB?=
 =?utf-8?B?UjArdnRQRUh6andYVExTSXFBYWV4L0N0czBvVEw0VU0yTGdLMFo5N0UrUmcv?=
 =?utf-8?B?dnYybGJYMFFNVWtnTW1CTzBYMUlUMXducGEvRWRBallCM3ZnYlZ1OHlBRmdq?=
 =?utf-8?B?dkF0eVByRGVCaG1ncFdxY3dIZHJzTUVOdEhvWGJodEM5MmdJNE5YNEFvZTIv?=
 =?utf-8?B?aWsvbno3aXN4OWt5WVQ2bDZmcm80ck1vQ3k2M1FsWWhEL21ISDBiaEVNNDdO?=
 =?utf-8?Q?WBQZf60NS+tYa9nga3Xr1OgdD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e43eb1-a941-4b78-04f8-08dcd267602b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 13:41:01.8795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuAGwqOeKlVJtkJ40qETIo72gZ6dB00at8FbBBnegBtVx3q2YV0Y1CKXa0aOrFJaoqJZHb0OhUpPahIJDhZLHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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



On 2024-09-11 09:06, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> DC has a special commit path for native cursor, which use the built-in
> cursor pipe within DCN planes. This update path does not require all
> enabled planes to be added to the list of surface updates sent to DC.
> 
> This is not the case for overlay cursor; it uses the same path as MPO
> commits. This update path requires all enabled planes to be added to the
> list of surface updates sent to DC. Otherwise, DC will disable planes
> not inside the list.
> 
> [How]
> 
> If overlay cursor is needed, add all planes on the same CRTC as this
> cursor to the atomic state. This is already done for non-cursor planes
> (MPO), just before the added lines.
> 
> Fixes: 1b04dcca4fb1 ("drm/amd/display: Introduce overlay cursor mode")
> Closes: https://lore.kernel.org/lkml/f68020a3-c413-482d-beb2-5432d98a1d3e@amd.com
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a3edaf658ae00..6b5baa3e20c49 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -11427,6 +11427,17 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  			drm_dbg(dev, "Failed to determine cursor mode\n");
>  			goto fail;
>  		}
> +
> +		/*
> +		 * If overlay cursor is needed, DC cannot go through the
> +		 * native cursor update path. All enabled planes on the CRTC
> +		 * need to be added for DC to not disable a plane by mistake
> +		 */
> +		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE) {
> +			ret = drm_atomic_add_affected_planes(state, crtc);
> +			if (ret)
> +				goto fail;
> +		}
>  	}
>  
>  	/* Remove exiting planes if they are modified */

