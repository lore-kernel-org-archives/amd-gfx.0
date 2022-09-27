Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59DCC07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 12:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B29710E32D;
	Tue, 27 Sep 2022 12:40:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422F810E32D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 12:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1xnSewow2uBKNCWtH6qJ+NAQMpmIckyfu/p4m+H+KO8BzsXuWlTUdizGhPk/GGoWM5nrm7iGC31Y3p//NxgHgjx9iLWXV5d2VqaNPqUDlHybl1RV7Lun6khXa4e96dqxEdT7msePFZm0bVeTtt5mbwwQUBTTiaNvc30ERi3gbotBgOKacbmLDsHMDxS8900GZgGqCtkMHquYoo3R2Dr9FB5C5lFRjnwfYGVnJGDceTlBlZ5hS0sd1uIXQhdUBhIUy5KSJyLZb1XGT35CKHO5nnoFuPL8NPNI1ag7th4q08fESbs61ZgGh66q97ccNL6p/BuHoDMQnQPToBWUburhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ+vd9tN4KIs4qEL+fEE75qwIhon+vS1ghvLnoUvDYU=;
 b=C7SxLvF4gs9fiZ1CovfS69FYeZXT43B4gcvQeoijg4W6vrJUT82NAulAHPihdhQ4r6Be9dSQJ1wDJ/Fw1lnyGad8GfnGay5QPtPR0ZZHlVIYWDNM6M37ov7NWR1cGCC8ZVLnhtDCsfnQdvxZZ8QvioDjzKPb+PP+DFnQ3ZePRIkBn90P9CA93SKm3Ui+PhW9Dh7mpZg3ietga71TtVI9BlFAVqRZ6y+bU4ubjVW6sKl34o2l9RFKB7KjMSvEhBIiVl1g1/3yco2C3a0ytq2qR34r7wu1gsc4ge6vMVIT6yQjDbxaReixBhVb9Woqr5DYtiyy43O1xKtRd+L+Eyf6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ+vd9tN4KIs4qEL+fEE75qwIhon+vS1ghvLnoUvDYU=;
 b=XMNHTLDw62ao3kIlI4fotI7Gnth/SPHNQDeW0xVsr9C8TKMJUQyyN7CTQD9g7f3Eu4yU1me7gZGY3eOqKIpZnotm9CzZ5YAyHnCuRK+eAD8zGdTgJtWCxn6/3JAHwZVRU3S31HpVyZcUI65blvTukxrPFDiPJHaCxf9UQYQXW+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 12:39:57 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 12:39:57 +0000
