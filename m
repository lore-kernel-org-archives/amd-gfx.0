Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C4AC3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 08:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D7410E56C;
	Tue,  2 Jul 2024 08:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1UzAruBj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E00410E56C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 08:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f40Pid94zmcuICBHIePoBcEob5d8cWmluvO7nVwubMcELLcMghf0A94sc7Rk2leDG0jlfTeMXrNqTC+QoLMY65/cdM5ITegtEL+V3S8rKEmNKS58koXj2s97IyM3sw1kwESK0QxIWJtbLVq8A30uVpROn8NmEoCLecmg6vG4P+ZZi+GWFnfkACZHu6KnmqxVXMK1EeBGFI+CtzYD90n3AQA0yySs3cyoGu6akGG3CFonrX8P7LERNDGWRwuhKU3/c/kOsKsIbFsHaZDcLd42kfqv+lwZpM8udSEVBthQy16hP3jtujhFjJ8DH/jz2pG4lvSowEs1MyuA+kTFRWcR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCI9TE88iY0C6pbxDI4l+mXi4xmJCOv0PhbXyNHgP2s=;
 b=SfZSfeWDDMy9eJszn7WxpjFCu/lk/W8rGhX3aWB19bNydi2UM7rI7NUN2UdevCZg7DUVeAZwmQTZuCxUs/Q5r/AO668ywpKPsPf7qvDo8WBpnNQ8sfT3dhnzovXMuV87v+KdlawX+3TVDq0O13Y7i+3w5ywrNrAXpnO6+gvOAyXFaaedNYxoglg89dBIu2wSjaknRksHxIzkUc9uPVVHc5SdkY/cGw3CHpxkfa3ImvSaXGK7RyOBF3v34Np+ekMo/pfypj4aOuQBYwq88nWPhXFkEmmLXLTWbjbRjtx4C1Q8YTb5TKy64s5gpFnvRsA8jjxquty4ZoO9vhETqZg2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCI9TE88iY0C6pbxDI4l+mXi4xmJCOv0PhbXyNHgP2s=;
 b=1UzAruBjgDQxPvTGLAK9dcF/jQkIC3s5sxpkPKWU2y2wqMMvfzD/rFYMvkL5iESNBJvjWLhX4aj0IrYG23Vo3ahUu+ZibWOtTvjafxiXanl2cMJTK73LB6h/jwezjDvB/nz9FYe6HuTcNYg/dai5xh7Hm4EemBXzKVq81iAfu4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 08:52:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 08:52:43 +0000
