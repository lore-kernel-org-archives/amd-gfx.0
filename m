Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852FDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 16:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCC810E162;
	Tue, 25 Jan 2022 16:41:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F0A10E162
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 16:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM4ZW4i2muB860RJM8iyZ2G2qvzSgpTdLicqJk4WXEiXldwbAwTD5KkxSyInmHCdhLnhhsQz3YDWW2Co27vSlLWK9DMW0VFbRTVRW+G8F2/tJcstSah1o7VNcrmMnGtmpFhuT4UwNkeuPdc3DnXCdXXfavnwvMDOJU5eraeL9EV2jQ1xLVHfS2RFYuUQOKray2V1TjGEvkJDhqeIezFJa/OhoqjHgNlrUCSPKSU9qFmy8VVvKOAARJWRZBwV9vz0Wyi63ZWJTdReZeKslLHU0zf93nb66xydI+ZQtaYdQ5XhJE40zDhT3AlzWhknnEd+armId0uNyBYCF/LuBK7kYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV4Lc1Ky0lMKEmLSYVoN/D3PvOJjRE+RrRn6bTeubOk=;
 b=AujKyRVh+wsya9lZFtbsQCuLM3lNqRu/bT++LU8fat5x+LO+Y+5k4lnJfTMjzonftTXJ47WMxG560Rlgpofg6pPPpwsHLdCccteakPE+sP4t/ydqxq43/Ozp1qpq6sHZjJLrgI8wsUHbs5LtpF0FzAZBQCTEYdxKItqJ3tnglgvmR/lbS4PDFm6wvEtzs2DOhZCdrdpw0c5g2w3wklrl7VJ55QXvYOcI/l0RM9oZDrQNWvWuY0o/g+eweHQQJKdjPc/k0t6MSrdvFL/KGlKwaVWvudn/ztp3HnnBXcRzUgnhknKQVvXy1GxaEjPKDVswjcLI7GyDqq0xfqj7ugZv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV4Lc1Ky0lMKEmLSYVoN/D3PvOJjRE+RrRn6bTeubOk=;
 b=PRsaBZ3ljKbtRpQzlwaVk2gBVbFzXP6ACmbEy6YQVC4i3vd/0aaNbCBgSeUxX/orINFS0KBY0i2aMte9kZRrklGE7Exe02vCt7mJeV+bwkrD0EdmiU11mE0xii+13rNryR9IJNwfrcOZtixiajHK0ZIjBMy/jER/FEDvBEetWEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 16:41:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 16:41:41 +0000
Message-ID: <6e8a51fd-16f7-d80d-7b48-21462a70810b@amd.com>
Date: Tue, 25 Jan 2022 11:41:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amd/display: Add Missing HPO Stream Encoder Function
 Hook
