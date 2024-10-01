Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8207ECE837A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 07:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD2310E5E8;
	Tue,  1 Oct 2024 07:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i623elmx";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9FD10E5E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 07:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSSSJWTcLch5sgRFpCgUq40f065q7echnuyDX3f5Kdyrs+EKteAPyDelw5qFkB2dmA3HDzpZmV2Je+35iuERh8Sh2ZhVYloIhr3vqRLcnlxigJicE+tsGyedrogfNuasnc9RuW9y0Mq63UsuE7OQis6x92JG0fyS8VMDAaLibWrTVgVfZvxT45ThQPjt+ATkdngmpbmCzY0uaQncBrEMhlA7/e76VdGD3Yi017Oi3TAJJIrN25jv+pjLpVQXxKuemTv2ZJ//0G+clO8dcAEwX0ARULXuMOIOIAmLWui/C1xKiGMnjgR+fu6pftCtTeUmOcI4orh16KLBzfg6b/s86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZn2C3GY3rw8aYiZtbFoe/U+wVWB47vVyYbSW4gQTk8=;
 b=zMrUS2H1rO/frc5Y3rA7eeVF8oC34PS26mrvWtQqPDaLuRPEK8dVhcx60cpzWb7DItNiDETJtIXZmHni/RAOivD3KODaobVpPLfLsr9JYMFseNQSt1aKa2Nyb9LdRYwZCncCLApCL3iE8a+YpAirRI+7In4Swno+Dg+uVMXpuIaFu4UvH2E77hdbMqenWyeSg7Dv8HCjLZYewyv0+OMjmjwb0/pUD0GZuSmWafIje2yFAV+DBCUulaf+fOo1T9ND3pu0VNZMgMMjJMzndsyAo56XjpEgY24xKnP3FU4EaTTbGhvh5OEuPXE/MpwHT9fiWcRfDodS7cdT1xKdeJvSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZn2C3GY3rw8aYiZtbFoe/U+wVWB47vVyYbSW4gQTk8=;
 b=i623elmxGaYfrk2F3ZoOw6YPSbZxrPzM9pEIMZO00M2PNAseaMiakeoKp+YEm/KqmfIovfAnCwBjirbdefb/H1CqEUIsb4cSz5naJ4/90RFa49MfFHVCzWPNxZalhxIyrOo35F2gE0UkKj7KJrSL+A818zQyxtULjNO61P+zjgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 07:21:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 07:21:38 +0000
