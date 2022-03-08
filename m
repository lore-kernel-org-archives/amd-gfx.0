Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E26FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 19:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64D710E3FF;
	Tue,  8 Mar 2022 19:23:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4901610E3FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 19:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT9MypV99WlnendbtcBpSEWpVACX1TXJUNBCX2+5QmgxLXrnbceTgGDWR++t5OkFJJh5PC1gjDx32JLTlfUOtgbpWbkI/ASJWH6ENpO3NBJjo5zfMx9/Tz2PW1/bN/O5mPz7x6R7jLLVGBosTVn2s8QniqmLVQ270QKnLEbQNj/ah5mT1JUez+v0sZleHWsm7OF1qX63le8Q4E+vp4ycLgFvR7rQ4PS8keT6Org0oKUknSW3ytaEGRYvGHDEjHrJkoJcFeLm4JmKCsO7Cm+II+blIIJJwGEs0re21qWyuSkHu4U5WMFW9cG8wQA8kI0VyBrke+3tdNVnLrfgOapNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7odEpdFlISHRizBVwZWvvi50/eT4ox0zEmpmbzS8ZBc=;
 b=TxOzEUFwsomtvJXWwTaaoOY2kXaDNsGIlxINWIQ6WR+unaWOO6iUUPsGHDqEoQRZThL1ttqobx1Z/ie7vePYsb87OFEy6EOHgT2iSw2CxXACmIfLp6wjYNn2Toc1tRKIsWwPCYALMXLxO41V6tmbIlfAFNIQgVVcEM8AeSNiB3nuh+THgywlukxs2oy8OB91XqBkLwWTmAPzL3uHYwknoCS8Mig8ij1atD0CDZC1dlRwN9SjMGwiy0ig9MxHnyg1ZoA4pclPEAPMoJKTsKZts9A7DFx6Bzo3UHe3QG2mX6XbFR3RfMjfWMLK//bQULRY8SnnvCnjNP8qcw6KU+vEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7odEpdFlISHRizBVwZWvvi50/eT4ox0zEmpmbzS8ZBc=;
 b=zm6RpZSDRD2VhcNdCg1dw5S9LT3tQopI4zzlJprIjst6ptckK2usxnFKDFYP0QW3g18rx7FUSvGxoEefHsVRKRmbqaUqRCyGUDW/6mHvL4QKLCUMUokf3ZSNxcO14/pzUnrRJQsO8mHV7vKnFOf10/++LrPssek+FXNbJ29qqI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 19:23:18 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b%11]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 19:23:18 +0000
Content-Type: multipart/alternative;
 boundary="------------Nc3ZqYgkfx0QVeLcRkxXU0n2"
Message-ID: <3bb6cf66-e85d-dd11-9bbf-52ba4283238d@amd.com>
Date: Tue, 8 Mar 2022 14:23:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Content-Language: en-CA
To: Leo Liu <leo.liu@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
 <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
 <YicOku9HhC3wJUb8@lang-desktop>
 <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
 <ec57da49-8a3f-852b-aaee-5bacdeb56c80@amd.com>
 <95e6f48e-fdc7-e535-1803-080a8d189d33@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <95e6f48e-fdc7-e535-1803-080a8d189d33@amd.com>
