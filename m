Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9D1D75E57
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 14:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B28510E0F5;
	Fri, 22 Nov 2024 14:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VGlFe3E+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831A710EB96
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 14:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6EGxkKHnyDqEH0qGL71ya/Rv1+tOatjXuWcrYVJpP94XySRzxJHnBY4EanTQJPzBfZnJDRxFdxRfgUA/N2nxw/+FOw4T0T9TmgRHlqglTVnf5XhE14njvdWk/tFbGtQynnLSqvbSo45e8bb8u9C7DMPxnkNgMis4+k4Hldw+xAG5LPfRU+pklFyYuh9pRkiMrZivqxD/23fGyuQvCm9F6T+JquLl2PLcuJa26vnp8tMSeWp1rjShmNSXzhUwVY/fbc4cSd1xr69ev1QZMLFtOAxugZ3nwGENIJqtiC0sdl2rz+HdotGN89/f2NpPXaRmM+UixBbthTZeHnrVWP8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMRYR6tzJEjeJXIS71bN28m77OqoKV/i/rVWm21D0f4=;
 b=MiZBpz2HZLtjo2+9p/mu0U9456BkojWY8IdwVQyTEKODzjDmlndS+7qHvwvy0l7PG4TcMsVIjeUhUxWZhzXo2+VNfPEBguUQxTYXMyDMn1mXOPDEhBp6V9E4xf+RnCGTD2nNSMO8JwPEF5QjRbQ/CRgYStLkNElDzaHDNNsuk+EOR7siKOY3bsp8p3Q1/6oaqcaHoBi1dMIsT2fdPfK1veCLmTH2Z2bTWANY9VMrzx5KF4lYHD6BeHB0BUEaOuYuc3ovS0Fxn0xC1t+gci01KFcvbx7b/E3yYvWTsWlFw4UhcqRgmk6nfy0bzQ09HBQLOp4KDBCFb4S3o4KVOhgb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMRYR6tzJEjeJXIS71bN28m77OqoKV/i/rVWm21D0f4=;
 b=VGlFe3E+/Dlg+sUkEXvKPvn55ntc6KmSEGVIGDgv7dQA82j/nBaN0R3kwRgmA+lyewy0GbEhWWZys5MadACpM3ieJYanV+eVORPndY8XW4h01k+QPhAjJWx1tI16H9GWG9l2n+fsJNyUbdo4OdNAbtDa3U3pY/iYJF1uXtMZaAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.18; Fri, 22 Nov 2024 14:28:17 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Fri, 22 Nov 2024
 14:28:17 +0000
