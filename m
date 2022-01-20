Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8C7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 15:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2E310E4CB;
	Thu, 20 Jan 2022 15:47:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D8910E4E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 15:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwnAy46A5prV+Vu3nyC8Fu9m7ELf3SmZsqbgpObMjSbaijuBHTfp35FDQpSWKMRXahh3rUSmUE4M2fxScQ00mYrx39bIIkukl2Fy3+bzVJwY9PBYDrLfL3psiDg2fPqKAKeMoTfg/VIpF4XckvHSFZM1aoWGyqPUIxDW4e+npNUwyX3wHwColuOR0b3O84VUQl++RaB6Kuqjx2G8iz3iWa65YZqpxN2uKYqdwMgvofBrRp1Otm2oNUhs4v11Rp4aop+7d/AzeOajsb2Dco5BJbBok8L3UtUf8G1t6y1duAAqBoA989tF4uRlnlkb3rdBe+bPcNHxFG20lMh7/+b2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDb3JqGtnlmm52oVCq7YYEaAH25qtWyLdnZDyJ/P0C4=;
 b=d5AKiQIMxjC67GE64Ut1jAlMT5D2ApVmt32ZNBrkiTMC0ncxasQAiegutlYcTrBaOp9sWXJp3wiIXPxe6v0CnMNV2I+moNt1Xen1S0VpKqpbpXLK9ee2iKxT1YrUqfCAyZGnxYyQjk6qnXDQ/Xx9O9puhEjSWkFuxufIrP8v/TPC9PxhtwretuHxk0ICMUh06SE331sEfkIjdKcuQOxMCLptYqnxjpSi5ElDP2MIQquXrGl4sLoXfmN2QY5j4WXZgRAJDroUrRplDVZ+P7adJmO1WxxTqsLf+1rt4+g1VnLbabqhjt2pUQujVI+Fclm0Bq6krxv7jMqc3XvIYDShOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDb3JqGtnlmm52oVCq7YYEaAH25qtWyLdnZDyJ/P0C4=;
 b=eegue1OV0vzrLSPAPc8GV0xJOLhlDL0ol0gHiakMSjckTVW2xhVa1d0tm941VmP2JMLMmtGcaG7DZTMg35xfyGMtvbVmASNYs+DEJGX5kQ1//Ik/8aSBCH9vgLMWQV5O1cxY63GqylFHPZ4hvELUaGUTo0om7Z7wjUXmoo1fRFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW2PR12MB2394.namprd12.prod.outlook.com (2603:10b6:907:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 15:47:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2%5]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 15:47:16 +0000
Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220118120157.102453-1-christian.koenig@amd.com>
 <DM5PR12MB24692C6D246264672211B712F1589@DM5PR12MB2469.namprd12.prod.outlook.com>
 <99b919b4-97df-16bc-46c2-682bc03117f4@gmail.com>
 <DM5PR12MB2469F71C6D7237AA6CC28B37F1589@DM5PR12MB2469.namprd12.prod.outlook.com>
 <DM5PR12MB24693B64F61260F9F28B326DF1599@DM5PR12MB2469.namprd12.prod.outlook.com>
 <4fce003f-e00f-d3ff-6523-fceb06df57ed@amd.com>
 <DM5PR12MB24697899BB92BEA2E87993BCF15A9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <88ed5995-22e3-52a6-c531-c7386a03bb86@amd.com>
 <DM6PR12MB3163A49AA7557968B7E91BC6855A9@DM6PR12MB3163.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <41a2aed9-a58e-8645-6853-3094d8730225@amd.com>
