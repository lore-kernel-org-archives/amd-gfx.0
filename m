Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D584CA5FC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 14:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E23910F464;
	Wed, 30 Sep 2026 14:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NRsD4ubY";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F045210F464
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 14:59:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJICzWnUnYumZGGD6zw/EDXDBhh+lOh2DPaGDGxVcN4M08iOG2JOAB4Hrfsnl37NH9/z1qmVbIl3ibfLfetO1GCAnxgH7NlflN0gAPDyRNWEH3QQSfDkAVZE9cRXos3fk56X9VIKDYP6uV89RscsVj3qGXUxCE0CoU8GbfjtO6KBYV7k5MJQndmZTH74RfKGoCSP5biVB4VmakeqWWaBFs1YFSxIJVv8BM0Whx/BbevwbCqjOdovhg8ikQFHYlcqHNqo8l9+6q8IhLd0YQlpxXlqefIMm3jwp2lLLD3L6FwhNsl+umzn7cs9n/TsOLTZX4kse6jhpPIH8BVXtZHvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rbl4al63T0J6R8aQXnSBSZixN8fu9sC5cp/uobZSqA=;
 b=Hk9Br5qnDhbRmEbfOrGrXg0XFoGxh79AFMGVcNuHVRMKyvRiWwNvI2JK3SZ02LwLNVAwHuXe9wtKIEhjSsWfmMIVaN7dJbTUctT7NNIpq4sIFLq4aeaQfl+A47BVhwp82Qh4neQG3VYaugZCpGMOmuH0F2GO1U81a/blBHXzdU2UpJPheP7VK/2cgQfUv5Lh6QZGCWtlD4MG9n79T1donMbi3pBIAUKgA4PZqrceZFfL+SXy/0ZWVzIqOgFB8aDDNs4fVvQi2zqvMEtv9ppAW26hw8fbbes499FVW+DJADSDTWCCAuCJnkP+FBz1kfZmG/YeHCLrfyu+l8eVeRqd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rbl4al63T0J6R8aQXnSBSZixN8fu9sC5cp/uobZSqA=;
 b=NRsD4ubYBvlvp5f/KOvrESfJW3gfO+cVeEZb4pHSI+mjoRvfcrqT46dB76sUb32WeehyZfoB1PFh8vAe+89kbpyO0RpZU7Hu7dBllym8axpmUJihUJo6xZ7XQbmYIFRA1HSMGyNp7VGAUT+1AHevCVWRjNJHKQLrDFy9OHnVwHc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 14:59:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 14:59:53 +0000
