Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BCF10775E7
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 17:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7631910E44D;
	Wed, 18 Mar 2026 17:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BS+qiPb9";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6153810E0FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 17:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBkWKBJYdesEprflUdKNj3d8RTPR8M6aOuNcgN1mu3Jf5KjtrvjAdgdLhtMCe+nJ4dbjFL1+WCeB1lUEFIIrNdp42ccfWfoxTizyMwMIeK5opXRnNWlMLuNXXyK+J2izGtLI9H/UEhLzt7YIhMKvitcTTS0mbciXKtNy8LKF5cIvp0r6QNXuXyAopfrhuayhFcYTEwrM+TiOsubtszHK58iVF4ECTuQIizo8oqgvSeuLi9ESMuAdlsFyV5EGllwkYG6q0i3G14NVoHmOKJTPUkg4QUmjeIk9pekZa2Pv6fda15tfl/GDT8eP2JtA/iXMahB2go5jZeOx3vYwTopFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ5NQUx+evrqGIai6Kbut2DSWJetkXHnZUcWTArifRo=;
 b=dKY2f65VHVkXm5qPB5pNvu+Xe3ydSWBTnCMRbLy+0eF//McsgwDREi3hZKNsJNWe9ShpKEV5B7MVSCYr0tl02gj65nXuQd++ka/4nvm0QIR+3g9bXOu1by6gkrqpDJBl2xERNmvOIj06Hr8nj3J+XebICU75a8X98E8fnZULcExf8XgvHyGsSPlgGo/P/NSBocst9dBQNa9Bu1hrib5vfdB750rvjkUQyHSJiyXWDGALMyw2fKSd1FinRNvmrdaFjKguWBSpMP1IEKbBwxRG+k0T5uZHcOlo09KThX/NRjBkD6M1M84H4yaQ9pPtx0hy4P0gKBjvyfydlALoRprUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ5NQUx+evrqGIai6Kbut2DSWJetkXHnZUcWTArifRo=;
 b=BS+qiPb9BeS5luoFkhI/ydftnGqZdO0Q0arFdHg9iNlTJhXJN3oG6I54Upn9J8evXLkULP9wuFqSuSJw5Wdm1I0gow0RhdqeZ4OVmPM7vqz/UaQ8xI7XGb9fCjqDHj6FjUODUovxY2ky3mNHXfDtA5KjzKrlLIbiGut4DeB15Lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 17:07:56 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%4]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 17:07:56 +0000
Message-ID: <ee1d2089-afcb-447e-b833-f9328581dd2b@amd.com>
Date: Wed, 18 Mar 2026 13:07:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Do not skip unrelated mode changes in
 DSC validation
