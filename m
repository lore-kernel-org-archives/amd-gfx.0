Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FECBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D136105A
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4D136105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6286E929;
	Fri, 22 Oct 2021 09:46:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44576E928
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 09:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvjZwuS5+7Vyc/Ve/6wBtINAgQ5MqSy95TByG2p6jFSxYT5/Q4WFm5+xAtl8/aUxIp83uYFSyPpx9v6GyfNGsw5y6JpPy6sb6db1Whey6wr8ittA+6OICVq2MS/yele9pL1ZUesAfU/Borb7qxmwj/jTzZ2oibryI0rF9Jc2orqjk4RbaV2/Q8Omwpk+LQJ49S9BvcfjhoOQXpVhIEOJV5fbPtVFkJGUBe6IMOM/vgC8WMDKtOYgCywfC2iqqZC3rM3tWIJ1j0N8QkTn904z1JS3iIwJOJ6E+iAHa04kVXtLkfF7Z7i+KNfi4T4H6rU5ZAekmUGK5ywOqujSq714IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvlEUYcQ8VRucsw86/NO596QvYLwYoU7nh82qaFdm0E=;
 b=R7GcL3+ZfcArI7lZa/GcVd3AGiaJ5voCR2hEyNc/y7AI1VylyTOqlXbgapju7QdfQkXO+uIbn5RB0obQg4u3sKbyK7GU6PLyuDD43ssx3PbzKT6RxvT4qi/t1IvIyyEls/eFLR2V9csNuCdx2NSn8fr49x70jh7C6tORzrUZFG32/FTvwfIx1OHg2befr1gm+d+Upd6PukZM1nnq2BrPiEz9MfYpfBxD9Zk987g+zCu5bEh28odHB7tDYov2VlmiEe8bhk83pdNkjbsmsehjryb7J5sen7KXf93kS+OATNsAZIDl0jcW22AcmfkOCNnjV7W+v857uMOjHVhdc+N5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvlEUYcQ8VRucsw86/NO596QvYLwYoU7nh82qaFdm0E=;
 b=RkOCdkRSvNHHMb7pnqkwOCryr8o8i4qoH0Zqz6YySM5PN8nUne6bRsuDwsMiLQ5IB+gXhNWDS/+TVOf09ECqg8V9Z62AwmtLKGaW478GSlRqow555GDC3cmj3CzQam5mDkXgQb76lA2RzCiTFvNJkFy3mtSmtNdoKaRZN1Dho28=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0078.namprd12.prod.outlook.com
 (2603:10b6:301:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Fri, 22 Oct
 2021 09:46:17 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4628.018; Fri, 22 Oct
 2021 09:46:17 +0000
Subject: Re: [PATCH v2 2/3] drm/amdgpu: do not pass ttm_resource_manager to
 vram_mgr
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com, lijo.lazar@amd.com
References: <20211022093231.7787-1-nirmoy.das@amd.com>
 <20211022093231.7787-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7f0b1097-68d2-65ba-fa5c-568cbccd8790@amd.com>
Date: Fri, 22 Oct 2021 11:46:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211022093231.7787-2-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0150.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::16) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:a39f:d981:e7cb:e6dc]
 (2a02:908:1252:fb60:a39f:d981:e7cb:e6dc) by
 AS9PR06CA0150.eurprd06.prod.outlook.com (2603:10a6:20b:467::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Fri, 22 Oct 2021 09:46:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 073151ea-f33e-4405-bd86-08d99540cb35
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0078:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0078FCE44E642BDA34EE147183809@MWHPR1201MB0078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7XELa82ai0AF2eDFgy7N4Cmvho0nvCleqrAqWoQ0+eJMeFwuXytloaOYTl5BQMP+5vKMouAZTXmKiJ2DNPRp0UXj3q2fVIUqesTpyhzzp5HtFRjtIfr3bWtfRrcejHKB+XUKd3shz/lG7nRb3pgukfCY+g/reTyaYNQHbTxM2CI5pzZyiFsxRdmWi/KrNhTuEq2sYMY1kHHEe+kvAZjR2qKUbw8aQIaFW3KrGpEB0zpbSoZv3MXzG/llSOYWppAYEQAfnPw0A86R/RX9inDDcIDPD+xutMe4SIh//cUSDLT07z9L09PQzPfxZxz9diZ4dzSICfu/ICywDDEjnKg/A7A71vwcyGTjv+fchm8ehoeihv0nZB3lp0VfRQC3OszoPKQkn0Vw22yFY4YoIeaqDDq3qK2QlW7xj318q8KSJzt1CnPCPLkFAGzywU8hTy77GWuuwdc+H8+BiIQZDoznIR7QWbtwhRR4i1BZU9JXtwF+tE0ev712vy5BKJaGJuAwVpUUwNJYpVQDQoIoRnOPs2qyoV6yaoW/ak6i4kxnNHubeacAV/+KQ9G5tOuXAl56dtX1Ss2E11fa8cq486Kb+f67CAL4B0T8+0t2hkHZelf8a3gUrvlJe7c02vJze3YIZRh2nHZvrQN+Q9ms+tIq4RVXJkGci2AE8KH5/cubBYeZ4xtLiiu3a1qReBJuO5pjfNDXPVHiPJ2VsG1lIVVehaS3ojiZXqAk0SsrL6Pr9GKdFtAHFyvvxW5ifbYjeup
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(30864003)(508600001)(66476007)(4326008)(5660300002)(66574015)(316002)(6666004)(66556008)(86362001)(2906002)(2616005)(8676002)(36756003)(38100700002)(66946007)(186003)(6486002)(8936002)(31686004)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0hnUDZwYnlxZTlQNGdyYUFnTGhjelZzQnU1SmZiWTJkM09JTXNsei9rY2No?=
 =?utf-8?B?VnU3QTVWZUdHWHlNSzR4aW1CNW1BQVpVTVR2Z3dDdXdqRDhaMXBnTkZoYklq?=
 =?utf-8?B?clRWOEtVOUQyeTVRcm5zUmFvRGhpclk0TDR1eTcveW1EaStyNklkNUc0QlVN?=
 =?utf-8?B?R3pURmpYOXJCbzNGaHZnTGtCOHpRQmNBMzNnaGdVNWdteXVJY0NObUJKNXJI?=
 =?utf-8?B?WVgzWUQrbnBhVDhVdG1TejRIZGkrdDY5TnBYR0NTanJvLzNTMUJHMjExUG9W?=
 =?utf-8?B?dFM5ZWxaQ0Vta25ldHdSZnlFdTN5VWxXZUFMakVCcnMwZnNsMVI5bzQyUjEy?=
 =?utf-8?B?TnJRR3pPMEttdUVielhJajh2NXYyUWpYL2k5Q3dRZTRXenBkUi9YcnlibG9j?=
 =?utf-8?B?TnpXZ2RPaGl4TDJINi9ieGF2NUcySnkrOUgrOHJnbDEreHpMaHlkck9TTHZx?=
 =?utf-8?B?OG9oQlJ1SEV0d3cyd0diVFJ6cE4rTFg4ZE1MOFQ3RjZ4Uml5MTRLbmZjVm1T?=
 =?utf-8?B?bEpIMzVyK1A4cnJHRWhDMk1JTjZaYk85Zk1rUEhTZWYrenRjNlRtZ0pmalVr?=
 =?utf-8?B?SGR6M085Q0xadDRkRy9DbVFmQlp5Uk10QnNHYlgwZ3Fac1RULzlzOGl5amRu?=
 =?utf-8?B?aXNucFZLZmtaOUJ4bHVYanZDS3FEblFFSENObVk2UzJzNzFOd3Z0WDZ6RW55?=
 =?utf-8?B?ZG9QYWVXSWx5V3J1dmw0S0d1UUUreXVIYnVWeXp4bEkvUVZjRDVJTUZ4R1hs?=
 =?utf-8?B?Q0NTTEtCaFpBVjNIeWNuUXRwbW11NnVIanpzVlJXMXNKUzFPUXIrSHlURmdG?=
 =?utf-8?B?Wnd0MTFqVDJzZm5vTndiU0VtbTFTMFdSMDZjOEpjRFF5ekNxbGpUSGNsMFc4?=
 =?utf-8?B?YW5oaUJud0VSWlN0cDhXRUN3ZXRSN1owdTZyOWRLLy9aeFQvWnBsVGt3L0Zn?=
 =?utf-8?B?TFJxbjZwRnExd05WQUsrUUZzSndrSHloM1N6KzZEVkIzUnhsNWRSNjVWUnBo?=
 =?utf-8?B?RVVFOUg2YWpjMGJGSXBhN014Z3Q2VTArZzVubjhadk9vS1NncXpWUWhZaGhO?=
 =?utf-8?B?NEw2b3QvR2pKczhYN0VWRVFEYnRNRnc5TGl3K3o0NENDcVBFL3BJSG9VWTFG?=
 =?utf-8?B?WVgrM0xRYnJUL0tENW41TEIwWUFCbjlJclBnZklFbkZlMmplYTAramRaUi9H?=
 =?utf-8?B?cEFuWTZ3cGV0ZWlxOFhEN3NFWVZpbTRUZDI0bldZdEpjS0FiR1F4Z1hreW5n?=
 =?utf-8?B?NTBLdWZYQXhFaFVPNytOZERaRmFtRzdnU2RBdzk2QUtLU0Rsb1h0Q2FUOGlC?=
 =?utf-8?B?Q2J0RVk0SW9yMmN6NWp5SGh0anRPUktZOHFVM2pMa0IrdFBQZE9XRUY4VFVm?=
 =?utf-8?B?YmN1bnRobWlaamgwZndlM0Z4VTZLcXlMb3VzazRUUjJXV0VnK2wwMGtaKzV6?=
 =?utf-8?B?UmtsTjhiN1JhejhRdEdvZVNPZ1drQUxkN2JYdFpLNDdJc1pGNmVUb1J2Z0hS?=
 =?utf-8?B?K0lQeVlWd0J2dEdVM2dzbHRVdlZGdTZrSFk5NW1NNDQ1K2ZPK2dxRTg2SGNE?=
 =?utf-8?B?bXVyS05MV1F1TEw4WjlkbDRTZ1gxZ053aFdreVc2YU0rdmNHRkh0bW1RcEJN?=
 =?utf-8?B?QTFSUyt6Z2FMZE0xY1pGUVJlQ2RqRzZYWm1pdDdsOE9NOExDL01vMU1ONnZ2?=
 =?utf-8?B?TDEvNWJDa0x2QmFmMmMySDV5MmtTczRER0V4MXVTZWd4Q1RMWnIrMU9tOXlK?=
 =?utf-8?B?dzE5dlc3U0ZLeUpmaFBCNE5EMUVxa2R1bXpndzJ5SjFVTkRWM3dLOEVub1Vn?=
 =?utf-8?B?ZGY0LzdiQXJyNDIwUHZDTm5IWk9tWEc1Qy91b3FqNzJIQ2ZEUW1DSUtmVVZE?=
 =?utf-8?Q?JOb0IghEakgyx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073151ea-f33e-4405-bd86-08d99540cb35
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 09:46:17.2076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0078
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

Am 22.10.21 um 11:32 schrieb Nirmoy Das:
> Do not allow exported amdgpu_vram_mgr_*() to accept
> any ttm_resource_manager pointer. Also there is no need
> to force other module to call a ttm function just to
> eventually call vram_mgr functions.
>
> v2: pass adev's vram_mgr instead of adev
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c       |  5 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 10 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      |  6 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  8 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c     |  5 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 40 ++++++++------------
>   7 files changed, 31 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 7077f21f0021..df818e145d9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -531,9 +531,8 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
>   uint64_t amdgpu_amdkfd_get_vram_usage(struct kgd_dev *kgd)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>
> -	return amdgpu_vram_mgr_usage(vram_man);
> +	return amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
>   }
>
>   uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 76fe5b71e35d..7e745164a624 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -298,7 +298,6 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
>   {
>   	s64 time_us, increment_us;
>   	u64 free_vram, total_vram, used_vram;
> -	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>   	/* Allow a maximum of 200 accumulated ms. This is basically per-IB
>   	 * throttling.
>   	 *
> @@ -315,7 +314,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
>   	}
>
>   	total_vram = adev->gmc.real_vram_size - atomic64_read(&adev->vram_pin_size);
> -	used_vram = amdgpu_vram_mgr_usage(vram_man);
> +	used_vram = amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
>   	free_vram = used_vram >= total_vram ? 0 : total_vram - used_vram;
>
>   	spin_lock(&adev->mm_stats.lock);
> @@ -362,7 +361,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
>   	if (!amdgpu_gmc_vram_full_visible(&adev->gmc)) {
>   		u64 total_vis_vram = adev->gmc.visible_vram_size;
>   		u64 used_vis_vram =
> -		  amdgpu_vram_mgr_vis_usage(vram_man);
> +		  amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
>
>   		if (used_vis_vram < total_vis_vram) {
>   			u64 free_vis_vram = total_vis_vram - used_vis_vram;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 603ce32db5c5..b426e03ad630 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -672,10 +672,10 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		ui64 = atomic64_read(&adev->num_vram_cpu_page_faults);
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_VRAM_USAGE:
> -		ui64 = amdgpu_vram_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
> +		ui64 = amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_VIS_VRAM_USAGE:
> -		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
> +		ui64 = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GTT_USAGE:
>   		ui64 = amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
> @@ -709,8 +709,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	}
>   	case AMDGPU_INFO_MEMORY: {
>   		struct drm_amdgpu_memory_info mem;
> -		struct ttm_resource_manager *vram_man =
> -			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>   		struct ttm_resource_manager *gtt_man =
>   			ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>   		memset(&mem, 0, sizeof(mem));
> @@ -719,7 +717,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   			atomic64_read(&adev->vram_pin_size) -
>   			AMDGPU_VM_RESERVED_VRAM;
>   		mem.vram.heap_usage =
> -			amdgpu_vram_mgr_usage(vram_man);
> +			amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
>   		mem.vram.max_allocation = mem.vram.usable_heap_size * 3 / 4;
>
>   		mem.cpu_accessible_vram.total_heap_size =
> @@ -729,7 +727,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   			    atomic64_read(&adev->visible_pin_size),
>   			    mem.vram.usable_heap_size);
>   		mem.cpu_accessible_vram.heap_usage =
> -			amdgpu_vram_mgr_vis_usage(vram_man);
> +			amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
>   		mem.cpu_accessible_vram.max_allocation =
>   			mem.cpu_accessible_vram.usable_heap_size * 3 / 4;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 08133de21fdd..4114e0d35e82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1804,8 +1804,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
>   			.size = AMDGPU_GPU_PAGE_SIZE,
>   			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
>   		};
> -		status = amdgpu_vram_mgr_query_page_status(
> -				ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
> +		status = amdgpu_vram_mgr_query_page_status(&adev->mman.vram_mgr,
>   				data->bps[i].retired_page);
>   		if (status == -EBUSY)
>   			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
> @@ -1906,8 +1905,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>   			goto out;
>   		}
>
> -		amdgpu_vram_mgr_reserve_range(
> -			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
> +		amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
>   			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT,
>   			AMDGPU_GPU_PAGE_SIZE);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index af1c4e414979..ee8ab7846905 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -129,11 +129,11 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   void amdgpu_vram_mgr_free_sgt(struct device *dev,
>   			      enum dma_data_direction dir,
>   			      struct sg_table *sgt);
> -uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);
> -uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man);
> -int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
> +uint64_t amdgpu_vram_mgr_usage(struct amdgpu_vram_mgr *mgr);
> +uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr);
> +int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
>   				  uint64_t start, uint64_t size);
> -int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
> +int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
>   				      uint64_t start);
>
>   int amdgpu_ttm_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 99c149397aae..a3c7a19047e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -548,7 +548,6 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
>   static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
>   {
>   	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
> -	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>
>   	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
>
> @@ -571,8 +570,8 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
>   	vf2pf_info->driver_cert = 0;
>   	vf2pf_info->os_info.all = 0;
>
> -	vf2pf_info->fb_usage = amdgpu_vram_mgr_usage(vram_man) >> 20;
> -	vf2pf_info->fb_vis_usage = amdgpu_vram_mgr_vis_usage(vram_man) >> 20;
> +	vf2pf_info->fb_usage = amdgpu_vram_mgr_usage(&adev->mman.vram_mgr) >> 20;
> +	vf2pf_info->fb_vis_usage = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
>   	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
>   	vf2pf_info->fb_vis_size = adev->gmc.visible_vram_size >> 20;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 7b2b0980ec41..7a2b487db57c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -96,10 +96,9 @@ static ssize_t amdgpu_mem_info_vram_used_show(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	struct ttm_resource_manager *man;
>
> -	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> -	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_usage(man));
> +	return sysfs_emit(buf, "%llu\n",
> +			  amdgpu_vram_mgr_usage(&adev->mman.vram_mgr));
>   }
>
>   /**
> @@ -116,10 +115,9 @@ static ssize_t amdgpu_mem_info_vis_vram_used_show(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	struct ttm_resource_manager *man;
>
> -	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> -	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_vis_usage(man));
> +	return sysfs_emit(buf, "%llu\n",
> +			  amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr));
>   }
>
>   /**
> @@ -263,16 +261,15 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
>   /**
>    * amdgpu_vram_mgr_reserve_range - Reserve a range from VRAM
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_vram_mgr pointer
>    * @start: start address of the range in VRAM
>    * @size: size of the range
>    *
> - * Reserve memory from start addess with the specified size in VRAM
> + * Reserve memory from start address with the specified size in VRAM
>    */
> -int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
> +int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
>   				  uint64_t start, uint64_t size)
>   {
> -	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>   	struct amdgpu_vram_reservation *rsv;
>
>   	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
> @@ -285,7 +282,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
>
>   	spin_lock(&mgr->lock);
>   	list_add_tail(&mgr->reservations_pending, &rsv->node);
> -	amdgpu_vram_mgr_do_reserve(man);
> +	amdgpu_vram_mgr_do_reserve(&mgr->manager);
>   	spin_unlock(&mgr->lock);
>
>   	return 0;
> @@ -294,7 +291,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
>   /**
>    * amdgpu_vram_mgr_query_page_status - query the reservation status
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_vram_mgr pointer
>    * @start: start address of a page in VRAM
>    *
>    * Returns:
> @@ -302,10 +299,9 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
>    *	0: the page has been reserved
>    *	-ENOENT: the input page is not a reservation
>    */
> -int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
> +int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
>   				      uint64_t start)
>   {
> -	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>   	struct amdgpu_vram_reservation *rsv;
>   	int ret;
>
> @@ -632,28 +628,24 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
>   /**
>    * amdgpu_vram_mgr_usage - how many bytes are used in this domain
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_vram_mgr pointer
>    *
>    * Returns how many bytes are used in this domain.
>    */
> -uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man)
> +uint64_t amdgpu_vram_mgr_usage(struct amdgpu_vram_mgr *mgr)
>   {
> -	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
> -
>   	return atomic64_read(&mgr->usage);
>   }
>
>   /**
>    * amdgpu_vram_mgr_vis_usage - how many bytes are used in the visible part
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_vram_mgr pointer
>    *
>    * Returns how many bytes are used in the visible part of VRAM
>    */
> -uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man)
> +uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr)
>   {
> -	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
> -
>   	return atomic64_read(&mgr->vis_usage);
>   }
>
> @@ -675,8 +667,8 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
>   	spin_unlock(&mgr->lock);
>
>   	drm_printf(printer, "man size:%llu pages, ram usage:%lluMB, vis usage:%lluMB\n",
> -		   man->size, amdgpu_vram_mgr_usage(man) >> 20,
> -		   amdgpu_vram_mgr_vis_usage(man) >> 20);
> +		   man->size, amdgpu_vram_mgr_usage(mgr) >> 20,
> +		   amdgpu_vram_mgr_vis_usage(mgr) >> 20);
>   }
>
>   static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
> --
> 2.32.0
>

