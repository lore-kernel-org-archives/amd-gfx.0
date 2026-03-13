Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5550106FD9E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680B310EB1B;
	Fri, 13 Mar 2026 08:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uz+HwCcD";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA37010EB37
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 08:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVbTnnX4En65RdvbbuMmQxmIe7dAdNH5e5mRBK5e3rcXJQwAdsl0z7cBS72ji/lquqYKvGhZLpakvMetPxTEDaFesOQrPuf4lVFhsHZKTW4wI7z1bd6eCPR7rrjmolJUhnsllsIw2vDod9cdQ0sLPpQ3384uswtpg6mV/n+E7FvyW4GezXhRwMKmxQyKUQDUYA8g/g/iAfC6lKqGxoaLAHoOFf6zRXQnJ4Os8a/Tuq+gbD0Ffb5NVIcAOMtM4vX6prH5Mo6WJbAvcs8sseMrqQSIvmbCbLNzFN13cgW6BJU5CRIIM9bAvhXxQk4N3WF5cn2/TgfsdEWJufrmB5RlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPgoO4Lw04bCw+v64kWT1YHwPWknFTYFZAIQHh9FujM=;
 b=y5QGqCTFqaXXjF0+DnPUnZgzGeDoSWps+Lhf3AkW8+bpeUrYY8talxw7Rvs9ACy6e169w/ABG2AaQcEVFhGmIRTIgyK362VzLpZn+Qpcg5e/ghxgTZAhpTzvihf4GDMtArw4lffUZBDHLUlFMcRaOQXCbz4XVyhBK7TwkKXzzJ3ywIRNNw7M0gqvGNnnTUykXmnbhqcvhmfJlwh1ngNxtcU7T5WyvbA/RSIS2FLosEiUGjO47a1taeueEyAYYNU65B1A7zohcZZCXwIKFsmkBR1PJeDtuwVx69MjCNzXJSHcPlTHKmj6ELxCvYU3//QjZ2GelI4bLhtLYS0Tkkwing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPgoO4Lw04bCw+v64kWT1YHwPWknFTYFZAIQHh9FujM=;
 b=uz+HwCcDPR/nCD1tQ9CaHFx/jcsmJC0LvJpPKaywt1i3ft1d31QCwCeOWfEzIvZq6sEVz+mrpgiqnOWyUAm3OiPnyU9sHetrJ6bQ4DHWLswcKdRICQbDmjnDzSO/k9kwwUyQEUFG3bnHBDSM1wttCslvh4+Fqdl/AtsEFHRpAgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Fri, 13 Mar
 2026 08:00:06 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Fri, 13 Mar 2026
 08:00:06 +0000
Message-ID: <afcb82ed-5c7a-4d13-960b-957e9a8cefb0@amd.com>
Date: Fri, 13 Mar 2026 13:30:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: completely rework eviction fence
 handling
From: "Khatri, Sunil" <sukhatri@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-4-christian.koenig@amd.com>
 <8cae20bf-4ff5-4a03-8137-36096197364f@amd.com>
