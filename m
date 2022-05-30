Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E2DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C24710E4A8;
	Mon, 30 May 2022 07:53:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A2210E3B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhf7StTYstOvkB0aDsUsW1gIDGfkilDXE5rJK4jzIYOkBVR+aTrlWNAoVEKmENRnL3WVX6Vt8C+onjsWyvkZSPnFZKpdUzIqX3uAPPJw5fj9NrsiR80aMWKqhdblMMWPO7mNymMlaRORHs6XNrcwAFEezlE1/48pLwBbzmoWHtX2Eopdi2PXX/S9q096t+C4Y6Z3uIb+SmzyRi3RdG48vro+NyavZAot5mH68q/HaFZlA8VydzSv4Vg5CL9wvjmDe0yHjEdcHLsPX3Zfw+TSi1Wy5HmfolYROA5nJCRUiDBgvxEm39G20vxZpJu6soHec/gB9rh+VwZuRtRJ5Kvosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpQ2Wy2IvlO+F1hTieknWYSIadCdq3njy9qwz5i8jUs=;
 b=hRh1TWtKkW3hRbl44fwxYiKKIZfqrMrJbG4oE4geDyTbsO4ihiSj61pBQU5HB3esewzV8TOe4naM7H4ikwXI9HHfYk/FAdnoxrvSje9PqPi8vb3PLhDp/7o805K6ikOH/78CT0giE/V5Mm7yKNqJjWC0rk/IAKA5zC0R6f0QBTfnhIzLFmI425viG+LudHX1+6mPBAe1m42gRMPfBzqhfTIyFJyDeuByxyBr2BRzrmXqVuTHmD0H3jtFMqFMuKzjA3E2mbSqsOcqVGgd9xfRun3GsMSAVFqnFTrP0liLXs38lNAl1w9fqsL7WmmcNmGzlVZDn3hlrRMXJ+ddnIedaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpQ2Wy2IvlO+F1hTieknWYSIadCdq3njy9qwz5i8jUs=;
 b=i5iAlv3bTXeNa+lZtUoBByaj1zOkSWHJI3yLCvpx0r5F+tiV+YqQW5JzHoYUsQUnl+SXH2Lf+DgKGQ+wdxkrkHzr5rRMYBSidtrmGJc6/Ftv/R85ikXViIpZoLlleupUv4P0/icevwZydwEzd892gXw7ZJXzQ1nGzOWDuX24g28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 07:53:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:53:04 +0000
