Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E797CD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 17:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A319010E1E9;
	Mon, 11 May 2026 17:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d5safmpx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA3110E1E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 17:50:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjcloqvQyAyhyoJu6Iq1wnsbV/84j+NIhFtLQ0DEXVjdES3doDmVJjJDwj5ddZusbT2jzUgEsgiMp4RjwbHnIjv4gFd9D3PgAxiW3v7rgRT1oPxlIBENeGtk+5HA2GhW92CC97vIUyRI0loFLWYe9lP55hK38fQQ2Zf1vfSPp5mqQzd4VFEFHRhYuwtjzFq7NhASThJGJacDZnoC1tmE5vJatU4jnK+wCwDFRUfc/Hy8Fy00bgpfA5qeA9HGZKspYWqbaRg8NY/rSfPgDQdTTnsQk6ph7ysBRE1ib3eoLMA9RDsM7X1Q8uJceD134q1/7y+Fx6fxlOaqjh9I338hIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iwq1OnDoPxDatleH5LyvdGWN+uGO2x9HgP56uo12mb0=;
 b=vIup8SrOlJlnc+XOFKevsQEXO2iJM0JinHnnqqRZhaDYWAmOpYUAH2Zps6cqMhhMF+6otFLbRKHhs3dSAu7IybboJGfIwTmId8GPCagmbfB4Frmk9UPxW6gh1iiU74EhrBF8gGWPKhXMp8ddarFAj6QGwCWaLm0G9+WlVE1Ie8W9juZxKXXZRtHXvaIat3Fq1rV0Mx6lawCXhpkSIeff4n+DTDTwdQTXv+sSUaF55SR5HaWTfj+22DKXsCXXaMBl/CfJsmdZeMp+ePn5Udo9c1U5rDlRpTDk+OOua+I8JifNqw2McZ1XN0ucHk0Gmi8kGl5vRVtYmdUy/R5cyXcN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwq1OnDoPxDatleH5LyvdGWN+uGO2x9HgP56uo12mb0=;
 b=d5safmpxzoljOWFetTMyIK3ylyI/ltclMQ1VALhnhoBgu6TaDFVuTyMH+HWOf+0eef1XYaOROdC3ztwkM3HhIk7RW0THXca7TvA48FvDzTu0RGxQiiQax5Bn1qX8XLF9z6Rt+Sa7S4qnpwdeupKzQsVe2ejbG2K6CUeHDFfOUas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Mon, 11 May
 2026 17:50:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 17:50:32 +0000
