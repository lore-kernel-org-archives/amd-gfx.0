Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729BCCF6497
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A51E10E40C;
	Mon, 30 Sep 2024 12:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ay4kWsoC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D144610E40C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoLpUwoqDB57JEvQtbu+Nu51QVl/cMGb8cSWomlUa1G58noLzSoWtRNFVN2C4wz+wosLml5YNV1iC7xFYPJ4x84jL4aX8sQl5rVp0lHNDPlsf1a6XJfukHpb+4NqTrfnriPGC5GIstMlc7QJ4Qiu+tFchThgbsIfpf2ujZ9YtgOU9h+E7vR9doXUJ0crV6r4plsnae1+kqsog2x7DaReYdrfh0ReDgOxRk2MljXnGjmuAAS8kIFFpxXTrB/dJ1AqLhAQh/B95P/vHF14Afg6B9ONByN9bKLZ8dVyWS0ngXPys8Q4gLH20nFLc4HnL9Q//GFlL6lY0s+yomhxRhO4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCaAxfhaTNhLcq/L1YKHpz9Li5y3lvuIiZA5sDikSas=;
 b=AVoVytaX2XkTgfLXrE/TAINiXUbgWyKsl8CYbYAv02TqrSOYqKqWUHgZhE5PFVuoJmcg0XcgnbEPLxqd/KzeIAJaTxdpE8rE7U9XdRT1C161tYV7eE8HrWYbKVob7yTLitCuM9M6D9W0Hh4QOKCnzFzdY4HMmGbk/U9TDzb/5OPlaeKIjV0QYfHlVJrntFk2jZROMiBFqhbKPCQsiItEgnGrQ8BPEPqpP7AtJd4ly929TBrf90Pd0zqpIX9IoAwnSEoQ37p7Vu2Wr+ogVYPHrnMpbHgQlKzh88OCwyPZOWFeT/xwpKsthzkGg+nrYL7JTvOP6bSpTSSN8z+iC9bPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCaAxfhaTNhLcq/L1YKHpz9Li5y3lvuIiZA5sDikSas=;
 b=ay4kWsoC1KYwnkcMJjAVr0n8yZ0nNtN8TIB1tDRrA1U6r6JCRYa0T/tjwYD5wwUCUyxP0ODmhMRYryXiggYXSiwh9FDGnHV+jMOU72T3qO8wtIh/E32KxP235nz6VGS6xwMFCU1V4HdE3Ayu/WjgA4E3m1xMtgBEheQHvB+T2Es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 12:21:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 12:21:54 +0000
