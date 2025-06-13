Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE188C71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838EA10EA62;
	Fri, 13 Jun 2025 21:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gXZo+poI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5522710EA62
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4OsqnHaoCrFtOq9FLJSs/KmVa71qDWutxSg+/NXZeD4x4dmyPGPMi7T3bSEYtzq//UdjLzAK1DHn4jKd6M2Gf5oOYI6QSEm+pKXK76edClMIMiOL3iNvytM5t+wPXYmKkqIJv4egFTovHPaI04AnLiy/InsB8py5Xz8fGHuq/X/ungNhwyZcF4q85UeSDiJYdCYbrSBsVpMDsitTjOZUvBiNwVdjeelDjXCX6/YdI627p3NoFdima/DeLmzptlwvdJ4XrBDJB50aHFWWcR0L8e/5ZTIgni8VZyoMi6yQYPCp6678SAC0yh+a168snmok80Sk8Rd4bgG5mgeADyJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqNhnk26w8X0zsjuRVy99SviMr4AnXba5FR+RmHwTRE=;
 b=T7tbRgW/Yaf7x3fbnCVf8yhu+rdBLzsveZG7ZMg7MxxsuTeZmtbfs6ars6djM8C+JsnE/rg00DQoYz8WeO0lCrwWXeaYMrb0ljpGO+MRvuMcftKxKoCO6iWXOw9GbYUKLqZPc41wDxzRs2WpE1XfFpX4OZDioPbM85uTfmtvh4ba7PFvVNoahCyKgoJUXKDgYVP+IHsw8up7qp6FKNOiQ/xLXDie2O+/st9ZgJwYRYrgaNNqv/M+kVraU4B4Z4XOAdfM71x2L0K3MDBU9qu9HYsvNDKUs1ZVml+MI9bixrzH0FDhHrazhwCviy+rzt0IQr5K2swBKmYzMyedyCM9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqNhnk26w8X0zsjuRVy99SviMr4AnXba5FR+RmHwTRE=;
 b=gXZo+poII31rOnMUCxbsaMIT88kMn38qEkYjxPO11dZWJ+S6MjY8SRXUfYY/tMvaCKlPKHscZDMX4qtSTWMG0V8SDuQU5cZXoABoypBRXAwnQbZ3rkbXhdJsTgUZbHbPKlWzv8/B8oS4lyEGP3EzjBWc9cG1mWkJn3pO102ymOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 21:56:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 21:56:08 +0000
