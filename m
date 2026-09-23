Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB5CC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C960710E16E;
	Wed, 23 Sep 2026 15:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GJ4gn7NM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F6E10E16E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:11:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fwfb+4csUGbTY7H4l6W+qSpDdOLZFvY57LnneaUrWc5rKl8ATut9pnBBMiVas+V6uNCw6sE8Zps2PqgQJ6iDU8YpDkoqmwWAMt+dOM1wU9sUgNaNO+3nUMYUUsBoK7SYmR8Y1b/Zrnt3yv/8v1C7zUueu8oo4vCEKbaa9HmSPv7EA0kvS1Vyw5q8PkHjN7JDyfdEZ+rshDEY/pstXeqwMj4LIfE0Vfaq9Yai0TK8QBimjRD7ycCOrC8vXySMpfGcnk2a5vYSz/4X2nzKwqmsL2+0WmOJFNdN1zoBOL0t2XmBBhXnTWmUMBvMuss/CzRHrTtNiqWiTZEjPSw+0h/GAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEXsAn+8zW/aqRdrP/z4NXHStc7GKwBKNLUuThRdZ54=;
 b=d77Lz8vPtleukVcZRdiJ6/5kvfIHJ7ZzoJjfyNMFy5xi9UCaxnim3jgulpkRbsn1qrMmHx8XTP/LWP6XTh9e7yUM6uLp7yuiZrzLYX+456Tg76Pn0+ef/KdlCg7vODSnPpxFQS1I8cMMF4b+Maun2g+fufNomcMEJR/EMbtxm1pK0OLw7FvjcY1RvE4uKSSf0fKeW/1ZV7w5LvxPbo2V3PqcjYm5YnAFF+oX3iX/rMMP/eLOLoHwLHTpNNwiEOaipBVC9wOZzsL+nRzMermufc6kPSkwE2upJ+W+AsMWZ0mXNw2hYhqHk/0/iJEuTKCZ392AAXSxize7gvKXsI8AMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEXsAn+8zW/aqRdrP/z4NXHStc7GKwBKNLUuThRdZ54=;
 b=GJ4gn7NMk+ewLCEAHQ8D/O4XnIU8pQ9gVcGl/Vko4HLgFpR4MvpXiqI9EBPQRMZUGFGhk7wX+0DZ94JwatMZLbBkYFRNf0yOP59Uh9t7YOaQMU8sxd3JjzBuTkv7cP/DIGdkuJdASHwL5DCtEbUhJzumD27mOBZgXVYrnffL9YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 15:11:02 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:11:02 +0000
