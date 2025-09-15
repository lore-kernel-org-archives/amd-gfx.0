Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E1CCAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54D210E4C2;
	Mon, 15 Sep 2025 13:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0P5rYmZl";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A466E10E4C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmJB9Be76pQm1Fex5ZVFXEzNCmletuVrXuDoo0qWHJcVR9MtY6XnOCs+6vy/Jpl9WaZYCd9gTxE74m/aS1wihUW/jjpHtl680aCmrH8wW3HZp/heMqA6MjUI0QiTtqxchRVtPdb5xq26PpJ0c4GgsuCpN83tpNJVGR0mfPA7MZ1eB7klvr7m3MKuxW9Uyp035s8LwG4VszFRbHh5NizvLI/zZBCmh/zVaAVLpgR+O30Jq0rpZBYRQgEM74KNYovz1tqgGli6rYEQvy7IUSVgAJYEZMGP2nRrcouvteBilaXqPd+WUOVEkmHveubFkgJpm0Vuq2c1LBGuTVtiAdLkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBLGCYUW/tkuSSLnzTHOQsQjRvC3ITetJsDJSzymnPc=;
 b=sQSIc0OnKPksudwrIJDD3zEi/ImdTEnT9C+TUY9/5FcpMrxR7r93wgsVCaVXQzJycjZFEY8w+Dq0+t4Bk2K8k1VjS4lGBqVHEAcxRoNdq6CED/wSuJhjWRKszAjTde0ysGQIBuxpLB6tYT/CW/+LhVa9YA7T/GTPA4voYMG+hCJZUKpNK61Cv6W0SpkP75Oz2Aqa/uJndMDPqZvTIbZyqqQUnARv/FXk/R0LEV1cUcFCxJND/zcPQhIgW6R4ZaHaLdi3L0czgNPjNlw1+O5KN9kv3b/eW706dfH/3Wgls76pTSs8veJIyI5Ol8rVBtMhvrwD/gEAhwAijSaGtfn5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBLGCYUW/tkuSSLnzTHOQsQjRvC3ITetJsDJSzymnPc=;
 b=0P5rYmZlqC3sIFszYTFosCVGTMiXt/96Asn1bm3Yu0PFvyR55UtP84j/t/Cx+AQOOunGKBw+NoKu1wpjoGJ08wp2sz76WSEnmv5bah1LuwcRlWYDqDVbKAb7rnUAtzEb7pkrD8uyMUPC3B5TZAxLkU5b0UOLOOF2yUkb7v6SNBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 13:43:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 13:43:26 +0000
