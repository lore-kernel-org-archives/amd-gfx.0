Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D323DC982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 15:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9B510E4F5;
	Mon, 21 Sep 2026 15:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dV+s+6sc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156BE10E4F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 15:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUaUMAwVsILHEMfGOQpgJGj4wkNRKD3FZbvsc124KaJaFfJNLAEgKyANaLFoP8dHCzKl/96Iq7bR0R1UP3+GGw//lAcTZV2y9e9/W56VscceqqwXcgWv+5Vk0m58o3lih9HUqA7B+UsVxAUQ+Xvj8AZABQ6PzTZ3CwAlFjhZHFvwuKaqN3b7ieiQS9DfWEzTcykjFQsmEAaHbPCsf0Q2fdXFPogrMMC7Pm5ceD/BRzQTdfwIAc7PSvuO2GqPvANxLl3EBFwGz2oFKHM0+nuq/lJj4XhtAnz8187VNCtnxWooz8Sw8YPUjw1rUMG4caNja0bdMSVUbzncxT40kHhDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v+P+WeuYhYnGleCJYZBM9TRnopVmtyLwXELWZVXCTI=;
 b=HxUH7FGF15ni/8czM40Yu/X9itcrM1jwkQZto1GTt+0GaO/g5LuSYnWWyatd4R0oOFRyXhc9M1ETSeFtyGouJfljaJtYX0l8F9xg57ft+bbK57Qu5j3i/rqDOnp3DoAue6yYw8MfZwLOK6y24b5wnvEBjEvmN+A+QBV6gkgOInFpqpucxRCcSJhGrlfWGJG9UgAcCdaULLl9EjrilmFZuiFV5OPRX4EDXqRRkhDXLCO/18L1gy+a8mjNGXO+jMKn7A1LDsQZfJNNJ4gngZS5WTI5OcXgXlRuz2mrscPSDrV7pZjTPFcE3xMZ1yGvZmkeqEACzhxrG3ZuWZbUhbdhug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v+P+WeuYhYnGleCJYZBM9TRnopVmtyLwXELWZVXCTI=;
 b=dV+s+6scZXj6KsvdgR4tcCC6N2wS4gudc+2unEt9PISqmMV6Eftfz5Ajl6nLnd4wjjqBKD/tf6xToLgqBuNeIvgpok+Lr8a4dnp8+kPvyfWs4u95BD3Bcz3k5cQ9CvIMYxk0qrXTK0r8goCtoGOG7O9ifc6HdBbj9Wuk6pma0Gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 15:33:12 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:33:12 +0000
Message-ID: <bf98fdda-fc0b-45d5-830a-df65bef804e6@amd.com>
Date: Mon, 21 Sep 2026 10:33:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix fast updates on DCE6
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Leo Li <sunpeng.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>
References: <20260921104136.23990-1-timur.kristof@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260921104136.23990-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31)
 To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: e96c0b7b-bf3b-419c-6b2c-08df17f5a5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|921020|6133799003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: dfreoAL2yrjPaLdQX2wmfJlTnAR5DAOLpheltCjccEiolw2eLpTtZ3O9+BnILd8JXbVvYahySD9TenyVnKL3QWt0KEpsH5BlVEkfBdcbKWGaSe/k97V2WmJFy+8M1gDoId0Sx+4R7we0/JfbuUlkZQEkTsz6BM7A14j+BVuXrIeW4JR9J8ET8m2bZSv0xJUJh8T9WsTvAjmO1e5lqjCnhsf5gLFmLmowjESGU13K2tByUu7YM9try9c5zJagHO33C4swQ23tZBhklFv2ryUPY8BDdU00RhBDvVdg+6TyLoev6qSBBTYQ79S5E1YwoEwn9AUBH4P9ZKKM6fXfaC3nf4LgUgqz8XDUYWIfqQwdjn0DmTCIi+lri0gGdWu6XYTdOD4PSnP9nECL4c5SClWnzWg9aAktUjexkcU0r4S/08uO7DHve9m6RzD27gwB1A/Adw9F61Vu8QQcoZARJuHLzb0g3fM9RrWgkZzOxAVBzuyG9TDyrfHuaLU51egQzBcjjEUqYngOFJ1DOyRVMmFWLI7W4WL2Jdol5yjwA9BVZd73/8lqYcRZz8nOqflKr+DWBanN/kyFzZtp4jOYLfgsB/LAesLRYBSlVA8ifbJTGLgFtqzTJgCO/FfRLix+/Sf5EKuDTQ5y2EdrmuM/UALTX8xAxmsklEWNPsFMEXHYJXknntEtewPOuJeWzxJRnzt8IsOHBTBIo2Wo3CFEPEkV+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(921020)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpBbStNcG00KzUvdUUyaEVPeHBUeklXSC9rNnlXMndkMmYrRlhyN1JyejNO?=
 =?utf-8?B?OUlWRXdFTmRUSUptSXRGc1VTQnBVZ2g4dCthc0Z6WTZDemw1Z215UURTMFlk?=
 =?utf-8?B?cjBOSlpNejZtR2lJd1praXdHZkZNWW1IMVU0MEZwb0YyM0lWTGkyMlpjWnND?=
 =?utf-8?B?MnMzRW1tSFl6WmRSQmVKOWRwWmc3QWJ6bi9NSjNNYUlyTmo3MTJpK2QwRXBB?=
 =?utf-8?B?Y3l3MnJrbVVyLzlyVGhCdXd5NjQ2ZTBKVzk1SVVrQk13UFdobjZIcW9NUWNs?=
 =?utf-8?B?TkRJQldEZE9EYWplNFdIdkxCNy91ZGdNa2J3NkE4eEc2dXpUVGRQZlN1aVhJ?=
 =?utf-8?B?ZWpUTk03RUJkR3NZZUNVQnJHUVEwVUFTS2padEtCWGdEd0NTSnlRWml4NXdH?=
 =?utf-8?B?OEZVWmloZ1MxWHR4cmtBVmlHaGptaDhQS01kZ0FDWDdQWnRjYXgxVkFZaHNX?=
 =?utf-8?B?WkcwOTFwRnR0VlBqdjllTldsM1dKVGVYbWJrYzM0bzZRWkhkbjdwVWorYzM5?=
 =?utf-8?B?dUxjMjVSYUQ1TFFIK3JvTlgxZkpqZVFsYXNySXRPaGxxcWp6dDB1dzdvTnFV?=
 =?utf-8?B?Z1ExdmFWejJaRU5jQmJ1QkJQUmRYalVCTDY0Wk80eUZMbWEzMEJKckVIRHFj?=
 =?utf-8?B?UUlERStadFBlQWVwZFptUHdvbmxxQStnZEFndDRRTFJRRUpsS3JIOW9icndS?=
 =?utf-8?B?d2pqNHNoRUVoM3dScytpRHc4R1VnYm1pdCttcGNwc3FRL3gzbGU2SnFaVThG?=
 =?utf-8?B?dFcwWEhWNVRKZlBIcTBpYVJnSnl6SHdST3lVRk05Z3E1WEJPK1laVjBMNmRY?=
 =?utf-8?B?UzdXQmJqSmVzV2NzU2VZc2JrcW1kQlRKMXRDVXlPOHlaQ3Y4eXFTNUpQaldE?=
 =?utf-8?B?V1h5clhCWE4ya2VMWGFUYXdSUXRUdzhwOHVnQmUvYmYvdG9LRjBUbWJDUjdR?=
 =?utf-8?B?cWpiLzcvOGtSR1BqVThlUmJoVzdzQUt1UnF4TG1abEM5aWNMSVYxekdteGth?=
 =?utf-8?B?bVpETGRjYUI0Ui95VEUraFpneldiR2wwYjc0VkJGbFNmUlRjVXVxOWdBK3pK?=
 =?utf-8?B?dlJBcTU2RVBCV2VsUmNESzZOR01TK3JBSk1OTkM5ckF1Um1tSWtPZW1vUFRN?=
 =?utf-8?B?ZklZZXkxQ2xFejFwU096OVRvbGtXOURyaGRJNG80dlBTWTVLSzZDL0tKYnlG?=
 =?utf-8?B?U0VWSUwvbjN1cjRCMjdYQ0RETnB3STFpSFJSWDhhTDhnY0ZKMk1HaU5IeWlp?=
 =?utf-8?B?VUUxNUNlUHhJNnNYZWFyTnhUa2xySTRrNlRnMm1mRGV6RWxPQmViR0h1RmN2?=
 =?utf-8?B?NDJWMGtlUERzU3ZVRjNnYlJ3a3pnNU5FUXNranJSTWZQVWpTOEFWeFlQRDBH?=
 =?utf-8?B?VUVISVhVL3ZXbldxT01rSnBZcmNoRW5oUEJlT3ZCeGNTZ0ppVWtXSmZVTWND?=
 =?utf-8?B?VTF5MzRNcVIzMXp0RUhFTDJ3MDFYak1TcFg4amdYRzI3bjhLVU1tVzZFRjNL?=
 =?utf-8?B?WE1uN1hkVHJuU1VwL3crSVlzNEZIbndSeXQ0Zk9yL1U1NncvL2pPUDdCU0ky?=
 =?utf-8?B?YjN6Z28yNjBXK2FBMVRBaWxBbUovVjRIVng3eGpZazRDeTFLYlRHT1lNeEpD?=
 =?utf-8?B?amNDTGNqVVcyYjlXcGV0L29DeTk1aDFaZDAxYzR5a1NFaXVXdldydUtnOVJS?=
 =?utf-8?B?OHRES1I3VUcrc0N0WUdJN055Z091UnExbUw4VzU1UW9VTGFxVndGTTd3cEht?=
 =?utf-8?B?bTBKczVtVlZBTnpiMmhGazdnYzd0YVBkVk5OZHJMLythQU9lYVE3ZG1uMEVo?=
 =?utf-8?B?WmoxSFZOL1NiM1dJY1ZCK0pUdENvdFNDdUxlaE93b2FzOTl4a0xWWEg5TFYv?=
 =?utf-8?B?WW9MMDdla040VHlmSXFOOEZpNDRzNWZRM0FRcDNodkhPV01ldDdCY3VHS08v?=
 =?utf-8?B?dnBtWHRFSVQxVXhlc01oMWNkeEU3eDZnNFBBeFBhRkNsaEtIa0Y3bUNRSzQ4?=
 =?utf-8?B?WG41eUZZQmNZZjlPbFZMdFpwL0E1VTRqRmtWVHNHcGpZTmNRaW9PRTg0S3Z2?=
 =?utf-8?B?Qmw4Vjl4VDBJOTN1YmkzR0d5Q1JFclZibHViUDNleUo5ZkRicVFyd3ZyVy92?=
 =?utf-8?B?QUJiQU1WbGMvbi8rRGc3bjVacjcxMlNxTlZnenZ6ZEluVitTTm0xWEpNYTBV?=
 =?utf-8?B?SGhWeVZ0Y2VxazlWamNHa2ZFZ3JBSU03NkNMOGZWN0lrUlNRc3hqd0phcGow?=
 =?utf-8?B?TmlpWlFmbG1objdhc2ZyVGhKYVJUd3NQcXQyQnk4cHpxMlVaU2RFQ09rTDFj?=
 =?utf-8?Q?rBtqCKFMRBmjZl90Fr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96c0b7b-bf3b-419c-6b2c-08df17f5a5a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:33:12.5651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/8DsGJHuHHUIf4G1zwNnHfz/MWPDmkNkbNnYUCYll9ycr24Q9mhEw/bzDE6Mo19qEkomVKz6qv/1F6vHx/ipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
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



