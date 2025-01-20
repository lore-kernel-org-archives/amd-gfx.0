Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA96C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 13:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D7310E3E7;
	Mon, 20 Jan 2025 13:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XC/myyLO";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B276410E3E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 13:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSyfbUaKrw1/jmkiz79tyIjj+IJbG8NvIIoKZYMmRbfv3WkBP8Ki9CvxluAx1usGp6TWYfAfFqB2fRWtK1n/TnTAS6sL/iGcykWv2beiukZydJFsUhI9ifDnA+24LjYHo8BHfg3VNoIY/Hp2MEFo+ZW9PfnIZOGgl6HJHTaXC5fdtIlPanRkQ1fTJAczBP9T1pB4XtTEps5LGzJl7dXgeKVSFvCIKF93vOrYrjGvHC+AA8FevIWLiPB6CQedoZiJ8eHFjZru26xHYDDjw9hgKp7PrBToUvYcuWySQO9vpV5rPOaBTOe34qFdGQ+FKBumM2KrCg1STmyRW/MtiTOV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w78p/7Tgfrwm6l0WGqdIs4neETZ3mzPJz2dL8KmaizM=;
 b=yz3nP0AvvnVu5LlH8sGCCzkEz9DWIfjvp1LN5RPZQN29NataRvJLT509Cs5d7VzggS0H987TlBZube4uGBUHZ2haSptgsPCCs6YvGhqKzGwmOjqo/6gka9ogujgG4MrDj1I/Koy2DrTg07J3HDme4L467Z3+y3+x3DMokq3iF6KdYJ0VhDu4pHJEQvEaZ9BQiGLuG46LlS4b7WCBxrjf2svpkL4zzL+d8bfxO+P+rArSGpx83qku8cv0JgdKPgLyXEj9zDVthpz6y5d7C+hTIPDvp69HcSTM1Vv0PIoAAHs5Goz/HFEAfZFMgKV+ylKecD39JJRjfxrVBg2Wm93zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w78p/7Tgfrwm6l0WGqdIs4neETZ3mzPJz2dL8KmaizM=;
 b=XC/myyLO98m5Yu6llLqKDSQbalZFYS0PXpwK+v0UL3MqJjV/HuXPneTqtmSnD/dpYgdr6Abm7/yv41tFEAfi1TuXQa+Bs2LO3bBR0Rl5ySLNsq/rp/RoTLdW92fJtUsMljvyCzO/BaXntfazq5XwSvhMpQFtTKyJiBhEDmruFlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 13:03:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8356.014; Mon, 20 Jan 2025
 13:03:11 +0000
