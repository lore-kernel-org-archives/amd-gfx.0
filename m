Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039E2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Oct 2022 16:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E47B10E97C;
	Fri,  7 Oct 2022 16:31:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C76110E966
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Oct 2022 16:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjxBLKzeYlbrUKsQCD33llS7hjoYIJGqPluE33VHyIeoAp8yVB7KCYGkOWQQM+a70q1cD6RQeWiI9oEVUENoYSsigrB6WIK+AMtH+zXGbe606S6EpiYyZ4W080WX1LxcbF+W1dgsXefGYUqCod0QQqvRPbNA0zWv942CeNwzXMwd7iT2eYp9LsvM7QrnIaTdeq7XDR2nxFpm35s0Mv3Co4uJJJfhTjB1bWgnVxa8pulw0EU7A1eEjLhkaVWCl/70CdUIwUjKbkfTqD+0Q6iFp3YYsvFF260b6OQCu+zuqOIALswWfsK1tzKKVmwuLWzOiyN9tvCqibtrB4PS1nBoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR/CzZshsihSGYRpYXS2AMCQqLUn0yVmPU2ruDNAc+A=;
 b=IG+uHArShCrwOfWJE6RbovYGN9RaW/Ox5PfKG/HyJ1A2Y/4oUug/42dtWpGEdF2ppwlnbR1bAwaEwPrU5hx850Pb1skJGBzYR20CAUpaommNxaCYxrkPayM73IdBROe/m4dKHzr6twjAAZffaxhRoBycwvnRSFOmga/cFC4zcXAdhuhgK8RjcgBt2b9XRWGwkfcS3CL8FzqhuN2upXLP6KaKmx5+LArXEVVcysgwaxuEGCQMcQdq/o3nudkBNavCmz6PHjJmXkN9kM5RkdqIWcDZql4XpbNNpJ51WLwtLtw+BEr5Rphrw0LWze0RjqRsE1lFzXI9JbdElC32wsxERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR/CzZshsihSGYRpYXS2AMCQqLUn0yVmPU2ruDNAc+A=;
 b=WYdxrkPb5GDjpPIbOu1HAAHF1zr2YocY0DDhuR09/Kwxym8o4QEheQlN0bsNwHRAlfGjGxP1aYcku6f4untHN6gxr2xL55aGfYEtdC5q1Dv/EiVr4fQ35RpMiVWj0mw2QpX5tHnLMVMaxSRpYftpAXrGqvgyXoBK1+5mNjlYndk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30; Fri, 7 Oct
 2022 16:31:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Fri, 7 Oct 2022
 16:31:10 +0000
