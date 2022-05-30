Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABBEC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9BB10E205;
	Mon, 30 May 2022 07:54:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D19C10E03F
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADh27tDYkDVZrSkXPOD4aXGaHSMbDfGOd1ISiTvtzedlnLrJluOq6I0XJa275Z4noj5pWGqiH4e14Yir3/DoQXTsbGPceaANjjyUdZXH9kjGpbI0LQlw+8MSZPr4bRO/Ge23P1EduMqfdKdm6BI4LOkhaKy04sdiRpoyB9hFK9PV2bBHfdoHD024xPSt97tPUXx5cXsRXD/tf/RNB/9UeL2K3Y/uFvCyb/YVolAVNsDoYcsNTSig9WTWocAGDV6KWjOmkvrd7EUE9dNckuBR4B2kUMKfL4MYXpARKKRP04wrlDJm3K4c3KZbitgub+Yt+dhPfHWfmEefYmR8WoU8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LhMQS8Xrtb8j217B6PkyhiOHe+o+7YIJeilXpbdXWY=;
 b=EP4kvU0I5fVk55z1KBsHD81Ngxo/v6vz0jinrTsA8lvgPZ0rBowiQmZUjx+9HopV3PqUYB8gKcfS9pPYejUmFemOxHiHixUOFfiRdSa2/3Woej9Gz36IuZYskdj450c4w246kHCeEzRmhbAc9OK78Z1wfo1qPN5XYOXZ9RVf9NhJx/rVeQ3eeJk2PzwO/bMbOOLemOf/f2HuZntexAAvjgUu0+ECbXFZbTA/tTm2DeO62qEWaG6XjIs/lPrLxHs7p8jcrgrduFFzHUc8LBJPhuOOaJZv2gMFrHoe06oS5IMjvx+4sASWWeUusr6eoMBEgpg8qa0zW8rpMhjaQH9wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LhMQS8Xrtb8j217B6PkyhiOHe+o+7YIJeilXpbdXWY=;
 b=NnyvLMUawhJX3v9nzIzcJx30CbvfIEOfsro2mMA9YOTv6WasVKBQYo1WYbDrMsr/XKT9a47EGqhw2hEdixRGAFrKCpSA6fqyPjd1KuTwpiNBWtYL5JPs9bz8LvWG+0ASNQk6bu9wygv1Mq51TuUmdbmCj5wJ/rgtC4jgQRW4hJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 07:54:39 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:54:39 +0000
Message-ID: <4fdeb19a-35e3-da7b-380f-ff5efda7b4b4@amd.com>
Date: Mon, 30 May 2022 09:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 5/7] drm/amdgpu: Add work_struct for GPU reset from kfd.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-6-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220525190447.239867-6-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0157.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::32) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b3b808-8a36-41a7-ed8c-08da4211a61f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4104:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41046C1C30F9FABE0DEB611283DD9@CH2PR12MB4104.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9RjL3dRXc3V5CwrkYpjWyWaqdCkJfvYgPepZlYRqhsOXcZ36XbdxePVJkvCQH6lGwu9UF16jEuf/sSUeQTAWBdFyJj5WYUptcjTtj02rVSc5jMub7OjhSj4EMGz9BXvbp65RWQ74inX98rtCI6e3UzrvMZdTirikCtxWDlfxYSNmFMISbG4KBV0MkHjthg5/UGjcHc+vq4rRE2KmoQ2EbirmAciWEiXAS+kmttUpjKzz+YHh2770ANs04gu0zGKZLOnxIlVGPboh/MzDiC684gMKJ72R2L2lVHgd0QCdi8jc2h4xW2PMZJmZpDfL92mne5+JKEp69E+E7OYNvO2zNlXkxeR0dNzBbc03uxmGcyrO8MfFgDxgGgqL+FJDTLw8ZRDniJ2z0+LZs8IdiYMwHxURJKYrSvOy9HQYFc7OW4hc1lfiujioO5H4nFKVmfkWoqoXVAqbi7oi0+dU2ac55CBFSuVz6ugH45okQzAI6tf4ybAn9oVyvnHMvTZQB9iVsT/ntqQSPjQrZdLn6FWN9EgHF6yXmZ1K3t7699SXQgXHf5P1vVl1YabpUXLFTivAp8q0dn9RbH380mG+OWlpBOQ4u/5EafGM8J0WVOK4xLVoAWmslLnro0drBIRPYD53dT+1eew5CPohKao9IQtAFCwm2PQUBUxjA3dK2vyRnVfOtAzcEeDWy9h/QgtX86grOeugoNIM8QvpSI3pTPO1aByppiUPYwZHiTz7FDptdsFGX9s/2nxK9DLDtgElVR5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(5660300002)(66556008)(4326008)(8676002)(66476007)(508600001)(83380400001)(186003)(31696002)(6486002)(8936002)(86362001)(26005)(6512007)(38100700002)(2616005)(6506007)(6666004)(2906002)(36756003)(31686004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5XUGpDMFJhc1h4djBLWFF4MWE0dXRsRkZLYVd0UXBHQjJLeFRma3ZjTXVy?=
 =?utf-8?B?eWdDT1kxQVZ2ZktjRFVBUkJuYllteklLVDgxVFRPbzRNWTlNb3kvcGwwTzRP?=
 =?utf-8?B?UFhyazlyR3E4Y29uQ3pkdDZHa01mMHJzNkFSUkxyalZMT3MrSFhyazBhRUpJ?=
 =?utf-8?B?YXlqYmVYWmFsWGxhZWJMNTdCN25MZUlnUGRSaTYzN0NFUXFlS3M5cjZHNU9X?=
 =?utf-8?B?aURYVFo3VmdHb3JsTEg0blI1ajdnQTE3MGpud2JOUE9hZTZzSEM5U1l0NXZy?=
 =?utf-8?B?RXg0c0ZtdWozZGFtdjR0eldERkg5YWtlL1dmdHZiUWxweDlZcHdFTnV2MVE2?=
 =?utf-8?B?OEpPWjdlVDhNZjNGMWQ0R3V5azdtSklIMS96WDZZY2VXTHRoVTNhM1k4S3JY?=
 =?utf-8?B?T2NOUjVZZnVUMlZqdzY5QVEreFB5akZTbnAvaE9hNmtLaTh3czFKdDNCM2lt?=
 =?utf-8?B?Vm1FUVhOVUFZVkJyV0dPM2VDV05LU29FYmIvMmRqaEhrcG1sV1hWempiSThV?=
 =?utf-8?B?Qk90QzhaT01WTGg3K0VPU09lOWdxQ2lwMHpYS3JMa1FFZW12KytSbDBNZUR3?=
 =?utf-8?B?Y29nOEdZSkNPTjlHVndqcjVPN29VRG5OclhlK0N6SGZHeDhicG5xK2x4ZDI4?=
 =?utf-8?B?elFFMEpUeGY4VjJXRFNNNjd4QXVSQVlxMUd2L3g2ZkVmek5pT21LdmNCVERT?=
 =?utf-8?B?RW9ocFVESmVwbVk5MSs0dXZyUENtWjBBZ2pTZjVzdUd5VXZ5WHVEOHE3K2hs?=
 =?utf-8?B?OUowalFQN1pad2YrZVMwdjJZYUx3Y3h5TFBlUDByM2NTeDM3VUlYajh2Rncw?=
 =?utf-8?B?TXBDMDNBYnJQN1hhZE15a1pKQXFXUmxnMEpxdk1JSDl6Z2dHNktYNUVRSXh2?=
 =?utf-8?B?K040QkZnajZQWVZ4NTVyUTFNMnhEckIvYTNNeVdBSGRjR0hMamtYeGJ4d2N2?=
 =?utf-8?B?UXBhMFJSMEZEWlJHcWhxVHJTM2N2bkFFNXAyTkdPaGRWRC9kRDlQNk13eEd6?=
 =?utf-8?B?SUJ5SVNPc20zSk43OWtsNmVmMVhYZEY5MWUydmwvS2gydDRrSHlOQnZMeDJl?=
 =?utf-8?B?aG1VZ2QrTjdrelgxYnV5T2g4RWJBUWdxb2JOcWxkKzYydVRMSGV0TGJWMzFp?=
 =?utf-8?B?RjY5SWRrK1lrczVINmVGK0FaampEYlQvKytMZ2JreVdCMnJTR2h5V2NiTVlX?=
 =?utf-8?B?RlhpZ1RYbk5PL3F5dUJDbEdFOFVJeFdiaFkyeTNWNU9TTUNraFBYTEw1U2xM?=
 =?utf-8?B?ZnRCeUR6aUJvN2dDN2VzeGhIWkVFeXJQa2xMQnBXZFpoZFYxb1ZsczFoRGdx?=
 =?utf-8?B?ZERBQ0ZUWWpZYUIrTHc0cFkxUitncVJHUEtqd3FpS1VpbndvWWxqbjdhWWVC?=
 =?utf-8?B?RThGN0s4Zmx0c0lqNEsrQUZnVGVSb3JiMXAxa2NmWGhBTFZLOEVQa2hFeDlZ?=
 =?utf-8?B?ZEVub3QwRkU4bU9tVEV2NmRMcE1Bb3lqdTNxdUh1Q1gwZEEyT1FOTWZGM0Fu?=
 =?utf-8?B?ZERORlY1SXl4SVlUaHIzR2RjNzc3U1Y4aGljOUZpYUUwR1BHK21TcDhqcGJn?=
 =?utf-8?B?TUFmaSs2ZTNJd2o2b2dwQWZwT2xVeXNSd2w2cVhKdDNQektCdEVObWppZXFo?=
 =?utf-8?B?amRqQzBGQnhtdlhqTnhoQng1czZuRnRsYnp2Sml1MWFIcHNVMG9CSnR2dWpS?=
 =?utf-8?B?RGd4VHFFdVFtUnc2cEVZWmVMcVJoeHNrTU5oWU9ETGlBMnNRRG9wTWhMY2ha?=
 =?utf-8?B?LzRzY1JwNEczd3p2MHBPL2dlZStvQktzZmgrQ0I1aEMveUoyOEsxdWxzd2JJ?=
 =?utf-8?B?ZU5wRDBPdFNSTG4xNWJtZVBrZklBSHNqVmR4dThDMVJXa2tIOE1lSlB6cjNT?=
 =?utf-8?B?ZzhGMlJpZm41UG5yNElVUFhCbzlVSUNObmhKRzVXU2VXTXNlUXgwUGdMODV3?=
 =?utf-8?B?V2VHckg0S3R6RmhVVGdvTWJzK1ZDMVNGWUZ1VG5NQ0pJcHR6eC9CbjgwNXY0?=
 =?utf-8?B?anFzL1hTcGdwL0tEdHNpWWJrQjBSY2Q4OFZ3WG93RExjR0RYd3JFVUE2Ni8r?=
 =?utf-8?B?MXJEc0hzT3k2U01kQTFjd1hVK3BoZ05WMStHVUl2OEMxaWpQS0ZtYXVZZGpI?=
 =?utf-8?B?UlYrcHgxQ0k3VlhlMDFURnB4VW1RQ0ZsMEFwYlFza0tkbWhGc0Y5Z095WENn?=
 =?utf-8?B?eTNnUWprL0YzS3VZeEZJQnhXQUNQOWR5VEYrT1g0elJ5M2c3QlU2WHk1c2Vs?=
 =?utf-8?B?SURRc0w1Vy9tRmVqSzdyRGExVW14a2FqL20reUlEUUx3TDZwcmxEK2VvdU4v?=
 =?utf-8?B?TWUvNFc3TCtFbVdXZjEvaEFUVGNQQ3U1OG5Vc2pNbHFjOW5nS1R4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b3b808-8a36-41a7-ed8c-08da4211a61f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:54:39.6427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkVOgqPU4EvS0ekF03HAtfLXINjO1kHs/ArO/n3G0mZ4NQgt1TkSgu9xoWQwYP4z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.05.22 um 21:04 schrieb Andrey Grodzovsky:
> We need to have a work_struct to cancel this reset if another
> already in progress.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 ++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ----------------------
>   3 files changed, 15 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 1f8161cd507f..a23abc0e86e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -33,6 +33,7 @@
>   #include <uapi/linux/kfd_ioctl.h>
>   #include "amdgpu_ras.h"
>   #include "amdgpu_umc.h"
> +#include "amdgpu_reset.h"
>   
>   /* Total memory size in system memory and all GPU VRAM. Used to
>    * estimate worst case amount of memory to reserve for page tables
> @@ -122,6 +123,15 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>   	}
>   }
>   
> +
> +static void amdgpu_amdkfd_reset_work(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
> +						  kfd.reset_work);
> +
> +	amdgpu_device_gpu_recover_imp(adev, NULL);
> +}
> +
>   void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   {
>   	int i;
> @@ -180,6 +190,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   
>   		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
>   						adev_to_drm(adev), &gpu_resources);
> +
> +		INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
>   	}
>   }
>   
> @@ -247,7 +259,8 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
>   void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>   {
>   	if (amdgpu_device_should_recover_gpu(adev))
> -		amdgpu_device_gpu_recover(adev, NULL);
> +		amdgpu_reset_domain_schedule(adev->reset_domain,
> +					     &adev->kfd.reset_work);
>   }
>   
>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f8b9f27adcf5..e0709af5a326 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -96,6 +96,7 @@ struct amdgpu_kfd_dev {
>   	struct kfd_dev *dev;
>   	uint64_t vram_used;
>   	bool init_complete;
> +	struct work_struct reset_work;
>   };
>   
>   enum kgd_engine_type {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bfdd8883089a..e3e2a5d17cc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5312,37 +5312,6 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -struct amdgpu_recover_work_struct {
> -	struct work_struct base;
> -	struct amdgpu_device *adev;
> -	struct amdgpu_job *job;
> -	int ret;
> -};
> -
> -static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
> -{
> -	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base);
> -
> -	amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
> -}
> -/*
> - * Serialize gpu recover into reset domain single threaded wq
> - */
> -int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> -				    struct amdgpu_job *job)
> -{
> -	struct amdgpu_recover_work_struct work = {.adev = adev, .job = job};
> -
> -	INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
> -
> -	if (!amdgpu_reset_domain_schedule(adev->reset_domain, &work.base))
> -		return -EAGAIN;
> -
> -	flush_work(&work.base);
> -
> -	return atomic_read(&adev->reset_domain->reset_res);
> -}
> -
>   /**
>    * amdgpu_device_get_pcie_info - fence pcie info about the PCIE slot
>    *

