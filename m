Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFF2C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 14:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C419890B2;
	Wed,  5 Mar 2025 14:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ms4AwFYG";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B79D890EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 14:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+GKUfLrgpUcv+v3zvo5gxENXpoqPavw1/KpDXMCsCMOWkrlDvVMmynYoBi6wjWSW/xKvvGFZrUr25A7kHgi7s13JH0bf/1SsaKOUG5DxotfRKkvS/jGMYWd6KiyqB+xAaU5dbSec94gdKAFfTFo7O3fvJ9YBNmST6u0ZnLM5tD8ORbU/t2Y4ijPpREgP2829AcgxSnTqAoOr64KZUL/ZMZYB5IwbO1XgYJmmvWIm+4f70k0SQjQITPS2g378mzsH1HH2Itg2jhN1zQBy0f2FYeXWlVgZedophRwJv9oJLDcZRaNlPKAPpE1SQMQLx5yiGHfDqXd8gFhTjMgsDBfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bTDEmiqjP6FU3Y2b3M7vo0+sB0SJPA6eptNxt8R2ds=;
 b=hH/wdWvqDTSq4Hv38dOxVe2ixofyu0NXq0cCSeMl0O8O3xt0yovYbIiTqDp+z89IYLuDVEogrOiJEp2V4I0Q8ODG6WF20D1N1oYyU36kYh9iLG42Ojs3aRS21Au0v1O9yfz1je0hhphxnNtpCH6dbODSSDjIk3IjjaWi7c+f3ogXyhVMElQMc6A2hKoAiSyX+dRGHrnEyZg3OA8gIb4tPU/oPPYmkvpU9niN8Jng7e/Ed0n7Hrxudz2i+sL5c6yCjHvcFTgZ2iX6S0s+/48Kx4Vh8nBbfCw6u09iqbbyfHwzHMJHP3rGhdYz8sG0qpTc+s94X9CDnnNvTDtRIfmq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bTDEmiqjP6FU3Y2b3M7vo0+sB0SJPA6eptNxt8R2ds=;
 b=ms4AwFYGoNOEAT7r3gFU99T9hB7nrX16XfF4ZIVBOT369BGEia6rdXB4QJ3W+z2faAF9hNV6zPnnInDpjOd5sRC0TR6RSB2yguldPWorTweKs7Fv3pje8LSWWUmUE8Ra1c3u7jEyhPgAjcUMZqvz116b7oUuWW/iCDG4E2uvmmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 14:20:07 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 14:20:05 +0000
Content-Type: multipart/alternative;
 boundary="------------KSViHt5d8FkjtJeefuKalgcV"
