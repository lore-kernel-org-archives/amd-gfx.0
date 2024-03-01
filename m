Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB18C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 17:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF8A10E67E;
	Fri,  1 Mar 2024 17:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l5uVsPFc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6451110E67E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 17:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctXiofp3XVMqDV+lySL+2ffvYPnUe/2u9ZgHu3kbeA5cMjCI3laT5eDXhsa07ib7PP5z4WdrEyOO1CrAArFuPk4fGpuYvGxdYvxt2esg84jlPVm97L2xL6IhiGh56g7Jld01xYQSE7d7z1hjdqwqfieCctbruD+v7rooSFZCYz0o+f64hDEjSTqvFHUZXMG9IrIWHevaKzLb+wpaMUGagMXve/K4LYwU/PXYn61qC/XzOenQB1AZ++UWdD5kxM4WNZlNCewf/u6DR8FzZvWP8m3zoZxJhHq1LmWX9vYFo3ZVa+hLSPpoZ3W9Seiw3TyrijfugzYoF/XRoXS7yg+L2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LKUpgGaxLqqw0MjpePrkvYHn4SHDGNbp62tmWM/7Ok=;
 b=GyiRTAzPDYMICU9K4EissJQ0UXuAQ3xXIUq5HZvqqAROIoxqoe1x9k1pKVGcvH1tO8zeZfidHl8v9cbUILMTMYyXei3s99bW0iJUs41DaOs0xx01SrREi7JenWxV3d3PDWsRg/KMDeGMbufWQrpLUAaPHxrxV31imcaBd+u/WgnNi4uCmHg3JMmdiBX83JY4SrIJIFH/ABmQFedcZCCVRzlaVwUoR0KquJKnq4zyG8llzNTF/1GyMCPvGocdRQid+PgWJW9Z1TcsCio6PpC4yzx9qfe8+0kmMRgaG6aT9k/oZSdYLL2Zg/YG3NexOq5NBGug2k0KB2nmYWs/GJJrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LKUpgGaxLqqw0MjpePrkvYHn4SHDGNbp62tmWM/7Ok=;
 b=l5uVsPFc+mgQdj9qTTFkKT8Fvorvc7VItkwChLHo5SZE6K8qPtAs3LDXD1w3+BofLHeczsisSR9WMcnGK+8LzXkzeqqls6K6snX0iLiQ+l/rLF52mp2KR3obRU91bmi76d03PZYw129pzkHjirEy3N9zr+89gF+f2z5hYOgCiHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 17:07:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 17:07:36 +0000
Content-Type: multipart/alternative;
 boundary="------------jXUmaj1Syub2BjtJzwAS30Uv"
