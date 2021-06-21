Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B261C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 12:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F716112D
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 12:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F716112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F86789C09;
	Mon, 21 Jun 2021 12:08:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A4B89C09
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 12:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsUQqqm0Hj7tL8uXa6eiOp6hD3p+QuVblWFh6TCDaVSnCEb3j00CJmDkKX7s1SRb8wa1OTN0lp2T97zIom3qBGG1sF35gc1hMM3GYmZQZTvQQ9ZiCjuz0qZ29wrBazl2jRW/al18WIvkiw0Vjc1lIbXXEIZS8c8vmQDegcMb7nY7gNtQPmuMCt+BJi9t15sSvVP7pSjkem4jbmo3xbR6yhNiA7BYTpBO9r+Vx33fcu7aCe//x2Ga2zAjJyodiepZvdipVJHjN1RhN3FKARql4g17KCalqgVXOq9RMHEe+kt+Us7w8cytCfANE27hqU5cBcyoPGU4q9WMUjzC9aYs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQDObhLyPPNVyN5q96hXeCDRwjvGXwS4VHkcuUyrDf0=;
 b=kBjZIgI4zGU/ETJ96YSCb6Hto6NR+tQ0RcTeRoJ3EDUy6qKZmUsOaZJ1e/DsFSdWJVVcghHl7xJou628ZZheZqTjASCtJXKp8Vluy37MJAEu8YUCeudm9VCSOKgFWDTGA+/h8umCPIqN0aXL/P5qGu7KY0BP5rOaBeuelfv+ono3mtBCuemSiOi0mVYj/OArOzR2yYH113VrTqoNr74Khmmco2gbWkjSNqfEzwmzDPBzlk1DMMCGkjCu8iFYUSO81uicuSVbN8RVU7TsXX76fNFT/O929tBGvZwXxkm4XfVp6P1LasBWPz1M0NCNAvOL2C7wMtBYcgoa1eEWhTypvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQDObhLyPPNVyN5q96hXeCDRwjvGXwS4VHkcuUyrDf0=;
 b=066lvNaxGQb56YQcce7SxRxhErFYG92sPMR0OJWIdOIc2c2YAyHh8junBjaYLocrvuqcWKjFDTNWHy///Ab4YW/yruw+LsNAjfm3UkjRqfOnhbDDKBVlyoRL4aAhmvxe+eAWV/u+aEBohiShTCveZeQjU0HtsWQ+An8VD9XB6Fs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5201.namprd12.prod.outlook.com (2603:10b6:610:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 12:08:07 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 12:08:06 +0000
