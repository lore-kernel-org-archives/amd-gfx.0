Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B359C55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 19:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22FFC10E257;
	Fri, 31 Jul 2026 19:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XtH08axK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76EB10E257
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 19:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q09yewgaIXusTV78MdrzST02cYhZjXxFCYyeyIuCAy7XoqdbxwPTAQF9copRh4w486ztjzA/fy1zUTKVMHr4uasfDBu0sLos/QPTFRoq7tv738z5gPn18FNPCb39ewv6YJswE42dtaJbsr90UBKS66I90wnJJnBXZEmR1MpqPmHuGnFNWMrJjmUlnAdcIA+fzmg6IIh7UtmKZsLzksvF33GQKA5Z3FuJOV6dclIaKlVTprmaHj0Vkdg5OFPN2VTENIgF0ushbQ/UTlQi0VUKMe6vZeCqDlc284QNChsf8Fzu8yU84tkzV7OygvktN+2rIEqmMXu4BmVHkruw4O2sKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlmJyfz7GHuxoDqajCHnIF1K6bxy1Xgitpx7xxfeyOQ=;
 b=sIetZqyY6tZ7T2K2srE3NRuX0fwmhTGV9RD4vr1FBFvK4BrG69b2J/+uYtS1366CEwtnplVChNACr9Jgs9JC4FAhCBejvgTXZyLO7E7G/BBzqQNySJTYOExy2c+IZMhUv/FxjRoulzfqK6U+lcUbJMrHfbM8tvcYJPMWMoJxN86TQBXKnKry/B8Yd4VJZEQ7YyteQlI+arWpzaxhu5HtMdriGEwz7JbdKmmzaJOznhpgMInzotdBJ4wE+J43OCqLMrkIn+JtVRx3qjL+7Zw81zB/9JgD3GEkRDD08TlwvqczkKuu0aaVqV7IboLcFrixMQzXscaGlD+EvqiPP135Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlmJyfz7GHuxoDqajCHnIF1K6bxy1Xgitpx7xxfeyOQ=;
 b=XtH08axKzxzQYC7iDiUtqmtUlyvoCqWhs8jrYHA1aKycMUay8jy1uQhICYWhpixBJvg185ZTwayzSTxXyX+QI+uF6gycInKCULNHXGpGfpZmgMl2QzjaasdgjXMduDXhDH7A+PwjxXTtc+HpyLzIMnuudcuh1q2mJbj7E0Le1as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DSWPR12MB999130.namprd12.prod.outlook.com (2603:10b6:8:36d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 19:57:16 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 19:57:16 +0000
Message-ID: <d31806cc-f102-4507-b905-cc57e06987b4@amd.com>
Date: Fri, 31 Jul 2026 15:57:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260730171754.704049-1-jerry.zuo@amd.com>
 <20260730171754.704049-3-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260730171754.704049-3-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::6) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DSWPR12MB999130:EE_
