Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94B3C77B76
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 21:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E81610E304;
	Fri, 21 Apr 2023 21:03:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BCA10E304
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 21:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYI7fOzv4AacykUt/g8E1YVzqELs/ozqWLm5ToyW7RYvGMGXOm+E7cMs2C21IaSDJfMLdqvB1gY0BUNjup3nK+XifIwtSYpUKbssa2TQ5oCaiqb4fApGwzasNOpDtmcDSwHJQS7nFoF0NW8io/5iTWTnkjJnWD/8BjNQ8Ghm9snXGe/dIvnyeoKCoBwTvOpjWfX2LId+ZTH7hCOL6eKPHsJJ8V9UYoT/bSlrDCN2OWwgbo10HhEkAFCofCkfVKgJAOyPwo2ZLbubcrYyhHkbLopl1Kayq8wC+1ssKPrNa9Sg7QeEMPDX4x57Tkhuz8JMoxR9iCbwGjuN+lIowp6owQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U2xkNl+avkb0MzCXjxCLrEiUdGmdXam6MESPIA20ZQ=;
 b=aWvkhVO2a09hET6mKFuJu3QkfVWyS7MYFKisqZQLcBlRSuW/EIyxZkKLCTmEurWTDDQstrkPu6rQSzv7WxrmjFBdholcggpUKrCDJZtbQi8ImHDKWd65KQT+ljhSWrUFvDF6y7apYd9V/mhIGY3HX5CWNxTKdgXkx4uKfXg+bqjVU2kIvY/GVwSb6OO9QCZ0zC4cUKyLoJDwaAZkxAu8xkAc5HdHtFM8eRM9ZFmh1q45Xv0T3VgsptjTV34gTk9JmQiCOAuO1CrJffWsBnAlWPBj0Ai/bAdUIPnn1SWYKGsb0bHBkzNB5S7pHDFLEtCuoNzaFavZHm/hrG4D4OOxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U2xkNl+avkb0MzCXjxCLrEiUdGmdXam6MESPIA20ZQ=;
 b=ZQWv0Sa12EbltLxE5Vap2idNK3Jsy6RXvnuiG2Purf4YZahUcxRp+mypWuiaP1fn9DKfu/yXWspDAH9+3bcberW4DXwS/4+pdASKerjtTK4yF1i9yfzFaBGntqsHSkYGDdPvYe2Ay3w9N5s4od5Y9Dm0a9h6JO/bUAzl1b5+DjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 21:03:11 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9e8b:6bfe:350b:99ad]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9e8b:6bfe:350b:99ad%6]) with mapi id 15.20.6298.045; Fri, 21 Apr 2023
 21:03:11 +0000
