Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A4FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351AE10E481;
	Tue, 10 May 2022 20:31:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75C010E481
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2ce717aenirodiePFfIKryhbT4UFC1YhLaUxJZ4p6RULRowtd7rjoJPDr0U/lN6dK3Mt8486f9Vvn+rVubllLkMpPWXJkOcJ/jqWnohFeciRyP5albDM76yKV6T0eO3qsIsSJthKEG9LBL4yU0c9hjmGQOdjC+EM9QLVeHbpyd9FQHablSRvOtajthtncRhcxXgVkfvbXAHCI3W8fYaUVcPVfa1P4I/dBTBw251dKenn6Ew0HeEWVX6pdgFIhkofQr4mF62OYK2vH2tlLX+qcHh8MZ94Vy2ki+hgUDwtzdBqO3FnW5u0cTePHWZP334REn5W42Df83p+2NCIVH9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9YCXy1C7rLi3u6esucMKBP7t4Jj93zU9RZUqZ78C5w=;
 b=eaqr9hxtOP+gRzTip4Ih5fhZ+ltefM63MlAuPqG93j358KUC22uhD/ibPEZR+tgdkkgvXkFvmqh8oyWfnnXkx9ZearDqUlZ0UdRgDkOmYNYIpP7X6fGE4WmLH8nIwhoq6Rrjz1eaKecOOTZgNRcvEpuh8hyyWTlxDnhc6Gg8o+IdMnQqtQ3GOjSb1TPxpAodA+PbGnAuxr9DMcthcZmPHHIeIOCyH7aeaGno9qiZoZhQZICCjl2ZgzTc4Vx3n4PeHPmo3I3iPSy4BdxFxEbvejIFIbWJu0LuKz1n7aZX25eXySlUlulvSX1GXwecytLcFN/ypt2rdgcsfMW8Q/sdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9YCXy1C7rLi3u6esucMKBP7t4Jj93zU9RZUqZ78C5w=;
 b=q2yccdzP4ywT1lNf0olf+/DlGoaU1DR19IyHAWVCDb/nZ4XwgT3VEf5SUNuOLfFamiv7MQslVvFg2XmVkYuJV6xR6M/e/VWcjZuXCwoGbsc4mypcYP+LQ2/iceHaHW9CWj4zTFDOzjAbQiR7HHEA6OJyR7Z7oEU99ooxF1oJpXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 20:31:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 20:31:50 +0000
Message-ID: <15805b62-2e43-b469-0816-1083c5e76acd@amd.com>
Date: Tue, 10 May 2022 16:31:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <08212428-471E-4C1C-9037-9AE16E9BA356@microsoft.com>
 <5c22aa65-f75d-bc05-e210-f28533d9f0f8@amd.com>
 <5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com>
 <c771861c-f25c-1953-3cb7-f805ddb11aa3@amd.com>
 <B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com>
 <42927224-900a-8548-80c4-13cda4d3f867@amd.com>
 <76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com>
 <c82b697a-b032-1b03-8a9c-49af57f4ae9e@amd.com>
 <7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com>
 <c5a41b51-5275-05dc-2a4e-2522ddb898b9@amd.com>
 <0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com>
 <77a8677a-0ac9-74be-598d-a2e8cf4d6883@amd.com>
 <549246A3-B326-47CC-92FD-608708E1876B@microsoft.com>
 <34789d77-b8ee-1e4f-c5c2-f32f42f923dc@amd.com>
 <0d99be40-f6b9-b191-feca-d74344f03bf2@amd.com>
 <FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com>
 <66bf32d5-1636-ecdd-8a49-24c6254079bf@amd.com>
 <E4C3FDDE-9948-489E-816B-D2777C07BD2E@microsoft.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <E4C3FDDE-9948-489E-816B-D2777C07BD2E@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb95deb1-0d5c-4eae-002e-08da32c41ce2
