Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB047E65D1D
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 03:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531F610E058;
	Fri, 22 Nov 2024 03:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eu9Ibvdi";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260E510E058
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 03:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfvaPBUMqAEBhlBeLX6jEErHv57NSSW/mzAgLDCJeLDJtOa9FXQFRj+f6MGOen0idaCgkNtKE4650I5fgcckPew1mDt6XdVhNsjOv6YjlZBq7h2epoLoKjQupfcFgNGQDaSEJu04Ui5Rf0E41Ku7LDIH6Njqv7KjWIGfT6CuWHm94xa2ZAftqsEM15kk57sfgkDyWedHl95JShiKw0l5U4eQxAlVD+wDXhAGTrSO+NMEU1xLUaFdBhZvE1rjCm5Jot5/MYhFE/962WwJq2r9s37R5RDAYlCudgIzU1Fi6ufTeV/OC5NgvbitQYMa2mc2r0qHuI+fN2ekT5AT7WJ7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUChdqM3uaohSUVo3YdU5cHCAqAMN6FLWbHpgj1isDk=;
 b=AhDSLH0DDrf3kuG1Xk4rRZ2ZmvgKfPh7wzQxsxT9eLEmsvt/N46glLHXc6kfuUyJCaN2TiAVcjxtWqpV3aAOUeVo/e/U+f+acrC6O+CS6r/+Kobm5grsBA8t469GqImHC09URfAy2qVs9BvLUCYNdkqrmZsblEj91XB7gnUR8Eh1HicrF40L6OOHvco4jY0c4BLkq+aLZEsAAnSObxJWi3tc4MrPt/jGOB2ZDd8WL0A/HfSM1vnG27p2ubQIEThpR3M3oiAX80Sv2bWJlrD9rHhLdFQaIQqWohiIv+GcvByjiDSyJNtNzwnCvqz3Ah2L35m8/5Bn/rlqjrxegcCQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUChdqM3uaohSUVo3YdU5cHCAqAMN6FLWbHpgj1isDk=;
 b=eu9IbvdiJVxiTjTrjD9hPjsP8Oh8p03K8LIOfEZI7CHCVduzc/bI5h2u0VCsPB3nkfz38i8jx7tZu/WWNUut9128iP1JPUVafzQULl28PiCU+jchVFnbSSJuUS6v/0FLfLG3kvkSxQHrE7JwoDI7aovogd5fBTWoDunBnwwN7RQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 03:47:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 03:47:15 +0000
Message-ID: <fdc2af49-95e7-4f26-a743-c9bef975ad71@amd.com>
Date: Thu, 21 Nov 2024 21:47:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add Suspend/Hibernate notification callback
 support
