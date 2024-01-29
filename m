Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDCAC47DB3
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 18:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8DA112A9E;
	Mon, 29 Jan 2024 18:59:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CBD112A9E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 18:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLgwSD8xY5KChSliApNd4UHy6iyl4/JVvauaelYaPweStoVtqAO38vxsn9ekluce3kCZfPztTP71oOKEeAhpMXdG79RUTzanlG7qUx78/zWizTSeLFTQVJFJrScwf/EcKQ6sBO1qvkhVS9GqQGwGYYjkbU1YIOLeBB+8UOv1bM2s+NMQLNCSwlMvq0IoHqIpdOATU1yyhjm/oC1O4fzBy73PUmZJURLb8cMNToBZSpcaYh9iH8yvJ2awmiDnuHs7A02iY0YI+oEZfvu688KKSKw6zEYsCGCjV1N0gyEwtjvtaHFcysQRJ4rcL1DfXXczBkqnjI0spayy/zFYiNaB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQb1btjFbTfZnMKJN3ia1U6udWfQ4QJm/NWln2yrgL4=;
 b=XaLxX3TGYsD+u2hSQ29xLp7lHH1RmvCZq/YW9lZsEfZ/osVpXzORceaszvnbAaU0W8mAieVL3o+7+u4YBP27DK6KkAG2/UuByEMlLABPc8Rlluf/jeKzIu56G57bCvrUN5BRo+9Bf61GHDxk7Llly00xUm+kvfapQGkjJFXO1QLdMC/8TIgCvJiTM6EPiNANVbPm9tej1PgBC/5o0e0pDVfJCii5bYds0TFmUKxMz7pwYQqRUVL3Ut2G7uRPyQIIOMeOhzuyMOcMbfoY31tGZ37cgcJQFWXfET44hNq/9cZ7zfVDIOKxjP0grdxOmSY5oWj6QxvZUgynR8lTFzE6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQb1btjFbTfZnMKJN3ia1U6udWfQ4QJm/NWln2yrgL4=;
 b=leIUK++aPCuhC+806OjbMyZj59JsDJjgJ1O8La1IgAiH4GUZng8JoPRSHgXHckZuOGwiDpDBE/i8vt6pzGvnLCuVe7qTmwb3vWSsP3AiF2eCVG3OP72KKoUwXhs3mp9tBTfNtCjB6IY8GasWWPhM04r9jmHGeDNFoBQfMQj7DMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 18:59:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 18:59:11 +0000
