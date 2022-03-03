Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A07C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 20:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923B610F00E;
	Thu,  3 Mar 2022 20:31:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18EA10F00E
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 20:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk2Gz49t590XWoU98H/Z+8ZzG788PAEmELeAhOqUHQJnIP+6t436H6YVmHh5HG1cn+WmA/gPR/Nl81VGTZ0TLCBWm4IzJv6wBR1hKgmYo2OdYlnTPyX2BXNHFwQSv589c530d6U9DAvZiFvUFEaLNm0URo7NZCbHOwZQBHuL2CXyn4027r4oBFVWlBU9GhCElp1hkIeye10eQe0lClPLDT3Iv8OmivLEc0YIwAQNn+oMmxEvWlgbrPQknh7Udx5zckCdUYxgXSO/PSYR7jnlmZiqq0moDnX0E9J8G/NdzVpB10qkr/Dt1iFwMM1hBGXuFPwnS8J1Ya3mMNgwvhCMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0Xe4sQVqAPioW7QdQCcV6K3+ag1Jb7Ryvo5XCGkg5E=;
 b=g1orcsOHqJoSMrKah2C8ukIQhr9vm+GhkpeXqyRn338cwsUysMe3ZOHxFDBUNRPnGEo9eCi0qJ02d5vPPvz7KR9IjDDmlZMU5F4FM18HXg9uDUWga8ua2xcGxo90HjEQySoio59WJutChsKis2MBxHolta4eUI1udRBk4P6qiMCb3LllsVST3oCRuuYWwKdMEG0S31vrzGWm9mvBo0BIZHCfvw8k5dmjHLEY7ECwDInZc3f/67EPXLlOBjAhGIyBN+nQ5HADE0aUehzmbX6mAzS7Y5LD6zmRQjRbLHYlIqg4mCNhAOdZ/PEMF28J/mBG3FwRzpM4Je0jkZFlFsM/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0Xe4sQVqAPioW7QdQCcV6K3+ag1Jb7Ryvo5XCGkg5E=;
 b=Difm8eIdZs9ixyfdwvY4jhFmU9RkVqub/hvweeIavALWMJvJwPsErw++cG/MrARzn53ELbQYmilv81HGzw9j6e86aUGOu/vvb7TvOVPNylDG0BNsz3KxGHNg5Bo78XP40z/ekDTlcFpli8DBSZUABXhc+ml0ElzzBH82ARRf8ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 3 Mar
 2022 20:31:16 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 20:31:16 +0000
