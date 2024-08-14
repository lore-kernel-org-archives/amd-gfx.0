Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE1DC52D7B
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 14:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6D410E0B0;
	Wed, 14 Aug 2024 14:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cIFmUk2n";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A393B10E0B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 14:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/eaP1g4nGTxodUghWCo6wQUjgZsC+V7ebupgUqpTdyb4nzbyHkiqLDjMtSIz1aVdMmWO9oncu181RkE7i1+r6DFZ7v8fGakfpqoFjIgMsEBqUHW1xOCDnTEm502MTa5Jms9f87fhOtVYYHI88aS33Q9oQthyKUOQNUbIH6wA5BlImjb+U4tA5pTZeQje8L1eDFOfmHvp58Rnc+6BdkwmXfwmZmRq3dmdVqn7zgtM6fgnqPU/kVUaTd9PGY/LJ0hxCfY4KdZ1Plzb4akrtOYIEcF9kcKdtGUFVci+pnUtBXFu0RZ5RMt2W9RJWwZOHTOB/9Y+W/NJtV8bLuaFNAtLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMUDODG9VDMqo7Oz20FRualNrFozMJez/PZYGE30MDY=;
 b=ScBUcRjN9Efi4/8lix79vVDMsy1GKofcYh76B6tDCCGs5W/o7zgZSjN20eggC6fsrdLL8bN0ISDPQMcCERs4r2UCUmhYDQM6gIJlosiRC/nicvVF07/TGtLJt6bTEr4Zhidp38hswPZ0OZ54ISYDvWy8rFzdK4iRQSvTd63oAFIsQxsQ2bhd68mqovH96oMFL+n0wRwgK5D/kyrhSuXItdarl34l36gop4Rx1lhg8aPJsmx92RxfbcIFDxHaXOVXQ5/jYXOIhf7+yPfKUmEov5Lw7OweMueOdF4e827xXn1w11Tdqy7/OsNIsLV1zboo9ydefdCrnqFHzSfTvbySPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMUDODG9VDMqo7Oz20FRualNrFozMJez/PZYGE30MDY=;
 b=cIFmUk2nrR2XP9xS5mt0d+Tat0lFEb+Y7NhgDfDUuu6DHIHgscIliQ4NSHEhbEZ3s3rFidKcxyZAxNkUGbhyhFwt5vNjV6RfXFwJiOLFojdGl7+FYiR4vD1BCnI0EaYQWMzlgjkkldsgSKOlvUDAcff/Shjtx3m1FcTps+ywhD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 14:47:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 14:47:10 +0000
