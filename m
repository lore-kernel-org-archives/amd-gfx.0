Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56054C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECEC710E1F6;
	Tue,  8 Mar 2022 16:18:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB3310E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFE59AJ88gFHzRoURNYtDCUzIINUHSIZiCC6FnJttkIbWBcuhnOOhu8X86bnDCks+Idw7CjOZGF6/8uMD8F7B2137xQwtzrGXXIbbtFhptCWPJfmeltDIOK7KdAoLZMLWgBMxhXOd9bzVKSman3odY01GNsBQDkhQAYXK3SLewta9geeUBVg+VPCNBSxDTU10ln2pWaS4rk60R/Uz4A1NoESMmQ4uzClIL5u734k46QNDbOw1h8/8A6ZuYLUzOglwvRytsV3vVj/tFdtOPQgM5/RS+SsCiZa4MFnHA6pUeOCZfD2tlUKAScv4j0kYjcCQF2CG2cby3osDp1tyGl62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iieaLhYRJT10+9VJmKjfxuzHNWSKV//nRzxTpCzH2Yk=;
 b=TGfvVhlPPr0NrJJ7SsGMQyNZ+v2KxgPjESLShUf0H2oMF6IjdvR307qYXn/hH/vpWJzj9LkCZonyESjTFDC3/qhcC+fAFaLISVsYcZPqg2HJBhAlZsSPpr2gNUAP5FWBI34/3kcdxGgy0s79LJ8b+0ENfmmlc2w8YrLLI254O/v4j2I2PZppJzMpZY6zKHXFkg+91C0CiwpOQCjswPlQfdBneM9UqEt/3ScQLq4WTOshut4RoQq3fwCvXoFqaiXYQGVcMH/5/MQxq0Zcz9MjIqpUTiZlk+Fj32NSI2Ev8UiVG7qfN/wqSzS7uuOqlaL9GU003glors0NSSZX6BrQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iieaLhYRJT10+9VJmKjfxuzHNWSKV//nRzxTpCzH2Yk=;
 b=W9VR+mU9ncErgEzZ00P9BmTIk/X7VYJanbeLUx6N+iGxVWZUnvdRmneNUzJZYBYISUK6Xl5WTyJm41JayS81UNVl2Ind7KzyovtMOsTe59DaUIedTOv3VC3EfdXEb2veY9eLYLzM/ChKscdG+HoZcGsntrAjbKsO9tD8d2dH3TQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 16:18:45 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::19ab:5c87:f10d:51cb]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::19ab:5c87:f10d:51cb%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:18:45 +0000