To: "Koenig, Christian" <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20241118200323.16541-1-mario.limonciello@amd.com>
Content-Language: en-US
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241118200323.16541-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:806:d2::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcae67b-a9a0-4fda-dc58-08dd0aa85aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEEyYUhldmttN29kR0F0TFU0ejZhNzVNZFI2eTQxV2VaZWNqYjJUNG9RSDBC?=
 =?utf-8?B?VDA0T091RVh3bmtBbFRRUnlrS21QNnNPcTY1TTgvY2JtRVJjcVpDa3hEckJp?=
 =?utf-8?B?REpwZjVuY29zS1h5QjB1dThJWEEvcVhTdHRnV1hPRXBKNVlPejdmYnRvN0NG?=
 =?utf-8?B?QTZsa21qWFh1OG9qRzYwS2t3b2ZlRzlsVEhYMzVtQ01nU2Q1bXFuSWUwZ0VK?=
 =?utf-8?B?bkZkc3Q5MFNjbUhtRUpDdE94clVIRlp6UTAzdUplRlM5RWZPd3R5UkR3T1Bh?=
 =?utf-8?B?ZncxRTJjcTNzT0c3UW4rNm10QVcvclU2YVdXY1F0c3lGZWJCdzUxSVExQS9u?=
 =?utf-8?B?TDdWa05JVVdXNVM4cDVXaEk5RUFlMW80eGFoSG9aaXJiYWszZnRFazluejk5?=
 =?utf-8?B?alE5KzAxK0p1UWJ5RHQrQlNpdGJHa2FEQnBMNGhPSWhDTUk2YWRYNWRzSDZ3?=
 =?utf-8?B?SVcvVlp0aXZhUFVPVG1lSlZoeU1FdUVGbDY0YkVJMjFoMHdsaEg4cFFYMWFC?=
 =?utf-8?B?ck9hR0s3L0hpVWRtTzBpZFgvb0NKMFEwdTk2ZGQrREptbUpJMlBmaUJaRTJE?=
 =?utf-8?B?RXhRdVMwT0ZQV05PdmN5cElsR21HMmdBeStTWVhEQU0wd28vT0Y2WnVqZ2ZX?=
 =?utf-8?B?c2o3bXN6azFtS3NwbnRhelFiODBZd1ExYVNCN21IemRvbDd6aHJNT0doUDlM?=
 =?utf-8?B?NWNaL0tmQXdCYWhQNDdHNmZ1OXFNU1dsOUVjZHZnTEsxd3dWU21hQ2k3b0o2?=
 =?utf-8?B?S2lROHBzcFFFQ2hzeWpEbEFlSmY4VXhZcG4xME5vaWVmeGUyUGNyV09POGZ6?=
 =?utf-8?B?VkhtUUx2U2J3RWZxVStXSjRYZHZJaFNLSW1TcFpvbWxheG1JN2VoRUIzMUxO?=
 =?utf-8?B?UnQ3R2kwSGdRYlFhOGIrQU4yM21iakJKYkd6U2crR1p6WWxMMy9DdTVXUHU4?=
 =?utf-8?B?MExEMUNHYVovTHc3empWR2J5MzhXLzBvSVM5aEFLSEJITE85eHl5aEdkRG9k?=
 =?utf-8?B?VzJ5aHUva2huVWZpTFFDUzlpL3dPWkV6Z0tVRXVMWG5xR3o0d244dlMzYWFR?=
 =?utf-8?B?TWtLQmxZRXJYellpd1IzMUs3M0NITFQrbHQ5dFVGZEJZRkVYZisyTEhFcjhF?=
 =?utf-8?B?aXVjZFZrR0ZiL3l3cjBkWU4rbEdhOTdMb2lSUk8xTi9ndmdmay9iY2NZbUIw?=
 =?utf-8?B?V09jd201bHBnYmFxcXp5aXBqTUxpeWFPc1RhK0lxR0lmS3FkL1JsVmpmSjA1?=
 =?utf-8?B?MzNHMlJGb2c5SXpWRFYycm5TeEZLdEU4cWhFUVJ6UlkxbW1LL21sNmJvaWlJ?=
 =?utf-8?B?YkM4WXB2NXBiVklkaU5MNllDNERPdE1lUVdNZkhBaXBjNlhBRDVJMzJ6M0Jv?=
 =?utf-8?B?NWREQzhsTWZFbkR5VFdKVXdybWQyZjBXVWZBNHdxc0ttV2lvZExPS2lNaERP?=
 =?utf-8?B?b0xNbGpSZVR3QWJpcWowdHh1V2J3UW5uMG9Wd2xsb2ZyOUZjT3VLcE5YVG5B?=
 =?utf-8?B?YjFGY1dLb2k3RStidDJleWlOK1VwUEo0S09vV1NJeXlHRnRBa1hnWVplOHZI?=
 =?utf-8?B?a1pKT1hLQmdGNGEzbGZad2F6L2dsMENudmk3aHduSlQrOVMxNDAvQ210QlVo?=
 =?utf-8?B?cWRPOXNQMldPQjRuVVhLSG1CaVl0M08zeThFVlYxZENlZkxCRmpHTFFQZDVn?=
 =?utf-8?B?dEExTDhFaTJkV3Q4VmkvckE2TDJFdjB4YnRvMU1RNXIvK1FjOXBVMytnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWNYNytFUzdSUW5KV1UzdU00MFNHMzlpZkR0YVFZYUprLzhSa1ZNU3JqMjY0?=
 =?utf-8?B?RE9jMmUzVWpYS3NrdkNIam93cytvOGVVVEpjUTZrcmF0czRZd1JkT3FtbEJK?=
 =?utf-8?B?WmpSUUlXQjhLcWNKY2dkMVB6NHozdGZrT3FrVXNwcnJYV2lsbDlZdEE2cmtK?=
 =?utf-8?B?WDNWdmVFMFJQdmQrWE1pcy9tQkNGZWFLYmxQbXVZZjl1Y05kMlhNYTFVREtr?=
 =?utf-8?B?NlV3Mk9iNUd0NnpxWmZQd0ZYM1l0U3VNZjJ3Q3orTlZ4bGFsMG5lVjU4WFNX?=
 =?utf-8?B?ODlyYlFjanRGNnBueE85UEtEZTJjeVZ0OElOK2s3cWhUcHJ5U2RqU3dtYURT?=
 =?utf-8?B?Q2R6WTk0bXRvNDUxSTVDSU9XNUUxQjJSSGIvSXVGZysvN0Nra2V6WE5POW1k?=
 =?utf-8?B?RkJFdFhVb3d4N3pEWjQ0U0xyRDh2bHRDdk94c1IrSkxPNWV3YTQyMDB4clJs?=
 =?utf-8?B?Sm5hS0xVM2wwOHIzalpFaEo5QnFCL2dYdlpKTGpPclR6NFA5NXRhTzhVOS8x?=
 =?utf-8?B?T2s5eHpKQTNHbnZySHA4anYrSUNIeUk4TTZmdkd4Q0cwQW02K3MvblVjU2V5?=
 =?utf-8?B?QVNhNC8vRjl2aFhWb1hCSXV5UlJEQjA1YWd3azVFOHNFUlV6NC8yWS8wMU41?=
 =?utf-8?B?eWp0SFA1aEpTZ1BVWE1Sa2pNKyt1WGZHTzBUOURQZnh2VGRJTkhEejJpYldr?=
 =?utf-8?B?ZzlibFhvckJBdTNydFBVbjJpeGxIMkRaTHpEaTM1dzZIakRrdW9VWDN1RzFE?=
 =?utf-8?B?TlhpU3JUbEE4UHJFYzRtUytmK2dpMkJCRnZGNi9RTTJ1Z1o2U3IyYXp4ZVcv?=
 =?utf-8?B?RGtTbXVIWEFaUXNVODFYT0ZNazExZEpMbS9aTHViUDRUSkVGZDRTWE1UamQ2?=
 =?utf-8?B?YUwrMzdFRDJqemg2YXJNRzVMSVIybG56QzdPZ0dydnVHRUQyMzFXblpPUUZ5?=
 =?utf-8?B?Ymsrdzd3b2NuOG5Tc01ZK1VGeFA2djZKWWZQNHR3NndEWjVYVHRGTEhLeC95?=
 =?utf-8?B?WFYvaUxFeWVyS2xGK0pxLzBQb2k5S2k4SGJLblFQOE1xRHhmYllVWE5rUS9k?=
 =?utf-8?B?SDNHQjdVZU1DdG5qdWVwRUhOSEUzdi93cFRNb21LbUxyRGp1ZytDV2s1YzNY?=
 =?utf-8?B?SW1BT3B3bXJ6eWJ0MDU1Rm9YVDdmZzJoaGtLSDhRbzlxbHRzZGNsQWhNeHFt?=
 =?utf-8?B?b2NYeVk5d2pmM1FFazg5TXB5a3JhcWg5R2xETmdEVnpWaU4xd0FSQUw3MEM3?=
 =?utf-8?B?WnU4OFBWSGgyYnJicG5TU0RObUxCd1Y1K3V1ODdpY3hrQ3lLRzNWRG95eWpz?=
 =?utf-8?B?WWM2Q2xIL3k1ek9RUWtKY0srTEJYRDFHREFmYnR6a29PemNta1VGZ3VodjJi?=
 =?utf-8?B?NjdxcTBlSk5lcWNjWFVTWUUrWElBQWZpdHJxeWxxdUJxRTByNkpiMWhsZlE3?=
 =?utf-8?B?WVdNKy8rczJHRjZPZ2IyaHpDRUdJdzFLZER0Z2FraGZ0aDk1WWZ3RVNMYUFz?=
 =?utf-8?B?TjgrZ3BZdW5JUyt3TmRhR1M0M2h4OXQ1d1pCcFc1OVhIZTk0aENwVTBWVWF5?=
 =?utf-8?B?Mk5LUzRkQURhM0hPWXo0bFRhQ3gyczdRSmx3NjFCTVpFc2lqYkJGdUJKRC9K?=
 =?utf-8?B?TlNoQ2l4TkFoblJyQnRnUCt3a3ZKb01DMVFjbkMxR1YwR3BhR2NzTDhPQnVy?=
 =?utf-8?B?K3V1Z0VvaE9SMVpnWmNIbGozN3dXSVQ1WnJiTDhBSy9hRlo0bFN6TjF5YktP?=
 =?utf-8?B?blgvTElqeGp0bGRQZ1ZoYmVYUVNIY0xib3gxNnZUbmlvNklvTUpOdXhpbjN5?=
 =?utf-8?B?ZFhIaGQ3NGVmdVdRTWgrV2JkS1l5bVZXd0dXK0E0Y2sySjFuYWdoT0hGd3dt?=
 =?utf-8?B?Vm9wN1NadW1BME40N3BReTVPcFFabCs3YlZVekcrN1hWQ3BzNjdnYWRlZW1O?=
 =?utf-8?B?ZWRRRXB2a1Q3em90eU1ObUI0TjBWL2VaRkMwN1lOb3FCcFJ1QzNkN1N5Vkh4?=
 =?utf-8?B?emF6YW1xRXExY001TXJOUFBTYTY1dm00R29HWmtzdVF3OXlGQ3ZmNk9Hc3VC?=
 =?utf-8?B?bXhHamxFZWlwMVpDNis3dHVvUTEyNjMzdC9ORlIveHBodGVIaGJUeXk1Zmtx?=
 =?utf-8?Q?r9/XhzSKtAOwaUrh+o57altBa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcae67b-a9a0-4fda-dc58-08dd0aa85aaf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 03:47:15.0193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lfjqk9WrHP2blI2Ys0BSOy7bC6DSQaSaWLe9WoC3pblSLlaQNNud5zeFVrv1J+0XzVvIs88kz33JNYU77EY6ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
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

