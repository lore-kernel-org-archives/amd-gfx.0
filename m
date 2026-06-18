Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE121CD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 11:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC3710F290;
	Thu, 18 Jun 2026 11:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nnkXQpUU";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2AC10F293
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 11:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPQne5xGF50+HNGAAarIlbhXLYQ8uhincs763To9NK9Y5nldF957i0jbN9ZPPbiZAJ+gPgqotMoALVVLWTSAjc68vvNjTB3DAIKTNCjyrhUohYGvRxDUpq0LA9LWwh+hm8eYyAYfCpV1aiNFaMK33KjDJTYQ3rQsKt7xxxF4yJdF85Q5IsSyp2UJD0+pGQzNkhAoT2VMoqFpmt59QvaUwvdT6b+n12NuozHyI7XyAr9mWTe6wDuGEtGBcV3xFu11L7AaLfLU5N4jCLxVLfIJsdt4SnZgb9Un4CVT88k5SMfRymn6eArPDr4Z8u+9qqj4PISs3srKcnDWzCKy8VLXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og4B5I3N9drGZZ5AMb84jZQYu9TNg6KEwnpDTx2S+TQ=;
 b=M8rziNZ0SUbtezIwxzpEP7+WcbQHGPEGDFIdCvBD7ZWlFb8TsF4o1AU6qTj2qOOPFlAnRFOpx0vmxpbaX20CZ4pXJU7HS9Z8K7b7TDIF8ysGgd1VJ0vhHlRY/K65FY7eH2ib5gwNyKYYYTteS8JtFpSiNw04T+u6pmtVaukk4HBxU8pme3Pq4NW27gDnknj/h69rfTOpvSPuzEsiOXylRdEhuYY8lXQRpsFJJX6kUj9R0+EevmQARVe2uaXRxGPPVLYzSqdR2NrQhRu2W/2olEs0q8k5umzKuehhGbFAHvRAho+IKfnn2QFPy3UgoIZBBUgrPWZC4il2qOeF7sxKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Og4B5I3N9drGZZ5AMb84jZQYu9TNg6KEwnpDTx2S+TQ=;
 b=nnkXQpUUSPYCZsrviolrcSUwesiFIhsZJM9TRguu7OKW1xPEx+2GNQESQs7gCZh6zY/g0B1auPoPvURoZIXrVCKzSETmG0tpxXamWjJyiY09GyjIM25+UrybVjWRoW9copmN/h/ko+mFeb/MRB4OVjis7RtgVwYtOA+xV9qOZFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 11:53:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 11:53:17 +0000
