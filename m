Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EEACA0FF7
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 18:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52C910E3FE;
	Tue,  5 Sep 2023 18:48:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888FB10E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 18:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2TTC23YQNT6bMekHQh4yePuCYcKQgXgH3wGAqukbcULuW0hQ3DJUDozJWPSGuHAGdMV4QswHeI5W5U3wpBNN++RuK6xx/KNBEKCA6a/MAFEnCK97O47BPwkdF0JjH5xgD2KYv4yXl2nej/MDqk3PG+Nzp4ZI6isae4qmIdf29IT42PT8EJ5G3dWnjBdNILTeI9pW5y0YhHUTIcxyGg22M5uqiu3me9OdNm1CO+c4jz9/u904vLHIFKVIHsrmLGJZMKNYZxz5PYnytCmlHZTAdKkoEXtivOu+nG0YcSVC/Wq+l382iMm5acpPbUnrs1mqFpO/CbNZYEr63ssAF+45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5nFFOQjdRa2SeR+aPjT8DCjvp01VDyX+GVeyJzwT6k=;
 b=EP1o1w2tdcwH6WT6WGg5YECuuEj9GCTiU5Ij93JcByKUU/lJ0RGZ5D77creybJFYJ7SoyVvzfAXMEqNtuyleVL38TvjRa1QMOFcNh6APDKiCmb3F63UNwtscXry14W+xo3y5MHxVgO7CyNtqC0fmNYVJ4ZNqoO4rFF4O/0l9ihv0hPrgICQn3Ftgl2ZpAzzWYdzwS63bPTyO4IraHo/Gg10zk/WnbmCU4+BWcghkpOyW4+hJYRt6lRubYwHbMbLzRYv5gsWwQoaj8545M4LolOC55xMqnZ4/b0VJ4CgsFtMLB9mF+vgQ+zQ3FqTOv0b3l68atz8smTgRYnq+69e7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5nFFOQjdRa2SeR+aPjT8DCjvp01VDyX+GVeyJzwT6k=;
 b=JSoUhTJgaBWfIGVH3BeufkF6ghKl3f08kyAVaQAAtJuilLGBWNh4XtpO8e0qNea37yyk76g+beeZOqlTKYe87FRtPGy8tpW3ctgEjpSLhk+IiElZN0XHoKdFFW67En5Wp0xbfJbuBwcCgSO/CgNa68E1Yx3qfDFI9asmedfC5DM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:48:35 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:48:35 +0000
