Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38C1C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E421210E401;
	Fri, 31 May 2024 06:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k8sKUUJT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F2D10E401
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnGCEAlbsVHrh3xwp9b+iJ7KpWmhEY7h6cr1rfPEOswEiZADnYlpmCeyMJfyhJD29Gp7SQlk47bXWoED7PfAHf5fPYaJINfAVfsM7vHfTyvuiKhAbzUznv+b0wSH9w36YtptO0bbljjFHvy5hdrRo3+jsGgKpO3mO5WLarEyal6YL+OYwnSDKr3bsGA2H//mKCAsrNxKT590Bd4pdSSVNNYXjjlXUmj1yj7/v8eVgwI+ob8a5CNk7PpciWpKqEGQ0+qJ5hXeJPnYALfuFdg6ukemOrfAzTfC0dNX47qlBaEyhF/AzbML0ZKQ0XGs2MwkPSw6YPoase8crgZrK8o+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqw3mtZGscQptjRi0ve1R/Wnk1quLCziP+uQMEoPym8=;
 b=HMHNdGL2uGarnenivtFTDZuPid5xgT/dNvB20bWghrYt4r3ch+TljOE4j3cIxvXNSzm4WMhNYx6N/5tdS95R/1d1FEXsA+Iy8S/DJUETbXopfcmn+9GyYCR8k7o1C3RZw1qJ97kkOZZ3v1Cwv74tVHQ46io5ebEaXQ3APOJbsi57PE3Hzs4G9Hv5MlkMEME7jcEXnZQ4qbnSfrq9fMw1Urk5i8k0FdjjTYtxee6Zm8/dj+9mlit1tB/4F3A1WNMv+CjV57GWsj829oNyURRpxvbbwBvxzu4nyAnFGQ4DbvpNOlxG7i3etaK/vziwgZuSx775tuE/2j0eEwoY/DZEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqw3mtZGscQptjRi0ve1R/Wnk1quLCziP+uQMEoPym8=;
 b=k8sKUUJTKzE/obou63kDqvoH2zVXunJ1qwQG9g51GBWlSnyb836evuLbKCytVjTcOgjSGj8wAhEs6J2Af12wSS7Z6kbs/h7hSCRYmZVUJKGmPj/rURQjnfeyczKoDS/7j/gk4Ab9XelVvQwvZqu3qtXSjkg5VLXojdNZw/u35ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.36; Fri, 31 May
 2024 06:50:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 06:50:31 +0000
