Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7E4D3E783
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 02:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4325E10E072;
	Thu, 11 Dec 2025 02:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="APkFD46r";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F0010E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 02:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voQ5cxzDwrerQ/85XnMz88VNNa7AHIwv86G/iJ6caEQ3+e2Yyw94euEHiEec08qIaEuAlOh0E51V1DNJSKY28a34swPzamIbOg81A2+rbBWosA81L1DT14sPjrTfPEuPyDqS5HnQ3F0e5XojpmKUwEg2bDjcnPIGj7USVDtkFgB6GAfWzdkdzpjCb0aYRWvGCaTSzOSeM8V90lX89ZYQtjcn5V0Egb383cWEyVKlTdjG5TAL0cZH/KyUkq+I13nRyhn+YoDFwpwJJVpbBZCpjD+gfMbpd9qTGe8FX/qLZ4EIvLT4GvWtP7QkWxXswmDDpAStUvc3EFLH8LXgwSCl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qX8bpLZ1KbuRKCkFlaYgDYuSuYGaT/ow8DvM/4q7QUg=;
 b=Q+C5QbCo1Z9d86fZA8yq5Tib0vwaE0orWwzzGBcEJIIJUK6bNLRtL2CcOg/IhRf6qlCBIhzxLwjuI2RxQD2svyrnFkxRrkDV7J//6MqQ8oyrpJrxw4YJDZP6UMAkuyxi8i4H/1vMrdLKfUXjk1WANQ9UbbdaxeG6k3Adjuw5BFBtFPHAthPUSwFQB2aROuNc+FLXpF7koFqep5YD+wOVkYMiMO8345SmO9RXAjma7R0Q0T0rBwWXV72udVFSKToc//8yA0BJjweaYqWwhsJe+ac4FrWIMO8PDXDizvANerKpRHhXGJHw8X1U3qpcaeWavLQ1xkX/G8L0HUjHKAfF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qX8bpLZ1KbuRKCkFlaYgDYuSuYGaT/ow8DvM/4q7QUg=;
 b=APkFD46rPbdkiaNiFpRHF3/qLvPU3tHyzWWBGjDcmV+JQ5yy6gat2vaPtg5RIHmDC1zglNkonS0d/a9OdgbBAhts3nOjjqtUQ5NHDULtB98quskfQ0Ss3OgIjVw0H1vNCPRjMmtxe09iSZ7CTm33ZJnsOSgDoG147+k1kjNI21k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 02:19:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 02:19:38 +0000
Message-ID: <03db9561-f7e4-4157-95b3-7d32bdafe15f@amd.com>
Date: Wed, 10 Dec 2025 20:19:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMU warning during isp suspend-resume
To: "Nirujogi, Pratap" <pnirujog@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com,
 Gjorgji Rosikopulos <grosikop@amd.com>
References: <20251210015140.568540-1-pratap.nirujogi@amd.com>
 <db479aed-d96d-414c-88f2-a699accf24f8@amd.com>
 <2aa0eb5d-6097-43eb-bb18-4fc7d793256c@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2aa0eb5d-6097-43eb-bb18-4fc7d793256c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 9941068c-a6b7-4faa-bdef-08de385bbc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWhEQ0JvQ3Q4aXpBNlh6TGRWRUhxYWVnOTVBaVp2K01mTEovY2hmRkg2TERh?=
 =?utf-8?B?UWhPMXJDbTRSdkpXOUM4UitVQXYvSFBtbkwyblVrM0U4SWNnMXBnUDRoNmNq?=
 =?utf-8?B?UStzd0Jxd0pRMzZkbmNxRGFlbVNLODU0bnF2ZVg1MmNIWDJ5dU02VFNyOW1V?=
 =?utf-8?B?RDRXYzhJa2I3WXkwZHJ1UDd2N2ZLV0xvOWxjY1RPQmpSNTJPT0FhUDlBY0tG?=
 =?utf-8?B?RSt4UkxBRFNBUU83UkdlcjR1QmRCUXVYRWlGZUY3SDlIbnliTWtObEdSS2tv?=
 =?utf-8?B?NFBPeDZtY281YnZyNzVIajR0R2JITlh3Q2Y3ZHpKYzc0K0hzRlpZNGdkcUNx?=
 =?utf-8?B?ZGx4N2UzWjdRL09RNlFNOFhTZlJNb1VhK0lxemMvN3JmSjd6ZFhWajcxWGhw?=
 =?utf-8?B?SG1zdEZkWFBmK2xGRVZPZkZBTUxzL0xKYUh1eUxHcnhzWGkyZEN6WTVyZTBW?=
 =?utf-8?B?aklRblZESnI5Yy9LcnlkdC9RVjlTTmo2bTZyRU9TWGxwZ2NBeWpCekxMRlEw?=
 =?utf-8?B?OWdQd0pkWER4K05WYUwwcUlDOU1RZ2g0OEErUWY4UWNKdlF1b2Y2Uzlaa1lk?=
 =?utf-8?B?VmRzUXRwNU5RaURDQ3FpR01yaXNTVHpjQXlRQXFuVkVPQ2E1bEp3aHVZRGhJ?=
 =?utf-8?B?VEZGSlFEM05hdEpoSXRRVUd0U0xlQ3ZqaWFGUnR6Ly9LU08xRHFKOXhCWExM?=
 =?utf-8?B?bTZFQU5jeUJNUU15VW5qMit4b1MxNVlvcEtXd3NEUi9Fa3lyOHMzOUJIbmxR?=
 =?utf-8?B?K3psaGJBVWpxMURxQ0JxeVM4MVJpOW9tYUFkT2RTYmM5T0svVFBsTVZhNkJq?=
 =?utf-8?B?UURIQlNETmV3c3puMEVoaHRMcjlJWnlYbWpzcGpTK2t3Zm90RHpyYnlTaFZa?=
 =?utf-8?B?RVA4SDM0eWQ4aUVPSXgyU2NNc0ZLRElKTmVtV0ZJOGgyaExOdVVPUDZ0Yi8y?=
 =?utf-8?B?ZlBvb3hZaS9oTTJxV253eHRhSGFLNWVCWnlxSU5rc0tPTkR3NW9Rd1F0Mm9N?=
 =?utf-8?B?WTMxVWZDM1hkeFlFZnRtSEUvclpEYU9xYUdPYzh4aHRKRmdaaDZkZUhEVmRF?=
 =?utf-8?B?OG40aWlNdlBQL282bWVobUhYcGRYMnVTTkY2eG9hSUU1dVY3SHdGZ1lNa2Nq?=
 =?utf-8?B?REljb0kwRkRpV1ZiYnE2UWRiOVFQTkVQWFdMZkJXaFhhK1U2TzFGRjFkMGlP?=
 =?utf-8?B?WFNTbG0vdWtzZVRSZ0o0bURvOFB2Ym1IOHY2c0RRS2tkV3ExeDRCNGcrWnRM?=
 =?utf-8?B?Nm5PZmtrU0hnaG8vV0k2L1QweXkvRUwyVTY5bm94M2J2OVpITy9nY0RML2FU?=
 =?utf-8?B?OGRpdGMwd1FPYmxIQytORGdBWjIvN2JpZ05lNnF2WmFWaGZmNnZ2c05EOVp2?=
 =?utf-8?B?Nmc5ZzEzZVYydW9scXRibVB3dFh1THB5MjdtME5sOUxLNjh0NjMrcUJxdTZW?=
 =?utf-8?B?eGJiU25zbnJCc042OVQrOXE4V0JhcXJvazRHems1T3RlQnQ4RzZFT1JnczJ4?=
 =?utf-8?B?dCtNVkt3RFM1Z2wweXZqSk9WWEExZ3hXWVdtOVorTzl6OTlzbHdCekE3V21S?=
 =?utf-8?B?WHpGR0RwbldPalZoKzhXRUlVVDFHVTg5RHZzRTJMTDhlZXd4UWJhZmZCNERT?=
 =?utf-8?B?Z3JnZlZXTGx4eHBOTktVK09VOWs3dFBoVWQxc1pWbzY5c3YxREM4cXZPRFZz?=
 =?utf-8?B?clh3Z1RLeWp1MzFyS2Q2TnE5WFNBZGpTWUFNSWd2UUx5SGM4Y0NzbkNhYmlG?=
 =?utf-8?B?VENBOGY2ZUlweHRuQ2twTldjNmdPT1hhSitUazB6aXJHenJBazlBQUtYYjYr?=
 =?utf-8?B?SnpCRDVUUnFSditsSnhOc1hYSytnbFUzSEE2cVZJdm42WE4xamRDZVE0cGdq?=
 =?utf-8?B?M3ZEWDlzN3F4WDR5d21NZS9yYWg5L1cvZWtqblhFLy9yWWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azI0cDBoQmJHTmU0MkkxVWMvS0FFM29sMUJyYTFBSTVRZEtxbzhaankvY0Rp?=
 =?utf-8?B?WVRnWXdkeGRycVJVeEhCWVU0Z2s3c0VKeHpsZm1YS0hxLzUrOENmSmpUTlli?=
 =?utf-8?B?S0RVMVh4dWRnQ0F2bm4wZTMrSDY5MFlXb01QczViZjZBME41cElSWVZ2OEpI?=
 =?utf-8?B?RjFmdHdxRWxIb1dKQTEwby9NZVV2WjFIQlBkQm1HNnBSYnZpbHJsSDY2NWxk?=
 =?utf-8?B?dGxmRzRmeUIvaHFOeDhFYVllV01KZUJhSWVEbHovNit2SUdBYktmb0pVNU1S?=
 =?utf-8?B?UVJsa2I4M0VFcVNhczFIZ1RscEp3MHdEeGNWck95d3VoemNiUEV5dkx1T2ZM?=
 =?utf-8?B?YzUySnUzWWtmV3NJeWpHU2tsYWl6dURmT0cwYXNXKzRTenFyc0ZYMVdGRC9h?=
 =?utf-8?B?ZjdubWZlS1UzM0pPWHZlWmFuVzUwOVZ5UlVteUNvTm5jKzNyakhxUG41cjhY?=
 =?utf-8?B?SjE4TDVLMEJaUnFPbHJnRzhQNlNOd1gvdU5JVjg3bEpOR2REN016S0NlMDhk?=
 =?utf-8?B?c1hRNWpKS2U3SWVLdHBuazBzQzFFbnc1VW5wQUpMZy9wMytzL25nYW5lNFhk?=
 =?utf-8?B?SnliRkc3dmpBZ2hsckw0bUdUOU5QV3FySzdFVkgycWIwWWdESUxiNU5EU2tx?=
 =?utf-8?B?NVd0dW1oVVVlNVpPV3g1N1djZ1FESkw2TFEvbC9pcUVJT042QUljTk4xQ1Ey?=
 =?utf-8?B?T1VOT09GZS8wODVPUTZ3M0lUZTZ3MmdzbTRPd3BEeXBORElNNHdLdjM0ait0?=
 =?utf-8?B?cWpPZHY4K1djZzAzRFJQb2YydGp5eDZWSUR3dzZ1V25nOGlSbitnSjlmcjFK?=
 =?utf-8?B?aXVhSHhKODBaSWVrcU03Z0h1c3REbWVDVW5ZZTE4WUltSDhuMEErSVhMVjRV?=
 =?utf-8?B?eHNtVkxnRWM1L25mNE13TkVZbDcvUmhxeURlbUNJZ3dYbEg3NXFSVTRBMXk2?=
 =?utf-8?B?d3ZDcmk0TEpuZTg4eU5qbXI0YXpwSGFwYWUyeDJHaXhrcDgrWHNLTzV6OUNy?=
 =?utf-8?B?b3JWN3hLU3UzZWRkc3ZwR0x3ZS8vTDJGY2I4cEJubUtSRFNzQjBnYlBaWml3?=
 =?utf-8?B?NmxuZ1YyeEZCKzloUVlUc1hPZmF1WnhuUFVsOFRHRDRnVDh6Q3dIeTZrd0dt?=
 =?utf-8?B?ekp2NmxkNnAvanFKKzVZdldPdnJBLytGVlVHWUFidTl1YWdZRW9KVHNMa1F1?=
 =?utf-8?B?em1lV3doQlNUdmg0L2h5SkpOU3hOZEFDcmw3ZTNNZWV4YlZMaXRQazFRcnd1?=
 =?utf-8?B?Ukg1SnpHemsza09NMlJHRnFwOU1vc1hKNEZMamJJSFFBeGJXNWZOK0htVmxy?=
 =?utf-8?B?Z3lsdC84ZkJYNSt5dUkvejBEOE9oQ2J2OEtvZHE0eXEwZy8rMGNSSktacE53?=
 =?utf-8?B?OXBqWnVuZldiUFBqL0F4VUtneXhSYjhsaWxieVVXZkpaK296T3FlWVpGa1F0?=
 =?utf-8?B?MlZ4TFRMUXVDQUo0WkdIbW1yMnRLYjlOMWZyMEJnRW5sYWs5dDFpNVdhOVN6?=
 =?utf-8?B?ZnRQUEg2K2FlK1hjTFA2U2pCK2QxNTNrUTNKNWxXdkkwUHpXM3dIMW1uZnJE?=
 =?utf-8?B?VkJURm1pSlFJeXA3WTRSYWFnKzBqQjBVbGtRd0wwQm55aHYra0YyQ3hNNldh?=
 =?utf-8?B?dFJrUkYyQUxwYk9SV1pWYjI3U2J5NFpObTdDSHNCcVBRcHlHSGRGbUgvVnV4?=
 =?utf-8?B?MHJLYVRycGh1Y0NoU3dhVTlmL2lQclpBSERnZ2dxVm9ONk8wVWRPZFQ5SDhS?=
 =?utf-8?B?RVBDSHRWSW1uejJ6NHBDdnJGb3lFYVYyRWxKZXBUb1VhVGtWMG9xUSs3WWUz?=
 =?utf-8?B?VkFvY21yeDJKaFF1SVAyOWRSQ3JUcnJ5cjB5M1hoSUpnSTZyaGxWekZrWW96?=
 =?utf-8?B?S282QzZHQ3NPRHdsWHhmK1NzY0RKSXg0emUxeXh4R2hFbG5naXhUOFdkdy93?=
 =?utf-8?B?ZnhnbWRDaXllaFhvNVFIQ2g1YzU0eWU1MFdCSFp6NVFHa0NJamJ2bFRIbmJL?=
 =?utf-8?B?MURiaWZDT2kyS1QyTWgrazVZVmFLbVRXd1RwTFFNQld5RllHUGNqeWExR0F3?=
 =?utf-8?B?TVBSWHNFc3pBN2hWL1YyK1ptRDJEV0x3WUVqbDJqd0xacXpyRmRLQUkzTmU2?=
 =?utf-8?Q?ldHEJez5Ob5b8DO5XVjbHLZnT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9941068c-a6b7-4faa-bdef-08de385bbc32
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 02:19:38.5877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUAxGW3Go8xnr0cwydp7IEba1YwaxTks3TiWzv/vqn7zMQhYtoHdX3/SEcd1fhwtSr33nb8Xg4gPLUCZxObAPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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



On 12/10/2025 5:13 PM, Nirujogi, Pratap wrote:
> Hi Mario,
> 
> On 12/9/2025 10:28 PM, Mario Limonciello wrote:
>>
>>
>> On 12/9/2025 7:50 PM, Pratap Nirujogi wrote:
>>> ISP mfd child devices are using genpd and the system suspend-resume
>>> operations between genpd and amdgpu parent device which uses only
>>> runtime suspend-resume are not in sync.
>>>
>>> Linux power manager during suspend-resume resuming the genpd devices
>>> earlier than the amdgpu parent device. This is resulting in the below
>>> warning as SMU is in suspended state when genpd attempts to resume ISP.
>>>
>>> WARNING: CPU: 13 PID: 5435 at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/ 
>>> amdgpu_smu.c:398 smu_dpm_set_power_gate+0x36f/0x380 [amdgpu]
>>>
>>> To fix this warning isp suspend-resume is handled as part of amdgpu
>>> parent device suspend-resume instead of genpd sequence. Each ISP MFD
>>> child device is marked as dev_pm_syscore_device to skip genpd
>>> suspend-resume and use pm_runtime_force api's to suspend-resume
>>> the devices when callbacks from amdgpu are received.
>>>
>>> Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
>>> Signed-off-by: Bin Du <bin.du@amd.com>
>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>
>> Who is the patch author?  If you guys worked together, there should be 
>> Co-developed-by tags to represent it.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 ++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 +
>>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 59 +++++++++++++++++++++++++
>>>   3 files changed, 85 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_isp.c
>>> index 37270c4dab8d..532f83d783d1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>> @@ -318,12 +318,36 @@ void isp_kernel_buffer_free(void **buf_obj, u64 
>>> *gpu_addr, void **cpu_addr)
>>>   }
>>>   EXPORT_SYMBOL(isp_kernel_buffer_free);
>>>   +static int isp_resume(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>> +    struct amdgpu_isp *isp = &adev->isp;
>>> +
>>> +    if (isp->funcs->hw_resume)
>>> +        return isp->funcs->hw_resume(isp);
>>> +
>>> +    return -ENODEV;
>>> +}
>>> +
>>> +static int isp_suspend(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>> +    struct amdgpu_isp *isp = &adev->isp;
>>> +
>>> +    if (isp->funcs->hw_suspend)
>>> +        return isp->funcs->hw_suspend(isp);
>>> +
>>> +    return -ENODEV;
>>> +}
>>> +
>>>   static const struct amd_ip_funcs isp_ip_funcs = {
>>>       .name = "isp_ip",
>>>       .early_init = isp_early_init,
>>>       .hw_init = isp_hw_init,
>>>       .hw_fini = isp_hw_fini,
>>>       .is_idle = isp_is_idle,
>>> +    .suspend = isp_suspend,
>>> +    .resume = isp_resume,
>>>       .set_clockgating_state = isp_set_clockgating_state,
>>>       .set_powergating_state = isp_set_powergating_state,
>>>   };
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_isp.h
>>> index d6f4ffa4c97c..9a5d2b1dff9e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>>> @@ -38,6 +38,8 @@ struct amdgpu_isp;
>>>   struct isp_funcs {
>>>       int (*hw_init)(struct amdgpu_isp *isp);
>>>       int (*hw_fini)(struct amdgpu_isp *isp);
>>> +    int (*hw_suspend)(struct amdgpu_isp *isp);
>>> +    int (*hw_resume)(struct amdgpu_isp *isp);
>>>   };
>>>     struct amdgpu_isp {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/isp_v4_1_1.c
>>> index 4258d3e0b706..560c398e14fc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>> @@ -26,6 +26,7 @@
>>>    */
>>>     #include <linux/gpio/machine.h>
>>> +#include <linux/pm_runtime.h>
>>>   #include "amdgpu.h"
>>>   #include "isp_v4_1_1.h"
>>>   @@ -145,6 +146,9 @@ static int isp_genpd_add_device(struct device 
>>> *dev, void *data)
>>>           return -ENODEV;
>>>       }
>>>   +    /* The devcies will be managed by the pm ops from the parent */
>>
>> devices
>>
>>> +    dev_pm_syscore_device(dev, true);
>>> +
>>>   exit:
>>>       /* Continue to add */
>>>       return 0;
>>> @@ -177,12 +181,65 @@ static int isp_genpd_remove_device(struct 
>>> device *dev, void *data)
>>>           drm_err(&adev->ddev, "Failed to remove dev from genpd 
>>> %d\n", ret);
>>>           return -ENODEV;
>>>       }
>>> +    dev_pm_syscore_device(dev, false);
>>>     exit:
>>>       /* Continue to remove */
>>>       return 0;
>>>   }
>>>   +static int isp_suspend_device(struct device *dev, void *data)
>>> +{
>>> +    struct platform_device *pdev = container_of(dev, struct 
>>> platform_device, dev);
>>> +
>>> +    if (!dev->type || !dev->type->name)
>>> +        return 0;
>>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>>> +        return 0;
>>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>>> +        return 0;
>>
>> Could we store the mfd_cell pointer instead and just compare the 
>> pointers?
> 
> I don't think I can do a pointer comparision to identify the correct 
> mfd_cell, string comparision seems like required in this case.
> 
> Its because when isp mfd child devices are created using 
> mfd_add_hotplug_devices(), it is not returning the pdev or mfd_cell handles
> to store in the amdgpu_isp and later use in suspend/resume to compare 
> with incoming pdev->mfd_cell to detect the correct the device.
> 
> The mfd-core is doing a kmemdup of mfd_cells data passed to 
> mfd_add_hotplug_devices() to create the platform device.
> 
> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L163
> 
> I'm considering to add this function to check for valid isp mfd child 
> devices that are allowed to do suspend-resume, this can minimize the 
> checks, but still cannot eliminate the string comparsion, please let us 
> know your thoughts.

Well actually is a check needed at all?

isp_v4_1_1_hw_suspend() calls device_for_each_child(isp->parent) which 
is a platform device.  Are there other children below that platform device?

The platform device was made explicitly for this purpose wasn't it?  So 
maybe drop the check overall?

> 
> static bool is_valid_mfd_device(struct platform_device *pdev)
> {
>      const struct mfd_cell *mc = mfd_get_cell(pdev);
>      if (!mc)
>          return false;
>      if (!strncmp(mc->name, "amdisp-pinctrl", 14))
>          return false;
>      return true;
> }
> 
> Thanks,
> 
> Pratap
> 
>>
>>> +
>>> +    return pm_runtime_force_suspend(dev);
>>> +}
>>> +
>>> +static int isp_resume_device(struct device *dev, void *data)
>>> +{
>>> +    struct platform_device *pdev = container_of(dev, struct 
>>> platform_device, dev);
>>> +
>>> +    if (!dev->type || !dev->type->name)
>>> +        return 0;
>>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>>> +        return 0;
>>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>>> +        return 0;
>>
>> same comment as above
>>
>>> +
>>> +    return pm_runtime_force_resume(dev);
>>> +}
>>> +
>>> +static int isp_v4_1_1_hw_suspend(struct amdgpu_isp *isp)
>>> +{
>>> +    int r;
>>> +
>>> +    r = device_for_each_child(isp->parent, NULL,
>>> +                  isp_suspend_device);
>>> +    if (r)
>>> +        dev_err(isp->parent, "failed to suspend hw devices (%d)\n", r);
>>> +
>>> +    return 0;
>>
>> Shouldn't you return r?
>>
>>> +}
>>> +
>>> +static int isp_v4_1_1_hw_resume(struct amdgpu_isp *isp)
>>> +{
>>> +    int r;
>>> +
>>> +    r = device_for_each_child(isp->parent, NULL,
>>> +                  isp_resume_device);
>>> +    if (r)
>>> +        dev_err(isp->parent, "failed to resume hw device (%d)\n", r);
>>> +
>>> +    return 0;
>>
>> Shouldn't you return r?
>>
>>> +}
>>> +
>>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>>   {
>>>       const struct software_node *amd_camera_node, *isp4_node;
>>> @@ -369,6 +426,8 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp 
>>> *isp)
>>>   static const struct isp_funcs isp_v4_1_1_funcs = {
>>>       .hw_init = isp_v4_1_1_hw_init,
>>>       .hw_fini = isp_v4_1_1_hw_fini,
>>> +    .hw_suspend = isp_v4_1_1_hw_suspend,
>>> +    .hw_resume = isp_v4_1_1_hw_resume,
>>>   };
>>>     void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
>>

