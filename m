Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26305C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 09:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A8610E98B;
	Fri, 27 Jun 2025 09:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EOKaWFpa";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A3810E98B
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 09:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEt3HvSWgLCMrH3mpdoivzkKKaqxAuNd4mNjUX1Yj4kV8VPDZStKr5t+1VrYjD1/lYpYb3oG77r+Zh87h51q6vnJID0O9voE0SAKQKoLFKtUfVOBR1qlp3XIuV7CG5Ubu3jd3VRzvCfH1mnowqQMU2IxKiwINg6Eg8ajaDRKm+s0tmXsyL5cLCYT+Z9/W31te1pHPUBBQ/TfdDbXlyEHwQ3RxuRe2ypfeXOeVkuiEVnsG9j2l4mzaPb3gMkdEfhv6JgVP7bO9Q6/+enXOvyUjQNghOuTsDu0iTGDEGEyI9TdOX3gQpQrIyXFbslbqLja3rhIpX5oXrVNgyTLFoOjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5usTZAeXzEwU/g4eIpQj4PaE25UJwP56i1FUayWjZs=;
 b=Bga5jLnyNncWQH49L3mLfswFd9jttREiIzFl/j7nOUwtMK+sMU0jHf4/6W45jGtfONTNxHUSQ85ef7bdMudzrf8/T6vVJgdnIHedfEKYFLNqGnb9Vx3/8yUvzFDS+2l8h89CD4JrFC/+sG8ZyNhOnvc7nkf00c1JOzzoPKBeZLxTxWi+j2KQQ6Iif6ORtAGW5Pjjkc64cjNi4wtxkih4p8kH1s31LjPKtgNw2EANPFF5+a4Y1Q1XWbPr+QQ1u1/EF1ZHib25uMDlgjqnw9jBgSXQbE2rUMJyasdATC8oV+wqoyWLUKUBYOD6n7HVYblqEfYOEdGw+oHOzcTvNM/3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5usTZAeXzEwU/g4eIpQj4PaE25UJwP56i1FUayWjZs=;
 b=EOKaWFpaduU8TFNmavppNsbj8lIhsOgMz31e7s2jHXiEqOANjbhnC0VubfDZDu1GLq7kWWnJKj1vqe1abJA7taPZJo085HGKIzfFYkan5uBYTi8uOws437H5bPrtLvj4dN5EBoJJsSliT+Nm4CsTje0JHdwbwpRYHZiV9Of8v2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 09:05:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 09:05:24 +0000
Message-ID: <f115ae1c-c838-48d9-abc4-01e1fe01baa5@amd.com>
Date: Fri, 27 Jun 2025 14:35:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amd: Change kv-dpm DRM_*() macros to drm_*()
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>
References: <20250626023855.4026084-1-superm1@kernel.org>
 <20250626023855.4026084-3-superm1@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250626023855.4026084-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b1dfd1-7254-4fda-9178-08ddb559c031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFkrL1BkdE1WcXZtSUYyYXduRTVQSW80akVPS3RUa1ZVREZiSXhUcGpWcmRM?=
 =?utf-8?B?dG45bysrY3UvK2UzZ21FRzVVR0VsVXMrSnczZTRKWVVFdThJZC9kN0dLUzBX?=
 =?utf-8?B?a01MOHN2djV5YWswYUVWemxXMzN3NjJoM2M2WkIza2NCZ3JrOVdPdXZ5MTlX?=
 =?utf-8?B?Q1FPUEo3Y2FrNzRleUJPVFBRNCszZEx5MWExaDJLWXQ1cHJGU2JNblkweEZk?=
 =?utf-8?B?LzZSa0IyaVZZNmJrUFJsOVVBemN5cFUwUmhPVXZCVEZRa05pa3pvRjJrYzlH?=
 =?utf-8?B?dU9KS25ka1hzYng4Y3ZDSzlIak91TUJKaHAyVGNSQkJjMi80TE0xdGJiN2ZI?=
 =?utf-8?B?TE9obURvSHJyK0htS0Vka2d4eFVQMFl4NVVqWWM4dW92UUR5eDNLWnlUeUM0?=
 =?utf-8?B?R0l1dWxlb1dIa3JhRzdmWjhxRFdxZ0JvY0ZlZ0tVZE5mK3lzUDNCalRPbEFH?=
 =?utf-8?B?RWV5VHdOVDl4TC81R1pjN1ZmbUxWcWcyR0pGMGM2RFd2R1hPTjNsVFRjYXgv?=
 =?utf-8?B?OWxrekh6dExHMXl5VmVkQUZxVjV3dHVlM3NsTk1JK2VvMjlCL1g3YU9Td3Rl?=
 =?utf-8?B?ZFlpNFJ3NHFJWWp6UkFwZkV6WndsM01uUW9mZkNJM0lXNEZFclhYQnh3cUlI?=
 =?utf-8?B?QktacTN0WFU0ZTd5dHROYktDZmVibHBMT3gvaXJ1RER4K3V6UDlaWnF5Yits?=
 =?utf-8?B?SUxjYUszdjhNMXZDbTdIbWpjVS9CQU9kYjlhL0Q3Y0JCN2RJTStxTzhEOS9v?=
 =?utf-8?B?V1hQYldSMWJsYWdzVzFoamZlaGtnelNtVTI3REZ3SWZIdzBha0IvbmZZdWNG?=
 =?utf-8?B?UE1DbUxJR1FqN29uY2dOWndXeXdUMTd1UnQ5NWtNZnJ4RDdzMWtMYVVtb0h6?=
 =?utf-8?B?U1RMblcvajNlSG5oYjE4dFdvUnhxUUEzVGVoRTJYL2QxVEE1ZUl5RG1sZ09W?=
 =?utf-8?B?eXRYbG1QV1MwRkxDVWRoU1hvcWtyVGhtaHhQMjgvdUk2cHBrWWxQVGQwc1N2?=
 =?utf-8?B?Q3g5czJZTFB4ZEZrWFJEeFEvSmRXWHl4bmh6ZTdwSVBqTENkQnI0dGJyalVH?=
 =?utf-8?B?RHlqS1BYcStiQVJzK0UydTNyYk1rZGoxbDhRYWszUWEwUTEwbU42dWdndUpu?=
 =?utf-8?B?K1czQUZIaXUybXFvRTM5eTBRM3VCWkl0ZjJ4cUlzcHJkaGRmOE9hM1k3WG05?=
 =?utf-8?B?SStHZnlHamkxSmJTL2xXQlJFR0xKNWRLQTVyU1lKRythekQwSStPR0J0NGZQ?=
 =?utf-8?B?NUQxLzZpQlIwM29ERGViZS9NYis5WlR2NTJGMTUxc0dRbTJZWmhuOTVmOEdj?=
 =?utf-8?B?Yjk1L1lsU3p0VHE1RFNqOU5vL2VMdFozdnA5V1NGbXpyS0VvaXlzTEN0TGhv?=
 =?utf-8?B?aFovVUYzSVczeDdPZnJEUjNMNFJhRWxZMEFrNTBoNmFpUml0bkVxNXU1eU9D?=
 =?utf-8?B?SGFYaTFxR2Z0R3lzUFFJY2VwOGlMZWR1QTJGUXhzQmFTb1RHOC82bExnK0Zi?=
 =?utf-8?B?Y1N3NVdxZUR3eVdjc2RyMDZpRlhZc1RROVd5dUZDVGZneklRR3N4enlTdFF5?=
 =?utf-8?B?N0grYmUxcDFnYXNCdm9XNi8vVGc0emUxN2VPUktFTndMMTkxUlFaTzgwTklW?=
 =?utf-8?B?MTUzMXJ4dDVhY0hYZ3Z0dk1BTms3RHZqRDVZNXZxblBqTlNjLzJEM3Vtak1F?=
 =?utf-8?B?Q1JwZXg0WDRhM29VbExPYnhLNHlNQXYxNjZqQU1xd0llazhaekJCWG51V1Fr?=
 =?utf-8?B?SUdLZTJlOHFPbFR2eUUzekh4S1RKcVQrbnpkWXhiT09SUVFURHFEaUVXR3ps?=
 =?utf-8?B?TFBPTjdRY3JOcHU5d1ErNGhsRXFGditQS2RYUEpFSUJrc29wbUxBdHExRlk2?=
 =?utf-8?B?RWZhME9JYmFzaGh5aUlNTU9kRHQwaEpEaks4ejR0Njdac0ZjQy9wblhQaGps?=
 =?utf-8?Q?rBxhPJT5MTk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXZweHp0Yi9ObTBPdG9lUzJFa21ENTB2eWc2YUc4U0U3TDdGdStsQW5rUVIy?=
 =?utf-8?B?aE8ySEJDaDM1RE9ZNWpjNG5SUHNNRTFpNFM0VG44cWYrZHExOEx2bUkyK3FK?=
 =?utf-8?B?Y083RDE4RnlVdzFJcm5nZ3loVFlEN1VNY1hFU24wM0pIbkE5T29GTE5QdW10?=
 =?utf-8?B?cGdFTmxWQ0dmNHlCQ0lnUmdmYzY1RWx2T3VINDFaSHpzMitIWmVUbSsxWU5j?=
 =?utf-8?B?Zm4rN1NyeHo1bzNHNWhPbjF5ZVFzanhocEtKNXdpTlpOWmRjQktsZSsvR0VI?=
 =?utf-8?B?TDY4STMwY0tTZVpGd3ZHMWtxMXpOaFQ2Tzl2MnB3WVVsbEF1VHhvY2U4ZEc0?=
 =?utf-8?B?TDN5TzRWcHlhTHpFWnFwZk9iaCtuMXJtenhHeGJmM3dlVmhHZjBzQlNNWXg1?=
 =?utf-8?B?emExbDVneXo2TVBtajJlSFlNS0V1eGIySUZCazhaRHlzK01IajNWNU1hRDYw?=
 =?utf-8?B?a1BzTXAzY2UyM0JidGx0eEYwOTFCeHMwS3FqRWdLajJIYUtXOXliZFNaODBr?=
 =?utf-8?B?eXFOcHlsODVSUFgzZXNpZ0dxL0dEb21TMWttOVJ1UDZDb04wK0dMN0pSRWRN?=
 =?utf-8?B?NFQvVk1ocnlZMW9mL2UwRmpidGN2cVNOeFJ6RnVjRnJYdllDdWZlb1hDMEl2?=
 =?utf-8?B?cHVBNkoyci9DcWhTblNEZ09qdm9FTmNHbHlMeGpQVi9zNWNONXFYaVVtVWtW?=
 =?utf-8?B?citpQTdiNzFsTWlYN29yVHBRWlV3NFRlMjR0Vy9jNHB1U3B6TlZWMXdYS3F0?=
 =?utf-8?B?NDFRUzRVeW9mdmp0SzVPQXJlWk1xeS8yWnltcXVZMWlpVlpoTndRdGd1Uk9V?=
 =?utf-8?B?RmtDeVVBN1M5aCtLeU5hZDBaSGE3NytkaTlOZjIyZVlCRW41VnZoK0tRSHRh?=
 =?utf-8?B?UmY2Y0NvbHdUUy9XSFRhR0NwWjBYMms0ME13S29lUEN4SW4zWkVpdWZXbWMw?=
 =?utf-8?B?SDg0eWt5U3lBYmZpdlZYVlN0SWdwR2VlRnpWdm1yaDVxMmN2VDJlNm9nWWk1?=
 =?utf-8?B?OUZWUElKNjJCdU9GU0FDa1FyOFZnbmxUOForUXZGK204NHRjazhjTnBva3ow?=
 =?utf-8?B?eGhnSFFHNTZBNExGQ0pnSDMxVjNFd0wvT2VRZVpNUmh4aCticzRCS2w5bUZi?=
 =?utf-8?B?ZW40K3lnb2Q1YnZ3ektiZk5WTTdydWdJUWZzWGhLTFg0KzR2bkQxL2VDbjF0?=
 =?utf-8?B?dUdtK3ZLS1c1dUJSNVR4VnM2bXp1SDlyUVV2MVNrK3liYTU4V1ArVTE3SXBZ?=
 =?utf-8?B?cERUVnpZT1Rab3dtQm4wRkx2TytQM3huVUNOeGo2SHZiTm9KT0I5Zzc1Z1Bm?=
 =?utf-8?B?ZlBtRXBlMkJpK256WCtiOWs3OTBNT0N3WW92RjdFcEhsT3pMeUVDbEg5UGFD?=
 =?utf-8?B?bGZmVW9wL1h2L2tRcUdQNEJrTlI5M3lNZW05RlNYTEx5U2pOa3dteXFFd21q?=
 =?utf-8?B?OCtYVjU5cFo3M1BaT0ZiYm9FcUlKN0QrcWFiMXc2bkw5VUJEcUU4RjdFMUNh?=
 =?utf-8?B?OENhbjFNVnlxU3Zia2hVMnBpbUVxYUFDakxtR2FFRHB3ejg5MTZ3bWk5d0V0?=
 =?utf-8?B?ZnVKbFpOQkpPMEl6TGxPYlBKb2RrVHo4dURaOXJKRHVHVkNyL1gwalZGdWh3?=
 =?utf-8?B?TmduK1BsV092dlo2SFdYa0VORzgweHZ1clIxZDR3Zmk0eE9LR25UcU9pS0lN?=
 =?utf-8?B?RlZuWXZ3QlFucXhjQk44VWQ4WExqTGNlUFNPdXdnN2NlWXUwcFNBK0IyT1R1?=
 =?utf-8?B?ZmFtSzViV1RjYnZmYnlQVjlWSE1DZjJKWmQvV1p4dlZZbnBsS2ZDYXhlMHFW?=
 =?utf-8?B?QXY1MTBDeUw5NGxDcGx1WVhZRHRxNDZqb1gzSFo4OFlBOGVpZXVJd01nRjc4?=
 =?utf-8?B?ZmpYUWw2WlZYZUZwM04wMmw3c3RqZnNJUG9YWTRkQTFMVkxJTVhmNmhIVXhJ?=
 =?utf-8?B?aVRvU05HTjc4alFlQzdCelk3a1BpbFhMV3BmdmhOZDJIUFA5UWU0YnJuTTFw?=
 =?utf-8?B?anZjZDJZT0huUVlkR1lVdEM1ZVRuYlY3WFNNdk9WWVJDUThkV0lEbGp5eUg4?=
 =?utf-8?B?Mk5SZzhteHM5M3poSEZFTzEybkJQNXd1TVE2T29UMC9Jd20vc2J1Mk1ZUUhF?=
 =?utf-8?Q?hO4sZgvP386aYnUKBfnTTeMwf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b1dfd1-7254-4fda-9178-08ddb559c031
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 09:05:24.3579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPfL/Sc8lpIFWMPa0QeT/xQeBbVAAOuetZeGJGfYtKwj5SEzjUHBo2HiIHZnwM6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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



