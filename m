Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B965C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 14:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E9A10F1D7;
	Wed, 18 May 2022 14:25:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3776D10F187
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 14:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diyPjy6fV7FFBHkpQXGz348JyeOOSVqkBh8tfZP2YPAfaJNPNkWtCneimDVn0buH24V+RHlQvpKHDVBVf9PPqpuuEyYlkWvPxw79bTMZp8UUaC+qyGonDFmy/In8fgA7S0vooOFKQlFU0pvo5dEWYP12Ku2ki2YQgcQQuzUxqTCEnyt4iIL0SBdMCAFAzgAEx77lVXLg2qTbnxvYAorav61c+hEJi+CuKFvZeIfhBe6bAFaNgKOr2YrVa/cMReSTxiTuanolXSc23xnTyJ4WRqGZmh0b3zvm7J3kiMhoSEYJRGnO8cRW69vj57keAYWMUVaOie3P7v6IPNoNVU2krg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r+Gq3hxpYNQen26NFnupeKmSN9OMXwfgrB9DYL3Ht0=;
 b=fs4AYlR97tpLGCzQumgCdRpTim5xruAF2jFrXPQ232BonQpXMjgdojAKl5l8Q+DYoXF/Hp68W/n/9U0KUKuM2iq7omAeX4Qnv4K59H/x2Cm2YM4hDYoV8oWQ3yhph8WygSTyqknObmm3iSKU5J17qz+10oGjGFBDIoE8ln6GWFeaW+vn2qWZWAYyK9jn7Aiyr06dyzaFmUlX5rF8DHeSEwYbf+3Y55UnEF9FjTvqsxRQat3jhsLY0ptOWmH8QTwkFXw6gYb/wd9nRnUJrn++bJJCAuMaURlqHyttWbYp+m4lwo9fPxOepTdqPaJDlf+8SC2MIjnL2BM+QNgdosGQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r+Gq3hxpYNQen26NFnupeKmSN9OMXwfgrB9DYL3Ht0=;
 b=zJIRFK+MRv7l0z4wuil+r5IKLeWDL+fafZDIUyDRL4qJ0odQJku/NdAWeF/nt8oggF7m4KyJvvr3Y3ynR1b+JeeKoWqCRQqfmo7lV1F0xAq9mhi+uk/PS7MWwcpJbm1Oz1j4XaDAQdP1VLyIVIX/2RHt+QWEGEkyInfeWEbyt5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CH2PR12MB3766.namprd12.prod.outlook.com (2603:10b6:610:16::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 14:24:47 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40%10]) with mapi id 15.20.5250.018; Wed, 18 May
 2022 14:24:47 +0000
Content-Type: multipart/alternative;
 boundary="------------4HDrxrv93gboxmghHKel16ea"
Message-ID: <ce60a983-9906-e33f-a2cc-6fedb958a124@amd.com>
Date: Wed, 18 May 2022 10:24:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/7] Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
 <1a7fd05f-490b-9999-5f0b-e84af26504a9@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <1a7fd05f-490b-9999-5f0b-e84af26504a9@amd.com>