X-MS-Office365-Filtering-Correlation-Id: 407b13a7-0c0b-43c8-3283-08deef3debb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|5023799004|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: suv5O/hZm6sk3POq4lQCCvhTbMWWxiThIonA0xL9isOlp2J9KcxT/pTusMERPN+/9+4gmw9EY2HuXcbID8QV3HOa60aLx7qGKRPQMO7X/MVFFGZxieEa9RC5nOu7XyD73tTJEt4KsxIqN2InJrh+Y8QNtZF7tLbcGyagYa71Os3xKZ5OKKVfCkFEOfJ5EaLgwxQ45YPrQj0p08JIqj+haZv114dQvV2Owm1X1m3U80bTTYyV56lGULER/NgHTmSOFiZrZq6Fm/1wB2iYtuxagqIb92GSZQEX04x5RcsV28cXzNzP8OTk5e+XqCvpTAAmab9yx3VHs5eUcwNcWXQVtFuyW+6jkKtQYUBDNFZg0REPaJDm1v5DoIWF7tNRKsRX+QNJm3pxONY7Jtp9koE4Y6s/PSJbsYf5S6WWsEuVosJBn9PE6oeK9Qd0mqNPVv6TJ2pSHZnAuD8vy4o+p47Xpc+Mybeu1i0mxCKw+Si89S4j7NXHZPoxt1PTixt1S9RD6wMvb5Pqai23Z7H2Txi8ZspAoUEsk/5VhD1i2lFqF72yJ/ocv78QzYGdcPVBQTi74rBBogTAdRye+zlDUZnAvunBLqqdpvxhav4DFm4VrsatEvyvXLDYwDSEjpYioO6IiIb1cg0Y+A9n7MTcqL6zz1zg9xBtqBAmoOuY/sYyzts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEVJZVlnMEpjTGhpSG1sNVNJSlRadFdhZ0VsT0d1UUp5dEdDb0pzTnZWQUtF?=
 =?utf-8?B?UVFMMmJ3THI2bE9jMDlUVGlGNGlmcFBvRUZtZ3luWkVUbG9HV1lXTkFuNzJC?=
 =?utf-8?B?VUNiVDkwQWthcDJoeTZQaWl4NjdTQXpJREk4aDdtN09pUEc4aW5SZUxIMG9O?=
 =?utf-8?B?WDhPNE9WT3FnMHdMWWpnMThyczh4V0NBRFBkMHN3ZSs4V3hSUGQvSStqaTcr?=
 =?utf-8?B?RnJXYTJKbHF6UmVMSmVDRDM0Z3g5UEM3Q3l5UG1uVGQzN3FaSzU3cGRDNnJJ?=
 =?utf-8?B?OHlUbU4vSHNwcnVIdTEzcmFCcGJBTlJpNlRQM1BrU3VnVk1GdWlnOVF6M0hG?=
 =?utf-8?B?UEU0Lys2QTE3dXFKVFRIcXpWWUVMUDVPdzF0NFVRYUJsS3ZtNVhaUnJlUXVI?=
 =?utf-8?B?NkNxaWp5cVY0ZkU2MkZWV2lodG1rWUg1dFJDcnZQU1dVdGpxK3UyWTk3VEJE?=
 =?utf-8?B?YnhIckVremJpTkhWcHBaeHp5MFNySDFGNURraExReFlEbUNpelNVK1VkVGUy?=
 =?utf-8?B?dlZSY0xMbXJSblRqVWZxTUpvc09NMUdQbXZMWVVQSW1ySXBvQzA5cGhZakdE?=
 =?utf-8?B?cEVNV0w4eTgwd05qcm1MRGpIVnMwa25qeStsS0F6Q0NyQURVSHVSRVc0RGRx?=
 =?utf-8?B?clFsTkVLYU5vajhWYzA3SzlBN09xejJTSW00TzNMNkxmQUp5NGc4dHhBN2kx?=
 =?utf-8?B?N0F6OS93NU40OXVRdk8zZ3lIVDlDb3hoWGtzQ2RzdGRCNHczMUs1Nk1wNG5w?=
 =?utf-8?B?bmtVTiswRzFPeUNMWVNPT3pITjBNcnhlMFArVEJJbi8rU3pvKy9GK2t4VVJw?=
 =?utf-8?B?ZlByTGJQc0FuNHlYZlFWbnpjRzZvOWtXUk8yTmF3WHRNZHVqcG5FKzdrWWhR?=
 =?utf-8?B?cExpeXFtc2I5aFJXQTU1bjVIVko1aWJWRkw4cE4yMDE2a3dRejVlN1NvQ2Yr?=
 =?utf-8?B?QzJ1a3FkTi9FQ2daWWIrNkZ4QnlGVlA4VEVScmh3bzUzM1RYNytXNytSZDRG?=
 =?utf-8?B?dFFQYTFINlJoL0tGL3hEbkVJYVlCS2htUzZUVFhvNjJjd21zUmdOd2lBOFd2?=
 =?utf-8?B?QkxsWDdIaHFHeWlzUlNJNU5YaTI0SkRwSG9rd0lXMFN3TG5ZUzU1QktBWC9S?=
 =?utf-8?B?ZlV1MFBBc2czUmc2QjA1TkxjeVdEVmZmYUJvRUhvNmx1d2g1QXRRRUpDdTFS?=
 =?utf-8?B?MW9LdEFDMENEY1BmRDV5MGl4OEpPK2JQcklQeTdwMENhWnpNdDZoU1JlYU9D?=
 =?utf-8?B?RlJmdzRJbVZUZjdINk1LU2dzN1d0U0oySlc1RHhhZU1Zamg4NndQMVNqZGlO?=
 =?utf-8?B?SW8rTzBlTno5Qlp5dktoWTM2aHRqblRGNzVxK1RyN25LY2l1d1kyK2RNSWk0?=
 =?utf-8?B?cHhoUUp0VVQyUU9jamoxSFRSYmtKbEFnb0hSN3M0Z2c1VlAvSVROdTluQUtJ?=
 =?utf-8?B?S055Y0puT2thN2dBdDBmWWl5VThxTjV2Ry9uSE1mbVZYZUhIbzJ0N1RiS1hM?=
 =?utf-8?B?ZWxrU1VncVk3dU9HZ0RYTTVKd29qZTZhdXF5VFJCbHo0aEczZmJYaXFXcU50?=
 =?utf-8?B?Rlppamg2bzdIc3lGQThJNE5PS1pzWUk1R2RPa1VzU1FnMTRJYVU0RGwwWFk3?=
 =?utf-8?B?LzhTczVWS1dHWTIrWmN3dGJtUittRzk1TmlPUjB0TlZvdjVmWUNYTGtXYkVn?=
 =?utf-8?B?WnZueEdCTWowWmlGOVdmT29nSXcwSkF3NXZuOFBXNEpCdGhrWGFZdXkyYktn?=
 =?utf-8?B?NWlhTFk0RVg3OGlMSW5xQUtXTGM3UUR3UUFuWU1vTUNGcUozMzlpT0gxbEtN?=
 =?utf-8?B?aHo5N2Vzb004UkZrRjNOTHByQTNwN3gvdmhxZ2pqMkRubkM2ajQ0cXlrK05K?=
 =?utf-8?B?aVgwYk5URis2QS9FM0hTV0IrZDRYcno1RGNzWWFyMVVMeEIxNkQvQWVUbnhk?=
 =?utf-8?B?SklsSktrT2ZhOEsyRmUwK1VFdHRDUU5lb3E3TWN1b3BGWE1lWFZlc0xkSmFH?=
 =?utf-8?B?cUFpUmxxbVRQZ2xhQW03S2VxS1pqL2dlSHZxWGlPV05SQ2dIU1lQZ2xBUis2?=
 =?utf-8?B?VkVJNEhOTGlzb0hQUDhwWFgwYk40bGtyN2IwL0NSSThOdFpydjZyZ0szUVBZ?=
 =?utf-8?B?eEpHNmE1SlE5c0pLbi9Md1NOdEJJUW5ndFc5SXV0Y3BzNjFNV2RkeDQ0RWVH?=
 =?utf-8?B?MWF3TElYYlVhTjVVRVdidHRVMVkvejVzOFN4QmtYb25Nd281VkhRcVlzQTQ3?=
 =?utf-8?B?amVRR0dCOHJMQ0FZeXZLL3E0STUzci92c3ZwLzd3U2cxSlE5SUVKOHFDSERX?=
 =?utf-8?B?RFBYM0dqeXVDb0s4S3lZTXFhMWhGZ0NRaWJGYldiMjFONUt6eHY1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407b13a7-0c0b-43c8-3283-08deef3debb4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 19:57:16.0977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVUq3FnVEysdPONDhNw0PhvkLcvvtWWH9IwsotnW52AkoHWzL3oPB2DDKAjs2BTRiTtnX7baCA+QQ4IrA4grYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999130
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



