Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85A1C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 09:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566A010E18C;
	Mon,  8 Jan 2024 09:01:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE2710E18C
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 09:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRj97pwBAtFJC/hwCjcOtEoEmRxAv/A2qaxnA+AWQg3v0dLTHk9Qsgk+o2qs8orRtnejyRFc9oVqzH/KkxZVAmfSgyBXDidRBnbv/l1tHuLs43biBuS4FKnPGfAuYFkcocScILM4M5DUkFskCFFZAS64pkoeHtrRPeAIkvhDQiAOxsDIGcO/MbORokTGeRgUAkzK583PFpEb5EfJcOpg6O/VyR7iI91/GAiNDHmONAMf92y62Hq/Trccsq57nRhxc6XsSXm6dhYr1vT7qsnq2VYf5iRkN/B1a+dZt33+4BZiSZcfVgHL4X+ed/kCSatnSmlXzwK5WeZ92uW2lBltCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJBssTGoX5LtrG7+6Hyrtek5CWfRs6XF0slCtEXqlM0=;
 b=BTdUkWms182n43GanS4q7F811sa9tKqvMIOQR/OCqF1laGj14p0Tyuic7DEu9QP57Lx6cMYBkqUf4E0+GmSEbJ85rBRUdGmvlW2m1bNeI+Q5WpDIdEigRkg6xxOdFBFvyY+sUAaF/LfW0xiv96x75nNxU5AVIWYLdJVKYU5stpw6MQl+uoGP254+2aYThJwx9K1oiJtR0yAvJv2kKszdad+30IVv0Z26gmhrLmOeErN5rGK+70QZ1dYUlSqrtLa1rd0Z5dhpYQJyAEnXRf+GP3KO8S9dNhF77cpIjjVDS9kXmaHnCs1Eo0RYEBcK/iJzdb6xEKGnNIc06FOOfjqTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJBssTGoX5LtrG7+6Hyrtek5CWfRs6XF0slCtEXqlM0=;
 b=1ZcvdYe3/GTexeDm6THS0oSisTN/xZHEWpXuDDopJrhZ3juXs/jv++69LOLBLw0Mc0Uhe7ywZ2BkyIJEJyidwVHY2CLuNfTPetm23bGSN+GB/k/iRT00+lxAcj1X/baR3p1R4f2RwC04zhKUXItdoU3a1zKfcRWpGCxf3xNbF4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 09:01:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 09:01:10 +0000
