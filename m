Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5211FC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 22:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8159810EDF8;
	Wed, 26 Aug 2026 22:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MmdXzKye";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1735A10EDF8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 22:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOo5/DQzAjepVWRMDtKl1I7R94sCc7VFQXU7xeXLuvFnTtUEp/Ay60joIM5vrlh4j303OGfi3zKP50+iGVjA1IqTKYl5hzB+bEIkBYYkGXWOFvC8cokw9g8Bw/97syDW1Z6R56R2sScRGqLbsUIep6o/iaGzqHSRGeyFrRE/GyoVYx6/VchKM2JMMongW4OPyqO5+OvyNzhUpe4npH3OLRbdQIWJRIhUFWoApZc61HZO8xwdTAPaRdi/apyBjLNTCwJEdndfvCXLJb1XWWFa9+1lH1ozNRPxNj6CmYWOwIEjpJ33EYWVZlvLFe/4rWalXMLJOoqUkzwiKqiOslaJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFE+FDI72z9rdCimNaRdi5GL5tqHZZraRX989x0xrDQ=;
 b=HfR/OFI/LMM0Qu/ordAAGkIvQmMnWVQhrixzIfldRk4SuA7PvinSETLMiF3f0p4vHnprJr6misaFHaQCO0xB2Sb1WExn5OQDk+msdobR3159CzZlRLIXR8u94gvgCfOWF6z1G1zItX4uWAcKelgBbxN21TOFtVXlUJnsbQRWxRx4NClDDTDLtWKQVXxpjMrgSCqvfc2N9zceVungFxqjEzHcHovk/i+I5LBM2F+Iq87uWvvJn6LstBg7CaOoReNfQ5rjf5ntZikrMt85X/M8XaVj3e2aONt/Q6rKHByaeIBrmeEHlysz2u+2B06WEZV4vBOmWpQ3mz4PIFcdQWAXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFE+FDI72z9rdCimNaRdi5GL5tqHZZraRX989x0xrDQ=;
 b=MmdXzKyeZ/JOGQs9cw/T4E7VQ7DMsSGTzPQaeSc3da3t1boCHCsVOdc5U+38dAbOduH9iYWRUVy94DefY3dOnc98aH62sZ+ULkneEHw4LrG8AklVEaT7BeQQhN35IqG7XjbZmJdupkZQuzvoeIccKOR+DdqmSONoNwkaVQJcGGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 26 Aug
 2026 22:40:15 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 22:40:15 +0000
