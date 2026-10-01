Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EA9CA5FB3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 06:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FADD10E076;
	Thu,  1 Oct 2026 06:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0vECd6j0";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2678310E076
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 06:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyvzfYGfLVAk0tCaY5Hj+f3QDOMh7lDMzdU42KPQ0gHsMaZQg/76CH9aClZZm4LLfVN7+WKBQYQJjEmTEeE4aq/WkRNpX9bwd2FtDK8M0VUMkzFj/TItGnFVz+jQHGQVBzkUKy4MBfFgKBxbQn2xk7x7K2MB8djfMCYGCkTNciN6qk62fipkK0hxCyQZp/5UhoXuCUvltuSI9Igl2IUNaug4O9ua0evQphlMoTUZU1Kn1SRIN3Xsbguty/1OflA5TJZuIiS/mHgXhuEzFykjQ7/BAx9VJPEk6GTU1JHjoDqIGyj9bFAjYAWp1H2wAxVZJjP86dI/2RW2+R5kg6zmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYbUm+O4VcITc62SL9c1e+N6Qod+AeN92jZPsLBrVRU=;
 b=w7CQhBXBMUDqzEt4YpD55kmO5mtYeJ2Gxs0sAilh4aD1MVHbww183gOIlBSzK4joDspp2YhTAAul95y9j7MwSasMvWxDSAocpWy/zPIW1Lw7cWQ2S1pxC53QNjU+ZUvhR1nc/pFpfxo8dl8Nv8ruHzlbRn0tZvdL3EKAwhWjDgISemPoDrQbTTHb0+1ZgRsWnJXFwcwllXjoArTZN8w1VPQduQeXsfH3mkpStlT0B6v5leVqvWS1lhM9ALbes3fyuhPqrD7+LvqQj0gE/oXlSV6w3qCNItVr5JovMG1EyXxbYGm/TqN0OZLs+HVyLNrJwPW8G/mgINTvmwfrbF75TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYbUm+O4VcITc62SL9c1e+N6Qod+AeN92jZPsLBrVRU=;
 b=0vECd6j0Nw5RhDdgKaAGUHBcBKqO6aNPdELWDls4OLtCqx8PFmIG4DEC1mhZsVqtp8HZHWnA1BICYEqPPIaTCS7sqZISg9SV9b7RfWNMLegbMsnw9iqXsRULIm29V23z+jYHJXwBc4Axq5wymLCFFEjTm/C3C4DX6EcyYxjTBj4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 06:12:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 06:12:14 +0000
