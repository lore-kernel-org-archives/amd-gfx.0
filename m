Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690C7C4707C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jan 2024 06:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D740010EA53;
	Fri, 12 Jan 2024 06:52:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E094910EA53
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 06:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbmT7zZlIwnhQGhVMuEdddh73VhpeBm9LCoRJOvTVTckARFYYPvE9++cGtzEs8AAdQCooPujnBE1KgMqTFVFNANdk0Aa1Z8ce4cgj0apwkOmT8o70WUnOf/KWnZX45J8PeGAF2X8cEVPK39+jglv1mrWco6bKUlZDo54xMqzD2UvQx4VGbvf7EXfa0O+R2dk4FxCuFIAGMx6b/jjf+vWg2VOiQS2ZLY1SqNSzyV1J2BNfU5CGK5ScJJDGfETzZqrUoOZGAahNdTnD/apn5TQzuC77uhahZeulaMz4ebyiL71lCqi/0b8sYXeIamFNm5QyBOYjnN2cY9Rv8pnGRYUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0zY3JBDnwZOV+gqpvOrk0ElA1gfpBGq/Q7+SlH/1WU=;
 b=bRx6PCUdp2dgQKHHUChIpdPiuySeweyTJvT4LvzftehArLQgPyUDP/6jML/35VCvFh2QxjYo7ccPdIXCNShzUOI0CBOVHv4gih0n6xkNIZX6oMCRz6KxfZXecNrxz+deGCIZtttTI9Y7gGgfMy5ZXprBWqBdC8m+xUiPrjeVVQQTeswDTy/+Bq1uzjJ+NveIFPyDjDmoByEmVY3WC+AoKrnni/nxVnxvCoJs6MzB9z44xTFpaEgKIgOa4h4m79j69De5NMHsL4IGVVHCc1aGr/C6tWAdGy0brrgAVPznJp6UsX+RtMkHaoNVgWfnyUMsraUQI+Xgx0q6ruuWB7oD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0zY3JBDnwZOV+gqpvOrk0ElA1gfpBGq/Q7+SlH/1WU=;
 b=j+uiqxtEKv1CNghcg/XXPo4wZwQOIQz7y8Z2JAqWL0H8inZQuxevgOy5B38K3md2eR47QxQWyswOPaEDnYxz6cQF/X4InPQa6s/3JEsBGGKrMyDTdbz+6377M2VFNlzJMP50uScWCeTRpyItyYKaon90IdQoxF64Hu88pi9i2/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 06:52:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Fri, 12 Jan 2024
 06:52:03 +0000