Message-ID: <08d87b37-0da6-4ba1-a0be-fdae2b4ba359@amd.com>
Date: Wed, 26 Aug 2026 16:40:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: pull colorops into state when recreating
 a plane
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260825153539.213495-1-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260825153539.213495-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::18) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1252a6-5ef5-4d57-17bd-08df03c2fec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|5023799004|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: XyJGwbZUJdorSqveufUTZId0+1/onum7xGP1CcZu58sqRWOktWAWGCUnU9EpnfnbmYyG0P6swapyUq7qjgsP+GMGETx/buRO9yZ+Xn+cjLRgZVhp/alieuXZMpUJlMFqRz97GDGDfJ9j1sfQUZAh1CLV4oJciRR4OIwJAjlqTXZGQknWVMDapwNymREH49/xrjz4Y6VKrAhNE2r3UrXp+xNaws6bXie8GY097zBQP7j8JeJZ20SkGcNm2Ll0GZ7WWWqZKZYjwxIhiEWs+UGwB2DKTx/i5wUC0yo0yTzHfRP7TEbVVBt6sS0YbtODn9rLASeNZ6mImQzNUAcWcT020foEk1mGm4Lqad0TYeezD5bjphC7stSZeX5vxNyq2WXF5DEwQ9jptLE4RxyYMFYPNDMv6bl5ONcOpTkTLdgfvHdNiGyQ+tF7FKdvpyLzkfvEr79vRY7lCP+/q/INzL1yU91h+dq3ga+l1+Q2LYBbKyvUFUWzee1IqzRrm1vpXrH8Y31xpOpSXfXpwZpRGzGXfFFrdflMIIWcd56c9vppWh4zfEpfsDkseOejHjV92lDzwCdr/oqWm59P0C4Vy0YoQu499U6FYH0h0CSXU5HLjgsp0vr0xnXZ6u4KL31vP70OSWS4wKHRomxY4Twq2MyQ8kQndU43pPgD53Q4pucTlgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS9ZM0tKTGVKZ3pnalJlWTRHOTlBc2VFYVk5RGtkZnZWM1JGbWZ2L1lHVVow?=
 =?utf-8?B?RGZPT3NybUxLeXQ3N1A2alpQaWUyMkNDcXlZZHRnNDdtNzNZZjJZdnFoSnpj?=
 =?utf-8?B?MWN5T3ZxVC8vSEw4d3RGRnBaRnd1bmVNRjBVdDdERUsvRlcrUVRoWC95bkZV?=
 =?utf-8?B?Y3BFR05QTFJWZjdqNHlPY2ZDQTNydDlLR2diZFBrSWtvQ0xwb1dlbkp2NlBO?=
 =?utf-8?B?TlM4Wjhia0lUZ2VQS1pjL05OSDU0OGtHT09KcFA2a05IdHZuR3RkVGE0V0Ry?=
 =?utf-8?B?N1Q2cDhKUXhEUlI1SFFHeXRxcnRscmlOb3RZUzBBSmdQUFl4L3BrSDFqWmZi?=
 =?utf-8?B?UUwzTkpaQ1B0a2VoZG5kcldLQlhMaW90T09nQTJHOVRBTDlya00yaGlBdjZT?=
 =?utf-8?B?ZDRDM1FUdG93d1pPbFdTcThmTlQzMDU5dWhIc3c0QnFIajlici83NkxrajJO?=
 =?utf-8?B?Nk4veGo2UUhka0hYL1VsQnQ0aFcxNGRLZThwM09ORUwwUFNVSjJQVlI3d0NP?=
 =?utf-8?B?SkQ5a3UzN0dKUmRMMmNBWW1ZbWR4V21NdXlQNjJCcmZ1YXhPT3JNOTN5c1F6?=
 =?utf-8?B?MGU1Vy9JWFlHTEJQby9CbGREVlljWmZGRi9Hcmg3T0xzVmVRcGZkc0VXZWZO?=
 =?utf-8?B?SGVpdngwVWU0eWtJK1dFSlpRbWlpNXMwS04zOWhNejlTbWxCSVVXang3Z1dR?=
 =?utf-8?B?VEFCNVBtVmp1TVdYVGhsczVoaDBxOVJ1dy82Q0NjVTNVVng5cjBjc1FqOGdn?=
 =?utf-8?B?ZFQwb0lNRnFpSllJYmMvMGFpTVdWNitYeHpBQ2hMRWpVL09FbENnMGFxRDdL?=
 =?utf-8?B?WXhYVGllS2FwRjJYOE1oTkxHVjZxT3hqeGt4d1p5TUdZbzhMNGhYNUZMZitn?=
 =?utf-8?B?RXJOVGI0dUtlTE1tY0NncnVlT2pCR21nNnExTi9HcmVJbmRTc1Jra09VUDhq?=
 =?utf-8?B?eUNyRytKbkVxZ29GUG1XSnN0YnRhb1dsZ0dTT0NJWC9kKzFLY3kyaWNMYkZy?=
 =?utf-8?B?d0lpeVd5OWZzaEE1dGJnQm94RXNQZXMvc1hxTzgyWER4TmpkY3ZXMDJFNjMz?=
 =?utf-8?B?ZTFKdUMyYStvbDdmU3ZXZGNCVHpiOExpU1VieFhCcDlIN0lWYnVGWDdheEdy?=
 =?utf-8?B?eVd2MVNpZi96OWtoUUFwK0tBcFZzVWZQMWxxbllQUUYyL3BJdGJjb2pYaFNm?=
 =?utf-8?B?Vnh5MUY5S3Z5djdLYU1nMWNycnBTcGZTVHBzU1Rmdnd5SEU4M3pkd2IwSDFD?=
 =?utf-8?B?VUlxNWVlK1Y0dGtUQWM4VjRwdExpOXZyMTFvaDJacWN3YzVmZHZqNlo1M0tI?=
 =?utf-8?B?QVloSHJtUFkyOUZVRlNCRE9ia1NiQjBhUWVORHYwTlVTbFZzUlIzblA1S0pW?=
 =?utf-8?B?ZzBDbzB2UW5vOHJJUUZ0NHA0UjV3YjdjN0JkL01NeEZFMEh4SjQ5dXF5S3VY?=
 =?utf-8?B?RUZ0ays3S1lCK0I0MFdaV3BWRW8xMGJudW4wOU52TWdjWnhUaVdxNjg1WGt3?=
 =?utf-8?B?eHBBYUlEbG0rVUszWlRSb09wQm90bnR0WXZsQkg4akUxTTVjNStmZUtaNnlv?=
 =?utf-8?B?ZmFIdEpRaVBCd1MrWC85bWR6L2N0STQzVllUSUVSL0hmemRheEJDbm9ucEsw?=
 =?utf-8?B?M3YveXhRVUl0TndUNk92VmdtZDhQVVRFaFFWaTFSZUZ4UFdTUnpvaWNlWTM1?=
 =?utf-8?B?bU5QOGk3eWFCbWJTT0xBSExodDFmdUxtRmx4eC9RV1pya1YrTy9jNWZPWmEr?=
 =?utf-8?B?M2JhT0FkdW9Oa25WSmxEMzNqbG1YcW55RWNBOVR4RHhQU1BnYUt2MlFSYkt3?=
 =?utf-8?B?TWlHdFBYZndtQWY3MXZWQTlwZXA2Q3lNcUdyblBFNkFUQjNOb05PZEFWMjJK?=
 =?utf-8?B?WllydGdmamVheGo1Y2tpdUpocmhlZm9aYUdLWDZ3TU5HZjJJdHM4bVZvOWJJ?=
 =?utf-8?B?b29iMUxwK0FSaExUdmhjU0VNSmRwQXRuYWErYWQ2dzZidncrQmg3QWdObVNX?=
 =?utf-8?B?RDZzcWcyaTh2ZzVETEg2Z2pWc0I1UHVRemRmRG9SbGU3endCMCs2bTIwbnV4?=
 =?utf-8?B?M2hUTE82RlhKWFY2dW5IaVdQZlc5YzdnUVp2NTlQdTE1Wi93RXVYeGdlNmsy?=
 =?utf-8?B?WGxGYlpodENVTCtnWW9ZNU05dzJsWFRTTlpMVHI0Zm8zY3NOWU9qL2c3bktL?=
 =?utf-8?B?b2paaTFGNForUnpjbzJtV2JDc2JJMS9EQ1hUQ1NEYlJZS3VCTHJCTzVZZksx?=
 =?utf-8?B?RlZKZ2ZkbWpVeUFQMHhYaTlKOE1RbHJ0WENQNWFLdzY0UTl2WWZEdHRXZTVI?=
 =?utf-8?B?ZGFENjY1dFBTbXVKZDI2NFJjMXU5ZitOWHA0YmZXeXZpLzRRQlZaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1252a6-5ef5-4d57-17bd-08df03c2fec6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:40:15.2797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR2UlDZp6E+YVUWhzJaW9O3M3tNm6NStsT1wKQa8t6yeVdgS0YiCP5zrECe9xH+EZDlCkzgZ5M8ejvaAHN4ObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
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

