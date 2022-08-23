Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BEFC25B08
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Aug 2022 04:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE263AD26F;
	Tue, 23 Aug 2022 04:52:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 327AEAD255
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 04:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDCJSnN1KsWS+lR5yEfKVFEc92j5z0Fm4g+mNP9y7aw8WSnCpqFazdCdJrHZahbuoIFB12qWImSRkdbYm7VUscAclWP8EOKuln5YSrUK145B8nJYsov6Uv4WidRCAcTEFQ+9RnEwpjdvShM2YVQ0j39zUxulyW5if0hNExmKTzmZxjSAITUHFHPltS2nH3rrp36f2M75Pz/uXN0quosd9fB+jTDP9wPLx5+Urj73MbXQmC9lASzDAFmhBmkeR/VE55/UaVaesFl6FNB14JDnFrZ9X1C0zXtYEcaRindAAZk6W8GGpJGdtm+XrG9YsTcXw+Fg8pQ6zFlSBBi/rjjYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPACP0bQl3kSbDisNiI2yI03IafhPa8f0MJbolxh9lI=;
 b=kv80dz6jaFHNKYFXlDdRrjYrLa3Z/dv4u7NhWAVETKaP8mo2JNJ/7za2Vnae2Tgtfa1uurpl+W0PkzF1SskVJQDAdoXOXABZU8HCzkSjQvGCRtsddjqaxTj8VnG/McS7Ma81hEDn6OUrauptZbNrKnYaRYLz5p/sR0QnBbFlXPCXnViMRYrVJoHpRmCf6O3lDbLMoNgAn2OuIu/OhmYO72jRcipmYqb4zOTZWqQCEIQo8ICpQXm3biMODczXKRfy+T8agYWDy9B2qwPsvLi9tf+2g092LMEWEopSII2T5rGpbqsd/UYdua76LqH+DET1WRvVgpHbo3aIEVR43I4Kkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPACP0bQl3kSbDisNiI2yI03IafhPa8f0MJbolxh9lI=;
 b=4Rn1dxKBN67TWdCRRIlocSIcqfLGuc55XFwnounI1J3XHOPh/gaHFiuS0bJY7xZeJON8hrJ24CSORZXW/ACg6AQKfYNslT5hRpgZOs1GDTKMjIokuWAJHe3m6Pi/WiWee17s7k39V5wcYlKveZZCCuCDZcw+t/+ruDZbtsLfi80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by DM6PR12MB3001.namprd12.prod.outlook.com (2603:10b6:5:116::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 04:52:32 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::dd3b:49e5:229b:e6a3]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::dd3b:49e5:229b:e6a3%4]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 04:52:32 +0000
