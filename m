Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDAFFED2F3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 09:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9753F10E1E3;
	Thu, 12 Mar 2026 09:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j67VTJWl";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72AA10E1E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJdMTZdJbTohpEadCKRuDMw6SOsafLN3ZopDdEXlTPhEVImaIqRIF2IV+NjrInw2E/rcpGMv3i+FY5xhD/DPOK3lAzLAMfr5kY8yyGwScTFGpja2W2AtpgSMuxFiYhX5GIR0jEyNX7gU0sMwrad6nuyUSyiLDVBI9UxNEuhsFsdbKpWdHIaVbEAScAng/mFFS1tdS88Q2NFIc+sjOCz0Hva5JXKvFZJcXHJS8/Qd9kWj+V7YxHjvrCwuv1yfuXH2lX7KX/juVgVrXl6Kg82D6etqad00Va/AQTcA+fNKZDvBcdONnoQqn1jD712QbhFUIlYndi8vpQc+AgMTCFK3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skjR7c//NMR6QqeJ/IEtyyV3Qdltzg6y4Ur3jMncLrc=;
 b=DSsBlDJf2Wwg/Oq7CvqaOoY3H7QaZEkwkUMJMc9JqDadiQuHQD4Mq5IhtYvm9rxZR8hVkX/hecLK4uzjAGzWDzAKY+ikdY6e0jubAJSCtXxp2HmJH5bTU2D7pPu/8bBS/BBYTFPkn1W+HMlFeH/W3FZSWwldwcbjKVRQkKvCvZoMsKWBrOxMlLck+2JAf3ZDarCLc5FyJyj+v8BiNBmgJjWVHQmTJZKlGMQQFT6c1OvsNKchLHbkg/OsNMwOvYPNgUz4vNxcIFkoVDD6t2uKB4jyFzTDKf/wHMHvIYvdQGndUOmbfmSwQR5X13FEmMwbL9VeQlaXyfixlZl16jCoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skjR7c//NMR6QqeJ/IEtyyV3Qdltzg6y4Ur3jMncLrc=;
 b=j67VTJWlnhCRZClfM8+kM4V9SLeBmlsEp4eYqgmo3zGs+ggRlceY7lozEb2DHGanJzF3V+MyibE67EoWGq9Sme7FD2H/din1NWEGV6wzxUwB//MoQFtMe8x1l9lMlskv1VQMGSc/c8LuzT3OT5Nzva7FvNQlo2H9Iz7Y1sE6vjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 09:17:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:17:38 +0000
