Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BEAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 14:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC81B10FF69;
	Thu, 14 Apr 2022 14:40:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFD010FF69
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 14:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzMfCfZFJJb+irIM2gl6N+qBp64AGdwQQpf/vQCrrjGCXCW3XUXSKzxK9OohO4JRo2yZTkLdVfb/JJdhq+1lJzrzyn8+QNFRbp118lOivmoMOl0ehEaZaDUTAnyBRXbRDr4fTcWvqu8GEugsGtFoOOA+mYkz7N4/u157ybwOwNH3mpe6jxXDajAu3IIYN459HE+XsTt05icgq2fQYNio57PdOxblg/fQppxSOiwRF1vZSnFO8UvLUgTed4WYKq5z1bcjt75Ugs6pgEYJvivmOkH64vikzt7P5DaF0zVxdHspAY2RWF7rx/kLNUbo9X+MZ0Mqzg6yuxmRi/4U5ltxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCjduPUibyGwux/bgcu5k/k2VXq1f7tuCXbD9ecUY3U=;
 b=obfwPqFxdxL+GmX/vD1PJ3wj7nwaabtGk2LzqrR/WyoEnkm6KQLwfia20KPDDSTBiyglVtdSk5Sd2pSsjvQ9yPEotMvITpfwtb4mAVf3A/qfDR3ZsuGjk3GsGNxPEAAvuYCOEdgmaDPg/cw4HDQjRjqbBbd95q8ugBgOaIyIbnt9P5/wUlBK+/7oAgrzFGo1crvqhyApO+EsBekQqkrvp/TBcb/alrmVVmsdN9RBCoEMYxWl6X0nxnjMp1taE6cGoX0rPitljZio8EgBIrcJ+76z7hRc/TV9ctvB/n7Q0cxNUqozA+FzeD2P9Ucc9hKpxAh6mkblC5eLbc5BsU30qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCjduPUibyGwux/bgcu5k/k2VXq1f7tuCXbD9ecUY3U=;
 b=XcGa05DYafN29ZWsLEJSoGeVEVCpho0jH6H3xVBORMxa1WxTir4XJ9/MG/DVLvQfhfuFjoSZIoutRw2HWg2UX55b+SszbpOhrhDK6Tgqs2xDVeZH08NYDao1+moHApH/c5pdFd5me8Pr8IR/+T0vJgscIRmUJIf5hCwrpdaxvOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 14:40:53 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 14:40:52 +0000
Message-ID: <cd2a520c-b527-1543-3e46-cd63ea8ea123@amd.com>
Date: Thu, 14 Apr 2022 10:40:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Move reset domain locking in DPC handler
Content-Language: en-US
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220413193100.154102-1-andrey.grodzovsky@amd.com>
 <378bf20b-8888-2efb-44c7-9ec2d28ff01d@gmail.com>
 <BL0PR12MB24658257A9A31C1C69C38745F1EF9@BL0PR12MB2465.namprd12.prod.outlook.com>
 <5a9f81c3-3889-a9ca-1faf-407e4455e780@amd.com>
