Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9539CC36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 09:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB1910E3D5;
	Mon, 28 Apr 2025 09:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Km28vaTi";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621B910E3D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 09:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIJ8i5Epfne00iTp99BZFUtaThNxKKXe+sw7yCAz6Uvhg0388IOSsMnVwzHsDuS180XOvOEED7q82bV6DJR4h3xSu5XVUpBlnQRJYlMEYwswk1/GRqqX/3NlK3oIG8kKIykiwLH/qwugiwBjZlpvC4Jsq/jHOmCLGoN6ubvrjY6sf03xwMOHhsB+bJQdiJ98xVp7uhWaRKC4uN6BQrY83D86xjWcFMoHeA7W89O0UHbdFYoW6BTRbbOlwxX+OBzA1LlA31SzCg+k9vcvR1sCXzy6qX2cHho9mpW3s9cx/v03SMlxsU9HCUX9a3Uh507VeMaa7bdhSL1mn0uzz+S36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+ju4y0H/501O1TaE8AnuSFv2IcLrDt6xlUUDez7SbA=;
 b=vId/xNby3uEvWtLgpqzAVZGwdf53qjYjM3ApljQgwjRuCQdmucJfFg+YGJIizS7kDmFASgQzZb1Tb9kdHJSpnkFWE5OZHPe884yb84axpNJmmdMwOBcPjHBE5nOPQWiz+GbLGtwllys6n9dTQq0PrXElg5xjb92VUrCM/IFZmY1Z270sBUJIwqXUONvdqhLCpBSCofd3qzjd6nw3arFXnpTvAbEYBYsWI4YupOaow9zukBmlF3ZqNAyUqD+PR27mbtdqx5Z+9UHLOvZMz1cGPjwImhLh9kMHjT9FhCa+qlDT1ynBoSokR8oeTx+LXBy8MxvhGKmyn7ZQrHcjfTSqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+ju4y0H/501O1TaE8AnuSFv2IcLrDt6xlUUDez7SbA=;
 b=Km28vaTi6LFGbiRTD48i7Y++OblJUz1dc0GxArO2GMI2RHhNkefTMV8nNODS2X77Hg2yEUWAqmY7ogZwcZBu1V24d8TrYna7Kldk0uPcEqd/IdarcMdn2uYBBn0hHCd/fV/ctjU9/laXzOsrSDJCBtLavdlI1J0O6oZ9tsmxsPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 09:37:40 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 09:37:40 +0000
Message-ID: <732415ec-4163-4727-bc84-e0a403b086e1@amd.com>
Date: Mon, 28 Apr 2025 15:07:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amdgpu/mes: remove more unused functions
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250425183855.165199-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250425183855.165199-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c003db4-3b11-4a80-7333-08dd86385142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yy9ESzVUN1NiOVJ4bkVHMEN0N3p4R29RNXhiQkFvd1l6WGk2V21WTXg5WmpN?=
 =?utf-8?B?bXZlTFJaWGtIb2xmSCtZODl6QkFHejBST1NDVmVvZG1oYkRPRG1iZzZ4WE5l?=
 =?utf-8?B?TFBOZFNqWWI0S21mVVg2VDdRMnhValJra1BZZVlLT1pxc1EzaFhBOVFIV2hp?=
 =?utf-8?B?NkFWU1c0ZzJENzNkWHNOR3FKQWtHM1Q1T0Rxam8zZXVSKzlUUGhub00xamZF?=
 =?utf-8?B?cW5zTWZxVUc4U0ZxbU9TODhkZFAwdkZ0UEhPYXpzODJHd0dZbWlRbHJMSUw1?=
 =?utf-8?B?UjhHNlpidTVqbkF4b3F3Vk5CcU9yK25YT1JLcTRCSGYrWTloM0cxcytUREw4?=
 =?utf-8?B?ODhSMHVDU2w2QWluSThXRko0Ni9aT1BXQVoyUW1pSjZaVmNGSkcwTmcxT0t4?=
 =?utf-8?B?UDVVZ0swbjNPdGRwWUVzUW1majRkbnVVUzU2Sm0xT2ZadDA0c3JnRUpGWDlp?=
 =?utf-8?B?ZmY0eXZXbG9uYWcrSVVFOXgyZEVMbzFJbXVWSTZ6Vy9nZ0dMZ2F4K1ppZFdr?=
 =?utf-8?B?MElPVG1VZ3FVY2lRcC84Z1UxdUt1UGc2b0xRaDNRU2VMNWMxcHhxdGhQdXFW?=
 =?utf-8?B?Zzl1MVBpMklkOXdkbjhIZWhUWmwzVDJFV0oyeVV6MXlSbmorM3Z2RllCc2Qy?=
 =?utf-8?B?OFF1SDdGWFI2MlNKY2s2K25IcURWcFVVTWNDSzVHcjlhUmEwWkRUclN4c0JM?=
 =?utf-8?B?Vmhldk5sanhuTXhkcEJuNUFmdjlBT2NGc1dLVHh5cmpIWDk0cGJjbFgybWJj?=
 =?utf-8?B?MmYxaE50MTlLQ0F3ZzVkSE9ldVFnaEdFYjc2NnlnL002MkdMZDk5Q1kzRFZq?=
 =?utf-8?B?eXNlMmczNTVkQU1FaUZvcDVSVTIva0FkU3RUeVJLWnZzbFBRL2pXdmJ2REI1?=
 =?utf-8?B?bm1iUDM3Q2Q5ZVdxZTh0ajg2My83cm9FRUxyeUtrdVlWZnpRUmJhWm5RSHgv?=
 =?utf-8?B?a3dXR29CdHExNFJTRDVGeFk1VjI2djdCUDdVUzZyZk95eVJ4QmxidDFGQmxN?=
 =?utf-8?B?Yk55Y1QvYWR0amdqdjcvUi9kN0d2RDVwZ3J6M2ZhSG92Wk9vTWNDZVlDZkxY?=
 =?utf-8?B?TEVrNDdrMEwvVkVYV1RXZy9KZWo0alB4MmVDUDhUVEx2UVpBcy9sVFpFT3Uz?=
 =?utf-8?B?Qml2NVNSelQ4NjNTZ29Hb3o0cGw4cFlVZFE2aVZTbWxJemF1VUthY255TUdU?=
 =?utf-8?B?SUJCYkpsQVhlMS9WaWRWNWdUaUtlY2lFUWZsb2xETElyTnZwa0dMLzJKWG9a?=
 =?utf-8?B?SnYyeGlaSzN1YjQ0bGovZERtZ2FUV3lxbEFOQ1ZYOUI2djFBc2d5czRtN1dJ?=
 =?utf-8?B?YmZXY2tzcFB2L3hpUEx2ejVMMXJuSU0xZjIyOXJBNm8yUG0xZHBMaWVVdUc5?=
 =?utf-8?B?S2VZM2RKS0luR1N5bitvK2lvbkdwclg5akN2OHF0ZXRobzc4RGlCWmNsUG44?=
 =?utf-8?B?ak5hc1JvVzAvLzNqRitSbmxtOFNPWnd6bFVTMlAxNWdWOFRQd3ZXZkg2ZHQw?=
 =?utf-8?B?U254RUhsRGM2YTM2RkpRWlpmc000Uis2QlFUMm1NRnF2dEFGNTFWYWhhRGFt?=
 =?utf-8?B?TlpDdElXTEFld2ZmYXZOV3UxZUx4bWEzM0t3TU00QkNGditWWHJtUUtaNE8z?=
 =?utf-8?B?TmJkSkMzZllkZkgrUU5sWFl6YytDSXpDcGJHcTFTOXNyU2xvSEVoUkZ4bkdy?=
 =?utf-8?B?Q2tNTFF6eDhJdDZtL2xBVG8va2E5NmpwMWxibHhqN0tuUDZVZXJlajgvTVgr?=
 =?utf-8?B?TFp1dzBqdFEvNnVkTkppaTUvYVBoQlhwb1FkZWhBZGVuajVVR0dhYkRpZjFD?=
 =?utf-8?B?TkFsL3p1OG5BeWVOY0xzUHhzRy9veFB4V1VFLzYvK0ptR0lxTWdnNXNBOTJz?=
 =?utf-8?B?eUcrMDB5cWJOL25NdzNRTitxSmZWMURxSWk3TnlvdVlabU9CVmZJK0RxNWNs?=
 =?utf-8?Q?dyXBS6L0zPw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWhZMGlwRGlPUDZERm9GRkpKelRUZnJtZzYxSE1CNUQ3T2x2Y3RaaWxTTTVE?=
 =?utf-8?B?eElJRUJhamppbjMvZ0o4K29rOGRhQ2g1M0k1cVRmbGZ1NVBUSGlDRENCUld0?=
 =?utf-8?B?bWlaTkY0eGxLdXVPY2w0NDBHUzZvZThvOGcvek1zZm9EdThUREpBN0Nqekto?=
 =?utf-8?B?WDV3M2FOZHZNdFhXeldvWm9vdVFPUVVHbGVhZE13ck1UY3pFeFdyUE1TNkFH?=
 =?utf-8?B?V3RZWHlKTVRYcWpCMzRnN3RMQTFJN2N1bnd5RklpUmtlVE5tTDR2TEdkMUUx?=
 =?utf-8?B?WWFhTWhLLzAwTmRQblEzS2YxT1RNOXI2Ym1QYnI0QnZCYUJYSm8zNVpqRnBu?=
 =?utf-8?B?S2t6b0ZFeU5rSmdjUHVvL0VrYWZFa0svekJNbjhtS3dxdXN4R2Y3ZkxRSlgr?=
 =?utf-8?B?RVJlNmhWZk9JZG9TcndkdEJXWTFRQmVjb0JIK29ZdGtCK05LNU9oSHg4bHVP?=
 =?utf-8?B?WDlYL2tpT05wU3F2UzRtUVUzQzFIOTBiS2hQRU9YKy9NcjBNdzdOaDRObk40?=
 =?utf-8?B?MzNCOE5BWnhyN0tPbmExY053WU1FcGVxY3dwdm93Tkxpa3FQYmRqdjMwMmx6?=
 =?utf-8?B?TDFWck9nb0UrbEZleVEzWGkvRGEydjFtVGlJd2pSM1dYVkZ6Wll5K0xGMFg2?=
 =?utf-8?B?NmVoTk5kN1c1MHVjWmlBakxZc21aLzdJcEg2UVgxdktUcHk4QXVpazh5OXMy?=
 =?utf-8?B?WFBXM25OaDZMT2YzMnVoVDZJN2NCWmJUTkQrWWZFekFYNy9NSmpLOXpOVm4v?=
 =?utf-8?B?Y1FMZjgrN0RMOWYwR3lCbE4vOVNlazFSemlXTFJobEhHQ3h6SHdBSThNRFpL?=
 =?utf-8?B?NnUybk9zVDc4ZjZxcUxxTnAyVFBKeHlIUXJNRW5FQXdlVUhHNDVhcEw5UUM3?=
 =?utf-8?B?NXVOc2FoMXVMc3BnQk5mQXp5K0g5M0dHWnh2V2dhY1dBenlKN25CSUVEakRY?=
 =?utf-8?B?ME5ITXNHYzZhSVZKc1pyY2RCTlM3Z3lURkJ1ZHZIWk5iTEhoWExwOFlJbmNE?=
 =?utf-8?B?RXZNRUEzYjZhUS9LV3ZaMEkyc0hIbndweUt2ckVwcTdmNG0zUkFKdjBUYkI5?=
 =?utf-8?B?Y1Y3Q01CbkpIUVpQSzJ3VVU4elNVc29pdk03ZGNoa0xFRHNqdjZpOXVLTVlI?=
 =?utf-8?B?ZTNyckJ0Ry84N3V4NkdvZDduVnJBK2MvbHJiRzZQTE5BQSt1YXprN2xSZUgy?=
 =?utf-8?B?WGpSRjBwWkIwZll3Y2tWWEhCcXRIeUhES0FtelVGYmZ2OXFkUUdMWlllUFh1?=
 =?utf-8?B?M3ZHaWVhaW1GNmczOWIxUzM5MjhVWEk4dGpIdDIyWmkzSWRIRE0yemJ5dG5G?=
 =?utf-8?B?MERzNDU0bmZTRkVjQmFVRWFPNGg5OVhOSVdxanlVellXWSszZk5RQXN1Yks0?=
 =?utf-8?B?TFg3cWhWUm5lQk5LQ05RWTNMVFhUQkliVnhrdTJTdXdKbW9jTmU5anBoYlBR?=
 =?utf-8?B?NjZGUy9hM1dycy8yRHNUcGhWNk12N29VUGtjbjNWMkJ6Ry8wSDV5Y0QyeXpr?=
 =?utf-8?B?cWc5TlcxQkUzeldHb05wWnJTaml3NUEvdUVhbGZMdnU2bVRSL2lMVXlzNUZD?=
 =?utf-8?B?aXR4ckhmc21ETk03MUJaTzVHTGhnNm9BQWN6Nm5raWJlZE9RVklJOFp5ZDFD?=
 =?utf-8?B?enliQjNvWnFIdUE0aE9tWFhJSVc3d3JiSTZkc2tyeHBFaUVIN3Zpa0svK0ZZ?=
 =?utf-8?B?MHpwa3FRZjlCc1gvTUNoMThNZTR0OTdXNFdwaC83OGJpT05iUHNkclVyYktu?=
 =?utf-8?B?MXVVVi9EVmxZMFJhMzF6TnpMTGIzZDl6RzgvRFpUSithTmpTY0VwUWFUWHNv?=
 =?utf-8?B?NitseUd3KzgwNU1JWjI4RHY0cEVUbGtjc21Ra1VGSXpXd0UraVBhelRTYVRy?=
 =?utf-8?B?WWxOWEFnWUkyQXBDZTk3WDZ4Z3I1dFI5VUNFbGVkdDV0V3JCRy9taDZzNFZK?=
 =?utf-8?B?Y3FjK01LaFRmanlkRElTd1d4YThSR0NoeXU4dWZoNktmcGRVZ0k2YjJ0RmRw?=
 =?utf-8?B?RUNkQ1V0NmRiL2JnNVNYVWVBQWxhUytBUUIybXBHaTR0ZVZ2ZEhEZzFFdCtm?=
 =?utf-8?B?dnl5M1cvNU9NOVB3QytDQjJnUE4yTkNVVnhCUm1OYUVQSkdiSXZHcnluMmJC?=
 =?utf-8?Q?Pn9wbKNFwAYTnDEWBw36lYBEC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c003db4-3b11-4a80-7333-08dd86385142
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 09:37:39.9329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxNwH7il1S4aGPijOI1j3Sr4HGJEa2qZm7Com5GqRpARxwOH3vPQB2ZoLaadZoQ6se6B4Tfzy7YBFtmG5R0uBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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

Series Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Apart from a minor comment in patch no 6 if applicable,  rest of the 
series LGTM.

On 4/26/2025 12:08 AM, Alex Deucher wrote:
> These were leftover from mes bring up and are unused.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 62 -------------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 --------
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 26 -----------
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 27 -----------
>   4 files changed, 134 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 38ea64d87a0ac..b5a7e2ae72aff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -285,68 +285,6 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
>   	return r;
>   }
>   
> -int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id)
> -{
> -	unsigned long flags;
> -	struct amdgpu_mes_queue *queue;
> -	struct amdgpu_mes_gang *gang;
> -	struct mes_reset_queue_input queue_input;
> -	int r;
> -
> -	/*
> -	 * Avoid taking any other locks under MES lock to avoid circular
> -	 * lock dependencies.
> -	 */
> -	amdgpu_mes_lock(&adev->mes);
> -
> -	/* remove the mes gang from idr list */
> -	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
> -
> -	queue = idr_find(&adev->mes.queue_id_idr, queue_id);
> -	if (!queue) {
> -		spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
> -		amdgpu_mes_unlock(&adev->mes);
> -		DRM_ERROR("queue id %d doesn't exist\n", queue_id);
> -		return -EINVAL;
> -	}
> -	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
> -
> -	DRM_DEBUG("try to reset queue, doorbell off = 0x%llx\n",
> -		  queue->doorbell_off);
> -
> -	gang = queue->gang;
> -	queue_input.doorbell_offset = queue->doorbell_off;
> -	queue_input.gang_context_addr = gang->gang_ctx_gpu_addr;
> -
> -	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
> -	if (r)
> -		DRM_ERROR("failed to reset hardware queue, queue id = %d\n",
> -			  queue_id);
> -
> -	amdgpu_mes_unlock(&adev->mes);
> -
> -	return 0;
> -}
> -
> -int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_type,
> -				   int me_id, int pipe_id, int queue_id, int vmid)
> -{
> -	struct mes_reset_queue_input queue_input;
> -	int r;
> -
> -	queue_input.queue_type = queue_type;
> -	queue_input.use_mmio = true;
> -	queue_input.me_id = me_id;
> -	queue_input.pipe_id = pipe_id;
> -	queue_input.queue_id = queue_id;
> -	queue_input.vmid = vmid;
> -	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
> -	if (r)
> -		DRM_ERROR("failed to reset hardware queue by mmio, queue id = %d\n",
> -			  queue_id);
> -	return r;
> -}
> -
>   int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
>   				struct amdgpu_ring *ring)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index be3390d263012..af6e341f6411e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -235,18 +235,6 @@ struct mes_remove_queue_input {
>   	uint64_t	gang_context_addr;
>   };
>   
> -struct mes_reset_queue_input {
> -	uint32_t	doorbell_offset;
> -	uint64_t	gang_context_addr;
> -	bool		use_mmio;
> -	uint32_t	queue_type;
> -	uint32_t	me_id;
> -	uint32_t	pipe_id;
> -	uint32_t	queue_id;
> -	uint32_t	xcc_id;
> -	uint32_t	vmid;
> -};
> -
>   struct mes_map_legacy_queue_input {
>   	uint32_t                           queue_type;
>   	uint32_t                           doorbell_offset;
> @@ -377,9 +365,6 @@ struct amdgpu_mes_funcs {
>   
>   	int (*reset_legacy_queue)(struct amdgpu_mes *mes,
>   				  struct mes_reset_legacy_queue_input *input);
> -
> -	int (*reset_hw_queue)(struct amdgpu_mes *mes,
> -			      struct mes_reset_queue_input *input);
>   };
>   
>   #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
> @@ -394,10 +379,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev);
>   int amdgpu_mes_suspend(struct amdgpu_device *adev);
>   int amdgpu_mes_resume(struct amdgpu_device *adev);
>   
> -int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id);
> -int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_type,
> -				   int me_id, int pipe_id, int queue_id, int vmid);
> -
>   int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
>   				struct amdgpu_ring *ring);
>   int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 0a5b7a296f08d..5ce62a3f01e7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -475,31 +475,6 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
>   	return r;
>   }
>   
> -static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
> -				    struct mes_reset_queue_input *input)
> -{
> -	if (input->use_mmio)
> -		return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
> -						  input->me_id, input->pipe_id,
> -						  input->queue_id, input->vmid);
> -
> -	union MESAPI__RESET mes_reset_queue_pkt;
> -
> -	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
> -
> -	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
> -	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
> -	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
> -
> -	mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
> -	mes_reset_queue_pkt.gang_context_addr = input->gang_context_addr;
> -	/*mes_reset_queue_pkt.reset_queue_only = 1;*/
> -
> -	return mes_v11_0_submit_pkt_and_poll_completion(mes,
> -			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
> -			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
> -}
> -
>   static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes,
>   				      struct mes_map_legacy_queue_input *input)
>   {
> @@ -817,7 +792,6 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
>   	.resume_gang = mes_v11_0_resume_gang,
>   	.misc_op = mes_v11_0_misc_op,
>   	.reset_legacy_queue = mes_v11_0_reset_legacy_queue,
> -	.reset_hw_queue = mes_v11_0_reset_hw_queue,
>   };
>   
>   static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 1f7614dccb005..a3391810c897c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -494,32 +494,6 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
>   	return r;
>   }
>   
> -static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
> -				    struct mes_reset_queue_input *input)
> -{
> -	union MESAPI__RESET mes_reset_queue_pkt;
> -	int pipe;
> -
> -	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
> -
> -	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
> -	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
> -	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
> -
> -	mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
> -	mes_reset_queue_pkt.gang_context_addr = input->gang_context_addr;
> -	/*mes_reset_queue_pkt.reset_queue_only = 1;*/
> -
> -	if (mes->adev->enable_uni_mes)
> -		pipe = AMDGPU_MES_KIQ_PIPE;
> -	else
> -		pipe = AMDGPU_MES_SCHED_PIPE;
> -
> -	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> -			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
> -			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
> -}
> -
>   static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
>   				      struct mes_map_legacy_queue_input *input)
>   {
> @@ -914,7 +888,6 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
>   	.resume_gang = mes_v12_0_resume_gang,
>   	.misc_op = mes_v12_0_misc_op,
>   	.reset_legacy_queue = mes_v12_0_reset_legacy_queue,
> -	.reset_hw_queue = mes_v12_0_reset_hw_queue,
>   };
>   
>   static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
