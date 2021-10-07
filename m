Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD0CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 12:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4741760F90
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 12:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4741760F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1B5D6F45C;
	Thu,  7 Oct 2021 12:18:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0FE96F45A
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 12:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq+aWwqKHmjGQpxSPXhjP2VMSNB1IZ/aVuvwanlgrnhXEdCvcg5xNDVCHQ2vIYaMPLH72HJx7/TqV8VdDhBE/XgLUvH0xWDwf9j9AgEX4qH5Ma58+rgiAfR+xEeBSLi99j5Zd5FEKaTqlWGaPJ/XtlTJe0zbp2EZmj5OkxEfygOLBHTvgadX9pw9s5k3rGh+JxPY4hauFyQH0kJVZmTFif4WXGrviJ1OBHTgErF3JSxK+0KdOXab17yslH7KE5nPDubI07o8s4OXPRS+p26i6adHz3obhPNiLjOfq8+3KlaEFnqT7DjNDktOVuNqQXg7WV9UF9ys069YfAsxjwbvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfF1TCfDTaSzL8bGKeVpeKCAUS3GYcWronkS7R7nTbk=;
 b=Y0iIxoVbFeYvX7B4CB9e+reB887mSrGyvcaL55xNZspFhNwRHX0mRdtP9QMA4dODxcsRH/tdxCDdhUseCwjNJLGaRiiBlDw2adalxmJ2RWgLR5YyzNleX1vRSl9W2HDAiN3ljWcM71Kn6N2m7mywKw8oKHsssfPEH3a2AvgykTeAXIKybP6r+vC1QAlXqXWT+t9QMXgk5NV/UJ1YHV2Fu/yb853MTw8oqRdq+pwZ++Cl0CQqCIWPwYyRlw9bXvIvDq/UEJhMHWiJPn2NhSGj1aRd1rKwnFznLst8Bovxu+PA3X8U+pdIM3SefY8D0O6ZA9PLVxj6kU3+ITEUZbj7Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfF1TCfDTaSzL8bGKeVpeKCAUS3GYcWronkS7R7nTbk=;
 b=Fojier8nkE4OfJ+XDL+Zh86CBQUa2PJaB/QcFb6WZJTR5dweCk2E9pqGA6xWscS3LIZ4VhdZtBWNcZIun77STA+dFFdwrzw73YDx6I0oFOflI5QHPdwmAuonY7fNXq6CSgocT7QvAx5AwuNRwJafOHQ/TpRMUqvNw5TU/T4RrrM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW3PR12MB4443.namprd12.prod.outlook.com
 (2603:10b6:303:2d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 7 Oct
 2021 12:17:55 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:17:55 +0000
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm for consistency when
 accessing drm_device
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 xinhui.pan@amd.com, alexander.deucher@amd.com, andrey.grodzovsky@amd.com
References: <20211007114001.12123-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <33611ccd-a33d-c076-6a06-2edbc4c719f6@amd.com>
Date: Thu, 7 Oct 2021 14:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211007114001.12123-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0148.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::15) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR02CA0148.eurprd02.prod.outlook.com (2603:10a6:20b:28d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Thu, 7 Oct 2021 12:17:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbaca6b5-6df5-4c64-f062-08d9898c7da2
X-MS-TrafficTypeDiagnostic: MW3PR12MB4443:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB444384A5CFED6084173B1A0383B19@MW3PR12MB4443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GnScokKeGlSZY8Rgb5zMDdMxj33HQmlN3AYrH7G9fbaexuRSonvcR2fv2v1y8jL0I294I0r9kV+PpoHXvYw8Ic7ye6Tnyf0an/0xP0k7Oj4h0nkqnHpke9wkgkBHua3kOx6/hWi4j00CPEmSNDHt/mpRZHmNhhdIXUGu2sG43i2xQra2Ar6HZQ+Z58+3mucHVbE29HxwzvV0DmupI3OJZJFUuzwz3cTnvZGWPucqQbsvu921rhqXLGhkWnkN5Alx6gGJ3PxTei8DX1ZkdG55GJROjgZrhK3Zh9M7wg5WFsCUJIVZzfDcfCa+ugNUxkj3q4GjJ1zXuVkY8u5QRsdB6SxFA+6KDTSyg9/s3IA/43FZV4HoVS6omeTRcug9o5aWEIpOr4AoVkoFpfAPPVKeNHrhjJtqj5RfHoZpu1U6LaF4nQvJ4xEgpfYvQKjutx6M8vgOuQnn+yXhnX6BJnGSQgmq8hcdXB2PXZN0wmnTsFm3v6rYzvRVQAlNfj1RsI5GPl84l5HiMoPYuidndBdx4iugoHR4Xd78vG9iaqbSl/CnaV5eCGMonwfF9D1eu89tM+Zjzf+tfRxxhxBqnoJAofuruNiS0n/8o5o0CRPZLkNQ9WDbq4WpU+txUPwH0VexrHuSKz9K62RxvAOrhMV2vWh00MMCtGYRSH+TrsHESGLBdm0qHGbVmGUvytfel5e8fPrDfcOfrBZZBdZlMInV3mVYecdLGDCIo0C+uvVVGmKI0ANXfMSaPcv3FdlnIjJl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(31686004)(2616005)(508600001)(5660300002)(38100700002)(66946007)(66556008)(66476007)(30864003)(36756003)(31696002)(316002)(6486002)(86362001)(6666004)(16576012)(186003)(26005)(66574015)(2906002)(6636002)(8676002)(83380400001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNoZ1I5cUNXN0RxcnA4emF2bVQzMU1uTm11akdzSko4TGR1ZzdqYVBySDNX?=
 =?utf-8?B?L1Nhb2FHMzF5OW1JWGUycmx5eDRHMVRvTXVRV2R5S2w5NVZnaSt4b1F6RHJP?=
 =?utf-8?B?SHhGSTZOeWkwU3M1Z1o0UFNoOTFMUEs4ZzV0d1UxYS96VHU4eVQvN2VFYXFJ?=
 =?utf-8?B?VHRxakJzMExLWmpINm5qcDB3Z08zQ1lrOWxkMDZpNDhndVV0VXg1eXJzem82?=
 =?utf-8?B?NTE0TWdoVGVud0V2QzVRbXlhS3ArMGF2NFIrZjRjMHRVTWdTQ2F4NVh5bTk2?=
 =?utf-8?B?SXgzcTh1N0YvU1hFWWlUR3MvVitVR3lFUm80M21XQnQwTmFORE9wc1J2RUNE?=
 =?utf-8?B?aHdycnFKUzhXOE1BT0t3aXYrWXFTVFNZWmNvVy81aGdLd284Q3g3RUF2VUty?=
 =?utf-8?B?eDNobFVXUW9iNXE3bXphZXNuK1p3YjNpZ0lyY29yZWtmcjVzYUorMWoxSmFk?=
 =?utf-8?B?ZEJTcktjbVd2bjJLRFlVa1E1Si8wVFRXWmhKalU0L1FWM2lsS3Y3UWN0Q3Q4?=
 =?utf-8?B?dXVlQ2xoTk8zOXF2RTU2NkdubXk4TWl1SHViczJFQUpMeG9CamRTUzRTNFNa?=
 =?utf-8?B?dFNqc0RXQjhVWVFwdmgxOU11MDBIUUxsSXZyM2Vhb3ErOEplYXhVOXdMNTJn?=
 =?utf-8?B?Y3BCSytZYXVjQndZcDdIWnhQSWV6Y2pXLzg5eXNTOTdEZTJKVWRtcDdFSTJq?=
 =?utf-8?B?Yk0wWXptZXdzR2JsdThCQXY0eU04OWNCR2NhUEdoY085dVp4dHpSMzdYcGM1?=
 =?utf-8?B?MG9QVCtrcCtLTGs3TVUxZ256MTNvQ1dDVlFYY2FaSzJwUDRkRlQ1bjhjNjFo?=
 =?utf-8?B?SG5odUN1RE9GMWlyTnhjbzl5TkloQXZuWGlaMTYzWllRTVBNeWNHS203a2Zo?=
 =?utf-8?B?T3VkcXBzdFJLakkra1M1M2VjNWh4OG5jUVpwWTZ3T3k1cnhiWVlnTnJsVmwr?=
 =?utf-8?B?OGhRSnhZemZlaTBhWkxwVEE1N2FlNHRyQVA4M1VjbUkwYUdiT0ZoK2sxNW9k?=
 =?utf-8?B?dmRkbVpKUm9aaHJMWWdwMFFWVEpXZFhqeVUwQkhxNTlYVnIvY1NqQlRqNENr?=
 =?utf-8?B?U3NMZG91c1FCQ201Slo0Z0RMMVFTaWo5WVJKMXAxWlVBVldFR0FrcVFENHE2?=
 =?utf-8?B?ak9OREJVWERDaDZDZTZHakZHVXlDaTRYcVJRTHZXOGFtMFFscHdBQStwZEVq?=
 =?utf-8?B?V0FLTjNZUmZLcVZjU1ZrZEo0amRYYS80MXV0dEgvTHJkSnZGT25vVDhzbjNG?=
 =?utf-8?B?aWs0WWt4VFNLT2hxRUlJZ3owbitrLzRLSU1OYkpnL05qM041RzhvdDBxUU56?=
 =?utf-8?B?NjRtYWgzS1VCZkVTVkJWUU5rMXZnbVhDT0ZpbllLMy8rWW1hbHluU2NMZFRa?=
 =?utf-8?B?bGtBNkZ0ajVITUhyNEFiMlB3MnUzZ0lXQy92Q0EwUDYzMlJyR09ZckJnVlh6?=
 =?utf-8?B?ZGVpK0h3cmJCdm90YkcxekhVczBjeHE2T1V4Y3owbkpvR0ErcTgwZmttaGEw?=
 =?utf-8?B?T1kxbUhSeEZPd2tSd0tWVXFZdGpoV3huOGc5YTRoa09IblRSZC9yeVZwSTdC?=
 =?utf-8?B?ajJLdU4rWFJXUmYxayswQTJxUUlSNmk4Y2NYemVabE5Jd2szYndjRDl1YVdr?=
 =?utf-8?B?WVZ5WkJ6MHhHS3M2aktOL2dzL0JWUGRrc1h0bW1FaDhGNURkTHpZM2ZwTDBT?=
 =?utf-8?B?Uld0Y24rdTFIU2J0K0tvOVQ5UGlIeEp0K1h1M1RQN0ljZEd3QkV2eGhualNp?=
 =?utf-8?Q?YLnIzn0mCxUwrTv4ps45/Lq098UF2WB3SvS7BH8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbaca6b5-6df5-4c64-f062-08d9898c7da2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:17:55.1670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWVE8DQDwMpL0zsRyBhrGFx0qIbt2MCHURx43gkmZRgktHVTm9D05RRmIIiAfNWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
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

Am 07.10.21 um 13:40 schrieb Guchun Chen:
> adev_to_drm is used everywhere, so improve recent changes
> when accessing drm_device pointer from amdgpu_device.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      | 2 +-
>   16 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 57638fe9cfc2..37f6c3a43541 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -306,7 +306,7 @@ void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
>   	uint64_t last;
>   	int idx;
>   
> -	if (!drm_dev_enter(&adev->ddev, &idx))
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return;
>   
>   	BUG_ON(!IS_ALIGNED(pos, 4) || !IS_ALIGNED(size, 4));
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index fd4ba076ff8a..1320f84c63cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -556,7 +556,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>   			drm_sched_stop(&ring->sched, NULL);
>   
>   		/* You can't wait for HW to signal if it's gone */
> -		if (!drm_dev_is_unplugged(&adev->ddev))
> +		if (!drm_dev_is_unplugged(adev_to_drm(adev)))
>   			r = amdgpu_fence_wait_empty(ring);
>   		else
>   			r = -ENODEV;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index d7e4f4660acf..d3e4203f6217 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -238,7 +238,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   		return -EINVAL;
>   	}
>   
> -	if (!drm_dev_enter(&adev->ddev, &idx))
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return 0;
>   
>   	t = offset / AMDGPU_GPU_PAGE_SIZE;
> @@ -289,7 +289,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   		return -EINVAL;
>   	}
>   
> -	if (!drm_dev_enter(&adev->ddev, &idx))
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return 0;
>   
>   	t = offset / AMDGPU_GPU_PAGE_SIZE;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 8d2716297070..45761d0328c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -748,7 +748,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>   	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>   	int idx;
>   
> -	if (!drm_dev_enter(&adev->ddev, &idx))
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return;
>   
>   	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index e1aa4a5e6a98..054d6210be7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -368,7 +368,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>   void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>   {
>   	if (adev->irq.installed) {
> -		drm_irq_uninstall(&adev->ddev);
> +		drm_irq_uninstall(adev_to_drm(adev));
>   		adev->irq.installed = false;
>   		if (adev->irq.msi_enabled)
>   			pci_free_irq_vectors(adev->pdev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index de29518673dd..f222ec17a523 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -38,7 +38,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	struct amdgpu_device *adev = ring->adev;
>   	int idx;
>   
> -	if (!drm_dev_enter(&adev->ddev, &idx)) {
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
>   			 __func__, s_job->sched->name);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index fd6e38ad493c..6b39e6c02dd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -440,7 +440,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   	if (psp->adev->no_hw_access)
>   		return 0;
>   
> -	if (!drm_dev_enter(&psp->adev->ddev, &idx))
> +	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
>   		return 0;
>   
>   	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
> @@ -3272,7 +3272,7 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
>   {
>   	int idx;
>   
> -	if (!drm_dev_enter(&psp->adev->ddev, &idx))
> +	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
>   		return;
>   
>   	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 8a26459bd80b..6f8de11a17f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -454,7 +454,7 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
>   		if (!adev->uvd.inst[j].saved_bo)
>   			return -ENOMEM;
>   
> -		if (drm_dev_enter(&adev->ddev, &idx)) {
> +		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   			/* re-write 0 since err_event_athub will corrupt VCPU buffer */
>   			if (in_ras_intr)
>   				memset(adev->uvd.inst[j].saved_bo, 0, size);
> @@ -487,7 +487,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>   		ptr = adev->uvd.inst[i].cpu_addr;
>   
>   		if (adev->uvd.inst[i].saved_bo != NULL) {
> -			if (drm_dev_enter(&adev->ddev, &idx)) {
> +			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   				memcpy_toio(ptr, adev->uvd.inst[i].saved_bo, size);
>   				drm_dev_exit(idx);
>   			}
> @@ -500,7 +500,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>   			hdr = (const struct common_firmware_header *)adev->uvd.fw->data;
>   			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>   				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> -				if (drm_dev_enter(&adev->ddev, &idx)) {
> +				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   					memcpy_toio(adev->uvd.inst[i].cpu_addr, adev->uvd.fw->data + offset,
>   						    le32_to_cpu(hdr->ucode_size_bytes));
>   					drm_dev_exit(idx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index caa4d3420e00..688bef1649b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -313,7 +313,7 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
>   	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
>   	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
>   
> -	if (drm_dev_enter(&adev->ddev, &idx)) {
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
>   			    adev->vce.fw->size - offset);
>   		drm_dev_exit(idx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 4d3f2386ef53..c7d316850570 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -325,7 +325,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>   		if (!adev->vcn.inst[i].saved_bo)
>   			return -ENOMEM;
>   
> -		if (drm_dev_enter(&adev->ddev, &idx)) {
> +		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   			memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
>   			drm_dev_exit(idx);
>   		}
> @@ -349,7 +349,7 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>   		ptr = adev->vcn.inst[i].cpu_addr;
>   
>   		if (adev->vcn.inst[i].saved_bo != NULL) {
> -			if (drm_dev_enter(&adev->ddev, &idx)) {
> +			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   				memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
>   				drm_dev_exit(idx);
>   			}
> @@ -362,7 +362,7 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>   			hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
>   			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>   				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> -				if (drm_dev_enter(&adev->ddev, &idx)) {
> +				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   					memcpy_toio(adev->vcn.inst[i].cpu_addr, adev->vcn.fw->data + offset,
>   						    le32_to_cpu(hdr->ucode_size_bytes));
>   					drm_dev_exit(idx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a1ddf74bbdba..0e7dc23f78e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -845,7 +845,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   			return r;
>   	}
>   
> -	if (!drm_dev_enter(&adev->ddev, &idx))
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
>   	r = vm->update_funcs->map_table(vmbo);
> @@ -1395,7 +1395,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (list_empty(&vm->relocated))
>   		return 0;
>   
> -	if (!drm_dev_enter(&adev->ddev, &idx))
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
>   	memset(&params, 0, sizeof(params));
> @@ -1718,7 +1718,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	enum amdgpu_sync_mode sync_mode;
>   	int r, idx;
>   
> -	if (!drm_dev_enter(&adev->ddev, &idx))
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
>   	memset(&params, 0, sizeof(params));
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index aaf200ec982b..21a325ea49cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -698,7 +698,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   			return -ENOMEM;
>   		}
>   
> -		if (drm_dev_enter(&adev->ddev, &idx)) {
> +		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
>   			ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
>   			if (ret) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 226b79254db8..d1fc4e0b8265 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -565,7 +565,7 @@ static int vce_v4_0_suspend(void *handle)
>   	if (adev->vce.vcpu_bo == NULL)
>   		return 0;
>   
> -	if (drm_dev_enter(&adev->ddev, &idx)) {
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
>   			void *ptr = adev->vce.cpu_addr;
> @@ -615,7 +615,7 @@ static int vce_v4_0_resume(void *handle)
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   
> -		if (drm_dev_enter(&adev->ddev, &idx)) {
> +		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
>   			void *ptr = adev->vce.cpu_addr;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 43f46ab07dda..091d8c0f6801 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -198,7 +198,7 @@ static int vcn_v2_0_sw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
>   
> -	if (drm_dev_enter(&adev->ddev, &idx)) {
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		fw_shared->present_flag_0 = 0;
>   		drm_dev_exit(idx);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index f4a7a30ecebd..59f469bab005 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -240,7 +240,7 @@ static int vcn_v2_5_sw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	volatile struct amdgpu_fw_shared *fw_shared;
>   
> -	if (drm_dev_enter(&adev->ddev, &idx)) {
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>   			if (adev->vcn.harvest_config & (1 << i))
>   				continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 135a9c553af8..dbfd92984655 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -263,7 +263,7 @@ static int vcn_v3_0_sw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int i, r, idx;
>   
> -	if (drm_dev_enter(&adev->ddev, &idx)) {
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>   			volatile struct amdgpu_fw_shared *fw_shared;
>   

