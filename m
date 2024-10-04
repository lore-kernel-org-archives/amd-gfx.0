Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8587CF8840
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 17:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B91710EA53;
	Fri,  4 Oct 2024 17:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kej2LSGE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F136610EA53
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 17:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4WbrsN9VvN+uBgu7wHnl4YQSwiN1Dfy9yMBIhQ9otxNuqVkv93XlL1IkvD7sBU+ppWJerv0d0bxtFz9LjgDJ9edKoeg+CXagqTA0JksWMHANfr8yaWiWPjnFN0qF4KfFApvEuwZm8I40GGVLxfgLt02LOJWY1Hkkufoqt6YX6IZmadmdWgOKwkXy2JzkCD28puwAlU4ciafT6Uvs4A+5oevRE2By6+G16R+MBHOBD+plkjfunXfij6nFJVXRz4IZviw2ZemujkvL1+NZIGGFJpI0fxxshpZr1jqNHpckmK7CBJurZiN3rSFuJVWbh7SZI+wEQDKtvlpdlEmvnn19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb2xJigL0CPiQZARb9W/jWR7uWMYgIWug9jeUxYoqsQ=;
 b=de/sp2h4kxE0+60vS4jllQuXiHpc9pYuJgWYanFF5i22rsyRUlfN21gXsrtuUe2D+0qMFanxTClCgQ5Aa+rxvzIecc8ZEtqL0ycdFOqeCI3pi2Ec54xIYtjelRC3paAECWRkQLM/td+ft5YNJPqY3on0exNnaMcQSHQW8mAY8thu8ve8s7qh6NbvcTS0xeQdXMcS7tqPbBox5LPWISOkw4QJhXjZMSRO+hi0S37Kmb6E5QattYpgC4/v4BY9EvWmopfNaHmNRD1etWCidbI3Xdin5nK3nvmX0STpz+wIh3wqHnhA9wl+E6Z04njDuLEpEj2JxHxZrZUlPl+ucjzxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb2xJigL0CPiQZARb9W/jWR7uWMYgIWug9jeUxYoqsQ=;
 b=kej2LSGE1gQP7QCAYqcQb3Qz2b17m2y/ORUELnocak1VhdntMlIuzuLssdCceuUrpYF2h9koOFQSOLQVQWtuSdlU4Ci+28SD7NlzuVyX+F//JtVfEVTtyvoBEpZiX1nSW8zSQgsILAm4UzSeHKn9REq5CWZ6oGlNt6qCMBBMMdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Fri, 4 Oct
 2024 17:56:16 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 17:56:16 +0000