Message-ID: <f0a5ee39-6501-625d-075a-b2cc26551553@amd.com>
Date: Fri, 7 Oct 2022 11:31:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [20/23] drm/amd/display: Fix watermark calculation
Content-Language: en-US
To: Qingqing Zhuo <qingqing.zhuo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221006212650.561923-21-qingqing.zhuo@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221006212650.561923-21-qingqing.zhuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:610:33::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a33572-313b-4882-17bf-08daa881576d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndU5TLNAd8Nh9FL1eboM93o3DPYZAOoDuQrf1fBzo3wUR4/g7nmEt0HIu/dlTbIQPvyHPmTHN0L0KJ8b3SFUrbdNSdvxmzK0XSdxm8Jy7FLkYywMg2YUPnM9+gl+3swOqpR1gP6VNut80Q6UUyRQEkJ5eibuNigeMyS78cDjT8kE4B3znalPJwWLk8rKN+ufoUDQoi3+DA0tb0aaF33v5CECnEyok21UBSSjjdAJwmf5TZ+40yRO/FIcgEnSg5sqyXM8sCLLC8SkpYYkO3gn/jXnSVElDbMurqZWxZzZI/tXDsFSdjtlSCKopfkXAJYeSDn/0JlaZImbnXw8G/ccBW5dB+Zp3pSmbrgFJBvcWUenjeYFbJgZKU7SkjqoEgT9AyK2iZljQyLc+xTQH/PzuymiEm4TRKI70bwfWh5MBHrx3bpoHzd9qp3LjVkqVXsliAV2ZtLr1jKf60phSx5tpFsGe+ndudcjqFSJggGrnz/syHuEXX8GEozSMKEryIWzdlsKctogZuWNTX+r0tI7QoliSmEp/x1QHufvC8gq77wFNNcL8xp1hAE2ka8eKpLNGHfTr1bAku/+fuWlioANGcHSUOpsiSJl5mwcFpJnOZKB46LP3Q96oRKVXTGt/ArO75aS0w9v+diYBC6axDJ4yyz4wjnerL0/I5kH5iCO49Ci90vPhnTTlczrANj2FsUpaHBPEnCOCyw4jdb4/icqO67+9CIKRtvu5vLdJHivqT1iLeVWYOpk6atAuvIw9zK2IApsXTNIajLtKs7K4iBjNeST2mPAywurUSCoWUWpQxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(8936002)(41300700001)(6666004)(53546011)(83380400001)(4326008)(66556008)(31696002)(26005)(66476007)(86362001)(6512007)(6506007)(36756003)(186003)(2616005)(66946007)(316002)(8676002)(31686004)(5660300002)(478600001)(2906002)(38100700002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBRN3NOakc4VXkyaHBxRk4xQVd0TmIxaWwxeENzazNDT0VlWUREcktvR3Ir?=
 =?utf-8?B?a0lrS3M4WTg2MmtFdFB2NFJGV3VkV01YbGZoTk9DbmZsc0tuQ2RuUGVnUzNU?=
 =?utf-8?B?dUFKT1B4ZDFqdHFIdklJa0lFSmR1QmJyQm92ZWxYRFAvM1lRYW14am8xMWJn?=
 =?utf-8?B?cU1Ed0wxUS9KRDA5bjU0bGY5M29UQUpQUXNDZjY2NGFubDJBc1VobWpaUVZB?=
 =?utf-8?B?QXpGckZlMjFOL1ZNTUZldURFZzZ2RjR0bFdaNUVpaHBGQU9VRkxQQzFCWTYv?=
 =?utf-8?B?U3MzTExZK3VqZ3ljTFhzMUtYREkyS2FncEt2aVN6azhBWlI2a0JyNmZZTzln?=
 =?utf-8?B?bGRDaWxFeE9mcklnWThaVzd1b3l5ZzB0bWhlYjN0VDBOcFRBWEFwYzlNV1lC?=
 =?utf-8?B?dmZMbUhydkxYQnpJN3FrenFXbDJ6TS9yKzVUVnkvQk1Zb0pZd0R4OHdOMjdN?=
 =?utf-8?B?SU9LSE5UWlgvTmNZbUMyb1cwdmV2bGJLV1lkY214Y3hadWMzVFFSNDQzRHFw?=
 =?utf-8?B?VCtocEQvZ2xPZDdZNUZlR2JTRFVtOVdKU25zYWZtdTFjQmxLdjc2OWZUZmw4?=
 =?utf-8?B?QWJLVjlkTi9NMG5adWhhbStlUytYRFdPd0hOVGd6SCtXTXFSTkFBclFUa2U1?=
 =?utf-8?B?QWtVbjhJcXlhQm03MTJVMENscUg0V0xpNDEvdWcrWnJKNkVVc0F1bzIzUU9B?=
 =?utf-8?B?aTd0M0FvNnIvakRZNHJ5RjBGU0l4Z3FmTDVHZFJKWUwrbk5PRm5MUVd1U2Fl?=
 =?utf-8?B?VWt3OFkvUFZBQno3UDdxQktncUFqNGFlTVlXN3Bld2E1WFVuejZ2cGwraXF6?=
 =?utf-8?B?NEpJUlh6QmxkU0dBbjNpdC9IV0hRVFgyTnJZbUhycTE1SFhKSTM2WlVLNE44?=
 =?utf-8?B?K1FQSTlta0xORnVuNUJXMGhTelBjaUQyVWdLTnNmWFNxeVBvalh1MjY2VHpW?=
 =?utf-8?B?QUF1SGtEcmZxNmZ1SkZpNzA4RkJXeGQ3TllKZUQ3ejNCazd5dDZJY1NVZzVC?=
 =?utf-8?B?NVkxT0N2SHR4SkUwZG1SdVpNZzFKNjdJU3lyS3JHdVA0YkprakczbHZPamdq?=
 =?utf-8?B?UW1BMWlDWDFWMDdMNS9QalFpZWlJNUFRVTl6Qm82VERHc1JtTGkxSnZJU3dq?=
 =?utf-8?B?dEs2cm9CS2FpQmpEazBIbFBJdnczVWRDT0w1enVrMldZRDk4ZDN5Vk9rYVQx?=
 =?utf-8?B?K2ZHaCtuZEpHTDlZVkFQL1RBQ1lZZEtNTWhoQ01sTC9UUDNPdmNSa0dJM1V6?=
 =?utf-8?B?WERCeEtYZWpJcHJXYXdsajhBV1FYM1pTVktheFk5cXVkVnVpUkZXN00xV2Vh?=
 =?utf-8?B?WTFnUjZjcXZmZDJzdGxxZWFJMUpHZ2FhUVpPR0Jta3BPVCs1WnlMekFCMkhp?=
 =?utf-8?B?cnFobjVqbVY3NzllTzVVb29jZnd2YTNzdUxjNHRZYWJDZ1R2OFlpWXRPRFFr?=
 =?utf-8?B?ckVhSkY4ZjBlUWMxeXpmRmVXdFZVNWtnVkl4U1Nzbi9QV1ROM0pnVno2MDBF?=
 =?utf-8?B?S05XMHlLOVVuOGs4ZU5FalhjK3FNbEY3Uld1Zy9nei9hYmNYWHlsMzZ1RlZH?=
 =?utf-8?B?NGtlRUZlcDlBYlFaVkIzTE85MlczMjg3Y1NxUFFTTXRuVTBpNkFyR3NyNm1J?=
 =?utf-8?B?WVdYaFZzTDM0UkkvTk5pcmt0SnNFME85Y3BlRDJjdkNENnBwVVU3cmtTNTdG?=
 =?utf-8?B?aHc2aEFIV2RYODFkamhIeW5YSkE0cGF6L0I2a1dDY0pOT1M0OXJEd01xS0Y1?=
 =?utf-8?B?bnVVK3pXaEV6K0twTTdmRW5SdHI0YzFnNnZIVThBbjVyRU1pZC9wTXRYUWJH?=
 =?utf-8?B?WWh4RGhraSt4bDFWUjFWbm5mek1CRkFYYjZLUkd2N2dHdjlxS3Z5UUNOYnNy?=
 =?utf-8?B?Z1RCellDcjFkb1JZeEVSaDdJdlJEQVQrNXhqYW5SYkYyaitvQVkyM0N6QWJY?=
 =?utf-8?B?VCttZDRFU0I1ek50WDgvU0ZBZkhUZUQ5Qk5Ia0dqaG5vM0VhbUo1Y2ExNTBr?=
 =?utf-8?B?K3ZOVFpDbUNpZVF4VEhBNFEzdlZxVzVURmQ2V242V1VUTDExeVRYcjJJREwr?=
 =?utf-8?B?OVlnYnJEaWNwZ3JUU1BQblZLNjNibTdJZ2ZFUm1LMVdjZWNnOEtwZElUamZi?=
 =?utf-8?Q?crFq5df4EAj0BMtTtWPqo5ri2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a33572-313b-4882-17bf-08daa881576d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 16:31:09.9548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1QMMjoZbILcRAH9qotmt+CEk5mhdxC2ZBk7nxMRS/Utgz8Bfn+WjuW3AiS4B5NpFpbsBOxHrjY02eJvDp/NHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/6/2022 16:26, Qingqing Zhuo wrote:
> From: Alvin Lee <Alvin.Lee2@amd.com>
> 
> Watermark calculation was incorrect
> due to missing brackets.
> 
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>

This just landed upstream for 6.0 and is a trivial fix for what the 
intention was, it should go 6.0.y too.

Cc: stable@vger.kernel.org # 6.0
Fixes: 85f4bc0c333c ("drm/amd/display: Add SubVP required code")

> ---
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index bbde635c56fc..0541e87e4f38 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -781,7 +781,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
>   		// Store the original watermark value for this SubVP config so we can lower it when the
>   		// MCLK switch starts
>   		wm_val_refclk = context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns *
> -				dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 / 1000;
> +				(dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000) / 1000;
>   
>   		cmd.fw_assisted_mclk_switch_v2.config_data.watermark_a_cache = wm_val_refclk < 0xFFFF ? wm_val_refclk : 0xFFFF;
>   	}

