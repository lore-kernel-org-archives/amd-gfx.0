Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE39C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 15:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F271161157
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 15:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F271161157
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810A96E8AA;
	Tue, 28 Sep 2021 15:33:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0DB6E8AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 15:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSIPeut7sDIkD+yXCzP8+wZvBbPac31ej7vl9NUp2E9Urqduo8Dp0pMeroXel9NSwTafrlj7mIle7oanjNZ+h8CXHoYFGQ4Lojo8FtzXSQ9+fCxn8iSA6Jao0nQCqgkH5/LxumgIQxcSP40vLVhENnqvKmgpoMx5cb4ySFdAA3cbSer44/92mqPl6Cy3vqJix7FJ6gtkDEuaEsdnokhKxUPPWlZRC5AUcGl9hhXZ0bwYe3ylcrPaRcyIaZNtI94q2GMZVLqHNuTaLNdTVTp6k2u0qlCzb7ENFfld6+2NS0Vp3NB6jnqdeJg1v1O40ka4RiaPtDXyTyemUmXOS1nLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=hx3HTZGnY/9SD7naNo1ZPi7P3V7uPn7ILTUUFu4CoSo=;
 b=HDB+DhV5GZWb21+IOBZ2WLiSgFeG1+UMMlhmKvMwFx+do5jEs4UqgwwdSzlx6QOMkcO1GL+c9qJ18qRCw5bGykyDv7mMweNGrwCaEZAyDLAAAU7SRKfdIwnCNpC29UmRImIuY1yd4xNSbEGs6eF6tGRCRUI3mezpXUH7/EhEov5QulX8krSq7dFS/801M0127anZAdq+7o8WZxKmMUxm6Lwxp/Gm4AWSXkOQ0rPlTWQBylpffFLhrtnmb27tMaGWRVL4GQ7paPRE/4Zqgv7McBFwBLyYtEN8seEYfx1Z1Cl6pOqJD0CHu1VQr5iDghUikd688vBJ3/3sL4ZnaB8v3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx3HTZGnY/9SD7naNo1ZPi7P3V7uPn7ILTUUFu4CoSo=;
 b=aYJkurb3WL1vwK/eRKb9V2WDkQ3bROLfb6cw/EGBXKRNQnESrbmv5VkwUPMPrFOx0tvMYVnnbbT96yHsmxFNU6Z3Hdk+z4IlCndXjqiFEUxg92dPpbCO6d7Gcyl1Q6qTOhNpyna2ek0yj4HksVq0TvP3mCP11WYdaL40+5sWWM8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 15:33:23 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 15:33:23 +0000