Message-ID: <7f432124-38fe-47e2-8beb-0f3bc37aceff@amd.com>
Date: Thu, 18 Jun 2026 13:53:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] drm/amdgpu: Delete GMC 8 soft reset
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOh?=
 =?UTF-8?Q?k?= <maraeo@gmail.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Lazar Lijo <lijo.lazar@amd.com>,
 Martin Roukala <martin.roukala@mupuf.org>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
 <20260617191428.1784083-4-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617191428.1784083-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:52c::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: bd228da5-63c6-4c35-405d-08decd302fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Ph3yL9IAfSx6u5t2cu2qVPvX5aG5FR72fGG0xlqQVOOWE3QZut6NvOqcm3VRKni0WHYHLLG2uf2hmpwmspXMYj4XKKPRFi8DIoLFBuzwBDxMFLvmgfZ98bzUj77AetroGZs2TR4V7ZO9gBR7+aVA9qZsu0bapETW44sHPhjkvFHOKvRaWgMqIFgnEY8xvK1+fvsIMVWItkbPj5SMZOzOusbIQmje9Vywwt9KUqx9ibyxdDlvC4xYloBj/kQuiaQ7exChsO3aYN2BRIspeVIdKhnQItUCQ5bzwrcV3gfhEJj0M0hPn7DynigjR8Ak0J8p1+OEXxABoS1EtCrVRDkGZjsVzYPA5LYFCnn6jcGEbsfL4P3gV+svQ4vA/NytuTE9WaCRJEyOK9L7EZ/Xyy+aS5c6H6/b8RUdJQFGmhfqPPgRM8Bst4z2z0dx9veEfKD4prUIwLYoJb1o6B6/GrSod9vjkEHpWnM8ACczfjSxpaQJ0+Be8PMneNkmRxqRHxQxMj0uh+kP3kJZguSwqlN0kfk/DLprfYFsWWiQA69EfTtKvTH/OQWqMqsreCIl9dP//aSn2/LyQLjrg9pnYWei5jOSiUiXhSUnaDCCeM+SARQy5JeDjaJW3wEjyquQBUA+HpO9AVN85OfhIdPjgiYP36cmI3cIbd1bcCKavSQR6AUzX2GtrEjUn2r+BHZHIq4I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjlWOGlsNER6V3F4TmYrVE9MZ1hpaWYxMDEvTkE4YVdCTUc4aDYydUZDczcr?=
 =?utf-8?B?TDdSZmVST2d0UGo1UmdReEtIM2dLaUVOQnhWaVlrZVZnN1VYbVJPeC9ZOU8x?=
 =?utf-8?B?THJUSFArSk5yTFo4b0gxMXFmWGZkY3BiU1JXWEFKZWZ2MGxNanNEeW1rc1lO?=
 =?utf-8?B?bUt0NzdiY0VGTHJzUUJNSXJQRlVNUmc5NnVUUVMvOWVySGkvbnFEWGhaMTA1?=
 =?utf-8?B?ZFZ4ZmM5QXVHN0RUUXV6UkdNTUYyWi80Qk9nMXB1ZzhnY0xob09UWFFVVlJj?=
 =?utf-8?B?ZTk3ckxhS1JNWVNiUTNqMFBDWnQxaUsxQnJla3ZEc1ZpTHBXV0VPS0Vvd1I0?=
 =?utf-8?B?SVBEVnJ3Zisvdk5McFhkcUhvRUZaQlMydXg5KzJlU0UzMVlkTmNEbWY4WEVv?=
 =?utf-8?B?SXN2a3k5QVF2dmhqUmYxc0Rya0pZZXdUVk5HUGNKOXkvVitoTHZkaWQxR3dP?=
 =?utf-8?B?UVFvYVJIWGt0QlRjcDlITnYxU0xtQ0d5Tkt3RnlLcW9NdXViT21HcmFNSlRQ?=
 =?utf-8?B?Wm52REhKRTB4T1VPYzR3UmlzZCs1OE10a292bnJVb3l1MzF6Q1djeGF5SnhR?=
 =?utf-8?B?VDcyQVNTcDBHM3VVaVdNV2FDMTFDNWdTVUFFbmZzZzJvUndTNHA2WHNkK2FN?=
 =?utf-8?B?dVJjeEF3dmZ1WWVBaTQ5NCtXMXFYaDUwSnJ0YjBCRUFJUk9xbG9semVoTFcy?=
 =?utf-8?B?UTRldURQRGVhZFUrdGt1RllUSGorc3VjZTF3V2x2TzBlWk8yRkhZVUgvS2JB?=
 =?utf-8?B?YTdvK1crWEE0Y08vYjB4cTdUSmZXcWVFbDlHZi9ETXZQVG1INFNSdVV4VUR5?=
 =?utf-8?B?ZzZrN1o3V01ONGp2aHBvODJaVVBHMkVFYkhLVmZnUTlVNDZvZEwwVWhXb3BC?=
 =?utf-8?B?MTVieGlOU2J6Rk1tUTBERXB2VWowOVp0YjRUZHk4b3FuVGlDMjF4SnQwQm44?=
 =?utf-8?B?NmEwazRjQ1Z6OUF5NE1kcTRLQUsrQUZSSzdIU2FWOWl6K1RTM3NJV0NibmpD?=
 =?utf-8?B?MEVJL2F6TGtCYWpWL3o1RnNSUkZtWVdHcWVReFNUT244ZDFlcU9ZTURDZkZV?=
 =?utf-8?B?bjE1dWNhZEVDK1UvbUNwRmpRSjBNalA2UzRwRG40TFU2UlZTYUh2bk8xSlBq?=
 =?utf-8?B?QW1Wb3dxVE4wOUdpYTNDTzJqak95eS9PNlFaZS8ydDl4cXduWDVRcU5ScGtS?=
 =?utf-8?B?ZEV4cllla3pBTFQrbkNtam1FOGZ6ZUl6djlRVkpycXN6TzhVbjBEYWdDM3JK?=
 =?utf-8?B?NjA4NEFxU2RKSWVQbU5va0lJcW1uUk44M3AxKzNlU2NVellaZW1OYjhyVis2?=
 =?utf-8?B?WEhCcEZiNkk3dGIycWNuK2hUVnhrZjZZNkdHbnIxMDlZTGZxT1lGdXQ0U2oz?=
 =?utf-8?B?OEFubXM5QmZzbTJKMmx3L3h1Q2RySDB3aUw3eExodEY1eElRRzBRNUFMRXBa?=
 =?utf-8?B?VERiMG9pT3ZmMC9Tc2h1SlJ0OGV6UktxcjNaVW5jMEtKR05CbkdpbVlZaXk2?=
 =?utf-8?B?V2JBMkdBc0FoR0N0b01UdVRiRWs1Y3dOOU9xaXJjVW5CYytqajloakVNYWZE?=
 =?utf-8?B?YUZMVmZ3ZFlrdkgyOVNXMHovdVloVklZMzJPeWNPU0FDaVBJcmR3Rmt3TTcy?=
 =?utf-8?B?cHBUZDUycFNHcHNqUWM0TW8rUTlzb1JaaWdIdGQwWW5UTlFhdGUvN3JybUFB?=
 =?utf-8?B?U1hxdzNhK2dnQjBxMWI1TTBpZWJ6NUMwd2RDMElFNW8zN0lJcVBMY05vSlBN?=
 =?utf-8?B?bk1sVVBIUnppWnFEWUhWandESzNSK2FxRU5hUVA1SXNndFc0VnBsYWxwcXBR?=
 =?utf-8?B?ODVGLzNidGpiT3lxNjg4djVTYVlZck9Fa0ZoZzJZRVYwRFhSc1g1YTRUUFBu?=
 =?utf-8?B?eENUK2xlZ0I5S2dlUGp6bThWZmdtdnZVekd0VTJaQkc1VjQwUlhJMjRmS3dV?=
 =?utf-8?B?MkRsei9jWEJFRkdLSElNZE1veW9PQVF3VVdRcVVXVHhkQUR1ekFpQTN1U1Bm?=
 =?utf-8?B?dWp5cWNweHVqNnZLVEMwT2tvYW5zRGxTbldOS3BidU5JakJBQ1FtcFNZQnNo?=
 =?utf-8?B?NnBDNjVLaFA2Wm1Pa3FIVVJHOXQyQk9xYVZCeU8rNk5nSXY1cEdSNVZmaTJj?=
 =?utf-8?B?cTVOc09PWFBYZW9ueUREWG9ZaXlVUVZwQkpMSEpQbWFpb3pOVGJoNHhKVHBD?=
 =?utf-8?B?YzlNVHduNFppalJweFBqd2paYUZ6OEt4MnNVWGx3aUdLU05RaFRYbGFEQTdk?=
 =?utf-8?B?R2hFQ2dXaVN1TXBQYVNrbEgweTh5NW5GeUcvOUhUWXdMOFNYRTZCaytpK1d2?=
 =?utf-8?Q?NBJ3ToAgiI9K+x7EEy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd228da5-63c6-4c35-405d-08decd302fa1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 11:53:17.5977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tELbeC4TcU8luy7jlZsGGtA0Jln6SrSVV/meEhsI1P3r+PUPqfFoJ0Vu1aTMv5y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
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

