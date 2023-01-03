Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3696C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 09:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2919C10E24B;
	Tue,  3 Jan 2023 09:43:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A311210E24B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 09:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haCjH6ATcD//96BoWWZ4JPonPzX/79qcXa9Oi8OAO+ZvSMpPIIr/WjDDJtXqxEemhlIePGDgmoMj9Q2SZ8lTyTYCFs4uq3ZGS88aosTg6Euadwc6dqhx8X9BdZ8pbVyBBWmXFPcQDMybxfsQhLpefVFZy0PBVYY4T6/gDoAIVIik6Xh+NpbeXKvdepZR3OtpulWw/JZayu1YdqQcp/duaOOBcqLtwd3dIGBm06l6A+faq3Cff5hbiEIRDT4oegEGMW9ubp3OhnKpm+SaYJgfBOAeJGBFo6q0PqOGKhXo3Xu94Ho92u6VTFLDJ3wMKgjHBPXqer03UmjqlsJgH/ggug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn2S82PBi/rJ5C+TcSK7q0FLP6e0quUI9POomhGBnEo=;
 b=O16al9/DaOmirfHjXSVeJezt0fUNoKh7Bosi5I3XfJYLqac7sl+dplQ42UxGd3dEVDvA6CKYVScVGBavjYSaMvoPxtPVaJQo8of69BphlXzLm1/JI6Rxa46mKopyIDGSM1drIFbA32JMuBRp83TkTeu2APR/+YJN+YnppnkOcgT0rWjURgizy/6HVS/VmG78fjLZWWNbkQnst8oWIgrSh8mv9ZdYl8o22QrHgzcVV21JgxXQfdJLL4y5RGi82Nb5YHcLSIW4SabyL1duefyMdkGvVv6OGyQHOZmbcIkIoziX2Vkem6M4sPm2gyTzaa7o0M/isRdfKAHnA8uXH5apLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn2S82PBi/rJ5C+TcSK7q0FLP6e0quUI9POomhGBnEo=;
 b=ZyDFvDljWsYP1IbGzTeWsVCK+bJle+aN8Dck0lXnCTyqdJlpgfJaJDnpFV6DhLa3aggkP0+ASlZ5bPn4yLwih9whcb8WiNOpCwl70G6lpXiDoxbIVhmokeY9ipLQU3a58bKE4kXrVpWI5MZGXR9t8DZFUpnd9if4wWgwAa7hT2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 09:43:40 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 09:43:40 +0000
