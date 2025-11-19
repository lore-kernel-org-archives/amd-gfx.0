Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFEFCF3186
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 10:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1CC10E5C9;
	Wed, 19 Nov 2025 10:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AiqQms1B";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0F710E5C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 10:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4uAQybDqQdBBKw+DxEUXb1joTx9Oocf8Cmse4MaWOq5+83Gp02pn+9Muci0gAg24rRdkTHUoNnswboGN+Z3BZYTD5MlZ87eVato+AosswB0HUMHZCk/S8NYD2xQIZD1QYEzzA2Bzko7zyJo0xOIpN+ih0qm4pNYmmrj2lUSRVo1xs0L1pXgxmJzqFJd9pXLRviWzoaTEo3pnOEYFb60n7tL3EeQFKpVH2kJgpOr1RiGyOzniSpGgKiqsU9oIN1dMyteHa3PIBH1wBbRKAqP9sS4FSCLFVO/o1jgIDCxTPjfJ/ul2uhvU4ndt8478hmrTBXU1Pi2+SlBCbhiHXhnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfGEyJ76RTsBDe10O20Bge9Id+zYI1f0K8sGYYpclqA=;
 b=wd6JMFLMSSB5Z8fwA+URjjFib2+RZafeDDODBgRWv71ZR2jkK1Au/PHZpNAoKOKSv9f0rU4iSgY8JjDD5Md/r6Xkomgnqkm5e7K0F5mBKVOJ1bejs0W6et6m3LI+wWfZE2K1dFg+pupAzhKdcaNyo6AFYf9mzz+Lht/LctGn3TzCY3pfjV0AU3ZKHdaktH+pzlrKmSt+fBhCKeQeLMxkpRWYWSJC/hiYBlqEYGfAzLWepMitjmlhiaeROHdl249H2VT7KwLguXrhK18Ur94Lbv2Gc6yv9PoOxdUJBlY/KlCrfEwUUmoLPQhNA6Q0bq4eiVfh05MLQPLEMjUQgyOapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfGEyJ76RTsBDe10O20Bge9Id+zYI1f0K8sGYYpclqA=;
 b=AiqQms1BgU7aXFa/O+fpDQJ9KWwIqF2FnRsYahmx/dC/EgQE6IPFangu4o9B+HVQpVubEixAUM1OzX9FvE/i1x73O20gJQdOTQsexXZGczZ4OVkjNezOjpynEfN3HREVdOFI6s2DeysPy0QuEgRxwMprpJWUjRqg0MwZkdbu9/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:03:19 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:03:19 +0000
Message-ID: <b1fc79bd-11e2-49f2-8483-a21cf6e9952a@amd.com>
Date: Wed, 19 Nov 2025 15:33:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add sriov vf check for VCN per queue reset
 support.
