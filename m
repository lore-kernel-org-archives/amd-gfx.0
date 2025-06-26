Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D2BC7EE32
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jun 2025 11:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B8D10E031;
	Thu, 26 Jun 2025 11:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nmMLYzkS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2672510E031
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jun 2025 11:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaIMe5uuNrq+zMTKQpuEvQkdGS9+gBcQY3PxJ6Qkdn2gdxpaVWNmiDAGlkktIlPuomIhIXZmgI5DAJY8k/Vyu4qkL/OTHcXZzgNtucIg6LykNy280mFDOsTFgkdwAQuRWptBRRcNyVFANOZ6HpI+Er8KafXVvW+io9W6mN93KLfztfpxE3izpp7Ey3E//E3jq78urhiSIVdP798Nd2GFgI53Yp2XQ2t9teU12TIaugkP1KgKaPozcrXF6kg858ge8J755yr1/Op0v/ZJW94rm4Fwt0ZrgTizCakEQ481W77S4m28D3dtjlXT1SKBcxK8NzLRNt7XQ0CDRKIySMGdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz+iZUntEiw4kbS6GaYucYipOOASf0oVd3T0Fo3xR5E=;
 b=p+U51l+fAm09kYfOTFAiyqYv21WCURX6RSjb5YvgjakGdH6nKav5ZCUBgLu8Einl5Vfacplut/CSNhVWpm1WCX/Fa2Ri7f549qEPkY7+fg2L6d3SLGLAwSQPAp02YZU3vzc0sUsqixoh01B9vbe7u2EPmj4J0gUYXUMpDghxEPoisYuBY6vRAmiYxfNhhwHBBRnfUljIqsHCYhZ1UAdk7lTlttniZdSHvHcdMvWhKGpddSPpQS+Bv1lDy7K1VY5xe17U0zelUXc3QZ9OJbYOwxdaOdpKNmgi8EmKkYgGEaKb/rJO0zuxjmLXmxjzEsI9K8JCf274p3nVXjiC3FdbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz+iZUntEiw4kbS6GaYucYipOOASf0oVd3T0Fo3xR5E=;
 b=nmMLYzkS/S8PaCFTodXStDi6ZVCffdeJEigLUfTqElCTD5dT2jOB0S5BQqBCW1jAnAVgDOmb7nvRhe5drPNtFoEgB0wsPQ277IWZrSfUhuvQ6+Pk5raerWss6anihlR/UHC0wSrkFuMwbhPDu1IXu002rlpb9AepWNWVaOw1bTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 26 Jun
 2025 11:02:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 11:02:44 +0000