Subject: Re: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210621070040.494336-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <c4550aab-23b3-fcf9-5fc1-7c129743adb3@amd.com>
Date: Mon, 21 Jun 2021 17:37:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210621070040.494336-1-evan.quan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 12:08:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f63ac2a7-4a99-4565-eac3-08d934ad3a8b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5201ED399D359A35501622DD970A9@CH0PR12MB5201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJJRP0Itc5nfwLte1o/E9zCaTuCIBN06ctDUipN7o7E/LnEom/yCw6oH4HbM/q5H3tEYKBCAdo2zRas8O59QcUJVvDoggDBjk6xqlnjuj6DQHcDEQzFxPQJyTujVMVDNFUkJtNlc07Okg3qaEqWtIfFsw6kpGzWdhSsokjiMhIloMHUvwC+4tmi5XOenfAqmjTlsjxyzAfVJdd8O10JFRY8H+vY9aJjaJX94TOJYK1ES13E/NTqFWrJ7E3yQzZUqa3XD190D9nslyi2vdoDPsrhNKxJ4QBcf0iysOcMyGHpKLpwTrCLaWlot5wbpnIeO9t3NtrYOQxtmAjQQuwQpPT5/B6jF1/hUWNX7xWi47xe+5spEIXtvGj1nYUArghC8W2gndmmMG50NmtlWuNeWnopR+tH02SvT+q4OCrJMX6Gr+48umDvBTWVZP8uGAYNzi1Y2zWjpJAQXdyz7LDAwR8G/r7LAXVtw+eLCnKNhT6xE9F9vGjZe+peiZd+KZT4Y0jvulNV4/l7FrVa5ysNZ5IhPwztvZ9Z7bxFzzeozJRv+SerisQ10Jdhi7rL5WQAMGV6r3baFkBFap+c0MmGMwk2OK1+GSEp6v4jUfS4NANAH2k6hARhggHS/9pObS2N3ONnn9efbNQP3Sva5DnqLzV6HjcwldGOsu8QVuwt32mB4hFlGns0pHCZvAJBsfcDa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(86362001)(31696002)(478600001)(6486002)(4326008)(2906002)(16526019)(5660300002)(38100700002)(186003)(26005)(8936002)(83380400001)(16576012)(316002)(53546011)(36756003)(66556008)(31686004)(8676002)(66476007)(6666004)(66946007)(956004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDU4akhTU0JwdDJKRk1kSnpISXU4MXJYb0I5K3k1aGRmcHhkVzAwWEtCaC96?=
 =?utf-8?B?QWJ2Mk5qb1NjNmFPTmM4ZDhXcXVBOTFtaDBoQ29sSy9iQjZZUTBJa3FoV2wx?=
 =?utf-8?B?cEF2Z1UvajZtVzM3cTYydHA5RjVUenlOVHdwRDVTNnRsUDVJd0hzaEkrWUsx?=
 =?utf-8?B?Q3dOYTF3eGFka2RDbkdLQ1Jtd1BIWVFkbHVJQUFZSFpOaktaREI5b1kyUWFD?=
 =?utf-8?B?dXBmODVOWkUrcXFjcTZIR003THVHTCtJNlcxZHZjYjVyT1hNQ0I5R0FHdVZC?=
 =?utf-8?B?ekhTOTJPbHhTU1hHLzd6SURGSUdYTDNWcWcvalJXbzdacStzd25YcEc0TW9P?=
 =?utf-8?B?aTV6ZkNndzJIN0xQVy9Cb2lBZlp4b1NlQkVKblE4N1VSZ3g0MzF2b3Z2NXlk?=
 =?utf-8?B?bFEvU2Z0OUhIVDdwM080NXRtL2dneUdkUm1uWlUrUFg1SmQ3NU0vaUpxbmtO?=
 =?utf-8?B?clVIQ2d1cnorRVBBdzNSTFpiODFpV281MU9QdCtBcTJiUmFjWFZCQkNpOXBJ?=
 =?utf-8?B?WFdXNGpCejhWNkhFVjZVbFZyY2R6QlBVM3AzL3JIZVdXVUZqVWdzd0VBaTI4?=
 =?utf-8?B?KzV4TUhYOUdXaGQ3ZHFjaFNVZ0RHdm1uenZhcTZWaWx0cTdIUkp3QzJTMXIw?=
 =?utf-8?B?ZEo1czRqTnNLclBIRFlzU3VSd0tPVGwzYkY2dklEam9rUzBRMkxkWVBCekhx?=
 =?utf-8?B?OEVSbTZ5ZVhYYXlaTzUzYzE4T1B4KzNmZWhCOTRlOWlhc2tGb3hEajc5bUx1?=
 =?utf-8?B?dWxTNFlROFlCcjV3NHovd294WDgwSVBjUENTU0pGTkZKNE0yVnAxc2RBOVVp?=
 =?utf-8?B?dTg2UkJrbWZEZEFTM2NzRE5oQmNKMGZZWjFXb3BocnhhdC9CSEcrK3FoZUs0?=
 =?utf-8?B?WldJRWRVWERKYjZyeld5dFdibEdyRTVwWWlDMXF1TUcxR0FhRkYrVjQ4VS9k?=
 =?utf-8?B?by93YmFJbThIQkRwTndqZm9kcURwRkg5WGowVzJjODlaUWdGWDZmRzVyVWFU?=
 =?utf-8?B?V0NnQ0gyYnhLbWtTbTN2cU5yb0dPQ1N2ei9iSmtRSHVwRklWRlBmK091Q1pZ?=
 =?utf-8?B?bU9uUFlRSlg4UlVPZW5mN09NNmhNVFplVTF5VG85Q2lSK3Q3ZHZONWQ5UmhQ?=
 =?utf-8?B?NXBib3JObnBsZHlpaEh6Q3dDR2dSRWdqc0xaa1M4cEhzMXk0a3VFRmMwM2gy?=
 =?utf-8?B?cjZ5TTQyTVV3MWNRQndJM3RSaVpIaGo4eTZWRkZodU41aXd6QUlJR1Iva2pu?=
 =?utf-8?B?YWI3VmFpbElDOHlwQis2WWdKUUdQYXRsUE9RYlVYRkhhUWU3ZHVOUUZSeVMr?=
 =?utf-8?B?SFczSHVQZEhhRy96akN0eDByOTFKeGdIRXZCcFovSXJteitqQ2J5dk1HeUNX?=
 =?utf-8?B?OUpBdjBEdnNHRzUwSWJDaVJqMytSVjY2TWRYZmFNKzVxU3g4aWllK2tHZnhF?=
 =?utf-8?B?Q29ZTlJWeG4rUWM1ZEFmKzEyUWNCVFlPSGc3ektFdExRQ08vWUlJVUZFVFRN?=
 =?utf-8?B?QTAyRzE0VUMxQ2xUT0I4bkhIVkVTTGszWjFJcGk5eDZ3dFlaWGR1ZjRMZWYr?=
 =?utf-8?B?T0JLa3JTZFp6empjWjZjaTNwT1c5RXZ5OGI3Z2h3L0tnNGRHaHVVcEVIellv?=
 =?utf-8?B?SVlQYzNHRU5yUGZOTWZZM1N6bmRPa0ZPK3BzNC96T0xSOG5tVGZLaVBLYTNI?=
 =?utf-8?B?bFB5ZSt5cS9LcnBhRGl4WDJGRVczVktzMVJrRmZEYXVZS3JiOE5PcE1pb1Ny?=
 =?utf-8?Q?gFR67/aStcnKT5g4hdcxnEf+GB2DTo21eZNFkqS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63ac2a7-4a99-4565-eac3-08d934ad3a8b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 12:08:06.7931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAFKWZrxIonioE9pSIloxX0Hu4OR+j9JygkErQkLCkE2y0WWAH/JYOOd8adUQufT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5201
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

One minor comment below, apart from that the series looks good.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 6/21/2021 12:30 PM, Evan Quan wrote:
> Add missing settings for SQC bits. And correct some confusing logics
> around active wgp bitmap calculation.
> 
> Change-Id: If4992e175fd61d5609b00328cbe21f487517d039
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
> V1->V2:
>    - restore correct tcp_harvest setting for NV10 and NV12
>    - move asic type guard upper layer for better readability
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 103 ++++++++++++++-----------
>   1 file changed, 57 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 15ae9e33b925..384b95fbad8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5090,47 +5090,50 @@ static void gfx_v10_0_tcp_harvest(struct amdgpu_device *adev)
>   		4 + /* RMI */
>   		1); /* SQG */
>   
> -	if (adev->asic_type == CHIP_NAVI10 ||
> -	    adev->asic_type == CHIP_NAVI14 ||
> -	    adev->asic_type == CHIP_NAVI12) {
> -		mutex_lock(&adev->grbm_idx_mutex);
> -		for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
> -			for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
> -				gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
> -				wgp_active_bitmap = gfx_v10_0_get_wgp_active_bitmap_per_sh(adev);
> -				/*
> -				 * Set corresponding TCP bits for the inactive WGPs in
> -				 * GCRD_SA_TARGETS_DISABLE
> -				 */
> -				gcrd_targets_disable_tcp = 0;
> -				/* Set TCP & SQC bits in UTCL1_UTCL0_INVREQ_DISABLE */
> -				utcl_invreq_disable = 0;
> -
> -				for (k = 0; k < max_wgp_per_sh; k++) {
> -					if (!(wgp_active_bitmap & (1 << k))) {
> -						gcrd_targets_disable_tcp |= 3 << (2 * k);
> -						utcl_invreq_disable |= (3 << (2 * k)) |
> -							(3 << (2 * (max_wgp_per_sh + k)));
> -					}
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
> +		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
> +			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
> +			wgp_active_bitmap = gfx_v10_0_get_wgp_active_bitmap_per_sh(adev);
> +			/*
> +			 * Set corresponding TCP bits for the inactive WGPs in
> +			 * GCRD_SA_TARGETS_DISABLE
> +			 */
> +			gcrd_targets_disable_tcp = 0;
> +			/* Set TCP & SQC bits in UTCL1_UTCL0_INVREQ_DISABLE */
> +			utcl_invreq_disable = 0;
> +
> +			for (k = 0; k < max_wgp_per_sh; k++) {
> +				if (!(wgp_active_bitmap & (1 << k))) {
> +					gcrd_targets_disable_tcp |= 3 << (2 * k);
> +					gcrd_targets_disable_tcp |= 1 << (k + (max_wgp_per_sh * 2));
> +					utcl_invreq_disable |= (3 << (2 * k)) |
> +						(3 << (2 * (max_wgp_per_sh + k)));
>   				}
> -
> -				tmp = RREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE);
> -				/* only override TCP & SQC bits */
> -				tmp &= 0xffffffff << (4 * max_wgp_per_sh);
> -				tmp |= (utcl_invreq_disable & utcl_invreq_disable_mask);
> -				WREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
> -
> -				tmp = RREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE);
> -				/* only override TCP bits */
> -				tmp &= 0xffffffff << (2 * max_wgp_per_sh);
> -				tmp |= (gcrd_targets_disable_tcp & gcrd_targets_disable_mask);
> -				WREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE, tmp);
>   			}
> -		}
>   
> -		gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> -		mutex_unlock(&adev->grbm_idx_mutex);
> +			tmp = RREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE);
> +			/* only override TCP & SQC bits */
> +			if (adev->asic_type == CHIP_NAVI14)
> +				tmp &= 0xff000000;
> +			else
> +				tmp &=0xfff00000;