Message-ID: <8b7a7bd9-c8ad-40d0-b1a5-a5765cfa5d11@amd.com>
Date: Wed, 23 Sep 2026 11:11:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/10] amdgpu: implement Performance Monitor Counter support
To: "Welton, Benjamin" <Benjamin.Welton@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <a97514f5-8a01-48bb-b1f0-645ac657bb0f@amd.com>
 <LV9PR12MB9831867DA9EAA980EA12DFFFF0822@LV9PR12MB9831.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <LV9PR12MB9831867DA9EAA980EA12DFFFF0822@LV9PR12MB9831.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::12) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ba3c5f-8df5-4ebf-1d18-08df1984e106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z4tVz/WfMpz9xbOF0oI0y29SzPr/Ctcq0/x7xCxslxPXgip0ifHFo+BDu9+VMq0dg0aj2piWvZdjwvGnPS9D9R3sDxjX0F5XDVXQxQFJcKb/7ZlF7YlnRbT+mFtA9QnVdyRgs410Zhj+MMtFi7HouIG6WmtKaYJbP59v1Clsb51WF7Dh665Bt6Obz5NpiWC909/Wk/EO8W93ATw0zwAak46W+Khg8AR4xKce9yx1q4dCzyw1qV3d/KaWfiENYWkaalkWpyJlvCd9M1v4yfxibidAuFGXORAPMPcNcc/j+htGTV+ABSJ8d9SzfCe311zDyV0kfspAk9Gym1uyxr0u9zfxsW7kivKtsBSBxDuDdYPidinbZpN6QZMBxOnhhoYk3ATRPbVC3/ec/DpBtcKKHpNBb1gfm16uoOSsbaCf5q6nHdKgCAoIpkzfuiYYJA2CGLJnLHZFmhjV8WQF5PADsNTP/OVrbFa/RLnDSvy0rjAcLV4AmbW1ThyJBtJjtktS3w1b30Bi07qGjl6T+frzfejb4cBjrfBA2XNnnfDXCDl85IDBw0y5helRw7JoTyCrGSmQSDn2788XoRrOGGXHgwxz1ZD2N0xLpVoTGb4S8a0mVu+6YeJz5qREow/o3mzW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEFOQitvMnRybmlEdld0RDd6S3ZodHF4RjNQTTJ2MHRuMUZyNEx4R2V4ZDhk?=
 =?utf-8?B?T3QwNDJ2OFVUcmtBMzRCVkhNcHo2NGdRN2Q2cUJJRm44b2RDbERpVlpKdjl1?=
 =?utf-8?B?S2x1UHRaaWtoVE4zV0NYSXNGQ2tmWENrYWE5STJDNnRyQ2d1eENWZDNGYnI0?=
 =?utf-8?B?aWxEdEJXSDdqcURSSHRyeS8rSytnaUROZUI1QmVWcDI3ZTV3TElmazdqZzFh?=
 =?utf-8?B?elVjbzV4OG5VdjdITW0wMGNpK3JzdVZ0NTlwYmo2S0xRbFVud3NmL1dmN3hv?=
 =?utf-8?B?amg2dG1PVjhuN2tyM0huQzVka0wwaEpiNzRKYktJbEMvcHk2YVd4ekNRMEpC?=
 =?utf-8?B?a3ZVZE5LbVdZZ21EOXZta0hBWmo1eXZwckh3M05LQ2Vta1R3Ty9ZczZ6Yllo?=
 =?utf-8?B?VkMzQXVacWRlTnBNcDN2aFhCTDdTQzU3b0xWRGdRVm85QllkRkxvelJ0N3FQ?=
 =?utf-8?B?azdEOTZteldLdDEwem03UXZJNERXRnAzNUFJRms0d0RkV2J3QmxPNUU1SUQ0?=
 =?utf-8?B?eEZHc0drN2xpMERTbCs4YnI5aUhtaDdHODdHc2RnREYyRUIvQ0Qvc1pHZHp0?=
 =?utf-8?B?VzQ5RlRGN1pMRHJqN09BZ3kyLzlmRWF4N1ZER1FlQjltNi9nNXMwT0g2cTI3?=
 =?utf-8?B?S2NvdDUxMlkxOUpuOG45Q0NPcFhZSjFNSFlXd3BGYWxBcnhvSXJZMm1pS2do?=
 =?utf-8?B?b3VvaTZDRHVjdzBRSDg1N0RMM3RMSzZ3RmtVWlk5NURVYWZDTkY0Zlc1MDg0?=
 =?utf-8?B?d0RqR2JNNUprMVUyVmtYeFg0S2NLOUEvcUxkcHBCZHJQOWVudkZFUXZFMEtw?=
 =?utf-8?B?Y0pKdlZZUk1YdFFyWitiMTl0bGxHVUREaTJTWGtWdTlmdTc5b1IzcTM0d0kv?=
 =?utf-8?B?YUlQQ1lMT2xlTk5QYm5oWHpLM2lxalVLY2kwN0MwQi92Y1hTajl0YkVtMmhB?=
 =?utf-8?B?VHQ1dmwya1VTOFVrbmQrOFhWRlcxVk1jK1JBSG9KUzlVSXV6eGx1MEM1RlU2?=
 =?utf-8?B?ekVybHJtR0FyUk12bUhrT2t6L2dVVnlWRWRJVlYvN2ZQSk1DTU45bTVEeWM5?=
 =?utf-8?B?VE1wandVeFZ1anN3SnAycm54T0Z4Q2xoazhMWk92ZDlyUFowb3RUdnZEbWw4?=
 =?utf-8?B?c1l4M0VmRHZRdVZyQWlUZUtybnZWQk1zTVh6N05YdEdqY2prRHhhcUFCVkMy?=
 =?utf-8?B?L3BKcXpiQnR2andSZkNhdmVjZld5cEdWMmJ2cmRHdmJ5dmZEM0FnSmNsMTVY?=
 =?utf-8?B?SXJWSUZrYU4wU1hUaVdlZXl3OTQ2SzVUSGVOVUZnUUk3NitJVXd6UmRPWTlU?=
 =?utf-8?B?aDlJZFhUZys2TWQwVVVoRHljaVZjRkdrbEM2K1dvN2l0VHhzTmNMSUxyRnFn?=
 =?utf-8?B?UGwwTm53OW9KRHZNK2syMHlnQnFzNXJvbVlPQ1hYTDR2Mi82OGJxYm9paU9K?=
 =?utf-8?B?TTRTMzZ3L0lUNEUvV0RKb3k3YVhNQmhPcFNna01uVlZra0dyQ1oyMlloZzRh?=
 =?utf-8?B?cGVlektjamhLWHRmblR2QW1NQktCR0t2eE10ZUcxSnBtc2crcWpSZWJUUll0?=
 =?utf-8?B?ejA3REsya0xFOTQ4T3l6V2dCZ3VCYld6UEk5aDJkN0hPOU5iT3JOR1gra2lJ?=
 =?utf-8?B?Q0c3azhqS29qWmU2ZEVhcmpFdlJvNXFjeEd0cDBjSW45TWRNQ20zTHBJTlQ3?=
 =?utf-8?B?ZUpDdTg5SzNadWk3eXJqVFFRTlJDWUdHRklKNE1LVGZjeGg5dFhTNllLVjFU?=
 =?utf-8?B?Q2JxdmVtOEdyVUVSYXNEcGpYOHRaUDBvVDNMYWdMNG5LV0xmb1BvZE9CQUNX?=
 =?utf-8?B?QTF6d1JFYzkxc2lqNVN6L002RTU4YnZYUEtUSThyQjB0Z29JK1IzMkRZeGw5?=
 =?utf-8?B?OHBSVWlvTEpKMDdDVFJqTFpIVVhvMmJvb1c3VjMwYTEyK2w4NVd5dmZ1Zllw?=
 =?utf-8?B?em5qMVVTNEFKNVVla3V1dC9IY3FyNWF1L2d0dklUSXJnbFc1MFE0WnpIYTI5?=
 =?utf-8?B?YjhlMW5rbHRvYnd6RzNxSXVnaTJ0eFlwQjdKVlUrTEg3MzUxQlRxdm44QmdX?=
 =?utf-8?B?bEpxcXdZUS9lMUxFNFdsVHFoQ3QxaXhlSi9ncUxlWGJVNDlNL0VDeXN3UjF6?=
 =?utf-8?B?OFRWYUZlT0Rmd0NzSzU5dWZZUURYbzg3aTQ2WmtMdEcvT2xxSVVIYUlJYStT?=
 =?utf-8?B?UTJudnQ4QzZkOXo0bTdwbnZsc0pFZU8yaFYrdksyZTVtZ3phV3hGTEREekwy?=
 =?utf-8?B?dlFTRkNkcy9XWVI3c21oRTRQRG9Bd3haVTZOZUhVaXJDQjAxeXdhSVRUSld2?=
 =?utf-8?Q?SI6M+4TpFSW4gPdrNG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ba3c5f-8df5-4ebf-1d18-08df1984e106
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:11:01.7785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tRsuUaob3AP/U/8vOKaFFZ6Tjt+gfRj9HwSxs/fWxaGTRyh+vlNiY3OhJaGOd0V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
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


