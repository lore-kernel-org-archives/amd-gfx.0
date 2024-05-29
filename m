Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C6BC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 06:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 683B610ED4D;
	Wed, 29 May 2024 06:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YrSpKliK";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10BE510EA4D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Debduk1WTWe12hKMHP1GnZmvM7Oky+Kl7f3yR3QyHccG3XdmqkqSwLemic7t/TTJTgjmqCR3mU7fs1s+zFWXteVlgHqW6vgWkpcFkCaXIid4nnxcI/yMP7/yXa/tk0HhlN5WDkWOouHnWLKEikbgLp9msW7wHMTiulvWE8hLump+6baVLsB29tsP3dDneYp1hC4LMnvEsYf+4qseQICqHBu0L4bvBQa4O+klXpXvBH7lVufYwUbSgDL5u9OKvxpRwvrPlqtKhlHxtDdETyHHDfrw4CNxAPVyoqrDzr1KwbTVu4Vjw7+g7pYWHZspjbqDljfQWqGhtD5o/KdJ7h46Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcujvmducukw/Ab/qzfu26iXBDRxvNnbtCdCvFsAB+k=;
 b=oEIwgLTWb5tGY5WoX2RiaI4YFk6nFcvBv9XOwDcBEOYt1iQ9gvc68f9fnBX+8NklU8wConnADNVYnm/05kHBUoR2sUoxKcXUnakbkE2JjBh/7mtiUerbQkp6ueBLu6U563Hzvps+QhEDL86LZl+eVir/sXMQme7Y5K2mWyYUw/6r3MWKRXx1KyVTcF/u8TjCBeRz5Q5jgoziR1wBlG4/VyB9lz1G5y0CLNVNJNCALdV8Oz3PDbUqb9RkA4kurmy92G3xj89FOJQULK56xGkXLSYWLhu0PCErIzrstqlxzOhLqGmxBBB1BOh5QXxUACDqTB4QZNCxzVz4BSfmbN34/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcujvmducukw/Ab/qzfu26iXBDRxvNnbtCdCvFsAB+k=;
 b=YrSpKliKEV98EuGatE8i8bV+Pgtb2k2ewcAkDQ8ocWbWRyxMgzRJJPZx+FuGTKuQPYL7NaBjxOVlWT67WswMPpLrb0+FcAJs1qC2Bion7BLyPwoa5ANg+HICph6vsAKi+ig11VvpYNMlQSGLTVErMnjSDbOXjCyELXTyA/1yHtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 06:38:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 06:38:45 +0000
