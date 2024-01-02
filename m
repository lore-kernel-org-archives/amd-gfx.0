Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF75C47073
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 18:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD78710E13B;
	Tue,  2 Jan 2024 18:02:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A832F10E13B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 18:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHJPGOjXxVc772OGZ4LkvKA1nqBth3J74P5nZPWLI8/bOG2p69LsozTyoHY8eYT/JluuLU/OYJJwVKDAnbqDiqF+WBs7EMGO4m2BmoRK+hVlO4YvQX1wHzSD17InCJg2ngSUu4gf4SblFOEX+O2k/hUV5tbdjFpgPTobQBfEWMFALGlX94sS+lxjNVQeJBGLFafhimCbSPvXQiQL22U7FPQtSxCIanhT38Vcgp2isXJl53oxikc6/B3hXaLSzTCKjAtw8v6a76SEX4H+gaVrfIQwplHLMU22LCb2P/37qORhqKCiJngb83dsNMR8BDZTBykF3Wadzwm4ik8iWo/hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhijIxy0r/ahP6ibkRnvV4p64KVsj/7Xxuf9ZTJkuKI=;
 b=S+dEL4y5F1hlzsbvmnxAOgWMTgE4qnMfRfKDib1LkErPvzt5taBT1uH25gtWetb+9UVrp92sNB/F7ruI00KuHF+IDoOoo/Y8RoZJFM7BQURcQcKw+pP0MGUcrl7XovXcbIRlMl+WurvLo1goLd17SbnDIqlQvu+P3YDnYZ1K6Qoc30kiiyCuWZdz9UQYpeV/26qU4dnjQQCueq10kCwdnOJ8HifUJOQkJFeufZYwFD+Pv6qX8NNbow/M+cYYoMLfZoWeLdsGd4SO/PfV5HrIjkkuNrUNhq6e3kyYTJqMKSxlCbE52uavK0jY28wbQk1xooXHpLKT+cuU8+eRTXfN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhijIxy0r/ahP6ibkRnvV4p64KVsj/7Xxuf9ZTJkuKI=;
 b=elyITiF+NsDHBd4oLsInKwuoMjhcSlZkuDC9L5DQ2M2cizsppT3WU8oIpcmjJACOiBL9eF5ZP72enRSrUpTx4ZsHoJqkoy4dOpW9kichuSyPoce5LIi9FmzoVX+z94qppp0LlUx7iFaiA0dD04FP1W7pB26z0g5wlVmfzG8Qkbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 18:02:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 18:02:30 +0000
