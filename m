Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1245BC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 15:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8D010E070;
	Wed, 23 Nov 2022 15:48:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5000B10E070
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 15:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqtId4a6GDFytHQlnTZ5DfkSZvjoJKxGjTMdpTDdd6Hn+RzJaUUW0dzJEBFWQcFMi0U2AOOkGjgSm7q3s5Gy6IS166968ShMLMib4Cn4bxZ3vtyxl8Zqjpo7kWlnTS3fcWOC6xbUiXUgGnPNdEa8LZVXhtGqQBtFqfttpIwZocO0HzMWF4L3FFMixFyeMTEdAdfmGvEXH8m2O5dOqD2k8HILKeTY+x8IBZ8O1+bjgVLLAByhJAq7ur3qNUzbT7dtaK81KcXeaym2INIBqkVNHCvm7By2EkPgko6hLfPFXAslTO6ITU40yApbCp871G0rIQ2aAfFA70uSd1++XHi2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEQZh8WeEvcUsEJa8bGUDenVmBWBoBvoX5paXMrhcKU=;
 b=RXGhqgQ0V0QzZDSDS11/aFiM+uR0294WXTqHPW4gcEuqvyiDTcs0k6bZzwoIt/xwyexAsGmfTJDI0o9gOySSj8sIeSWyrZQYjoW7HZGbDHRz8d4RXqAhzV2c+weiwCFr3Vsdcl35R3xhcnwbAIaN2rJ2oC/23XaVx01wxCPhKFaciOIVP2B4HkgiaN0i+QJu+fUclRFWu8PrhTCWhfuVM69nAff10rv2yVItPkHNWJ1yXMqXqzN9BNm1EYVXDpLKkukkiTskP68YeW/S3eWUcsdRDcowKXHWn5grsTZK/zUzO/GO0thrTOPeLyMlcmG1l38mOdE/c773ZzRlx//3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEQZh8WeEvcUsEJa8bGUDenVmBWBoBvoX5paXMrhcKU=;
 b=apv9JtRm7c0jo/vxsBcPOw2tvYLWWYnF4KzlqERw3S69eQV12xygyTHOVHZR5JY/efQqaLkH8Iw2N4c0ayjYCE7nB2eCia+YoJqbataGZ1XekMaHFgmDpPI1p//4V4qTV1f51Gk8zLKdPB+deycZOB87cOmUEr5ARcC3mmdcLwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:48:14 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 15:48:14 +0000
Message-ID: <a45fac55-7bcc-bac1-7687-c56406d8d416@amd.com>
Date: Wed, 23 Nov 2022 10:48:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-CA
To: veerabadhran.gopalakrishnan@amd.com, amd-gfx@lists.freedesktop.org
References: <20221123145139.1944700-1-veerabadhran.gopalakrishnan@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] amdgpu/nv.c: Corrected typo in the video capabilities
 resolution