On 8/25/26 09:35, Harry Wentland wrote:
> [Why]
> When should_reset_plane() forces a plane's dc_plane_state to be
> recreated (e.g. on every ALLOW_MODESET commit on DCN < 3.2),
> fill_dc_plane_attributes() re-derives the plane's color pipeline from
> the DRM colorop states. The per-stage helpers look up each colorop
> with for_each_new_colorop_in_state(), which only iterates colorops
> attached to the current commit. If userspace didn't touch color in
> that commit the colorops are absent, so the fixed matrix (YUV->RGB),
> shaper, 3D LUT and regamma all silently fall back to bypass. This
> corrupts the plane's colors - e.g. an HDR P010 video losing its
> color-space conversion - until the pipeline happens to be re-committed.
> 
> [How]
> When recreating a plane that has an active color_pipeline, call
> drm_atomic_add_affected_colorops() so the plane's colorops are pulled
> into the commit and the derivation sees the current pipeline instead
> of defaulting every stage to bypass. This mirrors what the core
> already does on a modeset via drm_atomic_add_affected_planes().
> 
> Assisted-by: Copilot:claude-opus-4.8
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 49f1a22f2888..4ee677f5b8b7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6337,6 +6337,19 @@ static int dm_update_plane_state(struct dc *dc,
>   		if (ret)
>   			goto out;
>   
> +		/*
> +		 * Recreating the plane re-derives its DC color pipeline from the
> +		 * colorop states in this commit. Pull the plane's colorops in so
> +		 * the derivation sees the current pipeline; otherwise every stage
> +		 * silently defaults to bypass (dropping YUV->RGB, shaper, 3D LUT
> +		 * and regamma) when userspace didn't touch color in this commit.
> +		 */
> +		if (new_plane_state->color_pipeline) {
> +			ret = drm_atomic_add_affected_colorops(state, plane);
> +			if (ret)
> +				goto out;
> +		}
> +
>   		WARN_ON(dm_new_plane_state->dc_state);
>   
>   		dc_new_plane_state = dc_create_plane_state(dc);

