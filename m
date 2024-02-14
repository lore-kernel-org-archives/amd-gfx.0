Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675BFC48BEB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C900010E8D8;
	Wed, 14 Feb 2024 18:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VfW7jiYG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D5E10E81C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRRYzABpe4yd7kSz5BVn0F1LNzm6KezinNk+eYMivaIJ3nfnhFSVcIbD2u4ZcrIeBIX6Tt9BMGvURcXVhb4pSxOv6OT6ZLmJ0SYpRffBqukk5/1UPkDnDuPXxX9KxrS65XwBI46zqRmYqr88vBA3L+XpbDwo1QRTyKYShy2cF9yS1AhAlxeJQTjRuxsDJT5CQuPg9ptT++jraqP5WeV3xZiiW9ss254wdU/1nqWFi539NuQ5XnYTJsaNuDGp7qBrWsDNj4fsSBhBKQm9z5sHVD+14/KCWZfUq9ewIeoW4ypZ5ArchFOI1l5QfDbHF8bWbVhqByAj/sMv5ttwlF/82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=804g2laiFQux7QYCrrtVNEwd5PS4HWlMSReNkRNjv2I=;
 b=Kw6uxAo4u2uWHg9TT0t4Mj+9pGM1QxYGacABqgkRLjiQIEGwEX/GCtJH4zKY2/BaSWeeG43AZMdiWRC108UkVvg56iYbaf9BbcwapNCe0lkGbOVOGtSAew6U40qGAKz2ClDL3+MghYki1YQ0b1TIlEZGSELs9QBfAX+jRWNibCnrLIZnweR0wpNj9T1g65irWYcAPoASPZnPlv/KXNtZ5CLT8PDhW3URLmuIb5VwBH6GZMzvWv3hfGdI+CSqJIH32XkpRXAdRYzTHPiGxszs/lC4v+mfESswWQFrpn4zbeGQ7rafVLmuz0rRXhM1DyZ83F65mHhfXgx2M1WPGK1SNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=804g2laiFQux7QYCrrtVNEwd5PS4HWlMSReNkRNjv2I=;
 b=VfW7jiYGTeeBtz/GbMBjZTw036YvdN8HMwUcd6EjeOpHP0L0Fc5UmKdUCvvoflmgM9Oiy+YGKQJHBUfdpRX0SxZRl28LKmC+wuKvbAzg92PN3UmJYKJ30XUk1/EeMxxkv6yCE1goPxdpkokazNQqdQrM6vOz3QRKgtSXhN9D24k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 18:48:12 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5%7]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 18:48:12 +0000
