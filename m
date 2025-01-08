Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77122E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 17:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222CA10EC2E;
	Wed,  8 Jan 2025 17:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f6knO31d";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762F410EC2E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 17:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcA6s02mWduk+mT90maLYEY+v24qabqE4eAS+JckczaP0DY7bbEk0BAjyDO86oJaJQAgw+h4SZJ3glQJsB/sXibveOhCpU1u/v+So5n59VKrl6xya2qDW2Yl+S7zT5X/l6EauPeiZ2pDgjSDf6IJMZUO+5NRgBreVqYLH9o7rTT84eV13kwbOMxC5ioPmWPxXmDc7rYX3kBBkn89gGuOZauvrL0lrV5qHNLV9G9TUmt2BgzxLym1tTY9fGyUrAusObJdZpBUZ96ZhA8VKJJqZM1YBaeEm0T9D+NXKZW55H4MOzSCZrK5vOi4J3/0KHVwXZTUYm20LrKKXmH+xYJFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm/rCwyMuF/giTXfqdpxuq84r46PkLhGkg1mq16b+Dk=;
 b=GIFZrR0ycPo5S2ThcCVhdAE+UcpyBDlNr2BRIdsd0bB7rkOP1Ic+yFZOLAciSyw1nsphSl9y0bAEPV0Xfoib2BExq1mvIJppsvAD73F/TG8dxqLCkqFK0d3Ev+3IyXyZlaqOc9KkUQtpzeXKHozBLh4SlCr2SKrI1BJwSMwAN3jAJuXlh048FdlaM1J20Gg3+0jW238+oTuvYBxqsWGOx9Aq+99XW5aXDBExhVIq1j3Zc3S2E3BdLvcLQBlHYUFKDMRbZ/c9l+Z7Kmn78ZNs0R8hZEUnDpocGAYDePaip35/lt70Mg8eUMwBZKQ9pMNlz8wXqRXHP3TMYYLSMLw9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm/rCwyMuF/giTXfqdpxuq84r46PkLhGkg1mq16b+Dk=;
 b=f6knO31dkOWDYUbQd5OwG5pxpX69rodMnsUz02u7/PMDWmhoc+2VQKzveHLZQB8I7kVCyRGlZW3iPLhd3GYo1dUW2GVGX2PQdjmm2/Faq3AOAqvIJqbKU+ncvMWp2iLAA/H6ZMgdYL6ba1GL/V1AqgHHaAxHHzXWZtS2Agnto1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 17:13:32 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Wed, 8 Jan 2025
 17:13:32 +0000
