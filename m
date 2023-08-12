Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D225C0015E
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 17:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830E510E09D;
	Sat, 12 Aug 2023 17:08:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CD210E09D
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 17:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJDqid6niD2u4luX8nwqFB99xGpLur/6y/t5JWZfx0bgl6FBfLLXwoCThB2P20qpRCpL092vkDpPB6y2QM74Z3wrHbNVrXbwhvlIzZVZzH5w9lFbnwravjTpz3hre6wefM1uJU9au+up7LdjIstbtJn7ZF/JzxAFkudQrH75OfidRx8ox84697phC50ohy+XqQx8Q0MTSikVH2Nee7NLCUDfTtM6jIsLLRNE41C/RfBphG35A4Xit1fdvRKKtUCJreYgDHiOxXMX9baypFcuzYAvdl54kygTJwyuk8pcHjnjutLcXOYdnob/CZgaJN0l+2R3Mx4sKcFuJPYCji/2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGCTXkyTN32E/IZqNHtO2YqDjvUl7sUTkX84WXiolc4=;
 b=EHUafoBvetyGQ1iRIt2+daJKWZ/Alsjd3d/P95Tz8ox8CCzNF5Yqs9pX2ntiF7Po+7/J9TsSHA92+DGBsxnTF++QAr74FHYwVeCB5vNq2sZzvhWtpNyQ4EpEPmSLI1JlFwxBQIM+udqdvd1tVBnbnLMGgCOLW3qyhxK0Ki8gpwFMQzph6jgEfW7vs8Del8UEEAxYgWL5MzW2NSBN9R94vjQDQjiRb0J8cTpbq/DgCevb/YPKiW9DUW2egFGH6PTYlxSzwvMcCxAdLKRe1KY4xSnARfDoqf4xskNTTl5stWI4hY9DZOjAJvPpW4kU1Jkw9vcVts8pLE55AEuD2e/6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGCTXkyTN32E/IZqNHtO2YqDjvUl7sUTkX84WXiolc4=;
 b=ZaW0xSzKzaUf+uHtNkMc5tnxqdi3oc4z+lZ/5JaB2yR+EAF/qHppSGdAd2ZmXYrDPRgxu6c0uaYsGRUJ0MbCmRoPbqVAQdUm/HckAM/EJ+/kxch6YRHXbvE7xAWFYaQchIhsiG5BqeEpXQXhKYUGmlVHv+W/c0ffkf9nx2VrPXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Sat, 12 Aug
 2023 17:08:43 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%4]) with mapi id 15.20.6678.020; Sat, 12 Aug 2023
 17:08:42 +0000