Message-ID: <9d108c14-acc9-be67-c785-f67a741d6c78@amd.com>
Date: Tue, 28 Sep 2021 11:33:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] drm/amd/display: Align two DP2 headers from drm
Content-Language: en-US
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210925133807.684459-1-Jerry.Zuo@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210925133807.684459-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0134.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 28 Sep 2021 15:33:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6bf705a-1b53-4799-90a7-08d982954e9e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54753F14A830E684B76D74A48CA89@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/A8vCP76iSkEyE5/TBb/6B/gYFbcIyIT8FIzEZyuxWV8Ufe2rqUhyfYwJgkHEKrUxVyGdu9m0SekDt4GmdN9ItbiWrSrMJ++Vv6zUlcbUzyZDKRhPTNRPZkB2nExpRWriTR0gUdp6jdDsbE8yoeH5s69ewgBXxhsKWHuXrh7yVVjAAhU3ZLicJRDLV9cnpJ2QMbdTPwiEqmFKEiuM2enb+JF0+5GDjxHePTWGH7R767V8eWyp92hA1JRTYHCv41eEfV30rysSTgUlN4hFl1iuGaSN9z5LeNDGWmbKTbuXmbND7vDlXWeo6ElpnYhNpikPMKZN7ZzXBv3D4H8blb+5jmeDlAHAr1FsnQrokrps9N9y1k63y7mkLizG36FG1xOTIcbaJyY3uBSYBjuvj0x+8AmEDWORlFhvdFH04TQ/Sp9ZtJHiezKRknffDMGe0nnh2sffE77QDXF0cXbglekMFR9QzAKFUyZ2N/gIvdYIqETTUZ2ueyevFwZoboEwVK/USDd6dzDW5HGXJPLqsmF1YX/yUPqHt+5L4EOCOvcpaAOCWTXU2Ry8HIbnb9QLbnHV1dULk/GeX06ugYQR9UH4+VHdPgV1ryYiJaxllbP/1Ycv6hRF4nJRLFZX1aAQvBdXcY/Wtn3kv+FrOYuhw2Avblqpl9y7m7Q2zhhGo0HWOJQhnLbhZvxdPUeC8K/x7B88fX+66sxRYmfYocp6QOxmCkIoC2Wxgr0wvq53fHx8CGscd7OazyPgtwhHYySZpr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(86362001)(6486002)(956004)(31686004)(38100700002)(508600001)(8936002)(2616005)(6666004)(316002)(26005)(53546011)(83380400001)(66476007)(186003)(36756003)(44832011)(8676002)(66946007)(2906002)(31696002)(16576012)(66556008)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JqZHQxM1NpLzFBdFlaUE5FdmRIOEVpTVdXMTZtY0plUjljQ3cvRTFOMi9j?=
 =?utf-8?B?QjVQT0QwbzNub1lGRHRJcWlZMkVpbVlEbUEwQm9aYkY2QTQ1anoveWV0L2tv?=
 =?utf-8?B?V1VOMjlGbnVqKytWUEh6bHJIeTFDbkU1SGxMVWFmL2ZNSEFNUG5lOGw0YkFu?=
 =?utf-8?B?NEo5UE04OUJpTUI1Uk8reElLdG44WU9VNEZBaU9ISXNBN3VZSkdBalNDa1pm?=
 =?utf-8?B?R2NJcG9rSldvQ2xCSWs0SStZTFJHWHdXbHVIWnhiQXQ4WitoOVFlUmxIeHk0?=
 =?utf-8?B?elprZitSdmlobW1FcGhjbVlicE1YVmg2dHVLa09mODZrNE5DN2xnczhRZDh5?=
 =?utf-8?B?YXQ4N1NsRVI0VzJDUHNpSlVnanRiV2pMaGF5NUVCSTNiR1dlbTVmdjVyTk9m?=
 =?utf-8?B?eVVVQWR0OTQ1K0RzSHVPbjB0M3I4MzYzNVhGSVJIMXduK1Rxcmx6MTgzRnFq?=
 =?utf-8?B?SVhhak1tMjNteVFWOGUza1VjaittWUlJdDRBajFPd2d2Z2w4UHZyT1dWU1dG?=
 =?utf-8?B?SldSUjRHNXhBc0M3K1U3cjdVbGpWSWE0VmhtYTZTQlJWWmlVYVRpTG9hUk1Z?=
 =?utf-8?B?SGN1dmNaM2taRTc1aFBocjdTbHlielJ3TDB5VExzek9wNXlFckNCYkQ0cytN?=
 =?utf-8?B?aCt5anA1enNoa2RuVVVGdU15V3BrZE8zMWwvV0w1R2R1d0RjVDRxN0ZwYmI3?=
 =?utf-8?B?OUpINlFGdllxL1NoQ0FrTTlSS295WmxsLzNmZ0RRMTJMamFRSjhMVHc3L2Ni?=
 =?utf-8?B?REs5eVVJblN3OG14RDBGei9HYTZhQlZsc0hIai8vS2REVjRNWUFDc3VDUnJl?=
 =?utf-8?B?RHZVRUZaZFB0ZmJHc2JIaTdpUTRicXVUOTU0aFQ2WllDQ0dpd2w5L2hiNnVC?=
 =?utf-8?B?ODN0VzEzNDN4eDRWT3ZjQWJOTEpoWXdLQ1hsZS90VjJBbHptcmFrSW9haUwx?=
 =?utf-8?B?K1EyQThwbktkdDVZb2RDdGhlaFJvNWZBVis5d2hNcFpIaUZrbURheTVQTEg3?=
 =?utf-8?B?NTNRWms3V2VTY294dmI4WkZtQncvamVLcytrbjB6Njc1c1dreDRJU0dlQXk0?=
 =?utf-8?B?WTBaTDRwQ1NCTjVWaHdqZDVUbEpUOEpBSXZiRlNabGZ3VDIyWHF5c0w5S3Ev?=
 =?utf-8?B?TnprWlE3dzFGME5CeWtmMzB0Ti91RWNac2E5SXkxaVRCL2lZdjYzRVJmZXRy?=
 =?utf-8?B?NjZ1aUpMTkhZeDlBN2ovMDNuWDBNSWVla2dydnlNUzdhY0YzRS9LS3dmMlZX?=
 =?utf-8?B?bUZGeHIxT0RUUmJsSkh5bXJ4eVMxbytpbFFuOGdpVitDZzVSN2VFa3AwY2Nk?=
 =?utf-8?B?NGJvV3JTNFh4WmxvZWdTZktmL0VVbXQyOXRLR2VTa0w3VWZpQ0NqNnlJcVE0?=
 =?utf-8?B?MGpBcE1UaWN4akI2RVhncTdKRW1LTDZxTHZZVUFYOTNCVENBSGtOeDJvOXhx?=
 =?utf-8?B?QW81RGl4ejkzdU5lcUxmUFJSblVqQytRdVhheHh6alFDdUd1cExKdFFZMklT?=
 =?utf-8?B?RzNsa2dVbVNUWURwTlYzSU00RXNYR1V1RFcxaWlzNmpUUFErRW9iTjI5UnZC?=
 =?utf-8?B?RUk4V3piR1R2TmVlK2NlT3VzOU16UUN3RUNrR2NsblhibG5rWkRBWUJxRFcr?=
 =?utf-8?B?RldBYzJ6QlY2OUMvTVFaWnFBT3h3eHVzbyt0YkVUbnZkNWVCUFcxMjZpM2Ru?=
 =?utf-8?B?MzlIZGZxU0Q4QzJmc3NhUXcrVHVTRGcyVEEyNmp5MnRqanFWQ0dxUzZkVHRX?=
 =?utf-8?Q?DvSJcbg2qOyH+lJfkqJFIJ5Gk8Na3RxN83Euj0c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bf705a-1b53-4799-90a7-08d982954e9e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 15:33:23.2180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0X4TrrGpMnx1pWqImdsNa2Puisjx3G3kvlYT/zcIWH+y86MtnAbzw0qZDTQ6+8r1aj/H8MZuajF4X7S41FYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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



