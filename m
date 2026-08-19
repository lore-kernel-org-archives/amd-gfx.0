Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DFAC5DF81
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 19:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE3310EE8F;
	Wed, 19 Aug 2026 19:04:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MBjEpjra";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D089910EE8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 19:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHgYSb4381xuudNE/WIgzyyD0uUvV7YvSaoDnnQzSaiqcLX/v0UJ3zcz5oxNq8PEfB+4flU6O5H7DVpx65EgOWD7aOeg/xujRJOtQjnFL68e4illk4cd9Awpj3TLW0nnletJZ97FJknDdvRc+bwTX6u5EjSnBgsRITKgMptI0cj2LGA2ROBy/UwoZ0oFmWiksBKx4+MHhME1HEB1Wywvk19SC8p0U/eVB0YzMzzb4NAp/WSQwPP7rrajw0IB9CptLTV6ubgyyCxeDc5GfVaAhm1Oq4O8s1Ca1qPtxqbuNO4mfI6aNkBwBShLv/cGxGd6FKiPvnHmCqDG4UlPT/a7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+Kk4lS2KlNyEyymy7nmP3KmJzHk6BiwVPTL2qfaRYw=;
 b=kmWJASWYiZz9kirbrNhl3HwzaDqW5ADm9adsz6I/dOWEh0K+S3E1+JNhD2sb2wVVhEDrqyaRNBGR/oOabkKOKbkTc9OZNqF8PVedfqQ794qL4gEzz8hGBhG6rLblNLxJr7vGmDrge0/H7xcfjJAZZJvtLdIwQ5iCVK/xSrTgrS6F0WG7XNN9D5rJSC1PBWpNPqU3oFax9o6LagZnl1RKhmZVpV5XW47pbLuxi5AQ3fbeQX/g5pteQZfh6rlegAzuIpm8xEQQT6omtGFd2Dgvj+XC1XTTT1Atipba9Xuul+qniPnGrAbk8fpLGmmjGPUosAy6zJltcO30uqAWtcd3Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+Kk4lS2KlNyEyymy7nmP3KmJzHk6BiwVPTL2qfaRYw=;
 b=MBjEpjra9nZ7AVAJB29Lc/bZPJpYvQ+5XEckTnL6+pmhAkDAhIx/pmLrplL/WoirtykKwPso4NtGoa92BVOOfP8wRrJZKmqe6bL/ofG8afN1nmz1dXpPmHpK/EcUuRSj7QSVvbMxaMpifsio6XqqxtcP3P8PkxM+tSRws33Ihzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 19:04:09 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 19:04:09 +0000