Message-ID: <486845c4-192c-47e5-9a18-b1497578c260@amd.com>
Date: Fri, 1 Mar 2024 12:07:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: change vm->task_info handling
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240205170508.974-1-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240205170508.974-1-shashank.sharma@amd.com>
X-ClientProxiedBy: YT4PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fcd666-ee7e-499c-5ddd-08dc3a12180c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+3DSh00edqNbmeqtwdFnkHKSZFfhIcFfQqnG42VGJLySJKZ84csPHXhoZdnO0OQbJebaimnLUxqzBuzhTTnug4gF8YFsd1i4VcWrol5iXpN/Dcv10RgAWMNrYHFWXT0wHtjqoe+rB9Kh75XQT5OOLeb3v/SgD6kEbaiyYuw+VQcrs4p3q+1QJbcilHumYZ4k5++IhI4NSAjbBP7TgdlZpt+IdbCK1o/rkzrv0LD/j/gWFUxjpN8WTHTkED9T3txmlVA17qW5HgWwzJiD3l1t079jxUujbIbivgguCwsFoLYAPU09SNjOq6cnlx186GBKWKBrdtEC9EhptLebb2zNdXKdD5QszJ4e6vgt8BAXvxJBnfpoa1j4h1xByfysPAC+pAdzOBYqmMJbhwfOO5XYkgmN21IcS6XCnjn/7re0OB0HeBsjnisRhkfFCpFKDs8fqPH6b/25MbHDFnw/HR9XhM8bcM77TkueYjgVcZ6pXH8zJKj2mqARfGM3HpjDN/HWAk+uoAvm3qShzJ87JYmIhOY+4yyR5EOTHukafo6Did/yQ79HZKO1mEIIWTRlHW+Nf77+zNdV5zmSQT/bHjLTR7LFkQXZHBKNLHp1+5g131x6y7aggal5R5NPRqgGym4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU1xRXRJRzJYbnhZWW5wUExWWmxkOGNCOWU4SWQ0VERvTlJOS3VKNGF3emhE?=
 =?utf-8?B?ditkUWJVT3IzdStBK2szbFdKSkhsZEYrTzY3dGJMUTlwRFlNQjUweWtHTkl6?=
 =?utf-8?B?UzNUMGVxTllTbHR4am9WMjRlU3dnVzR1YVphSDZTaXV4Y3hyRGIzYmVCc3FW?=
 =?utf-8?B?YnV5aFROUGdiSHpOamFaaDl4dnNiNHRtbC9BTE0rdm12QzlrQnBhRk9INFdZ?=
 =?utf-8?B?eFZuQjZqUmxhdWJKeXhaYlY1eWRkdG1sbXlab2M4TUFqR2xEZTBSeDVrMTdI?=
 =?utf-8?B?TGMwaHpLWUczODgyM0ZpL1pDNndJblc2ZjE1M3ZXNENKL2tuSU9vcHdrU3Rk?=
 =?utf-8?B?c1JQR05QR2l1UGY0MUJHSGJ4M3Z1UTcwTDlvK3V6dm1TS29meVlIbWJmSS8v?=
 =?utf-8?B?ZXlyUjFxek1tOVFUYzhjWExhMkQvd0dkN2F6ckdob29tSXdtYTNYOUYyVjFm?=
 =?utf-8?B?WHFDcmtVVDFSYS9Kb3FCd1U0aWw5VUt5Rzl4Z3BoaG1oZGhzWGV5akF2RC9u?=
 =?utf-8?B?MER4N2hEdnB5WUMwL3FkS2R0bHJHN01laFVxTHAwcVB1cE9zbUNiQXhpOFVH?=
 =?utf-8?B?UEdJbFQzcVdHQjFySXBEYUpleDlIZDI3VTROUHdqYm1PSVkyZWdKT0tUa2RF?=
 =?utf-8?B?RlkrRVpmSHJZVFVjMy9JaEkxODNRU0JGeTA5VGFsc1JkNzcwVG5nTVJnL0U1?=
 =?utf-8?B?TjRNSFpJWnlPMEZ2U3lQUlBxVjk3Qll3OXd4Q09pMisyak9IL0lIVGhzekl3?=
 =?utf-8?B?aDBWVEUvYUxIOExSVENNYzh4Y09hSVZCR1BkenhsSHVTMXJpYWl1SnNWWE1M?=
 =?utf-8?B?ZDArdWx6VzdGTmlEVUpRZHNrbk55SkowbTdGL0VpeE5iMCtJYU9mdTZrdEZt?=
 =?utf-8?B?SWhrNXZoemp0K3ZYSHIrcDRLMHJ2RnRLWHF5NlgxRVZGbFVMdHIzYWc1NDRE?=
 =?utf-8?B?R2dNa0Zla20zV0FPNmJTQkE3QVJsK2o4SDFDS2hsL0cxRTZhNUluWG12dVBD?=
 =?utf-8?B?dFJlTCtQcTFkS2UzcXgyLzBteml1NDFneUtRT0w2VW9mWitza29qczh0UVNL?=
 =?utf-8?B?YzRHYVV1VTRaZXYyS3FJd3VacS9SWVhLVTB1eGJCL21DYmxSUHNJeitxQmlI?=
 =?utf-8?B?dVFUalJDZHNYMWxsbjRRR3E4Z010UnhHdkN2MkV1K3R6aTNOZUxQa2NPVjJL?=
 =?utf-8?B?UFFBcnJqSkYzTWU1Z1lJZzQyN2dBeHc5YTBnY2tiZ1BnejQ2K09oRFVkNGtM?=
 =?utf-8?B?eFJ5dGdtWEtUZGRFWTZTOWhKVE1XTjd2L05tMDMwaVdyUHF6K1FJcDZaUFQy?=
 =?utf-8?B?ZU11WlAvT0tYNEc3NDZ1eHZJejhLdkNEQk9PcW43OGQ2L1lBc3NtbHV2V0Jw?=
 =?utf-8?B?b01HZTRKaG5odHBvb09ON292WHNUMllMUDVua3VENzkvREJBSjlkNDRSMmRk?=
 =?utf-8?B?YlRoMHRncnlOdWNYNEtQZ25ROG5IQW45ZzJoL09rNWp5YTNrMzlPMVZuWUlU?=
 =?utf-8?B?MXBIWHNBbStOOU14T0Q3U2RacFZobnFwakR2Wm9qZ2JFRnd6eE5jOGZLbEFY?=
 =?utf-8?B?WlFibE5pVEZGOUMwZ1NCTnJMaExjNndCSjBvTzdxRTBVMWM1N0RQS09aSlFL?=
 =?utf-8?B?RjNYVXhTeDVCeVVOSTBhWStieVJGK3dxR3N6QXFNWTUyZElIdUFINWpEcmQw?=
 =?utf-8?B?OTlrcWhwZFN5MGhvVk9ZdEtMaDhJSFFJczlseVNlWCtta2I1dnFnZm1wVzBa?=
 =?utf-8?B?MUlqR0gzWXp1dVovVjJFM203TlRVd01ucVViV2xuTXd0Y3pYa2NOQnA4QjlK?=
 =?utf-8?B?UERqWVNpakEzVW04YlNPcGd5V0ZOcmFPMGlpQTNiT2h3WUQ4enpCMGdGa0Yz?=
 =?utf-8?B?OU9FejdrN0RjclhKaUp1dXE0OGllNmJNUkNRT3Q3alFCQ2NFZDU3bHZRVTdF?=
 =?utf-8?B?bXpGWnh2dG5sbUJZZnVvMTNuaDBZd1ZYOVY0Lzg5R1BrKzhHM2xMb3Nmcjk2?=
 =?utf-8?B?eVFTTTJTaXZhL1ZJWmZYYjVyK2sra2FxS2duc1dsNmVHbklEbklFTkd5TFdi?=
 =?utf-8?B?SitSdW1YdTczNGlOUGREL25WMEF4Y2I5eUdHYkM3dGRoUlpNVm5ld21QV21E?=
 =?utf-8?Q?VBPz3Wgi70jJZLoVZiZsDlRdy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fcd666-ee7e-499c-5ddd-08dc3a12180c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 17:07:36.8676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ga+ZcrS7GgazUs14aNpd1ddOijuaZ613ZeAPGwPceGQ8ocOPgbYFOdVbpXwuCA16ltMJHn/xpzll7CBU1qUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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