Message-ID: <beb4c574-60d1-4ce4-ab9c-c574ec94a23c@amd.com>
Date: Tue, 2 Jan 2024 13:02:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: change vm->task_info handling
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240102111235.137-1-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240102111235.137-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::15)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: 26496aa2-0de9-4c40-66d6-08dc0bbcfcd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImsDNPRrJ3UjOlUed3GsphnB3WNZMYZ2bVlRiur8vEuU3yB/wv/66FM/V5iS5/HFEcbi4wdMCein9DX9rfuHAoz9m260G+muq48EGIXDpiq8b2rVo+LS2ReKPk1o52k5Zhc1ZAQQ7Aca6HI1VsKHi0Ifu9qWmhrQK30eVo0pmxKb0LE3j80sx5BE1AOhq03i9wuqINTdqLvpVwsMmtN5968tMnORejVnoCy8RhRh0m55eCQ3j75CmDnzO5/c7nGKDiFl2d3vEtKB0ZmLK2j916Ty94S+27vOQX1NZ1ypKu4imGHrHM7UfFgPzQ/sWn7hkUdepof5I+egpu5Uyjee39ZJrMg6aKzWO+gudYwC+tClPhaY6X1b4GBT2VeVGDwGcoumkUM3hua4HtQ938upoYRb7GfD4gsXI6HXGrhVWzm26Y758oks300n7zlDCVzDWe1bKOu6BTdQGePi0lefi+rzjDG+NSXrAmEU41DIjxhlYjI6L03XjITOjhx7AcbOB1DF9lKcD1XAPmauJrSuWY6XtNfRvyfdq6uk0g6VAkeatxJx9mq28YaL/w1bf4F9l7L59ivfduzuADnVUw3/eejVQrk8f2oaNaFc5LVZvNegScCBGQD/MdGVMi8Axlj9MquB/iUw5j1PuJ5cvBB0tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(66556008)(66946007)(6486002)(4326008)(44832011)(316002)(8676002)(8936002)(2616005)(54906003)(26005)(83380400001)(478600001)(53546011)(6512007)(36916002)(30864003)(2906002)(41300700001)(5660300002)(6506007)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZHWEcvMXR3NkVJdnlYbjYvRXM3cm16bDM3SE8vVERWOFBMN05MUTl0RmQ5?=
 =?utf-8?B?MG10VVhoSW42c3VUbTZFMDE2U0lDUnF3anpqTEg2QzZoNEMyRVdsTjBrSzdm?=
 =?utf-8?B?R09tUXVwM29neldBckJkUFREOUh6cHN4VG1vQkY2VjllM1VuMXIwMWtsV0FV?=
 =?utf-8?B?R09MMkpsSnUraUNpVHgreEZaU0VnT1ZXK29BeklHUUVOWElISFdaMm5ZT2NJ?=
 =?utf-8?B?WjM2NVpsSzdkZFdIMnorVGFZaisrY2NqcHpVSVdHVHBUb3ZlQXp0cUdHaGtG?=
 =?utf-8?B?K2JjYzUzdStpTUNwOUg2RE1yZTRmb1JwaWFQdnB2QWRLb0pQSFNwSERBeHUr?=
 =?utf-8?B?dWxqT0g2Vm80TVNyWktUWVZoa2p3NW1UajFlOGJSWDBNSEF5MGxhcFJyYkNF?=
 =?utf-8?B?bHMydVFaRHE2OHlHWTF1RVdXMHMzYnM2UExFdXhSblgySVNjMVBieXpGL0la?=
 =?utf-8?B?SmJtYUoxWEtCQjlkeHdmWldDZWRiM0wxY3dYMlQ1c0wzYzFYYy9nTTRPUFYr?=
 =?utf-8?B?WHhxSEVlTkZ2ZDBOYTJiRHByTll3ZWZldTQwTmVsYlNOVVdQczBic3NmaUhS?=
 =?utf-8?B?em9KNGxscXZZdE1MV2I3VWdZMTh3WkFYTE5hTDcvaVZJenNOQ2R5YXZ5bTFK?=
 =?utf-8?B?NG03VVk5a2Ntak8vMldQY3VCcngyMWV3UnJsRGZ1OVN3R3ZvcVl4OTI0YVhJ?=
 =?utf-8?B?cUErQlVEVFhwS0U4bFFueXJyMWNtSG5udzRjUk9WTFVVK1RwZ2o4Slh6S1cw?=
 =?utf-8?B?aklTT3BuQ3ZhNFFZa2FDRFpQN2VrNHVjREl1M2RPd051SVRrOEVYdlV2Sm9h?=
 =?utf-8?B?OC8xVHhoSS9TZmhOekI4RzNmMC9DcTA2VEtsRStJTW0wUEpSd1FsbjJRb2Nw?=
 =?utf-8?B?Y2ZSdXE3b3NsUlYxbHBFZjArdDl3cFJPenNmTXNpdHBaemMwWTllNFgxVlFL?=
 =?utf-8?B?N3B4dkNFOWF1cStwak1Za1NhOVFrcnRES283L0lWQ3l4eWF3UTJiV2ZuOEtx?=
 =?utf-8?B?VVpJR1dpUUJOeFZGM2tvVUZpZm02N3JabXRKSWtEWmxKSnVsaDRxdnEvdVJ2?=
 =?utf-8?B?aFVET2ZmVjdxM2M2aklLb2lJeUJSMEt0RFdsdGJSNUJpS1JpcEJOZGtONm4y?=
 =?utf-8?B?SE9iU3Jld1dkSjZiZzdqUVAwYVR4VmhhZk10SE5PQ2FVLzVJWklwU3Z4VTRj?=
 =?utf-8?B?R0EveG4xcytzVFZQQXo5MHVTTVlvWWV2a1hxMlc0YTRCNDhLOHlWaU4rek81?=
 =?utf-8?B?a1NBUytBbmhmVGJMbzh5Q0FaNXhHanRVZzMwUnpsSWt6aFV6THlWbyt4RlF2?=
 =?utf-8?B?cHJWL1MvODk2NGcxQ200S2FuQnI3KzFudHlOVDBZRlg5bTZlSStJcXN5NERh?=
 =?utf-8?B?UmVkYzkxL2NvS3dBaC9MVWM0eHgwS0ErRG1sYXl5b2s5TUV1alV0aFNrUmdi?=
 =?utf-8?B?alBOb1d5Szk1M3JSOHhsb3l3NGYyWlRXQk9MYmxzbHlvU08rSTU5ZXEvSUtm?=
 =?utf-8?B?MlA2MHVQWm50anlob2RsU2cvaGVONmE0ZUNzM0FPMWZ4K3AwTk0zbGpuaDQw?=
 =?utf-8?B?Wk9lVDdQc1JpWjdzY29RMHgvT1B3VVY2Z052NHNYSzNBK2psYUJ6Tk43aFk3?=
 =?utf-8?B?eHVxOGZjVE54ZTg3SnplMng2Sk9xWnhkdTZEME52UDRQTEgzUnNESm9lN09Y?=
 =?utf-8?B?M29nWXVqc2wyRFVCNmdiWHFZUEJNNFcyUkVKT1JJOFUzWS9HMmo4Z2V0WTM5?=
 =?utf-8?B?dW1wejJsTkhaZlpNWXErWHhXNDFUL2FmcVpxL2E1Yk4rVnBLc3hUMDRkYlVn?=
 =?utf-8?B?b2hJWC84OWc1bm96UzZOVkJzak9NdUpBR0E3U0NvSVY3L0ZiWE5aeWdOS29D?=
 =?utf-8?B?N01XL3p2NGhyL3NvWjlwMEIyRFVVUERtektmRGh1SldGaElsZzFTWE1MeTJ2?=
 =?utf-8?B?WEQ3cXVXTEN6SytlcXM5SVlRc2JZYXdKSHRPeXpoSjZoN3FMQy9aSlRRUFBJ?=
 =?utf-8?B?TzNvRDhmNEFtZit4V2lMUFlGUVBqSlk2cWZ0cllwbWRlN2xPeUN3Z2g5VnF0?=
 =?utf-8?B?cXJKWGdwd09JVmFHckU3YjVPL2Z6U21xOFJZNUF1L1lKWEk1eDZ3RFZqK2di?=
 =?utf-8?Q?xdR3yNegnUCQC5v7lP5nN2smc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26496aa2-0de9-4c40-66d6-08dc0bbcfcd2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 18:02:30.4889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUOocFrAjMP1szrL+DR04HhkqYvBSwqy9t3PdITZfVUM4IRulDeSHFRYFlNJv9vnzkfrmt1aUjcAQzN36Sxtvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
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


