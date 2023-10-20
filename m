Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07211C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 19:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DB010E5F2;
	Fri, 20 Oct 2023 19:11:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6EE310E5E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 19:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBwh2bQFZUVYT+G/1k1qqFTrt7a7rh+/lQmM3KWXMMkTwtALvP+XBekOdACbZ+tqLx1koBHkNuqfZ0hfblHFRtyMgSPoEZStU86fsryfCq45bdbyzPZJTH8K5xMogyxZrWt1RQaV6InHKqqFWgaqRdyZcAVh56mqCmyxuCwJyntZ8JTgx3nytlwy4R++Yl0hBqJ8tEAjLFrgev0r7q28D8z37ABwHMRATYJ14Oxos3sHAr6Y4+psAdRgllijzZqkMyuCIi60F9hn74ex0YwyB+/SBp0MEH7DEO8ipE3oFKys3R2/M0lVzshbhUOyFdGnfWLVs4mgdTHluCzvtN7stQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCUWikHOTlcCbz0/BPlJb4mok7RWwfcTn1icwaNBDj0=;
 b=IZtN98/+to6mTPbhBScFj+iRrkCYX1Z84H4siKTUctX3Z2i7mHOLFYpp1LYwtOM6tfL+r+WyI4+HiDEMWfgE1nw+4k1A/M7OhkgtesNa8hu0jccC8n/ahXyvkA+Qpg3Bg/4CtOplvrQrvxWWLlFM95KoC1tkAAjbY8mg1FPYSQUTcoPGerTyHhxwCS7gXahK5YOLfmGN+gyULVLphrL5tNl5YU6NYY+bcV5r2YEKzaidzfhSQm6yrLMwyYmZytmaTfGAh8vbf9s+KbHhQEBF/lx4Lw34xiLFlZt7f+aIfwMAptUvDQxehVZ8jpksNPiMhkBfxmBQxZXLex5gPmDIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCUWikHOTlcCbz0/BPlJb4mok7RWwfcTn1icwaNBDj0=;
 b=sQOmm5bRWndDY0M+/6aE7C85UAn5WUPrX4rkbWukPn9vXKW6FBf9l3CcNwYvekw9zeOP/ZOwKjcWn2+6tStw4KhTm4vzcIgimd2hGEz3zV7vnS99gT/8l6Ot0u5roMLy7PX5iKy2KAPYNk9YLZYyHrK0C1NmAlxepV/VNPd83U4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 19:11:15 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 19:11:15 +0000
