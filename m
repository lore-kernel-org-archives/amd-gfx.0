Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2391FCF3962
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 17:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD12D10E73B;
	Thu, 19 Sep 2024 17:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bwom6dRm";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7528610E73B
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 17:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7Lcj3BPnpaQ/PFJhP4cSlTM9gXQufZ6x5eSq6xYSEzavQRi4mmttZSRPfFWMGGLVl4dx7buzOgctR0Uz+S/14G3QrVIAXRC7SZa+XMbi92friQ/XM6CFrCDUi1PxKb3BCoVawAAKDcvUThvKMXZpYBvaF0dGI7kTXcuHDnfgCRSUzVHyp90DNpAnOVJVMjpz/WYH0HuyQyLPGH+8/jEf8x9srF5wUezGmwY+U7pU54XUMV7RJG/xF/Hpcqonqn35tzMigXpp4gj4kSCegpipHi1kGOLzwLrH4yN7k+yXzab7jMdoUABdQ3+8m3tKv7KkiAPnV0jSayZZjK6Vfbn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DXsoB7cVyDxlmHs20U7liIcQAHRaqllnzRuHO7ZQvU=;
 b=ThVEMiFQtmXaSgNhZ0tXc24o87YtPNl+9SHUYKUM3l58rIdefklEE7Kjj4zqKK156kJu1Sxe0Fz2wkZC8FfbgeH+mIGBHYhtA/6gf1X2CHlgOOnBGLYEg6jyVVUiWi2qw0hsz9SGXKegoKQtqyjSvHTVJxIAhEjxhgiNqUcpZvwcOFMfehltBnENl9HHW+AasK5XrHb3ti8NVW1lqc1tZG4zJwElNOIVmaleRd1n0uTP0pzKMXso733qJIP5vl0X/rPbha15e0AMzm5ukZu0hVSzo6TTiBNxWOx4FmVzCBzAjZL/V/3KAKkPP1+duVXWJrQ4FulBU7jh3I752morZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DXsoB7cVyDxlmHs20U7liIcQAHRaqllnzRuHO7ZQvU=;
 b=bwom6dRmbbZN7VFkaJDRt/K16h5aR2/vfByhYVWoGz5v0HS7EO4oisNxcYQpHkw3sXh0tLDbPh5BbKXsUONIb5ndG/ik12Vv1vuZMBpUDedhUmpd3n6rWoD3o9Jkka7G/2K/Ami1NGKcs8mLfdHViD2aIy7GLPOk9ZyvU0q1t0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.28; Thu, 19 Sep
 2024 17:41:14 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:41:14 +0000
Message-ID: <56436d34-3467-4cbc-b840-589db42650a7@amd.com>
Date: Thu, 19 Sep 2024 23:11:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx9: set additional bits on CP halt
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240919164700.2579011-1-alexander.deucher@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20240919164700.2579011-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::11) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 6903fb51-b108-4caf-f4ff-08dcd8d241d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0VNdHo5WW54SHM4ZTkwVDlCSmV3dEsyd2c0U1l0RkZPUCszUW9zTDdIUVFS?=
 =?utf-8?B?Zm1obHdpVHlCZ1NuTWFxeTFvVUxRdUV3b1QvY1dRbDZMUGVGZlNFQ2JhTjFu?=
 =?utf-8?B?ekIzYUYreUNoQWZ2Yk05MThlWm9JM3pmZnFyTFp2WHgxbzF0dlUvamUyc09Z?=
 =?utf-8?B?d0RvQy9qd1Y4OVc5RlEzcER0VGYxOFdnVzlhVU1xNXkxdCs1L24rNEtqeHdH?=
 =?utf-8?B?S1ZjcjlOVEY0UERFOGtkcjlBVzJoczlzV1l1NTFYUktvUjZmVldDRUpXQUd6?=
 =?utf-8?B?QkV1bk8yQi9kaFNqOWZ3eUhjTlFrdlFieElvdDRpNnlSclZad1VDVy9MNUQz?=
 =?utf-8?B?V2xkclJnUkxMd1o3bC9WbVlCVklJN2JVQUJnZHR6RnFBbmZQN0FRRE9rTkVW?=
 =?utf-8?B?bkJ4MWFzeHZDdTNxMzYxNGROV0pHRzhEaWJiYmI5RWJrdkN2NWpEbjZHVlAy?=
 =?utf-8?B?aDROcmp3ZVRUVEUwR1dVejQzcHlXUmFGcWQ2OGVEb2FyODFoQUZqbkdrNVM0?=
 =?utf-8?B?eDJWT1N4d0R3bnprRlBaY3phS2JDNkhZa1ZrcE43eFlVNFp1Si9QNWxzMkRB?=
 =?utf-8?B?b05ISU9naEFhNXNsYmRpZjMwL09hdnN6SnRDQlJWcVZBelBlODNFTkI4VVpR?=
 =?utf-8?B?cElheU9DeENSNjlmRSt2a2F2bjlQNjB5MjQrUXlkdmo1S2YyZDNKTzJpc1Fy?=
 =?utf-8?B?dHZ4Y05ZNFllYkhlUWpJYjBvNGplWE9tUkxTNDZnRFdDYTJ5UWVrWk9ZOXdt?=
 =?utf-8?B?MlhDMDcvckNLaUtVVENleExyK1hQSkZKd2dhTmpPV1ZKV2dFbGVKb094WXBk?=
 =?utf-8?B?QXMrOGswUFRCRXNUc0lydWVvamEzSEdxQzFPOUFtUWtnbXZXdmpUS2NreExu?=
 =?utf-8?B?dW1VRFk3STJCL2tIS2tlcGNNaVFUZ3IxL2w2ZXVreEE2VkRqSFkwRGR6Vnc4?=
 =?utf-8?B?UmdTdjNDU2h5VlBJSTBUZVp5KzczbFVTZ0VxcXhzS2RjSWY0Ry9sVlZDcVZj?=
 =?utf-8?B?UTlGRVhkU3ZqUlZaSVNITkZxdHBnNW0rclZMQzJocXZoQ3BGVDl3dU53QkhM?=
 =?utf-8?B?dDZaYjJSL0I4aTJnckg0dll4b3diWElCTDZlNGp3c1pBWFpUSTJBVlhqNjNR?=
 =?utf-8?B?ZHRwTWJHQS9Na3NrWndkWUhTV2pSREU5a1ZWWjZKcHV6aGhROW5UTUpORzFO?=
 =?utf-8?B?YjBkSFhjekdqemlFdS94Tm02YVQ4S2YyUHBmaTJ5Qy8wdTRLa0twZnBlTkxz?=
 =?utf-8?B?LzIxTWtSUmZlTmdxbWFuUlV3Q0thdnNZNzNyWnU1M0wwL3g3Wks4ajJtMnMz?=
 =?utf-8?B?Z3p4SHJxZlJWc1VxMFo4M1IrclJjVDN1em9WSkNTMko4R3lBdDlNWUJ3WlJi?=
 =?utf-8?B?Z0JraTdVaHB0dGx5S2tRWXh1ZkY4dnNLekdVSlpGWnhYVHd2eVZQWkxxMjc5?=
 =?utf-8?B?SnRCVWxCZzFzbDd5VDI4WU1pMWl5OExxNkNUcTEySERFd1dwL3ZBQXVFOTV0?=
 =?utf-8?B?TCtYUUNiczFDVW01NTlVYTBocDhOYngxMDdhUVZIWG83dnFydTBIUjZMY1lM?=
 =?utf-8?B?ckY0dU1nbUovN25VVXdSeHJNTUsxMEt6d0pxZlp3SnFYMVkwOHZYMlQ1Z0Zk?=
 =?utf-8?B?TWFIWWNEN3BzODNoUkI0N29UTGJtTkpSWFdIaW42WFhaaUdHZFhtK1BYV0Yy?=
 =?utf-8?B?aWo2cVozNEJkU1JZS0NGU3dOQ2JJZ3ptd0RRVW5EV0Y1bUluK0VDVW1TbWxC?=
 =?utf-8?B?K1IySFVVOUJZWW9EM2lmcExUOEhITW44L2xLRG52ZDkvREt2VGNpRThKK0k4?=
 =?utf-8?B?M1JvZUtiKzB2Q0ptVnBmUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czFvaStXWk43NGZUWUpNUGJ0ZmFESlk1UVRJWVdIQlFMZGdVSXlTeTFuYUtW?=
 =?utf-8?B?RmxPWWRQeGY1ZEJCNFlNSEg3UEduREkydlEydGhMMFBqRXBjdVVLUk5NbG9q?=
 =?utf-8?B?cnFGdzg0WWVEbGlVd2ErdlZGMTVNTVUzcWlPTzVzdmpma05JSWt4QWN6dUxy?=
 =?utf-8?B?Rk5lUXlqdHhscGFGQUt6dVRDeTBZREJtYUlpQzNhc1orbHI5allhVkN4VklR?=
 =?utf-8?B?NmhqSk1ONWRBOW5VL0lacE5GRFlYWWljdmxZZDk4Q1R4RERqTmpxbkxRNjM4?=
 =?utf-8?B?b0YzSHN6c3Z0Y2E2a2RvcC9ENzJ5cVVnd25BWEFsd2w4TXVmR0I4dlZFeCt6?=
 =?utf-8?B?S1ZDTlUyMnArWWZ0RWFWeWpLOGlpK1ozUWZOcjVwZEJFcWxWc1hwTEd6NFB0?=
 =?utf-8?B?VmE5N0h4MkErL25tUTdmSHViQUZRMGMxaGVXa1FCMFRPRWhkemk0dlV5bFVU?=
 =?utf-8?B?OUlnQlZ2Z1hWMzZvUjNWM3d5OXJEVStObldIdXpDdzZaRCtvZWJwMm42ajd4?=
 =?utf-8?B?M3NOOG45UjRXTVlyeTJzSFFHOThSMGEyZldROFd6eFc0SlU0Z3dHc1h6MnJH?=
 =?utf-8?B?UWxyZ1doQlF1RG5nbmdCQ21VTjJBMVY3OHVjWDhwTXE0d05JWjF3cmlzSE53?=
 =?utf-8?B?MlBxMUdtTEtWUGdFZ3dORVFLNUh1R3liZW1DN3ZZaGdMRDFYdUFQYVdwQXVn?=
 =?utf-8?B?eFVQN216SDI0WFpXejMwUVFPVTBUbFlpN1g4UTZIOUZxNHNXNTJyeXRkVDg2?=
 =?utf-8?B?TlJGNU5nRUliVmZPZmN0aWlKMnZaZzh3ZmloWDlwZmRKa0JMUGtnK0p5elN4?=
 =?utf-8?B?MVo4MDNKUk5YVFJZMnpkVnVkM0paNWZiN09hZkxGM0NydUovdWlXN2JRK0Er?=
 =?utf-8?B?MXFIZHMxYlkzeSticzB4U0c4TU5xaGNFc2xnN252a3ptK0dGQ1BReUo1a2VJ?=
 =?utf-8?B?N3p5aHpHbkpkMm5TazNOaTJKakpUOUVHeG1Wek8zR0lZb3A3OGlTb0NaMFhB?=
 =?utf-8?B?YTVta3ZSYUJIc0NmTjRka1BSKzErUGk0Z09oR0pSVUlwU043OVBaVDJpemZn?=
 =?utf-8?B?ZEFrOG9ORGRFb0gzdzhVa0tkeWYxUWJhY2xaaFhRbmtRWXRVWTNFSEVrdEg0?=
 =?utf-8?B?RVAwVzlhZWU5NjNTQWwxWDczcFdXZmdvWHVaUlNVRzI5RFBQdlgxVDhoYmVJ?=
 =?utf-8?B?bGJ6Mk1KKzA1UGFrNVVPWXcwSGZOMytVWSs3ck41REljdGRqSTVNN01EQVVo?=
 =?utf-8?B?ZWdjQkg5YzRiM3FTb3NVWjNGRTYzbzVOSU9hVGhuNWgvU2JkV3Y3WUlSSzdY?=
 =?utf-8?B?d05NWjNvVkJialgrL3oxMXAzTXNiS3AyNkJQbFZpTWsza0FtQmRuUHQ5OEha?=
 =?utf-8?B?ZzZzM3VGd25yNGR4eUl5M3ZucjV4T2hLclBiOXRSSDRUa2xEWXFVYVZCY1Fi?=
 =?utf-8?B?U2thM2YxVzF6UEttYXRsZ2Z2bXB1cWhiR244eGFnZ05qU1Q3TDdZbUxqMXQ4?=
 =?utf-8?B?WHpOSXJvTitXK3BrRWVJbFZqOExrVmFmY1FaSXlBR1ZNSHIxQnUyR2laQ1Vq?=
 =?utf-8?B?REdOTTAyMWpLYmJIZXA4aDY4N1FWZjNaVjl2czFUNm5XRzVmU2JhRnFCR1c0?=
 =?utf-8?B?VExxUFRMZXlsTEFaa1h0R0VTcWZ2ektZVWxTR1NLa253dlJ6RmM5N1N6alhI?=
 =?utf-8?B?a01kRm5uemNCTjJiaXZrcWVUalhoZ2xpNVA0ak1GdEdJNzRDR2RaK1U2WkVP?=
 =?utf-8?B?MDB5WnAvaGJWaElndXhWaDVvSURnaVRtSzhyUXROQWlkcUNLYXBPWXkwakxr?=
 =?utf-8?B?Y3E1YTlDQUNKd2RVVHpIYWgrNnFtOCtKSktRSlhQSjUzdk1LaU1ZRXVWdHZa?=
 =?utf-8?B?TkJNdjhsWGxORmJxcHFQOGVwdGxYNGlkdld3NHVJR3U0VXJHeENWNWR4RHFp?=
 =?utf-8?B?TEd2ZW01ZS9sbWhIelVqTXlRZXN5QUNEZ2paRjB3UDkyZ0NBODBTRWVUODhx?=
 =?utf-8?B?U01rdzZXK3V5eWhyalhsSEpBZzRHTmpuTWlEeVJWa0d1dkhhREIyUXZPYlcr?=
 =?utf-8?B?anUvZit4Y3p1NEcrSXpGaWF0TjJsUjhsdmV6V3lKOUN6a09UZDJIcDE2aEhm?=
 =?utf-8?Q?J1LRPYyiaa+r/AdosQZ5nw6cj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6903fb51-b108-4caf-f4ff-08dcd8d241d0
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:41:14.1844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeqPywJ7sEm2MEeSTz0ClAE8G6N6o3++iYisZpNBsVm0piCAOnNrmcCQBXrgKNJ/j9nuE+Y8PM6IY3OtP/TSQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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