Message-ID: <4fbc4cde-e597-4c01-9dc4-91c88a171eb8@amd.com>
Date: Wed, 14 Feb 2024 13:48:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] drm/amd/display: Remove unused file
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com,
 roman.li@amd.com, wayne.lin@amd.com, agustin.gutierrez@amd.com,
 chiahsuan.chung@amd.com, hersenxs.wu@amd.com, jerry.zuo@amd.com
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
 <20240214184006.1356137-4-Rodrigo.Siqueira@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240214184006.1356137-4-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b2e4bd-2150-4ec1-03ac-08dc2d8d7f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjGQPdwBZTMH+y++xSyeFYTFO0LVPPpGYaT1sfZbC2wxTA1D3uSoM9FH0tqNPlYVLiL3o46ZluwA8+zcTy0CP+RinUUWMsY7yYVLJ3FKkXDJ9L9sDYHue8PRao06Y/8qWH1eoX342Sw39+PvObzPo/2BBsOL/0SwsqfFebRWUVMXqm/x4nS1a0hPNxB/08347dMyiXh0aeU1paY+k49u56kHk5dPdKSN9xbiHRe/p8OPyoJ1KqDjTz+HR5HlkdP2OyogJECWWMF5wzTC1+hrbg7/hnO8s1gDQa5hv3oEpHI8yl1lpMo507209MMRl1zhsG3Ubj5qlML4mkB6AiEpciiDtdGUH3GS4D8x1OTghvjm6IHfJXjXr7f7RZzl4yLu4nsuyTdVJ8f/uSpR7DePjhMOlZC+57tR5skSiExbnMDDZkTaCRpUrB1lfeyzOOU/+cdsyCx+lgLjWEJmay5H0HkLAOijuDCqc9OPmx1v8b+ijitSnbS+4a/SZGQkCMLpXtBjxs58y8pjmJv+qwTqH8Z7vTsntkUNK5RkKqByLv1epMnqHLtJ1gqLj+1hEEke
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(8936002)(4326008)(66556008)(66946007)(66476007)(2906002)(83380400001)(26005)(38100700002)(36756003)(86362001)(31696002)(316002)(5660300002)(2616005)(41300700001)(53546011)(478600001)(6512007)(6506007)(6486002)(66899024)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFRZeDZBK3BpNXBwb2hzWmZWVEI5V2VUUGwwa2Vqc29OV0QzN25lZnNkejdk?=
 =?utf-8?B?NnNOaHVzanBDZlo0RFZHQ0VuRXJJclpnbkZXZ3JJSmxTeGJackhUOU9xdkxu?=
 =?utf-8?B?ZVNRZjZCM3RPWEphc3V4am9sdS9oMHhYNjhtcnlkbDcvNjRVanJVQnhYWVJR?=
 =?utf-8?B?RkhIcXUwK3hVcDZjRWYzQlNqSHVxdG82WVhOMVNBWk1pVGN6NGJKV2RKQnFK?=
 =?utf-8?B?T2U2RU1QUnJNY0VsSG8zMDB0REpJUGFJa1JqeVJjQ3pFNzN5UDVpMGNWaXZr?=
 =?utf-8?B?TUo1WE4wYTUzQ0JZUVZjcUlUWnNUejUrMUQ5SVN5ZWZTN0gzSFZFa2FqY1dh?=
 =?utf-8?B?RGo4VjE1TTVraWhiUzNKQXZjalVIU0RhOGhCN3k2RjhiVVREcnJoRVRMN0tF?=
 =?utf-8?B?NVdtVVJFQkhHVmVKZjM1cGRxM0JZRWt1MGVxdWZQVlRreFpzMW1zRGRJSjU4?=
 =?utf-8?B?cDdOQTJpeDlIOVZrSlZtMW9VenJvWm1ucml2eW5oOGZhK1RFSnJSYm5uOUpk?=
 =?utf-8?B?bStJcTFyNWZESC96N0l0bEdGRXBRdHJFRHJYNjl3bVRPQmJqeFRzSnhKbVhw?=
 =?utf-8?B?YnQ2VXZSOGkyQVpuQlYzSTFEUncwRDAxYUpwcXJQNElvdGVZYWs5Qy9HNy9H?=
 =?utf-8?B?cllBM3RLb05sd0tTcTBRK2R5cW9DaEFrWHdxNzFSNEg1Vi80NUVnc08vbDhF?=
 =?utf-8?B?QVB0YVoxUzVGTFRzVWY5eGM2THpMS01kOUVWdEtiRlVxbzR1aisrWTZTUVV2?=
 =?utf-8?B?cXg4d0lFYkI2VTJJY0JoekhRWnR2NXNxUHRGcEsra0tLNkd6ZjJNdXNOZkx5?=
 =?utf-8?B?SkxBSEpOeC9meHhVRkphSEVWcTRUQmJBZENUVTQ5UTgvMlJwMWpIQmtLanpU?=
 =?utf-8?B?NWVMVzBnaVozam5qazJnYVlMMmorRXFlUjVxTEx1b2JCN3dEaktyaExqQkpF?=
 =?utf-8?B?MVNRZGNBZWNtMnZBQ1I4ZElVVGZBRXdhZmcxY0JZWWpKZ2J1V2JMMkJmK25P?=
 =?utf-8?B?R3ZSdEtBaXBVZWJHbGNYaTdHcTdHbTZXQm5FM3RXeGpidFVxYlp2ZDVuS0E2?=
 =?utf-8?B?SDYwN1VzU3ppQkNwSWs1c2RaQVN4QnNTSG5IUUlvOVUxRjBzck1pamw0NTJn?=
 =?utf-8?B?QUttZDZPQnJ6NFFXOGdYYUIxUmZnVjFQL3dpZHNSdy9qUlJ1am1nRTVhUFlT?=
 =?utf-8?B?WXZFMGVHQWVoMXhkMi91WkM5WUduWDNuOXRPRmQwOWZTOGptZyt1cmtRTlcr?=
 =?utf-8?B?UUNXZHdrdGdoVUxqWGd5R3EvT3dqWUJ3NldHaFVsalFxK2xCVGZzazJYbnNY?=
 =?utf-8?B?Y04vQTVhTGFZbnoxY1hja0dQZUcyQWo3Z21nTUs4UFhGYSthaDZVemltM0o1?=
 =?utf-8?B?SDBoSkpLd2o4MG5KWEJDU01zWDFrbGxtYTh2djVlWGZuWHhTTkwxeUVLNy9X?=
 =?utf-8?B?N1JnT1QveVpYRTRFQ24zWENIMGRsNk5SOVNGNmRjV1hIYkswTDRsTTdNWCtt?=
 =?utf-8?B?ZlQ5L1pyQk9ZbHBQS1FTdjJwOVVrWkdOZDA2ekh0blI4K1dJNnVsUTluTFNq?=
 =?utf-8?B?RGlXSkpvUE8rdksyWFIyTjV6UHEvNzBpZUR5MlBLUWJ3NXdKekRXU3ZSUFBK?=
 =?utf-8?B?NjViQndQc1Rwc01IQ3dZRnZ6N3VacVBkdkcvZHVHQXMyZEdXZjNCaTBhR3ZW?=
 =?utf-8?B?Vm5xLys2elJJNElJdm0vdDVsUFBRNXpMZXkzSFcxamR0UlY5RWpnL1Fsc3Yz?=
 =?utf-8?B?eWs3dXREd0lSbEtwWHNDL25wclo3OFBtWTVrNG5STGl2V1hZR1QrVk5FRDAy?=
 =?utf-8?B?c3p0Sm02RGF1ajZCT1dEMUhuK2piem5QRmpxVUZrTmQxa3pMNk4yWlg1NTVv?=
 =?utf-8?B?RWoxSFB0bGVSVk9MWDRQalhoM1FRUzJrZWQ2cGwyb05aN2p6b2hCNVYvMkN5?=
 =?utf-8?B?NUI5T0NwWWlkS1ZkTXVIOUdzUXR0eit2SFRTNXl1SDNiZUFWMzZEa2pQYTMv?=
 =?utf-8?B?NTdmWWFWVVhpSHhqRXFza0haWmd6Z3RMK3VmVmEwR0JMbjFtNmRWakVlOTdM?=
 =?utf-8?B?RGs1SUMrdG9EQXJZSVVRRDhxSVdwRGRGbUZ4WEYwUXNqSGRjSnV1NGcvdkJj?=
 =?utf-8?Q?1EfM3f/OG/xoCPeR394gzREM3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b2e4bd-2150-4ec1-03ac-08dc2d8d7f17
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:48:12.7186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ut7O7ottWMgXKoYiAe0dUmxt1OPTWGViC/+QwnTPmb7ttIiXrMHiN228FOhJq3VsFM+YRBv414k5GueFbzSnQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