Message-ID: <0019ff23-9ba7-6826-69c7-a19be2351fd6@amd.com>
Date: Fri, 21 Apr 2023 15:03:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] Revert "drm/amd/display: disable SubVP + DRR to
 prevent underflow"
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230421203933.1085320-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230421203933.1085320-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:208:a8::15) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 873e8846-802f-46d8-96c3-08db42abd088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwkRQhz1A8PzvRi7ue3FgmVFaWO35UR4rcsaRfH/wnefYJVGRChq4K9qKsDpYQCmcdVzXzV4myKlGzzG06VUhIYGq1xqcqWeAL1ZVSNKjBh8+t5B6rS7sTPDb4vmlbV4mnMzbVnIIinSV1Qzdg//jYD82TfURYU0keqVhKZ8t9lQaAtTr7ezheqSanox9MI+nw3otKp7lu5bfvzRIUYsEe2rhug5oLqIwbNtYvotohLMt77BKE87dvYpWWZgDZieGX0e0gU1JZ2+05MEc67BhC8kCABhAFXZD8PwbDWPog+o7FrwOsFvBopY/Lq03WTg26V4Nd+vTKqPniXRxq7bn7j9u9bpuuWSrFBHYdOg/krLleaG7sG6bQHV4IWFGFfdvwAxux13wp7x2mcYOe+Zb8cva8SYJzm72dX5TkRg4/Bqxko7a81NlLevIjzPrG1pCc1CAAKN2RYW+hHaaQ+acOVIrCgkHoWMSLMeMtSqgCwdUyndkwu+XdWXVOkkh1l4zMKSqWofQTb1hyXlxMxBczPAje3JhD+2W0SuBDLnstibqTAayVztGcFIqoDg4QfzneG86YBYTnt0zU+ofVz8ntzgLYxFEbxIVvpGkWmQPYFUpvHJTUda1oAbHGBtaJZrC1a884qbsfyzd8RoL/rj3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(36756003)(5660300002)(2906002)(41300700001)(8936002)(8676002)(38100700002)(86362001)(31696002)(6486002)(6666004)(53546011)(6512007)(6506007)(478600001)(2616005)(31686004)(83380400001)(186003)(66556008)(66946007)(66476007)(4326008)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTdFNDk1UzNsM3FheEkvbk5ZaXZCczROOVRpMGdCMTR2amVmVDlYejMyTjBV?=
 =?utf-8?B?OUw2b2dqTVZSSmMveERONE95THFKdlJ6bDdlbHhUeVVXcnhiZ2JIKzVpdVI0?=
 =?utf-8?B?UlMvRy9oa2ExNTFHQ2tMcHR3TFlQOE81NVUwRkNRa2tCM0JFQlBiSVhvUVRk?=
 =?utf-8?B?YTg1NGd5STNRSlNVRnlFdTkwTThuTGorWkFXcHJacGt1UmFZK09IK3pjY3Js?=
 =?utf-8?B?MVk3MzBSQ1NIME1aNGJDbi9WbXpETWVGd0tlZXY0dmxuUWNwUHVNMVZBOHRo?=
 =?utf-8?B?VFNuTGR4WDJtdmFFS0s0SDk2VVJ1bFZKNEhBSFdGRkJhdlZWcm5aUnNzQTVu?=
 =?utf-8?B?MHNSYWxoWE93bTAzcjJydXpDRGkzblY1U3hYQXZMZ2ZkV0h3eTdCNGtUako0?=
 =?utf-8?B?VE9HRm9HQ0dtOVBkenZ4UnYwbkhzVGRhcUdmT0NtVXpRSENnMnZUNnB4NVZ0?=
 =?utf-8?B?SkZPeTBxNHFKWUZ1NFdRUUNBTDZnZlVGQ013b1dNaVpwT3cxRFJKSWxmUTdX?=
 =?utf-8?B?NCszR3dBSGtRTE9ENVpPL3laUm5Td0RpRmxmTW00aXliUFRNL0o1WFVKamFI?=
 =?utf-8?B?UlVBSkgyek93N1BCdHZWcERMTDFlMElrUjNoT3BPWkJtMWNlNjJnK012bWE3?=
 =?utf-8?B?UWNjMkdTSk9uNVJwenk3Z0dRSkkzRUt2WTNIVlhBZzEzL1kvQjV1KzVqM3pv?=
 =?utf-8?B?OVVRazU4cTBGYjNNZUxWRGxKenB5Q2FWTzA1aWppTDFxVkJCL3JjSEtYMUdC?=
 =?utf-8?B?b3BVS0RubGdMYjY4d2JYakIwdlpWUkhSbWRPQjl2aGNHMWZiKzhwWDZSY3kr?=
 =?utf-8?B?U1dQTHpZSVJ5YS9MVEtGb2drbzY4YUNBMzVYRldxcEVMREYvdjJZVkxCeTJn?=
 =?utf-8?B?M2NZWE80TGR0RjNUZ2pNNHkyNDg3cFZNZ3ZOMkxXNlF3L0NyMWo1WTdSZU4v?=
 =?utf-8?B?ZlNuRkpzNU9qZW5hMlJKbXFsMk1lMFFmaDJsMXVsc01xZG94TmFTU1RRREhK?=
 =?utf-8?B?M1dhYjBCeW5ibk01MkFNQ3Q4eUtWaE4zZUtrZ2F5ZTIxTVBucEt5bEFnOVNC?=
 =?utf-8?B?WnFnZURQNUluWXAxTjg5OUU5WEROSzdjSGc2MjFKNCtLamJMQmFmazhGNWJQ?=
 =?utf-8?B?VVlCNGJESjFsUnY3MjRyM2RqYkU2WWtFV3dRR0tSY2FsQ25CYmhvVmRwRDhW?=
 =?utf-8?B?djJpZ3hzd2VkVVVGZHhyM2t0OEIxalNncW43OTUvNXBtTHNRZnp4LzBieWd1?=
 =?utf-8?B?VmhKRWxTUVBZaFlIVzByRE1jOGhSM1JrRXovZWNJbnlZMERrNDFHVCtyQWdx?=
 =?utf-8?B?U3g2cDFhcTZBOUJycjllNUsxb2UxcFpkb01PYS9Mb3hvcmtqVHZMcUpTQS91?=
 =?utf-8?B?b1J6SUo3UUx4eFhJK1RJaG84MmhEMjVqbWtnVnRwZ2NUUUlPNXkwWW5QWm1U?=
 =?utf-8?B?YkZ3MmxvS0k4NFNzRFZ4T1N6bVI3MWdBSUJIWnViTkU2N08zYXNOazZTQXlV?=
 =?utf-8?B?YmxQVlJYblV2a0wvR1Vqd1NOQmgwZjViT1MwY3l6d29TQ3dxazNweU9WZWdQ?=
 =?utf-8?B?Y3JhU01sOTQxZGVCaFBjbGRaK1Fqajh6RFEvVDVkaiszb0ZxVTgxVFRvb01w?=
 =?utf-8?B?YUl5WEttMnVLSi94ZTB3UkdHVFZULzNuc2lPZnBId0lFTnU5RmxTV2p0RnlQ?=
 =?utf-8?B?ejREbVRyMDg3aDFZMENjTHFsWjZTNWtnL3lNSnRaMGhJbEFIVVJ1OFpDekZG?=
 =?utf-8?B?TjFvVFlTeENWWlpadmZJOHhiMVpXNUJGR2RiZjdPQ3FIbGp3Ujh1STRhTlFK?=
 =?utf-8?B?aFFxT0dadUw2VEl3Y3BacDJIUTRSS3B0TGNNQWgxbzRLNFVwbkFPU3N5MDNX?=
 =?utf-8?B?bGw4UGFUdWk1cHp5SkpnVVZaaExVc3N4VS9HczkxOXB2a3g4RitZb1hsUDhY?=
 =?utf-8?B?SmJManJMakZBSWZxZ2wxaUc1ZEhFS0pRL3Q0aUxXNkxYN3FjL2RCOHpCNHV3?=
 =?utf-8?B?Yjh1YWY1bWpNWGJIV0FRei95VGd2aWJBak9FcVZURXFUVk5Wc2szRFVxQXhN?=
 =?utf-8?B?QXJITXlCM2FCellseWFVamJFTVV6d2NudUhGV3JtSWdrUjMyS2JMUnIzMEE1?=
 =?utf-8?B?b1RXWVVKZ2g5Y2dVMXQvcEYrQmRpUU94SUlzZ2xWK1hmbHpzWSs1SDczczlD?=
 =?utf-8?Q?uFudoeKa3ovxUrDFKm92WYg2UmqIjGrmTK1VGp7slJsE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873e8846-802f-46d8-96c3-08db42abd088
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 21:03:10.9993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYsjIl3t1Qn0xbNFAqmiGjpPKVBPa6OeIA6T6mbq0iUxNhnL3eU+tjlCirGPNEIijIUzf2avAsaSL2XDZsANZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/21/23 14:39, Aurabindo Pillai wrote:
> This reverts commit 541908cc2cca427fc3ae3bd4c9b82797a78e63a9.

