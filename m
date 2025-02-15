Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B540C021A4
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Feb 2025 07:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB12210E185;
	Sat, 15 Feb 2025 07:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MdXFE+nM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723D910E185
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Feb 2025 07:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6k8pQtG4nyyySULaBF/JmornUMVlF8H+lA4qbjH9g54rSvIpiIwbNNa9fZTzYYgFSAwRjKleImxpHh/+xzOSlopDBAg7Ru8ojsEI2TLLQkOfKRrahN+fdDyTK27MlZsAOKDGKNA0IYPr5vuu0UYihmXRK+a9U3YCBFKSXEaP74jlXD/vtYE6ln2s06HUMmeM86josL8kP5yLbwL5s1bj0TtLEpqJMfyQ+lY7vY2Oa36fodBFlVmzgjZwB2nvhL3U6BSBHvOnlTYHkaCo//eypjGVUkW2stBhXDl0b07GqoczM7/5OnytHeGmEm/e7PmO/wXo9w81bljiizf2AbTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbWsiDmuDKS2o1STFHnwfPLTdXNkvaK6LnBsaDzp7x4=;
 b=JYbe7CAfrL+EpE5n+tTa30Iq0RzHfi+J/Fe6sKplra2JWiJO3vVT38WEJ9haWC0m6UlXcw9201xC5e31JURoIA3hz3PqqUCYwdi+L/CAxyxY7A/TtXyOb0nYWgmpxJv0FaM9c4WMUleTWFrqgqOWYp2sCyDdytPMBRLj5HuvZnrOxnZfEgGbnmmKUZqToxb/gc1XsM0YMPS5I+zshvkENhPyp2gus6b7A5Hq4QCjURFXce09lLBaTqK4vH81GDaz/ufJCQAjONqc7P4rtoslnnPxhhbmnyES4ficVhUvhHRCruDSHWiID78oiV99kpVkFZ0h9SqyZiGhPTZhKH0OJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbWsiDmuDKS2o1STFHnwfPLTdXNkvaK6LnBsaDzp7x4=;
 b=MdXFE+nMZ8JWKdIbZYT44fXcoHNIXjYjYjk7rjP06IhN/CTH7uL6I/b06b2BsJ56GRSlbqg2UQ7L6IS/6qIfkUXQuQJpUGMSEJ8Ap8bmKzqe+ZGdFVyVmujkFvS/Z8SWqsKSwt6CS7vC57DsO2H4s4TuoVjRa4+go8SdKCFJ6TM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Sat, 15 Feb
 2025 07:52:33 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8445.017; Sat, 15 Feb 2025
 07:52:32 +0000
Content-Type: multipart/alternative;
 boundary="------------SmWPHG1yuam604ShGIxTvztx"
