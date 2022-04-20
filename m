Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F673C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 15:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7CA10E11A;
	Wed, 20 Apr 2022 15:44:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07E010E11A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 15:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKUl0A3IQPp7XdblW/BjCVdMk1jFeMW9JQtU9TZxEvTM79I7Rx5zNbRlTAE/V7v9GosgQ14ZenTEYM3okapm51UBSKa/AsvMwCPKVobx8KQlR1UOV8rwiWaRUrHYhD7Bh6/VKHphOaZq0+wNgPyeJElqIA493DbHz4PomTl0pV55GGJKjX6N1WUveJB2TfUJHlyI0FMZ/asq4zd1SRa0TQgmepZXCwfwVa27v7N1gymqLNrVt7JDJKszU2GUOCCtHAbS+Zapyck5J+sgfjRV0iZMJb89djSVS+0xHgCDMJwOskSKL6zGxdfJFNGdu76vcgfz9uOR1b3FWmNFiHOk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ey9HVFTymxRJWkw18th6Q7vXPGgG4qKhzUGI2cvy9g=;
 b=Ube/nzVIgWtQS6iGnPui4NXBYq3f9DwCRpYYG/AhBfsxZWwBWuJkyqKbruT8DS+6HkM11LGmTC3HG/w7cXzMuLc4m7q4erGZHUavwocL3NUVurpqaFKVFSZaNuICwciJPCF/O3nhkzPirlI7/Mav6h3OmCG2/HUtz6frpzgWqPMi07ji9NREYOBU2rTgLBJj8xdL2pz80BWRuYPNIO1OO1L+mY+Z7ieA4GWYC3IIfEAVBQOHXVUjYRQSlPuJLR/vb0vLbi1K0Ai7Y4VOlV9E/wHWKM5EzJPMAYqClGHg3ust6DmqQqCZY3V02ys7/mJZYoh/T6w9/omOrMHDJnQLaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ey9HVFTymxRJWkw18th6Q7vXPGgG4qKhzUGI2cvy9g=;
 b=KD89QXvEhOpYhEeSHe+P/tCAwwT4bpQKRmTHLFAi1iC8ml4zVgnKHaiHoytwN9XL/csVuw086vG4XeKTUFODD8HDvkhobbqaeNP0R9EFWYyTOnbyERSu+VdtAEFNJ+RngerFJrDsKWLVFWhP4N9rPdbYbU6ojARxJlyanS3aTdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY4PR12MB1253.namprd12.prod.outlook.com (2603:10b6:903:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Wed, 20 Apr
 2022 15:44:05 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 15:44:05 +0000
Content-Type: multipart/alternative;
 boundary="------------ndk7QblhaTIP5L5G5ycudZwJ"
Message-ID: <34789d77-b8ee-1e4f-c5c2-f32f42f923dc@amd.com>
Date: Wed, 20 Apr 2022 11:44:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <20220408084544.9313-2-shuotaoxu@microsoft.com>
 <03483a49-5cfd-3e41-955e-e0e4dee78a74@amd.com>
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
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <549246A3-B326-47CC-92FD-608708E1876B@microsoft.com>
X-ClientProxiedBy: BL1P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::30) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d5e8c8e-1a2b-4a3d-a681-08da22e499b5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1253:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1253ECCD98330585CAAC5B7EEAF59@CY4PR12MB1253.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XD4ZaaUgm9Cp0d8xF4bOHJVocQpQ42vy18uSrDGNV5N2A03WWeYkzo74DOeC7CYBL8wzPHFifRF5PBTXL88Kw9cAsJkHW8y1LEBenUzZYh5qXm8jqFsbkXs9LOuOUdWST70VHaPi872JgEB5NC+iYT4S+DPyX4fSKhMPsNo6IaMPss1DjzAQYYgOKiLku/9RgUBGsO2CXiIfzMpKNWab3RHh0tb64Noa1puI/0WqKJn51sdZKUlWPw3Iha3rsyDyr4Ic2awh5E01iXqV+pqkIJTpsh3LonHskYfnisRaWXAJvvfY+jVzM0qjUctExXMTaFRbMv+GOPjZPjKbVukQplZG9Ne3xoypdrFE5u9trEoZz9BsWzZSDgh4YtTq4r0mLeIeHxU/Z/ljmSXjxR27DropmkZLoiqbTzlVgycV2Yj7T9Ew5OQfV6iUAR/4xbGEyPMN9FKXbE9kkLouIUik3lpEnbNG487NWuistS8LjIi7ghIS5WX9azsfIprCE6JIJFqpyrjXdqPhQGigSRy5xj06oUctBfSW1VtsHOpMoTirjO8Ig5ji5t8WP8Lwk9jDoT4HTpllPrpfBb/t+Y2LfhsOe+ucWEHn5PlY+NaOx63gNZTMp1B2UQWqLWYdpeLNkP18bZeoKdkIiXfvIy+RK2cbuEELULF3I9rwfgaqCtDW5AzsfXpP3MM7Hnr17WsRwyaOu8pk00oqdMHG2KcTxZm58NrEW++9VCXgCutLpEW8kZjtb3m+mJNlCQne0zTz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(316002)(31696002)(38100700002)(508600001)(83380400001)(54906003)(33964004)(36756003)(966005)(2906002)(6486002)(44832011)(6506007)(186003)(5660300002)(53546011)(86362001)(166002)(6512007)(31686004)(8676002)(4326008)(2616005)(6916009)(66556008)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2kzbU5QbFVCeXNLdDBIbGd4RGRCMFdlYlNFM0oyRTB5d2FDL0ZaZW01eDha?=
 =?utf-8?B?aVFBSDRQSWxKVU5wcmFEYVRIMU1KTnNBekZHbmpyczBvWHhMSEdscXBEY2Uy?=
 =?utf-8?B?V05kVDVvdHlyaW8yZFJwMGdtdHpBOUU0NVFOTngzbjNiYTlxU0J2NTEvQjFm?=
 =?utf-8?B?SWVlMnpRSGdZVXZTb29zN0NtN2cwZ2E5dnhOZ1lrdyswR1FDbk95dndQallF?=
 =?utf-8?B?NVRBRG9SUnJCeE8xK3lOMll3MmZxQ2h4c2hZcmZ1aE5ydE1DWkplUXdBcmRz?=
 =?utf-8?B?NnBTOEpPdmJaanlic29DV1RXbnVNWWNZUlE1cG5tK2FxaVVvMzYrcDJ5S0ZB?=
 =?utf-8?B?M003Y1FHVFZnUWttTHpsVnNyN1NlZDZjWHVIc2JTdlo0WHdoeUZ5TEtCMGE2?=
 =?utf-8?B?ZWlMTlluZDQ0NENvVWRzMnRMYTMwOWFlN1hIKzlRQTlkeFlNcEY4ZEFhaWJL?=
 =?utf-8?B?aHhhZ0FiVnpwTk1IcnBIQ2JSS3JKelNneDQ1eDJOS3hPbUxZV09YZGszTkxm?=
 =?utf-8?B?NWs3QXJpTDZVRzFIUWR1eWpIYVlranJ2eVpmNXQ3TS9YNXVuaFRzc0NzNDE4?=
 =?utf-8?B?aHdJSVpENitaUTMxeFZCMVQvOXpiVXZwOTRMbjBRVW9UWk4xVnM1YVphMTY4?=
 =?utf-8?B?U3hLZUpkZ0s1QUlVR1JReGNmVURuMlZlVnhlRjJ2YXhxMVdzL2lCay9vWllW?=
 =?utf-8?B?NEFZbmZFckJPNTdnQkpHSmtVSnlzUkFnQmJtamlQeVNjd0hQcll1QnZCSEhm?=
 =?utf-8?B?b1FYVm05K2dIaGpXQmRNSFhpZjMzM2NZbVNJN1VwUWVFM3JPSWRCWEpOTVBh?=
 =?utf-8?B?OTBuVE1UeW14Z0trbGJ5WEhOakZWUmtMUG9Cc3ZJYTdlUGswWGJIZzloVTNO?=
 =?utf-8?B?Ykg1ZUcwVHNReUF3dzFpZEY4YXM3UzVZcXlVNTY0amJxVEh3a0Y1ZWJPbW04?=
 =?utf-8?B?WWFZVXV0QTBZY3pmS215M0xOdm8vd2MyWDl4WDVLRCtMa2xFSTBXK0h4SUJW?=
 =?utf-8?B?ajRzNDVRUnVXOWtTVHkxL3QrTm5Fa3ZvaVpJMTFuak9VTE5paHlmUHhnRjA0?=
 =?utf-8?B?NWtMUGVUakVxSVZKSjVrM0grc1lNR2xrS0w2R09yVlAwTnRPUVRWaHl5QlM2?=
 =?utf-8?B?WlVsUjRiOGNLOWtkMjJPa0ZUWjBtT2NldUpaVGdUOXdIQ1ZtMW5jQUpxWDJB?=
 =?utf-8?B?cnhja3ptOEltNWJPZ2lBa1JlUjd5NStCWVFuSG5ybWxacTkxM0Y4R1pPL25R?=
 =?utf-8?B?UWtTZ2pNaEJoWmQ5QlRCL3ZUYmRkTjZiajV1REZka1VLQ2NXeStBc3djK3BH?=
 =?utf-8?B?NkNsamtqQkVBQmxMYmEralRCU2EybURxRk9tRFoxSzI0eXdTNFpHWkRwWFJX?=
 =?utf-8?B?MkpsR3kyYnZKWnB0Q2l5d3hVczFYSEpBcTgxQnRWK2V3WUoxRitrZ0s4VmU4?=
 =?utf-8?B?MnVyNDY5bDE4Y2Z2dDFFSHBQbnZHb29sNEpzMU9MVGMzQTNPNTQyZWVLT0VG?=
 =?utf-8?B?UmhmWUlWOG05cGlBQzZISzZaaGFvUnBseDZPdXE4TnRIRUg2dzdhYTI2U3Q5?=
 =?utf-8?B?RXAxSkdSUitoMUNMRWxRdTZ6NHBJN0dDTEs4bVNTL2ZnUnVnYWF0VHIrMXlO?=
 =?utf-8?B?VXJ3TXprYVhwQ09JMCsrRWJpUzJKTmZRTFZ0bCtxOFdpSUliL2hzdVMwcXN1?=
 =?utf-8?B?RjFvRVhxTE52ZUtqcWQ5Q0tKQmdhcW5NYllrbmJnWGNwd0dLU0VLWG82QlRC?=
 =?utf-8?B?TEdOVGxwR0paVCtKQTk2RmxZV0pySGdRYWJ2Y1RDUTNBcy80bGZSblkyNCtP?=
 =?utf-8?B?VUV2Q1MyQ0JUQXNxME40RHdDejBWL3R4NGRSamZIdGtkVmpvUk02WTVpMXNT?=
 =?utf-8?B?RzZPbFBzQU1IYVN4QnlrOGQrWU1wUzg3bEdJVDI2WkJxQzlNMUpmOVpIczVs?=
 =?utf-8?B?MFozV3V1SFV5alZGM3lyeHpMaHpmeEwyZnlRVTRkckkwYTM1blVKOHhSd2NT?=
 =?utf-8?B?T2REWmF3c3djd3NVWms2ckxlTW9TMlhZRXBDQ2FsQTFISk94emJFLytsN0dN?=
 =?utf-8?B?UlBnc2FJY3pWQ1dBS2FCVllVSWQ5cFJIL215VUtsN0NOSEE1dWx0THpJK1NP?=
 =?utf-8?B?YkJQSy9Fd05wNjdGWE11bjVjTjVKR3ZiY2pwT1VGYlM2ditYeWZBL0VCNWpa?=
 =?utf-8?B?NmpNbVFMWXRFaEIrdGIrVkNJalkydUtMeTRWNXNFR0NFNTJWa3pRWjRhdjY4?=
 =?utf-8?B?TTgwVjhOYmxVS2IzSkZ4RmNIMUJSNVZTdktaZ3FQVktqS0lqTGdPMUkwN2dM?=
 =?utf-8?B?aXBwUXY0N0Q5NHJ2cm1KZWg1dmV1clhSblV6cEtHOWR3Mm4rREJaYkFqd0ti?=
 =?utf-8?Q?EG6GqE1EWvEuM78cfNrI3ZXFmWGttXKgb5RMSpR6rttMU?=