Date: Thu, 20 Jan 2022 16:47:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM6PR12MB3163A49AA7557968B7E91BC6855A9@DM6PR12MB3163.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2186a974-7da6-4c79-acc5-08d9dc2c2215
X-MS-TrafficTypeDiagnostic: MW2PR12MB2394:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2394650BFA210EF024DD998E835A9@MW2PR12MB2394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XiyZFVQgUAkARwEqHUk540WuJj5+Vf0lCipraiMHc1g1r/1qkH+iwFqwg/7Rp4gWUVlUAdUF9zuBa8Pw+wfmRjZqddsfgbAlmUIaPr/8ipVssDjxdxSwEA7F5Wnmr+w7xNCB//iPRWhnlIIPD4sRnPUJyKOsqWFGInetQb5aFHpsUsFbEhU2ysAdnxMZPz+7YLtCrSv5i0Xbix/Yyv3D+kiG4v+4DrVT0dj9NLNcYdi7dh2edlp9wKUWhKBCexPMN5blJ5hS3r1teHVm6VpRzxV2TdURO4hgjCTSg7gJ+lmvfO/0jlZC3cFB0dG4uucXLz0hp8NDNTWYmrkmZCH+N+gBUxiLlSEU5n2L7LhlM5bMwo/q/VJPxrOY9L106+Qv3e8USSkUpu7qfaI/KTquF+8S9B7n2622EA/HPZgRFrZ6q53qvStmWxK2SWQRPLQyZzgTXR8BwkTv/FNaKV2934juadOiwO0/IimplY/iP3xUAGXwSFg+u1rQ1CjALsFUdejI09WWKEF+XqZxd6LgTIrjJPrmb4q93CMiizi9IDgE1WG1GMv0y27BRfA8fiE3yBRX1uLW2o0N+Zmm7wZR5Mz8jdmSbX7/NAzpe8OJVjSIEIZ2hx2sTeB5x+8MXSd0OjQ3dxrDjldW/x58c04hTi//KMcAzd80ATu6k2U+gUZKUNq6Dx1zNPoAgSkrHew5IWlCNel76QH6gCU36DNVRofhUqtWDZVVKk8KZs9MkTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(186003)(66556008)(30864003)(2906002)(31696002)(5660300002)(36756003)(86362001)(508600001)(8676002)(316002)(83380400001)(38100700002)(53546011)(6506007)(66574015)(110136005)(6486002)(66946007)(31686004)(66476007)(6512007)(6666004)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnl4ZUVBay92Z3ltVVg2emwweUUxK1Vrd0FqOVBNSEYxZlJieXRDZUs5RjBH?=
 =?utf-8?B?RVFDRGtIREhhY2M0dnpqQllDQis1eXdyUlFmbmQxMllYSW5YR1IvZG8zTUlr?=
 =?utf-8?B?Z1luUXNJV2tzNm5CZzMzTllNNmhuYU5LNHpBNXl1VmRIUHlBcUNZNXNkMTkw?=
 =?utf-8?B?bkRlN3d3NFJPMnpmcFhWZUlNNEJVMEsvV3FBL0dsT1I5K2dYQjJZODFiZzRn?=
 =?utf-8?B?Q09mVVRvdXhYaGVQRmkzekFyalEwQlFLU1JVaUZ5L0NEZ2lzdk13M0FsN1FG?=
 =?utf-8?B?V2s4VU1iZGdJUHlsQ1FTRXJmOTlEVGN1c3FwNElWMElTMTlhN0VzT3U1eFhM?=
 =?utf-8?B?eDYyZDUwbzdYRU1nNXFqZ0s3dFc3SGVQSHRmUXlFR2k4NCtWcTFxUnQ1b2d0?=
 =?utf-8?B?OTkzTGFHc1YrdENEVituaTJ6cE5xRnNOTThWRDMwak1idll1OWhZVGc1dEd4?=
 =?utf-8?B?TE0rdUFDcDZsdWNJeEI5WWViRjhvUFdUOGZBTDZZYk5xdWlGRFU2d1pDQVV3?=
 =?utf-8?B?eFNQQnYydjBKbzg3ZWdiZGJsWXVEMmZKWUxaRHNFS1lEcHhyTDcrS0p4N1Rz?=
 =?utf-8?B?b1p3UitYY2hZUDJZUzA0Wm1XaVBpZ3lNT1JXaGxKOU5DYjdVYTE4cjJRS0hU?=
 =?utf-8?B?RVpkUVZmdG4wL1QyMWtuR1k3N1FFeGdVS3E1LzBUQWZ2bk5FNHhHMnRLM3Zl?=
 =?utf-8?B?ZE5zN2Rib1czWDZQUVJ3a0JPaVVuVU1nZmtaODhFQWNoaU1oemRUU0x0QlFY?=
 =?utf-8?B?YkhEWFZGZW5pV2pPcnRTdnYwNjBoc1k1QWpnaGNSWTdnSkxsTUdiVks1VG1L?=
 =?utf-8?B?VFZkWVFIL2lxcEJHN054V01NeGVWNG4ydXR4d014aWxod21rbWdaVm1EVDFs?=
 =?utf-8?B?b0djYTAyL2JzbkdWSDBzZTVVVmNsOSs1dXBpcXNGcDlhV1lmUVZESTJMZG1m?=
 =?utf-8?B?a05obWlFRzhlem1qSGM0ODZOYjdlSDVmOEp3MGl0ZzZDY1RYdEZVb2xZSThX?=
 =?utf-8?B?RCsyZmRUSzJlcTZneWRJMWlYRXRsZ2toSnpRMG5yRWp3ZEo0Q09XUTYxeTgx?=
 =?utf-8?B?azU4bmVoK0Q1Ylpub056Q0N2Tkx3UkxyQXJQbkdLbWc3T3F0TG9QOFlXN1B0?=
 =?utf-8?B?UCsyVG9jdiswenhtSWRTSERUUmZiMnNoSXFKRk5hMmpuTGFwTGVjbVhlOG1K?=
 =?utf-8?B?UUNSa0Y0aVlvblV2ekF3T09JMXFEOWVXZmRjQmEvSkNwNjBHS0ErbkVSam1m?=
 =?utf-8?B?Z0N2YUtzVDMxYTY3K2NudUxqNTFDRWhWa2crYmRRU1I3UWRUSnlBTjBReHhV?=
 =?utf-8?B?cHdacklEQXUwMkd3TFNudTRFaVZ6Qm1SOUQwTzFDT1plSHlxc3duK0RMc2pq?=
 =?utf-8?B?THI2dXBJUnlZSTJOTHJhWHJyYmh2U3U1ZzRlT2lTSnVCcmFJWlVzT2t0TTlj?=
 =?utf-8?B?ZGl1OGsrS2VUWFpudHdtWWdDVllDeVBSTk52T3N5OVZ3T04rZ3hPenptRHkw?=
 =?utf-8?B?alZaUWRDUlFoZ2JmOGg2THRoMmlUbUlFQWg1OUFEakZRVzVYRkxLSE90ZE9H?=
 =?utf-8?B?WVdVZlQzSGdkN0xmY0pjVS9TcndMNDdqNHN2d0hHc1RSWXM0ek9xaXJndWpu?=
 =?utf-8?B?VkVibEJvTG5XVG05NzBKUFk1SU5FMTVLdlgxYW40bkJMWDJIWTA0b0NGSkUw?=
 =?utf-8?B?RlgyMGE3czJHODg0blFvUldCbGwyVUVJcHE0NXhQUnhBOGIrQ05WbFlYbXU0?=
 =?utf-8?B?WjY4em5wSklzNVZSeXp2N2tjTnlmZnVtaldrTTJvb3FISk4wU0k0bnVXVTV6?=
 =?utf-8?B?M2hkN083S0RlTWF0dDc2N21LKzM1K0VVdmY5QjAzM0M5dEtTMlBycG5mTy9C?=
 =?utf-8?B?aHB6SXNMd3dwZzhRQ1pFSHh2eVVacktleHdhV1NMUGNXNVA2NGxtdS9JMVN2?=
 =?utf-8?B?bm4vS0VwcTRHMDBDUFJ5b0dxT091MksvbFVZRlMrZzBURjUwOVlhYk14Wkcw?=
 =?utf-8?B?WnRtNHNISlVMVFE3T09XS1NpSHlWN1V5T0EzOXRjSDZrbWhLenpLZWd4bTRh?=
 =?utf-8?B?TDgwQnAxSkxmNEdxWkNGckN4Qkg1M3ZuVC9sZzFFODZ3R3pqVVgyWEdOOG5q?=
 =?utf-8?B?Q1J3T1JWZWJpd2N1QklMcVFJdTJWY25DYWVVSnB5NUZlOW9oQmNBYjRGUjlj?=
 =?utf-8?Q?RvGJJ9YlvpG1ZlZOsA1ky7A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2186a974-7da6-4c79-acc5-08d9dc2c2215
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 15:47:16.2528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFDDgzaZ60aZGjdQpUBCv1QqWAMdtsN7J5b0CVkjbnSs0nZUOcbjhrCctGUISnja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2394
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