Message-ID: <957a0ec9-a772-400a-b633-ecf41d16a2b7@amd.com>
Date: Thu, 1 Oct 2026 08:12:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, vitaly.prosyak@amd.com, tom.stdenis@amd.com
References: <20260930154934.27981-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930154934.27981-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: f846ab4c-a25e-4ec5-bab6-08df1f82efba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8Fun3inZmUbN2o/HjT4YCNc8JlkEhTC+bnPhUW1zn7Saio4jZGLcjdnLEp9sLAUZgE5Nrpl114ZmZ88DEq2BDucgIBrvyWSFv1zQysW0PoAu8cdIfpdwXNlEUxBt1Tcun+yT2oV7+Hdx/hGOZLWmsnD6OmYxm8WLB44GVc+nOaPqTEwW1/URzgvmWfKQZzh5W5UwMQtcIO2vrkeGZ+KSzwOKT1MXBOEP6DlnBbUSubPrIhMglN2P5jadfoRgs1DsUPiWRm/xN3aYVxDSWIcRQNShkhx2PuAXlEaNd2JBGAz88QOgWbbmWaU0xrQ4Q9eiYcVLkmKko/64jZhfSfhjHH+Rm/78S8iT7HBpbTPwNnFwuUVHsOBMgn19zYiC4Ps/LO0djw1/vCduhsxEJDRNkBfnh5UtqbmNMtZHE+NOfhIadI1CFxoqn8SvxQ26VOBKCyCCRpy8+zQ3S11FTzdiUhaZWGcSx4FrJiWYlvpsGnn8J2fc/bmNGgPoeofUUGtw2GV3jJv9+//g8Z04qEPGSEd7/6WJKDjoLwpOi8ncLiFBapXniSWpCHqOYYKXoi75Njia9i6PlV6VwVhBoR1LbmBgCFIPWRyRYEBSOUd2Dr9TbCSgKX9IN0im1YsnGMO+HhiWtp+ynPDrUptvZO1J3dw7ZnjdFd26ah94cPTGzyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzl0eTB5ZU5USnl0OHBTam9Gc0pFSGhGNFRZa1JmalNhNTYvQktRZGhpbzc5?=
 =?utf-8?B?YkVwa3NCRGtVNUlGTHppRVgyUjhSb1d4U3hxM0RPdDRLWVJXcXhzTkJlTTkz?=
 =?utf-8?B?RzJjdGRBMm80ZWJncE1kU3FUcUpRdHN3R2JXWEpzTEhLMHZkc3pRZHJsNVFP?=
 =?utf-8?B?NGVtTzl3dDdZYS9JTVZtK2laODh4Q1NzVUY3Z1I2MHZyYkRzMXgxTTBCN1hz?=
 =?utf-8?B?QzhvTWJia3ZLUldMbWxPMFZqSUVBUEovc0E0cTdzT1M2SWEyS2Foa0g2dnV2?=
 =?utf-8?B?VHNCZGV3ZU84RXRxNGpLQ1ZvSmNMQmZEdlM5c2xjWHFRRGdWa0VYNXY0RFUy?=
 =?utf-8?B?bGUybnYvOC9IbDlOYTdYQ2xKYVk5QW9ha0w1RFdmQ0srT2NpM2JaM3lHZmw2?=
 =?utf-8?B?eHNzOXZIRzE5NDI2cHZ3am9LRGhOV3lBUWhOVGhwZTFIaC9ENDA1K0dMQkJu?=
 =?utf-8?B?Z2VsaFFwOWZKWHh3bEFNcURoem5hdjhhUnVva3Znbk41Mi9xcWg5Y0FPdzFX?=
 =?utf-8?B?YnJOUnovZ1lSM0dmWVMzeGhEcmxuZTVDTTBXV0ZYWURkZTFHR0h3bGZhWXR3?=
 =?utf-8?B?ZVZiRUpYdGlEalNKUnFLNW51R1E1eXoxdk9hVlArMnJuakl3bHpxeVkzR1lC?=
 =?utf-8?B?TXAwaytjMVl0allMOUpGNkdVa3lnZVFlMGFJS3ZKZnUwYW9hSUlTQnNzdGVk?=
 =?utf-8?B?ekZrUktKaFdPcmxvUHp1eEdDcWduWG02T0c4K29oWFI0aU5iWmJ5NHlkTTV2?=
 =?utf-8?B?Z0QwTnZBUHMyTFpkdEV1ckZLRnB3UkNHRnl2OVlVRFhMM052elo3T3oyQmpN?=
 =?utf-8?B?eStuK1pyYitsWWtZY3hXemVieFdWWGpYZ1IyQ0ltVlV1M3dPd0xZRXZtaWFM?=
 =?utf-8?B?LzR6ZUJvREJuYnRjaERGTTAwSVQ1ak0vQ0pIZHEreXRNSjlGSmJyTWdCWUM0?=
 =?utf-8?B?V09peG5zSEZnOWdaaGwzbG50U1hzWnBaZXkyS2dnYlp1SWc1aDNiZkxjWWxD?=
 =?utf-8?B?QStTallYbGd3T1Roc2gwNThsM1JEbWdjbTNQK2RpemdCV3k3bUZ2d1FnVmhi?=
 =?utf-8?B?Zjk0ZW0vZlhKblgyT1NEdG1ubzVKM3ltT0wyanpzVUFlaWtZQWM0UTJ6Q01T?=
 =?utf-8?B?ZGZxaS9VbDJDeUptUkRoS2NZMEhBUDd1MCtTRUFmK0VIQkpSNmZmWSthYVQv?=
 =?utf-8?B?MngvSVRCT1ljbXVJeHFTekI3M0hFN2xmLzQ5YnMzaE9PaGJaY1pkT1FjSmlU?=
 =?utf-8?B?NDZoNzZnRXYxRUwyMkllY1dnck5GeklsRWZYcXFwV0pwa0owUEhzTkNhSktq?=
 =?utf-8?B?S1JpSTVMSkpUK01qb1p4b3pxTkFoQ0t6cXVFQmFaUTZrLzJGdXlCaHhteWlu?=
 =?utf-8?B?TS9IVlhVZjJlTHV3cFN6U3hOd2VabmxQMUhXVi9YZncyRDJPM3hHNVdHUUZX?=
 =?utf-8?B?MnVoeVBKU2NNYk56MXFZTi9JcG9xSFFlMVZYUFk4NUQ0M3RkNHRDT0pTSXlR?=
 =?utf-8?B?aUJGbXBqQ3RFNGRzRDFKQ05pbWZvZnN4aFRwVU1mcTY3VmZHYVg3VnNYUmhB?=
 =?utf-8?B?SmdKWjB2VjFDMWpEU1RrMEMxSEtvL2oyckVQdnBXZUZ6UUMrUmdIeUIxbU9K?=
 =?utf-8?B?b0piWHZVSVRocXlvdmJBTFJtbGdDbW5LcURHVGFnR0FiVW1tZUwrbHkxWnNK?=
 =?utf-8?B?UTJvLzZvVm5DYThZMTh5c2V5WG1mMlI0UDZwdUdTRTlTQXd3UjFWeUpHN056?=
 =?utf-8?B?UHhqWlBSZklmZ3AwM1FNcG55aVBrYVgrU2twWlhNaEw0b1pGbGMyZitCTnZX?=
 =?utf-8?B?SlRFWHQxTG84SlRkaXI0M0ttS0RiamRhanVIWHR4QjZmQjdib3NmWmJkQ3lU?=
 =?utf-8?B?UVJYMlZrd1dUaFFIYUR6UWZwNVRMWWZDNVBacUl2WUpVN2xVMm9MTGdpajlH?=
 =?utf-8?B?NjM0VkdOVk5pemhtSHllR0dQWllCRFd0ZnB1Y0ZPMzdMZEN4TThlbUpvNzFI?=
 =?utf-8?B?RTdhT3FLbWFXOHZ1bkhMdTQ5ajBydWhsZWF5ZFJjandiM0EyODQrL1NuTjEy?=
 =?utf-8?B?UElaY0w0TTNXdEpGN1pESTJGVSt4bjVYNmFSRjhkUmo4bC9oQjE3QnVROHI5?=
 =?utf-8?B?MlNVWW1xMlRNbmJGTmpJSDdQbDNlWUJFWm50Y2NvUW4rVlBZeGFsOTZnZVZh?=
 =?utf-8?B?eEttdkh0bEtHMFQrakVqenVnWWhPS3VpR2lpc2dramwwemRoNFdiVVhFNFpi?=
 =?utf-8?B?N3JsSGxnMWt4VXJJT1ZmOVdLb0x4SzJYdlg5ZXpQYUVFc0g3ZkJDa3Z2S2NV?=
 =?utf-8?Q?sIQk14HdqCVQ9LVile?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f846ab4c-a25e-4ec5-bab6-08df1f82efba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 06:12:13.9507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxOfEphvlaA6vJnlc9L88PGVJfLD0kZP/1Z94e53L3BXenFax49wKt45gB8dUmic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651
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

