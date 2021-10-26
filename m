Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB10C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 20:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01CB60F02
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 20:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D01CB60F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245616E492;
	Tue, 26 Oct 2021 20:47:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D426E492
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 20:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTl0yOOkgfgj17uttYpDgCNu+vOnB+/ieVdjE2fFPSIbzLrRZ0nxvtuzw3G63fpFCyAtzbD4wLTbrxFicSwwrJPy7ppL8+g8OH7Ynt8H/dGrp5Mh0UIVY4n7zkSVQ5CMKjyMdyKE7cjxErzb2RLYPmGjGVYuWRev/fBxNdUR9UvskxjqIMD77/Y6ZevMGdU2Azdlup9W9JLZ2yuCSUlE+l1ihOfau2+PbYeI/1atrSrawm3XBaoiwO0HpQJVNTOfoKoZWWRpYE2Hj2QdLe4Ozxftgqqeo82qbip4EL2qktwwLeq6W0iYySrNgwbFrvFJdyh6d3kZtSmtC2zkYaHiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZwmlSPYP2VmdLECjMRJYSpX5vdRt4Vg+5JKFzn0xEI=;
 b=ELoXBy28pvyFVrIV1CfRUohMUr5cI9YV7UJH3Rha/VEtc1ORX19mErRweN8AmURbMprHiXGZaIyMt4G5EzoLUc3hnB3zLB4PsLwcTy1Px7Qi7bIGxkHO09WKdby1KLr42yfRIABdn+Fb1qx4aYymwe9AsZDP51eLR4DxZaujFZrYU9nPobsuYbl0BYxR+Bc+abToHBHL/fOetusUvAkWXeNP2BxKIZXPzTz1rfTaN5dyfr2VEg5JGibDAmympSFAriGBG7p50Vdg/WKkYGjtS3rRAWanKdCB8zGQHcfgZZ0f1tzZ7QLs5BAj/9980SFnviTpPbWFk4Ecl9fNzuE2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZwmlSPYP2VmdLECjMRJYSpX5vdRt4Vg+5JKFzn0xEI=;
 b=gDjPcxtaghCmohkdyas3/GDKHpr+jg/GFCcMsluuJNXbl4Dwpuuyd4dfkY9zaW7iCJrZJTwoCblLm6/2B6/QTSmOOXnaRb52yQ9w1q/rboJdVpbz8P5ZSHKtCqorEeaa2EWr5st4OTArFJeeVHV59Jzmy6chd7A3FIeseO7I2wc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 26 Oct
 2021 20:47:55 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 20:47:55 +0000