On 6/17/26 21:14, Timur Kristóf wrote:
> We should only reset the memory controller during ASIC reset
> and only when it's absolutely necessary. Otherwise, resetting
> the memory controller typically just breaks everything and
> on dGPUs may also clear the contents of VRAM (it's unclear if
> it really does, but it's likely).
> 
> Specifically for GMC 8, the memory controller is reset as part
> of the ASIC reset and otherwise should be left alone.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

I'm a bit suprised that gmc_v8_0_mc_stop is removed as well, but yeah it is clearly unused now as well.

I never touched this code, so I think Alex should take a look as well.

Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 125 ------------------------
>  2 files changed, 126 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 676e3aaa1f27..f3f42f773171 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -285,7 +285,6 @@ struct amdgpu_gmc {
>  	struct amdgpu_irq_src	vm_fault;
>  	uint32_t		vram_type;
>  	uint8_t			vram_vendor;
> -	uint32_t                srbm_soft_reset;
>  	bool			prt_warning;
>  	uint32_t		sdpif_register;
>  	/* apertures */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 1d3ddffd5a11..37f7777e82d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -167,44 +167,6 @@ static void gmc_v8_0_init_golden_registers(struct amdgpu_device *adev)
>  	}
>  }
>  
> -static void gmc_v8_0_mc_stop(struct amdgpu_device *adev)
> -{
> -	u32 blackout;
> -	struct amdgpu_ip_block *ip_block;
> -
> -	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GMC);
> -	if (!ip_block)
> -		return;
> -
> -	gmc_v8_0_wait_for_idle(ip_block);
> -
> -	blackout = RREG32(mmMC_SHARED_BLACKOUT_CNTL);
> -	if (REG_GET_FIELD(blackout, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE) != 1) {
> -		/* Block CPU access */
> -		WREG32(mmBIF_FB_EN, 0);
> -		/* blackout the MC */
> -		blackout = REG_SET_FIELD(blackout,
> -					 MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE, 1);
> -		WREG32(mmMC_SHARED_BLACKOUT_CNTL, blackout);
> -	}
> -	/* wait for the MC to settle */
> -	udelay(100);
> -}
> -
> -static void gmc_v8_0_mc_resume(struct amdgpu_device *adev)
> -{
> -	u32 tmp;
> -
> -	/* unblackout the MC */
> -	tmp = RREG32(mmMC_SHARED_BLACKOUT_CNTL);
> -	tmp = REG_SET_FIELD(tmp, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE, 0);
> -	WREG32(mmMC_SHARED_BLACKOUT_CNTL, tmp);
> -	/* allow CPU access */
> -	tmp = REG_SET_FIELD(0, BIF_FB_EN, FB_READ_EN, 1);
> -	tmp = REG_SET_FIELD(tmp, BIF_FB_EN, FB_WRITE_EN, 1);
> -	WREG32(mmBIF_FB_EN, tmp);
> -}
> -
>  /**
>   * gmc_v8_0_init_microcode - load ucode images from disk
>   *
> @@ -1293,89 +1255,6 @@ static int gmc_v8_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  
>  }
>  
> -static bool gmc_v8_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	u32 srbm_soft_reset = 0;
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 tmp = RREG32(mmSRBM_STATUS);
> -
> -	if (tmp & SRBM_STATUS__VMC_BUSY_MASK)
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
> -						SRBM_SOFT_RESET, SOFT_RESET_VMC, 1);
> -
> -	if (tmp & (SRBM_STATUS__MCB_BUSY_MASK | SRBM_STATUS__MCB_NON_DISPLAY_BUSY_MASK |
> -		   SRBM_STATUS__MCC_BUSY_MASK | SRBM_STATUS__MCD_BUSY_MASK)) {
> -		if (!(adev->flags & AMD_IS_APU))
> -			srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset,
> -							SRBM_SOFT_RESET, SOFT_RESET_MC, 1);
> -	}
> -
> -	if (srbm_soft_reset) {
> -		adev->gmc.srbm_soft_reset = srbm_soft_reset;
> -		return true;
> -	}
> -
> -	adev->gmc.srbm_soft_reset = 0;
> -
> -	return false;
> -}
> -
> -static int gmc_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	if (!adev->gmc.srbm_soft_reset)
> -		return 0;
> -
> -	gmc_v8_0_mc_stop(adev);
> -	if (gmc_v8_0_wait_for_idle(ip_block))
> -		dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
> -
> -	return 0;
> -}
> -
> -static int gmc_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 srbm_soft_reset;
> -
> -	if (!adev->gmc.srbm_soft_reset)
> -		return 0;
> -	srbm_soft_reset = adev->gmc.srbm_soft_reset;
> -
> -	if (srbm_soft_reset) {
> -		u32 tmp;
> -
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -		tmp |= srbm_soft_reset;
> -		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -
> -		tmp &= ~srbm_soft_reset;
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		/* Wait a little for things to settle down */
> -		udelay(50);
> -	}
> -
> -	return 0;
> -}
> -
> -static int gmc_v8_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	if (!adev->gmc.srbm_soft_reset)
> -		return 0;
> -
> -	gmc_v8_0_mc_resume(adev);
> -	return 0;
> -}
> -
>  static int gmc_v8_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
>  					     struct amdgpu_irq_src *src,
>  					     unsigned int type,
> @@ -1715,10 +1594,6 @@ static const struct amd_ip_funcs gmc_v8_0_ip_funcs = {
>  	.resume = gmc_v8_0_resume,
>  	.is_idle = gmc_v8_0_is_idle,
>  	.wait_for_idle = gmc_v8_0_wait_for_idle,
> -	.check_soft_reset = gmc_v8_0_check_soft_reset,
> -	.pre_soft_reset = gmc_v8_0_pre_soft_reset,
> -	.soft_reset = gmc_v8_0_soft_reset,
> -	.post_soft_reset = gmc_v8_0_post_soft_reset,
>  	.set_clockgating_state = gmc_v8_0_set_clockgating_state,
>  	.set_powergating_state = gmc_v8_0_set_powergating_state,
>  	.get_clockgating_state = gmc_v8_0_get_clockgating_state,