X-ClientProxiedBy: CH0PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:610:74::35) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e6ab31-09f8-4633-09a2-08da01391964
X-MS-TrafficTypeDiagnostic: DM5PR12MB1418:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB14180D12853FEE5EB5DF0A44E4099@DM5PR12MB1418.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40QAKK4jIF4Zn7vu+uyq2/XGeborW6/QInhqyFWgv++8kHdnEi/JkvSVNBgdLB79T2FJtahh8lmwH/8t3IrMFVZ60dXG4MQs4jRmMwZoYj5a7NAnIoLmRJUr76sjmzbU5W4XwipoSMVvOVZr2dNLL+OqzDl5AVgzJUVw+ZqUuLq4X76n5krJ9BWGxEVu5Aoc8mC+2WjRGNbg3MaVGQytD2aJuwEdjduAfjBiJzLEfL6KXMF7yDQYHho8b/Kq/1PdHMD7KPUW0ejwWNzCsOJUq08UP+PFjO/96+pnAUZWfIT8tfEb/Ygn+yfVoLKUYy32dcJ1Z+p9IxjoEpp+XprIKbvC7NRQGC+y9VaHb5S43ch4NPu/K2KEmitFsiKPlTEgTjsYmZNW6Y44s+HHiftIUpbVaHFR06VGyhzwnOfMEj1z5lDY5wlth3osh6z6C6rAWk/krr2/yW4dhOrNt6CwJMzjOrY6H9aEyklN0f88UWIUC/mvqtavFRWO2oEHcAFTAjHuXey0ZRQ9zV/6Xtxeo5L2zSAs5gGyn79iZ+JaHdBxcCxH7LdyUSgoLh0LtH5FXWVvsw3Z4W0mlRAgun+YS5t7w0sUwzYBrA2xxG/sBWXa6vZAwXBs1S8tw6072D1E3WH3Dcf2imCXSIfSPeGSJHme74q6RAxKwDcLZgxIeRDsw0TjncZnHvWaDaCj8m6F4Ey2B2vrd80f+xgbHJSiOIwpx50VoCyUqWvKPTj8B60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(84040400005)(6666004)(53546011)(6506007)(6512007)(6486002)(26005)(38100700002)(8676002)(2616005)(33964004)(66946007)(5660300002)(508600001)(2906002)(8936002)(30864003)(66556008)(66476007)(31686004)(186003)(316002)(66574015)(54906003)(36756003)(4326008)(110136005)(83380400001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE1GbWVTUEdCam5xWEptSEw0dkNSKytHZlpOdFlEblhUTjAxYjA3M3VXWVZq?=
 =?utf-8?B?V2l6K3cySGhsUTQ4Y1R1SzNoeG82dExLUXI2UklONlc3Nys0TnBLVmFhYWF1?=
 =?utf-8?B?VjJCZ241NTdIWkxXWVRKWisreFovRm1OU2N0ZmEvVzZnUkR4UGhoamxpVUZC?=
 =?utf-8?B?T2dZdVRweWJlUDlxdGNtVXJsRnNpMDB0TGp3aGpVWTMwbml1bnhIayt6eU1W?=
 =?utf-8?B?Z1FlZjloejZLa21TdURHYitiUGxXbUJNaXRZUk1yTFJ2WkhTUkhLSVQ4WThG?=
 =?utf-8?B?THFSWUV0UEF6SWV1Y0FjYjE4d3NuTE9veEtpaG03L09SMjFDSVcrNFdnbitn?=
 =?utf-8?B?bE1OdjdjVkRvWjZyTjVKQ1NPM3VZQm1UR3Fwd09mOEpHOC92M3l4bkFuMGM4?=
 =?utf-8?B?WTRydVV4T3ZJQTJ6bEtkdXpEeWZBZm01bG9zQkJteHhqVXNhZm03RloyNU80?=
 =?utf-8?B?UHdJTTNQd2hhWnQ0MjRTK3FRekJqNEdRVmdNY2FPV3g1eXAxSy8ydURjSTNr?=
 =?utf-8?B?MVZNQ2UyTjU4T21FRThtOCtMa0ZSUnU1N3JFTHROSXppUCtGZ2t0cml1YTY2?=
 =?utf-8?B?cHg4Q0l1bk81bmY2TnpOZHdWbnRiWDVNWTJsVWF5djZ2NVIvdXcwbFRJaDNI?=
 =?utf-8?B?MnhGWnpGM1dRQ1pxRzA1ZHNSWWdIZUtQWSt5VTY1UHRoWDBJenBEaHpIR1Bp?=
 =?utf-8?B?aGVOUTJLL2xVYW03NHk2bzhUeHZxSy9KNmdXK2VKMUorM3NVb0c3TmpHMVdv?=
 =?utf-8?B?NDNpMFcyamRlSmR5YXBIQWM2ckxjRkxyRnZ4dFJQZXU4Ui8yVFIyN2d2MzZu?=
 =?utf-8?B?M0hOc1AybWU0bDJXYk5icDVwYUJ5R2ZWTWVRblQ5RmpEZUl5K0V1ckxpcUVV?=
 =?utf-8?B?Nk1FN2Z4NVVxamdBaXpzZGlSb1FHbDd5bk9Fc0lTeXNyK1lIR0ZFZDcxdlpI?=
 =?utf-8?B?NGpnYnNXMFFVMjBsT1BjdnV6U3Mvb3JIdGYycE9nbFphcFUwdk8ycjJmbE96?=
 =?utf-8?B?RVdVOVRyeGpDL3Zia0ljbSsvdkowaXRZTmJHU1lFYktHdUFSbTZ3ZFJOa0NZ?=
 =?utf-8?B?Z1Ayd21tYnVMNkFWamlGcVZtVmxaNnVZRzhSZThzdFBHaHlEVHAvZUZOUzhY?=
 =?utf-8?B?N3ptSUlIMFJ1bVpnSDJubnJmNHg1ZTQrWWZjeTE5L0x5UXlUTURuKzY1V3J6?=
 =?utf-8?B?em8zTDNwOW1JNHJkQ05xcEFxMTlSS29vclExYi8xS1psMHAybWJ4V1lyZDcv?=
 =?utf-8?B?a2I4cEdUQVEzTzlEVTdEbW8rSWROZVlneVlwY3JRQ1k5MTFROHNzVjVIYmhl?=
 =?utf-8?B?My9lRlhJSkhrMlFEUWsyQmJZUWU0c0M1NTh0RDNTR2E4b1ZsRHRYaDdycmV0?=
 =?utf-8?B?VDVCT2psMFN3a0trUFJjWEttV3JybDkxMU9oWUpZS0xLMS9XVk80SVMrbzVj?=
 =?utf-8?B?aEhoOVlSZno4SWh6Z1BRaHEwY200MFFEWFhTQjA0Q0FpVWJaR1lmS1FOKzM5?=
 =?utf-8?B?SmJmZ1pyalNzNGpyN0FzNnJ5aHhVY2xKdXhLNTUwUDM5VlpidHFZejNsa2Q0?=
 =?utf-8?B?aEVmNGM2VE5qN09jbjdHQm5lYUlQajk0OElOY2ZLV0ltSUtWdTlEVFdwWENu?=
 =?utf-8?B?SlI1aXBxV1BVTk5XdEluM2pEd0YwVzRpQlFiMTRobFR1bHdiMFFiV0VnZjdV?=
 =?utf-8?B?ekE4T3RJZ1dqcERnVk1DdGVzWkh3UWFBZnREbkREdnNweVJtRElXc0xxOFJk?=
 =?utf-8?B?MHRxSTI2d1FoV2pGemU4NXNMeFpldFhwNjhOajh4RXlPbjByUWlmcDhZVnBV?=
 =?utf-8?B?NDFyS1U1ZWx3V0VLcFUxMisxK2UvTE1jK3J5YmJxOWJHY3gzMVoyY3NCb2VF?=
 =?utf-8?B?RTkyTWJmSlg5QXFvaEdYblNHZU5FR3RWVkZJSEg3cFpGOEtORU1KTWJGbGJn?=
 =?utf-8?B?dkc3bWVoc3V6M2pFR3NkVDhzQ2t3UWdsOUlMQ28xeFhzMkk4eHBWYlRpczRh?=
 =?utf-8?B?SkpmZzM3RlQ3bXNpWjhxOStteFJtaDZFNWo4NkxJRDdoaHNmY2dDaittNSsv?=
 =?utf-8?B?VjBZcm1BNWRyYmVsdjRnb3E4UkhkbnNUcGNZOFJwTVdNWVZHN081MkJoamR3?=
 =?utf-8?Q?QOQU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e6ab31-09f8-4633-09a2-08da01391964
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 19:23:17.8971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iFrpeKM6yVm6hX4Gmr8L641SmrZWg8dPpezjoJNjNy6+p2EQQ8ctYaEH7uK29kp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Zhang,
 Boyuan" <Boyuan.Zhang@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------Nc3ZqYgkfx0QVeLcRkxXU0n2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+BoYuan

I am not sure if we need add ENCRYPT check when allocate surface if is 
supposed to be TMZ protected . For example:

VAStatus
*vlVaHandleSurfaceAllocate*(vlVaDriver *drv, vlVaSurface *surface,
                           struct pipe_video_buffer *templat,
                           const uint64_t *modifiers,
                           unsigned int modifiers_count)
{
    struct pipe_surface **surfaces;
    unsigned i;

*    if (is_encrypted && **templat) {/***is_encrypted is pseudocode*/
*

***templat->bind |= PIPE_BIND_PROTECTED;**
*

*    }*
    if (modifiers_count > 0) {
       if (!drv->pipe->create_video_buffer_with_modifiers)
          return VA_STATUS_ERROR_ATTR_NOT_SUPPORTED;
       surface->buffer =
drv->pipe->create_video_buffer_with_modifiers(drv->pipe, templat,
                                                        modifiers,
modifiers_count);
    } else {
       surface->buffer = drv->pipe->create_video_buffer(drv->pipe, templat);
    }

Best Regards!

James

On 2022-03-08 11:30 a.m., Leo Liu wrote:
>
> On 2022-03-08 11:18, Leo Liu wrote:
>>
>> On 2022-03-08 04:16, Christian König wrote:
>>> Am 08.03.22 um 09:06 schrieb Lang Yu:
>>>> On 03/08/ , Christian König wrote:
>>>>> Am 08.03.22 um 08:33 schrieb Lang Yu:
>>>>>> On 03/08/ , Christian König wrote:
>>>>>>> Am 08.03.22 um 04:39 schrieb Lang Yu:
>>>>>>>> It is a hardware issue that VCN can't handle a GTT
>>>>>>>> backing stored TMZ buffer on Raven.
>>>>>>>>
>>>>>>>> Move such a TMZ buffer to VRAM domain before command
>>>>>>>> submission.
>>>>>>>>
>>>>>>>> v2:
>>>>>>>>     - Use patch_cs_in_place callback.
>>>>>>>>
>>>>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68 
>>>>>>>> +++++++++++++++++++++++++++
>>>>>>>>     1 file changed, 68 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>> index 7bbb9ba6b80b..810932abd3af 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>> @@ -24,6 +24,7 @@
>>>>>>>>     #include <linux/firmware.h>
>>>>>>>>     #include "amdgpu.h"
>>>>>>>> +#include "amdgpu_cs.h"
>>>>>>>>     #include "amdgpu_vcn.h"
>>>>>>>>     #include "amdgpu_pm.h"
>>>>>>>>     #include "soc15.h"
>>>>>>>> @@ -1905,6 +1906,72 @@ static const struct amd_ip_funcs 
>>>>>>>> vcn_v1_0_ip_funcs = {
>>>>>>>>         .set_powergating_state = vcn_v1_0_set_powergating_state,
>>>>>>>>     };
>>>>>>>> +/**
>>>>>>>> + * It is a hardware issue that Raven VCN can't handle a GTT 
>>>>>>>> TMZ buffer.
>>>>>>>> + * Move such a GTT TMZ buffer to VRAM domain before command 
>>>>>>>> submission.
>>>>>>>> + */
>>>>>>>> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
>>>>>>>> +                struct amdgpu_job *job,
>>>>>>>> +                uint64_t addr)
>>>>>>>> +{
>>>>>>>> +    struct ttm_operation_ctx ctx = { false, false };
>>>>>>>> +    struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
>>>>>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>>>>>> +    struct amdgpu_bo_va_mapping *mapping;
>>>>>>>> +    struct amdgpu_bo *bo;
>>>>>>>> +    int r;
>>>>>>>> +
>>>>>>>> +    addr &= AMDGPU_GMC_HOLE_MASK;
>>>>>>>> +    if (addr & 0x7) {
>>>>>>>> +        DRM_ERROR("VCN messages must be 8 byte aligned!\n");
>>>>>>>> +        return -EINVAL;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    mapping = amdgpu_vm_bo_lookup_mapping(vm, 
>>>>>>>> addr/AMDGPU_GPU_PAGE_SIZE);
>>>>>>>> +    if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
>>>>>>>> +        return -EINVAL;
>>>>>>>> +
>>>>>>>> +    bo = mapping->bo_va->base.bo;
>>>>>>>> +    if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
>>>>>>>> +        return 0;
>>>>>>>> +
>>>>>>>> +    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>>>>>>> +    r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>>>> +    if (r) {
>>>>>>>> +        DRM_ERROR("Failed validating the VCN message BO 
>>>>>>>> (%d)!\n", r);
>>>>>>>> +        return r;
>>>>>>>> +    }
>>>>>>> Well, exactly that won't work.
>>>>>>>
>>>>>>> The message structure isn't TMZ protected because otherwise the 
>>>>>>> driver won't
>>>>>>> be able to stitch it together.
>>>>>>>
>>>>>>> What is TMZ protected are the surfaces the message structure is 
>>>>>>> pointing to.
>>>>>>> So what you would need to do is to completely parse the 
>>>>>>> structure and then
>>>>>>> move on the relevant buffers into VRAM.
>>>>>>>
>>>>>>> Leo or James, can you help with that?
>>>>>>   From my observations, when decoding secure contents, register
>>>>>> GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ buffer 
>>>>>> address.
>>>>>> And this way works when allocating TMZ buffers in GTT domain.
>>>>> As far as I remember that's only the case for the decoding, 
>>>>> encoding works
>>>>> by putting the addresses into the message buffer.
>>>>>
>>>>> But could be that decoding is sufficient, Leo and James need to 
>>>>> comment on
>>>>> this.
>>>> It seems that only decode needs TMZ buffers. Only observe 
>>>> si_vid_create_tmz_buffer()
>>>> was called in rvcn_dec_message_decode() in 
>>>> src/gallium/drivers/radeon/radeon_vcn_dec.c.
>>>
>>> Mhm, good point. Let's wait for Leo and James to wake up, when we 
>>> don't need encode support than that would makes things much easier.
>>
>> For secure playback, the buffer required in TMZ are dpb, dt and ctx, 
>> for the rest esp. those for CPU access don't need that E.g. msg 
>> buffer, and bitstream buffer.
>>
>> From radeon_vcn_dec.c, you can see the buffer for dpb and ctx, and dt 
>> buffer frontend/va/surface is set to PIPE_BIND_PROTECTED.
>>
>>
>> Regards,
>>
>> Leo
>>
> For VCN1, due to performance reason, the msg and fb buffer was 
> allocated into VRAM instead of GTT(for other HW), but those are not 
> TMZ in order to have CPU access.
>
>
> Regards,
>
> Leo
>
>
>
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>> Lang
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Regards,
>>>>>> Lang
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> +
>>>>>>>> +    return r;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int vcn_v1_0_ring_patch_cs_in_place(struct 
>>>>>>>> amdgpu_cs_parser *p,
>>>>>>>> +                       struct amdgpu_job *job,
>>>>>>>> +                       struct amdgpu_ib *ib)
>>>>>>>> +{
>>>>>>>> +    uint32_t msg_lo = 0, msg_hi = 0;
>>>>>>>> +    int i, r;
>>>>>>>> +
>>>>>>>> +    for (i = 0; i < ib->length_dw; i += 2) {
>>>>>>>> +        uint32_t reg = amdgpu_ib_get_value(ib, i);
>>>>>>>> +        uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>>>>>>>> +
>>>>>>>> +        if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
>>>>>>>> +            msg_lo = val;
>>>>>>>> +        } else if (reg == PACKET0(p->adev->vcn.internal.data1, 
>>>>>>>> 0)) {
>>>>>>>> +            msg_hi = val;
>>>>>>>> +        } else if (reg == PACKET0(p->adev->vcn.internal.cmd, 
>>>>>>>> 0)) {
>>>>>>>> +            r = vcn_v1_0_validate_bo(p, job,
>>>>>>>> +                         ((u64)msg_hi) << 32 | msg_lo);
>>>>>>>> +            if (r)
>>>>>>>> +                return r;
>>>>>>>> +        }
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +
>>>>>>>>     static const struct amdgpu_ring_funcs 
>>>>>>>> vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>>>         .type = AMDGPU_RING_TYPE_VCN_DEC,
>>>>>>>>         .align_mask = 0xf,
>>>>>>>> @@ -1914,6 +1981,7 @@ static const struct amdgpu_ring_funcs 
>>>>>>>> vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>>>         .get_rptr = vcn_v1_0_dec_ring_get_rptr,
>>>>>>>>         .get_wptr = vcn_v1_0_dec_ring_get_wptr,
>>>>>>>>         .set_wptr = vcn_v1_0_dec_ring_set_wptr,
>>>>>>>> +    .patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>>>>>>>>         .emit_frame_size =
>>>>>>>>             6 + 6 + /* hdp invalidate / flush */
>>>>>>>>             SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>>>
--------------Nc3ZqYgkfx0QVeLcRkxXU0n2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>+BoYuan</p>
    <p>I am not sure if we need add ENCRYPT check when allocate surface
      if is supposed to be TMZ protected . For example:<br>
    </p>
    <p>VAStatus<br>
      <b>vlVaHandleSurfaceAllocate</b>(vlVaDriver *drv, vlVaSurface
      *surface,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_video_buffer *templat,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t *modifiers,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int modifiers_count)<br>
      {<br>
      &nbsp;&nbsp; struct pipe_surface **surfaces;<br>
      &nbsp;&nbsp; unsigned i;<br>
    </p>
    <p><b>&nbsp;&nbsp;&nbsp; if (is_encrypted &amp;&amp; </b><b>templat) {/*</b><b>is_encrypted
        is pseudocode*/<br>
      </b></p>
    <p><b>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; </b><b>templat-&gt;bind |= PIPE_BIND_PROTECTED;</b><b><br>
      </b></p>
    <p><b>&nbsp;&nbsp;&nbsp; }</b><br>
      &nbsp;&nbsp; if (modifiers_count &gt; 0) {<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drv-&gt;pipe-&gt;create_video_buffer_with_modifiers)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return VA_STATUS_ERROR_ATTR_NOT_SUPPORTED;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface-&gt;buffer =<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      drv-&gt;pipe-&gt;create_video_buffer_with_modifiers(drv-&gt;pipe,
      templat,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; modifiers,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      modifiers_count);<br>
      &nbsp;&nbsp; } else {<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface-&gt;buffer =
      drv-&gt;pipe-&gt;create_video_buffer(drv-&gt;pipe, templat);<br>
      &nbsp;&nbsp; }<br>
    </p>
    <p>Best Regards!</p>
    <p>James<br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-08 11:30 a.m., Leo Liu
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:95e6f48e-fdc7-e535-1803-080a8d189d33@amd.com">
      <br>
      On 2022-03-08 11:18, Leo Liu wrote:
      <br>
      <blockquote type="cite">
        <br>
        On 2022-03-08 04:16, Christian König wrote:
        <br>
        <blockquote type="cite">Am 08.03.22 um 09:06 schrieb Lang Yu:
          <br>
          <blockquote type="cite">On 03/08/ , Christian König wrote:
            <br>
            <blockquote type="cite">Am 08.03.22 um 08:33 schrieb Lang
              Yu:
              <br>
              <blockquote type="cite">On 03/08/ , Christian König wrote:
                <br>
                <blockquote type="cite">Am 08.03.22 um 04:39 schrieb
                  Lang Yu:
                  <br>
                  <blockquote type="cite">It is a hardware issue that
                    VCN can't handle a GTT
                    <br>
                    backing stored TMZ buffer on Raven.
                    <br>
                    <br>
                    Move such a TMZ buffer to VRAM domain before command
                    <br>
                    submission.
                    <br>
                    <br>
                    v2:
                    <br>
                    &nbsp;&nbsp;&nbsp; - Use patch_cs_in_place callback.
                    <br>
                    <br>
                    Suggested-by: Christian König
                    <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
                    <br>
                    Signed-off-by: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a>
                    <br>
                    ---
                    <br>
                    &nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68
                    +++++++++++++++++++++++++++
                    <br>
                    &nbsp;&nbsp;&nbsp; 1 file changed, 68 insertions(+)
                    <br>
                    <br>
                    diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
                    b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
                    <br>
                    index 7bbb9ba6b80b..810932abd3af 100644
                    <br>
                    --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
                    <br>
                    +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
                    <br>
                    @@ -24,6 +24,7 @@
                    <br>
                    &nbsp;&nbsp;&nbsp; #include &lt;linux/firmware.h&gt;
                    <br>
                    &nbsp;&nbsp;&nbsp; #include &quot;amdgpu.h&quot;
                    <br>
                    +#include &quot;amdgpu_cs.h&quot;
                    <br>
                    &nbsp;&nbsp;&nbsp; #include &quot;amdgpu_vcn.h&quot;
                    <br>
                    &nbsp;&nbsp;&nbsp; #include &quot;amdgpu_pm.h&quot;
                    <br>
                    &nbsp;&nbsp;&nbsp; #include &quot;soc15.h&quot;
                    <br>
                    @@ -1905,6 +1906,72 @@ static const struct
                    amd_ip_funcs vcn_v1_0_ip_funcs = {
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_powergating_state =
                    vcn_v1_0_set_powergating_state,
                    <br>
                    &nbsp;&nbsp;&nbsp; };
                    <br>
                    +/**
                    <br>
                    + * It is a hardware issue that Raven VCN can't
                    handle a GTT TMZ buffer.
                    <br>
                    + * Move such a GTT TMZ buffer to VRAM domain before
                    command submission.
                    <br>
                    + */
                    <br>
                    +static int vcn_v1_0_validate_bo(struct
                    amdgpu_cs_parser *parser,
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job,
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr)
                    <br>
                    +{
                    <br>
                    +&nbsp;&nbsp;&nbsp; struct ttm_operation_ctx ctx = { false, false
                    };
                    <br>
                    +&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv =
                    parser-&gt;filp-&gt;driver_priv;
                    <br>
                    +&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
                    <br>
                    +&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_mapping *mapping;
                    <br>
                    +&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;
                    <br>
                    +&nbsp;&nbsp;&nbsp; int r;
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp; addr &amp;= AMDGPU_GMC_HOLE_MASK;
                    <br>
                    +&nbsp;&nbsp;&nbsp; if (addr &amp; 0x7) {
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;VCN messages must be 8 byte
                    aligned!\n&quot;);
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
                    <br>
                    +&nbsp;&nbsp;&nbsp; }
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp; mapping = amdgpu_vm_bo_lookup_mapping(vm,
                    addr/AMDGPU_GPU_PAGE_SIZE);
                    <br>
                    +&nbsp;&nbsp;&nbsp; if (!mapping || !mapping-&gt;bo_va ||
                    !mapping-&gt;bo_va-&gt;base.bo)
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp; bo = mapping-&gt;bo_va-&gt;base.bo;
                    <br>
                    +&nbsp;&nbsp;&nbsp; if (!(bo-&gt;flags &amp;
                    AMDGPU_GEM_CREATE_ENCRYPTED))
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp; amdgpu_bo_placement_from_domain(bo,
                    AMDGPU_GEM_DOMAIN_VRAM);
                    <br>
                    +&nbsp;&nbsp;&nbsp; r = ttm_bo_validate(&amp;bo-&gt;tbo,
                    &amp;bo-&gt;placement, &amp;ctx);
                    <br>
                    +&nbsp;&nbsp;&nbsp; if (r) {
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed validating the VCN
                    message BO (%d)!\n&quot;, r);
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
                    <br>
                    +&nbsp;&nbsp;&nbsp; }
                    <br>
                  </blockquote>
                  Well, exactly that won't work.
                  <br>
                  <br>
                  The message structure isn't TMZ protected because
                  otherwise the driver won't
                  <br>
                  be able to stitch it together.
                  <br>
                  <br>
                  What is TMZ protected are the surfaces the message
                  structure is pointing to.
                  <br>
                  So what you would need to do is to completely parse
                  the structure and then
                  <br>
                  move on the relevant buffers into VRAM.
                  <br>
                  <br>
                  Leo or James, can you help with that?
                  <br>
                </blockquote>
                &nbsp; From my observations, when decoding secure contents,
                register
                <br>
                GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ
                buffer address.
                <br>
                And this way works when allocating TMZ buffers in GTT
                domain.
                <br>
              </blockquote>
              As far as I remember that's only the case for the
              decoding, encoding works
              <br>
              by putting the addresses into the message buffer.
              <br>
              <br>
              But could be that decoding is sufficient, Leo and James
              need to comment on
              <br>
              this.
              <br>
            </blockquote>
            It seems that only decode needs TMZ buffers. Only observe
            si_vid_create_tmz_buffer()
            <br>
            was called in rvcn_dec_message_decode() in
            src/gallium/drivers/radeon/radeon_vcn_dec.c.
            <br>
          </blockquote>
          <br>
          Mhm, good point. Let's wait for Leo and James to wake up, when
          we don't need encode support than that would makes things much
          easier.
          <br>
        </blockquote>
        <br>
        For secure playback, the buffer required in TMZ are dpb, dt and
        ctx, for the rest esp. those for CPU access don't need that E.g.
        msg buffer, and bitstream buffer.
        <br>
        <br>
        From radeon_vcn_dec.c, you can see the buffer for dpb and ctx,
        and dt buffer frontend/va/surface is set to PIPE_BIND_PROTECTED.
        <br>
        <br>
        <br>
        Regards,
        <br>
        <br>
        Leo
        <br>
        <br>
      </blockquote>
      For VCN1, due to performance reason, the msg and fb buffer was
      allocated into VRAM instead of GTT(for other HW), but those are
      not TMZ in order to have CPU access.
      <br>
      <br>
      <br>
      Regards,
      <br>
      <br>
      Leo
      <br>
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Regards,
          <br>
          Christian.
          <br>
          <br>
          <blockquote type="cite">
            <br>
            Regards,
            <br>
            Lang
            <br>
            <br>
            <blockquote type="cite">Regards,
              <br>
              Christian.
              <br>
              <br>
              <blockquote type="cite">Regards,
                <br>
                Lang
                <br>
                <br>
                <blockquote type="cite">Regards,
                  <br>
                  Christian.
                  <br>
                  <br>
                  <blockquote type="cite">+
                    <br>
                    +&nbsp;&nbsp;&nbsp; return r;
                    <br>
                    +}
                    <br>
                    +
                    <br>
                    +static int vcn_v1_0_ring_patch_cs_in_place(struct
                    amdgpu_cs_parser *p,
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job,
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib)
                    <br>
                    +{
                    <br>
                    +&nbsp;&nbsp;&nbsp; uint32_t msg_lo = 0, msg_hi = 0;
                    <br>
                    +&nbsp;&nbsp;&nbsp; int i, r;
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; ib-&gt;length_dw; i += 2) {
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg = amdgpu_ib_get_value(ib, i);
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val = amdgpu_ib_get_value(ib, i +
                    1);
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reg ==
                    PACKET0(p-&gt;adev-&gt;vcn.internal.data0, 0)) {
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg_lo = val;
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (reg ==
                    PACKET0(p-&gt;adev-&gt;vcn.internal.data1, 0)) {
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg_hi = val;
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (reg ==
                    PACKET0(p-&gt;adev-&gt;vcn.internal.cmd, 0)) {
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = vcn_v1_0_validate_bo(p, job,
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((u64)msg_hi) &lt;&lt; 32
                    | msg_lo);
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
                    <br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
                    <br>
                    +&nbsp;&nbsp;&nbsp; }
                    <br>
                    +
                    <br>
                    +&nbsp;&nbsp;&nbsp; return 0;
                    <br>
                    +}
                    <br>
                    +
                    <br>
                    +
                    <br>
                    &nbsp;&nbsp;&nbsp; static const struct amdgpu_ring_funcs
                    vcn_v1_0_dec_ring_vm_funcs = {
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type = AMDGPU_RING_TYPE_VCN_DEC,
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .align_mask = 0xf,
                    <br>
                    @@ -1914,6 +1981,7 @@ static const struct
                    amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_rptr = vcn_v1_0_dec_ring_get_rptr,
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wptr = vcn_v1_0_dec_ring_get_wptr,
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wptr = vcn_v1_0_dec_ring_set_wptr,
                    <br>
                    +&nbsp;&nbsp;&nbsp; .patch_cs_in_place =
                    vcn_v1_0_ring_patch_cs_in_place,
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_frame_size =
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6 + 6 + /* hdp invalidate / flush */
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
                    <br>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------Nc3ZqYgkfx0QVeLcRkxXU0n2--
