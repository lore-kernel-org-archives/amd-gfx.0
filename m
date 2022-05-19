Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEE5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 13:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3790811A6BD;
	Thu, 19 May 2022 13:41:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2067111A6BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 13:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWwHSjcwCWA0CKhyD2mLLJSggOBOJVCJ0OI1x7GLRyEa6ba7KPH3nxClFsf+d2lbnUkalvBlCFZ6FCtXvJ4xAM/dagMHEJIjYxUw41hPXRWwhTBuCDIatdm7T3EWQC/yPO9jDiOUddOtVLcfKCse1U9g5wD7dRZhd0tO9YxycMX26Uq0Uhj3WbAR4VhOgROXB7fLkk1CxwEB1wh6HcAQqVza3TKJO0ojqjYKhAUM0zDBTlygRNzWZStRh9kbO1CaHnWfWh9tdSnu2qirkC8TcCbNW/+ytLmHyY0B9FIIGKzVOkIuYdS9JIeHr9aRakEVjd0UdMe19CE40ZRvJQyaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5b424ECEaJUJiIOW6cK2yANJrmmnPv23n04pVh/W6U=;
 b=VrOXtoYsyZTQ9qx91XqQHT8Mnd8lxuri+b28tYTeMzXonItn/4Vdvx1FKL90f/1Pfqd/bUzJqPcVbz2aoaRHt5BR3aeP2xJ1snhGm/uGbGgW2lDvpAb68YezAD6Mwt7Ox8orhCZeywAQEo+JpNPpWv07oSFGSmsVZ9pjcAgEZIlf3h3JhH+KyMKkz6/ZU/T3IDSFb/rWagBsSJ8DABmla+jCsmqvBESqBPQzeLUbUnsqJgu4LUSMK/daudbWx/vnJ+QMo+tp7Ajp0gPfi0XlELJYUKwE4Vm7NqGpD7Eb0gCIy5NWrdAm2VdiTcoptTxgDXZZcDtt1Ybuf8eLpEtNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5b424ECEaJUJiIOW6cK2yANJrmmnPv23n04pVh/W6U=;
 b=mBgnnS4IbfmdzrP3sK0lDf13VPrwyDOsGYyIAhdT1YHQEkFLYhMGrux4hfaIN0EkY9NuFeEFw49qpca0ezyiaxlJW6YXQmgoMMS3Y63G1pccRCKAA/qzRFclRgSkSd+aF83CarkBqb/PmoBvbd9RX83y/CzoSe1c7WvK/mHwkBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1868.namprd12.prod.outlook.com (2603:10b6:3:106::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 13:41:35 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40%10]) with mapi id 15.20.5250.018; Thu, 19 May
 2022 13:41:35 +0000
Content-Type: multipart/alternative;
 boundary="------------QAPpV04o6BrcAfe3EjKE6sEr"
Message-ID: <ac3feb03-9231-fa52-6183-43f85d0cff78@amd.com>
Date: Thu, 19 May 2022 09:41:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/7] Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
 <1a7fd05f-490b-9999-5f0b-e84af26504a9@amd.com>
 <ce60a983-9906-e33f-a2cc-6fedb958a124@amd.com>
 <3abdd2a3-2cb8-fc8f-fd5d-a8a7cd5fc828@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <3abdd2a3-2cb8-fc8f-fd5d-a8a7cd5fc828@gmail.com>
