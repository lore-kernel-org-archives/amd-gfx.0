Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD01106FD66
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 04:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3C110EAD9;
	Fri, 13 Mar 2026 04:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MeTfkxQt";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723EE10EAD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 04:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OICq779dcLDDNMWkc16VfpPBInEcpnS0tCZTRrgwjNakwRhq61eSuxB3X+mqNW51sVK/HI7rJQGv/Ph2zqLZ+AAviAnXc0ZQYu3+/1xzormQ1DDCpOjPH/Vl07hwxQwRUITvkGrZL5MKayp19DVVzoYX8WamLOdlvlb0ziYpGzvaxsxfWkLJmtn3PC9fYQDWd+xQl8xHAJ/JbhrVOO0wAROlQtP39lFkzDaUFeLwTMjM/HCLqF9n3i2sLzBBjRdDIbwmTO+bfJLKJ5q9h6kZDpBaKbMkfCUBMii/Lu0oS79m92oy4us4rhPv/0IqjUOsOzph2l7Y16X45n99Q/RU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfA/133E3aB8hZIp2aRAhKls5jkOrzJ5pUbSvqBnlVU=;
 b=VlJnOzVuK2Fbjr3mjkpdlHxN0aW1qvSipmwlus9OlF79Nwq44Fc5ah7KZjBYM6sWJs1TIiWXBhB4UvN/zYGfXuCKSrb1QrZdarudhlM+j5mQgm4fOqEkElxYOZMcZOY+mACiA0NKQM6Yu/KlORkB0T4CfkGRNxZ9+U9Kx1ronW/U8mpGv1KYM6vsyhtfo9g1aqpDE/nL9ZkTcBYxXLy1ZRCOAs/9xSsiwCDCbwCT1JFBLbEjumE1ENVXz7oXvAsH1VtKq06KY7EWMtKoj7Rl02NgMe+KT691ZPgS5yi9hOVSG8izJuNDG3wvLQSuIZATthXUzcmQARr1Ew9NEx3Mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfA/133E3aB8hZIp2aRAhKls5jkOrzJ5pUbSvqBnlVU=;
 b=MeTfkxQtskcnmK4RG5gRujYnsHSZiDx2Ex6kJU8UiD2KFVAordz0zzbrtf/oF4zeuzomE2kLLyL86wAAW4FRH/J0MuJStoztKnIvvUzKPBCXOiTsBriUhsY0Ji3cw6AGt46ljIQEMRvANkmpBNiMJuGhsKMy7qLq8q33ysTjtBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Fri, 13 Mar
 2026 04:29:20 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Fri, 13 Mar 2026
 04:29:20 +0000
