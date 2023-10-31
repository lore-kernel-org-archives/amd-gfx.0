Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF374C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 02:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F6F10E3D4;
	Tue, 31 Oct 2023 02:10:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE6E010E3D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 02:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyXLGf8Tmq5DzhcJ0oT7fAthI3xxDUUov7DOddSKbggSx8jkYvVPHitYMCNyxdpTKAmlt08zO8E5AOtTUKQNM0BOFJPVimZdgO0d8BkiKn5803uuPUVo/ZxENM9Ybn8MjRmLsnm4cxrrCKlBPL9j8VjgX8eoq63yVOaRJlzs7d/EybRoaMWzCN1kxR1rRX1i45bwRfyIdhK/doGIFbjzVZJfIcR3WIIyeYfW1DvRJux5UTnsGROnT0xsvEu0qfVl8DBtL8ev4KOcsX1uXyIBr2HuRPuS5Gicl/XPfBEcl68U7k89yIigUIcTu+rCGdnertNRO9yGmb7fNU3JFToXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FkBZp6pgVnJzi0MnVuSKRaIuvcYpmZbVei9UZJfLQQ=;
 b=McGguR4GrBoaEid2SXqReCBWEQdu2D9WXHLzdExOQT2S4JWkouLeHV/pBlsduMBntdDuXlUCKTHtS8E2UbbH83PlTT5BYtCMV+aBiU1KVoV4Tfvjjjmqpja2DMXbGhAZNt4AckNh/L82r4hS1whhXFa5yRTtWPOcKX9/nWwrBQ0rgyQ1Oh8GIZrOhJA98DrOllN+ZeasI1JRd/+SU4U9qzB4Wl4b3n7TeJ4Fr0I4He6QIA+FP1VWihRuALp5MFyCSXj6PA/7CY3DGgkhzFyKWvs6EFW4vOeupAJoNJcUbFUSC6mpYHGv+Y2SVS+ISdbNyPqpu5l1+hdI0h+d5kL57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FkBZp6pgVnJzi0MnVuSKRaIuvcYpmZbVei9UZJfLQQ=;
 b=Ldwcbt9HTYq5eMbjtSHR9o4zZwZG0Asw+bo8KqMDqlLz6HjzgQKAcwrE8oel99fIh9X5ZsmkHUzzW5m8ZCOntyzOvn5MBNhwyfitfaH7PGN+XngqCX8s1lmqY6NwH9HyI+RNjQ3TOpFGjr0l/YGVzUjQ9q4TimJkdoEa5QJ2uuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 02:10:47 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::cb63:20d5:2aeb:f1ab]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::cb63:20d5:2aeb:f1ab%6]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 02:10:46 +0000
