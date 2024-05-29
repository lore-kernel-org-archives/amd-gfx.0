Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B64C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 06:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4FF1132A9;
	Wed, 29 May 2024 06:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JhTXEpuR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07E61132A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNYkUsKTE/a7Vfg0wAj48knL39Hxtd1t3ovtXrNN2bcjcOStMaOmVXfPR6YbKx+Uf7Xugwo1TAb1bRHhYFklnVRxKkGyxZ35kERP3Auv3CNJfcsoEb6Bu+78ZX2WuwQsmaZtPzIp9lkB8o/KTXp++KABXR92xA4+lQ0nIIu5ArUgPjiMom47ycT2X33HxZipBFrCDnOs4yHsUKlxX4MmtKTp5YZVCM2tqYHT8wNPO5bFQv+IN4I4hyUMzC8SpwRCDK4WY+DI2gq4R2Fj7nlYDIA7wk+kk+1Gne6bzWf+phaJcn3LSA0vP1L+oUMJyeFyzZFH+8vK3+n472gr3ChSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XHZkYfJdYcTkRNYbULirTjYynCtZ5kwehLtxsFCpw4=;
 b=meqrG+h+ov1A32bAnXWGuSTTd7b4Cln7FSHn6j/330dKAXHldKaDjH4XU41keIgy8xzxU/WJb0l0hGeM0OIP+S5icfmUr09tCTGw9WSc2lYRuFuf3zW2lK5GPpwZck39yG2NDdL4nWj+FniP4lAw0CpOvhWxxPE4MFOpNXd9w05F95YV6D5fZg0xnHEzHd34+wdduXoDGnsakzj+udeuuHOY0UyrCNY5H7jRHKDyp2JP10Eqhz/SXlUrPJH/03bzDjz9GlrqgAti1/t0WECkazmN8FRKDyGB0o6oZk9tHWILO+xlNyCWlFSlDzAw90H3TM6t9hLjHqpIPBTn2rPnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XHZkYfJdYcTkRNYbULirTjYynCtZ5kwehLtxsFCpw4=;
 b=JhTXEpuR7omvA7fpKQX2ISSQxxF+FCJ967WD2wdf3HynBnmYU4kLxfnp4FQ54OSxOTgrPlL8P6BpurZgsIXLqnF0MHTRN6olxtEF850uG6FLdlAFEpAYQi9Kt1ZgYELG3lKPz/v8+/psqRC4O6nmNk3EQCSCAtHci3S5bXlj/TA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 06:42:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 06:42:01 +0000
