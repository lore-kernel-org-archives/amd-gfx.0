Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3066ECD4F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D8E10E8D6;
	Mon, 18 May 2026 14:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0qUUAwKj";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C0910E8D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjOGrck4Hhij2c1TPacnQoIjIUnP2VYq7C3v30/1p10+xPs0lIRy9hKVObadKIOhMFR4Y0EEqfdwXoTfeVqCx6dHpfj9DA7HE8XH+dWZeQ1BXpFThkfzQcdMJJKnMCCaaMKiwaTghvsGEdZhEWUt9YocZw1oLbHRLts+wJOR6yLKvJQynivCCjKfJ9+3NS7HcK6/wK6oQMAZHkVEDeT+RofS/otLtfFgSgGrjGgvnO8g1MnfEka3h0ZdiK1ZM4L2p4Y9AnxU6F+rxN2Yz/+OEdpIl3+LbpQxUtGh9Sronxn+Rlh5IPWrspEvocHkNTcJRxKaq9Z0QhKbcf7swOqxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nqIDik8HUukDozUM9Tse86FlajHeyIGMla5GV2+l9k=;
 b=jg6zkPSJU94WfuwiZ7aQlEu5mKMxMcslkAsfKmOLalS92XXMqyGPrqJn4m67BedHpmkkry2q/ER6ygEOnn97uHt1LfYMfzCXo/IL9ej/i2paUX0m33aF0h3sY7x9BOwn5JPFtSDjAoB50ykjr+8qduHKo0x+DR/0WOQkYWYkk8hrU05jrsI5Mk6zheW6Ya8/zGG/JvpL6Btu5jQI8CvoTAbr4f10l353z2v8DWgMEGwkH3kOFCus18Lt8yrR65wMKrJaex48ZNqhihiheFF0p/wzp4/9V5Be+4RR826jA5ohG+Qq8o9FFLhMdYcIXM0kuPsxIHdBMZvk9Dnp8aRzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nqIDik8HUukDozUM9Tse86FlajHeyIGMla5GV2+l9k=;
 b=0qUUAwKjsH96kzFRkUO3uIEKd/RI37QZuhT9fmlCO29jGkz+eBUjB8VNoUzBY1bIZMd3v1sVM7r3OJwul9vjeyi768Qh8utGC2XaHT+qFe74w+PV7qxKMDGvfgvUfvYmqgDqTQUhe2NuMsEr8XpVrGdF7OvD944/abbeYgutJkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 14:57:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:57:38 +0000
