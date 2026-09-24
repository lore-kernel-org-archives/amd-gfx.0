Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4437C9830D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 03:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CB510F2C4;
	Thu, 24 Sep 2026 03:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mHPY6JFd";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB5510F2BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 03:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPyf6sdFhyQ02jjui4CSa83IxPCxJOJ3EhmlDuQAmgJ7YoT5f+mzXn9EfLJj0hDYdEzHPSYzyzxiC69XbF30g8PnDgfB2agDyTnq48XZBdaM5Gn/6zOP956mz4tI/PPUQ6U2flgLiAoPx9Iny0k6IadrELmwr5G38ipAW8cGgKyVnvBxs5A7heXlcoGOTzwyRgAmRNULkAmXJa1l9o8ba6dRsCOg2TbU5gqSD3taQ0IF/91nVksis/4RQvl2L8JjPqk5O4xkeyK219EBC1B2fHGlXOfvRqkJUtDuVP1rOWsmSbnQ/iJc1AUo0gJVg6WDkVy4xYnqA8OXZqLY0hksfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3LxPP88qp95vOviBuGQCJFY2oBm2n1jzRJRZAKUawQ=;
 b=UyR9wSJcPD0Q6sNEog4efj38qINckBppkY9DvV5uLUj9rregVm/TKWho1XVoWSFwkkW9m1eh/gIIBMdIJFv7Jyoy3ZTwIc2PZJijpUM01z37SOVpmCyNDejctu5ZP8ttf5yT1VrMO1BYWwk1Ey3Xqi0P4sv6IabeePO5ykaIW+HD5JEnXLNm7e7gUWnDCMKK0ES4FnHEw2tEmL6NpYZbkjZmvTr/paHIj/CPgsW70c9X/NptbE1FEV2gPJwsKrCt0WFkkwxbLLFU/euQhDXPw/t+EZWYYEplXbYom9GWKScCT+qjGn/rnDIqZOdk3CESXwcQMWVoGK9n6bwryqc0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3LxPP88qp95vOviBuGQCJFY2oBm2n1jzRJRZAKUawQ=;
 b=mHPY6JFdD9H7zEIMiKeaj2YgfKK2XkybA3rsNI18pYMotOAGwZVpIFAtsEqn3LHFsyxx+7GQ1Rqi+bm8yJzVzyir1TLWWIW+XAvFFjMTTD/uYUQe3uYokRSrKSet43PSnsp6LWw2yKdK++NAAoGmcj44FymKgQ/mdv84OVu2Alo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) by
 BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 03:40:40 +0000
Received: from DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587]) by DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 03:40:40 +0000
Content-Type: multipart/alternative;
 boundary="------------foLpSrsrW0kerUJTgACioZP8"
