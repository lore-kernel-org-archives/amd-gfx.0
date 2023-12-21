Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F0CC46CD2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 16:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9795510E0E1;
	Thu, 21 Dec 2023 16:39:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC00D10E0E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 16:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGs97drek82uNFWr4VhvHQDZ17H+Qjn1GTl6Eq3j+9Tw2xtfN5jTJTUKBNlkq/3PO6MjqD2QtBaFxAQUe35SEDqpgNfKL6AoBVraNud0h5/T1LpaXMx85Lp7yVstPE8nTv1ed3gywfFdS8MGAc5gN7VVcQLZeowK3Hrna8TaBpQN52TmgRYHQphy0THDn3fNSxLoMdTQZJ65YxJ8pOH5OcU4CWvmM38wersJSTslb91DNTvuLkXKQPDDA6w/j6RzZWaVGNV2ys0Grtskb5ZMJ1yJCNGwskIVIrp/301H5qGhgpyZNJmXHFhIzlMgRV0MpSYFsaxiEYJuEVW3s7QWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgRENTmo1mkvk/JirI8doeMwycveFRK3UANj7/nfAyU=;
 b=oF0q6PKbCV1RuGD4Nmk7mRRnQaxQsYFdk9G0a6WA96mUnmIJoOUhrBpf9PalrySPkigolr4E/RE63n7yjauIP/PPuImuj9GI+UsT2MgmpImSiFvoDvV/MF+/6R4Z7BHGTqD9YoJ9T4T7XEQfrCjGKRdwRPEWArGQr2wjfvK4PWBTOc/QVb8eDQfwd+NXQCLxr6cwcAzYgplUE5OB4f4VcBDtUy10JBduyR3krnw6RMqBoLRDIEn06pCmGZ9Uqlhp8lRSb5hm79b6DbuhheDHBrAPpZrgkmabpR6NoqH1A6hBTB4CNGtdVi4cpDdW3K2byz7Z9RYXkDX/CCXZTFLcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgRENTmo1mkvk/JirI8doeMwycveFRK3UANj7/nfAyU=;
 b=GYJAYYcuRAqtp21cMyNy9TdzDclDANHgVXC/7qkYgQRLa3TGRVnTH8rMcXwPzf/92AMXhRCTBcFev6mgP6PILjuK1gnhCivZzAQlbUPYmX/xiX2OzSoUCustPD+I18IMptvNiqvvwGJLr2HXvWuQUxH79Sj5cqDAOSGsuhjjLZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 16:39:40 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::5f1e:bfb0:43e5:dc81]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::5f1e:bfb0:43e5:dc81%2]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 16:39:40 +0000