Content-Language: en-US
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, wayne.lin@amd.com
References: <20220125062507.1569727-1-Jerry.Zuo@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220125062507.1569727-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::44) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69b2d44c-32ba-48f6-5f3f-08d9e0219088
X-MS-TrafficTypeDiagnostic: BN9PR12MB5209:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5209AD77B2BBF179E4A0897E8C5F9@BN9PR12MB5209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmdGVfB9UxCOFI2Fi58aHXoQyf0okb7O/CeU9IOsanWvqgQ2Dot/0t++lNDDDlNZZcpq4mDt9omEXHgAdZaCFWb2b7WqrEhJkrwlwTMJvKDRJRKs2DY69nz5TvU93SGLCOJaBn2rLQwNsSInjkGWe6omt3vBnXdgMR1tkYfm1f9+2ec1bl9yPjr9yigcrMq2si/AwmALckLlewZwBE+3TYeFUQkVYF3orH/fVEM1cxKAJ2q/UzG/7y8NfXtqhoit9DG4fBYwu/d494AOyAM0cYt65GDplS9mxfvK3F0pqewJUgXBU0BxGZDN3iTPNlyfnnVj0q3DtCOIyqEp8GTK9pu7i2mYIc1ET3W3tA0ixEfqAgOHu1CpwxI1MMGGXM+mLJmG5G27w7coDItdXfylI4kDUdY84Gl8Xt18BVeSBJPj0CSdtjJtMzTLU43EKZIrjQ1etU16VJ6Ax/ImLlfvfWUmFKSRaezAqQTwlntpBhUN0UVYEQXToCWc9GvG8OVJgBCqw8LQOaGKCI5hFsYDo7jFh8MH/v52xgNShe/GW1FN35SPgIFnxKx78l7q/mmbrdmiDq8PSxg8ETy9ol7b8Oszh0HKO45NxSGViiAZHsDW3GtVN8gOGltOuF6nz7hpk7C8H6Mn4Qy933+nHehzwMcdkgfeG5AfHt6LxO2+YCz4l8lNUOKzJQxqK5EiFgYuBavNou8GUPxvf2EIEY9F+ivOK7ztWfj4+PuduFYAaDO8dzNwY4zDffkJarXKTwBg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(38100700002)(316002)(8936002)(8676002)(86362001)(6666004)(36756003)(44832011)(26005)(508600001)(186003)(83380400001)(6506007)(5660300002)(2616005)(31686004)(2906002)(66476007)(66946007)(6486002)(6636002)(66556008)(31696002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDRUQllmdGRBY2VYakFMWk5HT1k5MXF1cWpyN1pBczJjQ3FzS3ZzWGtPaWZP?=
 =?utf-8?B?TG44dWZINklTdGltQjZrbXNHbWVDc21FWnc0ZzRkTkt2cGZlSEFjZ1RFakNM?=
 =?utf-8?B?LzNGZTducUplZGV6Z1E0S2w5dWJOU1JueGdnSjUzeEo2K1JuVlJ1ZmFYenJk?=
 =?utf-8?B?MGJiUEVIU3dnV2d1ZWhFUEFUK0h4ZTNpMyszd2VycjZrb09JSXh6NGVaUERU?=
 =?utf-8?B?RXpxQk9jRTBFb3Y3TGhmZG1qeXg0NWNkaTl2RkpCMHdXTkJWb1dZTVJDREEv?=
 =?utf-8?B?ZlR2U0dxcXpqVllhMkp4TW9TQUFVWno2ZmlHU2FqTWsreGF2UHkrRERrTStU?=
 =?utf-8?B?dkxRTDlnZS9BR2FTR0gzSytwV0lKWXdyQ1VMTjNzZFJNczd6OFhDU29GQlls?=
 =?utf-8?B?K2pRZkZTT0ptS3BEZFI5bTBlMkJVRkNQbWRwNXRBakJ6VmNMNTViM2VxWHlM?=
 =?utf-8?B?Z2lCT0tpb29ROStES1BocGNuZTV5b1dwajJ2K0VZM016L1YyaEpDemxqVitx?=
 =?utf-8?B?VGpTQVAvMkhZTExFbkdpN0p6OG44Zzgwb0lLOXZxT0t1SnJxei9TRE8zT0I4?=
 =?utf-8?B?ejZQYnFwQzBuN2szdEh2MThqL0RRa1g2cnlCZTVBRnFkaldMWER1ZWtzbTNR?=
 =?utf-8?B?V29hb1hkTWVZUW44SmdDTk4vaDdJdTJEcnMycDhZWUJpdWJPZGNwdGU2Vzcx?=
 =?utf-8?B?T1lnaGh6d0JoQ0traWlSNlIvakFkYnNGbkhRelN5dWMvQnkrR2VvSlBENXBq?=
 =?utf-8?B?N3NXNXppVi95Vm56L0wrMkhmQ3hpdks0NzNocVRVWDk1dm1GYXFyWEc4ZWFX?=
 =?utf-8?B?UWRsSFdmYU1ZNncyUTdVVkRkeUppR2ZQTVcwN2gwTmZoTnYvTUhjNCtielZG?=
 =?utf-8?B?SnVsZlRBcFdaRzFHaUdVVEUrVEpxTTVpTFRPVFV2amRHeTZ1MXB4MFhjeS9G?=
 =?utf-8?B?Sm9BNTFoemVsNWY5QU5Ha1RwWXpFZkYrd0t5YThxUEJBaU9nQWRFOTR5NDRE?=
 =?utf-8?B?ZmZjVzJ6dEVObDZiNEhQUWNPNVlqWGE3V1ZUQnVDVVkwWmxtenpVdFhDS05W?=
 =?utf-8?B?Ti90K1ZENXlqYnhHMFBFQk1BbDNEdzFMekhOMzZoTUtXT25meURYa3M5eUVn?=
 =?utf-8?B?YWJpUWI1VVFMV2ppalg4YzJSYXlrR2lnU2p1TVYxak1abkNWbldqcXB0WUFF?=
 =?utf-8?B?Mk9FQXZIaE10Rk1lL05WY3MvY3Rrd0laZWt5NVY4SDc2bkRDcTdybDZ4aW9o?=
 =?utf-8?B?VnBnb0NYSkx3VGxmZnEvOWtncEgzR05wNlM5Qi8wTjZuSVZFblUzT2VKY0hS?=
 =?utf-8?B?NFA5UzFQVENIcXpxSFp3d0U0TURZR2Z0ZnpoanptL3lXeXBGdThycWU0c1V1?=
 =?utf-8?B?U0MyclVydXpnY2ZLaHVSUmJITEYySXE4ZzVmVm9lYXAxTW1qcDJudXlZdDRp?=
 =?utf-8?B?am83UERZTGlWZEZXSEYzaWpUSHRDS2d5SlJZek9GVXZkdVdKakJsYTB6ZkJi?=
 =?utf-8?B?UTNMWmRzYWJQbWtDZHg5d2xTN1NCaWdjbW93aEErcTJoTmlxTy9kM3VwaVFw?=
 =?utf-8?B?OFpOdTZJRytLcUJvTFVnY3ZWM0lZNW1CbURVaEwyY2UwOSsvZ01tM2ZNS0g0?=
 =?utf-8?B?TVpZY2VUKzkwTmVaWXpiditjaFpSUUI2OXNSOG1BdkpNeGd6a0dBYjJzZTU0?=
 =?utf-8?B?KzdkcUJUaE1KRVZFMDA3eEF3QmJSUWdIU1FXYjhqaGxUTGdycU53WmFQUm91?=
 =?utf-8?B?eGxPQlR2UHV3bDY1VG03d3FhclR5UzEwUWp3K2FqazRmWTQxYUlhOUphNTVT?=
 =?utf-8?B?VjhDenppNkNVT3djNW0yR0lvQ0FhOG0wRFEra0tJdEZhNGQ5K3NSU1M3RU9h?=
 =?utf-8?B?aG5vRkZuc1hmNUVBQlVtTXVic0ExcVlkU29yRkQxRHFsU3RranFlRU5uZmtv?=
 =?utf-8?B?dUxaZm9yR1d3Vkd3ZDdvQVZpVGthbzNvYTByV3NHZTB3dmVCM0x5TXZzbGZO?=
 =?utf-8?B?UzV1aXlSN0U3bmVJbS9qNGJCczliWXR4NEFEWkZ6QVRNMHZUMy9zdzAzRVRh?=
 =?utf-8?B?eE9JK0gyQktrcUYvYjN0dFptTUIzVERIL3hJclVjQlltaW9ra2thbm9ZYldV?=
 =?utf-8?B?WERGV3BkK3NjcHFWR2NZaTZvbTBSSlpId2NMNkRTVktwakpNSHh4dTluUVlC?=
 =?utf-8?Q?8fGgiAb2yVTy2sl46Npbyfg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b2d44c-32ba-48f6-5f3f-08d9e0219088
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 16:41:41.7565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrcz9w0rRmVN5QSlMiAbsO+udPJq+G4gkTWs/Xo/7sVcCjqzLZ58LaPlDArFsUZUIT8YNzp1kcIxhPKFcBzf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
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



On 2022-01-25 01:25, Fangzhi Zuo wrote:
> [Why]
> configure_dp_hpo_throttled_vcp_size() was missing promotion before, but it was covered by
> not calling the missing function hook in the old interface hpo_dp_link_encoder->funcs.
> 
> Recent refactor replaces with new caller link_hwss->set_throttled_vcp_size
> which needs that hook, and that causes null ptr hang.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c    | 11 +++++++++++
>  .../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h    |  9 ++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
> index 5065904c7833..23621ff08c90 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
> @@ -710,6 +710,16 @@ static void dcn31_hpo_dp_stream_enc_read_state(
>  	}
>  }
>  
> +static void dcn31_set_hblank_min_symbol_width(
> +		struct hpo_dp_stream_encoder *enc,
> +		uint16_t width)
> +{
> +	struct dcn31_hpo_dp_stream_encoder *enc3 = DCN3_1_HPO_DP_STREAM_ENC_FROM_HPO_STREAM_ENC(enc);
> +
> +	REG_SET(DP_SYM32_ENC_HBLANK_CONTROL, 0,
> +			HBLANK_MINIMUM_SYMBOL_WIDTH, width);
> +}
> +
>  static const struct hpo_dp_stream_encoder_funcs dcn30_str_enc_funcs = {
>  	.enable_stream = dcn31_hpo_dp_stream_enc_enable_stream,
>  	.dp_unblank = dcn31_hpo_dp_stream_enc_dp_unblank,
> @@ -725,6 +735,7 @@ static const struct hpo_dp_stream_encoder_funcs dcn30_str_enc_funcs = {
>  	.dp_audio_enable = dcn31_hpo_dp_stream_enc_audio_enable,
>  	.dp_audio_disable = dcn31_hpo_dp_stream_enc_audio_disable,
>  	.read_state = dcn31_hpo_dp_stream_enc_read_state,
> +	.set_hblank_min_symbol_width = dcn31_set_hblank_min_symbol_width,
>  };
>  
>  void dcn31_hpo_dp_stream_encoder_construct(
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
> index 70b94fc25304..7c77c71591a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
> @@ -80,7 +80,8 @@
>  	SRI(DP_SYM32_ENC_SDP_GSP_CONTROL11, DP_SYM32_ENC, id),\
>  	SRI(DP_SYM32_ENC_SDP_METADATA_PACKET_CONTROL, DP_SYM32_ENC, id),\
>  	SRI(DP_SYM32_ENC_SDP_AUDIO_CONTROL0, DP_SYM32_ENC, id),\
> -	SRI(DP_SYM32_ENC_VID_CRC_CONTROL, DP_SYM32_ENC, id)
> +	SRI(DP_SYM32_ENC_VID_CRC_CONTROL, DP_SYM32_ENC, id), \
> +	SRI(DP_SYM32_ENC_HBLANK_CONTROL, DP_SYM32_ENC, id)
>  
>  #define DCN3_1_HPO_DP_STREAM_ENC_REGS \
>  	uint32_t DP_STREAM_MAPPER_CONTROL0;\
> @@ -116,7 +117,8 @@
>  	uint32_t DP_SYM32_ENC_SDP_GSP_CONTROL11;\
>  	uint32_t DP_SYM32_ENC_SDP_METADATA_PACKET_CONTROL;\
>  	uint32_t DP_SYM32_ENC_SDP_AUDIO_CONTROL0;\
> -	uint32_t DP_SYM32_ENC_VID_CRC_CONTROL
> +	uint32_t DP_SYM32_ENC_VID_CRC_CONTROL;\
> +	uint32_t DP_SYM32_ENC_HBLANK_CONTROL
>  
>  
>  #define DCN3_1_HPO_DP_STREAM_ENC_MASK_SH_LIST(mask_sh)\
> @@ -202,7 +204,8 @@
>  	type GSP_SOF_REFERENCE;\
>  	type METADATA_PACKET_ENABLE;\
>  	type CRC_ENABLE;\
> -	type CRC_CONT_MODE_ENABLE
> +	type CRC_CONT_MODE_ENABLE;\
> +	type HBLANK_MINIMUM_SYMBOL_WIDTH
>  
>  
>  struct dcn31_hpo_dp_stream_encoder_registers {

