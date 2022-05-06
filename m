Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A562C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 05:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDC110FFC8;
	Fri,  6 May 2022 05:06:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 126B810FFC8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 05:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VznPPH2+e+i7N7S3miOqvr6O8f+7PxN4TnwHhsICm+Ocqy/U2r+IAdzaz0B0qSM+Hj2mjL5aXhXfulomuhsoDq01q6fsfr90qmoKrGeI8o8+m1/lrBfGXeTt+s3ps6Cznpx3bODyXDOTPj7E0dxTALuMdNnwk4/2Mo7f9r15N0y2NyM77BqaeGrQqh5i7qbahtae/r+/xmh2Psom8vq5ImGahsax4OXIpJR8vdAdxyiDwikaPB4dJZ5JX6MPKBNcNUJeXbtvJzp9yRBPT2XM6nDTbtDxgyZDHd37jVm9IQw7IHXow9v/p9+qfJPyr4XeCm69t9gfYSrSuy6HL3kShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DirB1VkR/cPQ6Ew9rSnnldQ/Zuqz3mSE93/RscZZYsQ=;
 b=nZ8zt5EUE/gR0gVXGCsKu0SMXW3RNU/3iTRS8HJi9rmeOWcv3PNPUDENFGFztqQgG01oM67uQRyB1bDrn8ROdGcSOVPfGilN0XtOEeXYXhKrQmZfMz+k2wmF1QyDE9+hAYs6cxyt7acZnuIIJg8Dq5WV35ypsy7SFL8/Fds4CJvNTlQdrGvhaX6Da5yqZNgxmiKABBIRb566Xi/UhUeZC91cgkrzdnPPVvW8wEfiSeD7z0O3hNohR5Bf0ulS23pemqSeYxxpxb+NR/zU2BM2vRxEqJgU5yISGq834OAEBd2JkAUVZoLtnmP4aooMbuDW57TrcSJD1O4zHs65/bUrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DirB1VkR/cPQ6Ew9rSnnldQ/Zuqz3mSE93/RscZZYsQ=;
 b=OK6Ez9Pn75SekZ8sxDx//Ty1cmpfJNCNFiveMcunV+9JIheW4axngjGwyAAYrAvtqmf4VS3iEMvkxabRLRr45f5vW4SdHSp9UyTHh0lBKs+nht2hmU7ORo/xnNG52n6/8AIa/eJN8ivgjEZdJih9QJu8mfSZdh1cR7TzzsTwXf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB4731.namprd12.prod.outlook.com (2603:10b6:5:35::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.18; Fri, 6 May 2022 05:06:54 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::588c:699c:71b:b6f2%6]) with mapi id 15.20.5206.025; Fri, 6 May 2022
 05:06:54 +0000
