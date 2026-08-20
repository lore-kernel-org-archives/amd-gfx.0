Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC07C5DF85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 14:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93FD10E1EB;
	Thu, 20 Aug 2026 14:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iWAWrFkX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E2610E1EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 14:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiRtruInLabMEHc9bcChgot0nuxhAG71w14dBFcx8M06tKr/rZLJvxNrOMjn2GQIAUo8/JbyqeAuCt9M1J0/G3GN9C2UIKrvuPUzPIZHRUsLIWhsgt43YePfPHVdC1mtT+B47D8C+xGZuHDdTJlXftwFxpS+4p4Z1kYvEH2fb0aYXtDwFXS75EpMn77o537ViGA64ezssoSjtctr3yh39zarLukdqhD25uW685LTg6EvD8f7JcII6nJcWehlDfeCCvBkYrMjF//+aoX63ANI/BO0VhfXsskMKNSWpeXYfSW/kp3p4CVyiSIRxjiZhkjw7BP2+TyRsdsuq3DuqiOuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86dDJlz/iZ5XufLCqZu+Oi9O2az6E2n9kV3zIG0ujmU=;
 b=WknnEKPoErcUKXdTQyRrS1Ycf6bGlGlkYH11MCdXc0sl3gJBEhvWzM7u9P1KNDf/yo641hvLNYv0Ys6aGkb68cfCS0md1MNwTjLYZaziDzZDRRAesddyYGf+CAkxdpqJVm8eGB2Lsz8BkF10lgjJi4437simXLMGo4+O90P2jEn8ahpeT1vrh00KeranshF+0YIad2S6A1DxUYUdTgR+moiua5dJ/r+Z4JQJBSbMse2SzGH1XJBaap+74UnNuxyA1gif8jBNsvc1n63GKdn6qPMYY3WR66sAyaoeRmvSwqi7zcC6Ie5yrr5w/SI+6LTISt0qStNHyIGfQ7U3NZkeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86dDJlz/iZ5XufLCqZu+Oi9O2az6E2n9kV3zIG0ujmU=;
 b=iWAWrFkXe6NlNTLtHjB54vTKPzqUtoCeFdOU6jBKzLvbahzljyfqzO9q71l7K8AFRLYAhz5Jzc0JBiFL/dBn3YKysTL2mE0cWBc3treajSparaxWoFG2NePns/w0mEv8BhL4FMW3Jhk0tE5g80T6fBAnpcoLhFk1AaNvZVDK7rU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 14:16:09 +0000