Message-ID: <1240341a-d19b-4a54-b18a-a4cec00c606e@amd.com>
Date: Fri, 13 Jun 2025 16:56:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Adjust output for discovery error handling
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
References: <20250613214101.4117000-1-superm1@kernel.org>
Content-Language: en-US
Cc: m.seyfarth@gmail.com
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250613214101.4117000-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0070.namprd05.prod.outlook.com
 (2603:10b6:803:41::47) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be826ad-8e6a-4fef-d7e0-08ddaac51a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTM2bFIvU1lwL1NlRFd1aUprU0ZpSVRJcG5ham1aNEhTdEJveWZkVURaY2xm?=
 =?utf-8?B?MUVobzhEKzh5czRwTU9yR0RjaFA4cisrZFdRT0RMUkpUVG04ZEVGb093UVZw?=
 =?utf-8?B?Zkw5d00yb0s5dStlQmZnZmlGNkNRTVNXa0dudnlKYWxkS3E0bEZQSGJ0RS8w?=
 =?utf-8?B?K1IzWDRabFVjb1JSVThyUnFrVzgzMDZPYW9CUURNTGhBU3ZUaWVTUGp1NTAz?=
 =?utf-8?B?UmpHa01SbkJCK083cmMzbXFJcVFhQnpmK0djM3hGQXR2aFdtbU9qQThjdk5L?=
 =?utf-8?B?WmZzSkJFb0x5WXBzTkpuRExPY1dLbWVKdS9kcllxNTl2T05vdGwxYVc5bnVy?=
 =?utf-8?B?Z0hicWhLWUd3dGZmZzlGWmR1ZmI1TWRTSXhySFJVRXRORlVoMGFQL3EwRERG?=
 =?utf-8?B?M0gzNGt2SWFmakVObHRLZUZ0VURBKzVxR0lkbU9odndQeGZnWHFnenFZU1VL?=
 =?utf-8?B?bVViSE5kczc4Z2JRR3ZJSDc1ZklmYlY5b0piNXhyZy9uaUllSmxWMC9oak5p?=
 =?utf-8?B?UUVqNzYvQzFkVkc4bWJobXYzYkt5ZGpJNXdhT1BYVDc4MVdBdGpLSTJpbnlY?=
 =?utf-8?B?QkdHSHBESG1RaHpPR21zQnBlU3EvVXhYWEF6ckdHdEJyUi96cVUwV3ZzbG9R?=
 =?utf-8?B?SlpCRWxsV2hkeEtUQlQ2UGpoTnoyK1gxZ1A3ZjdLN0VoTWF4YmRQYTRCZkZL?=
 =?utf-8?B?Nzl1QUltQjRSa1VKQkV0QVJBT0J0OWxucm9lYklQSFdSRHdsVDBBYzVhZDhU?=
 =?utf-8?B?cnpLMG50L3EyR1htUlVtTk1FQWI0NkJuenczbmlqVS93azlhQUozdHNiT3Z3?=
 =?utf-8?B?RnFobVVmMDcvRHpBYXpjOVE5WUxWMXNHYVcveEU0WkJONUlobzFFNEVtekJ1?=
 =?utf-8?B?UUdvbGkrNEx5N1JMZ09mR3BrZVJSZEYyNDZzaHFDODdxbGwzcFgvQkpiN2p2?=
 =?utf-8?B?UTE0Z0ZLS2thYitVSGp6bTFjbVJ0VDU3N2tCS0NQZkRoejVqQnhDaEVJOUtX?=
 =?utf-8?B?Y1pDdllxd0E1bHZCYWszZ0l3bkdiVEpTSU9LQ1I0b1F5M3dDQ0UwMkFOSGl0?=
 =?utf-8?B?RG83eit3QkFXRkNvV1FvYmp2QmRvRWlxZnlWeEVsM2JGWmpFUkptS1NMMWl0?=
 =?utf-8?B?WjVsS3RHYmVJanEyaWt0K05MVmlIUWp3VFJaUW51K3l3ZzROYjliZEtQSjRh?=
 =?utf-8?B?aENWR1BNVjJ0WVp0L3RaV25MdHB2RWQ5cU1XNThJZG1pMFVVQjhQTE51Z01L?=
 =?utf-8?B?ckJWb0dKdE9tTVBMQU43c1JKcDllR3IzU2Z6Z052Vm1hckZTZW1DSHJsZG5y?=
 =?utf-8?B?elhSc2tGZlpFUHRZd05vU0oxM3Rjdm5pc3F2UFlKS1gyWmdCVXdyUWVYcUpq?=
 =?utf-8?B?YnRCNkNwSnU0M1ZQTEh5aXB2dTNiNmN2cWpabmNCQTlvekFGeXZWTTdVRFAv?=
 =?utf-8?B?Sm1zaWRuOVM5UUs0YmlMZC9rbVhXZnlLaGx3eHNGMVNtTEpLbUx2Z1NEVUlJ?=
 =?utf-8?B?Qkp1L3luT2JyZ1VnQVVOYi9KWVoxdm9iWmdzc3pzZGFtb0tjWXNDd0I2WVl2?=
 =?utf-8?B?Nnl2ekpzbGY5TnpkdVVRWmY5ZkREMkZVWElZdjF1SkRlKzJGaEJlMkZDVnJy?=
 =?utf-8?B?U1JnOUtxNzVQZEU1a3NGNGtkeWpmV3dQdHpKdkNqK0lMenpqRVlpazgvUEE2?=
 =?utf-8?B?QlpRTU5TN1dHRG42M3Bkc1hGOGFDZURqWWUrVVZlU1V2blphbTBQS2YrMnBi?=
 =?utf-8?B?U2J4NWlVenJVMUoxTlV5ZkJuWjd0WlBFWFVkMnhwVlRCWDdFNG9yeTBMTnow?=
 =?utf-8?Q?10Mjl24eEL774U0lt93tw6aAI9t1DLSkPTEr4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJCaHRtNU9CVG1lekIrVVZwZHlXYVYxM3pBQjhqaTZmTzA0d0x5UmwvaGZn?=
 =?utf-8?B?M3RPdEY3YzBQblpZZDV1UTc4ZmhHTTZ4endZWTgvZVp4YWNZMzZOcTgySmgr?=
 =?utf-8?B?Y1ZaSWkvNjhRR25CYmptQTdHcFdtNG5YK0JZSVhqdmxvQ25xU05KRFhwdHdn?=
 =?utf-8?B?a1FFN2RsWW81QWZHKzRUSElVeEt4Q2ZRbXpPMEtkMUR2bnhZSS9nNzIzalhw?=
 =?utf-8?B?c1J3WVhTVFJsM20yYWRDUk00NlpmVEZWRlBNWkhsUVgvcStOZlFuQ2hnNklY?=
 =?utf-8?B?MG93QURPQ3B3bjZ2b25IK1BvcStwTmNIZkRxWHQ2N2RGZXo0c0NjS3d3VFBn?=
 =?utf-8?B?YS9hNGlPWU53T0N6RUVPYVF1cUkyMkdMRExVRWxjZTh2MjNySUFiYWpPY2sy?=
 =?utf-8?B?c25IcmRvcFJUSEl4dm02eWxmenkxS3k2Y0YyL0FVdFE2a2Q3Z1FMSi9GRWMr?=
 =?utf-8?B?OXI2TSsyWVJPSzBMSUNOVHU1SDczZWE0Z2dqVERQMjZrSk5MK0l4MmFMcFpl?=
 =?utf-8?B?NUJTOFRJUW16cG52d09VZm9QZC9GY1ZNeFR3ZWVkYnU0TDdkaC85UlQ3SVFr?=
 =?utf-8?B?dy9mRFQ3b3FlZDVGQjRxV2RNd3FoVHQrY0VRU2t2VWhBT3Rwclc4NnpMbjVo?=
 =?utf-8?B?ancxcmh4akJTd3o0dmVxNmxFRkgwN2dXcGszbk1uakUrMzVkZnJMU3FKVm94?=
 =?utf-8?B?Vm5RRWdnWUhvbU5GZW5vVC9oSW9FVklNY01wV3Vxa3ZzMHBOWENXSzR1bG1E?=
 =?utf-8?B?YmpXOUdidUhQZHBCdURrZ0lhZEtPR2k4SlVLQ2RvVzc2N1JySzdHZmEzQkdU?=
 =?utf-8?B?SG9LaHdnSWRNNEpiSTgrYzg4REMyY09VN0pLWFRFZGZFQVZxMW1MZFFUUmF3?=
 =?utf-8?B?eDg3bUx2ZlJGRktjNUFOT0QxcXNCQTQ3OVZWeXcxM01wUW5qNlVvSkswU0JX?=
 =?utf-8?B?SXJXTCtGNUovNnZhd3U0dGt5VExCVVI5QjlzNE05WmhuSU1FbTVVM1lQM1B5?=
 =?utf-8?B?YWg1aDVEbnFVYkZ3TGQzYm9xUzlWQVJ1ZzFYZWVsR3V1OGhIeWpiVzg5cWU5?=
 =?utf-8?B?bkJrdHdVZjZ3OGlCTFFHQnRkS3BPQ3NhTncyZkIzd0NnRmk0YkwwZEdNNGJR?=
 =?utf-8?B?MkVOTkVhbjcySkxZdXV4RUhubmNkRWVzTTNrSktQUWRPL1REQ1NQSWpCVFJY?=
 =?utf-8?B?WU1veWdjVWtBUFFWNld3TWlrRFZXdTQySDJzV1VuOTduUkJZUjFHbHFVMFYy?=
 =?utf-8?B?K0Z5c3k1Y0hrMWRtazc2bWpId2tVVjlmeEcvUFc0THhUTExiTnlHOFFFTTkr?=
 =?utf-8?B?aVovNThuMVBMeWxXNDdmSDlvM2JoNEVFOXZOUWI1WHlWTnB4OGNnV3BTRXlr?=
 =?utf-8?B?RnBVcjlLOUo4ek5KQUNwWlZmVTdtaFJDbXpRUlQraWNxSEsyeC91R2YyREox?=
 =?utf-8?B?SUpCWDVUT2kzSEsrK1p2N0NKbXpmN3dZNTQxT29CalIxeGsrKzNFVm5YcWJu?=
 =?utf-8?B?RDE1K1BkUlZBcElXaHd0WnBMMW5yQUU4bTJmOE04VEtkcURPTmJYZWpUcEJD?=
 =?utf-8?B?eTF1K0t4dWltSUY0QlFpSnJUYTBaVUVNQjd6SDdEWDFrdlM3c2tRQ3ZvcUpV?=
 =?utf-8?B?aG5mQXFqWlNOMGJmTXNIbGh6czB1NU9kUXpOQkFNMnpYNWxkYjVCRWVtYzJ5?=
 =?utf-8?B?VTB2QTh6TjJtU1U5UzdBWDZUbU00Z3FPTTV4UnRMY3daOEhRc2lMd0tENEVn?=
 =?utf-8?B?UEFDQXNnS2lXSjgybUNZQmlQek0rWHB2bm91US9aMTkwQXBvaVZJU1NoZjNQ?=
 =?utf-8?B?ZGtFOGp0b25oQWpMZjQ2N3lDc3pvODExMnNxTkNtZEQ2c2xNWFovVWtyb25N?=
 =?utf-8?B?UHFIRjZSeWNnRUhCdytsWHh4RlJma0tES1BQUC9VMG14NFVUWDR4S09NcUhr?=
 =?utf-8?B?S0oyQ0FKRVNFVk43UzBmVUlYZjhYbnpCZXlBbExDVytsdUhLeFZMaFRWc3c3?=
 =?utf-8?B?bEJ5ZDZEZUN2Rk56b1dGOElYazRoNkVtNlpBNUJKRjZBZ3BjWHNxUmViSWV3?=
 =?utf-8?B?V1ZlTlRFbkRoNXhXZy9ZTk1TYXpjSEJ2M1Z0ZFdVQk1PYVpqV1l3ckVPUEd2?=
 =?utf-8?Q?2D0RedJACu21Frch/eufGPYqd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be826ad-8e6a-4fef-d7e0-08ddaac51a04
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:56:07.9653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOkBrxYO4+keiU6/WKi/2EFcjEbIfHkLiL17aDhl+7qS8b/cMGTk052ucLMTQ5eAjAycmD+yKH6cYJh+S9rzJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
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

