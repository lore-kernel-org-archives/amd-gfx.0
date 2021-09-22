Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A1CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 16:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFF66103C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 16:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EFF66103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2D86EC47;
	Wed, 22 Sep 2021 16:55:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7306EC48
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 16:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rklw2ct41x31G2CPKTJiv1GRJsCMRMeuZOrWjcSq8rj5W9tAYvqZ5AtrFxk+9VPlEh+n7MN1fF/SklsS+NjksYcmf5w4dXIR4wnp+Sm4ljQyuhQdSBt8aVP1wIGRiwDVHtnHmETbpn7t0OgIyQ8HAoZ7C/CmGlBHsTM15M2ezdjNwdH1Wd4KdBvjqYiBg/xHmdWodsm+sICj7Tv4oTih/qG/d4O5ytsLLu07jKRwSY0TmiiO/xGMSEFaUg/LMILbrVK4sXTju6G9mSqFc/xWcLjatI0QoCtLVscN6AKHhmAg+MIWmJG4ehh8DeIkV2rVM14oUgeo7GR5XgCAilwe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=5FNaKQBPn31rv7R9cc/mJBb4uKJmfW9gaDrzGe0hK38=;
 b=K4tqUSD8OomaExljnn9pN8Qv6gy8AvLJDRYXwKP5Q9mCjhMGbrfBjK8i6v2SZiKPMpjh6WwMAaThaswGu/V3ve7a4E8la8AnZwc4dVToX5xO+eBtP7+y523/buiavnEEsRHT51o5UkUiE01XN1SmZv3LkIkCdXWMnRcG+UwVBxsFTZC+rHWQd9v/FUlDuBzHPnJtWi5chirl3l/TDUsEqpZT5BdXEt/zV8swhOiSf1B09XVXpc8aCBuixxRo/f+ep3JXUH7BNvBfb/BHP1hA8IuvQLVkvy+LdQffAaz0tSmOm/g0VpAnnKDedFdwyJCMpeJCjPNjrjHm6Tgyat9TEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FNaKQBPn31rv7R9cc/mJBb4uKJmfW9gaDrzGe0hK38=;
 b=QEE7/rPNka2FjmVvhY/eg3N1ZvPfhKKirQUl3zMrY4Ni1ru1kBQDNcB0De9yGmZAVe5pS/scN1TnexwCgG+//9Rg3B6DBUXmljgCy1RvTtgC0iRAJ50wq2IuDEIgn6i3sfkdWdUT8Ine6NJopI+4Xwma5AagTxCBsBt/mbVktFQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 16:55:29 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4523.020; Wed, 22 Sep 2021
 16:55:29 +0000
