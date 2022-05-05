Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A3FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 18:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A2610EE36;
	Thu,  5 May 2022 18:57:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB53310EE36
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 18:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J786JH1o5YlyQRUKS5Owvbc90v8RRXEV37+CnWRH6WaVQoaiFVbmyoIOPpfpiMJbqkSdK9UMOofM4qGZ/UJc9TAFjAf69mcPk+8HtR9zX9e8PmwcuCfn8UPvDDklt6EVCgoHFUw+MtXHrCG84y+cPrX9z+lRRMdXRNZXDZ8kk1MxYB45MdTKFVL7GoZYWh/Bt037SKw24xC6syNMW/nZ+h8UWUXMTCXqRCrUUKLDJKYCHUO4dkrg8x8DsUA31uYI65aZ4T0TlmehT4ukE9/m2MLr/3WjkPzS1an+GhAPm0yI4d933+ie811u59zkVu8vNbPAiuLNbwjS5v+A8lZXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVxOGZ9ZRoCZusK9c0gxr8DibjKFYCPt/oXo6JMycBs=;
 b=iEiEJ/oU4kh8fiJ6/f6KJ8dflO/bmaRQ9y46N3QfVd1n+Ummsnrkr7pyuGwOf5BcfUyscFJjBkIk+v0xJxefiKbKTOEMxF7AOJ0pFlFGgkUYC8mkE6j40sr3wKPOZEPrSTNh+96klmn6ZM/K2jn44HznU7UWvAkFRctjPv7n9Nak9gw9EVCtnLLFQbJBWeVaF4S5fI0j43jjWmQNnT5kgERCpSVUK7jhiYchGc1GBsnSM23fZraamC4hvVTWp/bW2JEYTyYAbWykUn02LTqM3fnU6aN5bUegBiQyoLkdMrBqKGI8zhvSSK3DNx6BIMLNr/dknU3IGlYTxs6R8yuVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVxOGZ9ZRoCZusK9c0gxr8DibjKFYCPt/oXo6JMycBs=;
 b=MkhkSVZSdkIjSF55d0Xq3ALr2IiwGDr8ZnpLdWwpiVppIcOWE0TN/beAv+rO2tEeUWRp4vDwWW/przRmKchlQG7qEZ9ZlGjY0AuSc035lNX3QJVJURoTyj4Z8bS8t42ra4E+Nx5SAUgWlcqrcTF/lPlQeurLlZvFHQdLFLO4l4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1259.namprd12.prod.outlook.com (2603:10b6:3:75::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 18:57:19 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5206.026; Thu, 5 May 2022
 18:57:19 +0000
Message-ID: <384abcbc-c5e9-3732-7257-7f7bbf4c704b@amd.com>
Date: Thu, 5 May 2022 14:57:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <7e9f45be-41a0-0764-8f4d-2787319477fb@amd.com>
 <80f0a3d8-5b42-f1b3-5396-464c665361c7@amd.com>
 <aec08997-9565-a596-f143-eccf92653a84@amd.com>
 <8ea0a998-b056-8cbf-d666-5305fd124a5d@amd.com>
 <40baeccc-86c0-5fc2-c970-c0bf8b6b6943@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <40baeccc-86c0-5fc2-c970-c0bf8b6b6943@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 332ade92-90eb-42f1-d4ce-08da2ec91487
X-MS-TrafficTypeDiagnostic: DM5PR12MB1259:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12594B69E6F977FEADBE9F0DEAC29@DM5PR12MB1259.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nP9dMXXSimDI3WxPXCcgIyFVLgMIDYc91GHfmWpV4lJhQR0doUYNgm1Vu8sliPDRk2c7+UjtQtCdc6b6aas2slriZgLbLuqNOsOatAv4yA3iPqog9W4Gv/Ss6V9jXKYEVhTL9MpjrcyyDzmY04WsUdzkdB+2Q931o+wWKuCNbI7cQvhK14EZKpC92bGoJuW6ufDzyk/ZKWVf1JaoyHFDIn5mBMe5ki24seuNhf3UGdUeZuF4LFL2mGt8OmtB63MEXxenUwVqHnQ9hZGqcc77xYHS5ws2vqejlgc+ttzkYoseNqO1sQFQ5kZUwWOEYte2Rpw6OZg6GpBJuQheTSrJ+ZiCNY50hUpBdEZyd1shnGLDkm3yX9+hGKjMpGjHhtHk4GJJalVJduqv5XZEKWd6o/EJsqSgNZ2AfKFoBS8TTyMf+DUJiOBq1OK6y4pck+97yumy1W4mQ7KjLm+KJSf+a1/vimlnH/TJCKQXynW0w+oxyYBFP6TALOUfRay6A2SWnzB6WoJzFKSQG2sTaCeMyawFlMHUpYmWEQEOXlpXNsgMBG/0DcdBmzMQaZvzJsq80rFqAgpq028kMQLsBektV6KmBwOuhN0U5Dmwrf1zaLM2/2B5ekj555IYCWDfQo+hqa7qftVc8NVUYlwzsHQZ+BuyYUNIfOtNLc0NQl0V6dgxGi8J31N1KrYm/0o/kF2iAOsG2ylsh2l9VtOAz5n7FA/hjuyOzj/vQcxYhiKRYJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(66946007)(8676002)(66556008)(316002)(4326008)(5660300002)(83380400001)(31686004)(8936002)(6486002)(508600001)(36756003)(2906002)(44832011)(30864003)(31696002)(53546011)(6506007)(6512007)(86362001)(38100700002)(66574015)(2616005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUYrTlczTDJQM3FMSk93Z0hMVlZPcklIcGY4WU4yMzFmL2dhTUlaeUxaYTFW?=
 =?utf-8?B?SUV2THpkdWZQY0xwdmtLdU1tVk43T1RUNTRyOGtCYVorczZJalVCQUFxWGZF?=
 =?utf-8?B?WUVncW1PNHdETHl2dEx5ZmdXR25lVWY3WTU1VnBSdnordGlrWUVvVmFCWS92?=
 =?utf-8?B?ekk2MDltZmZRQjlCMmlOWXNWdEdVckpNYWMwa3BvVGY4aENYV0Z5b3BxYjBY?=
 =?utf-8?B?TUZNQ01hc01HMGVZMHgyM2dQZHlTNXZvQUcxU2xDUlN4QmJzUm9rSnNtMXJh?=
 =?utf-8?B?dnpSY281dm5iY1R2MVhIZ0dYUGxOTHJ4UTNLWGRVcGFRUXNPdTJYT1hGdktK?=
 =?utf-8?B?Z2FseHVUcGI4VXo1UnNxMjZjR2xpWEllaWpFMlEwM0FGS0pGU2Q2OXRxdzAy?=
 =?utf-8?B?RnpaVkRJZnBsZXFISStnQ0VlVVlITm9CNVdZdC9ldmh4NGFsM09yU3k3KzBG?=
 =?utf-8?B?R0xKRklsN053c25HbW9yTVZ6elRoeGd5OTQ3RTg3b0thbitoZUJjcit4MTRq?=
 =?utf-8?B?a2o4a1ZrTHdSak4xQ25hbnQvd09acG5NYWYwMGdmMC9KWXF2eWJBMjdUWllp?=
 =?utf-8?B?NVk1RzdOSHcwZFhZY04rSWhrSkxlZWtkQzdUS09MM0d1UU5ZdFI4emI1ZXlS?=
 =?utf-8?B?Z21BeDIzSUhHQXh2eHQ5TEIvUklKSmRnMFhPb1hhd3hsbmNESG5mbmZ1Wngx?=
 =?utf-8?B?aERUZTk5T2w0MTcxamJBVDMwQTRqUUcxQUZvSzZOVTVTMzYzd2dxNEIzQm5x?=
 =?utf-8?B?Yk5Jak1rMk1BcklhSTY1a2tTZWgvTzRpR3V3dTR1QnBMSTFLbXFKdE05RUpy?=
 =?utf-8?B?NGdmLy9zSmhjc3ZUaWIzVVJkQkJCc1JJNEJkSE5pdUQ4WERneisyMzVGcjZ5?=
 =?utf-8?B?TlFlM1hJbXZmTDRDeWNkQWxySjZKRDhERDRiclBBaWEwbWduU2dIK0YxWVNn?=
 =?utf-8?B?NnhORllpR2phbDRUZXBVY3BHSmdpMjV4YkVZQTdmNjlxVXh1dTRRN0JIaXJ5?=
 =?utf-8?B?RFlrZ3V1WHpOajgyNlF6VGNPSXJNM3liQ0sweDhNWGlHL3ozOXZYT0ZFdkp2?=
 =?utf-8?B?QkUrdG95L2NGYjBCQjhEZjArdmtudzRha09FMkw3dGNoMW11bGdHRmYvN2VD?=
 =?utf-8?B?Mi9oR0tjTDBpYno3UytNdndKYmsyNlBEVGZhRzlmMkxyYy9CTWg2dmJEK0xx?=
 =?utf-8?B?MzZSbFBvWGlteldDVEtOSEtIWUEzc3JCQ2UxL1pMdWM5NFJuZGFFVmRpTjVD?=
 =?utf-8?B?cGt5RkZLSm1YT0tobVlvT0xZdFhuRzAxNGxqNXlPTXRTa2oyaXJGN3REWkxw?=
 =?utf-8?B?T2N5aWVmZ2c5TmdjRE5salU2ckU0MVo4WXZGazhDSzRSVnJobjY4VDZpTkFV?=
 =?utf-8?B?dU82d25ST2luMHAwYUpKbnFMWlY4dE5qczBPakhwREYreFBHUWlTR2UwSlFC?=
 =?utf-8?B?TlRwT2xqcFZYZXFzRFEweHpLbVVPazZDS0dmUTlFRlNuTWRMUkxVa0JKeXRJ?=
 =?utf-8?B?NlpobWRWcnAzNkE1ZU1uQUdScG9td01zYnVydnlyaEd0TG1UYVZWa3VMekxl?=
 =?utf-8?B?amRYKzB5YXFFTStxemhzK0tKdWVjZUJobkpRNVMraEZLL3JiY0doQVhIanBK?=
 =?utf-8?B?WmNsSUtFb0h0OHRSNTRwbHZEalp5M0Q4V250bkpYMVJzS3BhcmErTUdpUSsz?=
 =?utf-8?B?dnpic3V0VVlqTWhQUDVsWXZQWS9TNy85SzF3dUl4R0E5Zkc4UnRPcUxLeHlw?=
 =?utf-8?B?Sk8yKzNra3Y1VG01TDlDd2lvUnlCNE0ySEtmVjE0ejd5OXQreGRwZzRYaVZO?=
 =?utf-8?B?N09pVkt2bVNNdjVIODJrRTU4c2V5T0tKQU1oK2pLaEZQVHFKem5hRGdOc3BQ?=
 =?utf-8?B?UlZmbjNMUXlvVzhsQWdvVUlJMDhSUUtFUEpzalNZaGhwWHJIQ3l1SlJETUxO?=
 =?utf-8?B?Qi9uT2NMdFJoVVJOY0RKK05ZUlAraHE2WjBoeGxHTXFmYVM1a2tYZkJuU25D?=
 =?utf-8?B?UDJxS2RXQS94VS9ieFJFSjA3akN2YWszUUhMeFBON3NoOHQzdDFreDVmSytB?=
 =?utf-8?B?NUdwckNsMjlySVVvNStlNU13YVpsTldaL1FMaXplcVQrZkZudXZETFJuTktS?=
 =?utf-8?B?ZlpPNk1neXVJNHhEbTh3RkR2VVBBOGJ5NmhNYlE3dlFlR2dEYmltZUxkSUpp?=
 =?utf-8?B?cDB0WDZ3RFNuWUd2SWxjcUhxalBoTEZ3Mk9XdUZoV0pJUUJjV3lLSi9VS0c0?=
 =?utf-8?B?aC9QR0hOZWVleTJFYjFrYUZLY0pLRmlTWm1DTHBxWUU4cHA1UVdBZFV5S1Vo?=
 =?utf-8?B?TFRJdVNEVjh6NGhlMWFnbEk0M3ZBL0JSZFRhS0ppMnZoK25ReklrVWRTL20z?=
 =?utf-8?Q?KNhOF3UMNH7a0PfH2BiSTydGuTpVZLyJ3FfGeq5Ntm9hw?=
X-MS-Exchange-AntiSpam-MessageData-1: aaj0ZdJNqr4uYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332ade92-90eb-42f1-d4ce-08da2ec91487
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:57:19.6596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTxqfQIFEOoK6gSfxjeP+TBpOkIl3ir0TR6jGpPejB6FS02dA8OFIT5l/DQ7iGqXs/BpDH0jpRlmd6P9u8tivQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1259
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
Cc: Bai Zoy <Zoy.Bai@amd.com>, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-05-05 11:06, Christian König wrote:
> Am 05.05.22 um 15:54 schrieb Andrey Grodzovsky:
>>
>> On 2022-05-05 09:23, Christian König wrote:
>>> Am 05.05.22 um 15:15 schrieb Andrey Grodzovsky:
>>>> On 2022-05-05 06:09, Christian König wrote:
>>>>
>>>>> Am 04.05.22 um 18:18 schrieb Andrey Grodzovsky:
>>>>>> Problem:
>>>>>> During hive reset caused by command timing out on a ring
>>>>>> extra resets are generated by triggered by KFD which is
>>>>>> unable to accesses registers on the resetting ASIC.
>>>>>>
>>>>>> Fix: Rework GPU reset to use a list of pending reset jobs
>>>>>> such that the first reset jobs that actaully resets the entire
>>>>>> reset domain will cancel all those pending redundant resets.
>>>>>>
>>>>>> This is in line with what we already do for redundant TDRs
>>>>>> in scheduler code.
>>>>>
>>>>> Mhm, why exactly do you need the extra linked list then?
>>>>>
>>>>> Let's talk about that on our call today.
>>>>
>>>>
>>>> Going to miss it as you know, and also this is the place to discuss 
>>>> technical questions anyway so -
>>>
>>> Good point.
>>>
>>>> It's needed because those other resets are not time out handlers 
>>>> that are governed by the scheduler
>>>> but rather external resets that are triggered by such clients as 
>>>> KFD, RAS and sysfs. Scheduler has no
>>>> knowledge of them (and should not have) but they are serialized 
>>>> into same wq as the TO handlers
>>>> from the scheduler. It just happens that TO triggered reset causes 
>>>> in turn another reset (from KFD in
>>>> this case) and we want to prevent this second reset from taking 
>>>> place just as we want to avoid multiple
>>>> TO resets to take place in scheduler code.
>>>
>>> Yeah, but why do you need multiple workers?
>>>
>>> You have a single worker for the GPU reset not triggered by the 
>>> scheduler in you adev and cancel that at the end of the reset 
>>> procedure.
>>>
>>> If anybody things it needs to trigger another reset while in reset 
>>> (which is actually a small design bug separately) the reset will 
>>> just be canceled in the same way we cancel the scheduler resets.
>>>
>>> Christian.
>>
>>
>> Had this in mind at first but then I realized that each client (RAS, 
>> KFD and sysfs) will want to fill his own data for the work (see 
>> amdgpu_device_gpu_recover) - for XGMI hive each will want to set his 
>> own adev (which is fine if you set a work per adev as you suggest) 
>> but also each client might want (they all put NULL there but in 
>> theory in the future) also set his own bad job value and here you 
>> might have a collision.
>
> Yeah, but that is intentional. See when we have a job that needs to be 
> consumed by the reset handler and not overwritten or something.


I am not sure why this is a requirement, multiple clients can decide 
concurrently to trigger a reset for some reason (possibly independent 
reasons) hence they cannot share same work struct to pass to it their data.


>
>
> Additional to that keep in mind that you can't allocate any memory 
> before or during the GPU reset nor wait for the reset to complete (so 
> you can't allocate anything on the stack either).


There is no dynamic allocation here, regarding stack allocations - we do 
it all the time when we call functions, even during GPU resets, how on 
stack allocation of work struct in amdgpu_device_gpu_recover is 
different from any other local variable we allocate in any function we 
call ?

I am also not sure why it's not allowed to wait for reset to complete ? 
Also, see in amdgpu_ras_do_recovery and gpu_recover_get (debugfs) - the 
caller expects the reset to complete before he returns. I can probably 
work around it in RAS code by calling atomic_set(&ras->in_recovery, 0)  
from some callback within actual reset function but regarding sysfs it 
actually expects a result returned indicating whether the call was 
successful or not.

Andrey


>
> I don't think that concept you try here will work.
>
> Regards,
> Christian.
>
>> Also in general seems to me it's cleaner approach where this logic 
>> (the work items) are held and handled in reset_domain and are not 
>> split in each adev or any other entity. We might want in the future 
>> to even move the scheduler handling into reset domain since reset 
>> domain is supposed to be a generic things and not only or AMD.
>>
>> Andrey
>>
>>
>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 +---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++--
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  3 +
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 73 
>>>>>> +++++++++++++++++++++-
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +-
>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  7 ++-
>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  7 ++-
>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  7 ++-
>>>>>>   8 files changed, 104 insertions(+), 24 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> index 4264abc5604d..99efd8317547 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> @@ -109,6 +109,7 @@
>>>>>>   #include "amdgpu_fdinfo.h"
>>>>>>   #include "amdgpu_mca.h"
>>>>>>   #include "amdgpu_ras.h"
>>>>>> +#include "amdgpu_reset.h"
>>>>>>     #define MAX_GPU_INSTANCE        16
>>>>>>   @@ -509,16 +510,6 @@ struct amdgpu_allowed_register_entry {
>>>>>>       bool grbm_indexed;
>>>>>>   };
>>>>>>   -enum amd_reset_method {
>>>>>> -    AMD_RESET_METHOD_NONE = -1,
>>>>>> -    AMD_RESET_METHOD_LEGACY = 0,
>>>>>> -    AMD_RESET_METHOD_MODE0,
>>>>>> -    AMD_RESET_METHOD_MODE1,
>>>>>> -    AMD_RESET_METHOD_MODE2,
>>>>>> -    AMD_RESET_METHOD_BACO,
>>>>>> -    AMD_RESET_METHOD_PCI,
>>>>>> -};
>>>>>> -
>>>>>>   struct amdgpu_video_codec_info {
>>>>>>       u32 codec_type;
>>>>>>       u32 max_width;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -5201,6 +5201,12 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>>>> amdgpu_device *adev,
>>>>>>       }
>>>>>>         tmp_vram_lost_counter = 
>>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>>> +
>>>>>> +    /* Drop all pending resets since we will reset now anyway */
>>>>>> +    tmp_adev = list_first_entry(device_list_handle, struct 
>>>>>> amdgpu_device,
>>>>>> +                        reset_list);
>>>>>> + amdgpu_reset_pending_list(tmp_adev->reset_domain);
>>>>>> +
>>>>>>       /* Actual ASIC resets if needed.*/
>>>>>>       /* Host driver will handle XGMI hive reset for SRIOV */
>>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>>> @@ -5296,7 +5302,7 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>>>> amdgpu_device *adev,
>>>>>>   }
>>>>>>     struct amdgpu_recover_work_struct {
>>>>>> -    struct work_struct base;
>>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>>       struct amdgpu_device *adev;
>>>>>>       struct amdgpu_job *job;
>>>>>>       int ret;
>>>>>> @@ -5304,7 +5310,7 @@ struct amdgpu_recover_work_struct {
>>>>>>     static void amdgpu_device_queue_gpu_recover_work(struct 
>>>>>> work_struct *work)
>>>>>>   {
>>>>>> -    struct amdgpu_recover_work_struct *recover_work = 
>>>>>> container_of(work, struct amdgpu_recover_work_struct, base);
>>>>>> +    struct amdgpu_recover_work_struct *recover_work = 
>>>>>> container_of(work, struct amdgpu_recover_work_struct, 
>>>>>> base.base.work);
>>>>>>         recover_work->ret = 
>>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, 
>>>>>> recover_work->job);
>>>>>>   }
>>>>>> @@ -5316,12 +5322,15 @@ int amdgpu_device_gpu_recover(struct 
>>>>>> amdgpu_device *adev,
>>>>>>   {
>>>>>>       struct amdgpu_recover_work_struct work = {.adev = adev, 
>>>>>> .job = job};
>>>>>>   -    INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
>>>>>> +    INIT_DELAYED_WORK(&work.base.base, 
>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>> +    INIT_LIST_HEAD(&work.base.node);
>>>>>>         if (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>>>>>> &work.base))
>>>>>>           return -EAGAIN;
>>>>>>   -    flush_work(&work.base);
>>>>>> +    flush_delayed_work(&work.base.base);
>>>>>> +
>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>> &work.base);
>>>>>>         return work.ret;
>>>>>>   }
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>> index c80af0889773..ffddd419c351 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>>>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>>>>>       atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>>       init_rwsem(&reset_domain->sem);
>>>>>>   + INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>>> +    mutex_init(&reset_domain->reset_lock);
>>>>>> +
>>>>>>       return reset_domain;
>>>>>>   }
>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>> @@ -24,7 +24,18 @@
>>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>>   #define __AMDGPU_RESET_H__
>>>>>>   -#include "amdgpu.h"
>>>>>> +
>>>>>> +#include <linux/atomic.h>
>>>>>> +#include <linux/mutex.h>
>>>>>> +#include <linux/list.h>
>>>>>> +#include <linux/kref.h>
>>>>>> +#include <linux/rwsem.h>
>>>>>> +#include <linux/workqueue.h>
>>>>>> +
>>>>>> +struct amdgpu_device;
>>>>>> +struct amdgpu_job;
>>>>>> +struct amdgpu_hive_info;
>>>>>> +
>>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>>       AMDGPU_SKIP_HW_RESET = 1,
>>>>>>   };
>>>>>>   +
>>>>>> +enum amd_reset_method {
>>>>>> +    AMD_RESET_METHOD_NONE = -1,
>>>>>> +    AMD_RESET_METHOD_LEGACY = 0,
>>>>>> +    AMD_RESET_METHOD_MODE0,
>>>>>> +    AMD_RESET_METHOD_MODE1,
>>>>>> +    AMD_RESET_METHOD_MODE2,
>>>>>> +    AMD_RESET_METHOD_BACO,
>>>>>> +    AMD_RESET_METHOD_PCI,
>>>>>> +};
>>>>>> +
>>>>>>   struct amdgpu_reset_context {
>>>>>>       enum amd_reset_method method;
>>>>>>       struct amdgpu_device *reset_req_dev;
>>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>>       unsigned long flags;
>>>>>>   };
>>>>>>   +struct amdgpu_reset_control;
>>>>>> +
>>>>>>   struct amdgpu_reset_handler {
>>>>>>       enum amd_reset_method reset_method;
>>>>>>       struct list_head handler_list;
>>>>>> @@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
>>>>>>       XGMI_HIVE
>>>>>>   };
>>>>>>   +
>>>>>> +struct amdgpu_reset_work_struct {
>>>>>> +    struct delayed_work base;
>>>>>> +    struct list_head node;
>>>>>> +};
>>>>>> +
>>>>>>   struct amdgpu_reset_domain {
>>>>>>       struct kref refcount;
>>>>>>       struct workqueue_struct *wq;
>>>>>>       enum amdgpu_reset_domain_type type;
>>>>>>       struct rw_semaphore sem;
>>>>>>       atomic_t in_gpu_reset;
>>>>>> +
>>>>>> +    struct list_head pending_works;
>>>>>> +    struct mutex reset_lock;
>>>>>>   };
>>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>>> amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
>>>>>>   }
>>>>>>     static inline bool amdgpu_reset_domain_schedule(struct 
>>>>>> amdgpu_reset_domain *domain,
>>>>>> -                        struct work_struct *work)
>>>>>> +                        struct amdgpu_reset_work_struct *work)
>>>>>>   {
>>>>>> -    return queue_work(domain->wq, work);
>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>> +
>>>>>> +    if (!queue_delayed_work(domain->wq, &work->base, 0)) {
>>>>>> +        mutex_unlock(&domain->reset_lock);
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    list_add_tail(&work->node, &domain->pending_works);
>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>> +
>>>>>> +    return true;
>>>>>> +}
>>>>>> +
>>>>>> +static inline void amdgpu_reset_domain_del_pendning_work(struct 
>>>>>> amdgpu_reset_domain *domain,
>>>>>> +                  struct amdgpu_reset_work_struct *work)
>>>>>> +{
>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>> +    list_del_init(&work->node);
>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>> +}
>>>>>> +
>>>>>> +static inline void amdgpu_reset_pending_list(struct 
>>>>>> amdgpu_reset_domain *domain)
>>>>>> +{
>>>>>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>>>>>> +
>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>> +    list_for_each_entry_safe(entry, tmp, &domain->pending_works, 
>>>>>> node) {
>>>>>> +
>>>>>> +        list_del_init(&entry->node);
>>>>>> +
>>>>>> +        /* Stop any other related pending resets */
>>>>>> +        cancel_delayed_work(&entry->base);
>>>>>> +    }
>>>>>> +
>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>   }
>>>>>>     void amdgpu_device_lock_reset_domain(struct 
>>>>>> amdgpu_reset_domain *reset_domain);
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>> index 239f232f9c02..574e870d3064 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>> @@ -25,6 +25,7 @@
>>>>>>   #define AMDGPU_VIRT_H
>>>>>>     #include "amdgv_sriovmsg.h"
>>>>>> +#include "amdgpu_reset.h"
>>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is 
>>>>>> sr-iov ready */
>>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is 
>>>>>> enabled on this GPU */
>>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>>       uint32_t            reg_val_offs;
>>>>>>       struct amdgpu_irq_src        ack_irq;
>>>>>>       struct amdgpu_irq_src        rcv_irq;
>>>>>> -    struct work_struct        flr_work;
>>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>>       struct amdgpu_mm_table        mm_table;
>>>>>>       const struct amdgpu_virt_ops    *ops;
>>>>>>       struct amdgpu_vf_error_buffer    vf_errors;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>> @@ -251,7 +251,7 @@ static int xgpu_ai_set_mailbox_ack_irq(struct 
>>>>>> amdgpu_device *adev,
>>>>>>     static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>>>>>>   {
>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>> amdgpu_virt, flr_work);
>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>> amdgpu_device, virt);
>>>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>   @@ -380,7 +380,8 @@ int xgpu_ai_mailbox_get_irq(struct 
>>>>>> amdgpu_device *adev)
>>>>>>           return r;
>>>>>>       }
>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
>>>>>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>         return 0;
>>>>>>   }
>>>>>> @@ -389,6 +390,8 @@ void xgpu_ai_mailbox_put_irq(struct 
>>>>>> amdgpu_device *adev)
>>>>>>   {
>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>> +
>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>> &adev->virt.flr_work);
>>>>>>   }
>>>>>>     static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>> @@ -275,7 +275,7 @@ static int xgpu_nv_set_mailbox_ack_irq(struct 
>>>>>> amdgpu_device *adev,
>>>>>>     static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>>>>>>   {
>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>> amdgpu_virt, flr_work);
>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>> amdgpu_device, virt);
>>>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>   @@ -407,7 +407,8 @@ int xgpu_nv_mailbox_get_irq(struct 
>>>>>> amdgpu_device *adev)
>>>>>>           return r;
>>>>>>       }
>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
>>>>>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>         return 0;
>>>>>>   }
>>>>>> @@ -416,6 +417,8 @@ void xgpu_nv_mailbox_put_irq(struct 
>>>>>> amdgpu_device *adev)
>>>>>>   {
>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>> +
>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>> &adev->virt.flr_work);
>>>>>>   }
>>>>>>     const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>> @@ -512,7 +512,7 @@ static int xgpu_vi_set_mailbox_ack_irq(struct 
>>>>>> amdgpu_device *adev,
>>>>>>     static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>>>>>>   {
>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>> amdgpu_virt, flr_work);
>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>> amdgpu_device, virt);
>>>>>>         /* wait until RCV_MSG become 3 */
>>>>>> @@ -610,7 +610,8 @@ int xgpu_vi_mailbox_get_irq(struct 
>>>>>> amdgpu_device *adev)
>>>>>>           return r;
>>>>>>       }
>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
>>>>>> +    INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>         return 0;
>>>>>>   }
>>>>>> @@ -619,6 +620,8 @@ void xgpu_vi_mailbox_put_irq(struct 
>>>>>> amdgpu_device *adev)
>>>>>>   {
>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>> +
>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>> &adev->virt.flr_work);
>>>>>>   }
>>>>>>     const struct amdgpu_virt_ops xgpu_vi_virt_ops = {
>>>>>
>>>
>
