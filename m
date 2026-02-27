Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5814AFD7F91
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 10:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E859B10E136;
	Fri, 27 Feb 2026 10:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pbRK7PUk";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1850110E136
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 10:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tik+USn8sMgy7rP9sCd0K4Lp1yKpGsc7eQ0cG0S25ZFKdn22uMKDLFWFh2GAeI3H/rhWE7FLna79YjOeBGOKC1IAV8IW8BC5WjQMbAYuyaup1va7k8psuITSvPGSMn2S5ea3EDnCDNtDcYjRMJ6F1Eq1vdI3nfeQMOud81JAeWNupX793rK7k0MWkz6TW6dgTKtGmU29wTyUZGRb/nA+EBW/remJOag1c+MrU1q0fXsvtO7ezWHNMO1lthdpo8JMYKiGJlqTjw9DlJXH5X6zln5bDa+PokUqiXQkyxtL53An0AppSAdoyFDyABJCOic+6O5+KzapSzkUf+9R1tme3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRHnvZ7qGK7B3/xXYd48lupAgkIJTeL6665oOcfRgTY=;
 b=Beo4o7Il94z+nNQiGPp2KVnpeQerH9k4hgXTjUKzkz/5j2it3eXCEJiTSUY0tEHvbQHtI+mQ7+lshUgmIksbLVeti/yuNEeoynvh9zdYurbYSybP0iVZnMHbn7zCy2U2+iU+7DvI3XlSkgJzdhykvo5HV7thbCMn9/JXwsyhRScrOwKJG/iwT85p9U7PdQRGlo4WCfsrdn3lJAFs4cTlSTcZsQmLgK/FLiy4VidpGgm05R0RyhGZEGavFvUxFrchorQsyaev83s1zz6z3k3XVVzVRNKmmxHgbiOdsHo0fzb8PMYPeB2/m0wncCHoNO7ddZdP2Z/RZjs4rnpNGGbLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRHnvZ7qGK7B3/xXYd48lupAgkIJTeL6665oOcfRgTY=;
 b=pbRK7PUk5rXbNsPjMAbz/7ZHIQHQlEbOLj1lLvdfVf8j5HbEVyVOh/iv1so9mMPD68HLcGALRIZiHe7vrk53JsD4mXTU06jy5+LaIK0gVGHGQzGdCxAl2Nzv1kSyBV+3GQV97p8f/7lbOVfsmbX9mlptmnBWevWbePclx98pcTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPF4D923B935.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 27 Feb
 2026 10:27:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 10:27:33 +0000
