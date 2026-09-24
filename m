Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38780C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 15:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B863D10E1B5;
	Thu, 24 Sep 2026 15:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qoCtUjHO";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8096E10E1B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 15:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqGCKllYIHM+lrksN3pFW3vdGU3o363eWzgh6t7TBIiIoRRquBLdeFGhoqdKRjhXo8+suBe0HuFEoC4Q18VUcljKE5H5K8YCc+7AHAJXW/j5+lvRIXL1KRa2dNASAGv5IgyqhOZMFJFTHbHmrnZEUPhDoOCRyFaXTo9YtfpU3tWWjvDAoCPbsBh3EbX6F4YJsFHMj716mC3OSIZ7qq2pEiRc07lh2BuxUJrvfJV/2HwoKSVnmti2Nj3ZnzA6rEH9FoImb+CIH3i0ite/zt5EWGn9n+T6Tpy2zRs0ejPpG8GTODs6a1EV7sy6ob8nZbW/BnI+DAC4jbGnWQV3LZyAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQDgYMJ5Clhkg/wbRb5iVX7AP/52z33tPYilTJHwszU=;
 b=Bh1fXQs7QHP0Q8tT7NAwVIn5AgsHeo/ozGfcXWxXQ+BJuQAn13hheGL6B0EDQ5P6BII4FKnwmlKIUkAah8H3+pKLtKhT8Cak5QbfUQYkMP2/GXAgMcOZsJ4XmlOfUkqWxmqcP0sVQDHh92dqfuk+SMRdhxyRDHy4NHZ/fLeeTiahz5NZidAO8HaZSHAVlYr/c5TZ5xVMrtr1L64Llpk4E1iDKGl9u2AVCEIJ0Mm4JGMNK3NWyfz3wyEiQU4LBBblaUO0M5KyCMeRb1HQMjvvg/0C9LlKM02WfgdqqnVb6ljWgMj5hpP/4nJD92y+K+u7OTIKRTaiRJfWPCaGKDByow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQDgYMJ5Clhkg/wbRb5iVX7AP/52z33tPYilTJHwszU=;
 b=qoCtUjHOph0FdBNRK9VA/9dUotUbaA5iLpTfr7Pmy+3vO3ulVxf8hd0urbI5h6AQ2S9BLkCwMBof4EScfxKtALJc55DKLo9wOhAaxqhxSx4UrG4072wEzPk5OzwW0FYDGrFPyA721HlBNgeE1rGqrPtUzzQa0Qre/1uwEcNhqCg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 15:49:09 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 15:49:09 +0000
Content-Type: multipart/alternative;
 boundary="------------F7aKMjQYcLyxhlL4wUJhjH8C"
Message-ID: <e1456c80-ead8-4453-ad12-46e3bf467b40@amd.com>
Date: Thu, 24 Sep 2026 11:49:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] drm/amdgpu: implement PMC ioctl framework
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-2-lingshan.zhu@amd.com>
 <a8011684-b04b-4483-b05c-d547c1f4f86b@amd.com>
 <e662808d-e525-48fe-a5f3-3409b1d19e02@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <e662808d-e525-48fe-a5f3-3409b1d19e02@amd.com>
