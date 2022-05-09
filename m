Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FCCC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 14:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5014A10F0A2;
	Mon,  9 May 2022 14:59:40 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F81710F0A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 14:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXpFAHaFRq+Zwr4ZxBvqrBrv7uWgC9MOLLvcEoCPnSLEoq1rHvhWJuDXTnmZMrk9WY8MAPfaIJi1OgArFr8XE2GFpaB2LBVGXtfL6BvnrGgsvE/eRmWnbrPK4HQecd5EhoPFbXayaK7jstST2dDt9EydN9ad0qiKu5SFwXXf+oERS2MT2/PYFP1F870zmYl3yjmPHdBqc22LT98qH1zgHftYOtVWQRBMkBlCTmoUnwWC1MSJEyfbcgXI3b63eZ3T5Tu6NVQyHn83r0od+PYwX98aVfc3gW9C1tOXQ5Cz6dCXwoAP1twOYFUg+GfEuc1nG5RUWxi9NpTcJ2p3qaqwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6gdtMVsBBTkqdoJCx6APJPzhvKHuauTS8ZN6uzZgdU=;
 b=eGdWphwsxwsB1kHR5mGnqIvaU/Zz+Oov72Aflh3agIZU3blnKxjmLk17hvJg6d7BqCAY0hXwYqKIltmPrbvUw35ZtW5/RS8jvXbX68MmuARjl8aV+kenA5fYJ2iqfXdgRh6QmLCvm8EX5Kds0rRx0z5/6bTj5/QYqV20ehiT317fGdCSMME9L8Ay4r3UzJ2EeQbcYLzphrH1B6YShJ1o+fp9OQk1vPlyOhB0IVLagsk7W1v2CAPUx/V9Fwcon5SU833jtqICCZWWOZMcKBVdvjdfUAFg6iGoLQVmJ8PpOqRQFyn4+9UHSSjIRLfRNXdEuNy16MdrIBCiKpy1+Yu80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6gdtMVsBBTkqdoJCx6APJPzhvKHuauTS8ZN6uzZgdU=;
 b=37eJOTInSmLSQ/wdTk0SaSJubHIdtgn1S5zPHXWgAsgaHeXBCcdMS5QOqVNuMsHFLFI5RDc2IuinxJ+HdEpbrBzZkBa3Ppf/1Vo7wt496ufgorcR/jA33Wv76d+kGCusKRYUrmzG4gSf4rRSijVEvO5pxInBn2c3QSKWyJjvFIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MWHPR12MB1646.namprd12.prod.outlook.com (2603:10b6:301:10::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Mon, 9 May 2022 14:59:35 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 14:59:35 +0000
Message-ID: <e0f609d3-b99c-9d02-4930-fa23103ec9e4@amd.com>
Date: Mon, 9 May 2022 10:59:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/8] drm/amdgpu: support mem copy for LSDMA
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
 <20220505200406.1293467-3-alexander.deucher@amd.com>
 <ac0c55f7-20ee-9cf4-f52f-1a168cc4e8f8@amd.com>
 <CADnq5_OZE-vum4V7UJMeyZNJDj8gqgcSK1FJiF0LrR2s6dRd1Q@mail.gmail.com>
 <85a04aff-ba3f-4c5e-e5e8-fc37afd10a53@amd.com>
 <6030d00c-0f90-612e-aeff-a5b696bc78f4@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <6030d00c-0f90-612e-aeff-a5b696bc78f4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::6) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89d79e16-0a66-4647-8f9d-08da31cc87df
