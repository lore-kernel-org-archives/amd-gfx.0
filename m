Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2DEC11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 16:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6766D613D6
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 16:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6766D613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D176E049;
	Thu,  1 Jul 2021 16:39:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9AD6E049
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 16:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOkX2FDV3yaATtpCLo/Bgx7q1gQ2kVpDLbSReUFbZjStDbGIghdYHiQve27cWsXowromkLlPp5pGJXJlL4XaNE6uaxaZW26S125HD7tqSIaHBYb5u5m9LZo3qLiWYNmSbYYXV5ZT9+gveJ+oEVk7c775t6wiqOa3S4H8KWjNhDNe0ScXXsVwVxktIIZutExe9Xh4cynDuDqUVkaAH/Iftwu1UfhACfZW3l5P3YvDiXb9BA2rx2yCKG06zqIF6/I60rPvSfJ5YvFddJqVkuDxf1b7i9i7FKpg/i+q2FFAQfpua0gmTV1IN7bdVBSttiFWlEuYGBonuWkp3qEmxrCffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFbg/v+xwYLdhI2L5y/3pKOc6GGvb1NW4/Jo0ZGJP9c=;
 b=DZrEllTZSw9tVRFhu+n/6ZdZiAxtv1PmwpumfMMZ/lnZQvGmZmf43j9bTDGolVsWWbmug9yKnoZJhdyHLowu8xkExNnF3YHPNlHDxTzF+/RPMeYx/BbJgLrGw+WqeRF7mRytLp1/tL7mBKaKYdCKyFrD5esl21+lkH2GJGHniJGI+tmY4Y56yeuiS1jvsRXpK+SJ1ppJ/2xTTITYu8DW7VFTcKvgSobBSoLBps38WfMWa8W9WQqvYQ6uSgoRUfi8qoDQtafY9qM4PlzJK2dKmWNVJKDWukhGrrT1u5YP5Kr4ACWNTgd/jb0D1XHv+cEp2/uWS8rrULJm8CyBkvpGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFbg/v+xwYLdhI2L5y/3pKOc6GGvb1NW4/Jo0ZGJP9c=;
 b=pGrKY8bYC8P+h70wzIB8Fwx4iPG4a6ErKCN6iM1Bm+XC5ISsKCuQXYH27wFcR0Bwm+6SRrTvKq2kOIB54k36lGM/unIOX01DXqqGXlOaoa+UTsTj6OVseYlnnTUIj6eGulssFpRNRD04tTCGRzQfFOJcp7i7hJtZF+LkDdWWcvU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 1 Jul
 2021 16:39:47 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 16:39:47 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay (v5)
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210701095705.2133251-1-YuBiao.Wang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <c29a7fb9-b6a3-4351-ce27-95d3252e7dfc@amd.com>
Date: Thu, 1 Jul 2021 12:39:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210701095705.2133251-1-YuBiao.Wang@amd.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::14) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend
 Transport; Thu, 1 Jul 2021 16:39:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e68bfc2-f8ef-404b-af34-08d93caed653
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB317955FF2E0E3F72CC0E370699009@DM6PR12MB3179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Lov4qx6509yeosTh8QRz2p21TnDey9cguT34mYax6w4ducahoW9gpjaD1nF4xEINrerg/AT8vF6CFQjwD3N3IfmClNt5rUsyXlzuqgWfE2XTLSVbQSdJzeQ9kULlhxm6ekfiXdojhCxQ+oKPQ7JA/4dmQYB2IogRlY5gPac8eIfAfFVfinusw4KAeR1Tpr+m5tH2s5DgOjAz5H4brNYrTRVo1O/v4VMI1jJhRhDMTBWbO/xNKLt61YJNcrfDk+YlXLndE80+C+wh0D8gf87/qJPtRuiSK6t/nHouVTWiysrgSb5BN/nY9gyodL/OKSQAAeWxOHI6qbpPMt37WtvPu4pQmLNSYhfyMvUdlL1o+h7ArBf6S9IoDPovu4eBJFlrQbYnlItLC9Oe8ooEKQohhmIMWmvS+8ZZOc1FPqkSBirTv09hZCOsLvjfbetnMpJ+eckJJKgzP6Nv+Mvqnv9RoxeBzZ1YX7IqQ7VFpMiI6MRa3xiFeTyGdhLdzKOkI7EtAGComOfQUSMejeOgnLkd8IyO6HbTdmoGok+oD8S0bnmebcakEPjo7pZi30XHaWL5GRqH+inmNEGXRcHk0CzCJotAuoPj4dIvMENzcjsJM2TObe/WTvidplDkC3V6ExHv986XUBmAlovLS5XoYOq58Xh+BeVWS2nY4QqNnqLeDwUgRxMWagOxtPeeYPeQHP+9p6pCx3dtvqG4RdJVdGHSBURUH1GeapE73yMedhGQQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(38100700002)(956004)(316002)(8936002)(2906002)(36756003)(5660300002)(54906003)(44832011)(2616005)(31696002)(478600001)(66946007)(66556008)(186003)(86362001)(66476007)(83380400001)(26005)(4326008)(6512007)(16526019)(8676002)(55236004)(6506007)(6486002)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJUbzVmYlJlTjNRbGV3NCt3L0NKRk9JdmxYbTVObXFiVVdYb1hCOVYxUzk5?=
 =?utf-8?B?bWhxSHRKRWZXWDRxdXk1eVhRZ0RYUk9CU3hpU3huVGxMclZselFVcjBGY1pj?=
 =?utf-8?B?RnRBTS9XaHlPb05FTzlCL3hmZGNpVlpHdzRxZExGQlJMWTJicnVkL3dtVXRN?=
 =?utf-8?B?elNLZTAvRlFRM0l0SE1JM1QyZVFpN1FJUHZQZzRvZ2J5eDFpOWMxS3lSc3Rv?=
 =?utf-8?B?RGNrRExSUTFmME5FZ2dKMnE3bzdrMGtUR0ZHcytLZEhKVzNIOXdabC8rL3Nu?=
 =?utf-8?B?YVAwNjY0Zlh4UFZ3eHNlM2hxR29sMk5Xc2VuZFlIWU9SSlEyRSs2cmh3Z0hy?=
 =?utf-8?B?S0hoVk1ydjRhMUppalBseE84ZVdsVTQxcnhkck9VUVprK2krR3NhMnJRRmc4?=
 =?utf-8?B?Y3JaLzhZNTRMVmRJUTFUQTJhdHJCMXBGMzU5OWJqQUJNb1NZRXlpSittakx0?=
 =?utf-8?B?Z3RZT05wSCtQNGVVanNickkvanpTc0ZSRXVZT1pzZVd6MnN1TWNSdkwyYmhm?=
 =?utf-8?B?K3hWYlJCMlZVcnB0L1JFSGwvMHRpb2VVcmQ0R3VhNXNPTkI0c2t0QzBkcHVN?=
 =?utf-8?B?ekY1L3hteTZVQ3AvZkliQmVXdFZxeityRGFnMXVaVW12VXZjcnBTSjA1SWFL?=
 =?utf-8?B?a094cW1JRDRGT1FBVUx5VjhkR2RNSG5oY0VBQUVzNzBWR3VZcTFjRk91REMz?=
 =?utf-8?B?dXpzSTNQRUVyd21GSGxRd1JOM1R3Ymdob1B5MGlCU2hNem9md2FSQ3BJemdW?=
 =?utf-8?B?d2ttMEpzM0s0OHVKOEJXSUJCQkdvcUlPcStIbVk1aXFEa1NSUEFtTlZ5YjB6?=
 =?utf-8?B?RTB0aTZocE5jTE1UU1NYNHdHbWlWWHpzaCtuUytxQnMwd2Q3emE4ZUFJOEN3?=
 =?utf-8?B?VzNISXZyMkRpRDNPTzEvUjhpZGVnNisrNTFLYWg5a0VsaTJ3MlZ6LzVtcU9m?=
 =?utf-8?B?SWZxaFBteVk0RHFkS2VJOThRUENkQllpUTk2WVZNdEZmRk5nZVlicjNKQWdi?=
 =?utf-8?B?YXFoMXB1dGRFMGNFVkVvNEdBWDhuYk5VcmEyTms1WGZkVTUxRitYb2ZFaWM1?=
 =?utf-8?B?dm1vSGZKdDBLL3pveDdYdTJWS0d2NkNzSFowSk96aEN2OU10MnB5U205SXdZ?=
 =?utf-8?B?bk5jdHVoNnFzakRHRS9LZW5ZQ205bjFoaklFQW1vcHpmZWhZTGRxc0d6cFRZ?=
 =?utf-8?B?ZEVvZUFlek16eStQY0xVYXRXbzBQWDlweDN2QnU2OW8xMnBUVG5nV2p6ZGFi?=
 =?utf-8?B?WEdCNGFnWi9Ia0J4Ri9jdXpMS09XQlUvdkNpZ2pnTjZJR3J4dXRTN0pEQlFT?=
 =?utf-8?B?VWVock5lZVZWMlh6cVBjMVZOSGlQTkdlclRMNnBzTVdpZnZWOXBFSGFzZWor?=
 =?utf-8?B?cGt5alR6RXkzWk9MRUZMeDl4VmxWWUtzcGx5S1g1cHh2QWYzb0NlNUlIZ2F2?=
 =?utf-8?B?Wis2bXp1Nlc1ZnBkc3FzWkl2QW5HS3VRS1hxR0d3K1R5M2Jvbld6V0FzcS9n?=
 =?utf-8?B?bkwySXR4QmE5YVZCbWY1UTl4Tk1SSUR2UllOdVNoYVUxZ0dIWVRQYTN4K2pr?=
 =?utf-8?B?NFAwd3hxTVJwNWFZekpDQ1d6NWVnOGluaXpMOVJmTThvNDhSbXRHeTJwVWU2?=
 =?utf-8?B?MHN6dU9haGRhU2hDOGdsWkptdC9VR01ZMXdsbWhxb01JTUsxUUg3SFdmMUZv?=
 =?utf-8?B?RmtReGs1RkRpUHgzeFNLYzJzUm80bEQvU3hjYWxraTJKam5RcGZ2bGlRaFAy?=
 =?utf-8?Q?6ZYiebOqihwIsDJTqteJv0Ose1gKS9pWvuYpJG2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e68bfc2-f8ef-404b-af34-08d93caed653
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 16:39:47.0098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AglbZKRoCrGn58KM+TsKYHEKpDKNoGLi4gUj0Hbtb2ODvpMxIms+9xXZ6jPkLPDT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-07-01 5:57 a.m., YuBiao Wang wrote:
> [Why]
> GPU timing counters are read via KIQ under sriov, which will introduce
> a delay.
>
> [How]
> It could be directly read by MMIO.
>
> v2: Add additional check to prevent carryover issue.
> v3: Only check for carryover for once to prevent performance issue.
> v4: Add comments of the rough frequency where carryover happens.
> v5: Remove mutex and gfxoff ctrl unused with current timing registers.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> Acked-by: Horace Chen <horace.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index ff7e9f49040e..5f4eae9c9526 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7609,10 +7609,8 @@ static int gfx_v10_0_soft_reset(void *handle)
>  
>  static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>  {
> -	uint64_t clock;
> +	uint64_t clock, clock_lo, clock_hi, hi_check;
>  
> -	amdgpu_gfx_off_ctrl(adev, false);
> -	mutex_lock(&adev->gfx.gpu_clock_mutex);
>  	switch (adev->asic_type) {
>  	case CHIP_VANGOGH:
>  	case CHIP_YELLOW_CARP:
> @@ -7620,12 +7618,19 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>  			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
>  		break;
>  	default:
> -		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
> -			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
> +		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
> +		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
> +		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
> +		/* The GFX clock frequency is 100MHz, which sets 32-bit carry over
> +		 * roughly every 42 seconds.
> +		 */
> +		if (hi_check != clock_hi) {

Yeah, the comment is so much better now. Good job.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> +			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
> +			clock_hi = hi_check;
> +		}
> +		clock = (uint64_t)clock_lo | ((uint64_t)clock_hi << 32ULL);
>  		break;
>  	}
> -	mutex_unlock(&adev->gfx.gpu_clock_mutex);
> -	amdgpu_gfx_off_ctrl(adev, true);
>  	return clock;
>  }
>  

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
