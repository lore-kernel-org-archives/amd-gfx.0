Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BAEC001DC
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 15:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D61A10E2BC;
	Mon, 31 Jul 2023 15:16:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D55C10E2BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 15:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmzSFcbcP5jYwNGsBf0/HpS41OP2ssTUy+p0U+qB3xFMmnrh3GtqaAnG6uXIgo3q6Cp21xQiZjZqLKjp+RMSKkY86lhyuAolgTjNsOFAuu4lxu1Z819LxzKldUtyx6EYE7y2hj2funzjaUaAs6icK+SdZrIwz7nbO2Cv6+QkFtoQg34PtgCrWH3KwWXkyIXRjRviQWEHbLsfa4ZyEZxjalX9JG5gCBOSOTm6Pay5cMgjyqG9TehXbE13QYKSULiY6SZirOpvDvJ3Wee4RERob95H3AEOvm2T8/vWyHidDN2n0jaU2M0IE2/Hy1Zi/HFdQh98i6zVTEac+8ch6XZWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11lWiXYO55q1uuNXniwAKDbtNuggEnaCUMlbUVQSa0o=;
 b=LaWEd4EoQpUCgSRBc3CInMs+5QJNA7yFbxHtE3t/EvNRW91Ghss/l7xNTbmTnbUeil+Is8QNQGgHaPu9XXKfzvtQNaJtpwy8v3xIoQy48C4ykpX5ETsZS9O7IxOrYoFA7ASeyh4mdGplUyP/XditCjz9/yQipsc1wbvdH+vVPTTm8BbtS70WtsmC5EECUWIIvWLQkK3pmjY8a2VNVVJr1rccw3a/LhWlll94sE0ULO6gfwb/zkKOY45yvy5NosXnGmLR5bp6oQ8aGLBZqzqE0CuqayNOlZV4MsWgrSGcOHBHFwTlyTZ32ywtEVtvjAqSqgAqGYPFTWgb/Dw4MTzIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11lWiXYO55q1uuNXniwAKDbtNuggEnaCUMlbUVQSa0o=;
 b=Zq5SwOkMAVE+II5ZNmh4/f4H8dKgWA4gijt+BOMkzieGshAdkGjkpZvX+iHL6irUGZt0gAzdaJfzJY/fqjumxFb8wlroPW+zlJC0Rzf+PZamk4wrhZfSnLUOMld02h7ijLq1/aYfLIRHzmCdGW6Aade/MP433g8S2SSrcT/vQro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB5310.namprd12.prod.outlook.com (2603:10b6:5:39e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 15:16:23 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 15:16:23 +0000
Message-ID: <283555f2-5b17-e3f2-ee93-8eb9283495f7@amd.com>
Date: Mon, 31 Jul 2023 11:16:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix a regression on Polaris cards
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230728221143.37363-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230728221143.37363-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::14) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c179d35-25ff-420f-e2ad-08db91d919c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn12bmlYxvPp4vZdoP6YpVQlAxQZrEGRwu4yQrHxAHmIS+i6I1yYaXlPMwZSVAAN2X75CCNg0lIPH4ILPJ6MxC9qV71piCLj3d2Ge/xdC1+0u7/X9GH2/MfD9xfqkGAEP7ZXj5pnczFvQyM1bLCvPJIakqb7p8oZeFamMinOMDXal7bYhzUKPKd5qZ9hfX+epm8M52dCxPZS9lDt70dR/RMCDbpofqUZYxUY8TrAtlFJVbJ0Qm+VpRKeC4ry6rkpod+dS0RC9P7cgGjohQa45G+OGNZZM1BOnBdzB0nYZYQOSP+MBoi0krn5TijnnJAKCby0YlICqQIsBcJv211i8iIP+d2lYGRstC21/R5BgNciHWoycXSttMIyCy0RRiIikbsdaKWxTrlRBVwkrJ2W8qV9D1YiAoNxJ9mMXbYl4uPGGM0q7B81HW8YueHIq+kU4ZC5S2sH9eYD5JbFk3lZMHPy5WWHphLpqGbEFgVb4ovWX/kSeHcPugDfyJLG7kzQdqOrZqnC331OfxmQJRo5YVE5g4JiLfA3kU21wrjAwyxe05HgBIZOI9Sqxq1pAd0XpLJzEztG3BttThU9FEEVLlzlm5tA9a6Vn1N9p2uMk+OvnCZUTsl1s7fwyaLihmBf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(5660300002)(2616005)(53546011)(8936002)(6506007)(8676002)(186003)(26005)(44832011)(83380400001)(316002)(478600001)(4326008)(66946007)(66476007)(66556008)(6666004)(6486002)(6512007)(41300700001)(966005)(86362001)(31696002)(36756003)(2906002)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1QxVmUzS3UvZWVMUnRvZWN2Z1FnMVFLQ05zKzVPc3U4RGR2R2l5M3R2R1JT?=
 =?utf-8?B?aldjdnUrN01XSlVWS0NYdFZxaXJzR3IrYU13SG9EUmhNMEFkMmlhY1RsWWtO?=
 =?utf-8?B?WGt2RU10L2cxQ2VzNWpxRGp3d2hIbTFVQ2pzbzdlalN2c0RERHByTGdwamww?=
 =?utf-8?B?eXdoWE13dXlob2c4d0kyKzlRNUMwQmR0QS9mY1Nza2ZoKzhHY3c2QmlPYzhP?=
 =?utf-8?B?ZzFYYlE2MmZTOGxtRG43dHRXOGFIVzJmbVllbWlqZnlpVE5xZW5sTUhDR3V3?=
 =?utf-8?B?d3JZMmx4ejRtRWR6TVF4cm5wSndYNnFBYmN0TzN0UnZSWG9XczVWQkNJS1ZH?=
 =?utf-8?B?dDRmUGY0S0lTajBaRWVtTkFjS3RRb05FVVp3Tk9PallnR1p0K05kcTQycG5K?=
 =?utf-8?B?SERReGJueFVlKzdSa1J4QU4wZjhCK2ZLVVFUOVE3NVYwdHJSVWFuZ1RQdnlq?=
 =?utf-8?B?cGgraWNhV04zWEdzTmdDSmZSQnppaTBLWFRHZVFXYk5PZ2dlcmx2dHRwMzZw?=
 =?utf-8?B?MXZ6UkdRKytyQjBnRDNma2xZcWx4M25MWG8vNDJjSjFjTWFuTjZMQ2IwbTlZ?=
 =?utf-8?B?bjJkZHRJeEltZnp6eFNjMlBFeDBQRERRTjY1Rk9ONlg1OFRjUnJjakNDLzFm?=
 =?utf-8?B?d1ZaNm9xQXdDUW9WNzdIWXk5WURiVThKWVMrM3lvY3ZWTzBKQ09CTHJlSisx?=
 =?utf-8?B?eWYzZ09HU0Eva0pibzFkdTliNmQ5V0duR2ZyVFFtRllxOGZUTEZSek1iTG83?=
 =?utf-8?B?TlBjRGFnUHd4Wm9SZTN6Z1JsNzV5dVhpQnduRkd2OFYwY1dRN1VEdGtCdENO?=
 =?utf-8?B?bjBjMUNRR2ttQTlmaXAvR1hkREs4MU1iYlY5WHFCUjNwVEtVU1BycEtwOFVq?=
 =?utf-8?B?dGw1TUpEMEdHaHZWSkY5d3VCMzFTazk2ZVh1STdTcHUwaGtSMC9EMVZHc0di?=
 =?utf-8?B?Q2tOZ2pjWW5lR2ZkNm9sZDErc2JWdUVtU2lvdUhGNjRqbTRodEpQREVpcWMy?=
 =?utf-8?B?WTVBNnVnRUFsbGIvazU4Y1VMVTl2ODlFV2JVTjd3RXRJcXlMNHk1VDV0SEZv?=
 =?utf-8?B?a3J0bmQrd3VUWEZmSnZKeEZGWXFhNVpmeDgzUDBnWHB6N3h5YXQ1Y2hia1BE?=
 =?utf-8?B?WkdDZEJONzNyS3praXY0TDZYaStMWmhiWmdiS2xubjZFWWRsOUYyTTlTck9E?=
 =?utf-8?B?NlFjT2syMkpvcnpIenpybWhSOFJOenA4OThuUUNUdDZpdGlJWm9GN2dyeU9l?=
 =?utf-8?B?bk5UTG9UTE5HcUl6RllRWTZGZ1VPNEhzNWE4aG9udDBWZXMvbVoyemdKaEQx?=
 =?utf-8?B?VURjU3lwQkxlZVZXbUhyUnl4cExRVTViY2lPY0VOajhoUGdLR09aKzU4Nm0r?=
 =?utf-8?B?RFN2THpNMXFSTGxPN2M2TDU3OHhYZXNCTEtTcExKL2EzRWxPU29nUFZHbzRr?=
 =?utf-8?B?RmptS2g5SGZoanlTdFg1WEZsa2R2L1czSVhwaXh4VlJhUmM1R285Y3lWcUtR?=
 =?utf-8?B?b3ZBSVROQzhuQjBTMDNWMmV5WmF2OW9zS2Fza2RkYzNnZVQ4dFEycmgwdkZR?=
 =?utf-8?B?bm9NbkVJWEthYmtGbGRteDZPQm10alhmK0pSTVRjekp2Mk9UVEtSSWFpUUpH?=
 =?utf-8?B?U00zaTdSSHhKbDRJR0JQWE9qRDFKMGtvUU0xdXlValdheDNTengwdkVzTVJq?=
 =?utf-8?B?Z25XdXpCQ0lIVFBqS2FHZlppREd6MHpsZDZrcnpOZ0dEY3hXczZaRmphR3BR?=
 =?utf-8?B?bGdLOGRpVFpKZVYzU2xxcFFsZkhObTE2aUtvWWFjQW1rZDg3ajFhaDlTVE9t?=
 =?utf-8?B?aTJKSlVTL2hqc3JpeUxmd0RnZ0Q5K1FyQ1MvYnY4L3pCQWNLQVRkNmxpbVdx?=
 =?utf-8?B?VkVpeFFuRFVSR3VBc3N5TmJ5aFBkMkkwc2xVNDVVb1V2R0U0UHpMcnFTVmh0?=
 =?utf-8?B?SEdxRGNxdStsZkFHVDdQRWRVVUZQYVhrWlcra051Q1lUdjJEb3kvbXJ1S2VB?=
 =?utf-8?B?THJSLy9sTHREQ3I1L2lvSFVVV1FRUzRBd3hPUFJxNWdjRzY5SGZyY3M1b3ZW?=
 =?utf-8?B?c3NhM0FVR1RqenV5ZTFKWERUV2QzWDRyaGZ2Y0cwYTFzSm0yOFhBKzhnbkRh?=
 =?utf-8?Q?riXXurqVLM+1A7dUMJ3FjJ5vh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c179d35-25ff-420f-e2ad-08db91d919c5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:16:23.1729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z0BMri0RHs3PBNRnJYyJxpo/XDRnRhyIRhYY37l64p0GKqoX3duLnotEIxyPdi2HWlRG27qc6xDmjF13TQdAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5310
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
Cc: Klaus.Kusche@computerix.info
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-07-28 18:11, Mario Limonciello wrote:
> DCE products don't define a `remove_stream_from_ctx` like DCN ones
> do. This means that when compute_mst_dsc_configs_for_state() is called
> it always returns -EINVAL which causes MST to fail to setup.
> 
> Cc: stable@vger.kernel.org # 6.4.y
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Reported-by: Klaus.Kusche@computerix.info
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2671
> Fixes: efa4c4df864e ("drm/amd/display: call remove_stream_from_ctx from res_pool funcs")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 943959012d04..57230661132b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1327,7 +1327,7 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
>  		if (computed_streams[i])
>  			continue;
>  
> -		if (!res_pool->funcs->remove_stream_from_ctx ||
> +		if (res_pool->funcs->remove_stream_from_ctx &&
>  		    res_pool->funcs->remove_stream_from_ctx(stream->ctx->dc, dc_state, stream) != DC_OK)
>  			return -EINVAL;
>  

