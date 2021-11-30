Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB40C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 15:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201526EBD0;
	Tue, 30 Nov 2021 15:21:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49826EC03
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 15:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5WKlWodgsRzFS0uI6Xg/6LGfMcv4/FDkhyJo9NnQAaSQ4ME721YfADLtRmCZYY4Ii2UNOTqHe0L7bQw0zoDvzTF79wf4mlU+x2D7lWxLqHdP/zuWM54zRMCmcafQ69P0H83Spqtofh3vRVJsLShWfmiCosRLGXSNF9Pk0tIMhulFp8K+iDdZe9EzdY630pMDFHccSdDtGMFn/0bJiyEZ3JeabZ6HBnrTmktea+LUJHoimP14dbrvMj05xeEN6unykejLsFKSdkBeMChmXQONwvEYlZwmuLBvUhEbN0LocayrKUcwXDIJpwiOjzFc2m1ko3ozKrm9UXxhuqOIfpG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15bsoGXO9C6DCJlWb3oP6h18XYghXr+7JhAEyNZMk44=;
 b=UH6yTa6wswkQoBwKjEzdUbRqQNarX6jHGVHDCA6stZMBK42uJHR1nWMyNMqhYrzEHvbgz3X38Io6SRc0OAzBx4CBSDBDJKbl/caYAcO5g50E6qzVwwpLe/ehlNCXml0gir7bYxwYkNtBk0WXk3QtBx8c217Q9wwzw0PsTmzh8Zvql4JfvLRwVCnSD+SWjn+4nz8+/IX3n//dQsLkg+kMM1a8oO/9sGYIcD9T8GIwIWHvTnm9qrD/nUieMg3njwFcDZjjNe6ALmVFIqUXX5C8NKg0JJ0DVVXOAr+2ONcESQ3E4toHFFXxhOhOU30Wf9qDkRsthbp+QXX9AK5TwBZVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15bsoGXO9C6DCJlWb3oP6h18XYghXr+7JhAEyNZMk44=;
 b=W4o1ZpIaot2DksebEfZmIubu1zRNi8UMy1MUzkkKQ4gt4LXSg0SSxpGkagcu1+OgXARiBz9XudpayvrSp/HxRlUEEeeaGX6YL625+N5NNlkowfl146ECY3A10Q9hKnsalNa9+z7qKfoRIsosz210PXHHYx1GWS2BpRPDZwjG2g8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 15:21:06 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%7]) with mapi id 15.20.4734.023; Tue, 30 Nov 2021
 15:21:06 +0000
Message-ID: <980b9f5a-c9c7-8719-c92e-762e25b37b65@amd.com>
Date: Tue, 30 Nov 2021 10:21:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu/display: Only set vblank_disable_immediate
 when PSR is not enabled