Message-ID: <90fa2a22-1644-4405-a632-7c0e0c6a5c74@amd.com>
Date: Mon, 20 Jan 2025 14:03:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Prevent null pointer dereference in GPU
 bandwidth calculation
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250120123206.188410-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250120123206.188410-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba071f4-dc0a-4c27-8d25-08dd3952caf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE9CMGM2TEJFZENvTkp1eXIyUFVRZFJhYVJMK1FITDNodjArRi9HNi9IZkp2?=
 =?utf-8?B?dzU1NGRxTzhWeG1tMG9NelhhWktQL2pMVEZucVl0b0t6bDZmbHVsZ0NqWk1q?=
 =?utf-8?B?VVdaejBPdjhEWjk5aHdxYkl5cktQZDZOb3lhZGNzSjBwTm0xVTk3NjFNcnVX?=
 =?utf-8?B?c3VDZnA4aVpWcWhiZEhMNzdBZnRXYmlWZXZmeEN2SHpXak04MDV4QUp2MXYy?=
 =?utf-8?B?UFh1TGVIZVZ4SW5kVXFFU3RqRkluNlpzZWtzQ3A0aXE3WjhTR0FxRDJmdEMv?=
 =?utf-8?B?d2VxTzRVYWxHbFhia1AwRHRZNDFwYmp5ODNjYnlZRWhvV3drMGpSa3Q2RUhS?=
 =?utf-8?B?dXkxUTRmWVIzME9zaVNabVM0dm5DYTNScDBjVUQ5NFEvMi96cWNhSE5XYWhB?=
 =?utf-8?B?NVFNSHJobXI1R3NZL3JEWXA0b1Q0TVRabHV2cGJ6TkVJNGYycmR0dUlwWW9K?=
 =?utf-8?B?QzlMYmZZcytDQ0xIMGVrU2dQUFBBSzU4YjU2bkRheTEzYWgwZC81SC9OVU5l?=
 =?utf-8?B?YXJ2SmJua1dyaE1PczhJNlFpaVlUdGgzcDVERnQzbWM2a3FEZ0NDMysrekc3?=
 =?utf-8?B?bWx5Y0cxNHM5VGxoam14cklyR1FZTU9Wbm1NZStDN0Y2RW1vTTZrdmlyVnlG?=
 =?utf-8?B?WjBZSVhuL1pQNjQzSjhLTDFoMXEzeFdWZkRzeENHRllxRXpLZHFFNnlkOEQr?=
 =?utf-8?B?MytEZTdGZ2hHa1FCNWQ1WVFFRmNYYWZySGhPUVhsRmViUSs0a2ZEazkyTGpI?=
 =?utf-8?B?WUYvcVZISzJab3JhQ3Q2SWNMTFIrS01FMkRyNTlSZE05YUFPV2QzcVUvMXBH?=
 =?utf-8?B?VkR4YW1mV1RLTkFPa0lPL3d0Q1ZDY3RDeUVTRDh1MlhXbHlrQUdkYTFiQXN1?=
 =?utf-8?B?YWJuck1HQkhYa0tCWmVJamMxbGovMnlVNmRNZFc1K2lUekx0Q2gwM2VHWTZM?=
 =?utf-8?B?eWY2WUZHVEhNMTF2TW83OVlMZ2s4Vk9TZWFvUXFWb0NCQ2tJMWxVam1TMGgv?=
 =?utf-8?B?WENUOVFCcUtqRUthck1vTUZyekE5MmZTRjNLOC9XdEgwM3FrRDNxQVVMRFBZ?=
 =?utf-8?B?dlZ6aXpqMlVSRlU0UVNvdHRJNTk0R3pSVTIzR0xXVVVFUkpmNzlFQVRSUUtu?=
 =?utf-8?B?T2NkS0NQT1dIVHhuQStYWjZXY2VaL3g5bmtzUkdGYVozVTNGbEtlbm9hQzd1?=
 =?utf-8?B?UVcrZnB2U3IxUmpLalVqN2EySXJWbW5tNlo3TEdYUFBYejNFMkVaRUhCaGFF?=
 =?utf-8?B?YzZ0ajc5bnFzVmkyTTljSU9kc3lEMlJmVXBRVExXSXN1SkdUK2cxY3E4QjNm?=
 =?utf-8?B?LzNjVVRDcENnUklQR2dkalBvMUhyQ3hsY0tlMGxNdGgxRlRNdUN5K3ZtWXFY?=
 =?utf-8?B?eDVCZ3FHQTJrQnVtVG1xOXl6SVU1SlBmaWtiZktVWXFjaWhIUS9EeG9meDdO?=
 =?utf-8?B?MVl5S2wvK3hZNVdLbDJHZ1grY3NRb3ZaUzBIL2MyQ2haQ1NYZXlsN0pJVmNt?=
 =?utf-8?B?bXhtYkNrbHNTQnB3YVdtSGlFcndNMktKUy9BTkRZNzJIZXRiYXBiU0VJOGpz?=
 =?utf-8?B?NVVZSTRkZUZkam5IODRMU0NUVHJNU0R6bWxkTzVpKzM2ME9wZ1owQ3JpaWlo?=
 =?utf-8?B?QUdKaE5hWTNlRG5kY09ZbzVEcFdNa2V1bGpRL1hNYVlVbXd0b2NOVy81cExJ?=
 =?utf-8?B?Sk1oTExJRFhraFJsZHRCU01NWGZIdi8rYy9xYklDR05INzQvVzJVTkhucmJG?=
 =?utf-8?B?TDJYeUVEenpvMUxFbCtYVUI2UXpiYzgxaEw2NnpqZWhjSVlVNDNEY3ZPTFJ1?=
 =?utf-8?B?T0VvOC93a0pEQ3dDMHZJQWxHaXRIMTZIQ3dSU2pMNzVmV3JFUlpRZkcrOU9G?=
 =?utf-8?Q?dQ47Myxg13jy6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXcvLzdGZ0lLNnA0TlJQMzlsTGtEV2t4ZXJ1dVlsQmVUb1d4OVFDRVpoRHE3?=
 =?utf-8?B?elRsbnhUTXQxQll5d0lyRWdUSXczenltQkQ2Z0VLTmtzTURJS3Fhd0NXcGx5?=
 =?utf-8?B?YkJ3NFRGQnlRYU1CdXZRRGs4WnFZS3lXbW1yZEdzV21SSVFJdjA5TVJVa1Zq?=
 =?utf-8?B?ekZLeU10Zys0QXlOS1NmSUpHQnZNQ0pjRnFOci9UMWtXMC8vYVZyeDRCT3l6?=
 =?utf-8?B?c01TbnVoWjYxWTJFTThQVi8vb09laUt0aE5iTzYxQk9rVHlQVTNKdjI5RU9z?=
 =?utf-8?B?dHhmZjUyRlIvbWtIeGJDSzF4UjFpNVVRdjZOeFNKb2NsL2xGUXhDUm1CQ1p6?=
 =?utf-8?B?QjAwNzhkMzQ4U3dnVkhYaDdPS1RBT29UNXZwT1RGMENlSE0wbXE2Vkp0YjF3?=
 =?utf-8?B?b2oyY3FYUE9oa25HWGY2THc1c0hjS20zYTRtZTJ5Ry95OVNsaEx2a0lzSFZT?=
 =?utf-8?B?eGhYK0FIN2Iramg0R1Y5NGtweGUyOVZjMytlOFBRL2J1YWtEV2xoemtwM3Qz?=
 =?utf-8?B?T1dZS1hVWmhDeGh1QkpsbEM0YU5qOTI1US9JY3NlM1BVQmVyMkJkQUNqOEs5?=
 =?utf-8?B?R0hocExJWVd4TmlJSS8vOUZ4VVp0WGQ5WlZkNDBMdmUyQ2FLenorbFZIQ25t?=
 =?utf-8?B?bW9tR2Y5WVY2eTFCdEE3WTBjLzNJVVpvOU9aTk1Gb3MzdDJ0T09UWEt0aXNK?=
 =?utf-8?B?UzMwTDZBTTR2YlpuZGxMMlp5cHJsRm1hdVJqZmhjYWJpWEUyUkVsMXcwcG5R?=
 =?utf-8?B?OUo1NWNRTnBIc0pka3FDdFBxcTFpdksrU0pGc0Fmc21nSnVBTDkyY1J2SW1K?=
 =?utf-8?B?RFU2eERlMmRDN0k5ZXJPUUVIYUpXdit2S2dHQzZOcW1xZWlBUzBoYjFteEs3?=
 =?utf-8?B?MU10Z0t6L1NrKzZXYk1BbXROZ01WZENyRG1zNUd4RzZRQWdUc2JsWVFtNllL?=
 =?utf-8?B?ZFlMSU1WdmZERlY4Q3BsZEF1YmtldGZIZTZ1SzJaZ0g3Vms2Z2Fmb0JReEF0?=
 =?utf-8?B?bjl6aE5aTUwzcmgrZEtJS2FMWXNSdm93L20yK0JEd0lzZzVoUENIeWp4UVc0?=
 =?utf-8?B?aUpENHRNclJSSG82MDFEbDFBVFVPWXNEbDFxUzZlMHo3eDRtME1NL2JBMlkr?=
 =?utf-8?B?cGlzaXo3YkE0WXBXa2dSOVlPT0JvRmFQWm10NjIvclNCaEhuRThlNTZOSG41?=
 =?utf-8?B?RVpwdjdaZzVlNEswVXJlc3I1c0FWL0w5Y3M1VWJFRVhoR2lsNXJ1U1lCUTcy?=
 =?utf-8?B?WGVDeHJ0MWUrcVhzTVlGb2Y0dGlvZXFjL3N0SkhQbkNzWGZiZm5va1BFN2hh?=
 =?utf-8?B?NDRXeS94ZDZPUEs5Qy85Vk56Nm1ZTWYwTVh5QVdLQnlCb0w5RWQ0bmtyTGpI?=
 =?utf-8?B?ZlZ1RnJMc2xjcEJkd1NDNGlqS0RycDh1Zm9yY1ovK2N3amVjMWN3Z0UzNG1l?=
 =?utf-8?B?MDRUV0E1cDhyR0ZjRjVsbURCSnFjdU1WYVQ1U3B4UXp5WHJ4NTNDVVEvZVhp?=
 =?utf-8?B?Q3IzTUQyU3RCY3czajJRZnZoWjByY1RkTzFmR3R4cngxdlpUYmsrWkJ4OUlG?=
 =?utf-8?B?dndPSk1sekZmQ0ZIano5Y2VXdmY0aGdIVENLcFVFYkZtbXZHUkxyUk5oL244?=
 =?utf-8?B?QXdCaWY4N0RsMi9ncEFuQXdxcGxqSExJQWZyTDJSbnNWbVJpazBDTFVxRGM3?=
 =?utf-8?B?Z2RtTURpcVo5T2dIbHAxUzF1OTBadHVyV0NieWxwSUx2UnNXdC8weW45dVJT?=
 =?utf-8?B?SkRBQ0lQZnluRWtVbFhCQ3kvZEw5REJGWnozbmhtNk52T0I3RjU5d293ZmtC?=
 =?utf-8?B?QnJ6eUduTmpxMnlHVGJ0dHQzcGlvZ3d4Vmc0RmpqWkZSblN4WVV3alYyNVB0?=
 =?utf-8?B?SHVjSzN0LytvWU8vdXgrQ1FhQU4xSDBHYnNtdkt6UkU2czFMcTFwLzQ5eTRz?=
 =?utf-8?B?dTF0THJYcVVQK2dOM09uYkpwT3Jnb2YzbXZKaXJQNWwxVkk3VlFEaXI1WTY3?=
 =?utf-8?B?VVhNd040NjJPNDJmQ1lMVThIb011aUt4SEtGcXVtUmIwQi95cmxiVDNrU2s4?=
 =?utf-8?B?ZGhLYkZGZHkweWVWcDNyQ1hlNkJ6VkRjOUlKbE5GdnJuSVBGVEVkZGdoSkNt?=
 =?utf-8?Q?WZHEu6k7lWdmqPhQs/zvg4fcC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba071f4-dc0a-4c27-8d25-08dd3952caf0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 13:03:11.3761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fO2OCXGeVuKOsNrX8QxJmOZGT0CyPjcSjN1CWt6M+DK3zlNnpe1N4l34IcybXMM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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



