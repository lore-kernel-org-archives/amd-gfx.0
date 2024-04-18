Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF75C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 05:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ABB2112924;
	Thu, 18 Apr 2024 05:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0N8YNLvl";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4CB5112924
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 05:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKhcWd8eYav9un/4FQresYpc/yoSwft4AB0KFEkX1aCa+YiFFR0JX8b94DxBhw50/JM5lLQ7W6piSpfi6Gag0ekbq994/i/w0pVgrHsc3LBYSJSs6D984xH+xueXG3NcC1dmbtkN387IFpi0rHcBwGoFeMa11BSfJF8Oo/1xvE9x8COmK7AuZecQ98O7BburL7U+OTcUFlkzvQCmZXxC/lRhSZ3skEleR+VKkaY3pWbHvRraeBE/eK9N9A7IYKgui8j9njd/RiCeZyCgj+iCOAjQHYfhg1HYosaqmZObdi0YoySkF5tN1OJmqFkQ744mlMnzfYrZI/CuBYuvPn6OOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88WTRNSo62JwhWD0HqW67WwOSTy/b4UGaF/6F+5kcGI=;
 b=jWUpnnTrqsWIJM32jOHb2c2iWn25LVwxf7QU+kR9oaQ+bVgwgvkIEIJktV+TB+YgE7KCSnOYdiu52qg8SKtWo5F5DECd1dV7yL7Wo4PRAA6be18OUz6x1cQhFV9HW+RP1cluTDT0NKoL5Yrlv8A9j7l8xlQArO9sE6kz051A3cvXIoWQHurFicS+k6ILprmST3DeFUocpuVYhZ94vd0q2LEUA5QIM/Yn5zA78b6rRRrd/ll4yKzRlzYuMKPZcLfAXpduXwLIqe+nwawX2B7CuwOVFpHvQCzeVEGn46QxndAq3J1BEGLahaBWtLdX+t5HUGdROoH0aJs+65VWiIYvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88WTRNSo62JwhWD0HqW67WwOSTy/b4UGaF/6F+5kcGI=;
 b=0N8YNLvlYALx7IoCnJPytHxhhs8o0hO2+2SWG2H3Ui2MhXf/KRPPI0+1YQ6TptfoYo/1q24fAx5QUXg9IJh8m02uHVxiDXw2srg6INMtH5AeFqc3AGTVy7F88UvsK58GSVMtVZlZn9TgSrDjlwcmrXjfVMnn5mvgpcG3zI+itjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 05:59:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 05:59:11 +0000
Message-ID: <3e54fb91-806e-41a7-a7b6-5c12f4d5547b@amd.com>
Date: Thu, 18 Apr 2024 07:59:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/mes11: make fence waits synchronous
To: Alex Deucher <alexdeucher@gmail.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc: "Chen, Horace" <Horace.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, Leo Liu <leo.liiu@amd.com>,
 "Liu, Jenny (Jing)" <Jenny-Jing.Liu@amd.com>
