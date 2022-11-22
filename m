Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5108AC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7673410E4C7;
	Wed, 23 Nov 2022 01:44:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D1FF10E4C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qhkb/hm7h3bn+I42pl1fbEXwrnJW2P9iYeNgPT1IcWNUKNJvcesgmNs6+IZp5G17I3n4pJQS1bpnHY8zknPJi2JwmBKyHrYY5NNOFId8vYr1eUEWMvbVF221SieS7/toJo4adesH1iAqa2Q8ktW1q9ZTK7vtDdzm1AwRawKVgxTgyTMErEQuw+Ho7Xi1NhNNEjr1UK8rdtrvG5m/qbQ0dCHxiVttjtBnIofkp8o6jkrEkxuElMBSzxdvboVKgtwY8PbwaZOP/Mii3ki6ExYS1KF1HucGLRSx+NYTGtgUHvNjx/N1kBd4jgaxMQvepkXdts5evQrhpCcLg+GyOXWg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8sKJXa/xSTX329DlbXqo+InENiXtpbGC94HJH+j6CM=;
 b=drfuldODuLUF3aIHq23jHgv7MlAp4NSYaX+0U3haV430X2xTMSulE7mWFQd8CiHL0I3PB6dP9owjKQqGFVZ5J50GF1RxcpMTiHDTmiPV4dUxmcEKOp9GnA9LR7Z/Ann8MydZoiLpLjD09YVyGxPU2YLNJEPGkzh1GkqyO2wqdjj1I3iQ4p95x2vcauu4THLNh5Wkgwe4/1BiLoP1u6+Uoq2/M4tPB3ElLX95VcCHsBlTvcidp9FisTNaPFHm9VqvMoVz/o12sbnMDuKRJGHpNZkn/dcXFBxB8szOaCLqvGU6xQNcDUbi/fVeRUp+u8qVyfLvxPkMAxxZScfbjFxh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8sKJXa/xSTX329DlbXqo+InENiXtpbGC94HJH+j6CM=;
 b=XHn1PUP1SD+/aeIh530Ca6/OQr2noJDcNs5pnUV01q47sbvwCVbHxfBEAdgHiPDCCOcxkpCKDprf0bWQTr2n5xUpP3E2HcUgFsKdDB5vf9g6nVT2NtEIi6Jt9w1kCdK6MmP5tzZz9FyaH8ek2Eu+DZHNiyyhDyxTUDKu58lPujY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:44:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 01:44:45 +0000