On 11/18/2024 14:03, Mario Limonciello wrote:
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

This patch has some very good feedback on helping this memory pressure 
issue.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a37e687acbbc5..e70ca85151046 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -885,6 +885,7 @@ struct amdgpu_device {
>   	bool				need_swiotlb;
>   	bool				accel_working;
>   	struct notifier_block		acpi_nb;
> +	struct notifier_block		pm_nb;
>   	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>   	struct debugfs_blob_wrapper     debugfs_vbios_blob;
>   	struct debugfs_blob_wrapper     debugfs_discovery_blob;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b3ca911e55d61..5a4e9c7daf895 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -190,6 +190,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
>   }
>   
>   static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
> +				     void *data);
>   
>   /**
>    * DOC: pcie_replay_count
> @@ -4582,6 +4584,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   	amdgpu_device_check_iommu_direct_map(adev);
>   
> +	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
> +	r = register_pm_notifier(&adev->pm_nb);
> +	if (r)
> +		goto failed;
> +
>   	return 0;
>   
>   release_ras_con:
> @@ -4646,6 +4653,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   		drain_workqueue(adev->mman.bdev.wq);
>   	adev->shutdown = true;
>   
> +	unregister_pm_notifier(&adev->pm_nb);
> +
>   	/* make sure IB test finished before entering exclusive mode
>   	 * to avoid preemption on IB test
>   	 */
> @@ -4777,6 +4786,33 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>   /*
>    * Suspend & resume.
>    */
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
> +			return NOTIFY_BAD;
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>   /**
>    * amdgpu_device_prepare - prepare for device suspend
>    *

