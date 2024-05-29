Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67262C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 06:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE26810EF30;
	Wed, 29 May 2024 06:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2WVlM4yV";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B93F10EF2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu5afpGtrPkcMqKGQWaMZ/ft0eVXtpSJtPXZJM1W7jcMdvBx/epm7101243IC7BKP6a+64sTIHVwzfmnOwJ1icLZiiyoxic5ev05/Hr9i9wnS3XYNVyjTIZ9qvCLN9pjIBaErP43uHyRWhmWnnXkk35UJ044seZ/ngktpYWZFppPSSMRY6w7TsXT6XGjld13YBLzk+dvvs7xjcdxJqbrMxDGtb0q1Brtg6O8AA+8pHf55CcdYhZrw8/XkjBlILvyRE+alLWTF+2sBMeUvxk3Li8FsRacle36ctn//2JnC9YYf6zQ0bnLOJST3/2aMNfsHbPjRrc3x1ScbKEQr8w8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Eb3rdwZfHFUEUROw5yi192BBrPjP/9IrqvVhCTcy70=;
 b=Hp86uUwDB2nBWy9BptoA2ym5UDYewf7HDu3F/rzBcF72XPAFHSA9BtX0vKEHc8F+nkV64XAl+wKLYYrfyVsYuMW2WvdVlPCP9HOF+/TuURD+l7SJkRwqasG4L7aLeuS/YYoeNKiSIN/BbnfFSUHImdrc6WCuWNnyGSyJV0SsKK/qhVlq+3h7vdr0fUXW57Ek5xuWFHNw2RaPyVSFTNPtU583QpPeQmR77prt/jyAvz4XDiFRAtTLVEKC4PkFKBuS+oxSR4yq/5HYGKcvn4boqH5VZ7KosBurYXRf3xqx0hASMFW+8XHTz3dlpTV6cWsAM0HrN4gXAg9JQq2iE6cQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Eb3rdwZfHFUEUROw5yi192BBrPjP/9IrqvVhCTcy70=;
 b=2WVlM4yVPWkKBTDs3nEcgh1Wyy9+S3vieIP/U4vD3rJcdHQIljrpfTkuodcp/RZO1DVS9TcGhgOlcyPcAaN8BKAuZcvT8JF940KNYu4VlzWiXIYxX1CbTm5Crf5MPM8amaFTZ05l+LQMoVd/k6jj7tZ2wRDBOkRFR/AvZdNgzMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 06:55:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 06:55:24 +0000
