Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DE1C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 09:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3F110FFAC;
	Thu, 10 Mar 2022 09:53:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 023B310FFAC
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 09:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owf8mY9Tv1VgrVM+ul8Vn8h7Le2pFU+6TH8iH1kxf6D2nepAGyASvyW6wAFgA5qhEoThat0KJ/rQIq29NHDmDCaQ75+k5PuJg4QN6LeuwHzD7bcSvjQX1jo7LwhI9sbOdO/lbPlM8GtzRo5GLgT81c3beQeRsf9pKrojFT/ZjRJ0K4fi6Jt8FcpLUsb8oa8LL/Veu/4yV19u1gHY3mvas4IXBSBygdvGi0OuPi2T9w1xi392uM4gE+XScPBEisyW8IbQ3IcelicYujECFjH54tf3xZXLxdjdtd5lAPimqBLQdoA7ZwMvVvAehJqPD7WTTmKxoOs8R12GYIosv9UwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/4yDMPNRVoDJyE8qe4sS/cptutHERlcPzw05Ww0eP0=;
 b=YX9EKjnOuJMVRKYLnaQyu4mrzSPQNseTgZl0zaYO+un8tkqK6iHzP9U/0xLk4Z3/KBKCSKD/6iP4bExdGUqD8JLQkr8874e70PgrzNrOBpQd1zn58xoysznKGFxKyODP2Nq2zh97SdC1skYFP85eR5GwqP/EpvPscC9EXSwAlOUDg6CcG2t90l/HZFcwGK9S5JgZIb2ERIvitS/BAqkQ66Jxg4WJdwk0C7vJ/NC5n8f0I3unURA6WCDVi/yrbe+eI3lFbvFfD8FzEXSMjp1TZCkib5KvADfCVmPSyd1D6NHg354eXE5eACYGIPn9ki5XRxjto3fVPfw75qO3BlHy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/4yDMPNRVoDJyE8qe4sS/cptutHERlcPzw05Ww0eP0=;
 b=UyZN5dH5o/bDblg1YmXybnT4+8qheRuQzqDqELfpEI/nvoiqj2EuDQ1EO52NVZHqz9jT5e/dA2TxoXmKohSGkPzivIT97HsXp3W/+XFuk5Y5UnssDb6F+SFWclGEOQasyfaeETQtBcArvTA/7+i0ex7QOaB0zF632hHEcSRqCq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY4PR12MB1608.namprd12.prod.outlook.com (2603:10b6:910:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.23; Thu, 10 Mar
 2022 09:53:09 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5038.029; Thu, 10 Mar 2022
 09:53:08 +0000
Message-ID: <f16e10f2-fa3f-7e63-c260-aaf1a70f8011@amd.com>
Date: Thu, 10 Mar 2022 10:53:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, Leo Liu <leo.liu@amd.com>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
 <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
 <YicOku9HhC3wJUb8@lang-desktop>
 <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
 <ec57da49-8a3f-852b-aaee-5bacdeb56c80@amd.com>
 <95e6f48e-fdc7-e535-1803-080a8d189d33@amd.com>
 <Yim6vIBYKLd3Uqxu@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <Yim6vIBYKLd3Uqxu@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0292.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e815d3ad-1a29-43f0-f9d5-08da027bc7d6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1608:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16085EC29113A795555E5DF6830B9@CY4PR12MB1608.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/NuNZkQB1aEibNAs7N0nnSZofrS+wYN9h3r3DPdNNwiuTkDCRMP/WEsqvnDs1sKZqQt+XwulJCppsW8PtK/EGr8VW6OprwGgOOocw5tcv3i8zVpA3acDXoqjVI3dTx/ljIbvqc7Tc4kYDla0JDPj+5qiU658XfhybxayfPxjWnASQctExiwGyDGUj3kJtVdHU1e1MBW46uryp4/0WAn0KhC1L9rLUBtuZQjjH3uw1LmDnUcu2iyRQsUfYexh5GEZ+AM/gKM5JExz8hy9wnJiStyoovVn0XM5bpq19Zxx5UYvp4rkx3zw67d54bmE5qR7zOvfUvMGRkjzxsNSIeYSBujt9vjgEBwqGXFZcsCM/NRXGj3TzY6iML5u8Hi1I6OWUdOgd48IAObY8DIg2Pa2Cm+/6hGo5UT3lVMOfEp6L7BohON90Ht5oGpPOPsE6kux2NCR22RHualeVRnCoK+xvFpB0PzGxhjLdsffBGy2KXO+jTr+rRAV4ObHmsI40c8BNmgu8Ige4y/SNbsoE7dASoU9PKBSAW78IxWDMmO/coK3EXb7BIxy6eLhD1QcHHJ6hMtqeCq/OFXukwZ6SQKHCXXPLWYmeh7g6dfL/ICQwNANowhv81Y6EXVkJZrKLyFn70fpZ0jMhHsYS9nfz2UHvbLLiMu/W86UBrGjkwArWqVNwmGNJPeSRle+uyviP9Hj/vLtRNqP4t6A0BuqIcWgNNjg619NW5iDB/8p0dYl/PUVCyEAkcdi/DP9h9HL2hz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(84040400005)(110136005)(31686004)(6486002)(2906002)(8936002)(36756003)(31696002)(316002)(6636002)(6512007)(186003)(83380400001)(2616005)(86362001)(53546011)(66476007)(6506007)(66556008)(66946007)(4326008)(8676002)(508600001)(66574015)(6666004)(38100700002)(5660300002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUJpbCtnSE9rdWxVQjVLSmpSS01SM0xwR1pTT244MnZrNlZWNUxtWXJ2VHIr?=
 =?utf-8?B?STNGL1JyTk45bjhmUEw4c201QXF2TWlxNXVraGx1U2VoVVNzRW11YXhFQlpt?=
 =?utf-8?B?Skp4SlUrZ3M2aU0rU3VaM24xWGZYTjRmUFZJQmtyZmg3WFE4NEVxcmJHRUlG?=
 =?utf-8?B?VUtaVm5sdWV0OUFFVTROQk9HQXJDVjhHTSt3SDNMaXhRMjFteUYzQXZUdGN4?=
 =?utf-8?B?a1N1RHpuNnZiQUo0WGh1OFJpNWo2Ykl2c0lKWXU2VFFuaU13djRKa2ZtMkJp?=
 =?utf-8?B?Y0tUZnNidzBKTXY3UGRIMzljV2FEMVE1QzB4WFRVbERWcWxjN3Y1cHJHZDVB?=
 =?utf-8?B?NVQ1ZTV0SHFYUGZxN2kwMWxmRnRONy9Ncnd2SHVleCtIYng4cFM0QmVURXhU?=
 =?utf-8?B?SWhsT1lpSk9URFpvTDZKNjJrZDROSGRXOWhkcjlpK3g5WStob3NIeWZwd1B4?=
 =?utf-8?B?WHF1Mk1wN1QzZjV0Y1UrRGZMYkVkYldXSGUzbHZZSXBwaFJpZTAwK0tROHJR?=
 =?utf-8?B?Ylk5L3BMYXJnQ1pqT0hpYWpLcG9QbzVHdUtDaVFObUNYdkNOQ3MrOFlFSVYx?=
 =?utf-8?B?MUJzSnFpa2x2V0JzMjJMN0ZpNjNJL3hGRTA4enFPYjYxMmZxUExCY3hFQi9o?=
 =?utf-8?B?SXJXdnRTWk5Sa1gxUkxQUDk0MXBvdVhiRXp5VERObEY0NERHWWdCNUNuQUhJ?=
 =?utf-8?B?N1F4cmw2MloyL2hObkxXeG9tek5SR0VNdmRGTWwxdEkvZmFNTERWb2lEOWNu?=
 =?utf-8?B?VlR5NXVsa3pqVTJORG1xT1RUTVhYQ2FDSGV6Y09CeUNnTEdYOEx3YlFNNVNE?=
 =?utf-8?B?WkJiQkhKanlRY3ZjMjFBZHRvQkVySVNDUFZ6Q2ZsMkFhcE5xQWtBK09LWE5Q?=
 =?utf-8?B?bERQVjFSWlNadHZ3REF0U2VIWmdsU3RYWndoZ3VTMW1mQjNocFZHZis1QmpK?=
 =?utf-8?B?YzBjV1pJQjJ3bFdCMEFkakxuN2wvcWg2UkwxOGRMb3R1aEJNb3l5ZG95ekxX?=
 =?utf-8?B?RjRocFB1NjJtdDRBWmNIdEJGaHpBRHM2U2VNMURIb1NtQjJvaXY0VFNmbDht?=
 =?utf-8?B?c1NSV2NMVnlpVkxGY2xNYkVTenBsVmwwU1VJZDRvbjI3SzJlMW1UU25EZ1BN?=
 =?utf-8?B?Zy95UHRLUGMrRzBHUXVrN2dXNUxWaW9Cdlhqb2w4RUVEZWJFaFlYekMvTisx?=
 =?utf-8?B?ZE5Tdm5sT1R1dllqaEFsd1FnV3luZ3VnV3VjWDdBd3QvUmxhTksvL2xCbzdM?=
 =?utf-8?B?alh2OU5UQVRXZ3hBREdOcmVKRVYvdEErV0tnSXJKRFlZdW4weGFuWWxGaE96?=
 =?utf-8?B?T3pzZFpsRHowYXB6bEhiU243blVEb1kxUklzVTdNZXI3L2JLY0oxVzg5a3hW?=
 =?utf-8?B?K3dMbEtwWHVqNUJwa2t5ajk3K0R1VHlkakVodVhsbjFpUWszSWNMMFEwS1lD?=
 =?utf-8?B?cmgwV1ZhanhOelZNK2JOSHozUnFtK2ZzTXI3dS9MSlFuZFZLc1RZYittQkhz?=
 =?utf-8?B?RzJGSWNBd1pDN3MxMHhxQzdqWFhaM05iTExtWklTQ0twWXI4eEUrSTBNZXQ1?=
 =?utf-8?B?bStIczQyY2tSd2lxQXdWSEJlcXowMDV6aUZPbkFGUTNOUTVXYkN5dXRnenQ2?=
 =?utf-8?B?OWhkcU5qVkdOM0VRVzYwVlcxcThlMWRQRmdaSWJIWkZsNGJLZ0FzME1uRDJK?=
 =?utf-8?B?dHE3c09JNUFLaG1Relo4OUNPRjc5aFNsNHZCYVpCWU52UW9iMXZPZUF3Ynpw?=
 =?utf-8?B?dlhTVytlQWdQYVNadGEzVFFKZjJjdHdLZGltQkl6NE52ZEtrZmhuM3krZGVS?=
 =?utf-8?B?blZPdTdGRmhTdnB3VTZBaFJYTGt4ZXZRT0N2Z1pFQjlNNGdpYVBrU3JQQy82?=
 =?utf-8?B?NEhLTU1Ba3hxZ1BxMlNRaVUrTzFBenJ0bGRFVHRKbWtlNnVUZEFnSlQ3NHlT?=
 =?utf-8?B?ZnB6SjZ4cGh3UzNrcyt3S0ttTHFwektRbzFCTjZudDRXdVQxQXpUcURRK0sr?=
 =?utf-8?B?cGRYQVE0aW1RdWFUc2FVa01OR1ZZZkZFOFpjYUtZRFdKbFZ6bVNQYjRQYjdp?=
 =?utf-8?B?ODJ1UWRyMXhkMEM2U2Zsa2hHMFdsbFVlNjRzZFB1OUxXTGg5OEhiekV1VWVs?=
 =?utf-8?B?TVpMTE55MmNURHp0ZlY3VHlKUTRGcjRSV0N3d0JrN3EwR3RSVE11L1pTWkhj?=
 =?utf-8?Q?n3HklfDa9bHk6AlMSFko/3M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e815d3ad-1a29-43f0-f9d5-08da027bc7d6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 09:53:08.5677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSMnk6kCkEI4LGfvNvj3qRN/NleutrpKXdbdihY3yj8pfEmAO6TgMn3F5+2vUv+h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1608
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>, "Zhu,
 James" <James.Zhu@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Leo you didn't answered the question if we need TMZ for encode as well.

Regards,
Christian.

Am 10.03.22 um 09:45 schrieb Lang Yu:
> Ping.
>
> On 03/08/ , Leo Liu wrote:
>> On 2022-03-08 11:18, Leo Liu wrote:
>>> On 2022-03-08 04:16, Christian König wrote:
>>>> Am 08.03.22 um 09:06 schrieb Lang Yu:
>>>>> On 03/08/ , Christian König wrote:
>>>>>> Am 08.03.22 um 08:33 schrieb Lang Yu:
>>>>>>> On 03/08/ , Christian König wrote:
>>>>>>>> Am 08.03.22 um 04:39 schrieb Lang Yu:
>>>>>>>>> It is a hardware issue that VCN can't handle a GTT
>>>>>>>>> backing stored TMZ buffer on Raven.
>>>>>>>>>
>>>>>>>>> Move such a TMZ buffer to VRAM domain before command
>>>>>>>>> submission.
>>>>>>>>>
>>>>>>>>> v2:
>>>>>>>>>      - Use patch_cs_in_place callback.
>>>>>>>>>
>>>>>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68
>>>>>>>>> +++++++++++++++++++++++++++
>>>>>>>>>      1 file changed, 68 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git
>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>> index 7bbb9ba6b80b..810932abd3af 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>> @@ -24,6 +24,7 @@
>>>>>>>>>      #include <linux/firmware.h>
>>>>>>>>>      #include "amdgpu.h"
>>>>>>>>> +#include "amdgpu_cs.h"
>>>>>>>>>      #include "amdgpu_vcn.h"
>>>>>>>>>      #include "amdgpu_pm.h"
>>>>>>>>>      #include "soc15.h"
>>>>>>>>> @@ -1905,6 +1906,72 @@ static const struct
>>>>>>>>> amd_ip_funcs vcn_v1_0_ip_funcs = {
>>>>>>>>>          .set_powergating_state = vcn_v1_0_set_powergating_state,
>>>>>>>>>      };
>>>>>>>>> +/**
>>>>>>>>> + * It is a hardware issue that Raven VCN can't
>>>>>>>>> handle a GTT TMZ buffer.
>>>>>>>>> + * Move such a GTT TMZ buffer to VRAM domain
>>>>>>>>> before command submission.
>>>>>>>>> + */
>>>>>>>>> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
>>>>>>>>> +                struct amdgpu_job *job,
>>>>>>>>> +                uint64_t addr)
>>>>>>>>> +{
>>>>>>>>> +    struct ttm_operation_ctx ctx = { false, false };
>>>>>>>>> +    struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
>>>>>>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>>>>>>> +    struct amdgpu_bo_va_mapping *mapping;
>>>>>>>>> +    struct amdgpu_bo *bo;
>>>>>>>>> +    int r;
>>>>>>>>> +
>>>>>>>>> +    addr &= AMDGPU_GMC_HOLE_MASK;
>>>>>>>>> +    if (addr & 0x7) {
>>>>>>>>> +        DRM_ERROR("VCN messages must be 8 byte aligned!\n");
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    mapping = amdgpu_vm_bo_lookup_mapping(vm,
>>>>>>>>> addr/AMDGPU_GPU_PAGE_SIZE);
>>>>>>>>> +    if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +
>>>>>>>>> +    bo = mapping->bo_va->base.bo;
>>>>>>>>> +    if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
>>>>>>>>> +        return 0;
>>>>>>>>> +
>>>>>>>>> +    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>>>>>>>> +    r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>>>>> +    if (r) {
>>>>>>>>> +        DRM_ERROR("Failed validating the VCN
>>>>>>>>> message BO (%d)!\n", r);
>>>>>>>>> +        return r;
>>>>>>>>> +    }
>>>>>>>> Well, exactly that won't work.
>>>>>>>>
>>>>>>>> The message structure isn't TMZ protected because
>>>>>>>> otherwise the driver won't
>>>>>>>> be able to stitch it together.
>>>>>>>>
>>>>>>>> What is TMZ protected are the surfaces the message
>>>>>>>> structure is pointing to.
>>>>>>>> So what you would need to do is to completely parse
>>>>>>>> the structure and then
>>>>>>>> move on the relevant buffers into VRAM.
>>>>>>>>
>>>>>>>> Leo or James, can you help with that?
>>>>>>>    From my observations, when decoding secure contents, register
>>>>>>> GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ
>>>>>>> buffer address.
>>>>>>> And this way works when allocating TMZ buffers in GTT domain.
>>>>>> As far as I remember that's only the case for the decoding,
>>>>>> encoding works
>>>>>> by putting the addresses into the message buffer.
>>>>>>
>>>>>> But could be that decoding is sufficient, Leo and James need
>>>>>> to comment on
>>>>>> this.
>>>>> It seems that only decode needs TMZ buffers. Only observe
>>>>> si_vid_create_tmz_buffer()
>>>>> was called in rvcn_dec_message_decode() in
>>>>> src/gallium/drivers/radeon/radeon_vcn_dec.c.
>>>> Mhm, good point. Let's wait for Leo and James to wake up, when we
>>>> don't need encode support than that would makes things much easier.
>>> For secure playback, the buffer required in TMZ are dpb, dt and ctx, for
>>> the rest esp. those for CPU access don't need that E.g. msg buffer, and
>>> bitstream buffer.
>>>
>>>  From radeon_vcn_dec.c, you can see the buffer for dpb and ctx, and dt
>>> buffer frontend/va/surface is set to PIPE_BIND_PROTECTED.
>>>
>>>
>>> Regards,
>>>
>>> Leo
>>>
>> For VCN1, due to performance reason, the msg and fb buffer was allocated
>> into VRAM instead of GTT(for other HW), but those are not TMZ in order to
>> have CPU access.
>>
>>
>> Regards,
>>
>> Leo
>>
>>
>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>> Lang
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Regards,
>>>>>>> Lang
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +    return r;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int
>>>>>>>>> vcn_v1_0_ring_patch_cs_in_place(struct
>>>>>>>>> amdgpu_cs_parser *p,
>>>>>>>>> +                       struct amdgpu_job *job,
>>>>>>>>> +                       struct amdgpu_ib *ib)
>>>>>>>>> +{
>>>>>>>>> +    uint32_t msg_lo = 0, msg_hi = 0;
>>>>>>>>> +    int i, r;
>>>>>>>>> +
>>>>>>>>> +    for (i = 0; i < ib->length_dw; i += 2) {
>>>>>>>>> +        uint32_t reg = amdgpu_ib_get_value(ib, i);
>>>>>>>>> +        uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>>>>>>>>> +
>>>>>>>>> +        if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
>>>>>>>>> +            msg_lo = val;
>>>>>>>>> +        } else if (reg ==
>>>>>>>>> PACKET0(p->adev->vcn.internal.data1, 0)) {
>>>>>>>>> +            msg_hi = val;
>>>>>>>>> +        } else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
>>>>>>>>> +            r = vcn_v1_0_validate_bo(p, job,
>>>>>>>>> +                         ((u64)msg_hi) << 32 | msg_lo);
>>>>>>>>> +            if (r)
>>>>>>>>> +                return r;
>>>>>>>>> +        }
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +
>>>>>>>>>      static const struct amdgpu_ring_funcs
>>>>>>>>> vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>>>>          .type = AMDGPU_RING_TYPE_VCN_DEC,
>>>>>>>>>          .align_mask = 0xf,
>>>>>>>>> @@ -1914,6 +1981,7 @@ static const struct
>>>>>>>>> amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>>>>          .get_rptr = vcn_v1_0_dec_ring_get_rptr,
>>>>>>>>>          .get_wptr = vcn_v1_0_dec_ring_get_wptr,
>>>>>>>>>          .set_wptr = vcn_v1_0_dec_ring_set_wptr,
>>>>>>>>> +    .patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>>>>>>>>>          .emit_frame_size =
>>>>>>>>>              6 + 6 + /* hdp invalidate / flush */
>>>>>>>>>              SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +

