Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8356DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 18:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E21010E1D9;
	Tue, 10 May 2022 18:38:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3840A10E1D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 18:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwEBnEEtVEXbfxRMCIvumEpa37JIVnQT4KXCxAK/ygi82Si7mLbg34Z8HXuqXNFyjVGmenEIGqs1cMvAS1DDGUgBVMXZQ1F/1eQ+vy8XnArSV4Vk3wn54R+qP6/vkPSvobsX0DHZ0CqvipT6W+H1eR6hBrxOYpce7YTTEgTPZNTqynbw8YEVwCZYCRMWd7YMgK3+4duj7wE9u4Sm2f+mtCz3Qa8KegyaESCR+A4GEp2Vzh1koWJqvwiv7wwga6jXUlvHkxK34EGjJS2sTMKvxbyZJ7PiaJ61tY9ToXYWQx17HYrhQYDWUUWTBcNAZBSxg76HG3oyu2TLRW5VX3+j/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBUnf/kIPpgb9HHtLmfuHI3TenV42NteAf7fj3wkasM=;
 b=MtyzYO+wxqHB3+SiBIyBqzLVHeY/L1vIHpAh5OVcQQLTfc6Sahsw7ON/BfzvUHDnHlIgecFlcP/H4zm+45BTCbCFPd5fbP/GvnnbOQFNOOxsBdtrHfqW1hR2Od4vVyAznvH01b1cYlS9RmnsQlt3Dyu/MEN7nbzOoTSiYppLR57HIZiEy4qLGD738x3waaLb+sHJmVVgMaXfy/nq7RTyNZkaZOjtjhf1YebW9bRoXuUGt/ALAbN9kcYhmS1ZWCd91LrjmMChh73NBkYxwYi5p+/Mu/ROW2ioMN0+qw/mtqPp7hdyNClPKdTcQSTj1UiyptWBTOMTvI+x5XuqfmkQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBUnf/kIPpgb9HHtLmfuHI3TenV42NteAf7fj3wkasM=;
 b=r25dzDfG4DhLOd4HfARBw/Zfu2Jt+kOyD9f+9XLOiFZWKS1HrOAaqvqCJIGF31s+5zL5yn9GsZzA3QUEgghmJ3KXFTz4tdETRX3KjksaSfcXm/1nL8kTvQpuRMebyW+sXgegFPwTEv7M0B5JHH8fGd2SJc5jI89FgSBPQh9UmGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 18:38:37 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 18:38:37 +0000
Message-ID: <33674196-4054-c626-4ea8-19797f3679ff@amd.com>
Date: Tue, 10 May 2022 14:38:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/amd/display: Fix incorrectly reading prev_dppclk
Content-Language: en-US
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, praful.swarnakar@amd.com,
 hersenxs.wu@amd.com, alexander.deucher@amd.com