Message-ID: <62381e60-6b68-4d67-ad00-fd416d62a45d@amd.com>
Date: Fri, 4 Oct 2024 13:56:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: disable SG displays on cyan skillfish
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241004143010.444578-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20241004143010.444578-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0314.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::25) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5438:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d93b87-99e5-4015-2356-08dce49dd791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWdyQ2l6M3lDNHJ6QVkwMCtiN3FrS3pUUmZxT01VMEowUFJGTnhTZ0p6MGJ2?=
 =?utf-8?B?amg0N0pBM2M1djh2cXNNZUNTR3ZCTzRjb2loRUQzZ0lrQWNGd1BYUm9qV0Zp?=
 =?utf-8?B?aTRucnFjV0xlaUJuRUNQaHV4M2lxZm1FNzE3Q1FtL0hPK0owQXAzanNjdEtP?=
 =?utf-8?B?MVl3UUp6azJxcGVPWEhrQVFyWmpYT2s0RUNMV3B0UmIwRWxIOXFIMFl4TTdO?=
 =?utf-8?B?NUI0YlpZd2tFRVYxVS84a1BQZlpibWtQMkNtT0cyKzUrMmpBcnpLUjBMQ2Fm?=
 =?utf-8?B?eWZQSUxLbnR3b2JVWjIyVkRkZFNZcFloOGhpSW04eGs2clVqYXVyQ0JVZ201?=
 =?utf-8?B?SEs2b3dDTnNSZndMUmVjYlljQnV5K3NrZjdBSE8rZncrOWlzYlNSL2RUek91?=
 =?utf-8?B?ZGFhYlJNYVZYWENzcnV6WEFYMDJFbTczWjZKQlB4SnJoT3F1ZWthWGtRMXVt?=
 =?utf-8?B?UlAzdnd5c3JMRHkrYTdMNDQrcDZld01WVXRkZU1GWEkvU0c1VWQ4eUdac3dX?=
 =?utf-8?B?TFNsUVBZeTluQitJR2wxRHUzQXBUUTFFU1hsSTZaaktxY3JHdjlLWnN2a1Ny?=
 =?utf-8?B?ZDMyZ3hZRUoxVjZMd1ZaVXlSMUNNWmdYMFBNQTI2OHJpU1BXNkg4TXAzZW5I?=
 =?utf-8?B?NWIxd2dMYVU4SkFMUFRzUVVBQ1VPZHJUVytLd1dDM081QWllM0tlcVU4eVBP?=
 =?utf-8?B?WHNVdEFJdEg3NjFQTkJPUitUSDFDRHNYQW9rY2ljQkw0V3hFaWFSbENwempn?=
 =?utf-8?B?NUMvTkZCZUNpWHRjZjJpWGF5R2s5bGVLZkJSTFJYVWdxcjVVMnpCc1Y1Q2J3?=
 =?utf-8?B?Z0xkOUhWNzIwM0RQRHhsRU1hSjE3S3JNU3ZnamNFUzlEUVh6VnRuUnRyalJ3?=
 =?utf-8?B?dXNObGpMNnRmalpZaS9HTVpZandrajlvaURHclhyOUdpVDJZc2JEeVNiRkhp?=
 =?utf-8?B?NTI4MndVLzdPK0tzZW1rbWRBVEJxZUpHUFloMHN0YXdHbHFZa1J0R3NzS284?=
 =?utf-8?B?cWVBd29xOEN5WkNsMGcwVGMvT3Rnc0tTcUdSMFo1SkpkZ1NrWVRuaWxvZmhS?=
 =?utf-8?B?Q0RMVkoxc1dOK3pVbjRIdE9EazNJc1BQWVk3bjRCNFJmTGExNEJvTk9sdU9M?=
 =?utf-8?B?dXFzbmdGdUV4R3ZiRmpDaWdqYXJ2TitFWWUwUGtlbHFLRnNiZDJGSHRqNzlC?=
 =?utf-8?B?SnA0NlhSWGZIOU96UXcrNzJrT0V6WG1FekN3bkFDZlk1SjRWRUtlb25HOXZV?=
 =?utf-8?B?M0U5ZXJXRmNoaFZBOUc4UU0yTTJtL1JyUWxDTldwSnA4VTBJVUVHL3ZzUzRJ?=
 =?utf-8?B?RnF6N2JpZ2NwN0NuRCtUVnhVSGRPcGtwVTBCZGdUL3dvcE1JTUd6NG1iYVJZ?=
 =?utf-8?B?MEVmYTBJbG0zdG9UaHVpclNLc2o3cEVlUDNGejRnemU3Vkcwdmx3OHIrUldT?=
 =?utf-8?B?YWJqOUUzVFoxZkwyaFhZODRKbDJCTFpSanBvdlhHZnlmeDlZME1iZGhZcFh3?=
 =?utf-8?B?SUhabXB4RWJEVHFvUTRiVUpUOG1tUGI3UjNkZS9iaXZ2S09uQVhIaVJsaGxB?=
 =?utf-8?B?THBzdTNCZTJ4OHY1RE9MamJpRkEzMDlZQ0FEV3o4L3Q1dmhpaHZHeVBFYUJt?=
 =?utf-8?B?RUJkNEtKd2p4dDdkUnl5SzRmQnpQMUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5438.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThKSWh5WlgvRWI4dUtJQ28zcmNqUUQvbkd4TnFKc3UxcmtQRjJxM3BFcWpJ?=
 =?utf-8?B?WHZ1TGF1c1dyK3ZZYkxoNEtlMTcrVnppNC9ZQ1BROGdDeXp0NnBuTkM5TWxY?=
 =?utf-8?B?SnlyNWMwYk93SW5YTkhvd29YaU16TXJKdkdBemhtM29TenhDYVpmY0VYOUxZ?=
 =?utf-8?B?YVo0SERhMWN3VjZIR29VdkJESms0MG1relZBM0FBTWNPYjlRWUxqVWp0eU1K?=
 =?utf-8?B?eEI0WHA1ekx0K0dYSXkzek1ZNmdRcUJMMk5PRW9nRVZQdnF6RllnODN4NVpY?=
 =?utf-8?B?L011emdzMHA0Y1QxTFM1dkY2UzRBOVdGVjEzSmNSNmNON0FKc2hSVHVVWVpv?=
 =?utf-8?B?Z21JdnhGdGZNWGUxaU80aU5yQkZqSXBJZDVWZFBtdFFUWURMQ2o4R1lXOC8x?=
 =?utf-8?B?RWdnMlI1Vm1uN1VCL0lzSUliMG05MjMvNlpCcjVXSHp0TkFGVWFLSC9TYUJy?=
 =?utf-8?B?cFBUT3dwNjE0VUZEWVdmWE8rb3ZrSDZySm1mZUkzNTRsd1RkVktpUVRTOERp?=
 =?utf-8?B?KzUxSWhYdU10dElta0Qrbll5SldLeGc2UVU2MERTZENSNkZYR0NoQlFvMFkw?=
 =?utf-8?B?TGRHSEt6OUZESFpsQy8rOG1OeVFsUHFIVHJKQlVJbUVIZVlHcGswTjkxRC9r?=
 =?utf-8?B?TW55aWdScGNETFM5SzBQeWg2VkYrRkQvdjlvYy8yZ0dwdFBOeTZETEIxQ1Ew?=
 =?utf-8?B?eXNxT3d1VDNBcjlQdEFRcnkrOVNSZGRmZFBoS3NLM0JZdkN4MWRRMXh4M01x?=
 =?utf-8?B?RHMxYzhhZVAwenUvN3BNclR1SWxtZU1zaG5GLzRSYm9wMUpXZ2d4YzhoVTBC?=
 =?utf-8?B?UHl3TnBEc1B1T3hhMTU0ZnVXelhpU3RVeTN0QlhOckhReU1sdS9reVRTbU5J?=
 =?utf-8?B?V0VKb2pWeXN5K2x6WkpYdWpONUhaZmRQeEY2Z2pPTFVnVlIxa3g0dE95STBY?=
 =?utf-8?B?ejlSeEZwbTJJM0diVXhPUlNKWkdLTzFKajI0YnU2WlVSczRFUzZwRy9Qa1Jh?=
 =?utf-8?B?UWlSYkFBNnlSQVdraUxUMGluN2RQVzhVWEdFTlFuci83MzR2c2hRMDREZ2FT?=
 =?utf-8?B?eXlXd2Z5WWpzTXp6UmwzN0VqaVBWTWxQNU5ibDBUKzhGUkg1cmJwbDBSckxD?=
 =?utf-8?B?OFk2YmlRYWFZOHNFc1hYNDloZ2hpU0NhVzlpY3ZUdUl2eStvL1dBcWREK1U4?=
 =?utf-8?B?T3ZaRTF5MThxUjdmekEvK1RYYW90aVJBaGZDTEhTNHRvTnhrYXN0VW1lYkVu?=
 =?utf-8?B?Q2Rqc3RsN0E2UkVGbmNqRlRzdDRTb0tlK0V6RGFIMVJHNVIvMUZYMVZ0K2k2?=
 =?utf-8?B?RVJlNnBkditEdGxTREQxVkNPam5NSlBZaVlXaUYyT1VLWFdRcUV4djltU0Fv?=
 =?utf-8?B?NmsxK201TWpUR3llVi9ka3hFLzNDZmVqWW9LVjM4MTVPWFBPTWNMZ1pnVkkx?=
 =?utf-8?B?UnUwMEhGYXlNQzQzZ05qeTRJK2NnS213SDZWZDNWVEJJYlNvYUNrbW13VFBo?=
 =?utf-8?B?WlVzZmRsVGdiQlcvUm1DUjlDN3BqZjE2K1lDNTB5MHIyK0tvaHhCTnhROERk?=
 =?utf-8?B?MW5BbHJEQVdtUGIrQjg4OUd6aWh6Mk1yOXB3MlRPV1dSeklRaDBjZUNWYzEw?=
 =?utf-8?B?dENVUktlc3NUVlAvZThucW1LUGZxdDJ5d1FxczZwNkpaa0dQTHJQZlJlTVY0?=
 =?utf-8?B?Rlp3VmFmMVZPbmRIbEtjTUg5dStPRzA3UUJqM3p2emF4K1UySU15UUhEMzV0?=
 =?utf-8?B?Qmd2VzdDcW1UcjlhcUNrd3RUa3c5dVc5azg1SlpDZ1BhVSsrajEranRtYjJ4?=
 =?utf-8?B?cHRlQmlaTGl1Wmh3NVJETS84MlkzRjFQcFlYSlJwK0xyWDRSWlVzS0dmbzlv?=
 =?utf-8?B?aFk1dlh2ajZrSjJYSjlvOHp3ZHhKV0lrZTEwTkNLckJYZkNWZlNSZk93QTg4?=
 =?utf-8?B?bU1mUXdpN2lrb0txOHZGUDQ0TGRoK3lTWVNWcEx4TnhqQ1FOMFRiTThzY09I?=
 =?utf-8?B?cmVzcHVOaHc1WXZiOVZQQ09YbTU2MFdYclgyaWZQYmNtVHlRa3JLb2hFeGcx?=
 =?utf-8?B?T0RFcEtqdHYzRWRIOUpVcTFqck5xVkl6ZHA5SlpEUi96Q3NzRi9kZDllZENJ?=
 =?utf-8?Q?7mrvppTBypZv1wSXX/zu0SOg5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d93b87-99e5-4015-2356-08dce49dd791
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:56:16.2273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kjg4yTsXUg8JvFDzMvHQrM9HvBDTfvBQqzam3X+pZt8/kki/q+7iHQV8U6C5BlFfecb2vVTLPfCa65R7i7PAJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
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



On 2024-10-04 10:30, Alex Deucher wrote:
> These parts were mainly for compute workloads, but they have
> a display that was available for the console.  These chips
> should support SG display, but I don't know that the support
> was ever validated on Linux so disable it by default. It can
> still be enabled by setting sg_display=1 for those that
> want to play with it.  These systems also generally had large
> carve outs so SG display was less of a factor.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3356
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7616d7a509b9..84fdfb4c8bd0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1886,7 +1886,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  		else
>  			init_data.flags.gpu_vm_support = (amdgpu_sg_display != 0);
>  	} else {
> -		init_data.flags.gpu_vm_support = (amdgpu_sg_display != 0) && (adev->flags & AMD_IS_APU);
> +		if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(2, 0, 3))
> +			init_data.flags.gpu_vm_support = (amdgpu_sg_display == 1);
> +		else
> +			init_data.flags.gpu_vm_support =
> +				(amdgpu_sg_display != 0) && (adev->flags & AMD_IS_APU);
>  	}
>  
>  	adev->mode_info.gpu_vm_support = init_data.flags.gpu_vm_support;

