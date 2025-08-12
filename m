Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E37CA0EDC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 22:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528EE10E010;
	Tue, 12 Aug 2025 22:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UMKKmCIH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E640A10E010
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 22:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCscYLzcMMJCxLNbpvOB2bOzTxzn9uLeGvhu1SWZQY/8WDI7IE3facqzjQ8gozyt4hUb3/1uC2Ed0af/m0HxoYIrQ/uHEakrCIh219nSXWIy4Qr2MCPitgo2bgxSx9+EAy220Jffd+PT38hIYLoW9Rce9mqCkHdfN2aKy1R1c3x71/KRLAzLTZFKfM8FoBeTOB31yHBn2FEgxsiVzV486khTjiAxxGhCG8WvGkp/EsE/67eV/wV4GaPrC7exu030fZaNIXg+RHaafbAK97G7j9ix3GlBwnL2gGvx3U75GPI2RGwL06Z61EjJ/DLxa+acxY9cj7tyASKqBwbsHmXD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KWNItA23FREV0EdaZgciDq4WIfOVDnsIrATCop1Nzo=;
 b=u1a/cYM4OaklD7uqAKufxnFwIfjjZYMq+kVkVAbNbmwan9W2hgS2OKXCcKMutleen2+3o4EHSTbU9P6xHE3/5UeK+QO6YxMEvgixooiNqRg/P99BfUprWNNtEGeHOTDPk5ijRLpiypVtSrxEX8vlirLzZ3MD3pRRXiN0IwOBHcUWf5fjdVQaVKOCR+34of8Nxkwqq0zDIK6Og4OG/ajJJppAvehIt7QC4Q+eAueIZTViuWGhpR0bmb/+1bT9WIwzZWa8gOHBNHSKk4qR0kx2h4BlVsZcZkpMJpgbmxe6Csvo1NAWsZumIraahKkSeAriOV+9rCu2MUZRPwwmfh8dGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KWNItA23FREV0EdaZgciDq4WIfOVDnsIrATCop1Nzo=;
 b=UMKKmCIHDaT2/RHge+N9V3r+XYXGj8AzUXMMpGyfJdIDfOJI7n/OrxeMAXpdEYbY6BjXBb+YdXra1xkR097x3YLE4ZOAZbdASr9PyWQx/U+P3jhlUyS3d8ToUrRuNmnAzFsQ0SMFpdKGPKjgEBESw0NvLjedeJE+1EatbC9ZD5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 12 Aug
 2025 22:52:04 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.8989.018; Tue, 12 Aug 2025
 22:52:04 +0000
