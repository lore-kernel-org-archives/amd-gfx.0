Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF93F8D74B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 14:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F7910E8C0;
	Thu, 16 Apr 2026 14:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kVpxbJJ5";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011062.outbound.protection.outlook.com
 [40.93.194.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73A410E8C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 14:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spN8At0n+YtG9aROuw/mGErHn3bjiQjl3Bdc1WsOu6S2aiBooKLqhzPeU7E1tEu1uz6xCfkGiCwu4by0KwWH7GsfgLp2HftIBvIWzgHeoe2GhUC8vzwvKrPWMBNewaxCc0ASqTZz3pjvTIAfezuj8wINI27blwu7Cnpv+LUCkLlp/QyXv3Qf1Ow5me35v5Kt9OUejG3s7pQBXTlyPqpHLaQ6nN2ZYNMWCtzhHVgR3K/u5byyyqMXtgkyoQ5A3Ach+XsZkCxvHN4ZPEJH9cUGi9h6bsgmhe+vy78bL0KmuDvCSD0xsiY6F5s/AnOLRH+g+YGtg1IYzEXg6G1KzQovUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUMQmwYAMagt0SFHaPo7hVRrJuFvcqyvgt+AfgA8ZAY=;
 b=gRfAdjgNR8Sh/A0B7u6qooLPoxAtBfHuVb32Ck7u4e7zAe58l9xZYw77i4shNIHO5UFuJty0HpluQ3/KaMICQkJ/nvXuQ2WajZ1CqfEqkW+zSpF5bxB/20ivc8tE/YuFG/O12RJ8P1JzM+QKwB7bsk6zwzmdSM7qHgNHi0yCf1W8C7R664O86z4Qj/EWpkB9ufDW9y0Dy+oGH6wgKgtwkvE7IuQt1fymLqF4quvciv3IjTUJLur1P6zne8y6JDQMGMHTHxQHMBnLmyLDNUkkObLKEtvdfIzX8C/cqdBf1b+zQFvLhnkp+I5x+tfOjUiKMBuVwwi2CiUx+8c6PlUZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUMQmwYAMagt0SFHaPo7hVRrJuFvcqyvgt+AfgA8ZAY=;
 b=kVpxbJJ5H6XlgULg0MqT3I2VLHo++GZCs7tHelpxOAsA5nMVRQUhj3RqsWhzbSgiBguthMN3D419tDKIlYJDz4HcEwyjLDFuM8J153+aLjhKUulW/vL4KtIRb3AmQEB0Q1AM8PysaqqnaW9rS6Sr9ifwqLghPu9D+3La6E3iWYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 14:06:26 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 14:06:25 +0000
Message-ID: <82e24013-41de-4f7e-8267-377b39622b3c@amd.com>
Date: Thu, 16 Apr 2026 10:06:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] add SPM profiling feature
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Bing.Ma@amd.com, David.Francis@amd.com
Cc: Jesse.Zhang@amd.com, Jenny-Jing.Liu@amd.com
References: <20260324212030.822932-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::15) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc8720b-db64-4262-fc5d-08de9bc158e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: W6+Nnumenu/cbpgQrNa/AxP2LJ/T2gTEVGQHcu+5ecTNdi3LxxNTmgKH4VZRkJXiV234j0j5XanUQn/DiPBsCr9mQAtQ1xYEGWnlNfRHVDWmItTUF0m0Xd10hMGvZXrzxiVtewkuBPtbT8q7Zg+VJ1VlkXE9FNR1gYTjJYH+hLE0A/Uz7I5TNJ4TLw+EBacuPP4HAQcU27cxFHToMKKf4DYW8X5Y7TVmIXIUw4hmObp6eVv4hJ+mHfD7qCu6yZ4HhozBgohG7oUMO0yuLnGlN1d33m8xax1sisbwLAexwYU9sUIdXY+3CqVrvn3wdcM9vBM7+6mm8EgxeO4QdHyRy4OoUvWW5AZuIEVfOe/Hp9UWXI6FxBacvzNH9Gofww7GN1L24AJlXfhXO/J303JDWoQYg24eXN0CD6LRIvzAK8vJ2/FBQ9QfLLiz7KdIkmuh5q0ejlj96/XUaNAnNvi0mUlzHfGqPJXOouFKSncjBQSX5gZ9qxFsU1YOMwG43SWjGzsF8ROs15fkj7vCYFBhIETtMtb1BO4vRT5wMN/2zr7hP257d2FJ0LX7k4XGgnNUTg58TP+dNk8dhjoTfCKqwV2F6jK5K4cFjLuMz4XjM7lTFw8+LT4SFdHynE79/Z+zr4pLgrWIrxA/DFFNHBP4e7ZUPnRKPQOUt3pvDw5stXX25d5jhEC9GR8cn7G4ACglNLc8CptouL/1xpKeUpExm3R8qkvcVByOgBqfOlLhSt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBnRWdKUEVUMmpKcjJJT1pqdVloWHlVL0x4MEZFSThWTFFtQnZBelVYb2ZC?=
 =?utf-8?B?cTdBVEtpYXYxRktJQlBERDZXUFZKa25laTJ0dVAvNG1vWmdEMkw3Y1RiREIw?=
 =?utf-8?B?a01MbnFTWkhTNmtmNWwzMHNraGpFQkVBSkRvSWhRcVU3cGJXSFdHZDg2OWRz?=
 =?utf-8?B?RExOVG1uM25BZVVscURlcW9iRGEyVlI1eGFMSmFjbkJWRmZVVmN4QkpEZ0hT?=
 =?utf-8?B?UUJuU3BOQlZURm4xZnFsYnE4TytXVFdMSjA1Nnk1cGkvWlY2UElqQ2t2Uloz?=
 =?utf-8?B?KzRIdEh3dDNRQ2s2N3hYSmoxTWt2WUlOU2J0TkFQczA0S3JoampaSTNqZFNG?=
 =?utf-8?B?NFhZZFJWL0I3NW9XK01RTXN6czdxQzF1aTlaVXJtTytMcVh5UW4vYnIwOTB0?=
 =?utf-8?B?Z0RoMDJJS0p1UlpSSDNSb0xKcnQ1M3Y5dFVlcGxBazFnU283WC9ScHV0SFlm?=
 =?utf-8?B?QkZYc1NHZ2dqY0VQdUR2MHJOZ1NXTWJkQ3FJeGZvd3ErMjBYaGdjQU4xZURE?=
 =?utf-8?B?Zkw3Zm42MEV2cGRlTmplMjhMUkVVRm1sVFk3YlNqdXhVMWlrZDRsR3luK1pj?=
 =?utf-8?B?cVZpMFdGaWUzWTQwUmRWa3dSd1RrbUgxS3BHS1ZFZ1I5Y0UrTDFZbEd4UE5v?=
 =?utf-8?B?aWZzM25lb0RSRVNic1ZsWXlwblNCN0RmMFY0YjZVVHRaaUpOaUd2RzQxcXJv?=
 =?utf-8?B?OTFheThhRVdabFJDM1BDRXlLNUFkdGhFVTN0WUZmRUhtWXpGWWZGanViMWlx?=
 =?utf-8?B?Zm55N012aWFHSW5md25rZHVlTytseG9JTnNwSW02SlRUYkw3OVByczJsaHFu?=
 =?utf-8?B?emJMZmtPQjl0b3QyYTVPN2JVYmZhc093NVZZbXROWGp0d1FIU2xQRjdWTlFw?=
 =?utf-8?B?Yy9UTnNrVW94NjZNVlpjb2VPd2tVeEN0cjBYbGhsd3BNOGFjSU4xTVNhejl1?=
 =?utf-8?B?ZnFHRnZQMmFWajRiKzRpQVpzY214cDV4NGd6YTVOVEJKUVdGYlpHcG1VYzNS?=
 =?utf-8?B?cDF5NXQ1aFFhRGE0N0VnSTE4elFtYzdvd24vR1dIL2d2aUZydU5abTJHcVoz?=
 =?utf-8?B?MVpIMEg2WXI1MjF5NW5rVmlKY2I5UDRUS3dVQW5EajgxbTB0bjAvdTVUWGYr?=
 =?utf-8?B?ZEJIM3RBb0duOGJGUmNwVHBkcThoU2xSMCtZM1BKdlVJTHBGZUVpTnBPREl6?=
 =?utf-8?B?NXQyeU5RUStGVEdoYWxDQUw2NTRGQ1lpVG9Qa1ZBczMxbjlQM0hNM3kwbXoz?=
 =?utf-8?B?T1hmSkFEc2dlZ1ViS0Vmd3A1VDI5MjZLanE5bExQTUo1SHVVT3dCa28rL081?=
 =?utf-8?B?TUN0MjNSSGhTbnV1LzMvdzNudjJldHM5NkxHNk5RcjZRTTA0bk81d1J3c0px?=
 =?utf-8?B?RlMwd1BHNlErTkhZZyt0NVovUVJ5L3VLZ1Rqd1ZvcGdQZzBKN2FOQWc5aXho?=
 =?utf-8?B?U1FDODdSdmpWUi9GZmlIY2xaaVVzT2tpeUFkQmlEY1FINGlPdjNjR2NvbWFj?=
 =?utf-8?B?U3I2ZGdLWENsc3FKYktLYXhValJINUhNVVRrSHJoUWJiYVA0MzFZQ1NSVGU1?=
 =?utf-8?B?YzNzelNhaGFDS01XZWVEM0hheURxVmhCRFlHZkY5TTdGZXZkc0ZtT3ZCRGpk?=
 =?utf-8?B?S0p4dnV6d0ZWUUJuZXZ0Ni9Jc2JxSGc4NER2eGE0OEFIZzkvOUlIK2hUVVJF?=
 =?utf-8?B?VXg4SDJmam5mNlNXbXJmRldKSG9iVEorMGI3YWZOb2F4YlRPU2VGT0dZSk96?=
 =?utf-8?B?U0JkVTJ2TThBaHV6WUxoVlFuNnBVbFI4Q2o3M3Z6djRGcTZxWVB5U2I3azJD?=
 =?utf-8?B?N0ZVRiswNnlTRWdVQVh1eXJmM1lOVkxFQkl1cSthdnl2ckEvN1IzaS9udWtM?=
 =?utf-8?B?SjZCM0JmNVk2NzVlbllVOUZ2UGdoMkd1WVJsWTdScC9uVlVCMnhWaVdWdzZP?=
 =?utf-8?B?cUtmak10bzVCaU9pTkJ1T3dpTFpreFVOck4zOFcrbzVEcFJNTnBtWnBIM1hr?=
 =?utf-8?B?U0xjclI1b3JMWkVDdGIxR1llK3dWWGlLMVdMU2J3M2piYnMzR0dad096R21C?=
 =?utf-8?B?UVNyM0xOS0NCQWxTeklobVlrZGpOOW1yck1KQjMzV3YyUFoxYmRSUHppaDN5?=
 =?utf-8?B?eThDUm84RjFtelZQUTRhV1R1OUpSUXphYzRIVVhRR1g5eUVYRm16c256QVgr?=
 =?utf-8?B?djhoWHNFeVQ3Nm5nY2s2cVlOdjEzVGRqZ29zWGN2aVREWThjUmdWelJCa3VT?=
 =?utf-8?B?NHBLdHRIY3NiSnBZL0duUXhiU2RrREV2dU9jZjBlb09UaDVZQzNuU3h3ODd3?=
 =?utf-8?Q?wFmNJYsuHr2tOetUqw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc8720b-db64-4262-fc5d-08de9bc158e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 14:06:25.8581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JyWjTAWEQbaiLGQq7SLUqo3KkJNaJEPVbqK1Pnni7SsX+/CoCtC2d3hxcRdc7hz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931
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

