Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD28C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 14:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D08910E14A;
	Thu, 10 Mar 2022 14:26:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9747B10E14A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 14:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVRimNTEOfpvTR6YiCqTIwEPH5v2oUiLnXdDNwJnbA9Bq80Ftv82x+ieFNyBLcqYoLC6JAkh3RgiqP7IoEWAJm1dDNAZGdQczf84KGkSSvLkCHvS6z0ixpxnnYrzBWc/l2Xc4/JGAxWdwLt19A4xq7XJH2qr7Is6nxTcGwSaK54ZM7FcG5Qg4l3brrlMxv8FeStSfAzpgFXJHCIGYN5kM2+bHx8k5sYdd9nqLMtLfqJQNvBqFCoWwqUzLwex8U2ZdF/QLIGmN+/ypJGG44pMFMTyUZCxhTrm+p8mucYGKZkGbDAKypG1ZjTRC8yldy5N5S291WF5BGYxvvAdhv1VWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aRlkKl7G5pn+B2m7DQiDj9B2u0U/7mO1KjDqVevFEc=;
 b=ID+wXRfzntH9b9cMt+2p/31iKcIbi2TVicxHwyx9dBU1UnN1D17ZFtD5YsLcDrgKINms7gVRVaVWSx3WVR0wRN2M4baivsMVDqoSg/Ag/F/H1Z59mYzJDSh9kmroMGTiAHVd9xnEPJ0G03yywn1qbX2VvTOauixncxqa2STU9SN4I8hoB7/uohVh/x1GeknloIctX4SQMWsg5iKPtjbHmxnDnhvVJ5PKAg7sQKOa/uv3IGsd7tIGOzZcGoX+wBjPXhxZ7EJ4S2BN/j4g8ABTks18lcghRbZX7umTFTnXyMb6vBRUZsxrTeS3LsPYGMgUqMVjh60Fb953gErqUFq5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aRlkKl7G5pn+B2m7DQiDj9B2u0U/7mO1KjDqVevFEc=;
 b=PLIGW3HKTLcmHHg2YG98HuKa5wVSSGlBZElJpAuaRGg+GEQ1YvS0wAASusgN94IJRV43afPxih/fvLpR+2E9Y/IMmFu+GDkZsnz59veQj3kiU0agwycTZJIKdvuzPokVPyYasEtYwWRWQ7c+1xoc4ddh39Q1euKVjlJqyu2Ft4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5392.namprd12.prod.outlook.com (2603:10b6:5:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 14:26:06 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5038.029; Thu, 10 Mar 2022
 14:26:05 +0000
Message-ID: <b1277562-f425-b466-856f-f9590dd9a38a@amd.com>
Date: Thu, 10 Mar 2022 15:25:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Content-Language: en-US
To: Leo Liu <leo.liu@amd.com>, Lang Yu <Lang.Yu@amd.com>
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
 <d6c3cf48-7699-7192-5655-4c5bd7f7a37b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <d6c3cf48-7699-7192-5655-4c5bd7f7a37b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a4df0f3-430d-4fac-8725-08da02a1e92c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5392:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5392A8D03928EA7D386CAE4B830B9@DM4PR12MB5392.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfXk7xj77+pKfKHspJ+kMuZ7Or/bf3wobadz82ewq9sWnqaLpdEpJPUjA3tlVgFwUsDIkc2zREc9qhSugjqfQdWsVguUwV1O4oX9EGkkkBIVmz/8LuoyWVLkploBm0wXL2i90v+o+uA0YpO+NR4alpqUDEdIzOT/QTUX+ImqY169j0risaPQMSz8wLEvri5SnEPH768KqQlX0So8ABK9940YgLP/b78xqkPEku1DHFuTBHqugdH8r0u23SYHfhkg6CcRJP/AmpCuQkiG/8pazknir+aEOAtfsat7l64GvOLhu/Jn6TcD9vcsI7mBftwCoCmq5nZ3nQxKJVBvIE3AzCS5RCM01372kPAe3d++jvdMdHGV8ZdZNxHG4qtSZwmLTWy3NmA/ALPy205gNX9vCUUuwi1RkLChjw0dK6OVKCNBKcHScqs7wu8xLwtJZupuUo5OKhl+6tYFMwpOFYRBqrhyvtAIIdCs6BadeD7WOnDYSpxZsFelgKIb7vDBQWRA5uCOif2GMuippWo3ekWtL7jKDLJsv1ltUAMtvs80E5nwdyTsbXo7KMJPda+iPg7Q2Uirl4etLj1HGc6vm7uERvKSyS7P09EqyxXGPcIQEwvnBlCGP3uSCJQU85222bbiI6Pz3PJ9gJyoL/5FXOzWQ3fQuYrnKE1OHxcapKABUM+xJtcwnVbwudfDBc4yDCUcxpnnHxCaL66clrgZQGicDl9bjVQLaZwzTmH8s9x0Ho7SfQ+KTC75DvziMjJuwxRA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(84040400005)(66574015)(6666004)(6506007)(2616005)(186003)(26005)(6486002)(6636002)(316002)(54906003)(110136005)(53546011)(508600001)(38100700002)(6512007)(31696002)(86362001)(83380400001)(66476007)(66556008)(66946007)(31686004)(2906002)(8676002)(8936002)(36756003)(5660300002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cElmWm5nRXFDY3FZZXRHL3BPUVlNaGI1RjA0aXlBQmZ0MlhEM3MwUzR4akVB?=
 =?utf-8?B?cm5CSFExckpxb3MxMC9kUmZpSnlwYmlzaDFLaDZtbThmT0EyMGtoMXNsZmhF?=
 =?utf-8?B?V3lYcDFnMnB5emI1QUxYQTQzSTNJWGY4RDhVMTNFcW5wR05uOFl1UVR2ZjZu?=
 =?utf-8?B?V3M3aTBVU1RldzEzR3VVUjNzMHlaUGw1TEdVa3NycWxoZ1pKTG9YUE5sekli?=
 =?utf-8?B?OWE4MkRwMkdLUTFMQVVPQWNTcGY0ZXA1bzlldDdvMzJmQ3dQZTJOdkhjM1lB?=
 =?utf-8?B?VEcxYzcweDVVRmNyK2dNazRGcHNGWXUrcXVwbHJlU2dqRlpBOEk1bEdMOTlk?=
 =?utf-8?B?ZmE5dnN3eFdSZEdXU2lqZGVtOE5JT3J2cUt1ekJVMWVpRnpZbHMrd0I2WXdB?=
 =?utf-8?B?TXMvSnhWS20wcFZFb0t0QTU5SndoUDNobHhFZDJ1OEczMDdKY0JmcmdmOWVp?=
 =?utf-8?B?dDVsVWRTaHZUWExLT05XSEpGMjdKc1JmZmdJM2ZPQnI1VVBVVkNoMHVlSmpW?=
 =?utf-8?B?d2o4SnFpcHZZSUpKZ1NHbUlaWEs0YUZmVHJkU25sQjRKNVJhRzd6ZzY5eTN2?=
 =?utf-8?B?U0NmcVpaMXF6MUNsaGdmMlMwSjZQRExpYm1XQmphUW1DdUxNMWFTdnkvKzl6?=
 =?utf-8?B?Y25zU3FacmRKemVhbWpiaUJUZXN1SEl3WWd2dmhBNnVFMFowNzM4NkxERlRX?=
 =?utf-8?B?bkVWZndYVjc0c3Z3WFovK0llNE9xNFBzbUVqMmJhUno4UE9pQ2M0T1B0c2h6?=
 =?utf-8?B?WTdudkl1NmE5bUxCTWVYN2hYeHdITEZKQ0dwTUgrUkxkbTUvVVBDTXlqNk1r?=
 =?utf-8?B?TXNtalpvMU4rdFdNeFVJZnR1Y0E3SE1lemtUR2EzUzRpYTUxb3B6VmFxSUNl?=
 =?utf-8?B?ck1jOUJFM0hQSjBZNG05VzVjaE5NN05LMHVkNWxjNndncGY4aXhRc2VqSjVL?=
 =?utf-8?B?V2FWbEhmZ2FPamNGVmJ1WVpRNUJ0VHA1VEdEbzF3NmtRd1lmTFdnc3hidjIx?=
 =?utf-8?B?UGk4VHFzdG9DbHN3Q01wVGQxSnZJRzRHV3hON1EydlhtandkZzFESHpGRmpI?=
 =?utf-8?B?TXJ3NDdUeXcrNmMrRVl0WXB6R0FQeDY2a2RKY2xNSCtIeHo0b01HUFBWbTRm?=
 =?utf-8?B?ZUo3WFlYckVOWkZOeHkrZS9SZXpxVktEci9QajYyTUNqNXZrak5iNDZkMkpo?=
 =?utf-8?B?c2svVzlCZGNwYU9ia3JwSVRZeG9UVGZZVXBxMlZBUlRscHgzZlJ4N09JNzJP?=
 =?utf-8?B?Tll1Tno2eFdjcTFhdlVGS2l4Qm4vZFdWaDQ2Ujczbll4djF4WXBKc0kwUlQy?=
 =?utf-8?B?cHh3OFhnYi8vNXMwcUlPSXZ1R2pTRUFrMWNZakMvaGtUWUJwZE81dDQ3NmRJ?=
 =?utf-8?B?cmtHUUgwc0RISkN0Q0Y0MkRFNWRBNFU0MVhZK1dsa1YvbXRNVkV1MEYwSEtt?=
 =?utf-8?B?YkpwK1Q2NGZzVXkxaHhhT2x4Z3huSmlRTkJvL2hXWDN2SWRVTisrYU9namZy?=
 =?utf-8?B?Vk1aQk4yZWFJSlFoN2pZU2xVemtYYUxocHVQdDVIQ1l5RjdvQkhKU2E1cXpx?=
 =?utf-8?B?bjlWTmZCVXFkbXNLWWpXdDM3WlprUnFmVDFCWDZQZ0lhQ1BSdm9MNlJ4Nm8v?=
 =?utf-8?B?MEZwZ0lNT3NJSGhRcDZnNHdMd2U4R3g4Qm53WERpbVdDaU1MMFZxcmc5eWUx?=
 =?utf-8?B?V0FuK0pUYmdaMUx0Vm8vVytUWTB3czNic1hTcThZU21ZZWZOYXNuKzk0cEZK?=
 =?utf-8?B?MEJBSzBuWnIwNk1Cd2IyOVpoVzRhZUUwWk4yTUJNaVdVRURTME1lcUh3eVUx?=
 =?utf-8?B?VDU3WWp1b0tBOXY0enNaMCsxbXFQQjFBSjdlb1VnSTRtWFFZbmdGdUtsZVpB?=
 =?utf-8?B?Ymx1V0lub29GbVNUZGpmSFdzZnh4N0ZxVTJ0bnUxUWpkcDdvODlHMnhGWHJX?=
 =?utf-8?Q?h6xp5Wr1088eS+HyJ//NB2oPLGSP+5bV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4df0f3-430d-4fac-8725-08da02a1e92c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 14:26:05.8064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSAfHhlebnvVK4cBpY2hRbXptU7erzyQuidHA1XKIPC84oNtCIxZ0+OJF5XgNRel
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5392
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

Ok, thanks.

Lang is that case your patch should work fine.

Just add another patch with a check for the encode case to reject any CS 
with TMZ buffers in it.

Thanks,
Christian.

Am 10.03.22 um 15:17 schrieb Leo Liu:
> No need for encode. Encrypting uses TEE/TA to convert clear bitstream 
> to encrypted bitstream, and has nothing to do with VCN encode and tmz.
>
> Regards,
>
> Leo
>
>
> On 2022-03-10 04:53, Christian König wrote:
>> Leo you didn't answered the question if we need TMZ for encode as well.
>>
>> Regards,
>> Christian.
>>
>> Am 10.03.22 um 09:45 schrieb Lang Yu:
>>> Ping.
>>>
>>> On 03/08/ , Leo Liu wrote:
>>>> On 2022-03-08 11:18, Leo Liu wrote:
>>>>> On 2022-03-08 04:16, Christian König wrote:
>>>>>> Am 08.03.22 um 09:06 schrieb Lang Yu:
>>>>>>> On 03/08/ , Christian König wrote:
>>>>>>>> Am 08.03.22 um 08:33 schrieb Lang Yu:
>>>>>>>>> On 03/08/ , Christian König wrote:
>>>>>>>>>> Am 08.03.22 um 04:39 schrieb Lang Yu:
>>>>>>>>>>> It is a hardware issue that VCN can't handle a GTT
>>>>>>>>>>> backing stored TMZ buffer on Raven.
>>>>>>>>>>>
>>>>>>>>>>> Move such a TMZ buffer to VRAM domain before command
>>>>>>>>>>> submission.
>>>>>>>>>>>
>>>>>>>>>>> v2:
>>>>>>>>>>>      - Use patch_cs_in_place callback.
>>>>>>>>>>>
>>>>>>>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>>>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>>>>>>> ---
>>>>>>>>>>>      drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68
>>>>>>>>>>> +++++++++++++++++++++++++++
>>>>>>>>>>>      1 file changed, 68 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git
>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>>>> index 7bbb9ba6b80b..810932abd3af 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>>>>>>>> @@ -24,6 +24,7 @@
>>>>>>>>>>>      #include <linux/firmware.h>
>>>>>>>>>>>      #include "amdgpu.h"
>>>>>>>>>>> +#include "amdgpu_cs.h"
>>>>>>>>>>>      #include "amdgpu_vcn.h"
>>>>>>>>>>>      #include "amdgpu_pm.h"
>>>>>>>>>>>      #include "soc15.h"
>>>>>>>>>>> @@ -1905,6 +1906,72 @@ static const struct
>>>>>>>>>>> amd_ip_funcs vcn_v1_0_ip_funcs = {
>>>>>>>>>>>          .set_powergating_state = 
>>>>>>>>>>> vcn_v1_0_set_powergating_state,
>>>>>>>>>>>      };
>>>>>>>>>>> +/**
>>>>>>>>>>> + * It is a hardware issue that Raven VCN can't
>>>>>>>>>>> handle a GTT TMZ buffer.
>>>>>>>>>>> + * Move such a GTT TMZ buffer to VRAM domain
>>>>>>>>>>> before command submission.
>>>>>>>>>>> + */
>>>>>>>>>>> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser 
>>>>>>>>>>> *parser,
>>>>>>>>>>> +                struct amdgpu_job *job,
>>>>>>>>>>> +                uint64_t addr)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct ttm_operation_ctx ctx = { false, false };
>>>>>>>>>>> +    struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
>>>>>>>>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>>>>>>>>> +    struct amdgpu_bo_va_mapping *mapping;
>>>>>>>>>>> +    struct amdgpu_bo *bo;
>>>>>>>>>>> +    int r;
>>>>>>>>>>> +
>>>>>>>>>>> +    addr &= AMDGPU_GMC_HOLE_MASK;
>>>>>>>>>>> +    if (addr & 0x7) {
>>>>>>>>>>> +        DRM_ERROR("VCN messages must be 8 byte aligned!\n");
>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    mapping = amdgpu_vm_bo_lookup_mapping(vm,
>>>>>>>>>>> addr/AMDGPU_GPU_PAGE_SIZE);
>>>>>>>>>>> +    if (!mapping || !mapping->bo_va || 
>>>>>>>>>>> !mapping->bo_va->base.bo)
>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>> +
>>>>>>>>>>> +    bo = mapping->bo_va->base.bo;
>>>>>>>>>>> +    if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
>>>>>>>>>>> +        return 0;
>>>>>>>>>>> +
>>>>>>>>>>> +    amdgpu_bo_placement_from_domain(bo, 
>>>>>>>>>>> AMDGPU_GEM_DOMAIN_VRAM);
>>>>>>>>>>> +    r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>>>>>>> +    if (r) {
>>>>>>>>>>> +        DRM_ERROR("Failed validating the VCN
>>>>>>>>>>> message BO (%d)!\n", r);
>>>>>>>>>>> +        return r;
>>>>>>>>>>> +    }
>>>>>>>>>> Well, exactly that won't work.
>>>>>>>>>>
>>>>>>>>>> The message structure isn't TMZ protected because
>>>>>>>>>> otherwise the driver won't
>>>>>>>>>> be able to stitch it together.
>>>>>>>>>>
>>>>>>>>>> What is TMZ protected are the surfaces the message
>>>>>>>>>> structure is pointing to.
>>>>>>>>>> So what you would need to do is to completely parse
>>>>>>>>>> the structure and then
>>>>>>>>>> move on the relevant buffers into VRAM.
>>>>>>>>>>
>>>>>>>>>> Leo or James, can you help with that?
>>>>>>>>>    From my observations, when decoding secure contents, register
>>>>>>>>> GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ
>>>>>>>>> buffer address.
>>>>>>>>> And this way works when allocating TMZ buffers in GTT domain.
>>>>>>>> As far as I remember that's only the case for the decoding,
>>>>>>>> encoding works
>>>>>>>> by putting the addresses into the message buffer.
>>>>>>>>
>>>>>>>> But could be that decoding is sufficient, Leo and James need
>>>>>>>> to comment on
>>>>>>>> this.
>>>>>>> It seems that only decode needs TMZ buffers. Only observe
>>>>>>> si_vid_create_tmz_buffer()
>>>>>>> was called in rvcn_dec_message_decode() in
>>>>>>> src/gallium/drivers/radeon/radeon_vcn_dec.c.
>>>>>> Mhm, good point. Let's wait for Leo and James to wake up, when we
>>>>>> don't need encode support than that would makes things much easier.
>>>>> For secure playback, the buffer required in TMZ are dpb, dt and 
>>>>> ctx, for
>>>>> the rest esp. those for CPU access don't need that E.g. msg 
>>>>> buffer, and
>>>>> bitstream buffer.
>>>>>
>>>>>  From radeon_vcn_dec.c, you can see the buffer for dpb and ctx, 
>>>>> and dt
>>>>> buffer frontend/va/surface is set to PIPE_BIND_PROTECTED.
>>>>>
>>>>>
>>>>> Regards,
>>>>>
>>>>> Leo
>>>>>
>>>> For VCN1, due to performance reason, the msg and fb buffer was 
>>>> allocated
>>>> into VRAM instead of GTT(for other HW), but those are not TMZ in 
>>>> order to
>>>> have CPU access.
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Leo
>>>>
>>>>
>>>>
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
>>>>>>>>> Regards,
>>>>>>>>> Lang
>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>> +
>>>>>>>>>>> +    return r;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +static int
>>>>>>>>>>> vcn_v1_0_ring_patch_cs_in_place(struct
>>>>>>>>>>> amdgpu_cs_parser *p,
>>>>>>>>>>> +                       struct amdgpu_job *job,
>>>>>>>>>>> +                       struct amdgpu_ib *ib)
>>>>>>>>>>> +{
>>>>>>>>>>> +    uint32_t msg_lo = 0, msg_hi = 0;
>>>>>>>>>>> +    int i, r;
>>>>>>>>>>> +
>>>>>>>>>>> +    for (i = 0; i < ib->length_dw; i += 2) {
>>>>>>>>>>> +        uint32_t reg = amdgpu_ib_get_value(ib, i);
>>>>>>>>>>> +        uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>>>>>>>>>>> +
>>>>>>>>>>> +        if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
>>>>>>>>>>> +            msg_lo = val;
>>>>>>>>>>> +        } else if (reg ==
>>>>>>>>>>> PACKET0(p->adev->vcn.internal.data1, 0)) {
>>>>>>>>>>> +            msg_hi = val;
>>>>>>>>>>> +        } else if (reg == 
>>>>>>>>>>> PACKET0(p->adev->vcn.internal.cmd, 0)) {
>>>>>>>>>>> +            r = vcn_v1_0_validate_bo(p, job,
>>>>>>>>>>> +                         ((u64)msg_hi) << 32 | msg_lo);
>>>>>>>>>>> +            if (r)
>>>>>>>>>>> +                return r;
>>>>>>>>>>> +        }
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    return 0;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +
>>>>>>>>>>>      static const struct amdgpu_ring_funcs
>>>>>>>>>>> vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>>>>>>          .type = AMDGPU_RING_TYPE_VCN_DEC,
>>>>>>>>>>>          .align_mask = 0xf,
>>>>>>>>>>> @@ -1914,6 +1981,7 @@ static const struct
>>>>>>>>>>> amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>>>>>>>>>>>          .get_rptr = vcn_v1_0_dec_ring_get_rptr,
>>>>>>>>>>>          .get_wptr = vcn_v1_0_dec_ring_get_wptr,
>>>>>>>>>>>          .set_wptr = vcn_v1_0_dec_ring_set_wptr,
>>>>>>>>>>> +    .patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>>>>>>>>>>>          .emit_frame_size =
>>>>>>>>>>>              6 + 6 + /* hdp invalidate / flush */
>>>>>>>>>>>              SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>>

