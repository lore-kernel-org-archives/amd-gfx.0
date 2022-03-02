Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8A9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 22:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2993610E4F1;
	Wed,  2 Mar 2022 22:41:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3E610E4F1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 22:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4Wem5pF5AgtvF12C2PnlNL5/xwKLF+Zjy94Ezo0nUX+pKeru5C6yxsCozPchh548KpaeI7zbUK1BlBoqAATFkN28jkgCNmx/17kO3dc+oETQLn5+bmSlHVggMSF+eJtZDk6LwkKpCYeWZxrYX+Mo8U4gAYWAdI/ZHJlFuZ1BdB/OXojDCh5rpj7uG3x77Rf2VDk/kZCvCI2KYV0UOGmG3bAOFziIbueLNrWjPpAYBultg6kq6TjlOFWMgsgv3Vk9iOLXJzww0SSVwwXy4uSFRmJWWoly9YvPBzhfKCyHOR/FODCtm47yhizOh8abLtL6+gAoCIwNmgb2qdxBomT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5gn4eMEB8CXo4do9cRgRVzCC4v+wHcjX74XBj29yW4=;
 b=jMEqwHMltoiI1peJcAFcIaGT0YduyZXvINzOryfYuB1QAMaJUN/CuIrb9FcTFbdgUNJfdCZYn7nPUbfhRz1UxtMCZa1JAq4NohoVg+NrkjieVVHywuMMPJUUQneicXzdy+m7VKPo6wpEa5Yzd9G2T8B6oysnTeSvZdVIfVG1/rlx0FCCksTw6ox6ppH21wMT4IfC3b+XOK+sxMPSgvmlJR++KGX8FI6ajXZZxX350qIiQsiSpsqocqNtyPrDQ7ESlWarhS0whQBEE1wtO+mpP9ODcqfoU60PfOfABmfyJvJLYElANrHCEsTmRMI+PyLLIS/FX51I++9iKscs0W+XkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5gn4eMEB8CXo4do9cRgRVzCC4v+wHcjX74XBj29yW4=;
 b=b+cO3/VDomOEdZ2Bw6BLLzhS9lz7s5j1uzX/v+MOiW/623uVK3u6IGpgBaxWLvnxhm6LnRj7xXG14w/IrOcnvnkelEavuzQ/BjLHkKpyC9tZNQ9TbH1/Z3mniJJ1OSh6ObuupgApLho1F42BcN4oQx/b039KakQMcRYFzQrwODg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 22:41:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7%6]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 22:41:23 +0000
