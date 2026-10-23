Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FEF606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PMVF4Xa4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFE81129DA;
	Fri, 23 Oct 2026 09:14:46 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEF31129DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+HqWGSYPJQzSaAloCti3s843dsD2Wf1Xrm2Av9sWfP9A2/fJdt89jOtXwkHtyzEKeQru7ulsM3i8CusuPsaTr6mL2/5WfL6Ga/S87+KmomsOHp9jPCc72bFxJ0wT/NNkLESKF8BI4NZ/+ItxBOj5oyZcItN3BcuqracUpO2e+oH6LHKk37R8BO4IEtYs4VALcOde/pYEKki/R9gJ81AzAfKhdT8s7bcqkLCrBBZ0teUTAw4jYPLK3o0rh1ZkjLNOZ3ereWBHqgSyl0n9Pbds38O2Xv9TKQEhdVxahrHy19unBxPGKqPtlmY8DuD7gT5aL6cSxWD+aIxGZKJtNi3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WR1Vjy13BGWObWVdmmIh0I5VSMzyuxEGY63z/SoRGM=;
 b=aokKESKGstLC/mugbK4LKHWAH++1y+j539Pg6MLGGZdkQWEdgk+smZEtQKDTHvP9MHg1/rK7+NzLtotd0xd1qcEfOpNYdVt6msqXEIKQK5K5nVuyXq9JplcKqjJ0iBtQy7E0IzwbEO5GB/lsxXZpEzQo9XfozlFN7zi4+xWJw9d2nXrPSXEsKRtlLnqF2LOJFTir/cngdWce39MMnJAnJZhuI+NJ0XQ369s8UHaes04LEGin+TzbJsjJxXxbKq/YoKJBDtXJ82J6sJrykKBbj/ePvwOqv+UkEB5Kl84H4h2MSrj1IqIiNqlbm0aLZP5PsVkvj9xpdau24BS6gnwzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WR1Vjy13BGWObWVdmmIh0I5VSMzyuxEGY63z/SoRGM=;
 b=PMVF4Xa4WaLnYcoHj8aKY4lVhIYODHYYcYUj8zRYpFvLV6QMkGyj3IbnC+C/oDqxA8IJonS3yNfdRG38BPEiiDyzYy17prf95GMFQ1+aRBuTcQbzxxEhcnqXmM/nomvBzU2EbY11YRh/nJcR2jws6K9DMKxRbPyGjJ4eL4dn/yY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 09:14:34 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 09:14:34 +0000
