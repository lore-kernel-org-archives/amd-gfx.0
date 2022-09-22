Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54D8C6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 15:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7EA410EC1A;
	Thu, 22 Sep 2022 15:31:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6094C10EC19
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 15:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU61lFSUecddytxca+qd5acjDecbST/WYx//ZJRMKttwKVVLXZ0WJpaMWV/M9Cu7rj0Yv0d3o4Y+DM9XPXeEYQNeqxgfa6RtzRpSqbObM4J0F4yhPtiHJ48IJsk19aSiR6WCnfN+307LTsvl6hGY3SGiYmYqo9c0xN1ahxoOajRvAh635bisBbcqu7c9wMl4g6VkocBKYNn7caq25xN9/1mu+gHk9Iav2/6vq59JxMs56vMgmzW35hOd0vB4zjv6rzccTagBn6L0uf50oZXZU+fWo1PrsmxhxtxukgmlCVy81AlGmX/Gt3IAglHqmnM54nfMrjnd9R3XD42FJUAKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmrgiyZIN7x1ooUMuTMhYk7qzCoDSoNpSOSWlfeDSg0=;
 b=UyylfGJv58leKmO9oz1R54uPjuqWM4lISFEJmeglsGag2AqG7Rt0gR0nfJX/4/qq+gmM6hdqhvE10DwbLjwTtAENkBBWGeNf1mqwNevLDI6teiLs1PsI+MoAnrF10dYCmhK/Ufv9BXNhHzoAC/52NlgnOSVBOkoSCpFjnL8igyuVSIyiloI3KvNsqT/gouz5Q/tHrC4s2uteC/Fd+xsRRUSRk4OFuIX0OSIAXx8ZywX9MP38gV4nkb6DfqWEDCkXKENmIsBmPxUyZd+LOco3OtrRjiAo5JoZ0QjXhWYaBj76rWkbQTFhbuWq6HO1JupjPFGcqL4vJIXXCt7Z/BaW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmrgiyZIN7x1ooUMuTMhYk7qzCoDSoNpSOSWlfeDSg0=;
 b=44uoCU+94LO+4+BpQsD4fC5jt6f5qOOcYh8Z3JKYpYcbODP/5BbHym6B7kNgtjos3IZOMBKKZ+BQTFHgEhteegDK7xH5EZMf7Mo1cHKnvlG8RFiPfG0kBMkXiencTcG4zO6i0ovvJScstPjJa+vIEYNEp5FXaaUmpFdYHt9V7dY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Thu, 22 Sep
 2022 15:31:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:31:22 +0000
