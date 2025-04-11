Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D3EC369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E9A10EC11;
	Fri, 11 Apr 2025 16:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qfkiNBeV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B288F10EC11
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFGhZkf3WOLaaGWITrYckQ71jMGyINPoTFiHYK+ymwAel6tanI2xeMayTzt+YI85wITgLRA68d6XnFicXCLC2jMp5rzgBVHXpNQiYa3OlAqznGpVzazPe70xWqAfcWuQWeX0zyuM1AweRgpVd7FPAsCgzjq7bLoA5zeT7ApocVD3kWfIAF1BX/5CjBi0hrK3yJLO3pXk59/Pu1XZS9xou016RJU3PBpSMQhnn2t5d273f6LYkVSREkF/g4ab9d7mVfP27bDujloPTTRokk5n/ZTOcQr6O5K41HHyiwvoc37z3M7GImG7/1YsvbE6yptjya2DysIq+k7PJjtGIunsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L+3Qaw1FBRtkuf9923YXlafgK73IJiuiunvVm6Pl8c=;
 b=Th4oONcibFgmqoke0Xu8JOr3XSp+/nXnJXb4FoqY1skGHAAvDVPtVAYbKW46CicZhirJXPkbeXFh91Iljjjx6R/sgp7efmoHgX7gJJ9SmCwmYBlhx1OvlmrCxmdfFt58Mkg/eFm+DF/u7JsL7WZS2wAka0qDkeTT8ZEmF90RMctS6LOFOK28I+vVSvSnn6AcHqGOtzLPvZGUv+eqrIZalzcnebXxSzvJQriQjLWx/qAqAJiMiJKUsJWXNLA+XSgTU0Xq/m1T4Ny5XcGZwcQJpWLu5+DfRDcWZBLlrpMzM4XJzGTgYsU+4PIiFsQuQaiwVaB3mwMKQciC9duL9fTGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+L+3Qaw1FBRtkuf9923YXlafgK73IJiuiunvVm6Pl8c=;
 b=qfkiNBeVs/azcm6vM4Esd8jgAS9rAINtSK8TlEM1RnZrxpaZcyv5AeFHUzIJssH6MV+CTkN9ObX8YLOhKcxuY9gpsBmCaBZ7wLH4aCSakapQp6jPzuT5U6b9NUKWDIZktpTv8M3KbIOK4/C+dxNWYVvbiVlLZ9KVOfnVYM7QdTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 16:06:09 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 16:06:08 +0000
Content-Type: multipart/alternative;
 boundary="------------VyfGJDILPSPRcfVcsgIbYZba"
Message-ID: <a3166af5-5848-41b0-93d9-3ee2035951a5@amd.com>
Date: Fri, 11 Apr 2025 21:36:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] drm/amdgpu/userq: handle system suspend and resume
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
 <20250411141228.2722962-6-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250411141228.2722962-6-alexander.deucher@amd.com>
X-ClientProxiedBy: PN4PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 665f6517-0553-424b-043b-08dd7912c525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnNCd1QwaGtkTVhRcHBQdkJqejk1dlZ1TVh6ZXVTSXdDMUdKaGFyaFE5czZt?=
 =?utf-8?B?N1h2dW9LNWY2Tnp0cmg4cWNSQ0hJZmgyYUxtWU9td3Y4OWVQU005NUZERnRS?=
 =?utf-8?B?alkweTlFYStxcDFiamFPNlRSdTNzZWlYR1I5ZytsOXUwZG45a1orR0xzbHJm?=
 =?utf-8?B?K1ZvLy9acG12c3I5eU8wYjlONW9xdmhjNW9MVWltbTdtQTcvU1VPZzIvbmJx?=
 =?utf-8?B?cFBZMGhlZkNkSHFkMkw4K3pxUXhlNHpSWFVhcWVXdi9WSDltblVJL0Jrblg2?=
 =?utf-8?B?WmRESXh3STM1WVRzSmk1OStLdUljMWk2VDJ3TnJhUWV2MjYvR0o4OHFUWmh2?=
 =?utf-8?B?dEpjeVBMekVCdU1wQXMrZG1xVTNvWWo1UVk4am1BbzNwTEw0MkxzNWxXRGht?=
 =?utf-8?B?Q053OGRBOFZlT1p1cW9SV3h1N2dJQU5BT2lpT1VUaUF1RENUYTBNd3AzY0Uy?=
 =?utf-8?B?WFd3czJGSHZuK0VyYXlZVDBjV1pGZE91eUpPRXE5SzFPTTVpV0dtMjVaS1VT?=
 =?utf-8?B?dzhwc3FNTXdrZVFoUnhsbXdUVndVV0tsZ2dqbktpdEQ2aDZscnJYU2pnR3dJ?=
 =?utf-8?B?WnVIOWRacndWeHJjQUFVaTd5TVZGYjh2Z2lhWFRFVDM4Q1NldjlvTm9sRkVU?=
 =?utf-8?B?NlpiZittSllpcmRWeDQ4cUdDQllZeVdjeVg4bWxuMEdvU3kvdkNwTGJuYjk5?=
 =?utf-8?B?dDhHZi9lbHBBakY5RlhHcS9Da0ZsSDVKZ2lhVjR0TDFXczJDRkszRzJHMUZt?=
 =?utf-8?B?TytDWlRkdUNncjMvTUJ6TU5RU2c4UlBCVkJiTUJKSEx2elBremJ1K0dZOWkz?=
 =?utf-8?B?QlhEdUdLZTY4b1NSN1BGd3hBcTIwUVBOZW1pSEFLbjJ1OFM2RDZkWkxGZTc5?=
 =?utf-8?B?cHZXM1RkK1c1THNTNXo4OGRxTHA2emFoWlFmc2E1aHYvaVJyc3JWU1R1azdl?=
 =?utf-8?B?YnZZQjJCYjdrcVRkeEhBSnRqOXJFNnFhSmxnVXZwRUdUcFRmSGdyM0FqaXQz?=
 =?utf-8?B?SGtlZnZoOGZSOUpHdGlBZzY2Wmx1eEdrcktMcjAvSFIyaCsyczZkUzhwQzJM?=
 =?utf-8?B?US95OUNLb3VUWjl1S2h4VDcyYklWQlJXTGdqTGNwM3lnNlEyNTVjd2gwcTEy?=
 =?utf-8?B?Vk1lZDhiUVFwdHZPNHQ5RjEyZEp2N1dHRnJ1U2doTFVwQ1hXUDVsTnBpRW1v?=
 =?utf-8?B?VUQrZG1IWVI1QzJ4b3dJWkZOV2ljU2xwNituT21wTXVMYTY2TmVaV0V0SExm?=
 =?utf-8?B?Zld1SlY3bUR2aTFJeGxuRkhjWlUzOEJ4a2grdWRUNlB6S0g5ekFoVCs4b0l5?=
 =?utf-8?B?R2JLZ3k1V2dDbGh1ZklPanZiZEhGTjR0WU1teW53UUo4TDlPZGtDbkpDU2pu?=
 =?utf-8?B?b2ZNZ2pmeW1SUTNSQUQ0bEtocVhVdk1FSjE1Q3JsSElQeU51ZTZPUmlHaGxx?=
 =?utf-8?B?N0ZxcmRWaHBhVm5wU2tBV3pTYVFnMjFOMzg1RTdXQW5wbVhyN280OFBQaFM0?=
 =?utf-8?B?RmViaEdjTDBoT0NxaU5lVlFBdUxWd0pHVktNamkvY0huZldKc3FMbFVrdUxv?=
 =?utf-8?B?RHBYRER6S0lNL1lDajQvdzhvUC9WVXgzSEpzUTBJTllKdkppU1o5TVlOQUhC?=
 =?utf-8?B?em11TnAyMXZ5WWdNMXVXbS9PeXRNRlFGcTIyTkVxM3UrRk1keFZxaHZLOTlL?=
 =?utf-8?B?YUd5S0RPUEkzcHBXM2J3YzJPbGwrK25WZFNlUkhtcUhIekFURFJkS1BjTnhR?=
 =?utf-8?B?Z2V1RUsvclZtUzJHbGpMbm8yYVRJMytrS2JyQlYyWGl0U1ZzMlVKVTNHWXZ5?=
 =?utf-8?B?TCtlRDUrdkxjR21vZ2JhZWhOQjdYZEd5VU9RVDBmMjJ6akozdkJLVXVJNVdq?=
 =?utf-8?B?ZXJsV2crSjBuV1p3aEllMmhsZWNYR0hCc2s5OVRZYUFwQWNPYzlub1V1dU9w?=
 =?utf-8?Q?a0+DOEkjBC8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkRxUlJiSWxvN2hWVm1hOUYydzZSU2g2OTh6MklDNjdJWElLdXZhbzI5RWZl?=
 =?utf-8?B?cEprd1lQQWlocFFBT0xMUm1SL2JZa0NScmhJWWxqR25zRU1CU0xEWWE3UnBG?=
 =?utf-8?B?RHdUc3N3QUNhVHpWUUpUa1U2aUNUSE5sSnUvRU1FalQyajhMT01VM0VQQ0l5?=
 =?utf-8?B?c1JwT1JXNEtTM2xpTjBQa25nUVpLaEtGRHFJYXJ0NHFVLytXNk5xTUh1Z3hm?=
 =?utf-8?B?OWN2MjZacUNpUjN0dThxamJ4SUdIeG1VUWdRejZqVjVPZWI5ZFhNcU01R2Zy?=
 =?utf-8?B?UHY5WGk2bVExa0hSN2pQKzVQYi8wWXl0aGdtNWZKa2lxL3NTb21kWnBpWStP?=
 =?utf-8?B?NDFoQ1c5ZWNyanpxcUJCQ0VZNFB1L2Nab0RCY1hDWVFXMXJ3OGVKOFBVdDhX?=
 =?utf-8?B?Y3FoWEhCc01hWHNJU0ZkbEhIZndiTHlSLzZ4bE03WEZkNWYrbzlQa3kwbWdT?=
 =?utf-8?B?bVZEUElYWndFV09Icng0S2JmTUdacWVSVktlWDkzQUt3blZqYkFsZlg2OCtu?=
 =?utf-8?B?OHE1bTFrRnRZbGtNZ0lIR2Erb0lBcHltdHZjenlrRDltSUFmRHpsUytJSFRk?=
 =?utf-8?B?Y3IyWVVRWVNKVnNrRFZiN3d0YWMzcUhGOStNZmp6Y1I2RW4zMWNCQ3NzUVd1?=
 =?utf-8?B?d3FKQlVaUHhkYUg5ODdtZzJ4YTdZN1czNWJtR2pYcFdxdExteG5OVWhnbksv?=
 =?utf-8?B?NWF2aU5FZnl4elhuOVhmSlRRUFkwTFUvS3F5N1ZVc2xucjJiYkRqQUhBQmxV?=
 =?utf-8?B?SzlOTnlKWUhQVElieGJqdXJDQ2FxSEVnSEpscTZSRGZlWlhnZXVkNEkrKzBo?=
 =?utf-8?B?THlFUXdOczNLeVB4M3NZdFg3cDFaK2loWmpyckVIY0ZPdGQ3TVJoTkgvaTIx?=
 =?utf-8?B?L25CSjRLeXN0bExNVU1DMFBPT1JyeFdMYmxSVEduMFlBSm54WWxsektIWDZY?=
 =?utf-8?B?NGUwczVldDlHbVd6ckw4c2lwMlZocmpYbUk1a1BkUHpXeTNzNktsQTFqZ05R?=
 =?utf-8?B?WmNlazY5TEQ3c0UyZGNxSGx5Y2dtTDM3SHlLSHhzYkNQYnVkSzhEamRZK3Q5?=
 =?utf-8?B?M3UwY2VxTkMyVmplaEhFOUd2WDhIUmIwNHdBK0xienFlbFRUeC9UbGdERVgz?=
 =?utf-8?B?cjljSC9jZFZEeWp6NEZjZkhLaFQrQnlQMkFXamw1QWV6a0s4V0pWbWdSSDE5?=
 =?utf-8?B?NVpHcVh6bVRlN3RreGJIMFNkUWpFV1VBU3ErOE5jZTVpTUxSRzVvVEZtbURk?=
 =?utf-8?B?YS9MSzZ4K01kRThKN05oeDdlcm9VbEp5emNicEtCMG9wVFFWT3hPY1VrbmYz?=
 =?utf-8?B?UW1rNDM3SThLeG5SampTNUlaWDhWKzZqd0NrNjhlalRZeDhwZ3d3M0U2bzFp?=
 =?utf-8?B?ZzRqL2ZkVXpybVVjQ0ZsdnZvRGo0cExvbWY2aHpwQklPenFKcDJsc2MzR2g3?=
 =?utf-8?B?eU82dFoxK3F4cVRTcEJGQ0N5dHpCZHRkRUR2QUdrcy9SM2x6UVFYMmZUcjdH?=
 =?utf-8?B?aDk4ODQvWXBLVzcvcGlrK25BTTVDQ0xscmNMRU5DSlhkbUlwZERVRG9NMktq?=
 =?utf-8?B?anNQMnJMRnVQUHJQZlVtdkRLdmd2a2JKM0RpZkZMSVZWeFdYMHhmSkh0dUFm?=
 =?utf-8?B?WWVPYTdPSEliMUVWQXBKZVd3NkxSRU1yYmJVQzJKOWh6WWNSR0N5UCsxTUpO?=
 =?utf-8?B?aG05TlU3dDVlZFBVN2kzN0JONjFWTnZLV3pTT3dvcDdNRGhrQm4wWEhvaEtP?=
 =?utf-8?B?UCtOOWVqbS8ydTNzREZmUWRtbExydVRCNW5RcEhlSytIKzQzVDVLTFA3N2NW?=
 =?utf-8?B?NllTRWY0UVh3ODZjNlMxZXRtWW90T25PVC9Fd3BaeW1TcHF1UWhPc0o0MEsz?=
 =?utf-8?B?Rm8zcHFxZGZobzhGUlRRQnhaSmY1bkJ6ZE1Qbk8rQ2tjcFcycG5YaEQwZXo0?=
 =?utf-8?B?YWFxUmVQYkEzZEtmdHFtbDlDTUNwaUpna1BzLytsWit3WXlId25PbVZqemdZ?=
 =?utf-8?B?ZWgwQnR0SzNURE1oa1picEZRMFdENmZRMzhGVjk2MjNyV2htTVd6TzY5ZkY3?=
 =?utf-8?B?Z0s1dTIyam1rdUFKLzg3bVUxTDE2eVFCZ2w3SGVXRXdiVHRZU1k2ZG15eTNO?=
 =?utf-8?Q?qmfdxUnI0jPJDxUBg/8y12u+e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665f6517-0553-424b-043b-08dd7912c525
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:06:08.4409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJrOI8EooOb3EIxlNRC05XJ4/JFBcRd3G/kY5X51W79NWc4z4o7ZRiN2KogTskIWwKX3+es+MUUl0+sF+mlPQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
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

--------------VyfGJDILPSPRcfVcsgIbYZba
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 7:42 PM, Alex Deucher wrote:
> Unmap user queues on suspend and map them on resume.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f212ce3f5d34a..e7398e70d6795 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3507,6 +3507,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>   
>   	amdgpu_amdkfd_suspend(adev, false);
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +	amdgpu_userq_suspend(adev);
> +#endif
>   
>   	/* Workaround for ASICs need to disable SMC first */
>   	amdgpu_device_smu_fini_early(adev);
> @@ -5075,8 +5078,12 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>   
>   	amdgpu_device_ip_suspend_phase1(adev);
>   
> -	if (!adev->in_s0ix)
> +	if (!adev->in_s0ix) {
>   		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +		amdgpu_userq_suspend(adev);
> +#endif
> +	}
>   
>   	r = amdgpu_device_evict_resources(adev);
>   	if (r)
> @@ -5143,6 +5150,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>   		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
>   		if (r)
>   			goto exit;
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +		r = amdgpu_userq_resume(adev);
> +		if (r)
> +			goto exit;
> +#endif
>   	}
>   
>   	r = amdgpu_device_ip_late_init(adev);
--------------VyfGJDILPSPRcfVcsgIbYZba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Reviewed-by:
      Sunil
      Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></p>
    <div class="moz-cite-prefix">On 4/11/2025 7:42 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250411141228.2722962-6-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Unmap user queues on suspend and map them on resume.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f212ce3f5d34a..e7398e70d6795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3507,6 +3507,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	amdgpu_amdkfd_suspend(adev, false);
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+	amdgpu_userq_suspend(adev);
+#endif
 
 	/* Workaround for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
@@ -5075,8 +5078,12 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev-&gt;in_s0ix)
+	if (!adev-&gt;in_s0ix) {
 		amdgpu_amdkfd_suspend(adev, adev-&gt;in_runpm);
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		amdgpu_userq_suspend(adev);
+#endif
+	}
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
@@ -5143,6 +5150,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		r = amdgpu_amdkfd_resume(adev, adev-&gt;in_runpm);
 		if (r)
 			goto exit;
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		r = amdgpu_userq_resume(adev);
+		if (r)
+			goto exit;
+#endif
 	}
 
 	r = amdgpu_device_ip_late_init(adev);
</pre>
    </blockquote>
  </body>
</html>

--------------VyfGJDILPSPRcfVcsgIbYZba--