Message-ID: <f07784fd-26e6-44fb-8558-da0638ceb11a@amd.com>
Date: Fri, 23 Oct 2026 14:44:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amdgpu: finish GPU recovery callbacks before
 restarting schedulers
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-2-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261023083422.3049246-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: e896e823-5805-4b53-66e9-08df30e60da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|261022105027099003|261022075727099003|11063799006|4143699003|261009223027099003|261021123027099003|10067099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0/9gT6FgKl89p0vGF/vNpv36NZpq2t7BnHQXonPXo9X1msnKGexwwmy+ltbSYRDPC6C+CovXnITPi6PzTnxw4kRA/5tbSmhWV6aChcVtme+zrdrx2hy5W1RB5D2gCyHFzCYTqUuwmIjs0NZLuZKbiRNo8Iay+aIS7g0gqJC0SRgomdM2SWA/vJlT+7gt+tFQFzRT0O2X0HnlAFXUDEM+0R/dvCNCDyaRPdtwpQVt0WatApYEEwEVtQz8hTi1BL9BaOEydYJyjlqfaRy9dwgeMYW8ooQmNKMFcxYID3ePoxrjyg1JN2Y1GuJmKT8DQSit4th6gHuY+kZn56wrgEKX4zsUvlrxSRDpCrP+6i5PtI4G9T1s046b6rm2pkyUZRHDXKc5xn1yI+YFmVN2wRDgoGpPOyCE53y72mZ6X3FvPOFEzS4uF25oVOx/K3T3eSfg1SZ/JmigbqVjeocTFEZbKHd06Xl5XahhbNjHFACGCXoFdQyLro3sJ2BSuA03sWdheQwWT0mcgCFWDVWIyEnJcA+SZRpuXWDPJgj7+u250/dvfFzFfHwlSMsrtxjkEJjp7szHXFjLHxtz3SqjryD6A/Q2+UnnDUbVoDInkomIWa0N53hqzJ1c4a/gmkqVYOdAz8XopPO82+hu5dq5Tod7hqK3WZnxQ6oJxhmKz5KnV78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(261022105027099003)(261022075727099003)(11063799006)(4143699003)(261009223027099003)(261021123027099003)(10067099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDJKVFJCdEtDMGlwNFE1ZzYwKzNsWVZLaVlTa1RnRHN2N3hndXMwbDFwOHNw?=
 =?utf-8?B?ZW1JOHZxMXpqd3RCUWNSQlc1eGN0dEVLNFJwdEk5eVRRTHpseTYwa0NRaTl3?=
 =?utf-8?B?MHRDdGJLZlEvakVRa2NISm1UeitOT0djLy9xQzlmTE9NbHFWajhPVC9hZVhu?=
 =?utf-8?B?QStnZFlPQU56a2Z4U3ZOMVhqMHo2b0FKN25ic2NtM0h2eWVvUzRrT1pzemMv?=
 =?utf-8?B?SmNHc3hBZUg3STU5OG1haTV4bGZrRWlmQmlLMEJXYzNyYllPMVQ1U29LTlp6?=
 =?utf-8?B?SDU0cjNPTE5YWWNnWkl2U040RnRFdGkzM3B0VVpBLzlhaDI4a0xUVmlvUXFU?=
 =?utf-8?B?d2pmMWVaMkVoOCtuVVBkRHdaMGNnWXdGRWdDcUl2dEpDTUpURHFraW1ZcE9y?=
 =?utf-8?B?YmtDZnZwUXpVWjZvUW5vUHV0ZjJUZE9ZaTd4SXBEMVZ2SFdDbmNYRFVZdVJv?=
 =?utf-8?B?UXRxd09lRFdNWU0zWXVYbU1TWkpUWEh5L2VjSnZRYXZGYlRlSnRoc1M1YkRK?=
 =?utf-8?B?SU5IekpDTzdjOUhZV0lZaDRabDRZVU1OSjJXVm5KcFZ3b2l3K3g1YXZvdjEv?=
 =?utf-8?B?NzZ5TEFNd3E0RXlxUnFwdnNSdkl3WVp2TlZRYkJsdEtzVldMTk0vdkRzRlVR?=
 =?utf-8?B?VFFReTE0bW9DcUY3WngrVk9IVEVCZjk0TTZlWG1LWW0rMEdqMmtqTXRZVTlr?=
 =?utf-8?B?U2RmL0szVmJTZXVQRnZFZ04vNUJ1VjNPZXRqYk1HUjRvSGszM2pjL3Q3YzdL?=
 =?utf-8?B?Zk5ZOEVieW5VdXdqZ0lhamJGeUlSSWs1VnJEMHFQcm1iMzFaTy9SWENZaXFT?=
 =?utf-8?B?WnVyelBvVmlsemtyVEN2eEFPVGZ2RDE0SG1ENmFYTHlGeVl6elZxZTBic0sx?=
 =?utf-8?B?ajNmSjhqSDRhcm1zd0t2dDIxVTZSMHQ0YmQrK2dSdnhtZVlTK1d3cGc4cGFB?=
 =?utf-8?B?dGtaL29XYjhHaURsTWYyVDlIZmtrRGgvWC9xd1JIMFlod09ua2xWUDdWQWho?=
 =?utf-8?B?TlMzWit6eGxPUWFhUDlhZW9OQkhIZGN5WHgxaklWWkNxZnlrbEpLdy9xd0hD?=
 =?utf-8?B?YzdyQkRnTG5PN0hoeTMxS1dQWEw0Z0R1SDdlV1JaeklXQm84UXIxcmxZbytL?=
 =?utf-8?B?NzY5Y3V6S2JOS0V3ajdNcFNocUEzWUFvY2pmYW1hZFRJY0Y3V0hUcENBNU40?=
 =?utf-8?B?dWFOZmNvc2x3OTZ3VFVNNHIxbHlMQXlSNThaR2dPc0x3YnArcjhEQ1FQUCsw?=
 =?utf-8?B?emo0WlZPTTNiOEFUMzlDNUwzd0M3dmh0VWlzMDVzTm5DdDBoV3hKQUdYNVRX?=
 =?utf-8?B?bHVMNjNPNE9iUXJsUVVpUGpIUk1uRXFEeGxFV2RldTNaNXBQS0N6aldHUklM?=
 =?utf-8?B?b1FQandHYVR5YkJNek03aXJ4UFYwM2E1blNOTVQ1bEloRTJld3NwdEE3em9k?=
 =?utf-8?B?L0trUjN2V0xESDlRc2RlM1pCT1NEV3BDM0VqMng3Q1JsbXd5cVhveEp3RTdp?=
 =?utf-8?B?QTIyOXY5WmNWTlU5OUtOa3IvNUN5M0pLSVI4V1ZBNlZaTG5sWEVkTytVUmlP?=
 =?utf-8?B?OWQ1QmEvSW9Zek0zQUV4c1FkYWJnYVZaZkE2Z0VuUnE1MlkwWEdaYkhKUmxM?=
 =?utf-8?B?eHpKc2tPdnhDa3RFNkNsUVlTcGF3ZDJWeGdkVmsyanlXREtJMktXRjA5QWF2?=
 =?utf-8?B?RjNqVzNhYnRyaThaYjJ3TW50WG1lSDUrWEpGT3E0bGp4dk1NanVhT203Ukd1?=
 =?utf-8?B?VVBPOHVmY1lDQjVNMDZKS2xJUU5Eem1PWUxIYTF3aUZsdkQxdWFKaHA0Uzl1?=
 =?utf-8?B?MmN5OS9OTEZyZjl3NFVNQXBFbHFna0pMWDcybDM3cEVPOWI4dU9jaVdBME1u?=
 =?utf-8?B?NTQ4VGVaT1piSjliSTJNcFZ2TFY2eWZKUVBjSFZFMVp6bFU4MjBKRFh2cVMw?=
 =?utf-8?B?N0FXVHpHdWV4TUFBNmJIaCtOZ0xrRmh5WmdDUy8ya21RTHpkMjF4diswQnlp?=
 =?utf-8?B?dUlZNEJMTUNLVThFOHVaNjQwYUhBZGlxM2Z2Y3RzazBqWWlncFU3OWtWWkQ2?=
 =?utf-8?B?c05nemxVNXZiNzZ0ZzhwQWpDbVQ2bXlwV1lVWDJLU3F2b0ZrU2RlR05GRjJZ?=
 =?utf-8?B?UlhzOVlCZ3FMclBhR3VhRDloRVk5Qm5mb2ZqdkVLdFpSQnpoSXVXUmVDTnRn?=
 =?utf-8?B?MnBQalRFdlo4TjRhc3RJQmhmQmxLYnZIN0EvRTRCWFpwYkxidFh3cEdmZ3B5?=
 =?utf-8?B?eFZoSXV2Zmk0Q0U0dGVqUFRmdmptcldwYmltQ0U1bFg0L0NheGNoT2szRGdF?=
 =?utf-8?Q?j9hN+CCNRBTn3XWMN5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e896e823-5805-4b53-66e9-08df30e60da0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:14:34.1301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIhXH2jI7jnXBn9nfaTLRLqt4s5cUz5aCd691nxgQaAyOS6W4k9IaswbQHk/6L5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 23-Oct-26 2:04 PM, Prike Liang wrote:
> Run GPU post-reset callbacks, including KFD and display-audio resume,
> before restarting DRM scheduler workqueues. IP hardware initialization
> already happens inside ASIC recovery; this change orders the remaining
> callbacks before new scheduler submissions. Preserve the emergency-stop
> and guity job completition path's callbacks without starting schedulers,
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 406c5f2fbee1..20f02dd14c41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5816,8 +5816,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>   				      hive, need_emergency_restart);
> -	if (need_emergency_restart)
> -		goto skip_sched_resume;
> +	if (need_emergency_restart) {
> +		amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
> +		goto reset_unlock;
> +	}

Does this reordering indirectly affect any ttm memory management funcs 
(sdma) that may be required during KFD resume sequence?

Thanks,
Lijo

>   	/*
>   	 * Must check guilty signal here since after this point all old
>   	 * HW fences are force signaled.
> @@ -5827,18 +5829,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
>   		job_signaled = true;
>   		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
> -		goto skip_hw_reset;
> +		goto post_resume;
>   	}
>   
>   	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
>   	if (r)
>   		goto reset_unlock;
> -skip_hw_reset:
> +post_resume:
> +	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
>   	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
>   	if (r)
>   		goto reset_unlock;
> -skip_sched_resume:
> -	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
>   reset_unlock:
>   	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
>   	amdgpu_ras_post_reset(adev, &device_list);

