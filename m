Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCF6C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 19:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09D010E577;
	Mon, 28 Jul 2025 19:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4cH39i3S";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F1310E027
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 19:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2xUTmnlAzxNdd/uZbo0+x65iTAcfr5czLY1c5w6MZxOu+GHqdJp9TgmZGV6EfmBh81tARFoqiYaKvPyTMcKc9rYaT6P11bfZM250SLQ0YtfGr0NZ+dMPUjAbOfaitedupw+NjdVy6yjkhVJZ20J+hnTkBruSK8YqDqeM/MegHS+acBW8xLwZ7oiIIe3Xg4E1Z1GfKf95f+LYZVMmuTEaJ633jga73MbgCS/hieKP3/QKMJjfsZEYSTlD3+VHrUWqceeq0mPG7EhlwYjXQ/qapwx8xw2HXc6pEhuRvFbwmEoHly5SyU5VDqWOP37FlXf5S1ivsV/dpmE7VVZiJAa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD1YmyuC2jpM8jU1Y/0SCvWmET+8ItzuM1uHZDuSSuI=;
 b=jm+Z9gm85Lk+KvqH1fFpOr3qOnv/SB4jMFkjkgMfTs0OYnMSh0kEoYiinYrHhOFnezxG6v9vfjg4rMDqxmRUcwMp0go+Ca/VJmdMnBWuI+Cynw8dI0L+qZ0srZwz0XNZCgupvc+joRiiT1BwjOGp7q0CyYgtGTmsf6ymNuXB3EykRu8IzCO27vzEwI+De4+hoCLrsE6FhuQ2Dydx3XddHzd/s8LdxnLwnQP3TiOdOziTKQAey+mC3poXbyXwLb9p5WNhtvgtZFmw+Pt6eg24bqr9tyhqOVY9eAc751EgGTnrhtAsiF3iCA8yKJBG/h2Fccy+ISEZw1rfULR3BrctVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD1YmyuC2jpM8jU1Y/0SCvWmET+8ItzuM1uHZDuSSuI=;
 b=4cH39i3SccLRETulQc/8TzALARnZ5tXIHXuZPP+0Eh0LhgwgdOkXAzCBvPaoRgcguTilLFXWs0kXNHj9o3dUVJCUTlPkIFkrBPKYDMFfLOK0h3/RUg7RtNhSZjAXtalLul1riPfnJCKKiyQTHEfiHPgMN0nWK5PDlf3a9/ICOUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.26; Mon, 28 Jul 2025 19:48:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 19:48:09 +0000
