Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F59C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 14:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F4C210E681;
	Thu, 10 Mar 2022 14:17:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2401010E681
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 14:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjDQZYUPAmpDwfkctZqFwg5Iys6psOaulpznaQAz1JJmjGi8B/aSHmGyLDb0hlnIdlEfqGz5yQys6gB8CkEBpAjRpsJXM4FgeSy9CFizVfemJD/k22sfvUDx+z1wwN2RV+wWD57u6yJa6/qDxU52DsszM/QDxExcAsvAv5c3ZBSn8aG/gqQzFKhCh4DccudUfEwnvzqIlw/doUsR6cizFYsiYhSVm4aEf5nyG1mdmYlQIZwKlszA68WCevx7Sf7ZqD6Emrdlh5yMiuQ7ekFPswicM0ID9ssF1fhSEnjvI+um0qTA7UYOu1YXvA3xI8SbBPZuWHGTuO8LFOXaDN6G9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJkbTYLfs6oA1MgJlQ8G7eB86HuP4AGG72xgYVMAMxE=;
 b=MsI6r2NwLvcABQ/NCGsc5LgnyDTiPpYsAq5UmZOhaxy2TfH6AATgo/WPvnG8TU1Uf+VL8CDVo5LhtcayCd1WBTnw9RALJl88BgRTCDw2M/zXVizsTntpOdj26ZVPlxhZA5IMBJFdtqhYzpPpR+p7DRvqP0sTtcy8yFR+KjbeNteZ1QtgAvkieq+8RF5fSimfff698/GIIzA03w7uBBqtlvg17eVUGc19c9zTxRhli7L9T8Zqs5eLCPbRxishm3ysPY3nLGLPh8r3bV0OBa6PaIiQLuOOTT0VeTwCvIJN+xY6CuydG0pNqSdZ+s+7RmRd4/LkVtiufU6MxwXTQkwA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJkbTYLfs6oA1MgJlQ8G7eB86HuP4AGG72xgYVMAMxE=;
 b=b7rPY1QlYkOnH00ZYk93vFXTkpvEln/URqK6fZ9WMNFQPNn4oGwdAdMjVRZmrJeyWwldzwx5lkHJY0OYnB2v+7W/eMFI7B3XKquadtbgnLvKQZ0qlxBaYohaJlTSGdAAc+sLZ6PupU4XmERx0vdFLZIhPwzlsQOJkzs1Xl/ZjZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 MWHPR12MB1792.namprd12.prod.outlook.com (2603:10b6:300:114::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.27; Thu, 10 Mar
 2022 14:17:22 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::19ab:5c87:f10d:51cb]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::19ab:5c87:f10d:51cb%7]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 14:17:21 +0000
