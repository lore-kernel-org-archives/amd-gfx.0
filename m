Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8B0C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 12:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B74A112C46;
	Mon, 29 Apr 2024 12:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kbDHRmG8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D377112C46
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 12:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrAiPYg4Jj11GX8Ba4eTfzWtyImupD6gO9KlQdQrrwdv6uh5GHqTc4RsBVtKeX5hM+87X/MUtCyLNGGJGT6mYYfbEmB/47Ej/O8u6HiGOrPk9F2vsuCHL06vhVe1FrT7iOzRTarbQgfBgh5aXLJJWv+hD5nPqI26ds66aX/n0Th+csMgc/4G6KyaS7XLGqaeo80nuUuenqAhv3J78Nt1qa2YO3NgZMZVlWNpaa5fV3kkT8AXyy4eKtwQUYwvmpigwNM1tOSsQxPWl7g1ftGboagF3YwRkSAJjnt8Ur+BkuEdrICeKynPv37KDlEeFiRKvBrh9slGTXQZpqpQWMSrnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhxC/0cg3X26Jz312M1rPMmf1ApjlAY82V+1yaIJyhM=;
 b=EJLptuSFQivGWrB9ytWGl6YlVMB2x+iXJFVzZtUtOe4XkH1g92jSIxgkmIaPSZPxOhfHvyJhRo+b7pgoiHLMF25coHx1Tz05uv6YpqZNQMoFtZnwbwSLfrz5qYwrGjrzBeLmQ+pAvG8+4zcOg5lA8iXqOvqJyZjEUL/S4qzzR52Y6qr5ulIsxmZaUOoAzvrTZJlF4ZMSTCkuBjfOrpFC0eY/xzckGQ5TkgGW11q28tSqbpmrpiW9VhD1v3X4mPprjO9nZmkqdzi/uzozuO4jLYcsE2iItksSV0EHmNm3kS3VVtbWRf3+I1gRK0H2NVfFpG2JawD4wJIzUVD8Esj14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhxC/0cg3X26Jz312M1rPMmf1ApjlAY82V+1yaIJyhM=;
 b=kbDHRmG8JB2Uj08RelWXYM7aO3luO0i4tvxAOWYVC/rOf3gLfEZhcVQ1Vmdw6QlXjm5Y/9ETc/TVbABVmHlicFj1gNOtEiT6Foj5tIRpX6nO84NXsuCiqk9OSsSrqDSJUoWa808Pu2x7KtfRyQK+2k4Gdqd5r6hcDWzfjW6Np8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 12:52:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:52:07 +0000
