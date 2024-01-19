Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D97C4725D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 20:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF23010EA89;
	Fri, 19 Jan 2024 20:23:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB7F10EA6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 20:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMAHTCYa6HeODu3IZQXnp9oUaoiAyseSuZpaH8xWmtN27mRZlNEDSylhQv2cWYHpZzaVnaJr4jMTeNumgLnLAg/udxSJN/ozESeBbILBAQvp7rer3fG+G2Kvg+4tjD7Z3/00UjwP4296tHr7hWlfN5LyGA6sY0DSceok0ShzyoILcY0EPGa+ej01j4powX9g7QAThq+qZTb25VcNy2qTKCVf/xuloV/KtqyoIb/rNcT95fuE0qfxqSHOXYS89tluQ7xdGLvELIOKpy5msnUvXJh5K/52YOaf/JHkhF7ZqRNMqKennMOPvQkW6ZPfY14W+TltMMMIEinsCoeTtYikow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXWbafwtdIQJzWuVVfY+ACy+cDAl3ZK+LqNldKKY2DY=;
 b=MOl40IEhLp0tkGWh2B//vibRzzZb5z/EYifQq6hCfqb+YvizEMCECKOVP5nuSYFMRh0OI/FWm8aUqrwPb5mU9jvKRrsvqn9/hBQY3UvWrWxmYjc+W7brDx4N3Df9EdX/rNMh0umjcUSYtyBT7MdUApNRANDvYdmvNznN9l855gkjj2MYFjrEnub8ELGc3R8BKcxfeg5+n2LK6Sh7NtPhpU4bEJZeuaDpXf0FU24AZONgL9xy0m0xXt7hbhn+iadhUn3f6F9dP1C0HPFYJdhUzYKHmFXhiC3LQUJ/vBGofKwr7cJryYWqFWtsrX3uB6n4CGuWRUkQda+mOgEmib1hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXWbafwtdIQJzWuVVfY+ACy+cDAl3ZK+LqNldKKY2DY=;
 b=2pk200cr0Trq47QJxzAMbXm046U0NQLqNkQ6AdQKZUnh7JzWLb6+7iFfkPPX0CiYbrAMuEc76JkappERGmibUjXlJkN5QGXuitZSRWEO+TsHhYUcr2GVXaSQcom12T819TGHnI2BpZj54kD0ZI/+/laE5adS9JFrmRe2F8wUtTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 20:23:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 20:23:14 +0000