I think we could remove this warning as well, all we need to do is to 
make sure that the GART table is always restored from the metadata 
before it is enabled in hardware.

I've seen that we do this anyway for most hardware generations, but we 
really need to double check.

Christian.

Am 20.01.22 um 16:04 schrieb Kim, Jonathan:
> [Public]
>
> Switching to a VRAM bounce buffer can drop performance around 4x~6x on Vega20 over larger access so it's not desired.
>
> Jon
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: January 20, 2022 9:10 AM
>> To: Chen, Guchun <Guchun.Chen@amd.com>; Christian König
>> <ckoenig.leichtzumerken@gmail.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
>>
>> I actually suggested to allocate the bounce buffer in VRAM, but that add a
>> bit more latency.
>>
>> Christian.
>>
>> Am 20.01.22 um 15:00 schrieb Chen, Guchun:
>>> [Public]
>>>
>>> Hi Christian,
>>>
>>> Unfortunately, your patch brings another warning from the same
>> sdma_access_bo's creation in amdgpu_ttm_init.
>>> In your patch, you introduce a new check of WARN_ON(!adev->gart.ptr)),
>> however, sdma_access_bo targets to create a bo in GTT domain, but adev-
>>> gart.ptr is ready in gmc_v10_0_gart_init only.
>>>
>>> Hi Jonathan,
>>>
>>> Is it mandatory to create this sdma_access_bo in GTT domain? Can we
>> change it to VRAM?
>>> Regards,
>>> Guchun
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Wednesday, January 19, 2022 10:38 PM
>>> To: Chen, Guchun <Guchun.Chen@amd.com>; Christian König
>>> <ckoenig.leichtzumerken@gmail.com>; Kim, Jonathan
>>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
>>>
>>> Hi Guchun,
>>>
>>> yes, just haven't found time to do this yet.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 19.01.22 um 15:24 schrieb Chen, Guchun:
>>>> [Public]
>>>>
>>>> Hello Christian,
>>>>
>>>> Do you plan to submit your code to drm-next branch?
>>>>
>>>> Regards,
>>>> Guchun
>>>>
>>>> -----Original Message-----
>>>> From: Chen, Guchun
>>>> Sent: Tuesday, January 18, 2022 10:22 PM
>>>> To: 'Christian König' <ckoenig.leichtzumerken@gmail.com>; Kim,
>>>> Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Subject: RE: [PATCH] drm/amdgpu: remove gart.ready flag
>>>>
>>>> [Public]
>>>>
>>>> Thanks for the clarification. The patch is:
>>>> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>>>>
>>>> Regards,
>>>> Guchun
>>>>
>>>> -----Original Message-----
>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>> Sent: Tuesday, January 18, 2022 10:10 PM
>>>> To: Chen, Guchun <Guchun.Chen@amd.com>; Kim, Jonathan
>>>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
>>>>
>>>> Am 18.01.22 um 14:28 schrieb Chen, Guchun:
>>>>> [Public]
>>>>>
>>>>> - if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>>>>> -         goto skip_pin_bo;
>>>>> -
>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>> - if (r)
>>>>> -         return r;
>>>>> -
>>>>> -skip_pin_bo:
>>>>>
>>>>> Does deleting skip_pin_bo path cause bo redundant pin in SRIOV case?
>>>> Pinning/unpinning the BO was already removed as well.
>>>>
>>>> See Nirmoy's patches in the git log.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>> Guchun
>>>>>
>>>>> -----Original Message-----
>>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>>> Sent: Tuesday, January 18, 2022 8:02 PM
>>>>> To: Chen, Guchun <Guchun.Chen@amd.com>; Kim, Jonathan
>>>>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Subject: [PATCH] drm/amdgpu: remove gart.ready flag
>>>>>
>>>>> That's just a leftover from old radeon days and was preventing CS and
>> GART bindings before the hardware was initialized. But nowdays that is
>> perfectly valid.
>>>>> The only thing we need to warn about are GART binding before the
>> table is even allocated.
>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>> ---
>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    | 35 +++-------
>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h    | 15 ++--
>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  9 +--
>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 77 ++++++---------
>> ------
>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +-
>>>>>      drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 11 +--
>>>>>      drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c       |  7 +-
>>>>>      drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c       |  8 +--
>>>>>      drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  8 +--
>>>>>      drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 10 +--
>>>>>      drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  5 +-
>>>>>      11 files changed, 52 insertions(+), 137 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>> index 645950a653a0..53cc844346f0 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>> @@ -150,7 +150,7 @@ void amdgpu_gart_table_vram_free(struct
>> amdgpu_device *adev)
>>>>>       * replaces them with the dummy page (all asics).
>>>>>       * Returns 0 for success, -EINVAL for failure.
>>>>>       */
>>>>> -int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t
>> offset,
>>>>> +void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t
>>>>> +offset,
>>>>>                            int pages)
>>>>>      {
>>>>>            unsigned t;
>>>>> @@ -161,13 +161,11 @@ int amdgpu_gart_unbind(struct
>> amdgpu_device *adev, uint64_t offset,
>>>>>            uint64_t flags = 0;
>>>>>            int idx;
>>>>>
>>>>> - if (!adev->gart.ready) {
>>>>> -         WARN(1, "trying to unbind memory from uninitialized GART
>> !\n");
>>>>> -         return -EINVAL;
>>>>> - }
>>>>> + if (WARN_ON(!adev->gart.ptr))
>>>>> +         return;
>>>>>
>>>>>            if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>>>> -         return 0;
>>>>> +         return;
>>>>>
>>>>>            t = offset / AMDGPU_GPU_PAGE_SIZE;
>>>>>            p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE; @@ -188,7 +186,6
>> @@ int
>>>>> amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>>>>                    amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>>>>>
>>>>>            drm_dev_exit(idx);
>>>>> - return 0;
>>>>>      }
>>>>>
>>>>>      /**
>>>>> @@ -204,7 +201,7 @@ int amdgpu_gart_unbind(struct
>> amdgpu_device *adev, uint64_t offset,
>>>>>       * Map the dma_addresses into GART entries (all asics).
>>>>>       * Returns 0 for success, -EINVAL for failure.
>>>>>       */
>>>>> -int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>>>> +void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t
>> offset,
>>>>>                        int pages, dma_addr_t *dma_addr, uint64_t flags,
>>>>>                        void *dst)
>>>>>      {
>>>>> @@ -212,13 +209,8 @@ int amdgpu_gart_map(struct amdgpu_device
>> *adev, uint64_t offset,
>>>>>            unsigned i, j, t;
>>>>>            int idx;
>>>>>
>>>>> - if (!adev->gart.ready) {
>>>>> -         WARN(1, "trying to bind memory to uninitialized GART
>> !\n");
>>>>> -         return -EINVAL;
>>>>> - }
>>>>> -
>>>>>            if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>>>> -         return 0;
>>>>> +         return;
>>>>>
>>>>>            t = offset / AMDGPU_GPU_PAGE_SIZE;
>>>>>
>>>>> @@ -230,7 +222,6 @@ int amdgpu_gart_map(struct amdgpu_device
>> *adev, uint64_t offset,
>>>>>                    }
>>>>>            }
>>>>>            drm_dev_exit(idx);
>>>>> - return 0;
>>>>>      }
>>>>>
>>>>>      /**
>>>>> @@ -246,20 +237,14 @@ int amdgpu_gart_map(struct
>> amdgpu_device *adev, uint64_t offset,
>>>>>       * (all asics).
>>>>>       * Returns 0 for success, -EINVAL for failure.
>>>>>       */
>>>>> -int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>>>>> +void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t
>> offset,
>>>>>                         int pages, dma_addr_t *dma_addr,
>>>>>                         uint64_t flags)
>>>>>      {
>>>>> - if (!adev->gart.ready) {
>>>>> -         WARN(1, "trying to bind memory to uninitialized GART
>> !\n");
>>>>> -         return -EINVAL;
>>>>> - }
>>>>> -
>>>>> - if (!adev->gart.ptr)
>>>>> -         return 0;
>>>>> + if (WARN_ON(!adev->gart.ptr))
>>>>> +         return;
>>>>>
>>>>> - return amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
>>>>> -                        adev->gart.ptr);
>>>>> + amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
>>>>> +adev->gart.ptr);
>>>>>      }
>>>>>
>>>>>      /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>> index 78895413cf9f..8fea3e04e411 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>> @@ -46,7 +46,6 @@ struct amdgpu_gart {
>>>>>            unsigned                        num_gpu_pages;
>>>>>            unsigned                        num_cpu_pages;
>>>>>            unsigned                        table_size;
>>>>> - bool                            ready;
>>>>>
>>>>>            /* Asic default pte flags */
>>>>>            uint64_t                        gart_pte_flags;
>>>>> @@ -58,12 +57,12 @@ int amdgpu_gart_table_vram_pin(struct
>> amdgpu_device *adev);  void amdgpu_gart_table_vram_unpin(struct
>> amdgpu_device *adev);  int amdgpu_gart_init(struct amdgpu_device
>> *adev);  void amdgpu_gart_dummy_page_fini(struct amdgpu_device
>> *adev); -int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t
>> offset,
>>>>> -                int pages);
>>>>> -int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>>>> -             int pages, dma_addr_t *dma_addr, uint64_t flags,
>>>>> -             void *dst);
>>>>> -int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>>>>> -              int pages, dma_addr_t *dma_addr, uint64_t flags);
>>>>> +void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t
>> offset,
>>>>> +                 int pages);
>>>>> +void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t
>> offset,
>>>>> +              int pages, dma_addr_t *dma_addr, uint64_t flags,
>>>>> +              void *dst);
>>>>> +void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t
>> offset,
>>>>> +               int pages, dma_addr_t *dma_addr, uint64_t flags);
>>>>>      void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
>>>>> #endif diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>> index 9151950e0cc3..babdd915c4c3 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>> @@ -224,26 +224,21 @@ uint64_t amdgpu_gtt_mgr_usage(struct
>> amdgpu_gtt_mgr *mgr)
>>>>>       *
>>>>>       * Re-init the gart for each known BO in the GTT.
>>>>>       */
>>>>> -int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>>>>> +void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>>>>>      {
>>>>>            struct amdgpu_gtt_node *node;
>>>>>            struct drm_mm_node *mm_node;
>>>>>            struct amdgpu_device *adev;
>>>>> - int r = 0;
>>>>>
>>>>>            adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>>>>>            spin_lock(&mgr->lock);
>>>>>            drm_mm_for_each_node(mm_node, &mgr->mm) {
>>>>>                    node = container_of(mm_node, typeof(*node),
>> base.mm_nodes[0]);
>>>>> -         r = amdgpu_ttm_recover_gart(node->tbo);
>>>>> -         if (r)
>>>>> -                 break;
>>>>> +         amdgpu_ttm_recover_gart(node->tbo);
>>>>>            }
>>>>>            spin_unlock(&mgr->lock);
>>>>>
>>>>>            amdgpu_gart_invalidate_tlb(adev);
>>>>> -
>>>>> - return r;
>>>>>      }
>>>>>
>>>>>      /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index b489cd8abe31..9cdb61ec669e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -246,10 +246,7 @@ static int amdgpu_ttm_map_buffer(struct
>> ttm_buffer_object *bo,
>>>>>                    dma_addr_t *dma_addr;
>>>>>
>>>>>                    dma_addr = &bo->ttm->dma_address[mm_cur->start >>
>> PAGE_SHIFT];
>>>>> -         r = amdgpu_gart_map(adev, 0, num_pages, dma_addr,
>> flags,
>>>>> -                             cpu_addr);
>>>>> -         if (r)
>>>>> -                 goto error_free;
>>>>> +         amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags,
>> cpu_addr);
>>>>>            } else {
>>>>>                    dma_addr_t dma_address;
>>>>>
>>>>> @@ -257,11 +254,8 @@ static int amdgpu_ttm_map_buffer(struct
>> ttm_buffer_object *bo,
>>>>>                    dma_address += adev->vm_manager.vram_base_offset;
>>>>>
>>>>>                    for (i = 0; i < num_pages; ++i) {
>>>>> -                 r = amdgpu_gart_map(adev, i << PAGE_SHIFT, 1,
>>>>> -                                     &dma_address, flags, cpu_addr);
>>>>> -                 if (r)
>>>>> -                         goto error_free;
>>>>> -
>>>>> +                 amdgpu_gart_map(adev, i << PAGE_SHIFT, 1,
>> &dma_address,
>>>>> +                                 flags, cpu_addr);
>>>>>                            dma_address += PAGE_SIZE;
>>>>>                    }
>>>>>            }
>>>>> @@ -826,14 +820,13 @@ static void
>> amdgpu_ttm_tt_unpin_userptr(struct
>>>>> ttm_device *bdev,  #endif  }
>>>>>
>>>>> -static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>>> -                         struct ttm_buffer_object *tbo,
>>>>> -                         uint64_t flags)
>>>>> +static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>>> +                          struct ttm_buffer_object *tbo,
>>>>> +                          uint64_t flags)
>>>>>      {
>>>>>            struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
>>>>>            struct ttm_tt *ttm = tbo->ttm;
>>>>>            struct amdgpu_ttm_tt *gtt = (void *)ttm;
>>>>> - int r;
>>>>>
>>>>>            if (amdgpu_bo_encrypted(abo))
>>>>>                    flags |= AMDGPU_PTE_TMZ;
>>>>> @@ -841,10 +834,8 @@ static int amdgpu_ttm_gart_bind(struct
>> amdgpu_device *adev,
>>>>>            if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
>>>>>                    uint64_t page_idx = 1;
>>>>>
>>>>> -         r = amdgpu_gart_bind(adev, gtt->offset, page_idx,
>>>>> -                         gtt->ttm.dma_address, flags);
>>>>> -         if (r)
>>>>> -                 goto gart_bind_fail;
>>>>> +         amdgpu_gart_bind(adev, gtt->offset, page_idx,
>>>>> +                          gtt->ttm.dma_address, flags);
>>>>>
>>>>>                    /* The memory type of the first page defaults to UC. Now
>>>>>                     * modify the memory type to NC from the second page of
>> @@ -853,21 +844,13 @@ static int amdgpu_ttm_gart_bind(struct
>> amdgpu_device *adev,
>>>>>                    flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
>>>>>                    flags |=
>> AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
>>>>> -         r = amdgpu_gart_bind(adev,
>>>>> -                         gtt->offset + (page_idx << PAGE_SHIFT),
>>>>> -                         ttm->num_pages - page_idx,
>>>>> -                         &(gtt->ttm.dma_address[page_idx]), flags);
>>>>> +         amdgpu_gart_bind(adev, gtt->offset + (page_idx <<
>> PAGE_SHIFT),
>>>>> +                          ttm->num_pages - page_idx,
>>>>> +                          &(gtt->ttm.dma_address[page_idx]), flags);
>>>>>            } else {
>>>>> -         r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>>>> -                              gtt->ttm.dma_address, flags);
>>>>> +         amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>>>> +                          gtt->ttm.dma_address, flags);
>>>>>            }
>>>>> -
>>>>> -gart_bind_fail:
>>>>> - if (r)
>>>>> -         DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
>>>>> -                   ttm->num_pages, gtt->offset);
>>>>> -
>>>>> - return r;
>>>>>      }
>>>>>
>>>>>      /*
>>>>> @@ -883,7 +866,7 @@ static int amdgpu_ttm_backend_bind(struct
>> ttm_device *bdev,
>>>>>            struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>>>>>            struct amdgpu_ttm_tt *gtt = (void*)ttm;
>>>>>            uint64_t flags;
>>>>> - int r = 0;
>>>>> + int r;
>>>>>
>>>>>            if (!bo_mem)
>>>>>                    return -EINVAL;
>>>>> @@ -930,14 +913,10 @@ static int amdgpu_ttm_backend_bind(struct
>>>>> ttm_device *bdev,
>>>>>
>>>>>            /* bind pages into GART page tables */
>>>>>            gtt->offset = (u64)bo_mem->start << PAGE_SHIFT;
>>>>> - r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>>>> -         gtt->ttm.dma_address, flags);
>>>>> -
>>>>> - if (r)
>>>>> -         DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
>>>>> -                   ttm->num_pages, gtt->offset);
>>>>> + amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>>>> +                  gtt->ttm.dma_address, flags);
>>>>>            gtt->bound = true;
>>>>> - return r;
>>>>> + return 0;
>>>>>      }
>>>>>
>>>>>      /*
>>>>> @@ -987,12 +966,7 @@ int amdgpu_ttm_alloc_gart(struct
>>>>> ttm_buffer_object *bo)
>>>>>
>>>>>            /* Bind pages */
>>>>>            gtt->offset = (u64)tmp->start << PAGE_SHIFT;
>>>>> - r = amdgpu_ttm_gart_bind(adev, bo, flags);
>>>>> - if (unlikely(r)) {
>>>>> -         ttm_resource_free(bo, &tmp);
>>>>> -         return r;
>>>>> - }
>>>>> -
>>>>> + amdgpu_ttm_gart_bind(adev, bo, flags);
>>>>>            amdgpu_gart_invalidate_tlb(adev);
>>>>>            ttm_resource_free(bo, &bo->resource);
>>>>>            ttm_bo_assign_mem(bo, tmp);
>>>>> @@ -1006,19 +980,16 @@ int amdgpu_ttm_alloc_gart(struct
>> ttm_buffer_object *bo)
>>>>>       * Called by amdgpu_gtt_mgr_recover() from
>> amdgpu_device_reset() to
>>>>>       * rebind GTT pages during a GPU reset.
>>>>>       */
>>>>> -int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo)
>>>>> +void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo)
>>>>>      {
>>>>>            struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>>>>>            uint64_t flags;
>>>>> - int r;
>>>>>
>>>>>            if (!tbo->ttm)
>>>>> -         return 0;
>>>>> +         return;
>>>>>
>>>>>            flags = amdgpu_ttm_tt_pte_flags(adev, tbo->ttm, tbo->resource);
>>>>> - r = amdgpu_ttm_gart_bind(adev, tbo, flags);
>>>>> -
>>>>> - return r;
>>>>> + amdgpu_ttm_gart_bind(adev, tbo, flags);
>>>>>      }
>>>>>
>>>>>      /*
>>>>> @@ -1032,7 +1003,6 @@ static void
>> amdgpu_ttm_backend_unbind(struct ttm_device *bdev,  {
>>>>>            struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>>>>>            struct amdgpu_ttm_tt *gtt = (void *)ttm;
>>>>> - int r;
>>>>>
>>>>>            /* if the pages have userptr pinning then clear that first */
>>>>>            if (gtt->userptr) {
>>>>> @@ -1052,10 +1022,7 @@ static void
>> amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
>>>>>                    return;
>>>>>
>>>>>            /* unbind shouldn't be done for GDS/GWS/OA in
>> ttm_bo_clean_mm */
>>>>> - r = amdgpu_gart_unbind(adev, gtt->offset, ttm->num_pages);
>>>>> - if (r)
>>>>> -         DRM_ERROR("failed to unbind %u pages at 0x%08llX\n",
>>>>> -                   gtt->ttm.num_pages, gtt->offset);
>>>>> + amdgpu_gart_unbind(adev, gtt->offset, ttm->num_pages);
>>>>>            gtt->bound = false;
>>>>>      }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> index 084aa49e627d..d9691f262f16 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> @@ -119,7 +119,7 @@ void amdgpu_vram_mgr_fini(struct
>> amdgpu_device
>>>>> *adev);
>>>>>
>>>>>      bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>>>> uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr); -int
>>>>> amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>>>> +void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>>>>
>>>>>      uint64_t amdgpu_preempt_mgr_usage(struct
>> ttm_resource_manager
>>>>> *man);
>>>>>
>>>>> @@ -162,7 +162,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>>>>                            struct dma_fence **fence);
>>>>>
>>>>>      int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo); -int
>>>>> amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>>> +void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>>>      uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev,
>>>>> uint32_t type);
>>>>>
>>>>>      #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> index 4f8d356f8432..867c94a1a81a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> @@ -1000,14 +1000,7 @@ static int gmc_v10_0_gart_enable(struct
>> amdgpu_device *adev)
>>>>>                    return -EINVAL;
>>>>>            }
>>>>>
>>>>> - if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>>>>> -         goto skip_pin_bo;
>>>>> -
>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>> - if (r)
>>>>> -         return r;
>>>>> -
>>>>> -skip_pin_bo:
>>>>> + amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>            r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>            if (r)
>>>>>                    return r;
>>>>> @@ -1033,8 +1026,6 @@ static int gmc_v10_0_gart_enable(struct
>> amdgpu_device *adev)
>>>>>                     (unsigned)(adev->gmc.gart_size >> 20),
>>>>>                     (unsigned long long)amdgpu_bo_gpu_offset(adev-
>>> gart.bo));
>>>>> - adev->gart.ready = true;
>>>>> -
>>>>>            return 0;
>>>>>      }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>> index cd6c38e083d0..3baece11d74e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>> @@ -469,16 +469,14 @@ static void gmc_v6_0_set_prt(struct
>> amdgpu_device *adev, bool enable)  static int
>> gmc_v6_0_gart_enable(struct amdgpu_device *adev)  {
>>>>>            uint64_t table_addr;
>>>>> - int r, i;
>>>>>            u32 field;
>>>>> + int i;
>>>>>
>>>>>            if (adev->gart.bo == NULL) {
>>>>>                    dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>                    return -EINVAL;
>>>>>            }
>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>> - if (r)
>>>>> -         return r;
>>>>> + amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>
>>>>>            table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>
>>>>> @@ -558,7 +556,6 @@ static int gmc_v6_0_gart_enable(struct
>> amdgpu_device *adev)
>>>>>            dev_info(adev->dev, "PCIE GART of %uM enabled (table at
>> 0x%016llX).\n",
>>>>>                     (unsigned)(adev->gmc.gart_size >> 20),
>>>>>                     (unsigned long long)table_addr);
>>>>> - adev->gart.ready = true;
>>>>>            return 0;
>>>>>      }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> index ab8adbff9e2d..cf83f8c258f4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> @@ -613,17 +613,14 @@ static void gmc_v7_0_set_prt(struct
>> amdgpu_device *adev, bool enable)  static int
>> gmc_v7_0_gart_enable(struct amdgpu_device *adev)  {
>>>>>            uint64_t table_addr;
>>>>> - int r, i;
>>>>>            u32 tmp, field;
>>>>> + int i;
>>>>>
>>>>>            if (adev->gart.bo == NULL) {
>>>>>                    dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>                    return -EINVAL;
>>>>>            }
>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>> - if (r)
>>>>> -         return r;
>>>>> -
>>>>> + amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>            table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>
>>>>>            /* Setup TLB control */
>>>>> @@ -712,7 +709,6 @@ static int gmc_v7_0_gart_enable(struct
>> amdgpu_device *adev)
>>>>>            DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>>>>                     (unsigned)(adev->gmc.gart_size >> 20),
>>>>>                     (unsigned long long)table_addr);
>>>>> - adev->gart.ready = true;
>>>>>            return 0;
>>>>>      }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> index 054733838292..7cc7c8001734 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> @@ -837,17 +837,14 @@ static void gmc_v8_0_set_prt(struct
>> amdgpu_device *adev, bool enable)  static int
>> gmc_v8_0_gart_enable(struct amdgpu_device *adev)  {
>>>>>            uint64_t table_addr;
>>>>> - int r, i;
>>>>>            u32 tmp, field;
>>>>> + int i;
>>>>>
>>>>>            if (adev->gart.bo == NULL) {
>>>>>                    dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>                    return -EINVAL;
>>>>>            }
>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>> - if (r)
>>>>> -         return r;
>>>>> -
>>>>> + amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>            table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>
>>>>>            /* Setup TLB control */
>>>>> @@ -953,7 +950,6 @@ static int gmc_v8_0_gart_enable(struct
>> amdgpu_device *adev)
>>>>>            DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>>>>                     (unsigned)(adev->gmc.gart_size >> 20),
>>>>>                     (unsigned long long)table_addr);
>>>>> - adev->gart.ready = true;
>>>>>            return 0;
>>>>>      }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> index c76ffd1a70cd..9f71f810c2f8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> @@ -1783,14 +1783,7 @@ static int gmc_v9_0_gart_enable(struct
>> amdgpu_device *adev)
>>>>>                    return -EINVAL;
>>>>>            }
>>>>>
>>>>> - if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>>>>> -         goto skip_pin_bo;
>>>>> -
>>>>> - r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>> - if (r)
>>>>> -         return r;
>>>>> -
>>>>> -skip_pin_bo:
>>>>> + amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>>>            r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>            if (r)
>>>>>                    return r;
>>>>> @@ -1807,7 +1800,6 @@ static int gmc_v9_0_gart_enable(struct
>> amdgpu_device *adev)
>>>>>            DRM_INFO("PTB located at 0x%016llX\n",
>>>>>                            (unsigned long long)amdgpu_bo_gpu_offset(adev-
>>> gart.bo));
>>>>> - adev->gart.ready = true;
>>>>>            return 0;
>>>>>      }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> index d5d2cf2ee788..88db82b3d443 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>>> @@ -86,10 +86,7 @@ svm_migrate_gart_map(struct amdgpu_ring
>> *ring,
>>>>> uint64_t npages,
>>>>>
>>>>>            cpu_addr = &job->ibs[0].ptr[num_dw];
>>>>>
>>>>> - r = amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
>>>>> - if (r)
>>>>> -         goto error_free;
>>>>> -
>>>>> + amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
>>>>>            r = amdgpu_job_submit(job, &adev->mman.entity,
>>>>>                                  AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
>>>>>            if (r)
>>>>> --
>>>>> 2.25.1

