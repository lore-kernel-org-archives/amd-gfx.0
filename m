Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E986BC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B693B61D3B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B693B61D3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748F16E860;
	Tue, 29 Jun 2021 11:25:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34AFB6E860
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 11:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M94LLF3+kJy02yxkdDfQMZNL8T7KIVBrJZeYRlecKXY1Rb7eQff7E0a3Nq3KvFw6QmKmZ4OtJf8qQdrbusjKNOrdLZsbdvlWKFUbCLEzFFKbdy7Qnkd7rfxhD8knP9mjbysOxrja9tLOQ8cp15odikfxBiYzuqX4G/fOEDsMkMgN5VGvJLBriXERh4bvAiF9Ay5ck+tGL4U1t7qy6a3oDgthXiaWKPZGXDEyrKY5k2Ydmv+9ftdJRebPzJ4dN/1Mf5F7OznBjHQLrvOdb/fmaux+xeK9elSNP77iJ/UXWit9/4dWRk04G6aPVYuW5JHAQPbgAtKKtep7YKUXqRFABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR4A4Z3FGoiJ/nVvHReJDKF94iLLLuEzW/88P8D54io=;
 b=Q2vhNGqE/wo67TP7nTSU1Wn9MLVv8QfeWIoTa7d6XIKH3mNDMx9EufnawCXSipl6/3U5S+yFTXIMqTBiZeJpFmfyjOqO9BW+Ka9iBlPO+RDJQ7WyMSNgIKJhfJp/tyyxuDeKJiGOfGWmFo6ISFAgV+NnXCgXf/92oNtIfoR2dfiPO3i/AwjjOXaNQFkCAqenyDpO9OF1977gq7GoRDlWlb4b0rWNSXOQ4oADeQcp3uyJmmBUOD2p20gFdl29woiLYGweSVESfzvntfPZQXZUUZgMKKux18Gxipm9OqibK3+z3vwymW8eHlS3qUbXW4/Svy0F0Orn19wY4dfVjtdHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR4A4Z3FGoiJ/nVvHReJDKF94iLLLuEzW/88P8D54io=;
 b=COpTP0YGlXNyoNeHGHVUNSQTLRYkLWHRhkMd/LIZF49ZZHqyZ87/F49Fsnkk/HfbtixjbSrWMrqTlxPewuLa8RQ4YJhS+IiQpncrDofZiMCn9Tii09LFtTgwWMW2KY6VL7GO4CHIy5XOwJlH2JgxSKT+B5DXAS7rBEOgIBtlrJM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Tue, 29 Jun
 2021 11:25:58 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 11:25:58 +0000
Subject: Re: [PATCH] drm/amdgpu: Set ttm caching flags during bo allocation
To: amd-gfx@lists.freedesktop.org
References: <1624922136-15220-1-git-send-email-Oak.Zeng@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <ff6363dd-2a73-d2f2-4343-adc04a94dfbb@amd.com>
Date: Tue, 29 Jun 2021 13:25:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <1624922136-15220-1-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f27:5d00:9499:a270:2927:4d86]
X-ClientProxiedBy: AM0PR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::15) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f27:5d00:9499:a270:2927:4d86]
 (2003:c5:8f27:5d00:9499:a270:2927:4d86) by
 AM0PR01CA0146.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Tue, 29 Jun 2021 11:25:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53c0e9cb-4dea-442b-7636-08d93af0aaac