Message-ID: <363007c1-064a-4017-abaf-a2b69bbc4679@amd.com>
Date: Sat, 15 Feb 2025 13:22:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes: keep enforce isolation up to date
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Shaoyun Liu <shaoyun.liu@amd.com>
References: <20250214173522.2373211-1-alexander.deucher@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250214173522.2373211-1-alexander.deucher@amd.com>
X-ClientProxiedBy: BMXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::17) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b48f4e7-a8d4-4571-c548-08dd4d95b43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmFseWIzcVhuT1UyV1JwZDQzQ0lmYkNiVGI0ZWtnMU11L2NreXFCYzFlOW5F?=
 =?utf-8?B?T2t4L2dXTGIzVVFUd25nSlI2emZ0ZDI2WDdOY29kRHJqeWhyWFBENVRQS1NR?=
 =?utf-8?B?b04zQXJDZEk4cmN4RFZTSysxeFlFVnZoY0FlTnB5V1ZxTnBQcFZaT0VuRkxY?=
 =?utf-8?B?b3JRU3VoNlY1QWtOZGREcGtlWGFXZnBTM0tja052TzB2Ym9reHFsamI4QzRH?=
 =?utf-8?B?NUt0UGpkQ1pEOHk4OTQydmI0N1Vtek9NZWdGempneSsvazFlaWI0YWlWd25h?=
 =?utf-8?B?Um1ueVNub25aak92OHJKNmh6OXpQQWROblBTcDRQbHBWNWkzWFptaWlWaGNX?=
 =?utf-8?B?VkwvUEd6YkZCMEpHVklLZldUS0dCTjVhMmNwbUFMWUw0YzJkNE9xUURIaEJK?=
 =?utf-8?B?NWZoVEgycDVjc3dhM3c3dW9TU0JTQWQ3NlJKZDFCSUw0dVVqVFJsK1VxTXJn?=
 =?utf-8?B?ZDNzMGtnZW9ZenRGUFBCTW93RGpQd0ZsRU9sK2xZdFB3U1o3NHh6Y0o0MGxB?=
 =?utf-8?B?ZGY2c1g4bnNZdFZBdVhuZkthcGNJUnplUW5Kbkk3MzFkOTBDcWVrTFhsbXN0?=
 =?utf-8?B?eWhBNWk0bmJBWGdjRXdLazdXWGxUTHVGWmFzaUZMSUE4YzN1Unhsd25oUGpy?=
 =?utf-8?B?Mk5jZGVVcW0wbUdjdXQ3ZVJvQ1lNRXo4K3JqL3ZHQUlla3E5NEwyb2hxc0tl?=
 =?utf-8?B?cUFFMm5seGJhb2YyTGplcVVLMUkrMlgvQ3JPeVRra0YyZzc5emRLYnFwaG5T?=
 =?utf-8?B?bEVDYXFwWjF0b3NsakFneHBhQTA5VkJ2SEkyNW4vTGJnaTBWYkF4UHRBQWll?=
 =?utf-8?B?NVNZOWRyWkZMc1p4SVRTV3N1UlQ0MmJwYTVkSEhlMW1nWFROckFMb3dBNUFE?=
 =?utf-8?B?UGJraFArNUhRRkF6SFVzNUd6ZGlRTjFoS29STER6d1RFNWVNSDdjcVI4ckJV?=
 =?utf-8?B?U0Q5bzdDeGtPZjRqVEkwU240dGUwSkNLWEg5c2w1ano5eHJ1V3RuNFlxdlRY?=
 =?utf-8?B?T1FnQ3ZzOTBrV3Ztc0NsdmpZTm5rZTdUOTNZTUYxU3pRaDgwM05lWDBIWnJE?=
 =?utf-8?B?Sm9RSFRvRDVCUWVnZ1lwQzJKUTdkVlg4akFhSEdScitXbTFxc3E4cys4bTNq?=
 =?utf-8?B?L0EzcnJrdjg1K2lWLzJWaTJ3TmdwV2I2S2pISU1jRm8zT2x1L2w5VVhMYW9h?=
 =?utf-8?B?aCtiOGcwSG0rbVBScVlqWTNZL2FwQmpYVDk3N2tnYm1tTUlCZzM2dmcyM1NQ?=
 =?utf-8?B?ZkZHY3R1Wkl1dnVadnNlMmc4LzZXd2JncE5NbE9TWUpzZTNzYm5UOXAwb2FZ?=
 =?utf-8?B?bko4UVhWRTRFZmdMOERja2NTaHJlZm5SOURsejRYWFZBRGVMcFBPeHpNcytD?=
 =?utf-8?B?dTk3OWM5YVd3Njd1K3llcXlJUEFpYVRqTTBxNzZNQzJHOXdFM1JWY3VJVmkz?=
 =?utf-8?B?ZnRxWlk1RWs3Q0lKRW9qZVQrWEdFbW9VVmM2ajF5L21NN3FhVVpXMFd3VjlW?=
 =?utf-8?B?ZGt1ZVU5bW9tcDM5c2VCYSttSXBjU3k5ZU5wUHQ1azM4L2c4T1FhUXdKTk9Y?=
 =?utf-8?B?TVV6bWJqQmVaWFIyd29QSlQrTWJnS0xBRzhibDhjeldsWHFlbjJZbHFnTDJH?=
 =?utf-8?B?d21xaGp5Tm1UUXZtR1FWTDV6MkhpRXJHWVhLUEx3cUgyTHZFK0lsQ2h3b1F6?=
 =?utf-8?B?cFJHdHJ2ankyQURjdldPWWZ4TGxSQm1wV3loM3JhSmRzTS8zM0NzdkRjT3d0?=
 =?utf-8?B?M2FpM1lzY0UzS0NqeGRaUHo5UWNMaDhRUHZLV3REUDBvMmtGbGVXUTNzZ2pR?=
 =?utf-8?B?TTl6ZHV0OXkybzQ5WURPSzEvQU1FRmZhVDRIMDc2b05VRFJXbC9vMjBsZ05w?=
 =?utf-8?Q?FxTAsjXh3YPvw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTNxR3ZyQk1zMmo4R1NWU3VscXNuRkJ4L2ZaWGxzY3VBd05pWkFaWUFtbWZj?=
 =?utf-8?B?TmkzV0lNM1J5d2ROdUQxMmNraWdmck04UWhLUm9yb1ZPMlNXbnIvL1gxVmpR?=
 =?utf-8?B?QUsrcUgzZWdnZlRrU0J3ZkNCSitGY21lU2JJQjdiSDlVZmRWS0Q5RUdhZWtE?=
 =?utf-8?B?aTdhL3o5RHhteGJYTkp6OHBlYnpFUTgxN2pXVG9VVzdNQWVFY0Q1a0xtcWlF?=
 =?utf-8?B?WlYxaFZtdDUzQkdwYjJ0ZFNNYklUUG5PRnozTUc1MzdjZHI4M1JERzVicXBC?=
 =?utf-8?B?UkJ0WHZsSWExYmdqZ2MxZFFxcFl6TTd0MzVRRE9nRDdBUHRPSjh2UVZaSnVv?=
 =?utf-8?B?RE5JcWdHbkVmb010S1k5Rm0ySnRodVVBQ1RCdk9zNDNFWjZ0Z2lxcGE0dFRi?=
 =?utf-8?B?N21aVEdTK3N0dk4xVEZHd3VPMjFQaCtUUE9hTDNuQitjRFJBQnpDNXphWmtB?=
 =?utf-8?B?cHN2aEdzRDNMUkpjMlBZeDlxR2dzcEJHN05ORlI1ZXhoa2JrY1NnZDlyOWxr?=
 =?utf-8?B?T1dTTmdveVduVmJMR0tneiszVTc2OGpVZGl5SXhpcHd1Znp2RG1MaExGTG1x?=
 =?utf-8?B?ZzFGNHAzb3pnN3RkUW5GQnZlNkVmeWs3NnoxeGNVT091b2lJZ3NONzVON0FK?=
 =?utf-8?B?L3YwYVFtdFpuQkxlR01EcEdPRmJFTWNtQWs5cTJNVTNkcHpuYTljT09udlhv?=
 =?utf-8?B?MmszRForTDhSekZvejVhQW1GZ1BFdHFTRWNkWE9WRThXTXBLUmp6N0d4djBn?=
 =?utf-8?B?Qnp2MVVTb2lYejZlZDI0bTRhenVkVlQ5S0NOVXRETFdTS2Q3ekNkQytBeGJw?=
 =?utf-8?B?Y3c4TmFMbmxXa3QvbUlBUHJHajZwaVJrWU8vQXRJTWExMjljclhHM1VMYUxT?=
 =?utf-8?B?aVZBcHlJT05oZzh0UGl1d1ZHazlTcUNwMVUyZ2RNR1BVWnd6L01WM1NuY1dl?=
 =?utf-8?B?elJqYVEyRHJSVDF4TkNOWitJYWdDdWFRbG9GdjhBanNJOC9DeWNrVDU1cXp3?=
 =?utf-8?B?NDdOcGsvaWtseFY5M1lIY09LVXMweVl5VnRLZ1lRc3ZySTRJUlpMU0h4a1o4?=
 =?utf-8?B?V3B3TEIrUU94T0p5Wjh5aC8zajJHMm9ZeE1aWGk0SFVGSjZYQllpMjdidFpo?=
 =?utf-8?B?OWpjTTJYOUFrbUMydlJnR0RSWDFCclVZQjhqWEZJK0dsNzNqMnBTT1lyRThX?=
 =?utf-8?B?KzBqZlBxYlh6Uzk4ZE9oVnBXZEdUazUxYWZtc0RwdGJkR0JIZWlHRitpTnVH?=
 =?utf-8?B?dmo5aUJyQzN5VnVubTNYalYvUTJTbVpUUnNuLzlkYnBTNDhPdE81N3g3bjBM?=
 =?utf-8?B?QW1DRWk5R3JGaExBaXE2aEpab1RqSlM2RU1iMEZGZnNVR1pJbmdtTkdZTVNa?=
 =?utf-8?B?T2M3czNXQkhuTmJFSjJRWVhDQ1FRS1lEOGhBTXMvVWdrSXluZDNBZ2NhOGRP?=
 =?utf-8?B?YlVHSjBGc1ppY0ZUYkF4TWVVbmhpazVUaHdLak82TGZoRnhmK0dDd1ZIeW9I?=
 =?utf-8?B?RDlUWTcrclZEQkJmMnBPei8wTkVZZFV4dG4wRnFzSFA1MzZ4cTZvYWwvMjh4?=
 =?utf-8?B?SUFGVjF6UC8yVmpTdERYVW9MN1dLM09udStrQ1JodzJVMEpPOWNZWDVMdyts?=
 =?utf-8?B?R0xMRktXdC9ZeGhXNnA3bzFzT0dQWmt5U1Z4NEFvUzN0TVBhNlFkczF1S2p4?=
 =?utf-8?B?NlF1T091dTJTQWxUN01sWlRaWGVEamkzK3ZTRGhBd0Vkd2lJcElndTlkSEN6?=
 =?utf-8?B?RnE3RXhKMmFwM3FpMk5yMVZkbVNVSThVampoTWp5ZkNrelhuZC9kNFRkNWsx?=
 =?utf-8?B?aFp6dmZ6enlXUkorTk5DOEJDVCs4aXk2Z3lqQnVsMXJqQlUycjgzNm13QWlY?=
 =?utf-8?B?bnBTVVRlK2JsaDd0L3dORllsOWxwcW5ubkxOUm1iWEdKdkk3YTYwOHVsUHQx?=
 =?utf-8?B?VTIza3dUUGl5a1V6YXRLa3dQaWJUWjR2SkxFT0NRVzR3d2VTZHlDSGg4U0NC?=
 =?utf-8?B?bGVjdU54Z2k4cVN0VEJYRHZvd3htWWNzQmV4c1lsQTMzTng5RjlZL3VhRGpN?=
 =?utf-8?B?allJM1NFREQvUmdhTDl5V256Uy8zc1UraXEwQlRBdXdlS1ljOGFMUkZ2ZDcx?=
 =?utf-8?Q?8XiuebXr0+iUT94CMTDU11L5l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b48f4e7-a8d4-4571-c548-08dd4d95b43f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 07:52:32.9075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfT9i9nQeCYE7L6pYZqAyoiE3BAifcuQWEZuoio/MZhEF00khGOPqQho8511C/U+KNX7DMIjaXmL8MulW5OG/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
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