Message-ID: <d6bd6d19-9492-4465-aa88-e5d8144aac8d@amd.com>
Date: Thu, 24 Sep 2026 11:40:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/10] amdgpu: implement Performance Monitor Counter support
To: "Welton, Benjamin" <Benjamin.Welton@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <a97514f5-8a01-48bb-b1f0-645ac657bb0f@amd.com>
 <LV9PR12MB9831867DA9EAA980EA12DFFFF0822@LV9PR12MB9831.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <LV9PR12MB9831867DA9EAA980EA12DFFFF0822@LV9PR12MB9831.namprd12.prod.outlook.com>
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To DS7PR12MB9475.namprd12.prod.outlook.com
 (2603:10b6:8:251::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9475:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: a513f211-a6c2-4321-2fee-08df19ed9a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|8096899003|18002099003|22082099003|4143699003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: K6MrAZYFzuwFOWGQlV7EjBA0fB3mEEFSQ2Qdp6GZrzeh4dG3J00ewe0Khf3GNcvn/xxrsZA7rdPNQloxjbGG15qAkFbdl5Bwn/12fX3mqj5buI6dUQqHxnq+cFIRk45LlDTMvrb/f1IJRBs44oxjfzjEaE0geYX72+6QweV8eAqpaF9zPRUOKI+AMBomQpuKp+vR+KNQLsxH/UFrbvbvNIbdA6HCfFDBYp9ELewVNCYWOccNwTjcNWEarOxs5R+P78JD45cgX1dz0cQGNQPJacNHz4EQAR4zLmcjKdY9LN72H34GGiGYodbvJWb+2oKXTRBU2ORuqKMlhdCkNB2rpf/OUE8+0uxq1bs2SV2mw3S26W8LRjmzEmRYPv5uLTX+wpDksg00QqtPxLbe/uXtIK8We5RItrMHYKwxJZWAmnPhFEoW6+T5zAU+K2PehPhmnpMOqlI6I0lsAr1D31SR9wRpe8VUDyvBBUTnFstfUdHbwbiRHTmmsL4YnO0V13bmSLtYGGI7+G+7FlCs12FFU8msUrxX5FhX2mAvdssLMjF0Kab9LRorHIUknxHQDjngJBuzvVYwvsg8hLbuJaaIBM3quDgyDrFyYNz8uLTa576qQOVLwvKizwgNdeDbDXV7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9475.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(8096899003)(18002099003)(22082099003)(4143699003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGpTV0FoZGhZLzJFTUlFK2J4OGlMT01ISVZnSGp3R3dZTnpER0lnS1RWckNl?=
 =?utf-8?B?SEZONk9wZDdBNEFDb1l1cjhlU0VBMUVOYzdaT2NVY3YvbDFjellHbHYzakV4?=
 =?utf-8?B?NlZNaFdRTGs5MnNjOEhFd3BDYTN5MmZzRHBwNEJDRG9icXRSRDVxSG9vWUdB?=
 =?utf-8?B?RjdnSEJQYkhraTV5MGRXUDZlaDMvYnJsWWJEQ0xmUFQ2UXlvMHl6SXc4Rk5M?=
 =?utf-8?B?aW9HZytVdm9idFNRZXF4bTBSdDhmOXpPZGdtbnR2ZlhrQzZsV2VTY0M1SDBi?=
 =?utf-8?B?bTduR0dzMzJzZTQ0ZGtPaitsZG00L1hTVHFDVndBaEtPZ1FFUVVrWUFQMGNa?=
 =?utf-8?B?TFpqQkVtWGdGM1BUQkYzSk5oOUkwZmxoSGdyUEpjZW5CTldsUkw0cVFHUzFM?=
 =?utf-8?B?MW1icXV6Q2h1QWFiYzhqSWx2QXlmMG1NTS9yZVYxeExSY3c3M3NWalo4dW1L?=
 =?utf-8?B?NzRhWm9QRVVlVXdSdU4wd01LZXRaRVdiUHk2ZVJ1K0xPM2hINHdDMzNWQmJt?=
 =?utf-8?B?dDAvSWdGaTQzVWlhcC9mNnNlSnh3blVtTWJ6S2FsQWg0cnBGTnZQamJ6QTMv?=
 =?utf-8?B?U25UTHBvVVBTaXNjRm1FK1ppRksvSFVjaFdBNS9WbFZMdWwvWTJMSW9Qcjd4?=
 =?utf-8?B?c3c0VHF3bkdkd2k3YWtrckdLYUJ3dVovK05qN3VGLzFCR0ZSbnRhY1pKQUxQ?=
 =?utf-8?B?OFl0bUVQVXBlckpIV2JYMVZadlppaHJTYzZXSEIyNXQ0ckM1MTZiekU4NW1Q?=
 =?utf-8?B?ZzFuSmtQd0tITTZTT3lTZXNCU09hcnNrUHV2bmdVUlFYdEFoVXVYTkVWTExV?=
 =?utf-8?B?TVdxTVpGbm1PaDdXL0l2TE5iS25MdjE5a2lyeEFUU1BCb0F6Y1haNkg1UWxZ?=
 =?utf-8?B?ZTFXNWNLb0lYMXQwSlhyQmtqZFdqZ0U2Y0pRVkpuQmdjenFMdmVJUFdDeWJJ?=
 =?utf-8?B?N0dOdnJybU9YWVhUUXVVZ3Y2YXpMSWxvM3pnaXJVd0pBVmp6c0hCVE1DT3ND?=
 =?utf-8?B?NUtFLzh6NGJqbVAxb0J6ZUV3QXd0NWRFVmlJUVN2LysyZHhNd0drTlhrN2pV?=
 =?utf-8?B?WGloQU9BeFlDUWErYllyTUxleUZNUjUzOWlhQWRMeEtkN0tDMURzamZPcDRG?=
 =?utf-8?B?S0huYStCVE5iTnF2WTFiam55SXlXbHZaRWdFYkplYmFSazA2bjVFM0pnelhM?=
 =?utf-8?B?eHhicnFlS0xTdTdoaHlFeXorNzN1UnBMZmFsRUs4VTNMSWZjOTA4WEFraExs?=
 =?utf-8?B?bFRRK0FGaklFU0Ric2MzbXdOTm9EY3J1akF1cjhIbllaV2dQYjZvcnR5NmdJ?=
 =?utf-8?B?aXB6TFloOW9EODBrcTNzQTlLbC96OExBRjRKQjg4a3F5UlYxZFE0ckt5cGth?=
 =?utf-8?B?cEhQNitHZVoxVXNJd1JpUDhUNnFTcDZ4dFhXS1dOL3ZoRndhdlZ1SDFxVUpt?=
 =?utf-8?B?NGxSVlJ2aDArOFk4UllZd2g0TXkrUTRrUGhaWXVxYldhQ0gvL2ExY0NYTW9N?=
 =?utf-8?B?OStYbForWDAyZDA0MGxFcHllZFA3cHVxUno0cklNTC9FZkpVam56VGRlcUhq?=
 =?utf-8?B?d05xQzNtOEpySzhzdnB5NHA0VlZjalhOaXJoanZWMVRsUVdxaWtyWEY2MENV?=
 =?utf-8?B?TkZ5TUFiYjk5QXhSVE8wK29obU9IYmRMYUtiSVROOVIyZzZERzFGcU5CbGRv?=
 =?utf-8?B?Z1Arb0VhM2lCUTJwSmQydHAvUE10b3lYUk5SMUQwVVpaUmRUNExHNHdMaGtT?=
 =?utf-8?B?b0VxRytzcklHa1ZVbTJVSUtpckNhdXVZUE9iMCtmbkV0aVZmdHhRUlRDdExQ?=
 =?utf-8?B?N2FVREJRMmJadU1lYk9GeFRMRUVGeW5DaDlsZEtCVU5NYVZLdnJFOCtyRHho?=
 =?utf-8?B?UkpEZlRhV0RuTk14QmtVV3dqbjFWTElPc1FCZEw3aS9pV1c4S25qYzF3ck5I?=
 =?utf-8?B?MENoRHZ4M0JZeWtDNldjdHJWNG5DTXJOaUpBYjE4ZzJGN2JqNTZaaEp2bE1U?=
 =?utf-8?B?cXNEWEZNVFNWRlVrRXl2K01jYmp2Q3ovYWdSL0lQNVBXODFHei9NaGlHVW84?=
 =?utf-8?B?VWNodGxMaUdORHVYOWFXQloxeTZUdFFJdnB0N2dHc2kxQlVzb3k5OTJRZXo2?=
 =?utf-8?B?STByZlhlVVJCbWVLZCtTOVY5K1FJQURqNDZNdDdYTXhGaFJpeUhCR0sxMW9U?=
 =?utf-8?B?REZPNVU0Rlk2a2MzQUhIT3BCang1ZW9OVlBZUU9VKzdYZnlDV004ZlNUU1hX?=
 =?utf-8?B?TlI1TTJoak9tb2N5aVMvWXVaYmdqN0NHY05hdlk5M0RLTU1obDJIeUpvZnhR?=
 =?utf-8?Q?GFns5vCvYdabKZZ9fV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a513f211-a6c2-4321-2fee-08df19ed9a96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9475.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 03:40:40.3611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUOqzyaqZUSSg2arLo8yapPCgPr/uxOWW2xJ1dRkcZpjHSgIwzHvgvXMCdV2IdRBnD44ThriIZOii883e1KlaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------foLpSrsrW0kerUJTgACioZP8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/2026 11:02 PM, Welton, Benjamin wrote:

> [Some people who received this message don't often get email from benjamin.welton@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> AMD General
>
> For some background on my end, is this the porting over of the existing profiler work to KGD?

Hello Ben,

Yes, it is a porting from KFD because I don't have any other documents.

However I still made some improvements like separate reservation from PMC enabling operation
to avoid some corner cases.

Thanks
Lingshan

>
> Ben
>
> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Wednesday, September 23, 2026 7:02 AM
> To: amd-gfx@lists.freedesktop.org; Welton, Benjamin <Benjamin.Welton@amd.com>
> Subject: Re: [RFC 00/10] amdgpu: implement Performance Monitor Counter support
>
> Hi Ben,
>
> Please review these PMC patches for unified Kernel interface.
>
> Thanks and Best Regards!
>
> James Zhu
>
> On 2026-09-22 05:34, Zhu Lingshan wrote:
>> This series implements PMC support for amdgpu. Including two parts:
>> 1) PMC Enablement
>> 2) Profiler Reservation
>>
>> The user space should take the reservation, then set PMC.
>>
>> This series depends on and used new helper introduced in another
>> series:
>> https://lists.freedesktop.org/archives/amd-gfx/2026-August/151692.html
>>
>> Please help Review
>>
>> Thanks!
>>
>> Zhu Lingshan (10):
>>    drm/amdgpu: implement PMC ioctl framework
>>    drm/amdgpu: add device-wide PMC config
>>    drm/amdgpu: introduce PMC ioctl handler
>>    drm/amdgpu: implement reservation mechanism for PMC
>>    drm/amdgpu: set device-wide PMC enablement indicator
>>    drm/amdgpu: GFX11: set mqd->perfcount from mqd_prop
>>    drm/amdgpu: GFX12: set mqd->perfcount from mqd_prop
>>    drm/amdgpu: GFX12.1: set mqd->perfcount from mqd_prop
>>    drm/amdgpu: implement device PMC handler
>>    drm/amdgpu: set userq perf state before publish it
>>
>>   drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   8 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   3 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h      |   6 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 166 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  38 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    |  95 ++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   2 +
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |  11 ++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       |  11 ++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       |  11 ++
>>   include/uapi/drm/amdgpu_drm.h                |  36 ++++
>>   13 files changed, 390 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>>
--------------foLpSrsrW0kerUJTgACioZP8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/23/2026 11:02 PM, Welton, Benjamin wrote:</pre>
    <blockquote type="cite" cite="mid:LV9PR12MB9831867DA9EAA980EA12DFFFF0822@LV9PR12MB9831.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[Some people who received this message don't often get email from <a class="moz-txt-link-abbreviated" href="mailto:benjamin.welton@amd.com">benjamin.welton@amd.com</a>. Learn why this is important at <a class="moz-txt-link-freetext" href="https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/LearnAboutSenderIdentification</a> ]

