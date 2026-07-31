Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8180C55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 19:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4B710F3BE;
	Fri, 31 Jul 2026 19:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AcO8kxLr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87BA410F3BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 19:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1814Px360lDRaHekN48sJr8R9R39f5P4kUWqLuT7LWU9wl8OQ6aPTW2B++DWeolycTeAWJZCCRMl40X6uJ2illFe/3Bd40A5DItpwWn5DuQUlgMvdQG5WbGef2damowR+bQlhA0KYu+U7vhUtFn5P/S/Ir8yqqDfXRENlAQlt/rMoP+giaoYpRM7/ZAFRD+0HnvZ4rzb5q7gAWRW2S5vSO9mPU1pOC1DfoQoRNQYBpb/S0Ak+ZefDl9jJy4SRSvfe6nlUUBfAZON8gZntpYrGv1tBe/NLc2tgCYGn0bRlWuwpynlPI1I4PW2eKUDHWQaSYN2fJm8RFKKPbYl8CVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLscegxQLMMOF+C1xrabHpbBkdv3wW9BjAJXNsb4de0=;
 b=CKgepFpPhXu1hNzIUJ13L+lzCkj023WvpI6iYyLLPsZNQ23HpK7jyy2bLPAAXMSNnoBgwufrgz0gt+L6wlH0eVgqabpNHMLFLwdNCgN8UXDwrB7FjMrd1ibFMDgDtBXEZbyVIo+axYqqbrEaucL3940JR9ahgXFWyUwKy+CoMHeWEpvPr76K85xA5HkNqdH8KMVuQ8Qbwz4JhtG89ktddP5EuRYl6QcrraC8Kz3TxRUz4Uzs3yNYTDOnypLpJo/f29E2V7HBsw6IGntjrN3+K19YxKjq5SUDKsMhzHKkMVcK/ERI5V6xa8ZZATe5VOX7DaYLiMvh5Kqo0nD2pR6Zdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLscegxQLMMOF+C1xrabHpbBkdv3wW9BjAJXNsb4de0=;
 b=AcO8kxLro9mxLWO0cMCIMmWxS2VvPRmsFxDe/ibeETD4ApsJfGkgWy9ELP9pRoNioebDbLpskkn08cdhtxdcdVMj3o2rwKZtQzFuYghRETx9ArENVKhg2zSrs9ZDWsea4o4L5+iXlPkmSjWt2kHbUnuyUxonjiMyPa8CAA9Xn4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 19:38:02 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 19:38:02 +0000