On 6/26/2025 8:08 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> drm_*() macros can show the device a message came from.
> 
> Cc: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patches 2/3 are -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 56 +++++++++++-----------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index 81a6134bd56de..1520b2db6d70a 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -1242,7 +1242,7 @@ static void kv_dpm_enable_bapm(void *handle, bool enable)
>  	if (pi->bapm_enable) {
>  		ret = amdgpu_kv_smc_bapm_enable(adev, enable);
>  		if (ret)
> -			DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
> +			drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
>  	}
>  }
>  
> @@ -1266,40 +1266,40 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
>  
>  	ret = kv_process_firmware_header(adev);
>  	if (ret) {
> -		DRM_ERROR("kv_process_firmware_header failed\n");
> +		drm_err(adev_to_drm(adev), "kv_process_firmware_header failed\n");
>  		return ret;
>  	}
>  	kv_init_fps_limits(adev);
>  	kv_init_graphics_levels(adev);
>  	ret = kv_program_bootup_state(adev);
>  	if (ret) {
> -		DRM_ERROR("kv_program_bootup_state failed\n");
> +		drm_err(adev_to_drm(adev), "kv_program_bootup_state failed\n");
>  		return ret;
>  	}
>  	kv_calculate_dfs_bypass_settings(adev);
>  	ret = kv_upload_dpm_settings(adev);
>  	if (ret) {
> -		DRM_ERROR("kv_upload_dpm_settings failed\n");
> +		drm_err(adev_to_drm(adev), "kv_upload_dpm_settings failed\n");
>  		return ret;
>  	}
>  	ret = kv_populate_uvd_table(adev);
>  	if (ret) {
> -		DRM_ERROR("kv_populate_uvd_table failed\n");
> +		drm_err(adev_to_drm(adev), "kv_populate_uvd_table failed\n");
>  		return ret;
>  	}
>  	ret = kv_populate_vce_table(adev);
>  	if (ret) {
> -		DRM_ERROR("kv_populate_vce_table failed\n");
> +		drm_err(adev_to_drm(adev), "kv_populate_vce_table failed\n");
>  		return ret;
>  	}
>  	ret = kv_populate_samu_table(adev);
>  	if (ret) {
> -		DRM_ERROR("kv_populate_samu_table failed\n");
> +		drm_err(adev_to_drm(adev), "kv_populate_samu_table failed\n");
>  		return ret;
>  	}
>  	ret = kv_populate_acp_table(adev);
>  	if (ret) {
> -		DRM_ERROR("kv_populate_acp_table failed\n");
> +		drm_err(adev_to_drm(adev), "kv_populate_acp_table failed\n");
>  		return ret;
>  	}
>  	kv_program_vc(adev);
> @@ -1310,39 +1310,39 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
>  	if (pi->enable_auto_thermal_throttling) {
>  		ret = kv_enable_auto_thermal_throttling(adev);
>  		if (ret) {
> -			DRM_ERROR("kv_enable_auto_thermal_throttling failed\n");
> +			drm_err(adev_to_drm(adev), "kv_enable_auto_thermal_throttling failed\n");
>  			return ret;
>  		}
>  	}
>  	ret = kv_enable_dpm_voltage_scaling(adev);
>  	if (ret) {
> -		DRM_ERROR("kv_enable_dpm_voltage_scaling failed\n");
> +		drm_err(adev_to_drm(adev), "kv_enable_dpm_voltage_scaling failed\n");
>  		return ret;
>  	}
>  	ret = kv_set_dpm_interval(adev);
>  	if (ret) {
> -		DRM_ERROR("kv_set_dpm_interval failed\n");
> +		drm_err(adev_to_drm(adev), "kv_set_dpm_interval failed\n");
>  		return ret;
>  	}
>  	ret = kv_set_dpm_boot_state(adev);
>  	if (ret) {
> -		DRM_ERROR("kv_set_dpm_boot_state failed\n");
> +		drm_err(adev_to_drm(adev), "kv_set_dpm_boot_state failed\n");
>  		return ret;
>  	}
>  	ret = kv_enable_ulv(adev, true);
>  	if (ret) {
> -		DRM_ERROR("kv_enable_ulv failed\n");
> +		drm_err(adev_to_drm(adev), "kv_enable_ulv failed\n");
>  		return ret;
>  	}
>  	kv_start_dpm(adev);
>  	ret = kv_enable_didt(adev, true);
>  	if (ret) {
> -		DRM_ERROR("kv_enable_didt failed\n");
> +		drm_err(adev_to_drm(adev), "kv_enable_didt failed\n");
>  		return ret;
>  	}
>  	ret = kv_enable_smc_cac(adev, true);
>  	if (ret) {
> -		DRM_ERROR("kv_enable_smc_cac failed\n");
> +		drm_err(adev_to_drm(adev), "kv_enable_smc_cac failed\n");
>  		return ret;
>  	}
>  
> @@ -1350,7 +1350,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
>  
>  	ret = amdgpu_kv_smc_bapm_enable(adev, false);
>  	if (ret) {
> -		DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
> +		drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
>  		return ret;
>  	}
>  
> @@ -1358,7 +1358,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
>  	    kv_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
>  		ret = kv_set_thermal_temperature_range(adev, KV_TEMP_RANGE_MIN, KV_TEMP_RANGE_MAX);
>  		if (ret) {
> -			DRM_ERROR("kv_set_thermal_temperature_range failed\n");
> +			drm_err(adev_to_drm(adev), "kv_set_thermal_temperature_range failed\n");
>  			return ret;
>  		}
>  		amdgpu_irq_get(adev, &adev->pm.dpm.thermal.irq,
> @@ -1382,7 +1382,7 @@ static void kv_dpm_disable(struct amdgpu_device *adev)
>  
>  	err = amdgpu_kv_smc_bapm_enable(adev, false);
>  	if (err)
> -		DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
> +		drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
>  
>  	if (adev->asic_type == CHIP_MULLINS)
>  		kv_enable_nb_dpm(adev, false);
> @@ -1920,7 +1920,7 @@ static int kv_dpm_set_power_state(void *handle)
>  	if (pi->bapm_enable) {
>  		ret = amdgpu_kv_smc_bapm_enable(adev, adev->pm.ac_power);
>  		if (ret) {
> -			DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
> +			drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
>  			return ret;
>  		}
>  	}
> @@ -1931,7 +1931,7 @@ static int kv_dpm_set_power_state(void *handle)
>  			kv_update_dfs_bypass_settings(adev, new_ps);
>  			ret = kv_calculate_ds_divider(adev);
>  			if (ret) {
> -				DRM_ERROR("kv_calculate_ds_divider failed\n");
> +				drm_err(adev_to_drm(adev), "kv_calculate_ds_divider failed\n");
>  				return ret;
>  			}
>  			kv_calculate_nbps_level_settings(adev);
> @@ -1947,7 +1947,7 @@ static int kv_dpm_set_power_state(void *handle)
>  
>  			ret = kv_update_vce_dpm(adev, new_ps, old_ps);
>  			if (ret) {
> -				DRM_ERROR("kv_update_vce_dpm failed\n");
> +				drm_err(adev_to_drm(adev), "kv_update_vce_dpm failed\n");
>  				return ret;
>  			}
>  			kv_update_sclk_t(adev);
> @@ -1960,7 +1960,7 @@ static int kv_dpm_set_power_state(void *handle)
>  			kv_update_dfs_bypass_settings(adev, new_ps);
>  			ret = kv_calculate_ds_divider(adev);
>  			if (ret) {
> -				DRM_ERROR("kv_calculate_ds_divider failed\n");
> +				drm_err(adev_to_drm(adev), "kv_calculate_ds_divider failed\n");
>  				return ret;
>  			}
>  			kv_calculate_nbps_level_settings(adev);
> @@ -1972,7 +1972,7 @@ static int kv_dpm_set_power_state(void *handle)
>  			kv_set_enabled_levels(adev);
>  			ret = kv_update_vce_dpm(adev, new_ps, old_ps);
>  			if (ret) {
> -				DRM_ERROR("kv_update_vce_dpm failed\n");
> +				drm_err(adev_to_drm(adev), "kv_update_vce_dpm failed\n");
>  				return ret;
>  			}
>  			kv_update_acp_boot_level(adev);
> @@ -2521,7 +2521,7 @@ static int kv_set_thermal_temperature_range(struct amdgpu_device *adev,
>  	if (high_temp > max_temp)
>  		high_temp = max_temp;
>  	if (high_temp < low_temp) {
> -		DRM_ERROR("invalid thermal range: %d - %d\n", low_temp, high_temp);
> +		drm_err(adev_to_drm(adev), "invalid thermal range: %d - %d\n", low_temp, high_temp);
>  		return -EINVAL;
>  	}
>  
> @@ -2563,7 +2563,7 @@ static int kv_parse_sys_info_table(struct amdgpu_device *adev)
>  					      data_offset);
>  
>  		if (crev != 8) {
> -			DRM_ERROR("Unsupported IGP table: %d %d\n", frev, crev);
> +			drm_err(adev_to_drm(adev), "Unsupported IGP table: %d %d\n", frev, crev);
>  			return -EINVAL;
>  		}
>  		pi->sys_info.bootup_sclk = le32_to_cpu(igp_info->info_8.ulBootUpEngineClock);
> @@ -2579,7 +2579,7 @@ static int kv_parse_sys_info_table(struct amdgpu_device *adev)
>  		else
>  			pi->sys_info.htc_hyst_lmt = igp_info->info_8.ucHtcHystLmt;
>  		if (pi->sys_info.htc_tmp_lmt <= pi->sys_info.htc_hyst_lmt) {
> -			DRM_ERROR("The htcTmpLmt should be larger than htcHystLmt.\n");
> +			drm_err(adev_to_drm(adev), "The htcTmpLmt should be larger than htcHystLmt.\n");
>  		}
>  
>  		if (le32_to_cpu(igp_info->info_8.ulSystemConfig) & (1 << 3))
> @@ -3015,13 +3015,13 @@ static int kv_dpm_sw_init(struct amdgpu_ip_block *ip_block)
>  	adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
>  	if (amdgpu_dpm == 1)
>  		amdgpu_pm_print_power_states(adev);
> -	DRM_INFO("amdgpu: dpm initialized\n");
> +	drm_info(adev_to_drm(adev), "dpm initialized\n");
>  
>  	return 0;
>  
>  dpm_failed:
>  	kv_dpm_fini(adev);
> -	DRM_ERROR("amdgpu: dpm initialization failed\n");
> +	drm_err(adev_to_drm(adev), "dpm initialization failed: %d\n", ret);
>  	return ret;
>  }
>  