Message-ID: <537c2cbd-5a6a-4bc2-a349-426b66e322ad@amd.com>
Date: Wed, 5 Mar 2025 09:20:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix idle work handler for VCN 2.5
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250304230123.71874-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250304230123.71874-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::16) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad6adfd-f07d-41d7-0bf9-08dd5bf0d360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjZxK3FkeERUV1V1WUt6QUNQNTZMcEZtNUQ4WHFpcXJtOGQxMmI0RWtLTEZ3?=
 =?utf-8?B?ck1IS0VLY2NBVVBQOGtwVm9ZQ0JUeXlTNm5NK2FTWk9iS29VZ0NmTUF3OGNI?=
 =?utf-8?B?VzJ2Ni9nZGswVVJya080NlZ5aHUvSjVvY1ZvSGNEOGZQb2hCWHUvWEUwMjNv?=
 =?utf-8?B?eEw1SlNXeEJ3VVFSOEZiZmgwMGFlbUM4Yk42OUttcDNrSHg4a09XVDhVNTdB?=
 =?utf-8?B?MDFDZkRvd0UyUTh6S1BTR3Bzc3NGVjBNZlBBR3pqNGorYS9mUExCd3lWTkMr?=
 =?utf-8?B?UEVYUXpLN3ZVQmYxVUlwSE1GMWx0cUQ3ZTRIN1NmRTlTakZsWkwrZzVQU0dE?=
 =?utf-8?B?VlNTdUloRkM0Wm9Bd0Uwc3QzajNBWjRSaFJMT2wzbVVIcDlyZmRVcEJwSHhR?=
 =?utf-8?B?UFVmeW5aQ2tGUmY4UW8wejd6T2lxUGpRWGpqSjV5RDlCMi9ERk9LanB2TDFj?=
 =?utf-8?B?b3J5Vk55L3drT2NrU0lwVXppTjV1eW1jUnlMdGNXMER5Z2VPcndWVmNmcmp0?=
 =?utf-8?B?V3NpU0podkp2dEdESnZINWxvL1ZMSlpNYVl1d3dRVlUxL0JGWm5SWFpoeS9G?=
 =?utf-8?B?YkE1R09LZTRIOHhzN1VsRTgzUGdOakErQlIreHYvdFhVbSsvbktScTMvK3hP?=
 =?utf-8?B?WFpCYlZkYWNYbW9HdnRldjFBcDV0eEw1UElHQTJKbkFuRGsxaVFEYlV1ME1E?=
 =?utf-8?B?WmR5UmdBalA4N3pDc1RzQ3lpL0hvU0VNa0N4S2hGUFVpRnI1MEdnR3NodkNB?=
 =?utf-8?B?Z1o1dUxUL25pL2ZTb3BPOS9QWldxWVFFaDBMalhwWDlpWTN5WFFmOEovelZl?=
 =?utf-8?B?dUZRdVdVbW9nWmUzV1FUcXRkd1dwRS9NbGRyeVNzVElheG9yVlBaV1ZQWFpz?=
 =?utf-8?B?UWF5NGhUT0dNRUlaVzNsaEZZcGh1TFBLVThaMzZ4dXpHTTdDQlc3VzJlRVl1?=
 =?utf-8?B?NkdkQTBoblNoemF0ZUR1NTdyeWQwejBjNklqbW1MVktOVyt0ZWVGeTd3bmVp?=
 =?utf-8?B?WXdkUGdyTE51a0ptelZGUzBUcjlBQThpZWI0cWZ3T0dXSnYrWGNyS2duVDQ5?=
 =?utf-8?B?UWVFK0ZNZkVZQ2UrY0F2SllpelUxaHA4TGd4Z0NKZlNJaERhSVNvaTRrR044?=
 =?utf-8?B?c1dNNkRwVlZTYTErMmNXZUNPLzdab2ZaN1lnbENITmFNb0d6Y3EvUFBJWXRM?=
 =?utf-8?B?S0pLRXFKYXBrQnFQUkFwM0pnTE53UTk2aDVoemdVZmtrTjRQQ2FMZERvSzRW?=
 =?utf-8?B?V0w3UmpEUERUVm5JaGlGRUdscjB4ZE9WbmMrTm54SXdmOXJmQmI4RnFWOWEx?=
 =?utf-8?B?Y3BmR1RwTnpndDlPNUNYVVM2blp5d2tuTSszaTVwS0YvRzRDeTcyL1hlWjAy?=
 =?utf-8?B?NktaQjNma0NlK1diL2JyVkxlTnZib0t0RFJyMFdOUWxYZzB3Vi8rWmY5Vitl?=
 =?utf-8?B?Vjk5N1g0d0FNWkkxUmZ4SFFVbTlnY2U4bmRSNm8rTmZVWXh3SmtvSTF1Qk9L?=
 =?utf-8?B?LzRsVnVQRm9nRksrRzJkbEFLZEx0UUhYOWhPMkFUTXkyYmhaSFg3Vy9mVmpk?=
 =?utf-8?B?ZjkxTlZVWllqckJlL25GV2NNdmhyR0xMSTcxYkRvRml3RXNXUkltVllDV3pu?=
 =?utf-8?B?VlM5LzEyRzdRZHRGUmhHc1lZcWVtMURFYTBpT2p6T28yNjdKMnJMcEFoRHFR?=
 =?utf-8?B?ZEhKTzM3S0FubDF4V3F2dTkrWDZSZE81Yk9qY3JIT0FDcnFlUzhxeU5yR3Yr?=
 =?utf-8?B?cUxSamZmV1hyd3BPUDZpYlJwZ1lYaWpjcml5NGhuVWwvZnkvTnZuaDJXTEdW?=
 =?utf-8?B?R2VLNWtmT1FnSkFIQ1VWN2I3QjU1dnl0bWVVRUlhcTJsU1hPL1ErZzV5dFdB?=
 =?utf-8?Q?2s1pgztuJStET?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdOUUY2elIrUjNUam5PR0IzTlBaZEV0NWZCbkN4NHpDZ2IyempONnFyMWJk?=
 =?utf-8?B?bStmTEE3Z05QejRWbjVOSFBISVdqVXlEUnJRcFo0N2t4Sm9Nb3lGTGdYODBF?=
 =?utf-8?B?UXJmVkcvNDJlNFhiSUJSa3FVT2o4WHAwZnAxNDQ1RlpETmRMaGwwYmliVzNz?=
 =?utf-8?B?VHNtQlM2YnBxT1Y0YmpDMmpoQnNWRDMxblpmSElYNFlKamZkeUx4OWN0dzZ2?=
 =?utf-8?B?ZDFaU2V6bmd3Tm55K3hyZlA0eWZpeGR5UFIyZE93eFJyOS8xWk1kazVHVkZo?=
 =?utf-8?B?bGtKcDZGVWpHMTBURU43TlBLdk5yS1FpNk9VZjcyb0tlLzEyQjlmZEZUUjRq?=
 =?utf-8?B?Y09HVEtiUldPTVU3YzB3NnlUSit6SEw1N1dwaWtQelpXMWIxVzVRSVJadkFa?=
 =?utf-8?B?NFUxQ1Q1dTdBYWw3dzBKUjBnRFJaK3dJRkpzb2Z0SmIrQ2M2M3RQd05nTUhx?=
 =?utf-8?B?WldTTDBXSGU1djducWw0S0VFZlZvdGZLeEhxOVducmk1emJWeFN3dEpkOHlJ?=
 =?utf-8?B?WEpiRjA1eGROTXBja0lmTVVGd2t6Zjd4aWsvTElBdkQweXRPL3hmSmJRRHY3?=
 =?utf-8?B?NWRvdkswVEdmZWw0R1c4MlFKcTJGUWhhZWpJZkFuc0xJUDl3cFlxcVhWK25Q?=
 =?utf-8?B?RVQ1MzlPSmVDQnRNZXJWb3ptdXFDMnJzd2xEYThqVmsrT3hUTm1tVjNucDhn?=
 =?utf-8?B?M014NlJrb0h4RXJrK1JCR3hmZDQvSkpKQjgrSEZhbXFnL0NFZ0xoSlFaT1pS?=
 =?utf-8?B?Z2dSbEtrTzZkKzhmcHZiVmNadXA4VHQ4WTFmV3dhL09Eb1NBZWtrazRJb2Uv?=
 =?utf-8?B?MmNKbkJmc2hIZHV2TVNwNTBwK0RHNlQzZ1RQNTYwY3FNRVFjQUUrVXhrZmtD?=
 =?utf-8?B?dHg2YnE4T3E2MDZRVlJYM2hNdnZYQko4endxUm9HS21FUnB5NkFNVWlqZmhv?=
 =?utf-8?B?Uk1tQlRoRFFDZDA4cnc2TEtpQW9PdW4vbG5OV0RFWUs0OUl6ZXhqSk9pcVgy?=
 =?utf-8?B?NDhzUTQ2YmxxMVZsVzhWdllGalEybEpLRUtTSDB1ZVFUdHFnd3JaWW54UlFB?=
 =?utf-8?B?eG5JV1JXVnhqb3Vxdy9YN05wNVVDQ0RsOFNld1BPUHVsK1VoOXVDb0RkRFUx?=
 =?utf-8?B?Z2RRTTEzVUd6MW1HcUxITGhGSjh0OUpWUWhwOXU4MmNnZ0ZIazVDRklsRFdJ?=
 =?utf-8?B?THlJVkpydm1mWVBwMk1uZFFiNFVKU3cwYmkxeWtUOFBYWWh1UW1EOVJXU1VS?=
 =?utf-8?B?RmtoUCtydnlEV2g0NEd2OW9VRWxsd2VNZk9SanViNGV6MkFoanN0ZDdLT0xv?=
 =?utf-8?B?a3Bmd2RTcGpxcUZMOFk2UlFEQUlDWUxYcTZVYmNWYWhxVDdJZ2lpWUt0U3Y1?=
 =?utf-8?B?TjJXU3VSVjBxUjRUcW9qSkhWdWl6VnE4NDkzUFJQRjZkOWlGaTBwY005ZWt3?=
 =?utf-8?B?V0NySEpkUTJKVzc0WFVyYVRZL1dEK2laK2psT0xqWjNLR3dRUmFzOGtuM1hT?=
 =?utf-8?B?U3NmTlJPZS95S0tacGxhRFB0OVFuRU9YMFdqcDIrUm5qeXBIc2VhZ1RpWVpn?=
 =?utf-8?B?dXJEM3laMmpnY1FISFp2TktTaU1UR0h4RFlGM1I0UVdONlpWL0RpL2VWMEI0?=
 =?utf-8?B?QW01VEhkV0VGeDNqZXZtNnJad0JlWldPa1V3Z0dZQ2dOUW1DeFJJVUEvd0kv?=
 =?utf-8?B?Ukg0WkI3STBRcUNtUERZdS9CRmd0K1JHNlJ4VGtFeWFsU3R4MjZEek9Sa2lU?=
 =?utf-8?B?eDJWdTY3cVBvdlR5c2RTOFRWbllKQUpwOS91enF5USsrMHV5bThMZldsa254?=
 =?utf-8?B?Z0J2MWJBSUpHSVR5b2IyUXp0UU1qSHdta2NVUFAvakV3NHlNMHdmUGNzU0Nn?=
 =?utf-8?B?Z2E2UEhjc0lRdkJvNXU3L1pIRUFsWkVheEQvS1huTUxPSEN3MU9zWWh6ZTVh?=
 =?utf-8?B?dFdLNFlhQmFlZGVWUU83VFphL2tRdjRIRTF6YVZpN2tLY1JTSGt1ZVhaVGM1?=
 =?utf-8?B?ZURXbUpoblVVcGhOalpBWWtCTGIwd01VKzlwSndXSTNqRFo2dytnOHhhMUsy?=
 =?utf-8?B?aE1YQkpLQ1IvV24yaVBYMzhZdlFvUm5FbE5DMGFlUk9kWDN3RFRuQnJVS3Yr?=
 =?utf-8?Q?pLdpjnZx238ClxQnyivCgOa+t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad6adfd-f07d-41d7-0bf9-08dd5bf0d360
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:20:05.4747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAEdkDI1EVY9pn4GuXf1baMrm5tnlJJEAiiZBAa0jQqY3hRrYHVUzz8U0rt2UHjiNqQnZkT2o0NFvdLTIHagJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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

