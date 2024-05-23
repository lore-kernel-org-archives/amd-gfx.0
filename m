Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0F4C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 09:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6239110E0CA;
	Thu, 23 May 2024 09:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rCxPNOsd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E0C10E0CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 09:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI5Tg2ONzL2z1kizLNTXeTA+LVEMQ4vF8/owJ3pgrL3yUWvHHJzHGmX/zrmLP/rOGz4zkMIonPr0TXTtSbp9Dr0NKgoXjnnu8qo8G8FKC/qjJPRUGvSvAWb13+ocmVr+yhFB7S/Jc2U/+TALTWz2nOFmaT/VS66doyLbcv2ulStTCnQhMKHbxe5Wz+k/uJWwI7aiD1LQj517ut0LhTR3+S9leaOFaJA+GRrOiePyykFZ5IA789cxz4ETSlIUggtrbND+TmAG/Rr1+LwNWNqtzuBp3k3HGo+1uRXpv6nTkVfFX6Nw3XWS8wc6jAMA0d97EeBjOt0Zivl3uzAMCfuitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMsr8XURn8J50Xgk6yFDsw5Dj7J5YC6X6MmwsGNuKso=;
 b=NoLSUYyn4uImFrFrn12xULyKzhtPTT76r9Kgl1N2V/oZAOetCm2JL8WCbdfjBekH/dQAtbhDeEMp0CN1lnw2vdQmYj4R3vFUhAEi8hKUAmaR93q7wrhslzXp/OdN+DuiZlVDgZRdj2q4ZyHftpFmtwPCcuEwLVxyTitpQ8yNEUXsLH3omIo3vLFL7SW6Fr/NCzt9Xsxa2CK2sPwh5qGa3JOAOFQUAAf1oLTW1DNp0UU6xoPYk8VW8N3kXyz0+ZkaUYH9FC0xItBHOurY5Vh86OVsZCnOx0Q+9zXKL5yflGSu0m4Xl9S7jSK7j4E34VbA+AyELFiPrOcJsPUtxchoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMsr8XURn8J50Xgk6yFDsw5Dj7J5YC6X6MmwsGNuKso=;
 b=rCxPNOsdQxtuyX+V14pfhdBYNG63+eB7+l0yPyipQQhQ4+X/xt5//47IOqM5bmmwvE/QteYETduQnOPo/okJHRjk7RuGKavd/ELq6H1FLyH5yyTJaIs6SavtTt4CzG6GWzgPOUiLFgfdVmWxbYNoLeH0Dxcf0Cv8GDviXww5/2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 09:07:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.037; Thu, 23 May 2024
 09:07:33 +0000
