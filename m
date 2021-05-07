Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F6C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E78E61006
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E78E61006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D7E6EE53;
	Fri,  7 May 2021 15:04:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D3E6EE51
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 15:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWnLP6xBl6I/XQPEHwpzxJCo7/bv7AEG+GVWLgD0LpQPIVYjJ5qiM58/Vz8OhFmgaqiyy7rcYiUcwniEPW8PvdYFHK8abMoli9PGj9tFnKkmNJnMTHcEuImUQWByYGSXGT6Rw72duOMH94HoWxA0A85dQgIJcQViV7EnKlibIZfZMTASIW65/RE3IhntcUlKjio9eBHuBnOQX0yg/OI92x7Zt9NhblRSwK56zba0CLHQReECRDLiGePkrm51A8Lu9qHs/cWl1ZDsIaNq/yHbD8PixV/YQWOrChHoCy/L5Dk0qa+iLRBVcUZ+2YOMq38pIo5uphW/FwsZd2Udsm61OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM/OMP+rS09UhYMNoveU6XDC9S4IMg6O98HVUKQ81Fc=;
 b=NkF7dGF3TKtYauwSyDK8WAX02zILtmPjbwWEWWeg5eAL3Kzf5hqs9Ms+DUPKBYeQ4fWzvLUHSSmpZ7ybZ1UuHw3POfcKNevPqywZfZscbRS7liCKdT4frV7kS7XXFj9xTA5kN76vRHqXaYX2rD6D88g0RRq+IklLGIWtQkE6iT4lWXziRdlHwPvrPaVwbx3hw9IwDbSNfVEN7/JCQjG2vIwmc4NGvQBbzsHIGrgsyiAuoSBWzgrDqruwENIQkbP/GoetQIn8xoooKAqKBakaDlqk3RyWUuIz9cjDRcauL8X0+WschBk1a2svYn/S++giVusAUDWs2SSebGNe7ZZN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM/OMP+rS09UhYMNoveU6XDC9S4IMg6O98HVUKQ81Fc=;
 b=4G06x870LaGsPi3/LrUG64B5IEyuruswS1fr1TEeG6GCol5co4IYxljNbbCnBDrm1IuPx3S7wJn54CkxT9KyQJ+6t+qZ4j5v9vWK8YpSDHy5beYYQLM+7fWqEbeIcKEfsKkaen8lGUa35kwx5yWzxHHLU0Z8Jfmgy5AvH3psBj8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 15:04:09 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::acf3:1432:d128:3565]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::acf3:1432:d128:3565%3]) with mapi id 15.20.4108.028; Fri, 7 May 2021
 15:04:09 +0000