Message-ID: <71bbc63e-55bf-496b-8574-2fbfcfe40e17@amd.com>
Date: Wed, 8 Jan 2025 11:13:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/13] drm/admgpu: make device state machine work in
 stack like way
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <3d3920095879123b7261c7529ad4a61ee5e56259.1736344725.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3d3920095879123b7261c7529ad4a61ee5e56259.1736344725.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:802:20::26) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2569f3-b6a1-4b5e-a216-08dd3007c72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c09tOEVMKy9zby9pR3pOTEdlL2thMnFXTmwzUEdRT3JWdTJOQmhuaTRnUmYy?=
 =?utf-8?B?UkgraG14YUUxKzBUT0RsSzFUY0xoQ1Z6MVkrT1BJUjhqMm4wWm5UT2tnckFr?=
 =?utf-8?B?V09NN3didVFDMlZCc2tGU0ZoTHVZWThnMXR0azBrVHFOQ0MyT2FZM1lpSElZ?=
 =?utf-8?B?STZjQjJodzNlZVoxbFgrdVFJRGkza2lOVTVXY2NYNVB2bzdRcVJ0dmlEWjRV?=
 =?utf-8?B?TzZud2J5UGhVQlcyTE40aExCM1lRKzVteSsydjVlVXFkcTJ2cVhVMGMwSUZu?=
 =?utf-8?B?RkFMVzg2eEJ4ak4xYVlEcXc3L2hlZjBHYU1BRnBYa1RFbHlOdFZOYXhJQS91?=
 =?utf-8?B?QXF3UWlRbDFaUit1K3pMWkhkYW9HbWc3U2YrS296Y1RnS3hwQWpzV3ZFa3FE?=
 =?utf-8?B?WjZyQUtmMlVWKzJ1RzF3b1UwejNFRGQrU0dWeW8wSGpncnZ4M2xZU0FaWFZK?=
 =?utf-8?B?V2lWS0dEemdESzJBVCtpS2wzbTc5N29LV3Y2RFA4QVJZcmdLdEdpdTZnT3g4?=
 =?utf-8?B?cHErUlNTOFBBdFJPdFh5eGhJU3pjYks5OE1OUXZoR0VnNnhsUnVOZG5WOURN?=
 =?utf-8?B?c3BPcGRJcWNySjhOb1ZLK3RuMXA2S21MQXRtcUoxNkNad0svYnprSW9uRi9X?=
 =?utf-8?B?WWJGOS96SDgxNnRKbnQwK1c3aWxzOXJpR0hEWlBvRXpyKzQxcjhMQU00ZTVm?=
 =?utf-8?B?R2ZRUUZTSDZTMVRCL2N2cExDQU1IczkwUDZjSGhFZkk1eFpOSTZ3RXJDWThU?=
 =?utf-8?B?TTZFQXdPcXF6L3RzaHpRSWtJdU94dWpoWHVBU3pGMUs4ZnZwcEp4bVM1bFJz?=
 =?utf-8?B?NytIa0haVVAzbWhrd2VxUmYwVmtTUFd5TnJLaER5dG9FTVJ3VGZJM1ZtcDJ6?=
 =?utf-8?B?Q3hOaFIraXppRU9XWFFxZUNaMTFNWUM2djl1R05QanBQeHhNTDlCQmlBUS9B?=
 =?utf-8?B?SDcvcHQyMDlGOFAxa0NoTmVUcmVuSXc4VVlrR1dnZ1g2TlBuanV5SWRzWnFL?=
 =?utf-8?B?SjVNdDl5ZndwWFN6cGNuNlNha3RZbTUwSDhFVzhOOHVhRGQvSnVCVFRnWHp6?=
 =?utf-8?B?TmlKZCs4K1duVVg3dVV0QlErTU9QbUl4RTJ4K01TSU5hZFo2bnhJM0FRT3lC?=
 =?utf-8?B?bnJnRFFMeGdOalZzNkZ1WGc0NEtJN3pZcTlBWUw1QWo3SDI2Qlh4VGIraElH?=
 =?utf-8?B?d1kxUzdVNzBXckNSY1k5VWNsbmtvUkxTdDR5dmpOVzREU3FheUdmTFJxcW1s?=
 =?utf-8?B?MHcwUW15N1dLbjVnSkxjWGh6UzRwNWVadTlYRVlab1c4czA4azA5QzZPZTUw?=
 =?utf-8?B?djhueVBMT0NqTDdtbm4ybXF2OXFHREtlS2JOVjBOMWg1VWlrUTdxdktJVHVn?=
 =?utf-8?B?ZlJQZUduSXFkaGtmSk8rWUR1RENyQU9UWDdzZ21lR2R6dHo0R295Qk4xV1Jz?=
 =?utf-8?B?SGgxZkFFeVh3REZVL0FZU0VmUmpZTjEvNnpXMXdEQWpSYVp1Yk13MkZXaThR?=
 =?utf-8?B?U0s1MEF1d0YwRFkwV3h0am9XUkZpVUI0V0NIU294SFpSWG5YM3RBU1hZWlFZ?=
 =?utf-8?B?NXFzNzF4bmsxWVBSbUptUVpmK3J1NVJwSXJ5dzhRZFkyNDIvZmJ4MzFOcVRj?=
 =?utf-8?B?YjRkWENnY3QzMytJNXFqZ2hGMnhHZ2MwUkx0ZFN0UUNZNFpsVkVyQ0dZWW9W?=
 =?utf-8?B?M3hrL3hrNmY1WjBSSnV0Z1MzZmIvbUNldmtYcjh2eHAyeWRNVjczZ3dIeGx3?=
 =?utf-8?B?QkQrdjhwbVo1Vm16NkxDS0VVNE5na2tIZzRKSHRETGhUYjBNMHZSRmFZeFZj?=
 =?utf-8?B?Yjh6dnl6V2U2NDBQckJRQVRiMkF4MU16VUd5QmRRMEJBcGcrY1B3M2xHcGlS?=
 =?utf-8?B?WFBzZFFuWEhxdSs5UVBKQzZTQVNTYWw5cllrL0dMQm9wVWk5OUgyU2RaMXRY?=
 =?utf-8?Q?zNY9CwIY7UM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um1zTXVFbnc3Vi9NK2pnV0xla3BERGNoTE0yRFpQN0JCeW0rdHlYOVN1b0hC?=
 =?utf-8?B?cjM1WGQ4ZU1FM0tDK0Rhbm05OWQxOVFYRE9IRS9wWHRqTU1pa2M2OEpOaHdp?=
 =?utf-8?B?clozdS9KRTlWY1FMY245MUVabDN1RTZNQjVIMzZzRjY4QWlPUjNqUkdXY09I?=
 =?utf-8?B?ZHJvZUxiK0laSzkrNDVMTEpIU2daMVAzenB6cVJwRUo2RnE2eFpPVS90RSsw?=
 =?utf-8?B?VXJueWc2aTVPcHNlNDMxQ3BpS3lVSUdELytXWEUrMGRsak80RXNBeEhZNDBG?=
 =?utf-8?B?aXRWMTl3TWg1Wi82eFpoTFVLUUJLbkJ5MlNtQVU2UlhNbE1JOE0waUdnTkcx?=
 =?utf-8?B?SVFWenN0MnhHZXhWUlVXNjRRdEh3Qmc3dllvdEp6Vmo5MXV2WFBtYzBmYWJy?=
 =?utf-8?B?Z0dacjBkU1lPUGVxbTBkMnNXMWRGNkdCMWhRa2xNRFNvYngrV0ZqL1pJdi9W?=
 =?utf-8?B?ekN2RjhtRjBJUXBZZTQ5N1dwTm5scVNOdGFUTE9GVmh5SFFKamJDYjdhNHE3?=
 =?utf-8?B?RitjLzRMYldLZzhrY2hLdXkvcXdBdWhlNlVxcVNKQjVUSHFzcm9SemJxWFEx?=
 =?utf-8?B?MUZITGNMaW01cjhOSDNQMDlQV216RzZTRHNXRGRIRFJUMUtrekp1WGNRSXFh?=
 =?utf-8?B?eDJ5U0Qvd2lDUmRZWmtZWVJvbzBzNzVrZFVWN2pxdWlxRWVOMGZWSGJTb2Mv?=
 =?utf-8?B?MTNadUh6ZmtUM0NIVXpDVkF3L1U2V28wcG95azF4enh3R0c4Qk0xUmpJZEdz?=
 =?utf-8?B?QzNCZVdMc1VRZm9mYWZsb05HNTB2aHF2cGphUXBZN0VPRlRMU2szeHZhSVFs?=
 =?utf-8?B?WklkY2JjMFlicjhQUDBnQWRPbGVRa1JkMHB5ZFdsT3dROTB2cVRSQzIxLzBP?=
 =?utf-8?B?U01KMDh2a1M3c1VXckx4R1hQSXgzNmRLY1FwcDNZMFNtb1NPelorcHV6Nzlv?=
 =?utf-8?B?SGhYN0tQNHdIaGJEemwyNVpNMk90Z0lMZzVGWWRObi9yMi9NM3NHcG11aG1R?=
 =?utf-8?B?cUNyK29xSGtzNjR4b08xUkJReVpuMkVyL3RYdlRWTDJWZEpiQW84UUg5M1ox?=
 =?utf-8?B?bGt1VktTRVE5RVR3WkxyYWN1U2k5QnU4aXZTVHExZU1zMldaT2l3UHI4N2U3?=
 =?utf-8?B?U25vTXNiQ2tkSDFPTTNRR1gwL2wvNS9zNFRhTm13eXFWemM3emQ2bHo4SWNQ?=
 =?utf-8?B?SjFGQWQxRUtTY2JxWTdrWTNJRnNJZ1NGR0NLRGtibW45TnlXYTRtOWlRREtG?=
 =?utf-8?B?SVduY2J6YmY3czRndEwycldlSUFLZGhSd29nY01rTzB3dG9aZ1REQlNMQkhE?=
 =?utf-8?B?SjdCS241Zlc5RzB2czlZeFA1L1J4SmRvZ3lUazIrVTVsZXZlQy9pQWV2b0hE?=
 =?utf-8?B?VnMrZUNYN3VoWlpacS9DUU91KzlZZFhuaWI0ZnZQd1BCbnVUUzVtYTFWbjg1?=
 =?utf-8?B?b25maEtPa25vUG9ONlB3T3IvdjExVm9FTUpDYkRTTEd0N3ZxRHQzNGI5d3c5?=
 =?utf-8?B?QUxWQmR5YzE4ZVZndmVrVTdMbEh0ZWJLU1FZVjc5cU9UdXJJZWg2VDc0M21v?=
 =?utf-8?B?T0NRZHc3VXpxOUJIWWp5TTdpRy9QdlNJMlNoS0lKdU1OT3B3TmVUcHlCVXF3?=
 =?utf-8?B?TitDRWVNV0pWanRGNys4dWdMUGlaRmxGcHZqTTk5emQxT1pDTlpUR0hYMWRu?=
 =?utf-8?B?ZHFITTZ4MUYvN0F2cUJySmNiSzBnSkM3bEtxd2laMSttMFkrK2ZPNzhjSlR2?=
 =?utf-8?B?TnhTMkprbUxkWG9HZFpvbTVFUitLUE4zdkU3Rm9xNmpQQ29xcTJsbkI1RHJ0?=
 =?utf-8?B?eFlxQUN3L2UxWVRneitpeGoxNFdOeWppZExNSFZGWmtSdG4zVnp4cE5yMTdG?=
 =?utf-8?B?VXJaMXU5Q0o0OFdXWUZpQWpzMWQwbkloa2lIQWNYTGc4aGtwblU3dlZldHdx?=
 =?utf-8?B?di9LckhlcEtnZ20vQkJzYklHSGk2ZXVlNnRHOFVEVkpuYWNFZkNqNzhvZXE0?=
 =?utf-8?B?aUNFOTN4Ym9IK1hNWHliWU9LclIxRnhWTHU4RmdIQkhrbkNGR1RoUHB4SVJW?=
 =?utf-8?B?VS9FdGhJb2JrSmhNd3VxTHZsN2dVK0lMeDVFa1ZaZzRyU0IzMVorZHFGRGlt?=
 =?utf-8?Q?fJyW4QqTiNh5auPghP71ALOB2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2569f3-b6a1-4b5e-a216-08dd3007c72e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 17:13:32.3182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZufzjOJu8MfP0A9ndUcEXjzSFo4ubC31tV6tORlDvgxRPUiwnZJ1L3zzexQzgsepUa5QMINXmV4bTe4eR32xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
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