--------------SmWPHG1yuam604ShGIxTvztx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/14/2025 11:05 PM, Alex Deucher wrote:
> Re-send the mes message on resume to make sure the
> mes state is up to date.
>
> Fixes: 8521e3c5f058 ("drm/amd/amdgpu: limit single process inside MES")
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> Cc: Shaoyun Liu<shaoyun.liu@amd.com>
> Cc: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 13 ++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 +++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  4 ++++
>   5 files changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b9bd6654f3172..a194bf3347cbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1665,24 +1665,19 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>   	}
>   
>   	mutex_lock(&adev->enforce_isolation_mutex);
> -
>   	for (i = 0; i < num_partitions; i++) {
> -		if (adev->enforce_isolation[i] && !partition_values[i]) {
> +		if (adev->enforce_isolation[i] && !partition_values[i])
>   			/* Going from enabled to disabled */
>   			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
> -			if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
> -				amdgpu_mes_set_enforce_isolation(adev, i, false);
> -		} else if (!adev->enforce_isolation[i] && partition_values[i]) {
> +		else if (!adev->enforce_isolation[i] && partition_values[i])
>   			/* Going from disabled to enabled */
>   			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
> -			if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
> -				amdgpu_mes_set_enforce_isolation(adev, i, true);
> -		}
>   		adev->enforce_isolation[i] = partition_values[i];
>   	}
> -
>   	mutex_unlock(&adev->enforce_isolation_mutex);
>   
> +	amdgpu_mes_update_enforce_isolation(adev);
> +
>   	return count;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index cee38bb6cfaf2..ca076306adba4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1508,7 +1508,8 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
>   }
>   
>   /* Fix me -- node_id is used to identify the correct MES instances in the future */
> -int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable)
> +static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
> +					    uint32_t node_id, bool enable)
>   {
>   	struct mes_misc_op_input op_input = {0};
>   	int r;
> @@ -1530,6 +1531,23 @@ int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_i
>   	return r;
>   }
>   
> +int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
> +{
> +	int i, r = 0;
> +
> +	if (adev->enable_mes && adev->gfx.enable_cleaner_shader) {
> +		mutex_lock(&adev->enforce_isolation_mutex);
> +		for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
> +			if (adev->enforce_isolation[i])
> +				r |= amdgpu_mes_set_enforce_isolation(adev, i, true);
> +			else
> +				r |= amdgpu_mes_set_enforce_isolation(adev, i, false);
> +		}
> +		mutex_unlock(&adev->enforce_isolation_mutex);
> +	}
> +	return r;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 6a792ffc81e33..3a65c3788956d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -532,6 +532,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
>   
>   bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
>   
> -int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable);
> +int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
>   
>   #endif /* __AMDGPU_MES_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 530371e6a7aee..fc7b17463cb4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1660,6 +1660,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   		goto failure;
>   	}
>   
> +	r = amdgpu_mes_update_enforce_isolation(adev);
> +	if (r)
> +		goto failure;
> +

