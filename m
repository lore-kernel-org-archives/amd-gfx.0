Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9451C4321E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 00:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D68E10E4EF;
	Thu,  1 Dec 2022 00:00:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F2410E4EF
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 00:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7+KXGkHx9JnIE1RwX+bn6Ov4nzz4CJU2SQwh3absbR1+wIy/UqEpAGW2gTtNFD69xrCOSM+pDUb8oBYpsc4cYq24XICYLDCV/R1RIc5mGFxYfxWi0UXAWsD2szLk572vgdvvECdZ0wuE161zQWKKc9HeojDT75pnSbUTmcwP1nMUxrxTO5SYTYIV69KOU5ePtHQwIw1bkBHo1zbBWIKc0y715Yuf2o+Zx6wng/qug1Hay7d0nfN47JxuwdWY+Gk71d+BLi5M2qIR1CdTnaFaDK6WqG85tuNd9ApSuAA7m1N7d63l/xAhsS88KMTR6inJkKyV0s5eukb6ltp7u4L4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMTrkv5I6aNwQPDjsoF/VgyS1QbDSQJiuydJHATTp6I=;
 b=WLdGTUXDm+SsS67IxztDyekJPqJ67gG1EJWg9NrFnnI1wYbRh7HcFDWl5kUWFfvtbeWe9E3TKy40MOeQVo2nQN1kNRELFDf1VldAzKAgQ4kreDt9MZm9BsL4Bj5p62EQ0Ex5oCmMCyQQW3seOmxa3pvpteNdSwG1k89PRlsze/8ZWDG1E24urSjj4b5zFKZ+SDYF6zNME7ObEMt2Ba7/sVJVwcKKMJNoVTNSfLlrM/1hkOcWxETiPuRpdpLg/nb/rQ0T2OB1H5RggVqJfXROENqVL8EGrSeqrYEZ5dw+Cx6/zkRFVqLPfm5WQW6PyT9JzvW0ankhQsM0lU4nJLbJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMTrkv5I6aNwQPDjsoF/VgyS1QbDSQJiuydJHATTp6I=;
 b=Y9CZYBiGX3/LJQnHW+kdP0JpYW5TqhtMTAJHmh9keaXs+56Qk3O8UzMZN0URUeh0q3oKKVp94aXCw3L0C4j/ReD0fM6tJRDf6DjM9iB3VZnUzxznfUkelWD8Lsay4T6+W9NHklCF2c67pkGKFHVoSWVs2qpWR9/SxW9ndoZJoJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 00:00:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:00:25 +0000
