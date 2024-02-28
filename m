Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E85EC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 11:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ABE010E861;
	Wed, 28 Feb 2024 11:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p7tpm8Bi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 278FC10E754
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 11:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2poz8lK1C8t2mZdKMsfdh/MJxuk7T45cEUPH3TMatrblUNixR8wb9uuF4vMBpGma+BaoQRSz2P0xgXK89bij0otNbe2IO2W24e8RILU/M0XN3tXZ49+/HgBMa123Kz5lVNowR5BYPXk8LjkIcM2AAzgtucW4uPXwMlX45XAoucdA94LcCtQmHw3UyZSTaBUsPOW7SOa/wJ3+NWfn2SXQaXliZVDux1uP48Fa43VKEsFKWNeaHVJPBhlxLZ7QkqCz6a4qPIcBOhegyCACoFk/KAE8LyVOEc3MjsIVHDVe0wKIEfiId0NkeDQyVoiJUvd4hSIm9YTacXoXA9SSGDZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOrcPSUTstrkLEn0LQpruXxejUFEyd83dNZPK6T96xc=;
 b=MpG7zkxsxPlogBtVDG9UZk2Q/prE0jaD4AubEdewXR6OtUu0Y2CVpA2ybL46S6LgTrnSpcJvYfK1vske3wMbGv/JG6buTCFreuePHF37Vt22jA/xbKYls6tFG94w9fsYUHFzAASibpJM/ehQ7V0TRHWW5Zi92BqJTJT6C4tKg+3EhrIZcIe/MT3aDpvuCok3WyBUhk2l/mDcpw3GjZOUGBxk74SzNLBHxf88olOo59+lizbzOtMl240ZLD3dw9pXLXofsmdtjkxrehzFD7YIoN3dbsotEvkf3HY3utZzKeIJPs8KmqD8l5qWWWM/Oqj9BHj2LAiFjQWo8G48ro1C1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOrcPSUTstrkLEn0LQpruXxejUFEyd83dNZPK6T96xc=;
 b=p7tpm8BiXGaPuorpCi/BNrZ0VO2w3aE9MHMUneJlFL1lox1+8bQbud3UsaadRbCrkmkO7/95cQcIq7WjOJTdIPmZjaOCLRCX//nTPYobNEEXL2jIgjDktelaWygEzDsa8OQGTL7/keOVd0h+bhvcbKBlyz765YtvRvhJHD35vzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 11:58:56 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596%6]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:58:56 +0000
