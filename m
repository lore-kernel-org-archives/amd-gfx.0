Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07FEEB8FA5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 08:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8455E10E5A4;
	Wed,  6 Sep 2023 08:46:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F2310E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 08:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQGNvGfrM8ReFsc/kupX1UeqioWtIcAMXf2A5GGMaEqZTqM2fptfAyoAci4LA06KEO1bTO/4PwKenUCW8F21XvlEsM2gru58IjO9f4DWU8ISkQKlC+vcN/1fZAoh8loN+P5aZSUT9OfDx8NbJrGmYrR99mO+Qs5CMtqrRt0Vv9UyHj/kNAqjkeMmyLq1vh3pogiWyViWPauzxFE+TX99QtyN5zp/KDmF1huEpagIQ7/V2jauAO9q17OHRIxuFt9vk2ziH+V2wiBgYw65cFCWt60P8QU0AHbdwT7u5k2HE6wgKOAvWsPFcTEgzYvSM2HgdqzYxgg/w0ewwzW5xmfm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev/bCVzeRubVOtAImIkheiFniGtndcDNKdTek+aXI/o=;
 b=DKO2/zrxHBbnoAi3wajvCkW75UhGqFtwVfNb88I8Rh0P9++QdzpBPmVf4aK7PTnBF+sMOtyvQA318nf9B5Ms1zqMU37fyrKThD7x0IpQx32zLtFP9oQqDCmVIwXXxRFA9UnNRKYSGiEqanRTXjIfm+pi44FXdxcsawDJ5L58HKBAwEvhroRdehVzzp6koa+g5cvoIz44IV5fXzz86BqcbbmC3gXh+3clSYc6KK0TS4il+gzZ+CipZOJ30BFBcDvKNMvRLCjqswiUG62QZt+xJ05bhgdzdtXZq2++2SMLOSLnc2G4fVYdD/WOyuum8J4qnX/LzKy0hudvEeYrXQ+9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev/bCVzeRubVOtAImIkheiFniGtndcDNKdTek+aXI/o=;
 b=pV7s8kYo4bPKPYiLoGo2Q67evASczceUvONvvgCODk6b2YIx2RUUxLcXlScEI+L0Oq6K/bUbh5zhA9C037gEpfCp/i1i/Bt8us+kfIkroOh7Pz2iua6Vddp7DfFtmcLOB+HMtTpk+evzrrUtMIaA5BLLcX+8rDPeQz5CatqArew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 08:46:38 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 08:46:38 +0000
