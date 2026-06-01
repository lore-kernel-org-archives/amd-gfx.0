Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799D8CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 16:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CB111355D;
	Mon,  1 Jun 2026 16:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bmYZrjk6";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D641311355D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 16:10:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XginOClUlfpoqno+3q2XZEKjxyC8bW4i0+ZnccItP/CSAKMJb2eHO0dSXX5jETp/ygMNQ9HqWeMbl05wTDAN6onKw0iikSFGUJxhhm57DidCRgC+AjqrzhJVmB7ftHCfxHhzRsfvIzdOB/e5dfcJceMuD0xaSnAvLdr1COoeeOLWal6tA1xfai8FnOB2atzCA3mEv2Dv1VBuX/huqj38f12lAMnQzFJx3PpgVbaKZctSZzjclaQ7YT/z9P0vU5EpCMA9A+ZsTc6rRjGvV6r55XRye8+pxuuM297oMu/CVoEaBHGzcPgKiYyi4zp1XddP9R+7Xl1TqMOKykyCVIOtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWTw4hp7321HPM6h4Ml0UFrQ+1UiN+n13zzZcegiJG8=;
 b=jpRKK9ceQpXTcH0Owdib8lDnQhq9Aj/w+znaglTdE3ldOUV2LYV21dl7dq+FvN5LN4gp7/vQBeGSmAq/LIMKYUQIjejBpbB6va4MjxTEDhiJVhJE/498X9onbIG7XPOy+GWeVFueuyDiOOAXhv3ZA5GGl1fadM/MzHmMjgGfRfyPOzo/wfnKadlr18a1mkdmcXgSCnjUubK8yaYw3klqG5qrSvlRZUWgCr1W2kKtwhwDL9som090fgx5P22jMWfYF4eWSiWUhnSxM/z4Oo7NqgIs9lQ7E/p9OM8izz66GUuZ75Qn3I09uNM84VV1o8tq1LgYxFxvaXWa/kCzdvvszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWTw4hp7321HPM6h4Ml0UFrQ+1UiN+n13zzZcegiJG8=;
 b=bmYZrjk65Kq/MMBR15CtGT7AD/Dt5ht304NAOK57RSOvl/EU/51vhSik7LnwWdgGVm2M4/fNPjZSJtr4cEdtEsP8Ju2tSPkC/CUlTY9Fy67tqRiJtM4EA72z+d4i2H83jIDtF/pfSfSOPotPDi23GPALQVd7pqD0Fgm1XlnIl58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 16:10:46 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0071.010; Mon, 1 Jun 2026
 16:10:45 +0000
