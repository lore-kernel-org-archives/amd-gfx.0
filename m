Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF464C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 06:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1CA10E576;
	Tue, 27 Sep 2022 06:11:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C9C10E576
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 06:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrz+c0vIF6ELW3Jl8O86i8a8P2fAu7rU1+/CVLeAG9A4NZHY/j/tP8HaJPZac55fF39LiMTa29pifNydjKqF6I8a38KD5Ye7hbsam3f+2PBxyaxaQRi0qr4jTGrXjeO5SP3z1PEyt07ldA+vCWAPjQbqPUfPjctaBT358eg2v4o6jfGKUOrYqVe+snufsbo7GE9FyU8dpzWNl0Nj2D6W7ZAY69PkKijRD0tN4KRLSEVTxTF5mQ4Fa+Ln4TXUJFOmryT4bAMcKbn6/QuG4+ZtnFe824A3JOeKkewd/Ai/ysWpWhpLHMaTIEVjIuai2hMlpsp1ahu+9GBUDSV+ai5fuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLRnpyo6r/p/Z80KMt/p6gjGbOU7rWGB+ma3dBqdevM=;
 b=ZXp89K8g0GcFh0pkdDyKBzNfOb3hcSaSQq2ngLSRXEz+IHKXr/GhKUk0Y5IODr9WF2Q2WqlxvzL+lBs+HzEPSUdZGoZzpDbj17TLvpM4dmrsoiPkzScC4VZ3Qf/JHcoxFBZp5USwBZrky69rWXk1SKv8TocJhR/q91Iud0+TNnon90u1EtNgab6NsN4yDfFkz1BuXVGquw6pyqQGcrPWzdGHjY/eSNzYAOaiQPg/f05K4pm2KLWpKMwfBvcbikPEUi/Qcix9PTbrrAJrwXNTak3Jz0cv1Qxbk4MYdxsubGiFpwo40OZMFFnO2iwkrXew82G54Vzx6UOVDHCLtz6Erg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLRnpyo6r/p/Z80KMt/p6gjGbOU7rWGB+ma3dBqdevM=;
 b=w6/bC1xYLe2/A3UksRnszwQGtguGpvTdtEt0ghsddMmcKP1PNwXh11Ub7ZPNE/XjiqugnfUmtQcGnI8+4LKbR+S0JrGcZdDdGn4jrz9r0BSB7kFrOG5VA3wAFc8e63YvDgLNsn2I+gaMzjLBUJZ+2kHEWZxu06aJYyIOVGaiJdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 06:11:39 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 06:11:39 +0000
