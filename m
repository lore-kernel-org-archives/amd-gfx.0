Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7102EC44524
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 03:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD87710E41E;
	Thu, 23 Jul 2026 03:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mnsaiE0g";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8EB710E41E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 03:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB9k1iikPv3dbwX4UiKHR0zhmpXIm63GIfCSehzVfvqgbfZhAPcHBXl9SuVqUUfBujj9G1DLNYytDw9FX0GXAaAXVqBEvt4PSoHXjRq1A0/j5O+GUrJWCdUqfFocSHXJJhdjRJBupA7ELh1o3FS6BTgdiT/nhjp9Wm5jkNQXvuBjfAqcfKjEjO6OYTTT0TuZ3x5oB/SKiZRezDe+2h6i/KQJmyng4u0FgywYcQl9TMpDRwvC1UvL/7fXxZWsC4+ygBgHaY9bHWQBqMGg+t192ExVh9qCVZA7elYg+Umsrhzrrir4oBmt01EPxjY4UWP877mCz+NMQ6Ro5b/05cftGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drZlHRwctMb4MkDvzca6a/IcXTRydGRwY8dWLKQgOgQ=;
 b=oo+oV3oDTiKRpbcI3PP/2Foj4VPyYhjH5CpBFt5D28fUC4AduP74j77pQXqt/mtCiAsr4BpDriq1UeRsLOtVcWDs6rKMbJw3ugENr4Q7Fip4V+LEIsMOMGbQ80mnwQ+Nf40/082icwE7bsFx7rLrTHbNEWbob+V4CKnIWpsPBJ/goFJiwTh0aRCr7PcEIxCVwmCag9hkk+8Ycw4ox7Sq0EcfA3A6eOw8NkwehxHkS2JUJdWWSKv/uozEZdm+5sQ8Lyw6YvUI5pFCOetAIbBeU+0m7KEze/Ker36yKuOsdc6ih2c5JCw42ZGIIttWSidHQblGmNaHRTtPc0rme+KWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drZlHRwctMb4MkDvzca6a/IcXTRydGRwY8dWLKQgOgQ=;
 b=mnsaiE0gDYcQT06F9ApcdOp6IjPjK3LlXqqO9a6ZbWpDuT5ydS1a5wKbjewgj35kobHIYcue96nNOR9sFQpEvhEc6BqhNvROjp66r+SdkwWLWz284UY62MJcrtNX39plNE+22u3W84PWMV6hbLpHiAW911v9xtEZhoA62z1KeNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 03:46:11 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 03:46:11 +0000