Message-ID: <6c0ebd8f-06b0-32f4-089e-90951aed5e6a@amd.com>
Date: Wed, 30 Nov 2022 19:00:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 28/29] drm/amdkfd: add debug device snapshot operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-28-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-28-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: b636bdf1-d8cb-4c4e-3c22-08dad32f0c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+SvqF7Js40jLsNnu2QEADY6bfCNjdgOZ8ljR2QTw0F+IP64yrQ+4Lg23kF1oyCvZzso8vwPWHnfRbUNbEha5XMjRCb42Mo6w7FKVJMr+0DwGed3QeAMm6wvqz0HQaBdVuDGL7JWbddDFuWErPi9FQ5f+MobZvoczVroQuhqincFNbW6lebeWsKvD5ilF/unYl68tXL5BSNJqMHamn6OUOq0BKcuqPQ2u4vVDC9idZP6p68dMDtvbxohLMBPtP1G4OHnc69QFpRYVuce4emIrFzjm/ykFMNHZnHjj2kAI9XfBXT8xF+Wt4zynQ474McV59zHcJFHbKXgJN2Z5jF92ug6ZHzRLqLKIhm7gQeQouausSdzh2sG9X5aeeZ9lC6AiJfIK5N5zGOjKQidmddFmGSmqGNArXamiGDIHd2XQNx9Axji0PTlPhxopH2YgDEI2IpSeecsNzrnoye+TUO8zCprRRWPjGlrCZuoYjwA2CaoKTqscTovVp+7cHhk3AnMeB7cW9groCOxm0/H2MoqAhPTq1TD6Q2oH3WKQLavmry4lVe5+dC4Y9SsVQCwl8holM1ZOC/NMlA3CjdCoI1Iw5d6pIS7MZzIMCGv0WqdNZPwS8ZXTbExhLkz8vS2DyTSrSro9I8mmXbF2h+RD5Q+LR21uKYW9WuuTnQoaUxgAezegF4lJ0icWYEj/8sdlJNTxehAmSj2NbVvwQInETxpsroxsgAx5bGpXUUKqINLQWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199015)(31686004)(2616005)(83380400001)(26005)(6512007)(53546011)(186003)(6506007)(66946007)(36756003)(41300700001)(66556008)(6486002)(316002)(8676002)(4001150100001)(86362001)(36916002)(66476007)(38100700002)(478600001)(31696002)(2906002)(44832011)(5660300002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHpobmZGVGxBWFU3NitJa2tHUEEwOUtBNFZLbVk1Q0FaMDdZdjE5dDJ4c0x5?=
 =?utf-8?B?Z0dxNndQc2hDeEUvNW5mVzJWNzNoNDBISlBjZkZMNERJNXpCK1dGdjVucnRV?=
 =?utf-8?B?d1Jvc0xMWkVIQVFNVjNpSG1NaUxpN20zZmNIUlBKSFpNUzVXMXFNK09obGdw?=
 =?utf-8?B?UTJHeFlMYy9pVkJHckJ0R082TGQ1RDVhQ09KU04vMzhMd2NTVE1FZFg0N0o1?=
 =?utf-8?B?TW8waWUvYW1oUVRPYkhyeGVvTkFNamthRStTNVZ1NTNrTXB3K0txSTZvN2Mr?=
 =?utf-8?B?bE1SbGY0NTNyOUNZSVlxY2JwdGpKamlpUHFPZ3FQN05mWSs4VVNLbjdlbDEw?=
 =?utf-8?B?VjgreEhXTkpLMGdKdHBGOVZ5UFFhVlQ4Z2VBb0NzVGxiNnNoblBKVHFOTjM4?=
 =?utf-8?B?dmIvMCt5ZWVlZ3lKbTdodVhLV2J5RVBKZUs3L2RoQWJoaitxYzE1SnhhM3Rt?=
 =?utf-8?B?d3ZEZWxSSjBsUjZiMGtUZVJMeW1hTXdHUzcySXhTZmp5dWhleFh5SHNTN1JT?=
 =?utf-8?B?dXBXWGhYODVObFpoTXJCRnRoM2UvbVFoYWI4M3lnTU5ycWdrVGw5UldYOEp6?=
 =?utf-8?B?SnJlSVBOVXpDRmEwRlFsekVoMFpSZ1pmbEtDbjZ3QkhXMW5heHVGZ3UxK0FC?=
 =?utf-8?B?WXZoWVVOWFVvWGQxdVlHMy9xUk9LbkxROE5WQzNpVFFKR05lL2diU00vU212?=
 =?utf-8?B?c3ovc1V5U2E2T1F2djZ5N0FnTHlyN2lCRHVSQTQ0U2x1V0Q2RXJQc2ZwWkRV?=
 =?utf-8?B?cGZBdXhtY1hvTzdnWjNVSDE2OElBMVJEQlU5NUpUdWVlL08rRXVRK1RMa3VG?=
 =?utf-8?B?My9GVmF5VHpPVzdXZ0F6Y1dMR2l5ZzRQQVVrWWNWMCtKelhUVkpjbXhtbHdt?=
 =?utf-8?B?aWVaaWg2cUFzUGxpbkQ5UG1QQ3Y1THJYOXA5V2NhYkZqR2s0Zm13Yi95L1lI?=
 =?utf-8?B?bm1tMy9FTzJYVi9XdDRMYXZOSHRxRzhrZnhoUkRGSlBPcFoyK0I1V3NpYWlQ?=
 =?utf-8?B?MlF3bTRqVjdBb2Yyckpud1lSTlB3QXVmdjllUk5DNVd3Vjltd0p2R2ZjdVc2?=
 =?utf-8?B?dmM1Mm85d3lFVkxlYkZYSlNPd2M0SXJZazdtcFlNSGJ4MjRyczI4bXF0NFZ2?=
 =?utf-8?B?RmEwbEhwQTMwTCtvc2Y0MlBHVWg5aS9aVk9aM2c1OEZVWmF6anE4RlBQUS9l?=
 =?utf-8?B?V0UwYzI3eldrdEJJR3UwT0NlUEJ2YS9SK2tjQ3FCZzhnUW9SUVB3UEROemNx?=
 =?utf-8?B?WE1KSDNuME40UWRIZ2RlYW41ekloMHdrdTFnNzkzSnNDeUlVbHgvc0JxektD?=
 =?utf-8?B?T1MvWGVDYkpkR3NSVlFNN2dqRUN5dXptdzBXM05jM1AvdGFxVDZkRENBNS9r?=
 =?utf-8?B?YUNZZFFNUmwwejNJUjhMZFpwOUNRU3gxd3ZhV0JyUXRxWUFBay9MR2d0S1h2?=
 =?utf-8?B?SHk2cm5kS3FuSTdadzZJY0x4UjVTMWxBNGQ4ejE0M0pBMjJOSy9LenppNndw?=
 =?utf-8?B?bzZoM0ZwM0ZaWWREQ2UvYnZIa2h0VHBxNElJNDIwTDdySDRvY1kwaThrSkwz?=
 =?utf-8?B?ZVBscVYzQmR2ckk4dnlxNUtjNVpSejRxKzNLUkhLY3hpdDl0Q2ozcTVvMEpY?=
 =?utf-8?B?eGNIbnpoYitzT29OQlU0dUk1VlhMbEZjS00vVWRaT0o3cG5hK3YwdkxSYU5M?=
 =?utf-8?B?TmYvTmRYZEVjZ2s5dysvQzhSS3FGdnJkMFZqVzJXeTdBL3ByOEloSzN0c0FE?=
 =?utf-8?B?ZVp0Mk85bXRMUjBwU2Yxa3l0MlgwSGNwUTFleDZYa3crNU1WTWkyaGlkRjdp?=
 =?utf-8?B?UngxTTZIWWtwOGF3YUhBOC8wR3BTbDVnbEZXUGI5bnhkN2NzaVZYVk5FZU5v?=
 =?utf-8?B?akxTbWJ6VG5halJ1cXAzNURtM0xSck1QajZ2RmJ0SnphWnJTQXFNbTkwT2o1?=
 =?utf-8?B?SWxOb1FveFJQdFB3K1RneGpObTR2UDcwc0hsZS8wckNTZWlhYXVzU0ZBSEo1?=
 =?utf-8?B?a09Bb29FRjIzOTVJck1pandYV0pMb2lUNGF3OEpiVG9xMXJPQ3pqQ0FWYXY2?=
 =?utf-8?B?S3llK3ZGOGdUTUJhS015bkJSS0FMNzdtVWQyMVpsVVpZSDVZaXM5aW5Ua2NE?=
 =?utf-8?Q?LVfMk66TfOgtb7jZx6VoBNyc/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b636bdf1-d8cb-4c4e-3c22-08dad32f0c7b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:00:25.4703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IWxpYDwG1LzOp+hlv2VQmbSo4HrJFSigOFhqodqlBRrZWhLjYrFQHvE7IR4q3GX06ab12gyVyHZWALdA10VGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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

On 2022-10-31 12:23, Jonathan Kim wrote:
> Similar to queue snapshot, return an array of device information using
> an entry_size check and return.
> Unlike queue snapshots, the debugger needs to pass to correct number of
> devices that exist.  If it fails to do so, the KFD will return the
> number of actual devices so that the debugger can make a subsequent
> successful call.
>
> v2: change buf_size are to num_devices for more clarity.
> expand device entry new members on copy.
> fix minimum entry size calculation for queue and device snapshot.
> change device snapshot implementation to match queue snapshot
> implementation.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  7 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 67 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  5 ++
>   3 files changed, 77 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cea393350980..115a80686f7a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2968,8 +2968,11 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   				&args->queue_snapshot.entry_size);
>   		break;
>   	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
> -		pr_warn("Debug op %i not supported yet\n", args->op);
> -		r = -EACCES;
> +		r = kfd_dbg_trap_device_snapshot(target,
> +				args->device_snapshot.exception_mask,
> +				(void __user *)args->device_snapshot.snapshot_buf_ptr,
> +				&args->device_snapshot.num_devices,
> +				&args->device_snapshot.entry_size);
>   		break;
>   	default:
>   		pr_err("Invalid option: %i\n", args->op);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index a05fe32eac0e..8d22a27cc062 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -22,6 +22,7 @@
>   
>   #include "kfd_debug.h"
>   #include "kfd_device_queue_manager.h"
> +#include "kfd_topology.h"
>   #include <linux/file.h>
>   #include <uapi/linux/kfd_ioctl.h>
>   
> @@ -888,6 +889,72 @@ int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
>   	return r;
>   }
>   
> +int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
> +		uint64_t exception_clear_mask,
> +		void __user *user_info,
> +		uint32_t *number_of_device_infos,
> +		uint32_t *entry_size)
> +{
> +	struct kfd_dbg_device_info_entry device_info = {0};

Use memset. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +	uint32_t tmp_entry_size = *entry_size, tmp_num_devices;
> +	int i, r = 0;
> +
> +	if (!(target && user_info && number_of_device_infos && entry_size))
> +		return -EINVAL;
> +
> +	tmp_num_devices = min_t(size_t, *number_of_device_infos, target->n_pdds);
> +	*number_of_device_infos = target->n_pdds;
> +	*entry_size = min_t(size_t, *entry_size, sizeof(device_info));
> +
> +	if (!tmp_num_devices)
> +		return 0;
> +
> +	mutex_lock(&target->event_mutex);
> +
> +	/* Run over all pdd of the process */
> +	for (i = 0; i < tmp_num_devices; i++) {
> +		struct kfd_process_device *pdd = target->pdds[i];
> +		struct kfd_topology_device *topo_dev = kfd_topology_device_by_id(pdd->dev->id);
> +
> +		device_info.gpu_id = pdd->dev->id;
> +		device_info.exception_status = pdd->exception_status;
> +		device_info.lds_base = pdd->lds_base;
> +		device_info.lds_limit = pdd->lds_limit;
> +		device_info.scratch_base = pdd->scratch_base;
> +		device_info.scratch_limit = pdd->scratch_limit;
> +		device_info.gpuvm_base = pdd->gpuvm_base;
> +		device_info.gpuvm_limit = pdd->gpuvm_limit;
> +		device_info.location_id = topo_dev->node_props.location_id;
> +		device_info.vendor_id = topo_dev->node_props.vendor_id;
> +		device_info.device_id = topo_dev->node_props.device_id;
> +		device_info.fw_version = pdd->dev->mec_fw_version;
> +		device_info.gfx_target_version =
> +			topo_dev->node_props.gfx_target_version;
> +		device_info.simd_count = topo_dev->node_props.simd_count;
> +		device_info.max_waves_per_simd =
> +			topo_dev->node_props.max_waves_per_simd;
> +		device_info.array_count = topo_dev->node_props.array_count;
> +		device_info.simd_arrays_per_engine =
> +			topo_dev->node_props.simd_arrays_per_engine;
> +		device_info.capability = topo_dev->node_props.capability;
> +		device_info.debug_prop = topo_dev->node_props.debug_prop;
> +
> +		if (exception_clear_mask)
> +			pdd->exception_status &= ~exception_clear_mask;
> +
> +		if (copy_to_user(user_info, &device_info, *entry_size)) {
> +			r = -EFAULT;
> +			break;
> +		}
> +
> +		user_info += tmp_entry_size;
> +	}
> +
> +	mutex_unlock(&target->event_mutex);
> +
> +	return r;
> +}
> +
>   void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
>   					uint64_t exception_set_mask)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index 58a5f14d1258..d8c0c54fffa3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -80,6 +80,11 @@ static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_dev *dev)
>   }
>   
>   void debug_event_write_work_handler(struct work_struct *work);
> +int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
> +		uint64_t exception_clear_mask,
> +		void __user *user_info,
> +		uint32_t *number_of_device_infos,
> +		uint32_t *entry_size);
>   
>   void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
>   					uint64_t exception_set_mask);
