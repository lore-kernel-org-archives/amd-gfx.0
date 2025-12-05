Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DC1D2F7EE
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 13:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E76010EB16;
	Fri,  5 Dec 2025 13:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zu3uAsfu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D0C510EB16
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 13:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbJ4jZ4u6P1eP7ufJqi/lo6qO9JwQdne7h6+Q4GeWgA/FQbRfFSlWjjDFzh+ifaPsJJQOh8VIUJiv/p5i3h8+/i44Jbfz5e9ij3+jcdZvXpiL/dYen9hs+LI/n0kjtxOUEPgHi6BcRtwU4xLdLbkG2UtvH85QJdUlaC7kFXlBkkzvCdw0oQYNNKEcJdPekL/TB41vahx91BCMecFYYKH5pBK7NtbCxgj9ZwtWBgaBA/3gC+DjWWwsWIlETrGayXmCq/z1WpHZHKn4G/zLo6Lq0KDCGA3HuWg+R5XymjVsSC/Sv3avbsQFukJPaTTttYadNTPsxsIWzzydk4j7nh+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQxMJ3LzBJeycu9PdRplvsCJI9X2SzBvvioeqLYPLfo=;
 b=vemAFe9CFGnMUTpjvKeQwTaI3AhP3fxj2JWboZgu0nUCwIpW1QqerioYUreyU3mjLR7KUfvH7IVo2DjjK55dgw5uhkdGAUO2OfKNG+a2EFfc1pODxjitHh/9PkMP/igj1xW8ow/wk8mOAEsmN0/eKAqP8NzNBhUwm9RB+IxfjmZ9GNk5CBWYvMhFxuM/3h0YrLNMWqy/beFoMAowxD9kygFfzsaaijZ5vDTp1Ead4KHtj0kMSa50XyZa1RrJWrBob8nvbVYCNJc/NSofYr0rTxlvEHqeTIym/mCZTicCgXiW50te9+nIvuOZioFRr4XoxtQk77UouLtzmN8DGXk0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQxMJ3LzBJeycu9PdRplvsCJI9X2SzBvvioeqLYPLfo=;
 b=zu3uAsfuOaIQ4ZMzeYqs9L8NK5AxrAeOiaDFNoQjoQI2deVlWW9ww/d0+FHXcbmIU/zGaTjchyglrTad6YVyL/w8JsRXmHVkzrd4+gfz8mn+jj9T58ANV7doy7Cl30DVJOkm0gx4yQn1694OEsjVrduN/JC3XuqNdh6OdrbRaXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 13:00:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 13:00:27 +0000
