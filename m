Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05CCC001DB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 11:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35EB510E1BE;
	Mon, 14 Aug 2023 11:56:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A8F10E1BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 11:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxE9L2bOXRmZeYCkXnWHv83SQadMASLCaQfZ3wz1F6TbyJce5ZOxYgy16Z0m35e1kw9OusBS6yDliaufworywBe3Vzev/gcp1lVjRwlS0b+egzlJ85C5TcjgqcgAksSqG2mKVPU5rBsou7xQv6lQ39TbI5j3atom+F1h3NhUqzTj56+T+fYcUV0d62MmZE6RZ392reJKFLGgLE96POGfMVeFUSSv3eOungHp3TzxBIpidLzyS03P/2Cs6K3kqOx1uLc6bHA0DkX8BjJIwOyIyP7p6+W5y7n6dx2XovGEkQyjLvy+5dQKmSBl8c0PxTj/B5meYljFeNfHWnY5N0GvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oplvGwgA466NGSzmxit9PviN4ElKrrOVcRGl2Li3oIo=;
 b=FHwN+caReSRWxbqxc30ItzhO+LAHvvYL6cC5Phf7D4VZB1tJrPUDLhUOP/8uhhLkHRYZIlCId5WKhb6+lwRw5f/4uEms9ub1cYxv5/zFxijtCMG0aGMXrWntr3P8puMYmkXiEgYRaOJ1jtth/pFCpJVoKzeefVNafPgkBPxeh1+WTg9IuyAbodSKMgxRofot4dfOSBLnYtEAk4kKtpG8Q+GVyJcPjtC9dq5o5qOSqzrFtsww5L5ujlBglD+/HookinkJT12QoZ5wLwMpRdhuFbkqDfVg4+wZHcPRXT6Ql2DKWBVpGwWrvfnlGhjTXdyGkqTngBPU7lUKxjwx3+v9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oplvGwgA466NGSzmxit9PviN4ElKrrOVcRGl2Li3oIo=;
 b=38E7wZ50Izt9Ge1xC0esxi3sndg8LXkuD2asMS2mNGpHCofPhceO+kB5a2W/tTPXedI4e7Nvu341/vTnTW5jgnggis+rGU383BFbx8Geldyb4a4GX/gWCBmOCNpU8wj94u56LE4uY0lJuns5Cuz29Hxh44CsAi15GMA+E62iRGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 11:56:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 11:56:01 +0000