Message-ID: <0e6d5813-7031-451d-be18-da08f6632530@amd.com>
Date: Tue, 22 Nov 2022 18:59:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 07/29] drm/amdgpu: add gfx9.4.1 hw debug mode enable and
 disable calls
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-7-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221031162359.445805-7-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 59166989-87d0-4da9-2f39-08daccf44c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GqgLAL3aD2qHvarfqgr7GXpVoHfS8h1WOxtYv6ayjvkTjg0A09IfeXBWd2ZYpLgo8grgQHuN/Bf0WVZndqOr3ZCw2EoQ6m3XeK/YsGWl7NtOV+0l9ctjsacTBcOvx1tmx5GYp9dRp43thYYaN2U7nJ7JICllNVXA1P2L/HuVAuEe812gd+ayzinDes7BG/oCy1gZkind/hbswDMC1Py87NRV0mW+zXE92l9kpdnYVOP5wqkcq+rJ7A/JscN9HM3o5/Z1rHu1Q33tlZIt3I2Ly8mHu5Lq8n0IUXWI02a3+W2HkDsZXnkghbxxmBUm6pyMaSP50kBn3H85FPDe664JYxyTIloO5PKrdJ4UYeWsT7dQ+iydtT0uiPgHNm0xXyQich08Tp3a3avR5Kr4gpNUmwNNAPRzaVDTvJu8hOwy19mzFTPkNk7jzxalD4MFiIQt1XNCybFZz7too6Xk6sREUrUKT76q8Sjp4InTwh2sCPzltf6zpnK4fKJzYpMTs1kJ3tzQVE6WCluui1iB8qUhbgBLJnZoou26u7zd/P4Zd44SM8Aun1rMgstvdqnUBtB6RjCLj8n34EtRvBJXD5CNxeRdQgUK+bLEFUbHNqTUXyTXK2OXCeqoe6OJJTnVUb4301iEPrwJmH3g/0s5PEYfB8vynHUjOSnZIpcyrYKwwBWgZ+tvgFxhhAb4Tu8EmImy+W41wInLtAQYa/+XwNtHGX/AXHzZYFSLaf5GriyWZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(66946007)(83380400001)(36756003)(26005)(6512007)(66476007)(41300700001)(316002)(6506007)(2616005)(53546011)(66556008)(8676002)(6666004)(6486002)(44832011)(38100700002)(2906002)(186003)(478600001)(4001150100001)(5660300002)(8936002)(31686004)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDZaWEJ3VG1GeFhEdFh3U1FrTmFDaXFmN3NMTzBhZ2F3eE9EcXlHTmFIMWFH?=
 =?utf-8?B?aDdzaW1hUGwycHpVYndqeVNIQVNxZnBEK3I1OTd6cEdnd2pFclNUVVU5ZVRa?=
 =?utf-8?B?aVR6V1c2VGZHNm9zaVRwcWRHNjI2dDNTNEcxWmJlc2F2UVFuZHBIeWpkeVFr?=
 =?utf-8?B?RkgzMFlWN3k4dVNRYkVHOHFjdC8zRWlrQ3hxWTBZVlRmVkY2VjExSG9PL3Rk?=
 =?utf-8?B?V3RFVWFkOVo0TG5EZTRiM3F5Z3R1QVNtZzBHWTNPTTduaDJ1UmtHZDltbUlS?=
 =?utf-8?B?MWUwclVyby9lQ1FLZFA3TkIwelJzTERsSmcvOElQM1E1Y0IvNGtDbU5IM0s2?=
 =?utf-8?B?MVFHMSs1cDh4Y3hMdGx6VHlkNWdkY2FpUy9GeUZTbEtWTnlzN0ZYMFpkcElt?=
 =?utf-8?B?QlRVRzRCUk45WjVLVHpiVmhnaUxDaElWVzVROHl0cTl6bUVwTkxTajlNL3V3?=
 =?utf-8?B?UUlVRENsdEwrNjYzV0dvcmcxeGlLMDNkYWd4UjRmOTNla1pjV3VSQ0NjY3Jk?=
 =?utf-8?B?TjlaY2ZLeHVBWElLaGRjNXBoQlV1UVBpWnNIamFxQnJPY0dNQ1Jsckp4OEEx?=
 =?utf-8?B?bFY0VWN3T1RsNjBLcHVjcXM0OHlqRVdHSE1nQ3dtazNWbnExY25iTkZNWVNh?=
 =?utf-8?B?RlY2a0tiaER1MUFJNHhkaTAxMFluQkNqcFhBOTJTUlRiYSt3SGxheG9qeTZF?=
 =?utf-8?B?MTJPc3BhZjJrcys0ZHhBSTM3bkJkZWVneDNQMzRpa2g1Q3Vwem1MNFRBWUcy?=
 =?utf-8?B?U0s2YWh1SDA4dU5ScVBiWFpJRUtHVW1iWmo3dWZTdjgxaVZLVkNDcUtNL3Qz?=
 =?utf-8?B?N0ZUdVhhWlRjN3hWcjFxbVJhbjlSZzFYMFJrWHM0ZWpsRHo4aitTdDZ0citw?=
 =?utf-8?B?N1hYeURvSnNxVlF5Wm5uVlFLSmJTNVQ0N3NCbjFSMTZaUm1wVGppeUhMUTh5?=
 =?utf-8?B?c1UvMlVKY2JxeWdLY2VmanE2aG1ldE1idzJoMitrQlVkNVcycE42TW4wbCtv?=
 =?utf-8?B?aG5ZQTJwVXplVHlYVTJDbjVqaitoWnJTREJHTFgxRUwrN2dUL2hNdzV6eGha?=
 =?utf-8?B?bHdTNWtNbkJ2dktBWG8vcDd0YmU3Q0phVlkzVGxBMjBzRXBpMm5JTGVHQTlS?=
 =?utf-8?B?QjRVMHZ6bHBaTE43R2tsOHRLamw5b0NMV3hCNkRRWnlFbjcwVXpPeDJCVjlE?=
 =?utf-8?B?bmRQVjVzYU4zMzkrd1F6UEUzaGdyRktDVDI5Qm1TcFFNOU94c2s3bVh0V2Jn?=
 =?utf-8?B?cHZmWmJWUDFjVFdxTUw3dGIvNEY1WW9zNmNpOW9hQ2hnR3puRkFjK1NxZk9s?=
 =?utf-8?B?Y01WSW9GcXFhTjZlUlhFaWlxOUdlSk1CYndGa2MzVWxFRU9SN3JKVnFXdnFC?=
 =?utf-8?B?T014WXNxT0JrbVh0V05RRTJOVUd5cHdxdWdZTnJrRUEzUDE4NUI0ektDVHZu?=
 =?utf-8?B?bmpJeFJ3VjV2NzFvUHV5Q1NVc1lWekZwL3A0WWtNQkpoRW1oMDJ0N1dRTjdl?=
 =?utf-8?B?MjJzN2FCditlWlk1Rmk5TndYODJGdktHYVE4MFBQdGRIZ0lTVDJVS1BGOExy?=
 =?utf-8?B?OFBvTXE5ck9mMUN4YVZwTTlXSWJDVFJ0UDNVRktJalQwenROdFEwZ2NwODJ6?=
 =?utf-8?B?YXZ4TUpYQUtUb0xMV1Z5WlFad3RqTEJYRG56RVBTV0d0dVBVcEw0SEhvRWhR?=
 =?utf-8?B?Rk85WGpoU3Y2Y01QZWtxYkFSZ2cyN1FvckVPQ3dldHlHYTFVMDBSamRTdWRt?=
 =?utf-8?B?SVZqSXVrUWVtSTJnM2dUK3dURWVyRE8wUzZITFVaWlV0K0NEVWlIU2F6NzNy?=
 =?utf-8?B?dU5TR2hvbE9raW8xb0pMRkNnbWxrQUtySUJkNTVTWFFMbnUxNUVWRzZhZEdN?=
 =?utf-8?B?Qk1FbWpGcVlPZmdVM0tHWTVWL0RFaVdPbTVrVzlaa0dpU21IWStLOTVUempW?=
 =?utf-8?B?ckhyUjBGTC8xdjdRVHZLZHdCNHVmZVYzdU1Uald3aEZhKy9qNnovaXNWN3VP?=
 =?utf-8?B?aER2UHNsNFg3ell3UysvNTVlYXA1SFZuOXRvMzhiOTBZY1N2REN0SzRsTmJi?=
 =?utf-8?B?OVVrUlIxYU1HdkMzRUlpSXNmaVRSaDlEak5PQ0trYTRZaUVFSVpIOFViMjRQ?=
 =?utf-8?Q?EOou7aJOw8uD/OjonoBCrtsbH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59166989-87d0-4da9-2f39-08daccf44c6d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:44:45.4531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UXI0T8L7jJXf8oItcYAdPAYgI4761BEiynIBHObBcq1WEarkDja2Ia9klik3qMevdNyqMsI6STCcvLb48/jew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> On GFX9.4.1, the implicit wait count instruction on s_barrier is