Content-Language: en-US
In-Reply-To: <8cae20bf-4ff5-4a03-8137-36096197364f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 427b37e9-b9fd-436b-2dba-08de80d68a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Q8nXda9hbxswOkTWUVu+4Hbn4ZRGO5F476TAgvdXwxfHU1KOpc9wf5YJ4LaM9rHEd3DEtwZYvUMpo5ZdTVyNqt5c+YrjcgGzftbo6hiY0B/wTo1pVNSVTxC0zmmKxcUCi+FSqgfWqnrIhUWKZae0AJw4XcJOCUnRl6uZf1YVQft2zEc1wSbcbs+NyPaS3348Cd2EBykQGsrM6cZbsSEsHJAQm+d9/4aiVNWpRttHI5k2JoIatbJ66tzTiy+CywnxgQsXI3VaIMWIKNs5gWjm4/PtK8VO2x9kGt7Py3IkKXN0x+VNaeVxSWJ2zWS+1tv/w5YSdLTqcUfroxeCMxppNzNJwBzJvx0HPM4tfjZhvs8dJmvT4wd3sdqVCBXnsvRQuJczCL74nbgdKcrRYuOqmTvjqlthLqDsEdZXNzHDAzPv/6mhbk/hz7mhg6wvZh7Vzh+Z5ayF0lAgLco4+EiU7HL924jxRIFKbUn+UgstOzTDBxz/cZVSxB5r18Yzk3ldot8QabcvB+TZ1d3DH/49NmiqCHyXUrEcsH7z6qolGj1X3UZXtC4A44FtvwJmuTzuzWP/IL3qHe/1z+ZqjMrevtuAfR00MZjUTb259pfICXu/zbs5C+D6rEpb3LqXQ2ngmZ6NXuaWTZqM9svmp7KOCXPSCCqgOnOo+tcMVmfC78wEECdiQ1OygP5/FdJ7mz+9ehRpwv5pmWjoVVsP2+qQrsf6H4VbIh4kPXMohtBm3RQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3RBalBad1RIOXh4N2ZSS2w4MDlPOXBMekRrZXh3aExwS2FzNkxJY0VyL0c2?=
 =?utf-8?B?Q3F4Sk01WVlUc1EvdExFT21zeDdzTytONjVqQ3Z1TmhQcnliMHZRSDZYNmRr?=
 =?utf-8?B?SEtLSUZWbGNGU1lZd29DTE1Rd1N2amVZem5aK3dhWEJFMnN0b1lGMk9RNEtJ?=
 =?utf-8?B?R2JkN25JektENDZBZnBmOUlCNnovRFlTcStqb0VCY2w5NFVPN2ZDcDd6YW5z?=
 =?utf-8?B?ZFIxVDdjR0ZPb1I1enlxRFZoMWFMZ093aEdSSkUwUGZJL1Bqaitkc3F6MDRa?=
 =?utf-8?B?MFRHV2FVaENMRHNETGZ6NXhRSGp1UUVYbTE0MWEvejF4NUNXY28wMDRQY3dR?=
 =?utf-8?B?dGlZODJaUkd3U2xIdzZyb0Q0Q24xUTk3RGlqUEFuMXF6TXk0eWMxNjJ5K3Fr?=
 =?utf-8?B?RFMyanYxb05yVVRsUjZPcklvMVhra0l6NCsyMnNuamRIYTNzZC9OenRmOVVk?=
 =?utf-8?B?QlIvNEk4VmJ5ejFKWTM4cWIrM0tmN1ZKVnFhLzJYbU5uUFJTWEZYRSswUnZ5?=
 =?utf-8?B?VnJIMkF3VHRMeDJnY1dzdnZ5NWpSK2RVbmdPdk5FVmpuYjQvYk9TNTh1QW1B?=
 =?utf-8?B?Si9hWE9ZZWJPT2NWR3F4d2NkdUNzbHJzdGhrRUt2eTJjWmNCT0UwTHk0dHFK?=
 =?utf-8?B?alM4bkVSM3hSanUrWTFhNExjVWJQd1doUnpPUGx0U01XWHJxWnY3Y0lwTE9F?=
 =?utf-8?B?SlhpQUJHcXZlY2NYS1lnNGpuNHBCa0ZKNFdvQXh6T09Ibnp0VzZyWXNvdlYv?=
 =?utf-8?B?MWFQUEs0MGpPMzRaRzZZZFJZeW5CWDNTcjhMbW41aTcrbWFxbm1Pb081WFB2?=
 =?utf-8?B?YXZDZUxZSHFSZjNueUYvcnVmbFVnaFlUbjArb21XUTJveTRNVVNoa0NFTjJM?=
 =?utf-8?B?RXNLR3VmTHQ1RnZmWHVxYUJzSUwzcS8rejFFSVFGRWxIWkE0RlU1RTgrMnBN?=
 =?utf-8?B?TEJCZkliZkdVb1pJaWlCNkhUNlg5c0FRaW9BUGRWLzBId1BVNTFUZklqcVJQ?=
 =?utf-8?B?UWdQZFpTNjZxVlU1VU8wQlZkc01VTStoczFTWHVyTzB5S296SktXYmV4VWxR?=
 =?utf-8?B?ako2SmxKWmVUbzg3TVZ0dDZPMHc0Q3U0MVVLTkRjSGIzZkszcFlNdEhocG9l?=
 =?utf-8?B?ZkZzZjU3SjgwT081Ujl3bi9IYmh1WG9WMUJ2L1JXQWV4ZDRnMzVjSlprRXlB?=
 =?utf-8?B?ZGdQcTB3aTE3aDNHdFdWM08xZ1ZDU01KT2Jad2ZSZDZPQTQ4OWxPNmNRbHdC?=
 =?utf-8?B?YkFpQzYveHExOHd4MXdwbzZNSkJXNXJLZkZKNWRJWTVpaFBrbUNrRG1jd1h3?=
 =?utf-8?B?ejcyL0UrQlg1Q3NBMnF3VGNCYXI0WlpOcU94ZmN2UWV4b1ZGNDVZQ1FRUlln?=
 =?utf-8?B?cFhpQ0xkMFV0d0VVNVR4eVRDZUpDS0J2UmQvOHRHbi9wRWMxTHZ5czBMbXUx?=
 =?utf-8?B?RmdPSUl1OWt4UTJHZWE3YzFQRWJ0Z3J6azlMQnlTN3lKZWgwSWV0WmhLdDFP?=
 =?utf-8?B?c3F3UkI2VVJFcjFSU3owY0t4dG15aUlCRmFxalFRM3NRM1Z4UGtXYnI4aDNm?=
 =?utf-8?B?cHV0Y0ZwSHJsMjNCclZUTHZuUTJlcGhpRE1SeEgrQ2dBRU1uaEdQOXFGdUVp?=
 =?utf-8?B?QUlzNEFrVWVQTnpqM1hIcXdiTjRqVStEeFkrOWpIZ09LYjJ2R1hUWXphelIy?=
 =?utf-8?B?TGdKUlp4TENhSkg4aDdCaFczWHprc2RFQWRvdHZ2VEhUVUxIQllwYTlVU25X?=
 =?utf-8?B?SU1UNjQ0Qm9YcVdkV3AzakJVdnB1ZHVCTG1UZXF4MS9PNy9naFk1RzlFd0tm?=
 =?utf-8?B?QVZFbUN3L3dPN0ZONGFHVmtOQVhRS090ZG9NcW4wL1p0anpqclFzLzJTT1M0?=
 =?utf-8?B?UGtDSkhuYlFyMVlnREtEejgvOEw0VlY1NnltZDVDNURBQzZaY1dVSlVXb0FC?=
 =?utf-8?B?bzhsNXBsbWlzOHMyUGhiTVFZT3FvYXYxTTBHRnBJVWtuRlEvSjVGa1RIYVNZ?=
 =?utf-8?B?cGtLbTNDOGlyZlNpcXVRU1pmYUtiZUl1ZDM4S0hFN2VqWi80YnJmYVhySlpF?=
 =?utf-8?B?SitscHovZUJRQ1pKclZTUE80UjNsYm5Cb0dNVDNrdmx3b0tjWHBMMCtPbmsw?=
 =?utf-8?B?S0xTbUVmblhUWUJHZGdpZ3RMVW9CR1EvWGF4V3poYkVaNnFkVTNxbTNGb3ho?=
 =?utf-8?B?a29SRVJpWHphWEV1TkJxdmo3RmluU2dsOFRpcnFUVFgxdXZoeDVOSlJ4Q3pz?=
 =?utf-8?B?aUZKL1JoK3pIdVNkbWNyVjd1UThoV2VCKzdrN1hHMXpvdDdNbHRmM0JSN29G?=
 =?utf-8?B?dzBEcjk2Q095dnlVZEIyN0dNeFgzTWVQMGxHK3l6bkh4OTBNd29Edz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427b37e9-b9fd-436b-2dba-08de80d68a25
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:00:06.6659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaCyHWpntLwUJJjlCSjqVpMiPumGN6F1mLaPv32k/64X/jMELlm21YsbKuvY3Q3yhzb5g+o9Lx9IeR0qseGn7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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

