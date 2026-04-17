Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1C1F8E4B3
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 07:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2437710E984;
	Fri, 17 Apr 2026 07:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l3N1WdYo";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7EB10E984
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 07:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4+qrs7bT49GcluMtYcWi9lNOoHB9BCiTxJR82kzqbyXE6NLdhmFehoe1UzFLPeevl0CW49Bjt09KyWFoAUvKR8CBANevx+6whyEA/PRGTUtI9WG5/VQecyjcZUBZwFoXyvjo2YEB9zR/bidqb5Mh17zkpJL/calOztnFkWNref2/pVFqT2UTADqtKU3rs83XBcWfvcayDo8F+z6ojtEDi5rhj7h+wNGv81d7JCUwBXG3/29xVj7G90/sTa39ZFDh9zh8b6k4LqGqfu/xAOVoSs9StBcfZ65pNKnDhveLXiUL/OqkEAgWxgP2y7amq3ONpr19ScIHX+tFP9k8br1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rnJ/DQDfDsULp4IFFfKEI2NOmjKJn4DV1YSEO8GI3c=;
 b=BMBe/U09Itv0YMo8ocy8R5xyK/m+pOWMBhQnUdnRgRL1gdBUcb7kP7XAoEhBZ9BqpIN1npzMXeNPodA5HXO3UJKN2jcNT2rfa/fAUiQ4pQyH+Xw6GbeHFcgYCb51hMZs1vIkPLIT1pLHCGplG2HzqApFdUweWE4v4TE07Dw93O9mG4MOIKOKZuOfOpx/GIXEmCbdYDSVX0Sx+foe4+yzkeLLvYQ5YH2nXHSN9ROHB9B2uQfOD6BEKjU02xB2KO6LSRX29Pl7xdu1Ndrj7T5RNt8hdlOy/lUxmtq/B639phvMOiQCGLGhv2nAwaj6qbBO6KwFmNwcTQUIrrBQuLe6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rnJ/DQDfDsULp4IFFfKEI2NOmjKJn4DV1YSEO8GI3c=;
 b=l3N1WdYoz9ECHbNdh3+DFW8M66m6NLWO0niAjkkvP7NeXi2Yqhf6Cs1ylNnok6ibfLt4t/yhSDjPUEt7sHCdQSQhjqoUTU/zNYaB5UuZz8GWQ728k/AlXrPjEeGRFnRq2ZBIgEZMUNO+MjV/+r2u8nClYtCwy39iaswiCCUzWdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 07:22:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 07:22:43 +0000
