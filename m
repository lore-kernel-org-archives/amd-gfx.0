Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF982C43327
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 04:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BD7B10EA88;
	Tue, 30 Jun 2026 04:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3IL9CBWN";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB8710EA88
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 04:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0IJAqHUMiLh6uOZh/84FImN/RFhqSID4SUO6giVYjv+ff2ZDwl5eHJOJB9EHm+7uMHvUKC4Jey1IQecDNAwCzRmQyzTRqIRXqw4MIW+naWeFpVan/j0ZyJYc29+hRBA8hdOyfuBBJP2BlPM4QI7HBoDMg9JT4+aO+xKaEcNYZs9y4hCOWl5j6/DYSketnUFDXNTU11eo5ZQfTlLqYJUbj9g7qpynenHjc4MSgpLW8RYvf/wgcrKy2HavL7ovvCl/+dXwqvRdipPMgmB4z464fnx/3dhF/qW+vt/PK/N4p6SOQFO0EWjBVzFUNDmJmW541OgUjMOnv1BWgakIBa8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSgjepJkH9MdzHnlnmu+ogKsoLsX22gmHSP1AAEpsUo=;
 b=at9rN/X1E15yANE6+nnX9j+dDzAn0WDj9mvKakz25LfXyFRn4t/U2fADli/Eyb2HfFsUnZEy7xF+2gpZmzVZy/qeUAel8uxUc9SuQl8b6x1NlBnkuzbOKF1T3mWKbBEvzfDdjiafxhafP29c0kxPP4lE3a16siKmwKq3QPwICQUwnucNnZh3S+K9fovEBHWNFrCy06aD+jvSw0uJcUPkkC9iqAnFZia4Epy1d8DFL399ATQbqg4Y/1NV3sI3f+6og2Ed54iKJsT8BQbDHlW9ZY1FxWa1D8ZEU+NBBXS7rMkgykABsM3VkVpiA3OuVdXdcmNkZmtFCtiJ7jJ5V8vjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSgjepJkH9MdzHnlnmu+ogKsoLsX22gmHSP1AAEpsUo=;
 b=3IL9CBWNj8ryS7xvwi6ZHBGBJ9q/doxvfJk1Htsswifegzla8LzUL1fgm+nkdVTD8woA9cd0uDEc4GLj5RsLdszBPTIh5jXexO4l+g96HV7k/fyHW2H/Aaa9bemOnzPzRO0YB/LBSg0vjOicKOzUeOoin5Wq02Lkuv1v1SB+5L0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:53:58 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 04:53:58 +0000