X-ClientProxiedBy: YT3PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::24) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca40d39c-4ccc-46d1-8a37-08da399d4ab3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1868:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1868AEB63CA919C99B7B4ABCEAD09@DM5PR12MB1868.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61rWRsK31o3FjddOeMCzt1nTfESeudZ9u86NvPCWft69De72hlo0wadq9Ou1EOAhZZwAEQkmdNHo+8IxH1YbErMc+7VeaHQGn2+MZLx7cf3th6AneC5dS6ScqNd32/NTMZF+jErDRB1qB66fyVlyahP2dk0DGT92rn/bFaUT/4nr9NhRk1j5tkX4LrApGxvxHYZXl9x1Z4wK0YX5o1kFc5yX8PUHCPkeKS90vsU0/zY8/NnOjoI9Xbqn68Bd4y8dgRC8D+OLkzJH2VpwukX0cjjfWepdbT3kBNC0zliSRqUwSaOI/6XcGqDtu431eiBE6D/mGZ3YYbEfzGtVrSp8aZXtM3DGiG16eoT1RzrB5DsftDYEvZXdhfVDTfHE1D5iWA3RFxwQBcb30+kuk6Wd3Qdd9aOM16GikeVSpykmQ+0WYFzmEaeNF7FA81xk+34eKvg1sKgepKb2897hRiocX+lwHlSKx5W3RFC3aVT8UAEilw3Dh/FGtRhcmZ02vWHBSGoRU4t0cu+x7K4VbT05g+mwQnMpqvu6E7/tYhLhAUAvNi/fh+avfo6LZt95RFzDMqqm2DXQhu9I/IPaTM3pT3QvzXXZlD4rAg9vlag2IVRaibt30bxhffmp1KCnj1EDQ2k6fMpqHV1HnUfKgr97gYVbWwyJffXCADV0Mrxih7QluPXjsht/2WJpPBpuZmxdtjtjTlBtvVpvXwhHUjiDqEGpUM0I0p57/7Xkn9ciFhOMPeHW+ZMJBez3TVCV7vUwc27qvgL221XIpwYZHAsf8cBIbNPhUA2BJka0f4jQdaRgSdcTXoJv7rLNECL7zl+j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(66946007)(66476007)(36756003)(53546011)(8936002)(66556008)(31686004)(6506007)(2616005)(83380400001)(44832011)(166002)(186003)(33964004)(6512007)(38100700002)(4326008)(8676002)(316002)(508600001)(6486002)(966005)(2906002)(6666004)(110136005)(86362001)(66574015)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZYVVlaNXZoMG1ZL3FJKzlrUFpYUzdtcm1CYmxncGlCVk05MWlWeVE3T0tZ?=
 =?utf-8?B?OHFlbnNDdFM5MnkvR0d3NXZ3bWxKU05kdWZjT1AxUlFQK3BjL1dVQ1kyeUVR?=
 =?utf-8?B?VTdCanAyaUNzVGpSOWE1b203Nk5TWExjdSt1bVBBV3I0dnJ6SXlsTSt5Y3ZZ?=
 =?utf-8?B?ZmhML1J1ZkZqREpoK2xMWkJFZUxKaXd4V2p6T0x0M29sMDJ6YUtjSDV2cE04?=
 =?utf-8?B?WkR6K2NoMEt6RENIbGViN2Eyb3lMZnY3TTB6c2dwcVVaRXVQLzNqVndaeTlD?=
 =?utf-8?B?QmNtcHV2bldYSXNwVUF3WUtJWkFZcnpFRml6VnFyZ1JOcDh0d2tEdlo1eTdZ?=
 =?utf-8?B?QUtZK0wzM2dSdG91TlA1Nk5YamZ5b295MWdSTmswY1V6MmxmdENYRHc2NHow?=
 =?utf-8?B?am9EeTJod05pbmJjenpZWUo2K1lDWlJiUTkxc0JBNlhwSURsdXY1dUt0QjU0?=
 =?utf-8?B?K3Y1S0hEWkxRcGNPT1kvek9DOXZOZy9tSk9qRjhVQi9QVU5Wc2Z5eTJsN2lJ?=
 =?utf-8?B?cXovTHVyQkc5ak9nQnJKSEFwYmNremh6NTZCMjhiMmxNeTREU3BtWVArT0Rs?=
 =?utf-8?B?Yk4vaFlIeTB0SGs1TSt2TTZEdGUwbVJtZ25tczd2MURYU0F6YjVWTUxGdjl5?=
 =?utf-8?B?aktwUkZMWkpWb3ZPUXQ1QWVIRFBZdmNMRTlWZFpBS2JWSDVrSEdzVWtibytP?=
 =?utf-8?B?K0FYcFlSaTJnM1JyWkE1ZkM5VE5kVXZqelhkNzVPcEJCTkc2QW9rS0c4UXhW?=
 =?utf-8?B?ZUt0ZWtMd2FjOERoQ1kyM0hlL2VNQno3SVcrTGtnaHUwN0t1OXdvM1JzSm5N?=
 =?utf-8?B?N1VxdkxtTGRveVhKdGloL3Fydi9tamxmbVBTNGg2N0hEWlVPOVhUa1hpbzNj?=
 =?utf-8?B?Nmw5djlkNWlLRmZhWkxhVGpERmxVZnJnMk9QdXZhckJhTCtubTFRZkxHakIz?=
 =?utf-8?B?OFIyQStnZjNRYjdaaEROZllMRjdJUDY0NHRaY0duN2R1Y09pUStaZjZQa1RF?=
 =?utf-8?B?anZocmpNeFFwMHVaTTVBL1Iva2JxOVZBZ2dmZUlEQVI5LzlvVHRCSWgwYWZT?=
 =?utf-8?B?TUxnVWNYU1BYV0tKUWZOcEtPajJsckVuck8vUkllS0YwRFN6YWRCVm1uV3Nu?=
 =?utf-8?B?YWM1Q1hISmx2dm05TmNsRmozQ0lDcmNQMVAwNXZCbk16aDlLV1QwRGthZWk0?=
 =?utf-8?B?WSs5THRETk81Q2NhSEdrZUg4bUdEOElRRTVIcXhHY2J3aEJockVETFZsMmVw?=
 =?utf-8?B?bkY1Z2pnVEdTL1JhQVh2WUppOGNDZkMyVm9uYndCKzRaOE1McFpzcUZaMG5H?=
 =?utf-8?B?cXFXVGVTc3I2aUhyRWtMSzZxNzdVTW5VZm9aOW1EL2YzRjB5dlpyWXVkMHI2?=
 =?utf-8?B?eStYV2dpTXFqUEFTWGxFRlp5YldWRkh0NTgra05uOWVmaW5uYjhzUFBFYlE0?=
 =?utf-8?B?WFkydkZGWEpncFpMb0t3T3dVcXk2M0lEbmYxVXdFSktubHlqdlBrVUZUWjdZ?=
 =?utf-8?B?c0xRSkpPQXc1RWJRaTJ1WFZQaHltRm4wc3VvT05xdzh3NW5KbGJTcnFZSkxC?=
 =?utf-8?B?dWhTeFh5SnNqN2J1Wjc4dUppR29GcDZEanNFZTk2eUdYRnJmbGtlNEZucWR2?=
 =?utf-8?B?emJaTS83dXR1QlNQT3VybzE4bVZuZUpQZ3JBQzdqTHhmZC9rN2lBYnZBYlY0?=
 =?utf-8?B?RDB0cTBWVWRMMUp6cmhWL1h4U3p0T0M1MnUyUCtHeWhLZVNUTUs3MFMxR0RI?=
 =?utf-8?B?eVBxc3RhZVdxajcvV0h6K2NWN0VDZXJJNVdubHlhcHpJOCtPRXFrM2gxNUFW?=
 =?utf-8?B?bFNUWkcvdkNXV3ZvbnFnMndwc3VPU3ZHaHpSMTV2eTlCclN0a1hKNit3SmE3?=
 =?utf-8?B?bGVSdjdDd1RrUjdTek1hcDFsTkcrSGM2NEE5QTVPbnNUY1Z5TkNiajd0WkdI?=
 =?utf-8?B?bS9oeWZDa3UvSUZHMFg2dVJYbVhHR3JhVURYZUpBdVFUUlplRElEQjNwYzN4?=
 =?utf-8?B?amxtMHNjWFlZUDdkRk5WK0o1SnRKYmJBWitmUldGaUNybDNDSmFxMWtrUVor?=
 =?utf-8?B?K0pNeFNIQ2NOT2hNV2dvRXN0Y1JmdUlPb3Z1OWJIVlIxVms3UnpYazNtZ1dX?=
 =?utf-8?B?OUJqYVlsT3k5TmNmZjNHUVV6RDhnUWZwMFN1azJxeE9veE1iblplNmFscUFi?=
 =?utf-8?B?dmhSVXBueklTV0xndXFlbWZEMEFDTGpxSjNEN2Q2RDZmdW1aWEpXcWxCelBk?=
 =?utf-8?B?eGRzOWNyRHB6NHVXaVBta0xRbVdJczVXTlRJekMyQko4c3NBYk1QNThISVkz?=
 =?utf-8?B?V0hwTXhFcFNEUG85YTNYWnVpd2o4OS85ZTJCSENYMWtuTWwzd0cvWENlai9T?=
 =?utf-8?Q?d+YFH+yEotaD/krjwLmxZmytfS3aVGhQYtymGEo2rQLdh?=
