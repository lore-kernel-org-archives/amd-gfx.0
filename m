Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ED2EC01B6
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 09:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF66F10E4AB;
	Mon, 23 Mar 2026 09:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h28IxsiX";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D1B10E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 09:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfIGZVFOyAXRmQN7tJ2Q/1NhCuMT6R5TmbVIuYYZH00ttMRYvPc8otb936xRiJP/4YbxSe8ed1eN5O6yJzFM8IBX9WSSY9hmpU00YXMg53dfwqy1zcQd18vP4R5mLvkGQKJi44EyNml34QTPbWEYhpqbHSz3p0IpIAVTaVsedSiUvTzP6sISTIxDznX+80xMaqdXzUUdlr3f9hgDMTS2cZu1Yp0C9QoxyQd4cOajRYTsYVsINy3aJaXh+y8YAwc9YsOnfX49Zc8nzjG5uo5MWiRMLenkYbbpr16fthNxZFqBAjHy759rQ3n2zNlB7xvkxIdsuNZULE9FxHdrzbt8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev2cBvPXXkl7Pnbuo6pA4/6kk0KYRl30P2hRkUjPnfY=;
 b=NVfhGxyGWwcKYXtXe2Y4R71XhjyTcj9rAS6DWwiDeqrdYPm49xftUq5jk35D0IqErfCmpY+I6jQCIkgsUf3tBN2eb19kIXjIam1qUIgBbATaT9BTT1clE2JJPFl0b0dT6sOmh+T8Mmj3SM2+n5NHgQiFgj01eLDcvePsndnLDerCkAgIAvp/nXPawRFEeSAF+XoI4vaRRWOb3t0yrEKbwrEIZdcQ3AawwOv8E6fCgKWJ0pO999Xz3nMRF0qbSbuZAjfWG8EA4iHe9oGioMq3NjerTnRvBSXQdCB2ufNNzHaF5AeIJTwEJawwM5GLaAiJI7iMRiA5A85n9hQxQCi+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev2cBvPXXkl7Pnbuo6pA4/6kk0KYRl30P2hRkUjPnfY=;
 b=h28IxsiXaJrhFBqxBaD6vC8+WC4vAeD67HeJr3dy/+zmAi8VJHG8OTLYfi+05pJtJ9a/ie1+xfJABYmq94YmE75DU1Chc/VkxWFLE67ShWUAI78s1Rgj2mLL7+r3sjNaBn8mZKZ9zWNdBER5c5NBHCalczWtnYlV6+Kl5ydQImE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 09:58:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 09:58:24 +0000
