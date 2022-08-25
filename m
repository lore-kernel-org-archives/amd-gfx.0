Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64429C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 08:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D6910E0AB;
	Thu, 25 Aug 2022 08:13:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F40FA10E010
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 08:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi1rVfS0ZZ6fNVc20UILi13t3UsjErk4qKa32kYI/swPnuxTcITWwPVN7Y2He/0XN6EuYFimeSa8e7iEh4nOUSHzpZf7aOiPc0oYegkUkYv40K2en4BPh5kTrRDCQ9hlMCfHQmYQM1XL4HSDh56mq1OiCOD71nRRTLF8aWvgJSMXKEGYN+JkaP5SCdWBePPtm3OOFWrnuLG2/KamkJlupTohtXeY2BceCDbjMjuP58UUK8SKi10qdN8LOCKJWZ29NT81hBvMduOYwC90MfzXqwBsmwli9oajiZlmv049OBpBy52CNQNssfftFF1oKMJEnVmbUv4KScN3SdUE5wNv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWvzdX+pK6oZMBj/SmqEDGmotZxg4Qak0kTRwN0CsKE=;
 b=M8b0eraygA5PYSFRm8UAA3aa529oKo9nuOblAhZBMRad9FhUQinSx5OAh9yqFSi8fS72V90BljdQQsRqNeBiwkPG87M3atWqGsKyOHBHvknSMp3r3S5o7t2hihuCf5HTXDOgObY+1QQM7Q56wixBBaNaXWm7IMIPjiLelCRlZk75ij74KZ2djlRsCaSnynB9HwD00Xf9g1Hm/ZvhlKOiT9Lxmzd+tbfs3iCAJVAM3oQn9nlllKYf1s/TqAE0V5Bmn8idCdY1EPoKN/oDuECFDQJCUe9Uci6EXqY2GemGpLRQIuk++I01omCqHkQzOoHa25QB2W45oAySj2KN0sPXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWvzdX+pK6oZMBj/SmqEDGmotZxg4Qak0kTRwN0CsKE=;
 b=GWiAnvkYDRdFqIfE986TgzBGViljKgag8nT94PGXm7kEsxAihUp40egqpl0xDUGhWQTmAVFEyVHtjWGbtLBdkEop4zaPC2enjh0musQfmjHvPZLs+aA/wQ8yk5xhPjK203rxcUXU4/koKj0nHZ6Ovz5AyBmjspn2UXND8Dhx+gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:13:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:13:37 +0000