For the disable field mask calculation (which is the value that is 
applied finally), there is no ASIC check. The above code may utilize the 
same method as in the original code without ASIC check.

tmp &= 0xffffffff << (4 * max_wgp_per_sh);

Same for below case also - 3*max_wgp_per_sh.

Thanks,
Lijo

> +			tmp |= (utcl_invreq_disable & utcl_invreq_disable_mask);
> +			WREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
> +
> +			tmp = RREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE);
> +			/* only override TCP & SQC bits */
> +			if (adev->asic_type == CHIP_NAVI14)
> +				tmp &= 0xfffc0000;
> +			else
> +				tmp &= 0xffff8000;
> +			tmp |= (gcrd_targets_disable_tcp & gcrd_targets_disable_mask);
> +			WREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE, tmp);
> +		}
>   	}
> +
> +	gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +	mutex_unlock(&adev->grbm_idx_mutex);
>   }
>   
>   static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev)
> @@ -7408,7 +7411,10 @@ static int gfx_v10_0_hw_init(void *handle)
>   	 * init golden registers and rlc resume may override some registers,
>   	 * reconfig them here
>   	 */
> -	gfx_v10_0_tcp_harvest(adev);
> +	if (adev->asic_type == CHIP_NAVI10 ||
> +	    adev->asic_type == CHIP_NAVI14 ||
> +	    adev->asic_type == CHIP_NAVI12)
> +		gfx_v10_0_tcp_harvest(adev);
>   
>   	r = gfx_v10_0_cp_resume(adev);
>   	if (r)
> @@ -9328,17 +9334,22 @@ static void gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *
>   
>   static u32 gfx_v10_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev)
>   {
> -	u32 data, wgp_bitmask;
> -	data = RREG32_SOC15(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
> -	data |= RREG32_SOC15(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG);
> +	u32 disabled_mask =
> +		~amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh >> 1);
> +	u32 efuse_setting = 0;
> +	u32 vbios_setting = 0;
> +
> +	efuse_setting = RREG32_SOC15(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
> +	efuse_setting &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
> +	efuse_setting >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
>   
> -	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
> -	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
> +	vbios_setting = RREG32_SOC15(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG);
> +	vbios_setting &= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
> +	vbios_setting >>= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
>   
> -	wgp_bitmask =
> -		amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh >> 1);
> +	disabled_mask |= efuse_setting | vbios_setting;
>   
> -	return (~data) & wgp_bitmask;
> +	return (~disabled_mask);
>   }
>   
>   static u32 gfx_v10_0_get_cu_active_bitmap_per_sh(struct amdgpu_device *adev)
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