> disabled by default in the driver during normal operation for
> performance requirements.
>
> There is a hardware bug in GFX9.4.1 where if the implicit wait count
> instruction after an s_barrier instruction is disabled, any wave that
> hits an exception may step over the s_barrier when returning from the
> trap handler with the barrier logic having no ability to be
> aware of this, thereby causing other waves to wait at the barrier
> indefinitely resulting in a shader hang.  This bug has been corrected
> for GFX9.4.2 and onward.
>
> Since the debugger subscribes to hardware exceptions, in order to avoid
> this bug, the debugger must enable implicit wait count on s_barrier
> for a debug session and disable it on detach.
>
> In order to change this setting in the in the device global SQ_CONFIG
> register, the GFX pipeline must be idle.  GFX9.4.1 as a compute device
> will either dispatch work through the compute ring buffers used for
> image post processing or through the hardware scheduler by the KFD.
>
> Have the KGD suspend and drain the compute ring buffer, then suspend the
> hardware scheduler and block any future KFD process job requests before
> changing the implicit wait count setting.  Once set, resume all work.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 105 +++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
>   4 files changed, 110 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0e6ddf05c23c..9f2499f52d2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1034,6 +1034,9 @@ struct amdgpu_device {
>   	struct pci_saved_state          *pci_state;
>   	pci_channel_state_t		pci_channel_state;
>   
> +	/* Track auto wait count on s_barrier settings */
> +	bool				barrier_has_auto_waitcnt;
> +
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 4191af5a3f13..13f02a0aa828 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -26,6 +26,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_amdkfd_arcturus.h"
> +#include "amdgpu_reset.h"
>   #include "sdma0/sdma0_4_2_2_offset.h"
>   #include "sdma0/sdma0_4_2_2_sh_mask.h"
>   #include "sdma1/sdma1_4_2_2_offset.h"
> @@ -48,6 +49,8 @@
>   #include "amdgpu_amdkfd_gfx_v9.h"
>   #include "gfxhub_v1_0.h"
>   #include "mmhub_v9_4.h"
> +#include "gc/gc_9_0_offset.h"
> +#include "gc/gc_9_0_sh_mask.h"
>   
>   #define HQD_N_REGS 56
>   #define DUMP_REG(addr) do {				\
> @@ -276,6 +279,104 @@ int kgd_arcturus_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
>   	return 0;
>   }
>   
> +/*
> + * Helper used to suspend/resume gfx pipe for image post process work to set
> + * barrier behaviour.
> + */
> +static int suspend_resume_compute_scheduler(struct amdgpu_device *adev, bool suspend)
> +{
> +	int i, r = 0;
> +
> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
> +
> +		if (!(ring && ring->sched.thread))
> +			continue;
> +
> +		/* stop secheduler and drain ring. */
> +		if (suspend) {
> +			drm_sched_stop(&ring->sched, NULL);
> +			r = amdgpu_fence_wait_empty(ring);
> +			if (r)
> +				goto out;
> +		} else {
> +			drm_sched_start(&ring->sched, false);
> +		}
> +	}
> +
> +out:
> +	/* return on resume or failure to drain rings. */
> +	if (!suspend || r)
> +		return r;
> +
> +	return amdgpu_device_ip_wait_for_idle(adev, GC_HWIP);
> +}
> +
> +static void set_barrier_auto_waitcnt(struct amdgpu_device *adev, bool enable_waitcnt)
> +{
> +	uint32_t data;
> +
> +	WRITE_ONCE(adev->barrier_has_auto_waitcnt, enable_waitcnt);
> +
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return;
> +
> +	amdgpu_amdkfd_suspend(adev, false);
> +
> +	if (suspend_resume_compute_scheduler(adev, true))
> +		goto out;
> +
> +	data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CONFIG));
> +	data = REG_SET_FIELD(data, SQ_CONFIG, DISABLE_BARRIER_WAITCNT,
> +						enable_waitcnt ? 0 : 1);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CONFIG), data);
> +
> +out:
> +	suspend_resume_compute_scheduler(adev, false);
> +
> +	amdgpu_amdkfd_resume(adev, false);
> +
> +	up_read(&adev->reset_domain->sem);
> +}
> +
> +static uint32_t kgd_arcturus_enable_debug_trap(struct amdgpu_device *adev,
> +				bool restore_dbg_registers,
> +				uint32_t vmid)
> +{
> +	mutex_lock(&adev->grbm_idx_mutex);
> +
> +	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> +
> +	set_barrier_auto_waitcnt(adev, true);
> +
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
> +
> +	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
> +
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return 0;
> +}
> +
> +static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
> +					bool keep_trap_enabled,
> +					uint32_t vmid)
> +{
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +
> +	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> +
> +	set_barrier_auto_waitcnt(adev, false);
> +
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
> +
> +	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
> +
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return 0;
> +}
>   const struct kfd2kgd_calls arcturus_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>   	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -294,6 +395,8 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>   				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>   	.set_vm_context_page_table_base =
>   				kgd_gfx_v9_set_vm_context_page_table_base,
> +	.enable_debug_trap = kgd_arcturus_enable_debug_trap,
> +	.disable_debug_trap = kgd_arcturus_disable_debug_trap,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
> -	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
> +	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index a0e5ad342f13..8ed1b5d255f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2424,8 +2424,8 @@ static void gfx_v9_0_init_sq_config(struct amdgpu_device *adev)
>   	switch (adev->ip_versions[GC_HWIP][0]) {
>   	case IP_VERSION(9, 4, 1):
>   		tmp = RREG32_SOC15(GC, 0, mmSQ_CONFIG);
> -		tmp = REG_SET_FIELD(tmp, SQ_CONFIG,
> -					DISABLE_BARRIER_WAITCNT, 1);
> +		tmp = REG_SET_FIELD(tmp, SQ_CONFIG, DISABLE_BARRIER_WAITCNT,
> +				READ_ONCE(adev->barrier_has_auto_waitcnt) ? 0 : 1);
>   		WREG32_SOC15(GC, 0, mmSQ_CONFIG, tmp);
>   		break;
>   	default:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 56ad38fcd26e..efb81ccef8f5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1946,7 +1946,7 @@ void kfd_suspend_all_processes(void)
>   	WARN(debug_evictions, "Evicting all processes");
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>   		cancel_delayed_work_sync(&p->eviction_work);
> -		cancel_delayed_work_sync(&p->restore_work);
> +		flush_delayed_work(&p->restore_work);

This looks like a sneak bug fix. Should this be a separate patch 
independent of this path series?

Regards,
   Felix


>   
>   		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
>   			pr_err("Failed to suspend process 0x%x\n", p->pasid);