Message-ID: <f8422564-02e6-43d3-bbd6-538c7e5e9f0e@amd.com>
Date: Fri, 31 May 2024 08:50:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] drm/amdgpu: fix missing reset domain locks
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240530214805.40970-1-Yunxiang.Li@amd.com>
 <20240530214805.40970-9-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240530214805.40970-9-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 266b8106-14df-4959-f22c-08dc813df6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXhLaXBqUkFQVnZ3MHBHbndXWVNHV21nQ2ZmYlk2bXRmb1lmbVp4UVgxc01L?=
 =?utf-8?B?c1N3YWFCbU1haStXMW5sd0xxeFFkZ3dZdXFsc01kU2p5NURMVGI0cWc0cUJ0?=
 =?utf-8?B?NXQ5QUVUQUtHa2VNdkJUM3hLbW51N3A0enl3bGI1TjIwWmRLUVNxNTJIVHZ3?=
 =?utf-8?B?NUhZSXFBb0N3MytDWWl1UGhHQnpJR2w5QmhVTEt6a3hQaGR5bGRXVHUxQVBm?=
 =?utf-8?B?dFdIV3dmcEp0ZFMwem9xcE84WWlvRlFSZEdjMzYzSW1PMjVneEJKYUErT0l3?=
 =?utf-8?B?QTVIOGx1SHVBUTdBeE1EVmQzNUdzdWdrdFFNa01hekI3aGY2WmE2ZnE3YURN?=
 =?utf-8?B?U1N2OWZxMXVyV1N0bHQzL0RRbkdWeUR1K09idyt2TUwydmNpdkRHVDhGbnJz?=
 =?utf-8?B?Vnl3bW9LN1QwTHUyUER4aC9ZZzduVWhOUXQ3ckxaUkNGTFlpU0F1clBjeit5?=
 =?utf-8?B?a1BMYmNCTno2U0RuUStNWHlyeUpqOEczTndxcmZhdmlFMEV1M2JLNmhQc2pr?=
 =?utf-8?B?VDdsNHlWS2g2OXk2cE5hTkdNUEg4SWJsL2tsMmk5RllNM2xoM3ExS3JkcEZF?=
 =?utf-8?B?V0dVOENkR01oVHVWUlZBRnJkU0g4SjVUWDNuQ254c3F4NnJpeDgySXI4OFcy?=
 =?utf-8?B?b1p3RHVjWE5RU3AwZ2hPRXl1RkxCc2FhdkgzV3Z0WDdlemJBQXBTMHUzZE1o?=
 =?utf-8?B?azFQd0VLNWRhdUVsN1R0dWpURnlncXM5dHBFZXY4aGZGWGFXWmUrWVVwT3dZ?=
 =?utf-8?B?eFh3MUdJVk5GMEpqWHJKSVJQZnV3TGRKaW12MFlibHFCNTBnejROSUV5NVJa?=
 =?utf-8?B?OGVaSmUzZWZZMkVZbTlPVzhCc1ZFUkJpKzdkdEZxZ0lFdWVLSXFSLzIzTFFr?=
 =?utf-8?B?WjNDMW1zRHhiaVZRazI5T1J2Z3lxR2sxR0FTSzJDdE1DK002Ny9Fa0RkNUVx?=
 =?utf-8?B?T3I1RzYveitMMHdtek01V3MwcndjWEFxa0lUUHpBcmZ1aGhBaTNRSHBmQ2RO?=
 =?utf-8?B?VjkxNUJMc2lHdkNNczZsMUExdXJJSUhNY0FvTnpOUnJSTlN3Ti8vZU1sTyty?=
 =?utf-8?B?L1lCYjhSN1puMTZ3RHZIeWNkSnFSWlN1NFEvWmFDZUtLWmdaRllaZ2hJM0Nz?=
 =?utf-8?B?MEpvcUtCYXdxZGlQTGNNdnFLZTJPbXVreTFzeXBXbXhpWHRXZWpoTzhjekgz?=
 =?utf-8?B?RjEzYklWZCtWT2h1Z3lLQlBDMDFwRlFmamhKY283WUVSbWg2dWpVRWJCbmdQ?=
 =?utf-8?B?L0l6NWhpWWZ3dER3NHY2dHR6VWdGanZEeWswTjVOUUQ1ZEs4dEcwTmh4cHVr?=
 =?utf-8?B?ZysrbnBKNWNRTnpmQ3VSY01vYS93NkwxT1BWaGkwS1lNZ1RGQm03TjU3UXUr?=
 =?utf-8?B?Ym43WkVneVRSQUNDbWp3VGtvZlJjWDcxTWh4a3hnNThYWFpwRHRSRndnV1VI?=
 =?utf-8?B?QzA4MGZteUs5SFVjWXd1TWxIbGRpWVhmM1J1RFNRNXdGNXp1ZFZtaGUwZDF5?=
 =?utf-8?B?TGFra0ErQ0g3ZVdjLzgrMk4rbDdFRzFWVjBPaVgweHlOOXJnVllSMlRodFQr?=
 =?utf-8?B?cXkwU0wvYkJQTXpzOHZRak9HYXYrQXgyRzJ1QXZrc0xBZ01IQTFXUmtQUG5U?=
 =?utf-8?B?SjlsQStwaWhyaXpWQ0JJRHRvWWh6c0hKZU5XOE9IUTVWN1NRNDBPb3NqWjlT?=
 =?utf-8?B?dTNMeGhaN2dvbjNPN3o2eFJzQlpaZ2lDUXJkMVNxd2Vic0ZGSGUwMVRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlUwMWp1VDh4WGRCd2JZZ0ZROXRoNWV4M2szT0JhaHR0QVJHTVJxeEZieG1o?=
 =?utf-8?B?WWh1ZXl4OWxjZUF6RTJKYmZFeHp1NllWbnRsaXZIK2V0ZExhU3AxeENNeTA4?=
 =?utf-8?B?V09uSDBURUMvcktsWCsrS3p4eEs1MGpnVUNLUWtac1hNbTY4YndweUgzVytJ?=
 =?utf-8?B?N0I1SGE2YUYxVVZ0RXllNkc3dUhpdnpOb2oxdytkY3E3Mzl1TzRmcjErcmF6?=
 =?utf-8?B?WWE1Wnh0NFRKRE9DZ3pVYXBhKzRwTWJqL2d0YU9ZTVg3QWUySW5hRDh4a2k0?=
 =?utf-8?B?Z2s0TnJyWk54Mi8wMUpxZXhWU2FJVElUWFowV2wvbk5MZmsxRm5SbVc0UzdT?=
 =?utf-8?B?Q2VqUDNzNWVudXFtd1I0cGZlQ00wMTRDdEszK1hmV1FNcFg4YXBNNmVsUTJU?=
 =?utf-8?B?ZTRULzk2NWFGbWlkTEx4eW5yZWxzWG1BMCs2RmFaZjRMTlFzTXl4ZGM3KzI5?=
 =?utf-8?B?U2RkQUJKRG1xVlRsZlduVGRKdkh4M3o4Qnlvd0dLRVN6Ymprck11RmJVNVhZ?=
 =?utf-8?B?NDVZVDVxcHZQVVFmTUNZRHVGZS9FYjgrMjMvWVk0NXI4L1QvMEVBUUFISGdX?=
 =?utf-8?B?Vy83Z2trV3NWbHA4ZXlTNFVTamcvMVNPdTRCUFV6V0gyNTJJUXdYb1BaaWhs?=
 =?utf-8?B?QjJoU1pwQ3FhZWFEWTQvdWRKdS9LV0dONU9kZFBOYmFML3llbWZ6UXYwZXd2?=
 =?utf-8?B?WlRnd01JT0YyRzVibi9UeXBBTXh3d0J6bG0zbTQrNForQTBRYTNVbjRCM3k0?=
 =?utf-8?B?cVU4ckNGb25KUHlWUUJnYW9UYnZ1S3Nsb2Y3MTV1czI5RmFiODB5SFAzMnho?=
 =?utf-8?B?OHNlQUlBMVNKMnVuQ2ZxSzVNT2kvK01JaEIzZDFjUlRocDBPcjZ4aldYVE5w?=
 =?utf-8?B?dzFNUGZDNkI1YVBXbGNnNlFNSHhBNlhZKzJjTWtpRjlVYXRZTkc2eWEyRFE4?=
 =?utf-8?B?VXllVDVpK1V1Z1VoRVhnbldyeGhpRmxldDl6MDliWmowc08rWis1bEg5bExp?=
 =?utf-8?B?L2hPVEM3VERwVmVUZStITWphSWdGSlZ3UzducDlyZGg1MlBsQVJVdE9IWnpH?=
 =?utf-8?B?TFJ6THZUaUs4V09lcU4vV3ZWWXVTbWw5V3lXSERUSE90K1g5cFNIK3c1dlAr?=
 =?utf-8?B?dml3SVNvaGl2RVIveW10cUNCdEpicGJDN093bVlkSTBDR3JYNk1YZ1dBYzlB?=
 =?utf-8?B?SERxSlNvYnNBQ3grUWhyWnBPdDd1ckkzbkVZZzBiQk05dEwzQWE2WncvMlU4?=
 =?utf-8?B?M0N3cXVvL0l3N3RMNmcya241Z1RhVTlmSGpUTkRGUTYrUlNCcmNGU2hZbWVv?=
 =?utf-8?B?VVo3ZEx1eVJaRGczZ2RrN1RGUXdsNnd4VmsxL3BTaXpPYXJtOTVSY2Fud2Nw?=
 =?utf-8?B?aEZOdkV2aUttYi9VaWZjVmYzeEszU1VaVUp2VlNieEVwV0d6amwvb2h0MmFp?=
 =?utf-8?B?MG9Md0VKNWprRTRQSFA3MHVMZWREQmZyWGVFdGkzR2xTQmFuVUtPcDVnUkdY?=
 =?utf-8?B?QjNndG9oYVNNaGN0VGtsREVCUTAzL2R0R3BZcklxWGZSSTg3bFdIZWVhb2di?=
 =?utf-8?B?VVdpRWZmT1RQOE9hbjFkUUk4WkNaaUNLeGtiWVpPd281TDhOSGVZeHYyVVJN?=
 =?utf-8?B?cE5yTXNlQm5BKzRiUmlFSkRxTG1tQWFsaWlZNUVCRi9nUU5Wa3JwQStYZUlw?=
 =?utf-8?B?dy9rMGtoNUQ1bDVEQ203RTZ0cmEveVpIb3VocUdaajAxdXFXaFVENGNGMHFK?=
 =?utf-8?B?TnhFOXFFOCsxd3Z6QlE0NUh5MXdRWERWSnNxaUlHQjNFMEQxUzhvaEg0d1RY?=
 =?utf-8?B?OWIvamtsbnhjSERKM1F2M1JGNkJ3cmNFc3JsTVcwcjM0Z3VkRXlCSDBKeWE4?=
 =?utf-8?B?VVJwakJwVTlCaURLem43Q3BPVlRDMTNxLzZtNC9Hd2R0d0dZVUtiUlVna245?=
 =?utf-8?B?S0s3bGxpazFlaEQxQ1dOOUZxTXRsMUxTc0VvS1ZhMnE2c3VIR0E0Wk5OdlRQ?=
 =?utf-8?B?eE1OZVRuNUU1OCs2UTBLM1R6OEZvR0dSMm1DNEtUZXdrOGlSQ1M1c2ttSlQ3?=
 =?utf-8?B?OFBqS3pIaEtDNjFJam9kWDd2Z1pmZS9BcmJwM2ZQcDZ2ZGdIdXFXTWdvb3My?=
 =?utf-8?Q?eNplh8mPcl0jOJ6Y28Ly3R+s2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266b8106-14df-4959-f22c-08dc813df6ed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:50:31.6658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7Hse2I0IbnkAi2EHNrFvuu50GMC8bXkHIN5NQd+VfAmGuFvk7nBMzCzQpipwLgD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
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

