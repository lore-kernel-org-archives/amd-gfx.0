Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9E1D5CC87
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 10:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE22010E776;
	Wed, 30 Oct 2024 10:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bxjCcWHG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2533B10E776
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 10:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvZi9nu0aYw1Y7M/8P1XzhO0uISbO71Xr0c/up2MYym6nrHnlk0YPV3Vz9nCdeYwZi1MVpO9yGZRgI55Zs1jLPsEWpuUve8umCxz5zYRrmbrAphN0N6rxQYBRcZ3ACRDs577PshNkQOtga8hv93exNkPhghauCjRcLkq96cPeFHyL213fG17b2xmajvwyj8vNkPQ3dB89eqoeTVk3NX9WwJLb0KrGTrTFBKPUdKidWyBWVqdJJ7TX3soYPswqsIqxfVZAiKOTdvKsXAjhwALALple8Xdl122CDhocgVVs2qdxJKijMj52iIqXO7Dh1Hd6ZTZ9yR5wmbmYQDnPewJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8Kgs8xC4mc2ChEGMU5LCvqwyr+wrlkcmhzzy3Xods0=;
 b=FanOaMdTTQhlbsdMFpIM1GE7XcXDc336XkfSpJ4Rs0DGZYq5RO1xwCVs0KnKjdC3bbbqO9GJR3s/0ObXyXpzOBU1hyy9jZhQk3u3CY0qgpHTEFXixD9GgD0XNIvqNirvS6e5pCnGHJrS9HFS8UCsofUwBUYB2bvrp7vwFcqtDPkDK86pjBY4uoZcfYF98qqYFzYnH56JV9DVPYF11SpWFrObbqDdRLMbTmM0LTznRZAGuhwcx5vRueMNYODJymo+EFbyjvD91qCQEgxMno5/aRjG5/uc8q9TFRk1H1gDyOgNFsgWhn/U4SLWpfPPaVY9uK7EN/jlWR2ZfLlrEfVXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8Kgs8xC4mc2ChEGMU5LCvqwyr+wrlkcmhzzy3Xods0=;
 b=bxjCcWHGHGh/u6JiEHBzAJVZl/0zqv7sZgb7mcCmlffLfFlBOTcgBRJo6UY02cLJqoGDMkVd3oIWj+m/f63kgKU+iUUGc4KSAzpkp9hHtB3vfHZZjj2odNeqmLRmXxgZefzPbEDnEhylKQcEx3A+2gPAkSSSOLWOr6ehn5A18n4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Wed, 30 Oct 2024 10:29:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 10:29:33 +0000