Message-ID: <34f0850c-3fa9-440d-b7b8-0872130c3f9e@amd.com>
Date: Thu, 23 Jul 2026 09:16:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: restore perf state after runtime resume
To: "Li, Candice" <Candice.Li@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260722103619.2737329-1-candice.li@amd.com>
 <EAYPR12MB9991584ED579327E914EB32293FCC12@EAYPR12MB999158.namprd12.prod.outlook.com>
 <0de168fb-a9b8-43ce-a85b-a31033478f15@amd.com>
 <IA1PR12MB76619586987E439C743631D591C02@IA1PR12MB7661.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <IA1PR12MB76619586987E439C743631D591C02@IA1PR12MB7661.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0108.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: a119d63f-9587-49e8-3b44-08dee86cefa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3CIXb806ute63aycoRzyY6pLjVL3uPkLxWslwPe7BHt7g5QEUKXxhIDM5F/BUc3cx6Hyh1PmXItEgi3wrFF1nSrT92E7vurQVy4wRDctSfHSLvdo06vCgOjM5wV7/nXK2YNVCZ7R9Rp6SQ/pND2AliRNO8UTN4Bhr0TdsPfYftk5pBcDIyatU4M8pWH9Rw11o1PiD7GOR4+JOCagtNF/y/hHnbiaZn/cs0SAYgiTkd0RW5PkIPyTsJo3MNMlwfhzJiiDC+Ch1RDMXoYmnf4CSHk5DE2827z7mOxAsXXPtFxJX3b97QW6iU8OVAgkjKVKhIf0Ky1GpY2/hMb5VBBR4pOENfG0p5c4JtOUC1PzgqirraugM9A1WeCl2dZ02ve50ptg/z9FS9yQIuIj2qEQn7o1gMIWpSByUEvdqMzkZLlZoHx3jde5qtlC7dADQNFYLfH1J55b+pTvEbfAHCOmwxkAWSNczEB0E+6TK/QpFhJpv+zPHtfqaCgrykvxmApGxX1tVjk007JyJr8VObi9uLLJItE52EKMDKjUE4EkmxTrkI3eEDRQ9BzDnwxtlA6y52smqggCzrEj8Fsg7jOezQwFM6LhXuL2z6Y9XXqq+mz/lvDkYSRQ4OP+wDmDPttr0wUuJym3QQfawgjqIm+PFyCurip1dMaR2Af0vxsAsBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVhUbTJUdVNKeUxVNFZpMDZqaExRNDhzRWRYb2lSMUZ5QnRKT0RYenBSd0kr?=
 =?utf-8?B?dGt0MUZoWFBXTC8zd2JLQUlxcU5IRmhYanZkeThKdWZEeklxKzNtSWJseTBC?=
 =?utf-8?B?RmdnRCt2cHdyRFZxRkhjUEZSTlJNRUxVeVBicENKR2l4YTFlU24vTGtTcU9p?=
 =?utf-8?B?b1lWaVFZcURQTmdxYnU4MFFGenlBc0JudW55Y1hoRk4yc1RFVXRmVmZHTHZT?=
 =?utf-8?B?K1hnSzY4WVJMY0JNbDMzcWwySHRPZExuMzNhcXdUUUlHbXg5Z2FsMHg0ZW1V?=
 =?utf-8?B?SUd4Y0E4dnFRU0RKVzVHUWtFMGQ2RWtnQkx1S080Smxldks0aythbDBjWjVy?=
 =?utf-8?B?RjZtQW1KR0Jlbm8wNUVuQVRnc205aU15dURJaVE0Umhzd0djUWZGNEMvNExF?=
 =?utf-8?B?R0dOdWVZb0ZDVGxET1RFRXdHUGtuVWhkUzVxK01TWXR4ZG1YZ2ZBWTF5d3Ja?=
 =?utf-8?B?Z2xSYmFaUzA1Rk1QQnp3NUxFdS9BRG03RkEzWG9TY1l3RmZJZDJLbFBpUU9T?=
 =?utf-8?B?bDhIczFuVC8yWVJpalQ3aS9WK2ZxWGhyT0dxcFhodkp2MSsyL083K3VjMHVv?=
 =?utf-8?B?SFcwKzZvaktKV3hKZUFLcnBJdndRWXcrN0NoWHFVQkRrM3poS3drdFBnUkwx?=
 =?utf-8?B?MXJrTkEveEVIZWNsQ0lONHlGUTlmY0ZRWEZ2ZWVOZTBkT0oycXBPTUkwVE5T?=
 =?utf-8?B?M0xBTlhFaHYxRDBXakJyYjI2b2Jqb0RRQ3l2d2xSclZ1eG51a2FmWTkvMjlH?=
 =?utf-8?B?VloxckRxM1hIQ2JQcjV5SW5pVlJsUWNoUFJ1RmhSRGJZdU8wTzhTNU90ZTkx?=
 =?utf-8?B?bE8rSGxEMVJVUTJqOEsxbVBUbHM5ZmRjT3UwVU1tejBHWWJDaEtncTRSM1hS?=
 =?utf-8?B?ajVCZ1JnQlk0cVJtc3pTaGdGWGQwaGlrS3poY3VhVkVaNFk0cnZhWTNFOURV?=
 =?utf-8?B?NWFMUzBNYUx6QXh0REpwTE5xRHpWeE56OEpISHYrV2VST3lOQUpjZEZkanBG?=
 =?utf-8?B?aGtpbFdYRmxJVnNuUmkyNHJSM0t0TmtXWDdGT0pLaW5ldkY3bDlVRm1HeFJT?=
 =?utf-8?B?ekZ2cU1QZ2RGV09lL0RxK0hwZ2lNWW8yZk52V0cwOHJ5anZia2ZubmZYRVVl?=
 =?utf-8?B?USsrMjg5NjJ3S1c4QllkM0tyOTNQL3h0eDBSalpjamJvRFFzaGJ2S0FjUDIy?=
 =?utf-8?B?L2M5YmlIYU04VEhEZnhXdFYvcjQ0cGJGUUgzb1BPZ1ZyMnB6ZlJLcGZaNUNJ?=
 =?utf-8?B?VjNmczc5YXdENDI4S2pZcnYra1MzSFUxeGpiUXU0dVY5a01kYWRDNUdnOGN1?=
 =?utf-8?B?WEROMms0Q1F6OTd4d1l1cjg0RDltQks2ZW5jcml5NUpzTS9FUUgzUGxaVmJG?=
 =?utf-8?B?bzBOelJSWGxsQ1ZuU3RTMWdsTFdJRU9yVVVBamFXMGgremFlY2h3K0tUOFMx?=
 =?utf-8?B?TmNJUXFxU0o1TFNvM3JkOExCb2ZMc0RKcmVEOUxEWW1MZjZwUDNjTXdvTDI0?=
 =?utf-8?B?eUxQL2lwUHkyMVcrYkZ5dEJydnExZWIvYVh2blR4Mi9vTlBOSU1aY3M0SWhj?=
 =?utf-8?B?amFxVlIzdk1NMUZyZVRTR3FTSnlmK1hocCt0dmNETEcxam9NL3ZIOFZDNkg2?=
 =?utf-8?B?RXBvbkt1UWJWTXB0dUdWdU5mbUlLMklrMllUa252SnowVC9JMVFuWllGc09P?=
 =?utf-8?B?VWlYeTIzd083WkJWVTZVRDlTcXBrVm8yMktKWUJmZFpqKzg4a2djblpKNDVL?=
 =?utf-8?B?UkUvcVZTOXcxdmo1UDBOelFTalJKeDlXWk9CV3gwSldnQmVrWnV1ODRiWGFs?=
 =?utf-8?B?cG1XVHkwNTZWWFVaTFhtNGRUeGI3Q1lVbnhEc3E3MWRkYlNmN3ExVDh5NUxC?=
 =?utf-8?B?RXRiTXIxTlZmeVZ4Nm1aWEdUc0l6a2doNW1SN3NkZ1MzM1R2S3Ewc0Uzc3Mw?=
 =?utf-8?B?UUxIUHZUZnR6UStSSkNkbWxyc25xWkVuc0grekxRMDlyZ2dJbk1VRE5xVnRq?=
 =?utf-8?B?UDZxRnQ3ZnZ3ektZL25ZUFI0N0FSeUpoUisva0RFcmczaVBhWEpvc0tnVFFx?=
 =?utf-8?B?SnNuZXZmZHdncVBIeC9SQlhsVzZnV08wdGJwM1BwdVMwbWQyd1hSbW9jVEFh?=
 =?utf-8?B?SUw4YkNIYVhudHIxWXU1cm8wMDJvRG1hdkNyaDMwRUcyU3NiVGtFMDY1LzVB?=
 =?utf-8?B?L09kZjVkQzNDRXRTUCtYZGM2OU80TW1QdEx3OERzS2tRMlI4VVNQN1lXV0V6?=
 =?utf-8?B?eW42QXBWWXRkRkFDeE5tZGREU2VXTklWRU5Ra0ZhK3h5MXhOMlJRQlFpd1Z0?=
 =?utf-8?B?eXdsWFBhRlRleWlMNTlJeUxPRS9RTEoxZndiSXRyOXFJc0N4STVWQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a119d63f-9587-49e8-3b44-08dee86cefa5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 03:46:10.9462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egi4u2r78eymrkdl8a1Dh1FuBv4O9yzsauECS0MBO2JSghiOkTRlw5hsF5uqb4nO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838
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



