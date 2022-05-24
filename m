Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82604C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 15:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038C710E536;
	Tue, 24 May 2022 15:04:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF77F10E536
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 15:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYs948maG3hI86ukNSiJFV4K0WuahLJR3IJtmsEeBiKO9rUJ0CcaK3z2B/w0yY43ii1PzISSmW7RPoXAMnJX3yvN+OxVllxVTgGETCRh2HhANsq3lytcQg8FaXtoiXSfmPOwede6Dp9zNeAGPzG1QFGTCpds6m+JOy+ZWif/XjDM64tbZUGgzRvQytnmrP/QsqG7lGk30YPRyT5e0J5A0I+kqkezxd2ZeHj+ivqvoGGovYSy7wJ+BYy0l04rQthniVFqoKFLWDDPROKsEVQillj+lsh/6+E6ETKWZMw2FxcmD3sJ3IdFWkfslyrVQPqNMN+P0FXYUx+QUbmiikGyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVNnrKF2lRwjBd7c443XWu8tZDO6khBSG6sIFCLeIWY=;
 b=QxJo2wrpwLT06hXE1nKMCsJrsUEM0ktWlfiKUkZdIpcWuKK6AR2uBqceL9RR/W5yfCZULnjqw82oEumFaSr/yqSoHNAuGVD0wc59ZbHk/B0bm36b+ALwS4M+oT4/E52G8nzYaWN4KZMTEMajduH3l8X+DhFLl1toOC36rNaT1dr0NEe28CTSJ0kaBKVCendcfcBhtli4pqrO5TYig8hMiCAMyC2NPiD98ymN5b2IPi1wye5u0XRV3GhgMQVZuXHedx+IXlBtanfvwt51NZGWLNkPofZ2k85PUMNNi4k8XYz356ypW710aqorK2R3TzcbxSaV5QvWEFM2hfzfVapyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVNnrKF2lRwjBd7c443XWu8tZDO6khBSG6sIFCLeIWY=;
 b=lxT56jRn1Dk6JGcO4GzqEwL1SKdmaXmwtxcqJgz2qfzIpFJBGjBZqINlvnIeEPWN6r4PDGsldiVplSbs3trI1AC2j6FKqkv2/8m1winDVL4ExAmjagUYT59NfA9/eDPp2l95zHG0CUeUctgi6ceAfE7Jr6Tv3icIZzE7WAfFS3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 15:04:47 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Tue, 24 May 2022
 15:04:47 +0000
