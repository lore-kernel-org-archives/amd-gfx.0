Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20703C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 14:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D75010E5FB;
	Wed, 26 Apr 2023 14:04:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F23FB10E9AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 14:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIWs3nz3qWkIbYHKS73rzBZVuGqU0YOnXO+nNuqtZaw0R3S86OtPGUG335dKcY/bRXRgDVtcgmXxreyOYS6SbszEYmEbGsIxIuP5R7Q6NMmssRsor25hFygSDRu25YA+FoPN19ad9TjtNUan8FkVubUYtpCDy6+ML5xIRFjFV8qT0DrrV43B0lJogf3MC1GkGMzGXGWpevgqAHeo+FZzoVzfFAaouZfsSRCtUqxaZl9To2sL+y4xAgX28GYeeFFWp8J2BqcVgYSQIfQvzpS+7SeD7CNXQTO5xRjIJYXe/g0u0Lduj7YfV5Kz6qAjfW/+GQ2mQpHOzjBq9DhA3wO2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzkBbwqmEzAPCCbp25ZZLiVNuxsszyadbA1e0bqAxsw=;
 b=n7S6P6CeNPp8tcSBcvH4UZDEir/cbt3gi2kdl3tSWNc+Aeg5iwy/2LMGWq2X01xfssp/osEnVGr8Of+kpK5kNjJX3la2fbpFBLfYcBLHprpEvT8CRYoxZjep/yQ2/9dvOBYyGqL75v+G1LBjxhPni4oVwPEumm6VssyGfDJmgGsgvYwDYoJZhVE6RHwcIr+XiEXzcBWLpD/fpBty1ghK7q0s98PlSx5+A4I0cLmICCT2JdT1jCmpewq+Oc6txsgnNdtMz3D89NsuOZBuyDTQdy2Trc7CGKC/9RxqhqP9ECXVmubArIfeDOYSLTt44H63RbreyAWb9x6ckknwML9LzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzkBbwqmEzAPCCbp25ZZLiVNuxsszyadbA1e0bqAxsw=;
 b=5mHOfAWXbgwZ/hOHADRMKED5sHmEh5MjYxmI/RSfybXXNtSoFHeaDI49Z5/o/gHxfOwUcS+S07n1aDAXHwiXzGxsRmoxn56aKjVBC1pFU7wb4AUR+LPp12W91lKoXYxt3bmcg+o8JSTxBLEogi1cdgmZbsBAtbV7M6JxQelRlRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 14:04:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 14:04:01 +0000