On 23-Jul-26 9:00 AM, Li, Candice wrote:
> AMD General
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, July 22, 2026 8:11 PM
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: restore perf state after runtime resume
> 
> 
> 
> On 22-Jul-26 4:43 PM, Zhang, Hawking wrote:
>> AMD General
>>
>> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>>
>> Regards,
>> Hawking
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice Li
>> Sent: Wednesday, July 22, 2026 6:36 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Li, Candice <Candice.Li@amd.com>
>> Subject: [PATCH] drm/amdgpu: restore perf state after runtime resume
>>
>> Runtime suspend runs GFX hw_fini and clears perfmon clock gating while KFD keeps running, so block perf counters read zero after resume even though profiling remains enabled in software.
>>
>> Re-apply UMD stable pstate for profile DPM modes and re-enable KFD perfcount after a successful runtime resume.
>>
>> Signed-off-by: Candice Li <candice.li@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 46 ++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 17 ++++++++
>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  8 ++++
>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  1 +
>>    6 files changed, 75 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 121282dd30c161..38974beb98ef88 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -38,6 +38,7 @@
>>    #include "amdgpu_reset.h"
>>    #if IS_ENABLED(CONFIG_HSA_AMD)
>>    #include "kfd_priv.h"
>> +#include "kfd_device_queue_manager.h"
>>    #endif
>>
>>    /* Total memory size in system memory and all GPU VRAM. Used to @@ -280,6 +281,51 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc)
>>           return r;
>>    }
>>
>> +void amdgpu_amdkfd_restore_profiler_after_runpm(struct amdgpu_device
>> +*adev) { #if IS_ENABLED(CONFIG_HSA_AMD)
>> +       struct kfd_dev *kfd;
>> +       struct kfd_process *p;
>> +       struct kfd_process_device *pdd;
>> +       struct device_queue_manager *dqm;
>> +       int i;
>> +
>> +       if (!adev->kfd.dev || !adev->kfd.init_complete)
>> +               return;
>> +
>> +       kfd = adev->kfd.dev;
>> +
>> +       mutex_lock(&kfd->profiler_lock);
>> +       p = kfd->profiler_process;
>> +       if (!p || !kfd->profiler_perfcount_enabled) {
>> +               mutex_unlock(&kfd->profiler_lock);
>> +               return;
>> +       }
>> +       mutex_unlock(&kfd->profiler_lock);
>> +
>> +       mutex_lock(&p->mutex);
>> +
>> +       mutex_lock(&kfd->profiler_lock);
>> +       if (kfd->profiler_process != p || !kfd->profiler_perfcount_enabled) {
>> +               mutex_unlock(&kfd->profiler_lock);
>> +               mutex_unlock(&p->mutex);
>> +               return;
>> +       }
>> +       mutex_unlock(&kfd->profiler_lock);
>> +
>> +       for (i = 0; i < p->n_pdds; i++) {
>> +               pdd = p->pdds[i];
>> +               if (!pdd || !pdd->dev || pdd->dev->kfd != kfd)
>> +                       continue;
>> +
>> +               dqm = pdd->dev->dqm;
>> +               if (dqm && dqm->ops.set_perfcount)
>> +                       dqm->ops.set_perfcount(dqm, 1);
>> +       }
>> +       mutex_unlock(&p->mutex);
>> +#endif
>> +}
>> +
>>    void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev)  {
>>           if (adev->kfd.dev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 338412a750edf0..1be9d5ef97d6d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -164,6 +164,7 @@ void amdgpu_amdkfd_teardown_processes(struct amdgpu_device *adev);
>>
>>    void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc);  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc);
>> +void amdgpu_amdkfd_restore_profiler_after_runpm(struct amdgpu_device
>> +*adev);
>>    void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev);  int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev);  void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 5362705143bc75..f7a1064c340692 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2920,6 +2920,21 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>           return 0;
>>    }
>>
>> +static void amdgpu_restore_perf_state_after_runpm(struct amdgpu_device
>> +*adev) {
>> +       enum amd_dpm_forced_level level;
>> +       uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
>> +               AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
>> +               AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
>> +               AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
>> +
>> +       level = amdgpu_dpm_get_performance_level(adev);
>> +       if (level & profile_mode_mask)
>> +               amdgpu_asic_update_umd_stable_pstate(adev, true);
> 
> This is supposed to be called before entering the force dpm level mode.
> It's better to move this logic inside swsmu late_init before reapplying
> the level.
> 
> Thanks,
> Lijo
> 
> Thanks, Lijo.
> 
> I think this logic should remain in runtime resume. The amdgpu_asic_update_umd_stable_pstate(adev, true) call here is a restore/re-apply step for an already-selected profile forced level, not a force-level entry.
> Enter/exit behavior is already covered by the regular DPM force path (amdgpu_dpm_force_performance_level() / SMU force handling) when level transitions occur.
> 
> During runpm suspend/resume, the software forced level can remain profile mode, but HW-side stable pstate (and KFD profiler state) may be cleared by hw_fini/hw_init.
> That is why this restore is done after amdgpu_device_resume().
> 
> Moving this into swsmu late_init would apply the logic to broader flows (not only runpm), so I’d prefer to keep it in runpm resume.
> 


Profile setting is a user level setting and it's not the default SOC 
behavior. During runtime PM, chip is in ~D3 state and some settings are 
lost. For proper restoration, all the steps that are followed for a 
regular user profile setting needs to be done (you don't need to go by 
the 'force' name). That is done in the logic here also - it's checking 
if the level is one of the forced dpm levels. To properly reapply, it 
needs to follow the same process.

This is followed in other user setting scenarios also. smu late init has 
a specific call to restore user setttings.

Thanks,
Lijo

> 
> Thanks,
> Candice
> 
>> +
>> +       amdgpu_amdkfd_restore_profiler_after_runpm(adev);
>> +}
>> +
>>    static int amdgpu_pmops_runtime_resume(struct device *dev)  {
>>           struct pci_dev *pdev = to_pci_dev(dev); @@ -2964,6 +2979,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>>
>>           if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
>>                   drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
>> +
>> +       amdgpu_restore_perf_state_after_runpm(adev);
>>           adev->in_runpm = false;
>>           return 0;
>>    }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 2c1a936459ac87..2a140c40b53f9c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -3347,6 +3347,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
>>           if (op == 1) {
>>                   if (!kfd->profiler_process) {
>>                           kfd->profiler_process = p;
>> +                       kfd->profiler_perfcount_enabled = false;
>>                           status = 0;
>>                           mutex_unlock(&kfd->profiler_lock);
>>                           if (ptl->hw_supported) {
>> @@ -3364,6 +3365,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
>>                   }
>>           } else if (op == 0 && kfd->profiler_process == p) {
>>                   kfd->profiler_process = NULL;
>> +               kfd->profiler_perfcount_enabled = false;
>>                   status = 0;
>>                   mutex_unlock(&kfd->profiler_lock);
>>
>> @@ -3404,6 +3406,12 @@ static inline int kfd_profiler_pmc(struct kfd_process *p,
>>           mutex_unlock(&p->mutex);
>>
>>           dqm->ops.set_perfcount(dqm, args->perfcount_enable);
>> +
>> +       mutex_lock(&pdd->dev->kfd->profiler_lock);
>> +       if (pdd->dev->kfd->profiler_process == p)
>> +               pdd->dev->kfd->profiler_perfcount_enabled = !!args->perfcount_enable;
>> +       mutex_unlock(&pdd->dev->kfd->profiler_lock);
>> +
>>           return status;
>>    }
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 88191a4c165796..81055ada4f80b8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -389,6 +389,8 @@ struct kfd_dev {
>>           struct mutex profiler_lock;
>>           /* Process currently holding the lock */
>>           struct kfd_process *profiler_process;
>> +       /* Whether perfcount is enabled for profiler_process */
>> +       bool profiler_perfcount_enabled;
>>    };
>>
>>    enum kfd_mempool {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index eb508fe3ded780..8b7020fc0577a2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1180,6 +1180,7 @@ static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_proce
>>           if (pdd->dev->kfd->profiler_process == p) {
>>                   pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
>>                   pdd->dev->kfd->profiler_process = NULL;
>> +               pdd->dev->kfd->profiler_perfcount_enabled = false;
>>           }
>>           mutex_unlock(&pdd->dev->kfd->profiler_lock);
>>    }
>> --
>> 2.25.1
>>
> 

