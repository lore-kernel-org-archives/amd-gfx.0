Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07B0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE3710E4A3;
	Tue,  8 Mar 2022 16:30:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0588510E31A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxZ7YxTy8lsW0SSDNMRe0IU6IXTk1ZgaQSHNHi6JOTlGNaNjhZOkHjJhl/zKRUslpEJHrhG2GSaooLu6uWva2N89r5kuLXcD0vwtVGzO0uXmteJzKY9V+SjDhZaJptkWUvz4RzOCechhgjZuPlhk7e2ktf+D75bynpoQp1t2w6NcUXA/twG1Hjpd7veDEdMowj7pZcI6P793cG7aiugbfCK+IPeCGuLiUGp4Rr60f4A8pY1Kw5r7t5EeJma1LMadbyohoHasvmGh1YxBZBmlfill2L2TG412QIeQS/t0I1ZGBnKytXDFQVAMrb1A89vyOyHPQzF8pkNnS4ksqIbO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQF6eCBiHjYp0uhkPa3AsTeNH0z74n17BnJDBsTXpII=;
 b=CJ0BjTvFcJdbQx/LdPEdu23sWenNX/KOP1nkqjK+LWCYseQvACncj8PjGutdXEbIXC3Z5kIFXBVQfRBINxUSp/MhRBSj0MDmpsPVziDyQ546SphmRcCYJGzARFVjCgpKbOD1nkwJ+cYECjn04FwRGZYkFpLmT+ZPJKkSJ2zzdQ8v6b836aqQFxcdXEdLXrDQKPulMLl5P5wKSnVxjHHBMlEtDzglD4Oj3E6TT39TdhfCIk/fBNx4iyL8IAv9E75Mt9g0QZqSfZ9I8lV8JZj70DWcP360qKUVFOUBdj6+S4cwox7BHegqmcAXgE4XRh9I4wctWJK231kSvGFDXPWmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQF6eCBiHjYp0uhkPa3AsTeNH0z74n17BnJDBsTXpII=;
 b=ty6GUtctMGQxyOpCGege2+ZZ8vxJiFlQulSOaHtThyzCjrJOK/EMXVuPwQg0HiMpwrnANS9BhCNfc6IgEkzKCM4ndw96Ltb/uRRvPzq45so7qYa2NQQYchpdt47+NI+zHYpDgvoUWqlf9kiZXZUMm3KkPkKieSWECea7U2aNC8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CY4PR1201MB0054.namprd12.prod.outlook.com (2603:10b6:910:1a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Tue, 8 Mar
 2022 16:30:18 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::19ab:5c87:f10d:51cb]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::19ab:5c87:f10d:51cb%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:30:18 +0000
Message-ID: <95e6f48e-fdc7-e535-1803-080a8d189d33@amd.com>
Date: Tue, 8 Mar 2022 11:30:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Content-Language: en-US
From: Leo Liu <leo.liu@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <ckoenig.leichtzumerken@gmail.com>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
 <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
 <YicOku9HhC3wJUb8@lang-desktop>
 <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
 <ec57da49-8a3f-852b-aaee-5bacdeb56c80@amd.com>