Message-ID: <0f6d48bf-89f7-2bde-e7f3-eec1bba9855d@amd.com>
Date: Tue, 27 Sep 2022 08:11:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 4/5] drm/amdgpu: switch GPU workload profile
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-5-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220926214014.5450-5-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0602CA0008.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::18) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5836e928-ba93-46e4-a545-08daa04f23ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/iykkh/HtWpBA77ck4IlC6Ms5ZPp0RZGej5iKc845d9MU1krtdrEp2yGnSaSsS09hDVGlNRdKAQMXh2G9JjxEmI4sMEchDAJ/AoLe0grIZKSRauM19KKfbe5Ch4kXO2KwzdE8fdi/J+OBMhSeFPh3kdmNVz4XEnEeBkAVuPebWHMmzLvmb5wRMyS/D9wayjE1oEWufQjjFWhC8wg/ot0GGxaN/TosGdXOc3GAO/KvDT2nCV3Dhfm40drwNpddwdb/83/WRXtgqADkmkeN+LhcYAW7AKZlAXksf6bbR+DC42zNvDUfYOnZ2LXm/xWPro6IteocMIaP1Ury2k+kuE8vB2wa96M/4xELqfgFn8P9v+iMjl5X8n9aSvc/KEl1xynhGuBC/bnIdgPCJiy1wYTTdNoaAvdx6W7PMVFXyhXgNmT7+2g8Rg7DNHvERgxOhn9e6SvBaOInubiJMQCNYdFZSEBz+DJBcrHIWEhLQXFZmkxnv15CrLRTvyos6jG5JBa/UOJSDPw6XVeAK3d5Ua0EoHSVKzXTkTHNapV22u4gIA/H2TEa4+5J7KDfvdsZj54Cb66728VVN+4Svo1AEJOyE2yMyDezR+P9qU44K3AoPBtedDPSTYrOZ/iRPvD1u7Pin02PTey0pYTml0ZduonPJsgnHk+2vN2txnu/nOPem2ryIUbdrp1pBeueT//+ro2xEhwWXlZrf9OwIhBx9QUinxta1uoomX5azie/NO69sCWNm/BoSmJg1GvyNxtxGSqc7AslipF8YY8j5L7xjqSYw0NkG+N25fefWDo/wBumg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(6506007)(4326008)(6666004)(478600001)(41300700001)(6486002)(66946007)(8676002)(66556008)(66476007)(316002)(36756003)(38100700002)(186003)(26005)(2616005)(6512007)(86362001)(31696002)(66574015)(83380400001)(31686004)(5660300002)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0N2ZFlPcjF0MStEbkR4QU1WTHYrZE8rVUd6NjZockNnQURpNkxTTG1DWGhM?=
 =?utf-8?B?amthNkoyQkRQM0FxN1hPbWpmZXNoMzE3RGhOU1M3U0s2OEs5L1VnSzJkT1FK?=
 =?utf-8?B?WW5aVlppNUNjVHdHb2YyVC8wWHFBalJrNjZCU00zbVNEN3RYeTJYR2NWVUZT?=
 =?utf-8?B?ZGhMSWtYOVFKMytuNGhvS2szaTJsT2tpajZ1bUllZGNTNFRFdkRncjdmcEJz?=
 =?utf-8?B?d1RIdE0zaXd5cDR6RFlCeEJ1Z3JxVFVSZllvWDBUbUEyaDRzN0hmK3llMDlW?=
 =?utf-8?B?dXZzWWFkYXB2NjNXL1Frc3h4SVhGWFlTR1lIa2lLNDZJWEtuRWM2V1lhaGZv?=
 =?utf-8?B?bGx0dkk0YWZvL0JoVjFSeEtPaE9RTURpLzFETmFRRFloOWtQZENtQWJrclhn?=
 =?utf-8?B?azRwMnI0dHBzbGpmcTdNeWRyamo4NHNySXpPR2o4R0hWcERlMGFVWS84Y2Iy?=
 =?utf-8?B?TlM1YU5GY2pKT1FwNTFpUXFpa1VlTm0rZTJxWGdwcmcvRUM5TVhhUDFFY2oy?=
 =?utf-8?B?WVdDRkM2UG9lY1dCS1ZwMVkwRmx1eUxGTi9DczZSbmx3bDhqMVNCblZmbGEw?=
 =?utf-8?B?VjhrWE9UMk9HSytacWdJYXVqU0VOUFlLNm55TkJPMkhIemw2VDBvWEZLbys3?=
 =?utf-8?B?WWV6RDN2SGtKaG1OQ3VCcEs2ejlHRFU3WGI0bHFsM24rdUwyYjVsRlNhUDM1?=
 =?utf-8?B?MC9zUHhBMkRqWmRQbkNiNUs0d0dQeUxOZE8zNWhBWjFxQWUvUk9OVURPc1pV?=
 =?utf-8?B?Ym03TVhUbjBuMk15M3MzVzFZVDd2aFV3TExvT0dMMlpIblBFY29QTVNkdVMv?=
 =?utf-8?B?RE1rL1JIMnh0NlZFcnQ2Mkh3S3hzaG1IdlpBUURXaDhhOFVTK203TG1xd25h?=
 =?utf-8?B?UFBnNTV4NDhRbGtXMUR2bDc5M3BGRy9saFpITGZUWnlkTFo2VS82UGlxZmN4?=
 =?utf-8?B?RENLQzY3WFBNTXJXWEtTWG1PQk9kc2VnWDNkNUJ3WmJwK01jams3SEVSaHVz?=
 =?utf-8?B?U0FLUGFQME5BVGZ4ZmJxTi91ejhXVExDaVRzamNzSHl4ZjFUYUJCanovN29s?=
 =?utf-8?B?OTV2dmludi9xZG90OFBybVd5S1lFWGZUVHZiWVdQK3VqbWZhVFE0QzVydHRE?=
 =?utf-8?B?bzQ1TnV3ZkRvd01pd29kQnZwRS96OEpab0xuTUJHL3ZFd3FpU1hpL0RJU3V4?=
 =?utf-8?B?OXNaSHVhdnVMekVGYTNFajZEZmhLWjRxczVZY0lEc3lpVURjd1A2NG8zOTVU?=
 =?utf-8?B?RXQ4VlNFejlKTmw2czNrbVdyVEFGdHBXY2xQU3RoVFlmMlowOGdXTDdXWVBm?=
 =?utf-8?B?K1dRbzFIMVVQU2h6MVpXb1RIMW5SbXRuRGtLSUVUaXNzVjN4S1k1cTU5RHhX?=
 =?utf-8?B?b3YzcThoSU5LQ0pneU9VaUIzSFUvVXRpd0JhQmdibnNJUXZWRElNUkxCMUxM?=
 =?utf-8?B?ZlQ5dHNUSXVIcDZFS2NzNVM1SVdybzdRMHN0UWl5S281dmZ1WGVGdXcwRDlo?=
 =?utf-8?B?NlV5N0x1Z1FOS3o2VlR1d0VHcTIwckhSRUgvQUtUUWkvMUlvTGd0WDJNeFhF?=
 =?utf-8?B?U0pBSjdBVFBOaytsajRqb05HQTJicVl4cThZYURpcUlIT29idE1xOTVhOTJY?=
 =?utf-8?B?U3IrZm05VG5tL2l4RDlBeE43d3N3WmpEdjBKc0JGYlJmVnFRTTZ0eEYzamsx?=
 =?utf-8?B?ak5yZVZTdEhFMGNEV2xaTWdDc1cwNk90YUFhaE1VUGFBYmRLRTlkVmltdzVz?=
 =?utf-8?B?c3JFZVBMbUhNQ0ZETzhvLzFKMU5kQjN4bW15SnU1MTBiUFJtZjFybzUzMkh0?=
 =?utf-8?B?ZW5qQVRuUUs1SVNBZnp6YkMwWWMxRHJBRk1BMGRTejhVSlZCWWlOSEZGTVVM?=
 =?utf-8?B?Rzl0ZDdUdjAzVjB1RVhMMjVzRVdyZEhTQ0Y4YzJBWXhmZXB2eGxRaDNwTCsv?=
 =?utf-8?B?Um9yM1QybkpmNlVEOFhmNXR5ZTdYZDhmL1hLdjhNdGJjbkVqZUxFSnh1RXhE?=
 =?utf-8?B?OHNERXlxdVlCckpaZWRZOEhwanBJVklPRVo0ckVvcUtrWkd4WjVhZ09vV0hm?=
 =?utf-8?B?SEZ6RGRrZnFuajFRWXk2ZGFqZEU0SXJvTjVJMkFuZlVnWVhsdWNzSmlLSm1w?=
 =?utf-8?Q?3Lo/sqw0sFjWulefsoc7S8itQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5836e928-ba93-46e4-a545-08daa04f23ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 06:11:39.2346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBehBnypGyfaH9/VFlu5UG/PwtOG08runb0KtY43pg4dXiFdxExP1pACuTGLw9ns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.09.22 um 23:40 schrieb Shashank Sharma:
> This patch and switches the GPU workload based profile based
> on the workload hint information saved in the workload context.
> The workload profile is reset to NONE when the job is done.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c |  4 ----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h          |  3 +++
>   4 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index b7bae833c804..de906a42144f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -237,6 +237,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   		goto free_all_kdata;
>   	}
>   
> +	p->job->workload_mode = p->ctx->workload_mode;
> +
>   	if (p->uf_entry.tv.bo)
>   		p->job->uf_addr = uf_offset;
>   	kvfree(chunk_array);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> index a11cf29bc388..625114804121 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> @@ -55,15 +55,11 @@ int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>   
>   	mutex_lock(&adev->pm.smu_workload_lock);
>   
> -	if (adev->pm.workload_mode == hint)
> -		goto unlock;
> -
>   	ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>   	if (!ret)
>   		adev->pm.workload_mode = hint;
>   	atomic_inc(&adev->pm.workload_switch_ref);
>   
> -unlock:
>   	mutex_unlock(&adev->pm.smu_workload_lock);
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index c2fd6f3076a6..9300e86ee7c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -30,6 +30,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_reset.h"
> +#include "amdgpu_ctx_workload.h"
>   
>   static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   {
> @@ -144,6 +145,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   {
>   	struct amdgpu_job *job = to_amdgpu_job(s_job);
> +	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
> +
> +	if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
> +		if (amdgpu_clear_workload_profile(ring->adev, job->workload_mode))
> +			DRM_WARN("Failed to come out of workload profile %s\n",
> +				amdgpu_workload_profile_name(job->workload_mode));
> +		job->workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
> +	}
>   
>   	drm_sched_job_cleanup(s_job);
>   
> @@ -256,6 +265,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
>   	}
>   
> +	if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
> +		if (amdgpu_set_workload_profile(ring->adev, job->workload_mode))
> +			DRM_WARN("Failed to set workload profile to %s\n",
> +				  amdgpu_workload_profile_name(job->workload_mode));
> +	}
> +
>   	job->job_run_counter++;
>   	amdgpu_job_free_resources(job);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index babc0af751c2..573e8692c814 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -68,6 +68,9 @@ struct amdgpu_job {
>   	/* job_run_counter >= 1 means a resubmit job */
>   	uint32_t		job_run_counter;
>   
> +	/* workload mode hint for pm */
> +	uint32_t		workload_mode;
> +
>   	uint32_t		num_ibs;
>   	struct amdgpu_ib	ibs[];
>   };