Message-ID: <79007338-f47a-7e66-2427-c1e0eab0a095@amd.com>
Date: Wed, 6 Sep 2023 10:46:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: move task_info out of amdgpu_vm
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230905153636.2107-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230905153636.2107-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM8PR12MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: 383ccef7-c12f-4361-9870-08dbaeb5c888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmBpHkWc4H1qTsF9apYYl9edOvPfWt9DTnSPVLbKn78y7vMHe/5e9MoyLiSU9KZD9uyzJWozOHePFlXpI8q6+k76jRkmFIAFH0q0DPO4QOIA7/lKxJLcTB+TkngzZiTPwxnaQsObPcicDYmIG0wdV4HuPhV27LWjRMmDNSgA0OnjmphhqgVeCBd1haS97HsQc8nR9XxBQwJNAmJ51qKepY1ecIhGY8oMqTat3Mn47U4ZzBFKYAJr+pPT9xylKxPUFe67B7zPECnrICEUrIUyGjEnpmMYfp+YSzeJVZTP8XIz4cnRp/K3ESG42xIC8ojoi297ixEh09mXmM2uxMFOAAMuqR9pItOjitbbO8yrt2pzCRQCqi4F98I+9+V+gpUsoxVLSJoIVqNyWl/d0cBsh6URtutfPTjgwEgMYF/tzeclZsWbvU6zYDypusyxlIyeCtAguPjqRhI7KOVqrrbi6JzrOqLCcxCFOPYp6LWf1le5EEAC7w2PPsoZTR4eGB0GLUUwKxee+h8w1+XVPuljbTvHsGUaNMccOJ099B6SmOnSjDjOB7GldMisV60g6OTHVWsocVxKIqL6Ma5cYDjwYZBh4nbPNfVWkaUevQG1QQTJOK+s6eCOHTfyhPaOw9Lw53+8tTmZTxLO+u4A0aIaGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(186009)(1800799009)(451199024)(31686004)(6666004)(6506007)(6486002)(86362001)(31696002)(36756003)(38100700002)(2616005)(30864003)(2906002)(26005)(6512007)(83380400001)(478600001)(41300700001)(8936002)(8676002)(4326008)(5660300002)(316002)(66946007)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEk5dHFFc2lOSW04RWRtNUdmb2JpbysvSTVXcjFTdEZ4dURQc1Z1a1hpak9w?=
 =?utf-8?B?aS9ja3lvRWw0TkFJMFhDaEM4WnllTFhCdUFVMkZPbzI5WDd6TytDdjdvRUVo?=
 =?utf-8?B?WHJQYkhEQzBWSDR4V0dqa2g5RW1nYm5WOVJiWW9VTEVZb2NDa0hzWmNtajFG?=
 =?utf-8?B?b3E0T2xoL1Ezcnh1ZUxhS2J1Q1BYYTZQZjk0MkFQbmxOUWdCVHFTNDUyWjh5?=
 =?utf-8?B?SkNGa0Zqd3pXNkhpMkRMMjY0U1AvbVh0VjdXeHdPblNzanc2MXdhcmRibmpU?=
 =?utf-8?B?OE9mWldMUlE2T2xzS2ZNRHRVeVoyVmJoZTNpYy9oRk5STHBBSWJyRWRNU0pF?=
 =?utf-8?B?a1lrem9hV1ZhSDliSGJnSWZzSXczOVNPVmNHSVdHU1hTdU1sVjlCVVl6STJN?=
 =?utf-8?B?ZU5OWEtKbEl3aE1LT3RBblRGbkxOT1J6dE9hVVhCR1NFWHdzNHFoc1g0TGdi?=
 =?utf-8?B?ZWVLZzVnZGFUaTd1L2NtVXlNTmFLaHdVLzhCcE1UU1Z2YWZ5aUsrR29IemFl?=
 =?utf-8?B?TmZYWjRCalovMExpQ2hxUXR5RmNSM3J4RjdJYkhRaitNSStlKzJieWZVVDJn?=
 =?utf-8?B?ZVNzWVJ0V3NxdVlWUFM4dHp0Z0VCSkpRdGM5ODBLOWFvNk41c1VVR1dBbWVk?=
 =?utf-8?B?cDNhNWtHdjkzZ05XR0JJRGdXakR4ZDVzdVlXaWhyd3ZDdkNzaWFBWW1Pa1R3?=
 =?utf-8?B?N01tK0huZlBOcStwcU42cXpjRUR6ejB1bE5WdlhDQ0JNaHNiM3BaZ3BPWEND?=
 =?utf-8?B?MEt0aS9ReFZFWXdsNGRXaXR2NUp2clliMWlPMmRrdXdiWmZXUUJVRnJTRFUx?=
 =?utf-8?B?MldyYjZzUEc2dGgxc0NkVjdxclJQMFNYYkVnVU90SU1yRTM4ZEUxY2RMZmpk?=
 =?utf-8?B?UzlickxDZ00yUFF1VmZrc0xUNkVJZXhUSXBqSDhsUGtyVmFpUHRMVzJldGZ0?=
 =?utf-8?B?c01KL3lVR21FejdyQ2prMGVya2NNTEEvRGgxLzlIelgveGlzVjFhN2JiZG5F?=
 =?utf-8?B?cFRra0txTE52d2pyNTQzVGdxb3l0TkZPYmQzWjFOZzQvaUkzWHo2dWJCaDZG?=
 =?utf-8?B?UWQwT1orU2pRc1EzQytBRDlsdEkyd0lVRklpSXFoSzl5ZGtwanJ2RTNTQzFK?=
 =?utf-8?B?aWlKNWNZRzBKTGVBRTFDUlRWdGlQUU5kNTFNc0RxNnNRVVo2eGVNMkN1NGZj?=
 =?utf-8?B?d0tZaVNCMlhwbWQrdzNxVlZzZTdtTXRjeXBrNVB3WWNLV2FsYXh5OTQrUndN?=
 =?utf-8?B?TGJCcTUxaCtvZVdrNkpMVEQzV3lSV2lYRWNwVytiaDZKUFltSjRya0RIaHNG?=
 =?utf-8?B?azB3bDI3WTZpblRBYzF0ZUtmYll0OEFGdXJMK21YMFppenQ1S2NiYVNSaHBB?=
 =?utf-8?B?STV4RDlUU1ZPRDlSTG14YThSbjAzY09UTFlqamRCTGVmUzk2RkhSeFdkaVZK?=
 =?utf-8?B?cTRGLzJ3dXV6MDA5dGpCTDNXQlpFLzdNeWI3ZGh2dFJwUW40d0pKR0F0MjBE?=
 =?utf-8?B?NWtPL2NibVBaN2E5L2p1bVMwcGhZdjZFbXJrOVlxcUUyWkFsOHB6QXN6bkNY?=
 =?utf-8?B?RE13ZTNKNkdGRWk3NEhTeHlvNy91Q2p6MkN6UDlUeWU2eU1NTUZlSjdnblR1?=
 =?utf-8?B?TnduTFAyVVJ0QUlLVks3YXFjZ3BZemdVajEzSEpTcEJEdlVLTG5yQzZlVGJ1?=
 =?utf-8?B?d1lZYW0xbXFaNjRSNXR5NlkxUXFIcFgrUWduYWYvNlRzZXF4TlRuUUlkbFc1?=
 =?utf-8?B?SXRJVHFRTDhHRkZBS3BtS3JGNHFPV253bURTV1hwSmJ4RzhCamgyT2kzR1FF?=
 =?utf-8?B?RXFDY2N4VGw2UGZ5MWZVa0ppcEEzRFQwcGJKbVpINWFoa2Q1U3JHS3NkM0ly?=
 =?utf-8?B?anYzL3hLNHJmT29McTZ6UDYweUJsK2ZVVjQvR0tJemtHaWF6Vm93L1RjcG81?=
 =?utf-8?B?bExYZkdhdHVwL0drampHakFGMkZLSW1RZ01vWnVWMW0vcE0rV2IzZ2NYb2lH?=
 =?utf-8?B?ZmQ3UFdtNUNJMVN2MkxDYXY5ZFhDTkRaRzRSeDYwMWd3RW13WEtmV2tiSXFK?=
 =?utf-8?B?VEZkZmtZSnlDZ3JiajdGQitwbnZEcmRTRnVsVTdnREgwVWlZZWNGUEdMZ2lq?=
 =?utf-8?Q?KJ0jdSdIRu3teeznussiII3QE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383ccef7-c12f-4361-9870-08dbaeb5c888
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 08:46:38.2882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scOXCyzsDLfBsSBCxlQuah8OP+2V/LIzBz5uGHgvXDGd8QV8EkUuq7IQaZNDlDBx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.09.23 um 17:36 schrieb Shashank Sharma:
> It has been observed that task_info struct makes it difficult to
> handle amdgpu_vm during a GPU reset, due to it's parameters like
> task_name and process name.
>
> This patch:
> - removes task_info struct from amdgpu_vm and moves it into vm_mgr
>    as an Xarray.
> - creates a PID vs task_info mapping to index task_info from this
>    Xarray (similar to how it is being done for PASID to vm indexing).