Message-ID: <3977283e-3e3d-4078-9c20-f7f515e3503d@amd.com>
Date: Fri, 31 Jul 2026 15:37:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/display: Add 2.1 FreeSync support for AMD
 VSDB EDID Block
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260730171754.704049-1-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260730171754.704049-1-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::10) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea49860-ca8c-4b78-0f04-08deef3b3bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|5023799004|11063799006|3023799007|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: aSyM8P+czvVERVjanNIf88ZYOU0eZdV05bXkAqDOPNc6djEcltlnH/joIQg/PQjA5uxjRe8mjAChqCl/GPMcWUtlhhXWvrPvNfbT1ytoj6K7ySPnm6a7l+n7uoFiVCVQa81j8dDsbJtm6+CF5bSoTK6YCz8rQaR7dBDqut9WfWsdse9VKLtzQGBM8BFPhodss0J7cwHNd5++UvrHrbti860hbCyQ+BEgSZ6dkm1hXKDjYF7+hJt8HVNH8+Jgox+JWBFpoRJ0SrpN3U36j9Jm7nSByMFuo81OZBdEmGDpCh/R8nXft5lTv6v5SOr0FQ8sRqwnfuyR6pO4kWvyHb66TuvCZbHj86OoGcoSeRt7Ni5C7de4vkOmg9dIvpVx5MJA3ac+l7vGEmKvnKN/8F9G6AjO3vc8pApKkR4+yspV+YadcAk/tK27Z6LtRRn2Wv7KpNvRUxtHObe8aW4utV5fcOzu5nLsN/zfwj41ryX51YpheP23n+gNKqEj+sAFxMOvyH0uUU0tGdfvsrMpv1Tb5zcKxjkKLZLpz13Adz/ax2vFvVBlaO69gl3SpamaPliijbnYfU6zl/ZjtrhcPgYLzqOdB4H+X+5+hnaHLT3i4w6qxl/ZPNf7rlu3AOZVz44wM/PQqEeJD2Fx6ZP0D/YZwtosCIqv7NLAn9DKZQtzf38=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(5023799004)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVU0YU00cnRuZTUvQjNML01tNlNXaXJuYzI2MXBET2V6dDZNdCthRzYvTjJL?=
 =?utf-8?B?c3QxVzRRVERpa0RRSXJSSkRZOEZyRE1lZ1JzR2twbGpYZFNHbXVXajhFaGQ1?=
 =?utf-8?B?ajM1V0FKZXRFSWZwWUsveDF2ZlJwTndkWmRTRW1xVlhIejl0cndxMmN4NlA5?=
 =?utf-8?B?K0NSeGNFQk44WlJxRmdwTlkrVFVHUnpuWDU1Uno4V1VMOTB2eDl1TTh5Umxs?=
 =?utf-8?B?V0xCeDFYUzBqRFAxZjNVdFlDa0JQYldmbklDb29pdU9RamgySU9lRzdRRVVX?=
 =?utf-8?B?K2Q1WURwT2NmOXpuVDF3RTFMM0orRTBpeHIrY1VVMEpvYlE1T3hlMDBxa2VH?=
 =?utf-8?B?cWdtbjk1b3oxZmhlM1BQSjVLdDBiR1lvTXRqREdKejRUTS9uU0R4N2RIaVVU?=
 =?utf-8?B?bEp0VEFEb1kyc3M1dU9IdGxyNUJqdFVpRm9iZFJQK2l6NXk0eVJXcUljTWNQ?=
 =?utf-8?B?VGVsWXdzMWgwYUhYOGs4cUtnMjZFcjM3MzBtWDhOMXE4NXVVQXJBY3prV09X?=
 =?utf-8?B?RC9LcTNQeHhHNXRzSnVLYTZmUU81cmVQOXVLS3pnRTVXVzFaT09VL1VwMURD?=
 =?utf-8?B?YXh2aE1tYjJMa21POVl6QTFidG80SFBpc3c3cHVDSEhWRFNUVmNVSkF0RVJ0?=
 =?utf-8?B?VXFHQzA5SDFoY1pPZ1VISElJcW9hNGpjTjE4VnZKTDNRMkN5NHBibW5Editm?=
 =?utf-8?B?b1prUVpJcGZyMmxWS1RqMW9BSGFMTGdZT3EybFhtaVBWU2JObFFrbDNEMVND?=
 =?utf-8?B?b2NkM1NiSGt4aTE1SlQ1akxVUmdZS0RrUjFHKzZ4Nk9ScnloaFozR1o2MnZ6?=
 =?utf-8?B?MklnYndxOS9sK2QwUWRRcnlRK01PSjZPOEl0RDhZVFIwbDJJZzZObEJ4cmJY?=
 =?utf-8?B?WEpYWEtMNnc0cFN4c2VmZlZXVXBtaWlvM0padjlhN3IxS1k2aUoxYjhCeUVr?=
 =?utf-8?B?N3U2VjVySUlDOXMyNkJ5TEhOZ0pLTFR4VmFtTXhmaFU0SnFVQXhIcStXWjZ2?=
 =?utf-8?B?TWw0UmJFUmVRZDgxZkxGMENob1lwcHlZTHM4MDFFT210UDZNeWl0K1JDTUhC?=
 =?utf-8?B?Q0ZyM3ZhaElLSnppVFNJRklLV3JuM2JXdElNVTJIUXNGdW1NMGp5NG5KS3A0?=
 =?utf-8?B?T0l6K1BHaDc5MnJXdWRIZ2JGM3RDanYxL0xTUjUzL29aazNEa1JNREJJRXUx?=
 =?utf-8?B?UWI2bk9kUnZVbmp3WlNqbGZsQm1nK3VuaExMWEZZbFRobWV5SzhDR1NQd3Nn?=
 =?utf-8?B?dXV3Y2tHSy9Ca3VobHdNcEFlRmJlVTBqV3haU2Q3bHh4SURockp5K1lyTExY?=
 =?utf-8?B?Zlg2YlJvbkdxQXEwWHpHMUQ2ejJQbUFHMkVnaVIyNEl1MFlhbEJlY0lHNUtU?=
 =?utf-8?B?enV2MURXNXdtZ2xFZXhReTc2QXFiZXlQRW1HK3lvUU4zdURybFNOWG1Mb2c3?=
 =?utf-8?B?UHA2WkJCd1I0WnEwU2RDbnVhd245cXVhb2NxVmFWbHNQdHViMlQ5OGJQSWdj?=
 =?utf-8?B?ZmY5SEhCQ2xKSE9FeTNNVzJ1NGhRbU0zaDRsbEtsYlBWTEtCYXhSazNrcll2?=
 =?utf-8?B?dmw5N0E2R0pYcjhiZGtkNVNwZjFaMlJUUWJTcXJCZmZaU0ZRZytMZFcveERL?=
 =?utf-8?B?bHVzVHNXTXpLTzRFNzhHV0xYMDR5VytlUVNTN0o5TzNVYzhSNkNicEoxV2V1?=
 =?utf-8?B?Rzg3RmMxRTdHNnp0Ny9BYVJqa2tnRE80L2N0cmxCUjZEemxZSGxwcnNDdEdx?=
 =?utf-8?B?QXhqMUowYnRUYVFnY0J2WG9DZHErbGxPVEltWnVsYnJDbE02OFEwb3cwQ2Yr?=
 =?utf-8?B?dUs0YnhMUlJFRlUyU09YSFhVVXd1aG5Wc21uM01ZbnNnVnE1VTZ4enlWVGRz?=
 =?utf-8?B?K3BPclEwL2dEd0JqSEhpY3NXTUhBMFcramVob3I0aXdIWGpMNEZNaU9pakIz?=
 =?utf-8?B?aVFic0lpeDY3MDlMdXk4V1FSbHBDNVNwOThDSGJhdWo2VTlIRDdKM1V3dzh4?=
 =?utf-8?B?WGRJZHkrVnE2S2QwZUJkUXMwTm1ub1J3cW5LMmJkKzN0QjNSYzVHS25zdlM1?=
 =?utf-8?B?LzhpNW8rQVZob3NlcGkvUWtTbDNUZWxzT0FvT1Z5ZmozZmsvY3BkVU1TYmJs?=
 =?utf-8?B?QjRtTmVtZkdqUmFxek5MTlFIQUJ6UEk4bk5rclFSTmtqQ2prRmlyUTZ1clRa?=
 =?utf-8?B?eHJqS1pTRDRLc0p3R0FsQnV1MDRrZmcyU3kwL2xaTWFNMmZjRXJuUitBL1Bw?=
 =?utf-8?B?U2FSN3gwZDZLQnpZRzJTT2U2T1c5VHpCSzByYVYrNzQ5NXd0Qm52c0JBTWxO?=
 =?utf-8?B?QWprd0ZWdmthb2V5R0hFVWtVWnRNd3pMWVQ0TXN6NEpqaDZnSm9Ddz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea49860-ca8c-4b78-0f04-08deef3b3bcf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 19:38:02.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYQVfvtMmdHh6qH8nNIi3HQpJgW+SCqIAAYI7SgY/E9lVkbsl1r2lRaMkfgOKbyYARITK9TkoboAmYRNQUYYiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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
