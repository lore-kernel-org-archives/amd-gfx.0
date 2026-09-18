Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4663AC88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 07:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD8510E840;
	Fri, 18 Sep 2026 07:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V5I18SkH";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4DD10E840
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 07:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLb03l36u5RT6QLyK9BJWri2fsZ8Ch1s3wdLJl99/+P+R9XkJLV7cHRuTjPfu6MmAl0Rpd24pfYn8CBE6lSfNzZ1rtdflvv6UIkTF040EFn+mDLtH+OtNzz35OXLUgs1Bw5ye/pDnrT1reV9R5xquhyY4nOLVjgBlDh/xGCAtJnzyVqvAEsFDfo2Xt8ZGrhfe0x6zal42/HU3FwyaE9yS9+WMWFxKtUmincybvMyrxAuY6z9+0aEyUP3Bs9s98RGMCAuPMlUAd9kPoXQOO9XEptFPmLRsgJOKkjobjdfVd+xvZC1phcTnWBWILSJO4RCzp1PRWbVmO1G7wp56SAN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5jZ96EqtFESAVoEw7bfQOhWsOmItPkOqhdfFbgWtOg=;
 b=iX1mt6JpOE4tYoouXNNaZQJlX+V9nttzY5y9tohmtZrK8j2RXNGJyVN+dCboafsEXvon+5TdtfEC7YBHN+q8t6ZVWpHfUPZJYaU7MYM5MGwCB9faAIDRHY5jGeNf75rhwcgT4IE9TsfHVHIzCElsKGjCHSrnyYhQujCanhQrfu/MORnWgsEpO9IloNccGOH0qeJaH6kRet/8Ay6cSzLOZ1KGpzAAGlaCJlI2v1CdwVNR40BQf5Esuo5VsIuRN9iOdjJILy8z7aUYPMcMpHAHwiZ3WdzohN3QqSoi/iQMTCfE44dYXahlXuN5PQlslqX/Jp8k3tHZQ7mJEubukFG2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5jZ96EqtFESAVoEw7bfQOhWsOmItPkOqhdfFbgWtOg=;
 b=V5I18SkHcXfOpExdm45TaCK9Sj5jCUqzQjUQcjWPdqqv6bA4EBuhlqoQN70k5E9HBy8VeFtImdFgMr6Xk6wyXXdbXu+Fdz4p4jRyAB/TOkH23SjxgqjJyc2rgTlG5i6IxFtCCBVgqUMSsDRDkn7RXugEBkcw/wSOW9oDWGW89Lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 07:54:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:54:14 +0000
