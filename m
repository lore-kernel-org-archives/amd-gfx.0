Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D0DEB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 15:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E7310E056;
	Wed, 14 Jun 2023 15:05:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379AB10E056
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 15:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbUPVq0kvMjKaruoipv0vEGYwbdV4oFBDkzGR/xAtpGoSh0AQqyOLeFDmIkZQwzlH9znaHGP+MH2RzLVHI1F+Lwkq+ZoTR4qdZsm4csGxXRUt+gEoxK3AMtoXcFMg/HnXqijKCBDa2wk6S+tOWlCAAiIYdRIaklnBkUTurjBRQYvqWiufZbVrkBReUeaL/YXN+sx2MQVNMfj+LpHuBBUfz1REPi3p7JvAEDOf+Ds9HYwdVMPkU1tNUUQT2qqmv9n2XTXXSs44B7sajUqt0rv2fbPatqAmaT/hzIXKrn/gqzfcln5bQiYsRGmxK/kLM0vvqDvv6dDYUxRzCGkkqfR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTW8ADQ+bjiG41Iacq0OqAVLv8fAYobgdV1EuT2lxYM=;
 b=clznFB0pM+ECas9F0CVA0gCt85V0j2eQTBGQjizg3GgcYPNLjuaD8cJrH5bN/BdLBJ1Esiuw66DyZeCj1I/DOsQYi6GXHnHD7ZVh668LPRYZCLn37kx3qfDThiVZnYGRqTIAqfXia+MZhKlNgprcP0Mf+7p03v6wzkAtvwHInF33QEUBzjI6x9ANegJcAD4rgaF4Ke7dg5wB7DnZzH1XPAt12dhlYTwT7TzNhh8AcTIs2+eiT7onsWZ27ehYxtyt6Zn88fhNTo4Il4wSA1ZoiwMLstm7agx8MW0lHw2CTskJvdzpoFUVY+nyxFSUweo92mmemwUVplE11EjTDYvkuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTW8ADQ+bjiG41Iacq0OqAVLv8fAYobgdV1EuT2lxYM=;
 b=FAV6Do2fDzyLWSLqAVCN64PJKjqwDqbDpJF+TkgjkajjzR/S9sxzZHW7NzlV1w0GI8pvo+mfCVjaGscyRfRhURZ2vJ4iG+7+irFTnQZcmBGmFYSu6inSlKAkaCp2bi9zgfrzKbbidK04Rlb9nP/XVvz4hATjE3N71flXBIH25e8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH0PR12MB5028.namprd12.prod.outlook.com (2603:10b6:610:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 15:05:36 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 15:05:36 +0000
Message-ID: <7491c79a-dd54-925b-3f3b-574991dd2c1d@amd.com>
Date: Wed, 14 Jun 2023 09:05:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Convert to kdoc formats in dc/core/dc.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230614012103.2866603-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230614012103.2866603-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::31) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CH0PR12MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 825ae9de-564c-44ec-2285-08db6ce8cf0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liD6M+1hvimvznYLEE+cmuy8aKb+KV9NY645SXe2ZR5lxHpGXuTbnTa/26rHA5mAkuNxZOSsLwzN+8oUNM+l5RqE/VxUls4lciuol7y/Q8cfIEyyd/GmhAzDlbF0U1f47PMsR0NQQvgihwy4G6sMq7S3wzbCc/evd7rcBYchOKmKhEP6u9cIP2K/8EkYFIEDEOmsvs+uXWfp0b/sAUAE/1Sbm/lvoR3nzyxXFPehg0zDxcwX6qeE4EtzKqgMPVWC6hgtiyrXU7hM4Ms6oJLUmOLEO6VGSThcqkOXuBwVMOPRsydazN7Uy8eFWDftLqd5qwc6iE4o7XJN7lELZOM6rHq7bZuOQNuu4bm2XywS7TvYhYX/PyChLnstYrj8t6yZpO6k8Z0UHg6PxVTIpzJ8vEHAQZY4Cx5j3zMf0x2g1/z5CQ+jQBmpH93zFDZYGz5sdeDlvyQuDY8hhWZUXSGjS/8jRKX8JIEchDYGi8l9g4d2iL/3cT4YkaVZ1y3+4sVEcKMi+21m+QO5tqibMe8dwTGQNp0KLoe3V+Mg+g6p95N7kzuAorSdtyiFs9wqZZgXHqR2yZAfDXorvZwLtOdP8YvqZqEHHY7iUQRBT1TSKAtiW4153XAz/JnZLKCk0mFgEFH4hg5EHiwrY+MwrFWBkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(31696002)(38100700002)(8676002)(8936002)(5660300002)(31686004)(41300700001)(66556008)(66476007)(478600001)(4326008)(6636002)(6486002)(316002)(66946007)(6666004)(53546011)(186003)(110136005)(6512007)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlNFODFUbUUwdXlldG5YcE9FWHY3UU4xZjdSWWZIM0xtaWdvamdNVGFreURl?=
 =?utf-8?B?SHhTMDUrRk4vMXNZS01rWDRvN2t1Um42dXRjR1owcWFmNE85UlhaTkJRQ3Vx?=
 =?utf-8?B?Vk14eUh4UHEvOE5zMy9TZFlBUVFYaHhLbTRyRmk4THFneGhlRG1XcXVEYWVx?=
 =?utf-8?B?Z2FhSy9YYXlpZzR0cGcvRm1uVDdGQmExOEU3bm82blFNM2pxeEViMWRkK0FN?=
 =?utf-8?B?Tm9GeFh0eXprYk1RUlBMbFVicmFyUFVrU3E5K2lKM1FDNFVrUGlnOHlUaUNE?=
 =?utf-8?B?S2ptV2IvZTBCNDh6T1ZSMEVhdjlRQjRmZlB6Yzg4Z2xKRGdadTdHQ2lRc2N6?=
 =?utf-8?B?ZmxMM0RjdnJIMWVlTS96MUlxMldOKzlDblBkQURtdUUwOGZhMEZUbUlTUG9t?=
 =?utf-8?B?UmFnMFRGVTZEb1o3ck9LcnZzUGxwZ2tRcEo3VC90T1o1Um9hU2h0VG5IcDlQ?=
 =?utf-8?B?QWhOTmh2c29qQzl3VTNzQ0JsVGVmd0VudEZsWlVzOHNGMStSSFZIR2NoV1cy?=
 =?utf-8?B?MW1XaWdYZndOaEF2NmNyeitpSDlEcE5pQ2l5K2dFL0pnc2RRR1o5dzJ3dFZY?=
 =?utf-8?B?WDF5cm9GenNsZ0ttdkdMUXlCVHRuWjRGOWJHc0ZHSE1GSXpoQ3ZtQ3crelYw?=
 =?utf-8?B?Q1owMkpMNjhURHVkdjNYTUtiQ0Q0Z0s5MWRNVHJxWnpkbnRhaFRJZ1lZWkMw?=
 =?utf-8?B?TWZiU1ViUTQzQUFadEFDSXN4UHp0RDBYZkZxSXlpMm5RN1E5SC9maHF3MzJN?=
 =?utf-8?B?bXUyTnRrSTVzNGxOUVZUTHhOMDZPSG45d0NwMW1Od0I4eE1PU2NNcUhJTVlN?=
 =?utf-8?B?VWVQNW9RbXdnaS9NSzBOTmt0aWxIc1VTYXp4SGhFa0w3ZTFtNnNOWDlEMUJX?=
 =?utf-8?B?aDd3SjYwSGVJSTd2cGwzQlAwSjZMZGx2UE5FUVlCV1NqRWNPVVJnVSs4M1pD?=
 =?utf-8?B?MHUzSlRISENvcFZnZW0rbEg3ekxyRDV6cXFaakhNRnJEWkN5SUFRODhYSkMr?=
 =?utf-8?B?QVdHTjVWTzMrdXl6N0R6WEdGTnNkMGhGM0F0U2I4Uk5zdXNoeWEycjFvNG5j?=
 =?utf-8?B?L2ZjY1Z1RW1Nb2U4TXRHWkNiNDR4bkZJdXZxcDlOTkFZVW9QSjd6bmRvQkpj?=
 =?utf-8?B?UzFZUThkYmp4WEpyMDZ2Q2RzeHZBbzV6azJsUTZtVTNIZ3VkY1oyOXBmMUlG?=
 =?utf-8?B?UURGRW50S3Y4ZEtRakt4dnkycFozcVpUcGllT1RIZ0xqVEJmTkNkRGlhMUpz?=
 =?utf-8?B?enQ0aWErSVRGL0ROZlRYUkVid2hmNXZvV21vSXVhZklpdnlOS1Y5aG45c0Nr?=
 =?utf-8?B?M3ZxblhqQXA0TGcrWmhMUnFVL004WGVhZ3VjU3BHQk1ZcURsRTIzeWRYVmww?=
 =?utf-8?B?ZEtpa2U5M3czOGNpUW1jSVFERWI3QjY3amhxbGhDTzZGU0VXSEtsQkV1SCtB?=
 =?utf-8?B?YmhicXcyWDBmQTRDdkV2VDZVK3VJVEJaR3hzUkxBcHh6RUM0aVF0Z0lGSzI4?=
 =?utf-8?B?MUZKdUZxSEZSRm1vVysyeVQ0RFkxRTByQWlYRVlBM3AyN1BBVTF4b0dnbm50?=
 =?utf-8?B?R3dhOHpYT1BXQXBDczUrMmRlVFlaMWM0d0E3d2hhWXBtbXRkUzczSExkcFNX?=
 =?utf-8?B?ZGsvMFNuOE43RVpnSEF1TmRBRCtianplbm1FdjZIVVFiTEJ6bmFXWEhXSkd3?=
 =?utf-8?B?V0NvZ3FNNEFSQStaSHRCcEJkSkM2U1dORURvWk1MM2JyQlR3ZjRYYm1JT3Vo?=
 =?utf-8?B?VC9Ea3FneElmQTU3bkhFNEFoUWR6a1ZWNHRUV3NlMXBkOXZqYmhoUk5SS1Fq?=
 =?utf-8?B?OGFIRjdLMXo4RW9wMm80UXNySWJCMDJLSFRFcUVxWlRBU0Uzem1RbUZNNTJr?=
 =?utf-8?B?UkVyMFE3WCtFeVJpZmFhNERWN2locGtld3hKWkV4YmxGa1ZndmozWWtNVC9n?=
 =?utf-8?B?T3VoS2RWakJ0aUhCamZXeHE2ZTZVeGIzcW80ME1ReTNSWGNzZXhuUFhRK3hq?=
 =?utf-8?B?ZElNQ3BWdDZFQmsxMEgwWUdLV1JUVzJmdUJpZlh3VkZYWnovdGxkN1JuTWVN?=
 =?utf-8?B?SnBoZXJQQmk5QWNHVHZoYW14anQwdWtZZlFva0JtcFNQVGo4S2kyMktib00x?=
 =?utf-8?B?SG1sZWthSEF3RWdtUitzQ3NEZUxtenNKSEhMRCt2N0t0Zk1WT0hPTFh2K1Zz?=
 =?utf-8?Q?Desv9/FX3XpdcYYDTC9IvID70oehu4sHW93QSCa12nZd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825ae9de-564c-44ec-2285-08db6ce8cf0d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 15:05:36.6740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7z27YlDx1Neg4m565NFBCK6zCk2VyC2hE51CFy5bSsfuHpCaCK6GefUb76nA06bRxlHpns+cF2qpGiUxR5B7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5028
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/13/23 19:21, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3483: warning: Cannot understand  * *******************************************************************************
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4204: warning: Cannot understand  * *******************************************************************************
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 34 +++++++++++-------------
>   1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 5d3d61faeb28..e6bd20dbfc0a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3480,23 +3480,21 @@ static void build_dmub_update_dirty_rect(
>   
>   
>   /**
> - * ************************************************************************************************
> - * build_dmub_cmd_list: Build an array of DMCUB commands to be sent to DMCUB
> + * build_dmub_cmd_list() - Build an array of DMCUB commands to be sent to DMCUB
>    *
> - * @param [in]: dc: Current DC state
> - * @param [in]: srf_updates: Array of surface updates
> - * @param [in]: surface_count: Number of surfaces that have an updated
> - * @param [in]: stream: Correponding stream to be updated in the current flip
> - * @param [in]: context: New DC state to be programmed
> + * @dc: Current DC state
> + * @srf_updates: Array of surface updates
> + * @surface_count: Number of surfaces that have an updated
> + * @stream: Corresponding stream to be updated in the current flip
> + * @context: New DC state to be programmed
>    *
> - * @param [out]: dc_dmub_cmd: Array of DMCUB commands to be sent to DMCUB
> - * @param [out]: dmub_cmd_count: Count indicating the number of DMCUB commands in dc_dmub_cmd array
> + * @dc_dmub_cmd: Array of DMCUB commands to be sent to DMCUB
> + * @dmub_cmd_count: Count indicating the number of DMCUB commands in dc_dmub_cmd array
>    *
>    * This function builds an array of DMCUB commands to be sent to DMCUB. This function is required
>    * to build an array of commands and have them sent while the OTG lock is acquired.
>    *
> - * @return: void
> - * ************************************************************************************************
> + * Return: void
>    */
>   static void build_dmub_cmd_list(struct dc *dc,
>   		struct dc_surface_update *srf_updates,
> @@ -4201,20 +4199,18 @@ static bool commit_minimal_transition_state(struct dc *dc,
>   }
>   
>   /**
> - * *******************************************************************************
> - * update_seamless_boot_flags: Helper function for updating seamless boot flags
> + * update_seamless_boot_flags() - Helper function for updating seamless boot flags
>    *
> - * @param [in]: dc: Current DC state
> - * @param [in]: context: New DC state to be programmed
> - * @param [in]: surface_count: Number of surfaces that have an updated
> - * @param [in]: stream: Correponding stream to be updated in the current flip
> + * @dc: Current DC state
> + * @context: New DC state to be programmed
> + * @surface_count: Number of surfaces that have an updated
> + * @stream: Corresponding stream to be updated in the current flip
>    *
>    * Updating seamless boot flags do not need to be part of the commit sequence. This
>    * helper function will update the seamless boot flags on each flip (if required)
>    * outside of the HW commit sequence (fast or slow).
>    *
> - * @return: void
> - * *******************************************************************************
> + * Return: void
>    */
>   static void update_seamless_boot_flags(struct dc *dc,
>   		struct dc_state *context,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