Message-ID: <bbbde7b2-f9b5-4e58-859f-05c85ca3e589@amd.com>
Date: Mon, 11 May 2026 19:50:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] drm/amdgpu: rework userq reset work handling
To: "Khatri, Sunil" <sukhatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-8-christian.koenig@amd.com>
 <99fbb7b9-bdd4-4c97-b089-5f6a3bb7a6c8@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <99fbb7b9-bdd4-4c97-b089-5f6a3bb7a6c8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0381e9-31f1-4e84-0587-08deaf85cc1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: VBttxM5c8F1Rt6GcePAX9Nc4NbeyxwRNMdsjRhifhRs+d/eTqn0zDiRPodV00YtxPwglDLrAozMK7jS+2xxHI0fZQ1KB0ISAANgyKSMpwsnrVappj6rKuG3RjhNmqWiRTZUkhuWP6+NHw9vgmul6D5Ix2OvWmVj/5Joj6rhmBN6qC90/srgJAG6MY9e8KDtRXrHAhIKZ04/57MAxC0bZz2GpIPUJ3bkitgphzNxRJD0XhEusYED7c3BSzlrH2twjhoxMxdLGksiBu557C4RkliOpnvWhZFqYcvnITE+4R3OD1xgF+sv2EyP5Hl0OD7dCmwukPKEP07xz4LCopAAkskhk++6xevjCBYmtMxcJPXQQ6NqldOKbhlFH8dIkkDlBgt9ZjQvKi4V86KpqcYAvHvLz7BObuPQJ/+6p+CKRkNo2HesFkaRpUpCg8blxH+SE/8hXNR4k8NSNEpLn5UemkJmWCmltTAwFxQNKr/uF4wGkScb9jtE8B5G+AgtJ3HumR7V5JuCHrjT+Om78pXYCNZdETzzVuJj1wyDwy1LBsj3q1k7uRqEHPNXwUjzuxkUZe6z8HVaIP1TLseAYTtdJD0f4hUifF/tyCKYXtEVqppom6z1evb46yqPftKSaNFN50ClzrakqAQumycCNuhuamQUifDh/JEMmlskWAAFtfBdPjoh75Qf9AduP7Lkeky7j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEd3TmFJZDBrZ2UvUTRTcXlCd25FSUtGSXlReFcwSVo5YXhsRDFLTkptdHk2?=
 =?utf-8?B?clVFMEdsMzJ3ZXNDczhlMDZpWWlPZ0pja2ZBQ2ZTaFlaQUlxU2dKY3VKdWFE?=
 =?utf-8?B?bnk3TWxVMFVWNDJiVk1vWUx5RE1rTzBEaWlpcEZrc1BYNTJEZUNlL2x5dGY3?=
 =?utf-8?B?V1NaNS9nV1B2OFhscjR1cWNKeTJnRWxQK3M5VUpUOXIxejhoYUF4OGtWazg5?=
 =?utf-8?B?NVk1eDFzRjljQXdEWlRQeTZ0czhpaExtemtUemZOU1NxQ2NEdlBOZG9QdGRI?=
 =?utf-8?B?OHY1ZHQ4cmF3aDVEaWFQS25ZSVExYVpWM0lrTUJMdWcyUXZzSU9WYy9TRHZn?=
 =?utf-8?B?a3ZGeUZoZDZDb015VWplUXUrTXRLUlpIbmprWVUvV3ZMWUM5d0p5bjB2NTBZ?=
 =?utf-8?B?UDdUbDZHa01aTVRKU2Z2cVVQeDF6K3EzUjBXdmR4UmRzbGYxajh5MWZGdFdE?=
 =?utf-8?B?WWh1SGRYNmhrUzJrSUt4SXk4eG1IWFRIYkVoc2x4elcwUzdlRFd2UktBZTNx?=
 =?utf-8?B?aTNIZWxUMStyZU1hS1JTSFZhRjNMYmRFbDBVNHJMNUZpOXNJT1U0SFYvR20z?=
 =?utf-8?B?NExHZEl6U2xTbkpLQkVNWjJZTWJpV2FPSGxVTXRhTS9qajQ3WmhpaTE0TWl4?=
 =?utf-8?B?UDRuUlQ3UHU0Y1JXNkVxYkdMT3ZnN1o0dGlRZHFPR0dyUlhhc2g5RHdxVjRI?=
 =?utf-8?B?dmFHTStQZ1d3NDE3Y2pHeng4ZmhheUdlL2tpSVAzdU8vaVFBa2pTQ3NOK2t4?=
 =?utf-8?B?YTd4NE5SRVRJYTQ5eXJpV0JQcG1Ba2dvd05lQUtsVnlEbnJtY3A2ZXlkdzdl?=
 =?utf-8?B?Y3J3R3V4ODRpRlZXekFiRTVNbkRvYnlJWDA2R1hBWXV2K2hhM3Y2OTZldjlN?=
 =?utf-8?B?NmhuUmZ6cURXbmh5SFMvOXc4NHpSVlRoM0JXOTRoeHY3c202YjBnK2JNTDNY?=
 =?utf-8?B?L0Zrb3RNZ3RuRTBUYVUweS82K0N2VTFsYUtFNjZaOXdZK204VTBQeWNVWnZ1?=
 =?utf-8?B?ZmlscjlXYVJ0ejFZUDlSTjZONWQwK2FNVGRVaDNTeDYxWXk2bGZ6UW5DbVVn?=
 =?utf-8?B?cVRmRDR1bWwvREkxWkJYMkpmWmRJMmtEZE91NEFuVkMvNy9tWHpOWUUxTm1t?=
 =?utf-8?B?OXpIRnhBSUxvazN3Vyt1Vmk4Y0NSTWFSajh6L1hVSEVQLzNPWUZuRUppOGpG?=
 =?utf-8?B?R3N2TWJnRHVqelUyWFl4anNDbVk4M0ZuMmFoa2NxTDMySDhpMTVlWXpKSHRW?=
 =?utf-8?B?ZGpNUmQ1TjBHWmVyTnNIREV2bzRqSUxVL2VwZU9NSVZnZFNUVVBiMmJ6ak5l?=
 =?utf-8?B?SitKZFFJTlpGZHZUdG5kbnhMUk9RcWZTa2JCdlphT1gzcjlZc2p3aWdDWnRX?=
 =?utf-8?B?SE1rem5Uc3NWV0dXTTlHeHdjQTdXWlMyeEZxM2dsRksrSEFZUlZGR28wcitO?=
 =?utf-8?B?STdaWXhiRXM3bXRvaFNDendtYVFIZTlIU1oybGdjSG5ycXRTUmZIeTlVWHlH?=
 =?utf-8?B?akpxbDVxTXNpUnFHMlg0S2FQTUFaTmdhWlhWYVZNdzJtQi9RZHU4TXhxcHVY?=
 =?utf-8?B?SUt1R1pQRnVoQ2NiZWJmUVIxMVJTSDl0Nno4TFlVMVRwRkZQNVN5Nlc3M0dF?=
 =?utf-8?B?VlNJakJjOWdtY3pUNHN0VFQ4ekVUSlA4SjJZSlpFMUVHSExjN0ZrNmJqQ1pR?=
 =?utf-8?B?RHZzdWkzQ3E0UEYrY20vZ2dUVFJsdkR4L0pHYU5HNG5SajM1MGRGMW5FSi9r?=
 =?utf-8?B?clNmcWVDTHJkeTBlWjRsMEZCU1BuUXNLb1QyQS93NVF5bUtteGdhS1V6WlUx?=
 =?utf-8?B?STlKM0JiOEFkNnlwRlZvam4raW13cmRDSUQyakhZcVluanMwUHZsd3E3S29M?=
 =?utf-8?B?OENESlhRZ3UyYTExUTVpRmUxbkw0d0ZkcG8xaHZpcUgybGU4VFZkb0VXWGFE?=
 =?utf-8?B?U0FEaGY5SGlBR2cwSDlkSDhONVlyQXZ3Q3hUNjZJTUZQNGdscHE4MkR5ck9M?=
 =?utf-8?B?eEpGdDFlRnZtUkcwb0M5UWxRc1JMWU5sZWF3NWtPS2ljRm9JdzBmQ1lPM3Vh?=
 =?utf-8?B?N3QvRXRHdmhlQ2JsaTRYVlFvQllJUzBqekxWVEJVRGRmRVY0Umx4YXNBT1R0?=
 =?utf-8?B?TTNXTW52STBON2pQU2ZFSlFMcVpDMlEzaVMrcWRiZ0NkbmtpNGQ4dTY0RC9F?=
 =?utf-8?B?N3diM0lyaDUvYmh0VTlMWUo3R2oranZyNnZTbE5rc1c1UmxaT2diUDF5eHV2?=
 =?utf-8?B?Y1FsUmlhRzZmTXFGY1JCNkZVSmNxQVMzcWs0dUtjMDlRZDVJQllMN3JGS2hR?=
 =?utf-8?Q?/muBiYeIz5vFTFKNzX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0381e9-31f1-4e84-0587-08deaf85cc1e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:50:32.6782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcEpvH12hCG1T3kzlK0yPvS3TjwPYj661nnSa8urUaBIF0IxWftsbOpj6XJ3EmEF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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

