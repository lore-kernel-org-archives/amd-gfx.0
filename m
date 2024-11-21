Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CCED75BBC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 05:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0BC10E0DA;
	Thu, 21 Nov 2024 05:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p82uLLTw";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC56710E068
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 05:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtNDtsCPY0wsZaFCh7QnpTcHW03d6lDL+ST1VdF9W3qdAGjv0PVCH4g7sbAZZWUwcjSddfei6IE/qKxCvSPHYKuAUtmaojFa52huZWxPxPQmT6D8TJV6VJmy2OIxd1TmvnZNjIb/Y5cqHPyR5kYtjx44aSxw2JiKTPlwgJhtww9JI9eS5LpI/p7dvkoXKcyZQp18NVKOn7FXogfnDTRcc4vGlSVY8NgRTl6c8BXPbwOJwwD8rYgrht5+c9HBnJmaUWFNR/DFrZLg507gRSZboaczdC+dgJFgmbOMG0+mzi++pQBZo52SsuCrEfohcwT/vooqe+5cZRhT13dh4YfReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jeun1gR/x7lzqDS0nOh00ZZmhgI36o9dpfM9j0Mjsps=;
 b=J3gHSRi4SuHSwOegB+jeg0F3FqMXo2x9orIwfovIi61OMjdExO7qe6oZQA2tOGdLAGLFqJmqKZymhaHR0Eyg/IikzgnFWTwOsY+0/8MYYHJhDQhKZheKqmsjqcG4ZULYl8HpWgBTs+YDn0e05zKMDMAuXKF+6E8q9DxwHrnMDebah/v/ifvjiXSO2iWAYE1/9/esCSvmfqW4yyxSwQsp+sx4DyFzUV4il5oTtdDdZUx8MAd/8JevrLGNnmAclBDYT5WyNenr0XGtJIeF4WC7ss52IIFmQOobHN2t+4YqcXcRgzJZ6B7Dz7zBGBBCn7GI0eKT0yZ2zfWRqqzkfopiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jeun1gR/x7lzqDS0nOh00ZZmhgI36o9dpfM9j0Mjsps=;
 b=p82uLLTwtcufPfVDDLf4YokXonO7FO26r6A81AXWtFEy6wLfSFwnD6VVvsoBNq+kg2D48l7RJwZJGXMNrb2IwY7si5oecb7n35Dv/lyDHX3/OyiDTaPwH3uZqo9iMRH/eWeCue23fLegAcUZS7UFSnbX8nRMEhfmzoLnN19cqjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Thu, 21 Nov 2024 05:57:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Thu, 21 Nov 2024
 05:57:24 +0000