Message-ID: <245cd9a1-6a67-4970-a71f-ffc37563ac20@amd.com>
Date: Fri, 5 Dec 2025 14:00:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Reduce stack usage in
 amdgpu_userq_wait_ioctl()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251205121414.408466-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251205121414.408466-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0303.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: da735bd2-1221-497e-c82c-08de33fe42c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVNSQjFac0oyTEE1eXFncmZYYU9uelduYUlveVFpOHVkckpiVXgwcUZtOWk1?=
 =?utf-8?B?YWFBV3ZNVUxtRHppcUNnQk1wMWdTSGRTOXVRd2JPN0Z4aVVmZTU4OURieC9L?=
 =?utf-8?B?N3ovbk8zRkNjcUdJMW9KZG8yVFZPenFzcVV0aFk3TEdyNDh6eTVvdnR3Vzhx?=
 =?utf-8?B?VGZDYnZPVjM3S0gyWW80ZjVDVVh4Q3V2V0tLS0V1WjBFQ00wSG1SZUQ1UFFH?=
 =?utf-8?B?dUFHeExRMkFhakFkcHBNUGRqVzFGbEIwRkV0RG9CeXE3blI2RTlEY3dEZHpq?=
 =?utf-8?B?UTFCajNIeWtkOVFndklXdkkwaGV6M3RBRVIrbVo3OXNYMDN0K2pUMmZydUVH?=
 =?utf-8?B?QjlJdUxlVzc4U3c1eFBUbjlEQS8rRVlIdW4yWHlTdWtwNkxKTHc2VSs5TlZy?=
 =?utf-8?B?WHF0TEZkbnlDSk10MGo4T3d0ZFpoUmtMNmE2ak9kdUJWbXp5a0RXSkdFKy9u?=
 =?utf-8?B?QWJwR1FSUU4ramFZNnlpQjBZeTU5N29OdThMQWgxZ3VmUDNKNFNxbENCWVpp?=
 =?utf-8?B?aW95bXBiUHJRMXVxVzNxL2dSYlNTQXMwM0Y2YWhIaG1KU3dqTEdiQUJEdXgy?=
 =?utf-8?B?ZVZHMGR2aWJrdC9KVFF2MGZGYjBmRTg3RW55QWxIajJ6bkJWMFRZTG04ay9h?=
 =?utf-8?B?NzZnNkVhd1NDQlRJVkdTOXR3bmFBcEJqN1l5aXh5NmNEUGRsdGRNdVoraFZJ?=
 =?utf-8?B?RDcrTFdSTmo0TWQ4S284M1B4UjN5YXhBMGdRckYzOWRtdnZ0M0JKeG12TERm?=
 =?utf-8?B?RjBidkZ1Y2NlKysrcEZqUVN5cFlGcHV3OGd1cUZtaG5HZ0EwYnJrblpEVGFD?=
 =?utf-8?B?N0J3SXRDeXlQQ01ZTzZnZDlKZTV4NTBnTFNSK1NXTmtrQ3FFN2h6a21nZGxO?=
 =?utf-8?B?SnV3MHF2Vjg5UnVBTFJMR1hvVElxbE5jb2JBYkE5WEFDTW1EZUM2NWJ5T0dP?=
 =?utf-8?B?aWFPOEtqUXJBS054R0RNeWE5OSs0YmkxeVlNUUI2dU0yTXp1cG1UMmhCeTFa?=
 =?utf-8?B?UVVhK0lxZnB5a1VMdDhvVTgwK0ZKQWRuRWRrd2hXN3RDaEpPNmFpNHRrQWNN?=
 =?utf-8?B?YkIzQ01CRk53WEMwQjVSZjBFY2xXdXZmTzJsN3JTWkpxcFFMYW5NcllkeUNu?=
 =?utf-8?B?bVoxakZsWlIyU2tDY3hnclVFYzhhQWhiUGQ1SE5tZUs3STl5c1JyczcwanI0?=
 =?utf-8?B?UUtxN0Y5dXI1RjFxNW8veVFQdldoNXJTNzRhZzBQdmsxb1VLZk9QbjlSSi90?=
 =?utf-8?B?cVdhL1FzUm5OVzUvWjlTNUthcTZJcFY3cU1LYm1Wb0Y1SXRmbEh4UFF2aGxD?=
 =?utf-8?B?dFRzSnZKdmNLZVBBdjJiUThEem52R0ZjMXFLVkpVYlpXeWJHNmZmd2M3SGZs?=
 =?utf-8?B?YjdBeDZ4ZWNPUGt5cHg1RW1QY0I1TDl4OEVvMEMwc216WDE1WkViekU3VUxN?=
 =?utf-8?B?UHE1Ti83Nkd3N1A5aTdqT0hpOGg5VXFhbzdVWDBsc2orL1krZnYyU0Y2NWZ2?=
 =?utf-8?B?enJ2VVVZZXVGWU4zZXB3cjF0YXhweXBFM0dyUDVSNlVHNTZibTE1YnJlOWhK?=
 =?utf-8?B?LzJYdGZ1ejNhekFvZUg4cXBZcTlhdmhOWEZKK1JKUnNXZjNWd2pXQzFNTFEx?=
 =?utf-8?B?aXQyNUF1eVJpSVZMSlg4d2g2ZFd4Qk5vUXQ3YzBHYjVJUmFWZ0NLNWxKK3Ft?=
 =?utf-8?B?b0ZMTXpWbVplMlVNVjJ4YWtaN2w1TTc1WWJERnZFQnlpUUV0Wmg3ekMrc3FL?=
 =?utf-8?B?bG1qdCtndEFNRC9KSHNLUWZQQm5QWEIwZDJ0OWVoc1Y5Q3FqcjJhdWlqWDlo?=
 =?utf-8?B?YUFUSEdibmdRMlJKQ05kemx1bUxlZy9TaDFhWXhpNDBsVkVwbE40QVB6Zmd1?=
 =?utf-8?B?WUN3LzRRbjg5WDZPTGVOb1BQeXZ5amp1bFlXdEY4anZMeXl1cXFlR1pHeG5k?=
 =?utf-8?Q?I+9D/f4Oyo+EP/f3jCCAjJcY6bhx6TxQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUpENS9PZnVHS3BHRUR0VVdBbDVYV1ozNnM0M0RMRklZbHhyMGVGeEMwQ0hY?=
 =?utf-8?B?U0ZnSXZSaXhzUm1wc3FReEZqOGMxaCtCbi9DN0wzT29ua3NWUVFWa0VUd2xT?=
 =?utf-8?B?Ui9kMnU4RGJYMFBrREFab1lmNlFteFNDM2lJdGNoRTZ1bmdRVXpaUjlON0lR?=
 =?utf-8?B?d0VzWk93bnIwbVRwelk3N3p2aWZKb2hKTS91RWphWUExNkhrOFJhZlJFblFt?=
 =?utf-8?B?UldqK05aUnBPbzhjR2EvWEl3ZWRRdTEvMXpiWm9sZFV5T1dudUFvR04reWF4?=
 =?utf-8?B?KytvYzJEOXZtL200Mm5kWTNTdXU1T0k3SGROd29DUlcxb2w5dS9qV1JnQVJM?=
 =?utf-8?B?U2RSblRXeURvakkrMTdLRE5SckxvdS9ZMlRCVGRQd0ljWUlocFh0OFRiR0R3?=
 =?utf-8?B?ZHF4ZFdPcmlJNnJ4RFlPMi9nQ3Q1NWtSbDhhWWFEcUQwTXVoWkRncjZrbllN?=
 =?utf-8?B?RlN4NnFoQWtJeVEwS2M5bExCNDlmNFByQnlRMTZhZW1Nck9tZ3FXeXVpWnF4?=
 =?utf-8?B?OGZsY0tyckhJQkg4eGllRFJNVXZqeFpIM255L1FqcFRydTREdGtXUUl1QkdO?=
 =?utf-8?B?cTFlSzBHY3pZVkxEZTY5UTlHQnRjcTdJK0d4UERYL01hQ2FvdW5MVnI1elpS?=
 =?utf-8?B?WWdmRXZnSVY1dWFPRzRDYmRkOGs2amhka2lyb01wTjhvWFJaUDMwV2xiLzFY?=
 =?utf-8?B?c21UNThwaURUVXU0VWtLL25vN0pOMU9tMUVManZkOFFQTWNYdzg3a3IrUFpu?=
 =?utf-8?B?elRsYjBNYml3QlFsZmdYZFBwUFo2THV1WDJxQkxSYXo3UkZaUzU1T2hMNmo0?=
 =?utf-8?B?SE1NbXMxblR6VUdYUXozWmxCcGM0WEhoK1VqSXgzcStGQ2ZwVDRBZlo3elpm?=
 =?utf-8?B?TGZtOGpNUEZXMWRIV2tSMURrdDBMOHJGcDg4NkVFVXdnSVZ4WHRjemt6Yzky?=
 =?utf-8?B?MXJERzY0Y2pqU3BROW5yZ3VKWWhnNHYzYkZoMjZBSnViejkySXFHSVM3YTlM?=
 =?utf-8?B?elpMcmVZK09kUElxQTNqdS9IaUpmamkyeDBpRFhha2E3MmhXVDZ1Y1g1Y3FB?=
 =?utf-8?B?cmpmNzJGVHUwS29udWNteXV3cWVXWjZiU296Mmp4M3N5MlJMWUd3eE5BRHJm?=
 =?utf-8?B?WEVwcytLYm9WWUYzMi9lYWVZMXQzVjhyTE1uNkc1alBUandwdFdwektxdC8z?=
 =?utf-8?B?Um9ESkY0azdnbU85UjBXWUU1bU9NRzJCQWtuWkw3TXR5K041Z3RmTVBLa2c3?=
 =?utf-8?B?b0wzbjNvSDUvU2NWRmlFN28zY0RieEtmTFJMVEJ1U1FydEVZK1F3bUxpRXJr?=
 =?utf-8?B?c0pFNldHdmdmeTJVdzVRR2JuUXd1UW5GTVdOcW1jekRuTUU1R3ZoTk1xSkEv?=
 =?utf-8?B?U2lxZmRIeTN2VDRrL0ZKZlhoNXdudE1reU0zWXRtR0RzanVoYmx1NUhod0VB?=
 =?utf-8?B?RDlDZW1xOTVJUi9GTldFR3M2RElqVUZWQVlGVDEraW9zblNramlPTWJqdmRG?=
 =?utf-8?B?aTRJRit4a2J2R2F5SDRjdXdzWmFkWE83RTB1OEhRODdTciswQ05lc1cwejkv?=
 =?utf-8?B?dGNtY2FiWS8yNnc2OTByY3pkR1d0NHd6YU5xYUdHQ3AyaENFWmRHU0hVWm81?=
 =?utf-8?B?SE4wMDJxQWV2eHpkZjRhWlBsVkI5YStZMzZEY3FvYjRkRDRFWTg1djFQNXZw?=
 =?utf-8?B?TXR1YnBQRzdxRDVEOVZBeU0rUkVwSVZqc2hKdVZBWVo1MGhMQnhwQVF3SWM1?=
 =?utf-8?B?ZENicjFPWklWdkJqalFTOEJ4TTRNZG9qcGxJSU8xMmRTeEV0NnJNL25PRkJB?=
 =?utf-8?B?YmpzWUduUndwbFFVNmVwaFpFRmt1a2RWc2ZybDVDa2wwbVMxM3FqVmFXMnpm?=
 =?utf-8?B?N2xVUDBJSjZhSXpjSm51VHRwY1B4UFZOZDhBbTJrT2x3L3FXUGY0MVQ1eVNE?=
 =?utf-8?B?bnNwU1MyZHVWTmpobEtkdm9GMHl2SUVlN2NWSCs2Sk45elFEdTlNeGNBUFNH?=
 =?utf-8?B?WG5tWVNjRmQ4Y2k2c2xQYjNob1BGZzRxN3cwY3V3QkM2eUFCbUE2TURCdk45?=
 =?utf-8?B?b2lvVVlIK0Y5TmdpWlBGWmJyQ2M3TWYwODlIVUMvU3VVSnRVTkZvRXdnbi9H?=
 =?utf-8?Q?osUNhU8i6ca/YCalqpejwGinF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da735bd2-1221-497e-c82c-08de33fe42c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 13:00:26.9246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuMjSccr4TQL/bmGII2vmaqd8bQ0H+QkF4vuSbh3aXMKsfwUm2+YQmT2uFqXntVo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
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

