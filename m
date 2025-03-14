Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D820DC28B2F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 04:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6952110E28D;
	Fri, 14 Mar 2025 04:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GRRw1Yn3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0410810E28D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 04:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veW1Sr4DGEfvtYM3yO93A6ZbhR0yOSoP0s24wvS5TXN5uXs9J8NZVnIPRAEUNIw3sFpfrLPZ+ZHMnv67h8839G/oh5HTIBKAg1wC1H4z9yITn1aQDSHIKcvytLuFdoXyV9R3qWOZT1EnjUV1iJKcEySN5/7eqgRFLIyS850QHnkVG/oL6uUsBOZ5QPr+HTrrTIht3tZGxhttM37fhKYkxzj0/KmFp1xFxWZiiLVHZAiFdavD0SbMcgj9UvQ7aFGk6flQ9dYYEZSKX0xAOoPyJWXO95KpgoXwKjHYA1JyrrKBGo3Ectj8H4J1M88vtnQjLTvzVH8ngEWQmhkBkn+Xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhNtOMoluo2CE8a87LJiFgvSMQFTRyIHQ+bXmgXe5Qg=;
 b=tU7ntr3CgElg2iFiYUAjCTmaMhYREA+7u1nkH82bxkbOl9wiiWf+M7acpdoOlFKYtuNTtDZpJlKhlTTRHRX2EDZ/ZQcKalXXWvilXeKexO/0za0cvEm2/DnX3/2/AIKFp6RrQ8UY5quE8pMgpOWsUNHgYxokc+MN6SdC+qKBi2aynr2RhLFz1Hsqm+NyRDnNmMzSra1VXuYT/WPnWcG9N+kUpLnlo5zm4hrifToGBCSfNOjGEBmNg0KzZtrhiYd1R0OyHJ8DkY4XEh2qu51MoNk3FK0gwfHDUrYRW5yqqUfXd+c+wg5GWWaB5tEHkUvoJ7fM+qifPUqeBnjjYCwY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhNtOMoluo2CE8a87LJiFgvSMQFTRyIHQ+bXmgXe5Qg=;
 b=GRRw1Yn39c+C8U4Xg0mSUqJfK+3wr9VSnuQFJlctdR4AwNRTZrg33UKcKZZ3Fjnwafa7cFzG0zq0h1UUYKiVzgc1qxQi/r8MBNbpFshJs/JPpNjwFxPMuzVu3fP6FjkjJz4WwRZ/DsPsfyCMHCQll8PINwZz2pvJK7hWHkcPdnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:09:08 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:09:08 +0000