References: <20240417113025.2886905-1-horace.chen@amd.com>
 <20240417113025.2886905-3-horace.chen@amd.com>
 <8997494d-4b4e-4522-acbe-af44a8320c3d@amd.com>
 <CH0PR12MB53727853A2173DA703452EF5F40F2@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CADnq5_MJJk=wW4tDKtOCCVPk9HeK8as75jxgkaHU3LmXb8ezxg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MJJk=wW4tDKtOCCVPk9HeK8as75jxgkaHU3LmXb8ezxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: cd109295-f7b6-458d-89e3-08dc5f6cab18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0G9O0KXuUEfzzAkaicrRV4fQKbYSlEPir6p4/iZ6MoVUXy9nRp4jZ+qa7ZeMY6YDptuaonXnc4BSgtqMAuH0mdSWm+ZHrzVaN8+8dOIiJTDqUGoqvx8Ca8a2uij4mePMs9lA46xDeIJfgfHm9qlTlsCGGM5yYXWZck/d8mL0yMSr9y3E5wRup/yvnifJwBJAPaxszqhnlDNPpFNhiS16PKJJbyQleFftwa3PLgWx3VswUww+V70KFSuGVWy4Y4WS3a5jrwsYMZEbZfBE3U9uk6OLntaA9Sb/sWT2g0MeVlxHDxdMWfadm1kC4u9qjIOG/OC0DxksIj5ifvzdjYb/jva1r81B1VTfJHKat9hAMn6mCQ81/YB53ienWLy8xUF27UbUz+w3SVfqNcmWTl1WDuPE9uIJCEkHW5bOiztRauPcLIghxrAsJlob+dyiZr0cIDWEwPcPah7CTU0IE9ZtBzYY4FDiwu07qDQ0myaoDyGm43Pi81GtH1MTsAC+/cG0kKDX4jBYE8Cfyhlvt80kYSUEEUnj22wD+VEGRoUrHZDxyX8Uxcc4azn86YFsxN4A8MPPtfYSa0O8fLzR8MqoHoOrObWMT/BKMKE5lhe7enqRzluj4/N9l+M2tlYyZ4aSBm83F4ZkLivUKzFOrs+DZVJRF1S+uGanGscnYCnBrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVphL01paE5aQlZtZTFvTERyV0xUcXIyODhwUW8yeHNmaHZBenJKWHB6RUhB?=
 =?utf-8?B?OGxyZkljOWc0cWx0d1ZJL3g3ZGFJVit5Qkw0YWo2TTNPVjI0eVRCS0N2Q1RW?=
 =?utf-8?B?VmlYMTZoT1ZTOElwRGdHZUxMdFZ1NWNBTlJxeGt4U2h2YUJ4bDFoUkdURi9L?=
 =?utf-8?B?NlRkbGgxTUJKVGFJMEVwN0pwSGxRN0RZcHhBSDdoZWFWU2hlYktFZVpsUnFJ?=
 =?utf-8?B?ODczek1ZUm04V0p3dFd1V280bmJKODcvek5JdDRoa2tEMW9kU0xsbU5HUkgv?=
 =?utf-8?B?c0dXVmtHZmw0b3N6b25WNm85QWx3V09PejMyU1JFcURNUHIvdisxSjkwSmc1?=
 =?utf-8?B?Qm94dXlYNFdIdmxQYVMvZXN3RWJieklUVlhLL2NIZ0pDb2NvKy9kT2FFUE9o?=
 =?utf-8?B?M2NVRUk4ZUJMaFFCU0JueHAySy9NNG1jTklNTGE3N3VZQWRqemhQNExNOWJE?=
 =?utf-8?B?YVFISFhNOTFEaTl3WDZoaWpNNWREVHUyeXQrdlI3cVJuOGdvNDlpWnVFOXNP?=
 =?utf-8?B?QmtneTJEWVRuaUE1U0dMRytFeU9DRyszVVovbmczYUJZWGlEYlo2UEdRUFhR?=
 =?utf-8?B?aE1ZNnNsazc2a2h0aXhHVmFBVXE1Y1lMdEhkb1pSM2lSOXRJcmVzT2xING9s?=
 =?utf-8?B?QjFrOENyVHhOU20vVWw4SXV6MEpucjBDcS9ZSmllR2RkbHNLRG8zUVc5S1pz?=
 =?utf-8?B?YVU5MnU0d3BDUlBON0ZNai9XeFBrRVU4S3FhVHJwVXh1ODA4MFN6clpoQVFM?=
 =?utf-8?B?OFozWkwxSFNrZmFadEdDeVQyeXUxWWtVdFBpZFp1aE53ZEdEVE1MdDF2a1Nj?=
 =?utf-8?B?eHNKK3NrRkl3VTZLQ0NRT2NvYXoxR0g4clZuUEFnek0xaStJVW9aL2dPUG11?=
 =?utf-8?B?aTl4YUNjZ2hndXNKQkpuL0M5cEdwNU1oMk9iZzJKUjczMHUyaDk3c2NwWEhN?=
 =?utf-8?B?N1YwRElZTlJHM1F1SjAzL3NhRDdPQm85TlQ3K0o3TzZBU3oxNHhJa0tSWFo1?=
 =?utf-8?B?M3ZOWFdHc05vcFN2cmxaNDROK0RYMm1UMlErNWd4RGpRUDBzYkhyU1c4VGV4?=
 =?utf-8?B?YkRhZ0d2TWZqakZSV0huTkUvc0ltOE1HOWlsV0dzM3FPQkpLUkNlRjBqVkV3?=
 =?utf-8?B?VzhQUEgwWENUZ3FMS3pJeW1IeGdnL0hpUGdKWkxOWm9NWjBzR0RROVNMNk9M?=
 =?utf-8?B?V1NFRWFONytubkFFNkxPbDVqa3R2OEFVSCtkTkY0MENpdWUzdndhL3FLbEVT?=
 =?utf-8?B?MDVKRGFJSzd0eGVpT1ZtYklwZ1RiUDBzVWZYRHFxL0MveTBnS0FpNVRLMlF4?=
 =?utf-8?B?b2hpVFFiVnUyTUVOSldsTG1KVEJvbVhKMVFLbThBUHoxdXBhaVlDS09QS0cy?=
 =?utf-8?B?M1ZZeS9KME1PWUxxR1NrMnV1OWY4aWFqQWZuSjVhVXRXcHNPUWk4NmwxR09F?=
 =?utf-8?B?WXFiYk90eEk0cVJjblhLaFdXc0paaVpQbi9vUmdiUXh0SEdxS25PYlQrN011?=
 =?utf-8?B?SnhneVJScFlqVUJCS01YVXFXVmpEakxnUFdKYWRKOTNLbGJWKy9xQVdRQU13?=
 =?utf-8?B?TkJiVVMwSnAzeXpxdlllSU1RYkhOcFN0U0dGcE9Qemd6ZitYaUNUSXVqMS9Z?=
 =?utf-8?B?LytQSDJLallpZ2xHbi9PK3NybGFOcmI4R0VyMFRPOURkZ0hzUnJ0Z2tjaWlz?=
 =?utf-8?B?Q1FOSVBpemt6V2hiSTFwL3p0aVdvT09zSnViazNPR2NldHo0SC9YeG56bk5h?=
 =?utf-8?B?TklQeFNkbDRVRFNlQjM3dUpnNDVEM2FHakhYcmdoS2g2OHRKVW9ha3FPK1JD?=
 =?utf-8?B?Y1ZTakR5R2J0dnltSGoxcGFlWm5pdHVWOWJOTDg5QXJsR25OSmFLS1dqTjlR?=
 =?utf-8?B?QWZoay9jNmp1NktZaXVnTjlqOC9jTFR3RzRNRzViOEFCRnExM0JmcnM0THVv?=
 =?utf-8?B?SVFORVl2aW43THRBN0I0Q05uSGo2MEw0TzM4MEJ6STRLZWZYbytwdnpaWDlo?=
 =?utf-8?B?NjZ3U05jZ05lZ1d1dFZ4TE5UVEVjVk94UGdyN0lNMWVYMUZzT21CcXZNazBi?=
 =?utf-8?B?ZzgvMEx0VGxDcGNhL0xWa1hTQXJDN01TeXpHSHNPd2ZBNEp3K3VXWHAxbUpr?=
 =?utf-8?Q?zmHE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd109295-f7b6-458d-89e3-08dc5f6cab18
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:59:11.3160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH6o3cNRUp+Oh9JQPOjbjsDZXbAKzY7sFIfkrE2Vto5aQtFRBrjKuwkTS5PLf/Iu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476
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