Message-ID: <bbeeb981-c4eb-48c6-a268-bec48d979be5@amd.com>
Date: Wed, 19 Aug 2026 13:04:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: use
 translate_curve_to_degamma_hw_format on DCN30
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "'Dr . David Alan Gilbert'" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 robert.mader@posteo.de, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20260819161106.27702-1-mwen@igalia.com>
 <20260819161106.27702-3-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260819161106.27702-3-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c471e30-6c59-4ca4-9bf0-08defe24a5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|23010399003|1800799024|376014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JpHa4BFPC8Ghrbn7gtgecFjcH6GvWYDh58Z2ijU/NLrcqFS0i/6P0PSGvcjhlVN4nqtbRsGZqrsH7WndIf6Q0yLN23knBipqg1LdLvBEMlaJf28kKXhEdlL0jAtRuxhB17a2cRqU3P/zXbBQBfn4J4iKcwjxjIYA/eHDUf05FvmQYE/gBjsajMunhyMx6tU/v6cMiPtZfc9MuKU2lIA+bbBBhu8WGbvso+jpZrd65Tax1oh48tkUDrlSWE/+8wb4UhqSLHkJmBwbVWqzTKdIIvP1od8CXUac76s3L+DuVnB49G2dfc6K1VcR5arCahnO/lKebbObWptbvMF9L1GWYKF29TTk72vZOryyea4i/ZZ/5tA5gLTWokfbHApVfoX7Wj8C3nipAUGMNd8EvfACAd73yNT/LltdtmyGuj+anAMi99kBmMpcBi3dmOwPQEUS0e7NoCX00rNp8sD4oW+rQ6c4UXrSjoxXm+mMUqQgpONiUFb2y+xU1itfzB84/dnGdmcW5YNFkMuic70Ik/ph77BjTfT7Y4t51D343JWktOE97CPN99au2bOIeg+CFMS1ylt3LM90dsajRtAIRmWE+FCu4zlKi04o9VWYlaVyH4cW+PI+ojOKFgB5H70Ogfr/4H6EgrFhXZ3ur+MfP7Z0EGFVGWO/wNV9BvbPZ0O4bLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTFjV21FbjdmMDJzamF5ZkV4RXRmK3N6SHZ4bUU1U0tJS1RUeU00R05xT0Zi?=
 =?utf-8?B?aWpQMXE5am1LanFCamRJaXBWbndkb1V4YTdPUFRMU2x4eFFNUmw5ZXNwTHZD?=
 =?utf-8?B?bUMzVkRDcnF6dkN3Wm0reUxSNC93c20ycm0yMmFrelVCS1h4OUk2L0g4SjlT?=
 =?utf-8?B?eTBSaVpudlB0dEZkTDlnTVNUZ2RWQmRzUE51dkN6Mk1CNGNPWHc1VG9UVksw?=
 =?utf-8?B?dmRuWVlReVArUHpSTHZVSU1KWkpVOENKS2IzUEpKREt0T0dHYURNUzJWOTJj?=
 =?utf-8?B?VWprK1BRdHhEWUZrRnNzOHdjMUpaV09YWjNHRFN0SVAvL0lWTDA2QkdLOVRI?=
 =?utf-8?B?bEozSStBSFpYVWpxQ3JoVmRXSkZ5ZmV4K0RXdXJZWkxuWWZsSHBKV3hlbXlE?=
 =?utf-8?B?QTlMbEthZ0NxRkcvbmdTa1RlY25KblNIWWthQXJVLzErUHZCMUU0QW5Sd0tQ?=
 =?utf-8?B?aFFCalArTTl6Y3QyRGx4blBEeDZrVmYxQmdxYkNvZytNdlBud2xrazlYS0NG?=
 =?utf-8?B?cEZCUTh3Smo1ZXVPOTVvWktXMTlvWVllbTNmelJHRDBNUk1xWTNYaXdESjJ5?=
 =?utf-8?B?elZrU1JVS0dLUHF1RHFmay94aklaeURLMlpwSkVkd09tSkw4b3ZmSEVIU2Z4?=
 =?utf-8?B?QndUdHFQWFZzRXVpZWFoUDFDT0tLaDYreEF3MXpVNjhWZ3EzQ1JuNlBMcWk3?=
 =?utf-8?B?d0xvWnpWbEhmQVMxZFcwM2dQMzE4ajRSdDNhTlZFeStxZ3dwUGZDT1ZyQTJw?=
 =?utf-8?B?MUNFQ2VwejZNMjA4aHBJMXRQRWF4VFpNT2xhTkdEcVNSYzlGTk9BT2NMc2VM?=
 =?utf-8?B?d2FxQlIzWnlPTXBybEh2NDMwSlRqUHhscTJ1c2xlenVZbXVsOVVSbXlKTXZO?=
 =?utf-8?B?YnZuQzd4OTVYc3lUZ3J2OUE0anhONFpvUkFPOXRTRG4zVVN1K2p0Q1RvU2NZ?=
 =?utf-8?B?RmdoZ3F2WFNFZFIrSTZXZFA4ZytQdTVtT3cvOUt5OWNuVnRDNFJjUEErWEgz?=
 =?utf-8?B?UHFZaXVIb0Jzd0M4eHk5S1BncE1KWjkrMlpiM21yRmlvenJYM0svTElXUys3?=
 =?utf-8?B?bkx3elZyakxONGhwOThzbDRCYXFTOGJRYUIvZjFrVnFjUVkzZW8veUdxaXlJ?=
 =?utf-8?B?ZEQ1TytMc2NPOUljSno4SnBnd1N3ZmFDWmdsYXZ3bDZyTDlIUGhsVFRtc2t1?=
 =?utf-8?B?aXRJeGQ1V2EvNEZmUzFjTDQ3U01PQnJ4TG5PcTkvZElNZnhtalc4OG9XeDlW?=
 =?utf-8?B?VGUyODV0SkM3ZHoxeFlaenlxZ1hXVmhoOHdFY0xXM25GUG1CeHM3aVZuSHIx?=
 =?utf-8?B?Ly9KTlBtbFROSCs5MnZpRktvMzRYZnhVQ1ExVlBtVm1WMTZQMUM0R0cxVExr?=
 =?utf-8?B?bEpUa1dER2lhWHE4QUk4cjVSRCtheG5ROGp6S3JWVEpFRkp5MzJPZ3BhMlUy?=
 =?utf-8?B?bjlLTnVBNDV2UlhuQk9YTFFXQUQ1TXd0QU9BaHUvYzFINno2T2FLT2ovVExP?=
 =?utf-8?B?WjJoV1Z6UHc1OXlubUFJWXFsRXgzdHhSMHZBbXdJVjdua05KWlBGV0pwTnNw?=
 =?utf-8?B?Q0tNRlV6NGEyZDg1TnVYbEtQVmZsMnQrR2IzZ1NFZlNHUFBCb0RnRFliakxU?=
 =?utf-8?B?OXV1aEw1VzhJTXRMc1lUc1oxNGxUSnlPQ201cEFCOURaWW5id1hoVkZISXZ6?=
 =?utf-8?B?Qitaek1IR2VZdVA3TmQrdVN2cTEyaFo5QjhIaFBzSUdmNVI5SmxaSWhjNGxj?=
 =?utf-8?B?MUxZMWVWQ2VpbitFY2Q3RlpCS09ObXRja3ozTURIbVlJM2s1eVBmOHlTOEdI?=
 =?utf-8?B?ZE1sdVBYbkdPeDdWYWMrM3Fod09LcWozWEpOZHBOYVFpSmhKUUdJcVVYc1Iv?=
 =?utf-8?B?REtFYmlML0VNRmN4bFpZK0V3MzkzNzQ4cFdZQk5ueHhMbDJzUFhxenFZUGVB?=
 =?utf-8?B?c0plb2Jxc2UyL2YvaGxIR0xFSXJnbG9oU25FNEc2WWNmdnFLekthallSN2R5?=
 =?utf-8?B?M3pNVXkrV1ZNZWJpN2hYcXR2SG9aM3FVZmNaYWQxZTJGVjFkRmZVcmg2Y3pB?=
 =?utf-8?B?NWV0bXpwcGVDMEo3YkNSRkNucTFLOC9QYVVyNHc1YmJyMnNiREx6OTRkZ2FI?=
 =?utf-8?B?UlFhV1hyR29JTDM3MHhUcXYrd1lxN0tCbm10aElZTlV3OTZMMEYvcDRWZnFS?=
 =?utf-8?B?alpWRjlua3dsNXliQUtDWlkvVTljcytnSklFdlMyeDU1SHp0Wmt3cFUzYk51?=
 =?utf-8?B?Kzg2WE1PTXFjWmp2UlRtK2MwdTFMdzZIbkJrOEpPS1lzRTJSN3FqQ0wyZStY?=
 =?utf-8?B?TTczeit4dUh1Slowc2VwU0s2OVA5K1ZiMlFWUXo1cXJZenkvZUpBZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c471e30-6c59-4ca4-9bf0-08defe24a5ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 19:04:09.2528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqNKn3/eziDk6E4PPt9v/pJvd1Mw+CiXqsjqUFk09tS5MsbQp1qGdFshpMl8N2jVJzq0KaZ49r1bhmZMorXvBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
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



