Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE02C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 21:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0410B10E81E;
	Thu, 17 Feb 2022 21:16:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909B110E817
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 21:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft8lQUatScur4pNAYUbNz3ltvewkuDAHe4MRS4gVD+2H6e94j87eG3G3fApnhs2XRImffHBI6jkMPtClJZt6WTDe2KkJOatiQ4U7V2k8cxIEy6vIZn/zgIFqyoqPY2+XsBDu+TWRD4/6gFHYVnvHs7Pek2eEYFFjVdbC1+AWLctx2fva5oaOZ9c6q/iMdBb3O1gTWmAqb/xabtMYHfiMuvdgnJlBAi6DNLKnfMCGY2pDYi1cq1UqWOWV6fy4558MLiMivV01KdDAnMxvivZ9fyeAXh7M0IwZ7e52nezsmfKt0dPVB+Y3Pdmg5zyPuaQgu7/4QwP5DmB7QJ+ldPDdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MP9dZdrVf2pJirlB0qUmOqeaFHamP54zc/C2SV843k8=;
 b=dULuqp5GP1rUhdc/sFjvRsIaKj88C7VdkXHz8X68VcTPhcNc4GAXLB2KFy3NyQ8xu+WoMyKKuMVBgc2/pDx/6XWwpUrtl+czZ1v4FRWbzOuNU4GadqFsK3UsLoo5k3w2c+5PnypBqa04k7NS/zrHW+x35uxiXw5Rqp3BdjeOzdnk0M/SWH673BLhidE0TvMTGtkEidv59D/tnhj2hMCDeGWI3FDAi4pxw5cRtoYMz+tJSzBbuWw5FtfZyF43XX6jkMlQ+Xyu2GpfATdmbEoISdpxMK0qiiyTZmelWIocGdRYDxTasl2OIdaWTnkv1VzbVjxCw1/djxMm1NMXBcQSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP9dZdrVf2pJirlB0qUmOqeaFHamP54zc/C2SV843k8=;
 b=Hp38w+B9qaylLe/YYvdiqJQz4abNELY1UUL85NzaIUh76MYHBckSsIi8K/t4y8WuufHBV505mLbQ60UuasZaQDWht6Td653eSUiB67fh5hmafJhjDX3j4u1WSb/w+Le7A57XnbnW9x2e+GoGGWyXjB5LWUQow0pN0mWnreoBBu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Thu, 17 Feb
 2022 21:16:39 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%4]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 21:16:38 +0000
