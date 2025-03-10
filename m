Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F943C282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 17:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2605A10E055;
	Mon, 10 Mar 2025 17:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qUYsZ8ap";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC0510E055
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 17:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yhf0n2ncoSSRCt68rwC7REmINO6xVL8W3mf5gWFeEuB+sVLPpIyEFfzhKTvJ4BSU2Cf+XAuSvjhwgQxvwtGkRzvj2oU6UZJd5npba9E8imDGO0SoNImdIlA72eWGz2pX4v/HxR+VotaoVNZ3yyBvH2gYEgkmcC6y07vxEkBKA6MfXtrlppzCQEsIO5MQVGr1GY6T2QQAcS39I1rEvzh0WzdrH1n7Ixpf5Bl4K3iAomiOA72rgfT3vXjbla9O04OjBax+GnycdObb5hfKhWFSymUfqfKvQIgTHQ/EQhvuy4SpwPrkvnge1PzrKV3R0qpXr3grMANH+VXdsXc2RZ8mvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF913tA1xhKEFsftM9N1utFxXSbr2VTmzQI4qTelqXE=;
 b=lIDT71rfkgBB9X0ReA4x3V6RgXyMabvw/U3450VlKkglAzSeMt8R8BDO6vf/78oM57B8xKYMwEmOh7gt1971i3GmN3sqwNXSeilBx7F+I8XIrRzG+zJJ58d/jJFrLhFJylR/TY7A5xM5rw3HSDu88voUY5kyb3hgIvKLUHXWWjUtWK6OqrbL8LpjZQQV+y3Pv0hp9jDifxIi9weVqSl7h9ZC/1C/D9mLu/CoD7kWvUCGlprnpTjmqxRwrEZD31V2SB48MQiZ1HIfpfghFzYDDnWgEI/3819AEB4FDFCDFDEIy9Xpseeh9T9YR5Sty3UoJWr48eruGxEkYvnnZNNg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF913tA1xhKEFsftM9N1utFxXSbr2VTmzQI4qTelqXE=;
 b=qUYsZ8apYM0sCMcfWyr2WfAYF07yTGpySiWQlCTXbwwxjNMLuBpW2k6J2v0f4olydzwswuUeYsF5bAzCobxdfdoMsUE+ERCmdN8YstDk9C1rjI+Qaqcij8o89uSC9oqMG+Wjei1nVOhowp1KfNFhbkIYWVbwLHNZAPd3J40PHxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 17:54:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 17:54:45 +0000
Message-ID: <4bc6ed60-0f9c-4d4f-bb36-2e076a0fabd2@amd.com>
Date: Mon, 10 Mar 2025 18:54:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: NULL-check BO's backing store when
 determining GFX12 PTE flags