Message-ID: <0aced831-643a-f3db-eb71-6129d9ff008d@amd.com>
Date: Tue, 27 Sep 2022 18:09:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
 <29782362-ca83-9174-c289-1ef973b8e736@amd.com>
 <ff4e61f2-f361-83c2-0bf4-443989e01ada@amd.com>
 <f8d1a1dc-056c-bfe0-2f61-cc9c0702e37b@amd.com>
 <6a90712b-d6bb-d1b8-e1b9-8e714be85094@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <6a90712b-d6bb-d1b8-e1b9-8e714be85094@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed74ae0-96a1-43ec-8e3f-08daa08562a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5LpZF4gUUyxLTlgsxOHb85KtPAyikD1ZF0DLeJaoQ0CbD76sXpu4dJdcF1ws4YEJT0acLmKzmLF+RH+YFjFkN5bsETrt30bQHKv7QojgzCOeamH25fbUpgedNABEQDyvCNyI4DjFvHw9NbyceGPKg0KlnLPnqVNLVnk7LuUrXRkC7kDude/YaxdqM58uH8sKy6rAWdJh1tABmdWnpy2C9GKIjjFZC3KBz5iN3Z87hPBm0ABqEDuECD+P/fEHP8B3+ZRbNDcYuc6HSfs5VpvW7jXeyZlEShwcNDo+/uxhdpETYa4zt10wqmF84uBqkIeRFIhpmibyWuHUIMqfUr6GPUDMkA+TBd/Vo2xsIqbQhM6SXOiu8kfZPkNey+KJvTRyuVnDazboxlYT3XV3lA+lyg7CjUF2Ukp42eJIneRAhzdIQi5JR/5aZ1Qaf1jaxqyZenPLsAcvWOS+avFF+oumDlRK2kHiO01y5Tav+9lPGnuWY/CK5D+VRcLPbO/NlDg+Bhcsv6fZCAfIa60IaEjS5cAocXKNm5PXWF8wIEfF/QLbU8CMwshHTZTDQys1WtOI5rAAsC6BKExClVYNS00rZ9H+F5FW2sfDYKI7WPQbeA66VzNm4G4nksV55waanV8Hs9CpCKCxgUC3y73n3a7SO23LbPJCBiyhrPqhTeH+EffRO9jV8esR7RY+8tHIp4DeAfWNsG3B4jE5mybd1S+QifyAl3vBuSyZ1Ilxb9yLWXT2iCM4eUAFmdnmrvYHTGeI25OF82Trjb6CEgnEfiOv2jw8TxcgCQ3QPox4j9F74s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199015)(38100700002)(8676002)(41300700001)(6666004)(66556008)(66946007)(66476007)(26005)(186003)(4326008)(2906002)(2616005)(83380400001)(8936002)(36756003)(6506007)(53546011)(6512007)(5660300002)(30864003)(86362001)(31696002)(31686004)(6486002)(66899015)(316002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXhDclBDNFdoTU5lOHM0R0Y4WVNoVGF2SWt2N0tyMWxkZ0ZMZURVaWVWZ1kz?=
 =?utf-8?B?UGg2ZmFuU2lVVTg2QmRnYmU5RXNkSU82dlRIdGd5ZEl2WStMRHVmbnpLcm1R?=
 =?utf-8?B?K1N3bFpheTFWdzZmY01ETVU1am1ucjJVVVgrcmNkdm5DV1dUbFA2NHJmdmx0?=
 =?utf-8?B?VUJpdWs5OUYrZmFHT1ZHdVNaT2lIYTZBZzZCcTJwZVdKM1BIOW1NRmJlVE45?=
 =?utf-8?B?eXFyYXN3L0tOZ1hRcktzTVRhak9KY29wcnpOYnU0ZUFVTVpGWGlDeUJ4b1Vx?=
 =?utf-8?B?czUzR1p3ZjFmN1dZRUdYNlFtSjVsSEwxamY2WldiOUZqVmVkNjRjY1B6YlNs?=
 =?utf-8?B?QXJZdU5zUmNxYmJobkNBN1pzb1hiQzFlUWNScGVqbXVGRXpIQWRSZDNibHZw?=
 =?utf-8?B?bjdsc0VFcTdQM1pISHlhMGZiY3M1c21yYjg0QmtYZEtiMWpONkIyRkZPdUFa?=
 =?utf-8?B?VFI1T2cwWEJaem1weGFqQ0diem0wdmpaK1VvUmVrb3Jjb2Q0TVU5d1htaVRD?=
 =?utf-8?B?N0tvWXA0YnpxTVVlY3oweG5wYUdabWIxRzJCYitaZnQvb2VTakVIdmJra1lm?=
 =?utf-8?B?dlB1Q2UwanZuVmVmQkdsT0lhbytWNXg4NWlUcUxVNkFIdktlbXRtOEFtcGd3?=
 =?utf-8?B?TGlFalM2algxNzlpNVF1aFpCSFRUVTBud3Q5MWIyRWVnK0wxZlBLWE9iaWhR?=
 =?utf-8?B?Rjlxd2tJRW92ZjFUWFNOMzJpYUo0QVRxUWw5UEpUMlVkbk45TVRybG1Wb1Ri?=
 =?utf-8?B?RWgrTm9ORXV2Mk9XUzFvTWVRWlRKWjRjeVlsZGdGbC9ZcGN1TUV3bU13R0tU?=
 =?utf-8?B?cVp2NXZBUUNUMUwxOVN6ZFFxOXVnT0xKS1R3OHdTUmIvYXFPblBTWGFqRDk2?=
 =?utf-8?B?dkdEeEdUVEt2cFc4d3BTbHZxcm41OVl2M2FTL2ZXNTBMSEVpeUlmOHdHWTFN?=
 =?utf-8?B?b3RNRExIb0xCeHdxNms5RUxjSHRpd1BjTkhBRDBONVk2TldsYzlhMmVIRm9U?=
 =?utf-8?B?aGtMeHpuSzJpOVBOTGpTemxFRVY3K2RQemtMeGhxd0RURXNOV2NaZXlSd1JU?=
 =?utf-8?B?dFRnYURYOHhxVkVGTWFMK1AzaHVIak1lMHRNYWEwTEp3bkR4MktTRXQvTU95?=
 =?utf-8?B?VlpEN0ZJaWlTcWhvRUJPak8vUmdPcEVxdncwNVA4RG1PR2dWK0dMNW5jZC93?=
 =?utf-8?B?Slc0cUczMnRFVEZZRktpZkNlQ3IyT3BFMC9ia3FRVWo1Um1kS0R2OThQZkcy?=
 =?utf-8?B?dlAvSUMreTh5dU8xT21VN1ZCb3dZaTJBUXpRRWFjMWJwYWY5N2l5UmxwOGlQ?=
 =?utf-8?B?bmtoVHFlbHJrNUc5WnQ2RTJyVk0rWVVOR3hmMTRpY1lNZkJXeDl5VG14SmtX?=
 =?utf-8?B?bVljcVdqNkp6Rkw5VlJEeXlJWGpVT1ViOEJXSVdVVUw4eVdCTnl2eWIxUTFw?=
 =?utf-8?B?WWZFeVJZWDloZGJaaTZyci9MaXpKZW80cHRRN3hrMnB2UDdNVnc2cVdDNEk4?=
 =?utf-8?B?bGE2SVl3Q29NeTVlMlFKSm1IYzdBcURDU2FHTzNNRE9GTEtRRklKSDNxSXRM?=
 =?utf-8?B?dWs2cU5iTlVwMW5TZExGTFF4c0tjWkJ5cGg5aFRpV2lJM2twMGIxTkJaeU9x?=
 =?utf-8?B?dUt5eUROd3VycSt3eUtwL0tLWVczd2xoQ1Bzc3lSZzZucFY0T0dLRkxnME9z?=
 =?utf-8?B?dER1ckJEVjVUdTJxbHV3K3RYU3ZMYVI2V2h3a1F0NWR1Z3Y5bWM5UW9mZjFE?=
 =?utf-8?B?Z0E4bFZtbEppZGkzeDNTeFVRaU5nNUFyNTBHanVjNmNJbmZ4UHlGc1VWNE0v?=
 =?utf-8?B?M2FkR3czbXN5QjZhcTZNcWxqZkJsSzhXMVdnNzV5aFpRWjdPQ0Q3TGlIZDg1?=
 =?utf-8?B?RjY0ZE40SmtEcUYvWkQxNEcrNjlMR280V1Y4cTljTXB3ZSt2NVgxNnhkSEJk?=
 =?utf-8?B?ZytPWnliUDRDekxmVlJraVlUV2VrV1ZhLzg1MjZVZjFpaW9CTlY0UGxnZnFm?=
 =?utf-8?B?b1VQU1ovUWtBVWtCVEkvYkhERjlxdUxxQ0RRb2QrK3dvM0owNm9KSDNEcXF0?=
 =?utf-8?B?SmVrdE1MSDRHUEJ6L2UzcUxuZGYrNG5tUi9JNFNIYUhpVVViQUcxeTdHbEJC?=
 =?utf-8?Q?VWzuQ8bsRv+C94ecGBZW93Lz9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed74ae0-96a1-43ec-8e3f-08daa08562a8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 12:39:57.5935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tl+GNnpHswq13k1yauPJ80NqjVtYO1Kjv8WD5RljaKNNvZIgzSK1r6mJJ964wQ/g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 5:53 PM, Sharma, Shashank wrote:
> 
> 
> On 9/27/2022 2:10 PM, Lazar, Lijo wrote:
>>
>>
>> On 9/27/2022 5:11 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>>> This patch adds new functions which will allow a user to
>>>>> change the GPU power profile based a GPU workload hint
>>>>> flag.
>>>>>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 
>>>>> +++++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>> index 5a283d12f8e1..34679c657ecc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>>>> amdgpu_pll.o \
>>>>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>>>> amdgpu_virt.o \
>>>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>> new file mode 100644
>>>>> index 000000000000..a11cf29bc388
>>>>> --- /dev/null
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>> @@ -0,0 +1,97 @@
>>>>> +/*
>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>> + *
>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>> obtaining a
>>>>> + * copy of this software and associated documentation files (the 
>>>>> "Software"),
>>>>> + * to deal in the Software without restriction, including without 
>>>>> limitation
>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>> sublicense,
>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>> whom the
>>>>> + * Software is furnished to do so, subject to the following 
>>>>> conditions:
>>>>> + *
>>>>> + * The above copyright notice and this permission notice shall be 
>>>>> included in
>>>>> + * all copies or substantial portions of the Software.
>>>>> + *
>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>>>> EXPRESS OR
>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>> MERCHANTABILITY,
>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>>> EVENT SHALL
>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>> DAMAGES OR
>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>> OTHERWISE,
>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>>> USE OR
>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>> + *
>>>>> + */
>>>>> +#include <drm/drm.h>
>>>>> +#include "kgd_pp_interface.h"
>>>>> +#include "amdgpu_ctx_workload.h"
>>>>> +
>>>>> +static enum PP_SMC_POWER_PROFILE
>>>>> +amdgpu_workload_to_power_profile(uint32_t hint)
>>>>> +{
>>>>> +    switch (hint) {
>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>>>> +    default:
>>>>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>>> +
>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>>>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>>>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>>>> +        return PP_SMC_POWER_PROFILE_VR;
>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>>>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>> +                uint32_t hint)
>>>>> +{
>>>>> +    int ret = 0;
>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>> +
>>>>> +    if (adev->pm.workload_mode == hint)
>>>>> +        return 0;
>>>>> +
>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>
>>>> If it's all about pm subsystem variable accesses, this API should 
>>>> rather be inside amd/pm subsystem. No need to expose the variable 
>>>> outside pm subsytem. Also currently all amdgpu_dpm* calls are 
>>>> protected under one mutex. Then this extra lock won't be needed.
>>>>
>>>
>>> This is tricky, this is not all about PM subsystem. Note that the job 
>>> management and scheduling is handled into amdgpu_ctx, so the workload 
>>> hint is set in context_management API. The API is consumed when the 
>>> job is actually run from amdgpu_run() layer. So its a joint interface 
>>> between context and PM.
>>>
>>
>> If you take out amdgpu_workload_to_power_profile() line, everything 
>> else looks to touch only pm variables/functions. 
> 
> That's not a line, that function converts a AMGPU_CTX hint to PPM 
> profile. And going by that logic, this whole code was kept in the 
> amdgpu_ctx.c file as well, coz this code is consuming the PM API. So to 
> avoid these conflicts and having a new file is a better idea.
> 
> You could still keep a
>> wrapper though. Also dpm_* functions are protected, so the extra mutex 
>> can be avoided as well.
>>
> The lock also protects pm.workload_mode writes.
> 
>>>>> +
>>>>> +    if (adev->pm.workload_mode == hint)
>>>>> +        goto unlock;
>>>>> +
>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>>> +    if (!ret)
>>>>> +        adev->pm.workload_mode = hint;
>>>>> +    atomic_inc(&adev->pm.workload_switch_ref);
>>>>
>>>> Why is this reference kept? The swtiching happens inside a lock and 
>>>> there is already a check not to switch if the hint matches with 
>>>> current workload.
>>>>
>>>
>>> This reference is kept so that we would not reset the PM mode to 
>>> DEFAULT when some other context has switched the PP mode. If you see 
>>> the 4th patch, the PM mode will be changed when the job in that 
>>> context is run, and a pm_reset function will be scheduled when the 
>>> job is done. But in between if another job from another context has 
>>> changed the PM mode, the refrence count will prevent us from 
>>> resetting the PM mode.
>>>
>>
>> This helps only if multiple jobs request the same mode. If they 
>> request different modes, then this is not helping much.
> 
> No that's certainly not the case. It's a counter, whose aim is to allow 
> a PP reset only when the counter is 0. Do note that the reset() happens 
> only in the job_free_cb(), which gets schedule later. If this counter is 
> not zero, which means another work has changed the profile in between, 
> and we should not reset it.
> 
>>
>> It could be useful to profile some apps assuming it has exclusive access.
>>
>> However, in general, the API is not reliable from a user point as the 
>> mode requested can be overridden by some other job. Then a better 
>> thing to do is to document that and avoid the extra stuff around it.
>>
> As I mentioned before, like any PM feature, the benefits can be seen 
> only while running consistant workloads for long time. I an still add a 
> doc note in the UAPI page.
> 


a) What is the goal of the API? Is it guaranteeing the job to run under 
a workprofile mode or something else?

b) If it's to guarantee work profile mode, does it really guarantee that 
- the answer is NO when some other job is running. It may or may not 
work is the answer.

c) What is the difference between one job resetting the profile mode to 
NONE vs another job change the mode to say VIDEO when the original 
request is for COMPUTE? While that is the case, what is the use of any 
sort of 'pseudo-protection' other than running some code to do extra 
lock/unlock stuff.

