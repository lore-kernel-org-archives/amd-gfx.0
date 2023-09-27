Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17814E82CBB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 18:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1EC10E58D;
	Wed, 27 Sep 2023 18:24:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D7B10E58D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 18:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECCyR1cR6ylCjrZI2AS7SWqav+Kbznxxq+i6PLNp4dCG5QqJZpzxsUsN7ma5uXeI5folq+Ss0cJAHFfYvfUw6w3DY8zqiMHeXaP8fDRU3Q1MdMH6WXVVvC6QtuGMfbggCMkiHTTn0b64fbLONHxI55A2gk++N3dR1V3tn0OXVAbzprOpVAyV2t/jg2C+Rruo62ZCjQQdEBtVpDnwFkiYfidN7dgf89/mH/gIxZ0aLWSsu4DkqxgWWuE1+x6MpMnjWhSMt1c4UlEbSuHEk9IUu1bhm8uTtlFsmHatHSqjiVmLaLp9Ac2pE+XqUFcwsJemzuZn4nqwLgGNmyBnqJX5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+paFTSQzsC0p3PxqvdD694vfSwtvhO6pMQ1czmOKZg=;
 b=P0e/K+FFF2m32r8rwL1hbi2L2KoScByHbxptUdOT+1+yaBHl9/EYNpiWE8JkWfCnI+9hvRvco7UeCuLvhIjKRDlIyUwthYAxZX3SS44BWcvNnnCkydzeLtAJY67EsO4Yno9En7K74RPUeL04uWVpUSlTkvaRrrpW/p9G6o8gGDuJ8vFN9m5v/5eV45ugNKnBuyr8TDjjbmM3+wLXM/4MQ6oyNCyyl1ukQS/O7lJonBZpmvHDdJVlkxUaeK/owg/Gp4wSL4XQcwQGdnk0p4vEVZKDneOyoa0dRt4NEUIBJesrvNpkuSiMa3Zknl+BgGPfDKoJtwPx35z459bTDi5aEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+paFTSQzsC0p3PxqvdD694vfSwtvhO6pMQ1czmOKZg=;
 b=TeCDJMyG1DCsvMKVYwstiYep89Pr/zoKLTnwWoE1HTvteRM/tCWS4yo27uRPRn7986p1UlEy1PKrKUB67ryZGH0VdfwpbNYLtFz3pWpnTTAiteG0vbKzEsKalzxB0v26HiNH/f4NHkbkrErB3xY8ysYs4aVHXnj+aq5tUQ1IYpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21; Wed, 27 Sep 2023 18:24:54 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332%6]) with mapi id 15.20.6813.018; Wed, 27 Sep 2023
 18:24:54 +0000