On 2024-01-02 06:12, Shashank Sharma wrote:
> drm/amdgpu: change vm->task_info handling
>
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
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  15 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  17 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 142 +++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  24 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  27 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  28 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  26 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  28 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  20 +--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  19 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  17 +--
>   13 files changed, 259 insertions(+), 113 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index a4faea4fa0b5..111f8afb03a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1763,9 +1763,12 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>   	list_for_each_entry(file, &dev->filelist, lhead) {
>   		struct amdgpu_fpriv *fpriv = file->driver_priv;
>   		struct amdgpu_vm *vm = &fpriv->vm;
> +		struct amdgpu_task_info *ti;
> +
> +		ti = amdgpu_vm_get_task_info_vm(vm);
> +		seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti->pid, ti->process_name);
> +		amdgpu_vm_put_task_info_vm(ti, vm);
>   
> -		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
> -				vm->task_info.pid, vm->task_info.process_name);
>   		r = amdgpu_bo_reserve(vm->root.bo, true);
>   		if (r)
>   			break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2b8356699f23..00516fa178b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4952,10 +4952,17 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   				tmp_adev->reset_vram_lost = vram_lost;
>   				memset(&tmp_adev->reset_task_info, 0,
>   						sizeof(tmp_adev->reset_task_info));
> -				if (reset_context->job && reset_context->job->vm)
> -					tmp_adev->reset_task_info =
> -						reset_context->job->vm->task_info;
> -				amdgpu_reset_capture_coredumpm(tmp_adev);
> +				if (reset_context->job && reset_context->job->vm) {
> +					struct amdgpu_task_info *ti;
> +					struct amdgpu_vm *vm = reset_context->job->vm;
> +
> +					ti = amdgpu_vm_get_task_info_vm(vm);
> +					if (ti) {
> +						tmp_adev->reset_task_info = *ti;
> +						amdgpu_reset_capture_coredumpm(tmp_adev);
> +						amdgpu_vm_put_task_info_vm(ti, vm);
> +					}
> +				}
>   #endif
>   				if (vram_lost) {
>   					DRM_INFO("VRAM is lost due to GPU reset!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 78476bc75b4e..b89ee6ab7db9 100644
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
> @@ -58,12 +58,15 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		goto exit;
>   	}
>   
> -	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
> -	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
> -		  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
> -		  ring->fence_drv.sync_seq);
> -	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
> -		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
> +	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
> +	if (ti) {
> +		DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
> +			  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
> +			  ring->fence_drv.sync_seq);
> +		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
> +			  ti->process_name, ti->tgid, ti->task_name, ti->pid);
> +		amdgpu_vm_put_task_info_pasid(ring->adev, ti, job->pasid);
> +	}
>   
>   	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 82f25996ff5e..0d655bffad7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2332,6 +2332,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> +	if (vm->task_info)
> +		amdgpu_vm_put_task_info_vm(vm->task_info, vm);
> +
>   	flush_work(&vm->pt_free_work);
>   
>   	root = amdgpu_bo_ref(vm->root.bo);
> @@ -2492,26 +2495,129 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
> +		return -ENOMEM;
> +	}
> +
> +	kref_init(&vm->task_info->refcount);
> +	return 0;
>   }
>   
>   /**
> @@ -2521,17 +2627,23 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
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
> index 204ab13184ed..c2dce85d4f9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -183,10 +183,11 @@ struct amdgpu_vm_pte_funcs {
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
> @@ -334,7 +335,7 @@ struct amdgpu_vm {
>   	uint64_t		pd_phys_addr;
>   
>   	/* Some basic info about the task */
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   
>   	/* Store positions of group of BOs */
>   	struct ttm_lru_bulk_move lru_bulk_move;
> @@ -466,8 +467,17 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
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
> +struct amdgpu_task_info *amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
> +
> +void amdgpu_vm_put_task_info_vm(struct amdgpu_task_info *task_info, struct amdgpu_vm *vm);
> +
>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   			    u32 vmid, u32 node_id, uint64_t addr,
>   			    bool write_fault);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 96d601e209b8..f8323957d8bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -1032,7 +1032,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>   						    min(nptes, 32u), dst, incr,
>   						    upd_flags,
> -						    vm->task_info.tgid,
> +						    vm->task_info ? vm->task_info->tgid : 0,
>   						    vm->immediate.fence_context);
>   			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>   						   cursor.level, pe_start, dst,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index fa87a85e1017..12c624876243 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>   	bool retry_fault = !!(entry->src_data[1] & 0x80);
>   	bool write_fault = !!(entry->src_data[1] & 0x20);
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	uint32_t status = 0;
>   	u64 addr;
>   
> @@ -155,18 +155,19 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   	if (!printk_ratelimit())
>   		return 0;
>   
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
> -	dev_err(adev->dev,
> -		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> -		entry->vmid_src ? "mmhub" : "gfxhub",
> -		entry->src_id, entry->ring_id, entry->vmid,
> -		entry->pasid, task_info.process_name, task_info.tgid,
> -		task_info.task_name, task_info.pid);
> -	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
> -		addr, entry->client_id,
> -		soc15_ih_clientid_name[entry->client_id]);
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {
This drops a lot of useful information from entry if task_info is not 
found for any reason. Please separate this so that entry->... 
information can still be printed when there is no task_info.


> +		dev_err(adev->dev,
> +			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +			entry->vmid_src ? "mmhub" : "gfxhub",
> +			entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid, task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +		dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
> +			addr, entry->client_id,
> +			soc15_ih_clientid_name[entry->client_id]);
> +		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +	}
>   
>   	if (!amdgpu_sriov_vf(adev))
>   		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index e3b76fd28d15..ec61e371120a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -120,19 +120,21 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>   	}
>   
>   	if (printk_ratelimit()) {
> -		struct amdgpu_task_info task_info;
> -
> -		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
> -		dev_err(adev->dev,
> -			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> -			entry->vmid_src ? "mmhub" : "gfxhub",
> -			entry->src_id, entry->ring_id, entry->vmid,
> -			entry->pasid, task_info.process_name, task_info.tgid,
> -			task_info.task_name, task_info.pid);
> -		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
> -			addr, entry->client_id);
> +		struct amdgpu_task_info *task_info;
> +
> +		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +		if (task_info) {

Same as above.


> +			dev_err(adev->dev,
> +				"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +				entry->vmid_src ? "mmhub" : "gfxhub",
> +				entry->src_id, entry->ring_id, entry->vmid,
> +				entry->pasid, task_info->process_name, task_info->tgid,
> +				task_info->task_name, task_info->pid);
> +			dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
> +				addr, entry->client_id);
> +			amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +		}
> +
>   		if (!amdgpu_sriov_vf(adev))
>   			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 5af235202513..a33a5659713d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1446,18 +1446,20 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>   		gmc_v8_0_set_fault_enable_default(adev, false);
>   
>   	if (printk_ratelimit()) {
> -		struct amdgpu_task_info task_info;
> -
> -		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
> -		dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
> -			entry->src_id, entry->src_data[0], task_info.process_name,
> -			task_info.tgid, task_info.task_name, task_info.pid);
> -		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
> -			addr);
> -		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
> -			status);
> +		struct amdgpu_task_info *task_info;
> +
> +		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +		if (task_info) {

Same as above.


> +			dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
> +				entry->src_id, entry->src_data[0], task_info->process_name,
> +				task_info->tgid, task_info->task_name, task_info->pid);
> +			dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
> +				addr);
> +			dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
> +				status);
> +			amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +		}
> +
>   		gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
>   					 entry->pasid);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index f9a5a2c0573e..fefaa57d8669 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -550,7 +550,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	bool retry_fault = !!(entry->src_data[1] & 0x80);
>   	bool write_fault = !!(entry->src_data[1] & 0x20);
>   	uint32_t status = 0, cid = 0, rw = 0;
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	struct amdgpu_vmhub *hub;
>   	const char *mmhub_cid;
>   	const char *hub_name;
> @@ -625,19 +625,19 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	if (!printk_ratelimit())
>   		return 0;
>   
> -
> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
> -	dev_err(adev->dev,
> -		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> -		hub_name, retry_fault ? "retry" : "no-retry",
> -		entry->src_id, entry->ring_id, entry->vmid,
> -		entry->pasid, task_info.process_name, task_info.tgid,
> -		task_info.task_name, task_info.pid);
> -	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
> -		addr, entry->client_id,
> -		soc15_ih_clientid_name[entry->client_id]);
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {

Same as above.


> +		dev_err(adev->dev,
> +			"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
> +			hub_name, retry_fault ? "retry" : "no-retry",
> +			entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid, task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +		dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
> +			addr, entry->client_id,
> +			soc15_ih_clientid_name[entry->client_id]);
> +		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +	}
>   
>   	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
>   		dev_err(adev->dev, "  cookie node_id %d fault from die %s%d%s\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index cd37f45e01a1..02c8d4364c87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2112,7 +2112,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
>   					      struct amdgpu_iv_entry *entry)
>   {
>   	int instance;
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	u64 addr;
>   
>   	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
> @@ -2125,14 +2125,16 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
>   	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> -
> -	dev_dbg_ratelimited(adev->dev,
> -		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> -		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
> -		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> -		   entry->pasid, task_info.process_name, task_info.tgid,
> -		   task_info.task_name, task_info.pid);
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {

Same as above.


> +		dev_dbg_ratelimited(adev->dev,
> +			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> +			"pasid:%u, for process %s pid %d thread %s pid %d\n",
> +			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid, task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +	}
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index f413898dda37..b62a9bef72e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1633,7 +1633,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>   					      struct amdgpu_iv_entry *entry)
>   {
>   	int instance;
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   	u64 addr;
>   
>   	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
> @@ -1646,14 +1646,17 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
>   	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
> +	if (task_info) {

Same as above.

Regards,
   Felix


> +		dev_dbg_ratelimited(adev->dev,
> +			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
> +			"pasid:%u, for process %s pid %d thread %s pid %d\n",
> +			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> +			entry->pasid, task_info->process_name, task_info->tgid,
> +			task_info->task_name, task_info->pid);
> +		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
> +	}
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
> index d9953c2b2661..f6ed68fdff81 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -238,16 +238,17 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>   
>   void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
>   {
> -	struct amdgpu_task_info task_info;
> +	struct amdgpu_task_info *task_info;
>   
>   	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
> -	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
> -	/* Report VM faults from user applications, not retry from kernel */
> -	if (!task_info.pid)
> -		return;
> -
> -	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
> -			  task_info.pid, task_info.task_name);
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