Message-ID: <8fee32bd-ebbb-a037-850e-ec7e9d58cbca@amd.com>
Date: Mon, 14 Aug 2023 13:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] Add work pool to reset domain
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230811060234.663789-1-lijo.lazar@amd.com>
 <f01ee061-ba70-ce2b-e52e-79ba273234c2@gmail.com>
 <e5b13541-394a-0672-b865-9e475d2918f5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <e5b13541-394a-0672-b865-9e475d2918f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 955895c3-e788-423f-cfc2-08db9cbd6dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lrdg6JJt3McOZcFQVCI7DAYgtDTYpkHUBcLTX+mL34Guu6hFBGnIopBRry8vZ+t4jmD4l0By7VgE4TfLrx2eaMwiPF/akxYopPskrm3nZIDPLwuPN5TUOpgX7UgDXyei6GyUDB6UCBL2fue7EWUSOcQFdeLIoWHoIg9E6AgzRGAFirrPiTEH11E1mN0a5TnwxIo3o2J6DhjNtxERIR81fMuQP+WzadTyxrHKst2DaF8VwsiLc+4QIfHtv7tGNn/j8lHGgYSFbzUhc7vmKZlLmxIauoraMcozuru24vRAhbSoa/7eAz1Spt7p3WQBSRl5jmMYdgr30iDJ4qnsCwuqjk0E91rCMr8mDt99HplWhT1r/qrtezNStWoo9nk3huAeIbRWlwlpa91jW1No6eaCsFqh0vo5j+TIJniC5kGCaOUGjL+litX+u2lMI+Rg8GCp4AYFiNfvxeRxBheYvM6ALhV9amMVVG/QOzryWKpt3pb4dhnvMeFMu/iSHUcd3vl/SYj107NPydMg+gtQwPeDlsIxGQl6mkQzsP9+3T2qK0zHP6t2l5JgE1SjVt6I7Sqvx9ZjApY7QjXp6jL/GKa+BOgYmOBPdwrfB/X89qq/qhXE9cTmLVpLfGrS/DJ3S87aTsWjMLtMcTy6DHKJcPsdjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(186006)(1800799006)(31686004)(6666004)(6486002)(6506007)(478600001)(83380400001)(66574015)(36756003)(86362001)(31696002)(2906002)(6512007)(66946007)(2616005)(53546011)(38100700002)(316002)(4326008)(8676002)(66476007)(66556008)(5660300002)(41300700001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFzaDBjYUJqS1JETTR2bTNORGpKb3NtNDRERkhtK0ZOSmh0cXc1UFdoWFJH?=
 =?utf-8?B?d0UzSUJaaUl1bUppRkZPbGdGWU05cjdJK3dVMnBWQWt1WkZTNEdpWEF5bHQ5?=
 =?utf-8?B?OWRuWFBCYjAxcjlMUXJrcjl0YkU3N05pNEJpNUVJRFhXeStwdEhHYnNmNVgw?=
 =?utf-8?B?dmNzV2JqR3JrYklnSzlhbFExYTUvSitrY0R5UVRpSXFyVk1BTHNmYy90WnhN?=
 =?utf-8?B?S0FrSG5KOXhzL3V4Z1ZmaUVFeitoYnJxWitZQW9iVTVpcXhoaUx5NXR5anln?=
 =?utf-8?B?SVRnQnBxN1hnNEIzdkMxS3VSc0hHSFFHc3p1SUV1dmJqdEthSklCMFlIR3dn?=
 =?utf-8?B?cEdyNTF4T0FCNHZwblV2VnFQWXJneXg5TS9FUkVjaGdJTE5mS0ZjWERpRU42?=
 =?utf-8?B?dFJpODZNdjJaTURTbkptSHQwa2FwUi9rR3VtSlMxNFRjSlJuRjIrMVRUY2tP?=
 =?utf-8?B?bXkyM1JOVmdEeGg0Z1h3MExETWFBYVlFaWdRZE10Zk5HMEdya0JjUDkraGNt?=
 =?utf-8?B?Ny83NGk0aEZYTjR2dTUrUHhXbXZTOW1jY0Z0cFd2dzBSMkt1RFF1cWU1NnRl?=
 =?utf-8?B?d1Y1QzVwK251ZG9nNFJ4MTNhWnpFZE9FcmdmcHd5RVNXT1lTS0pmU1lxLzFW?=
 =?utf-8?B?cHdzS0IvZnJpQlp4SElVaGcyckhQZDVpMXoyenJvRHJ4WnpWM1JCUE5qdkts?=
 =?utf-8?B?eExWcGh4UjBuMDBEUmdmVW05dUlOemU5QUpBNzJ0azcybkpBSkNub29jVUxp?=
 =?utf-8?B?dSs1eERNQnJBcUg0dmVsTC9ielZVczZSc3UzbWp4VUhWdmNycnV4TGNPYTVT?=
 =?utf-8?B?eHRsMHdzTTFhRkxLNTJBV1JqZ0x4Z0d0YzdyeXpXQ2ZIWVlLbFBoZGx0RU83?=
 =?utf-8?B?cUEvd0RvZHF5aUFpZVhFaU0rVkZjNThheDk4czdPRlJDR1RuRnBGK2FVS0Na?=
 =?utf-8?B?eWcrOGZUZUtDRXNObXd6RFlzTlZXS0lRVDVxbVVDWWhSWEh6QU5BS1ROZXpi?=
 =?utf-8?B?aStEZTh3cGpYNUQzaXk0MjRBdW5ndXMwbCs4R2ZhWmlpWXlZY0U5UmdraEF1?=
 =?utf-8?B?RjlIZE1pc3RxN0JuTXV0QjR1QUlWSXJuOTFFbkNhYVZlVWRKUFpwKzhhVHdZ?=
 =?utf-8?B?NjlpZFBIUWtGWHkyQUlHYUZvVkJ2dC80NXJDYVNvUGVrc3hIcUhQMStOeDhG?=
 =?utf-8?B?a1JkVDlwMkFpRnZlaUVUZklIZVpEdGpWZnMybFJ3RGswbWZZRHJSQjFPNlcz?=
 =?utf-8?B?VDkzWWRab0owM0hLbk14N0FiZ2MrRGlIaXVqcEw1TzJIMVlYeGU3QUNRRUEw?=
 =?utf-8?B?SllTWVJCNHpQTzNTaWRzdERyNUkyVUFVL2QrM1Nxd3ZZVVNzRFlKaFhXa3Ny?=
 =?utf-8?B?NFl3amM0bkdhL1lScjdKdTBXS2lOejdCcVhyanlIMGsycGZhdW1YWklGSEwv?=
 =?utf-8?B?a0Nyb3FVSnJuSUFQbExUOWNOQmZlL2VLYmtINmlKb24rZWFVSU5yNGhVRmdC?=
 =?utf-8?B?SmQvWDJxUHBPeXZLWTNrV0praUxJYlVmM0drNHNlZ1M4emxGcElmVmFyRXF4?=
 =?utf-8?B?Tk9wYkl1cEYwUXZUMUhydWpxUzY4MFNCZGM3bzUyT1BwTjh2cFB1TWh5WUti?=
 =?utf-8?B?WHEyYk9RcFM1NG1Vd1BGRkZUZllkQWZtbzJHdi9uM0R1ckJMdzBpODIzUDQw?=
 =?utf-8?B?VUtIL1FzNFNXZnJpQjFRcjFYenFQVThrUWZnOFB0NUV5TFFOcjdpNmFNMElD?=
 =?utf-8?B?SDE1eUVnK2loRFFmMjZ6QjB2dzJ1NEYxeWdQN3lRYnNDWWNFNU1VN3VqTGMx?=
 =?utf-8?B?UUEvV2UvVWV2MnVpRXBtcFVFYk5lMitjVzZ4Q2EyOVVkYUpucWFTbWlNb3BF?=
 =?utf-8?B?cHZpVjI4QjVXL0s4aTJ2SHVNK0FvWXQ2N1VOdC9neHZRQXAxdm45VVk1WXpO?=
 =?utf-8?B?Y0I4aFpiNGVmeGREMkdZMlM5QkN1Ujg5dUxPdDk5Rzkzd1JGREZaMGpLNmJX?=
 =?utf-8?B?NnVobjVCckFVQld0V2paaWJPRi9OVTVtOGN2dExyQ0orbk9FVDNaNzEzeHU0?=
 =?utf-8?B?ZVhKNldVVWl6QW9UR2I4d2VjcmQwQm9PYWJuOW5ueVNoS1RwZ0dSM0pNMmM5?=
 =?utf-8?B?UlppREIwY3hWNUxPVy82SFlpaXpqaCtyRmNhOGFxaW9uc2dxRTZia3FDVUdn?=
 =?utf-8?Q?XioHCXqnbxTDLvQUzDUUforZJZhFqfoCkuP57o218RPw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955895c3-e788-423f-cfc2-08db9cbd6dce
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:56:00.9903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJ/XrepjEoZUimPZu6GRac/g0jhHpukUKIHYMZovFNZI4Xiaxmlh4c2EqWh5blYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
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

Am 12.08.23 um 19:08 schrieb Lazar, Lijo:
> On 8/12/2023 1:53 PM, Christian König wrote:
>> Am 11.08.23 um 08:02 schrieb Lijo Lazar:
>>> Presently, there are multiple clients of reset like RAS, job 
>>> timeout, KFD hang
>>> detection and debug method. Instead of each client maintaining a 
>>> work item,
>>> reset work pool is moved to reset domain. When a client makes a 
>>> recovery request,
>>> a work item is allocated by the reset domain and queued for 
>>> execution. For the
>>> case of job timeout, each ring has its own TDR queue to which tdr 
>>> work is
>>> scheduled. From there, it's further queued to a reset domain based 
>>> on the device
>>> configuration.
>>>
>>> This allows flexibility to have multiple reset domains. For example, 
>>> when
>>> there are partitions, each partition can maintain its own reset 
>>> domain and a job
>>> timeout on one partition doesn't affect jobs on the other partition 
>>> (when the
>>> jobs don't have any interdependency). The reset logic will select the
>>> appropriate reset domain based on the current device configuration.
>>
>> Well completely NAK to that design.
>>
>> We intentionally added the workqueue to serialize *all* reset work 
>> and I absolutely don't see any reason to change that.
>>
>
> This is for the case where there are multiple spatial partitions and a 
> reset is possible by hardware design on one partition without 
> affecting other partitions on the same device. The partition scenario 
> can be considered equivalent to a multi-gpu case (not interconnected 
> through XGMI) where each gpu gets its own reset domain and can be 
> reset independently.

Well, this is not even remotely correct. Multiple spatial partitions are 
not fully separated, for example they share a common IRQ block.

So you need to be very careful if you want to reset multiple things at 
the same time. Because of this we already rejected the idea you are 
trying to implement here from the SW side.

>
> BTW, this design doesn't restrict from keeping only one reset domain 
> as in the case of legacy ASICs like Aldebaran. The reset work is 
> always serialized within a domain. This allows to have multiple reset 
> domains or you could also fall back to reset_domain1 -> reset_domain2 
> for hierarchical resets, if required (though that is not planned now).

Yeah, beside the points noted above this infrastructure here is 
absolutely not necessary. The reset domain is already what you try to add.

In general if you get requirements like this please come to me first. 
I'm the owner of the amdgpu component, so all design regarding the 
kernel module must go over my desk.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>>
>>> Lijo Lazar (5):
>>>    drm/amdgpu: Add work pool to reset domain
>>>    drm/amdgpu: Move to reset_schedule_work
>>>    drm/amdgpu: Set flags to cancel all pending resets
>>>    drm/amdgpu: Add API to queue and do reset work
>>>    drm/amdgpu: Add TDR queue for ring
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 -
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  32 +++---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |   1 -
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  24 +---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  40 +++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  16 ++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  71 ++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 122 
>>> ++++++++++++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  32 +++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |   5 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |   1 -
>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  38 +++----
>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  44 ++++----
>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  33 +++---
>>>   15 files changed, 285 insertions(+), 177 deletions(-)
>>>
>>