Message-ID: <8b065c7b-d5ff-6742-94ed-997aadc7adca@amd.com>
Date: Mon, 30 May 2022 09:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/7] drm/amdgpu: Add work_struct for GPU reset from
 debugfs
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-5-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220525190447.239867-5-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0160.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42bfa483-2b33-446c-29f4-08da42116d37
X-MS-TrafficTypeDiagnostic: CH2PR12MB4104:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB410453735F84A34A382744EB83DD9@CH2PR12MB4104.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enlVhMvMGEkD/EDWRBmBInHg7eImL3GYu9kr52jpv/fisFvcAot7K6dyN5aO35Sd5gIP8idOZ0hFB73BXJaXloYBgWvCIEsZS7tDuQM+0hR186GVmSGMrj99/HLmTdbTpbvU1msEK9FVn8QmHEmLLsTMuXkga1JlCgjRUOGM8KMGP42o6aYdHeTlRSb2qZVkDEDQM8ljvELfg9urWkez/tkm34vZLuWiE2JY7JKDHAPVaXy84SpvKcNsD/94/1EFuj4NoJJAdc11ySf9nFeIGlTQFIE+YRP8skpiTc/RMNtPV7FWHFOjhcIxzjVpCiAhKiiPfivxoXfAXiymbHHJV2O1hrJsMG/dbTMbvtdo/camlzp5NbhW7nPeaF605F3DrmBAqvWXr/pMI+GM9cx87SqOZaHtKqGs+Xy5waHAq28+NnoZoXVkbvDZ4OqKlEpKvkB5+iJmm8h3HkJS+Ck/AVcKvZCuNrhWRZa/RDzYjsRFf2ILyZwgfzYxu9VctNEyxFk/QWHY2HO/wjylHuKOkqvA5TI0T16T9gT+l99py18T/LpLVGkqGQKnp8j4bboTHaPZCINl0tgr7TmiyIRYJaZG4G1dxyZwdHGfUiZRCo4i3y6iFj8G76Vm43TTg8ch9+LYEtVh/idNlM9zEbUI1c4tUXHIl9z0CgPdx8k0hwvlEgBhQz0DHkTrIRYdJH4gJS16e7TKlCy88jq9UozmdMWyyWrBMkehnwcWW7cPDRX6lfXhoKezgKAuuUl0R8Fa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(5660300002)(66556008)(4326008)(8676002)(66476007)(508600001)(83380400001)(186003)(31696002)(6486002)(8936002)(86362001)(26005)(6512007)(38100700002)(2616005)(6506007)(6666004)(2906002)(36756003)(31686004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdlS0IrTjRHTVNpUWNIZ3htWURTMFRPYjRRYmExSVdnZWpIN1d6d1l0RG1P?=
 =?utf-8?B?aU5xamo3cC9RT2V0N2JDRTQxN2J0bzRhMEFoaHE0VUtjb2cxYlVUOEVLWjYy?=
 =?utf-8?B?STF3bEJiaVVsa05xNm5OMGpqL25RanJYTnFkSk9mc0V4R3hua0FhbmZoMGg1?=
 =?utf-8?B?ZlQzc3pnYmhoVzZxcWcvVm9hbUpVamIzWCtrSUhEU2xidFZsdWNPckI2ZHIv?=
 =?utf-8?B?VWdINDBMbG1QRmhlcCttekwrRE52a3JnNWEwK1pNWFRXS2NES3oxVU5qeDZK?=
 =?utf-8?B?Qkp2MFVqZXhUZFFyL2hUYXAxWDZybStMOFVhVmlrbmdpSVZpVWR6M2VKcUVy?=
 =?utf-8?B?MDg2VlpFZVp3L1hOVnVwVUZZOGZQSkhvNW5DczUxU0IwY3NpRnQ4RjFXem5v?=
 =?utf-8?B?ZWw2d3hBZVdPQ1FuL3IvcUdyU2VPNmoyalo3aW8weG10eXk2bExPbWp0R0Nm?=
 =?utf-8?B?c1c0aHJOVWtRTFFkUU11L0xSODhNTVR5bkZrdmpNV1ppV04wZ3ZYek5pTW5l?=
 =?utf-8?B?RWxPSVB6cy9BeVZXVnpvQWlVTWFoVmhDQnJldXBqMUxyRWZUZ0IxNm9CNW1i?=
 =?utf-8?B?WmtxTUNMTGUwR3RqVkJ5UC9jNHpEQXI0U1lZOUtVT0hnenhNTUVVVEc3TzB5?=
 =?utf-8?B?aTduSXhEV3VTcmJxQjdLS3hUWTNFQjZyT2pKVStZZk1RUW5OcjBTSTdXMnVO?=
 =?utf-8?B?MUtGaG5rMURpWitRWENTaXBSWjU1U0ZhR3ByM0JTMlZ3M25WQ1dTRWpNZFNT?=
 =?utf-8?B?NUs1ZUxwVXRSYVZzcG5PUUlQK3FPUi9IWmJZWWdtUlh4cVVwejUyNDlWZUNL?=
 =?utf-8?B?MkgxUlhKOW12YlJBdFFSN1hqZytjMSsvRlplOW5iRGVWZ0w4MmFNWk5WSGtw?=
 =?utf-8?B?Y3c0TGsvdlZUT3hCbi9IWU5mdkhoUjAxa2xIMFQ2N1dELzZIOWpGeVdlL2Y2?=
 =?utf-8?B?ZEt4M095cEZQWTdyTlpUdXFDMHZubThmNldBN3ZGZkViOW8yUU13bU9yckFq?=
 =?utf-8?B?bjRCL0ZYbzBDTm5KY3JFUEs0N2R3NWYyL0N6c09CTmk4b3kvZkx3Qk82UGxT?=
 =?utf-8?B?VUFUMWNLVmNjdGEvZjhIYnJIRkRNNEJKMEQ2NUNPRzh6bHU4dXJXa01mR0dW?=
 =?utf-8?B?QUxaQVdZcUwyOG1BcUd4YWhOWFBJOWpwMGRZbmV0cWhuaFBXaUhLVVQxL1VI?=
 =?utf-8?B?M3A2ZXc0K2RURTl6SVNaOWo1cVl5cG5tTDdvWlcrNDc4ZlJUT3FUVHR4SGVl?=
 =?utf-8?B?VS83Wm9hMU5UT3RkRzJlYk8rVlYyTHJiSWVHZG9NRzNWRm1Gc0RVZURUZzFt?=
 =?utf-8?B?QUpKNnU0azJkRHBoMGNYYVlvWXpwbWtnR2ZzM1V2WmZMTTZBdmkwenBwUVBT?=
 =?utf-8?B?RSthRTFXMVZmMnIwT2YwY0wwNzBwUUN4L25ETzRYRlc4NityeTluS2J0TExK?=
 =?utf-8?B?RjY4UUpPOW5SSXN6aHFBUFdtTDNCZ1FDWVQxUWZMRFo2aFNZd3FUNTlRUWx1?=
 =?utf-8?B?OWdnUFFoOVB5TGNZU0tHVFNIQWRoU1cvU0I0eTNKUG1TQlVZcmZiR0tna3pX?=
 =?utf-8?B?aUhHTnJ2MDhuQzBLTWRJR3dGbXVHMUJqVXJhZW9EQldvTFRQaVgzMEhQYjNK?=
 =?utf-8?B?dnpabHR4NUtwTlI5SnBOaytQU1k3cUg4OGRoNkFHMWtLQ0R4WXVtc3Z5RUFO?=
 =?utf-8?B?RFRFWWZFQmtjeURQRXFRanJENnk0MkdyU20vcjBldEVYWmVyUmhiN2plMFVS?=
 =?utf-8?B?UHRwSnBiVHp2bG1SWHVzMTg0SllPNGQySVk4c3NKaWtRUnp0bm1vTDBDUkR4?=
 =?utf-8?B?L1FsY2lNZGZ4Q256UzNWWEllUG5ZRk9ic0JxRHM0ZjlRVjM5REt4NFhPS3d2?=
 =?utf-8?B?Q09lOW9ReHdWSmlLaHI1UnU3MFZHekgyWHdEKzZ3SVVJTk9wZW1SNjNZTHFO?=
 =?utf-8?B?U1d4aytWTFowV3RFUE1LTHRSS2c5dG1ONXlLRzYrd21ETWFrWVNidlM2QVpv?=
 =?utf-8?B?MUYwYkpWRDUxSm5oQjFqYm1XKzJzandVdG1TczJwSTVoYjBkVlB6OUFiRVdG?=
 =?utf-8?B?enVIanJVdks2b3ljcDczR3ZqVmRmSnh1V2JLVlZzaUhidTUyY3J5cFNsNXEy?=
 =?utf-8?B?Yk9vUFA5VjE5MWV0VDBOb0tONSs4aWUrUkZMZlR6QlJ5bHNCcjNUM2haWC9X?=
 =?utf-8?B?Z2wwd1Zha0M4cFJPSW0weGVEZzBtZ0FINnkzTUEwMlV6R1l5bVJXNDRIT2k4?=
 =?utf-8?B?OUFJQ1FnbGYxWCtzMnBLT2UrRDBBNVVVcXBlS3d2R0RIL05QSndjQ0JQcmdv?=
 =?utf-8?B?dWQxb2w5T29YSXlPMk5Jc1lQT2FUcWptRVIzWVI4RlZTSUN2eThjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bfa483-2b33-446c-29f4-08da42116d37
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:53:04.2586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmU1gXRaanz4QRy3TtGRjTPQ91I+KTeNducP9jzWqjq/zcoflHqVqGeDSKtNjBrV
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
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 19 +++++++++++++++++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 76df583663c7..8165ee5b0457 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1048,6 +1048,8 @@ struct amdgpu_device {
>   
>   	bool                            scpm_enabled;
>   	uint32_t                        scpm_status;
> +
> +	struct work_struct		reset_work;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index d16c8c1f72db..b0498ffcf7c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -39,6 +39,7 @@
>   #include <drm/drm_drv.h>
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
> +#include "amdgpu_reset.h"
>   
>   /*
>    * Fences
> @@ -798,7 +799,10 @@ static int gpu_recover_get(void *data, u64 *val)
>   		return 0;
>   	}
>   
> -	*val = amdgpu_device_gpu_recover(adev, NULL);
> +	if (amdgpu_reset_domain_schedule(adev->reset_domain, &adev->reset_work))
> +		flush_work(&adev->reset_work);
> +
> +	*val = atomic_read(&adev->reset_domain->reset_res);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> @@ -810,6 +814,14 @@ DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
>   DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
>   			 "%lld\n");
>   
> +static void amdgpu_debugfs_reset_work(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
> +						  reset_work);
> +
> +	amdgpu_device_gpu_recover_imp(adev, NULL);
> +}
> +
>   #endif
>   
>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
> @@ -821,9 +833,12 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
>   	debugfs_create_file("amdgpu_fence_info", 0444, root, adev,
>   			    &amdgpu_debugfs_fence_info_fops);
>   
> -	if (!amdgpu_sriov_vf(adev))
> +	if (!amdgpu_sriov_vf(adev)) {

I think we should drop the check for amdgpu_sriov_vf() here. It's a 
valid requirement to be able to trigger a GPU reset for a VF as well.

But not topic of this patch, feel free to add an Reviewed-by: Christian 
König <christian.koenig@amd.com>.

Regards,
Christian.

> +
> +		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
>   		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
>   				    &amdgpu_debugfs_gpu_recover_fops);
> +	}
>   #endif
>   }
>   

