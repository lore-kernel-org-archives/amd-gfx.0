Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA93C5DF85
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 19:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E7210EE9A;
	Wed, 19 Aug 2026 19:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HfOGP9sg";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920C310EE8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 19:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM3wRK/0AGb3lXEM6IukH9cMqlz7FfW2EM4NL+vMIz09lUra0UiVY3TN88UtDtTPP2sI+GFv5N4t9HGk05tVLv1v5GwrN4+1SAxAcIWXur6uOl3wtrfxjiDQzQUZ2WeDLssQQqq4osMeFBozcO2kiYoumeG958mP1dV/x5LJCDKefSjMeXcSYPFewt7HouSqK+ZGtGZR63b08/iRbRD54t36iohsF1G60o61e8yLqnoZWuYIJMn/CgV5veLDaXMKPgpbPN3RfIcbMolYzVmZNPTAjzjKFdXgh9Kl+Cj9SMxM03Pwm6sKRgMk7sinEwJ/b1cYHSRcKFrofxu2/64i6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoeF6Ow0HpQ69iWE+TIb1vevKeZIDRkmgKSOjhdKfYY=;
 b=rnFyDDeOPfAWqov15mX0V/Djpz1q9LJLlrvs3QeRQUeRXozaJQfeYmhP074pzZdmubHc+dOkPEYV8BLMrEiR6OiOJ4R/62viN0z8P/OIJO2BQAm8Mc8ZKgK9Nx3fJDa/e4JDsL1p3CQZRbvT3IhvKUNolqzlR5rl5zhUFSjpoaysDiK6yZcziImfjwMxZ8fyrmrj3YvhaM889A83I8nAP/hqu7nezmNR9ACTgvAQq03LzJPMt19ioK4z0vWXlwE5taOrfvZgSoC21qnb5anOSO6AEXcT9TfEsNpD+RefdsPk1fYZqzkudTD8e3Ocv9nSFG8Ym/990mPrd9yLYlnqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoeF6Ow0HpQ69iWE+TIb1vevKeZIDRkmgKSOjhdKfYY=;
 b=HfOGP9sgUWmzPybo0gnf69OiZvt8TQHv0TTWDJ6qtjjZo3UHP6HKFe7xMWG4/jRubnX/zzjK/zpBJGh9LNmrD3t2aMP9hHsrtN+L/98gdeBr0C6UsIu34erYKJoVjDKAfNx80/M1avPKN+Gv68cKza+x+AY0S6Z2aeFh+30eQWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 19:03:09 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 19:03:07 +0000