Am 20.01.25 um 13:32 schrieb Srinivasan Shanmugam:
> This commit adds an early return if no upstream bridge is found, setting
> the speed and width to PCI_SPEED_UNKNOWN and PCIE_LNK_WIDTH_UNKNOWN,
> respectively. This ensures that the function handles the absence of an
> upstream bridge gracefully.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6193 amdgpu_device_gpu_bandwidth()
> 	error: we previously assumed 'parent' could be null (see line 6180)
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>      6170 static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>      6171                                         enum pci_bus_speed *speed,
>      6172                                         enum pcie_link_width *width)
>      6173 {
>      6174         struct pci_dev *parent = adev->pdev;
>      6175
>      6176         if (!speed || !width)
>      6177                 return;
>      6178
>      6179         parent = pci_upstream_bridge(parent);
>      6180         if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
>                       ^^^^^^
> If parent is NULL
>
>      6181                 /* use the upstream/downstream switches internal to dGPU */
>      6182                 *speed = pcie_get_speed_cap(parent);
>      6183                 *width = pcie_get_width_cap(parent);
>      6184                 while ((parent = pci_upstream_bridge(parent))) {
>      6185                         if (parent->vendor == PCI_VENDOR_ID_ATI) {
>      6186                                 /* use the upstream/downstream switches internal to dGPU */
>      6187                                 *speed = pcie_get_speed_cap(parent);
>      6188                                 *width = pcie_get_width_cap(parent);
>      6189                         }
>      6190                 }
>      6191         } else {
>      6192                 /* use the device itself */
> --> 6193                 *speed = pcie_get_speed_cap(parent);
>                                                       ^^^^^^ Then we are toasted here.
>
>      6194                 *width = pcie_get_width_cap(parent);
>      6195         }
>      6196 }
>
> Fixes: 9e424a5d9087 ("drm/amdgpu: cache gpu pcie link width")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 46af07faf8c8..749791a486bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6174,6 +6174,14 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>   		return;
>   
>   	parent = pci_upstream_bridge(parent);
> +
> +	if (!parent) {
> +		/*Return early if no upstream bridge is found */
> +		*speed = PCI_SPEED_UNKNOWN;
> +		*width = PCIE_LNK_WIDTH_UNKNOWN;
> +		return;
> +	}
> +
>   	if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {

You can then also remove this check for parent here.

Regards,
Christian.

>   		/* use the upstream/downstream switches internal to dGPU */
>   		*speed = pcie_get_speed_cap(parent);