Message-ID: <14a697de-bc4b-4c12-9083-95e92a450a31@amd.com>
Date: Wed, 29 May 2024 08:55:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] drm/amdgpu: fix missing reset domain locks
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-10-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240528172340.34517-10-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d40defa-e79f-43b0-bfbb-08dc7fac5059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3VCMWJRTWNHcTBHSWFaWEQ1aGk1SWZrcXlrNVFpL3R1allsZkthVjJNb1VR?=
 =?utf-8?B?aVBqU21SUis0Zkh2b1JzVzRQNThEaU9RUXBNK3FVdkhoNDRpb3dmV3pwY3BJ?=
 =?utf-8?B?RlFnQS9FN3FYa1VHN2RJSXd3SVZyNStCeDBLbDNQdDY5TjBHM2NWSUQ1U0Zo?=
 =?utf-8?B?T0JpMCtHU05QYXRmQ1RocEdHY0FKNExQU0Z6UURzcWZGck53bUwrbEd1ZEZP?=
 =?utf-8?B?eFNWeFhaMXdHMjBtYk5Gc3ljSE5RbFMwOGgwMGxHRVhtdmoxdTYxb1lhN3pa?=
 =?utf-8?B?YTVOUWRUMlVqb2NSZTJtb1V1eWZIMFp6dkJxVzNRVklETkllNTNWK3FIVkx1?=
 =?utf-8?B?RkJHRDN4YzNFczhmTGljQ1VDNG45dGZpUytFTExmcmNETG04WWZISnFQTlFi?=
 =?utf-8?B?MEJWcDBoRW9jNjFXdDhzM09FbEhTUzZsaXVaelduT0N6MWF2ZzBCNnRldXpt?=
 =?utf-8?B?UUJYT2JzTEVZQ3doNlRWQkhxK1dEbmZIR0FXYmltR3hQdjlnQ3dacnVIK28x?=
 =?utf-8?B?dlozbkdrTS94U0hCa3JyWDlraVB3UGhRTGdoM0gzVXRWeU5LdGVNcVI1REU5?=
 =?utf-8?B?V1RJcTVLMGhDdzdQbXh6OVZOWHFjWTFSOUhNUG5WUG9NdG0vZkpHU1FWL2Jj?=
 =?utf-8?B?ZG9xcW5YWEFWN2hCTlJWVXF1enFEM0ZMWWZYdkp6UmhwSzFNeXhpRlVyNWRC?=
 =?utf-8?B?cTJKakx3YW5sVFVkNDZZRFNHRnVGdnM2SUx3VmwrNjRBT0lWQnIwWkJDUjFV?=
 =?utf-8?B?bE9hc29LQU1VTFA4ZWRocXYyRmYzSmt5ZSsvc1I2Z29wQytJSVgwNVdZcUJh?=
 =?utf-8?B?YWhIVmFWTTdZSzA1Q0F5QmdMOHJ0RnMxTVBGVFFIZzJmYmZjbEQ3cmY1aERX?=
 =?utf-8?B?Rys5VVVsQTJjYldIc204dkZZazJXRVZYdUVUenluZzBFU25UUzFaMlZoWWta?=
 =?utf-8?B?MmdIcmJBM0JiQUlRbEZwUUJrc0E2VEx1NDBEMVdTWUFyRU1WLzVPMnowekxX?=
 =?utf-8?B?WkpOb2VWV1Z2d1hmVW5FQzlFZE9KQ3AybUJSK3orMkN2R2l0MjlwcllyV0xR?=
 =?utf-8?B?ZmZwOEFqbGpUSjdiN3g5Z3Q3eUhKei9LbU1OSGJJa28zaVllYm5ESXNCVTRj?=
 =?utf-8?B?dWFUc1pzaVdIOE1INjlvNkZpRGJCM0VSdmNaU0JoNUh6cjIzL2wxekJ0UVc3?=
 =?utf-8?B?SkV4WmV2SG0vMWN0MjhGTjlVS0t2UHNoNHNxNWxnbk41NUJxbmJPR25JSXZX?=
 =?utf-8?B?SElJVnNKS01UaEFBNHZIa0NoeURTV05GN3hva1I2RENVdlNFYVZrcCsyQkxW?=
 =?utf-8?B?VlV2aHpHUk00YXdsQnpVSG5ENDU1NjhFcXdvbmJpR0R3SXRVUUo5SStTRHU3?=
 =?utf-8?B?bHY3cEhKTUhqWmlWSzFmTUx0NjV4Vm1GeHVNN25ZTncxc2tibTRpQ3pBYmpR?=
 =?utf-8?B?N3kxeGY1cVMvRnlUUXg5eW5lVzJQcHE5VDgwZXZUYVJhY1ZmbDk1ZDVTL0Vk?=
 =?utf-8?B?VjB4SmxXQSt5K256YVRqc2JBK1VGeXRXTHF6MEp5QlZENHBud3lNNlc4cVNm?=
 =?utf-8?B?TTg1VGM5RkJzYkhwdnZmZC9Jb0VvSEZYSGNWaE4vcmRQWW92a0lhZEJSMWVp?=
 =?utf-8?B?RkZ1T2k3Qk82VHhBUThDaFlBaThHVVFlQ2JPU0dLVHJ5Mm9LNzJLNGVRK1ZT?=
 =?utf-8?B?VGJMS2xsc0tlVWh6Z1QxaEN4Y0FuakxiOU55YXlTelU2RTN1VUZxcURBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2RueTBpS2x0SXRnd0NBSXRmKzJQNGlNbGRrbjFBUDNMQlpEQU85azg3S1Rm?=
 =?utf-8?B?UWs2YVpMd1JnNkZzMjVIRCtsekI1UlJLcm5OYjFKSUloZ1pIOHVLZjgrUkhG?=
 =?utf-8?B?NEljT0hNZXhhd09OT1pNR3hxNzU3c1JUbXY4ZDlrZzFWSy95QllMS3UweE1G?=
 =?utf-8?B?dEdTSDVWZ084U2I3OUY5UTQrZnlqMVhUVW5tb1c2dUdCN3RVSVU3VnFpbVhM?=
 =?utf-8?B?SVhqeUxicldKR2RhVmxrdWZocml5MVBmcktYTndjbnVhZ1hXOTZhQ04yRzVj?=
 =?utf-8?B?QnQ5emQ0OEx2VjhRTlJOT1NIVEdqdjhXWERZN054RWJZU29nNnprOHFZYXFM?=
 =?utf-8?B?Y2t5b2l6ZnFydVdwNXVLMlQ1M3E4OVVNcm1XbEh6NUMrUjlUK0NDbW5oRTlR?=
 =?utf-8?B?SlQrSjdWUXZURE1xYXA1T0piblhRMXJ4U3RBZWFqcVI0bTN5cHNFTFdTVXdJ?=
 =?utf-8?B?Q2JjeXZZaUF1aEovVG1XZm5waExFQ1F6QXg3aGxkMXN6S1duWnc1dTFmR2c2?=
 =?utf-8?B?NXQ0Z2hVWnlwenl6ME5QMUR1Q1dpOTYzaVd0QmlwRXpUTzFwbkMxZmVFTjhu?=
 =?utf-8?B?Rk5WSkhCTUZQcXoxVEVUMzlad3lqK1pidlFsRUl1RC8vZ3g0U1lWVFpJaXBr?=
 =?utf-8?B?K283OE91c2ZTYm1OZ1pvOStDd1JLYVRUc0JzWDFRVGpWQXp2YXhHNjlrQVlU?=
 =?utf-8?B?U2tESVpoaTdyTi9NK1ZEbk1uUlFxK24vUWtxNHA1K2tnM3dPODZsc3JjWlpn?=
 =?utf-8?B?dHpPNFZabWlJdGFwWHpWMmJpWFVBblJvY01RNGxWcERNT3dZUTE4WUZ0ZTZK?=
 =?utf-8?B?dzdTMjhScFlBTHpkNU5EQ09ja2N0QW1QRktTcU1iSTI0QUdQcmpheHF5QlhF?=
 =?utf-8?B?THdrbHl6REdNbzZRa1JVYnMybWVvOFNCWm9RbnVtaTEreTRBK0hQVzZ1UCt0?=
 =?utf-8?B?VHBrZFM4Wk4ybS84SytVcVlka3pObzNLRFRXOEM4ZU95QUhWUTI3bUpiWnJC?=
 =?utf-8?B?MlZYdFNnQ05JdVdUS1FIN2ZFVXpOcU1PQjZINmowalk4WnBacnRBalhqdnFp?=
 =?utf-8?B?cGpDODUxcm9wd29td0xhbU9vODV4eDlzZUhEOUE4QmlnQVFmUi9Qbk4zQktQ?=
 =?utf-8?B?LzFFUmNDQVVPSkM3OFg5ZklsVCtYazJNN2NkaVJQbDF2Ny9JSmR0TFBzSU44?=
 =?utf-8?B?Y2g2L2hSZStCWjNXaWdEUWNuaUpuKzA5cUY1MmRPN09mSW4yMXNqTnVNelFu?=
 =?utf-8?B?bFE0bndkeXBjTmJJR1JEaVhxUVIrWlFJYU1qMk5EUkhlSmNla1RVNXBpN25o?=
 =?utf-8?B?R2JON3VwZHNDMUpHdWowU0g5WlZtNis0WmN6QXQrZ3FlSUE1MXpCeW1rYmZv?=
 =?utf-8?B?Qkt6UFJrblpTVnFjOFlENXRHd0RWTFZ0Y0l2MHFRODlNWWUrd21YWWNJUmFB?=
 =?utf-8?B?V1dKTTBhTHZwenR5QXhuVEtOcVZjK1ZybDVjcFBFUTBVb1dSTys2MTI1M1A2?=
 =?utf-8?B?SkErZktVVXB2aXdrMzZOdzJPVVpaRkJQSVBNTFc0b0FJTjJFQ0E1M2NKamFU?=
 =?utf-8?B?UTdXZnI1LzhCMHlOTGw3ajI5WFRGWmVJVkJhM2NjS3NjQ3oySmY2d3NtY2Nv?=
 =?utf-8?B?azBSZ0lSelJ0enV4WjR0YmxxcTN5Wjk0LzFhZkVlamZHckxrVjdOM3BiQmNr?=
 =?utf-8?B?UCs0TVo0R1R6Z294RWlsbzBSYWYyRDF3bnoyc0lVUXNuV2s1QzJYMW9aNWVp?=
 =?utf-8?B?bVB5ekxGejREZVhsOFd5N2tjOVpYY3UxYzYyblhQamJNZUNHUE1HaDh1U05I?=
 =?utf-8?B?TnpKZGw0RkdGNVE0bzM0RXo4cjE1b1BOd2ZYN1hjQ25ickZQTUZIOTlzeGdL?=
 =?utf-8?B?RE5nM2dxSFlNSzg1K1dJMGppWm1zL0hsZTk2RHVyc3NBUkMxeWh4VXJMOHJs?=
 =?utf-8?B?bGcyZW9TOXhGYjNSY0VMQ0ZlcW1tY2ptVlZLRFNndkp2LzkzanRvMS9sNHh4?=
 =?utf-8?B?U2RjZTR3enFuM3ZxcitWbmtDYyt4RUM4T25zamYwcDRKOTM2RjJSNWZHKzJJ?=
 =?utf-8?B?Sjh3ZGlPUWIzZi91RTMza3J2RjBOWHhscHMwMUFTekk0a09YcXNFa202K0ZD?=
 =?utf-8?Q?PTw1jyJYCGwHJyuHXOJ+lw5Bq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d40defa-e79f-43b0-bfbb-08dc7fac5059
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:55:24.1451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VvUIT3ApM6Vj243APqjuqyJ4rJta1yjBPieTPw6gRIrPVsW1PFqh84QZ8373oE5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176
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