On 12/5/25 13:14, Srinivasan Shanmugam wrote:
> Checked all the local variables in the function. Most of them are small
> numbers or pointers and use very little stack space. The only large item
> stored on the stack is struct drm_exec, and this is what pushes the
> stack size over the limit.
> 
> To fix this, struct drm_exec is now allocated with kmalloc() instead of
> being placed on the stack. All call sites were updated to use a pointer,
> and all cleanup paths now call drm_exec_fini() and kfree() to release
> the memory safely.
> 
> This reduces stack usage, fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c:642:5: warning: stack frame size (1176) exceeds limit (1024) in 'amdgpu_userq_wait_ioctl' [-Wframe-larger-than]

Mhm, I'm really wondering how that happens? The drm_exec object is intentionally so small that it can be allocated on the stack.

What's going on here?

Regards,
Christian.

> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 40 +++++++++++--------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 25f178536469..b5839acde14a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -654,7 +654,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	struct dma_fence **fences = NULL;
>  	u16 num_points, num_fences = 0;
>  	int r, i, rentry, wentry, cnt;
> -	struct drm_exec exec;
> +	struct drm_exec *exec = NULL;
>  
>  	num_read_bo_handles = wait_info->num_bo_read_handles;
>  	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
> @@ -721,24 +721,26 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		}
>  	}
>  
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +	exec = kmalloc(sizeof(*exec), GFP_KERNEL);
> +	if (!exec) {
> +		r = -ENOMEM;
> +		goto put_gobj_write;
> +	}
> +
> +	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>  		      (num_read_bo_handles + num_write_bo_handles));
>  
>  	/* Lock all BOs with retry handling */
> -	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> +	drm_exec_until_all_locked(exec) {
> +		r = drm_exec_prepare_array(exec, gobj_read, num_read_bo_handles, 1);
> +		drm_exec_retry_on_contention(exec);
> +		if (r)
> +			goto exec_fini;
>  
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> +		r = drm_exec_prepare_array(exec, gobj_write, num_write_bo_handles, 1);
> +		drm_exec_retry_on_contention(exec);
> +		if (r)
> +			goto exec_fini;
>  	}
>  
>  	if (!wait_info->num_fences) {
> @@ -966,7 +968,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		kfree(fence_info);
>  	}
>  
> -	drm_exec_fini(&exec);
> +	drm_exec_fini(exec);
> +	kfree(exec);
>  	for (i = 0; i < num_read_bo_handles; i++)
>  		drm_gem_object_put(gobj_read[i]);
>  	kfree(gobj_read);
> @@ -990,7 +993,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  free_fence_info:
>  	kfree(fence_info);
>  exec_fini:
> -	drm_exec_fini(&exec);
> +	if (exec) {
> +		drm_exec_fini(exec);
> +		kfree(exec);
> +	}
>  put_gobj_write:
>  	while (wentry-- > 0)
>  		drm_gem_object_put(gobj_write[wentry]);

