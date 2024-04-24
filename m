Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9637C10F15
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 18:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8E5113D28;
	Wed, 24 Apr 2024 18:22:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="katlT6AW";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5B2113D29
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 18:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItNYLNekkMD0XcOXBBujS3sKPfnpkbu7X4XQT6d0JWuVbwxq5EDmPkYksVufZNBtYgq4HrSI/Ip0xMpM0rQDdZS2WwPD2EnWALQdJHH/zKw/g7kzjlx3cBBD9kFM9EqlY2Pu0vZMOv6/cmlA9SlhdTVNu61zQc22zIK0VAhCtC4PQO0QsYGnUVDFpSM0x5fu5ykREbcFQM7wB73SARdixnFoJPIiCmm6vGqEtBAP4+dEgTQiK+GutEayge22jHsOwkBw/RdPOhyyRGPMGxP9cViiCtnxerYBQcTyAoZ0/VwIx7ciRb2DyQ/9kpBywIYTG/OAL95sFMGNOI5jpgGNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm9OKCVcasvlojbuucrJGlACVxCOL4C3tFlUrXa+Xr0=;
 b=NkraUelHuyA+z01HdtG2W/5TpeFFfzMue9XFE4GrnpKjZtOV2dLN67BlQAVcxo7H7yKguBe/hB6Cwq0/QDuLalPNELNdkSflISb+VbDfjsCFMpFVSi/Jv3WPENnVtaq6ZfXGGzLwTtXTFi3TRc0SNDdaR7x+Yjo54hmw+tXTiINrJbiTXDGZb5i4q0+zk8Et24T8V3qs57z2SCk0qFim8OfIZXg6A7qlKi2Dc9jWYMSRMqnOubtRflehJyTlmk84PRbX6mTRfkjX/LMUAldOv4zhCvKC4qrD6wDMTZTgg7RtiwquI7FV15f9GWh0M8YkRPjOIRgjRCtm4JMFb96PgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm9OKCVcasvlojbuucrJGlACVxCOL4C3tFlUrXa+Xr0=;
 b=katlT6AWdqqIn+GiLqvu52q82kudCUyJEVo1nCfeDveZwHDKIoMW6ZaEeU7CPDSLYEtxwuzAoRwUz1QotE4wjZs6gtq6Ngd2Bk/EVgBwdTyeLMdtz8o9JDjaPy5uWZlZ9Y4+03x3I5GVGiHLQcnh5JOQxTEc61VdPTnKdwK5cSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 18:21:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.023; Wed, 24 Apr 2024
 18:21:55 +0000