To: Yussuf Khalil <dev@pp3345.net>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org
References: <20260306120513.57826-1-dev@pp3345.net>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260306120513.57826-1-dev@pp3345.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0095.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::29) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b59956-01cd-41f7-0ac2-08de8510e62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: WI9YGPXJikxwZFbUkqU8ruHj2VwDEULu7tVgZy0Dc9dZSEEJHCy3nIwgYXZR7EBsq3ctdTwO/zuXFbDeSGggzheGEixXJAWNC4SVMwGYgBRdrEcbquxC4Jj5nO+LA5IDsBBHDkIFfTF8nj+v3heuoTBXP1ZuYQ0qsJK5MA0IZjx2bH4ZeKtDFuvpRdnIZsoGldsEPxz7c4stjssJo/s1b0BarNafmxllvj6kMamavHsWsNfwYkM/1N9KNfE/l3BG9GsC/g5Ns7t2G9nJ4U0cRBVpXgCe0hDuZ/l52cpEr3wlD21/EemAhFHsH+3/ZzBVyoJgd5k1k2dbr7ot9aE2OxxVsr+8SUzXInWW7obkd4b9MSmuELP/7hdfx53iGLagqAbps5/aBoWhEA2MZqlzJDJxzu+BS1anr14GWTNleVwR0mdzSrWOZEmlE11+RnYhoqlWg2Te2CZFOQtVqvoHzke63B49Wshc5LVuEbCQMmVBJJev9CdRZbJyhJ21s1uXloSR+cSqKgGqKbeQXW0CY0pc9VMeMeqgFVN6ohIxBNsvox/HQVPePT6MHLNKWnuM3grKcdV4tgwQVim5RDrUCTlt2ewVKpABTmljrIkVjiOrzhSSI6uGJZducy9NQUwUv0UxmRSOjG1Xq2G4lCkbPfi3ANf+sv9WEqA5H7XBjIZskK21mR6wwVrzRfDljzXh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZtYTUyRDBTNzhPL3dWQm14ZmxUWHgwNXZCd3c0azRrMkZBZ21qSmZYK1B6?=
 =?utf-8?B?UHFSRTFqNFRJZEFsOWlINDFJclhjTUMzWmg0d3RRS3ZtTWJ3Q3ZtaTI4cGVp?=
 =?utf-8?B?Sy9oKzM0OE5yWSs1ckJPUyt1UmhHcEdoRUpYRW1Qb0RHM0tYYWRuSUtTbnZD?=
 =?utf-8?B?NjlpaVFYeThRdFJvbWpyQVZjUlJMMklVQWdEL1JtT2UxYmh1Qkd1UExWdjB3?=
 =?utf-8?B?bVVUWkZuVisvaXNWanR3cE9IM1FHL2ZMTU81SFN1N2swbXBaYWpGQ2g0NitS?=
 =?utf-8?B?djRZSDVNaFRleXlidWJrSTVqTFdNTEErbENPTEhDZGV0d1NqQ3hvckw4UWVX?=
 =?utf-8?B?VjZxbWRSL25uZGthWnduMTBFZFc0OEtTRHpaSzl2aC9XYXAvRTdpK01OanIr?=
 =?utf-8?B?SDgwM3RBV3JLdkE4RUhxaTMrelJqNkFpRGhHOW5WeEJmV1lVUUZ5V0dxRXRS?=
 =?utf-8?B?UnhtUXFLaXpDQzZubUExT0h5MU42ZEE1dzRGSElkK1pBU1JMMXJmRDFOWkw5?=
 =?utf-8?B?MEdXampCaDFwRURmaHdLSERoVXphTVBTS2NHYzlCak1RbXlkMmd3L0FZeGQ1?=
 =?utf-8?B?VkhYV1hCa2g3SGRpM1E0ZkowNUFZSlB0cmM4UTJkTWt6Ymw5c0JTSDRrczdl?=
 =?utf-8?B?MUxIMUpmU2YwbVVCOU96NzU0Uzl6a0RSb0tDVGJpY1hUalFTS1VJaVdabXAw?=
 =?utf-8?B?R0ZmdVZWV1QrNFhEdVR6ODUwUVRERFQzZzNtZTB1Zi9QSWdJOXJveUNNZ3lj?=
 =?utf-8?B?K0Q3eGt1VnpYN1B0dWl6ZmN6amlZYW4xeDZ6Z3pCZWJQM1BzaDZxU3dDMTJF?=
 =?utf-8?B?azloVklZQnpqaDZGMm42cUw0MVZIbzFGVi8xWStCakczUzNzUHIybmVtK01U?=
 =?utf-8?B?ME9MdVVKcVZHdTM3VW5ieXJrUllDMkRybHM0MGJjbFlOQmhtV1lGRG1wWE1M?=
 =?utf-8?B?N0RuT1Q4OVRUVVdlNHk5THZTUWRLNFBvMENUUkV3NlR6dm5iV09NVUZHTXRk?=
 =?utf-8?B?ZFdKMUdXcng5STNkRStUQUw4aTNGYm9uQk5PaWRxVHlZczFCNzVPNUR4SEVv?=
 =?utf-8?B?TG9CK0Z0UC9NdGNjdWRTdGN6RkhaQnkyOGg4NFdkR1R1UndjaWhqSEpiU1ps?=
 =?utf-8?B?MTNJWkNNS0FtQmNMMm1TR1cvUXdYS0lEQWQxVWF4clVka2RjS0hBNURYcGZX?=
 =?utf-8?B?YXhudzdsV2puSnk3VVo3TE9hNCtIUWJidzJEYTVxKy84QUdKZkxZVXE0UVB2?=
 =?utf-8?B?eFFUTlkvbW1NTlRrMTJYNnBPdDFBOFlyM1o3MlNBK3ZIYWJ5TjRxUmlQaktB?=
 =?utf-8?B?Y1JpUGJ6eWJCakhHUmlsaWNkTFZQYVQ4bTV4TTlQR3E1bW04U1F3TFFTSTVk?=
 =?utf-8?B?eEhYQ3ZjN1pOT1RLWkZiSUhuckhsdldhYVo1VWFSQVZnWGxjanFOM3ZocU9P?=
 =?utf-8?B?eVViZVNZaDVEZnVDQjJEeUsrSTIxbFp2eWNPUUpJb1JrTUc4WjFnMlhaY2NS?=
 =?utf-8?B?L3Nkd0tXNzBTTnRDOTdlbG5URXJaWUFKejZ0eE5LZzhJaEJMQVZpOGgzamkv?=
 =?utf-8?B?ZlFVZzFMTHNDVC9CQU1VVDNHOFNxWEpCdEQzclFDMDJ5cmRYdEg0UWNqR2RP?=
 =?utf-8?B?WGVHVFVPUjBkUWRFNzdONGtxejVPdTFTUTBsLzk0dVZ6eWl0QmVoSEExSTRR?=
 =?utf-8?B?c0prOUdGR3BSQTN2TFEvN0RvNFd0eTFFdTJCejhaWnl2b2VOb2E3TDB0ZDBi?=
 =?utf-8?B?UFpUR2Z6RFQyNkdpU3JlUFVneTFOanRSKzJVMkZ6Q2xrU1EwOVR6OEZmdHZ5?=
 =?utf-8?B?WUE4SUVxZGlDaFM2cVB5blc4elpUbnQ4N1ZJbmxESDQ3eHR0M1g0NEErbnZm?=
 =?utf-8?B?L3BKKzN6aTBGSWhoRWtqNndRTmYweVVhZVBkald4Qk9XYXJDSTVZeTFmb25j?=
 =?utf-8?B?OXZaUHNMQVZjVUtaS1NkTUppMFJRdnNDZTdhNWlneGE4TEUxWURhQnZEdDZQ?=
 =?utf-8?B?Q0EvdmV4a0tSRFFZYW9jOENwT0NYK0s3WHQ0NjVnWW9CYVdJQXI5bEFxOVJP?=
 =?utf-8?B?TXhYN3daODdoZlhvMFU4NDdiTERhdG1FL0VKaGRrOCtvWXExTXVxc1RVODFX?=
 =?utf-8?B?a3ZReWxtOXNlaENTaGxqWnpDbkJOa3NSNU9jY25SQU9FcmR1aHlGbG42TnRP?=
 =?utf-8?B?eXFZbjJUemlIWElSTEFPUmlaQmZWTU5RU0RlSC9ZeURENXVDRDRzenhPb084?=
 =?utf-8?B?SU85MGRDVC9PSFJKTVp5QW51WCtXdHBsOTh2V2lqbmtXOW9qWUFjS0dvamFa?=
 =?utf-8?B?WHhlTjV3c2NHWE5wNmoxYzJOaW5HTVVYVUlETWZiblpWQ3FwVFZMdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b59956-01cd-41f7-0ac2-08de8510e62c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 17:07:56.2552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQ926DYS9W95oZfKtqbblDDz1F4Hz3VejzwuySqcd6LjoYVuvUMislCA/2ne26JwqgoRA9A6Npg8CGUsSJrxdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571
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

