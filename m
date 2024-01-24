Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9D1C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 21:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7417F10EA9A;
	Wed, 24 Jan 2024 21:40:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A024E10EA85
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 21:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahdwJ8tiVvsaH9vBVgRSLYRw/EiPkNYvkqXaiwCV0FGVPRSCkaZrdzX5HlQsD6j3GRCBJ87Zv7MN/6AwHQ3cEShg8KpfVkizgfiVJRUoA3ePO7knGNhN/Dyw3n8lmp1dRgobBd2cRzoW0U3RT8DzfiJjLgZPgyECU65fbLThIQe0E1VSWCxdFC91k+grI2LXNJUpy3jXf27eEt+srCsiIXnPaAB3Ii8/BN2CQGXKoVzeiAUxHqM29IhahL7MLHsaC3+0VrT3OkaFiK4yUrv4xYbbEcu8CutG6l1Mxzo8f2s6n8x/D4oVdXsxWop7du+H4lwb/DVTLn9IFqgeciA6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+E0V2L0CAd3RXX7276SgPHQo623rQAz1cB9luccDhE=;
 b=lITvgh/MiGcVzax3OxPUg6xYJCZRPs7s24c1JKzkLjnitguXM9gI/zGBal5yqw6larYvs277ZHeVQX0nRYHj1Ggf8qHohX2CIlU8m6OWcan/nFXh7TCillF6cBzeisM0DnIhuVg4PzfOTYEhbaMgPSRsoRfFhk4ZtMh5ymYVLpnUS7f/1DaNuSIeFZrNjZDKgUTwI7r+ZTPOBHdMSlSmnNJy3TSJkg0VSz7xlbgWjRC/HYCXRqF2hrSeyKSy+cl3TlNQ29XjOERt3+7cyYRMlft/9QGdArPiEV6+psr4ZQIZmRiVUI6qEk+n/9CfF7Dil5+EP6eOPqWUgE4m3LWsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+E0V2L0CAd3RXX7276SgPHQo623rQAz1cB9luccDhE=;
 b=OxT1p+wa8wJLY9klyhkWAJMUUnvGWr1GaJTijTfzGzHxYhjyyI2ue87g83hcefBAokNNHf9qElCl+rW4MKUVBemg/B1NNlb5anxoPsRLZgjBKETR4Hfuchs62KMkp0XVE8RpuDtmBVN7GI6OJdE6pwmdXs3PzPZiyRyl9D59Loo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 21:40:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 21:40:46 +0000