Message-ID: <0ef7f000-bbd9-4b0c-b5e4-fb554091f33e@amd.com>
Date: Fri, 20 Oct 2023 15:11:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix DMUB errors introduced by DML2
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231020164241.463789-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231020164241.463789-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: ead4aad5-4111-420e-6f22-08dbd1a054ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRVodfwt0VUterAkDizbNYSzbywcXJDatPwQPXYP/IEwxkq1BBZP7fUntx4sbumGZRNbo1vR+wKTmyLLQ9oFuW41Tiq16aB/faz3/xN97aRXTO+IZen25lfqZKkW4pXaq5Iqo5JM3NrHwEGedjU/678JB5Uqv4CpKeBJKvhoDw44r/CEcG9JsAdE+Ja6yNFP9uU1SLXL1DbQAoaf9dHobZwJaM38oYT8mvN0mzOJOSCJfLiQDC3zXyAPL5ZvJElaxZ5TxA4Up/145D/HJXeNEIuYqpkp3TzBTLPjT8kPGYxKT5pexgcqagWHfgYRnbB2CaBvaZ+Cl2xWcyFu0PlJm1dTFD5M1A/8I/iBbFie1yxkRrKH5iGbuH6oBP1qSy0RXBEKJWvSrOSEMv77uMtadsd6ToF8DsKXxhqBpODxLUqZqpMJb++AhgRLbvkaoR+a1y0GnHW5Sxmsji3IOUiKHkskdYLNUWlDvvFcYOgQYE77+X8vO8jm7d63a9r2lGRXA2/iRpzTY7wC8bQdmmeX8VRLsYBcsGFZfkjrwBak7k2QKUw4Xoc5CmGdp0qqGouYn6TJ0fdrEMza08asHm7xs4+lOV2oLV8FM+JRijkDXMwbtTY9KtQd+papuIWuNZP2DKb+c3s5YGhmPJY/ttGFfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(478600001)(44832011)(66476007)(36756003)(38100700002)(2616005)(26005)(6512007)(4326008)(41300700001)(66946007)(6666004)(8676002)(8936002)(316002)(66556008)(54906003)(6506007)(5660300002)(6486002)(86362001)(53546011)(2906002)(4001150100001)(31696002)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVhOT05JQ1dFV3M1Z2VadDJSZHZEbWJoUmxwVFpDbDZNd29NVlpHNHorRWg4?=
 =?utf-8?B?TnZkclBpbmNjOGZiSFBHTHlIbS9VeHRicnhpNjNCamw1MXN0MTRFOWRtaUlv?=
 =?utf-8?B?UWc0ZE5xckh0a1pmdFdjMVQyWHFUcHpReFRkZitlM2VFMUcwd0FiVWNzcFRr?=
 =?utf-8?B?aDVKRWxhTWVDaU9UL1RXcDU4R3RlcmdnMGZEVnBzbkJWUkY1NzVuNmdCNlhB?=
 =?utf-8?B?ektBT1I3YTdIT0IwM1dMN0c2MGhsNXN0RFdMQ3BnN3RqVHVEallVdk9wMDRz?=
 =?utf-8?B?TnN1bVVSd2QzM21WNXVCemxhWk96a0owMnVXdU5VMzBRcTlZUitoNGJjTUhS?=
 =?utf-8?B?Qlc1YlcwYkNnTUNaQ3pNSWNPNDZyL0dVT1BjNFNpSkR5VXo5WXNmOVZGL0J6?=
 =?utf-8?B?S3hSVHpnRlV4aTRiTjU2eFpvVk43NUFVWjJxQmkvZGdHQUZ3dkdkWm0xNm1S?=
 =?utf-8?B?R0ZsR2J5ZEhlS29IaFZudks1RkwwWFZTV3pWa0ZGaWpRTlVsZk1kWFJuOXlZ?=
 =?utf-8?B?R2VwWVF1cU9FWHJjaHM0N1QwMUtBVmxFU3NVQS9pWXZIaU9rTFBaU2lZeDQz?=
 =?utf-8?B?YkkreElJKzMzd3NmVzlQOS93ckNYMmhLMThUT210TDRmays2ZW5oaDVtb0VL?=
 =?utf-8?B?UzBrbEJJNmdHRFpiK0JsZ2hMU2RWeFAvM0F1d1ZSQnlSQzAvd05sY3ZIVkNX?=
 =?utf-8?B?WVZqU3FkdzEwVGZBNk53ODVIWE9vdXpHUEtkM21QZDhZSS8wdFRzM0hLOEpE?=
 =?utf-8?B?ZHRzT1ZxTE1uOWhrN0xpODBiZi9RY2Z1RkJkU0hiTGZKRE5UWUpBWnNWSU1a?=
 =?utf-8?B?Q0twOGZYU1cwOERHd0FFYTZaZDJVSHZSQ0t4U0tCODh4cVF6a21pUm90alR4?=
 =?utf-8?B?Z1djVEQ0UFdzcC8vUVA2TTlCRHpCZDFpZ2NlVHVJU09nRDNiTWRQN1pmYjA0?=
 =?utf-8?B?K0ZJY2pucytMZENwNFJHcG81ZDVoamRFQktqc1B5NVBMVEFYTXlRajZNSjJN?=
 =?utf-8?B?K3hKN1RZbUxEMW5XKzVyektqQmp6c09CenNPc1BWSmhVZWM5TzdiSnd4dGtj?=
 =?utf-8?B?N2lJcnRXOEdRUlp4aGs5aHVic3ZTc094Y3I3YTNaNmY2THZCc2szWHpWTFlm?=
 =?utf-8?B?dXN3ejhYKzZ2VUNCRStOQ2hBbFVjaDFXaHdacUFhcmFteEt4ZW1ZZHBaNW0v?=
 =?utf-8?B?NDVPeWQ3UzJVWTdEU3BCc3VXTUtpbUFwMjRtRzJzdFdWNVplaGFndW5BNjVp?=
 =?utf-8?B?U1lYNHFSQkV3YXNNZmk3dVJVUm9zN1B1VkhXSFU3MkdZaVlCTHdvcm5zSm92?=
 =?utf-8?B?YnVnZEpSRXg1OCtERTU2bllkQzhKN3dPb0JNSkZIRWZMRkRISWVJUTVZeERy?=
 =?utf-8?B?alN0TFM5ZTN1YjhRVHpDSS9tRGkyOXREZFcyN2pIYTY2RzJFWEpGOU5wTXdI?=
 =?utf-8?B?b2xabHEvZW04ZENTSmJwankzbHpHbUdMRGJ5d251clYzV2ZWTmdxTG42eDNE?=
 =?utf-8?B?c1NjOGxkNUIwWGV1c0N1ejB4MWVsbDV4YmhLRVdFS3dwaVhKUVNsUkR2cnlo?=
 =?utf-8?B?L0NLMWlSb2g0MldtUDZ4ZWFLclFFTG5kdGlpUWxpd21CR0JJWVlsSVlVc1lO?=
 =?utf-8?B?dGhFU1ovQ2szUENVU3BhMC9NaXZZeHg5c05JMW1aM01BWkRiR2VJa2N1Qmta?=
 =?utf-8?B?VWMwTW44TUpNdHVDckZMa252cG5Wc2hJdzdMWWtKbWtNeGtmNHQ3UnBkMU4v?=
 =?utf-8?B?RGpkaW16UERVRDRRbS9NQnNxUEkvN2JKTE4rT3hDVWcrLzR2WjhpQjZBNERj?=
 =?utf-8?B?ZDVpREltbXBxT2ZuMnZTbStlNHMzV21UazYrWm1oVjFsVlNQbjBmYXIxczZM?=
 =?utf-8?B?MC9va2xEM2czcWxNaDErRDc2R1Q3Vy9Cc0VSZVBjYXB2UmtjZGkrNHluNlFQ?=
 =?utf-8?B?YzJScFlPVDBvb1N6L0tGMXhJQW0wYWhkS3R5M3Vrei9MdEpCS0pjdnhoVG0y?=
 =?utf-8?B?bTRrNXJXdEFadGhZNmdDb29XeU82Z0tyTld0Y1M4eHI5L1NUNEhvL2dHeGNw?=
 =?utf-8?B?dmQweG10S2JKV005Vm10ZzNYV3VMcXlobll3QlU4cTRTeGFBc0EvWUNZYXVx?=
 =?utf-8?Q?Aoq2iIs7llnNp4yWCW5lw8RvC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead4aad5-4111-420e-6f22-08dbd1a054ee
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 19:11:15.4620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEXrpnkvAGocx2oK+KOvX3XtL9D9pEDWdakbovjxsYOEK9eacYlKTOe+97JFrx7S2uJsOcDUMjLptlZEv/Yd0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
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
Cc: Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Vitaly Prosyak <vprosyak@amd.com>,
 Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-10-20 12:42, Rodrigo Siqueira wrote:
> When DML 2 was introduced, it changed part of the generic sequence of
> DC, which caused issues on previous DCNs with DMUB support. This commit
> ensures the new sequence only works for new DCNs from 3.5 and above.
> 
> Cc: Vitaly Prosyak <vprosyak@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Fixes: 7966f319c66d ("drm/amd/display: Introduce DML2")
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 97f402123fbb..73cc6e1b0e65 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -321,10 +321,11 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
>  				res_pool->ref_clocks.xtalin_clock_inKhz;
>  			res_pool->ref_clocks.dchub_ref_clock_inKhz =
>  				res_pool->ref_clocks.xtalin_clock_inKhz;
> -			if (res_pool->hubbub && res_pool->hubbub->funcs->get_dchub_ref_freq)
> -				res_pool->hubbub->funcs->get_dchub_ref_freq(res_pool->hubbub,
> -					res_pool->ref_clocks.dccg_ref_clock_inKhz,
> -					&res_pool->ref_clocks.dchub_ref_clock_inKhz);
> +			if (dc_version >= DCN_VERSION_3_5)

A better check would be dc->debug.using_dml2

Harry

> +				if (res_pool->hubbub && res_pool->hubbub->funcs->get_dchub_ref_freq)
> +					res_pool->hubbub->funcs->get_dchub_ref_freq(res_pool->hubbub,
> +										    res_pool->ref_clocks.dccg_ref_clock_inKhz,
> +										    &res_pool->ref_clocks.dchub_ref_clock_inKhz);
>  		} else
>  			ASSERT_CRITICAL(false);
>  	}

