Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10509C6FA86
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 07:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD5610E0F1;
	Tue, 27 Sep 2022 07:29:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477D610E0F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 07:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8SKWcyLqo0F7ZSSslOEOjPFAEWgq1w0yUK1dI1p0HJvVo+HU/LdSrNWnVb64y0jJS162iDLz73C5fD75EY3hfGZqjodn74SMletwUMuIy0tH8PL51PcK2cE96oIiBbhHmGOyDYwcPT9wZdXrTbXxmK+Yqh0kN6P6liTwpQbgiEb0CIbwoYQ1+URWPpQG8LMo+qnFayF6AIupZC3GnAtANR3SVq0KeRrgMdbwpwMXyolWWiKdpz0m0T5v8xKR69WGT4mLY5BXYf3RWEU+pJXNWEOMV966DSMf6fmIzCVPOhSChf5nvpLKzkM84A5qLq3osfVx0K7DC11TvOM7W5s6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvAGs2SlaVrffku5K5KkXACC5ILkPGteDOwaihpnzfc=;
 b=fDdlPDXaJO+yEixxwgouzJ7+h35zVGBi7dj5CSIsYWeE6Suu7g6JF1w6+PDYVLesDGDFyoIxY1FqzWlYLuCS0VtzwUAHmrtlcEQY2bbA3CXlToJPk/Rh4qymfJE1N0kaG+MhhQndGcUAoPBYcYBAJ4Tf1e+jBZbvqci1cKG+l0dW6yjNLt/PnHVXz93gM721MUAe/sGFRSsi54qYOM1CXVpk+1exHpNz20VDudp4ixccEYCEZv35Gmd1jzTmOkiUYyI3svLhISLqGdqEZajlPIQclRtcFsext8+g4v1+aBSXFJgr3BZOLocjBHNe7JWSBCGQgM2U+EDFirDvhaWjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvAGs2SlaVrffku5K5KkXACC5ILkPGteDOwaihpnzfc=;
 b=HxuUDTcn2BNdVZBbYs+DxKMjgf3xAqHCbEEXPISbtg0yO/iEBiZGihhQDdGnzY92fG3rRazWGcE30Tk64Z7VsPyGo7R0o7KsRJcp7kgNG0DBRJn6UsSNn4jxjNbDB91dZz/0KglNNC4dPPlV/BgTQyZ51Nxe49J4SS++sJJDKWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Tue, 27 Sep 2022 07:29:44 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c%9]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 07:29:44 +0000