Message-ID: <70e8c427-f816-4bdb-8f92-9382cd5ab13a@amd.com>
Date: Mon, 15 Sep 2025 15:43:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: set an error on all fences from a bad
 context
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250915133356.3547174-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250915133356.3547174-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a97fa0-229a-40c5-7841-08ddf45dd8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWt4cGFuc3BBc1pMWjJXaUtaRDFqbjB6aE5ML0RPUkI5SGs0SGUycThNZEp1?=
 =?utf-8?B?WDhKekdTbmFiaG9sdXRMaU5GWVRLa3hnUHQrSmErWlE5SVNmNVgvSUhtam5h?=
 =?utf-8?B?SnJERFVMYU54bkJMUzd1Y3pGWE5QUWlTS2VaOUtPbS91REhIOWNldWZjYk9m?=
 =?utf-8?B?TzNUSUNhaElIRW1wVXk3SUVLTlgwSXpsa2VjQXBuN0w1OWlDaEhLSUVoWjRC?=
 =?utf-8?B?TUQ0UW00NzR4cFVEVkZOQVdVSHZMUTlVMS9SakVXdFo5aS9wMWwzWXd0MkNG?=
 =?utf-8?B?K3RpbnpWWTRQNTUxUFM3cFZLeDY5WlZkUUhXR0J3WmY2bmlsZ1J6NC96ZDNP?=
 =?utf-8?B?SWNYTzBoM085OFZkbXcwektVM1RhZ2NuZDdkdXJyVFVWZHo1VVNzZmhCcDhy?=
 =?utf-8?B?dmZJNkJEM0xiL1JCQnQ3RUR1dGxhbk13SUQ4ODBndlc0WDJ4RjJ4RVlBazFt?=
 =?utf-8?B?Y0JiRkJQWUV5RXVCcURSRXJHT0xmalhXTEdUQzVWOU8rV1k5QlBjUUxHN2Qy?=
 =?utf-8?B?U3laK3M0Q0IxZ25UMDRDcit2b3pNNHQwb2tVRElpNFFUaW1ha0VCUEpua0dR?=
 =?utf-8?B?T1ljZTZuN3RTOGZHUWtIYU45RW5KWUJIdEY3bkx3VmZyT1N6QjJQaGliL2xm?=
 =?utf-8?B?dHB3ZVdnS2p3Vll6NnNvZWhEZXNXNDVnUm5uSnlhZ3BCVkxZWm1rTVpLUnhQ?=
 =?utf-8?B?QVpLQXF5bGZaTStKTm9FVUtIcUZhMTluMmdLaE9OT3lTSXJ5dUFBY2s2Tjlp?=
 =?utf-8?B?c0lkZXphWXJ3KzRnT1NValA5ZHN0QSs5ZStYYTdGYU1PMkRYTkw3NmRydlRs?=
 =?utf-8?B?dmtUZ2t5OGFXNGprVHhFaW9NZFpWMlNIcmlUbHc5dUxiRVJ3MXlPcktZN21w?=
 =?utf-8?B?SUx2TlhBekh1aThFdU56NS9YdUNGdEhha3NyZFZQeUxnRE5ncWE4Sk1wMm9O?=
 =?utf-8?B?T3B5ZE44U0NuQkJLOTFzY3ZQUWJ4NFdkazNPbWVhL0FBMkVQendZNlVrZm4x?=
 =?utf-8?B?TnZBYW1ZcmhidGFGWWQ0ZlhSMkYrdm1pdWM3bThFcXd3Q3hDQ1pDV3BJUGxK?=
 =?utf-8?B?ZmlRY1E2bTlCa2NEWm1EMkwrRUp2cGhYQlg5aDRMQ00vT3NaVjRHMnRnYzU2?=
 =?utf-8?B?NENQNWhNb0hZR2lNcGxEdEtETGxlR0MwS09vM2FWZ0lySnJxRlBNVEdzdGJ1?=
 =?utf-8?B?VGdoRDhrU2lJRGdIakp1RUlrRHNXbUt6ZmZiSWdVKzBFNmxNVTdhNW1OWWpt?=
 =?utf-8?B?TG1LMjkrWUd4V1hxeDE3KzNabUNUMTBKM2lxZjdXN21DNzUxRTBTZFo5eUV2?=
 =?utf-8?B?cS9YVFNVd0wxNnRFNGQwQ3RFN1hiUUV4MWFSSER5UUlQMkZsckdkQmI3ZmR2?=
 =?utf-8?B?cFFPcDZOUGxGYUh4UmF0QmIzK0h0Y1lkeUdqTGF0UFo4WnhIRnJQa09BakJo?=
 =?utf-8?B?eW1JWHJDQktqdXQ2cFRRUkNjT0Q0YUE3blM4djMxMTFzNGdjU04wWHYycWJE?=
 =?utf-8?B?NTJxY242M1M4VWhCNjkrSDdpMnZHY2RyeTMzUVIvWG5QYTE5SmNWMkNjb2Zo?=
 =?utf-8?B?SFV3UFp3QjNlYW5MMjdCaTR6SC95TC9BNUJjang3K2NMdk1rVkZESGRvTGd3?=
 =?utf-8?B?TjhkZzhpYW91REZaaC9MRW9IK2xkYUVCSmRPemJCQmlqSk1HZG1YMGlIODRa?=
 =?utf-8?B?Q1VwWjZ1eC9pL0Y5MEorV2JsTlJYNUZWM20rVThrSmJKQk1tbC8zN1pIMkxn?=
 =?utf-8?B?anZrTThET3R5TEp0dkNXS0xxTVg3K1BhTTlzbjlGRFRzZldJYWhpMjJaZkxU?=
 =?utf-8?B?QXN0SFBtTHBSR3ozQVI0ZjNONm4xekFGQVJVamxvOXp6Y0dxalJqWGhycm5v?=
 =?utf-8?B?d1NKa0YxN3dWNjhGV0ZpbXp2TkJCcER4RlFqWmpBODNTMUR3UWQ0OGIxQi9s?=
 =?utf-8?Q?cw/WVsL1tYo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ppTmVzQjNYR0l0a2ZHYWxtN2NZTHo4YlVLUnY2S01GR05hbHN6UHNCOVhC?=
 =?utf-8?B?N0tKcFhUK1JNcHVWeWN1c1YxMjRjRkt3THUrd05kbUgyN2JUbUVaTm9vdzUy?=
 =?utf-8?B?WUtYanFYM0w2T2liaEZBcWl6SEVDQndtSDVlMHUrUlJvSlpIdVlzK0dYZEZy?=
 =?utf-8?B?c3dIU3l6bHVBOEpXNFUvazAreTRiM0sxRHQyTnpwUnQrRjJGaE9IZE9YVXNu?=
 =?utf-8?B?QkxxVDRoV1ZKNVlvK08rTExKMWZjWHU0SzVYUUQyK2FKR1FrMWNjeEdoQkla?=
 =?utf-8?B?Q0RWYWdlOHVFS0prcTljcXhvVjlJRXE3aktvQWgzU0M2MVQ3TkdPLzlnR1Ns?=
 =?utf-8?B?L0d5TTlYR1NMNHFxaWVyS0x2VXI5N21TZkNGRGJZMWxTZEZRYWRMY1NQM05B?=
 =?utf-8?B?Z0Z3VkluZUozSi9UbFJjY1dHOTVyWUJFcEhSQnJ2cFUyZ3B6ano3bFdjSFZy?=
 =?utf-8?B?TkZvelBmYjNUNG1kbkoyWllFb1FFa1NaVEtDTmowVldsd0I4bVdRajhBOWN5?=
 =?utf-8?B?TnNCdGExMlBCWXdQRVhzbjJNeWhGYzRMTjVJRmNXS2s3d1pYaVF2QWppRFQ1?=
 =?utf-8?B?K0FpUm1NS1hMdlhXQjMwTm0wQmZSMjBTT2hsWUhyUTk2S0pnU3JTVmtoYmcv?=
 =?utf-8?B?b0pkV09wRytsZ1FyVE9KVEJoSStpc1BmdkRhYW1wS3hDQXppeTlsbTQ1QTEw?=
 =?utf-8?B?NGFYYnVZMEM3ek1yZUFpa0U4ZjBkMEYvREpOSCsxdU9KWGNwUW43TGR4OTdS?=
 =?utf-8?B?SzM5ekVSOGpyWW1aZFhaS1F1bUFMRTRxNW4xd0NjVlE3WDloN3R4MXhmL3ZN?=
 =?utf-8?B?bkJYZUZxQnFGVnhoaE1oY0NlaXFRMHZwRGRCYUN5ZzRsTThNY0NJU1Y4b1c0?=
 =?utf-8?B?VW40WTIyNlhGUExxTWpZQXhoMVdJTXh3cjljZVZlUUVNZlMvWUFWUTdXeGpN?=
 =?utf-8?B?RGpNQ3hScXllVXpSbWd0dE1RdVhFZXpyRXF5djRqVjM1UWZRb2FaMnlobExN?=
 =?utf-8?B?cGY0RndvUWYwWHBJejZyMHAweHVqUW92ZmE0U0xQSk1UOVdOdXZoc3JMSHdr?=
 =?utf-8?B?dE1mbHZNblpUUk51eWRVOS92ZnlVS0pMWFpHSFRIbTdhUXY5VFNCbWFmdlpX?=
 =?utf-8?B?SFlCTG13bzEyWkFhd2xnenZrdTM2bFI3R0JVVTZ3SEIzU0Z5blR2c2lQQ0xJ?=
 =?utf-8?B?K2ExREpQdzZCVVlDd0pRVEVhcjJNRWNtWWh0ZHBVUHFWL2N0L1oxRFdvV3Zm?=
 =?utf-8?B?UlVRK2RpUzl4T3Z2Q1VxcjlCT3B4TUpyandZbTgrL2R4cVQ2MWkwa2wxTEtl?=
 =?utf-8?B?b3lXMGhoZlFrVjFpUmRGdktPN2t0NlFZalZIRVZMZGxKTEtDVnVXa3FkN0VO?=
 =?utf-8?B?RXQrM1FTSVlQdWxiT2IyS3ZiY1lVTXpXWTEwS1ptYktRalJZUi9nalVZeFpk?=
 =?utf-8?B?Y0RxKzZqQnhZZkdzaTZQOTZ0QXJWekRwS2hPK0t5UG1LY0JLK3hJM2s0bFNh?=
 =?utf-8?B?ZUpXbEhwc0NaMUxhb1R3T2xKOU5CR1JXU3d3NGhrVVhOR2k5bS8waHZSNG0z?=
 =?utf-8?B?MFdvNkE5V05RaGkyUFFsdFBmTG52dFM4MWV2eGNyOVhZckVrUDFKcXlybmw2?=
 =?utf-8?B?WUM5TlVZaitYVjhZQUxLekV5cFR4by9HRVpydldhd1cyL1ZXZWtxMmRQalNO?=
 =?utf-8?B?Qk5EaVpTeHE4cGpEVVJ6eVIwN3lzai9jc2pLQkJ5MnJZNHAwbEZmQjdvRzJV?=
 =?utf-8?B?WEUvVStQT01sK1ZoOHZ4TzdlMGFHd3dQaFFOZmxmSDRldzhEa01WQ0VUQ0Fv?=
 =?utf-8?B?NzViblZzM3pqS3RHaXBPNFBBMGcwQmI3bnFtdUcyYjRDYk9GYWNEUGIzMlgv?=
 =?utf-8?B?YXdsdUlUb3FwbXJYNHZJVkVkVVdpNVoxZ3lSREo1RldqdVZLbmNzTXI2ZTRW?=
 =?utf-8?B?RHVkODRYNkJtc2thU0E5Y0tFU0tMOFRqVmp4UWtUeVFMS04xckJ2eThDc0sx?=
 =?utf-8?B?NVFjcHE0aFNYSVV3cnVxZjF5ZFUwMzkwT01oRklua1VtNDkwN1NoZzFLdFMz?=
 =?utf-8?B?WTR1NURGY2dqNy9LKzhKeXdYY2J5dHFvQnkyNS95cGErU1dLSEhLVGpmMUl1?=
 =?utf-8?Q?EZAQ8oAf3qTHU34LCrrfW3BeS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a97fa0-229a-40c5-7841-08ddf45dd8c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:43:26.4584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAhimZLdIZIgpthjvjuGLsb/bR5es7urlqq1qPuUyR0O6Ftt4jDaBQh/jgxYY03I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155
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