Message-ID: <cc024491-c93a-4487-9494-e8665271dae4@amd.com>
Date: Thu, 21 Nov 2024 11:27:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] drm/amdgpu/vcn: make powergating status per instance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241113214453.17081-1-alexander.deucher@amd.com>
 <20241113214453.17081-13-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241113214453.17081-13-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 838f710f-5cfd-47dd-7be4-08dd09f15ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWlOcWpaemxZczlHMTNwSW12N3h4SjE0WXJPRlpQVEVJQ1lMTUlFSFhpQnpi?=
 =?utf-8?B?TGoweUM3Z0JRelVhcXh4MWkxUVB6RVFpUDZXM2VRcmtKMUpDWkd3dUl0cEg4?=
 =?utf-8?B?Zyt3TDIzYStWTjhHdzZKdDZOejEwRksxdzJMQjlZWHc1c1E1MHQwMXV2OHdF?=
 =?utf-8?B?YWNocGFTYWgzcnFJeFlVZGJEU0JKaWNJR1E4b1BqU3l3Y0krZzdjczJuOU1o?=
 =?utf-8?B?QWZKYktUaEtGOUFBd1l6dEVlc05mcUdhZmVsMlBJK0h2TWtya2RxRXcyZ29r?=
 =?utf-8?B?eGFmTHMxZGM5b3UrbmNIWU00a2JZZmhjVFo1NlNoMlVoajJrZlU0ZFB4Y1hh?=
 =?utf-8?B?ak00ZXk3OFp1eUZnUzBrUzBkdGU4UkdKa0dwNERkUEpmME0vZkQyc0xrMWRa?=
 =?utf-8?B?M1NRWGkyR2dSV0daMzN5WkFlNjFQRTRqWVZiOVZxVVlOazljaFErVCtNSEMr?=
 =?utf-8?B?LzQyWU9xUmExRGNOZ2p2WVNNVUVBKzl3K3dmc09vZ0E3S0pTbnY4SFRnbUxH?=
 =?utf-8?B?RFE3ZDhJTnhRdC90eHNxOVIyMWYyVmxDREU4dHZYdEVJWitPQ0lXdFRyNUs3?=
 =?utf-8?B?ZnA1aGs0Ulo4bjhWM0F2SjJzRUVRUCtMMG0vc3VMZjhIUWd2dkRpZThQTU85?=
 =?utf-8?B?SGR2S1JoOUx0bFJ1aitGcndjdEYrYWJsY250NDAyOGcvTmZGYWVkZElCSjVo?=
 =?utf-8?B?NlFxcHVMblpobGpydlo0VTFQWkhGY0hzRENtR2YvZXVWRG1ZcEpNZUc1NUFD?=
 =?utf-8?B?Y0lickM4MmtpTk1rWjhycEFXNFVYK01vdFd1SEkyQ1dYUW5UQW9IQ1JCeG9T?=
 =?utf-8?B?RTJablBUcHhyOVVkYnNEN08zQjlYMEhUcjRVcGswV3IwR24vd2d2V0ZXelVi?=
 =?utf-8?B?cm8wUDIxT3JDZGo3NnJmNUkvQ0R3ZWlBZi9ZcXgwYU5KMGFVQ1VpR2tZSCsw?=
 =?utf-8?B?d1BLYVc0Nmx6ZzFtTmQzd0NjdDJLcmc3ZjZXVXpWb3U2cmJkK1RXQVhoV2tI?=
 =?utf-8?B?L0tWN1FsbGR4UDRvUCs1ZGd4VDNDTW1aUjYrZ1g2QmxYS1N1YWwvS1ViR3lm?=
 =?utf-8?B?VnVYZlcvMURTaWRVRWN2MnQ3bThYZEJrWk1lU3BBOTZjYUxZL1FYQk9NVEY0?=
 =?utf-8?B?UCtKdjZQY2pQSmV3YTRoaitDZjdFU2FqdmhuTU14NVpObFZJVno0aTRaNUVt?=
 =?utf-8?B?M1VlbUozSmxzK1p4NW53RVRoL08yYWU5dVpxYkF4YStpVi80TndhL1lIdlRC?=
 =?utf-8?B?TjBnaXhPN1FXMjFDYkJwNkJCNFlTTmxzTWx5a0EzbFQ1TS9majlROWg5NmR2?=
 =?utf-8?B?VUc1eDFLMCtIdVUveHBGMldnVW1mZWNHS1ArUnlZY01OQUVpT2tPQm41NmZs?=
 =?utf-8?B?Rk84MXEvVXI1eUY3aWxDdWJBSjlUS1lxWWozTFpFTGE3YmN6cXM2UmFEcGVK?=
 =?utf-8?B?SG5UVU5QTkFBUGJocXdNeVZsQ1FGS2dpKzZzbklhVUhleGkzUkRJaXBtQS9u?=
 =?utf-8?B?bVY3UFdIMGdCWkh3eHhCQlFVQ0lpU253dSt4VlM1Q2g3RGhYcmt4U0MrV0ht?=
 =?utf-8?B?NDJGUzA2TVdnb09JWVN2TytqdVd6Zkp5OGV6SUdTR1ZOeCtQV2o1ZVFQQWFo?=
 =?utf-8?B?dHpHYTZFYUJKZnBOWVAySDBwalg3ME1XNDVkUEJNQTBPOEJhajBlM1QxVkpr?=
 =?utf-8?B?cEJQNXplaWdRUldXZVBaLy90TTVUOUt3QkpzUDNRbVlhSnhhZ3h6bkZQcFd3?=
 =?utf-8?Q?RpalysTyemHYfedDuU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0ZJR1plMVdtSFpBZnFtaVJXeHVIcE9VNEtudDNKeEwveUMxTTY5UUNja0gv?=
 =?utf-8?B?TFBFTm9pdzVIRTFqWlF2S01CczBPK0ptY2c5aE9NOTdNUzlnbllPMU9CaFFt?=
 =?utf-8?B?SDMxOHNOYjVYM0JENU1zc0RXZVBqd3pGSHdHRVdYd2s5OW9qQjZiWGxWdVZj?=
 =?utf-8?B?UWc3WVBGbFQva1ZCNUI0VS9PRVY4QUZzWmprRGRXZlZjc0Yxc2RlZktzMVFO?=
 =?utf-8?B?Tk10dWxpUkE3cDdXT3hTQ29ZODdTU3dkdmxDQjFGS0g2Z0ZzUGxpV0pSRCtt?=
 =?utf-8?B?ck5IUEo0N0JDYnJnZUtsSWJGSDRxbkVlbmxDVEVldThzZzBraUphdUVJOC9m?=
 =?utf-8?B?S2RRT29JaENQUlIxdHBVSWZ6anRFWkdyZ2dKM3V0N1d5YnZRS0Nsd3ozR2dm?=
 =?utf-8?B?RGVRdjI4NFVSVkNKOEdkdHJpVkRraCtoWU1Ddy9QcHFwMmV4K3BuZHdDNm5Q?=
 =?utf-8?B?NHJETFg1Y3hoVzhjSW1Ta1I2NnNEVDNzT01rSnFUakNLNE0vTHhkVUM3TzZZ?=
 =?utf-8?B?dWZaUmtpbkxwSTRJdXBXaWFGWWFncG1ZUUVKTm1XSDdUbWVNSHFJWVhQYVZJ?=
 =?utf-8?B?Vm9xbnh1a09lSGZMRXJLeGNsK0VvbWh4d0hnNTkvZk95QjNiWENiYjNRY1FL?=
 =?utf-8?B?M1IwMGdRRHhLM085YlYzZXJNSUZRZGV1ZUZ6UlpMRzlOQitpZHRIQlJ6TUpT?=
 =?utf-8?B?MUh2Z1lQYStFa3QyVDg4dVBiUWJnSFZJWFJsQlZxTU8wNmNULzFkOFI1akxM?=
 =?utf-8?B?eWV6blNZTDZROUowR1NaV09xZ1l0SWdDSzhleXEweWxteVY5NFRwUW5KK2tO?=
 =?utf-8?B?bDNIN3g1cUQrNkZoei9YZ3VNYlhmQ29CZ3VMNXAxY2VhdnpweTFkeE8vRWtv?=
 =?utf-8?B?QjlOWnFETVFqWUpibGhvM2JDcXc1Mk9PVkJKTU1oL3JmSDYxZTY4T2lXZFpX?=
 =?utf-8?B?cjVaREp1TkErdkxzbDFmNjR1a0p2WVFjOUJ5UHo5RDJ3b3Y4MU50cWUwa2Fk?=
 =?utf-8?B?VGpuWUNrOXIwTTZkWUg2d0hrSnZ3MnpMbTgvOFBGU0lYUmhZdFd6VGpuMFFZ?=
 =?utf-8?B?OHBpT1lON1M5anlSR0ZGbkt5SWZzWDdGVDl5MTRUNlZOQjdKWnJiYVlteGpX?=
 =?utf-8?B?eG1LNEQvRWFtVW5ZK2o2WUdNaHQrNkJHV0VkWkdhTk1TSXZpY1JvYWttN0FO?=
 =?utf-8?B?KzFWT1hWRVZhOUVyMUczbWQ0MzI5YzdlRmJacE1pS20wUVBJTW5tcnU0dGhJ?=
 =?utf-8?B?SlNEaVN3UEpxOVVhazNheEErWWVERkxZS1BKQnl1QmFKR2NzWkk3TzRlVERR?=
 =?utf-8?B?anhVdkp2OUxrZkJZUllUaDJ0dkVkQmN0TTA2Tkd4Wkw4NWs0TnpXTlZGY0FR?=
 =?utf-8?B?M3dINUpKbFhGa0hURnhaQkNSeHJwdnFINW0rTzZERStDOFRPbWNoSzg4N3dU?=
 =?utf-8?B?U1lCUXlsWTBIZ0IvMEo3NVZOYzZUUEFkdHp5U2FPSnFMaDQ4Q2ZqaVVKb1hU?=
 =?utf-8?B?L000TXR6YWVXWEh2Y0VOTzlkdzZkaFUzTEoyOHpmSUpCUXVUZUlhVHdaazVO?=
 =?utf-8?B?QXlEUmNQcTZwVnRhLzBuRCtCTUd6RU1BYUNpWVpSdXViZStnd2xXVlJBQ3B0?=
 =?utf-8?B?NVp4eTVZQUdSRkFsVktXUmdYODFVRU8yalpQSDN6cVVvYkRGQ0JHdzlZMFMy?=
 =?utf-8?B?eGhISExma3IzRmY3Vi9pR3NxczQrT0lHbysvdFJMMnlPcmlqY2hKM2QxbWdC?=
 =?utf-8?B?a2kyR0FXR3FVMmVMdUpWeE1jQTZhL0RkeC9tL3NoQ3ZyT0ZIL2VtMXZYaDB0?=
 =?utf-8?B?c3ZJLzdWSzV1aUZ2dndMZmlNNWp3Y1owQTNSY2lFOHhhbTJJb3VJb2xQOFRm?=
 =?utf-8?B?RzFqUEMyZnpuYk80UVZmS1VLU2RQTmt0VEtWblhrZkxnOFNwUkdCcDNVampo?=
 =?utf-8?B?YUJLc0l1dUNKMGF2S3VwbDlhbTRHaGYrUU5PL0MwMWxKb21KZTBCTHROVFRX?=
 =?utf-8?B?TlVIM2VlT0ZQdUhsQ1BlbU5jTzN5NnZxRzBDNUlERmdoTXc0eno5NU96V3kr?=
 =?utf-8?B?LzJ0eVN5aXBjL0xLZzlaVWF0TVdQZHRsNG5zempwTEI1TEZlWGZPMitiTzJL?=
 =?utf-8?Q?j3J9VW6tShxaeUCM1VcWnJVor?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838f710f-5cfd-47dd-7be4-08dd09f15ebd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 05:57:24.1558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDzsZqOTMDbUfx4QDxy3ILjRVe6IaXilyOgu4wFcUiSqGrVcqShhOrjIkvwfnUYg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
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



