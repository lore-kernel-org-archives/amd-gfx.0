Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7257CD13D2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 20:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8381010F47C;
	Thu, 30 Apr 2026 20:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lxZL/cZO";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E0410F470
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 20:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s10fyq/g6hmcXquMpigowG0kTsuUOjsrAo/4b7YWiVxwFuygYFBnnMxqSC8ZMkyUxY0ySOR7UU9a7hDevmwPPiUZV9XQ6Yhla6Q4XwT6BXhAPYj3vX86bsHJsv2EaRYGhAvWmQxFe2vx9O2YwxVCQ/1Eh1i0teeXLFVIwnmDFwJmAVZnopW5FRKexQwxGqHFxOBOo22f5yMZKklDHOHP6G+tCk7sM9DMJ3ljSqZ4CcZIs53hacshAG9LFrDSDa61Bfs7byA2iShPE/peObwF8mXS92Boer0UPEJ3rT1U1Oq+vBXo/UKC0xSoSjSQlAKjXs7jvrixIazgg2CymQL30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMYCiY6E8dXNmLMgJ2vgPz8qvBlGaYL2g3t6KXFavPU=;
 b=LXty9vvGLbqdPlGerlJwQKXTU2Z/OtGy8gt7LkUJjjT976rt1VAJ5N+/a8tiK8A18rA2pOGa3C3WHA/49KC7WSy6EmVhD8D2FkCLWq3JOhRSdMr7N0u+ux9GxA/YG8PYnELZi5S8XaBKIyObZG9mqKH+DR2I5F4fabpcV9iL03Jm3XqXR3+vwQ5Rqk15gy4ukLhNduSlYPSPhxX2I0oLqNEj5surEVnFBORITfsE37H2mufF2+vWp12/4c3R2+GG+wWziZcU//5fiIHZRn5seFcaCeOQf+snwlgwmWm7EGZi8YpOwIEjvUo4tqFIGwpa8fVtxoeMTPhtZwZlLIXFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMYCiY6E8dXNmLMgJ2vgPz8qvBlGaYL2g3t6KXFavPU=;
 b=lxZL/cZOB1lJLfC8UPUpzNLeRFWjlc/jwxr65NjqiccgEFvYL02bFYjR8DrscxN3HYSn6aoOpwSqJJQjCfqnu7vuqk4tLMpVXJeXuyy8CWAnz0VCxBWrx87jISXgoXYeh4xQLcJqb5s+hiCJp6vEAXOIm7JA39ffsDb4RkYRi2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 30 Apr
 2026 20:55:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 20:55:49 +0000
Message-ID: <1c1b5033-9624-4989-8353-441655139fc6@amd.com>
Date: Thu, 30 Apr 2026 16:55:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: Add input validation for SET_XNACK_MODE
 ioctl
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
 Vitaly Prosyak <vprosyak@amd.com>
References: <20260430201803.90458-1-vitaly.prosyak@amd.com>
 <20260430201803.90458-3-vitaly.prosyak@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260430201803.90458-3-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2574ac-159a-42b8-633d-08dea6fadbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: cEMAGDy0VIMMYdbhdwXO0Yx4r4Ra7ZiTy1AYoD/CBiC/vxNLxMYUN+eKIxHNzGp5RIW8I7dz0GXYHfJ35MpAOi5h0BGfOZulq948Z+r4WNM1dUFaf2sPsEf/GKZj+vzCPyq94HvZR1CpX5JRiQOjbqf/GvsX1hgu1MR1s5OtqFQML4NVZhzFqv77E1aaWyRKhOIgg3HBpp2NEOP/v9BCLih6EaSLFsvC5DV+OrVnAP1VePPO47eoBol34FqvsvZG2UTx86RUZVSftagiEHsQW+YEBjX+hRsmbcW7j+K8Z9JvjRV+WodgQ/uKuMJ5bsAaOfMd+5++7asnO0TjH4nnR0f/FaOrIrpklfLF7Kk7vFZBRbmz22dlf70V1DgF6FvE/5JJUl0i5y7EU1Io3CkGN/EKv1M/of1+pKHwy6Kp8DLMx4tqMxYA38EU21MyYrcNBU7Kft5pn8Ym3qTT5xjnT5RKY46Iudk3fC2cV2GByy/avgdkR/E0+7MaY4+hrSZfzhqrUuL256DgjVgeBohO2BttJlKZ70Cs8XTElZas4tO0wwGdiAmfUBAMdBehnzb5eXa7SimHq+zDNsq0BpR6jZZBb7NaNjxnig0LsACawJHPiWv0cUF8/j1l4Q//orIM2oZ0lCPbS67qYrrdDCmy3snLd8jT/g70U9LaUNe9bBYgzjWvHXDcIZ9W5NJ+GRrA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1BHb1loeXkzaTFOYlFTbmo0K1VkTFlzVlpodW95OEF0SUorNkdEeDNGOEFk?=
 =?utf-8?B?ZytyTm1NMmdLTitDNE5SZnl0Q0o5ZzRxdWNXNEk0UW1MQXFDenF2OVE4QXZz?=
 =?utf-8?B?UjVvWXBaVTdSTENFaWlNbVFWREZDUGdvVDdsVzVQMUtoV1RCU1ZiWWdoQ1l1?=
 =?utf-8?B?Z0V1WnkrRlUreUhuS0tURUgwNVRLTlcvTkpmbTU0S1ZZTXZCeXNEaDJSUjhv?=
 =?utf-8?B?Q0Z6MHA1TFZBUUxnMVd0VXZqMURPVW1GNm0vSnVlbzl4U21zKzI3aVMrdzFs?=
 =?utf-8?B?UU90U012UzVWd05JWUVPdm80dUo4YWswR3VWaTNIOHNtM3ZVSlZqYU54WnNt?=
 =?utf-8?B?cGh6REFua2h5WHZwTE8relRIYVFCKzBBTGlKNWYwYStxLzBPbExCdy9XYWJY?=
 =?utf-8?B?RUhXdXVRaWx3ZjVvWm82VWwxa2NFRmF4WmN6WExUNkkraFRvZTFCYnZ4dmp6?=
 =?utf-8?B?T3BqeWVveFdyckhFd1FReHUwMXNVRkovaENoczQ1K0x6cTdabkRUT0p5TnVZ?=
 =?utf-8?B?QW9yVUVpNEZmWEdhMEh5K3haZHRLYWlNT0RCYTMxc2lDM3AwMkpoaWxYbEtq?=
 =?utf-8?B?eUJMNWljZ3VXS2tOL2ZPRndFQXU5Vk1ZbFd6REVTRmQzcEQ3WEQ5T25uMjI5?=
 =?utf-8?B?SGxTN2QvWFJFZ2Q0Mk1sbE9QUmdaMU8xY28xNkZrL0VxclpRSlRXdHljUUlC?=
 =?utf-8?B?S1JGWldJUVkxTktHN2YzWFdhYXJtSUpnL3UxSG1IMngyVVlYZ3ErSk12QVlo?=
 =?utf-8?B?Y1gxblI5MjhIZzkxcVhsd08vN3UybjRBS093UW4wMWdWK0pjSk0vK0sxN1Z1?=
 =?utf-8?B?bkc0ZkVxa3BMc24yMkgrWFJSOVhRV0xJZGl0RmJkdlZGYjBzSEFiMlNxRnFW?=
 =?utf-8?B?QzlwNFJQeVdGdmJhWm4ra0JKK3J4SUVMZUlaMSsyN2hpZlpGRzB4bTltWUNp?=
 =?utf-8?B?S3RBQVI5L0QyK1BsbVBEU1h0NTNYUnRaam5QeDROb09HMC94TlhCY3lRMU04?=
 =?utf-8?B?aTFTVWpUYjVlU2RzTnRFakxiMGtBMm80bXZHZjNqakwrWkdMelgxd28vdi9m?=
 =?utf-8?B?ejB6c2J6NDZmQ29LaCtXU2o1ZXVOTjQyYjhXV0VBb0l2L3JPVkxRTnRNRzZn?=
 =?utf-8?B?TUpLL3J3eEpMYmNENDFyckt1K1lJb1lXcFFtUEhvWnloeENZZ3dxOUdEd2xE?=
 =?utf-8?B?eCtlWkdoemRlM0RYZUlMMm9MRmY1aS94cXUrUWFCOHpDcWtjc1JYdE1YWStK?=
 =?utf-8?B?UXBKaUVIZlNyVFhjbHVYVFBhV3JsWmo0eU9OaFlMQU5zb241U0hHcHY0MWJh?=
 =?utf-8?B?YjZDYTd3ZUVHNmp4Q0U1MnZZeTgwS2VoNTBxQmw5TVNFWnowTWx3ZW5IRkIx?=
 =?utf-8?B?ZXBYczlFVGwyVVlaRlAxQWNCaCtaeGZVWTlDZU1DZENQOG1ZdkpnOU9sRUQ5?=
 =?utf-8?B?MjRyMXUvdmgrTGNVN2s1KytlR2RtVUEveWlaRTRRcU80WXIvR1JZU0FuV1FL?=
 =?utf-8?B?WDZDYUZIUm9LOWhJZk9lS0VTd3NJd1JNdG9HS2svbmZVUjNOUGZjZk91SnpB?=
 =?utf-8?B?U25PUmNTQ0dvZFhoSFg0T1l4eDF4bzdpT0lXS2FETmhWVmJiSVRiSUZib2w5?=
 =?utf-8?B?YmdXeVdZT3NPcXluVlg0TDMrdmtBeWJMTUpjTlhiZ1JpdzNGN3lic1FBSGEw?=
 =?utf-8?B?bVVJNkNRZmdoMGNuVExla3FNZC8rM2ZBKzZyVHlJaVp1MVhYbWkzNUMvWTND?=
 =?utf-8?B?SVdpR2hhd3V2NkYwc2hiakdIcFA0d2h2R2hlOUJzRjRya3NLaVpNQVJlak9q?=
 =?utf-8?B?ODY2a1ZVUU9Ta0ZnTWxEQStqRTl5Qkp5aEZjSmtyS05BTjljNGZVTzRKajBK?=
 =?utf-8?B?UFo2STB1dVNIckEyeFl2K0huWXN2OFFOR3cxNUtsQW9VY0tyVGtScGh5ak9S?=
 =?utf-8?B?cklLQnpleHJIZk1qNVlpWDdzM0ZESGFQUlRmb3lEbjdiZStJRU5uNE1rNDFD?=
 =?utf-8?B?Q2VaQXZ1MkZEM0JqY2psNmpaaFpxS2IyUHZGei9aVmwvbGdmUmRZSVpGc0p6?=
 =?utf-8?B?bkRPUkhnckVJWk9oaHhKSGQ1Q3Z1d2djZEMrUDlZU1p1cW1GQ2gySVhva1V5?=
 =?utf-8?B?aUQxcDBPVmJpUFRqNDdGNENWN1hlQ2FlWWdxU2xoc04rQnYxNUEwNE5qZlVn?=
 =?utf-8?B?ejQzR3NTRHpSekFUekZxTUttZ1Y5Nnd1MVJkZ28wMGFXNVlTVGZoSTBzOERV?=
 =?utf-8?B?RVBzdnNXdml6aE9KUUFyeTE4UHlFOHNjelNjSEJyc3RNZHJxdzVPbkxKSnBl?=
 =?utf-8?B?Nkt6cE1aYjZoVFNRVTE3TUhYaWE4bk5RYnpBeURBdzl2UkkzdVEwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2574ac-159a-42b8-633d-08dea6fadbfa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 20:55:49.7876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EymEwQWU17sqPqmGa1t9qMBn/yCpn9YZdY5bXDMRRHJK+Y5IC80kGHkdgJ/WSO8LKonz+O6vO0bXpBiQMDZ4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B
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