Received: from IA1PR12MB8407.namprd12.prod.outlook.com
 ([fe80::f019:2dab:3201:df90]) by IA1PR12MB8407.namprd12.prod.outlook.com
 ([fe80::f019:2dab:3201:df90%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:16:09 +0000
Message-ID: <43b83aa1-079e-45c0-85d6-bae17b4e9098@amd.com>
Date: Thu, 20 Aug 2026 10:16:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] drm/amd/display: Fall back to overlay cursor on dcn4x when
 top plane doesn't fill CRTC
To: IVAN.LIPSKI@amd.com, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>,
 James Lin <PingLei.Lin@amd.com>, Harry Wentland <harry.wentland@amd.com>
References: <20260820141339.343372-1-IVAN.LIPSKI@amd.com>
Content-Language: en-US
From: Ivan Lipski <ivlipski@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260820141339.343372-1-IVAN.LIPSKI@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0415.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::25) To IA1PR12MB8407.namprd12.prod.outlook.com
 (2603:10b6:208:3d9::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8407:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: fff21f72-47ba-4a52-c763-08defec594d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|18092099006|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8msCoSKAgjX8Xw8pWWJUzCAgAELcVbC2GpffkqhVcJqPeaqs5rBwd6WJWQEyxyC+bigKVziHuIbjvYhc2LY6M+bqd5sm15Rxx8YDP6rN88x9RYyEWrLpdLxyiM/mZ2rA7zmDGlk1kPnXXCGea1n2cAA/DIzmTXBAbbu93f1HMAGwuUBMLQn045mr6878Hf+A3bQYsfyOxW7Fukaz9TZJKJTnRQuq7O9Fs3Rzawt//+MSg3hhSc5tYtTHXmBLXYnnrJrBzdqlaseszYJrM37Z5/kn3VEdT87tM/OjI57tpmZdXnpA2SpTf3CZ96BsMTxC942FokolFrgTdbHPPtl9i0wtbzVW0wogihPbT+yWz0KBDVvGR/fNv17SWNm7TaP39AJmo6+AFcTYb1kgh9kkiYzFthvYHNk5koMy2xGVHqKV/R7HWLmcBt+A7Gh+lp6/U3pz4w5R7b3AZ9oH9E0Ikh7mLdpHvUJseXlXkXCaz+J2+ziUoCWdrexne6CoX3keSnBjz2fOsdQGsi/YcNROEHmPDXlRs5Jyn6T3Q+k+kIVzxy4rvSwFL6JI7lkjdpxXFPtWhJrbzhvM3Vt5pTbEk2l2XCwROf92H/T7R6m+O5KPS0vrK1of6d6rdOBRYcJiUptsne/Q86DRcoWG0SO0zb3Z0ogk4penEWuQ+eM0umQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(18092099006)(11063799006)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWgzbVVmenBHaTl6U0kzL25ZbjZRaEw1RnJwczBxb0dCWDkzSk5DQjZIZUxM?=
 =?utf-8?B?SnVkeEJBS3VEVUpTVlc3UEhUbnBhOTdyUFc5aitlSlFMVlF4VU1QRzNyZVhj?=
 =?utf-8?B?NTliQTRBb2hUd1Z3R1dIdWt2Q2l3MVRidGIyMDhJUjNjNkI1S2FnMTlteVhV?=
 =?utf-8?B?eWNWME91ZStVbDBkUHQ1Q0FydVhmVVM3Zkg2bUlLSDJ2bGlvSzFMazl6WUVM?=
 =?utf-8?B?WE5lWUx4ajRUUm5HUEtJYkxidWhoQ1RjWU0xOHZ0T0s1YXpqczBBakVOQi9Z?=
 =?utf-8?B?V1ZPMzIzYjNhWko1c2tLeFpnTE05L1prOXdWRnRRamZSSVBuQ0FmbjhMYkU3?=
 =?utf-8?B?SXZ5UW9kNTRZa1RjT1hOWlJzMEErYmtxOEJVd1UzZkFNQkI2bm9UazhBc2xG?=
 =?utf-8?B?SXViVzJZTnNYNW9ZajZXSm9yb3N3bVRZU3Y5MjhnWGRqbGUxOHYraEIxaXFu?=
 =?utf-8?B?S0c4TWRHL05IdGdZc2cwbzA3OEwwVUM0V2RXODlIaVZKWXFPT3BTSVRMM3Vr?=
 =?utf-8?B?aVhyR1R6eVpHenBIVjg4SkFuRXppMHg2d3Q4ckZaQW41ZVRueVd2RHUreTV3?=
 =?utf-8?B?Tjlua0RPeTR1WFNaV2RrUGQxL0kxbTVxN1R3cndWcnE0K1B5a3FzZW1zNHJQ?=
 =?utf-8?B?dzZsdFNCSE5zYzF5RDd4UTd4dnNERzNSc1NnWWd1OUNhY2lXYnI1a3MyWXVa?=
 =?utf-8?B?cUlvOVpuTHErdUN2RU8zUWVqN1kwTzVjcm4rZFRvbUpYclhidTFUZXRMcFJu?=
 =?utf-8?B?LzVMMnF3MDNzbjNvU1lFMjVFamF4d1RmWFN5Rm5aM0JLOUtOOFlsVVR5ajRD?=
 =?utf-8?B?ZGNqQjJGdFNzMjF3azZRWDN4SkQxL3VLZ2FPR0tMaXlIQXIvWmJSQVZTT1d3?=
 =?utf-8?B?REJjdGdwS0lFU1haVWk1V2FMWjFuNnAxOTk5bStoYzFBMHFIYlhGMUNTclQw?=
 =?utf-8?B?UlJ4U0tDaCtwVkhkVnZjTmtEcXk4Qk53WEZwRHFZWnJuOUVnVVZHN0tXNXpD?=
 =?utf-8?B?Z1Y2OEw3UVI1QVAxdW5idWoxdzFrblVXKy9LQUhTNnZBU3hEQlBkVWhWQ01H?=
 =?utf-8?B?U3pFVXB6MnV5N2NBeW5LR09rUjhWc1hmTFdrek1mcVF5ZWMvN3pFN2pvdGYr?=
 =?utf-8?B?cVdRYmxWdkg4d0t2cUczT2xPRmlLc05WMWRNUWJHVlhMTW5KY28vdk5pKzhJ?=
 =?utf-8?B?UTRiRmJFZDM4bGgxQ0dMQzk1Tm9mMjIzMkJVRWZHalVlRUNhSkRZOUV6Mm1S?=
 =?utf-8?B?dzhTR3RxZlVQTEpiQncrNm5EWDErT1BraHNWbVBGcHJzYmdBUXlWUW9WUmJI?=
 =?utf-8?B?U1QvQkcrQTFySXkwMmJUWm81TXcwYTFpUXUyRWpQdkxUYUM4Z3ZIV1ZTWGVw?=
 =?utf-8?B?WWZOdXRLNWdGUzEvZTBTbko4aktESHk0VXE5LzZoc0JhVCsvOEREYjFRVTZD?=
 =?utf-8?B?OERvdjRuYkl1Z1V4ZEhkYjY1K01aTUtVcE13QXcxSVhlZzc4UUlYbTRKVUhp?=
 =?utf-8?B?M1AvYU9pdVZNYzlKYWtyTldqTTdKR1JMa3A4OXJQanhwQ2xNdE1HY1dGTy9K?=
 =?utf-8?B?aEg1SmhINEZxa1VXdVVzeUQ2REdsNHczU0tQSlBQNWhJWFNSdFVPcHVGQUdj?=
 =?utf-8?B?ZmE0elRLUkg4dkdKYjJHMDA0WENOMXN4UGg0SjVNeXpHYnVjRUw0T3k4UHgy?=
 =?utf-8?B?NmN0d3Q4RlBpMWV0NjgrSnd5R3E2RzlRNUhZZEJxN1ZxV2d3R0dJZ0FNMERJ?=
 =?utf-8?B?WXQ4M0lNZG44UTlMZWJUR1UzSlQ4aUY0UTRSL1lKd2Y4VGU1UFV3ZlZ6NjBp?=
 =?utf-8?B?NlQ4eWpPNUJ4eUFDK1JnTERrR0pPeExTWGJTMllkUG5JeXdFZ0Jud1NoMzZ2?=
 =?utf-8?B?WVA2Ry9Xd2pkNTdKUU9MaGVneUJ3NUEwY09hcnAvaytYTjFrMldGaXdvUHVQ?=
 =?utf-8?B?Skc2S09mZ1JCOEhUM3JWZXNnVWthUTZuL01laXpGUFBzMWh0NFpVZ1JJTWJO?=
 =?utf-8?B?NnkrcmpDQVplZjgzMWxYc3VHam9jZjUvWGRWY284OTJEcUMrbXl2VmVHS2ov?=
 =?utf-8?B?ZlJoYlBEOWxIMjJjeDhaZVc4aE80Mkp0VWdDam9sSzdKVXpiaWpzUXFOa2s2?=
 =?utf-8?B?RVVXc05DWVJGOGZVanMxQ1Z4Y1NSU2JmRzU5b2ZYa3V6M2p5Zjl6RG5XN3VE?=
 =?utf-8?B?SmNlVDNhWlpoMFA1dmp2ZjJ3WUdtREl5WGZRM0hPSmg1dHdJck5OeXJ5cGpM?=
 =?utf-8?B?R1FTY3lISXYwMnIrbkNKMlo1Y3VFSkttSUNna1Z1YldoVFMvV1ZwVVVBSlhB?=
 =?utf-8?B?RGsxeTc1NTA5ZTZiQmdmVFh3NUpMblQ0WUkyR2JPZzZGakFCSEdxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff21f72-47ba-4a52-c763-08defec594d0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:16:09.3592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETxDaloVn5q+aGtECct2oxyN3xDM9NsWJrWdFeC4zdBs0VY5AuenndhlKoaU9RvTZge830NT5McAFe/GZWozdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430
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

Oops,
+ Harry

On 8/20/26 10:13, IVAN.LIPSKI@amd.com wrote:
> From: James Lin <PingLei.Lin@amd.com>
> 
> [why]
> amdgpu_dm_crtc_get_cursor_mode() returns DM_CURSOR_NATIVE_MODE early and
> unconditionally for dcn4.x. That early return was added because these ASICs
> no longer have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
> of older DCN, so native cursor is fine in those cases. However, it also
> bypasses the "does the top plane fill the CRTC?" (hole) evaluation further
> down. When the top/primary plane does not cover the whole CRTC, the cursor
> must fall back to an overlay plane so it is composited over the uncovered region;
> keeping the native cursor there produces an incorrect result. As a
> consequence igt@amdgpu/amd_cursor_overlay@non-full, which verifies exactly
> this native->overlay fallback, fails on dcn42.
> 
> [how]
> Replace the unconditional early return with a skip_fmt_scale_restrictions
> flag. For dcn4.x keep skipping the YUV / active-color-pipeline / different-
> scale overlay triggers (genuinely unnecessary on this hardware), but fall
> through to the existing entire_crtc_covered check so a top plane that does
> not fill the CRTC still selects DM_CURSOR_OVERLAY_MODE. Native mode is
> still chosen when the plane covers the whole CRTC.
> 
> Update the amdgpu_dm_cursor KUnit tests accordingly: exercise the dcn4x
> path with a full atomic state fixture (full coverage -> native) and add a
> dcn4x hole case (top plane does not fill the CRTC -> overlay).
> 
> Also remove DCN5/6 guards since they've been upstreamed.
> 
> v2:
> Move the check for disabled crtc to  separate early return, so a disabled
> CRTC always reports native mode on every ASIC, independently of the DCN4x
> fallback logic.
> 
> Signed-off-by: James Lin <PingLei.Lin@amd.com>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  | 45 +++++++++++--------
>   .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 32 +++++++++----
>   2 files changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> index 9534848ed240..8204ad4018e6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> @@ -87,12 +87,8 @@ STATIC_IFN_KUNIT int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
>   	 * check tiling flags when the FB doesn't have a modifier.
>   	 */
>   	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
> -#if defined(CONFIG_DRM_AMD_DC_DCN6_0) || defined(CONFIG_DRM_AMD_DC_DCN5_0)
>   		if (adev->family == AMDGPU_FAMILY_GC_12_0_0
>   		    || adev->family == AMDGPU_FAMILY_GC_13_0_1) {
> -#else
> -		if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
> -#endif
>   			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
>   		} else if (adev->family >= AMDGPU_FAMILY_AI) {
>   			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
> @@ -289,26 +285,34 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
>   	int underlying_scale_w, underlying_scale_h;
>   	int cursor_scale_w, cursor_scale_h;
>   	int i;
> +	bool skip_fmt_scale_restrictions = false;
>   
> -	/* Overlay cursor not supported on HW before DCN
> -	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
> -	 * as previous DCN generations, so enable native mode on DCN401/420
> -	 *
> +	/*
>   	 * Always set native cursor mode when the CRTC is disabled,
>   	 * to make sure it doesn't cause atomic commits to fail when
>   	 * they are trying to disable the CRTC.
>   	 */
> +	if (!crtc_state->enable) {
> +		*cursor_mode = DM_CURSOR_NATIVE_MODE;
> +		return 0;
> +	}
> +
> +	/* Overlay cursor not supported on HW before DCN
> +	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
> +	 * as previous DCN generations, so enable native mode on DCN401/420
> +	 */
>   	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
>   	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
> -#if defined(CONFIG_DRM_AMD_DC_DCN6_0)
>   	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
> -	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0) ||
> -#else
> -	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
> -#endif
> -	    !dm_crtc_state->base.enable) {
> -		*cursor_mode = DM_CURSOR_NATIVE_MODE;
> -		return 0;
> +	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0)) {
> +		/*
> +		 * Newer DCN has no cursor-on-scaled/yuv-plane restriction, so
> +		 * skip those overlay triggers below. A plane that does not fill
> +		 * the CRTC still needs overlay mode so the cursor renders over
> +		 * the hole, so fall through to the coverage check instead of
> +		 * unconditionally forcing native mode here.
> +		 */
> +		skip_fmt_scale_restrictions = true;
>   	}
>   
>   	/* Init cursor_mode to be the same as current */
> @@ -407,13 +411,15 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
>   			continue;
>   
>   		/* Underlying plane is YUV format - use overlay cursor */
> -		if (amdgpu_dm_plane_is_video_format(plane_state->fb->format->format)) {
> +		if (!skip_fmt_scale_restrictions &&
> +		    amdgpu_dm_plane_is_video_format(plane_state->fb->format->format)) {
>   			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
>   			return 0;
>   		}
>   
>   		/* Underlying plane has an active color pipeline - cursor would be transformed */
> -		if (dm_plane_color_pipeline_active(state, plane, false)) {
> +		if (!skip_fmt_scale_restrictions &&
> +		    dm_plane_color_pipeline_active(state, plane, false)) {
>   			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
>   			return 0;
>   		}
> @@ -424,7 +430,8 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
>   				   &cursor_scale_w, &cursor_scale_h);
>   
>   		/* Underlying plane has different scale - use overlay cursor */
> -		if (cursor_scale_w != underlying_scale_w &&
> +		if (!skip_fmt_scale_restrictions &&
> +		    cursor_scale_w != underlying_scale_w &&
>   		    cursor_scale_h != underlying_scale_h) {
>   			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
>   			return 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
> index efd16575896e..9026c6ce7336 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
> @@ -521,25 +521,38 @@ static void dm_test_crtc_get_cursor_mode_disabled_crtc(struct kunit *test)
>   }
>   
>   /**
> - * dm_test_crtc_get_cursor_mode_new_hardware - Test new hardware always uses native mode
> + * dm_test_crtc_get_cursor_mode_new_hardware - Test dcn4x uses native cursor when the top plane fills the CRTC
>    * @test: The KUnit test context
>    */
>   static void dm_test_crtc_get_cursor_mode_new_hardware(struct kunit *test)
>   {
> -	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
> -	struct dm_crtc_state *dm_crtc_state;
> +	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
>   	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_OVERLAY_MODE;
> -	int ret;
>   
> -	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
> -	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
> +	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
>   
> -	ret = amdgpu_dm_crtc_get_cursor_mode(adev, NULL, dm_crtc_state, &cursor_mode);
> -	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
>   	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_NATIVE_MODE);
>   }
>   
> +/**
> + * dm_test_crtc_get_cursor_mode_new_hardware_hole - Test dcn4x falls back to
> + * overlay cursor when the top plane does not fill the CRTC
> + * @test: The KUnit test context
> + */
> +static void dm_test_crtc_get_cursor_mode_new_hardware_hole(struct kunit *test)
> +{
> +	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
> +	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
> +
> +	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
> +	fixture.old_primary_state->crtc_w = 1280;
> +	fixture.primary_state->crtc_w = 1280;
> +
> +	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
> +	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_OVERLAY_MODE);
> +}
> +
>   /**
>    * dm_test_crtc_get_cursor_mode_no_change - Test unchanged atomic state preserves cursor mode
>    * @test: The KUnit test context
> @@ -948,6 +961,7 @@ static struct kunit_case amdgpu_dm_cursor_tests[] = {
>   	/* amdgpu_dm_crtc_get_cursor_mode */
>   	KUNIT_CASE(dm_test_crtc_get_cursor_mode_disabled_crtc),
>   	KUNIT_CASE(dm_test_crtc_get_cursor_mode_new_hardware),
> +	KUNIT_CASE(dm_test_crtc_get_cursor_mode_new_hardware_hole),
>   	KUNIT_CASE(dm_test_crtc_get_cursor_mode_no_change),
>   	KUNIT_CASE(dm_test_crtc_get_cursor_mode_disabled_cursor),
>   	KUNIT_CASE(dm_test_crtc_get_cursor_mode_yuv_plane),

-- 
Thanks,
Ivan Lipski