To: Natalie Vock <natalie.vock@gmx.de>, amd-gfx@lists.freedesktop.org
References: <20250310170805.37536-1-natalie.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250310170805.37536-1-natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2c0d53-f90b-4e26-4898-08dd5ffca45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2ttU250V2NIdnl5ejQ2VHRvanc2d0xSeThlR2JrR2U3dXBNQ01vb045Zk1z?=
 =?utf-8?B?Wml3MHVhamlta3ZFRUZxVzl0bkdGQXEwbmgzY1d0RjlDZEFZTGY3VjMzSHox?=
 =?utf-8?B?WGtCUGZlWDFHTHo0Ym5XR0NrdjFsSlVpUUZWWjBsZVZoV3lrUzlIU2w2RWZo?=
 =?utf-8?B?ekFkRWVMT1k4dE92dTJCcjZ6YnJMRFEvdDNIWHZETmRBNUw0OURyZnNaVXNU?=
 =?utf-8?B?V2sweHA3UW1BUWJERGhqY25mUlFHWnNRWlJQQUJGdVZyZGpOTFkzVXZXTWg0?=
 =?utf-8?B?V2NMTlQ4Y2RoU0V2Ump1eHUzbnI3OTVwa0tLcXdqU2RmTm1EcGc4dHBXa3ZS?=
 =?utf-8?B?VXBIMXN2L1c0N2UranllYzBQSEZUNUtQbGxKNHNwaUZSQkZOdVdYUU5XZmVw?=
 =?utf-8?B?M1hEVWRLOEtHakJaM2g2QjJJT0xTdVF4SnJlS1d5ZFpFSy9GSmNubXE3cHI1?=
 =?utf-8?B?TU5XdDc4Ymp2TTAwaFVWVjI1bFowZDMwM2ovQ3oxRlR3S1BHUTR4MnA5QTFa?=
 =?utf-8?B?R2g3bmlVMGQ2aW5SVkI5R29ZVTh4YjJ4OUx1ZVRpaUtXMllNendNc2ZyMmhS?=
 =?utf-8?B?bVlDRHRFbWJBQjF2VkxYenZZclFIRTZYNGg2SllmcWQ1MTBZNzNMZ2M4enBL?=
 =?utf-8?B?TWtRSmUrRERJU0w3aHZBcWJhR25VS2trRFVGVnlOMi90VXcyZzRFNURmZFhN?=
 =?utf-8?B?THdHOW5sak9Uc1l0MjdkUU1uSHFCL3daYllPTXRqaEN6VUlnaEZtdjhDeFBQ?=
 =?utf-8?B?RjUzY0MyOVVrT3AwbC9NVDd1NjVnZHpGRGk3VWEyVDErTGhXeVMvQXNnRys3?=
 =?utf-8?B?VTNDRDc0eVFTbmZ2OGEwZTlnU1dicHlxckE4V2EyMVlNSE5RWHpFcENPeHRx?=
 =?utf-8?B?T21HMnpEb3FqRXdYRWlQUm8rSS9FVnRyS2lKT016Q0FhMThSbFhGTEF4NFd3?=
 =?utf-8?B?VzlNd1B5TDRucmp5SnZRM0Z2QU5MdDJKYks5VU9jL0xOdEhkT2tIVXp1RWRK?=
 =?utf-8?B?RlR6OUVDY2FraXh1d1ZEL1dKWi94QWlUM3NDLzlGRzhUSDQ2bG1haEJqQ2dQ?=
 =?utf-8?B?WStwK2krTEZ5Q20rQzJub3ZJVGV2cFZ6R0NPdzhoRFdyWDRZUTV3SFpIWDJq?=
 =?utf-8?B?TTlWeDFTZzBBMFhWcm4zSFl6dWFqYWFUUUxyTFNSaDh3NytNL2ZuUzJWenFW?=
 =?utf-8?B?V1ZwNXlNSXFKay9odjhXVnhQR3BOYmNwRXNsekNEV2xDRGpsTnlQZ0RPemtK?=
 =?utf-8?B?T3U4VlBMbjc1SG9xUUJKTkVreExaUC9JbFVmczdac2EvYnRPWXBIcDJqNk5M?=
 =?utf-8?B?NXIzSkZqV3lZRG5CSVF0cGZWVnU0WDVvUFZ4MnBkc2VUZWtoSGVQR0puQmNI?=
 =?utf-8?B?bWM0SVpScWpHZHF0QTBONHo0bU5EemJNb2R6c3lMUVEwQ3ZvYzRIdEYzZDRR?=
 =?utf-8?B?RWZnWkJ4TWVjWWlUOFpGV1lDaWxCK3UvTFY4NHRWQ0xEWFJ4MkJkaDR0aHdu?=
 =?utf-8?B?WllDNkJocWJwcmNSK3JsUVcxeVZaT0t4SlhXMDcyRk03UHNobGszSlBPaE9K?=
 =?utf-8?B?UWNKaVZaUERhd2xkSTdUdEpWQ2xCakJwNmFzWmEyWVdTdTg4amhPcWJYOFMz?=
 =?utf-8?B?djRva0IvbnVBcktlSGlOYVJqeERtaGhQTUoyOE9OeElmTVdTcU5wSlBGemxD?=
 =?utf-8?B?OUtFd1o4NTByc1FUZzliVlBBN3lPemF3NnBsL1NLMFdkd2FuUlNENXk3VE1z?=
 =?utf-8?B?N3ZJUHVrZW9GMFF6TE5XWjhLanIyS3dqdGpMVEVnTXFTdVFFUmRCSnRQYmN4?=
 =?utf-8?B?VGhHRlBXeEtLQjBlVlNsbnZCYU5zdUgwQ2ZGYWl0QlVrWXlGRGhPaTdEVU5a?=
 =?utf-8?Q?6K04ufEa4HcKi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3pzZmRpaitKZVVhamVNWDNyZHFRWWZnbm4wMm5RODRvSVJzRW1IQWd3cHMz?=
 =?utf-8?B?WHpGaFAvdkJFRS91Nmd1YVNVQjQvZWE2MUxjdXlRcDIvVC81dVVLN21qNVRn?=
 =?utf-8?B?cE5QeU84SmcxT1JSUEhOdDlVZmVNbDFMcWpzbll5YWFwbktIbkQwRVJjS1Jk?=
 =?utf-8?B?blE5dTZQNjZyVDVGNFhua2NML2E0QS9CUnhIaEZYRUhmQWFPNU5paURhWkdI?=
 =?utf-8?B?aXIrRUhUaFdqSkFQdDZKbDBmdE1pTjdjSzVtY2g0S3EvcEZlT0tXSXhNWDhX?=
 =?utf-8?B?UERJMnF6YVdwV3Nib3V5V0VtVXBnM0NLMjV0YTIxaHlyMTA2VHp2RmdRV0Qv?=
 =?utf-8?B?NW5PK0dxdm9qejlBcTlEWWNXeThSOFowcS9lcS9GcmhNblN4ZUdRN3RuNVlO?=
 =?utf-8?B?VFVSVjVGTjhaUHdRL2Z1aGZIZFlDY2FnbDZTcW1DQ1BRY2RMZW9VemtpM0pq?=
 =?utf-8?B?WlFzN3VWRVNYMDEzWVZpQWE2MEFQOG5JUVk0VFRubSt1UEZNY3dMb2h3OGph?=
 =?utf-8?B?UHdwbWxBbktxODVtK3VhNkRrTzl5TWRwblN1dFB2YzhPenVtSGJHbW9uMytB?=
 =?utf-8?B?YXZTMUlzV1BqdTl0ZjlsdDk3am5DdnZWL1AzdjRROTcwUjdMVTZsU29XVHVw?=
 =?utf-8?B?Vk9uU1FKMVIxeGlpZy9NY0lzQVNRdVlucEFBRjAxcXNVaGVaZE1uelZzMkFi?=
 =?utf-8?B?a01yejladWFFYUlhSDl3Ky9teDgrRVFMdTZaR1hnL2oxc3JVVjdzOEdTTkd2?=
 =?utf-8?B?b1U5TlV1VGt5d2tJUkJKa0lITzM0dVJOSEc2bGRNTGlnRDM3dDJxeE9pN2Zp?=
 =?utf-8?B?MGN6Z29hbDNURlNYZjdpckxhYzhZZGU3a3g2VkY4S2tYaU9oK1pvdm1CaHhp?=
 =?utf-8?B?OTA4dXdNNGdWOUlSS3ZVOGMwb0RMQ09EWUo1bm9ZNkhtb0pXcDBKL1ZqL1BS?=
 =?utf-8?B?S005WXQva2lXRDNQK0lFaHhMU2NSY1FIZkg3ak9IV2xqMXZna1NYdVhBN2Q0?=
 =?utf-8?B?SUUrWEU4SEl2VzNaL0JicHVZNEZNcWh4V2hQeXNVVG1sb01LZXBlVU1qdUpu?=
 =?utf-8?B?ZzZwSjZuM3ZMYi9DYTBpek8zU3FuSEU1T0JqUzdqdkwzMGRsNmd3WWI1K3lr?=
 =?utf-8?B?bmZheHQ0YVRoYTREWnFiUTdXRUJQVCtIcXVqUVFBNVJjbXdJbkswbWFvUG5i?=
 =?utf-8?B?NzdrbTFCTHIxcVZUWUsxdnZUamhJb3ZwMVZYK1lXNE4rWnpFQi9UbG5tWDhP?=
 =?utf-8?B?RzVHa3dUMVFXWW9vYUlPVzFtdEZiaU1kS2ZldEM3dStlU1JvRnExN0FPUVpi?=
 =?utf-8?B?RjFyakxaM0hLMXlSTDQ4STkrOTdpN1R1cXRmTklkWkk1YWY5VFNwK3hkaG0z?=
 =?utf-8?B?YTJEdnQ2UE4wa2R6NVR0YlkrUHVONEttMlZYcUlUelAwRWFkOW04YmdPVmRj?=
 =?utf-8?B?VFVsOUZnUStsUzQyNys0ZiswQTFEVE1JemRkUmJXZ2VXTE00MVJCckIraE5r?=
 =?utf-8?B?NEM5am1Sa1ZOM2UrTkxiR2E0SGZyMm51V09NaVJkcmllQ2VxSERTbkZueVlI?=
 =?utf-8?B?a2JQaXNLR3ZWNnJzeE40Q2dHYjQ4VE1VNUJZUEdjdnFoM2JKdVdkdm9iV3M4?=
 =?utf-8?B?MVZtWnJTTUREb0NBdWh0QkZXYVlpdE9nV3FFdXNXaFJReDBxSU5ZbVhjRW1D?=
 =?utf-8?B?SFNnOEhUam5Uais3MElKN1VrZVQ4SUtkQ0J3aTF0QURpV2MvZ3FBWDJTZDZR?=
 =?utf-8?B?SVE3QjBOcXorbHBkOXlXTUE5UE0rT3g2Mnc1bURvZlM2YzJrOHlBTytLY21I?=
 =?utf-8?B?WXg5STRyVWxVWEtpVGhOdDJFMmQxdmZPZnptZ0ZKRjRPR0loaWh1dUpUdXI3?=
 =?utf-8?B?bjJsL0NnWjhzQm40M2VKeEtDd0kvUzJuL1FFUmNzZ29qTTdUTk1waXZ2MHBU?=
 =?utf-8?B?TDR2U2hQV25yc3JmY0lUOXRneHl2RnZ3NGhYRGpESFgrQnp6L0MyU0hENFcv?=
 =?utf-8?B?VFAzdmNHVDhyWWM0K2RpL3o3ZngxNk9vckZraFNNNjd3cE9aQ3BvQlFkS05w?=
 =?utf-8?B?M3U5TjMzRWZ1NHRFeUJEYmFoQ05jcGxHZnpydVVCUzI3V2dsSmlJeGpSd1E3?=
 =?utf-8?Q?N5Gk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2c0d53-f90b-4e26-4898-08dd5ffca45c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:54:45.3209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdlQvxT/emfsqtDKgz+wH5RsaXS4Miu1B1ERLoDbZrPyWItJcZad81OXzrUsECmm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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

Am 10.03.25 um 18:08 schrieb Natalie Vock:
> PRT BOs may not have any backing store, so bo->tbo.resource will be
> NULL. Check for that before dereferencing.
>
> Fixes: 0cce5f285d9ae8 ("drm/amdkfd: Check correct memory types for is_system variable")
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index ea7c32d8380ba..bf8d01da88154 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -528,8 +528,9 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>
>  	bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> -	is_system = (bo->tbo.resource->mem_type == TTM_PL_TT) ||
> -		(bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT);
> +	is_system = bo->tbo.resource &&
> +		(bo->tbo.resource->mem_type == TTM_PL_TT ||
> +		 bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT);
>
>  	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
>  		*flags |= AMDGPU_PTE_DCC;
> --
> 2.48.1
>

