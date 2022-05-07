Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EA3C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  7 May 2022 00:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3758710F146;
	Sat,  7 May 2022 00:03:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885AF10F146
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 May 2022 00:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCF0mrqWF/p+ysqz35JXbjWVRwnE8NGfUjRWRgsmnYrvEwd4/uvh3OUa8g5txRCtcx17r0QWRlicqhg79YTWjflVuZjpBYQfvFjuAV2NOwDvwktgjOhAQDNC21+3rLrzFYqXeb7k9BF5UBeSm+es9G6nvMHZWyoKMfca63gGc01DKld6o8kcbNvPfQiVIxvrejKc/23K6MxWB4vmbnYGFH7mjyPWA2SRoAHvRq9ZnO/uTGakPZePkl8NSUCHQqD7MdC5zBzl0SVuYQcZbFGFRlTcofo1vna/qDq2BM8qEvFgptQUb1h1oN467gi4o3n9Ge56qpRMgaKLOodGvzZ07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG8sdZVeyxkmGSi97sbLwvOTXZn1Tw5uWlZW1V+t+mo=;
 b=QRh1mAsHhMiYJ27UpXVNaU/74avB8tBRvMVkMtLoz1hzSQXORupoK6pQHOvc0I1tCew5GijN/S7fgGV0qtfMO2uWUt6vFgYgLQuHhHdQCVzr/VccCBJjpGbCuESSWYWmB4ZzmASW6aRH4o14VJH3XFZWlaADCK+QqXbqyshmMdYMoBuWnhkn/7NhR6qE/CtRDMy3gBU+036kZDWBvy7rtLNM04g9KUGJVeJ3Q5dXvuIF9TkEQ1YNnCoBnOcA3Q4ZULkRxufIMoH3Wd1P5gdc7SRITLn6iNq1U3ETLJli2fG5Uxzy2tbz0J4deS4d1FQLxSIiHjq95lKQudMNVqGc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG8sdZVeyxkmGSi97sbLwvOTXZn1Tw5uWlZW1V+t+mo=;
 b=5bqtMNh+HJMftdN15jSCsmy/1IL2gMhgWAe3ApqABgff+h/dZmCRz3ZNfYweHj0piTz3zU7JrwveuMTaJ4GFS3JwWZFEHSfs+NEjWAVmj5xdqpoD2PotyiF5302syZRrd46rIIBtKMsQlyXEGizeIDQhZBv1O3DlnCD4Rp9D2vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CH0PR12MB5249.namprd12.prod.outlook.com (2603:10b6:610:d0::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Sat, 7 May 2022 00:03:07 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2%6]) with mapi id 15.20.5206.025; Sat, 7 May 2022
 00:03:07 +0000
Message-ID: <85a04aff-ba3f-4c5e-e5e8-fc37afd10a53@amd.com>
Date: Fri, 6 May 2022 20:03:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/8] drm/amdgpu: support mem copy for LSDMA
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
 <20220505200406.1293467-3-alexander.deucher@amd.com>
 <ac0c55f7-20ee-9cf4-f52f-1a168cc4e8f8@amd.com>
 <CADnq5_OZE-vum4V7UJMeyZNJDj8gqgcSK1FJiF0LrR2s6dRd1Q@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_OZE-vum4V7UJMeyZNJDj8gqgcSK1FJiF0LrR2s6dRd1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::9) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7d9cf34-b1ff-42a8-c7ab-08da2fbcf6e3