> From: Fangzhi Zuo <Jerry.Zuo@amd.com>
> 
> why:
> HDMI FRL sinks were not parsed for the AMD VSDB and no VTEM info packet
> was emitted for them, so 2.1 FreeSync over HDMI FRL did not work. It is
> backward-compatible with 2.0 FreeSync.
> 
> how:
> - Accept SIGNAL_TYPE_HDMI_FRL alongside SIGNAL_TYPE_HDMI_TYPE_A when
>   parsing the AMD VSDB in amdgpu_dm_update_freesync_caps().
> - Build and send the VTEM info packet via mod_build_infopacket_vtem()
>   when the stream signal is HDMI FRL during the freesync state update.
> - Set the VTEM Data_Set_Length to 0 when no VTEM feature is enabled.
>   build_infopacket_header_vtem() hardcodes Data_Set_Length = 4, so a VTEM
>   with Data_Set_Length = 4 would be transmitted even when no VTEM feature
>   is enabled (VRR_EN = 0 and no FVA), e.g. when the sink advertises
>   VRRMIN = 0 and vrr_capable is false. This fails HDMI GCTS HF1-58 step
>   6.2.
>   The VTEM must keep being transmitted every MTW while VRR is enabled
>   (HF1-58 steps 8.1 and 8.3), so it cannot simply be suppressed per
>   frame. Instead, follow the MLDS option in HDMI 2.1 10.10.2.4: keep
>   transmitting the VTEM but set Data_Set_Length = 0 when no feature is
>   enabled. When VRR becomes active the full Data_Set_Length = 4 payload
>   with VRR_EN = 1 is sent as before.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +
>  .../display/amdgpu_dm/amdgpu_dm_connector.c   |   4 +-
>  .../amd/display/modules/inc/mod_info_packet.h |   4 +
>  .../display/modules/info_packet/info_packet.c | 109 ++++++++++++++++++
>  4 files changed, 119 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5a9afc0607b2..ccf882a22a57 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3881,6 +3881,9 @@ static void update_freesync_state_on_stream(
>  		&vrr_infopacket,
>  		pack_sdp_v1_3);
>  
> +	if (new_stream->sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)
> +		mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vrr_infopacket);
> +
>  	new_crtc_state->freesync_vrr_info_changed |=
>  		(memcmp(&new_crtc_state->vrr_infopacket,
>  			&vrr_infopacket,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 5e3dfeaed76b..2deb5abae264 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3631,7 +3631,9 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
>  		}
>  
> -	} else if (drm_edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> +	} else if (drm_edid &&
> +		  (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
> +		   sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)) {
>  		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
>  		if (i >= 0) {
>  			amdgpu_dm_connector->vsdb_info = vsdb_info;
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
> index eee8206bc531..5181d889fe7f 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
> @@ -67,6 +67,10 @@ struct AS_Df_params {
>  	struct frame_duration_op decrease;
>  };
>  
> +void mod_build_infopacket_vtem(const struct dc_stream_state *stream,
> +		const struct mod_vrr_params *vrr, int fva_factor,
> +		struct dc_info_packet *infopacket);
> +
>  void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
>  		enum adaptive_sync_type asType, const struct AS_Df_params *param,
>  		struct dc_info_packet *info_packet);
> diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> index f5ac4bf32a78..e956c707ac50 100644
> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> @@ -291,6 +291,21 @@ void set_vsc_packet_colorimetry_data(
>  	info_packet->sb[18] = 0;
>  }
>  
> +static void setFieldWithMask(unsigned char *dest, unsigned int mask, unsigned int value)

Don't use camel-case. We should rename it to set_field_with_mask(...).

> +{
> +	unsigned int shift = 0;
> +
> +	if (!mask || !dest)
> +		return;
> +
> +	while (!((mask >> shift) & 1))
> +		shift++;
> +
> +	*dest = *dest & ~mask;
> +	value = value & (mask >> shift);
> +	*dest = *dest | (value << shift);
> +}
> +
>  void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
>  		struct dc_info_packet *info_packet,
>  		enum dc_color_space cs,
> @@ -644,6 +659,100 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
>  		info_packet->valid = true;
>  }
>  
> +static void build_vtem_infopacket_data(const struct dc_stream_state *stream,
> +		const struct mod_vrr_params *vrr, int fva_factor,
> +		struct dc_info_packet *infopacket)
> +{
> +	unsigned int fieldRateInHz;

Same here: field_rate_in_hz

> +
> +	/* FVA Factor setting */
> +	setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__FVA_FACTOR_M1,
> +			(fva_factor > 0)?(fva_factor-1):0);