Message-ID: <0ed6e47f-4b68-4da9-bc9b-1d2e47d1511f@amd.com>
Date: Wed, 14 Aug 2024 10:47:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 Christopher Snowhill <chris@kode54.net>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <7e40e8c2-d6a7-4e10-b71c-c4f869e825ab@amd.com>
 <E3D1CFD8-93E9-4B38-BC02-7432B94432E8@kode54.net>
 <CY5PR12MB6369351BE6C7835F591DBCD2C1872@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CY5PR12MB6369351BE6C7835F591DBCD2C1872@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c17b466-ce69-4920-c299-08dcbc6ffa4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: qbhTLCzYNWNrQn+BSwYfjEuqlktTPzhitR+DJ9NllWAY1KPZHKKLu2H2oGY73a4jQFu1O34R9PSr3Ty0MbdM+IZ7Cg5W+yErAu0ufO5l/A6MaFkg1Mng6c7h2J1pTGyBd4hQiMVX4FcmcPHybRje/fLQtDw9lzBCH295XxFqrfdZuCzSNPcIXrv1Y+7wsoomG9pyPQvdH8gyx1qqJPO5BSWccT6RXryijnpDnkkyAmgi/IILz7CKR8ooqXWEdYiy9QhXjHJOQSWlRbRx423ToMjFqCuiQJ15jegM60kfB7357N8j0ZMTsoaKmzCp3J7D0oZsF1S7EDDJNRA5OwjbrpI41/aYeaksNZl5tKTqfYlcq+osnqo2lW2mZ4KB3jasE2nZuyl27v+9/pvINCT4zg8EAitHzn5HTeaVysGTCfYYFN8772sgpOdFxv+1I0S/0S/KS31UvSDymv6r/G41xYQw+Dvx5GEuKSnWTAGRr+9axgrAaYPMz6aetW56fN3j8CGlbU6sXO8qfF1zq8eeb76FheIQAv9lbBj+H5wqr0foi8gsOe7MMtUePt6y1YqT3/iTIy/Ihtx9u06Szr9t6kWxsjOIiNKBz2zmyzzm11w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGc2blZSN1NmbkJsdjlZN3RjS0dTVVFVNjhhY0JGdmRZUnpXSVpwMUZhZnRF?=
 =?utf-8?B?eFRLNVAwZmhJdi9TQUYrTG8wdW01RWs1eGZaRFBFanFXbllhVE81UlowMDhN?=
 =?utf-8?B?a0tUWmp2NUJ2UVBHd282YXJRNGtTWGdVaXFzNnJXWWJHTXZkSmNNQ3lTakVx?=
 =?utf-8?B?RTBoaXNJcWMxeXl3ZTNTVkdWckM0L2IzNXB0YWMxdkFkaTU1bnovZzZhOWo3?=
 =?utf-8?B?WHEyYW1IYUtLZFhXYTBqMVZsOG96WFBRREhSL090VmFQR2NNOXpNM1c3aDhW?=
 =?utf-8?B?VzUzZVIrZ3p3dEl5TCtiZmtLbUNQZ1hEU3JPayt4dmVsQk5VbG9jeHBZQ2tX?=
 =?utf-8?B?WHptYWlWL0I0RWFkbmgyTk5BWllFMnkwRXlJL0RSeHk4U0x3aXZ6Z0xxbGE2?=
 =?utf-8?B?cE45N29KeDdFaVZHeEl2OVVQa1RDZHk4dFFRQitNT2kzN2tvcjRiWUM4bUt2?=
 =?utf-8?B?ZS93Y0JUVGR6L2VTZXJCVDZ4UEZhZWRVZDQ0b1JvdlRKYTczOTZxRCt1NXlx?=
 =?utf-8?B?YW9GeVJHKzFmNTFsczFCczVkc2hBNy8rdHdwZTV5SWp1MEVwWDNOdy90ZkFh?=
 =?utf-8?B?L2hoczVMOTdOSTRRY0ZaSGVyTkJSbWdwbzRXemhGVE94WmcwQTVSQmNRWDQw?=
 =?utf-8?B?L1BLbGh3cWh5ZVh3R2Z3elNyT1UyTk11U1pJd2NkSlJ1V09wRWtEY3Ywc1RV?=
 =?utf-8?B?UEFhWFVvMmVIK3RoNkFySkFOdVh0YmhZWmRRTGx0cWNXaDRvVmlDNkdWYkti?=
 =?utf-8?B?VkVTUlRiOEx1aS9kNjN5Y2VVTjk4Q3FjclRNNURGZDBnRFdCTmwwQm9rSG1a?=
 =?utf-8?B?Z0VVSzJ0VnlDTElDRklpMXFiR2NVYUVGM01KeElBQkFPeUM3NjlWTkdMbktY?=
 =?utf-8?B?OGV5NGFHcGdvRFk0U1RwUVdmOWRkNk11YlJVQTNZTHN1c0oxUXpNaTk0YXlk?=
 =?utf-8?B?Z2xEUUxCNFUxbVV1SmJIbHUzWUdoaFBNdW9WYWxLbDA3MTQrbFo0ME1aZDlZ?=
 =?utf-8?B?R294UFNhNUdGZmdsamdrMDJ6dDlUK0VRTDRxUDc2RUdYTktseHBaTFowVlpP?=
 =?utf-8?B?SUI5NVNpbGpldmtsQXo5THNkNjNMUFFqbEExWWsyd21jTFduZHovejFhMUU0?=
 =?utf-8?B?ZDhqU1NxUDBlYk1KODR2d0tTWnUvSnU5YkdqMFcxamdFcnlLVG9YUzVLYkMw?=
 =?utf-8?B?eHdkL2NsNmZBUGlXZ0V5Q0RodjRNQUxxVHZQb29mV0FMNHhDcGJMVXE1OUNE?=
 =?utf-8?B?WDRXcVFiUlNrUkFwZERWSlk3ZTd1Zk9kTEkvcnRaY0Z6MGZtcEpBTTNTMnIr?=
 =?utf-8?B?alYwR1c2UFZBck1FYlV2WWhGWDZEMXVLNVVwRTNWbVJjRDJhZWRRMVFSTE9t?=
 =?utf-8?B?MS9XTm42azdPcWxTN3NDRG16N0R3YXZqWE52SXJMbnk0ZlhWWW1WbGVBOFND?=
 =?utf-8?B?YjJkZ2lqU0orMWlvMkgrbWNBbkJQUjFsTUhWc0U1THdLK3I5cTUwYi9JOVc5?=
 =?utf-8?B?djBlSnc4V1RFamRvSzZkdGtncE9GdThySTNYSHJ1L0JnZ3I5TEpHVTZwWlNx?=
 =?utf-8?B?L3JSa2VkNW04aXFEZzBoVldGUXp1YkNPT2RpaERtdFhFaVB4K1pwdU5Db2Q1?=
 =?utf-8?B?V2lXMnpFVW1PN0pRYUFLNmR3d01sK0JWYUFKWUJ3Z3BtWjJCbTJqTkxXZFV4?=
 =?utf-8?B?eHpzSTYyVDVpSlZYeE5CWVNwQ015cjJqOE5rVTRubEpkTTBKWGd1VkowSHRY?=
 =?utf-8?B?L1BNY05MbmRwR2lMUlZiOXhjTEt3NGlGUXo4SzhVTzdvMTV4RXV6a3VOdlRJ?=
 =?utf-8?B?azh0bzU0YU9NeFNncS9xNjB6TFppSXBDaVlvUU01OTlMRjRPTGRTUWZsNlR6?=
 =?utf-8?B?WmV2eitKS2V0Sm1JaFAydkt0QnAwVDRLMWFzdzNUdjVBQTFXU0Q2YUtFZXZo?=
 =?utf-8?B?Ym1PNHl1Wm93YVdneklMZjBOZEJyTkVBcE9MT2NCbFIvK3E1QldjNTdHZ054?=
 =?utf-8?B?SHNOSHF0b0ptMVJSZWVmcjRLeVlWVU40bGFsQVpSd2t0dXdackhkeDdWbmR3?=
 =?utf-8?B?ZldvUGFWMlY5bWVtVE1iTUhtM0tEUytjY2UxVitJTVIyZStwYm1BTHJvZ1Vm?=
 =?utf-8?Q?TxGp0yBS/Alc/dWcvllPxUrpS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c17b466-ce69-4920-c299-08dcbc6ffa4a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 14:47:10.8311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uohal79zOpva0AhkACobZNiutYDEnaTdO25NJoGECeLOeLT6qpUFI15z8oOBXOAmnIdvF/PJ3D7ux9SwpzQhww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
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