On 15.09.25 15:33, Alex Deucher wrote:
> When we backup ring contents to reemit after a queue reset,
> we don't backup ring contents from the bad context.  When
> we signal the fences, we should set an error on those
> fences as well.
> 
> v2: misc cleanups
> v3: add locking for fence error, fix comment (Christian)
> 
> Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 33 ++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index fd8cca241da62..72f0f16924476 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -758,11 +758,36 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>   * @fence: fence of the ring to signal
>   *
>   */
> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>  {
> -	dma_fence_set_error(&fence->base, -ETIME);
> -	amdgpu_fence_write(fence->ring, fence->seq);
> -	amdgpu_fence_process(fence->ring);
> +	struct dma_fence *unprocessed;
> +	struct dma_fence __rcu **ptr;
> +	struct amdgpu_fence *fence;
> +	struct amdgpu_ring *ring = af->ring;
> +	unsigned long flags;
> +	u64 i, seqno;
> +
> +	seqno = amdgpu_fence_read(ring);
> +
> +	spin_lock_irqsave(&ring->fence_drv.lock, flags);
> +	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {

That won't work, the seqno can wrap around.

I would just go over all fences, e.g. from 0 to end of array.

The checks below should make sure that we don't try to set an error on something already processed.

> +		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
> +		rcu_read_lock();
> +		unprocessed = rcu_dereference(*ptr);
> +
> +		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {

dma_fence_is_signaled_locked(), otherwise the function would try to lock the same spinlock again.

> +			fence = container_of(unprocessed, struct amdgpu_fence, base);
> +
> +			if (fence == af)
> +				dma_fence_set_error(&fence->base, -ETIME);
> +			else if (fence->context == af->context)
> +				dma_fence_set_error(&fence->base, -ECANCELED);
> +		}
> +		rcu_read_unlock();
> +	}
> +	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);

> +	amdgpu_fence_write(ring, af->seq);
> +	amdgpu_fence_process(ring);

That's actually wrong. We want the other fences to signal later on when we process them.

Regards,
Christian.

>  }
>  
>  void amdgpu_fence_save_wptr(struct dma_fence *fence)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 6379bb25bf5ce..f6c9decedbd51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -812,7 +812,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	/* signal the fence of the bad job */
> +	/* signal the guilty fence and set an error on all fences from the context */
>  	if (guilty_fence)
>  		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
>  	/* Re-emit the non-guilty commands */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e4..0704fd9b85fdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -155,7 +155,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
>  void amdgpu_fence_save_wptr(struct dma_fence *fence);
>  
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);

