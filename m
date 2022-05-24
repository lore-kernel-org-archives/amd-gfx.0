Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88025C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 13:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1167B10FB2E;
	Tue, 24 May 2022 13:18:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2DF10FADD
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 13:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgzBeN0z9AViAOpFRimHT9WSM4qiC4oV2Ajk5AIWO+SZS+dF5VZW13ukNEwqDgPQDg2gMb+MNDLJL33yYHtKl/pP95UEZPoX3nmD0DHx0aq39tY8bRIS2pra4MnvF1NtCahFmAR/gJGFxvIQxVbe298BIRQitShFsAKrkbRouJnM6ADrnJlT4uJrLH+1sLhmqrr79rctci/DTKhH/3kqy9j0pDPc9XJAGn/ITQ6JgDQ02hBr65KM01wxLE92VUA44tFVegw0Jm9FACUaUVcQoxYCjdsRG6VKlOCW7HxVDkcil0SjHBL9wM6inoJILdQG6QOXvpYVih836+7mpl881Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMh5NrEqgpx27flbPzIyvhWZeLH+xVl/6TTXNpr/RPQ=;
 b=NaMKGQ6UZTduNJj26FuKjxoCL8QKe2zdN0jYmxUs4rtVjGpDbZmDRUXJOKC+VWCxd7rSFFjW23erDitB+Z8c84gHU8DBXHMAYTGGXSaiXFTsdYVQwys7+6aNK03mCmXm8KYjziy8D0++9JPBtGE/LGHZz24EHlsEanqX3IDe2/fFo4AlohDdZAwRLE4TwciOsTbfFGnM/GVbKJfSYBCsp6B8l2Jw3X+E1IYd5RKwxCQtVBoat2OdyV6HEONTdHFQsgfaFS2Rj6UiRBrhShkXik3Pk5WUTOxwF58Ap0wFaUn9AryMeqcSIfZm03qyQUH7bM7zM6ET94+PAjVQFqhbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMh5NrEqgpx27flbPzIyvhWZeLH+xVl/6TTXNpr/RPQ=;
 b=o7zH4s91/bWwqRPnMPC43VNg2OE7LlKNtgCgsixY3+MRuk/jfp4DQEgfh/MAPS3/ExK2Lbr1K8OSTLgIz6y88Agq4oj3ffkeZtPr9tg7cMdy+rI9bEZzfPuwHSashO5nmA543OCUi/IMWyw52vpcH7s4m45hBgcaKQRdpwfRx4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM6PR12MB4746.namprd12.prod.outlook.com (2603:10b6:5:35::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 13:18:18 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 13:18:17 +0000
Message-ID: <2fb3744b-f23a-ebaf-98a3-34b4eb12df80@amd.com>
Date: Tue, 24 May 2022 18:48:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
 <588a0599-7d0c-0041-9877-4429b416e7ed@amd.com>
 <18da952a-25d7-1d52-5d1b-016432066211@amd.com>
 <2e8b9ebe-3d1f-40e5-73e3-54607a8045cb@amd.com>
 <7cdad508-17b9-17b0-59f2-de0bf98ed780@amd.com>
 <ae53629c-7922-6a17-c162-e9397386106b@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <ae53629c-7922-6a17-c162-e9397386106b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::12) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44892d53-66f8-4f17-30f8-08da3d87ddb0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4746:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4746BF043A1485556149A642F8D79@DM6PR12MB4746.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2DJwReIepZb9HPbmFJznIj9VjKOgMKI87RY+G5u2Mvi2SAfFfXoEQiki0bZxPzzwGF0rsBMrUNnqc/EhGTgWMaBQ/wRIoRED2NaZ9TMH7cySqbeAfEhcfzAdnuJoiIQxkpDOrCtgiQCXoXj2sNMcAGrRh5Upb+HxwoGfkrlGqpAf5uce9nvBGPB4E8FnEKOs1RYxdIsAm9uD42/yJgtdQQ5jOuziijbU7JEHmcZmG8CgCjDTkvq8qtMS+NPZNJ6QeZklzAHUAf/InQFDa6QSOp5PXBcS277X0I1XeHUaG4bUJh8rug27k5q1ZTpxPLhQVoxZqGTPcHAJTmZ+jXYtOnW8DOSzIT4VV1gF8omiy0GuSNApRK/rxETWQ7W8K+f4VcolB9RbqU+kvxdcl3gwxwr45RcSN9zqEA6c93oiiJfvjryIrFyLE4XmZ2vNC89s3PlXt1SdBiKQPfkbnz/5ueu3xEnepHPW9rhCRJoN7F77QS7okOr9gBUQhtW2C1tdAyBogOlAzpCsR7KVrMna8U39pUk0ihDFznePikvW2CRcr3fynEfIcdsArKvn5PN3uIB++HP8SnTbEuZTaBd1TGjRessEFdN+Uzbtx+7aHsll/lMKh2yupRbCZy7z24EYdlQgvNtf10wPNmvURrC7RT5SwzMDq00RspISbcw6G5D5BMVaaTNTJpLVoGRTjoB8TXN/hw5ncDIR/vYEUip8ls/Hk07ED71XpUqyGWkJnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(31686004)(83380400001)(2616005)(26005)(2906002)(38100700002)(66946007)(6512007)(8676002)(53546011)(5660300002)(4326008)(6506007)(66556008)(6486002)(8936002)(31696002)(186003)(508600001)(36756003)(316002)(110136005)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE9ZZERKMmhVRzZUVHY3TjAwTjJaZSt3YmNyYTBKaE43OGdIK1NBQVhSZzRC?=
 =?utf-8?B?akZpelFmblJaSkxvd1BHKzlLekpVTmRZSFo0cTlOUEVlczhDZ1MvTVhndUdk?=
 =?utf-8?B?bGo5M2hkOHU5RStqT01vVlRwVldYQVVJYWdwTG9veHY5dzUxd055Nzlqa2FW?=
 =?utf-8?B?cDNJNHdXWjkyL1hHSnJ6cTRDMkpJbTI0V1RVR3kxUU5sNGdpSlY1TFhMdjcx?=
 =?utf-8?B?c0w2ZjJRUDVaZGxFUHNkNVpkSTVQWUs0MzFsZVFpbkJTbkZadkN4dmNSTmlZ?=
 =?utf-8?B?ejE4QzVsR05oeW1aR3JyWW9RemoxVitGQzBrdjZlbXkzRnBncHh3VlY3UlZN?=
 =?utf-8?B?Tlc4U0toUXRsMDdtcFcwaDNUNDljanc5SGQ3TXdKSHVUK1R1L2E4djFrZTJu?=
 =?utf-8?B?QkZaRzRNbTM4cEJBTXl0RXErVEFKT3BiWnJsTWV3bHlYYlR5SlgyaGtPTUNX?=
 =?utf-8?B?UFBkVkxLdHRwZGZKaGkzM0QwWGhYNHZKc0o2Mi8yVGJmanpMbEs3REN2Ykxx?=
 =?utf-8?B?ZUNzT0pqTFVpMU9pa2lBNEJWKzhsYVFORDN2UjV3UGJLMktBZFNEZmtDdno4?=
 =?utf-8?B?NTVCUGcwb0pwbE1jU0kwUm5TRVFuc0c2MlR4ZTdvMjB5dTlwMUJMR2N2V2lJ?=
 =?utf-8?B?VkxMMWVFSmZ5M2xwQWZ0MTEydlRUZlJEYUdKeWliWmxqZ2FvakRkcHFiWC9B?=
 =?utf-8?B?ZUNhME5nL3hKamM1bkZCYnljKzh0bFVWSXpsY3F2VVBDd3dGNEJtR3RUSXVY?=
 =?utf-8?B?Y0xKdkpHSFdjY1JMMEJSS1VTK1VjZytBbjJrZDJrRWtuVHlmSFl5N0k4T0xv?=
 =?utf-8?B?aXVnWnpzc1EzcHJmR0hNWkgyWmFXbUc4NVRPa041Yk5vdWk1RHNQS0daWUZo?=
 =?utf-8?B?VDh1OUNKdzl1aXB6ajVYUXZNTWtxWElFNE5GT1NWQVdBZVhFSCtrNVdVdkRm?=
 =?utf-8?B?ODNiZWt1cDVIZDgwMTNFWW9iOGZoSllmb3RGeFpidXRKcGlBSXk3eGlSekNO?=
 =?utf-8?B?NlgrcmFkREs3Tk5Zb0dFb0pyMVpWYVdnR2Q5S3prakkvbE9xY1BJNXZuSUE3?=
 =?utf-8?B?TTd6bnBUcjhqMUtHUFdWRkFCdlBBQXYrQlY2L1VmcGVsSEZFN25vRXVXSHkr?=
 =?utf-8?B?cnRBMndWeDA2MEluSXc4VWhDcDFSTEpMSmVGcE9vRlRjVnV4VnkxS2tXTFoy?=
 =?utf-8?B?eGZuVEQ4WEJuV250UEZEbVJVWEsvTjBvNmdCeUxjQjZDMTNUYjBlWTNicTRv?=
 =?utf-8?B?a0EwZHBYM1ZuQnJNTm9KampPMFlyRU9acjdCK3p5ZkJCMi96dFlyM3FiMmY3?=
 =?utf-8?B?UFh4VDhXaDVyWU1wN3lZL1FxaG45MmRTWURRUzVNTzR5ZmNaSzVNTEJhcVhX?=
 =?utf-8?B?eGVDK2pNWGFmMUZvdlFjSmlidDFUSWtmZWEyMVBlOW4yWlNIZ2EzWXpzRFZk?=
 =?utf-8?B?ckhOSksvS3lMNzVuaHNRVGFjcTlIUGp2Q1V6Tm43bHREbnNBWTFCaW5LZ3Fm?=
 =?utf-8?B?Q1dJYVp3UFBzcjUwN3FLTjQ2ZFJXSko1Zm1DS0txY21yaWRWOUpiZ0VHU01U?=
 =?utf-8?B?Wjh5Q0wxdTg4NjE0U3lzdmg5czloMkVmOG0rYklZZ1ZSNUZkM1U0Mm5vOFNl?=
 =?utf-8?B?VnI5UE5vbUFhM0pFanJyRG9uNlRITkVXeEpoUnZ6SDV0RFpXamZ0dUtFRVRR?=
 =?utf-8?B?NW54NkJOaThrRVZYQ1A5dXB4NEMzYkM0Z1lPTkRrNWttWnVCSUpLNHlrYmlu?=
 =?utf-8?B?RHpYRWx4Z1BDbWQ4R2pKSDFoUzFtTWJkZjhSSFNPWk9aZkorakhJOXRldDhL?=
 =?utf-8?B?ZkkwVnNheU5tazZHVUJ3aDQxdk90Qy9TTDRiQXFMR3NhVzcyU3NneXRUVUZv?=
 =?utf-8?B?b2JwRnFESnFlWEtkMHdBbWNKU2xYeHJUY2R4clcrdkRFcnJRMjBrc1NhZW4v?=
 =?utf-8?B?YXUraUM4RXRoczJieWoxeElVckxzUmRpQnJoUUs4emRKUG5EajBTUlNIamg2?=
 =?utf-8?B?aDJxUTMrbXdUTEM1ZEswVVNyTEpPZy9yZlhSc2luRkhiSnBVa3BrcUNpSkZl?=
 =?utf-8?B?TC94eVpiNnRmaUdJSmxGSTFXNjV6cGdCakF6SXh0emExL3lxVm1KSExhcUZP?=
 =?utf-8?B?aXNhem82VHhKd2Fpdy9DOU5TSUQyb0NVTWwxSmV0N0hPcnFQNU0yRkJhcHNQ?=
 =?utf-8?B?RzJ6LzAwWFkyNnRUOWdKeDVxbGs1YzdhSU5ldjVZZFZtWlV3NWc2YXpnenJo?=
 =?utf-8?B?T2M2MW9VOXRZakRaNDUrdGozR2xkQVFIV1kyQ0JqV1FkZlcwaHhtcVY1Slh5?=
 =?utf-8?B?YmFEaW9Cb2lXdlBjVG5JQ0VZNmRuc0dSTkNXU004T1d2RVJJYi8wQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44892d53-66f8-4f17-30f8-08da3d87ddb0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 13:18:17.8818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8F2Ja9jMrBbM/fX05XJQLpDU6kkHUCKUiZ08VLvFSW1Tp6PZ0bRQcK9rzc6fE6j8aF3OEwaBh2Jctg5ld+NL2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4746
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