AMD General

For some background on my end, is this the porting over of the existing profiler work to KGD?</pre>
    </blockquote>
    <pre>Hello Ben,

Yes, it is a porting from KFD because I don't have any other documents.

However I still made some improvements like separate reservation from PMC enabling operation
to avoid some corner cases.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:LV9PR12MB9831867DA9EAA980EA12DFFFF0822@LV9PR12MB9831.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

Ben

-----Original Message-----
From: Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Sent: Wednesday, September 23, 2026 7:02 AM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Welton, Benjamin <a class="moz-txt-link-rfc2396E" href="mailto:Benjamin.Welton@amd.com">&lt;Benjamin.Welton@amd.com&gt;</a>
Subject: Re: [RFC 00/10] amdgpu: implement Performance Monitor Counter support

Hi Ben,

Please review these PMC patches for unified Kernel interface.

Thanks and Best Regards!

James Zhu

On 2026-09-22 05:34, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This series implements PMC support for amdgpu. Including two parts:
1) PMC Enablement
2) Profiler Reservation

The user space should take the reservation, then set PMC.

This series depends on and used new helper introduced in another
series:
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd-gfx/2026-August/151692.html">https://lists.freedesktop.org/archives/amd-gfx/2026-August/151692.html</a>

Please help Review

Thanks!

Zhu Lingshan (10):
   drm/amdgpu: implement PMC ioctl framework
   drm/amdgpu: add device-wide PMC config
   drm/amdgpu: introduce PMC ioctl handler
   drm/amdgpu: implement reservation mechanism for PMC
   drm/amdgpu: set device-wide PMC enablement indicator
   drm/amdgpu: GFX11: set mqd-&gt;perfcount from mqd_prop
   drm/amdgpu: GFX12: set mqd-&gt;perfcount from mqd_prop
   drm/amdgpu: GFX12.1: set mqd-&gt;perfcount from mqd_prop
   drm/amdgpu: implement device PMC handler
   drm/amdgpu: set userq perf state before publish it

  drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
  drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   8 +
  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   3 +
  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +
  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h      |   6 +
  drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 166 +++++++++++++++++++
  drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  38 +++++
  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    |  95 ++++++++++-
  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   2 +
  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |  11 ++
  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       |  11 ++
  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       |  11 ++
  include/uapi/drm/amdgpu_drm.h                |  36 ++++
  13 files changed, 390 insertions(+), 3 deletions(-)
  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------foLpSrsrW0kerUJTgACioZP8--