Message-ID: <67ca424d-5536-277f-5a9c-3291cda9202b@amd.com>
Date: Thu, 17 Feb 2022 16:16:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] drm/amd/display: Fix DC_FP_START/END use on non-DCN builds
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220217210528.8644-1-sunpeng.li@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220217210528.8644-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::36) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bc5ce63-bc28-49fb-c345-08d9f25ac8bc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4032:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40324BFD1AED6E8B6EC9D13D8C369@MN2PR12MB4032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ek766fgok+1fnZaqpkcfgkx5XXURzfVFtGSbNdOAj6ME61sUxkI+f8FJy9r5ZYNi/C5MDWe5/Nyc+afCdMDMplFjDH3R4oP1DE9q4l2KjnAQzQaX4+krhWC+dVp044F6s6tv+iFlj9YfxgJgmezDS8fCHV9H/FCs3xhBxQ+V9ihbwUAA4KFetB60RPI2wNeaOVkE1d5tLfoAgkW7Hp1Fdw1u8eAKE+CL2xqvcciH2avry9x8wiDz6sGTr+28rtdAUkwgMnbVryMv6OPCtD+fyU+nyIyfZ2Xm2rDqGAlqoVYor+sZPqo7aQXg1ZTbvO054kX8ITg2zzpfoAYle4V3OhHt9IOJcuJCLTg3EhMtkkathyw2cpDOGptAVXwyIsgMDt8yjv3+PlkXmapOqFBmYqPLpXUYB4sDZWBqCFw0+c5WeuSAGyrtD1tUwKzEqCRWv/4DSGHI2feEwDI9FGI9QorpNKjmLD/1Xj/mKt/g7WBGmJPCNIqhJMPslnQTHaD1ZdLJNrP6x0TgjzRTgCTFcFFa0MwUYdioPZ8+FvmfIY5TK9mFsd1EBekWG4OKK0W6LriVMISJXRaNcrAn3UdnJ0LenObSNmcmyiXurtNsP9pHMbDK7DPbZGEON4AmUK1N3siQmBJxWc4O+BdO0e/VTvjXqo6PnNWl81h5g2vbIQ/1LxOkd0xd5SfQqBwoTCnvmo/LWvKaFZgxf4ALGSH3+T7fAwLF7y2Xnd+BY0rCumQ+d1S5lp5IqGHLYUWp8Q1E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(86362001)(316002)(4326008)(31686004)(66946007)(83380400001)(66556008)(66476007)(8676002)(8936002)(2616005)(186003)(36756003)(53546011)(6506007)(6512007)(6666004)(26005)(5660300002)(31696002)(44832011)(508600001)(6486002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRRSG5ZSjJ3aUZ1d1lTamhvc1BKUllHMHJDcG9sWkNHd0I5T0VYYXM5WXRm?=
 =?utf-8?B?d0w3ZlY0T2JxQUZGTEJ2dFZKVjlqaTNvMlByMXdrdWxDR3hsS0FiL0VHelBW?=
 =?utf-8?B?bzdPZ2dURkVmYm1KeWxyMnlxRzc0c0JmczI4dGtWK2ZLMWpZSkpucE93MlFP?=
 =?utf-8?B?bGRCbVJsZXV6Q2ZhMWZoenRzZnE5WjZCQU0xNFdXemh5cUdRT2dSODBzRzJh?=
 =?utf-8?B?NEl1OFVIT0dnTlFySEx5NGg1MUNMaFBZcEE2ZEZIOWtMOGM5ejNEZ2Q2eGtj?=
 =?utf-8?B?TG1BVkJwODRzU1FyMDk1RnN6UEFWeXFEVjdib0RFVThNRUJIUTJWd2hENDRx?=
 =?utf-8?B?dGM2S25DMnJFRUhnYTlkNHhkMmdUOFc2ZWp6KzJlZCsrUGVhdXJkd0I5alp1?=
 =?utf-8?B?T1MxSWozMU1wOW1QeS9sL09xbWh0SExjVC8zRndXNXlHclZrQ3Z2RzBwN0pl?=
 =?utf-8?B?ZGZSbkhMRHM0aFRmRVBtd25lNUFxN2hwQVNwWlRkUGlTS2RqNDdmYTY1enVp?=
 =?utf-8?B?a1ZrZmp1VHJaa3lPYVNXTFUvNTZNT0FCVHRWWWsyT0pTQlNvZHpZTUJwMFRr?=
 =?utf-8?B?cHFSOFM1bE1Od2k1K0liL0JVeDdSUHZIMG9Oc21FVktDUFZDUWRKdEZYZWRr?=
 =?utf-8?B?Q1F2MTZNMHlBM2hxWmF3N0RVRGhCODlHZFBlalJFRkk4bG9VVjVHb1AxdlZt?=
 =?utf-8?B?ZDFtNW5WS2JQeFZZemt2eUx2MGxyM0VqcUdXT2p1NVdBRHlmYy9Ra3c5YW9q?=
 =?utf-8?B?RitmRi9EcXdGTmZ6dGNyUktML3kxZXU2WGw3MTBIZERyZWY3WHZCWG5NNHI2?=
 =?utf-8?B?Z1FOVGRvcU1yZUVzSmdiaXlhcEZyaS94MVFMU0EyWHZQMks4Y1hrRW1hUG9k?=
 =?utf-8?B?RTFuTHROSmhTeWIxT3V0VDdBTDdKRmpXNEhNN3d6dlFkdDNPV3kzMyt3cC9h?=
 =?utf-8?B?WjJkQUU1Vk9WcWE0cnAvN3ZYcGpvR2IvR2l2cnR3QTU1RndVRHRrMFRwT29l?=
 =?utf-8?B?b0FQTG1IZDF3VjdJN1MwOHBTdFBBYkV0czZ6Z0hnNUJoQlVhaEJReDNqZU5h?=
 =?utf-8?B?UCtPTWtaUUhoNVVXZVBLTC9HWEJvSGcvVHgvaStXRFBhOGVmTkVLTFdLZmpw?=
 =?utf-8?B?VW0ycE1XZTFOUTdCdDVnbjBtYTJobnVJK0E5TUtFSzlPYzB5d0FyWEMrSzNu?=
 =?utf-8?B?MVVjaXdoYlZXQmxheUdNeXBwTHZ2UUE0c0V5SGoxK09oYlRIWUdxSXozL0o4?=
 =?utf-8?B?SUI3VGljblNIS2NwSHVyeGp6QUl4amNUMFNLWGNURzNHU2xXWmRkRW1tbzJI?=
 =?utf-8?B?d3Nyd2dwUTRUY1JuQXNiYkUxSmhkOS96QnF5c0FuaG41Q0RybmpWR1ZpTXhK?=
 =?utf-8?B?Vm9LQU1aS0hCRGpINkxvWmtSeU4rellXZzZUdjhjMmxhZEZnNDBsTHBYQlZk?=
 =?utf-8?B?T2ZkZnlLMUJLQ01YYjRnNjNWWU0ybkZncDY3OW9rNjAreHhMalkyREt2SStv?=
 =?utf-8?B?a3FodldYS3JVblJpYlc1VlJrWHM5a3QyV0JNMXhEbkFyUDBuTitKdWo0eTZD?=
 =?utf-8?B?KzVWandUZTJkSGU4RkRiY3orYVQvVEpJWFFEY2JlQWJnNVlheUp5azR6akpM?=
 =?utf-8?B?SGRNSU0zdzNtM25HMVk2TlBieDA1VWEzTmlodFVNdTg2TCtDb2Z6ckwxelJD?=
 =?utf-8?B?eXJtTVIzSlozY2tHb2x0enJRK1k4bjJ3bDlMZkM5bHNMTnZGc1krZnFKamJv?=
 =?utf-8?B?dWp1S3lYQVc3MGs5d0R0U2hFYU1HNm1LaEFkVEh6ZHhjdVJrU3Fxc2daM204?=
 =?utf-8?B?RktQelRNVklnQkVSOUdGaTFML1pVRTVCZ1J2cGlHVHNpZXh1Nk1ZOFdMVWxt?=
 =?utf-8?B?V201c2l2SFUxVUZFd05xbnNod01DdnZ2K21lQ1MyRGcrbnVqdm56QjZaUGtz?=
 =?utf-8?B?YmUrdFNGMWozMm9JN0lLTGMzVVZ6UEk0TmcwOUdWcTVqZ3o1S1BUNXV0am1i?=
 =?utf-8?B?eDFubzRBdGpTQVRScC9oWXk0ZC9wbkFPYS9EVjlVZzk3UW5JRjhnSUxzZTJN?=
 =?utf-8?B?SkdSTXJrYUhlZ3ZGSFFRbkI4alZ5KzlMY0gySFlhUjU4U1ExMW1FM0VZNmdI?=
 =?utf-8?B?WHBQZUhTaTM5VG9CbFNIVG1EL2I3K2t0NlFpd1VJYmlpYmpEQ0IzSlhPUTBu?=
 =?utf-8?Q?KHE8fMhBTQ4ANwosrxRSi3E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc5ce63-bc28-49fb-c345-08d9f25ac8bc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 21:16:38.6193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjrarMGtIYpV+ybK+pPrz5Ea5V503H6/wglhleKuEIIaB4IjyzlICHuHHJ9UuafR//Jt9aKQZ3gvsOglSGg8jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4032
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Nicholas.Choi@amd.com,
 Rodrigo.Siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-02-17 16:05, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> DC_FP_START/END is only defined for CONFIG_DRM_AMD_DC_DCN enabled
> builds, and update_bw_bounding_box() is only valid for DCN ASICs.
> 
> Therefore, wrap the entire thing in the ifdef guard.
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 4ea114725d61..b1ce3c0cf477 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -987,13 +987,13 @@ static bool dc_construct(struct dc *dc,
>  		goto fail;
>  #ifdef CONFIG_DRM_AMD_DC_DCN
>  	dc->clk_mgr->force_smu_not_present = init_params->force_smu_not_present;
> -#endif
>  
>  	if (dc->res_pool->funcs->update_bw_bounding_box) {
>  		DC_FP_START();
>  		dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
>  		DC_FP_END();
>  	}
> +#endif
>  
>  	/* Creation of current_state must occur after dc->dml
>  	 * is initialized in dc_create_resource_pool because

