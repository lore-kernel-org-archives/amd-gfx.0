Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E0FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 13:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887CD10E26D;
	Thu, 23 Jun 2022 13:34:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B9610E13E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 13:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzX+ehT63akXxqm69eEgEVNZanr8R075TwHEusQhl46bT0PJtRm4liONffm017Mv93nK6YWlWv/HUj/ZCG8FKcGcdirc+sZ/Jt40X+6DEGn8VqVC4rWeoMerk/mXKXb/Ys5UWG5JJEUgVFF7qA1NofhUcM1dPTeMKveInmRvVBpfngTPCnNmQeqSeWDdmIuq8u3nGI20tg8zraSJW3xYig0Q7WrONun6l3yYbnhcIhitY0i9uSGnBmME/tawkYMiNmeoj7LqPhqmYCPu+m+/wswpg9vOXqagGflpIOZL2erAqJtTokDn9smzz8Mk//weYn/+Sun9ITCHTxIDpJvVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlIk2pCBCA2zMNUo1NSbALpeqaR/c4Oeu4gv4EBinhk=;
 b=UiVSrwCt8E0sMMsJXp/sH+89/rSG/YQ3tmk3i6qUCSycrGiDsKA+hewFw42iCYoL0WK7eIpyTOX1M8hvjoTSqkr3NDBJHz4hwKF3PCEyiWQVKT+e/V5NRM89XG6d05HAxyOIisZ0q96mgAJFQ+ft31giT1TuQVnN+2atbQMpQe8zosCNaKlB3R3TSjPb8gGYH+XgojlwIYT/Rgy9Ppq3aoTUUB5xOxliL19BsPPkFmLPSpq+buEwPWJhIc12XENI6UP5EEMWBBUxhLOBsNFJTdzHMjrVuIFR/MjOnlfNmTe5t7m6dlsCL3J210T8cX8WzMqZDWVWhoR3KmwmrADqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlIk2pCBCA2zMNUo1NSbALpeqaR/c4Oeu4gv4EBinhk=;
 b=TiHCwEa8+M2c/WqI1R2ZIFg3aQlMfaVEStUspH55JuClj0hj/K5NeL2eZ6xqEfb/tzfRplizty9vRIuRdjiISazsovGCPwWlNK/gJpmPquHok9tP4hFARB2xsBm/fGHDFr9LLP0eKGx5iIl0uApt9Boy5bS75EsYoHme7rzknAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Thu, 23 Jun
 2022 13:34:19 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1563:b9e5:78e3:5c15]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1563:b9e5:78e3:5c15%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 13:34:19 +0000