Message-ID: <893e3235-b291-45c7-8644-913e22b432ce@amd.com>
Date: Thu, 12 Mar 2026 10:17:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add overflow check for BO list array
 allocation
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260312081827.1484742-1-Jesse.Zhang@amd.com>
 <ff117d6b-943a-4555-834c-96b53bd20057@amd.com>
 <DM4PR12MB5152B6F41902A41DAF0364B0E344A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB5152B6F41902A41DAF0364B0E344A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abf571f-6ed6-4d4d-9e41-08de801834ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: x2GpAEEeDgZAplssFd4c6A/dgB8F4gS6p0QBwoxSigVLyYTpHySKqC8AsOn0VCt/DMJIJECMDht8DecRtWcE0+3huUTnxMIWQRFXP7UwlTeXDOSOpiLtaAGZgqHe8d+0zYfTjFMQS34VsQNRHwX2xzPjiw3uIqAz95PKBEB7bAhbGCAMHACtTgSwqBwq/UqXLCk16P6ah0kbI72+7jF6ys7dVwwAwGNBp0+EfK6T2X/p52d61hXoD+tcgQvmXhIR1vKbANzq/qzELuqbSH2YRf4K2Gb7zGl2tvTO3LWqPfZOeetQHjFD8u/nN8KPOVUwd8V1lybaYtqRa/nsLYkPvhliFgfPeNpYF0Up/ro56d/clb+6NlZgqZ+AQj01h9a7KjYg8x5GRRnDiZPsaU+owEs1FVitOiG9L8u1j0P7hwHqhrB8MKY6mzFTOdQK7WfyisBp5gnTDZnoIljbKiXKbCzq5XyAeaqlDLEPOoPl8cgeSEh/04nc1QQjwIdtjPktMiyA3b7cat478bsSCBmpqDHyq6oRZEkW2ZTug56e4tZjFEWsc7kAnYOeiiEW5Gth//iUCTxJbAqVKx+WznZE7ljvjp6hGn48/Lw0YS9GiC5a0dxF8okCQ2Ueriz3Vd01gid4Inxrp5joKcvUeeRp9fsFeKAxZvzE8CQwkLhF1AuSkTfxoKz3K+UV0aS7p0Lmy8tDOp7Civ2xGrykOuhkPP3jxPKP06pAWIHVPd/ZAi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1FyN1V2TFNKNUljVStDYk84VVFTS3Bwd3JjUG5vY1FnS3Y0V2FlKzFySkpG?=
 =?utf-8?B?b1NYVkZTY1ZBREFTTXZMS203ZGsyUWpmTU1LNlJocVBFZFB0cWR5UGtKdVA5?=
 =?utf-8?B?Z2VaVHVpU25saFMyL0o2V1lWd1dDNk94cUhPTFNaYWw2ZE5KckdObTdBbGMv?=
 =?utf-8?B?ZENwZ0tFNk9pVWlWMUtjSWNsbm9pVUFoUkFQWU5tWGNVcktaTlFBOGV3bE5l?=
 =?utf-8?B?YVdSTzZKOTNmV1FpLzQySXlwaGNIaXpCR3J5VFVxRjhzUXYyRU1JNzF0aGUx?=
 =?utf-8?B?SCtiWUlRUkJMdnZXSmNmYnNXcDZRSWRCVjBQUTVvTmhJWE5odVNxWnhQMkg1?=
 =?utf-8?B?Nzh1UFN2ZzJhVUhxQ0pKd2t1SGlZL1BqbUJSRzhFMjgzV0dpY2oza09QU2FI?=
 =?utf-8?B?VEQrRkpYbFByUmFSTTJwdWNVVHFWZzBzSmVNK3E1SWp4TEVZZTZwTkxCQk5k?=
 =?utf-8?B?aVh1cEF3VWkxZWVNTDRTaWtXSUwyMC84Q0xnVlBtd0Rha3hJbENsT1pYWGZN?=
 =?utf-8?B?ZzdLV3NOSzBBczBHUWxaN2x0dEowUWtUK1dOdENSR2YyNlZHUll2K0tOQkta?=
 =?utf-8?B?MVh3eXI1LzJROTFYY1lPNkN1bnZocGdzTlVKcDBOTmpyWU9yZmxoUEEwcVoz?=
 =?utf-8?B?Uk9FL3oxdmlnSzBsSzc1NEFpVVVRZSswOVBSdGZrcTRkSnFMeXhBVitnV3B0?=
 =?utf-8?B?SWc3Q2VyZlA0NVpyelZWTjN0Z0JZK2E4czlNcmIwRWpjRVB5NlUzVXY1V1o5?=
 =?utf-8?B?SE1yWS9kU2JxYzNYZk43bHhHbHpWcmdCKzQ4SmJNQXVua1F4bVRYM1hRWGIx?=
 =?utf-8?B?dFZ5OUFmc1NBRnV3Mlh1ZkttL2htSy9uWXdsT0xVWGNJNkM0ejRqWXh6TE9y?=
 =?utf-8?B?K2tab1FFT3V4ZG0wb1YzWFNneGhadEFEanVqZGV6VkVPOVljcUpEK0xhM2N4?=
 =?utf-8?B?djNvZGJlQkRFTmNxSGxCTU5NR1E2STU4Qkk0SDFhYWVZdFhJcXdqOEJZQTRQ?=
 =?utf-8?B?ZUxnMzkwNit0anNlaE40VzJJZGthVUY2TERrVlNKRTVxb2NmUVpDb0c5dTF5?=
 =?utf-8?B?dFMvd3Q1UXh2ekU0R2dOS3YwNmhnNFFDK1QwYXdxdlBLSG5ON2ExNitvOSt0?=
 =?utf-8?B?OGU2cjlHRTQrQkZGNGllbDZEalBsdURIZGw2blUvVTNQZVNRRVU4MFJaanI2?=
 =?utf-8?B?M1RBb3paTGFsclA4VUYyMDNVVVJsbDZpcGYxS1YxV294cUNOT1diQ1ZBQTE1?=
 =?utf-8?B?YSs5Z3JXVVF4L21PUDFKdGxldHdEMXA1WU01QkRHUGlvN0J3S2FyUHpjTld0?=
 =?utf-8?B?VlBkMWptNlhRVnlaV210Uk0vMnJQL0V1VEI4dzlHaEJZZlUrOTd0cUY5Zmh4?=
 =?utf-8?B?UjdMTGk5Vy9PNWNycnRJTm1HWlJOcFlEU29RVGx0bVJlTE5pVTZiMXkzNGhE?=
 =?utf-8?B?NDFPa01Ya0ZlMFphZjk0S1NmWWp1TVFkQTlQN0pZdjF0cHRtSWJUcmVlL3VV?=
 =?utf-8?B?aUdIY1NlMW9wRmFXdHR0bUhER29uNnJGSVVrQ0poOG5hVS84OEFtdElzZkYv?=
 =?utf-8?B?YUt5c0FkNzlTZ2lEL3djY1NhRmFBWDIwbGJsYmlKanpha0x0Z1VLcGdWK1Bj?=
 =?utf-8?B?MmtIQWZXZmRMYnREdjNId05jbkRlVzhvNjhaN0dsV1ZSenNzdi9KOHFaREIr?=
 =?utf-8?B?ZWdRUHRLVzJ6bVlKM29PR1YwUEk4cE9pakRJcHhnMmdUNloxRmVWZGF2WWVw?=
 =?utf-8?B?UEtmZnNyYzIvS1crWCtDenRpWlIzcmU1U1ZYcmhjYzdzV0hweUE1Qm81YU5E?=
 =?utf-8?B?elFwUGdBVVgxUGRVVTNaYkxxK0hhVEdxbWd2MStPSDNRbm81c1ZmMXpjUUJC?=
 =?utf-8?B?ZzZZaSs1K0VnSEZzd1NmSVl1dlhoM1lhQUpBTms5eTFRREhmUTdPcjhSMjJ6?=
 =?utf-8?B?ZUY3Ym0zV2ZXNDVBdU9Wbnp2MjdhdDRYNFVmNUV3NDVqcFREa3NNY3phVkFB?=
 =?utf-8?B?cHJBWmg5RHNjV2VGcUF2alZhWTFKRDB3ZlN0YnV4N2JHbWdvNVpadGluRE1I?=
 =?utf-8?B?WEppS0U1cmdneEVEMk1USUV4OEJQejdlejRSQmxVVWNxMVNqa0F4Z2tPck56?=
 =?utf-8?B?cDZ5azRhWFV1OXRVWFVJeE1Td2RIV1F3K1JHVmZ4STd5elI0WWZ0elhWWWxC?=
 =?utf-8?B?dmtNRlBzOHhyOWdJYnJhUTVPWUFIbkZhblVQT0ovNG4yUWdZamcrWjF4NnBY?=
 =?utf-8?B?VUo5Y3hXcW5OL2FCaWU2dmpsKzdYdDVFa3RFYzA5WFVCcXhqdXZyZHZKUDFv?=
 =?utf-8?Q?rLKc27kGSFZqo8GD64?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abf571f-6ed6-4d4d-9e41-08de801834ac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:17:38.6889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFOYwIymEqwGmvGj4od3PfMiZ9Gn1LJDpzk/X2yyILAvjmGrO8Dg04lC2YLSCmhu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
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