Message-ID: <a2e47637-f596-4580-8b86-db95af56e05c@amd.com>
Date: Wed, 28 Feb 2024 17:28:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amgpu: Check return value of
 amdgpu_device_baco_enter/exit
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240228114440.1939084-1-Jun.Ma2@amd.com>
 <20240228114440.1939084-2-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240228114440.1939084-2-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: d25098c1-096d-4c44-cf3e-08dc3854a3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2gCNf+vS1Os/GaayX0qHR3FJUBZlZiuBsXkW7KjLRM2NKOSRHWbeL4C946LGVch+H3mGgxRxIzuO4oNsa0LKoCpAAhbDgzbCUwgaVPNFd0sQfH7GjKqXv44V4PoHL4l6dLFbpstGRZXV9LZyo0hIBTR6sZf8zHv6cf//d1c9JEnacCI1xN5RVYdcdJ7SCXRsF0wgKqoki+cmDLwLxkWRKCYgX1sqPUUDA6OMlAMojrC6DR4cQnzyIinITQUKAbm0JZJgWgAgyMityV6vLMj3UAJ9pSESfJBJR12hMdGttVErxRFldch8t6z4MvIteumGwOOPeetls4WzESV5Y06fIjzB23scod+8K3dErM4NofIA/pDSCl1/latW/4m9OvO426qnnYpLUsAvOG02QG8cBpwQXf2saswHf0KFQd1laaiUY0lXX+Aahvss79snTCBbphIMOKSc/kT21vY7tPJQapAeMF3vwycsadQC/nuuzKkL7K7QZwN8mhwSqv1RKzETSWnbZvXIuI/8RkyfM6JEp+FOI+PDKVkVftAbZmQwLQLt3yFaJrkHld4ifNCn/4EC+RFZcFMcwyM965iEnByj0cTu6mBQoN+iE1KsgIiwm2NLo7aX6qsyMdrbhoJ7ssl9xbaw3RIJ4Dd8ZVEccxLXe1CVCkYJh+nc1peY1G8Zno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVl4b0huYUxmQ0dDZklzVzJKeWxBUGg4a1VVT3JzcXJBOXJEWFRjc0hZVjBH?=
 =?utf-8?B?aXhoUEcrVGhlY2p4RkhRbGdJdnROTTNHYno4MDJubEN2OHNrSHpmYzlMcjBq?=
 =?utf-8?B?dkdNWTZ6bjY4UFlKOXpZWmxMeSsrOVR4enpGKzRGV21tMmVoMng3V1U5enhj?=
 =?utf-8?B?NFhvVnRFVEFlZVIvYlIzM2k0QkV2cWhqc2JVenRVOUF1RHJlRXo3ZXI0a1gy?=
 =?utf-8?B?eFJxc1Q4Z2hxUVlTalNGb1d4VUU1MUVhSEYvRStSVm1QM0ZzZ2NaNkJZUU8v?=
 =?utf-8?B?b1ZTTElsdFhJWDkyWmlNbWNxSlJ6NGdGV284aVVaNzFoc2F2YldpTjVTVlMr?=
 =?utf-8?B?T0E0SjBUK0tFWVRWeGM4SGNVbGF4eXZWV3dnRTZMWWJrbDhDYkgxYlc4MXN5?=
 =?utf-8?B?WlEvY09pZCtxSU1RYldySFQ5Ym9LMlYxUVpTOWtOS3FnR1JUQVZXaG0wSVFE?=
 =?utf-8?B?VENraXZwV2tuamowVWdMRjgrZkJMRkMrb0hEdHkwMjR5eW5RYTZBQTUycGtO?=
 =?utf-8?B?czI0ZHFwSisxblRQQXRzeitWTGZ3RUlBdmxOckdHbnlLSGQ2QUxZWFpZdG9a?=
 =?utf-8?B?Y21uWjlRUDFtTEY0S3NIeFA5RlhHVUswVU5aVCtBajVvdWh6bGcvdlpJQ3Bs?=
 =?utf-8?B?TERBZWlLN21hNGhFcHIwVmVmdmVacjZNV2cvSWdoNjRqMFQwc2Nra2QzVVdl?=
 =?utf-8?B?Qm5ESG01VWd0NGJ1TlZoUWN1eTVzZXFuUlZoZldGNW1wb09zekRwdXE4SVNq?=
 =?utf-8?B?U3IrbVlEQUkwVHMvR1ZjMUZPUlRHVDM2aUdxbW1SMXdrck14bFdaWlVDa3hl?=
 =?utf-8?B?Y3JRQ3Bwd01hQmRZMDNRUkJySVhLYzVtb0ZXLzN0UHhjejkwQ29yOEpZNXFT?=
 =?utf-8?B?NC9pbitDeXRGbkNKT1MxWVV3QWhYb0RLdXVITlRPNENFVGlVQjdqR2dCcFNp?=
 =?utf-8?B?cEJMSmRqVGRvOFFSOGVDN082MDBzZmN0bzNjMWxWdkVyeFJNYUhGcVViTTFG?=
 =?utf-8?B?UEVvcVYzbkJMTEo4TTdZSFRxOVJlSUQxcEtxOHErQnVzMDZwQytLWk1uNTlP?=
 =?utf-8?B?STEzcCtrN3FySm1STXRMdExnUDR5WHJXTm9TS1phRWgrQmRtQkYvd2ttV0Rt?=
 =?utf-8?B?MFFoRXlUdzBxbHdBTE5Ock9vMlRybTBld0pQMms5MFNJUnEvZDh5UTU3c3A4?=
 =?utf-8?B?aHdsUjlRd1hNTnVlb2xqZWRMcVBoUnA1NU9QOUYyUUZwcytPeDhrdy95RjZ4?=
 =?utf-8?B?UDc1bGJQbkR2RHRocU1wUEF5UGxHdktsTjNiREZYZ2N6VDdSRE4zeXlFLzRV?=
 =?utf-8?B?UjJvNnFTcXhGN1NicVV0WkNHTnZlVjlHUFJZMTJVb05nSHNEYytaelhIakNK?=
 =?utf-8?B?TFN4YmhLSUllU1dqSVI2ODZhVDVjbUFMT1huVWFpbVVsZXNrb1R4aVAyeGFm?=
 =?utf-8?B?NmRUNjBSeUpkWUVNSFFRc3RQdlRaQmJxcjk4cEY4Q01RVU96VVoyckxBZUtk?=
 =?utf-8?B?aWx3cUt4RHdkU0dQbGRjd0N5Wm1pakZCWnF4cmQyZHZnSmRqeEdGb2N1dWpq?=
 =?utf-8?B?NmJ5b1Vzdk1KdHEzdDN5M2xSU1NwZDZJNEY3bzRHQ2VoUVU0dm9MR1RWeEww?=
 =?utf-8?B?OEhWZURnbkpyOU0vYVVPZXB3SnlwajV4emRBeEF5a1BiMlpHQXhFaXBTOFNY?=
 =?utf-8?B?Nk9COXdCWEVBbVBVSkswNnRvcFZMd04rbzllekNrTWZwZFJKY3dlUFpZM0I2?=
 =?utf-8?B?aWNyY2lSWnIvbjZoSGh6TnFiUzhGNE1LWnh1ZnFNa3I2TzRha2ZmdFcvdHVQ?=
 =?utf-8?B?cW9nL1lPdU5NeFVQWno1bU1WZmpnZDNQMDFETGJYaGJEcDJzcXNJUzBHVVI0?=
 =?utf-8?B?R3ZxSThZVUphSXcxd04yNG4ydGUwSXBTYUttMTk1Z1A0QWZVOGEyUFNadUl5?=
 =?utf-8?B?a0k5MVVJOGV5cllqM0xoZ2t0dUd3WTdJOVJaS0ZDZFlFeUxHM3U1a3RKd3Bu?=
 =?utf-8?B?NTJnRUpDR25pN3dQZCtIMFNjcXJ2aldjVktJNXpJZFB6WDJhNEtWNTNPM2lO?=
 =?utf-8?B?M2ZhZlRFVDQ0WmpjNlFjS29qLzgzZDVaVksxUnY4cWVaQXcwb3pyM25Pa0Jm?=
 =?utf-8?Q?Br9hnkNhWDS/W1wwLhPwQwDYU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25098c1-096d-4c44-cf3e-08dc3854a3f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:58:56.2670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n86Sr+SsKNOdLIo/KcmvWOAEsP6FG2elfT1MXy4Xt5rKUAc2vgq+7dJl2zd25cxW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
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