Message-ID: <5b2f6097-3928-f185-4d61-28b4adc162f4@amd.com>
Date: Tue, 31 Oct 2023 10:10:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] drm/amdgpu doorbell range should be set when gpu
 recovery
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231030095753.7946-1-lincao12@amd.com>
Content-Language: en-US
From: "Yin, ZhenGuo (Chris)" <zhengyin@amd.com>
In-Reply-To: <20231030095753.7946-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To MN2PR12MB3663.namprd12.prod.outlook.com
 (2603:10b6:208:16e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a22bf5-b0d9-4f6c-cd5b-08dbd9b697fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVWWbogBOcl6UvCeL50YGzVG+qWEvzWrkDxw/ujioqgXcVAV5tit49QSl2N5QToqo7ODpTTY9tqzCcs80/yLQ+ouLshIyTQy3SAd3pIYhywPz1/6d4upg2kQHFxXOam3vvPXqwUY/8h+qku9Bcxj43MEEDO/WR+jvF3pAOhVeOsu+NW4tNHbF52/TPuSodvVWloTt0fghj5St16adXujXbsZ70QxE9TlfllsJ0+wHYXJ82WsMa1qj1Nher1EU4JLSYuHkgIhG8NJC/KGZ0YWDXLicyuPxA1UH+ChNk0LwMhnV8bsBZsInFxjJ3ZgxPG+6y2nQlhqSAVPrcqDS39BFKCIu1OJ0iWJEH/rbcTpb8ut2Uhpg/RL5T7MQC/fUZwHJWL8MAh+iedjoTlZZ/13LCA52E7Tfc39kPgZtH9Orh7DynI9avn8HXvKuArioCQrHE7l+huEP2P/r+fPG0dbPDOCdecerkPaMqcFBi0Bs0NS18LsDkNdVsMSS4s/apVCtQ5K4lxdEAvz3q0TUHWjo9sjoOE5coZdJ+9hQUfCz6KKAzBPZ/DCtbPvp1L/CuSQ0sH292njzlhUyUBXogtgXE7kFgoymeVpkp7f52E/cav50HkkzDbZuRiioPYle0QcFwJZil92yvKN82Quj7RS6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3663.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(38100700002)(36756003)(53546011)(31696002)(6506007)(26005)(6512007)(83380400001)(6666004)(2906002)(316002)(66556008)(66946007)(66476007)(5660300002)(31686004)(41300700001)(478600001)(6486002)(8936002)(8676002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1VZGo2TmpCZCtsWVc1YjdsajZrc2MwZW1BZWJkWjgzeUFCT0RoMW1rMXY1?=
 =?utf-8?B?R0VkRWJha1RCNkphNkFyZjlzYkNMdmJ2Q3ZzclJUS3ZNVHhEaHRZcXFGV1Yv?=
 =?utf-8?B?QWV3YmVFZTVsQVNCb2lXU2kwaS9Za2kyVkFaRndGektka29HUU01UkRTNGpj?=
 =?utf-8?B?S0tySitZc1l1MWZwSU05MzFoUFlBZXBvNHhrSHNxRTFmaG91OHJpZTVTcDRR?=
 =?utf-8?B?TEI3T2txV0VKQXIzdi8rWTZodS9mZGttRFYyOWVxSlo4RWVZNTgxVmFHaW1B?=
 =?utf-8?B?RHVTNXB4bGU5amtFUVF1VVhleUp2bm5JcDBkUUZaQ2MzY2w4N2FlMUFDUjE5?=
 =?utf-8?B?MmdWTXhGN2V0MERTNHhjOWFlYmdzS2huVmhoS3p0RVRaVGFoeFZ2Ukxsa0Uz?=
 =?utf-8?B?Mk92dllxUlZkVURYS0YrZWVHTndFU2IxV1hvdEpUK2FETlpKck80eENISXp3?=
 =?utf-8?B?QWJMNHpDNERPQmVvT2gyempYekJ4M2dmUGIxWDN4OCttaUs0NE1wSjZlUlVT?=
 =?utf-8?B?eGc2YVgzcHl6eTRXVjRIalhReTlwWlA5ZFh3WjJMZDY1eG92L1gzaitzb0th?=
 =?utf-8?B?bnZDN1ZiMEVzS0dSZ3pXQzVkUWluUGdMcUxybkdDTUF1elZ1ZlZXVnhkZWNj?=
 =?utf-8?B?WFJKa0Y1bHVSRWdjSmMvbkhaeitiUWhOR0VIQlJ2b0p2dlZuTWdNcnRIWG05?=
 =?utf-8?B?MkxtNWd5YnlyajE3blEvNWlWbzlVM0ZvNU9tL3JJbnlRYjkyZXJLK01vdVlo?=
 =?utf-8?B?cHdvbHVTTE5LN09ENFdzVFQyWW5GU2JCdUx3eFE5RjVNLzRDK003OEExMmZY?=
 =?utf-8?B?LzNvMUwwWUZpbmZjdFhtb01uWnlPMWVLaWszbmVIdHRkcWhXWm9XZ1I2T0dZ?=
 =?utf-8?B?U2sySWZXZVo3NUpxdCtidlNLelJpbzlDL3lIOE90QTc4Q1cvZGg0bmc3M0ww?=
 =?utf-8?B?RDVxc0tOV3ZKWVU5ZE11Y2tJam1QSWEzcTAybEpra1piZ0NiT1RQS3d1aklk?=
 =?utf-8?B?aWpMWEJXZmRQbUQ1Vk9KY09tSzdKWGRrNkNnY0ZPdHVOYmVCaEkrZkRyRXFR?=
 =?utf-8?B?UmhGWTE4RlFlYWVxeWE1NXNZbWhxand6M3ZzOEZVRTRJUHlBbERleWZScjBE?=
 =?utf-8?B?V0p4VFgxVjM1MzVJN2NZa1BZQk95Y1RWNWtZZHBpZnduRG5FSzlibmE2UmhB?=
 =?utf-8?B?UlBlb1d3YXBaVFBiZGlsQW01emdKYmZYZXBGWGk0Q1h4ZW1pczQ5aG4vVDF1?=
 =?utf-8?B?WDlwVnR6a1JYTkFkTnVJaitFMGJpWkgveEJha0NXUVlYenVQcjlmYUFwb0ps?=
 =?utf-8?B?aVJaR25ER0lyaGtKbno0V0tNaHdudFlvZE1ublhITXg1VElQa3dRcDY1eGdW?=
 =?utf-8?B?QTZ5d2VsN2dpNG1WQ3ZRZUVZMzBHUlVnMGJrZWNoaHZFZVBGdVQ5dGJWZXlG?=
 =?utf-8?B?N25yaHQyNTM3OG15ZjZhSzczWEZZVERQcENaYW9SUkhkWVNxejU1N01weGVw?=
 =?utf-8?B?WWZmNlBBNjdOZzkxVVJlSzRvT1grdGtJVndiTUl3Ymh1TC8ydXNaeVIrd0JQ?=
 =?utf-8?B?WEcvaG81Y0U3SkNmUFQwWTM5NHBhOWZ1M1JaSTRpb2tMR1RaRFZwUTEzRGxR?=
 =?utf-8?B?YS9TS2VGK0NJVGFLTCtpWHZpZmlVd3ovd0xDU3U3bTAvUHZQWG1zM1d3bzBG?=
 =?utf-8?B?U2pOYXMrNEtZSmFGSUFqbUl2ZGwxRGk2bUlET1Z2Y3p3QWxsaFBhVjYwNjBP?=
 =?utf-8?B?NlZ4SmZPOXpvVUtQZEtvM1ZLYldaeUg2djlQMUxZSThxNHBEZkFRa0t5NkNl?=
 =?utf-8?B?WE1BMHdSLyszbzc0b0FHZ3RoSitTL1Y2b3pLMG1RSHIvcHJaVVZwc1A5bTFL?=
 =?utf-8?B?T0tDcFZDam1PNHU5RUgvdWJVYzkwMkxIbU9SeWJwQ0Z6WThFRjRBTGh6ZXZo?=
 =?utf-8?B?Z3lIcW1BSFhnTzlEVWFDV2V0bGQ1Z1VHNGNqOFJnY0NhRVN3enlvczRsL2hB?=
 =?utf-8?B?VDBIRUh0TnF2d0dEbEIzVkxuMC9jaHVtY1R6Mld3MzFoYk9Kbzk2dXkwblZG?=
 =?utf-8?B?TmVrSjF2VDhGdUh6eE9TaktyWmJNWTFRV2Z4NTJBZTc4TjNWUUhvbWZTRFBp?=
 =?utf-8?Q?a0Shepl800vJPJ5bly2acv+pL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a22bf5-b0d9-4f6c-cd5b-08dbd9b697fa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 02:10:46.2224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eB3GfbqE2VivSeM3nNBdCzYjErYausVPIBJwPVPHBjLAkpQILSzxbGPr8trWPBbIcC1knidXwfmDiadwr1VAHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
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
Cc: zhenguo.yin@amd.com, jingwen.chen2@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 horace.chen@amd.com, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: ZhenGuo Yin <zhenguo.yin@amd.com>

On 10/30/2023 5:57 PM, Lin.Cao wrote:
> GFX doorbell range should be set after flr otherwise the gfx doorbell
> range will be overlap with MEC.
>
> v2: remove "amdgpu_sriov_vf" and "amdgpu_in_reset" check, and add grbm
> select for the case of 2 gfx rings.
>
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index d9ccacd06fba..c9f4e8252070 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6467,6 +6467,13 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
>   		if (adev->gfx.me.mqd_backup[mqd_idx])
>   			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
>   	} else {
> +		mutex_lock(&adev->srbm_mutex);
> +		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +		if (ring->doorbell_index == adev->doorbell_index.gfx_ring0 << 1)
> +			gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
> +
> +		nv_grbm_select(adev, 0, 0, 0, 0);
> +		mutex_unlock(&adev->srbm_mutex);
>   		/* restore mqd with the backup copy */
>   		if (adev->gfx.me.mqd_backup[mqd_idx])
>   			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