On 3/12/26 09:33, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, March 12, 2026 4:23 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add overflow check for BO list array allocation
>>
>> On 3/12/26 09:18, Jesse.Zhang wrote:
>>> When allocating memory for a BO list array, the multiplication
>>> bo_number * info_size may overflow on 32-bit systems if userspace
>>> supplies large values. This could lead to allocating a smaller buffer
>>> than expected, followed by a memset or copy_from_user that writes
>>> beyond the allocated memory, potentially causing memory corruption or
>>> information disclosure.
>>>
>>> Add an overflow check using check_mul_overflow to detect such cases.
>>> Also ensure the resulting allocation size does not exceed INT_MAX, as
>>> the subsequent user copy operations may rely on this limit.
>>> Return -EINVAL if either condition fails.
>>
>> That is completely unnecessary, vmemdup_array_user() already does that check.
>>
>>>
>>> A crash log illustrating the issue:
>>>
>>> [ 2943.053706] RIP: 0010:__kvmalloc_node_noprof+0x5be/0x8a0
>>> ...
>>> [ 2943.053725] Call Trace:
>>> [ 2943.053728] amdgpu_bo_create_list_entry_array+0x42/0x130 [amdgpu] [
>>> 2943.053947] amdgpu_bo_list_ioctl+0x51/0x300 [amdgpu] [ 2943.054277]
>>> drm_ioctl+0x2cb/0x5a0 [drm] [ 2943.054379] __x64_sys_ioctl+0x9e/0xf0
>>>
>>> The overflow occurs in the allocation inside
>>> amdgpu_bo_create_list_entry_array, leading to a crash in vmemdup_user
>>> (via __kvmalloc_node_noprof).
>>
>> How and on which kernel can you reproduce that?
> We are developing some fuzz tests for the unified project.
> The tests involve passing different levels of garbage data and ensuring the kernel can handle this data correctly.
> This issue can be reproduced on the amd-staging-drm-next branch.

Do you have the full backtrace?

Regards,
Christian.

> 
> Thanks
> Jesse
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Jesse.Zhang <Jesse.Zhang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>> index 87ec46c56a6e..efab39ba7f51 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>> @@ -29,6 +29,7 @@
>>>   */
>>>
>>>  #include <linux/sort.h>
>>> +#include <linux/overflow.h>
>>>  #include <linux/uaccess.h>
>>>
>>>  #include "amdgpu.h"
>>> @@ -187,6 +188,11 @@ int amdgpu_bo_create_list_entry_array(struct
>> drm_amdgpu_bo_list_in *in,
>>>     const uint32_t bo_info_size = in->bo_info_size;
>>>     const uint32_t bo_number = in->bo_number;
>>>     struct drm_amdgpu_bo_list_entry *info;
>>> +   size_t alloc_size;
>>> +
>>> +   if (check_mul_overflow((size_t)bo_number, (size_t)info_size,
>>> +                          &alloc_size) || alloc_size > INT_MAX)
>>> +           return -EINVAL;
>>>
>>>     /* copy the handle array from userspace to a kernel buffer */
>>>     if (likely(info_size == bo_info_size)) { @@ -201,7 +207,7 @@ int
>>> amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>>>             if (!info)
>>>                     return -ENOMEM;
>>>
>>> -           memset(info, 0, bo_number * info_size);
>>> +           memset(info, 0, alloc_size);
>>>             for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
>>>                     if (copy_from_user(&info[i], uptr, bytes)) {
>>>                             kvfree(info);
> 