Message-ID: <3e71538a-7fef-4163-b0f5-ad9ddfcc08db@amd.com>
Date: Mon, 18 May 2026 16:57:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: Use gmc->noretry instead of
 amdgpu_noretry directly
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
References: <20260513163043.8725-1-timur.kristof@gmail.com>
 <20260513163043.8725-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260513163043.8725-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0337.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: b28fd5a0-f60e-4668-5776-08deb4edcdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: wUe023YSAUoXRuAdwC54d2Y26WlUNgaDr7N/G+tomJh6jibXyeY1KaZ/7K/E1h/8f9xE56wHSv7+O8aVKo6pMgdQPzxNfgFCo7jBgT5gpaRSU9ZqKHmgq/Ds8BSTGxnRG2m7wJ2v9kYMI001De0GPGpnaYHzGAlocyHboiHalOmhDjNXr5roj3wc7c62dtw6QNSxldhbMSPjwaZtulgNbCWN97TGVGhNf50Jh2UaFHl1cYsplsNdjYJO2nu7ASClTqgCFeR7h4oCuBzekcsVjDGgM9b4tXlQki0us12Go9GIi9BxT/SzimoIos+hCxAF9W8n4An6qXNA8/Hn5uyxtvwozM3lYKcGFwPM+aqGMLWnmNc5IDr/vfYUw7sN8O6lQTz/sBCpBpmsC+LZc883pujQ9rIuZHrS1Krg+0H9whJTRURZpUPc6NPuGOaOLc/UX4/sFcCYw8Mv9fzzphblkmAb/bhkm6PEsW2px3FK9coWlNMKSGr87XDE7iL5l2SktvI+c51bi2zwWiilO2XXhDw4iAbtfHjGFHDKSRncKHXNkaSsnN9ctQsNwhDj/Z4Fabcz3EMqJsgjq8SZXhfx5FuhQtUkYxAagVoGTv/UAMy/Qa8ktnM1upkq1Qk8ysENve1jBGpwaShlT2TvyQQwPX/Im4ifvV5Gwig5T3DTlBTvaTw+O9AtxiYnTdci73Qq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkowRGlpVkdnVmZjWUl3eUtrWkxmYThxTWJtUmhEV2lXckVkNm1RaTJZRmF3?=
 =?utf-8?B?Ym9OODJtbWR5N2Q1MEhGaldYL20rOElTU0lNS0xTVWdSb0hvZWtjZENWM2w4?=
 =?utf-8?B?RkZSWGFTSlNBbWtzWmprZ1MrLzQ3L04wNXJjRXgzc00zMFIrOXB6bXZpaEho?=
 =?utf-8?B?WHlqNHprbnNYUXZVSEIweUtNa21uRlVWWDZuQVRiVzNueVFLVjVaSVBpSlBB?=
 =?utf-8?B?M29LTklFUWZ5ZWVEUExiVkF1c3dqTnc0MnpuM3pJeWlRNUFFK2Y3YUEweFNw?=
 =?utf-8?B?Sno3MC92YUQ3aitxTkllUmtrSUgySFh6a1d2SERhTU02Nm43aWVJWVUwZ25Y?=
 =?utf-8?B?WDFrc3l5cEpvU3FrYXZ4anJNUzkzM3RMWWZncDBibTVWcWZEdFBPMldwbXlX?=
 =?utf-8?B?VmV5MGUzK0JSZUJiZUwxb0NpVk1oNWlSTVJoK0s5VFJremlkMFJXaWNNQStq?=
 =?utf-8?B?RFRNakR1c0VOb3B5alNCZVBPeXYvalc4Y3l1dTZ1Vkt5SkVGT3RHemo1amdH?=
 =?utf-8?B?dzArd0RMYzdVZUc2ZEFreHh0TndNTWlZOEtxQVVWNWROZCtLNmw4eldXYmRs?=
 =?utf-8?B?MUdDRlVsYkZDRW01Zkp2ak5zV1JEUzUzdm5ZczhtaDRxZzFMcUZjN3pETDUz?=
 =?utf-8?B?QW4xbHBwUXBUMHR6eTRhbk90M0NxQ1lzMm4wZlU1TDluUTZDNTBxZjRqdk1K?=
 =?utf-8?B?ak5MS1NabnN5RjFnQnNGSWlIMVRRSSs4cW5zVVlhMkVIVjh3Y2NqVHQvbFVq?=
 =?utf-8?B?L3R5ZkNFV1dHYy9WYmN4bDdySnNEV3R0MXNNSWZ2ODFZbDJRemFBSXRMdWxB?=
 =?utf-8?B?WElwL3Z2d0dLcVJQSUJqbDNobk5BZFhmeWppM1FEUU9ia1RXWGFlN0luTTl1?=
 =?utf-8?B?VGVTMVJmMzBvcms1L1NYQlpSazNBSm9SdnEyN1kwUXpWQW40N25MblQ2VGdC?=
 =?utf-8?B?eC9KaFgwSkNaYS9vemdkNmtmckNNNEk4WmJoNDFMUVZZamZVOC9FZHNISzly?=
 =?utf-8?B?VHVkTE81cjQ5U2tNbWtjRlMrdnIrcmMvbnFnMkY1aFdtb1N3RmxwRGhCY0RO?=
 =?utf-8?B?MVc4VVpvR281OW4xL3hjUHpmNmZ1WVpmM2pEWktxWE5LVkYvREV3aVFzTVN2?=
 =?utf-8?B?cm1IMFVyWDBvZGtSMEo5YTVxV0lPbnhjLzBLd1Vxa0s3VmNyR3JtdmlrWG1G?=
 =?utf-8?B?YjdET1dBcVRzM1dUSmFhSFBYMnJsbVJnS01GaW00NFN3RWNXMi8xZDhaZURN?=
 =?utf-8?B?UUduSUMvL09oRDdqdjlsMHhRV2dIN215Q1ZTcVpOa3h6NWsxYjhtRitRZGpC?=
 =?utf-8?B?Z1RhRGllNCtxM1hUMW1XRWNxcVBaSXh2bHFaQkdoUVE2ckd0WEVydENnT1Iy?=
 =?utf-8?B?bGJxU3oxREdCei9BZjEwa2pmTHJLTENjSXVFZXV6VjV1QnRDRlY2SUVqTDJo?=
 =?utf-8?B?OW8yODQ5OUt5Z3BoUE03aTZTSTZVcG1YZUM0WmMxWHBZRzdFaFAyWlR4c2lS?=
 =?utf-8?B?RWhzY1RjLytSUVlsY1QyL2lsLzZrY0NHN3FLVWdSNGsyd3U3bVozaUFHWSsy?=
 =?utf-8?B?M29IQU1BVjlaTUZRWUF1dHE5K0Z5SFYxRm90V0MvUWY5ZXVxcmM2WUJmSG5l?=
 =?utf-8?B?UkF6N0t3dVh5bSsrUDNQd0tmU1cvSUtRUkxtc0sxbU1Ub0FPTU1VdGZOM25R?=
 =?utf-8?B?MHVic1o4eFc5NnFVRS9udGZiY09NRjMvOTlqRU9nNWtTSEh0NUkzcXVNckEw?=
 =?utf-8?B?YTh2a3YwWXlwcGRsSFk5OVl3Nk1oZm5aLzJEVGd3ai8vekxSOGZURldabFFx?=
 =?utf-8?B?T2VwYzNFZjVQMjhwbm1BemFKeVNQdVlUWFVFd2RFR3pQQUhuWEN4Z05XZFJ0?=
 =?utf-8?B?MnBEd3RnMjJIT2piQzNhdnlNYTBpSGErSUwvSlJSRW9BNmtidHIvU3VqREQ1?=
 =?utf-8?B?S2N3NVVMUi85K3BKa3RoM0xQQk02SXlPN1Y3cFZydVM1WC80a2JhR0w4UGJw?=
 =?utf-8?B?akkxWXpQVnVLVnY0SVJMOEc1ZnlVSDlkV1NEbTA0aFVBR0hrV3J6K2RyOXZj?=
 =?utf-8?B?eVZiL2xNKzJlMG1YZU9ielYxVFJGUnBmZ1I0dmFqMHpoUm1FS0J0Tzd0amRC?=
 =?utf-8?B?SWZJVlZaRWs0N2U1NVdNT29nU1BseEtHdlhKTHo1NzNadXJEYjAyVm05QVZa?=
 =?utf-8?B?c3prMmVFWHZ3WFA4dmQwU1dNaUY4MGlFTG1yNnN0K0cwTk9aMmxQODJSUWox?=
 =?utf-8?B?RXNxcmNZRHJNRW9RcmRlRXZFWU1icmFzR0pOL3JMencrbEl3dnZvNjJPS1Bz?=
 =?utf-8?Q?OcDCaZ7hS2l1FFTgRS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28fd5a0-f60e-4668-5776-08deb4edcdb5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:57:38.8101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXr47IPSGX8Dkko3Bcx2/dVm45TMo8MTsctfZ55H5Cj5VQljjPiis8zKbX9E6Xff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
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

