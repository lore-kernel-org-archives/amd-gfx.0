Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A21C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 16:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AA7289DC2;
	Mon, 24 Jan 2022 16:45:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0D789DC2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:45:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3/ejevMNGFexChTuCyBDfvA7jpUfhub8FQJGI/oNn/EPOXeoIj8haNzqAvrYuKEYvH9BjK4ba74/U1zs3KsMXvyJXZgcNkuHcQfnhnWHvLf5/VXI9atXGoN3ouQN7xTTwXFsJ5TZSMzcWB6Lam3e+lvque2pKWpXfOIUTdgsKuKlKDC4AqfxYl5/g4533YnGQICt/1u18Q5Al7gn7n72KZbBuqCWJxVx7HWhRgb4LoueK2LWYrr8up78PaaSXv6jyDEh8ITBQMrjOSAs/joooFrvg16CBH+Q5iZ92P3xA9AhsgkQusIbXr0UdDRt1Y/qQoj2KY/9mOa3wfR6i7Xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXlNkzpzWw+wOmzS4suCCfRMi7fETCZkXQlTcSlsLs8=;
 b=YqWIPwcfxSZOwjd6GNmil9MlD3jl87+BD4/QgJvIyarYUrz91KpCeFjxCe89xtMeBAvzVp9d/nQW3ZNVqfFUDKt7uyootjWE0wTSBRAJZCUZfYU/YeqmjPWAkjr1Fo5lXj2BCdWk8vreg0e1asxL0NZdYtcca7uLMTYIFIi5NRZLq71ktZoVdUB4p+cVVGWh0wqMzZSSu6ce5jero6hnc1hrKpLqSlFivn/MwPB6un5LVyt4CqvVsd1M7VG377VXJftEDTvBTrhEJkcXKHWJq4hCALUkHsFxKE+TtwAM623poZYLCaAH4VkHtKV63Bk3ut5tMOzxqS0nJoGlIFd7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXlNkzpzWw+wOmzS4suCCfRMi7fETCZkXQlTcSlsLs8=;
 b=RTam7n3kqJOM0FLeokSGZE3bNSv8rBYXYQcpYf/HCpHdHpH7xQrBGGaupwCaku1mm/3YwJc+xnWhDhju4I+52Q7W6zXrLV2ibyqwGzBqGoNb3AL72Npd3DUDEHB0HY3JdAmBIKnAbgMmgjPGmw7BzFAvxQq3H8X2Kww2c4qMhug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB3087.namprd12.prod.outlook.com (2603:10b6:208:d2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Mon, 24 Jan
 2022 16:45:24 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:45:24 +0000
Message-ID: <26aeafd9-307e-f8de-501d-5efabd67a450@amd.com>
Date: Mon, 24 Jan 2022 17:45:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/4] drm/amdgpu: add reset register trace dump function
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <ba6e97b5-17e0-819a-fb2e-5c4515995156@amd.com>
 <fa8d13a4-ccbe-6e8c-5c97-9c4d7f1134f6@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <fa8d13a4-ccbe-6e8c-5c97-9c4d7f1134f6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR1001CA0056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::33) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c6f836-a6af-40ef-ba98-08d9df58eb12