On 2026-09-23 11:02, Welton, Benjamin wrote:
> AMD General
>
> For some background on my end, is this the porting over of the existing profiler work to KGD?
[JZ] Yes, for profiler-PMC only. One of the main changes is  from kfd 
device based PMC to render-node based PMC.
>
> Ben
>
> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Wednesday, September 23, 2026 7:02 AM
> To: amd-gfx@lists.freedesktop.org; Welton, Benjamin <Benjamin.Welton@amd.com>
> Subject: Re: [RFC 00/10] amdgpu: implement Performance Monitor Counter support
>
> Hi Ben,
>
> Please review these PMC patches for unified Kernel interface.
>
> Thanks and Best Regards!
>
> James Zhu
>
> On 2026-09-22 05:34, Zhu Lingshan wrote:
>> This series implements PMC support for amdgpu. Including two parts:
>> 1) PMC Enablement
>> 2) Profiler Reservation
>>
>> The user space should take the reservation, then set PMC.
>>
>> This series depends on and used new helper introduced in another
>> series:
>> https://lists.freedesktop.org/archives/amd-gfx/2026-August/151692.html
>>
>> Please help Review
>>
>> Thanks!
>>
>> Zhu Lingshan (10):
>>     drm/amdgpu: implement PMC ioctl framework
>>     drm/amdgpu: add device-wide PMC config
>>     drm/amdgpu: introduce PMC ioctl handler
>>     drm/amdgpu: implement reservation mechanism for PMC
>>     drm/amdgpu: set device-wide PMC enablement indicator
>>     drm/amdgpu: GFX11: set mqd->perfcount from mqd_prop
>>     drm/amdgpu: GFX12: set mqd->perfcount from mqd_prop
>>     drm/amdgpu: GFX12.1: set mqd->perfcount from mqd_prop
>>     drm/amdgpu: implement device PMC handler
>>     drm/amdgpu: set userq perf state before publish it
>>
>>    drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   8 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   3 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h      |   6 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 166 +++++++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  38 +++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    |  95 ++++++++++-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   2 +
>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |  11 ++
>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       |  11 ++
>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       |  11 ++
>>    include/uapi/drm/amdgpu_drm.h                |  36 ++++
>>    13 files changed, 390 insertions(+), 3 deletions(-)
>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>>