X-MS-TrafficTypeDiagnostic: CH0PR12MB5249:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52498E57665C8466653C714A99C49@CH0PR12MB5249.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MThr158yhT8brLXdhhG8Bqs+HJj1oSsietUGyqcGRK5ybZCQc/qY+d2yNbmI0HYJq/DtpxiuZYFdRIH7SIdYf6ewZpKoNzv9jWqDA49vDC6Rck4mEFvV3y3nrKhV0z1uoNa5Mu+H5MqRDRLR3MzTLziuEzWru1EO4BpPSfpwVORkTaAbcgwlKrWIjhigNWp2jRLe+/9PXkytpnBd2ROwEVFWQNPlTSvAErobUOBA68YOj0l49NaZ8eY8XJk93GpUCOfe4VMQkAGbkL5uW4FU5M5DgF8pI9PqAU2OFQ88StqOWvnsfc+X730Uo/D3gBAx1ay9BHKfl+oJCliTmLWHs+KbjBCLsyIPmgxQUCWvSYMt8a1JzLKlT739VjRl9NxBiSR+NMrM0S6f1fFVvuuKdKyxSUaL0/uH4mFJwjXydplGYV3GrbtXwsdKaukz62TOVVc60+Of2k2flQMmHa/QEpy+y0VTkWWFWTrXhoO1Sg3OuxTLQHGsS288WGDQ827DMXZt2igAi6xpTNFiS8CReT+c9XKzn6vHGEPF4f+2P10TjKJwx/+WcITgO8Fanju/xYRCDmGYSySHkP3rpCTDmsnf5v69gv2auLSjwGKTQLhZvbwsjP9hWFtuJ7VdNOLc2OxjzrnucRgYP0K3uxtL7h5YmLpdkrOVAXYOAnO01Mcl5v+KM+FEs5oFoiIhI3dB5+94thbEva2BuFAWlhcyvYmgzoTxOskkh+6otmpfJ+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(36756003)(186003)(31686004)(5660300002)(508600001)(6512007)(6916009)(316002)(54906003)(4326008)(66556008)(66946007)(66476007)(38100700002)(2616005)(6486002)(8676002)(31696002)(86362001)(2906002)(83380400001)(8936002)(6666004)(53546011)(44832011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC94dVcxWGhqQlcxL3lhOGtucTFQaWVVUWZkWXBmK1p3ZHplZXhTazhVVXE2?=
 =?utf-8?B?bW1aSmE5bVhTRXF4S09KeUdXb2M2eS9hR0lzMkRjSXZOWTZVbnR5UmloSXhU?=
 =?utf-8?B?ckRaNzZQQmJVNmFBMWRCQ3V6bE9yb3ZiRkR4bGE0NlMzcnY5dHBkNS9PaWND?=
 =?utf-8?B?OGM3R3FNSHQvVW5BZE5aY3o0Q2V4bkkraVc2L3VaOHNBVmlmOHByYS96SW56?=
 =?utf-8?B?TVE4eG8vZVJxVUhiL3g5VTlsb0lFVFdJd0tlOW8zRGNNeEcyZ1ZWTGJaVld6?=
 =?utf-8?B?TEdBYkRJUGo3Zy9Ba2pyRmR6UUllVzdEQWg1a2VtOTNVeE9IeUxvdHFOS2Vu?=
 =?utf-8?B?cnRpN0o5OWxyUjErTU5DZXhzZm1HUjEwdGF1T1Y0WVAwK3hwS3BQcERNejBa?=
 =?utf-8?B?NlVaRktEZUtTb3lCeFBCRUUzSTNIQS93YWthS2hXMktldHJHYjVzSGJjWGh5?=
 =?utf-8?B?aGRkQ2ZCRnl3UTdMNVNVNG1KK0xWMlZTZlFkR1hrTkd2ci9TeG01ZHZJY3Ba?=
 =?utf-8?B?R1RnVzZXbkVvL01WVEo2T29HRXVzTmJ3U1l4aUllVDRkZEI0NDlSRmV1Um9S?=
 =?utf-8?B?S2k2OXo0b2ozelBYWVlxUmJUNlJmKytETmJra2x1THBINVNudFYxWWdaclBh?=
 =?utf-8?B?UjZUaVRLSzRVZVJOOVlGa3ZqOVhVdkhYZWFRSmtHTGcrMUo2anllYkE3VXdW?=
 =?utf-8?B?WDNvcnJRWnNQU01sNjVmSjdrdHRMSWNlTVNsczlUaytZWXNtR2RqL2pYVXEr?=
 =?utf-8?B?RlVJREpWSWFRa0wxbm13cFlSZzIzbk9icFhzdkttVmorLzlFb2JuaVgxOEpQ?=
 =?utf-8?B?b1FRVWFwQnVpeXdxRWRtVm5VQmhUS0FNWmNMMCttbHNnUWpBNUMwVURtT0Y2?=
 =?utf-8?B?S1l3MWZJQWU1REZ5ZkJPWHhkTm9xb1ZMUm9Zc3dDZXAxS0xqaS9PNXhielBh?=
 =?utf-8?B?bk9BUzcxVGtOM29ZeEs2Ujc4OVZ2eDUrVFNTeExtWVBzV1BlTzg0U0xzQVZX?=
 =?utf-8?B?Z2k4MkNDUUNCVVZwazVRLzhzRXNzQk8zTzMvbUswaW1oaElPVUtLVUFERmx0?=
 =?utf-8?B?MFBMMitUdGhFRjgzOTk3SjZmdnZwbmkxODRmbmJScEpCL2lvbExnd1M1ZkRV?=
 =?utf-8?B?UlpjRXhlY2wrcTRwazAwRVFqS2xPWE55a3FkODBvR0VEK1JWZ1h6MEZJUnhk?=
 =?utf-8?B?RjdBQklDVVNDNVY3UGVBTzMyRkJHekMxSUlyTDBENGRQdlVNRnFJbHVBRjZ6?=
 =?utf-8?B?VHM3ZVRTRUIzL2U3NTBnajBzdytha0tQcTkray91TVg4RHRnYjRFbWhUNDgw?=
 =?utf-8?B?WHkrYjZkRUo2dGZYTnZnc20yL2pSZU5qbHQveGN4cUJncmUxQ1Y0eTVjamh2?=
 =?utf-8?B?ZDRWVjRoMm0zbkVDRjByOXN5VURPWFRaS2hiR3hJdW1BZENSSzBoR2xCL1pV?=
 =?utf-8?B?ZlQ4U1k5MkxJZkJVemM3VVJyYUZhak9QWGROYldtcmh3T0kybzhGem1EcHNH?=
 =?utf-8?B?eDBFVlNWNVAvc0hqem9FZW5MNllCZ3pjT1ZRVHQ2Zmw5QjROMmlLSDNuN3BH?=
 =?utf-8?B?RVp5S0ZDbGVUb3lvUU50bzB1R2hwM3E2S1dGTHZMd1IvbDBBVU5kOGZ5UE5X?=
 =?utf-8?B?VDlsOVllYnpBdGVRSkg5WlBKVFp3RDJYSm1XYWdoTmkxRU1ReXZwd1NSbG5r?=
 =?utf-8?B?NmdURmJ5YzBaaWtGRGZpTEF3b0xZTDVrbkxpSER0bEFDTFVoV1BFYktBNUF3?=
 =?utf-8?B?bWFRSFA1bmNLTGhHV1RIMm9HMFI2M0s5VGNFNmxYa1JGWlo0eFhKUTUzaDNn?=
 =?utf-8?B?elo4blgwVmdhQkxiaWp1Vzkwd2dNOFdwemgvc3VUcWZEYmZjQVJLdGZQQzRx?=
 =?utf-8?B?OUhtU0tMZnoySkFwY0I4dFkvVm5PbWdkcTQ1MjBNN0M1dnBkeklySE1Pb0RQ?=
 =?utf-8?B?cWNBN1M4cVRQa1J3WFhZeWZwQXkxcThtenMwZURqS3diaERvMlZNTU52d1R5?=
 =?utf-8?B?Z0pVYkdyTS9BbGxBd1hrQUxBVlVWeDgvSFFmNno2NHEvL0Nxb0pqOFRGK0pL?=
 =?utf-8?B?WUdVWnF2aXJtUFprRlNlbnpkNSthUDFrVnh6MS9wSjZaQzRic0g3M3VkV0ps?=
 =?utf-8?B?REQ2SzdQbVFORStIMlpTVzY2YjNPSGFrOVQ0TGszc2dYdGtXOEJkNDBUK2Vk?=
 =?utf-8?B?d0d1Zy9mUW1sTkM1N3pYOWlCWVREQUtHaXNITkZnMGcyRE9nK1RzZll6WkQy?=
 =?utf-8?B?dGJCbyt2T2RtNHJSOG1jRm0rbmFsZDZOYlhtbnBXWW1FdDZQODVQc3huc2Vu?=
 =?utf-8?B?RDgxZjFWLzBydWNzTTNGaC83U0IvSUF3UlphaktXbmdZZUtYM0JMdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d9cf34-b1ff-42a8-c7ab-08da2fbcf6e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 00:03:07.1482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezO427YjfAZaD+dexxVD8ItDVfdPzzpZ91UDaj5zAmfCmsmFTz+XdkPF7ZEpnQ1R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5249
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-05-06 10:22, Alex Deucher wrote:
> On Fri, May 6, 2022 at 1:02 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>>
>>
>> On 2022-05-05 16:04, Alex Deucher wrote:
>>> From: Likun Gao <Likun.Gao@amd.com>
>>>
>>> Support memory to memory linear copy in PIO mode for LSDMA.
>>>
>>> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c | 26 ++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h |  5 +++
>>>  drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c   | 44 +++++++++++++++++++++++
>>>  3 files changed, 75 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>> index af00a66f8282..3f1c674afe41 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>>> @@ -23,3 +23,29 @@
>>>
>>>  #include "amdgpu.h"
>>>  #include "amdgpu_lsdma.h"
>>> +
>>> +#define AMDGPU_LSDMA_MAX_SIZE        0x2000000ULL
>>> +
>>> +int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev,
>>> +                       uint64_t src_addr,
>>> +                       uint64_t dst_addr,
>>> +                       uint64_t mem_size)
>>> +{
>>> +     int ret;
>>> +
>>> +     if (mem_size == 0)
>>> +             return -EINVAL;
>>> +
>>> +     while(mem_size > 0) {
>>
>> Kernel style requires a space after the "while" and before the "(".
>>
>>> +             uint64_t current_copy_size = min(mem_size, AMDGPU_LSDMA_MAX_SIZE);
>>> +
>>> +             ret = adev->lsdma.funcs->copy_mem(adev, src_addr, dst_addr, current_copy_size);
>>> +             if (ret)
>>> +                     return ret;
>>> +             src_addr += current_copy_size;
>>> +             dst_addr += current_copy_size;
>>> +             mem_size -= current_copy_size;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>> index 4df4da423181..be397666e4c1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>>> @@ -30,6 +30,11 @@ struct amdgpu_lsdma {
>>>
>>>  struct amdgpu_lsdma_funcs
>>>  {
>>> +     int (*copy_mem)(struct amdgpu_device *adev, uint64_t src_addr,
>>> +                    uint64_t dst_addr, uint64_t size);
>>>  };
>>>
>>> +int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev, uint64_t src_addr,
>>> +                          uint64_t dst_addr, uint64_t mem_size);
>>> +
>>>  #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
>>> index b611ade53be2..0d2bdd04bd76 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
>>> @@ -29,5 +29,49 @@
>>>  #include "lsdma/lsdma_6_0_0_offset.h"
>>>  #include "lsdma/lsdma_6_0_0_sh_mask.h"
>>>
>>> +static int lsdma_v6_0_copy_mem(struct amdgpu_device *adev,
>>> +                            uint64_t src_addr,
>>> +                            uint64_t dst_addr,
>>> +                            uint64_t size)
>>> +{
>>> +     uint32_t usec_timeout = 5000;  /* wait for 5ms */
>>> +     uint32_t tmp, expect_val;
>>> +     int i;
>>> +
>>> +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_LO, lower_32_bits(src_addr));
>>> +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_HI, upper_32_bits(src_addr));
>>> +
>>> +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(dst_addr));
>>> +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(dst_addr));
>>> +
>>> +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
>>> +
>>> +     tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
>>> +     tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
>>> +     tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
>>> +     tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
>>> +     tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
>>> +     tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
>>> +     tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
>>> +     tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 0);
>>> +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
>>> +
>>> +     expect_val = LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK;
>>> +     for (i = 0; i < usec_timeout; i++) {
>>> +             tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
>>> +             if ((tmp & expect_val) == expect_val)
>>> +                     break;
>>> +             udelay(1);
>>> +     }
>>
>> Does the hardware specify a minimum delay after the write to the LSDMA_PIO_COMMAND,
>> and before we check the LSDMA_PIO_STATUS?
> 
> I'm not sure, but it should be pretty minimal.

My point is that there should be a delay at least as large as the polling delay,
after writing to the command register and before reading the status register.
So that should be at least a 1 us.

There should be a udelay(1) after writing the command to the LSDMA_PIO_COMMAND
register, before the for () loop begins.

Regards,
Luben


> 
>>
>> At the moment the code above checks the status immediately after writing to
>> LSDMA_PIO_COMMAND, and the copy wouldn't be completed.
>>
>> If the poll timeout is 1 us, as the loop shows us, maybe the command completion
>> is larger than that (the time after writing to LSDMA_PIO_COMMAND and before
>> checking LSDMA_PIO_STATUS)?
> 
> The time it takes for the copy will be dependent on the amount of data
> there is to copy.  While the command is probably not complete on the
> first read of the status register, it may be required to make sure the
> previous write goes through.
> 
> Alex
> 
>>
>>> +
>>> +     if (i >= usec_timeout) {
>>> +             dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
>>> +             return -ETIMEDOUT;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
>>> +     .copy_mem = lsdma_v6_0_copy_mem
>>>  };
>>
>> Regards,
>> --
>> Luben

Regards,
-- 
Luben
