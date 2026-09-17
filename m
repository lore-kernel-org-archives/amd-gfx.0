Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B809C982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 18:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B6410F049;
	Thu, 17 Sep 2026 18:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cna3S8jt";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012068.outbound.protection.outlook.com
 [40.107.200.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D396010F049
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 18:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj8RVSjSUTGKIrpa+Voc8Fn6yipK7+BczfHMED6ylPLuloWLonQCg6v+rOGdKbQMZyjZYgXDlHMH7STh+v2RFcLNl7dM44hoZ75MabJAq+/enzzb9GY37jjhezFWjUuSa3nbsYPtEMbKh7Khbk8Zr1hkQeQ2lX8fGd6+lMQPXr/ly4IuW0Rf/XysovK1XAcx+OUgR0rytVCV+gPSna91hxQTlWVYIW+HNG8K6vPaI/5SrPCuLpuNLgq0gcD5t6M8hLJTdXhpyi+F6bFkCbrr0LCmUYETEqUlZBNcAcy3Y6kDfQhq2MVORd7gxGUhMYO6WJLDITt9QNbj6GKzAIxQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqiSfU4YoDDtLe8BmFMmYgyni/kj3c2YmvqQF2vVu8A=;
 b=mx7AptnrSK1BWguTKjWNuIdK/wuZ7sBUExcoersCPBdUG343nnBWYgnFE7b5qm3ZXLzOUvQgl7789yLXJuYcQD+M5173XovbsE4VMklAehlPntEFn+bekOuAjR3hb6HRKywl5eWcYVWNIxNPAtt0cqCdyVHpIGgTS1HXE2cqSUH4eqNzTHW0q9a0oNiyKBcS9hSgFho5qgjpEzi9alTY6+fsCTG+bnTzoLoPIlEfiWoJgshPR+G82Asv/G5jq0cED9X1HZVEibuPUBaPvkDE2B0mVa+yS11dMRS7ALaSScxdC6EEhFBPW7Ra+8Wn8Y9EEQQ9Isz+dLQJdVMaJLgk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqiSfU4YoDDtLe8BmFMmYgyni/kj3c2YmvqQF2vVu8A=;
 b=Cna3S8jtl2Flx/nW0iSX/IPWmE3VTZdm3MuSjsji99t77a7cS2Rds7cjj4NTtnbnmQU4gU+OUUEz7GO31rKq+0WUaztvvbrpbn6eg8ZJ/tFp9otS1665DeF0R9TqurMW9P+r+GWgrufMuQ6m/JFUyvODRxcDk3YsS5sC9TCHIQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 18:22:55 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%3]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 18:22:55 +0000
Message-ID: <53d08e5f-44a6-4c1d-9f14-5fade78d01b1@amd.com>
Date: Thu, 17 Sep 2026 12:22:53 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix null deref of link_enc in
 dce110_enable_tmds_link_output
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>,
 Roman Li <Roman.Li@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