On 11/14/2024 3:14 AM, Alex Deucher wrote:
> Store it per instance so we can track it per instance.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  6 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     | 11 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 43 +++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 49 ++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 60 ++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 63 ++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 48 +++++++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 48 +++++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  8 +--
>  10 files changed, 214 insertions(+), 124 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 0d9a4d946eac..dc3c7b7bdd33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -304,6 +304,7 @@ struct amdgpu_vcn_inst {
>  	uint32_t		vcn_codec_disable_mask;
>  	atomic_t		total_submission_cnt;
>  	struct mutex		vcn_pg_lock;
> +	enum amd_powergating_state cur_state;
>  	struct delayed_work	idle_work;

Presently, IP level callback is not required for per instance as this
only used in VCN. This can be kept internal now.

Suggest to squash the changes in 12-15 as

1) Add below to amdgpu_vcn_inst.
	int (*set_powergating_state)(struct amdgpu_vcn_inst* vcn_inst, enum
amd_powergating_state state)
	
2) Assign the respective IP specific fucntion pointer and call like
	vcn_inst->set_powergating_state(vcn_inst, state); when required.

Thanks,
Lijo

>  };
>  
> @@ -314,7 +315,6 @@ struct amdgpu_vcn_ras {
>  struct amdgpu_vcn {
>  	unsigned		fw_version;
>  	unsigned		num_enc_rings;
> -	enum amd_powergating_state cur_state;
>  	bool			indirect_sram;
>  
>  	uint8_t	num_vcn_inst;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 9ca964e11540..406886f13566 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  
>  	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +		(adev->vcn.inst->cur_state != AMD_PG_STATE_GATE &&
>  		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
>  		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>  	}
> @@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  	int ret;
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst->cur_state)
>  		return 0;
>  
>  	if (state == AMD_PG_STATE_GATE)
> @@ -1822,7 +1822,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  		ret = vcn_v1_0_start(adev);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst->cur_state = state;
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 115f33c3ab68..f445ae401359 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -316,8 +316,8 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  
>  	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
> +	    (adev->vcn.inst->cur_state != AMD_PG_STATE_GATE &&
> +	     RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
>  		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>  
>  	return 0;
> @@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  	struct amdgpu_device *adev = ip_block->adev;
>  
>  	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst->cur_state = AMD_PG_STATE_UNGATE;
>  		return 0;
>  	}
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst->cur_state)
>  		return 0;
>  
>  	if (state == AMD_PG_STATE_GATE)
> @@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  		ret = vcn_v2_0_start(adev);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst->cur_state = state;
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 6fb08ed09310..1d3780a2d851 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -95,8 +95,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
>  static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i);
>  static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -				enum amd_powergating_state state);
> +					  enum amd_powergating_state state);
>  static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>  				int inst_idx, struct dpg_pause_state *new_state);
>  static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
> @@ -397,9 +400,9 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>  
>  		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +		    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
>  		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> -			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			vcn_v2_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>  
>  		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
>  			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
> @@ -1805,27 +1808,39 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> -static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return 0;
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>  		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v2_5_stop(adev, i);
> -		else
> -			ret |= vcn_v2_5_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v2_5_stop(adev, i);
> +	else
> +		ret = vcn_v2_5_start(adev, i);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		ret |= vcn_v2_5_set_powergating_state_inst(ip_block,
> +							   state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 70a1b85a4efa..13b9ed96cccd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -105,8 +105,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i);
>  static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -			enum amd_powergating_state state);
> +					  enum amd_powergating_state state);
>  static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>  			int inst_idx, struct dpg_pause_state *new_state);
>  
> @@ -430,9 +433,11 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> -				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
> +			     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> +				vcn_v3_0_set_powergating_state_inst(ip_block,
> +								    AMD_PG_STATE_GATE,
> +								    i);
>  			}
>  		}
>  	}
> @@ -2147,33 +2152,45 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> -static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret = 0;
>  
>  	/* for SRIOV, guest should not control VCN Power-gating
>  	 * MMSCH FW should control Power-gating and clock-gating
>  	 * guest should avoid touching CGC and PG
>  	 */
>  	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
>  		return 0;
>  	}
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>  		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v3_0_stop(adev, i);
> -		else
> -			ret |= vcn_v3_0_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v3_0_stop(adev, i);
> +	else
> +		ret = vcn_v3_0_start(adev, i);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		ret |= vcn_v3_0_set_powergating_state_inst(ip_block,
> +							   state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 656c2a1c4bf9..9b7fc7ee4188 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -96,8 +96,11 @@ static int amdgpu_ih_clientid_vcns[] = {
>  static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i);
>  static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -        enum amd_powergating_state state);
> +					  enum amd_powergating_state state);
>  static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
>          int inst_idx, struct dpg_pause_state *new_state);
>  static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -367,9 +370,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +				(adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
>  				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +				vcn_v4_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>  			}
>  		}
>  		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> @@ -2039,41 +2042,52 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> -/**
> - * vcn_v4_0_set_powergating_state - set VCN block powergating state
> - *
> - * @handle: amdgpu_device pointer
> - * @state: power gating state
> - *
> - * Set VCN block powergating state
> - */
> -static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret = 0;
>  
>  	/* for SRIOV, guest should not control VCN Power-gating
>  	 * MMSCH FW should control Power-gating and clock-gating
>  	 * guest should avoid touching CGC and PG
>  	 */
>  	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
>  		return 0;
>  	}
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>  		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v4_0_stop(adev, i);
> -		else
> -			ret |= vcn_v4_0_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v4_0_stop(adev, i);
> +	else
> +		ret = vcn_v4_0_start(adev, i);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +/**
> + * vcn_v4_0_set_powergating_state - set VCN block powergating state
> + *
> + * @handle: amdgpu_device pointer
> + * @state: power gating state
> + *
> + * Set VCN block powergating state
> + */
> +static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		ret |= vcn_v4_0_set_powergating_state_inst(ip_block, state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 8eea78c498da..60b6cece499a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -87,8 +87,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>  static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>  static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
>  		int inst_idx, struct dpg_pause_state *new_state);
>  static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -333,11 +336,12 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>  
> -	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
> -		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +		if (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE)
> +			vcn_v4_0_3_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
> +	}
>  
>  	return 0;
>  }
> @@ -1633,41 +1637,52 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> -/**
> - * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
> - *
> - * @handle: amdgpu_device pointer
> - * @state: power gating state
> - *
> - * Set VCN block powergating state
> - */
> -static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret = 0;
>  
>  	/* for SRIOV, guest should not control VCN Power-gating
>  	 * MMSCH FW should control Power-gating and clock-gating
>  	 * guest should avoid touching CGC and PG
>  	 */
>  	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
>  		return 0;
>  	}
>  
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>  		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v4_0_3_stop(adev, i);
> -		else
> -			ret |= vcn_v4_0_3_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v4_0_3_stop(adev, i);
> +	else
> +		ret = vcn_v4_0_3_start(adev, i);
>  
>  	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +/**
> + * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
> + *
> + * @handle: amdgpu_device pointer
> + * @state: power gating state
> + *
> + * Set VCN block powergating state
> + */
> +static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					    enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v4_0_3_set_powergating_state_inst(ip_block, state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 7086f98c2ddc..422f90c3d2b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -95,8 +95,11 @@ static int amdgpu_ih_clientid_vcns[] = {
>  
>  static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>  static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>  static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
>  		int inst_idx, struct dpg_pause_state *new_state);
>  static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -308,9 +311,9 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
> +			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v4_0_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>  			}
>  		}
>  	}
> @@ -1517,6 +1520,27 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> +static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0;
> +
> +	if (state == adev->vcn.inst[i].cur_state)
> +		return 0;
> +
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v4_0_5_stop(adev, i);
> +	else
> +		ret = vcn_v4_0_5_start(adev, i);
> +
> +	if (!ret)
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
>  /**
>   * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
>   *
> @@ -1526,23 +1550,13 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   * Set VCN block powergating state
>   */
>  static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state)
> +					    enum amd_powergating_state state)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0, i;
>  
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v4_0_5_stop(adev, i);
> -		else
> -			ret |= vcn_v4_0_5_start(adev, i);
> -	}
> -
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v4_0_5_set_powergating_state_inst(ip_block, state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 4c641813aeff..8c953cd1f95a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -78,8 +78,11 @@ static int amdgpu_ih_clientid_vcns[] = {
>  
>  static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>  static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>  static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
>  		int inst_idx, struct dpg_pause_state *new_state);
>  static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -282,9 +285,9 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
> +			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v5_0_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>  			}
>  		}
>  	}
> @@ -1254,6 +1257,27 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	return 0;
>  }
>  
> +static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0;
> +
> +	if (state == adev->vcn.inst[i].cur_state)
> +		return 0;
> +
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v5_0_0_stop(adev, i);
> +	else
> +		ret = vcn_v5_0_0_start(adev, i);
> +
> +	if (!ret)
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
>  /**
>   * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
>   *
> @@ -1263,23 +1287,13 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   * Set VCN block powergating state
>   */
>  static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state)
> +					    enum amd_powergating_state state)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0, i;
>  
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v5_0_0_stop(adev, i);
> -		else
> -			ret |= vcn_v5_0_0_start(adev, i);
> -	}
> -
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v5_0_0_set_powergating_state_inst(ip_block, state, i);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 2a9f041cf46d..abbd751926bb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2031,15 +2031,15 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
>  	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>  		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  		smu_dpm_set_vcn_enable(smu, false, i);
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
> +	}
>  	smu_dpm_set_jpeg_enable(smu, false);
> +	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
>  	smu_dpm_set_vpe_enable(smu, false);
>  	smu_dpm_set_umsch_mm_enable(smu, false);
>  
> -	adev->vcn.cur_state = AMD_PG_STATE_GATE;
> -	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
> -
>  	if (!smu->pm_enabled)
>  		return 0;
>  
