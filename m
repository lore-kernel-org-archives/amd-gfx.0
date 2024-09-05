Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DEDCD5BA9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 11:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8405110E869;
	Thu,  5 Sep 2024 11:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSSK4TXv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F275510E870
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 11:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH62henVZviOVbZyxBOGZ/vnOEjmDzyv3pFaQSJSv5nBGeRd0w5JEw2+QGsZo4odIyUtutdktXlhtgP4p1oLPC1lGRi67588Lo3yUthowc5hq1pX/luiD2MDrIlL4Ha2a1fF3F4jlphpMTGHD4vaz8555lpoHRQqx4ANT1o1NSk7zzdRWM+ekS0l/CP+v1VjirJByk/RMlzTa9KvBr8PmCnDeW9ENwsK9coUhIOtkCnSDCFALME0Kf0U5cKeSWunl6WEWbKlKN/8v5NeU9D/XAYdBJ9PoCAC8LJTaB1kLdZJAInwVxj3AgwXkaAB34eD+L6unESWK+mQVToC3/296Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woyjfsW8Mjbj2rfN9hvOhT57leNKQZwi5rwZpX3UNK8=;
 b=avN/OCfDr0W2DU+9mSs74MY+35yx/JeAfqK5gowwFqT06O86573YX4GLWwUfBYeNE/+oJWFNXUv2keqgXcSQFr/ysV7Y4snR9VUqhBeFBH5Z0DIi31z0s8SUWIPnPAhZE8wx2xRYqpo1ZP0cMVvZ5sLU7HOvFYycSJFXaaWM3z+x/MW4WtnmDJt8LhdeBsWhv50J3OH8dG9f4dqrPb4ZdKjzw6iC8385ICTlulhSvfuBsxlimb0P9hHVTtEM6FIMTM8iamCXOLslNfVhXWFeum+0BH9XSL62rYaxXtB0ZnonwIJ9SAHxyboSDRibJ0cwBsqRPHCOFmZr1QBQFwGagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woyjfsW8Mjbj2rfN9hvOhT57leNKQZwi5rwZpX3UNK8=;
 b=LSSK4TXvF3S1+RpSpzHlE06I8y3xdlOL00BtZETfqYHeZOl8pIU4NCk9kKT+XSLYAkrGTl2w/vNz59L4Dq+H6ttTkRziuiiGYKxynDLUTutcG/WwRM4kp54z5Vm1/6DTuTA2+eFNNKWAe+O6cNLsoXMVodkx3dZdhKzDQyAtbEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 11:17:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 11:17:33 +0000
