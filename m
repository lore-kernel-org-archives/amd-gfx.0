Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B27EEAA5F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 17:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A6710E2A0;
	Thu, 14 Sep 2023 17:33:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA39610E29E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 17:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7nrQqfYz5h2svd8EGGsHG8F1n9XHirEOvURVzQ/bMTt3Qf78+HVza6NK8Xd1/Dl00a305fYLopjd7XhpbMUZjq5Oz1aTLNjwAqomC0DBpQKPWwXYy9rlOLHNuDmQ0Sie6EPgB5D5m2J1S0w5ckZ2q03Qma2mq4HLfefCI4fVvPJxxhusByBNfIsg9WC3vyJWoTkWTZ+hWb6v8zBeiGvfFuOW8UziBMESLir6YqB+VWNxejJpyi/jXW5axv/w/T8ROZXo3hxN4sNjOnyY8t3BK1cNthV/tLomY3qkA+5ZpSbAG+PGCFUr+RkBGoT+Dg1yKYhv0QlT4SpigHCmY2PTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFBC7MLDVyUxMGPFmQiUWSKTkXyfwrTo/Tmh5KIgK9Y=;
 b=OzYH/JQ5duOPDOgPR8hJgm129ZEj6jUMKwhaMY6zeH8bFHC5fIcBpUO9NcsP5Ow9PgzVTABOw5keuq2FP4A4VkYAgD1A73S3NQXz2EKT2fEK7xVHYUhbhFK6PcG9FouUj8gT6fUajFpklnYq6mYOA7XigsaAybP6hXvhPSxwCGrQqjzOXQnvon82NynLReBLVHowX+mq1hDUnwEt0YMrb79GVlEMDSCMl10QqtIcE8epFY+xYo2somuOVMpsWDs7DG2yRIGEDjTQlRUdQplm0YkFVJ7nqw11kUpLwZFvnqiZYvlNXcw6T7x96uXN31taRfvm3FecoNrAR/eYLTyucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFBC7MLDVyUxMGPFmQiUWSKTkXyfwrTo/Tmh5KIgK9Y=;
 b=cjFu9crMMadySubsuEdU/wHR99O4NYZSL8cAZgE4Z2Z1GK70IowC+qhOJcOwrpZLPtm/Zpkik7p2C0/auOmE01kiADnW+nBctcjcthZMu26JE9k/8PFRzsjntEKjDpDxa/9Di3GuO2lu1et+pPYGl4v630rV4SvaUH1arpAUISw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 17:33:39 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 17:33:39 +0000