Am 30.05.24 um 23:48 schrieb Yunxiang Li:
> These functions are missing the lock for reset domain.

Please separate the GART changes from the KFD changes. Apart from that 
looks good to me.

Thanks,
Christian.

>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
> v3: only bracket amdgpu_device_flush_hdp with the read lock,
>      amdgpu_gmc_flush_gpu_tlb already takes the lock
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c               | 6 +++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++--
>   2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index eb172388d99e..256b95232de5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -34,6 +34,7 @@
>   #include <asm/set_memory.h>
>   #endif
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   #include <drm/drm_drv.h>
>   #include <drm/ttm/ttm_tt.h>
>   
> @@ -405,7 +406,10 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
>   		return;
>   
>   	mb();
> -	amdgpu_device_flush_hdp(adev, NULL);
> +	if (down_read_trylock(&adev->reset_domain->sem)) {
> +		amdgpu_device_flush_hdp(adev, NULL);
> +		up_read(&adev->reset_domain->sem);
> +	}
>   	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
>   		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 86ea610b16f3..21f5a1fb3bf8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -28,6 +28,7 @@
>   #include "kfd_priv.h"
>   #include "kfd_kernel_queue.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_reset.h"
>   
>   static inline struct process_queue_node *get_queue_by_qid(
>   			struct process_queue_manager *pqm, unsigned int qid)
> @@ -87,8 +88,12 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
>   		return;
>   
>   	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
> -	if (dev->kfd->shared_resources.enable_mes)
> -		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
> +	if (dev->kfd->shared_resources.enable_mes &&
> +	    down_read_trylock(&dev->adev->reset_domain->sem)) {
> +		amdgpu_mes_flush_shader_debugger(dev->adev,
> +						 pdd->proc_ctx_gpu_addr);
> +		up_read(&dev->adev->reset_domain->sem);
> +	}
>   	pdd->already_dequeued = true;
>   }
>   

