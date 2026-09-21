Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314F7C982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 19:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C587510E2A4;
	Mon, 21 Sep 2026 19:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n1r/+sEK";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAF210E008
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 19:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfDcllmAZkfA2l2WMSvuYAzkIqWTrrXXhfbQmnLNrGAZoJc3mFZyKzM68OmY9ZXHiCAjlM+LEcLX0Z7SmcH78p28SW9rctO383B7e7Ms8PMIpDXw8Yoji07QXs4E+qMBFghtbrKJ6GzhTYGyJqf9vZtpArZPwlGPfjb5SdQ4cSm1ZcSTE2Ly2ois9+9k1AbBilawQcYhJeGp8sYp/Wbs3T3H+3X0IRdQv4EV2xf+UtgJi2gNRsXeQc2I5jZ2HjZocgoCrHGrKsgVxnYwl9/fpNYwgAEstPcGXHYowim6Lw+bl9KjNuB8BOG5MwGL42l5hYV7eO+ShnvEYe6ovS89jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kA49qgPppURuj92T8ZfTs4I8Lpqt06xKljTZnHg2YwA=;
 b=MQhoQHDXZUrEQ4jw07KMQo/69aagKKgrMD34c0Zyy+UIM7/+82PDbFLHNH/Ltqmfj4fNu7M8UOZJv5vud5p6RUTbV7+SUrTGbvnNg4O143ICCkZKHP4dXUhD0fToE0FUeynnooG16Q9nobt/Cy9232MHmfBIHurS7wAvdFcBIWu2lpuTjumyQTkU1Y7kxDLqp0VOuuL/KhV6kd1YWBLl9MXsCVqj/zek+mHRaqguQvcJUg+GlNVMNJ16dc5eN6UBS2EeeaSzuc7cnePBILYQ+8vNAAo54Z4voq4UYXBsV3fafs1I2yDNJn+qbYIvGnKWuMbWX4+4rG9gD95FmaqxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA49qgPppURuj92T8ZfTs4I8Lpqt06xKljTZnHg2YwA=;
 b=n1r/+sEKS6RN0OPOf+iP7Gavrp8qNQBgx35aVJCsoEmmgdtA/PmpNb1bIeNQqTAbRjL9RiYcuQy7I+aNnZdKyt0fnhMLUWDBgogYddSTU321klk/jGG3CyazoJk1wA5A/xyguk49S86bz8O1BlPDIqNxUTWXLT2afpbhUmzYnbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:41:08 +0000
Received: from SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958]) by SA1PR12MB6970.namprd12.prod.outlook.com
 ([fe80::a65f:48fc:86fb:e958%4]) with mapi id 15.21.0428.014; Mon, 21 Sep 2026
 19:41:08 +0000
Message-ID: <2dff79db-bfa9-48ce-94c6-c467a85c8b8e@amd.com>
Date: Mon, 21 Sep 2026 15:42:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: only allow freesync on a VRR_ENABLED crtc
To: amd-gfx@lists.freedesktop.org
References: <20260909195906.3584191-1-matthew.schwartz@linux.dev>
Content-Language: en-US
Cc: matthew.schwartz@linux.dev, Fangzhi Zuo <jerry.zuo@amd.com>,
 Leo Li <sunpeng.li@amd.com>