To: Shikang Fan <shikang.fan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251118100657.1222595-1-shikang.fan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251118100657.1222595-1-shikang.fan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 087e93bc-8d68-4e03-af76-08de2752dd8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUZ6aDJrcG9ia094V2YreHRwRWEyUXNpVWRJaGZTZUNjQmE5Wk5Qby9KL0VW?=
 =?utf-8?B?VjQrQlJXQTZ2T05DcTJibmRpMzY3eG44SkpQZThOaTR3YmhWNlNNTEtLaGZw?=
 =?utf-8?B?NUc4U2liNWozczRrT0ZPOTJJUStXR1BiRzJjdktVanFUcDdLNW5FWjF2S2hr?=
 =?utf-8?B?NTZqdGJOMWpoUHFkRG95NDdjcEdFMEZCVlI5dW5zU2l4QmFyYnVJSkpBMGpV?=
 =?utf-8?B?OTJFSk9YS2txdjJRYVNhQ3hJM0RHSWd3SzI3S0FXYjlvZy9vV3QrcW05c3hn?=
 =?utf-8?B?SEFONGFFMDNFcytyUXI4NmNSd0JhNjFPN244bkVsRFJjYjNIWk5qVHdKc3l4?=
 =?utf-8?B?ZmJvREpmWitOSmJkUlAzaDVWUUZFaHNTVlR2QjhEMS9tOTN5eGNzRGFYZW12?=
 =?utf-8?B?dDA2dnZqV0ZKV3ZvVTRhZ2FxZHNpbm1xRmdMcG5MM3FhMEk0bm1tYjZYeVdK?=
 =?utf-8?B?ZFYwSGQwRWc2Um94Y1I0d2IySlV1cWlSR1VCWU5ReE9LcTJPem05SFhmUits?=
 =?utf-8?B?WEJpWXF6bVdPTGFlRGp1NlB4K1I3WEhpeGpsOUJMTlhBLzQ1OEc1bmh1aWhW?=
 =?utf-8?B?dEo0akVPUkswK0VRRGo5MVpUcURpd3hxdEdGejlvVG8vWENMbW1PcnlnVHQv?=
 =?utf-8?B?V0F4cDUvbkErY2ZmckVOOGNuL0xweGdHV3ljVkYxbTFIWGtWYmN6SEp2bjBz?=
 =?utf-8?B?QXJwS3l5bU9DNU8yWUxaMm1tMjk3TUF5OVMxUkpvZkMwZGg4SFoxSWdLZzVx?=
 =?utf-8?B?WWloNTF1L0UzZklic0VLaWhyRnZKVHR4dVMzZVVPN0UwMnUyNUFEakFpdFN3?=
 =?utf-8?B?a3dWR05XdDVzVmk4MEFRbjBNMHhnMy82TDl4ak10SEhITEFsQUswY2d0QmIv?=
 =?utf-8?B?cDA5M0t0c2R4T1dYSE9QUDJmM2U0azRaMFRPeHVSYVNJdVVIdG9aZGpMZVNv?=
 =?utf-8?B?UHIxTE9pRXBDSDcrUml2b1dSQzNudVdqWVBkcTZ1L1NVTHB2ekx4L2JNMWVt?=
 =?utf-8?B?dWc0MkNhQWIxWktmY1FEZ2xjdmhIL3FMRjd5NnRuMXc3RmhqbzJtL1hwd2xP?=
 =?utf-8?B?UGI5bDlQOFN6UzVhNmJ4SGRpUnpKNlZXUkxRL1laR3hzbjkwTFcwQ0NyMnRR?=
 =?utf-8?B?Uy9makg1WnhNTUVCbENSRkxRMXlQcnNpR0J6TzByQW56blM3dVNHMUx0amtE?=
 =?utf-8?B?eThkRklPNlhnUWZxZGdmcVB4c2dLNG02ZjZBTFNVdzJGZEx2bExkcjFQZmQ3?=
 =?utf-8?B?OXBkZ0l5QTc1UXYyald6QjZDc2ozaVgydm9HRFZoU1lTQ3ZVMmRoYUpLZXRZ?=
 =?utf-8?B?aTdGZGR1QUhtM29TcDJEdGM2MHBTU1hrdVlEb29KQnpNS1Z1VWxCZ0JEbVNp?=
 =?utf-8?B?KytFS08xL0poRzl2VXZDeXFES0JkSVg4dkRwb2V2SmtsMjhnUkVSN1RlS3V6?=
 =?utf-8?B?cWlMR2JaSUd5M3hVNDZNWVNGb2w4bDJoT0pBeXlRSVp0cnYvLy9qRitESkxY?=
 =?utf-8?B?WDlIQnZzc2pGOHhDN1pUdnh5eklkOUxydXQzK0JiRzlCRGUwaGZacExvelI3?=
 =?utf-8?B?NTA1ZGhTTGltS3o2b2h4Zk1kSkJudjk0c2h2UmgrdW8yUVNMQzE4Tm1WbDdx?=
 =?utf-8?B?dUVrSTFUWmNraUgxSDlmYWFGSmYvbzZiV2Q2RDI3WkVFTzNrNmVIS3NVbjl6?=
 =?utf-8?B?WEtuczhOL0NpeGhQTXZvaVZ3WE56VFRicUNxMVpTekZwSnVsT04rRWNTT3ls?=
 =?utf-8?B?ZjEzT0lVUlY4dEhWZmJIR2dnOG94Nm16bDVkMEFvYlRUUitTNEVKUkJ5cFVp?=
 =?utf-8?B?MXdsY0F5Uy9nVmRTMXlkVTRnSy8zT2Z2cDExNTF5M0RjbnViUElDR1pjZ2ta?=
 =?utf-8?B?RXYra0tjaCs3UWphREs5K0hoWGM0a2VGSUN0NWp0RTc0K21sU3BYNkpkcmsy?=
 =?utf-8?Q?P8+/2s2M6mOUb20f6eSoG992eq4i381T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVkZy9VZzBzdk4zUEVsTnM2Q3IvQzN3OUNWb0RsRHpGWXhyVjJ4cDRQbzUx?=
 =?utf-8?B?Lzg1SE5FQUhoVk9nTCtyNmp1ekJKMDQxZUxyOGpoZGxuSVZzZEtCMGxjQVJ3?=
 =?utf-8?B?bTlCalMvN29yRVNuZjduUnQvRGxKT3hHQm5vb1N0M20yL0lIUkpoNEUwY2xl?=
 =?utf-8?B?OVcrL1ZwdWhiZTJNOWs4Z3BDeXFIVzdqM2hnOFUxZWxuVzEvQy9mUUVYZ3Va?=
 =?utf-8?B?dUNDTVduVWRTZEsrQVBiNW9oZFl2S3lUWGVhWlhhdWpzN3FMaHVNb29SMVlu?=
 =?utf-8?B?cW9pdnQwVkdVMjh6ZmdCdXhRaC9YVmRTcWpranVJeU90WXUwTlFidUk3aXIz?=
 =?utf-8?B?YjJGdnhvSWV3SlZSd3A2SHpzU1gvTVVDODNLRnVZc0lRYmNVQjg0ZjQrUXRO?=
 =?utf-8?B?MWFEa053L1FTUVdEb1F6YVlRYmVsempxTno1RkJnUVVBWjdLa1NUaTl1NDE2?=
 =?utf-8?B?VjEyTXFiREtNZnpJaURNNVIwMFRiQTU5NnlKSm1WbVVRQWpSUmtqYXJzZEw1?=
 =?utf-8?B?NUxic0pUbGZ4bTRPbzd0WFJyTlpmeUdXZWp6OWNuK05FL2R6RGYxTEZoSUZa?=
 =?utf-8?B?bkgycVBId1o5N09LNHhoZ3pMMGlHQXRpZ1MyRVc1dGNZdlh2NlNiN1BQSUw2?=
 =?utf-8?B?TVRJcG1wTm5HY01pZE85Q2JxZnN3NFZ1S0N4citKdVRvWVQvaGdCa1hJYmRK?=
 =?utf-8?B?YU82ejROYXVpNWFhRklQMGdHWDRKcHZsMktEZFdnYThvalkxTEpGUUdXZi85?=
 =?utf-8?B?M1dwTmhPUnlMKzNSaWdjK014bGhqd3lrZFhyZU9QeFVYZmM2YTFkS2NLaHlp?=
 =?utf-8?B?YkpqVEV0TktGK29LUXBJYWw0b0NGTUUxRWx2LytraHdvZzdzZ0JUTmNJQVds?=
 =?utf-8?B?ZGhYdjVwMXYrT1dzRnNJUWxJWFJzUmd0Vll6bjlwUFJPTUZPZjJXZ3RjNkpj?=
 =?utf-8?B?TGVWdERzeGxjUWExVitENlBjMGdLL2hoSkx0NUJOVVBvOSsrT1BYN3NBN1U0?=
 =?utf-8?B?NDMrUjJoRTR5RlNvTUI2dlJCZzluWWdrenA2TkxYSUQ5ekV6eEtDa0UrTjN2?=
 =?utf-8?B?VVUyUTQwRlRvWHUzYmF4QjF6TGF3WkxnK2R6SFJYZml1TFZyRWRzazJqbXRT?=
 =?utf-8?B?NnZBYUdGQWtqTUpFOEl2WjlKamFnVUxzSGJCd1RPV05IQjhEVnBTYUxNWWJZ?=
 =?utf-8?B?SzRVRTRQVW9ONFJVV3ZMbC9LbnZIS2F6bzZQaU5uZjZ5WitPdGNGNHpxQWZU?=
 =?utf-8?B?ZXFhWjBRanJTQThCTCsyT2pkOGFOUTlBL0lESWNBWDNILzEyYjVmejZOQVcz?=
 =?utf-8?B?MlNqTWR5Z3JjeEJvaFRBSFpJRGVscU1sWi9peFdJbHUxNjRsc1JzVHRoUkxv?=
 =?utf-8?B?amswYUN0WWxka2RrL0hXd0h6SHZEMmJ3Ty9qSnUzaHhqclB5dkQwNVBleUQ5?=
 =?utf-8?B?SjRtQ3BnNkI0MU93WVNoa3Awb0tVdC9FRVYyeU5XYUJNcjBSZy9qbUxuaS9w?=
 =?utf-8?B?MHN3Qi9NNU1IZ2pjWU1NekJQRFRISzNObytVR29BN3dKdmVsVGdCSkd2OThI?=
 =?utf-8?B?MktiVVNCZDd3YldUd3JJd1poVEF0OWxHcHFqTTdTK0dDTzJOZ2E4RzEzbjJI?=
 =?utf-8?B?Y1NrdUdDblI1Rll1Y2hRMW5CZG9zTG10NisrSFF5czgvQ3hKQ2pBZlk0eTNZ?=
 =?utf-8?B?ZDVvTDd4N3RsOSt6Wnlrc0pKaExVckxsRExvN0RSc29CNExwS1M5b3NBT08z?=
 =?utf-8?B?UVZVU08xUUZ1U3FBNWxFdUdaZlVTbG1uczFIajZjSDVoc0NFbklxNXNwcFZK?=
 =?utf-8?B?VGlTWFJCVXhEL3JPNEJWckFxT3V0bndyOEdGWldqMVF4cC83ejRGSVBOc01W?=
 =?utf-8?B?bHA1QXcxWGRibS9MVHMwd1F0THFlQW5XeUNScFRyYThyVGhtWkRsTWY3cjJh?=
 =?utf-8?B?RGU4SzJWQTdHU3ZaYmF0LzByb0NFWVNIR09DVVc2dVdaK1VWaFE4QWJIM0NB?=
 =?utf-8?B?eCtpR1p4RVl4enB2ZlJFRHFSTEtYRmRuMWZFMmxkLzAxWXJWaVFCK3ZuNThG?=
 =?utf-8?B?b3BnYmhLSmdmbThnRy94UkZYTW81eEN2SmhKUllZZzZ0dFJqUWtPcTZvdmhX?=
 =?utf-8?Q?N8JZHINE4grJqWbrAlt4ubo16?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087e93bc-8d68-4e03-af76-08de2752dd8a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:03:19.5014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrSCPeMUXobDcRBAUeczkL7E0feLPqznuGcVwpjGc+FO9WsQl9meF39PyhrwQiQB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516
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



On 11/18/2025 3:36 PM, Shikang Fan wrote:
> Add SRIOV check when setting VCN ring's supported reset mask.
> 
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 4 +++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index eacf4e93ba2f..cb7123ec1a5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -141,7 +141,7 @@ static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
>   	adev->vcn.supported_reset =
>   		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
>   
> -	if (amdgpu_dpm_reset_vcn_is_supported(adev))
> +	if (amdgpu_dpm_reset_vcn_is_supported(adev) && !amdgpu_sriov_vf(adev))
>   		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 714350cabf2f..8bd457dea4cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -122,7 +122,9 @@ static int vcn_v5_0_1_late_init(struct amdgpu_ip_block *ip_block)
>   
>   	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
>   	case IP_VERSION(13, 0, 12):
> -		if ((adev->psp.sos.fw_version >= 0x00450025) && amdgpu_dpm_reset_vcn_is_supported(adev))
> +		if ((adev->psp.sos.fw_version >= 0x00450025) &&
> +			amdgpu_dpm_reset_vcn_is_supported(adev) &&
> +			!amdgpu_sriov_vf(adev))
>   			adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   		break;
>   	default:

