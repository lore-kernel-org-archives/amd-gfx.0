Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2A7C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0690210F222;
	Thu,  2 Jul 2026 08:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ppzFWY0A";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A7610F206
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 08:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HarDFEGGF8c6fBVl64HSoUCYj+JedZPiy6W3QXcxry0J34k0frsRJc1xaPmuyJP0o9gc8cfvIzvU8o+wizEhQbJFMzOlNoHgkPmrvh6hBbVz4ii8aQbMO0n3DJePEUZnXHxq6KE2hT4EzFBVi9L7dohU76WX+Ct61YpT1pTj35WbuuROadMxtMnImdBboHzey4T55SNrukRRoel5LN5IAMWneh8bi7PpI1Yt04pcgqkrruHrowxVU246tVJkr/JI4z9lGC6fJ6sIlPTHrgckjdSUR5VuRMXk6Jwt6qJBZye23R7lz9q9LyTGIKXdKYjqi0Dbsy5AkIe8CWXwgUIFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICVY+L5yrZb3xom0/Ej2XuUHOvR2cg+VyibIb8OD6yw=;
 b=SU2tXmUVPRHeS41DM8ByW7FDJLz+ucdb+qG53FnZah8gaSxdeLaat0LoxybXBDx1MOiYO5Z3fYu9d3NqIKHJnLhT7858z/teG6bqd4BKtfDgSeilmLbssRC5Lg1PiZ11Sre/cqghq8xJJu8Jixg7yMuAvbkSp/qSCUALCXmfNgBNJuWNpejyZfH2SrvBNMedUmT7ABp8xeECQrQ/7JoUoHSQIyfqM7VhuF6CJsjWqfQX9uGEBHCwvjZfxox4eyDBSqJ/zbVWdNoN0ZoVDCtX6kAT6ogjPew2lY9UGnMUfIo8MnU+xgxoZKGLGbSz7xgcox+U6DlsrH4qcNAp2k5OSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICVY+L5yrZb3xom0/Ej2XuUHOvR2cg+VyibIb8OD6yw=;
 b=ppzFWY0AT6RjWn6Fy1iiGiMmzwFWzKK0hLNU5TAHkxfQOqMGvrvFqAmXN9hGoa5GL2eusDXaW16mqUle2C7QgRKU5lObxUP6UAadFQBZwM+OlW5QDYgYwyGPMTFYh7fT0Pk02xo5x6qiPEKsMTvYEtOzdd765PPzGx9ipCXa/Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 08:11:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 08:11:03 +0000
