Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8638DCFA768
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 16:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124BD10E8E6;
	Fri, 21 Nov 2025 16:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iPBLrv8m";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A2510E8E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 16:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puW/MQPbx4FfarMq+uCv+9r0JU16V1J2p5ZLg+Bj3i6u+S5Mi3uI0XvHfe77wPkhY0UFRpMO2YrQcEk/t2KEm9wT3/25VAPmql7qJM9W6MU2fi5SSbOQ4tucPfT2FgU1Vse7jIB4qj/Qb9P5dY61donNJ1QSgCIlpkxF31rXWFWH/mLNysm+3lE0akKO/ooC4mSC7QUPJR82sxIjieTWk85p29YJ+8dLs09qh5C4oxCuWbKgdvpyme+kBmd1v1b3IEbdy3ZA0VbwsYd9dqfOTam/XubXX9tG7/sqCKwkaugWYgfF1ogUj4UkHuyX/ircKU1EajVxYtuha+6MFdLfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gGbYhfuBKBgwBRW4IqXTS5IkTxgGBy+oOKMJcFBPok=;
 b=ULOjaALmZL3Qo+FwRSpy718BOfJH6GOrSwBhLCQd0HOCwGjNwnQK/rF4kPsIsUG0TCB+zmsh3W2bTDUrIATDibMlyF5WK45U2ew6nlchR5pe5DULQX78dtWrtshUufBLU3wi9yliAbU+CvOhrv1YNoiCQBvz4o7qQygPIus3TBowA5/HyCLf2Ox6gsD9eV4j0QsMk35hGGpSm2+6kpxAae8BeKJRjfYapzsSV4tfj/J9mB6cFID4JqK4aIwm6fipgny/UmvFiO3F9G8fdnssfB7rXe1rfoBsf0tjdmVza3x1jecz83GOBAd/Ist2dRRUqSi2Wu6DgFqV1h6IzCpdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gGbYhfuBKBgwBRW4IqXTS5IkTxgGBy+oOKMJcFBPok=;
 b=iPBLrv8moaLQXlUEm9s+Dl4j5gQ+HVwZ7aMMtTWvjBOAMWRPjHHoxJrKl2KbCL3LhuhT3QLI1ksM+mo9rSyQibOz14lxv34IXNO46A02Wn+NMu1uEfQgaXDLyHyXx5+xGCKjoTUmlUsbhSaDwyjstURHyxQLZ15bgR9/H9/kcN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 16:43:35 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 16:43:35 +0000