On 9/30/26 17:49, Mikhail Gavrilov wrote:
> Reading or writing a register through the amdgpu_regs2 debugfs file
> with GRBM bank selection, which umr does for every banked access (a
> single "umr -b x x x -r <reg>" is enough, as is the wave dump with
> "-O halt_waves"), makes lockdep report a circular locking dependency,
> after which lockdep stays off until reboot:
> 
>   WARNING: possible circular locking dependency detected
>   umr/63306 is trying to acquire lock:
>   ffff8882cf4b8350 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x9b/0x140
>   but task is already holding lock:
>   ffff8881aec010d0 (&amdgpu_grbm_lock_key){+.+.}-{4:4}, at: amdgpu_debugfs_regs2_op.isra.0+0x20d/0xd00 [amdgpu]
>   ...
>   Chain exists of:
>     &mm->mmap_lock --> &amdgpu_srbm_lock_key --> &amdgpu_grbm_lock_key
>   ...
>    __might_fault+0xc5/0x140
>    amdgpu_debugfs_regs2_op.isra.0+0x441/0xd00 [amdgpu]
>    full_proxy_write+0x10e/0x1d0
>    vfs_write+0x1d0/0xf50
>    ksys_write+0x116/0x250
> 
> amdgpu_debugfs_regs2_op() and amdgpu_debugfs_process_reg_op() call
> get_user()/put_user() for every dword while holding grbm_idx_mutex or
> srbm_mutex, and pm.mutex if requested, so a fault there takes mmap_lock
> inside those locks. The lock hierarchy declared in amdgpu_lockdep.c since
> commit 1d0f5838b126
> ("drm/amdgpu: Add lockdep annotations for lock ordering validation") puts
> srbm_mutex and grbm_idx_mutex below notifier_lock, which
> amdgpu_cs_submit() takes with the BO reservations held, and
> dma_resv_lockdep() orders the reservations inside mmap_lock. So
> mmap_lock is outside grbm_idx_mutex and srbm_mutex, and these two
> debugfs paths nest it the other way round.
> 
> Copy the user buffer in before any of the locks is taken and the result
> out after all of them are dropped, as amdgpu_debugfs_wave_read(),
> amdgpu_debugfs_gpr_read() and amdgpu_debugfs_gprwave_read() already do.
> A fault on the user buffer of a write now fails with -EFAULT before any
> register is written, instead of after a partial write.
> 
> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")