X-ClientProxiedBy: YT3PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::29) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf4f4c0a-65b9-4145-71ed-08da38da2925
X-MS-TrafficTypeDiagnostic: CH2PR12MB3766:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3766C9F73F6B25403FCC716AEAD19@CH2PR12MB3766.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fgpajw37bUqWSoucbslwNMjmqOG+J22GP6muhR7vTkFWxBPa2imPcMNS5w0jo+qrAjABzivQARAzlhvFbN78P+ZGG65SWfHNr3qJ0g6J4h1odKUaNdmDT+3i3XbyfUvMmS7vZ26LgayBqZdMKhlxGa3xIxEQZmgOHomelqkj5y1vOaZLACSiE5dbSfnVSl//p/EXJ9+k5RV35hSjUmRkSessM2gPW2ls0rNWuS/OdAHXiJRxrZjsptaR7Vuhcr7m9nOc4HHgwUVay84fltFV1yN39DQrZDlb0kSdA4YYe0SPDKfNKwg702d+y+5I6SDr5+a5OKDVdwD0VpX05PeLJcD7iuu5kJ+8on9KeDsKZhGdBs6sqMBe/sBWWuzJnkTiShiw383mKuE3vT5Bx914ptjBDaCM9jK742qrySLv93BSQK7o2oyPwSnn43wgcR/cHvxCB1BCbWyfJWZOT0MAv94InSNQRRa4NubCviBoAAktQhhVXxYtAqbJE5S988yryRiTz2CA/ZXvN8SX+YHUP0YNd6zuiq7krw7Vf+rJZPxXuTgLv86cHfJqOyxpomnzHczmgBABp98aADm0ZNJvngHFrs6PcCkSre7Y1P3dbRlXtlSpgQLj9cZjqidUejCjavC11VdBPyGPMV7mXdf5cjxgG6x8QeRxP5PZiL5J4RQK8bXdn98YVnIuXag4Ple4Oba4T0GdeuqGaxdvPdIp1Cz/9RhzavxY7RQhwuc+PVtGwqltKta4Kg60WVYaiaMeS3AwKfMmZs4wqiBW1vIvrIEn8CN+jUjpwK2q+oa0hi+UMY2mi2D9bNDWoWwIK4Ch
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(5660300002)(31686004)(53546011)(186003)(33964004)(44832011)(166002)(6506007)(36756003)(83380400001)(66574015)(2616005)(8936002)(66476007)(38100700002)(66556008)(508600001)(966005)(2906002)(6486002)(86362001)(31696002)(8676002)(4326008)(66946007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnRYemtmVXRGMHFjT0psTTU1TXEwSnpmelhtYU5iQWx6SzB5Vmxua1lNUGdL?=
 =?utf-8?B?TCs3YlJnVm1NWFFqdHVsN2U2WXdUc0t1YVFxcU5nWVhmSUNtL2pwUEs5Z2hS?=
 =?utf-8?B?eWYxU1VYSkxjck1uMmZvaElsalBNM3RhbGxVWUVBWnZwUFM4TU91d1FUU1dw?=
 =?utf-8?B?U0FjMFJMaURHaVNHNWFTKzBTYitsc3lxOW9IeVRHSWxTWXFxV1JVTGdtNnRD?=
 =?utf-8?B?RitENTMzeHpoYWVvN0w4VXhTTk9xMkJxb1lOYkVZYWY1S3c2NVN4djN5L09v?=
 =?utf-8?B?SGxxb0RTaWxiYUU4eE02aFdCU1l2enEyZERoYmt2bWw3WDR5UThGNmlNc3hV?=
 =?utf-8?B?Ym5CeFVuR2NsM1hDRnV4Vk1mdzh2NHZ0c05MUzlJQlFQakpzYW9JaW9wck9y?=
 =?utf-8?B?Mm16NXVZTDNHd3NVK1ljMGNjMGIvTkptYTRDQ2ozSW43SHRJSDNyUWxPMUhq?=
 =?utf-8?B?dnIyTVZhczNxKytXRWRSMEMxSnBSL1JSRzlqOERLK2hhZHZOeXdMMU1qdnZ1?=
 =?utf-8?B?a1VuYm1WNnNYT3JSb2haS1ZyVTVqVWdEM1h3bm5CaXN4R0NFRzRRbzJUaFV3?=
 =?utf-8?B?NjFtaEFheTFsdHQ4Vm9LcFJMNnZ1MjhUdWdOWFpyQzFmTXl4bkI1ekg4UUV4?=
 =?utf-8?B?aGRTNGpKcERyT0k4eVkrMThXV0VoZ0Vzc21wR25leDZZMjlvNDdhcGRJQzNS?=
 =?utf-8?B?SEkxQytnQjFzeU05OC9DdDRiMkJFRGIvdUNCUHZvckVyQU84b0NvYWJZd2dJ?=
 =?utf-8?B?aU80eXQ3bzNHek5ZUGErcGd3VDFaUGhyWHljVDFRbVJpTERTN2VpYUpnZGQ3?=
 =?utf-8?B?M3oxckxKWWpFK01jVUR2TFJxOWY0ZXdYKzdLWVYwc0VicjlaMFoyanlLU0Fn?=
 =?utf-8?B?ZFJMYlM4S0l2MjdDSFdodXFqSEtUbUl6VW81RklDOTFob3E1SGcrYkNFVTY4?=
 =?utf-8?B?YzQ3VjRIK3JLR21mZVNCQWxtTlgzc1NhYk9WSWtWR3BnQ09uKzVkd3lpYW5Q?=
 =?utf-8?B?MnBNRE0xMm1yYzM5L25oclFhdG12Rjh3Z29Fb0dIVEc4bjBlTUdIWUdqUGMy?=
 =?utf-8?B?RVB0THo0emdhTnJkaXhYN293NWpuUnAxN0JTaVpoZVZ3UThTaUMxNG5xb0cv?=
 =?utf-8?B?R3dBMWdDSWoxbENxTGZnUHdTSS8za3BXOHRQLzZVRXU5eEJEc2h1VFYzNlEr?=
 =?utf-8?B?WDZndTJlY2hUckFBZlNsQ1c2TEkrd01tZWJ1aFVXTnhZOTk5RG11QzZGRFox?=
 =?utf-8?B?eDdndk1RM0Q1MkxmU2wxT0RScHp4cklZWnNRdDZLQUp3UXdSYXYwRTVkZ3Ix?=
 =?utf-8?B?OWdVbCtqR2xLMHZ5UmxQV21Ydm1BcDBKNFM4OVhYTlZWTGpvRzExekdHZkJ1?=
 =?utf-8?B?Qko1V0ZJYjBvM2EyMktPRGEzeHhmZ1BKdWJ5TDRFNEhySDFYMUpWQ2R3Rkhh?=
 =?utf-8?B?M2NQV2crVERTRlRveVVJSEpnL2RYVzAxNE9LSVZjT1lXZlNEOUNxT0VMeHJV?=
 =?utf-8?B?QVBCb0NzbCtLMVFrT2JLQzJaRjdBblZrRjlpeUtyamFvbVA3UDVzd3JEMGdq?=
 =?utf-8?B?NmRiMDIwMjdIdVJkMnp1cjBzTFV2RUF0ZjdkL241cU50eGVURUNRdmIvTGRl?=
 =?utf-8?B?TklXZkhYZjBQZkt6d1NETEQzdHlZY2tBRk9SaTUzUHlmZTYrNU5zaStlWlY4?=
 =?utf-8?B?Z0FKWlJBcDRRR0Y3UUpjZmlUUnJ2QlJOWTc2Rkx5ZmRqRUZ6bDJtejBNSU0v?=
 =?utf-8?B?Ky9jWTRaUGZ5UlFMSklJaFhDQzVDdlhMRisvVXBGUU96MEhMLzZsdjVWZ1hq?=
 =?utf-8?B?bDZ1Qk01a0dNdjI0Nlo4MU5YSnVLT2lCb3oxMGk5N3JWekJPNG9tVHdZNHVC?=
 =?utf-8?B?N1RQcXo2SHBobCs1NkFPMk9lRlhGeE4xdzlDMEFZYjlSZjFsRmhobTc2VVBi?=
 =?utf-8?B?dnBzUWw1TFdYZHBVSDMrWWh1UE45RXhMUjZXQ0VxSWNmczJJSHlTMmdGTDhm?=
 =?utf-8?B?NTNDTzVKMFd5Mk54WjhDUTRwcmVwYllpWEs1aG04TVR1MHliT2p2c0hURWtV?=
 =?utf-8?B?TndUc3FjZ2o2WVpTcHpBR09KRS9OeGZRekhjOTlhMEsyS0t1bko0YjZHRTVT?=
 =?utf-8?B?dTZ1MmVUd3F1WXA5TnN4RVpGQUx0UWt3TTJRMEsvbVQvakxuTTlxZGtBRmlX?=
 =?utf-8?B?Uk0xczRHQlNRM0MwbnV4UUJveUlUV2VWekVZcEZ4WHRkVW4xNXg5dnoreW5P?=
 =?utf-8?B?N3JLaUFEYnlCZkd2WU5Yc3pheUp6VEY1WFhSUTA4Qjg1eHpLcG43ZG94SlNE?=
 =?utf-8?B?ZURIUWw2TjBzS3ZsdlJMdGVXK3ZOZU4yYzNBTjJ5U0ZxbVRhUDgvWEhqUThx?=
 =?utf-8?Q?65s2CjXrqaLoZZTvnad0y6PQxFWHHAh6CTd2uKcCtmohf?=
X-MS-Exchange-AntiSpam-MessageData-1: 4fQFJSBw8UWCyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4f4c0a-65b9-4145-71ed-08da38da2925
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 14:24:47.1942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xv/QCZ7ofLSdnx20/oZBbasrYGUsK3DBTkHEJHjVUG6lXnJWUWbyseDS4VmXA2ivUUsLYqsmsH3/6W6jqDvQcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3766
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

--------------4HDrxrv93gboxmghHKel16ea
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-05-18 02:07, Christian König wrote:
> Am 17.05.22 um 21:20 schrieb Andrey Grodzovsky:
>> Problem:
>> During hive reset caused by command timing out on a ring
>> extra resets are generated by triggered by KFD which is
>> unable to accesses registers on the resetting ASIC.
>>
>> Fix: Rework GPU reset to actively stop any pending reset
>> works while another in progress.
>>
>> v2: Switch from generic list as was in v1[1] to eplicit
>> stopping of each reset request from each reset source
>> per each request submitter.
>
> Looks mostly good to me.
>
> Apart from the naming nit pick on patch #1 the only thing I couldn't 
> of hand figure out is why you are using a delayed work everywhere 
> instead of a just a work item.
>
> That needs a bit further explanation what's happening here.
>
> Christian.


Check APIs for cancelling work vs. delayed work -

For work_struct the only public API is this - 
https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3214 
- blocking cancel.

For delayed_work we have both blocking and non blocking public APIs -

https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295

https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295

I prefer not to go now into convincing core kernel people of exposing 
another interface for our own sake - from my past experience API changes 
in core code has slim chances and a lot of time spent on back and forth 
arguments.

"If the mountain will not come to Muhammad, then Muhammad must go to the 
mountain" ;)*
*

Andrey

>
>>
>> [1] - 
>> https://lore.kernel.org/all/20220504161841.24669-1-andrey.grodzovsky@amd.com/
>>
>> Andrey Grodzovsky (7):
>>    drm/amdgpu: Cache result of last reset at reset domain level.
>>    drm/amdgpu: Switch to delayed work from work_struct.
>>    drm/admgpu: Serialize RAS recovery work directly into reset domain
>>      queue.
>>    drm/amdgpu: Add delayed work for GPU reset from debugfs
>>    drm/amdgpu: Add delayed work for GPU reset from kfd.
>>    drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to
>>      amdgpu_device_gpu_recover
>>    drm/amdgpu: Stop any pending reset if another in progress.
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62 +++++++++++-----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 19 ++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 10 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  5 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  6 +--
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  6 +--
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  6 +--
>>   14 files changed, 87 insertions(+), 54 deletions(-)
>>
>
--------------4HDrxrv93gboxmghHKel16ea
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-05-18 02:07, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1a7fd05f-490b-9999-5f0b-e84af26504a9@amd.com">Am
      17.05.22 um 21:20 schrieb Andrey Grodzovsky:
      <br>
      <blockquote type="cite">Problem:
        <br>
        During hive reset caused by command timing out on a ring
        <br>
        extra resets are generated by triggered by KFD which is
        <br>
        unable to accesses registers on the resetting ASIC.
        <br>
        <br>
        Fix: Rework GPU reset to actively stop any pending reset
        <br>
        works while another in progress.
        <br>
        <br>
        v2: Switch from generic list as was in v1[1] to eplicit
        <br>
        stopping of each reset request from each reset source
        <br>
        per each request submitter.
        <br>
      </blockquote>
      <br>
      Looks mostly good to me.
      <br>
      <br>
      Apart from the naming nit pick on patch #1 the only thing I
      couldn't of hand figure out is why you are using a delayed work
      everywhere instead of a just a work item.
      <br>
      <br>
      That needs a bit further explanation what's happening here.
      <br>
      <br>
      Christian.
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>Check APIs for cancelling work vs. delayed work -</p>
    <p>For work_struct the only public API is this -
      <a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3214">https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3214</a>
      - blocking cancel.</p>
    <p>For delayed_work we have both blocking and non blocking public
      APIs - <br>
    </p>
    <p><a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295">https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295</a></p>
    <p><a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295">https://elixir.bootlin.com/linux/latest/source/kernel/workqueue.c#L3295</a></p>
    <p>I prefer not to go now into convincing core kernel people of
      exposing another interface for our own sake - from my past
      experience API changes in core code has slim chances and a lot of
      time spent on back and forth arguments.</p>
    <p>&quot;<span style="color: rgb(32, 33, 36); font-family: arial,
        sans-serif; font-size: 16px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        letter-spacing: normal; orphans: 2; text-align: left;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial;">If the mountain will not come to Muhammad, then
        Muhammad must go to the mountain&quot; ;)</span><b style="color:
        rgb(32, 33, 36); font-family: arial, sans-serif; font-size:
        16px; font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; letter-spacing: normal; orphans: 2;
        text-align: left; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial;"><br>
      </b></p>
    <p>Andrey</p>
    <blockquote type="cite" cite="mid:1a7fd05f-490b-9999-5f0b-e84af26504a9@amd.com">
      <br>
      <blockquote type="cite">
        <br>
        [1] -
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20220504161841.24669-1-andrey.grodzovsky@amd.com/">https://lore.kernel.org/all/20220504161841.24669-1-andrey.grodzovsky@amd.com/</a><br>
        <br>
        Andrey Grodzovsky (7):
        <br>
        &nbsp;&nbsp; drm/amdgpu: Cache result of last reset at reset domain level.
        <br>
        &nbsp;&nbsp; drm/amdgpu: Switch to delayed work from work_struct.
        <br>
        &nbsp;&nbsp; drm/admgpu: Serialize RAS recovery work directly into reset
        domain
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; queue.
        <br>
        &nbsp;&nbsp; drm/amdgpu: Add delayed work for GPU reset from debugfs
        <br>
        &nbsp;&nbsp; drm/amdgpu: Add delayed work for GPU reset from kfd.
        <br>
        &nbsp;&nbsp; drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_recover
        <br>
        &nbsp;&nbsp; drm/amdgpu: Stop any pending reset if another in progress.
        <br>
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62
        +++++++++++-----------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c&nbsp; | 19 ++++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp; | 10 ++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c&nbsp; |&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h&nbsp; |&nbsp; 5 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbsp; |&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +--
        <br>
        &nbsp; 14 files changed, 87 insertions(+), 54 deletions(-)
        <br>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------4HDrxrv93gboxmghHKel16ea--
