Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8409CA600A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F2610FC8F;
	Thu,  8 Oct 2026 07:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YmCnqvkw";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A02610FC8F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 07:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+B/M+m4Idd/QIugb1paVQHNM5KFfuKZVg9Czju09BXINrJaRx6ss1dPZF0gtNBJ9T7eMaNA+nW4jW56k/XZbZzBmuvV2DnVA6Phr+EL/3zWQ4IsT6aOYBZd2l0Xw+O+HobFgEWSGrwTVPfY6BOFbARoVhSCbpxIpne/rG8GiHsSlJdSeK0B0FzPQAg5znc8eosLyDqkdV9p2IvlT8jfnxo7fjUJXsIfmPSOoVKlM4XmX7ibO7+MPJi2Cn2Hx94WFiq+5exK1QONh6iimfPQLcxHUDrIEbQt9EMFg/SIQpGrpP5aZoQ+OsbH1yU4lYEFBKdgxXMyiYtBn1S8KphJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPJUoRFjF1pqPX6cL6oqG+oQ+BgByzpp9gD9LM2boq4=;
 b=gydtzOi2VNwO0c6wQtN5wytHaxCld70szHKa0ubRy9U6dK0pRPXKqugWn6+20TwFUJSdLhbkM9XoQlVdV6zHxaL5u7KsO+c5JPfREVVzaYjFvX662GSnP7W756MhNX+CcEp8iPkeUfSwd7yTNhLr5sHx36PJdhxBTPmfhzoGslvpH4z646a4YjTNbiK83saJd3oBBDbHk8PfX3VJWqiTg4ObJ8ePnAxZPHRHvPL+HC8l2UTviWlzqMq40jqgSPHTvprkP4XFZ1p8YS6Z6c5Cqekt1b4zOjEpg91Wi3k9AhNb+tzXBtAFRUfj9EyrHryb5xRtjMXmKYRrRh2LiwTGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPJUoRFjF1pqPX6cL6oqG+oQ+BgByzpp9gD9LM2boq4=;
 b=YmCnqvkwkKmcLSXJ7mk+tEVH9Tu2yg+uh/9z3tcTdkdz56Ru/I2ZKYalCb961ubRyfNNbZmbLrull+be7D32RhLvd6e/ZdpEfUWfVMkQ7DYAcLkS3MJOaOcNgUiyYE/6A4xctwRWDJpFCmhvZGQWMgG/ZTd2qsyhEEIsm3S5+MM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by EAYPR12MB999157.namprd12.prod.outlook.com (2603:10b6:303:2bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 07:59:34 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 07:59:32 +0000
Content-Type: multipart/alternative;
 boundary="------------cdYvgbebxsFEQlu8s8roFe8N"
Message-ID: <6befb9ce-4cac-4afc-91ad-ec7133ffb626@amd.com>
Date: Thu, 8 Oct 2026 15:59:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] drm/amdgpu: implement PMC ioctl framework
To: James Zhu <jamesz@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com, "Welton, Benjamin" <Benjamin.Welton@amd.com>
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-2-lingshan.zhu@amd.com>
 <a8011684-b04b-4483-b05c-d547c1f4f86b@amd.com>
 <e662808d-e525-48fe-a5f3-3409b1d19e02@amd.com>
 <e1456c80-ead8-4453-ad12-46e3bf467b40@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <e1456c80-ead8-4453-ad12-46e3bf467b40@amd.com>
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|EAYPR12MB999157:EE_
X-MS-Office365-Filtering-Correlation-Id: 56153530-098d-459c-786d-08df25121621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|8096899003|3023799007|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i2rCv4Qtxg+gCdcLm5rRowzhryVeYOSElS7E61GXdPUr59ICFUaFetCgEumXykBrP+hXnbOzDYwtlD5wljbsbaoclncH//khZ2KU9wR+3mR7vSuA78SD3ynRNRR16dkqN7EW6Iq5Q+T0Pw16RIEjPSOnCJFpU29YIkOT17zNGRumeFQz+LnlP6KXN77yoRU3204r7hmJ4U9RzMYRwWbAtNTfhQW66bwEK6yIf8ogAyPHNzTekp9AuviwsIIAx8/mebgNayRXf4Eywb1M1rq48AgFLXYhbCoEDu7DYi6O/D0RtRC+DhREeMY6/63H6n9haeI7QJDdSm0ufITo84of3wrpoB5SKQ9GT7s9AE3KSuJbw7lbiVU+4ok1indvnUjZRuw5zbklHkOuxhix7nTfwq/iRzXCQVjqvSmGpEGoJcs8Js4yrAM7CRTv++teDuG33++5kVXGXJYgIzisL5VT7eS03/umXAN1jzbg5EDgP+Y0hIyrDijBlbQ39xAwsczBWy9gxVusdpWwmNkHqQbZ356wPyQVpJ7Jl2/1mPamGd4oqlVGxhCIynboxCRt+CrSFbkIPsdhbwFrGMt+IPmpmTPLAfM+7Ny4eMrWxnc7XW+KdR2UUdh73xGgwLRu578+EW20+kv1sC77xF5/xUzKTJd+iLdQhzOJd026ygv/rmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(8096899003)(3023799007)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2lxNDVHQWhPbFNpckZRaDlLWUk4RTltNGNxL0FPd040eG9IaSswV1g1MzZ5?=
 =?utf-8?B?aGR4ajJXNGI2and2cUF4UEdrZTdsU2tkQk1lYlZHTlBFR3AxSkl0RFY3WTNn?=
 =?utf-8?B?TFkyREIzN0sxWUFCMFZqTkthR092aXZNZW9meSsxQllpS20rSGY2QWg1V1pv?=
 =?utf-8?B?VVZ3U0dJa1I0K0JBV2ROVXBQOHlkSVByeDM0NFc1NHhRY3ZYNkZjL21aOXBO?=
 =?utf-8?B?eFpXRXVaLzRmTXA5WWZodmEvYjczd3crQ0pIVmN0M3Q5NWZ4dm56dnV2dnZ0?=
 =?utf-8?B?RzN2RHVMWDhxeHgxV20yL29HSEI3dEljUGhFMlc4RWhJampLVUZSSS9CeFBp?=
 =?utf-8?B?czgrNUVxdmtyYnZGTUNjTXJWL1FXWCtyS3R2bDF5VFpmMzZaWml3cVlwRFBp?=
 =?utf-8?B?SkcwT0pMWEZLbWUzMUZMWEQzVEI3L3VxZU1LVXNtb0xsSUs0YitjbnlSTlNx?=
 =?utf-8?B?anB3Ymk2L1pIeTZxWDRuYTZLZnBJTDJvQlBrMjdISXN0b3NpUmw3NmVrY0h2?=
 =?utf-8?B?THpuZjBFMUVVVzNSbXRtTjdod3N2MkZRRENSSWJ0TlVEakxxREhmaXFyZ3A5?=
 =?utf-8?B?NkpFOGk2eHpRRmMzWmFXdFhCWUFQTzl2VkJpR0FvR01ibVM4RjFKcmlDdml0?=
 =?utf-8?B?RWxjMW9JMTZHVkdOOXc5bG5DbUF0ZDdUaFJzeW9XWlR3Z1Z4ek1VUTFKTFlW?=
 =?utf-8?B?ZXhuZi8xcXFxRXpBbTdOL1d6eEVHUU51djVpY3IxNHk0aU1RaEtGc1Zld016?=
 =?utf-8?B?Z2dOUjM3ejNQemhXSkh3NEpEQSszK01xLzAzeWRQejV2MnkxQ2RTbUo2QUhx?=
 =?utf-8?B?NjJTMS9XNlZGaXRTVjZ6ZEZTOTFiTjUwS2lWY0tiZnNTZVVIK094dTNjaXpu?=
 =?utf-8?B?UHN6aVJqK1VSSWFLMGZ5ZWdBdEgzd2c4QVNqazhZK2dnSHR4VHVXN1phU2RP?=
 =?utf-8?B?d3NyVTh6b1FTQWhwVm5SdHlUbHJLRG01UnBoblZTNDlhcEdhM0l5M0NLUlNp?=
 =?utf-8?B?Q0RxMGpJd2FQck1ja0I2SERrQXRadzVuRGJIbHdGMUhCRlpVaGd3MEFDc2pq?=
 =?utf-8?B?emtvNmNDblhBU2xnNzQ0cmN0SkZ5VVdQTndTeTd6SWE5NmlJWVV1dGFFeklI?=
 =?utf-8?B?bTdLdnpLZHM2dUpoMjg2UG00Q2wxNU5mWndIOW4rRXZqbElLQkVJQmJZcktC?=
 =?utf-8?B?TEZIK1ozSkswQldIWUwvREd5dHdaZVNLT2poMjRJSThUZ2pmMUJPcHZoc2Ir?=
 =?utf-8?B?b2M3N1RuTXpJVDFUS3N6aGpFZW1iSkZBOS8xd3pUY1JsNDN4RUR3RDZvMjdO?=
 =?utf-8?B?RWVzN2t4cEdLM09JSnRFbWVyblBFZUdxRi8xdTdNZFdpbVRWY1ZVeFdVWUd4?=
 =?utf-8?B?QXRnejZuaWJGc0dacVFOZUNtc0RIUCtaaE5SMjk1RVYraDIvWEFBWGlRb2dM?=
 =?utf-8?B?K1RGVFlrZUpPbE5DK3crZUMrWGRuSGRDOHZIbnRaQUdKbWdDUnlEUWVqdzFT?=
 =?utf-8?B?MzJUQXFZSktaVHBNUTVNZkVhZFZHMGpFMXAzQU55Z0h2Z2ZJQVVFNUpIQS9Q?=
 =?utf-8?B?NGhkYjgyclhFbWdhUjNjaGttVnlqeWJUNkgwV2ZiSDZ1UHczeEt1eTluT1RE?=
 =?utf-8?B?VnlFTmRuRTFpa2JKWHUrSU54YnpvVHl1VXhURUpsVk1tNnpRbG15RTNKMGVo?=
 =?utf-8?B?eThjRXlvT0VYQXo1cVVqbEsrUnlPWW5hQzBOTURTVUpxQlhXblZSNmRSY21m?=
 =?utf-8?B?MURKeGZzVW45aXNoL2ozaFFpakpVQ1V0TXVpMTVmZ2xPVkd4UDVkNkt1YzFX?=
 =?utf-8?B?c3Q0TVRBaGhob1FFMUJMMkJSaXRSNW9hT0U3TGVLL1dDYytCNFMwcVdXdWNv?=
 =?utf-8?B?eUd6ZnRTQTdnWUdSQmhjU1BTdjZ2NDNyblAvVnRPcGtlVHplYWYzMlJjSkk2?=
 =?utf-8?B?L0dRbUQyUG9tRm9PZG0zZGFXMTdRY2RLOWpsd09xT2krODhaUnpkYkV1czRW?=
 =?utf-8?B?anZQNGJoZnlKSXlDaVVrbnd1c0ZLeXAzVUVTZWFwVnprQXJVME40UmRUV0ZI?=
 =?utf-8?B?cmZyUEhkRHhoUnQzYUZ3YndEVFNEWjhENStvWGdSZ25QVUZQWENCV1kxM1JV?=
 =?utf-8?B?MEtuVzdQREVwS0xvUk8zam5WNkJHVVR1d200UXNJUEdBNHBrbko3R2xRakpJ?=
 =?utf-8?B?MnhGRExMSFNmTG5lbFhOc2preXJSMzJ1dWhHRGpVMHhLM1ZxY3lnblRCay9I?=
 =?utf-8?B?N2RBRzhLRFpXRzI3bFAzY3NEUmZGRUxCMkRGNk1JbnlHMFlWODRHbXVnRTVJ?=
 =?utf-8?B?OTFMcDNZUVdBMFlseWlYdkFrN0d3ZWxLUURWMEgyMmNST1ZHVDhodz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56153530-098d-459c-786d-08df25121621
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 07:59:32.4189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLSVPZ/bXcd7VeIraKfYujf0QBRdi3TyoTSFbGo9xXdzn/6LBoZHnvPsBLUYi5WfyiOQ39Uwsqdlj/FRE9RK5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999157
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