Message-ID: <bedb645e-e801-43dd-8334-57b9d557a589@amd.com>
Date: Fri, 13 Mar 2026 09:59:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu/userq: Only look up for gem objects
 when count is non zero
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260310135531.3954691-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310135531.3954691-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac59efe-c661-4994-67a8-08de80b91824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: oRikGUxaDY4cFAmxRiZcqEjgVrcCR5jfx2OP3K6bfr0D4D8iQ6APjrZGmwhSVtU9oN5Yxmuv+MMmvuvgMGBR7WSeYTZJEbNGhIRUKkyktPxHmMAaSn0njDF6oROUD6XAt4rtBZjnn/t+8DGcxstR0PAUaTJJ+0K85FmR7vlOBzBQswZREc88xW/OwVqNR9AACHU2yPTLH3nbN231Y8QEdX7PJ8KpaZuyzaXAkroqtCTGekJKvB81rR7c2p77fc6mHWp4CblNSNTS+l6wDY+nNv6MGKKWU9b7dU1VfG5vWs60vXW42PsSmYFrbAXVbgduGK/KAd3hqVlEs7rWafCevC2d52bBGtLKMeqVFI/AQXouQ0Mt2sUkTKYYHeuxBghQZooAA2Kgj0GlAUwZce+bCZWR899xVYJ6Os0p3VwAPIr0xxoS6iPJ3ZO7+C00DMV9xnbDG5k8aCcJKvX1ed9OfDfmGbcqxvhBMpBxnMelj1b7J8ay9cTF3JBdIPebEMUg52zDaSOCBVCtEC74SEApnBPorXdG6dYmpGsLnrDFbwEozKCwkUODTtfoT2ZES/6G3DdNzRQLQAzp0RaBpkVHb4vUmkLrGAMIsN4NoHEd/LYXo2n9ZiEV6SBc0x/DP2X+ovg3fXd3q53EG17nP12IuawrsvWK2iPo6Sf6ON9GianryYatmff3O6mHnpYBaUgKAnfkl9e1Kq0/PTj4Z7mMLLiYL4huHeMQm+yT6vHkekI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzhFaFZzR08rSm9tYndZUmI3UXZTVmpYM0xDNDc1U0lhbFUvRUxNcEs3Zkcr?=
 =?utf-8?B?VXNWcy8zeHRlZjZlNXNndnNuVjFrV2diL1lIcTQvR21UMXlqTzUyc0Zhd3Y0?=
 =?utf-8?B?d2J5Sk8yUHZ1SUFuc0NQUTZ1NVA3aVBOblVDWmQzTWhpcDZTSkJMSHN0c1Vi?=
 =?utf-8?B?dkR2Y05kUG85b3I4UU9ZS09veTd0Tm80cUdwR2FacXdZSjRqdWg0WE1EcUJE?=
 =?utf-8?B?d1pZazJpajQ1Ri9BMnFuYUdBQTBZRGhoVEFEWTJEc0NYZC8rOFl5Q0Y3bkh6?=
 =?utf-8?B?MnF2Zis0T2Vidll2Y1BJa2tmUmFERGJ3Q1JsR2s4NTFEU0VpMERMcExhTGpi?=
 =?utf-8?B?emVEc2ZJTnRzMi9XbGVCdEpNUWVTQXNQME9GWXh2RE9UWTJ2UUVqZkZnWHN5?=
 =?utf-8?B?WXExN3hpRjgzakpTUVh4WEpieFJNOVkrUE9uQXZNWHRxTFpyNkpxY29YUVNP?=
 =?utf-8?B?a290N2lnTTNxNHJvY3pwb0RSZWEwM2JsV3psT1E2Z2hRdGNpWjA0UGhzK0c2?=
 =?utf-8?B?OFBDYWN5SlZuMGZGS3RRbGJRbTIxZUZEZ0s1QnhsVm1uUEtVTkFjLzJyNFVz?=
 =?utf-8?B?b3l0bFIrQnFtS1ZtWkhCQVVhK2lJaHNWWFpIamI2UWZaTjFocTVsdDNQL0JW?=
 =?utf-8?B?emhid3VSSGFYM3dVMU9STkZoWEFiaXdVUVdBZ044dEVQdTFUQThneXlic0Ir?=
 =?utf-8?B?M1V6Qm5YekNBenllS0psbnFWUWEzUTRjTkswbGJxaWJCWEZUemxhL3prd0FS?=
 =?utf-8?B?cTZXYjl6UkNadVRWZjlpM3FDaGtLazNwTEFOUHpodVAvQldPa3NVb0RnY056?=
 =?utf-8?B?TXZTQkRBNnZrc2pIcUptS3FPRitIS3JXU1ZvaVdhOXozS0J4YjVoSTlzNXJP?=
 =?utf-8?B?Zzk2VjUzcW1sRFBSaDFTRHIxM3IvcEVlSjVtKzQxTGxnUWk1VVhJYnhJVDJk?=
 =?utf-8?B?ZkZQZWdqS1pDU1dsMmZBNngwMnhmSlE0SlpzNFhralNCeC9SSnQxM1B5RmxZ?=
 =?utf-8?B?ZnhNamgwTVY0TFk4UE10TWFkUk43TWhrOXhiUjd6c3l6a3FIYkhqR2hzc0hy?=
 =?utf-8?B?MUJsMldSU1hkekxwRWUrYmtKNU1oem5vOW1FalZicy83Sy9rK3JCcnBUZVBL?=
 =?utf-8?B?NFRrNnI3cnhXdWVhQzQ5bVNrZkZXK3NmRHhUR0IxS2JwTURhUU9MazRINlhN?=
 =?utf-8?B?L2QzNUM4c1FxakkvQWZHdVlraVhwZTJTcC9iaFBPUUkrSFUrYjU3blora2Fl?=
 =?utf-8?B?QkU5V2tPY010V3NXUytMdEU1cGNoNHlEL0wwMjU2ZmgzRXd2K1diQjJIU3B4?=
 =?utf-8?B?bGp3eU1PSzdBOG5MRE11cXE2dDNpWXUvOGd6K0hoU0tWOUwyUDRFMEQ1azRB?=
 =?utf-8?B?V1kxVkxGVGVuRjFsWHhjT0l3eTlkSVBCVXJ0SCttWGpLUlVKUWdRQUJhNnI5?=
 =?utf-8?B?b3ZEd2VySEYrWnJLckliay9ndEx0RDRONmVNbmxKdTVoZFNMZzJ1SHVHMm1Y?=
 =?utf-8?B?TGQ0OWlQMEdnYXU0azdkS1VneDVTUndvMlZxM1JDQ1lITk15dVp2enBxNWRJ?=
 =?utf-8?B?dHMvaVhCblpYTU5WSDBCTnd4c0xRekh0TkRVRFlQQm56Y0VIUGR5MU5qL01D?=
 =?utf-8?B?eGhUbkp5VWs0ZHJNNGdrM2xCeDdJdklxY05RNjhJYml3N0I1TCtHcFFISTZR?=
 =?utf-8?B?a3Z6VzdrdU5JaklscEd1WlVSc3B5eGVJNHp2OVNNajlOcitCRnV3RTNWeXBP?=
 =?utf-8?B?WTRHNXpDSmlXcjdraVBPcllEVVhjNk5Qb2ZyTG9zOXNxaXRleWM1WTNjYVc1?=
 =?utf-8?B?QmV1TjZsUUtxaXc5dERpeER1ZUZGSzcveHkwUktmNjE2N1BpcFBXVktMOXJB?=
 =?utf-8?B?VlpYcTcrMUxBN0FOdm5UNU5JUTVtQWlKbGhyYkhZb1NSaHk1ajFtK3oyTFJO?=
 =?utf-8?B?a1NjYjJ0WExkQVRlSjJpalNaQndVaWpNQSs2WW5aVUt0SHVXcENRL0Nha3ZY?=
 =?utf-8?B?WXhRTkpYSlFxU0NPTVVWem03ZTY3enpPenhLNGw2bkNGeC9CYmtWQmFWNlNp?=
 =?utf-8?B?M2srS01kNGhYM1kvNTB5cHBrM1NHMVJmdmpHMFY0TTVpNnp2ekZpejRTOU45?=
 =?utf-8?B?SStyOUxiUlU2OHBhT3gyNjBKcHFSRFdiRFQ3c2lsbnY2ZTRWdndkUjZlb3ll?=
 =?utf-8?B?U1V3UWtvYzBJUWY4N0FYM24wZHNIbVNEbEV6V0VJRmNuV1k1UnlaMlBENWdT?=
 =?utf-8?B?aUFLSlUyZTlBcWJOQWszTEFaK1RzcXh1S3hmUE96Q2JiRlRJOHozeUlsODQ2?=
 =?utf-8?B?NlppUUVDb2tiY2dwbm9UcGNldFBwRHJRNmF1YmsxMFg2ZHBtTFc5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac59efe-c661-4994-67a8-08de80b91824
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 04:29:19.9329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8vD6NQwNhbx3oF/RsA+fl7EA45F3R1FrzkQj3NU+E1tZpRtjfmkX1c1yklJMLNHn2MgR65EylSAWR9/qtLU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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