Message-ID: <1a705e40-8be0-4bc1-b5df-60722682e2e4@amd.com>
Date: Wed, 29 May 2024 08:41:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] drm/amdgpu/kfd: remove is_hws_hang and
 is_resetting
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-5-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240528172340.34517-5-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5cbf5b-f619-46ff-ec24-08dc7faa71f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bERESmFLR2Z0NGt1OEVVaUFMVUVJNUFqRzlXRDBpZldRT2lTYUlXVDhaWTR6?=
 =?utf-8?B?WnVOcEwzUjFQeDVia0ZUZTFRdHRQRzEzMVdXdzhrdnVqVDhhdm9iamdXMmdX?=
 =?utf-8?B?aVUrWlg4NW1kUVdKbE1PVzNRWml3QnBPMEZNY2NPQ3ErbllIUWVRSXc2aEpz?=
 =?utf-8?B?dGNDdjFYL0cyaTVKMS9BRzQrTlZOZGgyQmZiaU5vWll6Y0lZRkVXU0JqcFJ2?=
 =?utf-8?B?ZWk5RmhvcDFkYmdKMmR5OGRpbWxZSjN6NEtHYjJSME1KVm1mK1hhc1pKKzdB?=
 =?utf-8?B?Y2k4eDFCakhza2Z4U1VCM0M1a0dPQXV2bUZvaWF3ZUdINXVoSE1RTVNrbmZ2?=
 =?utf-8?B?YVhCblJtWlFUaDZJaDdiTDkwLzVCMmZUMU9EU2JZbklOQVp6OXJ0M1Nmbkgy?=
 =?utf-8?B?SWpHWmE3OUhwWFRQdFgzWld4YWsxblZtMjNFc0JmSElGcEF3R1cxbGRGWlEr?=
 =?utf-8?B?bGFmSU9QL0lkRVFPQ2ZPbDlkdzZXY3ZJaWdXelJ0Y0hRZjAyaFFwYUlmWHh1?=
 =?utf-8?B?eXpmVnZwb0lnZ3VDaE14UjdJVkFteXNhbng2NnBHc1lzQUZ5QVdyNG9XM0ND?=
 =?utf-8?B?bDVTcGZoV2JPbjF5elJtVGVNbjcvcGIzQXRESkVxMnNSRVNkVFFCMlZGaVRy?=
 =?utf-8?B?OFlqNHBmajNpMkZ3NjVnMXA4V1lZNXQ1ZnkwOG9ZdktxMEJNV0tySCtuaUJX?=
 =?utf-8?B?akEyKytDTElQOW84WVlPUmllLzMzUlJKV05CL0tHS0puT0hCRktqV21lWThx?=
 =?utf-8?B?K05COWh0ZmlKenJaRTU1MWppRHQrZEY5MVQ2b012emRSSU12UFhqckVncVJB?=
 =?utf-8?B?cSsxWHlweHdPMmRjamhOdXRSSzZRV1RubXJINy94ZlM4QW9NUWpTNzh3QTVy?=
 =?utf-8?B?MXY2dlV3bmpZcENsQk5FelF2UnNMQUZZZGRVSC9lM1djTUlzck5YK0RUb3dt?=
 =?utf-8?B?dFB2dXhudnd2M2haUjkwQjRvRHlnYTZlUFhWTG1QYUVNWlJiQ2JFT29CQ3ov?=
 =?utf-8?B?dXJJVGVsMDNQZnlRRXkxRmNuSTRES25PT0k1eXprYi9pM2hGZnhySTRNbVlh?=
 =?utf-8?B?YlBxUjM2OE1pWU5iRnFXU0xwTCtzaHQraVh2QkQ4MUFueUgvYWNxeklNMHlH?=
 =?utf-8?B?aTlncXBYRUR6K0x6aW9QRnZNWFlCWmFucGVxNzRCNlhhWkVOeHByNGFTR2hw?=
 =?utf-8?B?ZGNuY1NORXNJR1Ivc2VrajBwUUkyUGUxWHk0UGxkRzZtSnkxV24vRWJhQjha?=
 =?utf-8?B?S1FQcDhZQWNqQ3M3bStGb1ZUMU95YkUvOVo1N0NsbGl0cnlYY0E1b0o0ZUpV?=
 =?utf-8?B?SFArUFN0bnd2SEVrY3F6ZmIrQTdLbXcxSVBtdGNiVnI4SmNSN0wwZSt3WjJu?=
 =?utf-8?B?VWlYRldXaWEzeDAxYkNSNEZoNkN2a2t4a1VNbThSRzR0ellnZEpRMUplQmFV?=
 =?utf-8?B?Zng5dHFUVDlmRTA1akFIVmZHVzZMMXN5MHNGQXE4aHB6U2JOanpLRUxpZHpY?=
 =?utf-8?B?UEhZK2ZlS2pBbzBFUVhyM0hNeCtvVDR0QWlKeHNTcTdSWmpUdk9pRWF0WGxT?=
 =?utf-8?B?OGJ3QWJoK1FlZXozV1czd2FuZEttemJGVHl0TTVDZThCbFJjODhaTFhRWGVo?=
 =?utf-8?B?M2pOVUFaNWxxWkg3RXRlUHRUWXJ2ZS83N2VYdHI2Y3pKWXBLWForNXhlK25Y?=
 =?utf-8?B?dWZFSjlBeUJ0eGF5c25xZms0bGZvelRCU2FJQVRORXdabDZXeGVUbDVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG1qaVZnemV6NEhYZjVmV3lKb0VkbWR6RDJLY1hLNnc0ZEdzSUwxb0RTSE5V?=
 =?utf-8?B?UmJYcU1ZYjhLM0ozVmJENXEyZTREcCtxaUNrSnF6SkM0RmxnbG5Xc1M3MlBx?=
 =?utf-8?B?YWZVUUxPbzJ5VTMrbk4vVUNSYlpNdWZNVThLU3FHS1FNNDhmTmtaSE5TSERT?=
 =?utf-8?B?ZGNLeFFFTzZwSk96RlVQcjVHbEg2eWRuZDI0Q2RyTVIrUmxXT0ZrVjdKMGZI?=
 =?utf-8?B?d0Y1cEE0ekZPTjlPdWJXS1JKOWxTUVJkcW0yL0lhWU1FVHVrb21BZE1sdzRI?=
 =?utf-8?B?Vk9XYWVTTnh2Und2YjNiVXRLL3BLeEpFT1lCc1hOcTlIUjZSNUxMdTh2cWc2?=
 =?utf-8?B?cjc5NzdDWStBbHNNV1FkMjdNRmp0VThtdjc4OG9BSWRBUEoyK3ZrWkNsZ2Fs?=
 =?utf-8?B?WVpSVHFYNmRiMHpWYW9PT2JvWVZzWTJnVUo1TXBsNnh3a0NWdEdJbDh4Zk4x?=
 =?utf-8?B?SkprM0xkRDE2VzBaOE1OOGVkODBKOCtWOTFTY3dERGxVMU05QUYycUFsTVFD?=
 =?utf-8?B?Tmtxd3V3MU5WZ3ZSQzJNdTg0c3pEYkZud1VzUTNuSkphclN6VzNDVDR3WUlH?=
 =?utf-8?B?T3FYMnZNT09tc3EyTEdqYk1FMUxkT0QrUjlSZ2xXOTV5TEVBOTZ4S1pnWGxP?=
 =?utf-8?B?WnFVZThlY0lMbUNiQTFMZzVUa2VEK3NESERUNFdQNDlBb0Fka1R3d2o2YXpV?=
 =?utf-8?B?by8vQnpmZXdFTEpVYksyZC9PaHVGYjBuWXdDdzYwb09KOGpTYzdaUUpBMXlh?=
 =?utf-8?B?MldCNzJOVU1xSjVoUkh3OUdwMFNMU21BYVl0NzA5bWRMWVhPNExVbjI2enUr?=
 =?utf-8?B?QWZvbW91T1NmL3EraGl6UTJ3UDI2S3V6d1NhUnV5c1dMa0dDUGVsQ2Z4Zm9S?=
 =?utf-8?B?T2EzRC9WN01rN2xGRUlvL1NZUENrNFdMK1Raa01kRFpDd2ZtL3kxbGVWMUpU?=
 =?utf-8?B?VnhpenVDZ0I1QXVKYjl2WERHRHFacS9mQ2Q0amVqNi9BeWdCNzBSaXJ3bFB3?=
 =?utf-8?B?dEhQNzlLdjR5bUZHRENiMzJCdkpUeEhrVnA1SUxlNUI5aGxPcG9PMWhtam9l?=
 =?utf-8?B?MzY2NkpRS01SR05JK2VYUUJkMXRyTkc4cFhzQjhnUGJNR0wrTDJ0Z0ExelNB?=
 =?utf-8?B?aWtMMUpqUXdUTU5UbjBWYjBGWVhINmxteXNNalNNSXF5K0dmNi9HNnRZcXE2?=
 =?utf-8?B?UU82eFVERzVOSjJkRmQzTVUySWlOc0tUR1hiY3R0WW04TW9hK1ZrOWhleGZz?=
 =?utf-8?B?aXZIb0VsYlN2blJQcERyTzEwRmVkU3dvYUFYb3dGakhwa01qSGtxaTI4SzY3?=
 =?utf-8?B?U3RYd3FrQzZLcGhjL0pIK2tDZ1A4Wi9BTkhJbDhjWnN1QnRGWjREaW5KVTVW?=
 =?utf-8?B?emh5NWlkM1NVS0lKRlQ1aHFVSnAzQVVXeEJBdnFjNU5OYk5TSmJyNmdJVWcr?=
 =?utf-8?B?ZEJ2UUdad21jRFR6aE5rTklwWElkM0RvT0FwYnRISjJjVGFUc29NZktjRk5E?=
 =?utf-8?B?ZnJ5ZVViWDJBS1NxMEkvRGVrNmNRcGFZRmVNczBVcWFMcUgvUUp6Sk1MdEV0?=
 =?utf-8?B?ZGF3NktYcHVocXhpNVRhYTFQamw5UVZXTjNFRUliVXR3SlRHdTB2L0hUQUJo?=
 =?utf-8?B?anloVE1PMTJpZEJ0SVV4b09HNnVvdDgwUzhBbE52Z3hmaFRhcjJldlh2YjY5?=
 =?utf-8?B?Q1VGR2pDa0ZSOWs1SU1Ka3Q1RWtoMGdwLzJhYzg5WmkxVVlOQnFtZjBZZGNk?=
 =?utf-8?B?dldmc01pQW83ZFVsWHMybEN0cWdSbFQxOXpPM0hxT1dXa3FuellxODZuN1FP?=
 =?utf-8?B?UEpJWWpoa0pFYnJvNUx3UjF6V3VWeDlDZXJIa0EvZ0Y0YThPalNlNHZVVFdQ?=
 =?utf-8?B?U1NMbHBnUVVZdmwyUnMrL3VJWTJhK0d3OTlNT0RKZDVic1pndGhXbnJmYU9B?=
 =?utf-8?B?WEhTYmNxMUlkNEw3YXNiOTUyZWhVRHk0NnV3c0xWZDIxSEhIeng1VkhzcTVH?=
 =?utf-8?B?d2lhY0NKOU5ObmxBR3AyaDRTS0J1ZXZXVGl2N0pXKzNZS2lSbWlSM2xFdS9j?=
 =?utf-8?B?Wk9FZWcxTFpVUnhwMTJVZGkwRk0xWWxxZGV2c2h5elFuVWxVSzczWEI1NnVl?=
 =?utf-8?Q?WWy8yLPcpmEiIYFvPeYpcdLsH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5cbf5b-f619-46ff-ec24-08dc7faa71f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:42:01.5632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYH8+af+3taYdg/cW9RjICqRWcKxIJAEPMdvUQ1R85VGBCFuR3TZBKSvU/GZ9dBh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