On 2/14/24 13:38, Rodrigo Siqueira wrote:
> The file rv1_clk_mgr_clk.c is not used and for this reason useless. Drop
> the unnecessary file.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   .../dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c        | 79 -------------------
>   1 file changed, 79 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c
> deleted file mode 100644
> index 61dd12198a3c..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -/*
> - * Copyright 2012-16 Advanced Micro Devices, Inc.
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
> -
> -#include "reg_helper.h"
> -#include "clk_mgr_internal.h"
> -#include "rv1_clk_mgr_clk.h"
> -
> -#include "ip/Discovery/hwid.h"
> -#include "ip/Discovery/v1/ip_offset_1.h"
> -#include "ip/CLK/clk_10_0_default.h"
> -#include "ip/CLK/clk_10_0_offset.h"
> -#include "ip/CLK/clk_10_0_reg.h"
> -#include "ip/CLK/clk_10_0_sh_mask.h"
> -
> -#include "dce100/dce_clk_mgr.h"
> -
> -#define CLK_BASE_INNER(inst) \
> -	CLK_BASE__INST ## inst ## _SEG0
> -
> -
> -#define CLK_REG(reg_name, block, inst)\
> -	CLK_BASE(mm ## block ## _ ## inst ## _ ## reg_name ## _BASE_IDX) + \
> -					mm ## block ## _ ## inst ## _ ## reg_name
> -
> -#define REG(reg_name) \
> -	CLK_REG(reg_name, CLK0, 0)
> -
> -
> -/* Only used by testing framework*/
> -void rv1_dump_clk_registers(struct clk_state_registers *regs, struct clk_bypass *bypass, struct clk_mgr *clk_mgr_base)
> -{
> -	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -
> -		regs->CLK0_CLK8_CURRENT_CNT = REG_READ(CLK0_CLK8_CURRENT_CNT) / 10; //dcf clk
> -
> -		bypass->dcfclk_bypass = REG_READ(CLK0_CLK8_BYPASS_CNTL) & 0x0007;
> -		if (bypass->dcfclk_bypass < 0 || bypass->dcfclk_bypass > 4)
> -			bypass->dcfclk_bypass = 0;
> -
> -
> -		regs->CLK0_CLK8_DS_CNTL = REG_READ(CLK0_CLK8_DS_CNTL) / 10;	//dcf deep sleep divider
> -
> -		regs->CLK0_CLK8_ALLOW_DS = REG_READ(CLK0_CLK8_ALLOW_DS); //dcf deep sleep allow
> -
> -		regs->CLK0_CLK10_CURRENT_CNT = REG_READ(CLK0_CLK10_CURRENT_CNT) / 10; //dpref clk
> -
> -		bypass->dispclk_pypass = REG_READ(CLK0_CLK10_BYPASS_CNTL) & 0x0007;
> -		if (bypass->dispclk_pypass < 0 || bypass->dispclk_pypass > 4)
> -			bypass->dispclk_pypass = 0;
> -
> -		regs->CLK0_CLK11_CURRENT_CNT = REG_READ(CLK0_CLK11_CURRENT_CNT) / 10; //disp clk
> -
> -		bypass->dprefclk_bypass = REG_READ(CLK0_CLK11_BYPASS_CNTL) & 0x0007;
> -		if (bypass->dprefclk_bypass < 0 || bypass->dprefclk_bypass > 4)
> -			bypass->dprefclk_bypass = 0;
> -
> -}
-- 
Hamza