Message-ID: <63049cc5-d963-4cb1-d10a-230462ef1aff@amd.com>
Date: Thu, 23 Jun 2022 09:34:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Revert "drm/amd/display: ignore modifiers when checking
 for format support"
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20220620003720.2049653-1-bas@basnieuwenhuizen.nl>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20220620003720.2049653-1-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:208:d4::31) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b21449a6-3841-44f2-9fc1-08da551d1328
X-MS-TrafficTypeDiagnostic: DS7PR12MB5717:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB57173C6F33D4F747E86B50E88BB59@DS7PR12MB5717.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jj3/yqP6NG+H9VfoFgNtIzXyzrGwE/bQe6P7tllbC+/yNgtbauCDdi2S6wLqG6SCvZnPAIGV7MXRd1eUqaSGvGsrdBi1K0f5MewJvtp+7gG44b53PrHjxQUbMzkloWDuJFeoBBEOIsNu3WJ0YjHS4SN0fylxahtfmVQ8fiOpWS7tdGEwCF5oOwquY775JqexgZYcFbLcf4NFx6PdtooyVsOVCWqt4HLagY0aAQozYC4v5qlErQpZjpJw+chMZWEqiaMZUP3kcjWS7dESvHGHuqboS21KGN4YwT2TmAzkrSbtOo3u/VhHqbw7sruMAaTFEgOWfGhHOQU7/oV2uU5sSxiMTqNWWA/GPpRNo/V5vF4ADd3I8P134TVFxOdw/x0Q419KdCta2WOpNkr2hAVHE8Dls+O/VqdgiRMH1RkTW42RzF8zIF9gni7C2hVebI0h1NdUEiGdc5c8Nna8gVs2fozYZyU6Tyukq8Ro7bPnOTa9AugONNF9K5vdgvhYH9JVSmaMxXDy1loDWI8S4IVX8Cl25p6ZQlNCMCdmCyPhcX9GyqbQ1lY3hTMxgWEFyN2c9XMPSs1uECdPXtqk/RL0870O8V2n/FmuZwbVuoRc16y2j13BRhzoTL8oSbM2I0Fz/prdngtDAU8feBPy6i57Dm/PWNr73m10iI0M1DPxH/pCAklVrQXwoD5SXFQ+CYBJPt20dy0svW61/D8N6tRRpfrAXc9qND2+/iTUWMsbtLL6esLaj8zVTBs8SbRX2MISwH+MzK19eh1TpocqvqK+CjItDGrz1W/h3VMpXJQCHdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(2616005)(2906002)(6486002)(26005)(53546011)(8676002)(186003)(31696002)(4326008)(41300700001)(44832011)(66556008)(66476007)(66946007)(83380400001)(316002)(478600001)(31686004)(86362001)(6512007)(6506007)(36756003)(5660300002)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2dEQUhFRXVTemNKUTJPSUpBcFNDUEVUc2xPL3NkSzhaQXFHWElnWGwvc3pk?=
 =?utf-8?B?dzZ6Z2dMN1ArODlyQzJwK09vSUF6UHBUYmdtNng3USttY0VTNExZbmJUblUx?=
 =?utf-8?B?YncrNWF0bUpxS1ViY0dTbVFjd0s2aDJIMXZSeXlFdnZJL28wMS91QXZIMGhu?=
 =?utf-8?B?MUpxWXNVQ3U2SUcyazVvaGdNSWJkRlplYXZXb05OR0x1Z0YremtlN0wvaDRm?=
 =?utf-8?B?VHU5d1A4a1VEVmVwTm5EYXNZUWhQWmV1b1BYUlJ3ZXpXcjQ2bVdxNWQ1UTFn?=
 =?utf-8?B?Q1V0RUVoMG1wMzlqYU1uUW5BUkJoeStORmZEaytzUUJNRlQrSm51a1VBWVN6?=
 =?utf-8?B?V3FiM1BwSW40SDV4RGZ6VVphblRRcnZ6cDBKcFB6UTVyYldwL1lTWDVxZHFN?=
 =?utf-8?B?bk04OGNLVXhFOUxEWjVpYlBwc2xIZk9XMTFIeFd4aWZjaGVSSkpwbzJyK0JZ?=
 =?utf-8?B?ZEtCSllZeVNleU1RUVhkRkw1djRuYTlTQkZpUk5aZ3RMeTkwcFpoQlNBTW1Z?=
 =?utf-8?B?ZzlWNTczSXhsL0lac3BzS1A3Qm5lZ0ZWNGhtRDZTRGdBQ1VBWFFkb3RkWE9U?=
 =?utf-8?B?L1JpdHdCaVpvcU1Jd2E0YTBWdVd4T0VJWWRkZWJKcWNwR2JNc1ZlMlNLNEo1?=
 =?utf-8?B?YTRpSWx2TUxGTnc1bFM2WVBZL2wvbE9BZVh1VXBtSE5WdFBJYmRHZ3BTRUNP?=
 =?utf-8?B?ZkNuNi84RU1kZGxETmVoc3U2WU52dndRYzdrd0RXSlIrd2VkWGd0L25ZcjQ4?=
 =?utf-8?B?QjduTlBDWk5ta1JaNHhaMTNTTmR3YnVFalZJU3k4a1JDR2xzdkNTZW92OU5E?=
 =?utf-8?B?MjI0R08zWDUwc2FjYUVPbU5mQlU5SWZra3NQaExVbnl5TkcyamhiVlhmZ0lr?=
 =?utf-8?B?d3pqTldKdGViU2RudWNrd2lZYkQ0U0JRWG90eElBMWhBUGdBaTNCRzJYNzl3?=
 =?utf-8?B?cko4S1hiQStDdTZ0RE5oamQzRUc1WW4xNWpPMTNKcDNHeXZjMnA1TndhR3kx?=
 =?utf-8?B?ZHp6RWJ6UTAvMTJseFNvbGk2ZjJuZDcyY1RsYzU2VXFpMXdIQm1Ba0dKV2kw?=
 =?utf-8?B?M2hrajdZVHFid1RlU0c1L296YVVJU3paQlpXL1Jubkx5VDBkbFhmcG5xNHJ5?=
 =?utf-8?B?a2N2UGI5NUpHQ2RjLzMyQ3lIVkxIais3aHhoWUFmbkY4YjRKcllHWThSWWEr?=
 =?utf-8?B?ZUlSYW5ybUY4ZVk5WkhWWHRzSnNGamk2QUxxdndzUUVWd296N1FQa2M4dFY2?=
 =?utf-8?B?MWhrbEtJb3FGUUJmYUdoUlVIdmVmTVUydW1ZbFBSSFBacFhNaENHakEybXZ6?=
 =?utf-8?B?Y1hTTHZCQlVNMzRCdDhEM1NtODFkdVZyeXIxNmVCcGhzb2FxYTM3citnWWtO?=
 =?utf-8?B?UnRGRG4yRUgwQzhJV3VMd0FlLzRhZUFXcU1DSDdxQmFhdFo1dVRUbUlrM0Rs?=
 =?utf-8?B?STdOSEFTaHVvV1FMOHlxNFBzM2I2MjlsTEVMZ2ZLZ0pqWjNCVDk5SVNUaXpD?=
 =?utf-8?B?eS9MNFBXeUFVeDh2YXhkZk8wZWJ3VnBRUzB4ckpaSktRVExJanVZcmdlN3o4?=
 =?utf-8?B?S1JBNFpZSmFuS01WeDRYTzlWREVVZ2VETXl3UHlXU2huOVN6QjVjVzA4Q0JH?=
 =?utf-8?B?ZytMSXBXZkYwWENWVVphcmxLdjhVei9WYnVVaFc0c2NIendsMlhGZGtCdVBT?=
 =?utf-8?B?eEFvdFRtQmlFUy9McTY0aVdpMmxZV25ZN0pHSDBjQjV1UXEyWGN1R2Q1M0Vm?=
 =?utf-8?B?cjdaNkpsaHhrb1pGTFVkWGNEOVBpUVZkWHhSenh3Z3JBZlk2Q0dGaS9FZUdo?=
 =?utf-8?B?MUY5UVFCMlZldHJla3FiUWNqNHpod1RJTzUzZVl6Y2ROS0tCVkZyL0d2Mmt6?=
 =?utf-8?B?U0Q3RFc0SWxQUEhhbEJKYnhWQ1FrckVZMldNTndzSVZYb2VnZ2lkZCt1dEpI?=
 =?utf-8?B?VWozMno3R241WThITHAzVzVablhCTDZJQTZ4UzhrTGdOdk1UTjNBVWJTa2RT?=
 =?utf-8?B?d3ExUHdlbnFGTEJNSGxUWnRkN0JzWlU2cEQvVWlleVZKRTJSbmNKakxXNDI2?=
 =?utf-8?B?OVN0anFuTExDdkVTVm56UUlkSk41UXJSOGh3Y25VT3Q3T2dGTEYyaE1Xb2c0?=
 =?utf-8?B?YUxVOWV5aUNLM3JQbXNvVnNrN2dweU1zemdmdlBLcGpkWnZVUktwaXYvMHJP?=
 =?utf-8?B?S3NCNWdpMXBBQkFRK0EvZWZjRU9McEpOdVNUTWFSamY2MG1TQnFaY0xsT2Jo?=
 =?utf-8?B?U0NBNnZYRk9ReGpuZTdCTytHYkNQMGtiNFZrdTRyemcvMkgyYm5iY2llZG5F?=
 =?utf-8?B?dkVTVnA3MVYxUG5BUTQ2aG9RcnZ4emp4TlM2SFJyeWtqU3o4UFpBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21449a6-3841-44f2-9fc1-08da551d1328
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 13:34:19.1438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek42FFFnmoxMHjxTdwSfz/4CJBQNQgEFSJQiLutYq8JqUfqKt3/MIgbDloNVNPw/F57niFip6lBKeOo6ZpoJYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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
Cc: alexander.deucher@amd.com, marek.olsak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-19 20:37, Bas Nieuwenhuizen wrote:
> This reverts commit 5089c4a8ebea3c3ad9eedf038dad7098ebc06131.
> 
> This breaks validation and enumeration of display capable modifiers.
> 
> The early return true means the rest of the validation code never gets
> executed, and we need that to enumerate the right modifiers to userspace
> for the format.
> 
> The modifiers that are in the initial list generated for a plane are the
> superset for all formats and we need the proper checks in this function
> to filter some of them out for formats with which they're invalid to be
> used.
> 
> Furthermore, the safety contract here is that we validate the incoming
> modifiers to ensure the kernel can handle them and the display hardware
> can handle them. This includes e.g. rejecting multi-plane images with DCC.
> 
> Note that the legacy swizzle mechanism allows encoding more swizzles, and
> at fb creation time we convert them to modifiers and reject those with
> no corresponding modifiers. If we are seeing rejections I'm happy to
> help define modifiers that correspond to those, or if absolutely needed
> implement a fallback path to allow for less strict validation of the
> legacy path.
> 
> However, I'd like to revert this patch, since any of these is going to
> be a significant rework of the patch, and I'd rather not the regression
> gets into a release or forgotten in the meantime.
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 53 +++----------------
>   1 file changed, 7 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 60fb99b74713..698741fd39f4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4936,7 +4936,8 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
>   {
>   	struct amdgpu_device *adev = drm_to_adev(plane->dev);
>   	const struct drm_format_info *info = drm_format_info(format);
> -	struct hw_asic_id asic_id = adev->dm.dc->ctx->asic_id;
> +	int i;
> +
>   	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
>   
>   	if (!info)
> @@ -4952,53 +4953,13 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
>   		return true;
>   	}
>   
> -	/* check if swizzle mode is supported by this version of DCN */
> -	switch (asic_id.chip_family) {
> -		case FAMILY_SI:
> -		case FAMILY_CI:
> -		case FAMILY_KV:
> -		case FAMILY_CZ:
> -		case FAMILY_VI:
> -			/* asics before AI does not have modifier support */
> -			return false;
> -			break;
> -		case FAMILY_AI:
> -		case FAMILY_RV:
> -		case FAMILY_NV:
> -		case FAMILY_VGH:
> -		case FAMILY_YELLOW_CARP:
> -		case AMDGPU_FAMILY_GC_10_3_6:
> -		case AMDGPU_FAMILY_GC_10_3_7:
> -			switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> -				case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> -				case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> -				case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> -				case AMD_FMT_MOD_TILE_GFX9_64K_D:
> -					return true;
> -					break;
> -				default:
> -					return false;
> -					break;
> -			}
> -			break;
> -		case AMDGPU_FAMILY_GC_11_0_0:
> -			switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> -				case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
> -				case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> -				case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> -				case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> -				case AMD_FMT_MOD_TILE_GFX9_64K_D:
> -					return true;
> -					break;
> -				default:
> -					return false;
> -					break;
> -			}
> -			break;
> -		default:
> -			ASSERT(0); /* Unknown asic */
> +	/* Check that the modifier is on the list of the plane's supported modifiers. */
> +	for (i = 0; i < plane->modifier_count; i++) {
> +		if (modifier == plane->modifiers[i])
>   			break;
>   	}
> +	if (i == plane->modifier_count)
> +		return false;
>   
>   	/*
>   	 * For D swizzle the canonical modifier depends on the bpp, so check

We can expose an additional swizzle mode to work around the original 
problem with usermode which doesn't support modifiers but supports 
swizzle modes.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