Message-ID: <5ee27a79-90b7-48ba-9fca-a87705e319d4@amd.com>
Date: Fri, 17 Apr 2026 09:22:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/amdgpu/uvd3.1: Don't validate the firmware when
 already validated
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260416202643.25350-1-timur.kristof@gmail.com>
 <20260416202643.25350-6-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260416202643.25350-6-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e21c06-7f50-485b-1844-08de9c521dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: XNmMT8xPO4qDiH1HI0qP9K8gRM097ohd8u2f09i5x3ZX8IKSaiqSfxjZK+DFrz4inci6L5A7HFOV577ZNcf3BmZfp5A2NprbjOxh+UDTtLVY9Whpl9VeFSFUYKkYC76kp6mwOHxqd/lbNRIffYzicZkAVGV3lT+PV97wWn/OTkSIgYSeWwZN4vsOLGp1NaY+YCObYattwRnoRDOE5ERBXQGELQqtZsbGmf+HkzGMEIGeVNECTUvVv23ztiUtBT1KujMga+eg15i2ORgQEXyvQt1glqgbrN+Gj0xeB7V02/9zn92Bv1YBDanxD9X66oC8HGr6FmPJzcIgwH/gcDLGejzxdbOc69033Mjm+bS7r/yITCNNjZUb2JQjFe+lZ9peXpQrhrMJulYUD7kFA23bcs2EaQ6xLGZC3hnmnYO/0QLLeh8iJ5GtjjKQMtm5o5ywzyCRNkDT9arInyPfraW3E3ag+c5/gOTWGP79CI0X3hX2lYFmqmcuQUgi5w3G9hTALmi3gyp1pIaj+oCImam6+qXSGdTAKztPum6cK8XqAxeKOdSl2V7X6+Pwhwflx3lSBfRIHgfeWeyzvFkqZkMDpxR3e+2NpC4zuL2J12pfW3hTS6TABUw6G0zKGcW/ce1VN0PkEI4dslZcYO64vhPp1krgZJL0J1dLFq4C8GlAR+1CyTqdJuNrXkYCoeeH4cZj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUlnbHF2YWkraW54OFpDTVdrTWMxMjV6REdyZWJVZGpFN2ZxQkhVQTA3MG44?=
 =?utf-8?B?d0QzWmM5MHVMdHpnaC9kakFHbXlNd3Fma0duczg3RnpId0dqWnEwbUUzRUor?=
 =?utf-8?B?MytTMm43N0dVQS95b0FmSVhhcnVpdG9MQXpuOWNYYWRjTE1xbXRBZHRXRm1h?=
 =?utf-8?B?U1l4TXowM1F1dmlibkZRS1ZrNXZhTmxCOExpcFQ2MUROUmxqMjhlVkFrU0Fh?=
 =?utf-8?B?eTBmTmRnSmw5VmVQU0IrM0xvbUFwbDJVc29uRTdwS0d1Q0FLQUE4WXh2enBm?=
 =?utf-8?B?Rk5ibm1wcm9WdXlsU3FHeGNEWHQwRklJcUtVd1dOdDFxbGtlRTRtYUt3WTEr?=
 =?utf-8?B?RG1lOEdpbzdTY2xEelNOdlpXdDVwd3lKTlFSUHdUMUI2RWdUYkhIUCtRT1p2?=
 =?utf-8?B?WWdPMmliTHN4UXpEMEgrNUF0djBNN25RS2pkdFBrOHZpazlESkRyVlpKa1JB?=
 =?utf-8?B?ZitMZXlIMEVNalV0NkprQ0I5endYd1F6NlNVVlZTQTcwL3F0KzVUNTJwSlZM?=
 =?utf-8?B?bmhHaGE3YndNM29DZzczOXZzaDB2UllNZEVmS3kyQ1dtSHZCVG9NOXZUTlhW?=
 =?utf-8?B?a1o3ZTd3U3RjYXNrU0QzeEoxbzdjZnlUbVhySEN3QlBNM05XRXdTY2lnTzA0?=
 =?utf-8?B?Yld1VFBQb0FnckhTeUxQUmJQSXU4LzhSYjBzMkFYRXpZMlhLWkUwa3h3N0c2?=
 =?utf-8?B?Z0hpUVM4OUFVT3VpcTJSU3ZjdWZqdllrQ1ZSQURHb1k2dEo1R0dkci94elBw?=
 =?utf-8?B?LzV6OCtqRVZvRTY3WDU1ZzBSKytIVC84aWxHdFJFOVJvS3NyYmx6ZDEzZWRO?=
 =?utf-8?B?dDdac3Zsa0tBWnA1emIzalFaVGhrMXZZTnVKTHhoU1BqbUhybWVBOXVvSEFP?=
 =?utf-8?B?Sko4K1FuUWc0djQ5Z0orNWM5Z3lmLzVYcWUwREpaNWNIamtwZmRyc0JacmUw?=
 =?utf-8?B?bkVCbWkxSDZ0a0xXNmNiRnZTTWYrL3VEeitIdHUxdUNUdWFzVlJ5SDRIZnFh?=
 =?utf-8?B?NytXT3JET01TN21WMG1ScEs0dnhTdlAxVDBJandGcXZBY29ReXFhdWkrMVdT?=
 =?utf-8?B?Rks4anJkdU5SZ09pLzdaUWNQZitmNllOYk5CTnNHYVZMSjJrZi9aU2xjUjNB?=
 =?utf-8?B?Y3E3amhlSlpmdEo4eEJ3YWttQXlEVDlBeUFNalFORVBvdEhmeVpLUTdERUxS?=
 =?utf-8?B?b01EYnVKOFVGalFKUlRVZ3hBd2RnaFkreUtSemJnTEtUTmFkaWE3WHFET0FH?=
 =?utf-8?B?ODc3UGlhNWw4RGNBR1lQelI2UFJUdy8rWFBiVlhaUDVvWElkNTM1WGlkUWs1?=
 =?utf-8?B?TmplVDVxQWh5MzJja1dsN3R6amlzZ3dmUm9jdnRnektMT1hRWU1mUTFlOWhu?=
 =?utf-8?B?aUVUMFNtSWJtR1lPeGJzekFpSnV6YTJocXlZZ2NHL05kRjBiYXNkZ3Z1VmxF?=
 =?utf-8?B?cXdSYU9oVFVqUTNyZEd3WG9xaDBFK3lsbUNmKzFMdnFiclpTMklmYUFmOXl5?=
 =?utf-8?B?L0JNTzRHRGRVekdHeEFyWUdLSXpQS003Q0lKaTFPTnYzZ294N1pub0NITHVq?=
 =?utf-8?B?dDNJWWdsQ0lTUzZhKzhEK1NscE9FQnVqd3YzVlY5NEtWc0IvRldjVXhvdkFJ?=
 =?utf-8?B?cnRTdk5YMjE1SjhFeHFxT1dlR3BvYnVvRTRKK1psdmJCaDZzOUgvUHN5ejV1?=
 =?utf-8?B?eGpKMkVFSU1pM3VBWm52ZnkxSGJJQ1d2NTlLK1VQZW1CM0tKa2tibnRBRHhk?=
 =?utf-8?B?MENKenVhS3JMUFUwcHB0NnVhUjMzRnU0OWEzaGRBNjJNLzRqVmhLVUpSQmFV?=
 =?utf-8?B?SkJ3NmRWQ3hzUUJ5WlZ0SVFOUWlyeEYycFVvYTFYZCtwZUdPQ0ZVdzhPWGt3?=
 =?utf-8?B?NXRKeS9JS1VUV094V0kvRmQ1MGs1MUM2YXA1RU9XQ1N1UVJOM3ZqL0hBQk1Y?=
 =?utf-8?B?R09UY0NGbWMvYXNyVWd1cjEwM3p3RHJmVjAxMU5Bc1NPQmtHc1V5dG5qd0N0?=
 =?utf-8?B?VzZEaGNyUk5TUmFiZXRKSUxyT2dGajJ2MUc0aWpsdm05MWdieWRXc0Mya0JP?=
 =?utf-8?B?aVY5TmpzU3BLQ3JTSktxblVPVnhpUjFsaENncW9EZHFId2U1ekNqVGp6WXFC?=
 =?utf-8?B?NGRKemgxVXVjUG80cDRYLzFQclNqM2M0bmJmVjB6YzhreWN5YmVONW1wUE9C?=
 =?utf-8?B?SXVTUUtHWDVkZStEN2I3M3FoK21HNUpSY3U3ZjVrTDFjMnliUXdZMVVRNThx?=
 =?utf-8?B?K1luY3ZuTzhKU05wQ2RxUHlPS1VMdjY0dGlrN2diWldUbVlRVkRuWVNZbHp0?=
 =?utf-8?B?QmNvalM0NkxubFhsNk9PVFpyelNZcVhVRVJUZmtYaGI1YXhPWm0zUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e21c06-7f50-485b-1844-08de9c521dea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 07:22:43.7914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l026TWCfqwyFbQqy6L+ColNjV+//tmnrGzTc8++OUNbvM/9nJD4jaH4xPRjDsJmg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
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

