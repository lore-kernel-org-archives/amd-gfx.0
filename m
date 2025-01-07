Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DDEE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 23:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D216110EB5F;
	Tue,  7 Jan 2025 23:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1NTezCER";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE7A110E356
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 23:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRB/umlniS7g7mmzfV2aqAZcnK6s8OTsAxaWois4xyBmlWAFLFBpLd+tuiuCC8BuoALkYXBJPBE//5wgppi7oMn4PGa9TkNQ82gLnm/ALMiDUt8yskqtPPnBoTa+3RTBXRpOhWtAMxcXItRhXaY2+swEmbOWrcx77MGguf2G973cOuI1sUEwLhodUNJSdtlxwFh/HiKx6G+8Ecz4bH/ptskyZMIdJFSQKFKdR3GaZezeljDb3qpmkXQI2GtiXCG4zF2QDP8O9XkZWLpUi3Iefpr5XdM8hXjlQ6qK6m1zmhV8bjW8puUaf0vvQRR+RgCxQCbtp1GjcXThZRAixy/dxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoQtfj11BzrzyBCIl1qaf6tcYzWQ8lQOPevK5Olx77o=;
 b=gxyEwAERIxa1O0INeHUjtDRugLqX7r0clum+sSPdXpeqoeHEpDSk+U5s2ff9LLT0YiInctha7QD3f+z36l1zYgfKXBhyn6Kux+CJfvpz4NwliPuyNUC4XhwwEsn/dXI0qnT32gahrkO4Z89i0AdJLAFwLu/7hfH5oOd17fknzY09TOpEsjGgMUhY1njLW2pyRgi9cXD1HL0RXOKKVHNwFZbXFo4UOZEJ0VGnUUvMyfFkOJpKxYZah2EJQU8tntd/I5nb08Fd/6tkcxszo6nVno28Bs3y/OKrgF2c/6p4zgpkqpPSLPTHydG/NyAv06kIqOLMVl6OUTI1W4tOO6KRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoQtfj11BzrzyBCIl1qaf6tcYzWQ8lQOPevK5Olx77o=;
 b=1NTezCERCsZ0lyZVQPnhAUKgfYxI0RQm3vlRkUkFeGwneFo9bRYqGYU8mAQdEHE5mKl/3QYZh3xMertGoxlXeoAw/wpJm+LcC8zDLEflwd34NrieAYum9eCAnO8CgaoD7gU6f5FsXyNOtsbjS8Z6AoIcIYDQlaZTbmvEdvqgdto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:55:46 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 22:55:46 +0000
Content-Type: multipart/alternative;
 boundary="------------R13tVoRIf6OE8Fi90ZHuDaZX"
Message-ID: <554e76ef-f41b-4d30-bf1c-e531dca26d66@amd.com>
Date: Tue, 7 Jan 2025 16:55:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
To: Jiang Liu <gerry@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 lijo.lazar@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com
References: <cover.1736044362.git.gerry@linux.alibaba.com>
 <f19a505b4ca42302ea8b8c399c07eb8f9f06a0c6.1736044362.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <f19a505b4ca42302ea8b8c399c07eb8f9f06a0c6.1736044362.git.gerry@linux.alibaba.com>