Message-ID: <11a7b4fe-725f-4920-8dc6-b1241941e93c@amd.com>
Date: Wed, 19 Aug 2026 13:03:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/display: use halving distribution for all
 encode-to-linear curves
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
 <20260819161106.27702-2-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260819161106.27702-2-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 92019010-ac95-4125-13a9-08defe24810c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|23010399003|1800799024|376014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: otkrcQ2J+p76GSeAhDVvvNU5AbtaRiC64ErI7gP3vSMPPMWnesOLJTjwluQwBjHLjc6EIY2Nv0sHrd9jEYO8xluv5i7PbNJ6iRtcBE/YWv81Ul6lXiloZ+qKHnG0qmIbl+ACXCNeeUA8x0yHp17+ls4JHH/kTFy+HEzS49RXBTlpflx/q0dmw6tDE1iekH/1W4ephsDzic8hcpiZ3GoQVVEwBnrdUOB5IVx6vtsuuTCbNQl99mKWZSojW44sD+cSS8eYPF1qezcfOFvAYx+V3itmwPuqg1VOFTC4RUCztczFpTHtAcktz8PsrSjlz36NmIKwMkzDRwLLB8xRgN0ySMVSTpfYlcWcOjyGlqw/HrdEzivfRZb5+n6Dc9sIsuccmcL3efIAh4Vh/Kw3dXBiLW8SKQ01ZH2CH0Q2RWJv2fVPIVSjI4MhcSdoYkGNINKgNPiAnGjlFKDMuINs4HCTY0p7qfsVOuoiJBj1dy9ZIK6Rpt4unIjgV+WfQfbezjNn1+6Y5b6H+0X3+qtt9GuvFK5ZWJJDZx23IzuNyBwKfhmc9ePuKO69fLsDkhZ4NDSHmdbLEYnb1LeyWPDNzNiHJttp2BVJ6HfSh2ikavyukkrlxAiHf+xk5YDQmOqjOck6H+69y3uS9TXzNSEHOhV42Z9zO8ens2Rf7wDSZmi2QYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjFuNk9vWXB0eSt6Z1A4dVNEaE5aK2REd3VaNXdpaUVYNEtBblBxV25OK3Ny?=
 =?utf-8?B?NGhoY3lyY3BHd2NWTjVLeEROa3RLK3BBUW4xNkhEQWNOYnQxZ0NmOHNxQzhM?=
 =?utf-8?B?L25HTWwrWW1WamdEdXk0bGJCRGNQUmY0ZlZWL3VWTDRGWm1OeDQyekpBcXUx?=
 =?utf-8?B?YU9RcnBGbkNNeCtTVWVQdDVTSHIyZ1c2ZXQzK2pMejMrbnVHSjlRU0RCQXR0?=
 =?utf-8?B?ZTN2NHpTV1pYbFQ0QytGVFEzbHg2TlJNaWdFbGQ3V1kzTlJONVRzaWZQOFBG?=
 =?utf-8?B?UUpYM0w5Yk1vak10Mjh5Mi9iQ0FieDFPbUd1R25pUStyZDVpZVJ1QWhXbjdO?=
 =?utf-8?B?L0VFRzVKODB6dGdOZXpRQkdQV1N2TnB4WjgyU1ZOY3AyUk16dS82YUYyTlpB?=
 =?utf-8?B?bVhzV3R3aWpicGsrdlRtM1Z6VmZCb3prOUd6VE1NNk1NY1ZTTENsWXJpVVZQ?=
 =?utf-8?B?R0Z6L2lHaVk0cFA4K3JUY3N6NWNqY3V0cmtBOWxYanc2Vi82V2w0OFQwTjFE?=
 =?utf-8?B?Y1lWRU5ZWDF0OXFIUFMvN0RsMEprY0I1MU1SZHRTd2VVV1JMZ3hEUDJKWVNP?=
 =?utf-8?B?T3hJbTdnYVZDdmN3dGdpT1pXSVpKQnJleXBzN2JxRWs3eXVjcVRhTURCM2RJ?=
 =?utf-8?B?d08yYUQxZVJzOWlIQWh4R3pXMHRHQTlBYnQ0Y3BOUlczeGlqeU9GeERXZ3pt?=
 =?utf-8?B?bEJ4SmdtNEt5aTU5VVpwUlBXeUYwdmd1WjVKcnFkNUxDSWRtRC85ZjRIVXVZ?=
 =?utf-8?B?Qko4K0IxZHhYOGpocjZ1MjByc3Z0OFpscWc0RzJNRVpST2gySnlPNDVhWmJ0?=
 =?utf-8?B?M1hPSkR1ZDgxOWNtbEJLbG1PbnRqeGloV3FHYUlDaDVvb1VYVjNWYWpvSGlR?=
 =?utf-8?B?ZnE2eGFGMldmSzRTdHdMa0lFZkQ0WFRjS0F2U2pHMHNXcVM5YXNPYUhxY2tk?=
 =?utf-8?B?UE1rTkcraUhPS0haSEV5dW9YTnIrK1pwTXg2Y3BUQkJtYTlBRGlDTHN6aDlH?=
 =?utf-8?B?N3pnY2dOdjhYNFNBMG5QdkVqa25hT0p1TWpYbDdYWXZESk9FQ2RJVUNNbW9F?=
 =?utf-8?B?UElBZURtS3BTZDNTVGptd3ZFSnJmWUt3eW41Z2xXRVRwM2NrbUNlemF1eGQw?=
 =?utf-8?B?dGxMK1Z0bnNDeWpXMklmSm1lMEtkanEvakhjSUYwNFkzUmgrdEJ4eEZ2V3Zk?=
 =?utf-8?B?UGx0cldjbnhuZ1B5WnVJWUxtWmljZUZjV2tlNHhkTkRhdWtzTElWRjF6cEl3?=
 =?utf-8?B?dmVqRU5vR0xVRTdsQWZieTB1b0s0R05uVGFRU1Z5MzZLTTArajlkcllxSWtJ?=
 =?utf-8?B?dGVEOGVUcFRaQ3JhRWIwT2hkaC9VWm0vYnB6N2JXYWU4SDVaTWVsOFd5bFl6?=
 =?utf-8?B?c0RiQlA1WVFjeUtqSDA3Y05DR3JxZHp5NSsrMmdRRU51MDczWkhoWnJNTmth?=
 =?utf-8?B?N3lPZ3IrOHAvOUw5WFZBcUNSR01QWlBCdnBLcUF2bkV6SkZ4ZDdxV0J2dGor?=
 =?utf-8?B?OUd1UG12Mm1CZ0Ixd2tMR2NTZXhRMWZOdmZHdGVlaXJCbzNFa1J1WnkxeEtl?=
 =?utf-8?B?OEpDTHUyQjUwQi92cElEak8rTmlqaitiaEZPU1R1TWJrd3JGMldZR01EeXps?=
 =?utf-8?B?VXBNaG5PT2gxV1RxbzlQS3k0VktHMGcrT0xWeFRGWU5ZZmd4MzZJN3Y1N3pV?=
 =?utf-8?B?emRtTUZmSEpkaUxGandjVUtWWmVWRjVEUHAwNnpPTEFnZFV5NUxIRkNaSVpE?=
 =?utf-8?B?aDkzRW0wNk02Q01kVnpqbnZURnVFbGpmTTV5dWEwUWw5TkZLVzlGZFNnTGRY?=
 =?utf-8?B?WUNLSm00Wmx2NEl6UmRyL0NBTGNxb0NWVnRVZlF3MmdzVU84Um1mT3BDbVk5?=
 =?utf-8?B?Mk1kbzNoc3NYdElaZ0tmVW5xNlh1UURDTFFWWFROaTVGeEptRXQxc05WaTRC?=
 =?utf-8?B?WmRLR3ExV3dUdGRlcDdsWi8xSXhFVkF6U2lZZ3FXSXZwRFVHdXl3NnE2U3Q0?=
 =?utf-8?B?cmpYK2pSbWw2cmF6STh2VGFVS1JEVGZCRWNhSElmWDdaRHBKa3ljSGFOOWow?=
 =?utf-8?B?VU82YkdoNSsxdGtaOWNvS2R5UkVwWGhsZHR0cUpyL05hSklIUWVZVExVVHUy?=
 =?utf-8?B?VXc4UHFtZmNSZ2ZMOTFvdnE3bG0rM2cvSWcwTExKMmZiQnZxYnMvL1ptTzlU?=
 =?utf-8?B?TkM4bXFiUkdNSG5zVXNzTTN6c2I0QXBNOWhhRG0wbGoveVhGaGZCQWFGOVNa?=
 =?utf-8?B?TUxrY3MyMksySWpBSUZGc3c2akdXdHJyVTh2ZVJ6OGoyTW51YVhPbDE1WEVH?=
 =?utf-8?B?NUsxOXFMKzRnRGdmUDhXWGVVL0NndkozanFrbGQ4VzluRXFsblhjZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92019010-ac95-4125-13a9-08defe24810c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 19:03:07.2822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmhXxWB0LhlLDYRoUnJQ6Z6PYME47oWZKVByNNyPYgBObgLL7oyHrjvMLw5ZVF1pq0Gwu31h+iGhe43CNAmx8w==
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