Message-ID: <3bc548fc-a9f6-4da9-b0ee-be56749face2@amd.com>
Date: Thu, 21 Dec 2023 09:39:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Address function parameter 'context'
 not described in 'dc_state_rem_all_planes_for_stream' &
 'populate_subvp_cmd_drr_info'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20231219070154.110759-1-srinivasan.shanmugam@amd.com>
 <20231221162841.1382315-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231221162841.1382315-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0883.namprd03.prod.outlook.com
 (2603:10b6:408:13c::18) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 225006f8-100f-4867-20bb-08dc02436d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SL6LyChWJc7B10LYqEH/WcgcbQVoTCQu0Glp1VVLRusOEqOZQlQYeao6R4jcCepFWDwTHgcGc0XqRAJFQshroW78E/EjFfrVSsoO1WCs9uKoqcmmtE+SsBdQ0lEzM7zQtdMcYwCe9uxKdvzacZ8YjVrDz3TWxKFATqh9rMQ3rmVRrHkfFWRh69R/OOTEw7B6L+IM5V0FjyMEDNj0iX4ppJlP58MEL74lxbP2yX5WGoXMM4SO+ElnhqTVrjQu5fmnGhdycc+qVX/33yi/DVwxhqh9ZOWn9a0RpexbqdyWHYst/qlnCZmh5Kgz1nbxg7bMvr6TkyJ4Wl4I1RAxSEpQj6aoTJYUYDL26cnbYBLUnqGx6KusxYUep/Nv4zhLO2x1AS9Jau5Cz54kPfUY8twpXLDyageP9FDp0nCDijtCFEmLUBpOauORSF2/z+SohX17WMPy41fEdZ4pwOXI4LHSKbhc6naE8QJOzmBiX3kxKqBWWUxFOW3GApR5Z6YuwEO3dtAPMZqlr1IyRjs37YgyS+rXX1U//EBZrmMz+qmGgW4rPK58UQDEJUiKmExYWx28kDJuTo2jrlitoj1QssSx3mAp5Dn+1fukSlBSGOyGNZry2q2wfheH3f/5yc7x3oV96aCzJI2C7Dnj3X1/bi0zqnYsZE4VPYP3qHq9s6huf1CvCATm1VPvxcrqbJjMrjal
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(6512007)(2616005)(26005)(6506007)(6666004)(53546011)(5660300002)(4326008)(66556008)(8676002)(110136005)(8936002)(41300700001)(6486002)(66476007)(54906003)(6636002)(66946007)(316002)(478600001)(38100700002)(31696002)(86362001)(36756003)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjVOVHBHZ2g2KzFEdzNVK1NFenl1TmtLQTRPSXBOTThRZE1yMkIrcjBqOWlD?=
 =?utf-8?B?R2hoZHN2aFJCSzhaaVFXdFpyUUtaYXVabUtubE5nTW5yUkp6T3REQ3NFbzAx?=
 =?utf-8?B?Q2NScGs1am1Ld093VFNUOHlveXRUdmREbVBVUzNURUx1TUM5WW5TMklrQjJX?=
 =?utf-8?B?aWp0Wk1Wa0JKMlkrY0M2RENRMFJDQ2FiRmpDekJIdEVKVk8vUEg3QzkzYkxs?=
 =?utf-8?B?ZGtUenVET1lPOXNFa0d5QTRpUVIyNm5UOEliMXowUjFOYXhRbXRuMTB2cmkz?=
 =?utf-8?B?c3p4dVE4NGtJRUFvWlJXVlRDTURlVFRHUm5DV240cGIyakZoSHpFa05YT1ht?=
 =?utf-8?B?WE8xVnlXNHQ0a045bTZ0cU5VLzRZZE9uNTNTSDdheTRUemNOb0FIdVMwVmNH?=
 =?utf-8?B?WjM0VVhyVFkvNlNBbzA2bmJVellDWGJHVHE4VldnaFVKOVpwZFY2S2pBNjNL?=
 =?utf-8?B?cXQrOE1lMVJIeEVYQW1iaTAwR3VhcVExUGhTbWFncGZ0RlNSaTI5aXJ5a1Q0?=
 =?utf-8?B?SXVRM0wxYVdxd2Vldkp4b1d5dmxaQTYyNzVOekNQcjNQdVpIN2ZrQTdTNDh1?=
 =?utf-8?B?cHhROEVuZmRJNWt3bFJmQ0hZNDFXT1hGWFZITWRsQm41cTVaMWlkTE1KbXBO?=
 =?utf-8?B?TzRPTmF1TU9vVUVhWjlpeTAxMkpTblBSWHhYVElVZ3krdWZhWDcrZXc0SXlV?=
 =?utf-8?B?Y05meWwydnFBVWd0aEJXblk4UlEvWDlGWU5DOGYzOHJIbExneE5TQjBsY2Ja?=
 =?utf-8?B?RkswV0d2TWJUbE0xamlMT29ydk40QURUSjJ3ZzlCKzFGOEZwWUtVK1BKU3Ra?=
 =?utf-8?B?MTYzVzBOdUFIdHdLZzhKTUV3bU44YzV1SkNiWjUyNTcveEdseXR0OVNzcld1?=
 =?utf-8?B?NjVNVTYvVk5GbVhGTlFnM25pdjE5cnZHSWdXazMvKzV4d2w2RUZ6Z3cwRmpx?=
 =?utf-8?B?WVNKYW1EZkdZcTgzRkFDWTN3QVNrR2MxbUt2cm1xOWU5aGowS2hZckFnQzZK?=
 =?utf-8?B?Nm8xN2Q4OUlGQXRjeENNSEdKMzZrQXlzdVh4NVU1a1FFdUZ1eVJ4UitlbzYy?=
 =?utf-8?B?OVBJU2NZb25uMzF6TkRRMG5JaHcrZDFCWWV6VVhhcHd4MGFnZlhFcSttalpS?=
 =?utf-8?B?OENMei9LTmxVdnM0MDJiNlg0NnRCWmcxVTVpcVhvcytOTDhiRWZ0Y1NNRGpj?=
 =?utf-8?B?OEtPNUd6cDQrUVQ1ejlyWWF4bzFrcStmTFY2L0o2UHlraWRjdFdTT0F4ektw?=
 =?utf-8?B?YXQxOU5QRVBXeFF3by84ZEMxSDQwVkFrRk9ETFUrMGwveUplb1cxUTh1S2hr?=
 =?utf-8?B?eHhwY0dST3A3aTArK3Z0TWFOeDYrZThUcTEzeWViTzVFUzhiaTlvRzJWV2pl?=
 =?utf-8?B?SWtveUVVamFOWG5LaUFMakVvZDZodU5kMlBFelBCbTRac3QzWUhOY21zSXpw?=
 =?utf-8?B?SCtQQkRwdm1NbTNhU0ZXdWRnUG1xSUg5SExMR1RCdGVLdkUzOUtBQUZGVmNV?=
 =?utf-8?B?ZTVTRWt4cHB3ZEZuSGZnRnJGZlQxa29WM1lWcVlOQmx1SUVXQ3Y0SFhFMHNG?=
 =?utf-8?B?bUViUHQvL0FISkgzcjMrd29uYlk3bEN0dm1QeE9PNzhMM3ZpSThwWERnWGhQ?=
 =?utf-8?B?RmhRaUtkc21od0dIeE5ENVladmpveG10V1BSNlFaL3R3YkptdWVuTEpsS09N?=
 =?utf-8?B?NWNKSjFKdVdmTnhRdkg0UWNZZDhXWlZUa3hsRDhlRW9aVUpidUNLOWFnNUc1?=
 =?utf-8?B?Y3B0S2NyUGxJSklMVW8xRUxaNE4vMG12L3NVU0RnR1ZMWEFtbTBOWVUxQkRN?=
 =?utf-8?B?RVpmbWc2TW5BOGVETUlBUkR2b001VTJ0bmhFM2xpWC8zM1UwN1VrU3JOcTZ2?=
 =?utf-8?B?N3JzQTBxZjNiVXJqY1gvSWloSzJKa2JsYUcreFZXZThNV1BVd3VpYVdZWnNC?=
 =?utf-8?B?c1BVL3V3Q1hIRGhOaUEyb25IWTZaUmdtU0REZVV6di8waWdsNzZHNGc3SGp6?=
 =?utf-8?B?aHdqYXhJa1RMQzFSVU8yN285NWowTEY4RkdnMFZNaW9qdit0WXhMWlpmaFhH?=
 =?utf-8?B?RzVXRmFLeFBQaEpZTUt4WitFZWgyK2pad1czaldlWStKNzZKNVBYQTV6RS9G?=
 =?utf-8?Q?WPZYYsF/DfFov3VclakraBRFB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225006f8-100f-4867-20bb-08dc02436d8a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:39:40.4783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkuuLMoYVBDCinMwYbfGwyb+JtjXx6+Adtj9MhRl/zAoluFWQBlyTwh5RXsR87uc8BA1ap1aRtQ0VD98Y37t6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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