Subject: Re: [PATCH 65/66] drm/amdkfd: convert kfd_device.c to use GC IP
 version
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-66-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <196688af-b98e-3d9a-d33e-8234cde31c72@amd.com>
Date: Wed, 22 Sep 2021 12:55:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210921180725.1985552-66-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::35) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.122.119.142) by
 YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15 via Frontend Transport; Wed, 22 Sep 2021 16:55:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ec61e4f-cba5-4345-046d-08d97de9c86d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB519604F3DF79059036C8273892A29@BN9PR12MB5196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KRJ3g+40tB4AXtPTWoK9bazUov8j8XAztJZeWf4Gd6vrC7HPu/KpA3AwlrUUN4C+RIDp4BDluCk/wIeu/olfR2PXX1W8YorW23IkUNoEhYGmk9q4HWNi57rvgRD8MRkSeiRRuRSxAkxHAk+eD/DPKsvlEZESPlnWP1SWu/bhNiIdyVmm7HmficUC4K/aOuAG4KKXZvltDOGWroOD7s2YVZNnIJOxTnrXIu6Tllws1LTyIVDwK1PdWpP7FBK64gLOxrYEvT9kHlwXIBaJxS6b7JeKKfdJbyMJBBXXJrWnncSkkTILCsQUHFb9pqKgTObBRf6rO/IiKkX5MntavwWgPWb0nSiMyUtTqJV5v3T9+JCUymviqIFgZ2Tgci76Z4qW+Gf7NCBqAx020kgCU4ho3roanP5jX35Gjj2jtzRbTZGzzGqAzk28udnCFpR2IH7WAA+qnXMlib6wE1C84UozE0ed9XGwRonwEmkgx+iu/FPdspapWYCgrGqE0JdqV/m+iNigELj2PuVGlktgBWQzLNvAacBc0w+9iQYaBsPe+sB7m0pjwV+Ub3axMxiVFWKAMZVw7ZhCuuwSB/LXkZjrxEDiSiqXSHCItMAaLR1Ysn/3jWdv4/+fvpIXtl9QSmW2d2xDwO6C+HyWGtIlVr1dq5oeH9yDd60oTyLQXByGt8geF9E4DgtqoLGYIChT1IP6zmvDC7PHY2A0Mq4+ydaT12XxGyS32RxIKlH36kp2KsZdVI7VlDDQ9cA8aPKPoIA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(26005)(31696002)(86362001)(8936002)(36756003)(66476007)(83380400001)(66556008)(5660300002)(508600001)(956004)(2616005)(6486002)(44832011)(38100700002)(8676002)(16576012)(316002)(2906002)(31686004)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkpML3Y5NVdMVE9IbkZQL2gyNUIxbS9nSkpXLzdXU3JGd0F4YzQ4emY3bXVL?=
 =?utf-8?B?c3R0WCtDS0NmRUpPZlN1eFNMa0J2QnFRamhBRmduSUhKbHV6cnlYV0IvT2FQ?=
 =?utf-8?B?cVpuR1ArMmwvYWRhRkpYSUhsQkVJeGY4c2VvTjJmVWJDbkZFRWtWcFYwcUNm?=
 =?utf-8?B?NzVuMkhNaXZEQmcyWUFVaFU5WXE1QUJqOTJMZ0pkZnhIa1NJaFBZcy9ta21E?=
 =?utf-8?B?c2tCVGc3TWQxY2hWVENkdWd0QWZzajgrTVZXT0dHNVhWVlVaY2RxWVVMd2FC?=
 =?utf-8?B?THlOQVcyVzRCbWN3a0lVUkNJYm9nSE9JdkZQamNjSjNLWjZXRVgwclIzbjNy?=
 =?utf-8?B?aVhUSjdWamc0T2dJSFJ5aXZEVU5WS2lyekJkL0t5QmFjeFRXVklBa3ptbjBB?=
 =?utf-8?B?bUEvTUt3bUZlMjUrVzdUSVpod0YydmxRRml4b3FmTmMzQmFuSlpxVHE3elRE?=
 =?utf-8?B?UEFad1d0NWJhYXZKNGRZRGhHanBsVTBBTktnYmtQSlBLNFRMVjY5aTdJS3hT?=
 =?utf-8?B?L0ZNc09GSkh1NEJsOXZ1UWVOZG9oU2JCUDhFTURRSkxHMk9PeVo0SURGYW9r?=
 =?utf-8?B?UURJZVFqS01rMWhPOS8zK2lUSkNqeGg4U3I4dk52STBBTFBBM21DenZHNk9I?=
 =?utf-8?B?T3ZjMDliZU1Oc1dZbUxQY2l5VnBqUzNqUkVlTHFhdVkxWEFtdkVkQ1VvcmUx?=
 =?utf-8?B?S3MxMG8vdDF6OExwcjhQcHdQaUkxbTQxaXd6RktlT3I2K05MSTZVVjFjMUhE?=
 =?utf-8?B?YzE2SHduWHdveE1OeWpuYkZhdzkwRmowQXdnL2VWOFVNTkhZZzEyOFg5bHN0?=
 =?utf-8?B?SjZGN2JWSy9pNjRsUy9qcEE0bzdTZkVmekNiYnRXaHptYktwSi9ySGNJaDZH?=
 =?utf-8?B?UVJkSGVzSzNvelpONkZIdmp3NmV5cG04K3ZQOGFYVnprM1QrSDdtaE0xVmZH?=
 =?utf-8?B?VTQ2RFMwY1BJdzZDb2RsaUhNY04vSXBRdHUvOG9USUt4dEUrekRWQjV1ZGFI?=
 =?utf-8?B?cmExZDh5cy8xay9qSmp1VGZ0d1EzVU5jRHNFcm9WYVBnK0NTUVprVW0wanJK?=
 =?utf-8?B?R094eTJCczhtSFFLNW5zYUV4aHI3VjJHc212QStueUxMOXJYQit1a3k2V2F3?=
 =?utf-8?B?ZER2Z2hnY3hVRnRtbjU2Ty9KdWhnYTZETmVMTUZVOW1LWDdqTVduaEdoYW94?=
 =?utf-8?B?NE5TOW1OOHNNZmk1bzRkY2dnY2h3cndwbCt2YVdsMEh6TE1jMzRzR21uQ3d5?=
 =?utf-8?B?RFhJUFhsdDM3WGFwRWpPOWdoT3JIQUdocEpYVmJzdERtNTYraXMwYnZ5dU1Q?=
 =?utf-8?B?U1gweUpyMENJcC9ORGNCbXAzQWFCU2NWd1QxS3BhQytvNmJIR1lyWnFsYVdh?=
 =?utf-8?B?aTVsSmFMNkJ0dnluUy9CcVhYTGE3TWMxSWlHQzladDBnMmJhL1c0eWZBOU5j?=
 =?utf-8?B?dDJVMis3TlE4cjlwSGprZjJ4MjlSSVNYVkpMeDJZSk5pVVUrMUNUZWdQOXdP?=
 =?utf-8?B?bnZEZEhVVERTLytkdmxCaFE3eVJaUEU0Tk5RTjVRclluV0JvendWamtaZTQy?=
 =?utf-8?B?clRTcllVOXpNaWZYLzJuc1BjSXNLeUt6Y1kzR0dUM0MrL2tVdXJENWowalgx?=
 =?utf-8?B?ajFNc1NQaXcreUo1MitWdG4xdTdFcXhiT3BwS1JNeG91Uk9ua2gzNStCLzJz?=
 =?utf-8?B?bzZNanI3MDF4Z3pqd0Q4RWw3cWdHLy9YeWU1MkxsVCtUU3BXZXlsTDBIb3lT?=
 =?utf-8?Q?MrcRSs6tk85bqANeukirx5Y62DFyvp5gpqX+amE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec61e4f-cba5-4345-046d-08d97de9c86d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 16:55:29.4439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIikgAmdR3EJ3PQjVfgneerqTi2wuUQTYjIwprL2rjWoNDgEiCQhCVJOqFnFyCCtbIFFFYSDVj7+JmEKyYRy2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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