--------------KSViHt5d8FkjtJeefuKalgcV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-03-04 18:01, Alex Deucher wrote:
> VCN 2.5 uses the PG callback to enable VCN DPM which is
> a global state.  As such, we need to make sure all instances
> are in the same state.
>
> v2: switch to a ref count (Lijo)
> v3: switch to its own idle work handler
>
> Fixes: 4ce4fe27205c ("drm/amdgpu/vcn: use per instance callbacks for idle work handler")
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 126 +++++++++++++++++++++++++-
>   1 file changed, 122 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index dff1a88590363..fa66521b940de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -107,6 +107,121 @@ static int amdgpu_ih_clientid_vcns[] = {
>   	SOC15_IH_CLIENTID_VCN1
>   };
>   
> +static void vcn_v2_5_idle_work_handler(struct work_struct *work)
> +{
> +	struct amdgpu_vcn_inst *vcn_inst =
> +		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
> +	struct amdgpu_device *adev = vcn_inst->adev;
> +	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
> +	unsigned int i, j;
> +	int r = 0;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
> +
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
> +		for (j = 0; j < v->num_enc_rings; ++j)
> +			fence[i] += amdgpu_fence_count_emitted(&v->ring_enc[j]);
> +
> +		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +		    !v->using_unified_queue) {
> +			struct dpg_pause_state new_state;
> +
> +			if (fence[i] ||
> +			    unlikely(atomic_read(&v->dpg_enc_submission_cnt)))
> +				new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +			else
> +				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
> +
> +			v->pause_dpg_mode(v, &new_state);
> +		}
> +
> +		fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
> +		fences += fence[i];
> +
> +	}
> +
> +	if (!fences && !atomic_read(&adev->vcn.inst[0].total_submission_cnt)) {
> +		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +						       AMD_PG_STATE_GATE);
> +		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> +						    false);
> +		if (r)
> +			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
> +	} else {
> +		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
> +	}
> +}
> +
> +static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	int r = 0, i;
> +
> +	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
> +
> +	if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work)) {
> +		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> +						    true);
> +		if (r)
> +			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
> +	}
> +
> +	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
> +	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +					       AMD_PG_STATE_UNGATE);
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
> +
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +		    !v->using_unified_queue) {
> +			struct dpg_pause_state new_state;
> +
> +			if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
> +				atomic_inc(&v->dpg_enc_submission_cnt);
> +				new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +			} else {
> +				unsigned int fences = 0;
> +				unsigned int i;
> +
> +				for (i = 0; i < v->num_enc_rings; ++i)
> +					fences += amdgpu_fence_count_emitted(&v->ring_enc[i]);
> +
> +				if (fences || atomic_read(&v->dpg_enc_submission_cnt))
> +					new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +				else
> +					new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
> +			}
> +
> +			v->pause_dpg_mode(v, &new_state);
> +		}
> +	}
> +	mutex_unlock(&adev->vcn.inst[0].vcn_pg_lock);
> +}
> +
> +static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> +	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +	    ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
> +	    !adev->vcn.inst[ring->me].using_unified_queue)
> +		atomic_dec(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
> +
> +	atomic_dec(&adev->vcn.inst[0].total_submission_cnt);
> +
> +	schedule_delayed_work(&adev->vcn.inst[0].idle_work,
> +			      VCN_IDLE_TIMEOUT);
> +}
> +
>   /**
>    * vcn_v2_5_early_init - set function pointers and load microcode
>    *
> @@ -201,6 +316,9 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (r)
>   			return r;
>   
> +		/* Override the work func */
> +		adev->vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
> +
>   		amdgpu_vcn_setup_ucode(adev, j);
>   
>   		r = amdgpu_vcn_resume(adev, j);
> @@ -1661,8 +1779,8 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
>   	.insert_start = vcn_v2_0_dec_ring_insert_start,
>   	.insert_end = vcn_v2_0_dec_ring_insert_end,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
> -	.begin_use = amdgpu_vcn_ring_begin_use,
> -	.end_use = amdgpu_vcn_ring_end_use,
> +	.begin_use = vcn_v2_5_ring_begin_use,
> +	.end_use = vcn_v2_5_ring_end_use,
>   	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
>   	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> @@ -1759,8 +1877,8 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
>   	.insert_nop = amdgpu_ring_insert_nop,
>   	.insert_end = vcn_v2_0_enc_ring_insert_end,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
> -	.begin_use = amdgpu_vcn_ring_begin_use,
> -	.end_use = amdgpu_vcn_ring_end_use,
> +	.begin_use = vcn_v2_5_ring_begin_use,
> +	.end_use = vcn_v2_5_ring_end_use,
>   	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
>   	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
--------------KSViHt5d8FkjtJeefuKalgcV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-03-04 18:01, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250304230123.71874-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">VCN 2.5 uses the PG callback to enable VCN DPM which is
a global state.  As such, we need to make sure all instances
are in the same state.

