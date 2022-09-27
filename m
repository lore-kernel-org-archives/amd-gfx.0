Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1581C07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 11:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFFF110E2DA;
	Tue, 27 Sep 2022 11:41:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6F510E2DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 11:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDi/qpfrEGYhvKl36lngbz+/gstqjAGykl1SbTyfkCH+PMz9jyj19H72DdXlK6tIFv8s/1YmSZgoRyMKEhsrmnsb3iJ+S87jyoSI3Pu/eb1ACH38KOyg0yzJJPh1nyDPLnKmTIq/OlDyH3vzqy8xSUuqhMaQ1AV7KF6xh96QYIOPDteyvMT1JE+gtIKTCZs3u3LelZo905us3YMTOgsTW0d6wU4bX2ri1/aCraL+r1CogP5dezIX74X6eHx+XQxWy48pdoHmeP4rvU7hwlS11Tvu3CKQvXa0CwwF0UxjGMY+lJMhQKLxhS7uaMQlysL+jSMqZmeT09Dqo+t0NgEc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZenRZNkMOzaGOHqi9j4V+6s4ci0vLNFS08eKPvgBu3g=;
 b=QG0s1/QHmSu3rSyFqVE1biCjnEC6t8B2qvO0xxe3p9vQuPz9WJtCP1pf4pH4PakHUq7tIcIFk6LT4Zo7ZaoAWkHH9Dbk2weJW8YwJy5aML+Rx3FhVF8YGLySD7OlAD6D5f1YL5QQwt7YqUUt34S1KE8aki5j7cYT9Ikcaww5ir2GqG3+a+CLPAwSrX7BYzJ1Nu13jYO7z8f9H0IkS8UhTo6RXjCA6jGWYaUDSxSpDg1EjELhPgUZY1DMH0l2vM5zoTJL72bAhO7t8jOZ4uSvWyX15cDnFjz9aAd2P4qr+DpkhDROjIWQM7IG2su7AyqAjHWvXnoCZtgtcSuRflZvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZenRZNkMOzaGOHqi9j4V+6s4ci0vLNFS08eKPvgBu3g=;
 b=mhCHJyM9qFurZTYTzjmyrvSw4aMbQILB1362PXmOIiFe2oGBT+lyQMxIbGKgMFM5qedZxmtV9X0l9KsmVuRA0IVmArjhJ9tJzamp442qLDxh2ZkWDZJYK4X2iUrsKe4V1Mjbi2F3w87NU0843ThFNpkTaRccFRHXBjjtxUBlv/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 11:41:33 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c%9]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 11:41:32 +0000