On 2026-07-30 13:17, Fangzhi Zuo wrote:
> why:
> HDMI 2.1 sinks advertise their VRR range in the HDMI Forum VSDB
> (HF-VSDB), but amdgpu derived FreeSync capability only from the AMD
> VSDB. Sinks that expose just the HDMI Forum VRR capability (e.g. HDMI
> compliance EDIDs) were therefore reported as not VRR capable.
> 
> how:
> - In amdgpu_dm_update_freesync_caps(), when the AMD VSDB does not
>   provide a valid FreeSync range, fall back to the HDMI 2.1 VRR range
>   parsed by DRM core from the HF-VSDB
>   (connector->display_info.hdmi.vrr_cap). VRRMAX = 0 means "up to the
>   Base Refresh Rate"; when the EDID provides no monitor range maximum
>   either, fall back to the Base Refresh Rate (the highest refresh-rate
>   mode of the preferred timing) so a valid VRR range is still reported
>   to userspace.
> - Add VRR debug logging along the FreeSync capability and config paths.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 +++
>  .../display/amdgpu_dm/amdgpu_dm_connector.c   | 67 +++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ccf882a22a57..223b562f7005 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5781,6 +5781,14 @@ STATIC_IFN_KUNIT void get_freesync_config_for_crtc(
>  	}
>  out:
>  	new_crtc_state->freesync_config = config;
> +
> +	drm_dbg_driver(new_con_state->base.connector->dev,
> +		       "VRR: cfg vrr_enabled=%d vrr_supported=%d fs_capable=%d vrefresh=%d min=%d max=%d state=%d\n",
> +		       new_crtc_state->base.vrr_enabled,
> +		       new_crtc_state->vrr_supported,
> +		       new_con_state->freesync_capable, vrefresh,
> +		       aconnector->min_vfreq, aconnector->max_vfreq,
> +		       config.state);
>  }
>  EXPORT_IF_KUNIT(get_freesync_config_for_crtc);
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 2deb5abae264..ebead39939a6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3605,6 +3605,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
>  		goto update;
>  
> +	drm_dbg_driver(adev_to_drm(adev),
> +		       "VRR: enter signal=%d hdmi_vrr=%d mrange[%d-%d] hdmi.vrr_cap[sup=%d min=%d max=%d]\n",
> +		       sink->sink_signal, connector->display_info.hdmi.vrr_cap.supported,
> +		       connector->display_info.monitor_range.min_vfreq,
> +		       connector->display_info.monitor_range.max_vfreq,
> +		       connector->display_info.hdmi.vrr_cap.supported,
> +		       connector->display_info.hdmi.vrr_cap.vrr_min,
> +		       connector->display_info.hdmi.vrr_cap.vrr_max);
> +
>  	/* FIXME: Get rid of drm_edid_raw() */
>  	edid = drm_edid_raw(drm_edid);
>  
> @@ -3649,6 +3658,59 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  				connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
>  			}
>  		}
> +
> +		drm_dbg_driver(adev_to_drm(adev),
> +			       "VRR: amd_vsdb i=%d fs_sup=%d min=%d max=%d fs_capable=%d\n",
> +			       i, vsdb_info.freesync_supported,
> +			       vsdb_info.min_refresh_rate_hz,
> +			       vsdb_info.max_refresh_rate_hz, freesync_capable);
> +
> +		/*
> +		 * If AMD VSDB didn't provide a valid FreeSync range, fall back to
> +		 * the HDMI 2.1 VRR capability parsed from the HF-VSDB.
> +		 */
> +		if (!freesync_capable && connector->display_info.hdmi.vrr_cap.supported) {
> +			struct drm_hdmi_vrr_cap *vrr_cap =
> +				&connector->display_info.hdmi.vrr_cap;
> +
> +			drm_dbg_driver(adev_to_drm(adev),
> +				       "VRR: HF-VSDB fallback: hdmi_vrr=1 vrr_cap[sup=%d min=%d max=%d] mrange_max=%d\n",
> +				       vrr_cap->supported, vrr_cap->vrr_min, vrr_cap->vrr_max,
> +				       connector->display_info.monitor_range.max_vfreq);
> +
> +			if (vrr_cap->supported && vrr_cap->vrr_min > 0) {
> +				amdgpu_dm_connector->min_vfreq = vrr_cap->vrr_min;
> +				amdgpu_dm_connector->max_vfreq = vrr_cap->vrr_max ?
> +					vrr_cap->vrr_max :
> +					connector->display_info.monitor_range.max_vfreq;
> +
> +				/*
> +				 * VRRMAX = 0 in the HF-VSDB means "up to the Base
> +				 * Refresh Rate". If the EDID also did not provide a
> +				 * monitor range max, fall back to the Base Refresh
> +				 * Rate (the highest refresh rate of the preferred
> +				 * timing) so a valid VRR range is still reported to
> +				 * userspace.
> +				 */
> +				if (!amdgpu_dm_connector->max_vfreq) {
> +					struct drm_display_mode *brr_mode =

Should this be `vrr_mode`?

With that fixed this is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> +						amdgpu_dm_get_highest_refresh_rate_mode(amdgpu_dm_connector, true);
> +
> +					if (brr_mode)
> +						amdgpu_dm_connector->max_vfreq =
> +							drm_mode_vrefresh(brr_mode);
> +				}
> +
> +				if (amdgpu_dm_connector->max_vfreq -
> +				    amdgpu_dm_connector->min_vfreq > 10)
> +					freesync_capable = true;
> +
> +				connector->display_info.monitor_range.min_vfreq =
> +					amdgpu_dm_connector->min_vfreq;
> +				connector->display_info.monitor_range.max_vfreq =
> +					amdgpu_dm_connector->max_vfreq;
> +			}
> +		}
>  	}
>  
>  	if (amdgpu_dm_connector->dc_link)
> @@ -3692,6 +3754,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  	if (dm_con_state)
>  		dm_con_state->freesync_capable = freesync_capable;
>  
> +	drm_dbg_driver(adev_to_drm(adev),
> +		       "VRR: caps result: freesync_capable=%d min_vfreq=%d max_vfreq=%d\n",
> +		       freesync_capable, amdgpu_dm_connector->min_vfreq,
> +		       amdgpu_dm_connector->max_vfreq);
> +
>  	if (connector->state && amdgpu_dm_connector->dc_link && !freesync_capable &&
>  	    amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported) {
>  		amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported = false;