Message-ID: <8b8d22bd-0eff-2f81-9267-07c4c4d058d1@amd.com>
Date: Wed, 26 Apr 2023 16:03:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230412222511.236384-1-jinhuieric.huang@amd.com>
 <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
 <6d32ae76-08fa-64a4-6726-2d55e8c9fc08@gmail.com>
 <7df3dfd1-d89c-1f24-c3b9-789e1bedf138@amd.com>
 <73c8c82e-907a-1666-b05b-4ba257363a01@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <73c8c82e-907a-1666-b05b-4ba257363a01@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f49256-e4fa-4f40-b481-08db465f1558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOUQuwGDOq2unGSUUrsWjK4X2wpBfFSG5mRDg2TZmmcudqnUjMU26RgmPGgpHlJHv0gdbu7akdZ1tf+GtHiVLNpR2b5UrTDmhKxtNUJjLs/LcJsbgFIDa0Z9oQPb7IGol6SmUA364TqAez3XzF3VUT4TId/ezW/lvM05AmLsMHcbIMBFpPfhbWrv2AWE1PgBjrBdRmA2KIitw/hhm2N2vsXsJLJm/2D+QMMymyPoys0ziWJrOcKqdupsQOCOftUWXP0rc/ED99FJxSXy+Q/zeVrASkDquqkUk2OiHvK5j1qBb+4ydew5hr5msTDkuG40UvNeBOAVeUjW8h/vB8E2DEUxlut2CD8b0s4RXGdixi2kZfodPREOXo1Sgefh/retmtmmaIRQ06HKmIYoqJaRElShCkJgiNc/pk2t9fSJFNF69vzVFTqvBlanLGQekomGIliEndfsISLq53vkufo9Fa9kEOBR0jCCEAYRSC5wu8RbiOl8kYt/6OTe6bmHoht1O57zszQavt2B8/B13Gi5F6NEtCE90Dlk5euDi481f3c/V1GTv8PvK4LS9pIkUG/4tING4f7AGC2SnAEDqzIS2YnQNgEsoaLHVfBiyDecdhadlgBqhwP3HllxrGt3VsmKDQ85+gf2mTuJnXVYl1l44w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(66574015)(66556008)(186003)(86362001)(83380400001)(6506007)(6512007)(31696002)(53546011)(36756003)(2616005)(38100700002)(8936002)(316002)(41300700001)(8676002)(5660300002)(6666004)(6486002)(66476007)(66946007)(110136005)(478600001)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlREaG9KdzMyN2RKTGV3Q2R5a21TRStlU0VkcFVwc041cHRqcDJURTFvL0R4?=
 =?utf-8?B?SE02VXlSQ2VibnB5Z2tRSkVXL2hTNUhqVnRVd1hYbjgrY1dYUzE4Y2R6WU13?=
 =?utf-8?B?WFZ3SC8zZXN1K21XNmVmTUc0MGNFN3lLeFF6cFJCUnNmRXlMOGk5RE5XQ2dr?=
 =?utf-8?B?QnR6RHAyZFhtSzRZOHZHZ3dDaDlub0NCeFVoalczTG51UU0yRGovSmFWRnM5?=
 =?utf-8?B?Z3VmOWJPeFNJanpzM0FpUGxWRVE3eXF2SnlNNm5XS2xTRUk3WDNOTXVDSk1u?=
 =?utf-8?B?Z28yZXJDVW1nUmh4bXI4QnN0bUcxWEVtWVRrckFpN1Bvcks5QVlobTIxOFBO?=
 =?utf-8?B?Ti9zNC9YSmtWMnJ3SWViajVFdm9zZTVDY0NrWXE0SEI1RG5wbGJiSU43Z1hK?=
 =?utf-8?B?YVdMQkpMcUF2NXRQdEkxR21HVE5yV2RXNERxVnZGV1pZZkkwbzJFWFliOUxR?=
 =?utf-8?B?RXFBa0VWT0d5ZHhrc3JVY3RNaWtaeFZUSHFNUFJTeWl3dEMrZEZReVpFV3Zl?=
 =?utf-8?B?ZW16cDVENExJNk9jU1VDc1NuK2U4c21odWpqRGthQnlVL1NWN1h3ZjJuT25M?=
 =?utf-8?B?VDJwNWswN3B5SlpWRmFDL0F6NEhpTWdXd2tVMFFrZ2VaYWNsTWpFSGJxN0Nq?=
 =?utf-8?B?K2EzVUt6MkNlTlVFVW9qZFJFb21XbnUxOUFEdnEyVW9XY0QwQTVaNnJtSUhD?=
 =?utf-8?B?OW5MaHhVRmNXekVpUEFKdjFMNW9tWHpLc0NPTTBhL3BPUWIxN3cvN2ZiNVBH?=
 =?utf-8?B?eVc1T2ltNFIyMmJJYkxaK0dManBkQVNWZkcyaHZHRm5QaVhwKzBOYm01V2lq?=
 =?utf-8?B?MFJ3VndZZ0dSWm5RQ0ZtZWV4Y29xVDRpK2FkYlZaU092aXltSExrRVJ2TWtO?=
 =?utf-8?B?REJ4NlJkR2pXSXFMblVHTHE2dTh6Y2N5bENyc0NnMGtkT0lWN3p6M2hUVjJZ?=
 =?utf-8?B?YkU3WUN2N2lacFdFV1NpejlSa29oTks4T0xZTFdFM0dXeGdpUHhQY0l0QXRl?=
 =?utf-8?B?QTRwcXg5MStKTy9pSVpudzZKbmdtSFgyaDI3cVN0SkxpZ09TRWhPNnJweTlB?=
 =?utf-8?B?cTJqMUZNNHBucnZhaXM5ZFkwZ0JWRGphNk45bDl2NXJKSnAvUjNGdUM4cVpS?=
 =?utf-8?B?ajZaY2Ewa1BSQ01pVFQ2TnF3RldiWXBqU3hadXNZVU1zK1FCTkFDZkJiRzBD?=
 =?utf-8?B?MXpQWUpTaUxBWXZUOWVLTzhUNFBIV1p6V1NnVVBNalBLRTRmaUVsc2pUS3FB?=
 =?utf-8?B?eWxTRzBWc25uc3VWYzRBbFRLcnlpOUg4VVh6RTNLVG5PVnkyaktPaGJzelBs?=
 =?utf-8?B?OVB6Y3Z0Q0xpZlh4ajNwUjFZYXUrVjhkK29IWE9RNTlXMFlLQng2b2dwbUhN?=
 =?utf-8?B?WEQ4dHBXUDhjMWNvMm5KMmVWZ0k5TjdmYTVDVDRRMk5VeUNqV1ljQ1VpNEIy?=
 =?utf-8?B?b01vKzJ0NENPWTUyYTE2OE9xcytoSmwyNFJOdlV5MVVLNnF5NExOZDRXQ28r?=
 =?utf-8?B?RXQyeE1DdmNNa0RpdzFVNHVpR3JCTHVDSnNMcGhRVjhjNVJUNEtvRXI2eEpQ?=
 =?utf-8?B?dno4bDRMK0YxUUY0MzR1d2I2TER1NGREa0ZiR3ByVEtmUzg1RGVVMFYrUWlL?=
 =?utf-8?B?SGhVdVpQL0dKRnVpWmpiUjVQTHpON1hJcWxOVE8yQTk2MTBqMEhQZVA0ZzFR?=
 =?utf-8?B?NkV6M2Q1UVFHMDU3R2dQaWh6U3lPbVJqSDJuV3dTSmNxck5EcXVxMzJRTGRL?=
 =?utf-8?B?RStqSlVjcW9hTnNvYUJUNUhxMm5ZcEZuQnZJQWlobHVDMDJ5S0JkUGVhNUg4?=
 =?utf-8?B?a0YvVEZ5RHNjb2g0TERFUmVmc05xWlQyUlhtQUx3ejFsNmFOc0ZrZ1M4bjNp?=
 =?utf-8?B?MUpwbk12MWlhODV4b1hHYWtHeWlFZzJHSGV3dlJFeEMxRTNnY2N6OWxmb2pl?=
 =?utf-8?B?L3ErYURwK1E3djFzV3d3MUtKSklQTDNGV0tRZDlpemhiK0UwZlg1Z3lQcy9i?=
 =?utf-8?B?cDNJK2dUMDh4MGdLT2VCaS9NV3ZKMm1jdFFYNFF6SzhSQm15a0xOZkw5Sm11?=
 =?utf-8?B?dzJmSTByZG1Yd0M2V0FUMnRtZ3I4ZFcwUUN0OVA3MlZPQVpVTDhoSUdrVUF1?=
 =?utf-8?B?OVMxOE9ydXVCRXVwY0xGL0dTUkc4eklCN2pMcFJibDQ5blozSUIzT01FeTRt?=
 =?utf-8?Q?EzcXi3c9QRafCL1WSjKS+ixMg/gHrzZmuAp3Dtyvxabe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f49256-e4fa-4f40-b481-08db465f1558
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 14:04:00.9764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcLvf+QDOhjWkhazV3ukEVqheUmtqRj76hLRZDJGwciQnXtSoU0oLP81oASe4bop
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318
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

Am 25.04.23 um 16:11 schrieb Eric Huang:
> Hi Christian,
>
> What do you think about Felix's explanation?

That's unfortunately not something we can do here.

>
> Regards,
> Eric
>
> On 2023-04-13 09:28, Felix Kuehling wrote:
>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>> It is to avoid redundant eviction for KFD's DMAbuf import
>>>>> bo when dmaunmapping DMAbuf. The DMAbuf import bo has
>>>>> been set as AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>
>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>
>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>
>>>> I'd like to get an Acked-by from Christian as well before 
>>>> submitting this.
>>>
>>> I have to admit that I only partially followed the internal 
>>> discussion, but in general you need a *really* good explanation for 
>>> this.
>>>
>>> E.g. add code comment and explain in the commit message extensively 
>>> why this is needed and why there are no alternatives.
>>
>> OK. I'll give it a shot:
>>
>>    This code path is used among other things when invalidating DMABuf
>>    imports. These imports share a reservation object with the exported
>>    BO. Waiting on all the fences in this reservation will trigger KFD
>>    eviction fences unnecessarily, for example when a DMABuf import for
>>    a DMA mapping on a secondary GPU is being unmapped explicitly. Only
>>    moving the original exported BO requires stopping KFD user mode
>>    queues. If the invalidation is triggered through a move notifier
>>    from the exported BO, then moving the original BO already triggered
>>    the eviction fence and we don't need to wait for it again on the 
>> import.
>>
>>    We can identify DMABuf imports in KFD for secondary GPU DMA mappings
>>    by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>>    operation that ignores KFD eviction fences.
>>
>> How does this sound?

To be honest like quite a bad idea. Why in the world are imported BOs 
moved from GTT to SYSTEM in the first place?

The only reason for this I can think of is that the DMA mappings become 
invalid for some reasons and in this case waiting for the KFD fence is 
actually the absolutely right thing to do.

Regards,
Christian.

>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Thanks,
>>>>   Felix
>>>>
>>>>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct 
>>>>> ttm_buffer_object *bo, bool evict,
>>>>>       if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>            old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>           new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>> +                        AMDGPU_FENCE_OWNER_KFD,
>>>>> +                        ctx->interruptible);
>>>>> +        else
>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>           if (r)
>>>>>               return r;
>>>
>