Message-ID: <83155aae-3bb2-48ed-bcfc-48bd02bbcec6@amd.com>
Date: Fri, 19 Jan 2024 15:23:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: change vm->task_info handling
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240118192104.147-1-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240118192104.147-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ecad68-70cb-4068-c122-08dc192c76e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nwl/08rY2a14PvzKEVDwwxEpXbaVXs+GA3RlxHk+4AJxvLp4QyTMSzhWjQERPZSCblSgNqxsuBv7hZRy3/HdrHyXt8TMHkOPbibLkEH3nPKb4NoMmtz/JX/lT2ukdowiPOOPUqsbpT9LMMgoJAzuwKjd6uTDUnob4hHsat18lPAHSWJGxmgk3Avd6Gb+SFpsK0R7rJr8GSI/VHYGApJBdaHeuj5QWcugSyrN1ACW2vUUYmDf1aUpmg8SUAsoGcEGuLMDpvPj37/1ugo8gRBRjEMM52mMKqqSGberCy71eC79cBYFGXImNBMpXlBfvzfpIuve82vKSf4AESKRGvpZfmgUSQLZJ8VtkK2fBV8eRggO3JvuP7jaukU7735NLDQgg5zGdYJxxXHzmKulo/MU3Xl1Cxrb6x16lu5D/mHbGeKIMbSCMwA8bqpieIzoEzirV+cST4qEuBS1WQdtLIoKz/O2se5aAs6ULZ/7AJ5nS0eaTvYkA1lnuZsDX7iQ4a3v/N02U8g92hfmtu7gBZMuVpuH8yaoWC7TyxKD6zzHCkKlcsOOiDjl4Hwb3OImQs8NEaf19rPUUOLyn1+yFqlEWHj586fc+80ZT26UFdFk1rd4knZaIkT7c3sKWcB8r3eFoN7N8WzCybbUEdNsxJE7Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(44832011)(5660300002)(2906002)(38100700002)(4326008)(26005)(2616005)(53546011)(6512007)(31696002)(86362001)(31686004)(30864003)(36756003)(66476007)(41300700001)(66946007)(8936002)(316002)(8676002)(54906003)(36916002)(478600001)(6506007)(66556008)(6486002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzBUSTZwcUlDaHBPOHcrVGxZL3kvUkpia1ZUamZvS29aUW1nZmcvYm1VNHJv?=
 =?utf-8?B?Q2p6bDhya3ZKZkNKTlMra2VqVWZjc0w3RU5ZMU84SUpZTEtuYlA3VnF2dVlh?=
 =?utf-8?B?VGVuTGxSakZ3czFkeHU0SDZHdDVpUFFHZmNLOUM5VWVtYlpVcVluOEY4LzVl?=
 =?utf-8?B?L05yYWdidURYd3ZodmJwQVJWejVFOTlpM0svY2lHNFgxSHBWT09oUmdSZWNz?=
 =?utf-8?B?QWF0cmZOMTRkT0V0YTF5YVljeExWWVNsb3FacnVaR0gxaENKaHY4azVJZWhD?=
 =?utf-8?B?bTQ5K2dPMW9aMTNGWTlWZVRuTWM3cjRmeWJ1WG93aEhDNW5ycUxxZ1FaZGVC?=
 =?utf-8?B?eitUamRlUDFnaXh6N3hIbXlKeTdOSVo0MnVTN0xTNGI3WGY0c0dTTzVueUhF?=
 =?utf-8?B?WHY1R3BISTVIT2MyamM5QWM2SWJDS3JNODA4a0RHRHQzcEcwMXc5T1V0S3I2?=
 =?utf-8?B?OVRHTWtYY1k2NVBBQVVUbldGQ1hESUs3U0tEUVZlSTdVTmkxNHlBTk9QOTlM?=
 =?utf-8?B?WW92alBtVjFqcnZ2N3llZGplTk1HNjd3WWxrOFVZSHpTMTBXYU9mb0VtT0pD?=
 =?utf-8?B?aUcyRkdBZWRsYnIyVDZoMytEcnlqbWJaaHNBWFRya00yUzZIUnUvQjhEaVF3?=
 =?utf-8?B?LzJnNlpja1daSFdkamU3cW9mQ2VkSklSRW82RnVwUnlhMGgvOHI3RGdGMW5B?=
 =?utf-8?B?RUhjcGxseVN2YTJGdkFqUUNuZ3Q2U21hcllFZ0tIclNHa1ZQd1MxamNQSjZM?=
 =?utf-8?B?THhBRHJmYm9aQ0NZQmdjYTRpcGFUeG1TaG9TcXJiZ0xnUlVCNmtKT2RYQmpo?=
 =?utf-8?B?Z2VmTmluR3B2RE83d0kraE8wbTk5QnZvYU0rUFB6QmlQUmdKZUtTdlV5SXVz?=
 =?utf-8?B?d0kyZndJSmpmWjNTSzB4MEh3aDA3b1IxTmN0QzJOcWFXTkRMaXRJeWIvZmNn?=
 =?utf-8?B?ZWZTM1ZMY0Y2QmU0eGMrTWZULzk1RU1iQkQ5ZEI1NEp6L2t6V3ZtdllMZElS?=
 =?utf-8?B?SHQxWlJDSW5kZHZsc3JsSTF3OGdqaWpZVHM4eEdWQ0x3V0FtQ2ZzK2VtQzAr?=
 =?utf-8?B?Wndtc2VhQ2FDUmlYelR0MzdxQ0hxamhBdVd4VldYZ3BlWTVxL3VXZkJUWlZL?=
 =?utf-8?B?VnhXaGVvM2ZtVmp6YWFPQjdvNHl3UXEveW5iZ0pHOXhDSEFlK2J0dm01S0xD?=
 =?utf-8?B?dmI2Ulg5eFZNUmx5YlNoaHI1UmNWb1QzdWhZNHJjazZYNzZCZnljT3J1NXRY?=
 =?utf-8?B?endRYlg1QTBPOFkwSHMzLzZ0MW92UlFGQ1lkaTNVanB2Z0RSTEJNbFU3WE9a?=
 =?utf-8?B?YnBzMlk2Qnl4dHZrdXY2SFFUcGE1NGt0Mkk1WjNtZjBmRS9wbHdUaVFoaW1K?=
 =?utf-8?B?ZEs4NEtRVUZWMGVWSTc5ZVpmcXBPbzRLK0xJVVdUZnJMcXpJeTF0UGtiYkhj?=
 =?utf-8?B?WlNGMXNoT1dWL0gzK1lOOWRSbXZFT1RyaFlPeGhFVnZmbWx3ZDI5SW5CeE45?=
 =?utf-8?B?Qm1vYUxhQXlON3ViSDR0QUFNV1QybStNUEluV0JtVHlPMDhHcjZJbmxMWkNX?=
 =?utf-8?B?Rk1VcVlqcG1EZEM1K0ljL3RvTWR3N1RsZFFwcE9ESzVVelBCMktPSFdCT0NV?=
 =?utf-8?B?bUtwWjVRM1NmSHhPSE1UcFd3aFNnYjFaK21TRitNNG9CVmdYMlhKZHJVRmlm?=
 =?utf-8?B?WHU4end1ZHFIQlFKUzdseWZuOTBuZXVPQmdCcGZkeEZ6cnUreVluSUdsM0k0?=
 =?utf-8?B?NTY5SWNlRmtxMGtad2FNNGlDaWNlZnkvaHo2UFdaaVh6QzVPN3ppWG1TYldj?=
 =?utf-8?B?anBNRHI3VXB2Yk5DdGdTQUc2Mml0WGVwL280b2lUcGliY3U1d2NCQ0YxaGNp?=
 =?utf-8?B?eUZFMUtnY1lrZzQwUHNySUJ3ZDEwbnZwWEFJdEFMemNBeWtXcTc0eU90WkZF?=
 =?utf-8?B?VCs3VXBVL2o3enpwM1dCb1lJYmRWQktDT3l5bEgwdndFQUpOS0FmL0dvZXhS?=
 =?utf-8?B?eHZ4QjZGbmdLb0lKbmpmOUhuNEJDVHJWb2JLSlR3cDFiUXZqTXFERllTVGdH?=
 =?utf-8?B?dTVTSmt2MXhnMTRQRWJUVXBvcWUzVDloQVhzelBMNndQZG52cXpDQ2JnS25B?=
 =?utf-8?Q?ipV94iw3/f7aKka1ejkIfgGSG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ecad68-70cb-4068-c122-08dc192c76e6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 20:23:14.5113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfLwfwJD99Cqhnt9GQ+ACsBPe5rmzvHRCykLlAWEY+MAQ91ztYjTPuXEOH3wuNdq8K45pPcJwpQ3jRH3ES/kYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2024-01-18 14:21, Shashank Sharma wrote:
> This patch changes the handling and lifecycle of vm->task_info object.
> The major changes are:
> - vm->task_info is a dynamically allocated ptr now, and its uasge is
>    reference counted.
> - introducing two new helper funcs for task_info lifecycle management
>      - amdgpu_vm_get_task_info: reference counts up task_info before
>        returning this info
>      - amdgpu_vm_put_task_info: reference counts down task_info
> - last put to task_info() frees task_info from the vm.
>
> This patch also does logistical changes required for existing usage
> of vm->task_info.
>
> V2: Do not block all the prints when task_info not found (Felix)
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Nit-picks inline.


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  18 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 142 +++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  26 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  30 +++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  31 +++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  22 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  26 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  26 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  26 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  20 +--
>   13 files changed, 287 insertions(+), 101 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0e61ebdb3f3e..99c736b6e32c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1775,9 +1775,12 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>   	list_for_each_entry(file, &dev->filelist, lhead) {
>   		struct amdgpu_fpriv *fpriv = file->driver_priv;
>   		struct amdgpu_vm *vm = &fpriv->vm;
> +		struct amdgpu_task_info *ti;
> +
> +		ti = amdgpu_vm_get_task_info_vm(vm);

Can ti be NULL here? I think it can, so you'd need a NULL check to avoid 
a possible kernel oops.


> +		seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti->pid, ti->process_name);
> +		amdgpu_vm_put_task_info_vm(ti, vm);
>   
> -		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
> -				vm->task_info.pid, vm->task_info.process_name);
>   		r = amdgpu_bo_reserve(vm->root.bo, true);
>   		if (r)
>   			break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 1f357198533f..af23746821b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -35,7 +35,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   {
>   	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>   	struct amdgpu_job *job = to_amdgpu_job(s_job);
> -	struct amdgpu_task_info ti;
> +	struct amdgpu_task_info *ti;
>   	struct amdgpu_device *adev = ring->adev;
>   	int idx;
>   	int r;
> @@ -48,7 +48,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		return DRM_GPU_SCHED_STAT_ENODEV;
>   	}
>   
> -	memset(&ti, 0, sizeof(struct amdgpu_task_info));
> +
>   	adev->job_hang = true;
>   
>   	if (amdgpu_gpu_recovery &&
> @@ -58,12 +58,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		goto exit;
>   	}
>   
> -	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
>   	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
> -		  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
> -		  ring->fence_drv.sync_seq);
> -	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
> -		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
> +			  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
> +			  ring->fence_drv.sync_seq);

Unnecessary (and incorrect) indentation change.


> +
> +	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
> +	if (ti) {
> +		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
> +			  ti->process_name, ti->tgid, ti->task_name, ti->pid);
> +		amdgpu_vm_put_task_info_pasid(ring->adev, ti, job->pasid);
> +	}
>   
>   	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 4baa300121d8..bfd7a6067edd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -230,8 +230,16 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
>   
>   	coredump->reset_vram_lost = vram_lost;
>   
> -	if (reset_context->job && reset_context->job->vm)
> -		coredump->reset_task_info = reset_context->job->vm->task_info;
> +	if (reset_context->job && reset_context->job->vm) {
> +		struct amdgpu_task_info *ti;
> +		struct amdgpu_vm *vm = reset_context->job->vm;
> +
> +		ti = amdgpu_vm_get_task_info_vm(vm);
> +		if (ti) {
> +			coredump->reset_task_info = *ti;
> +			amdgpu_vm_put_task_info_vm(ti, vm);
> +		}
> +	}
>   
>   	coredump->adev = adev;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index d1b8afd105c9..0c95e10c815d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2347,6 +2347,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> +	if (vm->task_info)
> +		amdgpu_vm_put_task_info_vm(vm->task_info, vm);
> +
>   	flush_work(&vm->pt_free_work);
>   
>   	root = amdgpu_bo_ref(vm->root.bo);
> @@ -2507,26 +2510,129 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	return 0;
>   }
>   
> +static void amdgpu_vm_destroy_task_info(struct kref *kref)
> +{
> +	struct amdgpu_task_info *ti = container_of(kref, struct amdgpu_task_info, refcount);
> +
> +	kfree(ti);
> +}
> +
> +static inline struct amdgpu_vm *
> +amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
> +{
> +	struct amdgpu_vm *vm;
> +	unsigned long flags;
> +
> +	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +
> +	return vm;
> +}
> +
> +/**
> + * amdgpu_vm_put_task_info_pasid - reference down the vm task_info ptr
> + * frees the vm task_info ptr at the last put
> + *
> + * @adev: drm device pointer
> + * @task_info: task_info struct under discussion.
> + * @pasid: pasid of the VM which contains task_info
> + */
> +void amdgpu_vm_put_task_info_pasid(struct amdgpu_device *adev,
> +				   struct amdgpu_task_info *task_info,
> +				   u32 pasid)
> +{
> +	int ret;
> +
> +	ret = kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
> +
> +	/* Clean up if object was removed in the last put */
> +	if (ret == 1) {
> +		struct amdgpu_vm *vm;
> +
> +		vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
> +		if (!vm) {
> +			WARN(1, "Invalid PASID %u to put task info\n", pasid);
> +			return;
> +		}
> +
> +		vm->task_info = NULL;

This doesn't make sense. If there is a VM pointing to the task_info, 
then the ref count should not go to 0. Therefore this whole "look up the 
VM from PASID and clear vm->task_info" seams bogus.

I'd expect the last put_task_info call to come from amdgpu_vm_fini. At 
that point setting task_info to NULL is probably unnecessary. But if we 
wanted that, we could set it to NULL in the caller.


> +	}
> +}
> +
> +/**
> + * amdgpu_vm_put_task_info_vm - reference down the vm task_info ptr
> + * frees the vm task_info ptr at the last refdown
> + *
> + * @task_info: task_info struct under discussion.
> + * @vm: VM which contains task_info
> + */
> +void amdgpu_vm_put_task_info_vm(struct amdgpu_task_info *task_info, struct amdgpu_vm *vm)
> +{
> +	int ret;
> +
> +	ret = kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
> +
> +	/* Clean up if object was removed in the last put */
> +	if (ret == 1)
> +		vm->task_info = NULL;

Similar to above: If a VM is pointing to task_info, the ref count should 
not be 0.

That means, you can merge the two functions into a single 
amdgpu_vm_put_task_info. No need for a pasid or vm parameter.


> +}
> +
>   /**
> - * amdgpu_vm_get_task_info - Extracts task info for a PASID.
> + * amdgpu_vm_get_task_info_pasid - Extracts task info for a PASID.
>    *
>    * @adev: drm device pointer
>    * @pasid: PASID identifier for VM
> - * @task_info: task_info to fill.
> + *
> + * Returns the respective task_info structure, which must be referenced
> + * down with amdgpu_vm_put_task_info.
>    */
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
> -			 struct amdgpu_task_info *task_info)
> +struct amdgpu_task_info *
> +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
>   {
>   	struct amdgpu_vm *vm;
> -	unsigned long flags;
> +	struct amdgpu_task_info *ti = NULL;
>   
> -	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +	vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
> +	if (vm) {
> +		ti = vm->task_info;
> +		kref_get(&vm->task_info->refcount);
> +	}
>   
> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
> -	if (vm)
> -		*task_info = vm->task_info;
> +	return ti;
> +}
>   
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +/**
> + * amdgpu_vm_get_task_info_vm - Extracts task info for a vm.
> + *
> + * @vm: VM to get info from
> + *
> + * Returns the respective task_info structure, which must be referenced
> + * down with amdgpu_vm_put_task_info.
> + */
> +struct amdgpu_task_info *
> +amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
> +{
> +	struct amdgpu_task_info *ti = NULL;
> +
> +	if (vm) {
> +		ti = vm->task_info;
> +		kref_get(&vm->task_info->refcount);
> +	}
> +
> +	return ti;
> +}
> +
> +static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
> +{
> +	vm->task_info = kzalloc(sizeof(struct amdgpu_task_info), GFP_KERNEL);
> +	if (!vm->task_info) {
> +		DRM_ERROR("OOM while creating task_info space\n");

Printing OOM error messages is usually redundant. The allocators are 
already very noisy when OOM happens. I think checkpatch.pl also warns 
about that. Maybe it doesn't catch DRM_ERROR but only printk and friends.


> +		return -ENOMEM;
> +	}
> +
> +	kref_init(&vm->task_info->refcount);
> +	return 0;
>   }
>   
>   /**
> @@ -2536,17 +2642,23 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>    */
>   void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   {
> -	if (vm->task_info.pid)
> +	if (!vm->task_info) {
> +		if (amdgpu_vm_create_task_info(vm))
> +			/* OOM */
> +			return;
> +	}
> +
> +	if (vm->task_info->pid == current->pid)
>   		return;
>   
> -	vm->task_info.pid = current->pid;
> -	get_task_comm(vm->task_info.task_name, current);
> +	vm->task_info->pid = current->pid;
> +	get_task_comm(vm->task_info->task_name, current);
>   
>   	if (current->group_leader->mm != current->mm)
>   		return;
>   
> -	vm->task_info.tgid = current->group_leader->pid;
> -	get_task_comm(vm->task_info.process_name, current->group_leader);
> +	vm->task_info->tgid = current->group_leader->pid;
> +	get_task_comm(vm->task_info->process_name, current->group_leader);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 2cd86d2bf73f..c693772f8942 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -190,10 +190,11 @@ struct amdgpu_vm_pte_funcs {
>   };
>   
>   struct amdgpu_task_info {
> -	char	process_name[TASK_COMM_LEN];
> -	char	task_name[TASK_COMM_LEN];
> -	pid_t	pid;
> -	pid_t	tgid;
> +	char		process_name[TASK_COMM_LEN];
> +	char		task_name[TASK_COMM_LEN];
> +	pid_t		pid;
> +	pid_t		tgid;
> +	struct kref	refcount;
>   };
>   
>   /**
> @@ -356,7 +357,7 @@ struct amdgpu_vm {
>   	uint64_t		pd_phys_addr;
>   
>   	/* Some basic info about the task */
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   
>   	/* Store positions of group of BOs */
>   	struct ttm_lru_bulk_move lru_bulk_move;
> @@ -492,8 +493,19 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>   				  struct amdgpu_job *job);
>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>   
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
> -			     struct amdgpu_task_info *task_info);
> +struct amdgpu_task_info *
> +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid);
> +
> +void amdgpu_vm_put_task_info_pasid(struct amdgpu_device *adev,
> +				   struct amdgpu_task_info *task_info,
> +				   u32 pasid);
> +
> +struct amdgpu_task_info *
> +amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
> +
> +void amdgpu_vm_put_task_info_vm(struct amdgpu_task_info *task_info,
> +				   struct amdgpu_vm *vm);
> +
>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   			    u32 vmid, u32 node_id, uint64_t addr,
>   			    bool write_fault);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a160265ddc07..d9e895cb0c10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -1027,7 +1027,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>   						    min(nptes, 32u), dst, incr,
>   						    upd_flags,
> -						    vm->task_info.tgid,
> +						    vm->task_info ? vm->task_info->tgid : 0,
>   						    vm->immediate.fence_context);
>   			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>   						   cursor.level, pe_start, dst,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index a5a05c16c10d..e00b2a53b192 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -105,7 +105,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>   	bool retry_fault = !!(entry->src_data[1] & 0x80);
>   	bool write_fault = !!(entry->src_data[1] & 0x20);
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	uint32_t status = 0;
>   	u64 addr;
>   
> @@ -157,18 +157,26 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   	if (!printk_ratelimit())
>   		return 0;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {
> +		dev_err(adev->dev,
> +			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +			entry->vmid_src ? "mmhub" : "gfxhub",
> +			entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid, task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +	} else {
> +		dev_err(adev->dev,
> +			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, no process info)\n",
> +			entry->vmid_src ? "mmhub" : "gfxhub",
> +			entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid);

Can we avoid the duplication here? It's too easy for them to get out of 
sync. I think it's OK to change the message format so that the process 
into is printed on a separate line. E.g.:

  	dev_err(adev->dev,
-		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
+		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
  		entry->vmid_src ? "mmhub" : "gfxhub",
  		entry->src_id, entry->ring_id, entry->vmid,
-		entry->pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
+ 		entry->pasid);
+	if (task_info) {
+		dev_err(adev->dev, "  in process %s pid %d thread %s pid %d\n",
+			task_info.process_name, task_info.tgid,
+			task_info.task_name, task_info.pid);
+	}


> +	}
>   
> -	dev_err(adev->dev,
> -		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> -		entry->vmid_src ? "mmhub" : "gfxhub",
> -		entry->src_id, entry->ring_id, entry->vmid,
> -		entry->pasid, task_info.process_name, task_info.tgid,
> -		task_info.task_name, task_info.pid);
>   	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
> -		addr, entry->client_id,
> -		soc15_ih_clientid_name[entry->client_id]);
> +			addr, entry->client_id,
> +			soc15_ih_clientid_name[entry->client_id]);
>   
>   	if (!amdgpu_sriov_vf(adev))
>   		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 23d7b548d13f..3dda6c310729 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -126,19 +126,28 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>   	}
>   
>   	if (printk_ratelimit()) {
> -		struct amdgpu_task_info task_info;
> -
> -		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +		struct amdgpu_task_info *task_info;
> +
> +		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +		if (task_info) {
> +			dev_err(adev->dev,
> +				"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +				entry->vmid_src ? "mmhub" : "gfxhub",
> +				entry->src_id, entry->ring_id, entry->vmid,
> +				entry->pasid, task_info->process_name, task_info->tgid,
> +				task_info->task_name, task_info->pid);
> +			amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +		} else {
> +			dev_err(adev->dev,
> +				"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, no process info)\n",
> +				entry->vmid_src ? "mmhub" : "gfxhub",
> +				entry->src_id, entry->ring_id, entry->vmid,
> +				entry->pasid);
> +		}

Same as above.


>   
> -		dev_err(adev->dev,
> -			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> -			entry->vmid_src ? "mmhub" : "gfxhub",
> -			entry->src_id, entry->ring_id, entry->vmid,
> -			entry->pasid, task_info.process_name, task_info.tgid,
> -			task_info.task_name, task_info.pid);
>   		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
> -			addr, entry->client_id);
> +				addr, entry->client_id);
> +
>   		if (!amdgpu_sriov_vf(adev))
>   			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index ff4ae73d27ec..aa3887c3bb35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1444,18 +1444,24 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>   		gmc_v8_0_set_fault_enable_default(adev, false);
>   
>   	if (printk_ratelimit()) {
> -		struct amdgpu_task_info task_info;
> -
> -		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +		struct amdgpu_task_info *task_info;
> +
> +		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +		if (task_info) {
> +			dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
> +				entry->src_id, entry->src_data[0], task_info->process_name,
> +				task_info->tgid, task_info->task_name, task_info->pid);
> +			amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +		} else {
> +			dev_err(adev->dev, "GPU fault detected: %d 0x%08x (no process info)\n",
> +				entry->src_id, entry->src_data[0]);
> +		}
Same as above.