Message-ID: <4cfdf4a3-0a96-4f17-9f80-684e04935aac@amd.com>
Date: Mon, 29 Jun 2026 23:53:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/amdgpu: add support for GC IP version 11.7.0
Content-Language: en-US
To: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Pratik.Vishwakarma@amd.com, Suresh.Guttula@amd.com
Cc: Kanala.RamalingeswaraReddy@amd.com
References: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:806:127::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: bea3a55b-074f-4636-e026-08ded663983c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: OUNlJd8fMkpMxj16tU9OG1vejfST4qDD1/GT5FdpQQCZy0HNxlfnSB3Bm0D0U0YcuQ4qVAwdP0V2gEvZ7TSdFbQw7sjGndzGnwwcHz/+nMApwtAZg7dsap2nFZakpW9j8r+A6/dWq+qLPKIOquthfo3U1jgsj2A5ofFlD4eDQLe29/j5IrZaJZvYx6JybfwfJT4vojoSklCX5UYmpcHv3tWWDT3sl9A/FbpinTWPhtWHor2CfpmcUlQyT5cIXhZ+1Ou3CTIFEJKAhlksZvJ5pp2tTbzl9+3lBtBl2Ys+l07OGWJbyZscT/OXmfXkIv1KRbUlP7eLMHTNVYP8sAvFA9dfxRy2mZo3TZKWD4IcxbkgfbSFc4BJ8jlZzwD+1UM/hpyB+3pkUEa1oeC0Akid/J6X1wBw1hn98EDLHkxo7m3g17tzj0le2MR2Km4xePNrKRPX9fLtxAFAzCGu5ddS799dCUlmo2jrVLMjx4BUIyocazU7eiqWZcRK+FOpwj2ToUWn6XnGjUI1FEI2E+CjCtGGRPmat1OWJy1m92E64myBdcBmKq+MpRKIRO6G0SZkOT/c6QB7BoihJ3yIEFsA06mn+1q1tq0un3T8YXSnipVVFLtcm/i7Z8Sii6ofLkXXlaYmSeIhpCsUXcbhSQU/vbf+2w8AYPWadi0yd/XfHs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0Y1eUZwL2UxaXVuVjRYYXMxTW1hQlJjN01tckJoMGhaWWVNSGpISkl4Nkg2?=
 =?utf-8?B?Zk5RdVQwVHpwTEVicTQzcHh6SHZSZ3JvK2phOGhXaHJCZ3VyeFY1aEcrM01Q?=
 =?utf-8?B?bFZNVUVSenhKMGl0T2t0R1h3cHU4bTh1Zkp0dFE0WkJicXFBVzdaYzlEd2xq?=
 =?utf-8?B?TlREeXUvNzRxU3hyV3VhcGdXNUpTcVZ1V1A5SnZQSk15bUxCb3ZjbnFzWlJB?=
 =?utf-8?B?Qk5vbWx3V25qc1pXVExDK2FWVkVBbzNDRzBOcDZmVE1OQVhrdTlIUGhIRC8r?=
 =?utf-8?B?VjJVU3FkZXBNSTVCN0o2WFRlVWFNd2JyNnBIREYxOW1KTUJCV25RcjdObXBt?=
 =?utf-8?B?WnEreGFyOHFXZEFYUFdrdUdwOWJHTVl5VFE4MlYxKzgzVEpWNDNlTVZxN2dY?=
 =?utf-8?B?NS9ncWl0L00wZVZOTmJlUTF4djlrMmRzNUV2d2V2dDNtVE5LQStIZGNDTnM5?=
 =?utf-8?B?VTJqMFRGTXVwaTNHbEYySlk0MXdhYTF1YXNCZHhmcVFkMDdHaEhEQ3YzVkN5?=
 =?utf-8?B?OUs0ZHNoZXp6WHZMVnJrZTVDV1V3dzJUSmxzV2IxbEFGNjlya3d3UXNIRjFv?=
 =?utf-8?B?TnExNVpJM3BHWFNtOUx3Q2cweWtTMEZ2MHp6QWhKMDF2TW9ic1VGVitQU0N6?=
 =?utf-8?B?QnBvOGFwMUNpNXNZeWpCMHVNSTM2ZVUwZlNOcUFzaWZwK1hxSDBXak9PajBF?=
 =?utf-8?B?eU5OR0ZRTk9XMWhvUSt6cUpGd1d0SGNUbUxYVHEzanZ4UzAxZ2RxZCtpTDFO?=
 =?utf-8?B?ckVEb2NNQUlBckVmZlI3M3U1cEhHc1hjbTJOSURTL0UySWl1d2NaT3JYRi81?=
 =?utf-8?B?Ty9hTG5wemx4MG53UHBxVHFwMElTRUhPV2YxRVpDeUJRUU52RGNmaFpUT0Mz?=
 =?utf-8?B?Z1EycTRFZmNHZ1hRejFMMElJcmhZbmhXR0k0SXhqUGYzN1FLLzFJZHJON3BU?=
 =?utf-8?B?OURnTWdPYXBKUmU1YnA0RlI1NE9pZVZzbkUzN1BNa3BBbFRZd2x6Nlg1K2hH?=
 =?utf-8?B?NGlPWTFLcUlQc2x5WlBPelNQQ3JKMVZoVWZ1VDBaZWZKdmlvNUV4c1JIQmQr?=
 =?utf-8?B?RUxuUEcrbE5VM2dXVzhZUTFEanBabGQrM04rYWIxOWc0ZVFVK1I5dTNvanFM?=
 =?utf-8?B?c2RIS2oxVHRHWUdLVXcvTU5oWWppWnlJVXFvOGxFYTJlQ2QzaTFZdVhMeVNl?=
 =?utf-8?B?RXNXR3VtQVhkOENjRTRwaC9SM3A4NHc0cU1YelErUzg1U2lXTDFSRTlzNVpq?=
 =?utf-8?B?WmhTRVgwZlJEaFNsc1dxaVF4SnNXRnprbU11bmlMMHJGV0NBVUtSOEkxWVVj?=
 =?utf-8?B?UktxR0ZocUlVd1l2c2pQUWh2WmI2YTArdVB1L3prdlhRYzdwYW5aNE10NjdS?=
 =?utf-8?B?eWpTMlRia1hPaUFmUmVFcG1NS2pmbTA5aDRWb1NucTd0K3FpbHdSNW9LMVlJ?=
 =?utf-8?B?WERGNG8rY3l4OEo4bTVzVHZNK2ZzbUtRVG5vN0hrY3ErcUlzSTlKKzhNd1E1?=
 =?utf-8?B?bnBOVHdYUzcweVM1eHRUS2xXY3JucmNIRW5rTjBJblFWbi9vb01LYmRmVjFB?=
 =?utf-8?B?OXNIVWhzUy9RRHVjeXVOWnhvTkticGo4bmJJOE0wRHp0UENFcHozbGQ3K2dL?=
 =?utf-8?B?YS9NMDdqd3RFUHNhMmtTM09zZWRaVXp1MUNTYnZ4TXlWYXlJbEtHYjU3eWRq?=
 =?utf-8?B?OFRJV2RmZTdyV2VBei9tYTNvOVFjRHVjNTI5U0dWSkF5bDF4M3BCTmFvWEov?=
 =?utf-8?B?aWZJTlRtdEJEd0pYOEFITE43YVMwZGZKcFB2VGVOM1FBdnp2M21KVkwwMVVJ?=
 =?utf-8?B?UkI4c1JBdWM5aUlBcmg5ZDQ2bGplOHR2b2xiQTIrNDBLN1ZpdGR0blozcGcr?=
 =?utf-8?B?T3Q5NnhrZy9YWVVJc0xLS0t0SG1aZnpUTy9teTdQUjAyMnAreVAvT3R2WUgw?=
 =?utf-8?B?ZTltOVlsTzc4QmpWdWJVK3ZkZ3pDRkg3K3c5WkdsR0NnRUI5Y2dFNEJqd3RS?=
 =?utf-8?B?SmFjVjZaL3BmYjFnQXVUck81R2o0SElsWVl4WW5PMGUwWUxvM0tYNkNjQWVw?=
 =?utf-8?B?ckNPTGJ1aTl5cHZsVDN5Z0N6dHlab214VHFTbE85cDNQY1o1R2tHSjVrdlNU?=
 =?utf-8?B?dWpqL1dscmZ1RnJsczNzTjVDQVVJYi9QUjRvemRlZmxlRjlWbWFMWUswRkdF?=
 =?utf-8?B?bzAyZWVLSGU0ZHpld2NJSmVEb1ZheHVrbnMvRVZFVWJKdHRsSUtLR2ZsWGgy?=
 =?utf-8?B?MXlpWGhpNktkS0FrUk9MWnpVUXNlWm80RVNhWVBIRjJ1VW85MWwzZE94R0Y1?=
 =?utf-8?Q?wU4FbkfDz+dV47ajzE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea3a55b-074f-4636-e026-08ded663983c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:53:57.9888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFyijrAZuPvVQyMbJ7JRvmOIAuQC5aDG2l41pssDJAqG8esAWgyqSKpmnmfIrVtm2R6FMlWEwlN9rCI2Ya4mPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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