Ping

On 10-03-2026 07:25 pm, Sunil Khatri wrote:
> In function amdgpu_userq_wait_ioctl, call function drm_gem_objects_lookup
> only if the count is valid i.e non zero.
>
> In case of object count is 0 set the pointer to NULL for proper clean
> up.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++++++-------
>   1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 76f32fd768fb..a4fff90b190a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -665,19 +665,27 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		goto free_timeline_handles;
>   	}
>   
> -	r = drm_gem_objects_lookup(filp,
> -				   u64_to_user_ptr(wait_info->bo_read_handles),
> -				   num_read_bo_handles,
> -				   &gobj_read);
> -	if (r)
> -		goto free_timeline_points;
> +	if (num_read_bo_handles) {
> +		r = drm_gem_objects_lookup(filp,
> +					   u64_to_user_ptr(wait_info->bo_read_handles),
> +					   num_read_bo_handles,
> +					   &gobj_read);
> +		if (r)
> +			goto free_timeline_points;
> +	} else {
> +		gobj_read = NULL;
> +	}
>   
> -	r = drm_gem_objects_lookup(filp,
> -				   u64_to_user_ptr(wait_info->bo_write_handles),
> -				   num_write_bo_handles,
> -				   &gobj_write);
> -	if (r)
> -		goto put_gobj_read;
> +	if (num_write_bo_handles) {
> +		r = drm_gem_objects_lookup(filp,
> +					   u64_to_user_ptr(wait_info->bo_write_handles),
> +					   num_write_bo_handles,
> +					   &gobj_write);
> +		if (r)
> +			goto put_gobj_read;
> +	} else {
> +		gobj_write = NULL;
> +	}
>   
>   	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>   		      (num_read_bo_handles + num_write_bo_handles));