Hi Alex,

Should this also be moved to mes_v11_0_hw_init. Please let me know your 
thoughts?

>   out:
>   	/*
>   	 * Disable KIQ ring usage from the driver once MES is enabled.
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 6db88584dd529..ec91c78468f30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -1773,6 +1773,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
>   		goto failure;
>   	}
>   
> +	r = amdgpu_mes_update_enforce_isolation(adev);
> +	if (r)
> +		goto failure;
> +

And Similarly here also?

Thanks!

Srini

>   out:
>   	/*
>   	 * Disable KIQ ring usage from the driver once MES is enabled.
--------------SmWPHG1yuam604ShGIxTvztx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/14/2025 11:05 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250214173522.2373211-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Re-send the mes message on resume to make sure the
mes state is up to date.

Fixes: 8521e3c5f058 (&quot;drm/amd/amdgpu: limit single process inside MES&quot;)
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Shaoyun Liu <a class="moz-txt-link-rfc2396E" href="mailto:shaoyun.liu@amd.com">&lt;shaoyun.liu@amd.com&gt;</a>
Cc: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 13 ++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  4 ++++
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b9bd6654f3172..a194bf3347cbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1665,24 +1665,19 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	}
 
 	mutex_lock(&amp;adev-&gt;enforce_isolation_mutex);
-
 	for (i = 0; i &lt; num_partitions; i++) {
-		if (adev-&gt;enforce_isolation[i] &amp;&amp; !partition_values[i]) {
+		if (adev-&gt;enforce_isolation[i] &amp;&amp; !partition_values[i])
 			/* Going from enabled to disabled */
 			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