v2: switch to a ref count (Lijo)
v3: switch to its own idle work handler

Fixes: 4ce4fe27205c (&quot;drm/amdgpu/vcn: use per instance callbacks for idle work handler&quot;)
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <div>
      <p style="margin-top:0;margin-bottom:0;"><span style="color:black;font-size:11pt;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;"><span data-markjs="true" class="mark7ru6aprxh" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span>:
          Boyuan Zhang <a style="margin-top:0;margin-bottom:0;" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="0" id="LPlnkOWA0ed3e1cc-cbb8-88b5-8ab6-131c3f0c5066" href="mailto:Boyuan.Zhang@amd.com">&lt;Boyuan.Zhang@amd.com&gt;</a></span></p>
    </div>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250304230123.71874-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 126 +++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index dff1a88590363..fa66521b940de 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -107,6 +107,121 @@ static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
+static void vcn_v2_5_idle_work_handler(struct work_struct *work)
+{
+	struct amdgpu_vcn_inst *vcn_inst =
+		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
+	struct amdgpu_device *adev = vcn_inst-&gt;adev;
+	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
+	unsigned int i, j;
+	int r = 0;
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *v = &amp;adev-&gt;vcn.inst[i];
+
+		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+			continue;
+
+		for (j = 0; j &lt; v-&gt;num_enc_rings; ++j)
+			fence[i] += amdgpu_fence_count_emitted(&amp;v-&gt;ring_enc[j]);
+
+		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
+		    !v-&gt;using_unified_queue) {
+			struct dpg_pause_state new_state;
+
+			if (fence[i] ||
+			    unlikely(atomic_read(&amp;v-&gt;dpg_enc_submission_cnt)))
+				new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+
+			v-&gt;pause_dpg_mode(v, &amp;new_state);
+		}
+
+		fence[i] += amdgpu_fence_count_emitted(&amp;v-&gt;ring_dec);
+		fences += fence[i];
+
+	}
+
+	if (!fences &amp;&amp; !atomic_read(&amp;adev-&gt;vcn.inst[0].total_submission_cnt)) {
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+						       AMD_PG_STATE_GATE);
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+						    false);
+		if (r)
+			dev_warn(adev-&gt;dev, &quot;(%d) failed to disable video power profile mode\n&quot;, r);
+	} else {
+		schedule_delayed_work(&amp;adev-&gt;vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
+	}
+}
+
+static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring-&gt;adev;
+	int r = 0, i;
+
+	atomic_inc(&amp;adev-&gt;vcn.inst[0].total_submission_cnt);
+
+	if (!cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[0].idle_work)) {
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+						    true);
+		if (r)
+			dev_warn(adev-&gt;dev, &quot;(%d) failed to switch to video power profile mode\n&quot;, r);
+	}
+
+	mutex_lock(&amp;adev-&gt;vcn.inst[0].vcn_pg_lock);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+					       AMD_PG_STATE_UNGATE);
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *v = &amp;adev-&gt;vcn.inst[i];
+
+		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+			continue;
+		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
+		    !v-&gt;using_unified_queue) {
+			struct dpg_pause_state new_state;
+
+			if (ring-&gt;funcs-&gt;type == AMDGPU_RING_TYPE_VCN_ENC) {
+				atomic_inc(&amp;v-&gt;dpg_enc_submission_cnt);
+				new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			} else {
+				unsigned int fences = 0;
+				unsigned int i;
+
+				for (i = 0; i &lt; v-&gt;num_enc_rings; ++i)
+					fences += amdgpu_fence_count_emitted(&amp;v-&gt;ring_enc[i]);
+
+				if (fences || atomic_read(&amp;v-&gt;dpg_enc_submission_cnt))
+					new_state.fw_based = VCN_DPG_STATE__PAUSE;
+				else
+					new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+			}
+
+			v-&gt;pause_dpg_mode(v, &amp;new_state);
+		}
+	}
+	mutex_unlock(&amp;adev-&gt;vcn.inst[0].vcn_pg_lock);
+}
+
+static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring-&gt;adev;
+
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (ring-&gt;adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
+	    ring-&gt;funcs-&gt;type == AMDGPU_RING_TYPE_VCN_ENC &amp;&amp;
+	    !adev-&gt;vcn.inst[ring-&gt;me].using_unified_queue)
+		atomic_dec(&amp;adev-&gt;vcn.inst[ring-&gt;me].dpg_enc_submission_cnt);
+
+	atomic_dec(&amp;adev-&gt;vcn.inst[0].total_submission_cnt);
+
+	schedule_delayed_work(&amp;adev-&gt;vcn.inst[0].idle_work,
+			      VCN_IDLE_TIMEOUT);
+}
+
 /**
  * vcn_v2_5_early_init - set function pointers and load microcode
  *
@@ -201,6 +316,9 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
+		/* Override the work func */
+		adev-&gt;vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
+
 		amdgpu_vcn_setup_ucode(adev, j);
 
 		r = amdgpu_vcn_resume(adev, j);
@@ -1661,8 +1779,8 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.insert_start = vcn_v2_0_dec_ring_insert_start,
 	.insert_end = vcn_v2_0_dec_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.begin_use = amdgpu_vcn_ring_begin_use,
-	.end_use = amdgpu_vcn_ring_end_use,
+	.begin_use = vcn_v2_5_ring_begin_use,
+	.end_use = vcn_v2_5_ring_end_use,
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
@@ -1759,8 +1877,8 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.insert_end = vcn_v2_0_enc_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.begin_use = amdgpu_vcn_ring_begin_use,
-	.end_use = amdgpu_vcn_ring_end_use,
+	.begin_use = vcn_v2_5_ring_begin_use,
+	.end_use = vcn_v2_5_ring_end_use,
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
</pre>
    </blockquote>
  </body>
</html>

--------------KSViHt5d8FkjtJeefuKalgcV--