Message-ID: <ec57da49-8a3f-852b-aaee-5bacdeb56c80@amd.com>
Date: Tue, 8 Mar 2022 11:18:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <ckoenig.leichtzumerken@gmail.com>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
 <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
 <YicOku9HhC3wJUb8@lang-desktop>
 <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6935271e-9d36-4e0f-5567-08da011f517d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1830:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB18304D4D462398A4DF345707E5099@CY4PR12MB1830.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfhdNWoz3Cgy3CmdF+6tbaaVJhoKknKLpOFG3KtObAlBQxsooKWGRf+SDVrz6OcaqRysAoyvynyDR2gYBZnE7PySRVer8Sm5bZGaItVBtsEgNlJHCuZ2JTUv7979B4g7F99KfzS6L3S9QI6rPJ4j5yztwl4ecE2M9uSJlos+Bs7sMOg3QS+xhktru2frAc1+eUcsQE6mvMxLJ4yGejIkz3GiqCzBzhkKQXze/TzqLTX4VGmsz7qMNCID4/nx9kJG6Yg0yyc5KR/10VfCIyIrLUx0Rxye/kh2rmFmYSEJV7R744D0jsDOEG6cxSC+2gzav9yzYf+SKFx4HO0SP25ALUeiU8lGbR9Im0j7MGdYoQkH0lq32AvOhNVGfo1l3lDJPJJ45lC6G4mz5SjsoCE4MM6zXZOTrcZntfSWZ/5OaRQgJZ5odVSX52sPO3qRHAt1Fv0zyTZgBkkjjFZ58PPEp06LyRxPypeJP+qcrBHPibYNxZgLovl9RSQ3YqkKbaJ2DLq1b1/4qpIeWKizlqE4BlMsbupTHmQjthIKn8d3WVR9uJc2OqCeJKNuOHPP9X8l5pGogvLODhyrDNwN0JtDbdOXntNmyUiS+6kJpdljljogOYLm9x9Q13DQwl0JFMMRqPviB0hK+V56ZwGkZpsmXLyaIe/nyBm4lUKEekmwlZmAEuLAi1SDOswrh58Tm2MwEsw3SEuCVe3LQ5Uz7Ng59LJOK9OeMRuCVK8E/4myQXkESpKLgsRlIjrKsXIDdqDm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(84040400005)(38100700002)(316002)(2906002)(26005)(6506007)(186003)(31686004)(508600001)(2616005)(53546011)(36756003)(6512007)(6486002)(4326008)(86362001)(5660300002)(66946007)(66476007)(8676002)(83380400001)(31696002)(66574015)(66556008)(8936002)(110136005)(54906003)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZ5MCtmSk5NaWM2MU52eDMvV3Fxc2tQR2VJc1FnV1F6SVRobGNqMjBMSTJt?=
 =?utf-8?B?aU1jZ3JxQ2ZvM3diSWlRT09XN0JLczVhUnQ1UHduSG1wTFVXY0dYTGlkTUpy?=
 =?utf-8?B?eVcrdHZpMnlrQmpNYUl1QlVjZ3ZaUDl0a3BxZ3JHemZEWVdqc25USFhVb3p4?=
 =?utf-8?B?L2tlTk12NkJaNml0ck9uMlVaeFQzU1Z3NEhmMTcrNzFzWTRIUWZUeDAwYTZh?=
 =?utf-8?B?K0FlWVRBbkdSSThUUDlRNi9NYm9sNVFtWHN3dEFiTlVUL2g0eUFUYnRRQm1B?=
 =?utf-8?B?Yld5cHA4V1h2QXRQNmEycWUzWXJ3Q3VkL0VsSk9saENGcnc5VzRQUHZUeFpx?=
 =?utf-8?B?dkp5TmMzMmdGTDI1QWxWbjZQSEswejlzdE9tM2I0SHY1bjZUcGl0Sk1iWW90?=
 =?utf-8?B?bHU3WEZobHM4L0ttMzBmMjNUeFJ5c2hpOUJCVVlGN0FBVGZVT25RWUE2OGta?=
 =?utf-8?B?QUFkMTROU3FqeWU0TlNHSHRtbzlKNDI5bDhMSkJoRUIxNDJIU2NtZGV1ZjJE?=
 =?utf-8?B?VjQwYlFlRDNyWkpaV1JscXhoWkRLdGZ4SDFpSDBFbE94OUNWanBiOUdkZ2NP?=
 =?utf-8?B?VWQzWnF3TGlJZHFQLzM0VlhkMnBRYURrVTduU0tGMTB6bStFeTBZQTNPcUh0?=
 =?utf-8?B?ck9wWU5DQndrMWxVcmZSdGVJUUgwRWJlK3BtYTlMNHNNbUlWOFVGQTBscktG?=
 =?utf-8?B?RUJCdkIzZVBud2xXWmkzVE5ScEgyNDBqaU5QZndOZEV0Umgrb0sraTMxLzZ1?=
 =?utf-8?B?NEJrLzlnTExLWVgyc1BXVGpZUVRaODRuemdkRy9OWVpIOU1qRllpWkNaaXp0?=
 =?utf-8?B?ZVJwMUs3RnhKSUdNczJzKzJOSjdYb0gyWnExYUxveUQ1WFZJR3BmZlYyTnRm?=
 =?utf-8?B?MWxma29hck16UWtLQ3YrY3ZHNUdiQXoxTTZlYlFoRHo1bzYwc1FhT1BXTWIy?=
 =?utf-8?B?WnEycUplZXB5aUI1RjZRaVhsSDlrTkhEOHdjZlpmVDNaU05NTzVoamR2WnFS?=
 =?utf-8?B?V2tTaHMvdVlYNkxmaVUrV3pHbXR0WnhvM0N4bDNLZVgyaElVT2pSR29LWlF5?=
 =?utf-8?B?TTREZU1WSmpKMGFLSUNZWU9HTE1sUDZYdWgwanloN2x3bFpsdmErQ1UrNkhq?=
 =?utf-8?B?dDl2ZzZtYmkwZWZsR05TUi8xeGZ0Tk9PM0xQanRNY1pVb1pNYk5HdzNuODI3?=
 =?utf-8?B?Umo4dUV3Ymo2TzRlSTMwTEFGSTVLeXNYRVRsMGJjKzArNkhrN05OWGdtN3Rr?=
 =?utf-8?B?Z3haRS9sU0VPR1hsQ2pFOFJ0RStPZ0NwbERCNWVTUE4xVkRkdmVNalUyTERD?=
 =?utf-8?B?djdRY2JtekdVVmpPK1lxbjhxa0pjeGUxUm9FMVNhdU9MNVl1cS9KYTBxL2Jq?=
 =?utf-8?B?czZCcTJONVA5N3MwVTNvVS9YOUkwK09sRTFxN2hUZVM3Z1kwSENObUlPeVlu?=
 =?utf-8?B?YkpuOWxNSGxnNGxiOEtRTDhPRWZRNEpxcHFPTGprTXpqYlBBcDRneEpBOXpv?=
 =?utf-8?B?VHhjK0VLQ25pQVJqZng5d2lRdWprTUJkTWxhMkd2OTNGek90WXZweHJnV2NS?=
 =?utf-8?B?RW12blpoVHhKQzRVMEpobmJHS2oyZFdWYUdGbDlUak44REVzc3ZGOWc2UnRs?=
 =?utf-8?B?N0xLRkdRbGVSY1ZoZ1c0UnZuZlRJZjE1MDNkY3N4UFI0QW9pWlZzK1lsa2VW?=
 =?utf-8?B?blV3d2NDY3doSk9xejBYWnpaQmdkUTVOUWdzbjdYamh0MXhtNmFQZklDU05y?=
 =?utf-8?B?dFp1bmlrWllxdCtCZmlCMmVySWdlbXdJNi94V3NJVGxkRVZrMWVjMVVESm9o?=
 =?utf-8?B?REo0amRaeHk2dzNyVytFUUtucnRKT08wQ3RRRTFuaFUzT0lYZFBxTUVnZXJC?=
 =?utf-8?B?R1M1MWZ1Yk90dnBwbVdPcnJHdzRoN1JWSmIvcEI3VzQ0MFdWYTBlS2R5MTI1?=
 =?utf-8?B?akdJOEZ6WUdFSlkxd09BSkdoN3JqV0lUSWFyYlhYV1d0L0hmYzV0NGhBU0Uw?=
 =?utf-8?B?RjRZMjRkQTNqalVjTG4xU3c5b2c2cGxhSFNjclJNQTBWRUp2cnd4NmFVNFVv?=
 =?utf-8?B?cG9odkR5dTV1WXFFaVZueE5Da3ZyYyt6WmVlelRTMHhzZlV3b0JIV2o1RWdu?=
 =?utf-8?Q?OBgQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6935271e-9d36-4e0f-5567-08da011f517d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:18:45.5858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4UF93ZR/U/k9UFGW/rhBGKa3JzG+MMKC22uFo9DgdGrzJ6GZQEMpBLKN7FnxNUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-03-08 04:16, Christian König wrote:
> Am 08.03.22 um 09:06 schrieb Lang Yu:
>> On 03/08/ , Christian König wrote:
>>> Am 08.03.22 um 08:33 schrieb Lang Yu:
>>>> On 03/08/ , Christian König wrote:
>>>>> Am 08.03.22 um 04:39 schrieb Lang Yu:
>>>>>> It is a hardware issue that VCN can't handle a GTT
>>>>>> backing stored TMZ buffer on Raven.
>>>>>>
>>>>>> Move such a TMZ buffer to VRAM domain before command
>>>>>> submission.
>>>>>>
>>>>>> v2:
>>>>>>     - Use patch_cs_in_place callback.
>>>>>>
>>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68 
>>>>>> +++++++++++++++++++++++++++
>>>>>>     1 file changed, 68 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>> index 7bbb9ba6b80b..810932abd3af 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>> @@ -24,6 +24,7 @@
>>>>>>     #include <linux/firmware.h>
>>>>>>     #include "amdgpu.h"
>>>>>> +#include "amdgpu_cs.h"
>>>>>>     #include "amdgpu_vcn.h"
>>>>>>     #include "amdgpu_pm.h"
>>>>>>     #include "soc15.h"
>>>>>> @@ -1905,6 +1906,72 @@ static const struct amd_ip_funcs 
>>>>>> vcn_v1_0_ip_funcs = {
>>>>>>         .set_powergating_state = vcn_v1_0_set_powergating_state,
>>>>>>     };
>>>>>> +/**
>>>>>> + * It is a hardware issue that Raven VCN can't handle a GTT TMZ 
>>>>>> buffer.
>>>>>> + * Move such a GTT TMZ buffer to VRAM domain before command 
>>>>>> submission.
>>>>>> + */
>>>>>> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
>>>>>> +                struct amdgpu_job *job,
>>>>>> +                uint64_t addr)
>>>>>> +{
>>>>>> +    struct ttm_operation_ctx ctx = { false, false };
>>>>>> +    struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
>>>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>>>> +    struct amdgpu_bo_va_mapping *mapping;
>>>>>> +    struct amdgpu_bo *bo;
>>>>>> +    int r;
>>>>>> +
>>>>>> +    addr &= AMDGPU_GMC_HOLE_MASK;
>>>>>> +    if (addr & 0x7) {
>>>>>> +        DRM_ERROR("VCN messages must be 8 byte aligned!\n");
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>> +    mapping = amdgpu_vm_bo_lookup_mapping(vm, 
>>>>>> addr/AMDGPU_GPU_PAGE_SIZE);
>>>>>> +    if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>> +    bo = mapping->bo_va->base.bo;
>>>>>> +    if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>>>>> +    r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>> +    if (r) {
>>>>>> +        DRM_ERROR("Failed validating the VCN message BO 
>>>>>> (%d)!\n", r);
>>>>>> +        return r;
>>>>>> +    }
>>>>> Well, exactly that won't work.
>>>>>
>>>>> The message structure isn't TMZ protected because otherwise the 
>>>>> driver won't
>>>>> be able to stitch it together.
>>>>>
>>>>> What is TMZ protected are the surfaces the message structure is 
>>>>> pointing to.
>>>>> So what you would need to do is to completely parse the structure 
>>>>> and then
>>>>> move on the relevant buffers into VRAM.
>>>>>
>>>>> Leo or James, can you help with that?
>>>>   From my observations, when decoding secure contents, register
>>>> GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ buffer address.
>>>> And this way works when allocating TMZ buffers in GTT domain.
>>> As far as I remember that's only the case for the decoding, encoding 
>>> works
>>> by putting the addresses into the message buffer.
>>>
>>> But could be that decoding is sufficient, Leo and James need to 
>>> comment on
>>> this.
>> It seems that only decode needs TMZ buffers. Only observe 
>> si_vid_create_tmz_buffer()
>> was called in rvcn_dec_message_decode() in 
>> src/gallium/drivers/radeon/radeon_vcn_dec.c.
>
> Mhm, good point. Let's wait for Leo and James to wake up, when we 
> don't need encode support than that would makes things much easier.

For secure playback, the buffer required in TMZ are dpb, dt and ctx, for 
the rest esp. those for CPU access don't need that E.g. msg buffer, and 
bitstream buffer.

 From radeon_vcn_dec.c, you can see the buffer for dpb and ctx, and dt 
buffer frontend/va/surface is set to PIPE_BIND_PROTECTED.


Regards,

Leo



>
> Regards,
> Christian.
>
>>
>> Regards,
>> Lang
>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards,
>>>> Lang
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> +
>>>>>> +    return r;
>>>>>> +}
>>>>>> +
>>>>>> +static int vcn_v1_0_ring_patch_cs_in_place(struct 
>>>>>> amdgpu_cs_parser *p,
>>>>>> +                       struct amdgpu_job *job,
>>>>>> +                       struct amdgpu_ib *ib)
>>>>>> +{
>>>>>> +    uint32_t msg_lo = 0, msg_hi = 0;
>>>>>> +    int i, r;
>>>>>> +
>>>>>> +    for (i = 0; i < ib->length_dw; i += 2) {
>>>>>> +        uint32_t reg = amdgpu_ib_get_value(ib, i);
>>>>>> +        uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>>>>>> +
>>>>>> +        if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
>>>>>> +            msg_lo = val;
>>>>>> +        } else if (reg == PACKET0(p->adev->vcn.internal.data1, 
>>>>>> 0)) {
>>>>>> +            msg_hi = val;
>>>>>> +        } else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
>>>>>> +            r = vcn_v1_0_validate_bo(p, job,
>>>>>> +                         ((u64)msg_hi) << 32 | msg_lo);
>>>>>> +            if (r)
>>>>>> +                return r;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>>     static const struct amdgpu_ring_funcs 
>>>>>> vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>         .type = AMDGPU_RING_TYPE_VCN_DEC,
>>>>>>         .align_mask = 0xf,
>>>>>> @@ -1914,6 +1981,7 @@ static const struct amdgpu_ring_funcs 
>>>>>> vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>         .get_rptr = vcn_v1_0_dec_ring_get_rptr,
>>>>>>         .get_wptr = vcn_v1_0_dec_ring_get_wptr,
>>>>>>         .set_wptr = vcn_v1_0_dec_ring_set_wptr,
>>>>>> +    .patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>>>>>>         .emit_frame_size =
>>>>>>             6 + 6 + /* hdp invalidate / flush */
>>>>>>             SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>