Message-ID: <b12097c4-d9ff-4074-ace7-bcb567bb7f58@amd.com>
Date: Fri, 6 May 2022 01:06:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/8] drm/amdgpu: support fill mem for LSDMA
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
 <20220505200406.1293467-4-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220505200406.1293467-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::26) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c06cb79-bf25-4283-51c5-08da2f1e3cf7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4731:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47319A50E0C8E1B16EB1EA9699C59@DM6PR12MB4731.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nF2TGA4rNiOcTxTeXHpEL+0k9LY1tkAwW+L+UgV2kaFiFITTNEHpMKlCi5LXL6N1vRhSW313t5megC+uhREP3Bd8tn9xFeZATAsZHYCbPaqtT5lq9eg7cB0gJau0Be1waw/icE9Vaunn4SZ6J7pHfkx/qc9T+8qxLYniyfImYpW3gq3DHF7+phhRKvqN6Buhsl9nu4snKfIPtOk930Sr1WZCnSGov1GgSocDu9jL7vxrggCrJ2NrcBzbRN4lo+2U7DxKOQC747ZFKZI19+mz69LTsRK+dbzK0CUoaIA0rL/RPrSNZDXF3zGks1Q5TSv56QIsKHT5Yfm06mRr+rtSKjJVn0AK321qQjhQqWQzi11tL3alXPSb220CDZ26zDU6rFZHaz3jyT6U9F1LyG3a2QD7D5uT+SPkHkcvVjHrXVO1y0C4jVbs8GasWutWuCz1vo0rdgz8yV+UkB6aUOi9vElfI/1+6Rf1KRRo548d/oqTjGdtdzXfLsQ+F2aUSZnqecH9bQrcBhLY7W9jRY1+p22fIW93Jaf1Pz6ICJR19HapLKwQLTEF9b297xFDClnRLFUoQFe9YNJ8LRP39oPiPwi1slUZTHFybs/GNWV54CduHsF1F2wRgBs+bz462RffJhnyNakQwaOZHLZ+NGrxr2HH6zgUpl8Qujvdx5AB3sb6Kw4QNUFERTBpdp6Bpdq2DuGeOVIuq1w5kowpXERnU2hC9K0F/FdZW8HEXBNjrC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(31696002)(186003)(66476007)(66556008)(2616005)(4326008)(8676002)(66946007)(508600001)(26005)(6506007)(6666004)(6486002)(38100700002)(54906003)(6512007)(316002)(8936002)(53546011)(44832011)(2906002)(36756003)(83380400001)(5660300002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRZY0NkcCtTWjVCekJxUGNSQ2ZkSWxHMW56d055ZnJMYWJJcnZ5MW1INzBP?=
 =?utf-8?B?UWJRM0pOWi9oOGFMVktxZ1EwVTdYRzlMc2x5ZGI4RFRrZzkwQXNTVndTTyta?=
 =?utf-8?B?cXY3WFVOU2VlelFhSUExWE5sZVRMeE8rQVhhSUpyYkZLSER2SUE0dmFhQStV?=
 =?utf-8?B?ZDluY016SXI3a096ZS9jNWNrMFlVN0c0ZGZLUDJhYTc4bW9GTGdoaGZ2QlNQ?=
 =?utf-8?B?ZXdPQ294ZWovM3pTempZbTBFdXVSV1ZpQVJibGcwUDlzb0xiRTdiZEhwQ2ww?=
 =?utf-8?B?RDJTY0RYY1dBWjNwSmxPTDg5Q1lPQzBvSGNsZ2RQRXNLTytJWmdOSkkyNEN0?=
 =?utf-8?B?dGRzaU15MmM3VHQ1MXkxNXQyNjFSYjE1N1ptN3VpSm5URklJRkw5Y2thNzR2?=
 =?utf-8?B?TVJmTmRReGVRZXFzd1BoSGQ3M0RWejc3VUd0U2d0Z0xhdDRIT3BRYVFrRXlD?=
 =?utf-8?B?REQ0RmEra0N4WW1WVWsyMjVkU3R1QW4rS2xVM3k1QkRLd01YL2lrK2luZm9X?=
 =?utf-8?B?L0xSTC9ZK1Y1N3RKQS8yVkQ4c014bHY3aDlCSWVrSEk2NmVMb0hac0JVZWxv?=
 =?utf-8?B?MGhiTUxwcjJ0eUUwMWdtMERkcFNtVm9VUXdkTm8xTjVVY1NaTmlmVG1veHRY?=
 =?utf-8?B?YXFZNEx1b3NjUzNhSmU4KzlMVXlkdXJRbXlBcmgxaHhETGdlVWIvZ2hGbTha?=
 =?utf-8?B?bXFQSjVxS1ZHMzV3SE5oL2toSmpJUG92L0NJRXBqZ0gveUNZZWZENTBIOVZ6?=
 =?utf-8?B?SDVReFpIbFBVR0phZWd3R3RBU3RvNDdobThMcE40cUtGKytYK1JKcGlHdmt2?=
 =?utf-8?B?ZllZajQxZEFFaW5kdEw4dzBrRmF6dVN2OVNONnBZamluSjE3V0dkcG5uQnV5?=
 =?utf-8?B?ZEZSTmFqRkFtZ01EMk5Sc3ZUeDdoeXRKTnJrOGpVMis5OUFnZnhqS1pORVFk?=
 =?utf-8?B?bXRoNFFDSnJNZGR4dTErYXJjMy9FZWdEbHo5V0g1bnowTDh1d1diQVV1dzQ5?=
 =?utf-8?B?eE9UK1laeE94OXdtQ21RdnBIK1dNUGp0R0s5RlJqYmord2NYQTJKTlFvMTJH?=
 =?utf-8?B?WmJRTlNsRW5nd0FqWDdKUGNSajNnSzVhZTUxSDNxZnVMR3VXZTFBOG1CbTZq?=
 =?utf-8?B?MGJTTmJHM00wL2pjdnVRMkgxU0pjVzhzUTdRaktHVFpHZHFLZktZcmZQUExG?=
 =?utf-8?B?ZUtIckFOM3BSZ2h4cnZ1SWZHaTFTOFZGbjRrRHc5bFloUE8xdGpla0RiekRE?=
 =?utf-8?B?Y0JMT1ZoVlBWVVAxNkpBbzNySGZqZ2ZSRXo3Wi9VVzFBSnNGdEtCejJvR0NI?=
 =?utf-8?B?VlMxdCtVUlUyMWpzdGFkT2dMU0FnWmFNVE51anRpam5wcHNteWJMb0pBVkZ6?=
 =?utf-8?B?U2V3b2tTcEdLVjZScGJZQVA5dmd1RTR5bmFSS2tqR2ZnaTZpN3JRRXpUUVo5?=
 =?utf-8?B?L0NLOHp3d0hNY2RxUERjUlhvakk1U2p2Y2d2NUhPSW9lSnJmWktTcFpBN1NK?=
 =?utf-8?B?c2FqSVBOV25HZHVsbTI1L2xPWFVFM1UzVkIxRW5VckRnekVjZ2lweVp6VjEv?=
 =?utf-8?B?djdVOS9aRGVGem5ZZ2JZcU83TGQ1UTZPRHVhU0xCTS9xczhacHNJOWJEL1Jq?=
 =?utf-8?B?T2ErbTFTYzRwZHJneU0vc2lGOXd1K0VPTFdMYUJYLzJXbm50MmZCVUxZMThW?=
 =?utf-8?B?aVczOVhZTUVsNDhUMEI3N0JrNTk0UXBvUDJ3SXhFS0dCdzZoZ3F1dnNYSjFt?=
 =?utf-8?B?SGFEclpyWFhud3p5NDdPTDczQ2FVTHhhZGQ2RkZBL1NldnNQTVhPTExQWjJU?=
 =?utf-8?B?WGgyckl4UDdkcTBpVzlKWDgycTV1a1BDZFR4UnhXSW4zeHUvNlh3aUxnRFVL?=
 =?utf-8?B?MGZwRzJEUUQzcFFiTkV4WlE2UkljL0NlYzhuVE9KUS9hQjJVb0hzKzRCaEYv?=
 =?utf-8?B?aDlIbmo5U2IvNnFPNktTOVFxSEl1emQ5Z2F3b2ZzRGUvV09jNHROcGFrbGVx?=
 =?utf-8?B?c3B0QlV6NmRRYWhnTFBEbzBCRCtzNW1hQ1NFVHZQUXZGNFlBNUZRbU8rditS?=
 =?utf-8?B?RUk5SDQrN29Yc1dCQXNFdkMrMkFMTVM5SjlyMGFJSU1ReFNRUjdvSFRPYlhP?=
 =?utf-8?B?cVM4MVZEUkwvOEFMUVpWVnRTSmdhVUxuaWFrZUd1Rk9GZjlNY2tMY20zMnls?=
 =?utf-8?B?N0lldHlFS0xyNGtjUzBwei9vZEtHRTIvcHFNVW9Yd3pUbVM1VWMwZDV4OHhj?=
 =?utf-8?B?bnpYbzIzMld3Zm5ZbWJDSFQ3YzVtZ2FsRUI5di80SjJ3R284ejlTRno0d29F?=
 =?utf-8?B?L3J5cEVUQm1uUlMvd3FLMlVvTGJLYU1EbkFCanprMk90YVJXRWQrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c06cb79-bf25-4283-51c5-08da2f1e3cf7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 05:06:54.6274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKcM8oRd6ChN9HdjE8Ezrl3DLFayMledNMIFtKCTySjHqcv5g5mcFi4M+Cy7pIwX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4731
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
Cc: Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-05-05 16:04, Alex Deucher wrote:
> From: Likun Gao <Likun.Gao@amd.com>
> 
> Support constant data filling in PIO mode for LSDMA.
> 
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c | 40 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h |  6 +++
>  drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c   | 62 +++++++++++++++++------
>  3 files changed, 92 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> index 3f1c674afe41..223c47d1cc1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> @@ -26,6 +26,23 @@
>  
>  #define AMDGPU_LSDMA_MAX_SIZE	0x2000000ULL
>  
> +int amdgpu_lsdma_wait_for(struct amdgpu_device *adev,
> +			  uint32_t reg_index, uint32_t reg_val,
> +			  uint32_t mask)
> +{
> +	uint32_t val;
> +	int i;
> +
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		val = RREG32(reg_index);
> +		if ((val & mask) == reg_val)
> +			return 0;
> +		udelay(1);
> +	}
> +
> +	return -ETIME;
> +}
> +
>  int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev,
>  			  uint64_t src_addr,
>  			  uint64_t dst_addr,
> @@ -49,3 +66,26 @@ int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev,
>  
>  	return 0;
>  }
> +
> +int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
> +			  uint64_t dst_addr,
> +			  uint32_t data,
> +			  uint64_t mem_size)
> +{
> +	int ret;
> +
> +	if (mem_size == 0)
> +		return -EINVAL;
> +
> +	while(mem_size > 0) {

checkpatch.pl complains here for style.

> +		uint64_t current_fill_size = min(mem_size, AMDGPU_LSDMA_MAX_SIZE);
> +
> +		ret = adev->lsdma.funcs->fill_mem(adev, dst_addr, data, current_fill_size);
> +		if (ret)
> +			return ret;
> +		dst_addr += current_fill_size;
> +		mem_size -= current_fill_size;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> index be397666e4c1..9a29f18407b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> @@ -32,9 +32,15 @@ struct amdgpu_lsdma_funcs
>  {
>  	int (*copy_mem)(struct amdgpu_device *adev, uint64_t src_addr,
>                      uint64_t dst_addr, uint64_t size);
> +	int (*fill_mem)(struct amdgpu_device *adev, uint64_t dst_addr,
> +                    uint32_t data, uint64_t size);
>  };
>  
>  int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev, uint64_t src_addr,
>                            uint64_t dst_addr, uint64_t mem_size);
> +int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
> +                          uint32_t data, uint64_t mem_size);
> +int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
> +                          uint32_t reg_val, uint32_t mask);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> index 0d2bdd04bd76..b4adb94a080b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> @@ -29,14 +29,20 @@
>  #include "lsdma/lsdma_6_0_0_offset.h"
>  #include "lsdma/lsdma_6_0_0_sh_mask.h"
>  
> +static int lsdma_v6_0_wait_pio_status(struct amdgpu_device *adev)
> +{
> +	return amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
> +			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
> +			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);
> +}
> +
>  static int lsdma_v6_0_copy_mem(struct amdgpu_device *adev,
>  			       uint64_t src_addr,
>  			       uint64_t dst_addr,
>  			       uint64_t size)
>  {
> -	uint32_t usec_timeout = 5000;  /* wait for 5ms */
> -	uint32_t tmp, expect_val;
> -	int i;
> +	int ret;
> +	uint32_t tmp;
>  
>  	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_LO, lower_32_bits(src_addr));
>  	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_HI, upper_32_bits(src_addr));
> @@ -56,22 +62,46 @@ static int lsdma_v6_0_copy_mem(struct amdgpu_device *adev,
>  	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 0);
>  	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
>  
> -	expect_val = LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK;
> -	for (i = 0; i < usec_timeout; i++) {
> -		tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
> -		if ((tmp & expect_val) == expect_val)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i >= usec_timeout) {
> +	ret = lsdma_v6_0_wait_pio_status(adev);

Similarly here. Shouldn't we wait a minimum command completion time
before starting to (immediatly) poll? (perhaps not, but I've not seen the HW
spec, if it is specified a minimum command wating time before polling
for compeltion (whose poll time interval would be different (smaller)).

> +	if (ret)
>  		dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
> -		return -ETIMEDOUT;
> -	}
>  
> -	return 0;
> +	return ret;
> +}
> +
> +static int lsdma_v6_0_fill_mem(struct amdgpu_device *adev,
> +			       uint64_t dst_addr,
> +			       uint32_t data,
> +			       uint64_t size)
> +{
> +	int ret;
> +	uint32_t tmp;
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONSTFILL_DATA, data);
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(dst_addr));
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(dst_addr));
> +
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
> +
> +	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
> +	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 1);
> +	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
> +
> +	ret = lsdma_v6_0_wait_pio_status(adev);
> +	if (ret)
> +		dev_err(adev->dev, "LSDMA PIO failed to fill memory!\n");
> +
> +	return ret;
>  }
>  
>  const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
> -	.copy_mem = lsdma_v6_0_copy_mem
> +	.copy_mem = lsdma_v6_0_copy_mem,
> +	.fill_mem = lsdma_v6_0_fill_mem
>  };

Regards,
-- 
Luben
