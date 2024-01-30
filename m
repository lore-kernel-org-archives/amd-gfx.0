Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEF1C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 20:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8886113559;
	Tue, 30 Jan 2024 20:21:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3C9113559
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 20:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlM/PlcSp7SAKAQN/LCX8moZpyzIUWNDlR/B9Al5r+VPoUsQKS8NM+Yu+rk/E7Cn3uwJ8nbh3/DNWo8BEGbPxbJPbffgSBvWoOtxoqBkKsfkAA/W53UcDARZccvKzK9f/Hhe0T5gf16paf7cFfXlTotKRTmZO/Uw4saZiu3VC6UXBR1LZFASbCtd6b//S8X30alQPRrrtAwyrFgC8zgKuagxLriTxvdHrahIL4sbNhN0EmmRRkLltXLq3AyVg/tULWOfJRBa7Gkz3oIojxubsYYzzg6Bp2ADSGFevukvQkZ2VjynloGdfLLoeMWxgNUZMnHaQWKZA8OKJ8YHMfr0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWvW599GGtwMftTgB9ti15JWAm9Ms37sF+x3j1nFig0=;
 b=PEAw3OYV8ECjTw8G8uThSVZFKK8sRa5XK0dZzowQuqdSj/D/2d8h9npbTVRnuQu19RtnyyUFOdTHfU64ZcE4GoPDm/7MRblKG+SOksLROuvbhKWfFKzIxQwyS/z0qaVbBuYmmuhYA/t8CvfVTHlNxhFhK2qxXR8WNfEHol5juQT7oSEldIH7AroUx/tJyA2+hG2qUDLWifl93+V5V+i0QslZn31BCudrg93YwW72+tWna2RKv511DUrYtCSBgdpCFhf5vm1XQou7pXSHJd9pWM77kMNQTH+zwHPw1mV3QLQrXEzStgGs6zPx2PsKog+fLgqX+XJKmDb1ADC0L2mAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWvW599GGtwMftTgB9ti15JWAm9Ms37sF+x3j1nFig0=;
 b=csaJn46XI5JMsspF4SNr7/tK7p7dVV3xW+m2QikmQd1FRqWn1XXCUHulY6qXVbyuhLtH8QCfdFAUCLQ8IqM2sKo6mOIxLWP8Rj8AVHWZgL3zojwGFrF+SWau7luuXcC1WJPHi7QdHDAGWO7g8mayXfbDFQMn271wz1LiCpnTmJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 20:21:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.036; Tue, 30 Jan 2024
 20:20:59 +0000
