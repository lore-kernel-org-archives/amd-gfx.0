Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F1C11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 10:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055186140A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 10:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055186140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06116E072;
	Thu,  1 Jul 2021 10:50:56 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958CE6E072
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 10:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMc0O/NaNA0CQ1BmAS6u7QYXFfKb1+uLRnN9u4CsV0GVaeEJrNQbvytyYNTPq7DI7IgoSPbjEvfw08uRHwAzbllByssavM8qSEoeux/lQeQWMA+1y64dmiksdPfGXsD1uUSD7z0OiZZYanJ/W/buWtRIFcVu8IgR9cTdg/VmrMbzCFbEvEuZrHjvHTl1lxKC21PciprbtMA8Bqky/IlUK+XrOKWNabaN/emHGiPg0kBAG1M+5pCvrNGY8wbksd0/4kOe2Ne/1dA840Qu2lWFThfOzfc+ru/dEAW4pexKC/YIiySntdxqG1K8iA3KyfadlUBrao6jlunNoDs+nn11WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r18p/w+5aKFn8ol9/pai0WvQ2z3tqwhAVYkHmcR19LA=;
 b=hTsVfmZADMBy4S9ufk5blrQINyEKoq7v1Gx3/EGrZwPIR//D2fgYK7RzrVStESKeyPjJvoXaqHuWdd59PeOhQVHnD3VdsWTWc3XQit//1Qr++ddFXK3cwk/DHWRSBvDtqIMLqOw0eslZFvBF/FmDGetKqPZtC/Ct7c5lv4JgugDpQunTSr6nRgmlcN+tL2SOHPwD3lWIqPESPPpk/xRxtDlX/gV8aEj6qDNueKG/QcZxbPHJlAlBq2uo01HaADMNn8lOLKhDMFbXoE5GGI7LArzTa6S/g6qi1u78+cgglrO1kfjE1go+nnvUGm/OXCLzgff770L3ISVcfwLs1pPZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r18p/w+5aKFn8ol9/pai0WvQ2z3tqwhAVYkHmcR19LA=;
 b=iVArLrSZYLdHz5erzwUgACCJXJGdnkqiSXn9czPd7Nt9eXnBk1SY5pNX36ae5NpIh3OId+kff6eiuzRKWiAj+eJtXnNqul906dfVEex5YEkop5MN7j8D3Zk/ileRYBkcryKJeB5YxiltrFI3KRHe64W/SBWQXdQvTRk7dloXjVw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5044.namprd12.prod.outlook.com (2603:10b6:610:e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Thu, 1 Jul
 2021 10:50:53 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%7]) with mapi id 15.20.4287.022; Thu, 1 Jul 2021
 10:50:53 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay (v5)
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210701095705.2133251-1-YuBiao.Wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <44aff9d6-e3cd-e1a2-984d-791c2b24518c@amd.com>
Date: Thu, 1 Jul 2021 16:20:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210701095705.2133251-1-YuBiao.Wang@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 10:50:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19232d03-9540-4fb2-b798-08d93c7e18f5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5044:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5044601C74E3515E13D9150897009@CH0PR12MB5044.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzvpQfOSeyrU7Y8BkO91iIqIhl7IUOk8Q9hvDzfi1yOykpYIgSO+xgpgLVv2v2dkfZYwDUgd/TjPjLwABSrc9ltWq5xxgEUyXF63YhjwXInSLckwddNCSatB+lKmF/LK9p4w4icmuxFHhUSkMSL/VKfioTTRFeMOcSoFmU+Xmzp5hMc3+G28NShUhviIHqrGUZv3leSytDE5V6Zw0yaFmRmrBJtkovu0CY4skTfXlsVCmvijJcoPd7k09qtQBQF1puLJIQY1bqHLZ81teLlnqoDHJcXfCD501yr5pBRqQq1O/Q4YNTkknfWyn6tzyz4WNvcCdHG5Vsp5BvcILSomWZdef0B/AWce5EWLAlZklswiP1sGA272SN+GLR8wTyuHYKU+9cbmAA74/b8xeSMQqu1t3oD/1kWUSDlCnpzzUEMlv/9A1XQpTUcnTRMOdUczjGeogT721VJyaheBDbaXKWFjlybRmr0YUHCWjm4bXZrGk1xtgtcxjfI5a8V0J8OFndPFH98iIhes8AZZmNP01OMC8NUtnbx0a0nCHB2xaQ78m/FvL0zZS5KH+zatdDwcm8ZUqd7XVbHxWEuBOixhXBBXCorVgxiazXGuizjYRgok32go/RY4kFGeNdzn8hFNRBbhtP4MnuZoOuOQex6/h1awcF0jy++3540mVEI3JrbvY9wzaJOp7/NScBFmStLVI3K1uZ6LScdCLHOWan0zea6BHW3nRvi8uGzgUxbN5BU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(66946007)(956004)(66556008)(16526019)(66476007)(478600001)(38100700002)(8936002)(6486002)(186003)(26005)(31696002)(6666004)(8676002)(2616005)(36756003)(4326008)(83380400001)(53546011)(316002)(2906002)(5660300002)(16576012)(86362001)(31686004)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXdDMWxKYTNSWWxJb3MxWFZyZ0hwOG5ZOXJyc0R6QjA1TnpncWlCUVlBc3JN?=
 =?utf-8?B?YkJrMG9Rb0x0UzdLaHZxY25vVjk5SnFYWHBhUWNmekJJK2svSG9TUnFmOHhm?=
 =?utf-8?B?SWw3aWd4OVpPcnYzRTFhaE9pb1RWRkxVTUNQR21HS1NrSHVoN0syVDR2REZ4?=
 =?utf-8?B?TXMyUU9TUmFMMVh5cjJ4anQzS3NDZ0lyYlRrWTdYZGxKVGx1QmJyWlpoRWEx?=
 =?utf-8?B?dDdGeEVQeitFQUt3Y05HWGgvb2tMbVlRQXNMaEU1RHZLRWhhUkozVmJKT0Nz?=
 =?utf-8?B?dSsvVlprSDJLbUI3a1o5OE5oZVZseFpIeC9wK2FkM0FCL01XNENnRUNuVlpL?=
 =?utf-8?B?TTRaUTJlSG1Oa2tKZDNJejNqak53YkhQdVFCaEt3RGVBc1JqcDQ3ZDdsR2pK?=
 =?utf-8?B?UzhZdHpiNWpZQ2xxcnBrSmIxMjZUZVBSYU03Zkw5S0djZTNZYkdNQ1JQZmt6?=
 =?utf-8?B?RGN6OHBOZi94bGt4L0pwY3F0M2JIK0NxM1hTYnNnd284M1NBVUNwelVWdU4z?=
 =?utf-8?B?ZElxNTZ6L0t2L3VRV0dUOUwrU0dOa0hSbzJkYURVZDJKRHRkZFlsbkZISlRI?=
 =?utf-8?B?b3VTNTZZSG1FMGU3QmhPc1haWThwWnl2Rlh3ZTRMUENQWjZmamRWdUl2QVI1?=
 =?utf-8?B?c3ROUkR4SEVhNnpOWmhnYmJiY1Y2aXJuMVI3ODV4MnM3Q3FOOGoyTG8wOWdG?=
 =?utf-8?B?VldiTkIvK0VrOGdKRWtmR01pUzh2MWFuWWZNbi9nQksxMmgvWUNaL01zcUI3?=
 =?utf-8?B?QkdPYkdqQmdRZS9rUStvK3lSNDhMa0pCWmQ2YTZjbkxlYTlDY3lmWVh5VXVi?=
 =?utf-8?B?SUlhZ0MwbVNIcHpPYUZnVlFoQWtqWXBzbW1VT0p1QTdKSU11aGMra1pyem04?=
 =?utf-8?B?L0tRMHNHMy9QV1RJVzFWZ0FucnJjeWRtYzZvODRLb2N3V3luWjFuaFhBbjBL?=
 =?utf-8?B?dTZWWFdja0FHUE5ZMXRKeHRjZWVPLzRSSGU5NXRyNzFWWStaQ3duYlZodmFG?=
 =?utf-8?B?ZlZJZVYvbGFuakhOSnpvV0VsRWRpK2dHQ1czcEVFMWhlUFQwYjhwY3JkSy8y?=
 =?utf-8?B?Q0ZSOUlZdng3VkNxUWRQQXFUM3dUV3h3cFJQenU2Mk81UHg0M2tyZmlHOFlB?=
 =?utf-8?B?REhWeVhaNWlqTG5SZVFYTzAzT1g1YnhKRGNQRHJVemlsdTg4RVp6bmFaTjJi?=
 =?utf-8?B?c21xYytCbG5YQTRHOGlMOUtnSk5xVEZoZmRGc2V0NTdnRXdjVWRRY2lOZFRO?=
 =?utf-8?B?UGRKblYvMksvUlZldHB5STdKZGJhWktJcDV2cGJJUHRwb25XZ2JidStRV1po?=
 =?utf-8?B?aEFwY0FKamk3MXhkWDI3Tkh4SEdrZzRxVnB2bUtnYjNCRWIrVGxZSEtEWnRm?=
 =?utf-8?B?YnBEeFg4bFVCV0FYcXgrbnBlN1c5OFgwcUptU0FyT1pKV0pRRnN1N3RNS0dj?=
 =?utf-8?B?VTVxbDFmMWhGenFNdWJSSWlaQ2E0NkFPQVp2R01aQklyUDh0L3JhM1JQeW1I?=
 =?utf-8?B?cHdDMHo0VThZaEdueTJRNFVlTVd1ZUNvQ2FVZ1UxYnNHZGhyc3BEa1g1dUw1?=
 =?utf-8?B?L1Jaa0E5SGFmTWozUityaGdHb3J5bStSWURrTDlZUUVQK0ZBMFFtSDVQUU01?=
 =?utf-8?B?YWFTclFsOVc5RXVXV1duTmpqY00rdW5tb1htMytNN0dEVUFaSFpsekZ3YjNK?=
 =?utf-8?B?OVBwZ0VjMGh2MGw0NGI1cmgvMi9aS0Y4UXByNFNpeWVZejhJSHZKMEZuV0lz?=
 =?utf-8?Q?kH/dzxjOs7OMgUzfp582Mv7d17Ar2/lUbVpQr8J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19232d03-9540-4fb2-b798-08d93c7e18f5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 10:50:53.3630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wciy5/+59WkMF22wSzTSFCt7RR8YV7uUDIA8iRp5PPiH+XNiUlomBaOVeziD1s1N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5044
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
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A few comments to take care of before submitting the changes.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 7/1/2021 3:27 PM, YuBiao Wang wrote:
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
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index ff7e9f49040e..5f4eae9c9526 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7609,10 +7609,8 @@ static int gfx_v10_0_soft_reset(void *handle)
>   
>   static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>   {
> -	uint64_t clock;
> +	uint64_t clock, clock_lo, clock_hi, hi_check;
>   
> -	amdgpu_gfx_off_ctrl(adev, false);
> -	mutex_lock(&adev->gfx.gpu_clock_mutex);
>   	switch (adev->asic_type) {
>   	case CHIP_VANGOGH:
>   	case CHIP_YELLOW_CARP:
> @@ -7620,12 +7618,19 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>   			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
>   		break;
>   	default:
> -		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
> -			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
> +		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
> +		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
> +		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
> +		/* The GFX clock frequency is 100MHz, which sets 32-bit carry over
> +		 * roughly every 42 seconds.
> +		 */

SMUIO TSC is not ticking based on GFX clock frequency, it's running at a 
fixed SMUIO TSC Clock frequency which is 100MHz (second part is right).

Replace GFX Clock with SMUIO TSC Clock.

> +		if (hi_check != clock_hi) {
> +			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
> +			clock_hi = hi_check;
> +		}
> +		clock = (uint64_t)clock_lo | ((uint64_t)clock_hi << 32ULL);

These types are already uint64_t and looks cleaner without the cast.

Thanks,
Lijo

>   		break;
>   	}
> -	mutex_unlock(&adev->gfx.gpu_clock_mutex);
> -	amdgpu_gfx_off_ctrl(adev, true);
>   	return clock;
>   }
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