Message-ID: <8a66aa26-9e11-4b0d-99fd-c540f8ec2b8d@amd.com>
Date: Mon, 30 Sep 2024 14:21:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/09] drm/amdgpu: Add wait IOCTL timeline syncobj
 support
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
 <20240930115906.191060-3-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240930115906.191060-3-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: fba4d81a-85c9-4ecf-2f79-08dce14a788d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cC9vYjhTSmZJQjhSciszcWdsR3pCQVlzZ1hRRkJBbTYyMVFnZ1cxem5xWTdO?=
 =?utf-8?B?SXhLSGJrQ3krb0hNODR1UDNtTk9IOGZTd2l6QXRwT2F1ZnFlem9RMDVtYStP?=
 =?utf-8?B?QlVwRXpkSFBwR3NBVGwrNFBUYld2QVNRNmFtUkIvNlVYN0Z1UVFZdWM4TzRP?=
 =?utf-8?B?YnV0S2hLZHZnVHRHbE44OURTTU1rNDFRVEYwSitMN1VlaTdtc0ljWGZvMzF6?=
 =?utf-8?B?bzRDaEdVejVBR0dlQUhhajIvYkRmN3hWYWc2VW1MUVJiUVpWRmJZUHhod1Rw?=
 =?utf-8?B?dUkvV1gvVTRZc01HUXhxQms1VUNUdWRLM3paaDBJNHVFd0NxeW8zQ1JNS2JS?=
 =?utf-8?B?U0w2UUNBS0w1ZEdhL2UyTjhOclBsUUUrUVBEcDJoVU94VVY4U2s5ME43UnZC?=
 =?utf-8?B?UDZDbXh2MWVmckQwNjR5cllyRkpLOXZtcGdHSXlCczJNWUdSMndDVW96ZGFE?=
 =?utf-8?B?a3B6NzJPbDZPZkxsTVVMM3dEelJpYUp1YU95eHAxQkVTVmFUQzUyZ1FybjhL?=
 =?utf-8?B?MEpSYkNIeFBxRkJWcERZQTR4Nzh4OTEyclFHSXJ1U0RROU0xV083RlVSZHpk?=
 =?utf-8?B?b3NKRTVrdkJJaHhMOXJNemQ1T0VTblphSDFod0dOMWJaT1JSY05pYTlRQTFi?=
 =?utf-8?B?Y0Q0bDcyRWg0VXZ5WGF4NWh0Y1NkdEMzZEFiN1VJUWlLTy81d2VkL0w5bVQ4?=
 =?utf-8?B?dnR1a2NwUGo3OFRYK0Q2QTJlNFhacFh0dFc3QkRTdEoxYW1xRTRPdnJ1UE00?=
 =?utf-8?B?bTVJdlpvbTc3MFVpUldhZysyVWtybU05UU9VTXBnVnEzQyttRE5FaS9wam9U?=
 =?utf-8?B?RnQ2dm5seW9TUWM4T3RhZ1ZxbGVLaE5XLzdua1Z6R0RjdkVjNklVMytoZE1r?=
 =?utf-8?B?WXZ1UGYrZGVtMEY0bWpka1daeVR0YWhscytuSkt4aUZ1em1RZFh5cUZsZGFn?=
 =?utf-8?B?N0dYalJ0QU5ERjJlZXdJU1c1SFFDc3FGWFMvQnYxR0ZNczAvOVY2Ulk2SmdB?=
 =?utf-8?B?Z2U0ZEliZFYwODJkWXBrV3dmWkpLVUpkVjRmRXhpWUFkUk1VRkd5WnpHSnZY?=
 =?utf-8?B?WE9MKzhxU0ovV2VHT0FxZDdLVkpBZlV1dU15dFdMY1RJUkxUdjNIVmY5aUFk?=
 =?utf-8?B?blkvSUhjS2hlVzV6dzlQZ3hzWGVhL2xlNGJiRXNqQkdCRENQcEVYU2NGRVZu?=
 =?utf-8?B?YzF6bGF4bm01UnQzN1gwdWYvcHhjQmNaUG1qbUtWa2RRT3V3c2lxOHlnQlZD?=
 =?utf-8?B?V0FTNTdLcGw3bHdlaGVvWlVDWDQ4K3BleThvUTJuOWVZNkpkMktZclh3Y3hz?=
 =?utf-8?B?eEEwNHFkZDFuSW9VQmg2SlF5Y2hUMlZENkh3NzZKY1Y5ZVlrMWVXRjRsM3hk?=
 =?utf-8?B?L1paNVZ2a0NLdjBiTGFCQTBuZXpLOUhMZzhOSXFYcS9haDhKMDdNQzJzakEz?=
 =?utf-8?B?bkhDNGtXSW56bDVVYWNHUzlUdkZKdEJoN3ozVUJNMEZVWHo4K2txK0dqVUdR?=
 =?utf-8?B?cS9LSkZneldxU255aDNmanBtVU5HL1RTMEcxcllhOW1NQlZydXZBZ3ZPS05u?=
 =?utf-8?B?WS9TcHZWVDM2NFo2cTBEcG5NcUIzOG0zQTJLSFNwY3JBWGE4N21WTThWQU9l?=
 =?utf-8?B?L3I3VjlqYnlKdGxJc3VMVy9XTTFCOU5tZUFmQnFZTzdmU251ZmFXNzVYL2FE?=
 =?utf-8?B?ZncwTElXeGRTUkNHYVkrc08yanNZS1hEUC9xUDllL2ZFTWV0eCtPZVl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXlHUWNUSlhYSnpZZW96L3VzTE1heTZyZit4bHBOWFh3SjFkMnVPazllMitJ?=
 =?utf-8?B?ODNsclVidW1nN0t6R1lsb0xEaUtzT0p1a2xqdWZMd2lQQ2wwbFAyV1I2cWov?=
 =?utf-8?B?THpkd1VqZ3QvVkg3YURkR2ZZV2tFVWhjdHUxSXcybndzTU5Relk4YnlYMkhw?=
 =?utf-8?B?UnJKNzhzTDB2ei9iRFFia0lqYjRkNnZEb1YxeVRWNDFmUEEwd3J6a1M2a3dD?=
 =?utf-8?B?SjA3M0F6YjhWSHUyL29reVlOU0tjOEdNSTcyWFphYkd6UFV6eXc0Zy9nZzRm?=
 =?utf-8?B?eVliYUdxSkRnYnMxZFZ6bWJmQ2FtN2xHdHlvR2k2U1R5V1NyVS85cTlRM3N1?=
 =?utf-8?B?S0YybWdONzVITHJiNHJCOHlPNFhiZENGRm5haG95Znl4L0hXZTAwL21ya2lX?=
 =?utf-8?B?aVRjUDBjR3FKS2lENCtxclJ2cFU3cVczQjRFZEJTaXVDTFkwN2FVWkYwWHd4?=
 =?utf-8?B?LysrOTRENThZQnh1TWozMEhjTC9KRllRNUJJSExNQWdOWDBoekVpaURIWGFC?=
 =?utf-8?B?aFk4TW4rWFZSQVFEc0RzckwxbFdJVWhGaGM5dy9BaEkxN1F5T3lPZFhKY2Nz?=
 =?utf-8?B?dTA3SURXcXhzdm1JVkZHNnB3Wms3Ukt5RTY2YytkSFl5TGpaRVo3YTNud2d5?=
 =?utf-8?B?amZCbVc4RnZ3UXZyRVIrZFh2WmNrbUp2ODRSeTdlQXVRODhWc1pJTExyME9F?=
 =?utf-8?B?Q3dLWTE2Tnp5T0NaZEx1aFNCb3Q2cGVxVlBQOTlyWlpXaU1zRHVTb0pxejNO?=
 =?utf-8?B?b2Yrd1ZyRy83VitJeTlnUVN0cHptMEttMnpyMzR0MkhHWTM1TVZhY3R6L2V5?=
 =?utf-8?B?NFBNWGlpUWZSRXpIMTl0ZFM1QVdqUmNrYWNrODZQSFlleEozeGRHNWZ4bEth?=
 =?utf-8?B?cDh4VjluYi9TVjBrQ1NIS3FkOG5zdVFKWElQMXdJYUFiS3dyMjRnWFVYckhq?=
 =?utf-8?B?bklDTlJqclZRaGJIMjVVdDI5Qlp3dEdtNTJZMjlpa1RCTDlYTjNhZHAxYkp1?=
 =?utf-8?B?U2xrdEN5akNSUFRmMFN2TGlDZzVPRXdQVzVnS05OeVAydXYwY2pTQmRNdity?=
 =?utf-8?B?TGRob245eG1jd2NCc0dIdUhNaGtnNjVkbWdadTdvdmpoUjh6eGR0c0t0WDhK?=
 =?utf-8?B?UE4rZExRTnc1Z3RLQWYyRUFub3pheGpuZ1kwYmdrYmFabkVDQ2JIQUlyQ2dt?=
 =?utf-8?B?Z1RKQ2NpU3A1WlhPck9Hd21FdHlIcnpTU0tGdVkvTG9CbmorRnlCc1ZxV1JH?=
 =?utf-8?B?UmNiTTg5S2Yyazd0RWErVG9LRTlOa0gvWWxTUmhpMTVLd01wSTJjb0NWYjEz?=
 =?utf-8?B?bzZzUThyTnpuVTI1WEludkJ6bGZnUHhabytvTFB3Ly8xV1BUR1BQZzFnL0ZO?=
 =?utf-8?B?WkRrd2NINDJ3TXVlY05INHVJU2ltZysrdnE0NkJ4ZzVYZVRObGU0bzN6MzhX?=
 =?utf-8?B?SERtMEt5UGhjOFZNbjF3ZGtuOGd2MjNkdHJqQlpTUG4zQ1hpVld5TjVsRGtE?=
 =?utf-8?B?cm1PT0YwcHJTdTVncTlSV2MwWi8vR2VhL3BEa1BTYk1ON3V4ZUhSbkhJQnlj?=
 =?utf-8?B?bXRlTDlqVVlPUWMxUjZiUTJGS1hEZ3NFYXpuNFlaZk1kcWtpS1VhOGNBc2t4?=
 =?utf-8?B?dXN0Ym94UlhDZUNUdUR6SlI5dFM5N1B2aEFJMkFEd0VlVTBFdnFMc0ROQnVU?=
 =?utf-8?B?WjlBS1pibUl1cnhtam5aR2czd21OQ0pmMSs2a1NQWUtQUkJYK3VoczE0dmxU?=
 =?utf-8?B?cUVIRzJoNUFYVUYwTkxCRmsxbG1PUEp0a1h0Z01QNUJIMmRJUjZXaS9IWngx?=
 =?utf-8?B?RE9vL05hL2tacW81NnpndFZCdS9ON0hEaFczVCsyV2NuM05nYXVJSCtwSjIz?=
 =?utf-8?B?cEN4OUllMW9MaVFDZ3ZLcTQwTlppSWpjRFZlZ2pWSjFVRWMydWZDc09PQ0ti?=
 =?utf-8?B?TmpueGFpMkhxcXY3Nm0vbEEwdUd6Wm1Cem1Ea3RWWmxwT2tMOVp3RnpZc2ZF?=
 =?utf-8?B?SWdIKzBiZHhCSG9Ub3BvKy8wekpmaklrc3lnWmZ6b0NydU5leHFhSG8vdzY1?=
 =?utf-8?B?N0xxLzM1MGx3ZWFJNmFnaFNUQXZ4ZTI0OVhBYUlmQlJ0OXlpa2MyL0RxU25h?=
 =?utf-8?Q?ra+0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba4d81a-85c9-4ecf-2f79-08dce14a788d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:21:54.8873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UWZ+mP+4wEjfyDkqflg1MC4twMUNdlyfMYIghzXyx2PHjBq3wjqXkNOdGIxjXTI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
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

