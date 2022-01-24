Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5A3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 16:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C2B110E2E1;
	Mon, 24 Jan 2022 16:48:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CF210E2E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNrbWQVKhVEXOjQv5i8gFmUoA6Mj2zgNNlUJkUJSAxelg9swcL/G+glmZgt/Zfn/DCx66vXSRWpr5LK7N9cO0ky+4U0aopxueGAEAXAcQAIeQ8o44Zp+bA+AiXWzvVhlmsrW29TsU9tynUDYM/wRtDVZ8gddMFewAtlkSiBAWFTA51fMUc77IdLCtLnZIOT/HObvFzqXxhE+jsfP+d9KgHpabOfsK7gVqVFLZHLDH1MKGCuJJOxvM8qaBU7NmGJuDd3rnUxB2w67eYnF96XVwl10QZJpLFwRJK0Py7bo7izBhjYxyG6QyVFDLVUX/AD48RX/6vqlcNAb8zjsTXLqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDCrv/jQksS3eW6X2C5m5RwA4WEUpQI/tLXcGcodSTE=;
 b=iAh5T7prJmDbjy5rvsuhphrGOu3D8rtxGMu6V3cIQbCro6j+xwja4h984Qs6AOtsiZTP/UGJ7h3awRv9WHBkM1vMFLf85A8mbY9/gV8ub77dkhHkM/B1crgMH9hY8zuHPB0HoNmYIbbGQuhQhU2uVXRt7/iYNUOr911a7t3KCrxHvj51+VhTUhueuZMmlicmfag81GJnQQXAIBIVpcHwSoyggK0PRc4rsNLaao1S/L+ShEkghSHkqkG3tivkLXEWqWUkEp71JnbubVZRigal3WhsFZLk18fMMwxQp8wLYiyZABJNWjANMZK+/Ff2J+adFg3yh1skMK+82xO4TT//aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDCrv/jQksS3eW6X2C5m5RwA4WEUpQI/tLXcGcodSTE=;
 b=yR1RqgCSuL/owlKVibSR0hxSAZTuQahToNceSfm/6LBzxLXqqOGtlLsYbyzbG+UXeYlqrC41KRW1Qsxg6TbDocAdIHMrKkTGxZn0ZxLH7Rs5jE+guCzOwMma7moHKphB71hVfEFD/+5cRadRw+uIQNSyqH/ZFNSLXGix++g6Rfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB2926.namprd12.prod.outlook.com (2603:10b6:208:10a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Mon, 24 Jan
 2022 16:48:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:48:17 +0000
Subject: Re: [PATCH 3/4] drm/amdgpu: add reset register trace dump function
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <ba6e97b5-17e0-819a-fb2e-5c4515995156@amd.com>
 <fa8d13a4-ccbe-6e8c-5c97-9c4d7f1134f6@amd.com>
 <26aeafd9-307e-f8de-501d-5efabd67a450@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c47c2450-7008-4419-795d-f9e6be64061a@amd.com>
Date: Mon, 24 Jan 2022 17:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <26aeafd9-307e-f8de-501d-5efabd67a450@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6P192CA0050.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::27) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0455a44-c3ad-4c3c-0373-08d9df5951fd
X-MS-TrafficTypeDiagnostic: MN2PR12MB2926:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2926EAE675E33E7B14C6BA7D835E9@MN2PR12MB2926.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDb/qN8dqAFh0rHUDmc4MCwxnXNwlKqafa9C1EJlZkJ0XN3nh5R+l9FEwwOmlrj0KTBFj6EVjwYuCzHkLxrq7EsL+ehVD/mDsN0ype43nEmluig8nKbt8GFfJ4IUDCx9k8MYJJGzYs4w/f3GLYIp+t6aeI/92wuUEIlbXenPAfwgh2caFn3GdubqO456xufjdmS4iTJz+VtrmrFqA7bo5ffqATuz9EYIBxS9FOib1F/aslKxvq5AgdB8j87Ns55ba8UP4qY2AzAw0h+mScp2GjA4bNqROmaj9MUGfO62g4ZB5l8qEMHGU1ev82pbqOCrBJ7miKgPwDfF1U3Y7dkSRsIuy3B1zmL3qhYTgSlSOeCyjfXgLBwSlZYY9+0MChf5S0VCs1GEPYVKBXkVjR9i3EAASmd2bOWANkJrg7S7P1rYdd9XPfSzNdUQTILmx0nsrVWKSouhC8/6DWkqqOhiI1dWs/O040lNFzuzrDFtzFkTkdrhUwbUTXTKmiCibN/gBJbHlMvavDMuTZ+yyhxrv6Sxmb+AUC5fwLG1sh1SxEBVO56f8bJTnVqIYMtA1hBWW7C5NPwK6pxXo2kP8qoL2clxZEoZpeHu2j7BwMSziPTBS5C/AVblFXp9zxtMjFGm8bz4MrAjjaa0HTF00dI5ZkY8G3RlbqW4tIY1m0qKCy0yzHKB9W9EFEw/huCJqTCof9TQhYAeLu99dZhDo0KhIPWAH5xv5yZjKtwyFeFQq14=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(54906003)(6512007)(8936002)(31686004)(38100700002)(66574015)(66476007)(66556008)(316002)(6666004)(6506007)(2616005)(83380400001)(186003)(4326008)(66946007)(2906002)(36756003)(8676002)(86362001)(53546011)(508600001)(5660300002)(110136005)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1hRQko4T3ViNTByalJqZTdZcDFKR24zQkpiNmJZcUFTRUZSRUd4SXVMZmVh?=
 =?utf-8?B?aU01MFNQcmY5cDhmSWcyNjZVZTJlVVJMUFNhWlB1Q1BWRXpQNXFIUjE5SDBt?=
 =?utf-8?B?Mk1CS0psWWdEeENZV0ZoYkhhMzY1TThmdHhKb0pMYkNvZ2RXdnVOVm1CQ1dx?=
 =?utf-8?B?Wkk0OGVhallqT3pEZXpLRkVTbkNpV2I2MER5M2pVcWdGS3VtNEVLNHZvbGRF?=
 =?utf-8?B?TG56VE4xay9jMnFuOWo2dDhYR0c5Z1RlVmR5TE8rcGw0RDNlUGNwbDBPQS9h?=
 =?utf-8?B?OFVsRCtLV1RXMjFXaGx6WHJBbGt6UmpLbHlxblBkU3N5UnArQ3pncUJWK281?=
 =?utf-8?B?SStQMDBiQWxZRlJrSlV2UzNsUENmdjcvQ0YyVSs4VlhxMGI5QkI3aVhJNUNy?=
 =?utf-8?B?dmNRc0ZQak5ObmJVRDdZR1V3aWJnanhLUjZMZFM3QkIvcEpXeDVpS2RmUjlr?=
 =?utf-8?B?aUJtbEN0MEw5R2FOZ2Rob2JaLzV0eU5jWkhWUTV4MHEzZjhDb1NTcFg5R1Bk?=
 =?utf-8?B?cUNwVDJvU1J2aXp6cTFjWlVWV05tWW5yZXUxT21sMTBnTi8vamprOVM4a1J5?=
 =?utf-8?B?d1Y0ODVnYVBwYXV5djRNRktDbS9KZ1o4ODROODJraTB6WXJqRXQyd2FSL1VK?=
 =?utf-8?B?eFZ4cUk5TmhzNnlOODE2OTlKOVVOMTIxNmdJT21CTEgrdm9jNVN0YkxZeGpa?=
 =?utf-8?B?aHJ5aEt4VkxOaWh2K2ljYkZoWjJzbnRNMDBEQTVpZFZIWUh6NHJ3ZUR3Ly9h?=
 =?utf-8?B?d0hSemdtWEhlOW1RVlRhNzZiYk9CbnViSTljbEJjcjVXc1ZCcWNwdVJydi9K?=
 =?utf-8?B?U0Y4UHNhZ3U1TFU5cVVWSW0wTlJ4aWlWeUFsV3dpVUhuSE0zbFJGTndwUFlv?=
 =?utf-8?B?cEVEOGZYakxQVjJyVURXS3ZyTm5yL3BDMFhaREkxVGdoVXBVbkk1NXVoK3Rm?=
 =?utf-8?B?K1ZIUXZLd3VtMFlzN0hqdlp6YWlXbzFjR2xodENFU0lpTzRlMnZlZVdidVlN?=
 =?utf-8?B?L3ZCajhzWU1lT1pjcGt5bVRhRW9OMHN1RzRJcXRiRjllSmVEYnhaZFlpZGlD?=
 =?utf-8?B?cUlPMURIMlhsdDhydmRJVXBMbkpzaHRQcUs4UFVCTWVwSmQ1N3BlbUhqU05n?=
 =?utf-8?B?OVF5VXZwc3JmSlZiNEtjSXIvcDJ6eUdJNTd2Y0pkRDJ6Q1dHek5ITC9TRkZs?=
 =?utf-8?B?aDh0K3BiVHBaMUpqWTE5VEsxUFFrWENTd0RrbFAwS0dEV2dSUlFSQWw2aFJR?=
 =?utf-8?B?NTB4dklCbnRxN3VmTWwyZXdDTHdLejhsMXNUaC82TkVNcGZzN1NKZ2x0ckdv?=
 =?utf-8?B?a3FzTkNwa0hHSnQvVGlNbDFIT0dwVFE1RGc5NFpKTVd3dUxaaDhYVCtKWGo0?=
 =?utf-8?B?RlRUVzZkVnFOUmI1cWEwN2VYOGVBcURvMEpIQkRiamFEVFQ4dGxuMzdKQURy?=
 =?utf-8?B?bno2eXVJWFU0dzY1VTRQdjVzZS9VRERrRm0wSTl5OW5oK3JXNkpCNzFLV2xE?=
 =?utf-8?B?c0VNZ0pmNnhiYmNSaEZrUWk1R0hTUzg3VFpZa1dSQ2VZVHBnQk1zK3RnWk5D?=
 =?utf-8?B?d0ZWZkRPWGxHVmxXYStxOXhrcS9IQ1BjZ0JLbTgySkU3T3lZZWRoVUVhNjN2?=
 =?utf-8?B?TkxkbWJudGVWaG1xQ0lmVFA3RFVyTlRNV0cvejZzemNhRUd6Z0toK1VKUXAw?=
 =?utf-8?B?eE9pbkQrenZ2czIzUFVwVkt3OXV6QXdKejhYTGdkaEYyODVFOVFmeFVnMGhB?=
 =?utf-8?B?RVhEMEVuWUM4Y3VsZjVQcWgwYTh5RkF4NkorY3dTYmZwcTcycmt4UHlPMEor?=
 =?utf-8?B?ME53dGNVekdOQzJ6UmJzdXBQSlRFdVZwc3B0M2Y4d3l4MnUwMHE3VlAyN2tM?=
 =?utf-8?B?ODVlUDdFUHpJdVd2YUc1a3l1ZlRua1YwdmJydGt3ejl4TGlzSHI1dyt4SnFP?=
 =?utf-8?B?YWwxNTk4UE5FNzZaREg3djhaZVdKM2w1Y0JPZGFEODlScmk1RHpTT0duVkYv?=
 =?utf-8?B?SnE5TVlVckptZUFMVUphZjZ4Y3dOTVBvek5lWU1NbUlBRmh1VnNSWlAzN2FX?=
 =?utf-8?B?NjJ4UjZHTk5zOStLSUE4VWdKWXFtMXdRZ21hdExkdUk3RVlOSEZMc0UycWtq?=
 =?utf-8?B?OXhZQXRtS0xad1hLZnZhZWc5Vzh1UU8zdm4yY2RTWkJ2Ky9OblpoRTM3Mits?=
 =?utf-8?Q?vk+8fA32RlW4HFbuiWv73Rc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0455a44-c3ad-4c3c-0373-08d9df5951fd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:48:17.1661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDVYTB+oLwDtRlTzeCim6ZRfh9MmlBywgax/u7oKuGPUpDJk53Pbu5jgGr67KXAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2926
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.01.22 um 17:45 schrieb Sharma, Shashank:
> Hello Christian,
> Thank for your comments, please fine mine inline:
>
> On 1/24/2022 8:15 AM, Christian König wrote:
>> Am 21.01.22 um 21:34 schrieb Sharma, Shashank:
>>> From 1c5c552eeddaffd9fb3e7d45ece1b2b28fccc575 Mon Sep 17 00:00:00 2001
>>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> Date: Fri, 21 Jan 2022 14:19:10 +0530
>>> Subject: [PATCH 3/4] drm/amdgpu: add reset register trace dump 
>>> function for
>>>  gfx_v10_0
>>>
>>> Implementation of register trace dump function on the AMD GPU resets
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  8 ++++
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 53 ++++++++++++++++++++++-
>>>  drivers/gpu/drm/amd/include/amd_shared.h  |  1 +
>>>  3 files changed, 60 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> index d855cb53c7e0..c97b53b54333 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> @@ -537,6 +537,14 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>                __entry->seqno)
>>>  );
>>>
>>> +TRACE_EVENT(gfx_v10_0_reset_reg_dumps,
>>> +        TP_PROTO(char *reg_dumps),
>>> +        TP_ARGS(reg_dumps),
>>> +        TP_STRUCT__entry(__string(dumps, reg_dumps)),
>>> +        TP_fast_assign(__assign_str(dumps, reg_dumps);),
>>> +        TP_printk("amdgpu register dump {%s}", __get_str(dumps))
>>> +);
>>> +
>>>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>  #endif
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 16dbe593cba2..05974ed5416d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -46,7 +46,7 @@
>>>  #include "v10_structs.h"
>>>  #include "gfx_v10_0.h"
>>>  #include "nbio_v2_3.h"
>>> -
>>> +#include "amdgpu_trace.h"
>>>  /*
>>>   * Navi10 has two graphic rings to share each graphic pipe.
>>>   * 1. Primary ring
>>> @@ -188,6 +188,12 @@
>>>  #define RLCG_ERROR_REPORT_ENABLED(adev) \
>>>      (amdgpu_sriov_reg_indirect_mmhub(adev) || 
>>> amdgpu_sriov_reg_indirect_gc(adev))
>>>
>>> +#define N_REGS (17)
>>> +#define DUMP_REG(addr) do {                    \
>>> +        (dump)[i][0] = (addr);                \
>>> +        (dump)[i++][1] =  RREG32_SOC15_IP(GC, addr);    \
>>> +    } while (0)
>>
>> Those macros need an AMDGPU_ prefix and maybe some better names.
>
> Agree, @Amar pls check this out.
>>
>>  From the design POV I'm really wondering if it wouldn't be better if 
>> userspace defines the registers we want to dump in case of a crash.
>>
>
> I am not so sure about it. This means we have to communicate with the 
> userspace and get the list of registers it wishes to see, do I smell a 
> new IOCTL or DRM property ? I also feel that we have better filtering 
> tools for a trace event in userspace than in kernel.
>
> What do you think ?

Just a writeable debugfs file should probably do it. We have a list of 
known registers filled in during boot (just reg offsets) and userspace 
can read/write the file to update it.

Christian.

>
> - Shashank
>
>> Regards,
>> Christian.
>>
>>> +
>>>  MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
>>>  MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
>>>  MODULE_FIRMWARE("amdgpu/navi10_me.bin");
>>> @@ -7488,7 +7494,6 @@ static int gfx_v10_0_hw_init(void *handle)
>>>  {
>>>      int r;
>>>      struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -
>>>      if (!amdgpu_emu_mode)
>>>          gfx_v10_0_init_golden_registers(adev);
>>>
>>> @@ -7602,6 +7607,49 @@ static int gfx_v10_0_hw_fini(void *handle)
>>>      return 0;
>>>  }
>>>
>>> +static int gfx_v10_0_reset_reg_dumps(void *handle)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    uint32_t i = 0;
>>> +    uint32_t (*dump)[2], n_regs = 0;
>>> +    char *reg_dumps;
>>> +
>>> +    dump = kmalloc(N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
>>> +    reg_dumps = kmalloc(1024, GFP_KERNEL);
>>> +
>>> +    if (dump == NULL || reg_dumps == NULL)
>>> +        return -ENOMEM;
>>> +
>>> +    DUMP_REG(mmGRBM_STATUS2);
>>> +    DUMP_REG(mmGRBM_STATUS_SE0);
>>> +    DUMP_REG(mmGRBM_STATUS_SE1);
>>> +    DUMP_REG(mmGRBM_STATUS_SE2);
>>> +    DUMP_REG(mmGRBM_STATUS_SE3);
>>> +    DUMP_REG(mmSDMA0_STATUS_REG);
>>> +    DUMP_REG(mmSDMA1_STATUS_REG);
>>> +    DUMP_REG(mmCP_STAT);
>>> +    DUMP_REG(mmCP_STALLED_STAT1);
>>> +    DUMP_REG(mmCP_STALLED_STAT1);
>>> +    DUMP_REG(mmCP_STALLED_STAT3);
>>> +    DUMP_REG(mmCP_CPC_STATUS);
>>> +    DUMP_REG(mmCP_CPC_BUSY_STAT);
>>> +    DUMP_REG(mmCP_CPC_STALLED_STAT1);
>>> +    DUMP_REG(mmCP_CPF_STATUS);
>>> +    DUMP_REG(mmCP_CPF_BUSY_STAT);
>>> +    DUMP_REG(mmCP_CPF_STALLED_STAT1);
>>> +
>>> +    n_regs = i;
>>> +
>>> +    for (i = 0; i < n_regs; i++)
>>> +        sprintf(reg_dumps + strlen(reg_dumps), "%08x: %08x, ", 
>>> dump[i][0], dump[i][1]);
>>> +
>>> +    trace_gfx_v10_0_reset_reg_dumps(reg_dumps);
>>> +    kfree(dump);
>>> +    kfree(reg_dumps);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>  static int gfx_v10_0_suspend(void *handle)
>>>  {
>>>      return gfx_v10_0_hw_fini(handle);
>>> @@ -9367,6 +9415,7 @@ static const struct amd_ip_funcs 
>>> gfx_v10_0_ip_funcs = {
>>>      .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>>      .set_powergating_state = gfx_v10_0_set_powergating_state,
>>>      .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>>> +    .reset_reg_dumps = gfx_v10_0_reset_reg_dumps,
>>>  };
>>>
>>>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
>>> b/drivers/gpu/drm/amd/include/amd_shared.h
>>> index 257f280d3d53..76d3a55278df 100644
>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>> @@ -296,6 +296,7 @@ struct amd_ip_funcs {
>>>                       enum amd_powergating_state state);
>>>      void (*get_clockgating_state)(void *handle, u32 *flags);
>>>      int (*enable_umd_pstate)(void *handle, enum 
>>> amd_dpm_forced_level *level);
>>> +    int (*reset_reg_dumps)(void *handle);
>>>  };
>>>
>>>
>>