Message-ID: <38df51e1-4bb7-a693-a9b8-9d6f58e3b21d@amd.com>
Date: Thu, 3 Mar 2022 15:31:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 08/10] drm/amdgpu: initialize the vmid_wait with the stub
 fence
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-9-christian.koenig@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220303082308.38217-9-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::29) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7149eed8-9a9b-4f27-62c7-08d9fd54c458
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1909A7B3AE3B01A37FC352F7EA049@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xryOhB2ZjIbymxbzCEUXb2RtccydsXd7fGPtmZbq96FVGJUiFb8Srx62bFK6mVDcDio2PM3MLk9ZzWXyhAq7I4MRfVOEWhqQh5/rQ7xmCrjsPoagvbzURPniFuEALcDTb0BHAn0xZMCZiWwL/TOufZd2exphz59Pu3o0aXvva3d9u+mDVhlxU/inNIv3tEV6zr3nzGICzfFNiLBsjQOi8jBNyTwYnc+Ctzg23oKg7etnTdtdgNuEk6omvxlUEAmTNixhOp4sT668RIoNB43bOLV0N20r5/r/YGYsxbdvjozPic34s2cE/PKw5cVcI+B4Vd/udiTbgxH05xhiKifBmuRO7FD2qWWO9qOvVc0PwRMerwn57HbbtPgGtbWVQQT611Q3Qaw3E9TZw4GOYo4N0y4wZS6/JIAKoJR1zM3PHRcoPdrl1eHpPVAXld/g8RgbE/yhJSC23/3FVlI/ZdH/WI9WilvtKbYcXi9iHvNrSrkwxNJZajOsZfEmNqxJsukAEv5fdVj9oMY6lxpy+G9ZMNBB0upS+6kQ90e+y/CHzzvXtm7T7XwTd7hbV7asYersWffdb0QJiXh0De26eYxphN7TApUpBYHTIXs8V3Mj8m8gta2JmJwTNUmitIGmBDM1kzBylTDYLrUnUI1nznDxbI3rKqzq61p1wNgwjb5C++fHZ/csx98Xgm7HhqjwC/b95cB1jfhjmfqPCrL1+hLAy5SoDF2R8fvWUx6hj+DZP6kyFQIkisL3doCrmQa5U8nu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(6486002)(4326008)(31686004)(8676002)(2906002)(508600001)(66556008)(66946007)(6512007)(8936002)(36756003)(66574015)(2616005)(53546011)(316002)(6636002)(44832011)(6506007)(5660300002)(186003)(38100700002)(83380400001)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZQeDk5NVVRKzRaMHhvZkJNUFFvRWpKN3l4dGV2Q0s0cFJQS0hNYzZFaVVI?=
 =?utf-8?B?YitNNHFUQW56T2RPaElucUM2WWc5R1N6K1U5RERMRzlLb0M1emIrZnV6RG53?=
 =?utf-8?B?Vm9FalpqTVlFeFJORzYxYzN2MUloVld4VE4yS21XVFVrYTFLcGNzNWM0MzB5?=
 =?utf-8?B?c2ExMDRnRlFlOFhOWnZFb1g3SEpHOEwrSHR6eWl3cGc2RE52NGoyaUVQdHM0?=
 =?utf-8?B?VVJ6bWdsMTR1REIxRG5wckxMMWRtc2xteDBoMXIraHdrQXJWMUNlbHR0VUtC?=
 =?utf-8?B?aDFKR1gveG1ucitzRmtKUUsxVGhsK0pvZC8rRHFHYnc1M0tTaGhpeERWYzYx?=
 =?utf-8?B?aTRHUjVZUjZIN2pUNWpVOXBCYUdKR1pEMUtlT0FKaVNKTGNJUnI1YTF0Yi9O?=
 =?utf-8?B?aHFNVkxGWnNhMGNwNmZxQWQ4WE1EdE1kMUNDMDQxZVV0UGtOaDlVdFBuQkMv?=
 =?utf-8?B?SXNtRi84aURIZVFzeW1DSGpSZzBHZDdtOHcwYzA0Si9BZjYwSzJRWE1TK0dk?=
 =?utf-8?B?K2prY3V6UEJiWnVTemg2bTdhRWIzOVBkd3dTV1plRUYveVNkZDBCNHUrTUNL?=
 =?utf-8?B?eWQ4ZXZYdnRjOWRHdm9yUWVUVldpcnJmcWw4c2FpRVhmKzRHcThVMVV5UFhZ?=
 =?utf-8?B?SXI1aGViODBYMm5kRDEvVEF5S2RITFQ4K1laU1VxcjFFcXVrSTFjYnlTOXZX?=
 =?utf-8?B?TnErUEZRZFVJSVVHN05sQ1JscnlmUHBjVnFaNkRIMTY4c1ZIcHFEVjh1anE4?=
 =?utf-8?B?WTI1NWlSMThXK091Y0ZkNUVMWkR6TzRpNVM5ckhvWDhDdm1QYk8zM2RDUlRE?=
 =?utf-8?B?WGhLOUpRQTJuS2diOE1mOTQyTU1BQ3lKS1Fld00zN0RQRHYxbUtYalZNYnAr?=
 =?utf-8?B?SzlKVFh5Nm0rb2RaaEtTdGwrYWNTYTZRR1AySWNubm1VSVhlZ1J5eDMwUlk1?=
 =?utf-8?B?Tm9EMDhWL1dPMXp6RE5GRVp0RkJRQXJvQjN0MzhkTWNJa1hKUUNDQ2RGU0tp?=
 =?utf-8?B?VDVpamdyUS9TZ01zWEFzbFFZK0J5dFN1eVd5UTdsSVRKa255dTFRcjF0aHZ2?=
 =?utf-8?B?Kzl0dWNIUWs0QjJZOVBuUlIvRTdHZk9wUVJING9RK0g2Q1U5MlBXejBjcW45?=
 =?utf-8?B?M3JaMUZ4RHlQWjFPeU5NekJ4dzR4Z1NQaHlLVldSYTlOK3VmdWVxNGZkbVZu?=
 =?utf-8?B?Vi9FUXJrdUE4STByRXNoUEhVZ0VablhHV0FvVEtmVi9wWWNyOHhIYmVjOHIw?=
 =?utf-8?B?dGwvVlg1djE3TFFMZ0pMK3J6S24zNjBCbUJFUjAyemRQL09KMC9xVGgxblJw?=
 =?utf-8?B?QTE3WHhUNDVTeXVjZWhxZ1hCcDZrNlBWU3orNUJKL2RuWTIzSXlVTFZLSncr?=
 =?utf-8?B?ZkJxZTJ1ekZaUUp2cnh2RHZUNVFHV0dTZTJtOFo4Q0ZrUE15M1RQekh4T3VC?=
 =?utf-8?B?Y1ptN3Roc2xYOEpqWTd3NklmT3YzdGMzZTNUZ1VDZXZDVXliVzMySlVCbUhK?=
 =?utf-8?B?dDN4U2RjTzh0NDdDM05KOVNmSFZTcW5DWmFZci9SV2lWNTlqQmNPbWhjYTdF?=
 =?utf-8?B?djN2a3g3ZVdRSzJFc0paNmJXbkI2TW5IemlvUEZnM3BVUzNNZ2JuOXZtdjNu?=
 =?utf-8?B?YmQ0Y0ZTTWNwR0IyOENzQzdlVlF1RU5UYnFoR3dIZ2RrblpBYWY3NjlzZGJE?=
 =?utf-8?B?ZVFVSlZBRXRYVExWSUsvN011Nzd0VUhQZjJhR3ZNeDZLVG9QSHpJSVprUFdG?=
 =?utf-8?B?T1BKeWgyWHdlTkR0c09XSUk5S2Zvc09GVU5Jb2hCR1h3cEJ0Yzc5R2drVUpI?=
 =?utf-8?B?SFpZTWdmbE5YaFp5ajRVMzJxN1QwSWdxQkxOVURQU0JMR0ZJRm9UNjlsTEcv?=
 =?utf-8?B?UkthRzZtMUI2dGIrRWdyQ2xpcE53VmlRTU5maXhabHZEZFI1S3c3Z0Y5S3JE?=
 =?utf-8?B?QUVMMUpENjlSOUp6ZC9BWHVWVHVrazF2VCtoMEhZcHFMamU2LzF1ZFBkWG54?=
 =?utf-8?B?bi8wdDh2UFBkczNoL2FacmJaUDh5OFZsM0ROd1Q3SmNDaTdVQStuNjE0NjRp?=
 =?utf-8?B?VlI4NnkxazFhSURmWitHMmVqL1R1NHZ4NGNvVEdLZFM1TjVQY1ZzZ2FjbG1E?=
 =?utf-8?B?TDZ0YTJTWlBFS1k4b0VuS0FqOGhvSC9FVndzY0dDS1NyRjlGd1RhQmZ4b0V6?=
 =?utf-8?B?elB5YmhMRDBCd2JpTSs2Z2JkMWpNcUhqcHJyUlczVUpvMTJocjA3Vkw0b3Ur?=
 =?utf-8?Q?XDyyustKP3ylCiXtOCHfQB+pkKP2a6qH2jEp7mCVhI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7149eed8-9a9b-4f27-62c7-08d9fd54c458
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 20:31:16.4873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecFocbViDr8D2wLQ+w/tme3zpmyss8iT6eFX3EiESqBYFY2sRpWiXYICYPCIqYqZQMw73y1CPocN4P6g87Pimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-03-03 03:23, Christian König wrote:
> This way we don't need to check for NULL any more.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index ddf46802b1ff..4ba4b54092f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -188,7 +188,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
>   	unsigned i;
>   	int r;
>   
> -	if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
> +	if (!dma_fence_is_signaled(ring->vmid_wait))
>   		return amdgpu_sync_fence(sync, ring->vmid_wait);
>   
>   	fences = kmalloc_array(id_mgr->num_ids, sizeof(void *), GFP_KERNEL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 35bcb6dc1816..7f33ae87cb41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -193,6 +193,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   		adev->rings[ring->idx] = ring;
>   		ring->num_hw_submission = sched_hw_submission;
>   		ring->sched_score = sched_score;
> +		ring->vmid_wait = dma_fence_get_stub();
>   		r = amdgpu_fence_driver_init_ring(ring);
>   		if (r)
>   			return r;
