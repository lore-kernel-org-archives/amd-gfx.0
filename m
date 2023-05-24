Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C405C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 16:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC3C10E375;
	Wed, 24 May 2023 16:30:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F2910E375
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 16:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqVvRZ//+Ko3qfiKG3uQG74YN7SN7tI1Rsq1RpiOQajtvsH/y+ogJiwUf6VOlGu4LhiNnqTJg9HE0uiPH2wB9nje4lUiPQzP0nfxFTV/0zcJRR4uAr3k2LHAp2r8sVyTEfIMtBV7rX6yf6F4NIqe4Oep6S2/RXZVTjiuNOxnJCgtQLj9PAH6AlreFh9rGfs8aOhxai94QgZJNb5MeuEQ6pkAKZf1CRxD19i96o7Oo4nlqNHwOqObyMaAvaERjFDqoKA84yr0uPdEdkM6eDXWlgLxd5nHI4xlY2wNImsG96JaLjbrMks7Ff1pGTkhVve7mUAhLczI2JbdIMqtSHLiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4nvpIsLVwCmAy97KuhyXjOAUX1AzWCj5Qwkwd/piAQ=;
 b=Yyd8t1FRU0peC61gfatU/l2h83eBlYf5zFTXZHfbxRhz53VJYBccbqtYSr5E50eoE3rT786VW4rimbaGYo3xALD+l8c5ybV5sAExSWgIUXKtPFcKLvpmYMfsi4lGC6nt9vK+b60pCoJl1MjM7Q6dQHAwEHvqObG3I2WOMiikXK6CM2RSiuoDYmZPhnkFQOG4WXPgszpQh+h/psioCdufTA98aXmAVsvJhnNpe0sG33MHSkBt3g3alJ+BlYiK8n+pa8yqD3ahnG+kf5VUGspuUHqkJKGOHyKa0WPowtyzFMvIaO5Ok5HS6TGHIkToXnn+FrGz/5//90l0W0aLxsAoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4nvpIsLVwCmAy97KuhyXjOAUX1AzWCj5Qwkwd/piAQ=;
 b=W9LPy5VH8eE7b3RY3GFI57H11LMR/xHttEcXe6HLAkI0WDpH7vuXc9sQK7B7XC3fi0O3kaIMplJMTCvVLCzOlIoNNU8tsfsknEVZSUqxHh+rGCFHvDUXPW6J1FLfqzM3cEaj6nNAJCaBBXUdW9qNZCQPT29Wfro0mhYawyBh7kA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15; Wed, 24 May 2023 16:30:34 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 16:30:34 +0000