Message-ID: <c01c5980-70f5-474d-8173-c6be93b1c21c@amd.com>
Date: Tue, 12 Aug 2025 18:52:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v2)
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
References: <20250812205816.1773798-1-alexander.deucher@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20250812205816.1773798-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::15) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: a48a96c7-34ed-438b-2ec1-08ddd9f2db15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2dMVmk4K2RPYnNuc0Q1QStjcGR3Z2lhaDJBYmZhay92aFlqSEJPSFVkYzAy?=
 =?utf-8?B?c3RKcWkwRjg3clJlKzRUbk9LVGE2b1l5ZFFqRndxWktmOG9nZVJVNXNxMzYz?=
 =?utf-8?B?bG5kU0MwTy8wNFRudC9UZU42VWgwRHRjNWtFMUtmSXZxaXVyeEsyWVA4MGtE?=
 =?utf-8?B?V20wSkFQQ29BRmFrbjdWVXhpR1RVTHQvbzlZaVBqN25yN2Evc1I3b1k5RXlN?=
 =?utf-8?B?a2F0WmlKM0Y5TVhCSzRxejlIOEYyUytyRDc4QmVoTUh6UWVkMGtsT1EydUYx?=
 =?utf-8?B?aWlVeVNEVDBBckF2dmtHNThvUTEyaEhRRlB4N1FhRWl5Skc5cTRucUhieWNW?=
 =?utf-8?B?alNmbWxybnk3SUNkTisrTWF0TTg1NG9UcS9lRmI3RW5hV2NpWXhYY0NvQkM1?=
 =?utf-8?B?M2gvUkVzZFNSTVJFc3o4NkQ2ZlJkUkNkSDlMMzFnVktpTVEwS2JRNXJsbGdC?=
 =?utf-8?B?a0w0NXA2eTFxVGVJTi9rQkNmeisyUnJKektjVnBnMmc1bDNEdDZsUEpyRk9Z?=
 =?utf-8?B?TWFzSmRSWk1valdScEVtczBRMzBnNkJCckNSUGlDWW5pTEN5aGo4cXVPUjA3?=
 =?utf-8?B?RFdPTlIxcU15QWROckt5VytJQ1g0eVUwcFBLeVdPeG84WkNlUzN2K243UDdS?=
 =?utf-8?B?UW1ETDdZNlRCbG16dHUyTy9vTXhSaWVlbFdCWWhYYjJEOE41Vjl1UnBES1pq?=
 =?utf-8?B?eHViTnNVckI3MDV5Ti90VzdCVzNkOFZ5d3p0Q0lxRUl4cENrQ1JzNHNwcVZZ?=
 =?utf-8?B?ZWxYZElDUGFKSG92RGpWWWh0bGphNUwzNzlTNXVxM1lTSmNqblBXdHdUVCts?=
 =?utf-8?B?YUZ1Y1gyRlREYmZ3d3hvZmxiV1c2N3JFekJRWFVFRzlmNUlIdUN5SXFFZGkr?=
 =?utf-8?B?RHcrUWNTblpveUY5RDY4S1ZxN2hndjNFMWg0T0JWYU4zd3JZWWlveWhTeVB4?=
 =?utf-8?B?Y0hKTml6Tk5vN3QwNjJjdTRrQ1pLVXg1ZE1JdUdOR3p4UEdRbHNLelFvLzBE?=
 =?utf-8?B?Sy9oaTVFUjFQblpKMS90czZXZzRJbFA3WjQrd1BOaEJQYUpzOFQwV0tVTVJB?=
 =?utf-8?B?dkV6MjJTL2pVTnNXdDczT2Fjbno5TFZ3MlhNV3VORnB3RDRLdnpFRG1GazZq?=
 =?utf-8?B?cjhSR20yWHRLNm9FYktzTEhYMTlpTDlaaFo1OWRhZW9JQm1CL1NLZzdDMVNH?=
 =?utf-8?B?MEN0UFFINVNPYXVwYlJjY2lBYmF1akkwdWpyOEoyU0V1TVZwSFNXNkt4V29T?=
 =?utf-8?B?eEcxYzBkS1RlMTlSVmVyRU1aV2s2YXRhU3V0S2h2akd5elVjRHVMRmx5VS81?=
 =?utf-8?B?SVFTV282b0xIbkl0RXNiQ05FMDYxZkxFRVlJQUlrMDFnbVZPSGxQNDh0UHFV?=
 =?utf-8?B?b1pMaVJ0dnFnUlRNbm5xVEhQb0FoZEZXQ3pRZll0UEpUUU9FSnBQNnN1c2pI?=
 =?utf-8?B?N1F5WWtsWEx3WXhZajU1L3pqSitrc3Z3dFBQSjlXNlh4VWNWZ2NCejZWajAv?=
 =?utf-8?B?WkhkNURlQmNaU1NLOGU3L01kN3ovMDRETU5CUUxnckVXMWJYV1NsbUNyemtU?=
 =?utf-8?B?cVJPa3ZFQytlRktVaDdsa21UVEZwRzRlb0J0NjFwRk1FZTJvNUZhUHUrNFZ2?=
 =?utf-8?B?WC9MM2pHWDEzQ0Ryb3Jqc1p1Wjd0K3IrN3NGL2g0YWt1UnpDNm1oeHhWbUZC?=
 =?utf-8?B?a1J1b2tINmRSRTlJVE9ydm1Ibnh4aGNjbFp6ZzgzSHRxcHBUV29VYlVhVUpM?=
 =?utf-8?B?Rk5Ha28xMjcxdEdIUTM2MGozZFZHS2FQK1REdVA5eXBzSlFCOVNaUWdWakR0?=
 =?utf-8?B?MW5LSFZKd0VUQUgzQnJQdWxkMWkvdk9tS1AyYU8vY1A3Z1lWS0tIM3B1K2Zj?=
 =?utf-8?B?V2NBTkpWQnpmQ2lRNWUxYWFCUFBlMTgvRllua3p0MGNuNStwNm15NGloZXJj?=
 =?utf-8?Q?Nqc9IVgzHbA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZNQ0swcnh1S1VQTC90WGZMbEdFN3c3UkxOQ3Z2ZkRIelQwYVZPSGR6NVFE?=
 =?utf-8?B?VFB2TFZWNk5QWkdNWHZaODhlWWxVUVROVVA4N2FRRkpHYzVkdnBjTnpMTmh0?=
 =?utf-8?B?dGlzdW9IOFFJVkgxamYvQXZ0OWhXQXhWV1lGZ2JwblV0M1ZpSFJHamxTd1lR?=
 =?utf-8?B?d1NqWG1Ua1RnUEVMWks2VmdCbHYweVVCOUwzNTZwNk5UUVZVaThIR3pXL2Y0?=
 =?utf-8?B?NzNIRWlHczdwdDNMc1VFcEdrdGp6WkwxcHRVdWE4Tml4RnZleXRHY29GYkRZ?=
 =?utf-8?B?cUFOY3JDMWh2VjdMeTgyR3h0Und1UG9YVTBrSTdFOEdTdEtoaVBsd2tBYWtn?=
 =?utf-8?B?NWxUZ2Yyd2QxMFViYnY0UDZJY2FSM05VektsZ3gyaTcvTExQY2o5UzdPellZ?=
 =?utf-8?B?VzUwYUtYYXdsV3lIZUZiZnc0MitDd0RRT3BBaW1tZW14QXpMcDJ0MEp0cmo3?=
 =?utf-8?B?SnBsalRpbTBRNFhNdDFWREJDcXZXNDdzREtzUTJnUGRueHhCZmIwWFBDRWVq?=
 =?utf-8?B?NGpncm5wWG5zcmNXaCttSThTckt0NFRiRVUvaVJnaDg3SnNKbmVxVzJpZ01a?=
 =?utf-8?B?N3M0SHRnbTBtc0hwVVJNV0JGUWFtL0ZWa2pEd2ZCN05xTTl1ZmliaGVrVzBt?=
 =?utf-8?B?SHd6ZHBZR25jMlk3VXVCTGdiRUJGRVQ3TTVDTzRsNk5hYzhFdVpTRElxV2kr?=
 =?utf-8?B?L3NDZytrREpjRHc0YUQ4VTRVVm96bjM4NDNzemMydEhvQm13NGhBSVpDYm1J?=
 =?utf-8?B?MGtsdHlhWE1WV0psMVJNeGlVVlltWUNPelhOWlFjd1JDWkdEdytNNFpIcDlG?=
 =?utf-8?B?a2xMaUhzQnJtMStST2MxSG02b2pQV1R2RExqVzN2N1VOdnk4U0lreEhKSWRF?=
 =?utf-8?B?UmVCMTFuWnNkQUlCSFNvOCtzSXZ0SXdiQjNaSmpDL0ZYWjFDbndtYUcrdHg0?=
 =?utf-8?B?emRBVXlUWjBDT2NDdG5uTC9mOW9tL1NmL2drb2xhdmNUbXVJSlN5RlBUdEVo?=
 =?utf-8?B?YmU2TXZqUlFkT21PaWJ2bnNldURkVzhJdGg2VVFMOWJKT0s3L21JWG94c3I4?=
 =?utf-8?B?YlJhY1JGalVsclhZbWJkYUFGSkM5Q3FKbG84SjdyL1VzdFltVjV4M0Z1Zmhk?=
 =?utf-8?B?d3FxMXNSdndZOEp4bG9USFJTeVJQemM5VEo3YmhIUkJiY1k3NnpKTTRLR21x?=
 =?utf-8?B?RnFLdXBkd0IzY21BOFRNbHZrRVJ6NzlRQnJMY0lsZGJZQmJ0NGNTV3Q3RUhD?=
 =?utf-8?B?VGRIRDdJQndOeHpEOFo1L0FKZmdYU0pGQWVzS2M4MFBudUZEeERqME42cjZj?=
 =?utf-8?B?NVV5cmpjQ005VlFJVXFSOHgyYytJSHl1bXhZV0lQQXFWdzh1TjN0ZFFqRzVG?=
 =?utf-8?B?RHViTFBUSTFRcjhjVlo1M1VaTWpwUWdIbS9UT1FjRTBhRC96TXNzdjdyeHZo?=
 =?utf-8?B?cmdBYkxZbWlMYnN6TFZSUUU1UEg5bW1xSW9Jc3lNbXNLQVN1dVN1WHg1VTBt?=
 =?utf-8?B?bmw1eVBVS1JCSXlnU2oxN0FuMDVSTDZTQ3Zka1RRZFRSSGZjUFRaRkw4NDF1?=
 =?utf-8?B?Y3YxMW1vYnB3ZVFpRWd0VXZLYTlKbklyQ2F0dkYvczN3b1MwQmZ4YndXMC9T?=
 =?utf-8?B?SExKUkdhSk5MSkdaTGtqVmtPek8vZ3Vpajk2VUVrNmkzTUtQUUtyVzAxQ3dE?=
 =?utf-8?B?Tm9jTGxPR2hkM1BlN2QvNlV2Wit6cGhiSCtySUJKNzV1dFpMdkJyMGRqWFdp?=
 =?utf-8?B?RDlOaVhwajJXWXhjVHpQaWpzZkZleGI5dEJUWGd2aDYwajZ5T0l5R3Y5WTM4?=
 =?utf-8?B?R0w2dmc1MFEzOEcyeDRZTU4rb3AwelM3YlZ0d09ZRDFxODZYdFdFWm0yNG1t?=
 =?utf-8?B?YzRnSlhBR3NkdEF0Y3dCUUNadzZTaWtmUzZEOHpBTi9TK3drelF4YzdreGVW?=
 =?utf-8?B?aTdwOXBBWHpOaTdPVUVhZmthV3hOeGd3dEI4TkdCR3A2cG1yRTNKOEtlV2RO?=
 =?utf-8?B?VmNIR1pBa1VqdXJrbytDRXZ3c1hvZWpaNmlreGdYTkErenFFaXE3T2Nsa29V?=
 =?utf-8?B?TUl1bUpobEd6WHhBUjUvOFQ2RHllMjJoQ0o4eEhVSW9jQ1BxaVVnMjR6VGw5?=
 =?utf-8?Q?NDbAEgOTZsKHjyxuSnTp/D5Fw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48a96c7-34ed-438b-2ec1-08ddd9f2db15
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 22:52:03.9365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLYSqtL04oOWV+PMZXaYSSv0UFnAbBoGNku6c6acd7uNC1dVCkA5W/G0hQ8Y4TroOjgHPzdf29zT+1fy9icWVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
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