On 2026-03-06 07:06, Yussuf Khalil wrote:
> [Some people who received this message don't often get email from dev@pp3345.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Starting with commit 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validation in
> atomic check"), amdgpu resets the CRTC state mode_changed flag to false when
> recomputing the DSC configuration results in no timing change for a particular
> stream.
> 
> However, this is incorrect in scenarios where a change in MST/DSC configuration
> happens in the same KMS commit as another (unrelated) mode change. For example,
> the integrated panel of a laptop may be configured differently (e.g., HDR
> enabled/disabled) depending on whether external screens are attached. In this
> case, plugging in external DP-MST screens may result in the mode_changed flag
> being dropped incorrectly for the integrated panel if its DSC configuration
> did not change during precomputation in pre_validate_dsc().
> 
> At this point, however, dm_update_crtc_state() has already created new streams
> for CRTCs with DSC-independent mode changes. In turn,
> amdgpu_dm_commit_streams() will never release the old stream, resulting in a
> memory leak. amdgpu_dm_atomic_commit_tail() will never acquire a reference to
> the new stream either, which manifests as a use-after-free when the stream gets
> disabled later on:
> 
> BUG: KASAN: use-after-free in dc_stream_release+0x25/0x90 [amdgpu]
> Write of size 4 at addr ffff88813d836524 by task kworker/9:9/29977
> 
> Workqueue: events drm_mode_rmfb_work_fn
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x6e/0xa0
>  print_address_description.constprop.0+0x88/0x320
>  ? dc_stream_release+0x25/0x90 [amdgpu]
>  print_report+0xfc/0x1ff
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __virt_addr_valid+0x225/0x4e0
>  ? dc_stream_release+0x25/0x90 [amdgpu]
>  kasan_report+0xe1/0x180
>  ? dc_stream_release+0x25/0x90 [amdgpu]
>  kasan_check_range+0x125/0x200
>  dc_stream_release+0x25/0x90 [amdgpu]
>  dc_state_destruct+0x14d/0x5c0 [amdgpu]
>  dc_state_release.part.0+0x4e/0x130 [amdgpu]
>  dm_atomic_destroy_state+0x3f/0x70 [amdgpu]
>  drm_atomic_state_default_clear+0x8ee/0xf30
>  ? drm_mode_object_put.part.0+0xb1/0x130
>  __drm_atomic_state_free+0x15c/0x2d0
>  atomic_remove_fb+0x67e/0x980
> 
> Since there is no reliable way of figuring out whether a CRTC has unrelated
> mode changes pending at the time of DSC validation, remember the value of the
> mode_changed flag from before the point where a CRTC was marked as potentially
> affected by a change in DSC configuration. Reset the mode_changed flag to this
> earlier value instead in pre_validate_dsc().
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5004
> Fixes: 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validation in atomic check")
> Signed-off-by: Yussuf Khalil <dev@pp3345.net>

Thanks for this commit. It looks great.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 5 +++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h           | 1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 +++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b3d6f2cd8..4efd77477 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12523,6 +12523,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>         }
> 
>         if (dc_resource_is_dsc_encoding_supported(dc)) {
> +               for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> +                       dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> +                       dm_new_crtc_state->mode_changed_independent_from_dsc = new_crtc_state->mode_changed;
> +               }
> +
>                 for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>                         if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
>                                 ret = add_affected_mst_dsc_crtcs(state, crtc);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 800813671..d15812d51 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -984,6 +984,7 @@ struct dm_crtc_state {
> 
>         bool freesync_vrr_info_changed;
> 
> +       bool mode_changed_independent_from_dsc;
>         bool dsc_force_changed;
>         bool vrr_supported;
>         struct mod_freesync_config freesync_config;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 7be50e8c0..5d8c4c702 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1744,9 +1744,11 @@ int pre_validate_dsc(struct drm_atomic_state *state,
>                         int ind = find_crtc_index_in_state_by_stream(state, stream);
> 
>                         if (ind >= 0) {
> +                               struct dm_crtc_state *dm_new_crtc_state = to_dm_crtc_state(state->crtcs[ind].new_state);
> +
>                                 DRM_INFO_ONCE("%s:%d MST_DSC no mode changed for stream 0x%p\n",
>                                                 __func__, __LINE__, stream);
> -                               state->crtcs[ind].new_state->mode_changed = 0;
> +                               dm_new_crtc_state->base.mode_changed = dm_new_crtc_state->mode_changed_independent_from_dsc;
>                         }
>                 }
>         }
> --
> 2.53.0
> 
> 