On 1/8/2025 08:00, Jiang Liu wrote:
> Make the device state machine work in stack like way to better support
> suspend/resume by following changes:
> 
> 1. amdgpu_driver_load_kms()
> 	amdgpu_device_init()
> 		amdgpu_device_ip_early_init()
> 			ip_blocks[i].early_init()
> 			ip_blocks[i].status.valid = true
> 		amdgpu_device_ip_init()
> 			amdgpu_ras_init()
> 			ip_blocks[i].sw_init()
> 			ip_blocks[i].status.sw = true
> 			ip_blocks[i].hw_init()
> 			ip_blocks[i].status.hw = true
> 		amdgpu_device_ip_late_init()
> 			ip_blocks[i].late_init()
> 			ip_blocks[i].status.late_initialized = true
> 			amdgpu_ras_late_init()
> 				ras_blocks[i].ras_late_init()
> 					amdgpu_ras_feature_enable_on_boot()
> 
> 2. amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()
> 	amdgpu_device_suspend()
> 		amdgpu_ras_early_fini()
> 			ras_blocks[i].ras_early_fini()
> 				amdgpu_ras_feature_disable()
> 		amdgpu_ras_suspend()
> 			amdgpu_ras_disable_all_features()
> +++		ip_blocks[i].early_fini()
> +++		ip_blocks[i].status.late_initialized = false
> 		ip_blocks[i].suspend()
> 
> 3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()
> 	amdgpu_device_resume()
> 		amdgpu_device_ip_resume()
> 			ip_blocks[i].resume()
> 		amdgpu_device_ip_late_init()
> 			ip_blocks[i].late_init()
> 			ip_blocks[i].status.late_initialized = true
> 			amdgpu_ras_late_init()
> 				ras_blocks[i].ras_late_init()
> 					amdgpu_ras_feature_enable_on_boot()
> 		amdgpu_ras_resume()
> 			amdgpu_ras_enable_all_features()
> 
> 4. amdgpu_driver_unload_kms()
> 	amdgpu_device_fini_hw()
> 		amdgpu_ras_early_fini()
> 			ras_blocks[i].ras_early_fini()
> +++		ip_blocks[i].early_fini()
> +++		ip_blocks[i].status.late_initialized = false
> 		ip_blocks[i].hw_fini()
> 		ip_blocks[i].status.hw = false
> 
> 5. amdgpu_driver_release_kms()
> 	amdgpu_device_fini_sw()
> 		amdgpu_device_ip_fini()
> 			ip_blocks[i].sw_fini()
> 			ip_blocks[i].status.sw = false
> ---			ip_blocks[i].status.valid = false
> +++			amdgpu_ras_fini()
> 			ip_blocks[i].late_fini()
> +++			ip_blocks[i].status.valid = false
> ---			ip_blocks[i].status.late_initialized = false
> ---			amdgpu_ras_fini()
> 
> The main changes include:
> 1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().
>     Currently there's only one ip block which provides `early_fini`
>     callback. We have add a check of `in_s3` to keep current behavior in
>     function amdgpu_dm_early_fini(). So there should be no functional
>     changes.