References: <20220510183431.895489-1-Bhawanpreet.Lakha@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220510183431.895489-1-Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3be84e4b-68a5-46c2-9a4d-08da32b44ba2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4057:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4057E7815FEE4444C1EFD0878CC99@DM6PR12MB4057.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlTKlN0XHwfbE1fFyCaiCORbUUYwErc/AzkqyWAgNFE9WQveoo5bhbrnHXC82lyNo+ukmLeYkaffypAEft+AsRp7eTvO2uE7tXCX7zO4kE/yAPGSDDw8EzRy/30axUpO8aN9ByUoXWvR6atBtRDOBYdrv7z//EiAaGYnDeLU1gBKUt8OXLOw80EEhWM/Afp7821Vqje1qO7yv0TY5uTlAMnF3F6a2Q5e5SBkJ2+jnfkZ3o9Sbg1/d2HuiJt8WeFqG17hIuW9AVB843Rw35sxHhIAbbCvZzBWIK+2ogsjuLjU4jyT5FvMxyCS02OwaXiElyCj3SN/X8lsu7WZO3nY2qe0b+1eVWA8RywBTBDWrbON3nakixzuFm5U1VEMwOZMkS+fdeMN5unmXGqL+DSwwxPvzC8F5MzLafePlBwHX66TPsjEmMeC2tzxJOtTwIrb+ibKijUzYx1bzeluTXsmsgAy+TDR04XZ74JSsf3ZCEPtJV13rTADRZQ3gb11qfRoIB6D+7vkYJnlXD+9GNRKdY7d6c75YtnjW52MamujS3HTQ1ZhW6jlZKCTT/oNSamNoNRq/1lfuc2CZn798HKFs9c3qPrvJLoxypYSCSdULzOajKCJCJ9t9DwRHBiPyTxID2m24w4FjUVj0ViyZDFZXimVSradWlOkS5yOLWkLqxkYbFN3wOIlXXcqD6/j6R2iVAl6Asny2xbTEc3ASPjK2pdByj3xc1x1LG/AhB41kbJgAYrw9jgJuBRH2FLs8THL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(6636002)(53546011)(508600001)(31696002)(6506007)(54906003)(316002)(6486002)(6666004)(2906002)(36756003)(38100700002)(186003)(66946007)(83380400001)(26005)(2616005)(5660300002)(6512007)(4326008)(8676002)(44832011)(66556008)(66476007)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVBaN20yaDAxNUdQNENSTk5QQ0xDb1hWQmtKRGtxTFRSWmN6MjkzK3A2RjRX?=
 =?utf-8?B?MEN2ZGJXVXNvdXdXVWxmWC8xVEM5aWlyNVdpS3c5N1FJMHhvL3FkK2o1TUFL?=
 =?utf-8?B?Q25uMlRCZVZteEZBcGNGU2ZkUGgzaU1JVndTSXhyWEI1KzJicjBCaTRjNmt5?=
 =?utf-8?B?V09QeFVXSDBrZnd6dXY2R1QvMEpCc1RtckNEcllxN0ExT21HSXlncDhNeFJL?=
 =?utf-8?B?YnpSeG1FQTJIUDN3Q1hEcjF5b2ttTGJQNlVGV1JSNnc2dUZmQm9uNFJ0dDVZ?=
 =?utf-8?B?OXFxZXN2ZUNnT0hxc3JoMkcybTFBaXZaL3Nuc1pmbEhFaFBMYnloaFVmUTZ3?=
 =?utf-8?B?dTBTa2dhTGhFaVc1QU9JQTRidi94bmhjV0tldEMxNWhsN09hZWR3WUxqVTVK?=
 =?utf-8?B?ZXdmaXNUd09JRmJvRDhCckhCUVNzN3VjdC9CdGhOQ1FZMnpvZjBxcTVIU3VQ?=
 =?utf-8?B?QVY2OE5zOVovNkY5dTRsdDZWZnd2OTVjL25vYVF4ajRnbi82K1MzUHJUVTZS?=
 =?utf-8?B?TFZrUDFHRUFmYlRoUk1PNmU2OUxCUUdmSExmSEpGUFo4a3lBaGtKOVNUL2lH?=
 =?utf-8?B?d2VuckEwV0xzTGIyQllkc1VrYjVlVkYyU1FIMURHMDlLLzdsTHljcUxhVWVx?=
 =?utf-8?B?b0JwZjVpY1NWQzlkbE53MytlOUgxbW9tVUh5WittZFNwZWkreXVoU1h5QVRu?=
 =?utf-8?B?Z3gyallxemp4RlFQUGJLaXRqZkhJanI4N0RiN2w5SS9xRjRLZGhRdlFoK0Ro?=
 =?utf-8?B?bDF2MFJMUlBwVG1WU1VRUWNqaS8xa1FaS3ZIa2luUnhodkllcG1vSlIzSHBt?=
 =?utf-8?B?RVlKY2Q3ays1RkZQSnE0MHJjb1dxSGxnU2s2bUdCUFJveXpkdkh1VXhoWEMx?=
 =?utf-8?B?ekV1Y2tJT25EeldRbXBEU0dXWkpnUDk5cjVOZTJBL1NJUG5kR3FNeWJyREFy?=
 =?utf-8?B?MnJrUDlYbkVUVXo2WTVXbTVFckJuM0Z2VFB4bnB6d3h1WGlDaUJZQnc5SVNq?=
 =?utf-8?B?VzlOR1NrdzBVM3VpVHQxK1VabjQ0RVJxakJnanY5VkR2eUlhZXp6a0hOaWhr?=
 =?utf-8?B?Z2FBeHI0K0llUHhBcmJ0VzJ0cWM3NFJuZWhaZkNhcSt6OEFYT1RHSE05YjZR?=
 =?utf-8?B?Rlo3STYzdlR5VWxidUZvZFRtbk1wQ3B2RmVLVEdFVXVwQjA3eFBNa3V0bm45?=
 =?utf-8?B?aThFYlJrbXBSaW9oRldNUUlNbzF1MjJNVy9FOTR4VWMwcEJzUnVJQytvQkFG?=
 =?utf-8?B?aHNucTRGUytzVytaMjZsQmNud3UrVENvOUVyMnR0L0ZsNkUyQXNmV0tXamV6?=
 =?utf-8?B?MFNxVHNsUks1RmZ2Wm5LdUJyOS9QQTdTNXk2TXBLY21PYWN6dExjbHQyZmFv?=
 =?utf-8?B?dkowUWxWbzE0ZVRJTXA4bUdXMWk0TUhSanRFN3ZTYXZiVEZudWs5R1dacEJK?=
 =?utf-8?B?TGQveElEbEJMWjFSRy9TTmUxUGFhQ09oc1ZOYzRmRU81d0d4ZzRKUFVsVlYr?=
 =?utf-8?B?Slh4NFRHZ2dxWVdvT29SUXdhL2kyeVp0QVY5eElrV0dILzBkc0h1K205THF6?=
 =?utf-8?B?Z2xhNVo1RmZvNW81cGtya3pGdHlZSXRGTkw3UHBPMGljY3duU2ExdWtGUnRP?=
 =?utf-8?B?ZzFKS2k5Z1ViL0VFeEJMOFUzTUx2NkxJcjJxQ3FVMWp2WGh0M3FFS2VGc3NP?=
 =?utf-8?B?NnBSZmFXendCTVlENGloZE1HZ1ErRm1uU3RMRTJSTHdEWTJSbDM5djJaZGtY?=
 =?utf-8?B?amJwR3I2VSttZHh2dHlqbkQ5NXZRUHV5cGtramdxL0lGQTJqVUlwYWpOT29F?=
 =?utf-8?B?MGV5S042SlcyNXBiaG9DNHpUcUZVdnZUQldOM3B6dG5xQm5EZVhSVFBUak5k?=
 =?utf-8?B?L1dyZlVxSXRPZnorOUIrOEdXcjk5U0N3VmtBL29ZeDZ3amNzNGFqOWlVRVdX?=
 =?utf-8?B?RUVBMm5ZL0VFVmtDbStLeVZnQTVVMFpuUFBiYU1EMlhLUEhZTjhya3kyTWlp?=
 =?utf-8?B?WVRhVytOaURsVUVjZGZaNm0xNFBFbGtlNGF5WDVIREtEdElnSTVMeVZTQ1lE?=
 =?utf-8?B?bmxxVy9lZTlSM2JmT3ExK3FFVFNYZUhtWXJDd29QSy9SQTZrN29ZRXJqMGM2?=
 =?utf-8?B?T2VMdmk2S0o1ZXl6ai92NGNyYXdGRkZ3cnlmRllVS1gybEhkam1TSCs5cWZi?=
 =?utf-8?B?eHM5by9QVTlhUnNkbFZob2IwMnRGK0Z3RnpIL2xIaGdoWWdtYUpWek5xaUhO?=
 =?utf-8?B?V0p6dzFRVmpmSU41amp5M1FTZjdjTTRQNGJCRVRIRStzSmgrVVhjb2QyN2JG?=
 =?utf-8?B?aFJzeExPZjQ0ZnlTVTZSRnlQWlVuaVVJcHh5NjRCUm84cCtFaHVBZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be84e4b-68a5-46c2-9a4d-08da32b44ba2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 18:38:37.3152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H10omUCTX35npz3prsLtSYeypL8Z8ogongtULqdzuRLeQ5AbegaGzxQ/GFMc/nZJbyFgXTrT5hQ+WQ/39MuS0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.corp-partner.google.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-05-10 14:34, Bhawanpreet Lakha wrote:
> From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.corp-partner.google.com>
> 
> [Why]
> we save the prev_dppclk value using "dpp_inst" but when reading this
> value we use the index "i". In a case where a pipe is fused off we can
> end up reading the incorrect instance because i != dpp_inst in this
> case.
> 
> [How]
> read the prev_dppclk using dpp_inst instead of i
> 
> Signed-off-by: Bhawanpreet Lakha Bhawanpreet.Lakha@amd.com
> Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> index 02943ca65807..cf1b5f354ae9 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> @@ -122,7 +122,7 @@ static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
>  		dpp_inst = clk_mgr->base.ctx->dc->res_pool->dpps[i]->inst;
>  		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
>  
> -		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[i];
> +		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[dpp_inst];
>  
>  		if (safe_to_lower || prev_dppclk_khz < dppclk_khz)
>  			clk_mgr->dccg->funcs->update_dpp_dto(