X-MS-TrafficTypeDiagnostic: MN2PR12MB3087:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3087861480A519A24FF838D5F25E9@MN2PR12MB3087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJK/50e+d/ERTaptMGeLc3uID6BLmuaHjFj6GN0Gz28RogjXeHivjKLERGMnTxsY8lwMfDtVp2UfXzNcX+GmKXC7ksCr3+WTdyOt9Hf8egiFZDm8PBxEi0moCuubN6PWkChhhRkY3ER6BP6EFsK04bmpO0a8hSsS/BeDHSMPyOd8JSxGPg1kUemtrDcZFGBuABWTqBbg/OEtN35fYqYfgb5Uc2v6Pi2uPtrcglShmod3/Z8cJkGYa1LulHR4KQ5T9QyZuxZmUx9eNW+sLjQkZy9chW8Olf2EO15CmbxxNCivSuK1MGV9g8y1+jMGtdo8PHHe0XVKWraBVRcP8M3WXL4vPJ6L0FM8oICo3iHCVr9LcM14/6s5pB1f5nYyNtrmagMPKtdHXt2bXjmVSuG4FrRqSN2Cv7yllysg4tCzrHz1LwT27qbio0fxfwJo52dc6k3BceWF8A6bo34dqBx85LwPIq8NytCVvE8vne7aeDTIpXMNNE8YfgmSVB8NZwIccAWr7oWMhMVSzDSmzCKCKhAjcx0yFM8j9YPf+uh8rrjU1CsJ+pp4s8GW5cxO5NRqRSS0rQvuy5KgtBdQ9d+smJhr3amNk6xuc+tAriom7FTN4lxVArodXefe7nXm8E3VGd6ptxtZefYA1v46lQTQW9dw6i5JMxRaO9yRaRN6oSp4A7hAaz+fwe3RiTHrJtyCOxMneqP7hTfjDJUqeEDUCmGbtNhKBpZc8A7xSksALvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(53546011)(110136005)(6666004)(6506007)(316002)(36756003)(6512007)(38100700002)(5660300002)(2906002)(508600001)(26005)(8936002)(66476007)(6486002)(2616005)(66946007)(4326008)(66556008)(86362001)(186003)(8676002)(31686004)(83380400001)(31696002)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0lUYVRjRWpyTStzaVB5c2JYNlJDeDJ3UWFEQzBENGRpd1NDdVRMWUZoMkxN?=
 =?utf-8?B?RmFtMGVYd1JRaTFXTlFzM0xEL1lLSTdsOUFzbDQvc0kvOTViRG5mUG84WTBW?=
 =?utf-8?B?TG83QWV4OTV6SE5EMEQ2dlZyYjV4cFlFTDE5c1VZTG9LMDgxN3orMFYrSmFJ?=
 =?utf-8?B?QjA0bnVta0FsenFNeENLUUoycGxPMVk1ajAva3ZBK3BWK0Z6N0ZxY1FUNGV5?=
 =?utf-8?B?enBZQlRQZ2hWQnVJS2EwMUV3Vkh5VlJPYjdMMkdpYnhaRFBhUmo0UHE4VFQ4?=
 =?utf-8?B?b0dyaDBvdjYzUE9DVnZCOVdvQzJYMjMrYisxbGhjdVA4V3Z2d3JIVDlJWVJQ?=
 =?utf-8?B?cHJ4TDdBQ05EOVFmQzFKUjlEQTQyR3Vwb1N3N2xGOWdKc0VFMTVEWU5QM2JQ?=
 =?utf-8?B?MlpNWFkreFdHNktPNHhLbjVza1habHFKb3UyQ0xjek5mQ3RrN2QwaXVSNzlh?=
 =?utf-8?B?RlhGZWpmaWJtV25WODZYL09Rd2RDaVNLdUlHNi9EU1JYQ2hlQkFQVTFoZDN3?=
 =?utf-8?B?VlpRL1oyaUIrZkJyczlMb2lGQ1NlYVdUY1lUUFZHUzlXcHVPQW93Q2JhbWVt?=
 =?utf-8?B?d0UzT0hKNzlWaTdZYXpOMG9qYlhCand3cGN6TG5DeWF5OXlubmtBb0ZzOHBK?=
 =?utf-8?B?WktvTGpBVGxDbFJxSy9vUGhkbVNjK2pWMXNiMFJvSUtZc0lGVWhHZ0lZSmVs?=
 =?utf-8?B?UFhFOTBORHBIbUI5MXIydjRreHE1S1lUU2pzbktjeUZtMGJJc1pYcm5jTU5R?=
 =?utf-8?B?WU05TmQzaW5lSER1OHpkZVNNUFA0RS9xbmJ4dzN6bmk5VmlFMk1hbmtCNm5p?=
 =?utf-8?B?QkRsRkdOWTNYbW8xZVFzRVFzeXVnZXgxRG15b29mZ01YUjl0N0Z6czhHcEoz?=
 =?utf-8?B?ZEdZY2ZNMHJYMG8wVnhGU0xwOGFJeWZKMGZmYjlFdkExREhNRi9zTUdBUkx4?=
 =?utf-8?B?aUpGdjQ3UE9aMVA1QXFlK21pcElUa3ljejNXc09mOXNrM1hyM28yRU0ralVl?=
 =?utf-8?B?N0k1UC90VTZmTFhORVhSVjNDV3daMEw5RDFuUU9BeUxMOUpXS1hkenR2RjFX?=
 =?utf-8?B?bnVidUNPSWhhQVZkMVQwOGlhWTJXOXVCNmNOT3ZJZ2tza3d3TGJGUEUxaXFM?=
 =?utf-8?B?a1pFU2J2UU84V1dnVG0xQ0RjS0pvWHhQSnVsVmYrQnh4bWVVb0ZDUzQyV1RY?=
 =?utf-8?B?bFhMRkJDc29RZ0ZMWGlqUldSbGVqRmNZMU93K2J6WXJPSGZQQzRRWjZmTVBj?=
 =?utf-8?B?bXdMM3RzMXhJVmQxWEJVL0R2cG9Qdm5mRUJPbEpleFk2MEFMZklydXU1VHF3?=
 =?utf-8?B?S05tR1JLb1dYeDh3MVRSM3RMak1vbjJCZHNpRzZIU3ZKRmtVdk1keEJyYUdo?=
 =?utf-8?B?ZjdPczVEYjQ1TFo0eWxsb3lxT05uZHBhb2hNRlpYWEJqcHBCKzJyNzU2RWJR?=
 =?utf-8?B?ZVFkQlNJY2I1bzFjQ3RkY2dBODFIQkExMGRNVlcyc3Y5cWlvS1JMa0Iyc0R5?=
 =?utf-8?B?SW8xMWVBWk0xbCtnZHZ0VXRJUitpNk9IR1c3di9MLzUrbmoxU2JjMVd3Y0pE?=
 =?utf-8?B?MXdQM0dtbUFNWXRrNTBnOWl1eHhxcVV5OUpUOEFvLzgxT3FlUklsbDJrV2ND?=
 =?utf-8?B?V1BhUGdiKzVOdEpsME9Gbk1pWXhpZFhqODFGWjl6YW92YUFHR2o1TXR4Mm5z?=
 =?utf-8?B?NDVnemNBUHJBNFR3MWphZXBiSVdWMitPSDlhSDRFWVlKZnp5cUFZK1pSRjNq?=
 =?utf-8?B?TXNpcitKQTJzOTdiMUtWSFpVU09BUmRYcVhQamRFR2wvelBmTUdwZ1lDUHpx?=
 =?utf-8?B?cXFIS1pQekJzcXpDMmtsR1JTQzNRdEVmN1ZaWnZHb3dhemN0M0RoWGhWUTA1?=
 =?utf-8?B?Y1JCK01WYmFZTHBjNmQxK0ZjTHJLUzBGYXgyT0NNMHQraGZraDA4VkNyUWdV?=
 =?utf-8?B?d1VPeG1GdlJKRFdCRGx0Snc2cEUrQjExQVFWaDNYUDlGa2xzajNpRUg1eUhZ?=
 =?utf-8?B?b2ZzWHJYREZmTzR3VTVvSEQ1RHNoZE1UeG1hZFpYbE94b3N4TU9UNmxnQ20z?=
 =?utf-8?B?U2VCb0MrRUFzMnpjblVtZ0RPZzlDbkNSZWtseThINnR0bWc3YVQ3bFA0Y3l2?=
 =?utf-8?B?TVI1ODFxVThRMGlDekxMOUkrcVhmQWlhY2FGVnM0dWJJWjlWeEJTLzNkSUcr?=
 =?utf-8?Q?Aj81hV6DU7PAIT3xnHWrIFg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c6f836-a6af-40ef-ba98-08d9df58eb12
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:45:24.5824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/CyvhjqQcENI+K0wkvfB56ibzk3CZOepg72Tuzr98QNcWKItbk6DXaQwNYqA7iQJT8sZmgwfcG1cI7vzNq3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3087
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