Message-ID: <1f376d38-34ec-49ef-8391-d547613f60de@amd.com>
Date: Wed, 30 Oct 2024 15:59:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd/pm: correct the workload setting
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241030094340.49639-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241030094340.49639-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: f764e4df-8022-4d5d-0abe-08dcf8cdbebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXczZVRhN2FzaW5kbTB5SmhQWnprNHh5VEtnN0ZEcE0yckpMZW5UbWk3MVd0?=
 =?utf-8?B?YkVyYkdQL25IVUJKa0NTMjBwVkErVGpXOTA0cXRIN0J0TVUxU2RUZkt4WWxF?=
 =?utf-8?B?RDQ2UXJBamt2SGZPOEFsdWs0Q2M5OXFKRTk3TFdjNVc4Q29ZMWl6bmhlUUlu?=
 =?utf-8?B?dklXRkxGOHVGRHZXRHRhcStjelIzc0k4VE9XN3czdlBrNjUvYUlZKy9kdU04?=
 =?utf-8?B?REZxNkhlUENpNnpWeENpNi9MWnpPcGd5MXc3MVJwT2dZSlNNRWxJK2d6eHRv?=
 =?utf-8?B?M2txSG5kemRHbUtoOG9CYm5QaW4vWDNPbHptdTVVMWtOdjF3THRjSWJSc0t5?=
 =?utf-8?B?NkZXOEx0bml3Z0JVc0tsUW1zNEN5dTVRN2N6WE5jQkVCNUZRbzNOWEFLcy9R?=
 =?utf-8?B?Y1A4dWIycENJVzZNNEY5WHVaeFVQOEttRWM3OWVrdmhqNG5yK255SjZjWFJK?=
 =?utf-8?B?WU9iZDVvK1dSbysvMnk1a2s3YTQvSmN4Sm5icjRhL2ZiUmNhand0VmczekhL?=
 =?utf-8?B?L2NndENsZSs3WFRWQVlRcGFwOE03Ly9KYTJOTHpCbUE5RVBqaFpBZWUrVmRH?=
 =?utf-8?B?STFCN0x6dkJycUprRHZMdFVFQjV0L0hON1E2aUMyaEUveHZ1N28vUTFTUmlQ?=
 =?utf-8?B?Q2pCczFtc25NTFJKejg3aXptb1VBQnhxeE9panVleVBMdmJ4WW5UZ0ZLbzk1?=
 =?utf-8?B?TDMxK1N6T01iSG0yMi9vMXovTk5IN0VkYnkrbHRPS0tHKzFvMXZPYlNoUndI?=
 =?utf-8?B?bTVvOUtVUllkajd0Tk16RCtpVEFDd1ZKbmxWNW1tZk90U2Q2Wkp1TkFNaEpi?=
 =?utf-8?B?MHBXekJLdE5uTzhXdnVicGE3bkFpVXpxVzN3ZHkrVXhDTlpWSGZDcFZFRGVF?=
 =?utf-8?B?aVFUV0FkZ01DbEJsSTFOa1dsMERZbkxZbmsxWDE5dHhCODNQalJMMG8yMmZy?=
 =?utf-8?B?VEdIODJETkpiNG5GREdRMElmWU56UUxneDNRc0Vka25KaWU0Rk8wOTJrOU1W?=
 =?utf-8?B?QlRsNDllRDhsTCs2VFZhTVpUNllCYjhobWRUdWpDM3NsMXByQ2JrTFRnWURn?=
 =?utf-8?B?ZjJEMC9oM3dZR2xNZk01ZTlRNXhteG9JTzE4MFVZRHNhZ0tVRExUcENXK1JD?=
 =?utf-8?B?b3hUU09ZOHpUUzdqZ3JPUkU4SFByS0QvSWtpTVJGY1pZTXUwbDJQL3BhUVA3?=
 =?utf-8?B?NFVkdW1JdEJER0xBZHdVNXdaZzdtSFhqeTNPY0tmYklsQk95cTg5Q3F0R0pu?=
 =?utf-8?B?U3hEUWhVNzBFYTRXSlRYcndmT0FNQWwyb1NaZHc5V0NUWlZWZ3dvTEUwTGNE?=
 =?utf-8?B?cGFPUVNWWGJlZ3kxUFdCMTBoUkxkYkh0V3d3NXFGVnkzcDRYN21YbjVmS3Fu?=
 =?utf-8?B?TFFmOTZLKzdpUVc4USswV3RraGRZT0pTdFNNRVJjRnJBMjBSSUNaZkV4RW5L?=
 =?utf-8?B?cVBBTlpPaWc3aUwxMGR2b2RPa2xjdS9mYWFGamlsRUdOeG85K1FUVzFxRTEv?=
 =?utf-8?B?MjduWkhBdjE4QlBYNW5hbjVrUGFNZDJnbHoxVmZ3eFl1bEQwejhkaXRVdFB5?=
 =?utf-8?B?K0wyckh1Q28zN0FRYlUvTkR2SUw2M1JLdXdldUIwYWVBTmZSUGNKbHI5Rnhp?=
 =?utf-8?B?UkpNUXJkYWRTdDJVdTJsOWpxa3dmZ2owdDJ5ayt4enRUdEc5aFF5cFBNbnpE?=
 =?utf-8?B?cnlMbWQrYmZ3dktIZHk2V2grbEwyTkt4clNpU3prNWFyREp1L0Q1N1B1Wncv?=
 =?utf-8?Q?NjOV9+SGJZ9L4OF2OaMzamI+ndz6CdjTFGiGMg4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk44dUdUakN4V3Q0UWhMVmM1Vk9vSlNqMVVkLzUrbUgyMk1CME9CL2ZYbEJk?=
 =?utf-8?B?S3UwZnI4RGttOXc0OU9hcDJNWCt2YUNtL3AyeGRCRmNHeU9Nay9OaUFQOUox?=
 =?utf-8?B?TjBkQjVyMzhicDlBRFpHU3VlcW53T2l4dXBoNGlCdEsvZmRQV2tuaGFSUTU3?=
 =?utf-8?B?NkxFOUVzMmo5MGZqUTg2ZHRCUW1saDJDTlFaWWQ4Tnk5bHc5T3VqY21TZXNC?=
 =?utf-8?B?VHVDVTJGMnVVdURSbnJHaFZ3cmREU2I5K3c0QnFyYlFuMTh5cVdRL0IrbGo4?=
 =?utf-8?B?NXgyS1FFQXN4NU1NRXFLY0h0dFExeEJNVGdkQjBFSU5LTi9hQ3JvelFjQ0NJ?=
 =?utf-8?B?SFhLeDVTU0hIOHNKczRTdGZBdHZnQ3I4U2xLaE0vcWF6cXZPUGd4Sy9yWWZj?=
 =?utf-8?B?dWFGSEt0WWt1Wmd2YTl0bnVLZ3gzVXZiUHJpRUtCamNETytub2xmNWJJQzVv?=
 =?utf-8?B?U0hTL2pQeXkzd1FzcTN1N3VuVlU3V0Zkdk1adWV4VmFHdk9IeXg1dmo5OVZ1?=
 =?utf-8?B?VzF4dGRsTmh1K29CR1FQbWs1b05BZTNmQVkzSFR5YzhrS25PbUpsNC9ZQkNR?=
 =?utf-8?B?MkZqVzFRaWl2OHVpT0ZCcFc2YVBrdXdnZXhoL2FqQlJhRFp2VlRKaVBhbXVS?=
 =?utf-8?B?b29SQkd0Z0g3b0IxdjFyeEw2UXRxWkE4cXVxOWZ5N1JoenhtcktrV2RGandO?=
 =?utf-8?B?eG1qd084aGRQZDdHeEljM1FjS2I5VDZMcjRmbmdxQzU5UW1jY2VIbmJ0Y0F5?=
 =?utf-8?B?L3JudTd1WVkzNXRyMUxxcTBYeml0WlNGdTBTNXlXZGUzOFpkMk96UjBUcnJ0?=
 =?utf-8?B?d2w5b2l4TnRidFErRDQ5a1hJUVZob0ZaUS9OSXF0bzgrMWs4azB5ZnROOFhq?=
 =?utf-8?B?TER0N3FkL2thWHEzdWVDdnJqNmhtYlhOMytqWlhaTzhQMzNaTnIyU0lwdVc3?=
 =?utf-8?B?dncrWW5WMUkyVHRObmp5VTFYYk5UUlN5cGE2UG9YWDJCQUd2VS9aVkE5Vkxs?=
 =?utf-8?B?Q0J2WFllOHVjcmx3RE9GeG51eGlrczA2NkJ6OWlaUmltNUdkdEJDZkdIaDAy?=
 =?utf-8?B?TUMvL3FaUnE0TEZvaE1ONmR4K0lpUnBWdnFBV0pvbE9FckV1QUVUVEZoRmI0?=
 =?utf-8?B?STUxRWR6SHVGL1VObVlJUmtqTjBraStrTTMwYzk5djUzTVhNdi9Kbm9pckds?=
 =?utf-8?B?SEgyY01HWGJUbmdCNThLL1N2ZFpMTENBZXdhSy9LNnVKckRwL0VQRGZQUUlB?=
 =?utf-8?B?Y0VuQzZ6MXVFR0QyVnFVS2VxQmdXTmVlTXY0dUwyeVI2VXZ5YUg4aUNwV3d1?=
 =?utf-8?B?dTNobEUxYnhtSGdmQ1NHZmMzRjc0Und6em9lNGQ5MXRqWlJqa2NzOVBWNmpB?=
 =?utf-8?B?YmlWbjZrY0RaVnVxZmFoT1p2S3kxS2hSSXcwSG1tc1BFUENRckRmaEhXUUpL?=
 =?utf-8?B?a0RYNXhWdENhVnArblpOT0hwYUpnTnM1T0VqeWYzdEFFekR2UFo4MDlBWXNa?=
 =?utf-8?B?K1lBaG1yWUVmSGxjazkyZXFWbkNpak9kdDNWajJzT1VKelZMZjBza3RkYjNC?=
 =?utf-8?B?TW1xZGR4bkZPT0xZY3V1cGRuL1hrVW9IcGVMUWhIeEcrL2JocnhST3hHcmVW?=
 =?utf-8?B?NXVyK3pkWXk1UlR0SGQxdERKZjBTMk9QWkFEbnNkRTExazdSd29sRC80UmdQ?=
 =?utf-8?B?RVVKUXhpc0JSVWF0THdlRFE0T0xaSnlsampBK05paCtXbWFySU9uOHl5Y1VG?=
 =?utf-8?B?TEp3VGlWaXBrTUlSNTRHUUhsSkJkVHgvc3RCZFduU3hxaDhZWUFHWHhmK3l0?=
 =?utf-8?B?R01FZTJBck9lTVk3MWNJNWhDZHFveE5ESUErUjUvT3Z6c25NOTRJNTdQK214?=
 =?utf-8?B?K3Y5U1pJSlJNNTdpZkdpTHNpVmY5bG5wQ1BGMEV3N1g1QVZHak01eGs5elNM?=
 =?utf-8?B?bVVlcGZWU2FjWDc2d0ZxSU1nYkRLNmdURytyU1NyZ2t1eElTR3p6YjRVMWFk?=
 =?utf-8?B?YmJLWndKZ214TzZWenphK3FyRzRtZitnUC8rcnhLeVFkRUFjbkxpRGlrU3ZF?=
 =?utf-8?B?QWdGOGIrdDlqNkN2d0tNSHZIV0hyQXRTZGpEQ1BLUVpDdVdMb1g2Um53OExk?=
 =?utf-8?Q?Wz9Ljtwd4lwykTkLacMiTSO5C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f764e4df-8022-4d5d-0abe-08dcf8cdbebf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 10:29:33.4249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3ZjWzKd0UJcZFXSCzZoBdr7w+WLcRzTzIXEjoy4ZZCTQbbKqz4duq/hHQIY/VaR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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