Message-ID: <e9a3886d-44f4-4c76-b729-f1e5aae22b8b@amd.com>
Date: Mon, 23 Mar 2026 10:58:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix NULL pointer check order in
 kfd_ioctl_create_process
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Zhu Lingshan <lingshan.zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260323085953.2047082-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260323085953.2047082-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6520e4-2d03-4012-30a0-08de88c2b922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: PHkuXM1RVq8GzS4lHND7i7gT4JpE8NBCu3bH2JVV5CXYVcM9e3bbMSx2JSiFjQO56zUpZfCAqmVn1PR5GdoFw+o2ZlEKzo+K0WkWc4lnjtBreOKPBHjUfmUTvpAtEigNtiNTyh+YSRpt4Byk6pjnEBZdf1jwps30G8yM+4Yrw7e2CKIlQq3SB0ydooYQNqg4IvNG5x2+ISpuzSzXbMmTULOq1z/YL64MgNwhUxcR1UcLrRGD95uWC6aXTdaHHzMxMWoRsqlUA7JfB12ygkkieXTS4t0vaBHlYppyDnVwRRh9owUWFK80rg5smk/ZVMhB5nkc+RzBx60HK4fFrqijS+l+UbI0QeKcR8BMGXq9VzYAZy5+K3k//A/tglPr2HRanMlnunCgLlyjcUXUf3Khw/UzIb2du1OrFNWjzOKJdCz027Gbzjx3b62XGcrq+QjKxUbDNS7B2cTDlGds8unmJKmtdCYUKI3kYTegS3rUWwVzmr8qfN6fpiSfKFrDyuKFkM2C1XesPPcvrFNZAy48sAiysrwVrftDQVKPNdDh0NF/i8FF+mRy1Grbx0eVdTxx6W4hHqnEAd8FNET/OYZQH/rSUw8moWvYsoJDWtyrGpeWZ8eBFOpp23vVkFzGrxUBQB6vHoVe6YVr3MXddgn6j4MmFi4ILtEKM0Y3ATWBSRP++aqf6jEq0AN/PxCSYlyBSQmmpPqvjkbODl7kvsyw0NU+GFMX8N3K66jP/e2QOHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzU2S3BVQm10ZGZDV3pDRkFidXE2cUVxUzdZWGpIM3ZNcm5Nd1g3STViZ2FF?=
 =?utf-8?B?OEdEUlNWNzRnRWlpWi93NWpKUXpwR0o5eW11VTdrZTNIK1c5VmdPOWdDMW1w?=
 =?utf-8?B?T2VmdTgzd1A1L3Jpcnd0UlF3cUdRS1FjNEVHS0VZbkppQk9XNWNMVEJuaVZY?=
 =?utf-8?B?SFplUjliVDNGMGgxT0lsMEN1ZmFscnFHKzhwZmhSQlBZcnIvTUw4ZXBGb1pE?=
 =?utf-8?B?bzd0U0NzVE9IVHJBWExmek11T0RyQ2ZXNnY4dGlHUEVuWEdXV00ycFAxK0xp?=
 =?utf-8?B?aHJzV3BFNDNtVHRrdk8yejF5UEM4MGZwUk04b3k3bXlQR25JVzhIL0V1cmYz?=
 =?utf-8?B?SjF3NlZHRVNZUGRrUHl1MG96Uk5EUWo5ZWpwb2doZ0h6Rjlvb25sWU4yVGJL?=
 =?utf-8?B?ckJrb1Y5ZEh3SlV3QkVDQnJJY1hIeGJIcFNKSVNjMUZzb3FGMW1tWUl0ZU5L?=
 =?utf-8?B?WjJUbjc3UkFtd3FaTEpqQzVUSUlMVG0zZjJRVVUxWUlXMTcrdFhOYWVmT1VL?=
 =?utf-8?B?NFRYMkxoTVdYR1dXT3d3ZEZPSmJBbGlvUFJJTXhNSlJ5bUs4cmNkbkNrQ09C?=
 =?utf-8?B?dVJWUkFkcmVCU1g3cFJTZWtRbFoyVXdmMnNxMENZSERjZ3UyTjd2cW9ZYkJZ?=
 =?utf-8?B?clNlZnpMWVRqNVRkODl5NmdEam9tTTkzV09JVlB4Ry9CTU9weWRFRVZaajJR?=
 =?utf-8?B?QUNFODRkdldWN25ETkdIL25CQm1SNXc5VjRBSXFNU2tVVDlRaFhlN20zVUJQ?=
 =?utf-8?B?OWpoQlR5azBVdXJxVjlWeEtqYUcwNlo5ZE45NW9yUkhRUUtNSmVnQUxCdk9z?=
 =?utf-8?B?SzQ4MTNQTjNFTlNlc0pldDJ3Ym9SYVZ2SFA2Nms0M2czL2VKYXYwd1ZSelZw?=
 =?utf-8?B?akhmeVVibXl6U1grQU9Oc2c3aHVpM2xWOE1KNmY4dytHQVdiK3oxb3ZwOGxK?=
 =?utf-8?B?aVNlOUFFcmdGVzladmxya2FtRjJnQk9KVnZKZ2JiSVdIMXZoN0JwWWUwVFNO?=
 =?utf-8?B?Y0Z4aGhyK2FJcG4yUDhpL2w3RXJKRTlVa21NSnVHbC9mYVpwbXdGamtDVlRh?=
 =?utf-8?B?UXd2Z08wR3JzY1doR2xPY2ZaU3NmVFU4d3M0dXNmdTBubzF6VmEvL3c4VlhK?=
 =?utf-8?B?aVlUQVE3YWp4OGRITHEwOGJ0TTI5ZFR2NE85TEJtWDBmbTlLRXpOdFBHbE9T?=
 =?utf-8?B?MXUrQlVZMzlCVkw2WVg1YVNWK2J0bW0vcWRZSmVCeGE2bXpDQWNJV1hKMFBw?=
 =?utf-8?B?dEdVbGlpTEhFbDBrQVhQc2t0YTI0b2tiajg5RldNWUo4aWZleGZ0enFPQkZv?=
 =?utf-8?B?NjVUK0tZT3MrM2FxQThrZXV2UUt6aytSRjJaODBlZ3c5bFBHazdBMnB5Nm9z?=
 =?utf-8?B?U3RCcW5uMS9DUmo0MW0wUWRFWXkrbzl3U0Q2R0ZhcW9rSks5N0wwU1htUkdx?=
 =?utf-8?B?dEtNZkIxcDllbGROb2VDU01DakF4Ni9uZWRvaHFJWjdZS3BMQ09WQTVKK202?=
 =?utf-8?B?NVlFUXZzUHc0aXF2Z1hsSktRaFNPSm5nUFpaZDVxeEprcHJvRmZyOHo5MnFQ?=
 =?utf-8?B?MFQrSFZTLytQSUt0a0FHeFdhUTVFTmx4ZG9PYmx5M3JWcEU4cFRHY0xPRmVp?=
 =?utf-8?B?ZytkYlF2YWdIamEzb3NsZUY5b2ZmS0JLZGd5MWJxaXdMRHZkM3FVd0tOYksx?=
 =?utf-8?B?MDVMaGJkZ01US29Oc1ZoY3YzSk9KVktibVppSERhSUVjdStTdGtjOEVranhj?=
 =?utf-8?B?bjd2QXBrc0MwTk9PTUg3a2VBWXhMbnNkeE1DZ29ZejhJN0lnSHl4RzZmbVBL?=
 =?utf-8?B?RXdKeUtTWkdEM1oxc2F3MFBLcWpGd1hvWEdaU0lrdkhvTWZubm5TSThTemRr?=
 =?utf-8?B?NjcvVmFldmVXcjhMcVZtbHZWelJpdXhnMzFnaDB1Q2tKbWV1WlJTMHlZQ1dW?=
 =?utf-8?B?RnluUHpVYzQ2bEtpeGhFMWs3c1FwZmg5Z1VISWIxcHV0Z3huUmhrQ1VwbDFs?=
 =?utf-8?B?NjVHNjNxekUwV0VwejZrUStnbnc4WjNKTnUzOUVsMk04bmlYOE1YbHpkbHNm?=
 =?utf-8?B?UUtJcUdxbEliQkg4ZlhBQ1RwU0tJUTIwTEZxQngxZ0FKdVVmT0hrQWE1a2Uy?=
 =?utf-8?B?NnR4aWpsc3FhUEt5OTA3SVJ2QzhaTW9WUGRvV2lnRnowcExJNjFoaEJQeWZY?=
 =?utf-8?B?alJZWU5lRmpCS3Rmc2pFNHlLai9QZ29HcGVud0FNQzYzbjNER3VMM2JxK2tM?=
 =?utf-8?B?clVLNnRjV3FLcmwvWlhhT1d0MmRUTldEWXBCUkhTd1ZOQTdvUmRIeWIwTUxp?=
 =?utf-8?Q?JTQwoy5FQK/ag2ilYS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6520e4-2d03-4012-30a0-08de88c2b922
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:58:24.6926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWr/ITUdS+FAeOu94l2uNRo/NvSQGEoyOM5rg618Obrms4ruyfS+1dQRp23RBE2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
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

On 3/23/26 09:59, Srinivasan Shanmugam wrote:
> In kfd_ioctl_create_process(), the pointer 'p' is used before checking
> if it is NULL.
> 
> The code accesses p->context_id before validating 'p'. This can lead
> to a possible NULL pointer dereference.
> 
> Move the NULL check before using 'p' so that the pointer is validated
> before access.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:3177 kfd_ioctl_create_process() warn: variable dereferenced before check 'p' (see line 3174)
> 
> Fixes: cc6b66d661fd ("amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS")
> Cc: Zhu Lingshan <lingshan.zhu@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 732ad1224a61..1db565442c48 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3170,11 +3170,11 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
>  	struct kfd_process *process;
>  	int ret;
>  
> -	/* Each FD owns only one kfd_process */
> -	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
> +	if (!filep->private_data || !p)
>  		return -EINVAL;
>  
> -	if (!filep->private_data || !p)
> +	/* Each FD owns only one kfd_process */
> +	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
>  		return -EINVAL;
>  
>  	mutex_lock(&kfd_processes_mutex);