Hello Christian,
Thank for your comments, please fine mine inline:

On 1/24/2022 8:15 AM, Christian König wrote:
> Am 21.01.22 um 21:34 schrieb Sharma, Shashank:
>> From 1c5c552eeddaffd9fb3e7d45ece1b2b28fccc575 Mon Sep 17 00:00:00 2001
>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> Date: Fri, 21 Jan 2022 14:19:10 +0530
>> Subject: [PATCH 3/4] drm/amdgpu: add reset register trace dump 
>> function for
>>  gfx_v10_0
>>
>> Implementation of register trace dump function on the AMD GPU resets
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  8 ++++
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 53 ++++++++++++++++++++++-
>>  drivers/gpu/drm/amd/include/amd_shared.h  |  1 +
>>  3 files changed, 60 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> index d855cb53c7e0..c97b53b54333 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> @@ -537,6 +537,14 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>                __entry->seqno)
>>  );
>>
>> +TRACE_EVENT(gfx_v10_0_reset_reg_dumps,
>> +        TP_PROTO(char *reg_dumps),
>> +        TP_ARGS(reg_dumps),
>> +        TP_STRUCT__entry(__string(dumps, reg_dumps)),
>> +        TP_fast_assign(__assign_str(dumps, reg_dumps);),
>> +        TP_printk("amdgpu register dump {%s}", __get_str(dumps))
>> +);
>> +
>>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>  #endif
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 16dbe593cba2..05974ed5416d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -46,7 +46,7 @@
>>  #include "v10_structs.h"
>>  #include "gfx_v10_0.h"
>>  #include "nbio_v2_3.h"
>> -
>> +#include "amdgpu_trace.h"
>>  /*
>>   * Navi10 has two graphic rings to share each graphic pipe.
>>   * 1. Primary ring
>> @@ -188,6 +188,12 @@
>>  #define RLCG_ERROR_REPORT_ENABLED(adev) \
>>      (amdgpu_sriov_reg_indirect_mmhub(adev) || 
>> amdgpu_sriov_reg_indirect_gc(adev))
>>
>> +#define N_REGS (17)
>> +#define DUMP_REG(addr) do {                    \
>> +        (dump)[i][0] = (addr);                \
>> +        (dump)[i++][1] =  RREG32_SOC15_IP(GC, addr);    \
>> +    } while (0)
> 
> Those macros need an AMDGPU_ prefix and maybe some better names.

Agree, @Amar pls check this out.
> 
>  From the design POV I'm really wondering if it wouldn't be better if 
> userspace defines the registers we want to dump in case of a crash.
> 

I am not so sure about it. This means we have to communicate with the 
userspace and get the list of registers it wishes to see, do I smell a 
new IOCTL or DRM property ? I also feel that we have better filtering 
tools for a trace event in userspace than in kernel.

What do you think ?

- Shashank

> Regards,
> Christian.
> 
>> +
>>  MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
>>  MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
>>  MODULE_FIRMWARE("amdgpu/navi10_me.bin");
>> @@ -7488,7 +7494,6 @@ static int gfx_v10_0_hw_init(void *handle)
>>  {
>>      int r;
>>      struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -
>>      if (!amdgpu_emu_mode)
>>          gfx_v10_0_init_golden_registers(adev);
>>
>> @@ -7602,6 +7607,49 @@ static int gfx_v10_0_hw_fini(void *handle)
>>      return 0;
>>  }
>>
>> +static int gfx_v10_0_reset_reg_dumps(void *handle)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    uint32_t i = 0;
>> +    uint32_t (*dump)[2], n_regs = 0;
>> +    char *reg_dumps;
>> +
>> +    dump = kmalloc(N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
>> +    reg_dumps = kmalloc(1024, GFP_KERNEL);
>> +
>> +    if (dump == NULL || reg_dumps == NULL)
>> +        return -ENOMEM;
>> +
>> +    DUMP_REG(mmGRBM_STATUS2);
>> +    DUMP_REG(mmGRBM_STATUS_SE0);
>> +    DUMP_REG(mmGRBM_STATUS_SE1);
>> +    DUMP_REG(mmGRBM_STATUS_SE2);
>> +    DUMP_REG(mmGRBM_STATUS_SE3);
>> +    DUMP_REG(mmSDMA0_STATUS_REG);
>> +    DUMP_REG(mmSDMA1_STATUS_REG);
>> +    DUMP_REG(mmCP_STAT);
>> +    DUMP_REG(mmCP_STALLED_STAT1);
>> +    DUMP_REG(mmCP_STALLED_STAT1);
>> +    DUMP_REG(mmCP_STALLED_STAT3);
>> +    DUMP_REG(mmCP_CPC_STATUS);
>> +    DUMP_REG(mmCP_CPC_BUSY_STAT);
>> +    DUMP_REG(mmCP_CPC_STALLED_STAT1);
>> +    DUMP_REG(mmCP_CPF_STATUS);
>> +    DUMP_REG(mmCP_CPF_BUSY_STAT);
>> +    DUMP_REG(mmCP_CPF_STALLED_STAT1);
>> +
>> +    n_regs = i;
>> +
>> +    for (i = 0; i < n_regs; i++)
>> +        sprintf(reg_dumps + strlen(reg_dumps), "%08x: %08x, ", 
>> dump[i][0], dump[i][1]);
>> +
>> +    trace_gfx_v10_0_reset_reg_dumps(reg_dumps);
>> +    kfree(dump);
>> +    kfree(reg_dumps);
>> +
>> +    return 0;
>> +}
>> +
>>  static int gfx_v10_0_suspend(void *handle)
>>  {
>>      return gfx_v10_0_hw_fini(handle);
>> @@ -9367,6 +9415,7 @@ static const struct amd_ip_funcs 
>> gfx_v10_0_ip_funcs = {
>>      .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>      .set_powergating_state = gfx_v10_0_set_powergating_state,
>>      .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>> +    .reset_reg_dumps = gfx_v10_0_reset_reg_dumps,
>>  };
>>
>>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
>> b/drivers/gpu/drm/amd/include/amd_shared.h
>> index 257f280d3d53..76d3a55278df 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -296,6 +296,7 @@ struct amd_ip_funcs {
>>                       enum amd_powergating_state state);
>>      void (*get_clockgating_state)(void *handle, u32 *flags);
>>      int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level 
>> *level);
>> +    int (*reset_reg_dumps)(void *handle);
>>  };
>>
>>
> 