Message-ID: <a4e34c7f-ebf0-89b9-2992-99520a9f6687@amd.com>
Date: Thu, 25 Aug 2022 10:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm device
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com
References: <20220825074810.361902-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220825074810.361902-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd973f6-f083-4405-510a-08da8671b60a
X-MS-TrafficTypeDiagnostic: PH7PR12MB6720:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VWo7Ej47YHMheWWbW+qRBVPynaSErv3rAaexDZlCU6RAcDtxOB/q9C/ZZ5e7r7kPSJYFutmvx7O/EAWFStcoh8d5Wb9uq5dfcpOzEOGZh4kB/squWZi1yGnrMgdhn8Cw74mUh/qU1ATeNDK3uTNhs/LbGvoYr4V1mHj/RoMGayR2yJn8rhhUBqBgY7pTxnF78hZPOlhQTDA8t13hWb7HVpG7bLeUzcAOWSTFd6IY/0CpgvnocUHKCZssCtAlhQowrTVUszKCARbTITO7AOshi8X6UBN5HSK0K4JR/kECG+9w9B75dB190FQRFsaZSTblquu+kkta/EerM0Q99oqBRzkNmqHDwAL5LiVeL1KooIAF0IssG/zZKIjafq2CX7y5lBSFjr750wu5kHlPehCw7giG7CN2DN4xj1yWbVh6hSxq6ZHMdptOdLh29XTQP52NDU7HL+N/KdJsbjG/tUxbM3EnFanCAPfNb8s/dqxChjG8I0DsTE4VTCJaj+xILJhrvqti5FrAAvgIABcQLG1LST93t+oNkpcg31Mj4GVrJXiR2H7dRWhL9hZWoua8p6u+eSZw/GL7JemL7cY7l4VgrM0+HHaNBzZcKIK3y6nLgGk0pkknLEE7VU3akPZB+JzYbRVoRvgTd8vIk1HmA3YCc4KXcAuQEDQeCy5QMO1j+FP6QQqFOZ3EgnukURbkN00+AxkTYZUM0LWtVdfIjnlvVoJ3WQJhh7cEtoaFHjP0xcJk2jo2T7T/ZtK4pA1JI1XTTq9nOCWmx7wj2tS0XoeO7kLbXxh1pJR/Y6KGK6qT5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(83380400001)(6512007)(66574015)(26005)(2616005)(2906002)(186003)(6506007)(86362001)(31696002)(41300700001)(66476007)(6486002)(66556008)(38100700002)(66946007)(36756003)(8676002)(4744005)(31686004)(6636002)(5660300002)(316002)(8936002)(478600001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlpoNk5NRXdSQVRWaTd1eDlXOFR6RHd3dDg4UDZPQTY3aGxmT3VlbHBWMTlV?=
 =?utf-8?B?ZUdpbEJvL2hKamtlZ0R6dTN6L3F1UVdIYjEwcTQyd2dyRDhVcVZnV3puVXFy?=
 =?utf-8?B?UkxUM3NLZjd1dzRMUG1iWVkzSnc5MGl1bGVZU2V6QXBYWlVZK1N0VnYva3pU?=
 =?utf-8?B?T3BHcVJVWE5IeUxmVUxZek5lVGZMZnRlMm0xQ2pRRkEzSHpBRHVJckVTakVi?=
 =?utf-8?B?RnZyakYxUVBWNWlwRzNPcmFQSk8zWEdtV0ZYcEZnY09MMlo4RXVSeU5DTW5U?=
 =?utf-8?B?enlrbXlraVpqQjJBektEN0t3U3JCRzFaeGl2VjMzeXZUWlRxWngranErbExl?=
 =?utf-8?B?TGRIVWxsQVowRHY3bjF2NUYySUdvZHFCVTg2c1ZQNFRFZ09XeXV2SHhkaHZu?=
 =?utf-8?B?UURHYmxJUVJTWDAvUFZlaGltaWhEbnFnQzBtQ2swZlBmc3RndS9zZEF0QW13?=
 =?utf-8?B?Mng1Sk1sTUIweURDVm91Y3FTUk5NMDVrbG1yNFE4cVozZ1BUYjI3NUtLVGxx?=
 =?utf-8?B?cjNXOFcvajVST0ZXeXhvcjhDMzRxYlVqdTVDQVI2QnRpK3ZVREVqUkh1eDM1?=
 =?utf-8?B?cElYemZMZGpzRC9GTUFnc0hJU1JpamQ2M3RzV3NDRlV5bHZLYlV6M2lORHow?=
 =?utf-8?B?MjY0dTlDK0dVUHExU1QwdkNwdjZqYkRYWGdKc0pLWXI1Vzh0bzdsNzFLMWNE?=
 =?utf-8?B?cHJUVFY5SVJjS0VwM1cyWVNuU1ZaY2xCTTIvWlVkNnhwNEpudyttVmhDWjgv?=
 =?utf-8?B?bjhUZmlxZUJrVVZYZit1ekdwbTZYdHlmSFVJZmQ3ZXkxZ1VaV3UzT2ZlTGhY?=
 =?utf-8?B?a1hzTXBXYmdnOGVkZXhYYVFkbDJ4cHBuVUlxZlZGWk9CSFJuRUtGcFZMdTJp?=
 =?utf-8?B?ellCTXhOY2xHNzdZOGZ2MWpzOVdYQy9yUEcxZENZb0tWeHhIV2hSYkRmdjl4?=
 =?utf-8?B?U1JYdVFlQ1hOV3JTeXB3RlBrZ203cWFlZ3NLMEQwN0RVbngvN0traEpEMVZn?=
 =?utf-8?B?LzA1Y0xjZ1B2YkQzYjNwZ25ZTVFQVzBBWWlRbThXa3dCcW0xUzQyT0Z4WGIv?=
 =?utf-8?B?TElPOGF4cVFBRmVOWjhBS3hQRjR6cjBBZTJxZjZRdW4wZzNSVStVZ3hSUDd5?=
 =?utf-8?B?eDl2TDY2Z1hsTHNkL2Y4ajhoRlFheHFuT3I3V0luSzZ6R2NLNWZ4Y1BFelBG?=
 =?utf-8?B?T05DeENQSlE2K21TOHV6VEt5cTVkOXVIbEkzcmdaaFFQbzFGSkNuZUM1QjZu?=
 =?utf-8?B?L1B4NDhnazNzOUlCdUI1ZmlBNVNRbm5iditPWVpaYkdiMmJYcEk1RXM2WlFS?=
 =?utf-8?B?Snc0aE8yWlRxNUJxSGVBeDMvcFFQU2Z6R1NKNDB1MG40d2lIL0pTRkVoQWRh?=
 =?utf-8?B?dURJNmJUR1E1VmdvZEVnTm1tRHlkTE1tWjlsRkhSSE5ZTUhucytBcXF3Y25J?=
 =?utf-8?B?aCtNN2tuSWF2M2VjV3EwR3c1ejYyZmpxc0R6OVhxOWhBNlhkdVBvMlcrc24r?=
 =?utf-8?B?cHUvVjI1ZXNNS0dmV3JhNkZ2WFVXZEhMZkVrVmhLcC94OXJvNFNJcEw4VStu?=
 =?utf-8?B?SzE0RXcreXJPOGU2c1FJcy9TOEs0QkFTM2QvWlAxYjFuTEwwYlRwM1BBU2lN?=
 =?utf-8?B?Qk5leHFSUUp6UGVORlIxbzQ4cUl3UldaWndOWWtFaVVJekduRkQ5YkxHaUdS?=
 =?utf-8?B?WUhYaXRDVjNXc0xJdENVY09ENGhjWC9OU0QvUkE1c0dQb0NHZ1RHU2M1RkJu?=
 =?utf-8?B?UUwrVDNRM2RTNDYzVGpFZ3ZUYlZyYklQUWc3bXZpdGFsOXJ0TmhvQXhrYVZW?=
 =?utf-8?B?K2ZETWRFSXQvektZai9DWFlXVVI1STJNblFmSHFwZ2hOcTNPNHZTTVJoaHRs?=
 =?utf-8?B?YTFjWWFuMXh0a0wyUmRYeHllMnI0a0J3ajh1eUZOcjZmUGR6ZVkyT1JuVTJp?=
 =?utf-8?B?Y04xRUoyakkvOTBTd1JMSGJSbzh5NzJDUzVucVBRMVhDNE50dGg1V1FaN1VG?=
 =?utf-8?B?d0hGNVViaUtjUk5zeXpCaGdWbjh5YWE1aWpueHZWZXJ0eDRHZUtVQWpzRXVB?=
 =?utf-8?B?eTNhMUR6TTZRZjFlVzExcGYzMHc1ZkFJZ2NpTzdVemJlQ0t2YWowM2hXWGJ3?=
 =?utf-8?Q?f71qHIYrUx4gaqaswv4PN3tyZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd973f6-f083-4405-510a-08da8671b60a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:13:37.1777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S43juJcN7nh9MO8HudgV+qosJpqKaY0ihjKr9RxwBjimfYB+APxonP1uF6E6FU8n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
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

Am 25.08.22 um 09:48 schrieb Guchun Chen:
> adev_to_drm is used everywhere in amdgpu code, so modify
> it to keep consistency.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 8ee4e8491f39..6ea8980c8ad7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -402,7 +402,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
>   		}
>   	}
>   
> -	if (drm_dev_enter(&adev->ddev, &idx)) {
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
>   		drm_dev_exit(idx);
>   	}