Thanks,
Lijo

> - Shashank
> 
>> Thanks,
>> Lijo
>>
>>> - Shashank
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +
>>>>> +unlock:
>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>> +                  uint32_t hint)
>>>>> +{
>>>>> +    int ret = 0;
>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>> +
>>>>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>>>> +        return 0;
>>>>> +
>>>>> +    /* Do not reset GPU power profile if another reset is coming */
>>>>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>>>> +        return 0;
>>>>> +
>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>> +
>>>>> +    if (adev->pm.workload_mode != hint)
>>>>> +        goto unlock;
>>>>> +
>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>>>> +    if (!ret)
>>>>> +        adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>>> +
>>>>> +unlock:
>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>> +    return ret;
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index be7aff2d4a57..1f0f64662c04 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>>>> *adev,
>>>>>       mutex_init(&adev->psp.mutex);
>>>>>       mutex_init(&adev->notifier_lock);
>>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>> +    mutex_init(&adev->pm.smu_workload_lock);
>>>>>       mutex_init(&adev->benchmark_mutex);
>>>>>       amdgpu_device_init_apu_flags(adev);
>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h 
>>>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>> new file mode 100644
>>>>> index 000000000000..6060fc53c3b0
>>>>> --- /dev/null
>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>> @@ -0,0 +1,54 @@
>>>>> +/*
>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>> + *
>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>> obtaining a
>>>>> + * copy of this software and associated documentation files (the 
>>>>> "Software"),
>>>>> + * to deal in the Software without restriction, including without 
>>>>> limitation
>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>> sublicense,
>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>> whom the
>>>>> + * Software is furnished to do so, subject to the following 
>>>>> conditions:
>>>>> + *
>>>>> + * The above copyright notice and this permission notice shall be 
>>>>> included in
>>>>> + * all copies or substantial portions of the Software.
>>>>> + *
>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>>>> EXPRESS OR
>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>> MERCHANTABILITY,
>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>>> EVENT SHALL
>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>> DAMAGES OR
>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>> OTHERWISE,
>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>>> USE OR
>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>> + *
>>>>> + */
>>>>> +#ifndef _AMDGPU_CTX_WL_H_
>>>>> +#define _AMDGPU_CTX_WL_H_
>>>>> +#include <drm/amdgpu_drm.h>
>>>>> +#include "amdgpu.h"
>>>>> +
>>>>> +/* Workload mode names */
>>>>> +static const char * const amdgpu_workload_mode_name[] = {
>>>>> +    "None",
>>>>> +    "3D",
>>>>> +    "Video",
>>>>> +    "VR",
>>>>> +    "Compute",
>>>>> +    "Unknown",
>>>>> +};
>>>>> +
>>>>> +static inline const
>>>>> +char *amdgpu_workload_profile_name(uint32_t profile)
>>>>> +{
>>>>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>>>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>>>> +        return 
>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>>>>> +
>>>>> +    return amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>>>> +}
>>>>> +
>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>> +                uint32_t hint);
>>>>> +
>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>> +                uint32_t hint);
>>>>> +
>>>>> +#endif
>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>> index 65624d091ed2..565131f789d0 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>>>       struct mutex            stable_pstate_ctx_lock;
>>>>>       struct amdgpu_ctx       *stable_pstate_ctx;
>>>>> +    /* SMU workload mode */
>>>>> +    struct mutex smu_workload_lock;
>>>>> +    uint32_t workload_mode;
>>>>> +    atomic_t workload_switch_ref;
>>>>> +
>>>>>       struct config_table_setting config_table;
>>>>>       /* runtime mode */
>>>>>       enum amdgpu_runpm_mode rpm_mode;
>>>>>
