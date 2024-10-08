Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51BBCED26B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 06:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9AC10E03E;
	Tue,  8 Oct 2024 06:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pXz+PVhQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D1010E03E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 06:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEO3FZzwTTf2hp7BPE9LnXc7ZH2Ptpt6su2/lDCoudAPraqqHhIq4OypCL5Thssp07tw64Q03VdNPgS8/QHTWc7nNHzblsynp+scEkF4vNCCWtTUgvHWBDuJrVH6gPLm1e92aRoDn0KJeCSWzquPswDfC19KsxrRWiqhWrbqvw/7nfF+1Vfio5E5dYQLpzaXWfz5QJK2IXmFOuZNCkeK4doz/vjGdh6AxY4C4gVbuEy3qImLNZFWPlrjZPPL1d/aYGpGDAtkOK/prDTJWZbm4Furg17LiuutYoByjTzqdOLY0AQ1fbmfjgMzbGOYBb/ms6R7giwOkF4w8gTTICw8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GDMHXWgUZImFGcJbOpxS/WQ7JhGSDcJwcewyo8SVgU=;
 b=nGzS+PVEhyvLY9aPksysKp8xc2k+5my9gGaHNngsW5Yoxw6rWoei4Iz8O0KI2gkJPtqoEl5oE6PhNiH4JOis43ipKrj06eX0RpoyJDnKNN5u6rDLw5r0JIQ1XJK9FVmqp8/7xKlydrETqDOq7X1bYgXbehhJ40n8L2VNI2E6HjotKHm1+iIVeLynCqD1NMJVuikpprq2+pUIFw+jCJOMYODDiiN0OTKgtK/XR0on3EXL33oQ8zCboJz3aWFjVZHqbOWbH2e5h1hFaaERFAESh2qnl+EuWbNVFNHB1NhT6SvTu11L6RJ4JVscxu0IhEX1nsUnvT8hItVU36iKwPgT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GDMHXWgUZImFGcJbOpxS/WQ7JhGSDcJwcewyo8SVgU=;
 b=pXz+PVhQ4l3QmqOoiTUM/LFhzIhkwdMr4kdXVDKYAoUjF3zJh3R3csGzptx4rJ9G83YE+BaloPvpJ4/+EjSgfud4bwhUycVccYpO4tBIYAMamw9r3AnmGAALSEXBHF9GdfbaGDvyVMipWqSutfAtnRWufpAPQcmgnFh7hDz8pAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 06:17:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 06:17:43 +0000
Message-ID: <8d52cdf0-5ed1-4945-82da-f9117885703c@amd.com>
Date: Tue, 8 Oct 2024 08:17:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Clean up duplicate ip_block object
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241003134947.268245-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241003134947.268245-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 835e8600-ea6f-4e47-3f48-08dce760eb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWtZdkpaOS9mQjNtcXlwWHFjSnhyVEtLckRidFAzWHNiclZGdHRySU44NGFS?=
 =?utf-8?B?cEZFYWpXN0EzQWhJek5HejY2SW5abnJvc2FEQlJNK2tPNVdHTzZRMmE0SUJR?=
 =?utf-8?B?NlRLeStpOXYwS0VROXNRVWlEVGN0OWxMNXRZQUMvZjZmMVQySFUwVHV5eGcv?=
 =?utf-8?B?Y1NBcUtiZ2t6S2oySnU2R0ZFS0ZXdnpyemltbGhPMnpwU0FXdThlWDd3U1ZU?=
 =?utf-8?B?UjJzZjQyVUR4MStjaHBwcWowc2JKRDQyS2tucEpnVXdOeVpOK2k5NjZQbEpT?=
 =?utf-8?B?SUh0VUZQNVhnWFVHVFc2U2E5YzFaUHByM2NyMmo2OE01TVRpTUZhK3RyTmtI?=
 =?utf-8?B?WnU5blJMNmpFZTJ3MHRxVXEvWUIxNEUvVHR2dVByOXh1aUUyeFozWEZmNmwz?=
 =?utf-8?B?ZTRVdVY2Ry9RdjdQakQ1KzdXL1c1c254eHNsVFNSNFo3Wmg2RWZ2WWkyS3Fs?=
 =?utf-8?B?bjlKZE1CcTlDZGlySEh6SERvL0c2MzRwRUxDbnViUlNxZnZ5SUJpWGR3RFgx?=
 =?utf-8?B?YXZLVWxpSUdzTE9PSmpJdXVNSG5rT0pQWkpZSkh5ZnVwcTJidUEwVlgzT0tN?=
 =?utf-8?B?Q3JBc0ErU1NZbjlWRHdaYW00czBsVWl2Tk5iWnFxRU5KYWN5SDJuVEZ5Rm1W?=
 =?utf-8?B?eTA4TytOYkFZSFhXSm9KSUVtMkxIYkF2cUpYd2JUNlNDd1RnUjFXazYzUS9Z?=
 =?utf-8?B?TjJBMHh5QlpqZkRlV0g0U0JmZS9naVlaNko1K1F4T3ZCb2I2cHVOcFpYNFZS?=
 =?utf-8?B?YzI0TWNidUNVc2ZWM2hkdHBDZTR5U2tMb01tb2cyWEl3MUtzZEx6M1VvbU9l?=
 =?utf-8?B?Vk1FelgwVlI2dGt0S1lxaWVZNVBUQUpIemtTbldxZzdDUmlVbEZ1c3pGNDlh?=
 =?utf-8?B?SUhCUG1rSy9yNFJBVzJoUmlQdmk4b2dwL2dRdFVaMFg3VVQxa3daTEdxamdi?=
 =?utf-8?B?VVNxUVRRS0NmSjBtMU1ZZkdlcDJrYmRBUUVmVDJHSGxNMkxGTFh4VVBTV2FX?=
 =?utf-8?B?b3BoUncrV1lBZVFuM0tlZ3FpcmtzTEtsTzF0WHgzSzNzc05mU3VLbE9qUmdJ?=
 =?utf-8?B?dzFYYmErUFAxaEhmaHJNNFpTWTFEZEpsYWpCcGJURUFXV0Vka0RNVC9BOGFH?=
 =?utf-8?B?bVAwWG5WOS9xNnhFVHUwNmN4c1JmbUxwb253UVE4QlJDcUFLUFdrd1N6YzZX?=
 =?utf-8?B?eFpDOEYrUlhKcmp6VVJpWkpkbDdISU43WWh3dXNxZ3A5TXVCazZQempxTzNG?=
 =?utf-8?B?NERSVzB3RWxCS0lmeVhZWC9IZUZBS3RVbGJqU2N2NnVuOXpTTEJNU0xYSEZq?=
 =?utf-8?B?MVRUbHBLK3htdjBPVjV0TEVsMEdYUVpaekN3c05GdG5QVEJhYWNTeEZ6ZnRP?=
 =?utf-8?B?UzViWE40RGNuc3UxTWp1Yk8rODZWOC84VERRTkc3TjNHYklhaGozVjhramVB?=
 =?utf-8?B?QkhSdlByb0s4eWZJbHIxUFl5bFJobE1xdUQ3eHJFWkd0Z2Izb1U3ZFcyK1I1?=
 =?utf-8?B?VHh2cUZHUytFTzRmUW5uYlE4U0p6NldBNFVoUkFDNkZjbGduTXlQb0NaTStD?=
 =?utf-8?B?YktMTzhYNEtnaG0vdHVhT3IzRTBmWm1oNC91cXpiQVN3QmIvbFFQblFlMllp?=
 =?utf-8?B?U1FmVXc5QTlCRTdhV1ZKL3dNUzRRbTRHaitKQ2RBODlhR3lRUnBFclJPREdZ?=
 =?utf-8?B?UTl5bUhaS2RvV3kzY3lFNENNcWsrR3JyR2d2WFZueUlPcE4rdDkxc01BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2N6cXFMbnF3djh4UnBxcEZUWWphQVJDV25NWWo4ZUt0dlExYWptUTg5UHlm?=
 =?utf-8?B?ZkZkQ3AwZUxsUlluTjEwbEF1V0JWK3FEb3QwS3R3ajBaa09tOWlPS3hEWkdF?=
 =?utf-8?B?eVdZMlFudUQyS0p6R1REbTRNeGpPbEd6WUxmNGFsTGRrL2o0cjlEVi9lZS93?=
 =?utf-8?B?QnJVZUhhZzlUak42U3JBdEsxL1NaZHVXUldNNjFoVGY3MGJMRExQQnRXczdS?=
 =?utf-8?B?bGVpTEUvZUdSQ0dqb2lva2d1R0YvUFVXS1dUU2NDWEVqa3B4WVpkem5zOXFz?=
 =?utf-8?B?dnlrTld1M3hZMTJ6NDdYV3dmK1Bqbk5lSDVqWmNIeW9FVnRHZk4zVUxxNllx?=
 =?utf-8?B?ai9MU2MwejFhS2lmYVU0cy9GTUZNK2x3TElwLzRrVy80NjJDdmlKYnExNHVD?=
 =?utf-8?B?M1FJNG1kM2lHenV2cW42VGZXMWZZY01wQ1NYNXZUdTF0MEtRdzVoMjF3T3F1?=
 =?utf-8?B?RW9TRm5rMVZQZlFWV3o0Wlo5QmM1QWp2N2N1NHRyT1JsZGJDc1FHcHVNc1dP?=
 =?utf-8?B?UHYxZ2RXSEx4Yk1IcjdyaXJ2aTFRcitKbHFBTGgwOFNjL01TakVFbmR3Q24y?=
 =?utf-8?B?SFJDcjhiZDNQaFJNcjZ2REU5VEpjMmVML1ZtcG9BR1k4YXJQT0JlekErbWpa?=
 =?utf-8?B?bE5pM2pLKzZLNEdMS0NBYXRlc0R6Y3hUNFNrYjF6Ui90cUtHQzZhMzNMY0Vk?=
 =?utf-8?B?RlgxR2NTZWF6cDhzRkltQ1ZpT0g3QlRncWF4T1ZmTVZkZFhvSzlwTTNRUEFR?=
 =?utf-8?B?YUdCQ2Fyc3daMk9rQVVWV0hhRGJkMnBPMG0wRC9ZS3FreWFqaHBWU1U2ZUk0?=
 =?utf-8?B?WmR2VUhNNytLUC95NVkvNHNPb2hJS2ZqckpITVV6TTJvRDFER2RFOVl6TnBZ?=
 =?utf-8?B?STdKR1dqSGNjSHd6L2tjMlBlaUdwajNwRWIyQjFDZWV6cVl0VU5EZXoyWlBJ?=
 =?utf-8?B?Tm5XOXIwL2tYc1dLVzU2czNiczd5Qm1qOUdmeTJ4cGd4R2wvTU8rVkZlUVBZ?=
 =?utf-8?B?dFNrMjhsMDRFM1NDajd4aHA3MVFWaXdpaEVIVVVBY1haKzNPL0FMS2d5TU41?=
 =?utf-8?B?UWN1emJFbVZOWU5aRnQxZVBvWnk2a1RJSElGTzdJdkwwdm1VRFlyV3YwcUhx?=
 =?utf-8?B?cXlhUFNzVTU1Q2xUYXNkUys4L1Q3NElyK0JDaDBHWUpLRisySm51UzBqMzFE?=
 =?utf-8?B?SC8rT0tpeFBWS2l6QkxhbFZWc2NiTjhwbzB1RXgxdVM0ODd1Sk5pWEw5T3g3?=
 =?utf-8?B?OXJlTUd6S3M4dldDS3JIWFQzMW4wbThyZlFoRDFWZnBBN2k0WUJ1REhFak5T?=
 =?utf-8?B?bXE5ZkdHQW5adE1kS0FWVHIrRkxLUEl2Z1kyTGdTMjVXTjg4KzlTcEl5UmZG?=
 =?utf-8?B?MmI0MjF6ZFhSdWFpcFp1SWoyQzFuc3N6dVBsVWhKU0MvNlh2eStsV0tXRHlr?=
 =?utf-8?B?OWx5MlRFNGRLTlZiazcxWDZDbXljaE1SZEZhcExzSnd2MjZ5bitMVzJab0ZH?=
 =?utf-8?B?M3EvMkVxM2oyTVdITkF6dWRKdDdvWXFGc2xGdk5MSzBnSXQxLys3NTgwbjkz?=
 =?utf-8?B?RnllQ25MdG9sTFk0T1RvYk9VYUJIT0hDa1h2Y1F4SUR1dTlQdy9MMkZxeUtH?=
 =?utf-8?B?cFdhZFc2Zm1EcnAweHBVakxKUWtoYTd5b3BaRUV4YWV6ZzhCczUrNlY4a3RS?=
 =?utf-8?B?Rk8ydThtTE96WFFDUlBDZHhuZEJEaTlndjYyVEkzYkpVRjJNRUpaLzk4RWtL?=
 =?utf-8?B?Qlh1cGtKbWRJZW1maGpCM2lvcjRVajVrYVZZY2N6ejREUGhmQml3TmpJT0l4?=
 =?utf-8?B?d1dRY0NvRkJ0dURDbFFqZTF1dGtuVkFPSFoyalFCcU15ZThhLzRJK1ZxWEpp?=
 =?utf-8?B?SUNyc2p2R3YyQU5Dbkgyb3hzUFBUR09Ndm9HZHF0Rmh3ZU9UQnpkTTJVMi9a?=
 =?utf-8?B?TEpGazdnN2V6MHI2MnRKY0s5ZDdhQlJJRWxiL1ZHcEtvcXJ5SDdXVTVXUEU4?=
 =?utf-8?B?dDhXcElWbmoxaU1qSTl0RFFDRVlVOGtPNW9HeW10TmpiK2E3SGRNWVN4WTFo?=
 =?utf-8?B?dU5jbHRGOEhGY3NhdDdMUkM5WXZBUnNRMHI4aU14UzVqUlozU3l1cFlHQlAy?=
 =?utf-8?Q?YRKG+G3bWFVZc+FvDkm2WCVpR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835e8600-ea6f-4e47-3f48-08dce760eb2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 06:17:43.0966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9rP1CM52TV2JK1hE+OymbNq4RF9esi/vNj6+F90rPvz2Pa0Cz+/xzGggIuE0UZ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
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

Am 03.10.24 um 15:49 schrieb Sunil Khatri:
> remove the duplicate ip_block object in the
> isp_hw_init function.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

You probably already pushed this, but Reviewed-by: Christian König 
<christian.koenig@amd.com> anyway.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 416e8b3fad79..adc0b80ca5db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -54,12 +54,6 @@ static int isp_hw_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_isp *isp = &adev->isp;
>   
> -	const struct amdgpu_ip_block *ip_block =
> -		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ISP);
> -
> -	if (!ip_block)
> -		return -EINVAL;
> -
>   	if (isp->funcs->hw_init != NULL)
>   		return isp->funcs->hw_init(isp);
>   

