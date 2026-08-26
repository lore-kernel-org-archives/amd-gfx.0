Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAF9C61DC7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 09:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52F910E291;
	Wed, 26 Aug 2026 09:39:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HJIB93Ph";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010064.outbound.protection.outlook.com
 [52.101.193.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4145310E291
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 09:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eN5yLzFskJGuPdS3qywigQy2CnTyD+taFHKBuYBjeMbDJ6dy/0KffwOch/08xU6EvOrurM6a7ebY34fHrgCMyuqDEdU7UjZm7WAFkPN/X7S0fi0O7WCZXt6RASmT0EkeNcXYgTmEEuFxsAwps/oRJqrrdETobGN/WHIdZ/8OUJZ14pWZMR2/f388U3BwFDEqBp8I0Qt66QVdPMHJvb6SQJBEkqFH1jt0Tz2GMr3hCuYie9qXErlparU0ZZuVuEnXg53CJ2SICkwJMKI2+HJC+qU91Qto2/gXRRvlnEkm69uDS4YFHtHZmfC3LYBqSN/uIDTC4/1qfv3MR88ICLOL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iVVREZrTNJ3TTC/Lt0/tezpaJEHvcpe6VFZH+UpPnM=;
 b=Xh2qFW/hSplks7TVbG0njPvJofnaSZjY0RD5xq/KUGp4iZXM1KwvHLulCBRnOSJZ6tsXSryjkmmseanQZ8ALqCJvQ5xh2oD5jH/xOdSCd4+EnRqB619CEPY1PfiDV1rDlzS9PBDx9O8F225dhWHaKBlmeU7oA/FL3ssZM2/f3ZHPpl3QzzVIMcXOQ9qCDxHMC6wndkSNZWRR3P8nF1oMSYsQ28MItb+0q05UyI0xuCKCknyh7xf8FSnuAh8f4WJukPpI0eyoIu78oJLlbTxXTx8aqNCzyQnBgqkp5RIxPLNx6fyNOtiLaGyrWyOfyLjB4nwZCbkYKn1mga9D/00/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iVVREZrTNJ3TTC/Lt0/tezpaJEHvcpe6VFZH+UpPnM=;
 b=HJIB93PhfNIIRRznl/LklAs2Zhjd5DQv6axxcprRombV13EKDj9jgfTjdItNvIJnGhFF2nIftpojf/uiUmGE625DwwMv2KkVuY5zYryV9gsl8GCRDc/Pg1XgTGsjfDAy52fj2BnHcn4VsE80EV65yGsRXnhLFHnnOsMh8bvSCrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 09:39:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 09:39:16 +0000
Message-ID: <18273e08-a0de-46e2-bba2-131237e84718@amd.com>
Date: Wed, 26 Aug 2026 11:39:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: use hyphens in TLB fence driver and timeline
 names
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260825081528.496730-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260825081528.496730-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b62e7c-4aea-4bbd-b623-08df0355e52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nrk575zZsAtBXtP3rcwS/AABIpCzobuJhec+N7s93bjqUgxWYHgS17pvHdoxjrpvWzx4GEg7r8uvxthrgZXkQaC2xFiR7xpdyxtjp6n5Le0vyJmCwzNuXn/pTo6Xwlxg65/5RxjAwEexHSpgCKwfiDuMOjfo0HDhpa05QHQHKx996EizP1qhuSeq+ikzd5lS0gf9hkQ2rQToQMPOD3IleKnrXkcwUqL4Gmq5KHWuKO0j7pL/cG286uumQs8EU/CeITD5G9aj/uMwr2R37DNgEg8Mtc8vK9lnPkullWl60Sp2hblfhsc9u9+bvCu4eYDRKt4OKiiAGeWR7dznfZh6fk7VfbB+oOIye1dR+actis/ZcrJYTVhde2dNxkwjAlFSH4MchZxao6gI2t8AfquT+CEDubHNmbtwinQaavuqDh7EsyoOJJfz/wJaEab1wQYNob8R5rcD1CIITHRHuMZSd14elYPfmf2HU2nLGocwKJpJIuaTvnwZUrGorMTdAJfzl3xrIerhafGY0Yj/09BN2+dOympiZG5krSVFFJWhFZL+LozEFo6peIw9I4+/+fCZRCr6PSpmc+RaLWGhjzAh7UMHDz2hQMA79uwqVXTrrzlLZJw1f6kYMW569AmSfwSZBOM3R/iq8SLVouKhvHNbfdek+iJx4MLoe3HIjIr0UXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNpOU44bjBXUHpyeFU2ZlRHMnMrUnp5SkdQYmw2Qmg1Z3AzT3NmZGl6bGJJ?=
 =?utf-8?B?dmMrdnhoa2pmcmNtNEx0Y0FFNGxTRDlkZng1U3pMbEc1dDJpVzE4eW81UFJx?=
 =?utf-8?B?eklSd096N2pLU3RVdENrRnAyNm45T2JkZWxlU2VKc2l1QVlzTlcrTWt4eGps?=
 =?utf-8?B?dm93SUlTN3VPYkFCWVZxRHRZekRqWGtISGJ6U2pYTWRaZDFIQ0ZVY09ta3Nw?=
 =?utf-8?B?eU9oTzNKaXlaZWtyM1VaRm5KZU5sMjJGZVpkTXZMdVFSRWZ0NHU4MytsUXhS?=
 =?utf-8?B?b3VkV2JWeDdEelAwY1BoVnlZbXQ5WmFQUFdkSkFDa1BaZHBwcXRublNDUjVn?=
 =?utf-8?B?U3czQVAwQ0NsSmNMODBlT0tKY3Axc2VEUFFyWlVhenpZVzUzNnl0M2pta0xl?=
 =?utf-8?B?OFpZQ1FrT1Rjck9jWnZpbEZmQzV4NWVvb0pnajZYRDdOSVBUbkJQQ0xnbWNK?=
 =?utf-8?B?N1U1QXdBeTUvZTRNcFJVTzd6bEk1ejVJL0x0Sm9zemJFV1lsTXVxZ09YWEcv?=
 =?utf-8?B?c3JRc1kzaDJMZlA1ZENkNXNEQ3REa0NWT25nSEZSM3ZzdTA0MUwwYmhYSGZz?=
 =?utf-8?B?OVJzbzlIU1E2RVJsNkt5cjc1Q3JxNFVMdXpsZ2ZBc2dneHJmUkFZWisyQjFz?=
 =?utf-8?B?Q1ZiTU5zeXRNT3hUUUpEUlp2ZUkvSnJETzNSbWRZWUc3YjdvSTI3ZkZmSm5o?=
 =?utf-8?B?c2ROVVFjaHU2aDZSRWg3U2NBaTBaaE9ZRW1GcWQ5blZ0dTdlWnFGVTIxeWF3?=
 =?utf-8?B?cStMVDB4dXhmUi9oL3dnNjRHV3RCUGYyQUNKWkJ1MjJOMGRnU3lhME1LMWY3?=
 =?utf-8?B?aDdiUmxFS3pJTTFVL2dDSlo3ekJPTFI5ZCtSVnBjaHNiakV6V2hoSUY2WTUz?=
 =?utf-8?B?ZGZsT2dOQ2dTYmpEQS9oZEtkVTVyb2V6NHBzMzVNM3NYUFNVNkdFV2xNS1Ft?=
 =?utf-8?B?OTZBbFJKdXJ3bHY1NjFINHVPYWhrRkk0elArUFJSbUZ1MGZTa0RVZyt3NzU0?=
 =?utf-8?B?bGZDRFY4MHRaay91ZWkvSXgrTVRIdnowU2daR0lMWDhKRWYzdGNOai9QSGto?=
 =?utf-8?B?UWRIZGd2eEhFeVdvditrWEZBN1dDMjlQR1Ezb29OMllaUTExN2pUTXp5Kzg4?=
 =?utf-8?B?cTRWcHp1QWtxN0RIRWJUYkVkTFNtOWlJUVBKdUtFclZsV1JmRUY4ZGNiOXFj?=
 =?utf-8?B?WUFXNkdkRW9UbXdPQXNBaDJ3WmdGQklGN1VEampxd2NOSGNVRGdtZWQrR1gr?=
 =?utf-8?B?NUpIMGp2SUx2eXlpVE81Vk5mV3dOK3NuYzRGRGR5K1M4dnAxYWJ4elkyQ0c2?=
 =?utf-8?B?SDlqRGVNbTZ0U1ZrL3pXYzdJNWxzRkJGdWJSRnk0WWFZdUtHT1lOdzNpSlhQ?=
 =?utf-8?B?ZHpvWlBxMmhLL24rUVNwVHhRUSswM3RCcW5DRDhPNW1PaHB4OGFScGJDb2dV?=
 =?utf-8?B?S21WV3ZjNjZHN3dDeDNma0c0U0ZwbkVzNmJDSmluenBQcGVqNHB4THVPS2cz?=
 =?utf-8?B?NHo0ZzQ5TEFBeEQxVHVITGw5QTFUdjl1aG40WEZiSTV1TithWll2bjBDZkV1?=
 =?utf-8?B?N0pKc0piZ3RjRHFxbi8xQUdBT1lSVE9hLzlDV1o3OUswVkJqMUk0MTB6K0pw?=
 =?utf-8?B?Q2dFQWVGWmlIbFV5czdPODRyNkxaT3hYMW5zcStiVFMrdUhBZzRzMjNZZlgz?=
 =?utf-8?B?cUFja3djMVlpYm9DSW8vYm9aQzZoOEY0anUwNTlSSGZ3YVQzanRqNkFaWlZj?=
 =?utf-8?B?RjZCYldKeG9MY0dLUDFqSzRZa2h2SXF5MXNOQWpIWEdkYytRajFsTXdqZzZN?=
 =?utf-8?B?T255TGF4TGRJa0dBZWFyZmdmalUvY0hpcFI2YW91OHZ0aUFrNk80MjltLzdO?=
 =?utf-8?B?d0dqOFB4ZXRjNzJFbGdPMVY4MTYzMVhmQTlwM0FacjlxaFFhdWZ1T3gxQ1Yv?=
 =?utf-8?B?RUkzclUyQ2tQRXFWTGN1cDRlcmhsT1VDcVExeVVIWEdicmU0UlE1Q0ttQVR4?=
 =?utf-8?B?ZzBQV2d6WXNabTQxLzh5TjR2anJXTGwzamw3SGlwWTdaaVBxc3NySXZIYmF1?=
 =?utf-8?B?WTBpZ21kRWZnWXdYd2E0eDRMbVA5TFFIb3lReVhCWERZMlluQk9ZL1hUU1hx?=
 =?utf-8?B?d1AzZUs0ZmlPMnlkNVNKcGUxd2VjMDNXQjJ0WDFhY2NDK3RqZ3BYdW41Sk1i?=
 =?utf-8?B?RjNXUDN6UHo1eW5XRmpIVjVFdjRSVmN3ME1xcVRPU2I0c2NPRzEyL29xSUdY?=
 =?utf-8?B?L2dteDhRTkJCTkg3NC9OVEh3d1FLNGVPYm0xU2RpK0hSc1JCVm9tbmpSRTRR?=
 =?utf-8?Q?KajWFcoPJ4Lyop4c3F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b62e7c-4aea-4bbd-b623-08df0355e52d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 09:39:16.3831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBwZGdlNwViqcvZXm98OWbcpCW3wWrkbQZIerL3KIpk5RBi3rVaLM0jEHv/R7del
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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

On 8/25/26 10:15, Prike Liang wrote:
> Replace spaces with hyphens in amdgpu_tlb_fence_get_driver_name() and
> amdgpu_tlb_fence_get_timeline_name(). Returning string literals with
> spaces makes ftrace fence events and debugfs fence entries visually
> ambiguous and harder to parse using standard log analysis tools.

Interesting, I never considered that a problem.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> index 82b8badde453..b0002c898386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -40,12 +40,12 @@ struct amdgpu_tlb_fence {
>  
>  static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
>  {
> -	return "amdgpu tlb fence";
> +	return "amdgpu_tlb_fence";
>  }
>  
>  static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
>  {
> -	return "amdgpu tlb timeline";
> +	return "amdgpu_tlb_timeline";
>  }
>  
>  static void amdgpu_tlb_fence_work(struct work_struct *work)