On 10/30/2024 3:13 PM, Kenneth Feng wrote:
> Correct the workload setting in order not to mix the setting
> with the end user. Update the workload mask accordingly.
> 
> v2: changes as below:
> 1. the end user can not erase the workload from driver except default workload.
> 2. always shows the real highest priority workoad to the end user.
> 3. the real workload mask is combined with driver workload mask and end user workload mask.
> 
> v3: apply this to the other ASICs as well.
> v4: simplify the code
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39 ++++++++++++-------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  8 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 10 ++++-
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 10 ++++-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  7 +++-
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  7 +++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 23 ++++++++---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 12 ++++--
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 15 ++++---
>  10 files changed, 97 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8d4aee4e2287..57cbc41f8457 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1261,26 +1261,30 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	smu->watermarks_bitmap = 0;
>  	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>  	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +	smu->user_dpm_profile.user_workload_mask = 0;
>  
>  	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>  
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>  
>  	if (smu->is_apu ||
> -	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
> -		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> -	else
> -		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> +	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
> +		smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];

For adding clarity to code, the operation needs to be reversed. Instead
of smu->workload_mask, assign smu->driver_workload_mask here.

> +	} else {
> +		smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];

Same as above, assign smu->driver_workload_mask here.

> +		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +	}
>  