Message-ID: <44c427a8-8e6c-4392-9c3d-fd2f907aabdd@amd.com>
Date: Thu, 2 Jul 2026 10:10:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] drm/amdgpu/ih: Don't perturb HW registers when
 accessing soft IH ring
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-4-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d81ce59-9750-404e-42af-08ded8117588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: A10X/mivy3Iw9X7LZqnwsW6I1FW3rgtwIm9QyIyCj2h3w3HrEg0k20n0VvPJooXLll0v3okX++41mCul6MlG19B+5wMNQTFS5y7K3GnH1nzoEkgXt887UyHgZGPVNAU7G9lmsF+WGtyFZkhqkdzPyN+Sb5TNV0y+FG6KM4Q+N+5StF6uRAHAYYtLr/3NeMdDO7Vq7V/HJ+AUC+Ex17rByqFagNfRMVqa40X7i4RC6n+CZbOo50pYTXTU1K7rnMj3DoJMqhnNlxpP2ReGG76gZIuM/+SvX9CKU56eC/SkT8G0Mzjc8wauTRuyJb48Jxbahz5Uo3ILLq4lZp4nHDDrwa6bP23gtvkDNhAU1gor5d4V7eJk+CTdNPNJmLzXhTwI5sF67CrtBhcMZAXWdusOw908uasOlCthZ1BwpjqZNRjuS4p+xZuJU/Ueogwtcc3La6KmnDGffw2e5aRxCBgNmxkH1Jm1CK+Y/KJRv2phwhvM1mMCjIg7HzuKPatgnBkmefEbcnsJz5vGCuGf/nx6GXBkUvIyvUIUXM30ICNKe4ANNxFSXR2yGdXKzBOII5F170Q9tOomql7QQGvUmzqMvob8OwknuFUfMCUJ91LGTVbibyzgatIBZWjLCrIhZysIgr5mZDZ9uQWqnMRWK9bJuFlAhXo4agFhLvrULEmICb7a5lA8Wb1sQ4jHwxkWFSHaRhAjp1RD+tJC8wUWBupz7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJ6MVF1QlRqTWhrU2d2V044K3U4QTNkSVc0S3Zucm9aOWpIT2xtTlRFbDN4?=
 =?utf-8?B?b3FPT0M4dUhVaVBiVm0wcXZzUzdRaHM2QlMwQjZUNnJpRm9aNWlBL0pXMWwr?=
 =?utf-8?B?VERiMVdvdWZMM1FUNTlRK0pqUHFGY3hyRUF0MVcrb2dEU0tLWm8wQ0xzUVpS?=
 =?utf-8?B?a2RJclhrUUZjL3hsU0RLclJNQ3hKdS9TMU82UHVPcnBhL1JQQ0ZNeDVNdldK?=
 =?utf-8?B?aTByZFpGUVhrSS9XKytqclRBdi9kWkI4OUVvT0YrRkV4a2E0NGpoVlI3WFJY?=
 =?utf-8?B?YkhQV3dqMVc1SzMyTTZDbWJFc2thMnY4NWJ2VkxJb0JuMmlhUS9BK3dRS3hk?=
 =?utf-8?B?VG1UV3FXemRQcHZCa1FHVWNUUjRiTDQxd2ZqcDlsLy9hYnJHYWUreGpLU0ln?=
 =?utf-8?B?SFgwbUJNUlNmSnZxZUxPbHgzTXZ5WVBWT3loR1ViQ0F6TlhqdU9seThtTEVt?=
 =?utf-8?B?d25sZVhwcU4yV29aV0lVVlVUT0ZkVzZPMi9XSHJRWnVSUnVRem41YStaNVNl?=
 =?utf-8?B?cTBiOXk1TmhLMXFjNkR2WkhicGdzVkdIZkxIajRoSVZwNUhMU2tWcWxVVXFY?=
 =?utf-8?B?TmZteE1VOWRZYlQ0RXBDNS9PZHgyVzkzT2JVQkNYdFJNbEVocXF5aWVZRDFm?=
 =?utf-8?B?UlNlRERPOGRXK0l4VXl1anJRZnRodDdIU3Z3QTcvSElpNmRkWDZEc2g1bHE1?=
 =?utf-8?B?RXQrZStUN1c2TWwxdHhtWjQyR3RySWU0Z1FqK0NSRVhFSnBsNHExOVJGNXdC?=
 =?utf-8?B?MGg4dmU4d2t6aGdydTJwK3Jqc0h3aFZRRDlxNGFHQnRrRTVRMWJWelJnanJR?=
 =?utf-8?B?THdsNU5XNzhwbTRIeHpaT0xFelJMb0dnbnZqa3YwQ1ZCZFA5cjJiK21xaEoz?=
 =?utf-8?B?QisrUGNWUFY1blozbm55azRlKzRXUlZvVlNjRCtoNkhWV0xqT0QyNm9waVIv?=
 =?utf-8?B?TTFURTV1ZDF6YmM5L045L2t4bHJyTUQzUzVYSXdESXpKd3J3Vi9tRmFEcmw3?=
 =?utf-8?B?dkJtdFU1Yzd4c2ppYXlqblh1RHJTSlRYMm5ib2tkazNlUTExQzBqamJ5RDBT?=
 =?utf-8?B?a0Fjc0toWFpITmtiYWt5R0NZWng3YXhIRmwyajFpM1JyQ0VNNk5VWWJwT1hj?=
 =?utf-8?B?ZytLTnZKWHFpRnA5Ry9xVkY0MnNwbEhFVmswbSszRDFRaGFZSkdDNlIzWEpj?=
 =?utf-8?B?Yy94MzB0ZG45OUU4YjkyQ0tCaHgrYWJXRmJHcmJZWmZyUEx2ZFIyUzJOUmE3?=
 =?utf-8?B?SkFaR0FRK1prUGREbTBHVjB3NUdjRnMxR2MzanptbXN1WHJWYkh2cDZseFI3?=
 =?utf-8?B?N2c5Ri9Lc2dNdSttZVRxVFdwdXM2VzlRaU5uY3NFRGx5cEd6YzZpaGtxYi9D?=
 =?utf-8?B?a2xBREcrYVVXZUp3MFR5Vk5OUEkyd2w3R0lqZ1liaTU3NVVNRmZVbjk2QURI?=
 =?utf-8?B?Q1A3NU9uZFBQQk5RekhlTnNGMllxUFFwV0J2R3R0WXExcXRpSHNhcEY2b2Zh?=
 =?utf-8?B?aXlaMkh3SFU4S012alpYNGR0dVB5eTNyT1ZBOGVVSDlwVHJWOVNYNWx0bWdk?=
 =?utf-8?B?V3FQdU5maEVDa2lFZllPci91akpFOG03ZWJKSCtzNGk1bzRFbWJFK3pqdVJD?=
 =?utf-8?B?aW9qWVEwd3FNNDdUL1JSZXpmc1Z2WXhjOXZyb2lTZGM5Qk5JTW1QV1k1MWtT?=
 =?utf-8?B?aTJiL2JDa3FJQXQvZGk2S0tmS1M0MlF1azJiQnBTcTdjNUU2cDBpUjBQVHBw?=
 =?utf-8?B?bjgvR2NXWHVKVzdiSUFScGxIMmhWMWp5ei91RHhuSkV1MnhaZHZUQnVBSmNB?=
 =?utf-8?B?ZllYNUU4QkxTSDdhODhNZTc2azNPY09iNHVRRm02ZnYwQ1lOTUVRSUYyS01x?=
 =?utf-8?B?cTBHeUY1NW1xUTRncllyNnpOVHhlS1hRMlpJa0FCSm4ycWt1TzAveHdJOXVW?=
 =?utf-8?B?S1RuRFJLUGlZR2RLVmV5VHpGaHpxSlRQOEd6eWpidVlCaVR0d2tuU1Vib0VY?=
 =?utf-8?B?MTRTWllSSmVNUEhqUjYvWGlPcVFZcWkvb2FtZmEyV1lqUlhrejNMMHdKVlFG?=
 =?utf-8?B?NE1mRExGSkVrM2NZZHFPaEErSTE5eHVnVTRjdEdqNFhYR0l2ZjBJNGZWcC8w?=
 =?utf-8?B?WWRVQmNtYlhKaGRmREhsSUFmUTJVS2dFZjM2R2lQTHJHQzMxZ21FTFdGUWVr?=
 =?utf-8?B?WlExZEJjaEpiN1FGTUxJUG1DWFlHekIrVVFvL3NSOWsvUDgvM3JkRFVZRnhh?=
 =?utf-8?B?MjdhV2FHQnJraGNFWEF4NkRRR09ITWJvZWtycnlLdW5uTG8rNkpybHpvb0ZF?=
 =?utf-8?Q?jWDzXzNZxqNNIwNIpb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d81ce59-9750-404e-42af-08ded8117588
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:11:03.2845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9kQCtvbQ0xYOvrsBTYkfPn/5iGlltJL9HQQ9Yj/I2kYr7DG/P/jH/cuAldhRabJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
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