Message-ID: <d72c312a-5c59-4469-a2f8-057a86ddb173@amd.com>
Date: Tue, 2 Jul 2024 10:52:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: fix out of bounds access in gfx10
 during ip dump
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240702082605.3062592-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240702082605.3062592-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 5374bee6-b4b4-439e-ddd4-08dc9a74562d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjNuZ2RPVGdHa3BVSVhNc1FIQ3d2emNnVjhpN3o2ODBDMmg5ZzV3SFN1Z1Iv?=
 =?utf-8?B?OVZPbzFvZUg1bDBiSVpzNWlnazFEQU41SGFucE5KTnZDTW43OWtteXgrUUFq?=
 =?utf-8?B?ZTZIZHRQaEc5NW5QSCtVWG9DZlVYK0F1M0orK1Z3WHlleHNiakQreG00djlO?=
 =?utf-8?B?ZnlIYkt0MlRtQ01IcXJERnRlcWJKOGd5UmFHL0FLS2JJWXBnS2NpU0Q2MFVS?=
 =?utf-8?B?S0RLdUx6OXRtanUwWFlVUjRrYXRYWEpITjJwOWRwUlA1MlB6NzEvYU9HRTZQ?=
 =?utf-8?B?dVBiYm9QVGNpUlBWejNSZVNSalF3cjhpYTJ4VTVFZlAzY3RPekZzaEFLZmhG?=
 =?utf-8?B?WlRQT2Yyb0xRMkJMSmVySFM3djhBRDJxVytCOXNtK2VUUXB0NjdSeElnNW9Z?=
 =?utf-8?B?N3UxdFZ1L2N0UUhIYXBrUFVNRDVWcURYdTZ5bENnMXEweGEwU3ZSR1lPck0y?=
 =?utf-8?B?Y2hOeExEMGV2dE9EelpBTW5aWXV0MWNyVCs4MXl0RHpkYmxldVpLVVZOOG53?=
 =?utf-8?B?Z3Q3V2FnRHBTT0FYR012Q3FRSWpVQVp1Yyt3MTF4a3NqSkw3WE9wcFFIaHBE?=
 =?utf-8?B?NXA2ejNOanlpcENKN0EyZ3RKQzRTY0tuVXp2U3JqbytEeHJMNFNocWMwR2Zv?=
 =?utf-8?B?RmsxUjJJYlZXTzMzMGtMK1VVVFpyV3VxRlRQN1l2cXpCZ3hIc0dra282TDdE?=
 =?utf-8?B?MlBTM3ZsNlFhYVVsN3BLOE42NDVkc3Ruc2xrOG1ZTml3ZnJwTGp0M016SHdF?=
 =?utf-8?B?YittaTNkeTAxbVNWWGFKcDRtUW5hZUY3Vi92TldPMEJpTitXVFU4YmZTWkln?=
 =?utf-8?B?S3oxRFhEMFFGcXYxdUNRNGxiNUlrSzhicU5yRHdqWkpvS3ZhK3NxaTRRRjl6?=
 =?utf-8?B?TVRhMzN0S3RQRnBiS1Y1MTIwRWMwM3Fxd1EwbkQ3RC93ZXpjRGJiVlQ3Mlo4?=
 =?utf-8?B?bnpXK1dMZSs5OEhnNit3RWRLK3JhV0xwWjVyRnlzWTZESkVEOHJZQ1RLa21s?=
 =?utf-8?B?STNVUm8wYVM1ZjZOZTE1YVNwWDRDSnc3ekxkYldZOVlCSnRmbGh3UFViSWJO?=
 =?utf-8?B?L2V3a0FkbE92WlJPbWw4UnFYajBwbEoyVTBucUFkMG15dHFZMWhmTE1OMnBq?=
 =?utf-8?B?RmNBZDdrMGx1WUpDY3pTY1k4Sk5KNTk5Qi83bGxjWCs0T3hUWDl4YUFPa0xS?=
 =?utf-8?B?cHhNZGRFb1dHSzdsYWdKcWo2SE52V3BnN1NCOXJ5b3NjMHRHZmZzRXdGN0l5?=
 =?utf-8?B?cXF3WFNIMWRubTh0dEhHbnhFTTF6bDVwL01kcFp0bzRtOXFrcFlXaXdGa0Y5?=
 =?utf-8?B?MTAvNW5ZKzlxT2lkQ2dhYWtsWUNlZWk1WWxvanpQM1NPRFpZWmFLaWdoQmpr?=
 =?utf-8?B?a2xwYkY0ZlpYVjZrNVhjeUFQK1EzaHVnNnJ1dHJaZDRleUpmZEIxYThnN3dl?=
 =?utf-8?B?UDhOWFN0aUczS0pJRTc0Ny9GN2Fpb2R5OXRiRXU0dFZrTWNxWmRrclZibWRx?=
 =?utf-8?B?UWRVZVQzV0dxV1NpYzNpb0hMdnozOW9mUzJoQVV0ZXlhMTI3aFJURkFaNFlV?=
 =?utf-8?B?cDNRcnEzTVl2N0llbE9jZ3N3dzljYnRDbm9mWlk5Qk55MTN4aHYzL3hRYTA3?=
 =?utf-8?B?L01tYnh4Zk52MG1YQ1VUMXM5dzFPZEY4NDlqK2g0N01LcThUaFB1U1oyQ01J?=
 =?utf-8?B?WmRyVldIVDRNcTVDc2EyNjc0WkZIajRkMjlPVjBWK3duN3JWaEViTUpEUzMx?=
 =?utf-8?B?VUY5Y0lzZHU2dXRybldaRytyZ3ZDdHdiTGQ1T25makI4RnFEOEhteURxeDVL?=
 =?utf-8?B?S2MrK3NqVlBJakZoemE4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS9HMXRkUnRqWnFwM3p6cHI3Tkd3Q2lGa1VGd1Q5TEgvcHg0eUxmT0U3VmZY?=
 =?utf-8?B?RWdOUzdPa1NOZjhjTm9OSWtqM0V0akJXbHI1akFOL3h1MmIycTRZVlNUamtJ?=
 =?utf-8?B?bWdhWGhKalRyUTJQQk5BQ3FLd0FBVVFSSjlhRFl5RjBDcmp1d3o1ay9lMXVp?=
 =?utf-8?B?WC9vZGp2dE1PQXpLeTU5aExOa1M0SVo1di90RFJ5WEJrM01UYkkwTS9YRFlQ?=
 =?utf-8?B?VmZPMCtQNTV3Z1NVM1lpbVM5NXdVWUJSdDJhc01GK2FVbDFhN3hNVWEwMHVj?=
 =?utf-8?B?TXduTnpDSkhONlJKZExTckVldUZPdEJxT3BiYW1RRit5MW16anNyQkJSNlhQ?=
 =?utf-8?B?Z0RVYWdrbUdIUXE4ZU1Qa2JIZE1uRDdzRGJsenNZaHBHenlsS054M0JDZ05N?=
 =?utf-8?B?cmhKL2lVbXY0bGcyY3RPRW43djNtNHpINmV4YWQvZldvTjJVV1Q1UzhrKzV2?=
 =?utf-8?B?amxpOXZ0SEc0THl0U0o0R2J2NTNBSnFudlZFZDdCV2JJNlgvSXlEYjlLMnlL?=
 =?utf-8?B?aWhBZWR5dWdVN1FZOWYrdE5jRzlEVlBSNnlqNGVhZlpaMzNPSU5FRCsvaWdt?=
 =?utf-8?B?dHVYdy9FcTVhMFpESXZVRGlDdFBVVi9zZFg0b1c5R1lQYXdZdjN6SFpyRXk5?=
 =?utf-8?B?VEtVWERJOXpmeFRqQ1h6MFRQdGpuRXpydEVCTDdkOW5PSTIzeFMzR2VyYTEr?=
 =?utf-8?B?d01sckFYaVl1SXRmWDk4dnR5d3V0cjNVTHBQbG1FbUJTNzNxYmRuKzFHMm90?=
 =?utf-8?B?TTJGYXFWS0ZOdHZxbk90NmVSNENUOUxzYXZSTnhTRWFwNjlTMHhBUmdUcHRB?=
 =?utf-8?B?aWcvU2t2cTQ5QU43eVpETEZFZU5NamFnRWNsa2dPOUFUMmFzREZFa3puNkxU?=
 =?utf-8?B?bFJPdHh3Y3ZNV1Q1QjcrYmlNckZqNjlnUzRjN2xoWWhtM1hnSkxnYUtQKzBi?=
 =?utf-8?B?ZnNnRE13MjlZcmpxeTdSRmEyNkdBOGRRSVNsY0VKdFd3ZE03ZTNPeUs0c05B?=
 =?utf-8?B?OXgvREp2T3FPL0VaQ1VGZnUvWUw2MTF4Y1BpcStjODZvWno2amNjdDMxZzdF?=
 =?utf-8?B?RTAxaTdhb2FJK3NUSDBnMHVkVXR6YVM0THdraTBCMFo3T0phQnNvQTQ3Y2Iv?=
 =?utf-8?B?SGh1cTdTUUxIOFowM2w4clVDY1MraFdiN3JweHg4aDdBRDdqNnZzMGRlMitN?=
 =?utf-8?B?S2lHT2IvWFVuczNyVkNYcWdrTTMwNUhscjlnb2luaXRQOXFpdU96MUF3Y01J?=
 =?utf-8?B?TFRpejJaM2RhQXVER2ZtbGFvMGxraEx6ampkeG1YQU94OW9RNjF3Y1cxM21L?=
 =?utf-8?B?T1haMUJMKzRiOVR2elFOWnFVTzE0YlJHNDZhSzl3Z2tqQWR0S1MxREVuSDEv?=
 =?utf-8?B?UDU2elJsNXllMkhyaHNiSmJSUExmQzk0bXNVcFZtOCt3bzZHUmE1eW94V1dT?=
 =?utf-8?B?Vy9FaC9nUklaQ3lMdERtQ3pLaXhlSithdzZoeERmL1MwRzVZcy9BVlJRMGNR?=
 =?utf-8?B?WUs4T3JnOEFZQUJ6V25jSkNPdE5NVHV3Q1N5V25RK0NuSlZQRU1la2pQd0t0?=
 =?utf-8?B?OEowZ3E4OEdQUFFiTWxIajNYWVpXcXpyUXl5cFlvM2dvcHJKeVdVbGFqL21S?=
 =?utf-8?B?cURkQmpSdFlUdTF4UlhCNkdJWXRnVFhKWlRrYlR3STQ4UlVoTW1udC8rSy9w?=
 =?utf-8?B?c2FzUEVWdHBNWE9uMk1GdmxOWlVGNFU1ZkVzZUlENWE1K0VWMXFlbTVsTjZw?=
 =?utf-8?B?RmhYdXlBZUdaMnNJS2pLbVJCN0hjbnVBMmw3UE10b1JNSEV1QVp2YUwveGpX?=
 =?utf-8?B?UEhKSCt6d3lTTmFCNVEzelR0VktNL3k1VEMxMHhmUlJRQWhQTW50RnJBRENr?=
 =?utf-8?B?Qmd1SEQ0SjNtVXVoRStBQkc5L2g4MHo5Q1lJOGV4Q05tWW1EZUNBRDNveDYv?=
 =?utf-8?B?WGtBb1UrWEtDYlUrV2ZPbFF0c2NYaHhzREVYRGtvbWNZZld4UTFPK3ZOYnEx?=
 =?utf-8?B?Tll4ZmxhMm1wcHFFY2NhcnMrbS9nRmtoS3BwdVd1ZExnR2RkR1M2V2pFSS9N?=
 =?utf-8?B?NVUwam5INHdtemt4VU0zWE9Qclo4OEdEL0NaRlNsaG8ybVhiU1hTVXh3OUs4?=
 =?utf-8?Q?hcrBfsWMTHfWoiqTNgkW/Sv0o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5374bee6-b4b4-439e-ddd4-08dc9a74562d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:52:43.6671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyvqEutdIR3XvJPOzmZyTpZCoZBKvaZtZkq1aFxVD9gv0ZZ/2hQDMWo+jt3eaMRG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

Am 02.07.24 um 10:26 schrieb Sunil Khatri:
> During ip dump in gfx10 the index variable is reused but is
> not reinitialized to 0 and this causes the index calculation
> to be wrong and access out of bound access.

Acked-by: Christian König <christian.koenig@amd.com> for the series.

Regards,
Christian.

>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 18488c02d1cf..a52c72739b40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9287,6 +9287,7 @@ static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
>   	if (!adev->gfx.ip_dump_gfx_queues)
>   		return;
>   
> +	index = 0;
>   	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_10);
>   	drm_printf(p, "\nnum_me: %d num_pipe: %d num_queue: %d\n",
>   		   adev->gfx.me.num_me,
> @@ -9352,6 +9353,7 @@ static void gfx_v10_ip_dump(void *handle)
>   	if (!adev->gfx.ip_dump_gfx_queues)
>   		return;
>   
> +	index = 0;
>   	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_10);
>   	amdgpu_gfx_off_ctrl(adev, false);
>   	mutex_lock(&adev->srbm_mutex);