Message-ID: <9ef46565-5df6-4e90-8f04-99cde4a655db@amd.com>
Date: Mon, 8 Jan 2024 10:01:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Update irq disable flow during unload
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20240105152100.471494-1-asad.kamal@amd.com>
 <5c1863cb-a528-4c12-9ad7-3c9589088863@amd.com>
 <DS7PR12MB60714005DFBD7DFF9754A23B8E6B2@DS7PR12MB6071.namprd12.prod.outlook.com>
 <1309eac6-7b01-4566-a83f-541dbc0a3132@amd.com>
 <d83c82ef-f9f3-46f0-99ed-8d115dbdd465@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d83c82ef-f9f3-46f0-99ed-8d115dbdd465@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b6bf0c-7dd9-4fd0-3aae-08dc10285b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JEhLdy93EVWkoMWczVoMQP4NfcMmS3QrX0mHFOULyAnzDJCxyWHm0iyOhxWdZomoTIopEKzodxshHD0d404jOEmvqzNokkEr59LVCeFIJCWrB+L9W2jhVA2vYEkBIDSwa5xbKnbSBiJRs5BLRob0KjVuEXPvfe+b6B3zH3vaci7pkHP0Ha8FV3foORqfDlm6g0Fqg+MJdqlyixDO/gY2mfF4azEzsUWdObYVQBN+uZbEGes0pQc9ZxVYXPkCmCbEy7sn/dRuNPdcHR0EkhPt1utuu9R/BguANXoQss6eL9/p8g0vhGhib5txc8PWimD/ZVqspJEVQGak0bD9YCyxjpl6UgdTk6XSMBrQFMeepYCrP9KBC6dMlfrNZLUB4ev+/zcGBZsXykD6IARZGd7KuzFELxU+2Q5b12j2vSHj+wIwXhrw9FB9ecI7ato8upKJo5cOukLU25pYu+e2McFJMKryg0Ehl4ytk1dNkJ+cwYTwnCJ3Aj7+Ssm8MFIU0NrFhCPEmzhuehc040Mb/ZkdIxVqBq0dNIDgbURUCugzXh+PSh4y+L9Uq3LjwZwOJwO1GCaaBcQGt/ACJO3ZiB5msmh8PL1G+lekN9XnSRUb8suF/F//Lx877SCQuR/oNcQVUee3LmDwyHD8tI7IcudYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(110136005)(54906003)(6636002)(316002)(86362001)(4326008)(66556008)(6486002)(66946007)(478600001)(31696002)(6666004)(66476007)(38100700002)(31686004)(26005)(2616005)(6512007)(53546011)(6506007)(66574015)(8936002)(8676002)(83380400001)(5660300002)(2906002)(36756003)(15650500001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzNwL0FPVzJEbzhXYWQvTkRFMFVudUVLNldrOFpBV0hKb3VObysvRit6ZDRJ?=
 =?utf-8?B?THVWMFZVdVQwSG1obGZEUXlxd2g4dkpsOUQxV1FicitCWXFmYjdtajQzUENN?=
 =?utf-8?B?MEpHRW5PSFVBd2s2cSs4OEdpKys2QmU5VWx3b1F6M3I5TTRGeWZHZnM5bmxR?=
 =?utf-8?B?eVcrZFJiSlY3b3VjYi8rbWNiYW5MZzJyNG15enEzeFRWZGliZDdHU2xya2Zq?=
 =?utf-8?B?YnYvTmZBMG9MT3Nmbkl0am9lbFJOMWpzODdSRUJUcFlucU5jbGJYRFhXMUhn?=
 =?utf-8?B?ZzljdWM0dDR1dU9Cbm1yVjNpQkx6UURYZ3ExTFNuTDVqTDd5V203UlovcTdB?=
 =?utf-8?B?ajZoWHk3Z29STFpOZkx0c2NMRmlTZUFTUS9ZclNvTE9DKzI0SXRzQXExOFVG?=
 =?utf-8?B?eTJpVnVnMU83SHJSc0tqcGliemtRY3pWNkR5WC83cTVqbmxxaFlicmVMSEpi?=
 =?utf-8?B?UHAvVDAwMzJWZHNtbnloNHY2WHNYY2JMNTRMUlJVbzQzWExIWkQ1eVVIaThX?=
 =?utf-8?B?MForTU5GelFVQlBONE1UOXFRNEhCSmVaVm5JQmVDRHYyYTdGWmNibUg0OEVT?=
 =?utf-8?B?WmtRaGtJTmJVRkRDSURjUlJ4QWdQb3FlQWprM0kxS3hxODRSL0NVSWcyMFlV?=
 =?utf-8?B?Mk1Wcm9wSzhWRVBRaXFxcWl4RzB6WFo0ejdSVXcvNFNKRXVsQUZhQUdoYVhW?=
 =?utf-8?B?NjB2bUlRVCt3SE5ScWRmY2UxTjk1dVFibWJ2Nk5yMS9xNE9yNXpkVzNrRHVh?=
 =?utf-8?B?THBwTGx5TnorNGppaW9FRzltT0Qva2NQWC9adFNyM3ZPcWdLWVdlc016b0ZU?=
 =?utf-8?B?ZkdBdVJzenZId0s0dHBBTUgvUVY1SW9FbHlEM0dRNVVTcloyZE56Um9CUm1D?=
 =?utf-8?B?WGJtTWNqeHUvVGs2MjhHem1McGl2V3hlZHJrcGRqTS9RUjVtalRaYXVycUcy?=
 =?utf-8?B?K1VYMnNwYnRhc203RUZxZ2FITDh6OWN1U1RObTVNM2l6ZHVFTlJFb2pGVGh3?=
 =?utf-8?B?TDdRYlJtNmp3SWtMZFVCRDNpUi9kVzl5OWs4eWluNDZGV08vdzBOejUrZHVQ?=
 =?utf-8?B?SStyRHYzRVpPZmM0R0VqZ2ZqZnljOHRrM2ZxZS92YWx2ZlpPWDcyck9sSXdK?=
 =?utf-8?B?aDdrODZ0c1pJQmpDeGlRMlFVSGhlVVBjWHlsMG1lL1RKM3BNS2VuN0owN0dQ?=
 =?utf-8?B?OVFqTlVpd255dllvTHBESHMrODEzdjA1VmFubzlybWo0WnRuRXpSQlJVTHho?=
 =?utf-8?B?dkhGMVEycldIY0hmZG1aR3NzVXNoRXlRNy9FdGg3Nm1nU2d2bFlFelQvMEJs?=
 =?utf-8?B?bWR2bGZsaXF2VysxWnBoNHR0aUJORGhLSHJhWVFwa2J3bTJlNEVTOUgxSmVm?=
 =?utf-8?B?NUUrMEtJTEFWbW40SlgyTXR4RmRWbVQ0M242SUFDNFdBUUhmS0lSK2VJdWla?=
 =?utf-8?B?bVBkNG15MHB2Umx4aE1IUk9wQVpXbkFTYSt5K3A1QXp0anVRRmNWT0dUZ1Nm?=
 =?utf-8?B?dUxSak1mdHhmOTJQZVpnRWFnS2kzQWVlQVUzU3NqeEtHKzF3RjdRaEpmdENv?=
 =?utf-8?B?S1pVbXJ4VmU2UEsxNjNCdytpSkJjd1lHa09LRFNZUy84YU9ObzN1cVlFcFFk?=
 =?utf-8?B?aHI1enFrMjZJbmoxYUl1ZkYyRjNQenZMQU5aRFVVaHhEQWNic0R6OHVrSDZq?=
 =?utf-8?B?ZG9MQTdZSHdBSGRoNnZUUDhZZGFndmh4b05TN3hLZTRTZlA5YzFFOFliQlA3?=
 =?utf-8?B?ZDE3aGgxMzBZcVBUTGR6dVdieU5TNVduQ0pVS1JyZUNSVU5DZFRvTThvZmpa?=
 =?utf-8?B?d0U4aThiUU1SaU0vWEtaWE1XMkE0WUFtcFg5dUNsZys2Rjg2MmtHMEZCSlBw?=
 =?utf-8?B?aDVFSURXcU5xWHdhcElEY0t2cG8rVTE0NkszS0JhbGtOSk8wL0dJZWNpY0lz?=
 =?utf-8?B?N1luWnNKVVpoamJRc1NrdDJDaHlDQlBvekQ1REVCeWl4OStKemlnS1p5SWVa?=
 =?utf-8?B?dVBweElYK0k4YWNBS2ttaGNudW4reE9JVHZYQVJoMUh6ZWRoNVYwdVk4ejZj?=
 =?utf-8?B?a2ptVzhzQnJyTTk5cldRaEh0cENLK1NnNUhTSEF2R3h0V1VZWWxnejdQakRn?=
 =?utf-8?Q?tZZI/eHEqtHVX0TeVM0g6MVze?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b6bf0c-7dd9-4fd0-3aae-08dc10285b7f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 09:01:10.2547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAQ/UzBFmhc59zlb/wELghwD6NtOI58ParWTotsjp2bxamjniP9ZETzl6dpQ9FQa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.01.24 um 09:32 schrieb Lazar, Lijo:
> On 1/8/2024 1:51 PM, Christian König wrote:
>> Am 08.01.24 um 09:13 schrieb Kamal, Asad:
>>> [AMD Official Use Only - General]
>>>
>>> Hi Christian,
>>>
>>> Thank you for the comment.
>>>
>>> This is not normal reset, it is reset done during unload for smu 
>>> v_13_0_2.
>>
>> Yeah, but this doesn't explain the rational for this.
>>
>> IRQ enable/disable should be balanced in hw_init()/hw_fini(), 
>> independent of what else you do.
>>
>> I'm not sure what you are trying to solve but this here is a complete 
>> no-go.
>>
>
> This is a special reset done during module unload by this commit - 
> f5c7e7797060 ("drm/amdgpu: Adjust removal control flow for smu
> v13_0_2"). Without this commit, it seems driver reload doesnt' work.
>
> In this particular case, a the reset is done during unload and only 
> resume sequence of only select IPs are done (part of the workaround in 
> the patch). For those IPs, irqs are enabled during 
> late_init/ras_late_init, and not during hw_init(), that part gets 
> skipped.

Please revert that immediately, this whole approach is completely broken 
as far as I can see.

>
> The module unload sequence causes a WARN trace during irq_put of those 
> IPs during hw_fini(). Those are mix of generic irqs and ras irqs, so 
> there is no clean way to untangle it.

This is WARN is just the tip of the iceberg here, the problem is that 
you are not supposed to call amdgpu_device_ip_resume_phase1() as you do 
in f5c7e7797060.

Please sync up with Alex how to do this cleanly.

Regards,
Christian.

>
> One thing that could be done is to add an extra check for 13.0.2 
> version to make it clear that this workaround is done for only for 
> those ASICs.
>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks & Regards
>>> Asad
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Monday, January 8, 2024 1:33 PM
>>> To: Kamal, Asad <Asad.Kamal@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: Update irq disable flow during unload
>>>
>>> Am 05.01.24 um 16:21 schrieb Asad Kamal:
>>>> In certain special cases, e.g device reset before module unload, irq
>>>> gets disabled as part of reset sequence and won't get enabled back.
>>>> Add special check to cover such scenarios
>>> Well complete NAK to that. Resets shouldn't affect the IRQ state at 
>>> all!
>>>
>>> If this is an issue then something else is broken.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
>>>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 ++++++++++--
>>>>    drivers/gpu/drm/amd/amdgpu/soc15.c    | 13 +++++++++++--
>>>>    2 files changed, 21 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> index 372de9f1ce59..a4e1b9a58679 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> @@ -2361,6 +2361,7 @@ static void gmc_v9_0_gart_disable(struct 
>>>> amdgpu_device *adev)
>>>>    static int gmc_v9_0_hw_fini(void *handle)
>>>>    {
>>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +     bool irq_release = true;
>>>>
>>>>        gmc_v9_0_gart_disable(adev);
>>>>
>>>> @@ -2378,9 +2379,16 @@ static int gmc_v9_0_hw_fini(void *handle)
>>>>        if (adev->mmhub.funcs->update_power_gating)
>>>> adev->mmhub.funcs->update_power_gating(adev, false);
>>>>
>>>> -     amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>>>> +     if (adev->shutdown)
>>>> +             irq_release = amdgpu_irq_enabled(adev, 
>>>> &adev->gmc.vm_fault, 0);
>>>>
>>>> -     if (adev->gmc.ecc_irq.funcs &&
>>>> +     if (irq_release)
>>>> +             amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>>>> +
>>>> +     if (adev->shutdown)
>>>> +             irq_release = amdgpu_irq_enabled(adev, 
>>>> &adev->gmc.ecc_irq, 0);
>>>> +
>>>> +     if (adev->gmc.ecc_irq.funcs && irq_release &&
>>>>                amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
>>>>                amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> index 15033efec2ba..7ee835049d57 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> @@ -1266,6 +1266,7 @@ static int soc15_common_hw_init(void *handle)
>>>>    static int soc15_common_hw_fini(void *handle)
>>>>    {
>>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +     bool irq_release = true;
>>>>
>>>>        /* Disable the doorbell aperture and selfring doorbell aperture
>>>>         * separately in hw_fini because 
>>>> soc15_enable_doorbell_aperture @@
>>>> -1280,10 +1281,18 @@ static int soc15_common_hw_fini(void *handle)
>>>>
>>>>        if (adev->nbio.ras_if &&
>>>>            amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
>>>> -             if (adev->nbio.ras &&
>>>> +             if (adev->shutdown)
>>>> +                     irq_release = amdgpu_irq_enabled(adev,
>>>> +&adev->nbio.ras_controller_irq, 0);
>>>> +
>>>> +             if (adev->nbio.ras && irq_release &&
>>>> adev->nbio.ras->init_ras_controller_interrupt)
>>>>                        amdgpu_irq_put(adev, 
>>>> &adev->nbio.ras_controller_irq, 0);
>>>> -             if (adev->nbio.ras &&
>>>> +
>>>> +             if (adev->shutdown)
>>>> +                     irq_release = amdgpu_irq_enabled(adev,
>>>> + &adev->nbio.ras_err_event_athub_irq, 0);
>>>> +
>>>> +             if (adev->nbio.ras && irq_release &&
>>>> adev->nbio.ras->init_ras_err_event_athub_interrupt)
>>>>                        amdgpu_irq_put(adev, 
>>>> &adev->nbio.ras_err_event_athub_irq, 0);
>>>>        }
>>
>