Message-ID: <ff4e61f2-f361-83c2-0bf4-443989e01ada@amd.com>
Date: Tue, 27 Sep 2022 13:41:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
 <29782362-ca83-9174-c289-1ef973b8e736@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <29782362-ca83-9174-c289-1ef973b8e736@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM7PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::17) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: dc00ac04-2260-4520-706c-08daa07d398c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcrqShqcWE99vPBbZNe3zeukdRJT8+fHsQOzpcdmpEHGSUww+DNwj2940GXMP2Y8jufM0wIvBv9/LGW8LYUjGcalHFk9C+mIJ2nMLt2rX1vDbxlUWEWUKgUoKn2sBmIBbuZ9vdVtZPsi5lEj12oj6yIWJ4kRcccsvY6DIEhu4kVMz/ITQERif2FtPjbv9BN7fiAOROv+peu92u/2f4pFLSLOSRKf/0YgicwAl10MMNlBVYqedyC20YW9chjWrX0gLHFeJAbp5JOj4Y/531AXpvtyBpjGbFPivomMQTyCbw9bCEnVV2Pu4bigZBX4juXwKyD+NQqZZ+k47rRw0l+tskhCHTZ43SXzM33eHDP2TIGpXGeK6+kQq4MkuwZbwE2CqVnH6G3Q+Kdgt2fygZK2RnZUmv+uLtOAE/V/OFLenki7yoANmOlB4s6E1tuc+dBvMSQywVbCWCY+jAsaAZRyNxT3M246NYgkBJp9rHAGtTIG8fd03eWKlMKjt9QJEbsf44ttMwJtbrM/xKh5XxfoeKvVStk+FRVwgbt7g/6MgmUuAo5T53iEnOOwaraAGSXXoFDoRJILKFXGj75hUx64Lc+O1uI+Gvh6Tkxnqqb0d85WOtB96aHcSMfrd2InEf56rwqorIvclhiaqqQOJrJ/xNH5wMC3NLnEBPwAIziGVSCKb821OZ0Ygk0httNctwfjOUWtq3y8+77kH5qChbQi0zlEc9WnpJVpqoUehojN2zXj5TYLui+dzmhDK1BF48B2BXkXROCMwGRoMeUnALoh42InpI24Ge66wBCbkRyeLGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199015)(5660300002)(478600001)(6512007)(66556008)(6486002)(26005)(66476007)(8936002)(36756003)(38100700002)(53546011)(6666004)(83380400001)(66946007)(41300700001)(6506007)(316002)(8676002)(31696002)(2616005)(4326008)(186003)(66899015)(86362001)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01RQWNQTVVXYWpWdGNxNGFaemZ2NEdEY3BBc0ZJQWlWRHNmcVJwbFdCRngr?=
 =?utf-8?B?NVc5WmtneElSSDhoT1MxYTR2WGNkM0VKeTZYbnNyOWJiR3JoVTFtdEFiN1JT?=
 =?utf-8?B?L3VXcERKakhxWUVLMTY4c2FCbCt5dk0yc0lQRXFFT2RtZENIK1FtZDlGODkv?=
 =?utf-8?B?ZVB0cHU0Zyt0bS8yRmgwbHFHRm1nYTlxTDlDUzZCZjUxQlVYZS9sM3FMdkJH?=
 =?utf-8?B?a3Q4dWhzUGZuYWNaSlZOZXNFS2cvb1YxMWYzSE9uYjQ2VTVwVkd4bm50Qlp6?=
 =?utf-8?B?ZEdzNUwySFdpQld6aWY2eS9SOWx3WmRtdkZrSmFEdWpRRG5IZ0JiWDFIU0Qx?=
 =?utf-8?B?UjhidGVJS1Q5V2ltQW9kSHBNQ2NQMnduWDhFbmNFL2pPVFNhbzJ0MENTdEV1?=
 =?utf-8?B?a0l6RG5WU25CSDgyRkdHZExuMzd3Y2dlVU03bkhpNGQrV1V1VTJNcnREc0VT?=
 =?utf-8?B?UGpEdlkxaWN0dHF6MWhrWlpxcTNDODRuanZ1NlA4V3gyL3ZkYjNSUzVlZHA5?=
 =?utf-8?B?NnVGRlpTZjFuemtiaTBsbVplWURnZDkrTjdHUXpTck1SWEF3WDBQOGgrVUlL?=
 =?utf-8?B?WWN4NG53ZDNwS0ZSRU01dll4NXIyaFI5ODdlSlFMZ2Nhbit4Uk94N0hUUTRx?=
 =?utf-8?B?Y2pEVlhRYkIyVmtOZ1JnVG1sY0lqejlQM2hjeEl2TEVoMGNHd3lXMStXWTRa?=
 =?utf-8?B?S2Uya21Vd1FNOVk5ZXVDK21xZnQyK2xCTGdVV002RURMbHE0dGNzSUJxTUNF?=
 =?utf-8?B?VjkwSVRudm5EL3VYU3NDdnM5Nk9zb1htQlFVWjNDeFZldDlwSFVsc1VRK2dY?=
 =?utf-8?B?cE5RSVpOb1dLNlFWbGg2Wmt0WGl5YkxvUE9ueVkvcS9BdUlVRWtBWHRDaG5V?=
 =?utf-8?B?U04wOHNaZkhJZXFmbHd0V3c4bk1RcHJvNFpsQTIvRnE2eFBOVnZQY250VXdV?=
 =?utf-8?B?QnJ6STRkYzd2T3J4Vmdqb2pEY1J1THNmc2dLZDhJTzlkdUFnQTM4eXRucGls?=
 =?utf-8?B?NUdhUEluY2tXa2lCN05IcUNnZXVVUmU0MlpEYVpIWkc5d3Bmbmo0ay9ObUJl?=
 =?utf-8?B?ZFRycnRwOW10ZCthOThnVHV4SCtVdFI5M0VrTEQwWXhValBPVGZkZ3NKakNl?=
 =?utf-8?B?NGNCOFdvWFVFdFVPQ0lpZ251OWd6cG5ONDYwTWc0SGdqRnRmNS9tem1tbU45?=
 =?utf-8?B?K1l1WndrWnkwQ1RjL1IrOWduVWhFdnpxdm03aWFmRlpTWlduT2w3Vi9xL3NJ?=
 =?utf-8?B?Y0U1TTRteE4xdWRaMTFMcCtFTEJDczV2T0hrUEpZS0NjcUVsSDZsZmhJOTZE?=
 =?utf-8?B?OGNadGx2MUtEc2lldDNLUmhrSnlNT00ranJFQVhnN21lVlIvRlNMSFZCcVd1?=
 =?utf-8?B?c1M2OVQxbU42ZUdpVUlXZWJOQlBYSitTVlhyVjhXbmZFbHd6bjZINzd4Yk1Q?=
 =?utf-8?B?cENkeEZMSU5XZE40M2g3a3NTcWNvMzMyQXQ3WERGQnhPQVRjdUxuY1lPOGM0?=
 =?utf-8?B?Q3krNGFzTnlzbXM5aEdZVFh4Yk9LY0prQzdocVlxaUZ0ZnBFdTdTeUsrTkVB?=
 =?utf-8?B?QWZIbzFaVkhiY2RQSjAwTFlMcEwrNTVoMVNwNHVhZm9oalZJRkRmVXhVeHJR?=
 =?utf-8?B?dHhzbkc4OGs5TmpsM3BnTjg0TWFFZmNPdEZidTdGRk9iTHZJMlhMMzVQcG9o?=
 =?utf-8?B?dGQ3alIwRXNoNmIxdEt2L3Bubk1xS2NDVFAvVTh5NXRaL1FFTFRBUTgxUTZl?=
 =?utf-8?B?Q2dueUlxdGYxb0xsVzh2anhlRjdNcjJmSGxBU3FXd2JhTk45MzFGRzNackFa?=
 =?utf-8?B?K3pCVEhKQlF2WVBXMVFFOTZvMERqMllTVkRXaDd6cXQ3bklFK1FCSWFzNUVO?=
 =?utf-8?B?VHBmWDZMZSs0bEJlajNTRldtZ3pYb2hOQzlKK1NkVDJ1SS8vU2VCWEF2RW1i?=
 =?utf-8?B?OVlkRjhvS3BGV1AyM3Z5N25Zd0RxdHZLVjJwcEFaQ1RsQ09SMityNDBmOURs?=
 =?utf-8?B?dkcyWTMyNzZDeTFtQ0cydWp1MVY3dlRNclY1TXFKUCtWNXV6eFUwQUtLbFUy?=
 =?utf-8?B?TmQ0MC8rdmRrMWNFaldDaHU2dzhYTDNuYkpTaU5OQ0ZvNkdsdzFoV3Y5dVk0?=
 =?utf-8?Q?je21h74HO8sHMVKzS86HAn5iT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc00ac04-2260-4520-706c-08daa07d398c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 11:41:32.7894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: st3kTdDXVpT10ABQgz9eOHxHeUGT9+0fWWeGoAv9sV7o+KTbwYrNYp6I4eX6lgR5CCXGVm+hjlAZ1m7iGl6wVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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