Message-ID: <9b181f91-4de1-4c0d-8a38-dfd75c8eb98c@amd.com>
Date: Wed, 30 Sep 2026 16:59:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: fix cleared PDE/PTE flag generation
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Philip.Yang@amd.com, cascardo@igalia.com, tvrtko.ursulin@igalia.com,
 "Joshi, Mukul" <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-2-christian.koenig@amd.com>
 <P3WG6T-ATwauPO6Yp0bWtQ@gmail.com>
 <cd5af67b-d2af-43a5-be86-216155f46ff8@amd.com>
 <7b1ec2f8-0619-4132-ac35-bc2722755b97@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7b1ec2f8-0619-4132-ac35-bc2722755b97@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d5e6cb-a6b8-4e9a-a036-08df1f037b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|921020|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0i7XQyK2UWvy0tzbPYGQPjlz+hq0rL4oJEDCCc5Q/VoHpeGid2IHFRyW/gQlP4tbXNZklirjUfFUYhbbleSa2enCEbpde7UrJHHODBrN2cyjYYJWDPQtedygVL4qRVbROEpOnsemwrk4fhioXFD5tnyceow+BFNIpj6yLvasr4vxe1hZhR7rIdbrImCyGYzwHIrdREv5JbulyhCFvOTtFDJer3lBD9fjHtWLRRa+oVgzXoIouBh0INDFHoqlcI/u9F0Y5Q1yKk/ensxieLkVSslQiHF8iyEg1REg0UPRxRYgstVWUTWU04inY7Zks1GLZrE6X4yWkjP/SftTVwVwc8aC2ptPCXx1lZW/y907RHjaYTQZhQvWc7lDv6/gU0VJNZf0LQRKc5dtTWYrPfdJgwTaxBps4riDS2m9f1gMwQei23g0leiU5OKx8ZDJMVyN/Y+a+VoT0E9210HR3lS1B635s2xYHIO9zhyUuYALzNJ16rJyop47hHdbA/qcXSjpXWt4R8rVPzAdPPFFQwlTY2cGILaAVP0Br0Hx1vHFaewsQA2iTiYDxyCplkbWn3q5Tfi0o6zWya5jh6KBXZjQWxAbZ57ypMpCmqzxeduSemIc6MVfSE7IorSD7C+4O2xCnqHyGa5N5DU6RgdCorpSUMpJwh6z305mT2OuxTiG3VthZJ7c2GNHeUFTQKyy9HBxx2YeUhfSrWYqo6OP/VFcOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(921020)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxnVkRIbDg5Qm8vNWJFWDg2V1JBTWZSbU8zdXJKbzF1ZDhLc2o1U2dkclhE?=
 =?utf-8?B?MmZvbUZLbTN1SlNZWVpZZTM0UDJQZzBYYnBtZ2hQSnpxZnlWZTlWSy9WTUxJ?=
 =?utf-8?B?eTBFMUpDVVZLQWRVc3NVUUMwdll5MU5Na2g5SFFKRnByT2Jua3h6V2s3QTJB?=
 =?utf-8?B?UVUrU09DQWZNTGJycjhHTVFNU1VETXRycmxhZFF4S0MvVnRoS2cvMGlwZWcv?=
 =?utf-8?B?cTRCQ0g3cTU0ZHNKNkJNblF3aFpTZU9TMjlzc0VtdUhqS0ZOL001eUZQeEx3?=
 =?utf-8?B?NXJmbjhBVnBiS2syQWFndEF2N1RFbFNGbTBHRnZCWUtoVnlEbGNyMExISEFv?=
 =?utf-8?B?c3hudUdqdEVWaXFaMmpHOFdlUU5HMStQbmlOdURjZG9aZlhXcWppVEpaeEt1?=
 =?utf-8?B?aUdla0V0ay9YRWVvNlA3Z1FIa3dqdEJ1OHdmejdPZmxTSzRweC9rM0xRM0hQ?=
 =?utf-8?B?UzEzSC9aOFF3MlZ4MmlaZk9GQ1hrOXNBM0I5RXdTODJ3TzQ1dnJRZ2lFdmJP?=
 =?utf-8?B?T2tBMVprM25SWVk0SkNUaTlCM3hvREVtcFMydWNHRDU3T3JzUlFkaWV2VDBS?=
 =?utf-8?B?dENxR3lubGJ1eXJrSzdMcTZQRDdmT08vQy9EOW9HR0NmM0FhWlZyV2loT1R4?=
 =?utf-8?B?Qmd5czNWZjBBYXF2MVdYcDdPSVhJZzhycTA0QXpDaUNCVUxIRUNjWXNITVQy?=
 =?utf-8?B?ZTk5Z0M0SVpzem4xTHpNWng2QmU0aUIrcXl4V0pwOFo2VDhHa2R5UitIY01x?=
 =?utf-8?B?cSsxd0F4YlJPTTdnSU9EYVlpdEVKZXcweE5jOGtZMkV5TzNTc2UzSlF2djFu?=
 =?utf-8?B?UHVNUHlpWUEyb3BDY2h5Umh1MjhtZHBSb0pjNCt0bDRoaVB4VFROd2Y0eVNX?=
 =?utf-8?B?dFBJYWhXZ3RENXBHSkU3MVpQSC9HZURHTll2dzJQazFlNysvMUcvNm5RaFRr?=
 =?utf-8?B?RW85cHFYeDgrYzA0M0hyWWpFYk5odDZSb0tCSUM3ejFxY1dUNEJSUWhOU09M?=
 =?utf-8?B?WVZmYnZSbS9IOTR3TlVGTC9TREtiVFkwUk5zbkZCOFZoQWlrc0dZUEtkMG5i?=
 =?utf-8?B?d0crNkFtVjZUQTA5dzg3VG1vWmlXTG1GcEhiaVU1aXFoOVBoRFliWVZUWXZQ?=
 =?utf-8?B?Wnc5V2N0N0FIVFZhL1NPb3RwS0owOUdEbWNtc2Yvek11V3hBSjBVcFZRTEkr?=
 =?utf-8?B?OUluejRtRDVtYUVqUnVLZzV5enZLOXdZSjJ2OUJDdVVRUkFYMFgvY1AyLzlw?=
 =?utf-8?B?b0sybHNReGFGYklpc3VyL0t5aGhGN3Y0ek1lV1lsWnVBdCthZ2FuemhGK1V5?=
 =?utf-8?B?TXMxWEREWVdmNnB4U0NIN0oyTVl1ZkJ1bUprOUV3b21rMWxteXR3dytZUTVB?=
 =?utf-8?B?ZS9VYnkrNmcrYjBhV3BWdEVDMnhoUEZVcHFhWEtWVG1MaFV4MGRyZkgyeWo5?=
 =?utf-8?B?dlZPTHh4R044RmsrSENZcXBtdmQ1L2xRNzlJYnFFTk4rNVVPMVQ2b041djA4?=
 =?utf-8?B?NFRRTVV3RDc3TzlYU1dnRXBxbG9XMGZMS2pWMUl4QU9XM2cwRDMzVDBaR1do?=
 =?utf-8?B?Mjh2MXdxRmhRZXc4V0xBTk1Oc2kxd00vbjN4QUZ0anJ5aUhmbjVMdWRIWFFU?=
 =?utf-8?B?cGlBL1VIbURIT1N2RlR0UjRnNVhkY0RNNDJiSk1sZlhxOEJpU3dZU2ZPVUhi?=
 =?utf-8?B?cU1uTTRSQ2xBN2tvUlRZVjR5QzBNVGlkZFJsdVFaMjlFOUxqV3dyMXY3MS90?=
 =?utf-8?B?RmRSa2pEbkJZVHV1OXJldHpmMXhkYzJ4SXBIOXRieGM2bUFYT3d4MlUvMFdE?=
 =?utf-8?B?Zy9EV0lsM2ZVZ01SL29LaDNGc3JWeDgrTE11dERhN0VLSy9FdW14MFNiLzdl?=
 =?utf-8?B?ejE0WWxFWXFRZ2tzVXRJUGdDV0NnUUVGcXpoTU9KUXk4UUMvZU03TkNGRStZ?=
 =?utf-8?B?YkRCRTd6ZW1VbWZwQnI3bWo3eXVGTFJvTjY2T2p2c2llOU1uVkJ6eEVrSnps?=
 =?utf-8?B?MDkwWktUMmdBYTZMMyt6YndqMjlCd0htR1hnNzlsTUtqMkZpbCs0SkpCMk5i?=
 =?utf-8?B?RHhzRnhkNUFWdmV4WWM3T24zUEpyRHZBUTZRQ2VzSERnQmQ5aFp0SzYwMW1H?=
 =?utf-8?B?b3IxQXdpZ28waXBtNHlmTFNrUGgzUVM0RnpuSnZvejlhV0hNQVljTEk5WlF3?=
 =?utf-8?B?T1FPOVBFZWhocFlOdHlIak9HQ2dSYk5EeElINUo0ZFJRdzZZL1lmaFczcDVL?=
 =?utf-8?B?Rkc4dlVPRzNCOTZDT3RIVWlNVjFrZU1Fd2Z1Rm1qeUw1YVQyRjNNS2ZXOTh1?=
 =?utf-8?Q?daSZETs6/Ra5xOVR5i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d5e6cb-a6b8-4e9a-a036-08df1f037b9b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:59:53.1055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTNJ208zVcKdKA36qZ2+/sFGFqbajFYv/OBl2iTHh6GbxXFUVxJ5Jkc4iIq/vEmY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
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

On 9/30/26 16:44, Kuehling, Felix wrote:
> [+Mukul]
> 
> On 2026-09-30 05:02, Christian König wrote:
>> @Felix and @Philip any objections to this patch?
>>
>> It is actually a bug fix for the NPA support.
> 
> As I understand it, this fixes the flags used when unmapping memory from the NPA VM. We passed adev->gmc.noretry_flags from amdgpu_ualink_unmap_npa_addr to amdgpu_vm_update_range explicitly in the flags parameter. I guess that's no longer needed with your fix. But I think the end result would be the same, right?

Not quite, passing adev->gmc.noretry_flags to amdgpu_vm_update_range() is completely broken as well and also need fixing.

The flags parameter to amdgpu_vm_update_range() can't contain the AMDGPU_PTE_TF nor the AMDGPU_PDE_PTE flag because those are overwritten by the PTE callbacks.

That's why setting the AMDGPU_PTE_IS_PTE for gfx12 through the init_pte_flags is completely broken as well.

We seriously need to stop doing such hacks.

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>
>> Regards,
>> Christian.
>>
>> On 9/28/26 21:08, Timur Kristóf wrote:
>>> On 2026. szeptember 28., hétfő 11:10:34 keleti államokbeli nyári idő Christian
>>> König wrote:
>>>> That was broken since adding the NPA support.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 64 ++++++++++++-----------
>>>>   1 file changed, 33 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
>>>> c03327f1242d3..e8f441e018839 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>> @@ -346,6 +346,33 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device
>>>> *adev, amdgpu_vm_pt_continue_dfs((start), (entry));           
>>> \
>>>>            (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev),
>>> &(cursor)))
>>>> +/* Return the flags used for cleared PDEs/PTES */
>>>> +static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
>>>> +                    struct amdgpu_vm *vm,
>>>> +                    unsigned int level)
>>>> +{
>>>> +    uint64_t flags;
>>>> +
>>>> +    if (adev->asic_type < CHIP_VEGA10)
>>>> +        return 0;
>>>> +
>>>> +    if (level != AMDGPU_VM_PTB) {
>>>> +        uint64_t value = 0;
>>>> +
>>>> +        flags = AMDGPU_PDE_PTE_FLAG(adev);
>>>> +        if (vm->is_npa)
>>>> +            flags |= adev->gmc.noretry_flags;
>>>> +        amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
>>>> +    } else if (vm->is_npa) {
>>>> +        flags = adev->gmc.noretry_flags;
>>>> +    } else {
>>>> +        /* Workaround for fault priority problem on GMC9 */
>>>> +        flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
>>>> +    }
>>>> +
>>>> +    return flags;
>>>> +}
>>>> +
>>>>   /**
>>>>    * amdgpu_vm_pt_clear - initially clear the PDs/PTs
>>>>    *
>>>> @@ -366,10 +393,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
>>>> struct amdgpu_vm *vm, struct ttm_operation_ctx ctx = { true, false };
>>>>       struct amdgpu_vm_update_params params;
>>>>       struct amdgpu_bo *ancestor = &vmbo->bo;
>>>> -    unsigned int entries;
>>>>       struct amdgpu_bo *bo = &vmbo->bo;
>>>> -    uint64_t value = 0, flags = 0;
>>>> -    uint64_t addr;
>>>> +    unsigned int entries;
>>>> +    uint64_t flags;
>>>>       int r, idx;
>>>>
>>>>       /* Figure out our place in the hierarchy */
>>>> @@ -404,26 +430,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
>>>> struct amdgpu_vm *vm, if (r)
>>>>           goto exit;
>>>>
>>>> -    addr = 0;
>>>> -
>>>> -    if (adev->asic_type >= CHIP_VEGA10) {
>>>> -        if (level != AMDGPU_VM_PTB) {
>>>> -            if (vm->is_npa)
>>>> -                flags = adev->gmc.noretry_flags;
>>>> -            /* Handle leaf PDEs as PTEs */
>>>> -            flags |= AMDGPU_PDE_PTE_FLAG(adev);
>>>> -            amdgpu_gmc_get_vm_pde(adev, level,
>>>> -                          &value, &flags);
>>>> -        } else if (vm->is_npa) {
>>>> -            flags = adev->gmc.noretry_flags;
>>>> -        } else {
>>>> -            /* Workaround for fault priority problem on
>>> GMC9 */
>>>> -            flags = AMDGPU_PTE_EXECUTABLE | adev-
>>>> gmc.init_pte_flags;
>>>> -        }
>>>> -    }
>>>> -
>>>> -    r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
>>>> -                     value, flags);
>>>> +    flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
>>>> +    r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0,
>>> flags);
>>>>       if (r)
>>>>           goto exit;
>>>>
>>>> @@ -712,15 +720,9 @@ static void amdgpu_vm_pte_update_flags(struct
>>>> amdgpu_vm_update_params *params, flags |=
>>>> AMDGPU_PDE_PTE_FLAG(params->adev);
>>>>           amdgpu_gmc_get_vm_pde(adev, level, &addr, &flags);
>>>>
>>>> -    } else if (adev->asic_type >= CHIP_VEGA10 &&
>>>> -           !(flags & AMDGPU_PTE_VALID) &&
>>>> +    } else if (!(flags & AMDGPU_PTE_VALID) &&
>>>>              !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
>>>> -
>>>> -        /* Workaround for fault priority problem on GMC9 and
>>> GFX12,
>>>> -         * EXECUTABLE for GMC9 fault priority and init_pte_flags
>>>> -         * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
>>>> -         */
>>>> -        flags |= AMDGPU_PTE_EXECUTABLE | adev-
>>>> gmc.init_pte_flags;
>>>> +        flags |= amdgpu_vm_pt_clear_flags(adev, params->vm,
>>> level);
>>>>       }
>>>>
>>>>       /*
>>>
>>>
>>>