With some of the comments in my previous mail and with the fixes that i 
sent before this patch, the results looks good.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 11-03-2026 05:57 pm, Khatri, Sunil wrote:
>
> On 11-03-2026 12:43 am, Christian König wrote:
>> Well that was broken on multiple levels.
>>
>> First of all a lot of checks where placed at incorrect locations, 
>> especially if
> where -> were
>> the resume worker should run or not.
>>
>> Then a bunch of code was just mid-layering because of incorrect 
>> assignment who
>> should do what.
>>
>> And finally comments explaining what happens instead of why.
>>
>> Just re-write it from scratch, that should at least fix some of the 
>> hangs we
>> are seeing.
>>
>> Use RCU for the eviction fence pointer in the manager, the spinlock 
>> usage was
>> mostly incorrect as well. Then finally remove all the nonsense checks 
>> and
>> actually add them in the correct locations.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 213 ++++++------------
>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  54 ++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  10 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  29 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +-
>>   7 files changed, 112 insertions(+), 205 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 03814a23eb54..67b8c33d5ee3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2952,9 +2952,9 @@ static int amdgpu_drm_release(struct inode 
>> *inode, struct file *filp)
>>       int idx;
>>         if (fpriv && drm_dev_enter(dev, &idx)) {
>> -        fpriv->evf_mgr.fd_closing = true;
>> -        amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>> +        amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
>>           amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>> +        amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
>>           drm_dev_exit(idx);
>>       }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> index 23d7d0b0d625..8fe9f91f9551 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> @@ -25,9 +25,6 @@
>>   #include <drm/drm_exec.h>
>>   #include "amdgpu.h"
>>   -#define work_to_evf_mgr(w, name) container_of(w, struct 
>> amdgpu_eviction_fence_mgr, name)
>> -#define evf_mgr_to_fpriv(e) container_of(e, struct amdgpu_fpriv, 
>> evf_mgr)
>> -
>>   static const char *
>>   amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
>>   {
>> @@ -43,102 +40,14 @@ amdgpu_eviction_fence_get_timeline_name(struct 
>> dma_fence *f)
>>       return ef->timeline_name;
>>   }
>>   -int
>> -amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> -                    struct drm_exec *exec)
>> -{
>> -    struct amdgpu_eviction_fence *old_ef, *new_ef;
>> -    struct drm_gem_object *obj;
>> -    unsigned long index;
>> -    int ret;
>> -
>> -    if (evf_mgr->ev_fence &&
>> - !dma_fence_is_signaled(&evf_mgr->ev_fence->base))
>> -        return 0;
>> -    /*
>> -     * Steps to replace eviction fence:
>> -     * * lock all objects in exec (caller)
>> -     * * create a new eviction fence
>> -     * * update new eviction fence in evf_mgr
>> -     * * attach the new eviction fence to BOs
>> -     * * release the old fence
>> -     * * unlock the objects (caller)
>> -     */
>> -    new_ef = amdgpu_eviction_fence_create(evf_mgr);
>> -    if (!new_ef) {
>> -        DRM_ERROR("Failed to create new eviction fence\n");
>> -        return -ENOMEM;
>> -    }
>> -
>> -    /* Update the eviction fence now */
>> -    spin_lock(&evf_mgr->ev_fence_lock);
>> -    old_ef = evf_mgr->ev_fence;
>> -    evf_mgr->ev_fence = new_ef;
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> -
>> -    /* Attach the new fence */
>> -    drm_exec_for_each_locked_object(exec, index, obj) {
>> -        struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>> -
>> -        if (!bo)
>> -            continue;
>> -        ret = amdgpu_eviction_fence_attach(evf_mgr, bo);
>> -        if (ret) {
>> -            DRM_ERROR("Failed to attch new eviction fence\n");
>> -            goto free_err;
>> -        }
>> -    }
>> -
>> -    /* Free old fence */
>> -    if (old_ef)
>> -        dma_fence_put(&old_ef->base);
>> -    return 0;
>> -
>> -free_err:
>> -    kfree(new_ef);
>> -    return ret;
>> -}
>> -
>> -static void
>> -amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>> -{
>> -    struct amdgpu_eviction_fence_mgr *evf_mgr = 
>> work_to_evf_mgr(work, suspend_work.work);
>> -    struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
>> -    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> -    struct amdgpu_eviction_fence *ev_fence;
>> -
>> -    mutex_lock(&uq_mgr->userq_mutex);
>> -    spin_lock(&evf_mgr->ev_fence_lock);
>> -    ev_fence = evf_mgr->ev_fence;
>> -    if (ev_fence)
>> -        dma_fence_get(&ev_fence->base);
>> -    else
>> -        goto unlock;
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> -
>> -    amdgpu_userq_evict(uq_mgr, ev_fence);
>> -
>> -    mutex_unlock(&uq_mgr->userq_mutex);
>> -    dma_fence_put(&ev_fence->base);
>> -    return;
>> -
>> -unlock:
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> -    mutex_unlock(&uq_mgr->userq_mutex);
>> -}
>> -
>>   static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence 
>> *f)
>>   {
>>       struct amdgpu_eviction_fence_mgr *evf_mgr;
>>       struct amdgpu_eviction_fence *ev_fence;
>>   -    if (!f)
>> -        return true;
> Isn't there a possibility of the fence being signaled or f to be NULL?
>> -
>>       ev_fence = to_ev_fence(f);
>>       evf_mgr = ev_fence->evf_mgr;
>> -
>> -    schedule_delayed_work(&evf_mgr->suspend_work, 0);
>> +    schedule_work(&evf_mgr->suspend_work);
>
> We can avoid to use evf_mgr instead directly use ev_fence->evf_mgr as 
> it is only one time usage.
>
> Regards
> Sunil Khatri
>
>>       return true;
>>   }
>>   @@ -148,22 +57,52 @@ static const struct dma_fence_ops 
>> amdgpu_eviction_fence_ops = {
>>       .enable_signaling = amdgpu_eviction_fence_enable_signaling,
>>   };
>>   -void amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> -                  struct amdgpu_eviction_fence *ev_fence)
>> +static void
>> +amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>>   {
>> -    spin_lock(&evf_mgr->ev_fence_lock);
>> -    dma_fence_signal(&ev_fence->base);
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> +    struct amdgpu_eviction_fence_mgr *evf_mgr =
>> +        container_of(work, struct amdgpu_eviction_fence_mgr,
>> +                 suspend_work);
>> +    struct amdgpu_fpriv *fpriv =
>> +        container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct dma_fence *ev_fence;
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +    ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>> +    amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
>> +
>> +    /*
>> +     * Signaling the eviction fence must be done while holding the
>> +     * userq_mutex. Otherwise we won't resume the queues before 
>> issuing the
>> +     * next fence.
>> +     */
>> +    dma_fence_signal(ev_fence);
>> +    dma_fence_put(ev_fence);
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +}
>> +
>> +void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> +                 struct amdgpu_bo *bo)
>> +{
>> +    struct dma_fence *ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>> +    struct dma_resv *resv = bo->tbo.base.resv;
>> +
>> +    dma_resv_add_fence(resv, ev_fence, DMA_RESV_USAGE_BOOKKEEP);
>> +    dma_fence_put(ev_fence);
>>   }
>>   -struct amdgpu_eviction_fence *
>> -amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +             struct drm_exec *exec)
>>   {
>>       struct amdgpu_eviction_fence *ev_fence;
>> +    struct drm_gem_object *obj;
>> +    unsigned long index;
>>   +    /* Create and initialize a new eviction fence */
>>       ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
>>       if (!ev_fence)
>> -        return NULL;
>> +        return -ENOMEM;
>>         ev_fence->evf_mgr = evf_mgr;
>>       get_task_comm(ev_fence->timeline_name, current);
>> @@ -171,56 +110,22 @@ amdgpu_eviction_fence_create(struct 
>> amdgpu_eviction_fence_mgr *evf_mgr)
>>       dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
>>                &ev_fence->lock, evf_mgr->ev_fence_ctx,
>> atomic_inc_return(&evf_mgr->ev_fence_seq));
>> -    return ev_fence;
>> -}
>> -
>> -void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr)
>> -{
>> -    struct amdgpu_eviction_fence *ev_fence;
>> -
>> -    /* Wait for any pending work to execute */
>> -    flush_delayed_work(&evf_mgr->suspend_work);
>> -
>> -    spin_lock(&evf_mgr->ev_fence_lock);
>> -    ev_fence = evf_mgr->ev_fence;
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> -
>> -    if (!ev_fence)
>> -        return;
>> -
>> -    dma_fence_wait(&ev_fence->base, false);
>>   -    /* Last unref of ev_fence */
>> -    dma_fence_put(&ev_fence->base);
>> -}
>> -
>> -int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> -                 struct amdgpu_bo *bo)
>> -{
>> -    struct amdgpu_eviction_fence *ev_fence;
>> -    struct dma_resv *resv = bo->tbo.base.resv;
>> -    int ret;
>> +    /* Remember it for newly added BOs */
>> +    dma_fence_put(evf_mgr->ev_fence);
>> +    evf_mgr->ev_fence = &ev_fence->base;
>>   -    if (!resv)
>> -        return 0;
>> +    /* And add it to all existing BOs */
>> +    drm_exec_for_each_locked_object(exec, index, obj) {
>> +        struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>>   -    ret = dma_resv_reserve_fences(resv, 1);
>> -    if (ret) {
>> -        DRM_DEBUG_DRIVER("Failed to resv fence space\n");
>> -        return ret;
>> +        amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
>>       }
>> -
>> -    spin_lock(&evf_mgr->ev_fence_lock);
>> -    ev_fence = evf_mgr->ev_fence;
>> -    if (ev_fence)
>> -        dma_resv_add_fence(resv, &ev_fence->base, 
>> DMA_RESV_USAGE_BOOKKEEP);
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> -
>>       return 0;
>>   }
>>   -void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> -                  struct amdgpu_bo *bo)
>> +void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> +                 struct amdgpu_bo *bo)
>>   {
>>       struct dma_fence *stub = dma_fence_get_stub();
>>   @@ -229,13 +134,25 @@ void amdgpu_eviction_fence_detach(struct 
>> amdgpu_eviction_fence_mgr *evf_mgr,
>>       dma_fence_put(stub);
>>   }
>>   -int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr)
>> +void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>>   {
>> -    /* This needs to be done one time per open */
>>       atomic_set(&evf_mgr->ev_fence_seq, 0);
>>       evf_mgr->ev_fence_ctx = dma_fence_context_alloc(1);
>> -    spin_lock_init(&evf_mgr->ev_fence_lock);
>> +    evf_mgr->ev_fence = dma_fence_get_stub();
>>   -    INIT_DELAYED_WORK(&evf_mgr->suspend_work, 
>> amdgpu_eviction_fence_suspend_worker);
>> -    return 0;
>> +    INIT_WORK(&evf_mgr->suspend_work, 
>> amdgpu_eviction_fence_suspend_worker);
>> +}
>> +
>> +void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +{
>> +    evf_mgr->shutdown = true;
>> +    flush_work(&evf_mgr->suspend_work);
>> +}
>> +
>> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +{
>> + dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true),
>> +               false);
>> +    flush_work(&evf_mgr->suspend_work);
>> +    dma_fence_put(evf_mgr->ev_fence);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> index fcd867b7147d..527de3a23583 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> @@ -25,6 +25,8 @@
>>   #ifndef AMDGPU_EV_FENCE_H_
>>   #define AMDGPU_EV_FENCE_H_
>>   +#include <linux/dma-fence.h>
>> +
>>   struct amdgpu_eviction_fence {
>>       struct dma_fence base;
>>       spinlock_t     lock;
>> @@ -35,35 +37,35 @@ struct amdgpu_eviction_fence {
>>   struct amdgpu_eviction_fence_mgr {
>>       u64            ev_fence_ctx;
>>       atomic_t        ev_fence_seq;
>> -    spinlock_t        ev_fence_lock;
>> -    struct amdgpu_eviction_fence *ev_fence;
>> -    struct delayed_work    suspend_work;
>> -    uint8_t fd_closing;
>> -};
>> -
>> -/* Eviction fence helper functions */
>> -struct amdgpu_eviction_fence *
>> -amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr);
>>   -void
>> -amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr);
>> -
>> -int
>> -amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> -                 struct amdgpu_bo *bo);
>> +    /*
>> +     * Only updated while holding the VM resv lock.
>> +     * Only signaled while holding the userq mutex.
>> +     */
>> +    struct dma_fence __rcu    *ev_fence;
>> +    struct work_struct    suspend_work;
>> +    bool            shutdown;
>> +};
>>   -void
>> -amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> -                 struct amdgpu_bo *bo);
>> +static inline struct dma_fence *
>> +amdgpu_evf_mgr_get_fence(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +{
>> +    struct dma_fence *ev_fence;
>>   -int
>> -amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
>> +    rcu_read_lock();
>> +    ev_fence = dma_fence_get_rcu_safe(&evf_mgr->ev_fence);
>> +    rcu_read_unlock();
>> +    return ev_fence;
>> +}
>>   -void
>> -amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> -                 struct amdgpu_eviction_fence *ev_fence);
>> +void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> +                 struct amdgpu_bo *bo);
>> +int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>> +             struct drm_exec *exec);
>> +void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> +                 struct amdgpu_bo *bo);
>> +void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
>> +void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr);
>> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr);
>>   -int
>> -amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr,
>> -                    struct drm_exec *exec);
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 5c90de58cc28..e28abfd04867 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -263,13 +263,7 @@ static int amdgpu_gem_object_open(struct 
>> drm_gem_object *obj,
>>       else
>>           ++bo_va->ref_count;
>>   -    /* attach gfx eviction fence */
>> -    r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
>> -    if (r) {
>> -        DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
>> -        amdgpu_bo_unreserve(abo);
>> -        return r;
>> -    }
>> +    amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
>>       drm_exec_fini(&exec);
>>         /* Validate and add eviction fence to DMABuf imports with 
>> dynamic
>> @@ -337,7 +331,7 @@ static void amdgpu_gem_object_close(struct 
>> drm_gem_object *obj,
>>       }
>>         if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>> -        amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
>> +        amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, bo);
>>         bo_va = amdgpu_vm_bo_find(vm, bo);
>>       if (!bo_va || --bo_va->ref_count)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index f69332eed051..f512b6ec6c53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1522,10 +1522,7 @@ int amdgpu_driver_open_kms(struct drm_device 
>> *dev, struct drm_file *file_priv)
>>                "Failed to init usermode queue manager (%d), use 
>> legacy workload submission only\n",
>>                r);
>>   -    r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
>> -    if (r)
>> -        goto error_vm;
>> -
>> +    amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>>       amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>>         file_priv->driver_priv = fpriv;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 85adc53eb523..67ba46851c2b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -472,17 +472,16 @@ void
>>   amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>>                    struct amdgpu_eviction_fence_mgr *evf_mgr)
>>   {
>> -    struct amdgpu_eviction_fence *ev_fence;
>> +    struct dma_fence *ev_fence;
>>     retry:
>>       /* Flush any pending resume work to create ev_fence */
>>       flush_delayed_work(&uq_mgr->resume_work);
>>         mutex_lock(&uq_mgr->userq_mutex);
>> -    spin_lock(&evf_mgr->ev_fence_lock);
>> -    ev_fence = evf_mgr->ev_fence;
>> -    spin_unlock(&evf_mgr->ev_fence_lock);
>> -    if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
>> +    ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>> +    if (dma_fence_is_signaled(ev_fence)) {
>> +        dma_fence_put(ev_fence);
>>           mutex_unlock(&uq_mgr->userq_mutex);
>>           /*
>>            * Looks like there was no pending resume work,
>> @@ -491,6 +490,7 @@ amdgpu_userq_ensure_ev_fence(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>           schedule_delayed_work(&uq_mgr->resume_work, 0);
>>           goto retry;
>>       }
>> +    dma_fence_put(ev_fence);
>>   }
>>     int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>> @@ -1196,7 +1196,7 @@ amdgpu_userq_vm_validate(struct 
>> amdgpu_userq_mgr *uq_mgr)
>>           dma_fence_wait(bo_va->last_pt_update, false);
>>       dma_fence_wait(vm->last_update, false);
>>   -    ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, 
>> &exec);
>> +    ret = amdgpu_evf_mgr_rearm(&fpriv->evf_mgr, &exec);
>>       if (ret)
>>           drm_file_err(uq_mgr->file, "Failed to replace eviction 
>> fence\n");
>>   @@ -1216,11 +1216,13 @@ static void 
>> amdgpu_userq_restore_worker(struct work_struct *work)
>>   {
>>       struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, 
>> resume_work.work);
>>       struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>> +    struct dma_fence *ev_fence;
>>       int ret;
>>   -    flush_delayed_work(&fpriv->evf_mgr.suspend_work);
>> -
>>       mutex_lock(&uq_mgr->userq_mutex);
>> +    ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
>> +    if (!dma_fence_is_signaled(ev_fence))
>> +        goto unlock;
>>         ret = amdgpu_userq_vm_validate(uq_mgr);
>>       if (ret) {
>> @@ -1236,6 +1238,7 @@ static void amdgpu_userq_restore_worker(struct 
>> work_struct *work)
>>     unlock:
>>       mutex_unlock(&uq_mgr->userq_mutex);
>> +    dma_fence_put(ev_fence);
>>   }
>>     static int
>> @@ -1311,11 +1314,8 @@ amdgpu_userq_wait_for_signal(struct 
>> amdgpu_userq_mgr *uq_mgr)
>>   }
>>     void
>> -amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>> -           struct amdgpu_eviction_fence *ev_fence)
>> +amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr, bool 
>> schedule_resume)
>>   {
>> -    struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>> -    struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
>>       struct amdgpu_device *adev = uq_mgr->adev;
>>       int ret;
>>   @@ -1328,10 +1328,7 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr 
>> *uq_mgr,
>>       if (ret)
>>           dev_err(adev->dev, "Failed to evict userqueue\n");
>>   -    /* Signal current eviction fence */
>> -    amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
>> -
>> -    if (!evf_mgr->fd_closing)
>> +    if (schedule_resume)
>>           schedule_delayed_work(&uq_mgr->resume_work, 0);
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 54e1997b3cc0..82306d489064 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -133,7 +133,7 @@ void amdgpu_userq_destroy_object(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>                    struct amdgpu_userq_obj *userq_obj);
>>     void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>> -            struct amdgpu_eviction_fence *ev_fence);
>> +            bool schedule_resume);
>>     void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr 
>> *userq_mgr,
>>                     struct amdgpu_eviction_fence_mgr *evf_mgr);
