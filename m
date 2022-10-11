Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC63C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 00:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3F610E768;
	Tue, 11 Oct 2022 00:45:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA01810E769
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 00:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTc3z4x4jSyr1IqecImweTuverQkFatJCUusQtx7iOQzvQsfC3lg+5lsR59K96uSwDxZ6iEkUoMMbg1VAaVj/WwWK+1LI/1IJmzQxP9V5ywiPfUZ7Iv7whwoGe588bAT2ZVlfJZVYxtMT0aE3Pf/XA8L22nH/JLJO4nK0JTXGGdomUtEiJpGKOOXvwx5VjhelnKQUuxGybyAPtEWlguikDa8OMqQLN9PVs+8VwQPxTKIipufEiaYpsxbwGwTD1A0dl2eL8oht2LLzn2OC6GpICllLOAH6ZtWf4H1yZyxcWRvWel058gRsNng5CsoIjgDIt4NvATko1OsqSO00CfTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2KuIuPkbIIWrTVsnQMZOBuc1YgWZY1cUgwoTAVwtjs=;
 b=QlXR/70xxWP19L5GgdATmPPa67LASHJI93p2UvFYTkJydTfkl0EhHz2xO81ZIzpmRjTtr0t2uoQ5ci3Pqrn0McMaVHn4sIl1MfF4OBahhUd9gHEm1BpqA5XMOWvv5TpxFs3co775IqDVZBfEzWz807EEOoUYtyfjkltBj+lm4gipGKVKtYQuzPwV8odAyoyyENvR9+V71OPRyJ1sGXzK2HcK54Za4DovfuR7g5TrPd1qkGgiHZzKRLt0I5YvyUxuzZNDDb06ifTG9RT+d+RK73SfEYQM2ub7gbsUqzQhwDad3h3V3j2BMaZs7GMp2t/Dzh8gwUWMQ1G0Kw/CMrXFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2KuIuPkbIIWrTVsnQMZOBuc1YgWZY1cUgwoTAVwtjs=;
 b=W7MP0okoYnm8YPrSGz+YEj9BHWgasbNJKiEyFeKuayTI0aTaNtK4mul5mfiIUj7El8gNZoE9C8IMMG2eIEkzBgjryKXx832Onkos/igaALPBbT7EI9vfRWgO3pAoRItXcQ4ch/TUVxbvKD++zMrtx3FW4YeRCR636qCrMznlCsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 00:45:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f9a4:8620:8238:20e8]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f9a4:8620:8238:20e8%4]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 00:45:00 +0000
Message-ID: <93121784-9422-b740-1ab6-474271d2ad71@amd.com>
Date: Mon, 10 Oct 2022 20:44:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] drm/amdgpu: set vm_update_mode=0 as default for Sienna
 Cichlid in SRIOV case
Content-Language: en-US
To: "Slivka, Danijel" <Danijel.Slivka@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221005110325.31871-1-danijel.slivka@amd.com>
 <97a4e0df-bd79-8c1d-c3b1-af88850e8d3e@amd.com>
 <BYAPR12MB309451B6B5540D317691C7C798209@BYAPR12MB3094.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <BYAPR12MB309451B6B5540D317691C7C798209@BYAPR12MB3094.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: ff19c20c-dd1b-4b8f-5eae-08daab21d400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDlZPmkeAzoHkowo86yejtF9+4aItfKKIY6ixshI0gH48TWFmuatvV4RKfZrhtVyFTUXaS+/YQxSgno1w670uHwsFbd/xutl1QNDF2TfWbxeFZCadlIXMZhZR2xNIEioh4Foqt+kpOEaM5mJTXXzAmlXZjp6XtdVEc2kEmGjtJe0BXdWAMvIdanpNhWSpnPOo9/EvW+4RYi/PSKYy7If28srowYTe2nhBk1RIGdmjL454V8Lwb/S+s4Poi0hX+M4S8bKyTeiKj+Kf9SGBOWjhFLDHXffz7+FPmTnpZi4QyovruH+Ohmd58KtrMnGnpj1dgScQ3BTrHEbkiMse8ObRqraUk4J7nswr6U7CV6VJ6QW6jr9cX0YUDzxQRlz8xPcrEB0jkdWtQFYT7beZ1PFce56+z+uz9e1MUejHH3IKOQAXTuL7D9ktaUKQ+Tt89+OqrGGn6vW5+8uIlDc7cZSTxSceDAHe7B4pH1cYuz+IC0wrGGYOjfIit6dHvFZNurjIa2C29wQUImu+15HCODKt15H93MqXnB7wsjKt4AsRnzBe2JsuoAvz3P3+3hBMQ7OGrazxHRklaLLE8M+xDb2uD93W8J9zANvH10ans9u3NVKy4vTfNrE6j/og0uaZP4ccCHcKKuKAkQphMjv1qVbQ3Ldl+EkxQJ6pPBtYl3KcK3blyjtJFrSstSOKhKVzoks2aTb5wbYvp3pFx3DnOaqBRuAOzDNFAlt50Dc29wcR75GS69jK4dU+FN07mWq2PUOD0xaBU1LRn6XR7r506gzjTJIctx6AirI2VrqijzQBDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(26005)(66476007)(8936002)(2616005)(6506007)(53546011)(6512007)(186003)(83380400001)(4001150100001)(2906002)(44832011)(5660300002)(41300700001)(478600001)(6486002)(316002)(8676002)(66556008)(66946007)(110136005)(38100700002)(31686004)(31696002)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0swMHhUZWZ6V2N4dnZmRlNURTJpNXBDSm5MSFN1OXJJdU1JSjEyT3hmaFR5?=
 =?utf-8?B?RkVaSHZkNHk4WmpkSzl6MEFmaHZPVzdtQ3lJaVZKNE1PR21vcExRR0FSMmI1?=
 =?utf-8?B?T3F3aS9oMmhleHBMdlI2aXlzTCsyeXpHc0Z2dzQ4d2ZxU0E4c3grMTl3dWli?=
 =?utf-8?B?RGJ4bXVmNXU1cDIzdkRnMENHT20wR3lycUFDUFB1K1FRMXRQTHUwM2dVbWtn?=
 =?utf-8?B?V2d1QjlwV2tBWDUySlJzeHpRWUJTUWEzaDNHOTlsb1VVSFg4SFY4aktuVUIr?=
 =?utf-8?B?dDVucnF0WVU2ME5PRk5mQTY2QmJZOG5XZUVTUHhhYzJnUHJwNTErcG9rV29q?=
 =?utf-8?B?Qkd5UVpTYTB1WXhscUdEVGM5d2ZQaUtvdGY5S2h2ZW5qeENlZkRORmJPWE42?=
 =?utf-8?B?aEVYcGdORWZDTHdTRjRROXNLbE1ZTXN6bjM2K041L3RRdzRiQ2ZsNkQzVWtF?=
 =?utf-8?B?c0NhSjRvb0dTaVlUSVd2RmFNWVJneE9rK2grTElGVHVTMzZPNU1KR0NzZVdY?=
 =?utf-8?B?WCtiQVFiT0JUbkg0N2J2dWZqMXVGMVY0NTJqTU1OZjlWZUpoVCtQZXF1eGs4?=
 =?utf-8?B?UkxyQXBpUmtCaUJzTGVDcWY3eUlLU2hlYUF1WllodUx2UW00Y0hiSlZ3OVRH?=
 =?utf-8?B?bitON2s2dXQxN05INEZPamc3M2dNbTlnWnVCT05PSktUUXZJRFVIOTI3Y29K?=
 =?utf-8?B?bHdobFVqZ2duNGVROFFXZE1kd0pwc3hEMDhSQ2VyUkZpVHI5VjFLeEtmZVU2?=
 =?utf-8?B?WW9yeTZwaFZPdjJEYVRaNENVNkNhWDJUWmJTY1k3OXQ5dFhaR2t6MTNiMy9w?=
 =?utf-8?B?R2hGbit5R3FwQVJkcGM1WWJUQmhkQWpucldNVjFTUUZDZDBHRS9qWkROTlQ4?=
 =?utf-8?B?R21lYTVLeGVoQW9KOGdRSzMwdGYwTm9YR2ZPb2swTXY1VGZjOGhVZzF4YXBE?=
 =?utf-8?B?ckFsWWNUTmlNYUcxTUNLby9pVElMYS9xbE91NzRaTjVxZHd3dkIwWFRETVJK?=
 =?utf-8?B?UXJEMXpzSDhPVnUxRTFmOFV6bHFOc1NEN050OEFGRi9uVTV2ZW9zVVB1U3R1?=
 =?utf-8?B?NnZKcFZlbkx4cmFuUEdaNkRYZU8xT2RPd3R1SHhNZ3hyd3N2Wm44M3BOWmd3?=
 =?utf-8?B?Y1p6eXIySGNUOW1lMlNuMGFieUR3ZGtza20vYjV1YlpHS0VOUlV6RERvcTcy?=
 =?utf-8?B?YjNhRCtIOEpFaTdIZ0tuSTM2ZEg1NDFWd3hiazcxQ0pPaHZIOWQyaXpPRC9o?=
 =?utf-8?B?MGpudEQ5TjhYNWpIamZjOER6NVpZRUt4OEc1Z1Y4VXBwL3hTQnpmVDF5dDZ6?=
 =?utf-8?B?OTAyZVdTbERZZUtENmZ5YzVhcVYzVFFxRUJUQytyaXZXWmtJUnpiemFnVkp3?=
 =?utf-8?B?SUl5dmdQR0ZZNU9YSUowQzl0RzBOem9QaVdqUjhNRC9uYkpCaEtORTlGeVh1?=
 =?utf-8?B?a2Nrb3o1NTJ4NWErN3FWVEh3L2FWQTBQdnZaY0k4aVNmbkJTVThrVnFKZHEy?=
 =?utf-8?B?d0pnWVNIelNBeUhsdnczWGVYT1hNWWVtNHpZbDZTN3NXT0pqeUpFc1FUMWJD?=
 =?utf-8?B?WDAwcEZzdUlvdHV1Z1pPSE54L0I2YnJ0S0Z2YW8wb1I5cVUwTVJZQ0NDaXRa?=
 =?utf-8?B?eFZJRTd1c2M5Y0hicEVnY2pEdHc1a0FQLy9pczZIRDlndmRzU2xQV3JHeGJo?=
 =?utf-8?B?UTVSVTJsVWFnZUxpZ0pMbE1MVXNQSjBkRGNleld6dkRlQnFUNitLOUlzdGxO?=
 =?utf-8?B?SkJMMzF6ZWRieWhaa2Y5ZHMvVEVUYnZSRE1jYzBpUGdJWmlHeEpVWXNlM2Fm?=
 =?utf-8?B?T0VuWHkzUVdtNUFXTzBLUnltYXB3aHlOdjhVSm1KOUlYK01wYlkvb3FkcGlD?=
 =?utf-8?B?dWpDcVV2T0pSN0k1blZaVG5MNFZTK2k4S1BjNDZ6dVI4cVU4blc0UmdqbFRz?=
 =?utf-8?B?b2JHSXVNRE02dmxlQmk0VU9hbHduamlleGJDOEJoN2RQenBQMXJpMlJ5Rk9S?=
 =?utf-8?B?MjJGd2tYS1p2Mk9icEY1UUhYNHZ3cE1XN1RQaTJuejErWTFrWEdzemp0c1lQ?=
 =?utf-8?B?YVNCSE1oNVcxT05iWWNrWmRWbDNQRG5pRzdibE5wU210UThVM2lYeURqVWJl?=
 =?utf-8?Q?7uQ7ZB4d/Uyp1B9H8yAH3YsSc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff19c20c-dd1b-4b8f-5eae-08daab21d400
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 00:45:00.6192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bP5jBFy1ROcEzE1FaezVamRYAzs1mDE5DmzmORzqbRKQ2GDvKn2XAr9ELu2kC1qdKkzulLzA8lIzDTyio3d/IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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