From: George Zhang <george.zhang@amd.com>
In-Reply-To: <20260909195906.3584191-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::23) To SA1PR12MB6970.namprd12.prod.outlook.com
 (2603:10b6:806:24d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6970:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd0c0d9-39c3-4a51-0f1c-08df18184862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|3023799007|11063799006|18002099003|22082099003|5023799004;
X-Microsoft-Antispam-Message-Info: qqkNMZ1kpgEgzPEaDUDaPOWCrG/XJd10jU8BoB94qxCioNsZTZU6cMwWzJpSCm4H+cYqqkP6OgrZwH6lpNmUpkeDABVokCrWRZI/LkD/tRDWa4Sr5ujqxQSSW++hlcKQOc7AX2OfT6UIvsQt54GEQ2F8VRN9agKMyy00z1wIpuVy9VSPttgllO/BDEzDPWcVw7pdtIZDsT5Be824fHA1Kcfki/eXqhdOxsdaU/ytISYv7KC7if7L0uBHh1Wbc7GFKcB57bCcsMPuOJrJU/KcReHXNbyGQNhAlaYC85h4J55UkLU7pY0dcq5l20SEMKChd6gjWs+pXAlEj0TybMk+y+tNZiZ9PmM9Hj8jiO4ESRtMRBtyaeDrr/gQJeOQikWm8ST7/Kmn9q0auyt7GGNSDKrx7C0I4ZtruIfvvX4kKugr95EKHJGO7vMRSLCJi5bi1mL9k4T3QT0MVUsMyXZBjTugWilwP0Dd5Ge6uwnSIJr9SVzwPoZ9bhygt5wQG4w81xj2PBQ6XwlnDs1eEmTT+J2E94L34vivmJpFjkI/innaJ8hDroXE6V72faasp1XC0Ou32AVI915oBeEPwWB+s9cDQwvalFOBmSDomNaat7eLB5jK4OU6Vzg60KsbRa67V4Q+oi35fIcba25gR09u+8SBGjJxoWMq04JjuGvqmXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6970.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWo2bXVqNWRVeHdJdEtvdm5UcGJ6SXJEOTZrc1c2LzdsRmJSR256VkRuQ1Iy?=
 =?utf-8?B?Z3poRE9QazgzdGdLRFBNckY2UFY3ZmVOanoyMFN4eWZGYjR5eWNwVnlyQU5M?=
 =?utf-8?B?dEhaSWZWa2xpVUxDdlozT1g3QmVNUHpiVDU4T3l4QTRHZTRRUlpRWTE2cjIr?=
 =?utf-8?B?bW5YWC90bEJWVHNGOWxKVjU3SGJUT0RHdng3YlRHQnJNMVF4SDlRdy9KYklY?=
 =?utf-8?B?ZUMwUEZkZ3htVDR3K01EVkRVWk5ud01nN2lvbVpCbDRkSGlLaFFTQVhKMmwx?=
 =?utf-8?B?M1ZQS2tpMzE3ZS92cEJtaDRLaW5CYlF1UWZpNGd6eDZ3R1FsbnBkNWsxVkRp?=
 =?utf-8?B?MUphaVd4a2VQTGpiNVBzS0U2cHhHU0dteFdvUjUzZERBUEdWcThHS2U4WUVy?=
 =?utf-8?B?RmwrV2RUdFhsWmNLbUJWcnlBVVpHYjl4QXRuZ1JubGpndGkvU3paY3NhRS9M?=
 =?utf-8?B?OVdnSmwxSzNVTmlRRERUNnBBbHp4dHVlRUpoVnRzN0JkNHArLytHcllUTjgw?=
 =?utf-8?B?YUZGR1ovT3AybFgyM2xwZjVxRW9reVpIMFpUUUFsQUMzVTdpdWx2K1pWV3Nj?=
 =?utf-8?B?V0cveTZUNmt1cUNwanJGaTdXelhlQ2VPMVdoODBpYllsN1U5QzFZVEZZODdr?=
 =?utf-8?B?eFFxQmFSblN2MWZ1NUNhaTgrZ3lKZ21wL2QvVjlFd0dwUWRlM0E3TzdOaEdv?=
 =?utf-8?B?QWlrQ0Jaemg2MExqWTBkajZoTVV5VDFVKzNjM2xvOFI2N21ISmFtaDE3MVpy?=
 =?utf-8?B?UU8vVFM4cXptRU1nVk96dTE3VlpDaDVaek5ZOGtxZ2ZOdVJWaFZSWXk2R2JX?=
 =?utf-8?B?L0JvdEZJSmVaZWVpYlczTHFTWlk2NFM0MkJmTTVTaHZGTGordlR6RzVhR0N6?=
 =?utf-8?B?S2sxb2F6L3RFeWo0WHdCYWZvKzB3dTJ4SDdOM3lnNzZVSFZJc2hZZUw2c3d3?=
 =?utf-8?B?a3N1VzVUdkFRZW1vM3o5ZzBIUHdub2JqMUlta3laNTFoVFcwNzgyWEtVTVVZ?=
 =?utf-8?B?c00vK1laNERVWHVFaytoaTNGU1F0UnNXeXB6Ykl1a3hkRGdMS1p0dXlkRTI5?=
 =?utf-8?B?Y2NOV3FNc2Z2OU1VcnlxK3J3cE9FRVVUc1RGZlV0U3NSSHRiVGpRK24yUTg3?=
 =?utf-8?B?MHRub1Z1ZndwRnRDejVzZVJSMURDZmJkK0oyVkNTUXVEcjJLTU9WTVB5UlE4?=
 =?utf-8?B?QURoM3N0RnBBeitzYW9TdlFPcnZ3enErQVppdEp1TVkyMFdEMWxWM3IzRndF?=
 =?utf-8?B?T0Z3Uy8zdWxDU01rcXJSS3k5Yk5qckR3dFpLa3J1eVltb2dnZzBDNm9peDVo?=
 =?utf-8?B?MEFnYjN6ai9zTlZ5TkxVeFVBSy8yRm5PUnp1cm5uZ0p2bWVCWUQ1S3I3U1ZP?=
 =?utf-8?B?WWVWRHVGY0JsL1ZhVlRNMTM4aG0zcXNWNWNLb0REL0YzODBBOUVQbVU1YTRj?=
 =?utf-8?B?UWZzdDNTNU55WGsxeC9RKzJueVAwN2Y0Z28xT2JwdFhQelc4YmlyUU9ZUDV1?=
 =?utf-8?B?ZnY5RlhtUGIwdjR4NGF4MlBwZVdBdlY3djhSSW9JMWlQYmRlNGpOSFV2U0g5?=
 =?utf-8?B?eERMeHppYTdjYW5iK3hNUWRlYU15ODBaOE56Vm1BRHUwckxSZXpjall4bkFR?=
 =?utf-8?B?UThKSTZucHNFajd1V2U0SUl4WUl6eXE5ZUdsanFXUGk0WFhPS29sdlJhT2Ju?=
 =?utf-8?B?NXBVOGRBVENMTzdobDRTYzRZTmdYa2VWQWVuZ2hFQWRsSWJGVHpFS1VmT3Zq?=
 =?utf-8?B?SnFhWDZ6cEdicEtMMnlGWHpJK3gycEVDcXlLb1JML0ZQaEhHZms0ajgvOW1L?=
 =?utf-8?B?U0k2WjZRM0dQYjVtbk1sTnpjUzI3Z2RRc3FGQkVyVXJtWUxHWEExbVRZQ0pR?=
 =?utf-8?B?MkdhWTFES2lCdm1uMUNqUEY3dDRQZ0lRQ2NzVzhsY05iUFNkbCt4OTYvMWZM?=
 =?utf-8?B?Y29FTTFLbXRuS3p0dFZYa01WR2hQSjlSWE4rZmk1T093Y2duTllDMW5jY0F3?=
 =?utf-8?B?UEUvcEVFa0FsenZiZmswUXByWXdxUFhBNitlbzZUVnBDbnpNUjhTMVdDMnVF?=
 =?utf-8?B?cENZODRoZzNpczNjVCthcm5lUU5iZnA1TXYyblVCNk5taWE5UC80dEhqbUsx?=
 =?utf-8?B?NU81UExXZm5XRWUrRFMxQ25RekdMRURNT01NcGY2bHo5ZmhXZHhmNzN4MDVC?=
 =?utf-8?B?NlZrNzR0MGJBcitDaVMyWFNCbUw4UTMxcjRoS1V4Q3hYU3daeEY5cG4rWmdJ?=
 =?utf-8?B?K1kyTVZBcE1hQndyNE81cUxMMDN6bExjNW5QdXVxVVBoMGFyZkpEazhCYWxB?=
 =?utf-8?B?SVdlQzlhSGtNbXNPa0JUNDJRdm9VbG5TdU42b0lkRlVnZ0I2WWlrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd0c0d9-39c3-4a51-0f1c-08df18184862
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6970.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:41:08.4216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/wluc//931vC5JXNEQgJpAXDf5EKLFhnpAzFWj43dMe/V42HGv1HWcI+JZjUSRtdtLDVMsBbAh2Hhtr+tnaFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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

Hi Matthew,

A bit curious on what this patch is fixing. Do you have any more context 
behind the motivation for this patch?

Thanks,
George

On 9/9/26 15:59, Matthew Schwartz wrote:
> VRR-capable sinks set allow_freesync even with VRR_ENABLED=0, letting
> FPO stretch frames during UCLK switches. On a Navi 33 driving 4K120
> through a DP-HDMI PCON, a 40fps compositor limiter then runs at 37fps.
> This surfaced after commit d49086491bcb ("drm/amd/display: Adjust
> freesync pcon whitelist").
> 
> Allow frame stretching only for VRR_STATE_ACTIVE_VARIABLE. Store the
> proposed permission in the private DC state so TEST_ONLY and failed
> checks cannot change the shared stream. Apply changed permissions at
> commit and force full DC validation, including native DP and eDP.
> 
> Fixes: 7eaef1163b82 ("drm/amd/display: set allow_freesync parameter in DM")
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++++++
>   .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  1 -
>   drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +++
>   .../gpu/drm/amd/display/dc/core/dc_state.c    | 31 +++++++++++++++++++
>   drivers/gpu/drm/amd/display/dc/dc_state.h     |  6 ++++
>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 ++
>   .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  9 ++++--
>   .../dml21_wrapper/dml21_translation_helper.c  |  9 ++++--
>   .../dc/resource/dcn30/dcn30_resource.c        |  2 +-
>   .../resource/dcn32/dcn32_resource_helpers.c   | 10 ++++--
>   10 files changed, 92 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f49cc198fb0d..09c088b878bb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3835,6 +3835,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>   	unsigned long flags;
>   	u32 target_vblank, last_flip_vblank;
>   	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);
> +	bool allow_freesync = acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
>   	bool cursor_update = false;
>   	bool pflip_present = false;
>   	bool immediate_flip = false;
> @@ -4146,6 +4147,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>   			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>   		}
>   		mutex_lock(&dm->dc_lock);
> +		if (acrtc_state->update_type == UPDATE_TYPE_FULL &&
> +		    allow_freesync != acrtc_state->stream->allow_freesync)
> +			bundle->stream_update.allow_freesync = &allow_freesync;
>   		update_planes_and_stream_adapter(dm->dc,
>   					 acrtc_state->update_type,
>   					 planes_count,
> @@ -5413,6 +5417,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   	struct dc_stream_state *new_stream;
>   	struct amdgpu_device *adev = dm->adev;
>   	int ret = 0;
> +	bool allow_freesync, old_allow_freesync;
>   
>   	/*
>   	 * TODO Move this code into dm_crtc_atomic_check once we get rid of dc_validation_set
> @@ -5668,6 +5673,27 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   	amdgpu_dm_get_freesync_config_for_crtc(dm_new_crtc_state,
>   				     dm_new_conn_state);
>   
> +	allow_freesync = dm_new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
> +	old_allow_freesync = dm_old_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
> +
> +	/* Keep the proposed FreeSync permission in the private DC state. */
> +	if (dm_new_crtc_state->stream != dm_old_crtc_state->stream ||
> +	    old_allow_freesync != allow_freesync) {
> +		ret = dm_atomic_get_state(state, &dm_state);
> +		if (ret)
> +			goto fail;
> +
> +		if (!dc_state_set_stream_allow_freesync(dm_state->context,
> +							dm_new_crtc_state->stream,
> +							allow_freesync)) {
> +			ret = -EINVAL;
> +			goto fail;
> +		}
> +
> +		/* DML must re-evaluate FPO when the permission changes. */
> +		*lock_and_validation_needed = true;
> +	}
> +
>   	return ret;
>   
>   fail:
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index 281c6cec9f4b..9f40064d13c5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -253,7 +253,6 @@ void amdgpu_dm_update_freesync_state_on_stream(
>   	new_crtc_state->vrr_infopacket = vrr_infopacket;
>   
>   	new_stream->vrr_infopacket = vrr_infopacket;
> -	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
>   
>   	/*
>   	 * HDMI ALLM: when Gaming-VRR is active (VRR_EN=1) and the sink
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index ebbd81995c38..6064cc992d91 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3175,6 +3175,10 @@ static struct dc_update_descriptor check_update_surfaces_for_stream(
>   		if (stream_update->mst_bw_update)
>   			su_flags->bits.mst_bw = 1;
>   
> +		if (stream_update->allow_freesync &&
> +		    *stream_update->allow_freesync != stream_update->stream->allow_freesync)
> +			su_flags->bits.fams_changed = 1;
> +
>   		if (stream_update->stream->freesync_on_desktop &&
>   			(stream_update->vrr_infopacket || stream_update->allow_freesync ||
>   				stream_update->vrr_active_variable || stream_update->vrr_active_fixed))
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> index 1e4fe2f941ca..382858b6c1da 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> @@ -425,6 +425,7 @@ enum dc_status dc_state_add_stream(
>   	}
>   
>   	state->streams[state->stream_count] = stream;
> +	state->stream_status[state->stream_count].allow_freesync_valid = false;
>   	dc_stream_retain(stream);
>   	state->stream_count++;
>   
> @@ -746,6 +747,36 @@ struct dc_stream_status *dc_state_get_stream_status(
>   	return status.stream_count > 0 ? status.stream_status[0] : NULL;
>   }
>   
> +bool dc_state_get_stream_allow_freesync(const struct dc_state *state,
> +					const struct dc_stream_state *stream)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < state->stream_count; i++) {
> +		if (state->streams[i] == stream &&
> +		    state->stream_status[i].allow_freesync_valid)
> +			return state->stream_status[i].allow_freesync;
> +	}
> +
> +	return stream->allow_freesync;
> +}
> +
> +bool dc_state_set_stream_allow_freesync(struct dc_state *state,
> +					const struct dc_stream_state *stream, bool allow_freesync)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < state->stream_count; i++) {
> +		if (state->streams[i] == stream) {
> +			state->stream_status[i].allow_freesync = allow_freesync;
> +			state->stream_status[i].allow_freesync_valid = true;
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>   enum mall_stream_type dc_state_get_pipe_subvp_type(const struct dc_state *state,
>   		const struct pipe_ctx *pipe_ctx)
>   {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_state.h b/drivers/gpu/drm/amd/display/dc/dc_state.h
> index acf461225e9d..40ad063cec09 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_state.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_state.h
> @@ -81,4 +81,10 @@ struct dc_get_status_options;
>   enum dc_status dc_state_get_status(struct dc_state_status *status,
>   	const struct dc_get_status_options *options);
>   
> +bool dc_state_get_stream_allow_freesync(const struct dc_state *state,
> +					const struct dc_stream_state *stream);
> +
> +bool dc_state_set_stream_allow_freesync(struct dc_state *state,
> +					const struct dc_stream_state *stream, bool allow_freesync);
> +
>   #endif /* _DC_STATE_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> index 934ae381e730..14d8da9f15e5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -62,6 +62,9 @@ struct dc_stream_status {
>   	bool is_abm_supported;
>   	struct mall_stream_config mall_stream_config;
>   	bool fpo_in_use;
> +	/* Proposed permission for validation, without modifying the stream. */
> +	bool allow_freesync;
> +	bool allow_freesync_valid;
>   };
>   
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index b5bd1358fdfd..a816e47153ad 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -844,7 +844,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
>   			continue;
>   
>   		if (dc_state_get_pipe_subvp_type(context, drr_pipe) == SUBVP_NONE && drr_pipe->stream->ignore_msa_timing_param &&
> -				(drr_pipe->stream->allow_freesync || drr_pipe->stream->vrr_active_variable || drr_pipe->stream->vrr_active_fixed)) {
> +				(dc_state_get_stream_allow_freesync(context, drr_pipe->stream) ||
> +				 drr_pipe->stream->vrr_active_variable ||
> +				 drr_pipe->stream->vrr_active_fixed)) {
>   			drr_found = true;
>   			break;
>   		}
> @@ -3444,7 +3446,10 @@ bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context
>   				uint32_t height = subvp_high_refresh_list.res[i].height;
>   
>   				if (dcn32_check_native_scaling_for_res(pipe, width, height)) {
> -					if ((context->stream_count == 1 && !pipe->stream->allow_freesync) || context->stream_count > 1) {
> +					if ((context->stream_count == 1 &&
> +					     !dc_state_get_stream_allow_freesync(context,
> +										 pipe->stream)) ||
> +					    context->stream_count > 1) {
>   						allow = true;
>   						break;
>   					}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
> index 3c25de54d55b..031f90955b95 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
> @@ -125,6 +125,7 @@ static unsigned int calc_vblank_nom_lines(const struct dc_stream_state *stream,
>   }
>   
>   static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cfg *timing,
> +		const struct dc_state *context,
>   		struct dc_stream_state *stream,
>   		struct pipe_ctx *otg_master_pipe,
>   		struct dml2_context *dml_ctx)
> @@ -166,7 +167,7 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
>   	timing->drr_config.enabled = stream->ignore_msa_timing_param;
>   	timing->drr_config.drr_active_variable = stream->vrr_active_variable;
>   	timing->drr_config.drr_active_fixed = stream->vrr_active_fixed;
> -	timing->drr_config.disallowed = !stream->allow_freesync;
> +	timing->drr_config.disallowed = !dc_state_get_stream_allow_freesync(context, stream);
>   
>   	/* limit min refresh rate to DC cap */
>   	min_hardware_refresh_in_uhz = stream->timing.min_refresh_in_uhz;
> @@ -923,6 +924,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
>   	struct dml2_display_cfg *dml_dispcfg = &dml_ctx->v21.display_config;
>   	unsigned int plane_count = 0;
>   	struct pipe_ctx *otg_master_pipe;
> +	struct dml2_timing_cfg *timing;
>   
>   	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
>   
> @@ -952,7 +954,10 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
>   
>   		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
>   
> -		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], otg_master_pipe, dml_ctx);
> +		timing = &dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing;
> +		populate_dml21_timing_config_from_stream_state(timing, context,
> +							       context->streams[stream_index],
> +							       otg_master_pipe, dml_ctx);
>   		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], otg_master_pipe);
>   		populate_dml21_writeback_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].writeback, context->streams[stream_index]);
>   		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index], &context->stream_status[stream_index]);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> index dbb8bb7fc20d..5333c4cc9eba 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
> @@ -2152,7 +2152,7 @@ bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc,
>   	if (!is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(context))
>   		return false;
>   
> -	if (!context->streams[0]->allow_freesync)
> +	if (!dc_state_get_stream_allow_freesync(context, context->streams[0]))
>   		return false;
>   
>   	if (context->streams[0]->vrr_active_variable && (dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE))
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
> index 602a0e4e5dc0..a86d3111703f 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
> @@ -579,7 +579,7 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
>   	if (!is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(fpo_candidate_stream, fpo_vactive_margin_us, refresh_rate))
>   		return NULL;
>   
> -	if (!fpo_candidate_stream->allow_freesync)
> +	if (!dc_state_get_stream_allow_freesync(context, fpo_candidate_stream))
>   		return NULL;
>   
>   	if (fpo_candidate_stream->vrr_active_variable &&
> @@ -673,7 +673,9 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
>   				non_subvp_pipes++;
>   				drr_psr_capable = (drr_psr_capable || dcn32_is_psr_capable(pipe));
>   				if (pipe->stream->ignore_msa_timing_param &&
> -						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed)) {
> +				    (dc_state_get_stream_allow_freesync(context, pipe->stream) ||
> +				     pipe->stream->vrr_active_variable ||
> +				     pipe->stream->vrr_active_fixed)) {
>   					drr_pipe_found = true;
>   				}
>   			}
> @@ -734,7 +736,9 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
>   				non_subvp_pipes++;
>   				vblank_psr_capable = (vblank_psr_capable || dcn32_is_psr_capable(pipe));
>   				if (pipe->stream->ignore_msa_timing_param &&
> -						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed)) {
> +				    (dc_state_get_stream_allow_freesync(context, pipe->stream) ||
> +				     pipe->stream->vrr_active_variable ||
> +				     pipe->stream->vrr_active_fixed)) {
>   					drr_pipe_found = true;
>   				}
>   			}