On 2026-04-30 16:14, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> The AMDKFD_IOC_SET_XNACK_MODE ioctl accepts any arbitrary 32-bit value
> without validation. According to the UAPI documentation, only three values
> are valid:
>    -1: Query current XNACK mode (read-only operation)
>     0: Disable XNACK mode
>     1: Enable XNACK mode
>
> Currently, the ioctl accepts invalid values like 0xDEADBEEF, 0xFFFFFFFF,
> 0x7FFFFFFF without returning an error. While the kernel internally treats
> any positive value as "enabled", accepting garbage values violates the
> principle of strict input validation at the kernel/userspace boundary.

I disagree with this statement. E.g. for boolean, it's common that 0 
means false and anything non-0 means true. In this case it's extended to 
0: disable, positive: enable, negative: query. This is also how the API 
is documented in kfd_ioctl.h. I don't see why accepting values outside 
the range -1..1 is a bad thing as long as that doesn't cause undefined 
behaviour.

Your patch is changing the API semantics. If you really want to do that, 
you should also update the API documentation in kfd_ioctl.h and consider 
whether that may break existing user mode.

Regards,
   Felix


>
> This patch adds validation to reject values outside the documented range
> [-1, 1], improving robustness and catching potential userspace bugs early.
>
> Discovery: Found through systematic fuzzing of KFD IOCTLs using the
> IGT amd_fuzzing_kfd test, which revealed that all fuzz patterns
> (0xDEADBEEF, 0xFFFFFFFF, etc.) were accepted without error.
>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Vitaly Prosyak <vprosyak@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 881ea252b3ad..57bd1e78b3e5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1716,6 +1716,13 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
>   	struct kfd_ioctl_set_xnack_mode_args *args = data;
>   	int r = 0;
>   
> +	/* Validate input: only -1 (query), 0 (disable), or 1 (enable) allowed */
> +	if (args->xnack_enabled < -1 || args->xnack_enabled > 1) {
> +		pr_debug("Invalid xnack_enabled value: %d (must be -1, 0, or 1)\n",
> +			 args->xnack_enabled);
> +		return -EINVAL;
> +	}
> +
>   	mutex_lock(&p->mutex);
>   	if (args->xnack_enabled >= 0) {
>   		if (!list_empty(&p->pqm.queues)) {