Am 2022-10-10 um 05:01 schrieb Slivka, Danijel:
> [AMD Official Use Only - General]
>
> Thank you for the input.
>
> Regarding function amdgpu_virt_mmio_blocked, this is not returning correct results as it is checking if read operation is successful,
> which for VF MMIO access protection is always allowed.
>
> Regarding other suggestion to set this in some capability flag,  this flag should be set after VF MMIO access protection is enabled,
> after driver is amdgpu driver is loaded,  thus it would require reinitialization of vm instances, to set vm_update function to sdma instead of cpu.

I think the initialization sequence would only be relevant if you want 
to implement a runtime test for MMIO access. It doesn't matter if the 
flag is set by the driver itself based on prior knowledge about the HW 
and IFWI. The flag just says "this GPU doesn't allow MMIO access after 
initialization". My point is really, that this prior knowledge needs to 
be in HW or IP-version-specific code to make it maintainable and easily 
extensible for future HW. We should not have such HW-specific knowledge 
in the generic amdgpu_vm code.

That said, VMs only get created when user mode processes open the 
/dev/dri/* device file. This is after the initialization is complete. I 
don't think you'd ever be in a situation where you need to fix up a VM 
that was created during driver initialization.

Regards,
   Felix


>
> Would it be better to keep this fix in amdgpu_vm_manager_init() when initially setting the sm_update_mode?
>
> BR,
> Danijel
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Wednesday, October 5, 2022 6:43 PM
> To: amd-gfx@lists.freedesktop.org; Slivka, Danijel <Danijel.Slivka@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: set vm_update_mode=0 as default for Sienna Cichlid in SRIOV case
>
> Am 2022-10-05 um 07:03 schrieb Danijel Slivka:
>> CPU pagetable updates have issues with HDP flush as VF MMIO access
>> protection is not allowing write during sriov runtime to
>> mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL
>>
>> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 83b0c5d86e48..32088ac0666c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2338,7 +2338,9 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>>         */
>>    #ifdef CONFIG_X86_64
>>        if (amdgpu_vm_update_mode == -1) {
>> -             if (amdgpu_gmc_vram_full_visible(&adev->gmc))
>> +             if (amdgpu_gmc_vram_full_visible(&adev->gmc) &&
>> +                 !(adev->asic_type == CHIP_SIENNA_CICHLID &&
>> +                 amdgpu_sriov_vf(adev)))
> This would need at least a code comment. But I'd prefer a more general solution that expresses that some ASICs don't allow any MMIO access under SRIOV.
>
> I found that there is this function defined in amdgpu_virt.c/h: bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev). Would this return the correct result and could you use it here instead of a hard-coded asic_type?
>
> Or maybe this could be added as a flag in (adev)->virt.caps and get initialized in some ASIC-specific code path.
>
> Regards,
>     Felix
>
>
>>                        adev->vm_manager.vm_update_mode =
>>                                AMDGPU_VM_USE_CPU_FOR_COMPUTE;
>>                else
