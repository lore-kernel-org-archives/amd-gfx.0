Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31085C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 23:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36EB310E109;
	Thu, 29 Jun 2023 23:23:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 889F010E109
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 23:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SImaYmS7zF4RsXYo3Bakvzn2G+MLclUY56QhS6gGdWGS44plFe3/EG12uqBoaK3snAjYkbvak2jVOahK7Oggm0SyN3pMaa0GQjLmBO4k96iZYX2r09UMRNXHr/UAsfq9TbZNXK9VecdLxQrI7YKXq39qe9e0iQiAhaGGEBjxPgQhRMdALWs9SDcMGGLJNxSmk0PkTyr68DI2L4wf1VfVYjV54x8iRU3bdzZqRmZKLb8iaxCbYTpYwpzEHgvv1+VJY0wG7izM4ZXk2u8cgED0g/OSu7s9JaGoUSAkdcp2z73MLmqxk6Jr8wTMF9d/O4GQhFTvjLa5Mi5DEYxwSr0GRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCPJUp4cehs6lNB9SMHlMOXpq7N+T59Siojy8Hg5OgI=;
 b=W6dliXRM0f8RdH4PFLB+deyB/C2HkVAdTJz5BTT9mI+TU7y+kKLM2n3jFTVdEhRglxCIRBiWbaaC4UynfwPO+dptOLQEK705j7TMUhWVfXlGrgc19jWj681xt6eY86iSRDPywlGphJvMySVD6boRhAkc7C8Yv/L7tUKLH/Qsg5O+rXBOOI4GK5uhZgWtbpUI8TGvuW3kYrOPvVh+C3RRIMp7FcdxpT3PmbzA+oY4DEOZ8m+e+FCCH3JfUeHcM6wCylfMSm0lUBn4bHN8Kjprq8DM8Q9ny7UEIT7FmITgw3aUUI/iTT4PQ0HCRJhCAEnXw2G2wJBwA+kpfQ0vuUZ5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCPJUp4cehs6lNB9SMHlMOXpq7N+T59Siojy8Hg5OgI=;
 b=GcCWzlQ9scjJ3r6Wv2jZKTlQoj6COodzC+b2vL2jdq/1aEdGE7J/h+1t3EjQCotAErYoN5ALCTGtQlslZOtJiG+c5kZ9KaomZcoUTG0taduEhjzeHRIZ3ZrMs7VvnotNpUDYiPJOCSYCwcLV913s+E4XxVbZRFyxF43eGd9vzh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Thu, 29 Jun 2023 23:22:53 +0000