Subject: Re: [PATCH] drm/amd/display: Move plane code from amdgpu_dm to
 amdgpu_dm_plane
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210507143942.1546281-1-Rodrigo.Siqueira@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <2c793be8-42a3-e148-2ab5-a9f2342d6c50@amd.com>
Date: Fri, 7 May 2021 11:04:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210507143942.1546281-1-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::22) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.16.155] (165.204.54.211) by
 YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Fri, 7 May 2021 15:04:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12cf4f8c-6ed2-4ff4-f52f-08d911695dec
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5431DA2DF9EF00429F6E477FEC579@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+7s4mu+ekOxH5CMdz9cYp2+FoJfHnJzCYHTJSTzwX/tJcMjzZKw4O2Oewl465zWlv8ldhx0xHqXfeb7rktwsK3FHI0r2lJkSO8a8zgeY6zA+gEiaMYGiAVCryKPrqY4nveRulv3N/cYqK3OYE5KEk5sSeD7Mq2rpR5uQwoxQlIZ7YZuo6BwJxuRe7zdrfh4w80sgf9TPLiR/l13/XIq2Wnkghb35qia2qIEM7b/tlVi/A/Fwa1RwPUQi+DsqWVnOKuneSDxcZPtt0PdG5xvCwTifC96V06D5TPbMoU0maGooejF+Ya4mYXNoOFNHCv8a5y1t5Jeq8PnlQCUj6k+PyLQ+ZzPDOWH4qP4wVEyiNMm6FeV3STYH28yg/LkNkNzXd2vQW6K+HNfiF5Es4fBi7GXdtQtoTgzoWsMimWtvWIgGnee8na7U5jEP+DAsfkC3d/820zjuCnja0ACnDipyv3ycyDK+b6rHChkBBNa39+u5ELiZKF6go1Zf11UUse/h71EGgMCZuBqMwA4hthHw2S9FH5vrzXDSWQlJK4imH7Ytsx2NlQVIj1+cU/L8xdlRWnrqnvkDfus3GRHTguyIxey70shZUhbWK8DHw83HbxAkT5ksVk15ag6DMhhlasVq+CxZIyQJzLjzpFbHS4vaDK9Wwlrdhe9qd4HDWD3bqdmUWvBbYInfbNFypTUT7WJ5679dfJ/XIABSwKc0w2/kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(4326008)(66476007)(66556008)(83380400001)(30864003)(38100700002)(5660300002)(26005)(6666004)(31696002)(66946007)(16526019)(8676002)(53546011)(186003)(31686004)(2906002)(36756003)(478600001)(316002)(16576012)(6486002)(2616005)(8936002)(86362001)(956004)(21314003)(43740500002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YVQ1bFZrK0NrN3hxV3AzVGNkcnlSaFhiT05YeWF5a0R4TTdPaUNrU1VlZ1lv?=
 =?utf-8?B?VmwyMFVsd2xsM2xLblRqc3ZIZUI5ZzBhU0xRVHNRTEp6enR3eEZmVHVSMll3?=
 =?utf-8?B?RzlMRDFVUHJpK0VRblFXNDF3c21QbUJuRXZrVmVhTko0MEpnTERxd0lCbzkw?=
 =?utf-8?B?c0prT3VwVW9CNmtpdUNmU1ZkYnh3a3ROY0dzZytrcXhHbmVPN3NMR2dzZE1B?=
 =?utf-8?B?RThPRkFuajV2VGVVcVBaOE9RZlFiU01DZ01aQkdGZTZ3ckYxeDM3MlJiM1Jx?=
 =?utf-8?B?eVpqY25FRURPK05jRzM4YXhsNVZyMWw1OFY1M1NEbXdhemNyNmZXR3Q5TDlB?=
 =?utf-8?B?Y29RYWRDcGFaczNxYnRXTm93bHprZEJ2L3ZHV1dCaXUxc3hlZUFNUWdBR0l1?=
 =?utf-8?B?STd4NXRVL3MwSVh1TUNoWlUzclE4K0V6RHNUc3FicHpzL01OeUhCWEdqSmFl?=
 =?utf-8?B?T2tiTWFENm0yMTJRcXcrSEJwNVR4Zk5BenRXT1dlVGhncGsvVkYwcEZ3czhu?=
 =?utf-8?B?aW03Vk1LeEU1R1lSc1RsQThvc09QeDZNREVJdUdZelptY0d1Y0FiZkZ6OWdh?=
 =?utf-8?B?a3pTb2RndFN2SWUrV0ZGbi8wVDFtTk5JZ0JBOGR6U2M4aUVZcmpUeEVEZ1F1?=
 =?utf-8?B?TUMvUUNKZlJIam9BRUtvcU1SUkc1V1owLzNjOGFLRGR3UlhXLy81RmRjcUU2?=
 =?utf-8?B?MVBjY29vdndGcVdYSk1LN3ZWZlJFbUczTjQrdHZSL1BaQnBjaVVRdnJWZkFK?=
 =?utf-8?B?ZzN3QXFzZDhFT21KZFN2cHVOUE5XNktCaXJhaDNQSVpUekFmZitiZVVXYzVz?=
 =?utf-8?B?RGpKY1M4UDVVMWRtdnJvVUwxYTh3Tk50U2sySWRaSGNCelQ5alYvSFZiV3di?=
 =?utf-8?B?M1dMMm1kZ01oa01jS0hkWGFob0dXVjBzT1c5VWp3Vm1SN3oreHV5RG44UFdM?=
 =?utf-8?B?R3VVQ0Iyb2lBd2M1eFcvQzRNOHhTeWZMSS9JeWlUQXl3am9vbm1WT2xlTno5?=
 =?utf-8?B?WFZTNlJLMXdRSU9ZbWdxQmtpeVBEeVRxVkJIMnlmM0c3YXFWUVU5a0sxR3V6?=
 =?utf-8?B?VnBoZEExSHZGdzYzNGlFSUtMcWM2UFRvMjdNR3VJSUxYTnlZQjkxQ1o0OXc4?=
 =?utf-8?B?SEhIaGFrajNXZ3NHYlBsc0hTa0dFZjgrdTcremsyVXp1SmhXZk9LQzVMSlZo?=
 =?utf-8?B?VWdZazRMVm80ckgxNHI3dit1MnpyL1ZvblBsRm5YQTBsUWNwUjRibHR6bnlz?=
 =?utf-8?B?VUcwUFpKZE9EeUJZZFRaOEJXYmdlcEZ3MVFHOSsyQXNjTDIxY3VFYVJXYlRF?=
 =?utf-8?B?MzBUSDNrQW14Q0FUN0VodzlSNmVLUHV0eWE3MVdxTmo1K2FUditWL1M3d2kr?=
 =?utf-8?B?dEhXRDJCalVBS2VwRGYxNHhUejJseVNPQytoZk1rL3RlVUtPZ2svdC8xbEZS?=
 =?utf-8?B?NzgxbFN5SXF6TURwVmdjUXBYL1pha3FTYVBOZFBJZWdNNkRPTy9qN1RnNjA2?=
 =?utf-8?B?SlloVitVcDVodHYyMFNwOWJEdGNKRHdiUkx0bkJ2MTZrSWpkOWNVWnpYUmsy?=
 =?utf-8?B?dm9CWmYvZFFCRmNMekNuRUJVV0RZSGxHWHVWbDBWaE5aNVl4UVFUSGFCajg2?=
 =?utf-8?B?SUt0eHJjWG1tTHlkb1pFKzJuQTdNcXkrY280U0tFdkc0NGkvUGZZdUNiUzBX?=
 =?utf-8?B?eTFzQTVpVWNucytyRU01MDZJbkVDcEF0cHVOZ2YrUmNjS3J0cWtlbWNGYmpl?=
 =?utf-8?Q?l7ts4rNLsMG7xZOyBU8B/obfE672U/5pVUHezLK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cf4f8c-6ed2-4ff4-f52f-08d911695dec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 15:04:09.7073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDxznMgAxIes5WEXXrwZHwG2jz8AS6ADOmc4uUBoc3oHlOQO8DQStnY3smf1gYZqwLX1E6hik9YUt64Du6zbJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
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
Cc: Bhawanpreet.Lakha@amd.com, Harry Wentland <harry.wentland@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-05-07 10:39 a.m., Rodrigo Siqueira wrote:
> The amdgpu_dm file contains most of the code that works as an interface
> between DRM API and Display Core. We maintain all the plane operations
> inside amdgpu_dm; this commit extracts the plane code to its specific
> file named amdgpu_dm_plane. This commit does not introduce any
> functional change to the functions; it only changes some static
> functions to global and adds some minor adjustments related to the copy
> from one place to another.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/Makefile    |    9 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1479 +---------------
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 1496 +++++++++++++++++
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   56 +
>   4 files changed, 1559 insertions(+), 1481 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>   create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
> index 9a3b7bf8ab0b..6542ef0ff83e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
> @@ -23,9 +23,12 @@
>   # Makefile for the 'dm' sub-component of DAL.
>   # It provides the control and status of dm blocks.
>   
> -
> -
> -AMDGPUDM = amdgpu_dm.o amdgpu_dm_irq.o amdgpu_dm_mst_types.o amdgpu_dm_color.o
> +AMDGPUDM := \
> +	amdgpu_dm.o \
> +	amdgpu_dm_color.o \
> +	amdgpu_dm_irq.o \
> +	amdgpu_dm_mst_types.o \
> +	amdgpu_dm_plane.o
>   
>   ifneq ($(CONFIG_DRM_AMD_DC),)
>   AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index cc048c348a92..60ddb4d8be6c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -44,6 +44,7 @@
>   #include "amdgpu_ucode.h"
>   #include "atom.h"
>   #include "amdgpu_dm.h"
> +#include "amdgpu_dm_plane.h"
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
>   #include "amdgpu_dm_hdcp.h"
>   #include <drm/drm_hdcp.h>
> @@ -181,10 +182,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev);
>   /* removes and deallocates the drm structures, created by the above function */
>   static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm);
>   
> -static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
> -				struct drm_plane *plane,
> -				unsigned long possible_crtcs,
> -				const struct dc_plane_cap *plane_cap);
>   static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
>   			       struct drm_plane *plane,
>   			       uint32_t link_index);
> @@ -203,9 +200,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
>   static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   				  struct drm_atomic_state *state);
>   
> -static void handle_cursor_update(struct drm_plane *plane,
> -				 struct drm_plane_state *old_plane_state);
> -
>   static void amdgpu_dm_set_psr_caps(struct dc_link *link);
>   static bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);
>   static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
> @@ -4125,925 +4119,12 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
>   	.destroy = amdgpu_dm_encoder_destroy,
>   };
>   
> -
> -static void get_min_max_dc_plane_scaling(struct drm_device *dev,
> -					 struct drm_framebuffer *fb,
> -					 int *min_downscale, int *max_upscale)
> -{
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> -	struct dc *dc = adev->dm.dc;
> -	/* Caps for all supported planes are the same on DCE and DCN 1 - 3 */
> -	struct dc_plane_cap *plane_cap = &dc->caps.planes[0];
> -
> -	switch (fb->format->format) {
> -	case DRM_FORMAT_P010:
> -	case DRM_FORMAT_NV12:
> -	case DRM_FORMAT_NV21:
> -		*max_upscale = plane_cap->max_upscale_factor.nv12;
> -		*min_downscale = plane_cap->max_downscale_factor.nv12;
> -		break;
> -
> -	case DRM_FORMAT_XRGB16161616F:
> -	case DRM_FORMAT_ARGB16161616F:
> -	case DRM_FORMAT_XBGR16161616F:
> -	case DRM_FORMAT_ABGR16161616F:
> -		*max_upscale = plane_cap->max_upscale_factor.fp16;
> -		*min_downscale = plane_cap->max_downscale_factor.fp16;
> -		break;
> -
> -	default:
> -		*max_upscale = plane_cap->max_upscale_factor.argb8888;
> -		*min_downscale = plane_cap->max_downscale_factor.argb8888;
> -		break;
> -	}
> -
> -	/*
> -	 * A factor of 1 in the plane_cap means to not allow scaling, ie. use a
> -	 * scaling factor of 1.0 == 1000 units.
> -	 */
> -	if (*max_upscale == 1)
> -		*max_upscale = 1000;
> -
> -	if (*min_downscale == 1)
> -		*min_downscale = 1000;
> -}
> -
> -
> -static int fill_dc_scaling_info(const struct drm_plane_state *state,
> -				struct dc_scaling_info *scaling_info)
> -{
> -	int scale_w, scale_h, min_downscale, max_upscale;
> -
> -	memset(scaling_info, 0, sizeof(*scaling_info));
> -
> -	/* Source is fixed 16.16 but we ignore mantissa for now... */
> -	scaling_info->src_rect.x = state->src_x >> 16;
> -	scaling_info->src_rect.y = state->src_y >> 16;
> -
> -	/*
> -	 * For reasons we don't (yet) fully understand a non-zero
> -	 * src_y coordinate into an NV12 buffer can cause a
> -	 * system hang. To avoid hangs (and maybe be overly cautious)
> -	 * let's reject both non-zero src_x and src_y.
> -	 *
> -	 * We currently know of only one use-case to reproduce a
> -	 * scenario with non-zero src_x and src_y for NV12, which
> -	 * is to gesture the YouTube Android app into full screen
> -	 * on ChromeOS.
> -	 */
> -	if (state->fb &&
> -	    state->fb->format->format == DRM_FORMAT_NV12 &&
> -	    (scaling_info->src_rect.x != 0 ||
> -	     scaling_info->src_rect.y != 0))
> -		return -EINVAL;
> -
> -	scaling_info->src_rect.width = state->src_w >> 16;
> -	if (scaling_info->src_rect.width == 0)
> -		return -EINVAL;
> -
> -	scaling_info->src_rect.height = state->src_h >> 16;
> -	if (scaling_info->src_rect.height == 0)
> -		return -EINVAL;
> -
> -	scaling_info->dst_rect.x = state->crtc_x;
> -	scaling_info->dst_rect.y = state->crtc_y;
> -
> -	if (state->crtc_w == 0)
> -		return -EINVAL;
> -
> -	scaling_info->dst_rect.width = state->crtc_w;
> -
> -	if (state->crtc_h == 0)
> -		return -EINVAL;
> -
> -	scaling_info->dst_rect.height = state->crtc_h;
> -
> -	/* DRM doesn't specify clipping on destination output. */
> -	scaling_info->clip_rect = scaling_info->dst_rect;
> -
> -	/* Validate scaling per-format with DC plane caps */
> -	if (state->plane && state->plane->dev && state->fb) {
> -		get_min_max_dc_plane_scaling(state->plane->dev, state->fb,
> -					     &min_downscale, &max_upscale);
> -	} else {
> -		min_downscale = 250;
> -		max_upscale = 16000;
> -	}
> -
> -	scale_w = scaling_info->dst_rect.width * 1000 /
> -		  scaling_info->src_rect.width;
> -
> -	if (scale_w < min_downscale || scale_w > max_upscale)
> -		return -EINVAL;
> -
> -	scale_h = scaling_info->dst_rect.height * 1000 /
> -		  scaling_info->src_rect.height;
> -
> -	if (scale_h < min_downscale || scale_h > max_upscale)
> -		return -EINVAL;
> -
> -	/*
> -	 * The "scaling_quality" can be ignored for now, quality = 0 has DC
> -	 * assume reasonable defaults based on the format.
> -	 */
> -
> -	return 0;
> -}
> -
> -static void
> -fill_gfx8_tiling_info_from_flags(union dc_tiling_info *tiling_info,
> -				 uint64_t tiling_flags)
> -{
> -	/* Fill GFX8 params */
> -	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
> -		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
> -
> -		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
> -		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
> -		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
> -		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
> -		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
> -
> -		/* XXX fix me for VI */
> -		tiling_info->gfx8.num_banks = num_banks;
> -		tiling_info->gfx8.array_mode =
> -				DC_ARRAY_2D_TILED_THIN1;
> -		tiling_info->gfx8.tile_split = tile_split;
> -		tiling_info->gfx8.bank_width = bankw;
> -		tiling_info->gfx8.bank_height = bankh;
> -		tiling_info->gfx8.tile_aspect = mtaspect;
> -		tiling_info->gfx8.tile_mode =
> -				DC_ADDR_SURF_MICRO_TILING_DISPLAY;
> -	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE)
> -			== DC_ARRAY_1D_TILED_THIN1) {
> -		tiling_info->gfx8.array_mode = DC_ARRAY_1D_TILED_THIN1;
> -	}
> -
> -	tiling_info->gfx8.pipe_config =
> -			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
> -}
> -
> -static void
> -fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
> -				  union dc_tiling_info *tiling_info)
> -{
> -	tiling_info->gfx9.num_pipes =
> -		adev->gfx.config.gb_addr_config_fields.num_pipes;
> -	tiling_info->gfx9.num_banks =
> -		adev->gfx.config.gb_addr_config_fields.num_banks;
> -	tiling_info->gfx9.pipe_interleave =
> -		adev->gfx.config.gb_addr_config_fields.pipe_interleave_size;
> -	tiling_info->gfx9.num_shader_engines =
> -		adev->gfx.config.gb_addr_config_fields.num_se;
> -	tiling_info->gfx9.max_compressed_frags =
> -		adev->gfx.config.gb_addr_config_fields.max_compress_frags;
> -	tiling_info->gfx9.num_rb_per_se =
> -		adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
> -	tiling_info->gfx9.shaderEnable = 1;
> -	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> -	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
> -	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
> -	    adev->asic_type == CHIP_VANGOGH)
> -		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
> -}
> -
> -static int
> -validate_dcc(struct amdgpu_device *adev,
> -	     const enum surface_pixel_format format,
> -	     const enum dc_rotation_angle rotation,
> -	     const union dc_tiling_info *tiling_info,
> -	     const struct dc_plane_dcc_param *dcc,
> -	     const struct dc_plane_address *address,
> -	     const struct plane_size *plane_size)
> -{
> -	struct dc *dc = adev->dm.dc;
> -	struct dc_dcc_surface_param input;
> -	struct dc_surface_dcc_cap output;
> -
> -	memset(&input, 0, sizeof(input));
> -	memset(&output, 0, sizeof(output));
> -
> -	if (!dcc->enable)
> -		return 0;
> -
> -	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
> -	    !dc->cap_funcs.get_dcc_compression_cap)
> -		return -EINVAL;
> -
> -	input.format = format;
> -	input.surface_size.width = plane_size->surface_size.width;
> -	input.surface_size.height = plane_size->surface_size.height;
> -	input.swizzle_mode = tiling_info->gfx9.swizzle;
> -
> -	if (rotation == ROTATION_ANGLE_0 || rotation == ROTATION_ANGLE_180)
> -		input.scan = SCAN_DIRECTION_HORIZONTAL;
> -	else if (rotation == ROTATION_ANGLE_90 || rotation == ROTATION_ANGLE_270)
> -		input.scan = SCAN_DIRECTION_VERTICAL;
> -
> -	if (!dc->cap_funcs.get_dcc_compression_cap(dc, &input, &output))
> -		return -EINVAL;
> -
> -	if (!output.capable)
> -		return -EINVAL;
> -
> -	if (dcc->independent_64b_blks == 0 &&
> -	    output.grph.rgb.independent_64b_blks != 0)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static bool
> -modifier_has_dcc(uint64_t modifier)
> -{
> -	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
> -}
> -
> -static unsigned
> -modifier_gfx9_swizzle_mode(uint64_t modifier)
> -{
> -	if (modifier == DRM_FORMAT_MOD_LINEAR)
> -		return 0;
> -
> -	return AMD_FMT_MOD_GET(TILE, modifier);
> -}
> -
>   static const struct drm_format_info *
>   amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
>   {
>   	return amdgpu_lookup_format_info(cmd->pixel_format, cmd->modifier[0]);
>   }
>   
> -static void
> -fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
> -				    union dc_tiling_info *tiling_info,
> -				    uint64_t modifier)
> -{
> -	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
> -	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
> -	unsigned int pkrs_log2 = AMD_FMT_MOD_GET(PACKERS, modifier);
> -	unsigned int pipes_log2 = min(4u, mod_pipe_xor_bits);
> -
> -	fill_gfx9_tiling_info_from_device(adev, tiling_info);
> -
> -	if (!IS_AMD_FMT_MOD(modifier))
> -		return;
> -
> -	tiling_info->gfx9.num_pipes = 1u << pipes_log2;
> -	tiling_info->gfx9.num_shader_engines = 1u << (mod_pipe_xor_bits - pipes_log2);
> -
> -	if (adev->family >= AMDGPU_FAMILY_NV) {
> -		tiling_info->gfx9.num_pkrs = 1u << pkrs_log2;
> -	} else {
> -		tiling_info->gfx9.num_banks = 1u << mod_bank_xor_bits;
> -
> -		/* for DCC we know it isn't rb aligned, so rb_per_se doesn't matter. */
> -	}
> -}
> -
> -enum dm_micro_swizzle {
> -	MICRO_SWIZZLE_Z = 0,
> -	MICRO_SWIZZLE_S = 1,
> -	MICRO_SWIZZLE_D = 2,
> -	MICRO_SWIZZLE_R = 3
> -};
> -
> -static bool dm_plane_format_mod_supported(struct drm_plane *plane,
> -					  uint32_t format,
> -					  uint64_t modifier)
> -{
> -	struct amdgpu_device *adev = drm_to_adev(plane->dev);
> -	const struct drm_format_info *info = drm_format_info(format);
> -	int i;
> -
> -	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
> -
> -	if (!info)
> -		return false;
> -
> -	/*
> -	 * We always have to allow these modifiers:
> -	 * 1. Core DRM checks for LINEAR support if userspace does not provide modifiers.
> -	 * 2. Not passing any modifiers is the same as explicitly passing INVALID.
> -	 */
> -	if (modifier == DRM_FORMAT_MOD_LINEAR ||
> -	    modifier == DRM_FORMAT_MOD_INVALID) {
> -		return true;
> -	}
> -
> -	/* Check that the modifier is on the list of the plane's supported modifiers. */
> -	for (i = 0; i < plane->modifier_count; i++) {
> -		if (modifier == plane->modifiers[i])
> -			break;
> -	}
> -	if (i == plane->modifier_count)
> -		return false;
> -
> -	/*
> -	 * For D swizzle the canonical modifier depends on the bpp, so check
> -	 * it here.
> -	 */
> -	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX9 &&
> -	    adev->family >= AMDGPU_FAMILY_NV) {
> -		if (microtile == MICRO_SWIZZLE_D && info->cpp[0] == 4)
> -			return false;
> -	}
> -
> -	if (adev->family >= AMDGPU_FAMILY_RV && microtile == MICRO_SWIZZLE_D &&
> -	    info->cpp[0] < 8)
> -		return false;
> -
> -	if (modifier_has_dcc(modifier)) {
> -		/* Per radeonsi comments 16/64 bpp are more complicated. */
> -		if (info->cpp[0] != 4)
> -			return false;
> -		/* We support multi-planar formats, but not when combined with
> -		 * additional DCC metadata planes. */
> -		if (info->num_planes > 1)
> -			return false;
> -	}
> -
> -	return true;
> -}
> -
> -static void
> -add_modifier(uint64_t **mods, uint64_t *size, uint64_t *cap, uint64_t mod)
> -{
> -	if (!*mods)
> -		return;
> -
> -	if (*cap - *size < 1) {
> -		uint64_t new_cap = *cap * 2;
> -		uint64_t *new_mods = kmalloc(new_cap * sizeof(uint64_t), GFP_KERNEL);
> -
> -		if (!new_mods) {
> -			kfree(*mods);
> -			*mods = NULL;
> -			return;
> -		}
> -
> -		memcpy(new_mods, *mods, sizeof(uint64_t) * *size);
> -		kfree(*mods);
> -		*mods = new_mods;
> -		*cap = new_cap;
> -	}
> -
> -	(*mods)[*size] = mod;
> -	*size += 1;
> -}
> -
> -static void
> -add_gfx9_modifiers(const struct amdgpu_device *adev,
> -		   uint64_t **mods, uint64_t *size, uint64_t *capacity)
> -{
> -	int pipes = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
> -	int pipe_xor_bits = min(8, pipes +
> -				ilog2(adev->gfx.config.gb_addr_config_fields.num_se));
> -	int bank_xor_bits = min(8 - pipe_xor_bits,
> -				ilog2(adev->gfx.config.gb_addr_config_fields.num_banks));
> -	int rb = ilog2(adev->gfx.config.gb_addr_config_fields.num_se) +
> -		 ilog2(adev->gfx.config.gb_addr_config_fields.num_rb_per_se);
> -
> -
> -	if (adev->family == AMDGPU_FAMILY_RV) {
> -		/* Raven2 and later */
> -		bool has_constant_encode = adev->asic_type > CHIP_RAVEN || adev->external_rev_id >= 0x81;
> -
> -		/*
> -		 * No _D DCC swizzles yet because we only allow 32bpp, which
> -		 * doesn't support _D on DCN
> -		 */
> -
> -		if (has_constant_encode) {
> -			add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> -				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> -				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> -				    AMD_FMT_MOD_SET(DCC, 1) |
> -				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> -				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> -				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1));
> -		}
> -
> -		add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> -			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> -			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> -			    AMD_FMT_MOD_SET(DCC, 1) |
> -			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> -			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> -			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0));
> -
> -		if (has_constant_encode) {
> -			add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> -				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> -				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> -				    AMD_FMT_MOD_SET(DCC, 1) |
> -				    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> -				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> -				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> -
> -				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> -				    AMD_FMT_MOD_SET(RB, rb) |
> -				    AMD_FMT_MOD_SET(PIPE, pipes));
> -		}
> -
> -		add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> -			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> -			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> -			    AMD_FMT_MOD_SET(DCC, 1) |
> -			    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> -			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> -			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> -			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0) |
> -			    AMD_FMT_MOD_SET(RB, rb) |
> -			    AMD_FMT_MOD_SET(PIPE, pipes));
> -	}
> -
> -	/*
> -	 * Only supported for 64bpp on Raven, will be filtered on format in
> -	 * dm_plane_format_mod_supported.
> -	 */
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D_X) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> -		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -		    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
> -
> -	if (adev->family == AMDGPU_FAMILY_RV) {
> -		add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> -			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> -			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
> -	}
> -
> -	/*
> -	 * Only supported for 64bpp on Raven, will be filtered on format in
> -	 * dm_plane_format_mod_supported.
> -	 */
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> -
> -	if (adev->family == AMDGPU_FAMILY_RV) {
> -		add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
> -			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> -	}
> -}
> -
> -static void
> -add_gfx10_1_modifiers(const struct amdgpu_device *adev,
> -		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
> -{
> -	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
> -
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> -		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -		    AMD_FMT_MOD_SET(DCC, 1) |
> -		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> -		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> -		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> -
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> -		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -		    AMD_FMT_MOD_SET(DCC, 1) |
> -		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> -		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> -		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> -		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> -
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> -		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
> -
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> -		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
> -
> -
> -	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> -
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> -}
> -
> -static void
> -add_gfx10_3_modifiers(const struct amdgpu_device *adev,
> -		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
> -{
> -	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
> -	int pkrs = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
> -
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> -		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
> -		    AMD_FMT_MOD_SET(DCC, 1) |
> -		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> -		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> -		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> -		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> -
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> -		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
> -		    AMD_FMT_MOD_SET(DCC, 1) |
> -		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> -		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> -		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> -		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> -		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> -
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> -		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -		    AMD_FMT_MOD_SET(PACKERS, pkrs));
> -
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> -		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> -		    AMD_FMT_MOD_SET(PACKERS, pkrs));
> -
> -	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> -
> -	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> -		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
> -		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> -}
> -
> -static int
> -get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
> -{
> -	uint64_t size = 0, capacity = 128;
> -	*mods = NULL;
> -
> -	/* We have not hooked up any pre-GFX9 modifiers. */
> -	if (adev->family < AMDGPU_FAMILY_AI)
> -		return 0;
> -
> -	*mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
> -
> -	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
> -		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
> -		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
> -		return *mods ? 0 : -ENOMEM;
> -	}
> -
> -	switch (adev->family) {
> -	case AMDGPU_FAMILY_AI:
> -	case AMDGPU_FAMILY_RV:
> -		add_gfx9_modifiers(adev, mods, &size, &capacity);
> -		break;
> -	case AMDGPU_FAMILY_NV:
> -	case AMDGPU_FAMILY_VGH:
> -		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
> -			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
> -		else
> -			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
> -		break;
> -	}
> -
> -	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
> -
> -	/* INVALID marks the end of the list. */
> -	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
> -
> -	if (!*mods)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
> -static int
> -fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
> -					  const struct amdgpu_framebuffer *afb,
> -					  const enum surface_pixel_format format,
> -					  const enum dc_rotation_angle rotation,
> -					  const struct plane_size *plane_size,
> -					  union dc_tiling_info *tiling_info,
> -					  struct dc_plane_dcc_param *dcc,
> -					  struct dc_plane_address *address,
> -					  const bool force_disable_dcc)
> -{
> -	const uint64_t modifier = afb->base.modifier;
> -	int ret;
> -
> -	fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
> -	tiling_info->gfx9.swizzle = modifier_gfx9_swizzle_mode(modifier);
> -
> -	if (modifier_has_dcc(modifier) && !force_disable_dcc) {
> -		uint64_t dcc_address = afb->address + afb->base.offsets[1];
> -
> -		dcc->enable = 1;
> -		dcc->meta_pitch = afb->base.pitches[1];
> -		dcc->independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
> -
> -		address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
> -		address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
> -	}
> -
> -	ret = validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static int
> -fill_plane_buffer_attributes(struct amdgpu_device *adev,
> -			     const struct amdgpu_framebuffer *afb,
> -			     const enum surface_pixel_format format,
> -			     const enum dc_rotation_angle rotation,
> -			     const uint64_t tiling_flags,
> -			     union dc_tiling_info *tiling_info,
> -			     struct plane_size *plane_size,
> -			     struct dc_plane_dcc_param *dcc,
> -			     struct dc_plane_address *address,
> -			     bool tmz_surface,
> -			     bool force_disable_dcc)
> -{
> -	const struct drm_framebuffer *fb = &afb->base;
> -	int ret;
> -
> -	memset(tiling_info, 0, sizeof(*tiling_info));
> -	memset(plane_size, 0, sizeof(*plane_size));
> -	memset(dcc, 0, sizeof(*dcc));
> -	memset(address, 0, sizeof(*address));
> -
> -	address->tmz_surface = tmz_surface;
> -
> -	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN) {
> -		uint64_t addr = afb->address + fb->offsets[0];
> -
> -		plane_size->surface_size.x = 0;
> -		plane_size->surface_size.y = 0;
> -		plane_size->surface_size.width = fb->width;
> -		plane_size->surface_size.height = fb->height;
> -		plane_size->surface_pitch =
> -			fb->pitches[0] / fb->format->cpp[0];
> -
> -		address->type = PLN_ADDR_TYPE_GRAPHICS;
> -		address->grph.addr.low_part = lower_32_bits(addr);
> -		address->grph.addr.high_part = upper_32_bits(addr);
> -	} else if (format < SURFACE_PIXEL_FORMAT_INVALID) {
> -		uint64_t luma_addr = afb->address + fb->offsets[0];
> -		uint64_t chroma_addr = afb->address + fb->offsets[1];
> -
> -		plane_size->surface_size.x = 0;
> -		plane_size->surface_size.y = 0;
> -		plane_size->surface_size.width = fb->width;
> -		plane_size->surface_size.height = fb->height;
> -		plane_size->surface_pitch =
> -			fb->pitches[0] / fb->format->cpp[0];
> -
> -		plane_size->chroma_size.x = 0;
> -		plane_size->chroma_size.y = 0;
> -		/* TODO: set these based on surface format */
> -		plane_size->chroma_size.width = fb->width / 2;
> -		plane_size->chroma_size.height = fb->height / 2;
> -
> -		plane_size->chroma_pitch =
> -			fb->pitches[1] / fb->format->cpp[1];
> -
> -		address->type = PLN_ADDR_TYPE_VIDEO_PROGRESSIVE;
> -		address->video_progressive.luma_addr.low_part =
> -			lower_32_bits(luma_addr);
> -		address->video_progressive.luma_addr.high_part =
> -			upper_32_bits(luma_addr);
> -		address->video_progressive.chroma_addr.low_part =
> -			lower_32_bits(chroma_addr);
> -		address->video_progressive.chroma_addr.high_part =
> -			upper_32_bits(chroma_addr);
> -	}
> -
> -	if (adev->family >= AMDGPU_FAMILY_AI) {
> -		ret = fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
> -								rotation, plane_size,
> -								tiling_info, dcc,
> -								address,
> -								force_disable_dcc);
> -		if (ret)
> -			return ret;
> -	} else {
> -		fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
> -	}
> -
> -	return 0;
> -}
> -
> -static void
> -fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
> -			       bool *per_pixel_alpha, bool *global_alpha,
> -			       int *global_alpha_value)
> -{
> -	*per_pixel_alpha = false;
> -	*global_alpha = false;
> -	*global_alpha_value = 0xff;
> -
> -	if (plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY)
> -		return;
> -
> -	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI) {
> -		static const uint32_t alpha_formats[] = {
> -			DRM_FORMAT_ARGB8888,
> -			DRM_FORMAT_RGBA8888,
> -			DRM_FORMAT_ABGR8888,
> -		};
> -		uint32_t format = plane_state->fb->format->format;
> -		unsigned int i;
> -
> -		for (i = 0; i < ARRAY_SIZE(alpha_formats); ++i) {
> -			if (format == alpha_formats[i]) {
> -				*per_pixel_alpha = true;
> -				break;
> -			}
> -		}
> -	}
> -
> -	if (plane_state->alpha < 0xffff) {
> -		*global_alpha = true;
> -		*global_alpha_value = plane_state->alpha >> 8;
> -	}
> -}
> -
> -static int
> -fill_plane_color_attributes(const struct drm_plane_state *plane_state,
> -			    const enum surface_pixel_format format,
> -			    enum dc_color_space *color_space)
> -{
> -	bool full_range;
> -
> -	*color_space = COLOR_SPACE_SRGB;
> -
> -	/* DRM color properties only affect non-RGB formats. */
> -	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
> -		return 0;
> -
> -	full_range = (plane_state->color_range == DRM_COLOR_YCBCR_FULL_RANGE);
> -
> -	switch (plane_state->color_encoding) {
> -	case DRM_COLOR_YCBCR_BT601:
> -		if (full_range)
> -			*color_space = COLOR_SPACE_YCBCR601;
> -		else
> -			*color_space = COLOR_SPACE_YCBCR601_LIMITED;
> -		break;
> -
> -	case DRM_COLOR_YCBCR_BT709:
> -		if (full_range)
> -			*color_space = COLOR_SPACE_YCBCR709;
> -		else
> -			*color_space = COLOR_SPACE_YCBCR709_LIMITED;
> -		break;
> -
> -	case DRM_COLOR_YCBCR_BT2020:
> -		if (full_range)
> -			*color_space = COLOR_SPACE_2020_YCBCR;
> -		else
> -			return -EINVAL;
> -		break;
> -
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int
> -fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
> -			    const struct drm_plane_state *plane_state,
> -			    const uint64_t tiling_flags,
> -			    struct dc_plane_info *plane_info,
> -			    struct dc_plane_address *address,
> -			    bool tmz_surface,
> -			    bool force_disable_dcc)
> -{
> -	const struct drm_framebuffer *fb = plane_state->fb;
> -	const struct amdgpu_framebuffer *afb =
> -		to_amdgpu_framebuffer(plane_state->fb);
> -	int ret;
> -
> -	memset(plane_info, 0, sizeof(*plane_info));
> -
> -	switch (fb->format->format) {
> -	case DRM_FORMAT_C8:
> -		plane_info->format =
> -			SURFACE_PIXEL_FORMAT_GRPH_PALETA_256_COLORS;
> -		break;
> -	case DRM_FORMAT_RGB565:
> -		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_RGB565;
> -		break;
> -	case DRM_FORMAT_XRGB8888:
> -	case DRM_FORMAT_ARGB8888:
> -		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
> -		break;
> -	case DRM_FORMAT_XRGB2101010:
> -	case DRM_FORMAT_ARGB2101010:
> -		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010;
> -		break;
> -	case DRM_FORMAT_XBGR2101010:
> -	case DRM_FORMAT_ABGR2101010:
> -		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010;
> -		break;
> -	case DRM_FORMAT_XBGR8888:
> -	case DRM_FORMAT_ABGR8888:
> -		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR8888;
> -		break;
> -	case DRM_FORMAT_NV21:
> -		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr;
> -		break;
> -	case DRM_FORMAT_NV12:
> -		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb;
> -		break;
> -	case DRM_FORMAT_P010:
> -		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb;
> -		break;
> -	case DRM_FORMAT_XRGB16161616F:
> -	case DRM_FORMAT_ARGB16161616F:
> -		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F;
> -		break;
> -	case DRM_FORMAT_XBGR16161616F:
> -	case DRM_FORMAT_ABGR16161616F:
> -		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F;
> -		break;
> -	default:
> -		DRM_ERROR(
> -			"Unsupported screen format %p4cc\n",
> -			&fb->format->format);
> -		return -EINVAL;
> -	}
> -
> -	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
> -	case DRM_MODE_ROTATE_0:
> -		plane_info->rotation = ROTATION_ANGLE_0;
> -		break;
> -	case DRM_MODE_ROTATE_90:
> -		plane_info->rotation = ROTATION_ANGLE_90;
> -		break;
> -	case DRM_MODE_ROTATE_180:
> -		plane_info->rotation = ROTATION_ANGLE_180;
> -		break;
> -	case DRM_MODE_ROTATE_270:
> -		plane_info->rotation = ROTATION_ANGLE_270;
> -		break;
> -	default:
> -		plane_info->rotation = ROTATION_ANGLE_0;
> -		break;
> -	}
> -
> -	plane_info->visible = true;
> -	plane_info->stereo_format = PLANE_STEREO_FORMAT_NONE;
> -
> -	plane_info->layer_index = 0;
> -
> -	ret = fill_plane_color_attributes(plane_state, plane_info->format,
> -					  &plane_info->color_space);
> -	if (ret)
> -		return ret;
> -
> -	ret = fill_plane_buffer_attributes(adev, afb, plane_info->format,
> -					   plane_info->rotation, tiling_flags,
> -					   &plane_info->tiling_info,
> -					   &plane_info->plane_size,
> -					   &plane_info->dcc, address, tmz_surface,
> -					   force_disable_dcc);
> -	if (ret)
> -		return ret;
> -
> -	fill_blending_from_plane_state(
> -		plane_state, &plane_info->per_pixel_alpha,
> -		&plane_info->global_alpha, &plane_info->global_alpha_value);
> -
> -	return 0;
> -}
> -
>   static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>   				    struct dc_plane_state *dc_plane_state,
>   				    struct drm_plane_state *plane_state,
> @@ -6816,456 +5897,6 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
>   }
>   #endif
>   
> -static void dm_drm_plane_reset(struct drm_plane *plane)
> -{
> -	struct dm_plane_state *amdgpu_state = NULL;
> -
> -	if (plane->state)
> -		plane->funcs->atomic_destroy_state(plane, plane->state);
> -
> -	amdgpu_state = kzalloc(sizeof(*amdgpu_state), GFP_KERNEL);
> -	WARN_ON(amdgpu_state == NULL);
> -
> -	if (amdgpu_state)
> -		__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
> -}
> -
> -static struct drm_plane_state *
> -dm_drm_plane_duplicate_state(struct drm_plane *plane)
> -{
> -	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
> -
> -	old_dm_plane_state = to_dm_plane_state(plane->state);
> -	dm_plane_state = kzalloc(sizeof(*dm_plane_state), GFP_KERNEL);
> -	if (!dm_plane_state)
> -		return NULL;
> -
> -	__drm_atomic_helper_plane_duplicate_state(plane, &dm_plane_state->base);
> -
> -	if (old_dm_plane_state->dc_state) {
> -		dm_plane_state->dc_state = old_dm_plane_state->dc_state;
> -		dc_plane_state_retain(dm_plane_state->dc_state);
> -	}
> -
> -	return &dm_plane_state->base;
> -}
> -
> -static void dm_drm_plane_destroy_state(struct drm_plane *plane,
> -				struct drm_plane_state *state)
> -{
> -	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
> -
> -	if (dm_plane_state->dc_state)
> -		dc_plane_state_release(dm_plane_state->dc_state);
> -
> -	drm_atomic_helper_plane_destroy_state(plane, state);
> -}
> -
> -static const struct drm_plane_funcs dm_plane_funcs = {
> -	.update_plane	= drm_atomic_helper_update_plane,
> -	.disable_plane	= drm_atomic_helper_disable_plane,
> -	.destroy	= drm_primary_helper_destroy,
> -	.reset = dm_drm_plane_reset,
> -	.atomic_duplicate_state = dm_drm_plane_duplicate_state,
> -	.atomic_destroy_state = dm_drm_plane_destroy_state,
> -	.format_mod_supported = dm_plane_format_mod_supported,
> -};
> -
> -static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
> -				      struct drm_plane_state *new_state)
> -{
> -	struct amdgpu_framebuffer *afb;
> -	struct drm_gem_object *obj;
> -	struct amdgpu_device *adev;
> -	struct amdgpu_bo *rbo;
> -	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
> -	struct list_head list;
> -	struct ttm_validate_buffer tv;
> -	struct ww_acquire_ctx ticket;
> -	uint32_t domain;
> -	int r;
> -
> -	if (!new_state->fb) {
> -		DRM_DEBUG_KMS("No FB bound\n");
> -		return 0;
> -	}
> -
> -	afb = to_amdgpu_framebuffer(new_state->fb);
> -	obj = new_state->fb->obj[0];
> -	rbo = gem_to_amdgpu_bo(obj);
> -	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
> -	INIT_LIST_HEAD(&list);
> -
> -	tv.bo = &rbo->tbo;
> -	tv.num_shared = 1;
> -	list_add(&tv.head, &list);
> -
> -	r = ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
> -	if (r) {
> -		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
> -		return r;
> -	}
> -
> -	if (plane->type != DRM_PLANE_TYPE_CURSOR)
> -		domain = amdgpu_display_supported_domains(adev, rbo->flags);
> -	else
> -		domain = AMDGPU_GEM_DOMAIN_VRAM;
> -
> -	r = amdgpu_bo_pin(rbo, domain);
> -	if (unlikely(r != 0)) {
> -		if (r != -ERESTARTSYS)
> -			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
> -		ttm_eu_backoff_reservation(&ticket, &list);
> -		return r;
> -	}
> -
> -	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
> -	if (unlikely(r != 0)) {
> -		amdgpu_bo_unpin(rbo);
> -		ttm_eu_backoff_reservation(&ticket, &list);
> -		DRM_ERROR("%p bind failed\n", rbo);
> -		return r;
> -	}
> -
> -	ttm_eu_backoff_reservation(&ticket, &list);
> -
> -	afb->address = amdgpu_bo_gpu_offset(rbo);
> -
> -	amdgpu_bo_ref(rbo);
> -
> -	/**
> -	 * We don't do surface updates on planes that have been newly created,
> -	 * but we also don't have the afb->address during atomic check.
> -	 *
> -	 * Fill in buffer attributes depending on the address here, but only on
> -	 * newly created planes since they're not being used by DC yet and this
> -	 * won't modify global state.
> -	 */
> -	dm_plane_state_old = to_dm_plane_state(plane->state);
> -	dm_plane_state_new = to_dm_plane_state(new_state);
> -
> -	if (dm_plane_state_new->dc_state &&
> -	    dm_plane_state_old->dc_state != dm_plane_state_new->dc_state) {
> -		struct dc_plane_state *plane_state =
> -			dm_plane_state_new->dc_state;
> -		bool force_disable_dcc = !plane_state->dcc.enable;
> -
> -		fill_plane_buffer_attributes(
> -			adev, afb, plane_state->format, plane_state->rotation,
> -			afb->tiling_flags,
> -			&plane_state->tiling_info, &plane_state->plane_size,
> -			&plane_state->dcc, &plane_state->address,
> -			afb->tmz_surface, force_disable_dcc);
> -	}
> -
> -	return 0;
> -}
> -
> -static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
> -				       struct drm_plane_state *old_state)
> -{
> -	struct amdgpu_bo *rbo;
> -	int r;
> -
> -	if (!old_state->fb)
> -		return;
> -
> -	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
> -	r = amdgpu_bo_reserve(rbo, false);
> -	if (unlikely(r)) {
> -		DRM_ERROR("failed to reserve rbo before unpin\n");
> -		return;
> -	}
> -
> -	amdgpu_bo_unpin(rbo);
> -	amdgpu_bo_unreserve(rbo);
> -	amdgpu_bo_unref(&rbo);
> -}
> -
> -static int dm_plane_helper_check_state(struct drm_plane_state *state,
> -				       struct drm_crtc_state *new_crtc_state)
> -{
> -	struct drm_framebuffer *fb = state->fb;
> -	int min_downscale, max_upscale;
> -	int min_scale = 0;
> -	int max_scale = INT_MAX;
> -
> -	/* Plane enabled? Validate viewport and get scaling factors from plane caps. */
> -	if (fb && state->crtc) {
> -		/* Validate viewport to cover the case when only the position changes */
> -		if (state->plane->type != DRM_PLANE_TYPE_CURSOR) {
> -			int viewport_width = state->crtc_w;
> -			int viewport_height = state->crtc_h;
> -
> -			if (state->crtc_x < 0)
> -				viewport_width += state->crtc_x;
> -			else if (state->crtc_x + state->crtc_w > new_crtc_state->mode.crtc_hdisplay)
> -				viewport_width = new_crtc_state->mode.crtc_hdisplay - state->crtc_x;
> -
> -			if (state->crtc_y < 0)
> -				viewport_height += state->crtc_y;
> -			else if (state->crtc_y + state->crtc_h > new_crtc_state->mode.crtc_vdisplay)
> -				viewport_height = new_crtc_state->mode.crtc_vdisplay - state->crtc_y;
> -
> -			if (viewport_width < 0 || viewport_height < 0) {
> -				DRM_DEBUG_ATOMIC("Plane completely outside of screen\n");
> -				return -EINVAL;
> -			} else if (viewport_width < MIN_VIEWPORT_SIZE*2) { /* x2 for width is because of pipe-split. */
> -				DRM_DEBUG_ATOMIC("Viewport width %d smaller than %d\n", viewport_width, MIN_VIEWPORT_SIZE*2);
> -				return -EINVAL;
> -			} else if (viewport_height < MIN_VIEWPORT_SIZE) {
> -				DRM_DEBUG_ATOMIC("Viewport height %d smaller than %d\n", viewport_height, MIN_VIEWPORT_SIZE);
> -				return -EINVAL;
> -			}
> -
> -		}
> -
> -		/* Get min/max allowed scaling factors from plane caps. */
> -		get_min_max_dc_plane_scaling(state->crtc->dev, fb,
> -					     &min_downscale, &max_upscale);
> -		/*
> -		 * Convert to drm convention: 16.16 fixed point, instead of dc's
> -		 * 1.0 == 1000. Also drm scaling is src/dst instead of dc's
> -		 * dst/src, so min_scale = 1.0 / max_upscale, etc.
> -		 */
> -		min_scale = (1000 << 16) / max_upscale;
> -		max_scale = (1000 << 16) / min_downscale;
> -	}
> -
> -	return drm_atomic_helper_check_plane_state(
> -		state, new_crtc_state, min_scale, max_scale, true, true);
> -}
> -
> -static int dm_plane_atomic_check(struct drm_plane *plane,
> -				 struct drm_plane_state *state)
> -{
> -	struct amdgpu_device *adev = drm_to_adev(plane->dev);
> -	struct dc *dc = adev->dm.dc;
> -	struct dm_plane_state *dm_plane_state;
> -	struct dc_scaling_info scaling_info;
> -	struct drm_crtc_state *new_crtc_state;
> -	int ret;
> -
> -	trace_amdgpu_dm_plane_atomic_check(state);
> -
> -	dm_plane_state = to_dm_plane_state(state);
> -
> -	if (!dm_plane_state->dc_state)
> -		return 0;
> -
> -	new_crtc_state =
> -		drm_atomic_get_new_crtc_state(state->state, state->crtc);
> -	if (!new_crtc_state)
> -		return -EINVAL;
> -
> -	ret = dm_plane_helper_check_state(state, new_crtc_state);
> -	if (ret)
> -		return ret;
> -
> -	ret = fill_dc_scaling_info(state, &scaling_info);
> -	if (ret)
> -		return ret;
> -
> -	if (dc_validate_plane(dc, dm_plane_state->dc_state) == DC_OK)
> -		return 0;
> -
> -	return -EINVAL;
> -}
> -
> -static int dm_plane_atomic_async_check(struct drm_plane *plane,
> -				       struct drm_plane_state *new_plane_state)
> -{
> -	/* Only support async updates on cursor planes. */
> -	if (plane->type != DRM_PLANE_TYPE_CURSOR)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static void dm_plane_atomic_async_update(struct drm_plane *plane,
> -					 struct drm_plane_state *new_state)
> -{
> -	struct drm_plane_state *old_state =
> -		drm_atomic_get_old_plane_state(new_state->state, plane);
> -
> -	trace_amdgpu_dm_atomic_update_cursor(new_state);
> -
> -	swap(plane->state->fb, new_state->fb);
> -
> -	plane->state->src_x = new_state->src_x;
> -	plane->state->src_y = new_state->src_y;
> -	plane->state->src_w = new_state->src_w;
> -	plane->state->src_h = new_state->src_h;
> -	plane->state->crtc_x = new_state->crtc_x;
> -	plane->state->crtc_y = new_state->crtc_y;
> -	plane->state->crtc_w = new_state->crtc_w;
> -	plane->state->crtc_h = new_state->crtc_h;
> -
> -	handle_cursor_update(plane, old_state);
> -}
> -
> -static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
> -	.prepare_fb = dm_plane_helper_prepare_fb,
> -	.cleanup_fb = dm_plane_helper_cleanup_fb,
> -	.atomic_check = dm_plane_atomic_check,
> -	.atomic_async_check = dm_plane_atomic_async_check,
> -	.atomic_async_update = dm_plane_atomic_async_update
> -};
> -
> -/*
> - * TODO: these are currently initialized to rgb formats only.
> - * For future use cases we should either initialize them dynamically based on
> - * plane capabilities, or initialize this array to all formats, so internal drm
> - * check will succeed, and let DC implement proper check
> - */
> -static const uint32_t rgb_formats[] = {
> -	DRM_FORMAT_XRGB8888,
> -	DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_RGBA8888,
> -	DRM_FORMAT_XRGB2101010,
> -	DRM_FORMAT_XBGR2101010,
> -	DRM_FORMAT_ARGB2101010,
> -	DRM_FORMAT_ABGR2101010,
> -	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_ABGR8888,
> -	DRM_FORMAT_RGB565,
> -};
> -
> -static const uint32_t overlay_formats[] = {
> -	DRM_FORMAT_XRGB8888,
> -	DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_RGBA8888,
> -	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_ABGR8888,
> -	DRM_FORMAT_RGB565
> -};
> -
> -static const u32 cursor_formats[] = {
> -	DRM_FORMAT_ARGB8888
> -};
> -
> -static int get_plane_formats(const struct drm_plane *plane,
> -			     const struct dc_plane_cap *plane_cap,
> -			     uint32_t *formats, int max_formats)
> -{
> -	int i, num_formats = 0;
> -
> -	/*
> -	 * TODO: Query support for each group of formats directly from
> -	 * DC plane caps. This will require adding more formats to the
> -	 * caps list.
> -	 */
> -
> -	switch (plane->type) {
> -	case DRM_PLANE_TYPE_PRIMARY:
> -		for (i = 0; i < ARRAY_SIZE(rgb_formats); ++i) {
> -			if (num_formats >= max_formats)
> -				break;
> -
> -			formats[num_formats++] = rgb_formats[i];
> -		}
> -
> -		if (plane_cap && plane_cap->pixel_format_support.nv12)
> -			formats[num_formats++] = DRM_FORMAT_NV12;
> -		if (plane_cap && plane_cap->pixel_format_support.p010)
> -			formats[num_formats++] = DRM_FORMAT_P010;
> -		if (plane_cap && plane_cap->pixel_format_support.fp16) {
> -			formats[num_formats++] = DRM_FORMAT_XRGB16161616F;
> -			formats[num_formats++] = DRM_FORMAT_ARGB16161616F;
> -			formats[num_formats++] = DRM_FORMAT_XBGR16161616F;
> -			formats[num_formats++] = DRM_FORMAT_ABGR16161616F;
> -		}
> -		break;
> -
> -	case DRM_PLANE_TYPE_OVERLAY:
> -		for (i = 0; i < ARRAY_SIZE(overlay_formats); ++i) {
> -			if (num_formats >= max_formats)
> -				break;
> -
> -			formats[num_formats++] = overlay_formats[i];
> -		}
> -		break;
> -
> -	case DRM_PLANE_TYPE_CURSOR:
> -		for (i = 0; i < ARRAY_SIZE(cursor_formats); ++i) {
> -			if (num_formats >= max_formats)
> -				break;
> -
> -			formats[num_formats++] = cursor_formats[i];
> -		}
> -		break;
> -	}
> -
> -	return num_formats;
> -}
> -
> -static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
> -				struct drm_plane *plane,
> -				unsigned long possible_crtcs,
> -				const struct dc_plane_cap *plane_cap)
> -{
> -	uint32_t formats[32];
> -	int num_formats;
> -	int res = -EPERM;
> -	unsigned int supported_rotations;
> -	uint64_t *modifiers = NULL;
> -
> -	num_formats = get_plane_formats(plane, plane_cap, formats,
> -					ARRAY_SIZE(formats));
> -
> -	res = get_plane_modifiers(dm->adev, plane->type, &modifiers);
> -	if (res)
> -		return res;
> -
> -	res = drm_universal_plane_init(adev_to_drm(dm->adev), plane, possible_crtcs,
> -				       &dm_plane_funcs, formats, num_formats,
> -				       modifiers, plane->type, NULL);
> -	kfree(modifiers);
> -	if (res)
> -		return res;
> -
> -	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
> -	    plane_cap && plane_cap->per_pixel_alpha) {
> -		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> -					  BIT(DRM_MODE_BLEND_PREMULTI);
> -
> -		drm_plane_create_alpha_property(plane);
> -		drm_plane_create_blend_mode_property(plane, blend_caps);
> -	}
> -
> -	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
> -	    plane_cap &&
> -	    (plane_cap->pixel_format_support.nv12 ||
> -	     plane_cap->pixel_format_support.p010)) {
> -		/* This only affects YUV formats. */
> -		drm_plane_create_color_properties(
> -			plane,
> -			BIT(DRM_COLOR_YCBCR_BT601) |
> -			BIT(DRM_COLOR_YCBCR_BT709) |
> -			BIT(DRM_COLOR_YCBCR_BT2020),
> -			BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
> -			BIT(DRM_COLOR_YCBCR_FULL_RANGE),
> -			DRM_COLOR_YCBCR_BT709, DRM_COLOR_YCBCR_LIMITED_RANGE);
> -	}
> -
> -	supported_rotations =
> -		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
> -		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
> -
> -	if (dm->adev->asic_type >= CHIP_BONAIRE &&
> -	    plane->type != DRM_PLANE_TYPE_CURSOR)
> -		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
> -						   supported_rotations);
> -
> -	drm_plane_helper_add(plane, &dm_plane_helper_funcs);
> -
> -	/* Create (reset) the plane state */
> -	if (plane->funcs->reset)
> -		plane->funcs->reset(plane);
> -
> -	return 0;
> -}
> -
>   static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
>   			       struct drm_plane *plane,
>   			       uint32_t crtc_index)
> @@ -8058,114 +6689,6 @@ static void remove_stream(struct amdgpu_device *adev,
>   	acrtc->enabled = false;
>   }
>   
> -static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
> -			       struct dc_cursor_position *position)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
> -	int x, y;
> -	int xorigin = 0, yorigin = 0;
> -
> -	if (!crtc || !plane->state->fb)
> -		return 0;
> -
> -	if ((plane->state->crtc_w > amdgpu_crtc->max_cursor_width) ||
> -	    (plane->state->crtc_h > amdgpu_crtc->max_cursor_height)) {
> -		DRM_ERROR("%s: bad cursor width or height %d x %d\n",
> -			  __func__,
> -			  plane->state->crtc_w,
> -			  plane->state->crtc_h);
> -		return -EINVAL;
> -	}
> -
> -	x = plane->state->crtc_x;
> -	y = plane->state->crtc_y;
> -
> -	if (x <= -amdgpu_crtc->max_cursor_width ||
> -	    y <= -amdgpu_crtc->max_cursor_height)
> -		return 0;
> -
> -	if (x < 0) {
> -		xorigin = min(-x, amdgpu_crtc->max_cursor_width - 1);
> -		x = 0;
> -	}
> -	if (y < 0) {
> -		yorigin = min(-y, amdgpu_crtc->max_cursor_height - 1);
> -		y = 0;
> -	}
> -	position->enable = true;
> -	position->translate_by_source = true;
> -	position->x = x;
> -	position->y = y;
> -	position->x_hotspot = xorigin;
> -	position->y_hotspot = yorigin;
> -
> -	return 0;
> -}
> -
> -static void handle_cursor_update(struct drm_plane *plane,
> -				 struct drm_plane_state *old_plane_state)
> -{
> -	struct amdgpu_device *adev = drm_to_adev(plane->dev);
> -	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
> -	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
> -	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
> -	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
> -	uint64_t address = afb ? afb->address : 0;
> -	struct dc_cursor_position position = {0};
> -	struct dc_cursor_attributes attributes;
> -	int ret;
> -
> -	if (!plane->state->fb && !old_plane_state->fb)
> -		return;
> -
> -	DC_LOG_CURSOR("%s: crtc_id=%d with size %d to %d\n",
> -		      __func__,
> -		      amdgpu_crtc->crtc_id,
> -		      plane->state->crtc_w,
> -		      plane->state->crtc_h);
> -
> -	ret = get_cursor_position(plane, crtc, &position);
> -	if (ret)
> -		return;
> -
> -	if (!position.enable) {
> -		/* turn off cursor */
> -		if (crtc_state && crtc_state->stream) {
> -			mutex_lock(&adev->dm.dc_lock);
> -			dc_stream_set_cursor_position(crtc_state->stream,
> -						      &position);
> -			mutex_unlock(&adev->dm.dc_lock);
> -		}
> -		return;
> -	}
> -
> -	amdgpu_crtc->cursor_width = plane->state->crtc_w;
> -	amdgpu_crtc->cursor_height = plane->state->crtc_h;
> -
> -	memset(&attributes, 0, sizeof(attributes));
> -	attributes.address.high_part = upper_32_bits(address);
> -	attributes.address.low_part  = lower_32_bits(address);
> -	attributes.width             = plane->state->crtc_w;
> -	attributes.height            = plane->state->crtc_h;
> -	attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
> -	attributes.rotation_angle    = 0;
> -	attributes.attribute_flags.value = 0;
> -
> -	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
> -
> -	if (crtc_state->stream) {
> -		mutex_lock(&adev->dm.dc_lock);
> -		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
> -							 &attributes))
> -			DRM_ERROR("DC failed to set cursor attributes\n");
> -
> -		if (!dc_stream_set_cursor_position(crtc_state->stream,
> -						   &position))
> -			DRM_ERROR("DC failed to set cursor position\n");
> -		mutex_unlock(&adev->dm.dc_lock);
> -	}
> -}
> -
>   static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
>   {
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> new file mode 100644
> index 000000000000..91a61f7d4827
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -0,0 +1,1496 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_plane_helper.h>
> +
> +#include "dc.h"
> +
> +#include "amdgpu.h"
> +#include "amdgpu_display.h"
> +#include "amdgpu_dm_plane.h"
> +#include "amdgpu_dm_trace.h"
> +#include "amdgpu_mode.h"
> +
> +/*
> + * TODO: these are currently initialized to rgb formats only.
> + * For future use cases we should either initialize them dynamically based on
> + * plane capabilities, or initialize this array to all formats, so internal drm
> + * check will succeed, and let DC implement proper check
> + */
> +static const uint32_t rgb_formats[] = {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_RGBA8888,
> +	DRM_FORMAT_XRGB2101010,
> +	DRM_FORMAT_XBGR2101010,
> +	DRM_FORMAT_ARGB2101010,
> +	DRM_FORMAT_ABGR2101010,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_RGB565,
> +};
> +
> +static const uint32_t overlay_formats[] = {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_RGBA8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_RGB565
> +};
> +
> +static const u32 cursor_formats[] = {
> +	DRM_FORMAT_ARGB8888
> +};
> +
> +enum dm_micro_swizzle {
> +	MICRO_SWIZZLE_Z = 0,
> +	MICRO_SWIZZLE_S = 1,
> +	MICRO_SWIZZLE_D = 2,
> +	MICRO_SWIZZLE_R = 3
> +};
> +
> +static void dm_drm_plane_reset(struct drm_plane *plane)
> +{
> +	struct dm_plane_state *amdgpu_state = NULL;
> +
> +	if (plane->state)
> +		plane->funcs->atomic_destroy_state(plane, plane->state);
> +
> +	amdgpu_state = kzalloc(sizeof(*amdgpu_state), GFP_KERNEL);
> +	WARN_ON(amdgpu_state == NULL);
> +
> +	if (amdgpu_state)
> +		__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
> +}
> +
> +static struct drm_plane_state *
> +dm_drm_plane_duplicate_state(struct drm_plane *plane)
> +{
> +	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
> +
> +	old_dm_plane_state = to_dm_plane_state(plane->state);
> +	dm_plane_state = kzalloc(sizeof(*dm_plane_state), GFP_KERNEL);
> +	if (!dm_plane_state)
> +		return NULL;
> +
> +	__drm_atomic_helper_plane_duplicate_state(plane, &dm_plane_state->base);
> +
> +	if (old_dm_plane_state->dc_state) {
> +		dm_plane_state->dc_state = old_dm_plane_state->dc_state;
> +		dc_plane_state_retain(dm_plane_state->dc_state);
> +	}
> +
> +	return &dm_plane_state->base;
> +}
> +
> +static void dm_drm_plane_destroy_state(struct drm_plane *plane,
> +				       struct drm_plane_state *state)
> +{
> +	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
> +
> +	if (dm_plane_state->dc_state)
> +		dc_plane_state_release(dm_plane_state->dc_state);
> +
> +	drm_atomic_helper_plane_destroy_state(plane, state);
> +}
> +
> +static unsigned modifier_gfx9_swizzle_mode(uint64_t modifier)
> +{
> +	if (modifier == DRM_FORMAT_MOD_LINEAR)
> +		return 0;
> +
> +	return AMD_FMT_MOD_GET(TILE, modifier);
> +}
> +
> +static bool modifier_has_dcc(uint64_t modifier)
> +{
> +	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
> +}
> +
> +static bool dm_plane_format_mod_supported(struct drm_plane *plane,
> +					  uint32_t format,
> +					  uint64_t modifier)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(plane->dev);
> +	const struct drm_format_info *info = drm_format_info(format);
> +	int i;
> +
> +	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
> +
> +	if (!info)
> +		return false;
> +
> +	/*
> +	 * We always have to allow these modifiers:
> +	 * 1. Core DRM checks for LINEAR support if userspace does not provide modifiers.
> +	 * 2. Not passing any modifiers is the same as explicitly passing INVALID.
> +	 */
> +	if (modifier == DRM_FORMAT_MOD_LINEAR ||
> +	    modifier == DRM_FORMAT_MOD_INVALID) {
> +		return true;
> +	}
> +
> +	/* Check that the modifier is on the list of the plane's supported modifiers. */
> +	for (i = 0; i < plane->modifier_count; i++) {
> +		if (modifier == plane->modifiers[i])
> +			break;
> +	}
> +	if (i == plane->modifier_count)
> +		return false;
> +
> +	/*
> +	 * For D swizzle the canonical modifier depends on the bpp, so check
> +	 * it here.
> +	 */
> +	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX9 &&
> +	    adev->family >= AMDGPU_FAMILY_NV) {
> +		if (microtile == MICRO_SWIZZLE_D && info->cpp[0] == 4)
> +			return false;
> +	}
> +
> +	if (adev->family >= AMDGPU_FAMILY_RV && microtile == MICRO_SWIZZLE_D &&
> +	    info->cpp[0] < 8)
> +		return false;
> +
> +	if (modifier_has_dcc(modifier)) {
> +		/* Per radeonsi comments 16/64 bpp are more complicated. */
> +		if (info->cpp[0] != 4)
> +			return false;
> +		/* We support multi-planar formats, but not when combined with
> +		 * additional DCC metadata planes.
> +		 */
> +		if (info->num_planes > 1)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static const struct drm_plane_funcs dm_plane_funcs = {
> +	.update_plane	= drm_atomic_helper_update_plane,
> +	.disable_plane	= drm_atomic_helper_disable_plane,
> +	.destroy	= drm_primary_helper_destroy,
> +	.reset = dm_drm_plane_reset,
> +	.atomic_duplicate_state = dm_drm_plane_duplicate_state,
> +	.atomic_destroy_state = dm_drm_plane_destroy_state,
> +	.format_mod_supported = dm_plane_format_mod_supported,
> +};
> +
> +static int get_plane_formats(const struct drm_plane *plane,
> +			     const struct dc_plane_cap *plane_cap,
> +			     uint32_t *formats, int max_formats)
> +{
> +	int i, num_formats = 0;
> +
> +	/*
> +	 * TODO: Query support for each group of formats directly from
> +	 * DC plane caps. This will require adding more formats to the
> +	 * caps list.
> +	 */
> +
> +	switch (plane->type) {
> +	case DRM_PLANE_TYPE_PRIMARY:
> +		for (i = 0; i < ARRAY_SIZE(rgb_formats); ++i) {
> +			if (num_formats >= max_formats)
> +				break;
> +
> +			formats[num_formats++] = rgb_formats[i];
> +		}
> +
> +		if (plane_cap && plane_cap->pixel_format_support.nv12)
> +			formats[num_formats++] = DRM_FORMAT_NV12;
> +		if (plane_cap && plane_cap->pixel_format_support.p010)
> +			formats[num_formats++] = DRM_FORMAT_P010;
> +		if (plane_cap && plane_cap->pixel_format_support.fp16) {
> +			formats[num_formats++] = DRM_FORMAT_XRGB16161616F;
> +			formats[num_formats++] = DRM_FORMAT_ARGB16161616F;
> +			formats[num_formats++] = DRM_FORMAT_XBGR16161616F;
> +			formats[num_formats++] = DRM_FORMAT_ABGR16161616F;
> +		}
> +		break;
> +
> +	case DRM_PLANE_TYPE_OVERLAY:
> +		for (i = 0; i < ARRAY_SIZE(overlay_formats); ++i) {
> +			if (num_formats >= max_formats)
> +				break;
> +
> +			formats[num_formats++] = overlay_formats[i];
> +		}
> +		break;
> +
> +	case DRM_PLANE_TYPE_CURSOR:
> +		for (i = 0; i < ARRAY_SIZE(cursor_formats); ++i) {
> +			if (num_formats >= max_formats)
> +				break;
> +
> +			formats[num_formats++] = cursor_formats[i];
> +		}
> +		break;
> +	}
> +
> +	return num_formats;
> +}
> +
> +static void add_modifier(uint64_t **mods, uint64_t *size,
> +			 uint64_t *cap, uint64_t mod)
> +{
> +	if (!*mods)
> +		return;
> +
> +	if (*cap - *size < 1) {
> +		uint64_t new_cap = *cap * 2;
> +		uint64_t *new_mods = kmalloc(new_cap * sizeof(uint64_t), GFP_KERNEL);
> +
> +		if (!new_mods) {
> +			kfree(*mods);
> +			*mods = NULL;
> +			return;
> +		}
> +
> +		memcpy(new_mods, *mods, sizeof(uint64_t) * *size);
> +		kfree(*mods);
> +		*mods = new_mods;
> +		*cap = new_cap;
> +	}
> +
> +	(*mods)[*size] = mod;
> +	*size += 1;
> +}
> +
> +static void fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
> +					      union dc_tiling_info *tiling_info)
> +{
> +	tiling_info->gfx9.num_pipes =
> +		adev->gfx.config.gb_addr_config_fields.num_pipes;
> +	tiling_info->gfx9.num_banks =
> +		adev->gfx.config.gb_addr_config_fields.num_banks;
> +	tiling_info->gfx9.pipe_interleave =
> +		adev->gfx.config.gb_addr_config_fields.pipe_interleave_size;
> +	tiling_info->gfx9.num_shader_engines =
> +		adev->gfx.config.gb_addr_config_fields.num_se;
> +	tiling_info->gfx9.max_compressed_frags =
> +		adev->gfx.config.gb_addr_config_fields.max_compress_frags;
> +	tiling_info->gfx9.num_rb_per_se =
> +		adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
> +	tiling_info->gfx9.shaderEnable = 1;
> +	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> +	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
> +	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
> +	    adev->asic_type == CHIP_VANGOGH)
> +		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
> +}
> +
> +static void
> +fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
> +				    union dc_tiling_info *tiling_info,
> +				    uint64_t modifier)
> +{
> +	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
> +	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
> +	unsigned int pkrs_log2 = AMD_FMT_MOD_GET(PACKERS, modifier);
> +	unsigned int pipes_log2 = min(4u, mod_pipe_xor_bits);
> +
> +	fill_gfx9_tiling_info_from_device(adev, tiling_info);
> +
> +	if (!IS_AMD_FMT_MOD(modifier))
> +		return;
> +
> +	tiling_info->gfx9.num_pipes = 1u << pipes_log2;
> +	tiling_info->gfx9.num_shader_engines = 1u << (mod_pipe_xor_bits - pipes_log2);
> +
> +	if (adev->family >= AMDGPU_FAMILY_NV) {
> +		tiling_info->gfx9.num_pkrs = 1u << pkrs_log2;
> +	} else {
> +		tiling_info->gfx9.num_banks = 1u << mod_bank_xor_bits;
> +
> +		/* for DCC we know it isn't rb aligned, so rb_per_se doesn't matter. */
> +	}
> +}
> +
> +static int validate_dcc(struct amdgpu_device *adev,
> +			const enum surface_pixel_format format,
> +			const enum dc_rotation_angle rotation,
> +			const union dc_tiling_info *tiling_info,
> +			const struct dc_plane_dcc_param *dcc,
> +			const struct dc_plane_address *address,
> +			const struct plane_size *plane_size)
> +{
> +	struct dc *dc = adev->dm.dc;
> +	struct dc_dcc_surface_param input;
> +	struct dc_surface_dcc_cap output;
> +
> +	memset(&input, 0, sizeof(input));
> +	memset(&output, 0, sizeof(output));
> +
> +	if (!dcc->enable)
> +		return 0;
> +
> +	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
> +	    !dc->cap_funcs.get_dcc_compression_cap)
> +		return -EINVAL;
> +
> +	input.format = format;
> +	input.surface_size.width = plane_size->surface_size.width;
> +	input.surface_size.height = plane_size->surface_size.height;
> +	input.swizzle_mode = tiling_info->gfx9.swizzle;
> +
> +	if (rotation == ROTATION_ANGLE_0 || rotation == ROTATION_ANGLE_180)
> +		input.scan = SCAN_DIRECTION_HORIZONTAL;
> +	else if (rotation == ROTATION_ANGLE_90 || rotation == ROTATION_ANGLE_270)
> +		input.scan = SCAN_DIRECTION_VERTICAL;
> +
> +	if (!dc->cap_funcs.get_dcc_compression_cap(dc, &input, &output))
> +		return -EINVAL;
> +
> +	if (!output.capable)
> +		return -EINVAL;
> +
> +	if (dcc->independent_64b_blks == 0 &&
> +	    output.grph.rgb.independent_64b_blks != 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int
> +fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
> +					  const struct amdgpu_framebuffer *afb,
> +					  const enum surface_pixel_format format,
> +					  const enum dc_rotation_angle rotation,
> +					  const struct plane_size *plane_size,
> +					  union dc_tiling_info *tiling_info,
> +					  struct dc_plane_dcc_param *dcc,
> +					  struct dc_plane_address *address,
> +					  const bool force_disable_dcc)
> +{
> +	const uint64_t modifier = afb->base.modifier;
> +	int ret;
> +
> +	fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
> +	tiling_info->gfx9.swizzle = modifier_gfx9_swizzle_mode(modifier);
> +
> +	if (modifier_has_dcc(modifier) && !force_disable_dcc) {
> +		uint64_t dcc_address = afb->address + afb->base.offsets[1];
> +
> +		dcc->enable = 1;
> +		dcc->meta_pitch = afb->base.pitches[1];
> +		dcc->independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
> +
> +		address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
> +		address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
> +	}
> +
> +	ret = validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void add_gfx10_3_modifiers(const struct amdgpu_device *adev,
> +				  uint64_t **mods, uint64_t *size,
> +				  uint64_t *capacity)
> +{
> +	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
> +	int pkrs = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
> +
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +		    AMD_FMT_MOD_SET(DCC, 1) |
> +		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> +
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +		    AMD_FMT_MOD_SET(DCC, 1) |
> +		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> +
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +		    AMD_FMT_MOD_SET(PACKERS, pkrs));
> +
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +		    AMD_FMT_MOD_SET(PACKERS, pkrs));
> +
> +	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +}
> +
> +static void add_gfx10_1_modifiers(const struct amdgpu_device *adev,
> +				  uint64_t **mods, uint64_t *size,
> +				  uint64_t *capacity)
> +{
> +	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
> +
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +		    AMD_FMT_MOD_SET(DCC, 1) |
> +		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> +
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +		    AMD_FMT_MOD_SET(DCC, 1) |
> +		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> +
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
> +
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
> +
> +
> +	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +}
> +
> +static void add_gfx9_modifiers(const struct amdgpu_device *adev,
> +			       uint64_t **mods, uint64_t *size,
> +			       uint64_t *capacity)
> +{
> +	int pipes = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
> +	int pipe_xor_bits = min(8, pipes +
> +				ilog2(adev->gfx.config.gb_addr_config_fields.num_se));
> +	int bank_xor_bits = min(8 - pipe_xor_bits,
> +				ilog2(adev->gfx.config.gb_addr_config_fields.num_banks));
> +	int rb = ilog2(adev->gfx.config.gb_addr_config_fields.num_se) +
> +		 ilog2(adev->gfx.config.gb_addr_config_fields.num_rb_per_se);
> +
> +	if (adev->family == AMDGPU_FAMILY_RV) {
> +		/* Raven2 and later */
> +		bool has_constant_encode = adev->asic_type > CHIP_RAVEN || adev->external_rev_id >= 0x81;
> +
> +		/*
> +		 * No _D DCC swizzles yet because we only allow 32bpp, which
> +		 * doesn't support _D on DCN
> +		 */
> +
> +		if (has_constant_encode) {
> +			add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> +				    AMD_FMT_MOD_SET(DCC, 1) |
> +				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> +				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1));
> +		}
> +
> +		add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> +			    AMD_FMT_MOD_SET(DCC, 1) |
> +			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> +			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0));
> +
> +		if (has_constant_encode) {
> +			add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> +				    AMD_FMT_MOD_SET(DCC, 1) |
> +				    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> +
> +				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +				    AMD_FMT_MOD_SET(RB, rb) |
> +				    AMD_FMT_MOD_SET(PIPE, pipes));
> +		}
> +
> +		add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
> +			    AMD_FMT_MOD_SET(DCC, 1) |
> +			    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
> +			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0) |
> +			    AMD_FMT_MOD_SET(RB, rb) |
> +			    AMD_FMT_MOD_SET(PIPE, pipes));
> +	}
> +
> +	/*
> +	 * Only supported for 64bpp on Raven, will be filtered on format in
> +	 * dm_plane_format_mod_supported.
> +	 */
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +		    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
> +
> +	if (adev->family == AMDGPU_FAMILY_RV) {
> +		add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
> +			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
> +			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
> +	}
> +
> +	/*
> +	 * Only supported for 64bpp on Raven, will be filtered on format in
> +	 * dm_plane_format_mod_supported.
> +	 */
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +
> +	if (adev->family == AMDGPU_FAMILY_RV) {
> +		add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
> +			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
> +	}
> +}
> +
> +static void fill_gfx8_tiling_info_from_flags(union dc_tiling_info *tiling_info,
> +					     uint64_t tiling_flags)
> +{
> +	/* Fill GFX8 params */
> +	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
> +		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
> +
> +		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
> +		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
> +		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
> +		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
> +		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
> +
> +		/* XXX fix me for VI */
> +		tiling_info->gfx8.num_banks = num_banks;
> +		tiling_info->gfx8.array_mode =
> +				DC_ARRAY_2D_TILED_THIN1;
> +		tiling_info->gfx8.tile_split = tile_split;
> +		tiling_info->gfx8.bank_width = bankw;
> +		tiling_info->gfx8.bank_height = bankh;
> +		tiling_info->gfx8.tile_aspect = mtaspect;
> +		tiling_info->gfx8.tile_mode =
> +				DC_ADDR_SURF_MICRO_TILING_DISPLAY;
> +	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE)
> +			== DC_ARRAY_1D_TILED_THIN1) {
> +		tiling_info->gfx8.array_mode = DC_ARRAY_1D_TILED_THIN1;
> +	}
> +
> +	tiling_info->gfx8.pipe_config =
> +			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
> +}
> +
> +static int
> +fill_plane_buffer_attributes(struct amdgpu_device *adev,
> +			     const struct amdgpu_framebuffer *afb,
> +			     const enum surface_pixel_format format,
> +			     const enum dc_rotation_angle rotation,
> +			     const uint64_t tiling_flags,
> +			     union dc_tiling_info *tiling_info,
> +			     struct plane_size *plane_size,
> +			     struct dc_plane_dcc_param *dcc,
> +			     struct dc_plane_address *address,
> +			     bool tmz_surface,
> +			     bool force_disable_dcc)
> +{
> +	const struct drm_framebuffer *fb = &afb->base;
> +	int ret;
> +
> +	memset(tiling_info, 0, sizeof(*tiling_info));
> +	memset(plane_size, 0, sizeof(*plane_size));
> +	memset(dcc, 0, sizeof(*dcc));
> +	memset(address, 0, sizeof(*address));
> +
> +	address->tmz_surface = tmz_surface;
> +
> +	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN) {
> +		uint64_t addr = afb->address + fb->offsets[0];
> +
> +		plane_size->surface_size.x = 0;
> +		plane_size->surface_size.y = 0;
> +		plane_size->surface_size.width = fb->width;
> +		plane_size->surface_size.height = fb->height;
> +		plane_size->surface_pitch =
> +			fb->pitches[0] / fb->format->cpp[0];
> +
> +		address->type = PLN_ADDR_TYPE_GRAPHICS;
> +		address->grph.addr.low_part = lower_32_bits(addr);
> +		address->grph.addr.high_part = upper_32_bits(addr);
> +	} else if (format < SURFACE_PIXEL_FORMAT_INVALID) {
> +		uint64_t luma_addr = afb->address + fb->offsets[0];
> +		uint64_t chroma_addr = afb->address + fb->offsets[1];
> +
> +		plane_size->surface_size.x = 0;
> +		plane_size->surface_size.y = 0;
> +		plane_size->surface_size.width = fb->width;
> +		plane_size->surface_size.height = fb->height;
> +		plane_size->surface_pitch =
> +			fb->pitches[0] / fb->format->cpp[0];
> +
> +		plane_size->chroma_size.x = 0;
> +		plane_size->chroma_size.y = 0;
> +		/* TODO: set these based on surface format */
> +		plane_size->chroma_size.width = fb->width / 2;
> +		plane_size->chroma_size.height = fb->height / 2;
> +
> +		plane_size->chroma_pitch =
> +			fb->pitches[1] / fb->format->cpp[1];
> +
> +		address->type = PLN_ADDR_TYPE_VIDEO_PROGRESSIVE;
> +		address->video_progressive.luma_addr.low_part =
> +			lower_32_bits(luma_addr);
> +		address->video_progressive.luma_addr.high_part =
> +			upper_32_bits(luma_addr);
> +		address->video_progressive.chroma_addr.low_part =
> +			lower_32_bits(chroma_addr);
> +		address->video_progressive.chroma_addr.high_part =
> +			upper_32_bits(chroma_addr);
> +	}
> +
> +	if (adev->family >= AMDGPU_FAMILY_AI) {
> +		ret = fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
> +								rotation, plane_size,
> +								tiling_info, dcc,
> +								address,
> +								force_disable_dcc);
> +		if (ret)
> +			return ret;
> +	} else {
> +		fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
> +				       const enum surface_pixel_format format,
> +				       enum dc_color_space *color_space)
> +{
> +	bool full_range;
> +
> +	*color_space = COLOR_SPACE_SRGB;
> +
> +	/* DRM color properties only affect non-RGB formats. */
> +	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
> +		return 0;
> +
> +	full_range = (plane_state->color_range == DRM_COLOR_YCBCR_FULL_RANGE);
> +
> +	switch (plane_state->color_encoding) {
> +	case DRM_COLOR_YCBCR_BT601:
> +		if (full_range)
> +			*color_space = COLOR_SPACE_YCBCR601;
> +		else
> +			*color_space = COLOR_SPACE_YCBCR601_LIMITED;
> +		break;
> +
> +	case DRM_COLOR_YCBCR_BT709:
> +		if (full_range)
> +			*color_space = COLOR_SPACE_YCBCR709;
> +		else
> +			*color_space = COLOR_SPACE_YCBCR709_LIMITED;
> +		break;
> +
> +	case DRM_COLOR_YCBCR_BT2020:
> +		if (full_range)
> +			*color_space = COLOR_SPACE_2020_YCBCR;
> +		else
> +			return -EINVAL;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void
> +fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
> +			       bool *per_pixel_alpha, bool *global_alpha,
> +			       int *global_alpha_value)
> +{
> +	*per_pixel_alpha = false;
> +	*global_alpha = false;
> +	*global_alpha_value = 0xff;
> +
> +	if (plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY)
> +		return;
> +
> +	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI) {
> +		static const uint32_t alpha_formats[] = {
> +			DRM_FORMAT_ARGB8888,
> +			DRM_FORMAT_RGBA8888,
> +			DRM_FORMAT_ABGR8888,
> +		};
> +		uint32_t format = plane_state->fb->format->format;
> +		unsigned int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(alpha_formats); ++i) {
> +			if (format == alpha_formats[i]) {
> +				*per_pixel_alpha = true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (plane_state->alpha < 0xffff) {
> +		*global_alpha = true;
> +		*global_alpha_value = plane_state->alpha >> 8;
> +	}
> +}
> +
> +int fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
> +				const struct drm_plane_state *plane_state,
> +				const uint64_t tiling_flags,
> +				struct dc_plane_info *plane_info,
> +				struct dc_plane_address *address,
> +				bool tmz_surface,
> +				bool force_disable_dcc)
> +{
> +	const struct drm_framebuffer *fb = plane_state->fb;
> +	const struct amdgpu_framebuffer *afb =
> +		to_amdgpu_framebuffer(plane_state->fb);
> +	int ret;
> +
> +	memset(plane_info, 0, sizeof(*plane_info));
> +
> +	switch (fb->format->format) {
> +	case DRM_FORMAT_C8:
> +		plane_info->format =
> +			SURFACE_PIXEL_FORMAT_GRPH_PALETA_256_COLORS;
> +		break;
> +	case DRM_FORMAT_RGB565:
> +		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_RGB565;
> +		break;
> +	case DRM_FORMAT_XRGB8888:
> +	case DRM_FORMAT_ARGB8888:
> +		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
> +		break;
> +	case DRM_FORMAT_XRGB2101010:
> +	case DRM_FORMAT_ARGB2101010:
> +		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010;
> +		break;
> +	case DRM_FORMAT_XBGR2101010:
> +	case DRM_FORMAT_ABGR2101010:
> +		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010;
> +		break;
> +	case DRM_FORMAT_XBGR8888:
> +	case DRM_FORMAT_ABGR8888:
> +		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR8888;
> +		break;
> +	case DRM_FORMAT_NV21:
> +		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr;
> +		break;
> +	case DRM_FORMAT_NV12:
> +		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb;
> +		break;
> +	case DRM_FORMAT_P010:
> +		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb;
> +		break;
> +	case DRM_FORMAT_XRGB16161616F:
> +	case DRM_FORMAT_ARGB16161616F:
> +		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F;
> +		break;
> +	case DRM_FORMAT_XBGR16161616F:
> +	case DRM_FORMAT_ABGR16161616F:
> +		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F;
> +		break;
> +	default:
> +		DRM_ERROR("Unsupported screen format %p4cc\n",
> +			  &fb->format->format);
> +		return -EINVAL;
> +	}
> +
> +	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
> +	case DRM_MODE_ROTATE_0:
> +		plane_info->rotation = ROTATION_ANGLE_0;
> +		break;
> +	case DRM_MODE_ROTATE_90:
> +		plane_info->rotation = ROTATION_ANGLE_90;
> +		break;
> +	case DRM_MODE_ROTATE_180:
> +		plane_info->rotation = ROTATION_ANGLE_180;
> +		break;
> +	case DRM_MODE_ROTATE_270:
> +		plane_info->rotation = ROTATION_ANGLE_270;
> +		break;
> +	default:
> +		plane_info->rotation = ROTATION_ANGLE_0;
> +		break;
> +	}
> +
> +	plane_info->visible = true;
> +	plane_info->stereo_format = PLANE_STEREO_FORMAT_NONE;
> +
> +	plane_info->layer_index = 0;
> +
> +	ret = fill_plane_color_attributes(plane_state, plane_info->format,
> +					  &plane_info->color_space);
> +	if (ret)
> +		return ret;
> +
> +	ret = fill_plane_buffer_attributes(adev, afb, plane_info->format,
> +					   plane_info->rotation, tiling_flags,
> +					   &plane_info->tiling_info,
> +					   &plane_info->plane_size,
> +					   &plane_info->dcc, address, tmz_surface,
> +					   force_disable_dcc);
> +	if (ret)
> +		return ret;
> +
> +	fill_blending_from_plane_state(plane_state, &plane_info->per_pixel_alpha,
> +				       &plane_info->global_alpha,
> +				       &plane_info->global_alpha_value);
> +
> +	return 0;
> +}
> +
> +static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
> +				      struct drm_plane_state *new_state)
> +{
> +	struct amdgpu_framebuffer *afb;
> +	struct drm_gem_object *obj;
> +	struct amdgpu_device *adev;
> +	struct amdgpu_bo *rbo;
> +	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
> +	struct list_head list;
> +	struct ttm_validate_buffer tv;
> +	struct ww_acquire_ctx ticket;
> +	uint32_t domain;
> +	int r;
> +
> +	if (!new_state->fb) {
> +		DRM_DEBUG_KMS("No FB bound\n");
> +		return 0;
> +	}
> +
> +	afb = to_amdgpu_framebuffer(new_state->fb);
> +	obj = new_state->fb->obj[0];
> +	rbo = gem_to_amdgpu_bo(obj);
> +	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
> +	INIT_LIST_HEAD(&list);
> +
> +	tv.bo = &rbo->tbo;
> +	tv.num_shared = 1;
> +	list_add(&tv.head, &list);
> +
> +	r = ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
> +	if (r) {
> +		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
> +		return r;
> +	}
> +
> +	if (plane->type != DRM_PLANE_TYPE_CURSOR)
> +		domain = amdgpu_display_supported_domains(adev, rbo->flags);
> +	else
> +		domain = AMDGPU_GEM_DOMAIN_VRAM;
> +
> +	r = amdgpu_bo_pin(rbo, domain);
> +	if (unlikely(r != 0)) {
> +		if (r != -ERESTARTSYS)
> +			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
> +		ttm_eu_backoff_reservation(&ticket, &list);
> +		return r;
> +	}
> +
> +	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
> +	if (unlikely(r != 0)) {
> +		amdgpu_bo_unpin(rbo);
> +		ttm_eu_backoff_reservation(&ticket, &list);
> +		DRM_ERROR("%p bind failed\n", rbo);
> +		return r;
> +	}
> +
> +	ttm_eu_backoff_reservation(&ticket, &list);
> +
> +	afb->address = amdgpu_bo_gpu_offset(rbo);
> +
> +	amdgpu_bo_ref(rbo);
> +
> +	/**
> +	 * We don't do surface updates on planes that have been newly created,
> +	 * but we also don't have the afb->address during atomic check.
> +	 *
> +	 * Fill in buffer attributes depending on the address here, but only on
> +	 * newly created planes since they're not being used by DC yet and this
> +	 * won't modify global state.
> +	 */
> +	dm_plane_state_old = to_dm_plane_state(plane->state);
> +	dm_plane_state_new = to_dm_plane_state(new_state);
> +
> +	if (dm_plane_state_new->dc_state &&
> +	    dm_plane_state_old->dc_state != dm_plane_state_new->dc_state) {
> +		struct dc_plane_state *plane_state =
> +			dm_plane_state_new->dc_state;
> +		bool force_disable_dcc = !plane_state->dcc.enable;
> +
> +		fill_plane_buffer_attributes(adev, afb, plane_state->format,
> +			plane_state->rotation,
> +			afb->tiling_flags,
> +			&plane_state->tiling_info, &plane_state->plane_size,
> +			&plane_state->dcc, &plane_state->address,
> +			afb->tmz_surface, force_disable_dcc);
> +	}
> +
> +	return 0;
> +}
> +
> +static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
> +				       struct drm_plane_state *old_state)
> +{
> +	struct amdgpu_bo *rbo;
> +	int r;
> +
> +	if (!old_state->fb)
> +		return;
> +
> +	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
> +	r = amdgpu_bo_reserve(rbo, false);
> +	if (unlikely(r)) {
> +		DRM_ERROR("failed to reserve rbo before unpin\n");
> +		return;
> +	}
> +
> +	amdgpu_bo_unpin(rbo);
> +	amdgpu_bo_unreserve(rbo);
> +	amdgpu_bo_unref(&rbo);
> +}
> +
> +void get_min_max_dc_plane_scaling(struct drm_device *dev,
> +				  struct drm_framebuffer *fb,
> +				  int *min_downscale, int *max_upscale)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct dc *dc = adev->dm.dc;
> +	/* Caps for all supported planes are the same on DCE and DCN 1 - 3 */
> +	struct dc_plane_cap *plane_cap = &dc->caps.planes[0];
> +
> +	switch (fb->format->format) {
> +	case DRM_FORMAT_P010:
> +	case DRM_FORMAT_NV12:
> +	case DRM_FORMAT_NV21:
> +		*max_upscale = plane_cap->max_upscale_factor.nv12;
> +		*min_downscale = plane_cap->max_downscale_factor.nv12;
> +		break;
> +
> +	case DRM_FORMAT_XRGB16161616F:
> +	case DRM_FORMAT_ARGB16161616F:
> +	case DRM_FORMAT_XBGR16161616F:
> +	case DRM_FORMAT_ABGR16161616F:
> +		*max_upscale = plane_cap->max_upscale_factor.fp16;
> +		*min_downscale = plane_cap->max_downscale_factor.fp16;
> +		break;
> +
> +	default:
> +		*max_upscale = plane_cap->max_upscale_factor.argb8888;
> +		*min_downscale = plane_cap->max_downscale_factor.argb8888;
> +		break;
> +	}
> +
> +	/*
> +	 * A factor of 1 in the plane_cap means to not allow scaling, ie. use a
> +	 * scaling factor of 1.0 == 1000 units.
> +	 */
> +	if (*max_upscale == 1)
> +		*max_upscale = 1000;
> +
> +	if (*min_downscale == 1)
> +		*min_downscale = 1000;
> +}
> +
> +int dm_plane_helper_check_state(struct drm_plane_state *state,
> +				struct drm_crtc_state *new_crtc_state)
> +{
> +	struct drm_framebuffer *fb = state->fb;
> +	int min_downscale, max_upscale;
> +	int min_scale = 0;
> +	int max_scale = INT_MAX;
> +
> +	/* Plane enabled? Validate viewport and get scaling factors from plane caps. */
> +	if (fb && state->crtc) {
> +		/* Validate viewport to cover the case when only the position changes */
> +		if (state->plane->type != DRM_PLANE_TYPE_CURSOR) {
> +			int viewport_width = state->crtc_w;
> +			int viewport_height = state->crtc_h;
> +
> +			if (state->crtc_x < 0)
> +				viewport_width += state->crtc_x;
> +			else if (state->crtc_x + state->crtc_w > new_crtc_state->mode.crtc_hdisplay)
> +				viewport_width = new_crtc_state->mode.crtc_hdisplay - state->crtc_x;
> +
> +			if (state->crtc_y < 0)
> +				viewport_height += state->crtc_y;
> +			else if (state->crtc_y + state->crtc_h > new_crtc_state->mode.crtc_vdisplay)
> +				viewport_height = new_crtc_state->mode.crtc_vdisplay - state->crtc_y;
> +
> +			if (viewport_width < 0 || viewport_height < 0) {
> +				DRM_DEBUG_ATOMIC("Plane completely outside of screen\n");
> +				return -EINVAL;
> +			} else if (viewport_width < MIN_VIEWPORT_SIZE*2) { /* x2 for width is because of pipe-split. */
> +				DRM_DEBUG_ATOMIC("Viewport width %d smaller than %d\n", viewport_width, MIN_VIEWPORT_SIZE*2);
> +				return -EINVAL;
> +			} else if (viewport_height < MIN_VIEWPORT_SIZE) {
> +				DRM_DEBUG_ATOMIC("Viewport height %d smaller than %d\n", viewport_height, MIN_VIEWPORT_SIZE);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		/* Get min/max allowed scaling factors from plane caps. */
> +		get_min_max_dc_plane_scaling(state->crtc->dev, fb,
> +					     &min_downscale, &max_upscale);
> +		/*
> +		 * Convert to drm convention: 16.16 fixed point, instead of dc's
> +		 * 1.0 == 1000. Also drm scaling is src/dst instead of dc's
> +		 * dst/src, so min_scale = 1.0 / max_upscale, etc.
> +		 */
> +		min_scale = (1000 << 16) / max_upscale;
> +		max_scale = (1000 << 16) / min_downscale;
> +	}
> +
> +	return drm_atomic_helper_check_plane_state(state, new_crtc_state,
> +						   min_scale, max_scale,
> +						   true, true);
> +}
> +
> +int fill_dc_scaling_info(const struct drm_plane_state *state,
> +			 struct dc_scaling_info *scaling_info)
> +{
> +	int scale_w, scale_h, min_downscale, max_upscale;
> +
> +	memset(scaling_info, 0, sizeof(*scaling_info));
> +
> +	/* Source is fixed 16.16 but we ignore mantissa for now... */
> +	scaling_info->src_rect.x = state->src_x >> 16;
> +	scaling_info->src_rect.y = state->src_y >> 16;
> +
> +	/*
> +	 * For reasons we don't (yet) fully understand a non-zero
> +	 * src_y coordinate into an NV12 buffer can cause a
> +	 * system hang. To avoid hangs (and maybe be overly cautious)
> +	 * let's reject both non-zero src_x and src_y.
> +	 *
> +	 * We currently know of only one use-case to reproduce a
> +	 * scenario with non-zero src_x and src_y for NV12, which
> +	 * is to gesture the YouTube Android app into full screen
> +	 * on ChromeOS.
> +	 */
> +	if (state->fb &&
> +	    state->fb->format->format == DRM_FORMAT_NV12 &&
> +	    (scaling_info->src_rect.x != 0 ||
> +	     scaling_info->src_rect.y != 0))
> +		return -EINVAL;
> +
> +	scaling_info->src_rect.width = state->src_w >> 16;
> +	if (scaling_info->src_rect.width == 0)
> +		return -EINVAL;
> +
> +	scaling_info->src_rect.height = state->src_h >> 16;
> +	if (scaling_info->src_rect.height == 0)
> +		return -EINVAL;
> +
> +	scaling_info->dst_rect.x = state->crtc_x;
> +	scaling_info->dst_rect.y = state->crtc_y;
> +
> +	if (state->crtc_w == 0)
> +		return -EINVAL;
> +
> +	scaling_info->dst_rect.width = state->crtc_w;
> +
> +	if (state->crtc_h == 0)
> +		return -EINVAL;
> +
> +	scaling_info->dst_rect.height = state->crtc_h;
> +
> +	/* DRM doesn't specify clipping on destination output. */
> +	scaling_info->clip_rect = scaling_info->dst_rect;
> +
> +	/* Validate scaling per-format with DC plane caps */
> +	if (state->plane && state->plane->dev && state->fb) {
> +		get_min_max_dc_plane_scaling(state->plane->dev, state->fb,
> +					     &min_downscale, &max_upscale);
> +	} else {
> +		min_downscale = 250;
> +		max_upscale = 16000;
> +	}
> +
> +	scale_w = scaling_info->dst_rect.width * 1000 /
> +		  scaling_info->src_rect.width;
> +
> +	if (scale_w < min_downscale || scale_w > max_upscale)
> +		return -EINVAL;
> +
> +	scale_h = scaling_info->dst_rect.height * 1000 /
> +		  scaling_info->src_rect.height;
> +
> +	if (scale_h < min_downscale || scale_h > max_upscale)
> +		return -EINVAL;
> +
> +	/*
> +	 * The "scaling_quality" can be ignored for now, quality = 0 has DC
> +	 * assume reasonable defaults based on the format.
> +	 */
> +
> +	return 0;
> +}
> +
> +static int dm_plane_atomic_check(struct drm_plane *plane,
> +				 struct drm_plane_state *state)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(plane->dev);
> +	struct dc *dc = adev->dm.dc;
> +	struct dm_plane_state *dm_plane_state;
> +	struct dc_scaling_info scaling_info;
> +	struct drm_crtc_state *new_crtc_state;
> +	int ret;
> +
> +	trace_amdgpu_dm_plane_atomic_check(state);
> +
> +	dm_plane_state = to_dm_plane_state(state);
> +
> +	if (!dm_plane_state->dc_state)
> +		return 0;
> +
> +	new_crtc_state =
> +		drm_atomic_get_new_crtc_state(state->state, state->crtc);
> +	if (!new_crtc_state)
> +		return -EINVAL;
> +
> +	ret = dm_plane_helper_check_state(state, new_crtc_state);
> +	if (ret)
> +		return ret;
> +
> +	ret = fill_dc_scaling_info(state, &scaling_info);
> +	if (ret)
> +		return ret;
> +
> +	if (dc_validate_plane(dc, dm_plane_state->dc_state) == DC_OK)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int dm_plane_atomic_async_check(struct drm_plane *plane,
> +				       struct drm_plane_state *new_plane_state)
> +{
> +	/* Only support async updates on cursor planes. */
> +	if (plane->type != DRM_PLANE_TYPE_CURSOR)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
> +			       struct dc_cursor_position *position)
> +{
> +	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
> +	int x, y;
> +	int xorigin = 0, yorigin = 0;
> +
> +	if (!crtc || !plane->state->fb)
> +		return 0;
> +
> +	if ((plane->state->crtc_w > amdgpu_crtc->max_cursor_width) ||
> +	    (plane->state->crtc_h > amdgpu_crtc->max_cursor_height)) {
> +		DRM_ERROR("%s: bad cursor width or height %d x %d\n",
> +			  __func__,
> +			  plane->state->crtc_w,
> +			  plane->state->crtc_h);
> +		return -EINVAL;
> +	}
> +
> +	x = plane->state->crtc_x;
> +	y = plane->state->crtc_y;
> +
> +	if (x <= -amdgpu_crtc->max_cursor_width ||
> +	    y <= -amdgpu_crtc->max_cursor_height)
> +		return 0;
> +
> +	if (x < 0) {
> +		xorigin = min(-x, amdgpu_crtc->max_cursor_width - 1);
> +		x = 0;
> +	}
> +	if (y < 0) {
> +		yorigin = min(-y, amdgpu_crtc->max_cursor_height - 1);
> +		y = 0;
> +	}
> +	position->enable = true;
> +	position->translate_by_source = true;
> +	position->x = x;
> +	position->y = y;
> +	position->x_hotspot = xorigin;
> +	position->y_hotspot = yorigin;
> +
> +	return 0;
> +}
> +
> +void handle_cursor_update(struct drm_plane *plane,
> +			  struct drm_plane_state *old_plane_state)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(plane->dev);
> +	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
> +	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
> +	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
> +	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
> +	uint64_t address = afb ? afb->address : 0;
> +	struct dc_cursor_position position = {0};
> +	struct dc_cursor_attributes attributes;
> +	int ret;
> +
> +	if (!plane->state->fb && !old_plane_state->fb)
> +		return;
> +
> +	DC_LOG_CURSOR("%s: crtc_id=%d with size %d to %d\n",
> +		      __func__,
> +		      amdgpu_crtc->crtc_id,
> +		      plane->state->crtc_w,
> +		      plane->state->crtc_h);
> +
> +	ret = get_cursor_position(plane, crtc, &position);
> +	if (ret)
> +		return;
> +
> +	if (!position.enable) {
> +		/* turn off cursor */
> +		if (crtc_state && crtc_state->stream) {
> +			mutex_lock(&adev->dm.dc_lock);
> +			dc_stream_set_cursor_position(crtc_state->stream,
> +						      &position);
> +			mutex_unlock(&adev->dm.dc_lock);
> +		}
> +		return;
> +	}
> +
> +	amdgpu_crtc->cursor_width = plane->state->crtc_w;
> +	amdgpu_crtc->cursor_height = plane->state->crtc_h;
> +
> +	memset(&attributes, 0, sizeof(attributes));
> +	attributes.address.high_part = upper_32_bits(address);
> +	attributes.address.low_part  = lower_32_bits(address);
> +	attributes.width             = plane->state->crtc_w;
> +	attributes.height            = plane->state->crtc_h;
> +	attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
> +	attributes.rotation_angle    = 0;
> +	attributes.attribute_flags.value = 0;
> +
> +	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
> +
> +	if (crtc_state->stream) {
> +		mutex_lock(&adev->dm.dc_lock);
> +		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
> +						     &attributes))
> +			DRM_ERROR("DC failed to set cursor attributes\n");
> +
> +		if (!dc_stream_set_cursor_position(crtc_state->stream,
> +						   &position))
> +			DRM_ERROR("DC failed to set cursor position\n");
> +		mutex_unlock(&adev->dm.dc_lock);
> +	}
> +}
> +
> +static void dm_plane_atomic_async_update(struct drm_plane *plane,
> +					 struct drm_plane_state *new_state)
> +{
> +	struct drm_plane_state *old_state =
> +		drm_atomic_get_old_plane_state(new_state->state, plane);
> +
> +	trace_amdgpu_dm_atomic_update_cursor(new_state);
> +
> +	swap(plane->state->fb, new_state->fb);
> +
> +	plane->state->src_x = new_state->src_x;
> +	plane->state->src_y = new_state->src_y;
> +	plane->state->src_w = new_state->src_w;
> +	plane->state->src_h = new_state->src_h;
> +	plane->state->crtc_x = new_state->crtc_x;
> +	plane->state->crtc_y = new_state->crtc_y;
> +	plane->state->crtc_w = new_state->crtc_w;
> +	plane->state->crtc_h = new_state->crtc_h;
> +
> +	handle_cursor_update(plane, old_state);
> +}
> +
> +static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
> +	.prepare_fb = dm_plane_helper_prepare_fb,
> +	.cleanup_fb = dm_plane_helper_cleanup_fb,
> +	.atomic_check = dm_plane_atomic_check,
> +	.atomic_async_check = dm_plane_atomic_async_check,
> +	.atomic_async_update = dm_plane_atomic_async_update
> +};
> +
> +static int get_plane_modifiers(const struct amdgpu_device *adev,
> +			       unsigned int plane_type, uint64_t **mods)
> +{
> +	uint64_t size = 0, capacity = 128;
> +	*mods = NULL;
> +
> +	/* We have not hooked up any pre-GFX9 modifiers. */
> +	if (adev->family < AMDGPU_FAMILY_AI)
> +		return 0;
> +
> +	*mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
> +
> +	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
> +		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
> +		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
> +		return *mods ? 0 : -ENOMEM;
> +	}
> +
> +	switch (adev->family) {
> +	case AMDGPU_FAMILY_AI:
> +	case AMDGPU_FAMILY_RV:
> +		add_gfx9_modifiers(adev, mods, &size, &capacity);
> +		break;
> +	case AMDGPU_FAMILY_NV:
> +	case AMDGPU_FAMILY_VGH:
> +		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
> +			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
> +		else
> +			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
> +		break;
> +	}
> +
> +	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
> +
> +	/* INVALID marks the end of the list. */
> +	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
> +
> +	if (!*mods)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
> +			 struct drm_plane *plane,
> +			 unsigned long possible_crtcs,
> +			 const struct dc_plane_cap *plane_cap)
> +{
> +	uint32_t formats[32];
> +	int num_formats;
> +	int res = -EPERM;
> +	unsigned int supported_rotations;
> +	uint64_t *modifiers = NULL;
> +
> +	num_formats = get_plane_formats(plane, plane_cap, formats,
> +					ARRAY_SIZE(formats));
> +
> +	res = get_plane_modifiers(dm->adev, plane->type, &modifiers);
> +	if (res)
> +		return res;
> +
> +	res = drm_universal_plane_init(adev_to_drm(dm->adev), plane, possible_crtcs,
> +				       &dm_plane_funcs, formats, num_formats,
> +				       modifiers, plane->type, NULL);
> +	kfree(modifiers);
> +	if (res)
> +		return res;
> +
> +	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
> +	    plane_cap && plane_cap->per_pixel_alpha) {
> +		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> +					  BIT(DRM_MODE_BLEND_PREMULTI);
> +
> +		drm_plane_create_alpha_property(plane);
> +		drm_plane_create_blend_mode_property(plane, blend_caps);
> +	}
> +
> +	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
> +	    plane_cap &&
> +	    (plane_cap->pixel_format_support.nv12 ||
> +	     plane_cap->pixel_format_support.p010)) {
> +		/* This only affects YUV formats. */
> +		drm_plane_create_color_properties(plane,
> +			BIT(DRM_COLOR_YCBCR_BT601) |
> +			BIT(DRM_COLOR_YCBCR_BT709) |
> +			BIT(DRM_COLOR_YCBCR_BT2020),
> +			BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
> +			BIT(DRM_COLOR_YCBCR_FULL_RANGE),
> +			DRM_COLOR_YCBCR_BT709, DRM_COLOR_YCBCR_LIMITED_RANGE);
> +	}
> +
> +	supported_rotations =
> +		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
> +		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
> +
> +	if (dm->adev->asic_type >= CHIP_BONAIRE &&
> +	    plane->type != DRM_PLANE_TYPE_CURSOR)
> +		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
> +						   supported_rotations);
> +
> +	drm_plane_helper_add(plane, &dm_plane_helper_funcs);
> +
> +	/* Create (reset) the plane state */
> +	if (plane->funcs->reset)
> +		plane->funcs->reset(plane);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> new file mode 100644
> index 000000000000..cbf6f3017ecb
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> @@ -0,0 +1,56 @@
> +/*
> + * Copyright (C) 2021 Advanced Micro Devices, Inc. All rights reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dc.h"
> +#include "amdgpu_dm.h"
> +
> +/* Forward declarations */
> +struct dc_plane_state;
> +
> +void handle_cursor_update(struct drm_plane *plane,
> +			  struct drm_plane_state *old_plane_state);

I'm OK with the patch on the high level but I think it'd be best to be a 
little more rigorous with the naming scheme on some of these functions 
now that they're no longer static symbols specific to amdgpu_dm.c.

Regards,
Nicholas Kazlauskas

> +
> +int fill_dc_scaling_info(const struct drm_plane_state *state,
> +			 struct dc_scaling_info *scaling_info);
> +
> +void get_min_max_dc_plane_scaling(struct drm_device *dev,
> +				  struct drm_framebuffer *fb,
> +				  int *min_downscale, int *max_upscale);
> +
> +int dm_plane_helper_check_state(struct drm_plane_state *state,
> +				struct drm_crtc_state *new_crtc_state);
> +
> +int fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
> +				const struct drm_plane_state *plane_state,
> +				const uint64_t tiling_flags,
> +				struct dc_plane_info *plane_info,
> +				struct dc_plane_address *address,
> +				bool tmz_surface,
> +				bool force_disable_dcc);
> +
> +int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
> +			 struct drm_plane *plane,
> +			 unsigned long possible_crtcs,
> +			 const struct dc_plane_cap *plane_cap);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