In-Reply-To: <5a9f81c3-3889-a9ca-1faf-407e4455e780@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:610:52::35) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 863e7338-241a-4539-bda7-08da1e24c69e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5866:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5866249246BF8A1330BFD9C1EAEF9@DM4PR12MB5866.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aMxZ/jGvgtj77KmvNxb10u2W1M+j4LoxNUae/NTFCbEpA4H5Q0UeNaQtWnIxJx7psa8wgZ1inNS0hSxsFMe+FsxYauqRT99G49krq4003RVx6NdV3Qe4/AvPnB9CitZhxb/wTNfQyczfw8FeT6YnXgAOuWcy3kwD1YRs5XRy9IBD7ndle6Rl0gTDsD9JqE7cZN4TaM0yDMg1axu0VKBTBHhv/qKBOQK4b/c2lmoLCDYfVTMtUqA6fA4FrV02vD5wccXyBG5hz+zWaw6yoi5wQBtjDDUBWDOhrtoff092E5h17g22DVtL8+/Kyu4Zkxvr360HpfbB+JsH4daVOF5zVtuxZdcwk7Ulw1I6kT4A3yvPufn/3+5mwTbQtWXarHm0NUPllGS8xWooHhRI9X+GHv1bHCTSkUqn5oHxohnfLiPSTvI2V4/oA/redSN408oMrADpKC4B7jfTfST2PAawO5e5g/2lwSRGcjOApUI5E5jzOG9avZX08Hv3VityeJiu2P1KazPK7yOCay9+eLa7yu+jMi1IJadSmKZ4Se3TUZS3sQHFwRGi4zoOufwln/UBSInxQH09R00mjncSW+QR6gVosuZ8SSf7mn8KDElRa6/rYBX4nsfON0A3Mz8Ns++6+8AoPKDnjNqaQXUMXrKHyRAQ6g7uNCOQc97cNYjYgcFIXBAffQoMWjHht+talMG4Uph/2a5KeuIbd4e/D4f3fHJZNKfImd7Jft5W69028ef4hXfMiJUhi5YWcqgW5igxxegl9NkkCeIcZh34ZhU4sgQS0+tuAUIBbkr5VJvP0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(6512007)(66556008)(6506007)(83380400001)(66574015)(2616005)(66476007)(508600001)(186003)(8676002)(4326008)(53546011)(31686004)(66946007)(86362001)(31696002)(110136005)(316002)(6486002)(5660300002)(36756003)(44832011)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkUydUIwTUpQTGRSZVV4UXhrVk0zMnYvWFVRTDZFclBxUEtxR28vYUhzc00r?=
 =?utf-8?B?UnVKWHQyZk5VQVNZcG5RaUtqcFQ5amVxbko2K2Q3c1M1MTZycFYwUHJEZHN0?=
 =?utf-8?B?UTlLS2psTzFwejh0VThwb2xuYXhhZW5lMHEwM1cyVVBBZ1VPWHlXWEliZ3RM?=
 =?utf-8?B?NUVBR0VrK1A1SEhxdy9CYkVZeXFwYVJnUGJhWkRtMXRTeUVNSnJhUHdqNE1E?=
 =?utf-8?B?Skl1blNDWXhZS0huT3FneldZTUNHOGU3Q3g0a3RWUXlBTlZqYUFtUW1SOCtX?=
 =?utf-8?B?dUdQZmJLUCtQa2R0K0JpcGExQlFJOG15TURUUGgwVHU1ZGtxWWRaR2tudjZU?=
 =?utf-8?B?cDVUdGZjZ2gxWmNLS3FhbGFiQXdqcVN2MkVDWmQ5ZS9la3pQZmVHTy9XY0JE?=
 =?utf-8?B?KzAxdHRVWkU3cXo1eGRMam9jaktxRDZKSTEwN3VxV3c0MElJdVgxMXVZMysz?=
 =?utf-8?B?d0VTTGprWjdRNzd2UUxySmJ0Vm1VWFF5WmU5QUlpRFRlclk3L2lEUWVRWUJO?=
 =?utf-8?B?bTA4aTBWcHlDREpUN3dPbUdGYlA1Y08zbUdqbjlZZldHMVQzSkNlZ2RGVXhE?=
 =?utf-8?B?aXo2NE5tUjdMOTJPUERLdUx0NzNRZVpEYXdNa25GVTJPMjg3SmQ2NUJrOUs3?=
 =?utf-8?B?d1p1ZFY3dGpteFNha25BL1BLV1FRdTA1SU1yTFdsbG9mQlFXZmtSSUFHUXdF?=
 =?utf-8?B?NnAvU2Q2dVJGd24xZ1pvWmthNlZMb0V1NDRPWFVXdlVZQ2pHZFAxUzJwU3pR?=
 =?utf-8?B?NjVpdVZENkwwTmpuRU90bTdMaFhOTVJpTWN2ME8yOEtlMDI1bDNBdmlpNXA0?=
 =?utf-8?B?ZXBaYTFINlNKc3VsYWx1TXF1ekY3NGY3MGQvWk1rWG95ZUlSQjFZTmpHenNY?=
 =?utf-8?B?RWdqcm5TWEh0TVRDWnNIWG1naUJKekFRdHhMN0Y5TXFNWkZNMWdsUHcvRlZn?=
 =?utf-8?B?QnppQlZBbTJYSlFPQ3IwNnFLMythbjNEdjVaejJWNEtJUjhJdUFIUDBrMENM?=
 =?utf-8?B?RkcwZXVJUVNCQVJhQ0tMdDQzRnp6dUNIOFkwb1lCMjJ5UitZUVdjcHNXNnRx?=
 =?utf-8?B?YUpLZ0owVkQ5Vi9uNHcvQTVTS0tONXZSQS9EYi9mTUNUaHRkTU13dGs5VVcv?=
 =?utf-8?B?QjZJTXB2cHpnQmZqakhJdk9pa2E2OUcvdUtUSUI1aDA5K1ZxaXU2TzdQcHY3?=
 =?utf-8?B?YnU4TjAxdlRnR0hweFYvc3dlTlFWNVBYbm5GeVpMdlpHcVl0NExVUTVQeU9u?=
 =?utf-8?B?N2RXb2ZidWljU0RIY0k0dVdMcDJJZERHN1VETFF1WFNsazNPOU9FNGMzVENC?=
 =?utf-8?B?Ump3Tml3ZTBQNUpDT3RUNkdGZHFyNG9vc2t3cUVLbTBMbnFGdmJRU1RrYjNR?=
 =?utf-8?B?T1ZYT0x3b0RnWDJlTVE2eVNHMU40Qlk1TjRpb3creVN2VkVTalAzMzVWR2NL?=
 =?utf-8?B?azRYd2tZMU1BV3dmbDl3ZTBybWM0Tk9UNGF5T1VSRHI3Si93S0NPNENhRGZD?=
 =?utf-8?B?UVJIdjJhMzR5UHQyQWhhc0dNZW5YeHFaSkNBLzB3VmhTNW1JNE9VMkN6Njlz?=
 =?utf-8?B?bncrVDhTV0hVdFlvb3NwSDk5UWdRMDZwdk00bVhEbXMwSk5FaEpadmpMNllJ?=
 =?utf-8?B?R0ZVUnYrLytKejREWm01NFJ5WkdXekdNWGRPR3Rua3JJb1FiS2Q0Sno2K3dC?=
 =?utf-8?B?bDdGMWF1c0hqN1VmK25LUnRWQ2xNVmR5My9wVUhmNW03eVdKNSt6aER0VXNN?=
 =?utf-8?B?dmFYdkU0UkVQTWNPdUJHNWdlQnNaUXdRWGN4VG5sKzNkWUJnYmUwdnh5OEhx?=
 =?utf-8?B?aHVvemRlejVBSHcwMXh3aFJVMXlmS25vRDJZRnZZR0JBTUtvNFRJRW95cmc1?=
 =?utf-8?B?Z1Njb0FSb1UvTllGcFprcGs1U2Fpa3ZobkRDRjcrZU1Wbk9qMWx4clgraDFS?=
 =?utf-8?B?SjNIWkY5a1pkbnJuR25ROUw4WENma0Y1YktPb2JDVkxQNGY3N3QrdDh4VDZW?=
 =?utf-8?B?c0llZE9sQjllVTJPM1VpMUsvd254VU8wTWEzT2wyZ1dNMGJJZllvUTgzdm5P?=
 =?utf-8?B?RXFNTlpGSWQyTXRBdTE3akVsd1k3a05IWXNYYWFzS05tVFc1djM3WlNDL0w5?=
 =?utf-8?B?UTNoa1hlbllwNjdTeS8wQ3ZwOGxsbGhLRjc0eWF6L1dKWnlxZlBKZ3pBeTNK?=
 =?utf-8?B?U2FobnVNdkR0YkQybmZzQmhQVSsxMDM2b2ZnRkZjNktRR1h6bjNGckpvNERp?=
 =?utf-8?B?U2hvR2pZZ0oxZ0h2dGg5bi9yUUZVeXJsVHc5ZStVRWUwUFVHRGQ3b0JoN3Jn?=
 =?utf-8?B?dU83NzF5ZVZhWkpjSTcwekFObENHVG0xT0tMM1VZR2kvN2RVcHBlc2hwb0Fj?=
 =?utf-8?Q?MneZMt1KPi97u+neJXZaMjZZWh19H9/v2p2pg4cgnRJgH?=