Hi Alex,

still have a concern - the fence or submission_cnt could increase in 
begin_use but idle handler
has finished counting it (as 0) so it could also power off vcn.

David

On 2025-08-12 16:58, Alex Deucher wrote:
> If there are multiple instances of the VCN running,
> we may end up switching the video profile while another
> instance is active because we only take into account
> the current instance's submissions.  Look at all
> outstanding fences for the video profile.
>
> v2: drop early exit in begin_use()
>
> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling")
> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++-------------
>   1 file changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c184..fd127e9461c89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -415,19 +415,25 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	struct amdgpu_vcn_inst *vcn_inst =
>   		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
>   	struct amdgpu_device *adev = vcn_inst->adev;
> -	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
> -	unsigned int i = vcn_inst->inst, j;
> +	unsigned int total_fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
> +	unsigned int i, j;
>   	int r = 0;
>   
> -	if (adev->vcn.harvest_config & (1 << i))
> +	if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>   		return;
>   
> -	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> -		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
> +
> +		for (j = 0; j < v->num_enc_rings; ++j)
> +			fence[i] += amdgpu_fence_count_emitted(&v->ring_enc[j]);
> +		fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
> +		total_fences += fence[i];
> +	}
>   
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> -	    !adev->vcn.inst[i].using_unified_queue) {
> +	    !vcn_inst->using_unified_queue) {
>   		struct dpg_pause_state new_state;
>   
>   		if (fence[i] ||
> @@ -436,18 +442,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   		else
>   			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   
> -		adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
> +		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>   	}
>   
> -	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> -	fences += fence[i];
> -
> -	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> +	if (!fence[vcn_inst->inst] && !atomic_read(&vcn_inst->total_submission_cnt)) {
> +		/* This is specific to this instance */
>   		mutex_lock(&vcn_inst->vcn_pg_lock);
>   		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>   		mutex_unlock(&vcn_inst->vcn_pg_lock);
>   		mutex_lock(&adev->vcn.workload_profile_mutex);
> -		if (adev->vcn.workload_profile_active) {
> +		/* This is global and depends on all VCN instances */
> +		if (adev->vcn.workload_profile_active && !total_fences) {
>   			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   							    false);
>   			if (r)
> @@ -470,13 +475,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   
>   	cancel_delayed_work_sync(&vcn_inst->idle_work);
>   
> -	/* We can safely return early here because we've cancelled the
> -	 * the delayed work so there is no one else to set it to false
> -	 * and we don't care if someone else sets it to true.
> -	 */
> -	if (adev->vcn.workload_profile_active)
> -		goto pg_lock;
> -
>   	mutex_lock(&adev->vcn.workload_profile_mutex);
>   	if (!adev->vcn.workload_profile_active) {
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> @@ -487,7 +485,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   	}
>   	mutex_unlock(&adev->vcn.workload_profile_mutex);
>   
> -pg_lock:
>   	mutex_lock(&vcn_inst->vcn_pg_lock);
>   	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>   