On 6/29/26 23:36, Granthali Vinodkumar Dhandar wrote:
> From: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
> 
> Initialize GC IP 11_7_0
> 
> Signed-off-by: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 +++++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/soc21.c            | 28 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 ++++
>   9 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index a229fe9d043b..249b2d556bb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2336,6 +2336,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2397,6 +2398,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2723,6 +2725,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2941,6 +2944,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
>   		adev->enable_mes = true;
>   		adev->enable_mes_kiq = true;
> @@ -3349,6 +3353,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		adev->family = AMDGPU_FAMILY_GC_11_5_0;
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -3378,6 +3383,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		adev->flags |= AMD_IS_APU;
>   		break;
>   	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 2b557c9096df..46b9a477fb42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -977,6 +977,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		/* Don't enable it by default yet.
>   		 */
>   		if (amdgpu_tmz < 1) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 6346f16c4e61..26c02bcb05fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -133,6 +133,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_pfp.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
>   
>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
>   	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> @@ -1128,6 +1132,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		adev->gfx.config.max_hw_contexts = 8;
>   		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
>   		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
> @@ -1612,6 +1617,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		adev->gfx.me.num_me = 1;
>   		adev->gfx.me.num_pipe_per_me = 1;
>   		adev->gfx.me.num_queue_per_pipe = 2;
> @@ -3090,7 +3096,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 2) ||
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3) ||
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4) ||
> -		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 6))
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 6) ||
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 0))
>   			bootload_status = RREG32_SOC15(GC, 0,
>   					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
>   		else
> @@ -5765,6 +5772,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
>   		case IP_VERSION(11, 5, 3):
>   	        case IP_VERSION(11, 5, 4):
>   		case IP_VERSION(11, 5, 6):
> +		case IP_VERSION(11, 7, 0):
>   			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
>   			break;
>   		default:
> @@ -5805,6 +5813,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		if (!enable)
>   			amdgpu_gfx_off_ctrl(adev, false);
>   
> @@ -5841,6 +5850,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   	        gfx_v11_0_update_gfx_clock_gating(adev,
>   	                        state ==  AMD_CG_STATE_GATE);
>   	        break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 8eb9847d9e1e..8a0a88551461 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -606,6 +606,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
>   		break;
>   	default:
> @@ -781,6 +782,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>   		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
>   		/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index f5927c3553ce..177d702e612a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -43,6 +43,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_2_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
>   
>   static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 9e27d01cbfa3..3ee0c9ee262b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -60,6 +60,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
>   
>   static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 963659deeaff..9b9b13e327d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -838,6 +838,34 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
>   		adev->pg_flags = 0;
>   		adev->external_rev_id = adev->rev_id + 0xd0;
>   		break;
> +	case IP_VERSION(11, 7, 0):
> +		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
> +			AMD_CG_SUPPORT_JPEG_MGCG |
> +			AMD_CG_SUPPORT_GFX_CGCG |
> +			AMD_CG_SUPPORT_GFX_CGLS |
> +			AMD_CG_SUPPORT_GFX_MGCG |
> +			AMD_CG_SUPPORT_GFX_FGCG |
> +			AMD_CG_SUPPORT_REPEATER_FGCG |
> +			AMD_CG_SUPPORT_GFX_PERF_CLK |
> +			AMD_CG_SUPPORT_GFX_3D_CGCG |
> +			AMD_CG_SUPPORT_GFX_3D_CGLS |
> +			AMD_CG_SUPPORT_MC_MGCG |
> +			AMD_CG_SUPPORT_MC_LS |
> +			AMD_CG_SUPPORT_HDP_LS |
> +			AMD_CG_SUPPORT_HDP_DS |
> +			AMD_CG_SUPPORT_HDP_SD |
> +			AMD_CG_SUPPORT_ATHUB_MGCG |
> +			AMD_CG_SUPPORT_ATHUB_LS |
> +			AMD_CG_SUPPORT_IH_CG |
> +			AMD_CG_SUPPORT_BIF_MGCG |
> +			AMD_CG_SUPPORT_BIF_LS;
> +		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
> +			AMD_PG_SUPPORT_VCN |
> +			AMD_PG_SUPPORT_JPEG_DPG |
> +			AMD_PG_SUPPORT_JPEG |
> +			AMD_PG_SUPPORT_GFX_PG;
> +		adev->external_rev_id = adev->rev_id + 0xF;
> +		break;
>   	default:
>   		/* FIXME: not supported yet */
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index f28259d13818..a6a7888c7a8d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1715,6 +1715,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
>   		case IP_VERSION(11, 5, 3):
>   		case IP_VERSION(11, 5, 4):
>   		case IP_VERSION(11, 5, 6):
> +		case IP_VERSION(11, 7, 0):
>   			/* Cacheline size not available in IP discovery for gc11.
>   			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
>   			 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 67a17458f4e9..bc05ae15c1cc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -169,6 +169,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
>   	case IP_VERSION(11, 5, 3):
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
> +	case IP_VERSION(11, 7, 0):
>   		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -451,6 +452,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>                           gfx_target_version = 110504;
>                           f2g = &gfx_v11_kfd2kgd;
>                           break;
> +		case IP_VERSION(11, 7, 0):
> +			gfx_target_version = 110700;
> +			f2g = &gfx_v11_kfd2kgd;
> +			break;
>   		case IP_VERSION(12, 0, 0):
>   			gfx_target_version = 120000;
>   			f2g = &gfx_v12_kfd2kgd;

