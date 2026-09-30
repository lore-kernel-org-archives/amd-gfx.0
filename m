Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CD3CA5FBA
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 10:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C2310E6E5;
	Wed, 30 Sep 2026 10:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MHWxmLUC";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE2F10E6E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 10:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPwJjyagYJo/wSxaxlzJQDN/AXtL10D8vtAQuONyibdcBx18EpSF7O3WV9fOiLR/RxAvq4q2qWicrmrJ/1PtUV2sHF9cv1i99Gfk2wLZPt0tjuE2VlUo9gbpkgvSASorLqb0/efB+Y6kxtOW7ngsMJbzbDC6c5gDDz5rEXK5SRzfx7TsQCu7ybY/bHSK+KkCYd5eiWd+li7/4m9h5l4tuFnoHrpMMTMqFw51MhYDi/F5g/DDTz/PRZ/okzY6yP25YsDvcN54xmEt7pVMdMlq9/yqfNqqsUSxrdcZoLJi0WdmadoR7zxPjYhPt4Wf7xaCf/Jr5dlVNeOp/ie8fxqz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6qbBIjhaD3MsekRXIg6kkxFdsG+CZhWT3vJrxzQfgI=;
 b=J/p96ar5uyxQZE8yF/Y/LRbNS0NstRn/9RAVSaV26bjvlJNRWh/WLWYauabKp3TC5cy1zTLtJvAX58NqBAe6vRLIkyCliae43dq6hGogYA/LOfWg5qZcslzmIv9ClYxc3RFF/hXwcWPLnhdYFOUMOXk6LNW1ZiLWmn4USFyXk0/BnWAhscgRTvNeHnKnNG0/OQi8Q9KlFsVzhqHbkJp023zyWErZmBPN1JXkAxBV2uy58DfOTNaPLubgk4Ypjy0T+bzuX2s/L5LYsOnPlinmPR8tDZ7Ql8Z9luGfW98Qw1q1U7ah7pFONqRhym/M55OxCT8VNny24pzXrTB2SQ2gPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6qbBIjhaD3MsekRXIg6kkxFdsG+CZhWT3vJrxzQfgI=;
 b=MHWxmLUC9syMQlEBlujf/YzenE/Jty5NN0/nEzOal/ToXIMz32zIeBIZfcrr0+MBGUW8Yqz++CVuRiPzFOcGsgLpEw3I9LoySJ2ztCO+etU+2/ieZMaM/OhIUUNK9Wkbu1BcpYOhgNsgi6IsREqXKr5L8JcfCH5ACpr9dvk1up8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 10:25:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 10:25:27 +0000
Message-ID: <a72f7474-6906-412a-a38f-9ecbd80c8a21@amd.com>
Date: Wed, 30 Sep 2026 12:25:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/amdgpu/userq: return the memdup_user() error
 for the user MQD
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, sukhatri@amd.com
References: <20260930093912.177219-1-Jesse.Zhang@amd.com>
 <20260930093912.177219-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930093912.177219-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: 91111b9f-a884-4cb4-a35d-08df1edd2540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|4143699003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1vWAnSdu7qw3hoKHCXjvE5LNltWmONLWOxXT+9quULpkgtuTKVLum2tyM7E7iWfAgqHfRkVF7r2R6RiKPrswwD2nS/fb4fYcoblHhURLgl0Z0fddapYA18pqq7v/2RPvp5dROwor70WAwMLRGlAYBQdrUq1zELYvSCz/h3xZ9cf7JdfkxN2cAUNbsj3Xdeq1o5GP7eIC385CUUHpMUrdmD+PsxokQAo4x6iEUyMsdHgUAMJImKe+HxqXHYEIkt1Wbww4sM+A2WKb04xXQyUC3Q5IRZUp2gAg/vWP1qmwMH0+32h0R4l/cZjhcuveIDwExQvQ5kjOafxpLOnPI+vzQ83u5Xphqj/X7ACpG2TwiNVYYDWb8Y/sW5rVQekPZwXK9U1k7wDeixpeeIbr+F0SzgltI2AI0cSe/oupRHvvpluCk1STIbDg2ylXWF8Mumgr00YdvBhKB73Uzr6/nw71YKpii+mp4PW0DpieGUyfRGCVLD8c0S2Avwo11/hwMWVKz+EBg9jSVW/pyPcBLJ/T78eBegHetIGQOS3G6QcDr+SB9ZUW8liu02rZTdS514ZTG++73r5BQ9ZlDS698vFH5fsxJhLwzReRNvYv8chKaIwgtwfqbEKo03U3p2eY3o37t/H9fUaDkGhLCs3avAgt/qnWCbHxCm9/qAMzo2GL3hg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk1Gc2hpbEg2WFdUaU9OQlhWbjU3RjlPTWxJcWZvN3lBRGN0Ylg4QlpFZ2Js?=
 =?utf-8?B?MVRKN1Zsb3dWdU8xZlE2SDAvU05jK3NmN1poekVDTE1QQS9IaTA1dFR5ZDBE?=
 =?utf-8?B?dDZrZUJPZVQrQjQvSW1pbEo5eml4em1ZSGcwVis5cUtzNWZKVTRTbW4zYUQ1?=
 =?utf-8?B?bUZqQTNWY0Vrc1BvVDgzQUxFRW1GRzlRZHJVb0hjMGZhZ2ZEd0RhcGxUc0Qz?=
 =?utf-8?B?REVqZzdBVElYKzA3QTk1R2xCc2hIQTJGdEJYUVZqbUlkMjlmV0tWeGFkbU5N?=
 =?utf-8?B?WWhsY3NaQVFxd3VNNm0zNHpvcmtSSzRhNHhURjlscGVCVW1sZ3Vkdllac2p1?=
 =?utf-8?B?QzUvV1hFMG5KMVFPNTVlZWFvQ0k5WWlrL0txbXJkNm9KbXFkN0tZRHRXM09W?=
 =?utf-8?B?UjZyRjQwMTVIOUNyZkk5aVdoQmpTbUR4Y1ZVZlBWUmZOeEVqeVJwTTZXQ0xR?=
 =?utf-8?B?d09hSVJva1lIV2RQQ3lZcFlFcGZVTnVHV0c0WXQwcWJsNXZTc0F5OVE3eWpG?=
 =?utf-8?B?WDhjbTJCbmt5dzhrWTY1QUZkRTM0a3JXSWtqRUVtMVM3U2xCQXB3TW1vU3N5?=
 =?utf-8?B?eFFpQVB4alhUWmdYbEJJMVN5U2drL0Ntd3kyeG9ZZ2xOK20yMVBBS21mYUV2?=
 =?utf-8?B?Yk82K2ZVckdsTmpseWJwNDBRelBFWloxMVdyZUVuTWkxRlNCVFpxMHNqM0hp?=
 =?utf-8?B?cE1lUnNWanY0T1RZcnBvRVV2a3ZzbTV6MTZLZUNja2I5cG9pckxVTkRPaEdp?=
 =?utf-8?B?Vk55ekhKQnpHNmc0OE9hUk9lV0g2eTVVU2xmYlcrMXlpcEkyZTdMR0tWdXpu?=
 =?utf-8?B?ZWJ1SDd2M0MzSGxMbkRQTDB0MFRXUUtzWFhTN2dGV2ZKN0VCMGxpSklLeDJi?=
 =?utf-8?B?T2drS09ONzcvejAvVlpTZXkwd0g5MGdOK0ladGt6LytPTmlPdml2UDFEWUNB?=
 =?utf-8?B?Y2ZERnlpdGN6N2dsaDZkb2krMGp0ZmJ4R21CWUtDbitWREU1Q0pBNWpRVUI3?=
 =?utf-8?B?SXdLNmVWNk5UVlBEMFpOOVFvZjFicmZieGVaT0JaY1UxMEk2Q2RxdEIzc1VG?=
 =?utf-8?B?cGhhYW9TNWpnaGtybjZzaGdxeHZLM1JBL3Iva2dEdlhoTlNkZU9xL3FvTFBa?=
 =?utf-8?B?NCs5ZWpOWElTTlhCbHhHN3hiSjVnTStNOHJyeHZqZ1BvS3N1bE9rZmprOTlG?=
 =?utf-8?B?eHFkV09NY243VkRmd2lCWmJJWjNYUm9vTVRPVlBrb21GUWkvNGdrTTdYelFv?=
 =?utf-8?B?aEd2cjR4bUdFTGdWR2dCblYzb2RKblUrdXd6R3hxWjM0b1ZYU3lZR05WZmRj?=
 =?utf-8?B?c25ybHUzUlY2MFhIRHIyZkZPbFBlenFIaGFlWW9XbC8zWVRsNDg2cFF3b2tu?=
 =?utf-8?B?NmEyMi9KOXNmZmNvL2lZeTJKVDd0VU1MdnZsNHFrS1J5SzV4VkRhLzBRbW55?=
 =?utf-8?B?WU9NU1JqZDQzT016dkQwU24vY0xkS0RVM3YwKytqRHlBMGJLVnNzNjNic2hq?=
 =?utf-8?B?UzJqcXNCZmJoWW5jdDlRMUxFSUtCQjFTZzN1M1VVRU04NWw1eTZnZEh4WWUy?=
 =?utf-8?B?YzR2K21IdVUxVENDNHoySWpKVENRakJSeURWV29XSzdzVFhWcXhURnU5dGsr?=
 =?utf-8?B?Nm1MbjMvbk9MUkxFQmVzTUhwSzlMQ0hQVkJ0NzlwbzVtcGZlcG5sYmVubHMw?=
 =?utf-8?B?UHdZcVNKcDdLZEVoeGp6TkNnQVhpL1gwVE1nT0E0WUlzU1JYdlNCN3NVNnhY?=
 =?utf-8?B?cDdwbk1ZU0VpN2xFdTdSNkl1UUgvWWIybGVYQTBpZEFwU0s0WkVQdCs3SklS?=
 =?utf-8?B?SG1pa1VzbTFFYmczVzd6Rmx3VVJpZHFJOTNQWno1Y3Jsb0hkOVRGT3JFeXgv?=
 =?utf-8?B?bXQrcEorK254VUc0TVliNVBGMHRPdlNBdUswaDFMZW94VEhReFlqQk16U0lE?=
 =?utf-8?B?dm5GVUc4V3NTMTh0TkQ5U3gzbU5qWDg0WjhEVGVCRENqM0NPL3o4SXB4NmhI?=
 =?utf-8?B?WEI3Vk5pNVVJTXZYTFhEK2ozZllRQTVWUEtpZVJqQlpKdERUNTBtVThBVExG?=
 =?utf-8?B?UmNYQklMb1o1Z1dRb0ZWY0xUbk1rSUNwMDhXU2F1c2JDcmd6OEdGUXB1QW9H?=
 =?utf-8?B?MjRWaUMxSU10bEhBMTdTMkFjMDlHcVpISWh3eDlWY1NaNE9vWm1pUnNHa2FK?=
 =?utf-8?B?ZFJaRkZTdStoN2NWT0FmcU5tNHBnZFNNcCtkK2RLVnI4WHF5bUdoQTd6aDZi?=
 =?utf-8?B?MWZVWE1xU21IZE5PU3cvUnpkMVdQTks4NnBvZUZrdGx2N0VrdTcrd0g3djRo?=
 =?utf-8?Q?ZqfF/w1kAWj02iO8Hh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91111b9f-a884-4cb4-a35d-08df1edd2540
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:25:27.3475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvyEDIe7SpSUOSMXiD6u6tL1Uu/OdMbkmmNrxfkXFDA+xBZcOVb+uQTOUb2bcyk6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494
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