> +	smu->driver_workload_mask = smu->workload_mask;

Expecting the assignment here like
	smu->workload_mask = smu->driver_workload_mask |
smu->user_dpm_profile.user_workload_mask // at this point user workload
mask will be 0.

If this varialbe needs to be kept, preferrably, this is done just before
sending final message to FW.

>  	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>  	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>  	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
> @@ -2354,12 +2358,14 @@ static int smu_switch_power_profile(void *handle,
>  		return -EINVAL;
>  
>  	if (!en) {
> -		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
> +		smu->workload_mask &= ~(1 << smu->workload_priority[type]);
> +		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);

Same comment as above. Assign only driver mask here and in else part.
Outside if..else, assign smu->driver_workload_mask.

smu->workload_mask = smu->driver_workload_mask |
smu->user_dpm_profile.user_workload_mask.

Basically, whenever workload mask is applied, it takes driver and user
mask as inputs. This makes sure that any user specified values are not
lost when driver prefers a different mode. We could let the FW decide
the final workload priority.

>  		index = fls(smu->workload_mask);
>  		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>  		workload[0] = smu->workload_setting[index];
>  	} else {
> -		smu->workload_mask |= (1 << smu->workload_prority[type]);
> +		smu->workload_mask |= (1 << smu->workload_priority[type]);
> +		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
>  		index = fls(smu->workload_mask);
>  		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>  		workload[0] = smu->workload_setting[index];
> @@ -3054,12 +3060,17 @@ static int smu_set_power_profile_mode(void *handle,
>  				      uint32_t param_size)
>  {
>  	struct smu_context *smu = handle;
> +	int ret;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>  	    !smu->ppt_funcs->set_power_profile_mode)
>  		return -EOPNOTSUPP;
>  
> -	return smu_bump_power_profile_mode(smu, param, param_size);
> +	smu->user_dpm_profile.user_workload_mask = (1 << smu->workload_priority[param[param_size]]);

Not sure if a check is required here about the current
user_workload_mask and newly passed parameter. If required, please add
that here.

> +	smu->workload_mask = smu->user_dpm_profile.user_workload_mask | smu->driver_workload_mask;

This is the expected code for every profile mode change which represents
the final mask. The bitwise mask operations are done only on the
respective masks.

> +	ret = smu_bump_power_profile_mode(smu, param, param_size);
> +
> +	return ret;
>  }
>  
>  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 8bb32b3f0d9c..4ffed49ebb4b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -240,6 +240,7 @@ struct smu_user_dpm_profile {
>  	/* user clock state information */
>  	uint32_t clk_mask[SMU_CLK_COUNT];
>  	uint32_t clk_dependency;
> +	uint32_t user_workload_mask;
>  };
>  
>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
> @@ -557,7 +558,8 @@ struct smu_context {
>  	bool disable_uclk_switch;
>  
>  	uint32_t workload_mask;
> -	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
> +	uint32_t driver_workload_mask;
> +	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
>  	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
>  	uint32_t power_profile_mode;
>  	uint32_t default_power_profile_mode;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 5ad09323a29d..f1e271e4f470 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1449,13 +1449,13 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>  	int workload_type = 0;
>  	uint32_t profile_mode = input[size];
>  	int ret = 0;
> +	uint32_t index;
>  
>  	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -
>  	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
>  	     (smu->smc_fw_version >= 0x360d00)) {
>  		if (size != 10)
> @@ -1523,14 +1523,16 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					  SMU_MSG_SetWorkloadMask,
> -					  1 << workload_type,
> +					  smu->workload_mask,
>  					  NULL);
>  	if (ret) {
>  		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
>  		return ret;
>  	}
>  
> -	smu->power_profile_mode = profile_mode;
> +	index = fls(smu->workload_mask);
> +	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +	smu->power_profile_mode = smu->workload_setting[index];