On 2024-08-14 2:35, Zhang, Yifan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> AFAIK, for low level libraries, e.g. LLVM, ROCr, Hip/OpenCL runtimes, all GPUs are supported. But for the mathlibs and frameworks, only limited GPUs are supported. E.g. :
> 
> https://github.com/ROCm/rocBLAS/blob/28877e5e134a157b7ea56b88a1a12ba551d53cbf/CMakeLists.txt#L111
> 
> set( TARGET_LIST_ROCM_6.3 "gfx900;gfx906:xnack-;gfx908:xnack-;gfx90a;gfx940;gfx941;gfx942;gfx1010;gfx1012;gfx1030;gfx1100;gfx1101;gfx1102;gfx1200;gfx1201")
> 
> On the unsupported GPUs, HSA_OVERRIDE_GFX_VERSION currently works as a workaround.

Then HSA_OVERRIDE_GFX_VERSION probably does more than we need it to for working around support in the math libs. What math libs care about is mainly the ISA target version. There should be no need to allocate different sizes for CWSR areas.

Regards,
  Felix


> 
> 
> Best Regards,
> Yifan
> 
> -----Original Message-----
> From: Christopher Snowhill <chris@kode54.net>
> Sent: Wednesday, August 14, 2024 10:01 AM
> To: Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>
> Subject: Re: [PATCH] drm/amdkfd: keep create queue success if cwsr save area doesn't match
> 
> 
> 
>> On Aug 13, 2024, at 6:52 PM, Felix Kuehling <felix.kuehling@amd.com> wrote:
>>
>> ﻿Hang on a second. If there are production GPUs that only work with HSA_OVERRIDE_GFX_VERSION right now, then we should make those GPUs properly supported. I thought this was only used internally for bring-up or maybe externally as a short-term solution before we upstream proper support for new GPUs.
> 
> For instance, for a bunch of compute things, I have to override 10.3.0 for my 10.3.1 GPU, a 6700 XT, because nobody builds or packages the kernels for 10.3.1.
> 
>>
>> Regards,
>>  Felix
>>
>>
>>> On 2024-08-11 22:10, Zhang, Yifan wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> I agree that adding exp_hw_support is a safer approach. My concern is that HSA_OVERRIDE_GFX_VERSION has been used for a while and has become a status quo for running ROCm on unsupported APUs. I'm not sure if this approach will be a burden for APU end users. Adding driver load parameters is more complicated than simply adding an environment variable on consumer PCs.
>>>
>>> Best Regards,
>>> Yifan
>>>
>>> -----Original Message-----
>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Sent: Saturday, August 10, 2024 7:37 AM
>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Kasiviswanathan, Harish
>>> <Harish.Kasiviswanathan@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Yang, Philip <Philip.Yang@amd.com>
>>> Subject: Re: [PATCH] drm/amdkfd: keep create queue success if cwsr
>>> save area doesn't match
>>>
>>> Maybe we can turn this check into a warnings if, and only if the exp_hw_support module param is set. That way we don't water down the checks on the production code path but allow experimental setups to run without a seat belt.
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> On 2024-08-09 01:39, Zhang, Yifan wrote:
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>> Yes, I think we need that change for a normal code path, but this case is introduced only with the HSA_OVERRIDE_GFX_VERSION environment setting, which implies that "the override ASIC is compatible with the real ASIC." It is intended for experimental purposes. When a user is using HSA_OVERRIDE_GFX_VERSION, they should be aware of the potential risks it may bring. Usually, HSA_OVERRIDE_GFX_VERSION is used to force an unsupported APU to be recognized as a ROCm-supported high-end dGPU, which has a large cwsr save area, making the operation safe. This check was added to KFD two weeks ago, the HSA_OVERRIDE_GFX_VERSION environment had been working fine before that.
>>>>
>>>> Best Regards,
>>>> Yifan
>>>>
>>>> -----Original Message-----
>>>> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>>> Sent: Thursday, August 8, 2024 10:46 PM
>>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>;
>>>> amd-gfx@lists.freedesktop.org
>>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip
>>>> <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>>>> Subject: RE: [PATCH] drm/amdkfd: keep create queue success if cwsr
>>>> save area doesn't match
>>>>
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>> In this case, shouldn't larger of two sizes be used. Also, we should have an upper bound check.
>>>>
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Yifan Zhang
>>>> Sent: Thursday, August 8, 2024 4:44 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip
>>>> <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>>>> Subject: [PATCH] drm/amdkfd: keep create queue success if cwsr save
>>>> area doesn't match
>>>>
>>>> If HSA_OVERRIDE_GFX_VERSION is used in ROCm workload, user space and kernel use different spec to calculate cwsr save area, current check may fail create queue ioctl. Change error to warn to make create queue succeed in that case.
>>>>
>>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 4 +---
>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>>> index e0a073ae4a49..9f283aff057a 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>>> @@ -295,11 +295,9 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>>>>         }
>>>>
>>>>         if (properties->ctx_save_restore_area_size != topo_dev->node_props.cwsr_size) {
>>>> -               pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
>>>> +               pr_warn("queue cwsr size 0x%x not equal to node cwsr
>>>> + size 0x%x\n",
>>>>                         properties->ctx_save_restore_area_size,
>>>>                         topo_dev->node_props.cwsr_size);
>>>> -               err = -EINVAL;
>>>> -               goto out_err_unreserve;
>>>>         }
>>>>
>>>>         total_cwsr_size = (topo_dev->node_props.cwsr_size +
>>>> topo_dev->node_props.debug_memory_size)
>>>> --
>>>> 2.37.3
>>>>
>>>>