X-ClientProxiedBy: SA1PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::20) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: e62b6f06-a88f-4eb4-9e04-08dd2f6e6c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE9lWm9LSGFpR255Q2Jjcmc0UlVHcUYyMXFiSSt3emZJdHFsZnk1cjhJZVM1?=
 =?utf-8?B?T01uYXdLbTVIVWtzTERud1dORHZYSVNTUTFPQmZjMkJTaXkxa01lb2dPRi9Z?=
 =?utf-8?B?YTVaUEFZd0RLaWlGOEdKQU96NzJrYk1wLzVpNy95RHRBdW1ydks0WnU0WW9S?=
 =?utf-8?B?SHVRTnFsQ1U4Z2I5VWlMYUFnekl1M01TNDZ1Yk01QmlRZnJrZHRRYVpmcXVR?=
 =?utf-8?B?T3FPK2pGODByOFlHTEdOVmZCUXZIMzJRNmlhdzRLdW5oQWFqR3dsOGxvaFVH?=
 =?utf-8?B?UUJ2K09vMExOSWtnRC93U1Qwa0VydE1PZmZPcXdZaWh6K0IxSFlJMFlMd29k?=
 =?utf-8?B?NVJQZXFpT01zalRqaUdWRzNmSEd3ekkrMWFFV3VueWNndWtPT09nVVhYZ2p5?=
 =?utf-8?B?bWpzTzJKN1lEUDdsWlIyc3EvZyszaW01MTVZRGxneVBjQ1VyWmgvOHFWNHc3?=
 =?utf-8?B?WW15b3NMN0hZcXZnNk1qK2c4NmFuNzBvUmkvRmkxNGdVYTd3MU5ycWJiZFlE?=
 =?utf-8?B?c3ZCcklWRXFiUVd1ZzFTOGg3UW1hTHFsdHdPTzdHOUFXcFZrTWM1dzBDYVN0?=
 =?utf-8?B?ejdlNXphTkRJak9NcWpoYWhUbzhKYmFNajhwalA2NmtMMTJzZTFnWDVJZ0VL?=
 =?utf-8?B?Vm5WV1E5VTFjNFZ6TE43OUtYRTBDa2lhbmlsYnR2VlBHdExTTUY2dElncnJE?=
 =?utf-8?B?VkpORlg0M3VLWDZKNWlaMWt4NDdlSGlVMmROc0tYeEUzZzJGVDhjRDBDenVr?=
 =?utf-8?B?c09yT005TTNuUUtib0VKZlUwNGF6bDR0clRpREVyL3BncDFYaVl3QWUyQkFo?=
 =?utf-8?B?eEYyYzB6b3kwYXNYSzJ1QXdBUXhsc2FHMXljdVMrNVk2OVF5NHhZRmJkM2Z6?=
 =?utf-8?B?aHFqUnVwM3lZenEvQmtNc3JGRzlKeHJxYXZsZEU2RjZEczZxbTFmemhlZ3Uy?=
 =?utf-8?B?M0V0dXBqSUVEOWljR0E0Vzh5NDA5eVJEZlJScTExTUgyZUxFd0hISENRT3F3?=
 =?utf-8?B?WGQ3Wmx3Q1RJNDVxd3F0bzNzY3dxUm9CY0lTVldKSDZUMXlVSHZZTXJzTUp0?=
 =?utf-8?B?T0h2blZTWHVkMkZFb1djU0UxS1F0WWdIbkovOGl5N25WTmpPVWdadDB0bVgz?=
 =?utf-8?B?S3ozeU1MSlI0bWRGQ3pQSnRYS3BqY3hwdUZ3NXhBRmQxSGRnZ3BFU3NxS09G?=
 =?utf-8?B?VDF2Z0lmZXRkUUFFWUpXeHJRRnBVK0FiWmVPQmVBblpDWlRnako2clQvM3Nr?=
 =?utf-8?B?ZFFBVlk0dTFGUnFBM3BuU3JPSkFDWHdLcnBVV1FIQkU0RGJBcDl2Y1RvUktB?=
 =?utf-8?B?WkU3RmNTNENOcU5pTTZiN1NvWVpTMkdMV2thaHhXTElVVFRGQ3M5UmVDS3o1?=
 =?utf-8?B?SnRmcUJsUHBuaEpNeXlZa05pSWEva2x4MTB4UVNrK2I5em83cFJvcnZPTTE0?=
 =?utf-8?B?KzZuL0pDeS9HQ0wrN3VyRzdmQWdnd0Y4UnFqL29NZEhLOGdadWl4eUtPSGdP?=
 =?utf-8?B?eDlCYmlycVVJM0ptamttcXg1Nk1tcjNIbHU1bzJ2bUxhbVl1bkNIRWxPMUNX?=
 =?utf-8?B?czNEK0tkODdNUHBEdEFSWkNiZW42REdOai9ZYjl4U3RSUzJ3OHpqUmZ5a0tG?=
 =?utf-8?B?eHlMQVVWZDNRMmF0bjFSeUQ5bWZQVzlPNys5M2M3OFBjZGFMRDd4WDZ6N2dy?=
 =?utf-8?B?cmszUUtNMkQ2SnZIbUx3dm5mSERnMk03QjNvUkx4U21lUmcwT0JnTXpkZXBI?=
 =?utf-8?B?dklIU0JDMktOeDVIK3lseEdwK0UxV1FRZUJJZkhWRGUzbitSS1BEMWdaZnZm?=
 =?utf-8?B?YmpRbStWR0J0akQwbEtHQWMwcGdnUE04K3dQWWIrV2F0ZGpvUzVsSVJOZ05v?=
 =?utf-8?Q?moWS9JKbaGTuG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGtzeVpLOEZONm1VT0xWenlJamNWOFdtVnAwZklSWXFPWHdRMDU4QUNaeUZs?=
 =?utf-8?B?SGJyQ1dXQWZVREQ4dGw3bnNjWkpwc2JRWkJKK2dYWVorZTN0RGFHc20yNUlr?=
 =?utf-8?B?WmYzT2U2Z0RtVEZtZFd1K2NnVjQxaGVPcTVHWXlwUEQyNEhBTFdmSkNZSncy?=
 =?utf-8?B?YUpQU0haZHBHUVdHUmdleVB6LzgwNkdVK3gwWkp2UVZnbkhwTGdvRFFoOVFI?=
 =?utf-8?B?NmFLYk1BM3hZQ1BNbnd1V1VLTWhYNnZHWld4Rnp5d1duWmJxbVQrOGliMkhs?=
 =?utf-8?B?ZlZ0OEV5QUF2L1FHb0IzTmdieFU1RzhpRm9XWnM1VE14dDNKTnNvTVM1eEg0?=
 =?utf-8?B?RmdqdVN5aDNHUzVpVkZ1UnRoSno4aXhiek43M3hoQmViQkZuVnVsZUN6T1BO?=
 =?utf-8?B?ajRIcWoxcEZMdlErakdxeWRFTGdzQVQrMmhYbnRzSUVpdnZNUkdyYllsOGJ1?=
 =?utf-8?B?YUQ1ODlaMGhFcXlUMTIxZVJkMzNua0xZazVyUStWRFZXRWlaK05pWTVONk1M?=
 =?utf-8?B?WXZIWTl4TmlNc25PM2hkaVBRSDZ1OFNvdjBsdXdBVjRpUDZWWWtjUmlkQVFw?=
 =?utf-8?B?dGZ1MXAySVVuQnVqaUNLOUx5aFR2TmlCQWcyZkJra1pVbC9SYlhFWEY2VHgy?=
 =?utf-8?B?dFp1aWRkS0cwcG9Dck9PbTB3djFNYnJSOFdaSkhhY3lxRDB6V0VvenlWMUIw?=
 =?utf-8?B?UG5HT3Q2dC9uN1RGanlHd3E3SmFJdThtMWkxNkQzWVNTMFpaem81TERtV2xu?=
 =?utf-8?B?SGlncjRtZ0t6bDVmUjJFRTNUbkZrKzN5OU1WWStTd1o4Z05pRHZRbHBncFc4?=
 =?utf-8?B?T25rYXFDSkxEekZoZ2lDQlRYaEh3b1BIR3VNTkF2QUZjRE5ZNFBtcmZ4V0JW?=
 =?utf-8?B?VXpXRWd0OXdpYnc1QXg4eWloQVo2ZkU2M1U1bGtEYW1ZNGEwem9UU1RlRko0?=
 =?utf-8?B?S2lkQnhmU3g4SWQyTHEweUNla2o1ZFAxZ3lWMHVlRnBUVTgzV3hnUksvNzhR?=
 =?utf-8?B?SDgvYUZWUlM1THVtK2pjYkMxN2ZBY01qcnlsd2xpayt1U0R5SEE2UTRjRmR5?=
 =?utf-8?B?MFkwN2JvQlVBT1RoTnRSQmhzRzBMKzVUSmJQMGh0cGVvMXFyQy9VM3IrTHZZ?=
 =?utf-8?B?MUM1ekp0alZYRTRYSDZQTkVzWWRiRXpJMHZvQmEzSCt4NDUvYmlLVkp1SU5R?=
 =?utf-8?B?RXlMV1NCZ2g2c1VkMnltU1RYSkdhcTkwLzVwbU01VUpmeGMremRzR2sxRnNj?=
 =?utf-8?B?Tm0wL0NvZkxMRk5sWXhVRkQ3dURIV1kxZzc3VEx0Rk9acHpseHFZSk9NLy9u?=
 =?utf-8?B?QUlSRkMrSDgrTEMzZkVWOGZSU0VXQUhwczBtYUZzL0kvTEl5V1laamdzTUgw?=
 =?utf-8?B?ZGRLNkFsUmxZT3VlNWtucnUwdzVpV3ZvWjF3RTVaNUh4SVlRM1R5MXhKM2dq?=
 =?utf-8?B?bHBsdUxOZWpuOXorRXRiRmtFdE5KU0JLS1gyZENoRkNsVGt2cHNNTTVudzd3?=
 =?utf-8?B?alVGd2N6b1lFV3pHeDBIWm5YZkRZTm1Ua3BxK3VrMWJ4UnN1cmJjTjliSk5Y?=
 =?utf-8?B?T29LUGV2LzYwYVRpa2xLZjFjWWNCUktaQTBYaVpWOUlnSkxsWG52elMzT3Iz?=
 =?utf-8?B?YnkzOUk0SlNqcGJBWVFYSFFiU0w5U0FnSldSN3NraE5oU0lPUUdrNExZN1JB?=
 =?utf-8?B?RFBTNjIvemtaaDFxOWtLR3ZrdklkQWZoNUV0YXErSFlmRzBKMVgzcm5UV0dH?=
 =?utf-8?B?VkNHR2trOXJyNHArOFdJK0tWSVdLdmZ4eTUxdGowc29ObkhFMHBiWkNNU0l4?=
 =?utf-8?B?L3F1WUtmNHRXR05jc0w3REZjYVR4UjQzM3RDMFVDTVlVVzVsM1lsSkpHZVda?=
 =?utf-8?B?RTNuWFpVUk9zaU95WGVXQzJmeHNUL2IwbElwOFZuZzdvY2N4ZksyZVAxS0Yv?=
 =?utf-8?B?bmlZZWJ4MzZXV0R3WTIvRjBHenFTd1RlZndXN3kvR0JMQ2Y5UUtCUjd2U3Zy?=
 =?utf-8?B?UlFHOTgwRm1NeHZoUEhPZXVXbjB4MEJSRWxOalBVSjNYRlJiaGFZWGFlMXMw?=
 =?utf-8?B?SkJWeVFIMS9wSmpHdVVXbDZCNEtNZnd5OEhpazBIZEpwT0xtSUVHdGtFaFFZ?=
 =?utf-8?Q?7OgI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62b6f06-a88f-4eb4-9e04-08dd2f6e6c39
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:55:46.6304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jsbm9uHcvllEBL14J8gklOJvhxkUZyYYtey008rmFTEV7x30ch3o1vq3KImZxlN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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