X-MS-Exchange-AntiSpam-MessageData-1: INMosgZ7snKtkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca40d39c-4ccc-46d1-8a37-08da399d4ab3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 13:41:35.3994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v8k87H9w8ytjIcTOHsZJ+qaDP+QEp89UPZe0ShZoaZH4nzrBgkBzt7hjgvsI2yGT/0WBBdxR5bgMh+8ksI/sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1868
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------QAPpV04o6BrcAfe3EjKE6sEr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-05-19 03:58, Christian König wrote:
>
>
> Am 18.05.22 um 16:24 schrieb Andrey Grodzovsky:
>>
>>
>> On 2022-05-18 02:07, Christian König wrote:
>>> Am 17.05.22 um 21:20 schrieb Andrey Grodzovsky:
>>>> Problem:
>>>> During hive reset caused by command timing out on a ring
>>>> extra resets are generated by triggered by KFD which is
>>>> unable to accesses registers on the resetting ASIC.
>>>>
>>>> Fix: Rework GPU reset to actively stop any pending reset
>>>> works while another in progress.
>>>>
>>>> v2: Switch from generic list as was in v1[1] to eplicit
>>>> stopping of each reset request from each reset source
>>>> per each request submitter.
>>>
>>> Looks mostly good to me.
>>>
>>> Apart from the naming nit pick on patch #1 the only thing I couldn't 
>>> of hand figure out is why you are using a delayed work everywhere 
>>> instead of a just a work item.
>>>
>>> That needs a bit further explanation what's happening here.
>>>
>>> Christian.
>>
>>
>> Check APIs for cancelling work vs. delayed work -
>>
>> For work_struct the only public API is this - 
>> https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3214 
>> - blocking cancel.
>>
>> For delayed_work we have both blocking and non blocking public APIs -
>>
>> https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295
>>
>> https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295
>>
>> I prefer not to go now into convincing core kernel people of exposing 
>> another interface for our own sake - from my past experience API 
>> changes in core code has slim chances and a lot of time spent on back 
>> and forth arguments.
>>
>> "If the mountain will not come to Muhammad, then Muhammad must go to 
>> the mountain" ;)*
>> *
>>
>
> Ah, good point. The cancel_work() function was removed a few years ago:
>
> commit 6417250d3f894e66a68ba1cd93676143f2376a6f
> Author: Stephen Hemminger <stephen@networkplumber.org>
> Date:   Tue Mar 6 19:34:42 2018 -0800
>
>     workqueue: remove unused cancel_work()
>
>     Found this by accident.
>     There are no usages of bare cancel_work() in current kernel source.
>
>     Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>     Signed-off-by: Tejun Heo <tj@kernel.org>
>
>
> Maybe just revert that patch, export the function and use it. I think 
> there is plenty of justification for this.
>
> Thanks,
> Christian.