Message-ID: <51264616-aca9-4b82-822e-7c8856b47629@amd.com>
Date: Mon, 28 Jul 2025 15:48:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] amdkfd: identify a secondary kfd process by its id
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
 <20250725024316.9273-9-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250725024316.9273-9-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0275.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 046874f0-155c-49b1-974f-08ddce0fae03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVk0TThnOFRNODJydi90MEZlWncwQ0hiZ0dmSnZoMG9PdGp2MVh3UUZJTW91?=
 =?utf-8?B?a2poamM2NEJOQ1dCZTJtalc0WEdEMDMzR0JreTd6RllGWHR5dG1SNUx6K0tJ?=
 =?utf-8?B?bDcyOVl1RVVwMGRYVTJFWHNmeWY1R3JrKzR4RnhwL0lBLy9ITnQ0R2FZSmps?=
 =?utf-8?B?Zmx0cndUV1NJY0VweEdtWXc4eHdWdzdxTzNwNVpFTm5paGxoQ0dFNm83MEZD?=
 =?utf-8?B?YllCdkliYjBidHBldVFpcmdPbmt4WmpMK29RYUM5bGJlZ3Vyb0N0UEQyS2RT?=
 =?utf-8?B?VUtpdzdUYzZrQm1oTVJHK3ZwMzJhZFprc2xzWFBKcHB3c21wbVhYMzY0VzB1?=
 =?utf-8?B?SUVzaG5jWUIweEJjelRna2dPK3B4NWVqdStyZUcram94aytzeWhTcExkSStT?=
 =?utf-8?B?V1NjVWZuV0ZLZDZoUnpER0dBdWxnTUQ0SEtiYndhQ3pvajIzNm5SbnpkaDNo?=
 =?utf-8?B?THBxN216SWJsTGxpb2RuQURNNXpOUVJTakdTYk9teTJQc3pmMVJ4K2dHaUF1?=
 =?utf-8?B?cUtBNXE0YmFDbSs3dEYwZUZZcDlrdEJqWTlIL0MxMG94d2tUSmtTcDBBNWtx?=
 =?utf-8?B?cHRvc29BOWxWVWo2aitXTEdHU1dOMlg4aUNhdXdJcDFZa0tEb1ZnSHVGRlFV?=
 =?utf-8?B?UHhUWGovTDgxSWt0NnphK2JscXE4dk9vbFNteElleXo1SjVudkExWUtmVzhE?=
 =?utf-8?B?SXVlN2VjdXpWT1ptc00vSmx3dnVrRmJxWmRDYlBmVTlWNmcxc2w0bWpEWEIz?=
 =?utf-8?B?N25KTWFORW44ZHZzdlI3eGNoV2pCSlVqTUh3MkxpWnNCZGduSm5PL3grcjVa?=
 =?utf-8?B?OGhTdE5sanVQTFI1WW9uR05kKzRsWUIzUTFPcW5LRVJoQnZickVuR0ljU2Ru?=
 =?utf-8?B?ZExOV0ZkVEFZMDhVbFpTNHFDS3R1eFVnUWNlVzljS0ZBTVpsczJGWUVOajFW?=
 =?utf-8?B?YnNxdFRiR3kreTd6d0Qzd3FVRGJRQnljWGxrYU5hMnlPSkRsU0JLZGYxeDNN?=
 =?utf-8?B?UzIzSkM5VTgwVHNtM2Z5L3RsV3ZLOVVRWGVvcDYvWU5JMmZkZlM2ejlNVHJE?=
 =?utf-8?B?b0sxRTdNaDloSGdITTRSSG13a2I4ZUREc2x2ZE5uTDlaaFg0TU5nZnhSZlo4?=
 =?utf-8?B?WFBLOTljcTNzSlhiUWV2d28wNi8zalBrQUd1RjNmcG5NY0JNYW5VdDh0OUh2?=
 =?utf-8?B?SStPd0dUUUFJODc3dTgvY1hMMzRkU2tQcnN1N3IyK0RUd0MrYlhuY2RjYS9V?=
 =?utf-8?B?MFo4dWdwOGFaZkorK3h6NWNmdXVNc0pnLzFTZnhHTnVRcVhsQUp3cnlwMERt?=
 =?utf-8?B?cTBuMFB0ay9RTmVrcFZDMnFybkxwQXZlNWpTdHBBTEVnWEREODdJenFQOWZC?=
 =?utf-8?B?K1d5WExXQVZFT2NOQ2NqeHlsUEw4bE9yWHBibWl0OVpNRHJGMWhvY1RTUzZN?=
 =?utf-8?B?YzY1Q2toaE9SL2hsUzVRL2pNZkxLelpwWldkZmpzKzRUUTExNUtRQVI1OWtE?=
 =?utf-8?B?R2g4c2RRdFZmMDdOeU5qMm1kMWNDQkhjbndjNVRsa2tXdkV5YzE5UlBhMWtE?=
 =?utf-8?B?aXlKZEVNVzQ5Q0N3cVdjVTJJaUVDL0t1UVV3MFhSRWQyWjYxZmJHaVNsVENC?=
 =?utf-8?B?MmRWeVJEbUNyNThoT095K0Z1U1RwcVk5Q1dVY3g2V1BqZHZiR2phVjBxNVpJ?=
 =?utf-8?B?a0g5UXNpZ05EeDR2ckVFTmtDTkR4MDhFRTdNcVVXSDRhb1htSHJhalVXeHNn?=
 =?utf-8?B?anpkRXlFYkxYb0pOMHUwM0oyd3o4R28rdkxSR2Q0VmFwK2N6Zi8xTGMrVXU1?=
 =?utf-8?B?Q3huaXdBV0xUeTcxQlFWL2ViY0RYdkhvMC85b1pXRjNkYStaOGlqc3J1K3hm?=
 =?utf-8?B?QTd4SHpITUgxbG5rNStqaG9EQm1EZnVwbUhndVhtNUEzVW9MREZiSzVqY3Jq?=
 =?utf-8?Q?pjuFOOnmFGc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NittNm4xNmx2YStzRVdpZGJKS3c4KzJYNUJDMUxhTTQyR3JoNjduK09hOHFE?=
 =?utf-8?B?T0F0bFA3NnNiUHZLMDZoQXhXS1R1NEVYYTMyUUNRUHN0bGVtT2pqeVNacUc4?=
 =?utf-8?B?dGY4WnY1dENLVzhyN0FScGEvY1RmN0p5Tms3NnFzVTd0dHBrdUZHU1BvSDl4?=
 =?utf-8?B?aDJ3Q3ZTdU4rZFBYb0lWY3JtRTJoVlYyKy9ZMmYwMytXd01aZDFDMFBvR1JD?=
 =?utf-8?B?bW1TelNqOHMrTTY1K1U2NkhGUVJabUtjNW1UVzhsckp5WUMzRlpFQWNScFVn?=
 =?utf-8?B?MXdVZlMweG80MTFESnNqUGllaU1LNm0wTGx5dzFpdEl4WGw1VmhGWEo2WGVY?=
 =?utf-8?B?ZHdXaGdXVnFmVGxWRmg3dUtTb1JGeENvd1psenpUbUN3a2tvaHVEWjIxeFlH?=
 =?utf-8?B?RmJ3QzFKNlpTc09HNURsOHliRHVBS3o0WkJrVU1oVElvRjVYeExnRGNLQ3F6?=
 =?utf-8?B?S3pNZzJYN3o2bFVLZmo3aDBoSWF1b0lRQlJOZU5HUUREaEh2VWV6eHo4ZDdy?=
 =?utf-8?B?RFFBUEwvUU05MC83Y2YwcFZ1QVB3ZVppK3huTUlTMVN3dTlUQmJvSlVqZ0pZ?=
 =?utf-8?B?SFRrUHlWKzA2M1p4MkpqMk0vSlhmbDJ0d2YrQ3ZVOTBKdThLOCt3NGlBQTdP?=
 =?utf-8?B?VFhzTDJ3MUY1TVlkQTlVNG5iVEJkYkFROFVvbEZkODBncExtcnk5NWhyM28z?=
 =?utf-8?B?VXBVY0NyakRPa0RlWGN3WFFES3o3OWpFSElBcVQxYml6WVMvc2F4alNDU1hl?=
 =?utf-8?B?Z202N2xvekhOZ2FIeUEwU0JRcVpmc3EzSklqYnNqcHNxclJCdFlKRTZQRG9r?=
 =?utf-8?B?VXNuOXQrUkNGdXFpZmlCWmM0ZFZGUWRJTEttQ0NjQWxaWC9OZjJFOTJUZ3pZ?=
 =?utf-8?B?RGpweFNXN3FNQkJPWDdFcHpPM0QwMnRhTlNkYjdQRldYTWxPdnl2R3pNckg1?=
 =?utf-8?B?M09Wd2ZnaGgxK2xZaThlUTdNRFZ4eFpCMDlMQUVSRUFwdndNV25JdTJLSU9I?=
 =?utf-8?B?bzBRRE1HZjFmUkJFdzhjQnJqQWJRWU92WFhMWlhZZFNBRlVPQ0lPMHhOZWtV?=
 =?utf-8?B?SUlBRzJUYm1ZVXN6SE1SSHpuT2ZnTkFxWTBOUVVmcC9yVVJIZzlEeDRmWjVG?=
 =?utf-8?B?QTBvMWp4QjFUUTRLUXMxeGNsTC96UVNWZ2lNNGsrQkZnaDZISlBCTmFDZzZQ?=
 =?utf-8?B?WW9PalMrN3VKdnRiK0FvY3lSNHk3SDhxbkkxVXNVdGZiL0NFbFppdCtiQlM3?=
 =?utf-8?B?WnBEcUE2RGFYcW5YOXdvSVBzK09wZE04aUVCdXBaSUIvdlhzdEN3OUlrNEc0?=
 =?utf-8?B?Q3dpUzQyNFp1bWJuTVNEdXF3N0t0Sk5VdFd3S3crT0EyTGpEVnAxQUZ6VmRK?=
 =?utf-8?B?RUxjQ0RZSjhYR01ZMFFPODZ2cFB3TGxFcTlGVFhpWHFvRHRtWUNuM3gzMllO?=
 =?utf-8?B?L09ENnZpVERMU2diRXBQOEVqdGNxN2RyYlRTazFaTnY5aUpkQUtEc1h2TWJu?=
 =?utf-8?B?U0lVTmw2dFNQdjQ2YURoZWhTNDhQdHNtWWxJbEpOeExaVmVXZjZnSG1EL2kw?=
 =?utf-8?B?ak9lWXZNY3N5dFZvVE5aSi9zTUtFOXlGUXFndjNHUmlMRGt2dWlnUFNYeFFq?=
 =?utf-8?B?TkxQbmRjZS9JUXBhWWRsVW9wbVFyY1BJbFNoRWNLcG1uZDJveDduWDNYZHFa?=
 =?utf-8?B?SzRWaU9BeEx2NFJVR0c4bVA3T21zaGtwdDRTczNOSEpRQmFBWTR3M1A2b3Zj?=
 =?utf-8?B?UXVZQjhva0taUklVbkE3VXVnNDE0Sys5TzBJd3Jvb3hLSHl4WnRFcFpIZTMr?=
 =?utf-8?B?emlCWm5uYWQ0KzR5M3BxUTUrRDlaMzhXTU9VQlJCY2d0SUxpY2pldFVoR1dl?=
 =?utf-8?B?dFdVT2Mra1o2M0RDUzArYUd0RmRWdkFyQXpiNXp1OGVQWE4zU3FMcmp6OFpP?=
 =?utf-8?B?Mmc1MW1rWnV1dlloNDVxYW9kSDdGb0xpUW5UYzZzVVY2VFRHMWR6amlFZlNa?=
 =?utf-8?B?d3p4QzM0enNxcEhXdUlGOTRpb1VJbEZ4YitFQ1pmSmtPTGZrOGduQzZUSkt2?=
 =?utf-8?B?YUR6NFBrb1BmZlVMUkdINzBxaWJFZVpRWEkydi9Kb0tyZWEwUXk5UjdEaCtY?=
 =?utf-8?Q?uOtLbDO6Xlud3AL2GojWkzQ7E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046874f0-155c-49b1-974f-08ddce0fae03
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 19:48:09.7518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/RAtan7YYUEY3Ce7nmMkQnGXIHdNh97HCeHwmc84Oj0BHvS68PVuZ3dVE8NrqVe11kkYrk2afwRDbssSb0ZWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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

