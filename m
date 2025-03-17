Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E968BC28B28
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 11:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684B610E098;
	Mon, 17 Mar 2025 11:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jXK2Czqb";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258A710E098
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 11:02:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIrbiihomZIVQNuxkf53xWheUDmqUPCXNn+qPoBOsdJFB7KXNokE+ITdgU/UH83T3VkFIKzR67s1SVyMlMC1wxN/IhvKPyc0+gG6DqWBU3JONC8AdQel8gh+1+tbWAUSvqQLKWTJWuC5jmXTRPjA+JEdKvY/31yFv+F3rnG1Cw7FoMrThVYmP0iiYTAH0LXgfxiYSar5iBryWvCiKSHe/VDlv7supafanmnWvfPqt7CD9eSf0cUdsTARl2DBBjgujUo0KZ63OeaHO5NTGult+O8qpad6yZA+zhjGy8ABguPP011MKuQhsmAImNgmMDiPWlAEZ/KjU0MOEu1rbA7DXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z81Kudf8s2mfUa0H1KGhwfW6Gs+Fal0f/xyvSZ72czA=;
 b=rFD2MceSkT68jd1qEfgnuacagtaua51geOV48SoMlB/5j8oAsQEx0SvZh6iXdfVC8KgNxnW0uMfvuBavZ9XTY6R9hyF7RS6MjGgnPb2IawWTnruEZcGu6Ey9fIK76AjWRzidd8PSlerA0L6z/XDClqYXR2kEzm34c0KgzC/wnUWkh7oJN5hj5GXIsjZvDD+DfAURbSMYRyXz/xtGdaaSLMrSBtOsz7mL243Keh4ivOSJ9uTeRUDCb/GqL1U5iekl98PApltXJ90u6udoTQzOhYbH5eo5Q/pKwwNVZCa+L0JVXVjo1fUAIqr4q3fas5dssYMnslSOhVcR+sPYlTeRcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z81Kudf8s2mfUa0H1KGhwfW6Gs+Fal0f/xyvSZ72czA=;
 b=jXK2Czqbwl+lihWV+XIcVLX9xgUMHlgD640nS+t2wD/xsJSiG3YWzSaGvLsaglrstTjz0Oz3L4yc+t0opeWlNQBYXGfGwQPi4f6QXa69bzIzzf2c4DbiXuGAW5K+2qLkeT16w8jTn5Vh3Gyr3aUesIVm8fuwj4Mous/EFYT3VD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Mon, 17 Mar
 2025 11:02:02 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 11:02:01 +0000
Message-ID: <409bc442-cf25-4a5a-862e-6eb8376c0584@amd.com>
Date: Mon, 17 Mar 2025 11:01:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: set precise mem ops caps to disabled for gfx
 11 and 12
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250314151416.726789-1-jonathan.kim@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20250314151416.726789-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: d33c26de-a21e-443e-87c6-08dd65432506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFVQc1NkSlQrMDlsa05TNkQzSjlJWVhYMkNHODBsSXg2SDVrZURIZ0g0Y3pp?=
 =?utf-8?B?TExRVkF6cUhJVWYwSFBheGFJam10TkFVZDNHN1E1REJzVXdzOGRxd1hqVEtY?=
 =?utf-8?B?Uk5rZXY1dGlWNDRUQ0VKRnBlRkxxd3Fodjh4RE0wMEY2U0kyYklqLzFTenJ5?=
 =?utf-8?B?NFpVdWlTeEdRMjlPUTlPV0t6TlRWZXRWTGdxYlIvYVp3bDNMbTBaMDBPNkZN?=
 =?utf-8?B?Rm5GWFJmMDlOeEFlR3A0RHdvUklTektZS1I5amlBZXRPVzNobGF4VUxXc292?=
 =?utf-8?B?MTlaenZVL0F1YTN3cHNzVk9BL2dSVnErbDNGeFFUY3NtRG9YWUpzWTkwZmtE?=
 =?utf-8?B?amdwdDZkNDFrNWJLWHdkOFNOVUt3WHpkVGJGR3FSbVZsMjA5MDJGcHdUZ29R?=
 =?utf-8?B?OHA1VlZBcnFOR2d1RWxubXlsZzZua1FjYnhNdlE0ZHpxanc4VUNWLzZXUHlP?=
 =?utf-8?B?R29kSUFnejc2TENlMFN0UHZpcXJ6OHc0K3ZucFk4NVppcUVoUzQ1Z3FZQkVj?=
 =?utf-8?B?OWJJei9RMjlmMUpPSGpvaVp3NnpEczh2VzVpSVZsaU5pcnR0ZHBnQ2ZQKzU2?=
 =?utf-8?B?Qytqc0xpU0pNQ2FHandiN2NZc2xUUTM4K2lmQ0VnUkFPWHdnMzI4LzdqcEd4?=
 =?utf-8?B?ZU1hakxOS2dDTmF5ZkhobUthMFFvT2ZrSS9MS3gyZ1hQTVp6U21DYXJwbWp1?=
 =?utf-8?B?ZURCUTRvVHlZWlJ2elNYNk5qc0h0NENmMDY5LzhhQTloL1F6b1JhY0lTZDVz?=
 =?utf-8?B?Z3FJMDJMU2tJS1JsRnZJK3Jja25vQ0dnZWZRekUyQVA0ZlNSQWJsUVdQNm9N?=
 =?utf-8?B?dnV2L2tZcnIyOFpFT2FQV0llakhDSUpWQUUvbXlkb0VPWmRIR01GdVJIVG5w?=
 =?utf-8?B?clZLK0cxN0dYZ0hXdGlmeUpoRitIcHB3WGpPWmRkS2JkRzJwMFFKVXE1SkJF?=
 =?utf-8?B?UjdXZmxveW5YNkVsS2VJNjh1cnU1aDhkNWp1dkpqMTNBU2MzbGo1WU9zQ2to?=
 =?utf-8?B?TWkyUjJUN1lUbkswYUJib1dVcTg1VldnZ0drVjBxL3YzNkRZSFFiRkZuVGhv?=
 =?utf-8?B?cHNUNkc1Q2FaSkZvcCtJZE56TWk2N2xINmd3WFY1dVdLdEpjMDZMUWdlZCta?=
 =?utf-8?B?Z1ppT1dYVWw4cnlFUkJnaG1BMzVkbi9VckhZQWRkZGxZWVVKS1ZKbk1la2N6?=
 =?utf-8?B?cHhSKzliSnJ1bWgxSFB2OG5hUDFkeVpSZUJJSVV6NkN2SVYxd21iTHhPRTQ2?=
 =?utf-8?B?UHBNV1hwOTN5OEp3bWpqV0pJVHNKTUgvOTkvSCtlZmpOcVRLSkdDQ1BjMjVR?=
 =?utf-8?B?T3kvYkpLZmQ4TnMvd1ZTR1ZPZ0RtbmVUbWZYM0REK2Z6elNoT2lDSWFMYTNP?=
 =?utf-8?B?dXFTcUVQKzdyOEZsamxEekVZVVovOExLKzZJbGpzTHBGc1FFdmE2TTFUd3I0?=
 =?utf-8?B?aTUwbVBHNXpUdi9TY3UxWm4vMVcvZHBjRVNUSURBSm9JT0kxZ2R5UGhpQ05i?=
 =?utf-8?B?dnFOTWdFNlVuakNRYk0yTnYrdmR2eXBJOFd5blYwd0hFeFhlMTBGYkY2N25h?=
 =?utf-8?B?a0U0aHl2T04rUkMwZlZGd3grUEJyN0IycDlMeE1MS01LQUtHT1QySy9UVkYv?=
 =?utf-8?B?ZFA0TjMxWW96YUNzdzNiTHVMdzVDTXJhMGF2NEpLL0tVTlpTVW5rWE9mZmI4?=
 =?utf-8?B?VWcvclVNTFlpSDIxZXJFQjdNR21qVFFKbTB1T05maTlYbE14YVROWmJDNE5V?=
 =?utf-8?B?ZUtwS2RiOUJvM1ViZDR1RENvSzRPeiswajdTOUZ0WXJpZnh5S0RXLzNQRTV3?=
 =?utf-8?B?TGtXanlWRlZpSjdya2lGT3JLeVJwdHVGRllaSmxlNVh5ZWttQWtnQnBWVlZY?=
 =?utf-8?Q?Yy1j8Qqv7fRvv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9zVTVUVnZ2SXQ2Y0FvUnZVcnN1WC92MlpabGFzSGFyNXdZdXBicnNkZ2pB?=
 =?utf-8?B?b0U1MlYveGxhMlFqd0taQ1lyZUUzWGIrbU1KNVV3elZ5em05V24wN1BTUlFw?=
 =?utf-8?B?bTZ3UURPcjRLeVBKYnBQeDh3OVZrWTl2a0o1V3hPSHpOUDNQRkVVbHFUd2hW?=
 =?utf-8?B?bmY2ZllVKzBxb3RYTmwwUzNBeDkzc29qSnJ0Wmh3aG1aRXVQS0JPVFlsN080?=
 =?utf-8?B?L3g2WktHb3pIeXNwNjhlWlBNd3pHc3N6bDJFVUgyNlAvU0RrcWdpeGNlMGpC?=
 =?utf-8?B?Q1IxUkJKa0J5VitqV04zeVZ5Ykg4TWlPUVpxVnV6aEY4UEJUVGk0ZVM5QXJK?=
 =?utf-8?B?dDhraGEzbjRDZDRMWW1MQzAwVWg2Q3kzUmQvdG9Yd1FpeFltTEJFMVF6ZDlv?=
 =?utf-8?B?WmNDczh4Nld0ZXA1bkRUSTdESjZBeG5sQWk4azladEhYbXlxYTZBSDF4Uiti?=
 =?utf-8?B?bXBGVjUrdEg3R3Q1WitVNktpaStiWGFJeENoS3pHdVJhY1FqUE80SGhoWVZE?=
 =?utf-8?B?bjFiaDNEUWRZbERnakNIWHBwQXVEbnpmOHh5Q245ajhsVGpOTFYwNk00aS9p?=
 =?utf-8?B?T21ralExSlN0TjhMbWQ4Qy90UEc5b2IybFJrd2l0R1hrUXRXbDZuTzlMUEx4?=
 =?utf-8?B?ZUtQQmY1UFpJVllwTE56Z1Bka3lZRkRmRmx5OHowSmo3Q0IwSG5ISWcyUTQr?=
 =?utf-8?B?elZQTXUrVnBkRTJyMWN0OVVyZURWSEs2UEpIYzU5RGpWTU8xbklheFVnNVBw?=
 =?utf-8?B?UnF1WlhFajZkbHNJOGdlb0RXUmN1dVI0M0Z5bnBONWlvMXRLSjBGaUE0QVRS?=
 =?utf-8?B?TzZiUXNZM0pTd3AxU2ZaY0FJS1dWeGVFTDd5Y2Q1dFV5ZUNVbTZVdk5HWncw?=
 =?utf-8?B?dkZJWUtDanA2clUrOEl3QkFUcEFrUklJNThwVkRLdVh4TFoxcHV1Tm1FS3o3?=
 =?utf-8?B?MVZhSCtObUU2SGMzV0RGdTJ1Yi9HL2dmaWJnMi94emJFRkgrbmVpQ0dDcGZF?=
 =?utf-8?B?LzVjMEVsc0NWSkNvV1ZSRytMaW5PMC9jekZ0QXRKbUd4SDZZYnBqVlVQeFIv?=
 =?utf-8?B?a1hvN24zeDRaTlFwV1paUXNIb0ZPbGRYSVNYekVTMU44azRZTHV2enNubUhN?=
 =?utf-8?B?K3RZODFRRDh3Zmg3OS9DanRQNTJ6bGFXdXJrTWxyTjB3NFZITkVzUXZiejFX?=
 =?utf-8?B?SFJhMUtyZFd2TWt2QmNGYjBrSDZPUDUweFhrU1NXTWp4Y3Jwa0hNdFFNNmRo?=
 =?utf-8?B?YWtsQlVlSkVSaUdYQ2U2L3dDVjRoVndzbXpnS0JnVXNobmNLWDMzbzR3ekp1?=
 =?utf-8?B?UFlaeXJMR2l1TzY1ZWEvY3lRWHZwZjBHZUZsM1JNTytGSmRNZUJ1UFpWYnpq?=
 =?utf-8?B?Y0tZcEV0NDVMWk9XVStHeWUrbVhxZXp4QzU2c3BvZlVrbGZ0ZnVSdktkZ0lJ?=
 =?utf-8?B?MXBENlVoaDlsWWhVd3hiMTFJMHVtUGE3SHI5RVh6bTV0cldQT20rcXNCZk1S?=
 =?utf-8?B?Q0tWZ1piS0NOMHVWZFJSVlkzSS9ScFNKZFJRQ3N6YTJPUDFtcEIxVUoyZ3RS?=
 =?utf-8?B?dlgxVTFQWERpNUxpdHpSUGVKZ1ZsOUpJMG5ISG5PUGpNSmpyazJyQzZxUnM5?=
 =?utf-8?B?SlNIYWxpYkk3L1JGSHpqbGU3LzJvSTFoZWRlM2ZnNy9nNlRCU0IyRnAvUDNF?=
 =?utf-8?B?RURKTGdwN0lwSmFQS0FBdVp0alJCOWI1cVBKL25hbmtxUUJpS0ZWZTBCdmEr?=
 =?utf-8?B?OGJVVTFac0tsUW5wL0tvU3VLQ1B1MWViNXJybi94U1lkN29VS3ZMbm1lbDcv?=
 =?utf-8?B?NHJ4RWNaU2oxaG12K2VtT1lwY0M1Q3JEVFFpNmhqNzZmakhubjduaXdRNWg5?=
 =?utf-8?B?cUNzS0FyTzY5TE5icDMrK21oMCtWODdtSXo5YXFkZGxJczJIZm84OEJ4U1Rn?=
 =?utf-8?B?V2JHb05kK3dDUGJpaHYxOUx0N2kxdUNtODBqb3grVEM4RUVLMGppMXVicVEv?=
 =?utf-8?B?NzI1cXgxRHFZaVFSOEdUQVVZNzJJQVBSQWNBc05rOFpQdWE0dnhJeDdmT1ZH?=
 =?utf-8?B?Wk1RdWVvditkRGdiSUp5Z3VSc1lkWGdweVQxUndIU0Fxbm1yTVhMOW9kcFB6?=
 =?utf-8?Q?ruJgHnwWGyB17t9cE+fGJgVNr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33c26de-a21e-443e-87c6-08dd65432506
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:02:01.7322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ebYc4/qiJsdErQ06voNK1wwyyvnUJGhBRkBzHbKMqqRcwYOPpa+3L4NsH/NZfATM5u1qH56RZgdLJCAGsTSgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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



On 14/03/2025 15:14, Jonathan Kim wrote:
> Clause instructions with precise memory enabled currently hang the
> shader so set capabilities flag to disabled since it's unsafe to use
> for debugging.
> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Hi,

I have tested this for gfx11.
For what it is worth, this patch looks to me.

Tested-by: Lancelot Six <lancelot.six@amd.com>

Best,
Lancelot.

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 27e7356eed6f..e477d7509646 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2006,10 +2006,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>   		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
>   					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
>   
> -		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0))
> -			dev->node_props.capability |=
> -				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
> -
>   		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0))
>   			dev->node_props.capability |=
>   				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;