Received: from SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::bfec:5fd8:f8ba:1afb]) by SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::bfec:5fd8:f8ba:1afb%3]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:22:53 +0000
Message-ID: <c1b473af-55a9-4a8f-ae40-5a843d6622fb@amd.com>
Date: Thu, 29 Jun 2023 18:22:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: Skip handle mapping SVM range with no GPU
 access
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230629222926.9078-1-Philip.Yang@amd.com>
From: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
In-Reply-To: <20230629222926.9078-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:5:54::37) To SN6PR12MB2717.namprd12.prod.outlook.com
 (2603:10b6:805:68::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f74e57-ff6a-457d-b468-08db78f7c30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omGRYYczeQ9HBWam4bkwsFM8f8OI/bMdOcPDR3zFIoRyglTs3kNg5LoW25PIUZ6CaeSOTTdB2XoH0tafexYcz4XgRBKGOPZifpPrL8d2t1+oIMgKKbZHovCOJHUq0nU97tWcmRS9WxBxDnuDNWLvw7Ur6VO5eo9qeM17vB5hXAbpKrOVPLiOcLz5tOgh6EcxtbpBWfGYGRZSlInbi9t/N6IU2xf2n7PoiuIM4SQUDC4ecUnuuMDI4rZmFv84A+/uT96OmRaE1GPUBeK76fbXS1JgjKmO+iA1nv7cHvdPDV4CytsbG6BJyLIKQ4Y3tEsWkcbeyn02yj/wysJ6YivfDMG/ATMh67lrGtUt0MRYN4jyA4N/w25pj/1hEGYPogW4rXEGebRji7gRYX2aNL8D9kPnZdPWg+zh12/Sox9bU8p+sshlH2twxCTqbc4Ft8pWiYexh+DyFBwDLX+OpbHPVIj01o+6WtlERsom/NeIIIoph8gOKTOzyDdiIjFwD7wZ4saeZBilErvTBbnFT3bqyAwbUMRx/rj1mtakgMlaaa598+sTzsR9zgbjm+AKHiraETgmClcGXNbnpF6seohQCnmOMVF1CkrXfat+9v9EMJOvwIV9WoK55Fsj42idKxbmOwAr6TbAxxkoZgvfywDv4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2717.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(38100700002)(31696002)(86362001)(53546011)(6506007)(6512007)(5660300002)(66556008)(66476007)(66946007)(2616005)(186003)(26005)(478600001)(2906002)(8676002)(4326008)(316002)(41300700001)(6486002)(8936002)(83380400001)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0duTGUvRnlaN29POG9Sa1RPTjA4eE8vYitXUHNWb3pmSmhqL2pTZUlXYjNo?=
 =?utf-8?B?UXlCZFNHWW5LaDFzNjNDOTd1ZURMeUJONm0wR2liSXI4ZzQ2M3MzKzdZaHhV?=
 =?utf-8?B?dVNJczA2ODZLZjB4c2poYkFPK1N2Qk5GZmtUL0MxM2MzeUVSTkp5WmZDZFpN?=
 =?utf-8?B?N1dOR0k1OHA3cnJJb2Q1QWQ3M1pyS0Vkblhvd0VJVjBjYWd4a0pjUFRWekZB?=
 =?utf-8?B?UVVXYzBQUnVYZmYydHRrL3RpY21QVmlNdmx4bndxd0dLTWJjOThYWVBPYUpJ?=
 =?utf-8?B?ZUErakZrZ3ZNT1A0SEpoMG1oQ1VLdGIxWTdpSXN5Q2k2V0lVck5jOFBxMlc5?=
 =?utf-8?B?cGJlV3NUL3h6UVBiQnNhbzh1emwxYnJYRlZibWU5MnZoZXFYdVZHRTVvOGov?=
 =?utf-8?B?SGJpNUJuVkVFenV4cTBkdlhBR1R3NjI0OW4rbUl6Zy9hQkhqcXNxRE9ETldS?=
 =?utf-8?B?amk0UytXQ0VPN1c5ZkxleHF2YndmZ0NQWVBQWFQvMUNjcUJ0TmVvQ1dNdHBG?=
 =?utf-8?B?UDlieUpmK3JGSDdlMlE2Q0wwZTFWRUlMUlllSDgxbDZJYTh2STQ2L1c5RGxo?=
 =?utf-8?B?c1dGekt6MG43SUw2dkpBdjV5SUtHMFhCYzFhL2RLNk5NOHR6aWdKaFprajIw?=
 =?utf-8?B?UGl5dFdzeTBGdlhxaWNmMjduc2VuUGVwV2xhcDN0VS9sZ1p4WHZZYnhsOXdQ?=
 =?utf-8?B?Vld3MWN0R1hkdi93aWVucE1yOUZTK1BZN2tLQ1JvTUczSTJER3pabFVQYjRk?=
 =?utf-8?B?RHR0Q1ZIOFFmOExWVFRpUmRNeTJ1eXN2MlptZkNMeDZKUGxPQk1KQUlWanhD?=
 =?utf-8?B?Q2lTeXk3ZkViMyttUXZPMnV3eStEVUNHVVllL0xLVVlMbEVPeEpOTnVaTGRa?=
 =?utf-8?B?dGxXVnlONncweEppYWxZSHRtNU05bUNJdng4VTNobGhVQ3FhMjdIeURIcWVF?=
 =?utf-8?B?ekpoWjVkSW1zUEpJZGJDaldxL2ZtaGk1ZWhVUjUvQTczVFkyVUF4VG1SWElR?=
 =?utf-8?B?UTlEZUxqR1JKU2ZCbzJPbnJxUm01TCtMVlovYUJUU21NcGRZaDFOdFU3ZWJF?=
 =?utf-8?B?ZkpJOS9DdS83ZXdadWJ3ZGw2a0hOTXpJOWh5NUlKZk9jd1gzRitWNTFSUDVG?=
 =?utf-8?B?WGVnSmdlV2FreXpPVGZlYXZXalJFbWVMb2dMNCtqMWp3QzY5bFZTWVBZVnpk?=
 =?utf-8?B?NnFKcFVPbDFkZFhOZkRiS3JocG5vYUptblNmcDlhNVZXVVcrTTl3RzVQeFh1?=
 =?utf-8?B?MVM1NUFQdGpwL05OdEJEQUpWb0dtMVJGejYrSnpUOGZUM1NRQnRwdXJQeFM2?=
 =?utf-8?B?VFF2Vm5EUjRUY25wOVFCRkpHTkZaU0lQTy95M3ZYOFBtd0VvckJaMktPR1R2?=
 =?utf-8?B?NWFkQ3FJaEVBUFRvU1A4UFRCck1ycWlNU09Qb3Q2eEhCcURtcnEvUlNDeG1K?=
 =?utf-8?B?VzVZREhyQ0EyejhmNkVjL1BlRXhjRE51cmZNS0RrZlVqOVk2MTd2NjJSVStj?=
 =?utf-8?B?WWp1eDllSkJtc3NNcWowbzUyMVl3cVdCMURySHMrbzFyelFkTkFHYmVoR1dl?=
 =?utf-8?B?aFJzR1ZGcFV3MjNlMVJxZGs4NHV2L1phaDJJM2N3cktlVGtNRzdZRHJDRmJM?=
 =?utf-8?B?VmlvTHd3V0dPeGNvV1IrcnFYdW9jb25uL0lJTFpDcDRkTU5rVlZTcTRWZzRV?=
 =?utf-8?B?ZzZEeGFob0VSSE9nT2MxNm16TTB5UThEbXQrZ0I1M3BDdHplbUViK20zRjFo?=
 =?utf-8?B?S2VzNHpPYkJHaHM4Mmo4c2JzZ05QNE4rZUUyVnh3OGwzd0NSZU9vbjJzbUFu?=
 =?utf-8?B?eDVNanFYYlN3Ukwrc29aUTZOdEpJOVRrcHNPQW9NVmJQRWZzU2djRTdWVWZV?=
 =?utf-8?B?V0ZZSHNlNmJ0dGVYcklMcTVwdDRvUVVKQUtSUVF5Mk5ZZnlSbDFtb2VTaUx1?=
 =?utf-8?B?cTZiM2o0WVdaZWxlM1E3S0hOMWJRYWpLYjZXSUFMWkZIdFZ6YjNxY0NseE1k?=
 =?utf-8?B?OW9aL0w1eHR3a3dLRmJnUEg1MmpFb01iakhtNnFKYUg3SXR3RWxxMTVTUEZv?=
 =?utf-8?B?cUlXeVFvWndPWjBJczM3VHNiTUxPdWY3c0lpUi9oQkpsakY2N3ZOK3gyTmdw?=
 =?utf-8?Q?wRYwaRAgOEl9L5XAy+NG7d9wk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f74e57-ff6a-457d-b468-08db78f7c30c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2717.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:22:52.9795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwgMkkZlxbaBFdwRhUng79O0qXCX2DXOWejYI4Md7Iyd2TjbhNg2Qyyn8XV6Vpa+UB1f1QRdl3XraA2ANlXWwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/29/2023 5:29 PM, Philip Yang wrote:
> If the SVM range has no GPU access or access-in-place attribute,
Just a nit-pick. Shouldn't be no GPU access nor access-in-place?
> validate and map to GPU should skip the range.
>
> Add NULL pointer check if find_first_bit(ctx->bitmap, MAX_GPU_INSTANCE)
> returns MAX_GPU_INSTANCE as gpuidx if ctx->bitmap is empty.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5ff1a5a89d96..479c4f66afa7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1522,6 +1522,8 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
>   	struct kfd_process_device *pdd;
>   
>   	pdd = kfd_process_device_from_gpuidx(p, gpuidx);
> +	if (!pdd)
> +		return NULL;
>   
>   	return SVM_ADEV_PGMAP_OWNER(pdd->dev->adev);
>   }
> @@ -1596,12 +1598,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	}
>   
>   	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
> -		if (!prange->mapped_to_gpu) {
> +		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> +		if (!prange->mapped_to_gpu ||
> +		    bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>   			r = 0;
>   			goto free_ctx;
>   		}
> -
> -		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
>   	}
>   
>   	if (prange->actual_loc && !prange->ttm_res) {