In-Reply-To: <ec57da49-8a3f-852b-aaee-5bacdeb56c80@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::18) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ade3ca5b-948e-4233-40a8-08da0120eed5
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0054:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB005461E6075BCAC9AB37A2FFE5099@CY4PR1201MB0054.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BejJQy1tOjqnxlR2C7p4jq4K5N+ULoRvKdnm6sqQpkTnSC1XvnKSQoVGr4knbiC9PSMJdom9TTdBs0cxfrZAn4NH31Hz9CS3sygJkLWQ0x8xu8eFuj+6FoGx7IreqpTJvrLzHZ07O3e5OIDyoPKFCF5Av1RF/7W5iQIG6+QUWMJITVHwNBTehf4Jb8OAFSlWey6TmUbp567hGNV1AEr/KaLMZ9m7XRdlDGDT+dICNu/R972cP81DcIRaPj3UqjTp20+g9n+S4eFQQqpufQYgBRJMQYF8lxgo/vlV7zHk/x09DBvQt+UfpUpNDSTDbvyXdFjyv6hF5F1g1BS2aVVFASAMUWQo2E2ZecbLJv4VaBOYz8h3QIR95V5jZutYZjlB835Z5gf2XNsXQ5qy6I3DbiR4doI5o0qJ5rzDoaTkvrL1uDNj8CtP6O83XbVpEZ/XpOG/xWIQ1GjT9QL9OqAVk6CBGRkYAl0rYF86OQP0ME/iJMkDvbqbE2jT5VAJxrAmBF6ElczP4wWgu99Hp8+C2K/7oPM/fmIFCsoVQGdJwyiJ1nqUQrvuInl5IcNb05YIGY8r5dbt5RU+H0LgW+7MMh9RPsPidCR1WhAMRSGkbTziN77vav1YLVR0wxnTfUqZx9+Mv0ReaN9UzrezQL/LyFroNbmg4iacgd5y3JGNRVmrwKsoPXuKMDKn2tvuknVUZX2KM7KHR/yH+c0bKt++C+T/A0eqk5pCbwLVHJwNE7f39CefE+ekn0TeFuwYEzOW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(84040400005)(66574015)(2616005)(186003)(26005)(38100700002)(8676002)(36756003)(66946007)(66476007)(66556008)(8936002)(110136005)(31686004)(316002)(6512007)(54906003)(4326008)(86362001)(2906002)(31696002)(53546011)(508600001)(5660300002)(83380400001)(6486002)(44832011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlaeWdJaHJYR0FNZnM0Wm5NNTNMSndDMkh6K0NpbjZVeUY1SlhOOEYyaGx4?=
 =?utf-8?B?MGFHaTE0cS9nU3JiN01NNG45TWhkK3JXajhXMlZnaThQZmtDTjJiQ29kQnR3?=
 =?utf-8?B?WDZHQnNxWmN5STR1QVBCQVZIK25STGRITmZHMjh6T1RrdkNza0hia2dIaWNs?=
 =?utf-8?B?cE5XeHBFZzFidkpxOGxYakNhUzdmRWduMG8yaEVmRnplMTNUdkVROE1XYm5T?=
 =?utf-8?B?eGZVWW5hWHdVODlxeW9vMDFqS1BnQU5VZENXT3Faa21vbXdFSmpLTzU0WS9q?=
 =?utf-8?B?eU8ranQwWHp2aTRrMjlHZ1gydytOY3pkVXlFTlFLV3VGaFRJdVg0eUY5MDAx?=
 =?utf-8?B?NXIyd1BMK09HWGdkZTFyQWFUOVA2bVI2Sm1YT1k1bzZSOVZXSzdrS0tDQVZY?=
 =?utf-8?B?TVREYzFDMU1iSE9mdWUwOUFnUmNIRU52aHVobW1SRHhQTVFXRW5KdHhWT1NX?=
 =?utf-8?B?Q2xWSHhPY2xKekdRb0V2enhXQTRpUWlNV0xZMkl2b1V0RXMxREtaS3BJZ2tD?=
 =?utf-8?B?VzRVTDFraHZsNC9CWHQ5TDdEUzJPVnRZZU5DQno3aXpUaEtxdFVxSzRXcU5T?=
 =?utf-8?B?TXc5Z2hRZ3V5K0xGdktmSUlwbzNvWkFiczEvc0tTd2J5bmRvMkRsSE41MFov?=
 =?utf-8?B?cENoSnJyZXJnNmIvNHpFMlJMRkNqS2J2bkI0d09MVVUzVXlUK1FwSmhsdC9z?=
 =?utf-8?B?bExrUko1RWg2MVV6TmZXQVZ5THM1VlNBM2dtUStNNE5lYWx6WXViS1NWNWtk?=
 =?utf-8?B?Nm85NGdzOW40bDhWeHp6SXd4V2lGY2d3alNmS1I4WHpVaXVxZE5McW94MzZq?=
 =?utf-8?B?UTRHazNuZHRMN0phTXVaM3l0UTRvUzI5eFFiNjJxODJIcXRKVXJJVjJ0blN4?=
 =?utf-8?B?TmN1dVZYdDdkVEx6SW82Z0FhLzRsWXFBRE1obkxlY0Y4V0dLb2E5T2JWd1kz?=
 =?utf-8?B?MUpzQmNNRnhnMU8rNUNMVjA4VzVaVEhweU04LzZTaXdxb29IQWJwcGlxVGRJ?=
 =?utf-8?B?ZWphQmRuWUVKUzNLUStGYUt1SUZuZHlxclhhd3h3OXgxOWNBR280OHY0dmRm?=
 =?utf-8?B?ZkI4Qk5qRGk4a3kxQTFpVXZsVlo5ZU96QWVBeVVjWEZPVXN1bWVNc1d4cVpI?=
 =?utf-8?B?MEdLY1dwTkc5T0hYUmN0Vk0xaDJlQ0ZqSzhQR2lJZnpQZmthOC9RRXlKQ2Rp?=
 =?utf-8?B?QVY1ZE1QVndidkVlWFZJY3gvZS9UZXRuczZkbzVVVlJMR0EzM2tibHN2ZEtx?=
 =?utf-8?B?RDBjTmU3cGYyMkQvN08xaER2MXJaaFhudUlzVGI4RjBMd2tuNUxEdjdrMkIr?=
 =?utf-8?B?YVdVNXNpSzRZNTEwRk8xNDRHUDArSEFVMWxwRVhPekNNcGdYeEFHa3JVZERZ?=
 =?utf-8?B?QlRqbytqckhWYUpLa24veHJkZVUzNDJOTjNMMkZCV0xnRVlkTVQ0Z0lmWWp4?=
 =?utf-8?B?MmZuNFZXSElwcVROZmJsUzVJNnorRVVCVlNUMmhjeXpSVllIMVJhdkRHNXU1?=
 =?utf-8?B?SkpYSWhVbWg5Q0NEQjRvTUlEdEN1UGFyM0NmZVpGZUpDb1kzR0RHeUMzMUlM?=
 =?utf-8?B?MC9hQVc0K2E0TC9LaSswaTk4ZGhTeTVhY0pKL3orQVBkWnhnMk5qQTZJRSs3?=
 =?utf-8?B?Z0R6V25OTm1BeitKOWwzZ3pGMjBWZUl2c051aCthODl6NjVWR3dGVURtNHpx?=
 =?utf-8?B?WmxqUmlYWG5pMitEK0ZFcTNhZExWY21WMm16RCtkWW9FZEVxZXF5T1d1RU5W?=
 =?utf-8?B?VGFiYlhhWnVpV1cyUDBsQ3U2NmZsZGoxVGVnTFJKMGF3UUpvL1VmMG1udWZi?=
 =?utf-8?B?RERDbm5oNnBNMno2U2ZNTlJ0V0RobzB6U0lSS2h6UlJjY3NMOWhGT1Rkc2Iy?=
 =?utf-8?B?YWlrUmFhKzYxdm8rNTJyZERtUU9yM3BXVDhpeHhWUksxZDZXOUEra0ZtcTNL?=
 =?utf-8?B?eGNRcEZaWDZFZ2hxK2R5d1JTcnkzNDBWVWZZRDM3MWt5N1F1Z0NKOFh0V0JV?=
 =?utf-8?B?V2ZjV0VjQ1VZUWdJQjQzZzU3OWIwVVVFOVRQY1VHT2hVRW9MYVV1RTVRNkMw?=
 =?utf-8?B?YWVOSUlROXBHZWkzdk9NejJjVFkza3lmNUZ6ZXE4VmN0RUtxRGJvWE40bVRU?=
 =?utf-8?Q?y7Qo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade3ca5b-948e-4233-40a8-08da0120eed5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:30:18.5917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UK9jV4l5Abyb0ALQ6nGkvHd6ElR+KYBYbtWFI8WYowHmm/LCrNyCHIadmcU+xetl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0054
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


On 2022-03-08 11:18, Leo Liu wrote:
>
> On 2022-03-08 04:16, Christian König wrote:
>> Am 08.03.22 um 09:06 schrieb Lang Yu:
>>> On 03/08/ , Christian König wrote:
>>>> Am 08.03.22 um 08:33 schrieb Lang Yu:
>>>>> On 03/08/ , Christian König wrote:
>>>>>> Am 08.03.22 um 04:39 schrieb Lang Yu:
>>>>>>> It is a hardware issue that VCN can't handle a GTT
>>>>>>> backing stored TMZ buffer on Raven.
>>>>>>>
>>>>>>> Move such a TMZ buffer to VRAM domain before command
>>>>>>> submission.
>>>>>>>
>>>>>>> v2:
>>>>>>>     - Use patch_cs_in_place callback.
>>>>>>>
>>>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68 
>>>>>>> +++++++++++++++++++++++++++
>>>>>>>     1 file changed, 68 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>> index 7bbb9ba6b80b..810932abd3af 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>> @@ -24,6 +24,7 @@
>>>>>>>     #include <linux/firmware.h>
>>>>>>>     #include "amdgpu.h"
>>>>>>> +#include "amdgpu_cs.h"
>>>>>>>     #include "amdgpu_vcn.h"
>>>>>>>     #include "amdgpu_pm.h"
>>>>>>>     #include "soc15.h"
>>>>>>> @@ -1905,6 +1906,72 @@ static const struct amd_ip_funcs 
>>>>>>> vcn_v1_0_ip_funcs = {
>>>>>>>         .set_powergating_state = vcn_v1_0_set_powergating_state,
>>>>>>>     };
>>>>>>> +/**
>>>>>>> + * It is a hardware issue that Raven VCN can't handle a GTT TMZ 
>>>>>>> buffer.
>>>>>>> + * Move such a GTT TMZ buffer to VRAM domain before command 
>>>>>>> submission.
>>>>>>> + */
>>>>>>> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
>>>>>>> +                struct amdgpu_job *job,
>>>>>>> +                uint64_t addr)
>>>>>>> +{
>>>>>>> +    struct ttm_operation_ctx ctx = { false, false };
>>>>>>> +    struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
>>>>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>>>>> +    struct amdgpu_bo_va_mapping *mapping;
>>>>>>> +    struct amdgpu_bo *bo;
>>>>>>> +    int r;
>>>>>>> +
>>>>>>> +    addr &= AMDGPU_GMC_HOLE_MASK;
>>>>>>> +    if (addr & 0x7) {
>>>>>>> +        DRM_ERROR("VCN messages must be 8 byte aligned!\n");
>>>>>>> +        return -EINVAL;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    mapping = amdgpu_vm_bo_lookup_mapping(vm, 
>>>>>>> addr/AMDGPU_GPU_PAGE_SIZE);
>>>>>>> +    if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
>>>>>>> +        return -EINVAL;
>>>>>>> +
>>>>>>> +    bo = mapping->bo_va->base.bo;
>>>>>>> +    if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>>>>>> +    r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>>> +    if (r) {
>>>>>>> +        DRM_ERROR("Failed validating the VCN message BO 
>>>>>>> (%d)!\n", r);
>>>>>>> +        return r;
>>>>>>> +    }
>>>>>> Well, exactly that won't work.
>>>>>>
>>>>>> The message structure isn't TMZ protected because otherwise the 
>>>>>> driver won't
>>>>>> be able to stitch it together.
>>>>>>
>>>>>> What is TMZ protected are the surfaces the message structure is 
>>>>>> pointing to.
>>>>>> So what you would need to do is to completely parse the structure 
>>>>>> and then
>>>>>> move on the relevant buffers into VRAM.
>>>>>>
>>>>>> Leo or James, can you help with that?
>>>>>   From my observations, when decoding secure contents, register
>>>>> GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ buffer 
>>>>> address.
>>>>> And this way works when allocating TMZ buffers in GTT domain.
>>>> As far as I remember that's only the case for the decoding, 
>>>> encoding works
>>>> by putting the addresses into the message buffer.
>>>>
>>>> But could be that decoding is sufficient, Leo and James need to 
>>>> comment on
>>>> this.
>>> It seems that only decode needs TMZ buffers. Only observe 
>>> si_vid_create_tmz_buffer()
>>> was called in rvcn_dec_message_decode() in 
>>> src/gallium/drivers/radeon/radeon_vcn_dec.c.
>>
>> Mhm, good point. Let's wait for Leo and James to wake up, when we 
>> don't need encode support than that would makes things much easier.
>
> For secure playback, the buffer required in TMZ are dpb, dt and ctx, 
> for the rest esp. those for CPU access don't need that E.g. msg 
> buffer, and bitstream buffer.
>
> From radeon_vcn_dec.c, you can see the buffer for dpb and ctx, and dt 
> buffer frontend/va/surface is set to PIPE_BIND_PROTECTED.
>
>
> Regards,
>
> Leo
>
For VCN1, due to performance reason, the msg and fb buffer was allocated 
into VRAM instead of GTT(for other HW), but those are not TMZ in order 
to have CPU access.


Regards,

Leo



>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> Lang
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
>>>>>>> +
>>>>>>> +    return r;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int vcn_v1_0_ring_patch_cs_in_place(struct 
>>>>>>> amdgpu_cs_parser *p,
>>>>>>> +                       struct amdgpu_job *job,
>>>>>>> +                       struct amdgpu_ib *ib)
>>>>>>> +{
>>>>>>> +    uint32_t msg_lo = 0, msg_hi = 0;
>>>>>>> +    int i, r;
>>>>>>> +
>>>>>>> +    for (i = 0; i < ib->length_dw; i += 2) {
>>>>>>> +        uint32_t reg = amdgpu_ib_get_value(ib, i);
>>>>>>> +        uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>>>>>>> +
>>>>>>> +        if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
>>>>>>> +            msg_lo = val;
>>>>>>> +        } else if (reg == PACKET0(p->adev->vcn.internal.data1, 
>>>>>>> 0)) {
>>>>>>> +            msg_hi = val;
>>>>>>> +        } else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
>>>>>>> +            r = vcn_v1_0_validate_bo(p, job,
>>>>>>> +                         ((u64)msg_hi) << 32 | msg_lo);
>>>>>>> +            if (r)
>>>>>>> +                return r;
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +
>>>>>>>     static const struct amdgpu_ring_funcs 
>>>>>>> vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>>         .type = AMDGPU_RING_TYPE_VCN_DEC,
>>>>>>>         .align_mask = 0xf,
>>>>>>> @@ -1914,6 +1981,7 @@ static const struct amdgpu_ring_funcs 
>>>>>>> vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>>         .get_rptr = vcn_v1_0_dec_ring_get_rptr,
>>>>>>>         .get_wptr = vcn_v1_0_dec_ring_get_wptr,
>>>>>>>         .set_wptr = vcn_v1_0_dec_ring_set_wptr,
>>>>>>> +    .patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>>>>>>>         .emit_frame_size =
>>>>>>>             6 + 6 + /* hdp invalidate / flush */
>>>>>>>             SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>>