--------------jXUmaj1Syub2BjtJzwAS30Uv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-05 12:05, Shashank Sharma wrote:
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
> V3: (Felix)
>     - Fix wrong indentation
>     - No debug message for -ENOMEM
>     - Add NULL check for task_info
>     - Do not duplicate the debug messages (ti vs no ti)
>     - Get first reference of task_info in vm_init(), put last
>       in vm_fini()
>
> Cc: Christian Koenig<christian.koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Cc: Felix Kuehling<Felix.Kuehling@amd.com>
> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>

One nit-pick and one bug inline. With those fixed, the patch

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   9 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  18 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 158 ++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  21 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  24 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  23 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  20 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  23 +--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  23 +--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  22 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  20 +--
>   13 files changed, 251 insertions(+), 124 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0e61ebdb3f3e..f9eb12697b95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1775,9 +1775,14 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>   	list_for_each_entry(file, &dev->filelist, lhead) {
>   		struct amdgpu_fpriv *fpriv = file->driver_priv;
>   		struct amdgpu_vm *vm = &fpriv->vm;
> +		struct amdgpu_task_info *ti;
> +
> +		ti = amdgpu_vm_get_task_info_vm(vm);
> +		if (ti) {
> +			seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti->pid, ti->process_name);
> +			amdgpu_vm_put_task_info(ti);
> +		}
>   
> -		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
> -				vm->task_info.pid, vm->task_info.process_name);
>   		r = amdgpu_bo_reserve(vm->root.bo, true);
>   		if (r)
>   			break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 1f357198533f..e6e6d56398f2 100644
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
> +		   job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
> +		   ring->fence_drv.sync_seq);
> +
> +	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
> +	if (ti) {
> +		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
> +			  ti->process_name, ti->tgid, ti->task_name, ti->pid);
> +		amdgpu_vm_put_task_info(ti);
> +	}
>   
>   	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 4baa300121d8..a59364e9b6ed 100644
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
> +			amdgpu_vm_put_task_info(ti);
> +		}
> +	}
>   
>   	coredump->adev = adev;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index d1b8afd105c9..8414567af683 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2127,6 +2127,117 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>   	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
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
> + * amdgpu_vm_put_task_info - reference down the vm task_info ptr
> + *
> + * @task_info: task_info struct under discussion.
> + *
> + * frees the vm task_info ptr at the last put
> + */
> +void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info)
> +{
> +	kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
> +}
> +
> +/**
> + * amdgpu_vm_get_task_info_pasid - Extracts task info for a PASID.
> + *
> + * @adev: drm device pointer
> + * @pasid: PASID identifier for VM
> + *
> + * Returns the reference counted task_info structure, which must be
> + * referenced down with amdgpu_vm_put_task_info.
> + */
> +struct amdgpu_task_info *
> +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
> +{
> +	struct amdgpu_vm *vm;
> +	struct amdgpu_task_info *ti = NULL;
> +
> +	vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
> +	if (vm) {
> +		ti = vm->task_info;
> +		kref_get(&vm->task_info->refcount);
> +	}

This could be more concise and elegant if you implemented it in terms of 
amdgpu_vm_get_task_info_vm. I.e.:

	return amdgpu_vm_get_task_info_vm(
		amdgpu_vm_get_vm_from_pasid(adev, pasid));


> +
> +	return ti;
> +}
> +
> +/**
> + * amdgpu_vm_get_task_info_vm - Extracts task info for a vm.
> + *
> + * @vm: VM to get info from
> + *
> + * Returns the reference counted task_info structure, which must be
> + * referenced down with amdgpu_vm_put_task_info.
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
> +	if (!vm->task_info)
> +		return -ENOMEM;
> +
> +	kref_init(&vm->task_info->refcount);
> +	kref_get(&vm->task_info->refcount);

kref_init initializes the refcount to 1. I don't think you should to 
take another reference here because that reference never gets released.

Regards,
   Felix


> +	return 0;
> +}
> +
> +/**
> + * amdgpu_vm_set_task_info - Sets VMs task info.
> + *
> + * @vm: vm for which to set the info
> + */
> +void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
> +{
> +	if (!vm->task_info)
> +		return;
> +
> +	if (vm->task_info->pid == current->pid)
> +		return;
> +
> +	vm->task_info->pid = current->pid;
> +	get_task_comm(vm->task_info->task_name, current);
> +
> +	if (current->group_leader->mm != current->mm)
> +		return;
> +
> +	vm->task_info->tgid = current->group_leader->pid;
> +	get_task_comm(vm->task_info->process_name, current->group_leader);
> +}
> +
>   /**
>    * amdgpu_vm_init - initialize a vm instance
>    *
> @@ -2212,6 +2323,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto error_free_root;
>   
> +	r = amdgpu_vm_create_task_info(vm);
> +	if (r)
> +		DRM_DEBUG("Failed to create task info for VM\n");
> +
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	amdgpu_bo_unref(&root_bo);
>   
> @@ -2351,6 +2466,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
> +	amdgpu_vm_put_task_info(vm->task_info);
>   	amdgpu_vm_set_pasid(adev, vm, 0);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
> @@ -2507,48 +2623,6 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	return 0;
>   }
>   
> -/**
> - * amdgpu_vm_get_task_info - Extracts task info for a PASID.
> - *
> - * @adev: drm device pointer
> - * @pasid: PASID identifier for VM
> - * @task_info: task_info to fill.
> - */
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
> -			 struct amdgpu_task_info *task_info)
> -{
> -	struct amdgpu_vm *vm;
> -	unsigned long flags;
> -
> -	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> -
> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
> -	if (vm)
> -		*task_info = vm->task_info;
> -
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> -}
> -
> -/**
> - * amdgpu_vm_set_task_info - Sets VMs task info.
> - *
> - * @vm: vm for which to set the info
> - */
> -void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
> -{
> -	if (vm->task_info.pid)
> -		return;
> -
> -	vm->task_info.pid = current->pid;
> -	get_task_comm(vm->task_info.task_name, current);
> -
> -	if (current->group_leader->mm != current->mm)
> -		return;
> -
> -	vm->task_info.tgid = current->group_leader->pid;
> -	get_task_comm(vm->task_info.process_name, current->group_leader);
> -}
> -
>   /**
>    * amdgpu_vm_handle_fault - graceful handling of VM faults.
>    * @adev: amdgpu device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 2cd86d2bf73f..a74b94c3c9ba 100644
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
> @@ -492,8 +493,14 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>   				  struct amdgpu_job *job);
>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>   
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
> -			     struct amdgpu_task_info *task_info);
> +struct amdgpu_task_info *
> +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid);
> +
> +struct amdgpu_task_info *
> +amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
> +
> +void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
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
> index a5a05c16c10d..7098f0be83c7 100644
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
> @@ -157,18 +157,22 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   	if (!printk_ratelimit())
>   		return 0;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
>   	dev_err(adev->dev,
> -		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>   		entry->vmid_src ? "mmhub" : "gfxhub",
> -		entry->src_id, entry->ring_id, entry->vmid,
> -		entry->pasid, task_info.process_name, task_info.tgid,
> -		task_info.task_name, task_info.pid);
> +		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {
> +		dev_err(adev->dev,
> +			" in process %s pid %d thread %s pid %d\n",
> +			task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info(task_info);
> +	}
> +
>   	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
> -		addr, entry->client_id,
> -		soc15_ih_clientid_name[entry->client_id]);
> +			addr, entry->client_id,
> +			soc15_ih_clientid_name[entry->client_id]);
>   
>   	if (!amdgpu_sriov_vf(adev))
>   		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 23d7b548d13f..bff88070bb00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -126,19 +126,24 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>   	}
>   
>   	if (printk_ratelimit()) {
> -		struct amdgpu_task_info task_info;
> -
> -		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +		struct amdgpu_task_info *task_info;
>   
>   		dev_err(adev->dev,
> -			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>   			entry->vmid_src ? "mmhub" : "gfxhub",
> -			entry->src_id, entry->ring_id, entry->vmid,
> -			entry->pasid, task_info.process_name, task_info.tgid,
> -			task_info.task_name, task_info.pid);
> +			entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
> +		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +		if (task_info) {
> +			dev_err(adev->dev,
> +				" in process %s pid %d thread %s pid %d)\n",
> +				task_info->process_name, task_info->tgid,
> +				task_info->task_name, task_info->pid);
> +			amdgpu_vm_put_task_info(task_info);
> +		}
> +
>   		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
> -			addr, entry->client_id);
> +				addr, entry->client_id);
> +
>   		if (!amdgpu_sriov_vf(adev))
>   			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index ff4ae73d27ec..ba1f18978487 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1444,18 +1444,24 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>   		gmc_v8_0_set_fault_enable_default(adev, false);
>   
>   	if (printk_ratelimit()) {
> -		struct amdgpu_task_info task_info;
> +		struct amdgpu_task_info *task_info;
>   
> -		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
> +			entry->src_id, entry->src_data[0]);
> +
> +		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +		if (task_info) {
> +			dev_err(adev->dev, " for process %s pid %d thread %s pid %d\n",
> +				task_info->process_name, task_info->tgid,
> +				task_info->task_name, task_info->pid);
> +			amdgpu_vm_put_task_info(task_info);
> +		}
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
> index 2ac5820e9c92..cc0968f553a1 100644
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
> @@ -626,15 +626,20 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	if (!printk_ratelimit())
>   		return 0;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
>   	dev_err(adev->dev,
> -		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> -		hub_name, retry_fault ? "retry" : "no-retry",
> -		entry->src_id, entry->ring_id, entry->vmid,
> -		entry->pasid, task_info.process_name, task_info.tgid,
> -		task_info.task_name, task_info.pid);
> +		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n", hub_name,
> +		retry_fault ? "retry" : "no-retry",
> +		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
> +
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {
> +		dev_err(adev->dev,
> +			" for process %s pid %d thread %s pid %d)\n",
> +			task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info(task_info);
> +	}
> +
>   	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
>   		addr, entry->client_id,
>   		soc15_ih_clientid_name[entry->client_id]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 3d68dd5523c6..43775cb67ff5 100644
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
> @@ -2116,15 +2116,20 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
>   	addr = (u64)entry->src_data[0] << 12;
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
>   	dev_dbg_ratelimited(adev->dev,
> -		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> -		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
> -		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> -		   entry->pasid, task_info.process_name, task_info.tgid,
> -		   task_info.task_name, task_info.pid);
> +			   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n",
> +			   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> +			   entry->pasid);
> +
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {
> +		dev_dbg_ratelimited(adev->dev,
> +				    " for process %s pid %d thread %s pid %d\n",
> +				    task_info->process_name, task_info->tgid,
> +				    task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info(task_info);
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 0f24af6f2810..51a17d7076ec 100644
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
> @@ -1654,15 +1654,19 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>   	addr = (u64)entry->src_data[0] << 12;
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
>   	dev_dbg_ratelimited(adev->dev,
> -		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> -		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
> -		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> -		   entry->pasid, task_info.process_name, task_info.tgid,
> -		   task_info.task_name, task_info.pid);
> +			    "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n",
> +			    instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> +			    entry->pasid);
> +
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {
> +		dev_dbg_ratelimited(adev->dev, " for process %s pid %d thread %s pid %d\n",
> +				    task_info->process_name, task_info->tgid,
> +				    task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info(task_info);
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index d9953c2b2661..06ac835190f9 100644
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
> +		amdgpu_vm_put_task_info(task_info);
> +	}
>   }
>   
>   void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
--------------jXUmaj1Syub2BjtJzwAS30Uv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2024-02-05 12:05, Shashank Sharma
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240205170508.974-1-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">This patch changes the handling and lifecycle of vm-&gt;task_info object.
The major changes are:
- vm-&gt;task_info is a dynamically allocated ptr now, and its uasge is
  reference counted.
- introducing two new helper funcs for task_info lifecycle management
    - amdgpu_vm_get_task_info: reference counts up task_info before
      returning this info
    - amdgpu_vm_put_task_info: reference counts down task_info
- last put to task_info() frees task_info from the vm.

This patch also does logistical changes required for existing usage
of vm-&gt;task_info.

V2: Do not block all the prints when task_info not found (Felix)
V3: (Felix)
   - Fix wrong indentation
   - No debug message for -ENOMEM
   - Add NULL check for task_info
   - Do not duplicate the debug messages (ti vs no ti)
   - Get first reference of task_info in vm_init(), put last
     in vm_fini()

Cc: Christian Koenig <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a></pre>
    </blockquote>
    <p>One nit-pick and one bug inline. With those fixed, the patch</p>
    <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20240205170508.974-1-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  18 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 158 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  21 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  24 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  23 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  20 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  23 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  23 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  22 +--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  20 +--
 13 files changed, 251 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0e61ebdb3f3e..f9eb12697b95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1775,9 +1775,14 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 	list_for_each_entry(file, &amp;dev-&gt;filelist, lhead) {
 		struct amdgpu_fpriv *fpriv = file-&gt;driver_priv;
 		struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
+		struct amdgpu_task_info *ti;
+
+		ti = amdgpu_vm_get_task_info_vm(vm);
+		if (ti) {
+			seq_printf(m, &quot;pid:%d\tProcess:%s ----------\n&quot;, ti-&gt;pid, ti-&gt;process_name);
+			amdgpu_vm_put_task_info(ti);
+		}
 
-		seq_printf(m, &quot;pid:%d\tProcess:%s ----------\n&quot;,
-				vm-&gt;task_info.pid, vm-&gt;task_info.process_name);
 		r = amdgpu_bo_reserve(vm-&gt;root.bo, true);
 		if (r)
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1f357198533f..e6e6d56398f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -35,7 +35,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job-&gt;sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
-	struct amdgpu_task_info ti;
+	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring-&gt;adev;
 	int idx;
 	int r;
@@ -48,7 +48,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
-	memset(&amp;ti, 0, sizeof(struct amdgpu_task_info));
+
 	adev-&gt;job_hang = true;
 
 	if (amdgpu_gpu_recovery &amp;&amp;
@@ -58,12 +58,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		goto exit;
 	}
 
-	amdgpu_vm_get_task_info(ring-&gt;adev, job-&gt;pasid, &amp;ti);
 	DRM_ERROR(&quot;ring %s timeout, signaled seq=%u, emitted seq=%u\n&quot;,
-		  job-&gt;base.sched-&gt;name, atomic_read(&amp;ring-&gt;fence_drv.last_seq),
-		  ring-&gt;fence_drv.sync_seq);
-	DRM_ERROR(&quot;Process information: process %s pid %d thread %s pid %d\n&quot;,
-		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
+		   job-&gt;base.sched-&gt;name, atomic_read(&amp;ring-&gt;fence_drv.last_seq),
+		   ring-&gt;fence_drv.sync_seq);
+
+	ti = amdgpu_vm_get_task_info_pasid(ring-&gt;adev, job-&gt;pasid);
+	if (ti) {
+		DRM_ERROR(&quot;Process information: process %s pid %d thread %s pid %d\n&quot;,
+			  ti-&gt;process_name, ti-&gt;tgid, ti-&gt;task_name, ti-&gt;pid);
+		amdgpu_vm_put_task_info(ti);
+	}
 
 	dma_fence_set_error(&amp;s_job-&gt;s_fence-&gt;finished, -ETIME);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 4baa300121d8..a59364e9b6ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -230,8 +230,16 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 
 	coredump-&gt;reset_vram_lost = vram_lost;
 
-	if (reset_context-&gt;job &amp;&amp; reset_context-&gt;job-&gt;vm)
-		coredump-&gt;reset_task_info = reset_context-&gt;job-&gt;vm-&gt;task_info;
+	if (reset_context-&gt;job &amp;&amp; reset_context-&gt;job-&gt;vm) {
+		struct amdgpu_task_info *ti;
+		struct amdgpu_vm *vm = reset_context-&gt;job-&gt;vm;
+
+		ti = amdgpu_vm_get_task_info_vm(vm);
+		if (ti) {
+			coredump-&gt;reset_task_info = *ti;
+			amdgpu_vm_put_task_info(ti);
+		}
+	}
 
 	coredump-&gt;adev = adev;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d1b8afd105c9..8414567af683 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2127,6 +2127,117 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 	return dma_fence_wait_timeout(vm-&gt;last_unlocked, true, timeout);
 }
 
+static void amdgpu_vm_destroy_task_info(struct kref *kref)
+{
+	struct amdgpu_task_info *ti = container_of(kref, struct amdgpu_task_info, refcount);
+
+	kfree(ti);
+}
+
+static inline struct amdgpu_vm *
+amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
+{
+	struct amdgpu_vm *vm;
+	unsigned long flags;
+
+	xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids, flags);
+	vm = xa_load(&amp;adev-&gt;vm_manager.pasids, pasid);
+	xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids, flags);
+
+	return vm;
+}
+
+/**
+ * amdgpu_vm_put_task_info - reference down the vm task_info ptr
+ *
+ * @task_info: task_info struct under discussion.
+ *
+ * frees the vm task_info ptr at the last put
+ */
+void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info)
+{
+	kref_put(&amp;task_info-&gt;refcount, amdgpu_vm_destroy_task_info);
+}
+
+/**
+ * amdgpu_vm_get_task_info_pasid - Extracts task info for a PASID.
+ *
+ * @adev: drm device pointer
+ * @pasid: PASID identifier for VM
+ *
+ * Returns the reference counted task_info structure, which must be
+ * referenced down with amdgpu_vm_put_task_info.
+ */
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
+{
+	struct amdgpu_vm *vm;
+	struct amdgpu_task_info *ti = NULL;
+
+	vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
+	if (vm) {
+		ti = vm-&gt;task_info;
+		kref_get(&amp;vm-&gt;task_info-&gt;refcount);
+	}</pre>
    </blockquote>
    <p>This could be more concise and elegant if you implemented it in
      terms of amdgpu_vm_get_task_info_vm. I.e.:</p>
    <pre>	return amdgpu_vm_get_task_info_vm(
		amdgpu_vm_get_vm_from_pasid(adev, pasid));
</pre>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20240205170508.974-1-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
+	return ti;
+}
+
+/**
+ * amdgpu_vm_get_task_info_vm - Extracts task info for a vm.
+ *
+ * @vm: VM to get info from
+ *
+ * Returns the reference counted task_info structure, which must be
+ * referenced down with amdgpu_vm_put_task_info.
+ */
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
+{
+	struct amdgpu_task_info *ti = NULL;
+
+	if (vm) {
+		ti = vm-&gt;task_info;
+		kref_get(&amp;vm-&gt;task_info-&gt;refcount);
+	}
+
+	return ti;
+}
+
+static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
+{
+	vm-&gt;task_info = kzalloc(sizeof(struct amdgpu_task_info), GFP_KERNEL);
+	if (!vm-&gt;task_info)
+		return -ENOMEM;
+
+	kref_init(&amp;vm-&gt;task_info-&gt;refcount);
+	kref_get(&amp;vm-&gt;task_info-&gt;refcount);</pre>
    </blockquote>
    <p>kref_init initializes the refcount to 1. I don't think you should
      to take another reference here because that reference never gets
      released.<br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20240205170508.974-1-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	return 0;
+}
+
+/**
+ * amdgpu_vm_set_task_info - Sets VMs task info.
+ *
+ * @vm: vm for which to set the info
+ */
+void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
+{
+	if (!vm-&gt;task_info)
+		return;
+
+	if (vm-&gt;task_info-&gt;pid == current-&gt;pid)
+		return;
+
+	vm-&gt;task_info-&gt;pid = current-&gt;pid;
+	get_task_comm(vm-&gt;task_info-&gt;task_name, current);
+
+	if (current-&gt;group_leader-&gt;mm != current-&gt;mm)
+		return;
+
+	vm-&gt;task_info-&gt;tgid = current-&gt;group_leader-&gt;pid;
+	get_task_comm(vm-&gt;task_info-&gt;process_name, current-&gt;group_leader);
+}
+
 /**
  * amdgpu_vm_init - initialize a vm instance
  *
@@ -2212,6 +2323,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
+	r = amdgpu_vm_create_task_info(vm);
+	if (r)
+		DRM_DEBUG(&quot;Failed to create task info for VM\n&quot;);
+
 	amdgpu_bo_unreserve(vm-&gt;root.bo);
 	amdgpu_bo_unref(&amp;root_bo);
 
@@ -2351,6 +2466,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm-&gt;root.bo);
 	amdgpu_bo_reserve(root, true);
+	amdgpu_vm_put_task_info(vm-&gt;task_info);
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm-&gt;last_unlocked, false);
 	dma_fence_put(vm-&gt;last_unlocked);
@@ -2507,48 +2623,6 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 }
 
-/**
- * amdgpu_vm_get_task_info - Extracts task info for a PASID.
- *
- * @adev: drm device pointer
- * @pasid: PASID identifier for VM
- * @task_info: task_info to fill.
- */
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
-			 struct amdgpu_task_info *task_info)
-{
-	struct amdgpu_vm *vm;
-	unsigned long flags;
-
-	xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids, flags);
-
-	vm = xa_load(&amp;adev-&gt;vm_manager.pasids, pasid);
-	if (vm)
-		*task_info = vm-&gt;task_info;
-
-	xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids, flags);
-}
-
-/**
- * amdgpu_vm_set_task_info - Sets VMs task info.
- *
- * @vm: vm for which to set the info
- */
-void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
-{
-	if (vm-&gt;task_info.pid)
-		return;
-
-	vm-&gt;task_info.pid = current-&gt;pid;
-	get_task_comm(vm-&gt;task_info.task_name, current);
-
-	if (current-&gt;group_leader-&gt;mm != current-&gt;mm)
-		return;
-
-	vm-&gt;task_info.tgid = current-&gt;group_leader-&gt;pid;
-	get_task_comm(vm-&gt;task_info.process_name, current-&gt;group_leader);
-}
-
 /**
  * amdgpu_vm_handle_fault - graceful handling of VM faults.
  * @adev: amdgpu device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 2cd86d2bf73f..a74b94c3c9ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -190,10 +190,11 @@ struct amdgpu_vm_pte_funcs {
 };
 
 struct amdgpu_task_info {
-	char	process_name[TASK_COMM_LEN];
-	char	task_name[TASK_COMM_LEN];
-	pid_t	pid;
-	pid_t	tgid;
+	char		process_name[TASK_COMM_LEN];
+	char		task_name[TASK_COMM_LEN];
+	pid_t		pid;
+	pid_t		tgid;
+	struct kref	refcount;
 };
 
 /**
@@ -356,7 +357,7 @@ struct amdgpu_vm {
 	uint64_t		pd_phys_addr;
 
 	/* Some basic info about the task */
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 
 	/* Store positions of group of BOs */
 	struct ttm_lru_bulk_move lru_bulk_move;