Message-ID: <bfdcdf2a-07a7-edc9-6cac-806ce6a4ca4c@amd.com>
Date: Wed, 2 Mar 2022 17:41:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Set correct DMA mask for aldebaran
Content-Language: en-US
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220228182508.464871-1-Harish.Kasiviswanathan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220228182508.464871-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:208:329::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c342dee6-7494-4a59-93aa-08d9fc9dc769
X-MS-TrafficTypeDiagnostic: PH7PR12MB5950:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB59508B001DB127027BE27CAC92039@PH7PR12MB5950.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpZbVsxzoDfeuO5CMh/mZT+KLo0zEjXrtIyQwO0lXEg9qz0YsRu5xXTj0eQYUxGkJcMn/VCsEn78xtDuroWX8uv2CzZo1TJeNSsmb/FcYXUtOK59T9WoZulrWCw69L5ElsM3N/sPC4KBc8Phgz5m3Frjn28MsSr6oW5N6xD0SzOuYxlvggxhSfKmfKx7srJgKoizH6YXL4ekEnhcKGHRXG7EUcozdHjGYf2b4Uv0bOkpQ7oecmBPZuiyDOc6rSpV89mr+SOGfyTWoN/ABPV1esfg3NfZ/qPgBpTaGqD03iCU1OlW3INy2UPrYml927qOTh8avZv8C9jS3VrYeI9Na5CjBqsKM4PZsNfNBN/lPtHs7SPZDZKvCVxYTEtTFh+PwjMCc+jpwQEKO+DEZwEzxuPhvmydShQaQ6al3aD2Ml8tZLmD/40qLZGhhcDTVP0mQGr3wVzLhSEIN4u/UoruM0GfESqDcTI5FFXSQKK6PJLTyyzYaX3YXwmiXYkO3BwQn161rzPj7xLATTiwVnE4zbxKtb/sE7d+xLq85N/anThQfH2/KhMLX6KNWmW3hNgNH7Qwb4isUi6zxs6kudZjpwMBFGXOFm+suPcuMavxxEmB450rqqEFQ12dZ3XfjxsnddkklGrK5lrZ8nPHboq6DiwwrdMY9KTzWFPImHmgjxPBdsNjzut9feFXEl0mcv7cpC/M64jrENkocS1WoTdC+3ADshg1OweeiNvkFf8Cc4UsD07eVs2gCfnU0ci0Tlx2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(316002)(38100700002)(186003)(6512007)(36756003)(2906002)(5660300002)(44832011)(31686004)(8936002)(2616005)(66556008)(66946007)(508600001)(6486002)(86362001)(53546011)(6506007)(36916002)(83380400001)(8676002)(31696002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2tzbHN2d2V5a0pLTDRnenJBbHRON0VJNlhOVDArZVhDMDVZYXBOZEU3YnZF?=
 =?utf-8?B?czJ3NmZvU1lBNHNLNnF2dnZoMExCYTJvK3ZVMEJ3aXBuREJJdHp6NE5SQThh?=
 =?utf-8?B?N0hNNldSbzBJOHN2SW96QjVDS21EcjlaMlNCVGNyUGlvTFlpdDcrREpMbGNW?=
 =?utf-8?B?amNLOTYwRngrc2orOGljbVc0dmQ1ZnBsWi84bXlYWWJBKzhwdEFPenNkbExF?=
 =?utf-8?B?MHhDVDdKeUN6SUZVcFhtZHVZM1luRHlZR2RTaVhHS2UxQ0x5NnBvTVNCUTVr?=
 =?utf-8?B?Z2RXOTdyVWhBSGcxRmNkZkpoR01JZ3VXY3JuNDBiSEEwOUMyaC92REpvbE5I?=
 =?utf-8?B?SElyV3JpTkNtMmFXSG50cm1rSmlqTWxkd0VvVXlNMVdDNnFLTkV1cVNnQWNk?=
 =?utf-8?B?YmNjUFpNejBLWVNaN1JodmJnTkxTMFVqY1lnOUNkQ0F0aGxvM3gyb2xuS1B2?=
 =?utf-8?B?ZEozRnowSXBDallNcHlMVzNyK2srMzFoOWlyOGI0RkRZZHRjcVZPYXZiRUlo?=
 =?utf-8?B?aC85dytJUGZrQXpCQmtxSEZOVkVJTWZuMU5leUVYRk1NWStzNU1MbWk5MzdL?=
 =?utf-8?B?ZDVtNzM3Wnl3VW5va3hnbTBVRlNteTIraEl4RXc2NUwrKy9MU2gyRHF1OU1u?=
 =?utf-8?B?L1VoNTZVWE1kMjhWclVITENBTkFQdHAzWTB3TVNmVG1GdWRHU29Zc3JhVVNx?=
 =?utf-8?B?cjltbzFzOGM2K2taTkVvcWRwc3lOdXZIcTliTlNDNWxDUVUzMlVaMHU4WWxH?=
 =?utf-8?B?bzVwVEFCRXJEK0piZWcrNnN4eW9OWVc3VmhWbjQ2M0FpWVppM256RktyREtz?=
 =?utf-8?B?RjRmbWY0Vkl1Y0lXUXcxL0JQZHAvcUtCTkNWZW51WG9iaUJGbTNNYjZ0b2xl?=
 =?utf-8?B?RjZ6M3FlS2JzNmQ2MlYwOWFmdDlGT1FQMFpPM3pGaGJXejFqOWtLYXFDVlF3?=
 =?utf-8?B?ZUxHZ1J3S21aUFdpaXQ2cDdnUmxQMlFab2R0OUd6Rmt4MVhMUnlkcU9qT254?=
 =?utf-8?B?SXQ4c29VMExRQlBBbXllYlUvdk1la3dzNVJGenJVanBZblN2THUxNFlpOTFE?=
 =?utf-8?B?cGtvYnRSTnBOYk1oMkF6M3BuOUNwdG9xTHF1V1BkNWNtMHdzcFFSRTRBamdm?=
 =?utf-8?B?N04yRjVUd2plaG4xYXVodU1MZXp6d2RzcUIrN2dMdlcvNmxnb0x5Qm1JUW1B?=
 =?utf-8?B?S2x1VHNYc3dFUkQzM0krbWRMSVZMRUdwWEtyM1pkNHZsY3lmOS9ham9rOVB0?=
 =?utf-8?B?YkpoS2V6UWpqUERoRmhSM3JoVXF2UWJHazlVT3BWUkVKUEtyN0ExY3grMWxG?=
 =?utf-8?B?U1dUSGU3bjBGZENRbXJydEI1MUNPamlxamc5dEZWT2pQMUxzQmVocUMxZTNo?=
 =?utf-8?B?WkttdTNMRDR2ZFBPRHV1ZzVlWmtNOTNWcnFveCtWWTc4aDR4N3l5TXdiMjlS?=
 =?utf-8?B?a243eVF6WW1EdTBkdHcxY0EvMUtKUWRqMVh1ZytJMjBvbjZWSjRqWS8wQmgw?=
 =?utf-8?B?d25QWHRISXJ1WHh4SWJRek9rcWdJRXdGalBZcmVuZTRVSFAwUzlZNUx6V21C?=
 =?utf-8?B?eXNkQVRrYktsZEl0N0FZcGkxUE9tTmtCSHlrNlNWTUFmcnp1TkRESmdoRVFj?=
 =?utf-8?B?TnJTTzQveUtmQjNOTEFkczVva0lscm1GTm9tdDRoVlUzb2h1SXRvWDhJdkNU?=
 =?utf-8?B?dUxaV1RpWmpPWGVlU1Jvck9BSmhJOXltVnhPaGZHWVZhT1ExWWZPZmhiSDEr?=
 =?utf-8?B?QXBUSUFqN0ZtcUtaNUhob0Q0N1hmTW1ta0hPVVVpaXQ3bVI4OU9pdzRmeEI0?=
 =?utf-8?B?bUJCNzNCRCtvVlJ3dXVRdmFGYlh0ZTRLSDJyVnBZcXZLZXZBNEVSanNBYU1I?=
 =?utf-8?B?UkY0aXY3eSs1dDNFN292Q2JRUFhzRW96ZThsbjZnUkVXNWswL2xTU2dvbmJK?=
 =?utf-8?B?SEdvRVhqZ2t5Ky9taGVUWU4ydzBWekd4WWlETXo4UExBd3BjOGV4VjNRZERF?=
 =?utf-8?B?SFEzU1A1UmhGUjZsMk1XQnZRL2luQittck4xTUxVR0xTRE1CSzFmcWd4L1Bh?=
 =?utf-8?B?a2VWYkRCd2hwYkVmK3k5WS9HcmN2VitUeXkyTndUK3ZOU3lsTmY2WEt3S3Fw?=
 =?utf-8?B?R01XeWJCMkpQMWVtTFBGUG5qY2FFUzgxMm1qTVJzbGlDK3VKKy9DQkdYdWRv?=
 =?utf-8?Q?WCYeMJRAWzyDIf4DViuBtvw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c342dee6-7494-4a59-93aa-08d9fc9dc769
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 22:41:23.6392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTJ+ilI5QI3k/4HyrZeTfLXFOnRfseSjag00CGIanpCFaOZcKyZzLz2yrfLxZuoZHgSQGWq5VLkI+2hF/fDJ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
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

On 2022-02-28 13:25, Harish Kasiviswanathan wrote:
> Aldebaran has 48-bit physical address support
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 412e44af1608..0765c163b355 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1675,12 +1675,17 @@ static int gmc_v9_0_sw_init(void *handle)
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
>   
> -	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
> +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) {
> +		r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(48));
> +		adev->need_swiotlb = drm_need_swiotlb(48);
> +	} else {
> +		r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
> +		adev->need_swiotlb = drm_need_swiotlb(44);
> +	}

Instead of duplicating the code, I'd prefer a variable to hold the 
number of address bits. E.g.

    int dma_addr_bits =
    	(adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) ? 48 : 44;
    ...
    r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_addr_bits));
    ...
    adev->need_swiotlb = drm_need_swiotlb(dma_addr_bits);

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   	if (r) {
>   		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
>   		return r;
>   	}
> -	adev->need_swiotlb = drm_need_swiotlb(44);
>   
>   	r = gmc_v9_0_mc_init(adev);
>   	if (r)