--------------cdYvgbebxsFEQlu8s8roFe8N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/24/2026 11:49 PM, James Zhu wrote:

>
> On 2026-09-23 23:38, Zhu, Lingshan wrote:
>> On 9/23/2026 10:17 PM, James Zhu wrote:
>>>
>>> On 2026-09-22 05:34, Zhu Lingshan wrote:
>>>> This commit implements basic ioctl framework for PMC,
>>>> including basic operations.
>>>>
>>>> This commit also implements AMDGPU_PROFILER_OP_VERSION
>>>> which report profiler version to the user space.
>>>>
>>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  2 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 44
>>>> ++++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 33 +++++++++++++++
>>>>   include/uapi/drm/amdgpu_drm.h                | 36 ++++++++++++++++
>>>>   5 files changed, 116 insertions(+), 1 deletion(-)
>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> index 6fb0a913e33b..d7db69e9d6a0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o
>>>> amdgpu_doorbell_mgr.o amdgpu_kms
>>>>       amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
>>>> amdgpu_lockdep.o \
>>>>       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o
>>>> amdgpu_dev_coredump.o \
>>>>       amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o
>>>> amdgpu_ip.o \
>>>> -    amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
>>>> +    amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_profiler.o
>>>>     amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 7c473f60bd28..a98c4a47e196 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -55,6 +55,7 @@
>>>>   #include "amdgpu_cwsr.h"
>>>>   #include "amdgpu_userq_fence.h"
>>>>   #include "../amdxcp/amdgpu_xcp_drv.h"
>>>> +#include "amdgpu_profiler.h"
>>>>     /*
>>>>    * KMS wrapper.
>>>> @@ -3096,6 +3097,7 @@ const struct drm_ioctl_desc
>>>> amdgpu_ioctls_kms[] = {
>>>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl,
>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES,
>>>> amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>       DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS,
>>>> amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>> +    DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl,
>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>   };
>>>>     static const struct drm_driver amdgpu_kms_driver = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>>>> new file mode 100644
>>>> index 000000000000..04902696adab
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>>>> @@ -0,0 +1,44 @@
>>>> +// SPDX-License-Identifier: MIT
>>>> +/*
>>>> + * Copyright 2026 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person
>>>> obtaining a
>>>> + * copy of this software and associated documentation files (the
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without
>>>> limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>> sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to
>>>> whom the
>>>> + * Software is furnished to do so, subject to the following
>>>> conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be
>>>> included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>>>> USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/errno.h>
>>>> +#include <drm/amdgpu_drm.h>
>>>> +#include "amdgpu_profiler.h"
>>>> +
>>>> +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data,
>>>> struct drm_file *filp)
>>>> +{
>>>> +    struct drm_amdgpu_profiler_args *args = data;
>>>> +
>>>> +    switch (args->op) {
>>>> +    case AMDGPU_PROFILER_OP_VERSION:
>>>> +        args->version = AMDGPU_PROFILER_VERSION_NUM;
>>>> +        return 0;
>>>> +    case AMDGPU_PROFILER_OP_RESERVE:
>>>> +        return -EOPNOTSUPP;
>>>> +    case AMDGPU_PROFILER_OP_PMC:
>>>> +        return -EOPNOTSUPP;
>>>> +    default:
>>>> +        return -EINVAL;
>>>> +    }
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>>>> new file mode 100644
>>>> index 000000000000..c27b5f9b3ff0
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>>>> @@ -0,0 +1,33 @@
>>>> +/* SPDX-License-Identifier: MIT */
>>>> +/*
>>>> + * Copyright 2026 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person
>>>> obtaining a
>>>> + * copy of this software and associated documentation files (the
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without
>>>> limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>> sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to
>>>> whom the
>>>> + * Software is furnished to do so, subject to the following
>>>> conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be
>>>> included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>>>> USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +
>>>> +#ifndef __AMDGPU_PROFILER_H__
>>>> +#define __AMDGPU_PROFILER_H__
>>>> +
>>>> +#include <drm/drm_device.h>
>>>> +#include <drm/drm_file.h>
>>>> +
>>>> +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data,
>>>> struct drm_file *filp);
>>>> +
>>>> +#endif /* __AMDGPU_PROFILER_H__ */
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>> b/include/uapi/drm/amdgpu_drm.h
>>>> index 9222be9a6d2a..acc63804ba8c 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -60,6 +60,7 @@ extern "C" {
>>>>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>   #define DRM_AMDGPU_PROC_OPTIONS        0x1A
>>>>   #define DRM_AMDGPU_CWSR            0x1B
>>>> +#define DRM_AMDGPU_PROFILER        0x1C
>>>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE +
>>>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE +
>>>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>> @@ -83,6 +84,7 @@ extern "C" {
>>>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct
>>>> drm_amdgpu_gem_list_handles)
>>>>   #define DRM_IOCTL_AMDGPU_PROC_OPTIONS DRM_IOWR(DRM_COMMAND_BASE +
>>>> DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>>>>   #define DRM_IOCTL_AMDGPU_CWSR    DRM_IOWR(DRM_COMMAND_BASE +
>>>> DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
>>>> +#define DRM_IOCTL_AMDGPU_PROFILER DRM_IOWR(DRM_COMMAND_BASE +
>>>> DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>>>>     /**
>>>>    * DOC: memory domains
>>>> @@ -1809,6 +1811,40 @@ struct drm_amdgpu_proc_options {
>>>>       } kfd_sigbus_delay;
>>>>   };
>>>>   +#define AMDGPU_PROFILER_VERSION_NUM    1
>>>> +
>>>> +enum amdgpu_profiler_ops {
>>>> +    AMDGPU_PROFILER_OP_VERSION = 1,
>>>> +    AMDGPU_PROFILER_OP_RESERVE = 2,
>>> [JZ] the implementation tells that it is
>>> AMDGPU_PROFILER_OP_PMC_RESERVE, it is better to put it under new PMC
>>> sub-ioctl op
>> Do you mean implement it like {bool pmc_enable, bool reserve} in a
>> struct? I am not sure it is a good idea
>> and this reservation design is a improvement. Because it separates
>> the reserve(lock) and unreserve(unlock),
>> so we don't need to keep the reservation during the PMC operations in
>> a complex way, and we won't meet
>> the problems like how to handle the situation where the user tries to
>> unlock but keeps enable = 1.
> [JZ] profiler includes PMC, PC sampling, SPM etc. do the other feature
> need reservation also?

Hello James,

I think we should implement reservations, but in different ways:
1) if it is a device scope profiler, then we should implement a reservation mechanism like this one.
2) if the profiler facility allows running multiple type of profiler concurrently(e.g, PMC and PC together),
and some of the profiler may collect correlate data, then we need reservation because we don't want a profiler to
sniff another.
3) if it is a dri node or any sub function profiler, then we should implement a proper reservation in that level.

I believe we need a device level reservation for PMC.

Thanks
Lingshan

>>
>> Thanks
>> Lingshan
>>>> +    AMDGPU_PROFILER_OP_PMC = 3,
>>>> +};
>>>> +
>>>> +enum amdgpu_profiler_reserve_ops {
>>>> +    /* release the device resertaion, only the reservation owner
>>>> do this */
>>>> +    AMDGPU_PROFILER_RELEASE = 0,
>>>> +    /* reserve the device profiler */
>>>> +    AMDGPU_PROFILER_RESERVE = 1,
>>>> +    /* Clear the device profiler reservation, in case the reservation
>>>> +     * owner can no longer release the reservation(e.g., it crashes),
>>>> +     * This operation does not take the reseration nor touch
>>>> profielr state
>>>> +     */
>>>> +    AMDGPU_PROFILER_CLEAR_RESERVATION = 2,
>>>> +};
>>>> +
>>>> +struct drm_amdgpu_profiler_args {
>>>> +    /* enum amdgpu_profiler_ops */
>>>> +    __u8 op;
>>>> +    __u8 pad[3];
>>>> +    union {
>>>> +        /* AMDGPU_PROFILER_OP_RESERVE: enum
>>>> amdgpu_profiler_reserve_ops */
>>>> +        __u8 reserve;
>>>> +        /* AMDGPU_PROFILER_OP_PMC: 1 enable PMC, 0 disable PMC */
>>>> +        __u8 perfcount_enable;
>>>> +        /* AMDGPU_PROFILER_OP_VERSION: AMDGPU_PROFILER_VERSION_NUM */
>>>> +        __u32 version;
>>>> +    };
>>>> +};
>>>> +
>>>>   #if defined(__cplusplus)
>>>>   }
>>>>   #endif
--------------cdYvgbebxsFEQlu8s8roFe8N
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/24/2026 11:49 PM, James Zhu wrote:</pre>
    <blockquote type="cite" cite="mid:e1456c80-ead8-4453-ad12-46e3bf467b40@amd.com">
      <br>
      On 2026-09-23 23:38, Zhu, Lingshan wrote:
      <br>
      <blockquote type="cite">On 9/23/2026 10:17 PM, James Zhu wrote:
        <br>
        <blockquote type="cite">
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
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_cper.o amdgpu_userq_fence.o
            amdgpu_eviction_fence.o amdgpu_ip.o \
            <br>
            -&nbsp;&nbsp;&nbsp; amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
            amdgpu_profiler.o
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
            +&nbsp;&nbsp;&nbsp; DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER,
            amdgpu_profiler_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
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
            + * Permission is hereby granted, free of charge, to any
            person obtaining a
            <br>
            + * copy of this software and associated documentation files
            (the &quot;Software&quot;),
            <br>
            + * to deal in the Software without restriction, including
            without limitation
            <br>
            + * the rights to use, copy, modify, merge, publish,
            distribute, sublicense,
            <br>
            + * and/or sell copies of the Software, and to permit
            persons to whom the
            <br>
            + * Software is furnished to do so, subject to the following
            conditions:
            <br>
            + *
            <br>
            + * The above copyright notice and this permission notice
            shall be included in
            <br>
            + * all copies or substantial portions of the Software.
            <br>
            + *
            <br>
            + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF
            ANY KIND, EXPRESS OR
            <br>
            + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
            MERCHANTABILITY,
            <br>
            + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp;
            IN NO EVENT SHALL
            <br>
            + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
            CLAIM, DAMAGES OR
            <br>
            + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
            OR OTHERWISE,
            <br>
            + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
            OR THE USE OR
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
            +int amdgpu_profiler_ioctl(struct drm_device *dev, void
            *data, struct drm_file *filp)
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
            + * Permission is hereby granted, free of charge, to any
            person obtaining a
            <br>
            + * copy of this software and associated documentation files
            (the &quot;Software&quot;),
            <br>
            + * to deal in the Software without restriction, including
            without limitation
            <br>
            + * the rights to use, copy, modify, merge, publish,
            distribute, sublicense,
            <br>
            + * and/or sell copies of the Software, and to permit
            persons to whom the
            <br>
            + * Software is furnished to do so, subject to the following
            conditions:
            <br>
            + *
            <br>
            + * The above copyright notice and this permission notice
            shall be included in
            <br>
            + * all copies or substantial portions of the Software.
            <br>
            + *
            <br>
            + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF
            ANY KIND, EXPRESS OR
            <br>
            + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
            MERCHANTABILITY,
            <br>
            + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp;
            IN NO EVENT SHALL
            <br>
            + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
            CLAIM, DAMAGES OR
            <br>
            + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
            OR OTHERWISE,
            <br>
            + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
            OR THE USE OR
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
            +int amdgpu_profiler_ioctl(struct drm_device *dev, void
            *data, struct drm_file *filp);
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
            &nbsp; &nbsp; #define DRM_IOCTL_AMDGPU_GEM_CREATE
            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
            drm_amdgpu_gem_create)
            <br>
            &nbsp; #define DRM_IOCTL_AMDGPU_GEM_MMAP
            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union
            drm_amdgpu_gem_mmap)
            <br>
            @@ -83,6 +84,7 @@ extern &quot;C&quot; {
            <br>
            &nbsp; #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES,
            struct drm_amdgpu_gem_list_handles)
            <br>
            &nbsp; #define DRM_IOCTL_AMDGPU_PROC_OPTIONS
            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct
            drm_amdgpu_proc_options)
            <br>
            &nbsp; #define DRM_IOCTL_AMDGPU_CWSR&nbsp;&nbsp;&nbsp; DRM_IOWR(DRM_COMMAND_BASE
            + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
            <br>
            +#define DRM_IOCTL_AMDGPU_PROFILER DRM_IOWR(DRM_COMMAND_BASE
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
          AMDGPU_PROFILER_OP_PMC_RESERVE, it is better to put it under
          new PMC sub-ioctl op
          <br>
        </blockquote>
        Do you mean implement it like {bool pmc_enable, bool reserve} in
        a struct? I am not sure it is a good idea
        <br>
        and this reservation design is a improvement. Because it
        separates the reserve(lock) and unreserve(unlock),
        <br>
        so we don't need to keep the reservation during the PMC
        operations in a complex way, and we won't meet
        <br>
        the problems like how to handle the situation where the user
        tries to unlock but keeps enable = 1.
        <br>
      </blockquote>
      [JZ] profiler includes PMC, PC sampling, SPM etc. do the other
      feature need reservation also?
      <br>
    </blockquote>
    <pre>Hello James,

I think we should implement reservations, but in different ways:
1) if it is a device scope profiler, then we should implement a reservation mechanism like this one.
2) if the profiler facility allows running multiple type of profiler concurrently(e.g, PMC and PC together),
and some of the profiler may collect correlate data, then we need reservation because we don't want a profiler to
sniff another.
3) if it is a dri node or any sub function profiler, then we should implement a proper reservation in that level.

I believe we need a device level reservation for PMC.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:e1456c80-ead8-4453-ad12-46e3bf467b40@amd.com">
      <blockquote type="cite">
        <br>
        Thanks
        <br>
        Lingshan
        <br>
        <blockquote type="cite">
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
            +&nbsp;&nbsp;&nbsp;&nbsp; * This operation does not take the reseration nor
            touch profielr state
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
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMDGPU_PROFILER_OP_PMC: 1 enable PMC, 0 disable
            PMC */
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
      </blockquote>
    </blockquote>
  </body>
</html>

--------------cdYvgbebxsFEQlu8s8roFe8N--
