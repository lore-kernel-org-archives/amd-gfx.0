Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA18C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 21:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E8310E03A;
	Mon, 19 May 2025 21:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cR+6BYeP";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235E610E03A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 21:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdOyKAc6wK+wKww4jEq94oimQdSh/BQI2uyy16mltkkOHBZEYCV3CFN/VD2UKMSJfDie3tCe8Rlct4JFg5JpFUtZtKux8AZMm/AOGbB8pymeB4KzXWPwIm3s1QmtDkcpR0B6dOilGnbPOBm705g4E58tKsUWqtsTHG5W5A+Sgoo/2WoT/QJWtfz5zsJrBoxfc9rowCq6feKPOmNTHvSsB5v/kgyZBVtZWccgRt7S+GTwbbDzQWJA66mfaSDma35sMMVQ27qVl/GmC0Pa4fFANyGAdCaJkWwxbQaquESOscOaoDm9AK6b16OeS0i2VubUXpgNgz3G9ShkZWPYo8it+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3RmvKLD9QVBXsOOHtoAyaa1O3cNllMMeCsoz8h67Dw=;
 b=d4TM56pRvdpV3dXwFqd9DRrnZsZDGb67luyS7ZZWy6xDUEFNP9gdbl8tOQ/bn0oDwzA+IF1Zg5ppEoCWS5eHK6GtIzs/ohzRZdbn/k+5iyZt3vS823JCIrhRQhPVxuaUZapPBQ4DfxQGvx8C0gBAouK1lHBpCcSgzCn6A1L7j7qMBMaSUypDebY7Da1PEe3ndRt32qcdVU39FvoQbPSOx9J4+MjjzGT+Puuz+J+0H8raHGVYSHHTRqug35iFM0JmIgThbGIHVZdPQXxVqOtGeHbCLM716LLoXtxpS3ztAthZTWl9logUVS8T62g+HKrxVYgdxXSGsxqkkF4g+azf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3RmvKLD9QVBXsOOHtoAyaa1O3cNllMMeCsoz8h67Dw=;
 b=cR+6BYeP/IYLQQ5J/GHtLZ75UGgyBpltOJ6Fx/6WOv6BVy9t9a4U1c2+iXiAyLRnSpa2WgSzjgpoAw55S2YXQ0yr9toav3sPKMFOhz8q555AjoKZPe1FbbyvvqnJEmptTwfM6sm+2AsAC4RH06zJSIA9A3weDZ7IfJ73PDBNDgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 21:14:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 21:14:55 +0000