Am 28.05.24 um 19:23 schrieb Yunxiang Li:
> is_hws_hang and is_resetting serves pretty much the same purpose and
> they all duplicates the work of the reset_domain lock, just check that
> directly instead. This also eliminate a few bugs listed below and get
> rid of dqm->ops.pre_reset.
>
> kfd_hws_hang did not need to avoid scheduling another reset. If the
> on-going reset decided to skip GPU reset we have a bad time, otherwise
> the extra reset will get cancelled anyway.
>
> remove_queue_mes forgot to check is_resetting flag compared to the
> pre-MES path unmap_queue_cpsch, so it did not block hw access during
> reset correctly.

Sounds like the correct approach to me as well, but Felix needs to take 
a look at this.

Christian.

>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 -
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++++-----------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 11 ++-
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 +-
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  4 +-
>   7 files changed, 45 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index fba9b9a258a5..3e0f46d60de5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -935,7 +935,6 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>   	for (i = 0; i < kfd->num_nodes; i++) {
>   		node = kfd->nodes[i];
>   		kfd_smi_event_update_gpu_reset(node, false);
> -		node->dqm->ops.pre_reset(node->dqm);
>   	}
>   
>   	kgd2kfd_suspend(kfd, false);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4721b2fccd06..3a2dc31279a4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -35,6 +35,7 @@
>   #include "cik_regs.h"
>   #include "kfd_kernel_queue.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_reset.h"
>   #include "mes_api_def.h"
>   #include "kfd_debug.h"
>   
> @@ -155,14 +156,7 @@ static void kfd_hws_hang(struct device_queue_manager *dqm)
>   	/*
>   	 * Issue a GPU reset if HWS is unresponsive
>   	 */
> -	dqm->is_hws_hang = true;
> -
> -	/* It's possible we're detecting a HWS hang in the
> -	 * middle of a GPU reset. No need to schedule another
> -	 * reset in this case.
> -	 */
> -	if (!dqm->is_resetting)
> -		schedule_work(&dqm->hw_exception_work);
> +	schedule_work(&dqm->hw_exception_work);
>   }
>   
>   static int convert_to_mes_queue_type(int queue_type)
> @@ -194,7 +188,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	int r, queue_type;
>   	uint64_t wptr_addr_off;
>   
> -	if (dqm->is_hws_hang)
> +	if (!down_read_trylock(&adev->reset_domain->sem))
>   		return -EIO;
>   
>   	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> @@ -245,6 +239,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	amdgpu_mes_lock(&adev->mes);
>   	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>   	amdgpu_mes_unlock(&adev->mes);
> +	up_read(&adev->reset_domain->sem);
>   	if (r) {
>   		dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=0x%x\n",
>   			q->properties.doorbell_off);
> @@ -262,7 +257,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	int r;
>   	struct mes_remove_queue_input queue_input;
>   
> -	if (dqm->is_hws_hang)
> +	if (!down_read_trylock(&adev->reset_domain->sem))
>   		return -EIO;
>   
>   	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> @@ -272,6 +267,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	amdgpu_mes_lock(&adev->mes);
>   	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>   	amdgpu_mes_unlock(&adev->mes);
> +	up_read(&adev->reset_domain->sem);
>   
>   	if (r) {
>   		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
> @@ -1468,20 +1464,13 @@ static int stop_nocpsch(struct device_queue_manager *dqm)
>   	}
>   
>   	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
> -		pm_uninit(&dqm->packet_mgr, false);
> +		pm_uninit(&dqm->packet_mgr);
>   	dqm->sched_running = false;
>   	dqm_unlock(dqm);
>   
>   	return 0;
>   }
>   
> -static void pre_reset(struct device_queue_manager *dqm)
> -{
> -	dqm_lock(dqm);
> -	dqm->is_resetting = true;
> -	dqm_unlock(dqm);
> -}
> -
>   static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   				struct queue *q, const uint32_t *restore_sdma_id)
>   {
> @@ -1669,8 +1658,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   	init_interrupts(dqm);
>   
>   	/* clear hang status when driver try to start the hw scheduler */
> -	dqm->is_hws_hang = false;
> -	dqm->is_resetting = false;
>   	dqm->sched_running = true;
>   
>   	if (!dqm->dev->kfd->shared_resources.enable_mes)
> @@ -1700,7 +1687,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   fail_allocate_vidmem:
>   fail_set_sched_resources:
>   	if (!dqm->dev->kfd->shared_resources.enable_mes)
> -		pm_uninit(&dqm->packet_mgr, false);
> +		pm_uninit(&dqm->packet_mgr);
>   fail_packet_manager_init:
>   	dqm_unlock(dqm);
>   	return retval;
> @@ -1708,22 +1695,17 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   
>   static int stop_cpsch(struct device_queue_manager *dqm)
>   {
> -	bool hanging;
> -
>   	dqm_lock(dqm);
>   	if (!dqm->sched_running) {
>   		dqm_unlock(dqm);
>   		return 0;
>   	}
>   
> -	if (!dqm->is_hws_hang) {
> -		if (!dqm->dev->kfd->shared_resources.enable_mes)
> -			unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
> -		else
> -			remove_all_queues_mes(dqm);
> -	}
> +	if (!dqm->dev->kfd->shared_resources.enable_mes)
> +		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
> +	else
> +		remove_all_queues_mes(dqm);
>   
> -	hanging = dqm->is_hws_hang || dqm->is_resetting;
>   	dqm->sched_running = false;
>   
>   	if (!dqm->dev->kfd->shared_resources.enable_mes)
> @@ -1731,7 +1713,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>   
>   	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
>   	if (!dqm->dev->kfd->shared_resources.enable_mes)
> -		pm_uninit(&dqm->packet_mgr, hanging);
> +		pm_uninit(&dqm->packet_mgr);
>   	dqm_unlock(dqm);
>   
>   	return 0;
> @@ -1957,24 +1939,24 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   {
>   	struct device *dev = dqm->dev->adev->dev;
>   	struct mqd_manager *mqd_mgr;
> -	int retval = 0;
> +	int retval;
>   
>   	if (!dqm->sched_running)
>   		return 0;
> -	if (dqm->is_hws_hang || dqm->is_resetting)
> -		return -EIO;
>   	if (!dqm->active_runlist)
> -		return retval;
> +		return 0;
> +	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
> +		return -EIO;
>   
>   	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
>   		retval = pm_update_grace_period(&dqm->packet_mgr, grace_period);
>   		if (retval)
> -			return retval;
> +			goto out;
>   	}
>   
>   	retval = pm_send_unmap_queue(&dqm->packet_mgr, filter, filter_param, reset);
>   	if (retval)
> -		return retval;
> +		goto out;
>   
>   	*dqm->fence_addr = KFD_FENCE_INIT;
>   	pm_send_query_status(&dqm->packet_mgr, dqm->fence_gpu_addr,
> @@ -1985,7 +1967,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	if (retval) {
>   		dev_err(dev, "The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
>   		kfd_hws_hang(dqm);
> -		return retval;
> +		goto out;
>   	}
>   
>   	/* In the current MEC firmware implementation, if compute queue
> @@ -2001,7 +1983,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   		while (halt_if_hws_hang)
>   			schedule();
>   		kfd_hws_hang(dqm);
> -		return -ETIME;
> +		retval = -ETIME;
> +		goto out;
>   	}
>   
>   	/* We need to reset the grace period value for this device */
> @@ -2014,6 +1997,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	pm_release_ib(&dqm->packet_mgr);
>   	dqm->active_runlist = false;
>   
> +out:
> +	up_read(&dqm->dev->adev->reset_domain->sem);
>   	return retval;
>   }
>   
> @@ -2040,13 +2025,13 @@ static int execute_queues_cpsch(struct device_queue_manager *dqm,
>   {
>   	int retval;
>   
> -	if (dqm->is_hws_hang)
> +	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))
>   		return -EIO;
>   	retval = unmap_queues_cpsch(dqm, filter, filter_param, grace_period, false);
> -	if (retval)
> -		return retval;
> -
> -	return map_queues_cpsch(dqm);
> +	if (!retval)
> +		retval = map_queues_cpsch(dqm);
> +	up_read(&dqm->dev->adev->reset_domain->sem);
> +	return retval;
>   }
>   
>   static int wait_on_destroy_queue(struct device_queue_manager *dqm,
> @@ -2427,10 +2412,12 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   	if (!dqm->dev->kfd->shared_resources.enable_mes)
>   		retval = execute_queues_cpsch(dqm, filter, 0, USE_DEFAULT_GRACE_PERIOD);
>   
> -	if ((!dqm->is_hws_hang) && (retval || qpd->reset_wavefronts)) {
> +	if ((retval || qpd->reset_wavefronts) &&
> +	    down_read_trylock(&dqm->dev->adev->reset_domain->sem)) {
>   		pr_warn("Resetting wave fronts (cpsch) on dev %p\n", dqm->dev);
>   		dbgdev_wave_reset_wavefronts(dqm->dev, qpd->pqm->process);
>   		qpd->reset_wavefronts = false;
> +		up_read(&dqm->dev->adev->reset_domain->sem);
>   	}
>   
>   	/* Lastly, free mqd resources.
> @@ -2537,7 +2524,6 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   		dqm->ops.initialize = initialize_cpsch;
>   		dqm->ops.start = start_cpsch;
>   		dqm->ops.stop = stop_cpsch;
> -		dqm->ops.pre_reset = pre_reset;
>   		dqm->ops.destroy_queue = destroy_queue_cpsch;
>   		dqm->ops.update_queue = update_queue;
>   		dqm->ops.register_process = register_process;
> @@ -2558,7 +2544,6 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   		/* initialize dqm for no cp scheduling */
>   		dqm->ops.start = start_nocpsch;
>   		dqm->ops.stop = stop_nocpsch;
> -		dqm->ops.pre_reset = pre_reset;
>   		dqm->ops.create_queue = create_queue_nocpsch;
>   		dqm->ops.destroy_queue = destroy_queue_nocpsch;
>   		dqm->ops.update_queue = update_queue;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index fcc0ee67f544..3b9b8eabaacc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -152,7 +152,6 @@ struct device_queue_manager_ops {
>   	int	(*initialize)(struct device_queue_manager *dqm);
>   	int	(*start)(struct device_queue_manager *dqm);
>   	int	(*stop)(struct device_queue_manager *dqm);
> -	void	(*pre_reset)(struct device_queue_manager *dqm);
>   	void	(*uninitialize)(struct device_queue_manager *dqm);
>   	int	(*create_kernel_queue)(struct device_queue_manager *dqm,
>   					struct kernel_queue *kq,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 32c926986dbb..3ea75a9d86ec 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -32,6 +32,7 @@
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_pm4_headers.h"
>   #include "kfd_pm4_opcodes.h"
> +#include "amdgpu_reset.h"
>   
>   #define PM4_COUNT_ZERO (((1 << 15) - 1) << 16)
>   
> @@ -196,15 +197,17 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>   }
>   
>   /* Uninitialize a kernel queue and free all its memory usages. */
> -static void kq_uninitialize(struct kernel_queue *kq, bool hanging)
> +static void kq_uninitialize(struct kernel_queue *kq)
>   {
> -	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && !hanging)
> +	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && down_read_trylock(&kq->dev->adev->reset_domain->sem)) {
>   		kq->mqd_mgr->destroy_mqd(kq->mqd_mgr,
>   					kq->queue->mqd,
>   					KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
>   					KFD_UNMAP_LATENCY_MS,
>   					kq->queue->pipe,
>   					kq->queue->queue);
> +		up_read(&kq->dev->adev->reset_domain->sem);
> +	}
>   	else if (kq->queue->properties.type == KFD_QUEUE_TYPE_DIQ)
>   		kfd_gtt_sa_free(kq->dev, kq->fence_mem_obj);
>   
> @@ -344,9 +347,9 @@ struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
>   	return NULL;
>   }
>   
> -void kernel_queue_uninit(struct kernel_queue *kq, bool hanging)
> +void kernel_queue_uninit(struct kernel_queue *kq)
>   {
> -	kq_uninitialize(kq, hanging);
> +	kq_uninitialize(kq);
>   	kfree(kq);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 7332ad94eab8..a05d5c1097a8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -263,10 +263,10 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
>   	return 0;
>   }
>   
> -void pm_uninit(struct packet_manager *pm, bool hanging)
> +void pm_uninit(struct packet_manager *pm)
>   {
>   	mutex_destroy(&pm->lock);
> -	kernel_queue_uninit(pm->priv_queue, hanging);
> +	kernel_queue_uninit(pm->priv_queue);
>   	pm->priv_queue = NULL;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index c51e908f6f19..2b3ec92981e8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1301,7 +1301,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev);
>   void device_queue_manager_uninit(struct device_queue_manager *dqm);
>   struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
>   					enum kfd_queue_type type);
> -void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
> +void kernel_queue_uninit(struct kernel_queue *kq);
>   int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
>   
>   /* Process Queue Manager */
> @@ -1407,7 +1407,7 @@ extern const struct packet_manager_funcs kfd_v9_pm_funcs;
>   extern const struct packet_manager_funcs kfd_aldebaran_pm_funcs;
>   
>   int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm);
> -void pm_uninit(struct packet_manager *pm, bool hanging);
> +void pm_uninit(struct packet_manager *pm);
>   int pm_send_set_resources(struct packet_manager *pm,
>   				struct scheduling_resources *res);
>   int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 6bf79c435f2e..86ea610b16f3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -434,7 +434,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   err_create_queue:
>   	uninit_queue(q);
>   	if (kq)
> -		kernel_queue_uninit(kq, false);
> +		kernel_queue_uninit(kq);
>   	kfree(pqn);
>   err_allocate_pqn:
>   	/* check if queues list is empty unregister process from device */
> @@ -481,7 +481,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   		/* destroy kernel queue (DIQ) */
>   		dqm = pqn->kq->dev->dqm;
>   		dqm->ops.destroy_kernel_queue(dqm, pqn->kq, &pdd->qpd);
> -		kernel_queue_uninit(pqn->kq, false);
> +		kernel_queue_uninit(pqn->kq);
>   	}
>   
>   	if (pqn->q) {