Message-ID: <d6c3cf48-7699-7192-5655-4c5bd7f7a37b@amd.com>
Date: Thu, 10 Mar 2022 09:17:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
 <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
 <YicOku9HhC3wJUb8@lang-desktop>
 <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
 <ec57da49-8a3f-852b-aaee-5bacdeb56c80@amd.com>
 <95e6f48e-fdc7-e535-1803-080a8d189d33@amd.com>
 <Yim6vIBYKLd3Uqxu@lang-desktop>
 <f16e10f2-fa3f-7e63-c260-aaf1a70f8011@amd.com>
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <f16e10f2-fa3f-7e63-c260-aaf1a70f8011@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e7f6924-a22e-4e2c-6019-08da02a0b121
X-MS-TrafficTypeDiagnostic: MWHPR12MB1792:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1792F9FA8CA4B27EC4CB8A97E50B9@MWHPR12MB1792.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfkqP07Ieb624fIpcUvW+tFSs3hc3uyaF9rXW5L34M9RgB993A65v87SFFxmgpEmvHVlbHp7ooq+Xlzyy1kG1k/bV6sCwE/Ftx0bHOdpmX+TJuJdfriOsKiPjzhZQl/jtlp8jN2KMqpxRErtlWtttm5djRCE4TR9EZkPCz0MYS1S312Vh8EZmOFS5XMjUVKy6nzoVpA13BbZPneNxmBakDyHKoQuhv62sU22tnQzuE80aWQvjqwQbo1HluxYbq0FXEPtJM2BeCSQS+ZyOl+B4aPmrJ55DEzqXATosNITUzAt6a0Fpg6TjjyIrukEqwKbREBOvIRvTYENbzoGu8MX34A4EXLgbjUyPrkHMny/wv6OAnTzVhp5/BHTmsTmKUaBatMR1lwWkzN0rRFvk7n+BVy19EuOHxLsC/L0Hd62WuopSCmxZ2fJi130bYvsjjd+c8WWnkO9DTTuyq8gdRKvQpraerPl9tciTUoU7TvctWjSXlEOyZaHs7koxf5rRDuseqA2wMC1k0kRHCkUthPpPrN6/7NWTycs44q/fXgLztgxDAyfowcIhBTi/6YGF4ve31V8M5/iiyTUqSKTOQykPfse2feSmaTUviEavIIDuOlBJAlCOHMGNRPANcG+VX1HES2juS4w2HzBep78hxa2bNuDAy2xsPWj3MALzQ0Q3Wpb91W4ikuv90+osjRzUrk7IC8M0cuNFoYSq6zGpojmAHL0qjuWDastApjgVQ3Bgbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(84040400005)(6512007)(2906002)(53546011)(6506007)(38100700002)(66946007)(66556008)(8676002)(66476007)(4326008)(6486002)(508600001)(54906003)(86362001)(316002)(6636002)(31686004)(83380400001)(186003)(5660300002)(44832011)(2616005)(36756003)(66574015)(26005)(31696002)(110136005)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTRhWDlqY0k4Q2JzbG1sbkN1c1BOZU9vRHpzNS9tbWVYbDVmNFZpMHArRTdx?=
 =?utf-8?B?Qy9MVkZmczAxZzFkQkllZjV4RlJrNDQ5OStBK2dkYk1JVlY0d0NBSkpCelJo?=
 =?utf-8?B?UnkxM2FBQkw4czJVWHBrTzBMdG82djdCYkxyZmt2dlVpUzUzd2JMNGU0cWRY?=
 =?utf-8?B?Uk1lMG9adzRrK2t4U1BHRXFxUzI3OWJUSGVxT2ZqTGhnaENXS0FBcjFMYTdK?=
 =?utf-8?B?NEZOdUtMczRzQldOdEo0RXpCS2VvSDA3Y0NxV2pMVStzVktseTM0dmhZbTVx?=
 =?utf-8?B?RmVIRUFsdFFjL2orUXVFZlhjSUlXMDd6TkF0Z3R0NHI0dTRUSkZFMVA5eHZP?=
 =?utf-8?B?U1gvcSt6UzRMUHA5YzJzdU1VLzNVU0JnRFpudkZMKzBZWVF4Nk4xRDNBd2or?=
 =?utf-8?B?V25ubXhyR1lhc2tudDFwNGd0UzZic3hXamVyaElTcGtrMmdKMXhsNDh3aW1D?=
 =?utf-8?B?VDNVNnRrL04xbGhoNWVFSXI4WXB1Z0ZsU2lWNjhjaldMRE5XdzFzMUNyTFlG?=
 =?utf-8?B?KzUzTU05UzJodm1zblNJU1VwdVNad01rNDV6dU5BR3lDYlY0MWNPZm1INVhT?=
 =?utf-8?B?ck5MN1FKc3lPdG1lNUtxQ25YR081Zzd2dkNxL1hpeW80Z1Z2RW5DMXdLd3Ur?=
 =?utf-8?B?cmtSOXlsTFZrNjZFTENLWUtVMzdQZXFHd0JtT3BmbnFjT0hnWmpJTkZRZWRE?=
 =?utf-8?B?MzlqcVdSWEV5MkJRZmVFbmcrS1pHY2k2ajM1eVQwU1R0S20ycVh4RHVBMEZG?=
 =?utf-8?B?cFI3czd4QjhNNVk2UzVpS0E1QTBPNnRMNlB3QTg5bk9ja3pLb2sxS2dGa0g4?=
 =?utf-8?B?K0NKMllndjdNMncxOFJRZVAyRm9VbnZIbm8wSzF0VkN2aWF5OER6b2x6RTAr?=
 =?utf-8?B?V1NZVGNaTnpwUVNuUEc1MmxxRTI2U3V4aWxxYlFkdFFyZmZTclhyZTBsa2Jk?=
 =?utf-8?B?MmNqbWtLbTZ2WGVoSklIeXFMQUt0b0R5VDFia3pkd1FhY1c5bGFEdFE3OGtG?=
 =?utf-8?B?b0FUQ3RHOG9XWHBTcDRGcVNBUmVyVGRQZmdiSCtxVC9HL1ZPUFltczNSZm10?=
 =?utf-8?B?YW1aeHFRUEdyUjB6SWtZRGJDY2FqYjc1eU12ckJBZlRVc251OFhja05RN3Jr?=
 =?utf-8?B?Z0JnWm8yTXNzcFM2aWhKVDBRQ2duSXFmejZpWHFaRndtKzE4WVE1ZXNTSStE?=
 =?utf-8?B?L1FxUXBzZXRMR282ZHFkb01odFJhWW1CR0lFWi8vUC8vN2hMSU9wU3RPOUkx?=
 =?utf-8?B?N1dKZkFJZ0kyVXRoa1FnTTA5MGFKQjNnWVZXRUZMbllOYU5rRzl0eTRDeDFS?=
 =?utf-8?B?ODByRmx0ajhwZUxnZWowVU5hdkdqN1NFNVpZcjRIYzc3b0JhMnRWaWx6WTFp?=
 =?utf-8?B?VEZUV0IvL1JseGdwTXVqemhUWUhCMzlPUk1RZ0tUYTNrcmQ2TWhmRE9wRTg2?=
 =?utf-8?B?WHNaWUJlcXJnZGlZMWZVWUxEbzVtN0M2ZU1KWEUzSEhHcnhNMEJDVzd6Mi9O?=
 =?utf-8?B?VmJRb2Uvc3dPcE9xTWVjUjN6aTVkSnA1b0grZkIxRmJSZ0lVWGIxZDZMcnYw?=
 =?utf-8?B?WXpUbkJia3NZaitmditJZktWcGhmVHRGVEhyQ21oWkY1QnRoREdmb01jSzAz?=
 =?utf-8?B?MVdRTXZwVDZHTkFwNmhNbDZFSzJKWjhNTlVZR01NczVmMk11dEhRWHRrc2hB?=
 =?utf-8?B?dHpranB3OVNld2xYOTM2c2ZnMUJNOElRd25SR3JabW5Oa0xwV2hZa1dTSm8y?=
 =?utf-8?B?NVl2N3dha214QnlUNjRab2VGTXRIM3JWWVI1dy9IWkNLcXZmTmZGMmI3Zk1E?=
 =?utf-8?B?endOR0s2MDlVQjMwbEtmWk16WlpMazU5VHU2R1pmNHc5VUpCS2w2OXhZanpo?=
 =?utf-8?B?U0FiYVVHR0tkVTU4em5nTXBsT2p5QjFTb2x0RzR4ckhaUk13NnBueStaVlRY?=
 =?utf-8?B?NEZTRFRiOGtBZUtlMG9GSUFwNVZVT0xzbkRzYW5yUUJZWkVOZXdmNTZKeUd6?=
 =?utf-8?B?MVNyY0RCTlcwR3FrQ0g5MlpwemNibG04SCt4bFFsRUFhUlZ1ZE1pZzJUZFZn?=
 =?utf-8?B?UE5EaXloNWN5WVhoZ1pHSGxienBQWGhxMURpYm94di81K25Ya3FVa2dLY0JZ?=
 =?utf-8?Q?QgH8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7f6924-a22e-4e2c-6019-08da02a0b121
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 14:17:21.8949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5GPptQ5jwoc+H46oceW7PNu0jgJdZcxfL11yQ7jTG0w3SyPB73EXqHZwQrbuuXp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1792
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

