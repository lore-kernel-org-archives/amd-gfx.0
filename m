Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C5BF31E24
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 15:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C156810E81B;
	Thu,  9 Apr 2026 15:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxoLWLNw";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011024.outbound.protection.outlook.com
 [40.93.194.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC18810E81B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 15:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD6oIa8u5DUnJzEMlCmfMfQYSfCzUYS5QhdFK9xrvdpkM9cmRoO7oLo/9Lb/mjjHDoBIMRPby2u0nHXR8v6nXP/d5M0OOM+GawX6boeMQiEDcAB9K2eeYcLgMcVTDWcbro5OW7g3JReF4fkJUdixMrVHFcMm3ETIcg2ZUtYKCvGekB8NP/+dctV0MCegjvb/gbM9dE5teVhGtZvgqil9VstnorwyWkUUHU97NzQNcHRkq3tH6lvy4lB9VeM0o9nFl4g9seqzxooQb5IbObMGnIPolPYjOVODP3FxJXKIKR7CdRif7U/6c/ZfBkA9ChzHGEs/m/q6Sydi51itvEOYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIqNF+XNnT59i6YdidJbcOp1gleg0Lvmze/mP/VES/g=;
 b=NKaKxaxmivRFBp6NxwPrdTEYvCI88BymBIMcDcWQA/PQ3lhNhawwTp0eh+QemTjxUBTQLfaU/ORSU3bdu9wQJpeHMEPqQ2McPMSlD47PtlYMWvE/5pLYofw69PDW2aR4piKFL4EG1RE67R1DhvrtId+KRVOWxxWbTQKovikMCsK54KokVxbY828QToM1X2EaZcqnzEqO7EkoQ9eTr0OWHqvcgm4VWW35o1ANPhx89lMr5sxTStaZvwzd7Li9jB6Nb2xpxU8uxX8RvtkH8h07Lop2aUR37JJpNMloRdDXU9v3Fzhob0dag95URiKaFuaRVq6NQDH0XvKmtP5JPhzG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIqNF+XNnT59i6YdidJbcOp1gleg0Lvmze/mP/VES/g=;
 b=zxoLWLNwpznPTa6BexKJgRubqBcmMB15Hg4CEyOQWKivRStO3lW6zW57wrr3R1fLrpn7SPxdNwpf8Qhv6ZWcw/3qyvEcKO9TJX31IWNR1A0vHP0tOxXJ3qygBkvNozric4G3cyKCH1uOJMgWmVBvIq+HQP8w+Z0gw3WUtPjzt7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 15:12:48 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 15:12:48 +0000
Message-ID: <e58bd7e1-e35a-4227-91be-ee3285c981fa@amd.com>
Date: Thu, 9 Apr 2026 09:12:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Add missing do_mccs parameter
 description
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
References: <20260409014148.2282920-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260409014148.2282920-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::9) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d36d69-7d92-4a3d-c984-08de964a7599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ZQT53pQKDsG4chrRok4Uno3n8BvdW5SwSJekQQ37FCFW9BguczsyKd1/swNJNBu5aFneYRSsUUO+n1wqMEc9thY0ZSpCn0AP5CiFSYmN9uRD3Hp77wiOriRUiZGSCmjhuKRfHl7i3xUvyWbFeu2X3sHd5koNoR5iTPRd7UbaNNVvlac+sZrgLBpAlIqvHmjDxJWa/U2X25oK3wi7kZJUf7MeUiyUxreSud6ZEs25gyEsbnIBTRaouOB36tnAhdp7VrYLVmhv4CUeqF2A0qM5cU1PggAA/YhObEvX5u1Dc3JUIS+uycK3IVoEwDX9fXvO+A+T6Eu2/7czMxyusMVoHBnx641UQdaLDN9SUSD92GzkzoKQRWwk+6BG/tusvVsn97jkmiFg2I5kWyB3ryC6iGfKcSSjCzUHU5gWP3c4lSsoPhtZjSC7nZyFXx5eznqf1DE4t2ouyZ1vzGRB2M4BdGax0SbzSkayfV2U0LHqOkR7SYvax3uuVysEalpAGbeiwD6d5MD4OHDT6j+qfKgbbCvQEhlShmXqV9jIUUv2PrG9oP/6JHoQ5ETwR8IRsTaGBCQ3OCFMxydOW8VrItjdtUBrY+nAHorsYYzVZTmU8ucfkB2NyObu61e9p/hqKn/6S7xmeroTwuJUdolFmWoNrwY6HV1OaY54y0WjLTSvNL8zMxoLzbxLj3XEfF0rpbQuFgUn9nrcRKN/D/2kGO74zxCyNp+sGMYrEcOPc3X5CLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUxkWkhMbG9lZmFPK3ZDbHlBeHltY0U5UzlnSkNiVXpuclFDbjI0R1dGV0Vj?=
 =?utf-8?B?bE9DcGJqRHJ1d2NabE1MaEROcWtReTV5N1JXMUlqZ2VSQ1RPNmNUTGhQSm00?=
 =?utf-8?B?cHlTNjJyVHRuM2R6Uk5MWXNKc1MzZmF1M2p4V3R3Yng1R2FqU3p0QUJjZWNW?=
 =?utf-8?B?ZEZWNjZRV3NFQTljQ3cxSVNKNExvV0FWcjdCNXFVNUJSTmtob3VXeWNDK3lp?=
 =?utf-8?B?dVNTT2t4Z25pTStvK1IrOEhoTE05NEtyK29ndHFqaktNcDVYaFhjWkxpeUdp?=
 =?utf-8?B?Y2p0VFBMVlJRSGZ5emE4NUx5MXdqUzZaeXd2WnIyMEZHQUhNZUhwTWhkWVcy?=
 =?utf-8?B?RDhrNkhuUW1vR3l6NHB3Qk9oTWYvMGkzL1pyTHhwNEpLQnNHRngwQ0ZSUC8z?=
 =?utf-8?B?SE01UnhxUnRJL3hWUXVEdEFqVi83d3RpZGovVUV6UzFrZnNvKy95Tm1UeVhJ?=
 =?utf-8?B?Yi9TQkN1SHljdVE5cTZLbVY0dTRwNldBdUduaXV3bjhZSXJmWUhKdEJDdS9z?=
 =?utf-8?B?bkJxZDNMQnY3bTBhL05oaWtlb2NUeXhOYUhXcmJqVmhDMlVwMnhqR2h4amRJ?=
 =?utf-8?B?OUhuUWlyRCsvbGxUTVEyU2p5dHliREZjTkxWVUowdkE0Z0llaWYyOXFPRFVY?=
 =?utf-8?B?bzBVVDJIRHE4eXRSWm14U3JLMkk2c1VPWkZlZXZmbElvQ0szUUNEMDU5anBD?=
 =?utf-8?B?TnlXWlBXOEhOd1p0bkdXbTJCcWZqRVl2U3ViQUdKRVFPWVdnRGZZcHUxU01W?=
 =?utf-8?B?bWVKQ2RGd2FNc2Y3VWhhN3BvbkhZQ2ZYOUNCRUJoeHAxM2djOWtTT095U29Z?=
 =?utf-8?B?Ri8rSFMrUWdML2dYWFd1K1FUbVVPaks5OEpCelJUeFArbGR1Y0Uvc0lGUlNv?=
 =?utf-8?B?VTVNZnBPRElkcVorZEZKKzRiT2JPZGtPUDBoTTJXaGs1NVR2KytpL0N0R2RI?=
 =?utf-8?B?TGtkNVVBWHViOVRYYUR3Nm1QOVVQWWd6ellOVWdhRy92WldXSWsvL0xGOVBT?=
 =?utf-8?B?ZVR0eTN3VEk5V0lUWVh4b20rMTN3UE90N1hLeXBVd3V2OXkxOWU0KzhCWk5q?=
 =?utf-8?B?VEd6SEQ1VTYzL2w1Vm1rU0luVnYrYlNhekluaklrN1B0eUUyOXN4dGRZdExG?=
 =?utf-8?B?c1kzUjN3Ty9pOTl4bDlYeVJtZDlrYTIxcTdoQTZtdldHbmVKanhjdTV6WTgx?=
 =?utf-8?B?aVdRY0tPeHZZLzhPZDc2eVZIOW41eHJ6SDdyVHBsZUk0WnlzcDcyakkvcXVS?=
 =?utf-8?B?RUYzRUQxVlRMcWhDT3lDWDM1SmdLOVRvVUNYYUtyQ05EVis5TXhnZkh6Nk9N?=
 =?utf-8?B?Yy9kN1dsajNLM291NThieTNLa3VhYko5eDRXOTZ2M0xzck13aVhRRGNSdWtw?=
 =?utf-8?B?V2JicTNPRm5uaFYxMnFldDJNV01EYy9hSndhaVgrbnh4SzVKYytvbFdtbUdS?=
 =?utf-8?B?cXEwd05zTlZDbVl6ajRZYUxSaHJYOCtkMDFscTVsRmMvTUpmcmV5UUtNbGFF?=
 =?utf-8?B?WnRwUlExSDY5aEl4SWN4K29yWVVKZ2FYNXgwMFBJejVQSExTaEw0Y2VrVEZ3?=
 =?utf-8?B?enBueEtEVHZVV2FrZEMyRHpUZjRrK0RtT2JDLzE2T1g3VktlNlRicFZRdDhP?=
 =?utf-8?B?R25jc0dEakF2bzZ0bkFrZmt6WTk4OXpYbDhTWE9OcWRyajVXNElROWxzNkYy?=
 =?utf-8?B?LzVjTWxBZFJNN3hTdm5NdjhjV2RGb05lSXJOMCsxYTE4U2VQZVQwQVIwaFpR?=
 =?utf-8?B?NmpqUVZYTmE1dzM0Z256YnBiUU1kOUtncnE2eXpUcnVKdVhxSmZxZnhJWmZ5?=
 =?utf-8?B?cmg3L2w2ZXc3Wlo2VytIbWRLLzdxMWQwZWhjTksxRHh6cnJ3UGZzbnk2dXdN?=
 =?utf-8?B?MFdBeGxLc2ptaGtZQkd4WDcwMnM4L1lTVDl0Q2xxaVhNNnMvdDQ0WkR3QlRH?=
 =?utf-8?B?SWx0RU5qKzJycm1ETEcxcXliWk9TRmE2aFgwa25YZlBnTU1xaWpyVnRMSnA4?=
 =?utf-8?B?bk1xeVcxWnoxN3dnb1duOHgyUkliZi92TEJNYzVRaEV6bEdDSXBQNDE1L21T?=
 =?utf-8?B?N0lybEJFUU5sMVpBUVF3WHBaQy9icXJMa2hSWWxvNkwxQ3F1L3BvaGJpUlMz?=
 =?utf-8?B?b3psWkUrSXdha3lmUnNuR3lvT3l6b3FRb0RxbGpkUzFqMXVqUHhtOEdDQWhU?=
 =?utf-8?B?bXZyNnFKYS8ydERSdkF2ODlJM0JZSGlTQk12K0FvMGFJY0VPTE94TGxZNmNh?=
 =?utf-8?B?UDgrQnV4aU83eXVWVHN1ZjN5c3kzbURia3ltbkF5ODY2M2ZYS2ltMzBSMnM2?=
 =?utf-8?B?L21JNUVUTFlIRjNuWWJnTCtHQ2tpWVIwZ3VjQU1EblBvM1J2TG42UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d36d69-7d92-4a3d-c984-08de964a7599
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:12:47.9725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6pb31cu6LYX7H86ylIZ/rFH5nst5JIQ7jSV4F/IOoQuKRFwHDr6RzNAYEuv2D/oWr66yZ645FxByJLcAnLaTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 4/8/26 19:41, Srinivasan Shanmugam wrote:
> Add missing description for do_mccs parameter in
> amdgpu_dm_update_freesync_caps.
> 
> Fixes the below with gcc W=1:
> ../display/amdgpu_dm/amdgpu_dm.c:13269 function parameter 'do_mccs' not described in 'amdgpu_dm_update_freesync_caps'
> 
> Fixes: 980a8981351a ("drm/amd/display: Avoid to do MCCS transaction if unnecessary")
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bac02ea15b8a..77ef24ca8b26 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -13259,6 +13259,10 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>    *
>    * @connector: Connector to query.
>    * @drm_edid: DRM EDID from monitor
> + * @do_mccs: Controls whether MCCS (Monitor Control Command Set) over
> + *	      DDC (Display Data Channel) transactions are performed. When true,
> + *	      the driver queries the monitor to get or update additional FreeSync
> + *	      capability information. When false, these transactions are skipped.
>    *
>    * Amdgpu supports Freesync in DP and HDMI displays, and it is required to keep
>    * track of some of the display information in the internal data struct used by