The above piece of code can be moved to something like
smu_cmn_assign/calculate_power_profile() and called from all IP funcs.

Thanks,
Lijo

>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 9fa305ba6422..df158d789ced 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2008,6 +2008,7 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
>  {
>  	DpmActivityMonitorCoeffInt_t activity_monitor;
>  	int workload_type, ret = 0;
> +	uint32_t index;
>  
>  	smu->power_profile_mode = input[size];
>  
> @@ -2081,11 +2082,18 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
>  						       smu->power_profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
> +
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    1 << workload_type, NULL);
> +				    smu->workload_mask, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>  
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 77e58eb46328..7263e53eafe1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1713,6 +1713,7 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
> +	uint32_t index;
>  
>  	smu->power_profile_mode = input[size];
>  
> @@ -1786,11 +1787,18 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>  						       smu->power_profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
> +
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    1 << workload_type, NULL);
> +				    smu->workload_mask, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>  
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 6c43724c01dd..fa7b45208777 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1058,6 +1058,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>  {
>  	int workload_type, ret;
>  	uint32_t profile_mode = input[size];
> +	uint32_t index;
>  
>  	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> @@ -1079,7 +1080,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>  	}
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> +				    smu->workload_mask,
>  				    NULL);
>  	if (ret) {
>  		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
> @@ -1087,7 +1088,9 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>  		return ret;
>  	}
>  
> -	smu->power_profile_mode = profile_mode;
> +	index = fls(smu->workload_mask);
> +	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +	smu->power_profile_mode = smu->workload_setting[index];
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 0b210b1f2628..4aa3bf005850 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -866,6 +866,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  {
>  	int workload_type, ret;
>  	uint32_t profile_mode = input[size];
> +	uint32_t index;
>  
>  	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> @@ -890,14 +891,16 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  	}
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> +				    smu->workload_mask,
>  				    NULL);
>  	if (ret) {
>  		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
>  		return ret;
>  	}
>  
> -	smu->power_profile_mode = profile_mode;
> +	index = fls(smu->workload_mask);
> +	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +	smu->power_profile_mode = smu->workload_setting[index];
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 8d25cc1f218f..1023b39ac995 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2473,7 +2473,8 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
> -	u32 workload_mask, selected_workload_mask;
> +	u32 workload_mask;
> +	uint32_t index;
>  
>  	smu->power_profile_mode = input[size];
>  
> @@ -2540,7 +2541,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> -	selected_workload_mask = workload_mask = 1 << workload_type;
> +	workload_mask = 1 << workload_type;
>  
>  	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
>  	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
> @@ -2555,12 +2556,24 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  			workload_mask |= 1 << workload_type;
>  	}
>  
> +	smu->workload_mask |= workload_mask;
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					       SMU_MSG_SetWorkloadMask,
> -					       workload_mask,
> +					       smu->workload_mask,
>  					       NULL);
> -	if (!ret)
> -		smu->workload_mask = selected_workload_mask;
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
> +			workload_type = smu_cmn_to_asic_specific_index(smu,
> +							       CMN2ASIC_MAPPING_WORKLOAD,
> +							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
> +			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
> +										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> +										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +		}
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 23f13388455f..056c45453a36 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2429,6 +2429,7 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
> +	uint32_t index;
>  
>  	smu->power_profile_mode = input[size];
>  
> @@ -2487,13 +2488,18 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>  						       smu->power_profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
> +
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    1 << workload_type, NULL);
> +				    smu->workload_mask, NULL);
>  
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu->workload_mask = (1 << workload_type);
> +
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index cefe10b95d8e..f139c338e822 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1787,6 +1787,7 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
> +	uint32_t index;
>  	uint32_t current_profile_mode = smu->power_profile_mode;
>  	smu->power_profile_mode = input[size];
>  
> @@ -1857,12 +1858,14 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> -	ret = smu_cmn_send_smc_msg_with_param(smu,
> -					       SMU_MSG_SetWorkloadMask,
> -					       1 << workload_type,
> -					       NULL);
> -	if (!ret)
> -		smu->workload_mask = 1 << workload_type;
> +	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> +										  smu->workload_mask, NULL);
> +
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +	}
>  
>  	return ret;
>  }