On 9/19/2024 10:16 PM, Alex Deucher wrote:
> Need to set the pipe reset and cache invalidation bits
> on halt otherwise we can get stale state if the CP firmware
> changes (e.g., on module unload and reload).
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 23f0573ae47b3..d4f19eb8ff6d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3184,6 +3184,15 @@ static void gfx_v9_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
>   {
>   	u32 tmp = RREG32_SOC15(GC, 0, mmCP_ME_CNTL);
>   
> +	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_INVALIDATE_ICACHE, enable ? 0 : 1);
> +	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_INVALIDATE_ICACHE, enable ? 0 : 1);
> +	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_INVALIDATE_ICACHE, enable ? 0 : 1);
> +	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_PIPE0_RESET, enable ? 0 : 1);
> +	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_PIPE1_RESET, enable ? 0 : 1);
> +	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE0_RESET, enable ? 0 : 1);
> +	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE1_RESET, enable ? 0 : 1);
> +	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE0_RESET, enable ? 0 : 1);
> +	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE1_RESET, enable ? 0 : 1);
>   	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
>   	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
>   	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
> @@ -3393,7 +3402,15 @@ static void gfx_v9_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
>   		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL, 0);
>   	} else {
>   		WREG32_SOC15_RLC(GC, 0, mmCP_MEC_CNTL,
> -			(CP_MEC_CNTL__MEC_ME1_HALT_MASK | CP_MEC_CNTL__MEC_ME2_HALT_MASK));
> +				 (CP_MEC_CNTL__MEC_INVALIDATE_ICACHE_MASK |
> +				  CP_MEC_CNTL__MEC_ME1_PIPE0_RESET_MASK |
> +				  CP_MEC_CNTL__MEC_ME1_PIPE1_RESET_MASK |
> +				  CP_MEC_CNTL__MEC_ME1_PIPE2_RESET_MASK |
> +				  CP_MEC_CNTL__MEC_ME1_PIPE3_RESET_MASK |
> +				  CP_MEC_CNTL__MEC_ME2_PIPE0_RESET_MASK |
> +				  CP_MEC_CNTL__MEC_ME2_PIPE1_RESET_MASK |
> +				  CP_MEC_CNTL__MEC_ME1_HALT_MASK |
> +				  CP_MEC_CNTL__MEC_ME2_HALT_MASK));
>   		adev->gfx.kiq[0].ring.sched.ready = false;
>   	}
>   	udelay(50);
These bits are related to invalidating the instruction cache and 
resetting the pipes, which are necessary to ensure that the CP is in a 
clean state. This is particularly important if the CP firmware changes, 
such as during a module unload and reload, to prevent stale state from 
causing issues.

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
