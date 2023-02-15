Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B72C636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 22:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4098410E0C2;
	Wed, 15 Feb 2023 22:36:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB72910E0C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 22:36:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk2NmH34AZ5Z8nyQdktfGk0YhWjhEl6osVymPPNzkEhZI8lUIbhH5OJdD5Sw7BHoEO51CWDZJqwvaSAtxfbjVfkROWOtWNROD/UbgOYJu0BPEoeSwh4Wj2C91nU6BNNCOiS1dRHUft0RlEuTz6JDrPTG7M3+trfp18GT8CDIfuQoQl633Y15xBXYlG9smWESypyKkk8+Cvv5RIFIbjhKzCT39GWzcIDrHzO74x9Pkpdnx8j7zf6Qi+eZm0QuMg9PGFftHHDcQK68kpGX47Ee5lPeBjLp85krLqmoSeQqKQgAyr2s5CEqoci+Rsvt7rXW62dURMNUa4AZ/0wkTUgTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mE86YBdLn+eQNHFtWFzhlGuOLbdSEeE1Ub85hnv9syA=;
 b=dfm7R8/qt11F4ZEUp8P+BDSQOWnZGY4x+YIjfVl1FTwEvQCis7Wo6UWSlx229Q8hNE9cp2TWuY9lfDroxiydFXCIl9bWZC+972KcZoo4B6YxLimvpMvFK83ZCx3wWOqlQvdcmsXEzU86emOAMKMbgpU68vtsWJnv7qexPb8OrXS9Fc9w/7U2EvAumLC2C/J9DD2y1ZBabO7kDfifsX68OsiU+GE5+pY4y7hb+L8So25DAvAMDN2V1PlmdqAo+ZyaA4nQ8GT0+dJStAqx9Lwa+p9QUdiOFz1YIogxWROJsEnxR3LUlC62TVMYpv0OZWZY31gpC0R0HPCBA8OhRvd0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE86YBdLn+eQNHFtWFzhlGuOLbdSEeE1Ub85hnv9syA=;
 b=W0itwAShrqLj96xlGmsqjgSOGr2BoieM0qH/QKnmvmaeObzj0sdCJq6e8Gfb8dutr8lbHdg5qp9oQL/t++tr8YXfbTu9rUS8+TABmfI2KhWGKJtNPXzuYutP6tg5Ttc0Tdivc1je8JraR9hYYzonEji/RmVpXsKhoV6x9EHHsVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 22:36:00 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::699d:42b8:93ed:76da]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::699d:42b8:93ed:76da%4]) with mapi id 15.20.6111.012; Wed, 15 Feb 2023
 22:36:00 +0000