Message-ID: <81a94078-fbeb-4b7f-ae63-b0c73e16e0ea@amd.com>
Date: Mon, 1 Jun 2026 10:10:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix kdoc parameter names for DSC padding
 helper
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Roman Li <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
References: <20260601142449.2648037-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260601142449.2648037-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::6) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: d619d651-22a8-46f9-a819-08debff85650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /Li3soeAXfXqr282d1VVVewf5CSMzdE+MuGrUWMY4TpuOMG/ULpzzCj4ZPtHLp7g+NvmDMfNi+ZDZO70RPF12PBbLdJw8YqT1MC9jBGsKsTMsC5QDarlp6stfUDvzeG2IjkVTL0Mi3X5rRg0Rf/qh4Q37Y8LqRiQ4EEdwbXo+ZC+BKgfDfDhkqGJUG54lrdUqVAEi0rTGRWeKrilP9K/bCqxmvqB4BLnDYn96X+gboBN7ljAQWwNu60evZhIGIC9eiphf4zF8ftPNn5HDlMtMZwSoi0fuJfcIestZVYRmjCP/XwllLA8nmsYXXJJpwkY6bg22cPvhB/4tl5OvreJ30jbCnnn0BswWKsGh9gqYjX7bLHuuABqluwDL+mXcM+OIc9/yjJK+jgTDN6lJHF9QxgZOvoAfmmCAiQ6e/43DMwbIQbwbNUtecQiAyqJASshRmMYnGBmEqtfEGJX2ObiZc7uxJEiruSowBZzREWrmRH3A3ESYyGvXnQTLrvNuSNv98BXs77fprW5vSDcTxgnqJ1Bt0p5ZCkxQmNQSgqOY9AxY5aIy2fMxMT3U06zobKpblwfgYGM4A+XH83lpjofmWhY16hLvBMJtQ+RPxYWvUGPfapSDqa0RZdm08qSlotszU+QpMfJxb7zRm5SMUsImJQeMnLFvWeu2/tTJVhooNMCENzCa/mvkT5ipZvFEkuj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHp4cTZabTRZcVBLeEhIbVAwdVJod0tqSTZpdFl3dk5mdm9qN1BIeENRWHE1?=
 =?utf-8?B?dmtuTjBNS1NCWStXdEZmY1U3Rmw5L3VLUlpwY0xVcHI0c1d0eDhoVGl6R3g3?=
 =?utf-8?B?QmtpZlVTbVNtWTNoQk1JTlROakF4OHFmcFRhRE82RFBKYnhIZElwbnFOV3RJ?=
 =?utf-8?B?eExDZUxrTFdDb0szQlJhY25UMmRiNzJ4OTZrTlJXckJjTUNNZ3d5ZlNTVlp2?=
 =?utf-8?B?MHI3ZW9FamNBK2VpVVB1bzVJMGQ3SGRNYjFNSkMzV292MkNBWC83U3BHeTl3?=
 =?utf-8?B?TUJlQVI0dkdLbUZsbmgzdDRRa3N5U1NvQ051b3VxZm9KWVlwQjJzZnRuY0R4?=
 =?utf-8?B?cmRiL2V6SFppL2NLNlk2K0VxVThrL21EcHRrMXRlUnJmaE1WRm1kYXdScG5q?=
 =?utf-8?B?NlZFU2JSOEt1RnJlanh5Mk92cjZzeWNEN2JEdDAvWEhsQWtVdEg5aitlYUNL?=
 =?utf-8?B?WGFVamtMaE81SlNNbjFscXYyU1l6Z0QzcVYwZHd5UWVtK2hjdVlFai95MTYr?=
 =?utf-8?B?bStFUWMwOWMwOEJDbnVmVzlLWHRFMkRUNTQzV09sbGZqYjJwT2JISzdjWDNn?=
 =?utf-8?B?d2JxRkZZdFpIRml6anRSQm9COU9XTko3QndiYkI2QTFORVJIZUNXVENqbkRG?=
 =?utf-8?B?dnZJOWdkY2tkOExvM3BYVm95L0N0T3hXYUsyeDVlYlBuTmlxTU5wSTRGeTNZ?=
 =?utf-8?B?TFhKTTVUelBXYXJNMEZ2RlV0MTJHcDBPanRPa2o0NG02eTF2cjRhVjBYSTcz?=
 =?utf-8?B?NmR4ZDN4eWxYUFN0dnNvUU4vbkV0VHQ2NkZpQUpaMFVCdm5rdU85TkFyV3pp?=
 =?utf-8?B?YjZWbUhjYmNJK0loSWZzVFVVSC96NEVhZitta3dkSkZaMkY1NGQ1Z3NaeEtN?=
 =?utf-8?B?ZjVxVXRUbTVSLzRWRVdQelhVOE5GaVhKTVRtNnNPZEFNOUNtTktNenVWVE8x?=
 =?utf-8?B?WnIvNGpnZTVPT29Ba3ZUeDFWVmdzQ2s0T2lTNmZaRFdoZFg4L2MxVWJmOXpn?=
 =?utf-8?B?NFpiVHRDZ0pOckdGWWt3VVFOcVNLZCt6Q1dGQVljUlAvOFdhVXRaU040QzUv?=
 =?utf-8?B?QXBqV055RG9OK0ZyYnlEa1gyeHVPeldzYXFCbjFHRG9XLzJCNUF3TkhDMm9J?=
 =?utf-8?B?TlNpbFlFUXprbk9qTFArd1hMY3VJSVVJb0pEWGhEYy9TaWtYSzVMQ3pDc3Ry?=
 =?utf-8?B?SG12alBNL3hwSHFreXJzNGJBWXo3eE1oM2kxT3ZWbVhCVEVyN1gxL2RXb1FW?=
 =?utf-8?B?Q1o3RlNvOWh4NlpuNHpCRU5nS3Q0YVpLU2tmK2YvV0hiVWt1WFdaOGVHUldy?=
 =?utf-8?B?U3NOaGV3dEh6VEc1WVdUTmhOK09iZVptS2N3NVhqeHJsZzF0NjRiMEtic0ht?=
 =?utf-8?B?WWtyR0ZoMEdocVVPbmtGU1hsTlEwM3NaWlB2YXlCMXFFU0RvbE45QngwS1ZP?=
 =?utf-8?B?ckhpNThKQ0ZwaHZyR0k5YmFpMUxUcTc4S0k0Uk81Y2xaUG1LcVRuMTdrNERJ?=
 =?utf-8?B?bW9KM3EycnVoUHE1dHkzMzJVUm95eW1WY01NRENpN2NjciswZGRxSi92WFdr?=
 =?utf-8?B?UEpNYXIzQ1h3c2NrZFdDWVZHdlRzd2lBSllCNGsybUFPMmRBNC9kZi9DbUZa?=
 =?utf-8?B?K3VUbGNJQm1jVUNiVStwQzYwK05vb1pUNldURjFxSkpWcU51a2dnTEtrUVgw?=
 =?utf-8?B?R1F6UHh2Vkd4OXczZmFFbmxFRGw5WEdhdEFTK0Mxenk2ZVZhbFhVK2cra0Qw?=
 =?utf-8?B?Y1pzTXI0TitqZ0NacVVLcmI0M3dnSjJuMkMrSGVUdjFxQUoreFY3NXIwRDE2?=
 =?utf-8?B?RXFDZjRBWEJ6dkxha2krbkdUcDN6OGYyRC9LZmFZcHJ4MjhSUUZ6RmQ4VjBS?=
 =?utf-8?B?OU82Wlk1QU0wcHgwbmdmYkZmdXMvUWc3RWZEbXFlZ3kyYmpjWW9pSW1DZnZI?=
 =?utf-8?B?TnBML1pQSngwSG9QTit3YkU0b0wrVXpvK1drRWhJSEpwc2xpci9DeHIyM1ov?=
 =?utf-8?B?bDdUMFBLbzRhbVJjVER3dmxKMkdFcHdUK3pVdjQvSDZpQ2VWeUtiV1FwV0U1?=
 =?utf-8?B?Qk16K2dIc0MzYVBYYWU3Y3k2NFU5RmY2Q1dzUUVVdjFqUm5YZ0xxT1p1UEFK?=
 =?utf-8?B?cnN5cElyaXdCU1N5Uk9QYWhLcWVNZDBYL0F3OVBSLzlhc05MUkF4L01rNE9T?=
 =?utf-8?B?V2lSNGJKMUV1Rzh5YS9RQlI5eG12SFIrRldCUXYyS3JqeVJBaUFvbDhoUlFF?=
 =?utf-8?B?ZGp3djZ6dHZ6TVZFeU1zazRkeGlWdkYzdVlKVTdpVk9FZXpYZkZjb3p0RjJu?=
 =?utf-8?Q?c3+bLOF6g43eacEaTe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d619d651-22a8-46f9-a819-08debff85650
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 16:10:45.6935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oy4J1nvwaT5CvQ7isL5sbWKatXZMjwGz5qojNBpwnylhK3PhcUJ+KjkVo44xCUP95cByWzSK8U8FbYxgqsoBoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 6/1/26 08:24, Srinivasan Shanmugam wrote:
> Replace incorrect kdoc parameter names with the actual function
> parameter names used by
> dc_update_modified_pix_clock_for_dsc_with_padding().
> 
> Fixes the below with gcc W=1:
> ../display/dc/core/dc_resource.c:4616 function parameter 'stream' not described in 'dc_update_modified_pix_clock_for_dsc_with_padding'
> ../display/dc/core/dc_resource.c:4616 function parameter 'timing' not described in 'dc_update_modified_pix_clock_for_dsc_with_padding'
> ../display/dc/core/dc_resource.c:4616 function parameter 'stream' not described in 'dc_update_modified_pix_clock_for_dsc_with_padding'
> ../display/dc/core/dc_resource.c:4616 function parameter 'timing' not described in 'dc_update_modified_pix_clock_for_dsc_with_padding'
> 
> Fixes: 3bd4001e8d1d ("drm/amd/display: add HDMI 2.1 DSC over FRL support")
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Cc: Dan Wheeler <daniel.wheeler@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index e5565a61ef12..5f6cc1b1f788 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -4603,8 +4603,8 @@ enum dc_status dc_validate_with_context(struct dc *dc,
>   /**
>    * dc_update_modified_pix_clock_for_dsc_with_padding() - update pix_clk for dsc with padding
>    *
> - * @dc_stream_state: Pointer to the stream structure.
> - * @dc_crtc_timing: Pointer to the stream dc_crtc_timing structure.
> + * @stream: Pointer to the stream structure.
> + * @timing: Pointer to the stream dc_crtc_timing structure.
>    * @dsc_padding_params: Pointer to the DSC padding parameters structure.
>    *
>    * This function updated the pix_clk for dsc with padding stored in pipe_ctx