>   
> -		dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
> -			entry->src_id, entry->src_data[0], task_info.process_name,
> -			task_info.tgid, task_info.task_name, task_info.pid);
>   		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
> -			addr);
> +				addr);
>   		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
>   			status);
> +
>   		gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
>   					 entry->pasid);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 2ac5820e9c92..075d633109e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -549,7 +549,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	bool retry_fault = !!(entry->src_data[1] & 0x80);
>   	bool write_fault = !!(entry->src_data[1] & 0x20);
>   	uint32_t status = 0, cid = 0, rw = 0;
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	struct amdgpu_vmhub *hub;
>   	const char *mmhub_cid;
>   	const char *hub_name;
> @@ -626,15 +626,23 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	if (!printk_ratelimit())
>   		return 0;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {
> +		dev_err(adev->dev,
> +			"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +			hub_name, retry_fault ? "retry" : "no-retry",
> +			entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid, task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +	} else {
> +		dev_err(adev->dev,
> +			"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, no process info)\n",
> +			hub_name, retry_fault ? "retry" : "no-retry",
> +			entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid);
> +	}
Same as above.


>   
> -	dev_err(adev->dev,
> -		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> -		hub_name, retry_fault ? "retry" : "no-retry",
> -		entry->src_id, entry->ring_id, entry->vmid,
> -		entry->pasid, task_info.process_name, task_info.tgid,
> -		task_info.task_name, task_info.pid);
>   	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
>   		addr, entry->client_id,
>   		soc15_ih_clientid_name[entry->client_id]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 3d68dd5523c6..515d1a1ff141 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2104,7 +2104,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
>   					      struct amdgpu_iv_entry *entry)
>   {
>   	int instance;
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	u64 addr;
>   
>   	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
> @@ -2116,15 +2116,23 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
>   	addr = (u64)entry->src_data[0] << 12;
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {
> +		dev_dbg_ratelimited(adev->dev,
> +			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> +			"pasid:%u, for process %s pid %d thread %s pid %d\n",
> +			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid, task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +	} else {
> +		dev_dbg_ratelimited(adev->dev,
> +			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> +			"pasid:%u, no process info\n",
> +			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid);
> +	}
Same as above.


>   
> -	dev_dbg_ratelimited(adev->dev,
> -		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> -		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
> -		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> -		   entry->pasid, task_info.process_name, task_info.tgid,
> -		   task_info.task_name, task_info.pid);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 0f24af6f2810..d7e23bd90f7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1642,7 +1642,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>   					      struct amdgpu_iv_entry *entry)
>   {
>   	int instance;
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	u64 addr;
>   
>   	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
> @@ -1654,15 +1654,23 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>   	addr = (u64)entry->src_data[0] << 12;
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {
> +		dev_dbg_ratelimited(adev->dev,
> +			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> +			"pasid:%u, for process %s pid %d thread %s pid %d\n",
> +			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid, task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +	} else {
> +		dev_dbg_ratelimited(adev->dev,
> +			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> +			"pasid:%u (no process info)\n",
> +			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid);
> +	}
Same as above.

Regards,
   Felix


>   
> -	dev_dbg_ratelimited(adev->dev,
> -		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> -		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
> -		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> -		   entry->pasid, task_info.process_name, task_info.tgid,
> -		   task_info.task_name, task_info.pid);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index d9953c2b2661..0dfe4b3bd18a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -238,16 +238,16 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>   
>   void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
>   {
> -	struct amdgpu_task_info task_info;
> -
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
> -	/* Report VM faults from user applications, not retry from kernel */
> -	if (!task_info.pid)
> -		return;
> -
> -	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
> -			  task_info.pid, task_info.task_name);
> +	struct amdgpu_task_info *task_info;
> +
> +	task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
> +	if (task_info) {
> +		/* Report VM faults from user applications, not retry from kernel */
> +		if (task_info->pid)
> +			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
> +					 task_info->pid, task_info->task_name);
> +		amdgpu_vm_put_task_info_pasid(dev->adev, task_info, pasid);
> +	}
>   }
>   
>   void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