Message-ID: <b4b995b7-d72f-e1f9-2639-5a31237527de@amd.com>
Date: Wed, 15 Feb 2023 17:37:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] drm/amd/display: disable SubVP + DRR to prevent underflow
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230215215936.2009032-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230215215936.2009032-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 770b30cb-fbcd-4f79-2739-08db0fa50362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BoCRa4D4//SD/ggOJrC7FNigDiTcdH1qL0ymBawXWFGBCsWi2ouKbhBRjhTmQdCGRXH/+6zdoy0c0I8LsPA1gVQidNGILm/OWKRO6NskGE4B33tAwK+muOopbuZHrewuror4d14AJH+/2L4tukrRdOtzNM6bTHyZUJfuC26DQzs5Fdi3/KmsYBnFgP146QqdpBYRdUsQO+DyOHkCTKdWte4bJGXtMNHZhCa99b+aHT5O0f9zR49rkHi7W4gvAIE6YxlCkDcKCcVMxExN2R6/fUMf+Bv+wMLflQvlzESZrBdaqvDlDzHM7V5ZpOWVVYue0E8IwflXn01vc4/kY/rvrlSV+A+btaqZILg9z+MsjezgsrlO4Twnvf+j2XwHVQbwukioXal/rRgDs4hCFaIlHzY0ZQ6kh1GnxeB1KLvU3y1+detmuPbikBsO607EEXDLHULbFgqBEfTsijsR1EUtuZDVCud1s4igQKx/NhCWXmGe7RHnLmQSc5XtoefdYCAJp1S3wQo3Y2XPUy7Oly9OE47MqR6mWVuq2do5hhXtSkxmIk8tQePoesCphfdlouHezkpxHDwNzQdghx1X+lRGQEY8qfJMe2hXcNNunOIb+6QsCch05bKj0vdbIaHE5DBAPMICtoLoM4+3NCVR3udcNNvnvotqnVJ0m15TfxYrh50rB73KmopZaZPC2+HFa4JlzJgdqcnWWXwm02TYUbEGzWcD7G1A6j3LdmLlr5TUgyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199018)(478600001)(186003)(316002)(6486002)(2616005)(53546011)(83380400001)(6666004)(36756003)(6506007)(6512007)(2906002)(31696002)(8936002)(86362001)(38100700002)(8676002)(31686004)(5660300002)(41300700001)(66946007)(4326008)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzN1MHcwWGhSS0NTUHg4TVkrWG9oSFhRS2wvVkU1N2xUR1lmSzhKZjBEOVdy?=
 =?utf-8?B?My82WEFoVW1Wb3RnRFVLV1kxZ2VBamZrMThXWXVTWVVlRWhJNXZybnhOd0pj?=
 =?utf-8?B?QlQ5a0lJc3dWWFROcWVCNk82V2NSMVNjWkRkdlRFeW54UGhDc2t0OEVyMlcr?=
 =?utf-8?B?YTlGOWliL2s1T1BwSUloMTJmQUlQck56OU5uSFBjbEN0NThGRnFTNXpCZ1RM?=
 =?utf-8?B?dVBXaC9vUklEem0wSFBqVlpTN3R4MHM3UDZQQW1sQjNPeDVkYmJUMzNjejht?=
 =?utf-8?B?c1B0ZlZRQjh4QlJHQ0dnUFA2a3hSd1dFUmQ1akNhWnprcVk4Rmw3Z3p5VDN3?=
 =?utf-8?B?aUpYaHZZekE0UUFDNXJNa1lwclowTmFZME1VYk51aHE0TDhDT1VYUGsrRllj?=
 =?utf-8?B?QXhVM0F1YzhOMDdNVzNGUWdCSlRRSDlwOTZBeEdYQ2duUzh3VVVxa1FiN2J5?=
 =?utf-8?B?K2YxcXB6ei9XRG5YNU5qUHNhc1RpL2dUUG80MFIvMEN6SUpibmdBRHpEdDlZ?=
 =?utf-8?B?ZEpaMXUrclloUkxJOUtqazJXTklEaXJXLzN2aEY1cE55RmNqOTRiK3R5cjdr?=
 =?utf-8?B?UXpYWTcwSDRJTkFzWGpXc2lsVDEyK1ltcG4velRTVjlnVFlMQzVObGZCQXRO?=
 =?utf-8?B?OThta3oxZC9LeTZCMmE0VGtkQUNrNi9DdXUrcE01RUIwaUJNY0FTTEluOFJ1?=
 =?utf-8?B?TzZwd1g4YktRREtVTCtCSFNnTEoyT3JsSDRnWEdSbGZGT3VyVHEwVFBqRWtt?=
 =?utf-8?B?R3RYUk8xdTY2Y1lPMVpKUFpEWXVUSHVYVzI2MktUTytFMHhpaWNjc3pNMEkr?=
 =?utf-8?B?QXZFYnM3Z2hBYndZRnFHR3JIOGkvL1pvOHp6cXdXT2QvZHU5SlptT3Z2S3JW?=
 =?utf-8?B?bWJydUd4QnVmQXcyTjVROTRWL2VPK3lWRkVpNS9MS3RjMlZnZmNnZlcrOGwv?=
 =?utf-8?B?ZVhibXByWlBGSTFyS1BobkV4RXR0NEFvNXJHTWVSZHZUN2pCN0ZwRXpxN2o1?=
 =?utf-8?B?NWVpQWdCTzF5RWRJOXVFYy9QcmZhS3NjSDJzYnhIaXJ1Qm1RSzIzRXAvRFlZ?=
 =?utf-8?B?SldlR1Z1S2ZKdWU1QWxtcTB6MGZDRnRoZnJwVzlFU3F4a0Zjbndsb25QaFdk?=
 =?utf-8?B?eEEyeW5SL3c1UXAwNjkwZS9HQURVdGxrcjlpeG1EQy9NNTU0ckp3bTQ4d0o1?=
 =?utf-8?B?U1E0Z1JGMzI5Z3cxcC9Wd3ZZTXR6WHF0Y1NQajJsUkJlaEtHNkVVWTJrWVY2?=
 =?utf-8?B?QnZQekc5ZU42QzVVYXg2eVNmUGxhZlFXZmJHZmhvejFBMm5UK05DMkpQM2lJ?=
 =?utf-8?B?TllCdUNoQmlwRVZKT0VjdXE5NkRNaDgyOXFheU9rbWVKcTVFZUtWeW5XbXNJ?=
 =?utf-8?B?Y1dUU0xzamxiSVFkSXNMMWo2V2wvOTZMcGdFdmNpTlUvdEVMb1BoSUVjU2dq?=
 =?utf-8?B?TXZoZStFdVJKb0ppM1kxWkozQjd6Z29CMGdhWnVONW5FbG5aL0JWczNEd1Fz?=
 =?utf-8?B?c2htNWpqa28rY09NaktCU0RFQS9IeWhLSEd4cmpGUFJlMlhVNnJDQUVhQ2hq?=
 =?utf-8?B?UnJ3WEFOcEprcFdFcmFEank0MG9SYS9mQWs1ZjlIT1dONWErTkxtY2NvTTlP?=
 =?utf-8?B?MU4xR0xwckpXdVNXMXFGMWVIa2NLT08xdnlia0krWVVvdXQvamJPS0tXRmpS?=
 =?utf-8?B?emdPRC9rVEQwaGNvMFpPNSsyRzhLNnNOZ1laQ0N1VldJbE0xRDNtL25kM3Vo?=
 =?utf-8?B?MGZIT0wvK2JvbFZrSThzb2RYUmpVZGxvc0ZTajViSzNIUk5QVFJubU5oelBp?=
 =?utf-8?B?eWg0NVMydmpWWnlnYzhwK0NSWlpLNHpaVk5XWEZLRGZpMFhqUUZWUXcwdTZ3?=
 =?utf-8?B?dmFnUFF5cTBqT2Z5R3hqWUk3RDF1N0g4K3RWVzZNbXdEeUhUNUFOSWpmeVFU?=
 =?utf-8?B?R3VOZEdBZis2NVdTaWxaQU45b0gwWldTNlJFWW13T1JMMWFacmtyMWZPK1pl?=
 =?utf-8?B?Q1NkeG1Mekcra2F0emhaVmRJSmZFNGdYellxN0o3bjVPMm9ncnBXeGNEWkhP?=
 =?utf-8?B?Z2diS2ZSYS94aW1XRTQ4bTlVbHl5N0lTME9xUU1yV0VTSmlFbnNQc1VxRVUx?=
 =?utf-8?B?Z2VURmdhTHRQMThBZjhwLysvNDc5UDNzKytuZ0RpakRpcVZUa0xIVFViam5p?=
 =?utf-8?Q?QfAGhXUKhqoD1ejyG+QwJM5eqWojNaOkQK2t532exPr9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770b30cb-fbcd-4f79-2739-08db0fa50362
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 22:36:00.6341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ji0OCmIHEchrwD01F8xp19JutiCE15Ux1N3qNt5H1MCoWKor8m7ptNSbRr14eVRib7JZCAvgX1fnDKDfzI8ggw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/15/23 16:59, Aurabindo Pillai wrote:
> [Why&How]
> Temporarily disable SubVP+DRR since Xorg has an architectural limitation
> where freesync will not work in a multi monitor configuration. SubVP+DRR
> requires that freesync be working.
> 
> Whether OS has variable refresh setting enabled or not, the state on
> the crtc remains same unless an application requests VRR. Due to this,
> there is no way to know whether freesync will actually work or not
> while we are on the desktop from the kernel's perspective.
> 
> If userspace does not have a limitation with multi-display freesync (for
> example wayland), then this feature can be enabled by adding a
> dcfeaturemask option to amdgpu on the kernel cmdline like:
> 
> amdgpu.dcfeaturemask=0x200
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 5 +++++
>   drivers/gpu/drm/amd/display/dc/dc.h                  | 2 +-
>   drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ++++
>   drivers/gpu/drm/amd/include/amd_shared.h             | 1 +
>   4 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 599ee6417bce..5cb9e2b4ef2b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1604,6 +1604,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
>   		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
>   
> +	/* Disable SubVP + DRR config by default */
> +	init_data.flags.disable_subvp_drr = true;
> +	if (amdgpu_dc_feature_mask & DC_ENABLE_SUBVP_DRR)
> +		init_data.flags.disable_subvp_drr = false;
> +
>   	init_data.flags.seamless_boot_edp_requested = false;
>   
>   	if (check_seamless_boot_capability(adev)) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 2bf0a467d45f..1fde43378689 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -409,7 +409,7 @@ struct dc_config {
>   	bool force_bios_enable_lttpr;
>   	uint8_t force_bios_fixed_vs;
>   	int sdpif_request_limit_words_per_umc;
> -
> +	bool disable_subvp_drr;
>   };
>   
>   enum visual_confirm {
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index 3372ede2dc28..e47828e3b6d5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -880,6 +880,10 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
>   	int16_t stretched_drr_us = 0;
>   	int16_t drr_stretched_vblank_us = 0;
>   	int16_t max_vblank_mallregion = 0;
> +	const struct dc_config *config = &dc->config;
> +
> +	if (config->disable_subvp_drr)
> +		return false;
>   
>   	// Find SubVP pipe
>   	for (i = 0; i < dc->res_pool->pipe_count; i++) {
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index f175e65b853a..e4a22c68517d 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -240,6 +240,7 @@ enum DC_FEATURE_MASK {
>   	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
>   	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
>   	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
> +	DC_ENABLE_SUBVP_DRR = (1 << 9), // 0x200, disabled by default
>   };
>   
>   enum DC_DEBUG_MASK {

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