References: <20260915075755.458506-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260915075755.458506-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:303:16d::20) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3a5cc1-6499-4264-e6da-08df14e8b153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|10067099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 9kIsnNmdHODaBpM1FXQVrZbNrHuR+V1ySkg9tw1fYUa11I+tL7peE2n7YzuIEZ1CeuLqHi5Hrb0lB+pOkI0QQAdJj1ZudfaFU/t9ZVM2ga6vpsWyk3Xz0kAd+uthOkVMCFpAMuDUrUcO7i4RiBOAydCCwBFoVX++uF0ZCZSxVoSVNTL+KK+af7EHAIOhbcCRtRvRdOtwktfKMXZJ7kXSX10w1Jt7+gjaValGo+Il8BDzxKliDz9rzZj26Nnsh1YpwGlNdgdpsDnyNPZS1iM7p7LFfO91auTWd6t01gBq+kJn4Wb7JRaNJDzj5SR1MEuDcTA+goP8WMZDQkyirXTAt9u4gn7Ze3a3SM25vFYkKIALraYf7xROZFZ+ZJ5d7kwvjDc45vEgkTbrAi1O83YByp7eJq/4CJwCoZo/2KJXMsbbfdb3PNh2+nnxJLx4z7Sdo8/W9bqh0QBFxQOxtdOC3cEjj6/XpM0DyYlBoj2Z2nocP1cKGQc/xmnSulYfIi+eK/NjoCN1fAimtJwR9dkpwaijEZlm3l4WzuoaU8QiFHBcNihEcUK3X//ymvx0kcLwF1w7mDFm5E1NREApMe0hDtRq+hBkaNmJCl0n27wCvRpN4jpJ/FtrX9J8toUobm5luLhGs4xWq3Y4rzCVqjBYC1fHWesvAyj9+l8zQ/EJsoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUliZ3ZCZ1NoQm54OW56RDNEdVVmS2pYVDdpdHNQUW9xWmE5TkJCV2Qyak9C?=
 =?utf-8?B?Y20rNDdqN2Q3Rm5MeDBSak5TZGh2WmlkUTJEeGVQMEMyL0ppT211Z2xqTS9X?=
 =?utf-8?B?S1dKcUZuYk4yQmZWcE5xcml0L253T1A2OVZVQzRxM093Y1RERjdqV1lyc3FV?=
 =?utf-8?B?RU55SlRUQTR3RmdEWHR4ZzhnQXVTdzJxVnlwVTFYd2ZPQk5nYzdhZHFhSzRl?=
 =?utf-8?B?TGVoZUFxZ3lnSU5PdlpnTjFpaFhMS2EwRStwd3VhRGJuaHlUcEhsWGY4MStj?=
 =?utf-8?B?V3ZvajF2NXRWSnkrNUpMZjduelAwSnRsUjZONDkxcXF3aFdjbENyNVkvWDlB?=
 =?utf-8?B?REVZdFVmczl6bGZjSG5CRHhkNldiNU1FVDU5RmxsczhxVExaMG1WWnZ1MytN?=
 =?utf-8?B?TEhFSkVIeFlhSlBDTUFBb21tRmxnT1paeVE5a2JQY3ZaSzBwNFlwOGF2OWlB?=
 =?utf-8?B?Wmd4SFAwcXdVZjUrcmQ3Rkx3d2pWYlhZUnFJYUR5S0tIa3dDdHMzczZnN0Fh?=
 =?utf-8?B?NVB3aDZGeGI4dFNTaExYRkxMMlg5MG9QRGx6ZVdnZGswenJXeFl0eU1BaEVw?=
 =?utf-8?B?elVSUVI0Nk1CeVdKNFg4QTN2d3RjendsRTZHOXBUYkZtMVE3SFNabW9BaUF6?=
 =?utf-8?B?c2FaaWNBRFFscUlGR2lxcCtLNGVBRDNnYlVaWGJRcXJYbHFoeXJiK0hMbHMr?=
 =?utf-8?B?aGdXVTM5VEdocVFob3hnbDc4ak9ZaGIwT0FVNzFrYUlQR0dJMmxER1NWNmlZ?=
 =?utf-8?B?VHZZMVFKanVBN2YzdDFqbERQL1pmdXJnc1draFF1U2pCckl4VEF1bUJ5dlEw?=
 =?utf-8?B?YU9WKzFweXduOStzaTRsc0Zwc2Z1c3RBVzUzcEdRVU05SVR0dExYUzRCM0hM?=
 =?utf-8?B?eS9VYkZTTmpKbXAvbDNGM094V0NDRFoyd2V6SmRINTN5bm8rUXNrZmd3TVM5?=
 =?utf-8?B?V0xFVVpIQjYwRnA3SjJHNnh1Sm9iV3JnYjBtNGhoWm9aY05VNlhFS3hINHdr?=
 =?utf-8?B?TjNDN1hreHQwYWpZVVBsa3d1Q2o0LzczZjhUdjRoUmt0cVNxQVM3YVJaRjAy?=
 =?utf-8?B?R3dmZVFOUUJUWDNzeHlZR0pLQ25xTXNFNFF0V2g5bU1VMG5qdDJLaysrcExO?=
 =?utf-8?B?ZVY0TjZRVFEvUThvazBlVUJhdTRPd2kzRVRiMjZzSUYxWEU1SXNBKytWenFi?=
 =?utf-8?B?dk5vdTgwUnBDV1ZUQWUwSVB5SjJZNFJOSFBONU9OZFJwV1AyaSs4WUpWL3V2?=
 =?utf-8?B?aHAxQUpGQm9IeExoZE0rZnlKMUdUZElUaGRSbklxU2UyU3RaWmRqVDZ0eGhn?=
 =?utf-8?B?MDJZbWdiMkxISkdsczN2L0szN3NVVkl2bzhra2RobmtCYnAzZkQralR6Z2Nk?=
 =?utf-8?B?NFdhMzlmZWNZV1FHeEY5VDhwNm5rQjBKdnBxKytFTUpqMCtIMHBrbVVCaTMw?=
 =?utf-8?B?ekQ4OGFIaVdmaWJONDZnQ29zTUNIK2tRRkIvRWZuTGpVWjhUd05SdVBFUjNy?=
 =?utf-8?B?MkhRNkhVRFlDb3BpQnE4SENYalhKZGJpdURLWWxjbUNFWlVjNXNvRWJRMjRs?=
 =?utf-8?B?cWhmaWVGSVhUM0IwYlFrbmJxOGoyU096dFVYVnZMYkV1MWhQNWNWZzJpNUJG?=
 =?utf-8?B?UVpLMXR2VkRwTENEWnEveVlYQTI3UGZLZUFyWk5wb09XLzBPSWFMR2VaVUZL?=
 =?utf-8?B?bS9nZ2VtQ1pHVWRsZXBFeDVTaXI5cTRxdnVhMDU3aHlvN3NaWVJVNjJyT0la?=
 =?utf-8?B?SzhBNDhZTHk3Ykw1NGY1N0J3VUMvdUp1QVN2Vmc5N2lhdFNQajlWQlF1ZFFV?=
 =?utf-8?B?SDFiWTJQRDRHMm05ZmdLNTlJdm5nczEyRm9JTUNWVUtTbG9pMEJEVGZnRWZp?=
 =?utf-8?B?ZXJpa05MUzRsUHR6U3BSSHkzZVlwV2p4OHhQN0JXb2FFMTRiQ1dXS1hpVjFj?=
 =?utf-8?B?cFU5UXlGMWpla1JQdXQ3YXFhV2xjRUVFaTVZZUdHbVJXcVBmaWR3YWt5Zmpp?=
 =?utf-8?B?WldSdHhEbmNhRXUwUlJDd0tYazFtQ0xwZFhVYnJSVmtZYnZCNkhYN2hiVnpr?=
 =?utf-8?B?SThhYlpyMmUzNzU3K3NnR2E5Y0IvQlJxU0p2U3VwZVpydzltS1ZBb1RDSFpN?=
 =?utf-8?B?cGhJemFBY3FYbTYyQU9XSUptWkZtemdxcmx0djcydDBPU1h3b0hodTJpU1VX?=
 =?utf-8?B?SEJ0bVNyVFBJWVhiWHdrMGYrRWZtWEU3aFI3bktIMXV3Mmw1ay9mcW9CdE5Y?=
 =?utf-8?B?Z0V0ZHg0YzE0MGQ4bHo2QzhLMStpaGtORTRkcHZLbUpodkpzUHBRK2dUY243?=
 =?utf-8?Q?69pO1mC8Ai8jyNBXFK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3a5cc1-6499-4264-e6da-08df14e8b153
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:22:55.2280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHAqbJGpGU6t41aNq84fSUlvNCKmLc2xRnHsksTyS8oQVDq70enQAastzeZKakd0oIiTw47Mnt4LBFKzGZ4cFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 9/15/26 01:57, Srinivasan Shanmugam wrote:
> Smatch reports that link->link_enc is unconditionally dereferenced at
> the top of dce110_enable_tmds_link_output() while the later
> setup_ri_pj_check_in_sw_or_hw_mode calls guard against it being NULL,
> making those checks contradictory.
> 
> Add an early return when link_enc is NULL and drop the redundant NULL
> checks from the two call sites that follow, since link_enc is guaranteed
> non-NULL past the guard
> 
> Fixes: 64fb5e1fd7fd ("drm/amd/display: Enable DCN6 sources compilation")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Ivan Lipski <ivan.lipski@amd.com>
> Cc: Dan Wheeler <daniel.wheeler@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I3e55d05cfbcfa006bb06de92bf735806438b6b42
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index bb46d7249025..54797293c0a1 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -3487,6 +3487,10 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
>   		uint32_t pixel_clock)
>   {
>   	(void)link_res;
> +
> +	if (!link->link_enc)
> +		return;
> +
>   	link->link_enc->funcs->enable_tmds_output(
>   			link->link_enc,
>   			clock_source,
> @@ -3497,12 +3501,12 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
>   
>   	// For dongle Type 2 with no I2C support on board, setup sw mode of Ri/Pj check with proper aux instance
>   	if (link->force_to_use_aux) {
> -		if (link->link_enc && link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode)
> +		if (link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode)
>   			link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode(link->link_enc,
>   				link->aux_hw_inst, true);
>   	} else
>   		// For HDMI setup hw mode of Ri/Pj check with proper ddc pin instance
> -		if (link->link_enc && link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode)
> +		if (link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode)
>   			link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode(link->link_enc,
>   				link->ddc_hw_inst, false);
>   }