Am 2021-09-21 um 2:07 p.m. schrieb Alex Deucher:
> rather than asic type.

I think this works as a first step. I'd like to clean up KFD and replace
a lot of the asic_family-based conditions with IP-version-based
conditions in a follow-up patch series.

Regards,
  Felix


>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 254 +++++++++++++++++-------
>  1 file changed, 178 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9269b5e3aed1..25614a86b2c9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -53,41 +53,6 @@ extern const struct kfd2kgd_calls aldebaran_kfd2kgd;
>  extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
>  extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
>  
> -static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
> -#ifdef KFD_SUPPORT_IOMMU_V2
> -#ifdef CONFIG_DRM_AMDGPU_CIK
> -	[CHIP_KAVERI] = &gfx_v7_kfd2kgd,
> -#endif
> -	[CHIP_CARRIZO] = &gfx_v8_kfd2kgd,
> -	[CHIP_RAVEN] = &gfx_v9_kfd2kgd,
> -#endif
> -#ifdef CONFIG_DRM_AMDGPU_CIK
> -	[CHIP_HAWAII] = &gfx_v7_kfd2kgd,
> -#endif
> -	[CHIP_TONGA] = &gfx_v8_kfd2kgd,
> -	[CHIP_FIJI] = &gfx_v8_kfd2kgd,
> -	[CHIP_POLARIS10] = &gfx_v8_kfd2kgd,
> -	[CHIP_POLARIS11] = &gfx_v8_kfd2kgd,
> -	[CHIP_POLARIS12] = &gfx_v8_kfd2kgd,
> -	[CHIP_VEGAM] = &gfx_v8_kfd2kgd,
> -	[CHIP_VEGA10] = &gfx_v9_kfd2kgd,
> -	[CHIP_VEGA12] = &gfx_v9_kfd2kgd,
> -	[CHIP_VEGA20] = &gfx_v9_kfd2kgd,
> -	[CHIP_RENOIR] = &gfx_v9_kfd2kgd,
> -	[CHIP_ARCTURUS] = &arcturus_kfd2kgd,
> -	[CHIP_ALDEBARAN] = &aldebaran_kfd2kgd,
> -	[CHIP_NAVI10] = &gfx_v10_kfd2kgd,
> -	[CHIP_NAVI12] = &gfx_v10_kfd2kgd,
> -	[CHIP_NAVI14] = &gfx_v10_kfd2kgd,
> -	[CHIP_SIENNA_CICHLID] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_NAVY_FLOUNDER] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_VANGOGH] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_DIMGREY_CAVEFISH] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_BEIGE_GOBY] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_YELLOW_CARP] = &gfx_v10_3_kfd2kgd,
> -	[CHIP_CYAN_SKILLFISH] = &gfx_v10_kfd2kgd,
> -};
> -
>  #ifdef KFD_SUPPORT_IOMMU_V2
>  static const struct kfd_device_info kaveri_device_info = {
>  	.asic_family = CHIP_KAVERI,
> @@ -654,38 +619,6 @@ static const struct kfd_device_info cyan_skillfish_device_info = {
>  	.num_sdma_queues_per_engine = 8,
>  };
>  
> -/* For each entry, [0] is regular and [1] is virtualisation device. */
> -static const struct kfd_device_info *kfd_supported_devices[][2] = {
> -#ifdef KFD_SUPPORT_IOMMU_V2
> -	[CHIP_KAVERI] = {&kaveri_device_info, NULL},
> -	[CHIP_CARRIZO] = {&carrizo_device_info, NULL},
> -#endif
> -	[CHIP_RAVEN] = {&raven_device_info, NULL},
> -	[CHIP_HAWAII] = {&hawaii_device_info, NULL},
> -	[CHIP_TONGA] = {&tonga_device_info, NULL},
> -	[CHIP_FIJI] = {&fiji_device_info, &fiji_vf_device_info},
> -	[CHIP_POLARIS10] = {&polaris10_device_info, &polaris10_vf_device_info},
> -	[CHIP_POLARIS11] = {&polaris11_device_info, NULL},
> -	[CHIP_POLARIS12] = {&polaris12_device_info, NULL},
> -	[CHIP_VEGAM] = {&vegam_device_info, NULL},
> -	[CHIP_VEGA10] = {&vega10_device_info, &vega10_vf_device_info},
> -	[CHIP_VEGA12] = {&vega12_device_info, NULL},
> -	[CHIP_VEGA20] = {&vega20_device_info, NULL},
> -	[CHIP_RENOIR] = {&renoir_device_info, NULL},
> -	[CHIP_ARCTURUS] = {&arcturus_device_info, &arcturus_device_info},
> -	[CHIP_ALDEBARAN] = {&aldebaran_device_info, &aldebaran_device_info},
> -	[CHIP_NAVI10] = {&navi10_device_info, NULL},
> -	[CHIP_NAVI12] = {&navi12_device_info, &navi12_device_info},
> -	[CHIP_NAVI14] = {&navi14_device_info, NULL},
> -	[CHIP_SIENNA_CICHLID] = {&sienna_cichlid_device_info, &sienna_cichlid_device_info},
> -	[CHIP_NAVY_FLOUNDER] = {&navy_flounder_device_info, &navy_flounder_device_info},
> -	[CHIP_VANGOGH] = {&vangogh_device_info, NULL},
> -	[CHIP_DIMGREY_CAVEFISH] = {&dimgrey_cavefish_device_info, &dimgrey_cavefish_device_info},
> -	[CHIP_BEIGE_GOBY] = {&beige_goby_device_info, &beige_goby_device_info},
> -	[CHIP_YELLOW_CARP] = {&yellow_carp_device_info, NULL},
> -	[CHIP_CYAN_SKILLFISH] = {&cyan_skillfish_device_info, NULL},
> -};
> -
>  static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
>  				unsigned int chunk_size);
>  static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
> @@ -698,21 +631,190 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
>  	const struct kfd_device_info *device_info;
>  	const struct kfd2kgd_calls *f2g;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -	unsigned int asic_type = adev->asic_type;
>  	struct pci_dev *pdev = adev->pdev;
>  
> -	if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void *) * 2)
> -		|| asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
> -		dev_err(kfd_device, "asic_type %d out of range\n", asic_type);
> -		return NULL; /* asic_type out of range */
> +	switch (adev->asic_type) {
> +#ifdef KFD_SUPPORT_IOMMU_V2
> +#ifdef CONFIG_DRM_AMDGPU_CIK
> +	case CHIP_KAVERI:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &kaveri_device_info;
> +		f2g = &gfx_v7_kfd2kgd;
> +		break;
> +#endif
> +	case CHIP_CARRIZO:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &kaveri_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +#endif
> +#ifdef CONFIG_DRM_AMDGPU_CIK
> +	case CHIP_HAWAII:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &hawaii_device_info;
> +		f2g = &gfx_v7_kfd2kgd;
> +		break;
> +#endif
> +	case CHIP_TONGA:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &tonga_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	case CHIP_FIJI:
> +		if (vf)
> +			device_info = &fiji_vf_device_info;
> +		else
> +			device_info = &fiji_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	case CHIP_POLARIS10:
> +		if (vf)
> +			device_info = &polaris10_vf_device_info;
> +		else
> +			device_info = &polaris10_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	case CHIP_POLARIS11:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &polaris11_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	case CHIP_POLARIS12:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &polaris12_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	case CHIP_VEGAM:
> +		if (vf)
> +			device_info = NULL;
> +		else
> +			device_info = &vegam_device_info;
> +		f2g = &gfx_v8_kfd2kgd;
> +		break;
> +	default:
> +		switch (adev->ip_versions[GC_HWIP][0]) {
> +		case IP_VERSION(9, 0, 1):
> +			if (vf)
> +				device_info = &vega10_vf_device_info;
> +			else
> +				device_info = &vega10_device_info;
> +			f2g = &gfx_v9_kfd2kgd;
> +			break;
> +#ifdef KFD_SUPPORT_IOMMU_V2
> +		case IP_VERSION(9, 1, 0):
> +		case IP_VERSION(9, 2, 2):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &raven_device_info;
> +			f2g = &gfx_v9_kfd2kgd;
> +			break;
> +#endif
> +		case IP_VERSION(9, 2, 1):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &vega12_device_info;
> +			f2g = &gfx_v9_kfd2kgd;
> +			break;
> +		case IP_VERSION(9, 3, 0):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &renoir_device_info;
> +			f2g = &gfx_v9_kfd2kgd;
> +			break;
> +		case IP_VERSION(9, 4, 0):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &vega20_device_info;
> +			f2g = &gfx_v9_kfd2kgd;
> +			break;
> +		case IP_VERSION(9, 4, 1):
> +			device_info = &arcturus_device_info;
> +			f2g = &arcturus_kfd2kgd;
> +			break;
> +		case IP_VERSION(9, 4, 2):
> +			device_info = &aldebaran_device_info;
> +			f2g = &aldebaran_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 1, 10):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &navi10_device_info;
> +			f2g = &gfx_v10_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 1, 2):
> +			device_info = &navi12_device_info;
> +			f2g = &gfx_v10_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 1, 1):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &navi14_device_info;
> +			f2g = &gfx_v10_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 1, 3):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &cyan_skillfish_device_info;
> +			f2g = &gfx_v10_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 0):
> +			device_info = &sienna_cichlid_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 2):
> +			device_info = &navy_flounder_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 1):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &vangogh_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 4):
> +			device_info = &dimgrey_cavefish_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 5):
> +			device_info = &beige_goby_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		case IP_VERSION(10, 3, 3):
> +			if (vf)
> +				device_info = NULL;
> +			else
> +				device_info = &yellow_carp_device_info;
> +			f2g = &gfx_v10_3_kfd2kgd;
> +			break;
> +		default:
> +			return NULL;
> +		}
> +		break;
>  	}
>  
> -	device_info = kfd_supported_devices[asic_type][vf];
> -	f2g = kfd2kgd_funcs[asic_type];
> -
>  	if (!device_info || !f2g) {
>  		dev_err(kfd_device, "%s %s not supported in kfd\n",
> -			amdgpu_asic_name[asic_type], vf ? "VF" : "");
> +			amdgpu_asic_name[adev->asic_type], vf ? "VF" : "");
>  		return NULL;
>  	}
>  