Ping ...

On 2026-03-24 17:20, James Zhu wrote:
> SPM stands for Stream Performance Monitor which can collect
> stream counters through RLC (Run List Control) Hardware block
> to profile application stream.
>
> -v2: add more descriptive commit descriptions
>       move new GTT memory alloc/free to amdgpu_object
>
> James Zhu (17):
>    drm/amdgpu: add UAPI to support profiler
>    drm/amdgpu: add profiler manager initialization and release
>    drm/amdgpu: implement profiler ioctl
>    drm/amdgpu: add UAPI to support profiler/SPM
>    drm/amdgpu: add amdgpu_bo_alloc_gtt_mem and amdgpu_bo_free_gtt_mem
>    drm/amdgpu: add RLC SPM interface to
>    drm/amdgpu: add profiler/spm manager initialization and release
>    drm/amdgpu: add profiler/spm interrupt handler
>    drm/amdgpu: add profiler/spm ioctl
>    drm/amdgpu: add profiler/spm operation AMDGPU_SPM_OP_ACQUIRE
>    drm/amdgpu: add profiler/spm operation AMDGPU_SPM_OP_SET_DEST_BUF
>    drm/amdgpu: add profiler/spm operation AMDGPU_SPM_OP_RELEASE
>    drm/amdgpu: implement data dump from spm ring buffer
>    drm/amdgpu: workaround for spm ring buffer overflow
>    drm/amdgpu: workaround for hw stall issue
>    drm/amdgpu: add profiler/spm support for gfx9
>    drm/amdgpu: add profiler/spm support for gfx9_4_3
>
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |  12 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  97 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |   5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 120 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  73 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c      |  93 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h      |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 703 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  77 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       |   1 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 135 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c      | 194 ++++-
>   include/uapi/drm/amdgpu_drm.h                | 110 +++
>   18 files changed, 1625 insertions(+), 14 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
>