Message-ID: <75da7d79-5cf5-404e-89c7-741ceeb2d435@amd.com>
Date: Mon, 29 Jan 2024 19:59:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole
 (v2)
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
 <CH3PR12MB8902F83CE713AD38C49C346BFB7E2@CH3PR12MB8902.namprd12.prod.outlook.com>
 <d9143fd6-2e82-4e42-a297-962d3b806cf9@amd.com>
 <054ed71a-446e-7ba7-e1cc-bfb08497afe4@amd.com>
 <19cae9ce-b9b6-4051-ad2f-ec9010c8745f@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <19cae9ce-b9b6-4051-ad2f-ec9010c8745f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8f46f1-08e4-4bba-3bb6-08dc20fc614a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qe4tw92upHKfLWLGa56kvYoBOGftsBQ0zyhX65p/Xjh1MaLLnobi8P+bCJDlSr+ET/Ud4LU/d6SUvhPReh0QTgbRly4anHkSrlCf1nEbVr1UFzrDGM0p86SAPmOgP6gIzj4OODICImR12gzhGx436vCEBR0P21BsUZtSQD+czcYvrS/tcbr5bF1kG5qeACdlXRFmnf7D6EzDCRHlrYRfjRw0jf9LBssq6E1aopaBdV0dKHIlTmX2KCWckjwZRo7xceEXsQveFlX/wrwgoPUl0rOmv1buC+c/pYCMjhZTCVfbnnmgsEqZvyJDWQYPzDPdZtRYOeCtLT2TiROrUBpa7Rtwgdd9/HkgUC5bB7YSDsAMiDKYCtk96m6MjuviMkxeqxEy903zomvibfm5sA3qLqcHcMyxs2luixd6L5AOzA5mg9vLCT3CRtlCRNtfQWopn+f7g2XnHapKFQcONNY3zshdchk1ZDLmF1Flm+UyN36G5uj16IoaDJ06en+j9hf5L04vahi+NbXcctmXsSPeUqN5BviNFkG1WbtN4TIrJeajEnZeLXzt4MmhY3wQVubXfS7zyS7z6CJjYN+L5D2hkWfCllxJqBKIiqSe0BpyiCVFEOkM5PKDfk78vaIWWO7xysPbofef4UbXUE0KOjh7cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(2906002)(5660300002)(4326008)(6512007)(6506007)(6666004)(53546011)(8936002)(66556008)(8676002)(316002)(66946007)(2616005)(110136005)(26005)(66476007)(38100700002)(6486002)(41300700001)(83380400001)(478600001)(86362001)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVdBSHFTTUVwWlptTFdrTzBMczJYbmpqREU2TS8vWWNMRkg5TmVVVzRpejk3?=
 =?utf-8?B?T1dBQUcza2tPS2RtSEJEVkVBMmpZWG4vanJJSktpcWxJZEVvZnQ4RzJvWTNJ?=
 =?utf-8?B?WHlqUkZUblpjcTBibkZLTDFqaFdNL1RPL2YwVjF5ZXIxTVgyVmViajJpbUFi?=
 =?utf-8?B?UmR6RGs1NnpVK1BBK251MG5HVnRxaDZtb2Q1K2tRRWdiYUdMTUlnWUxvOHU3?=
 =?utf-8?B?VTZwaFc5bGZZSi9lMDRBeERudU1KZFYveEJGWXR3UzlyT3JCV3ZtWTlhWkM1?=
 =?utf-8?B?VXNkbEJ6NlRENW0wZ3FpcXZLNE1lamlKMy9ESUptSGovVjNSYmJsYjFTU2d6?=
 =?utf-8?B?WGkzQWlUcmFoUlRDTnJtY3cvL1FVTzVIRlVpTmNFbTluelFYQzh0eWF3SkFY?=
 =?utf-8?B?RUlaZUhnZDVIdjB6cGwzT1htbFoxMURqbXlJdEMvMSthdEh6ZUtBdmROeGxE?=
 =?utf-8?B?R3FlbkNySVh2VXhNbFYrZktHVGEvMDlDSVgrS0loNk5UTHdSdCtIRk44Vk1a?=
 =?utf-8?B?ejFKSERnWDhnaEtLZzRxUGtMRXU3WXR1S1VZZTd6OThkcUM1Nk5BeDRmRmMz?=
 =?utf-8?B?by82dWVNTHVPcTEvYXlWSVNOR2FqWEpHQjQvUXlXUmJRWHdWTjU0dEE5YzNh?=
 =?utf-8?B?V0FBZGNQTi8zd1BBU2owL29zaVZ1bmFTWkx1NXc2N3A4ajBJRUM2QmdjRHo0?=
 =?utf-8?B?dGdVQ1I0bElwVjhSd3RQczVjUlFBMUlCM3UrNTdvTWJOb1BYMFB4UlZFRG9Y?=
 =?utf-8?B?aEM1OFo3d3NwODNpeExteTluakVTejhqV0RqL3JUcTlVemJGUXAvS0RJTURJ?=
 =?utf-8?B?WDhnOWl1NXVWcUxHbm83UDNUbk1Vay9JYkdDWmc3S2V1VzU5enNod1B2bkhQ?=
 =?utf-8?B?VG5PVXlRK3QrbFVRR2txbm43WFVGazk5Sk5zN25yUm9WK0gzQitLY1VBR00v?=
 =?utf-8?B?Z2ZSQzhDNFVlOGlCdGwwZlVVcU1DS01XUndYNlpMdUx4WXBZZzRGdWYrWFdi?=
 =?utf-8?B?VFZWdDFkRG5FcHRaWTJHQ3poendibjNKdEg1dy9OYXl6VUNpamU4R0ZtQU5s?=
 =?utf-8?B?c2FXZml4QlprcVE1L1psM29nOERUdm5qbkoxWnQ2NnZiR0JQckRIU2FMODFp?=
 =?utf-8?B?T1R2R0VZRGlZVlVSeVd4MmNRTmtXckdvQ1FNMGkrQXdKM1FJSWVkUnFGQm1E?=
 =?utf-8?B?bWlPMXVkSEx2R29yUXZaSTc2ZUp4UWs0VHhTTlQwZ1NBYXRUNlVTcG5ocjZ3?=
 =?utf-8?B?TFY3NE9GaXc5RE00dStPWTZKakF4TEU2S3krdzBlSVpKbXFHMlFzeWEvOFkw?=
 =?utf-8?B?ZVBON3J1dWtkL3E3VW1vVFl6UEhJZXJlQU9WVlBHSDhiZXFkbkJSdnFmMEVH?=
 =?utf-8?B?S2J3eisrUFQzd09zNTRtS1ZCeWQwUE5BeXA4WUVta2NnK2tPODYwYk1LMlhk?=
 =?utf-8?B?TlNMSVJuTWNTVjBQV29RdDFXU1Y1Tk1oRDliNUM4QVUyZjFmT2VXYXFvdEVx?=
 =?utf-8?B?VStIVm1SSVF2emEzV3pNTHZKV2ZCQnRQRm1kZzhud2RVeDdrR1VhVmJ6dFVB?=
 =?utf-8?B?aXh2R0dSMU9OZzZPVENsOFVvdFVmaWxpbDRHSkJBbW9wVU5XSlEzZ3BETFpZ?=
 =?utf-8?B?QkJ0NjFma2dpNTdPNFlEam9hWlhybFRuSUI3WFpkaVV3Tys1Rm1TamhjQXlS?=
 =?utf-8?B?K1BQMG1YTmN2R3dHQWZ4MXRVUy96TFhYVHJuUXMvdGxHOURrcGNkdmJDcmp3?=
 =?utf-8?B?dzQ0dUp5b0lCNWVuci9LK3YrVkZnY3pYeHhZS0dnMy8yZ1krcmJPMnI0QUNw?=
 =?utf-8?B?U2ZNK0FiUFVyajdROFd4ZVU2SkgwYmJNVFZqYS90SzM3dW1hOWl1c3RYVDhy?=
 =?utf-8?B?V1QwczRlbkptMlNEZEpVN3VlaWdZa0N1aUg3R1NDL3BscjdPcXZRUE53TzBU?=
 =?utf-8?B?bldBOUFVWDNwU0poalFVZFgxU3orS2oyd0FHYzduVFd2SnNmdjdpRXFKTENx?=
 =?utf-8?B?Q0VEMEhYNnQ4WmV4MnZhL3dtMTBTSWtKRnB6R2d6ck5SVm5YQzJkbjVBcU0r?=
 =?utf-8?B?bmt4NllGMU1LdldvWkhzZjNzMTJXaTRsRURZdFEzVk5yZkxUdEFJdE9lVXVw?=
 =?utf-8?Q?cYoq5esR+KD0bbOnsEalk3BZM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8f46f1-08e4-4bba-3bb6-08dc20fc614a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 18:59:11.7415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YLIwAf5T2/sHyG1LNrxgC2NIN3l5tabIb1xPGtvMNQRbo0Vh5BMpCdSLzNewQBO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
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
Cc: "Cornwall, Jay" <Jay.Cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.01.24 um 18:48 schrieb Felix Kuehling:
> On 2024-01-29 11:50, Arunpravin Paneer Selvam wrote:
>>>>> @@ -339,18 +346,19 @@ static void kfd_init_apertures_v9(struct
>>>>> kfd_process_device *pdd, uint8_t id)
>>>>>        pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>>>>>        pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>>>>
>>>>> -        /* Raven needs SVM to support graphic handle, etc. Leave 
>>>>> the small
>>>>> -         * reserved space before SVM on Raven as well, even 
>>>>> though we don't
>>>>> -         * have to.
>>>>> -         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses 
>>>>> so that they
>>>>> -         * are used in Thunk to reserve SVM.
>>>>> -         */
>>>>> -        pdd->gpuvm_base = SVM_USER_BASE;
>>>>> +      pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
>>>> Hi Felix,
>>>>
>>>> pdd->gpuvm_base changes from 16KB to 2MB after this patch.
>>>>
>>>> The default mmap_min_addr(/proc/sys/vm/mmap_min_addr) is 64KB.
>>>>
>>>> That means user could get a CPU VA < 2MB while the corresponding 
>>>> GPU VA has been reserved. Will this break SVM?
>>>
>>> It could break SVM if a process tries to map or access something 
>>> below 2MB. I'm not sure what AMDGPU_VA_RESERVED_BOTTOM is used for 
>>> in the GPU page tables. But if it's causing problems for real 
>>> applications with SVM, we should look into lowering that reservation.
>>>
>> We have decided to keep AMDGPU_VA_RESERVED_BOTTOM free for catching 
>> NULL pointer dereferences.
>
> Can this be made smaller? I think the 64KB minimum address used on the 
> CPU side serves the same purpose. Could we match that on the GPU side?

Yeah I think that should work. There used to be a VCN firmware which was 
buggy and would write randomly into the first x MiB of the virtual 
address space.

Apart from that we never really encountered an issue with NULL pointers 
on the GFX side which a smaller reserved areas wouldn't have catched as 
well.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Arun. 