Message-ID: <9a7aad24-e3f6-cffa-bf3d-e1ade6c9c29c@amd.com>
Date: Tue, 3 Jan 2023 10:43:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 0/7] RFC: Usermode queue for AMDGPU driver
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <CADnq5_MuJdXE3CjuibmiW72bPFfAN1YCr20tUpayf9fnn+DXZQ@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_MuJdXE3CjuibmiW72bPFfAN1YCr20tUpayf9fnn+DXZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: d61ae40e-41b2-43ff-8562-08daed6efe91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvFgJ/dhdnh2bgWtr84EfXVr/KJGx97uagSFmpRHfc/6D5gs64c4o3QNYNGaNd5+wd9Z5Nh6ceplmKG3Fa261YLLyVkz/4rdvrMvPwMRux05guCQN2jpwig/viUzI0wQJBW7ByYK3Aguw3wO8qvKH5tPt/UiM/+aoic0NXKoRTdVKTvTZD+JqhJM606GnPL2E7a39fLgrSKfAaK7mhI8ZRsyEZ2EdL/vLk2mglb7gL7Vh7cIqF2uJbuCSuTCJauQbYQdpvklnA9iDe9PcvCes1LSR707GP4VpShNIr0HYW7+KqflEyD/PJhCWuJmouVyjwcjqWUnPgchpzC7a5gUi+DXH2s8fuCGG626Y9DJpnfK+LXOGVgtPr8uMqDatJ6fOjxuTRhJzQ4+FHye7MBuBuBYc0I9DYwUqbVFPaRsJsUOfb4N9LR89rmck1I1MlUsTb+RKAmbuQAyPKmjchJYlmmhusmEySdIUli8mt7U7pUpOFdcbK1Wm4tzCipAJVStyEAiIObkGuY8CCVqWfvSXUdWXDX7G7z5FRJjFkiFRW/igPvn5NXfL3osQMU/D9LkCGXMnKe0yUfHKDGy5whzaG/xMk+cy8BvVn6htQwvSeKGyAwlWKS2xQQhPnlhiTfP06aVqAZV7NrO6JN6rH7nDNco+lCv9TaFvq5xhSW1BvU9F9DYUGdYcWdWYp7cNd1PZHLYMcQZhbnjsAxtw27Ewzik39XJ7KPQ0vJFw9bWPtacr5Y89BmifLiL7EQ5dct2CbR4bxd+WNiIiAtTKvOibVRpDhU6Ojt4e2v5ERFqB+Y8GEogmnAiUa8rc5tM09dV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(6512007)(186003)(53546011)(26005)(6486002)(6916009)(54906003)(31686004)(478600001)(316002)(6506007)(4326008)(66946007)(6666004)(8676002)(66556008)(2616005)(66476007)(8936002)(5660300002)(44832011)(83380400001)(41300700001)(2906002)(38100700002)(36756003)(31696002)(86362001)(22166006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTh2RUlQUkVqTkgrTDg4Tll2b054ZXR6ZlNtWVBUT0c5TjN2NGdJdnllTnB1?=
 =?utf-8?B?N0tTa05CVUhDLzZJTnNwb0YwS1U4RlQ0djk1Ym9lSU1ydWkvYW1pVHBYWE5w?=
 =?utf-8?B?Z2pMUndWQmdiaGh6Y3BHSXN5SkYwL3o1VWwzSVdCNTJ5bVlUZUlTbHoxYURa?=
 =?utf-8?B?Tkp1K1NVMkZmNzZzVUpYdUhCNDl5c0g3ZmFVY2FoOUlLSHN3Zi9oMlBFRDRS?=
 =?utf-8?B?bXdUYkVjU0lPME1TWHIrNHRBc3pHcmMwcTBMQmdBdTJta1M1OCtlSEhlTzRX?=
 =?utf-8?B?TmhkVlF4M0hHYzEwQTA5bi84SDI2eTRzWURXNU1aY1VXdzZSVWVBSDBtbmVk?=
 =?utf-8?B?M2tHTGVPMHFML1pyOUdKUUlJb1Q5RWxuOXdYSlBGSkdIUUNLRWoza0tpODQz?=
 =?utf-8?B?dTIvaVpmeEdXREZtN0NGSDhTa2h4R2l5Smx0YW92NjVjNnZVZ1RvRVVtdW04?=
 =?utf-8?B?QWc1WG9PN0UrOXpBNUxSMjEwUVQrSWxSb2IvOE00eDNKTkdLNzE5a05adDRO?=
 =?utf-8?B?SDdXZGRCdUc1ZUlLZ3Y0YjZ5eko4a29ycW5WUENBUmp3b0hNRmV6dnNBMnV3?=
 =?utf-8?B?Wkh3dmRSeVZZVnI0Z1Qxb2txYVVYY0hRMUxzTThRNzJ0M2dvNWVyVkU4bTVu?=
 =?utf-8?B?dHFYTW5ud0tiSEJ6WDhDRDZDbDgwMjNhQkJCV3o2YUozUzVjVkx1Q2FWUXUz?=
 =?utf-8?B?QWY4b0ZrTUZVOWVWOTBhRnJETjB4YUoxdFBPQjdYU09wdjdZM0liWkU4cERu?=
 =?utf-8?B?SExrSDZCVzUyT3ZSY0FxYlI4azhsaUVCLytGaW9iVHRFZURFblVxbjErSEdw?=
 =?utf-8?B?SlBjSlVaRFd3THppSGF5N3ludzREbzl5Tm1vRmtOb2xPejRnZDBCRWJuQWRr?=
 =?utf-8?B?R3Nsa1BUY2hTMkwrYjA0SmZNSUNlZHpFbGtOSldpNE1ia2FLNWxUa2xaYlk0?=
 =?utf-8?B?d3FOY1VacThDUFJ6MVRGYVpBaE9KVGlxb1hhcUlXeWcyR1M4WEdBbldSOHhw?=
 =?utf-8?B?RElveGRTai95OHBYN2VmYnI2MDUyUkNzc0t5eXNieEQ3VlVNUUpzcmpqTWtj?=
 =?utf-8?B?L21CU2dabU0rblNCY3cxemVoTDNCcTgvM1JvM25OUUpEc1BWZWpDU2RMR3Vv?=
 =?utf-8?B?NEF3SWUrOTE5bDJGcURtTWdvSFFocDQ3U3BqMU5IY3lINDVLWGdIM1B0WWxM?=
 =?utf-8?B?TnQ4YnJ0R2VqaU9YbS93TzJNZFdwd3lybjAvUGYwTWJGWFNjbjVuaXN0ZVVS?=
 =?utf-8?B?a2d2TU5OS3dXbWVmQlhRNjN0bVB1UjBnd1JLOGpDV1dKMi9KOVgwVFAxc3FC?=
 =?utf-8?B?WGgwMnhlZ0Y5TjBlUzVzVGk4UTN3TS9IV1BRWlU2cGJPZ3h4NHZhbjhoRHU1?=
 =?utf-8?B?MFE1Z2hYT2FtWG5uem9CMmNNOTlGVk1Rd2Jlc1doNDk2Vy9BVzM5SU5MUGNG?=
 =?utf-8?B?NC9aZElIUW5QU3UzVUhLNzlPM1MzT3lRenFVTVk4cERwNEY0c2RrYmo2NlBB?=
 =?utf-8?B?SWlMSzFRMFJtbVEyTlZ3TWg2KzBuei9YakVmSU1HOGxkVWljbFV2cFBTWDFm?=
 =?utf-8?B?ZGRHQ2NrMWhXV1Q0SXBhb0VPSVVhYnlibEo0b3kyRjBzYTRmUjRGcVVnQTJx?=
 =?utf-8?B?eXBvNWY1cFpzNFBvNzZndEVMMDBsN3ZEcXZNcHlLWXpmRDJVUzR5QTVvRUdE?=
 =?utf-8?B?V1Y0ZW13OFkwWUkwZklEQU83WHI2MXFIekxkVWRhVVIxRXRacWRuUy9YSjZi?=
 =?utf-8?B?aUNOcWdwUkpHbHIvdTdIVW5McngyaUIxUGFKU01GWENna1pBOURCMjVUS1pv?=
 =?utf-8?B?V1l4K2IzVWtSeTg1VVpHVnZnaTVxd1VtTXJ2RC8rejRSbTQzNEI4VENpRjEv?=
 =?utf-8?B?RllxSG5UQVZaOGdBNGt5RkNLZTl4K0Q4cTRHbXYrdW5MMVFiS1pmdVZCdFdu?=
 =?utf-8?B?U0M1UElvZE5DbElxZXFxNUpZUFVoa0Y4M3QwZmc5eGlGeTFOZGxUazNqMVc0?=
 =?utf-8?B?VTYrZkFlODNJYjdwcDdEMmttaC9ud2l3Z2drTEFWVXgvNGJidC84emRXUUsr?=
 =?utf-8?B?akQzOWM5QnZwUXJTSzlKc3BPMVZmdFpVallvUnZLc3VjQ013N2xsRmtveUdl?=
 =?utf-8?Q?qQXPHYuqepSb1tlnYfJhIKqqM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61ae40e-41b2-43ff-8562-08daed6efe91
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 09:43:40.2606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8UzCxScAWQn71sw2kN40vrnfiGHqHCwJbBizKPgw/ZowyJwqPEt4TH2psN8rSb8EP+PT+QZ6Ng66No9T7EO0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 29/12/2022 19:02, Alex Deucher wrote:
> On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This is a RFC series to implement usermode graphics queues for AMDGPU
>> driver (Navi 3X and above). The idea of usermode graphics queue is to
>> allow direct workload submission from a userspace graphics process who
>> has amdgpu graphics context.
>>
>> Once we have some initial feedback on the design, we will publish a
>> follow up V1 series with a libdrm consumer test.
> I think this should look more like the following:
> 1. Convert doorbells to full fledged GEM objects just like vram.  Then
> update the GEM IOCTL to allow allocation of doorbell BOs.
> 2. Store MQD data per amdgpu_ctx.

If my understanding of the comments is correct, we are having 
conflicting opinions here on where to save the MQD data. @Christian ?

> 3. Create secure semaphore pool and map RO into each GPUVM.
> 4. Add callbacks to each IP type that supports user mode queues.
> These callbacks should handle the IP specific MQD initialization and
> mapping/unmapping details including allocation of BOs for the MQD
> itself and any relevant metadata.  The USERQ IOCTL handler will look
> up the callback based on the IP type specified in the IOCTL.

Noted.

Shashank

>
> Alex
>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>>
>> Alex Deucher (1):
>>    drm/amdgpu: UAPI for user queue management
>>
>> Arunpravin Paneer Selvam (1):
>>    drm/amdgpu: Secure semaphore for usermode queue
>>
>> Arvind Yadav (1):
>>    drm/amdgpu: Create MQD for userspace queue
>>
>> Shashank Sharma (4):
>>    drm/amdgpu: Add usermode queue for gfx work
>>    drm/amdgpu: Allocate doorbell slot for user queue
>>    drm/amdgpu: Create context for usermode queue
>>    drm/amdgpu: Map userqueue into HW
>>
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  14 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 486 ++++++++++++++++
>>   .../amd/amdgpu/amdgpu_userqueue_secure_sem.c  | 245 ++++++++
>>   .../drm/amd/include/amdgpu_usermode_queue.h   |  68 +++
>>   .../amd/include/amdgpu_usermode_queue_mqd.h   | 544 ++++++++++++++++++
>>   include/uapi/drm/amdgpu_drm.h                 |  52 ++
>>   8 files changed, 1413 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
>>
>> --
>> 2.34.1
>>