Message-ID: <2046351d-b7ac-41c2-9423-2075e2f0a18c@amd.com>
Date: Mon, 19 May 2025 16:14:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250516222611.1966604-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250516222611.1966604-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 0593142a-c76e-4744-7277-08dd971a33bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVVWWFBQMzZnYll5ME5vaDBLa29YbHFsRlhzazNWSG5vMlZKbzZkd3NoR2Nv?=
 =?utf-8?B?NHl4ck1GRnp6UWo4TUdlL0NCNTBKRE80aTFncXpVSDRHNHFSR2dqSUdVVlZk?=
 =?utf-8?B?RFB0Q0pNRlBTaVUwM0tKeTg3L2loS0VPVkVMVGlXT2ZQbytKUk9PUXpvOUc3?=
 =?utf-8?B?MWl3a1hxcC81MHpOTUdjSStZMElrKzNyQ05mdUtxRkFZMlV2WWxSL1gvZ2g4?=
 =?utf-8?B?bU9NNE05QTRoSEg5M0dwNExSaUNqY3ZJT285SWh0SHByczVLcHRqa2NHV2J3?=
 =?utf-8?B?Z2FsWk0rV3NUVHJXRnVvRkhDaWZYU01PckRxZkNrZWZpRHZWQklDQ3JUN29s?=
 =?utf-8?B?VnBkcjAvaUZsOENTTGIyV1NWVDViU0hGTkFmTExLMndWdEhDK3habFAwQzRE?=
 =?utf-8?B?cWpsVVlITFdjT0U4QXFERlV2Mml1VmlFMDJKZktrL0s3VENieHdTR216RDZw?=
 =?utf-8?B?U3hIaGdKeEVHdVNFdUVUWHQ5K3lVRzByMDdBamRYeDZVRlhWRFo4R2JPL1ll?=
 =?utf-8?B?aEtBSDJVTkRBeElZelpubUo1dVl1STRGOXNSM01Vdk9rSkRMNzdrZTRFNFo4?=
 =?utf-8?B?KzgyUGE5aEthaXhqNWxNZWhZTi9xUWlrdm9QeUpxY0FnSzBtZDNIQkFEaGRt?=
 =?utf-8?B?T1V4clpHUkU1Q2ovTU9LNWxORkVmWm1GQ1dQbjk2UnZvSDBLT1BtcUVJMUI4?=
 =?utf-8?B?aW9ndklFWXhhNHNidmNyN1dzbjJNUHlmWUpnekVZRlY0R3ZKcm54TTdiWVV1?=
 =?utf-8?B?SUhGQ3NjZ1NCbHRGUkRPSk5hOEVleWNzQytaeTRqVHZlMFdmUnBUUnhMMmxz?=
 =?utf-8?B?WWc3SVk0WTdyQnovaDZTYzYxSTY0MkEvR0xiaEFQWEFYeUJoQk02ZVVuVnll?=
 =?utf-8?B?UXVMVUFiTW9sYnBSZzAyTk02OERGUzh0K2FOOVFFVDFHRFhMbGE4SmltbzJ5?=
 =?utf-8?B?VDJJZjhTQ25JOUxEQ0w4QW1LTmo2N0lwVEM3YTk1VXZMeG81MWpPQkcvVEMy?=
 =?utf-8?B?ZGN2RkhBRElBaXUvN0ZYczNzZmNvVjZBck5nQkJ5UzMrNE5Pd3JQZXZlMjNW?=
 =?utf-8?B?ZmFmbmpkV1o4WHdwTWpBd0Y1aE1lQjJvdkRFcDNvNjAwOERFOGU5dG1xZWNP?=
 =?utf-8?B?dHZrT29tcnpTR2x5SExsZk9lNCt4N1NjWHZacXFsVHhxTHR0cmM5T3Y0YlVZ?=
 =?utf-8?B?WktqL1pTVzhHZlBHQVZiaHYzT2NhWXArdjhEWm5tZEx2cGd0aXVtOHZ0R3dv?=
 =?utf-8?B?OE04WS8rYVVUM3BIMGxXd2NHNERHMUFUa3k4R01KdlY3MnNMeHV0MlM3eGUr?=
 =?utf-8?B?eHA5NW9LdndvdnNjbk00Z01nMktXaWVqK3RkbXlGVUVlNmE4OFB5YXBNVzRY?=
 =?utf-8?B?WjJsT0hLZmNyeVBFSE9QeDNjL2NWRzN3UUE3d2hTWFN4Z2dWNVJVRUZZWHc4?=
 =?utf-8?B?VE0wVlFmYzlDU2hUMFp1aGQ1V1BGdk9vSGsxOURISnJCd0pLbFA5NDRlYW5W?=
 =?utf-8?B?Mld6QVBaWEQxRlhmb1o3bEtVcTF2QXQ3Y29qN3hnWVRja0FudzRiR3VEOUd2?=
 =?utf-8?B?VzFJa210YVo4UGUwMU5pOFlWOWN1U3dVN1VuZGlNK25xRmV4T0ZNUk56OUJX?=
 =?utf-8?B?L2JwM0FsOVN5c2pwaXgrU0U1eldpanV5U0ZpSTFvNFhtUDRqdUtUQlMyb3pn?=
 =?utf-8?B?SEprT0ZzbnpOWHJEa255MldvK0k4bXZGSTh0MUlaeDZ6ZUF5NEtQZnR4Tzd1?=
 =?utf-8?B?VU0vYTd4RXBidEZMc0x4NWxpTURLZzFJdFpxeTNmd1VLK0lRNUNJTERYSVRm?=
 =?utf-8?B?R29hTEQ0TkJZYUtLenRYWW9zditpRmNkWlhMc1MxVUI2Zk1TU2Jma1BiSThI?=
 =?utf-8?B?Z0dwTmppeXZBSnRLTHJxdWpPRkpPejk2ZXE5ODZwVWcvdFRWclhUVFVwUlNQ?=
 =?utf-8?Q?gaam8YRsWNQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXpuR29lV2hzTzVEZXprOVh4bmZmVElaMWxlZWlRVXMyRlZoNyswYkVvWDFt?=
 =?utf-8?B?ZmZSdG1yUW43b0NjRU5VSnZhRFFJZHBtNTRSYmZVVUJpZnhoRW5DVnErNzd3?=
 =?utf-8?B?RzdTaFVHNHd3MHdwZGtyRlM2V2FydmROMmEwRm9GMkczRk4vdytnTlZpQ2Ev?=
 =?utf-8?B?cmlKMmdMTEFqSENzQXVKMVFNTmFTeUh5em9YR1JWRFE1bnpVSGpPYXZ0eXNy?=
 =?utf-8?B?S2pyNlFkeThPZHNhRi9LemYzMFNBUW5uRjRmcG9rdTkvZUgzcEdGR0czWW1E?=
 =?utf-8?B?TmRDdld4UjF0KzRMMjZuUkdqNkpTSThUYjg3dEpyTFF0bWtPYmFWY2VYUDYx?=
 =?utf-8?B?SGgvRVp0cmZ2d2hxV2pIWlh3YnJ4czJxN002U1R1dDVhR1FNYWJONUphTG9V?=
 =?utf-8?B?R1NUekdPcEVSQi90K20wYVZPanptaEZWOW5ZWFI3Mjlqei93eEM1ZERReUh0?=
 =?utf-8?B?YnV2clMxeXA3SGptOUFFdU1RMHFzY0pUaW92QWpGaEFpYThBSEdXNEhTTk5t?=
 =?utf-8?B?NWNJWXlVR1dOK3FMVSsrUzRrWmVCZG9yc1F6QlhoWTU2dFErcDZJWTRUN1Ri?=
 =?utf-8?B?b2lqekQwdWkxUXZIRTRydDAvaTcyTitMVVFXZGtNZFBNQUQyUXBUemdhWFFx?=
 =?utf-8?B?QlhyelE5ZEhMZ1VWYjJjdjM2T2VGYUNLMVowaXgycnZMeFlOSHErNVM3Wm9j?=
 =?utf-8?B?cU90bW0yck5uZUYwcHVoUVZ0dU1TaUs5TWY0eVRsSHlSMCtrN0JiSWp1Ynlx?=
 =?utf-8?B?R3dGRkw2aHhGUlFzTWpMcHoxdVd3WjRqN3dtMnNBd2k1QUR4VFpOZ1FpSjNM?=
 =?utf-8?B?Ti9TYW1ZMElBbDFEQWJmQ3lFeXdLZWtuS2hLanM2ZGpkN0kyUnRGdE4wRmIy?=
 =?utf-8?B?b2ZDTlBLUWtBakxtV0RQZWZDWG85cnVobDBTL3g2L0l2ekJ4WWZ4dDd3cVNw?=
 =?utf-8?B?MWtzdnNPQmxZT2xBUHM5VXZwZ2k1ZXBkMmtLR05aWmhUU1FDMHVBV2FzVzRt?=
 =?utf-8?B?WllwSTB1VUY5Qld3RkZ0YzZzOEdpSmJQMmVXc2tYRlpzN0pVbnQrZHBXVk1k?=
 =?utf-8?B?N0kzRjFBNVVqOEFsSVhFWmwzZGtIcmRNaXBrQlJlR1gvSWFvWHVUbitjbHVl?=
 =?utf-8?B?VXpEVmdrSG5aQVBYU1FoSVZVZWxzU0VxbDB4UzBQZUI3TVhycS9SUUFMOEtD?=
 =?utf-8?B?aEtROFdjaUVtSzlwVkFaZkI0R1RPSEJyTU0wZjRJSXNNQkdwUHUrb01QR1Bl?=
 =?utf-8?B?U1Boam1KK2s1Z1IyWTR0cnBWQTJmdkc0V2ZMbHJnTy83OHozeGwyV01OUmo5?=
 =?utf-8?B?WEFqSERJemdjaWVURVVxY040WFVXVzBxWnBHVmEyc3pzZGhqOTN0VUZ5eXB5?=
 =?utf-8?B?YWlhZHNIYnFCbms5Vlc0bUo1b2xKZGgybFF1MktraTRId09pWTdKaXMvc0pn?=
 =?utf-8?B?dG5XR0F1WkxhbzQvV0ZURXYvMStrQzhJY0lJTUh5RmVmc3FXZUlTWnFLTTFE?=
 =?utf-8?B?bVJZeHg0Nm9NZlN5d0J4MlF1Y1g3SDZaTThEMTBxeDFyUkxBbS8veVd3bjBB?=
 =?utf-8?B?U0dmTWEzOXAraXorNVlNZU1OK2NTVnZ5TWUyR3hYM1hZT3o0VkZxQ0VZWmpY?=
 =?utf-8?B?MncyWi9sZGxDWjZocVJwOU0rTVVSSExtbkxuYTdDTGtSS2NXRFc3ZXhYRjEx?=
 =?utf-8?B?d0dYSDByYk42bm84SGpybzh3RGgvNmgybEtJSE9KYXdTYXQwNGFEY1NONUxB?=
 =?utf-8?B?NkJ1NG13KzBROVQwdnVxWVJBRTlaZEtFM2hXQzVHT1dvbzhPVm16ZmNqRENH?=
 =?utf-8?B?LzFTbG9GOTliTi90QmZOWkpqcFN2WEdUcUFXdEk4U3NKSTNjRDVqS2RqV3Mz?=
 =?utf-8?B?a2lwQndsNFZ5L3l6RGVYZzdmL3dGdUF3WSswTzhxbVl2emJWNUhlanlsYzh3?=
 =?utf-8?B?bjRZWXVPVE5SbUV3VWhBTnByVTBxV3lOMDZLTm1RL0FQaUp3eWdycVdiRnhZ?=
 =?utf-8?B?em1rTTdJWE9wTzhkczJDdnFaMm5rRk9qajVua1ZNNTZ4THl0c282SXJrYWV6?=
 =?utf-8?B?dDh5OUt5c01peXYyNE5aY3ZKZ0ZzMElDQ3g0MWU1ME51WVBPc2Q3VG81YjF3?=
 =?utf-8?Q?wZWuvAivCI+FYYMQ2BQz8oVR9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0593142a-c76e-4744-7277-08dd971a33bf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 21:14:55.1811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4e8uEl9+3JWoaqib1mpoQ3giItrWmfkIE9ucE7w20mztSmsyMMcQie1wQdQtI2CwlZ0TRu+3/fb2AGL9tmR8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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