Message-ID: <2e6929f4-a687-4601-89f1-3ce28efe6847@amd.com>
Date: Fri, 27 Feb 2026 11:27:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix null pointer access in
 amdgpu_userq_signal_ioctl
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260227081307.2861605-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260227081307.2861605-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPF4D923B935:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e3b57b-117b-41fd-fcca-08de75ead15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 8HliiMjBLHxh3Jk7V/GVgFGfHYzXksar4PfzORaEbi3wnJitYpqEwNillhu1tqbz00D6pNHDQ0GJjc+wEhoml8eT2XvYQlLcL8kSpv75Ef4jjPxB1GxYkuhufj4aFCM3OuYneZHjh/mZzkcX3nb0K5YtZweh8yFYsm6ls7ihvAaYWYQ36Kp/5YOefF94PHrpRFKqPOQBmuAT/3GqaOiQ8cui9eCnz0yzoLsFSuDXg/PNzQbnic3iLzJ+sL4ha1d7Gwuat36JebSeWGghHMyv8pT3YESYdl278iW0UakE5KJLXObreOpiUf/40CCgfPvLzaKEJRcvRau2HusZCJjEZIwf/4xpBBMQLfePcJseM1Pm33wuZEktPRkN5tCIVgSIho5lH0CREYXKOIhwWFf4+iZKwztXVDwEMinQlwPvqdnC69Zx0xp1hUqRa15Xy7SDprXMguMiUZsipwOv2YByOhf4lvLz5k2wQduCQin12kNh9hO6Q5vlTi1l7xjWkAVUnIAf6pOHDfw1v8hDRUBmeymbmNIfCIgiaUHtbjEx4yVQKEXGD9+Em+5BMetfnuWVFj7FXBQ87uM4aPhFs7WvNFdEOoX8jVbgZ5e5Eb90QJUvGfq74UNLmzSsPsYa+cvt5Cixr/PtguEyPm3kQeFWLQ1OYXwr7R84dc+TDIgM2PUdCYjnxvV0jBAbIYDiVO6trR1iXooSkBOJ94gd9G2paRLiHbJ2tpRq3lkPlFM1j2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlNcDUvOFdhK3NPNGtRbTUxWlNCbkdoNStZOGVGQVRkdUJjMGZvS2xyVnlZ?=
 =?utf-8?B?dE5DUjdWOEJucmE4eEZiUDFzN2xtenpnSjZjbGJxblpMWFpKUE9haEMvTVEr?=
 =?utf-8?B?K1lland0UHJ6YW5DY3dLbERxTkt2RGlZU01zRjdxM3dESlpGN2NyTWtRV29H?=
 =?utf-8?B?NW9hYXZ1MStLVUhhWThkZ2lYb1RFVUpMVi9SbVdtWGJibWdmQ2EvV05WMlFI?=
 =?utf-8?B?dStZQ0w2eitNMVVnTFp5VUNuY1J0TFV2dnhhOW9xcTVYZlNTaDJBZ1Jzd09o?=
 =?utf-8?B?MHVhQjlSUEwzVEJEaG1ZSFAySG1iSDB5b3oraFllSHRtcS9Pd1ZzYTJnbWRv?=
 =?utf-8?B?L3VlazhPWGtkcDU1KzdFMG5rdWRlV2FjTkFiUU4raXMwWXJpUnRRUCtDVlI5?=
 =?utf-8?B?K0F1MTBBZ091MytKVkZPWjMxS01rTDd3SnBLbGZyTTdnT0N5aHZvOHgwNmdm?=
 =?utf-8?B?dVQ5RE5NQ1VVa3VuUHZmMFhZeVNIT1Rva3owQ0ptRnNQZ0VvNnBsWUJCaVRQ?=
 =?utf-8?B?dllkNDMvWkpEYStodU1tbjhQcnlVQ2sxY3VpTXRYWkZGWTBzZ1h5Zk5kNjJD?=
 =?utf-8?B?aVhySDN4QWRQOFkrZXdaZ09tZFdacTRvQStHdzN6RVczaE5wSC81WDdYS211?=
 =?utf-8?B?MFozYmNFNDl2NS9Fd25GRkgybkRSVElqZ3I4QjUvOHBTb0N6cTJYVUJJUWJN?=
 =?utf-8?B?TWcyVEZuTFN6ZGdxS3V5cEJtQkd0TTdEampZaU0ycUZiSUJMazNDNjRiV2Rk?=
 =?utf-8?B?MGptZE02WWZBWk1UNHpuQzFJcHFyL25oUG1tTmIwWjJqWUs0bUtMVXBIU0Zq?=
 =?utf-8?B?VGpid2RIaTd5RVozakpJL0RJdFY3a20xeXh6bTNSTythZ1VoTGdBLzJtTVQ5?=
 =?utf-8?B?VzdNdllPajQ2MU8xN20zd3VLWTBNakQ1SVBpK010SCtOWHJhMjBZNEgyYU56?=
 =?utf-8?B?K1UyNXgwc1NUOS9DbEVINFRMOTRpYy9wb3pSNWQ4eDNnaitnWU1ScEtHUEdj?=
 =?utf-8?B?MnFpYmJJamFoVk5hdWRLUjVuZU9udE9NQTFGZGhJNHNXVERVWkFzZk5XWCt0?=
 =?utf-8?B?ZUI3SEtHVUJQUjVoTzZqcUlyY1pVMmVaNEJGMjljYmw4SVRJbitWb2tZVDB2?=
 =?utf-8?B?VkhQZ2hUSEJabDg0OE9sQlhqdWlGQnZ1VFVmWXhpR3JXdTkwQXI4TUpVOTdl?=
 =?utf-8?B?YjVwQzZoS2ZhR1JaazdmTFlCU0ZTNHVWaW9jL0ZnZGszWDdtREtJcENyczlv?=
 =?utf-8?B?UVovQzVXdE5BdkhyN24zclBRc0tvT0Q3WjYxaVR5M1FqWUcrNnhOcmxwSXZh?=
 =?utf-8?B?YkRkZG53RnpVWU5CbG80eERDRzdvbitubm1pcm1VWW8zbWZhVXZDY010Q04z?=
 =?utf-8?B?RHBOcXF0WXU5SXBQVHdnR2NTaFVYcm5uUlNGNWR6OHRIV0xjTTlUUFRLd0FG?=
 =?utf-8?B?UE05TldQZFdhV1k2Zm9kY294aDA4Rm5WN2RwNVU2TVBDWlg1MDJNSDd2ODJo?=
 =?utf-8?B?ZzNmazdhdmxnTFRveHFQZHd6WDNsemxya1daaS9mU3NJeWNWdGdBajhydnRr?=
 =?utf-8?B?aDloNi9NSU80ZkJ6bGJJejNCanZyUDdiczBhSUFSbVZVaC85OHNkTGNVYUFP?=
 =?utf-8?B?RE10L3YzOXdNMkwvUUxQRVRXWTBzdXNpc285c1NOODBLNENBelF2MVp2czdH?=
 =?utf-8?B?N0ZHVXJCYlUxRHU3Q3ZYT0FZZ2FISE1qY2dVNGxDWXBOdlBZRFcyM0s1UEUr?=
 =?utf-8?B?RDhQN1M2WE12eG1wMjFTVlI3Y2lPUUg1VnVOQXJGWHBWTlRBS2E4cmJud1Jy?=
 =?utf-8?B?L0lrQ3Bra050cmo1N3NENkFZNjRYMzluQ3NENXdyVXdRdnIxTkZidFZtNlFJ?=
 =?utf-8?B?WXdETDJ1NzJQZkNyK1lqMXpKUEJoZWJFQVpIOGxvYjIzWUFVVkZGeU5hL0N4?=
 =?utf-8?B?Q2dyVUJCRzRLY212K1BFLzVOS3Q4ZlpmSjN5TDc1QmxIbDAydGQ4K0cyQkJt?=
 =?utf-8?B?dXZoVzJDYnpVN3dDZ1k0QjBvQjl2NU4vNUVPcXJQOCsvd3dySGNsTDBiTEMx?=
 =?utf-8?B?ZllPUEkwMUpNZE94eUJQWmN0Mlo2b3pWYnFzVEZwSTN3THo1Y05qWThPblRp?=
 =?utf-8?B?RWx1Nm1WVlVwWVZqZms4Nzl4dnJxSnZ0MzJqaUZwbXphSVdja1l4SzBDWEtJ?=
 =?utf-8?B?cGNDeDJacTcrT1ExWTNnNXFRVUtWUnZWMEFOK2FtTGV5S1dxNUhEVjJoUEFW?=
 =?utf-8?B?NExsNjNYZkZBYUhEdFBVL1RxZFJGZEZVdUV5VlNVa1BTcTNDcGM0ZXlWc0Ju?=
 =?utf-8?B?eC9JSmhNcTl4UjJTUlpJL0Zob2NPM1JOUXUraHBQd3REQkhUdnpoZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e3b57b-117b-41fd-fcca-08de75ead15b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:27:33.2021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBfdMA20tv1HG9hTfZBgOutBiEr28/Wz73OBod4xmUn7spkWqQYuvxJkLTeHrfLZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF4D923B935
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