On 5/24/2022 6:20 PM, Sharma, Shashank wrote:
>
>
> On 5/24/2022 2:10 PM, Somalapuram, Amaranath wrote:
>>
>> On 5/24/2022 3:23 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 5/24/2022 8:42 AM, Somalapuram, Amaranath wrote:
>>>>
>>>> On 5/20/2022 7:52 PM, Sharma, Shashank wrote:
>>>>>
>>>>>
>>>>> On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
>>>>>> Added device coredump information:
>>>>>> - Kernel version
>>>>>> - Module
>>>>>> - Time
>>>>>> - VRAM status
>>>>>> - Guilty process name and PID
>>>>>> - GPU register dumps
>>>>>>
>>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 
>>>>>> ++++++++++++++++++++++
>>>>>>   2 files changed, 62 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> index c79d9992b113..f28d9c563f74 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> @@ -1044,6 +1044,9 @@ struct amdgpu_device {
>>>>>>       uint32_t *reset_dump_reg_list;
>>>>>>       uint32_t            *reset_dump_reg_value;
>>>>>>       int                             num_regs;
>>>>>> +    struct amdgpu_task_info reset_context_task_info;
>>>>>> +    bool reset_context_vram_lost;
>>>>>
>>>>> How about drop the 'context' from name and just reset_task_info 
>>>>> and reset_vram_lost ?
>>>> OK.
>>>>>
>>>>>> +    struct timespec64 reset_time;
>>>>>>         struct amdgpu_reset_domain    *reset_domain;
>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 963c897a76e6..f9b710e741a7 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -32,6 +32,8 @@
>>>>>>   #include <linux/slab.h>
>>>>>>   #include <linux/iommu.h>
>>>>>>   #include <linux/pci.h>
>>>>>> +#include <linux/devcoredump.h>
>>>>>> +#include <generated/utsrelease.h>
>>>>>>     #include <drm/drm_atomic_helper.h>
>>>>>>   #include <drm/drm_probe_helper.h>
>>>>>> @@ -4733,6 +4735,55 @@ static int amdgpu_reset_reg_dumps(struct 
>>>>>> amdgpu_device *adev)
>>>>>>       return 0;
>>>>>>   }
>>>>>>   +#ifdef CONFIG_DEV_COREDUMP
>>>>>> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
>>>>>> +        size_t count, void *data, size_t datalen)
>>>>>> +{
>>>>>> +    struct drm_printer p;
>>>>>> +    struct amdgpu_device *adev = data;
>>>>>> +    struct drm_print_iterator iter;
>>>>>> +    int i;
>>>>>> +
>>>>>
>>>>> A NULL check for 'buffer' here could prevent a segfault later.
>>>>>
>>>> Agreed.
>>>>>> +    iter.data = buffer;
>>>>>> +    iter.offset = 0;
>>>>>> +    iter.start = offset;
>>>>>> +    iter.remain = count;
>>>>>> +
>>>>>> +    p = drm_coredump_printer(&iter);
>>>>>> +
>>>>>> +    drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
>>>>>> +    drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>>>>>> +    drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>>>>>> +    drm_printf(&p, "time: %lld.%09ld\n", 
>>>>>> adev->reset_time.tv_sec, adev->reset_time.tv_nsec);
>>>>>> +    if (adev->reset_context_task_info.pid)
>>>>>> +        drm_printf(&p, "process_name: %s PID: %d\n",
>>>>>> + adev->reset_context_task_info.process_name,
>>>>>> + adev->reset_context_task_info.pid);
>>>>> Please fix the alignment of print variables.
>>>>>
>>>> I will cross check this.
>>>>>> +
>>>>>> +    if (adev->reset_context_vram_lost)
>>>>>> +        drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>>>>>> +    if (adev->num_regs) {
>>>>>> +        drm_printf(&p, "AMDGPU register dumps:\nOffset: Value:\n");
>>>>>> +
>>>>>> +        for (i = 0; i < adev->num_regs; i++)
>>>>>> +            drm_printf(&p, "0x%08x: 0x%08x\n",
>>>>>> +                    adev->reset_dump_reg_list[i],
>>>>>> +                    adev->reset_dump_reg_value[i]);
>>>>>> +    }
>>>>>> +
>>>>>> +    return count - iter.remain;
>>>>>> +}
>>>>>> +
>>>>>> +static void amdgpu_reset_capture_coredumpm(struct amdgpu_device 
>>>>>> *adev)
>>>>>> +{
>>>>>> +    struct drm_device *dev = adev_to_drm(adev);
>>>>>> +
>>>>>> +    ktime_get_ts64(&adev->reset_time);
>>>>>> +    dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
>>>>>> +            amdgpu_devcoredump_read, NULL);
>>>>> instead of registering NULL as free function, I would prefer you 
>>>>> to have a dummy no_op free function registered, which we can 
>>>>> consume if something changes.
>>>> you mean something like this (function without any code):
>>>> staticvoidamdgpu_devcoredump_free(void*data)
>>>> {
>>>> }
>>>
>>> Yes, precisely.
>>>
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>                struct amdgpu_reset_context *reset_context)
>>>>>>   {
>>>>>> @@ -4817,6 +4868,14 @@ int amdgpu_do_asic_reset(struct list_head 
>>>>>> *device_list_handle,
>>>>>>                       goto out;
>>>>>>                     vram_lost = 
>>>>>> amdgpu_device_check_vram_lost(tmp_adev);
>>>>>> +#ifdef CONFIG_DEV_COREDUMP
>>>>>> +                tmp_adev->reset_context_vram_lost = vram_lost;
>>>>>> + tmp_adev->reset_context_task_info.pid = 0;
>>>>> why is the PID hardcoded to 0 ?
>>>> in case of reset context reset_context->job->vm  is null 
>>>> (possibility that reset can be non VM related).
>>>> If we don't set tmp_adev->reset_context_task_info.pid = 0, it will 
>>>> show previous reset valid PID.
>>>>
>>>
>>> But when the VM is not NULL, are we updating this PID somewhere ? I 
>>> did not see that happening in this series.
>> This is the only place where PID get updated.
>> For example sequence of operation like:
>> 1st reset:
>> -valid VM and tmp_adev->reset_context_task_info.pid is set to some 
>> valid PID
>> 2nd reset:
>> -invalid VM
>> -tmp_adev context will remain same (adev context will be same after 
>> successful  GPU reset sequence).
>> -tmp_adev->reset_context_task_info.pid will be holding 1st reset PID 
>> value
>>
>> if we don't set it 0, it can give wrong PID.
>>
>
> I get your point, and agree, that when the vm is invalid, PID is 
> invalid so we should send pid=0. But where are you handling the case 
> when VM is valid and pid is valid ?
valid VM check in the below condition:
-->if (reset_context->job && reset_context->job->vm)
reset_context->job->vm->task_info will have the required information.
>
> - Shashank
>
>> Regards,
>> S.Amarnath
>>>
>>> - Shashank
>>>
>>>>
>>>> Regards,
>>>> S.Amarnath
>>>>>> +                if (reset_context->job && reset_context->job->vm)
>>>>>> + tmp_adev->reset_context_task_info =
>>>>>> + reset_context->job->vm->task_info;
>>>>>> + amdgpu_reset_capture_coredumpm(tmp_adev);
>>>>>> +#endif
>>>>>>                   if (vram_lost) {
>>>>>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>>>>>>
>>>>> - Shashank
>>>>>                      amdgpu_inc_vram_lost(tmp_adev);