Ok - i will send them a patch - let's see what they say.

Andrey


>
>> **
>>
>> Andrey
>>
>>>
>>>>
>>>> [1] - 
>>>> https://lore.kernel.org/all/20220504161841.24669-1-andrey.grodzovsky@amd.com/
>>>>
>>>> Andrey Grodzovsky (7):
>>>>    drm/amdgpu: Cache result of last reset at reset domain level.
>>>>    drm/amdgpu: Switch to delayed work from work_struct.
>>>>    drm/admgpu: Serialize RAS recovery work directly into reset domain
>>>>      queue.
>>>>    drm/amdgpu: Add delayed work for GPU reset from debugfs
>>>>    drm/amdgpu: Add delayed work for GPU reset from kfd.
>>>>    drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to
>>>>      amdgpu_device_gpu_recover
>>>>    drm/amdgpu: Stop any pending reset if another in progress.
>>>>
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62 
>>>> +++++++++++-----------
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 19 ++++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 10 ++--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  5 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  6 +--
>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  6 +--
>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  6 +--
>>>>   14 files changed, 87 insertions(+), 54 deletions(-)
>>>>
>>>
>
--------------QAPpV04o6BrcAfe3EjKE6sEr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-05-19 03:58, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3abdd2a3-2cb8-fc8f-fd5d-a8a7cd5fc828@gmail.com">
      
      <br>
      <br>
      <div class="moz-cite-prefix">Am 18.05.22 um 16:24 schrieb Andrey
        Grodzovsky:<br>
      </div>
      <blockquote type="cite" cite="mid:ce60a983-9906-e33f-a2cc-6fedb958a124@amd.com">
        <p><br>
        </p>
        <div class="moz-cite-prefix">On 2022-05-18 02:07, Christian
          König wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:1a7fd05f-490b-9999-5f0b-e84af26504a9@amd.com">Am
          17.05.22 um 21:20 schrieb Andrey Grodzovsky: <br>
          <blockquote type="cite">Problem: <br>
            During hive reset caused by command timing out on a ring <br>
            extra resets are generated by triggered by KFD which is <br>
            unable to accesses registers on the resetting ASIC. <br>
            <br>
            Fix: Rework GPU reset to actively stop any pending reset <br>
            works while another in progress. <br>
            <br>
            v2: Switch from generic list as was in v1[1] to eplicit <br>
            stopping of each reset request from each reset source <br>
            per each request submitter. <br>
          </blockquote>
          <br>
          Looks mostly good to me. <br>
          <br>
          Apart from the naming nit pick on patch #1 the only thing I
          couldn't of hand figure out is why you are using a delayed
          work everywhere instead of a just a work item. <br>
          <br>
          That needs a bit further explanation what's happening here. <br>
          <br>
          Christian. <br>
        </blockquote>
        <p><br>
        </p>
        <p>Check APIs for cancelling work vs. delayed work -</p>
        <p>For work_struct the only public API is this - <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fkernel%2Fworkqueue.c%23L3214&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C29fac8e733b14ee2551b08da396d5093%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637885438944206302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=6FMDy2apJCIkLEW8DE1t7sAfnDIJ%2Fm%2BCGo7ME5nRMzI%3D&amp;reserved=0" originalsrc="https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3214" shash="fuy0PYQymaWnVrdD3sOhZLnqjUKO8VSpEEYhcosSkT1HuW7cRvY6RZF5ybgsnzOmJ2tMlglk7Oa+SzXu4sO2Hho0Krmu5/IcsAbeEADZ+W7J3SuYSBJaCLwwpSn/EH7pfpKGeHIglBMQ4PLkmcISc9J4wguUPxaiHx3FX92n6yM=" moz-do-not-send="true">https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3214</a>
          - blocking cancel.</p>
        <p>For delayed_work we have both blocking and non blocking
          public APIs - <br>
        </p>
        <p><a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fkernel%2Fworkqueue.c%23L3295&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C29fac8e733b14ee2551b08da396d5093%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637885438944206302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ci%2BVEDdbi7ub%2B9p4y5tth7SZvjBiRCkBm4%2FrhDavEnM%3D&amp;reserved=0" originalsrc="https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295" shash="fFYuA/PjoBFLlKdXj0Oivc/vDEX78KLK90RDFaoCYwWlUbXrgZ+MqhJvXMet0hRhM8A8FFmMxWRW3rnjTRbt0OsdqQ0/fFn86hFR79AjYwtUlpraZMYQU5WE9k5uSZ9B3rxdeGUqEPlt4cSszC+YfhAi/t8wjdHq/U/skYPttIc=" moz-do-not-send="true">https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295</a></p>
        <p><a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fkernel%2Fworkqueue.c%23L3295&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C29fac8e733b14ee2551b08da396d5093%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637885438944206302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ci%2BVEDdbi7ub%2B9p4y5tth7SZvjBiRCkBm4%2FrhDavEnM%3D&amp;reserved=0" originalsrc="https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295" shash="fFYuA/PjoBFLlKdXj0Oivc/vDEX78KLK90RDFaoCYwWlUbXrgZ+MqhJvXMet0hRhM8A8FFmMxWRW3rnjTRbt0OsdqQ0/fFn86hFR79AjYwtUlpraZMYQU5WE9k5uSZ9B3rxdeGUqEPlt4cSszC+YfhAi/t8wjdHq/U/skYPttIc=" moz-do-not-send="true">https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295</a></p>
        <p>I prefer not to go now into convincing core kernel people of
          exposing another interface for our own sake - from my past
          experience API changes in core code has slim chances and a lot
          of time spent on back and forth arguments.</p>
        <p>&quot;<span style="color: rgb(32, 33, 36); font-family: arial,
            sans-serif; font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            letter-spacing: normal; orphans: 2; text-align: left;
            text-indent: 0px; text-transform: none; white-space: normal;
            widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
            0px; background-color: rgb(255, 255, 255);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial;">If the mountain
            will not come to Muhammad, then Muhammad must go to the
            mountain&quot; ;)</span><b style="color: rgb(32, 33, 36);
            font-family: arial, sans-serif; font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; letter-spacing: normal; orphans: 2; text-align:
            left; text-indent: 0px; text-transform: none; white-space:
            normal; widows: 2; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(255,
            255, 255); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial;"><br>
          </b></p>
      </blockquote>
      <br>
      Ah, good point. The cancel_work() function was removed a few years
      ago:<br>
      <br>
      commit 6417250d3f894e66a68ba1cd93676143f2376a6f<br>
      Author: Stephen Hemminger <a class="moz-txt-link-rfc2396E" href="mailto:stephen@networkplumber.org" moz-do-not-send="true">&lt;stephen@networkplumber.org&gt;</a><br>
      Date:&nbsp;&nbsp; Tue Mar 6 19:34:42 2018 -0800<br>
      <br>
      &nbsp;&nbsp;&nbsp; workqueue: remove unused cancel_work()<br>
      &nbsp;&nbsp; &nbsp;<br>
      &nbsp;&nbsp;&nbsp; Found this by accident.<br>
      &nbsp;&nbsp;&nbsp; There are no usages of bare cancel_work() in current kernel
      source.<br>
      &nbsp;&nbsp; &nbsp;<br>
      &nbsp;&nbsp;&nbsp; Signed-off-by: Stephen Hemminger <a class="moz-txt-link-rfc2396E" href="mailto:stephen@networkplumber.org" moz-do-not-send="true">&lt;stephen@networkplumber.org&gt;</a><br>
      &nbsp;&nbsp;&nbsp; Signed-off-by: Tejun Heo <a class="moz-txt-link-rfc2396E" href="mailto:tj@kernel.org" moz-do-not-send="true">&lt;tj@kernel.org&gt;</a><br>
      <br>
      <br>
      Maybe just revert that patch, export the function and use it. I
      think there is plenty of justification for this.<br>
      <br>
      Thanks,<br>
      Christian.<br>
    </blockquote>
    <p><br>
    </p>
    <p>Ok - i will send them a patch - let's see what they say.</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:3abdd2a3-2cb8-fc8f-fd5d-a8a7cd5fc828@gmail.com"> <br>
      <blockquote type="cite" cite="mid:ce60a983-9906-e33f-a2cc-6fedb958a124@amd.com">
        <p><b style="color: rgb(32, 33, 36); font-family: arial,
            sans-serif; font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            letter-spacing: normal; orphans: 2; text-align: left;
            text-indent: 0px; text-transform: none; white-space: normal;
            widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
            0px; background-color: rgb(255, 255, 255);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial;"> </b></p>
        <p>Andrey</p>
        <blockquote type="cite" cite="mid:1a7fd05f-490b-9999-5f0b-e84af26504a9@amd.com"> <br>
          <blockquote type="cite"> <br>
            [1] - <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20220504161841.24669-1-andrey.grodzovsky%40amd.com%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C29fac8e733b14ee2551b08da396d5093%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637885438944206302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=NVufR4wmuP%2B6hE6VitPr5Jti1%2FcgxpRywcGpzqMIEnk%3D&amp;reserved=0" originalsrc="https://lore.kernel.org/all/20220504161841.24669-1-andrey.grodzovsky@amd.com/" shash="zrNOsjV9bngBrJJI2hBLdeJZ3W0TApHJpzwO8AyVkzTTrFUsORyPq9+qnes8eYlLlYNF5eGF9xy6/lRZDZg25nd1A25eFM6woda0KbYtDrSCvmcplvwsLXCpw36JGS+4wi9Jxt52Jj8Gyh9Hu/QQh2nUCgPIelzGU/jQCFIfZk4=" moz-do-not-send="true">https://lore.kernel.org/all/20220504161841.24669-1-andrey.grodzovsky@amd.com/</a><br>
            <br>
            Andrey Grodzovsky (7): <br>
            &nbsp;&nbsp; drm/amdgpu: Cache result of last reset at reset domain
            level. <br>
            &nbsp;&nbsp; drm/amdgpu: Switch to delayed work from work_struct. <br>
            &nbsp;&nbsp; drm/admgpu: Serialize RAS recovery work directly into
            reset domain <br>
            &nbsp;&nbsp;&nbsp;&nbsp; queue. <br>
            &nbsp;&nbsp; drm/amdgpu: Add delayed work for GPU reset from debugfs <br>
            &nbsp;&nbsp; drm/amdgpu: Add delayed work for GPU reset from kfd. <br>
            &nbsp;&nbsp; drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_recover <br>
            &nbsp;&nbsp; drm/amdgpu: Stop any pending reset if another in
            progress. <br>
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp; 1 + <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62
            +++++++++++----------- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c&nbsp; | 19 ++++++- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 +- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp; | 10 ++-- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp; |&nbsp; 2 +- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c&nbsp; |&nbsp; 1 + <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h&nbsp; |&nbsp; 5 +- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbsp; |&nbsp; 2 +- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +-- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +-- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +-- <br>
            &nbsp; 14 files changed, 87 insertions(+), 54 deletions(-) <br>
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------QAPpV04o6BrcAfe3EjKE6sEr--