On 2/27/26 09:12, Jesse.Zhang wrote:
> The amdgpu_userq_signal_ioctl function was triggering kernel page faults
> due to missing null pointer checks when accessing gobj_read/gobj_write
> arrays, and improper handling of memory allocation for these arrays.

Sunil is already working on those and IIRC has send patches to fix that to the mailing list.

Regards,
Christian.

> 
> The crash stack showed the failure originated from the ioctl path:
> [   64.977695] Call Trace:
> [   64.977696]  <TASK>
> [   64.977700]  amdgpu_userq_signal_ioctl+0x8e4/0xda0 [amdgpu]
> [   64.977830]  ? tty_ldisc_deref+0x1a/0x20
> [   64.977834]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [   64.977934]  drm_ioctl_kernel+0xab/0x110 [drm]
> [   64.977955]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [   64.978071]  drm_ioctl+0x2cb/0x5a0 [drm]
> [   64.978088]  ? ttm_bo_vm_fault_reserved+0x1ef/0x410 [ttm]
> [   64.978093]  amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
> [   64.978179]  __x64_sys_ioctl+0x9e/0xf0
> [   64.978182]  x64_sys_call+0x1274/0x2190
> [   64.978185]  do_syscall_64+0x74/0x950
> [   64.978189]  ? ___pte_offset_map+0x20/0x170
> [   64.978191]  ? __handle_mm_fault+0x986/0xfb0
> [   64.978194]  ? count_memcg_events+0xe7/0x1e0
> [   64.978197]  ? handle_mm_fault+0x1cc/0x2b0
> [   64.978199]  ? do_user_addr_fault+0x394/0x8a0
> [   64.978202]  ? irqentry_exit_to_user_mode+0x2a/0x1e0
> [   64.978205]  ? irqentry_exit+0x3f/0x50
> [   64.978206]  ? exc_page_fault+0x97/0x190
> [   64.978208]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   64.978210] RIP: 0033:0x7f3c08b24ded
> 
> Fixes: fd4fde1df18b ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 22 +++++++++++++------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c30512a6266..d795d01d9969 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -467,7 +467,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> -	struct drm_gem_object **gobj_write, **gobj_read;
> +	struct drm_gem_object **gobj_write, **gobj_read = NULL;
>  	u32 *syncobj_handles, num_syncobj_handles;
>  	struct amdgpu_userq_fence *userq_fence;
>  	struct amdgpu_usermode_queue *queue;
> @@ -597,13 +597,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  exec_fini:
>  	drm_exec_fini(&exec);
>  put_gobj_write:
> -	for (i = 0; i < num_write_bo_handles; i++)
> -		drm_gem_object_put(gobj_write[i]);
> -	kfree(gobj_write);
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		if (gobj_write)
> +			drm_gem_object_put(gobj_write[i]);
> +	}
> +
> +	if (gobj_write)
> +		kfree(gobj_write);
>  put_gobj_read:
> -	for (i = 0; i < num_read_bo_handles; i++)
> -		drm_gem_object_put(gobj_read[i]);
> -	kfree(gobj_read);
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		if (gobj_read)
> +			drm_gem_object_put(gobj_read[i]);
> +	}
> +
> +	if (gobj_read)
> +		kfree(gobj_read);
>  free_syncobj:
>  	while (entry-- > 0)
>  		if (syncobj[entry])