Formatting. There should be whitespace around the `?`, `-`, and `:`.

> +	/* VRR Parameters */
> +	if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
> +				vrr->state == VRR_STATE_ACTIVE_FIXED) {

Formatting. The vrr->state on the second line should align with
the vrr->state on the prior line.

> +		setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__VRR_EN, 1);
> +	} else {
> +		setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__VRR_EN, 0);
> +	}
> +
> +	if (vrr->state == VRR_STATE_ACTIVE_FIXED)
> +		setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__M_CONST, vrr->m_const);
> +
> +	if (!stream->timing.vic) {
> +		setFieldWithMask(&infopacket->sb[VTEM_MD1], MASK_VTEM_MD1__BASE_VFRONT,
> +				stream->timing.v_front_porch);
> +
> +
> +		/* TODO: In dal2, we check mode flags for a reduced blanking timing.
> +		 * Need a way to relay that information to this function.
> +		 * if("ReducedBlanking")
> +		 * {
> +		 *   setFieldWithMask(&infopacket->sb[VRR_VTEM_MD2], MASK__VRR_VTEM_MD2__RB, 1;
> +		 * }
> +		 */
> +
> +		fieldRateInHz = stream->timing.pix_clk_100hz * 100;
> +		fieldRateInHz /= stream->timing.h_total;
> +		fieldRateInHz = (fieldRateInHz + stream->timing.v_total / 2)
> +						/ stream->timing.v_total;
> +
> +		setFieldWithMask(&infopacket->sb[VTEM_MD2],  MASK_VTEM_MD2__BASE_REFRESH_RATE_98,
> +				fieldRateInHz >> 8);
> +		setFieldWithMask(&infopacket->sb[VTEM_MD3], MASK_VTEM_MD3__BASE_REFRESH_RATE_07,
> +				fieldRateInHz);
> +
> +	}
> +
> +	/*
> +	 * When no VTEM feature is enabled (neither VRR nor FVA), signal a
> +	 * zero-length data set (MLDS) by clearing Data_Set_Length. HDMI 2.1
> +	 * 10.10.2.4 requires the Source to either stop transmitting the VTEM
> +	 * or set Data_Set_Length = 0 when no feature is enabled; keeping the
> +	 * VTEM with Data_Set_Length = 0 preserves the every-MTW cadence while
> +	 * staying compliant (e.g. HDMI GCTS HF1-58 step 6.2).
> +	 */
> +	if (vrr->state != VRR_STATE_ACTIVE_VARIABLE &&
> +	    vrr->state != VRR_STATE_ACTIVE_FIXED && fva_factor == 0)
> +		setFieldWithMask(&infopacket->sb[VTEM_PB6],
> +				 MASK_VTEM_PB6__DATA_SET_LENGTH_LSB, 0);
> +
> +	infopacket->valid = true;
> +}
> +
> +static void build_infopacket_header_vtem(enum signal_type signal,
> +		struct dc_info_packet *infopacket)
> +{
> +	// HEADER
> +
> +	// HB0, HB1, HB2 indicates PacketType VTEMPacket

Formatting: convert these C++-style comments to C-style.

> +	infopacket->hb0 = 0x7F;
> +	infopacket->hb1 = 0xC0;
> +	infopacket->hb2 = 0x00; //sequence_index
> +
> +	setFieldWithMask(&infopacket->sb[VTEM_PB0], MASK_VTEM_PB0__VFR, 1);
> +	setFieldWithMask(&infopacket->sb[VTEM_PB2], MASK_VTEM_PB2__ORGANIZATION_ID, 1);
> +	setFieldWithMask(&infopacket->sb[VTEM_PB3], MASK_VTEM_PB3__DATA_SET_TAG_MSB, 0);
> +	setFieldWithMask(&infopacket->sb[VTEM_PB4], MASK_VTEM_PB4__DATA_SET_TAG_LSB, 1);
> +	setFieldWithMask(&infopacket->sb[VTEM_PB5], MASK_VTEM_PB5__DATA_SET_LENGTH_MSB, 0);
> +	setFieldWithMask(&infopacket->sb[VTEM_PB6], MASK_VTEM_PB6__DATA_SET_LENGTH_LSB, 4);
> +}
> +
> +void mod_build_infopacket_vtem(const struct dc_stream_state *stream,
> +		const struct mod_vrr_params *vrr, int fva_factor,
> +		struct dc_info_packet *infopacket)
> +{
> +	//VTEM info packet for HdmiVrr
> +

C++-style comment

> +	memset(infopacket, 0, sizeof(struct dc_info_packet));
> +
> +	//VTEM Packet is structured differently

C++-style comment

Happy to have all these style comments fixed separately in an amd-dal commit
or a new asdn commit.

Either way, this is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> +	build_infopacket_header_vtem(stream->signal, infopacket);
> +	build_vtem_infopacket_data(stream, vrr, fva_factor, infopacket);
> +
> +	infopacket->valid = true;
> +}
> +
>  void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
>  		enum adaptive_sync_type asType,
>  		const struct AS_Df_params *param,