On 2021-09-25 09:38, Fangzhi Zuo wrote:
> Two DP2 headers are available in drm that local ones should be removed.
> Will submit a separate drm patch for all other DP2 required headers.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 10 +++++-----
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c |  4 ++++
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |  7 -------
>  3 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 120c9955cafb..6be944ac46e2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -146,7 +146,7 @@ static uint32_t get_eq_training_aux_rd_interval(
>  	if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING) {
>  		core_link_read_dpcd(
>  				link,
> -				DP_128b_132b_TRAINING_AUX_RD_INTERVAL,
> +				DP_128B132B_TRAINING_AUX_RD_INTERVAL,
>  				(uint8_t *)&training_rd_interval,
>  				sizeof(training_rd_interval));
>  	} else if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING &&
> @@ -2107,7 +2107,7 @@ static void dpcd_128b_132b_get_aux_rd_interval(struct dc_link *link,
>  	uint32_t interval_unit = 0;
>  
>  	dpcd_interval.raw = 0;
> -	core_link_read_dpcd(link, DP_128b_132b_TRAINING_AUX_RD_INTERVAL,
> +	core_link_read_dpcd(link, DP_128B132B_TRAINING_AUX_RD_INTERVAL,
>  			&dpcd_interval.raw, sizeof(dpcd_interval.raw));
>  	interval_unit = dpcd_interval.bits.UNIT ? 1 : 2; /* 0b = 2 ms, 1b = 1 ms */
>  	/* (128b/132b_TRAINING_AUX_RD_INTERVAL value + 1) *
> @@ -4593,7 +4593,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
>  								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
>  
>  		link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.raw =
> -				lttpr_dpcd_data[DP_PHY_REPEATER_128b_132b_RATES -
> +				lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
>  								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
>  #endif
>  
> @@ -4875,13 +4875,13 @@ static bool retrieve_link_cap(struct dc_link *link)
>  		link->dpcd_sink_ext_caps.raw = 0;
>  
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> -	link->dpcd_caps.channel_coding_cap.raw = dpcd_data[DP_MAIN_LINK_CHANNEL_CODING_CAP - DP_DPCD_REV];
> +	link->dpcd_caps.channel_coding_cap.raw = dpcd_data[DP_MAIN_LINK_CHANNEL_CODING - DP_DPCD_REV];
>  
>  	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
>  		DC_LOG_DP2("128b/132b encoding is supported at link %d", link->link_index);
>  
>  		core_link_read_dpcd(link,
> -				DP_128b_132b_SUPPORTED_LINK_RATES,
> +				DP_128B132B_SUPPORTED_LINK_RATES,
>  				&link->dpcd_caps.dp_128b_132b_supported_link_rates.raw,
>  				sizeof(link->dpcd_caps.dp_128b_132b_supported_link_rates.raw));
>  		if (link->dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR20)
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
> index 7f25c11f4248..ff06d6060e9a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
> @@ -127,7 +127,11 @@ static uint32_t dpcd_get_next_partition_size(const uint32_t address, const uint3
>   * XXX: Do not allow any two address ranges in this array to overlap
>   */
>  static const struct dpcd_address_range mandatory_dpcd_blocks[] = {
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	{ DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV, DP_PHY_REPEATER_128B132B_RATES }};
> +#else

This seems to be somewhat unrelated to the intention of this
patch. Is this something that we missed previously when upstreaming
LPTTR support?

I recommend pulling this into a separate patch, if possible.

Either way, this is
Reviwed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>  	{ DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT }};
> +#endif
>  
>  /*
>   * extend addresses to read all mandatory blocks together
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> index a5e798b5da79..04a71e10bb97 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> @@ -860,14 +860,10 @@ struct psr_caps {
>  };
>  
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> -#define DP_MAIN_LINK_CHANNEL_CODING_CAP			0x006
> -#define DP_SINK_VIDEO_FALLBACK_FORMATS			0x020
>  #define DP_FEC_CAPABILITY_1				0x091
>  #define DP_DFP_CAPABILITY_EXTENSION_SUPPORT		0x0A3
>  #define DP_DSC_CONFIGURATION				0x161
>  #define DP_PHY_SQUARE_PATTERN				0x249
> -#define DP_128b_132b_SUPPORTED_LINK_RATES		0x2215
> -#define DP_128b_132b_TRAINING_AUX_RD_INTERVAL		0x2216
>  #define DP_TEST_264BIT_CUSTOM_PATTERN_7_0		0X2230
>  #define DP_TEST_264BIT_CUSTOM_PATTERN_263_256		0X2250
>  #define DP_DSC_SUPPORT_AND_DECODER_COUNT		0x2260
> @@ -877,9 +873,6 @@ struct psr_caps {
>  # define DP_DSC_DECODER_0_AGGREGATION_SUPPORT_SHIFT	1
>  # define DP_DSC_DECODER_COUNT_MASK			(0b111 << 5)
>  # define DP_DSC_DECODER_COUNT_SHIFT			5
> -#define DP_MAIN_LINK_CHANNEL_CODING_SET			0x108
> -#define DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER	0xF0006
> -#define DP_PHY_REPEATER_128b_132b_RATES			0xF0007
>  #define DP_128b_132b_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1	0xF0022
>  #define DP_INTRA_HOP_AUX_REPLY_INDICATION		(1 << 3)
>  /* TODO - Use DRM header to replace above once available */
> 