checkpatch reports the following error and warning. Are they intentional?

ERROR: Please use git commit description style 'commit <12+ chars of 
sha1> ("<title line>")' - ie: 'commit de17c6bb7072 ("drm/amd/display: 
use halving distribution for PQ/sRGB linearizing LUT")'
#13:
any encoded input, so remove the PQ/sRGB condition from de17c6bb7072 and

WARNING: Possible repeated word: 'segments'
#67: FILE: drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c:349:
+	/* 9 segments
+	* segments are from 2^-9 to 2^0

total: 1 errors, 1 warnings, 47 lines checked

On 8/19/26 10:00, Melissa Wen wrote:
> In encode-to-linear conversions, LUT entries should be uniformly
> distributed across the input range: non-linear encodings are already
> approximately perceptually uniform, so every input code carries the same
> weight. A fixed count per region does the opposite, concentrating
> entries on the darker values and leaving few for the bright end, whereas
> halving distribution spaces all 256 entries uniformly. This holds for
> any encoded input, so remove the PQ/sRGB condition from de17c6bb7072 and> apply halving to all encode-to-linear operations (pre-defined TF or user
> LUTs).
> 
> It fixes the following IGT kms_colorop subtests:
> - plane-XR30-XR30-srgb_inv_eotf_lut-srgb_eotf_lut
> - plane-XR30-XR30-gamma_2_2-gamma_2_2_inv-gamma_2_2
> 
> Fixes: de17c6bb7072 ("drm/amd/display: use halving distribution for PQ/sRGB linearizing LUT")
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../amd/display/dc/dcn30/dcn30_cm_common.c    | 34 ++++++-------------
>   1 file changed, 10 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> index 66fe7f313ea3..62ca235cd649 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> @@ -320,6 +320,8 @@ static struct fixed31_32 interp_tf_pts(const struct fixed31_32 *output_tf_channe
>   	return value;
>   }
>   
> +#define NUM_DEGAMMA_REGIONS    9
> +
>   bool cm3_helper_translate_curve_to_degamma_hw_format(
>   				const struct dc_transfer_func *output_tf,
>   				struct pwl_params *lut_params)
> @@ -343,31 +345,15 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
>   	memset(lut_params, 0, sizeof(struct pwl_params));
>   	memset(seg_distr, 0, sizeof(seg_distr));
>   
> -	if (output_tf->tf == TRANSFER_FUNCTION_PQ ||
> -	    output_tf->tf == TRANSFER_FUNCTION_SRGB) {
> -		/* 9 segments
> -		 * segments are from 2^-9 to 0
> -		 */
> -		const uint8_t SEG_COUNT = 9;
> -		seg_distr[0] = 0; // Since we only have one point in darkest region
> -		for (k = 1; k < SEG_COUNT; k++)
> -			seg_distr[k] = k - 1; // 2^(k-1) points per region; halves as k decreases
> +	/* 9 segments
> +	 * segments are from 2^-9 to 2^0
> +	 */
> +	seg_distr[0] = 0; // Since we only have one point in darkest region
> +	for (k = 1; k < NUM_DEGAMMA_REGIONS; k++)
> +		seg_distr[k] = k - 1; // 2^(k-1) points per region; halves as k decreases
>   
> -		region_start = -SEG_COUNT;
> -		region_end = 0;
> -	} else {
> -		/* 12 segments
> -		 * segments are from 2^-12 to 2^0
> -		 * There are less than 256 points, for optimization
> -		 */
> -		const uint8_t SEG_COUNT = 12;
> -
> -		for (i = 0; i < SEG_COUNT; i++)
> -			seg_distr[i] = 4;
> -
> -		region_start = -SEG_COUNT;
> -		region_end = 0;
> -	}
> +	region_start = -NUM_DEGAMMA_REGIONS;
> +	region_end = 0;
>   
>   	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
>   		seg_distr[i] = -1;