Cc: Dillon Varone <dillon.varone@amd.com>, amd-gfx@lists.freedesktop.org,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <jun.lei@amd.com>,
 Srinath Rao <srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/21/23 09:28, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:524: warning: Function parameter or member 'state' not described in 'dc_state_rem_all_planes_for_stream'
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:524: warning: Excess function parameter 'context' description in 'dc_state_rem_all_planes_for_stream'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:540: warning: Function parameter or member 'context' not described in 'populate_subvp_cmd_drr_info'
> 
> Cc: Dillon Varone <dillon.varone@amd.com>
> Cc: Jun Lei <jun.lei@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinath Rao <srinath.rao@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_state.c | 2 +-
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c   | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> index dd52cab7ecdf..460a8010c79f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> @@ -511,7 +511,7 @@ bool dc_state_remove_plane(
>    *
>    * @dc: Current dc state.
>    * @stream: Target stream, which we want to remove the attached plans.
> - * @context: New context.
> + * @state: context from which the planes are to be removed.
>    *
>    * Return:
>    * Return true if DC was able to remove all planes from the target
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index 1d315f7cdce3..a59b982e99bf 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -519,10 +519,11 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
>   /**
>    * populate_subvp_cmd_drr_info - Helper to populate DRR pipe info for the DMCUB subvp command
>    *
> - * @dc: [in] current dc state
> + * @dc: [in] pointer to dc object
>    * @subvp_pipe: [in] pipe_ctx for the SubVP pipe
>    * @vblank_pipe: [in] pipe_ctx for the DRR pipe
>    * @pipe_data: [in] Pipe data which stores the VBLANK/DRR info
> + * @context: [in] DC state for access to phantom stream
>    *
>    * Populate the DMCUB SubVP command with DRR pipe info. All the information
>    * required for calculating the SubVP + DRR microschedule is populated here.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