--------------R13tVoRIf6OE8Fi90ZHuDaZX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/4/2025 8:45 PM, Jiang Liu wrote:
> Function detects initialization status by checking sched->ops, so set
> sched->ops to non-NULL just before return in function drm_sched_init()

This commit message is not what the change did: you set sched->ops to 
NULL just after return from drm_sched_init.

Other than that this change looks good to me.

Regards

Xiaogang


> to avoid possible invalid memory access on error recover path.
>
> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ff53a3b9851..475ab635c699 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2857,6 +2857,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>   		if (r) {
>   			DRM_ERROR("Failed to create scheduler on ring %s.\n",
>   				  ring->name);
> +			ring->sched.ops = NULL;
>   			return r;
>   		}
>   		r = amdgpu_uvd_entity_init(adev, ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf..b5e87b515139 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -656,8 +656,10 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
>   		 * The natural check would be sched.ready, which is
>   		 * set as drm_sched_init() finishes...
>   		 */
> -		if (ring->sched.ops)
> +		if (ring->sched.ops) {
>   			drm_sched_fini(&ring->sched);
> +			ring->sched.ops = NULL;
> +		}
>   
>   		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>   			dma_fence_put(ring->fence_drv.fences[j]);
--------------R13tVoRIf6OE8Fi90ZHuDaZX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/4/2025 8:45 PM, Jiang Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f19a505b4ca42302ea8b8c399c07eb8f9f06a0c6.1736044362.git.gerry@linux.alibaba.com">
      <pre wrap="" class="moz-quote-pre">Function detects initialization status by checking sched-&gt;ops, so set
sched-&gt;ops to non-NULL just before return in function drm_sched_init()</pre>
    </blockquote>
    <p>This commit message is not what the change did: you <span style="white-space: pre-wrap">set sched-&gt;ops to NULL just after return from drm_sched_init.</span></p>
    <p><span style="white-space: pre-wrap">Other than that this change looks good to me.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang
</span></p>
    <br>
    <blockquote type="cite" cite="mid:f19a505b4ca42302ea8b8c399c07eb8f9f06a0c6.1736044362.git.gerry@linux.alibaba.com">
      <pre wrap="" class="moz-quote-pre">
to avoid possible invalid memory access on error recover path.

Signed-off-by: Jiang Liu <a class="moz-txt-link-rfc2396E" href="mailto:gerry@linux.alibaba.com">&lt;gerry@linux.alibaba.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ff53a3b9851..475ab635c699 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2857,6 +2857,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 		if (r) {
 			DRM_ERROR(&quot;Failed to create scheduler on ring %s.\n&quot;,
 				  ring-&gt;name);
+			ring-&gt;sched.ops = NULL;
 			return r;
 		}
 		r = amdgpu_uvd_entity_init(adev, ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf..b5e87b515139 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -656,8 +656,10 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
 		 * The natural check would be sched.ready, which is
 		 * set as drm_sched_init() finishes...
 		 */
-		if (ring-&gt;sched.ops)
+		if (ring-&gt;sched.ops) {
 			drm_sched_fini(&amp;ring-&gt;sched);
+			ring-&gt;sched.ops = NULL;
+		}
 
 		for (j = 0; j &lt;= ring-&gt;fence_drv.num_fences_mask; ++j)
 			dma_fence_put(ring-&gt;fence_drv.fences[j]);
</pre>
    </blockquote>
  </body>
</html>

--------------R13tVoRIf6OE8Fi90ZHuDaZX--