In-Reply-To: <20221123145139.1944700-1-veerabadhran.gopalakrishnan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::24) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: fa99d44f-e677-4b2e-9e3d-08dacd6a21e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2GeZcyiDDBcXjFvUaDMNj5W0VDP6O3GK8lZuFIq5pq5RcyzkJNFOgCY807i9oDy0fs6AUh51BrZ6WBqfKLICD+ZZCNWS8qvO5yac/47KxiJUryCEAOiEa7K3k8SLOYKxtGvu9weVtny/K1iebW3P1Ocs4Hs11F+ucRwLRE3Orx20H+xuFsQLTXw1nYBIFSnSiRzD5BFg7viFSVWc3rRFJX3Aa4ks2SdhAnLOmz5D+3NKcwNbvZVGG/pgpQ8V05wgMdZwLhiOEuGjj29xYsiGN2pP0zjV71Jk76lNPgwgPogec19oXFAQFWfgrK6BDSlUgBFaPMCLItQOA4k9+8ZiBtF8eGLKtqGidMOoyet1i5g95BIVU1JwV18z+NelPw2YzfT2j6qXYumHjH1IPO5+qy7b9eYp8jY082qH51icG2M8kbNCsvxx7ex6N4hIiP0gZuOJqnQlRpyVPhBp4YP875XRptsSmrP1u6ugqGybbMsiRiVW74Y4+lw7ILE0CIRPrORhNscW8/9RU6UVVQILXSzw9GGpkJZWPXHf7xbEwIIbApeSY4QyXBKBc1V30wujI20lW5CGuwoN5jIRgDDqUIjGGwvgJ+mzGa6aO9LGi/SEden9TfYU6pwV6FU1iA75S4brXk7Lf1dzg9idJpUYv5KISVNslnI0AeZuzV64oE0Nffdm7+7LVvKPtamFmgWZcF/H5u8EySA4vyASOR0KDqWd4I2IRyhav04Est3uGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(31686004)(36756003)(8676002)(2906002)(31696002)(4326008)(86362001)(8936002)(4001150100001)(5660300002)(38100700002)(83380400001)(186003)(2616005)(316002)(6486002)(66556008)(66476007)(66946007)(478600001)(53546011)(6512007)(44832011)(26005)(6506007)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhBc01lWWlCcS9pTk9iSGNHY0FMVG11ZXQvSE9SSUE1MTVJSyt5YUx3cDBz?=
 =?utf-8?B?aXNFNjFCTkkxd0RmbTRUMnFTLzB2b2RxOW4vSVUrcGEwOW5kODVpViswaGw0?=
 =?utf-8?B?dEx3TTJQR0l6TURjK2RKQ3RkYllRUnJiKzlHTXBuL3VmNW1taTFzcng0Z2l4?=
 =?utf-8?B?NkpUR2RxWkZuUGVEZjN0YUIyT0hweG1FcmlmMDlxa1IvWVl1OVFySUFadjh2?=
 =?utf-8?B?OVVmcFhvcXpQSUd2UElYWUxXWUlRbER5emRaNmhCYTZCRmJSRXk3Wk5GK1Aw?=
 =?utf-8?B?aUZ5TDF4amJ4U25IR01Tc2JKZ20xKzV6VGxiNndrREtzT2R3RExHanZrNXJ5?=
 =?utf-8?B?OVF2eW5zdXl6L3FnSGxWVFQ3Uk9yWVdtZkUrZTQ3YXNqZlRtTkRPK0JCZURQ?=
 =?utf-8?B?OTl0eEcrQjAyaGdjVWs2NVc4cGJ4VlNFdjdDbjFlSjFlN01MekNLWTQ2Y2JW?=
 =?utf-8?B?Mmllb3U2dDN3VW9RaHdWRGE0M1lsNVRVakJKNXIwQ2gyZGRLMWJ0cE11a2sw?=
 =?utf-8?B?cG5tNm1CN3RPMHFUb1ppSFZLMHIyMFEwZ0ZUUDRrdEVCWUtNRXNlQ3F5TTcv?=
 =?utf-8?B?ZmkxbGF0UWEyeCszUzNXMUU1cHFid0JGYldRUWptNXdtRURsTk5CaXpIV1Bj?=
 =?utf-8?B?K21QVlltZGxtRXBYV2t6YU13eGJZL1hBcU5Oa25PSmJTODJnclB0VkEwZVdY?=
 =?utf-8?B?TzMzZU91MDhqOWJyUk40bURPUEpxSElYdWNrenROQ24vc3R5ZFRzOExzMy9N?=
 =?utf-8?B?UHdMa0RKR0ZhOGxtUWRrc0NvWTJXQUliMk90cHZ2Uy9BbUVaMFBSQmpXZFNl?=
 =?utf-8?B?WlkxTFlwYkhkcDViNWtONy9iRXhyM1FhaDB5bGtLMjhXMU1YN21GS3BVRkNZ?=
 =?utf-8?B?a0xwSlcxWC9GeGtnZUphdEhtaFp4Z21lcjRubEtPcVM5eEY3LzhpWXRXMmEy?=
 =?utf-8?B?YjRNZ3NheTdkZ1VBVnhnWEVRUlBYeHIweHpUbGZwSkJZQUpHSkpjWE4yVmVN?=
 =?utf-8?B?a0g0cENmVnVoZDQzSGpFa2FlL1JSOFE2Q05OcW41MUxEOWRTYWpKL1cwZ1VP?=
 =?utf-8?B?QVhxdU9hRXNLcXYreW8xd3lMNDdTSWN1dW5nTHNGVVVhZzFZU3JvN3paWitr?=
 =?utf-8?B?YXFDUEZlRXBZcU9PVXcyVlJCbFVGZ1dRUmRvQVVuNjhjc0Q0b3hNcjd2NDd6?=
 =?utf-8?B?a2QwTTEwSkxTNFdKUitzMk9CYkk3Ym5lYVdWY3U5V0RSTGNTMStJWEllM21S?=
 =?utf-8?B?N2Z2dDhDcUt3Sm83MUhhQ0RqK2g2am90UzNabnNGRXVCaEdRMlBlOXVzS3Mv?=
 =?utf-8?B?RGlFNVNKcHRnSG1HMFI2cUdUNWZxUVg3NWdoanh3WXR3VXhBa3RrMUtZeGls?=
 =?utf-8?B?Y3poR3lLSXZibTlaVjNLK0FPSVNJTXZNKy95dUs3cTBBVGJuYUlOdlRtS2JS?=
 =?utf-8?B?alNjcDNuZTliOHRPaTdyS00vcEJEY3RBbjUvclBPUTZJQi9FMWtQa0Mwd3pM?=
 =?utf-8?B?d0RhK2d6OFdKQ21yQytNOUlwV3hXUVJhMWtTTGlVL3VBK2srcTBnWXN6ZGVE?=
 =?utf-8?B?S1ZYMEQ5VkpmMjZKV2RJSXlOeFhIWTR4UU1aK0txOHBhczRoR1ZuTC80djB0?=
 =?utf-8?B?WXg2R01YODZJbk8vcVh1VWlmVDg2WUhXU2cyUlRLWDBYYmtoazFtWGFaWU9j?=
 =?utf-8?B?ZmdwRExBNzBqWFZndXFvdERiK1Y4Q2NkaWFNck9CSmlXTkZNeTAyTkJLS0pt?=
 =?utf-8?B?blhNV0N3ek9YeThDU3RrN0xNazc5NGd2R1lCSUlpWXJldHJJVVpsbTBYWDVK?=
 =?utf-8?B?SkYyYmlsSldIb05sZ2d5d0d2L2hFWE9vKzBFTnpGbnlQelQ2VHpRWDNHSWEw?=
 =?utf-8?B?akhYeTRCTnNFRFhMYUFVMXNFZ3FjL0ZubHRXcGo4MDBHbmNSc29paTFhU1pm?=
 =?utf-8?B?cTFHdUthN1JzTzhMSUJCcDZjbERGZW1QYTJ3S3grenptcWVENE5XQlhWb01I?=
 =?utf-8?B?VUxMaFVPNzA5WG54QkZwV2xrTnFyWGplelV5WnhJU0Y0Rm5QMTF5VGo1YjJE?=
 =?utf-8?B?NFVxVkhnelp5bXpLeXQ5VHhxOFRPRDVTN0RDZXUvT21pckQvT0dSeEhERldr?=
 =?utf-8?Q?RBG1xgr7H+/zAC1Or5bCuHe2I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa99d44f-e677-4b2e-9e3d-08dacd6a21e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:48:14.6807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECIT5PAHa2Rbk9j5KaDp/igzNgwi39vkdFjN5Opg2wEeChrVJbap0R28PWACSDsp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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