X-MS-Exchange-AntiSpam-MessageData-1: EsFFzje1Hhy5Zw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863e7338-241a-4539-bda7-08da1e24c69e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 14:40:52.7544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E5lRSjb+Ffq1NFbjhOun56jRY2eeiPQr7o21jHhos438JXaQ9i3XLqSxdaDcfrRkCp1XAWAyVPUyBOm/CKxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
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
Cc: "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

My bad, I see u already fixed this in amd-staging-drm-next. We had an 
issue in an internal branch with this and just reinvented the wheel :))

Andrey

On 2022-04-14 10:32, Andrey Grodzovsky wrote:
> Yea, i need to improve it a bit, ignore this one, will be back with V2.
>
> Andrey
>
> On 2022-04-14 03:12, Chen, Guchun wrote:
>> It's in amdgpu_pci_resume.
>>
>> Andrey, shall we modify the code accordingly in amdgpu_pci_resume as 
>> well? Otherwise, an unset/unlock leak will happen when 
>> pci_channel_state != pci_channel_io_frozen.
>>
>> Regards,
>> Guchun
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
>> Christian König
>> Sent: Thursday, April 14, 2022 2:40 PM
>> To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; 
>> amd-gfx@lists.freedesktop.org
>> Cc: Antonovitch, Anatoli <Anatoli.Antonovitch@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Move reset domain locking in DPC 
>> handler
>>
>>
>>
>> Am 13.04.22 um 21:31 schrieb Andrey Grodzovsky:
>>> Lock reset domain unconditionally because on resume we unlock it
>>> unconditionally.
>>> This solved mutex deadlock when handling both FATAL and non FATAL PCI
>>> errors one after another.
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++-------
>>>    1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 1cc488a767d8..c65f25e3a0fc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5531,18 +5531,18 @@ pci_ers_result_t
>>> amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>>>           adev->pci_channel_state = state;
>>>    +    /*
>>> +     * Locking adev->reset_domain->sem will prevent any external 
>>> access
>>> +     * to GPU during PCI error recovery
>>> +     */
>>> +    amdgpu_device_lock_reset_domain(adev->reset_domain);
>>> +    amdgpu_device_set_mp1_state(adev);
>>> +
>>>        switch (state) {
>>>        case pci_channel_io_normal:
>>>            return PCI_ERS_RESULT_CAN_RECOVER;
>> BTW: Where are we unlocking that again?
>>
>>>        /* Fatal error, prepare for slot reset */
>>>        case pci_channel_io_frozen:
>>> -        /*
>>> -         * Locking adev->reset_domain->sem will prevent any 
>>> external access
>>> -         * to GPU during PCI error recovery
>>> -         */
>>> - amdgpu_device_lock_reset_domain(adev->reset_domain);
>>> -        amdgpu_device_set_mp1_state(adev);
>>> -
>>>            /*
>>>             * Block any work scheduling as we do for regular GPU reset
>>>             * for the duration of the recovery