Message-ID: <de0e6edc-c3a8-4c9f-b0f3-37cfd8776db5@amd.com>
Date: Fri, 14 Mar 2025 09:39:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: grab an additional reference on the gang
 fence v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250307134816.1422-1-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250307134816.1422-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS0PR12MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: b4471ca1-05aa-4a8d-4bfc-08dd62adf7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2VscHBYdDAvYndFZGs2MXkxZE9vK2Z1YnVIS0cwOW5mc2JGZy9lelJJTmlu?=
 =?utf-8?B?eVM2dDJNL2JuNUVMRnhYbTlGU2FQbTlHd0ZsWkU2ODU3QXVvelU4UXVkc2ZD?=
 =?utf-8?B?VTlKMzhaRTR5MkRlSGdmSElkdjRRZlJ2encwMXRvM0p1TzFVZHdZSHZmQWhX?=
 =?utf-8?B?T0plWmtXRk9ZVno3c2cxTmtXMWdNcjhZNFNaeGVGVzFHRERzU3JwNWc2K01p?=
 =?utf-8?B?Z1ljSC9STlZ1K2lhMDZReE5ybUQrRXFjdFAwbCtta0J5K3ZKTGlqTE1mUkR6?=
 =?utf-8?B?ckprWUdJUTlQYjZtSkEwaU5reWZsQ2pCTzFqcHlhTUcxZlYwb1NTVnVCVWw4?=
 =?utf-8?B?a2JIVXhTeVhoTHovV25sQUFlTU81czVTcVhCSE5pbWxoWnpGMmxpQ0lycjVQ?=
 =?utf-8?B?ZzRUN0JvTVVJeHdNeC9Cb3BtOXorUGpteVVkeTV6TDlzc2xOUTY0ZUttZDd6?=
 =?utf-8?B?eGlCU2FROGdCR0lJMGZ6NzI4UTBDTUlWTjluamVlMjlCM2ljV1R0NW9FSEU3?=
 =?utf-8?B?YmJia1MyM3c2WU1LUnhNZ3M0M1JxeW9VU2g0NS9DRVZIYWpzcTdxVDIxLzhN?=
 =?utf-8?B?ZHp5YTFBT1JRZHlQdi9EMTM2QUU2Q2dnU0IzVFdRVkZrdVl1TmhmRzlXd2Yw?=
 =?utf-8?B?a1JianRSTEZWTHJnbkcxTExydUhqQ25NRGN2eGJ3Tnlibm9Bb1dpQXVjZlgz?=
 =?utf-8?B?ZnhYNys2T3plWUlsSlpkSVBxNE94d1pGUktRS1hFRU5zVUhoWFRSWGQxTVl3?=
 =?utf-8?B?N2hNSjExVjUwaElUeS9PSjFqRU9DRWNIQkVvVk83WDEzQ2NmSGZKK1dQSGRX?=
 =?utf-8?B?TytoMC9UU05RT1pWVWVjREhDZ0IrcGlHUEpOeElDaTZpdmFLbS82bGdtWG0z?=
 =?utf-8?B?Z01YNHp3NWtzNlRZajMrVVRYUzJlY1NLWU9YYUlFTTBWQWxnaytXSmQxNUVR?=
 =?utf-8?B?UnNFdFM0VUc2U2VmNkp3aXpoK2ozeDZVak9lV3BDRC9wM25pMnQzOUIrR3Bk?=
 =?utf-8?B?SUNkOURqQTZBOXc1c05ETVlrOVF6VWtUWFY2RXpQZzhZTW5oWFZ2REU4Sktr?=
 =?utf-8?B?UXE2QjVwaFk4TjlsTURSUFFZeFV4MnZTTGY3d3RrMVNXR09QOTNWVmFNRmMz?=
 =?utf-8?B?RncybkZPRGx4cE4wM1M2Znc5ZEU3a29ad2FXWUFZUHJ5Z3lZdzJjTlkzSHpU?=
 =?utf-8?B?cjY4ZkFtbCt0Z0I5OGd2UlEzWWJDQ0JFRktndlJPeG84VXFLUllDWHNkM2gr?=
 =?utf-8?B?bDNhR0VnTzJPTWNLSTYvbThKU0NrSjNPMzRkdHhZb3hsTTFacmdyY01uWHcz?=
 =?utf-8?B?c08yb1FJMmtEcUwxZnpHZk9zSjE4S3hQemhqeWJhTHlwMk1ZK2Y1VFd6VG9H?=
 =?utf-8?B?Rmp4WCtJcFc3UzBIWDhiQzU0UXIrcUM1cFF0UEJqYVI2KzhobXJsZ01zZUNW?=
 =?utf-8?B?LzlOM2dHbGR3cXlrL3F1RmRtR3hFam1qS3RNOHZXZVVSSEtUZEFSZXFUaU0v?=
 =?utf-8?B?WWE0c1g2alVsa3lkU3ZOTHl0N1A3Q2NxWWtJbzNwMXVuVGx5UmJCZ0hOZ3VW?=
 =?utf-8?B?dW42aHg1djYrZDdzSkw2eXJaajlJQzhHWktSVjFEdTBNVlVLOXd4TmpQdCtl?=
 =?utf-8?B?THEzRVlXNjd0cnc2TU5FY3pKNENoZW1uZVVQRUY2bFBzNWJ2M0tGU041aFNV?=
 =?utf-8?B?d00yMENyVVFYZXBKZE1ISldKWVljNS95V2RxOTdKN2FFbzVNNGZQenFSWEZ3?=
 =?utf-8?B?NWlvMkx3VVNEMTRNREZ4N29iVHc0eTBlSHBaNkc2T0FoZXllVTQxMUlPN05W?=
 =?utf-8?B?TXNkTjZGaG1YR1hNNlliZ2FodVRFWmRHWnU5V2xYeEZ0aUo4Y1NVUjd6SlJT?=
 =?utf-8?Q?ouT6AXM66c4A0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkdLdTZPZklUYmlJdW5CTVF4bmU4NE1xUnl2N2ZHWXFzUHpCVDBhZm9GZkhO?=
 =?utf-8?B?OEN4MjdJdGlLTVFYSFRUTEcyODZscjJselRId0NVRzZBSE9SQjd4Znlsbmk4?=
 =?utf-8?B?bFNVWmpSWUh1ZXdsdnl5VXZtelc2aDJPakE5ZWYzUklJS2JtcWY2ejZuK0ZC?=
 =?utf-8?B?dExUejNLZERnaGE2YjhZTnhMRzN5ZzZjUHFyU2hSakcyQUtFSjRRbmRSVWNh?=
 =?utf-8?B?cHFvY25sOG1laUh4bFdTOWRzQ05vdkxmaGxlZWtyZEwxOEpwL2pCUWQzN0w1?=
 =?utf-8?B?bTl3aGNLeEJpM3NNUkxLb2pSN0RrYnY2MnovMFhhbWxTSzJXUkNDYkxEenUx?=
 =?utf-8?B?MFNXbWhyQnp0MzN4VGwyQU9aU2d6cGJ4bFRpSHhHQjZZMHFZcFJ5SlFsREtz?=
 =?utf-8?B?aDFEeEJBWHpOaHUvQTlrcUZRRmV0TWtIa3pqd3dxUFF2ZUx6UTAzL29IVzFk?=
 =?utf-8?B?bHZzUThJeW1PTlR1NWY2R2JnVnpxSTllUUExZHBrOXhtVWl1Q1BmY2dTOWl4?=
 =?utf-8?B?S0ZIL0hGWlJVdjRMT1J5MVlSK1A3NzJMY043S0kzMG9Ialp4a040MWhaSmZv?=
 =?utf-8?B?T1lraFNPRnozR1RXZmhZd0JsR0p3VzVmL3hPSXlQWEJ5cHhFUmF0a2g3RHp1?=
 =?utf-8?B?akg0NVZZOXY2dXd2MWlBcUJXZzlMQkM3R2R4dVB0RnhtMHZQN2RhOVljcFJs?=
 =?utf-8?B?OUlabTJxdkF4Vy8wZWpzT09lTEVpRjRySzVsaTdSUHI3Um1UWFRic1p6K3RU?=
 =?utf-8?B?Mk1rVldTWEsvRzN6K01leEtaRmozZ1NDMzhrbk5pWGpubFIzRGlZWlRUZHpU?=
 =?utf-8?B?Unl2QmI2ODlyVXlOY3JQTzNtOW1WMXdFV1VwaExhSlcyMHJOSGxtcXljRWNY?=
 =?utf-8?B?V1NWVFNFc0lDRjRrUXF2ZlVzY1ByZmFSWE5vSFFQOHVQdWxpNWEvMU1acGI0?=
 =?utf-8?B?OGpCODk4REJHdEcvZUREZlI0bmhEYUV6akF6MGtTdmdJWjNxL0pHWWxXVmhM?=
 =?utf-8?B?dm9ZOExWQlVzdmRXL1o2ZFo5WVZGU29LSVR6WTF1N0JEaUR4bFNzRkt2dzE2?=
 =?utf-8?B?NDhsVHJDUjIxQ1BGb0hXN2lKeHhXRW9udHlWb09mOEgrdStRZ1BKVEJ2WlE4?=
 =?utf-8?B?cDhRN2ZNekZveDlhaDRuakFCaWlxUnJScXJFR1l3djArM1VWRlVIa1Arb1dz?=
 =?utf-8?B?aDFkUVU2Vy9kNnpTUnBnWjR0MmNHNFg1cUg3SHBrOTdwTzc4WVVBU2U2WVFM?=
 =?utf-8?B?SDI0K2I3WWtPV1JyZ20zT2ZHQzRSVCtoR3dFOUlKOTRPdytXYk80aU9HVmxH?=
 =?utf-8?B?c2FrRVM2dXp5ZXNYU2FUa0Z6VWtKTkwxWWdVdEVqeFlxdmtFZ1drSUY1VFdQ?=
 =?utf-8?B?MnRKS3hwZUNEY0VpVTB6MXNMd0x0bVYvWkhwa3psMlNXeGkyckE0UlJuWU1a?=
 =?utf-8?B?U0NscW82UkRMeDlJV0cyaDM0anlwNjB6QS9LUEJXQyswZUNVODNkOTRWeXhS?=
 =?utf-8?B?dEVvL1ZORDBPNG54dEpPbFE5anVlUnVCOEExU3hDRmVjZFNROENBeVVsUElq?=
 =?utf-8?B?MTE3UDFNd1JLUTZPeFNZZEZoMkY1QnNYNnFUQjY4U0d5bkQ0eGNMd09nQ1dF?=
 =?utf-8?B?SnR6U21XL25BcDBjYmdQOThDbndmalRwYjlLaXRoSElGV1pVbUZEUU5JMGtt?=
 =?utf-8?B?cHV5dXZzWHQ3MHN2UUFCcVp2TzVGYVpNTllTdXFSRkV0b0JXVms3UzQyMGdp?=
 =?utf-8?B?L3d5SytLMTFCckxIQzE4ZEt5d2UybFM5MFI3cmxyQVlic2t2eU5YQmE0QmhH?=
 =?utf-8?B?S04yTnQ1ekVkY1ByWTJ3VTJXS0o0elJlSVNoUlFNM0pFSlg1Rk9wN0Q4U1FL?=
 =?utf-8?B?SU1VM2hGWmNUOHpKNjU3U2cvaXY2M0F3U1hrM3IyUU9jS29BUVk3M0tQYW9U?=
 =?utf-8?B?RHZTNy9qNllNTU1VdnBqeXllT2xLaVBNSVpGa2VLNFU4cUZNTEZUTXQrQmhi?=
 =?utf-8?B?NEVkdjBlNVNHc0FJVmlTdWFqZlo3bTFRTEtKb05jeUNISUJDV1c1aXZZS3ND?=
 =?utf-8?B?K3FNY04xdThwbHluajh3M3VvQlhLN3lFbnNtbUk5WGxlK24vQ0JZTCs1NXpI?=
 =?utf-8?Q?q0vn7kuRSK/1zVJdYj35jOf+n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4471ca1-05aa-4a8d-4bfc-08dd62adf7c2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:09:08.5444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuWRw1pYsBhJ1O8bQo/3jmq3O/U8rljqAmAdqJAg1EktGR4sa/7VWSr85DjK97qXcj3DZawB1bKzqpF+AH3+gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
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


On 3/7/2025 7:18 PM, Christian König wrote:
> We keep the gang submission fence around in adev, make sure that it
> stays alive.
>
> v2: fix memory leak on retry
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 198d29faa754..337543ec615c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6889,18 +6889,26 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>   {
>   	struct dma_fence *old = NULL;
>   
> +	dma_fence_get(gang);
>   	do {
>   		dma_fence_put(old);
>   		old = amdgpu_device_get_gang(adev);
>   		if (old == gang)
>   			break;
>   
> -		if (!dma_fence_is_signaled(old))
> +		if (!dma_fence_is_signaled(old)) {

Here, should we need to check ?

     // Check if old fence isn't signaled
     if (old && !dma_fence_is_signaled(old)) {

> +			dma_fence_put(gang);
>   			return old;
> +		}
>   
>   	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
>   			 old, gang) != old);
>   
> +	/*
> +	 * Drop it once for the exchanged reference in adev and once for the
> +	 * thread local reference acquired in amdgpu_device_get_gang().
> +	 */
> +	dma_fence_put(old);

if (old)
     dma_fence_put(old); // Ensure to release old reference  only if it 
is valid?


>   	dma_fence_put(old);
>   	return NULL;
>   }