On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
> 
> 
> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>> This patch adds new functions which will allow a user to
>> change the GPU power profile based a GPU workload hint
>> flag.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 5a283d12f8e1..34679c657ecc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>> amdgpu_pll.o \
>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>> amdgpu_virt.o \
>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
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
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
>> SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
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
>> +    switch (hint) {
>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>> +    default:
>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>> +
>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>> +        return PP_SMC_POWER_PROFILE_VR;
>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>> +    }
>> +}
>> +
>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>> +                uint32_t hint)
>> +{
>> +    int ret = 0;
>> +    enum PP_SMC_POWER_PROFILE profile =
>> +            amdgpu_workload_to_power_profile(hint);
>> +
>> +    if (adev->pm.workload_mode == hint)
>> +        return 0;
>> +
>> +    mutex_lock(&adev->pm.smu_workload_lock);
> 
> If it's all about pm subsystem variable accesses, this API should rather 
> be inside amd/pm subsystem. No need to expose the variable outside pm 
> subsytem. Also currently all amdgpu_dpm* calls are protected under one 
> mutex. Then this extra lock won't be needed.
> 

This is tricky, this is not all about PM subsystem. Note that the job 
management and scheduling is handled into amdgpu_ctx, so the workload 
hint is set in context_management API. The API is consumed when the job 
is actually run from amdgpu_run() layer. So its a joint interface 
between context and PM.

>> +
>> +    if (adev->pm.workload_mode == hint)
>> +        goto unlock;
>> +
>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>> +    if (!ret)
>> +        adev->pm.workload_mode = hint;
>> +    atomic_inc(&adev->pm.workload_switch_ref);
> 
> Why is this reference kept? The swtiching happens inside a lock and 
> there is already a check not to switch if the hint matches with current 
> workload.
> 

This reference is kept so that we would not reset the PM mode to DEFAULT 
when some other context has switched the PP mode. If you see the 4th 
patch, the PM mode will be changed when the job in that context is run, 
and a pm_reset function will be scheduled when the job is done. But in 
between if another job from another context has changed the PM mode, the 
refrence count will prevent us from resetting the PM mode.

- Shashank

> Thanks,
> Lijo
> 
>> +
>> +unlock:
>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>> +    return ret;
>> +}
>> +
>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>> +                  uint32_t hint)
>> +{
>> +    int ret = 0;
>> +    enum PP_SMC_POWER_PROFILE profile =
>> +            amdgpu_workload_to_power_profile(hint);
>> +
>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>> +        return 0;
>> +
>> +    /* Do not reset GPU power profile if another reset is coming */
>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>> +        return 0;
>> +
>> +    mutex_lock(&adev->pm.smu_workload_lock);
>> +
>> +    if (adev->pm.workload_mode != hint)
>> +        goto unlock;
>> +
>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>> +    if (!ret)
>> +        adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>> +
>> +unlock:
>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>> +    return ret;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index be7aff2d4a57..1f0f64662c04 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>       mutex_init(&adev->psp.mutex);
>>       mutex_init(&adev->notifier_lock);
>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>> +    mutex_init(&adev->pm.smu_workload_lock);
>>       mutex_init(&adev->benchmark_mutex);
>>       amdgpu_device_init_apu_flags(adev);
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
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
>> SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
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
>> +    "None",
>> +    "3D",
>> +    "Video",
>> +    "VR",
>> +    "Compute",
>> +    "Unknown",
>> +};
>> +
>> +static inline const
>> +char *amdgpu_workload_profile_name(uint32_t profile)
>> +{
>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>> +        return 
>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>> +
>> +    return amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>> +}
>> +
>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>> +                uint32_t hint);
>> +
>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>> +                uint32_t hint);
>> +
>> +#endif
>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> index 65624d091ed2..565131f789d0 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>       struct mutex            stable_pstate_ctx_lock;
>>       struct amdgpu_ctx       *stable_pstate_ctx;
>> +    /* SMU workload mode */
>> +    struct mutex smu_workload_lock;
>> +    uint32_t workload_mode;
>> +    atomic_t workload_switch_ref;
>> +
>>       struct config_table_setting config_table;
>>       /* runtime mode */
>>       enum amdgpu_runpm_mode rpm_mode;
>>