Message-ID: <68455f0a-b55f-45ca-9490-d4eec7cd2be1@amd.com>
Date: Fri, 18 Sep 2026 09:54:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] drm/amdgpu: rework runtime pm management for cs
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
 <20260917195812.72917-4-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917195812.72917-4-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: dc173b09-ea76-4d75-2ab6-08df155a0846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|6133799003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Bg7nRQqTZJlPTsLpk2b11EU0ZQTEFkLR4gp8zbDW4tFqEIJpSpf3McikSZoKmPD54FIQ+d4x6kzfPiqwqwPykAJsYAtPGVrgg3QpJY0i29JG5LTuvX1+pnJofeMg7iC68MtcKJ65q28Yl0t5Xy0I1+8/+utjF2HF576UScDmIpHL2e7/xvck/FHAkgLZC6WKEZhgZpOJvnSDutmGi0xleLEgFga8drxgKUIKWvQg6cJZLorWqIT1AB3Octvt7NhiAVdtfvR4iLufRjJLv3P1jPyj9UYAcbqSOQ29Guf4bdKKHbhl7cfryoJf8jZ6TQruBjaJ3uQEp6X32mDJN8O4zJvLqbvLS67kITREjbtxl+yI+icrAtouXYMDdz03gTlHAlOxs8Fof8s3N5Y1ZZNFMvOAuPsBIIgMPwMde2JEU32gunkTlh+CxCv/v9k7ACB5ZtFa7/VhIDehxKVJi0qBJ9tNCsgqg80MpfcENZfwGpwQUHzSu4pRfsVPQRkv5Jbqx11Fa7iKPOGwadwdTr/Td4qywKj5g/nDyF5TJwr+yqb4HzQzblTGnVUJR2YVkYjehhMGbw0vvhWLELQCJy7+mwbdoz6P7XuE88Ftz5ChLUe3Ed3N1hx8zU1AA5FEqWPkPJxatA5HjFn+EK5sH+qSkRKUU+jaNXJ7qTvGKH21k5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWg0SDQ5RHpUNG9MZVhvN05jTHpxL1R3cUQ5MDBUNlAwNXhWQlZva2kvQW5B?=
 =?utf-8?B?bVRpMWQ4clkvSEkzK3F1Z3VFUjlDOC91Q2JBTk54cXpBdVgwZTIxNytyblZJ?=
 =?utf-8?B?VlRZdkphbmR0b05ZTDB2K1k5REdVVFprdUJGVFFYQTBzZS9xejNnOXFyUE03?=
 =?utf-8?B?U2NIbW4zejJuY1k0REdueDQrN1hKYmRsNzIxNTFiM3RVWEdCc0d3OWw1RTJG?=
 =?utf-8?B?V2pKdWFaY2cxdEhPOXR0RDB0dGZrY0JEaGFoS1VLWktCQTRxZjJ5eVdLek5I?=
 =?utf-8?B?R0pkQTJQVUxiWFA4S2NOemFjaDVjQ2l4b0h2NVR2ZGs3WGZMOVB0bzdSSWZp?=
 =?utf-8?B?bkcyNUtrMjNZZU9IYWR4TzdjcEdGTWEzUGpOVE5XV2FQQ2J1cC91TFB1ZC9i?=
 =?utf-8?B?a1l2UWROTXNLdmRPbzRRMEtUczJ2Mkc0eHVoMVF3VFRiMW5aVGFkUzRKQTJK?=
 =?utf-8?B?eEliY2NvRSsvOFVaUEUydlMvc0orQ0FpVDB5UTd4WDVsd0JVbzZabUFsdm5U?=
 =?utf-8?B?R2xHOGxaNEc1ZEF0ei9KeDFTb2VVUmJ0YU1XYnhyTlRTSzFBVDA1ZUpJK3lJ?=
 =?utf-8?B?UWl0Y1k0QWpodkFzRHhZTnpoWENzRXRIOXpjYnM1aVdaSEdTN0FvYTNKNmU4?=
 =?utf-8?B?N2RHUVdhQnN0ZVovY1VJaGV3Y2wzM0dQMDVjajA5elNhVUYrd2xCNmRnNkNx?=
 =?utf-8?B?cWJaS0wxY0ZiUk5nNXpIYjltZys5TnFoUE5HejF4eVJYVUQ5b1o0bDVjUHVY?=
 =?utf-8?B?K3AraDZ5ZUhMcTkwcDdMNkNkT1NjMnE4TmpVWVJJOU9hTG9qVWFVU3JhTEg3?=
 =?utf-8?B?TG5Cc1FOWjlvV1lnbDVKSUFQSFJDYmp3eFhSaGl0NlB0YkxTV0FMY1hMSkFh?=
 =?utf-8?B?TWZDK3pSSnpTeTVCMTQyUWdzVVMxeXM1RHBuaW55Rnl5eDdPNEl4WGdydnRZ?=
 =?utf-8?B?MTZNRDBpWERzT1Bnd1JIMFR3eW8xbzJJYkN3eGo5dFVYVThwU0Q1bGwwZUd3?=
 =?utf-8?B?UlRneEZJY0ZMOHZvTms5Y3RJcm1aWkVSb1BPZ3JyS1pxVjFsMlpSYXp4OGxn?=
 =?utf-8?B?SWc5eE5ndnh1dFZXYVB2cWdQbEQ0VFVIY2tTSmpabWl0LzJzODFaWDNvY1RX?=
 =?utf-8?B?Zk44cWNMSUE1cllaODVHZ0VJS3YveiszQWxTZFk2L0RYUHpaOVJXeUtjQldZ?=
 =?utf-8?B?MXN1OGg4aERFaGRpY0Q2eDFWK1RucmRXNHZlTkZYQXZXUWhpaFdPY3BqbEcy?=
 =?utf-8?B?anhJYjlFSDNseG9WVnh0QUhodVR6Zk5DWjNaVHFIUXNkeUJvZ0UzamdUODRy?=
 =?utf-8?B?YlJMcmJ5bFlncFRhRmN1RndXQ0lVZWtNeDluRkVXN2t0anR0Nkh1Y2NqMEtr?=
 =?utf-8?B?ZkxqUGdIRHdza3V1SGhlLzdrUDZ4YWZXemsyYm0wZkQ3aXIwRm9CTXNkdnBo?=
 =?utf-8?B?Q1lMUTFvdFV1UzVEVGRDd3ZOYktJTHAvOUtYaElyRVo5RmJ5VXJneUZpTXh6?=
 =?utf-8?B?bDdmR0ZWemhOdmFnSFZWNEp3UVdmVWprTkpTM3hnc3VRRnFUd3VJY3NaUGMx?=
 =?utf-8?B?LzJISkJQQXVyQzNpc3A2K1RVZG02OVRicjdVaFFkTFFZMUtMTmdxS21Yalhy?=
 =?utf-8?B?VzFFWERJS2Vya05INVZNYUVvbCsyRFpkNG00SzV4dXM4VCtQb1hveXZqSktY?=
 =?utf-8?B?Z2VscXVLZU1uMGlSbnJmYlpBeE1INlJObXJnNTNuVHJJYXp4MzI0ZExUV1Yv?=
 =?utf-8?B?bnVmaXJUcHRyZXhEeHppUWNEUktCU0tNdFRrZFNRK2diME9LNEF1MXJ5YndF?=
 =?utf-8?B?THRINmNhUld5NUs3bUZGM2ZITGJScGUvOXBXQzE5M0JkQ0dPdmZhaXFwbkNS?=
 =?utf-8?B?NU51R3ZaVGtTaE5LZEUrTzlLYmRzeExpZjMvUkJ6Wkh3TC9UenF3dkhwcTRH?=
 =?utf-8?B?MlNoUDJHQkZqOFcvdHVEeTFsRitmSWNIWHlLNG5nU0c5TkFDdjFDcm1wbnBT?=
 =?utf-8?B?ZkpxRkNVSTYwNGo3bmtjMDRmb2VNczFXL0hyOGZjUGNjdS9tVUUwZmVWcEFj?=
 =?utf-8?B?RDViYm5XK2Q2eGZQYlpOem9SVzVSV3VLVkhCSmd2a3pwY2VqNWFFT0l5OVds?=
 =?utf-8?B?ZmxOOEF2RCtWV0hMdDBwVVJBTVpkSUxHSzBka09nSkFjOXR1ZjYwb1FjSWwy?=
 =?utf-8?B?NnJtcU5hRHNNTytVUzRuLzBYQVhjeUVWRXZZc2N4Z2IydHFoSlR2TTlaYkM0?=
 =?utf-8?B?Uy95YTJITnQwQkJhT20yRjUyVmQ2VENnazQxZ25sNXpMcW82WTZPYUZldGFL?=
 =?utf-8?Q?6Q4FvyzJDIiJjrs1xp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc173b09-ea76-4d75-2ab6-08df155a0846
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:54:14.1883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfrEGwa8dFovTzO8CEUdFxScPaDMNH/Onlc3T0JEoQaf+eaO69LUuLqyURxnTBDQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683
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

On 9/17/26 21:58, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Creating a job will now wake up the GPU. The rpm ref will be dropped
> either in amdgpu_ib_schedule (because at this point the amdgpu_fence
> took a ref) or in amdgpu_job_free (for unsubmitted jobs).
> 
> Jobs submitted directly are a bit tricky because they might be fired
> from suspend/resume sequence and for now they're left unmodified.

Well that patch is still quite a mess.

I strongly suggest to just drop it completely and have the CS IOCTL have the necessary runtime_pm calls. See amdgpu_cs_ioctl().

Dropping the runtime_pm at the end of that is ok since autosuspend will wait for the submitted work to complete. We actually don't need to mess with the jobs nor the fences here.

Regards,
Christian.

> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 15 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 42 +++++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  2 ++
>  3 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 0f8b097001e3..3b55dd6ce8a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -27,6 +27,7 @@
>   *          Christian König
>   */
>  #include <linux/seq_file.h>
> +#include <linux/pm_runtime.h>
>  #include <drm/amdgpu_drm.h>
>  
>  #include "amdgpu.h"
> @@ -297,8 +298,18 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  
>  	amdgpu_fence_emit(ring, af, fence_flags);
>  	*f = &af->base;
> -	/* get a ref for the job */
> -	dma_fence_get(*f);
> +
> +	if (job) {
> +		/* get a ref for the job */
> +		dma_fence_get(*f);
> +		/* now that the fence has been sent to the hw, we can drop
> +		 * our pm ref.
> +		 */
> +		if (job->holds_pm_ref) {
> +			pm_runtime_put_autosuspend(adev->dev);
> +			job->holds_pm_ref = false;
> +		}
> +	}
>  
>  	if (ring->funcs->insert_end)
>  		ring->funcs->insert_end(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 0056a93c400a..417f2619dfb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -24,6 +24,7 @@
>  #include <linux/kthread.h>
>  #include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <drm/drm_drv.h>
>  
> @@ -201,15 +202,24 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		     unsigned int num_ibs, u64 drm_client_id,
>  		     gfp_t gfp_flags, struct amdgpu_job **job)
>  {
> +	bool take_pm_ref = entity && !adev->in_runpm;
>  	struct amdgpu_fence *af;
>  	int r;
>  
>  	if (num_ibs == 0)
>  		return -EINVAL;
>  
> +	if (take_pm_ref) {
> +		r = pm_runtime_resume_and_get(adev->dev);
> +		if (r < 0)
> +			return r;
> +	}
> +
>  	*job = kzalloc_flex(**job, ibs, num_ibs, gfp_flags);
> -	if (!*job)
> -		return -ENOMEM;
> +	if (!*job) {
> +		r = -ENOMEM;
> +		goto out_pm;
> +	}
>  
>  	af = kzalloc_obj(struct amdgpu_fence, gfp_flags);
>  	if (!af) {
> @@ -230,6 +240,7 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	amdgpu_sync_create(&(*job)->explicit_sync);
>  	(*job)->generation = amdgpu_vm_generation(adev, vm);
>  	(*job)->vm_pd_addr = AMDGPU_BO_INVALID_OFFSET;
> +	(*job)->holds_pm_ref = take_pm_ref;
>  
>  	if (!entity)
>  		return 0;
> @@ -245,6 +256,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  err_job:
>  	kfree(*job);
>  	*job = NULL;
> +out_pm:
> +	if (take_pm_ref)
> +		pm_runtime_put_autosuspend(adev->dev);
>  
>  	return r;
>  }
> @@ -270,6 +284,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>  		kfree((*job)->hw_vm_fence);
>  		kfree((*job)->hw_fence);
>  		kfree(*job);
> +		if ((*job)->holds_pm_ref)
> +			pm_runtime_put_autosuspend(adev->dev);
>  		*job = NULL;
>  	}
>  
> @@ -314,6 +330,17 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>  static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  {
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
> +	struct amdgpu_ring *ring;
> +
> +	if (job->holds_pm_ref && job->base.sched) {
> +		ring = to_amdgpu_ring(job->base.sched);
> +		WARN_ON(!ring);
> +
> +		/* Should have been cleared on submit, but we have to drop
> +		 * it in case the job was cancelled.
> +		 */
> +		pm_runtime_put_autosuspend(ring->adev->dev);
> +	}
>  
>  	drm_sched_job_cleanup(s_job);
>  
> @@ -349,9 +376,20 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>  
>  void amdgpu_job_free(struct amdgpu_job *job)
>  {
> +	struct amdgpu_ring *ring;
> +
>  	if (job->base.entity)
>  		drm_sched_job_cleanup(&job->base);
>  
> +	if (job->holds_pm_ref && job->base.sched) {
> +		ring = to_amdgpu_ring(job->base.sched);
> +
> +		/* Should have been cleared on submit, but we have to drop
> +		 * it in case the job was cancelled.
> +		 */
> +		pm_runtime_put_autosuspend(ring->adev->dev);
> +	}
> +
>  	amdgpu_job_free_resources(job);
>  	amdgpu_sync_free(&job->explicit_sync);
>  	if (job->gang_submit != &job->base.s_fence->scheduled)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 7e03bd2ff639..e7ab7e38f6df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -101,6 +101,8 @@ struct amdgpu_job {
>  	bool			enforce_isolation;
>  	bool			run_cleaner_shader;
>  
> +	bool			holds_pm_ref;
> +
>  	uint32_t		num_ibs;
>  	struct amdgpu_ib	ibs[];
>  };