Message-ID: <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
Date: Wed, 29 May 2024 08:38:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240528172340.34517-4-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: e78225ee-0092-4a05-3e16-08dc7fa9fd4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVNmL282VDBnTm1SRVRrWHlaVkR4RTZJUzd2eTlWSGhzOWRsdmthdm8rWnQ0?=
 =?utf-8?B?TWJudUxqckhoUW5UNmRROTAra2tZQ3lTZUltMENLRmR5RU5xeE5lNkUrbEpq?=
 =?utf-8?B?SmFXYmZleG5wRFRVeTRNYnJncjhseUV3aWNhWW5VUkZ1SU13MGlybHVrWm5I?=
 =?utf-8?B?Qyt2c1dBeUxuWk9USXFTVFp6TC8zYVFUYk9CbHBaa0tVenJ2UEZFTVpVWVli?=
 =?utf-8?B?ZkhrUVRtRFlNTkl1ZEdaMFZVR2RlRXBaV3pJd2VsV215Z0ZTYk5XN3VLTUVw?=
 =?utf-8?B?N2JkYjNJRS9zQmV3d3J1MmVjRW5Ub3o5UjRxcmp4UlZSenJzZkZPNCtkQkZJ?=
 =?utf-8?B?V0gzMWxyZXJmRVVMSHZvc1hSdXFabEliYzJ2VlJUZTBqS0VZWHdoa3JTSnBF?=
 =?utf-8?B?dWVUZGNOeVh4b3Q0RlRJYlZqdDFLdDhUODZhbG5TN2l4Z0VJWkZ6VWtpWERG?=
 =?utf-8?B?TkJzWENvVXg5SlFCOHVTQ2t4MnNOYlB2bTRWZlVLTVExZ0h5czk3Y0hsZnFI?=
 =?utf-8?B?VnA5aUlwdGo5UzBJWTM5RTVSUUhXenhhRk51UXgzWGsyK2RZM2NGZ2xUWDhQ?=
 =?utf-8?B?Qy8yMVJ4Q1hXTmJLS0FnRDgzdzAwUHZnSWZ2emR5TWo2eVFQL043UFQ0VlI4?=
 =?utf-8?B?RmJpdkdBUVZ3U2s5ZXlNK3l4Z2tKTWM3Sys0NCtuYnBWRjBKcnQvZXB5REVR?=
 =?utf-8?B?MVFrWWFXU05sRWk5ajhmSzRiRVhHOFdySUZseFB5N1g4djk0WUIvNVFEUEZ0?=
 =?utf-8?B?amJ6R0ZBbnlqaUpQb2FScGI3K0Nia3ZSbEl6dzZWdmk0bzBlU2ZjTmRJblV1?=
 =?utf-8?B?WUhIUXMzakN3bmRablErcnJHOS9zaDI3NjRVRmpoMFBrRytQU3dRRWVXRFRa?=
 =?utf-8?B?cm1zYzhrRldCTE5GcW1GWTdTK2N6RmQ5YkR1d2FZUmxka1oyaTNhUVpXc1F0?=
 =?utf-8?B?M1J6Qm5HZ2k0aEIvekxxcldjSlBmT3JGUHZWSzRib1J3OXpRcmRuNStoSXBD?=
 =?utf-8?B?QkVXc1ZBalM0Vk9CWmRCaFdmY1E3Q09QT0hZODJrTk5tb1AxWkd6NjNYTTgx?=
 =?utf-8?B?dFUwOVpocHBEM25DZjVzelhFRnVkRytlQmtFSVBJT3dMQ2pCYWo0MmhhZU85?=
 =?utf-8?B?OFl4L0tKdCtZaXJhTHZRbDlnZk52REMvUTFBYXdVVDZhSVBEU3VlRStxbHJu?=
 =?utf-8?B?MVorTzJwZDV6dnVZYm1US3lyTW40THpjUnR2R1NlR3JkL1JGRUZocnlFZW5j?=
 =?utf-8?B?bjFXWnllQmMwWnJQdkhmRkhKMXdLY0N4VlBRYkUxR29YWEtyTkJZcU01OXp2?=
 =?utf-8?B?YkJNVzVVNWVaQW1UeWF5dDRaZUJ3ZEVtSml0UC9uWlpEbVY1QkNOWXdTdEdm?=
 =?utf-8?B?ZHhrNWVQQkg0S2MwVzVjZEk3d1F4eE93NFpyYmxObGszYTdBaHZHNHB3ZjZN?=
 =?utf-8?B?bVREai9PTEhVbnhHVWJkZWl1amR1RnkrbnRSbU9VWGJGNE1OM2ZKRjR1QTZ5?=
 =?utf-8?B?bjdZUnVXQi9Ib2orTDlUTERsclRKT1ozdnJQN3JZWUZBd0lDUGhMM253YmNi?=
 =?utf-8?B?Q2NOZGdMS0J3ZTJNVnByaElTZnM2MXgwNXFWWENUdUtKeWRiMGlmcGFJbHZI?=
 =?utf-8?B?ZVRjWnZUMjBLazhqTHozQi9Lc0lLSTZYdXZHbjdKOEZLWmxJOXpnZzVkZlpk?=
 =?utf-8?B?SUc3ajExeHRQYUpDMWM4cXdoQzlCRnVPbEw4dG4rUEtya2pCS0VFODlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJVazNYbDk3RzlmMUxZbHh1N2RpWFQ5dEVxcTJDczZaQ0NhTFJ1STdTM1NU?=
 =?utf-8?B?STVvekgvSmV5eWFlRGdSSmxVN0JETUFidW9VeE43bHNYOTRjTmp2ZnltRU9N?=
 =?utf-8?B?TXEvdVhzK3BUdmJoMXVvQjhuMmYxU01yTjJ5OVlTUUxzcDZEbGtlMU9kVko2?=
 =?utf-8?B?d2R0eEcyeDRlSkRnT0NGd3A0bm5DV01MaERndWxpUGtpUkJoQkdqZHYvN2pC?=
 =?utf-8?B?WExYWmdxempaTEo1SVJKWVVoMDFJbFF5MEJDeTdsMXYrQlR4VFlaUU8xVVU0?=
 =?utf-8?B?bGR2MTJJQTU1K1EvR3JPajJQM2dseWNMUmFqVlEyakRwTXQ4d2szYm1xTzBV?=
 =?utf-8?B?SFNFU0psRWYwaC9HUWs3VG5XYllXZGhLNWNTRDNZNnhoVkkwVDVRbXpSU1dO?=
 =?utf-8?B?QTdQS0Qwa0dpQ0ZpZTVMbnJLYU83bUJBMWRsSVlxZkVEdkMwMXNzd2tWcjBi?=
 =?utf-8?B?OGJIQU5WUW91dTFBTkhCSmt3NVVZbmxMTkZFNTZYbnN3L3VzWk9oM05leEFP?=
 =?utf-8?B?ZHZsN1BFQjJTTENYSnlNRFhlY0hvL1BqN1hKUStJUys4Znh5RXF0ZFFseHZP?=
 =?utf-8?B?aFIxbzhZTHJKalFuaU5nRCtMbEo1SHhuOFZkbnJHR2VlMFlZc2k3ZkErK2k1?=
 =?utf-8?B?TGR3OXZiN1lJVEwzeWNMdVdISmZoeVZybkpTR2NqaEU5UzQwZXlCVGdwcVA2?=
 =?utf-8?B?NndGQkh0eGNJYTV0QUlZZC9lbysydkxjejM2aWxIcXF2YTdYczlHVXd6Y2RO?=
 =?utf-8?B?KzduYVE1MEJHM25VdTFNd1hVUjJmdzZrdkJBZmladGxQUllyOTZmMEgvWU05?=
 =?utf-8?B?b3RvcmdnTjkrU29FLzRXaGhyM2tja0YxcllBNnFqU1pRWE53dkVhK254S0hm?=
 =?utf-8?B?RnlRWmswWnE2aElDSGNjQXpFeHRBTTJHb3IvRFIxRHJ2Qk1UYlFFK21WZm9o?=
 =?utf-8?B?MExEYlVId1lONG9EcHhBUWxYQU54OFlmL0NXeFd5VWNPc3NXbTBVM2VBK1U3?=
 =?utf-8?B?aXR2STg5Zjg4TkNQcVNLNGkxK3h4TlpjMzRKZm9yMEdsbVpMR3Vobk5iUUxY?=
 =?utf-8?B?MWZNUGpENTJLSUhlRllCS2JDTGJEbGhwQ1dMaFc0TW9SQW1EWTNmY0NFWTdh?=
 =?utf-8?B?N3BRa3BBeTU0WTY5VmxwTStrRm9ZK2E2WDQ0d2kzS2JjeDJPSXE0NnF3THZP?=
 =?utf-8?B?VS9yQUVOdStiSGZOTVcvMmxjZ2V1MjRvcnQyQXBSbmFmK0VCYWZoS0VpWi9L?=
 =?utf-8?B?NTA5aHdSd1l5ZFNGeGNEc20wbG5pRVBaNmlDak5IQ0w3ZnRMZjdoMGZvQXBO?=
 =?utf-8?B?VCszQmlJNXdqbXlIR0FlcVkyd0szUVEzRmViYTFhVVJxYzU5T3UyYW43ZXNN?=
 =?utf-8?B?eC9rOUU3aStVbUEyZHk1d1V3N2RxWUt2Y1pkOXB3akg0SHR5UXVzU3E0SXVr?=
 =?utf-8?B?ZnVVVmFtL3pSMzV4eDJoZGowdHQ1TnBrUkthZkorVms0YUJibkRFaFlTaTR4?=
 =?utf-8?B?MG9mSXoyMzJkV3NoemhzVXl5OHZRMEFLakNkdDhXUFllRWxwTEE0b2VhWnpB?=
 =?utf-8?B?ZWpqQ3JhOUMwTVR1ZDdDWnZ0d2VwWnFpNjV5QTExVFNralRFa2o3VGduNFd3?=
 =?utf-8?B?SXkybXBsUnZ0QXhFbnJQb0F3OWNYeWpuKzN6VnNvQmNPejVZbzRTdFNVN25Q?=
 =?utf-8?B?ZnIvcDhmSld6ZnFkWWtYRkpNQ3FNaHUzR3pSNml0Ylg5d2dZWFpQUHNRcjBR?=
 =?utf-8?B?U2NmU09NZjdnc0ZqakRlcWkvakVjMkYvaUVabUFrNFE1ZzdkWHR4QUxGdkR2?=
 =?utf-8?B?ZmNBRGRCdHIweWJ3SzJacTI1blg0Q3o1dW0vUi8zaGM0MzVkRjNkbDFFcWdK?=
 =?utf-8?B?VlovSUZTUHlPeEE1azU0R0xrZlQ5S1RKQjRrYzdPZFhYcVZRYWEvZ3FZOWV4?=
 =?utf-8?B?L1JLb1dwWDJnNTJGRkYyZWZEckRlY215L0RqUzNSbENBakhuaWRnYXVta0xu?=
 =?utf-8?B?bVBnVDQrQnlFZHdSeXZ1TStDdkpyeUYxcWNOeEpmTXB6ZVBBZ2d4RjNHZDhm?=
 =?utf-8?B?cWxqTTVjQzVpOVVEa1BwY2E2N0lhNlFDMXJ1c1UrTWlrazhwRlpTdE9oMTdN?=
 =?utf-8?Q?c1M6SkTEXiijM/zMh9Ai9rFLy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78225ee-0092-4a05-3e16-08dc7fa9fd4e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:38:45.7015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiZin0WRmAsatsaPbcuxEO1SVo2aZAWz+c5ELY9gzFSXYloOwUwlqzW39HsktW6W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785
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