X-MS-Exchange-AntiSpam-MessageData-1: SdET011ZHBPhiA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5e8c8e-1a2b-4a3d-a681-08da22e499b5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 15:44:05.4459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sOLiMxLXZJ6lu53Q3tUEH/btLRa3Ih4dDINGprSFhGfdelw921RIsZyAa/90BTl105EXwPwL+lnhZQqyVelnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1253
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------ndk7QblhaTIP5L5G5ycudZwJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The only one in Radeon 7 I see is the same sysfs crash we already fixed 
so you can use the same fix. The MI 200 issue i haven't seen yet but I 
also haven't tested MI200 so never saw it before. Need to test when i 
get the time.

So try that fix with Radeon 7 again to see if you pass the tests (the 
warnings should all be minor issues).

Andrey


On 2022-04-20 05:24, Shuotao Xu wrote:
>>
>> That a problem, latest working baseline I tested and confirmed 
>> passing hotplug tests is this branch and commit 
>> https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6 
>> which is amd-staging-drm-next. 5.14 was the branch we ups-reamed the 
>> hotplug code but it had a lot of regressions over time due to new 
>> changes (that why I added the hotplug test to try and catch them 
>> early). It would be best to run this branch on mi-100 so we have a 
>> clean baseline and only after confirming  this particular branch from 
>> this commits passes libdrm tests only then start adding the KFD 
>> specific addons. Another option if you can't work with MI-100 and 
>> this branch is to try a different ASIC that does work with this 
>> branch (if possible).
>>
>> Andrey
>>
> OK I tried both this commit and the HEAD of and-staging-drm-next on 
> two GPUs( MI100 and Radeon VII) both did not pass hotplugout libdrm 
> test. I might be able to gain access to MI200, but I suspect it would 
> work.
>
> I copied the complete dmesgs as follows. I highlighted the OOPSES for you.
>
> Radeon VII:
--------------ndk7QblhaTIP5L5G5ycudZwJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>The only one in Radeon 7 I see is the same sysfs crash we already
      fixed so you can use the same fix. The MI 200 issue i haven't seen
      yet but I also haven't tested MI200 so never saw it before. Need
      to test when i get the time. <br>
    </p>
    <p>So try that fix with Radeon 7 again to see if you pass the tests
      (the warnings should all be minor issues).</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-20 05:24, Shuotao Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:549246A3-B326-47CC-92FD-608708E1876B@microsoft.com">
      <div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class="">That a problem, latest working baseline I
                tested and confirmed passing hotplug tests is this
                branch and commit
                <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fcommit%2F86e12a53b73135806e101142e72f3f1c0e6fa8e6&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C39356160279b44accbe208da22af9c6d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637860435039102940%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Lz7qOj8b%2BQ%2BI8XmC016E7M%2B7c7v6WHlRsMaynDUAL0o%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6" shash="aQsDnBBx+4wVN7dIUr4Ib91c16nNH4kHfx1IPv2d+8MyW5GFeo2j0+YcklqfAtyO82rJfGn0Sz11kc4IrTFF7Kb8E+okwybryejcAdvHmEzKeIspr9c5HDusNm/aejWGuhgbkBJD1eJrwEdZewgbPcvOh9jw4UV5jNl9d+7uNj8=" moz-do-not-send="true">
https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6</a>
                which is amd-staging-drm-next. 5.14 was the branch we
                ups-reamed the hotplug code but it had a lot of
                regressions over time due to new changes (that why I
                added the hotplug test to try and catch them early). It
                would be best to run this branch on mi-100 so we have a
                clean baseline and only after confirming&nbsp; this
                particular branch from this commits passes libdrm tests
                only then start adding the KFD specific addons. Another
                option if you can't work with MI-100 and this branch is
                to try a different ASIC that does work with this branch
                (if possible).</p>
              <p class="">Andrey<br class="">
              </p>
            </div>
          </div>
        </blockquote>
        OK I tried both this commit and the HEAD of and-staging-drm-next
        on two GPUs( MI100 and Radeon VII) both did not pass hotplugout
        libdrm test. I might be able to gain access to MI200, but I
        suspect it would work.&nbsp;</div>
      <div><br class="">
      </div>
      <div>I copied the complete dmesgs as follows. I highlighted the
        OOPSES for you.</div>
      <div><br class="">
      </div>
      <div><span style="background-color: rgb(255, 38, 0);" class="">Radeon
          VII:</span></div>
    </blockquote>
  </body>
</html>

--------------ndk7QblhaTIP5L5G5ycudZwJ--