-			if (adev-&gt;enable_mes &amp;&amp; adev-&gt;gfx.enable_cleaner_shader)
-				amdgpu_mes_set_enforce_isolation(adev, i, false);
-		} else if (!adev-&gt;enforce_isolation[i] &amp;&amp; partition_values[i]) {
+		else if (!adev-&gt;enforce_isolation[i] &amp;&amp; partition_values[i])
 			/* Going from disabled to enabled */
 			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
-			if (adev-&gt;enable_mes &amp;&amp; adev-&gt;gfx.enable_cleaner_shader)
-				amdgpu_mes_set_enforce_isolation(adev, i, true);
-		}
 		adev-&gt;enforce_isolation[i] = partition_values[i];
 	}
-
 	mutex_unlock(&amp;adev-&gt;enforce_isolation_mutex);
 
+	amdgpu_mes_update_enforce_isolation(adev);
+
 	return count;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index cee38bb6cfaf2..ca076306adba4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1508,7 +1508,8 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
 }
 
 /* Fix me -- node_id is used to identify the correct MES instances in the future */
-int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable)
+static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
+					    uint32_t node_id, bool enable)
 {
 	struct mes_misc_op_input op_input = {0};
 	int r;
@@ -1530,6 +1531,23 @@ int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_i
 	return r;
 }
 