Am 17.04.24 um 21:21 schrieb Alex Deucher:
> On Wed, Apr 17, 2024 at 3:17 PM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
>> [AMD Official Use Only - General]
>>
>> I have  a discussion with Christian about this before .  The conclusion is that driver should prevent multiple process from using  the  MES ring at the same time . Also for current MES  ring usage ,driver doesn't have the  logic to prevent the ring  been  overflowed and we doesn't hit the issue because MES will wait polling for each MES submission . If we want to change the MES to work asynchronously , we need to consider a way to avoid this (similar to add the limit in the fence handling we use for kiq and  HMM paging)
>>
> I think we need a separate fence (different GPU address and seq
> number) per request.  Then each caller can wait independently.

Well no, we need to modify the MES firmware to stop abusing the fence as 
signaling mechanism for the result of an operation.

I've pointed that out before and I think this is a hard requirement for 
correct operation.

Additional to that retrying on the reset flag looks like another broken 
workaround to me.

So just to make it clear this approach is a NAK from my side, don't 
commit that.

Regards,
Christian.

>
> Alex
>
>> Regards
>> Shaoyun.liu
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christian König
>> Sent: Wednesday, April 17, 2024 8:49 AM
>> To: Chen, Horace <Horace.Chen@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Leo Liu <leo.liiu@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.Liu@amd.com>
>> Subject: Re: [PATCH 3/3] drm/amdgpu/mes11: make fence waits synchronous
>>
>> Am 17.04.24 um 13:30 schrieb Horace Chen:
>>> The MES firmware expects synchronous operation with the driver.  For
>>> this to work asynchronously, each caller would need to provide its own
>>> fence location and sequence number.
>> Well that's certainly not correct. The seqno takes care that we can wait async for the submission to complete.
>>
>> So clear NAK for that patch here.
>>
>> Regards,
>> Christian.
>>
>>> For now, add a mutex lock to serialize the MES submission.
>>> For SR-IOV long-wait case, break the long-wait to separated part to
>>> prevent this wait from impacting reset sequence.
>>>
>>> Signed-off-by: Horace Chen <horace.chen@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  3 +++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 18 ++++++++++++++----
>>>    3 files changed, 18 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> index 78e4f88f5134..8896be95b2c8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> @@ -137,6 +137,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>        spin_lock_init(&adev->mes.queue_id_lock);
>>>        spin_lock_init(&adev->mes.ring_lock);
>>>        mutex_init(&adev->mes.mutex_hidden);
>>> +     mutex_init(&adev->mes.submission_lock);
>>>
>>>        adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
>>>        adev->mes.vmid_mask_mmhub = 0xffffff00; @@ -221,6 +222,7 @@ int
>>> amdgpu_mes_init(struct amdgpu_device *adev)
>>>        idr_destroy(&adev->mes.queue_id_idr);
>>>        ida_destroy(&adev->mes.doorbell_ida);
>>>        mutex_destroy(&adev->mes.mutex_hidden);
>>> +     mutex_destroy(&adev->mes.submission_lock);
>>>        return r;
>>>    }
>>>
>>> @@ -240,6 +242,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>>>        idr_destroy(&adev->mes.queue_id_idr);
>>>        ida_destroy(&adev->mes.doorbell_ida);
>>>        mutex_destroy(&adev->mes.mutex_hidden);
>>> +     mutex_destroy(&adev->mes.submission_lock);
>>>    }
>>>
>>>    static void amdgpu_mes_queue_free_mqd(struct amdgpu_mes_queue *q)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> index 6b3e1844eac5..90af935cc889 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> @@ -85,6 +85,7 @@ struct amdgpu_mes {
>>>
>>>        struct amdgpu_ring              ring;
>>>        spinlock_t                      ring_lock;
>>> +     struct mutex                    submission_lock;
>>>
>>>        const struct firmware           *fw[AMDGPU_MAX_MES_PIPES];
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> index e40d00afd4f5..0a609a5b8835 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> @@ -162,6 +162,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>>>        struct amdgpu_ring *ring = &mes->ring;
>>>        unsigned long flags;
>>>        signed long timeout = adev->usec_timeout;
>>> +     signed long retry_count = 1;
>>>        const char *op_str, *misc_op_str;
>>>
>>>        if (x_pkt->header.opcode >= MES_SCH_API_MAX) @@ -169,15 +170,19 @@
>>> static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes
>>> *mes,
>>>
>>>        if (amdgpu_emu_mode) {
>>>                timeout *= 100;
>>> -     } else if (amdgpu_sriov_vf(adev)) {
>>> +     }
>>> +
>>> +     if (amdgpu_sriov_vf(adev) && timeout > 0) {
>>>                /* Worst case in sriov where all other 15 VF timeout, each VF needs about 600ms */
>>> -             timeout = 15 * 600 * 1000;
>>> +             retry_count = (15 * 600 * 1000) / timeout;
>>>        }
>>>        BUG_ON(size % 4 != 0);
>>>
>>> +     mutex_lock(&mes->submission_lock);
>>>        spin_lock_irqsave(&mes->ring_lock, flags);
>>>        if (amdgpu_ring_alloc(ring, ndw)) {
>>>                spin_unlock_irqrestore(&mes->ring_lock, flags);
>>> +             mutex_unlock(&mes->submission_lock);
>>>                return -ENOMEM;
>>>        }
>>>
>>> @@ -199,8 +204,13 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>>>        else
>>>                dev_dbg(adev->dev, "MES msg=%d was emitted\n",
>>> x_pkt->header.opcode);
>>>
>>> -     r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>>> -                   timeout);
>>> +     do {
>>> +             r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>>> +                             timeout);
>>> +             retry_count--;
>>> +     } while (retry_count > 0 && !amdgpu_in_reset(adev));
>>> +
>>> +     mutex_unlock(&mes->submission_lock);
>>>        if (r < 1) {
>>>
>>>                if (misc_op_str)