Message-ID: <ee0413a6-c1bc-f927-92b9-d5b0ae4499d1@amd.com>
Date: Tue, 24 May 2022 17:04:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
 <588a0599-7d0c-0041-9877-4429b416e7ed@amd.com>
 <18da952a-25d7-1d52-5d1b-016432066211@amd.com>
 <2e8b9ebe-3d1f-40e5-73e3-54607a8045cb@amd.com>
 <7cdad508-17b9-17b0-59f2-de0bf98ed780@amd.com>
 <ae53629c-7922-6a17-c162-e9397386106b@amd.com>
 <2fb3744b-f23a-ebaf-98a3-34b4eb12df80@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <2fb3744b-f23a-ebaf-98a3-34b4eb12df80@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0463.eurprd06.prod.outlook.com
 (2603:10a6:20b:49a::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f1c2223-ed82-4d51-8c3d-08da3d96bde4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4080:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4080A9A47ED49B910EA142F1F2D79@MN2PR12MB4080.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYEcQOFvKxJAj70y0TuG7AJa0eiS1y5NuWwlzt7tc2SdVd7N06f2KYshpZnB9R4sf9Yh1M/I4g41CXPSqzSB0sit6S9eUVuNrpr06e4wf8olWV5lA51Blh+EvRJCH7zp+pW1JZTFUm52/02+ee4GR15xbGHoFViniDHCM7OU8MEy5xE/QRXpkl7m6uvJvy+XQrcV1AQTWJvQ98eDrbS9hW9D3Wcbfg98aPqARXrsXIbbJMDTG6AqlFtEhFMH+TNUktV2S5nrpo0gnXmoM1zWptyfkWNOcJ7J7zNSBUx7aaau7Vu9AnsRUun8fRyPo3QOx7b8fo/diN1u1JPzAR2VPtQzNeCHyQD4O7QwSyF6XYzCHkTmtFquVecObu1wKq2rBsf4McOdtmk8OT6zq+JETiX66M1+lSECSKdO466wwlpZbTcaN+03bJMIih9+RNa4CS+0SVAly146xOshwn8nSr/77dVmRzBsqlGbHH15fVrYO3GT6gvHZwyD7DbqFVhm8vZBfTP1J+hris/+/ZYcWWTGKShAQB5dCRepPzibhs0/M874+IIPYBzSxwHhrTNm2n6Bi1ovr3jxt3iZZxqqJA2CSaPPRgjWF8Y+Bl49mYadMin9sr+rCOKwzD1/QXKx8/3tX7gQ46MZx+6TjCqifoYf7AcqysPnSGa2fWVAiHDnFy5o11DgoZBIFB8AC42pNZFM3YTfvsVucOgqNVwbQZixf8SwnBAc0ubbG0XpUhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(6512007)(31696002)(508600001)(8936002)(110136005)(36756003)(6666004)(31686004)(5660300002)(83380400001)(86362001)(66946007)(8676002)(66556008)(66476007)(316002)(38100700002)(4326008)(2906002)(6506007)(53546011)(186003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFNrZ2hnRy9FU2dhd3g0dmpJTEwvWG9oL1k2d1VsZnBYRFpwbzFFcjR3Q0NT?=
 =?utf-8?B?M2IxRUFHZXc3dW9iakN6dGJlU3pZU2dxWWFMY2VGR3BkeVBXeUlGVGxxR0M0?=
 =?utf-8?B?Y04rZ1VpcFk4bzIwejRMN3lyQkU3SkpxNUVEVmp0Q3pRT09uVnFQVVZONWdm?=
 =?utf-8?B?dExYMXpxN1lqeVJBeWUxY0RDUkYvKzFtVVBqTHladlJPMkNLdjRDdDhaRWdV?=
 =?utf-8?B?bFV3aTRScGJSVnJSVjVmR2JDQUZQLzR5RVdvc2liMmd3U0xJdW4wbkdIS2pD?=
 =?utf-8?B?MG9DTzRIeDJwK1A2OS9iTTcveXlxYVlGU0t5VG1xQ043VzZObStDMGlLcE54?=
 =?utf-8?B?d0JaYlJXR2VPUTRKNTVZeE5ZenRSZ0JFb3pKcEMraG9YOVR3c2NFcENTTzhY?=
 =?utf-8?B?dHJiYnNQeTRVQS8rVjAwTWM1TjZJZlY1ZzRETUFUR2pSL3E5N1RNdjA0YW9l?=
 =?utf-8?B?NjJyM2Y1Ni9wTHh4QUlrQlBlQlNuTEk0NWZZSlBZSzJsblhWci9pS2RaWUNv?=
 =?utf-8?B?S1RwOUxUMTJSaTNLQm5weXdmR3VIZ1YwTFByTDdWZEtRTHR6TTJ1V3g1NVRL?=
 =?utf-8?B?cDU5SjZYMVYwSVRLSjVhL2NidVQ0N0Fubnd0N29TQmQvbmw0aHJMalhhbHhD?=
 =?utf-8?B?Q0dxOVdPQXVMdEp4SWp5UnVRRk0xdXZpaXBWbGRhWVJVVk0renUvTk5GamZP?=
 =?utf-8?B?VDBpUVI0dzB3aVlVS1BmVlpBeFNJaGM4dGVOczlodEdXWFNHT1orTlAwdDlS?=
 =?utf-8?B?Zk1mREZoRTBacEdZWE9IdzREK1hGY1h2N2xCTWpaTVJxWUlGR1J0QmhTRTlL?=
 =?utf-8?B?S0psUjNxOTN5dHQrRGNKUUhlcGJYS3BSdUE3Rkh4K0R4NjJwblNyOTc5cVhF?=
 =?utf-8?B?c0pWTmJnQUFqNnNOQ0V3NVBrTmFvQmIxdGk2dUpQbENHTUFqSjA1WTc5d3VP?=
 =?utf-8?B?SVJzWUVqZjFqV2tyd2J3eEFoNGpmR2FGdkx4TkNKSkxkREVxVFZxQ0ExVHZl?=
 =?utf-8?B?T3ZNeGFLSHU4STBzTy84NTBVNmdEVGI1ZXlSaEJnVjlWM2szVFZFM2F3dmpY?=
 =?utf-8?B?aVdmS2NFY3dxREtkcDUyajRkaWVvd3ZPeTdIRFdmQTR4RUVYVGJhTGQycFFp?=
 =?utf-8?B?eVAxVDZyZENtMStFU2xHMzZQci9JMjVRY3dnTzNBbGRHdTY3aDBheXRxWnF5?=
 =?utf-8?B?WGJoRG90TW9lT3NxK3hNRHlzZnVtZXZXc1ExWmVvYWNHeDFQeS9YYmQra3ZB?=
 =?utf-8?B?U0diWlQwSDZ0b0VwZDVTc3cxTndHMVdFSjN4bEx1T05lVVZ3Y1FwME9VQlc5?=
 =?utf-8?B?MUxCcXoxcVI1VTBFaEhwa1R5S1pma29XZGpiTThsb293MnRpZklFcnVnQ1Rv?=
 =?utf-8?B?bjE5TXdRTlVrNGxRZ1J0dkI1dXZHdEdtTlRjMUtMR08yMFZjdFkzazcrSUEw?=
 =?utf-8?B?RnFrb2h5Yk5aZlY2R0xkQXNnZVBQdHJSVitHVVkrYWZOeWxPamlHSy9KNWNq?=
 =?utf-8?B?WUNWL0xyRGY3aXpNNFdnRUU1YVdqMGg5MnU3ZVNDMzQzcjRBT0g4U21HSk1a?=
 =?utf-8?B?QjQreUpaQjlJemNXSHpsQXJibjB5Y1FiNEV0Y0tCZWdRQzFTbzFnTklBWktm?=
 =?utf-8?B?R3NsUHFKWlpzajhkY2FiaEUvZzhXeDNFbEJPZUc4QU1NcU5SU1IxWUtSU3RB?=
 =?utf-8?B?UjRHanV2a2IxKzFTT0ZxOGpzUWxGN3l6Z3NsREM2bzZLbllqenFhbm1adnhw?=
 =?utf-8?B?K0p2S3kvbzdXOVpEVC8zdGZrN0lRaG53TUhaT1FoVVB3d21BckZ3QVU2ajZX?=
 =?utf-8?B?c2RPSGJrWnNYNlk2dmpRVTZTcXNOdmE0TUJJV1JOOW1ESW9jRWpFM0h1Z3Zn?=
 =?utf-8?B?WnAyWloybCtyWlYxQW1FYTVEdlZhQk5VS05Tck9pYitXdHhMMDgwQTRGNVRV?=
 =?utf-8?B?cC9maGdqSW1NN3hFaFRLWjRPVnQwM09HaU82dWRKR2NKdHY4eFZySmltQW5k?=
 =?utf-8?B?bFh1dnlrSnIwNkxuMTlOeDgyRVZvQ1ZVb3dPRkVEdU1PQy84T0JIOHRBWStZ?=
 =?utf-8?B?ZzBIaCsxTnBJbEZ5RnUrNHBrRkFIZXdFQWhmM041dk82U1kyL3d2cGFRV0pX?=
 =?utf-8?B?YzdkNU44VEM5MXE5U3NrdXdwVFdINy9ETUdHQUxhd2dMUlNBUFpmYVdrUGFV?=
 =?utf-8?B?dGpEcUNZa3NoTmNKbk81dHZ4SG9MOHJIa2dWVXh5VFYwL2JhWFduTHJHdTAw?=
 =?utf-8?B?L1JJVjRJWXdzNjhEekdrVFJjcWZ6QU0zd1NobzIveEN5RmNoUXZQWG9YUi9B?=
 =?utf-8?B?TlNmdUFURmxONVllMDhRRU9EcUtPOVc0dDBJcWhZTERsRVpVbDZWTjczRFov?=
 =?utf-8?Q?EJXEDYr71svAkPxQvyJdb/xm46XUk0uHEdh82+fNkNeQn?=
X-MS-Exchange-AntiSpam-MessageData-1: Y9rHdDpE7qVSFQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1c2223-ed82-4d51-8c3d-08da3d96bde4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:04:46.9575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKxyCK9XeGX/IFrcfdhtHeTb2G2sGcuSioyc5BN4NiuHrRO6OI7u/S9PVZzBTYne5uea9vNK4tcatkViglttsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/24/2022 3:18 PM, Somalapuram, Amaranath wrote:
> 
> On 5/24/2022 6:20 PM, Sharma, Shashank wrote:
>>
>>
>> On 5/24/2022 2:10 PM, Somalapuram, Amaranath wrote:
>>>
>>> On 5/24/2022 3:23 PM, Sharma, Shashank wrote:
>>>>
>>>>
>>>> On 5/24/2022 8:42 AM, Somalapuram, Amaranath wrote:
>>>>>
>>>>> On 5/20/2022 7:52 PM, Sharma, Shashank wrote:
>>>>>>
>>>>>>
>>>>>> On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
>>>>>>> Added device coredump information:
>>>>>>> - Kernel version
>>>>>>> - Module
>>>>>>> - Time
>>>>>>> - VRAM status
>>>>>>> - Guilty process name and PID
>>>>>>> - GPU register dumps
>>>>>>>
>>>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 
>>>>>>> ++++++++++++++++++++++
>>>>>>>   2 files changed, 62 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> index c79d9992b113..f28d9c563f74 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> @@ -1044,6 +1044,9 @@ struct amdgpu_device {
>>>>>>>       uint32_t *reset_dump_reg_list;
>>>>>>>       uint32_t            *reset_dump_reg_value;
>>>>>>>       int                             num_regs;
>>>>>>> +    struct amdgpu_task_info reset_context_task_info;
>>>>>>> +    bool reset_context_vram_lost;
>>>>>>
>>>>>> How about drop the 'context' from name and just reset_task_info 
>>>>>> and reset_vram_lost ?
>>>>> OK.
>>>>>>
>>>>>>> +    struct timespec64 reset_time;
>>>>>>>         struct amdgpu_reset_domain    *reset_domain;
>>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 963c897a76e6..f9b710e741a7 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -32,6 +32,8 @@
>>>>>>>   #include <linux/slab.h>
>>>>>>>   #include <linux/iommu.h>
>>>>>>>   #include <linux/pci.h>
>>>>>>> +#include <linux/devcoredump.h>
>>>>>>> +#include <generated/utsrelease.h>
>>>>>>>     #include <drm/drm_atomic_helper.h>
>>>>>>>   #include <drm/drm_probe_helper.h>
>>>>>>> @@ -4733,6 +4735,55 @@ static int amdgpu_reset_reg_dumps(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>       return 0;
>>>>>>>   }
>>>>>>>   +#ifdef CONFIG_DEV_COREDUMP
>>>>>>> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
>>>>>>> +        size_t count, void *data, size_t datalen)
>>>>>>> +{
>>>>>>> +    struct drm_printer p;
>>>>>>> +    struct amdgpu_device *adev = data;
>>>>>>> +    struct drm_print_iterator iter;
>>>>>>> +    int i;
>>>>>>> +
>>>>>>
>>>>>> A NULL check for 'buffer' here could prevent a segfault later.
>>>>>>
>>>>> Agreed.
>>>>>>> +    iter.data = buffer;
>>>>>>> +    iter.offset = 0;
>>>>>>> +    iter.start = offset;
>>>>>>> +    iter.remain = count;
>>>>>>> +
>>>>>>> +    p = drm_coredump_printer(&iter);
>>>>>>> +
>>>>>>> +    drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
>>>>>>> +    drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>>>>>>> +    drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>>>>>>> +    drm_printf(&p, "time: %lld.%09ld\n", 
>>>>>>> adev->reset_time.tv_sec, adev->reset_time.tv_nsec);
>>>>>>> +    if (adev->reset_context_task_info.pid)
>>>>>>> +        drm_printf(&p, "process_name: %s PID: %d\n",
>>>>>>> + adev->reset_context_task_info.process_name,
>>>>>>> + adev->reset_context_task_info.pid);
>>>>>> Please fix the alignment of print variables.
>>>>>>
>>>>> I will cross check this.
>>>>>>> +
>>>>>>> +    if (adev->reset_context_vram_lost)
>>>>>>> +        drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>>>>>>> +    if (adev->num_regs) {
>>>>>>> +        drm_printf(&p, "AMDGPU register dumps:\nOffset: Value:\n");
>>>>>>> +
>>>>>>> +        for (i = 0; i < adev->num_regs; i++)
>>>>>>> +            drm_printf(&p, "0x%08x: 0x%08x\n",
>>>>>>> +                    adev->reset_dump_reg_list[i],
>>>>>>> +                    adev->reset_dump_reg_value[i]);
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return count - iter.remain;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void amdgpu_reset_capture_coredumpm(struct amdgpu_device 
>>>>>>> *adev)
>>>>>>> +{
>>>>>>> +    struct drm_device *dev = adev_to_drm(adev);
>>>>>>> +
>>>>>>> +    ktime_get_ts64(&adev->reset_time);
>>>>>>> +    dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
>>>>>>> +            amdgpu_devcoredump_read, NULL);
>>>>>> instead of registering NULL as free function, I would prefer you 
>>>>>> to have a dummy no_op free function registered, which we can 
>>>>>> consume if something changes.
>>>>> you mean something like this (function without any code):
>>>>> staticvoidamdgpu_devcoredump_free(void*data)
>>>>> {
>>>>> }
>>>>
>>>> Yes, precisely.
>>>>
>>>>>>> +}
>>>>>>> +#endif
>>>>>>> +
>>>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>                struct amdgpu_reset_context *reset_context)
>>>>>>>   {
>>>>>>> @@ -4817,6 +4868,14 @@ int amdgpu_do_asic_reset(struct list_head 
>>>>>>> *device_list_handle,
>>>>>>>                       goto out;
>>>>>>>                     vram_lost = 
>>>>>>> amdgpu_device_check_vram_lost(tmp_adev);
>>>>>>> +#ifdef CONFIG_DEV_COREDUMP
>>>>>>> +                tmp_adev->reset_context_vram_lost = vram_lost;
>>>>>>> + tmp_adev->reset_context_task_info.pid = 0;
>>>>>> why is the PID hardcoded to 0 ?
>>>>> in case of reset context reset_context->job->vm  is null 
>>>>> (possibility that reset can be non VM related).
>>>>> If we don't set tmp_adev->reset_context_task_info.pid = 0, it will 
>>>>> show previous reset valid PID.
>>>>>
>>>>
>>>> But when the VM is not NULL, are we updating this PID somewhere ? I 
>>>> did not see that happening in this series.
>>> This is the only place where PID get updated.
>>> For example sequence of operation like:
>>> 1st reset:
>>> -valid VM and tmp_adev->reset_context_task_info.pid is set to some 
>>> valid PID
>>> 2nd reset:
>>> -invalid VM
>>> -tmp_adev context will remain same (adev context will be same after 
>>> successful  GPU reset sequence).
>>> -tmp_adev->reset_context_task_info.pid will be holding 1st reset PID 
>>> value
>>>
>>> if we don't set it 0, it can give wrong PID.
>>>
>>
>> I get your point, and agree, that when the vm is invalid, PID is 
>> invalid so we should send pid=0. But where are you handling the case 
>> when VM is valid and pid is valid ?
> valid VM check in the below condition:
> -->if (reset_context->job && reset_context->job->vm)
> reset_context->job->vm->task_info will have the required information.

And how will that reflect on tmp_adev->reset_context_task_info.pid ? The 
point is, if this parameter is being set to zero, means it is being used 
somewhere, so when and how will this become non-zero ?

- Shashank

>>
>> - Shashank
>>
>>> Regards,
>>> S.Amarnath
>>>>
>>>> - Shashank
>>>>
>>>>>
>>>>> Regards,
>>>>> S.Amarnath
>>>>>>> +                if (reset_context->job && reset_context->job->vm)
>>>>>>> + tmp_adev->reset_context_task_info =
>>>>>>> + reset_context->job->vm->task_info;
>>>>>>> + amdgpu_reset_capture_coredumpm(tmp_adev);
>>>>>>> +#endif
>>>>>>>                   if (vram_lost) {
>>>>>>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>>>>>>>
>>>>>> - Shashank
>>>>>>                      amdgpu_inc_vram_lost(tmp_adev);