Message-ID: <dd3ac270-a338-888d-4bd3-1716504b7a8f@amd.com>
Date: Thu, 22 Sep 2022 17:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix VRAM eviction issue
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220922151447.265696-1-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220922151447.265696-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0543.eurprd06.prod.outlook.com
 (2603:10a6:20b:485::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: f9db7ac0-8b5a-44ee-991d-08da9caf80d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tK4+KO2liWoPoxaqyM0QPcMLfq//yLPaXeyT1VXzDyJPpBNrPIqYplXTKZi67/ILxE9wiifYk11u+sG+nIjvSsfWL0KRrAb6jrg/BSBYoJrlYyA4e+8OQcUhvB1e7DXateP7JG6gbJO3GZw3Sv9xLUgK0Tl4Bll9cpg3TLn6w6qkJnTQ1RbEgzd6Vkdra/Z8S63uutiPsuRBYSE1dA6X+Ni2DS3p4CwzRTXGij/KTG9veCvBaqMUHHtiqvdg6mOogO+/cRORwB4MnXVW6rVKa9yCtl0zRttHneMfnkm2pSPqYN/vbbvbfqRxM5XfUIJE4fJXnRwcO8P4K915abpdNuGfQAgrIfvOx2Xnbh8K9b2KLLWyFfSSrwDSsp2F51j4OkTso0102oB21nVO8Wauba1eyb1h6sAyakMEEQ3+0W8n/JcDFKYHtJ9SJz4suAznF5dC4iwP83hywoWQletTxcghZ1dHb9BiKGkXoDyXPi9IMlDeSByHPZKvzyJp8Z9/FRGBAy+BNqI4cyoLQzxs/7JLHQpEH3NfAT1qKRXRyHuXNo4V6DBqdlmlWTTIZHlmsGiCVDTu2NZD4HibWanldmu0LLBB3tQNUmv2wkEFoXKoM8suRvJ6NTCAhfptqpUZdZkaw9THsX3hQOvi+hFk10jTwDuE7ej/89pBpWAk+dbF6N/VN+SQGEvcr+8kh895P/UG4no6iVw//K3EdDYMx+IYKZq7v2/uIeQfUtd8r5HRh74tUyD0T33Sra0YPMh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(5660300002)(38100700002)(6486002)(478600001)(8936002)(6666004)(4326008)(316002)(66556008)(66476007)(966005)(8676002)(86362001)(66946007)(2906002)(31696002)(6506007)(41300700001)(36756003)(31686004)(83380400001)(66574015)(186003)(6512007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3B6MG9HWjByQ0NjMzZ2R0NGZGhvYWhCUEdBVEovTUxvUG5id0VMclFmYjRl?=
 =?utf-8?B?Rkk1MzdJaHlkVmwzcmxQMDVBYXhsY093eWxTUkxaNjQzQmx1QThkOGV4V21V?=
 =?utf-8?B?ZnM3aEtzeEY2cHhhWGl6cTRrS29kTWlpZXc3d1l5U28xYkhiT2tzUnIrUnRk?=
 =?utf-8?B?UTBwcmhzaUdMWjNZZFRQR1BaRno0UnhyemNiSGVsS0VPendQZDEvWGNlMkVs?=
 =?utf-8?B?RDNWVUF0VGUrMHk5NVI0RlJkNnVaZVdmT0h4bENjREFpMkVpYmM2QVVRZnBM?=
 =?utf-8?B?LzV5bk5ORUdrMUlxVE9ibytMZTdZZDlCdGdEK2kyMzArOFJsODNnS2pDOTMw?=
 =?utf-8?B?SU1JWS9KZy9LRGZ6YzA3cjJaQ0FzQXAxeU9uZktmR0xZV1FkdGRxZXZhY25x?=
 =?utf-8?B?OGhsbzl5NEdCZmVOaEpiSTFmcUhLTzRLcDdwYWU2Z0dEbnV4ZWE4eWlXclVa?=
 =?utf-8?B?VzVUcTF0RkFIanBtaklMMWQrNVhoS2l4Qm01RVFQNFM3ZVJLeUV4VE9IUzN0?=
 =?utf-8?B?K1JsUkZJNG9LNXdOejh5QmpNUk0wSnZ6cGU2dWxxanNlQnl5S3VHbTlqcGlt?=
 =?utf-8?B?M1RNREJOZHcrK2xiVWNYZDRyUE85QzFqRGxBYXFUK29nMlBiT0Qvai9od1hT?=
 =?utf-8?B?eERGSWpMUFRJblFZQVlRSkM0b08yRW9kOGFkWHR3YUplZ1RrQzFlaXVKaHdM?=
 =?utf-8?B?VlFMbURJRnN5STVoVFBGMmVuQTJuamVSMU00Tm1iYUdjTkZqa3ZZcXhvRUc1?=
 =?utf-8?B?bEhUMDV1ZDVHT2VuNWlYd29DUXdaMDJONkRNL20zZkl4WHpoZEZDZGhwVVhW?=
 =?utf-8?B?dGJNNURQS1ZuS3lySGZlV2w1ZHlaWmFaOEJhZjNpMHNRYzBCa0RSTElXOEh0?=
 =?utf-8?B?WmNtbER5a1JOZldHLzlvQXdRT3JxdkVEWmIyeEJERnQzL1gyemlkc2w1bDU4?=
 =?utf-8?B?VDIzWnB2YTl4UjBkRTQvUnQ3VXlPNHp0eGg5aFprTnl6VWtTZWpaZDhjSWhK?=
 =?utf-8?B?OFA4TGJNTnJPUHFTM2ZuL3AzMWtUOWhTT2VJU0E5d2E4M0NpSldMemp0RzBv?=
 =?utf-8?B?SHlDTTZJdDY3UHY0V3BubFlOWFpvZFliOHBOSDNXK0cwTUdXZlRZdG5BOXpL?=
 =?utf-8?B?Yy9aWWQwV2hkRlM1NzVBQ0UrNmJCNGRCc0FudEZYWjlYSDROU01BdTVvcjFv?=
 =?utf-8?B?ZVdEQW9ab01YUjZUaXViVDFYUEtFMDdNQ1NPZlNtdkdzWmFPOE9GQ0ZUR1Fj?=
 =?utf-8?B?b2FuUHdncElpUzcxZHpXUk05VHBpc0hZaWhHV1dnMklOWUxRa0JENDBacjFl?=
 =?utf-8?B?SXNhUkNiSXFMRDliZGpVbjhXbUsrK0o5eTluODhLNlBjck9sOVdrNk9QTlBa?=
 =?utf-8?B?TWh2bnllR1hGSTVYV3VnaWVaWUdCLzFRaXhYWXQza25DbDAwZU9YOTlyd1RS?=
 =?utf-8?B?bTdDVkNsMnhlNTlXdDRZbWtWKzIyclpybkx5RGdRQTFxNy95aDFuK1BHcFQ5?=
 =?utf-8?B?Nm42QVFzd3pOTUtYVU1QTm05cmhQOCtaWHU1ekdJaUtWYzJJWnVxSnpkUWdo?=
 =?utf-8?B?MzJxWSt4aFI1TW1kR3ZXRTlCNVl3NWc1c3hiVG5rYnQzOVVScEt5UUpQNkdY?=
 =?utf-8?B?UXQwUXlnSUdmaFVtcjZjMkpwSjNIRlZ1bEsydnZtQnNzSW53eTZJSnMxRHVD?=
 =?utf-8?B?WElRMExwcE05SmV3Q0QyR3BCeENPQ1c4Nkh1cjJmWnFCckNxSThwTXRISDBU?=
 =?utf-8?B?bUxTQUkyK2dPM3NFWkhmVDl5eU9COW04L21xRzdHM2lid1pacjI5SUphWGJI?=
 =?utf-8?B?d0hlbnFrdU1pM0hIcTZzTE5IWjcyNzZRNEdUT0RVSG1XalVXeXkwSmJsWXhv?=
 =?utf-8?B?YnAzK1hoWGlROGppUDZqQ3hJM05YKzM1c3lTaStXd1JSL3pFWEkvSGkrSGVz?=
 =?utf-8?B?TEZtSFRyNU1pbzVJdGcwa2dScFZkK0pNdWI1anBFekt1R1h0TC9mbFVoZnhz?=
 =?utf-8?B?RkJyRk00UlluaTBmQXg4NGUwOGVvVW9lSkhqUzJ2THJUUTFaOUxUUFRLcHR6?=
 =?utf-8?B?MnRtMnZEYjRmNDkxdkY4bUMraWVudHgvdGJjNGdib09oeElKLzJkZE94QlN4?=
 =?utf-8?B?SkMraG1XMzJ1cXZlMG9zMXVZczFCcExBenhrOVpYR0tNVnRvRzhSbEY1SDJ5?=
 =?utf-8?Q?jILVtNdKoXWCSVu6ER1MMXpxyVchqp7FoP3VfwGIInGc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9db7ac0-8b5a-44ee-991d-08da9caf80d0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:31:22.3679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oYwfOqtBnIwJrAgy2zI6BdhAtT/eA80lDTKlfZbCowOfDY7lZrw0y1e+i05jMV1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.09.22 um 17:14 schrieb Arunpravin Paneer Selvam:
> A user reported that when he starts a game (MTGA) with wine,
> he observed an error msg failed to pin framebuffer with error -12.
> Found an issue with the VRAM mem type eviction decision condition
> logic. This patch will fix the if condition code error.
>
> Gitlab bug link:
> https://gitlab.freedesktop.org/drm/amd/-/issues/2159
>
> Fixes: ded910f368a5 ("drm/amdgpu: Implement intersect/compatible functions")
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Can you push it yourself now?

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index d1a2619fa89f..73a517bcf5c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -746,7 +746,7 @@ static bool amdgpu_vram_mgr_intersects(struct ttm_resource_manager *man,
>   			(amdgpu_vram_mgr_block_size(block) >> PAGE_SHIFT);
>   
>   		if (place->fpfn < lpfn &&
> -		    (place->lpfn && place->lpfn > fpfn))
> +		    (!place->lpfn || place->lpfn > fpfn))
>   			return true;
>   	}
>   