Message-ID: <371ba183-93b1-48da-9c5c-a1ec87c86919@amd.com>
Date: Thu, 23 May 2024 11:07:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: fix dereference null return value for the
 function amdgpu_vm_pt_parent
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com
References: <20240523080724.1422801-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240523080724.1422801-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b82fbf-9829-486b-c7f2-08dc7b07c816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnpSb2U2bUdLSjJaOU1FYmREVEhtQjh5RGhWNXkzdzFFRFNMY3cvdEFqOEZo?=
 =?utf-8?B?dzVvOFJmNWduR0pVNkVGQkErdmdDK283bHZycGJNbTRmbS8xTEQ2czJTb25r?=
 =?utf-8?B?ZHdwdURoek5tUHpKU012TkxYcDVzK1BlM0twTFEzWHNPeEhpYlhsT3RlT3h0?=
 =?utf-8?B?WldZbHovMUhKR2dmVmFSenF6aVVOQ0JVTE84NGpRWk9tOXV3OERsSzBVeC9J?=
 =?utf-8?B?dFQxczFwK1J2RHV1UUR5MzVvblVqeDd5UzZTZW9lcmRCdTJVcnpmYTAxTDVL?=
 =?utf-8?B?dGQ5eDVyc1BWRFcyeExpVVRrSjNoZU1hcWdYeWhIdm5vbXI1dW8yN3VVeVg4?=
 =?utf-8?B?eW1paWFiNWJ4Qzl6NGxmb0dVN0FVTDJ5dnJiWnNmSS83UG1DKzYzbENTR01W?=
 =?utf-8?B?SGxQUWpGbWtIT0tiOWRFcE1IS2p3UkwxLys2d1lYRlRrbXRoSVFJVFpSNkc0?=
 =?utf-8?B?d1UrRi80WHQxOEFkbXNWeEM1ei9lblBjTCtRZmt1NnpBUCsrL3BjYzZBbllt?=
 =?utf-8?B?Yis1Z01mUEVWb0ZUamNrTzBLa2d3cGRkSCs5VHBZdXYrN05Udnl3VUhUcjBm?=
 =?utf-8?B?MFF1V3hlZXZrbUduMmpNcy9sQmpCRVhpUmQrNjY2bHRlOUswWHRtUGNTSHIv?=
 =?utf-8?B?cVZLNVJLMXJHaGRHVGJsRGFvYW1HeHA5TDNsSTFOTXNYZ0tQbG1UMEs4K2ZP?=
 =?utf-8?B?UVc5SXZ4UkVoWSs1WjFZdWw3Qk5NYVdrU0VZTFErOE81NlZlOGk5cm5LbmEx?=
 =?utf-8?B?Tlk5R1R4RmpQWExieEZXVHZwTEZzeHQwVXkrU0pNcXhMSFdicVQvYXdRN0Rh?=
 =?utf-8?B?dllyb3ZGNE56aDh6SlNRMmtjYVZoWVlZMWRrMml5WlMwUWVUQUJyZmNOQkQw?=
 =?utf-8?B?TEFqM0ttU1dneXFUU0pUVThoaE9ldm9mWXdYTmk0cWwwTU1NU0QyaEpnWnRj?=
 =?utf-8?B?QnF1Q0RsRkZhTUI5ZEEyd01UdWlPR1hBZWlUc096M3ZLWWdKa25QMW03SnA1?=
 =?utf-8?B?MWY2RXV5YXZRUmF2c0gyY0lFQWJFblV3UTlXd2dZSmF0c2hKYVZPZWtta040?=
 =?utf-8?B?ZEtoWEphZk5qN2tYV2NSamhUbTU5Sis2QnBTaGRtaGp1Kzc3OHBWVThxNjV1?=
 =?utf-8?B?b0ZWcUdML0VBVms1UXVBZW9xTmZhNDliN1hrV0lmMTFYK3FBVWdwNk1hZVo1?=
 =?utf-8?B?Y3lubHdWSkdhdHp4Y25rUjYwR3VwSWEwb2xXK256bHM3Yy9FUVlYSTlZOVVa?=
 =?utf-8?B?OG5Ya2YvQkdJZnhKQ2RET2FFZ0RTamYwVXpQWGlhQTFzeXVHWVVuaGtaRWpO?=
 =?utf-8?B?RXFsMTdTay9UZHk3cVNZQlM4aTcvYzVoSllPSjRUeTdINU9jRHZ2a0FxV3pR?=
 =?utf-8?B?b2xxSWloQlhzSFBGR1piNUtlNkJ1RkNRRnFQZnJlaE8vMDROeXRCYVcxbUxF?=
 =?utf-8?B?SjRTTG9OZ09ydXQwQ29oUXpEVGFQODBndmVtY3loSGw2dStLNmVpYy9DZ2VL?=
 =?utf-8?B?K1hhS1F5Z0xsWHRlVmN5eElBWktWMFBLQkxYNEdJVCtleTJBTUE0S0FmU1Uz?=
 =?utf-8?B?QlZJYzByQVByc0JHRndBYVUxNXhHWjRnb1FFOFZ0bVdQYVNlNHRVRTIwVkNu?=
 =?utf-8?B?b2hETEFmSjVuZXI3TTZNU3ZKVkdCYmw4b1BDazBDRFlqV3doYWErNEVmMy9l?=
 =?utf-8?B?N0pDbm1iODdzbWZYVU5lL1pFSWFERzA2cVFuQmsvQTNCKzZnUFlkRFdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFV6MkVPUzNiNW9jVStFQlpiK1F0NkdZWThEbHVneFRzZHErTFhGczI1QzVy?=
 =?utf-8?B?VmpqNWVadTQ4UW94QktmTjZncjZkL3MxNWRDZ2FMb1FkSyt6R3VBaUdjNzFs?=
 =?utf-8?B?Vm11cWZpKzdoNm9qS2RRRXREQk1DMzVHR0krQzRHWVhKRzQwSnFQZ0ppY2Vu?=
 =?utf-8?B?WEh2UlkyelN6NjZZZXhoK1dMNERHK0FBUmJPMFJ3cS9DNnZRNnBEeHRwbW80?=
 =?utf-8?B?MGM3SkdzTnFKYnBqai85YzlnWWhMTlpBV2hHREVOZmQ2T09JQmpKRjQxcW05?=
 =?utf-8?B?RE11TGw1QWZBMTEwS0RiemxuVVEvbXZUNTl3ajVISXBRM0NtVloweERxeHR6?=
 =?utf-8?B?Ymo4YkRhRUJHZ0ViMUJLaStGbGlMWDlKc1p2TjlqVjFGaHNyMzQ3c0ZKekIy?=
 =?utf-8?B?TFppMHRwRkZYZDdmcytzdkF0SG5KakpJWnBuYkZCMTQvNmpmK3Jxd3NVYUtW?=
 =?utf-8?B?T3FEL1RDMWpXTWJiWUVBSE40eWlYUXVVRXhwbTNGZ0pJcWppSEVDU3Q1cmZC?=
 =?utf-8?B?QUMrNFV3MTZMVkZKeTVZakpQRHBCL1hWUmdpOXhTd3JxQ2xsM3h3TllOY216?=
 =?utf-8?B?ZXJxUVNkVVlhaXdQV1JVN0FlNVlmNTdnUFdYeGhSMXBSZmxIUllIa2N4aGJV?=
 =?utf-8?B?VVBKcUtBNFdiaUdRckw4V0NnS1hTYzhTTXd3dWYzWTFUbXJtRGdxOHJPZ3Vi?=
 =?utf-8?B?dklJais0SDVvUktpUzdNUEtaYkxPYnFscUx6aW1QMDRQWnNkdHI1SndsOEFp?=
 =?utf-8?B?WGtlZU1hdlZZWlNmOHpwSXZUOTVtN2wyNXBZQ0xtcVlubHYzdFFxTkRURTU2?=
 =?utf-8?B?empOV1RtaWNQd0dwV29vams4blhoR2U3NEJzaEZNMFVLblVuN3BYQmlmN2pC?=
 =?utf-8?B?bVpoOXJNNHEwTXdBNExwU3I1Y0J1eHZ6Y1BpTmRjVkEwTEY3OEtvRytnZ1l6?=
 =?utf-8?B?T2VQR2dnN2hUVmQ4RmZmL2dqZThnS3JjNFhVbVVUeDBpcTA3MVJOdHpLak84?=
 =?utf-8?B?c2NWMHFBazdwencxekZOQnB6SVJhd3ZsRXMycTJRTnc3SUljYk03QVJvOVFn?=
 =?utf-8?B?U0NGV0h5UUxKMHc5c2xvM043a1hFbVJ3azh4a1QrV01nQUE4SlBCeDljK1Zo?=
 =?utf-8?B?eG5seGhDU1UvRnVBV016YUNtNUZtUERjNnpxV2tBRE5vbXMzazBWRGlVTWxq?=
 =?utf-8?B?TFNPN0Q0UW1vTGlQVVNIeWFPUnkxQTMxQTRvOW5HejlBZHJKSnJ6NDBHcWcz?=
 =?utf-8?B?YUNLK2JBRWFsNUEra1Z1Rm5RdXo0Mncvd29ERTF3QVYzcFg3ZllaZ0hjRjM4?=
 =?utf-8?B?MzZkZXJhaW9iczRhMDB6WHhMM0RKN0VZVjc5ZkR1UWtuUjJRcWpwL2MyV1Z1?=
 =?utf-8?B?MmRvMGVZSmRvKzJpVVVTcXQ0TzRTdDVTNjRhZml2Wlc3V3loSTVrN2xrWlBE?=
 =?utf-8?B?VjdTV3dyTGhSWmhSa0IyR2g5T3pJRmJ0QTFDZDNaMHZHNW91OW9wVmVieGRi?=
 =?utf-8?B?ZTdrR3ljcWxlUTAvTzU5Qkh0VytTbSt2Q3JaYkhhYklKc3E5QkNLVGVicXcr?=
 =?utf-8?B?SFJTU0FySExsUWRCYmtuUldEaVZaRzBUajhoMk43UXpWcTIyZGFKRlFpTVF4?=
 =?utf-8?B?SGY4RmwrS0tEa3lTU3Zwa0JleUpQMGhxZ05sdGtRa3N0RklabkNZRHZaY3hz?=
 =?utf-8?B?MjRzM2pEM1lzdzZwQ0xoSlZwSEdSVUJuckVVWFVNcVpvU2liSTNDRkpyclJY?=
 =?utf-8?B?N3B6QzdBeVlGZVNaSHBUTURQS2dGRHhtbGQvRHUzNG85MXNpdnIwQ2czQjd1?=
 =?utf-8?B?MTQ0U3NLa3VjemcxUG5RUUtVa2lOeUUwenVHNEF3VG1SZWxJMzZxUEVZd2t5?=
 =?utf-8?B?TExETDRVM2ZGU24vTWJrSnBnbnJWUFI3SHJNMk9lbHQ1a0JqYmYyUkEzVkNU?=
 =?utf-8?B?aE1tMVQvaGZ0TXZzYnFGVkNncVdmbitHY0wyRklxcFFLQ3gwbkRqZzVIUTJM?=
 =?utf-8?B?U2N0cWE5YUhyRVJ6RDhxNGlFeTBXbU52YWpieGJOZGNMSGFCY2FsM0xrUm9E?=
 =?utf-8?B?b2x1dktPREJjbEN6RGdJaUhpZHZHblFtVzkyR3Z2T0JjZDRlQy9rUnZsZk1k?=
 =?utf-8?Q?19kx1XgfOnU3cjKio6qtyGmyP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b82fbf-9829-486b-c7f2-08dc7b07c816
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:07:33.4143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7ET94vhkeHfc9mOakNw/Odbmc/eOVluN9Tfz6DKtJ34VobWXVqhOFHmCUqFgrE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281
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

Am 23.05.24 um 10:07 schrieb Jesse Zhang:
> The pointer parent may be NULLed by the function amdgpu_vm_pt_parent.
> To make the code more robust, check the pointer parent.
>
> V2: When parent is NULL here we should
>   probably call BUG() instead. (Christian)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 0763382d305a..6fac8440012e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -706,11 +706,17 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   			 struct amdgpu_vm_bo_base *entry)
>   {
>   	struct amdgpu_vm_bo_base *parent = amdgpu_vm_pt_parent(entry);
> -	struct amdgpu_bo *bo = parent->bo, *pbo;
> +	struct amdgpu_bo *bo, *pbo;
>   	struct amdgpu_vm *vm = params->vm;
>   	uint64_t pde, pt, flags;
>   	unsigned int level;
>   
> +	if (!parent) {
> +		BUG();
> +		return -EINVAL;
> +	}
> +	bo = parent->bo;
> +

Mhm, think more about it a BUG() isn't fully justified here.

Maybe make that:

if (WARN_ON(!parent))
     return -EINVAL;

Thanks,
Christian.

>   	for (level = 0, pbo = bo->parent; pbo; ++level)
>   		pbo = pbo->parent;
>   