That's a good start, but the fundamental problem is that the task info 
needs to exceed the existence of the task which it describes.

In other words we can have a GPU reset for a task long terminated.

I would rather say we make the task_info a separate reference counted 
object and each job/hw fence gets a reference to it.

I would also completely remove it from the VM structure and code since 
this isn't realted in any way. Rather put it into fpriv instead.

Regards,
Christian.

> - adds additional changes to support these changes.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 64 ++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 12 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |  4 +-
>   9 files changed, 77 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d34c3ef8f3ed..8568ced570c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1539,7 +1539,7 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>   	if (ret)
>   		return ret;
>   
> -	amdgpu_vm_set_task_info(avm);
> +	amdgpu_vm_set_task_info(adev, avm);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index fb78a8f47587..24b9a841db54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -316,7 +316,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   	kvfree(chunk_array);
>   
>   	/* Use this opportunity to fill in task info for the vm */
> -	amdgpu_vm_set_task_info(vm);
> +	amdgpu_vm_set_task_info(p->adev, vm);
>   
>   	return 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 56e89e76ff17..cd8aef1135e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1762,9 +1762,10 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>   	list_for_each_entry(file, &dev->filelist, lhead) {
>   		struct amdgpu_fpriv *fpriv = file->driver_priv;
>   		struct amdgpu_vm *vm = &fpriv->vm;
> +		struct amdgpu_task_info ti = {0, };
>   
> -		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
> -				vm->task_info.pid, vm->task_info.process_name);
> +		amdgpu_vm_get_task_info(adev, vm->pasid, &ti);
> +		seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti.pid, ti.process_name);
>   		r = amdgpu_bo_reserve(vm->root.bo, true);
>   		if (r)
>   			break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6238701cde23..44fb16eba749 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5192,8 +5192,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   				memset(&tmp_adev->reset_task_info, 0,
>   						sizeof(tmp_adev->reset_task_info));
>   				if (reset_context->job && reset_context->job->vm)
> -					tmp_adev->reset_task_info =
> -						reset_context->job->vm->task_info;
> +					amdgpu_vm_get_task_info(tmp_adev,
> +							    reset_context->job->vm->pasid,
> +								&tmp_adev->reset_task_info);
>   				amdgpu_reset_capture_coredumpm(tmp_adev);
>   #endif
>   				if (vram_lost) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 78476bc75b4e..3985b9b10b46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -58,7 +58,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		goto exit;
>   	}
>   
> -	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
> +	amdgpu_vm_get_task_info(ring->adev, job->vm->pasid, &ti);
>   	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
>   		  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
>   		  ring->fence_drv.sync_seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 12414a713256..cb3bde5ce682 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1329,8 +1329,10 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>   	amdgpu_vm_fini(adev, &fpriv->vm);
>   
> -	if (pasid)
> +	if (pasid) {
> +		amdgpu_vm_free_task_info(adev, fpriv->vm.pid);
>   		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> +	}
>   	amdgpu_bo_unref(&pd);
>   
>   	idr_for_each_entry(&fpriv->bo_list_handles, list, handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ec1ec08d4058..95bea7690bb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -161,7 +161,6 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		vm->pasid = pasid;
>   	}
>   
> -
>   	return 0;
>   }
>   
> @@ -2439,6 +2438,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   #endif
>   
>   	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
> +	xa_init_flags(&adev->vm_manager.tasks, XA_FLAGS_LOCK_IRQ);
>   }
>   
>   /**
> @@ -2453,6 +2453,9 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>   	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
>   	xa_destroy(&adev->vm_manager.pasids);
>   
> +	WARN_ON(!xa_empty(&adev->vm_manager.tasks));
> +	xa_destroy(&adev->vm_manager.tasks);
> +
>   	amdgpu_vmid_mgr_fini(adev);
>   }
>   
> @@ -2498,6 +2501,20 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_vm_free_task_info - Finds and frees task_info ptr
> + *
> + * @adev: drm device pointer
> + * @pid: pid of the process in vm
> + */
> +void amdgpu_vm_free_task_info(struct amdgpu_device *adev, u32 pid)
> +{
> +	struct amdgpu_task_info *task_info;
> +
> +	task_info = xa_load(&adev->vm_manager.tasks, pid);
> +	kfree(task_info);
> +}
> +
>   /**
>    * amdgpu_vm_get_task_info - Extracts task info for a PASID.
>    *
> @@ -2508,14 +2525,18 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>   			 struct amdgpu_task_info *task_info)
>   {
> +	struct amdgpu_task_info *ti;
>   	struct amdgpu_vm *vm;
>   	unsigned long flags;
>   
>   	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>   
>   	vm = xa_load(&adev->vm_manager.pasids, pasid);
> -	if (vm)
> -		*task_info = vm->task_info;
> +	if (vm) {
> +		ti = xa_load(&adev->vm_manager.tasks, vm->pid);
> +		if (ti)
> +			*task_info = *ti;
> +	}
>   
>   	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>   }
> @@ -2523,21 +2544,44 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>   /**
>    * amdgpu_vm_set_task_info - Sets VMs task info.
>    *
> + * @adev: drm device pointer
>    * @vm: vm for which to set the info
>    */
> -void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
> +void amdgpu_vm_set_task_info(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	if (vm->task_info.pid)
> +	struct amdgpu_task_info *task_info, *old;
> +
> +	if (!vm->pasid)
>   		return;
>   
> -	vm->task_info.pid = current->pid;
> -	get_task_comm(vm->task_info.task_name, current);
> +	if (vm->pid == current->pid)
> +		return;
>   
> -	if (current->group_leader->mm != current->mm)
> +	task_info = kzalloc(sizeof(struct amdgpu_task_info), GFP_KERNEL);
> +	if (!task_info) {
> +		DRM_ERROR("OOM while setting task info\n");
>   		return;
> +	}
> +
> +	task_info->pid = current->pid;
> +	get_task_comm(task_info->task_name, current);
> +
> +	if (current->group_leader->mm == current->mm) {
> +		task_info->tgid = current->group_leader->pid;
> +		get_task_comm(task_info->process_name, current->group_leader);
> +	}
> +
> +	/* Replace and free if there is an existing task_info entry */
> +	old = xa_store_irq(&adev->vm_manager.tasks, task_info->pid, task_info, GFP_KERNEL);
> +	if (xa_err(old) < 0) {
> +		DRM_WARN("Failed to update task info, pid=0x%x pasid=0x%x\n",
> +			  task_info->pid, vm->pasid);
> +		kfree(task_info);
> +		return;
> +	}
>   
> -	vm->task_info.tgid = current->group_leader->pid;
> -	get_task_comm(vm->task_info.process_name, current->group_leader);
> +	kfree(old);
> +	vm->pid = task_info->pid;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ffac7413c657..33f333d864b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -302,6 +302,7 @@ struct amdgpu_vm {
>   	struct dma_fence	*last_unlocked;
>   
>   	unsigned int		pasid;
> +	unsigned int		pid;
>   	bool			reserved_vmid[AMDGPU_MAX_VMHUBS];
>   
>   	/* Flag to indicate if VM tables are updated by CPU or GPU (SDMA) */
> @@ -325,9 +326,6 @@ struct amdgpu_vm {
>   	/* Valid while the PD is reserved or fenced */
>   	uint64_t		pd_phys_addr;
>   
> -	/* Some basic info about the task */
> -	struct amdgpu_task_info task_info;
> -
>   	/* Store positions of group of BOs */
>   	struct ttm_lru_bulk_move lru_bulk_move;
>   	/* Flag to indicate if VM is used for compute */
> @@ -374,6 +372,11 @@ struct amdgpu_vm_manager {
>   	 * look up VM of a page fault
>   	 */
>   	struct xarray				pasids;
> +
> +	/* PID to task_info mapping, will be used in reset context to
> +	 * look up PID/TID of a reset
> +	 */
> +	struct xarray				tasks;
>   };
>   
>   struct amdgpu_bo_va_mapping;
> @@ -465,7 +468,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   			    u32 vmid, u32 node_id, uint64_t addr,
>   			    bool write_fault);
>   
> -void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
> +void amdgpu_vm_set_task_info(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> +void amdgpu_vm_free_task_info(struct amdgpu_device *adev, u32 pid);
>   
>   void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 5431332bbdb8..3704556210d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -992,16 +992,18 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			uint64_t upd_end = min(entry_end, frag_end);
>   			unsigned int nptes = (upd_end - frag_start) >> shift;
>   			uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
> +			struct amdgpu_task_info ti = {0, };
>   
>   			/* This can happen when we set higher level PDs to
>   			 * silent to stop fault floods.
>   			 */
>   			nptes = max(nptes, 1u);
> +			amdgpu_vm_get_task_info(adev, vm->pasid, &ti);
>   
>   			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>   						    min(nptes, 32u), dst, incr,
>   						    upd_flags,
> -						    vm->task_info.tgid,
> +						    ti.tgid,
>   						    vm->immediate.fence_context);
>   			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>   						   cursor.level, pe_start, dst,