X-MS-TrafficTypeDiagnostic: DM4PR12MB5102:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51024B723CFB2BA5E37B19A08B029@DM4PR12MB5102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zD60NHEl1aCOe33B98br+CoCRJyRDl9bjloe4xfSeFxh3ta12Qw7XggFvK21CvcdnsZ4J5U/1cv1eoGanHi/yR8XG0cewxEbA5E4d27D1ag3dQiZ6Ddghmo6ma8o+q9/R1PjXm5ZYX2Qwk2j9/bee6pWgZZAWFQMWvXzPkuovJqNTv0fgQv0z95qONwQU9fRQuoib8PZG3NYdQD1adgpMtiVvaj1M3Z0g8seMzGp7YpK0xIQ5xnheUKN6Z6phOBWN0Uf0fyqYJixEXjD+E0LvNuL053K2chU6aTZhf63M2dU3Fo6yliCRqMltiteAw6R0h1jwH7elvLgSOFdaph/j2PAJhhTDBpkx3uka0/lIZDsRWIf81/26U1SKH7L6XQB894EjdU/ADkvAaf086NqlkWPfHk1/TVg5RQTnQBdCteW9yGeO1sf5SdfmLhLTi0VIZuSXlajvqZTXNOqQnfDwrsT4/uD8i2F7T5i1y2EL8N44wfeF84Hlza3cgroDAuxJ7f3hs+uTH/9b7/yXyas0JWqgWd+hSrmX+DXoQY1KdYxOhDTCalkqFMZCGvT65gN/fSFHX2CG7UY6Pq9mVjsunEJpgvgWCQf5Z36GNJoHS9i2KfUa4pJV12OZ2b4x6kQIT0mT9ydH/pe0xpA2y9OWSJaoOPcjFeFGgzQRz3QiWjLGF/4sMQSzLt/uFWTTW2ucqUDyjJfFMo33MoM8XTTbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(38100700002)(478600001)(2616005)(316002)(16526019)(53546011)(2906002)(52116002)(83380400001)(6916009)(31696002)(186003)(86362001)(36756003)(8676002)(5660300002)(31686004)(6486002)(66556008)(6666004)(66946007)(66476007)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDNvQ3JkaVllbk9UbnRiMUcyeW5QSSswMktHQUZYcFQvUEN5cmtTaFYwRzZI?=
 =?utf-8?B?NWN6Z3p2RlhlV1hvMWdXeUt1alZoQ0dNT09QVUZIUkx6SzdybVRldkFOazBk?=
 =?utf-8?B?ZSt0QmNFM1dQY0g0dlZYRnVQZVdXWFZEQk4yWSszMkQvNzR0eVE0bHBuK2xF?=
 =?utf-8?B?MHpBNkpZempJN2g3Q05EZHprSk9DVU5DWUNHQUk5dk5ZY2hBZVJscXdJKzhO?=
 =?utf-8?B?MlA4V2h2aldJRW1LT2JLNUZQTXFTT09LemhzU09FSFNtV2FndDRXRzdWdlJr?=
 =?utf-8?B?RkgrRTBRcEtSMnhVSy9zcU41QXYwTTJTSURrV0VleVM2dEQ3VnE0VEVJdmI0?=
 =?utf-8?B?eVZFWkM3Sk5GRHBwOHdOVWxrcERlODFpakVyUFR2L0pWTWhFQVBjbFdKWktN?=
 =?utf-8?B?MWFrOWQvb0cwcHdTeHJ0VzVrUkZQdUZSaHFtaWNyR0RGbnVkNDZvKzBjemRu?=
 =?utf-8?B?T1UycTRDZkQyc3JjN3R6RGRORlZuUmZQNExtRzE1R2hMNk5RcW1OclhTUTdT?=
 =?utf-8?B?Q25XaUl6R2pvdStaVVJ1MDVaeDZ6OXl0LzYxYjBOSy9wUjVkcGRPWU4yeVdY?=
 =?utf-8?B?cGhBN1ladWxoaTFwRDdDTTZnaHBCTXBWc2gwc1Jkb1VHZG1GQ2h6emQ5MFlO?=
 =?utf-8?B?UzdXTzhwVGZaYlRHenkzV1Y5NXhnV3EwYnR0bmE1TFV5Y2pqeVhySjhpdEh4?=
 =?utf-8?B?YjdBd1pwdGNIM1ZnS2xXcnUyb3pDNHc1UGxCaERPQkpuSXhkVnBYeG9hc2VY?=
 =?utf-8?B?aHJiZmhyQkVWUjlSaVUrRVFDZlVKWGVqQis4S2t4Y1VnS05EZWhJdUNtcE5v?=
 =?utf-8?B?engyK3AyRjU1aVJsUHVxdFJiR05zVytnRldwTWlDTGVPc0d5TjNEclBza1lj?=
 =?utf-8?B?RzJWQzJYeWVtaERRY3haMjMvUlVkUUNVQjBVcGttcldnOHRJSVJKWTlGUnBj?=
 =?utf-8?B?Sng1ZmtUMktRQy96SmZBbFlqT3JaZDQ1NnFqcHNteGJrVkZyOVdxTERkODMr?=
 =?utf-8?B?N1JzMklWU0xDR0ZtL1NIVmNmUk53N1NIUm9ETE5VUmo2ZDFTVk05UWJBaXF4?=
 =?utf-8?B?TW9pdGxjNFVSbFZ0bTVnVHNzV1ZkK2h4YXZJOWE0T3V1a3psREgvNXNLdlFW?=
 =?utf-8?B?TWhSU1JMSU4vclF5RGFTNmhuWi9heUZhNjB6Zlp6aFRxVzE1Qy9vQThvRVQy?=
 =?utf-8?B?OVcrODdmbGlxWVBRcTlGS3Bjdm00TTY3V0wrVVlRakxWUXFSN1BVUnMya0Fu?=
 =?utf-8?B?aHFzUWlpVGRZRlVHSDZRcjJTR3pEdmswY1BkNExFSGFEd1ZoS1V5a1FhN2d6?=
 =?utf-8?B?Y3VQNGMzZEtHRnQzVkQwV24wVUtzY3Y2VUc5UHU1NThMOFlPWjFIOHYvdTNM?=
 =?utf-8?B?WDdNMVhxWGZoVGJvNWVwZG0rdEg1V3B0THBhcTc1dVhsN2Y4QUM1L0RSN0Ro?=
 =?utf-8?B?SlJJNCtrSTc5Zm95UWoxNThkUVpkR0ZGY3huQXRPazlxVGpDMHA3TlltTU5o?=
 =?utf-8?B?UTN0MDhJNENXdC9mTitGamZDRXNtOFQyRkNiTEpKT3pKM1NJUXo4MDlKTGM4?=
 =?utf-8?B?Z1g0b1hDWTFUTkljekpxd3YrQkNHV1Y2R0svTDZxWjRYZkVvaFlXdUZ4ZVJD?=
 =?utf-8?B?UHIxRGlYVDJUUEkxZkNKNHA3RmRSV2FSUjRmUzl5cjAzTS9FNWhrMFNwSzN3?=
 =?utf-8?B?Sm9HQ0RUYkJncmVRRmxiUnFrb0QzdEM1Q3EzZFFFSHcrek91N1BHTDJmMjgx?=
 =?utf-8?B?RmVRKysvUFJTWDFvQWpvM3IvYUk3cDlWVk1tZnExUzEvZ0w1RW5pR01yZ3po?=
 =?utf-8?B?UDVJSGZieW1zdFliQy9GYURUNm9NejZYV2I5MGppZStITzVybWJ5c1MzWWxn?=
 =?utf-8?Q?CJBUr6bD1nnHH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c0e9cb-4dea-442b-7636-08d93af0aaac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 11:25:58.0821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7voKVk+1N7GvI5dIf8DejSVNpGgM7HjN3wTNLhw1G1Hb91XlkqGTsyCu1OcCgMMqKHdaTuzH9e2uhobDFfnDpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5102
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the detailed commit message :)

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 6/29/2021 1:15 AM, Oak Zeng wrote:
> The ttm caching flags (ttm_cached, ttm_write_combined etc) are
> used to determine a buffer object's mapping attributes in both
> CPU page table and GPU page table (when that buffer is also
> accessed by GPU). Currently the ttm caching flags are set in
> function amdgpu_ttm_io_mem_reserve which is called during
> DRM_AMDGPU_GEM_MMAP ioctl. This has a problem since the GPU
> mapping of the buffer object (ioctl DRM_AMDGPU_GEM_VA) can
> happen earlier than the mmap time, thus the GPU page table
> update code can't pick up the right ttm caching flags to
> decide the right GPU page table attributes.
>
> This patch moves the ttm caching flags setting to function
> amdgpu_vram_mgr_new - this function is called during the
> first step of a buffer object create (eg, DRM_AMDGPU_GEM_CREATE)
> so the later both CPU and GPU mapping function calls will
> pick up this flag for CPU/GPU page table set up.
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> Suggested-by: Christian Koenig <Christian.Koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 4 ----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 5 +++++
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6297363..93acf6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -607,10 +607,6 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>   
>   		mem->bus.offset += adev->gmc.aper_base;
>   		mem->bus.is_iomem = true;
> -		if (adev->gmc.xgmi.connected_to_cpu)
> -			mem->bus.caching = ttm_cached;
> -		else
> -			mem->bus.caching = ttm_write_combined;
>   		break;
>   	default:
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index a52e17e..6cb66eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -454,6 +454,11 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	if (i == 1)
>   		mem->placement |= TTM_PL_FLAG_CONTIGUOUS;
>   
> +	if (adev->gmc.xgmi.connected_to_cpu)
> +		mem->bus.caching = ttm_cached;
> +	else
> +		mem->bus.caching = ttm_write_combined;
> +
>   	atomic64_add(vis_usage, &mgr->vis_usage);
>   	mem->mm_node = nodes;
>   	return 0;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