Message-ID: <fa49adbf-4112-2da4-1d12-4d2d2d00ae46@amd.com>
Date: Tue, 5 Sep 2023 12:48:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 07/18] drm/amd/display: Use drm_connector in
 create_validate_stream_for_sink
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230816212626.987519-1-alex.hung@amd.com>
 <20230816212626.987519-8-alex.hung@amd.com>
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20230816212626.987519-8-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b409e59-fe96-44b8-2910-08dbae40b529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQT2cwf2smtNOKNHNew/tiQVhQtg0L1wcVZrs7MR88BYVzv4jSNBHMf10pOEsicVEjE9pmSPqCLZy/NwNnGPE/tczq9WnKfjqbhU2a1zRxdK/mJ4sCUaxVMdDocUBSc9A7oJ7g6oA43NdfS9dPb7kgckKbprMTVT8yT+1E2FkbD3y9AoZN9VP2ox+pi/PThxOhjghN4enmPRXgzLvtkXNiJtWK0knO7l5OeYRppSb2yRLWX/H6DUVN9LdmBblCYqgRmZuSFSCJuDPhB5VcLTgWxlR0c8A4E6nhD27p8PQ10B1u4FrVqiOvsoWniH0tC7vhNah4KQZWXCe2k/sTkTsHxdBWKqQAoeiRU13RzMdhr5yhXs5Q792TVlWGD5Xc1zdUNgUr28t8PFjo5zhPLokzaFm4/AKLbjoik6wKd7xZTsfIqj0pa0h+kPe0nELh14LOUsCJaSwxblfbslSt1/9d5f+9Sp1pZBUXkpPLqK06HlXtx5cWacwkW3BHsysM9YiEYtXaxfQ2slBlzhIYq1UEgarfhz19QrzkOckA8pJAU9l87JOat2ja5aIpM+NIP8y9qBhRxYFDmlZEY5R1XwTwJbhhmqJUClHOY7oe1OTVxvn8k05o5AKFSjRiylWEAwj/BavjZA6tGBhPn1j+umkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(186009)(451199024)(1800799009)(31686004)(36756003)(53546011)(83380400001)(8936002)(31696002)(5660300002)(4326008)(44832011)(8676002)(6506007)(2616005)(6666004)(26005)(86362001)(41300700001)(6512007)(6486002)(478600001)(38100700002)(2906002)(316002)(66476007)(6916009)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVxQnJqa04vRDU5dFloRVhtdGVlcjJ0bWg1cmp2MmtKOVUrdVRINFE0VHNw?=
 =?utf-8?B?TDVEbHNKME1aZkFDamFhYUxNcnVVRXl2WEVLNzkrK0NVUU9VQ2E1S0FYbkJr?=
 =?utf-8?B?UlRZcUZCTzJqSTJ4UC9YZFZlSVB6Q0wvUVlpeml6ZzRFQmxWUjFDUyswYXpp?=
 =?utf-8?B?TFVGenRWNCsvZjl1TU43azBHUElzQTIrTUhhcHc3QWpZQ1pZUnVOT1h3ZU5n?=
 =?utf-8?B?NW02azBFY2NmeWVaTjZWYzM0c1JjRkNnMThJeGlueFBRWnFBeU1qTFF2ellQ?=
 =?utf-8?B?dkVHZHJPQlI5czlDTUlQL3cxVW1DSXdjVTNIcW5MSEtlL0FpN0pQMEZBdkVS?=
 =?utf-8?B?cERaWDhjeDZNbEl6UVZKQVMxRitERUxCVXZsMkpBNzcvKzh4aDZjSEhNRnFF?=
 =?utf-8?B?dDdzYXdmSFRaWEFYazdBb25BZ1ZIcmozRWNZNmJvQmFsdDY3ekJPOU1PS0V1?=
 =?utf-8?B?UlJmamRXYkpLNWFnanFYclN5RW9mY1gzSWliOTJPU2w1TTY3TjNpcWxjdDJm?=
 =?utf-8?B?a1E4MVFCeWViMFg4RmNpN0FDcG1jR09OQVB0Rkw3cEJidUlXL1dGaUlxNGI2?=
 =?utf-8?B?Z3o0b3Z1Qnp3b1NIeFltL0phVG1mVk45Z1NzM3lkdmF5bEFRLzJtUmtuYjdK?=
 =?utf-8?B?d2h3MlBzQmo0SEppYWJFemlXMDc1eW4rOHdIQmx6a0loNk0xcE8wc2tTTFI0?=
 =?utf-8?B?eWJEbmhIVHV5dEJtR3c3Y2ZtVktKU1BzSXRwR2QwY0hmcjE4NTdwU2tiek53?=
 =?utf-8?B?NnpLM1h2ZUZCanFjbWFxZ2J5NVlNd0lnVHUrSnRhcmNzMWlWT2xLMEVOdVZY?=
 =?utf-8?B?T1M1VXBJNmZOYmlEQlRVZ2szUjlKUzNDdlhVZTd6QXkxbEJXOE9ZTXo4KzNi?=
 =?utf-8?B?a1VUQVBCVy9BY0hrTnYyUyt1MnZVRWMwUDFoV2VKdFF2cWxVNm94dkU1MFpz?=
 =?utf-8?B?alNPa3M4bHdoTUVZRkRIK2x5MzZha0U5SHRmSGZSOGtTdHk3YjNxSVBOd1VD?=
 =?utf-8?B?RnQzekM1VWNLejQzVXpFaUE4a3VDSTdNQWFTc2lwYjZYVnZVcGczWG9kbzRC?=
 =?utf-8?B?ajk4SHVhSVlyYUp2Zjdyd05VUE94Q2lPWHZDTkxqZzMyWEFJQ3hIOEJtQTRJ?=
 =?utf-8?B?cWtHdUJSeUg3UzExdXEwN3VRcytnVXZiYWY4dlpVVDdYL25kNGloeWdGYWp4?=
 =?utf-8?B?eEVRVnU3MDR2MUtna0hCZXpDc25pTml6S3pJTHVUdWRXdUI2RTNRZWxDckNT?=
 =?utf-8?B?Y0grZW5lNUNEbDREcVliNjVTZ3ZZRkhZWDZBR1dvR3dzMkRoeEplL3A4TGVq?=
 =?utf-8?B?TExHQUZySWxtVXZZaUk4R1FFUmpFZzRqSW0rbElKNE5sZnZKbCtKekY5YzJJ?=
 =?utf-8?B?UWFOMXJ2MHFBVHIzRkdTcjk1UnFHVUljUkg1UUdaNzhxTnF0QXQ3Uk1xRDgr?=
 =?utf-8?B?MGVveWJZWnlYdzN2R3pheGJFVkt1TW0wb0RkRVQ4eVlGV0gwS0NJNGNiUUpK?=
 =?utf-8?B?TlRpb0tUaUVCcmZEU25UZHZENmJ3K0g5d1JoNGdsYm1pcFRUTnFXdXpnc3Nz?=
 =?utf-8?B?RHZWWC9aN1A5dnFrNG5jbjY1a2djV0ExRW8waFMwbm12TklpMDRwUDFWejVq?=
 =?utf-8?B?WDFjRGFLOE9xUDdyTFFtWEVSVi81MlR1WGVoYnh1ZFZlcTR5TG5jOGY2YU4z?=
 =?utf-8?B?YjV3bCt2ODU2SGRzSFcxNU8xZjc5OGY1RFllMzNMVGp3K1BLM1JXSkd3a09i?=
 =?utf-8?B?VUNINnpMTlRTR0lFc3l6a3M5MUJ4UXNiWGJ5RzVObnVuREE1UVRmYy83QVVG?=
 =?utf-8?B?WitQVys5K0taMklzb0xPSHJBb2I5NEl5WWl4WjNLVFpPeGZIaTVOQXdjVTAw?=
 =?utf-8?B?RDA5OERvT2Z6UStJdXJ6VGxkdnB6QWdUQ05iYXk2eWplc29UdVE5bnJ5cXk1?=
 =?utf-8?B?c1NuZFhkMGNmVVNPdW9RaVUxd0w3MDBYWjJiYnpOWFlrb1dPSDNPVzhNUHRz?=
 =?utf-8?B?Q0NlVS9ob1A1WlI3cjYvUE9GWjlhSGlWbHFuWVhDZnI2dkFxSk1vR3VMS2xI?=
 =?utf-8?B?a291MEI4M255RFQxM051R3llaGlPaUpscmxRZTFFcXFncGlybE1RT2pUTzR6?=
 =?utf-8?Q?BH4d3tpxva/CTVfbnmzRF1u0j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b409e59-fe96-44b8-2910-08dbae40b529
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:48:34.5078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGoILh4gpUWDKofa0TF5r5ttIwqbHugrumOJtgluFsTp3SQPIDwhwgK5KZL0Gd5E3YVsMrgWkX3KZA3ERVw/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2023-08-16 15:26, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> [WHAT]
> Again, we need to use this function for writeback connectors,
> which are not of type amdgpu_dm_connector. Use the common base
> drm_connector instead.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++++-----
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
>   .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  6 ++---
>   3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a7d2a3f35f74..33e7c463a0d0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6546,18 +6546,21 @@ static enum dc_status dm_validate_stream_and_context(struct dc *dc,
>   }
>   
>   struct dc_stream_state *
> -create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
> +create_validate_stream_for_sink(struct drm_connector *connector,
>   				const struct drm_display_mode *drm_mode,
>   				const struct dm_connector_state *dm_state,
>   				const struct dc_stream_state *old_stream)
>   {
> -	struct drm_connector *connector = &aconnector->base;
> +	struct amdgpu_dm_connector *aconnector = NULL;
>   	struct amdgpu_device *adev = drm_to_adev(connector->dev);
>   	struct dc_stream_state *stream;
>   	const struct drm_connector_state *drm_state = dm_state ? &dm_state->base : NULL;
>   	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
>   	enum dc_status dc_result = DC_OK;
>   
> +	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +		aconnector = to_amdgpu_dm_connector(connector);
> +
>   	do {
>   		stream = create_stream_for_sink(connector, drm_mode,
>   						dm_state, old_stream,
> @@ -6568,10 +6571,14 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		}
>   
>   		dc_result = dc_validate_stream(adev->dm.dc, stream);
> +
> +		if (!aconnector) /* writeback connector */
> +			return stream;
> +
>   		if (dc_result == DC_OK && stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
>   			dc_result = dm_dp_mst_is_port_support_mode(aconnector, stream);
>   
> -		if (dc_result == DC_OK)
> +		if (dc_result == DC_OK && connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
>   			dc_result = dm_validate_stream_and_context(adev->dm.dc, stream);
>   
>   		if (dc_result != DC_OK) {
> @@ -6593,7 +6600,7 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		DRM_DEBUG_KMS("Retry forcing YCbCr420 encoding\n");
>   
>   		aconnector->force_yuv420_output = true;
> -		stream = create_validate_stream_for_sink(aconnector, drm_mode,
> +		stream = create_validate_stream_for_sink(connector, drm_mode,
>   						dm_state, old_stream);
>   		aconnector->force_yuv420_output = false;
>   	}
> @@ -6608,6 +6615,9 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
>   	struct dc_sink *dc_sink;
>   	/* TODO: Unhardcode stream count */
>   	struct dc_stream_state *stream;
> +	/* we always have an amdgpu_dm_connector here since we got
> +	 * here via the amdgpu_dm_connector_helper_funcs
> +	 */
>   	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
>   
>   	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) ||
> @@ -6630,7 +6640,7 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
>   		goto fail;
>   	}
>   
> -	stream = create_validate_stream_for_sink(aconnector, mode,
> +	stream = create_validate_stream_for_sink(connector, mode,
>   						 to_dm_connector_state(connector->state),
>   						 NULL);
>   	if (stream) {
> @@ -9304,7 +9314,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
>   			goto skip_modeset;
>   
> -		new_stream = create_validate_stream_for_sink(aconnector,
> +		new_stream = create_validate_stream_for_sink(connector,
>   							     &new_crtc_state->mode,
>   							     dm_new_conn_state,
>   							     dm_old_crtc_state->stream);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 5a8d07a27e9b..a2d0ab881c44 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -828,7 +828,7 @@ int amdgpu_dm_process_dmub_set_config_sync(struct dc_context *ctx, unsigned int
>   bool check_seamless_boot_capability(struct amdgpu_device *adev);
>   
>   struct dc_stream_state *
> -	create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
> +	create_validate_stream_for_sink(struct drm_connector *connector,
>   					const struct drm_display_mode *drm_mode,
>   					const struct dm_connector_state *dm_state,
>   					const struct dc_stream_state *old_stream);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 1975b9d96cb8..687dba32cde3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1495,7 +1495,6 @@ int pre_validate_dsc(struct drm_atomic_state *state,
>   
>   		if (ind >= 0) {
>   			struct drm_connector *connector;
> -			struct amdgpu_dm_connector *aconnector;
>   			struct drm_connector_state *drm_new_conn_state;
>   			struct dm_connector_state *dm_new_conn_state;
>   			struct dm_crtc_state *dm_old_crtc_state;
> @@ -1503,15 +1502,14 @@ int pre_validate_dsc(struct drm_atomic_state *state,
>   			connector =
>   				amdgpu_dm_find_first_crtc_matching_connector(state,
>   									     state->crtcs[ind].ptr);
> -			aconnector = to_amdgpu_dm_connector(connector);
>   			drm_new_conn_state =
>   				drm_atomic_get_new_connector_state(state,
> -								   &aconnector->base);
> +								   connector);
>   			dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
>   			dm_old_crtc_state = to_dm_crtc_state(state->crtcs[ind].old_state);
>   
>   			local_dc_state->streams[i] =
> -				create_validate_stream_for_sink(aconnector,
> +				create_validate_stream_for_sink(connector,
>   								&state->crtcs[ind].new_state->mode,
>   								dm_new_conn_state,
>   								dm_old_crtc_state->stream);