On 4/23/26 12:43, Khatri, Sunil wrote:
> 
> On 21-04-2026 06:25 pm, Christian König wrote:
>> It is illegal to schedule reset work from another reset work!
>>
>> Fix this by scheduling the userq reset work directly on the work queue
>> of the reset domain.
>>
>> Not fully tested, I leave that to the IGT test cases.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 84 +++++++++++-----------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 16 ++++-
>>  4 files changed, 60 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 39894e38fee4..17341e384caf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1191,7 +1191,6 @@ struct amdgpu_device {
>>  	bool                            apu_prefer_gtt;
>>  
>>  	bool                            userq_halt_for_enforce_isolation;
>> -	struct work_struct              userq_reset_work;
>>  	struct amdgpu_uid *uid_info;
>>  
>>  	struct amdgpu_uma_carveout_info uma_info;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b11c4b5fa8fc..cf61be17e061 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3786,7 +3786,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>  	}
>>  
>>  	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>> -	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>>  
>>  	amdgpu_coredump_init(adev);
>>  
>> @@ -5477,7 +5476,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>>  	if (!amdgpu_sriov_vf(adev))
>>  		cancel_work(&adev->reset_work);
>>  #endif
>> -	cancel_work(&adev->userq_reset_work);
>> +	amdgpu_userq_mgr_cancel_reset_work(adev);
>>  
>>  	if (adev->kfd.dev)
>>  		cancel_work(&adev->kfd.reset_work);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 0a4c39d83adc..ad6dac17dd21 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -82,19 +82,11 @@ static bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev,
>>  	return false;
>>  }
>>  
>> -static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
>> -{
>> -	if (amdgpu_device_should_recover_gpu(adev)) {
>> -		amdgpu_reset_domain_schedule(adev->reset_domain,
>> -					     &adev->userq_reset_work);
>> -		/* Wait for the reset job to complete */
>> -		flush_work(&adev->userq_reset_work);
>> -	}
>> -}
>> -
>> -static int
>> -amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>> +static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
>>  {
>> +	struct amdgpu_userq_mgr *uq_mgr =
>> +		container_of(work, struct amdgpu_userq_mgr,
>> +			     reset_work);
>>  	struct amdgpu_device *adev = uq_mgr->adev;
>>  	const int queue_types[] = {
>>  		AMDGPU_RING_TYPE_COMPUTE,
>> @@ -103,12 +95,11 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>>  	};
>>  	const int num_queue_types = ARRAY_SIZE(queue_types);
>>  	bool gpu_reset = false;
>> -	int r = 0;
>> -	int i;
>> +	int i, r;
>>  
>>  	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
>>  		dev_err(adev->dev, "userq reset disabled by debug mask\n");
>> -		return 0;
>> +		return;
>>  	}
>>  
>>  	/*
>> @@ -116,7 +107,7 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>>  	 * skip all reset detection logic
>>  	 */
>>  	if (!amdgpu_gpu_recovery)
>> -		return 0;
>> +		return;
>>  
>>  	/*
>>  	 * Iterate through all queue types to detect and reset problematic queues
>> @@ -141,10 +132,19 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>>  		}
>>  	}
>>  
>> -	if (gpu_reset)
>> -		amdgpu_userq_gpu_reset(adev);
>> +	if (gpu_reset) {
>> +		struct amdgpu_reset_context reset_context;
>>  
>> -	return r;
>> +		memset(&reset_context, 0, sizeof(reset_context));
>> +
>> +		reset_context.method = AMD_RESET_METHOD_NONE;
>> +		reset_context.reset_req_dev = adev;
>> +		reset_context.src = AMDGPU_RESET_SRC_USERQ;
>> +		set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>> +		/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
>> +
>> +		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>> +	}
>>  }
>>  
>>  static void amdgpu_userq_hang_detect_work(struct work_struct *work)
> The function and the work handler for are using the same name and it causes confusion to understand.
> queue_delayed_work(adev->reset_domain->wq, &queue->hang_detect_work,
>                            msecs_to_jiffies(timeout_ms)); The queued item here call the work item where the function name is same , so its better if we can keep a different name

Mhm, usually it is good practice for naming the function and the work item similary.

Why do you see an issue with that?

Thanks,
Christian.

> 
> Regards
> Sunil Khatri
> 
>> @@ -153,7 +153,11 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>>  		container_of(work, struct amdgpu_usermode_queue,
>>  			     hang_detect_work.work);
>>  
>> -	amdgpu_userq_detect_and_reset_queues(queue->userq_mgr);
>> +	/*
>> +	 * Don't schedule the work here! Scheduling or queue work from one reset
>> +	 * handler to another is illegal if you don't take extra precautions!
>> +	 */
>> +	amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
>>  }
>>  
>>  /*
>> @@ -182,8 +186,8 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
>>  		break;
>>  	}
>>  
>> -	schedule_delayed_work(&queue->hang_detect_work,
>> -		     msecs_to_jiffies(timeout_ms));
>> +	queue_delayed_work(adev->reset_domain->wq, &queue->hang_detect_work,
>> +			   msecs_to_jiffies(timeout_ms));
>>  }
>>  
>>  void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>> @@ -1256,28 +1260,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>  	if (ret) {
>>  		drm_file_err(uq_mgr->file,
>>  			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
>> -		amdgpu_userq_detect_and_reset_queues(uq_mgr);
>> +		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
>> +					     &uq_mgr->reset_work);
>> +		flush_work(&uq_mgr->reset_work);
> Flush work is called here with userq_mutex held? Is it ok to run for that long time and not sure about it but the flush_work might try to take the userq_mutex again, that was problem initially during reset.
>>  	}
>>  	return ret;
>>  }
>>  
>> -void amdgpu_userq_reset_work(struct work_struct *work)
>> -{
>> -	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
>> -						  userq_reset_work);
>> -	struct amdgpu_reset_context reset_context;
>> -
>> -	memset(&reset_context, 0, sizeof(reset_context));
>> -
>> -	reset_context.method = AMD_RESET_METHOD_NONE;
>> -	reset_context.reset_req_dev = adev;
>> -	reset_context.src = AMDGPU_RESET_SRC_USERQ;
>> -	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>> -	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
>> -
>> -	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>> -}
>> -
>>  static void
>>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>  {
>> @@ -1311,9 +1300,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>  	userq_mgr->file = file_priv;
>>  
>>  	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
>> +	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
>>  	return 0;
>>  }
>>  
>> +void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev)
>> +{
>> +	struct xarray *xa = &adev->userq_doorbell_xa;
>> +	struct amdgpu_usermode_queue *queue;
>> +	unsigned long flags, queue_id;
>> +
>> +	xa_lock_irqsave(xa, flags);
>> +	xa_for_each(xa, queue_id, queue) {
>> +		cancel_delayed_work(&queue->hang_detect_work);
>> +		cancel_work(&queue->userq_mgr->reset_work);
>> +	}
>> +	xa_unlock_irqrestore(xa, flags);
>> +}
>> +
>>  void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
>>  {
>>  	cancel_delayed_work_sync(&userq_mgr->resume_work);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 85f460e7c31b..49b33e2d6932 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -84,7 +84,13 @@ struct amdgpu_usermode_queue {
>>  	u32			xcp_id;
>>  	int			priority;
>>  	struct dentry		*debugfs_queue;
>> -	struct delayed_work hang_detect_work;
>> +
>> +	/**
>> +	 * @hang_detect_work:
>> +	 *
>> +	 * Delayed work which runs when userq_fences time out.
>> +	 */
>> +	struct delayed_work	hang_detect_work;
>>  	struct kref		refcount;
>>  
>>  	struct list_head	userq_va_list;
>> @@ -116,6 +122,13 @@ struct amdgpu_userq_mgr {
>>  	struct amdgpu_device		*adev;
>>  	struct delayed_work		resume_work;
>>  	struct drm_file			*file;
>> +
>> +	/**
>> +	 * @reset_work:
>> +	 *
>> +	 * Reset work which is used when eviction fails.
>> +	 */
>> +	struct work_struct		reset_work;
>>  	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
>>  };
>>  
>> @@ -134,6 +147,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp
>>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>>  			  struct amdgpu_device *adev);
>>  
>> +void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
>>  void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>>  