Am 30.09.24 um 13:59 schrieb Arunpravin Paneer Selvam:
> Add user fence wait IOCTL timeline syncobj support.
>
> v2:(Christian)
>    - handle dma_fence_wait() return value.
>    - shorten the variable name syncobj_timeline_points a bit.
>    - move num_points up to avoid padding issues.
>
> v3:(Christian)
>    - Handle timeline drm_syncobj_find_fence() call error
>      handling
>    - Use dma_fence_unwrap_for_each() in timeline fence as
>      there could be more than one fence.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 99 +++++++++++++++++--
>   include/uapi/drm/amdgpu_drm.h                 | 16 ++-
>   2 files changed, 107 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 8f9d2427d380..76552eed6d86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -24,6 +24,7 @@
>   
>   #include <linux/kref.h>
>   #include <linux/slab.h>
> +#include <linux/dma-fence-unwrap.h>
>   
>   #include <drm/drm_exec.h>
>   #include <drm/drm_syncobj.h>
> @@ -474,11 +475,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			    struct drm_file *filp)
>   {
> +	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles;
> +	u32 num_syncobj, num_bo_handles, num_points;
>   	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>   	struct drm_amdgpu_userq_wait *wait_info = data;
> -	u32 *syncobj_handles, *bo_handles;
>   	struct dma_fence **fences = NULL;
> -	u32 num_syncobj, num_bo_handles;
>   	struct drm_gem_object **gobj;
>   	struct drm_exec exec;
>   	int r, i, entry, cnt;
> @@ -498,11 +499,26 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		goto free_bo_handles;
>   	}
>   
> +	num_points = wait_info->num_points;
> +	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> +				       sizeof(u32) * num_points);
> +	if (IS_ERR(timeline_handles)) {
> +		r = PTR_ERR(timeline_handles);
> +		goto free_syncobj_handles;
> +	}
> +
> +	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> +				      sizeof(u32) * num_points);
> +	if (IS_ERR(timeline_points)) {
> +		r = PTR_ERR(timeline_points);
> +		goto free_timeline_handles;
> +	}
> +
>   	/* Array of GEM object handles */
>   	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>   	if (!gobj) {
>   		r = -ENOMEM;
> -		goto free_syncobj_handles;
> +		goto free_timeline_points;
>   	}
>   
>   	for (entry = 0; entry < num_bo_handles; entry++) {
> @@ -524,15 +540,40 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	if (!wait_info->num_fences) {
> +		if (num_points) {
> +			struct dma_fence_unwrap iter;
> +			struct dma_fence *fence;
> +			struct dma_fence *f;
> +
> +			for (i = 0; i < num_points; i++) {
> +				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +							   timeline_points[i],
> +							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +							   &fence);
> +				if (r)
> +					goto exec_fini;
> +
> +				num_fences++;
> +
> +				dma_fence_unwrap_for_each(f, &iter, fence)
> +					num_fences++;

This duplicates the num_fences increment, just drop the first one since 
fence is always included in the iteration as well.

> +
> +				dma_fence_put(fence);
> +			}
> +		}
> +
>   		/* Count syncobj's fence */
>   		for (i = 0; i < num_syncobj; i++) {
>   			struct dma_fence *fence;
>   
>   			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0, 0, &fence);
> +						   0,
> +						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +						   &fence);
>   			if (r)
>   				goto exec_fini;
>   
> +			dma_fence_put(fence);
>   			num_fences++;
>   			dma_fence_put(fence);
>   		}
> @@ -588,12 +629,46 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			}
>   		}
>   
> +		if (num_points) {
> +			struct dma_fence_unwrap iter;
> +			struct dma_fence *fence;
> +			struct dma_fence *f;
> +
> +			for (i = 0; i < num_points; i++) {
> +				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +							   timeline_points[i],
> +							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +							   &fence);
> +				if (r)
> +					goto free_fences;
> +
> +				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +					r = -EINVAL;
> +					goto free_fences;
> +				}
> +
> +				fences[num_fences++] = fence;