On 9/30/26 11:38, Jesse Zhang wrote:
> mes_userq_mqd_create() returns -ENOMEM when copying the user MQD fails,
> even though memdup_user() returns -EFAULT for a bad pointer or -EINTR
> when interrupted by a signal. Return PTR_ERR() instead.
> 
> While at it drop the error messages. Neither case is a driver error and
> userspace shouldn't be able to spam the log with invalid IOCTL
> parameters.
> 
> v2: drop the error messages (Christian)
> 
> Fixes: 2c695d7c0720 ("drm/amdgpu: enable compute/gfx usermode queue")
> Fixes: 543b61453774 ("drm/amdgpu: enable SDMA usermode queues")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index e6c167a39d44..1b76c10d1ac2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -407,8 +407,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
>  		if (IS_ERR(compute_mqd)) {
> -			DRM_ERROR("Failed to read user MQD\n");
> -			r = -ENOMEM;
> +			r = PTR_ERR(compute_mqd);
>  			goto free_mqd;
>  		}
>  
> @@ -452,8 +451,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
>  		if (IS_ERR(mqd_gfx_v11)) {
> -			DRM_ERROR("Failed to read user MQD\n");
> -			r = -ENOMEM;
> +			r = PTR_ERR(mqd_gfx_v11);
>  			goto free_mqd;
>  		}
>  
> @@ -497,8 +495,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
>  		if (IS_ERR(mqd_sdma_v11)) {
> -			DRM_ERROR("Failed to read sdma user MQD\n");
> -			r = -ENOMEM;
> +			r = PTR_ERR(mqd_sdma_v11);
>  			goto free_mqd;
>  		}
>  