Message-ID: <a04eb5d7-2229-4823-9366-00ca038dc37d@amd.com>
Date: Mon, 29 Apr 2024 14:52:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix doorbell regression
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20240429125038.1308-1-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240429125038.1308-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4833b8-b420-491f-5573-08dc684b2d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVdUdXRaTzY1L3pqKzRIZlpidmFvdi94b3hONmRBcjRtbFRRNnVBVjJqWDdx?=
 =?utf-8?B?Y1ZVMFpqaW1HMisvQVU0M0QycFhkcFhNQW0xdTRxQVFVZDJDRUxOTTBudnFE?=
 =?utf-8?B?ZlZibWJ2bFlQRDhFN2lEdzByM2ZUREdGOXBrTjBxL2FGVjVoTnhaaEgxTVFs?=
 =?utf-8?B?MTBPVFhhN1RXU29IS0FhYXMrTDYwRXBjaWtZQ2ZHc3FxcHNpUWZFOUprdlFG?=
 =?utf-8?B?aXBpVDZqVnBsa1BGNHNlK1kyZ2NqZ25ZeUZhRDRlbXpWeW9YSVNoeUR3Qmt3?=
 =?utf-8?B?OXVWc252QUJPN1RqZU9XbW82d3BORWZKRU9kYWZuOVBDUENFUi9yV2FQMzQy?=
 =?utf-8?B?bjV5NnBVL01GdUdrNW45QlJYUXNaVm55cmlBdWRTdUdBakhnem9aU2Y0N3Js?=
 =?utf-8?B?REd1WjVRRWRoancrSElucFZTRkoxZlBRV0lzenV0eE81ZUNpKzAyMWxKVVU1?=
 =?utf-8?B?MzVGeERvbUJ0WE5QdnZTa25LQSt1RGdKMXQ1Q1VNQ3EvM0l4bTh5d1VKVFNk?=
 =?utf-8?B?VWFRdy9ZTktxRyt1YkpDbHJpUkxwdEQ0c2lqYk5kcGRsZExEcWFUdVNsSkZX?=
 =?utf-8?B?aEdKVTRhSGVxQnNxSkR5Y1ZzZTVTRklLVVN5OCszemlJUmRhWWFud0NmUDBN?=
 =?utf-8?B?RHZpT2xHMXdhMDlNWGJxWWxvQUpXcTRXdnZyeWxHaTUvQUt2eFFxNlVPeW1z?=
 =?utf-8?B?RllvQU1NQVJ0VVhZR1QwaHczcXRyNGV3a1VScXZ1MnlHek1zb29tUkZ0WjBQ?=
 =?utf-8?B?V01Hd1RPT2V5MU9wSmpuRW8zaGV2M01iYUxhQjZsR3g0Y21XRmdDeWxiUlpq?=
 =?utf-8?B?VHpXVUZlMm5LbWc0QnZHQStvTGdGZ056S1ljRDU1WVhzRjJIdVdxQTUvWm44?=
 =?utf-8?B?ZHhIQnFGSGJ3bHhoc0VhTyt1aG96VjJ0anB0anY1YWY3bWVDay9QNkRpRnNj?=
 =?utf-8?B?N0hVcU9maXFPUmdLc2J0ak5tbUdQS0xHa25vaDhPTFVmN21tc3hTUFA3enkv?=
 =?utf-8?B?Wmt0M1h5RlV1NE5lUFozK2RjSHF6allibXBJRUVHMGxWei9VbXRQSjlOTi93?=
 =?utf-8?B?ZDNpZTY3d2JieGYzcVNINmRXUlN0SjZIQ1F6YjlnaEFQSEh2aWM5THdObmxX?=
 =?utf-8?B?NFZuNWZZTHd4TmhIc1ZMRUVWUXVaNnk3eFNESUk2Y2I2YzZ6SUU1VjVCK0Nr?=
 =?utf-8?B?K1hXWXdtYUJnL1RRRUhLaWxwbEh4MHhsQWxsT2VwanU4N0NWOFZNMzI5UENn?=
 =?utf-8?B?MWFZcDl3ZmhEdTFxNjFlR0Z1eiszYzlCM2M4ck52ZzYzQWZ3eGsyOUNVS2Fl?=
 =?utf-8?B?STdJN09HdUg3M3hHRlJoZktIMFBEU05Wam5Nak5HOUFvL0RhaFVocVF2eG90?=
 =?utf-8?B?dHAvSFBGeEdnQWs1V1lkQlRjR011ZWVuR2kzNnIxbktHbFdUWUNIRG5PK0w3?=
 =?utf-8?B?YkdxVkVPS0hLVEVFYzlDTDR4UHJSL0ZHRW50Nk5vWWMvZy9EaDgraUM4U0Rm?=
 =?utf-8?B?MUpPeDgwVjBuQWVIdUNEUUM1QzJIRytuVkpGMVBkckNJYkZFMk9qaFZjdmdZ?=
 =?utf-8?B?dlRkSFYvM2ZPeFBvQzAzN0pVd3ArcVlqalY4Rm4yRk5YQWlVbTRTbzlKUTU1?=
 =?utf-8?B?ckc4RVZ6Y2dxakVzdklhb3o5eGNuQUdTWTZFNml1SzdOSzJ6TGs0ZVJOb2la?=
 =?utf-8?B?NWVkeUlrYktkalYrL3NXUEZVS2o1L1B0aDNFZ1pCMWpIZExUS2pwUEJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRNalFrT0xTU2VTWHQvTDY5Z2ZkUm9jOE9INUh6dmpFWStpa0RrV1MxdUJo?=
 =?utf-8?B?NVhTc0MzMDczNzVYVExGcGM2KytGai9VTkJndHdiTWd3OGh5ODc2K3QxaUJn?=
 =?utf-8?B?bkdZMWtwT3BQSDREQjFUdUxXSUxzRy9CN2Q1dmNINUFSY2lNUnA3T05rTXM2?=
 =?utf-8?B?K1pOdUtzWXB5SGZ6YldrbXVteFMzR3JnVnFIZGlVT2RONDJqdCtTNmR2T205?=
 =?utf-8?B?VkZRSFpKOFI4WnJ2QVUyK0xQcjNWb1Nwd1hsWTBjc1JkYmVnVFJERStBeFBJ?=
 =?utf-8?B?YkpFYmdVbmFBVEE1UFk0dVVidGd2NUJmTEhoNkE4THcwY0hiTWJDNGl1MjlW?=
 =?utf-8?B?L3krMFp4MXhzc2U2L3ZCU1RBVDFpMGN5UHV3UEFqckYwSnVqaHVZaEFhOXRJ?=
 =?utf-8?B?VmdsUE83NEZTdUZaWWZZWnhaSnMwclVKOGpiSFJuNU1Id2pTVEc5TldRbTY5?=
 =?utf-8?B?eUE2cHpJUFZCQnlIbWVYUmxvQllQS3pqbXZPZVdwbVBKS1JDek9GNjY5Q1dq?=
 =?utf-8?B?L3ViM00vMXZoVjBvRFFJMVhMRmdVSU1EblJSa0lDUk9TVDNLR0tLWU1vZ09a?=
 =?utf-8?B?SzJ5T0lCUDA4TnNJeTRuenlFb3BxUTM0eVhQNDdnRnpxMXNMemJVZ3VWdzN0?=
 =?utf-8?B?N1E3SWtVZ0FrcEYwL2dOQ0FrYzdQMzhUVEtzdzhORDl0ZnowdG5JaEJpd1Na?=
 =?utf-8?B?NWViVVc3cEFTcE0xV3c4Ymg5VktmczR6RFg2djF4TksrWXlYWkIzUDdTcnkz?=
 =?utf-8?B?N2Zxcml0V2trNEhJSzBXNWF2anB2LzJEdE4rMGdEMTR2aTFSdDdLd0hrTVdX?=
 =?utf-8?B?dUFuRmVRWGk0TmxKRXZIM1UrdkNZYmgxT3h1dXpTRTlCZm1MdVhJNHQvSEJz?=
 =?utf-8?B?RGJ0NGx0YUdLNEZBd0xjRk1RZ3p6VTMyQzBzeG9DUDFrVmJUaE1HaC9MMHdY?=
 =?utf-8?B?eHgxdDdLK3JtN3Qrbm81aUJucDVnRERKZEF2UnNGUnhBL2ZzcWRESFJ5Mmdt?=
 =?utf-8?B?VENRRnZtUkRIdVA1UEJWeUdaM0dOdCs5a3hGQkVjUTFzL0RacmwxeVNjVWRv?=
 =?utf-8?B?U1JzT0dRcXdlR1RGN09vK09PZGJNOUtmbVFaVjF0blpFb3Flc0NVZUhWcjJU?=
 =?utf-8?B?M1Y2bWdkL21FSENGZWNMUFNMZDl5cUV0ay9LTkxPSkZjSlZrSUI0NGZ3eVMr?=
 =?utf-8?B?N3l3eUI2MWhmZDE1ZXQ4RjJvd2hWdjRvNHhla2Z6bzRRTy8wY2hWMmtUd2Rp?=
 =?utf-8?B?RVZkVW54SVpjVTlzY1JRUERkWG1UckNiSFA2cFQ5eFlaR3d1UXFhcGRYa0ZG?=
 =?utf-8?B?akVCd1pWdzFDdkFwRlVRUmZ5ZDMvRGtvQnVLbXNtSTIzQWpJdVhqS2Y1S0F3?=
 =?utf-8?B?dzlwbFowWXBEMnVLT2hXL3liVko3ZlEwdHYvSDg0cDJKNllHZFRMdEd1ZHdR?=
 =?utf-8?B?YkVHSWREWjdRbGgwdk5rRk01R0I1VnJ2WmRaQUduQXdSSDRWUXhXbnNmSjlE?=
 =?utf-8?B?VjJZbnFDZnBSRzYrVWV2SGg3dWpmZ2lWZkowbEdwTkIwbWpuU0NrMUdHMkhN?=
 =?utf-8?B?VU5ReStQSUVUQ2hseCtkS0s4T0hlek50U2tGWjh5Y2N3M09yV0V1M085SmR6?=
 =?utf-8?B?V2lwNzBoaTRZTm1Kb1RJa1NRNk1oSlM3Kzd1aU43bWg1RmgveEdMUXg4ei9y?=
 =?utf-8?B?cWRNNjlwdWw2aktvWkVzMGJYOUlwY2NJMXlyd3IreXBoeFkrRE0zTHdBc3h5?=
 =?utf-8?B?YjdGeERiTWJZVzlBVFlUbFBveFpjRWdQWnA5RVlBUTRPUkd6UVdPR2RTYVdx?=
 =?utf-8?B?ZWFBZ2xrZWg4cGN5M0RUano5MVdvdURCTEpZNUtpMFZ6TXY0cU9MWUp6dG9C?=
 =?utf-8?B?US9pOWpsS1dUS2ZtU0JwMjVROUlCM0hueGNRblJtcFdXMGg2MFhPd3hZYTBL?=
 =?utf-8?B?ZVlFd3NETzZtcTBKVHZEbVZENjNERGNLeWdwdmRHb3VmK1A1TDRXZXNXMGRP?=
 =?utf-8?B?TmJRY1JZbndjN3pUdlN5T0x0bXpFMlh1enJBVlBaVy9raHF4NGo4NFFBMElm?=
 =?utf-8?B?cjV2MVNTY3U2R0l3U2NINDRvYmZwNGV0K1hkWUNVY1dyRXZwN3ZwbDlYZEhw?=
 =?utf-8?Q?5c7E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4833b8-b420-491f-5573-08dc684b2d13
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:52:07.0708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlnwV/+UdFyORWKpEEVMfOubrTY1eqoOQpNbvcPnQL5zAIKdX3ibknHMd7j3XemG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

Am 29.04.24 um 14:50 schrieb Shashank Sharma:
> This patch adds a missed handling of PL domain doorbell while
> handling VRAM faults.
>
> Fixes: a6ff969fe9cb ("drm/amdgpu: fix visible VRAM handling during faults")
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 1d71729e3f6b..c71eeb6a04e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -419,7 +419,7 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
>   		return false;
>   
>   	if (res->mem_type == TTM_PL_SYSTEM || res->mem_type == TTM_PL_TT ||
> -	    res->mem_type == AMDGPU_PL_PREEMPT)
> +	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL)
>   		return true;
>   
>   	if (res->mem_type != TTM_PL_VRAM)