Message-ID: <e91581c5-ad36-4792-b74d-69a16827db03@amd.com>
Date: Thu, 14 Sep 2023 13:33:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/28] drm/amd/display: Drop unused code
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
 <20230914020021.2890026-28-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230914020021.2890026-28-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::32) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ef695e-62b1-46da-76d7-08dbb548bba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUvTebindj7W5pLOSyLFtNigbPBCNQ+1V8+ep3qvAV4ZO2PomRexl8Ub8kAzZ9PiEg2ugUCms1QmH9+tyA92PbDx/yrKP23DI+Fa65w3MwCDEHccdNLys5DxIpL+WvBTWm4bax0HXdJstfAw+mW9bL/bj3ZqkorPSBeFz6DxkIyFjr4UyYxMGQR+6JXq+tmWLvnoCowTiQ08n0jZ7CfzT+iGXJT4VlCAth0ozLLZyo61tAl9DbvRlCWKhhpNp3BjIzWXZBmSEXMZOkWK4f0h9eX2CLtivL9TbhCzX8CqdHYZlzqgIMNQVl2u378KnVZDfJtj7A+z0FrkF9XrSNnap1kfSdj51mT5+Ty9Ci20a/qdpVSsuO32pPCpOT8dr00jz87zCvAshmHLP1jswOS+VvPETgew0vwYbVPYK1389FVpyhzY0uUiIAcdKE9ztkAJShq/XcIO7b6X2SEIDq/OyVPiRyqsA7CuhPra4B9BOIQ6dPQxHLu9HdiXuhUB/XOSHgPkkobRYs05x6ylBruJVJ+YU98oWTEO+odK/nbMupTUxehTGQpqPI1H2SyYlDjMZJw461SMRy+vmirbwzwatGMvUxirkgMm7bR660Wik4vDgnJQw7DshQokbrZeWwkj1R0y2Oz6d6oIA0rCbuUSzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(1800799009)(451199024)(186009)(86362001)(41300700001)(31686004)(8676002)(36756003)(4326008)(31696002)(66556008)(66946007)(66476007)(83380400001)(5660300002)(38100700002)(8936002)(316002)(44832011)(2616005)(26005)(478600001)(2906002)(53546011)(30864003)(6512007)(66899024)(6666004)(6486002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ry9IS2VJdmdmdnZpUHBqdmZZWElNYzdiRHpObmpDZlI2SDdhT1ZpWmFwc0dp?=
 =?utf-8?B?bVh3QVVXVXNSdUwydDRtSU1peVREWlpnUGxrYllNZ29zY01RYVQ1cEdPam9H?=
 =?utf-8?B?K1dxUFh6M1l2bi9KRjV0b3oreWhpQmVoVHZTSitkMDg2a3c0R0o4N1B0djN6?=
 =?utf-8?B?RVdjeWhOeUR0Qmgza3NNNm1GSjdWOStRM3BHL0gzVTVPTDdWbVp4SDRWMWZp?=
 =?utf-8?B?a3E4UEJhVTR0dnJOa2s3VHY5Ukg0Mkc3Sko4THFTcWF6TXYzZHFpMENpM3pv?=
 =?utf-8?B?QytLOFpPVHJMNGsrUDFQNS9xa25JVjZaaDlZcHVzTGFmOUxrYmlsVVZjZ2Fi?=
 =?utf-8?B?bkg0YkZNN0FXRmFKeW5YckF4b29iRktpdDN1clhIZ0VaOGU0cDFTWVAzd2lj?=
 =?utf-8?B?NWJKU1J5UUpodWVCaXY3ME1UeE5Tb2RZRXhsNUUvd1BjaEJaTXBqRzlhekYw?=
 =?utf-8?B?MllSU3c2TldNYlFGTk9xU2VGYTkvQjVVQ3R4VGtkU3F1NjhCemZDY3E0RG82?=
 =?utf-8?B?ZUZyVVZOVWZZc1V2RGprbmRhYW1GaFQvc1ROK3I1SndSRGswRE9VOGFtVVNX?=
 =?utf-8?B?Rk5TYzNqZHVpSkRNOGZUZUQzN2svUFRWOTgybU9sZjNpZlNJbGZQZzYxcXVq?=
 =?utf-8?B?SGE3aWREbEFHbGtnOXoySENiNTl2MkFsWUY1TkFad3lhVnRYVGlJVlBQZ1Jl?=
 =?utf-8?B?czRlTUZyTlFzcC9WZWY2eHZYT1ZqMEl4Z2lOZlBkcHFMd0QwbEdMenBDdExI?=
 =?utf-8?B?c2JtQXZOQWdiT0wvZVdCZDh3elhQM0pxUU00V2FmZ1hyeVlhRTFNRGZsZzRz?=
 =?utf-8?B?R3hQWGQybURvUVJRRjFtaFZ6MUdIUkt3MCszVm03WUtjck9lSUFScEVCODln?=
 =?utf-8?B?V3QzRDY4MXFhKy9uUk0rdEV4aWtvYVJibmpiWm5TdmE0NmZwTjZib1ZrZjVx?=
 =?utf-8?B?djAxTkY0UzBRZW4zR0lJYVF2TzNRNG1ybHMxMFZFNXBvZC9qQWppQlNpNWxT?=
 =?utf-8?B?dER2VmlEMm4wOC9KRzF4R0xOZUc0UUNTZWJ5YngrT0JwdXZQUDVBV1ZxR0xo?=
 =?utf-8?B?Y09GSzhLaUlCN2N2UnRTcWlmQlptWm1mVGhJbFRrQzRMNmd0YTBGYWc3WCsz?=
 =?utf-8?B?cjF3dzhid0o0TnA0cXNRMm1ua3doRFdLTHJvZ1VmM1Q0UFNDakF2cjkyV0xX?=
 =?utf-8?B?UWt5UTZwbzFHTVFDUy9obVRYbFJxZWhHWEN0aUJTdGhRYzNZeUZoeEtFUldW?=
 =?utf-8?B?eno0Q1ZYbFlTalFNYnVuOStML2ZMdmFNbVk5QUtZKzVDVjhDOGY5VEFWdzlw?=
 =?utf-8?B?Y0I0dWlvYWExejJKcEc5ZGNtTFd0L3NqaHdLczhNNjZJNlRoalhjanpFSXc5?=
 =?utf-8?B?WW9aRDRvOVJhdlV6RjJPOXVSWUNYSjA3cXh3U1pNL3huKzJvK2xFSE1vSi9D?=
 =?utf-8?B?RngvRGZrY3JlY2RNMjhhOUowc3NzdUdwTEZxS3EzQWp2NC9PUXBJSHFPcCs2?=
 =?utf-8?B?dXVDczZ6WHVHWDMxVU1uMTRjK2FBdHlLSWZQSW5hQllrOG9rVmJTQ1kwQVNO?=
 =?utf-8?B?OHhWaDBWMEVVSjZ1QmhKUHFzUmtZcTdla2tpdmRCY0R2ZDdKYkU0THNZdW5m?=
 =?utf-8?B?dDZyZ1diRXFjOXUwb2Jybm41OVU1V0ZHTHcrWlg1QXN2eTd2TGVaVTBYYnRI?=
 =?utf-8?B?NzlBQWFNVEkxRFowNzRmSXBFcjJQOFVFZnMxUnQveG1SL0dueEJYUDJJVVR2?=
 =?utf-8?B?Nm5rZHN6MDk0dkZTQ2hyVVVJblJFQnh3anRKV2Fwb3FLbGhXNGkrSmJ3dkQ2?=
 =?utf-8?B?U2tvVE9lQWVzSVJWVkIwNEUwV2MxRXZqRDBKYmpHQk5XdGVtTGdGUE1haFlh?=
 =?utf-8?B?b0RiNWNqWitvSjFJd1RmL3kraHFxbFpqSEUxNG1LZXBmTS9GZk9ydkJoOW9O?=
 =?utf-8?B?WmJYWVpRcVZyRElGSit5M0UzV0pNOWRuMTMzSG1GYW93SUdYK1RudU9jbWdK?=
 =?utf-8?B?MytrVHdxWkd2R1NaQ0VxaW5salNYYUtKc211b3lGQ1dlT0VwMWxnM0VtSk9W?=
 =?utf-8?B?dzdPUGF5a0pzVUpFNnpyWDl1R050QWhTTUNtaWhLNkNhOUx1RUNsNk5PS25m?=
 =?utf-8?Q?B+Q4mUJ0fhmeu2TyesEfT04RG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ef695e-62b1-46da-76d7-08dbb548bba8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:33:39.5607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyt2eMqivgPPZgdNo3OjU70n24rYKS+1s/CYTwpkV0V+rqKLqXGs67qGf9e1NCve/eFgWeFuYKYQi05+NX4NKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, qingqing.zhuo@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-13 22:00, Rodrigo Siqueira wrote:
> There are multiple parts of the code that DC does not use anymore, and
> this commit drops those dead codes.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

The commit title is a bit non-descript. I think something like
"drop unused link_fpga.c" would be better.

Either way this is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../drm/amd/display/dc/bios/bios_parser2.c    |  9 --
>  drivers/gpu/drm/amd/display/dc/link/Makefile  |  4 +-
>  .../display/dc/link/accessories/link_fpga.c   | 95 -------------------
>  .../display/dc/link/accessories/link_fpga.h   | 30 ------
>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |  1 -
>  .../drm/amd/display/dc/link/link_factory.c    |  1 -
>  6 files changed, 2 insertions(+), 138 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.h
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 484d62bcf2c2..2ec496be778a 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -1723,15 +1723,6 @@ static void bios_parser_set_scratch_critical_state(
>  	bios_set_scratch_critical_state(dcb, state);
>  }
>  
> -struct atom_dig_transmitter_info_header_v5_3 {
> -    struct atom_common_table_header table_header;
> -    uint16_t dpphy_hdmi_settings_offset;
> -    uint16_t dpphy_dvi_settings_offset;
> -    uint16_t dpphy_dp_setting_table_offset;
> -    uint16_t uniphy_xbar_settings_v2_table_offset;
> -    uint16_t dpphy_internal_reg_overide_offset;
> -};
> -
>  static enum bp_result bios_parser_get_firmware_info(
>  	struct dc_bios *dcb,
>  	struct dc_firmware_info *info)
> diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
> index 6af8a97d4a77..84c7af5fa589 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
> @@ -33,7 +33,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_LINK)
>  ###############################################################################
>  # accessories
>  ###############################################################################
> -LINK_ACCESSORIES = link_dp_trace.o link_dp_cts.o link_fpga.o
> +LINK_ACCESSORIES = link_dp_trace.o link_dp_cts.o
>  
>  AMD_DAL_LINK_ACCESSORIES = $(addprefix $(AMDDALPATH)/dc/link/accessories/, \
>  $(LINK_ACCESSORIES))
> @@ -61,4 +61,4 @@ link_edp_panel_control.o link_dp_irq_handler.o link_dp_dpia_bw.o
>  AMD_DAL_LINK_PROTOCOLS = $(addprefix $(AMDDALPATH)/dc/link/protocols/, \
>  $(LINK_PROTOCOLS))
>  
> -AMD_DISPLAY_FILES += $(AMD_DAL_LINK_PROTOCOLS)
> \ No newline at end of file
> +AMD_DISPLAY_FILES += $(AMD_DAL_LINK_PROTOCOLS)
> diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c
> deleted file mode 100644
> index d3cc604eed67..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c
> +++ /dev/null
> @@ -1,95 +0,0 @@
> -/*
> - * Copyright 2023 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -#include "link_fpga.h"
> -#include "link/link_dpms.h"
> -#include "dm_helpers.h"
> -#include "link_hwss.h"
> -#include "dccg.h"
> -#include "resource.h"
> -
> -#define DC_LOGGER_INIT(logger)
> -
> -void dp_fpga_hpo_enable_link_and_stream(struct dc_state *state, struct pipe_ctx *pipe_ctx)
> -{
> -	struct dc *dc = pipe_ctx->stream->ctx->dc;
> -	struct dc_stream_state *stream = pipe_ctx->stream;
> -	struct link_mst_stream_allocation_table proposed_table = {0};
> -	struct fixed31_32 avg_time_slots_per_mtp;
> -	uint8_t req_slot_count = 0;
> -	uint8_t vc_id = 1; /// VC ID always 1 for SST
> -	struct dc_link_settings link_settings = pipe_ctx->link_config.dp_link_settings;
> -	const struct link_hwss *link_hwss = get_link_hwss(stream->link, &pipe_ctx->link_res);
> -	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
> -
> -	stream->link->cur_link_settings = link_settings;
> -
> -	if (link_hwss->ext.enable_dp_link_output)
> -		link_hwss->ext.enable_dp_link_output(stream->link, &pipe_ctx->link_res,
> -				stream->signal, pipe_ctx->clock_source->id,
> -				&link_settings);
> -
> -	/* Enable DP_STREAM_ENC */
> -	dc->hwss.enable_stream(pipe_ctx);
> -
> -	/* Set DPS PPS SDP (AKA "info frames") */
> -	if (pipe_ctx->stream->timing.flags.DSC) {
> -		link_set_dsc_pps_packet(pipe_ctx, true, true);
> -	}
> -
> -	/* Allocate Payload */
> -	if ((stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) && (state->stream_count > 1)) {
> -		// MST case
> -		uint8_t i;
> -
> -		proposed_table.stream_count = state->stream_count;
> -		for (i = 0; i < state->stream_count; i++) {
> -			avg_time_slots_per_mtp = link_calculate_sst_avg_time_slots_per_mtp(state->streams[i], state->streams[i]->link);
> -			req_slot_count = dc_fixpt_ceil(avg_time_slots_per_mtp);
> -			proposed_table.stream_allocations[i].slot_count = req_slot_count;
> -			proposed_table.stream_allocations[i].vcp_id = i+1;
> -			/* NOTE: This makes assumption that pipe_ctx index is same as stream index */
> -			proposed_table.stream_allocations[i].hpo_dp_stream_enc = state->res_ctx.pipe_ctx[i].stream_res.hpo_dp_stream_enc;
> -		}
> -	} else {
> -		// SST case
> -		avg_time_slots_per_mtp = link_calculate_sst_avg_time_slots_per_mtp(stream, stream->link);
> -		req_slot_count = dc_fixpt_ceil(avg_time_slots_per_mtp);
> -		proposed_table.stream_count = 1; /// Always 1 stream for SST
> -		proposed_table.stream_allocations[0].slot_count = req_slot_count;
> -		proposed_table.stream_allocations[0].vcp_id = vc_id;
> -		proposed_table.stream_allocations[0].hpo_dp_stream_enc = pipe_ctx->stream_res.hpo_dp_stream_enc;
> -	}
> -
> -	link_hwss->ext.update_stream_allocation_table(stream->link,
> -			&pipe_ctx->link_res,
> -			&proposed_table);
> -
> -	if (link_hwss->ext.set_throttled_vcp_size)
> -		link_hwss->ext.set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
> -
> -	dc->hwss.unblank_stream(pipe_ctx, &stream->link->cur_link_settings);
> -	dc->hwss.enable_audio_stream(pipe_ctx);
> -}
> -
> diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.h b/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.h
> deleted file mode 100644
> index 3a80f5595943..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.h
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/*
> - * Copyright 2023 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -#ifndef __LINK_FPGA_H__
> -#define __LINK_FPGA_H__
> -#include "link.h"
> -void dp_fpga_hpo_enable_link_and_stream(struct dc_state *state,
> -		struct pipe_ctx *pipe_ctx);
> -#endif /* __LINK_FPGA_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index d8327911c467..5a4f732e1e6c 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -38,7 +38,6 @@
>  #include "link_dpms.h"
>  #include "link_hwss.h"
>  #include "link_validation.h"
> -#include "accessories/link_fpga.h"
>  #include "accessories/link_dp_trace.h"
>  #include "protocols/link_dpcd.h"
>  #include "protocols/link_ddc.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> index e406561c2c23..754aab662489 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> @@ -33,7 +33,6 @@
>  #include "link_dpms.h"
>  #include "accessories/link_dp_cts.h"
>  #include "accessories/link_dp_trace.h"
> -#include "accessories/link_fpga.h"
>  #include "protocols/link_ddc.h"
>  #include "protocols/link_dp_capability.h"
>  #include "protocols/link_dp_dpia_bw.h"