X-ClientProxiedBy: YT4PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::26) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 7601c7e5-9608-44dc-2569-08df1a535f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|4143699003|3023799007|6133799003|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KTTU0+qETpyHCvsmZsoczl1T0mTxOb975EGQlB82X9ARtDFLQZ8vgH0I+2KZRS+5nrVUN9DAxkWeQzr1zcHHxCCFTPO4iPiDDqIrzgRMbNfJE9knRgybJhU9IC7VtV2GzCuUh2i2GDgQSc0AApuLydflDKxhrAlmH/oR8EPOe2il/SXrhWnGxk4oyUxFn3egjTPFL+IAH6i8qeDSENqrpdrNCsN04hsdnqO6h2zaGq8tR6t/SGYkhHr3eymaL/5XLCaiabZ5Q8l6Bc61+KVMlOWw4HbrwPeNOfX3AP4j3kXbgolb20FaLrpI7glq3ijMAB5N67RBbwzs1DSePF/XkmZ3/KYgnKM6ZScn7IsV8GeCpGGK7hlVQXgkpJ9/gi/hB82NKAXhW65eI+dcJmULbRGGmY9KjrqdDtIM6rC3Ardo6vabmGNcF5CtdN645dH9l5tt/8lz6TeL90SckvO4BuP0Zl7TDhMKPaQ/dq3aZMBh+2UipZmV6rUAAaA6LtjqDb+mCFmlje6Ax0X2L34In9Kgizbss/CSz2gXJ7MUAUWbo2sjEEIOa0ac5cgUP5xCYgPIMb1nMYfg2Ns3Uc2zx6EkoCrq5lYyTleIdQhDRHsOjY0hYO8ckglauaTEi124a8ZjB18zMPO2P8GvHdU3NA8+QYzPpbcQHB83fYmXFow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5pTkRyQi9ielZSdjlVY0ttRlIvOXFWUXZJZUpGaXpXbm9pSUZpK3pLZmg0?=
 =?utf-8?B?emZ2b1dSOEZtWHUwcS80R3U2S1piNktRQmdJbHAwdlVvZDNXZDNOeDg1NHEz?=
 =?utf-8?B?bzRaVEZPR2poc1B1TGNXem9sdHFoblBCTENqWW1HdU81bTlpTlllVyt0OWho?=
 =?utf-8?B?WmNxZU9tODRLUk1OM2lFMlF4M0dKNFJDV0ZUb3pVdUpUdjNscnNFTFZwWndn?=
 =?utf-8?B?TW0rYjZIRmlPNlFTOEN6Y0p3SXRIdGhSSlBob2NjNFA5QTBFWFloS084NEJX?=
 =?utf-8?B?cnZyb1JkYnUycEFZU0NDd2cxb29BdDRob2twWEJvQXNHR0h2cldoWC9ZYWZl?=
 =?utf-8?B?c2NYblZOdTFqbmthTjhzVUp4dDZFYjd3cG81KzFWYloxNXpabDBZRXYwZlRv?=
 =?utf-8?B?WXA2WGNBOXJLUWo5NktrMTI5VVNkSkxvYWtFOUYwZ24zOEh4NVdaditDT1R0?=
 =?utf-8?B?OEc0c3Q5V1lsQTdlMnMwcFFOc0FNUzhPa0twcXFhNXZSNGRVcnhSUDV5cVhy?=
 =?utf-8?B?cGg2WEJONVR4dU1WNFJvT1h1K1ROV2w5V1JjUTJvQ1NsdHpHWWFpaXZuMGdC?=
 =?utf-8?B?cmRHbmJqS2I3SkNIMXZuS1B4cTA3eStPNmRkdGJrbzBNeEdPVkxzaGJKTTNJ?=
 =?utf-8?B?eHNVaTJBVVhCcGR0RGNwb0dRdk0vdDQ4YW5DN285S3F1Mmg1T1AxaDhIMUFQ?=
 =?utf-8?B?ZEZaSkFtdnBvNTJRMEtRY3FFSkViUm5iU1hoS0VPNFRkMTlaSi9FVnNRTzB6?=
 =?utf-8?B?NUI4d2s2RUo2OUV2OHVpVVB6UkdCZVFNRlVOYnU5eSt0cVZsYlBob0krRlhn?=
 =?utf-8?B?YlV4MStIS2NkMzd0alJ1MFpsWE93dVd5ek5pRlZNZVJ5TksvZHFuZzlRQnQr?=
 =?utf-8?B?Z0F0QytBci9GL1FUcXhtdHF3R29tVVVxelI1M3U0NFRCemMyMlVhamlkS0Jk?=
 =?utf-8?B?SGRhVXJ1bXlxZlpoQ093ekhkeFBvYTROa2Z0Unptd0pKV3pRWENidzZwZm9s?=
 =?utf-8?B?SytQNkwwV3J4LzZPTXRYVW52OWx1NXhuR3dISCtiTWJIQldPTWJjQVhOL2Nv?=
 =?utf-8?B?YTZhSDVIVlVzRHR2QVdpSTJTMTIvZ0FReEh2LzFLYkp3bFQ1d0tGNUhKV2kv?=
 =?utf-8?B?VG5yK0NBSERDRExRZUNOTWxXWGJWdVQvcG1WcmYrSUZRWXlnNU1FS3NaS0Ri?=
 =?utf-8?B?VjhwR2FKSytwcHArRk9kRjZUWmZzZVl3VkkxVHFmOHFxbThuT2Z4VXBnRzN6?=
 =?utf-8?B?RHc3dnN5alpoVnRQamd0THlJLys0M0hyL1JDeFh6cE5QTHBkRnRUdXJYQmlJ?=
 =?utf-8?B?WXBZSThpV1BaYmI3NlE2ZFEwYkl0UXJ2c3JucUw4US9ZOWViRGN2MFlycHFM?=
 =?utf-8?B?Rmg4Q2t0QTlNNXFISjNwdStoVzBkSVQ3anArdVk3Y0kyOTg2bVMrMEVLdVN3?=
 =?utf-8?B?b0ViV3FMN2EzeFhLcjl1Z2NGc3A5bkMvTmtNeWJPSVdzTXpKZEtFVXBPQUlW?=
 =?utf-8?B?QkhyU2pJUEdVRkhtKzZmRGsvR3lmb3Q3dVU2RjNYNm5Fa1UweGxnYWxwMzVv?=
 =?utf-8?B?OUFKa2lEaCsrODRuM3VaQnZ5NUFUeHJqU3FXMmJTaEg3S2oyakRIN0Mzc0ND?=
 =?utf-8?B?ZGxvZnhNMjI3YkRmNnU0UnhyalpmSzFlRFZEd2VHN1Bnbkp3Qmdoek1OSkM1?=
 =?utf-8?B?VG5idjJhcWJ0dXFPTWM5VmZ3NW5wRXh6ZDN1RjAraTlqbGJ0dFhDS1ZaMGhy?=
 =?utf-8?B?ZWM5NnVkSGtvZG92V0w3R3p5bUdvYTFFR29HQllDT1FTRkd3a0VkdkxtS21y?=
 =?utf-8?B?akQrY0poM0IrZVcyNFJLYTRyOVFqaUFtM09IK096b2t3dHpyV1IwOXhOTHBi?=
 =?utf-8?B?b0diM0lRODlBSm1BR0txSXQvalFUQUJzYW9Sa3ZRZ1pSajlJc25Bd1d3YTM1?=
 =?utf-8?B?SXRmVmczMkt3U0h6RGlreDI5MElEUnY5VnAzcXFyM3U5RGVYZkVaWGlhd0hS?=
 =?utf-8?B?ZjQzd3FrRkdReFRiMHFtK0wxMGFZNFBzeCtzSFJTTkFkeEdSYlRLaFQwUmNO?=
 =?utf-8?B?YkU2SDVUMWhBbVFNcTVQVHBabVVaK2tEaGJJS3hiNFlFaWNXS3VXSmpjb1VB?=
 =?utf-8?B?Ukw0b0xkRTl5SjBBTDVLRlNpYTBMZjBCak5zZlF1SUZVbXB5ZE9pUDF4MDZ4?=
 =?utf-8?B?ellxbGJvb1Z1cGc3WXZSOS9qRGFuWHVOb3N6NjJiYWdKLzhOZ0o1YVZRc0dl?=
 =?utf-8?B?eXFCTFF5bmsxTGFnNU01ZG9rajVsdi9qM3E0S3NmYWttVHhiNjZKQ1Zoc1BY?=
 =?utf-8?Q?ddkF4VgkvGm4GP2TU9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7601c7e5-9608-44dc-2569-08df1a535f72
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 15:49:09.7348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5SXq71o4nfqBGDcN+DG1NzHUdQYUWVR+JHus8taEc8HQZdPTC2CsduRc2/LOBXg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945
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