Same here.

Apart from that looks good to me. We could cleanup the code a bit more, 
but that can come later on.

Regards,
Christian.

> +
> +				dma_fence_unwrap_for_each(f, &iter, fence) {
> +					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +						r = -EINVAL;
> +						goto free_fences;
> +					}
> +
> +					dma_fence_get(f);
> +					fences[num_fences++] = f;
> +				}
> +			}
> +		}
> +
>   		/* Retrieve syncobj's fence */
>   		for (i = 0; i < num_syncobj; i++) {
>   			struct dma_fence *fence;
>   
>   			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0, 0, &fence);
> +						   0,
> +						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +						   &fence);
>   			if (r)
>   				goto free_fences;
>   
> @@ -616,9 +691,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   				 * Just waiting on other driver fences should
>   				 * be good for now
>   				 */
> -				dma_fence_wait(fences[i], false);
> -				dma_fence_put(fences[i]);
> +				r = dma_fence_wait(fences[i], true);
> +				if (r) {
> +					dma_fence_put(fences[i]);
> +					goto free_fences;
> +				}
>   
> +				dma_fence_put(fences[i]);
>   				continue;
>   			}
>   
> @@ -664,6 +743,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		drm_gem_object_put(gobj[i]);
>   	kfree(gobj);
>   
> +	kfree(timeline_points);
> +	kfree(timeline_handles);
>   	kfree(syncobj_handles);
>   	kfree(bo_handles);
>   
> @@ -681,6 +762,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	while (entry-- > 0)
>   		drm_gem_object_put(gobj[entry]);
>   	kfree(gobj);
> +free_timeline_points:
> +	kfree(timeline_points);
> +free_timeline_handles:
> +	kfree(timeline_handles);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
>   free_bo_handles:
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index af42798e901d..3b24e0cb1b51 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -521,12 +521,26 @@ struct drm_amdgpu_userq_wait {
>   	 * matching fence wait info pair in @userq_fence_info.
>   	 */
>   	__u32	bo_wait_flags;
> -	__u32	pad;
> +	/**
> +	 * @num_points: A count that represents the number of timeline syncobj handles in
> +	 * syncobj_handles_array.
> +	 */
> +	__u32	num_points;
>   	/**
>   	 * @syncobj_handles_array: An array of syncobj handles defined to get the
>   	 * fence wait information of every syncobj handles in the array.
>   	 */
>   	__u64	syncobj_handles_array;
> +	/**
> +	 * @syncobj_timeline_handles: An array of timeline syncobj handles defined to get the
> +	 * fence wait information of every timeline syncobj handles in the array.
> +	 */
> +	__u64   syncobj_timeline_handles;
> +	/**
> +	 * @syncobj_timeline_points: An array of timeline syncobj points defined to get the
> +	 * fence wait points of every timeline syncobj handles in the syncobj_handles_array.
> +	 */
> +	__u64	syncobj_timeline_points;
>   	/**
>   	 * @bo_handles_array: An array of GEM BO handles defined to fetch the fence
>   	 * wait information of every BO handles in the array.