Am 28.05.24 um 19:23 schrieb Yunxiang Li:
> These functions are missing the lock for reset domain.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c               | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                | 8 ++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++--
>   3 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index eb172388d99e..ddc5e9972da8 100644
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
> @@ -401,13 +402,14 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
>   {
>   	int i;
>   
> -	if (!adev->gart.ptr)
> +	if (!adev->gart.ptr || !down_read_trylock(&adev->reset_domain->sem))
>   		return;
>   
>   	mb();
>   	amdgpu_device_flush_hdp(adev, NULL);
>   	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
>   		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +	up_read(&adev->reset_domain->sem);

That is clearly incorrect. amdgpu_gmc_flush_gpu_tlb() already takes the 
lock by itself.

But we might want to add this to amdgpu_gmc_flush_gpu_tlb() if the ring 
is NULL.

>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e4742b65032d..52a3170d15b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -307,8 +307,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
>   			ring->name);
>   	} else {
> -		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
> -				       &fence);
> +		r = -ETIME;
> +		if (down_read_trylock(&adev->reset_domain->sem)) {
> +			r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs,
> +					       job, &fence);
> +			up_read(&adev->reset_domain->sem);
> +		}

Job submission is blocked by stopping the scheduler. If you add that 
here you create a circle dependency.

>   		if (r)
>   			dev_err(adev->dev,
>   				"Error scheduling IBs (%d) in ring(%s)", r,
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

That one is most likely correct, but Felix and/or somebody else from the 
KFD team needs to take a look.

Thanks,
Christian.

>   	pdd->already_dequeued = true;
>   }
>   