Message-ID: <13109200-1dd4-49b2-9615-476ec05ac827@amd.com>
Date: Wed, 24 Apr 2024 14:21:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Enforce queue BO's adev
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240424174038.840827-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240424174038.840827-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 9501acc2-c90f-4094-ad59-08dc648b6bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmdReTNEM1ZrSGNmQ2p6NEpUbURHa1V3MmhXTWJBMXpZaFpEeWp4Nm9yaUtr?=
 =?utf-8?B?T3RVdTkvVE1SWWt1STFsRGdlV2ovUUQ1bi9mTFBrNityRUpuWDAxM1R2c0JW?=
 =?utf-8?B?MVoxT0tqQzN2ekl3N2l3RWIzNmJWbmJmMXlWVmVsY2ZFUEdJeG1kc1BxK2du?=
 =?utf-8?B?NGF5dWlnU0U4c1dTYk5VVlVvTXFFZTVHeCtIUVR3d2NUSWRwYzRzbjFWSW5x?=
 =?utf-8?B?cksyeTk1Wnh0cngxMUdHWU0rSm1mR3EzMHVIWGxRMFFnMjA3Uk8zWmQ2YUN6?=
 =?utf-8?B?c1BuWjVGUmR4d0tXekV1bTlsQXNvdCtOV3YvOTZSM0l5M1dwY3dic1ZqUytI?=
 =?utf-8?B?eDNrNTMwM2hqY2JOT1VGeWozK2lMWjFSa2loejhXTStzMlpUODM3dVNCYmpN?=
 =?utf-8?B?WGxJeTNVWW0xajlIWGRRVEFwZnYyY0xqc1RXOUpHM0dITzNjelkwTkNJME1s?=
 =?utf-8?B?NWsyc29BSmZuaml5SHJ3MksxZEIrcHVORm44ZWp1NWtzdCtCN2QyeU1qc1hs?=
 =?utf-8?B?aHJmRElocXpRRFFoK1R3QTk4MXo2R3FmcWlvY0QyODRabkRiMFRmODZGSkdw?=
 =?utf-8?B?MS9yT1hXZlFXanJwb1YrMDd4VTRuSFlKZFNLMndhMDhYeEhpck9ES0xkaldi?=
 =?utf-8?B?dHkrTVA5cTVOSFNoUWRwUUVKaExyQ0JLRUZMQ3ZyOHJDdms3NHBNN1hkTCtS?=
 =?utf-8?B?VVRIRmlFcFJnUzVZY1FxWlBKTU42NDJveEk1NVN4aTdzMitFa3l6Z24wMkVm?=
 =?utf-8?B?dU1RcU54MzJrS2Z1VjI2dkpqNFYvQnBaRUtqei9tc1dYVm9wVjg1KzBqQ0F3?=
 =?utf-8?B?RHovWEljTE10T21Uc092cUFWbmJZTFpLQjV3UERaRUxTZ0RhTlI2ZUdpcnJP?=
 =?utf-8?B?TDJOYjN3ZTNSTjJST242U09Yd01DVC95SW1tNTMvem9jb1lXMWhRdm10M29Y?=
 =?utf-8?B?UW54dk9RZ2F4Vlg4bUFwYWpJRlBrbVhVSy84MlQvdHliMnQzV05kekN3enpC?=
 =?utf-8?B?S0tDcXgvYWR1allFZGhBRlhJb3dwZmpXWUIvZGlDNG9NRmI3UU1RL2xXZDAv?=
 =?utf-8?B?Syt2ckt3Vm1ZL3NTNHpkNEdDbncrZFliVXVORlBKTEQwUHdsczhWd3JOVnFs?=
 =?utf-8?B?RnY0REFiU0J3VFNqMHlFNTVzNjRWYzlpMjM0VzlPaFJyWGIrL0JLMDRlanBE?=
 =?utf-8?B?Rm5QU3JVeUN0bFA1WlRYenJjYzllMlJaOU5QNGd6VFpvSXNDK2V4aG9ya2hB?=
 =?utf-8?B?TU14d0crNGI1RDV1aHFZanU1Vmg4djRSU0o2ZU5kQ0ZVbHJORXUxamZlVWVN?=
 =?utf-8?B?cUtiSXlzRWJacjd0QUlzRVFOU1BpMS9tc0hLSlJ6R2hJQlFxcHFBeXBmVkt6?=
 =?utf-8?B?RG9KYzl5dkxPejZjbDgwNUhNeWpzSFdUeEQ1WEdZU2VSVStNekJ5NGVuWFV4?=
 =?utf-8?B?bmNjblhhT2NUOGxIclpjT3NGUnEyMEJhdTlSR08vT3ZORWdyQ1dzTXozS2Ir?=
 =?utf-8?B?dHIzR1dkZFQ3ZHlsVTZxK3k1WjQ3TXE0V2NOeVN4R3FCeTViMlNXOGszcUNv?=
 =?utf-8?B?aUlHK3lvcEJVMzVGSnRCSmFLcHRBaWdWVmhxYnI1YXprK2p0V205NTU5QkNS?=
 =?utf-8?B?cmZOMDJIK3B2bFZhcUlaQ0hKZEVWWHpSQkNmdFhsQWtCMzQ3M3AzVk1iL1p5?=
 =?utf-8?B?MjJHYUp1eWtkdGI0TGI2YUpiN1dGZFJOQldDWG9rWXVrbDdudXVIQ0ZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmZ5Y294LzdZRXhIdjhFZFVTaytsQnNnMG44dVdLL3hqMjI2akVYUzZTWHkz?=
 =?utf-8?B?eWVZYjkyVFZ4bUVHOEpGZ2VraEVJS2FCTGlFOHV5ODY5RGRpOTI5RGYvdlZa?=
 =?utf-8?B?bUpNajJyUjNkcE4xQWxMRUFXcTlzU0RvMFJVMGg4R2cwV2JpN2IxNTBhbk5z?=
 =?utf-8?B?bklPeEdCd3JMTjMwc3dySEptbkdCYnB1bGJQVmM5OWhHVVUvdlhsaGR0dmY5?=
 =?utf-8?B?Z0I5ZGlSR3VLcWplOXcyZXBWcGhkWTFlUmRvOGo1Wk9BbE8yOEFIRVlMZWk4?=
 =?utf-8?B?bDI1ak9xNUU3M1d0V0krbW5jYStJU2thVXdVTk5RTW1XL0xwRFBxWlNhRkZh?=
 =?utf-8?B?WHhyUVRXdWRTenNZOHNpWlIyRWw1WWtUV3JvMFhWZXdvejd2eG5oUEJBMGFF?=
 =?utf-8?B?WmhpZFpESFUvYzNNU0MzSUpsbHlDS0UwdXdQa2E3VnU1Qkw2NDVvWVVwbGYx?=
 =?utf-8?B?SEJrckhudUlodVY5RzBzVkF2cGNjdmoweGdVQ2ptK1dmVFk3TG5nZ0UzODlY?=
 =?utf-8?B?aXh0ZDNVT05XMXd6NnhFaTduSElsTDgvcU1zTHd1b2N1Zjd5SCtpVW0ybEtQ?=
 =?utf-8?B?Q0hKQVFWbkpRVE1iRTVyeFprK0M1Y2NZcEtucXFxeWhENlhaS1FMNW4rYXgy?=
 =?utf-8?B?V0ptKzVQQVBFb2k4OFpNSFFBV0c2aUJPZkM0QjRWQkVnSTlRRWtGcUdtWmRh?=
 =?utf-8?B?M1R2aXFCR1BIRnNlK2NkMEhsbnRqdzhnZlBqM0dkek9KZUNITjdWWkxIWnlH?=
 =?utf-8?B?QXRuLzMyVUJhZTI0ZWlaVHN5WnNMNW5NVWRNTUp0bWVPenI4Mmp3UTl0Y1NM?=
 =?utf-8?B?OWRWUUthTFZsVXJuTnBWZjVDTDZHMGNIUmpZcGdaUnFpc1NoNUVkdjd1cm5V?=
 =?utf-8?B?T3RVTmZmMkVScWZGSnhkWFBVV0dqdmMzajNWVkNaU0pkNmtQR1RKYzBSU01y?=
 =?utf-8?B?bXdoYXlBWG9SSkR6UlhLVmZPZjZOWE5sWmtVZnExM09ldDBNaWh4TExnbjBE?=
 =?utf-8?B?cWdJK0hmSkJ1dHEzcnFDdmFvSytUOVhpTmpORXFrdHJ6NFpIL1hjM01Ma3NK?=
 =?utf-8?B?eWlycGs0YThxRk9KRVNuSFNqSEJpWkloUklubjhJeEVuK3U5REVvSGlMQTFz?=
 =?utf-8?B?M3ZWL3Y3TDRFV0x2Uld0VnRWZVFobXZrc2NvOU9acGZDVUJlVytKSTNVVW1R?=
 =?utf-8?B?aFJQMGNWODFRKzZRRVJzaWVybVRzOExGUHJjeEVxSGd5cFlKeUdjMy9yZzRi?=
 =?utf-8?B?Y1pVdzY1NkFsMzZhNXdWblRlSHlLbWt0aXltZHYyL0pSMy9hV0FvSU8waW9v?=
 =?utf-8?B?VXoyQkVpODB4WTlza0ZqRGxzYTlJM3o5YlgrS3FMcXVINFFoREJuK2VRRlhr?=
 =?utf-8?B?N1FqTXlpWTIxU0xrT2o5RjZENUExU3puOEdxcDdSSHZtRWtNbVhCWUFSYzhB?=
 =?utf-8?B?YjJqZkt0ZFVwcmZCZTVjM0RDSG1MTVpaemVmalg2dHVDeFFwNmkyVis4dm1n?=
 =?utf-8?B?MXZSZlpoWDdxYkRBZUh4YjZDd0FWOVdDTU5sSUxvcWo3c1lEMVBpckdQK3ho?=
 =?utf-8?B?RUxTVUF5Q2RZZndTWjMxKzF3aDU1dlozbGh4ejZ1bmNUQi9kMk1OT3hDaUho?=
 =?utf-8?B?bm8zMmxUNDQvZWwxZ1FEL3hOU3QzTjZrQ2U1R3g2bTFCMHU3Z1NTVVZlUDBs?=
 =?utf-8?B?WmtJZHdwNU9LWGtubTFhRWlhK094SkdlbVJPUmxRWDRhWERyQWo4ZVZaZy9p?=
 =?utf-8?B?TXp2b3RMb2ZCa2FoYkJPeWVuNFh4ZHIwY01QSGpJWWFMYWNqdUFicXNwbkxH?=
 =?utf-8?B?VjhVU2RPZWZJWXgxcmNFZ1dVRWxHYUptK05HQlFzSjgvdW9kUnFWZERKL0hZ?=
 =?utf-8?B?QmJIOGprV0dEcVZ3TDVKUGVGbWpwdVNIbTNZNWhxdzI1R2hTMHdZdE9SMDA2?=
 =?utf-8?B?NmNBc0dqWHJ1di9JWnhHQVhrRnNLUVZhWU5aOTFFNDJUSXc1NnhEOUp5TVQ3?=
 =?utf-8?B?YmxGdDVlaERTY3FIeWRHZDgyT254dmFCWU95dWdJb25mVlhGaEU5VVFmZlkv?=
 =?utf-8?B?NEVGeWtoVCttbkY3RVVSWXlEZnFJZy9Tcy9SR2tsRlJrOFNxVVRNeEQ1Vm5Y?=
 =?utf-8?Q?BkJsH8cbbagmC2zKzi0zZ9WqQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9501acc2-c90f-4094-ad59-08dc648b6bd3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 18:21:55.3420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuopPuoPTBsU4DvwCPfq5l8wDPPtntq/srrCCReDPq5RQydz5FV4nDCOH/neK20BqCHih13lHnBLBF0G/bl+aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
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

On 2024-04-24 13:40, Harish Kasiviswanathan wrote:
> Queue buffer, though it is in system memory, has to be created using the
> correct amdgpu device. Enforce this as the BO needs to mapped to the
> GART for MES Hardware scheduler to access it.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

I guess this doesn't break existing user mode. It only makes it fail in 
a more obvious way. If that's the case, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 8fd5e0da628c..963cf6d657cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -373,6 +373,11 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   			err = -EINVAL;
>   			goto err_wptr_map_gart;
>   		}
> +		if (dev->adev != amdgpu_ttm_adev(wptr_bo->tbo.bdev)) {
> +			pr_err("Queue memory allocated to wrong device\n");
> +			err = -EINVAL;
> +			goto err_wptr_map_gart;
> +		}
>   
>   		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
>   		if (err) {