Message-ID: <c63de8e8-3855-4de5-9778-ccabbd9f7731@amd.com>
Date: Wed, 27 Sep 2023 14:24:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Check all enabled planes in
 dm_check_crtc_cursor
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>
References: <20230912102224.4826-1-michel@daenzer.net>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230912102224.4826-1-michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::22) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ffe2ef-df5d-4680-37e8-08dbbf870bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxnHsMAmsH7RosxWKtCbj/RmVPLSbMjt5c/bthKQSiFz9Y+WxdUmalhxGXTm8pMkXupgwqREYtOCxOsqxhKJb1Se4AwyhIf53UQidYs65+YuZeHFN9EMJuHDkh4YMQTie1Yja9T6ey4AcWUz//t80U4ifT2I13qVYi9MvMPUg7fDeXzFrIqTLZsEe3K8nN3j6dyngdCCql3QWq9ivXJd2e0YFLp2Vho7IgyzA6dMOZTFimY51jvjtM4mbRIHReQlvzc8veOF140PVK7Hlr+QQsdIyRAUz78eLsxRsLLkuIZDNvXwSXX3aQiKYmTrbsGNY2CBPQS2Ph1iysan0GOjLwcUAah1xG9qaBhot0LPaVui/He0rd4Q3ORshlvnu1AwWwqDM9X4l9fMbX2Zv5QY4KxrGNnleLcR/qhy6Xu6/dMeup8dW4S+8PN0yhiy2Pv4jv6bV7bgqWiVnu/au88h7lsjVD9/giuBZ9u7Qw3pGuY8JAqn6yU68354egZ+F8kv4Vln1eSDoOovh5yozVLe7D4zpNP0eoiRBc7UJrf4FDHQqBeFo8j4fcvDgVtMJihuMjp70J9wH20ugbYxj2dHyUsAXziYpbM3eKkMGJSCx0qycF/+bTOFFjuwM/opzlp4RyeGKuvpHNfkruv3H1ohKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(2906002)(4326008)(66556008)(8676002)(8936002)(66476007)(31686004)(41300700001)(316002)(54906003)(66946007)(5660300002)(6486002)(966005)(6666004)(478600001)(44832011)(6506007)(53546011)(2616005)(110136005)(26005)(83380400001)(6512007)(38100700002)(86362001)(36756003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU1iaG9GUU04a205dk40S2tqRDVGZjgxamNOMXJUcVZldlh6M2dYK2FzSXZa?=
 =?utf-8?B?VUZWM2pRaVpiZnJHRDlRbUIwZ0J4d3dMTFl4LzNCbjlFdVhaeUFjbTIzaGtv?=
 =?utf-8?B?bXdOeXZPa0dkSlBPOUV4SWo2RjU4dGpZMTE5WXU5UXk2OHB3NWFSWVgvME02?=
 =?utf-8?B?RkdNbDVzNWg4bVhwK2lVZ3JjZWlkSlB0M3NkczdvQWxnQVFRRzBRUkV1aCtN?=
 =?utf-8?B?MlcxMTVzNStWTHc5cUw3d01UTmJuWldnbS9nK0ZJWm5HZU9XM2IySXE2TDVP?=
 =?utf-8?B?Z2pIYVdYQW1pcmFhUURuZjRtUUsrbTJCQlNxWHAyb2I3Yy9Oejc4WVJONVBT?=
 =?utf-8?B?WTBCS0tjTVJHT1JDdVpQQ1d2VmMralU2QkNveGQzRzNrZlhTZTB4Z3BFRkln?=
 =?utf-8?B?THVpclZQOFRLOWRyUWFyYytQWE1xYmVpaFd6eWdiQ0dxU2xBVlZiVDBxZ2Q3?=
 =?utf-8?B?SVlFbGZOQzlEQ3ZuQkdRazFlWHRpd0QxSHI4RnVIVURYOUhQM2VZczIxanov?=
 =?utf-8?B?aXN3dnl2QkFxa0JuZ29vazhoWEQvSHBoK3hhM1Yxb0hUMDZRckhkWmdlTXJu?=
 =?utf-8?B?U0M2WWNCc3FoRkNQOHNVc0IyNm9PRVR1V1ZLMkFRSHNsYy9sSUpNWXNLSDVI?=
 =?utf-8?B?c1lucVI1ZFM2RW92bW5nUHhVemthLzVQdEJsZmVSK3UxNjJHNjNVaVMrY3Rl?=
 =?utf-8?B?MEcvWGJJTDBLcUx5NWtPN2RydnM0b0ZJOXZmMzJaRG1qL0NGck9iRXR4cGlr?=
 =?utf-8?B?eDQ3UFJVeEtTOFl1c3I4YkVENFVEY3BlSkQ5RThqZGxVRnZKY3k3UE1rQXJI?=
 =?utf-8?B?YXkzcjBEMGJGejZSZlo2b0dINS95NWdnVkMzMHk1WGpaN0FONDBaNnpKTmM5?=
 =?utf-8?B?Mnc4R1hoWUdOWU9laGE0ZDk0eDN6Mm9XTklNVG1JNVZzU2dOMHZUb3J1cGd6?=
 =?utf-8?B?QkZTK1RCWFdRaWdHbS9xdnN1OWlZd20wbk9EcXZlUkJ0WENqdklTN3BHQUV3?=
 =?utf-8?B?b3J2MEJ1eE8rTzQyUlEyazJNTVVNalpKMnZzZ2t3TWt2ejNRa2loL2tMQmRN?=
 =?utf-8?B?NUtDZkdlNFZlK0RlUHJKUjJPQ2krQ1g1bVlUZjdzZzM1RWQ0cTRnazlaekM5?=
 =?utf-8?B?N00yc2NIOUU3ZnhNQ1BRaW84VjhUemQ4VjhJYzBLR1JVdHpkQmNkMzVxM0xL?=
 =?utf-8?B?NWRCdnE1OXRWU2FRRGxieExCZ1BaTTh2SUZWdzdpSHc4UG90OTYzS1hjZGQ1?=
 =?utf-8?B?RTNZbUJkeXRCSVV1blVZYmpJRU1zc2NCUm5QS1VBd2hMejNqaXdkeEtMTWVI?=
 =?utf-8?B?Q1pRNHlhU3piOU9QTjF4N21JbGtHNGFhRHlkbE45Qi85VXpNTGV1K2lUQmZ5?=
 =?utf-8?B?ZUh0bDZWTEFwelZMdXBwcU5zeVJDNjNwaEZld1VnYkdSNUF0L25NMFhHODhn?=
 =?utf-8?B?QzBDb0VRZjdFQ3k4ZHNHVGtYSHovbEE4T3p0TWRFZDYzMmZwd1BCSVNHNG51?=
 =?utf-8?B?MUVzZGhFMldCc2xqQXBVL0xMeUVmRWlnNXQydFY1MmtFRTZHQUlZSFphWExo?=
 =?utf-8?B?ZWkrU1BQTlpYNXNRWEpob01wVlNQT0VkOFVPbDR5SFhwM0NFaEwwYmFLWHNk?=
 =?utf-8?B?cWVEdDZnR1NUWE1KQkJxUktybEx6QSs4eTFzK2hxbS9BL1hWTWQ4ZUxqN2ph?=
 =?utf-8?B?NkQrbWtFcGZ2Tm85bGJQVVNpQ3IzQTJuQXBUa0x4c3RvcUpkWHdOdEZadzBv?=
 =?utf-8?B?SkdxVk5odmVKUzdGWGxoVExQK3U1Ym9YTDVCcHlrMDFFMTY3U1p3RDFlc0Nz?=
 =?utf-8?B?dG9raU5zZ01XZ3MzTllER01ydGFhN1Rmd1FhM1NEZktac0hldDNGeVZWeXpR?=
 =?utf-8?B?MEF3d25zTExXUXJFaWhxTStxc1p0VUUya0FscjUzaWkvc0t0aUVRUjJBTk1i?=
 =?utf-8?B?cVNVZ2JSK3loc1hBN0RlLzV5Nzc2bWhhRzc4RHdaekhKZ3lKNktZemxvOG5y?=
 =?utf-8?B?M1NMaEp6c3R2VzRWaHpJNDhTYzlSTmI3SzV5SXdsTFZEejRmaEtQcUVaMjRT?=
 =?utf-8?B?WUR6bFllMmVDcmdKMHM1VFNhSklFY09qZ3lkc3BEcllhakFZU0RrM0RTSzRI?=
 =?utf-8?Q?WOnp8azDn/gb+xFJ8B6drqHHW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ffe2ef-df5d-4680-37e8-08dbbf870bce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:24:54.4860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoFPHaNaYkzvPMsG0eoqusvdd87ugwJeUrMuqXbNGbogQN45NutVrEA3WeI221y8XHW1G8z5bqj7Rpr1WQ05/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 9/12/23 06:22, Michel Dänzer wrote:
> From: Michel Dänzer <mdaenzer@redhat.com>
> 
> It was only checking planes which had any state changes in the same
> commit. However, it also needs to check other enabled planes.
> 
> Not doing this meant that a commit might spuriously "succeed", resulting
> in the cursor plane displaying with incorrect scaling. See
> https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3177#note_1824263
> for an example.
> 
> Fixes: d1bfbe8a3202 ("amd/display: check cursor plane matches underlying plane")
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>

Applied, thanks!

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 88ba8b66de1f..81c9d39567db 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9836,14 +9836,24 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   	 * blending properties match the underlying planes'.
>   	 */
>   
> -	new_cursor_state = drm_atomic_get_new_plane_state(state, cursor);
> -	if (!new_cursor_state || !new_cursor_state->fb)
> +	new_cursor_state = drm_atomic_get_plane_state(state, cursor);
> +	if (IS_ERR(new_cursor_state))
> +		return PTR_ERR(new_cursor_state);
> +
> +	if (!new_cursor_state->fb)
>   		return 0;
>   
>   	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
>   	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
>   	cursor_scale_h = new_cursor_state->crtc_h * 1000 / cursor_src_h;
>   
> +	/* Need to check all enabled planes, even if this commit doesn't change
> +	 * their state
> +	 */
> +	i = drm_atomic_add_affected_planes(state, crtc);
> +	if (i)
> +		return i;
> +
>   	for_each_new_plane_in_state_reverse(state, underlying, new_underlying_state, i) {
>   		/* Narrow down to non-cursor planes on the same CRTC as the cursor */
>   		if (new_underlying_state->crtc != crtc || underlying == crtc->cursor)
-- 
Hamza