On 4/16/26 22:26, Timur Kristóf wrote:
> UVD 3.1 firmware validation seems to always fail after
> attempting it when it had already been validated.
> (This works similarly with the VCE 1.0 as well.)
> 
> Don't attempt repeating the validation when it's already done.
> 
> This caused issues in situations when the system isn't able
> to suspend the GPU properly and so the GPU isn't actually
> powered down. Then amdgpu would fail when calling the IP
> block resume function.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/2887
> Fixes: bb7978111dd3 ("drm/amdgpu: fix SI UVD firmware validate resume fail")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index fea576a7f397f..efb3fde919ee3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -242,6 +242,10 @@ static void uvd_v3_1_mc_resume(struct amdgpu_device *adev)
>  	uint64_t addr;
>  	uint32_t size;
>  
> +	/* When the keyselect is already set, don't perturb it. */
> +	if (RREG32(mmUVD_FW_START))
> +		return;
> +
>  	/* program the VCPU memory controller bits 0-27 */
>  	addr = (adev->uvd.inst->gpu_addr + AMDGPU_UVD_FIRMWARE_OFFSET) >> 3;
>  	size = AMDGPU_UVD_FIRMWARE_SIZE(adev) >> 3;
> @@ -284,6 +288,12 @@ static int uvd_v3_1_fw_validate(struct amdgpu_device *adev)
>  	int i;
>  	uint32_t keysel = adev->uvd.keyselect;
>  
> +	if (RREG32(mmUVD_FW_START) & UVD_FW_STATUS__PASS_MASK) {
> +		dev_dbg(adev->dev, "UVD keyselect already set: 0x%x (on CPU: 0x%x)\n",
> +			RREG32(mmUVD_FW_START), adev->uvd.keyselect);
> +		return 0;
> +	}
> +
>  	WREG32(mmUVD_FW_START, keysel);
>  
>  	for (i = 0; i < 10; ++i) {