Am 28.05.24 um 19:23 schrieb Yunxiang Li:
> If a reset is triggered, there's no point in waiting for the fence back
> anymore, it just makes the reset code wait for a long time for the
> reset_domain read lock to be dropped.
>
> This also makes our reply to host FLR fast enough so the host doesn't
> timeout.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c   | 7 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h   | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c    | 2 +-
>   5 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 10832b470448..3c04f034d43e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -376,10 +376,12 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
>   				      uint32_t wait_seq,
>   				      signed long timeout)
>   {
> -
> +	int in_reset = amdgpu_in_reset(ring->adev);
>   	while ((int32_t)(wait_seq - amdgpu_fence_read(ring)) > 0 && timeout > 0) {
>   		udelay(2);
>   		timeout -= 2;
> +		if (!in_reset && amdgpu_in_reset(ring->adev))

Clear NAK to that approach. This is just a pretty unstable hack.

It's perfectly possible that the reset has already started before we 
enter the function.

Regards,
Christian.

> +			return 0;
>   	}
>   	return timeout > 0 ? timeout : 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 8c6b0987919f..dd22fd93f572 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -32,14 +32,17 @@
>   #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
>   #define AMDGPU_ONE_DOORBELL_SIZE 8
>   
> -signed long amdgpu_mes_fence_wait_polling(u64 *fence,
> +signed long amdgpu_mes_fence_wait_polling(struct amdgpu_device *adev,
> +					  u64 *fence,
>   					  u64 wait_seq,
>   					  signed long timeout)
>   {
> -
> +	int in_reset = amdgpu_in_reset(adev);
>   	while ((s64)(wait_seq - *fence) > 0 && timeout > 0) {
>   		udelay(2);
>   		timeout -= 2;
> +		if (!in_reset && amdgpu_in_reset(adev))
> +			return 0;
>   	}
>   	return timeout > 0 ? timeout : 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index b99a2b3cffe3..064cb3995a3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -340,7 +340,8 @@ struct amdgpu_mes_funcs {
>   #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
>   #define amdgpu_mes_kiq_hw_fini(adev) (adev)->mes.kiq_hw_fini((adev))
>   
> -signed long amdgpu_mes_fence_wait_polling(u64 *fence,
> +signed long amdgpu_mes_fence_wait_polling(struct amdgpu_device *adev,
> +					  u64 *fence,
>   					  u64 wait_seq,
>   					  signed long timeout);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 96629d8130b8..38edd60c6789 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -212,7 +212,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	else
>   		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
>   
> -	r = amdgpu_mes_fence_wait_polling(fence_ptr, (u64)1, timeout);
> +	r = amdgpu_mes_fence_wait_polling(adev, fence_ptr, (u64)1, timeout);
>   	amdgpu_device_wb_free(adev, fence_offset);
>   	if (r < 1) {
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index c5a03b79f07e..73430b9c4b27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -202,7 +202,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	else
>   		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
>   
> -	r = amdgpu_mes_fence_wait_polling(fence_ptr, (u64)1, timeout);
> +	r = amdgpu_mes_fence_wait_polling(adev, fence_ptr, (u64)1, timeout);
>   	amdgpu_device_wb_free(adev, fence_offset);
>   
>   	if (r < 1) {