Message-ID: <b1660947-5ee8-4b6f-a760-fb82d3d09399@amd.com>
Date: Wed, 24 Jan 2024 16:40:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: reserve the BO before validating it
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240122090843.1540732-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240122090843.1540732-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0277.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 909394d5-49bd-4c84-4629-08dc1d251ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSjoELyuVYMBsr/YkHMYrTr+/AJq+cLTMPKuoSjMjeDxfcv0LlO7zQ7Sk8HCmLxzS/c36mqTzT/kVnDdk9THhkKSKWPoD88lYlKsOg48Mph0SQDNBBXiZshjbyv8HPQ+6chvCvrOaeMFe+gI8HaW+GDuBpkSDvmwHMEBdCwi257Ex9zHkuDgg51wCELMwoNXJjWn/us3DIr7orXf/POlpzzNTv7WqfQ8smmsyNa8ImuzxNrXKF3qfIyrgpVtSSi2n5S61g3r57TLpRedEHjTVf/7jD60kF5RXHB1Nc8ACZfzkSrIViWMXwCYZa3bDJc11rPBn7WNWDa0HrprKkuNuKwW4Nc6osomYraRkIygMAzBvbpVdqqhOXIQFbvSvRwQx0SoaidNEVQYTXhNQU8zkQMd+yo32S/sXfMNjcreAMTwr7J+96GBr+RM6oEpt455MaEyY+UM9lBbEKehyj6XRfA4GZbK9SSb2rRVzK0PZoSfr59GZ+KbDy1on0X8ZShk3vqGCBEcnwHv6b76AGyl3r6CpGj1OfVCvKiJdQLumSBDT6seU/bheNASsSqmFHgg3ZJ/QwbUXk1nPGQ1N+sHJn0pynvwMZ1gdh2T1Y0gJ2aqrimd0fAm5Ctb48XxUFj9OS+eF9Ct9uX21mnaEZ4RxnePfBlvN9tAMK1jA6BKqUI154ohWjk1Za5jKs96B7Lo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(36756003)(31686004)(31696002)(86362001)(83380400001)(26005)(2616005)(316002)(66946007)(66476007)(66556008)(6486002)(8936002)(53546011)(6506007)(478600001)(6512007)(8676002)(2906002)(4326008)(41300700001)(5660300002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFzazRPUmYrY21LK1UxQlRLMVI0TkFRcFlCU2dHNTYzWkovWnU1V1JvMDN2?=
 =?utf-8?B?NVFCNVN2MjFUR3gyS0Izb1ZnZEQvK0R0QjZzUUkrZnhocS9IRWhYUHVNR09u?=
 =?utf-8?B?SXA1VVFYK2N0MU1xRmJYYThNeDZQQnRaOHo2NFV0L2dWaStmekdlaStnUGhU?=
 =?utf-8?B?TTRBby9wVFllaUlKYklDcmxCVnFkNjNESHhWclFyTnB4RXdZNUl0NUF2UXhJ?=
 =?utf-8?B?L3NhMG1QcUVtZXFoOWNJbG15SC9sVm5ueGtHVVpWUXd1V0gvbzBjUThYdzFv?=
 =?utf-8?B?YlNNdi9EanZ3VmNsOXp4eGJDYy8xdEtQRHdMUWVOMjEzWTByRU1nbVlTR0or?=
 =?utf-8?B?cGRpSmR0OE5GWmtZazFtSitDN2E2M3I2MGZ2ekFlb1lUN2xzV0pNUERZMTBt?=
 =?utf-8?B?VmFsNEFFdmRrNS9xZHpROCtkRjBtZDZNVzIwRmF3OFV1Vk9RT0RUeFJhaXJ2?=
 =?utf-8?B?TXZydUc0UkF5SWM3TzNRR215Mm1Ib0trMGF1US9WOVpJTVc3L2w0NURWZHd1?=
 =?utf-8?B?Nzhpa1BuQmV6Nm01Y1lyQ25WM09BaThkaGJuWlg4QU1xTU9mQWZMOThPRHBo?=
 =?utf-8?B?bUswVGswa1FvK0lkMXQ3eWYwVStWaW5IdXJEUFUzV0UwcUFqOXk4WmhlR1gy?=
 =?utf-8?B?VjR4RmZ1WFhQVWhiSG9CQmx5U3gyVTl6a0dCV2E5dVFKTDZvb0lkejVPWWZa?=
 =?utf-8?B?L1IrNjd3QXFhdjViTHFaUk5pZzVnUzB3KzEwNGxUTGVORE1URkFJMys1VVF4?=
 =?utf-8?B?aC9vS2pmRGt6YStxVTF0YVh0RmRYT2EvS3F4UHFQVTQ1aXZ2dllld2ZaOEtM?=
 =?utf-8?B?VnZnOUZQUXhHVmEzcVVleWw3YWIySG9kRWJIVTdlZVFWT2JkWDUxclppUTRk?=
 =?utf-8?B?K0xNNEhDd2tBYXJZT0hZbkVvbjJMQktiZTJwUzIwVjFKODRjSzdMR2dpRy9m?=
 =?utf-8?B?WVJlaUJmVlZoTGMyOGo4UmVvY3U0K1R1VStaaFNzdUlqRldyUnk3YnN3K3dQ?=
 =?utf-8?B?MzNaT1ZLUEl5bEVsRWxsWVpVTzFLRDluelN4dHIveUUvTStMVnVWcGNyRnFx?=
 =?utf-8?B?VSt5Mld0Z2JqU05NTkF0K1cydmo3OThmcHdwRm5ISS93cjc2MVJXalVNaEZj?=
 =?utf-8?B?Q2hZZXcxU0YxM1FpTlFCUWNBSE1xZHFpdHRkVmRzOXFreTlJc3k5NU55TU92?=
 =?utf-8?B?MGJFODQ3eE9MTE9peFovT1J4OVZlQmE3YW5QWms0akszaS9JZWY0Sm4zU3Zi?=
 =?utf-8?B?MWJhQjA3R0Mxd3dGK0RyTkl2TkNweWsyaXNjR3VpcmpCKy9xUkNJWjJPOTF4?=
 =?utf-8?B?MFVSZWZ3eHNlbytIdmpyYjc3Q2NIZEF3eWxROVJZQUxCYldiRGVjWlJmc2xS?=
 =?utf-8?B?dm5waEZ1S2ozWURzYnRDamt6ZVdzU1BrTUx1WHFubXZFOW1pSVBWQjN2bGhw?=
 =?utf-8?B?Z2NjQ0QxMjcwVE5ENW90eW51Q2t4YjBTNFpHVm9xL1NjUlQwc0lqWlNZWmZo?=
 =?utf-8?B?MFRjWXc1Q2lJalZocnM1eTVQTTJIWkJOV2VrU3JvbHk4RTRWdkFZTVphVkpv?=
 =?utf-8?B?alRVUWFRR0RVZVIzTkY5QkExendIeFY5d2JRekZ4TmhFN3g4MC9qUU9sM25G?=
 =?utf-8?B?ai9zTnlDako5bXFJUzVlV0JVamZMR28xVGpaMzBNeG9zZmcyUFFRc3luWVpH?=
 =?utf-8?B?ZWl4S3gwMGZ6NjBiZ1gvRzlGeVVpUnFsNUx1WDVNNGhaRWVaVGhXa3lHVGVv?=
 =?utf-8?B?VkxFanMyUXRxRU5QMkx1ZUwzaHUxTThXOUNIbUgySk5mUXVCWHRHZTNVMS9U?=
 =?utf-8?B?bG4zUlFoQUF1MWNod0lGZllTR05qZ2dRTlFPdm90QUdaTUJnVmp1RHpNTmhI?=
 =?utf-8?B?bzFMWkVFdUdNWDFXVkMxdUkyZ25DcHpwRU03bE84aSsvTStaaVZVWVoyZ1Ev?=
 =?utf-8?B?Y2lFOTJWNWtYRndKVDVGWktZOXBPYTR1M3hObFlJUDdIRGJSU1cwTElKMExu?=
 =?utf-8?B?TlhFck1zWlhtaHFpb3BjSlZlR1FVMitOcDNMWlA2eVZ0Uy84N2JxdnE5bmNV?=
 =?utf-8?B?NkRwOE5HWlB2RXFPbUNtZ2RGOXQ4bldqK2ZPK2gyUjdYRGNQeXhpZy95cms3?=
 =?utf-8?Q?tsQGfJgx92NN2KWukqj6WIwF5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909394d5-49bd-4c84-4629-08dc1d251ffc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 21:40:46.8363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UK8LhDjEKlcdkUMIABGG4n4cYKJVz75cto4Q05ezZ8eDPW/hC98m0lHoaZZPPURv3QvNiTSO4gaEFXegJSSUDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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
Cc: Francis David <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-01-22 4:08, Lang Yu wrote:
> Fixes: 410f08516e0f ("drm/amdkfd: Move dma unmapping after TLB flush")
>
> v2:
> Avoid unmapping attachment twice when ERESTARTSYS.
>
> [   41.708711] WARNING: CPU: 0 PID: 1463 at drivers/gpu/drm/ttm/ttm_bo.c:846 ttm_bo_validate+0x146/0x1b0 [ttm]
> [   41.708989] Call Trace:
> [   41.708992]  <TASK>
> [   41.708996]  ? show_regs+0x6c/0x80
> [   41.709000]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
> [   41.709008]  ? __warn+0x93/0x190
> [   41.709014]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
> [   41.709024]  ? report_bug+0x1f9/0x210
> [   41.709035]  ? handle_bug+0x46/0x80
> [   41.709041]  ? exc_invalid_op+0x1d/0x80
> [   41.709048]  ? asm_exc_invalid_op+0x1f/0x30
> [   41.709057]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
> [   41.709185]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
> [   41.709197]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
> [   41.709337]  ? srso_alias_return_thunk+0x5/0x7f
> [   41.709346]  kfd_mem_dmaunmap_attachment+0x9e/0x1e0 [amdgpu]
> [   41.709467]  amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x56/0x80 [amdgpu]
> [   41.709586]  kfd_ioctl_unmap_memory_from_gpu+0x1b7/0x300 [amdgpu]
> [   41.709710]  kfd_ioctl+0x1ec/0x650 [amdgpu]
> [   41.709822]  ? __pfx_kfd_ioctl_unmap_memory_from_gpu+0x10/0x10 [amdgpu]
> [   41.709945]  ? srso_alias_return_thunk+0x5/0x7f
> [   41.709949]  ? tomoyo_file_ioctl+0x20/0x30
> [   41.709959]  __x64_sys_ioctl+0x9c/0xd0
> [   41.709967]  do_syscall_64+0x3f/0x90
> [   41.709973]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 28 +++++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 ++-
>   3 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 584a0cea5572..41854417e487 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -311,7 +311,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>   					  struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_sync_memory(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 6f3a4cb2a9ef..7a050d46fa4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2088,21 +2088,43 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	return ret;
>   }
>   
> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
>   {
>   	struct kfd_mem_attachment *entry;
>   	struct amdgpu_vm *vm;
> +	bool reserved = false;
> +	int ret = 0;
>   
>   	vm = drm_priv_to_vm(drm_priv);
>   
>   	mutex_lock(&mem->lock);
>   
>   	list_for_each_entry(entry, &mem->attachments, list) {
> -		if (entry->bo_va->base.vm == vm)
> -			kfd_mem_dmaunmap_attachment(mem, entry);
> +		if (entry->bo_va->base.vm != vm)
> +			continue;
> +		if (entry->type == KFD_MEM_ATT_SHARED ||
> +		    entry->type == KFD_MEM_ATT_DMABUF)
> +			continue;
> +		if (!entry->bo_va->base.bo->tbo.ttm->sg)
> +			continue;

You're going to great lengths to avoid the reservation when it's not 
needed by kfd_mem_dmaunmap_attachment. However, this feels a bit 
fragile. Any changes in the kfd_mem_dmaunmap_* functions could break this.


> +
> +		if (!reserved) {
> +			ret = amdgpu_bo_reserve(mem->bo, true);
> +			if (ret)
> +				goto out;
> +			reserved = true;
> +		}
> +
> +		kfd_mem_dmaunmap_attachment(mem, entry);
>   	}
>   
> +	if (reserved)
> +		amdgpu_bo_unreserve(mem->bo);
> +
> +out:
>   	mutex_unlock(&mem->lock);
> +
> +	return ret;
>   }
>   
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index ce4c52ec34d8..80e90fdef291 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1442,7 +1442,9 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>   
>   		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
> -		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
> +		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
> +		if (err)
> +			goto sync_memory_failed;

This handles the case that the system call got interrupted. But you're 
not handling the restart correctly. When the ioctl is restarted, you 
don't know how many dmaunmaps are already done. So you'd need to make 
sure that repeating the dmaunmap is safe in all cases. Or what David 
tried earlier, find a way to track the unmapping so you only try to 
dmaunmap on GPUs where it's actually dmamapped.

Regards,
   Felix


>   	}
>   
>   	mutex_unlock(&p->mutex);