X-MS-TrafficTypeDiagnostic: MWHPR12MB1646:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB164659415DD92F5E623D202A99C69@MWHPR12MB1646.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3w85qkfepIB7hbPs8MD8vNUX0PNKFHInceoXUyuclGQfYH8iTZHbd9jzur/26W/XsMc42DIcXXIhIvfTKMfz+jlzDQEvTqew2JnnDVipj+J0wJog7dADH5bBjTOUX3R6J50qFWEsQw2isacAJRiqRsmmH62vNa056KCOfqHhz6wo3Ja5O+L/A7wJeKZbSluPUBIY+ZLf/ewZg7KcezpKwXLaVCnvmxOf7eR2Ko2tRcxaAkbz/nVjBUZfgdqfjt40kkZ/R84CC1285MI8qvIt6FtiSYnNrBCPr3MqVXyKyoVNSvoX7NWC4kfbyd9p9EIJTlJzLaTVreAQzAQIyr7/6nyGnL4Ww1DG8EFEEhXUnNN+W1qLBLkqnMnGfi3gDDJbTsWMMIi2VNFiWoYqW51UVOS8ymwJOZMb14Uu6NumEqsk2Tu6YE4eH0RJq5INz/UXu1ob6l+6AARCf6kNGdbCug9fNc/uHZ7wl3Aucox2W9OBwdGcRWBYp098r+tfN4tiwXf1VkPW/9IHY4vSBgr0ICmaiUyxLjboM4M2D/wMf/S6ccH+O3R3a22Dt9YF2em32Y2iq4ulF6e2K5sNKV1VPhSBdvArrC8twaW8OR9/79lX3csPmxWVJ3NzQW1k+qCO0D+OlhPgkJR2I+mHFxIvRjydkRxbr+YeSNB+EJePtpcP2jbaRjZW/wE3qhZSAVbqhh/qte9Ve4oClrHUMOZ7lOzb3ok4X619kQ6o/cwoTQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66476007)(2616005)(66574015)(66556008)(66946007)(31696002)(186003)(83380400001)(508600001)(4326008)(6486002)(26005)(86362001)(6512007)(6666004)(316002)(54906003)(110136005)(6506007)(53546011)(8936002)(31686004)(2906002)(36756003)(44832011)(5660300002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnM4bStOeVZ2Sk05UmorYmNiY0NYOERabmFQUmg0dTh2QVlWTnpIMXVXYTFI?=
 =?utf-8?B?QkpGaFVzbFQ5M01xQXJXdzgvTGRCMlovNnkzemxNL1g5R1dBK1laSVFRSEdp?=
 =?utf-8?B?VmdoZHdtWERYeG5kTEtlVG1jcFpqMDNuNHd5YmNpNlAvS0NnZFhxazVxVjJj?=
 =?utf-8?B?dzdhY0xBZGVJUFRFM3VGcTFwUDBFREs3YVd2VmZxVnJFMG0raTZOeDZzZC9F?=
 =?utf-8?B?cEVJZVIxR0M0WFhRNURId3NaOHpRLytKTEZYVGN5MW1kQldGbjVxUHYybjVw?=
 =?utf-8?B?WXdrRXIrcVRmSWZJa0RKZ2U5WGEzdXc2MkxvWWRjamx0WXEra0hkRW1EWUE0?=
 =?utf-8?B?OTVqdmtMN2VLbmhRSHNwcnZLNkI1OEZ6TWY3YTJ5ZEZWL0NzRzNtSTJibno4?=
 =?utf-8?B?NW9vby9VNkxGVWNtUEUwT2VkSTRWeEl6RGhoeVNWNTdpMW9MZzVockVsY05r?=
 =?utf-8?B?aVNOYVRsRnF6VWt4Z3BpUndkeHI3YU1yRFA1MC9EaVhubk1HL2x4U1pmSVZ3?=
 =?utf-8?B?OU9lUEdEY21iZ2l5V25ZeWUydlJLZzcwNk5nenBrUmRqYVgzZDZtMHQxV0ls?=
 =?utf-8?B?SW4ydVo1bzlNSWZPT0VTZExXNUlHTHlSMnpOVVRlRktVZDFTa1hhQ2UxWlAr?=
 =?utf-8?B?UHB5ZjdOVUI1RDZYQzFOdUdrcURZZmZxUDY3SU82RWJkRTE5QkZ5d0JWREFV?=
 =?utf-8?B?QjdZNnk5U1psTUZaNCt3Szl1NUcveHlxRGlUQTF3RDJmSEF4d01jMVhjcWZT?=
 =?utf-8?B?cU4xUm5NS3pqQUpQSE0xdDFrV3Q3ajV5L29PQ3dnQndOY1Q2WjhxME9wZHM5?=
 =?utf-8?B?aHQwdXg4RWdZMlkvUzR3ZFpNU2YrTjQzMWdkcFFUc2hYTElDNElmamg0amFW?=
 =?utf-8?B?eldJU2h5K1lxYWNZRTloU3p2QkZpd0s5Y3FHd0JQd05WZjc2d25YVzFlem1D?=
 =?utf-8?B?c0tVMHhFQ25SdFAvTzBGRGxoQWErcjJnNlZmN3ZSNDdrelluTW0ydmg3Z292?=
 =?utf-8?B?eFlOYmtLdDdIbkhiRnBTTTlOcXBhNGtpYWtMSlcvVkxtWm5KWHU5d0ZoajBy?=
 =?utf-8?B?b2JJdEJGd3lNckwwUUVhVzlhZERHYk9oMW1wdWs1QVdsN0g5STY2SG9ZYUs4?=
 =?utf-8?B?UmNlcHNZWXN4RUdXZjNrWTE3SWptK00xa0N4SVJ1RVJzeHhJeWRta0pyd2U0?=
 =?utf-8?B?R2Fld0NMSURjanlxYk9HTnhYRVVlWEZEK3ZpcUF3OUh5T2xZQUE4a05sRTJ1?=
 =?utf-8?B?emZaa09Fa2J5US9UOEhjYUZDcy8rSDYrUGFoK042ZWgxbnUxMWdhN1lINFhk?=
 =?utf-8?B?RVYzdW9Jajc2ZmNZZnpwNzdXRU9EdGVqQi9lbzZveEc4by92ZWNhOG5RNWZo?=
 =?utf-8?B?NmI0WW5lNFNLSDV0T3A2RHk3Vld4bVRObjZzSk1DNVBkNURwVVZrMnBVc2FY?=
 =?utf-8?B?ZHVXMUgwdmpzN1d6b3M2bW12eW5QYTN3d1orRlZVT1JpZTYvcTJBOTlmWExK?=
 =?utf-8?B?YUNBYnVlT3FNdFQ4U01HbHpvbU1EVjZhbmlaWXBlR3hWYUxpemZ3TmhiaTJt?=
 =?utf-8?B?QnZnR3c2cFFBV1ZqTFR0alV3MTVyNWVnbi9va0UveDlBUUR2eTlpbmdIa0la?=
 =?utf-8?B?a0EzMWNvMDlxc2ZNNkI3ckFFcCtzVnBiYm1BREI4OUdKNFV4S1dVdVBHblg3?=
 =?utf-8?B?SmdqS3FVeTJtUy93WSsrS1BYbFI2Mk11eStVMzQrSW50ZDBRZThmeDRHZXdD?=
 =?utf-8?B?STRBRnRVM090Si8ycENLYkRlcFk1bmFRMlVDZDMvaS8zenc3eWtvbFNDQlF1?=
 =?utf-8?B?RE1YazNjbVlzeGVDZ1lHcWprUHFRc09ZWU1DNUs2LzlNWm5SMEduL1JkWm82?=
 =?utf-8?B?QkFQNFZUUHgwb2xkSmg4eUVNdTJnb2ptckQrbkhjYzJ1b0k5VGdyemtBSnNP?=
 =?utf-8?B?aHc5dWpNMkd6VXNIbDQ0QVd1TlRBTHZ1MlBHMytkWXJkZlpxN0drVjlqc2pL?=
 =?utf-8?B?QndTcFVmNUJJWFhHYzNNNmExWDdRaHIrdkFYeUhmb0pxc05RMlhvUXF6WEVK?=
 =?utf-8?B?dUZuOEFnVk1oWGRMeFRxTXBJMHZmSys4ZkhwWGFSMThrUWRySHl2YTFiYkVm?=
 =?utf-8?B?Q2IveGVzVUhkcVZPVEhFa2NkV2hmRCszWVY4MENnRGtSNEErN202aXREWXor?=
 =?utf-8?B?TlZSSVg1TDFaVnhFWExhdC9MTzhHbnBGeHRZZ2hoRlhDUWZZVVB5NjM1ODhE?=
 =?utf-8?B?NWVEdTZNcElNbGF4OG1vTTJlVzBGODlTcDhIOTF5NVVJbjgyZVc3bVYxY1lV?=
 =?utf-8?B?aVZEY01JVEFUVzRPcVZCbDZvK3lxZmoxUFBNM1Jxd2tXUC9GbFpKUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d79e16-0a66-4647-8f9d-08da31cc87df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:59:35.0417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CatS5FJGpZUg9yGzjSji+PwuObZmzxKmgf/JtWE0PDzB0HhR8EOzhtnGrBLZt7SH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1646
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



On 2022-05-09 02:06, Christian König wrote:
> Am 07.05.22 um 02:03 schrieb Luben Tuikov:
>> [SNIP]
>> +     expect_val = LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK;
>> +     for (i = 0; i < usec_timeout; i++) {
>> +             tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
>> +             if ((tmp & expect_val) == expect_val)
>> +                     break;
>> +             udelay(1);
>> +     }
>>>> Does the hardware specify a minimum delay after the write to the LSDMA_PIO_COMMAND,
>>>> and before we check the LSDMA_PIO_STATUS?
>>> I'm not sure, but it should be pretty minimal.
>> My point is that there should be a delay at least as large as the polling delay,
>> after writing to the command register and before reading the status register.
>> So that should be at least a 1 us.
>>
>> There should be a udelay(1) after writing the command to the LSDMA_PIO_COMMAND
>> register, before the for () loop begins.
> 
> I can't count how often I had to reject that approach. This is exactly 
> what we should *not* do.
> 
> The SRBM (or whatever that's called on newer hardware) is the one who 
> inserts the delay here. The driver should not explicitly do that 
> additionally.
> 
> The background is that a) the read is often used to commit the write 
> operations, both for the PCIe as well as internally in the GPU and b) 
> the read only comes back when the SRBM has synced up between the bus 
> interface and the hardware block in question.
> 
> So when the SRBM has synced between the two clock domains the operation 
> has usually been completed or at least started. The minimal delay we 
> enter between reads is just to avoid hammering on the register bus when 
> the hardware block in question is (for example) power gated or otherwise 
> not reachable.

Yeah, that's what I wanted to avoid, but if you say that we need it to
make sure that the write has committed, then it's okay.

Regards,
Luben

> 
> Regards,
> Christian.
> 
>>
>> Regards,
>> Luben
>>
>>
>>>> At the moment the code above checks the status immediately after writing to
>>>> LSDMA_PIO_COMMAND, and the copy wouldn't be completed.
>>>>
>>>> If the poll timeout is 1 us, as the loop shows us, maybe the command completion
>>>> is larger than that (the time after writing to LSDMA_PIO_COMMAND and before
>>>> checking LSDMA_PIO_STATUS)?
>>> The time it takes for the copy will be dependent on the amount of data
>>> there is to copy.  While the command is probably not complete on the
>>> first read of the status register, it may be required to make sure the
>>> previous write goes through.
>>>
>>> Alex
>>>
>>>>> +
>>>>> +     if (i >= usec_timeout) {
>>>>> +             dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
>>>>> +             return -ETIMEDOUT;
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>>   const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
>>>>> +     .copy_mem = lsdma_v6_0_copy_mem
>>>>>   };
>>>> Regards,
>>>> --
>>>> Luben
>> Regards,
> 

Regards,
-- 
Luben