On 7/1/26 18:17, Timur Kristóf wrote:
> The soft IH ring is implemented entirely in software.
> We shouldn't read (or write) any HW registers when accessing it.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/ih_v6_1.c   | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c   | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 4 ++++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index 333e9c30c091..65e5d21753f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -439,6 +439,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
>  	struct amdgpu_ih_regs *ih_regs;
>  
>  	wptr = le32_to_cpu(*ih->wptr_cpu);
> +
> +	if (ih == &adev->irq.ih_soft)
> +		goto out;
> +
>  	ih_regs = &ih->ih_regs;
>  
>  	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> @@ -514,6 +518,9 @@ static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_ih_regs *ih_regs;
>  
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>  	if (ih->use_doorbell) {
>  		/* XXX check if swapping is necessary on BE */
>  		*ih->rptr_cpu = ih->rptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> index 699c274d357e..9dbc20131410 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> @@ -410,6 +410,10 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *adev,
>  	struct amdgpu_ih_regs *ih_regs;
>  
>  	wptr = le32_to_cpu(*ih->wptr_cpu);
> +
> +	if (ih == &adev->irq.ih_soft)
> +		goto out;
> +
>  	ih_regs = &ih->ih_regs;
>  
>  	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> @@ -481,6 +485,9 @@ static void ih_v6_1_irq_rearm(struct amdgpu_device *adev,
>  static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>  			       struct amdgpu_ih_ring *ih)
>  {
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>  	struct amdgpu_ih_regs *ih_regs;
>  
>  	if (ih->use_doorbell) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index 6de9e87e04e1..bd332e8cc5bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -457,6 +457,10 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device *adev,
>  	struct amdgpu_ih_regs *ih_regs;
>  
>  	wptr = le32_to_cpu(*ih->wptr_cpu);
> +
> +	if (ih == &adev->irq.ih_soft)
> +		goto out;
> +
>  	ih_regs = &ih->ih_regs;
>  
>  	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> @@ -527,6 +531,9 @@ static void ih_v7_0_set_rptr(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_ih_regs *ih_regs;
>  
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>  	if (ih->use_doorbell) {
>  		/* XXX check if swapping is necessary on BE */
>  		*ih->rptr_cpu = ih->rptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 4cd325149b63..e7ed37bb48e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -417,6 +417,10 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
>  		 */
>  		wptr = le32_to_cpu(*ih->wptr_cpu);
>  
> +		if (ih == &adev->irq.ih_soft)
> +			goto out;
> +
> +
>  		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>  			goto out;
>  	}