Message-ID: <3616b558-4e92-428e-b59d-afa5ff5646d8@amd.com>
Date: Tue, 30 Jan 2024 15:20:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: reserve the BO before validating it
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240130094544.176209-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240130094544.176209-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f79a1a-5925-487c-85a5-08dc21d0f92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwm//iktCmXoyAc7m05Gm2vgvaf2qwexWvW26s7UjO5vJ9QBYnCw8lokWoH2y7wo7eKfIfQa5404YV8dA2cSHzgnRDdIW7YktfZd0+RCJsi0cW6CN37zEMHFrXrggRsILUXThFJfD5mPxHxmpiN34lBv4ng66GRznGRqPjeEMI1Fm+6IrDW6MBpoaAm0Leqwe1Cq4tBxRc8ql9nhZqONJbsPfoBDShefHvXX833G40dkhqa8DAPSLFNstyLBsiIl5P+/KBmSPQKXS0PogUjByFFVQoX1MyzPb5+A3dwj6BbhlagXWgFW8VesEPPCstcGUr1paR40LL8M5r7/a4DPa4SzFfh4k8/gXk+cKS+IwRYJ6Z/1z1sr9ezUWihErEL1rU+rXdAXY4PxdMo19ESzqv5npU8LFuVqWUITi+Y4/a7UhQ2QIZS/LLJm8tvj4qba63dvt/SQoPDuI+/+dVYOP+COvjlEGB5m91bnxZChkA7TKxYmDTqTjtAMwuAesWOV5trKecdjDqAgqtdgIKMXzzhiFoSOg5hgbSry5FNMlIH+XuMSr00fjfC0QR76p+T0l1RbW6Xxqc/DCWyW96QmnMvES0BF9wRk5lQ/KF2D0QXNYmr6ueYZqn2Tz10aT6msgQdYi/YtYbtRSVOZDaP1u302vbWN4LisGsSKV2l7R8bwQJV9uk6WU/3fofUN3V2T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(36916002)(6506007)(6512007)(53546011)(66946007)(2616005)(38100700002)(316002)(8936002)(41300700001)(44832011)(5660300002)(2906002)(66476007)(8676002)(6486002)(66556008)(36756003)(31696002)(86362001)(478600001)(31686004)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xGZmt0RFAvOFREeDNhMHZNdmdnd3B1NVd0bnJkWWJkUDhBQmZDSnpIeEE2?=
 =?utf-8?B?VGtwYWlnTFMvRGpmRFF3aGFINk9kT0NxUmpjSjRkRTk2L2NkMnd0MlRWbUNL?=
 =?utf-8?B?WGxHTVpVaDZZb2tPWGNLWnh5T2hQU0ZvVFBIQkRvZzE1cWM5Mk8yQjdBN1R5?=
 =?utf-8?B?YkRpWFRrVFFNZktoQ0ZJeDFiMStwZ2xaRkZ4WWpmZFhjemY0QlFxMFRPa3FE?=
 =?utf-8?B?RWNrK1ZiS1dxZXQvTFRZTXVKR2Z4NW9mWmI1STNQMkk2R3RxZkliZ0M4L2dM?=
 =?utf-8?B?VTlSSGtPZ0tFWjRzS1hFNXZMTVBka1lkaDMya083aDVFV1NFa2lHUmpKRXkr?=
 =?utf-8?B?RGU5eWxtQXpnam9RZm1WMTN0QnczMEwwRm9RTlVqSjI5eERQVkdrQUFwWUlq?=
 =?utf-8?B?MFhvWHE0MXIrTVRrWStETWNEOXNvbkRhWnc2Y01GcmF1bHYxNVF6cThEZmov?=
 =?utf-8?B?RzZFVW5YcEtjNXdvM0p3Wm13eFlMRWF0SFRweGx6ZkdoVnA5bm5lSlV5eTZ6?=
 =?utf-8?B?bVRwb1JSQmw5dUFhL05lRzRuQ3NIV0VNbWNDeDdjR0oyMzhxNnNrWVR0aktY?=
 =?utf-8?B?blkyTERjV1prM0ErTFFQS0NpZkRJNVd5eWg1TkJqREIvKzRhYTJoU0NwSlRO?=
 =?utf-8?B?TUFhcTQ1Tlp3YTI3ZndVUDl2cVYvdWVYL3l5Si8wVFBiaklEU2JRR0lCVGNS?=
 =?utf-8?B?WDRnYWJCc2s3R3RwV1NzS0JMcFdZQzNKenBTTmtPaXpUU1RMV2FmNGlHdDZN?=
 =?utf-8?B?WWltWlZFaHRBN2NyZVlETHo1ZDdHRjRyMXN6Zk1EUGJDUXlZeUd3ZGg4dG5Y?=
 =?utf-8?B?cXl5SmJGREsxalIzUXFRTll4L0lYOTY4OEdYVDRhelVpT0ZMUmY3RXIrNWpW?=
 =?utf-8?B?SUIvcVEzelNMcklZNFE0c2JQMmttVlZ2UUFUUnh2MjJWTGd5aE5xZWJxSTBs?=
 =?utf-8?B?R2JrK0ZjQ0hWVEFoQWVkMjVmMlJpRHlaeWpHd1FzelQyQW05TnJRT0lqNlVX?=
 =?utf-8?B?M2tabm4raHk0K1Z1cmZXZFJ3b2tIYldDcWpQZTgvVDMvU1ZSVDk3R3psS2hS?=
 =?utf-8?B?RlRiYzR1T1E1cVdHZGZyaWIvcHZhL3o2M2gvdyt5cWtiazdJcmJ6S3lrL2s2?=
 =?utf-8?B?NlNkUVJjNVgrNERHcmhTZXJKMWkzSWtURnJMMUxoaUt1MHBBTGd6VDY2Vk85?=
 =?utf-8?B?dmxSOXJ4b0lQRFpvMXU1TThpUWhoVHRKdEtGeEFsa29IYnZ2ZFNocmFaT3Iz?=
 =?utf-8?B?Y1l2QUxLb1lidERTOWlnYnZndEVzUG8rUWRoajNIQjJnaGJhaWJ6OG0xZW5j?=
 =?utf-8?B?bFRycmIrRGUyRloraWhQakllOCs1bzRZaCtVMzZFczYzNFo2YmdjU285eW50?=
 =?utf-8?B?SnlBK3NVZnptaUR2MkhxYXo5VWNGL1lNQ09KZ00rVEFleG5WaFcyZXo0bWdk?=
 =?utf-8?B?VC9vQ3g3REM0bEZGMW02SU9qK0dwd0ZJV2hvRGNZdVI1ZXVqTC8vRi9oZlB3?=
 =?utf-8?B?SCtOOFU1Y1VPZWRPeldwaUl0L1ByTFJEVi80M3ArVTBpNGQ1emhFLzVabmY3?=
 =?utf-8?B?S0Nka21ZMURQcnhXQnYwOGRIMXdjclFzdXVFaTIybXVrR0V4TjRsbkhxaWFH?=
 =?utf-8?B?SUFrMGg4WWpwVm5iQ01FM3k5ZXpmTHJDSEpBZ2J3c0k0WTdCbFJiRUZ0TjhC?=
 =?utf-8?B?bnFvNzUvVG9SelJXcjQrZUEwTENZL1hnWjl5V0plRFZFZ1VVaE94MWtXZGFx?=
 =?utf-8?B?Q3dSZ3d0bjQ4M3FVM1E4RE9QK25iTFRWNDE5Z3JMOU8zUFdab2lISkdjZjd3?=
 =?utf-8?B?TUZraGw0MkF3dUpsUWVoSWk3TGtvUDlSd2tIdTRodTIzVXd4MlR2SlFVNVlJ?=
 =?utf-8?B?OTJTcldpOUtRSnJac3RHUVBiVnRLMjN0R3lWRzNNZzdIcXJOaUxlR0Z4b05D?=
 =?utf-8?B?dUFvWjcrSHM0RGdLRHpxQmIvSUo1NDV6bGgrQk15NS9wV1hmUzNvMyt0MlNs?=
 =?utf-8?B?QkVRSndZMXdwNlNIbG1HUmRXOW4ydlBkeFJtQjBXTlBUZEN1b05iNFR6Um1x?=
 =?utf-8?B?RGhxMm5Sdm5oT0dvOHVXd2taVXBBTzV6WXJUVE9hZnpxaXFqeFA4STVkQUc4?=
 =?utf-8?Q?BKFfH6gDLN33owvFtNyPDyAvT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f79a1a-5925-487c-85a5-08dc21d0f92f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 20:20:59.8280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULPOr29cibwxnS5f4XchgdWzMKEgXE5Gd4oKNDn66GRdBGLFYh2UvUX3N/chGxJsQKqipLzTBSJPtozEXFyEVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223
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

