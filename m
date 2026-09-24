Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A8BC98304
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 03:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BB810F2B7;
	Thu, 24 Sep 2026 03:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dn3ks9zp";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9857D10F2B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 03:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKl519d69h5edVJ5hTz49LM5EpJexbYf8L4i61jP0b/ohtDaUFcErlZqjv+u1c0gc+Cv4XE8EDDd0en23O/nW9tNM0cfuqyXQJ3HsBCK0uyl/Ns8itfaehPFF9M3ISPfS1xvGElbtsYOvMQ+GIdIfyf6f/TeN7mggqS4PrgFukbfvgGsgUT1T9R5pqeSiocC32TKscMic5i25QsBXOUMng5TjwDqa9HYq07zNRobfqkEnOrgz2OkM8oPwKvIle11RHJ/4uhwC+JP8kPObNUJa1LjKe+101MvhW22l2klYMgs7vf7zOox13CqumVf28NhhajIel3qzZRfrfCtC8Br0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKKbpym3kJovncIXUL/eWv67JVd3ii153NDZJVLwTEQ=;
 b=N5dJsMZg+6ELlK+yWFKfAmQFvOINFZC3J0O9BCuCmYLMZzSMP08O0nj07hvPHFI4NJIyujYCHZPj36xPVyECKOOLNSb8f8IaMMpk2z62KsPmO14fq71hVvn5FvzVDaCemcPR8b8Ni9AB0Mxe5ujRold8trHZjx/fWA7Ecd/xzhGfmsljvLntAoJHRd1ahNdEhLKXANesEcU8TJXsP/05qdCFPCUo8kqiZHdQwbbd8J1T1x3MFkk2Po1cWhp4iztmNBQFeFLHDEyU4rIJaH15RrxHq6P6IVwn2HYPMrjBGCFgjftgLuTlLgin5XvsRKlRndbsNKb6o7kFMDoKn3jCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKKbpym3kJovncIXUL/eWv67JVd3ii153NDZJVLwTEQ=;
 b=Dn3ks9zpFuKLycRggJO+b/wX2np/r/CKhdG1+mmVsNkB3v0RoNxLBkM4KJkswf/iUS6mJ2z7Y7BOUgI9RivqUVYVgvCQroNrarKSX3RUdy9/6PH5vDXEeL53E9VvMxN+dkWrW4vQwR5HIgDzcqWIN8y4SGt5zXdDwPxhEzsHXiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) by
 BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 03:38:21 +0000
Received: from DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587]) by DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 03:38:19 +0000
Content-Type: multipart/alternative;
 boundary="------------FVSxOMCu0mC2NM73f55XBBnt"