On 6/13/2025 4:41 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file
> available") added support for reading an amdgpu IP discovery bin file
> for some specific products. If it's not found then it will fallback to
> hardcoded values. However if it's not found there is also a lot of noise
> about missing files and errors.
> 
> Adjust the error handling to decrease most messages to DEBUG and to show
> at most one message to a user about the missing file at INFO level.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4312
Reported-and-tested-by Marcus Seyfarth <m.seyfarth@gmail.com>?
> Fixes: 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file available")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index a0e9bf9b27108..8e4526a8c2600 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -321,10 +321,9 @@ static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
>   	const struct firmware *fw;
>   	int r;
>   
> -	r = request_firmware(&fw, fw_name, adev->dev);
> +	r = firmware_request_nowarn(&fw, fw_name, adev->dev);
>   	if (r) {
> -		dev_err(adev->dev, "can't load firmware \"%s\"\n",
> -			fw_name);
> +		drm_info(&adev->ddev, "Optional firmware \"%s\" was not found\n", fw_name);
>   		return r;
>   	}
>   
> @@ -459,16 +458,12 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   	/* Read from file if it is the preferred option */
>   	fw_name = amdgpu_discovery_get_fw_name(adev);
>   	if (fw_name != NULL) {
> -		dev_info(adev->dev, "use ip discovery information from file");
> +		drm_dbg(&adev->ddev, "use ip discovery information from file");
>   		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin, fw_name);
> -
> -		if (r) {
> -			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
> -			r = -EINVAL;
> +		if (r)
>   			goto out;
> -		}
> -
>   	} else {
> +		drm_dbg(&adev->ddev, "use ip discovery information from memory");
>   		r = amdgpu_discovery_read_binary_from_mem(
>   			adev, adev->mman.discovery_bin);
>   		if (r)
> @@ -1339,7 +1334,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   
>   	r = amdgpu_discovery_init(adev);
>   	if (r) {
> -		DRM_ERROR("amdgpu_discovery_init failed\n");
> +		drm_warn(&adev->ddev, "%s failed: %d\n", __func__, r);
>   		return r;
>   	}
>   