Message-ID: <83b3894d-14e3-4505-9b94-c9dd905634c6@amd.com>
Date: Fri, 21 Nov 2025 09:43:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix dereference-before-check for dc_link
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Roman Li <roman.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
References: <20251121150247.181583-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20251121150247.181583-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea11a2c-adbf-4060-ee5d-08de291d1d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3BDR3ZTeVRkWUM4ODdzWFcyTERJNUMvVWtFZXV5czdGOXZwTWpsUkRvaWVk?=
 =?utf-8?B?M0RrNkFqdkJaKzRUTjFSSEl4Nno0dVRHL1hwYUdoZXBZNEdsYVJkUFk5NWJs?=
 =?utf-8?B?ZnhFQTFEcXNoaDRUNG9aK0NlV1BZNWpqaTF4TFFvNTRaZkZiZy9PeElCdTUw?=
 =?utf-8?B?bWFKTTJDM1pibTg0dlhFTVVtcHZqbW1iVm5yb28xbWJVMDFqQnQzV3JCWmxu?=
 =?utf-8?B?QUZjT1lKUjljYTFqbElvUjFOR3BjbTRxa1RHUlpHL3VheGRsbUtJbkdHdWNT?=
 =?utf-8?B?cndwTzl4bGV3WjA4anVteHQ3QjZ3cXRNek0wQURlRzV1NWFZZWVoYzkrMGFB?=
 =?utf-8?B?K0pGT0xDV3dxOXNCaGI4a2dmQlBnKzg5WHJJUjh3VjZKN2NUdHE2dWR1U0FE?=
 =?utf-8?B?WnBOVDF5bksxcWpxWEx4bU1NdjNYYTlMaDVyc0xiOURXTlYrNzB2aDVmRFBz?=
 =?utf-8?B?UHRmUlEweXBmK241ZmxKSG1sUWpjWEZOMjBQeEFnYUZmOGJIYk5lTVV5TEwv?=
 =?utf-8?B?VWVPL0JLNG43OXp6RmtWdGlRNjBDRmhKeVM2cmJ2S2NoU29vbndMQVJsSkRQ?=
 =?utf-8?B?bkplbmM0VTRuaDJ3YVhCQUM2N2hCTVgzTXZaVmF6RjR1MFZjd0s5S3AvdHha?=
 =?utf-8?B?Y3JWTEllUUtmSlVIRmFLazhvdWlZMC9XWENXeUtWb0gvRGtXNlhMckJOeTF5?=
 =?utf-8?B?L3I1a3Z4MTVta25ubk1mcVlkV1ZlWWxYNlhUMFpCZ1kwM0xodHRtUk5EbTIx?=
 =?utf-8?B?V3ZDU1l0S1NERUo0cUFnbzNYRnJoK2pDNHFZSGU3dlFFaFBtdzBhZ0RlK2pz?=
 =?utf-8?B?R3l5UGxSNmtqV2hPRVZlQVhrRmk5Z2pIbGNVOU5yMzFTSU1mVVJzRzdUbjRO?=
 =?utf-8?B?Q3pzbTlmRUVPTGdwaHpDOHdYNHFaU0x6WE5hUFZ0U3d0MW9kQ0hHQVFMamF0?=
 =?utf-8?B?Skp1Rk5QZHNpOWxSY0ZnN0dRdFMwSE5RallnMlFJakFUb05PUFdac1had2lC?=
 =?utf-8?B?MEVlQnJnZnZXRklHdHJZb0NJdC80enFyeWhXM0ppaC9tSCt4UzkvL1lBd2Y1?=
 =?utf-8?B?THYvRmNzK0xZWmdDYmpFTjMzYUNvTTE5T1E1YUVHNUNibDZZQmJpeU1uaXNI?=
 =?utf-8?B?enJhdEZUSmRqaXNmZFVDOGpCS2wyd0xORFJBcHlFSFFqMDBJeWZvazY5RDRX?=
 =?utf-8?B?d2xlVnUyTkFOb0R4Q0lkS213VmcydUV0UkdQTGFBalcvOWo1TmU4Ums3K0JU?=
 =?utf-8?B?d1BYNU11Smk4U1BCeHFWeHlvM1N2MTZQN0o4ZUwxT3V6dGhXY1NzK0V6WGFS?=
 =?utf-8?B?TXM3T1JRbXlXcVZEeElOcUZ5dDRERkRNQnBNTVFRZklTVGNkYmVKSzd4alh0?=
 =?utf-8?B?bXZjcm5EMmcvbkhuL1UvVmtObGs0eUg4OG1ONkF1QmtueUNTV3ZSKy9ZcXEv?=
 =?utf-8?B?cnVqNWJ4NXpqcnF5UTIvK3l3UFlaN2Q2ZGRySkdoUmYwekR6RXhic1ZsUlVN?=
 =?utf-8?B?bm9wQkUrUStiTFlnL3ZDdkFsYVBiT3lpUEFtSDhGb3BjZGZlYTBqeVh2aUlG?=
 =?utf-8?B?a3kzQUsrVEx6bk9XNTF4bDNmR25XaVpPMWY4VWh6N0tuMGtoaVI2L3Byc0Rk?=
 =?utf-8?B?YnZOd2dsaUxvTHd6cWNUdnBCRk9qeGZvS1ZNS0ZKckcvMW1EVzZ3eEJrRXhJ?=
 =?utf-8?B?UXl5STFrR0MzbU9JWHRSYTl3bnY4MXRKK1U5WHdOZVlxNlhRaHdBNFVkdStD?=
 =?utf-8?B?TU9ZTUUzTGIzNG5GODdhY1NVRjBhaGhMRUJ6cjBiOUo4c0tZRmFnWEEwOG1R?=
 =?utf-8?B?d3lrODZGc1FCc21MSC9ML3NHdE5nSmdoeEtkNC92R09QN0ozS1MwQS9OV0V2?=
 =?utf-8?B?VGZWWjlCK1JWK2lkd3g5TFJ0cHZGZWdRS0Evc1YzV0RtMlN3aHh5YUYyTEp3?=
 =?utf-8?Q?xgn7nx+lqUemJxW1VbD4azjAyD9PVMJ6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFNGUFBPSXREV1o2bFVzVGFvbzRwR2pXY0pLbEtFL1o1V3hzK1Vvb1FnZWZi?=
 =?utf-8?B?am54Q0hYdldKREhRMy83T2lLTFl1bWg5bjFpaTRnY0dmb1ByYnN1WXJvSENQ?=
 =?utf-8?B?WHVvMU1SL1lYTFY0cVNRSUJKZ2JObVk5QTBTdHEyUTJuREkxRkhTL2dPNHha?=
 =?utf-8?B?TzcwTVhXS3JmTmF0Q0RJV1pBU2M3Ny9sUnlQVUR0YjRzV05RdUV3cnVadWhJ?=
 =?utf-8?B?RjJ1RituMXBoMzFMczZkdUFjN0p3dXFGZ2tBZ203TWIvdDd5aHp2aTFzOERG?=
 =?utf-8?B?UkNEc3kxTDFweHJmeHQ1YXI3eWo2bkNXL1k0cUZGcXBSdmtDVjhqSXVjK2hF?=
 =?utf-8?B?VGJkU2k1UnFNekJPcUtoeHlobnZSYVhQUElNdDlnUTl0dFlHc0IzTTJSTEpB?=
 =?utf-8?B?dDc3dm9lc05aUHFXYTQrQUo2WnE0T2s0ZllRQjRIWlNGK2JPc3Z2WEJsdXFm?=
 =?utf-8?B?Skl6OHN6VitkRHVQSVpEUjVmdUhtdHZtS3d5SEx2YzI4L3F0WGo1ODBqK29z?=
 =?utf-8?B?YmI4bTA3ZFlaOCs4QUhRZDJEbWRFZU82bWtKaCtLcVRzYitmdWNWTm9jbERi?=
 =?utf-8?B?b1RzVFFKL0xIWXg2NE5paDBHS25IamU5UlBpQ3JjQVJNYmRBcjZyS3ptVTdG?=
 =?utf-8?B?eFdVck9EWEtZOHB3a3lYSS83NGdGaVVWSEFRUlg4emRUWitsV2tzam0vOTlz?=
 =?utf-8?B?ZU1uWW51TjVUN1FQZmhGUVkxNC93b1R6V091M2JpRm5WZkZ3YzFkelY2c2xl?=
 =?utf-8?B?Z21CR1dkK3ZPU0ttRldFRFdWdEZNYnJBWDVOeFNxY05mRUV3WFloZHdYYmFC?=
 =?utf-8?B?dmR4V2g3VE5zQnE5aG4vM0VZdXd1bTRJSVQvQlhBa2lpZVIvSHVZQmVmcXA2?=
 =?utf-8?B?OVV6bEZINm8zdzZ2aGpaVXQrVTJkMkx1SFBlTENIQTVHazUzeklXY0RySll1?=
 =?utf-8?B?UDdxUGlJa24ycE1iN0FobkdudWVvNHBKWHZWUkluYnVyUHhvdFlaY1l4bE8y?=
 =?utf-8?B?OEU1a1gyc2E4dGFRd08rM0d1WlBBSFF2SEkyL2xNOWl3bEhwQWpud05DLy9F?=
 =?utf-8?B?RTFkWUtDM1hhV1hUSjF4OVltWjN5MjJ0NkpHMkJ3NDhmcG1tYk1oZ0xmYm5Y?=
 =?utf-8?B?bGhxand4cXFyMENPLy9qQ1dBQlFZbHdxVzBOUTd2V0JlQ1p2dzgxZFNadHAz?=
 =?utf-8?B?U1Y1cnpEQWFaOXFHQXBtNkJCRzV1ViswSEpJcGM1VXNlUmdUaTR4bnMzRm43?=
 =?utf-8?B?YzA0SW9FTGZPWmMvU25JV1EvNU85Q1BZcGZXeGxqS3orUnJqRW9GWi9qNUV3?=
 =?utf-8?B?bmtaT1FnTlB2YnFVMlJuRVlqUlJqZlhmMlBEQ1BUQ0JheGFkU0hwMDZOUHNa?=
 =?utf-8?B?U0RDS1hTSDhGZ1c2U2d4YThDS3pSV2U1bzZKSDdvazFNQkRRMzVuRE9sV3J1?=
 =?utf-8?B?eHk1a1NaMFllcXNObzNCODgra050STJiQkttRElOZUIyYktFNW9UV2VJWU1V?=
 =?utf-8?B?NzQ3TXVXM0Jaa0hMS0lDZWh0N2JxU2xoZ01jVjBTenBKS1hSZWM0ZGRzczlJ?=
 =?utf-8?B?Q1JkYTF6dGFJbnR1WHhRWTM1MlZmM0p5T2xNWW9lQ2RCaUdicDNqTy8zbHc2?=
 =?utf-8?B?SERWOG1iY0hTcVJWK3JrV21KcHJJcXdhSUxmUDZ6S3krSDAwUFNKMXNDWkht?=
 =?utf-8?B?bTZRUVFGM0V6TEFzS25lVWxJcVZvbTdEalV5K21QVE8xZmJUQXY1dlhFaWZq?=
 =?utf-8?B?VU9kZWVpZ0toNjAyWVNoQ2M2c3gzMnIxQTZrV1RUVEFKZG9XMXpvb1AzTDBD?=
 =?utf-8?B?aERxQzJsN3YrUmcvN0ZtaE1rYUUwQUNHUVhsQWNIYi85TTFjT3R0ZXJIOU1Z?=
 =?utf-8?B?Ritqb1U5Y3RvY1BzWnNIUjZzbnJHMVhMRWlTSjdpTGFiNVRRZGxmOVBDTjBT?=
 =?utf-8?B?WFd3ak5ROHUvamlTM3lPMzd6OWJYOWFmcE16a1VZTjNKd2hpNXY3R01ZTWZa?=
 =?utf-8?B?d3QwbUtNd0RJL1k0dzlOWGtIbjNJMVVmcnV1Qnc2R013dUlaS3lhbUcrUG9t?=
 =?utf-8?B?ZHQvaWN5NWtlQ09QNFBkMW96QmkrS2RNR2xuViswcUtUbUJrb29qTWozRUdn?=
 =?utf-8?Q?ujwGuCbbfKeCXBPramnMEIoyj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea11a2c-adbf-4060-ee5d-08de291d1d47
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 16:43:35.7173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H08IyKWEZcjoZm/XL9Co6iqCPbMWYUEaLuju5KwJ4fFCIpSDDmZfD8C5kSNaSlLvSuZGPY8juCEWgkvrMhnZ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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