Message-ID: <e5b13541-394a-0672-b865-9e475d2918f5@amd.com>
Date: Sat, 12 Aug 2023 22:38:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/5] Add work pool to reset domain
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230811060234.663789-1-lijo.lazar@amd.com>
 <f01ee061-ba70-ce2b-e52e-79ba273234c2@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <f01ee061-ba70-ce2b-e52e-79ba273234c2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b4ccbc-326a-4a6d-eb9d-08db9b56c7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4ZzU7oxMsPpEYJv3gB/ZoyoVdcUpH2qXC4b3SdTfuwntahP1eRGxY1yUQEEhHoS4YcckTuic4T2OT4lgoV2tYh+Xu2tMyaNvaJ0PNAugJbVC65kfj46G/GPsQMVnzIBp5U1fnlC8GnieAPVULsvU+KcG8uWqCJOLRjdjiqPobQK54AUQqR2Ku3CQ8RWascdSi1s6RV2OGvs/lXzwaJ6Wa/GrAtN/gu0O1DWueWNjI7ZdvWLToNbIJS1rk/9LWfGnreM66WqxPSBPk1nlb5FZjisMonTaYVQnqpFuXvyciaswpU053z3wQ0BNZuyZvkbsUNJiCjbhnqgnKUi9bo5vAu2LcheJb3DnVFPe6ZiyBbZmvFio2XYsy0m6VbBqEq9luLLQjMXY4k8CGYV02wA/fLaFGBVLoBTVv1cbLyILbgvmVUHHmZN28uZ82b7WBZYoegI4i1QZR3B5kmuOc5IKOyQdk2D3qK+OGy1Lyup2QsKkHQjIRJp0U8C99usM0WcvNxPaUpwGi5H0e1uDuu+hFJ38FvH8V7d0FJK+BTNBPxUr5c/K7iGSgNdSu7oxXofm0Lcc1bUjqs991EqBvQcw2sGOLa3gCmvde6StYrLefMRk7dAcmkz0qDGKNP431Ttg43405nhIFbIrsQV9eTT+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(186006)(451199021)(1800799006)(41300700001)(86362001)(4326008)(31686004)(6506007)(66476007)(31696002)(66946007)(66556008)(83380400001)(53546011)(66574015)(38100700002)(26005)(316002)(478600001)(2616005)(36756003)(6666004)(2906002)(6486002)(8676002)(8936002)(6512007)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0xnSFF5TjhnL2RFc2NocDNyc1NEczhOUm82YUJoZTBkWnpIM0hVKzJsaWVU?=
 =?utf-8?B?TzN6YXVCMEpEeU5SWjBJR1pneHJLNGlENmN4T2pMT3RkWElxc2ZoNk8za3c1?=
 =?utf-8?B?R1RWVFJLTlpKYkFlQ1BZbHlOemlEWWEreEFMNGpaSTFOb3VsYzZ4Ym84cHN6?=
 =?utf-8?B?OGZxZjZWdldOLzRhTFdUekRJUGcxTFF4dUdnRURYb2FFY09sWVJOVDNiZlZK?=
 =?utf-8?B?Q1lLazFJL1B2Y0Z5dVA4M1BSK3FMdHUvRlk2clJnYVlINWd1ZC85SXM2dWla?=
 =?utf-8?B?aDMvZDdYTkRZa2dsNy96eGdqOVFqbUN5enFpaW9nQVdGRnhtc3h4OWtleWVz?=
 =?utf-8?B?NVVSRXVPUWM5NnVuSnYvZ2ZYY1lPMjQwSCtoUTJCNkpaNkdSWUwrcndueHAy?=
 =?utf-8?B?QTZwaHluNytCNUJaQnpvRDhuakNQT200aXVDK0NHR3dPWTJwU3A2QTRCemtk?=
 =?utf-8?B?Rk1tWGpVTitGcm5rQUhvcHlGRWszb3orWklzckFCYjRuUTJ3RnR2MGNjSm5i?=
 =?utf-8?B?NW5abDEyMWhIRlZOTDE1ZWVCU3F4NFFtYlc3NXM1TEl6L3loeG53dnBLQ3Vk?=
 =?utf-8?B?ZnRxVG9QRnhFbGpvUW1DV2dnMVNOUWZNb3FUQVI3ajdsbkFEa1hlSTNHVGJR?=
 =?utf-8?B?WHJTL2pLeGZhcVlDdmRodHdCM2hRMTdzSGZnOHdiakhzSEwrUzMxeWxJMXFE?=
 =?utf-8?B?Y1ZYU1VPWElxVHQ5MnhDc2E1UlA1VTF1Y1BnbEMxV3FPUUFISXIyWGs1YlEy?=
 =?utf-8?B?SE9tYlRJVHY5NUtWZWdwNWRJeDBPaDBtNnFBT2U3dWpEbW04YVlmZnIzRjI4?=
 =?utf-8?B?cEt0dnFHZTdoL1pia25WT3FOTFRXcmVIbmRVamZEd095Q0JrOFc2SnhMSUE0?=
 =?utf-8?B?MVdkUGttbnpxMU5nWWVuMjJJODl1RFRCUkU1Q2hTVGN6cWtpMzgwNVJvZGZN?=
 =?utf-8?B?SzFjYU43VkNqV0dpT0pXOSt4TzdrU2s0QXpkSEpQMk5YTEIvWm1QTElpU0Z4?=
 =?utf-8?B?M3BYMWxPZFdyNFVUeEpqUE4rN1VMRXNvdjlRV3FtTXFObGlyY0NRVzJ5RStp?=
 =?utf-8?B?RnNGeFRiNTkveUVrK0R2dGxxVmFrNmVFV3J5L2hmYzZtMUF4TmthekIrQmZQ?=
 =?utf-8?B?SEEwSVdsbjFXSjlNdThWK2ZWUldVcHVhSlBwUk9lMnBzeEE2VURGNE9RK01G?=
 =?utf-8?B?MkxTbVVxQ3BkMXVKdGNoUVU2NTJZZ3ZGRW0vdEp1anFVSUZ5S3ZwWnEvM0JM?=
 =?utf-8?B?c3cyTUQ0Q0FGTFl2a0xFMXZUdlRHN1JEM3hSelI5Q29VendSTVdvVWNZWkpu?=
 =?utf-8?B?SFlBdXRwcmljNVNoWVdOdFJ1NUcrU284UDR1bkZXd3NhNndITFh2OGFwbkV2?=
 =?utf-8?B?RHdtcmg0bUlCcStiWGN3ZVBsZDFZZ0dHaitVQnViNVJQY0ZpR0lCTVBqVEVh?=
 =?utf-8?B?NW4zOW5mOXU1cWRoM1I1bm53SHBiMGZzZjQ1S1diU3loU0hRNDJwcGR5WTFX?=
 =?utf-8?B?S3JTVnhTU2phNVhwTFBSSVhVb3hIckFqOHE2VFVYb2piU0hxWHF2YVdXME5P?=
 =?utf-8?B?Z3JTbWpZTmRIYnFwRDk1Ykg5eDMzbXlCVGtCazBld1Q1YTVTR3czTE9oSEZ4?=
 =?utf-8?B?Tm5vSGhHd012WjNBUXRTTFZjVXVPS2kvL2J0SDE4Q2thK2NIZ29UeDcvWnVT?=
 =?utf-8?B?OFVERzJsOXJIeEVnRXpaR1B1MTBaa3NoSzF1UDhTa3RsekhITnQvMm9nNy9u?=
 =?utf-8?B?YlAvTXgxNVRzNjBKRndCZno4NjRrTjBTaVRmWE5HZ3dwcjNqTGVkT3d0emUv?=
 =?utf-8?B?WnNpNllicGs1VlU5aG5jZVhpenh3dUUzYkVJRDFwcWhIS3lqUkhXQnROT1NP?=
 =?utf-8?B?US9tMW11REpzTjVTWXhvVVZkSjJXNEI5RDVkYkJrTUR6QTU2QWdGdjRzUnA3?=
 =?utf-8?B?T3owb2pHdllTazlMa3QzYjVzNFNyWFhNUThFWDVZcWtmc2hGYmQwakZZTmg0?=
 =?utf-8?B?K3ZueER0S3hyYk51Ky9hdkdhb01seGl1WVl3Z3NKZ0VlYzJhWm43UXBoSFM3?=
 =?utf-8?B?d3JZUThacERFWjBZdEtiZ2FhelE0dThwWkRTVlpEY1NjbjRONXNOUWcxSWdU?=
 =?utf-8?Q?TxCXPw6UeLudw4g+Lnl2nonOa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b4ccbc-326a-4a6d-eb9d-08db9b56c7d5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 17:08:42.8518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfm8x1xmZxJHYLBG5OGap90TWQNrKwFKu6/3Tcr37JMg2tF6E3nsZ6COdXHiBnM+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/12/2023 1:53 PM, Christian König wrote:
> Am 11.08.23 um 08:02 schrieb Lijo Lazar:
>> Presently, there are multiple clients of reset like RAS, job timeout, 
>> KFD hang
>> detection and debug method. Instead of each client maintaining a work 
>> item,
>> reset work pool is moved to reset domain. When a client makes a 
>> recovery request,
>> a work item is allocated by the reset domain and queued for execution. 
>> For the
>> case of job timeout, each ring has its own TDR queue to which tdr work is
>> scheduled. From there, it's further queued to a reset domain based on 
>> the device
>> configuration.
>>
>> This allows flexibility to have multiple reset domains. For example, when
>> there are partitions, each partition can maintain its own reset domain 
>> and a job
>> timeout on one partition doesn't affect jobs on the other partition 
>> (when the
>> jobs don't have any interdependency). The reset logic will select the
>> appropriate reset domain based on the current device configuration.
> 
> Well completely NAK to that design.
> 
> We intentionally added the workqueue to serialize *all* reset work and I 
> absolutely don't see any reason to change that.
> 

This is for the case where there are multiple spatial partitions and a 
reset is possible by hardware design on one partition without affecting 
other partitions on the same device. The partition scenario can be 
considered equivalent to a multi-gpu case (not interconnected through 
XGMI) where each gpu gets its own reset domain and can be reset 
independently.

BTW, this design doesn't restrict from keeping only one reset domain as 
in the case of legacy ASICs like Aldebaran. The reset work is always 
serialized within a domain. This allows to have multiple reset domains 
or you could also fall back to reset_domain1 -> reset_domain2 for 
hierarchical resets, if required (though that is not planned now).

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Lijo Lazar (5):
>>    drm/amdgpu: Add work pool to reset domain
>>    drm/amdgpu: Move to reset_schedule_work
>>    drm/amdgpu: Set flags to cancel all pending resets
>>    drm/amdgpu: Add API to queue and do reset work
>>    drm/amdgpu: Add TDR queue for ring
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  32 +++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |   1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  24 +---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  40 +++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  16 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  71 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 122 ++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  32 +++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |   5 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |   1 -
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  38 +++----
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  44 ++++----
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  33 +++---
>>   15 files changed, 285 insertions(+), 177 deletions(-)
>>
> 