X-MS-TrafficTypeDiagnostic: PH7PR12MB6585:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB65852DCF2998B19721C6E73C92C99@PH7PR12MB6585.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3wlQ2Od44i4oHVAbwxMCj84nKAwg6n6u5e4G5Nc/6x04Jql+UaJfP8NXsD6mco7qK46/na88GiPn9EeQQfRvtcLbdkQbjJCWZoSw56nJ+lyS7zrXulx6Tqe01uWkdzHl8AI0ezJh1FU7EU+91XcltifBDthvjQuXO0QOlnYhtZrnGXPNM4zgy9vCnuczwLERoXtd/NI6gggLbMk4ejE4w13iN3Wh4Yp92KfDDuwxogTAUHCtacc7Rq3P7h5aW/lmijI5zeQU+EZzaqE4bvQyMTnwu5zWlcU/jZjvzjxWKURoTvE58Bh8DChbwT7/V23phWARrshuVgqsBJtpXyVaRPbSlGdTDufbxxw3I4sR3Wb2v83E/X+yykb2Ixs5/bwh+xDM4Vtb49H5m870NewtDK0NdhAenzAF9TSF4hT1FPsLh3IgG5241mvJWLrHIinYTnNqAPIEqyZ58c0oiqKUPfENNi/O9S17+mpEQfJw2NIyO2M3G2CD0Qsgevmdtbm3CdoAK+zhAtVvtuNCwLRZZEfwdpCxYM20E38FRWycJCbFBmPoFiG8731ao4OZ4n4QwW6p34bds09QxoNmIjZ7ymFMEG240op1m4glIwMh9IiOGHPg48LTHMK5tbs98lHkidM79Wxca+mnn8QqJMjgtTuD1SzvCFtEsRs6+PankBz3QR3X+aOhytu2q8pu8AIqVtuGPZ1YZxzt1wDmCITGPSGssBZSQbQGI6N1l9xkQNy1sKh8iIDse9s3B7pFMmx16azfrMpOYViDF9qJHmJ+Y007kK7qGKe0/LK5FNHMZJIEA2VK/ylUOMZiXKGhrft
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(186003)(6486002)(66476007)(26005)(66556008)(66946007)(4326008)(31696002)(38100700002)(6512007)(966005)(83380400001)(8676002)(2906002)(6636002)(2616005)(5660300002)(54906003)(110136005)(36756003)(508600001)(31686004)(30864003)(53546011)(6506007)(45080400002)(44832011)(8936002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3E5cFRlRWoycDI4SUF4MGpGYk5lVEZ1VHZ4azB4aWlKVWtsbnFOU04rbmFq?=
 =?utf-8?B?VS90UlJJTXRrS1d6NDVBaGhITW0ybzdpYkI4cUp1bUJVNE9pdVAyNEZuc29n?=
 =?utf-8?B?aHNSMHdFaHFXNUM2clpZSGpRYXBDc3NETnM3QWJuMVRDYTdydkNMOXlUL0xY?=
 =?utf-8?B?a085Uno2RzdpUmZCQnc4R0MrWDBRYThDd0xHOGRqMEZpYXV2SzN6Q3V0OHpU?=
 =?utf-8?B?bWxpL1ZIbHlSVmh6d2VaQkpLVURwaWFiam1YN1ZkYTY0d0o2ek5zZUpLSFQ0?=
 =?utf-8?B?Vm1qeUhhTHBBL0xLUHd2cTlCNm9iU3R6U0l1em95UXRGbS82QndZdDBCQUQz?=
 =?utf-8?B?ZlMzSmdiK3YzdGFUS3JCeVpiNS9BTlZBTkM3M0RmMmpDZytjci95OXRtWFp2?=
 =?utf-8?B?T3EyMGZnTU9RTlVJTGFsY1lvclVMNVVOYUxYaDdZN0tmQTR6bGgrRTkxeVky?=
 =?utf-8?B?ZEgzVTVFdjIzUldjYUdTbzdscVhHZHAzc2VWWXpoRWhWdzNobGtsN3B4dkZI?=
 =?utf-8?B?bW9ORXNMOHlUbXFHc0svSVpCd3BJTWROWWYvNjdXb1JobWhuZkZ5ZzNJUWNR?=
 =?utf-8?B?NDkzeUU3d3RON3FLOWNTUlVndXVwMXBTZFRiSzFuRTVCYndDaUdUSndjb3J4?=
 =?utf-8?B?b3RUSlo4RnpoZSt0TWRmUkVOL2Z5cEhudHdwN3Vxa2tKU1p4d1FPcUxLamQ3?=
 =?utf-8?B?enRLRWg4K0E5OHhmOGtsMHFSQURvMWJMZG0vYjVWUXZOVUplNHhNQm9Qendn?=
 =?utf-8?B?aExxNG5ESDVOSzRWaWQ3cTlrTUdGRit0bUZiU01mVjA5dnQwU0Q2Wlo1TDl4?=
 =?utf-8?B?VjlRU1BQTSt5aFY3QlhTYXlJQW5hTktwdTZLQkJaNHExSC9jZ3lwTzBEVEFQ?=
 =?utf-8?B?RjRJNklBWHdacUtNWXp0Um1RUkNFaHNjTGg4a3lmM0trZGxxdU9rcWtVV1E5?=
 =?utf-8?B?RjFlRjFDSDIwNlZFK1NvTS9ieldtaHdvVENsYUFPYXFHaU5RK1lMNVZIZTdw?=
 =?utf-8?B?OExVSGc2VlBEbFJweU41cXJYbThLSkhGeVdsdDJoMGVoK2s1NkdZVmdsTGl4?=
 =?utf-8?B?aUhMNW5xMUZxZmJCTW00QnhURitueWR2TTQwN21DR05rZUR0VUUxem1uS0pE?=
 =?utf-8?B?WEoxalpBenhacGtiSE9LRVRLKytZNHo5ejBGTkhuNFA4bXV6VmF1MjlGR1hU?=
 =?utf-8?B?MFRZWHZtSVlsbjkvWUJqRytySW5QZG5BeVphOVd1QythSmZKU2ZRWnJoUjFG?=
 =?utf-8?B?TWdxTGFBNnM5QjhWNjFjNFl2Z1BlMlpuVUY4QW1sdklHeFE3ZEhpamZNUm42?=
 =?utf-8?B?Zk5KOGJZRWE5OFRLS0h4ZGU0ZXZjNE1hQnVTTkFsSHYrWVF5UmRiSGxSeGh2?=
 =?utf-8?B?aWhFRm9FdXFaVHljb1MwZkMzbDlvT0dWQ2VSbmZmODAwdlhieGNqaGVuNDZk?=
 =?utf-8?B?UUNkTStJcE5DLzQyVXNGWU1ZWlJrYU96OUh6V3JTV2lUUk8yZkRlZWlXZWZP?=
 =?utf-8?B?SnZybDI3c2cyV3hQZkgrM2lSbzhUaEdsRXVFSXhuVEFOOGdMdmxydHJiTnVj?=
 =?utf-8?B?TFJxUEpRYnlwOGFFOFBEMUkxejlyQS84SDRjUjIvbVFGV3FmWEhRekNKZ2lV?=
 =?utf-8?B?NEpFd0gvUTEvWDVhUkw5L2s3Vk5laExQQ0RVc2VXTEFGdjVGRkxLazBGbVFR?=
 =?utf-8?B?ZjM1Y1RxcDQ5L256TXFnTTlqNHlIOEluTVA0VWcvcTlkWDM5Mml5UEZGdkk2?=
 =?utf-8?B?aTc4QS9SbzZYNDE1VG41b0NTUDRvQ2Q5UUpObjZGOEE0Y3RVQk0yd1RGZUVR?=
 =?utf-8?B?UTRYc3BaNTBpYW1LN1NRQ0xwUGFGckZLR2tiYnhBa3Q5S21qdXRpRm9RVEdZ?=
 =?utf-8?B?S003SDdMcU9iWGJBc3llbjdGRHZpMUVOKzlXUzJpZUN3NEZ3M2pVbmRaVm9u?=
 =?utf-8?B?dm9DU09SWk4rRU8rRjJTQ0s5L1RtR2w2YlhvN2RWSnhyUlJqZ2hQSVlSNTRp?=
 =?utf-8?B?UW5tY0xqejMrUCtXUVA5dmVJWUwwQ2lybzBwVXFrM1FuaUpWSFVOeGR5Z1E2?=
 =?utf-8?B?Q3ZkQTN5QUdwVTFPRUhGUlNEVUJiRkdzVFI3Vm9hNUpFaDV6TVBCRkQzbFRV?=
 =?utf-8?B?YUpvZGNxeklFS3NBZUVteUo0RGNjUEpGdncvNUNqVGpFZEpCNzNzU1dLbkpV?=
 =?utf-8?B?VEUvclZ1aDQxaStSYU9Wc1BVSVF4ZkFCM0U2L2JkV2doejBWWW5TcDNlZjVV?=
 =?utf-8?B?MituRktmNnB4cDdjblpDT3ZOUml5ZCsrYXh2Q2x3c2lWcmlZZTMwa3cyMkdH?=
 =?utf-8?B?cW9iUTBVaUYwNTloR0hod3RrTGRvK29uQ3BoNEIzZ3dGVldHRWtFZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb95deb1-0d5c-4eae-002e-08da32c41ce2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:31:50.7137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCSfvv5IoIQEBEKCt2lS61yRgR/FwmU8NWpd+mMzyT+yUhbYQWAAJcedaJWK1LYkR9ekt0w6Uu0/wnxYv6xiCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>,
 Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-05-10 um 07:03 schrieb Shuotao Xu:
>
>
>> On Apr 28, 2022, at 12:04 AM, Andrey Grodzovsky 
>> <andrey.grodzovsky@amd.com> wrote:
>>
>> On 2022-04-27 05:20, Shuotao Xu wrote:
>>
>>> Hi Andrey,
>>>
>>> Sorry that I did not have time to work on this for a few days.
>>>
>>> I just tried the sysfs crash fix on Radeon VII and it seems that it 
>>> worked. It did not pass last the hotplug test, but my version has 4 
>>> tests instead of 3 in your case.
>>
>>
>> That because the 4th one is only enabled when here are 2 cards in the 
>> system - to test DRI_PRIME export. I tested this time with only one card.
>>
> Yes, I only had one Radeon VII in my system, so this 4th test should 
> have been skipped. I am ignoring this issue.
>
>>>
>>>
>>> Suite: Hotunplug Tests
>>>   Test: Unplug card and rescan the bus to plug it back 
>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>> passed
>>>   Test: Same as first test but with command submission 
>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>> passed
>>>   Test: Unplug with exported bo 
>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>> passed
>>>   Test: Unplug with exported fence 
>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>> amdgpu_device_initialize: amdgpu_get_auth (1) failed (-1)
>>
>>
>> on the kernel side - the IOCTlL returning this is drm_getclient - 
>> maybe take a look while it can't find client it ? I didn't have such 
>> issue as far as I remember when testing.
>>
>>
>>> FAILED
>>>     1. ../tests/amdgpu/hotunplug_tests.c:368  - CU_ASSERT_EQUAL(r,0)
>>>     2. ../tests/amdgpu/hotunplug_tests.c:411  - 
>>> CU_ASSERT_EQUAL(amdgpu_cs_import_syncobj(device2, shared_fd, 
>>> &sync_obj_handle2),0)
>>>     3. ../tests/amdgpu/hotunplug_tests.c:423  - 
>>> CU_ASSERT_EQUAL(amdgpu_cs_syncobj_wait(device2, &sync_obj_handle2, 
>>> 1, 100000000, 0, NULL),0)
>>>     4. ../tests/amdgpu/hotunplug_tests.c:425  - 
>>> CU_ASSERT_EQUAL(amdgpu_cs_destroy_syncobj(device2, sync_obj_handle2),0)
>>>
>>> Run Summary:    Type  Total    Ran Passed Failed Inactive
>>>               suites     14      1    n/a      0        0
>>>                tests     71      4      3      1        0
>>>              asserts     39     39     35      4      n/a
>>>
>>> Elapsed time =   17.321 seconds
>>>
>>> For kfd compute, there is some problem which I did not see in MI100 
>>> after I killed the hung application after hot plugout. I was using 
>>> rocm5.0.2 driver for MI100 card, and not sure if it is a regression 
>>> from the newer driver.
>>> After pkill, one of child of user process would be stuck in Zombie 
>>> mode (Z) understandably because of the bug, and future rocm 
>>> application after plug-back would in uninterrupted sleep mode (D) 
>>> because it would not return from syscall to kfd.
>>>
>>> Although drm test for amdgpu would run just fine without issues 
>>> after plug-back with dangling kfd state.
>>
>>
>> I am not clear when the crash bellow happens ? Is it related to what 
>> you describe above ?
>>
>>
>>>
>>> I don’t know if there is a quick fix to it. I was thinking add 
>>> drm_enter/drm_exit to amdgpu_device_rreg.
>>
>>
>> Try adding drm_dev_enter/exit pair at the highest level of attmetong 
>> to access HW - in this case it's amdgpu_amdkfd_set_compute_idle. We 
>> always try to avoid accessing any HW functions after backing device 
>> is gone.
>>
>>
>>> Also this has been a long time in my attempt to fix hotplug issue 
>>> for kfd application.
>>> I don’t know 1) if I would be able to get to MI100 (fixing Radeon 
>>> VII would mean something but MI100 is more important for us); 2) 
>>> what the direct of the patch to this issue will move forward.
>>
>>
>> I will go to office tomorrow to pick up MI-100, With time and 
>> priorities permitting I will then then try to test it and fix any 
>> bugs such that it will be passing all hot plug libdrm tests at the 
>> tip of public amd-staging-drm-next 
>> -https://gitlab.freedesktop.org/agd5f/linux, after that you can try 
>> to continue working with ROCm enabling on top of that.
>>
>> For now i suggest you move on with Radeon 7 which as your development 
>> ASIC and use the fix i mentioned above.
>>
> I finally got some time to continue on kfd hotplug patch attempt.
> The following patch seems to work for kfd hotplug on Radeon VII. After 
> hot plugout, the tf process exists because of vm fault.
> A new tf process run without issues after plugback.
>
> It has the following fixes.
>
>  1. ras sysfs regression;
>  2. skip setting compute idle after dev is plugged, otherwise it will
>     try to write the pci bar thus driver fault
>  3. stops the actual work of invalidate memory map triggered by
>     useptrs; (return false will trigger warning, so I returned true.
>     Not sure if it is correct)
>  4. It sends exceptions to all the events/signal that a “zombie”
>     process that are waiting for. (Not sure if the hw_exception is
>     worthwhile, it did not do anything in my case since there is such
>     event type associated with that process)
>
> Please take a look and let me know if it acceptable.
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 1f8161cd507f..2f7858692067 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -33,6 +33,7 @@
>  #include <uapi/linux/kfd_ioctl.h>
>  #include "amdgpu_ras.h"
>  #include "amdgpu_umc.h"
> +#include <drm/drm_drv.h>
>
>  /* Total memory size in system memory and all GPU VRAM. Used to
>   * estimate worst case amount of memory to reserve for page tables
> @@ -681,9 +682,10 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device 
> *adev,
>
>  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool 
> idle)
>  {
> -       amdgpu_dpm_switch_power_profile(adev,
> - PP_SMC_POWER_PROFILE_COMPUTE,
> -                                       !idle);
> +       if (!drm_dev_is_unplugged(adev_to_drm(adev)))
> +               amdgpu_dpm_switch_power_profile(adev,
> + PP_SMC_POWER_PROFILE_COMPUTE,
> +                                               !idle);
>  }
>
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index 4b153daf283d..fb4c9e55eace 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -46,6 +46,7 @@
>  #include <linux/firmware.h>
>  #include <linux/module.h>
>  #include <drm/drm.h>
> +#include <drm/drm_drv.h>
>
>  #include "amdgpu.h"
>  #include "amdgpu_amdkfd.h"
> @@ -104,6 +105,9 @@ static bool amdgpu_mn_invalidate_hsa(struct 
> mmu_interval_notifier *mni,
>         struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, 
> notifier);
>         struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>
> +       if (drm_dev_is_unplugged(adev_to_drm(adev)))
> +               return true;
> +
>         if (!mmu_notifier_range_blockable(range))
>                 return false;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index cac56f830aed..fbbaaabf3a67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1509,7 +1509,6 @@ static int amdgpu_ras_fs_fini(struct 
> amdgpu_device *adev)
>                 }
>         }
>
> -       amdgpu_ras_sysfs_remove_all(adev);
>         return 0;
>  }
>  /* ras fs end */
> @@ -2557,8 +2556,6 @@ void amdgpu_ras_block_late_fini(struct 
> amdgpu_device *adev,
>         if (!ras_block)
>                 return;
>
> -       amdgpu_ras_sysfs_remove(adev, ras_block);
> -
>         ras_obj = container_of(ras_block, struct 
> amdgpu_ras_block_object, ras_comm);
>         if (ras_obj->ras_cb)
>                 amdgpu_ras_interrupt_remove_handler(adev, ras_block);
> @@ -2659,6 +2656,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>         /* Need disable ras on all IPs here before ip [hw/sw]fini */
>         amdgpu_ras_disable_all_features(adev, 0);
>         amdgpu_ras_recovery_fini(adev);
> +       amdgpu_ras_sysfs_remove_all(adev);
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index f1a225a20719..4b789bec9670 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -714,16 +714,37 @@ bool kfd_is_locked(void)
>
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>  {
> +       struct kfd_process *p;
> +       struct amdkfd_process_info *p_info;
> +       unsigned int temp;
> +
>         if (!kfd->init_complete)
>                 return;
>
>         /* for runtime suspend, skip locking kfd */
> -       if (!run_pm) {
> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>                 /* For first KFD device suspend all the KFD processes */
>                 if (atomic_inc_return(&kfd_locked) == 1)
>                         kfd_suspend_all_processes();
>         }
>
> +       if (drm_dev_is_unplugged(kfd->ddev)){
> +               int idx = srcu_read_lock(&kfd_processes_srcu);
> +               pr_debug("cancel restore_userptr_work\n");
> +               hash_for_each_rcu(kfd_processes_table, temp, p, 
> kfd_processes) {
> +                       if (kfd_process_gpuidx_from_gpuid(p, kfd->id) 
> >= 0) {
> +                               p_info = p->kgd_process_info;
> +                               pr_debug("cancel processes, pid = %d 
> for gpu_id = %d", pid_nr(p_info->pid), kfd->id);
> + cancel_delayed_work_sync(&p_info->restore_userptr_work);

Is this really necessary? If it is, there are probably other workers, 
e.g. related to our SVM code, that would need to be canceled as well.


> +
> +                               /* send exception signals to the kfd 
> events waiting in user space */
> + kfd_signal_hw_exception_event(p->pasid);

This makes sense. It basically tells user mode that the application's 
GPU state is lost due to a RAS error or a GPU reset, or now a GPU 
hot-unplug.


> + kfd_signal_vm_fault_event(kfd, p->pasid, NULL);

This does not make sense. A VM fault indicates an access to a bad 
virtual address by the GPU. If a debugger is attached to the process, it 
notifies the debugger to investigate what went wrong. If the GPU is 
gone, that doesn't make any sense. There is no GPU that could have 
issued a bad memory request. And the debugger won't be happy either to 
find a VM fault from a GPU that doesn't exist any more.

If the HW-exception event doesn't terminate your process, we may need to 
look into how ROCr handles the HW-exception events.


> +                       }
> +               }
> +               srcu_read_unlock(&kfd_processes_srcu, idx);
> +       }
> +
>         kfd->dqm->ops.stop(kfd->dqm);
>         kfd_iommu_suspend(kfd);

Should DQM stop and IOMMU suspend still be executed? Or should the 
hot-unplug case short-circuit them?

Regards,
   Felix


>  }
>
> Regards,
> Shuotao
>>
>> Andrey
>>
>>
>>>
>>> Regards,
>>> Shuotao
>>>
>>> [  +0.001645] BUG: unable to handle page fault for address: 
>>> 0000000000058a68
>>> [  +0.001298] #PF: supervisor read access in kernel mode
>>> [  +0.001252] #PF: error_code(0x0000) - not-present page
>>> [  +0.001248] PGD 8000000115806067 P4D 8000000115806067 PUD 
>>> 109b2d067 PMD 0
>>> [  +0.001270] Oops: 0000 [#1] PREEMPT SMP PTI
>>> [  +0.001256] CPU: 5 PID: 13818 Comm: tf_cnn_benchmar Tainted: G     
>>>    W   E     5.16.0+ #3
>>> [  +0.001290] Hardware name: Dell Inc. PowerEdge R730/0H21J3, BIOS 
>>> 1.5.4 [FPGA Test BIOS] 10/002/2015
>>> [  +0.001309] RIP: 0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]
>>> [  +0.001562] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f 3f 75 ae 0f 1f 
>>> 44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0 
>>> 09 00 00 <45> 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c 
>>> 2e ca 85
>>> [  +0.002751] RSP: 0018:ffffb58fac313928 EFLAGS: 00010202
>>> [  +0.001388] RAX: ffffffffc09a4270 RBX: ffff8b0c9c840000 RCX: 
>>> 00000000ffffffff
>>> [  +0.001402] RDX: 0000000000000000 RSI: 000000000001629a RDI: 
>>> ffff8b0c9c840000
>>> [  +0.001418] RBP: ffffb58fac313948 R08: 0000000000000021 R09: 
>>> 0000000000000001
>>> [  +0.001421] R10: ffffb58fac313b30 R11: ffffffff8c065b00 R12: 
>>> 0000000000058a68
>>> [  +0.001400] R13: 000000000001629a R14: 0000000000000000 R15: 
>>> 000000000001629a
>>> [  +0.001397] FS:  0000000000000000(0000) GS:ffff8b4b7fa80000(0000) 
>>> knlGS:0000000000000000
>>> [  +0.001411] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  +0.001405] CR2: 0000000000058a68 CR3: 000000010a2c8001 CR4: 
>>> 00000000001706e0
>>> [  +0.001422] Call Trace:
>>> [  +0.001407]  <TASK>
>>> [  +0.001391]  amdgpu_device_rreg+0x17/0x20 [amdgpu]
>>> [  +0.001614]  amdgpu_cgs_read_register+0x14/0x20 [amdgpu]
>>> [  +0.001735]  phm_wait_for_register_unequal.part.1+0x58/0x90 [amdgpu]
>>> [  +0.001790]  phm_wait_for_register_unequal+0x1a/0x30 [amdgpu]
>>> [  +0.001800]  vega20_wait_for_response+0x28/0x80 [amdgpu]
>>> [  +0.001757]  vega20_send_msg_to_smc_with_parameter+0x21/0x110 [amdgpu]
>>> [  +0.001838]  smum_send_msg_to_smc_with_parameter+0xcd/0x100 [amdgpu]
>>> [  +0.001829]  ? kvfree+0x1e/0x30
>>> [  +0.001462]  vega20_set_power_profile_mode+0x58/0x330 [amdgpu]
>>> [  +0.001868]  ? kvfree+0x1e/0x30
>>> [  +0.001462]  ? ttm_bo_release+0x261/0x370 [ttm]
>>> [  +0.001467]  pp_dpm_switch_power_profile+0xc2/0x170 [amdgpu]
>>> [  +0.001863]  amdgpu_dpm_switch_power_profile+0x6b/0x90 [amdgpu]
>>> [  +0.001866]  amdgpu_amdkfd_set_compute_idle+0x1a/0x20 [amdgpu]
>>> [  +0.001784]  kfd_dec_compute_active+0x2c/0x50 [amdgpu]
>>> [  +0.001744]  process_termination_cpsch+0x2f9/0x3a0 [amdgpu]
>>> [  +0.001728]  kfd_process_dequeue_from_all_devices+0x49/0x70 [amdgpu]
>>> [  +0.001730]  kfd_process_notifier_release+0x91/0xe0 [amdgpu]
>>> [  +0.001718]  __mmu_notifier_release+0x77/0x1f0
>>> [  +0.001411]  exit_mmap+0x1b5/0x200
>>> [  +0.001396]  ? __switch_to+0x12d/0x3e0
>>> [  +0.001388]  ? __switch_to_asm+0x36/0x70
>>> [  +0.001372]  ? preempt_count_add+0x74/0xc0
>>> [  +0.001364]  mmput+0x57/0x110
>>> [  +0.001349]  do_exit+0x33d/0xc20
>>> [  +0.001337]  ? _raw_spin_unlock+0x1a/0x30
>>> [  +0.001346]  do_group_exit+0x43/0xa0
>>> [  +0.001341]  get_signal+0x131/0x920
>>> [  +0.001295]  arch_do_signal_or_restart+0xb1/0x870
>>> [  +0.001303]  ? do_futex+0x125/0x190
>>> [  +0.001285]  exit_to_user_mode_prepare+0xb1/0x1c0
>>> [  +0.001282]  syscall_exit_to_user_mode+0x2a/0x40
>>> [  +0.001264]  do_syscall_64+0x46/0xb0
>>> [  +0.001236]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> [  +0.001219] RIP: 0033:0x7f6aff1d2ad3
>>> [  +0.001177] Code: Unable to access opcode bytes at RIP 0x7f6aff1d2aa9.
>>> [  +0.001166] RSP: 002b:00007f6ab2029d20 EFLAGS: 00000246 ORIG_RAX: 
>>> 00000000000000ca
>>> [  +0.001170] RAX: fffffffffffffe00 RBX: 0000000004f542b0 RCX: 
>>> 00007f6aff1d2ad3
>>> [  +0.001168] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 
>>> 0000000004f542d8
>>> [  +0.001162] RBP: 0000000004f542d4 R08: 0000000000000000 R09: 
>>> 0000000000000000
>>> [  +0.001152] R10: 0000000000000000 R11: 0000000000000246 R12: 
>>> 0000000004f542d8
>>> [  +0.001176] R13: 0000000000000000 R14: 0000000004f54288 R15: 
>>> 0000000000000000
>>> [  +0.001152]  </TASK>
>>> [  +0.001113] Modules linked in: veth amdgpu(E) nf_conntrack_netlink 
>>> nfnetlink xfrm_user xt_addrtype br_netfilter xt_CHECKSUM 
>>> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack 
>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 
>>> xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter 
>>> ip6_tables iptable_filter overlay esp6_offload esp6 esp4_offload 
>>> esp4 xfrm_algo intel_rapl_msr intel_rapl_common sb_edac 
>>> x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_hdmi 
>>> snd_hda_intel ipmi_ssif snd_intel_dspcfg coretemp snd_hda_codec 
>>> kvm_intel snd_hda_core snd_hwdep snd_pcm snd_timer snd kvm soundcore 
>>> irqbypass ftdi_sio usbserial input_leds iTCO_wdt iTCO_vendor_support 
>>> joydev mei_me rapl lpc_ich intel_cstate mei ipmi_si ipmi_devintf 
>>> ipmi_msghandler mac_hid acpi_power_meter sch_fq_codel ib_iser 
>>> rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi 
>>> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs 
>>> blake2b_generic zstd_compress raid10 raid456
>>> [  +0.000102]  async_raid6_recov async_memcpy async_pq async_xor 
>>> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear 
>>> iommu_v2 gpu_sched drm_ttm_helper mgag200 ttm drm_shmem_helper 
>>> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops 
>>> crct10dif_pclmul hid_generic crc32_pclmul ghash_clmulni_intel usbhid 
>>> uas aesni_intel crypto_simd igb ahci hid drm usb_storage cryptd 
>>> libahci dca megaraid_sas i2c_algo_bit wmi [last unloaded: amdgpu]
>>> [  +0.016626] CR2: 0000000000058a68
>>> [  +0.001550] ---[ end trace ff90849fe0a8b3b4 ]---
>>> [  +0.024953] RIP: 0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]
>>> [  +0.001814] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f 3f 75 ae 0f 1f 
>>> 44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0 
>>> 09 00 00 <45> 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c 
>>> 2e ca 85
>>> [  +0.003255] RSP: 0018:ffffb58fac313928 EFLAGS: 00010202
>>> [  +0.001641] RAX: ffffffffc09a4270 RBX: ffff8b0c9c840000 RCX: 
>>> 00000000ffffffff
>>> [  +0.001656] RDX: 0000000000000000 RSI: 000000000001629a RDI: 
>>> ffff8b0c9c840000
>>> [  +0.001681] RBP: ffffb58fac313948 R08: 0000000000000021 R09: 
>>> 0000000000000001
>>> [  +0.001662] R10: ffffb58fac313b30 R11: ffffffff8c065b00 R12: 
>>> 0000000000058a68
>>> [  +0.001650] R13: 000000000001629a R14: 0000000000000000 R15: 
>>> 000000000001629a
>>> [  +0.001648] FS:  0000000000000000(0000) GS:ffff8b4b7fa80000(0000) 
>>> knlGS:0000000000000000
>>> [  +0.001668] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  +0.001673] CR2: 0000000000058a68 CR3: 000000010a2c8001 CR4: 
>>> 00000000001706e0
>>> [  +0.001740] Fixing recursive fault but reboot is needed!
>>>
>>>
>>>> On Apr 21, 2022, at 2:41 AM, Andrey Grodzovsky 
>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>
>>>> I retested hot plug tests at the commit I mentioned bellow - looks 
>>>> ok, my ASIC is Navi 10, I also tested using Vega 10 and older 
>>>> Polaris ASICs (whatever i had at home at the time). It's possible 
>>>> there are extra issues in ASICs like ur which I didn't cover during 
>>>> tests.
>>>>
>>>> andrey@andrey-test:~/drm$ sudo ./build/tests/amdgpu/amdgpu_test -s 13
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>
>>>>
>>>> The ASIC NOT support UVD, suite disabled
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>
>>>>
>>>> The ASIC NOT support VCE, suite disabled
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>
>>>>
>>>> The ASIC NOT support UVD ENC, suite disabled.
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>
>>>>
>>>> Don't support TMZ (trust memory zone), security suite disabled
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> Peer device is not opened or has ASIC not supported by the suite, 
>>>> skip all Peer to Peer tests.
>>>>
>>>>
>>>>      CUnit - A unit testing framework for C - Version 2.1-3
>>>> http://cunit.sourceforge.net/
>>>>
>>>>
>>>> *Suite: Hotunplug Tests**
>>>> **  Test: Unplug card and rescan the bus to plug it back 
>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>> **passed**
>>>> **  Test: Same as first test but with command submission 
>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>> **passed**
>>>> **  Test: Unplug with exported bo 
>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>> **passed*
>>>>
>>>> Run Summary:    Type  Total    Ran Passed Failed Inactive
>>>>               suites     14      1    n/a 0        0
>>>>                tests     71      3      3 0        1
>>>>              asserts     21     21     21 0      n/a
>>>>
>>>> Elapsed time =    9.195 seconds
>>>>
>>>>
>>>> Andrey
>>>>
>>>> On 2022-04-20 11:44, Andrey Grodzovsky wrote:
>>>>>
>>>>> The only one in Radeon 7 I see is the same sysfs crash we already 
>>>>> fixed so you can use the same fix. The MI 200 issue i haven't seen 
>>>>> yet but I also haven't tested MI200 so never saw it before. Need 
>>>>> to test when i get the time.
>>>>>
>>>>> So try that fix with Radeon 7 again to see if you pass the tests 
>>>>> (the warnings should all be minor issues).
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>> On 2022-04-20 05:24, Shuotao Xu wrote:
>>>>>>>
>>>>>>> That a problem, latest working baseline I tested and confirmed 
>>>>>>> passing hotplug tests is this branch and 
>>>>>>> commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>>>>>> is amd-staging-drm-next. 5.14 was the branch we ups-reamed the 
>>>>>>> hotplug code but it had a lot of regressions over time due to 
>>>>>>> new changes (that why I added the hotplug test to try and catch 
>>>>>>> them early). It would be best to run this branch on mi-100 so we 
>>>>>>> have a clean baseline and only after confirming  this particular 
>>>>>>> branch from this commits passes libdrm tests only then start 
>>>>>>> adding the KFD specific addons. Another option if you can't work 
>>>>>>> with MI-100 and this branch is to try a different ASIC that does 
>>>>>>> work with this branch (if possible).
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>> OK I tried both this commit and the HEAD of and-staging-drm-next 
>>>>>> on two GPUs( MI100 and Radeon VII) both did not pass hotplugout 
>>>>>> libdrm test. I might be able to gain access to MI200, but I 
>>>>>> suspect it would work.
>>>>>>
>>>>>> I copied the complete dmesgs as follows. I highlighted the OOPSES 
>>>>>> for you.
>>>>>>
>>>>>> Radeon VII:
>