On 2025-07-24 22:43, Zhu Lingshan wrote:
> This commit introduces a new id field for
> struct kfd process, which helps identify
> a kfd process among multiple contexts that
> all belong to a single user space program.
>
> The sysfs entry of a secondary kfd process
> is placed under the sysfs entry folder of
> its primary kfd process.
>
> The naming format of the sysfs entry of a secondary
> kfd process is "context_%u" where %u is the process id.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 82 +++++++++++++++++++++++-
>   2 files changed, 85 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index de701d72aa5c..a6e12c705734 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -995,6 +995,9 @@ struct kfd_process {
>   	/* Tracks debug per-vmid request for debug flags */
>   	u32 dbg_flags;
>   
> +	/* kfd process id */
> +	u16 id;
> +
>   	atomic_t poison;
>   	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
>   	bool queues_paused;
> @@ -1009,6 +1012,9 @@ struct kfd_process {
>   
>   	/* indicating whether this is a primary kfd_process */
>   	bool primary;
> +
> +	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
> +	struct ida id_table;
>   };
>   
>   #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 440fde75d1e4..e1ba9015bb83 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
>   
>   DEFINE_SRCU(kfd_processes_srcu);
>   
> +#define KFD_PROCESS_ID_MIN 1
> +#define KFD_PROCESS_ID_WIDTH 16
> +
>   /* For process termination handling */
>   static struct workqueue_struct *kfd_process_wq;
>   
> @@ -827,6 +830,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
>   
>   int kfd_create_process_sysfs(struct kfd_process *process)
>   {
> +	struct kfd_process *primary_process;
>   	int ret;
>   
>   	if (process->kobj) {
> @@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>   		pr_warn("Creating procfs kobject failed");
>   		return -ENOMEM;
>   	}
> -	ret = kobject_init_and_add(process->kobj, &procfs_type,
> -				   procfs.kobj, "%d",
> -				   (int)process->lead_thread->pid);
> +
> +	if (process->primary)
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   procfs.kobj, "%d",
> +					   (int)process->lead_thread->pid);
> +	else {
> +		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +		if (!primary_process)
> +			return -EFAULT;

EFAULT means "Bad address". A better error code would be ESRCH "No such 
process".


> +
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   primary_process->kobj, "context_%u",
> +					   process->id);
> +		kfd_unref_process(primary_process);
> +	}
> +
>   	if (ret) {
>   		pr_warn("Creating procfs pid directory failed");
>   		kobject_put(process->kobj);
> @@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>   	return 0;
>   }
>   
> +static int kfd_process_alloc_id(struct kfd_process *process)
> +{
> +	u16 ret;
> +	struct kfd_process *primary_process;
> +
> +	if (process->primary) {
> +		process->id = 0;
> +
> +		return 0;
> +	}
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return -EFAULT;

ESRCH


> +
> +	ret = ida_alloc_range(&primary_process->id_table, KFD_PROCESS_ID_MIN,
> +	     1 << (KFD_PROCESS_ID_WIDTH - 1), GFP_KERNEL);

Did you mean (1 << KFD_PROCESS_ID_WIDTH) - 1? That would give you the 
range from 1 to 0xffff, which is what I'd expect with 16-bit wide ID.


> +	if (ret < 0)
> +		return ret;

You're leaking a process reference here.


> +
> +	process->id = ret;
> +
> +	kfd_unref_process(primary_process);
> +
> +	return 0;
> +}
> +
> +static void kfd_process_free_id(struct kfd_process *process)
> +{
> +	struct kfd_process *primary_process;
> +
> +	if (process->primary)
> +		return;
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return;
> +
> +	ida_free(&primary_process->id_table, process->id);
> +
> +	kfd_unref_process(primary_process);
> +
> +	return;

This return statement is unnecessary.


> +}
> +
>   struct kfd_process *kfd_create_process(struct task_struct *thread)
>   {
>   	struct kfd_process *process;
> @@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	if (ef)
>   		dma_fence_signal(ef);
>   
> +	if (!p->primary)
> +		kfd_process_free_id(p);
> +	else
> +		ida_destroy(&p->id_table);
> +
>   	kfd_process_remove_sysfs(p);
>   	kfd_debugfs_remove_process(p);
>   
> @@ -1549,6 +1616,12 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>   	process->queues_paused = false;
>   	process->primary = primary;
>   
> +	err = kfd_process_alloc_id(process);
> +	if (err) {
> +		pr_err("Creating kfd process: failed to alloc an id\n");
> +		goto err_alloc_process;

That's the wrong label for cleanup. You'd end up leaking the process 
structure. You need to create a new label. See below.


> +	}
> +
>   	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
>   	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
>   	process->last_restore_timestamp = get_jiffies_64();
> @@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>   			goto err_register_notifier;
>   		}
>   		BUG_ON(mn != &process->mmu_notifier);
> +
> +		ida_init(&process->id_table);
>   	}
>   
>   	kfd_unref_process(process);
> @@ -1619,6 +1694,7 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>   err_process_pqm_init:
>   	kfd_event_free_process(process);
>   err_event_init:
> +	kfd_process_free_id(process);

You should add a new label here

err_alloc_id:

Regards,
   Felix


>   	mutex_destroy(&process->mutex);
>   	kfree(process);
>   err_alloc_process:
