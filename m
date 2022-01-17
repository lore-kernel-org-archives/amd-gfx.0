Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC5EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 16:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38D810EAF0;
	Mon, 17 Jan 2022 16:07:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F0510EAF0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 16:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHogtHdjZYZrCfqSIL5EoTtutj0dzAvtU8VsO3jrCgE3Dv0ye82fc/yHaaxXNQBKTFx1qZghimbL79qGGEVHbAHpbUPSGDMm1u5AdKETfUc+AgF4K9+IlEnjFXdrm+buRY4zASTKlizFrEMS5Ye7FIasTuxS9ADvK0ohVQzRtNk4pb1ZVeqWTxBD/mIOGnLzlQTWFg8frpcQN5YjmgBCNMTY18Udg5rAeKRfJP5/wqB9GlGgECI3Zghd8SgUBRzfQrHkDgF0yxZI8yL4V5llIdWmbGDPwBeMoyMwX+q2jU2QPiCqWhR6pcphTApFkorGhzjyX0mTg9LOIAl3N/YAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r70OhqOz3EXUL+cEQhVjwdGS0VY+2qQVGhHB7Xw3Qn0=;
 b=ZOYzcq0VdwZssXrdFNWg0nEoxJhdeSKTRv7uOTuu7kR8p17vY4O2XBqTyh3oSvUdcQMbFclEa+xWksfe0prd2Zjwy3b5dd9E3UxrVcz5C7aZKajVpqpLC0ywjfsHUzFhtQkAT+ZOOkZ8JRyd+BVmohsW3S8hFCfofdeeM0/KGwexn8qyeHWP2wpXDwznX7ErEFq4rgiJil3wTKdNrgcvKeQ1Sg6FNTuUnpP/ga4NhCHode2fx8mjVu+CiGqYHCn9PJgMGCzm3SwLS2GbmsHCmIiXKD5KcU6RO9ai++hYoObwmTuKhmwKUHFnRLgFEZZ3bwdjQWwqa1Omd5/4v1VJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r70OhqOz3EXUL+cEQhVjwdGS0VY+2qQVGhHB7Xw3Qn0=;
 b=Ww6xElLVbGqyg0GzK+kT6NJbyYGn76dI2O54b5P8g+av81uOMQqCZeq1DeBSb/spPil9I1aBC03/FT5NE4qTZrbRFJ8kcNoq/0NcuRBHcwbj7mrbeZllqHhkqphMJTFlVvfk0d3a2quTD59qF+IFPa6PepN4A+g7oxIc3Dvvuzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by BN7PR12MB2836.namprd12.prod.outlook.com
 (2603:10b6:408:32::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 16:07:45 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 16:07:45 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 "Sharma, Shashank" <shashank.sharma@amd.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
 <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
 <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <5568c4e1-7bc5-cd7f-d6d7-92a4f920c40c@amd.com>
 <DM6PR12MB3897D33226DBA88264B5BBF8F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <62372e77-31c8-211f-0d9c-01a0f880badf@amd.com>
 <779d4778-6b85-2769-f169-f5f9e956a671@amd.com>
 <10fe91c4-9078-8937-5dac-0625d38c2ea3@amd.com>
 <7a082b06-179a-22dc-e176-3f6d46a1deeb@amd.com>
 <8ffbf71a-9c62-b153-bf52-a88e7bcf91d3@amd.com>
 <98202e9d-cefa-8874-8a8d-58ec512f80ca@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ee156d84-796a-af7b-d316-5bca0a2a6e5d@amd.com>
Date: Mon, 17 Jan 2022 17:07:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <98202e9d-cefa-8874-8a8d-58ec512f80ca@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS8P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::25) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 791d8df9-ea7d-4183-33d8-08d9d9d37f99
X-MS-TrafficTypeDiagnostic: BN7PR12MB2836:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB28362E72AD7FB8061C74F58F83579@BN7PR12MB2836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykZUTdA8grWUcCjxJJ/2VHBQGdnSxt4SGF+Jr0KXOB1fx6MlKwA9Hv1KdlaV0TGDHQJFvydC3RPR/ZnMVoD3Nr6Giaj0WehCv4Gk8Pb19OrReEdJa8pSfL8w8OjVvvhYLOClgoQQsmk1mji7sBhClI2mw/4Gc2FDhye0B5c1XjV3gGrkUYYWsN0IqFIfTuVAdcgc3fGvyqzpziT3AgGob3oFob0SP0U+npGEQPv7P11LjjS0H9icmaD0kVNE/LdfcoFdsE/hpAmk1ylMOjUl02Vbo86KLw7ZTyc8B0DpwVFeqnjMNSvZ+McrShOd44uWuexIs9yt86qEeienNdg1R0jehmbzeVNvMs7zSAro2XwXmC73HlZEGEVlo35DgiZ2+dZ30GKft8BnNFJAKQz4Wi4A4L3X9td7oCgaUnJRmRBmz7VpDgYDU0lSeyAFL29lTV1TxCj2RqmYXt7u8l8EHJu41z5DR8bQ+WPNKoTChH2S1cVi1IWQanxYaDxI8/7kpN+qd1jDX+UqMwa5T0FXYILsBaU4q4NaGb6CrwrkVTyU062p72WTn9rRbb2NEWLZsKkHWWWwNnG5sy+N3YCjxjvdT8FWRbyr2jKrht6LR8KYeHLui4/Ebg93JofgecHt2zl+IwkI376PIdmYgKnoUi6EjnUOWPQXWIlhand/LFTMSeErjLOfebMvc7E1Zdfg+nM7POLF2Kip13t4Qa5LbUzcETMSUK1UTnA+unHrqsmTDYm97IibZGq8wi29tyGm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(316002)(38100700002)(508600001)(2906002)(186003)(6512007)(6486002)(83380400001)(8936002)(2616005)(31686004)(31696002)(6666004)(5660300002)(66476007)(86362001)(66946007)(4326008)(53546011)(66556008)(8676002)(6506007)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3ZMVFhhV2NFV3hFcVQ2WVN4amRBb29BczVyZmdBZ29QdUM0RC9nVkh5bENn?=
 =?utf-8?B?RU9MOW5wWEYyRFVweDYxWTdNaUhDenNxb09palNJclB1cURaVkFWZ1cva2hP?=
 =?utf-8?B?OERlUlpUZGJ2QVBRSlEvR1dIcEJERWdMdG9kcnE4YUxBb3JhTVFzUXBSZDI4?=
 =?utf-8?B?WGppWFV6TG04K1Y1WEUveVNwYjNhRkRoMFcrZlJMdDRUSEw4TEZ4M2FramZw?=
 =?utf-8?B?c0IrTVpRNGFWME04MFRObDAyZlM3dUpjMGcyMm1vanpOOGtXdFdQYzYwMWlZ?=
 =?utf-8?B?azAyd3RDcnBTQkY3YmJVVGlsMS85MEhWVS8xZ0dReGJjR2hacVRzR0JsMkIv?=
 =?utf-8?B?NWpDdFkwbjNNUkV6SHRCS1dyYnZLWkl6ZWFOc2J3ZTh2WUtDTDQ5TXVxU28r?=
 =?utf-8?B?U00rS0FnZVoxR1NFWG1uTzlGUStzTXdwTGp6OVJQU2Nvelg4a1NPUktpenI4?=
 =?utf-8?B?Z3JmWFA5cjVNVUxaeU40cWVZYlRqSU90aVVDbFo5cFJFQ3RXK29nN01qRk4v?=
 =?utf-8?B?OEtpdklNZTVzaFEvZFpoRnVyUGgxcGl5dWtrbTF2aHNNSGZ3RHJiWWsvbkdQ?=
 =?utf-8?B?OWVUdC9oc2xNSDdxS29mSlJtVVFmS0VCRGhETnBMWm9iL3FRTFdDeXYzdzVP?=
 =?utf-8?B?VGlWYjhrUFp0K1UyTWViRllYV3N2dXRVSFY3RnhXdS9sWENwUFVaNXpycUF2?=
 =?utf-8?B?MjFrWElJZ2hGYTZ6U2MreXJ6NDF6MVJYdWl5blVNbmRIOUtWZElNeXFmcWxq?=
 =?utf-8?B?MUdVSjFsYW85S0xwczhpdTBSb013MGVDNlhVVEhzNk92cEtXVUlFMnZOWUd3?=
 =?utf-8?B?bHVCSk1NOEhLNHNsT3RGVjh1UUhXelEweHpEL0txczNVbTBocHBnTGl3dTVK?=
 =?utf-8?B?YmNoSGQ5MEsvN3VIcFNEYVNwcE8wL2Y2UUdYbnBuOXBCNXZNeG9ZSitmQk1u?=
 =?utf-8?B?RUVuNzdYNUlFUWtkL2xlTWZ1dnpWRnIxY3ZqNzB3d2FCOGxqdGdOVGFKWTVE?=
 =?utf-8?B?UkVZQ201MmpaU2FJUEZvZ3R6aHlwTmhDVk9kaVZoaWV1dVNSWXBTZklDVU5R?=
 =?utf-8?B?SkZETkd6Z0ZVTlVITm53OTdLUEJlOG9wcm5hVnpSK2VFY2gyZnMwdVNHSXJE?=
 =?utf-8?B?bDc1T2pBV0ZFWWpDMXRGSzA4Smo0dkVpMmZTcUcrbEEyTFE5aGI1bmgxVGda?=
 =?utf-8?B?RUhPTVhLN29pQlJUc3NTcDZzMEdkN0RrTEJlL2lROVNaWDVrTFNDajZtTThJ?=
 =?utf-8?B?LzYwOHRoblRVSXpXQnlxbFdJS1NnVFhUV0Z3enhLck8vSlhaSWxqSEQ2S1pI?=
 =?utf-8?B?WGt4MmRYcER2OEgyL0NZclBsN3dndDEyQzE4Z1lyYXI1YlIzbzJmcVdVUkV0?=
 =?utf-8?B?a0w3aFlnRnlzK25OUFVMckR4YmpvVXBVTkM1YkVpalVhYnE2b0tGY2hGbU5m?=
 =?utf-8?B?K3VKWXdWczRVMGQwQUFGcXBJa21CRzRucDZyZWF0Y1ozbGtnN09oTUtqL21i?=
 =?utf-8?B?VU1qc1UrVVduS0tid1lNZmhnUkhuWFM5SjdwYmdDOU1VYnk3bzlLeHhSd1Ns?=
 =?utf-8?B?SWtNczhUKzB6QU44VUtsVVRqVTMvV1h2empLa1M0VFQrM3l0ODc3MUdpaXBx?=
 =?utf-8?B?cXRXeHI5STR0NThMUkpVdFBWQWZrN3FhNHM0dVlIMElqZzFWdlVXNmp4UVdh?=
 =?utf-8?B?ck1hRUNkWW1wRklwZ0JCN0ZBRU8rOG01YkpHNjlwQ0lHRy9Sckw2cjZxWC9w?=
 =?utf-8?B?YjNWMXhqWkJna2RUaW9OeFdHVlNIdVNoMGVHUFdabkt6Nm83WS9pM29aMFM2?=
 =?utf-8?B?UmFVU05tNnVxR09vNDdzdTJLOFhSYlAzRno0ejJEZWdDRUpDRVRtRzhzTnFi?=
 =?utf-8?B?K3BxRFZEUnhKV05CZDk4UXVqM1RyN2JCK2VBTmFNVUp5NmprVFFxNEhSTTFC?=
 =?utf-8?B?cWYzS0x5YkFxT0Z5ZXRhVkJqV1J2K3dFbEdMaVR5TzRjU1dhVzVSYXZCa21x?=
 =?utf-8?B?b3NjQW16akdQVHhsVGd5V0ZIOHM5am5SQlBNR3A4cEp1Vm04R1pYV21OKzZ0?=
 =?utf-8?B?MlRWKzlpNWR6b2VGQTMyNE1FeWxlR1U2NGFGb2N2VkZVb2VPdUc2MlZzdXdS?=
 =?utf-8?B?S2t4dFQ5QUh6b1RlQTRjK0F6WGRxQkc5UzBEY0MzWTdJQ2VlT3NEblhkM1c0?=
 =?utf-8?Q?YeJF/lqB54ulQilDfSrpXco=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791d8df9-ea7d-4183-33d8-08d9d9d37f99
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 16:07:45.5302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSEh3BY9aOC3KEP/AZCTTzf9tyI3T+nlayrej7nlzEcdG/khXjpq3DdChSKLElgU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2836
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Amarnath,