Message-ID: <6165855e-2e3e-4f32-9946-e81cff2353ce@amd.com>
Date: Thu, 26 Jun 2025 13:02:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/30] drm/amdgpu: track ring state associated with a fence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250625210638.422479-1-alexander.deucher@amd.com>
 <20250625210638.422479-8-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250625210638.422479-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:208:530::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 013a3526-470a-41f0-feda-08ddb4a0fa7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2NNV1lFb1M1akRDMlczUk9QYWdscEx5UXNCWHUxMWFzdURGaE5hTlMybkRL?=
 =?utf-8?B?elJJSVZMZFcrUXAyeE4xR0JPWVZJVlRlV2RPS2hrVUdCRVNleUUvUktCbWtE?=
 =?utf-8?B?bXBQNXN3OXFONVJIcktxV0NPa0VuOGV4bHA1M3draDd4OW9HZUpnM3MrSi9P?=
 =?utf-8?B?TC9aRFNCL2lmQ1hTd3dKNXkzam91RjhsdnZtRmdNR1YrK3BiQmh6Z0VWQXA5?=
 =?utf-8?B?STB0L0Z4UVVMb2hteGFUbG9NY24yRVVXeThLZ3kxQ2srSDZhMW5oVXJ2QS9v?=
 =?utf-8?B?d1BlMDBTRTg5Zm1Ub1d4Ni9oSVUrS3dydVB6cThKSm93WEV1cjh6T0I3OVZE?=
 =?utf-8?B?UWVveGhCTFdlOGFZZHdsc3JPR2tISktZZ1F3UWs4czAwUlZISU1tME1tUHA5?=
 =?utf-8?B?Syt1RG42NVcwYVB6LzlZWmxubG1mSG93aGZVZ1M1M3A5RHRqTkxkaXcvMWZn?=
 =?utf-8?B?aDlvL3FJR0NtRVhxdVNxc0diV0dLUVhMQWd6emVtZklKaThqek05K2JvREwx?=
 =?utf-8?B?alJ6WUlrWEhDZFhCQkxTTVdtYjhDM0kzbHhFZFJLYVNYUFZXek5LV2w4KzNF?=
 =?utf-8?B?Q1JicGNCc3VWYjQxbGQ0WmZSL2tERlNWUWNMWWRPU3Q1cit5TERFcTgrcTQr?=
 =?utf-8?B?aTBqWGdHU0t0OTk3dUN5cmd4ZG5xU1AzbXFFTW05QzU1aE04YnNWc3VNUWI5?=
 =?utf-8?B?R0FzdzV4TlZxcktqclIvdUxPSjlxaDhSRWRPdFduMXh4NnhmT0gyZ3g2NWlp?=
 =?utf-8?B?a2lSS2RSdklsQmozMHR3TmtTeDhWakVFR1hwc2pHQ09EV3YyYTEyM0YrWEFp?=
 =?utf-8?B?cE9hdUVOWjNMa2RObDRqK1J2YSs3QXQ5eTRnaXFGSDZnOFRJQzQ5czJWMDhB?=
 =?utf-8?B?eXlkUVF3YUI1V3JiYlVNbDdDdkU1VW4yWG55T2ZxSStNYWloQnJVVURuREJT?=
 =?utf-8?B?aXJsVUNuU2hLNnJEK2hPVG5ORFdFalhjd3J6TEFKL0tRQ2x1bHc4aUZ5MkZ4?=
 =?utf-8?B?UEYvcHEzWVp1bDg5cGxOd0swdC9jRUU3WlREQlVuSUNTSmE0Mkk2UFg2TVll?=
 =?utf-8?B?OHRHNERDRnlETnZ3T0cvVE1tZlZvTjMvWWxSTnpwT3JkMklsUFBtMjFWVndC?=
 =?utf-8?B?Zm9BeXV0aFZQMGU2cExrckZmVDR2Q29GcDZDY0NnaDN6VXlYVVZaajZTUjY2?=
 =?utf-8?B?aXEzc2Q4elAwd2pEb0Q3U0ZNLzFvWENCdlNTMzhDVUw4bVFMMUpkMzBXUUNs?=
 =?utf-8?B?TzBhT0lmcllQTW9PMzlxUHdqaUQrb1pVNXVYeVFkazMyckl2dGJZUjE4QTlt?=
 =?utf-8?B?aG1RYmpvT3hJTFIxaCtDWHdUNlFWU1V5Unhkazg1U0tvSCtQZmNCbGk0R0Nz?=
 =?utf-8?B?TVdnckZJK2dOUFprQWtleFQvNldCTFR0M28zRzk5Nnk1ck5UNlppQW0ydjBn?=
 =?utf-8?B?SWRJOFVtUUZibVlJRU1SeG0xNlkzbXZxUTFNL1NlWGtmOER2T3lWVzFEOVlv?=
 =?utf-8?B?N204OTNCdzIvVitQcmlkRUhCdWdWK0tYc29PVzdwRWJ2WnlMTzFVeEJIVUlI?=
 =?utf-8?B?bTVWYkJ2ZjVwUXZIb1h1eEs0VUdlOFF6SWQvOXhxME1YU3k0enlkZkF5a1BS?=
 =?utf-8?B?K2c0UVZPeGFmdmVHbDVQaGM4eFBzaStPTkphSHFVMEp1VzBvc3hMWDJoNDNL?=
 =?utf-8?B?WFlTb01QS2EyVzRGbUY2VFBjQXlaTE4zRkJRdWI0Z2tLVUwwS0xJSXBnNldG?=
 =?utf-8?B?d3c3MEkvZ2ZRYWIyRVZISzhvaFJxQUMwK3FsRWM4c2YrMDFuV1FIL0ptWTlu?=
 =?utf-8?B?WmlrNHJaSGlQN3c1dDhVMHUzZWJqYWRnNnRxUmFWU0dUcmMzQTQ0QXcwNFpV?=
 =?utf-8?B?bGZlWHNBZWNxSW1kL1hHeWNTQnVmd0hBTFdDRll1M3VMcW9WY0pVb0daelZL?=
 =?utf-8?Q?JOuzcO1KaL0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVlUVVhNN2NZMXlySlc4aVRzaC9xNHIrRDFQbFNZc09zS1RnMVNmYXJldG5m?=
 =?utf-8?B?K3Z3Z3NqU0FiYW5sUE9qV1M1SndYSVdkZ3Q0VmhvaTNTN2xYZnloSWxMRzFW?=
 =?utf-8?B?RXMzUS8rK1lUODdwWlU2WnFrNFhXMlBZWGlxajJtMHgvQlFMbUMwUW1DQ1lE?=
 =?utf-8?B?QVdEaEJLbmpFenp3Q3lRSFdQanEzTXU5aC9mWGNGeTMyOThBSVJQeWNZbnEw?=
 =?utf-8?B?OXBIMmdZT0QwZUd2bHlaaFA2UjN1RHhwa2JQdjgzV0VHeVMvMm1ERzR5U09y?=
 =?utf-8?B?c2lWWWxQZ3R1Q1dvbW01cXJkcWs0MXZrdmloUWdSY0hEbGdyMy82MFl3ODJK?=
 =?utf-8?B?THZWNndmQWRNWDVhYWpoWnVCWVBFbmFCZWEwK2k1VDhKRkpYWGg3K0ZiUDBj?=
 =?utf-8?B?QzRJa0krQXUwSGg3T25HT0ZJckxLTVh6Wm5qeWpNNTg5ZEN0WnUzWlhUcGhs?=
 =?utf-8?B?dTJnelEvY3JYZ1MzSXdsSzhSVDhnRDdPVmlEbkcrcjVMWnFrZkw5MG90K1Ft?=
 =?utf-8?B?K3hGMUtCNy9lR08rNXlPeEhuODJmYzRLWnlseGE5QXVIQUtISFdEdmhBQzRx?=
 =?utf-8?B?ckJvMlJ6L0d4MTM5YWZ5aDdWME9kdFJ0RnNjRnc5YWo0SkdNZGhkNjd3U0Vs?=
 =?utf-8?B?NFBISDdqbXdLLytmemNsQnNVOWxKRGp5dFllSGpVL3lMYkt2aURzeVZDNFJ0?=
 =?utf-8?B?a1VjcG1nVFFjcDRxenorNHFRWDlFWXM4SmdIZVV6UjA2dkhXWlVWQlIwR3M2?=
 =?utf-8?B?UGhwVU1hMmV1QnJHNE1WOWNmaGVjeldkcXE0VkFSUUd4UURnd3NtVXpRRlJy?=
 =?utf-8?B?R0Jvb01naHhrSS8wL0tzNUtxMlM3TFdML3lvOXBMbTNWZVZWSW9BdTZack5x?=
 =?utf-8?B?WDJxSFZNV0NSOVdRSVlSelE5eVVZYkVyQUlYWkZJcUNCUkpkVXdPNEI5Vk1Y?=
 =?utf-8?B?empldzZyUE9kUVRNU3JRYWtoYjk1UzhGaGc5aWFoSXpXQkM0RXcrVHVCNVJN?=
 =?utf-8?B?WGs2NVBiUGNhSGx5R2tna0FIMFE2UlRRMGdqZitPSkR5Y3VZL2xwbkdUS3Qw?=
 =?utf-8?B?b2lHcE1ja29MN2gxWFRSdVdtT3prY1FmVzlGMDl0V3czMy95NDZUdFVrNk9i?=
 =?utf-8?B?c2xIOXQ3c21UTHdOMlR6enJqREhmQWFobllPeENZSXNYKy9OdmhKS2xSOXE5?=
 =?utf-8?B?ZVNIazJBVkFzNm5VVU9CcG9RclZyMjNESExkb1hQMHhIYURnQ1d6SFJXWWND?=
 =?utf-8?B?aUxIWExPS0FzZ1JKN1NWNmEwa0FTM20yMnNqS0pDSWNaaEFHU1IzV0E5M044?=
 =?utf-8?B?ZENid1dNR2RHMlRPWkxDWVNiMS8yOHozazM2bWFRMWV1TkgyT3UxTVM3MHp2?=
 =?utf-8?B?WlNHNzJSRndRbCtkVWhqSnBEVmhYSEIrQStLd0M5emJOMm9rQ0ZhY205NjNm?=
 =?utf-8?B?bWtZamJkYlRxcUl5TmlIUDVCdEtFN2c0bGZ6NkdSODlvc1BNY0hFMG5mRkNs?=
 =?utf-8?B?VmtWRHB4cmJraDNBV3FnVzZKdklGdUlkM2JpYWhJMEtpWDdQRHdwRnpZUmd1?=
 =?utf-8?B?VFpRMTl1eHdkQzlQSy82V3RiVThrbEpDZDB0TFBjYUxldElvc0Z0VzduclVp?=
 =?utf-8?B?aDdpQjFXMFpoNEZHdnRzTzI5andMK05DU0JEd1F5MlVyd3dRL2Q4Q1hZVmZO?=
 =?utf-8?B?MjRuR3ZjTVp4N1NrVDF1VXJjU29xYm80ckJ3VittbENManhyeEw1U2pKbG9t?=
 =?utf-8?B?cE5rdXdkK2I1anlnUk1RRDBJLzdwYnRvTE12eFVpYmNlYzNybE83Slh6eWlv?=
 =?utf-8?B?MEtNbkgyeVFOU3dVZmpFYTk2S0svS2JEVXlTWmpoREJjR1hEK2JmbFQ3R0VZ?=
 =?utf-8?B?ZHB3ZHpPeFNFbHZ6dnh6YzNVR1RDYllmaGdvN3R5dFYwNjRxN29Ccmw4ZDUy?=
 =?utf-8?B?eEFlUGcwdWU3V1l2UGZqK1J0cmc5b0kvQ0hEUVRiVlB6czNhSnpIcFNBcnVP?=
 =?utf-8?B?ZDJ2aUZUN01hUFJtSGxjS1Bad3Y5dkxnWFZoeThpa0hwMkFLUFBTWVhlS2Na?=
 =?utf-8?B?NE11RXA1SXM0VGRiR3FvVFh6bXNOdnRvYkQxakUvYk5iQzNPQWp3L2NzaFJ0?=
 =?utf-8?Q?zVPU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013a3526-470a-41f0-feda-08ddb4a0fa7f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:02:44.8595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AgCHilS40F4Tk2iGW1RLTZO0KxH/UK8x5goknT2rDaFF0BAxxeLJVcpL459Ndph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
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



On 25.06.25 23:06, Alex Deucher wrote:
> We need to know the wptr and sequence number associated
> with a fence so that we can re-emit the unprocessed state
> after a ring reset.  Pre-allocate storage space for
> the ring buffer contents and add helpers to save off
> and re-emit the unprocessed state so that it can be
> re-emitted after the queue is reset.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 99 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 15 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 59 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 17 ++++
>  5 files changed, 191 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2d6b2b486baf7..db14bdc7053ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -120,11 +120,13 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>  		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
>  		if (!am_fence)
>  			return -ENOMEM;
> +		am_fence->context = 0;
>  	} else {
>  		am_fence = af;
>  	}
>  	fence = &am_fence->base;
>  	am_fence->ring = ring;
> +	am_fence->wptr = 0;
>  
>  	seq = ++ring->fence_drv.sync_seq;
>  	if (af) {
> @@ -253,6 +255,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>  
>  	do {
>  		struct dma_fence *fence, **ptr;
> +		struct amdgpu_fence *am_fence;
>  
>  		++last_seq;
>  		last_seq &= drv->num_fences_mask;
> @@ -265,6 +268,13 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>  		if (!fence)
>  			continue;
>  
> +		/* Save the wptr in the fence driver so we know what the last processed
> +		 * wptr was.  This is required for re-emitting the ring state for
> +		 * queues that are reset but are not guilty and thus have no guilty fence.
> +		 */
> +		am_fence = container_of(fence, struct amdgpu_fence, base);
> +		if (am_fence->wptr)
> +			drv->last_wptr = am_fence->wptr;

That looks fishy. We don't need the last wptr, but the first processed one.

>  		dma_fence_signal(fence);
>  		dma_fence_put(fence);
>  		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> @@ -727,6 +737,95 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>  	amdgpu_fence_process(ring);
>  }
>  
> +
> +/**
> + * Kernel queue reset handling
> + *
> + * The driver can reset individual queues for most engines, but those queues
> + * may contain work from multiple contexts.  Resetting the queue will reset
> + * lose all of that state.  In order to minimize the collatoral damage, the

Typo "collateral".

> + * driver will save the ring contents which are not associated with the guilty
> + * context prior to resetting the queue.  After resetting the queue the queue
> + * contents from the other contexts is re-emitted to the rings so that it can
> + * be processed by the engine.  To handle this, we save the queue's write
> + * pointer (wptr) in the fences associated with each context.  If we get a
> + * queue timeout, we can then use the wptrs from the fences to determine
> + * which data needs to be saved out of the queue's ring buffer.
> + */
> +
> +/**
> + * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
> + *
> + * @fence: fence of the ring to signal
> + *
> + */
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
> +{
> +	dma_fence_set_error(&fence->base, -ETIME);
> +	amdgpu_fence_write(fence->ring, fence->base.seqno);
> +	amdgpu_fence_process(fence->ring);
> +}
> +
> +void amdgpu_fence_save_wptr(struct dma_fence *fence)
> +{
> +	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
> +
> +	am_fence->wptr = am_fence->ring->wptr;
> +}
> +
> +static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
> +						   unsigned int idx,

idx is unused.

> +						   u64 start_wptr, u32 end_wptr)
> +{
> +	unsigned int first_idx = start_wptr & ring->buf_mask;
> +	unsigned int last_idx = end_wptr & ring->buf_mask;
> +	unsigned int i, count;
> +
> +	/* Backup the contents of the ring buffer. */
> +	for (i = first_idx, count = 0; i != last_idx; ++i, i &= ring->buf_mask, ++count)

count should start at ring->ring_backup_entries_to_copy.

> +		ring->ring_backup[count] = ring->ring[i];
> +	ring->ring_backup_entries_to_copy = count;
> +}
> +
> +void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> +					     struct amdgpu_fence *guilty_fence)
> +{
> +	struct amdgpu_fence *fence;
> +	struct dma_fence *unprocessed, **ptr;

ptr need an __rcu annotation or otherwise the automated tools will start complaining.

> +	u64 wptr, i, seqno;
> +
> +	if (guilty_fence) {
> +		seqno = guilty_fence->base.seqno;
> +		wptr = guilty_fence->wptr;

I think we can just always go over the whole ring buffer here. E.g. dropping this if branch.


> +	} else {
> +		seqno = amdgpu_fence_read(ring);
> +		wptr = ring->fence_drv.last_wptr;

Again that looks fishy. We shouldn't start at the last wptr, but the first.

> +	}
> +	ring->ring_backup_entries_to_copy = 0;
> +	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
> +		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
> +		rcu_read_lock();
> +		unprocessed = rcu_dereference(*ptr);
> +
> +		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
> +			fence = container_of(unprocessed, struct amdgpu_fence, base);

We should probably make ring->fence_drv.fences an array of amdgpu_fences.

> +
> +			/* save everything if the ring is not guilty, otherwise
> +			 * just save the content from other contexts.
> +			 */
> +			if (fence->wptr &&
> +			    (!guilty_fence || (fence->context != guilty_fence->context))) {
> +				amdgpu_ring_backup_unprocessed_command(ring,
> +								       ring->ring_backup_entries_to_copy,
> +								       wptr,
> +								       fence->wptr);
> +				wptr = fence->wptr;

Wptr also needs to be updated for already signaled fences and fences which are skipped because they belong to the guilty context.

Christian.

> +			}
> +		}
> +		rcu_read_unlock();
> +	}
> +}
> +
>  /*
>   * Common fence implementation
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 206b70acb29a0..d0f838fde2ae5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -139,7 +139,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	int vmid = AMDGPU_JOB_GET_VMID(job);
>  	bool need_pipe_sync = false;
>  	unsigned int cond_exec;
> -
>  	unsigned int i;
>  	int r = 0;
>  
> @@ -156,6 +155,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		gds_va = job->gds_va;
>  		init_shadow = job->init_shadow;
>  		af = &job->hw_fence;
> +		/* Save the context of the job for reset handling.
> +		 * The driver needs this so it can skip the ring
> +		 * contents for guilty contexts.
> +		 */
> +		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>  	} else {
>  		vm = NULL;
>  		fence_ctx = 0;
> @@ -309,6 +313,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  
>  	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
> +
> +	/* Save the wptr associated with this fence.
> +	 * This must be last for resets to work properly
> +	 * as we need to save the wptr associated with this
> +	 * fence so we know what rings contents to backup
> +	 * after we reset the queue.
> +	 */
> +	amdgpu_fence_save_wptr(*f);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index f0b7080dccb8d..45febdc2f3493 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -89,8 +89,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  {
>  	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
> -	struct amdgpu_task_info *ti;
>  	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_task_info *ti;
>  	int idx, r;
>  
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> @@ -135,7 +135,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
>  		dev_err(adev->dev, "Starting %s ring reset\n",
>  			s_job->sched->name);
> -		r = amdgpu_ring_reset(ring, job->vmid, NULL);
> +		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
>  		if (!r) {
>  			atomic_inc(&ring->adev->gpu_reset_counter);
>  			dev_err(adev->dev, "Ring %s reset succeeded\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 426834806fbf2..0985eba010e17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  	/*  Initialize cached_rptr to 0 */
>  	ring->cached_rptr = 0;
>  
> +	if (!ring->ring_backup) {
> +		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
> +		if (!ring->ring_backup)
> +			return -ENOMEM;
> +	}
> +
>  	/* Allocate ring buffer */
>  	if (ring->ring_obj == NULL) {
>  		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
> @@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  					    (void **)&ring->ring);
>  		if (r) {
>  			dev_err(adev->dev, "(%d) ring create failed\n", r);
> +			kvfree(ring->ring_backup);
>  			return r;
>  		}
>  		amdgpu_ring_clear_ring(ring);
> @@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  	amdgpu_bo_free_kernel(&ring->ring_obj,
>  			      &ring->gpu_addr,
>  			      (void **)&ring->ring);
> +	kvfree(ring->ring_backup);
> +	ring->ring_backup = NULL;
>  
>  	dma_fence_put(ring->vmid_wait);
>  	ring->vmid_wait = NULL;
> @@ -753,3 +762,53 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
>  
>  	return true;
>  }
> +
> +static int amdgpu_ring_reemit_unprocessed_commands(struct amdgpu_ring *ring)
> +{
> +	unsigned int i;
> +	int r;
> +
> +	/* re-emit the unprocessed ring contents */
> +	if (ring->ring_backup_entries_to_copy) {
> +		r = amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
> +		if (r)
> +			return r;
> +		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
> +			amdgpu_ring_write(ring, ring->ring_backup[i]);
> +		amdgpu_ring_commit(ring);
> +	}
> +
> +	return 0;
> +}
> +
> +void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
> +				    struct amdgpu_fence *guilty_fence)
> +{
> +	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
> +	drm_sched_wqueue_stop(&ring->sched);
> +	/* back up the non-guilty commands */
> +	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
> +}
> +
> +int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> +				 struct amdgpu_fence *guilty_fence)
> +{
> +	int r;
> +
> +	/* verify that the ring is functional */
> +	r = amdgpu_ring_test_ring(ring);
> +	if (r)
> +		return r;
> +
> +	/* signal the fence of the bad job */
> +	if (guilty_fence)
> +		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
> +	/* Re-emit the non-guilty commands */
> +	r = amdgpu_ring_reemit_unprocessed_commands(ring);
> +	if (r)
> +		/* if we fail to reemit, force complete all fences */
> +		amdgpu_fence_driver_force_completion(ring);
> +	/* Start the scheduler again */
> +	drm_sched_wqueue_start(&ring->sched);
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 784ba2ec354c7..2b5546d15a6be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
>  	/* sync_seq is protected by ring emission lock */
>  	uint32_t			sync_seq;
>  	atomic_t			last_seq;
> +	u64				last_wptr;
>  	bool				initialized;
>  	struct amdgpu_irq_src		*irq_src;
>  	unsigned			irq_type;
> @@ -141,6 +142,11 @@ struct amdgpu_fence {
>  	/* RB, DMA, etc. */
>  	struct amdgpu_ring		*ring;
>  	ktime_t				start_timestamp;
> +
> +	/* wptr for the fence for resets */
> +	u64				wptr;
> +	/* fence context for resets */
> +	u64				context;
>  };
>  
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> @@ -148,6 +154,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
> +void amdgpu_fence_save_wptr(struct dma_fence *fence);
>  
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -284,6 +292,9 @@ struct amdgpu_ring {
>  
>  	struct amdgpu_bo	*ring_obj;
>  	uint32_t		*ring;
> +	/* backups for resets */
> +	uint32_t		*ring_backup;
> +	unsigned int		ring_backup_entries_to_copy;
>  	unsigned		rptr_offs;
>  	u64			rptr_gpu_addr;
>  	volatile u32		*rptr_cpu_addr;
> @@ -550,4 +561,10 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
>  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
> +void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> +					     struct amdgpu_fence *guilty_fence);
> +void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
> +				    struct amdgpu_fence *guilty_fence);
> +int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> +				 struct amdgpu_fence *guilty_fence);
>  #endif