Message-ID: <80efbb83-c6a5-7585-1c16-21832ded522e@amd.com>
Date: Tue, 27 Sep 2022 09:29:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
 <BN7PR12MB261218AAD06042B10065EA56E4559@BN7PR12MB2612.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <BN7PR12MB261218AAD06042B10065EA56E4559@BN7PR12MB2612.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0712.eurprd06.prod.outlook.com
 (2603:10a6:20b:49f::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd80dbb-51d1-4e98-1f62-08daa05a0c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wC3Go8k/mDAI1iKrSZ9ZIW0WLBzCqWTVNrEpNtU0MpcqRncAkz3ZaAWf3BeJhn47a9tredPQHU4n6M0WmEI3lvnOb3XUq/ZdiV9aCrjF2CXR5oNY7wjIKCiTR8xnsoq211JzbeEM2z9v0ZZcMAYWqldAY+snFDmmKQ9oidpHTBkNWn0EBrz1j6nGB2BF9FE1DoThVzJMANY4urWW7T3OVP1mMUkjW++R6rax+BwYMGphTzVP8SkQNtOU24phSuxIAwoYzvGXDXSTmo4DrC53R43vCs5vZcjAB1fLTznZ8mcAiYDrdghMtnwe+Z9bm+GnR5yVQSUbogFCcCZl+aKPp/7wC3QbL8x9YLaijzasUXk6GfxHM6Iw1CZ1KMmUlKY6G1MJx0bbg7aldQH91GCrWSzaEHP+AwmFIzLjoVVT2SOfy2tvrxaRNHgQ170yn2GrFSlN1fHQB77RMrB5Jwr3EoSkLe9caAsSVu6Xo0xpAJcmzx7uFHkA4SbOOKK0obdGKh6qmzwJVCsOmfWGYaJCF3ZXjhXAMVKEEFa0Jd9mvrC4qncDw3y66cFuOj8mQepC5DfYqbdOyYIHX7uroKrzl7AiVpTxyrYqjPS+Xf4RWrX+47mkJpRWvChwmWgTzec/WDz5ujU5alpteVO7m+FOWz50tUEl/ECexgobKObScVfCHjvJVGsbtR0mFLwQcMuyAs7HwcQoNCiFxxv1oLy0CnaM92TqSFKq/edzkc3CllEHl8CfOn//sH4tornGVzItisqh/ITurZc0xKg4/q7Cw25aUlYRQSO5B8Svn8FRVKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199015)(38100700002)(66556008)(66946007)(8676002)(41300700001)(66476007)(6666004)(186003)(2906002)(4326008)(2616005)(83380400001)(5660300002)(8936002)(6506007)(36756003)(53546011)(6512007)(26005)(30864003)(86362001)(31696002)(66899015)(31686004)(6486002)(316002)(54906003)(478600001)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dThVR0J3aU92UFhCVSsvS3I2THJIVlhVa1liTU9Wejd2cXdmL3Y0bFQwQWRs?=
 =?utf-8?B?SmtXc1ZQdXkvdzVSRSs1OE45bG1ESGgvT2FpUndteEo3ZDlOTU1nRUZkZ0hi?=
 =?utf-8?B?bloxVjZ6Wk0xQS9jUFUzSHYvSHhpMWpLa3hYZStjakNGQWJxQ1NxNlFnejdI?=
 =?utf-8?B?MmJsbU9pc3luUTVRYk54Szh5OFFNQUJidFRNa0M0dWxkRHhnbGY4Y2p1T0dB?=
 =?utf-8?B?aVpyWlM1bk5WREFseTk1b1E5YkFVY2xidStqT0NuQ3UvSSthRlk5YUFRMGtm?=
 =?utf-8?B?QnRyNUl2YnFPSHVJYkZPbzI4ajVyVEhYSzdMVkoyRGZ0dWh6WGlCUlJUZ1ZH?=
 =?utf-8?B?UWVlY2V0WG9lNWRCYkVHdENYSTJPNkJOcnFxWVZxVFpJakpIUnl3ZDQyRkZH?=
 =?utf-8?B?aTNiUHBsTWgvdmZVSU5lRnliL3VxbzNrQWJXb25NWVQ5RmNJb1RDVEttSUw0?=
 =?utf-8?B?eDJ4US9aa0FTRFZvVmJKT2xuZUJXNkZOcFFrdGJOa3RkTXBxQWp0YWQvT0NW?=
 =?utf-8?B?Tm5KMXZRL2NSQVg0c2Q5N1k5MENJZkF0ZWhhZHUvMXlrL3RBSDdBSjFlZEli?=
 =?utf-8?B?TTR3dVdNS1RITmZRUlFuejYvUTBrb2FCOTVJdzBzT3M2ZEhyVkVQZklzdlJU?=
 =?utf-8?B?MmNDOFJSOTZPbll3TGwrbTN4TTllSkRudVo2T0xRUnhRNG9wYkl4Z1FEcTB5?=
 =?utf-8?B?Z0VIaXdtb29ra0lRSGhNL25RQTBRcDJnYXh4NnIyekFleHVtRWNZbFRzL3RQ?=
 =?utf-8?B?aFdOd1ZkTDhMZFM5aGJDc3ZqZEl4eXYrTFdhMzd5NCtvY04xK3dKTEZUeGhh?=
 =?utf-8?B?WVdKc1FVYVM5L2RaMW5WM0swRlE1aE56d2xxT0dwYzhBZmZ5SFJaakRnVDZs?=
 =?utf-8?B?YzRmdTNoYUpqYnVYQ1lMZGllNTZwdzhZRFlPUWpWM1RoQUlnUG41Y3NNS3dr?=
 =?utf-8?B?NENSc0FnN0tLb2hmSWEvVU9TNGZON2J4U1VZT2lhU08zb3BNbVdZb0xsd1hn?=
 =?utf-8?B?K3Jua29wWk9HTXBPbmxLcENHQXV3NWpNR3lDQ01rRlF2QWJ4VW9BWWxnamNF?=
 =?utf-8?B?QXBpTVMyeUFJWGt2UE54Vmd5bmdremhsTWp3aVhERldjR1NkMmowTlVITllv?=
 =?utf-8?B?Qnh0SzhJay96WEhRendkOGFVMmJDREFabGkwaEJvVjZUSDNmVzZqN1hGSmZ6?=
 =?utf-8?B?OVJzRCtPOHBuL2ZYZnFvcXY0d2hFZXNiTzN3ckFmSzJKR05kdjZEQmlBVkVP?=
 =?utf-8?B?L21PRTB0Y0ZCOS9vZnNNOWhjcUJDcDVSeDltZld2V2dYRlpSRjl2VGFKbGZU?=
 =?utf-8?B?ZXRhcUFrMVJoS3M2VmI3eUMzLzR6RUF1aGgwcXphd0c1S0hzQXdXSUVsd2wz?=
 =?utf-8?B?QTIzNnQxQ1VKZnZ1NGtDQng5ZVVwS2hGYm5zTW1TRzNseW41d3VvcFR6bUtH?=
 =?utf-8?B?L01LcXpycGJoTDdtV1cxY09HR1ZIRzU5NWVkN0VwSXFHTm1OTWoxMW9wbDdQ?=
 =?utf-8?B?WlpkUEpwNEoxYWJQMkVuMUs0R0poODVvYTN2RlFrWHoxVmNkOC9KQTFhaWxX?=
 =?utf-8?B?Ny80VW9CY0M0cncyNWNWanpyczYxRHAxbFlQcDZZaVBkRjV2QlAramhvRGY2?=
 =?utf-8?B?SDJjcFRoQVhJcG03d0FxdU5SZzFjaldONHVrWUttRjlUNWR2eFg4MXo4czdk?=
 =?utf-8?B?MnF3ckk2TGxvd1I0bUM3c0g0ckF3WDFmSG40UW1FeDNYQlFidzJ0YVRsS1V1?=
 =?utf-8?B?QkVHZXZFMzZ2MXhhRFk4dVJLbjRSTkZJUEZIVlVUTW9OQnIyRG1UWTdqRUhI?=
 =?utf-8?B?YTRrSzRHdWU3aTAvVHdVSklTMWh6b0EwTWFFQzlMRnlHTEgyUjFoc3FFTldN?=
 =?utf-8?B?ZnVqRWxtek5leGpuZ0lIb2E2UDFVa2dKNG15L3BPaGw0dDhGU0tKeTNTY2FU?=
 =?utf-8?B?ekhpZGJVV0plUGYvelI3aWdRS3VuYzRYbkloT3drYi9ZcnRqSXJLUlJqOWps?=
 =?utf-8?B?MlA3QnR0ZHkweVhjR2o3TnBvcm53OFN6dlhhR0Z4YTJmc3JuWGpWdHAxNDcw?=
 =?utf-8?B?Lzd0VEJLckVRZmdqZ1U0UWthcC9aUURzcE5rQ25FeUR0R2lNc0pEOEpDbHhF?=
 =?utf-8?Q?Ce8K8QY9eGz92BklsX8b8tdaL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd80dbb-51d1-4e98-1f62-08daa05a0c1c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 07:29:43.8418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lV0sMvYJlNzxqxJmCZhG9cg9LesNQrBrwO/Wj2xjjvW6lkA/xDAxmdfIzgOaZ3WFjDhU2WLupdH5OEDC9V0jJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Evan,

On 9/27/2022 4:14 AM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Shashank Sharma
>> Sent: Tuesday, September 27, 2022 5:40 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram,
>> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Sharma, Shashank
>> <Shashank.Sharma@amd.com>
>> Subject: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
>> profile
>>
>> This patch adds new functions which will allow a user to
>> change the GPU power profile based a GPU workload hint
>> flag.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97
>> +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>   create mode 100644
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>   create mode 100644
>> drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 5a283d12f8e1..34679c657ecc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>   	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>   	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>   	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o
>> amdgpu_pll.o \
>> -	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>> +	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o
>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>   	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o
>> amdgpu_virt.o \
>>   	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>   	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>> new file mode 100644
>> index 000000000000..a11cf29bc388
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>> @@ -0,0 +1,97 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the
>> "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
>> THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#include <drm/drm.h>
>> +#include "kgd_pp_interface.h"
>> +#include "amdgpu_ctx_workload.h"
>> +
>> +static enum PP_SMC_POWER_PROFILE
>> +amdgpu_workload_to_power_profile(uint32_t hint)
>> +{
>> +	switch (hint) {
>> +	case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>> +	default:
>> +		return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>> +
>> +	case AMDGPU_CTX_WORKLOAD_HINT_3D:
>> +		return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>> +	case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>> +		return PP_SMC_POWER_PROFILE_VIDEO;
>> +	case AMDGPU_CTX_WORKLOAD_HINT_VR:
>> +		return PP_SMC_POWER_PROFILE_VR;
>> +	case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>> +		return PP_SMC_POWER_PROFILE_COMPUTE;
>> +	}
>> +}
>> +
>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>> +				uint32_t hint)
>> +{
>> +	int ret = 0;
>> +	enum PP_SMC_POWER_PROFILE profile =
>> +			amdgpu_workload_to_power_profile(hint);
>> +
>> +	if (adev->pm.workload_mode == hint)
>> +		return 0;
>> +
>> +	mutex_lock(&adev->pm.smu_workload_lock);
>> +
>> +	if (adev->pm.workload_mode == hint)
>> +		goto unlock;
> [Quan, Evan] This seems redundant with code above. I saw you dropped this in Patch4.
> But I kind of feel this should be the one which needs to be kept.

Yes, this shuffle happened during the rebase-testing of V3, will update 
this.

>> +
>> +	ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>> +	if (!ret)
>> +		adev->pm.workload_mode = hint;
>> +	atomic_inc(&adev->pm.workload_switch_ref);
>> +
>> +unlock:
>> +	mutex_unlock(&adev->pm.smu_workload_lock);
>> +	return ret;
>> +}
>> +
>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>> +				  uint32_t hint)
>> +{
>> +	int ret = 0;
>> +	enum PP_SMC_POWER_PROFILE profile =
>> +			amdgpu_workload_to_power_profile(hint);
>> +
>> +	if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>> +		return 0;
>> +
>> +	/* Do not reset GPU power profile if another reset is coming */
>> +	if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>> +		return 0;
>> +
>> +	mutex_lock(&adev->pm.smu_workload_lock);
>> +
>> +	if (adev->pm.workload_mode != hint)
>> +		goto unlock;
>> +
>> +	ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>> +	if (!ret)
>> +		adev->pm.workload_mode =
>> AMDGPU_CTX_WORKLOAD_HINT_NONE;
>> +
>> +unlock:
>> +	mutex_unlock(&adev->pm.smu_workload_lock);
>> +	return ret;
>> +}
> [Quan, Evan] Instead of setting to AMDGPU_CTX_WORKLOAD_HINT_NONE, better to reset it back to original workload profile mode.
> That can make it compatible with existing sysfs interface which has similar functionality for setting workload profile mode.