On 2024-01-30 04:45, Lang Yu wrote:
> Fixes: 410f08516e0f ("drm/amdkfd: Move dma unmapping after TLB flush")
>
> v2: Avoid unmapping attachment twice when ERESTARTSYS.
>
> v3: Lock the BO before accessing ttm->sg to avoid race conditions.(Felix)
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

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 ++++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +++-
>   3 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 298fc52a35bc..e60f63ccf79a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -313,7 +313,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>   					  struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_sync_memory(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 6f3a4cb2a9ef..ef71b12062a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2088,21 +2088,35 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	return ret;
>   }
>   
> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
>   {
>   	struct kfd_mem_attachment *entry;
>   	struct amdgpu_vm *vm;
> +	int ret;
>   
>   	vm = drm_priv_to_vm(drm_priv);
>   
>   	mutex_lock(&mem->lock);
>   
> +	ret = amdgpu_bo_reserve(mem->bo, true);
> +	if (ret)
> +		goto out;
> +
>   	list_for_each_entry(entry, &mem->attachments, list) {
> -		if (entry->bo_va->base.vm == vm)
> -			kfd_mem_dmaunmap_attachment(mem, entry);
> +		if (entry->bo_va->base.vm != vm)
> +			continue;
> +		if (entry->bo_va->base.bo->tbo.ttm &&
> +		    !entry->bo_va->base.bo->tbo.ttm->sg)
> +			continue;
> +
> +		kfd_mem_dmaunmap_attachment(mem, entry);
>   	}
>   
> +	amdgpu_bo_unreserve(mem->bo);
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
>   	}
>   
>   	mutex_unlock(&p->mutex);