On 5/16/2025 5:25 PM, Pratap Nirujogi wrote:
> ISP is a child device to GFX, and its device specific information
> is not available in ACPI. Adding the 2 GPIO resources required for
> ISP_v4_1_1 in amdgpu_isp driver.
> 
> - GPIO 0 to allow sensor driver to enable and disable sensor module.
> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming mode.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Changes v3 -> v4:
> 
> * Use __free() macro to call put_device on exit in amdgpu_acpi_get_isp4_dev_hid()
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 29 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 ++++++++++++++++++++++++
>   3 files changed, 62 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cc26cf1bd843..2aa7e89a190e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1657,10 +1657,12 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
>   #else
>   static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
>   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
>   static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
> +static int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]) { }
>   #endif
>   
>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index b7f8f2ff143d..daef8b912277 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1551,4 +1551,33 @@ void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
>   		adev->in_s3 = true;
>   }
>   
> +static const struct acpi_device_id isp_sensor_ids[] = {
> +	{ "OMNI5C10" },
> +	{ }
> +};
> +
> +static int isp_match_acpi_device_ids(struct device *dev, const void *data)
> +{
> +	return acpi_match_device(data, dev) ? 1 : 0;
> +}
> +
> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
> +{
> +	struct device *pdev __free(put_device) = NULL;
> +	struct acpi_device *acpi_pdev;
> +
> +	pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
> +			       isp_match_acpi_device_ids);
> +	if (!pdev)
> +		return -EINVAL;
> +
> +	acpi_pdev = ACPI_COMPANION(pdev);
> +	if (!acpi_pdev)
> +		return -ENODEV;
> +
> +	strscpy(*hid, acpi_device_hid(acpi_pdev));
> +
> +	return 0;
> +}
> +
>   #endif /* CONFIG_SUSPEND */
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index 69dd92f6e86d..574880d67009 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -25,6 +25,7 @@
>    *
>    */
>   
> +#include <linux/gpio/machine.h>
>   #include "amdgpu.h"
>   #include "isp_v4_1_1.h"
>   
> @@ -39,15 +40,45 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>   	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>   };
>   
> +static struct gpiod_lookup_table isp_gpio_table = {
> +	.dev_id = "amd_isp_capture",
> +	.table = {
> +		GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
> +	.dev_id = "i2c-ov05c10",
> +	.table = {
> +		GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   {
>   	struct amdgpu_device *adev = isp->adev;
>   	int idx, int_idx, num_res, r;
> +	u8 isp_dev_hid[ACPI_ID_LEN];
>   	u64 isp_base;
>   
>   	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>   		return -EINVAL;
>   
> +	r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
> +	if (r) {
> +		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
> +		/* allow GPU init to progress */
> +		return 0;
> +	}
> +
> +	/* add GPIO resources required for OMNI5C10 sensor */
> +	if (!strcmp("OMNI5C10", isp_dev_hid)) {
> +		gpiod_add_lookup_table(&isp_gpio_table);
> +		gpiod_add_lookup_table(&isp_sensor_gpio_table);
> +	}
> +
>   	isp_base = adev->rmmio_base;
>   
>   	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);