Message-ID: <10227541-3d1b-4e48-9a17-b9c0dc25a541@amd.com>
Date: Fri, 22 Nov 2024 19:58:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add Suspend/Hibernate notification callback
 support
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20241118200323.16541-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241118200323.16541-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::32) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb407ba-e9d3-401c-8e2a-08dd0b01e809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUorK2l4RGFWdmJRNWp3djY2T1NsY1dCcGFFbi9LRmlZazgzZWk4QlRIMkht?=
 =?utf-8?B?Wk5iNTc0eTRaeFR6OTg3Ryt0M0pYRzZOVks2eHFXd2g2dTMzSTFlZmcvV2ZK?=
 =?utf-8?B?ZmZ0S3lqK1ZZUjVlRHhkSHFKOVgyZjNzbFYxT3JHclV5WkVUenJFOExXa1NZ?=
 =?utf-8?B?ZTd6b1Y5TFZqMmdVTXNreTlneTkxWnRlS1B5V3J1TUh5NE4wTitZczJoWkR0?=
 =?utf-8?B?Ym01RlpEdEQwK2F4Zm9hL29KelZocVljUWY1ZFhmMXhQOXFUSVdRRVFPY21m?=
 =?utf-8?B?cmtMQkdiejVoYjN6UjhPZXdoUnNnWE9nRlMrUUFHRExLZkZQZUg1c09GWjZ2?=
 =?utf-8?B?TXRrek1vSHBOaVBFcXcwU1hRVW9kbGtaN0pWMFZqRGwxaktJWndpU2FhSzBp?=
 =?utf-8?B?RmZZUmx2MG45cExHQ1Fsall1aDA5cUlpUzg0UDBrUkM2OTYvUnJNN3Btbkly?=
 =?utf-8?B?S2I4eEhmSHNMb3NCbW1pSHpKWVV6VU5ldlhDa2Q0ZFhvb3FnU3hXWTNnekx2?=
 =?utf-8?B?KzU0c1lJNnV6ZzZNTEdHM2xuZ0YzbTZFRmdsRlJWbEJOOGFHeHkreHpYc01D?=
 =?utf-8?B?ZnBjejZJMEQ1T1UzYWpWNVlGNTJjWlh6VnBRQS9FZGxWRUw1NTZjY3pNZGdB?=
 =?utf-8?B?ZmZibkd5SGdnSUp0bFpyWklQdDFrU2Y3U2JIZWFjZUQ2SEtZK0ZEYzVmRk80?=
 =?utf-8?B?Y0oySlRKQkJ2WmZPRVorc24yYW9neVZ0VVYwdklwUm0xamV2Q3pXWUdRZ3BR?=
 =?utf-8?B?T1hqeHlmYWp2azdKcHJVdlNNSXc1aXNXM1RFSkI1YkxQYklxYWdXZ2RqSnJr?=
 =?utf-8?B?ZGNGeElQZitHb2ZIVnNOZ25OZ1VCa2l2TzFibHZVVW9GM29BOEVKdW9USEhn?=
 =?utf-8?B?dGlxMTRrTUxuTFlUb1lIQy9SdHBBVDJ1bGVqSEFHYXI3N2piaHpYUVFXNmEv?=
 =?utf-8?B?OWFkY1ZoZWxneERxT3RueWUzMHUzZS9ERTNvOXZEc2NmRlJ6MWhHcDVCVGsw?=
 =?utf-8?B?N0xRbnlxYUhRNi8yUHdYM3c4bU0yV1gxSnF2M2FPSjFiVUNCeFkyMXZtOWZm?=
 =?utf-8?B?azd4M2xwZ1lWOHQwM2tDYm1DalQ4REVUMHFUQzJmd2VrMFlsR1doSEo5aitJ?=
 =?utf-8?B?VGczazJvNGdlS0xiOTJoSXF0a0hSZUp1c2VPWmpGOEtBb3Bjd2Fmb0lkTWhz?=
 =?utf-8?B?Nkt3UnhtaGthdWlkenpBUFRsMXYyVkpYeXVmN1RHWEhsbWNsUFFJYWJYSncz?=
 =?utf-8?B?YWJPNDNtbm9YUEVobHJLWU5MdUtCZWhodlN4YVBWcHpTQS8ybzVIRzIxcktJ?=
 =?utf-8?B?S3I3MHdaK282b1pjeVVQdGZuU0hGckgxTlFNWkRJb1IwcU56SGt0RVRoeTZC?=
 =?utf-8?B?eVFSQ0VHQzZ2Yy9reGI4bHN1WGtFZ0tIWWV6OXZreExBS25mNDZkVTQ5SjRN?=
 =?utf-8?B?OXBpaU83eGcvK0IyS2dyWi93SXBmYSs4bjVjTlNyL2t4R0R4dmJNS0YvZlJ6?=
 =?utf-8?B?OGF3YkVNd1VUdlpqUjVXQzVmL1BDdE96K2JPbzZqalJYbEFXWGE5VFo4d1hn?=
 =?utf-8?B?Z1Qxci9KU0Fnckd6RUlwMjliSTh4V3lwem9uMkVneEpIWWVwOUJIdTZqMVAx?=
 =?utf-8?B?QXVHNGpqTk5SQnp6YXNSN1NpaTRXN1FJZzZwcEF6a2pjTU9aSnFxb1RKU0Y2?=
 =?utf-8?B?QmZrU1J4eUFpQkwrVVVCRExPRWdwYmQ1Y2xzY1ZsZzV0Vk44TmtmSTZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmpzRjBBaUxGWGJhWGloaVI3ODBFbmsvV2M1ZmplWHZ2RGdUWHlCL3NmVlNR?=
 =?utf-8?B?S0pLSS95aEJQdzBwYlpIemM5V1RZS2gyQU16VXJCZGtoalVvdy80OFV6ZzVP?=
 =?utf-8?B?d1JacEJwcy9ZYjREV05UOHR5bzRFVTV6bVRPRDNuSVd1N0ZFK21WNzJSaUtX?=
 =?utf-8?B?TFoyR1IrQ094KzdEQzA4Wm5OMUZ0dkhpUnp3eVdnTmxIMjhWUmZwbWcxTGhk?=
 =?utf-8?B?OFZlVzJFZHcvQ2ZEYm03bHJlV05LWStGa1hhcXE1Zlp3QURRQzlIMVNPa3RW?=
 =?utf-8?B?blpCeVRxQVBhZXhWcysxUEpxbmMwamVqZkhrUnBYTk8xQmR1dnd4SzU4OVFr?=
 =?utf-8?B?ODVVaXBUV09jZytuTW5DMXE4K25LeXF3UWpTOUQyZUlGQWF5SGxpZzNNWU5R?=
 =?utf-8?B?Q3VuSVJaQXkwbVpqVkFOcDcwTTl6VlVNVHVPeUpldFJtU0FLenhQMXJ1MHdQ?=
 =?utf-8?B?SVpiUGd0RnNzdzZscHNDbmdYZXBSbXdCbjhBN2RGZ2VtUXZJMDU4Y2JITjNY?=
 =?utf-8?B?WGx3L2JoRFFEL1hKU3ovUmlwaUtYZzlkT1RFUzBrYThqMXNSQy9FdmRhTE1U?=
 =?utf-8?B?MEx6eUhPWEkybVh5WkR1ckJtOGtrUXpuL0t6TjNkVGpoMVlFYmJQVW5scWc0?=
 =?utf-8?B?eWZGcGE0YThXY2NJSGRPRmd2SkFQalQ0VWVqcjQwdVVMSDd2OTlLWDcvaUR6?=
 =?utf-8?B?TU5VbFhQOU5nZHlFcjg1aXZjdmVsSTAzQml5THdTSVpyekt6V1Rlc2FvckM3?=
 =?utf-8?B?R0dCaTUvaTR2cWw5c3FoOWNJb29pRncyS2hNc3lTVmZ0VXB0MkV4Ti9sN1A3?=
 =?utf-8?B?dmZETXpldGtScVhMbnJsTlJ5aG1McEZBQUZNenV2eHAzVWw3MXN0eVBNa3ht?=
 =?utf-8?B?NW01RWgwc2hqR2Ryc25tYjRjYk9BWGV1dXdnWFliOHpYcHZlTU9uRHVQZndR?=
 =?utf-8?B?M25sYlZFWXZHSFpjSHIrZXhsUE1lM202TU9JNS9iZzJWMmlra2tKZHFENWRs?=
 =?utf-8?B?VkZQQ2x0Tml3RmxaeXc2U1Q5YWVCWmtLbEE0OHV1eXUzYURmVGFqVGJSUTJ6?=
 =?utf-8?B?YVE1a0s3MXc2czQ2V0wrYXE1TXhsSW9yaStXbitLSmphWVlMdXlndUpxbFlj?=
 =?utf-8?B?UXhDZHYwNE9SUEJ3QXdTayt1YnYrNjc0dmJ2dHQ1Z1czQnVpRGRLT2doNFJG?=
 =?utf-8?B?eldEU2dYS3Y5SHZHc3EwSFZsQjEvdS92R0RnU2hyajA0UHIrUytxZ3BvUkVj?=
 =?utf-8?B?NlNGMGIyRVd5aW9KWkZzZFQreC9EMVZwd1pBYzlFNFpqeXN4V2VXWWY0VFlX?=
 =?utf-8?B?OFF6dEtobXlCNHFNclhQRXdGVjloZ1VJeS9nZE9hdDFrK2xueTZtbXdjT1VN?=
 =?utf-8?B?QVZwUmJ6TmlOYmt1dEZyU2gyZm5hNmlyTWd3K1J6ZzBHbzN2WHBGczVxRkx2?=
 =?utf-8?B?Vmg5V3dwN3o5Rkx1TlVnSzJLeW5yc2poRjFNTnNrZEhQK0h3SGx6L1ErUU1S?=
 =?utf-8?B?ZnNnckxLTGdhVmplbDZEL25YblVDQ2ZqVEJFTVRSUVhVNlkwK2Z2dkpzcjlz?=
 =?utf-8?B?L2Jyb1VidHo3MUhvZGwyM0tyRlRzcEZNR2NaYlYrYXduaDNvVVV0V0xLK25u?=
 =?utf-8?B?RlhtVkxVOWFCb2ZWbi92cjd4K0VrV28ydi9sMlFpWmR5amZ1OSt1UHNiNFRH?=
 =?utf-8?B?bTNsS2I2TWFuTUtONnRkY0szQnhwYzIycjgxNzdtT3FkMzhCd0tRME5tb3Y2?=
 =?utf-8?B?aFlLajZ1cDJUWUZqN1RuVmNpRnhsSC9xZGtxOGk4dnduN3NIeWVybW0yL0V0?=
 =?utf-8?B?UGNKY213SGJCYWh0eTBmSUlOQWZ2WlV4WEdvbU14MG93RXQ5aDE3WDF2NGZl?=
 =?utf-8?B?b3pZY3o3UlR0UEJ6d29RWGdYSFZ2SzRSOUtnNlkwSkJPYVpIa0ZDNzl6RTZY?=
 =?utf-8?B?Zml0czRyL0tYTVhFTVVUalNmbTJ1RTJMWlo5RVRhN1BuWVA4OVMrTTNvWGVZ?=
 =?utf-8?B?dzM3MjBxUk1qMHNrbFFyRmFGdHo2VnNJTkhsSnBjV2RQMjZBZjFvZDJOdXkx?=
 =?utf-8?B?Q21ndWJwZ3pLdzZ0QlZsTFc1eWRWZi9OQkdWNTUrZVE1VVBUcEwzOCtoUVhY?=
 =?utf-8?Q?sS5EWixpJhhlvbuTNqseOs7Ya?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb407ba-e9d3-401c-8e2a-08dd0b01e809
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 14:28:17.6339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vZsaLhhgigKcy+o3r6WhfXFZbzO4KUlgiIzksD+stVKASh5rhzJM9o8vv2zzDnX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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



On 11/19/2024 1:33 AM, Mario Limonciello wrote:
> As part of the suspend sequence VRAM needs to be evicted on dGPUs.
> In order to make suspend/resume more reliable we moved this into
> the pmops prepare() callback so that the suspend sequence would fail
> but the system could remain operational under high memory usage suspend.
> 
> Another class of issues exist though where due to memory fragementation
> there isn't a large enough contiguous space and swap isn't accessible.
> 
> Add support for a suspend/hibernate notification callback that could
> evict VRAM before tasks are frozen. This should allow paging out to swap
> if necessary.
> 
> Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a37e687acbbc5..e70ca85151046 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -885,6 +885,7 @@ struct amdgpu_device {
>  	bool				need_swiotlb;
>  	bool				accel_working;
>  	struct notifier_block		acpi_nb;
> +	struct notifier_block		pm_nb;
>  	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>  	struct debugfs_blob_wrapper     debugfs_vbios_blob;
>  	struct debugfs_blob_wrapper     debugfs_discovery_blob;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b3ca911e55d61..5a4e9c7daf895 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -190,6 +190,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
>  }
>  
>  static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
> +				     void *data);
>  
>  /**
>   * DOC: pcie_replay_count
> @@ -4582,6 +4584,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  
>  	amdgpu_device_check_iommu_direct_map(adev);
>  
> +	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
> +	r = register_pm_notifier(&adev->pm_nb);
> +	if (r)
> +		goto failed;
> +
>  	return 0;
>  
>  release_ras_con:
> @@ -4646,6 +4653,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  		drain_workqueue(adev->mman.bdev.wq);
>  	adev->shutdown = true;
>  
> +	unregister_pm_notifier(&adev->pm_nb);
> +
>  	/* make sure IB test finished before entering exclusive mode
>  	 * to avoid preemption on IB test
>  	 */
> @@ -4777,6 +4786,33 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>  /*
>   * Suspend & resume.
>   */
> +/**
> + * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
> + * @nb: notifier block
> + * @mode: suspend mode
> + * @data: data
> + *
> + * This function is called when the system is about to suspend or hibernate.
> + * It is used to evict resources from the device before the system goes to
> + * sleep while there is still access to swap.
> + *
> + */
> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
> +				     void *data)
> +{
> +	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
> +
> +	switch (mode) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +		if (amdgpu_device_evict_resources(adev))

This will result in an eviction call on APUs since the flags won't be
set by this time. Is that intended?

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4739

Thanks,
Lijo

> +			return NOTIFY_BAD;
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>  /**
>   * amdgpu_device_prepare - prepare for device suspend
>   *