On 9/21/26 05:41, Timur Kristóf wrote:
> DCE6 should use legacy fast updates, just like all DCE8 - DCN2.
> 
> Technically DCE6 should have been included when the fast update
> code was refactored, but it just happened to work until now.
> 
> A recent commit "Attach only plane updates that actually changed"
> has exposed this issue because with that commit, DC accidentally
> took the new fast update code path for DCE6 as well, which caused
> it to boot into a black screen with a flip done timeout.
> 
> This fix should be backported to all kernel versions that
> have "Refactor fast update to use new HWSS build sequence",
> but this patch won't apply cleanly to older kernels due to
> another refactor in "Remove dc param from check_update".
> 
> Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
> Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from check_update")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>> ---
>   .../drm/amd/display/dc/resource/dce60/dce60_resource.c    | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> index d2d56a1c4b8b..f4efa55952f3 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> @@ -448,6 +448,12 @@ static const struct dce_abm_mask abm_mask = {
>   		ABM_MASK_SH_LIST_DCE110(_MASK)
>   };
>   
> +static const struct dc_debug_options debug_defaults = { 0 };
> +
> +static const struct dc_check_config config_defaults = {
> +	.enable_legacy_fast_update = true,
> +};
> +
>   #define CTX  ctx
>   #define REG(reg) mm ## reg
>   
> @@ -937,6 +943,8 @@ static bool dce60_construct(
>   	dc->caps.max_cursor_size = 64;
>   	dc->caps.dual_link_dvi = true;
>   	dc->caps.extended_aux_timeout_support = false;
> +	dc->debug = debug_defaults;
> +	dc->check_config = config_defaults;
>   
>   	/*************************************************
>   	 *  Create resources                             *