On 5/13/26 18:30, Timur Kristóf wrote:
> Whether retry faults are actually enabled, is determined by
> the amdgpu_gmc_noretry_set() function. The rest of the code
> base should use gmc->noretry instead of the module parameter.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c   | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> index f9949fedfbb9..f845ba698b40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -321,7 +321,7 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>  		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
>  				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -				    !amdgpu_noretry);
> +				    !adev->gmc.noretry);
>  		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
>  				    i * hub->ctx_distance, tmp);
>  		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> index 7609b9cecae8..ba78b5a1a7cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> @@ -326,7 +326,7 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
>  		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
>  				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -				    !amdgpu_noretry);
> +				    !adev->gmc.noretry);
>  		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
>  				    i * hub->ctx_distance, tmp);
>  		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index abe30c8bd2ba..631f99e3741a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -318,7 +318,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>  		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
>  				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -				    !amdgpu_noretry);
> +				    !adev->gmc.noretry);
>  		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
>  				    i * hub->ctx_distance, tmp);
>  		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index b3ef6e71811f..8a87410ce016 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -323,7 +323,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
>  		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
>  				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -				    !amdgpu_noretry);
> +				    !adev->gmc.noretry);
>  		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
>  				    i * hub->ctx_distance, tmp);
>  		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> index 3d82cfa0f1b5..ab56dd15b3f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> @@ -340,7 +340,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>  		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
>  				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -				    !amdgpu_noretry);
> +				    !adev->gmc.noretry);
>  		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
>  				    i * hub->ctx_distance, tmp);
>  		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> index a1b0b7b39a42..6522a89379b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> @@ -333,7 +333,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
>  		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
>  				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -				    !amdgpu_noretry);
> +				    !adev->gmc.noretry);
>  		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
>  				    i * hub->ctx_distance, tmp);
>  		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> index 34e8dbd47c0f..23cf95783264 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> @@ -339,7 +339,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
>  		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
>  				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -				    !amdgpu_noretry);
> +				    !adev->gmc.noretry);
>  		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
>  				    i * hub->ctx_distance, tmp);
>  		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> index cfce7e1297d4..98568c72c2be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> @@ -451,7 +451,7 @@ static void mmhub_v3_3_setup_vmid_config(struct amdgpu_device *adev)
>  		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
>  				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -				    !amdgpu_noretry);
> +				    !adev->gmc.noretry);
>  		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
>  				    i * hub->ctx_distance, tmp);
>  		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
> index bef75c4c48d3..c9fb48992a2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
> @@ -334,7 +334,7 @@ static void mmhub_v4_1_0_setup_vmid_config(struct amdgpu_device *adev)
>  		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
>  				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -				    !amdgpu_noretry);
> +				    !adev->gmc.noretry);
>  		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
>  				    i * hub->ctx_distance, tmp);
>  		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> index 29f7ed466858..49b7f16a941f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> @@ -518,7 +518,7 @@ static void mmhub_v4_2_0_mid_setup_vmid_config(struct amdgpu_device *adev,
>  			/* Send no-retry XNACK on fault to suppress VM fault storm. */
>  			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
>  					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
> -					    !amdgpu_noretry);
> +					    !adev->gmc.noretry);
>  			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_CNTL,
>  					    i * hub->ctx_distance, tmp);
>  			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,

