Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFC0C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 16:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B03BF10EE18;
	Fri,  7 Apr 2023 16:55:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E51110EE18
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 16:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUQBr2sikieuIHSSjb5nNczFSArc7noZ7fFBfmUFOxdkDMisNAMf73j5vuUBxJ58F+3esQbc9DDJtvuD11pdz0I5hVvoqSsppSUSRgx2NGYrdM2BqbdMLJk+XI/zt2FOooeGdGj3q0eWzKT9WL86VSFZZJQQ6Y0E/qgHinoFLNIobnqghudcUB19tTjSaEGiSLNSTC3X8ZDH2xCBF/Q76rNt+VewSlzPVmp1gahO/vJRfAE1Nr0ABRKKVuQn7vplXatov21tH2OkIgwIYZMM7PB1OFtzobyiTsRYtGA04HWys6ivSCZu07mpr/oQIx4I7u+VBI9db55KVLsy1lMAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVXZlLdjkLK2DLsDPpoEak3lc6tI0L2JMonHc4uRBnU=;
 b=S3ddgsCBArj6r6fw9meM4NA6+zv0tQy30MDSsZhnsknr2UXHWZ+dgSN8QFYwrI2qizo/g+pzYwiDvbPs4+jtXN5FU72g2yHgfteGTHluvKWSnNuK+KZR6En1D9yA+bq5MJNRe52BRQeJeT+PNmdEFdPaC5i3VWqk/qlpGwlnGm0QYGBGWrn5dfiEzHUJ1EJ/agoNP/FlzlL/wYkmOyfKN2/MpnM79fF2hXhN13zKrtU94U6/PRKndLAVxamTJURJdsFh45psZGsjGwGR9YEGMP7I9KTYZoB/mB3au8x8xNQzM2qxgBQZ3HeobhPhG71RwbaTwUTj+MEQ2R+E37d9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVXZlLdjkLK2DLsDPpoEak3lc6tI0L2JMonHc4uRBnU=;
 b=RVKyGhMpv/526pKNpoWC3tqh1iiLjCspPPvzGB1XiodzuDaK24mvR/7JqvnwOQW0tYrxp0bwv4Lxwd3Y1oKEBAe4VD5cZB+IWeHZtHcQcT5mr3+HLOcs1vALb1f7P5YQTkzTHeEXpoewZhugsaL5tup2m/sUl48lwu5ldDnbH/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Fri, 7 Apr 2023 16:55:54 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 16:55:54 +0000