not a bad idea, but that won't work either because you really need to 
return to make sure that a potential next reset can run.

What could be done is to have a work item which does that, but then I 
think it would just be easier to teach the udev function a GFP mask.

Regards,
Christian.


Am 17.01.22 um 15:19 schrieb Somalapuram, Amaranath:
> Hi Christian,
>
> if sending udev event during reset is going to create problem, we can 
> move this code from reset sequence to re-int  (after GPU reset 
> succeeded).
>
> Regards,
>
> S.Amarnath
>
> On 1/17/2022 5:27 PM, Christian König wrote:
>> Am 17.01.22 um 12:43 schrieb Sharma, Shashank:
>>> Hello Christian,
>>>
>>> On 1/17/2022 11:37 AM, Christian König wrote:
>>>> Am 17.01.22 um 11:34 schrieb Somalapuram, Amaranath:
>>>>> [SNIP]
>>>>> Any suggestion how we can notify user space during this situation. 
>>>>
>>>> Well trace points should work. They use a ring buffer and are 
>>>> specially made to work in such situations.
>>>
>>> We are anyways sending a trace event with data, but can trace event 
>>> be a wake up source for an application (like a tracer) ? This DRM 
>>> event is just to indicate that reset happened, so app has to read 
>>> from trace file.
>>
>> Yeah, that's a really good question I can't fully answer. As far as I 
>> know you can filter in userspace what you get from the tracer, but I 
>> don't know if you can block on a specific event.
>>
>> Christian.
>>
>>>
>>>>
>>>> Alternative would be to audit the udev code and allow giving a GFP 
>>>> mask to the function to make sure that we don't run into the deadlock.
>>>>
>>>> Another alternative is a debugfs file which just blocks for the 
>>>> next reset to happen.
>>>>
>>>
>>> - Shashank
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>>
>>>>> S.Amarnath
>>>>>
>>>>
>>