Message-ID: <e28ea7b3-2fa7-4c66-9ca4-25f8e7388d95@amd.com>
Date: Tue, 1 Oct 2024 09:21:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx9: Add Cleaner Shader Deinitialization in
 gfx_v9_0 Module
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241001070047.2578002-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241001070047.2578002-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6073b1-a71c-4e4d-fd2e-08dce1e9b040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmJNZzJ2SmE4YjhWV0g3WXQrNm1yUGRrUi82UW1pYlFkalBaYWU1bDBiVnBB?=
 =?utf-8?B?d0t4K0lWUWxDQUdqWjJhcW1SdGtxUWdmTktFSTBaeFlnMWFaZkk1dHcvczRn?=
 =?utf-8?B?Uk1uRHdSWG5SOTlZQnpOSHh5aGpXcTJOOG1mcmoyandmWDUwelRtbElxTUZ1?=
 =?utf-8?B?bm5tUWZ6OXJLY3diN1FrMXhaSGw1VllRUlU1Rmc0UmJSNEcvaDd6Z1M0T2d3?=
 =?utf-8?B?Qjc1VGhtakdhaVJYcmJUbUZ4NEV0SXRJYWw3WWxDM1ErUDA5MHlWVFgxTVlD?=
 =?utf-8?B?R0VVTGdVaTJ5ZGIrWVJXbTdVYzdWVmZyU2c3T0dqQkJ1U2Jac0RtUVRMZU9u?=
 =?utf-8?B?T0dnZzByZ1VoZlFxcmJoamUrN2NrN1I4U2tKcnltdElDdUN0K1lNSlhVVkJ4?=
 =?utf-8?B?anVzY2VXdktoNTR0bWZ3MzhINEpkT2puQ25nTUF4SnRmRzlLMGxvSzVyUWlO?=
 =?utf-8?B?ZnAxdVlJRHMvL0dTNFYrNnNNdm1saTVDMkhmejRWV0k0NzJLRitjOW9tYkVQ?=
 =?utf-8?B?NHFqVHp0OW9PcTFCZmNkbGh5SjhKMUlneFhMeU1tWHY2K2lIbzQ3WElRNEYy?=
 =?utf-8?B?cXdXSTBPNFpxczNVTW5pNXROQ09ZdzF6OEd2THRKWTEvbTFTMFJMekJ3elNF?=
 =?utf-8?B?K0ZNanNSeWF6QldrYlNIVGF1d2huREFIZC94Q2R2MXBhZ080OVdzL0pycUxW?=
 =?utf-8?B?NHdZbmdaZUl1L1IzRFpaQnBkaERGakZhekdJT3VhK0JIVjdaRHJkY1pNNkh4?=
 =?utf-8?B?R1Nrb0NaTkNHK0NkRGN0VG95YXp5RHZVQlNvUlJ4UUU0MGZvZnFlSWhhTjV4?=
 =?utf-8?B?NkZLVFE4MG93aXJPOHNlVFdycnFPUWJKNitEMDVlWkJkY205aEltNklRR0NC?=
 =?utf-8?B?RGxnYmlyUjc3Z0lDZ3FkSU1DaTAzbXpHbno5cytpTE5MVGNqUkVUdzJsYWN4?=
 =?utf-8?B?YmxlSElXUjFldzdFaGtJbjFveHovUExwa0dMM3NMLzBLQlZQbkpVcjFiQXlu?=
 =?utf-8?B?bVluTi9NVHRmSkh3UC95akVyaFhYdUJuMWNmZ0J5NXFUWDcrdEdya2tEQUlH?=
 =?utf-8?B?UWVQY3VnRDNMNi9wdkNVSHcvbktoZFJzWENvR3pxVkZ1dHNrb3o4dDVtYi9h?=
 =?utf-8?B?TmtONjJOSVBIeEVEaW91Q2Ira2hVbnRxcmRSWFh3RnBuemwxVkxaNVZCcnlU?=
 =?utf-8?B?a1JrczlKTXNuYVA5djNzSzAxVTFNMjFaSTdpWDlRMzNtMFF6Vng0WnJlZVhK?=
 =?utf-8?B?OU8xakNjUmNSb3NVM0gwcnhoUkZmMnRWVHNMc0x1VWNHaWFBQjlLSFRzek9v?=
 =?utf-8?B?MVdvY0JjR2Z0bFUzc3VCS0VzajFPZ0QvalNBbW1ubGkwUS8rRXlNTWd1RTc5?=
 =?utf-8?B?NlRHVTNFM1Bzd0dQN3dWZEl1Wm9nMVp2eURZNUJlcnhWbVY0ejdKNkw2UXlH?=
 =?utf-8?B?Y2ZoZ1JTVWpGaytvL3FDV0RyYWMzelpWeWp5NlB3UE12bjVHSVRON0RjOFRE?=
 =?utf-8?B?WFE1RHU4d2pYdFJveDE1MmZWUXowcjhQYXJUVkZqREhaM0krWFFnM1FuVW9n?=
 =?utf-8?B?TTNoOU5xaHZoaGhheDJOdVREb0dKK1MrMmtKVXFqM0FHYjhzTUdFR3JBT3Ay?=
 =?utf-8?B?VEtrV0VYUGhJUXVKR0txVHNSWFMrbHFWazZwSlBKeVJmU1QxQ2JDVThhQUI1?=
 =?utf-8?B?WGVUMDNGY0xnSFN0cWx1Q3NtUmlqRTFoVjJrNE9UWEJIVXBTUDB5Z2R3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkN0UzhNODl0cjVTZXc2bFVabFczTDVrbG1CNWNhMytaSkpUa2d6cWhmMjR0?=
 =?utf-8?B?bFhYTFkyWlBTSS9UT3NZbDJDTmpVQitESW12bm4rc2pjR2o3aU84RVFpSU5Y?=
 =?utf-8?B?S2RJajBEeklvYW9La2I4dzNQNGRZMVVtTTJUSWJUbFREdDRkSnFvL1kxSVAw?=
 =?utf-8?B?R3hEajU4OG1IZ3JBNHlXbEdYSDVqNFFMOUhwTGg4bVhhR2V5cEFYM0tmOVU3?=
 =?utf-8?B?TnhaaHZGSTMwMWEyM04vaGRzQUxOLytOMEhod25ZOXdYZFNjZHIrNGh6N252?=
 =?utf-8?B?bjJ1TkN2ZUNiNVI5aVBsUk9ETGJRRHhHOW5rMkduUjQyUFAwUC9EWjNOY3VY?=
 =?utf-8?B?ZXU3ZU1BSWxYNXZCVTdVc1VyWmZIaG5NU0VZdjFxdHhBRUhkZUNPNWxtTFA0?=
 =?utf-8?B?a0pJSWhOMlJ3ZUU3QUdnYmNaaXZMa3hJQlpGYXVjSnQwK2JvdE1oVmN1Zlpy?=
 =?utf-8?B?VmlUVXdSSzZiRTZOQ2tJTUR3eGlyTWpKZy9GQjB0YVpPUWUydHhmMURtZmFW?=
 =?utf-8?B?MytUc3o1dlpLM1RqZUZ3M1dCOElDUTBzL1kzU1RjcjlRN0IvcHpjYndMYUtL?=
 =?utf-8?B?aTFWNzd1ZVduSlFhWUpUUGgxQ3J1bmRMRGw5L3J2T21oRWhKcnVKK0Y5bDlK?=
 =?utf-8?B?WTAxazFFYnNjOWFUTmpVaENVV0lsSG5ScDd3NXJGVWdFbjdjMkdaN2pPUFUy?=
 =?utf-8?B?d1l6eXMyOUthRW80RlRZQXB3T1dvS2Z3WkQ2QW9DOGpOc0l4R1E0WHBBTGk3?=
 =?utf-8?B?NGFkVUllRXpCTWd1bXFDV3FJY2hKa1RrWjN1NEkvcDV4YVFuZmh0SFZjeHgv?=
 =?utf-8?B?WWZnazRDYUJIY0lMN1YzUzlUNHIzRW1VaHpLcHlPOUVjcnVPYlVkYk16aGg5?=
 =?utf-8?B?OU9ZU21xVDg2b2J6NEVrUTlZUllpbmVaSFdUN3hyMFJrdENKOXN1a2dLT2pn?=
 =?utf-8?B?a25LMkdXemNqaHZKNmRHdHQ1em5lUWZkSS9TNEJSTjhHenI4RXpLS2xMVzVm?=
 =?utf-8?B?WG14dittN09HQWdZSE5jNnpPdkFpc0hGZERqWjlxa3hTbXhKam1nZE5HN3JX?=
 =?utf-8?B?cjU1YXdCcythTERGS3E3N2lLdXd2M2tlNzR1d3pJL3F5T09GL3I0NHMyWi9n?=
 =?utf-8?B?QmFhM2d2SGs5alN4NlYxYkhmOENVOUp0T0F2SHVHTkI5Mllyd3ZIWUJHeDNY?=
 =?utf-8?B?NjJodmcrcDEwci9INHJ4Q2pra2JVL3pjMmlSY0huYXgxdGRuMGkrNks1VjRX?=
 =?utf-8?B?cy9tZ2hqU05NMmgrcUFiQll1T1p3eGtLSzNEd1ZITlZIRjNJdkoxTENhQXJa?=
 =?utf-8?B?ZXM2VjlTWGVWQlY5WGwzZVF5TmplbEpTOWxxNGlac2ErY2pvekhhUzZNZytl?=
 =?utf-8?B?d1V2cnRQNk9RN3hPcEpCd0VuNERsTjZZV2dqeUJGNWRTc1dveEJ6bHpSYWZB?=
 =?utf-8?B?Mzc2NTdVSzJmbVpwVEgwN2hnbldJOW1UaXprVHVvWDNiRGVkL0NVdjRWQmxj?=
 =?utf-8?B?N0FVdi9SQk96Q0pHUmRPSXBGajM2a0VQUm5lRENuZmR4U2pCRWQ2VTYzbWRz?=
 =?utf-8?B?Q08vZ3BaODRSZWdob2pCS1ZSTU5WZEdranN1OUk3eUFyd3hUamlMa3ZBaGg1?=
 =?utf-8?B?STVjT0ZnQmx1cUpnRjZGZUVFUy9SWCthOUN1Qm15aVlnZURRYjIzSzFxMHdI?=
 =?utf-8?B?RGxDdk1CUzlMKzhvVUgvd2xiSm0zbHNrbWZSb3k3N1NCaW43WE44SnVBdFlu?=
 =?utf-8?B?MUI3WVJJZVRudm1NeHVBVjdPNkJOTGZrVERXR0QvbEtHNXpLVHlQWGtneGgz?=
 =?utf-8?B?OVErd2tDdzIxQkEyYlR2azBIRmI1M3JPdTk4UVFnc3hMN282QkpEOWxmSnBU?=
 =?utf-8?B?VGROWkhuNEpESDJrV3p3NjRHTllKYlpPSWxtSll6L2JOUThaZkQzOExSWk9p?=
 =?utf-8?B?YytVbkNEMGxHS21mN2hub29MSzJpakVJN00rOGZ5dVJqaWMwdkM3N295aS91?=
 =?utf-8?B?MWtFWWY3L1Z2MXdRWWtoK3dSM0lxRlV4WjVuMXRod1pWL1Vzek5HV24vblEx?=
 =?utf-8?B?ZElNdUIwVm15V3ExeTdNVE4xRU42M1JHYTNKOUFqQUtBRHpEbXBqcURrNXdL?=
 =?utf-8?Q?ukaroQ0hlTY3WJnCXEY7TrMHy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6073b1-a71c-4e4d-fd2e-08dce1e9b040
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 07:21:38.2704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0a4sFNnRhGkhTtdH0PzAIHKsbdlSzwZDWtB2wroJkPs0dISmr56SzTvl3Zk9ChCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
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

Am 01.10.24 um 09:00 schrieb Srinivasan Shanmugam:
> This commit addresses an omission in the previous patch related to the
> cleaner shader support for GFX9 hardware. Specifically, it adds the
> necessary deinitialization code for the cleaner shader in the
> gfx_v9_0_sw_fini function.
>
> The added line amdgpu_gfx_cleaner_shader_sw_fini(adev); ensures that any
> allocated resources for the cleaner shader are freed correctly, avoiding
> potential memory leaks and ensuring that the GPU state is clean for the
> next initialization sequence.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index d7ef05cdb72e..1deb5eee794f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2418,6 +2418,8 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
>   	amdgpu_gfx_kiq_fini(adev, 0);
>   
> +	amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +
>   	gfx_v9_0_mec_fini(adev);
>   	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
>   				&adev->gfx.rlc.clear_state_gpu_addr,