FWIW You added more than just the in_s3 (which is correct, so update 
commit message!).

> 2) set ip_blocks[i].status.late_initialized to false after calling
>     callback `early_fini`. We have auditted all usages of the
>     late_initialized flag and no functional changes found.
> 3) only set ip_blocks[i].status.valid = false after calling the
>     `late_fini` callback.
> 4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.
> 
> There's one more task left to analyze GPU reset related state machine
> transitions.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 22 +++++++++++++++++--
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
>   2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 36a33a391411..5c6b39e5cdaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3411,6 +3411,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   		adev->ip_blocks[i].status.sw = false;
>   	}
>   
> +	amdgpu_ras_fini(adev);
> +
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.valid)
>   			continue;
> @@ -3419,8 +3421,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   		adev->ip_blocks[i].status.valid = false;
>   	}
>   
> -	amdgpu_ras_fini(adev);
> -
>   	return 0;
>   }
>   
> @@ -3478,6 +3478,24 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>   	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
>   		dev_warn(adev->dev, "Failed to disallow df cstate");
>   
> +	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {

This is the 37th time we have a for loop that walks the IP blocks.
I'm thinking it would be good to have for_each_ip_block macro, what do 
you think?

> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (!adev->ip_blocks[i].status.late_initialized)
> +			continue;

If you take my idea in the cover letter of moving the state machine into 
a single variable I think that some of these cases can be a little bit 
cleaner.  IE if it was never valid it wouldn't have progressed to 'hw' 
or 'sw' states.

This check (and other similar ones) could turn into something like this:

if (adev->ip_blocks[i].status != AMDGPU_STATE_LATE_INIT)
	continue;

> +
> +		if (adev->ip_blocks[i].version->funcs->early_fini) {
> +			r = adev->ip_blocks[i].version->funcs->early_fini(&adev->ip_blocks[i]);
> +			if (r) {
> +				DRM_ERROR(" of IP block <%s> failed %d\n",
> +					  adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
> +		}
> +
> +		adev->ip_blocks[i].status.late_initialized = false;
> +	}
> +
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.valid)
>   			continue;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f622eb1551df..33a1a795c761 100755
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2175,6 +2175,9 @@ static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> +	if (adev->in_s0ix || adev->in_s3 || adev->in_s4 || adev->in_suspend)
> +		return 0;
> +

I think this set of changes to display code (amdgpu_dm) should split to 
it's own patch and stand on it's own.

>   	amdgpu_dm_audio_fini(adev);
>   
>   	return 0;