Cc: Boyuan.Zhang@amd.com, leo.liu@amd.com, "Koenig,
 Christian" <Christian.Koenig@amd.com>, thong.thai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-23 09:51, veerabadhran.gopalakrishnan@amd.com wrote:
> From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
> 
> Corrected the typo in the 4K resolution parameters.
> 
> Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Please add the following Fixes tags. The first is where the 4906 first appeared, and latter
is where it got duplicated.

Fixes: b3a24461f9fb15 ("amdgpu/nv.c - Added codec query for Beige Goby")
Fixes: 9075096b09e590 ("amdgpu/nv.c - Optimize code for video codec support structure")

With these tags added, this patch is:

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c    | 28 ++++++++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 24 ++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/soc21.c |  2 +-
>  3 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index b3fba8dea63c..6853b93ac82e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -82,10 +82,10 @@ static const struct amdgpu_video_codecs nv_video_codecs_encode =
>  /* Navi1x */
>  static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
>  {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
> @@ -100,10 +100,10 @@ static const struct amdgpu_video_codecs nv_video_codecs_decode =
>  /* Sienna Cichlid */
>  static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
>  {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
> @@ -125,10 +125,10 @@ static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] =
>  
>  static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array[] =
>  {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
> @@ -149,7 +149,7 @@ static struct amdgpu_video_codecs sriov_sc_video_codecs_decode =
>  
>  /* Beige Goby*/
>  static const struct amdgpu_video_codec_info bg_video_codecs_decode_array[] = {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
>  };
> @@ -166,7 +166,7 @@ static const struct amdgpu_video_codecs bg_video_codecs_encode = {
>  
>  /* Yellow Carp*/
>  static const struct amdgpu_video_codec_info yc_video_codecs_decode_array[] = {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index e3b2b6b4f1a6..7cd17dda32ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -103,10 +103,10 @@ static const struct amdgpu_video_codecs vega_video_codecs_encode =
>  /* Vega */
>  static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
>  {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
>  };
> @@ -120,10 +120,10 @@ static const struct amdgpu_video_codecs vega_video_codecs_decode =
>  /* Raven */
>  static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
>  {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 4096, 4096, 0)},
> @@ -138,10 +138,10 @@ static const struct amdgpu_video_codecs rv_video_codecs_decode =
>  /* Renoir, Arcturus */
>  static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
>  {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index b258e9aa0558..5f19b85ccbb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -61,7 +61,7 @@ static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode =
>  
>  static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array[] =
>  {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
>  	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},