Message-ID: <36c73957-7ac5-4ea4-9cb1-6128443a0f1d@amd.com>
Date: Fri, 12 Jan 2024 07:51:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
 <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
 <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
 <0416969a-ddf5-4c6b-9017-6a6a4384b163@amd.com>
 <2e8cd9ed-bdea-eb54-99f1-a7b854594b69@amd.com>
 <CAAxE2A6YdbbC0EKWTdAMLQK9tKmO3v17+yPvhqfby2P_bfH1pw@mail.gmail.com>
 <285317c2-4236-4a22-a6ba-26e2100dde54@amd.com>
 <CAAxE2A7+bJm7g+8S_Z3z99vinnSr_8CwjJs+YZVizOS94CekoA@mail.gmail.com>
 <CAAxE2A6c2pxv5j_Mums73Y0PYMXyASOJFoS3rXvUYuRGmbSj-g@mail.gmail.com>
 <0a345f0a-f344-45e9-af0d-13b0c43d6234@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0a345f0a-f344-45e9-af0d-13b0c43d6234@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: c17c87e6-152d-44f5-8706-08dc133afb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sjCoxCYBUUsz+eiprpjl6t2js2JtaBHFQF4auqj+H01+birRmgRXAOMB0eG4ReTZ4vB6GTS2QVXkWpDFF2FIR6xERvx/jXqpPllLC5Is5SItOIVCQNSMbGZzxy1U7mUsO0QeQMWcnY5ycrMXqB9cNqbAhsdwSYUQjut8uAUS4eAzQRFrowDN/zTSkW/qSWiRMmHQ1f67ElKxnMW7kn/CuXJmrZFdjj4pm7AA11esfizM1PbEU4mJNSVH081G4s/D73scATZJnBZ5irI0vKkJkCZCUIFfGmHhutsK62E0CJah7XvImCNwOOn7NtP/YYbFv8dpyxqDyddmA5Ltj4SXGoapEhXi0T4fJK9V46bJ6lteDIxUNUDnLXTZ9oNJWvDY9tDpS6Aeis2vwiICuIWfSqZP+iEjx/Huu6po/ns923Sv3ABYx2OYIuZUYgWndvETYEZ/UvJnSNT5E5zg/nmUIN1EfuRbe5jTPZRrSVJfO1Luh6Qc/9rXLqmYoMu/ozwpiFd7bZE6sUOTe8i+7tcWmfDvWLbMIgTqX4FJy8xasiSHOzrbO3/vI0/cNHG0MuzNAphrikVJNcsRRMFq0c2rVU6UKmnecTh8YuNdTCAE1aRYsvdofFEfra71YfecR6jlDF8g1uccCvaOM7zdqp+Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2906002)(6666004)(5660300002)(478600001)(6512007)(4326008)(38100700002)(66946007)(36756003)(110136005)(66476007)(316002)(54906003)(8936002)(66556008)(86362001)(6486002)(53546011)(31696002)(6506007)(41300700001)(2616005)(8676002)(26005)(83380400001)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3JncTJKbG55aVBud1lHL3BOdkRLL1c4cUsraGhjcXREdzMwSC9vVU5WODZD?=
 =?utf-8?B?eCtGR1FSeWk2aURrbnVDMlNhQVUyd0xPaEVRUlI3bG5sTEgxSU1yOStoKzRN?=
 =?utf-8?B?cUhBY1FRY1QvNHV0RzFjN05SMC8rZWpXVFYrQndJN3pDL0xpRFBVMkVyMWI5?=
 =?utf-8?B?UTRLRjNRbEFlNm1JWTN2ZTZvbjY0N3I1eEM0bk9wTGJ0VDFOMUFVZzJWOU5D?=
 =?utf-8?B?YUFIZDkyL2VYL0pOQURtRWNiNUtocCtiVlB5ZzE0d3dvNXcvcnptZUFySkxK?=
 =?utf-8?B?b0FCR216WUJHT1RVSFBSSzZldSsvbTNEZ2E4QWc2THFtVVZvUmRpUUczR1dT?=
 =?utf-8?B?dXQwUnpJREVKOGVnZjFXbHdXeUdodUY1Q2JkQXhxdWZDRllnQlN6MllvZjFR?=
 =?utf-8?B?WlJBMmJOWG12a0U2SUc0eTV2V1RrbkpzSnZ6Um8yOWlQbWUvZ05YblpFR2ZO?=
 =?utf-8?B?dHBqTnpwZUpZWWhyQnB3UjhndjRPUGNuMVBVUVhsZlB1MEkyQUJsZGV2cVpq?=
 =?utf-8?B?NHlzbUVwYmhqeHVLZXVQR2NiNUo1YXNiTTFYeFlNVDJoWmFLV21ZQllMUnNP?=
 =?utf-8?B?WWE5SzRSWXRGYWVsaHltd09vTUJZczlIQTFocENDSTlJVHREL1MvMUlsczdr?=
 =?utf-8?B?eFFzR3AvL2ovODJGRGlkVUc3QlB5d2hTOVI1V3AyY0V6Q09DYnRIQW9WV3Fm?=
 =?utf-8?B?SGx1RWZzOXBPYWMzVDE3Q0ZaeUFXK0phSkhHelp1djRGc2JKMmZSbUVtcDRZ?=
 =?utf-8?B?RnlQb3BtSWs5N0RQbUE0V0MvT2w5SUhpV1dNbEdmNXlXU2t5SWp5NDN4S0dK?=
 =?utf-8?B?RU41N1RKZml5YkYyZ2NmWkdRYlplSHpGS3JHQmN3S3dCekoyN2hMNC9wbk5C?=
 =?utf-8?B?dXdOYlpYbWJHLzZ0QW9WZUIzcmcvYVNVS09kYjRINnZBazZTTmEvTzhIOENk?=
 =?utf-8?B?dzVzV2hzNElZWlo5UEpoNmR5MFJoUlpnRlRYQmRxbUl4d3pzZU9KblhWa3c2?=
 =?utf-8?B?cGVZc0YwS3V1T2U1V3FZM1JkM1ZoelVydEpjMWZJbUNxVHVDM1M1d250aitl?=
 =?utf-8?B?bllkTCs1NUIxL2dRYXZRQm85c0dEVVkvdVdJY1pRRlo2bmhXOGJIRHpkcHFC?=
 =?utf-8?B?VTBpaVB0U2xTNDBtTEx3Qlhhb3JhQy9xMlZNdGh6QVlYanpRZ0pHaWxEMWFh?=
 =?utf-8?B?VkNtV2R3N2NTeFcra3hGek5nM3FLNGlmOEpUbEpzZ3JZaTZIMEU4MXdrWFJi?=
 =?utf-8?B?U0IzN2xIdVFFZXYzZzdDaE14SHhhcEcwSUxmbnZrb2o1UWFCcTVjc2kwaVpx?=
 =?utf-8?B?UlZPVEZXSnZuNG9yOHlUN3QwcG05THBsQm1ybmNoTHpxS2VuSHJJY0FxaUR0?=
 =?utf-8?B?andmVmRUWXBYb1JmWWxTQVFlOTNBeHprbFJmU2xwc0h5Y0xUN2NjcGlkZlNM?=
 =?utf-8?B?R0FwVnQrbk9XZTYvcGViQ3BBSmFCWGlSN3A5M3NYM2hRdmROcDBKVnVRaUJa?=
 =?utf-8?B?VnF0WlpacHpjKzJRSzFUUzFOb25hTnQ0MHQvZ3VQZ2krbFpUclZyRzY5a3VS?=
 =?utf-8?B?dVdNd0d3aGxablkybkIzeENzWWkvNVFyNkJPQVFYMkFKcDVxaGJSTHgzR1Mv?=
 =?utf-8?B?bThsS3hlY05MdTJqUGRvdlJ0ckF3c0RzZWtKRk9GOUZWWGF0b3hZNEJCanZI?=
 =?utf-8?B?SXJVTmdxN3lYWElITEVNalVjNTk1N1AzTUVMQ21TT0tLazBNcng4SHNwTWVK?=
 =?utf-8?B?aGVQTHh6OFRQNytRSXNsV0N1ZWVrTGhGVnBLeXNwTjNhcVVzUzV6Q0ZyQURO?=
 =?utf-8?B?SlhnRFpHSk1TSDAxbjE4NUljWWUvK2cxQ0ZFUE83WlUyVUM5QWxwYjBlcTd0?=
 =?utf-8?B?MTBWSzhyNnN1R24xMHl4ODFLZ2tVUVNzMnZNZCtqZWFiZmwwVlJHdk9KOUdS?=
 =?utf-8?B?SzU0UHducS9ZNGJGaXVXMGU4OUR1OW01QnUyclBQR09LRCtiNlVvOUQ5RFdT?=
 =?utf-8?B?VkQ0MDJsbUxGQWFoWjFmTlRGelhoRE5TK3pBclBXUjQ5dnlQSU42TDFHQkNW?=
 =?utf-8?B?MFBTQmt1SVFNMnJuYmlzUlJtSzBUakM4YUpwVkYrd241NmFXZjhMamhUdHZs?=
 =?utf-8?Q?LueQBtddEdzJ9xUc3Ahe3xQ90?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17c87e6-152d-44f5-8706-08dc133afb5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 06:52:02.8662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw+uvY3h+VLLB0+ZT4vKoHhruw+KLWeXGNUmJxGu4lLJWjMkdXnLmxRQIrb7a48v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
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
Cc: Alex Deucher <alexdeucher@gmail.com>, Kaibo Ma <ent3rm4n@gmail.com>,
 Jay Cornwall <jay.cornwall@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Arun and I have been working on a patch to split up 
AMDGPU_VA_RESERVED_SIZE into two separate defines.

I assumed that Arun landed this by now, but that doesn't seem to be the 
case.

Going to take another look, but yeah the CSA area isn't large enough to 
fill the upper reserved area so moving the TMA/TBA there should work.

Regards,
Christian.

Am 11.01.24 um 23:41 schrieb Felix Kuehling:
> [+Christian]
>
> I'm looking into virtual address reservations in amdgpu and what's 
> reported by AMDGPU_INFO_DEV_INFO. So far I only found 
> AMDGPU_VA_RESERVED_SIZE, which is reserved both at the start of the 
> lower virtual address range and the end of the upper virtual address 
> range.
>
> The reservation size is currently 2MB. The upper reservation is used 
> by the CSA, which is currently 128KB. That leaves plenty of room for 
> the TMA/TBA above the CSA. I'll create a patch for that.
>
> Regards,
>  Felix
>
>
> On 2024-01-10 12:45, Marek Olšák wrote:
>> It looks like this would cause failures even with regular 64-bit
>> allocations because the virtual address range allocator in libdrm asks
>> the kernel what ranges of addresses are free, and the kernel doesn't
>> exclude the KFD allocation from that.
>>
>> Basically, no VM allocations can be done by the kernel outside the
>> ranges reserved for the kernel.
>>
>> Marek
>>
>> On Sat, Jan 6, 2024 at 1:48 AM Marek Olšák <maraeo@gmail.com> wrote:
>>> The 32-bit address space means the high 32 bits are constant and 
>>> predetermined and it's definitely somewhere in the upper range of 
>>> the address space. If ROCm or KFD occupy that space, even 
>>> accidentally, other UMDs that use libdrm for VA allocation won't be 
>>> able to start. The VA range allocator is in libdrm.
>>>
>>> Marek
>>>
>>> On Fri, Jan 5, 2024, 15:20 Felix Kuehling <felix.kuehling@amd.com> 
>>> wrote:
>>>> TBA/TMA were relocated to the upper half of the canonical address 
>>>> space.
>>>> I don't think that qualifies as 32-bit by definition. But maybe you're
>>>> using a different definition.
>>>>
>>>> That said, if Mesa manages its own virtual address space in user mode,
>>>> and KFD maps the TMA/TBA at an address that Mesa believes to be 
>>>> free, I
>>>> can see how that would lead to problems.
>>>>
>>>> That said, the fence refcount bug is another problem that may have 
>>>> been
>>>> exposed by the way that a crashing Mesa application shuts down.
>>>> Reverting Jay's patch certainly didn't fix that, but only hides the 
>>>> problem.
>>>>
>>>> Regards,
>>>>     Felix
>>>>
>>>>
>>>> On 2024-01-04 13:29, Marek Olšák wrote:
>>>>> Hi,
>>>>>
>>>>> I have received information that the original commit makes all 32-bit
>>>>> userspace VA allocations fail, so UMDs like Mesa can't even 
>>>>> initialize
>>>>> and they either crash or fail to load. If TBA/TMA was relocated to 
>>>>> the
>>>>> 32-bit address range, it would explain why UMDs can't allocate
>>>>> anything in that range.
>>>>>
>>>>> Marek
>>>>>
>>>>> On Wed, Jan 3, 2024 at 2:50 PM Jay Cornwall <jay.cornwall@amd.com> 
>>>>> wrote:
>>>>>> On 1/3/2024 12:58, Felix Kuehling wrote:
>>>>>>
>>>>>>> A segfault in Mesa seems to be a different issue from what's 
>>>>>>> mentioned
>>>>>>> in the commit message. I'd let Christian or Marek comment on
>>>>>>> compatibility with graphics UMDs. I'm not sure why this patch would
>>>>>>> affect them at all.
>>>>>> I was referencing this issue in OpenCL/OpenGL interop, which 
>>>>>> certainly looked related:
>>>>>>
>>>>>> [   91.769002] amdgpu 0000:0a:00.0: amdgpu: bo 000000009bba4692 
>>>>>> va 0x0800000000-0x08000001ff conflict with 0x0800000000-0x0800000002
>>>>>> [   91.769141] ocltst[2781]: segfault at b2 ip 00007f3fb90a7c39 
>>>>>> sp 00007ffd3c011ba0 error 4 in 
>>>>>> radeonsi_dri.so[7f3fb888e000+1196000] likely on CPU 15 (core 7, 
>>>>>> socket 0)
>>>>>>
>>>>>>> Looking at the logs in the tickets, it looks like a fence reference
>>>>>>> counting error. I don't see how Jay's patch could have caused 
>>>>>>> that. I
>>>>>>> made another change in that code recently that could make a 
>>>>>>> difference
>>>>>>> for this issue:
>>>>>>>
>>>>>>>       commit 8f08c5b24ced1be7eb49692e4816c1916233c79b
>>>>>>>       Author: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>       Date:   Fri Oct 27 18:21:55 2023 -0400
>>>>>>>
>>>>>>>            drm/amdkfd: Run restore_workers on freezable WQs
>>>>>>>
>>>>>>>            Make restore workers freezable so we don't have to 
>>>>>>> explicitly
>>>>>>>       flush them
>>>>>>>            in suspend and GPU reset code paths, and we don't 
>>>>>>> accidentally
>>>>>>>       try to
>>>>>>>            restore BOs while the GPU is suspended. Not having to 
>>>>>>> flush
>>>>>>>       restore_work
>>>>>>>            also helps avoid lock/fence dependencies in the GPU 
>>>>>>> reset case
>>>>>>>       where we're
>>>>>>>            not allowed to wait for fences.
>>>>>>>
>>>>>>>            A side effect of this is, that we can now have multiple
>>>>>>>       concurrent threads
>>>>>>>            trying to signal the same eviction fence. Rework 
>>>>>>> eviction fence
>>>>>>>       signaling
>>>>>>>            and replacement to account for that.
>>>>>>>
>>>>>>>            The GPU reset path can no longer rely on 
>>>>>>> restore_process_worker
>>>>>>>       to resume
>>>>>>>            queues because evict/restore workers can run 
>>>>>>> independently of
>>>>>>>       it. Instead
>>>>>>>            call a new restore_process_helper directly.
>>>>>>>
>>>>>>>            This is an RFC and request for testing.
>>>>>>>
>>>>>>>            v2:
>>>>>>>            - Reworked eviction fence signaling
>>>>>>>            - Introduced restore_process_helper
>>>>>>>
>>>>>>>            v3:
>>>>>>>            - Handle unsignaled eviction fences in 
>>>>>>> restore_process_bos
>>>>>>>
>>>>>>>            Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>            Acked-by: Christian König <christian.koenig@amd.com>
>>>>>>>            Tested-by: Emily Deng <Emily.Deng@amd.com>
>>>>>>>            Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>
>>>>>>>
>>>>>>> FWIW, I built a plain 6.6 kernel, and was not able to reproduce the
>>>>>>> crash with some simple tests.
>>>>>>>
>>>>>>> Regards,
>>>>>>>      Felix
>>>>>>>
>>>>>>>
>>>>>>>> So I agree, let's revert it.
>>>>>>>>
>>>>>>>> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>