Message-ID: <1ef6fd36-2ec9-05ba-be63-560f32f559f7@amd.com>
Date: Tue, 26 Oct 2021 16:47:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] drm/amdgpu/UAPI: rearrange header to better align related
 items
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211026144726.191916-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20211026144726.191916-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::6) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [10.254.36.169] (165.204.84.11) by
 YT3PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.13 via Frontend Transport; Tue, 26 Oct 2021 20:47:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4015be3-beed-4630-6674-08d998c1e2d7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1162:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1162E80BD627B22759CE16F299849@DM5PR12MB1162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MZqPqTIE+TE8LKbRJttQGgflgh0tahPaOndnKoIqqBdE/Wp8/7o0vnfW7NbnH5U9j6LtxGhPRlmxn9pUtmjuNS77xD0mGDpffaiJYOHKYmfYo8EVOr6T2wPurBq0DxLH6yacj7uHgjx00q3GhDz2n1FodOlrhbRGjYqtSquDcmEAj00ufl5TU6jN8BZOBxRsM9DnQTmSoC3TvJF8HibrvxAvZ4iNAWuzEBo2jCee+zlNjHUXGIe6M2LcN7J0dRDiaymvFt5CCBu0n4SHvtSd3nMxYJm8uTe2HcI9ZgZ1qx+wFZvCvZyosWkmCLCWAykqpmsU/XNOWActyfIta2VBcdQFgzl6e5GrGzpcwRor65TzWBo7WB6tPMHbcK7CYzW+F3Kb5mEVITXr3wT4t2tAj9o8fIMC1hxVZ7rVPK0tvLrvNV77Lign7bw7HPO1h2+HnoT6fx+UPPzKeSyeBUtvc7sjD9IM/8axODaCm0VdPVZnxtPD5xc6ftvHG2bC3O7w5QbbULWkuWK9ErZedjG3UaKGflFcyBi3rAUFzLYHZUiJrVwOg/T6gKvxFVAp9EYHbLVri8eHKJORmz/92YG5pul32P2W7FVn94ahTu5XVCNMemnwnpGn0Srp+gS7Eco8bfOEzN41T/YxgYnkE/hIe2WA3r7AmEqcIj5b5MzlaOzrIiOm4MCLW+RmN1cTalllNgEzWcE8YI0EFzP87UT2sHE3Z7Vd30wCc5WqPQuRSw111fbWenYBsTuRqycvmMG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(31696002)(316002)(26005)(956004)(6486002)(36756003)(8676002)(16576012)(53546011)(83380400001)(8936002)(86362001)(508600001)(38100700002)(2616005)(31686004)(66476007)(66946007)(66556008)(4001150100001)(44832011)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2E1MVJiQmlUeHo3bHo4TkpsZUNiSTVjWGdjVTVpRTFxWXQyS1YzZnVKV1Ew?=
 =?utf-8?B?dlJGYjhheDNaS01CUGdDMUR6U1VJTjFLbEkvUXg3aEdHd0hBTWpwNGlSb3pV?=
 =?utf-8?B?T0lkd3d1UWE2S3RRYjhlS1Y4RGVUMElUZEpmNWg5alJsR21sQldlU2luTXNw?=
 =?utf-8?B?enZkWHZydnJNQnlnQUFUVnN2dTBKWXhQbU5Ea0ZXQVFLN281clJJblFRWllr?=
 =?utf-8?B?ZkRGTHkwSmN1Qzl1ZE9ablNTQVdRb0ZVYzFONm9HTEpZTmEzTUh6N2RrdE0w?=
 =?utf-8?B?TzRaT1hUQWYrN1hmMjU5dWpBVkNjOGRLelJKZlcveTJlNytqNGY0ZzZ1NGNa?=
 =?utf-8?B?eVh4Nm5oekp5MnJjNzM2c1dCTzVQRmRyTWZCYzRtaUpSUkN0anhBU1UvdFdy?=
 =?utf-8?B?Y3BDNlVFVjBBZVdKeXlPaC9rWDdqM2srUWtvWm5ZZUV3NnRJUzVGdlJSS29N?=
 =?utf-8?B?TFBqNVA5TzEvMitpV3gvTjZyeUJKUnpKWEJ1WE5WS0lpUlZBdTE4RG1HYjJv?=
 =?utf-8?B?bWgzZXB1UUdyaE5aYWdDaDdvc3BZaEF2ZFpmbVZJQlJPZlJMWThDQjJlcnRU?=
 =?utf-8?B?MGc5bm1udjF6WFV1RW41ZnZnTmExSGluOS9BOXJScFZRTWRxV25wdXlTN2o2?=
 =?utf-8?B?dVcva2JLdnFoRG5mYldTTC9ZWFZPTHpjYUEwakw2UEZFK0hDU1FIRUFibmJW?=
 =?utf-8?B?UFhMQWFoQjllMnlVTWVzVElzcHdpT1V3RUFheHoyQlBrWGRKeDREMmlDdnZV?=
 =?utf-8?B?YzhBS1NkNC93dVRvbW5PYVRzR1NTdm54WSt2Yml1eEJOamV5MGNkbnBteEVi?=
 =?utf-8?B?SC9TbklYb05NVGtSb3JOdmdUbDVNRnZNcW05OHFTdXhyeWZpRFlSUWxMQ1hw?=
 =?utf-8?B?RkZIdGk5U09UWER4M3RZaUNUZ25lcUFLK2czWVhydUNuQ2pkTzViMFpkaGQ4?=
 =?utf-8?B?YndnM0U3TUw4VVhQNTZidHB4NHNxVDNWOXFzQ1VJNmY2SythbVNmenc4c2Vq?=
 =?utf-8?B?NTFaVno0SWRGbHhNbHgrTHpPU0RCT0R5dnVkSkRZMzk5YnNkM3gxclpBSVlr?=
 =?utf-8?B?UXJpSjZsMnRxSDRIQ0FTMHUrbEJGZWdiay85WFYzUHlqTjBUODRuRkZ6WkRJ?=
 =?utf-8?B?SnVBVmw3OWJsOU5rUGNsUGpjU243RlpoUUxqTk9vbGt3QkZTejV0NmRhSFRp?=
 =?utf-8?B?Ym5HY3lHQ0djc1JiZlhIZ1lxb0dybkpMZUUxMUpyRk00c05HKzA0RHAvRThr?=
 =?utf-8?B?Y0R1OGRWOTFSSTdjemF4NFJ3RktvM1ZWM05MS2JBZ1VsazJzZGs4NGdITm1G?=
 =?utf-8?B?d3E2cGhoM0M1bko5WjZwVGdwd2VnTVRGaC9aczFZRTVyZTdRVXRURGZLbjZp?=
 =?utf-8?B?bUxnUlgyR01qV0pRRzY1Wkh3SEk3eFNSYS9BN2ZkbndOSGowOFVXTUhUTWMx?=
 =?utf-8?B?WStSdk43Nk91M0F3bnZaYURVanN5N2s1NUFJZEErMHBJbmg0L2cwZTgva00w?=
 =?utf-8?B?dWZaZkhnZnloV0hCQ2toaEc1OHZTb1I2d01RZzBKd2hJeCtpQndMa2dZcFlW?=
 =?utf-8?B?U1dDS3lqeEQzOHY5STRuOG4veU5tUVc5eEVyVjNhS3gyQ1haeTZXbHIvNVhL?=
 =?utf-8?B?OTBWanJhOFJSU3AvMmVhcXIyMVA1ZXRSMEo2TmZTWk95TXI5bmlyQ3JUR2xw?=
 =?utf-8?B?em90V3JXbjVYOEh6RHY1b1dlWTFWWCtzeVZTRXltTVBKOFZZUThxaWdXaUpN?=
 =?utf-8?B?R1orczdxRWtwcWxqVEZxQmErR0lRVXB5Q2RoMVh3c2dHT1lsbWdzTk5sRnRU?=
 =?utf-8?B?WUlNRUl6cUVQK25TRnZQN1ptYXdhc0Z5RkQ1cmliajJNQkh5ZzdmODA2R3ZS?=
 =?utf-8?B?UjhtQWV3VGZRNW12dksyOG93V0tmYlNtR0paK050dmlwTjlTSTdTUFcxK1lV?=
 =?utf-8?B?WlV3Ky9FUlBJc3BqQkIzYVk2MjhqaWdERWgySEkvOVVWNWVjMUJtTEdnaHlU?=
 =?utf-8?B?S2p6RUZjeDREUi9IcXBKeENvSER5L0tFcnUvVWFHMDZXZTNlTzZVTkpDcXFD?=
 =?utf-8?B?Y1k5UXhxNXlJTmxmREJ3UnBnRjFTdXp4WVc4eGFydU9xU09TSlBzdzhQeFVj?=
 =?utf-8?Q?+B+I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4015be3-beed-4630-6674-08d998c1e2d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 20:47:55.3022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsCMiRulgTFgEbZQhL74DyUtcFFthrMHLZ5M7As+T3wlhv8FAQ6SJsi2c3OjaSiJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>