Message-ID: <c93d6652-08fd-40fb-a629-d52bec489ede@amd.com>
Date: Thu, 5 Sep 2024 13:17:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence
To: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: nikprica@amd.com, felix.kuehling@amd.com, emily.deng@amd.com
References: <20240905085841.18189-1-Dejan.Andjelkovic@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240905085841.18189-1-Dejan.Andjelkovic@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: b5789075-d5f6-4238-b5e6-08dccd9c56a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGs4NWdZS2ZJVmtzbnhUaUxWa0huRnhaTFdGaUZUbE1ObEdvOXNNZUFTVkdF?=
 =?utf-8?B?OEZ4NmYzdHVHOW9ORkk5VnpkWHFNRXhmT2NDbXI5VWtuR0tHK1E4aUduMml3?=
 =?utf-8?B?aHFTQ3RlNGg3SlNkQVd4SlNGN1drQUZPckkzY21vK1daeityMjVoRDYwQ2pl?=
 =?utf-8?B?Ty90WUNkOWtnaUxGcC90QmxyeFpzWWdFcE5EZkwyTXNCTjA3Q3VXd3M4dkdL?=
 =?utf-8?B?S1o4RmhzRnBqNDNPVkZOcGdycEVuM0tlQ0w3RlFQdklBNmxyYTgyOTk2REZI?=
 =?utf-8?B?eFVzNG5LNjdoSEZEY3RuWDE0QWp0QjNPOEZFaGg3VElVeVN3UG5GYnppbWxT?=
 =?utf-8?B?NFFBWWY2Z05iY1BhdStkVVNhVmFzY0xzOGlRc2g2QUZHN2hzcWhkaHE1ckZm?=
 =?utf-8?B?bS9TN1FsRXhTTHNvVjZjTFlOY3Z1YlVLc3pFUzdNNFJlZndtOTkyejI1dmtT?=
 =?utf-8?B?OE56U1Rxc1IrRG40SEZoM1E3YnY2cFVOMmRiMERCWnIrTjN4RXF1dmVPRXJu?=
 =?utf-8?B?Yk9hdGpjaFNWc2pKVnRhdnFBTWRUTkxEMVZLOFdleVlaT3BYWDlpVmptemZX?=
 =?utf-8?B?VmxEWEg2WU4zQWdHbmNFeEN0Q3BkSEJCMUdZZjBTeWlxQ2Z1Lys5SjJqcEJy?=
 =?utf-8?B?ZGxRbTdpdVpYdlF2ZnJZQnJSUzlnTTdnOVhXMmlEQ09jMjcvSnJBWGFBMjJj?=
 =?utf-8?B?Y3BOZ0tqVHR3aXZyS2x1cVRTZUgrUlQ4RkVhbDZIeGJtZEFXbVduQmtLN2k4?=
 =?utf-8?B?Z0JsOFF6NlVscEtYbExpYW92L20xVzFXaEw4R0QxTjlsbmkrVWxtbFFuYS9p?=
 =?utf-8?B?dmdGTWpUSDRQN2poSnNQdzZMMDl1WUl3T0xWSGpEUzRyc3Y4L1ZvVkxSSXZt?=
 =?utf-8?B?aDA5bmdaVStOTUNRYS84NU9kN2FEeU5MQzRjTGxPY2tpZXE4emZBcGF1bXJw?=
 =?utf-8?B?WFltclhrY2VSVG1xc3MyM3pKTEMvSG1UaDNTdm1XR1JJZXAyNFpuVUNUQ2hH?=
 =?utf-8?B?aysrbzdYVUthMTlER3A4UFdwVXZCRkRvc09CNXVIRG0rem5MbDlwSGQvMThk?=
 =?utf-8?B?OTZMeG1XbVNtU3dFMzVObjRmMEloV3pwR0ZvSHFFL2ZYbkt0cUlacktKUHVC?=
 =?utf-8?B?bHNzQjlrcU8xTklMNUN1T1ducEZiRnpwMHpQTFQrcUxYSmpPQ0FsbElFWlo5?=
 =?utf-8?B?MkFoc2tiR0NVSEh5S1ltMWhzMXRmdEZHOUJtVTNiSVZnTjJMVFVBSXB1SzBt?=
 =?utf-8?B?b1B5U0x6L01PV1Y4QTZYMGVYVjl6R0NBUEs0TzNrdlJzeWNjZFpxT25meWw1?=
 =?utf-8?B?TmhSZm1Zb2czR3ZBY3FYaTZwaXdLUXlrZWJjMjFzSGE1Nzh5WjhoMlIyejRW?=
 =?utf-8?B?ZDFHVzdtU0diZitPK0J5RTNFL1JjWS9jdEFjWUMrcjFKUDZ3ZHNkeXJpQkRG?=
 =?utf-8?B?alpUMllSaHNoVFRJSkNrU3lucGJoUjRDSDY3SFNya2diRHQ2US80ekFldm1x?=
 =?utf-8?B?VGtRbzgzMkZQWWp3cHA4ZUFLelpaSjloeGNrMURGNUIwbHFKUHhaN0ovNGVa?=
 =?utf-8?B?S3hueEZHWXEzdXFDMitnNnNlRnhnUW1pLzRoZ2RVcGhHTTZ2ckxqVFZkOVZN?=
 =?utf-8?B?NGhBZndtU1RndXkreDRBL1ZBZVhlMU9ISjBadEVIVjlyRkliaTQweGdwYzRD?=
 =?utf-8?B?ZGFTbmh4eEtYYjN4TU1BWVlsa1EyTFlnbVp6ZStvdkRXbk1xcCtKZ2wvQ21w?=
 =?utf-8?B?MCtBcXhlTFhDSldtUTZDay9ZcHQycklwVzAvVWNoRnpkWnVBbHdhbXgrdHZh?=
 =?utf-8?B?V1hsZGhFUmFabWh4Ni95dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFBUb2ZzSzZrNnM0eGlEQUZuUzY4ajl3SHdlRE9CTkFWU0U1L29adkZ6ZEpH?=
 =?utf-8?B?elB5d3RBd2NLNmdIRGlWTFo0Q1dQZE9HYXg2ZzJ5VU1TZzY5bDFleHJXMm5a?=
 =?utf-8?B?SWlEZ1JabzNaakNJLzJpZEZjV3IyM3RLS2RtTUU3ZHVQKzdIWGdkZ1dkSm9j?=
 =?utf-8?B?ckN6NlBMSEViZC94L2RoRExrb3ZzaGlOTStOdmtiSnkxOGhjRnlNdlNPM2d1?=
 =?utf-8?B?OHY1UDVsRjBWeEdEcDBONzNaMXBaNmRTNTFkNytKQUFRN1dWMzFFem1ZQ1ls?=
 =?utf-8?B?WGJyaDJqL2QzL0NCaEZYR1c4eC94eStnRzBDK01pYmpwYXN2YVpSbmluUmg0?=
 =?utf-8?B?amt1SER0MzNISlFldEc1cmtKNm9tQm04SnBrLy9wK1VJYldVSEZjSG5acjhj?=
 =?utf-8?B?cGxFSSt0WG5wRjFsc1lvVjF4RXA5a0UzSDZJaUMzUlduZnVITlk4TkpvN2xo?=
 =?utf-8?B?MlB4ek9Ea2JDKzlyNktDdVk0eW5sSHpyY3RwdTVveVpPV3psTjZuZnZWMWdL?=
 =?utf-8?B?Skl5WVRZL25xcEoyUXlPT2FaWjJLUCtqRWwvY016bGJXekM1VXBsYlUrZXhh?=
 =?utf-8?B?eE1lVDBMbFhIU1dkb29tV2tQTHhDN2JBcmZvbEg1MjVEOG50akVIWEJ0THVZ?=
 =?utf-8?B?QklTZVhhQnhUbWNMNmZpUG5hK0pOaG9vNXlxTjM0dXRYbUJITlZlcDJxc051?=
 =?utf-8?B?TGNER0t0UzY0LzhKSGQ3UWtYWXRTK1FLMit5NHptKzJBWHpjZVE5TTVFemtD?=
 =?utf-8?B?NHJOd2M5V0lvS2lDOXBLeitlSHRuYStGM2ZlTzRyMVNwK2lDenhKSEphQTht?=
 =?utf-8?B?UEhPL1IwQ211YU5YL0VVWUdnY1hKQVkrOGJsNGJ4WTlHWWdwb28rWVl4VkdB?=
 =?utf-8?B?dXpxUm14R0FYR3d4NkdHTzR3UVRhcFUyelRha1Z5QWd0NzV3VVpXaExET09h?=
 =?utf-8?B?L3BCNFdxNXl6MHNVU2M3aDB0dExJQ1FQT0x6RlFjM3JQd2pWKzRoR2pSZ1Zw?=
 =?utf-8?B?aHJZYTVIdnBLNkFQTEw2NE0wTS9qaXRPMzVQM2NUM0NQV2l2T2xZbXRsSTk5?=
 =?utf-8?B?OE1GYUl1UVhrRCszK1RyT0xLZmtKcmZvbUQyZ0FTQ3NSRTVnN2dWVmRBSWMw?=
 =?utf-8?B?SElFYnBKMWZMeml0WUllNzFMVVlKU28wYXFWcU1HdmFnN2EzdDhiK1pXU0Jk?=
 =?utf-8?B?MGZNeWhuR2toZkw1L0JQR0FTb2Q0Y3RncHhvd1phWW1jYzVzc3hBUXpLVVlU?=
 =?utf-8?B?d3B5dXRQL0NaMVQ2OStOazFaR09qenVPazRVaXhVYkkyRHZuN3poa283V2pa?=
 =?utf-8?B?L09ad1o5dWwwUFlCQ0FmUG9Mek85TGU4aHpzcFc3RkhuWXJQWG04bjJac2VO?=
 =?utf-8?B?RHlOeTZIcGF6U0pZTUIydlZsenJ2RThDNHdYS2VscHN1SXIrUjVvQUJETXc3?=
 =?utf-8?B?RmVNaVB5bFVBc0dLSE9ldEVodm1LbWVXZHZxVjBXam5TdDI2RWFyWnFTYW9S?=
 =?utf-8?B?QVlMdGpQSWFZS1JSdit4cGpiTGlGTUE0Ykw4Umh0MDZBdXdnUk4xaHJqLzhz?=
 =?utf-8?B?UnNvRlRON1BFUVUrS2ErUW9XYzhjaU9mVU1XY0o1YVV0SXRHME9MY2FNL2xT?=
 =?utf-8?B?S1J0MmkwdEswTElIaHQ1TUZFUVBlV05hUkhZUmhDTzZ2ZWVwYjE2c1RFWFdD?=
 =?utf-8?B?aGhMcVJ2a1VZWldHSVpTMkhOTGhiT25DQnJRTHJZa1RTaTNJby9RbG9EWHlz?=
 =?utf-8?B?SitPTURJUVVZQm9jQXBhRUIzN2x5eDZpMHFTNWxnUE1nM3pUK2R4dHlFY1Nq?=
 =?utf-8?B?UURqYXBOZDBBVmE4cFdZeUlHM1BLbzlKY1E3RzcwbStkTnVUVTgvMHBVVWFJ?=
 =?utf-8?B?Umt1SnV2REZrMzZtVDJPRDRKSWhtYnN0YVpqS2VWRkpIZFdVVUM5eXdhQWpP?=
 =?utf-8?B?R0FJblRPaVliNjVXa05ualYydHdpZnEzdDRmTWdsamVOelhVTFVyaDdtS1pj?=
 =?utf-8?B?ZU9wODlYR3N6cFc4RHptbnp6S01ObktQanhGNlNwS2ZpYUc0a3MwVWZEb2xZ?=
 =?utf-8?B?eDUrb0JSVHVLcGFlM2QxZmZ2amg0Qy9UOFdka3dnWUNNTTRkaUxtb1BaYVpD?=
 =?utf-8?Q?ngNkbspgrs0wkK5WUcWLXJqGd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5789075-d5f6-4238-b5e6-08dccd9c56a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 11:17:33.4466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9XkojN5ufmqN13BgdXd6RFHWmp8K8Jh8mfJXhJxIwuPmI0/V3cSPKHldttNlr8i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
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

Am 05.09.24 um 10:58 schrieb Dejan Andjelkovic:
> When using SDMA for PT updates, a TLB fence hooked to a buffer
> objects dma resv object with usage declared as BOOKKEEP leaves a
> chance for TLB flush to occur prematurely. This will lead to a page
> fault. Raising the usage from BOOKKEEP to KERNEL removes this
> possibility.

Well that's complete nonsense. The usage model is for implicit syncing 
and not even remotely related to TLB flushing.

What exactly is the problem you run into?

Regards,
Christian.

>
> Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f93804902fd3..8efc2cf9bbb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -928,7 +928,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   
>   		/* Makes sure no PD/PT is freed before the flush */
>   		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> -				   DMA_RESV_USAGE_BOOKKEEP);
> +				   DMA_RESV_USAGE_KERNEL);
>   	}
>   }
>   