Message-ID: <84100ef9-a098-b5b2-fbd6-22df2f1015da@amd.com>
Date: Fri, 7 Apr 2023 12:55:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdgpu: refine get gpu clock counter method
Content-Language: en-CA
To: Tong Liu01 <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230406101327.28310-1-Tong.Liu01@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230406101327.28310-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1P288CA0013.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::26)
 To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: a9477e55-edac-47c7-4688-08db3788f334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khDFjaa79k9PI0eAbHrxxblhsrXiVsXIZl/PopvT/2K/ltyar0WHs1OVVfAWyNwlPlyvfRKybfi/xeFX9PdV/irm8wVwmHrfH07Xyj0lw4CDMaGVQk821ZM065GM2azOCmTVNd0haq3kCYFtY0qrLy7uHTxhG2sYay7O63BcRzT0xhX3PB8uRmZQ6B9ThGv6gIUsaJ77m2JomIjWTzfqsGQMiJq7msB3LHt9DT44kUDk/nlxQlL4x127V+q/18t876eShSmljwzUpIcI/8BfdmLfr+L94E9pQIt4spLOmoAA0q95U/dufn6CjVILab+yE6bjimdZX7WovhoQDWpnVFsHDHXPkW50X2is9NG7Sy+SsLOGfH3tbhVJRMzZOTp9rJPCvxsvp8B6a56XUMY1Tq6SIg0CLAeZKRz90sfk1w09Qtf2CHi1omFi67azVefKMQJMPS4KH4ot4wQzucpnGreaqMnDhCIClBgNQ6azEHt3eqHbElolYpq9WIcISx7/RrzNR6u3MlR7fZ5DvwXfKzEWDA5ZUBg0gr1z2JvoleXjMJBlL3YVaQQSaFqvp6jfaaGLHTqvYi+hbZNJ0MLc4AhCavuZ/0lI7vclRsehCqYD9Gba2Vraio4KE06KvesBeWaCDS6Hg8UC78Sa7p0FDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(6486002)(2906002)(478600001)(83380400001)(31686004)(6506007)(54906003)(41300700001)(6512007)(86362001)(186003)(8936002)(6666004)(26005)(53546011)(5660300002)(2616005)(316002)(8676002)(4326008)(44832011)(66556008)(66946007)(66476007)(38100700002)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHBtMisxdG1DQzdHaFhzcUJyU25wemp1d2ZiakhDZTcySXd0QUxUU29tSHJK?=
 =?utf-8?B?VHRrWHU5RHhUMzZnbS94WXZSdDF2R0d0ZGIrb2hwSHNEcjg5cWM3OVMvWDkr?=
 =?utf-8?B?L2RQL3U5cjNtUWJodkpPTThyVE44bUNISXhxTytkRmE0dVovU2pYdjdXQ1Ex?=
 =?utf-8?B?Vk9VU2N6czNicXF0YnJQRXZIb1NmRmQyUDVoVWFVTUlnMjFVSHY0RkJtcnRV?=
 =?utf-8?B?UzVpTFZ4OTVKcFUvdzdQYUVESU9hbDJEQ1BaRGlnTDc1cFN5YlZMUUVHKzdq?=
 =?utf-8?B?dW5Da3M1L1FJWm1kR21mT3VqNEd0eXFDUXZBR3U2Z051Wk5zWjNOd1BaRDhl?=
 =?utf-8?B?RkpBRDIrNVV2eW05Zkh3RlNBYU9vTk9sakxZeWJLR1BSOEdaU3R4MHFMYXpB?=
 =?utf-8?B?Qk9Lc0xqM1ljTTg2eGhPNmt5V211WllXNWRIelFxcDljOGQyN1I0dVNQM0FZ?=
 =?utf-8?B?THF0UzRuSDA3MThUdEpMbml0WUFoNkxzNWpYOURHVVZ6OGV1dnduV21QSWhJ?=
 =?utf-8?B?bUpTUVhlWFF0akRCVDg5ZHdYZUsvUm50cVQ4enBaM2hkVUdTN1llM1lVMUJJ?=
 =?utf-8?B?U0d0aVVybFp4cVI2NG1FSnRKeGx5NW1nUEJxdGRtRXk4WG5zSkFLQnBOOUk1?=
 =?utf-8?B?Rk4vL2daN1l1V2xjZHllNDc0VGtzVCtLRklYZy9IRnZSS29oUUNORzg2blph?=
 =?utf-8?B?aFJneDlSUXRMZ1NmaFh6Tm5zWFpmNW5vQk4zV3k1UlJqVWRQYmk3elVtQ1o1?=
 =?utf-8?B?clltcCthOTJkREVRMXQ5dTh1aEtDZG1LeFJKaUwwaGV4NDk4ZnpKemdJV054?=
 =?utf-8?B?Q3N2L0k3YldFeklaMXlCUlcvQWpHbUtYZkYwZGtmSFdveWx6d1RHQ2YvUGhk?=
 =?utf-8?B?akpmQlhIdThBMk5hYzVXWnhGUndEN3lXZG1CTHNKazNXRjRpdzMzQm5kNkoz?=
 =?utf-8?B?cjRIMWtqam9EYW9CUjl1ajFvLzFFRkNUV3ZlYThmakU1SFE2WjJMZS9vQTRp?=
 =?utf-8?B?RnA0YVlseG13OURWS1F1bnlENVNDM1cxeDJxNXVDaUViRnZIZ2psdEhGcVlZ?=
 =?utf-8?B?VFUwRWRIT2pOR0gxaG1iWVIyTVE4MnNrOG80b2puSHp4UFJSc2lGRFVFZEZy?=
 =?utf-8?B?Y3VsK2VCY245bHk5ckl1N1pQT0x3aXluMWpxMFhoNTRnYTA0Wm1GUXZ6K3I0?=
 =?utf-8?B?WmpSdmNrbGxTVUR1Szkrcis3L3FVbXUrSm80dFRjdGlUT1QwOW5xL3pmQ2Fz?=
 =?utf-8?B?bUV0OFYzRHpNT2NOdVJ4NkJHc3g2RVFrRGplYkhQcmxlRVpvT2xLdzBNN1J2?=
 =?utf-8?B?bWFiQStibkRnbzRxb3BRbWJzT1Bva1JFWisvZHN3MktKWTg0ME5pMXJ2aEF3?=
 =?utf-8?B?cXF3WGZkcDFLMVF3c3BTZGNONk5zaWlybXo1RUpHODEraFNWZUJmeWIyRVkr?=
 =?utf-8?B?bEZWVmNuSE4rNFlDaWFHVDFEMFBDVVFFSFdBMlJnRU1Nd25oZ0Y3Q2V2TkdK?=
 =?utf-8?B?MHhKd1pJZXU2d0xZblgyTkI2WlBSVFY2M29VM3hYeE5oWGhrUU5aUXhvb0lW?=
 =?utf-8?B?VGpkVFRVR3Q3UTVnRlBmOExzS2JyTkt3RmVhS3JxNCtzTm9qdUsxaDJqNDFT?=
 =?utf-8?B?bHU4MjdsRlJYRUlMVFpESVRMbFpNdjlLRXlZUVZWbUV5Y1pGR3JGdStpMzlq?=
 =?utf-8?B?eU0xSVhqN1ZHalljZjA5MmFKL0RnS0QrS09TQ3NMY3M1MXdrVmJ5ZHVEUnF0?=
 =?utf-8?B?cWVPenF0RDdRSmxZL1pGVnB0N2hFR1RLelB3dkhkendhZEhqbnFpRVZnM0ZY?=
 =?utf-8?B?aDBiaDVZbC9MRTY4ZFp4bXJxQ0tHSVVkRTIyTzNtUXE2dlJseXRFeVJSU0hW?=
 =?utf-8?B?TkRpK2lteFJPSDlBSzB6bFhlaEJaeWREMDJHRGVPYW1ITjdLNmplZ240MElX?=
 =?utf-8?B?WHBpbmNZem5aR0pJNG54K05IZUxNSzNhckpSNlF3S0dSMUw3UHVOMFdYS3hw?=
 =?utf-8?B?ZkFwenhoS3ZOZEJxby9qamZpbTd0QWFYQ2syaDN2ejJBbUQzTXJFUU1QSXor?=
 =?utf-8?B?TXFIaEFobW85SmRMZ2orc0JpKzdFQlYxclU5N1piWXZrVmk1NUNTZXFHbld2?=
 =?utf-8?Q?wM1IZOdIBTb3C8T/J3NaRyNfs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9477e55-edac-47c7-4688-08db3788f334
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 16:55:54.1170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SSQc+9j5KExLAcq7gro7vN93sLKDzz5h6xYV2x46tqXLm9L08PBTil/WYeXHGon
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>, haijun.chang@amd.com,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-04-06 06:13, Tong Liu01 wrote:
> [why]
> regGOLDEN_TSC_COUNT_LOWER/regGOLDEN_TSC_COUNT_UPPER are protected and
> unaccessible under sriov.
> The clock counter high bit may update during reading process.
> 
> [How]
> Replace regGOLDEN_TSC_COUNT_LOWER/regGOLDEN_TSC_COUNT_UPPER with
> regCP_MES_MTIME_LO/regCP_MES_MTIME_HI to get gpu clock under sriov.
> Refine get gpu clock counter method to make the result more precise.
> 
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index ecf8ceb53311..107c487c0c37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4671,11 +4671,24 @@ static int gfx_v11_0_post_soft_reset(void *handle)
>  static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>  {
>  	uint64_t clock;
> +	uint64_t clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
>  
>  	amdgpu_gfx_off_ctrl(adev, false);
>  	mutex_lock(&adev->gfx.gpu_clock_mutex);
> -	clock = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER) |
> -		((uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER) << 32ULL);
> +	if (amdgpu_sriov_vf(adev)) {
> +		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
> +		clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
> +		clock_counter_hi_after = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
> +		if (clock_counter_hi_pre != clock_counter_hi_after)
> +			clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
> +	} else {
> +		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
> +		clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
> +		clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
> +		if (clock_counter_hi_pre != clock_counter_hi_after)
> +			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
> +	}
> +	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
>  	mutex_unlock(&adev->gfx.gpu_clock_mutex);
>  	amdgpu_gfx_off_ctrl(adev, true);
>  	return clock;