On 2/28/2024 5:14 PM, Ma Jun wrote:
> Check return value of amdgpu_device_baco_enter/exit and print
> warning message because these errors may cause runtime resume failure
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 8b83c26dc018..11e089cfb465 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2705,7 +2705,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>  	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
>  		/* nothing to do */
>  	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
> -		amdgpu_device_baco_enter(drm_dev);
> +		ret = amdgpu_device_baco_enter(drm_dev);
> +		if (ret)
> +			dev_warn(&pdev->dev, "warning: device fails to enter baco. ret=%d\n", ret);
>  	}

If the intention is to print for any baco entry/exit failure, it's
better to put the print inside enter/exit functions itself. Also, since
these are triggered through PMFW, any PMFW fail will be printed. So this
may not be that useful.

Thanks,
Lijo

>  
>  	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
> @@ -2745,7 +2747,9 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>  		 */
>  		pci_set_master(pdev);
>  	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
> -		amdgpu_device_baco_exit(drm_dev);
> +		ret = amdgpu_device_baco_exit(drm_dev);
> +		if (ret)
> +			dev_warn(&pdev->dev, "warning: device fails to exit from baco. ret=%d\n", ret);
>  	}
>  	ret = amdgpu_device_resume(drm_dev, false);
>  	if (ret) {
