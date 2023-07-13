Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8940C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 18:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE8410E084;
	Thu, 13 Jul 2023 18:03:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD46510E084
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 18:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGzc6nv5c2wU9GiRKNO3+RBxpiaNsci9CNiEEejyX/5aMQti7zdZOyG8bAk8YTBpBryOyTPa/hNO6gPK8RFem1iBD9jx4Hz7Y89/Gz1au8wqv2+E+DHZ9/K437dhWEJmYJ3tmGqZG2qpc//gdjCLC7AZZ3Hq4Dp8yklNp2fEWDGq7lKO8/YagPJGNFFiQPNtr8H2QNYrEEnc7F+eCiK7cubgJPKFyWGdRm0JvSAvi3bKKOpk8ODnVIboCyxoahzJsRZ2bdi2B5plZYFl3tVbaR7OyBn94EcSpBKilpJiCsbHSB14RPvFydm/n8MVWjQTiY7ae5sqJ0KBcn2Wl05RWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2GtUn8fS71qeR7mRzxjsR4klJy2YkCfAygM+ZDpMw4=;
 b=Mz9EWH+1KVELgq5diMwZQzWSLCdxfitwVbyOYtYYuHZlFvxgJZtbLvc+qISf++pwNkrFGf5MsvDGcPVttr77tsA2KuzB+160/B0OSJhakhxcBZGIlii4lubWb2dt7uMljqTY4qlaqfo8/z+Jrtwojl71uNxHf6QEUWoaNW9g1U+v15b3CB+hNI4cg+9k2B/3FRqpCsKl/BvNOFodzOMX3jR0iTIW3Rvfs37tUYBYYt32Kn48QvKILHzF7VmYj8xlCIwUgx+gpH06WbpPrfufeGFTjkceJ+r/yvT0zUTUZwFyNqUOlCe0E0SmnVNqHh33m1v5EsDbACIWKANNB+Ad+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2GtUn8fS71qeR7mRzxjsR4klJy2YkCfAygM+ZDpMw4=;
 b=Agerkd/drwuU5ICRx9k9Iy6aN7DPgb++GzNJTNct8/jHUw3WbiIdzmi9gvNs/LjpBFE9xv32cDTKranJQqNyCSnUxTrppQ+rHozBhd4/5n3pCNEuIQFGbIkL6F9zCv6889fT8SHDXwODYOb5FpZ8HD48nip+lQMd0rJ2nZZ0na8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Thu, 13 Jul 2023 18:03:36 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::68b9:3f7d:ca38:31ba]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::68b9:3f7d:ca38:31ba%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 18:03:36 +0000