Hi Srinivasan,

The patch looks good and I will send it to promotion test next week.

On 11/21/25 08:02, Srinivasan Shanmugam wrote:
> The function dereferences amdgpu_dm_connector->dc_link early to
> initialize verified_link_cap and dc, but later still checks
> amdgpu_dm_connector->dc_link for NULL in the analog path.
> 
> This late NULL check is redundant, introduce a local dc_link pointer,
> use it consistently, and drop the superfluous NULL check while using
> dc_link->link_id.id instead.
> 
> The function uses dc_link at the very beginning without checking if it
> is NULL.  But later in the code, it suddenly checks if dc_link is NULL.
> 
> This check is too late to be useful, because the code has already used
> dc_link earlier.  So this NULL check does nothing.
> 
> We simplify the code by storing amdgpu_dm_connector->dc_link in a local
> dc_link variable and using it throughout the function.  Since dc_link is
> already dereferenced early, the later NULL check is unnecessary and is
> removed.
> 
> Fixes the below:
>    amdgpu_dm_connector_get_modes():
>    variable dereferenced before check 'amdgpu_dm_connector->dc_link'
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
>    8845				&amdgpu_dm_connector->dc_link->verified_link_cap;
>    8846		const struct dc *dc = amdgpu_dm_connector->dc_link->dc;
>                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                                        Dereference
>    ...
> 
>    8856
>    8857			if (amdgpu_dm_connector->dc_sink &&
>    8858			    amdgpu_dm_connector->dc_link &&
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                              Checked too late.
>                              Presumably this NULL check could be removed?
>    ...
> 
> Fixes: c8f52ca2cefb ("drm/amd/display: Cleanup uses of the analog flag")
> Reported by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8a0555365719..6eb88a96cc33 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8818,11 +8818,11 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>   {
>   	struct amdgpu_dm_connector *amdgpu_dm_connector =
>   			to_amdgpu_dm_connector(connector);
> +	struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
>   	struct drm_encoder *encoder;
>   	const struct drm_edid *drm_edid = amdgpu_dm_connector->drm_edid;
> -	struct dc_link_settings *verified_link_cap =
> -			&amdgpu_dm_connector->dc_link->verified_link_cap;
> -	const struct dc *dc = amdgpu_dm_connector->dc_link->dc;
> +	struct dc_link_settings *verified_link_cap = &dc_link->verified_link_cap;
> +	const struct dc *dc = dc_link->dc;
>   
>   	encoder = amdgpu_dm_connector_to_encoder(connector);
>   
> @@ -8834,9 +8834,8 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>   				drm_add_modes_noedid(connector, 1920, 1080);
>   
>   		if (amdgpu_dm_connector->dc_sink &&
> -		    amdgpu_dm_connector->dc_link &&
>   		    amdgpu_dm_connector->dc_sink->edid_caps.analog &&
> -		    dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id)) {
> +		    dc_connector_supports_analog(dc_link->link_id.id)) {
>   			/* Analog monitor connected by DAC load detection.
>   			 * Add common modes. It will be up to the user to select one that works.
>   			 */