--------------F7aKMjQYcLyxhlL4wUJhjH8C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-09-23 23:38, Zhu, Lingshan wrote:
> On 9/23/2026 10:17 PM, James Zhu wrote:
>>
>> On 2026-09-22 05:34, Zhu Lingshan wrote:
>>> This commit implements basic ioctl framework for PMC,
>>> including basic operations.
>>>
>>> This commit also implements AMDGPU_PROFILER_OP_VERSION
>>> which report profiler version to the user space.
>>>
>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  2 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 44 
>>> ++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 33 +++++++++++++++
>>>   include/uapi/drm/amdgpu_drm.h                | 36 ++++++++++++++++
>>>   5 files changed, 116 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 6fb0a913e33b..d7db69e9d6a0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o 
>>> amdgpu_doorbell_mgr.o amdgpu_kms
>>>       amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o 
>>> amdgpu_lockdep.o \
>>>       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o 
>>> amdgpu_dev_coredump.o \
>>>       amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o 
>>> amdgpu_ip.o \
>>> -    amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
>>> +    amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_profiler.o
>>>     amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 7c473f60bd28..a98c4a47e196 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -55,6 +55,7 @@
>>>   #include "amdgpu_cwsr.h"
>>>   #include "amdgpu_userq_fence.h"
>>>   #include "../amdxcp/amdgpu_xcp_drv.h"
>>> +#include "amdgpu_profiler.h"
>>>     /*
>>>    * KMS wrapper.
>>> @@ -3096,6 +3097,7 @@ const struct drm_ioctl_desc 
>>> amdgpu_ioctls_kms[] = {
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, 
>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, 
>>> amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, 
>>> amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> +    DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl, 
>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>   };
>>>     static const struct drm_driver amdgpu_kms_driver = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>>> new file mode 100644
>>> index 000000000000..04902696adab
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>>> @@ -0,0 +1,44 @@
>>> +// SPDX-License-Identifier: MIT
>>> +/*
>>> + * Copyright 2026 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to 
>>> whom the
>>> + * Software is furnished to do so, subject to the following 
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#include <linux/errno.h>
>>> +#include <drm/amdgpu_drm.h>
>>> +#include "amdgpu_profiler.h"
>>> +
>>> +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, 
>>> struct drm_file *filp)
>>> +{
>>> +    struct drm_amdgpu_profiler_args *args = data;
>>> +
>>> +    switch (args->op) {
>>> +    case AMDGPU_PROFILER_OP_VERSION:
>>> +        args->version = AMDGPU_PROFILER_VERSION_NUM;
>>> +        return 0;
>>> +    case AMDGPU_PROFILER_OP_RESERVE:
>>> +        return -EOPNOTSUPP;
>>> +    case AMDGPU_PROFILER_OP_PMC:
>>> +        return -EOPNOTSUPP;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>>> new file mode 100644
>>> index 000000000000..c27b5f9b3ff0
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>>> @@ -0,0 +1,33 @@
>>> +/* SPDX-License-Identifier: MIT */
>>> +/*
>>> + * Copyright 2026 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to 
>>> whom the
>>> + * Software is furnished to do so, subject to the following 
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#ifndef __AMDGPU_PROFILER_H__
>>> +#define __AMDGPU_PROFILER_H__
>>> +
>>> +#include <drm/drm_device.h>
>>> +#include <drm/drm_file.h>
>>> +
>>> +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, 
>>> struct drm_file *filp);
>>> +
>>> +#endif /* __AMDGPU_PROFILER_H__ */
>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>> b/include/uapi/drm/amdgpu_drm.h
>>> index 9222be9a6d2a..acc63804ba8c 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -60,6 +60,7 @@ extern "C" {
>>>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>   #define DRM_AMDGPU_PROC_OPTIONS        0x1A
>>>   #define DRM_AMDGPU_CWSR            0x1B
>>> +#define DRM_AMDGPU_PROFILER        0x1C
>>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>> @@ -83,6 +84,7 @@ extern "C" {
>>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES 
>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct 
>>> drm_amdgpu_gem_list_handles)
>>>   #define DRM_IOCTL_AMDGPU_PROC_OPTIONS DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>>>   #define DRM_IOCTL_AMDGPU_CWSR    DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
>>> +#define DRM_IOCTL_AMDGPU_PROFILER DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>>>     /**
>>>    * DOC: memory domains
>>> @@ -1809,6 +1811,40 @@ struct drm_amdgpu_proc_options {
>>>       } kfd_sigbus_delay;
>>>   };
>>>   +#define AMDGPU_PROFILER_VERSION_NUM    1
>>> +
>>> +enum amdgpu_profiler_ops {
>>> +    AMDGPU_PROFILER_OP_VERSION = 1,
>>> +    AMDGPU_PROFILER_OP_RESERVE = 2,
>> [JZ] the implementation tells that it is 
>> AMDGPU_PROFILER_OP_PMC_RESERVE, it is better to put it under new PMC 
>> sub-ioctl op
> Do you mean implement it like {bool pmc_enable, bool reserve} in a struct? I am not sure it is a good idea
> and this reservation design is a improvement. Because it separates the reserve(lock) and unreserve(unlock),
> so we don't need to keep the reservation during the PMC operations in a complex way, and we won't meet
> the problems like how to handle the situation where the user tries to unlock but keeps enable = 1.
[JZ] profiler includes PMC, PC sampling, SPM etc. do the other feature 
need reservation also?
>
> Thanks
> Lingshan
>>> +    AMDGPU_PROFILER_OP_PMC = 3,
>>> +};
>>> +
>>> +enum amdgpu_profiler_reserve_ops {
>>> +    /* release the device resertaion, only the reservation owner do 
>>> this */
>>> +    AMDGPU_PROFILER_RELEASE = 0,
>>> +    /* reserve the device profiler */
>>> +    AMDGPU_PROFILER_RESERVE = 1,
>>> +    /* Clear the device profiler reservation, in case the reservation
>>> +     * owner can no longer release the reservation(e.g., it crashes),
>>> +     * This operation does not take the reseration nor touch 
>>> profielr state
>>> +     */
>>> +    AMDGPU_PROFILER_CLEAR_RESERVATION = 2,
>>> +};
>>> +
>>> +struct drm_amdgpu_profiler_args {
>>> +    /* enum amdgpu_profiler_ops */
>>> +    __u8 op;
>>> +    __u8 pad[3];
>>> +    union {
>>> +        /* AMDGPU_PROFILER_OP_RESERVE: enum 
>>> amdgpu_profiler_reserve_ops */
>>> +        __u8 reserve;
>>> +        /* AMDGPU_PROFILER_OP_PMC: 1 enable PMC, 0 disable PMC */
>>> +        __u8 perfcount_enable;
>>> +        /* AMDGPU_PROFILER_OP_VERSION: AMDGPU_PROFILER_VERSION_NUM */
>>> +        __u32 version;
>>> +    };
>>> +};
>>> +
>>>   #if defined(__cplusplus)
>>>   }
>>>   #endif
--------------F7aKMjQYcLyxhlL4wUJhjH8C
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-09-23 23:38, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:e662808d-e525-48fe-a5f3-3409b1d19e02@amd.com">
      
      <pre>On 9/23/2026 10:17 PM, James Zhu wrote:</pre>
      <blockquote type="cite" cite="mid:a8011684-b04b-4483-b05c-d547c1f4f86b@amd.com"> <br>
        On 2026-09-22 05:34, Zhu Lingshan wrote: <br>
        <blockquote type="cite">This commit implements basic ioctl
          framework for PMC, <br>
          including basic operations. <br>
          <br>
          This commit also implements AMDGPU_PROFILER_OP_VERSION <br>
          which report profiler version to the user space. <br>
          <br>
          Signed-off-by: Zhu Lingshan<a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;lingshan.zhu@amd.com&gt;</a>
          <br>
          --- <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +- <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 + <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 44
          ++++++++++++++++++++ <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 33
          +++++++++++++++ <br>
          &nbsp; include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 36
          ++++++++++++++++ <br>
          &nbsp; 5 files changed, 116 insertions(+), 1 deletion(-) <br>
          &nbsp; create mode 100644
          drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c <br>
          &nbsp; create mode 100644
          drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
          b/drivers/gpu/drm/amd/amdgpu/Makefile <br>
          index 6fb0a913e33b..d7db69e9d6a0 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/Makefile <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/Makefile <br>
          @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o
          amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o
          amdgpu_lsdma.o amdgpu_lockdep.o \ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o
          amdgpu_dev_coredump.o \ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_cper.o amdgpu_userq_fence.o
          amdgpu_eviction_fence.o amdgpu_ip.o \ <br>
          -&nbsp;&nbsp;&nbsp; amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o <br>
          +&nbsp;&nbsp;&nbsp; amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
          amdgpu_profiler.o <br>
          &nbsp; &nbsp; amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o <br>
          &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c <br>
          index 7c473f60bd28..a98c4a47e196 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c <br>
          @@ -55,6 +55,7 @@ <br>
          &nbsp; #include &quot;amdgpu_cwsr.h&quot; <br>
          &nbsp; #include &quot;amdgpu_userq_fence.h&quot; <br>
          &nbsp; #include &quot;../amdxcp/amdgpu_xcp_drv.h&quot; <br>
          +#include &quot;amdgpu_profiler.h&quot; <br>
          &nbsp; &nbsp; /* <br>
          &nbsp;&nbsp; * KMS wrapper. <br>
          @@ -3096,6 +3097,7 @@ const struct drm_ioctl_desc
          amdgpu_ioctls_kms[] = { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT,
          amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW), <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES,
          amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW), <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS,
          amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW), <br>
          +&nbsp;&nbsp;&nbsp; DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl,
          DRM_AUTH|DRM_RENDER_ALLOW), <br>
          &nbsp; }; <br>
          &nbsp; &nbsp; static const struct drm_driver amdgpu_kms_driver = { <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c <br>
          new file mode 100644 <br>
          index 000000000000..04902696adab <br>
          --- /dev/null <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c <br>
          @@ -0,0 +1,44 @@ <br>
          +// SPDX-License-Identifier: MIT <br>
          +/* <br>
          + * Copyright 2026 Advanced Micro Devices, Inc. <br>
          + * <br>
          + * Permission is hereby granted, free of charge, to any
          person obtaining a <br>
          + * copy of this software and associated documentation files
          (the &quot;Software&quot;), <br>
          + * to deal in the Software without restriction, including
          without limitation <br>
          + * the rights to use, copy, modify, merge, publish,
          distribute, sublicense, <br>
          + * and/or sell copies of the Software, and to permit persons
          to whom the <br>
          + * Software is furnished to do so, subject to the following
          conditions: <br>
          + * <br>
          + * The above copyright notice and this permission notice
          shall be included in <br>
          + * all copies or substantial portions of the Software. <br>
          + * <br>
          + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY
          KIND, EXPRESS OR <br>
          + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
          MERCHANTABILITY, <br>
          + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN
          NO EVENT SHALL <br>
          + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
          CLAIM, DAMAGES OR <br>
          + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
          OTHERWISE, <br>
          + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
          THE USE OR <br>
          + * OTHER DEALINGS IN THE SOFTWARE. <br>
          + * <br>
          + */ <br>
          + <br>
          +#include &lt;linux/errno.h&gt; <br>
          +#include &lt;drm/amdgpu_drm.h&gt; <br>
          +#include &quot;amdgpu_profiler.h&quot; <br>
          + <br>
          +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data,
          struct drm_file *filp) <br>
          +{ <br>
          +&nbsp;&nbsp;&nbsp; struct drm_amdgpu_profiler_args *args = data; <br>
          + <br>
          +&nbsp;&nbsp;&nbsp; switch (args-&gt;op) { <br>
          +&nbsp;&nbsp;&nbsp; case AMDGPU_PROFILER_OP_VERSION: <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;version = AMDGPU_PROFILER_VERSION_NUM; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
          +&nbsp;&nbsp;&nbsp; case AMDGPU_PROFILER_OP_RESERVE: <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP; <br>
          +&nbsp;&nbsp;&nbsp; case AMDGPU_PROFILER_OP_PMC: <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP; <br>
          +&nbsp;&nbsp;&nbsp; default: <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; <br>
          +&nbsp;&nbsp;&nbsp; } <br>
          +} <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h <br>
          new file mode 100644 <br>
          index 000000000000..c27b5f9b3ff0 <br>
          --- /dev/null <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h <br>
          @@ -0,0 +1,33 @@ <br>
          +/* SPDX-License-Identifier: MIT */ <br>
          +/* <br>
          + * Copyright 2026 Advanced Micro Devices, Inc. <br>
          + * <br>
          + * Permission is hereby granted, free of charge, to any
          person obtaining a <br>
          + * copy of this software and associated documentation files
          (the &quot;Software&quot;), <br>
          + * to deal in the Software without restriction, including
          without limitation <br>
          + * the rights to use, copy, modify, merge, publish,
          distribute, sublicense, <br>
          + * and/or sell copies of the Software, and to permit persons
          to whom the <br>
          + * Software is furnished to do so, subject to the following
          conditions: <br>
          + * <br>
          + * The above copyright notice and this permission notice
          shall be included in <br>
          + * all copies or substantial portions of the Software. <br>
          + * <br>
          + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY
          KIND, EXPRESS OR <br>
          + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
          MERCHANTABILITY, <br>
          + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN
          NO EVENT SHALL <br>
          + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
          CLAIM, DAMAGES OR <br>
          + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
          OTHERWISE, <br>
          + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
          THE USE OR <br>
          + * OTHER DEALINGS IN THE SOFTWARE. <br>
          + * <br>
          + */ <br>
          + <br>
          +#ifndef __AMDGPU_PROFILER_H__ <br>
          +#define __AMDGPU_PROFILER_H__ <br>
          + <br>
          +#include &lt;drm/drm_device.h&gt; <br>
          +#include &lt;drm/drm_file.h&gt; <br>
          + <br>
          +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data,
          struct drm_file *filp); <br>
          + <br>
          +#endif /* __AMDGPU_PROFILER_H__ */ <br>
          diff --git a/include/uapi/drm/amdgpu_drm.h
          b/include/uapi/drm/amdgpu_drm.h <br>
          index 9222be9a6d2a..acc63804ba8c 100644 <br>
          --- a/include/uapi/drm/amdgpu_drm.h <br>
          +++ b/include/uapi/drm/amdgpu_drm.h <br>
          @@ -60,6 +60,7 @@ extern &quot;C&quot; { <br>
          &nbsp; #define DRM_AMDGPU_GEM_LIST_HANDLES&nbsp;&nbsp;&nbsp; 0x19 <br>
          &nbsp; #define DRM_AMDGPU_PROC_OPTIONS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1A <br>
          &nbsp; #define DRM_AMDGPU_CWSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1B <br>
          +#define DRM_AMDGPU_PROFILER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1C <br>
          &nbsp; &nbsp; #define DRM_IOCTL_AMDGPU_GEM_CREATE&nbsp;&nbsp;&nbsp;
          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
          drm_amdgpu_gem_create) <br>
          &nbsp; #define DRM_IOCTL_AMDGPU_GEM_MMAP&nbsp;&nbsp;&nbsp;
          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union
          drm_amdgpu_gem_mmap) <br>
          @@ -83,6 +84,7 @@ extern &quot;C&quot; { <br>
          &nbsp; #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES,
          struct drm_amdgpu_gem_list_handles) <br>
          &nbsp; #define DRM_IOCTL_AMDGPU_PROC_OPTIONS&nbsp;&nbsp;&nbsp;
          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct
          drm_amdgpu_proc_options) <br>
          &nbsp; #define DRM_IOCTL_AMDGPU_CWSR&nbsp;&nbsp;&nbsp; DRM_IOWR(DRM_COMMAND_BASE +
          DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr) <br>
          +#define DRM_IOCTL_AMDGPU_PROFILER&nbsp;&nbsp;&nbsp;
          DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct
          drm_amdgpu_profiler_args) <br>
          &nbsp; &nbsp; /** <br>
          &nbsp;&nbsp; * DOC: memory domains <br>
          @@ -1809,6 +1811,40 @@ struct drm_amdgpu_proc_options { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } kfd_sigbus_delay; <br>
          &nbsp; }; <br>
          &nbsp; +#define AMDGPU_PROFILER_VERSION_NUM&nbsp;&nbsp;&nbsp; 1 <br>
          + <br>
          +enum amdgpu_profiler_ops { <br>
          +&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_OP_VERSION = 1, <br>
          +&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_OP_RESERVE = 2, <br>
        </blockquote>
        [JZ] the implementation tells that it is
        AMDGPU_PROFILER_OP_PMC_RESERVE, it is better to put it under new
        PMC sub-ioctl op</blockquote>
      <pre>Do you mean implement it like {bool pmc_enable, bool reserve} in a struct? I am not sure it is a good idea
and this reservation design is a improvement. Because it separates the reserve(lock) and unreserve(unlock),
so we don't need to keep the reservation during the PMC operations in a complex way, and we won't meet
the problems like how to handle the situation where the user tries to unlock but keeps enable = 1.</pre>
    </blockquote>
    [JZ] profiler includes PMC, PC sampling, SPM etc. do the other
    feature need reservation also?
    <blockquote type="cite" cite="mid:e662808d-e525-48fe-a5f3-3409b1d19e02@amd.com">
      <pre>

Thanks
Lingshan </pre>
      <blockquote type="cite" cite="mid:a8011684-b04b-4483-b05c-d547c1f4f86b@amd.com">
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_OP_PMC = 3, <br>
          +}; <br>
          + <br>
          +enum amdgpu_profiler_reserve_ops { <br>
          +&nbsp;&nbsp;&nbsp; /* release the device resertaion, only the reservation
          owner do this */ <br>
          +&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_RELEASE = 0, <br>
          +&nbsp;&nbsp;&nbsp; /* reserve the device profiler */ <br>
          +&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_RESERVE = 1, <br>
          +&nbsp;&nbsp;&nbsp; /* Clear the device profiler reservation, in case the
          reservation <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; * owner can no longer release the reservation(e.g., it
          crashes), <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; * This operation does not take the reseration nor touch
          profielr state <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
          +&nbsp;&nbsp;&nbsp; AMDGPU_PROFILER_CLEAR_RESERVATION = 2, <br>
          +}; <br>
          + <br>
          +struct drm_amdgpu_profiler_args { <br>
          +&nbsp;&nbsp;&nbsp; /* enum amdgpu_profiler_ops */ <br>
          +&nbsp;&nbsp;&nbsp; __u8 op; <br>
          +&nbsp;&nbsp;&nbsp; __u8 pad[3]; <br>
          +&nbsp;&nbsp;&nbsp; union { <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMDGPU_PROFILER_OP_RESERVE: enum
          amdgpu_profiler_reserve_ops */ <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 reserve; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMDGPU_PROFILER_OP_PMC: 1 enable PMC, 0 disable
          PMC */ <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 perfcount_enable; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMDGPU_PROFILER_OP_VERSION:
          AMDGPU_PROFILER_VERSION_NUM */ <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version; <br>
          +&nbsp;&nbsp;&nbsp; }; <br>
          +}; <br>
          + <br>
          &nbsp; #if defined(__cplusplus) <br>
          &nbsp; } <br>
          &nbsp; #endif <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------F7aKMjQYcLyxhlL4wUJhjH8C--