Message-ID: <a41a5f77-2f7e-8af1-d445-8f5a1ac94837@amd.com>
Date: Wed, 24 May 2023 12:30:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Drop unused res_create_maximus_funcs &
 debug_defaults_diags variables
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230524161957.3672412-1-srinivasan.shanmugam@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230524161957.3672412-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::15) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|CH0PR12MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed877b1-5806-4b8a-f3b5-08db5c743296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xs8S0zAkEddUXe+0V4pX4TH5UhXT1zItoXzabphFap9j9qUDMYc+jfzES4BP0Vh68vTQnYNd94AY2XiY+bKyX6smUQsFfF7gsBQv3A+zE9cwPovO1PV4BmfBbd79L5OcSR70L+3Ix9cCbEAgNHc9QCntfyKZpoOILfkRXvdxLkkEyBluA5wyHpiMdLCjNWJSXN3yPbGG/3tIPxp4i36SPSPGyK2oTq/XoAkE+IVaoyInoHcmYlyK4GhcZI/NkRQ/nzKBbAJGT22j1sIlW2cezFIeEQRW0M5a+8oyGVpFP8me+ajKaVJ/iMCs0HbcVDtYc2mT/AUiGTRdUWfEp7N7uvqBrQRNVsaO3VG7eEFllHjDbfgkabR8v+X1s49bl3Vy1bwCKUk8b/3pnD7XN99Mhd/FTLwnnVb1XrnjTyXuNPwlrPvJa4OVuLs3hHJRqGA0Cf26/uSVF7l/ZGsYNIML7r/g/Jme2kdF1B1tgFKTnDq/nYTYyrULOILeOm0LyfH0rJRcYCMxBb9/ITlyx8HBmvdQyGDwQKszE+iaQ3UM5X9RAfLuzIUf4SfO8Is74I3Ru5qEzRDRltNy2w5cdHQaRL5LYaNCw63cNGD9R6sY+mVQcCubaLXCKF8eluxy06ZVFxezzXKAHV+Bt8mMmhi7yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(6666004)(4326008)(478600001)(53546011)(110136005)(316002)(41300700001)(66476007)(66556008)(6636002)(31686004)(66946007)(6486002)(38100700002)(5660300002)(8936002)(8676002)(83380400001)(2616005)(26005)(44832011)(6506007)(6512007)(2906002)(186003)(36756003)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjUvdGRSRGZISCtTaXFxUFB2SDYwSTVmazdIUmFxdlRtWjhOL081eE9NNy96?=
 =?utf-8?B?NkFDSlRqNndtRmpsa3E5Z245T3h1NXRISmdMKzE3WkZKOW14dGpDL2ZNa0d4?=
 =?utf-8?B?R04xOGhNcERLV1laMkY2amx5S1A1M1owdjNFdmc0bjR2bElTUGxzYWZSbkpP?=
 =?utf-8?B?MFdQdDZmbm4xQ2syem5PTmI4cG9nU1BLL1ZBRWF6UmNjMnE0QlgzV3RpYTRr?=
 =?utf-8?B?UytGTDNqUE9KSEF3NkppVnJWSnI2cXNrc2xlNlhwMmtlRG0rb3lxS3M3emdm?=
 =?utf-8?B?VkJka0U1ZFphV0EyVzNDUlFNamhRMVN6TFJlaU5xcXpvblNLejlQa1o4blQz?=
 =?utf-8?B?Q1BNTU1Od3dTb3cvNys3NGJvdld0Wmd5dnN6akhFVFlzQ1pVSUtVMzJGZHhi?=
 =?utf-8?B?TzZDS3FaM1FIY1psTFpjempCNnBsdkxiS2dyTVQ2a1JhY3JCUDFLY1FlUnly?=
 =?utf-8?B?eXh3SnFDcyt3M29YcFQreDZYZFNiZ0RFSVNTaUo1ak5ac3BoZi9nK01ya3pB?=
 =?utf-8?B?L1RpdEk4VWk0MVNJcEhWTU50RnJTSjV3Q2piZk5qWkxEbjhHdi82REFqeTY0?=
 =?utf-8?B?clNhSGdZYlhPWC94eFRaRDk3SnNLR1JkcEZaYkdqMzY5MTFiM21PaU9KWlc0?=
 =?utf-8?B?bzlLT0o0QzI2OHBpRTFhYThtNlkveDNlQy9DYVdMZS9XblBXeXAxZkd2V1Mz?=
 =?utf-8?B?dEpnNW9IVXMwQlZGTmgwdHlveTBJVmFJS3FraklNYlZqNjdMTFFNSk1qTHdD?=
 =?utf-8?B?VnA1VVMrK25UeDdYV3JXSE1kb09CVURXREhmWVJpemowZkJzTlo1K3l4VnZz?=
 =?utf-8?B?eVRLZU1ydGlrdkQ3SndnYlJ0eFdFU0RRejZPV0lXK2NnKzhvZ2lIMEZOanh3?=
 =?utf-8?B?Rjc1M1VEclhpVGZSME1rRjZmWWczTlhCUkUrNC9OaFJIdmx1a0x4OG8yTUpK?=
 =?utf-8?B?VE5CRmo1UXBzTGRQMk50cUk2YWdwQmEvKzdGOENNQlRnZ0psQVVSUWlONEJJ?=
 =?utf-8?B?VnhLNUE3MFdHclFWUDZ4OUxWMGMrVTFVRDJHR3NidE1ldmswRWxlYXhUeGhC?=
 =?utf-8?B?ZDRwK0RWenlFeHVYeTB1d2V6dEd4ZWkvUUh2Zm8vODZuR3BPdGF5d2VUWWZJ?=
 =?utf-8?B?UDlUZXU4aXpuK1AyRFFKZjB6NVp4OFV4aUNwbHZsMis1T3NkRnlUZ1kxejVJ?=
 =?utf-8?B?RWhlbjR4d0ROQ1M0TzVXbFZFYXFVVi92cGh0eENwSUJEOU0rMW5OM2tlNXk5?=
 =?utf-8?B?UHh3QTZ3bzlXem11RDlvOVdCczl1VThkRzBqQkZTdkJjU0owY3o0RExDaU5V?=
 =?utf-8?B?VzZLVU5aT1l1U1gxWkdTOUFNQk8yLzhrRDUreDN0Y045V0NNMWM0SmQrVzZD?=
 =?utf-8?B?SjlJVDFRRzdEODhrMkMvMUhERUNXcXZhOVlTZjI5SkxWZ2xSd0JtMGltZHA0?=
 =?utf-8?B?amJuNnBscXBhdjU5MTZsc05WM0RoSllaV0tuelk4VmVxd1R6T3R3QzQ4KzEr?=
 =?utf-8?B?QWNNelRJeEx2OE5GYjRBajUrL2x5N1RoeDMwU3BucTg0QTlnbFIzcmJucEMz?=
 =?utf-8?B?SzJxaURlUTRQOGRJdzlNSTBUZDVBcjlIZjRHZk0yVElzV005T0tJdEtEWGQ4?=
 =?utf-8?B?NFNuWXpsajloMVdYbTd1L0M2MXZUNzlJT3BOaHQzSjBqd2JqVnRmOTI2T1BP?=
 =?utf-8?B?dE5oTzFzSG53eDdFZ2NTVEJIL0JoOFJtNkpCWEJDU2JxRGsrVkk3dkpTVHg1?=
 =?utf-8?B?dTRIMDEyOXdLUCs3T3hGb3NqUm1UNkMwbEUxNEdQdjhjeU1wT1BmcVIxT2Nz?=
 =?utf-8?B?V01OZzQ0b3RHVXQyYlFwTVVDUVdCU2o1RXk4M3I0RzlWQTFKbW9nWnlFd0F4?=
 =?utf-8?B?RHdxc0VhbUtFZE1oRUtOdENQQ2I2ajRhRGFuNWtFejMvZ1FJODh2Q0g3Vm1P?=
 =?utf-8?B?YXE5SFpsVlUvOU1QOWJyT25TNmlkTU1McU1jbDF5M1lMNUFWRTlMU2M0b1BT?=
 =?utf-8?B?QWpjdjdlNUlSUForNS9Sc1hURWNkRm9jWEZaZmd5a1MzMklnUCt4T1hoTllB?=
 =?utf-8?B?QlRoRmk0RStRU2g5ZEZhRUpQOUhYajRQOTNWQ0RkTlI4ZG1SeHhTL01DelRv?=
 =?utf-8?Q?YcmApJF8NILox98L7xWj6EuQd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed877b1-5806-4b8a-f3b5-08db5c743296
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 16:30:33.9707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWgeqZKe7NfdtTSRYsJJWVFQhIvfirRJqY9yGXGRyKncpAUwVKY1VgjtCIr/r3eR8JUSMCB1OgAJ9VW6myo3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5283
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