Well that's not really correct since that patch only makes the problem visible and not introduce it :)

But apart from that rather good catch, Vitalies work to add lockdep annotations pays of.

> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

I don't have time to review this in detail. Vitaly and Tom please take a look at this.

But feel free to add Acked-by: Christian König <christian.koenig@amd.com>

Thanks in advance,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 71 ++++++++++++---------
>  1 file changed, 40 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index aca1a8045afa..5618bd3e2610 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -121,6 +121,17 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>  
>  	*pos &= (1UL << 22) - 1;
>  
> +	/*
> +	 * Access the user buffer only while none of the locks below are held:
> +	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
> +	 * inside it.
> +	 */
> +	u32 *data __free(kvfree) = kvmalloc(size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	if (!read && copy_from_user(data, buf, size))
> +		return -EFAULT;
> +
>  	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>  	if (r < 0) {
>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -152,28 +163,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>  		mutex_lock(&adev->pm.mutex);
>  
>  	while (size) {
> -		uint32_t value;
> -
> -		if (read) {
> -			value = RREG32(*pos >> 2);
> -			r = put_user(value, (uint32_t *)buf);
> -		} else {
> -			r = get_user(value, (uint32_t *)buf);
> -			if (!r)
> -				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value, 0);
> -		}
> -		if (r) {
> -			result = r;
> -			goto end;
> -		}
> +		if (read)
> +			data[result >> 2] = RREG32(*pos >> 2);
> +		else
> +			amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, data[result >> 2], 0);
>  
>  		result += 4;
> -		buf += 4;
>  		*pos += 4;
>  		size -= 4;
>  	}
>  
> -end:
>  	if (use_bank) {
>  		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>  		mutex_unlock(&adev->grbm_idx_mutex);
> @@ -188,6 +187,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	amdgpu_virt_disable_access_debugfs(adev);
> +
> +	if (read && copy_to_user(buf, data, result))
> +		return -EFAULT;
> +
>  	return result;
>  }
>  
> @@ -238,11 +241,21 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>  	struct amdgpu_device *adev = rd->adev;
>  	ssize_t result = 0;
>  	int r;
> -	uint32_t value;
>  
>  	if (size & 0x3 || offset & 0x3)
>  		return -EINVAL;
>  
> +	/*
> +	 * Access the user buffer only while none of the locks below are held:
> +	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
> +	 * inside it.
> +	 */
> +	u32 *data __free(kvfree) = kvmalloc(size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	if (write_en && copy_from_user(data, buf, size))
> +		return -EFAULT;
> +
>  	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>  	if (r < 0) {
>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -281,24 +294,16 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>  		mutex_lock(&adev->pm.mutex);
>  
>  	while (size) {
> -		if (!write_en) {
> -			value = RREG32(offset >> 2);
> -			r = put_user(value, (uint32_t *)buf);
> -		} else {
> -			r = get_user(value, (uint32_t *)buf);
> -			if (!r)
> -				amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value, rd->id.xcc_id);
> -		}
> -		if (r) {
> -			result = r;
> -			goto end;
> -		}
> +		if (!write_en)
> +			data[result >> 2] = RREG32(offset >> 2);
> +		else
> +			amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, data[result >> 2],
> +						rd->id.xcc_id);
>  		offset += 4;
>  		size -= 4;
>  		result += 4;
> -		buf += 4;
>  	}
> -end:
> +
>  	if (rd->id.use_grbm) {
>  		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, rd->id.xcc_id);
>  		mutex_unlock(&adev->grbm_idx_mutex);
> @@ -317,6 +322,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	amdgpu_virt_disable_access_debugfs(adev);
> +
> +	if (!write_en && copy_to_user(buf, data, result))
> +		return -EFAULT;
> +
>  	return result;
>  }
>  