Message-ID: <32bef6cd-7085-f6b5-ae4b-951c9de51504@amd.com>
Date: Thu, 13 Jul 2023 14:03:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] drm/amd/display: Expose more formats for overlay
 planes on DCN
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
References: <20230709020700.3116749-1-joshua@froggi.es>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230709020700.3116749-1-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::12)
 To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a6139c-b7b7-4b5b-854a-08db83cb7a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sA8jld0IGYOrOc5sdH07MEmjmAZ2Eft5iI+ekI+GNuo1/c0O2qp10SESq9yDXujJalEpZKLfkbKks3OlKutl2AcKymHF/50s5FCp+/elkuO0LqWflPAw4xW95nL7ZfSo2WSODRHA3V5EabQkFgegFqJrOgDlARPlOARupav6FfM83EpkT80X3ffJ9XEkn0KvW6QNIWDanjAWIM2LiZ6c4VNBMfZ7MakOmr8HTh+4z/5COtdeuRRY2j0mdO/rK/TYXx5QTkJYrXeDDFxbRXqm8eP3nKp8wAFw0IUSFt50gmRRWPPbRYEtSX+DuSHRHRfmcTJDTI3ist5Z4tUmvjXuXOi3JvQoLLyTfDllfuUBLmTTOhUdFB2hExNoTL6Y9UWsDAf+W9XwYUFH2gdFMRb7dbS/OLB92YcruZH28+aFQ4ajeEMm9OKi0FS5MWLi9qVeZ+t/0SOG62AS0mHOozdX6d40aKj3byr2lM2PPyR6uB6lGeHLanxtp6VWQW4Fzy04yQ43KgEUQS3iTbRQlUH27Zo3DtMDQcXkJ5ARk/GmiokBLQNGNzTcfKzcuIzpRbzh+PuMuoarlmhQG52MzMl3YqsdPiTbwBxUOxzjsUUUwThXZFcvGU99iaBmo1aJQJ8wuBJzI+7a17iLMKsCa1mCAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(41300700001)(44832011)(31686004)(2906002)(66946007)(66556008)(66476007)(4326008)(5660300002)(478600001)(316002)(86362001)(31696002)(6486002)(8936002)(38100700002)(6666004)(8676002)(6512007)(36756003)(26005)(83380400001)(6506007)(53546011)(186003)(54906003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZiUnBoS0ZFOXVtaTJnYmFXUG5lanRrLzhKVXNCMnU0WTEyanhUQlFXMmxP?=
 =?utf-8?B?RkV4Q2hKUGtJeFFQeUNsUnI4VnNxQUNiN2lkL1MzMGdYbUNTZWtIYWl1T2FX?=
 =?utf-8?B?RitHYUE4dVBxS1l4VmhGYVFVbFZhN0dQT1B0QjZ2Z2xLSzFLeVpKQUZZcEQr?=
 =?utf-8?B?Vm9SOHJESEdwQzhnbHFoTktvNGswV0ZGQ3F1a3VWaWt2Myt0L0FXaUducUlh?=
 =?utf-8?B?NjlhUjZocmtDUTAvVUpNWWxyb2l3THgxcmhXN0ljVTdIakZkT2gzaUFlL1Vu?=
 =?utf-8?B?VWw5clFSRzN3VGFvbnBCdjZZc09VMkNRSFA3RGFqdHJkcTFwYmUxa0EyTGg3?=
 =?utf-8?B?QmlIK2h4MWs5WVBad2FSMUxxcnd3RzJHY2IzanhERzZSdTBZZUxKMlhPVy9r?=
 =?utf-8?B?MXMrTngrcDRzQ3VFQlIxK1J3OVhyQVpoOE1YeVc3QTdFZ0NieEh4bTZnYmda?=
 =?utf-8?B?TmdpTzBJb0xOTnBDVTZqdHd2ZytNUDlYUWlUc1BoODBhVHFkZzZibHlDam9R?=
 =?utf-8?B?Wlg5RURMVEkvamlMeDN4VWpFU0pYNlhFNHkzc0lOcklXVGJKVDYxL29vRnA0?=
 =?utf-8?B?RWlCTm5TS010elBkbDlWQWNTT1NoRDRjYkljL3dXaXZLT0JQdGZXc0VYbGg1?=
 =?utf-8?B?d3BhN3BJc2xOclVZRlZRUjEzczhXUkxFejlCMzhPYUFncWR1TzR0QnFsQVpS?=
 =?utf-8?B?N25rbkd0MzZTV3RJOXl0cDlHT1pDUnNMQ0o3eXF5QzlhWE12Q001TWtad2dw?=
 =?utf-8?B?Y2RxNGJuWUdPV2l5SDZFdk1ScmdwK3FGYm14aWxHSUJKZ29nK29la3hiS090?=
 =?utf-8?B?cHZESjNzWGs0MTZKNmtjR3NtVGlRWU91emQ2MlBMYkFML0EvVUhoSGNIYlJ2?=
 =?utf-8?B?RTIwVUdXU1h5Tk5uTkwxNVVaZ01ib0lyUGtHMUFJdHBtdHN3RTY2Z21wMTNO?=
 =?utf-8?B?K2VHOERvbmdockY3UWNxVEFJSnl3VVdITTRDNUY1TDJscnFVTDg0R2ZJcFhp?=
 =?utf-8?B?ZGJpY2J6MWx4YThyTWgxcEZPQXpNOURIbXkyd1RlNjZpaHBZQ0JBZzI3OU5n?=
 =?utf-8?B?REVJdXp5TlJRSGsxaElGUmp0Z2pwZjVtbnEvZ2VZa0xTRG5sWWdYMFZOaDJR?=
 =?utf-8?B?L3JSN3NQMFR6c09mL0Z2bi9ySDgvb3c0SmZSWkxUWUZnTDdCaWtIQUJpUlhO?=
 =?utf-8?B?YzlVblE0Q0NzOHlYd0k4UUtJNXZmZWYrU3FJNmF4MWZsNnVNL3dXSEt1TlRN?=
 =?utf-8?B?bTBPVFlXaHhGQVhtYm1tb0JiZWQ0eWp5a0RqQ082eWhoNCtDdG5Xc0dMdnNC?=
 =?utf-8?B?R1BCTm9MQ21uNGFzbDlsdXdWVjQ1V2kwdTA4dkZKVXI1elV6VE9QSGVwaVVW?=
 =?utf-8?B?MGlHU2RrMTJRQS8zeWhBd292ZXBlWHM3WWdhNThxWXQ4bHJ4c0dPbWJaNGs3?=
 =?utf-8?B?OUlKZEU2dy81aVozQTNNR1l2RTFXS1FNeDJtb0ZUL2pVWnVhM3hNZ2RIVEpD?=
 =?utf-8?B?dEtuWDJicjJVS01aZTd1RUViNmlIUEE2S1lxRFpUSlBwODBLcE1iWmE5ejd3?=
 =?utf-8?B?SWZ0TE5Ga2I2UTFhOXZuZ1ZBSHhtVENDYUFzNWh4azBWYTc2L25yeU9BdmVG?=
 =?utf-8?B?SU5IVXYwQ3pYVzVkb3YxNndSSkFWVEEva2dhRXFHZTFaSVBuNnNPeEZiOUZW?=
 =?utf-8?B?bC9NY1lyVjBwYTVzUlpiUEZKVWxTTHRaWnFRUnY3UzY5ZEhuSUlBV1p6WjVB?=
 =?utf-8?B?TlFuVEhxNnp0cE8xNWttN01odlMwLzlEbmdGaFpoNmpONTNmUGZoaUVMVVNm?=
 =?utf-8?B?ZkVLOXlmUG1zUkFobFo0STRMVnp5SmRTaGU4T2wxNUc1eVNTR3ppUUx3QllQ?=
 =?utf-8?B?bkpOc0JxNVZTUUVRM0xlYjBYYW8xN3FwSGNxUkpDU2F3WTFWbUtIZmJEMDA4?=
 =?utf-8?B?VC9NSkxIaUtrY013cE5FNjFXNVdRdS9vL3FFMmdSTDc4a01xU2NsSWJvNU1o?=
 =?utf-8?B?WlREUVUvVTROdXgxcXR0aUlJU0RvQ1BGSSttc1VVTW1NUEFZSWR5R1FERUFZ?=
 =?utf-8?B?VE5YZyt6cjdPVG5YWnA1SkZjVndvRW4zNEJtZk5ibGYvcGFyQmUxV3JYOHB2?=
 =?utf-8?Q?eOonPyiSkhyJbOFCh171ybmFO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a6139c-b7b7-4b5b-854a-08db83cb7a8c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 18:03:36.2669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwwtHc8RJg5bCcrsmSlf4Nq6XXxHkVUJQUQSwocnnz4iGngRe3/IrOl/bZdDQx3UA7c4F0n9jzzk1hLKF21nTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
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
Cc: Melissa Wen <mwen@igalia.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/8/23 22:06, Joshua Ashton wrote:
> DCN planes are universal and therefore overlay planes can use the same
> formats as primary planes, unlike DCE.
> 
> Gamescope/Steam Deck would like to take advantage of this functionality
> for partial composition which in some cases in our pipeline, can contain
> negative values in some instances.
> 
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Simon Ser <contact@emersion.fr>

I have applied the series, thanks!

> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 41 +++++++++++--------
>   1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index de1c7026ffcd..8eeca160d434 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -113,6 +113,11 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
>   			DRM_FORMAT_ARGB8888,
>   			DRM_FORMAT_RGBA8888,
>   			DRM_FORMAT_ABGR8888,
> +			DRM_FORMAT_ARGB2101010,
> +			DRM_FORMAT_ABGR2101010,
> +			DRM_FORMAT_ARGB16161616,
> +			DRM_FORMAT_ABGR16161616,
> +			DRM_FORMAT_ARGB16161616F,
>   		};
>   		uint32_t format = plane_state->fb->format->format;
>   		unsigned int i;
> @@ -698,8 +703,8 @@ static int get_plane_formats(const struct drm_plane *plane,
>   	 * caps list.
>   	 */
>   
> -	switch (plane->type) {
> -	case DRM_PLANE_TYPE_PRIMARY:
> +	if (plane->type == DRM_PLANE_TYPE_PRIMARY ||
> +		(plane_cap && plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL && plane->type != DRM_PLANE_TYPE_CURSOR)) {
>   		for (i = 0; i < ARRAY_SIZE(rgb_formats); ++i) {
>   			if (num_formats >= max_formats)
>   				break;
> @@ -717,25 +722,29 @@ static int get_plane_formats(const struct drm_plane *plane,
>   			formats[num_formats++] = DRM_FORMAT_XBGR16161616F;
>   			formats[num_formats++] = DRM_FORMAT_ABGR16161616F;
>   		}
> -		break;
> +	} else {
> +		switch (plane->type) {
> +		case DRM_PLANE_TYPE_OVERLAY:
> +			for (i = 0; i < ARRAY_SIZE(overlay_formats); ++i) {
> +				if (num_formats >= max_formats)
> +					break;
>   
> -	case DRM_PLANE_TYPE_OVERLAY:
> -		for (i = 0; i < ARRAY_SIZE(overlay_formats); ++i) {
> -			if (num_formats >= max_formats)
> -				break;
> +				formats[num_formats++] = overlay_formats[i];
> +			}
> +			break;
>   
> -			formats[num_formats++] = overlay_formats[i];
> -		}
> -		break;
> +		case DRM_PLANE_TYPE_CURSOR:
> +			for (i = 0; i < ARRAY_SIZE(cursor_formats); ++i) {
> +				if (num_formats >= max_formats)
> +					break;
>   
> -	case DRM_PLANE_TYPE_CURSOR:
> -		for (i = 0; i < ARRAY_SIZE(cursor_formats); ++i) {
> -			if (num_formats >= max_formats)
> -				break;
> +				formats[num_formats++] = cursor_formats[i];
> +			}
> +			break;
>   
> -			formats[num_formats++] = cursor_formats[i];
> +		default:
> +			break;
>   		}
> -		break;
>   	}
>   
>   	return num_formats;
-- 
Hamza