Content-Language: en-US
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211130145333.38917-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211130145333.38917-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::45) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 15:21:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9c4a82f-0d07-4754-8f7e-08d9b4150756
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5410087F6D5AEB1C0E9114068C679@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLnZxaCaKa2ojr87NWzbaP3akLG4ruVEFFB7HU8fsYhi2AOCIyXg+nqz60gPfsXLow0fnBtiHzxRSvkWRXbUDRCg3UT639leo51b60g6ad9Cuzsj50xbLwWDd92VEXsA/P3njrQuCzV3COzm4jQuS+V9HJGbfF4hRWxDOqAHaE7w4uzfBwrR4aYugi0j47EPiKWOC57grSLDQiPPv5oMHgCE5s6jnN/6/sS4szfjky5NUWtKJpqrZ4skC/8bqrAI5pyJvkMUCVu4li+fufdG8ivwUqihqEyoGG2CHWL7d552xigEptEpUta4xXNj3z2q1+vMKXg1OjJJBRLiQKXfzsyosxRT0l6kNRS/zLVCiXD/zpmgZJ+eINqYS9CEXe16cAktzMV5jYFUCNrNU4xybRCbWp+RlVAKKWy3HB1IrukHyoGbqi2mwxGhxXfb1CBuMrDmqsSlTyKOSEVJgnDHHaZdrQ8GVJuiyxEki8IT1j7mwy+Hl0Yb2I3Lf0Z885INZ7E4zItOM2w/1A8JOvhBaqKPRZogyYF2GPdW6fEopnoB47bIl2u/sSw+1MHkxdEa1Jj+1+uNx55rWmlyCi1xTVo1Gwl4ltXCFoWxSIuoFGdbioYY4U5BlSmnob2KpwbRo9Del5eglZ5BIr7eXkUUdL5OudT2/RmTg4rdke5NKmOlZ1OAwFS8UUjHO0mRe0B4+38yu6vPAsBTY7QwvOImLBPI+m/yWfVdN5FUIsPLvig3PoWyW06nu+YrzfQfMCVpBT8O1b/N/Inq8ocd0mitNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(5660300002)(44832011)(8936002)(186003)(4326008)(6486002)(508600001)(6666004)(4001150100001)(66476007)(66556008)(2906002)(36756003)(86362001)(956004)(2616005)(83380400001)(316002)(53546011)(16576012)(26005)(31686004)(31696002)(8676002)(66946007)(14773001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmoxUFAwQU9GVFphRUFNU05oU1R3TTVoekRzVkUvOEZDT0phazc3RHFhVTFK?=
 =?utf-8?B?OXdpWDlOVEREQ1pTQys5cUI3aStMRVBOZnRReHkxTHZYYnNiN28yNWRqaWhW?=
 =?utf-8?B?dzJMMVRsRmN6Q3RKYUxGK3N5L3JhWFhReDFJeUFNSy8rekh6Q2hMcFR1TGRl?=
 =?utf-8?B?amFyS3FrRHY1NGJObzc5Zzk1LzhIakMxUzVveWNGTExhR1BheDdIQ2RSeW9y?=
 =?utf-8?B?SkU4TDhMRU1yMzRCcGJuZGEyZUdqTHNlaHoxVkNZU1hnaVVSZVJSVVVsczkr?=
 =?utf-8?B?QXRLTHFkeXVtVU9MS3N3bFVvTjk1dDUzVEJHMGY2M2ZqS2x3bkJvcVBuTUtX?=
 =?utf-8?B?NmdXUVN0Z3FPQ1pxcWcxOGZPMVhLY202cnIvRDFLeEVNdHBLM0k3bUp3VGxP?=
 =?utf-8?B?SU96bGtQd1d1RDc1Q0piRVVzNGUwenNvN2QrUkJ3azF4ekljSWJEL1N4Z0Fp?=
 =?utf-8?B?OW1IakhUb1VHQittNDlsSmpjajVmQVE5REpVV1diaE5qbVBDOTNZU3lYMGJF?=
 =?utf-8?B?d0dUUk1hT3lJOE1iSm9VTlhiemxZUEZSZ1RUbitaZnkxZS90Ykpzd05zUXFT?=
 =?utf-8?B?b2NUTEhrYWpmenlUaXhOODZRTFlBak9ld3BadVpmb09UZXVMWURCU1Y2ZDFR?=
 =?utf-8?B?SHM4YUNrTm01blI3MStvMkc3My96ckkvUTVLM2VPOWJENU5oU0dhdjY0dTZW?=
 =?utf-8?B?Q2ROQ28yNXNLMncyNkhSTUVLVjdxbUUrRkJaME5DYkZVYU9iU1JsYzF5NVV4?=
 =?utf-8?B?OTN5NnBEZFZXT3lpSEkwc0Y5Wm9FNUhhdVJQY1d0OUtzc0N5bTlBdnB3YUR5?=
 =?utf-8?B?dXUxOE1RUlMyUFVsVTRva1U3S2lyUGhkYnFMQlRrM1RESjF2T2l0U3BlZS9S?=
 =?utf-8?B?NGE5QmgwOThEV0hoWG9SeDBvUlplcG5VeFZPTkgxd0VCUW95SW5YbmhBV2Jr?=
 =?utf-8?B?MWpCWTNpeXF4WW5QbUFOVGwxZy9xZ2tkUm9WdTgxbXc4WTBmalhLMDhFSTc3?=
 =?utf-8?B?blpOSnhHOTdJTjhnbk9WbktZSWVMcDB0MmN1K2tpUFhyWTVndUlINCtHQVZv?=
 =?utf-8?B?WjhmVXZiS3BsbUx0YVNscDh4TG5waXJwcFY4V0RCOHR0ZE1rZllxRjVLV1dn?=
 =?utf-8?B?MlBxa2YzQTVtR1JPY0g4RmNvMkhWeitrNk8vdVcxUmpwSVlYTEY0YWd4c1Ri?=
 =?utf-8?B?QUlJYXNwbDJIaU1hZkdzQ3lrZEtaNzZ5MjJQM09uSTRKbXZkbEZrQzdiS3lU?=
 =?utf-8?B?WVVoRW5tTFRwb1lFSThNS3JLUGdpN0JWUW5MbjRJOWRKUDZ4cC8zSE14QkVF?=
 =?utf-8?B?OGdmYXZqQXkyVFlQUTJLYzJvT09BVVEwaVN1djNvTmR3Nm9DNm9YalFhMDNS?=
 =?utf-8?B?bzJVMjlTQzZFUVRnSmRidjZXTXVveVY4MGZSVzZiYXZuV0JmRlFSb2ZLaTZY?=
 =?utf-8?B?QTZqNjVHZ05IRGFZUGlYWThsN3NRdXU3NHlCZnF6Qzg1WSt3TVBuREk3ck9y?=
 =?utf-8?B?ckhsNnJhUE1LNzM3eWZ6cytBSzdRSGc2clpRMUd4a3Z2ZEVGWitGOVNmRHVs?=
 =?utf-8?B?ZFY4TzFxV1NNUUFOelNDK1BzV25QeTNKMTk5MzVUL3Y3UURMbTQrTlQrYjh1?=
 =?utf-8?B?MFdxM0IzWkZaTDBmOGY2elAxclQyNVNCek44RlU1RVZHWEU5S0x1QU1uRmVT?=
 =?utf-8?B?OVh5UzRYUVptdXRyQzNuVkFsajk1ZmJSLzUxdDBpS3U0RGQzL0hUbzNnZGg0?=
 =?utf-8?B?bkpTdEVpWklZQ2hOYm8vcnRKMGVjbnVxa1BFV244RkY2VlUyMmQ5ZGhkTzZz?=
 =?utf-8?B?Q1Y3MUx1M2xuMjFwaUZFOTRIMytzZDFNZE9oQ3FWVXNWeEFERld3K0d5L2ti?=
 =?utf-8?B?dkd3cUhvWW5zaWU2OFJCUVJPQzZCOHR6L0R5VGNnM1NTQ3kwdU90UFlzR2Z5?=
 =?utf-8?B?REM3VzcxS25rTnNoNm1XemtRemxkQUFPOEZPQU43WXE5anRLUWVzWjhlclhM?=
 =?utf-8?B?dG1FVTdYemMwbTR1ak85eHJFK2tNdmN3S1dHMjc5cUpPUW9CRkQrVDlOTmVE?=
 =?utf-8?B?NysvM1R2Nms1K05FUmNac0ZLeU5FUFoyN21uczByeXlncUxFY04wOXhvOWxW?=
 =?utf-8?B?RmtxRzBNRHgyT2VHUlNSbTd5YTFkMnFNMVBURHRhSURGM0FvVWZwemF0SHZp?=
 =?utf-8?Q?HLODGOrcJ5n//jF6Rtl0i0k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c4a82f-0d07-4754-8f7e-08d9b4150756
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 15:21:06.4203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqNsGoaYSu2COUrcSn2KC2VYyG31ukpGUo1OrYM1mnH/q1CblicaRO2BkAEdYMT4mznqHoA53wfNUM1UqQ+78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-30 09:53, Nicholas Kazlauskas wrote:
> [Why]
> PSR currently relies on the kernel's delayed vblank on/off mechanism
> as an implicit bufferring mechanism to prevent excessive entry/exit.
> 
> Without this delay the user experience is impacted since it can take
> a few frames to enter/exit.
> 
> [How]
> Only allow vblank disable immediate for DC when psr is not supported.
> 
> Leave a TODO indicating that this support should be extended in the
> future to delay independent of the vblank interrupt.
> 
> Fixes: 3d1508b73ff1 ("drm/amdgpu/display: set vblank_disable_immediate for DC")
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Now I'm curious whether vblank_disable_immediate or PSR
save more power.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0747dc7922c2..d582d44c02ad 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1599,9 +1599,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	adev_to_drm(adev)->mode_config.cursor_width = adev->dm.dc->caps.max_cursor_size;
>  	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
>  
> -	/* Disable vblank IRQs aggressively for power-saving */
> -	adev_to_drm(adev)->vblank_disable_immediate = true;
> -
>  	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
>  		DRM_ERROR(
>  		"amdgpu: failed to initialize sw for display support.\n");
> @@ -4264,6 +4261,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  
>  	}
>  
> +	/*
> +	 * Disable vblank IRQs aggressively for power-saving.
> +	 *
> +	 * TODO: Fix vblank control helpers to delay PSR entry to allow this when PSR
> +	 * is also supported.
> +	 */
> +	adev_to_drm(adev)->vblank_disable_immediate = !psr_feature_enabled;
> +
>  	/* Software is initialized. Now we can register interrupt handlers. */
>  	switch (adev->asic_type) {
>  #if defined(CONFIG_DRM_AMD_DC_SI)
> 