On 2021-10-26 10:47, Alex Deucher wrote:
> Move the RAS query parameters to align with the INFO query where
> they are used.  No functional change.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 0cbd1540aeac..26e45fc5eb1a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -786,13 +786,6 @@ struct drm_amdgpu_cs_chunk_data {
>  #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
>  /* query ras mask of enabled features*/
>  #define AMDGPU_INFO_RAS_ENABLED_FEATURES	0x20
> -/* query video encode/decode caps */
> -#define AMDGPU_INFO_VIDEO_CAPS			0x21
> -	/* Subquery id: Decode */
> -	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
> -	/* Subquery id: Encode */
> -	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
> -
>  /* RAS MASK: UMC (VRAM) */
>  #define AMDGPU_INFO_RAS_ENABLED_UMC			(1 << 0)
>  /* RAS MASK: SDMA */
> @@ -821,6 +814,12 @@ struct drm_amdgpu_cs_chunk_data {
>  #define AMDGPU_INFO_RAS_ENABLED_MP1			(1 << 12)
>  /* RAS MASK: FUSE */
>  #define AMDGPU_INFO_RAS_ENABLED_FUSE			(1 << 13)
> +/* query video encode/decode caps */
> +#define AMDGPU_INFO_VIDEO_CAPS			0x21
> +	/* Subquery id: Decode */
> +	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
> +	/* Subquery id: Encode */
> +	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
>  
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff

