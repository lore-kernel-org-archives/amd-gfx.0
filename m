Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAB7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 16:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DF210F0A8;
	Tue, 19 Apr 2022 16:18:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630DD10F0A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 16:18:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=he1OWhY/241a+dUnyM327sHhCoS7QKawbG4PGAEkS3N8nYxgR77FzMKXhHSgDCEumFYTflV7llObYmIx+aJKPKl8oLgrh6xR5OMQkeunilvQF7o8e/FTJ7hFQOoAjRHGSU1RP1hZirjtwOf1stRhIiKMTYoxAUv3zVX/ZI1WmahC6qCyuer+sqN7O+OmNjJ+obXpv14gu9n9iMrgkcWeff4b1VtWA/NZ3mKgmEGwenYdjWdWOe0mLPZ0TlgV2Z93pWhd+Ge1ee+EzonqFZbPq6ENaW2EC9L9G1iFh3hkWwTeSyoChf7JqZUqE11LY5OuR5XelhZZreE9HJ5+LfTIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du9nlQ1Qep6h4DKMnP8kob2tJEPo/0w7FlxtV8RNGBc=;
 b=Pjq7khhIDCDe+YFgpgt2CEumCk/BymrqEOVHXmDoz39nejDJRNoxLctJ6fBji7UPSqfhyfiT3ZVWzzrFsHhMiPoKecU89ypGqdzOQpUUK3NftpfNlRBXvIkpETV5wYWVLTj8awLmmWVSm53ZbVypiQm4PAom++zALIe449tTmKZ7xE3iR2wrAdPSon6HEZTBPHJhnCWd4HGPabrZZZNas5sYLyRdf9bUhBlAIxPjA66qbDCCXXwyErbshpujyykSX3GEmlhehxn5sExItYMkb/pO4e1+4t3Gp9aboiWIF7gQwDp6D608Crhm80kowBYMTAkuTaxKFxOWqfR0H1sMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du9nlQ1Qep6h4DKMnP8kob2tJEPo/0w7FlxtV8RNGBc=;
 b=uLBRwmq8Kl7T3r8IQzp17cd7o+CeGGQb0YiQF4Sjrlb2Xt4gP5wl6trpU1lMopN4V1P0FGFnWYrOMUFEhz2kF/KYn8WaIiExrpL3d00+eJai/Yu0LhhV4hMveyWY+lVyY/N+UGm2heJ1oaEdiuBXr3fjK09cDSRC+oms/J8pyQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 16:18:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 16:18:35 +0000
Message-ID: <d7bc88ec-0cc4-628b-cd87-19c87d90c495@amd.com>
Date: Tue, 19 Apr 2022 12:18:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Shuotao Xu <shuotaoxu@microsoft.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <20220408084544.9313-2-shuotaoxu@microsoft.com>
 <03483a49-5cfd-3e41-955e-e0e4dee78a74@amd.com>
 <08212428-471E-4C1C-9037-9AE16E9BA356@microsoft.com>
 <5c22aa65-f75d-bc05-e210-f28533d9f0f8@amd.com>
 <5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com>
 <c771861c-f25c-1953-3cb7-f805ddb11aa3@amd.com>
 <B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com>
 <42927224-900a-8548-80c4-13cda4d3f867@amd.com>
 <76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com>
 <c82b697a-b032-1b03-8a9c-49af57f4ae9e@amd.com>
 <7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com>
 <c5a41b51-5275-05dc-2a4e-2522ddb898b9@amd.com>
 <0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com>
 <77a8677a-0ac9-74be-598d-a2e8cf4d6883@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <77a8677a-0ac9-74be-598d-a2e8cf4d6883@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b1cfea1-f230-42af-07a3-08da222040ef
X-MS-TrafficTypeDiagnostic: CH2PR12MB3912:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39128562CB2B1E2FF14AF46392F29@CH2PR12MB3912.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtNCHvu6wZIKwZvVGeLI7+d4xjfoAKQkD2h/R4kZr3wQ1NeHQzGnQLneSIjW6Dq/5M6pB1VUF5Gv/bhIG4A+Xsw0gBBuIvqxzyILUorBaOkmzyY1AFbLui+6H6LdQIHEsiGf+t0w6NnRIJJaiEOWXARazaQHpIAwjAAHgaaFduiNRjmUYSHUjA/naIXHyAtL3a8zE73cridNZmvzYvlxN8Y3eFOD+JtFYTSgHxY5epAQbXAZt+rX63sc+YIopHkextNM9Y45G0xEA2iFoKqo2TKP1VcQ65ChpB/irpBLwdaG7BryPhBzYJ70X2CB7owwfus6zTjxswYKlzqUs0IfAdTulZDh1SayIr/I+Of76KMZEKJ2Z2EnVCmc5XlnOzFn4PrT1+HNjwJzzEn713Rx6UDq95ZpPe62zVByqrBo4/q3hn0/e0sP76h0KV1zFFAjUWYqYzWDtEw+xiN+ONJWjFg2muxpWSnxvQbY7pBKGZN9J0DpSTX6ePeDI3KE3DCAe6t1TuKUM/JVTlSg0RfS9zyg30oFzWnu0BZu2jxTnoSlj0g5f3R5n8E/eS63u75rdUgQvsDOUk3Iowwwbh5pgBfEaJL6lwqA4z6U+NEtLuirUPCTFJon6/FvdXI6Ke4Qm6+MZfzkqarhlq+XeQV9NPiuek6YBU67P1vVYNDT8b0Uh/zYH6xZaDfFaPPXoSkUSiKzpBijD7aeNg0OkPw1uvFmpJlMSQatZ1wZ6PXYXL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(6506007)(2906002)(508600001)(86362001)(5660300002)(44832011)(316002)(31686004)(36756003)(6512007)(8936002)(66476007)(66946007)(66556008)(38100700002)(6486002)(186003)(26005)(54906003)(110136005)(4326008)(8676002)(2616005)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEFGTk9MaGJjZTAxZC9NTEM2YklJV0trejYzYVMxbUxLSjFXcnNiQ2NSdEt6?=
 =?utf-8?B?MktTRzhoZkt2Q3VOTlh4SHhzVTNuMlV1UFFXTmtqMlpXSHUycTRYcHJDaG9E?=
 =?utf-8?B?ei80RmlncTgxQWxiK0FGa2hYQ3d6YVlGTXRCWVJId2FlZmE5VFZ6UzRuenpY?=
 =?utf-8?B?TC8yQUlxRHN2UUdoM1BlVUM0UjZCVXBHUEk4VnptMXgrSjZJNVdhdFJlTkdy?=
 =?utf-8?B?QkFGdE1wdElBemJlQmxFQmNaTUxXOGVZTUJscmxpc2gxa3VlbnNqQU5yUHlQ?=
 =?utf-8?B?SHB4UWdHaWlxRW1NTEpCSGFCNExrbDB6aG5MNVc4R2VXM2lYQ3Ivbk0xOC9i?=
 =?utf-8?B?MmJkN3dtV3E5UW5XcnhEbnN1emZhSDlKQzF5QVdHUW42VDBCenhjT1EyR1Ix?=
 =?utf-8?B?THlKeXZDSlRaMkdpMkN5cjRVemROR1VmQ2dTYXBzaUhpZnZ3eVYrUWwwQWxL?=
 =?utf-8?B?bStuY3hkM0l4ek1FZWtjSFdaZVpMNTQzdll2UHdqUlpZVHZRRC8yK041N0FN?=
 =?utf-8?B?WXFwOVhJVzhZd3doNXQxdDBnaWV0bTFqSEp5WWozUUJYdHdjZElMbXJUK212?=
 =?utf-8?B?V3pxdDF6NU9ObDNPMGdia2ZRME5ldDdXczNKN1ZZOG9KNC93NTNmMnJTSWlr?=
 =?utf-8?B?dFpWWnQreWFPR29UZ3QwQ1dRL0Q0LzducnZabWUzWWpYK0Q2dWVxTmozY1pD?=
 =?utf-8?B?Z1RwcFFiRnVXcndXcnJ5b1dGSVFVWE1RWEtJMy8rR0dFNHM3NG80S25hdDhY?=
 =?utf-8?B?SVlsNWpneDhJUU9YRHdZZ0hYT0pWWldWZGFiOGZqVFhTcEZ3TFNrRjBZUUJ6?=
 =?utf-8?B?NDUrSThRNjBlbnkzTWRqREY4THRiVFVKaUhhTXhKYlh5cmlnZzczT2JwSHZG?=
 =?utf-8?B?TlYzRnpiOUd5VUxRT3pRYVAwRGpMdDVMMlNzeXlYN3B1SDBJeGVzU05OcWdJ?=
 =?utf-8?B?RXp4ZGFqSTA0ci9DT1E5dnFGSGkwS0xsbjFXV0lNeCs1WEpvbE5wZ3NLLytp?=
 =?utf-8?B?dzIyS2tsL3dBMU5DY1RpN1hXeDVBeEx2RC9lUU94SXhsZWpPTmxMbUIrNlFW?=
 =?utf-8?B?SFM2TFoyOUl6UEVEVEUyVE5ZMWNQOEtYdG1DL2Nnb0pXUkRNQy9kbDFPRFZ2?=
 =?utf-8?B?NHFaMTRBaC9VQmlCS3U5NXFtYno0dHVJYlB1UEJsUW5yNEQxa2ppQVZZb3gv?=
 =?utf-8?B?Q3l6WWZKQTN0R0tYNTh6UkZhenk5WSs5QjErQWFaRUFtT2M3L0FlV1kxTWIx?=
 =?utf-8?B?YXgzd2NxTXYzbmVpM1N1SW8xOXJoVmx3Um9icXVCS0ZIWmtlVVE1UG5wN0Nl?=
 =?utf-8?B?ZVNGZ0FVbnZuVlcrOUZnV01nNkMyTlhub1RpR0V0bkppaVVYS21wc2c3amcy?=
 =?utf-8?B?Y3NlVjNQV3NodjJBM0t4MnBrdGw3Z1RBZjVJa2lEZHcrVXcvL2R5cjNVNWNR?=
 =?utf-8?B?SGJQeXY5dk5xeDR3YnVDa1hLUWxDQTEyaE1jNm1iKzAvcW5PQjVQNGNsbkVB?=
 =?utf-8?B?Q2tGSjNSZ3BHNmkxQ3ZTWlhoa3YxcXplSjB1cXlEYi9RckVGSUd0WENzWVVr?=
 =?utf-8?B?YUtjTy9jUmRGM3JkZHVpcVU1TkJEbndyTm1xdnE3U1BTNWpxMStmRnFoRlUy?=
 =?utf-8?B?K0FiWE9LNHRYZVpiWDBwRVBmOWh6NXNHdGp2WjJjODI3YmFncXJTUXZ4YWw1?=
 =?utf-8?B?ZW5aNDczZThTTVJaK2k3dVRKczF0bE5WRW9GWkhNL2xnWTd4dTJEUjF1Qk1a?=
 =?utf-8?B?L1pSdDJNWE9UVE12MEZSU1hwZUg4YzlOVFRjandwL2FyYmg3SkJiZEhjcnh6?=
 =?utf-8?B?b1k5SzhPUldlczd6UHE4cVRMdXBMVGRiMmlHeWVnbkJnVHNtcGo5ZGxUV1RZ?=
 =?utf-8?B?a3FPeXRrSXhJVHpnbVVhTFp0OGpXNFdGakdpY1piUUpDb0l6R1FlbTQwODJ6?=
 =?utf-8?B?QVVDSXBrelpmcXpVa3VyMFcweTVMNjlVL0J1QjhYWEl1dlVKSlBtN3Y5VlZo?=
 =?utf-8?B?UjdVQVBaL0w3c2VlM3FyZVN3WTlkbjNmMFBzTnhQaFNCRnVKUmdidzdpcTgw?=
 =?utf-8?B?cmtsTzk1UmxoSmozamxQSTgyNG1uYThTQ2N2eEdOMmdmVVlQZ0pBMXM5UjVJ?=
 =?utf-8?B?NmFOYk9rNDRLb08rWXZ1VG84d2twdkt6VS9KWHVMQlZ3RE4zY0lXL0toRUR4?=
 =?utf-8?B?WW40N1hNTDh2NmNrUVl1QmhnRnhzcWFtMXppWmFiYlRIODJ4RnQrSFl2UnNE?=
 =?utf-8?B?dTI4blk1eXZRb3g2TU5iTU9waDFzQnNrc1VJS09zaktMK0dZemM3S3A0Y2lE?=
 =?utf-8?B?bXVMOW5BTC9aRjhtdElhb1F2ek5BQnFkam1iUkE4cDZZRjNtbWM2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1cfea1-f230-42af-07a3-08da222040ef
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 16:18:35.1613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQpm3+JanDZ72ABuj2phFuwOul0JsniSgo843UlamVrbTzsOrsX09aKrSBZi1++1dCCtYrUrnyMNjKhLeyX52A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3912
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>,
 Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-04-19 um 12:01 schrieb Andrey Grodzovsky:
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -134,6 +134,7 @@ struct amdkfd_process_info {
>>>> /* MMU-notifier related fields */
>>>> atomic_t evicted_bos;
>>>> +atomic_t invalid;
>>>> struct delayed_work restore_userptr_work;
>>>> struct pid *pid;
>>>>  };
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index 99d2b15bcbf3..2a588eb9f456 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -1325,6 +1325,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, 
>>>> void **process_info,
>>>> info->pid = get_task_pid(current->group_leader, PIDTYPE_PID);
>>>> atomic_set(&info->evicted_bos, 0);
>>>> +atomic_set(&info->invalid, 0);
>>>> INIT_DELAYED_WORK(&info->restore_userptr_work,
>>>>  amdgpu_amdkfd_restore_userptr_worker);
>>>> @@ -2693,6 +2694,9 @@ static void 
>>>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>>> struct mm_struct *mm;
>>>> int evicted_bos;
>>>> +if (atomic_read(&process_info->invalid))
>>>> +return;
>>>> +
>>>
>>>
>>> Probably better  to again use drm_dev_enter/exit guard pair instead 
>>> of this flag.
>>>
>>>
>>
>> I don’t know if I could use drm_dev_enter/exit efficiently because a 
>> process can have multiple drm_dev open. And I don’t know how I can 
>> recover/refer drm_dev(s) efficiently in the worker function in order 
>> to use drm_dev_enter/exit.
>
>
> I think that within the KFD code each kfd device belongs or points to 
> one specific drm_device so I don't think this is a problem.
>
Sorry, I haven't been following this discussion in all its details. But 
I don't see why you need to check a flag in the worker. If the GPU is 
unplugged you already cancel any pending work. How is new work getting 
scheduled after the GPU is unplugged? Is it due to pending interrupts or 
something? Can you instead invalidate process_info->restore_userptr_work 
to prevent it from being scheduled again? Or add some check where it's 
scheduling the work, instead of in the worker.

Regards,
   Felix