On 5/24/23 12:19, Srinivasan Shanmugam wrote:
> gcc with W=1
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:1346:43: warning: ‘res_create_maximus_funcs’ defined but not used [-Wunused-const-variable=]
>   1346 | static const struct resource_create_funcs res_create_maximus_funcs = {
>        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn321/dcn321_resource.c:735:38: warning: ‘debug_defaults_diags’ defined but not used [-Wunused-const-variable=]
>    735 | static const struct dc_debug_options debug_defaults_diags = {
>        |                                      ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1360:43: warning: ‘res_create_maximus_funcs’ defined but not used [-Wunused-const-variable=]
>   1360 | static const struct resource_create_funcs res_create_maximus_funcs = {
>        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:737:38: warning: ‘debug_defaults_diags’ defined but not used [-Wunused-const-variable=]
>    737 | static const struct dc_debug_options debug_defaults_diags = {
>        |
> 
> These variables are not used so removed them.
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

There is already a series queued that addresses this issue.

> ---
>   .../drm/amd/display/dc/dcn32/dcn32_resource.c | 29 ------------------
>   .../amd/display/dc/dcn321/dcn321_resource.c   | 30 -------------------
>   2 files changed, 59 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index 33abc8c9d4be..2e6b39fe2613 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -734,26 +734,6 @@ static const struct dc_debug_options debug_defaults_drv = {
>   	.fpo_vactive_max_blank_us = 1000,
>   };
>   
> -static const struct dc_debug_options debug_defaults_diags = {
> -	.disable_dmcu = true,
> -	.force_abm_enable = false,
> -	.timing_trace = true,
> -	.clock_trace = true,
> -	.disable_dpp_power_gate = true,
> -	.disable_hubp_power_gate = true,
> -	.disable_dsc_power_gate = true,
> -	.disable_clock_gate = true,
> -	.disable_pplib_clock_request = true,
> -	.disable_pplib_wm_range = true,
> -	.disable_stutter = false,
> -	.scl_reset_length10 = true,
> -	.dwb_fi_phase = -1, // -1 = disable
> -	.dmub_command_table = true,
> -	.enable_tri_buf = true,
> -	.use_max_lb = true,
> -	.force_disable_subvp = true
> -};
> -
>   static struct dce_aux *dcn32_aux_engine_create(
>   	struct dc_context *ctx,
>   	uint32_t inst)
> @@ -1357,15 +1337,6 @@ static const struct resource_create_funcs res_create_funcs = {
>   	.create_hwseq = dcn32_hwseq_create,
>   };
>   
> -static const struct resource_create_funcs res_create_maximus_funcs = {
> -	.read_dce_straps = NULL,
> -	.create_audio = NULL,
> -	.create_stream_encoder = NULL,
> -	.create_hpo_dp_stream_encoder = dcn32_hpo_dp_stream_encoder_create,
> -	.create_hpo_dp_link_encoder = dcn32_hpo_dp_link_encoder_create,
> -	.create_hwseq = dcn32_hwseq_create,
> -};
> -
>   static void dcn32_resource_destruct(struct dcn32_resource_pool *pool)
>   {
>   	unsigned int i;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> index af0bb3e94250..bbcd3579fea6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> @@ -732,27 +732,6 @@ static const struct dc_debug_options debug_defaults_drv = {
>   	.fpo_vactive_max_blank_us = 1000,
>   };
>   
> -static const struct dc_debug_options debug_defaults_diags = {
> -	.disable_dmcu = true,
> -	.force_abm_enable = false,
> -	.timing_trace = true,
> -	.clock_trace = true,
> -	.disable_dpp_power_gate = true,
> -	.disable_hubp_power_gate = true,
> -	.disable_dsc_power_gate = true,
> -	.disable_clock_gate = true,
> -	.disable_pplib_clock_request = true,
> -	.disable_pplib_wm_range = true,
> -	.disable_stutter = false,
> -	.scl_reset_length10 = true,
> -	.dwb_fi_phase = -1, // -1 = disable
> -	.dmub_command_table = true,
> -	.enable_tri_buf = true,
> -	.use_max_lb = true,
> -	.force_disable_subvp = true,
> -};
> -
> -
>   static struct dce_aux *dcn321_aux_engine_create(
>   	struct dc_context *ctx,
>   	uint32_t inst)
> @@ -1343,15 +1322,6 @@ static const struct resource_create_funcs res_create_funcs = {
>   	.create_hwseq = dcn321_hwseq_create,
>   };
>   
> -static const struct resource_create_funcs res_create_maximus_funcs = {
> -	.read_dce_straps = NULL,
> -	.create_audio = NULL,
> -	.create_stream_encoder = NULL,
> -	.create_hpo_dp_stream_encoder = dcn321_hpo_dp_stream_encoder_create,
> -	.create_hpo_dp_link_encoder = dcn321_hpo_dp_link_encoder_create,
> -	.create_hwseq = dcn321_hwseq_create,
> -};
> -
>   static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
>   {
>   	unsigned int i;
-- 
Hamza