+int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
+{
+	int i, r = 0;
+
+	if (adev-&gt;enable_mes &amp;&amp; adev-&gt;gfx.enable_cleaner_shader) {
+		mutex_lock(&amp;adev-&gt;enforce_isolation_mutex);
+		for (i = 0; i &lt; (adev-&gt;xcp_mgr ? adev-&gt;xcp_mgr-&gt;num_xcps : 1); i++) {
+			if (adev-&gt;enforce_isolation[i])
+				r |= amdgpu_mes_set_enforce_isolation(adev, i, true);
+			else
+				r |= amdgpu_mes_set_enforce_isolation(adev, i, false);
+		}
+		mutex_unlock(&amp;adev-&gt;enforce_isolation_mutex);
+	}
+	return r;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 6a792ffc81e33..3a65c3788956d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -532,6 +532,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
 
 bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
 
-int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable);
+int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 530371e6a7aee..fc7b17463cb4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1660,6 +1660,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 		goto failure;
 	}
 
+	r = amdgpu_mes_update_enforce_isolation(adev);
+	if (r)
+		goto failure;
+</pre>
    </blockquote>
    <p>Hi Alex,</p>
    <p>Should this also be moved to <span style="white-space: pre-wrap">mes_v11_0_hw_init. Please let me know your thoughts?</span></p>
    <blockquote type="cite" cite="mid:20250214173522.2373211-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
 out:
 	/*
 	 * Disable KIQ ring usage from the driver once MES is enabled.
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6db88584dd529..ec91c78468f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1773,6 +1773,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 		goto failure;
 	}
 
+	r = amdgpu_mes_update_enforce_isolation(adev);
+	if (r)
+		goto failure;
+</pre>
    </blockquote>
    <p>And Similarly here also?</p>
    <p><span style="white-space: pre-wrap">Thanks!</span></p>
    <p><span style="white-space: pre-wrap">Srini
</span></p>
    <p></p>
    <blockquote type="cite" cite="mid:20250214173522.2373211-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
 out:
 	/*
 	 * Disable KIQ ring usage from the driver once MES is enabled.
</pre>
    </blockquote>
  </body>
</html>

--------------SmWPHG1yuam604ShGIxTvztx--