This API is specifically written to remove any workload profile applied, 
hense named as "clear_workload_profile" and the intention is reset. As 
you can see in the next patch, the work profile is being set from the 
job_run and reset again once the job execution is done.

If there is another set() in progress, the reference counter takes care 
of that. So I would like to keep it this way.

- Shashank

> /**
>   * DOC: pp_power_profile_mode
>   *
>   * The amdgpu driver provides a sysfs API for adjusting the heuristics
>   * related to switching between power levels in a power state.  The file
>   * pp_power_profile_mode is used for this.
>   *
>   * Reading this file outputs a list of all of the predefined power profiles
>   * and the relevant heuristics settings for that profile.
>   *
>   * To select a profile or create a custom profile, first select manual using
>   * power_dpm_force_performance_level.  Writing the number of a predefined
>   * profile to pp_power_profile_mode will enable those heuristics.  To
>   * create a custom set of heuristics, write a string of numbers to the file
>   * starting with the number of the custom profile along with a setting
>   * for each heuristic parameter.  Due to differences across asic families
>   * the heuristic parameters vary from family to family.
>   *
>   */
> 
> BR
> Evan
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index be7aff2d4a57..1f0f64662c04 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device
>> *adev,
>>   	mutex_init(&adev->psp.mutex);
>>   	mutex_init(&adev->notifier_lock);
>>   	mutex_init(&adev->pm.stable_pstate_ctx_lock);
>> +	mutex_init(&adev->pm.smu_workload_lock);
>>   	mutex_init(&adev->benchmark_mutex);
>>
>>   	amdgpu_device_init_apu_flags(adev);
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>> new file mode 100644
>> index 000000000000..6060fc53c3b0
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>> @@ -0,0 +1,54 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the
>> "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
>> THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#ifndef _AMDGPU_CTX_WL_H_
>> +#define _AMDGPU_CTX_WL_H_
>> +#include <drm/amdgpu_drm.h>
>> +#include "amdgpu.h"
>> +
>> +/* Workload mode names */
>> +static const char * const amdgpu_workload_mode_name[] = {
>> +	"None",
>> +	"3D",
>> +	"Video",
>> +	"VR",
>> +	"Compute",
>> +	"Unknown",
>> +};
>> +
>> +static inline const
>> +char *amdgpu_workload_profile_name(uint32_t profile)
>> +{
>> +	if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>> +		profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>> +		return
>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile
>> )];
>> +
>> +	return
>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>> +}
>> +
>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>> +				uint32_t hint);
>> +
>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>> +				uint32_t hint);
>> +
>> +#endif
>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> index 65624d091ed2..565131f789d0 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>   	struct mutex            stable_pstate_ctx_lock;
>>   	struct amdgpu_ctx       *stable_pstate_ctx;
>>
>> +	/* SMU workload mode */
>> +	struct mutex smu_workload_lock;
>> +	uint32_t workload_mode;
>> +	atomic_t workload_switch_ref;
>> +
>>   	struct config_table_setting config_table;
>>   	/* runtime mode */
>>   	enum amdgpu_runpm_mode rpm_mode;
>> --
>> 2.34.1