Message-ID: <e662808d-e525-48fe-a5f3-3409b1d19e02@amd.com>
Date: Thu, 24 Sep 2026 11:38:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] drm/amdgpu: implement PMC ioctl framework
To: James Zhu <jamesz@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-2-lingshan.zhu@amd.com>
 <a8011684-b04b-4483-b05c-d547c1f4f86b@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <a8011684-b04b-4483-b05c-d547c1f4f86b@amd.com>
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To DS7PR12MB9475.namprd12.prod.outlook.com
 (2603:10b6:8:251::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9475:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 411c6ce4-3726-44e4-6822-08df19ed4688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|3023799007|6133799003|8096899003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: c+nzp1ZsuGN6kzcH+BQIo0S/dhEGCGWuO9CWztOcTmkLGtifJKkuX7dZfA/ZZZOMJc48k3XHCgM5lyPA0KwGFot3KEaUx/x1+wa3asnI9LtKsnGUD5Cjd4OP3S7bFTQBT60rIeUK9VZPM+2CwcquCwyTfqOIBzeLUm8kBBIzhGrwms6sWWPJOm/qtIPIaNnDdnqTkxDO+Bd60QQ+Nf1pH7QWyFosHCY/otfcV7SSHL5XtRCp0QYvQtE8fSSXE5Z7wkwYq8I0jSasaMJe5ch9iC3rSmyvtpJcRXvlxKWMzFQjc2KWVA5fYkTVcRgux4iy/AzS3PsqEyeAmEFh6Soq8kv/7U7hzTXQewmhnpFhFEQl/OlBDI6aSpfyimzPP/hzf98w1woUup+a7t90YO171DdIg0OhzEi9UnRpegGd8EtmKN/angh2lbsPw22RA5IeQY7upE7/HGfuM+Zfj0icdEeq3N/R+cVknTn0Ad9Hlwp/5+7jdXWe+I31YyBceH7t8zIxK1vVfR19x2pvzrzrHBf/Tr6mRKeQKH99VMbvVJQVA8Bfhee3urAzpTyRXI0hwteobxWKsSofUXdwbMGXgC40lNQ2wuuXexDNDeLrrAMC7zE4GxGzVOsmvNf/83XH7/Z0GFziTWNICEv3vV+FPBHKyf2bxml1g+e+yxOWT24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9475.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(3023799007)(6133799003)(8096899003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEljWCtRYTd6SUFSYklzNW1RY1hBOXQ4V0Q5cVlEL1hvYWdUNkVzcnRVMXFZ?=
 =?utf-8?B?RHA2QmcwWkUydEVpa1dnQnFjQ0ZidzZsWEo4aU1Xc3NzQnAvdm52VVRwQldt?=
 =?utf-8?B?ODlBa2EwRmVHMWVuRTFhbnJkNVVZWFNlMnc3QlpuSHR0N28rUURUOG00NEht?=
 =?utf-8?B?RnF5OW52ZXZESW1qN2pkOHgvczV3c0lzZnhpeVg2Vm1WWktPY2FtVWRONHJ2?=
 =?utf-8?B?NEwwYUtWWmdZOUMxZFJjTm03bkNoWllWb2pIcjVMZE9qWkprUXIyc2lhdUox?=
 =?utf-8?B?ZXRVVlR1SXhmUEw5S0NRWXhwYTBjTXVUbXFiOGVtSzY4MkpoYU9LcXJVMEow?=
 =?utf-8?B?Yy83cjhBTnI4MC9LaEtmalJCb3NIOTdiSXRBZE9jb2NFcWx0ODkxa0hDRWxT?=
 =?utf-8?B?WDlwUmVUY1R1MmVZbXIxN1dvdklyRE14aGY0ZXVrazhLd2ZMMUNBVE9jOFVH?=
 =?utf-8?B?QUlTTDhJUk9IcmIwVzQwTUdjckhIZFFuQmN4T2pMODVrZHJlMDU2NGs5SXRo?=
 =?utf-8?B?MFA2Tm56TEVTTG85bHhvZklrV0k5SzBOUS91aE9BcW5OSFZONVkrRW1oWnl1?=
 =?utf-8?B?T2JhVmxrdko0c2lLWE5uSUplUnhBdUZrZkRWdVIwaWQwc1BqSlhlaThUVlZZ?=
 =?utf-8?B?Q3lBWXRITWFMcTdGbEkxdERDeDhzUWRzWWwzR3RZQjYwRlRkNzgyQ1QzNTRt?=
 =?utf-8?B?MG42NkpueC9qM01id1Y4blE3TldjdU9LVkFuVDJqdnlmYklycWRIbWR5elZC?=
 =?utf-8?B?RSt1endWUW8wczF1YmdMcmFoZ1hMNlNDWU9VV1YvZGNyK1JhV0hOQkZGNDdM?=
 =?utf-8?B?Y2IwZzFSM2tmV1NPTkhLcVFFOFVteXozRXc1cEo4cXRwcEVtdXA2QVR4VzRD?=
 =?utf-8?B?V09la1UvUnBKcGxZVTlxNGRPc1A4UTQwZlpvb1dWdGVIS3F1VHRwaHFZbEk0?=
 =?utf-8?B?Ynp5bGJmQnNRYXlabzJuU3FTTTlVYkVkK2FLY09xZ1JLREU5cHZoNHpwbnV5?=
 =?utf-8?B?YW5YZ3FReUNpQWNiYVpHcVJkdGtZRWFJMmV0a0dIQkpWaklDdWE2d3VxTkFs?=
 =?utf-8?B?bndYNUlzbFlWM0ZDZ2Q4OW5Rd2FSc3k4SFdLaDRZOFFjOE5pN25aTVF6cHQ3?=
 =?utf-8?B?V1ZiVkRIK2RkdmRGSVl0TUJPd2RWdm82UGFBN1h1OGNrZE9XSHV3dEdHdGw3?=
 =?utf-8?B?VC83TlZFdW5nV1dYMTdBdm1CUnhqd3NlNGhLK0ZqaEV3MVNVb1RvaFdUYVd1?=
 =?utf-8?B?MHA0VWwwSWxFZzVIcU1wNERiQTJpMit5WFNZWUdROEphMDVGYXQyaXU3bElO?=
 =?utf-8?B?ZVp5VCs3bFlyaDRYWDd6UEpuYnRpSi9McnJ4d3djQUdKR01xL0xJWnlrNFZI?=
 =?utf-8?B?TkFycExhN0xwUGptTHVSSVRXVk0xdUdJTXpvQnpaVzV1Z05FK1dCSWtXY3lr?=
 =?utf-8?B?ei9HVWZIUm01cjBiMEZCVzVjY0s4aDhPa3RvRURVT1dRcUpTcFBGTlhUSjRW?=
 =?utf-8?B?c2pMVmRTQ3Ivdjk5T2RlWFJVblBiaEpkd2NsYXhlVEdYbFdiQTFjUk13RmFy?=
 =?utf-8?B?QW5RTSs2U3c2WHVEaXNwZzQwTzgzL3lORW0yV28zTnhncEsvU1JPV243NUQv?=
 =?utf-8?B?S2pXZW04cHY3bWlmMTZLai9oQU96aFNiUjRmZTZpV3J3Zk14a25SVmRyTFdE?=
 =?utf-8?B?d1RvVmIwVDd6UUtvQ3dndUE3dmt4V3N1L2JmTHRKS3BzUGRRRThtd3NNTEdQ?=
 =?utf-8?B?Q3hFWEU5azZYMjVYaGdaeGJ0TUdTNHJpUkFWWS9kaitOUmVsL0tBbkQ3VXJ4?=
 =?utf-8?B?b2MrdFlWYXEzQUphaFdDSk1FL3FuQnU5THB0KzIrK2RTMEZhRklTTnhFYUNL?=
 =?utf-8?B?Y3E3TzRNYUtYQUQrQkdMcUk0MjhxQk93b0pSbnNjVVhxeExLaTV4NG9RRVA2?=
 =?utf-8?B?OFVoUFk4YXAvOTdNNEhTaEZwZ3FnbW5oT2hyY0dMVFYzWUhvc0ZqNmx3cHVs?=
 =?utf-8?B?UFVRZVE5emV6R2FiYUdkMUd3SUZ4VkJPYnZTT1Vaei9udVViZXRXb25LZmR0?=
 =?utf-8?B?ajhIWUJReFE3OXFvZjhTeFdXdHM0a0VFa1VqNWJsV1RyTXFhM2VZc0l3Yk05?=
 =?utf-8?B?alVyemN0ZklBVE1UblVFaThPdUdaWTVqVEl1NzRqTVBBSVVTVmFTeGZMc1ZM?=
 =?utf-8?B?Q3BsdUdPUE5zWEN0ZHdCdERQcVZ5bUIrVTBFanBsWXZGRXBQWklPUFJqaUJr?=
 =?utf-8?B?bVdqMEd2VXlNK2VEazcxK2psbjIrNnM0MmFGL1poMWwzSnFzeFB2cGx2MUhi?=
 =?utf-8?Q?NTpvCumm38bLdoyqJo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411c6ce4-3726-44e4-6822-08df19ed4688
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9475.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 03:38:19.4292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgUJ0a4idRvadlYKDvIc3vr0mqq1FAJQbDF5CMFIecnSRe3X99lJBR3uqA4uX4QM/tNBUJLQ2FpmUh5Dw6m5Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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

--------------FVSxOMCu0mC2NM73f55XBBnt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/2026 10:17 PM, James Zhu wrote:

>
> On 2026-09-22 05:34, Zhu Lingshan wrote:
>> This commit implements basic ioctl framework for PMC,
>> including basic operations.
>>
>> This commit also implements AMDGPU_PROFILER_OP_VERSION
>> which report profiler version to the user space.
>>
>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 44 ++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 33 +++++++++++++++
>>   include/uapi/drm/amdgpu_drm.h                | 36 ++++++++++++++++
>>   5 files changed, 116 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 6fb0a913e33b..d7db69e9d6a0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o
>> amdgpu_doorbell_mgr.o amdgpu_kms
>>       amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
>> amdgpu_lockdep.o \
>>       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o
>> amdgpu_dev_coredump.o \
>>       amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o
>> amdgpu_ip.o \
>> -    amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
>> +    amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_profiler.o
>>     amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 7c473f60bd28..a98c4a47e196 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -55,6 +55,7 @@
>>   #include "amdgpu_cwsr.h"
>>   #include "amdgpu_userq_fence.h"
>>   #include "../amdxcp/amdgpu_xcp_drv.h"
>> +#include "amdgpu_profiler.h"
>>     /*
>>    * KMS wrapper.
>> @@ -3096,6 +3097,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[]
>> = {
>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl,
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES,
>> amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>       DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS,
>> amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +    DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl,
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>     static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>> new file mode 100644
>> index 000000000000..04902696adab
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2026 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> obtaining a
>> + * copy of this software and associated documentation files (the
>> "Software"),
>> + * to deal in the Software without restriction, including without
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <drm/amdgpu_drm.h>
>> +#include "amdgpu_profiler.h"
>> +
>> +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct
>> drm_file *filp)
>> +{
>> +    struct drm_amdgpu_profiler_args *args = data;
>> +
>> +    switch (args->op) {
>> +    case AMDGPU_PROFILER_OP_VERSION:
>> +        args->version = AMDGPU_PROFILER_VERSION_NUM;
>> +        return 0;
>> +    case AMDGPU_PROFILER_OP_RESERVE:
>> +        return -EOPNOTSUPP;
>> +    case AMDGPU_PROFILER_OP_PMC:
>> +        return -EOPNOTSUPP;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>> new file mode 100644
>> index 000000000000..c27b5f9b3ff0
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>> @@ -0,0 +1,33 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Copyright 2026 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> obtaining a
>> + * copy of this software and associated documentation files (the
>> "Software"),
>> + * to deal in the Software without restriction, including without
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef __AMDGPU_PROFILER_H__
>> +#define __AMDGPU_PROFILER_H__
>> +
>> +#include <drm/drm_device.h>
>> +#include <drm/drm_file.h>
>> +
>> +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct
>> drm_file *filp);
>> +
>> +#endif /* __AMDGPU_PROFILER_H__ */
>> diff --git a/include/uapi/drm/amdgpu_drm.h
>> b/include/uapi/drm/amdgpu_drm.h
>> index 9222be9a6d2a..acc63804ba8c 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -60,6 +60,7 @@ extern "C" {
>>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>   #define DRM_AMDGPU_PROC_OPTIONS        0x1A
>>   #define DRM_AMDGPU_CWSR            0x1B
>> +#define DRM_AMDGPU_PROFILER        0x1C
>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE
>> + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE +
>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -83,6 +84,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE
>> + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>   #define DRM_IOCTL_AMDGPU_PROC_OPTIONS    DRM_IOWR(DRM_COMMAND_BASE
>> + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>>   #define DRM_IOCTL_AMDGPU_CWSR    DRM_IOWR(DRM_COMMAND_BASE +
>> DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
>> +#define DRM_IOCTL_AMDGPU_PROFILER    DRM_IOWR(DRM_COMMAND_BASE +
>> DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>>     /**
>>    * DOC: memory domains
>> @@ -1809,6 +1811,40 @@ struct drm_amdgpu_proc_options {
>>       } kfd_sigbus_delay;
>>   };
>>   +#define AMDGPU_PROFILER_VERSION_NUM    1
>> +
>> +enum amdgpu_profiler_ops {
>> +    AMDGPU_PROFILER_OP_VERSION = 1,
>> +    AMDGPU_PROFILER_OP_RESERVE = 2,
> [JZ] the implementation tells that it is
> AMDGPU_PROFILER_OP_PMC_RESERVE, it is better to put it under new PMC
> sub-ioctl op

Do you mean implement it like {bool pmc_enable, bool reserve} in a struct? I am not sure it is a good idea
and this reservation design is a improvement. Because it separates the reserve(lock) and unreserve(unlock),
so we don't need to keep the reservation during the PMC operations in a complex way, and we won't meet
the problems like how to handle the situation where the user tries to unlock but keeps enable = 1.

Thanks
Lingshan 

>> +    AMDGPU_PROFILER_OP_PMC = 3,
>> +};
>> +
>> +enum amdgpu_profiler_reserve_ops {
>> +    /* release the device resertaion, only the reservation owner do
>> this */
>> +    AMDGPU_PROFILER_RELEASE = 0,
>> +    /* reserve the device profiler */
>> +    AMDGPU_PROFILER_RESERVE = 1,
>> +    /* Clear the device profiler reservation, in case the reservation
>> +     * owner can no longer release the reservation(e.g., it crashes),
>> +     * This operation does not take the reseration nor touch
>> profielr state
>> +     */
>> +    AMDGPU_PROFILER_CLEAR_RESERVATION = 2,
>> +};
>> +
>> +struct drm_amdgpu_profiler_args {
>> +    /* enum amdgpu_profiler_ops */
>> +    __u8 op;
>> +    __u8 pad[3];
>> +    union {
>> +        /* AMDGPU_PROFILER_OP_RESERVE: enum
>> amdgpu_profiler_reserve_ops */
>> +        __u8 reserve;
>> +        /* AMDGPU_PROFILER_OP_PMC: 1 enable PMC, 0 disable PMC */
>> +        __u8 perfcount_enable;
>> +        /* AMDGPU_PROFILER_OP_VERSION: AMDGPU_PROFILER_VERSION_NUM */
>> +        __u32 version;
>> +    };
>> +};
>> +
>>   #if defined(__cplusplus)
>>   }
>>   #endif
--------------FVSxOMCu0mC2NM73f55XBBnt
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/23/2026 10:17 PM, James Zhu wrote:</pre>
    <blockquote type="cite" cite="mid:a8011684-b04b-4483-b05c-d547c1f4f86b@amd.com">
      <br>
      On 2026-09-22 05:34, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">This commit implements basic ioctl
        framework for PMC,
        <br>
        including basic operations.
        <br>
        <br>
        This commit also implements AMDGPU_PROFILER_OP_VERSION
        <br>
        which report profiler version to the user space.
        <br>
        <br>
        Signed-off-by: Zhu Lingshan<a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 44
        ++++++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 33
        +++++++++++++++
        <br>
        &nbsp; include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 36
        ++++++++++++++++
        <br>
        &nbsp; 5 files changed, 116 insertions(+), 1 deletion(-)
        <br>
        &nbsp; create mode 100644
        drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
        <br>
        &nbsp; create mode 100644
        drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
        b/drivers/gpu/drm/amd/amdgpu/Makefile
        <br>
        index 6fb0a913e33b..d7db69e9d6a0 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/Makefile
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
        <br>
        @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o
        amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o
        amdgpu_lsdma.o amdgpu_lockdep.o \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o
        amdgpu_dev_coredump.o \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o
        amdgpu_ip.o \
        <br>
        -&nbsp;&nbsp;&nbsp; amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
        <br>
        +&nbsp;&nbsp;&nbsp; amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_profiler.o
        <br>
        &nbsp; &nbsp; amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
        <br>
        index 7c473f60bd28..a98c4a47e196 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
        <br>
        @@ -55,6 +55,7 @@
        <br>
        &nbsp; #include &quot;amdgpu_cwsr.h&quot;
        <br>
        &nbsp; #include &quot;amdgpu_userq_fence.h&quot;
        <br>
        &nbsp; #include &quot;../amdxcp/amdgpu_xcp_drv.h&quot;
        <br>
        +#include &quot;amdgpu_profiler.h&quot;
        <br>
        &nbsp; &nbsp; /*
        <br>
        &nbsp;&nbsp; * KMS wrapper.
        <br>
        @@ -3096,6 +3097,7 @@ const struct drm_ioctl_desc
        amdgpu_ioctls_kms[] = {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT,
        amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES,
        amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS,
        amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
        <br>
        +&nbsp;&nbsp;&nbsp; DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl,
        DRM_AUTH|DRM_RENDER_ALLOW),
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; static const struct drm_driver amdgpu_kms_driver = {
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
        <br>
        new file mode 100644
        <br>
        index 000000000000..04902696adab
        <br>
        --- /dev/null
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
        <br>
        @@ -0,0 +1,44 @@
        <br>
        +// SPDX-License-Identifier: MIT
        <br>
        +/*
        <br>
        + * Copyright 2026 Advanced Micro Devices, Inc.
        <br>
        + *
        <br>
        + * Permission is hereby granted, free of charge, to any person
        obtaining a
        <br>
        + * copy of this software and associated documentation files
        (the &quot;Software&quot;),
        <br>
        + * to deal in the Software without restriction, including
        without limitation
        <br>
        + * the rights to use, copy, modify, merge, publish, distribute,
        sublicense,
        <br>
        + * and/or sell copies of the Software, and to permit persons to
        whom the
        <br>
        + * Software is furnished to do so, subject to the following
        conditions:
        <br>
        + *
        <br>
        + * The above copyright notice and this permission notice shall
        be included in
        <br>
        + * all copies or substantial portions of the Software.
        <br>
        + *
        <br>
        + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY
        KIND, EXPRESS OR
        <br>
        + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
        MERCHANTABILITY,
        <br>
        + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO
        EVENT SHALL
        <br>
        + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
        CLAIM, DAMAGES OR
        <br>
        + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
        OTHERWISE,
        <br>
        + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
        THE USE OR
        <br>
        + * OTHER DEALINGS IN THE SOFTWARE.
        <br>
        + *
        <br>
        + */
        <br>
        +
        <br>
        +#include &lt;linux/errno.h&gt;
        <br>
        +#include &lt;drm/amdgpu_drm.h&gt;
        <br>
        +#include &quot;amdgpu_profiler.h&quot;
        <br>
        +
        <br>
        +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data,
        struct drm_file *filp)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct drm_amdgpu_profiler_args *args = data;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; switch (args-&gt;op) {
        <br>
        +&nbsp;&nbsp;&nbsp; case AMDGPU_PROFILER_OP_VERSION:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;version = AMDGPU_PROFILER_VERSION_NUM;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +&nbsp;&nbsp;&nbsp; case AMDGPU_PROFILER_OP_RESERVE:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;
        <br>
        +&nbsp;&nbsp;&nbsp; case AMDGPU_PROFILER_OP_PMC:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;
        <br>
        +&nbsp;&nbsp;&nbsp; default:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +}
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
        <br>
        new file mode 100644
        <br>
        index 000000000000..c27b5f9b3ff0
        <br>
        --- /dev/null
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
        <br>
        @@ -0,0 +1,33 @@
        <br>
        +/* SPDX-License-Identifier: MIT */
        <br>
        +/*
        <br>
        + * Copyright 2026 Advanced Micro Devices, Inc.
        <br>
        + *
        <br>
        + * Permission is hereby granted, free of charge, to any person
        obtaining a
        <br>
        + * copy of this software and associated documentation files
        (the &quot;Software&quot;),
        <br>
        + * to deal in the Software without restriction, including
        without limitation
        <br>
        + * the rights to use, copy, modify, merge, publish, distribute,
        sublicense,
        <br>
        + * and/or sell copies of the Software, and to permit persons to
        whom the
        <br>
        + * Software is furnished to do so, subject to the following
        conditions:
        <br>
        + *
        <br>
        + * The above copyright notice and this permission notice shall
        be included in
        <br>
        + * all copies or substantial portions of the Software.
        <br>
        + *
        <br>
        + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY
        KIND, EXPRESS OR
        <br>
        + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
        MERCHANTABILITY,
        <br>
        + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO
        EVENT SHALL
        <br>
        + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
        CLAIM, DAMAGES OR
        <br>
        + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
        OTHERWISE,
        <br>
        + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
        THE USE OR
        <br>
        + * OTHER DEALINGS IN THE SOFTWARE.
        <br>
        + *
        <br>
        + */
        <br>
        +
        <br>
        +#ifndef __AMDGPU_PROFILER_H__
        <br>
        +#define __AMDGPU_PROFILER_H__
        <br>
        +
        <br>
        +#include &lt;drm/drm_device.h&gt;
        <br>
        +#include &lt;drm/drm_file.h&gt;
        <br>
        +
        <br>
        +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data,
        struct drm_file *filp);
        <br>
        +
        <br>
        +#endif /* __AMDGPU_PROFILER_H__ */
        <br>
        diff --git a/include/uapi/drm/amdgpu_drm.h
        b/include/uapi/drm/amdgpu_drm.h
        <br>
        index 9222be9a6d2a..acc63804ba8c 100644
        <br>
        --- a/include/uapi/drm/amdgpu_drm.h
        <br>
        +++ b/include/uapi/drm/amdgpu_drm.h
        <br>
        @@ -60,6 +60,7 @@ extern &quot;C&quot; {
        <br>
        &nbsp; #define DRM_AMDGPU_GEM_LIST_HANDLES&nbsp;&nbsp;&nbsp; 0x19
        <br>
        &nbsp; #define DRM_AMDGPU_PROC_OPTIONS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1A
        <br>
        &nbsp; #define DRM_AMDGPU_CWSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1B
        <br>
        +#define DRM_AMDGPU_PROFILER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1C
        <br>
        &nbsp; &nbsp; #define DRM_IOCTL_AMDGPU_GEM_CREATE&nbsp;&nbsp;&nbsp;
        DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
        drm_amdgpu_gem_create)
        <br>
        &nbsp; #define DRM_IOCTL_AMDGPU_GEM_MMAP&nbsp;&nbsp;&nbsp; DRM_IOWR(DRM_COMMAND_BASE
        + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
        <br>
        @@ -83,6 +84,7 @@ extern &quot;C&quot; {
        <br>
        &nbsp; #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
        DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct
        drm_amdgpu_gem_list_handles)
        <br>
        &nbsp; #define DRM_IOCTL_AMDGPU_PROC_OPTIONS&nbsp;&nbsp;&nbsp;
        DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct
        drm_amdgpu_proc_options)
        <br>
        &nbsp; #define DRM_IOCTL_AMDGPU_CWSR&nbsp;&nbsp;&nbsp; DRM_IOWR(DRM_COMMAND_BASE +
        DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
        <br>
        +#define DRM_IOCTL_AMDGPU_PROFILER&nbsp;&nbsp;&nbsp; DRM_IOWR(DRM_COMMAND_BASE
        + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
        <br>
        &nbsp; &nbsp; /**
        <br>
        &nbsp;&nbsp; * DOC: memory domains
        <br>
        @@ -1809,6 +1811,40 @@ struct drm_amdgpu_proc_options {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } kfd_sigbus_delay;
        <br>
        &nbsp; };
        <br>
        &nbsp; +#define AMDGPU_PROFILER_VERSION_NUM&nbsp;&nbsp;&nbsp; 1
        <br>
        +
        <br>
        +enum amdgpu_profiler_ops {
        <br>
        +&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_OP_VERSION = 1,
        <br>
        +&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_OP_RESERVE = 2,
        <br>
      </blockquote>
      [JZ] the implementation tells that it is
      AMDGPU_PROFILER_OP_PMC_RESERVE, it is better to put it under new
      PMC sub-ioctl op</blockquote>
    <pre>Do you mean implement it like {bool pmc_enable, bool reserve} in a struct? I am not sure it is a good idea
and this reservation design is a improvement. Because it separates the reserve(lock) and unreserve(unlock),
so we don't need to keep the reservation during the PMC operations in a complex way, and we won't meet
the problems like how to handle the situation where the user tries to unlock but keeps enable = 1.

Thanks
Lingshan </pre>
    <blockquote type="cite" cite="mid:a8011684-b04b-4483-b05c-d547c1f4f86b@amd.com">
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_OP_PMC = 3,
        <br>
        +};
        <br>
        +
        <br>
        +enum amdgpu_profiler_reserve_ops {
        <br>
        +&nbsp;&nbsp;&nbsp; /* release the device resertaion, only the reservation
        owner do this */
        <br>
        +&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_RELEASE = 0,
        <br>
        +&nbsp;&nbsp;&nbsp; /* reserve the device profiler */
        <br>
        +&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_RESERVE = 1,
        <br>
        +&nbsp;&nbsp;&nbsp; /* Clear the device profiler reservation, in case the
        reservation
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * owner can no longer release the reservation(e.g., it
        crashes),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * This operation does not take the reseration nor touch
        profielr state
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_CLEAR_RESERVATION = 2,
        <br>
        +};
        <br>
        +
        <br>
        +struct drm_amdgpu_profiler_args {
        <br>
        +&nbsp;&nbsp;&nbsp; /* enum amdgpu_profiler_ops */
        <br>
        +&nbsp;&nbsp;&nbsp; __u8 op;
        <br>
        +&nbsp;&nbsp;&nbsp; __u8 pad[3];
        <br>
        +&nbsp;&nbsp;&nbsp; union {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMDGPU_PROFILER_OP_RESERVE: enum
        amdgpu_profiler_reserve_ops */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 reserve;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMDGPU_PROFILER_OP_PMC: 1 enable PMC, 0 disable PMC
        */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 perfcount_enable;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMDGPU_PROFILER_OP_VERSION:
        AMDGPU_PROFILER_VERSION_NUM */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;
        <br>
        +&nbsp;&nbsp;&nbsp; };
        <br>
        +};
        <br>
        +
        <br>
        &nbsp; #if defined(__cplusplus)
        <br>
        &nbsp; }
        <br>
        &nbsp; #endif
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------FVSxOMCu0mC2NM73f55XBBnt--