No need for encode. Encrypting uses TEE/TA to convert clear bitstream to 
encrypted bitstream, and has nothing to do with VCN encode and tmz.

Regards,

Leo


On 2022-03-10 04:53, Christian König wrote:
> Leo you didn't answered the question if we need TMZ for encode as well.
>
> Regards,
> Christian.
>
> Am 10.03.22 um 09:45 schrieb Lang Yu:
>> Ping.
>>
>> On 03/08/ , Leo Liu wrote:
>>> On 2022-03-08 11:18, Leo Liu wrote:
>>>> On 2022-03-08 04:16, Christian König wrote:
>>>>> Am 08.03.22 um 09:06 schrieb Lang Yu:
>>>>>> On 03/08/ , Christian König wrote:
>>>>>>> Am 08.03.22 um 08:33 schrieb Lang Yu:
>>>>>>>> On 03/08/ , Christian König wrote:
>>>>>>>>> Am 08.03.22 um 04:39 schrieb Lang Yu:
>>>>>>>>>> It is a hardware issue that VCN can't handle a GTT
>>>>>>>>>> backing stored TMZ buffer on Raven.
>>>>>>>>>>
>>>>>>>>>> Move such a TMZ buffer to VRAM domain before command
>>>>>>>>>> submission.
>>>>>>>>>>
>>>>>>>>>> v2:
>>>>>>>>>>      - Use patch_cs_in_place callback.
>>>>>>>>>>
>>>>>>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>      drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68
>>>>>>>>>> +++++++++++++++++++++++++++
>>>>>>>>>>      1 file changed, 68 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git
>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>>> index 7bbb9ba6b80b..810932abd3af 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>>> @@ -24,6 +24,7 @@
>>>>>>>>>>      #include <linux/firmware.h>
>>>>>>>>>>      #include "amdgpu.h"
>>>>>>>>>> +#include "amdgpu_cs.h"
>>>>>>>>>>      #include "amdgpu_vcn.h"
>>>>>>>>>>      #include "amdgpu_pm.h"
>>>>>>>>>>      #include "soc15.h"
>>>>>>>>>> @@ -1905,6 +1906,72 @@ static const struct
>>>>>>>>>> amd_ip_funcs vcn_v1_0_ip_funcs = {
>>>>>>>>>>          .set_powergating_state = 
>>>>>>>>>> vcn_v1_0_set_powergating_state,
>>>>>>>>>>      };
>>>>>>>>>> +/**
>>>>>>>>>> + * It is a hardware issue that Raven VCN can't
>>>>>>>>>> handle a GTT TMZ buffer.
>>>>>>>>>> + * Move such a GTT TMZ buffer to VRAM domain
>>>>>>>>>> before command submission.
>>>>>>>>>> + */
>>>>>>>>>> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser 
>>>>>>>>>> *parser,
>>>>>>>>>> +                struct amdgpu_job *job,
>>>>>>>>>> +                uint64_t addr)
>>>>>>>>>> +{
>>>>>>>>>> +    struct ttm_operation_ctx ctx = { false, false };
>>>>>>>>>> +    struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
>>>>>>>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>>>>>>>> +    struct amdgpu_bo_va_mapping *mapping;
>>>>>>>>>> +    struct amdgpu_bo *bo;
>>>>>>>>>> +    int r;
>>>>>>>>>> +
>>>>>>>>>> +    addr &= AMDGPU_GMC_HOLE_MASK;
>>>>>>>>>> +    if (addr & 0x7) {
>>>>>>>>>> +        DRM_ERROR("VCN messages must be 8 byte aligned!\n");
>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    mapping = amdgpu_vm_bo_lookup_mapping(vm,
>>>>>>>>>> addr/AMDGPU_GPU_PAGE_SIZE);
>>>>>>>>>> +    if (!mapping || !mapping->bo_va || 
>>>>>>>>>> !mapping->bo_va->base.bo)
>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>> +
>>>>>>>>>> +    bo = mapping->bo_va->base.bo;
>>>>>>>>>> +    if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
>>>>>>>>>> +        return 0;
>>>>>>>>>> +
>>>>>>>>>> +    amdgpu_bo_placement_from_domain(bo, 
>>>>>>>>>> AMDGPU_GEM_DOMAIN_VRAM);
>>>>>>>>>> +    r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>>>>>> +    if (r) {
>>>>>>>>>> +        DRM_ERROR("Failed validating the VCN
>>>>>>>>>> message BO (%d)!\n", r);
>>>>>>>>>> +        return r;
>>>>>>>>>> +    }
>>>>>>>>> Well, exactly that won't work.
>>>>>>>>>
>>>>>>>>> The message structure isn't TMZ protected because
>>>>>>>>> otherwise the driver won't
>>>>>>>>> be able to stitch it together.
>>>>>>>>>
>>>>>>>>> What is TMZ protected are the surfaces the message
>>>>>>>>> structure is pointing to.
>>>>>>>>> So what you would need to do is to completely parse
>>>>>>>>> the structure and then
>>>>>>>>> move on the relevant buffers into VRAM.
>>>>>>>>>
>>>>>>>>> Leo or James, can you help with that?
>>>>>>>>    From my observations, when decoding secure contents, register
>>>>>>>> GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ
>>>>>>>> buffer address.
>>>>>>>> And this way works when allocating TMZ buffers in GTT domain.
>>>>>>> As far as I remember that's only the case for the decoding,
>>>>>>> encoding works
>>>>>>> by putting the addresses into the message buffer.
>>>>>>>
>>>>>>> But could be that decoding is sufficient, Leo and James need
>>>>>>> to comment on
>>>>>>> this.
>>>>>> It seems that only decode needs TMZ buffers. Only observe
>>>>>> si_vid_create_tmz_buffer()
>>>>>> was called in rvcn_dec_message_decode() in
>>>>>> src/gallium/drivers/radeon/radeon_vcn_dec.c.
>>>>> Mhm, good point. Let's wait for Leo and James to wake up, when we
>>>>> don't need encode support than that would makes things much easier.
>>>> For secure playback, the buffer required in TMZ are dpb, dt and 
>>>> ctx, for
>>>> the rest esp. those for CPU access don't need that E.g. msg buffer, 
>>>> and
>>>> bitstream buffer.
>>>>
>>>>  From radeon_vcn_dec.c, you can see the buffer for dpb and ctx, and dt
>>>> buffer frontend/va/surface is set to PIPE_BIND_PROTECTED.
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Leo
>>>>
>>> For VCN1, due to performance reason, the msg and fb buffer was 
>>> allocated
>>> into VRAM instead of GTT(for other HW), but those are not TMZ in 
>>> order to
>>> have CPU access.
>>>
>>>
>>> Regards,
>>>
>>> Leo
>>>
>>>
>>>
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
>>>>>>>> Regards,
>>>>>>>> Lang
>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +    return r;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int
>>>>>>>>>> vcn_v1_0_ring_patch_cs_in_place(struct
>>>>>>>>>> amdgpu_cs_parser *p,
>>>>>>>>>> +                       struct amdgpu_job *job,
>>>>>>>>>> +                       struct amdgpu_ib *ib)
>>>>>>>>>> +{
>>>>>>>>>> +    uint32_t msg_lo = 0, msg_hi = 0;
>>>>>>>>>> +    int i, r;
>>>>>>>>>> +
>>>>>>>>>> +    for (i = 0; i < ib->length_dw; i += 2) {
>>>>>>>>>> +        uint32_t reg = amdgpu_ib_get_value(ib, i);
>>>>>>>>>> +        uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>>>>>>>>>> +
>>>>>>>>>> +        if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
>>>>>>>>>> +            msg_lo = val;
>>>>>>>>>> +        } else if (reg ==
>>>>>>>>>> PACKET0(p->adev->vcn.internal.data1, 0)) {
>>>>>>>>>> +            msg_hi = val;
>>>>>>>>>> +        } else if (reg == PACKET0(p->adev->vcn.internal.cmd, 
>>>>>>>>>> 0)) {
>>>>>>>>>> +            r = vcn_v1_0_validate_bo(p, job,
>>>>>>>>>> +                         ((u64)msg_hi) << 32 | msg_lo);
>>>>>>>>>> +            if (r)
>>>>>>>>>> +                return r;
>>>>>>>>>> +        }
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    return 0;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +
>>>>>>>>>>      static const struct amdgpu_ring_funcs
>>>>>>>>>> vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>>>>>          .type = AMDGPU_RING_TYPE_VCN_DEC,
>>>>>>>>>>          .align_mask = 0xf,
>>>>>>>>>> @@ -1914,6 +1981,7 @@ static const struct
>>>>>>>>>> amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>>>>>          .get_rptr = vcn_v1_0_dec_ring_get_rptr,
>>>>>>>>>>          .get_wptr = vcn_v1_0_dec_ring_get_wptr,
>>>>>>>>>>          .set_wptr = vcn_v1_0_dec_ring_set_wptr,
>>>>>>>>>> +    .patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>>>>>>>>>>          .emit_frame_size =
>>>>>>>>>>              6 + 6 + /* hdp invalidate / flush */
>>>>>>>>>>              SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>