Hi,

Please add an explanation of the reason why we want to revert this patch.

With that change:
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks
Siqueira

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 5 -----
>   drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ----
>   drivers/gpu/drm/amd/include/amd_shared.h             | 1 -
>   3 files changed, 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e1565126ad2a..81206f67b993 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1645,11 +1645,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
>   		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
>   
> -	/* Disable SubVP + DRR config by default */
> -	init_data.flags.disable_subvp_drr = true;
> -	if (amdgpu_dc_feature_mask & DC_ENABLE_SUBVP_DRR)
> -		init_data.flags.disable_subvp_drr = false;
> -
>   	init_data.flags.seamless_boot_edp_requested = false;
>   
>   	if (check_seamless_boot_capability(adev)) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index b8a2518faecc..d7749260e1d9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -880,10 +880,6 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
>   	int16_t stretched_drr_us = 0;
>   	int16_t drr_stretched_vblank_us = 0;
>   	int16_t max_vblank_mallregion = 0;
> -	const struct dc_config *config = &dc->config;
> -
> -	if (config->disable_subvp_drr)
> -		return false;
>   
>   	// Find SubVP pipe
>   	for (i = 0; i < dc->res_pool->pipe_count; i++) {
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index e4a22c68517d..f175e65b853a 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -240,7 +240,6 @@ enum DC_FEATURE_MASK {
>   	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
>   	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
>   	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
> -	DC_ENABLE_SUBVP_DRR = (1 << 9), // 0x200, disabled by default
>   };
>   
>   enum DC_DEBUG_MASK {