Message-ID: <b7ad1218-29d4-ef17-3b02-03837a89006c@amd.com>
Date: Tue, 23 Aug 2022 10:22:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 13/14] drm/amd/display: Adding log clock table from SMU
Content-Language: en-US
To: brichang <Brian.Chang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
 <20220822095752.3750614-14-Brian.Chang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220822095752.3750614-14-Brian.Chang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::16) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7238964-cff8-4724-3cc6-08da84c349ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3001:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ycaGDvYUqEldyyM/qCfOoY7oLwlDh3DG6ZRG2K6zFWOlhaIarGz02US4IQ3DiqEjnjMIq6ZZrGuQ68TQBU3tzMtoxiahgecbRKNgeZIfGrmOdLWgPJoc6ftTP/zp1WyyfaNzF7a9DbzGbrEqnvXkCi/4zNKDS6xkU/JssL3S3sJCc8pVfFOMiBU/R+OM/+9AW+rAK70H3P+dR+LUcgR3IkChDuxxKEME7Q2GPzCkVAQy3RLbKhhShxOgzpu2poqbNmzbktpmdgvetPYlsH0SFp+bfOZ6pwCn07oI4Ih8OYBCAyPiqiV4ajG7niDipLi9c/vnOmAnKDAaf/cVmF4tFAf9toLsWNkwiwrJm7pjrrCink/669ncd9TIi18T4QP5yOkVW159ipjtUOI04ea1qgugWmJPSrKUGT3nh05kFMkB+ff05mBg0iqa3kxRWCG5Mrg+dUYzpVIFxpLgKI+txXpvX4AUlKJK9KYAX6i2J1SlVSRt3iGZ1EufEuEdcPzdYXyzOTpBxVxw/5aSKb89AxNOJ0ohqPnGBOhy3vMb5XFLBLtlM/Q+KXbj5zXX4sq1+j8EN/YTTDovdkphdYwAc2/lQqJtnCjW3w73ghjcEG/Unu8B3LLJd5ISq3ht2UjNl4aMKLWsNguEMGQUVz1K8HJJjwh3NxzCwRKiSeakAslNozg5g+Qtxb+rQf4Lz0jU860BVDhlT9WZFFdYBCub8BfxD8FHh6Td9APpL+fxS9MZpHuWXVtJ6DlaKktSBrDfDEqfrmVOPqpQ0ZB5IZmuX4BTG660pYKwErwXbj8UoeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(53546011)(6666004)(31686004)(6506007)(6512007)(478600001)(41300700001)(38100700002)(26005)(2616005)(6486002)(186003)(66476007)(66556008)(66946007)(31696002)(8676002)(54906003)(4326008)(83380400001)(2906002)(8936002)(86362001)(316002)(5660300002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUErRytITk5vclZINjRUZi9MU3pjbmwvQkFGak8xQ09IZHdCVDZybkhuWUhT?=
 =?utf-8?B?ZER6b1pyTTh6TzZFWUZhNE5peEhRdTFnR1RLR25aYVJRRFo2VXNRdmRZbHBv?=
 =?utf-8?B?ZDBoWGUrMTFZUjJXUTJTT0lYZ3kxQzdkNklNcEEvRjF0cUl3SVVWM1BkenJw?=
 =?utf-8?B?Rm5JSVM5RmVwS29ycWVVSzhMTDBBd2hEUEREWmJLSmt6SWJuWlNnUlRWSDNk?=
 =?utf-8?B?Z2VWYWphYWtLanNnVFpEeHUwMzJnRGRpTi9hTVlXVDFFYWN4RWhxNHFwNkRO?=
 =?utf-8?B?cDhOQ2xUcjZBbjFNQk1QcEVMMGlMT1p6VkxWQyszL0dPMm9MMzVReDVlc1Na?=
 =?utf-8?B?S3J5Y2hFTEtyeUg4aTdIemtodW8zR0ZsZE41NWtzNi9Pc0NPMDNtdytmM1Nv?=
 =?utf-8?B?c3lOR0V3SjNobGNDR3pwTUwyNEV2cmlNbnd5TW93UXJaZUpJZ09ackY1N1Fi?=
 =?utf-8?B?YjkvdWlPK3ZRbk9GYU9GMVlMSUJWNGhPQURkWXl3YXgwejBkMDNmcnd1TWpM?=
 =?utf-8?B?M0crNHBHcGFlaGQ3OWFhaXZoOFRBTUxwT1NBNGJDUWcvWURHeFViMzV5VTFS?=
 =?utf-8?B?UzVkdytsY1ZsWm1sbzRWOTFXOW5aMEhRWmJNM3p6ZVZpREt4TjB2R0tNelFR?=
 =?utf-8?B?Rzk4Q01TYlN0dVFxTVdiZFV4bUJOQmZzbEF5QUIzZ1MzVEdrNUsrRVNHODhl?=
 =?utf-8?B?aU1mZXJ3eThZZ043RC8ya0VRWmFWVGZYdXdDWFR5Q0NKTVlzTzNLdFk4QW9K?=
 =?utf-8?B?b2w2VFJ0VDR6Q2VxVkcyZjlRUGhlbzZBOGJsTmhtL0JTUmphdTh6T3RId0hi?=
 =?utf-8?B?aDA1OWlGcnNETVBUNnVMOGlQL0VKQWg5Vk9GTDB4UU5zNjFEeEt1QWljZ0xI?=
 =?utf-8?B?akw4ZVV6SFVoNmIzTGFyQVl5ZzJRU0N1cmlJZUZIZFRyMVpxNkRxZWxBZVRP?=
 =?utf-8?B?NEhzQWcwQTFwazQ2eTJRc2x1QlVIY29zTWZ6bGk1blJlRFFaRmViTTByR1Vi?=
 =?utf-8?B?d3B3OGF2Sk95MW15M2l5ZFBBT1M1cHRoRGVoVXNrbVAzaUVOWTlzbjN4U25Q?=
 =?utf-8?B?UU5xV0w1U0lzTnRMODFPemFXakxpRWtMbFQvTGN4d0d4YTEzYnVOcHczeVlz?=
 =?utf-8?B?eTNjaTdVTHRzRzE3VWM3R3Y0S1IwOGhpaGV6QXFkZklNSlF0QmdIR3hNb3BI?=
 =?utf-8?B?eUROVXE3QU9samJPNmhFem9ENFdxeXN1amVJWHlVZnB2MzJrZmpxZ3ZILy9o?=
 =?utf-8?B?VjZ1WXVOeXBaVWJLcFVjY29RWEZXUUY5T1MrcVBGdGIzdnNBQy9YdWxLSnFL?=
 =?utf-8?B?Y1ZER1U2L0xkTkI4OGdVSytnTVpRL0VIYmJsaXgvQWVRM00xTFdJeTFxeThu?=
 =?utf-8?B?Mld4Y3E5UU42eGVNb1dhQkpVN0RVdjY3SWE2dHVHMVpNNzZJQ29sM1pXSUVU?=
 =?utf-8?B?VTlOLzcvcFhPcEJLSGRrdFFRZ3FTNUVSbjZHSlQreU1jYXBndlNHL1k3RTdo?=
 =?utf-8?B?anpDL0g5R1RuVG8rMTlhTHhSZ3RmUTlKMW5tTXpGOEFadm9Hb1FNRXlESkRy?=
 =?utf-8?B?SDR3eW5DNXVjYWEzeHNtT2ovTjN3OU5MM1FtSkpsSUZqNUhwRjZOS3VyT0tp?=
 =?utf-8?B?WW9GZWdNZXVvbDQ5d1NZb0xOek9UbElkQjc1UGpPRzlGQ29EU1pMaG5LMmdH?=
 =?utf-8?B?N1BhV3pRM09PZkdVY0NVL2Z4c2NBalZ1ckU5T3FvYktiRGRrNEN3QUxJL3Vy?=
 =?utf-8?B?U0lRNHUwRktkcGJXcFUzMHJ2c05hN2ZmS3VMMWpuZlZSOVVZSXJYeTM4UXpY?=
 =?utf-8?B?eVFoV2lha1dEeDYrblNLL2FaTkowbmQ5cEpMd3pKVnZoRlg0TnIrNEt4SElD?=
 =?utf-8?B?cGFiRnhacmpNWmpQMll5LzVUeUpNNFlibE4raFN0eTNhSjM1Y0UxOGNGcHl6?=
 =?utf-8?B?QktFODQ0T0d5U3JsM09EYXA3RXlDWXlzRnZaZEVwOHM2SDkrK043c05HMnZ2?=
 =?utf-8?B?dExvWFY3RjdId0JSRjBpd0tBR3k0REpnWjRxZ0ovYi9tTXVqN29vR1B0elNV?=
 =?utf-8?B?eXJkQWVIN21RWTJoSmk5OXhmeHVKOGlTdHhlVys1NzFRenBCczRCZ3U5SmxU?=
 =?utf-8?Q?GDqumnPu261BlV0rNW00BgqIM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7238964-cff8-4724-3cc6-08da84c349ae
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 04:52:32.0053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtVx+AOof+Q0REJ68Pw0c8bBnjAAGCrq7sEq418PdCxHsgMZtxJr5m6NJJbOSjZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3001
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/22/2022 3:27 PM, brichang wrote:
> From: Leo Chen <sancchen@amd.com>
> 
> [Why & How]
> Adding log for clock table from SMU helps with the debugging process.
> Implemented using DC_LOG_SMU to output log.
> 

Most of this info is already available through *_print_clk_levels. 
Additional info like voltage may be added though it may not make sense 
with adaptive voltage control.

Thanks,
Lijo

> Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
> Acked-by: Brian Chang <Brian.Chang@amd.com>
> Signed-off-by: Leo Chen <sancchen@amd.com>
> ---
>   .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 46 ++++++++++++++++++
>   .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 48 +++++++++++++++++++
>   .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 46 ++++++++++++++++++
>   3 files changed, 140 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> index c09be3f15fe6..d43258e3cd4f 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> @@ -48,6 +48,11 @@
>   
>   #include "dc_dmub_srv.h"
>   
> +#include "logger_types.h"
> +#undef DC_LOGGER
> +#define DC_LOGGER \
> +	clk_mgr->base.base.ctx->logger
> +
>   #include "yellow_carp_offset.h"
>   
>   #define regCLK1_CLK_PLL_REQ			0x0237
> @@ -737,8 +742,49 @@ void dcn31_clk_mgr_construct(
>   	clk_mgr->base.base.bw_params = &dcn31_bw_params;
>   
>   	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
> +		int i;
> +
>   		dcn31_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
>   
> +		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
> +				   "NumDispClkLevelsEnabled: %d\n"
> +				   "NumSocClkLevelsEnabled: %d\n"
> +				   "VcnClkLevelsEnabled: %d\n"
> +				   "NumDfPst atesEnabled: %d\n"
> +				   "MinGfxClk: %d\n"
> +				   "MaxGfxClk: %d\n",
> +				   smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->VcnClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->NumDfPstatesEnabled,
> +				   smu_dpm_clks.dpm_clks->MinGfxClk,
> +				   smu_dpm_clks.dpm_clks->MaxGfxClk);
> +		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DcfClocks[%d] = %d\n",
> +					   i,
> +					   smu_dpm_clks.dpm_clks->DcfClocks[i]);
> +		}
> +		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DispClocks[%d] = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->DispClocks[i]);
> +		}
> +		for (i = 0; i < smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocClocks[%d] = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->SocClocks[i]);
> +		}
> +		for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++)
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocVoltage[%d] = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->SocVoltage[i]);
> +
> +		for (i = 0; i < NUM_DF_PSTATE_LEVELS; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks.DfPstateTable[%d].FClk = %d\n"
> +					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].MemClk= %d\n"
> +					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].Voltage = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].FClk,
> +					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].MemClk,
> +					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].Voltage);
> +		}
>   		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
>   			dcn31_clk_mgr_helper_populate_bw_params(
>   					&clk_mgr->base,
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
> index beb025cd3dc2..f2f9d2d3908c 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
> @@ -51,6 +51,13 @@
>   #include "dc_link_dp.h"
>   #include "dcn314_smu.h"
>   
> +
> +#include "logger_types.h"
> +#undef DC_LOGGER
> +#define DC_LOGGER \
> +	clk_mgr->base.base.ctx->logger
> +
> +
>   #define MAX_INSTANCE                                        7
>   #define MAX_SEGMENT                                         8
>   
> @@ -775,7 +782,48 @@ void dcn314_clk_mgr_construct(
>   	clk_mgr->base.base.bw_params = &dcn314_bw_params;
>   
>   	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
> +		int i;
> +
>   		dcn314_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
> +		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
> +				   "NumDispClkLevelsEnabled: %d\n"
> +				   "NumSocClkLevelsEnabled: %d\n"
> +				   "VcnClkLevelsEnabled: %d\n"
> +				   "NumDfPst atesEnabled: %d\n"
> +				   "MinGfxClk: %d\n"
> +				   "MaxGfxClk: %d\n",
> +				   smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->VcnClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->NumDfPstatesEnabled,
> +				   smu_dpm_clks.dpm_clks->MinGfxClk,
> +				   smu_dpm_clks.dpm_clks->MaxGfxClk);
> +		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DcfClocks[%d] = %d\n",
> +					   i,
> +					   smu_dpm_clks.dpm_clks->DcfClocks[i]);
> +		}
> +		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DispClocks[%d] = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->DispClocks[i]);
> +		}
> +		for (i = 0; i < smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocClocks[%d] = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->SocClocks[i]);
> +		}
> +		for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++)
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocVoltage[%d] = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->SocVoltage[i]);
> +
> +		for (i = 0; i < NUM_DF_PSTATE_LEVELS; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks.DfPstateTable[%d].FClk = %d\n"
> +					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].MemClk= %d\n"
> +					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].Voltage = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].FClk,
> +					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].MemClk,
> +					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].Voltage);
> +		}
>   
>   		if (ctx->dc_bios && ctx->dc_bios->integrated_info && ctx->dc->config.use_default_clock_table == false) {
>   			dcn314_clk_mgr_helper_populate_bw_params(
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> index bff0f57e7fe6..14071aef5eab 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> @@ -41,6 +41,11 @@
>   
>   #include "dc_dmub_srv.h"
>   
> +#include "logger_types.h"
> +#undef DC_LOGGER
> +#define DC_LOGGER \
> +	clk_mgr->base.base.ctx->logger
> +
>   #include "dc_link_dp.h"
>   
>   #define TO_CLK_MGR_DCN315(clk_mgr)\
> @@ -666,7 +671,48 @@ void dcn315_clk_mgr_construct(
>   	clk_mgr->base.base.bw_params = &dcn315_bw_params;
>   
>   	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
> +		int i;
> +
>   		dcn315_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
> +		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
> +				   "NumDispClkLevelsEnabled: %d\n"
> +				   "NumSocClkLevelsEnabled: %d\n"
> +				   "VcnClkLevelsEnabled: %d\n"
> +				   "NumDfPst atesEnabled: %d\n"
> +				   "MinGfxClk: %d\n"
> +				   "MaxGfxClk: %d\n",
> +				   smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->VcnClkLevelsEnabled,
> +				   smu_dpm_clks.dpm_clks->NumDfPstatesEnabled,
> +				   smu_dpm_clks.dpm_clks->MinGfxClk,
> +				   smu_dpm_clks.dpm_clks->MaxGfxClk);
> +		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DcfClocks[%d] = %d\n",
> +					   i,
> +					   smu_dpm_clks.dpm_clks->DcfClocks[i]);
> +		}
> +		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->DispClocks[%d] = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->DispClocks[i]);
> +		}
> +		for (i = 0; i < smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocClocks[%d] = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->SocClocks[i]);
> +		}
> +		for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++)
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocVoltage[%d] = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->SocVoltage[i]);
> +
> +		for (i = 0; i < NUM_DF_PSTATE_LEVELS; i++) {
> +			DC_LOG_SMU("smu_dpm_clks.dpm_clks.DfPstateTable[%d].FClk = %d\n"
> +					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].MemClk= %d\n"
> +					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].Voltage = %d\n",
> +					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].FClk,
> +					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].MemClk,
> +					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].Voltage);
> +		}
>   
>   		if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
>   			dcn315_clk_mgr_helper_populate_bw_params(
> 