On 8/19/26 10:00, Melissa Wen wrote:
> DCN3.01 presents the same banding issue as reported in the link below,

This affects more than just DCN301 as below:

drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c: .set_blend_lut = 
dcn30_set_blend_lut,
drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c: 
.set_blend_lut = dcn30_set_blend_lut,
drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c: .set_blend_lut = 
dcn30_set_blend_lut,
drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c: 
.set_blend_lut = dcn30_set_blend_lut,

> but the previous fix doesn't cover this hw. Change the helper for
> degamma/blend curves for DCN30-based family.
> 
> Link: https://lore.kernel.org/amd-gfx/20260623160112.1636801-1-mwen@igalia.com/
> Fixes: 3719314af322 ("drm/amd/display: use a separate helper to translate degamma curves")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> index cb163902e12e..6980f622db0a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -243,10 +243,9 @@ bool dcn30_set_blend_lut(
>   	if (plane_state->cm.blend_func.type == TF_TYPE_HWPWL)
>   		blend_lut = &plane_state->cm.blend_func.pwl;
>   	else if (plane_state->cm.blend_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
> -		result = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
> +		result = cm3_helper_translate_curve_to_degamma_hw_format(
>   				&plane_state->cm.blend_func,
> -				&dpp_base->regamma_params,
> -				false);
> +				&dpp_base->regamma_params);
>   		if (!result)
>   			return result;
>   
> @@ -337,9 +336,8 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
>   	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
>   		params = &plane_state->in_transfer_func.pwl;
>   	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
> -		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
> -							&plane_state->in_transfer_func,
> -							&dpp_base->degamma_params, false))
> +		cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->in_transfer_func,
> +								&dpp_base->degamma_params))
>   		params = &dpp_base->degamma_params;
>   
>   	result = dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);