@@ -492,8 +493,14 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 				  struct amdgpu_job *job);
 void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
-			     struct amdgpu_task_info *task_info);
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid);
+
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
+
+void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
+
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    bool write_fault);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a160265ddc07..d9e895cb0c10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -1027,7 +1027,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
 						    upd_flags,
-						    vm-&gt;task_info.tgid,
+						    vm-&gt;task_info ? vm-&gt;task_info-&gt;tgid : 0,
 						    vm-&gt;immediate.fence_context);
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a5a05c16c10d..7098f0be83c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -105,7 +105,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub = &amp;adev-&gt;vmhub[vmhub_index];
 	bool retry_fault = !!(entry-&gt;src_data[1] &amp; 0x80);
 	bool write_fault = !!(entry-&gt;src_data[1] &amp; 0x20);
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	uint32_t status = 0;
 	u64 addr;
 
@@ -157,18 +157,22 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
-
 	dev_err(adev-&gt;dev,
-		&quot;[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n&quot;,
+		&quot;[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n&quot;,
 		entry-&gt;vmid_src ? &quot;mmhub&quot; : &quot;gfxhub&quot;,
-		entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
-		entry-&gt;pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
+		entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid, entry-&gt;pasid);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+	if (task_info) {
+		dev_err(adev-&gt;dev,
+			&quot; in process %s pid %d thread %s pid %d\n&quot;,
+			task_info-&gt;process_name, task_info-&gt;tgid,
+			task_info-&gt;task_name, task_info-&gt;pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	dev_err(adev-&gt;dev, &quot;  in page starting at address 0x%016llx from client 0x%x (%s)\n&quot;,
-		addr, entry-&gt;client_id,
-		soc15_ih_clientid_name[entry-&gt;client_id]);
+			addr, entry-&gt;client_id,
+			soc15_ih_clientid_name[entry-&gt;client_id]);
 
 	if (!amdgpu_sriov_vf(adev))
 		hub-&gt;vmhub_funcs-&gt;print_l2_protection_fault_status(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 23d7b548d13f..bff88070bb00 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -126,19 +126,24 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
-
-		memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
+		struct amdgpu_task_info *task_info;
 
 		dev_err(adev-&gt;dev,
-			&quot;[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n&quot;,
+			&quot;[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n&quot;,
 			entry-&gt;vmid_src ? &quot;mmhub&quot; : &quot;gfxhub&quot;,
-			entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
-			entry-&gt;pasid, task_info.process_name, task_info.tgid,
-			task_info.task_name, task_info.pid);
+			entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid, entry-&gt;pasid);
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+		if (task_info) {
+			dev_err(adev-&gt;dev,
+				&quot; in process %s pid %d thread %s pid %d)\n&quot;,
+				task_info-&gt;process_name, task_info-&gt;tgid,
+				task_info-&gt;task_name, task_info-&gt;pid);
+			amdgpu_vm_put_task_info(task_info);
+		}
+
 		dev_err(adev-&gt;dev, &quot;  in page starting at address 0x%016llx from client %d\n&quot;,
-			addr, entry-&gt;client_id);
+				addr, entry-&gt;client_id);
+
 		if (!amdgpu_sriov_vf(adev))
 			hub-&gt;vmhub_funcs-&gt;print_l2_protection_fault_status(adev, status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ff4ae73d27ec..ba1f18978487 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1444,18 +1444,24 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
+		struct amdgpu_task_info *task_info;
 
-		memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
+		dev_err(adev-&gt;dev, &quot;GPU fault detected: %d 0x%08x\n&quot;,
+			entry-&gt;src_id, entry-&gt;src_data[0]);
+
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+		if (task_info) {
+			dev_err(adev-&gt;dev, &quot; for process %s pid %d thread %s pid %d\n&quot;,
+				task_info-&gt;process_name, task_info-&gt;tgid,
+				task_info-&gt;task_name, task_info-&gt;pid);
+			amdgpu_vm_put_task_info(task_info);
+		}
 
-		dev_err(adev-&gt;dev, &quot;GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n&quot;,
-			entry-&gt;src_id, entry-&gt;src_data[0], task_info.process_name,
-			task_info.tgid, task_info.task_name, task_info.pid);
 		dev_err(adev-&gt;dev, &quot;  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n&quot;,
-			addr);
+				addr);
 		dev_err(adev-&gt;dev, &quot;  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n&quot;,
 			status);
+
 		gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
 					 entry-&gt;pasid);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2ac5820e9c92..cc0968f553a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -549,7 +549,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	bool retry_fault = !!(entry-&gt;src_data[1] &amp; 0x80);
 	bool write_fault = !!(entry-&gt;src_data[1] &amp; 0x20);
 	uint32_t status = 0, cid = 0, rw = 0;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	struct amdgpu_vmhub *hub;
 	const char *mmhub_cid;
 	const char *hub_name;
@@ -626,15 +626,20 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
-
 	dev_err(adev-&gt;dev,
-		&quot;[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n&quot;,
-		hub_name, retry_fault ? &quot;retry&quot; : &quot;no-retry&quot;,
-		entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
-		entry-&gt;pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
+		&quot;[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n&quot;, hub_name,
+		retry_fault ? &quot;retry&quot; : &quot;no-retry&quot;,
+		entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid, entry-&gt;pasid);
+
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+	if (task_info) {
+		dev_err(adev-&gt;dev,
+			&quot; for process %s pid %d thread %s pid %d)\n&quot;,
+			task_info-&gt;process_name, task_info-&gt;tgid,
+			task_info-&gt;task_name, task_info-&gt;pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	dev_err(adev-&gt;dev, &quot;  in page starting at address 0x%016llx from IH client 0x%x (%s)\n&quot;,
 		addr, entry-&gt;client_id,
 		soc15_ih_clientid_name[entry-&gt;client_id]);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3d68dd5523c6..43775cb67ff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2104,7 +2104,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 	int instance;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	u64 addr;
 
 	instance = sdma_v4_0_irq_id_to_seq(entry-&gt;client_id);
@@ -2116,15 +2116,20 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	addr = (u64)entry-&gt;src_data[0] &lt;&lt; 12;
 	addr |= ((u64)entry-&gt;src_data[1] &amp; 0xf) &lt;&lt; 44;
 
-	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
-
 	dev_dbg_ratelimited(adev-&gt;dev,
-		   &quot;[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u &quot;
-		   &quot;pasid:%u, for process %s pid %d thread %s pid %d\n&quot;,
-		   instance, addr, entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
-		   entry-&gt;pasid, task_info.process_name, task_info.tgid,
-		   task_info.task_name, task_info.pid);
+			   &quot;[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n&quot;,
+			   instance, addr, entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
+			   entry-&gt;pasid);
+
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+	if (task_info) {
+		dev_dbg_ratelimited(adev-&gt;dev,
+				    &quot; for process %s pid %d thread %s pid %d\n&quot;,
+				    task_info-&gt;process_name, task_info-&gt;tgid,
+				    task_info-&gt;task_name, task_info-&gt;pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 0f24af6f2810..51a17d7076ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1642,7 +1642,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 	int instance;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	u64 addr;
 
 	instance = sdma_v4_4_2_irq_id_to_seq(entry-&gt;client_id);
@@ -1654,15 +1654,19 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	addr = (u64)entry-&gt;src_data[0] &lt;&lt; 12;
 	addr |= ((u64)entry-&gt;src_data[1] &amp; 0xf) &lt;&lt; 44;
 
-	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
-
 	dev_dbg_ratelimited(adev-&gt;dev,
-		   &quot;[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u &quot;
-		   &quot;pasid:%u, for process %s pid %d thread %s pid %d\n&quot;,
-		   instance, addr, entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
-		   entry-&gt;pasid, task_info.process_name, task_info.tgid,
-		   task_info.task_name, task_info.pid);
+			    &quot;[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n&quot;,
+			    instance, addr, entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
+			    entry-&gt;pasid);
+
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+	if (task_info) {
+		dev_dbg_ratelimited(adev-&gt;dev, &quot; for process %s pid %d thread %s pid %d\n&quot;,
+				    task_info-&gt;process_name, task_info-&gt;tgid,
+				    task_info-&gt;task_name, task_info-&gt;pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index d9953c2b2661..06ac835190f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -238,16 +238,16 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 {
-	struct amdgpu_task_info task_info;
-
-	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(dev-&gt;adev, pasid, &amp;task_info);
-	/* Report VM faults from user applications, not retry from kernel */
-	if (!task_info.pid)
-		return;
-
-	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, &quot;%x:%s\n&quot;,
-			  task_info.pid, task_info.task_name);
+	struct amdgpu_task_info *task_info;
+
+	task_info = amdgpu_vm_get_task_info_pasid(dev-&gt;adev, pasid);
+	if (task_info) {
+		/* Report VM faults from user applications, not retry from kernel */
+		if (task_info-&gt;pid)
+			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, &quot;%x:%s\n&quot;,
+					 task_info-&gt;pid, task_info-&gt;task_name);
+		amdgpu_vm_put_task_info(task_info);
+	}
 }
 
 void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
</pre>
    </blockquote>
  </body>
</html>

--------------jXUmaj1Syub2BjtJzwAS30Uv--
